---
title: "How Cleric’s AI SRE leveled up with continuous learning through LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-cleric/"
date: "2025-04-03"
scraped_at: "2026-03-03T07:35:41.108193446+00:00"
language: "en-zh"
translated: true
description: "Cleric is an AI SRE teammate that identifies issues using existing observability tools and infrastructure. See how they used LangSmith to investigate their production issues effectively."
tags: ["Case Studies"]
---

Cleric is an AI agent designed to help engineering teams debug production issues, focusing on the complex, time consuming investigations that often drain engineering productivity.

Cleric 是一款专为工程团队设计的 AI 智能体，旨在协助调试生产环境中的问题，尤其聚焦于那些复杂、耗时且常常严重拖慢工程效率的深度排查工作。

When an alert fires, Cleric automatically begins investigating using existing observability tools and infrastructure. Like a human engineer, Cleric examines multiple systems simultaneously - checking database metrics, network traffic, application logs, and system resources through read-only access to production systems. This parallel investigation approach helps quickly identify complex issues, like cascading failures across microservices.

当告警触发时，Cleric 会自动启动调查，充分利用团队已有的可观测性工具与基础设施。如同人类工程师一样，Cleric 可并行检查多个系统——通过只读方式访问生产环境，实时监测数据库指标、网络流量、应用日志及系统资源。这种并行调查模式有助于快速定位复杂问题，例如微服务间发生的级联故障。

Cleric communicates with teams through Slack, sharing its findings and asking for guidance when needed. There's no new tooling to learn – Cleric works with existing observability stacks, accessing logs, metrics, and traces just like a human engineer would.

Cleric 通过 Slack 与团队沟通，实时共享调查发现，并在需要时主动请求人工指导。无需学习任何新工具——Cleric 完全兼容现有的可观测性技术栈，以与人类工程师完全相同的方式访问日志、指标和链路追踪（traces）。

## **Conducting concurrent investigations of production issues in LangSmith**

## **在 LangSmith 中开展生产问题的并发调查**

Production issues present unique learning opportunities that can't be reproduced later. Unlike code generation, production environments are stateful and dynamic. Once an issue is resolved, that exact system state is gone, along with the opportunity to learn from it.

生产问题提供了独特且不可复现的学习机会。与代码生成不同，生产环境是有状态且高度动态的；一旦问题被解决，该时刻精确的系统状态便永远消失，连同从中学习的机会一并消逝。

The Cleric team needed to test different investigation approaches simultaneously. For instance, one investigation path might prioritize checking database connection pools and query patterns, while another focuses first on network traffic and system resources. This setup creates a complex matrix of concurrent investigations, as Cleric examines multiple systems using different investigation strategies.

Cleric 团队需要同时测试多种调查路径。例如，某条路径可能优先检查数据库连接池与查询模式，而另一条则首先聚焦于网络流量与系统资源。这种设计催生了一个复杂的并发调查矩阵：Cleric 同时调用多种策略，对多个系统展开并行调查。

This approach introduced a new challenge. How could the Cleric team monitor and compare the performance of different investigation strategies running simultaneously? And how could they determine which investigation approaches would work best for different types of issues?

这一方法带来了一个新挑战：Cleric 团队如何监控并对比多种调查策略在并发运行时的性能表现？又该如何判断哪些调查方法最适合应对不同类别的问题？

LangSmith helped to address this problem by providing clear visibility into these parallel investigations and experiments. With LangSmith, the Cleric system can now:

LangSmith 通过为这些并行调查与实验提供清晰的可观测性，有效解决了这一难题。借助 LangSmith，Cleric 系统如今能够：

- Compare different investigation strategies side-by-side  
- 对比不同调查策略的执行效果（并排呈现）

- Track investigation paths across all systems  
- 追踪贯穿所有系统的调查路径

- Aggregate performance metrics for different investigation approaches  
- 汇总不同调查方法的性能指标

- Tie user feedback directly to specific investigation strategies  
- 将用户反馈直接关联至特定的调查策略

- Perform direct comparisons of different approaches handling the same incident  
- 针对同一事故，直接比较不同调查方法的实际效果

LangSmith's tracing capabilities enabled the Cleric team to analyze investigation patterns across thousands of concurrent traces, measuring which approaches consistently lead to faster resolutions. This data-driven validation is crucial for building reliable autonomous systems, as relying on an approach that worked once isn’t enough to ensure it will be generalizable.

LangSmith 的链路追踪能力，使 Cleric 团队得以分析成千上万条并发 trace 中的调查行为模式，精准评估哪些方法能持续带来更快的问题解决速度。这种基于数据的验证对于构建可靠的自主系统至关重要——因为仅凭某次成功的经验，远不足以确保该方法具备普适性与可推广性。

![](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_001.jpg)

## **Tracking feedback & performance metrics to generalize insights across deployments**

## **跟踪反馈与性能指标，以在各部署环境中泛化洞察**

Cleric learns continuously from interactions within each customer environment. When an engineering team provides feedback on an investigation - whether positive or negative - this creates an opportunity to improve future investigations. While learning within a single team or company is valuable, Cleric also recognized the potential to generalize successful investigation strategies across all of our deployments.

Cleric 持续从每个客户环境中的交互中学习。当工程团队对某次调查提供反馈（无论正面或负面）时，便为改进后续调查创造了机会。虽然在单一团队或公司内部的学习极具价值，Cleric 同样意识到：成功调查策略具备跨所有部署环境泛化应用的潜力。

The challenge is determining which learnings are specific to a team or company, and which represent broader patterns that could help all users. For example, a solution that works in one environment might depend on specific internal tools or processes that don't exist elsewhere.

挑战在于区分哪些经验仅适用于特定团队或公司，而哪些则代表更普适的模式、可惠及所有用户。例如，某一环境中行之有效的解决方案，可能依赖于该组织特有的内部工具或流程，而这些在其他环境中并不存在。

Before generalizing any learnings, Cleric employs strict privacy controls and data anonymization. All customer specific details, proprietary information, and identifying data are stripped before any patterns are analyzed or shared.

在将任何经验泛化之前，Cleric 严格实施隐私保护机制与数据匿名化处理。所有客户专属细节、专有信息及可识别身份的数据，均会在模式分析或共享前被彻底剥离。

Cleric uses LangSmith to manage this continuous learning process:

Cleric 借助 LangSmith 管理这一持续学习流程：

1. When Cleric completes an investigation, engineers provide feedback through their normal interactions with Cleric (Slack, ticketing systems, etc.)  
2. This feedback is captured through LangSmith's feedback API and tied directly to the investigation trace. Cleric stores both the specific details of the investigation and the key patterns that led to its resolution.  
3. The system analyzes these patterns to create generalized memories that strip away environment specific details while preserving the core problem-solving approach.  
4. These generalized memories are then made available selectively during new investigations across all deployments. LangSmith helps track when and how these memories are used, and whether they improve investigation outcomes.  
5. By comparing performance metrics across different teams, companies, and industries, Cleric can determine the appropriate scope for each learning. Some memories might only be useful within a specific team, while others provide value across all customer deployments.

1. 当 Cleric 完成一次调查后，工程师通过其日常与 Cleric 的交互（如 Slack、工单系统等）提供反馈；  
2. 此类反馈经由 LangSmith 的反馈 API 捕获，并直接关联至该次调查的追踪记录（trace）。Cleric 同时保存调查的具体细节，以及促成问题解决的关键模式；  
3. 系统分析这些模式，生成“泛化记忆”（generalized memories）——剔除环境特异性细节，同时保留核心的问题解决思路；  
4. 这些泛化记忆随后在所有部署环境的新调查中被有选择地调用。LangSmith 负责追踪这些记忆被调用的时间、方式，及其是否切实提升了调查成效；  
5. 通过跨不同团队、企业及行业的性能指标对比，Cleric 可判定每项经验适用的合理范围：某些记忆可能仅对特定团队有效，而另一些则能为全部客户部署带来价值。

LangSmith's tracing and metrics capabilities allow the Cleric team to measure the impact of these shared learnings. The system can compare investigation success rates, resolution times, and other key metrics before and after introducing new memories. This data-driven approach helps validate which learnings truly generalize across environments and which should remain local to specific customers.

LangSmith 的追踪与指标能力，使 Cleric 团队得以量化评估这些共享经验的实际影响。系统可对比引入新记忆前后的问题调查成功率、解决耗时及其他关键指标。这种数据驱动的方法，有助于验证哪些经验确能跨环境泛化，而哪些则应保留在特定客户的本地知识库中。

This system allows Cleric to maintain separate knowledge spaces - customer specific context for unique environments and procedures, alongside a growing library of generalized problem solving patterns that benefit all users.

该系统使 Cleric 能够维护彼此独立的知识空间：一方面保留面向独特环境与流程的客户专属上下文；另一方面持续积累一个不断扩充的泛化问题解决模式库，惠及所有用户。

![](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_002.jpg)**Knowledge Hierarchy:** How Cleric Organizes Operational Learning

![](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_002.jpg)**知识层级结构（Knowledge Hierarchy）：** Cleric 如何组织运维学习

## **The path to autonomous, self-healing systems**

## **通往自主、自愈系统的道路**

Production systems are becoming more autonomous. The future of engineering is building products, not operating them. Every incident Cleric resolves advances this shift, systematically moving operations from human engineers to AI systems, letting teams focus on strategic work and product development.

生产系统正变得越来越自主。工程的未来在于构建产品，而非运维产品。Cleric 解决的每一个事件都在推动这一转变——系统性地将运维工作从人类工程师逐步移交至 AI 系统，从而让团队得以专注于战略任务与产品开发。

Cleric is building this future systematically, expanding autonomous capabilities while maintaining the safety and control that production systems demand. Each investigation helps Cleric learn and improve, moving their customers toward truly self-healing infrastructure. To see how Cleric can help your team today, [reach out](https://cleric.io/?ref=blog.langchain.com).

Cleric 正系统性地构建这一未来：在持续拓展自主能力的同时，坚守生产系统所必需的安全性与可控性。每一次根因调查都助力 Cleric 学习与优化，推动客户迈向真正具备自愈能力的基础设施。如需了解 Cleric 如何助力您的团队，请立即 [联系我们](https://cleric.io/?ref=blog.langchain.com)。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何借助 LangChain 和 LangGraph 利用 AI 为数千名客户完成入职流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-cleric_s-ai-sre-leveled-up-with-continuous-learning-through-langsmith/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟