---
title: "You.com x LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/you-com-x-langchain/"
date: "2023-10-18"
scraped_at: "2026-03-03T08:33:56.033770017+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

**Editor's Note: the following is a guest blog post from our friends at You.com. We've seen a lot of interesting use cases around interacting with the internet, and we're always looking for new tools to highlight to our community that can help do that. So when You.com mentioned they would releasing an API access to their search engine - the same one they use to power their [**AI assistant**](https://about.you.com/category/ai-tools/youchat/?ref=blog.langchain.com) \- we jumped at the opportunity to help them highlight this.**

**编者按：以下是由 You.com 团队撰写的客座博客文章。我们已观察到大量围绕“与互联网交互”的有趣应用场景，也始终在为社区发掘并推介有助于实现这一目标的新工具。因此，当 You.com 告知我们将开放其搜索引擎的 API 接入权限——即驱动其 [**AI 助手**](https://about.you.com/category/ai-tools/youchat/?ref=blog.langchain.com) 的同一套搜索引擎时，我们欣然抓住了这次机会，协助他们向广大开发者展示这一能力。**

**This blog post walks through some results highlighting the efficacy of the You.com search API. These results are based off of the below notebook, so you can follow along there:**

**本文将通过若干实验结果，展现 You.com 搜索 API 的实际效能。所有结果均基于下方 Notebook 生成，您可随时前往复现：**

- [**Notebook**](https://colab.research.google.com/github/You-OpenSource/You-API-Examples/blob/main/blogpost_final.ipynb?ref=blog.langchain.com)

- [**Notebook（笔记本）**](https://colab.research.google.com/github/You-OpenSource/You-API-Examples/blob/main/blogpost_final.ipynb?ref=blog.langchain.com)

### YouRetriever

### YouRetriever（You 检索器）

We are excited to announce the release of YouRetriever, the easiest way to get access to the [You.com](http://you.com/?ref=blog.langchain.com) Search API. The [You.com](http://you.com/?ref=blog.langchain.com) Search API is designed by LLMs for LLMs with an emphasis on Retrieval Augmented Generation (RAG) applications. We evaluate our API on a number of datasets to benchmark performance of LLMs in the RAG-QA setting and use these benchmarks to guide the optimization of our search systems.

我们很高兴地宣布 YouRetriever 正式发布——这是接入 [You.com](http://you.com/?ref=blog.langchain.com) 搜索 API 最便捷的方式。该 [You.com](http://you.com/?ref=blog.langchain.com) 搜索 API 由大语言模型（LLM）团队专为 LLM 场景设计，尤其面向检索增强生成（Retrieval Augmented Generation, RAG）类应用。我们已在多个数据集上对 API 进行评估，以量化其在 RAG-QA（检索增强问答）任务中对 LLM 性能的提升效果，并以此评估结果持续优化搜索系统。

In this blog post we will compare and contrast the You.com Search API with the Google Search API as well as give the reader the tools to evaluate LLMs in the RAG-QA setting. We will evaluate our retriever performance on [Hotpot QA](https://github.com/hotpotqa/hotpot?ref=blog.langchain.com) using the `RetrievalQA` Chain. Hotpot is a dataset which is comprised of a question, answer, and context. The context can vary in relevance to the question/answer with a special "distractor" setting where the LLM needs to not be distracted by certain misleading text within the context. In this experiment we will be removing the context from the dataset and replacing it with text snippets which come back from the search APIs. In this sense the entire internet is the distractor text since the APIs are responsible for finding the answer to the question across the entire internet not just within the list of snippets supplied in the dataset. We call this the "web distractor" setting for evaluating search APIs with respect to their performance being used in conjunction with an LLM.

在本文中，我们将对比 You.com 搜索 API 与 Google 搜索 API 的表现，并为读者提供一套可在 RAG-QA 场景下评估 LLM 性能的工具。我们将基于 [Hotpot QA](https://github.com/hotpotqa/hotpot?ref=blog.langchain.com) 数据集，使用 `RetrievalQA` 链来评估 YouRetriever 的检索性能。Hotpot 是一个包含问题、答案及上下文文本的问答数据集；其中上下文的相关性各异，特别设置了一种“干扰项（distractor）”场景——要求 LLM 能够识别并忽略上下文中某些具有误导性的无关内容。在本次实验中，我们将原始数据集中的预置上下文全部移除，代之以搜索 API 返回的文本片段。换言之，整个互联网都构成了潜在干扰源：API 必须从浩如烟海的全网信息中精准定位答案，而不仅限于数据集中预先提供的少量片段。我们将这种评估范式称为“网络干扰项（web distractor）”设定，用于衡量搜索 API 在与 LLM 协同工作时的真实检索效能。

### Retrieval

### 检索能力

The first thing you will notice about our text snippets is that we provide larger text snippets when we can and will soon have the option for specifying the amount of text you want returned from a single snippet to the entire page. Let's ask it about the greatest pinball player ever, Keith Elwin.

您首先会注意到，我们的文本片段默认提供更长的内容；未来还将支持灵活配置——从单个片段返回的文本量，直至整页网页内容，均可按需指定。现在，让我们来查询一下有史以来最伟大的弹球机选手：基思·埃尔温（Keith Elwin）。

![](images/you_com-x-langchain/img_001.png)

![](images/you_com-x-langchain/img_001.png)

You can see that even with the default settings we return 27 text snippets about the great Keith and some of the documents contain a decent amount of text. This makes our search API especially powerful for LLMs operating in the RAG-QA setting.

可以看到，即使采用默认配置，我们也返回了关于这位传奇人物基思的 27 个文本片段，且部分文档所含文本量相当可观。这使得 You.com 搜索 API 在 RAG-QA 场景下对大语言模型而言尤为强大。

However, these 27 text snippets can be a lot for a language model to work with. We can use the models with longer context windows as one workaround. There are a few options you can employ here if you don't want to use a smaller context window model. The first is the cap the number of documents you feed from our API to the LLM. The other option is to use the [map\_reduce chain](https://python.langchain.com/docs/modules/chains/document/map_reduce?ref=blog.langchain.com) type. The map\_reduce chain type takes larger chunks of text and breaks them down to make them digestible by the LLM. This does mean that you will need to make multiple calls to the LLM which will mean slower run-time but you'll be able to process all the data returned from the `YouRetriever`.

然而，这 27 段文本对语言模型而言可能数量过大，难以高效处理。一种可行的变通方案是采用上下文窗口更长的大语言模型。若您不希望使用上下文窗口较小的模型，还有几种替代方案可供选择：其一是限制从我们的 API 输入至大语言模型（LLM）的文档数量；其二是采用 [map_reduce 链](https://python.langchain.com/docs/modules/chains/document/map_reduce?ref=blog.langchain.com) 类型。该链类型会将大段文本切分为更小的、便于 LLM 理解与处理的片段。但需注意，这会导致对 LLM 发起多次调用，从而延长整体运行时间；不过，它能确保完整处理 `YouRetriever` 所返回的全部数据。

### Evaluation

### 评估

In order to evaluate, we'll use the HotPotQA dataset. We load this up from the [Huggingface dataset](https://huggingface.co/datasets/hotpot_qa?ref=blog.langchain.com) using the datasets library. We use the fullwiki setting here instead of the distractor but as we said before, we'll be using our own context powered by the search APIs instead of what comes off the shelf.

为开展评估，我们将使用 HotPotQA 数据集，并通过 `datasets` 库从 [Hugging Face 数据集平台](https://huggingface.co/datasets/hotpot_qa?ref=blog.langchain.com) 加载。此处我们选用 `fullwiki` 设置而非 `distractor` 设置；但如前所述，我们将完全依赖自研搜索 API 提供的上下文，而非直接采用数据集中附带的现成上下文。

Let's take a sample from Hotpot QA and compare our search API with one of the current alternatives in LangChain, the `GoogleSearchAPIWrapper`. This isn't a retriever in LangChain but it only takes a small amount of code to make an analog retriever. All we need to do is implement the `_get_relevant_documents` method of the abstract base class `BaseRetriever`. We should note here, that you could easily repeat this experiment and swap in another web search API like Bing. First let's create a small utility for the existing wrapper.

我们选取 Hotpot QA 中的一个样本，将我们的搜索 API 与 LangChain 当前提供的一个替代方案——`GoogleSearchAPIWrapper`——进行对比。虽然 `GoogleSearchAPIWrapper` 在 LangChain 中本身并非一个检索器（retriever），但只需少量代码即可将其封装为功能等效的检索器：我们仅需实现抽象基类 `BaseRetriever` 中的 `_get_relevant_documents` 方法即可。需要特别说明的是，您完全可以复现本实验，并轻松替换为其他网络搜索 API（例如 Bing 搜索 API）。首先，我们为现有封装器创建一个轻量级工具函数。

![](images/you_com-x-langchain/img_002.png)

![](images/you_com-x-langchain/img_002.png)

As you can see Google gives us much less information to feed into our LLM. While in both cases we requested results from 10 web results, the You.com Search API will attempt to give multiple text snippets per web result. To further demonstrate, we can now get predictions from the exact same LLM so we do our best to isolate the experiment to evaluating the search APIs.

如图所示，Google 返回的信息量明显少于 You.com 搜索 API，导致输入至 LLM 的内容更为有限。尽管两种 API 均按请求返回了 10 条网页结果，You.com 搜索 API 却会尝试为每条网页结果提取多个文本片段；而 Google 则通常仅提供单一片段。为进一步凸显差异，我们接下来将使用**完全相同的 LLM** 对两组结果分别生成预测答案，从而最大限度地将实验变量控制在“搜索 API 质量”这一单一维度上。

Now we can use these two search methods and get predictions from the LLM using each search API's results. It's important to remember that at this point we have done everything we can to ensure the only thing we're testing is the quality of search results for use by an LLM to answer these questions.

现在，我们可以利用这两种搜索方法，分别基于各自 API 返回的结果，驱动同一 LLM 生成预测答案。务必牢记：截至目前，我们已竭尽所能，确保本次实验所评估的唯一变量，就是各搜索 API 所返回结果的质量——即这些结果作为 LLM 回答问题所需上下文的有效性。

We use the F1 score function from the hotpot repository to ensure we are as close to the evaluation setting that was presented in the paper.

我们采用 hotpot 官方仓库提供的 F1 分数计算函数，以确保评估方式尽可能贴近原始论文中所设定的标准。

On the sample of data that we run over, we get the following results:

在我们所测试的样本数据集上，获得如下结果：

![](images/you_com-x-langchain/img_003.png)

![](images/you_com-x-langchain/img_003.png)

### In Conclusion

### 总结

As you can see, the You.com Search API heavily out-performs Google on this small subset of data. Please stay tuned as You.com will be releasing a much larger search study in the weeks to come. If you would like to be an early access partner of ours please email api@you.com with your background, use case, and expected daily call volume.

如您所见，You.com 搜索 API 在这一小部分数据集上大幅超越 Google。敬请关注——You.com 将在接下来几周内发布一项规模大得多的搜索对比研究。如果您希望成为我们的早期合作伙伴，请将您的背景信息、使用场景及预期日调用量发送邮件至 api@you.com。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/you_com-x-langchain/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/you_com-x-langchain/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/you_com-x-langchain/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/you_com-x-langchain/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/you_com-x-langchain/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/you_com-x-langchain/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/you_com-x-langchain/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/you_com-x-langchain/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/you_com-x-langchain/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台处于 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟