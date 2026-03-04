---
title: "LangGraph 0.3 Release: Prebuilt Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-0-3-release-prebuilt-agents/"
date: "2025-03-15"
scraped_at: "2026-03-03T07:37:35.229838324+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

By Nuno Campos and Vadym Barda

作者：Nuno Campos 与 Vadym Barda

Over the past year, we’ve invested heavily in making [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) the go-to framework for building AI agents. With companies like [Replit](https://blog.langchain.com/customers-replit/), [Klarna](https://blog.langchain.com/customers-klarna/), [LinkedIn](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.dev) and [Uber](https://dpe.org/sessions/ty-smith-adam-huda/this-year-in-ubers-ai-driven-developer-productivity-revolution/?ref=blog.langchain.dev) choosing to build on top of LangGraph, we have more conviction than ever that we are on the right path.

过去一年中，我们大力投入，致力于将 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 打造成构建 AI 智能体（AI agents）的首选框架。随着 [Replit](https://blog.langchain.com/customers-replit/)、[Klarna](https://blog.langchain.com/customers-klarna/)、[LinkedIn](https://www.linkedin.com/blog/engineering/ai/practical-text-to-sql-for-data-analytics?ref=blog.langchain.dev) 和 [Uber](https://dpe.org/sessions/ty-smith-adam-huda/this-year-in-ubers-ai-driven-developer-productivity-revolution/?ref=blog.langchain.dev) 等公司选择基于 LangGraph 构建其系统，我们比以往任何时候都更加确信——我们正走在正确的道路上。

A core principle of LangGraph is to be as low level as possible. There are no hidden prompts or no enforced “ [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/)” in LangGraph. This has served to make it production ready and also distinguishes itself from all other frameworks.

LangGraph 的核心设计原则之一是尽可能保持底层抽象。LangGraph 中既不存在隐藏的提示词（hidden prompts），也不强制采用任何特定的“[认知架构（cognitive architectures）](https://blog.langchain.com/what-is-a-cognitive-architecture/)”。这一设计理念使其具备了生产就绪（production-ready）能力，也使其显著区别于所有其他框架。

At the same time, we **do** see the value in higher level abstractions. They make it easy to get started, easy to try out new cognitive architectures, and provide a nice entrypoint to the field.

与此同时，我们**确实**认可更高层级抽象的价值：它们降低了入门门槛，便于快速尝试新型认知架构，并为初入该领域的开发者提供了友好的切入点。

Up to this point, we’ve had one higher level abstraction and it’s lived in the main `langgraph` package. It was [`create_react_agent`](https://langchain-ai.github.io/langgraph/how-tos/?ref=blog.langchain.com#prebuilt-react-agent), a wrapper for creating a simple tool calling agent. Today, we are splitting that out of `langgraph` as part of a 0.3 release, and moving it into `langgraph-prebuilt`.

截至目前，我们仅提供一个高层级抽象，它一直内置于主 `langgraph` 包中——即 [`create_react_agent`](https://langchain-ai.github.io/langgraph/how-tos/?ref=blog.langchain.com#prebuilt-react-agent)，一个用于创建简单工具调用智能体（tool-calling agent）的封装函数。今天，作为 0.3 版本发布的一部分，我们将该功能从 `langgraph` 中拆分出来，并迁移至新独立包 `langgraph-prebuilt`。

We are also introducing a new set of [prebuilt agents](https://langchain-ai.github.io/langgraph/prebuilt/?ref=blog.langchain.com) built on top of LangGraph, in both Python and JavaScript.

此外，我们还推出了一套全新的 [预构建智能体（prebuilt agents）](https://langchain-ai.github.io/langgraph/prebuilt/?ref=blog.langchain.com)，全部基于 LangGraph 构建，同时支持 Python 和 JavaScript 两种语言。

Over the past three weeks, we’ve already released a few of these:

过去三周内，我们已陆续发布了其中若干组件：

- [Trustcall](https://github.com/hinthornw/trustcall?ref=blog.langchain.com): for doing reliable structured extraction  
- [Trustcall](https://github.com/hinthornw/trustcall?ref=blog.langchain.com)：用于实现可靠的结构化信息抽取  

- [LangGraph Supervisor](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com): for getting started with a supervisor multi-agent architecture  
- [LangGraph Supervisor](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com)：用于快速上手监督式多智能体（supervisor multi-agent）架构  

- [LangMem](https://github.com/langchain-ai/langmem?ref=blog.langchain.com): for long term memory  
- [LangMem](https://github.com/langchain-ai/langmem?ref=blog.langchain.com)：用于长期记忆（long-term memory）  

- [LangGraph Swarm](https://github.com/langchain-ai/langgraph-swarm-py?ref=blog.langchain.com): for getting started with a swarm multi-agent architecture  
- [LangGraph Swarm](https://github.com/langchain-ai/langgraph-swarm-py?ref=blog.langchain.com)：用于快速上手群体式多智能体（swarm multi-agent）架构  

We believe that these prebuilt libraries can combine the best of both worlds:

我们相信，这些预构建库能够融合两大优势：

- They make it easy to get started with common agent patterns  
- 它们让常见智能体模式的快速上手变得轻而易举  

- They are built on top of LangGraph, so if you want to modify them it’s easy and familiar  
- 它们均构建于 LangGraph 之上，因此如需定制修改，操作便捷且开发体验熟悉

We hope that this will foster a large collection of prebuilt agents built by the community.

我们希望此举能促进社区构建大量预置智能体（prebuilt agents）。

To that end, we have added [instructions](https://langchain-ai.github.io/langgraph/prebuilt/?ref=blog.langchain.com#contributing-your-library) for creating your own prebuilt package and adding it to our registry of agents.

为此，我们已添加了[创建您自己的预置软件包并将其加入我们的智能体注册中心](https://langchain-ai.github.io/langgraph/prebuilt/?ref=blog.langchain.com#contributing-your-library)的相关说明。

We have seen this work well with LangChain integrations. We have over 700 integrations, a large number maintained by the community in third party packages.

这一模式在 LangChain 的集成生态中已被证实行之有效：目前我们已有 700 多个集成组件，其中大量由社区在第三方软件包中维护。

We hope the same will happen with LangGraph prebuilt agents.

我们也期待 LangGraph 的预置智能体生态能迎来同样的蓬勃发展。
&#123;% endraw %}
