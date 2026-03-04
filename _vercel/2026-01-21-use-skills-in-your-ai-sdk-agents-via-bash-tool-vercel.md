---
title: "Use skills in your AI SDK agents via bash-tool - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-skills-in-your-ai-sdk-agents-via-bash-tool"
date: "2026-01-21"
scraped_at: "2026-03-02T09:22:16.596421914+00:00"
language: "en-zh"
translated: true
description: "Skills support is now available in bash-tool, so your AI SDK agents can use the skills pattern with filesystem context, Bash execution, and sandboxed runtime access."
---

render_with_liquid: false
Jan 21, 2026

2026 年 1 月 21 日

Skills support is now available in [`bash-tool`](https://www.npmjs.com/package/bash-tool), so your AI SDK agents can use the skills pattern with filesystem context, Bash execution, and sandboxed runtime access.

`bash-tool` 现已支持 Skills 功能，因此您的 AI SDK 智能体可借助该功能，结合文件系统上下文、Bash 命令执行以及沙箱化运行时访问来调用 Skills。

This gives your agent a consistent way to pull in the right context for a task, using the same isolated execution model that powers filesystem-based context retrieval.

这为您的智能体提供了一种统一的方式，使其能够为特定任务准确拉取所需上下文——所采用的正是支撑基于文件系统的上下文检索的同一套隔离执行模型。

This allows giving your agent access to the [wide variety of publicly available skills](https://skills.sh/), or for you to write your own proprietary skills and privately use them in your agent.

这使您的智能体既能接入 [大量公开可用的 Skills](https://skills.sh/)，也可由您自行开发专有 Skills，并在您的智能体中私有化使用。

```typescript
import {

2  experimental_createSkillTool as createSkillTool,

3  createBashTool,

4} from "bash-tool";

import { ToolLoopAgent } from "ai";
```

7// Discover skills and get files to upload

7// 发现技能并获取待上传的文件

const { skill, files, instructions } = await createSkillTool({

const { skill, files, instructions } = await createSkillTool({

9  skillsDirectory: "./skills",

9  skillsDirectory: "./skills",

10});

10});

12// Create bash tool with skill files

12// 使用技能文件创建 Bash 工具

const { tools } = await createBashTool({

const { tools } = await createBashTool({

14  files,

14  files,

15  extraInstructions: instructions,

15  extraInstructions: instructions,

16});

16});

18// Use both tools with an agent

18// 使用工具与智能体协同工作

const agent = new ToolLoopAgent({

const agent = new ToolLoopAgent({

20  model,

20  model,

21  tools: { skill, ...tools },

21  tools: { skill, ...tools },

22});

22});

Example of using skills with bash-tool in an AI SDK ToolLoopAgent

在 AI SDK 的 ToolLoopAgent 中结合使用技能（skills）与 bash-tool 的示例

Read the [`bash-tool` changelog](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval) for background and check out [createSkillTool documentation.](https://github.com/vercel-labs/bash-tool?tab=readme-ov-file#skills-experimental)

请参阅 [`bash-tool` 更新日志](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval) 了解背景信息，并查阅 [createSkillTool 文档](https://github.com/vercel-labs/bash-tool?tab=readme-ov-file#skills-experimental)。