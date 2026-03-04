---
title: "How Minimal built a multi-agent customer support system with LangGraph & LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/"
date: "2025-01-21"
scraped_at: "2026-03-03T07:43:52.710623989+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
&#123;% raw %}

In the thriving world of e-commerce, where customer satisfaction can make or break a brand, [Minimal](https://gominimal.ai/?ref=blog.langchain.com) is leveraging the LangChain ecosystem to transform how support issues are handled. Minimal AI agents are delivering 80%+ efficiency gains over a broad variety of E-commerce stores while improving customer satisfaction. This year, Minimal expects that 90% of their customers' support tickets will be handled autonomously by their AI, escalating only 10% to human agents. Below, you’ll see how this new e-commerce support provider constructed a multi-agent system that integrates seamlessly with popular helpdesk tools, automates customer interactions, and even executes order management tasks—all while maintaining tight control over business protocols.

在蓬勃发展的电子商务世界中，客户满意度往往决定一个品牌的成败。[Minimal](https://gominimal.ai/?ref=blog.langchain.com) 正依托 LangChain 生态系统，彻底变革客户服务问题的处理方式。Minimal 的 AI 智能体已在众多电商店铺中实现超 80% 的效率提升，同时显著提高客户满意度。今年，Minimal 预计其客户提交的客服工单中，将有 90% 由 AI 自主处理，仅 10% 升级至人工客服。下文将详细介绍这家新兴电商客服服务商如何构建了一套多智能体系统——该系统可无缝集成主流帮助台工具、自动化客户交互流程，甚至执行订单管理任务，同时严格遵循企业既定业务规范。

## **Overview: Automation for e-commerce customer support**

## **概览：面向电商客服的自动化方案**

[Minimal](https://gominimal.ai/?ref=blog.langchain.com) 专注于为电商企业提供重复性与复杂性兼具的客户服务工作流自动化解决方案。尽管基础支持工单（T1 级）处理相对简单，其核心优势在于通过深度对接客户自有系统，稳定、可靠地解决更复杂的 T2 和 T3 级问题。公司由机器学习工程师 Titus Ex 与航空航天工程专业毕业生 Niek Hogenboom 联合创立，已迅速在荷兰电商市场取得成功。Minimal 支持与 Zendesk、Front、Gorgias 等主流客服平台集成，使用户得以在一个统一界面中高效响应客户咨询。

其 AI 系统支持两种响应模式：草稿模式（即“协作者”模式）和全自动模式。当用户启用 AI 后，系统即开始自动生成准确、上下文丰富的工单回复。不仅如此，借助与主流电商平台（如 Shopify、Shopify Plus 等）的直连集成，该系统还能执行真实操作——例如取消订单、更新收货地址等。

这一方案大幅节省了电商运营人员的时间与精力，使其能够持续、精准地回应客户最紧迫的问题。

![](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_001.gif)

## **Embracing a multi-agent architecture for scalability**

## **采用多智能体架构以实现可扩展性**

其核心差异化能力在于采用多智能体（multi-agent）架构，该架构划分为三大主要智能体：

1. **规划智能体（Planner Agent）**：将每个进站查询拆解为若干子问题（例如，“退货政策” vs. “前端故障排查”），并协同专用的研究型智能体开展检索与相关性重排序，从知识库或客户协议文档中提取关键信息。
2. **研究智能体（Research Agents）**：分别处理各子问题，深入检索培训中心知识库（如退货指南、物流规则等），并将相关结果汇总后反馈给规划智能体。
3. **工具调用智能体（Tool-Calling Agent）**：接收来自规划智能体的最终“工具执行计划”，执行确定性操作——例如，通过 Shopify 发起退款，或更新客户地址记录；同时将所有操作日志统一归集，便于后续处理及思维链（chain-of-thought）验证。待上述三类智能体完成全部子任务后，系统最终生成一份逻辑严密、审慎推演的客户回复草稿——该草稿明确援引适用协议、核验相关数据，并确保完全符合企业在退款、退货等方面的业务规则。

### **Why Multi-Agent?**

### **为何选择多智能体架构？**

The team discovered that a monolithic language model prompt often conflated multiple tasks, leading to errors and expensive usage. Splitting tasks across agents curtailed prompt complexity, increased reliability, and allowed them to add new specialized agents without disrupting existing flows.

团队发现，单一、庞大的语言模型提示词（prompt）常常将多个任务混为一谈，从而引发错误并导致高昂的调用成本。通过将任务拆分至不同智能体（agents）执行，显著降低了提示词的复杂度，提升了系统可靠性，同时也使他们能够在不干扰现有业务流程的前提下，灵活新增各类专业化智能体。

## **Testing and benchmarking with LangSmith**

## **使用 LangSmith 进行测试与基准评估**

During development, the Minimal team extensively tested their system using LangSmith. This enabled them to:

在开发过程中，Minimal 团队广泛使用 LangSmith 对其系统进行了全面测试。这使他们能够：

• Track model responses and performance over time.

• 长期追踪模型响应结果与性能表现。

• Run side-by-side comparisons of different prompts (few-shot vs. zero-shot vs. chain-of-thought variants).

• 并行对比不同提示策略的效果（例如：小样本提示 vs. 零样本提示 vs. 思维链提示等变体）。

• Log each sub-agent’s output to catch unexpected reasoning loops or tool calls.

• 记录每个子智能体（sub-agent）的输出，以便及时发现异常的推理循环或工具调用行为。

Whenever they found an error—say, a policy misunderstanding or a missing step—they created new tests in LangSmith’s trace logs, added more few-shot examples, or further split a sub-problem. This iterative process helped them catch anomalies and refine prompts without losing velocity.

每当他们发现一个错误——例如对某项政策的理解偏差，或遗漏某个关键步骤——便会立即在 LangSmith 的追踪日志（trace logs）中创建新测试用例，补充更多小样本示例，或进一步拆解该子问题。这种迭代式优化流程，帮助他们在不牺牲开发速度的前提下，及时识别异常并持续精炼提示词。

## **Why they chose LangChain and LangGraph**

## **为何选择 LangChain 与 LangGraph**

• **Modularity:** The Minimal team appreciates that LangGraph, which is a component of the LangChain ecosystem, is designed as a modular framework. This structure allows them to effectively manage sub-agents in a flexible manner, avoiding the constraints of a bulky, “batteries-included” approach that lacks customization options. By utilizing a modular design, the team can tailor the functionalities to better suit their specific needs and workflows, enhancing their overall efficiency and adaptability in various projects. This level of customization empowers them to innovate and optimize their processes without being hindered by unnecessary features or limitations.

• **模块化设计：** Minimal 团队十分认可 LangGraph（LangChain 生态系统中的核心组件）所采用的模块化架构。该设计使其能够以高度灵活的方式管理各类子智能体，有效规避了“大而全”（batteries-included）式框架所带来的僵化限制——后者往往缺乏定制能力。借助模块化设计，团队可按自身具体需求与工作流，精准裁剪和组合各项功能，从而显著提升多项目场景下的整体效率与适应性。这种深度定制能力，赋予团队充分的创新空间与流程优化自由度，使其免受冗余功能或结构性约束的掣肘。

• **Integration Hooks:** The system’s code-like design made it easy to add proprietary connectors for Shopify, Monta Warehouse Management Services and Firmhouse for recurring ecommerce.

• **集成扩展接口（Integration Hooks）：** 系统具备类代码（code-like）的设计风格，因而可轻松接入专有连接器，支持 Shopify、Monta 仓储管理系统（Warehouse Management Services）以及面向周期性电商场景的 Firmhouse 等第三方服务。

• **Future-Proofing:** Adding new agents or transitioning to next-gen LLMs is a breeze. They can simply expand subgraphs for new tasks and connect them back to the Planner Agent.

• **面向未来的设计：** 添加新智能体或迁移到新一代大语言模型（LLM）轻而易举。他们只需为新任务扩展子图，并将其重新连接至规划智能体（Planner Agent）即可。

## **Results and future plans**

## **成果与未来规划**

Already, the startup has earned revenue from Dutch e-commerce clients who appreciate faster ticket resolution and advanced features like automated refunds. With a small but growing team, they aim to expand across Europe.

目前，该初创公司已从荷兰电商客户处实现营收，客户高度认可其更快的工单处理速度以及自动退款等高级功能。凭借一支虽小但持续壮大的团队，他们计划将业务拓展至整个欧洲。

By pairing multi-agent workflows with LangChain’s ecosystem—LangGraph for orchestration, LangSmith for testing, and robust e-commerce integrations—this new startup stands at the forefront of automated support. Their vision is to empower e-commerce businesses to maintain full control over every edge case while letting AI handle the heavy lifting, allowing companies to scale infinitely without hiring additional support.

通过将多智能体工作流与 LangChain 生态系统深度结合——以 LangGraph 实现编排、LangSmith 支持测试，并集成强大的电商能力——这家新兴初创公司正站在自动化客服支持的最前沿。他们的愿景是赋能电商企业，在完全掌控每一个边界场景（edge case）的同时，交由 AI 承担繁重的常规工作，从而让企业无需增聘客服人员即可实现无限规模扩展。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_002.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-minimal-built-a-multi-agent-customer-support-system-with-langgraph-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
