# install.ps1 — Windows all-in-one dev environment installer
# Usage:  .\install.ps1                # full install
#          .\install.ps1 -SkipPython    # skip Python packages
#          .\install.ps1 -SkipNode      # skip Node.js packages
#          .\install.ps1 -DryRun        # preview only, no changes

param(
    [switch]$DryRun,
    [switch]$SkipPython,
    [switch]$SkipNode,
    [switch]$SkipSkills
)

$ErrorActionPreference = "Stop"
$repoRoot = $PSScriptRoot

function Write-Step($msg)  { Write-Host "`n>>>> $msg" -ForegroundColor Cyan }
function Write-Info($msg)  { Write-Host "    $msg" -ForegroundColor White }
function Write-Ok($msg)    { Write-Host "    [OK] $msg" -ForegroundColor Green }
function Write-Warn($msg)  { Write-Host "    [WARN] $msg" -ForegroundColor Yellow }
function Write-Err($msg)   { Write-Host "    [ERR] $msg" -ForegroundColor Red }
function Write-Dry($msg)   { Write-Host "    [DRY] $msg" -ForegroundColor Magenta }

if ($DryRun) { Write-Host "`n[DRY RUN MODE — no changes will be made]" -ForegroundColor Magenta }

# ============================================================
Write-Step "1/6  Detecting runtimes"
# ============================================================
$checks = @(
    @{ Name="Git";    Cmd="git --version";       Min="";   Var=$null },
    @{ Name="Node.js";Cmd="node --version";      Min="v18";Var=$null },
    @{ Name="npm";    Cmd="npm --version";       Min="8";  Var=$null },
    @{ Name="Python"; Cmd="python --version";    Min="3.10";Var=$null },
    @{ Name="pip";    Cmd="pip --version";       Min="21"; Var=$null }
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
Write-Step "2/6  Configuring domestic mirrors (China)"
# ============================================================
Write-Info "Setting npm registry to npmmirror (China mirror)..."
if (-not $DryRun) {
    npm config set registry https://registry.npmmirror.com/
    Write-Ok "npm registry → https://registry.npmmirror.com/"
} else {
    Write-Dry "Would set npm registry to https://registry.npmmirror.com/"
}

Write-Info "Setting pip index-url to Tsinghua mirror..."
if (-not $DryRun) {
    pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/
    Write-Ok "pip index-url → https://pypi.tuna.tsinghua.edu.cn/simple/"
} else {
    Write-Dry "Would set pip index-url to Tsinghua mirror"
}

# ============================================================
Write-Step "3/6  Installing OpenClaw (if needed)"
# ============================================================
$oc = Get-Command openclaw -ErrorAction SilentlyContinue
if ($oc) {
    Write-Ok "OpenClaw already installed: $($oc.Source)"
} else {
    Write-Info "OpenClaw not found. Installing..."
    if (-not $DryRun) {
        Write-Warn "Please install OpenClaw manually from https://openclaw.ai"
        Write-Host "  Then re-run this script." -ForegroundColor Yellow
        exit 1
    } else {
        Write-Dry "Would install OpenClaw"
    }
}

# ============================================================
Write-Step "4/6  Installing Python packages (Tsinghua mirror)"
# ============================================================
if (-not $SkipPython) {
    $pkgs = @(
        "aiohappyeyeballs==2.6.2", "aiohttp==3.13.5", "aiosignal==1.4.0",
        "annotated-types==0.7.0", "anyio==4.13.0", "attrs==26.1.0",
        "boto3==1.42.89", "botocore==1.42.97", "certifi==2026.5.20",
        "cffi==2.0.0", "charset-normalizer==3.4.7", "colorama==0.4.6",
        "cryptography==48.0.0", "distro==1.9.0", "edge-tts==7.2.7",
        "fire==0.7.1", "frozenlist==1.8.0", "h11==0.16.0",
        "httpcore==1.0.9", "httpx==0.28.1", "idna==3.16",
        "Jinja2==3.1.6", "jiter==0.15.0", "jmespath==1.1.0",
        "markdown-it-py==4.2.0", "MarkupSafe==3.0.3", "mdurl==0.1.2",
        "multidict==6.7.1", "openai==2.24.0", "packaging==26.2",
        "prompt_toolkit==3.0.52", "propcache==0.5.2", "psutil==7.2.2",
        "pycparser==3.0", "pydantic==2.13.4", "pydantic_core==2.46.4",
        "PyJWT==2.12.1", "python-dateutil==2.9.0.post0", "python-dotenv==1.2.2",
        "pytz==2026.2", "PyYAML==6.0.3", "requests==2.33.0",
        "rich==14.3.3", "ruamel.yaml==0.18.17", "ruamel.yaml.clib==0.2.15",
        "s3transfer==0.16.1", "setuptools==82.0.1", "six==1.17.0",
        "sniffio==1.3.1", "socksio==1.0.0", "tabulate==0.10.0",
        "tenacity==9.1.4", "termcolor==3.3.0", "tqdm==4.67.3",
        "typing_extensions==4.15.0", "typing-inspection==0.4.2",
        "tzdata==2025.3", "urllib3==2.7.0", "wcwidth==0.7.0", "wheel==0.47.0"
    )
    Write-Info "Installing $($pkgs.Count) Python packages via Tsinghua mirror..."
    if (-not $DryRun) {
        pip install $pkgs -i https://pypi.tuna.tsinghua.edu.cn/simple/ 2>&1 | Out-Null
        Write-Ok "Python packages installed (mirror: Tsinghua)"
    } else {
        Write-Dry "Would run: pip install $($pkgs.Count) packages (Tsinghua mirror)"
    }
} else {
    Write-Warn "Skipping Python packages (SkipPython flag set)"
}

# ============================================================
Write-Step "5/6  Installing npm global packages (npmmirror)"
# ============================================================
if (-not $SkipNode) {
    $npmPkgs = @("@larksuite/cli@1.0.44", "@openai/codex@0.133.0")
    foreach ($pkg in $npmPkgs) {
        Write-Info "npm install -g $pkg (registry: npmmirror)"
        if (-not $DryRun) {
            npm install -g $pkg --registry https://registry.npmmirror.com/ 2>&1 | Out-Null
            if ($LASTEXITCODE -eq 0) { Write-Ok "Installed: $pkg" }
            else { Write-Warn "Failed: $pkg (may already be installed)" }
        } else {
            Write-Dry "Would run: npm install -g $pkg (npmmirror)"
        }
    }
} else {
    Write-Warn "Skipping npm packages (SkipNode flag set)"
}

# ============================================================
Write-Step "6/6  Installing Skills (npmmirror)"
# ============================================================
if (-not $SkipSkills) {
    $skills = @(
        "aippt", "another_them", "cloud-upload-backup", "docx",
        "email-skill", "fbs_bookwriter", "imap-smtp-email", "kdocs",
        "mcporter", "multi-search-engine", "pdf", "persona-switch",
        "wecom-weisheng-scrm", "xlsx", "bdpan-storage",
        "meituan-travel", "tencent-esign-contract", "tencent-meeting-mcp",
        "weread-skills", "tencent-survey"
    )
    Write-Info "Installing $($skills.Count) skills via skillhub (npmmirror)..."
    foreach ($skill in $skills) {
        if (-not $DryRun) {
            openclaw skillhub install $skill 2>&1 | Out-Null
            Write-Ok "Skill installed: $skill"
        } else {
            Write-Dry "Would run: openclaw skillhub install $skill"
        }
    }
} else {
    Write-Warn "Skipping skills (SkipSkills flag set)"
}

# ============================================================
Write-Host "`n====== All Done! ======" -ForegroundColor Green
Write-Host "Mirrors configured:" -ForegroundColor Cyan
Write-Host "  npm : https://registry.npmmirror.com/"
Write-Host "  pip  : https://pypi.tuna.tsinghua.edu.cn/simple/"
Write-Host "`nRemaining manual steps:" -ForegroundColor Yellow
Write-Host "  1. Create .env file with your API keys (see TO-DO-LIST.md Phase 3)"
Write-Host "  2. Run: openclaw gateway restart"
