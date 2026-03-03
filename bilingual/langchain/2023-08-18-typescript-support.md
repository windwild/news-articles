---
title: "TypeScript Support"
source: "LangChain Blog"
url: "https://blog.langchain.com/typescript-support/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:55:56.801169819+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

It's finally here... TypeScript support for LangChain.

终于来了……LangChain 的 TypeScript 支持。

What does this mean? It means that all your favorite prompts, chains, and agents are all recreatable in TypeScript natively. Both the Python version and TypeScript version utilize the same serializable format, meaning that artifacts can seamlessly be shared between languages. As an example of using this, we've also recreated ChatLangChain with TypeScript.

这意味着什么？这意味着你最喜爱的所有 Prompt、Chain 和 Agent 都能原生地在 TypeScript 中重建。Python 版本与 TypeScript 版本采用完全相同的可序列化格式，因此各类产物（artifacts）可在不同语言间无缝共享。作为这一能力的示例，我们还使用 TypeScript 重构了 ChatLangChain。

A huge thank you to the community for helping with this.

衷心感谢社区为此付出的努力与支持！

Important Links:

重要链接：

- GitHub Repo: [https://github.com/hwchase17/langchainjs](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com)
- GitHub 仓库：[https://github.com/hwchase17/langchainjs](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com)
- Documentation: [https://hwchase17.github.io/langchainjs/docs/overview/](https://hwchase17.github.io/langchainjs/docs/overview/?ref=blog.langchain.com)
- 文档：[https://hwchase17.github.io/langchainjs/docs/overview/](https://hwchase17.github.io/langchainjs/docs/overview/?ref=blog.langchain.com)
- ChatLangChain-js: [https://github.com/sullivan-sean/chat-langchainjs](https://github.com/sullivan-sean/chat-langchainjs?ref=blog.langchain.com)
- ChatLangChain-js：[https://github.com/sullivan-sean/chat-langchainjs](https://github.com/sullivan-sean/chat-langchainjs?ref=blog.langchain.com)

# Why TypeScript?

# 为何选择 TypeScript？

Initially, the crowd playing with language models was more of the researchy, ML-oriented folks - most of whom prefer Python. However, since the launch and quick success of ChatGPT, the idea of using LLMs has gone mainstream. As such, we saw a massive increase in interest in LangChain from folks across the stack, many of whom prefer to using javascript. As such, we thought it appropriate to develope a javascript native version of LangChain.

最初，探索语言模型的群体主要是偏研究型、面向机器学习的开发者——其中绝大多数更青睐 Python。然而，随着 ChatGPT 的发布及其迅速走红，“使用大语言模型（LLM）”的理念已全面走向主流。由此，我们观察到，来自全栈各层的开发者对 LangChain 的兴趣激增，而其中许多人更习惯使用 JavaScript。因此，我们决定开发一个原生的 JavaScript（TypeScript）版本 LangChain。

# What is in this package?

# 此软件包包含哪些内容？

All of the same abstractions that are in the Python package are in the Typescript package.

TypeScript 版本完整复现了 Python 版本中的所有抽象模块。

- [Prompts](https://hwchase17.github.io/langchainjs/docs/modules/prompts/prompt_template?ref=blog.langchain.com)
- [Prompt 模板](https://hwchase17.github.io/langchainjs/docs/modules/prompts/prompt_template?ref=blog.langchain.com)
- [LLMs](https://hwchase17.github.io/langchainjs/docs/modules/llms/openai?ref=blog.langchain.com)
- [大语言模型（LLM）](https://hwchase17.github.io/langchainjs/docs/modules/llms/openai?ref=blog.langchain.com)
- [Text Splitters](https://hwchase17.github.io/langchainjs/docs/modules/indexes/text_splitter?ref=blog.langchain.com)
- [文本切分器（Text Splitters）](https://hwchase17.github.io/langchainjs/docs/modules/indexes/text_splitter?ref=blog.langchain.com)
- [Embeddings](https://hwchase17.github.io/langchainjs/docs/modules/indexes/embeddings?ref=blog.langchain.com)
- [嵌入模型（Embeddings）](https://hwchase17.github.io/langchainjs/docs/modules/indexes/embeddings?ref=blog.langchain.com)
- [Vectorstores](https://hwchase17.github.io/langchainjs/docs/modules/indexes/vectorstore?ref=blog.langchain.com)
- [向量数据库（Vectorstores）](https://hwchase17.github.io/langchainjs/docs/modules/indexes/vectorstore?ref=blog.langchain.com)
- [Chains](https://hwchase17.github.io/langchainjs/docs/modules/chains/llm_chain?ref=blog.langchain.com)
- [Chain（链）](https://hwchase17.github.io/langchainjs/docs/modules/chains/llm_chain?ref=blog.langchain.com)
- [Agents](https://hwchase17.github.io/langchainjs/docs/modules/agents/overview?ref=blog.langchain.com)
- [Agent（智能体）](https://hwchase17.github.io/langchainjs/docs/modules/agents/overview?ref=blog.langchain.com)
- [Memory](https://hwchase17.github.io/langchainjs/docs/modules/memory/buffer_memory?ref=blog.langchain.com)
- [记忆模块（Memory）](https://hwchase17.github.io/langchainjs/docs/modules/memory/buffer_memory?ref=blog.langchain.com)

Since the Typescript version is much newer, there are fewer of these implementations in there. Also, many of the more ML-centric functionality (tokenizers, LLMs, etc) have worse TypeScript support. Still, we intend to bring and grow that functionality over time.

由于 TypeScript 版本要新得多，其中这类实现的数量也相对较少。此外，许多更偏向机器学习的核心功能（如分词器、大语言模型等）在 TypeScript 中的支持程度也较差。尽管如此，我们仍计划随时间推移逐步引入并完善这些功能。

With these abstractions, we found it very easy to recreate the "ChatLangChain" web application we previously made in Python to have a chatbot over our documentation. This utilizies many of those abstractions, and so is a perfect showcase. Check out the TypeScript version [here](https://github.com/sullivan-sean/chat-langchainjs?ref=blog.langchain.com).

借助这些抽象层，我们非常轻松地将此前用 Python 构建的 “ChatLangChain” 网页应用复现为一个面向我们文档的聊天机器人。该应用大量使用了上述抽象能力，因此堪称绝佳的演示案例。欢迎查看 TypeScript 版本：[此处](https://github.com/sullivan-sean/chat-langchainjs?ref=blog.langchain.com)。

# Relationship to the Python package

# 与 Python 包的关系

We intend the TypeScript package to mirror the Python package as closely as possible. To that end, it was a priority to make sure that serialized format we introduced for prompts, chains, and agents in Python worked for the TypeScript version.

我们的目标是让 TypeScript 包尽可能紧密地与 Python 包保持一致。为此，确保 Python 中为提示（prompts）、链（chains）和智能体（agents）所引入的序列化格式同样适用于 TypeScript 版本，成为一项关键优先事项。

We considered this a priority because as we grow the [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com) over time, we want these artifacts to be shareable between languages. This will allow for largely and more widespread community adoption and sharing of best prompts, chains, and agents. This will also make it possible to prototype in one language and then switch to the other. At the moment, since the TypeScript package does have slightly less functionality than the Python package, not all the chains are portable between languages. However, we intend to push hard to make them equal.

我们将此视为重中之重，是因为随着 [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com) 的持续发展，我们希望这些构件（artifacts）能在不同编程语言之间共享。这将极大促进社区对优质提示模板、链结构和智能体的广泛采用与共享；同时也支持开发者先用一种语言快速原型验证，再无缝切换至另一种语言进行开发。目前，由于 TypeScript 包的功能略少于 Python 包，尚非所有链结构都能跨语言直接复用。但我们正全力以赴，力求尽快实现二者功能对等。

Over time, it is not out of the question that the packages do diverge somewhat, in line with their respective audiences. For example, the Python package may start to include more researchy or data centric concepts, while the TypeScript package may include more features aimed at facilitating web dev. We are actually excited to explore the different priorities and use cases with the community. But throughout it all, we intended to keep on making the core set of prompts, chains, agents (and soon more) serializable and usable between languages.

长远来看，两个包在一定程度上出现差异化发展并非不可能，而这恰恰会契合各自的目标用户群体。例如，Python 包可能逐步纳入更多偏研究导向或数据密集型的概念，而 TypeScript 包则可能更侧重于增强 Web 开发体验的相关功能。我们实际上非常期待与社区共同探索这些差异化的优先级与实际应用场景。但无论如何，在整个演进过程中，我们都致力于确保核心组件——包括提示（prompts）、链（chains）、智能体（agents），以及未来更多模块——始终保持跨语言的可序列化性与互操作性。

# Thank You

# 致谢

A huge thank you to the community support and interest in "Langchain, but make it typescript". At one point there was a Discord group DM with 10 folks in it all contributing ideas, suggestion, and advice. In particular, large shoutout to [Sean Sullivan](https://twitter.com/_seanyneutron?ref=blog.langchain.com) and [Nuno Campos](https://twitter.com/nfcampos?ref=blog.langchain.com) for pushing hard on this.

衷心感谢社区对“LangChain，但用 TypeScript 实现”这一构想所给予的鼎力支持与热切关注。曾有一段时间，一个 Discord 群组私聊中聚集了 10 位热心贡献者，大家积极提出想法、建议与专业意见。尤其要向 [Sean Sullivan](https://twitter.com/_seanyneutron?ref=blog.langchain.com) 和 [Nuno Campos](https://twitter.com/nfcampos?ref=blog.langchain.com) 表示由衷感谢，他们为此项目付出了巨大努力。

We also pre-emptively thank the community for their feedback, contributions, and ideas for this package. We've already gotten a lot of interest in the short time we've been teasing it, and we're really excited to work on it together.

我们也提前向社区致以诚挚谢意——感谢大家对本包提出的反馈、贡献与创意。尽管我们仅进行了短暂预热，已收获大量关注；我们无比期待与各位携手共建这一项目。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/typescript-support/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/typescript-support/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/typescript-support/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中全面支持端到端 OpenTelemetry](images/typescript-support/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中全面支持端到端 OpenTelemetry**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/typescript-support/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/typescript-support/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/typescript-support/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/typescript-support/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/typescript-support/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读