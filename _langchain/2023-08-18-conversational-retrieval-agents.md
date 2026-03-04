---
title: "Conversational Retrieval Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/conversational-retrieval-agents/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:09:16.900953379+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

**TL;DR: There have been several emerging trends in LLM applications over the past few months: RAG, chat interfaces, agents. Our newest functionality - conversational retrieval agents - combines them all. This isn't just a case of combining a lot of buzzwords - it provides real benefits and superior user experience.**

**简明摘要：过去几个月，大语言模型（LLM）应用领域涌现出若干重要趋势：检索增强生成（RAG）、聊天界面（chat interfaces）、智能体（agents）。我们最新推出的“对话式检索智能体”（conversational retrieval agents）正是这三者的有机融合。这绝非简单堆砌流行术语，而是切实带来显著优势与更优用户体验。**

**Key Links:**

**关键链接：**

- **[Python Documentation](https://python.langchain.com/docs/use_cases/question_answering/how_to/conversational_retrieval_agents?ref=blog.langchain.com)**  
- **[Python 文档](https://python.langchain.com/docs/use_cases/question_answering/how_to/conversational_retrieval_agents?ref=blog.langchain.com)**

- **[JavaScript Documentation](https://js.langchain.com/docs/use_cases/question_answering/conversational_retrieval_agents?ref=blog.langchain.com)**  
- **[JavaScript 文档](https://js.langchain.com/docs/use_cases/question_answering/conversational_retrieval_agents?ref=blog.langchain.com)**

- **[End-to-end example](https://github.com/hwchase17/conversational-retrieval-agent?ref=blog.langchain.com)**  
- **[端到端示例](https://github.com/hwchase17/conversational-retrieval-agent?ref=blog.langchain.com)**

As LLM applications are starting to make their way into more and more production use cases, a few common trends are starting emerge:

随着大语言模型（LLM）应用逐步落地于越来越多的实际生产场景，若干共性趋势正日益显现：

**Retrieval Augmented Generation**

**检索增强生成（Retrieval Augmented Generation, RAG）**

LLMs only know what they are trained on. To combat this, a style of generation known as "retrieval augmented generation" has emerged. In this technique, documents are retrieved and then inserted into the prompt, and the language model is instructed to only respond based on those documents. This helps both in giving the language model additional context as well as in keeping it grounded.

大语言模型仅知晓其训练数据所涵盖的内容。为应对这一局限，“检索增强生成”（Retrieval Augmented Generation, RAG）应运而生。该技术先从外部知识库中检索相关文档，并将这些文档内容注入提示词（prompt），再指示语言模型仅依据所检索出的文档作答。此举既为模型提供了额外上下文信息，也有效增强了其回答的事实准确性与可靠性（即“grounding”）。

**Chat Interfaces**

**聊天界面（Chat Interfaces）**

With the explosion of ChatGPT, chat interfaces have emerged as the dominant way with which to interact with language models. The ability to ask follow up questions about a previous response - especially as context windows grow longer and longer - proves invaluable.

随着 ChatGPT 的爆发式普及，聊天界面已成为人机交互语言模型的主流方式。用户可基于前一轮回复自然提出后续追问——尤其在上下文窗口（context window）持续扩大的今天，这一能力愈发不可或缺。

**Agents**

**智能体（Agents）**

The term agents may be overloaded by now. By "agents" we mean a system where the sequence of steps is NOT known ahead of time, but is rather determined by a language model. This can allow the system greater flexibility in dealing with edge cases. However, if unbounded it can become quite unreliable.

“智能体”（agents）一词如今可能已被过度泛化。此处我们所指的“智能体”，特指一类运行流程**并非预先固定**、而是由语言模型**动态决策**的系统。这种机制赋予系统更强的灵活性，使其能更稳健地应对各类边界情况（edge cases）。但若缺乏合理约束，其行为也可能变得高度不可靠。

* * *

At LangChain, we have had components for these trends from the very beginning.  
在 LangChain，我们从最初就已具备支持这些趋势的组件。

One of our first applications built was a `RetrievalQA` system over a Notion database.  
我们最早构建的应用之一，便是一个基于 Notion 数据库的 `RetrievalQA` 系统。

We've experimented and pushed the boundary with many different forms of memory, enabling chatbots of all kinds.  
我们已通过多种不同形式的记忆机制展开实验并不断突破边界，从而赋能各类聊天机器人。

And - of course - we've got many types of agents, from the "old" ones that use ReAct style prompting, to newer ones powered by OpenAI Functions.  
当然，我们也提供了多种类型的智能体（agents）：既有采用 ReAct 风格提示词的“传统”智能体，也有由 OpenAI Functions 驱动的新型智能体。

We've also combined these ideas before. `ConversationalRetrievalQA` \- a chatbot that does a retrieval step to start - is one of our most popular chains.  
我们此前也已将这些理念进行过融合。`ConversationalRetrievalQA`——一种启动时即执行检索步骤的聊天机器人——便是我们最受欢迎的链（chain）之一。

From almost the beginning we've added support for memory in agents.  
自项目早期起，我们便已在智能体中加入了对记忆功能的支持。

Yet we've never really put all three of these concepts together. Until now. With our conversational retrieval agents we capture all three aspects.  
然而，我们此前从未真正将这三大概念整合到一个统一框架中——直到现在。借助我们的**对话式检索智能体（conversational retrieval agents）**，我们首次完整地融合了全部三项核心能力。

Let's dive into what exactly this consists of, and why this is the superior retrieval system.  
接下来，让我们深入探讨这一系统究竟包含哪些要素，以及为何它代表了更优越的检索方案。

* * *

The basic outline of this system involves:  
该系统的基本架构包括：

- An OpenAI Functions agent  
  ——一个基于 OpenAI Functions 的智能体

- Tools that are themselves `retrievers` \- they take in a string, and return a list of documents  
  ——若干本身即为 `retriever`（检索器）的工具：它们接收一个字符串输入，并返回一组文档列表

- A new type of memory that not only remembers `human <-> ai` interactions, but also `ai <-> tool` interactions  
  ——一种新型记忆机制：不仅记录 `人类 ↔ AI` 的交互历史，还同步记录 `AI ↔ 工具` 的调用过程

The agent can then decide when to call the retrieval system if at all.  
智能体可自主决定是否、以及何时调用检索系统。

If it does, the retrieved documents are returned and it can use them to reason about what to do next, whether it be respond directly or do a different retrieval step.  
一旦触发检索，系统将返回相关文档；智能体即可据此推理下一步行动——无论是直接生成回复，还是发起另一次检索。

Note that this relies upon a few things:  
需要注意的是，该机制的成功运行依赖于以下几项前提条件：

- Longer context windows: if context windows are short, then you can't just return all the documents into the agent's working memory  
  ——更长的上下文窗口：若上下文窗口过短，则无法将全部检索文档直接载入智能体的工作内存中

- Better language models: if language models aren't good enough to reason about when they should retrieve documents, then this won't work  
  ——更强大的语言模型：若语言模型尚不足以自主判断何时应发起文档检索，则此机制将无法有效运作

Luckily, language models are getting better and getting longer context windows!  
幸运的是，语言模型正持续进化——能力日益增强，上下文窗口也不断扩展！

Here's a LangSmith trace showing how it looks in action:

以下是 LangSmith 的一个追踪示例，展示其实际运行效果：

[https://smith.langchain.com/public/1e2b1887-ca44-4210-913b-a69c1b8a8e7e/r](https://smith.langchain.com/public/1e2b1887-ca44-4210-913b-a69c1b8a8e7e/r?ref=blog.langchain.com)

![](https://blog.langchain.com/content/images/2023/08/screenshot-2023-08-02-at-10.29.17-pm.png)

Let's compare this to the `ConversationalRetrievalQA` chain that most people use. The benefits that a conversational retrieval agent has are:

我们来将它与大多数人使用的 `ConversationalRetrievalQA` 链进行对比。对话式检索智能体（conversational retrieval agent）具备以下优势：

1. Doesn't always look up documents in the retrieval system. Sometimes, this isn't needed! If the user is just saying "hi", you shouldn't have to look things up  
   并非每次都需要在检索系统中查找文档——有时这完全没必要！例如，当用户只是说“你好”时，就不应触发任何检索操作。

2. Can do multiple retrieval steps. In `ConversationalRetrievalQA`, one retrieval step is done ahead of time. If that retrieval step returns bad results, then you're out of luck! But with an agent you can try a different search query to see if that yields better results  
   支持执行多次检索步骤。在 `ConversationalRetrievalQA` 中，仅预先执行一次检索；若该次检索返回了低质量结果，便无法补救。而使用智能体时，则可尝试更换搜索查询，以期获得更优结果。

3. With this new type of memory, you can maybe avoid retrieval steps! This is because it remembers `ai <-> tool` interactions, and therefore remembers previous retrieval results. If a follow-up question the user asks can be answered by those, there's no need to do another retrieval step!  
   借助这种新型记忆机制，你甚至可能完全跳过检索步骤！原因在于它会记录 `AI ↔ 工具` 的交互过程，从而记住此前的检索结果；若用户后续提出的问题恰好能由这些已有结果回答，则无需再次执行检索。

4. Better support for meta-questions about the conversation - "how many questions have I asked?", etc. Because the old chain dereferences questions to be "standalone" and independent of the conversation history in order to query the vector store effectively, it struggles with this type of question.  
   对关于对话本身的元问题（meta-questions）支持更佳——例如：“我一共问了多少个问题？”等。由于旧链为高效查询向量数据库，会将用户问题改写为脱离上下文的独立问题（即“去上下文化”处理），因此难以应对这类依赖对话历史的问题。

Note, that there are some downsides/dangers:

需要注意的是，该方案也存在一些劣势或潜在风险：

1. With agents, they can occasionally spiral out of control. That's why we've added controls to our AgentExecutor to cap them at a certain max amount of steps. It's also worth noting that this is a VERY focused agent, in that it's only given one tool (and a pretty simple tool at that). In general, the fewer (and simpler) tools an agent is given, the more likely it is to be reliable.  
   智能体偶尔可能失控发散。正因如此，我们在 `AgentExecutor` 中加入了控制机制，限制其最大执行步数。此外还需指出：这是一个高度聚焦的智能体——它仅被赋予单一工具（而且该工具本身相当简单）。总体而言，赋予智能体的工具越少、越简单，其行为就越可靠。

2. By remembering `ai <-> tool` interactions, that can hog the context window occasionally. That's why we've included a flag to disable that type of memory, and more generally have made memory pretty plug-and-play.  
   由于需记录 `AI ↔ 工具` 的交互内容，该机制偶尔会占用大量上下文窗口空间。为此，我们提供了禁用此类记忆的开关选项；更广泛地讲，我们已将记忆模块设计为高度可插拔（plug-and-play）的架构。

This new agent is in both Python and JS - you can use these guides to get started:

这一新型智能体已同时支持 Python 和 JavaScript —— 你可以参考以下指南快速上手：

- [JS](https://js.langchain.com/docs/use_cases/question_answering/conversational_retrieval_agents?ref=blog.langchain.com)  
- [Python](https://python.langchain.com/docs/use_cases/question_answering/how_to/conversational_retrieval_agents?ref=blog.langchain.com)

* * *

LLM applications are rapidly evolving.  
大语言模型（LLM）应用正在快速演进。

Our NotionQA demo was one of the first we did - and although it was only ~9 months ago the best practices have shifted dramatically since then.  
我们的 NotionQA 演示是最早开展的项目之一——尽管距今仅约 9 个月，但相关最佳实践已发生巨大变化。

This currently represents our best guess at what a GenAI question-answering system should look like, combining the grounded-ness of RAG with the UX of chat and the flexibility of agents.  
目前，这代表了我们对生成式 AI（GenAI）问答系统应有形态的最佳判断：它融合了 RAG（检索增强生成）的“事实依据性”（grounded-ness）、聊天界面（chat UX）的易用性，以及智能体（agents）的灵活性。

We've got a few more ideas on how this can be further improved - we'll be rolling those out over the next few weeks.  
我们还有若干进一步优化的构想——将在未来几周内陆续推出。

As always, we'd love to hear from you with any suggestions or ideas.  
一如既往，我们非常期待听到您的任何建议或想法。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布｜阅读时长 7 分钟](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](https://blog.langchain.com/content/images/size/w760/format/webp/2025/03/Theme-Fractal-Matrix--Format-Blog--Colour-Green--Text-Alignment-Centred--With-Image-Text-Only.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](https://blog.langchain.com/content/images/size/w760/format/webp/2025/03/Theme-Fractal-Matrix--Format-Blog--Colour-Green--Text-Alignment-Centred--With-Image-Text-Only.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](https://blog.langchain.com/content/images/size/w760/format/webp/2024/12/State-of-AI-2024-header.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](https://blog.langchain.com/content/images/size/w760/format/webp/2024/12/Youtube-and-Blog-Self-Serve-Components--2-.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](https://blog.langchain.com/content/images/size/w760/format/webp/2024/12/Youtube-and-Blog-Self-Serve-Components--1-.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](https://blog.langchain.com/content/images/size/w760/format/webp/2024/10/editing---langgraph-platform--3-.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
&#123;% endraw %}
