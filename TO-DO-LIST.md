# 开发环境安装 To-Do List

> 最后更新：2026-05-31
> 适用平台：Windows / macOS / Linux

---

## Phase 1：基础运行环境

### 1.1 Git

| 平台 | 安装方式 |
|------|-----------|
| Windows | `winget install Git.Git` |
| macOS | `brew install git` |
| Linux | `sudo apt install git` / `sudo yum install git` |

```bash
# 验证
git --version
# 当前版本：2.54.0
```

### 1.2 Node.js & npm

| 平台 | 安装方式 |
|------|-----------|
| Windows | `winget install OpenJS.NodeJS` |
| macOS | `brew install node` |
| Linux | `sudo apt install nodejs npm` / `nvm install --lts` |

```bash
# 验证
node --version   # 当前 v22.16.0
npm --version    # 当前 10.9.8
```

### 1.3 Python & pip

| 平台 | 安装方式 |
|------|-----------|
| Windows | `winget install Python.Python.3` |
| macOS | `brew install python@3.12` |
| Linux | `sudo apt install python3 python3-pip` |

```bash
# 验证
python --version   # 或 python3 --version，当前 3.12.10
pip --version    # 或 pip3 --version，当前 26.1.1
```

### 1.4 JDK（OpenJDK / Temurin）

| 平台 | 安装方式 |
|------|-----------|
| Windows | `winget install EclipseAdoptium.Temurin.17JDK` |
| macOS | `brew install openjdk@17` |
| Linux | `sudo apt install openjdk-17-jdk` |

```bash
# 验证
java -version
# 当前版本：OpenJDK 17.0.19 (Temurin)
```

- **JAVA_HOME 配置**：
  - Windows（PowerShell）：`[Environment]::SetEnvironmentVariable('JAVA_HOME', 'C:\Program Files\Eclipse Adoptium\jdk-17.0.19.10-hotspot', 'User')`
  - macOS/Linux（bash/zsh）：`export JAVA_HOME=$(/usr/libexec/java_home -v 17)` → 写入 `~/.zshrc` 或 `~/.bashrc`

### 1.5 Android SDK（含 adb）

| 平台 | 安装方式 |
|------|-----------|
| Windows | 安装 Android Studio，或单独下载 [Command-line Tools](https://developer.android.com/studio#command-line-tools) |
| macOS | `brew install android-commandlinetools` |
| Linux | 下载 command-line tools 并配置 `ANDROID_HOME` |

```bash
# 验证
adb --version
# 当前版本：Android Debug Bridge v1.0.41 (Platform-Tools 37.0.0)
```

- **ANDROID_HOME 配置**：
  - Windows：默认 `C:\Users\<user>\AppData\Local\Android\Sdk`
  - macOS/Linux：`~/Library/Android/sdk` 或 `~/Android/Sdk`
  - 将 `$ANDROID_HOME/platform-tools` 加入 PATH

### 1.6 NVM（Node Version Manager）

| 平台 | 安装方式 |
|------|-----------|
| Windows | 下载 [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) 安装包 |
| macOS/Linux | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash` |

```bash
# 验证
nvm version
# 当前版本（Windows）：1.2.2

# 安装并使用 LTS 版本
nvm install lts
nvm use 22.16.0
```

### 1.7 NRM（npm Registry Manager）

```bash
# 安装（跨平台）
npm install -g nrm

# 验证
nrm --version
# 当前版本：2.1.0

# 切换 npm 镜像（国内推荐）
nrm use taobao    # 淘宝镜像 https://registry.npmmirror.com/
# 或
nrm use tencent   # 腾讯镜像 https://mirrors.tencent.com/npm/
```

### 1.8 Hermes Agent

| 平台 | 安装方式 |
|------|----------|
| Windows | `npm install -g hermes` + 按提示安装 hermes-agent（Python venv） |
| macOS | `brew install hermes` 或 `npm install -g hermes` |
| Linux | `npm install -g hermes` |

```bash
# 验证
hermes --version
# 当前版本：0.4.4

hermes-agent --version
# Python 版 hermes-agent（需安装依赖：pip install websockets）
```

> **注意**：`hermes-agent` 依赖 Python venv，如报错 `No module named 'websockets'`，运行：
> ```bash
> pip install websockets
> ```

# 验证
nrm --version
# 当前版本：2.1.0

# 切换 npm 镜像（国内推荐）
nrm use taobao    # 淘宝镜像 https://registry.npmmirror.com/
# 或
nrm use tencent   # 腾讯镜像 https://mirrors.tencent.com/npm/
```

---

## Phase 2：OpenClaw 平台

```bash
# 1. 安装 OpenClaw
#    下载：https://openclaw.ai
#    当前版本：v0.2.23.532

# 2. 验证安装
openclaw --version

# 3. 启动 Gateway
openclaw gateway start
openclaw gateway status
#    - bind: 127.0.0.1:64541
#    - Dashboard: http://127.0.0.1:64541/
```

---

## Phase 3：API Keys 配置（脱敏版）

> ⚠️ 以下所有 Key 均已脱敏，真实值请填入本地 `.env` 文件，不要提交到 Git

### 3.1 创建 `.env` 文件

```bash
# 复制模板
cp .env.template .env

# 编辑填入真实 Key
# Windows:  notepad .env
# macOS/Linux:  vim .env
```

### 3.2 Key 清单

| 环境变量 | 用途 | 获取地址 |
|-----------|------|-----------|
| `LLM_BASE_URL` | LLM 代理地址 | 内部提供 |
| `LLM_API_KEY` | LLM API Key | 内部提供 |
| `OPENROUTER_API_KEY` | OpenRouter API Key | https://openrouter.ai/keys |
| `DEEPSEEK_API_KEY` | DeepSeek API Key | https://platform.deepseek.com |
| `WECHAT_WS_URL` | 微信 WebSocket 地址 | 内部提供 |
| `FEISHU_APP_ID_1` | 飞书应用 1 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_1` | 飞书应用 1 App Secret | 飞书开放平台 |
| `FEISHU_APP_ID_2` | 飞书应用 2 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_2` | 飞书应用 2 App Secret | 飞书开放平台 |
| `FEISHU_APP_ID_3` | 飞书应用 3 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_3` | 飞书应用 3 App Secret | 飞书开放平台 |
| `FEISHU_APP_ID_4` | 飞书应用 4 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_4` | 飞书应用 4 App Secret | 飞书开放平台 |
| `FEISHU_APP_ID_5` | 飞书应用 5 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_5` | 飞书应用 5 App Secret | 飞书开放平台 |

### 3.3 加载环境变量

```powershell
# Windows PowerShell
Get-Content .env | ForEach-Object {
    if ($_ -match '^([^#=]+)=(.*)$') {
        [Environment]::SetEnvironmentVariable($matches[1], $matches[2], 'User')
    }
}
```

```bash
# macOS / Linux
export $(grep -v '^#' .env | xargs)
# 或写入 shell 配置文件使其持久化：
echo 'export $(grep -v "^#" .env | xargs)' >> ~/.zshrc   # macOS (zsh)
echo 'export $(grep -v "^#" .env | xargs)' >> ~/.bashrc  # Linux
```

---

## Phase 4：Skills 安装清单

### 4.1 System Skills（通过 skillhub 安装）

```bash
# 批量安装
openclaw skillhub install aippt
openclaw skillhub install another_them
openclaw skillhub install cloud-upload-backup
openclaw skillhub install docx
openclaw skillhub install email-skill
openclaw skillhub install fbs_bookwriter
openclaw skillhub install imap-smtp-email
openclaw skillhub install kdocs
openclaw skillhub install mcporter
openclaw skillhub install multi-search-engine
openclaw skillhub install pdf
openclaw skillhub install persona-switch
openclaw skillhub install wecom-weisheng-scrm
openclaw skillhub install xlsx
openclaw skillhub install bdpan-storage
openclaw skillhub install meituan-travel
openclaw skillhub install tencent-esign-contract
openclaw skillhub install tencent-meeting-mcp
openclaw skillhub install weread-skills
openclaw skillhub install tencent-survey
```

### 4.2 Local / Custom Skills（手动创建）

这些 skill 不在公开注册表中，需要手动从备份恢复或重新创建：

| Skill 名称 | 路径 |
|-----------|------|
| agent-development | `~/.openclaw/skills/` + `~/.agents/skills/` |
| agent-evaluation | `~/.openclaw/skills/` + `~/.agents/skills/` |
| agent-manager-skill | `~/.openclaw/skills/` + `~/.agents/skills/` |
| excel-analysis | `~/.openclaw/skills/` + `~/.agents/skills/` |
| find-skills | `~/.openclaw/skills/` + `~/.agents/skills/` |
| ai-engineer | `~/.qclaw/skills/` |
| deepseek-balance | `~/.qclaw/skills/` |
| redbox-xiaohongshu-creator | `~/.qclaw/skills/` |

### 4.3 Bundled Skills（随平台自带，无需安装）

lark-setup / lark-calendar / lark-im / lark-doc / lark-drive / lark-sheets / lark-base / lark-task / lark-mail / lark-contact / lark-wiki / online-search / qclaw-cron-skill / qclaw-env / qclaw-rules / qclaw-text-file / qclaw-skill-creator / skillhub-preference / tencent-docs / qq-email-skill / qclaw-migration / xbrowser

---

## Phase 5：Python 包安装

```bash
pip install -r requirements.txt
# 或 pip3 install -r requirements.txt
```

**当前已安装包（共 62 个）：**

aiohappyeyeballs 2.6.2 / aiohttp 3.13.5 / aiosignal 1.4.0 / annotated-types 0.7.0 / anyio 4.13.0 / attrs 26.1.0 / boto3 1.42.89 / botocore 1.42.97 / certifi 2026.5.20 / cffi 2.0.0 / charset-normalizer 3.4.7 / colorama 0.4.6 / cryptography 48.0.0 / distro 1.9.0 / edge-tts 7.2.7 / fire 0.7.1 / frozenlist 1.8.0 / h11 0.16.0 / httpcore 1.0.9 / httpx 0.28.1 / idna 3.16 / Jinja2 3.1.6 / jiter 0.15.0 / jmespath 1.1.0 / markdown-it-py 4.2.0 / MarkupSafe 3.0.3 / mdurl 0.1.2 / multidict 6.7.1 / openai 2.24.0 / packaging 26.2 / prompt_toolkit 3.0.52 / propcache 0.5.2 / psutil 7.2.2 / pycparser 3.0 / pydantic 2.13.4 / pydantic_core 2.46.4 / PyJWT 2.12.1 / python-dateutil 2.9.0.post0 / python-dotenv 1.2.2 / pytz 2026.2 / PyYAML 6.0.3 / requests 2.33.0 / rich 14.3.3 / ruamel.yaml 0.18.17 / ruamel.yaml.clib 0.2.15 / s3transfer 0.16.1 / setuptools 82.0.1 / six 1.17.0 / sniffio 1.3.1 / socksio 1.0.0 / tabulate 0.10.0 / tenacity 9.1.4 / termcolor 3.3.0 / tqdm 4.67.3 / typing_extensions 4.15.0 / typing-inspection 0.4.2 / tzdata 2025.3 / urllib3 2.7.0 / wcwidth 0.7.0 / wheel 0.47.0

---

## Phase 6：npm 全局包安装

```bash
npm install -g @larksuite/cli@1.0.44
npm install -g @openai/codex@0.133.0
```

> 国内建议使用 nrm 切换镜像后再安装：`nrm use taobao`

---

## Phase 7：Agent 配置

将 `openclaw-config-template.json` 复制到配置目录，并填入真实 Key：

```bash
# Windows
copy openclaw-config-template.json %USERPROFILE%\.qclaw\openclaw.json

# macOS / Linux
cp openclaw-config-template.json ~/.qclaw/openclaw.json
```

| Agent ID | 名称 | 模型 | Workspace |
|----------|------|------|----------|
| main | QClaw | modelroute | `~/.qclaw/workspace` |
| openrouter | OpenRouter | anthropic/claude-opus-4.8 | `~/.qclaw/workspace-openrouter` |
| deepseek-flash | DeepSeek Flash | deepseek/deepseek-chat | `~/.qclaw/workspace-deepseek-flash` |
| deepseek-pro | DeepSeek Pro | deepseek/deepseek-reasoner | `~/.qclaw/workspace-deepseek-pro` |

---

## Phase 8：最终验证

- [ ] `openclaw gateway status` — Gateway 正常运行
- [ ] `openclaw skills list` — 所有 skills 已安装
- [ ] `java -version` — JDK 17 正常
- [ ] `adb --version` — Android SDK 正常
- [ ] `nvm version` — NVM 正常
- [ ] `nrm --version` — NRM 正常
- [ ] `hermes --version` — Hermes CLI 正常
- [ ] `hermes-agent --version` — Hermes Agent 正常
- [ ] `python --version` → 3.12.10
- [ ] `node --version` → v22.16.0
- [ ] `npm --version` → 10.9.8
- [ ] `git --version` → 2.54.0
- [ ] 发送测试消息到微信/飞书，确认 bot 正常响应

---

## 附：一键安装（推荐）

如果不想手动逐步操作，直接用一键安装脚本（自动检测平台）：

```powershell
# Windows (PowerShell)
.\install.ps1

# 预览模式（不实际安装）
.\install.ps1 -DryRun
```

```bash
# macOS / Linux
bash install.sh

# 预览模式（不实际安装）
bash install.sh --dry-run

# 跳过 Python 包
bash install.sh --skip-python

# 跳过 npm 包
bash install.sh --skip-node
```

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
