---
title: "UX for Agents, Part 3: Spreadsheet, Generative, and Collaborative UI/UX"
source: "LangChain Blog"
url: "https://blog.langchain.com/ux-for-agents-part-3/"
date: "2024-08-10"
scraped_at: "2026-03-03T07:55:47.222224567+00:00"
language: "en-zh"
translated: true
description: "Learn about spreadsheet UX for batch agent workloads, Generative UI, and collaborative UX with agents."
tags: ["Harrison's Hot Takes"]
---

_At Sequoia’s AI Ascent conference in March, I talked about three limitations for agents: planning, UX, and memory. Check out that talk_ [_here_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _. Since UX for agents is such a wide-ranging topic, we’ve split our discussion of it into three posts. See the first blog post on_ [_chat UX_](https://blog.langchain.com/ux-for-agents-part-1-chat-2/) _and the second on_ [_ambient UX_](https://blog.langchain.com/ux-for-agents-part-2-ambient/) _. This is our third post on UX for agents, focused on spreadsheet, generative, and collaborative UI/UX._

在今年3月红杉资本（Sequoia）举办的“AI Ascent”大会上，我探讨了智能体（agents）面临的三大局限：规划能力（planning）、用户体验（UX）和记忆能力（memory）。欢迎点击此处观看该演讲视频：[_链接_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com)。由于智能体的用户体验涵盖范围极广，我们将其拆分为三篇系列博文展开讨论。第一篇聚焦于[_对话式 UX_](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)，第二篇探讨[_环境式 UX（ambient UX）_](https://blog.langchain.com/ux-for-agents-part-2-ambient/)，而本篇——即第三篇——则重点介绍面向智能体的**电子表格式、生成式与协作式 UI/UX**。

This is my third post on agent UX, but I could probably dive into ten more — there is so much to explore as we all figure out the best ways to build and interact with agents. The UI/UX space for agents is one of the spaces I am most excited about and will be watching closely for innovation in the coming months.

这虽是我关于智能体 UX 的第三篇博文，但其实我还能再写十篇不止——随着我们共同探索构建与交互智能体的最佳方式，这一领域尚有大量未知等待发掘。智能体的 UI/UX 正是我最期待、也将在未来数月持续密切关注的创新高地之一。

In an attempt to wrap up the discussion on agent UI/UX, I’ll highlight three lesser-known UXs that have recently become more popular. Each of these could easily deserve its own blog post (which may happen down the line!).

为阶段性收束关于智能体 UI/UX 的系列讨论，本文将重点介绍三种近期日益流行、却尚未被广泛认知的 UX 范式。其中任意一种，都足以独立成篇（未来或许真会如此！）。

## Spreadsheet UX

## 电子表格式 UX

One UX paradigm I’ve seen a lot in the past ~2 months is a spreadsheet UX. I first saw this when [Matrices, an AI-native spreadsheet](https://x.com/dina_yrl/status/1753206294784418024?ref=blog.langchain.com), was launched earlier this year.

过去约两个月里，我频繁见到一种 UX 范式——即“电子表格式 UX”。今年早些时候，当 [Matrices（一款原生支持 AI 的电子表格工具）](https://x.com/dina_yrl/status/1753206294784418024?ref=blog.langchain.com) 发布时，我首次注意到这种设计。

![](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_001.png)

![](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_001.png)

I loved seeing this. First and foremost, the spreadsheet UX a super intuitive and user friendly way to support batch workloads. Each cell becomes it own agent, going to off to research a particular thing. This batching allows users to scale up and interact with multiple agents simultaneously.

我对这种设计倍感欣喜。首先，电子表格式 UX 是一种极为直观、用户友好的批量任务处理方式：每个单元格本身即可成为一个智能体，各自执行特定的研究或计算任务。这种“批处理”机制使用户得以规模化扩展操作，同时与多个智能体交互。

There are other benefits of this UX as well. The spreadsheet format is a very common UX familiar to most users, so it fits in well with existing workflows. This type of UX is **perfect** for data enrichment, a common LLM use case where each column can represent a different attribute to enrich.

此类 UX 还具备其他优势：电子表格格式是绝大多数用户早已熟悉的通用界面，因而能无缝融入现有工作流。它尤其**适合数据增强（data enrichment）**——这是大语言模型（LLM）的一类典型应用场景，其中每一列均可代表一个待增强的不同属性。

Since then, I’ve seen this UX pop up in a few places ( [Clay](https://www.clay.com/?ref=blog.langchain.com) and [Otto](https://x.com/SullyOmarr/status/1803779798658859067?ref=blog.langchain.com) are two great examples of this).

此后，我已在多个产品中观察到此类 UX 的实践应用（例如 [Clay](https://www.clay.com/?ref=blog.langchain.com) 和 [Otto](https://x.com/SullyOmarr/status/1803779798658859067?ref=blog.langchain.com)，便是两个极佳范例）。

## Generative UI

## 生成式 UI

The concept of “generative UI” can mean a few different things.

“生成式 UI”（generative UI）这一概念可以有多种不同含义。

One interpretation is a truly generative UI where the model generates the raw components to display. This is similar to applications like [WebSim](https://websim.ai/?ref=blog.langchain.com). Under the hood, the agent is largely writing raw HTML, allowing it to have **FULL** control over what is displayed. However, this approach allows for a lot of variability in the quality of the generated HTML, so the end result may look a bit wild or unpolished.

一种理解是“真正意义上的生成式 UI”，即由模型直接生成用于展示的原始界面组件。这类似于 [WebSim](https://websim.ai/?ref=blog.langchain.com) 这类应用。其底层实现中，智能体（agent）主要通过编写原始 HTML 来构建界面，从而对所呈现内容拥有**完全**（FULL）控制权。然而，该方法会导致所生成 HTML 的质量差异较大，最终界面效果可能略显杂乱或不够精致。

![](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_002.png)

Another more constrained approach to generative UI involves programmatically mapping the LLM response to different pre-defined UI components. This is often done with tool calls. For instance, if an LLM calls a weather API, it then triggers the rendering of a weather map UI component. Since the components rendered are not truly **generated** (but more chosen), the resulting UI will be more polished, though less flexible in what it can generate.

另一种更受约束的生成式 UI 实现方式，则是将大语言模型（LLM）的响应以编程方式映射到若干预定义的 UI 组件上。这种映射通常借助工具调用（tool calls）完成。例如，当 LLM 调用天气 API 时，系统便会触发渲染一个天气地图 UI 组件。由于所呈现的组件并非真正由模型“生成”，而更多是“选择”所得，因此最终界面更为精致，但可生成的内容类型也相应受限、灵活性较低。

You can learn more about generative UI in [our video series here](https://www.youtube.com/watch?v=mL_KuQgX9Oc&ref=blog.langchain.com).

您可通过[本系列视频](https://www.youtube.com/watch?v=mL_KuQgX9Oc&ref=blog.langchain.com)进一步了解生成式 UI。

## Collaborative UX

## 协作式用户体验（Collaborative UX）

A lesser explored UX: what happens when agents and humans are working together? Think Google Docs, where you can collaborate with teammates on writing or editing documents - but instead, one of your collaborators is an agent.

一种尚未被充分探索的用户体验范式：当智能体（agents）与人类协同工作时，会发生什么？想象一下 Google Docs —— 你可与团队成员共同撰写或编辑文档；而在此场景中，你的某位协作者将是一位智能体。

The leading thinkers in the space in my mind are [Geoffrey Litt](https://x.com/geoffreylitt?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) and [Ink & Switch](https://www.inkandswitch.com/?ref=blog.langchain.com), with their [Patchwork project](https://x.com/geoffreylitt/status/1784717440720507355?ref=blog.langchain.com) being a great example of human-agent collaboration.

在我心目中，该领域最具前瞻性的思考者包括 [Geoffrey Litt](https://x.com/geoffreylitt?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) 和 [Ink & Switch](https://www.inkandswitch.com/?ref=blog.langchain.com)，他们联合发起的 [Patchwork 项目](https://x.com/geoffreylitt/status/1784717440720507355?ref=blog.langchain.com) 正是人机协作的绝佳范例。

![](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_003.jpg)

How does collaborative UX compare to the previously discussed [ambient UX](https://blog.langchain.com/ux-for-agents-part-2-ambient/)? Our founding engineer Nuno highlights the key differences between the two:

协作式用户体验（Collaborative UX）与此前讨论过的[环境式用户体验（ambient UX）](https://blog.langchain.com/ux-for-agents-part-2-ambient/)有何异同？我们的创始工程师 Nuno 指出了二者的关键区别：

The main difference between ambient and collaborative is concurrency:

环境式（ambient）与协作式（collaborative）体验的核心区别在于**并发性**：

- In a **collaborative UX**, you and the LLM often do work simultaneously, "feeding" off of each others work  
- 在**协作式用户体验（collaborative UX）**中，你与大语言模型（LLM）通常同步开展工作，彼此“承接”对方的输出继续推进。

- In an **ambient UX**, the LLM is continuously doing work in the background while you, the user, focus on something else entirely  
- 在**环境式用户体验（ambient UX）**中，LLM 持续在后台运行，而你——作为用户——则完全专注于其他任务。

These differences also translate into distinct requirements when building these applications:

这些差异也直接转化为构建两类应用时截然不同的技术需求：

- For **collaborative UX**, you may need to display granular pieces of work being done by the LLM. (This falls somewhere on the spectrum between individual tokens and larger, application-specific pieces of work like paragraphs in a text editor). A common requirement might be having an automated way to merge concurrent changes, similar to how Google Doc manages real-time collaboration.  
- 对于**协作式 UX**，你可能需要实时呈现 LLM 正在执行的细粒度工作单元（其粒度介于单个 token 与更宏观、应用特定的单元之间，例如文本编辑器中的段落）。一个典型需求是：需具备自动化合并并发变更的能力，类似于 Google Docs 对实时协作的处理方式。

- For **ambient UX**, you may need to summarize the work done by the LLM or highlight any changes. A common requirement might be to trigger a run from an event that happened in some other system, e.g. via a webhook.  
- 对于**环境式 UX**，你可能需要对 LLM 完成的工作进行摘要，或突出显示其中的关键变更。一个常见需求是：通过外部系统发生的事件（例如 Webhook）来触发一次运行。

## Why are we thinking about this?

## 我们为何关注这一问题？

LangChain is not known for being a UI/UX focused company. But we spend a _lot_ of time thinking about this. Why?

LangChain 并非一家以 UI/UX 为核心定位的公司。但我们却投入了**大量精力**思考这一问题。为什么？

Our goal is to make it as easy as possible to build agentic applications. How humans interact with these applications **greatly** affects the type of infrastructure that we need to build.

我们的目标是让构建智能体（agentic）应用变得尽可能简单。而人类与这类应用的交互方式，**极大地影响着**我们必须构建的底层基础设施类型。

For example - we recently launched [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/), our infrastructure for deploying agentic applications at scale. It features multiple streaming modes, support for [“double-texting”](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#double-texting) use cases, and [async background runs](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#stateless-runs). All of these were directly influenced by UI/UX trends that we saw emerging.

例如——我们近期推出了 [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/)，这是专为大规模部署智能体应用而设计的基础设施。它支持多种流式传输模式、[“双重发送”（double-texting）](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#double-texting) 等典型用例，以及 [异步后台运行（async background runs）](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#stateless-runs)。所有这些功能，都直接受到我们观察到的新兴 UI/UX 趋势所驱动。

If you are building an application with a novel or interesting UI/UX (e.g. non-streaming chat) we would _love_ to hear from you at [hello@langchain.dev](mailto:hello@langchain.dev)!

如果你正在开发一款具有新颖或独特 UI/UX 的应用（例如非流式聊天界面），我们**非常期待**收到你的反馈！欢迎随时发送邮件至 [hello@langchain.dev](mailto:hello@langchain.dev)！

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_004.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![论 Agent 框架与 Agent 可观测性](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_004.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**论 Agent 框架与 Agent 可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_005.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪数据到深度洞察：规模化理解 Agent 行为](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_005.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪数据到深度洞察：规模化理解 Agent 行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_006.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_006.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码记录应用行为；在 AI 中，追踪数据（traces）承担这一角色。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_007.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![Agent 框架、运行时与封装器——天哪！](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_007.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent 框架、运行时与封装器——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_008.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_008.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_009.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/ux-for-agents-part-3-spreadsheet-generative-and-collaborative-ui_ux/img_009.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读