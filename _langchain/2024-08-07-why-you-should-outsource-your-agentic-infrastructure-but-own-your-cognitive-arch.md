---
title: "Why you should outsource your agentic infrastructure, but own your cognitive architecture"
source: "LangChain Blog"
url: "https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/"
date: "2024-08-07"
scraped_at: "2026-03-03T07:56:26.332706258+00:00"
language: "en-zh"
translated: true
description: "In this third installment in our \"In The Loop\" series, learn why you should tailor your cognitive architecture to be application-specific, alongside running better infrastructure for your agentic apps..."
tags: ["Harrison Chase", "Harrison's Hot Takes"]
---
{% raw %}

When OpenAI Assistants API came out, it was a bold step towards the future of agents. It moved OpenAI from a company producing LLM APIs to a company producing Agent APIs.

当 OpenAI Assistants API 发布时，这是一次迈向智能体（agent）未来的大胆迈进。它标志着 OpenAI 从一家提供大语言模型（LLM）API 的公司，转型为一家提供智能体（Agent）API 的公司。

There are several things that I think the OpenAI Assistants API got right - it introduced a lot of new and helpful infrastructure specifically aimed at running agentic applications. At the same time, it limits what “ [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/)” can be built on top of it for really complex (and valuable!) agents.

我认为 OpenAI Assistants API 在多个方面做得非常出色——它引入了大量新颖且实用的基础设施，专为运行智能体应用而设计。但与此同时，它也限制了在该平台之上构建真正复杂（且极具价值！）智能体所依赖的“[认知架构](https://blog.langchain.com/what-is-a-cognitive-architecture/)”的可能性。

This shows off the difference between “agentic infrastructure” and “ [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/)”. Jeff Bezos has the brilliant quote: “ [Focus on what makes your beer taste better](https://www.acquired.fm/episodes/amazon-com?ref=blog.langchain.com)”. If we take this metaphor and apply it to companies building agents:

这凸显了“智能体基础设施（agentic infrastructure）”与“[认知架构](https://blog.langchain.com/what-is-a-cognitive-architecture/)”之间的本质区别。杰夫·贝索斯曾有一句精辟名言：“[聚焦于让你的啤酒口感更佳的因素](https://www.acquired.fm/episodes/amazon-com?ref=blog.langchain.com)”。若将这一隐喻迁移到构建智能体的公司身上：

💡  
Agentic infrastructure does not make your beer taste better  

💡  
Cognitive architectures absolutely make your beer taste better  

💡  
智能体基础设施并不会让你的啤酒口感更佳  

💡  
认知架构则绝对会让你的啤酒口感更佳  

## The need for agentic infrastructure  

## 智能体基础设施的必要性  

OpenAI was pretty spot on in that developers want better infrastructure for running agentic applications. In particular:  

OpenAI 对开发者需求的判断相当精准：他们确实需要更完善的基础设施来运行智能体应用。具体而言：  

- The ability to “configure” assistants with a prompt and tools made it easy to get started and create different agents  
- 通过提示词（prompt）和工具对助手进行“配置”的能力，大幅降低了入门门槛，并便于快速创建各类智能体；  

- The ability to run assistants as background runs made it easier to manage longer running workflows  
- 将助手作为后台任务运行的能力，简化了长周期工作流的管理；  

- The built-in persistence of messages made it easy to manage state  
- 内置的消息持久化机制，让状态管理变得轻而易举。

All of these things are things that developers shouldn’t really have to think about. None of these things make your application differentiated - in Jeff Bezos’s words, they don’t make your beer taste better.

所有这些事情，本不该是开发者真正需要操心的。其中没有任何一项能让您的应用脱颖而出——用杰夫·贝索斯（Jeff Bezos）的话来说，它们并不能让您的“啤酒尝起来更美味”。

There is still even more infrastructure that can be built to assist developers! In OpenAI Assistants AI, you currently can’t run multiple runs on the same thread. You can’t easily modify the state of a thread. Still - the Assistants API was a fantastic step in the right direction.

仍有大量基础设施有待构建，以进一步赋能开发者！在 OpenAI Assistants AI 中，您目前无法在同一 thread 上并发执行多个 runs；也无法轻松修改 thread 的状态。尽管如此，Assistants API 仍是迈向正确方向的一次极佳尝试。

## The importance of an application-specific cognitive architecture

## 应用专属认知架构的重要性

The issue with the Assistants API is that it is too limiting in what you can easily build on top of it.

Assistants API 的问题在于：它对上层可构建内容的限制过于严格。

If you are looking to build a chatbot - fantastic! The “state” of a thread is a list of messages, perfect for that.

如果您想构建一个聊天机器人——太棒了！thread 的“状态”就是一条消息列表，这正适合该场景。

If you are looking to build a simple ReAct style agent - great! It also probably works well for that - basically just running an LLM in a `while` loop.

如果您想构建一个简单的 ReAct 风格智能体——很好！它很可能也适用于该场景——本质上只是在一个 `while` 循环中反复调用大语言模型（LLM）。

But agentic applications are more than just a single chat model invoking the same tools with the same prompt over and over again. They have more complex state that they track than just a list of messages. This control over the state and flow of an application is _crucial_ for bringing any semblance of reliability to agents.

但智能体类（agentic）应用远不止是一个聊天模型反复使用相同提示词、调用相同工具那么简单。它们所维护的状态比单纯的消息列表要复杂得多。对应用状态与执行流程的精细掌控，对于赋予智能体任何程度的可靠性而言，都是**至关重要的**。

From working with thousands of builders, we see that the agents making their way to production all have slightly different cognitive architectures. The cognitive architecture of an application is how you get it **to really work well** \- this is where teams are innovating. This is what they are building to make their application differentiated - to make their beer taste better.

通过与数千名开发者的协作，我们发现：那些成功走向生产的智能体，其认知架构均略有不同。所谓应用的认知架构，正是决定它能否**真正高效运转**的关键所在——这也是各团队开展创新的核心阵地。他们正着力构建这种专属架构，以实现应用的差异化——让他们的“啤酒”真正尝起来更美味。

This isn’t to say you _can’t_ do more complex things with the Assistants API. You probably can. But the API doesn’t make it easy. It doesn’t want you to. OpenAI made a bet on a generic cognitive architecture, which in turn makes it hard to build the application-specific cognitive architectures that are needed to make agents reliable.

这并不是说您**无法**借助 Assistants API 实现更复杂的功能——您大概率可以做到。但该 API 并未为此提供便利，甚至可以说，它并不鼓励您这么做。OpenAI 押注于一种通用型认知架构，而这恰恰使得构建面向具体应用场景、保障智能体可靠运行所需的专属认知架构变得异常困难。

## Why do we care?

## 我们为何关注这一点？

Why do I care so much? Why am I writing so many words on this? It’s because I actually think OpenAI got a lot of things right, and they took a stance early in the market that there is a need for agentic infrastructure. They made it easy for developers not to worry about where to store the state of their agents, how to manage a task queue, etc — which is fantastic.

我为何如此在意？为何要为此写下如此多的文字？原因在于，我确实认为 OpenAI 在许多方面做对了——他们早在市场初期就明确表态：业界亟需“智能体基础设施”（agentic infrastructure）。他们让开发者无需再操心智能体的状态该存于何处、任务队列该如何管理等问题——这实在令人赞叹。

Our goal at LangChain is to make it as easy as possible to build agentic applications. This type of infrastructure is absolutely part of what is needed.

LangChain 的使命，就是让构建智能体应用变得尽可能简单。而此类基础设施，恰恰是当下不可或缺的一环。

We want to bring the benefits of that agentic infrastructure and marry it with the control that LangGraph gives you over your cognitive architecture. That’s why we built LangGraph Cloud. Write your custom cognitive architecture with [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com), then deploy it with [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/) and get all the benefits of this agentic infrastructure.

我们希望将智能体基础设施的优势，与 LangGraph 所赋予你的认知架构（cognitive architecture）控制权深度融合——这正是 LangGraph Cloud 诞生的缘由。请使用 [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) 编写你专属的认知架构，再通过 [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/) 进行部署，即可全面享有该智能体基础设施带来的所有优势。

LangGraph Cloud provides fault-tolerant scalability, optimized for real-world interactions. We designed it to have horizontally-scaling task queues and servers, a built-in persistence layer optimized for heavy loads, and configurable caching of nodes across runs. This lets you own the differentiating parts of your application and outsource the rest.

LangGraph Cloud 提供容错性强、可弹性伸缩的架构，专为真实世界中的交互场景优化。我们为其设计了支持水平扩展的任务队列与服务器、针对高负载场景深度优化的内置持久化层，以及跨多次运行可配置的节点缓存机制。由此，你只需专注掌控应用中真正体现差异化的核心部分，其余通用能力则可放心交由平台托管。

In conclusion, focus on what makes your beer taste better: cognitive architectures, not infrastructure.

总而言之，请专注于让你的“啤酒”更醇香的关键所在：即认知架构本身，而非底层基础设施。

### Tags

### 标签

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[![关于智能体框架与智能体可观测性](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪记录到深度洞察：规模化理解智能体行为](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪记录到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![In software, the code documents the app. In AI, the traces do.](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪记录即文档。](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码即文档；在人工智能中，追踪记录即文档。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排层——天哪！](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排层——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不。](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不。**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
{% endraw %}
