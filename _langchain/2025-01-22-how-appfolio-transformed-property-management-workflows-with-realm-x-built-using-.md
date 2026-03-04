---
render_with_liquid: false
title: "How AppFolio transformed property management workflows with Realm-X, built using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-appfolio/"
date: "2025-01-22"
scraped_at: "2026-03-03T07:43:25.047919447+00:00"
language: "en-zh"
translated: true
description: "See how AppFolio's AI-powered copilot Realm-X has saved property managers over 10 hours per week. Learn how they improved Realm-X's performance 2x using LangSmith and built an agent architecture with ..."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

AppFolio, the technology leader powering the future of the real estate industry, has released **Realm-X Assistant**, an AI-powered copilot designed to improve the efficiency of property managers’ day-to-day work.  

AppFolio——引领房地产行业未来发展的技术领导者——已正式发布 **Realm-X Assistant**，一款专为提升物业经理日常工作效率而打造的 AI 赋能协作者。

Realm-X is embedded generative AI that provides intelligent, real-time assistance by combining the latest foundation models with industry-specific context.  

Realm-X 是深度嵌入系统内的生成式 AI，通过将最新基础大模型与房地产行业专属业务语境深度融合，提供智能化、实时化的辅助支持。

Realm-X provides a conversational interface that helps users understand the state of their business, get help, and execute actions in bulk – whether it’s querying information, sending messages, or scheduling actions related to residents, vendors, units, bills, or work orders and many more.  

Realm-X 提供对话式交互界面，帮助用户全面掌握业务运行状态、即时获取帮助，并批量执行各类操作——无论是查询信息、发送消息，还是针对租户、供应商、房源单元、账单或工单等场景安排任务，皆可轻松完成。

Early users have reported **saving over 10 hours a week** in completing their to-do list.  

早期用户反馈，借助 Realm-X 助理，每周完成待办事项可 **节省逾 10 小时**。

While designing Realm-X, AppFolio realized that they needed a better natural language interface to help property managers engage with the platform and simplify operational processes. The team turned to LangChain, LangGraph, and LangSmith to improve their execution flow and add visibility into how users were interacting with Realm-X.  

在设计 Realm-X 过程中，AppFolio 意识到：亟需更优质的自然语言交互界面，以助力物业经理高效使用平台、简化运营流程。为此，团队引入了 LangChain、LangGraph 和 LangSmith，以优化执行流程，并增强对用户与 Realm-X 交互行为的可观测性。

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_001.jpg)Realm-X assistant interface

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_001.jpg)Realm-X 助理界面

## **Choosing LangGraph for flexibility and control**

## **选择 LangGraph：兼顾灵活性与可控性**

Realm-X Assistant was initially built using LangChain for interoperability, making it easy to switch out model providers without changing any code. LangChain also made it easy to use tools and structured outputs when making requests with their tool calling agent.  

Realm-X Assistant 最初基于 LangChain 构建，以保障系统互操作性——无需修改任何代码，即可灵活切换底层大模型服务商。此外，LangChain 还极大简化了工具调用（tool calling）代理在发起请求时对各类工具及结构化输出的集成与使用。

As the Assistant evolved, AppFolio needed a way to handle even more complexity with their requests. Their team made a strategic transition from LangChain to LangGraph, which simplified response aggregation from different nodes to display to the user.  

随着助理功能持续演进，AppFolio 面临着日益复杂的请求处理需求。为此，团队战略性地从 LangChain 迁移至 LangGraph，显著简化了来自多个节点的响应聚合逻辑，从而更高效地向用户呈现结果。

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_002.jpg)Realm-X architecture with LangGraph

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_002.jpg)基于 LangGraph 的 Realm-X 架构图

After switching to LangGraph, the AppFolio team could clearly see the execution flow of the Realm-X Assistant, which allowed them to design workflows that could reason before acting. By parallelizing branch execution, AppFolio has also been able to reduce latency and code complexity.  

迁移到 LangGraph 后，AppFolio 团队得以清晰洞察 Realm-X Assistant 的完整执行流，进而设计出“先推理、后行动”的智能工作流。通过并行化分支执行，AppFolio 同时实现了延迟降低与代码复杂度下降。

One major benefit of LangGraph has been its ability to run independent code branches in parallel. While determining relevant actions, it simultaneously calculates fallbacks and runs a question-answering bot over help pages. This allows Realm-X to offer related suggestions which enhances the user experience, while keeping latency at a minimum.  

LangGraph 的一大核心优势在于其支持独立代码分支的并行执行能力。例如，在判定相关操作时，系统可同步计算备用方案（fallbacks），并调用问答机器人在帮助文档中实时检索答案。这使得 Realm-X 能够即时提供关联建议，在大幅提升用户体验的同时，将响应延迟控制在最低水平。

## **Leveraging LangSmith to monitor and pinpoint issues in production**

## **依托 LangSmith 实现生产环境监控与问题精准定位**

To add a layer of visibility into their production traffic, AppFolio used LangSmith to facilitate debugging during development and gain more insights into user interactions.  
为提升对生产环境流量的可观测性，AppFolio 借助 LangSmith 在开发阶段辅助调试，并更深入地洞察用户交互行为。

In production, the AppFolio team keeps a close eye on real-time feedback charts in LangSmith — tracking error rates, costs, and latency to keep everything on course.  
在生产环境中，AppFolio 团队持续关注 LangSmith 中的实时反馈图表——监控错误率、成本与延迟，确保系统始终稳定运行。

The team also added in automatic triggers to collect feedback when users submit an action drafted by Realm-X.  
团队还增设了自动触发机制：当用户提交由 Realm-X 生成的操作时，系统自动收集反馈。

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_003.png)

In addition, automatic feedback is generated based on LLM or heuristic evaluators to continuously monitor system health.  
此外，系统还会基于大语言模型（LLM）或启发式评估器自动生成反馈，以持续监测系统健康状况。

![](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_004.jpg)

LangSmith’s tracing also makes it easy for AppFolio to pinpoint issues when they occur.  
LangSmith 的追踪能力也让 AppFolio 能够在问题发生时快速定位根因。

During development, engineers rely on comparison views and the LangSmith playground to iterate on workflows, ensuring they're battle-tested before deployment.  
在开发阶段，工程师依托 LangSmith 的对比视图与 Playground 快速迭代工作流，确保其在部署前已通过充分验证。

Traces are also shareable across the team, streamlining the process of collaborating across stakeholders.  
追踪记录亦可跨团队共享，显著简化了多方利益相关者之间的协作流程。

## **Iterating on prompts to improve system performance**

## **通过提示词迭代提升系统性能**

One key innovation that LangSmith supports in AppFolio’s system is dynamic few-shot prompting — which involves dynamically pulling relevant examples to deliver more personalized and accurate responses to Realm-X users.  
LangSmith 为 AppFolio 系统赋能的一项关键创新是动态少样本提示（dynamic few-shot prompting）——即根据上下文动态检索相关示例，从而向 Realm-X 用户提供更个性化、更精准的响应。

With LangSmith, the AppFolio team has been able to quickly identify whether wrong samples were used or if a relevant sample was missing or poorly formatted, ultimately helping optimize the examples pulled for a given query.  
借助 LangSmith，AppFolio 团队得以快速识别：是否误用了错误示例，或是否遗漏了关键示例、抑或示例格式不规范，从而有效优化针对特定查询所拉取的示例集合。

The comparison view in LangSmith was particularly useful for identifying subtle differences in how prompts were constructed, helping AppFolio ensure precise outputs.  
LangSmith 的对比视图在识别不同提示词构造间的细微差异方面尤为高效，助力 AppFolio 实现输出结果的高精度。

The LangSmith Playground also enabled the team to rapidly iterate on prompts, base models, or tool descriptions with modifying the underlying code – shortening the feedback cycle between stakeholders.  
LangSmith Playground 还使团队无需修改底层代码，即可快速迭代提示词、基础模型或工具描述，大幅缩短了各利益相关方之间的反馈周期。

Dynamic few-shot prompting has been crucial in improving the performance of specific Realm-X features like its text-to-data functionality, where **performance significantly increased from ~40% to ~80%.**  
动态少样本提示对提升 Realm-X 特定功能（如文本转数据功能）的性能至关重要，其准确率**从约 40% 显著提升至约 80%。**

This showcases the impact of tailored examples in improving system accuracy.  
这充分体现了定制化示例对提升系统准确性的关键作用。

AppFolio has also maintained high performance as they’ve increased the number of actions and data models that users can query in Realm-X.  
随着 Realm-X 中用户可查询的操作类型与数据模型数量持续增加，AppFolio 依然保持了高性能表现。

## **LLM evaluations for continuous improvement**

## **基于大语言模型的评估实现持续优化**

AppFolio prioritizes user experience and feedback in its testing and evaluation process. Every step in the Realm-X workflow— from individual actions to end-to-end executions— is rigorously tested using custom evaluators and LangSmith’s tools.

AppFolio 在其测试与评估流程中始终将用户体验和用户反馈置于优先地位。Realm-X 工作流中的每一步——从单个操作到端到端的完整执行——均通过自定义评估器及 LangSmith 工具进行严格测试。

To ensure quality, AppFolio maintains a central repository of sample cases containing message history, metadata, and ideal outputs. These can be used as evals, unit tests, or examples. Evals are run in CI, with results tracked and integrated into PRs. To avoid regressions, code changes merge only when all unit tests pass and eval thresholds are met.

为保障质量，AppFolio 维护一个集中式样例案例库，其中包含对话消息历史、元数据以及理想输出结果。这些样例可直接用作评估（evals）、单元测试或参考示例。评估任务在持续集成（CI）环境中自动运行，结果被实时追踪并直接集成至 Pull Request（PR）中。为避免功能退化，仅当全部单元测试通过且评估指标达到预设阈值时，代码变更方可合入主干。

LangGraph also helps streamline complex workflows like text-to-data processing by organizing intricate if-statement logic into clear, flexible code paths. This, combined with rigorous testing, ensures that Realm-X Assistant produces accurate and reliable responses for property managers.

LangGraph 还有助于简化文本转数据等复杂工作流：它将错综复杂的 `if` 语句逻辑重构为清晰、灵活的代码路径。配合前述严格的测试机制，这一方案确保 Realm-X 助理能为物业管理者提供准确、可靠的响应。

## **The path forward for AppFolio**

## **AppFolio 的未来发展之路**

As AppFolio continues to innovate with the Realm-X Assistant, the focus remains on enhancing user-centric features and optimizing performance. As an early LangSmith user, AppFolio seamlessly integrated LangGraph with LangSmith’s robust monitoring, which helped Realm-X Assistant aggregate responses from multiple system parts to ensure clear, actionable user outputs.

随着 AppFolio 持续依托 Realm-X 助理推进创新，其核心焦点始终是强化以用户为中心的功能特性，并持续优化系统性能。作为 LangSmith 的早期用户，AppFolio 顺利实现了 LangGraph 与 LangSmith 强大监控能力的无缝集成；该集成助力 Realm-X 助理聚合来自多个系统模块的响应，从而确保向用户提供清晰、可执行的输出结果。

Looking ahead, AppFolio is expanding Realm-X to further improve overall performance and reliability by using LangGraph for state management and self-validation loops. By combining these tools with their commitment to innovation, AppFolio continues to empower property managers everywhere to succeed.

展望未来，AppFolio 正通过引入 LangGraph 实现状态管理与自验证循环，进一步拓展 Realm-X 的能力边界，以全面提升整体性能与系统可靠性。凭借这些先进工具与其对技术创新的坚定承诺，AppFolio 持续赋能全球各地的物业管理者迈向成功。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_005.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_006.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_006.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_007.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_008.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可观测性](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_009.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员工作状态的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-appfolio-transformed-property-management-workflows-with-realm-x-built-using-/img_010.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟