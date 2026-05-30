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

### 4. 验证

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

## 注意事项

- **API Keys 未包含在本仓库中**，请从 `.env.template` 复制后自行填写
- 仓库设为 **Private**，仅作者可见
- Skills 建议通过各平台按需搜索安装，无需全部预装

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
