---
render_with_liquid: false
title: "How Infor is Transforming Enterprise AI using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-infor/"
date: "2025-02-06"
scraped_at: "2026-03-03T07:41:07.316340733+00:00"
language: "en-zh"
translated: true
description: "See how Infor is using the full LangChain product suite — including LangChain, LangGraph, and LangSmith — to drive enterprise automation for the cloud."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Infor](https://www.infor.com/?ref=blog.langchain.com) 是一家领先的 enterprise software 公司，提供面向特定行业的云原生多租户解决方案，涵盖航空航天与国防、汽车、分销、时尚、食品与饮料、医疗健康以及工业制造等领域。其解决方案以 **云套件（cloud suites）** 的形式交付给客户——即一套全面集成的软件应用程序，通过软件即服务（SaaS）模式部署于多个 AWS 区域。这些套件帮助组织优化运营流程、提升生产力，并借助云基础设施降低 IT 成本。

[Infor](https://www.infor.com/?ref=blog.langchain.com) 是一家领先的企事业软件公司，提供面向特定行业的云原生多租户解决方案，涵盖航空航天与国防、汽车、分销、时尚、食品与饮料、医疗健康以及工业制造等领域。其解决方案以 **云套件（cloud suites）** 的形式交付给客户——即一套全面集成的软件应用程序，通过软件即服务（SaaS）模式部署于多个 AWS 区域。这些套件帮助组织优化运营流程、提升生产力，并借助云基础设施降低 IT 成本。

Infor OS（Operating Service，操作系统服务）是支撑所有 Infor 云套件应用与服务的云平台，为用户、开发者及企业打造统一的云体验，显著增强功能丰富性、安全性与系统互操作性。随着生成式 AI 的兴起，Infor 把握契机，依托 Infor OS 平台将大语言模型（LLM）深度集成至全部云套件中，从而实现产品能力的前瞻性升级。

Infor OS（运营服务）是支撑所有 Infor 云套件应用与服务的云平台，为用户、开发者及企业打造统一的云体验，显著增强功能丰富性、安全性与系统互操作性。随着生成式 AI 的兴起，Infor 把握契机，依托 Infor OS 平台将大语言模型（LLM）深度集成至全部云套件中，从而实现产品能力的前瞻性升级。

为此，Infor 将其聊天助手 Coleman DA（Digital Assistant，数字助理）从 AWS Lex 迁移至一个更灵活、由 LLM 驱动的新平台。这一全新生成式 AI 能力使平台能够处理复杂查询、生成动态内容、提供智能自动化服务，并无缝集成机器学习（ML）模型、各类 API 及整个生态中的云套件应用。

为此，Infor 将其聊天助手 Coleman DA（Digital Assistant，数字助理）从 AWS Lex 迁移至一个更灵活、由 LLM 驱动的新平台。这一全新生成式 AI 能力使平台能够处理复杂查询、生成动态内容、提供智能自动化服务，并无缝集成机器学习（ML）模型、各类 API 及整个生态中的云套件应用。

## **从 LangChain 到 LangGraph：构建可扩展的 AI 平台**

## **从 LangChain 到 LangGraph：构建可扩展的 AI 平台**

为实现其生成式 AI 愿景，Infor 需要一套具备可扩展性与模块化特性的解决方案。借助 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 和 [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com)，Infor 工程团队得以快速在 Infor OS 平台上集成新一代生成式 AI 组件，使旗下各类云套件与业务应用均可便捷调用大语言模型（LLM）。此举助力 Infor 充分发挥深厚的行业知识积淀与丰富的业务场景经验，满足客户对创新型商业解决方案的期待。

为实现其生成式 AI 愿景，Infor 需要一套具备可扩展性与模块化特性的解决方案。借助 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 和 [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com)，Infor 工程团队得以快速在 Infor OS 平台上集成新一代生成式 AI 组件，使旗下各类云套件与业务应用均可便捷调用大语言模型（LLM）。此举助力 Infor 充分发挥深厚的行业知识积淀与丰富的业务场景经验，满足客户对创新型商业解决方案的期待。

![](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_001.jpg)

![](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_001.jpg)

Infor 生成式 AI 团队基于 AWS Bedrock 构建了一个平台，该平台包含三大核心组件：

Infor 生成式 AI 团队基于 AWS Bedrock 构建了一个平台，该平台包含三大核心组件：

1. **嵌入式生成式 AI 体验（GenAI embedded experiences）** — Infor 应用可通过其 API 网关安全访问大语言模型（LLM），支持单次请求调用，配合领域定制化提示词（domain-engineered prompts），完成文本生成、摘要提炼与语言翻译等任务。这有助于将生成式 AI 功能深度嵌入业务流程，简化人工操作。
2. **生成式 AI 知识中心（GenAI Knowledge Hub）** — Infor 采用检索增强生成（RAG）架构，并以 AWS OpenSearch 作为向量数据库，显著提升文档检索能力。该方案支持批量导入全部产品文档与客户支持工单，从而改善客户服务响应质量；此外，客户还可将内部手册、政策文件、业务流程等自有文档上传至其专属私有向量库，再通过对话式 AI 助理进行交互式查询与问答。
3. **生成式 AI 助理（GenAI Assistant）** — Infor 将原有基于 AWS 的传统聊天机器人全面升级为多智能体（multi-agent）AI 助理，提供更智能、上下文感知更强的人机交互体验。该助理通过 Infor OS API 网关实时调取云套件应用中的最新数据，确保大语言模型在推理过程中始终拥有准确、及时的上下文信息，同时严格遵循权限控制与数据治理策略。

1. **嵌入式生成式 AI 体验（GenAI embedded experiences）** — Infor 应用可通过其 API 网关安全访问大语言模型（LLM），支持单次请求调用，配合领域定制化提示词（domain-engineered prompts），完成文本生成、摘要提炼与语言翻译等任务。这有助于将生成式 AI 功能深度嵌入业务流程，简化人工操作。  
2. **生成式 AI 知识中心（GenAI Knowledge Hub）** — Infor 采用检索增强生成（RAG）架构，并以 AWS OpenSearch 作为向量数据库，显著提升文档检索能力。该方案支持批量导入全部产品文档与客户支持工单，从而改善客户服务响应质量；此外，客户还可将内部手册、政策文件、业务流程等自有文档上传至其专属私有向量库，再通过对话式 AI 助理进行交互式查询与问答。  
3. **生成式 AI 助理（GenAI Assistant）** — Infor 将原有基于 AWS 的传统聊天机器人全面升级为多智能体（multi-agent）AI 助理，提供更智能、上下文感知更强的人机交互体验。该助理通过 Infor OS API 网关实时调取云套件应用中的最新数据，确保大语言模型在推理过程中始终拥有准确、及时的上下文信息，同时严格遵循权限控制与数据治理策略。

LangGraph 对 Infor 的多智能体工作流起到了关键作用，为其提供了灵活且结构清晰的复杂交互管理方式。其 **强大的记忆管理（robust memory management）** 功能，使 Infor 的 AI 智能体能够在多次对话轮次中持续保留并有效利用上下文信息，从而在长周期工作流中显著提升推理能力。此外，LangGraph 的 **状态持久化（state persistence）** 能力，使智能体可高效保存与恢复中间状态，避免重复计算，保障决策过程的连贯性与一致性。

LangGraph 对 Infor 的多智能体工作流起到了关键作用，为其提供了灵活且结构清晰的复杂交互管理方式。其 **强大的记忆管理（robust memory management）** 功能，使 Infor 的 AI 智能体能够在多次对话轮次中持续保留并有效利用上下文信息，从而在长周期工作流中显著提升推理能力。此外，LangGraph 的 **状态持久化（state persistence）** 能力，使智能体可高效保存与恢复中间状态，避免重复计算，保障决策过程的连贯性与一致性。

LangGraph 支持循环式交互的能力，使智能体可在多步骤流程中反复优化响应、动态协作，并逐步消除歧义。这些能力赋能 Infor 构建出高度复杂的 AI 智能体，使其不仅能深入理解并精准执行错综复杂的业务流程，还能自动化关键决策环节，并以更高效率与准确性增强终端用户体验。

LangGraph 支持循环式交互的能力，使智能体可在多步骤流程中反复优化响应、动态协作，并逐步消除歧义。这些能力赋能 Infor 构建出高度复杂的 AI 智能体，使其不仅能深入理解并精准执行错综复杂的业务流程，还能自动化关键决策环节，并以更高效率与准确性增强终端用户体验。

## **Strengthening LLM observability and compliance with LangSmith**

## **借助 LangSmith 提升大语言模型的可观测性与合规性**

As a SaaS provider, Infor relies on strong observability and tracking to ensure reliability, performance, and a consistent, high-quality user experience. Since Infor serves customers across various geographic locations and regulated industries, its LLM-powered platform requires robust observability and governance. The team’s key needs for visibility into any model’s inference pipeline included:

作为一家 SaaS 服务商，Infor 高度依赖强大的可观测性与追踪能力，以保障系统可靠性、性能表现以及一致且高质量的用户体验。由于 Infor 的客户遍布全球各地，并涵盖多个受监管行业，其基于大语言模型（LLM）构建的平台亟需健全的可观测性与治理机制。团队对任意模型推理流水线所需的关键可观测能力包括：

- Inference Performance: Tracking latency, response times, and token usage to optimize throughput and cost efficiency.  
- 推理性能：追踪延迟、响应时间及 Token 使用量，以优化吞吐量并提升成本效益。

- Model Behavior and Quality: Detecting hallucinations, mitigate bias, and track output consistency for improved accuracy.  
- 模型行为与质量：识别幻觉（hallucinations）、缓解偏见，并跟踪输出一致性，从而提升准确性。

- Data and Model Integrity: Identifying potential attacks, data drift, and unintended responses to ensure safety.  
- 数据与模型完整性：识别潜在攻击、数据漂移及非预期响应，确保系统安全性。

- Compliance and Security: Providing audit trailing and protecting sensitive data to meet regulatory requirements.  
- 合规性与安全性：提供审计追踪能力并保护敏感数据，以满足各项监管要求。

- Transparency and Accountability: Ensuring explainability of AI decisions to enhance trust and responsible AI deployment.  
- 透明性与可问责性：确保 AI 决策过程可解释，从而增强用户信任，并推动负责任的 AI 部署。

[LangSmith’s](https://www.langchain.com/langsmith?ref=blog.langchain.com) tracing required minimal integration effort and enabled Infor engineers to monitor interactions, debug performance, and ensure compliance throughout all phases of its GenAI initiatives. Additionally, with the hot-swapping nature of the LLM’s leaderboard, accessing LangSmith in combination with AWS Bedrock allows the Infor team to compare different models and prompts to identify the most effective combination for the various use cases the platform must support. As such, they not only can identify and resolve issues quickly in LangSmith but can improve their prompt engineering to ensure high-quality, safe, and reliable AI-generated outputs.

[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 的追踪功能仅需极少集成工作量，即可赋能 Infor 工程师在生成式 AI（GenAI）项目的各个阶段持续监控用户交互、调试性能瓶颈，并确保全程合规。此外，得益于大语言模型排行榜（LLM leaderboard）所具备的“热切换”（hot-swapping）特性，Infor 团队将 LangSmith 与 AWS Bedrock 结合使用，能够便捷地横向对比不同模型与提示词（prompts），从而为平台所支持的各类应用场景甄选出最优组合。因此，团队不仅可在 LangSmith 中快速定位并解决各类问题，还能持续优化提示工程（prompt engineering），确保生成内容具备高质量、高安全性与高可靠性。

## **The Generative AI Impact and What's Next**

## **生成式 AI 的影响与未来规划**

Infor’s generative AI initiative is a critical effort across the entire organization, driving the company to maintain its innovative edge, enhance customer confidence for its enterprise solutions. By integrating LLM-powered features throughout its cloud suite, Infor has streamlined report generation, automated content creation, and improved knowledge retrieval. Users now have a better experience and can accomplish their tasks using natural language through the new assistant.

Infor 的生成式 AI 战略是贯穿全公司的关键举措，旨在持续巩固其创新优势，并进一步增强客户对其企业级解决方案的信心。通过在整个云产品套件中深度集成大语言模型驱动的功能，Infor 显著简化了报表生成流程、实现了内容创作自动化，并大幅提升了知识检索效率。如今，用户获得了更优的使用体验——只需借助全新推出的 AI 助手，即可通过自然语言完成各类任务。

Looking ahead, Infor is committed to empowering customers to leverage AI to enhance their businesses and customize AI agents to their use cases. They also plan to incorporate more advanced multi-agent interactions into their AI assistant to improve contextual awareness and better manage complex workflows. By utilizing LangGraph and LangSmith, Infor is not merely adopting generative AI but redefining how enterprises interact with and benefit from AI-driven automation.

展望未来，Infor 致力于赋能客户充分运用 AI 技术提升自身业务能力，并支持客户根据具体业务场景定制专属 AI 智能体（AI agents）。团队还计划在 AI 助手中引入更先进的多智能体（multi-agent）协同机制，以增强上下文理解能力，并更高效地管理复杂业务流程。依托 LangGraph 与 LangSmith，Infor 并非简单采用生成式 AI，而是正在重新定义企业如何与 AI 驱动的自动化技术进行交互，并从中获取切实价值。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_003.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-infor-is-transforming-enterprise-ai-using-langgraph-and-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟