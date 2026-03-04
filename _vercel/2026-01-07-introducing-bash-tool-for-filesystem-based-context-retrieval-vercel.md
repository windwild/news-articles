---
title: "Introducing bash-tool for filesystem-based context retrieval - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval"
date: "2026-01-07"
scraped_at: "2026-03-02T09:23:06.300102480+00:00"
language: "en-zh"
translated: true
description: "We've open-sourced bash-tool, which gives your agent a way to find the right context by running bash-like commands over files, then returning only the results of those tool calls to the model."
---
{% raw %}

Jan 7, 2026

2026 年 1 月 7 日

我们开源了 `bash-tool`——这是 [我们近期重构的文本到 SQL 智能体（text-to-SQL agent）](https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools) 所使用的 Bash 执行引擎，旨在降低 token 消耗、提升智能体响应的准确性，并整体增强其性能。

[`bash-tool`](https://www.npmjs.com/package/bash-tool) 为您的智能体提供了一种通过在文件上运行类 Bash 命令来精准定位上下文的能力，随后仅将这些工具调用的结果返回给大语言模型。

若在提示词（prompt）中直接嵌入大量文本，上下文窗口会迅速被占满。而智能体通常在类 Unix 工作流（如 `find`、`grep`、`jq` 及管道操作）中表现优异；借助 `bash-tool`，您现在可将海量上下文**本地化存储于文件系统中**，并让智能体按需调用这些命令，动态提取更小、更相关的上下文片段。

`bash-tool` 为基于 [AI SDK](https://ai-sdk.dev/) 构建的智能体提供了 `bash`、`readFile` 和 `writeFile` 三类工具，兼容内存内（in-memory）与沙箱（sandboxed）两种运行环境，且具备以下特性：

- 基于 [`just-bash`](https://justbash.dev/) 构建，该库可在 TypeScript 中直接解释执行 Bash 脚本，**无需启动 shell 进程，亦不执行任意二进制程序**；  
- 启动时即可预加载文件系统，使智能体在需要时直接搜索本地文件，**无需将全部内容粘贴进 prompt**；  
- 支持在内存中运行，也支持在自定义的隔离虚拟机（VM）中运行。

agent.ts

```typescript
import { createBashTool } from "bash-tool";
```

```typescript
const { tools } = await createBashTool({

4  files: { "src/index.ts": "export const hello = 'world';" },

5});



const agent = new ToolLoopAgent({ model, tools });
```

```typescript
const { tools } = await createBashTool({

4  文件：{ "src/index.ts": "export const hello = 'world';" },

5});



const agent = new ToolLoopAgent({ model, tools });
```

Using bash-tool with an in-memory filesystem

使用基于内存的文件系统的 bash-tool

If you need a real shell, a real filesystem, or custom binaries, you can run the same tool against a Sandbox-compatible API for full VM isolation.

如果您需要真实的 shell、真实的文件系统，或自定义二进制程序，您可以将同一工具对接支持 Sandbox 的 API，以实现完整的虚拟机隔离。

agent.ts

agent.ts

```typescript
import { createBashTool } from "bash-tool";
```

```typescript
import { createBashTool } from "bash-tool";
```

```typescript
import { Sandbox } from "@vercel/sandbox";

const sandbox = await Sandbox.create();



const { tools } = await createBashTool({ sandbox });



const agent = new ToolLoopAgent({ model, tools });
```

```typescript
import { Sandbox } from "@vercel/sandbox";

const sandbox = await Sandbox.create();



const { tools } = await createBashTool({ sandbox });



const agent = new ToolLoopAgent({ model, tools });
```

Using bash-tool with a Vercel sandbox

使用 bash-tool 与 Vercel 沙箱

[**Try bash-tool in your agent**  
**在您的智能体中试用 bash-tool**  
\\  
Install the package along with AI SDK v6, and start building your file system agent.  
安装该软件包以及 AI SDK v6，并开始构建您的文件系统智能体。  
\\  
Get started  
立即开始](https://www.npmjs.com/package/bash-tool)
{% endraw %}
