---
title: "How to build agents with filesystems and bash - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-build-agents-with-filesystems-and-bash"
date: "2026-01-09"
scraped_at: "2026-03-02T09:23:00.901292203+00:00"
language: "en-zh"
translated: true
description: "How to build agents with filesystems and bash, production agents, context management, template, bash"
---

Jan 9, 2026

2026 年 1 月 9 日

The best agent architecture is already sitting in your terminal

最优秀的智能体（agent）架构其实早已存在于你的终端中。

Many of us have built complex tooling to feed our agents the right information. It's brittle because we're guessing what the model needs instead of letting it find what it needs. We've found a simpler approach. We replaced most of the custom tooling in our internal agents with a filesystem tool and a bash tool. Our sales call summarization agent went from ~$1.00 to ~$0.25 per call on Claude Opus 4.5, and the output quality improved. [We used the same approach for d0](https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools), our text-to-SQL agent.

我们中的许多人曾构建了复杂的工具链，以向智能体提供“正确”的信息。但这种做法十分脆弱——因为我们是在猜测模型需要什么，而非让它自主发现所需内容。我们找到了一种更简洁的方案：用一个文件系统工具（filesystem tool）和一个 Bash 工具（bash tool）取代了内部智能体中大部分定制化工具。以 Claude Opus 4.5 为例，我们的销售通话摘要智能体单次调用成本从约 $1.00 降至约 $0.25，同时输出质量反而提升。[我们也在 d0（一款文本转 SQL 智能体）中采用了相同方法](https://vercel.com/blog/we-removed-80-percent-of-our-agents-tools)。

The idea behind this is that LLMs have been trained on massive amounts of code. They've spent countless hours navigating directories, grepping through files, and managing state across complex codebases. If agents excel at filesystem operations for code, they'll excel at filesystem operations for anything. Agents already understand filesystems.

这一思路背后的逻辑在于：大语言模型（LLM）已在海量代码数据上完成训练。它们已在无数小时中练习过目录导航、文件内容搜索（`grep`）、以及在复杂代码库中维护状态等操作。如果智能体擅长对代码执行文件系统操作，那么它们同样擅长对任意类型的数据执行此类操作——因为智能体早已理解文件系统。

Customer support tickets, sales call transcripts, CRM data, conversation history. Structure it as files, give the agent bash, and the model brings the same capabilities it uses for code navigation.

客户支持工单、销售通话记录、CRM 数据、对话历史……将这些数据组织为文件形式，再赋予智能体 Bash 执行能力，模型便能复用其原本用于代码导航的全部能力。

## How agents read filesystems

## 智能体如何读取文件系统

The agent runs in a sandbox with your data structured as files. When it needs context, it explores the filesystem using Unix commands, pulls in what's relevant, and sends that to the LLM.

智能体运行在一个沙箱环境中，而你的数据则以文件形式组织其中。当它需要上下文时，便通过 Unix 命令探索文件系统，提取相关文件内容，并将这些内容送入大语言模型（LLM）进行处理。

```markdown
Agent receives task

2    ↓

Explores filesystem (ls, find)
```

```markdown
智能体接收任务

2    ↓

探索文件系统（ls、find）
```

4    ↓

4    ↓

Searches for relevant content (grep, cat)

搜索相关的内容（grep、cat）

6    ↓

6    ↓

Sends context + request to LLM

将上下文和请求发送给大语言模型（LLM）

8    ↓

8    ↓

Returns structured output

返回结构化输出

```

The agent and its tool execution run on separate compute. You trust the agent's reasoning, but the sandbox isolates what it can actually do.

代理及其工具执行运行在独立的计算环境中。你信任代理的推理能力，但沙箱机制限制了它实际能够执行的操作。

## Why filesystems work for context management

## 为何文件系统适用于上下文管理

The typical approach to agent context is either stuffing everything into the prompt or using vector search. Prompt stuffing hits token limits. Vector search works for semantic similarity but returns imprecise results when you need a specific value from structured data.

处理代理上下文的常规方法，要么是将所有内容塞入提示词（prompt stuffing），要么是使用向量检索（vector search）。提示词填充会迅速触及模型的 token 数量限制；而向量检索虽适用于语义相似性匹配，但在你需要从结构化数据中精确提取某个特定值时，往往返回不够准确的结果。

Filesystems offer a different tradeoff.

文件系统则提供了一种不同的权衡方案。

**Structure matches your domain.**  
**结构与您的业务领域相匹配。**  
Customer records, ticket history, CRM data. These have natural hierarchies that map directly to directories. You're not flattening relationships into embeddings.  
客户记录、工单历史、CRM 数据——这些数据天然具有层次结构，可直接映射为文件目录。您无需将关系“压平”为嵌入向量（embeddings）。

**Retrieval is precise.**  
**检索精准可靠。**  
`grep -r "pricing objection" transcripts/` returns exact matches. When you need one specific value, you get that value.  
`grep -r "定价异议" transcripts/` 返回精确匹配结果；当您需要某个特定值时，得到的正是该值。

**Context stays minimal.**  
**上下文始终保持精简。**  
The agent loads files on demand. A large transcript doesn't go into the prompt upfront. The agent reads the metadata, greps for relevant sections, then pulls only what it needs.  
智能体按需加载文件；一份冗长的对话转录文本不会在初始提示（prompt）中全部载入。智能体会先读取元数据，再通过 `grep` 定位相关段落，最终仅提取真正需要的内容。

## Mapping your domain to files  
## 将您的业务领域映射到文件系统

Let's look at some concrete examples of how different domains map to filesystem structures.  
我们来看几个具体示例，展示不同业务领域如何映射为文件系统结构。

**Example 1: Customer support system**  
**示例 1：客户服务系统**

Instead of throwing raw JSON into your agent, structure it:  
不要将原始 JSON 直接丢给智能体，而应对其进行结构化组织：

```bash
1/customers/

2  /cust_12345/

3    profile.json          # High-level info
```  
```bash
1/customers/

2  /cust_12345/

3    profile.json          # 高层级信息
```

4    tickets/

4    工单目录/

5      ticket_001.md       # Each ticket

5      ticket_001.md       # 每个工单

6      ticket_002.md

6      ticket_002.md

7    conversations/

7    对话记录目录/

8      2024-01-15.txt      # Daily conversation logs

8      2024-01-15.txt      # 每日对话日志

9    preferences.json

9    preferences.json

```

When a customer asks "What was the resolution to my issue?", the agent can `ls` the tickets directory, `grep` for "resolved", and read only the relevant file.

```

当客户询问“我的问题是如何解决的？”，代理可执行 `ls` 命令列出工单目录内容，再用 `grep` 搜索关键词 “resolved”，最后仅读取相关文件。

**Example 2: Document analysis system**

**示例 2：文档分析系统**

```bash
1/documents/

1/documents/

2  /uploaded/

2  /uploaded/

3    contract_abc123.pdf

3    contract_abc123.pdf

4    invoice_def456.pdf

4    invoice_def456.pdf

5  /extracted/

5  /extracted/

6    contract_abc123.txt

6    contract_abc123.txt

7    invoice_def456.txt

7    invoice_def456.txt

8  /analysis/

8  /analysis/

9    contract_abc123/

9    contract_abc123/

10      summary.md

10      summary.md

11      key_terms.json

11      key_terms.json

12      risk_assessment.md

12      risk_assessment.md

14/templates/

14/模板/

15  contract_analysis_prompt.md

15  合同分析提示词.md

16  invoice_validation_rules.md

16  发票验证规则.md

```

Raw inputs in one place, processed outputs in structured directories. The agent can reference previous analysis without reprocessing.

```

原始输入集中存放，处理后的输出则存放在结构化的目录中。智能体可在无需重复处理的情况下，参考此前的分析结果。

## Case study: Sales call summary agent

## 案例研究：销售通话摘要智能体

We built a [sales call summary template](https://vercel.com/templates/ai/call-summary-agent) using this architecture. The agent analyzes sales call transcripts and generates structured summaries with objections, action items, and insights.

我们基于该架构构建了一个[销售通话摘要模板](https://vercel.com/templates/ai/call-summary-agent)。该智能体分析销售通话的文字记录，并生成结构化摘要，内容包括客户异议、待办事项及关键洞察。

The agent sees this file structure:

该智能体看到如下文件结构：

```bash
gong-calls/

gong-calls/

2  demo-call-001-companyname-product-demo.md     # Current call transcript

2  demo-call-001-companyname-product-demo.md     # 当前通话文字记录

3  metadata.json                                 # Call metadata  
3  metadata.json                                 # 通话元数据  

4  previous-calls/  
4  previous-calls/  

5    demo-call-000-discovery-call.md             # Prior discovery call  
5    demo-call-000-discovery-call.md             # 此前的探索性通话  

6    demo-call-intro-initial-call.md             # Initial intro call  
6    demo-call-intro-initial-call.md             # 初次介绍性通话  

salesforce/  
salesforce/  

9  account.md                                    # CRM account record  
9  account.md                                    # CRM 账户记录  

10  opportunity.md                                # Deal/opportunity details  
10  opportunity.md                                # 交易/商机详情  

11  contacts.md                                   # Contact profiles  
11  contacts.md                                   # 联系人档案

slack/

slack/

14  slack-channel.md                              # Slack history

14  slack-channel.md                              # Slack 历史记录


research/

research/

17  company-research.md                           # Company background

17  company-research.md                           # 公司背景

18  competitive-intel.md                          # Competitor analysis

18  competitive-intel.md                          # 竞争对手分析


playbooks/

playbooks/

21  sales-playbook.md                             # Internal sales playbook

21  sales-playbook.md                             # 内部销售手册


```

The agent explores this like a codebase:

代理以类似探索代码库的方式进行探索：

```bash
1# Explore what's available

2$ ls sales-calls/

customer-call-123456-q4.md

metadata.json



6# Read the metadata

7$ cat sales-calls/metadata.json



9# Look for objections

6# 查看元数据

7$ cat sales-calls/metadata.json



9# 寻找客户异议

10$ grep -i "concern\|worried\|issue\|problem" sales-calls/*.md  
10$ grep -i "concern\|worried\|issue\|problem" sales-calls/*.md  

```

The intuition is that the agent treats the transcript like a codebase. It searches for patterns, reads sections, and builds context just like it would debug code. No custom retrieval logic. The agent decides what context it needs using tools it already knows how to use. It handles edge cases we never anticipated because it's working with the raw information, not parameters we defined.

其核心直觉在于：该智能体将通话转录文本视作一个代码库。它像调试代码一样搜索模式、阅读段落、构建上下文。无需定制化的检索逻辑；智能体仅凭自身已掌握的工具，自主决定所需上下文。由于它直接操作原始信息，而非依赖我们预设的参数，因此能够妥善处理大量我们未曾预料到的边界情况。

We'll have another post diving deeper into the sales call summary agent.

我们后续还将发布一篇专题文章，深入探讨销售通话摘要智能体（sales call summary agent）。

## Why you should use bash and filesystems

## 为何应使用 Bash 和文件系统

**Native model capabilities.** grep, cat, find, awk. These aren't new skills we're teaching. LLMs have seen these tools billions of times during training. They're native operations, not bolted on behaviors.

**原生模型能力。** `grep`、`cat`、`find`、`awk`——这些并非我们额外教授的新技能。大语言模型在训练过程中已接触过这些工具数十亿次；它们是模型固有的操作能力，而非后期拼凑的行为。

**Future-proof architecture.** As models get better at coding, your agent gets better. Every improvement in code understanding translates directly. You're leveraging the training distribution instead of fighting against it.

**面向未来的架构设计。** 随着模型编程能力的持续提升，你的智能体性能也将同步增强。每一次代码理解能力的进步，都会直接转化为智能体能力的提升。你是在充分利用模型的训练分布，而非与之对抗。

**Debuggability.** When the agent fails, you see exactly what files it read and what commands it ran. The execution path is visible. No black box.

**可调试性。** 当智能体出错时，你能清晰看到它读取了哪些文件、执行了哪些命令——整个执行路径完全可见，毫无黑箱。

**Security through isolation.** The sandbox lets the agent explore files without access to production systems. You trust the reasoning, not the execution environment.

**通过隔离实现安全性。** 沙箱环境允许智能体自由探索文件，却无法访问生产系统。你信任的是它的推理过程，而非执行环境本身。

**Less code to maintain.** Instead of building retrieval pipelines for each data type, you write files to a directory structure. The agent handles the rest.

**更少的维护代码。** 你无需为每种数据类型单独构建检索流水线，只需将文件写入合适的目录结构即可；其余工作均由智能体自动完成。

## Get started

## 快速开始

Every agent needs filesystem and bash. If you're building an agent, resist the urge to create custom tools. Instead, ask: can I represent this as files?

每个智能体都需要文件系统和 Bash。如果你正在构建一个智能体，请克制创建自定义工具的冲动。相反，不妨自问：我能否将这一功能以文件形式来表达？

We recently open-sourced [bash-tool](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval), a dedicated tool that powers this pattern.

我们近期开源了 [bash-tool](https://vercel.com/changelog/introducing-bash-tool-for-filesystem-based-context-retrieval)，这是一款专为支撑该范式而设计的工具。

1. [**AI SDK**](https://ai-sdk.dev/docs/introduction) for tool execution and model calls

1. [**AI SDK**](https://ai-sdk.dev/docs/introduction)：用于工具执行与模型调用

2. [**bash-tool**](https://www.npmjs.com/package/bash-tool) for sandboxed filesystem access

2. [**bash-tool**](https://www.npmjs.com/package/bash-tool)：提供沙箱化的文件系统访问能力

3. [**Sales Call Summary template**](https://vercel.com/templates/ai/call-summary-agent) to see the full pattern and to get started with one-click

3. [**销售电话摘要模板（Sales Call Summary template）**](https://vercel.com/templates/ai/call-summary-agent)：完整呈现该范式，并支持一键快速上手

The future of agents might be surprisingly simple. Maybe the best architecture is almost no architecture at all. Just filesystems and bash.

智能体的未来可能出人意料地简单。或许，最优的架构几乎就是“无架构”——仅需文件系统与 Bash。

[**Get started with filesystem agents**\\
\\
The Sales Call Summary template shows the filesystem and bash pattern in production. Deploy it on Vercel and watch the agent explore files in real time.\\
\\
Deploy the template](https://vercel.com/templates/ai/call-summary-agent)

[**立即开始使用基于文件系统的智能体**\\
\\
“销售电话摘要”模板已在生产环境中落地应用该“文件系统 + Bash”范式。将其部署至 Vercel，即可实时观察智能体如何探索和操作文件。\\
\\
一键部署该模板](https://vercel.com/templates/ai/call-summary-agent)