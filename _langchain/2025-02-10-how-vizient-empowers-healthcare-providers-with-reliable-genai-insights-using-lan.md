---
render_with_liquid: false
title: "How Vizient empowers healthcare providers with reliable GenAI insights using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-vizient/"
date: "2025-02-10"
scraped_at: "2026-03-03T07:40:19.661611562+00:00"
language: "en-zh"
translated: true
description: "Vizient's GenAI platform helps users manage data to query for information ranging from patient outcomes to clinical benchmarking. See how they used LangGraph and LangSmith for multi-agent system relia..."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Vizient](https://www.vizientinc.com/?ref=blog.langchain.com)，作为医疗健康绩效提升领域的领军企业，正在彻底改变医疗服务提供者访问与分析数据的方式。当前，许多医疗机构依赖彼此割裂的数据源，需耗费大量时间“挖掘”数据，才能生成有关患者照护的可操作洞察——这一过程漫长而低效。Vizient 的生成式 AI（GenAI）平台赋能各类规模的医疗系统，实现对孤立数据集的统一查询与整合，从而在供应链管理与临床结局优化方面推动更优决策。

Vizient 的 GenAI 平台可直接回答诸如：“我的门诊投资是否有效？”或“我们是否提供了最具成本效益的诊疗服务？”等关键问题，并即时提供基于数据的可靠答案。其目标是提升运营效率，同时将数据分析能力普及至资源受限的基层医疗机构——所有这一切，均建立在对其会员机构高度信任与严格数据隐私保护的基础之上。

![](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_001.jpg)某示例医院系统在 Vizient GenAI 平台中的绩效记分卡（Scorecard）

### **借助 LangGraph 构建高可靠性 AI 智能体工作流**

在采用 LangGraph 之前，Vizient 的多智能体系统面临诸多挑战。每个智能体原本被设计为执行特定任务，例如分析历史数据或生成可视化图表；但协调这些智能体却十分困难。它们各自独立运行、互不联通，导致响应不一致、系统整体可靠性不足。此外，部分底层 API 工作流每次调用需管理数百个参数，使得应用逻辑的维护与更新异常复杂。

![](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_002.jpg)Vizient 的 AI 用户界面：支持与数据对话并自动生成可视化图表

为协调其多智能体系统，并确保平台满足高标准的可靠性要求，Vizient 选择采用 [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) 来编排其智能体系统。依托 LangGraph 的图结构与完全可描述的原语（primitives），Vizient 工程团队得以精准控制并规划工作流，将智能体应执行的每一步操作以工具（tool）或节点（node）的形式进行程序化定义，显著提升了系统可靠性。如今，其层级化智能体架构（即多个工作智能体向一位主管智能体汇报）已极大简化了请求路由流程，使请求能高效、准确地分发至对应 API。

随着 Vizient 不断拓展与增强其 GenAI 平台，LangGraph 始终是其技术战略的核心支柱，助力团队自信地实现系统演进与规模化扩展。

### **借助 LangSmith 实现大语言模型可观测性与提示词管理**

为保障 GenAI 平台稳定高效运行，Vizient 需要对其性能具备全面可观测性——这正是 LangSmith 发挥关键作用之处。借助 LangSmith 的追踪（tracing）能力，Vizient 工程师可在高压力、实时演示等关键场景中快速定位并解决各类问题。例如，他们轻松排查并修复了由 Azure OpenAI 内容过滤器触发的拦截问题，以及外部限流机制引发的错误。

LangSmith's Prompt Hub has also proved invaluable.  
LangSmith 的 Prompt Hub 也已被证明极具价值。

By isolating prompt logic, Vizient's teams gained the flexibility to version and iterate on prompts with ease—a much more flexible approach.  
通过将提示词逻辑解耦，Vizient 的各团队得以轻松地对提示词进行版本管理与迭代——这是一种灵活得多的开发方式。

As the number of GenAI development teams grows, having this logic separated out will help teams handle and iterate on prompts quickly.  
随着生成式 AI 开发团队数量的持续增长，将该逻辑独立出来，将有助于各团队快速处理和迭代提示词。

### **Looking Forward**

### **展望未来**

Vizient is focused on refining evaluations to ensure output consistency and trust. Key initiatives include:  
Vizient 正专注于优化评估机制，以确保输出结果的一致性与可信度。关键举措包括：

- **Evaluating consistency across data domains:** Aligning generated answers with established tools like Q&A scorecards.  
- **跨数据域的一致性评估**：将生成的答案与既有的评估工具（如问答评分卡）对齐。

- **Rapid data onboarding**: The team aims to quickly onboard product data to fuel its agentic system using various existing product APIs and other data sources.  
- **快速数据接入**：团队计划利用多种现有产品 API 及其他数据源，迅速将产品数据接入系统，为智能体（agentic）系统提供支撑。

Vizient is building a transformative GenAI platform that empowers healthcare providers. It enables even non-experts to ask complex questions and get actionable insights while maintaining the highest trust, security, and innovation standards. With LangGraph and LangSmith as foundational technologies, Vizient is poised to continue raising the bar for healthcare performance improvement.  
Vizient 正在构建一个具有变革意义的生成式 AI 平台，赋能医疗健康服务提供方。该平台使即便是非技术专家也能提出复杂问题，并获得可落地的洞察，同时始终坚守最高水平的可信度、安全性和创新标准。依托 LangGraph 和 LangSmith 这两项基础技术，Vizient 将持续引领医疗绩效提升的新高度。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_003.png)](https://blog.langchain.com/customers-monday/)  
[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)  
[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-vizient-empowers-healthcare-providers-with-reliable-genai-insights-using-lan/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟