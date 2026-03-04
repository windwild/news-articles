---
title: "How DocentPro Built a Multi-Agent Travel Companion with LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-docentpro/"
date: "2025-04-29"
scraped_at: "2026-03-03T07:33:55.318479560+00:00"
language: "en-zh"
translated: true
description: "See how DocentPro built a multi-agent system in LangGraph and traces and monitors interactions with LangSmith for their AI search itinerary agent"
tags: ["Case Studies"]
---
&#123;% raw %}

[DocentPro](https://docentpro.ai/?ref=blog.langchain.com) is building an AI travel platform that helps travelers figure out where to go, what to do, and how to plan.

[DocentPro](https://docentpro.ai/?ref=blog.langchain.com) 正在构建一个 AI 旅行平台，帮助旅行者确定去哪里、做什么以及如何规划行程。

People love using ChatGPT and Perplexity for trip research - and they’re great at surfacing ideas. But to DocentPro, travel isn’t just about a research – it’s about creating a streamlined experience from discovery to planning to booking. These tools often stop short. You still end up mapping routes, comparing ratings, scanning reviews, and bouncing between apps to make it all work.

人们热衷于使用 ChatGPT 和 Perplexity 进行旅行调研——它们在激发创意和呈现灵感方面表现卓越。但对 DocentPro 而言，旅行远不止于信息检索，而是一个从发现目的地、制定计划到完成预订的无缝衔接体验。而现有工具往往止步于此：你仍需手动规划路线、比对评分、浏览评论，并在多个应用之间来回切换，才能让整个流程真正落地。

To solve that, they built a modular multi-agent system using LangGraph and LangSmith, blending the creativity of LLMs with the precision of deterministic logic, and designing reusable agents that work across trip planning and real-time conversation.

为解决这一问题，他们基于 LangGraph 和 LangSmith 构建了一套模块化多智能体系统，将大语言模型（LLM）的创造性与确定性逻辑的精准性相结合，并设计出可复用的智能体，使其同时适用于行程规划与实时对话场景。

## Building Modular Agents that Work Across the Stack

## 构建贯通全栈的模块化智能体

DocentPro broke down the travel planning agent into four domains: attractions, restaurants, hotels, and activities. Each of these is managed by its own agent, and each agent is designed to be modular and reusable. That means the Restaurant Research Agent, for example, isn't just used in their trip planner to suggest meals for each day. The same agent is also called by their chat assistant when a user asks, "Where’s a good place to eat nearby?"

DocentPro 将旅行规划智能体拆解为四大领域：景点、餐厅、酒店和活动。每个领域均由独立的智能体负责管理，且每个智能体均按模块化与可复用原则设计。例如，“餐厅调研智能体”不仅用于行程规划器中为每日行程推荐用餐地点，当用户向聊天助手提问“附近有什么好吃的地方？”时，该智能体同样会被调用。

This approach helps the DocentPro team avoid duplicating logic, keep things consistent, and make their agents easier to test and improve. With LangGraph, each part of the system is composed as a clear, traceable node - and with LangSmith, they can debug and refine behavior step-by-step. DocentPro thinks of this as a small but important step toward more collaborative AI - where agents don’t just operate in isolation, but work together across different workflows.

这一方法帮助 DocentPro 团队避免逻辑重复、保障系统一致性，并使智能体更易于测试与迭代优化。借助 LangGraph，系统的每一部分都被构建成清晰、可追溯的节点；借助 LangSmith，团队可逐环节调试并精细化调整智能体行为。DocentPro 将此视为迈向更具协作性的 AI 的一小步——在此范式中，智能体不再彼此孤立运行，而是能在不同工作流间协同配合。

## Balancing LLM Flexibility with Deterministic Control

## 在大语言模型的灵活性与确定性控制之间取得平衡

While LLMs are great at coming up with interesting ideas - like suggesting popular local spots - they don’t always stick to reality. Furthermore, while LLMs are great at suggesting interesting places, especially well-known spots, they often build itineraries based solely on what they “know,” not how people actually move. The result? Plans that zigzag across the regions in a day without considering realistic routes.

尽管大语言模型擅长提出有趣的想法——例如推荐当地热门场所——但其输出并不总能严格符合现实。此外，虽然 LLM 擅长推荐有趣的地点（尤其是广为人知的地标），但它们常常仅依据自身“所知”来编排行程，而非依据人们真实的移动方式。结果如何？便是一日行程在区域内反复折返、东奔西走，却完全忽视了实际可行的路线规划。

![](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_001.png)

![](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_001.png)

That’s why DocentPro built guardrails into the system to keep outputs grounded. This involved:  

正因如此，DocentPro 在系统中嵌入了多重“护栏”（guardrails），以确保输出结果始终立足现实。具体措施包括：

- **K-Means clustering** to group points of interest by geography  
- **K-Means 聚类**：按地理位置对兴趣点进行分组  

- **Route reordering** to minimize unnecessary travel  
- **路线重排**：最大限度减少不必要的行程  

- **Filtering** out hallucinated or closed places  
- **过滤**：剔除幻觉生成或已关闭的场所  

- LLM-generated explanations for every recommendation  
- 每项推荐均由大语言模型（LLM）生成解释说明  

This hybrid approach helps DocentPro strike the right balance between helpful suggestions and practical plans that users can actually follow.  
这种混合式方法帮助 DocentPro 在“富有帮助性的建议”与“用户真正可执行的实用计划”之间取得恰到好处的平衡。

## Observability and Debugging with LangSmith  
## 借助 LangSmith 实现可观测性与调试  

LangSmith has been essential in helping DocentPro make their system reliable. They use it to:  
LangSmith 对 DocentPro 构建高可靠性系统起到了关键作用。他们借助 LangSmith 实现以下目标：  

- Trace and monitor every LangGraph run  
- 追踪并监控每一次 LangGraph 运行  

- Quickly inspect where things go wrong (or right)  
- 快速定位问题发生（或成功运行）的具体环节  

- Understand how users are interacting with our agents  
- 深入理解用户如何与我们的智能体（agents）交互  

- Replay sessions to iterate faster and improve behavior  
- 回放会话以加速迭代，并持续优化智能体行为  

It’s especially helpful in a multi-agent system, where it’s easy to lose track of who’s doing what. With LangSmith, the DocentPro team always has visibility into the decision-making process.  
在多智能体系统中，各智能体职责易混淆、协作流程难追溯——而 LangSmith 正好解决了这一痛点。借助 LangSmith，DocentPro 团队始终能清晰掌握整个决策过程。

### Adding support for Audio Guides in 12 Languages  
### 新增支持 12 种语言的语音导览功能  

One of the earlier features DocentPro built was an on-demand audio guide system for global attractions. They initially implemented it with a custom RAG pipeline — but as they added support for 12 languages and more locations, maintaining and scaling the system became painful.  
DocentPro 较早推出的特性之一，是面向全球景点的按需语音导览系统。该系统最初基于自研的 RAG 流水线实现；但随着支持语言扩展至 12 种、覆盖地点持续增加，系统的维护与规模化变得愈发困难。

As a result, DocentPro decided to port their architecture to LangGraph in just two days, using a map-reduce style workflow tailored for content generation. This means that:  
因此，DocentPro 仅用两天时间便将原有架构迁移至 LangGraph，并采用专为内容生成设计的 Map-Reduce 风格工作流。这意味着：  

- For each point of interest, they break it down into multiple topics (e.g. history, architecture, fun facts)  
- 针对每个兴趣点，将其拆解为多个主题（例如：历史背景、建筑特色、趣味冷知识）  

- Each topic is passed through a chain of agents: research ⇒ narrative generation (RAG) ⇒ translation ⇒ TTS (Text to Speech)  
- 每个主题依次经由一连串智能体处理：资料检索 ⇒ 叙事生成（RAG） ⇒ 多语言翻译 ⇒ 文本转语音（TTS）  

- Final outputs are then aggregated into structured, per-language audio playlists  
- 最终输出被聚合为结构化、按语言组织的音频播放列表

![](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_002.jpg)

LangSmith 帮助 DocentPro 追踪并调试早期运行过程，如今该系统已实现全球规模化部署，且开销极低。

### The Result

### 成果

DocentPro 当前的系统：

- 在行程规划与聊天场景中，采用模块化、面向特定领域的智能体（agents）  
- 将确定性算法与基于大语言模型（LLM）的推理能力相结合  
- 通过 LangSmith 实现全流程可追溯、可持续优化  
- 为全球旅行者提供 AI 生成的行程规划及多语言语音导览服务  

DocentPro 正持续优化其智能体之间的协作方式，并不断探索如何为灵活多变的旅行体验注入结构化支持——一次行程，一步精进。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-docentpro-built-a-multi-agent-travel-companion-with-langgraph/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
