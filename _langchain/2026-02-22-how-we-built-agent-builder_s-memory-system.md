---
title: "How we built Agent Builder’s memory system"
render_with_liquid: false
source: "LangChain Blog"
url: "https://blog.langchain.com/how-we-built-agent-builders-memory-system/"
date: "2026-02-22"
scraped_at: "2026-03-02T10:08:08.714701962+00:00"
language: "en-zh"
translated: true
description: "A key part of Agent Builder is its memory system. In this article we cover our rationale for prioritizing a memory system, technical details of how we built it, learnings from building the memory syst..."
---

render_with_liquid: false
We launched [LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com) last month as a no-code way to build agents. A key part of Agent Builder is its memory system. In this article we cover our rationale for prioritizing a memory system, technical details of how we built it, learnings from building the memory system, what the memory system enables, and discuss future work.

我们于上月推出了 [LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)，这是一款无需编写代码即可构建智能体（agent）的工具。Agent Builder 的核心组件之一便是其记忆系统（memory system）。本文将介绍我们为何优先构建记忆系统、该系统的具体技术实现、开发过程中的经验总结、记忆系统所赋能的功能，以及对未来工作的展望。

## What is LangSmith Agent Builder

## 什么是 LangSmith Agent Builder

[LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com) is a no-code agent builder. It’s built on top of the [Deep Agents harness](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com). It is a hosted web solution targeted at [technically lite](https://x.com/ericzakariasson/status/1996347523880165857?s=20&ref=blog.langchain.com) citizen developers. In LangSmith Agent Builder, builders will create an agent to automate a particular workflow or part of their day. Examples include an [email assistant](https://x.com/hwchase17/status/2011126016287113681?s=20&ref=blog.langchain.com), a [documentation helper](https://x.com/docs_plz/status/2011536177556570203?s=20&ref=blog.langchain.com), etc.

[LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com) 是一款无需编写代码即可构建智能体的工具，底层基于 [Deep Agents harness](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 构建。它是一个托管式 Web 解决方案，主要面向 [技术门槛较低](https://x.com/ericzakariasson/status/1996347523880165857?s=20&ref=blog.langchain.com) 的“公民开发者”（citizen developers）。在 LangSmith Agent Builder 中，用户可创建智能体，以自动化某项特定工作流或日常任务的一部分。典型用例包括 [邮件助手](https://x.com/hwchase17/status/2011126016287113681?s=20&ref=blog.langchain.com)、[文档辅助工具](https://x.com/docs_plz/status/2011536177556570203?s=20&ref=blog.langchain.com) 等。

![Create agents using natural language](images/how-we-built-agent-builder_s-memory-system/img_001.png)

![使用自然语言创建智能体](images/how-we-built-agent-builder_s-memory-system/img_001.png)

Early on we made a conscious choice to prioritize memory as a part of the platform. This was not an obvious choice – most AI products launch initially without any form of memory, and even adding it in [hasn’t yet transformed products](https://simonwillison.net/2025/May/21/chatgpt-new-memory/?ref=blog.langchain.com) like some may expect. The reason we prioritized it was due to the usage patterns of our users.

项目初期，我们便有意识地将“记忆”列为平台的核心能力之一。这一决策并非显而易见——目前大多数 AI 产品在发布之初并不具备任何形式的记忆功能；即便部分产品（如 ChatGPT）已引入记忆能力，[也尚未带来预期中的产品级变革](https://simonwillison.net/2025/May/21/chatgpt-new-memory/?ref=blog.langchain.com)。我们之所以优先投入记忆系统，根本原因在于 LangSmith Agent Builder 用户的实际使用模式。

Unlike ChatGPT or Claude or Cursor, LangSmith Agent Builder is not a general purpose agent. Rather, it is specifically designed to let builders customize agents for particular tasks. In general purpose agents, you are doing a wide variety of tasks that may be completely unrelated, so learnings from one session with the agent may not be relevant for the next. When a LangSmith Agent is doing a task, it is doing the same task over and over again. Lessons from one session translate to the next at a much higher rate. In fact, it would be a bad user experience if memory is not present – that would mean you would have to repeat yourself over and over to the agent in different sessions.

与 ChatGPT、Claude 或 Cursor 等通用型智能体不同，LangSmith Agent Builder 并非面向广泛用途的通用智能体，而是专为支持用户定制化构建面向特定任务的智能体而设计。在通用型智能体中，用户执行的任务种类繁多、彼此可能毫无关联，因此一次会话中获得的经验往往难以迁移到下一次会话；而在 LangSmith Agent 中，智能体持续重复执行同一类任务，前一次会话中积累的经验能以高得多的概率复用于后续会话。事实上，若缺乏记忆能力，用户体验将大打折扣——用户不得不在不同会话中反复向智能体说明相同信息。

When thinking about what exactly memory would even mean for LangSmith Agents, we turned to a third party definition of memory. The [COALA paper](https://arxiv.org/abs/2309.02427?ref=blog.langchain.com) defines memory for agents in three categories:

- **Procedural:** the set of rules that can be applied to working memory to determine the agent’s behavior  
- **Semantic:** facts about the world  
- **Episodic:** sequences of the agent’s past behavior  

在思考“记忆”对 LangSmith 智能体究竟意味着什么时，我们参考了第三方研究提出的定义。[COALA 论文](https://arxiv.org/abs/2309.02427?ref=blog.langchain.com) 将智能体的记忆划分为三类：

- **程序性记忆（Procedural Memory）**：作用于工作记忆的一组规则，用于决定智能体的行为方式  
- **语义性记忆（Semantic Memory）**：关于外部世界的基本事实  
- **情景性记忆（Episodic Memory）**：智能体过往行为的序列记录  

![COALA Memory Diagram](images/how-we-built-agent-builder_s-memory-system/img_002.png)

![COALA 记忆结构图](images/how-we-built-agent-builder_s-memory-system/img_002.png)

## How we built our memory system

## 我们如何构建记忆系统

We represent memory in Agent Builder as a set of files. This is an intentional choice to take advantage of the fact that models are [good at using filesystems](https://www.blog.langchain.com/how-agents-can-use-filesystems-for-context-engineering/?ref=blog.langchain.com). In this way, we could easily let the agent read and modify its memory without having to give it specialized tools - we just give it access to the filesystem!

我们在 Agent Builder 中将记忆（memory）表示为一组文件。这一设计是有意为之，旨在充分利用大语言模型“擅长使用文件系统”这一特性（参见：[模型如何利用文件系统进行上下文工程](https://www.blog.langchain.com/how-agents-can-use-filesystems-for-context-engineering/?ref=blog.langchain.com)）。借此，我们可轻松让智能体直接读取和修改其自身记忆，而无需为其配备专用工具——只需向其开放文件系统访问权限即可！

When possible, we try to use industry standards. We use [AGENTS.md](http://agents.md/?ref=blog.langchain.com) to define the core instruction set for the agent. We use [agent skills](https://agentskills.io/home?ref=blog.langchain.com) to give the agents particular specialized instructions for specific tasks. There is no subagent standard, but we use a [similar format to Claude Code](https://code.claude.com/docs/en/sub-agents?ref=blog.langchain.com). For [MCP](https://modelcontextprotocol.io/docs/getting-started/intro?ref=blog.langchain.com) access, we use a custom `tools.json` file. The reason we use a custom `tools.json` file and not the standard `mcp.json` is that we want to allow users to give the agent only a subset of the tools in an MCP server to avoid context overflow.

在可行的情况下，我们尽量采用行业标准。我们使用 [AGENTS.md](http://agents.md/?ref=blog.langchain.com) 定义智能体的核心指令集；使用 [agent skills](https://agentskills.io/home?ref=blog.langchain.com) 为智能体提供面向特定任务的专业化指令。目前尚无统一的子智能体（subagent）标准，但我们采用了与 [Claude Code 的子智能体格式类似的设计](https://code.claude.com/docs/en/sub-agents?ref=blog.langchain.com)。对于 [MCP](https://modelcontextprotocol.io/docs/getting-started/intro?ref=blog.langchain.com) 接入，我们则使用自定义的 `tools.json` 文件。之所以不采用标准的 `mcp.json`，是因为我们希望允许用户仅向智能体授予 MCP 服务器中部分工具的访问权限，从而避免上下文溢出（context overflow）。

![Memory = Filesystem](images/how-we-built-agent-builder_s-memory-system/img_003.png)

![记忆 = 文件系统](images/how-we-built-agent-builder_s-memory-system/img_003.png)

We actually do not use a real filesystem to store these files. Rather, we store them in Postgres and expose them to the agent in the shape of a filesystem. We do this because LLMs are great at working with filesystems, but from an infrastructure perspective it is easier and more efficient to use a database. This “virtual filesystem” is [natively supported by DeepAgents](https://docs.langchain.com/oss/python/deepagents/backends?ref=blog.langchain.com) \- and is completely pluggable so you could bring any storage layer you want (S3, MySQL, etc).

实际上，我们并未使用真实的文件系统来存储这些文件；而是将其存入 PostgreSQL 数据库，并以文件系统的形式暴露给智能体。这样做的原因在于：大语言模型（LLM）非常擅长处理文件系统操作，但从基础设施角度看，使用数据库存储更简单、也更高效。“虚拟文件系统”已由 [DeepAgents 原生支持](https://docs.langchain.com/oss/python/deepagents/backends?ref=blog.langchain.com)，且完全可插拔——您可自由接入任意存储层（如 S3、MySQL 等）。

We also allow users (and agents themselves) to write other files to an agent’s memory folder. These files can contain arbitrary knowledge as well, that the agent can reference as it runs. The agent would edit these files as it’s working, “ [in the hot path](https://docs.langchain.com/oss/python/concepts/memory?ref=blog.langchain.com#in-the-hot-path)”.

我们还允许用户（甚至智能体自身）向智能体的记忆文件夹中写入其他文件。这些文件可承载任意形式的知识，供智能体在运行过程中随时引用。智能体会在执行任务时动态编辑这些文件，即所谓“[热路径中（in the hot path）](https://docs.langchain.com/oss/python/concepts/memory?ref=blog.langchain.com#in-the-hot-path)”的操作。

The reason it is possible to build complicated agents without any code or any domain specific language (DSL) is that we use a generic agent harness like Deep Agents under the hood. Deep Agents abstracts away a lot of complex context engineering (like [summarization](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#conversation-history-summarization), [tool call offloading](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#large-tool-result-eviction), and [planning](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#to-do-list-tracking)) and lets you steer your agent with relatively simple configuration.

之所以能无需编写任何代码或领域特定语言（DSL），即可构建功能复杂的智能体，根本原因在于我们底层采用了通用型智能体框架（agent harness），例如 Deep Agents。Deep Agents 将大量复杂的上下文工程任务（例如：[对话历史摘要](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#conversation-history-summarization)、[工具调用结果卸载](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#large-tool-result-eviction)、以及[规划能力（如待办事项追踪）](https://docs.langchain.com/oss/python/deepagents/harness?ref=blog.langchain.com#to-do-list-tracking)）进行了抽象封装，使您仅需通过相对简单的配置即可引导智能体行为。

These files map nicely on to the memory types defined in the COALA paper. Procedural memory – what drives the core agent directive – is [AGENTS.md](http://agents.md/?ref=blog.langchain.com) and `tools.json`. Semantic memory is agent skills and other knowledge files. The only type of memory missing is episodic memory, which we didn’t think was as important for these types of agents as the other two.

这些文件与 COALA 论文中定义的记忆类型高度契合：程序性记忆（procedural memory）——驱动智能体核心指令的部分——对应 [AGENTS.md](http://agents.md/?ref=blog.langchain.com) 和 `tools.json`；语义性记忆（semantic memory）则由智能体技能（agent skills）及其他知识类文件构成。唯一缺失的是情景性记忆（episodic memory），我们认为对这类智能体而言，其重要性远不及前两者。

### What agent memory in a file system looks like

### 文件系统中的智能体记忆长什么样？

We can look at a real agent we’ve been using internally – a LinkedIn recruiter – built on LangSmith Agent Builder.

我们可以考察一个我们内部实际使用的智能体案例——一个基于 LangSmith Agent Builder 构建的 LinkedIn 招聘专员智能体。

- [AGENTS.md](http://agents.md/?ref=blog.langchain.com): defines the core agents instructions  
  - [AGENTS.md](http://agents.md/?ref=blog.langchain.com)：定义智能体的核心指令  
- `subagents/`: defines only one subagent  
  - `subagents/`：仅定义了一个子智能体  
  - `linkedin_search_worker`: after the main agent is calibrated on a search, it will kick off this agent to source ~50 candidates.  
    - `linkedin_search_worker`：主智能体完成某次招聘搜索的校准后，将自动启动该子智能体，为其搜寻约 50 名候选人。  
- `tools.json`: defines an MCP server with access to a LinkedIn search tool  
  - `tools.json`：定义一个 MCP 服务器，并为其配置 LinkedIn 搜索工具的访问权限  
- There are also currently 3 other files in the memory, representing JDs for different candidates. As we’ve worked with the agent on these searches, it has updated and maintained those JDs.  
  - 记忆中目前还有另外 3 个文件，分别代表不同候选人的职位描述（JD）。在我们使用该智能体执行这些搜索任务的过程中，它持续更新并维护着这些 JD 文件。

![Agent Builder Memory Filesystem](images/how-we-built-agent-builder_s-memory-system/img_004.png)

### How memory editing works: a concrete example

### 记忆编辑的工作原理：一个具体示例

To make it more concrete how memory works, we can walk through an illustrative example.

为了更直观地理解记忆机制的工作方式，我们可以通过一个示例来逐步说明。

**Start:**

**初始状态：**

You start with a simple [AGENTS.md](http://agents.md/?ref=blog.langchain.com):

你从一个简单的 [AGENTS.md](http://agents.md/?ref=blog.langchain.com) 文件开始：

`Summarize meeting notes.`

`总结会议纪要。`

**Week 1:**

**第一周：**

The agent produces paragraph summaries. You correct it: "Use bullet points instead." The agent edits [AGENTS.md](http://agents.md/?ref=blog.langchain.com) to be:

代理生成了段落形式的摘要。你纠正它：“请改用项目符号（bullet points）。” 于是代理将 [AGENTS.md](http://agents.md/?ref=blog.langchain.com) 修改为：

`# Formatting Preferences  
User prefers bullet points for summaries, not paragraphs.`

`# 格式偏好  
用户倾向于用项目符号而非段落形式呈现摘要。`

**Week 2:**

**第二周：**

You ask the agent to summarize a different meeting. It reads its memory and uses bullet points automatically. No reminder needed. During this session, you ask it to: "Extract action items separately at the end." Memory updates:

你让代理总结另一场会议。它读取自身记忆，并自动采用项目符号（bullet points）格式，无需额外提醒。在本次会话中，你要求它：“最后单独提取待办事项（action items）。” 记忆内容随之更新：

`# Formatting Preferences  
User prefers bullet points for summaries, not paragraphs.  
Extract action items in separate section at end.`

`# 格式偏好  
用户偏好使用项目符号（bullet points）而非段落形式生成摘要。  
待办事项（action items）需在摘要末尾单独列出。`

**Week 4:**

**第四周：**

Both patterns apply automatically. You continue adding refinements as new edge cases surface.

两种模式均自动生效。随着新边缘情况（edge cases）不断出现，你持续添加优化项。

**Month 3:**

**第三个月：**

The agent's memory includes:

代理的记忆内容包括：

- Formatting preferences for different document types  
- Domain-specific terminology  
- Distinctions between "action items", "decisions", and "discussion points"  
- Names and roles of frequent meeting participants  
- Meeting type handling (engineering vs. planning vs. customer)  
- Edge case corrections accumulated through use  

- 针对不同文档类型的格式偏好  
- 领域专属术语（domain-specific terminology）  
- “待办事项（action items）”、“决策（decisions）”与“讨论要点（discussion points）”之间的区别  
- 常参会人员的姓名及角色  
- 会议类型处理逻辑（如工程类、规划类、客户类会议的差异化处理）  
- 在实际使用过程中逐步积累的边缘情况修正记录  

The memory file might look like:

该记忆文件可能如下所示：

`# Meeting Summary Preferences  

## Format  
- Use bullet points, not paragraphs  
- Extract action items in separate section at end  
- Use past tense for decisions  
- Include timestamp at top`

`# 会议摘要偏好  

## 格式规范  
- 使用项目符号（bullet points），而非段落  
- 待办事项（action items）需在摘要末尾单独列出  
- 决策（decisions）使用过去时态表述  
- 摘要顶部需包含时间戳`

## Meeting Types

## 会议类型

- Engineering meetings: highlight technical decisions and rationale  
- 工程会议：突出技术决策及其依据

- Planning meetings: emphasize priorities and timelines  
- 规划会议：强调优先级与时间线

- Customer meetings: redact sensitive information  
- 客户会议：脱敏敏感信息

- Short meetings (<10 min): just key points  
- 短会（<10 分钟）：仅记录关键要点

## People

## 人员

- Sarah Chen (Engineering Lead) - focus on technical details  
- Sarah Chen（工程负责人）——关注技术细节

- Mike Rodriguez (PM) - focus on business impact  
- Mike Rodriguez（产品经理）——关注业务影响

...

The [AGENTS.md](http://agents.md/?ref=blog.langchain.com) built itself through corrections, not through upfront documentation. We arrived iteratively at an appropriately detailed agent specification, without the user ever manually changing the [AGENTS.md](http://agents.md/?ref=blog.langchain.com).

[AGENTS.md](http://agents.md/?ref=blog.langchain.com) 文件是通过持续修正自动生成的，而非依赖预先编写的文档。我们通过迭代方式逐步形成了恰当详尽的智能体（agent）规范，整个过程中用户从未手动修改过 [AGENTS.md](http://agents.md/?ref=blog.langchain.com)。

## Learnings from building this memory system

## 构建该记忆系统过程中的经验总结

There are several lessons we learned along the way.

我们在实践中收获了若干重要经验。

**The hardest part is prompting**

**最困难的部分在于提示词工程（prompting）**

The hardest part of building an agent that could remember things is prompting. In almost all cases where the agent was not performing well, the solution was to improve the prompt. Examples of issues that were solved this way:

构建具备记忆能力的智能体时，最难的部分就是提示词工程。在绝大多数智能体表现不佳的案例中，根本解决方法都是优化提示词。以下问题均通过此方式得以解决：

- The agent was not remembering when it should  
- 智能体本该记忆却未记忆

- The agent was remembering when it should not  
- 智能体不该记忆却进行了记忆

- The agent was writing too much to [AGENTS.md](http://agents.md/?ref=blog.langchain.com) instead of to skills  
- 智能体向 [AGENTS.md](http://agents.md/?ref=blog.langchain.com) 写入过多内容，而未正确写入技能（skills）模块

- The agent did not know the right format for skills files  
- 智能体不了解技能文件的正确格式

- … many more  
- …… 还有更多类似问题

We had one person working full time on prompting for memory (which was a large percentage of the team).

团队中曾有一名成员全职投入记忆功能的提示词优化工作（占团队总人力比重相当可观）。

**Validate file types**

**校验文件类型**

Several files have specific schemas they need to abide by (`tools.json` needs to have valid MCP servers, skills needs to have proper frontmatter, etc). We saw that Agent Builder sometimes forgot this, and as a result generated invalid files. We added a step to explicitly validate these custom shapes, and, if validation failed, throw any errors back to the LLM instead of committing the file.

若干文件需遵循特定的结构规范（例如 `tools.json` 必须包含有效的 MCP 服务器，skills 文件必须具备正确的前置元数据等）。我们发现 Agent Builder 有时会忽略这些要求，从而生成无效文件。为此，我们新增了一个显式校验步骤，用于验证这些自定义结构；若校验失败，则将错误直接返回给大语言模型（LLM），而非提交该文件。

**Agents were good at adding things to files, but didn’t compact**

**代理擅长向文件中添加内容，却不擅于压缩归纳**

Agents were editing their memory as they worked. They were pretty good at adding specific things to files. One thing they were not good at, however, was realizing when to compact learnings. For example: my email assistant at one point started listing out all specific vendors it should ignore cold outreach from, instead of updating itself to ignore all cold outreach.

代理在运行过程中会持续更新自身记忆。它们在向文件中添加具体内容方面表现良好；但一个明显短板是：无法自主判断何时应对所学知识进行归纳压缩。例如：我的邮件助手曾一度开始逐条罗列所有应屏蔽冷启动推广邮件的供应商名称，而未能将其泛化为“屏蔽全部冷启动推广邮件”这一更简洁、更具普适性的规则。

**Explicit prompting is still sometimes useful as an end user**

**作为终端用户，显式提示仍有时十分有用**

Even with the agent being able to update its memory as it worked, there were still several cases where (as an end user) we found it useful to prompt the agent explicitly to manage its memory. One such case was at the end of its work to reflect on the conversation and update its memory for any things it may have missed. Another case was to prompt it to compact its memory, to solve for the case where it was remembering specific cases but not generalizing.

即便代理已具备运行时动态更新记忆的能力，作为终端用户，我们在实际使用中仍发现若干场景下显式提示其管理记忆十分必要。一种典型场景是：在其完成任务后，主动提示其复盘本次对话，并补充更新可能遗漏的记忆项；另一种则是明确指示其对记忆进行压缩归纳，以解决其仅记住具体个例、却未能提炼通用规律的问题。

**Human-in-the-loop**

**人工介入闭环（Human-in-the-loop）**

We made all edits to memory human-in-the-loop – that is, we require explicit human approval before updating. This was largely done to minimize the potential attack vector of prompt injection. We do expose a way for users to turn this off (“yolo mode”) in cases where they aren’t as worried about this.

我们对所有记忆修改操作均采用人工介入闭环机制——即任何记忆更新均需获得用户的明确批准后方可执行。此举主要目的在于最大限度降低提示注入（prompt injection）攻击的风险。同时，我们也为用户提供了一种关闭该机制的选项（称为 “yolo mode”），适用于用户对此类安全风险不甚担忧的场景。

## What this enables

## 这一设计所赋能的能力

Besides a better product experience, representing memory in this way enables a number of things.

除提升产品体验外，以这种方式表征记忆还带来了一系列能力拓展。

**No-code experience**

**无代码体验**

One of the issues with no-code builders is that they require you to learn an unfamiliar DSL that does not scale well with complexity. By representing the agent as markdown and json files, the agent is now in a format that (a) is familiar to most technically-lite people, (b) more scalable.

无代码构建工具的一个问题是，它们要求你学习一种不熟悉的领域特定语言（DSL），而这种语言在面对复杂性时难以良好扩展。通过将智能体表示为 Markdown 和 JSON 文件，智能体现在采用了一种格式：(a) 对大多数技术背景较弱的用户而言十分熟悉；(b) 具有更强的可扩展性。

**Better agent building**

**更优的智能体构建体验**

Memory actually allows for a better agent building experience. Agent building is very iterative – in large part because you don’t know what the agent will do until you try it. Memory makes iteration easier, because rather than manually updating the agent configuration every time, you can just give feedback in natural language and it will update itself.

记忆机制实际上显著提升了智能体构建体验。智能体开发本质上是一个高度迭代的过程——很大程度上是因为你只有在实际运行后，才能知道智能体的具体行为。记忆机制让迭代变得更轻松：你无需每次手动更新智能体配置，只需用自然语言提供反馈，智能体即可自动完成自我更新。

**Portable agents**

**可移植的智能体**

Files are very portable! This allows you to easily to port agents built in agent builder to other harnesses (as long as they use the same file conventions). We tried to use as many standard conventions as possible for this reason. We want to make it easy to use agents built in agent builder in the Deep Agents CLI, for example. Or other agent harnesses completely, like Claude Code or OpenCode.

文件具有极强的可移植性！这使你能够轻松地将 Agent Builder 中构建的智能体迁移到其他运行框架（harness）中（前提是这些框架采用相同的文件约定）。正因如此，我们尽可能采用了大量标准化约定。例如，我们希望让用户能便捷地在 Deep Agents CLI 中直接使用 Agent Builder 构建的智能体；甚至也能无缝接入其他完全不同的智能体运行框架，例如 Claude Code 或 OpenCode。

## Future directions

## 未来方向

There are a lot of memory improvements we want to get to that we did not have time or enough confidence to get in before the launch.

在发布之前，我们有许多关于记忆机制的改进构想，但受限于时间与成熟度考量，暂未纳入本次版本。

**Episodic memory**

**情景记忆（Episodic Memory）**

The one COALA memory type Agent Builder is missing is episodic memory: sequences of the agent’s past behavior. We plan to do this by exposing previous conversations as files in the filesystem that the agent can interact with.

Agent Builder 当前缺失的、也是唯一尚未支持的 COALA 记忆类型是“情景记忆”（episodic memory）：即智能体过往行为的有序序列。我们计划通过将历史对话以文件形式暴露在文件系统中来实现这一能力，使智能体可直接读取并与其交互。

**Background memory processes**

**后台记忆处理机制**

Right now, all memory is updated “in the hot path”; that is, as the agent runs.  
目前，所有记忆的更新都发生在“热路径”中；也就是说，在智能体运行过程中实时进行。

We want to add a process that runs in the background (probably some cron job, running once a day or so) to reflect over all conversations and update memory. We think this will catch items that the agent fails to recognize in the moment, and will be particularly useful for generalizing specific learnings.  
我们计划添加一个后台运行的进程（可能是一个 cron 任务，每天执行一次左右），用于遍历所有对话并更新记忆。我们认为该机制能够捕获智能体在实时交互中未能识别的信息，尤其有助于将具体经验泛化为通用知识。

![In the hot path](images/how-we-built-agent-builder_s-memory-system/img_005.png)  
![热路径中](images/how-we-built-agent-builder_s-memory-system/img_005.png)

**`/remember`**  
**`/remember`**

We want to expose an explicit `/remember` command so you can prompt the agent to reflect on the conversation and update its memory. We found ourselves doing this occasionally with great benefits, and so want to make it easier and more encouraged.  
我们希望提供一个显式的 `/remember` 命令，使您能主动提示智能体对当前对话进行反思，并据此更新其记忆。我们在实践中已多次手动执行此类操作，并收获了显著成效；因此，我们希望将其操作流程简化，并更积极地鼓励用户使用。

**Semantic search**  
**语义搜索**

While being able to search memories with `glob` and `grep` is a great starting point, there are some situations where allowing the agent to do a semantic search over its memory would provide some gains.  
尽管目前支持使用 `glob` 和 `grep` 检索记忆已是一个极佳的起点，但在某些场景下，若允许智能体对其记忆执行语义搜索，将进一步提升能力与效果。

**Different levels of memory**  
**多层级记忆**

Right now, all memory is specific for that agent. We have no concept of user-level or org-level memory. We plan to do this by exposing specific directories to the agent that represent these types of memory, and prompting the agent to use and update those memories accordingly.  
目前，所有记忆均专属于单个智能体，尚无用户级或组织级记忆的概念。我们计划通过向智能体暴露特定目录（分别代表用户级、组织级等不同层级的记忆），并引导其按需使用和更新对应层级的记忆，来实现这一目标。

## Conclusion  
## 结语

If building agents that have memory sounds interesting, please try out [LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com).  
如果您对构建具备记忆能力的智能体感兴趣，欢迎试用 [LangSmith Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)。

If you want to help us build this memory system, [we are hiring](https://www.langchain.com/careers?ref=blog.langchain.com).  
如果您希望参与共建这一记忆系统，[我们正在招聘](https://www.langchain.com/careers?ref=blog.langchain.com)。