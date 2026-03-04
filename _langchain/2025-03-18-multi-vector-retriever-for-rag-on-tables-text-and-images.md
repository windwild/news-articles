---
title: "Multi-Vector Retriever for RAG on tables, text, and images"
source: "LangChain Blog"
url: "https://blog.langchain.com/semi-structured-multi-modal-rag/"
date: "2025-03-18"
scraped_at: "2026-03-03T07:37:33.525065476+00:00"
language: "en-zh"
translated: true
---
{% raw %}

### Summary

Seamless question-answering across diverse data types (images, text, tables) is one of the holy grails of RAG.  
在多种数据类型（图像、文本、表格）之间实现无缝问答，是 RAG 领域的“圣杯”之一。

We’re releasing three new cookbooks that showcase the [multi-vector retriever](https://python.langchain.com/docs/how_to/multi_vector/?ref=blog.langchain.com) for RAG on documents that contain a mixture of content types.  
我们现推出三本全新实战指南（cookbook），演示如何在混合内容类型的文档上，利用 [多向量检索器（multi-vector retriever）](https://python.langchain.com/docs/how_to/multi_vector/?ref=blog.langchain.com) 构建 RAG 系统。

These cookbooks also present a few ideas for pairing [multimodal LLMs](https://huyenchip.com/2023/10/10/multimodal.html?ref=blog.langchain.com) with the multi-vector retriever to unlock RAG on images.  
这些指南还探讨了几种将 [多模态大语言模型（multimodal LLMs）](https://huyenchip.com/2023/10/10/multimodal.html?ref=blog.langchain.com) 与多向量检索器协同使用的思路，从而真正实现面向图像的 RAG 能力。

- [Cookbook for semi-structured (tables + text) RAG](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.com)  
- [面向半结构化数据（表格 + 文本）的 RAG 实战指南](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.com)

- [Cookbook for multi-modal (text + tables + images) RAG](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_and_multi_modal_RAG.ipynb?ref=blog.langchain.com)  
- [面向多模态数据（文本 + 表格 + 图像）的 RAG 实战指南](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_and_multi_modal_RAG.ipynb?ref=blog.langchain.com)

- [Cookbook for private multi-modal (text + tables + images) RAG](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_multi_modal_RAG_LLaMA2.ipynb?ref=blog.langchain.com)  
- [面向私有化多模态数据（文本 + 表格 + 图像）的 RAG 实战指南](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_multi_modal_RAG_LLaMA2.ipynb?ref=blog.langchain.com)

### Context

LLMs can acquire new information in at least two ways: (1) weight updates (e.g., [fine-tuning](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/)) and (2) [RAG](https://docs.google.com/presentation/d/1exjoapZ4EB_2xSQ7BSfSdPsZT30ap_6N3bi37F3cG0E/edit?ref=blog.langchain.com#slide=id.g23a039de743_0_40) (retrieval augmented generation), which passes relevant context to the LLM via prompt.  
大语言模型（LLM）至少可通过两种方式获取新知识：（1）权重更新（例如 [微调（fine-tuning）](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/)）；（2）[RAG（检索增强生成，retrieval-augmented generation）](https://docs.google.com/presentation/d/1exjoapZ4EB_2xSQ7BSfSdPsZT30ap_6N3bi37F3cG0E/edit?ref=blog.langchain.com#slide=id.g23a039de743_0_40)，即通过提示词（prompt）向 LLM 注入相关上下文。

RAG has particular promise [for](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev) [factual](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com) [recall](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.dev) because it marries the reasoning capability of LLMs with the content of external data sources, which is [particularly powerful](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.com) for enterprise data.  
RAG 在[事实性召回（factual recall）](https://www.youtube.com/watch?v=hhiLw5Q_UFg&ref=blog.langchain.com)方面展现出独特潜力——它将 LLM 的推理能力与外部数据源的内容有机结合，这一特性对[企业级数据应用](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.com)尤为强大。

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_001.png)

### Ways To Improve RAG

A number of techniques to improve RAG have been developed:  
目前已发展出多种提升 RAG 效果的技术方法：

| **Idea** | **Example** | **Sources** |
| --- | --- | --- |
| **Base case** **RAG** | Top K retrieval on embedded document chunks, return doc chunks for LLM context window | [LangChain vectorstores](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com), [embedding models](https://python.langchain.com/docs/modules/data_connection/text_embedding/?ref=blog.langchain.com) |
| **基础版 RAG** | 对嵌入后的文档分块执行 Top-K 检索，并将检出的文档块直接作为 LLM 上下文窗口输入 | [LangChain 向量数据库（vectorstores）](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com)，[嵌入模型（embedding models）](https://python.langchain.com/docs/modules/data_connection/text_embedding/?ref=blog.langchain.com) |

| **Summary** **embedding** | Top K retrieval on embedded document summaries, but return full doc for LLM context window | [LangChain Multi Vector Retriever](https://twitter.com/hwchase17/status/1695078249788027071?s=20&ref=blog.langchain.com) |
| **摘要嵌入（Summary embedding）** | 对嵌入后的文档摘要执行 Top-K 检索，但将对应完整文档送入 LLM 上下文窗口 | [LangChain 多向量检索器（Multi Vector Retriever）](https://twitter.com/hwchase17/status/1695078249788027071?s=20&ref=blog.langchain.com) |

| **Windowing** | Top K retrieval on embedded chunks or sentences, but return expanded window or full doc | [LangChain Parent Document Retriever](https://twitter.com/hwchase17/status/1691179199594364928?s=20&ref=blog.langchain.com) |
| **窗口扩展（Windowing）** | 对嵌入后的分块或句子执行 Top-K 检索，但返回其扩展上下文窗口（如前后若干句）或整篇文档 | [LangChain 父文档检索器（Parent Document Retriever）](https://twitter.com/hwchase17/status/1691179199594364928?s=20&ref=blog.langchain.com) |

| **Metadata filtering** | Top K retrieval with chunks filtered by metadata | [Self-query retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query?ref=blog.langchain.com) |
| **元数据过滤（Metadata filtering）** | 在 Top-K 检索过程中，依据元数据（metadata）对候选分块进行筛选 | [自查询检索器（Self-query retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query?ref=blog.langchain.com) |

| **Fine-tune RAG embeddings** | Fine-tune embedding model on your data | [LangChain fine-tuning guide](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/) |
| **RAG 嵌入模型微调（Fine-tune RAG embeddings）** | 在自有数据上对嵌入模型进行微调 | [LangChain 微调指南](https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/) |

| **2-stage** **RAG** | First stage keyword search followed by second stage semantic Top K retrieval | [Cohere re-rank](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.com) |
| **两阶段 RAG（2-stage RAG）** | 第一阶段执行关键词检索，第二阶段在初筛结果上进行语义 Top-K 检索 | [Cohere 重排序（re-rank）](https://python.langchain.com/docs/integrations/retrievers/cohere-reranker?ref=blog.langchain.com) |

### Applying RAG to Diverse Data Types

### 将 RAG 应用于多样化数据类型

Yet, RAG on documents that contain semi-structured data (structured tables with unstructured text) and multiple modalities (images) has remained a challenge.  
然而，针对包含半结构化数据（即带有非结构化文本的结构化表格）和多模态内容（如图像）的文档开展检索增强生成（RAG），仍是一项挑战。

With the emergence of [several](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com) [multimodal](https://llava.hliu.cc/?ref=blog.langchain.com) [models](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com), it is now worth considering unified strategies to enable RAG across modalities and semi-structured data.  
随着一系列[多模态模型](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)（如 Fuyu-8B）、[LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com) 和 [GPT-4V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com) 的涌现，现在值得探索统一策略，以支持跨模态及半结构化数据的 RAG 应用。

### Multi-Vector Retriever

### 多向量检索器（Multi-Vector Retriever）

Back in August, we released the [multi-vector retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com). It uses a simple, powerful idea for RAG: decouple documents, which we want to use for answer synthesis, from a reference, which we want to use for retriever.  
早在八月，我们发布了 [多向量检索器（Multi-Vector Retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com)。它基于一个简洁而强大的 RAG 思路：将用于答案生成（answer synthesis）的原始文档，与用于检索器（retriever）的参考表示（reference representation）解耦。

As a simple example, we can create a summary of a verbose document optimized to vector-based similarity search, but still pass the full document into the LLM to ensure no context is lost during answer synthesis. Here, we show that this approach useful beyond raw text, and can be applied generally to either tables or images to support RAG.  
举个简单例子：我们可以为一份冗长的文档生成一个专为向量相似性搜索优化的摘要，同时仍将完整原文传入大语言模型（LLM），从而确保答案生成过程中不丢失任何上下文信息。本文进一步表明，该方法不仅适用于纯文本，还可泛化应用于表格或图像，以全面支持 RAG。

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_002.png)

**Document Loading**

**文档加载**

Of course, to enable this approach we first need the ability to partition a document into its various types. [Unstructured](https://unstructured.io/?ref=blog.langchain.com) is a great ELT tool well-suited for this because it can extract elements (tables, images, text) from numerous file types.  
当然，要实现这一方案，我们首先需要将文档按类型进行切分的能力。[Unstructured](https://unstructured.io/?ref=blog.langchain.com) 是一款出色的 ELT 工具，非常适用于此类任务——它能从多种文件格式中提取各类元素（如表格、图像、文本）。

For example, Unstructured will [partition PDF files](https://unstructured-io.github.io/unstructured/bricks/partition.html?ref=blog.langchain.com#partition-pdf) by first removing all embedded image blocks. Then it will use a layout model ( [YOLOX](https://arxiv.org/abs/2107.08430?ref=blog.langchain.com)) to get bounding boxes (for tables) as well as `titles`, which are candidate sub-sections of the document (e.g., Introduction, etc). It will then perform post processing to aggregate text that falls under each `title` and perform further chunking into text blocks for downstream processing based on user-specific flags (e.g., min chunk size, etc).  
例如，Unstructured 在[解析 PDF 文件](https://unstructured-io.github.io/unstructured/bricks/partition.html?ref=blog.langchain.com#partition-pdf)时，会首先移除所有嵌入式图像块；随后调用版面分析模型（如 [YOLOX](https://arxiv.org/abs/2107.08430?ref=blog.langchain.com)）识别表格的边界框（bounding boxes）以及文档中的 `标题`（`titles`）——这些标题对应于文档潜在的子章节（如“引言”等）。最后，它将执行后处理操作：将归属于每个 `标题` 下的文本聚合起来，并依据用户设定的参数（如最小块大小等）进一步切分为适合下游处理的文本块。

**Semi-Structured Data**

**半结构化数据**

The combination of Unstructured file parsing and multi-vector retriever can support RAG on semi-structured data, which is a challenge for naive chunking strategies that may spit tables.  
Unstructured 的文件解析能力与多向量检索器相结合，可有效支撑半结构化数据上的 RAG，而这恰恰是简单粗暴的分块策略（naive chunking）难以应对的——后者往往将表格随意截断，破坏其完整性。

We generate [summaries](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary) of table elements, which is better suited to natural language retrieval. If a table summary is retrieved via semantic similarity to a user question, the _raw table_ is passed to the LLM for answer synthesis as described above. See the below cookbook and diagram:  
我们为表格元素生成[摘要](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary)，这类摘要更契合自然语言检索的需求。当某张表格的摘要通过语义相似度匹配到用户问题时，系统便会将该表格的**原始版本**（_raw table_）传入大语言模型，用于后续的答案生成（如前所述）。参见下方的实践指南（cookbook）与示意图：

- [Cookbook for semi-structure RAG](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.com)  
- [半结构化数据 RAG 实践指南（Cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_Structured_RAG.ipynb?ref=blog.langchain.com)

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_003.png)

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_003.png)

**Multi-Modal Data**

**多模态数据**

We can take this one step further and consider images, which is quickly becoming enabled by the release of multi-modal LLMs such as [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com) and open source models such as [LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com) and [Fuyu-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com). There are at least three ways to approach the problem, which utilize the [multi-vector retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary) framework as discussed above:

我们可以更进一步，将图像纳入考量——这正随着多模态大语言模型（MLLM）的发布而迅速成为可能，例如 [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com)，以及开源模型如 [LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com) 和 [Fuyu-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)。针对该问题，至少存在三种可行方案，均基于上文所述的 [多向量检索器（multi-vector retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary) 框架：

`Option 1:` Use multimodal embeddings (such as [CLIP](https://openai.com/research/clip?ref=blog.langchain.com)) to embed images and text together. Retrieve either using similarity search, but simply link to images in a docstore. Pass raw images and text chunks to a multimodal LLM for synthesis.

`选项 1：` 使用多模态嵌入模型（例如 [CLIP](https://openai.com/research/clip?ref=blog.langchain.com)）对图像与文本进行联合嵌入；检索时可采用相似性搜索，但仅在文档存储（docstore）中保留图像引用链接；最终将原始图像与文本片段一同输入多模态大语言模型（multimodal LLM），完成答案合成。

`Option 2:` Use a multimodal LLM (such as [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com), [LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com), or [FUYU-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)) to produce text summaries from images. Embed and retrieve text summaries using a text embedding model. And, again, reference raw text chunks or tables from a docstore for answer synthesis by a LLM; in this case, we exclude images from the docstore (e.g., because can't feasibility use a multi-modal LLM for synthesis).

`选项 2：` 利用多模态大语言模型（例如 [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com)、[LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com) 或 [FUYU-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)）为图像生成文本摘要；再使用纯文本嵌入模型对这些摘要进行嵌入与检索；最后，在答案合成阶段，仍从文档存储（docstore）中调取原始文本片段或表格内容供大语言模型（LLM）使用；此方案中，图像本身不存入 docstore（例如，因实际部署中难以用多模态 LLM 进行合成）。

`Option 3:` Use a multimodal LLM (such as [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com), [LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com), or [FUYU-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)) to produce text summaries from images. Embed and retrieve image summaries with a reference to the raw image, as we did above in option 1. And, again, pass raw images and text chunks to a multimodal LLM for answer synthesis. This option is sensible if we don't want to use multimodal embeddings.

`选项 3：` 同样使用多模态大语言模型（例如 [GPT4-V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com)、[LLaVA](https://llava.hliu.cc/?ref=blog.langchain.com) 或 [FUYU-8b](https://www.adept.ai/blog/fuyu-8b?ref=blog.langchain.com)）为图像生成文本摘要；但不同于选项 2，此处将摘要与对应原始图像的引用一并嵌入和检索（方式同选项 1）；最终仍将原始图像与文本片段共同输入多模态大语言模型以完成答案合成。若不希望引入多模态嵌入，则该方案尤为合理。

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_004.png)

![](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_004.png)

We tested `option 2` using the [7b parameter LLaVA model](https://huggingface.co/mys/ggml_llava-v1.5-7b/tree/main?ref=blog.langchain.com) (weights available [here](https://huggingface.co/mys/ggml_llava-v1.5-7b/tree/main?ref=blog.langchain.com)) to generate image image summaries. LLaVA recently added to [llama.cpp](https://github.com/ggerganov/llama.cpp/pull/3436?ref=blog.langchain.com), which allows it run on consumer laptops (Mac M2 max, 32gb ~45 token / sec) and produces reasonable image summaries. For example, for the image below it captures the humor: `The image features a close-up of a tray filled with various pieces of fried chicken. The chicken pieces are arranged in a way that resembles a map of the world, with some pieces placed in the shape of continents and others as countries. The arrangement of the chicken pieces creates a visually appealing and playful representation of the world.`

我们采用 [7B 参数版本的 LLaVA 模型](https://huggingface.co/mys/ggml_llava-v1.5-7b/tree/main?ref=blog.langchain.com)（权重文件可在此处下载：[链接](https://huggingface.co/mys/ggml_llava-v1.5-7b/tree/main?ref=blog.langchain.com)）测试了 `选项 2`，用于生成图像摘要。LLaVA 最近已集成至 [llama.cpp](https://github.com/ggerganov/llama.cpp/pull/3436?ref=blog.langchain.com)，使其可在消费级笔记本电脑（如 Mac M2 Max，32GB 内存）上运行（约 45 token/秒），并能生成质量合理的图像摘要。例如，对下方图像，其摘要成功捕捉到了其中的幽默感：“图中是一盘炸鸡的特写镜头。各块炸鸡被精心摆成一幅世界地图的形状：部分鸡块构成大陆轮廓，另一些则代表不同国家。整幅‘鸡地图’视觉效果鲜明，富有趣味性，是对世界版图的一次生动戏仿。”

![figure-8-1.jpg](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_005.jpg)

![figure-8-1.jpg](images/multi-vector-retriever-for-rag-on-tables-text-and-images/img_005.jpg)

We store these in the [multi-vector retriever](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary) along with table and text summaries.

我们将这些图像摘要，连同表格摘要与文本摘要，一并存入 [多向量检索器（multi-vector retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary) 中。

- [多模态（文本 + 表格 + 图像）RAG 实战指南](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_and_multi_modal_RAG.ipynb?ref=blog.langchain.com)

- [多模态（文本 + 表格 + 图像）RAG 实战指南（私有化部署版）](https://github.com/langchain-ai/langchain/blob/master/cookbook/Semi_structured_multi_modal_RAG_LLaMA2.ipynb?ref=blog.langchain.com)

如果数据隐私是您的关注重点，该 RAG 流水线可在消费级笔记本电脑上本地运行，全部采用开源组件：使用 [LLaVA](https://github.com/haotian-liu/LLaVA/?ref=blog.langchain.com) 7B 模型进行图像摘要生成；使用 [Chroma](https://www.trychroma.com/?ref=blog.langchain.com) 作为向量数据库；采用开源嵌入模型（如 [Nomic 的 GPT4All](https://python.langchain.com/docs/integrations/text_embedding/gpt4all?ref=blog.langchain.com)）；利用 [多向量检索器（multi-vector retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com#summary)；并借助 [Ollama.ai](http://ollama.ai/?ref=blog.langchain.com) 运行 [LLaMA2-13b-chat](https://python.langchain.com/docs/integrations/chat/ollama?ref=blog.langchain.com) 模型完成答案生成。

### 结论

### 结论

我们证明了多向量检索器（multi-vector retriever）既可支持半结构化 RAG，也可支持融合多模态数据（文本、表格与图像）的半结构化 RAG。同时，我们验证了整套流水线完全可在消费级笔记本电脑上依托开源组件实现本地化运行。最后，我们归纳出三种通用的多模态 RAG 方法，均基于多向量检索器理念构建，这些方法将作为未来实战指南（cookbooks）中的特色功能予以呈现。
{% endraw %}
