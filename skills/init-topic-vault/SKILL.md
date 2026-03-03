---
name: init-topic-vault
description: "Initialize a complete Obsidian learning vault in the current directory for any topic. Use when starting a new Obsidian knowledge base for learning or research. Invoke with /obsidian-lab:init-topic-vault \"主题名\" to automatically plan modules, create directory structure, and generate a CLAUDE.md configuration file."
---

# Obsidian 主题学习知识库初始化

用户正在当前目录初始化一个全新的 Obsidian 学习知识库。

## 第一步：依赖检测

运行 `scripts/check_deps.sh` 检测依赖：

```bash
bash ~/.claude/plugins/obsidian-lab/skills/init-topic-vault/scripts/check_deps.sh
```

- **输出 `all_deps_ok`（exit 0）** → 执行下方"完整流程"
- **输出 `deps_missing`（exit 1）** → 告知用户缺少哪些 plugin，执行下方"降级流程"

---

## 完整流程（all_deps_ok）

注入以下上下文后调用 `superpowers:brainstorming`：

> 我们正在为 **[主题名]** 初始化一个 Obsidian 学习知识库。
>
> **约束条件：**
> - 这是个人学习知识库，不是软件项目
> - 模块使用数字前缀目录（`01-xxx/`），建议 5-8 个模块
> - 每个模块规划初始文档：至少 1 篇 quick-ref + 1 篇 notes，核心模块可加 deep-dive
> - 最终产物：目录结构 + CLAUDE.md + 各模块 README + 初始文档骨架
> - 不涉及技术架构、测试、CI/CD 等软件工程概念
>
> **brainstorming 输出：**
> 1. 模块列表（带数字前缀和中文名）
> 2. 每个模块的初始文档清单（文件名 + 类型 quick-ref/notes/deep-dive）
> 3. 学习路径建议（模块学习顺序）
> 4. 知识图谱结构（模块间依赖关系）

brainstorming 完成后自动调用 `superpowers:writing-plans`，生成包含所有文件路径和内容的执行计划。

---

## 降级流程（deps_missing）

**Obsidian 规范：** 参考 [references/obsidian-conventions.md](references/obsidian-conventions.md)

### 1. 规划模块

根据主题分析，生成 5-8 个模块，每个模块包含：
- 数字前缀目录名（如 `01-基础概念/`）
- 初始文档清单（至少 1 quick-ref + 1 notes）

展示模块列表，等待用户确认。

### 2. 创建文件结构

用户确认后，按以下结构创建（遵循 obsidian-conventions.md 中的文档规范）：

```
<当前目录>/
├── 00-index/
│   ├── 知识图谱.md      ← 列出所有模块的 wikilink
│   └── 学习路径.md      ← 建议的学习顺序
├── 01-<模块名>/
│   ├── README.md        ← 模块导航，列出所有文件 wikilink
│   └── <初始文档>.md
├── 02-<模块名>/
│   └── ...
├── _assets/
├── _templates/
└── CLAUDE.md
```

### 3. 生成 CLAUDE.md

读取 `assets/CLAUDE.md.template`（路径：`~/.claude/plugins/obsidian-lab/skills/init-topic-vault/assets/CLAUDE.md.template`），替换占位符：
- `{{TOPIC}}` → 实际主题名
- `{{MODULES}}` → 根据模块列表生成的 tag 英文值（如 `basics` `ownership` `lifetime`）
