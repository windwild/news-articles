---
render_with_liquid: false
title: "Top 5 LangGraph Agents in Production 2024"
source: "LangChain Blog"
url: "https://blog.langchain.com/top-5-langgraph-agents-in-production-2024/"
date: "2025-01-30"
scraped_at: "2026-03-03T07:41:18.456934418+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

2024 was the year that agents started to work in production. Not the wide-ranging, fully autonomous agents that people imagined with [AutoGPT](https://github.com/Significant-Gravitas/AutoGPT?ref=blog.langchain.com). But more vertical, narrowly scoped, highly controllable agents with custom [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/). It's still not easy to build these agents — but it's entirely possible.

2024 年是智能体（agents）开始投入实际生产应用的一年。这并非人们曾通过 [AutoGPT](https://github.com/Significant-Gravitas/AutoGPT?ref=blog.langchain.com) 所构想的那种覆盖广泛、完全自主的智能体，而是更垂直化、任务范围更聚焦、可控性更强的智能体，并搭载了定制化的 [认知架构](https://blog.langchain.com/what-is-a-cognitive-architecture/)。构建此类智能体依然不简单——但已完全可行。

We launched [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) in early 2024 as a new take on an agentic framework. Incorporating lessons learned from LangChain, we made LangGraph very low level, controllable agentic framework. No hidden prompts, no obfuscated " [cognitive architecture](https://blog.langchain.com/what-is-a-cognitive-architecture/)". Soon after it's launch, we saw LangGraph become the go-to default framework for agents.

我们于 2024 年初发布了 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)，作为对智能体框架的一次全新探索。在充分吸收 LangChain 的实践经验基础上，我们将 LangGraph 设计为一个极低层级、高度可控的智能体框架：不隐藏提示词（prompts），也不模糊封装所谓“[认知架构](https://blog.langchain.com/what-is-a-cognitive-architecture/)”。发布后不久，LangGraph 迅速成为构建智能体的首选默认框架。

As the year closes, we wanted to highlight some of our favorite stories of companies building agents with LangGraph. As mentioned before, it's still hard to build agents, but these companies have figured out how. They've shared their lessons learned in various forms — blogs, case studies, talks, fireside chats. We hope that by amplifying their stories, their lessons learned, it enables every more agents to be built in 2025.

随着这一年临近尾声，我们希望重点介绍几家使用 LangGraph 成功构建智能体的企业案例。如前所述，构建智能体仍具挑战性，但这些公司已摸索出切实可行的路径。他们以多种形式分享了宝贵经验——技术博客、案例研究、主题演讲、炉边对话等。我们相信，通过传播这些真实故事与实践洞见，将助力更多智能体在 2025 年落地生根。

## Honorable mentions:

## 值得嘉许的案例：

- [Unify](https://blog.langchain.com/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/): An agent for GTM account qualification, featuring o1 as a planning agent  
- [Unify](https://blog.langchain.com/unify-launches-agents-for-account-qualification-using-langgraph-and-langsmith/)：面向 GTM（Go-to-Market）场景的客户资质评估智能体，其中采用 o1 作为规划智能体。

- [OpenRecovery](https://blog.langchain.com/customers-openrecovery/): An innovative and forward-looking application, especially with respect to memory  
- [OpenRecovery](https://blog.langchain.com/customers-openrecovery/)：一款兼具创新性与前瞻性的应用，尤其在记忆（memory）机制设计方面表现突出。

- [Rexera](https://blog.langchain.com/customers-rexera/): Great example of "single agent → multi agent but uncontrollable (CrewAI) → controllable multi agent (LangGraph)" journey that we see many user go through  
- [Rexera](https://blog.langchain.com/customers-rexera/)：典型展现了用户普遍经历的演进路径：“单智能体 → 多智能体但不可控（如 CrewAI）→ 可控的多智能体（LangGraph）”。

- [Komodo Health](https://www.komodohealth.com/perspectives/new-gen-ai-assistant-empowers-the-enterprise/?ref=blog.langchain.com): Exciting to see agents working in highly-regulated domains like healthcare  
- [Komodo Health](https://www.komodohealth.com/perspectives/new-gen-ai-assistant-empowers-the-enterprise/?ref=blog.langchain.com)：令人振奋的是，智能体已成功应用于医疗等强监管领域。

- [Airtop](https://blog.langchain.com/customers-airtop/): Web agents are a big area, so it's great to see them for browser automation  
- [Airtop](https://blog.langchain.com/customers-airtop/)：网页智能体是重要应用方向，很高兴看到其被用于浏览器自动化任务。

- [Tradestack](https://blog.langchain.com/customers-tradestack/): The first public-facing agent launched on LangGraph platform  
- [Tradestack](https://blog.langchain.com/customers-tradestack/)：首个面向公众发布的、基于 LangGraph 平台构建的智能体。

- [Athena Intelligence](https://blog.langchain.com/customers-athena-intelligence/): One of the most advanced research agent platforms we know of  
- [Athena Intelligence](https://blog.langchain.com/customers-athena-intelligence/)：目前已知最先进的一批研究型智能体平台之一。

- [GPT Researcher](https://github.com/assafelovic/gpt-researcher/blob/master/docs/blog/2024-05-19-gptr-langgraph/index.md?ref=blog.langchain.com): The most advanced open-source research assistant  
- [GPT Researcher](https://github.com/assafelovic/gpt-researcher/blob/master/docs/blog/2024-05-19-gptr-langgraph/index.md?ref=blog.langchain.com)：目前最先进的开源研究助手。

## \#5: Uber

## \#5：Uber（优步）

At DPE, Uber talked about how they formed a dedicated Developer Platform AI team, and how they adopted LangGraph as a part of that. Especially interesting is how they are tackling large-scale code migrations with agentic systems.

在 DPE（Developer Productivity Engineering）大会上，Uber 分享了其组建专属“开发者平台 AI 团队”的历程，以及如何将 LangGraph 纳入该技术体系。尤为引人注目的是，他们正借助智能体系统应对大规模代码迁移这一复杂工程挑战。

We like this example because it shows that while general coding agents are undoubtably useful, there is also a large amount of value to be gained from building some internal coding tools yourself, which perform workflows that only really you know how to do best.

我们格外欣赏这一案例，因为它表明：尽管通用型编程智能体无疑极具价值，但企业自行构建内部专用编码工具同样能释放巨大潜力——这些工具所执行的工作流，往往只有企业自身才最清楚如何最优地完成。

- [DPE session video](https://dpe.org/sessions/ty-smith-adam-huda/this-year-in-ubers-ai-driven-developer-productivity-revolution/?ref=blog.langchain.com)  
- [DPE 大会视频回放](https://dpe.org/sessions/ty-smith-adam-huda/this-year-in-ubers-ai-driven-developer-productivity-revolution/?ref=blog.langchain.com)

## \#4: AppFolio

## \#4：AppFolio

AppFolio's AI-powered copilot Realm-X has saved property managers over 10 hours per week. Realm-X provides a conversational interface that helps users understand the state of their business, get help, and execute actions in bulk – whether it’s querying information, sending messages, or scheduling actions related to residents, vendors, units, bills, or work orders and many more.

AppFolio 推出的 AI 驱动型智能助手 Realm-X，已为物业管理者每周节省超 10 小时工作时间。Realm-X 提供对话式交互界面，帮助用户全面掌握业务现状、获取即时协助，并批量执行各类操作——无论是查询信息、发送消息，还是针对租户、供应商、房源单元、账单或工单等对象安排任务，皆可轻松完成。

On their journey, they needed a controllable agent architecture to make this a reality — and so they chose LangGraph.

在实现这一目标的过程中，他们需要一种可控性强的智能体（agent）架构——因此最终选择了 LangGraph。

- [Case study](https://blog.langchain.com/customers-appfolio/)

- [案例研究](https://blog.langchain.com/customers-appfolio/)

## \#3: LinkedIn

## \#3：LinkedIn

One of the big use cases for LLMs is in making data more accessible to everyone. LinkedIn recently rolled out SQL Bot, an AI-powered assistant internally.

大语言模型（LLM）的重要应用场景之一，是让数据对所有人更易访问。LinkedIn 近期在公司内部上线了 AI 助手 SQL Bot。

This internal tool transforms natural language questions into SQL: it finds the right tables, writes queries, fixes errors, and enables employees across functions to independently access the data insights they need under the appropriate permissions.

该内部工具可将自然语言提问自动转化为 SQL 查询：自动定位所需数据表、生成查询语句、修复语法或逻辑错误，并支持各职能部门员工在符合权限策略的前提下，自主获取所需的数据洞察。

Behind the scenes, SQL Bot is a multi-agent system built on top of LangChain and LangGraph.

在底层，SQL Bot 是一个基于 LangChain 和 LangGraph 构建的多智能体（multi-agent）系统。

- [LinkedIn Engineering Blog](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.com)

- [LinkedIn 工程博客](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.com)

## \#2: Elastic

## \#2：Elastic

Elastic was one of the first companies in my mind to launch an AI "agent". We covered their AI assistant in late January of 2024 - right at the start of the year. Back then it was using LangChain, but as they added more features, they migrated to LangGraph.

Elastic 是我脑海中最早推出 AI “智能体”的公司之一。我们在 2024 年 1 月下旬——即年初伊始——就曾报道过其 AI 助理。彼时该产品基于 LangChain 构建；而随着功能持续扩展，Elastic 后续迁移至 LangGraph。

- [Initial case study](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/)  
- [初始案例研究](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/)

- [Follow up blog](https://www.elastic.co/blog/building-automatic-import-attack-discovery-langchain?ref=blog.langchain.com)  
- [后续博客文章](https://www.elastic.co/blog/building-automatic-import-attack-discovery-langchain?ref=blog.langchain.com)

Excited to see the continued development of AI assistant!  
非常期待看到 AI 助手的持续发展！

## \#1: Replit  

## \#1：Replit

Replit released their agent this fall to pretty widespread adoption. When we've talked with them about the agent they've emphasized human-in-the-loop and multi-agent setup — both things we think will be key for agents in the future.  
Replit 今年秋季发布了其智能体（agent），并迅速获得了广泛采用。在与他们就该智能体展开的交流中，Replit 特别强调了“人在环路中”（human-in-the-loop）机制和多智能体架构——这两点我们都认为将是未来智能体发展的关键方向。

We've chatted with them a few times about Replit Agent:  
我们已就 Replit 智能体与他们多次交流：

- [Fireside Chat](https://www.youtube.com/watch?v=ViykMqljjxU&ref=blog.langchain.com)  
- [炉边畅谈](https://www.youtube.com/watch?v=ViykMqljjxU&ref=blog.langchain.com)

- [Case study](https://blog.langchain.com/customers-replit/)  
- [案例研究](https://blog.langchain.com/customers-replit/)

- [Breakout Agents](https://www.langchain.com/breakoutagents/replit?ref=blog.langchain.com)  
- [专题智能体展示](https://www.langchain.com/breakoutagents/replit?ref=blog.langchain.com)