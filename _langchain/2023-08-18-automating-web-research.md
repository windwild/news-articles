---
render_with_liquid: false
title: "Automating Web Research"
source: "LangChain Blog"
url: "https://blog.langchain.com/automating-web-research/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:03:15.049283074+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

## Key Links

## 关键链接

- [Web Researcher 代码仓库](https://github.com/langchain-ai/web-explorer/tree/main?ref=blog.langchain.com)
- [新版 LangChain 检索器](https://github.com/langchain-ai/langchain/pull/8102?ref=blog.langchain.com) 及其 [文档](https://python.langchain.com/docs/modules/data_connection/retrievers/web_research?ref=blog.langchain.com)
- [托管版 Streamlit 应用](https://web-explorer.streamlit.app/?ref=blog.langchain.com)

## Motivation

## 动机

网络研究（Web research）是大语言模型（LLM）最具代表性的应用场景之一：Greg Kamradt 将其列为他最希望拥有的 AI 工具之一（[原文推文](https://twitter.com/GregKamradt/status/1679913813297225729?s=20&ref=blog.langchain.com)），而开源项目（如 [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)）也正日益流行。我们决定尝试开发这一方向——最初，和许多团队一样，我们计划构建一个网络研究智能体（web research agent）。但最终，我们走上了另一条路径：一个结构相对简单、却高效且高度可配置的检索器（retriever）被证明效果出色；例如，它可轻松部署于私有模式下，正如 [PrivateGPT](https://github.com/imartinez/privateGPT?ref=blog.langchain.com) 等项目所推广的那样。本文将介绍我们的探索过程与思考逻辑、该检索器的具体实现方式，以及后续演进方向。

## Exploration

## 探索过程

前述项目（如 [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)）以及 AI 搜索引擎（如 [perplexity.ai](https://www.perplexity.ai/?ref=blog.langchain.com)）为我们初步展现了网络研究可能被重新构想的方式。和许多人一样，我们最初设计了一个智能体：它接收用户提示（prompt）和一组工具（tools），随后便能自主地（[autonomously](https://github.com/Significant-Gravitas/Auto-GPT?ref=blog.langchain.com)）在互联网上展开搜索！为此，该智能体显然需要以下三类工具：

- 搜索并返回网页结果  
- 抓取（scrape）所返回网页的全部内容  
- 从网页中提取相关信息  

借助这些工具，智能体便可模拟人类的研究行为：围绕某一主题发起搜索，筛选出若干相关链接，快速浏览各链接以定位有用信息，并在迭代过程中反复调整搜索策略。我们确实构建了这样一个智能体，并为其配备了上述工具……但结果发现，它在迭代式搜索过程中进展缓慢，表现竟与人类研究者如出一辙！

## Improvements

## 改进思路

我们注意到，AI 具备一项人类无法企及的核心优势：可并行发起大量搜索请求，并同步“阅读”多篇网页内容。当然，若在串行搜索中，首篇文档已涵盖全部必要信息，则并行处理反而可能造成资源浪费。但对于那些真正需要 AI 研究员介入的复杂问题而言，这种风险在一定程度上是可接受的。为此，我们引入了一些基础工具来支撑该并行流程，包括：[异步 HTML 文档加载器](https://python.langchain.com/docs/integrations/document_loaders/async_html?ref=blog.langchain.com) 和 [HTML 转文本转换器](https://python.langchain.com/docs/integrations/document_transformers/html2text?ref=blog.langchain.com)。

With a heap of information collected in parallel from a set of pages, it seemed reasonable to fetch the most relevant chunks from each page and load them into the context window of an LLM for synthesis. Of course, at this point we realized that our agent was morphing into a retriever! (NOTE: we still think that agentic properties can further benefit this retriever, as discussed at the end.)

从一组网页并行收集了大量信息后，从每一页中提取最相关的文本片段，并将其加载至大语言模型（LLM）的上下文窗口中以进行综合处理，这一做法看起来十分合理。当然，此时我们意识到：我们的智能体（agent）正在演变为一个检索器（retriever）！（注：我们仍认为，如文末所讨论，智能体特性可进一步增强该检索器的能力。）

## Retrieval

## 检索

What exactly would this retriever do under the hood? Our thinking was:

该检索器在底层究竟如何运作？我们的设计思路如下：

- Use an LLM to generate multiple relevant search queries (one LLM call)  
- 使用大语言模型生成多个相关搜索查询（一次 LLM 调用）

- Execute a search for each query  
- 对每个查询分别执行搜索  

- Choose the top K links per query  (multiple search calls in parallel)  
- 为每个查询选取排名前 K 的链接（并行发起多次搜索请求）

- Load the information from all chosen links (scrape pages in parallel)  
- 加载所有选定链接中的信息（并行抓取网页）

- Index those documents into a vectorstore  
- 将这些文档索引到向量数据库（vectorstore）中  

- Find the most relevant documents for each original generated search query  
- 针对每个原始生成的搜索查询，找出最相关的文档  

Collectively, these steps fall into [the flow](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) used for retrieval augmented generation:

上述步骤整体构成了[检索增强生成（RAG）的标准流程](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)：

![](https://blog.langchain.com/content/images/2023/07/image-11.png)

And yet the logic is similar to the agentic architecture for [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com):

然而，其逻辑与 [gpt-researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) 所采用的智能体架构高度相似：

![](https://blog.langchain.com/content/images/2023/07/68747470733a2f2f636f7772697465722d696d616765732e73332e616d617a6f6e6177732e636f6d2f617263682e706e67.png)

Even though this isn't an agent, the similarity in logic is a useful sanity check on the approach. We created a new LangChain [retriever](https://github.com/langchain-ai/langchain/pull/8102?ref=blog.langchain.com) and provide documentation on [usage](https://python.langchain.com/docs/modules/data_connection/retrievers/web_research?ref=blog.langchain.com) with configurations. For an example question ( _How do LLM Powered Autonomous Agents work?_), we can use [LangSmith](https://blog.langchain.com/announcing-langsmith/) to visualize and validate the process (see trace [here](https://smith.langchain.com/public/a789cbad-648b-4dca-8d65-21edd66dbd58/r?ref=blog.langchain.com)), observing that the retriever loads and retrieves chunks from a reasonable source (Lilian Weng's blog [post on agents](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com)):

尽管这并非严格意义上的智能体，但其逻辑上的相似性为当前方法提供了有益的合理性验证。我们已构建了一个全新的 LangChain [检索器](https://github.com/langchain-ai/langchain/pull/8102?ref=blog.langchain.com)，并为其提供了详尽的[使用文档](https://python.langchain.com/docs/modules/data_connection/retrievers/web_research?ref=blog.langchain.com)，涵盖各类配置说明。以示例问题“_LLM 驱动的自主智能体如何工作？_”为例，我们可借助 [LangSmith](https://blog.langchain.com/announcing-langsmith/) 可视化并验证整个流程（参见[追踪记录](https://smith.langchain.com/public/a789cbad-648b-4dca-8d65-21edd66dbd58/r?ref=blog.langchain.com)），观察到该检索器确实从一个合理信源（Lilian Weng 关于智能体的[博客文章](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com)）中加载并检索出了相关文本片段：

![](images/automating-web-research/img_003.png)

As noted in the documentation, the same process can be trivially configured to run it "private" mode using, for example, [LlamaV2 and GPT4all embeddings](https://python.langchain.com/docs/modules/data_connection/retrievers/web_research?ref=blog.langchain.com) (below is a [trace](https://smith.langchain.com/public/39a1fa89-a7fc-4115-a0ec-67e4c087e492/r?ref=blog.langchain.com) from a run executed on my Mac M2 Max GPU ~50 tok / sec):

如文档所述，上述流程只需简单配置，即可以“私有”模式运行，例如使用 [LlamaV2 和 GPT4All 嵌入模型](https://python.langchain.com/docs/modules/data_connection/retrievers/web_research?ref=blog.langchain.com)（下方是我在搭载 M2 Max GPU 的 Mac 上运行的一次实测 [追踪记录](https://smith.langchain.com/public/39a1fa89-a7fc-4115-a0ec-67e4c087e492/r?ref=blog.langchain.com)，处理速度约为每秒 50 个 token）：

![](images/automating-web-research/img_004.png)

## Application

## 应用

We wrapped the retriever with a simple [Streamlit](https://streamlit.io/?ref=blog.langchain.com) IU (only ~50 lines of code [here](https://github.com/langchain-ai/web-explorer/blob/main/web_explorer.py?ref=blog.langchain.com)) that can be configured with any LLM, vectorstore, and search tool of choice.

我们使用一个简洁的 [Streamlit](https://streamlit.io/?ref=blog.langchain.com) 用户界面（仅约 50 行代码，见 [此处](https://github.com/langchain-ai/web-explorer/blob/main/web_explorer.py?ref=blog.langchain.com)）封装了该检索器，支持灵活配置任意大语言模型（LLM）、向量数据库（vectorstore）及搜索工具。

![](images/automating-web-research/img_005.png)

## Conclusion

## 总结

What started as an attempt to build an autonomous web research agent, evolved into a fairly simple / efficient and customizable retriever. Still, this was just a first step. This project could benefit from adding in many agentic properties, such as:

最初旨在构建一个自主式网络研究智能体（autonomous web research agent）的尝试，最终演变为一个相当简洁、高效且高度可定制的检索器。但这也仅仅是个开端。该项目还可进一步增强多种智能体（agentic）特性，例如：

- Asking an LLM if more information is needed after the initial search  
  - 在初次搜索后，调用大语言模型判断是否需要补充更多信息；  
- Using multiple "write" and "revision" agents to construct the final answer  
  - 引入多个“撰写”与“修订”智能体协同工作，共同生成最终答案。

If any of those additions sound interesting, please open a PR against the [base repo](https://github.com/langchain-ai/web-explorer/tree/main?ref=blog.langchain.com) and we'll work with you to get them in!

若您对上述任一增强方向感兴趣，欢迎向 [主代码仓库](https://github.com/langchain-ai/web-explorer/tree/main?ref=blog.langchain.com) 提交 Pull Request（PR），我们将全力配合您完成集成！

While hosted AI search from large models like [Bard](https://bard.google.com/?ref=blog.langchain.com) or [Perplexity.ai](https://www.perplexity.ai/?ref=blog.langchain.com) are extremely performant, smaller lightweight tools for web research also have important merits such as privacy (e.g., the ability to run locally on your laptop without sharing any data externally), configurability (e.g., the ability to select the specific open source components to use), and observability (e.g., peer into what is happening "under the hood" using tools such as LangSmith).

尽管由 Bard、Perplexity.ai 等大型托管模型提供的 AI 搜索服务性能极为出色，但轻量级本地化网络研究工具同样具备不可替代的重要优势：**隐私性**（例如，可在您的笔记本电脑上完全离线运行，无需向外部共享任何数据）、**可配置性**（例如，可自由选择并组合特定的开源组件），以及**可观测性**（例如，借助 LangSmith 等工具深入洞察系统内部运行细节）。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/automating-web-research/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/automating-web-research/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/automating-web-research/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/automating-web-research/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/automating-web-research/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/automating-web-research/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/automating-web-research/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/automating-web-research/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/automating-web-research/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/automating-web-research/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/automating-web-research/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入测试阶段：面向可扩展智能体基础设施的新部署选项](images/automating-web-research/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入测试阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 4 分钟