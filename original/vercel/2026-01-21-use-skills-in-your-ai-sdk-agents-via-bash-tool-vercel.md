---
title: "Use skills in your AI SDK agents via bash-tool - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/use-skills-in-your-ai-sdk-agents-via-bash-tool"
date: "2026-01-21"
scraped_at: "2026-03-02T09:22:16.596421914+00:00"
language: "en"
translated: false
description: "Skills support is now available in bash-tool, so your AI SDK agents can use the skills pattern with filesystem context, Bash execution, and sandboxed runtime access."
---




Jan 21, 2026

Skills support is now available in [`bash-tool`](https://www.npmjs.com/package/bash-tool), so your AI SDK agents can use the skills pattern with filesystem context, Bash execution, and sandboxed runtime access.

This gives your agent a consistent way to pull in the right context for a task, using the same isolated execution model that powers filesystem-based context retrieval.

This allows giving your agent access to the [wide variety of publicly available skills](https://skills.sh/), or for you to write your own proprietary skills and privately use them in your agent.

```typescript
import {

2  experimental_createSkillTool as createSkillTool,

3  createBashTool,

4} from "bash-tool";

import { ToolLoopAgent } from "ai";



7// Discover skills and get files to upload

const { skill, files, instructions } = await createSkillTool({

9  skillsDirectory: "./skills",

10});



12// Create bash tool with skill files

const { tools } = await createBashTool({

14  files,

15  extraInstructions: instructions,

16});



18// Use both tools with an agent

const agent = new ToolLoopAgent({

20  model,

21  tools: { skill, ...tools },

22});
```

Example of using skills with bash-tool in an AI SDK ToolLoopAgent

Read the [`bash-tool` changelog](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval) for background and check out [createSkillTool documentation.](https://github.com/vercel-labs/bash-tool?tab=readme-ov-file#skills-experimental)