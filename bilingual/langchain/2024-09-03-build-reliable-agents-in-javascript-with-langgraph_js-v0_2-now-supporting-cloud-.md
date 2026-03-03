---
title: "Build reliable agents in JavaScript with LangGraph.js v0.2: Now supporting Cloud and Studio"
source: "LangChain Blog"
url: "https://blog.langchain.com/javascript-langgraph-v02-cloud-studio/"
date: "2024-09-03"
scraped_at: "2026-03-03T07:54:57.426724747+00:00"
language: "en-zh"
translated: true
description: "For JavaScript developers - LangGraph v0.2, LangGraph Cloud, and LangGraph Studio are all available."
---

Today, we’re launching [LangGraph.js v0.2.0](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com), our JavaScript/TypeScript framework for building LLM-powered agents. Here’s what’s new:

今天，我们正式发布 [LangGraph.js v0.2.0](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com) —— 我们面向 JavaScript/TypeScript 的、用于构建大语言模型（LLM）驱动智能体（agent）的框架。以下是本次更新的主要特性：

- [**灵活的流式输出（Streaming）**](https://langchain-ai.github.io/langgraphjs/how-tos/stream-values/?ref=blog.langchain.com)：支持对中间步骤及聊天模型消息进行多种模式的流式传输  
- [**内置检查点系统（Checkpointing）**](https://langchain-ai.github.io/langgraphjs/how-tos/persistence/?ref=blog.langchain.com)：支持回溯至历史状态，便于调试模型响应异常等错误  
- [**原生支持人工介入（Human-in-the-Loop）**](https://langchain-ai.github.io/langgraphjs/how-tos/breakpoints/?ref=blog.langchain.com)：可在图中任意节点中断执行、修改内部状态，并从中断点继续运行  
- [**并行节点支持（Parallel Node Support）**](https://langchain-ai.github.io/langgraphjs/how-tos/map-reduce/?ref=blog.langchain.com)：支持同时运行多个节点并聚合其结果  

我们还为 [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/)（面向桌面端的智能体集成开发环境 IDE）和 [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/)（用于部署智能体的可扩展基础设施）新增了对 LangGraph.js 项目的**Beta 版支持**。

LangGraph.js 已助力顶尖 AI 团队攻克关键难题。Elastic 公司安全分析领域的生成式 AI 与机器学习总监 James Spiteri 表示：

> _“LangGraph.js 及整个 LangChain 生态系统，已成为 Elastic 安全 AI 助理（Security AI Assistant）、攻击发现（Attack Discovery）与自动导入（Automatic Import）功能架构中的核心组件，帮助我们以前所未有的速度完成迭代，并将_ [_这些功能_](https://www.elastic.co/security/ai?ref=blog.langchain.com) _快速推向生产环境。LangChain 团队持续不断的改进与紧密协作令我们印象深刻，我们也非常期待继续携手 LangChain 共同构建未来。”_

对于 JavaScript 开发者社区而言，这些新特性进一步强化了“构建 → 调试 → 部署”这一闭环流程，使开发者能够更高效地打造稳定、可靠的智能体应用。

内容丰富，让我们即刻深入探索！

## **使用 LangGraph 0.2 在 JavaScript 中构建可控智能体**

## **使用 LangGraph 0.2 在 JavaScript 中构建可控智能体**

Unlike traditional APIs, LLMs pose unique challenges to developers due to their long-running, non-deterministic nature. These challenges compound as the number of LLM calls in your logic increases, especially as you introduce agentic steps that give models autonomy over your code execution.

与传统 API 不同，大语言模型（LLM）因其长时运行、非确定性等特性，给开发者带来了独特挑战。当逻辑中调用 LLM 的次数增多时，这些挑战会愈发显著；尤其在引入“智能体式步骤（agentic steps）”——即赋予模型自主控制代码执行流程的能力后，挑战将进一步加剧。

LangGraph.js provides JavaScript developers with a powerful toolkit for addressing these complexities and creating delightful experiences around agents. LangGraph.js can improve your application’s:

LangGraph.js 为 JavaScript 开发者提供了一套强大工具集，助您应对上述复杂性，并围绕智能体打造卓越的用户体验。LangGraph.js 可显著提升您应用的以下能力：

- **Responsiveness:** By [streaming results token-by-token](https://langchain-ai.github.io/langgraphjs/how-tos/stream-tokens/?ref=blog.langchain.com), you can deliver real-time, interactive experiences and report progress immediately. Having various modes of streaming is crucial for web apps that demand instant feedback and smooth user experience.  
- **响应性（Responsiveness）：** 通过 [逐 Token 流式传输结果](https://langchain-ai.github.io/langgraphjs/how-tos/stream-tokens/?ref=blog.langchain.com)，您可提供实时、交互式的用户体验，并即时反馈执行进度。支持多种流式传输模式，对需要即时响应与流畅体验的 Web 应用至关重要。

- **Resilience:** Using node-level retry policies and checkpointing, ensure your app stays robust. If a service goes down or a step fails, your app can recover seamlessly and resume execution from previous states.  
- **韧性（Resilience）：** 借助节点级重试策略与检查点（checkpointing）机制，保障应用的强健性。当某项服务宕机或某个步骤执行失败时，您的应用可无缝恢复，并从先前保存的状态继续执行。

- **Access control:** Restrict sensitive tools to [require human approval](https://langchain-ai.github.io/langgraphjs/how-tos/review-tool-calls/?ref=blog.langchain.com). This lets you protect your application and reduce the risk of unintended consequences.  
- **访问控制（Access control）：** 对敏感工具设置 [人工审批要求](https://langchain-ai.github.io/langgraphjs/how-tos/review-tool-calls/?ref=blog.langchain.com)。此举可有效保护您的应用，显著降低意外后果发生的风险。

LangGraph.js also runs in most JS runtimes, including Node, Deno, Cloudflare Workers, Vercel’s Edge runtime and [even in the browser](https://langchain-ai.github.io/langgraphjs/how-tos/use-in-web-environments/?ref=blog.langchain.com) through the `@langchain/langgraph/web` entry point.  
LangGraph.js 还可在绝大多数 JavaScript 运行时环境中运行，包括 Node.js、Deno、Cloudflare Workers、Vercel 的 Edge Runtime，甚至可通过 `@langchain/langgraph/web` 入口点 [直接在浏览器中运行](https://langchain-ai.github.io/langgraphjs/how-tos/use-in-web-environments/?ref=blog.langchain.com)。

Check out our revamped [documentation](https://langchain-ai.github.io/langgraphjs/?ref=blog.langchain.com) for new how-to guides, tutorials, and conceptual guides that help you get started. For an overview of the latest changes and updates to the documentation, you can also view a summary [here](https://langchain-ai.github.io/langgraphjs/versions/?ref=blog.langchain.com).  
欢迎查阅我们全面更新的 [文档](https://langchain-ai.github.io/langgraphjs/?ref=blog.langchain.com)，其中包含全新编写的操作指南（how-to guides）、教程（tutorials）及概念性讲解（conceptual guides），助您快速上手。如需了解文档的最新变更与更新概览，您还可在此处查看 [汇总说明](https://langchain-ai.github.io/langgraphjs/versions/?ref=blog.langchain.com)。

## **Iterate and debug faster with LangGraph Studio**  
## **借助 LangGraph Studio 加速迭代与调试**

[LangGraph Studio](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) provides a best-in-class experience for debugging agents. In dynamic TypeScript / JavaScript environments involving async operations, it’s often tough to understand the flow of data– with LLM-powered agents adding further branching logic complexity.  
[LangGraph Studio](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) 为智能体（agent）调试提供了业界领先的开发体验。在涉及异步操作的动态 TypeScript / JavaScript 环境中，数据流向往往难以厘清；而由大语言模型（LLM）驱动的智能体又进一步引入了复杂的分支逻辑，使问题更加棘手。

LangGraph Studio automatically detects your graph’s inputs and outputs using TypeScript's type inference, giving you a clear visual overview of your logic. This eliminates the need to manually trace different data flows and simplifies debugging.  
LangGraph Studio 利用 TypeScript 的类型推断能力，自动识别您图结构（graph）的输入与输出，为您提供清晰直观的逻辑可视化视图。这消除了手动追踪各类数据流的繁琐过程，大幅简化调试工作。

When testing, you can travel back to individual states and rerun them. This lets you identify and fix issues without restarting the entire application. You can also set interrupts to step through your logic and inspect how your code is executing step-by-step. LangGraph Studio even supports hot reload to apply changes in real-time and speed up development!  
在测试过程中，您可以回溯至任意历史状态并重新执行该状态——无需重启整个应用即可定位并修复问题。您还可设置中断点（interrupts），逐层遍历逻辑流程，细致检查代码每一步的实际执行情况。LangGraph Studio 甚至支持热重载（hot reload），实现变更的实时生效，显著提升开发效率！

We’re excited to announce that LangGraph Studio now supports LangGraph.js. LangGraph Studio is currently in beta, and is free to all LangSmith users during the beta period. **You can download the latest release** [**here**](https://github.com/langchain-ai/langgraph-studio?tab=readme-ov-file&ref=blog.langchain.com#download) **and check out** [**this repo**](https://github.com/langchain-ai/langgraphjs-studio-starter?ref=blog.langchain.com) **for a JavaScript starter template.**  
我们很高兴地宣布：LangGraph Studio 现已正式支持 LangGraph.js！目前 LangGraph Studio 处于 Beta 测试阶段，在此期间对所有 LangSmith 用户免费开放。**您可在此处下载最新版本** [**此处**](https://github.com/langchain-ai/langgraph-studio?tab=readme-ov-file&ref=blog.langchain.com#download)，并访问 [**该代码仓库**](https://github.com/langchain-ai/langgraphjs-studio-starter?ref=blog.langchain.com) 获取面向 JavaScript 的入门模板（starter template）。

And if you have an existing graph, you’ll need to [update to the latest versions](https://langchain-ai.github.io/langgraphjs/how-tos/manage-ecosystem-dependencies/?ref=blog.langchain.com) of LangGraph.js and LangChain core, then export your graph from a file and add a langgraph.json file with the path and some metadata.  
若您已有现成的图结构，您需要先 [升级至 LangGraph.js 与 LangChain Core 的最新版本](https://langchain-ai.github.io/langgraphjs/how-tos/manage-ecosystem-dependencies/?ref=blog.langchain.com)，再将图结构从文件导出，并添加一个包含路径及部分元数据的 `langgraph.json` 文件。

## **Deploy at scale with LangGraph Cloud**  
## **依托 LangGraph Cloud 实现规模化部署**

Once you've perfected your LangGraph.js graphs locally, you can deploy them in one-click on [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.dev). Designed for web-scale, LangGraph Cloud helps you manage and provision task queues and servers so that your agents can handle many concurrent users and high traffic.

当您在本地完善了 LangGraph.js 图后，即可通过一键部署将其发布至 [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.dev)。LangGraph Cloud 专为 Web 规模设计，可帮助您管理并配置任务队列与服务器，使您的智能体能够应对大量并发用户及高流量负载。

For diagnosing issues in production, LangGraph Cloud integrates with LangSmith for detailed tracing and uses a built-in Postgres checkpointer. This out-of-the-box checkpointer stores states and threads so that you can rewind and rerun previous states, allowing you to troubleshoot and replicate issues as if you were developing locally.

在生产环境中诊断问题时，LangGraph Cloud 深度集成 LangSmith，提供详尽的追踪能力，并内置基于 PostgreSQL 的检查点（checkpointer）。该开箱即用的检查点机制会持久化保存图的状态（state）与线程（thread），使您能够回退并重放历史状态，从而像在本地开发时一样高效地排查与复现问题。

In addition, LangGraph Cloud supports advanced real-world interaction patterns beyond streaming and human-in-the-loop. These include features like double-texting to handle new user inputs on active threads of the graph, async background jobs to manage long-running tasks, and cron jobs to automate scheduled processes.

此外，LangGraph Cloud 支持超越流式响应（streaming）与人工干预（human-in-the-loop）的高级真实场景交互模式。例如：支持“双消息”（double-texting）机制，在图的活跃线程中实时响应新的用户输入；支持异步后台任务（async background jobs），用于处理长时间运行的任务；以及支持定时任务（cron jobs），以自动化执行周期性流程。

**LangGraph Cloud is now available in beta for all LangSmith users on Plus or Enterprise plans. Try it out today for free** [**by signing up for LangSmith**](https://smith.langchain.com/?ref=blog.langchain.dev) **.**

**LangGraph Cloud 现已面向所有订阅 LangSmith Plus 或 Enterprise 计划的用户开放 Beta 测试。立即免费体验——[注册 LangSmith 即可开始](https://smith.langchain.com/?ref=blog.langchain.dev)。**

## **What’s next?**

## **下一步是什么？**

This is just the beginning - we’re committed to making LangGraph.js the most delightful way to build agents in JavaScript in the long run.

这仅仅是个开始——我们长期致力于将 LangGraph.js 打造成使用 JavaScript 构建智能体（agents）最愉悦、最高效的开发方式。

We’re closely listening to the community and their feedback, many of whom are already running LangGraph.js in production – and we invite you to share your thoughts.  [Connect with us on X](https://x.com/LangChainAI?ref=blog.langchain.com), or join our [community Slack workspace](https://join.slack.com/t/langchaincommunity/shared_invite/zt-2of5edn9u-kVYpEDdEkbg7JDQxpg0HsQ?ref=blog.langchain.com).

我们正密切关注社区的声音与反馈——其中已有许多用户正在生产环境中运行 LangGraph.js。诚挚邀请您分享宝贵见解：[欢迎在 X 平台关注我们](https://x.com/LangChainAI?ref=blog.langchain.com)，或加入我们的 [社区 Slack 工作区](https://join.slack.com/t/langchaincommunity/shared_invite/zt-2of5edn9u-kVYpEDdEkbg7JDQxpg0HsQ?ref=blog.langchain.com)。