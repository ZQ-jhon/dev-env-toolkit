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
        --tools-only)  SKIP_SKILLS=1 ;;
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
step "1/6  Detecting runtimes"
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
step "2/6  Installing OpenClaw (if needed)"
# ============================================================
if command -v openclaw &>/dev/null; then
    ok "OpenClaw already installed"
else
    warn "OpenClaw not found. Please install from https://openclaw.ai"
    echo "  Then re-run this script."
    exit 1
fi

# ============================================================
step "3/6  Installing skills (skillhub)"
# ============================================================
if [[ $SKIP_SKILLS -eq 0 ]]; then
    if [[ -f "$SCRIPT_DIR/qclaw-skill-installer.sh" ]]; then
        bash "$SCRIPT_DIR/qclaw-skill-installer.sh" $([ $DRY_RUN -eq 1 ] && echo "--dry-run")
    else
        warn "qclaw-skill-installer.sh not found, skipping skills"
    fi
else
    warn "Skipping skills (--skip-skills flag set)"
fi

# ============================================================
step "4/6  Installing Python packages"
# ============================================================
if [[ $SKIP_PYTHON -eq 0 ]]; then
    REQ_FILE="$SCRIPT_DIR/requirements.txt"
    if [[ -f "$REQ_FILE" ]]; then
        info "Installing from requirements.txt..."
        PIP_CMD="pip3"; command -v pip3 &>/dev/null || PIP_CMD="pip"
        if [[ $DRY_RUN -eq 0 ]]; then
            $PIP_CMD install -r "$REQ_FILE" 2>&1 | tail -5
            ok "Python packages installed"
        else
            dry "Would run: $PIP_CMD install -r requirements.txt"
        fi
    else
        warn "requirements.txt not found, skipping"
    fi
else
    warn "Skipping Python packages (--skip-python flag set)"
fi

# ============================================================
step "5/6  Installing npm global packages"
# ============================================================
if [[ $SKIP_NODE -eq 0 ]]; then
    NPM_FILE="$SCRIPT_DIR/npm-global.txt"
    if [[ -f "$NPM_FILE" ]]; then
        while IFS= read -r pkg || [[ -n "$pkg" ]]; do
            [[ -z "$pkg" || "$pkg" =~ ^# ]] && continue
            info "npm install -g $pkg"
            if [[ $DRY_RUN -eq 0 ]]; then
                npm install -g "$pkg" 2>&1 | tail -1
                ok "Installed: $pkg"
            else
                dry "Would run: npm install -g $pkg"
            fi
        done < "$NPM_FILE"
    else
        warn "npm-global.txt not found, skipping"
    fi
else
    warn "Skipping npm packages (--skip-node flag set)"
fi

# ============================================================
step "6/6  Final setup"
# ============================================================

# .env
if [[ -f "$SCRIPT_DIR/.env.template" && ! -f "$SCRIPT_DIR/.env" ]]; then
    cp "$SCRIPT_DIR/.env.template" "$SCRIPT_DIR/.env"
    ok "Created .env from template — please edit it with your API keys!"
    echo -e "  ${YELLOW}Edit: $SCRIPT_DIR/.env${NC}"
elif [[ -f "$SCRIPT_DIR/.env" ]]; then
    ok ".env already exists"
fi

echo -e "\n${GREEN}====== All Done! ======${NC}"
echo -e "${YELLOW}Remaining manual steps:${NC}"
echo "  1. Edit .env with your API keys"
echo "  2. (Optional) Copy openclaw-config-template.json to ~/.qclaw/openclaw.json"
echo "  3. Run: openclaw gateway restart"
