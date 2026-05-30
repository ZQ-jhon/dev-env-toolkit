# dev-env-toolkit

一键恢复完整开发环境的工具包，支持 **Windows / macOS / Linux**。

新电脑上 Agent 只需看 **TO-DO-LIST.md**（完整安装清单）或直接运行一键脚本。

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

## 仓库结构

| 文件 | 用途 |
|------|------|
| `TO-DO-LIST.md` | **完整安装清单**（唯一需要人工看的文件） |
| `install.ps1` | Windows 一键安装脚本 |
| `install.sh` | macOS/Linux 一键安装脚本 |
| `README.md` | 本文件（入口说明） |
| `.gitignore` | Git 忽略规则 |

> **不需要**手动安装 Python 包 / npm 包 / skills —— 脚本全自动处理。

---

## 包含内容速览

| 类别 | 内容 |
|------|------|
| **运行环境** | Git, Node.js & npm, Python & pip, NVM, NRM, Hermes Agent, Claude Code |
| **Python 包** | 62 个（openai, boto3, pydantic, requests 等，脚本自动安装） |
| **npm 全局包** | `@larksuite/cli`, `@openai/codex`（脚本自动安装） |
| **OpenClaw** | 配置参考（见 TO-DO-LIST.md Phase 2~3） |
| **Skills** | 19 个（脚本通过 skillhub 自动安装） |
| **常用软件** | Snipaste, Warp, Obsidian, Postman, Edge, VS Code, Sublime Merge, Typeless, CC Switch, Clash Verge, WeType, Raycast(macOS), Charles(Windows) |

---

## 安装步骤概览

详细步骤见 **TO-DO-LIST.md**，脚本一键完成以下所有：

1. **Phase 1** — 基础运行环境（Git / Node.js / Python / NVM / NRM / Hermes / Claude Code）
2. **Phase 2** — OpenClaw 安装与配置
3. **Phase 3** — API Keys 配置（复制模板，手动填 Key）
4. **Phase 4** — Skills 安装（19 个，通过 skillhub）
5. **Phase 5** — Python 包安装（62 个）
6. **Phase 6** — npm 全局包安装
7. **Phase 7** — Agent 配置
8. **Phase 8** — 常用软件安装（见 TO-DO-LIST.md 各平台表格）
9. **Phase 9** — 最终验证

---

## API Keys（脱敏）

所有 Key 均已脱敏，真实值请参照 `TO-DO-LIST.md` Phase 3 创建 `.env` 文件手动填入。

需要的 Key 清单：
- `LLM_BASE_URL` / `LLM_API_KEY` — 内部 LLM 代理
- `OPENROUTER_API_KEY` — https://openrouter.ai/keys
- `DEEPSEEK_API_KEY` — https://platform.deepseek.com
- `WECHAT_WS_URL` — 微信 WebSocket 地址（内部）
- `FEISHU_APP_ID_n` / `FEISHU_APP_SECRET_n` — 飞书应用（最多 5 个）

---

## 常用软件平台支持

| 软件 | Windows | macOS | Linux |
|------|---------|-------|-------|
| Snipaste | ✅ | ✅ | ✅ (AppImage) |
| Warp | ✅ | ✅ | ❌ |
| Obsidian | ✅ | ✅ | ✅ (AppImage) |
| Postman | ✅ | ✅ | ✅ |
| Microsoft Edge | ✅ | ✅ | ✅ |
| VS Code | ✅ | ✅ | ✅ |
| Sublime Merge | ✅ | ✅ | ✅ |
| Typeless | ✅ | ✅ | ✅ |
| CC Switch | ✅ | ✅ | ✅ |
| Clash Verge | ✅ | ✅ | ✅ |
| 微信输入法 (WeType) | ✅ | ❌ | ❌ |
| Raycast | ❌ | ✅ | ❌ |
| Charles | ✅ | ✅ | ❌ |

> 各软件具体安装命令见 TO-DO-LIST.md Phase 8

---

## 注意事项

- 仓库设为 **Private**，仅作者可见
- API Keys **不要**提交到 Git（已加入 `.gitignore`）
- Skills 通过 `openclaw skillhub install` 按需安装，不占用仓库空间
- 新电脑直接 `git clone` + 运行脚本即可，无需参考其他文件

---

**仓库地址**：https://github.com/ZQ-jhon/dev-env-toolkit （Private）
