---
title: "How Airtop built web-automation for AI agents powered by the LangChain ecosystem"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-airtop/"
date: "2024-11-26"
scraped_at: "2026-03-03T07:46:52.338133034+00:00"
language: "en-zh"
translated: true
description: "See how Airtop, which provides browser automation for AI agents, built a flexible agent architecture with LangGraph and debugged and refined prompts in LangSmith."
tags: ["Case Studies"]
---

[Airtop](https://www.airtop.ai/?ref=blog.langchain.com) is a powerful platform that empowers developers to create scalable, production-ready web automations with simplicity and precision. Airtop is at the forefront of enabling agents to interact intelligently with the web, it empowers agents to perform actions such as logging in, extracting information, filling forms, and interacting with web interfaces—all through natural language commands.

[Airtop](https://www.airtop.ai/?ref=blog.langchain.com) 是一个功能强大的平台，赋能开发者以简洁性和精准性构建可扩展、面向生产的网页自动化应用。Airtop 位居智能代理与网页交互技术的前沿，使代理能够通过自然语言指令执行登录、信息提取、表单填写以及与网页界面交互等操作。

AI agents are only as functional as the data they can access. Navigating websites at scale introduces challenges like authentication and Captchas. Airtop bridges this gap by providing developers with a reliable way to control browsers via natural language APIs, eliminating the need for complex CSS selector hacks or Puppeteer scripts.

AI 代理的功能强弱，取决于其可访问的数据范围。在大规模浏览网页时，开发者常面临身份认证（authentication）和验证码（CAPTCHA）等挑战。Airtop 通过提供基于自然语言的浏览器控制 API，弥合了这一鸿沟，使开发者无需再依赖复杂的 CSS 选择器“黑科技”或 Puppeteer 脚本。

Leveraging the full LangChain ecosystem (LangChain, LangSmith, and LangGraph), Airtop has built a number of browser solutions, including:

依托完整的 LangChain 生态系统（LangChain、LangSmith 和 LangGraph），Airtop 已构建出一系列浏览器解决方案，包括：

1. **Extract API**: Enables **extraction of structured information** from web pages, like lists of speakers, LinkedIn URLs, or monitoring flight prices. Also works with authenticated sites for use cases like social listening and e-commerce.  
1. **Extract API（提取 API）**：支持从网页中**提取结构化信息**，例如演讲者名单、LinkedIn 链接或航班价格监控；亦可对接需登录认证的网站，适用于社交舆情监测、电商比价等场景。

2. **Act API:** Adds the **ability to take actions on websites,** such as entering search queries or interacting with UI elements in real-time.  
2. **Act API（执行 API）**：赋予代理在网站上**执行操作的能力**，例如输入搜索关键词，或实时与用户界面元素进行交互。

## **Simplifying model integration with LangChain**

## **借助 LangChain 简化模型集成**

As Airtop set out to build its cloud-based browsers for AI agents, they needed a platform that could flexibly integrate various LLM models. [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) quickly stood out because of its "batteries-included" approach. With built-in integrations for the GPT-4 series, Claude, Fireworks, and Gemini, LangChain saved Airtop countless hours of development time.

当 Airtop 开始为其 AI 代理构建云端浏览器时，亟需一个能灵活集成各类大语言模型（LLM）的平台。[LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 凭借其“开箱即用”（batteries-included）的设计理念迅速脱颖而出。其原生支持 GPT-4 系列、Claude、Fireworks 和 Gemini 等模型，为 Airtop 节省了海量开发时间。

“The standardized interface LangChain provides has been a game-changer,” shared Kyle, Airtop’s AI Engineer. “We can switch between models effortlessly, which has been critical as we optimize for different use cases.”

“Airtop 的 AI 工程师 Kyle 表示：“LangChain 提供的标准化接口堪称变革性突破。我们可无缝切换不同模型——这在针对多样化应用场景持续优化的过程中至关重要。”

## **Building a flexible agent architecture in LangGraph**

## **基于 LangGraph 构建灵活的代理架构**

As Airtop looked to add more browser automations, their engineering team turned to [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) to leverage its flexible architecture to build their agent system. With LangGraph, Airtop constructed individual browser automations as subgraphs. This also helped future-proof their application, as it would be easy to add in additional subgraphs as they expanded their automations — giving the team more dynamic control without needing to redesign their control flow.

随着 Airtop 计划拓展更多网页自动化能力，其工程团队转向 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com)，借助其灵活的架构构建代理系统。借助 LangGraph，Airtop 将各项网页自动化能力分别建模为独立子图（subgraph）。该设计也显著提升了应用的前瞻性（future-proofing）：未来只需新增子图即可扩展自动化能力，无需重构整体控制流，从而赋予团队更动态、更敏捷的掌控力。

As Airtop designed their agents, the team decided to start small with micro-capabilities for their agents, then building out their system with more sophisticated agents that could click on elements on the site and perform keystrokes. As their agents evolved, reliability was top-of-mind. LangGraph helped Airtop validate the accuracy of their agent steps as it took actions on a website.

在设计代理之初，Airtop 团队决定采用渐进式策略：先从微能力（micro-capabilities）起步，再逐步构建更复杂的代理——这些代理不仅能点击网页元素，还可模拟键盘输入。随着代理能力不断演进，“可靠性”始终是团队最关注的核心指标。LangGraph 帮助 Airtop 在代理执行网页操作过程中，实时验证每一步动作的准确性。

## **Debugging and refining prompts in LangSmith**

## **在 LangSmith 中调试与优化提示词**

While Airtop originally began using LangSmith to debug issues that would come in through customer support tickets, they quickly also discovered that [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) could speed up multiple parts of their development process.

Airtop 最初使用 LangSmith 主要是为了调试来自客户支持工单的问题，但很快他们便发现，[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 还能显著加速开发流程中的多个环节。

During development, Airtop used LangSmith for prompt engineering and dynamic testing. When nebulous error messages arose from AI models like OpenAI or Claude, LangSmith’s multimodal debugging features offered clarity, allowing the team to identify whether issues stemmed from formatting problems or misplaced prompt components.

在开发过程中，Airtop 利用 LangSmith 进行提示词工程（prompt engineering）和动态测试。当 OpenAI 或 Claude 等 AI 模型返回模糊不清的错误信息时，LangSmith 的多模态调试功能提供了清晰的可视化洞察，帮助团队快速判断问题根源——究竟是格式错误，还是提示词组件位置不当。

![](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_001.jpg)

![](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_001.jpg)

In addition, it was important for the Airtop team to empower their users with reliable web automation capabilities. They utilized LangSmith’s playground to iterate on prompts and run parallel model requests, simulating real-world use cases on the fly. This sped up Airtop’s internal workflows and enhanced their ability to deliver more accurate, tailored responses to users.

此外，为用户提供稳定可靠的网页自动化能力，对 Airtop 团队至关重要。他们借助 LangSmith 的 Playground 功能快速迭代提示词，并并行发起多个模型请求，实时模拟真实场景下的用户交互。此举不仅加快了 Airtop 内部工作流，也显著提升了其向用户交付更精准、更个性化响应的能力。

![](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_002.jpg)

![](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_002.jpg)

## **What’s next**

## **下一步计划**

Airtop has significantly accelerated its time-to-market for AI agent-powered web automation solutions. With LangGraph’s controllable agent framework and LangSmith for testing in development, the team ensures robust agent performance.

Airtop 已大幅缩短了 AI 智能体驱动的网页自动化解决方案的上市周期。依托 LangGraph 可控的智能体框架，以及 LangSmith 在开发阶段的测试能力，团队得以保障智能体运行的稳定性与可靠性。

_“Each innovation becomes a foundation for what's next,”_ said Daniel Shteremberg, Airtop’s CTO. _“With LangChain and LangSmith, we can create solutions that are adaptable, reliable, and future-proof.”_

Airtop 首席技术官 Daniel Shteremberg 表示：“每一项创新，都将成为下一次突破的基石。借助 LangChain 和 LangSmith，我们能够构建出具备强适应性、高可靠性且面向未来的解决方案。”

In the future, the Airtop team aims to:  

未来，Airtop 团队的目标包括：

1. **Build even more sophisticated agents**, with advanced LangGraph agents capable of performing multi-step, high-value tasks, such as stock market analysis or enterprise-level automation.

1. **构建更加复杂的智能体**：借助功能更强大的 LangGraph 智能体，执行多步骤、高价值任务，例如股票市场分析或企业级自动化。

2. **Adding additional** micro-capabilities to the platform, enabling AI agents to perform an unlimited range of actions across the web.

2. **新增更多微能力**：为平台持续扩展微能力，使 AI 智能体能够在 Web 上执行无限种类的操作。

3. **Enhanced benchmarking**: Further refining their benchmarking system to evaluate performance across a wider array of model configurations and use cases.

3. **增强的基准测试能力**：进一步优化其基准测试体系，以在更广泛的模型配置和实际应用场景中评估性能。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith，通过 AI Agent 转型客户体验](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith，通过 AI Agent 转型客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![ServiceNow 如何利用 LangSmith 实现客户成功 Agent 的可观测性](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现客户成功 Agent 的可观测性**](https://blog.langchain.com/customers-servicenow/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性 Agent](images/how-airtop-built-web-automation-for-ai-agents-powered-by-the-langchain-ecosystem/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟