# Obsidian Flavored Markdown 规范

创建任何 .md 文件时遵循以下规范。

## Frontmatter 格式

```yaml
---
tags:
  - <module-tag>
  - <type-tag>
  - draft
created: YYYY-MM-DD
---
```

## 文档类型与字数

| 类型 | tag | 字数 | 用途 |
|------|-----|------|------|
| 快速参考卡 | `quick-ref` | 300-800 字 | 代码示例、对比表格，速查用 |
| 学习笔记 | `notes` | 800-1500 字 | 概念理解，含原理和使用场景 |
| 深度研究 | `deep-dive` | ≤1500 字 | 难点、核心机制深度分析 |

## Wikilink 格式

- 模块间引用：`[[模块目录/文件名]]`
- 同模块引用：`[[文件名]]`
- 模块导航引用：`[[模块目录/README]]`

## Callout 格式

```
> [!NOTE] 标题
> 内容

> [!WARNING] 注意
> 内容

> [!TIP] 技巧
> 内容
```

## 目录规范

- 模块目录使用数字前缀：`01-xxx/`、`02-xxx/`
- 每个模块必须有 `README.md`，列出该模块所有文件的 wikilink
- 图片/附件统一放 `_assets/`
- 文档模板统一放 `_templates/`
- 索引文件统一放 `00-index/`

## 语言规范

- 文件命名：中文（如 `所有权概念.md`、`生命周期速查.md`）
- Frontmatter tags：英文小写（如 `ownership`、`quick-ref`）
- 正文：中文叙述 + 英文技术术语

## 更新迭代流程

1. 更新某模块前，**先读取该模块的 `README.md`** 了解已有文件，避免重复创建
2. 补充新知识点：在对应模块目录下创建新文件
3. 完善已有文档：直接编辑，遵守字数上限，单一知识点
4. 每次新增文件后，同步更新：
   - 所在模块的 `README.md`（添加 wikilink）
   - `00-index/知识图谱.md`（添加 wikilink）
