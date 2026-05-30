#!/usr/bin/env bash
# install.sh — macOS/Linux all-in-one dev environment installer
# Usage:  bash install.sh              # full install
#          bash install.sh --skip-python    # skip Python packages
#          bash install.sh --skip-node      # skip Node.js packages
#          bash install.sh --dry-run        # preview only

set -euo pipefail

DRY_RUN=0
SKIP_PYTHON=0
SKIP_NODE=0
SKIP_SKILLS=0

for arg in "$@"; do
    case $arg in
        --dry-run)     DRY_RUN=1 ;;
        --skip-python) SKIP_PYTHON=1 ;;
        --skip-node)   SKIP_NODE=1 ;;
        --skip-skills) SKIP_SKILLS=1 ;;
    esac
done

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'
CYAN='\033[0;36m'; MAGENTA='\033[0;35m'; NC='\033[0m'

info()  { echo -e "    ${1}"; }
ok()    { echo -e "    ${GREEN}[OK]${NC} ${1}"; }
warn()  { echo -e "    ${YELLOW}[WARN]${NC} ${1}"; }
err()   { echo -e "    ${RED}[ERR]${NC} ${1}"; }
dry()   { echo -e "    ${MAGENTA}[DRY]${NC} ${1}"; }
step()  { echo -e "\n${CYAN}>>>> ${1}${NC}"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [[ $DRY_RUN -eq 1 ]]; then
    echo -e "\n${MAGENTA}****** DRY RUN MODE — no changes will be made ******${NC}\n"
fi

# ============================================================
step "1/5  Detecting runtimes"
# ============================================================
check_cmd() {
    if command -v "$1" &>/dev/null; then
        ok "$1: $($1 --version 2>&1 | head -1)"
        return 0
    else
        err "$1 NOT found. Please install it first."
        return 1
    fi
}

ALL_OK=1
check_cmd git   || ALL_OK=0
check_cmd node  || ALL_OK=0
check_cmd npm   || ALL_OK=0
check_cmd python3 || check_cmd python || ALL_OK=0
check_cmd pip3 || check_cmd pip || ALL_OK=0

if [[ $ALL_OK -eq 0 && $DRY_RUN -eq 0 ]]; then
    warn "Some runtimes are missing. Please install them first."
    echo "  Node.js: https://nodejs.org"
    echo "  Python:  https://python.org"
    echo "  Git:     https://git-scm.com"
    exit 1
fi

# ============================================================
step "2/5  Installing OpenClaw (if needed)"
# ============================================================
if command -v openclaw &>/dev/null; then
    ok "OpenClaw already installed"
else
    warn "OpenClaw not found. Please install from https://openclaw.ai"
    echo "  Then re-run this script."
    exit 1
fi

# ============================================================
step "3/5  Installing Python packages"
# ============================================================
if [[ $SKIP_PYTHON -eq 0 ]]; then
    PIP_CMD="pip3"; command -v pip3 &>/dev/null || PIP_CMD="pip"
    PACKAGES=(
        "aiohappyeyeballs==2.6.2" "aiohttp==3.13.5" "aiosignal==1.4.0"
        "annotated-types==0.7.0" "anyio==4.13.0" "attrs==26.1.0"
        "boto3==1.42.89" "botocore==1.42.97" "certifi==2026.5.20"
        "cffi==2.0.0" "charset-normalizer==3.4.7" "colorama==0.4.6"
        "cryptography==48.0.0" "distro==1.9.0" "edge-tts==7.2.7"
        "fire==0.7.1" "frozenlist==1.8.0" "h11==0.16.0"
        "httpcore==1.0.9" "httpx==28.1" "idna==3.16"
        "Jinja2==3.1.6" "jiter==0.15.0" "jmespath==1.1.0"
        "markdown-it-py==4.2.0" "MarkupSafe==3.0.3" "mdurl==0.1.2"
        "multidict==6.7.1" "openai==2.24.0" "packaging==26.2"
        "prompt_toolkit==3.0.52" "propcache==0.5.2" "psutil==7.2.2"
        "pycparser==3.0" "pydantic==2.13.4" "pydantic_core==2.46.4"
        "PyJWT==2.12.1" "python-dateutil==2.9.0.post0" "python-dotenv==1.2.2"
        "pytz==2026.2" "PyYAML==6.0.3" "requests==2.33.0"
        "rich==14.3.3" "ruamel.yaml==0.18.17" "ruamel.yaml.clib==0.2.15"
        "s3transfer==0.16.1" "setuptools==82.0.1" "six==1.17.0"
        "sniffio==1.3.1" "socksio==1.0.0" "tabulate==0.10.0"
        "tenacity==9.1.4" "termcolor==3.3.0" "tqdm==4.67.3"
        "typing_extensions==4.15.0" "typing-inspection==0.4.2"
        "tzdata==2025.3" "urllib3==2.7.0" "wcwidth==0.7.0" "wheel==0.47.0"
    )
    info "Installing ${#PACKAGES[@]} Python packages..."
    if [[ $DRY_RUN -eq 0 ]]; then
        $PIP_CMD install "${PACKAGES[@]}" 2>&1 | tail -5
        ok "Python packages installed"
    else
        dry "Would run: $PIP_CMD install ${#PACKAGES[@]} packages"
    fi
else
    warn "Skipping Python packages (--skip-python flag set)"
fi

# ============================================================
step "4/5  Installing npm global packages"
# ============================================================
if [[ $SKIP_NODE -eq 0 ]]; then
    NPM_PACKAGES=("@larksuite/cli@1.0.44" "@openai/codex@0.133.0")
    for pkg in "${NPM_PACKAGES[@]}"; do
        info "npm install -g $pkg"
        if [[ $DRY_RUN -eq 0 ]]; then
            npm install -g "$pkg" 2>&1 | tail -1
            ok "Installed: $pkg"
        else
            dry "Would run: npm install -g $pkg"
        fi
    done
else
    warn "Skipping npm packages (--skip-node flag set)"
fi

# ============================================================
step "5/5  Installing Skills"
# ============================================================
if [[ $SKIP_SKILLS -eq 0 ]]; then
    SKILLS=(
        "aippt" "another_them" "cloud-upload-backup" "docx"
        "email-skill" "fbs_bookwriter" "imap-smtp-email" "kdocs"
        "mcporter" "multi-search-engine" "pdf" "persona-switch"
        "wecom-weisheng-scrm" "xlsx" "bdpan-storage"
        "meituan-travel" "tencent-esign-contract" "tencent-meeting-mcp"
        "weread-skills" "tencent-survey"
    )
    info "Installing ${#SKILLS[@]} skills via skillhub..."
    for skill in "${SKILLS[@]}"; do
        if [[ $DRY_RUN -eq 0 ]]; then
            openclaw skillhub install "$skill" 2>&1 | tail -1
            ok "Skill installed: $skill"
        else
            dry "Would run: openclaw skillhub install $skill"
        fi
    done
else
    warn "Skipping skills (--skip-skills flag set)"
fi

# ============================================================
echo -e "\n${GREEN}====== All Done! ======${NC}"
echo -e "${YELLOW}Remaining manual steps:${NC}"
echo "  1. Create .env file with your API keys (see TO-DO-LIST.md Phase 3)"
echo "  2. Run: openclaw gateway restart"
