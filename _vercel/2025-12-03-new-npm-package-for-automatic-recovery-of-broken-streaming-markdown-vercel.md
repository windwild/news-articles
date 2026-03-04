---
render_with_liquid: false
title: "New npm package for automatic recovery of broken streaming markdown - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/new-npm-package-for-automatic-recovery-of-broken-streaming-markdown"
date: "2025-12-03"
scraped_at: "2026-03-02T09:24:33.617829352+00:00"
language: "en-zh"
translated: true
description: "A new standalone package that brings Streamdown's intelligent incomplete Markdown handling to any application. "
---
render_with_liquid: false
render_with_liquid: false

Dec 3, 2025

2025年12月3日

[Remend](https://www.npmjs.com/package/remend) 是一个全新的独立软件包，可为任意应用提供智能的不完整 Markdown 处理能力。

Remend 原先内置于 [Streamdown](https://streamdown.ai/) 的 Markdown 终止逻辑中，如今已作为独立库发布（`npm i remend`），可供任何应用直接集成使用。

### 为何重要

AI 模型以逐 token 流式输出 Markdown，此过程常生成语法不完整的片段，从而导致渲染失败。例如：

- 未闭合的代码围栏（fences）

- 未完成的粗体/斜体标记

- 未终止的链接或列表


若不加以修正，此类不完整模式将导致渲染失败、原始 Markdown 泄露，或破坏页面布局：

```markdown
1**This is bold text
```

2[Click here](https://exampl

2[点击此处](https://exampl

3`const foo = "bar
```

3`const foo = "bar
```

Remend automatically detects and completes unterminated Markdown blocks, ensuring clean, stable output during streaming.

Remend 自动检测并补全未闭合的 Markdown 区块，确保在流式输出过程中生成整洁、稳定的文本。

```typescript
import remend from "remend";



const partialMarkdown = "This is **bold text";

const completed = remend(partialMarkdown);



6// Result: "This is **bold text**"
```

```typescript
import remend from "remend";



const partialMarkdown = "This is **bold text";

const completed = remend(partialMarkdown);



6// 结果："This is **bold text**"
```

As the stream continues and the actual closing markers arrive, the content seamlessly updates, giving users a polished experience even mid-stream.

随着数据流持续进行，实际的闭合标记陆续到达，内容将无缝更新，即使在流式传输中途，也能为用户提供精炼流畅的体验。

It works with any Markdown renderer as a pre-processor. For example:

它可作为预处理器，与任意 Markdown 渲染器配合使用。例如：

```typescript
import remend from "remend";

import { unified } from "unified";

import remarkParse from "remark-parse";

import remarkRehype from "remark-rehype";

import rehypeStringify from "rehype-stringify";



const streamedMarkdown = "This is **incomplete bold";



9// Run Remend first to complete incomplete syntax
9// 首先运行 Remend，以补全不完整的语法
```

```javascript
const completedMarkdown = remend(streamedMarkdown);



12// Then process with unified

12// 然后使用 unified 进行处理

const file = await unified()

14  .use(remarkParse)

15  .use(remarkRehype)

16  .use(rehypeStringify)

17  .process(completedMarkdown);



console.log(String(file));
```

Remend powers the markdown rendering in Streamdown and has been battle-tested in production AI applications. It includes intelligent rules to avoid false positives and handles complex edge cases like:

Remend 为 Streamdown 提供 Markdown 渲染能力，并已在生产环境的 AI 应用中经过充分验证。它内置智能规则，可有效避免误报，并能妥善处理以下复杂边界情况：

- LaTeX 块中的含下划线数学表达式  
- 含星号/下划线的产品编号与变量名  
- 带格式标记的列表项  
- 链接中的嵌套方括号  

To get started, either use it through [Streamdown](https://www.npmjs.com/package/streamdown) or install it standalone with:

如需快速开始，您可通过 [Streamdown](https://www.npmjs.com/package/streamdown) 使用 Remend，或直接独立安装：

```bash
npm i remend
```