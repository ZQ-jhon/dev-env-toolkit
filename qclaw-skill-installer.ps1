# qclaw-skill-installer.ps1
# Install QClaw/OpenClaw skills from skills-manifest.json

param(
    [switch]$DryRun,
    [switch]$SkillsOnly,
    [string]$ManifestPath = "$PSScriptRoot\skills-manifest.json"
)

$ErrorActionPreference = "Stop"

function Write-Step($msg) { Write-Host "`n>>> $msg" -ForegroundColor Cyan }
function Write-Ok($msg)   { Write-Host "    OK: $msg" -ForegroundColor Green }
function Write-Warn($msg) { Write-Host "    WARN: $msg" -ForegroundColor Yellow }
function Write-Err($msg)  { Write-Host "    ERR: $msg" -ForegroundColor Red }

# --- Check openclaw CLI ---
Write-Step "Checking OpenClaw CLI..."
$openclawCmd = Get-Command openclaw -ErrorAction SilentlyContinue
if (-not $openclawCmd) {
    Write-Err "openclaw CLI not found in PATH. Please install OpenClaw first."
    Write-Host "  Download: https://openclaw.ai" -ForegroundColor Yellow
    exit 1
}
Write-Ok "openclaw CLI found: $($openclawCmd.Source)"

# --- Load manifest ---
Write-Step "Loading skills manifest..."
if (-not (Test-Path $ManifestPath)) {
    Write-Err "Manifest not found: $ManifestPath"
    exit 1
}
$manifest = Get-Content $ManifestPath -Encoding UTF8 | ConvertFrom-Json
Write-Ok "Loaded manifest (generated: $($manifest.generated_at))"

# --- Install system skills via skillhub ---
Write-Step "Installing system skills (skillhub)..."
$systemSkills = $manifest.skills.system_skills.items
$total = $systemSkills.Count
$installed = 0
$skipped  = 0

foreach ($skill in $systemSkills) {
    $name = $skill.name
    Write-Host "  [$installed/$total] $name (v$($skill.version))..." -NoNewline

    if ($DryRun) {
        Write-Host " [DRY RUN]" -ForegroundColor Magenta
        $skipped++
        continue
    }

    # Try skillhub install
    $result = & openclaw skillhub install $name 2>&1
    if ($LASTEXITCODE -eq 0) {
        Write-Host " OK" -ForegroundColor Green
        $installed++
    } else {
        $errMsg = $result -join " "
        if ($errMsg -match "already installed|already exists|已安装") {
            Write-Host " already installed" -ForegroundColor Gray
            $skipped++
        } else {
            Write-Host " FAILED: $errMsg" -ForegroundColor Red
        }
    }
}

Write-Host "`n--- System Skills Summary ---" -ForegroundColor Cyan
Write-Host "  Installed : $installed"
Write-Host "  Skipped  : $skipped"
Write-Host "  Total    : $total"

# --- Note about local skills ---
Write-Step "Local / custom skills (manual step required)..."
$localSkills = $manifest.skills.local_skills.items
foreach ($skill in $localSkills) {
    Write-Warn "  [LOCAL] $($skill.name) — located at: $($skill.location)"
    if ($skill.note) { Write-Host "          Note: $($skill.note)" -ForegroundColor Gray }
}
Write-Host "`n  -> These skills must be manually copied or recreated." -ForegroundColor Yellow

# --- Python packages ---
if (-not $SkillsOnly) {
    Write-Step "Installing Python packages (pip)..."
    if (Get-Command pip -ErrorAction SilentlyContinue) {
        Write-Host "  Running: pip install -r requirements.txt"
        if (-not $DryRun) {
            pip install -r "$PSScriptRoot\requirements.txt" 2>&1 | Out-Null
            Write-Ok "Python packages installed"
        } else {
            Write-Host "  [DRY RUN] would run pip install" -ForegroundColor Magenta
        }
    } else {
        Write-Warn "pip not found, skipping Python packages"
    }

    # --- npm global packages ---
    Write-Step "Installing npm global packages..."
    if (Get-Command npm -ErrorAction SilentlyContinue) {
        $npmPackages = Get-Content "$PSScriptRoot\npm-global.txt" | Where-Object { $_.Trim() -ne '' -and $_ -notmatch '^#' }
        foreach ($pkg in $npmPackages) {
            Write-Host "  Installing: $pkg" -NoNewline
            if (-not $DryRun) {
                $out = npm install -g $pkg 2>&1
                if ($LASTEXITCODE -eq 0) { Write-Host " OK" -ForegroundColor Green }
                else { Write-Host " FAILED" -ForegroundColor Red; Write-Host "    $out" }
            } else {
                Write-Host " [DRY RUN]" -ForegroundColor Magenta
            }
        }
    } else {
        Write-Warn "npm not found, skipping Node packages"
    }
}

Write-Host "`n====== Installation Complete ======" -ForegroundColor Green
Write-Host "Next steps:" -ForegroundColor Yellow
Write-Host "  1. Copy .env.template to .env and fill in your API keys"
Write-Host "  2. Copy openclaw-config-template.json to ~/.qclaw/openclaw.json"
Write-Host "  3. Run: openclaw gateway restart"
