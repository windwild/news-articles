---
title: "Self-Reflective RAG with LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/agentic-rag-with-langgraph/"
date: "2024-02-15"
scraped_at: "2026-03-03T08:13:05.176553794+00:00"
language: "en-zh"
translated: true
---

### Key Links

### 关键链接

- [Self-RAG](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_self_rag.ipynb?ref=blog.langchain.com) 和 [CRAG](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_crag.ipynb?ref=blog.langchain.com) 的实用示例（Cookbooks）  
- [视频](https://youtu.be/pbAd8O1Lvm4?ref=blog.langchain.com)

### Motivation

### 动机

由于大多数大语言模型（LLM）仅会周期性地在大规模公开数据语料库上进行训练，因此它们缺乏最新信息和/或无法用于训练的私有数据。**R**etrieval-**A**ugmented **G**eneration（RAG，检索增强生成）是 LLM 应用开发中的核心范式，旨在通过将 LLM 连接到外部数据源来解决这一问题（参见我们的 [视频系列](https://www.youtube.com/watch?v=wd7TZ4w1mSw&feature=youtu.be&ref=blog.langchain.com) 和 [博客文章](https://blog.langchain.com/deconstructing-rag/)）。基础 RAG 流程包括：对用户查询进行嵌入（embedding），**检索**与该查询相关的文档，并将这些文档传给 LLM 以**生成**一个基于所检索上下文的答案。

![](images/self-reflective-rag-with-langgraph/img_001.png)基础 RAG 流程

### Self-Reflective RAG

### 自反思型 RAG（Self-Reflective RAG）

在实践中，许多人发现，实现 RAG 需要围绕上述步骤进行逻辑推理：例如，我们需判断何时执行检索（依据问题本身及索引的构成）、何时重写问题以提升检索效果，或何时丢弃不相关的检索结果并重新检索？“**自反思型 RAG**”（[论文](https://arxiv.org/abs/2310.11511?ref=blog.langchain.com)）这一术语由此提出，其核心思想是利用 LLM 对低质量的检索结果和/或生成内容进行自我修正。

上图所示的基础 RAG 流程仅使用一条**链式（chain）**结构：LLM 根据已检索到的文档直接决定生成内容。部分 RAG 流程采用**路由（routing）**机制，即由 LLM 根据问题本身，在不同检索器之间做出选择。但自反思型 RAG 通常需要某种形式的反馈机制，例如重新生成问题和/或重新执行文档检索。**状态机（state machines）** 是第三类[认知架构（cognitive architecture）](https://blog.langchain.com/openais-bet-on-a-cognitive-architecture/)，它天然支持循环操作，因而非常适合此类任务：状态机允许我们明确定义一系列步骤（例如：检索、评估文档相关性、重写查询），并设定各步骤之间的转移条件；例如，若检索出的文档不相关，则重写查询并重新检索新文档。

![](images/self-reflective-rag-with-langgraph/img_002.png)适用于 RAG 的认知架构

### Self-Reflective RAG with LangGraph

### 基于 LangGraph 的自反思型 RAG

We recently launched [LangGraph](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com), which is an easy way to implement LLM state machines. This gives us a lot of flexibility in the layout of diverse [RAG flows](https://x.com/hwchase17/status/1748089843698290840?s=20&ref=blog.langchain.com) and supports the more general process of "flow engineering" for RAG with specific decision points (e.g., document grading) and loops (e.g., re-try retrieval).

我们最近推出了 [LangGraph](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com)，这是一种轻松实现大语言模型（LLM）状态机的方式。这为我们灵活编排各类 [RAG 流程](https://x.com/hwchase17/status/1748089843698290840?s=20&ref=blog.langchain.com) 提供了极大便利，并支持更广义的 RAG “流程工程”——即在流程中嵌入特定决策点（例如文档分级）和循环机制（例如重试检索）。

![](images/self-reflective-rag-with-langgraph/img_003.png)State machines let us design more complex RAG "flows"

![](images/self-reflective-rag-with-langgraph/img_003.png)状态机使我们能够设计更复杂的 RAG“流程”

To highlight the flexibility of LangGraph, we'll use it to implement ideas inspired from two interesting and recent self-reflective RAG papers, [CRAG](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com) and [Self-RAG](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com).

为凸显 LangGraph 的灵活性，我们将基于两篇新颖且富有启发性的自反思式 RAG 论文——[CRAG](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com) 和 [Self-RAG](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com)——来构建相应实现。

### Corrective RAG (CRAG)

### 纠正性 RAG（CRAG）

Corrective RAG (CRAG) introduces a few interesting ideas ( [paper](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com)):

纠正性 RAG（CRAG）提出了若干颇具启发性的思路（[论文原文](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com)）：

- Employ a lightweight **retrieval evaluator** to assess the overall quality of retrieved documents for a query, returning a confidence score for each.  
  - 引入轻量级的 **检索评估器（retrieval evaluator）**，用于整体评估针对某查询所检索出的文档质量，并为每份文档返回一个置信度分数。

- Perform **web-based document retrieval to supplement context** if vectorstore retrieval is deemed ambiguous or irrelevant to the user query.  
  - 若向量数据库检索结果被判定为模糊或与用户查询无关，则执行 **基于网络的文档检索**，以补充上下文。

- Perform **knowledge refinement** of retrieved document by partitioning them into "knowledge strips", grading each strip, and filtering our irrelevant ones.  
  - 对已检索文档进行 **知识精炼（knowledge refinement）**：将其切分为“知识条带（knowledge strips）”，对每个条带评分，并过滤掉不相关条带。

![Screenshot 2024-02-04 at 2.50.32 PM.png](images/self-reflective-rag-with-langgraph/img_004.png)Diagram for CRAG

![Screenshot 2024-02-04 at 2.50.32 PM.png](images/self-reflective-rag-with-langgraph/img_004.png)CRAG 流程示意图

We can represent this as a graph, making a few simplifications and adjustment for illustrative purposes (of course, this can be customized and extended as desired):

我们可以将该流程建模为一张图，并在不影响核心逻辑的前提下做若干简化与调整（当然，实际应用中可根据需要自由定制和扩展）：

- We will skip the knowledge refinement phase as a first pass. It represents an interesting and valuable form of post-processing, but is not essential for understanding how to lay out this workflow in LangGraph.  
  - 我们将在第一版实现中跳过知识精炼阶段。该阶段是一种有趣且高价值的后处理方式，但并非理解如何在 LangGraph 中编排此工作流的必要环节。

- If _any_ document is irrelevant, we'll supplement retrieval with web search. We'll use [Tavily Search](https://python.langchain.com/docs/integrations/tools/tavily_search?ref=blog.langchain.com) API [for web search](https://tavily.com/?ref=blog.langchain.com), which is rapid and convenient.  
  - 只要**任一**文档被判定为不相关，我们就启动网络搜索以补充检索结果。我们将使用 [Tavily Search](https://python.langchain.com/docs/integrations/tools/tavily_search?ref=blog.langchain.com) API [执行网络搜索](https://tavily.com/?ref=blog.langchain.com)，其响应迅速、使用便捷。

- We'll use query re-writing to optimize the query for web search.  
  - 我们将采用查询重写（query re-writing）技术，优化原始查询以适配网络搜索。

- For binary decisions, we use Pydantic to model the output and supply this function as an OpenAI tool that is [called every time the LLM is run](https://python.langchain.com/docs/modules/model_io/chat/function_calling?ref=blog.langchain.com#binding-functions). This lets us model the output of conditional edges where consistent binary logic is critical.  
  - 对于二元决策，我们使用 Pydantic 对输出结构建模，并将该函数注册为 OpenAI 工具；该工具将在每次调用大语言模型时 [自动触发](https://python.langchain.com/docs/modules/model_io/chat/function_calling?ref=blog.langchain.com#binding-functions)。这使得我们能精准建模条件分支（conditional edges）的输出，尤其适用于需保持严格一致二元逻辑的关键路径。

![Screenshot 2024-02-04 at 1.32.52 PM.png](images/self-reflective-rag-with-langgraph/img_005.png)LangGraph implementation for CRAG

![Screenshot 2024-02-04 at 1.32.52 PM.png](images/self-reflective-rag-with-langgraph/img_005.png)CRAG 的 LangGraph 实现

We lay this out in an [example notebook](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_crag.ipynb?ref=blog.langchain.com) and index [three](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com) [blog](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering?ref=blog.langchain.com) [posts](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering?ref=blog.langchain.com). We can see a trace [here](https://smith.langchain.com/public/af0a82ae-69e6-4314-9c63-03ca49e56864/r?ref=blog.langchain.com) highlighting the usage when asked about information found in the blog posts: the logical flow across our nodes is clearly enumerated.

我们在一个 [示例 Notebook](https://github.com/langchain-ai/langgraph/blob/main/examples/rag/langgraph_crag.ipynb?ref=blog.langchain.com) 中实现了这一流程，并对 [三篇](https://lilianweng.github.io/posts/2023-06-23-agent/?ref=blog.langchain.com) [博客](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering?ref=blog.langchain.com) [文章](https://lilianweng.github.io/posts/2023-03-15-prompt-engineering?ref=blog.langchain.com) 进行了索引。我们可在 [此处追踪](https://smith.langchain.com/public/af0a82ae-69e6-4314-9c63-03ca49e56864/r?ref=blog.langchain.com) 中观察到模型在回答博客内容相关问题时的行为：各节点间的逻辑流转清晰可辨。

![](images/self-reflective-rag-with-langgraph/img_006.png)

![](images/self-reflective-rag-with-langgraph/img_006.png)

In contrast, we ask a question out of domain for the blog posts. The trace [here](https://smith.langchain.com/public/615c9263-7e0b-4307-93c1-aa9d7c3298b7/r?ref=blog.langchain.com) shows that we invokes on the lower path of our conditional edge and gather supplementary documents from [Tavily](https://python.langchain.com/docs/integrations/tools/tavily_search?ref=blog.langchain.com) web search used in final generation.

相比之下，我们向模型提出一个超出博客文章覆盖范围的问题。[此处的追踪记录](https://smith.langchain.com/public/615c9263-7e0b-4307-93c1-aa9d7c3298b7/r?ref=blog.langchain.com) 显示，模型触发了条件边（conditional edge）的“下游路径”，并调用 [Tavily](https://python.langchain.com/docs/integrations/tools/tavily_search?ref=blog.langchain.com) 网络搜索来获取补充文档，用于最终生成阶段。

![](images/self-reflective-rag-with-langgraph/img_007.png)

![](images/self-reflective-rag-with-langgraph/img_007.png)

### Self-RAG

### Self-RAG（自反思式 RAG）

Self-RAG is a related approach with several other interesting RAG ideas ( [paper](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com)). The framework trains an LLM to generate self-reflection tokens that govern various stages in the RAG process. Here is a summary of the tokens:

Self-RAG 是一种相关方法，融合了若干其他富有启发性的 RAG 思路（[论文](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com)）。该框架通过训练大语言模型（LLM），使其能生成用于调控 RAG 流程各阶段的“自反思标记（self-reflection tokens）”。以下是这些标记的简要说明：

- `Retrieve` token decides to retrieve `D` chunks with input `x (question)` OR `x (question)`, `y (generation)`. The output is `yes, no, continue`  
- `Retrieve` 标记决定是否基于输入 `x（问题）` 或 `x（问题）` 与 `y（当前生成结果）` 检索 `D` 个文本块。输出为 `yes（是）、no（否）、continue（继续）`。

- `ISREL` token decides whether passages `D` are relevant to `x` with input (`x (question)`, `d (chunk)`) for `d` in `D`. The output is `relevant, irrelevant`.  
- `ISREL` 标记判断文本块集合 `D` 中的每个片段 `d` 是否与 `x（问题）` 相关；输入为 `(x（问题）, d（文本块）)`。输出为 `relevant（相关）、irrelevant（不相关）`。

3. `ISSUP` token decides whether the LLM generation from each chunk in `D` is relevant to the chunk. The input is `x`, `d`, `y` for `d` in `D`. It confirm all of the verification-worthy statements in `y (generation)` are supported by `d`. Output is `fully supported, partially supported, no support`.  
3. `ISSUP` 标记判断 LLM 基于 `D` 中每个文本块 `d` 所生成的内容 `y` 是否得到该文本块的支持；输入为 `x（问题）`、`d（文本块）` 和 `y（生成结果）`。它验证 `y（生成结果）` 中所有需核实的陈述是否均由 `d` 支持。输出为 `fully supported（完全支持）、partially supported（部分支持）、no support（无支持）`。

4. `ISUSE` token decides whether generation from each chunk in `D` is a useful response to `x`. The input is `x`, `y` for `d` in `D`. Output is `{5, 4, 3, 2, 1}.`  
4. `ISUSE` 标记判断 `D` 中每个文本块 `d` 所生成的 `y` 是否对回答 `x（问题）` 具有实用价值；输入为 `x（问题）` 和 `y（生成结果）`。输出为 `{5, 4, 3, 2, 1}`（数值越高表示实用性越强）。

This table in the paper supplements the above information:

论文中的下表进一步补充了上述信息：

![](images/self-reflective-rag-with-langgraph/img_008.png)Four types of tokens used in Self-RAG

![](images/self-reflective-rag-with-langgraph/img_008.png)Self-RAG 中使用的四类标记

We can outline this as simplified graph to understand the information flow:

我们可以将此流程概括为一个简化的示意图，以帮助理解信息流向：

![Screenshot 2024-02-02 at 1.36.44 PM.png](images/self-reflective-rag-with-langgraph/img_009.png)Schematic graph of the flow used in Self-RAG

![Screenshot 2024-02-02 at 1.36.44 PM.png](images/self-reflective-rag-with-langgraph/img_009.png)Self-RAG 流程示意图

We can represent this in LangGraph, making a few simplifications / adjustments for illustrative purposes (this can be customized and extended as desired):

我们可在 LangGraph 中实现该流程，并为说明目的进行若干简化与调整（此实现可根据需要进一步定制和扩展）：

- 如上所述，我们对每个检索到的文档进行相关性评分。若**任意一个**文档被判定为相关，则进入生成阶段；若**全部**文档均被判定为不相关，则对原始查询进行改写，生成更优问题并重新执行检索。注意：此处可借鉴 CRAG（网络搜索）中的思路，将其作为该路径上的一个补充节点！  
- 原论文会对**每个文本块**分别执行一次生成，并对每次生成结果进行两次评分。而我们在本实现中仅对**所有相关文档合并后**执行一次生成；随后，该生成结果将从两个维度接受评估：一是相对于输入文档（例如，用于防范幻觉），二是相对于原始问题（如前所述）。此举显著减少了大语言模型（LLM）调用次数、降低了延迟，并支持在生成过程中整合更丰富的上下文信息。当然，若需更高粒度的控制，也可轻松适配为“逐块生成 + 独立评分”的模式。

![](images/self-reflective-rag-with-langgraph/img_010.png)LangGraph implementation for Self-RAG

![](images/self-reflective-rag-with-langgraph/img_010.png)Self-RAG 的 LangGraph 实现

[Here](https://smith.langchain.com/public/c4cc439e-2d1c-48cd-8c01-1d4a9dcf8dbf/r?ref=blog.langchain.com) is an example trace that highlights the ability of active RAG to self-correct. The question is `Explain how the different types of agent memory work?`. All four documents were deemed relevant, the generation versus documents check passes, but the generation was not deemed fully useful to the question.

[此处](https://smith.langchain.com/public/c4cc439e-2d1c-48cd-8c01-1d4a9dcf8dbf/r?ref=blog.langchain.com)是一个典型执行轨迹示例，凸显了主动式 RAG（active RAG）的自我修正能力。用户提问为：“请解释各类智能体记忆（agent memory）的工作原理？”——系统判定全部四份文档均相关，且生成结果通过了“与文档一致性”检验，但最终仍被判定为未能充分满足问题需求。

We then see the loop re-initiate with a re-formulated query [here](https://smith.langchain.com/public/2dd33136-749b-4028-90cd-07cbcfb8aa53/r?ref=blog.langchain.com): `How do the various types of agent memory function?` . One of out of four documents is filtered because it is not relevant ( [here](https://smith.langchain.com/public/532b6b7d-ff97-4f70-a731-664b3a47e458/r?ref=blog.langchain.com)). The generation then passes both checks:

随后，循环重新启动，查询被改写为：[此处](https://smith.langchain.com/public/2dd33136-749b-4028-90cd-07cbcfb8aa53/r?ref=blog.langchain.com) —— “各类智能体记忆是如何运作的？”其中一份文档因不相关而被过滤掉（[此处](https://smith.langchain.com/public/532b6b7d-ff97-4f70-a731-664b3a47e458/r?ref=blog.langchain.com)）。最终生成结果顺利通过两项检验：

`The various types of agent memory include sensory memory, short-term memory, and long-term memory. Sensory memory retains impressions of sensory information for a few seconds. Short-term memory is utilized for in-context learning and prompt engineering. Long-term memory allows the agent to retain and recall information over extended periods, often by leveraging an external vector store.`

“智能体记忆主要包括感觉记忆（sensory memory）、短期记忆（short-term memory）和长期记忆（long-term memory）。感觉记忆可保留感官信息的印象数秒；短期记忆常用于上下文学习（in-context learning）与提示工程（prompt engineering）；长期记忆则使智能体能够长期保存并回忆信息，通常借助外部向量数据库（vector store）实现。”

The overall trace is fairly easy to audit, with the nodes clearly laid out:

整个执行轨迹清晰易审，各节点逻辑明确呈现如下：

![](images/self-reflective-rag-with-langgraph/img_011.png)

### Conclusion

### 结论

Self-reflection can greatly enhance RAG, enabling correction of poor quality retrieval or generations.  

自我反思可显著增强 RAG，使其能够纠正低质量的检索结果或生成内容。

Several recent RAG papers focus on this theme, but implementing the ideas can be tricky.  

近期多篇 RAG 论文均围绕这一主题展开，但实际实现这些思路往往颇具挑战性。

Here, we show that LangGraph can be easily used for "flow engineering" of self-reflective RAG.  

本文中，我们展示了 LangGraph 可被便捷地用于自反思型 RAG 的“流程工程”（flow engineering）。

We provide cookbooks for implementing ideas from two interesting papers, [Self-RAG](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com) and [CRAG](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com).  

我们提供了两份实用指南（cookbook），分别介绍如何实现两篇颇具启发性的论文——[Self-RAG](https://arxiv.org/pdf/2310.11511.pdf?ref=blog.langchain.com) 和 [CRAG](https://arxiv.org/pdf/2401.15884.pdf?ref=blog.langchain.com)——中的核心思想。