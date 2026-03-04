---
title: "Agent skills explained: An FAQ - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/agent-skills-explained-an-faq"
date: "2026-01-26"
scraped_at: "2026-03-02T10:47:55.654529231+00:00"
language: "en-zh"
translated: true
description: "A plainspoken Skills FAQ with a ready-to-use guide: what skill packages are, how agents load them, what skills-ai.dev is, how Skills compare to MCP, plus security and alternatives."
---
{% raw %}

Jan 26, 2026

2026年1月26日

Learn what agents skills are, how to install them, how agents use them, and best practices for implementation.

了解什么是 Agent 技能、如何安装它们、Agent 如何使用它们，以及实施过程中的最佳实践。

Agents lack the same context as you and your team. Even when an agent scans your codebase or connects with your document management system, it doesn't know your team's process, quality standards, or goals. To improve responses and clean up mistakes, people use repeated prompts to provide the right context.

Agent 无法像你和你的团队那样天然拥有上下文。即使 Agent 扫描了你的代码库，或连接了你的文档管理系统，它仍不了解你们团队的工作流程、质量标准或业务目标。为提升响应质量并修正错误，人们往往需要反复输入提示词（prompts）来提供恰当的上下文。

Agent skills fix this. They are a simple, open format that packages instructions, scripts, and resources LLMs and agents can discover and use automatically, increasing output accuracy.

Agent 技能正是为解决这一问题而生。它是一种简洁、开放的格式，将指令、脚本和资源打包封装，使大语言模型（LLM）和 Agent 能够自动发现并调用，从而显著提升输出准确性。

Think of skills as centralized, on-demand expertise. Write it once, and the agent will have access to critical information right when it needs it. Skills give you a path from "the agent kind of works" to "the agent actually knows how we do things here".

可将技能视作集中化、按需调用的专业知识。只需编写一次，Agent 就能在真正需要时即时获取关键信息。技能为你铺就了一条从“Agent 勉强可用”迈向“Agent 真正理解我们此处的工作方式”的演进路径。

## What are skills?

## 什么是技能？

Skills are packaged, reusable instructions for AI agents. Skills are built on an [open standard](https://agentskills.io/) adopted by many of the top providers and agent platforms.

技能是面向 AI Agent 的、已封装且可复用的指令集。其构建基础是一项[开放标准](https://agentskills.io/)，已被众多头部服务商及 Agent 平台所采用。

You install skills packages once, and your agent can load them when they match the task. Skills work with any type of agent, whether it is writing code, analyzing data, managing workflows, or handling customer support.

你只需安装一次技能包，Agent 即可在任务匹配时自动加载相应技能。无论 Agent 是用于编写代码、分析数据、管理工作流，还是处理客户支持，技能均可无缝适配。

While coding agents are driving much of the current adoption, skills apply to any agent use case. The same packaging format and ecosystem work across domains.

尽管当前编码类 Agent 推动了技能的大部分落地应用，但技能本身适用于所有 Agent 使用场景。同一套封装格式与生态体系，可跨领域通用。

## How do skills compare to MCP servers, tools, rules, and system prompts?

## 技能与 MCP 服务器、工具、规则及系统提示有何区别？

Skills, MCP servers, tools, rules, and system prompts each solve different aspects of AI agent configuration and provide different types of agent capabilities.

技能、MCP 服务器、工具、规则和系统提示各自解决 AI 智能体配置的不同方面，并提供不同类型的智能体能力。

Skills excel at packaging complete workflows with context and guardrails. MCP servers provide standardized tool access. Tools provide specific functionality. Rules and system prompts offer foundational behavior control.

技能擅长将完整的业务流程（含上下文与安全护栏）进行封装；MCP 服务器提供标准化的工具接入方式；工具提供特定功能；规则与系统提示则提供基础的行为控制机制。

The approaches work together. Skills can reference MCP servers, build on system prompts, and incorporate rule-based logic.

这些方法协同工作：技能可调用 MCP 服务器、基于系统提示构建，并融入基于规则的逻辑。

### Skills

### 技能

Skills package complete workflows that combine instructions, context, and decision-making logic. They tell agents not just what tools are available, but when to use them, how to sequence actions, and what success looks like.

技能将指令、上下文与决策逻辑整合，封装成完整的业务流程。它们不仅告诉智能体有哪些可用工具，更明确指出何时使用这些工具、如何编排操作步骤，以及“成功”应呈现为何种状态。

They work best for complex, multi-step processes with repetitive, domain-specific tasks. These scenarios require contextual decision-making about tool usage and output handling, and skills provide the task-specific expertise needed to make the best choice.

技能最适用于涉及重复性、领域专用任务的复杂多步骤流程。此类场景要求结合上下文对工具调用与输出处理作出判断，而技能则提供了完成特定任务所需的专门知识，从而支持最优决策。

### MCP servers

### MCP 服务器

Model Context Protocol (MCP) servers provide standardized interfaces for AI agents to access external tools and services. They handle the technical integration between AI systems and third-party APIs.

模型上下文协议（Model Context Protocol，MCP）服务器为 AI 智能体访问外部工具与服务提供标准化接口，负责 AI 系统与第三方 API 之间的技术集成。

They work best for tool integration, API access, and providing agents with reliable interfaces to external services like databases, file systems, or web services.

MCP 服务器最适合用于工具集成、API 接入，以及为智能体提供通往数据库、文件系统或 Web 服务等外部服务的稳定可靠接口。

### Tools

### 工具

Tools provide individual functions that agents can call to perform specific actions. Each tool handles a discrete operation like making an API call, performing a web search, reading a file, or processing data.

工具提供独立的功能，供智能体（agents）调用以执行特定操作。每个工具负责一项明确的任务，例如发起 API 调用、执行网络搜索、读取文件或处理数据。

They work best for single-purpose operations, API integrations, and providing agents with specific capabilities they can use as building blocks for larger workflows.

它们最适用于单一用途的操作、API 集成，以及为智能体提供可作为大型工作流“积木”的特定能力。

### Rules

### 规则

Rules define specific constraints and logic for AI behavior. They are used by both teams and individuals to consistently apply security policies, data handling standards, and operational constraints, regardless of the task or agent persona.

规则为 AI 的行为定义具体的约束条件与逻辑。团队与个人均可使用规则，以确保无论面对何种任务或智能体角色，都能一致地落实安全策略、数据处理规范及运营限制。

They work best for enforcing compliance requirements, setting access controls, and defining specific behavioral boundaries that need consistent application.

它们最适用于强制执行合规性要求、设定访问控制权限，以及明确定义需在所有场景中一贯遵循的行为边界。

### System prompts

### 系统提示词（System Prompts）

System prompts establish the AI's foundational behavior and personality. They set the initial context for how an agent should respond, what tone to use, and basic capabilities to emphasize.

系统提示词确立 AI 的基础行为模式与个性特征。它们设定了智能体应如何响应、采用何种语气，以及需要重点强调的基本能力等初始上下文。

They work best for defining core behavior, setting communication style, and establishing baseline operational parameters that apply across all interactions (whereas rules act as narrower constraints that restrict or require specific actions within that baseline).

它们最适用于定义核心行为准则、设定沟通风格，以及确立适用于所有交互场景的基础运行参数（而规则则是在该基础之上施加的更精细约束，用于限制或要求特定操作）。

## What problems do skills solve?

## 技能（Skills）解决了哪些问题？

Skills solve problems that emerge when teams rely on agents for complex workflows.

技能解决的是当团队依赖智能体执行复杂工作流时所出现的问题。

Prompts drift. Two people can ask for the same thing and get different results because they used different words, or because the agent chose to focus on different context. This can happen even within the same step-by-step process. Without consistent instructions, agent behavior varies even when performing the same task.

提示会漂移。两个人可能提出相同的需求，却得到不同的结果——原因可能是措辞不同，也可能是智能体自主选择了不同的上下文重点。即使在完全相同的分步流程中，这种情况也可能发生。若缺乏一致的指令，智能体在执行同一任务时的行为仍会不一致。

Workflow conventions get lost. Every process has its own patterns for quality checks, validations, approval flows, data formats, and decision criteria. Agents do not infer these correctly without guidance, and it is impossible to restate them for every task at scale.

工作流规范容易丢失。每个业务流程都有其专属的质量检查方式、校验规则、审批流程、数据格式及决策标准。智能体无法在缺乏明确指引的情况下准确推断这些规范；而若要在海量任务中为每一项都重复声明这些规范，则根本不可行。

Instruction sprawl bloats context. Copying detailed playbooks into prompts competes with everything else the agent needs to reason about, and critical workflow context gets buried.

指令泛滥导致上下文膨胀。将详尽的操作手册直接复制进提示词，会与智能体需推理的其他所有信息产生竞争，致使关键的工作流上下文被淹没。

Skills extract those instructions from ad hoc prompts and put them in a centralized place and format you can version, review, and reuse across your agentic workflows.

“技能（Skills）” 从临时性提示中提取出这些指令，并将其统一存放于中心化的位置，以标准化格式进行版本管理、人工审核，并在各类智能体工作流中复用。

## What are examples of skills?

## 哪些是“技能”的示例？

- [Vercel React Best Practices](https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices): When an agent is writing or reviewing React or Next.js code, it loads this skill to ensure components follow performance patterns like proper memoization, bundle optimization, and server component usage.

- [Vercel React 最佳实践](https://skills.sh/vercel-labs/agent-skills/vercel-react-best-practices)：当智能体编写或审查 React 或 Next.js 代码时，将加载此项技能，确保组件遵循性能优化模式，例如合理使用 `memo`、包体积优化及服务端组件（Server Components）的正确应用。

- [Supabase Postgres Best Practices](https://skills.sh/supabase/agent-skills/supabase-postgres-best-practices): When an agent needs to write database queries or design schemas, it applies this skill to ensure proper indexing, efficient query patterns, and optimal table structures.

- [Supabase PostgreSQL 最佳实践](https://skills.sh/supabase/agent-skills/supabase-postgres-best-practices)：当智能体需要编写数据库查询语句或设计数据表结构时，将应用此项技能，以确保索引设置合理、查询模式高效、表结构设计最优。

- [Copywriting](https://skills.sh/coreyhaines31/marketingskills/copywriting): When an agent is creating marketing content, landing pages, or social copy, it uses this skill to apply conversion-focused writing patterns, persuasive frameworks, and brand voice consistency.

- [文案写作](https://skills.sh/coreyhaines31/marketingskills/copywriting)：当智能体生成营销内容、落地页文案或社交媒体文案时，将调用此项技能，应用以转化率为导向的写作模式、说服性框架以及品牌语调一致性原则。

- [Remotion Best Practices](https://skills.sh/remotion-dev/agent-skills/remotion-best-practices): When an agent is generating video with the Remotion SDK, it uses this skill to apply domain-specific knowledge about animations, audio, 3D content, charts, captions, and other video production patterns.

- [Remotion 最佳实践](https://skills.sh/remotion-dev/agent-skills/remotion-best-practices)：当智能体使用 Remotion SDK 生成视频时，将启用此项技能，融入动画、音频、3D 内容、图表、字幕等视频制作领域的专业知识与生产模式。

These examples show how skills work across different domains. Development teams get code that follows performance best practices, database teams get optimized queries, marketing teams get copy that converts, and video teams get production-ready Remotion code. The same packaging format works whether you're writing SQL or sales content.

以上示例展示了“技能”如何在不同领域中发挥作用：开发团队获得符合性能最佳实践的代码，数据库团队获得经过优化的查询语句，营销团队获得高转化率的文案，视频团队则获得可直接投入生产的 Remotion 视频代码。“技能”的封装格式具有高度通用性——无论你是在编写 SQL 查询，还是撰写销售文案，均适用同一套机制。

## What is a skill package?

## 什么是技能包？

A skill package is a shareable collection of one or more skills that teams can adopt and install where needed.

技能包是一个可共享的、包含一个或多个技能的集合，团队可根据需要采纳并安装。

Each package contains components that make skills work. The only required component is the SKILL.md file. Everything else is optional.

每个包都包含使技能正常运行所需的组件。其中唯一必需的组件是 `SKILL.md` 文件，其余均为可选。

The SKILL.md files contain instructions that tell the agent what the skill does and how to use it. The scripts directory holds executable helpers and automation scripts. The references directory contains supporting documentation, examples, and context files. Configuration files define setup and dependency requirements.

`SKILL.md` 文件包含指令，用于向智能体说明该技能的功能及使用方法；`scripts` 目录存放可执行的辅助脚本和自动化脚本；`references` 目录包含支持性文档、示例和上下文文件；配置文件则定义环境搭建要求与依赖项。

You do not need one giant instruction set for every repo. You can install a package where it fits and keep the rest of your agent setup unchanged. This modular approach lets teams adopt specific capabilities without overhauling their entire workflow.

你无需为每个代码仓库准备一套庞大而冗长的指令集。只需将技能包安装到适用的位置，其余智能体配置可保持不变。这种模块化方式使团队能够按需引入特定能力，而无需重构整个工作流。

A package might contain a single focused skill or multiple related skills that work together, and you can add supporting files as needed to make them useful in your development environment.

一个包可以仅包含一项专注明确的技能，也可以包含多个协同工作的相关技能；你还可以根据开发环境的实际需求，灵活添加各类支持文件，以提升其可用性。

## How do I install a skill package?

## 如何安装技能包？

To install a skill package, you can place the skill files in your project's `skills/` directory or global user scope. You can also use the `skills` command-line utility.

安装技能包时，你可以将技能文件放入项目的 `skills/` 目录中，或置于全局用户作用域下；也可使用 `skills` 命令行工具完成安装。

**Installing skills from the command line**

**通过命令行安装技能**

Use the [skills CLI](https://www.npmjs.com/package/skills) to add skills directly from the command line:

请使用 [skills CLI](https://www.npmjs.com/package/skills) 工具，直接从命令行添加技能：

`npx skills add <owner/repo>`

`npx skills add <owner/repo>`

## How do I find skills packages?

## 如何查找技能包？

Skills have their own ecosystem with a consistent format and public directory at [skills.sh](https://skills.sh/), where you can discover new skills.

技能拥有独立的生态系统，采用统一格式，并在 [skills.sh](https://skills.sh/) 提供公开目录，供您发现新技能。

## What happens after installation?

## 安装后会发生什么？

Once installed, skills appear in your agent's available skills list. The agent loads them when needed based on the skill metadata and the current context.

安装完成后，技能将出现在您智能体（agent）的可用技能列表中。智能体会根据技能的元数据及当前上下文，在需要时自动加载这些技能。

## Can I create my own skills?

## 我可以创建自己的技能吗？

Yes, you can create custom skills. Skills are folders containing a `SKILL.md` file, and other files if needed, that define the skill's purpose and implementation.

是的，您可以创建自定义技能。技能本质上是包含 `SKILL.md` 文件（以及按需添加的其他文件）的文件夹，用于定义该技能的目的与具体实现方式。

You can create skills locally without external hosting. Create a folder, add a `SKILL.md` file with the required YAML frontmatter and skill definition, and the agent can use it immediately.

您可直接在本地创建技能，无需外部托管。只需新建一个文件夹，添加一份包含必要 YAML 前置元数据（frontmatter）和技能定义的 `SKILL.md` 文件，智能体即可立即使用该技能。

To understand the structure and implementation patterns, [explore existing skills as examples](https://vercel.com/blog/How%20do%20I%20find%20skills%20packages?%20Skills%20have%20their%20own%20ecosystem%20with%20a%20consistent%20format%20and%20public%20directory%20at%20skills.sh%20for%20discovery.). This helps you build skills that integrate effectively with agentic systems.

为深入理解技能的结构与实现模式，请[参考现有技能作为范例](https://vercel.com/blog/How%20do%20I%20find%20skills%20packages?%20Skills%20have%20their%20own%20ecosystem%20with%20a%20consistent%20format%20and%20public%20directory%20at%20skills.sh%20for%20discovery.)。这有助于您构建能与智能体系统（agentic systems）高效集成的技能。

## Where do skills packages show up in real workflows?

## 技能包在实际工作流中会出现在哪些环节？

Skills are most useful when they map to repeatable work patterns across any domain and represent specific domain expertise or organizational knowledge:

技能在映射到任意领域中可复用的工作模式，并体现特定领域的专业知识或组织内部知识时，最为实用：

- A development team might have skills that explain how to add a new route, run tests, write clear PR descriptions, and confirm which checks must pass before merging.

- 开发团队可能拥有若干技能，用于说明如何添加新路由、运行测试、撰写清晰的 Pull Request 描述，以及确认合并前必须通过哪些检查。

- A content team could have skills for writing headlines, following brand guidelines, structuring blog posts, and optimizing for SEO.

- 内容团队可能拥有若干技能，用于撰写标题、遵循品牌规范、组织博客文章结构，以及针对搜索引擎优化（SEO）进行内容调整。

- Customer support teams might create skills for triaging tickets, following tone guidelines, resolving common issues, and escalating when needed.

- 客户支持团队可能创建若干技能，用于工单分类（triaging）、遵循语气指南、解决常见问题，以及在必要时向上升级。

- Data analysts might create skills for cleaning datasets, running specific queries, creating visualizations, and documenting methodology.

- 数据分析师可能创建若干技能，用于数据集清洗、执行特定查询、生成可视化图表，以及记录分析方法论。

Teams also build shared skill packages for processes they use across their organization. For example, engineering teams might standardize how to structure database migrations, write logging, or handle incidents.

团队还会围绕组织内跨部门共用的流程，构建共享的技能包。例如，工程团队可能就数据库迁移的结构设计、日志编写规范，以及事件响应流程等制定统一标准。

The main shift agent skills bring is that specific instructions and expertise are no longer buried in someone's notes from last week or hidden in a prompt. They live in a central, reviewable place where teams can iterate on them together.

Agent 技能带来的核心转变在于：具体的操作指令与专业经验，不再散落在某位成员上周的笔记里，也不再隐匿于某个提示词（prompt）之中；它们被集中存放在一个可供审查的统一位置，供团队共同协作、持续迭代。

## How do skills get used by an agent?

## Agent 如何使用技能？

Most agents that support skills follow the same pattern.

大多数支持技能的 Agent 都遵循相同的使用模式。

At startup, the agent loads a lightweight index of what skills are available. It sees names and descriptions, not the full instruction bodies.

启动时，Agent 会加载一份轻量级索引，其中包含当前可用技能的名称与描述——但不包含完整的指令正文。

When a task looks like a match, the agent loads the full content of the relevant skill. This keeps the default context small, while still making detailed guidance available when it matters.

当某项任务看起来匹配时，智能体将加载相关技能的全部内容。这使得默认上下文保持精简，同时在关键时候仍能提供详尽的指导。

Some agent platforms also support explicit invocation. That is useful when you want to force a workflow, or when you are debugging why a skill did or did not apply.

某些智能体平台还支持显式调用（explicit invocation）。当你需要强制执行某个工作流，或正在调试某项技能为何被应用（或未被应用）时，这一功能尤为有用。

## What is in SKILL.md?

## `SKILL.md` 文件包含哪些内容？

`SKILL.md` has two parts, YAML frontmatter and markdown content.

`SKILL.md` 文件由两部分组成：YAML 前置元数据（frontmatter）和 Markdown 正文内容。

### YAML frontmatter

### YAML 前置元数据

The frontmatter is used for agent discovery and metadata. It must include `name` and `description` fields.

该前置元数据用于智能体的技能发现与元数据管理，必须包含 `name` 和 `description` 两个字段。

The `name` field requirements include 1–64 characters, lowercase letters and numbers with single hyphens, must match the directory name, and must match `^[a-z0-9]+(-[a-z0-9]+)*$`.

`name` 字段需满足以下要求：长度为 1–64 个字符；仅允许小写字母、数字及单个连字符（`-`）；必须与所在目录名称完全一致；且须符合正则表达式 `^[a-z0-9]+(-[a-z0-9]+)*$`。

The `description` field requirements are 1–1024 characters.

`description` 字段长度需为 1–1024 个字符。

Unknown frontmatter fields are ignored, making the format forward compatible.

未知的前置元数据字段将被忽略，从而保证该格式具备向前兼容性。

### Markdown content

### Markdown 正文内容

The markdown content section contains the actual instructions for the agent. This is where you define what the agent should do, how it should behave, and any specific guidelines it should follow when using this skill.

Markdown 内容部分包含代理（agent）的实际操作指令。在此处，您需明确定义代理应执行的任务、其行为方式，以及在使用该技能时须遵循的任何具体准则。

## Which SKILL.md frontmatter fields are optional?

## 哪些 `SKILL.md` 前置元数据（frontmatter）字段是可选的？

Optional frontmatter fields include `license`, `compatibility` (max 500 characters), `metadata` (arbitrary string-to-string key-value mappings), and `allowed-tools`.

可选的前置元数据字段包括 `license`（许可证）、`compatibility`（兼容性，最多 500 个字符）、`metadata`（任意字符串到字符串的键值映射）以及 `allowed-tools`（允许使用的工具）。

These fields let a team communicate constraints and environment requirements without baking them into the prose.

这些字段使团队能够在不将约束和环境要求硬编码进正文描述的前提下，清晰传达相关限制与运行环境需求。

## What else can a skill include?

## 技能还可以包含哪些内容？

A skill can be more than a single instruction file.

一项技能不仅限于单个指令文件。

Alongside `SKILL.md`, a skill directory can include a `scripts/` directory for executable helpers, which are useful when you want a step to run the same way every time. A `references/` directory holds longer supporting docs the agent can load only when it needs them. An `assets/` directory contains files that support the skill's output, like templates, examples, or other artifacts.

除 `SKILL.md` 外，技能目录还可包含：  
- `scripts/` 目录，用于存放可执行辅助脚本——适用于需要确保某一步骤每次均以完全相同方式运行的场景；  
- `references/` 目录，用于存放篇幅较长的补充文档，代理仅在需要时才加载；  
- `assets/` 目录，用于存放支持技能输出的各类文件，例如模板、示例或其它产物。

These are optional, but they add advanced functionality, simplify `SKILL.md`, and keep long reference material out of the default context.

这些均为可选组件，但它们能增强技能的功能性、简化 `SKILL.md` 的内容，并将冗长的参考材料从默认上下文中剥离。

## What is the scripts directory for?

## `scripts/` 目录的作用是什么？

`scripts/` can contain executable helpers.

`scripts/` 目录可用于存放可执行的辅助脚本。

This can make skills more token-efficient and more deterministic, because the agent can run a script instead of re-deriving a multi-step procedure in natural language.

这可以使技能更加节省 token，也更具确定性，因为智能体可以运行脚本，而无需在自然语言中重新推导多步骤流程。

Scripts also make review easier. If there is a step that must be correct every time, a script is often more auditable than a paragraph.

脚本还使审查更加便捷。如果某一步骤每次执行都必须准确无误，那么脚本通常比一段文字更易于审计。

## What is the references directory for?

## `references/` 目录的用途是什么？

`references/` is for supporting documents that are designed to be loaded on demand.

`references/` 目录用于存放按需加载的支持性文档。

This fits a progressive disclosure model. An agent can see summaries first, then load full content only when it needs the details.

这符合渐进式披露（progressive disclosure）模型：智能体可先查看摘要，仅在需要细节时才加载完整内容。

One practical best practice is to avoid duplicating the same information in both `SKILL.md` and `references/`.

一项实用的最佳实践是：避免在 `SKILL.md` 和 `references/` 中重复相同的信息。

If a reference file is huge, include grep search patterns in `SKILL.md` so an agent can locate the right section quickly.

若某参考文件体积庞大，可在 `SKILL.md` 中提供 `grep` 搜索模式，以便智能体快速定位到正确段落。

## Other common questions about skills

## 关于技能的其他常见问题

**Are skills secure?**

**技能是否安全？**

A useful mental model is that skills change how an agent behaves. Like any AI tool, they do not magically make the agent trustworthy. If a skill package includes scripts, treat them like any other code you run. Review what it does, pin versions where you can, and prefer packages that are designed to be auditable.

一个有用的思维模型是：技能会改变智能体的行为方式。与任何 AI 工具一样，它们并不会“神奇地”让智能体变得可信。如果某个技能包中包含脚本，则应将其视作你运行的任何其他代码来对待：务必审查其具体行为，在可能的情况下锁定版本，并优先选用专为可审计性而设计的技能包。

**What are alternatives to skills?**

**技能的替代方案有哪些？**

You can also use prompt libraries, repo-level instruction files like `AGENTS.md`, or custom agent wrappers. The industry is converging on skills as a shared standard, so they are the recommended approach for most teams.

您还可以使用提示词库（prompt libraries）、仓库级说明文件（如 `AGENTS.md`），或自定义的智能体封装器（custom agent wrappers）。目前行业正逐步将“技能”（skills）确立为一种通用标准，因此对大多数团队而言，技能是推荐采用的方法。

## Why skills matter

## 为何技能至关重要

Teams are going to spend more time supervising agents.

团队将花费更多时间监督智能体的行为。

If the only place your context and conventions live is in someone's chat history, you cannot review them, update them systematically, or debug them when something goes wrong.

如果您的上下文信息和约定仅存在于某人的聊天记录中，那么您就无法对其进行审查、系统性地更新，或在出现问题时有效调试。

Skills make agent behavior easier to standardize.

技能有助于标准化智能体的行为。

They also make it easier to improve over time. You can ship a better workflow as a change to a skill package, not as a new prompt someone has to remember.

它们也使持续优化变得更加容易。您可以通过更新一个技能包（skill package）来交付更优的工作流，而无需依赖某个需要人工记忆的新提示词（prompt）。

## Skills resources

## 技能相关资源

- [Agent Skills](https://agentskills.io/home): Learn about the open standard for skills

- [Agent Skills](https://agentskills.io/home)：了解技能的开放标准

- [Skills.sh](https://skills.sh/): Search for and discover agent skills

- [Skills.sh](https://skills.sh/)：搜索并发现各类智能体技能

- [npx skills](https://www.npmjs.com/package/skills): 面向开放智能体技能生态系统的命令行工具（CLI）

- [npx skills](https://www.npmjs.com/package/skills)：开放智能体技能生态系统的命令行工具（CLI）
{% endraw %}
