---
title: "January 2026: LangChain Newsletter"
source: "LangChain Blog"
url: "https://blog.langchain.com/january-2026-langchain-newsletter/"
date: "2026-01-30"
scraped_at: "2026-03-02T10:08:13.297138260+00:00"
language: "en-zh"
translated: true
description: "Read about the latest product updates, events, and content from the LangChain team"
---
&#123;% raw %}

We’re kicking off 2026 with a fresh set of agent-building updates, improved experiment comparison, and new reads on observability and evaluation. Read on to see everything we’ve shipped this January.

我们以一系列全新的智能体（agent）构建更新、更完善的实验对比功能，以及关于可观测性（observability）与评估（evaluation）的深度文章，开启 2026 年。请继续阅读，了解本月（2026 年 1 月）我们发布的所有内容。

# Product Updates

# 产品更新

### LangSmith

### LangSmith

🚀 **LangSmith Agent Builder is now GA**

🚀 **LangSmith Agent Builder 现已正式发布（GA）**

Build agents with natural language. Describe what you want, and Agent Builder figures out the approach, including a detailed prompt, tool selection, subagents, and skills. [Try Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com).

使用自然语言构建智能体。只需描述您的需求，Agent Builder 将自动规划实现路径，包括生成详细提示词（prompt）、选择合适工具、编排子智能体（subagents）及调用所需技能。[立即试用 Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)。

📊 Spot regressions and improvements at a glance with side-by-side LLM experiment comparisons. Filter by inputs, outputs, status, or metadata to zero in on what matters. [Learn more.](https://docs.langchain.com/langsmith/compare-experiment-results?ref=blog.langchain.com#how-to-compare-experiment-results)

📊 通过并排式大语言模型（LLM）实验对比，一目了然地识别性能退化与优化点。支持按输入、输出、状态或元数据进行筛选，快速聚焦关键问题。[了解更多](https://docs.langchain.com/langsmith/compare-experiment-results?ref=blog.langchain.com#how-to-compare-experiment-results)。

🤖 Insights Agent automatically analyzes your traces to detect usage patterns, common agent behaviors and failure modes – and is [now available for self-hosted LangSmith customers.](https://changelog.langchain.com/announcements/langsmith-self-hosted-v0-13?ref=blog.langchain.com)

🤖 Insights Agent 可自动分析您的追踪记录（traces），识别使用模式、常见智能体行为及典型失败模式——现已面向自托管版 LangSmith 用户开放。[查看详情](https://changelog.langchain.com/announcements/langsmith-self-hosted-v0-13?ref=blog.langchain.com)。

### Open Source

### 开源项目

**LangChain JS v1.2.13** improves agent robustness with dynamic tools, recovery from hallucinated tool calls, and better streaming error signals. [Learn more.](https://github.com/langchain-ai/langchainjs/releases?ref=blog.langchain.com)

**LangChain JS v1.2.13** 通过动态工具支持、对幻觉型工具调用（hallucinated tool calls）的自动恢复能力，以及更清晰的流式传输错误信号，显著提升了智能体的鲁棒性。[了解更多](https://github.com/langchain-ai/langchainjs/releases?ref=blog.langchain.com)。

Stream live progress from subagents and surface who’s doing what as messages are generated in `deepagents`. [Learn more.](https://docs.langchain.com/oss/python/langchain/streaming/overview?ref=blog.langchain.com#streaming-from-sub-agents)

在 `deepagents` 中，实时流式输出各子智能体的执行进度，并清晰呈现“谁正在执行什么任务”，随消息生成同步更新。[了解更多](https://docs.langchain.com/oss/python/langchain/streaming/overview?ref=blog.langchain.com#streaming-from-sub-agents)。

* * *

# Interrupt 2026 — **门票将于 2 月 12 日开售**

# Interrupt 2026 — **门票将于 2 月 12 日开售**

5 月 13–14 日，诚邀您参加 Interrupt 2026——AI 智能体大会。门票将于 2 月 12 日起发售，数量有限，建议尽早注册。[立即报名](https://interrupt.langchain.com/?ref=blog.langchain.com)，第一时间获知开售通知。

5 月 13–14 日，诚邀您参加 Interrupt 2026——AI 智能体大会。门票将于 2 月 12 日起发售，数量有限，建议尽早注册。[立即报名](https://interrupt.langchain.com/?ref=blog.langchain.com)，第一时间获知开售通知。

* * *

# Speak the Lang

# 说“Lang”语

**智能体可观测性驱动智能体评估**

**智能体可观测性驱动智能体评估**

传统软件将追踪（tracing）与测试（testing）视为相互独立的环节；而对智能体而言，二者密不可分。交付高可靠性智能体的团队，均采用统一工作流——直接利用生产环境中的追踪数据驱动其评估过程。

传统软件将追踪（tracing）与测试（testing）视为相互独立的环节；而对智能体而言，二者密不可分。交付高可靠性智能体的团队，均采用统一工作流——直接利用生产环境中的追踪数据驱动其评估过程。

这为何重要：

这为何重要：

🔹 智能体行为仅在运行时才真正显现——追踪记录揭示了实际发生的情况  
🔹 评估智能体，意味着需检验其执行轨迹（trajectories）、输出结果（outputs）以及内部状态（state），而不仅限于最终答案  

🔹 智能体行为仅在运行时才真正显现——追踪记录揭示了实际发生的情况  
🔹 评估智能体，意味着需检验其执行轨迹（trajectories）、输出结果（outputs）以及内部状态（state），而不仅限于最终答案

🔹 Production traces become living test cases that shape what you evaluate next

🔹 生产环境中的追踪记录（traces）成为动态的测试用例，决定你下一步要评估的内容。

[Read more here](https://www.langchain.com/conceptual-guides/agent-observability-powers-agent-evaluation?ref=blog.langchain.com) on how traces become the foundation of an agent eval strategy.

[点击此处了解详情](https://www.langchain.com/conceptual-guides/agent-observability-powers-agent-evaluation?ref=blog.langchain.com)，了解追踪记录如何成为智能体（agent）评估策略的基础。

![](images/january-2026-langchain-newsletter/img_001.png)

![](images/january-2026-langchain-newsletter/img_001.png)

**Agent Builder’s memory is a filesystem**

**Agent Builder 的记忆机制基于文件系统**

Agents doing repeated tasks need to remember, so we gave Agent Builder memory using standard Markdown and JSON files. Here’s how we built it and what we learned. [Read more](https://www.langchain.com/conceptual-guides/how-we-built-agent-builders-memory?ref=blog.langchain.com).

执行重复性任务的智能体需要“记住”过往信息，因此我们为 Agent Builder 设计了基于标准 Markdown 和 JSON 文件的记忆机制。本文介绍其实现方式及我们的经验总结。[了解更多](https://www.langchain.com/conceptual-guides/how-we-built-agent-builders-memory?ref=blog.langchain.com)。

**New Agent Builder Academy Course**

**全新 Agent Builder 学院课程**

Learn how to build agents with LangSmith Agent Builder. We’ll cover set up, building and improving your agent, and then dive into Triggers, Subagents, MCP, and Skills. [Learn more](https://academy.langchain.com/courses/quickstart-agent-builder/?ref=blog.langchain.com).

学习如何使用 LangSmith Agent Builder 构建智能体。课程涵盖环境搭建、智能体开发与优化，并深入讲解触发器（Triggers）、子智能体（Subagents）、MCP（Model Control Protocol）以及技能（Skills）等核心概念。[立即了解](https://academy.langchain.com/courses/quickstart-agent-builder/?ref=blog.langchain.com)。

# New and Improved Resources

# 新增与优化资源

**Chat LangChain**

**Chat LangChain**

Meet the relaunch of [chat.langchain.com](http://chat.langchain.com/?ref=blog.langchain.com), a ChatGPT-like resource for LangChain with how-tos, code snippets, and help understanding errors. Login with your LangSmith credentials to preserve your chat history and continue your conversations.

欢迎体验全新升级的 [chat.langchain.com](http://chat.langchain.com/?ref=blog.langchain.com) —— 一款面向 LangChain 开发者的类 ChatGPT 工具，提供操作指南、代码片段及错误解析支持。使用你的 LangSmith 账户登录，即可保存聊天历史并延续对话。

**Support Portal**

**支持门户**

We’re launching our new Support Portal. Browse knowledge articles, submit feature requests, and connect with our team when you need help. Check out [here](https://support.langchain.com/?ref=blog.langchain.com).

我们正在推出全新的支持门户。您可浏览知识库文章、提交功能需求，并在需要帮助时与我们的团队取得联系。点击此处了解详情：[这里](https://support.langchain.com/?ref=blog.langchain.com)。

# Upcoming Events

# 即将举行的活动

🇨🇳 **(Feb 1) Shanghai // Community Meetup: Agent Builder Meetup**

🇨🇳 **(2月1日) 上海 // 社区线下聚会：Agent 构建者交流会**

Get an in-depth intro into LangSmith Agent Builder and Deep Agents, organized by Ambassador Haili Zhang. [RSVP here](https://luma.com/9g53xf8q?ref=blog.langchain.com).

由大使张海莉（Haili Zhang）组织，深度介绍 LangSmith Agent Builder 与 Deep Agents。[立即报名](https://luma.com/9g53xf8q?ref=blog.langchain.com)。

**🌐 (Feb 5) Virtual // Webinar: Agent Observability Powers Agent Evaluation**

**🌐 (2月5日) 线上 // 网络研讨会：Agent 可观测性赋能 Agent 评估**

Walk through the core primitives of agent observability and learn how teams use them together to improve agent behavior. [RSVP here.](https://luma.com/98vqaocz?ref=blog.langchain.com)

深入讲解 Agent 可观测性的核心基础能力，并了解团队如何协同运用这些能力以优化 Agent 行为。[立即报名](https://luma.com/98vqaocz?ref=blog.langchain.com)。

**🏙️ (Feb 5) NYC // No-Code Agent Building (Women & Underrepresented Genders)**

**🏙️ (2月5日) 纽约 // 低代码 Agent 构建工作坊（面向女性及性别少数群体）**

Calling all citizen developers, technical professionals, and non-technical folks who are women and gender-divers - come build an agent with us and Tavily! [RSVP here.](https://luma.com/zkemhck5?ref=blog.langchain.com)

诚邀所有公民开发者、技术从业者，以及女性和性别多元背景的非技术人员——加入我们，携手 Tavily 共同构建一个 Agent！[立即报名](https://luma.com/zkemhck5?ref=blog.langchain.com)。

🗽( **Feb 17) New York // AI Agents Meetup: Agent Observability Powers Agent Evaluation**

🗽( **2月17日) 纽约 // AI Agents 社区聚会：Agent 可观测性赋能 Agent 评估**)

Join our Nick Huang, Applied AI Engineer at LangChain, as he shares best practices on agent observability & evals with LangSmith. [RSVP here.](https://luma.com/3cn66ifk?ref=blog.langchain.com)

欢迎参加由 LangChain 应用 AI 工程师 Nick Huang 主讲的分享会，他将介绍如何借助 LangSmith 实现智能体（agent）可观测性与评估（evals）的最佳实践。[立即报名](https://luma.com/3cn66ifk?ref=blog.langchain.com)

**🌉 (Feb 18) San Francisco // AI Agents Meetup: Agent Observability Powers Agent Evaluation**

**🌉 （2月18日）旧金山 // AI 智能体线下聚会：智能体可观测性驱动智能体评估**

Join our CEO, Harrison, as he shares best practices on agent observability & evals with LangSmith. [RSVP here.](https://luma.com/v6y5ms2z?ref=blog.langchain.com)

欢迎 LangChain 首席执行官 Harrison 亲临现场，分享如何利用 LangSmith 提升智能体可观测性与评估能力的最佳实践。[立即报名](https://luma.com/v6y5ms2z?ref=blog.langchain.com)

🇵🇱 **(Feb 19) Kraków // Community Meetup: AI Agents Workshop (on site & remote)**

🇵🇱 **（2月19日）克拉科夫 // 社区线下聚会：AI 智能体工作坊（线下+线上同步）**

Join this hands-on, practical workshops on building agentic systems with LangGraph. Learn how to use LangSmith for tracing and evals. Organized by Ambassadors Simon Budziak and Bart Ludera from Lubu Labs. [RSVP here](https://luma.com/31xzoj09?ref=blog.langchain.com).

加入这场以 LangGraph 构建智能体系统为主题的实操型工作坊。您将学习如何使用 LangSmith 进行链路追踪（tracing）与评估（evals）。本活动由 Lubu Labs 的社区大使 Simon Budziak 与 Bart Ludera 联合组织。[立即报名](https://luma.com/31xzoj09?ref=blog.langchain.com)

🇮🇳 **(Feb 21) Bengaluru // Community Meetup: Agentic AI in Practice: Evaluation, Memory, and Scale**

🇮🇳 **（2月21日）班加罗尔 // 社区线下聚会：实践中的智能体 AI：评估、记忆与规模化**

This meetup will focus on building agents with eval-driven auto-optimization and building a universal memory layer for AI. Organized by Ambassador Ravi Kiran Vemula. [RSVP here](https://luma.com/7nx581e1?ref=blog.langchain.com).

本次聚会将聚焦于构建具备“评估驱动自动优化”能力的智能体，并探讨如何为 AI 构建通用记忆层（universal memory layer）。活动由社区大使 Ravi Kiran Vemula 组织。[立即报名](https://luma.com/7nx581e1?ref=blog.langchain.com)

🇳🇱 **(Feb 25) Netherlands // Community Meetup: Utrecht**

🇳🇱 **（2月25日）荷兰 // 社区线下聚会：乌得勒支**

Hear from the LangChain team on how to build reliable agents with LangSmith, alongside Karsten (Field CTO at Incentro). [RSVP here.](https://luma.com/6xst89h5?ref=blog.langchain.com)

聆听 LangChain 团队与 Incentro 公司首席技术官（Field CTO）Karsten 联合分享：如何借助 LangSmith 构建高可靠性的智能体。[立即报名](https://luma.com/6xst89h5?ref=blog.langchain.com)

🇫🇷 **(Feb 26) Paris // Community Meetup: Agents & Apéro**

🇫🇷 **（2月26日）巴黎 // 社区线下聚会：智能体与开胃酒会（Agents & Apéro）**

Ambassador Juan Felipe Arias and Ambassador/Expert Guillaume Fortaine. Keep things informal, friendly, and very Parisian — with an apéro vibe and plenty of time to network 🍷🥖. [RSVP here](https://luma.com/dabn5yjc?ref=blog.langchain.com).

大使胡安·费利佩·阿里亚斯（Juan Felipe Arias）与大使兼专家纪尧姆·福泰纳（Guillaume Fortaine）。氛围轻松友好，十足巴黎范儿——就像一场惬意的餐前小酌（apéro），还有充足时间自由交流 networking 🍷🥖。[立即报名](https://luma.com/dabn5yjc?ref=blog.langchain.com)。

🇺🇸 **(2月26日) 丹佛 // 社区线下聚会：用 LangSmith 尽早发现错误**

加入 Focused 公司首席智能体工程师（Lead Agent Engineer），围绕如何借助 LangSmith 构建并运维面向生产环境的 AI 应用，展开一场务实而深入的探讨。[立即报名](https://luma.com/x8kffsta?ref=blog.langchain.com)。

🇺🇸 **(3月3日) 芝加哥 // 社区线下聚会：用 LangSmith 尽早发现错误**

加入 Focused 公司首席智能体工程师（Lead Agent Engineer），围绕如何借助 LangSmith 构建并运维面向生产环境的 AI 应用，展开一场务实而深入的探讨。[立即报名](https://luma.com/962j2bv9?ref=blog.langchain.com)。

🇬🇧 **(3月6日) 伦敦 // 社区黑客松：智能体与知识图谱**

在这个周末黑客松中，探索智能体如何突破演示阶段——通过扎根于结构化、持久化的上下文，真正落地应用。由大使苏迪普·坎德尔（Sudip Kandel）联合 SurrealDB 共同主办。[立即报名](https://luma.com/lcsqwmf3?ref=blog.langchain.com)。

🇸🇪 **(3月22日) 斯德哥尔摩 // 社区黑客松：Lovable × LangChain 房地产科技（PropTech）黑客松**

携手 LangChain 与 Lovable，在斯德哥尔摩举办为期一天的黑客松！使用新一代 AI 开发工具，为房地产与建筑行业构建实用 AI 解决方案。由大使古斯塔夫·耶伦斯波雷（Gustaf Gyllensporre）组织。[立即报名](https://luma.com/aa543o8t?ref=blog.langchain.com)。

🇳🇱 **(3月26日) 阿姆斯特丹 // 社区线下聚会：自主系统的崛起**

Get practical POVs on architectures, runtime, and the evolving role of platforms in enabling reliable AI at scale — with speakers from LangChain, AWS, Qodo, and SurrealDB. Organized by Ambassador Sri Rang. [RSVP here](https://luma.com/oqjo3kut?ref=blog.langchain.com).

获取关于架构、运行时以及平台在规模化实现可靠 AI 过程中不断演进之角色的实用视角——演讲嘉宾来自 LangChain、AWS、Qodo 和 SurrealDB。本次活动由大使 Sri Rang 策划组织。[立即报名](https://luma.com/oqjo3kut?ref=blog.langchain.com)

## 🤝 Customer stories

## 🤝 客户案例

- **Coinbase** standardized a code-first, observable agent stack to safely automate regulated workflows — reducing agent development time from quarters to days. [Read the full story.](https://www.coinbase.com/blog/building-enterprise-AI-agents-at-Coinbase?ref=blog.langchain.com)

- **Coinbase** 采用以代码为先、可观测的智能体（agent）技术栈，安全地自动化受监管的业务流程——将智能体开发周期从数个季度缩短至数天。[阅读完整案例](https://www.coinbase.com/blog/building-enterprise-AI-agents-at-Coinbase?ref=blog.langchain.com)

- **Remote** built a Code Execution Agent that separates reasoning (LLMs) from execution (Python), turning complex, multi-format employee and payroll data into validated JSON in hours. [Read the full story.](https://blog.langchain.com/customers-remote/)

- **Remote** 构建了一个代码执行智能体（Code Execution Agent），将推理（由大语言模型 LLMs 完成）与执行（由 Python 完成）解耦，仅需数小时即可将复杂、多格式的员工与薪酬数据转化为经过验证的 JSON 格式。[阅读完整案例](https://blog.langchain.com/customers-remote/)

**How can you follow along with the Lang Latest? Check out the** [**LangChain blog**](https://blog.langchain.dev/?ref=blog.langchain.com) **,** [**Changelog**](https://changelog.langchain.com/?ref=blog.langchain.com) **, and** [**YouTube channel**](https://www.youtube.com/@LangChain?ref=blog.langchain.com) **for more product and content updates.**

**如何持续关注 LangChain 最新动态？欢迎访问** [**LangChain 博客**](https://blog.langchain.dev/?ref=blog.langchain.com) **、** [**更新日志（Changelog）**](https://changelog.langchain.com/?ref=blog.langchain.com) **以及** [**YouTube 频道**](https://www.youtube.com/@LangChain?ref=blog.langchain.com) **，获取更多产品与内容更新。**
&#123;% endraw %}
