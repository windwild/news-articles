---
render_with_liquid: false
title: "Benchmarking RAG on tables"
source: "LangChain Blog"
url: "https://blog.langchain.com/benchmarking-rag-on-tables/"
date: "2023-12-13"
scraped_at: "2026-03-03T08:19:38.091687516+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

## Key links

## 关键链接

LangChain 公开基准评测笔记本：

- 长上下文大语言模型（Long context LLMs）：[点击此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/semi_structured_benchmarking/ss_eval_long_context.html?ref=blog.langchain.com)  
- 分块大小调优（Chunk size tuning）：[点击此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/semi_structured_benchmarking/ss_eval_chunk_sizes.html?ref=blog.langchain.com)  
- 多向量检索结合集成方法（Multi vector with ensemble）：[点击此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/semi_structured_benchmarking/ss_eval_multi_vector.html?ref=blog.langchain.com)

## Motivation

## 动机

检索增强生成（Retrieval Augmented Generation, RAG）是大语言模型（LLM）应用开发中最重要的概念之一。各类[文档类型](https://www.youtube.com/watch?v=O8sQxPgw8Ws&ref=blog.langchain.dev)均可[输入至大语言模型的上下文窗口](https://blog.langchain.com/deconstructing-rag/)，从而支持交互式聊天或问答助手。在表格数据中进行推理是 RAG 的一项重要应用场景，因为表格广泛存在于白皮书、财务报告及技术手册等文档中。

## Approaches

## 方法策略

针对非结构化文本与结构化表格混合构成的半结构化文档，至少有三种合理的半结构化 RAG 策略可供考虑：  
**(1)** 将包含表格的半结构化文档整体传入大语言模型上下文窗口（例如，使用长上下文大语言模型，如 [GPT-4 128k](https://openai.com/blog/new-models-and-developer-products-announced-at-devday?ref=blog.langchain.com) 或 [Claude 2.1](https://www.anthropic.com/index/claude-2-1?ref=blog.langchain.com)）；  
**(2)** 采用定向方法检测并提取文档中的表格（例如，使用专门用于[检测表格](https://github.com/microsoft/table-transformer?ref=blog.langchain.com)以供后续提取的模型）；  
**(3)** 对文档进行切分（例如，采用文本切分器），确保表格元素完整保留在各文本块内。对于策略 (2) 和 (3)，所提取的表格或含表格的文档切分块均可被嵌入（embedded）并存入向量数据库，以支持 RAG 应用中的语义检索（参见 [RAG 应用详解](https://blog.langchain.com/deconstructing-rag/)）。

![](images/benchmarking-rag-on-tables/img_001.png)

## Benchmarking

## 基准评测

为验证上述策略的有效性，我们构建了一个公开的 LangSmith 基准评测集：共包含来自 6 份文档（2 份白皮书 + 4 份财报）的 30 个问题，其中 25 个问题明确源自这些文档中的表格内容。

We tested two different long context LLMs along with various approaches for chunking documents. We use [LangSmith to grade](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation) the responses relative to the ground truth answer presented in the benchmark (chart below, runs [here](https://smith.langchain.com/public/8d99760c-8f2c-4cd4-aca0-8d72dc23c61d/d?ref=blog.langchain.com)).

我们测试了两种不同的长上下文大语言模型（LLM），并结合多种文档分块方法进行了评估。我们使用 [LangSmith 进行评分](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation)，将模型输出与基准测试中提供的标准答案（ground truth answer）进行比对（如下图所示；完整实验运行记录见 [此处](https://smith.langchain.com/public/8d99760c-8f2c-4cd4-aca0-8d72dc23c61d/d?ref=blog.langchain.com)）。

![](images/benchmarking-rag-on-tables/img_002.png)

## Approach 1: Long Context LLMs

## 方法一：长上下文大语言模型（Long Context LLMs）

Directly passing documents that contain tables into the a long context LLM context window has considerable appeal: it is simple. But the challenges are two-fold: (1) this approach does not scale to a very large corpus; 128k tokens is > 100 pages, but this is still small relative to the size of many datasets. (2) These LLMs exhibit some degradation in performance with respect to the size of the input and the placement of details within the inputs, as Greg Kamradt has nicely shown [here](https://twitter.com/GregKamradt/status/1722386725635580292?ref=blog.langchain.com) and [here](https://twitter.com/GregKamradt/status/1727018183608193393?ref=blog.langchain.com).

直接将含表格的文档整体送入长上下文大语言模型的上下文窗口，具有显著吸引力：该方法极为简洁。但其挑战也体现在两方面：（1）该方法难以扩展至超大规模语料库；GPT-4 的 128k token 上下文长度虽相当于百余页文本，但相较于许多真实数据集的规模仍显不足。（2）此类大语言模型的性能会随输入长度增加以及关键信息在输入中所处位置的变化而出现一定程度下降——Greg Kamradt 已在 [此处](https://twitter.com/GregKamradt/status/1722386725635580292?ref=blog.langchain.com) 和 [此处](https://twitter.com/GregKamradt/status/1727018183608193393?ref=blog.langchain.com) 做出了清晰直观的演示。

![](https://lh7-us.googleusercontent.com/XHj3A3pQYoc2N1XO0gFCTZbdLnvrKe0-vWFUCFtjjjSUPu8HCY_rnDjatQlvxm-aFDpzTiUfQMQ90KqgqN3cVJKIoEciSZMGqGqTw4ZOx7cMvF66zTHnqedwuWc8pkOCqEO7Ojpodyxs8St43PwqDJz_9g=s2048)Figure credit to Greg Kamradt ( [here](https://twitter.com/GregKamradt/status/1722386725635580292?ref=blog.langchain.com))

![](https://lh7-us.googleusercontent.com/XHj3A3pQYoc2N1XO0gFCTZbdLnvrKe0-vWFUCFtjjjSUPu8HCY_rnDjatQlvxm-aFDpzTiUfQMQ90KqgqN3cVJKIoEciSZMGqGqTw4ZOx7cMvF66zTHnqedwuWc8pkOCqEO7Ojpodyxs8St43PwqDJz_9g=s2048)图表来源：Greg Kamradt（[原文链接](https://twitter.com/GregKamradt/status/1722386725635580292?ref=blog.langchain.com)）

The concatenated text from all 6 documents is only ~36,000 tokens, far fewer than the 128k token context limit for GPT-4. Following the above report, we also looked at failures with respect to document depth (see results [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/semi_structured_benchmarking/ss_eval_long_context.html?ref=blog.langchain.com) and shown below). This would would benefit from more careful examination to better understand why and when long context LLMs fail to recover information in tables.

全部 6 份文档拼接后的文本仅约 36,000 个 token，远低于 GPT-4 的 128k token 上下文上限。基于上述报告，我们还进一步分析了模型失败是否与文档深度（document depth）相关（结果详见 [此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/semi_structured_benchmarking/ss_eval_long_context.html?ref=blog.langchain.com)，并展示于下方）。这一现象值得更细致地深入探究，以厘清长上下文大语言模型在何种条件下、因何原因无法从表格中准确恢复信息。

![](images/benchmarking-rag-on-tables/img_004.png)

## Approach 2: Targeted table extraction

## 方法二：面向表格的精准提取（Targeted Table Extraction）

Directly extracting tables from documents is appealing: it would allow us to use methods like the [multi-vector retriever](https://blog.langchain.com/semi-structured-multi-modal-rag/) to index each one. A few approaches [to detect tables](https://github.com/microsoft/table-transformer?ref=blog.langchain.com) in documents are available and packages such as [Unstructured](https://unstructured-io.github.io/unstructured/introduction.html?ref=blog.langchain.com#tables) or Docugami. We'll be following up with some specific analyses focused on these packages. However, it is worth flagging that table extraction is challenging due to variable representation of tables. For example, in our evaluation we saw cases where the table header was not correctly extracted using some of these methods (below). While challenging, these methods probably hit the highest performance ceiling, especially for complex table types, and are worth examining carefully.

直接从文档中提取表格极具吸引力：这将使我们能够采用诸如 [多向量检索器（multi-vector retriever）](https://blog.langchain.com/semi-structured-multi-modal-rag/) 等技术对每个表格单独建立索引。目前已有若干用于文档中表格检测的方法可供选择（例如 [Table Transformer](https://github.com/microsoft/table-transformer?ref=blog.langchain.com)），也有如 [Unstructured](https://unstructured-io.github.io/unstructured/introduction.html?ref=blog.langchain.com#tables) 或 Docugami 等成熟工具包。我们后续将针对这些工具包开展专项分析。但需特别指出的是，由于表格在文档中的呈现形式千差万别（如合并单元格、嵌套结构、图文混排等），表格提取本身是一项极具挑战性的任务。例如，在本次评估中，我们发现部分方法未能正确识别并提取表格的表头（如下图所示）。尽管难度较高，这类方法在性能上限方面仍具明显优势——尤其适用于结构复杂的表格类型，因而值得投入精力进行审慎评估。

![](images/benchmarking-rag-on-tables/img_005.png)

## Approach 3: Chunking

## 方法三：分块（Chunking）

While targeting table extraction focuses specifically on finding and extracting tables, document chunking naively splits documents based upon a specified token limit. The challenge here is straightforward: if we chunk a document in a way that disrupts table structure, then we will not be able to answer questions about it. As an example, we saw lowest performance with 50 token chunk size (30% accuracy) and we can visualize this using [chunkviz](https://www.chunkviz.com/?ref=blog.langchain.com) from Greg Kamradt: this obviously breaks up one of our examples tables in a problematic way and degrades performance.

虽然“目标表格提取”专注于精准定位并提取表格，但文档分块（document chunking）则简单粗暴地依据预设的 token 数量上限对文档进行切分。此处的挑战显而易见：若分块方式破坏了表格结构，我们就无法回答与该表格相关的问题。例如，当采用 50 token 的分块大小时，我们观察到最低性能（准确率仅 30%）；借助 Greg Kamradt 开发的 [chunkviz](https://www.chunkviz.com/?ref=blog.langchain.com) 工具，可直观看到这一问题——我们的某个示例表格被明显割裂，从而严重损害检索与问答效果。

![](images/benchmarking-rag-on-tables/img_006.png)50 token chunk size applied to a table

![](images/benchmarking-rag-on-tables/img_006.png)对表格应用 50 token 分块大小

So, the question is: how can we set chunk size to maximize the likelihood that we preserve tables? Performance improves with respect to chunk size, as expected, since tables are more likely to be preserved in larger chunks. We also tested both GPT-4 and Mixtral-8x-7b (via [Fireworks.ai](https://x.com/thefireworksai/status/1733309517583302700?s=20&ref=blog.langchain.com)), which shows that choice of LLM will impact performance by varying answer quality (see details [here](https://smith.langchain.com/public/8d99760c-8f2c-4cd4-aca0-8d72dc23c61d/d?ref=blog.langchain.com)).

因此，问题在于：如何设定分块大小，以最大程度确保表格结构的完整性？正如预期，随着分块尺寸增大，整体性能随之提升——因为更大的分块更有可能完整保留整张表格。我们还对比测试了 GPT-4 和 Mixtral-8x-7b（通过 [Fireworks.ai](https://x.com/thefireworksai/status/1733309517583302700?s=20&ref=blog.langchain.com) 提供），结果表明：大语言模型（LLM）的选择会显著影响最终性能，主要体现在生成答案的质量差异上（详见 [此处](https://smith.langchain.com/public/8d99760c-8f2c-4cd4-aca0-8d72dc23c61d/d?ref=blog.langchain.com)）。

Ultimately, we found an obvious chunk strategy worked well: _split documents along pages_. Many document tables are designed to respect page boundaries to improve human read-ability. Of course, this approach will break down in cases where tables span page boundaries (motivating targeted extraction methods).

最终，我们发现一种看似朴素却行之有效的分块策略：**按页面切分文档**。许多文档中的表格在设计之初就遵循页面边界，以提升人类阅读体验。当然，当表格跨页存在时，该策略便会失效——这也正凸显了“目标表格提取”等精细化方法的必要性。

However, we found another problem: chunks from tables, which contain our most valuable information, can compete with chunks from the text body of documents. Here is a [trace](https://smith.langchain.com/public/9c7c354f-2f39-4398-964c-d40cfcb8aeb6/r?ref=blog.langchain.com) that highlights the problem: we want the _capitalized software expense_ for Datadog in one of our docs but fail to retrieve the table chunks because this keyword is present in much of the text body, acting as a distraction.

然而，我们又发现了另一个问题：承载最关键信息的表格分块，可能在检索中被文档正文的普通文本分块所“淹没”。以下 [追踪记录](https://smith.langchain.com/public/9c7c354f-2f39-4398-964c-d40cfcb8aeb6/r?ref=blog.langchain.com) 清晰揭示了该问题：我们在某份文档中希望获取 Datadog 的“资本化软件支出（capitalized software expense）”，却未能成功召回包含该信息的表格分块——原因在于该关键词在大量正文文本中反复出现，形成干扰，导致表格内容被忽略。

![](images/benchmarking-rag-on-tables/img_007.png)

![](images/benchmarking-rag-on-tables/img_007.png)

To combat this, we found a simple approach worked well: build a retriever that focuses on tables. To do this, we use an LLM to scan each page and summarize any tables within the page. We then index those summaries for retrieval and store the raw page text containing the table with [multi-vector retriever](https://blog.langchain.com/semi-structured-multi-modal-rag/). Finally, we [ensemble](https://python.langchain.com/docs/modules/data_connection/retrievers/ensemble?ref=blog.langchain.com) retrieved table chunks with the raw text chunks. The nice thing about ensemble retriever is that we can prioritize certain sources, which allows use to ensure that any relevant tables chunks are passed to the LLM.

为应对这一问题，我们尝试了一种简洁有效的方法：构建一个**专注表格的检索器（table-focused retriever）**。具体而言，我们利用 LLM 扫描每一页，自动识别并生成其中表格的摘要；随后将这些摘要建立索引用于检索，并借助 [multi-vector retriever](https://blog.langchain.com/semi-structured-multi-modal-rag/) 同时保存原始含表页面文本。最后，我们将检索出的表格分块与常规文本分块通过 [ensemble 检索器](https://python.langchain.com/docs/modules/data_connection/retrievers/ensemble?ref=blog.langchain.com) 进行融合。ensemble 检索器的一大优势在于支持对不同来源设置优先级，从而确保所有相关表格分块均能可靠地传递至下游 LLM。

In short, the [ensemble retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/ensemble?ref=blog.langchain.com) combines the rankings from different retrievers into a single, unified ranking. Each retriever provides a list of documents (or search results) ranked based on their relevance to the query. We can apply weights to scale the contribution of each retriever to the final combined ranking. Here, we simply gives table-derived chunks a higher weight to ensure their retrieval.

简言之，[ensemble 检索器](https://python.langchain.com/docs/modules/data_connection/retrievers/ensemble?ref=blog.langchain.com) 将多个检索器各自输出的排序结果融合为一份统一、综合的排序列表。每个检索器都会返回一组按查询相关性排序的文档（或搜索结果）。我们可通过配置权重，调节各检索器对最终融合排序的贡献度。在此方案中，我们仅需为“源自表格的分块”赋予更高权重，即可切实保障其被优先检出。

![](images/benchmarking-rag-on-tables/img_008.png)

![](images/benchmarking-rag-on-tables/img_008.png)

## Conclusion

## 结论

While long context LLMs offer simplicity, factual recall can be challenged by both context length and table placement within documents.

尽管长上下文大语言模型（LLM）使用起来较为简单，但其事实性召回能力可能同时受到上下文长度以及表格在文档中所处位置的影响。

Targeted table extraction may have the highest performance ceiling, especially for complex table types, but requires specific packages that can add complexity and may suffer from failure modes on recognition of diverse of table types.

针对表格的提取方法可能具有最高的性能上限，尤其适用于结构复杂的表格类型；但该方法依赖特定软件包，不仅会增加系统复杂度，还可能因难以识别多样化的表格形式而出现失效问题。

Follow-up work will examine these methods in detail.

后续工作将对上述方法进行深入分析与评估。

Chunking is a simple approach, but chunk size selection is a challenge.

分块（chunking）是一种简单易行的方法，但如何选择合适的分块大小仍是一大挑战。

For this use case, we found that chunking along page boundaries is a reasonable way to preserve tables within chunks but acknowledge that there are failure modes such as multi-page tables.

针对本应用场景，我们发现按页面边界进行分块是一种较合理的策略，有助于在分块中保留完整表格；但我们也意识到该策略存在局限性，例如跨页表格（multi-page tables）即属于典型失效情形。

We also found that tricks such as ensembling can prioritize table-derived text chunks to improve performance.

此外，我们还发现，诸如集成（ensembling）等技巧可优先提升源自表格的文本分块的权重，从而改善整体性能。