# 开发环境安装 To-Do List

> 最后更新：2026-05-31
> 用途：新机器一键查看需要安装的所有环境和工具

---

## Phase 1：基础运行环境

- [ ] 安装 **Git** (≥ 2.x)
  - Windows: `winget install Git.Git`
  - 验证：`git --version`
- [ ] 安装 **Node.js** (≥ v18)
  - Windows: `winget install OpenJS.NodeJS`
  - 验证：`node --version` → 当前 v22.16.0
- [ ] 安装 **npm** (≥ 8)
  - 随 Node.js 自带
  - 验证：`npm --version` → 当前 v10.9.8
- [ ] 安装 **Python** (≥ 3.10)
  - Windows: `winget install Python.Python.3`
  - 验证：`python --version` → 当前 3.12.10
- [ ] 安装 **pip** (≥ 21)
  - 随 Python 自带
  - 验证：`pip --version` → 当前 26.1.1

---

## Phase 2：OpenClaw 平台

- [ ] 安装 OpenClaw
  - 下载：https://openclaw.ai
  - 当前版本：v0.2.23.532
  - 验证：`openclaw --version`
- [ ] 启动 OpenClaw Gateway
  ```powershell
  openclaw gateway start
  openclaw gateway status
  ```

---

## Phase 3：API Keys 配置（脱敏版）

> ⚠️ 所有 API Key 已从本文件移除，请复制到本地 `.env` 后填写

| 环境变量 | 用途 | 获取地址 |
|-----------|------|-----------|
| `QCLAW_LLM_BASE_URL` | 主 LLM 代理地址 | 内部提供 |
| `QCLAW_LLM_API_KEY` | 主 LLM API Key | 内部提供 |
| `OPENROUTER_API_KEY` | OpenRouter API Key | https://openrouter.ai/keys |
| `DEEPSEEK_API_KEY` | DeepSeek API Key | https://platform.deepseek.com |
| `QCLAW_WECHAT_WS_URL` | 微信 WebSocket 地址 | 内部提供 |
| `QCLAW_FEISHU_ACCOUNT_*` | 飞书应用凭证（5个账号） | 飞书开放平台 |

**配置步骤：**

```bash
# 1. 复制模板
cp .env.template .env

# 2. 编辑 .env，填入真实 Key
# Windows: notepad .env

# 3. 将环境变量加载到系统
# Windows PowerShell:
Get-Content .env | ForEach-Object { if ($_ -match '^([^#=]+)=(.*)$') { [Environment]::SetEnvironmentVariable($matches[1], $matches[2], 'User') } }

# 4. 复制 openclaw 配置模板
# Windows:
copy openclaw-config-template.json %USERPROFILE%\.qclaw\openclaw.json
```

---

## Phase 4：Skills 安装清单

### System Skills（通过 QClaw UI 或 skillhub 安装）

| # | Skill 名称 | 版本 | 安装时间 |
|---|-----------|------|---------|
| 1 | aippt | v3 | 2026-05-27 |
| 2 | another_them | v1 | 2026-05-20 |
| 3 | cloud-upload-backup | v2 | 2026-05-20 |
| 4 | docx | v1 | 2026-05-20 |
| 5 | email-skill | v2 | 2026-05-20 |
| 6 | fbs_bookwriter | v1 | 2026-05-20 |
| 7 | imap-smtp-email | v5 | 2026-05-30 |
| 8 | kdocs | v1 | 2026-05-20 |
| 9 | mcporter | v1 | 2026-05-20 |
| 10 | multi-search-engine | v2 | 2026-05-20 |
| 11 | pdf | v1 | 2026-05-20 |
| 12 | persona-switch | v7 | 2026-05-23 |
| 13 | wecom-weisheng-scrm | v1 | 2026-05-20 |
| 14 | xlsx | v1 | 2026-05-20 |
| 15 | bdpan-storage | v1 | 2026-05-20 |
| 16 | meituan-travel | v1 | 2026-05-21 |
| 17 | tencent-esign-contract | v1 | 2026-05-21 |
| 18 | tencent-meeting-mcp | v1 | 2026-05-27 |
| 19 | weread-skills | v1 | 2026-05-29 |
| 20 | tencent-survey | v1 | 2026-05-30 |

### Local / Custom Skills（手动创建）

| # | Skill 名称 | 位置 |
|---|-----------|------|
| 1 | agent-development | `~/.openclaw/skills/` + `~/.agents/skills/` |
| 2 | agent-evaluation | `~/.openclaw/skills/` + `~/.agents/skills/` |
| 3 | agent-manager-skill | `~/.openclaw/skills/` + `~/.agents/skills/` |
| 4 | excel-analysis | `~/.openclaw/skills/` + `~/.agents/skills/` |
| 5 | find-skills | `~/.openclaw/skills/` + `~/.agents/skills/` |
| 6 | ai-engineer | `~/.qclaw/skills/` |
| 7 | deepseek-balance | `~/.qclaw/skills/` |
| 8 | redbox-xiaohongshu-creator | `~/.qclaw/skills/` |

### Bundled Skills（随 QClaw 自带，无需安装）

lark-setup / lark-calendar / lark-im / lark-doc / lark-drive / lark-sheets / lark-base / lark-task / lark-mail / lark-contact / lark-wiki / online-search / qclaw-cron-skill / qclaw-env / qclaw-rules / qclaw-text-file / qclaw-skill-creator / skillhub-preference / tencent-docs / qq-email-skill / qclaw-migration / xbrowser

---

## Phase 5：Python 包安装

```bash
pip install -r requirements.txt
```

**当前已安装包（共 62 个）：**

aiohappyeyeballs 2.6.2 / aiohttp 3.13.5 / aiosignal 1.4.0 / annotated-types 0.7.0 / anyio 4.13.0 / attrs 26.1.0 / boto3 1.42.89 / botocore 1.42.97 / certifi 2026.5.20 / cffi 2.0.0 / charset-normalizer 3.4.7 / colorama 0.4.6 / cryptography 48.0.0 / distro 1.9.0 / edge-tts 7.2.7 / fire 0.7.1 / frozenlist 1.8.0 / h11 0.16.0 / httpcore 1.0.9 / httpx 0.28.1 / idna 3.16 / Jinja2 3.1.6 / jiter 0.15.0 / jmespath 1.1.0 / markdown-it-py 4.2.0 / MarkupSafe 3.0.3 / mdurl 0.1.2 / multidict 6.7.1 / openai 2.24.0 / packaging 26.2 / prompt_toolkit 3.0.52 / propcache 0.5.2 / psutil 7.2.2 / pycparser 3.0 / pydantic 2.13.4 / pydantic_core 2.46.4 / PyJWT 2.12.1 / python-dateutil 2.9.0.post0 / python-dotenv 1.2.2 / pytz 2026.2 / PyYAML 6.0.3 / requests 2.33.0 / rich 14.3.3 / ruamel.yaml 0.18.17 / ruamel.yaml.clib 0.2.15 / s3transfer 0.16.1 / setuptools 82.0.1 / six 1.17.0 / sniffio 1.3.1 / socksio 1.0.0 / tabulate 0.10.0 / tenacity 9.1.4 / termcolor 3.3.0 / tqdm 4.67.3 / typing_extensions 4.15.0 / typing-inspection 0.4.2 / tzdata 2025.3 / urllib3 2.7.0 / wcwidth 0.7.0 / wheel 0.47.0

---

## Phase 6：npm 全局包安装

```bash
npm install -g @larksuite/cli@1.0.44
npm install -g @openai/codex@0.133.0
```

---

## Phase 7：Agent 配置

| Agent ID | 名称 | 模型 | Workspace |
|----------|------|------|----------|
| main | QClaw | qclaw/modelroute | `~/.qclaw/workspace` |
| openrouter | OpenRouter | anthropic/claude-opus-4.8 | `~/.qclaw/workspace-openrouter` |
| deepseek-flash | DeepSeek Flash | deepseek/deepseek-chat | `~/.qclaw/workspace-deepseek-flash` |
| deepseek-pro | DeepSeek Pro | deepseek/deepseek-reasoner | `~/.qclaw/workspace-deepseek-pro` |

---

## Phase 8：最终验证

- [ ] `openclaw gateway status` — Gateway 正常运行
- [ ] `openclaw skills list` — 所有 skills 已安装
- [ ] `python --version` → 3.12.10
- [ ] `node --version` → v22.16.0
- [ ] `npm --version` → 10.9.8
- [ ] `git --version` → 2.54.0.windows.1
- [ ] 发送测试消息到微信/飞书，确认 bot 正常响应

---

## 附：一键安装（推荐）

如果不想手动逐步操作，直接用一键安装脚本：

```powershell
# Windows
.\install.ps1

# macOS / Linux
bash install.sh
```

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
