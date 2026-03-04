---
title: "How Lovable uses LangSmith to debug & monitor agents in production"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-lovable/"
date: "2025-03-26"
scraped_at: "2026-03-03T07:36:46.342556555+00:00"
language: "en-zh"
translated: true
description: "Discover how Lovable leveraged LangSmith to gain visibility into its agent’s interactions, rapidly scaling its AI software engineer agent to $25M ARR in just 4 months."
tags: ["Case Studies"]
---
{% raw %}

[Lovable.dev](http://loveable.dev/?ref=blog.langchain.com) 是一个创新的、由 AI 驱动的平台，使用户无需编写代码即可构建并上线高质量的软件初版（v1）。该平台支持与 GitHub、Supabase 等工具无缝集成，极大简化了应用的创建与部署流程。用户只需通过自然语言对话，即可快速构建网站和 Web 应用；例如，可一键构建并部署具备身份认证（authentication）和数据存储功能的应用，开发效率较传统编码方式提升达 20 倍。

## **使用 LangSmith 实现智能体可观测性**

## **使用 LangSmith 实现智能体可观测性**

随着 Lovable 快速增长及用户规模持续扩大，团队亟需深入洞察其智能体（agent）在实际运行中的交互行为。面对激增的用户量，厘清智能体各组件之间复杂的交互逻辑，已成为 Lovable 团队保障系统高效运转、交付流畅用户体验的关键所在。

为突破智能体问题诊断缓慢、功能迭代迟滞这一瓶颈，Lovable 引入 LangSmith，以全面掌握其智能体调用链（agentic chain）的运行细节——此举至关重要。工作流的一项关键优化，是新增了一个仅限管理员访问的按钮：“在 LangSmith 中打开提示词”（open prompt in LangSmith）。该功能使团队成员可即时查看详尽的智能体执行轨迹（traces），从而赋能开发者快速定位性能瓶颈、优化执行流程，显著提升整体运维效率。

借助 LangSmith 的多请求聚合能力及其底层 API，Lovable 能够精准定位任意生产环境中的会话，并即时回溯应用开发过程中所执行的操作序列。监控图表帮助团队第一时间识别各项指标的异常突增，随后双击任一异常轨迹即可深入排查根本原因。这不仅大幅提升了调试效率，更助力团队深入理解系统中各组件间的协作机制，从而持续迭代优化其智能体设计与实现。

## **成效与后续规划**

## **成效与后续规划**

LangSmith 的集成已为 Lovable 带来显著成果：

- **调试能力大幅提升**：LangSmith 使 Lovable 能够对智能体调用链中任意环节进行深度自省（introspect），大幅减少问题诊断耗时，显著加快故障解决速度。  
- **协作效率明显改善**：代码统一托管于 GitHub，团队成员得以无缝协同开发，营造出高度协作、责任共担的工程文化。

展望未来，Lovable 计划进一步精进智能体开发流程，并将持续探索 LangSmith 的更多高级功能，以进一步提升终端用户体验与内部运营效率。

## **结语**

## **结语**

Lovable's strategic use of LangSmith has been instrumental in its rapid growth, enabling the company to achieve the milestone of $25M ARR in just four months. The integration of LangSmith has not only streamlined workflows but also set the stage for future advancements, showcasing the transformative potential of AI in the software development landscape.

Lovable 对 LangSmith 的战略性应用在其快速增长中发挥了关键作用，助力公司仅用四个月便实现了 2500 万美元年经常性收入（ARR）的重要里程碑。LangSmith 的集成不仅优化了工作流程，还为未来的技术演进奠定了基础，充分展现了人工智能在软件开发领域所蕴含的变革性潜力。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_001.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI Agent 转型客户体验](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI Agent 转型客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![ServiceNow 如何利用 LangSmith 实现客户成功 Agent 的可观测性](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现客户成功 Agent 的可观测性**](https://blog.langchain.com/customers-servicenow/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性 Agent](images/how-lovable-uses-langsmith-to-debug-monitor-agents-in-production/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
{% endraw %}
