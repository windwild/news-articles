---
title: "Recap of Interrupt 2025: The AI Agent Conference by LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/interrupt-2025-recap/"
date: "2026-02-17"
scraped_at: "2026-03-03T07:14:13.201007013+00:00"
language: "en-zh"
translated: true
description: "Hear more about the product launches, keynote themes, and exciting news from our first-ever conference."
---
{% raw %}

That's a wrap on Interrupt 2025! This year, 800 folks from across the globe gathered in San Francisco for LangChain's first industry conference to hear stories of teams building agents – and we’re still riding the high! Cisco, Uber, Replit, LinkedIn, Blackrock, JPMorgan, Harvey, and more shared lessons on architectures, evals, observability, and prompting strategies – both their challenges and their wins.

Interrupt 2025 圆满落幕！今年，来自全球各地的 800 多位参会者齐聚旧金山，共同参与 LangChain 首届行业大会——Interrupt，聆听各团队构建 AI Agent 的真实故事。我们至今仍沉浸在这场盛会带来的振奋与喜悦之中！思科（Cisco）、优步（Uber）、Replit、领英（LinkedIn）、贝莱德（Blackrock）、摩根大通（JPMorgan）、Harvey 等企业，分享了他们在架构设计、评估方法（evals）、可观测性（observability）及提示工程（prompting strategies）等方面的宝贵经验——既有实践中的挑战，也有来之不易的成功。

The main thing we felt leaving the day was that agents are here, and we’ve never been more bullish on the future of the industry. If you weren’t with us in person, we’ll be sharing content over the next few weeks, including recordings of all the talks. Sign up [here](https://interrupt.langchain.com/?ref=blog.langchain.com#tickets) to get the content as soon as it drops!

大会结束时，我们最深切的感受是：AI Agent 已真正落地，而我们比以往任何时候都更加看好这一行业的未来。若您未能亲临现场，别担心——接下来几周内，我们将陆续发布全部会议内容，包括所有主题演讲的完整视频回放。立即点击[此处](https://interrupt.langchain.com/?ref=blog.langchain.com#tickets)注册，即可在内容上线第一时间获取！

![](images/recap-of-interrupt-2025-the-ai-agent-conference-by-langchain/img_001.jpg)

Keep reading for big themes of the days and product launches!

敬请继续阅读，了解本次大会的核心议题与重磅产品发布！

## In Case You Missed It ✨

## 错过现场？精彩回顾在此 ✨

### **Keynote Themes:**

### **主题演讲核心观点：**

Harrison's opening keynote at Interrupt highlighted a few key beliefs:

哈里森（Harrison）在 Interrupt 大会开幕主题演讲中，阐述了几个关键理念：

- **Agent Engineering is a new discipline** – Taking inspiration from the best of software engineering, prompting, product, and machine learning, we believe you need to code, engineer your prompts for the right context, understand the business workflows to turn them into agents, and understand likelihoods and distributions similar to in ML. Being good at all four disciplines is a tall task, and in pursuit of our mission to make agents ubiquitous, we want to make everyone an 100x agent engineer – no matter what your relative strengths are to start with.

- **Agent Engineering（Agent 工程）是一门全新学科**——它融合了软件工程、提示工程（prompting）、产品设计与机器学习（ML）等领域的最佳实践。我们认为，一名优秀的 Agent 工程师需具备四大能力：编写代码、针对具体场景精细化设计提示词（prompt engineering）、深入理解业务流程并将其转化为可执行的 Agent、以及像理解机器学习模型那样掌握概率与分布特性。同时精通这四项能力绝非易事；而为践行“让 Agent 无处不在”的使命，我们的目标是赋能每一位开发者，使其成长为“百倍效能的 Agent 工程师”——无论您起步时在哪方面更具优势。

- **LLM apps will rely on many different models.** The LangChain package today is mostly about giving companies model optionality. LangChain has had 3 stable releases, and we’re laser focused on depth and breadth of integrations. Developers want the choice and flexibility that LangChain provides, and as a result, LangChain has been downloaded over 70M times in the last month – even more than the OpenAI SDK 🤯.

- **大语言模型（LLM）应用将依赖多种不同模型。** 当前 LangChain 框架的核心价值，正在于为各类企业提供模型选择的自由度（model optionality）。LangChain 已发布三个稳定版本，我们正全力以赴拓展集成的深度与广度。开发者青睐 LangChain 所赋予的灵活选型能力与高度可定制性；正因如此，LangChain 在过去一个月内的下载量已突破 7000 万次——甚至超过了 OpenAI SDK 的下载量 🤯！

![](images/recap-of-interrupt-2025-the-ai-agent-conference-by-langchain/img_002.jpg)

- **LangGraph is how you build reliable agents.** One of the hardest parts about building agents is getting the right context to the LLM. LangGraph, our agent orchestration framework, gives you full authorship over the cognitive architecture so you can control the workflow and information flow. This low-level control makes LangGraph unique as an agent orchestration framework.

- **LangGraph 是构建高可靠性 Agent 的基石。** 构建 Agent 过程中最棘手的挑战之一，便是如何将恰当的上下文精准传递给大语言模型（LLM）。LangGraph 作为我们自主研发的 Agent 编排框架，赋予开发者对认知架构（cognitive architecture）的完全掌控权，从而实现对工作流（workflow）与信息流（information flow）的精细调控。这种底层级别的控制能力，正是 LangGraph 作为 Agent 编排框架的独特优势所在。

- **AI Observability is different.** With GenAI apps, you’re dealing with dense, unstructured information – often text, audio, or image. The agent engineer needs to understand what’s happening with the application, and is a totally different user with different needs than SREs that traditional observability tools serve. If LangSmith's aggregate trace volume reflects broader industry trends, more agents are moving into production—making the need for an [AI observability](https://www.langchain.com/articles/ai-observability?ref=blog.langchain.com) stack more critical than ever.

- **AI 可观测性（AI Observability）具有本质差异。** 在生成式 AI（GenAI）应用中，开发者处理的是高度密集且非结构化的信息——通常是文本、音频或图像。Agent 工程师需要实时洞察应用内部运行状况，其角色定位、使用场景与核心诉求，与传统可观测性工具所服务的站点可靠性工程师（SRE）截然不同。若 LangSmith 平台汇总的追踪（trace）数据量能反映行业整体趋势，则意味着越来越多的 Agent 正加速走向生产环境——这也使得构建一套专为 AI 场景优化的[可观测性技术栈](https://www.langchain.com/articles/ai-observability?ref=blog.langchain.com)变得前所未有的紧迫与关键。

![](images/recap-of-interrupt-2025-the-ai-agent-conference-by-langchain/img_003.jpg)

## **重磅发布！**

## **Launches!**

我们在 LangChain 始终秉持“快速交付”的理念，本次大会宣布了大量新功能！

We love to ship at LangChain, and we announced a LOT.

- **LangGraph Platform 正式全面可用（Generally Available）。**  
- **LangGraph Platform is Generally Available.**  
  [LangGraph Platform](https://www.langchain.com/langgraph-platform?ref=blog.langchain.com) 是一个专为长期运行、有状态 AI 智能体（agents）设计的部署与管理平台。即日起，您可一键部署自己的智能体——支持云托管（Cloud）、混合部署（Hybrid）及完全私有化自托管（fully self-hosted）三种模式。更多详情请参阅 [官方文档](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com)，或观看我们的 [4 分钟快速入门视频](https://www.youtube.com/watch?v=pfAQxBS5z88&t=8s&ref=blog.langchain.com)。

![](images/recap-of-interrupt-2025-the-ai-agent-conference-by-langchain/img_004.jpg)

- **Open Agent Platform —— 开源、零代码智能体构建平台。**  
- **Open Agent Platform – an open source, no code agent builder.**  
  现在，无需编程背景也能轻松构建智能体：通过图形化界面，您可自由选择 MCP 工具、自定义提示词（prompts）、指定大模型、接入数据源，甚至连接其他智能体。该平台由 LangGraph Platform 全力驱动。立即注册体验：[点击此处](https://oap.langchain.com/signin?ref=blog.langchain.com)；或查阅 [开发文档](https://docs.oap.langchain.com/?ref=blog.langchain.com) 自行搭建。

- **LangGraph Studio v2 版本发布。**  
- **LangGraph Studio v2.**  
  LangGraph Studio 现已支持纯本地运行（无需安装桌面客户端），是一款面向智能体开发的集成开发环境（IDE），助您直观可视化并深度调试智能体交互流程。v2 版本新增多项实用能力：可将执行追踪（traces）直接拉取至 Studio 中进行分析；支持向评测数据集（eval dataset）批量添加测试样例；更可在 UI 中直接编辑和更新提示词。

- **LangGraph Pre-Builts 大幅降低智能体开发门槛。**  
- **LangGraph Pre-Builts lowers the effort for building agents.**  
  在实际开发中，我们反复观察到若干高频使用的智能体架构模式，例如 Swarm（蜂群架构）、Supervisor（监督者架构）、工具调用型智能体（tool-calling agent）等。为此，我们推出 LangGraph Pre-Builts，显著减少重复性配置代码，让这些成熟架构开箱即用。详见 [预置架构文档](https://langchain-ai.github.io/langgraph/agents/prebuilt/?ref=blog.langchain.com#available-libraries)。

- **LangSmith 可观测性能力升级：新增智能体专属指标。**  
- **LangSmith Observability now includes agent specific metrics.**  
  我们现已支持对工具调用（tool calling）与智能体行为轨迹（trajectory tracking）的细粒度监控，帮助您清晰识别智能体最常走的执行路径，并快速定位耗时高、响应慢或成功率低的异常调用。

- **Open Evals 与 Chat Simulations（对话仿真）正式开源。**  
- **Open Evals and Chat Simulations**.  
  编写评估器（evaluators）往往繁琐耗时。尽管部分评估逻辑高度依赖具体应用场景，但许多通用评估需求（如代码生成、信息抽取、RAG 效果、智能体轨迹验证等）完全可以复用——这正是 Open Evals 的价值所在。我们现已开源一个高质量评估器目录（catalog），覆盖多类典型任务。同时，我们非常高兴地推出面向多轮对话场景的 **Chat Simulation（对话仿真）与配套评测能力**。欢迎访问 GitHub 仓库了解详情：[https://github.com/langchain-ai/openevals?ref=blog.langchain.com](https://github.com/langchain-ai/openevals?ref=blog.langchain.com)。

- **LLM-as-Judge：对齐与校准能力（私有预览版上线）**  
- **LLM-as-Judge: alignment and calibration (in Private Preview).**  
  LLM-as-Judge 是一种在需更高判断力与主观裁量的场景下极为有效的性能评估技术。然而，作为“裁判”的 LLM 本身也可能存在偏差。为此，我们隆重推出一项处于**私有预览阶段（Private Preview）** 的创新能力：基于人类反馈评分（human feedback scores）自动引导（bootstrap）LLM 评估器，并持续对其进行校准（calibrate）与审计（audit），确保“裁判”始终表现稳健、公平可信。若您希望抢先体验，请填写申请表获取访问权限：[点击此处报名](https://docs.google.com/forms/d/e/1FAIpQLSebD0knAtZjuN9VKbMmHmn6QL_8uZrMEfwqMi7pfIkhKYQH5Q/viewform?ref=blog.langchain.com)！

我们无比荣幸能与各位同行共建 AI 智能体生态，并致力于将 Interrupt 打造成一年一度的行业盛会。期待在 LangChain [社区 Slack 频道](https://www.langchain.com/join-community?ref=blog.langchain.com)、各地线下 Meetup 中与您交流互动，更期待 **明年再会于 Interrupt：The AI Agent Conference by LangChain！**

We’re so excited to be building alongside you all, and aim to make this an annual event. We’ll see you the C [ommunity slack](https://www.langchain.com/join-community?ref=blog.langchain.com), at our meetups, and **we’ll see you next year at Interrupt: The AI Agent Conference by LangChain.**

![](images/recap-of-interrupt-2025-the-ai-agent-conference-by-langchain/img_005.jpg)  
线下相聚，方知 LangChain 社区之魅力无可替代！  
Nothing beats the LangChain community in-person!
{% endraw %}
