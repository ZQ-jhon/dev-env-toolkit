# install.ps1 — Windows all-in-one dev environment installer
# Usage:  .\install.ps1                # full install
#          .\install.ps1 -SkipPython    # skip Python packages
#          .\install.ps1 -SkipNode      # skip Node.js packages
#          .\install.ps1 -DryRun        # preview only, no changes

param(
    [switch]$DryRun,
    [switch]$SkipPython,
    [switch]$SkipNode,
    [switch]$SkipSkills,
    [switch]$ToolsOnly
)

$ErrorActionPreference = "Stop"
$repoRoot = $PSScriptRoot

function Write-Step($msg)  { Write-Host "`n>>>> $msg" -ForegroundColor Cyan }
function Write-Info($msg)  { Write-Host "    $msg" -ForegroundColor White }
function Write-Ok($msg)    { Write-Host "    [OK] $msg" -ForegroundColor Green }
function Write-Warn($msg)  { Write-Host "    [WARN] $msg" -ForegroundColor Yellow }
function Write-Err($msg)   { Write-Host "    [ERR] $msg" -ForegroundColor Red }
function Write-Dry($msg)   { Write-Host "    [DRY] $msg" -ForegroundColor Magenta }

if ($DryRun) { Write-Host "`n****** DRY RUN MODE — no changes will be made ******`n" -ForegroundColor Magenta }

# ============================================================
Write-Step "1/6  Detecting runtimes"
# ============================================================

$checks = @(
    @{ Name="Git";       Cmd="git --version";       Min="";     Var=$null },
    @{ Name="Node.js";   Cmd="node --version";      Min="v18";  Var=$null },
    @{ Name="npm";       Cmd="npm --version";       Min="8";    Var=$null },
    @{ Name="Python";    Cmd="python --version";    Min="3.10"; Var=$null },
    @{ Name="pip";       Cmd="pip --version";       Min="21";   Var=$null }
)

$allOk = $true
foreach ($c in $checks) {
    try {
        $out = Invoke-Expression $c.Cmd 2>&1
        Write-Ok "$($c.Name): $out"
    } catch {
        Write-Err "$($c.Name) NOT found. Please install it first."
        $allOk = $false
    }
}
if (-not $allOk) {
    Write-Warn "Some runtimes are missing. Install them before continuing."
    Write-Host "  Node.js: https://nodejs.org`n  Python: https://python.org`n  Git: https://git-scm.com" -ForegroundColor Yellow
    if (-not $DryRun) { exit 1 }
}

# ============================================================
Write-Step "2/6  Installing OpenClaw (if needed)"
# ============================================================
$oc = Get-Command openclaw -ErrorAction SilentlyContinue
if ($oc) {
    Write-Ok "OpenClaw already installed: $($oc.Source)"
} else {
    Write-Info "OpenClaw not found. Installing..."
    if (-not $DryRun) {
        # TODO: replace with actual OpenClaw install command
        Write-Warn "Please install OpenClaw manually from https://openclaw.ai"
        Write-Host "  Then re-run this script." -ForegroundColor Yellow
        exit 1
    } else {
        Write-Dry "Would install OpenClaw"
    }
}

# ============================================================
Write-Step "3/6  Installing skills (skillhub)"
# ============================================================
if (-not $SkipSkills) {
    & "$repoRoot\qclaw-skill-installer.ps1" -DryRun:$DryRun
} else {
    Write-Warn "Skipping skills (SkipSkills flag set)"
}

# ============================================================
Write-Step "4/6  Installing Python packages"
# ============================================================
if (-not $SkipPython) {
    $reqFile = "$repoRoot\requirements.txt"
    if (Test-Path $reqFile) {
        Write-Info "Installing from requirements.txt..."
        if (-not $DryRun) {
            pip install -r $reqFile 2>&1 | Out-Null
            Write-Ok "Python packages installed"
        } else {
            Write-Dry "Would run: pip install -r requirements.txt"
        }
    } else {
        Write-Warn "requirements.txt not found, skipping"
    }
} else {
    Write-Warn "Skipping Python packages (SkipPython flag set)"
}

# ============================================================
Write-Step "5/6  Installing npm global packages"
# ============================================================
if (-not $SkipNode) {
    $npmFile = "$repoRoot\npm-global.txt"
    if (Test-Path $npmFile) {
        $pkgs = Get-Content $npmFile | Where-Object { $_.Trim() -ne '' -and $_ -notmatch '^#' }
        foreach ($pkg in $pkgs) {
            Write-Info "npm install -g $pkg"
            if (-not $DryRun) {
                npm install -g $pkg 2>&1 | Out-Null
                if ($LASTEXITCODE -eq 0) { Write-Ok "Installed: $pkg" }
                else { Write-Warn "Failed: $pkg (may already be installed)" }
            } else {
                Write-Dry "Would run: npm install -g $pkg"
            }
        }
    } else {
        Write-Warn "npm-global.txt not found, skipping"
    }
} else {
    Write-Warn "Skipping npm packages (SkipNode flag set)"
}

# ============================================================
Write-Step "6/6  Final setup"
# ============================================================

# .env
$envFile  = "$repoRoot\.env"
$envTemplate = "$repoRoot\.env.template"
if ((Test-Path $envTemplate) -and (-not (Test-Path $envFile))) {
    Copy-Item $envTemplate $envFile
    Write-Ok "Created .env from template — please edit it with your API keys!"
    Write-Host "  Edit: $envFile" -ForegroundColor Yellow
} elseif (Test-Path $envFile) {
    Write-Ok ".env already exists"
}

# openclaw config
$configTemplate = "$repoRoot\openclaw-config-template.json"
$configTarget  = "$env:USERPROFILE\.qclaw\openclaw.json"
if ((Test-Path $configTemplate) -and (-not (Test-Path $configTarget))) {
    Write-Info "openclaw.json template available at: $configTemplate"
    Write-Host "  Copy to: $configTarget  and fill in your API keys" -ForegroundColor Yellow
} elseif (Test-Path $configTarget) {
    Write-Ok "openclaw.json already exists at: $configTarget"
}

Write-Host "`n====== All Done! ======" -ForegroundColor Green
Write-Host "Remaining manual steps:" -ForegroundColor Yellow
Write-Host "  1. Edit .env with your API keys"
Write-Host "  2. (Optional) Copy openclaw-config-template.json to ~/.qclaw/openclaw.json"
Write-Host "  3. Run: openclaw gateway restart"
