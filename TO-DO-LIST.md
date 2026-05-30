# 开发环境安装 To-Do List

> 最后更新：2026-05-31
> 适用平台：Windows / macOS / Linux
> **原则：优先使用国内镜像源，镜像不可用时才用官方源**

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

# 配置国内镜像加速（可选，对 GitHub 等境外仓库有效）
git config --global url."https://ghproxy.com/https://github.com/".insteadOf "https://github.com/"
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

# 【国内必做】切换 npm 镜像到淘宝
npm config set registry https://registry.npmmirror.com/
# 或安装 nrm 后切换（推荐）
npm install -g nrm && nrm use taobao

# 验证镜像
npm config get registry
# 应输出：https://registry.npmmirror.com/
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
pip --version      # 或 pip3 --version，当前 26.1.1

# 【国内必做】切换 pip 镜像到清华源
pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/
# 或临时使用：
pip install <package> -i https://pypi.tuna.tsinghua.edu.cn/simple/

# 验证镜像
pip config get global.index-url
```

### 1.4 NVM（Node Version Manager）

| 平台 | 安装方式 |
|------|-----------|
| Windows | 下载 [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) 安装包 |
| macOS/Linux | 见下方【国内镜像】 |

```bash
# 【国内必做】macOS/Linux 安装 NVM 时使用国内 Node 镜像
# 方法 1：安装前设置环境变量
export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash

# 方法 2：安装后配置（已安装 NVM 的情况）
echo 'export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node' >> ~/.zshrc

# 验证
nvm version
# 当前版本（Windows）：1.2.2

nvm install lts
nvm use 22.16.0
```

### 1.5 NRM（npm Registry Manager）

```bash
# 安装（跨平台）
npm install -g nrm

# 验证
nrm --version
# 当前版本：2.1.0

# 【国内推荐】切换到淘宝镜像
nrm use taobao    # https://registry.npmmirror.com/
# 或腾讯镜像
nrm use tencent   # https://mirrors.tencent.com/npm/

# 查看当前使用的镜像
nrm current
```

### 1.6 Hermes Agent

| 平台 | 安装方式 |
|------|----------|
| Windows | `npm install -g hermes` + 按提示安装 hermes-agent（Python venv） |
| macOS | `brew install hermes` 或 `npm install -g hermes` |
| Linux | `npm install -g hermes` |

```bash
# 【国内必做】先切换 npm 镜像
npm config set registry https://registry.npmmirror.com/

npm install -g hermes

# 验证
hermes --version
# 当前版本：0.4.4

hermes-agent --version
# Python 版 hermes-agent（需安装依赖）
pip install websockets -i https://pypi.tuna.tsinghua.edu.cn/simple/
```

> **注意**：如报错 `No module named 'websockets'`，运行：
> ```bash
> pip install websockets -i https://pypi.tuna.tsinghua.edu.cn/simple/
> ```

### 1.7 Claude Code（Anthropic CLI 编程助手）

| 平台 | 安装方式 |
|------|----------|
| Windows | `npm install -g @anthropic-ai/claude-code` |
| macOS | `brew install --cask claude` 或 `npm install -g @anthropic-ai/claude-code` |
| Linux | `npm install -g @anthropic-ai/claude-code` |

```bash
# 【国内必做】先切换 npm 镜像
npm config set registry https://registry.npmmirror.com/
npm install -g @anthropic-ai/claude-code

# 验证
claude --version

# 登录（需要 Anthropic API Key）
claude login

# 使用
claude "帮我写一个 Python 脚本"
```

> **前置要求**：需要 Node.js ≥ 18 和 Anthropic API Key
> 获取 Key：https://console.anthropic.com/

---

## Phase 2：OpenClaw 平台

```bash
# 1. 安装 OpenClaw
#    下载：https://openclaw.ai
#    当前版本：v0.2.23.532
#    国内如下载慢，可使用镜像代理或备用下载地址

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
# 手动创建 .env 文件，内容模板：
cat > ~/.qclaw/.env << 'EOF'
LLM_BASE_URL=<内部提供>
LLM_API_KEY=<内部提供>
OPENROUTER_API_KEY=<从 https://openrouter.ai/keys 获取>
DEEPSEEK_API_KEY=<从 https://platform.deepseek.com 获取>
WECHAT_WS_URL=<内部提供>
FEISHU_APP_ID_1=<飞书开放平台>
FEISHU_APP_SECRET_1=<飞书开放平台>
EOF
```

### 3.2 Key 清单

| 环境变量 | 用途 | 获取地址 |
|-----------|------|-----------|
| `LLM_BASE_URL` | LLM 代理地址 | 内部提供 |
| `LLM_API_KEY` | LLM API Key | 内部提供 |
| `OPENROUTER_API_KEY` | OpenRouter API Key | https://openrouter.ai/keys |
| `DEEPSEEK_API_KEY` | DeepSeek API Key | https://platform.deepseek.com |
| `WECHAT_WS_URL` | 微信 WebSocket 地址 | 内部提供 |
| `FEISHU_APP_ID_n` | 飞书应用 App ID | 飞书开放平台 |
| `FEISHU_APP_SECRET_n` | 飞书应用 App Secret | 飞书开放平台 |

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
# 【国内必做】确保 npm 镜像已切换到国内
npm config set registry https://registry.npmmirror.com/

# 批量安装（skillhub 会自动使用 npm 镜像）
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
# 【国内必做】使用清华 PyPI 镜像
pip install -r -i https://pypi.tuna.tsinghua.edu.cn/simple/ << 'EOF'
aiohappyeyeballs==2.6.2
aiohttp==3.13.5
aiosignal==1.4.0
annotated-types==0.7.0
anyio==4.13.0
attrs==26.1.0
boto3==1.42.89
botocore==1.42.97
certifi==2026.5.20
cffi==2.0.0
charset-normalizer==3.4.7
colorama==0.4.6
cryptography==48.0.0
distro==1.9.0
edge-tts==7.2.7
fire==0.7.1
frozenlist==1.8.0
h11==0.16.0
httpcore==1.0.9
httpx==28.1
idna==3.16
Jinja2==3.1.6
jiter==0.15.0
jmespath==1.1.0
markdown-it-py==4.2.0
MarkupSafe==3.0.3
mdurl==0.1.2
multidict==6.7.1
openai==2.24.0
packaging==26.2
prompt_toolkit==3.0.52
propcache==0.5.2
psutil==7.2.2
pycparser==3.0
pydantic==2.13.4
pydantic_core==2.46.4
PyJWT==2.12.1
python-dateutil==2.9.0.post0
python-dotenv==1.2.2
pytz==2026.2
PyYAML==6.0.3
requests==2.33.0
rich==14.3.3
ruamel.yaml==0.18.17
ruamel.yaml.clib==0.2.15
s3transfer==0.16.1
setuptools==82.0.1
six==1.17.0
sniffio==1.3.1
socksio==1.0.0
tabulate==0.10.0
tenacity==9.1.4
termcolor==3.3.0
tqdm==4.67.3
typing_extensions==4.15.0
typing-inspection==0.4.2
tzdata==2025.3
urllib3==2.7.0
wcwidth==0.7.0
wheel==0.47.0
EOF

# 或先写入 requirements.txt 再安装
pip install -r requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple/
```

> **备选镜像**（如清华源不可用）：
> - 阿里云：`https://mirrors.aliyun.com/pypi/simple/`
> - 腾讯云：`https://mirrors.cloud.tencent.com/pypi/simple/`
> - 华为云：`https://repo.huaweicloud.com/repository/pypi/simple/`

---

## Phase 6：npm 全局包安装

```bash
# 【国内必做】先切换 npm 镜像
npm config set registry https://registry.npmmirror.com/
# 或 nrm use taobao

npm install -g @larksuite/cli@1.0.44
npm install -g @openai/codex@0.133.0
```

> **备选镜像**（如淘宝源不可用）：
> - 腾讯镜像：`https://mirrors.tencent.com/npm/`
> - 华为镜像：`https://repo.huaweicloud.com/repository/npm/`

---

## Phase 7：Agent 配置

将 OpenClaw 配置写入 `~/.qclaw/openclaw.json`（模板见下方）：

```json
{
  "agents": [
    {
      "id": "main",
      "name": "QClaw",
      "model": "modelroute",
      "workspace": "~/.qclaw/workspace"
    },
    {
      "id": "openrouter",
      "name": "OpenRouter",
      "model": "anthropic/claude-opus-4.8",
      "workspace": "~/.qclaw/workspace-openrouter"
    },
    {
      "id": "deepseek-flash",
      "name": "DeepSeek Flash",
      "model": "deepseek/deepseek-chat",
      "workspace": "~/.qclaw/workspace-deepseek-flash"
    },
    {
      "id": "deepseek-pro",
      "name": "DeepSeek Pro",
      "model": "deepseek/deepseek-reasoner",
      "workspace": "~/.qclaw/workspace-deepseek-pro"
    }
  ]
}
```

| Agent ID | 名称 | 模型 | Workspace |
|----------|------|------|----------|
| main | QClaw | modelroute | `~/.qclaw/workspace` |
| openrouter | OpenRouter | anthropic/claude-opus-4.8 | `~/.qclaw/workspace-openrouter` |
| deepseek-flash | DeepSeek Flash | deepseek/deepseek-chat | `~/.qclaw/workspace-deepseek-flash` |
| deepseek-pro | DeepSeek Pro | deepseek/deepseek-reasoner | `~/.qclaw/workspace-deepseek-pro` |

---

## Phase 8：常用软件工具包

> ⚠️ **前提**：请先完成 Phase 1~7 基础环境安装，再执行本 Phase

### 8.1 跨平台软件

| 软件 | Windows | macOS | Linux |
|------|--------|-------|-------|
| **Snipaste**（截图/贴图） | `winget install Snipaste.Snipaste` | [官网](https://www.snipaste.com/download.html) | [AppImage](https://www.snipaste.com/download.html) |
| **Warp**（AI 终端） | `winget install WarpTerminal.Warp` | `brew install --cask warp` | 不支持 |
| **Obsidian**（笔记） | `winget install Obsidian.Obsidian` | `brew install --cask obsidian` | [AppImage](https://obsidian.md/download) |
| **Postman**（API 测试） | `winget install Postman.Postman` | `brew install --cask postman` | [官网](https://www.postman.com/downloads/) |
| **Microsoft Edge**（浏览器） | 已内置 / `winget install Microsoft.Edge` | `brew install --cask microsoft-edge` | [官网](https://www.microsoft.com/edge) |
| **VS Code**（编辑器） | `winget install Microsoft.VisualStudioCode` | `brew install --cask visual-studio-code` | `sudo snap install code --classic` |
| **Sublime Merge**（Git 客户端） | `winget install SublimeHQ.SublimeMerge` | `brew install --cask sublime-merge` | [官网](https://www.sublimemerge.com/download) |
| **Typeless**（AI 语音输入法） | [官网](https://typelesscn.cn/) | [官网](https://typelesscn.cn/) | [官网](https://typelesscn.cn/) |
| **CC Switch**（AI 编程 CLI 管理） | [官网](https://www.ccswitch.io/zh/) | [官网](https://www.ccswitch.io/zh/) | [官网](https://www.ccswitch.io/zh/) |
| **Clash Verge**（代理工具） | [Releases](https://github.com/clash-verge-rev/clash-verge-rev/releases) | `brew install --cask clash-verge-rev` | [Releases](https://github.com/clash-verge-rev/clash-verge-rev/releases) |
| **微信输入法**（电脑版） | [官网](https://zhiwen.weixin.qq.com/) 或 `winget install Tencent.WeType` | 不支持 | 不支持 |

> **国内下载加速**：
> - GitHub Releases 下载慢 → 使用 [https://ghproxy.com/](https://ghproxy.com/) 代理
> - 例如：`https://ghproxy.com/https://github.com/clash-verge-rev/clash-verge-rev/releases/download/v2.1.2/Clash.Verge.Rev_2.1.2_x64-setup.exe`

### 8.2 macOS 专属

| 软件 | 安装方式 |
|------|----------|
| **Raycast**（启动器/效率工具） | `brew install --cask raycast` |
| **微信输入法**（WeType macOS 版） | [Mac App Store](https://apps.apple.com/cn/app/微信输入法/id6478707436) |

> **Homebrew 国内镜像**：如 `brew install` 速度慢，先配置中科大或清华 Homebrew 镜像：
> ```bash
> # 中科大镜像
> export HOMEBREW_BOTTLE_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles
> export HOMEBREW_API_DOMAIN=https://mirrors.ustc.edu.cn/homebrew-bottles/api
> ```

### 8.3 Windows 专属

| 软件 | 安装方式 |
|------|----------|
| **Charles**（HTTP 抓包代理） | `winget install Charles.Charles` 或 [官网](https://www.charlesproxy.com/) |
| **微信输入法**（WeType） | `winget install Tencent.WeType` 或 [官网](https://zhiwen.weixin.qq.com/) |

### 8.4 一键批量安装（可选）

```powershell
# Windows：用 winget 批量安装（winget 源在国内通常可用）
winget install Snipaste.Snipaste WarpTerminal.Warp Obsidian.Obsidian Postman.Postman Microsoft.Edge Clash.Verge.Rev Charles.Charles SublimeHQ.SublimeMerge Tencent.WeType
```

```bash
# macOS：用 brew 批量安装（先配置 Homebrew 国内镜像）
brew install --cask snipaste warp obsidian postman microsoft-edge clash-verge-rev raycast charles visual-studio-code sublime-merge typeless cc-switch
```

---

## Phase 9：最终验证

- [ ] `openclaw gateway status` — Gateway 正常运行
- [ ] `openclaw skills list` — 所有 skills 已安装
- [ ] `nvm version` — NVM 正常
- [ ] `nrm current` — NRM 已切换到国内镜像
- [ ] `hermes --version` — Hermes CLI 正常
- [ ] `hermes-agent --version` — Hermes Agent 正常
- [ ] `npm config get registry` — 输出 `https://registry.npmmirror.com/`
- [ ] `pip config get global.index-url` — 输出 `https://pypi.tuna.tsinghua.edu.cn/simple/`
- [ ] 常用软件均已安装（Snipaste / Warp / Obsidian / Postman / Edge / Clash Verge ...）
- [ ] `python --version` → 3.12.10
- [ ] `node --version` → v22.16.0
- [ ] `npm --version` → 10.9.8
- [ ] `git --version` → 2.54.0
- [ ] 发送测试消息到微信/飞书，确认 bot 正常响应

---

## 附：国内镜像源速查表

| 工具 | 国内镜像地址 | 配置命令 |
|------|-------------|---------|
| **npm** | 淘宝：`https://registry.npmmirror.com/` | `npm config set registry https://registry.npmmirror.com/` |
| **pip** | 清华：`https://pypi.tuna.tsinghua.edu.cn/simple/` | `pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple/` |
| **Node.js (nvm)** | `https://npmmirror.com/mirrors/node` | `export NVM_NODEJS_ORG_MIRROR=https://npmmirror.com/mirrors/node` |
| **Homebrew** | 中科大镜像 | 见 Phase 8.2 |
| **GitHub** | `https://ghproxy.com/` | 在 URL 前加 `https://ghproxy.com/` |

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
