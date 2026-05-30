# dev-env-toolkit

My personal development environment toolkit — a one-command setup to restore the full OpenClaw + skills + Python/Node toolchain on a new machine.

## What's Included

### OpenClaw Skills (35 skills)

| Skill | Type | Scope | Installed |
|-------|------|-------|-----------|
| aippt | system | global | 2026-05-27 |
| another_them | system | agent | 2026-05-20 |
| cloud-upload-backup | system | agent | 2026-05-20 |
| docx | system | agent | 2026-05-20 |
| email-skill | system | agent | 2026-05-20 |
| fbs_bookwriter | system | global | 2026-05-20 |
| imap-smtp-email | system | global | 2026-05-30 |
| kdocs | system | global | 2026-05-20 |
| mcporter | system | agent | 2026-05-20 |
| multi-search-engine | system | agent | 2026-05-20 |
| pdf | system | agent | 2026-05-20 |
| persona-switch | system | agent | 2026-05-23 |
| wecom-weisheng-scrm | system | global | 2026-05-20 |
| xlsx | system | agent | 2026-05-20 |
| bdpan-storage | system | global | 2026-05-20 |
| meituan-travel | system | global | 2026-05-21 |
| tencent-esign-contract | system | global | 2026-05-21 |
| tencent-meeting-mcp | system | global | 2026-05-27 |
| weread-skills | system | global | 2026-05-29 |
| tencent-survey | system | global | 2026-05-30 |
| ai-engineer | local | agent | — |
| agent-development | local | agent | — |
| agent-evaluation | local | agent | — |
| agent-manager-skill | local | agent | — |
| excel-analysis | local | agent | — |
| find-skills | local | agent | — |
| lark-* (10 skills) | system | agent | — |
| online-search | system | agent | — |
| qclaw-* (4 skills) | bundled | agent | — |
| redbox-xiaohongshu-creator | system | agent | — |
| tencent-docs | system | agent | — |
| qq-email-skill | system | agent | — |

### Python Packages (pip)

```
aiohappyeyeballs 2.6.2     aiohttp 3.13.5         aiosignal 1.4.0
annotated-types 0.7.0        anyio 4.13.0           attrs 26.1.0
boto3 1.42.89               botocore 1.42.97       certifi 2026.5.20
cffi 2.0.0                  charset-normalizer 3.4.7  colorama 0.4.6
cryptography 48.0.0          distro 1.9.0           edge-tts 7.2.7
fire 0.7.1                   frozenlist 1.8.0       h11 0.16.0
httpcore 1.0.9               httpx 0.28.1           idna 3.16
Jinja2 3.1.6                jmespath 1.1.0         markdown-it-py 4.2.0
MarkupSafe 3.0.3             mdurl 0.1.2            multidict 6.7.1
openai 2.24.0                packaging 26.2          prompt_toolkit 3.0.52
propcache 0.5.2              psutil 7.2.2           pycparser 3.0
pydantic 2.13.4              pydantic_core 2.46.4   PyJWT 2.12.1
python-dateutil 2.9.0        python-dotenv 1.2.2    pytz 2026.2
PyYAML 6.0.3                 requests 2.33.0        rich 14.3.3
ruamel.yaml 0.18.17          s3transfer 0.16.1      setuptools 82.0.1
six 1.17.0                   sniffio 1.3.1          socksio 1.0.0
tabulate 0.10.0              tenacity 9.1.4         termcolor 3.3.0
tqdm 4.67.3                  typing_extensions 4.15.0  tzdata 2025.3
urllib3 2.7.0                wcwidth 0.7.0           wheel 0.47.0
```

### Node.js / npm Global Packages

| Package | |
|----------|-|
| @larksuite/cli | v1.0.44 |
| @openai/codex | v0.133.0 |
| node | v22.16.0 |
| npm | v10.9.8 |

### Runtimes

| Tool | Version |
|------|---------|
| Node.js | v22.16.0 |
| Python | 3.12.10 |
| pip | 26.1.1 |
| Git | 2.54.0.windows.1 |
| OpenClaw | v0.2.23.532 |

## Quick Install

### Windows (PowerShell)

```powershell
# Clone and install everything
git clone https://github.com/ZQ-jhon/dev-env-toolkit.git
cd dev-env-toolkit
.\install.ps1
```

### macOS / Linux (bash)

```bash
git clone https://github.com/ZQ-jhon/dev-env-toolkit.git
cd dev-env-toolkit
bash install.sh
```

## What `install.ps1` / `install.sh` Does

1. Detects OS and existing toolchain (Node, Python, Git)
2. Installs missing runtimes if needed
4. Restores all pip packages via `requirements.txt`
5. Restores all npm global packages via `npm-global.txt`
6. Guides you through `openclaw.json` config (API keys are in `.env.template` — you fill in your own)
7. Verifies the installation

## Manual Setup

If you prefer to pick what to install:

```powershell
# Install skills only
qclaw-skill-installer.ps1 -SkillsOnly

# Install Python packages only
pip install -r requirements.txt

# Install npm global packages only
npm install -g $(cat npm-global.txt)
```

## Files

| File | Purpose |
|------|---------|
| `skills-manifest.json` | Complete skill list with versions & checksums |
| `requirements.txt` | Python pip packages (pip freeze output) |
| `npm-global.txt` | npm global packages |
| `install.ps1` | Windows one-click installer |
| `install.sh` | macOS/Linux one-click installer |
| `.env.template` | Template for API keys (copy to `.env` and fill in) |
| `openclaw-config-template.json` | Sanitized openclaw.json template |
| `setup-guide.md` | Detailed setup walkthrough |

## Notes

- **API keys are NOT included.** Copy `.env.template` to `.env` and fill in your own keys.
- The `openclaw-config-template.json` has all API keys replaced with `${ENV_VAR}` placeholders.
- Skill `.skill` zip files are not stored in this repo (too large). The installer downloads them from the skill registry.

## Author

tychozhang → [GitHub @ZQ-jhon](https://github.com/ZQ-jhon)
