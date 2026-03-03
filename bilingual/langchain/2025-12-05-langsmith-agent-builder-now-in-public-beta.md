---
title: "LangSmith Agent Builder now in Public Beta"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/"
date: "2025-12-05"
scraped_at: "2026-03-03T07:16:20.278252035+00:00"
language: "en-zh"
translated: true
description: "Now anyone can create production ready agents without writing code, just chat.
Agent Builder guides you from initial idea to deployed agent, creating detailed prompts, selecting required tools, and ev..."
tags: ["agent builder", "agents"]
---

Today, we're expanding who can build agents. Now, anyone can create production ready agents without writing code using LangSmith Agent Builder.

今天，我们正在扩大能够构建智能体（agents）的用户群体。现在，任何人都可以借助 LangSmith Agent Builder，无需编写代码，即可创建可用于生产环境的智能体。

LangSmith Agent Builder is different from traditional AI workflow builders. Workflows require users to define a step-by-step approach to accomplish each task, with small components delegated to LLMs. They follow a fixed path and require a lot of thinking on edge cases up front. Agents, on the other hand, are dynamic. They reason on the fly and adapt to new information.  We believe that for a wide range of productivity use cases, agents are better than workflows because they can:

LangSmith Agent Builder 与传统的 AI 工作流（workflow）构建工具截然不同。工作流要求用户为每项任务明确定义逐步执行的流程，仅将其中细小环节交由大语言模型（LLM）处理；其执行路径是固定的，且需在设计初期就大量考虑各种边界情况。而智能体则是动态的：它们能实时推理，并根据新信息灵活调整。我们认为，在广泛的生产力应用场景中，智能体优于工作流，原因在于它们能够：

- **Figure out the appropriate steps to take.** No need to map out every tool, action, or sequence. Agents can even create a plan and delegate complex work to subagents autonomously.  
- **自主确定恰当的执行步骤。** 无需预先枚举所有工具、操作或执行顺序。智能体甚至可自主制定计划，并将复杂任务委派给子智能体（subagents）完成。

- **Work on tasks until the job is complete** by calling tools in a loop. For instance, agents can work over long time horizons, make multiple searches across different tools, synthesize findings, and keep going until they have what’s needed.  
- **持续执行任务直至完成**，通过循环调用各类工具实现。例如，智能体可在较长的时间跨度内运行，在多个工具间反复搜索、整合结果，并持续迭代，直至获取所需全部信息。

- **Improve with your feedback.** Agents can accurately execute a task over the course of a conversation with short-term memory. Or they can use long-term memory to capture your feedback and preferences, improve over time, and deliver reliably good results.  
- **基于您的反馈持续优化。** 智能体可借助短期记忆，在单次对话中精准完成任务；也可利用长期记忆记录您的反馈与偏好，随时间推移不断改进，从而稳定输出高质量结果。

So for LangSmith Agent Builder, we skipped the if-this-then-that canvas and went straight to a proper agent. We aimed to combine as much power as possible, with the easiest mode to create: chat.

因此，在设计 LangSmith Agent Builder 时，我们跳过了“如果…那么…”式的工作流画布（canvas），直接构建了一个真正意义上的智能体。我们的目标是：在保留尽可能强大能力的同时，采用最简易的创建方式——即聊天（chat）。

[Try LangSmith Agent Builder for free](https://smith.langchain.com/?ref=blog.langchain.com).

[免费试用 LangSmith Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com)。

## **As simple as Slacking a teammate**

## **简单得就像给同事发一条 Slack 消息**

Creating an agent with Agent Builder is easy. Using chat, Agent Builder guides you from your initial idea to a deployed agent, creating detailed prompts and selecting the tools required to achieve your tasks.

使用 Agent Builder 创建智能体非常简单。借助聊天界面，Agent Builder 将引导您从最初的想法出发，一步步完成智能体的构建与部署，自动生成详尽的提示词（prompts），并为您选择完成任务所需的工具。

Under the hood, Agent Builder is yet another agent designed to help you build _your_ agent. It uses best practices we’ve learned by working with millions of developers around the world who are building and deploying agents at scale — from hyper-growth startups to industry-leading enterprises. That means you can create agents in a few minutes without code, while leaning on agent engineering principles employed by enterprise-grade production agents.

在底层实现上，Agent Builder 本身也是一个智能体——专为帮助您构建 *您自己的* 智能体而设计。它融合了我们与全球数百万开发者协作过程中积累的最佳实践：这些开发者正从高速成长的初创公司到行业领军企业，大规模构建并部署智能体。这意味着，您无需编写任何代码，几分钟内即可创建出智能体，同时还能依托企业级生产智能体所采用的智能体工程（agent engineering）原则。

Since launching Agent Builder in private preview in October, users have built thousands of agents that handle everything from sales prospect research to bug ticket creation to email triage to sourcing talent. Now we're releasing Agent Builder in public beta for all LangSmith users, along with new tools, model options, and all new workspaces that make it simple to create, share, and collaborate across teams.

自去年 10 月 Agent Builder 进入私有预览以来，用户已构建了数千个智能体，应用场景涵盖销售线索调研、缺陷工单创建、邮件分类筛选，以及人才寻源等。如今，我们面向所有 LangSmith 用户正式发布 Agent Builder 公开测试版（public beta），并同步推出全新工具、更多模型选项，以及功能完备的全新工作区（workspaces），让团队内的创建、共享与协作变得前所未有的简单。

## **What's new with the beta release**

## **本次公开测试版新增特性**

- **Bring your own tools:** Connect external APIs and internal systems via an MCP server, then use those tools in your agents. Your team gets access to the capabilities you approve.  
- **自带工具：** 通过 MCP 服务器连接外部 API 和内部系统，随后即可在您的智能体（agents）中调用这些工具。您的团队仅能访问您已批准的功能。

- **Workspace agents:** Browse, copy, and customize agents across your workspace. When someone builds something useful, everyone can adapt it for their own needs. One-click cloning means you don’t start from scratch.  
- **工作区智能体：** 在您的工作区内浏览、复制并自定义智能体。当某位成员构建出一个实用的智能体时，其他成员均可根据自身需求快速调整复用。“一键克隆”功能让您无需从零开始。

- **Multi-model support:** Choose between OpenAI and Anthropic models depending on your task and preferred model.  
- **多模型支持：** 根据具体任务与偏好，在 OpenAI 和 Anthropic 模型之间灵活切换。

- **Programmatic invocation:** Call agents via API to embed them into existing workflows and systems.  
- **程序化调用：** 通过 API 调用智能体，将其无缝嵌入现有工作流与系统中。

- **Simplified UI:** We've moved Agent Builder into its own tab in LangSmith, making it easier and faster for anyone in your company to create and manage agents without needing to understand tracing, observability, or evals in LangSmith.  
- **简化用户界面：** 我们已将 Agent Builder 独立为 LangSmith 中的一个专属标签页，使公司内任何员工都能更轻松、更高效地创建和管理智能体，而无需掌握 LangSmith 中的追踪（tracing）、可观测性（observability）或评估（evals）等复杂概念。

## **Build an agent in 5 minutes**  
## **5 分钟内构建一个智能体**

We’ve consistently heard two challenges with AI adoption from our customers.  
我们持续从客户处听到关于 AI 落地应用的两大挑战：

1. **It’s hard to get the right tools in place.** Team members want to use AI to increase productivity, but writing effective LLM prompts takes expertise, workflow automation tools have steep learning curves, and it's hard to know which tasks can be automated reliably. The result? Many people default to repetitive LLM chat instead of purpose-built agents.  
1. **难以快速部署合适的工具。** 团队成员希望借助 AI 提升工作效率，但编写高效的 LLM 提示词需要专业知识；工作流自动化工具学习门槛高；且难以判断哪些任务可被稳定、可靠地自动化。结果是？许多人最终只能反复使用通用型 LLM 聊天，而非构建面向特定目标的专用智能体。

2. **Technical teams need to balance speed, security, and employee autonomy.** Giving people the flexibility to customize their own agents accelerates adoption and innovation, but those agents need the right guardrails.  
2. **技术团队需兼顾速度、安全与员工自主权。** 赋予员工自定义智能体的灵活性，有助于加速 AI 的普及与创新；但这些智能体必须配备恰当的安全护栏（guardrails）。

Agent Builder addresses both of these challenges. It gives every employee an intuitive way to create agents, and it gives technical teams the ability to govern tools across the organization.  
Agent Builder 正是为应对这两大挑战而生：它为每位员工提供直观易用的智能体创建方式，同时赋予技术团队对全组织工具使用的统一管控能力。

### **You operate like a manager, not a programmer**  
### **您以管理者的方式操作，而非程序员**

You describe what you want the agent to do, approve the right tools, and let your agent figure out the approach. Agent Builder helps you write the prompt, which often can be several paragraphs long or longer, and the agent uses long-term memory to learn from your feedback over time.  
您只需描述期望智能体完成的任务、审批所需工具，其余交由智能体自行规划执行路径。Agent Builder 协助您撰写提示词——其长度往往达数段甚至更长；智能体则依托长期记忆机制，持续从您的反馈中学习优化。

![Agent Builder prompt](images/langsmith-agent-builder-now-in-public-beta/img_001.png)  
![Agent Builder 提示词界面](images/langsmith-agent-builder-now-in-public-beta/img_001.png)

### **Update agents with natural language**  
### **用自然语言更新智能体**

Need to extend or modify what your agent does? Just tell Agent Builder what to update. The agent stores your guidance in its system prompt. No rebuilding workflows.  
需要扩展或调整智能体的功能？只需用自然语言告诉 Agent Builder 如何修改。智能体会将您的指导直接存入其系统提示词（system prompt）中，无需重新构建整个工作流。

![Update agent system prompt](images/langsmith-agent-builder-now-in-public-beta/img_002.png)

![更新代理系统提示词](images/langsmith-agent-builder-now-in-public-beta/img_002.png)

### **跨团队复用与安全规模化代理**

### **安全地跨团队复用并规模化部署代理**

Our new Agent Workspace lets you create templates that team members can clone and customize. Technical teams can provide secure access to internal tools through MCP servers, while non-technical teams can build on top of approved tools and authenticate using OAuth, without needing IT support for every change to an agent.

我们全新的“代理工作区”（Agent Workspace）支持创建可被团队成员克隆与自定义的模板。技术团队可通过 MCP 服务器为内部工具提供安全访问；非技术团队则可在已批准的工具基础上构建代理，并使用 OAuth 进行身份认证——无需每次修改代理都寻求 IT 支持。

![Workspace Agents](images/langsmith-agent-builder-now-in-public-beta/img_003.png)

![工作区中的代理](images/langsmith-agent-builder-now-in-public-beta/img_003.png)

## **人们正在构建什么**

## **用户实际构建的应用场景**

It’s early days for Agent Builder, but we’re already seeing a few interesting patterns emerge.

Agent Builder 尚处于早期阶段，但我们已观察到若干颇具启发性的应用模式正在浮现。

### **面向特定角色的研究型代理**

### **按角色定制的研究型代理**

Nearly everyone does regular research for their work. Sales teams research prospects, marketers research competitors, recruiters research candidates. These tasks require multiple steps: find information (often across multiple sources), analyze it, synthesize key details, and turn insights into something useful like sending a message to your team or drafting an email. It's time-intensive, and it's hard to maintain depth when you're juggling other work.

几乎每位职场人士都需要定期开展研究工作：销售团队研究潜在客户，市场人员研究竞品，招聘人员研究候选人。这类任务通常包含多个步骤：从（常为多个）信息源中搜集资料、分析内容、提炼关键要点，并将洞察转化为实用成果——例如向团队发送消息，或草拟一封邮件。整个过程耗时较长；而当人们同时处理多项任务时，更难保证研究的深度。

These deep research tasks also require a feature that’s unique to agents. This process of research and analysis is possible because agents call tools and evaluate the result in a loop, continuing until determining that task is complete. This approach isn’t possible with a deterministic workflow builder in which tasks follow a predetermined path from beginning to end.

此类深度研究任务还依赖于代理所独有的核心能力：正是通过循环调用工具、评估返回结果，并持续迭代直至判定任务完成，才使这种研究与分析流程成为可能。而确定性工作流构建器（deterministic workflow builder）则无法实现这一点——其任务路径是预先设定、从始至终固定不变的。

We've seen teams build research agents that cut hours-long processes down to background tasks that take a few minutes. And because the research happens automatically, teams can do it daily or weekly instead of waiting for rare blocks of focus time.

我们已看到不少团队构建出研究型代理，将原本耗时数小时的流程压缩为仅需几分钟即可在后台自动完成的任务。正因研究过程完全自动化，团队得以将其设为每日或每周例行操作，而不再被动等待难得的整块专注时间。

- **Sales:** Create a daily research report for each of your customer calls with an agent that reviews your calendar, creates a list of participants, searches relevant news, finds relevant past interactions and notes, and sends you a report each morning.  
- **销售：** 利用智能体为您每次客户通话自动生成每日调研报告——该智能体可自动查阅您的日历、列出参会人员、检索相关行业新闻、查找过往互动记录与备注，并于每天清晨向您发送报告。

- **Marketing:** Stay on top of competitors with a weekly update on news, announcements, events, and product launches that impact your GTM strategy. Turn hours of research into a background task and get alerts sent to your team Slack channel. [In this demo](https://youtu.be/2GeTGEVyPfo?ref=blog.langchain.com), we show how to create a market research agent in just a few minutes.  
- **市场营销：** 借助每周竞品动态简报（涵盖新闻、官方公告、行业活动及新品发布等影响您上市策略的关键信息），实时掌握竞争格局。将原本耗时数小时的手动调研转为后台自动化任务，并将关键提醒直接推送至团队 Slack 频道。[本演示视频](https://youtu.be/2GeTGEVyPfo?ref=blog.langchain.com) 展示了如何仅用几分钟即可构建一个市场调研智能体。

- **Recruiting:** Run a daily search for candidates that meet your target profile, prioritize them by the criteria that matter most, and have your agent draft an outbound message that you can review and approve, or edit and send.  
- **招聘：** 每日自动筛选符合目标画像的候选人，依据您最关注的维度（如技能匹配度、经验年限、文化契合度等）进行优先级排序，并由智能体草拟外联消息——您可审阅后直接批准发送，或修改后再发出。

### **Turning ambient information into tracked projects**  
### **将环境信息转化为可追踪项目**

If your team uses a ticketing system, such as for product and customer support, you know the friction of navigating multiple systems to create, update, and report on issues.  
若您团队使用工单系统（例如用于产品与客户支持场景），您一定深谙在多个系统间切换以创建、更新和汇报问题所带来的操作摩擦。

Natural language is a fast way to get from idea to execution. Teams are building agents that create Linear issues from Slack messages, analyze ticket trends on a schedule, and generate weekly reports with action items.  
自然语言是实现“想法→执行”的最快路径。各团队正构建智能体：从 Slack 消息自动生成 Linear 工单、按计划分析工单趋势、并生成含明确待办事项的周度报告。

- **Product and engineering:** Create or update an existing Linear issue when someone in your product channel messages about a bug. Fill in details for scope, priority, and owner based on relevant information available in Slack, Salesforce, or Gong. Learn how to build a Linear issue agent [in this demo](https://youtu.be/SJcZIshin1w?ref=blog.langchain.com).  
- **产品与工程：** 当产品频道中有人提及 Bug 时，自动创建或更新一条 Linear 工单；并基于 Slack、Salesforce 或 Gong 中的相关信息，自动填充范围（scope）、优先级（priority）与负责人（owner）等字段。[本演示视频](https://youtu.be/SJcZIshin1w?ref=blog.langchain.com) 将指导您如何构建 Linear 工单智能体。

- **Customer support:** Send your team a weekly Slack or email summary of Pylon tickets with trends and action items customized for each individual.  
- **客户支持：** 向团队成员定期（每周）推送 Slack 或邮件摘要，内容涵盖 Pylon 工单统计趋势与个性化待办事项。

- **Developer Education:** Monitor GitHub contributions and get recommendations for new docs based on repo changes.  
- **开发者教育：** 监控 GitHub 代码库贡献动态，并根据仓库变更自动生成新文档撰写建议。

### **Communication and time-saving assistants**  
### **沟通与提效助手**

One of the most common use cases is also one of the simplest: small tasks that add up to significant time savings. Think of these as simple tasks that would take an engineer hours to code. But with Agent Builder, they take a few minutes to create and can save hours each week.  
最常见也最基础的一类应用场景，恰恰是那些看似微小却能积少成多、显著节省时间的任务——若由工程师手动编码实现，可能需耗时数小时；而借助 Agent Builder，只需几分钟即可完成搭建，每周却可为您节省数小时。

- **Email:** Make sure you respond to high priority messages while clearing inbox clutter. Create an email assistant that reads, labels, prioritizes, and drafts responses to inbound messages. You review and approve or edit and send. We show how to create an email agent [in this demo](https://youtu.be/PwldOnb0eiU?ref=blog.langchain.com).  
- **邮件：** 确保及时响应高优先级来信，同时高效清理收件箱冗余信息。构建一个邮件助手智能体，自动阅读、打标、分级并草拟回信；您只需审阅后批准发送，或稍作修改再发出。[本演示视频](https://youtu.be/PwldOnb0eiU?ref=blog.langchain.com) 将展示如何快速创建邮件智能体。

- **Calendar:** Want at least two hours of focus time each day? Build an agent that monitors your calendar and blocks time when meetings exceed the threshold you specify.  
- **日历：** 是否希望每天至少保留两小时专注工作时间？构建一个日历监控智能体，当会议安排超出您设定的阈值时，自动为您预留并锁定空闲时段。

- **Slack:** Stay on top of active Slack channels without constant context-switching. Get a summarized report with action items at the end of each day (or the cadence of your choice).  
- **Slack：** 无需频繁切换上下文，即可全面掌握活跃 Slack 频道动态。每日（或按您自定义周期）接收一份汇总简报，内含关键信息与待办事项。

## **What's next**  
## **下一步计划**

We're continuing to learn as more people put Agent Builder to work. If you're already using it, we'd love to hear what you're building and what you’d like to see next through our [Slack Community](https://www.langchain.com/join-community?ref=blog.langchain.com).  
随着越来越多用户将 Agent Builder 投入实际应用，我们也在持续学习与迭代。若您已在使用该工具，诚挚邀请您加入我们的 [Slack 社区](https://www.langchain.com/join-community?ref=blog.langchain.com)，分享您的构建成果，并告诉我们您期待的下一项功能！

If you're not using Agent Builder yet, you can [try it for free using LangSmith](https://langsmith.com/?ref=blog.langchain.com) today.

如果您尚未使用 Agent Builder，今天即可[通过 LangSmith 免费试用](https://langsmith.com/?ref=blog.langchain.com)。

### Tags

### 标签

[agent builder](https://blog.langchain.com/tag/agent-builder/)

[agent builder](https://blog.langchain.com/tag/agent-builder/)

[![Introducing Agent Builder templates](images/langsmith-agent-builder-now-in-public-beta/img_004.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板库](images/langsmith-agent-builder-now-in-public-beta/img_004.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**借助 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 分钟阅读

[![LangSmith Agent Builder Now Generally Available](images/langsmith-agent-builder-now-in-public-beta/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布](images/langsmith-agent-builder-now-in-public-beta/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**正式发布：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 min read

[agents](https://blog.langchain.com/tag/agents/) 2 分钟阅读

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/langsmith-agent-builder-now-in-public-beta/img_006.png)](https://blog.langchain.com/introducing-align-evals/)

[![推出 Align Evals：简化大语言模型应用评估流程](images/langsmith-agent-builder-now-in-public-beta/img_006.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)

[**推出 Align Evals：简化大语言模型应用评估流程**](https://blog.langchain.com/introducing-align-evals/)


[![Catch production failures early with LangSmith Alerts](images/langsmith-agent-builder-now-in-public-beta/img_007.png)](https://blog.langchain.com/langsmith-alerts/)

[![借助 LangSmith Alerts 及早发现生产环境故障](images/langsmith-agent-builder-now-in-public-beta/img_007.png)](https://blog.langchain.com/langsmith-alerts/)

[**Catch production failures early with LangSmith Alerts**](https://blog.langchain.com/langsmith-alerts/)

[**借助 LangSmith Alerts 及早发现生产环境故障**](https://blog.langchain.com/langsmith-alerts/)


[![Pairwise Evaluations with LangSmith](images/langsmith-agent-builder-now-in-public-beta/img_008.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![使用 LangSmith 进行成对评估（Pairwise Evaluations）](images/langsmith-agent-builder-now-in-public-beta/img_008.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**使用 LangSmith 进行成对评估（Pairwise Evaluations）**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)


[![Access Control Updates for LangSmith](images/langsmith-agent-builder-now-in-public-beta/img_009.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[![LangSmith 访问控制功能更新](images/langsmith-agent-builder-now-in-public-beta/img_009.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**LangSmith 访问控制功能更新**](https://blog.langchain.com/access-control-updates-for-langsmith/)