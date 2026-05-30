# Setup Guide — dev-env-toolkit

This guide walks you through restoring the full dev environment on a new machine.

---

## Prerequisites

| Tool | Min Version | Check |
|------|-------------|-------|
| Git | 2.x | `git --version` |
| Node.js | v18+ | `node --version` |
| npm | 8+ | `npm --version` |
| Python | 3.10+ | `python --version` |
| pip | 21+ | `pip --version` |

> **Windows users**: Use winget or chocolatey to install missing tools:
> ```
> winget install Git.Git  OpenJS.NodeJS  Python.Python.3
> ```

---

## Step 1: Clone the Repo

```bash
git clone https://github.com/ZQ-jhon/dev-env-toolkit.git
cd dev-env-toolkit
```

---

## Step 2: Set Up API Keys

```bash
# Copy the template
cp .env.template .env

# Edit with your actual keys
# (Windows PowerShell: copy .env.template .env, then notepad .env)
```

Fill in at minimum:
- `QCLAW_LLM_BASE_URL` + `QCLAW_LLM_API_KEY` (primary LLM)
- `OPENROUTER_API_KEY` (if using OpenRouter)
- `DEEPSEEK_API_KEY` (if using DeepSeek)

---

## Step 3: Run the Installer

### Windows (PowerShell)
```powershell
.\install.ps1
# Dry run first (no changes):
.\install.ps1 -DryRun
# Skip Python:
.\install.ps1 -SkipPython
```

### macOS / Linux
```bash
bash install.sh
# Dry run first:
bash install.sh --dry-run
# Skip Python:
bash install.sh --skip-python
```

What the installer does:
1. Detects installed runtimes
2. Installs OpenClaw (if missing)
3. Installs all skills via skillhub
4. `pip install -r requirements.txt`
5. `npm install -g` each package in `npm-global.txt`
6. Copies `.env.template` → `.env` (if not exists)

---

## Step 4: Restore OpenClaw Config

```bash
# The template has all API keys replaced with ${ENV_VAR} placeholders
# Copy it to the OpenClaw config location:

# Windows:
copy openclaw-config-template.json %USERPROFILE%\.qclaw\openclaw.json

# macOS/Linux:
cp openclaw-config-template.json ~/.qclaw/openclaw.json
```

Then edit the file to make sure `${VAR_NAME}` placeholders match your `.env`.

---

## Step 5: Restart OpenClaw Gateway

```bash
openclaw gateway restart
```

Verify:
```bash
openclaw gateway status
```

---

## Step 6: Verify Skills

```bash
# List installed skills
openclaw skills list

# Or via skillhub
openclaw skillhub list
```

---

## Manual Steps (Not Automated)

Some items can't be auto-installed and need manual attention:

| Item | Why | How |
|------|-----|-----|
| Local/custom skills | Not in public registry | Copy from backup or recreate |
| `.qclaw/skills/deepseek-balance` | Custom skill | Recreate from memory or backup |
| Feishu app secrets | Sensitive | Fill into `openclaw.json` manually |
| WeChat WS URL | Sensitive | Fill into `.env` manually |
| GitHub SSH keys | Sensitive | `ssh-keygen` + add to GitHub |

---

## Troubleshooting

**Skill install fails with "not found"**
> The skill may have been renamed or removed from the registry. Check `skills-manifest.json` and skip it with `-SkipSkills`.

**pip install fails on Windows**
> Some packages (like `cryptography`) need Visual Studio Build Tools. Install from: https://visualstudio.microsoft.com/visual-cpp-build-tools/

**openclaw command not found after install**
> Restart your terminal, or run: `RefreshEnv.ps1` (Windows) / `source ~/.bashrc` (Linux/macOS)

---

## File Reference

| File | Purpose |
|------|---------|
| `README.md` | Overview and quick start |
| `skills-manifest.json` | Complete skill inventory with versions |
| `requirements.txt` | Python packages (`pip freeze`) |
| `npm-global.txt` | npm global packages |
| `.env.template` | API key template (copy to `.env`) |
| `openclaw-config-template.json` | Sanitized `openclaw.json` |
| `install.ps1` | Windows all-in-one installer |
| `install.sh` | macOS/Linux all-in-one installer |
| `qclaw-skill-installer.ps1` | Skills-only installer (Windows) |
| `setup-guide.md` | This file |
