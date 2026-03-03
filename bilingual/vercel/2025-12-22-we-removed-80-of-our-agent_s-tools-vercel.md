---
title: "We removed 80% of our agent’s tools - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools"
date: "2025-12-22"
scraped_at: "2026-03-02T09:23:18.767206749+00:00"
language: "en-zh"
translated: true
description: "We spent months building a sophisticated text-to-sql agent, but as it turns out, sometimes simpler is better. Giving it the ability to execute arbitrary bash commands outperformed everything we built...."
---

Dec 22, 2025

2025 年 12 月 22 日

It got better.

它变得更出色了。

我们花了数月时间构建了一个精密的内部文本到 SQL（text-to-SQL）智能体 d0，该智能体配备了专用工具、大量提示工程（prompt engineering）以及精细的上下文管理。它确实“能运行”……但仅限于某种程度。然而，它十分脆弱、响应缓慢，且需要持续维护。

So we tried something different. We deleted most of it and stripped the agent down to a single tool: execute arbitrary bash commands. We call this a file system agent. Claude gets direct access to your files and figures things out using `grep`, `cat`, and `ls`.

于是我们尝试了一种不同的思路：删除了其中大部分组件，将该智能体精简为仅含一个工具——执行任意 Bash 命令。我们称其为“文件系统智能体”（file system agent）。Claude 可直接访问你的文件，并借助 `grep`、`cat` 和 `ls` 等命令自主推理与分析。

The agent got simpler and better at the same time. 100% success rate instead of 80%. Fewer steps, fewer tokens, faster responses. All by doing less.

智能体反而变得更简单、更强大：成功率从 80% 提升至 100%；步骤更少、Token 消耗更少、响应更快——这一切，恰恰源于“做更少”。

## What is d0

## d0 是什么？

If [v0](https://v0.app/) is our AI for building UI, d0 is our AI for understanding data.

如果说 [v0](https://v0.app/) 是我们用于构建用户界面（UI）的 AI，那么 d0 就是我们用于理解数据的 AI。

![d0 enables anyone to make data-driven decisions by asking it questions in Slack](images/we-removed-80-of-our-agent_s-tools-vercel/img_001.jpg)![d0 enables anyone to make data-driven decisions by asking it questions in Slack](images/we-removed-80-of-our-agent_s-tools-vercel/img_002.jpg)

![d0 enables anyone to make data-driven decisions by asking it questions in Slack](images/we-removed-80-of-our-agent_s-tools-vercel/img_001.jpg)![d0 enables anyone to make data-driven decisions by asking it questions in Slack](images/we-removed-80-of-our-agent_s-tools-vercel/img_002.jpg)

d0 enables anyone to make data-driven decisions by asking it questions in Slack

d0 让团队中任何人都能通过在 Slack 中向它提问，轻松做出数据驱动的决策。

d0 translates natural language questions into SQL queries against our analytics infrastructure, letting anyone on the team get answers without writing code or waiting on the data team.

d0 将自然语言问题自动翻译为针对我们分析基础设施的 SQL 查询，使团队中任何成员都无需编写代码，也无需等待数据团队，即可即时获取答案。

When d0 works well, it democratizes data access across the company. When it breaks, people lose trust and go back to pinging analysts in Slack. We need d0 to be fast, accurate, and reliable.

当 d0 运行良好时，它能将数据访问权限普及至全公司；而一旦出现故障，用户便会失去信任，重新转而通过 Slack 直接联系分析师。因此，d0 必须做到快速、准确且可靠。

## Getting out of the model's way

## 为模型“让路”

Looking back, we were solving problems the model could handle on its own. We assumed it would get lost in complex schemas, make bad joins, or hallucinate table names. So we built guardrails. We pre-filtered context, constrained its options, and wrapped every interaction in validation logic. We were doing the model’s thinking for it:

回溯过往，我们一直在替模型解决本可由其自主处理的问题。我们曾假设模型会在复杂的 Schema 中迷失方向、生成错误的 JOIN 条件，或“幻觉”出根本不存在的表名。于是我们为其设置了层层护栏：预先过滤上下文、严格限制其可选操作，并在每次交互中嵌入验证逻辑——本质上，我们在代替模型进行思考：

- Built multiple specialized tools (schema lookup, query validation, error recovery, etc.)

- 构建了多个专用工具（如 Schema 查询、SQL 查询校验、错误恢复等）

- Added heavy prompt engineering to constrain reasoning

- 投入大量精力进行提示词工程，以约束模型的推理路径

- Utilized careful context management to avoid overwhelming the model

- 精心设计上下文管理策略，避免信息过载压垮模型

- Wrote hand-coded retrieval to surface “relevant” schema information and dimensional attributes

- 手动编写检索逻辑，以提取“相关”的 Schema 信息与维度属性

Every edge case meant another patch, and every model update meant re-calibrating our constraints. We were spending more time maintaining the scaffolding than improving the agent.

每一个边缘情况都意味着一次补丁更新，每一次模型升级都要求我们重新校准所有约束条件。我们花在维护这些“脚手架”上的时间，远超于真正提升智能体本身能力的时间。

ai-sdk@6.0.0-beta.160 ToolLoopAgent

ai-sdk@6.0.0-beta.160 ToolLoopAgent

```typescript
import { ToolLoopAgent } from 'ai';
```

```typescript
import { GetEntityJoins, LoadCatalog, /*...*/ } from '@/lib/tools'

import { GetEntityJoins, LoadCatalog, /*...*/ } from '@/lib/tools'

const agent = new ToolLoopAgent({

const agent = new ToolLoopAgent({

4  model: "anthropic/claude-opus-4.5",

4  model: "anthropic/claude-opus-4.5",

5  instructions: "",

5  instructions: "",

6  tools: {

6  tools: {

7      GetEntityJoins, LoadCatalog, RecallContext, LoadEntityDetails,

7      GetEntityJoins, LoadCatalog, RecallContext, LoadEntityDetails,

8      SearchCatalog, ClarifyIntent, SearchSchema, GenerateAnalysisPlan,

8      SearchCatalog, ClarifyIntent, SearchSchema, GenerateAnalysisPlan,

9      FinalizeQueryPlan, FinalizeNoData, JoinPathFinder, SyntaxValidator,

9      FinalizeQueryPlan, FinalizeNoData, JoinPathFinder, SyntaxValidator,

10      FinalizeBuild, ExecuteSQL, FormatResults, VisualizeData, ExplainResults

10      FinalizeBuild, ExecuteSQL, FormatResults, VisualizeData, ExplainResults

11    },

11    },
```

12});
```

## A new idea, what if we just… stopped?

## 一个新想法：如果我们干脆……停下来呢？

We realized we were fighting gravity. Constraining the model’s reasoning. Summarizing information that it could read on its own. Building tools to protect it from complexity that it could handle.

我们意识到自己正在“对抗重力”：限制模型的推理能力，总结它本可自主阅读的信息，构建工具来保护它免受它本可应对的复杂性影响。

So we stopped. The hypothesis was, what if we just give Claude access to the raw Cube DSL files and let it cook? What if bash is all you need? Models are getting smarter and context windows are getting larger, so maybe the best agent architecture is almost no architecture at all.

于是我们停下了。我们的假设是：如果直接让 Claude 访问原始的 Cube DSL 文件，让它自由发挥，会怎样？如果仅靠 bash 就已足够，又会怎样？模型正变得越来越聪明，上下文窗口也越来越大，因此，或许最优秀的智能体（agent）架构，恰恰是几乎“零架构”。

### v2: The file system is the agent

### v2：文件系统即智能体

**The new stack:**

**新技术栈：**

- **Model:** Claude Opus 4.5 via the [AI SDK](https://ai-sdk.dev/)

- **模型：** 通过 [AI SDK](https://ai-sdk.dev/) 调用的 Claude Opus 4.5

- **Execution:** [Vercel Sandbox](https://vercel.com/sandbox) for context exploration

- **执行环境：** [Vercel Sandbox](https://vercel.com/sandbox)，用于上下文探索

- **Routing:** [Vercel Gateway](https://vercel.com/ai-gateway) for request handling and observability

- **路由层：** [Vercel Gateway](https://vercel.com/ai-gateway)，用于请求处理与可观测性

- **Server:** Next.js API route using [Vercel Slack Bolt](https://vercel.com/academy/slack-agents)

- **服务端：** 基于 [Vercel Slack Bolt](https://vercel.com/academy/slack-agents) 的 Next.js API 路由

- **Data layer:** Cube semantic layer as a directory of YAML, Markdown, and JSON files  
- **数据层：** Cube 语义层，以 YAML、Markdown 和 JSON 文件组成的目录形式存在  

The file system agent now browses our semantic layer the way a human analyst would. It reads files, greps for patterns, builds mental models, and writes SQL using standard Unix tools like `grep`, `cat`, `find`, and `ls`.  
文件系统代理如今能像人类分析师一样浏览我们的语义层：它读取文件、用 `grep` 搜索模式、构建思维模型，并借助标准 Unix 工具（如 `grep`、`cat`、`find` 和 `ls`）编写 SQL。  

This works because the semantic layer is already great documentation. The files contain dimension definitions, measure calculations, and join relationships. We were building tools to summarize what was already legible. Claude just needed access to read it directly.  
这一方案之所以可行，是因为语义层本身已是极佳的文档：其中的文件已包含维度定义、度量计算逻辑以及表连接关系。我们此前开发的工具，本意是汇总那些本就清晰可读的内容；而 Claude 所需的，仅仅是直接读取这些文件的权限。  

ai-sdk@6.0.0 ToolLoopAgent  
ai-sdk@6.0.0 ToolLoopAgent  

```typescript
import { Sandbox } from "@vercel/sandbox";

import { files } from './semantic-catalog'

import { tool, ToolLoopAgent } from "ai";

import { ExecuteSQL } from "@/lib/tools";}



const sandbox = await Sandbox.create();
```

```javascript
await sandbox.writeFiles(files);
```

```javascript
await sandbox.writeFiles(files);
```

```javascript
const executeCommandTool(sandbox: Sandbox) {

10  return tool({

11    /* ... */

12    execute: async ({ command }) => {

13      const result = await sandbox.exec(command);

14      return { /* */ };

15    }

16  })
```

```javascript
const executeCommandTool(sandbox: Sandbox) {

10  return tool({

11    /* ... */

12    execute: async ({ command }) => {

13      const result = await sandbox.exec(command);

14      return { /* */ };

15    }

16  })
```

17}



const agent = new ToolLoopAgent({

20  model: "anthropic/claude-opus-4.5",

20  模型："anthropic/claude-opus-4.5"，

21  instructions: "",

21  指令：""，

22  tools: {

22  工具：{

23    ExecuteCommand: executeCommandTool(sandbox),

23    ExecuteCommand：executeCommandTool(sandbox)，

24    ExecuteSQL,

24    ExecuteSQL，

25   },

25   }，

26})

## 3.5x faster, 37% fewer tokens, 100% success rate

## 速度快 3.5 倍，Token 使用量减少 37%，成功率 100%

We benchmarked the old architecture against the new file system approach across 5 representative queries.

我们针对 5 个具有代表性的查询，将旧架构与新的文件系统方法进行了基准测试。

|     |     |     |     |
| --- | --- | --- | --- |
| **Metric** | **Advanced (old)** | **File system (new)** | **Change** |
| **指标** | **高级模式（旧）** | **文件系统模式（新）** | **变化** |
| Avg execution time | 274.8s | 77.4s | 3.5x faster |
| 平均执行时间 | 274.8 秒 | 77.4 秒 | 快 3.5 倍 |
| Success rate | 4/5 (80%) | 5/5 (100%) | +20% |
| 成功率 | 4/5（80%） | 5/5（100%） | +20% |
| Avg token usage | ~102k tokens | ~61k tokens | 37% fewer tokens |
| 平均 Token 使用量 | 约 102,000 个 Token | 约 61,000 个 Token | 减少 37% 的 Token |
| Avg steps | ~12 steps | ~7 steps | 42% fewer steps |
| 平均步骤数 | 约 12 步 | 约 7 步 | 减少 42% 的步骤 |

The file system agent won every comparison. The old architecture’s worst case took 724 seconds, 100 steps, and 145,463 tokens before failing. The file system agent completed the same query in 141 seconds with 19 steps and 67,483 tokens, and it actually succeeded.

文件系统智能体在每一项对比中均胜出。旧架构最差的一次尝试耗时 724 秒、执行 100 步、消耗 145,463 个 Token 后仍以失败告终；而文件系统智能体仅用 141 秒、19 步、67,483 个 Token 就完成了同一查询，并且成功达成目标。

The qualitative shift matters just as much. The agent catches edge cases we never anticipated and explains its reasoning in ways we can follow.

这种质的转变同样重要。该智能体能捕捉到我们从未预见到的边界情况，并以我们可理解的方式清晰阐释其推理过程。

### Lessons learned

### 经验总结

**Don’t fight gravity.** File systems are an incredibly powerful abstraction. Grep is 50 years old and still does exactly what we need. We were building custom tools for what Unix already solves.

**勿逆“重力”而行。** 文件系统是一种极其强大的抽象机制。`grep` 工具已有 50 年历史，却依然精准满足我们的需求。我们曾为 Unix 系统早已解决的问题，重复开发定制化工具。

**We were constraining reasoning because we didn’t trust the model to reason.** With Opus 4.5, that constraint became a liability. The model makes better choices when we stop making choices for it.

**我们曾因不信任模型的推理能力，而人为限制其推理空间。** 在 Opus 4.5 版本下，这种限制反而成了负担。当我们不再越俎代庖替模型做决策时，模型自身反而能做出更优选择。

**This only worked because our semantic layer was already good documentation.** The YAML files are well-structured, consistently named, and contain clear definitions. If your data layer is a mess of legacy naming conventions and undocumented joins, giving Claude raw file access won’t save you. You’ll just get faster bad queries.

**这一方案之所以奏效，前提是我们的语义层本身已是高质量的文档。** 这些 YAML 文件结构清晰、命名规范、定义明确。如果你的数据层充斥着陈旧混乱的命名惯例和未经文档说明的表连接逻辑，那么即使赋予 Claude 对原始文件的直接访问权限，也无法挽救局面——你只会得到执行更快的错误查询。

**Addition by subtraction is real.** The best agents might be the ones with the fewest tools. Every tool is a choice you’re making for the model. Sometimes the model makes better choices.

**“减法式增益”真实存在。** 最优秀的智能体，或许恰恰是工具最少的那一个。每一个工具，都是你替模型所作的一项选择；而有时，模型自己作出的选择，反而更优。

### What this means for agent builders

### 这对智能体构建者意味着什么

The temptation is always to account for every possibility. Resist it. Start with the simplest possible architecture. Model + file system + goal. Add complexity only when you’ve proven it’s necessary.

人们总是倾向于穷尽所有可能性，但请抵制这种冲动。从最简化的架构起步：模型 + 文件系统 + 目标。仅在确证其必要性时，才逐步增加复杂性。

But simple architecture isn’t enough on its own. The model needs good context to work with. Invest in documentation, clear naming, and well-structured data. That foundation matters more than clever tooling.

但仅靠简洁的架构还不够。模型需要高质量的上下文才能有效工作。请投入精力完善文档、采用清晰的命名规范，并构建结构良好的数据——这一基础远比精巧的工具更重要。

Models are improving faster than your tooling can keep up. Build for the model that you’ll have in six months, not for the one that you have today.

模型的演进速度远超你的工具链更新速度。请面向六个月后的模型进行构建，而非局限于当前所用的模型。

If you’re building agents, we’d love to hear what you’re learning.

如果您正在构建智能体，我们非常期待了解您的实践与洞见。

[**Build an agent with Vercel and Slack**\\
\\
Start creating your own Slack Agent using the Bolt for JavaScript and Nitro template. Deploy it on Vercel to get a live, production-ready setup in minutes.\\
\\
Deploy the template](https://vercel.com/templates/nitro/slack-agent-template)

[**使用 Vercel 和 Slack 构建智能体**\\
\\
借助 Bolt for JavaScript 与 Nitro 模板，快速启动您专属的 Slack 智能体开发。部署至 Vercel，几分钟内即可获得一个实时可用、面向生产的完整环境。\\
\\
立即部署该模板](https://vercel.com/templates/nitro/slack-agent-template)