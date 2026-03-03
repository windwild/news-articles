---
title: "LangChain Partners with CommandBar on their Copilot User Assistant"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-partners-with-commandbar-on-their-copilot-user-assistant/"
date: "2024-06-19"
scraped_at: "2026-03-03T08:01:15.152216300+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain", "Case Studies"]
---

[CommandBar](https://commandbar.com/?ref=blog.langchain.com) 是一个用户辅助平台，帮助软件公司通过捕获与预测用户意图，并据此提供个性化的应用内帮助，从而提升产品易用性。CommandBar 的 Copilot 小部件（企业可将其嵌入自身应用中）远不止是一个普通聊天机器人：它不仅能回答用户问题、触发个性化的产品导览，甚至还能直接代用户执行操作，切实满足其意图。

[CommandBar](https://commandbar.com/?ref=blog.langchain.com) 的客户各自需求略有不同；为确保 Copilot 能在所有客户场景中均发挥实效，CommandBar 团队需提炼出用户辅助的共性需求——这些需求既可通过大语言模型（LLM）实现流程简化或自动化，又需能灵活对接各类内容源（如帮助台系统、知识库等），以支持高效的信息检索。

CommandBar 决定采用 LangSmith，以全面掌握 Copilot 的运行表现，最终为客户提供更优质的体验。尽管该团队并未在生产环境中使用 LangChain，但借助 LangSmith 快速完成了部署。“我惊讶于仅靠 LangSmith 提供的装饰器（decorators）就能如此轻松地配置追踪（traces）——上手简直毫不费力。”高级软件工程师 Jared Luxenberg 表示。

LangSmith 主要在以下四个方面助力 CommandBar 团队：

- **追踪可视化（Trace Visibility）：** 团队仅需查看一条 LangSmith 追踪记录，即可快速判断终端用户是否遭遇了不良体验，无需再被动等待用户发送截图或邮件反馈。LangSmith 对话线程级的细粒度可见性，使 CommandBar 能主动识别问题根源，并提前优化交互设计，避免用户未来再次遭遇类似困扰。  
- **调试（Debugging）：** 打造一款优秀的 Copilot，核心在于构建一套出色的检索系统；而 LangSmith 的追踪能力，帮助团队清晰判断：系统是否在第一步就成功检索到了正确文档？若未命中，团队也能基于追踪数据尝试不同技术方案，持续优化检索效果。  
- **测试覆盖率大幅提升（Increased Testing Coverage）：** 团队将任意新代码变更所对应的自动化测试数量提升了 5 倍。在引入 LangSmith 之前，CommandBar 完全依赖人工 QA；而采用 LangSmith 后，团队得以在人工评估之外，辅以更可靠的自动评估机制——即针对已知优质问答对（grounded question : response pairs）开展精准验证。  
- **监控（Monitoring）：** CommandBar 团队依托 LangSmith 实现关键告警：一旦其 LLM 服务提供商发生故障，系统立即通知；同时，团队还可通过 LangSmith 的监控面板，实时掌握整个应用的健康状态。

LangSmith 无缝契合 CommandBar 所需的工作流，贯穿其应用开发全生命周期。自 2023 年 11 月上线以来，CommandBar 的 Copilot 已为数千个客服团队及数百万终端用户提供便捷支持，并为客户带来切实成效——例如，某近期案例研究显示，客户支持工单量下降了 44%。“每周我们都会收到来自客户的热情反馈，盛赞 Copilot 的回复精准到位；如今它已成为我们产品最具竞争力的优势之一，甚至堪称当前的旗舰产品。”Luxenberg 表示。

![](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_001.jpg)

CommandBar 相信，Copilot 未来将为用户带来更强大、更主动的辅助能力。接下来几个月，CommandBar 将陆续推出多项令人振奋的功能升级——全部由 LangSmith 提供底层支撑。欲了解更多发布详情，请访问其官方博客：[此处](https://www.commandbar.com/blog/why-we-built-copilot/?ref=blog.langchain.com)。

### 标签（Tags）

[By LangChain](https://blog.langchain.com/tag/by-langchain/) [案例研究（Case Studies）](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入职流程](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_003.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入职流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![Evaluating Deep Agents: Our Learnings](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性](images/langchain-partners-with-commandbar-on-their-copilot-user-assistant/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟