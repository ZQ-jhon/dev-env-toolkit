# dev-env-toolkit

一键恢复完整开发环境的工具包，支持 **Windows / macOS / Linux**。

---

## 包含内容

| 类别 | 内容 |
|------|------|
| **运行环境** | Git, Node.js & npm, Python & pip, JDK 17, Android SDK (adb), NVM, NRM |
| **Python 包** | 62 个（见 `requirements.txt`，含 openai, boto3, pydantic 等） |
| **npm 全局包** | `@larksuite/cli`, `@openai/codex` |
| **OpenClaw** | v0.2.23.532 配置模板 + skills 清单 |
| **一键脚本** | `install.ps1`（Windows）+ `install.sh`（macOS/Linux） |
| **常用软件** | Snipaste, Warp, Obsidian, Postman, Edge, Clash Verge, VS Code, Raycast(macOS), CC Switch(Windows), Charles, Typeless(Windows), WeType(Windows) |

> Skills 可从公开平台按需实时下载，本仓库不存储 `.skill` 文件。

---

## 快速开始

```bash
git clone https://github.com/ZQ-jhon/dev-env-toolkit.git
cd dev-env-toolkit

# Windows
.\install.ps1

# macOS / Linux
bash install.sh

# 仅预览，不实际安装
.\install.ps1 -DryRun
bash install.sh --dry-run
```

---

## 安装步骤

### 1. 基础环境

| 工具 | Windows | macOS | Linux |
|------|--------|-------|-------|
| Git | `winget install Git.Git` | `brew install git` | `sudo apt install git` |
| Node.js & npm | `winget install OpenJS.NodeJS` | `brew install node` | `sudo apt install nodejs npm` |
| Python & pip | `winget install Python.Python.3` | `brew install python@3.12` | `sudo apt install python3 python3-pip` |
| JDK 17 | `winget install EclipseAdoptium.Temurin.17JDK` | `brew install openjdk@17` | `sudo apt install openjdk-17-jdk` |
| Android SDK | [下载 Command-line Tools](https://developer.android.com/studio#command-line-tools) | `brew install android-commandlinetools` | 手动下载配置 `ANDROID_HOME` |
| NVM | [nvm-windows](https://github.com/coreybutler/nvm-windows/releases) | `curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh \| bash` | 同 macOS |
| NRM | `npm install -g nrm` | 同 Windows | 同 Windows |
| Hermes Agent | `npm install -g hermes` | `brew install hermes` 或 `npm install -g hermes` | `npm install -g hermes` |
| Claude Code | `npm install -g @anthropic-ai/claude-code` | `brew install anthropic/claude/claude` | `npm install -g @anthropic-ai/claude-code` |

### 2. 配置 API Keys

```bash
cp .env.template .env
# 编辑 .env，填入真实 Key
```

### 3. 运行安装脚本

```powershell
# Windows
.\install.ps1
```

```bash
# macOS / Linux
bash install.sh
```

脚本会自动检测平台，安装缺失的工具，恢复 Python/npm 包。

### 4. 安装常用软件

| 软件 | Windows | macOS | Linux |
|------|--------|-------|------|
| Snipaste | `winget install Snipaste.Snipaste` | [官网](https://www.snipaste.com/) | [AppImage](https://www.snipaste.com/) |
| Warp | `winget install WarpTerminal.Warp` | `brew install --cask warp` | 不支持 |
| Obsidian | `winget install Obsidian.Obsidian` | `brew install --cask obsidian` | [AppImage](https://obsidian.md/) |
| Postman | `winget install Postman.Postman` | `brew install --cask postman` | [官网](https://www.postman.com/) |
| Edge | `winget install Microsoft.Edge` | `brew install --cask microsoft-edge` | [官网](https://www.microsoft.com/edge) |
| Clash Verge | `winget install Clash.Verge.Rev` | `brew install --cask clash-verge-rev` | [下载](https://github.com/clash-verge-rev/clash-verge-rev/releases) |
| **VS Code** | `winget install Microsoft.VisualStudioCode` | `brew install --cask visual-studio-code` | `sudo snap install code --classic` |
| Raycast | 不支持 | `brew install --cask raycast` | 不支持 |
| CC Switch | `winget install CCSwitch` | 不支持 | 不支持 |
| Charles | `winget install Charles.Charles` | `brew install --cask charles` | 不支持 |
| Typeless | [Store](https://apps.microsoft.com/store/detail/typeless/) | 不支持 | 不支持 |
| **微信输入法（WeType）** | [官网](https://zhiwen.weixin.qq.com/) 或 `winget install Tencent.WeType` | 不支持 | 不支持 |

> ⚠️ 软件安装前请先完成基础环境（Phase 1~8）

### 5. 验证

```bash
node --version && npm --version
python --version && pip --version
java -version
adb --version
openclaw gateway status
```

---

## 文件说明

| 文件 | 用途 |
|------|------|
| `install.ps1` | Windows 一键安装脚本 |
| `install.sh` | macOS/Linux 一键安装脚本 |
| `requirements.txt` | Python pip 包列表（`pip freeze`） |
| `npm-global.txt` | npm 全局包列表 |
| `.env.template` | API Key 模板（复制为 `.env` 后填写） |
| `openclaw-config-template.json` | OpenClaw 配置模板（API Key 已脱敏） |
| `TO-DO-LIST.md` | 完整安装 Checklist（跨平台） |
| `setup-guide.md` | 详细安装指南 |
| `skills-manifest.json` | Skills 版本清单（供参考，无需手动安装） |

---

## 常用软件一览

| 软件 | 用途 | 平台 |
|------|------|------|
| Snipaste | 截图/贴图 | Windows / macOS / Linux |
| Warp | AI 终端增强 | Windows / macOS |
| Obsidian | Markdown 笔记 | Windows / macOS / Linux |
| Postman | API 接口测试 | Windows / macOS / Linux |
| Microsoft Edge | 浏览器 | Windows / macOS / Linux |
| Clash Verge | 代理 / 科学上网 | Windows / macOS / Linux |
| Raycast | 启动器/效率工具 | macOS only |
| CC Switch | 剪贴板管理 | Windows only |
| Charles | HTTP 抓包代理 | Windows / macOS |
| **VS Code** | 代码编辑器 | Windows / macOS / Linux |
| **微信输入法** | 中文输入法 | Windows only |
| Typeless | 打字统计 | Windows only |

---

## 注意事项

- **API Keys 未包含在本仓库中**，请从 `.env.template` 复制后自行填写
- 仓库设为 **Private**，仅作者可见
- Skills 建议通过各平台按需搜索安装，无需全部预装

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
