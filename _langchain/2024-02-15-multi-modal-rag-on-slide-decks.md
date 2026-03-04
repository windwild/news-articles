---
title: "Multi-modal RAG on slide decks"
source: "LangChain Blog"
url: "https://blog.langchain.com/multi-modal-rag-template/"
date: "2024-02-15"
scraped_at: "2026-03-03T08:12:34.906060910+00:00"
language: "en-zh"
translated: true
---
{% raw %}

## Key Links

## 关键链接

- LangChain 公开基准评测 [notebooks](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval.html?ref=blog.langchain.com)  
- LangChain 面向演示文稿的多模态 RAG [模板](https://templates.langchain.com/?integration_name=rag-chroma-multi-modal&ref=blog.langchain.com)

## Motivation

## 动机

检索增强生成（RAG）是大语言模型（LLM）应用开发中最重要的概念之一。[多种类型](https://www.youtube.com/watch?v=O8sQxPgw8Ws&ref=blog.langchain.com)的文档可被[输入至 LLM 的上下文窗口](https://blog.langchain.com/deconstructing-rag/)，从而支持交互式聊天或问答助手。尽管迄今为止大多数 RAG 应用聚焦于文本，但大量信息实际以视觉内容形式呈现。例如，幻灯片（slide decks）广泛应用于从投资者路演到企业内部沟通等各种场景。随着 [GPT-4V](https://openai.com/research/gpt-4v-system-card?ref=blog.langchain.com) 等多模态大语言模型的出现，如今已有可能对幻灯片中常见的视觉内容开展 RAG。下文我们将介绍解决该问题的两种不同方法；我们公开了一个用于评测幻灯片 RAG 效果的基准，并借此揭示这两种方法之间的权衡取舍；最后，我们提供一个模板，帮助您快速构建面向幻灯片的多模态 RAG 应用。

## Design

## 设计思路

该任务与基于文本文档的 RAG 应用类似：根据用户提问检索出相关幻灯片，并将这些幻灯片送入多模态大语言模型（GPT-4V）以合成答案。至少存在两种通用的解决路径：

(1) **多模态嵌入（Multi-modal embeddings）**：将幻灯片提取为图像，使用多模态嵌入模型对每张图像进行向量化编码，再依据用户输入检索出最相关的幻灯片图像，最后将这些图像传给 GPT-4V 进行答案合成。我们此前已发布一份配套 [食谱（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/multi_modal_RAG_chroma.ipynb?ref=blog.langchain.com)，其中集成了 [Chroma](https://www.trychroma.com/?ref=blog.langchain.com) 向量数据库和 [OpenCLIP 嵌入模型](https://github.com/mlfoundations/open_clip?ref=blog.langchain.com)。

(2) **多向量检索器（Multi-vector retriever）**：将幻灯片提取为图像，利用 GPT-4V 对每张图像生成摘要，再将图像摘要（并附带指向原始图像的链接）通过文本嵌入模型进行向量化；检索时，依据用户输入与图像摘要之间的语义相似度找出相关图像，最终将这些图像送入 GPT-4V 进行答案合成。我们此前也已发布另一份 [食谱（cookbook）](https://github.com/langchain-ai/langchain/blob/master/cookbook/Multi_modal_RAG.ipynb?ref=blog.langchain.com)，其中采用 [多向量检索器（multi-vector retriever）](https://python.langchain.com/docs/modules/data_connection/retrievers/multi_vector?ref=blog.langchain.com) 实现该方案。

![](images/multi-modal-rag-on-slide-decks/img_001.jpg)

两种方法的核心权衡十分明确：多模态嵌入设计更简洁，其范式与传统文本型 RAG 应用高度一致；但当前可用的多模态嵌入模型选择有限，且在识别外观相似但语义迥异的图表或表格时可能存在能力瓶颈。相比之下，图像摘要方案借助成熟的文本嵌入模型，能以相当细致的语言描述图表或图形内容；但该方案复杂度更高，且图像摘要本身会带来额外的计算开销与成本。

## Evaluation

## 评估

To evaluate these methods, we chose a recent [earnings presentation](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com) from Datadog as a realistic slide deck with a mixture of visual and qualitative elements. We create a small public [LangChain benchmark](https://github.com/langchain-ai/langchain-benchmarks/pull/101?ref=blog.langchain.com) for this slide deck with 10 questions: you can see documentation for evaluating on this benchmark [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval_baseline.html?ref=blog.langchain.com) and [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval.html?ref=blog.langchain.com).

为评估这些方法，我们选取了 Datadog 最近发布的一份[财报演示文稿](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com)，作为一份兼具视觉元素与定性内容的真实幻灯片资料。我们为此幻灯片构建了一个小型公开的 [LangChain 基准测试集](https://github.com/langchain-ai/langchain-benchmarks/pull/101?ref=blog.langchain.com)，共包含 10 个问题；您可在此处查阅该基准测试的评估文档：[链接一](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval_baseline.html?ref=blog.langchain.com) 和 [链接二](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval.html?ref=blog.langchain.com)。

As a sanity check, we can see that it is possible to retrieve slides based upon a natural language description of the slide content (below, see code [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval.html?ref=blog.langchain.com)).

作为合理性验证，我们确认：仅凭对幻灯片内容的自然语言描述，即可成功检索到对应幻灯片（下方代码参见 [此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/retrieval/multi_modal_benchmarking/multi_modal_eval.html?ref=blog.langchain.com)）。

![](images/multi-modal-rag-on-slide-decks/img_002.png)Retrieval of slides based upon natural language with multi-modal embeddings

![](images/multi-modal-rag-on-slide-decks/img_002.png)基于多模态嵌入的自然语言幻灯片检索

The question-answer pairs in our benchmark are based on the visual content of the slides. We evaluated the above two RAG methods with [LangSmith](https://docs.smith.langchain.com/evaluation/faq/evaluator-implementations?ref=blog.langchain.com) and compare against RAG using text extraction (`Top K RAG (text only)`).

本基准测试中的问答对均基于幻灯片的视觉内容构建。我们使用 [LangSmith](https://docs.smith.langchain.com/evaluation/faq/evaluator-implementations?ref=blog.langchain.com) 对上述两种 RAG 方法进行了评估，并与仅依赖文本提取的 RAG 方法（`Top K RAG (text only)`）进行对比。

|     |     |
| --- | --- |
| Approach | Score ( [CoT accuracy](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation)) |
| Top k RAG (text only) | 20% |
| Multi-modal embeddings | 60% |
| Multi-vector retriever w/ image summary | 90% |

|     |     |
| --- | --- |
| 方法 | 得分（[思维链准确性（CoT accuracy）](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation)） |
| Top K RAG（仅文本） | 20% |
| 多模态嵌入 | 60% |
| 带图像摘要的多向量检索器 | 90% |

LangSmith offers a comparison view where we can review the results of each experiment side-by-side. [Here](https://smith.langchain.com/public/b738420f-3cd5-46c4-a0e1-894aff3cf37e/d?ref=blog.langchain.com) is a public page where the evaluation runs can be compared in detail. The image below shows the run comparison view.

LangSmith 提供对比视图功能，支持并排查看各次实验的结果。[此处](https://smith.langchain.com/public/b738420f-3cd5-46c4-a0e1-894aff3cf37e/d?ref=blog.langchain.com) 是一个公开页面，可对各项评估运行结果进行详细比对。下图即为运行结果对比视图。

![](https://lh7-us.googleusercontent.com/CVrWByV6IcS-rz84MOAb21Csg9iRqtFrx881FwRx2GZ5QMGLPj2yKiHbe8jgxUBCgRjdlcQe7uINnv_D2cGkNqc-9gR087OVZivuwDsJIPsGM9thaHNvJx59LkZFGUX_SD30dKp2MuSKDqpFGnOTgzA25A=s2048)LangSmith comparison view for the 3 experiments

![](https://lh7-us.googleusercontent.com/CVrWByV6IcS-rz84MOAb21Csg9iRqtFrx881FwRx2GZ5QMGLPj2yKiHbe8jgxUBCgRjdlcQe7uINnv_D2cGkNqc-9gR087OVZivuwDsJIPsGM9thaHNvJx59LkZFGUX_SD30dKp2MuSKDqpFGnOTgzA25A=s2048)三项实验的 LangSmith 对比视图

Using the above comparative analysis, we can compare the retrieved content for each question. These [slides](https://docs.google.com/presentation/d/19x0dvHGhbJOOUWqvPKrECPi1yI3makcoc-8tFLj9Sos/edit?usp=sharing&ref=blog.langchain.com) provide a deep dive of every question - answer pair in the evaluation set along with the associated LangSmith traces.

借助上述对比分析，我们可以逐题比对各方法所检索出的内容。这份 [幻灯片](https://docs.google.com/presentation/d/19x0dvHGhbJOOUWqvPKrECPi1yI3makcoc-8tFLj9Sos/edit?usp=sharing&ref=blog.langchain.com) 深度剖析了评估集中每一对问答，并附有对应的 LangSmith 追踪记录（traces）。

## Insights

## 洞察

1. **Multi-modal approaches far exceed the performance of text-only RAG**.  
1. **多模态方法的性能远超纯文本 RAG**。

We saw notable improvement with multi-modal approaches (60% and 90%) over the RAG that loads only the text (20%), an expected result given the importance of retaining visual context for reasoning about the slide content.  
我们观察到，多模态方法（准确率分别为 60% 和 90%）相比仅加载文本的 RAG（准确率仅 20%）展现出显著提升；这一结果在意料之中——毕竟，在对幻灯片内容进行推理时，保留视觉上下文至关重要。

2. **GPT-4V is powerful for structured data extraction from images**.  
2. **GPT-4V 在从图像中提取结构化数据方面能力强大**。

For example, see this [trace](https://smith.langchain.com/public/63c73da7-0001-4bb9-aa83-94cb9e63b24c/r?ref=blog.langchain.com). The question asks for the count of customers, which can only be retrieved from a slide that contains a broad mix of visual content. GPT-4V is able to correctly extract this information from the slide  
例如，请参阅此 [追踪记录](https://smith.langchain.com/public/63c73da7-0001-4bb9-aa83-94cb9e63b24c/r?ref=blog.langchain.com)。问题要求统计客户数量，而该信息只能从一张包含丰富混合视觉内容（如图表、表格、图标等）的幻灯片中获取。GPT-4V 能够准确地从该幻灯片中提取出这一信息。

![](https://lh7-us.googleusercontent.com/RLMyLx2geXsa1rBqHSxJx9aTrHXhTIi5nITsBUM89qMevwQJhT0rDzzNA7-I3w8gmzLCBdfkfCU9p4D90zQ5YtITWyGcLUrb2N55iNywy0PHkXnP3MzjFj8RcTrb6ghDtfB6QXuG3y84sL2cakjjC85enw=s2048)Extraction from visual tables  
![](https://lh7-us.googleusercontent.com/RLMyLx2geXsa1rBqHSxJx9aTrHXhTIi5nITsBUM89qMevwQJhT0rDzzNA7-I3w8gmzLCBdfkfCU9p4D90zQ5YtITWyGcLUrb2N55iNywy0PHkXnP3MzjFj8RcTrb6ghDtfB6QXuG3y84sL2cakjjC85enw=s2048)从视觉表格中提取信息

3. **Retrieval of the correct image is the central challenge.**  
3. **准确检索目标图像，是核心挑战**。

As noted in the [slides](https://docs.google.com/presentation/d/19x0dvHGhbJOOUWqvPKrECPi1yI3makcoc-8tFLj9Sos/edit?ref=blog.langchain.com#slide=id.g262b753d5b7_0_183) and mentioned above, if the correct image was retrieved then GPT-4V was typically able to answer the question correctly. However, image retrieval was the central challenge. We found that image summarization **does** improve retrieval significantly over multi-modal embeddings but comes with higher complexity and cost to pre-compute the summaries. The central need is for multi-modal embeddings that can differentiate between visually similar slides. OpenCLIP has a [wide variety of different models](https://github.com/mlfoundations/open_clip/blob/main/docs/openclip_results.csv?ref=blog.langchain.com) that are worth experimenting with; they can be easily configured as shown [here](https://python.langchain.com/docs/integrations/text_embedding/open_clip?ref=blog.langchain.com).  
正如 [幻灯片](https://docs.google.com/presentation/d/19x0dvHGhbJOOUWqvPKrECPi1yI3makcoc-8tFLj9Sos/edit?ref=blog.langchain.com#slide=id.g262b753d5b7_0_183) 中所述及上文所提：只要成功检索到正确的图像，GPT-4V 通常便能正确回答问题。然而，图像检索本身正是最核心的难点。我们发现，图像摘要（image summarization）**确实**能显著提升检索效果，优于直接使用多模态嵌入（multi-modal embeddings），但其代价是更高的计算复杂度与预生成摘要所需的成本。当前最迫切的需求，是开发出能够有效区分视觉上高度相似幻灯片的多模态嵌入模型。OpenCLIP 提供了[种类繁多的预训练模型](https://github.com/mlfoundations/open_clip/blob/main/docs/openclip_results.csv?ref=blog.langchain.com)，值得逐一尝试；这些模型可轻松配置，具体方法请参见[此处文档](https://python.langchain.com/docs/integrations/text_embedding/open_clip?ref=blog.langchain.com)。

## Deployment  
## 部署

To ease testing of multi-modal RAG application for this use-case, we are releasing a [template](https://templates.langchain.com/?integration_name=rag-chroma-multi-modal&ref=blog.langchain.com) that uses both Chroma and OpenCLIP multi-modal embeddings. This makes it extremely easy to get started: simply upload a presentation and follow the README (just two command to build the vectorstore and run the playground). Below we can see the interactive chat playground (left) on the [Datadog earnings presentation](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com) with the LangSmith trace (right) showing retrieval of the right slide.  
为简化本场景下多模态 RAG 应用的测试流程，我们发布了一个[模板](https://templates.langchain.com/?integration_name=rag-chroma-multi-modal&ref=blog.langchain.com)，该模板同时集成了 Chroma 向量数据库与 OpenCLIP 多模态嵌入。这使得快速上手变得极为简单：只需上传一份演示文稿，并按 README 指引操作（仅需两条命令即可构建向量数据库并启动交互式 Playground）。下方左侧为针对 [Datadog 财报演示文稿](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com) 的交互式聊天 Playground，右侧为 LangSmith 追踪记录，清晰展示了系统成功检索到目标幻灯片的过程。

![](images/multi-modal-rag-on-slide-decks/img_005.gif)  

## Conclusion  
## 结论

Multi-modal LLMs have potential to unlock the visual content in slide decks for RAG applications. We build a public benchmark evaluation set of question-answer pairs on an investor presentation slide deck for Datadog ( [here](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com)). We tested multi-modal RAG using two approaches on this benchmark. We found that both exceed the performance of text-only RAG. We identified trade-offs between approaches for multi-modal RAG: text summarization of each slide can improve retrieval but comes at the cost of pre-generating summaries of each slide. Multi-model are likely to have a higher performance ceiling, but current options are somewhat limited and, in our test, under-perform text summarization. To aid in the testing and deployment of multi-modal RAG apps, we also are releasing a [template](https://templates.langchain.com/?integration_name=rag-chroma-multi-modal&ref=blog.langchain.com).  
多模态大语言模型（Multi-modal LLMs）有望充分释放幻灯片中的视觉信息价值，赋能 RAG 应用。为此，我们构建了一个面向 Datadog 投资者财报演示文稿的公开基准评测数据集（含问答对），详见[此处](https://investors.datadoghq.com/static-files/986ca4cd-9507-4c9d-b56f-4bae59d3dd47?ref=blog.langchain.com)。我们在该基准上测试了两种多模态 RAG 方法，结果表明：二者性能均明显优于纯文本 RAG。我们进一步识别出不同方法间的权衡取舍：对每张幻灯片生成文本摘要虽可提升检索效果，但需额外投入资源预先生成所有摘要；而多模态模型理论上具备更高的性能上限，但目前可用选项仍较有限，且在我们的实测中，其表现尚不及文本摘要方案。为支持多模态 RAG 应用的测试与部署，我们同步发布了上述[模板](https://templates.langchain.com/?integration_name=rag-chroma-multi-modal&ref=blog.langchain.com)。
{% endraw %}
