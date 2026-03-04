---
title: "[Week of 7/8] LangChain Release Notes"
source: "LangChain Blog"
url: "https://blog.langchain.com/week-of-7-8-langchain-release-notes/"
date: "2024-07-19"
scraped_at: "2026-03-03T07:58:28.961413967+00:00"
language: "en-zh"
translated: true
description: "See new use cases for building & deploying with LangGraph Cloud, revamped LangGraph docs, and more on self-improving evaluators in LangSmith. Plus, hear the latest agents trends — and learn more abo..."
---
{% raw %}

We’re highlighting the most exciting ways to use different parts of the LangChain ecosystem – from the gamut of apps being built in LangGraph Cloud, to customer stories on how to test LLM apps reliably. Plus, stay ahead of the latest agentic trends and gear up for our upcoming hackathon.

我们重点介绍 LangChain 生态系统各组成部分最激动人心的用法——从 LangGraph Cloud 上层出不穷的应用构建实践，到客户分享的如何可靠地测试大语言模型（LLM）应用的真实案例；同时，助您率先把握最新智能体（agentic）技术趋势，并为即将举办的黑客松（hackathon）做好充分准备。

* * *

# Product Updates

# 产品更新

_Highlighting the latest product updates and news for LangChain, LangSmith, and LangGraph_

_聚焦 LangChain、LangSmith 和 LangGraph 的最新产品动态与重要资讯_

## 🔁 LangSmith: Self-improving evaluators

## 🔁 LangSmith：自优化评估器

Humans can now easily correct “LLM-as-Judge” evaluators in LangSmith and pass those back to the evaluator as few-shot examples to create a self-improving feedback loop. See [this video](https://www.youtube.com/watch?v=fmL6cB5Q5M0&ref=blog.langchain.com) to add self-improving evaluators to any LangSmith dataset.

现在，用户可在 LangSmith 中轻松修正“LLM 作为裁判（LLM-as-Judge）”类评估器的判断结果，并将这些人工修正样本以少样本（few-shot）示例形式反馈给评估器，从而构建起一个持续自我优化的反馈闭环。请观看[本视频](https://www.youtube.com/watch?v=fmL6cB5Q5M0&ref=blog.langchain.com)，了解如何为任意 LangSmith 数据集添加自优化评估器。

## ☁️ LangGraph Cloud: Use Cases

## ☁️ LangGraph Cloud：典型应用场景

Our latest infrastructure for running agents at scale, LangGraph Cloud, can be used for many different LLM apps.

我们最新推出的、面向大规模智能体部署的基础设施——LangGraph Cloud，可广泛应用于各类大语言模型（LLM）应用。

- See how to build a full-stack, generative UI app in [this video](https://www.youtube.com/watch?v=EKNiz_fWrDk&feature=youtu.be&ref=blog.langchain.com) that generates charts analyzes queries to filter and visualize data on the fly — then deploy on LangGraph Cloud.

- 请观看[本视频](https://www.youtube.com/watch?v=EKNiz_fWrDk&feature=youtu.be&ref=blog.langchain.com)，了解如何构建一个端到端的生成式 UI 应用：该应用可动态生成图表、解析用户查询、实时筛选并可视化数据，最终一键部署至 LangGraph Cloud。

- Want to build a Discord bot to remember and learn from conversations using LangGraph Cloud? Watch [this video](https://www.youtube.com/watch?v=ORAecR4hXsQ&ref=blog.langchain.com) to see how we did it, from build to deployment to testing its performance.

- 想基于 LangGraph Cloud 构建一个能记忆并从对话中持续学习的 Discord 机器人？请观看[本视频](https://www.youtube.com/watch?v=ORAecR4hXsQ&ref=blog.langchain.com)，了解我们从开发、部署到性能测试的完整实现过程。

- For a self-corrective RAG app that can flexibly handle model hallucinations, LangGraph Cloud also comes in handy. [See an example here](https://www.youtube.com/watch?v=hpIOx2eGQS4&ref=blog.langchain.com).

- 对于需灵活应对模型幻觉（hallucination）的自校正式 RAG（检索增强生成）应用，LangGraph Cloud 同样大显身手。[点击此处查看示例](https://www.youtube.com/watch?v=hpIOx2eGQS4&ref=blog.langchain.com)。

## 📓 LangGraph Documentation

## 📓 LangGraph 文档

We’ve revamped LangGraph documentation to include clear and actionable how-to guides and comprehensive conceptual guides:

我们已全面更新 LangGraph 文档，新增清晰、可直接上手的“操作指南”（how-to guides）以及全面深入的“概念指南”（conceptual guides）：

- [Human-in-the-loop](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/breakpoints/?ref=blog.langchain.com): Learn how to add breakpoints, wait for user approval, and more  
- [人机协同（Human-in-the-loop）](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/breakpoints/?ref=blog.langchain.com)：了解如何设置断点、等待用户审批等操作

- [Streaming](https://langchain-ai.github.io/langgraph/how-tos/stream-values/?ref=blog.langchain.com): See how to stream graph state, LLM tokens and more with LangGraph’s first-class streaming support  
- [流式传输（Streaming）](https://langchain-ai.github.io/langgraph/how-tos/stream-values/?ref=blog.langchain.com)：了解如何利用 LangGraph 原生流式支持，实时流式输出图状态、大语言模型（LLM）token 等内容

- [Controllability](https://langchain-ai.github.io/langgraph/how-tos/subgraph/?ref=blog.langchain.com): Create advanced control flows with subgraphs, branches, and more  
- [可控性（Controllability）](https://langchain-ai.github.io/langgraph/how-tos/subgraph/?ref=blog.langchain.com)：借助子图（subgraphs）、分支（branches）等机制构建高级控制流程

- [Prebuilt ReAct agent](https://langchain-ai.github.io/langgraph/how-tos/create-react-agent/?ref=blog.langchain.com): Quickly build powerful ReAct-style agents in just a few lines of code with LangGraph’s prebuilt implementation  
- [预置 ReAct 智能体（Prebuilt ReAct agent）](https://langchain-ai.github.io/langgraph/how-tos/create-react-agent/?ref=blog.langchain.com)：仅需数行代码，即可借助 LangGraph 提供的预置实现，快速构建功能强大的 ReAct 风格智能体

- [Conceptual guides](https://langchain-ai.github.io/langgraph/concepts/?ref=blog.langchain.com): Learn agentic concepts and LangGraph’s core low-level building blocks  
- [概念指南（Conceptual guides）](https://langchain-ai.github.io/langgraph/concepts/?ref=blog.langchain.com)：系统学习智能体（agentic）相关核心概念，以及 LangGraph 的底层基础构建模块

* * *

# Events & Meetups

# 活动与线下聚会

_Meet up with LangChain enthusiasts, employees, and eager AI app builders at the following IRL events this coming month:_

_欢迎于本月参加以下线下活动，与 LangChain 爱好者、LangChain 团队成员以及热衷构建 AI 应用的开发者面对面交流：_

🌉 **(August 11) Agents Hackathon in San Francisco**

🌉 **（8 月 11 日）旧金山智能体黑客松（Agents Hackathon）**

- Join us for an Agents and Compound AI Hackathon, with talks from leaders at Fireworks, Factory AI, and LangChain. Cash prize & credits are at stake! This is a fully in-person hackathon. [Apply here](https://lu.ma/kwp4mkr3?ref=blog.langchain.com).  
- 加入我们的“智能体与复合 AI 黑客松”，现场将有 Fireworks、Factory AI 及 LangChain 等机构技术负责人的主题分享。丰厚现金奖励与云服务积分等你来赢！本次活动为纯线下形式。[立即报名](https://lu.ma/kwp4mkr3?ref=blog.langchain.com)。

🙈 **ICYMI, Past Events:**

🙈 **小贴士（ICYMI）：近期已举办的活动回顾**

- Thanks to all who’ve turned out for our regional meetups! We’ve met so many LangChain builders & enthusiasts in NYC and Austin TX in the past month — with more events to come!  
- 衷心感谢所有参与我们区域线下聚会的朋友！过去一个月，我们在纽约（NYC）和得克萨斯州奥斯汀（Austin TX）已与众多 LangChain 开发者及爱好者相聚——更多精彩活动正在路上！

- [See the replay](https://www.youtube.com/watch?v=A0jOmaPdKM4&ref=blog.langchain.com) for our live panel discussion on how to deliver on GenAI hype” with Edo Liberty (Pinecone CEO) and Harrison Chase (LangChain CEO)  
- [观看回放](https://www.youtube.com/watch?v=A0jOmaPdKM4&ref=blog.langchain.com)：由 Pinecone 首席执行官 Edo Liberty 与 LangChain 首席执行官 Harrison Chase 共同参与的直播圆桌讨论——《如何兑现生成式 AI（GenAI）热潮背后的承诺》

# Speak the Lang

# 说“Lang”语

_See how our 1M+ developers and builders are using LangChain, LangSmith, and LangGraph in their day-to-day. Thank you for always helping us build better!_

_看看我们超过 100 万的开发者与构建者如何在日常工作中使用 LangChain、LangSmith 和 LangGraph。感谢你们始终如一地帮助我们打造更优秀的产品！_

### 🤖 **Agents, agents everywhere**

### 🤖 **智能体，无处不在**

With our “In the Loop” blog series, hear the latest thoughts and learnings from our CEO Harrison Chase on commonly-asked questions for agentic apps. Check out:

通过我们的博客系列“In the Loop”，聆听 CEO Harrison Chase 就智能体应用（agentic apps）中常见问题所分享的最新见解与经验。欢迎阅读：

- [Pt 1: What is an agent?](https://blog.langchain.com/what-is-an-agent/)
- [第 1 部分：什么是智能体？](https://blog.langchain.com/what-is-an-agent/)

- [Pt 2: What is a cognitive architecture?](https://blog.langchain.com/what-is-a-cognitive-architecture/)
- [第 2 部分：什么是认知架构？](https://blog.langchain.com/what-is-a-cognitive-architecture/)

We’ve also added video tutorials for one of the most requested agent features, human-in-the-loop. See [part 1](https://www.youtube.com/watch?v=Za8CrPqQxpA&ref=blog.langchain.com) on adding breakpoints to LangGraph to stop the agent for human approval at certain steps, then [part 2](https://www.youtube.com/watch?v=YmAaKKlDy7k&ref=blog.langchain.com) on how to wait for human feedback on clarifying questions.

我们还为呼声最高的智能体功能之一——“人在回路中（human-in-the-loop）”新增了视频教程。请观看：[第 1 部分](https://www.youtube.com/watch?v=Za8CrPqQxpA&ref=blog.langchain.com)，介绍如何在 LangGraph 中添加断点，使智能体在特定步骤暂停并等待人工审批；以及[第 2 部分](https://www.youtube.com/watch?v=YmAaKKlDy7k&ref=blog.langchain.com)，讲解如何等待人工就澄清类问题提供反馈。

Want more of a deep-dive into a multi-agent setup? Jockey (from Twelve Labs) is a conversational video agent that uses LangGraph to optimize their token usage and video processing. [Read the blog here](https://blog.langchain.com/jockey-twelvelabs-langgraph/).

想更深入地了解多智能体系统？Jockey（来自 Twelve Labs）是一款对话式视频智能体，它借助 LangGraph 优化其 token 使用效率与视频处理流程。[点击此处阅读相关博客](https://blog.langchain.com/jockey-twelvelabs-langgraph/)。

![](images/week-of-7_8-langchain-release-notes/img_001.png)Jockey's flow of information between nodes in LangGraph

![](images/week-of-7_8-langchain-release-notes/img_001.png)Jockey 在 LangGraph 中各节点间的信息流转图

### 🛠️ **Testing & evaluating LLM applications**

### 🛠️ **大语言模型（LLM）应用的测试与评估**

As an AI assistant for in-house legal teams, Wordsmith adopted LangSmith for their full product lifecycle — from shaving debugging time to seconds, to establishing baselines for testing their RAG app, then releasing to production in the same day. [Read their story here.](https://blog.langchain.com/customers-wordsmith/)

作为企业内部法律团队的 AI 助手，Wordsmith 在其完整产品生命周期中全面采用 LangSmith——从将调试时间缩短至数秒，到为 RAG 应用建立测试基线，再到当天即完成上线发布。[点击此处阅读他们的故事](https://blog.langchain.com/customers-wordsmith/)。

When it come to agents, however, building and testing is a tall task. We recently [gave a workshop](https://youtu.be/XiySC-d346E?ref=blog.langchain.com) on how to build and test reliable agents with LangGraph and LangSmith, from implementation to evaluation.

然而，谈及智能体（agents）时，构建与测试便是一项极具挑战性的任务。我们近期举办了一场[工作坊](https://youtu.be/XiySC-d346E?ref=blog.langchain.com)，详细讲解如何借助 LangGraph 和 LangSmith 从实现到评估，系统性地构建并测试高可靠性的智能体。

Unlike standard RAG, agentic memory systems dynamically create documents to be retrieved later. New Computer (creators of Dot, the personal AI assistant) used LangSmith to quickly iterate and evaluate their app on precision, recall, and F1 — resulting in **50% higher recall and 40% higher precision.** They also leveraged regression testing to optimize conversation prompts. Read [the full story here](https://blog.langchain.com/customers-new-computer/).

与标准的 RAG（检索增强生成）不同，智能体记忆系统（agentic memory systems）会动态生成文档，供后续检索使用。New Computer 公司（个人 AI 助手 Dot 的开发者）利用 LangSmith 快速迭代并评估其应用在准确率（precision）、召回率（recall）和 F1 分数上的表现——最终实现了**召回率提升 50%，准确率提升 40%**。他们还借助回归测试（regression testing）持续优化对话提示词（conversation prompts）。点击此处阅读[完整案例故事](https://blog.langchain.com/customers-new-computer/)。

### ✨ **Notable community projects**

### ✨ **值得关注的社区项目**

Here’s some exciting projects and papers from community members, code and implementation included:

以下是一些来自社区成员的精彩项目与论文，均附有源代码与具体实现：

- [Resumé chatbot with LangChain.js + Next.js + Gemini for personal websites](https://medium.com/@aaronphilip2003/r%C3%A9sum%C3%A9-chatbot-abccc89de23b?ref=blog.langchain.com) by Aaron Philip (Member of Technical Staff @ DevRev)  
  - [面向个人网站的简历聊天机器人：基于 LangChain.js + Next.js + Gemini](https://medium.com/@aaronphilip2003/r%C3%A9sum%C3%A9-chatbot-abccc89de23b?ref=blog.langchain.com)，作者：Aaron Philip（DevRev 公司技术专家）

- [From Local to Global: GraphRAG with Neo4j and Langchain](https://medium.com/neo4j/implementing-from-local-to-global-graphrag-with-neo4j-and-langchain-constructing-the-graph-73924cc5bab4?ref=blog.langchain.com) by Tomaz Bratanic (Researcher @ Neo4j)  
  - [从局部到全局：基于 Neo4j 与 LangChain 的 GraphRAG 实现](https://medium.com/neo4j/implementing-from-local-to-global-graphrag-with-neo4j-and-langchain-constructing-the-graph-73924cc5bab4?ref=blog.langchain.com)，作者：Tomaz Bratanic（Neo4j 研究员）

- [Tutorials to learn RAG with LangChain](https://www.sakunaharinda.xyz/ragatouille-book/intro.html?ref=blog.langchain.com) by Sakuna Harinda (SWE @ [H2O.ai](http://h2o.ai/?ref=blog.langchain.com))  
  - [使用 LangChain 学习 RAG 的教程合集](https://www.sakunaharinda.xyz/ragatouille-book/intro.html?ref=blog.langchain.com)，作者：Sakuna Harinda（[H2O.ai](http://h2o.ai/?ref=blog.langchain.com) 软件工程师）

- [LangGraph Adaptive RAG with Milvus and local Llama 3 with Ollama](https://www.youtube.com/watch?v=zULKPrekNhQ&ref=blog.langchain.com) by Stephen Batifol (Dev Advocate @ Zilliz)  
  - [基于 LangGraph 的自适应 RAG：集成 Milvus 与本地运行的 Llama 3（通过 Ollama）](https://www.youtube.com/watch?v=zULKPrekNhQ&ref=blog.langchain.com)，作者：Stephen Batifol（Zilliz 开发者布道师）

* * *

**How can you follow along with the Lang Latest? Check out the** [**LangChain blog**](https://blog.langchain.com/) **and** [**YouTube channel**](https://www.youtube.com/@LangChain?ref=blog.langchain.com) **for even more product and content updates. For any additional questions, email us at support@langchain.dev.**

**如何及时获取 LangChain 最新动态？欢迎访问** [**LangChain 官方博客**](https://blog.langchain.com/) **以及** [**YouTube 频道**](https://www.youtube.com/@LangChain?ref=blog.langchain.com) **，获取更多产品更新与技术内容。如有其他问题，欢迎致信 support@langchain.dev 咨询。**
{% endraw %}
