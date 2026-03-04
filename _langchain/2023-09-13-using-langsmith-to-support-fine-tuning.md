---
title: "Using LangSmith to Support Fine-tuning"
source: "LangChain Blog"
url: "https://blog.langchain.com/using-langsmith-to-support-fine-tuning-of-open-source-llms/"
date: "2023-09-13"
scraped_at: "2026-03-03T08:45:52.083344805+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

### Summary

We created a guide for fine-tuning and evaluating LLMs **using LangSmith for dataset management and evaluation**. We did this both with an open source LLM on CoLab and HuggingFace for model training, as well as OpenAI's new finetuning service. As a test case, we fine-tuned LLaMA2-7b-chat and `gpt-3.5-turbo` for an extraction task (knowledge graph triple extraction) using training data exported from LangSmith and also evaluated the results using LangSmith. The CoLab guide is [here](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com).

### 摘要

我们编写了一份关于大语言模型（LLM）微调与评估的指南，**全程使用 LangSmith 进行数据集管理与效果评估**。该指南既涵盖在 Google Colab 和 HuggingFace 上对开源 LLM 进行训练的实践，也包含对 OpenAI 新推出的微调服务的使用。作为示例任务，我们利用从 LangSmith 导出的训练数据，分别对 LLaMA2-7b-chat 和 `gpt-3.5-turbo` 进行了知识图谱三元组抽取任务的微调，并同样借助 LangSmith 对结果进行了系统性评估。Colab 版本指南详见：[此处](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com)。

### Context

Interest in fine-tuning has grown rapidly over the past few weeks. This can largely be attributed to two causes.

First, the open source LLM ecosystem has grown remarkably, progressing from open source LLMs that [lagged the state-of-the-art (SOTA) by a wide margin](https://cameronrwolfe.substack.com/p/the-history-of-open-source-llms-early?ref=blog.langchain.com) to near-SOTA (e.g., Llama-2) LLMs that [can be run on consumer laptops](https://python.langchain.com/docs/guides/local_llms?ref=blog.langchain.com) in ~1 year! The drivers of this progress include [increasingly large corpus of training](https://cameronrwolfe.substack.com/p/the-history-of-open-source-llms-better?ref=blog.langchain.com) data (x-axis, below) and fine-tuning (y-axis) for [instruction-following](https://openai.com/research/instruction-following?ref=blog.langchain.com) and better-human- [aligned](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com) responses. Performant open source base models offer benefits such as cost savings (e.g., for [token-intensive tasks](https://twitter.com/RLanceMartin/status/1691492119855390720?s=20&ref=blog.langchain.com)), privacy, and - with fine tuning - the opportunity to [exceed](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com) SOTA LLMs with much smaller open source for highly specific tasks.

Second, the leading LLM provider, OpenAI, [has released](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com) fine-tuning support for `gpt-3.5-turbo` (and other models). Previously, fine-tuning was only available for older models. These models were not nearly as capable as newer models, meaning even after fine-tuning, they often weren't competitive with GPT-3.5 and few-shot examples. Now that newer models can be fine-tuned, many expect this to change.

[Some](https://twitter.com/ajratner/status/1693320931744292902?s=20&ref=blog.langchain.com) [have](https://www.youtube.com/watch?v=zjM2-_cFupo&ref=blog.langchain.com) [argued](https://www.youtube.com/watch?v=1StidE83-Xs&&ref=blog.langchain.com) that organizations may opt for many specialist fine-tuned LLMs derived from open source base models over a single massive generalist model. With this and libraries such as [HuggingFace](https://huggingface.co/blog/llama2?ref=blog.langchain.com) to support fine-tuning in mind, you may be curious about when and how to fine-tune. This guide provides an overview and shows how LangSmith can support the process.

![](images/using-langsmith-to-support-fine-tuning/img_001.png)

### 背景

近几周来，业界对模型微调（fine-tuning）的关注度迅速升温。这一趋势主要由两大因素驱动。

首先，开源大语言模型生态已取得惊人进展：短短约一年时间，开源 LLM 就从早期明显落后于最先进水平（SOTA）的阶段——如 [Cameron R. Wolfe 所述](https://cameronrwolfe.substack.com/p/the-history-of-open-source-llms-early?ref=blog.langchain.com)——跃升至接近 SOTA 的水准（例如 Llama-2），甚至可直接在消费级笔记本电脑上运行（参见 [LangChain 官方本地 LLM 指南](https://python.langchain.com/docs/guides/local_llms?ref=blog.langchain.com)）。推动这一进步的关键因素包括：训练语料规模持续扩大（下图横轴所示）以及针对指令遵循（[instruction-following](https://openai.com/research/instruction-following?ref=blog.langchain.com)）和更符合人类偏好（[human-aligned](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com)）的微调技术（纵轴所示）。高性能开源基础模型带来诸多优势，例如成本节约（尤其适用于 [token 密集型任务](https://twitter.com/RLanceMartin/status/1691492119855390720?s=20&ref=blog.langchain.com)）、数据隐私保障；更重要的是，通过微调，可在特定垂直任务上让轻量级开源模型超越通用 SOTA 模型（参见 [Anyscale 关于 Llama-2 微调的深度案例研究](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com)）。

其次，头部大模型提供商 OpenAI 已正式[发布](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com)对 `gpt-3.5-turbo`（及其他模型）的微调支持。此前，微调功能仅面向较老版本模型开放；而这些旧模型能力远逊于当前主流模型，即使经过微调，其表现往往仍难以匹敌 GPT-3.5 或少样本（few-shot）提示方法。如今新一代模型亦支持微调，业界普遍预期这将显著改变应用格局。

已有部分专家（如 [Alex Ratner](https://twitter.com/ajratner/status/1693320931744292902?s=20&ref=blog.langchain.com)）、研究者及工程师（参见 [YouTube 视频 1](https://www.youtube.com/watch?v=zjM2-_cFupo&ref=blog.langchain.com)、[YouTube 视频 2](https://www.youtube.com/watch?v=1StidE83-Xs&&ref=blog.langchain.com)）指出：组织机构或将倾向于部署多个基于开源基础模型定制的“专家型”微调模型，而非依赖单一庞大的“通才型”通用模型。考虑到这一趋势，以及 [HuggingFace](https://huggingface.co/blog/llama2?ref=blog.langchain.com) 等成熟工具链对微调流程的全面支持，您可能正思考：究竟何时需要微调？又该如何高效开展？本指南将为您提供概览，并重点展示 LangSmith 如何赋能整个微调工作流。

![](images/using-langsmith-to-support-fine-tuning/img_001.png)

### When to fine-tune

LLMs can learn new knowledge in at least two ways: weight updates (e.g., pre-training or fine-tuning) or prompting (e.g., retrieval augmented generation, RAG). Model weights are like long-term memory whereas the prompt is like short-term memory. This [OpenAI cookbook](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.com) has a useful analogy: _When you fine-tune a model, it's like studying for an exam one week away. When you insert knowledge into the prompt (e.g., via retrieval), it's like taking an exam with open notes._

### 何时进行微调？

大语言模型获取新知识至少有两种途径：权重更新（如预训练或微调）与提示工程（如检索增强生成，RAG）。模型权重相当于“长期记忆”，而提示（prompt）则更像“短期记忆”。[OpenAI 官方 Cookbook](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.com) 提供了一个形象类比：  
_微调模型，就像为一周后的大考认真复习；  
而将知识注入提示（例如通过检索实现），则如同开卷考试。_

With this in mind, fine-tuning is [not](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.com) [advised](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.com) for teaching an LLM new knowledge or factual recall; this [talk](https://www.youtube.com/live/hhiLw5Q_UFg?feature=share&ref=blog.langchain.com) from John Schulman of OpenAI notes that fine-tuning can increase hallucinations. Fine-tuning is better suited for teaching specialized tasks, but it [should be](https://twitter.com/rachel_l_woods/status/1692577254914638340?s=20&ref=blog.langchain.com) [considered](https://twitter.com/transitive_bs/status/1643017583917174784?s=20&ref=blog.langchain.com) [relative to prompting or RAG](https://twitter.com/karpathy/status/1655994367033884672?s=20&ref=blog.langchain.com). As discussed [here](https://twitter.com/karpathy/status/1655994367033884672?ref=blog.langchain.com), fine-tuning can be helpful for well-defined tasks with ample examples and / or LLMs that lack the in-context learning capacity for few-shot prompting. This Anyscale [blog](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.com) summarizes these points well: _fine-tuning is for form, not facts_.

考虑到这一点，**微调并不推荐**用于向大语言模型（LLM）传授新知识或提升事实性记忆能力；OpenAI 的 John Schulman 在这场[演讲](https://www.youtube.com/live/hhiLw5Q_UFg?feature=share&ref=blog.langchain.com)中指出，微调反而可能加剧模型的幻觉（hallucination）现象。微调更适合用于教授特定领域的专业任务，但其使用应与提示工程（prompting）或检索增强生成（RAG）等方法进行权衡比较——相关讨论见[此处](https://twitter.com/rachel_l_woods/status/1692577254914638340?s=20&ref=blog.langchain.com)、[此处](https://twitter.com/transitive_bs/status/1643017583917174784?s=20&ref=blog.langchain.com)和[此处](https://twitter.com/karpathy/status/1655994367033884672?s=20&ref=blog.langchain.com)。正如[这篇推文](https://twitter.com/karpathy/status/1655994367033884672?ref=blog.langchain.com)所讨论的，当任务定义清晰、样本充足，或当目标 LLM 缺乏上下文学习能力（难以通过少样本提示实现良好效果）时，微调才更具价值。Anyscale 的这篇[博客文章](https://www.anyscale.com/blog/fine-tuning-is-for-form-not-facts?ref=blog.langchain.com)很好地总结了上述观点：**微调适用于“形式”（form），而非“事实”（facts）**。

### How to fine-tune

### 如何进行微调

There’s a number of helpful LLaMA fine-tuning recipes that have been released for tasks such as [chat](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com) using a [subset](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com) of the [OpenAssistant corpus](https://paperswithcode.com/dataset/oasst1?ref=blog.langchain.com) in [HuggingFace](https://github.com/huggingface/trl/blob/main/examples/scripts/sft_trainer.py?ref=blog.langchain.com). Notably, these work on a single CoLab GPU, which makes the workflow accessible. However, two of the largest remaining pain points in fine-tuning are dataset collection / cleaning and evaluation. Below we show how LangSmith can be used to help address both of these (green, below).

目前已发布多个实用的 LLaMA 微调方案（recipes），适用于如[对话生成](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com)等任务，这些方案基于 [OpenAssistant 语料库](https://paperswithcode.com/dataset/oasst1?ref=blog.langchain.com)的一个[子集](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com)，并在 [HuggingFace](https://github.com/huggingface/trl/blob/main/examples/scripts/sft_trainer.py?ref=blog.langchain.com) 平台上实现。值得注意的是，这些方案仅需单块 Google Colab GPU 即可运行，大大降低了实践门槛。然而，当前微调流程中两大主要挑战仍是：**数据集的收集与清洗**，以及**模型评估**。下文将展示 LangSmith 如何助力解决这两项关键问题（如下图绿色标注部分所示）。

![](images/using-langsmith-to-support-fine-tuning/img_002.png)

### Task

### 任务类型

Tasks like [classification / tagging or extraction](https://twitter.com/ajratner/status/1693320931744292902?s=20&ref=blog.langchain.com) are well-suited for fine-tuning; Anyscale [reported](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com) promising results (exceeding GPT4) by fine-tuning LLaMA 7B and 13B LLMs on extraction, text-to-SQL, and QA. As a test case, we chose extraction of knowledge triples of the form (subject, relation, object) from text: the subject and object are entities and the relation is a property or connection between them. Triples can then be used to build [knowledge graphs](http://ai.stanford.edu/blog/introduction-to-knowledge-graphs/?ref=blog.langchain.com), databases that store information about entities and their relationships. We built an public [Streamlit app](https://auto-graph.streamlit.app/?ref=blog.langchain.com) for triple extraction from user input text to explore the capacity of LLMs (GPT3.5 or 4) to extract triples with function calling. In parallel, we fine-tuned LLaMA2-7b-chat and [GPT-3.5](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com) for this task using [public](https://github.com/dair-iitd/CaRB?ref=blog.langchain.com) [datasets](https://github.com/gkiril/benchie?ref=blog.langchain.com).

诸如[分类/标注或信息抽取](https://twitter.com/ajratner/status/1693320931744292902?s=20&ref=blog.langchain.com)等任务非常适合采用微调方式；Anyscale 曾[报告](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com)称，在信息抽取、文本转 SQL 和问答（QA）等任务上对 LLaMA-7B 和 LLaMA-13B 进行微调后，取得了超越 GPT-4 的优异效果。作为测试用例，我们选择了从文本中抽取**知识三元组**（triples）这一任务，其格式为（主语，关系，宾语）：其中主语与宾语均为实体（entity），关系则表示二者之间的属性或连接。此类三元组可用于构建[知识图谱](http://ai.stanford.edu/blog/introduction-to-knowledge-graphs/?ref=blog.langchain.com)——一种专门存储实体及其相互关系信息的数据库。为此，我们开发了一个公开的 [Streamlit 应用](https://auto-graph.streamlit.app/?ref=blog.langchain.com)，支持用户输入任意文本并利用 LLM（GPT-3.5 或 GPT-4）结合函数调用（function calling）自动抽取三元组，以探索大模型在此类任务上的能力边界。与此同时，我们也基于两个公开数据集——[CaRB](https://github.com/dair-iitd/CaRB?ref=blog.langchain.com) 和 [BenchIE](https://github.com/gkiril/benchie?ref=blog.langchain.com)，对 LLaMA2-7b-chat 和 [GPT-3.5](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com) 进行了该任务的微调。

### Dataset

### 数据集

**Dataset collection and cleaning is often a challenging task in training LLMs.** When a project is set up in LangSmith, generations are automatically logged, making it easy to get a large quantity of data. LangSmith offers a [queryable interface](https://docs.smith.langchain.com/evaluation/datasets?ref=blog.langchain.com) so you can use user feedback filters, tags, and other metrics to [select for poor quality cases](https://docs.smith.langchain.com/tracing/use-cases/export-runs/local?ref=blog.langchain.com#complex-query-list-all-runs-that-started-after-a-specific-timestamp-and-either-have-error-not-equal-to-null-or-a-correctness-feedback-score-equal-to-0), correct the outputs in the app, and save to datasets that you can use to improve the results of your model (see below).

**数据集的收集与清洗通常是训练大语言模型过程中最具挑战性的环节之一。** 当项目在 LangSmith 中完成初始化后，所有模型生成结果（generations）将被自动记录，从而轻松积累大量高质量数据。LangSmith 提供了[可查询的接口](https://docs.smith.langchain.com/evaluation/datasets?ref=blog.langchain.com)，支持您借助用户反馈标签（feedback filters）、自定义标签（tags）及其他评估指标，[精准筛选出低质量样本](https://docs.smith.langchain.com/tracing/use-cases/export-runs/local?ref=blog.langchain.com#complex-query-list-all-runs-that-started-after-a-specific-timestamp-and-either-have-error-not-equal-to-null-or-a-correctness-feedback-score-equal-to-0)，在应用界面中直接修正输出结果，并将修正后的样本保存为结构化数据集，用于持续优化模型性能（详见下文）。

![](images/using-langsmith-to-support-fine-tuning/img_003.png)

As an example, we created LangSmith train and test datasets from knowledge graph triples in the public [BenchIE](https://github.com/gkiril/benchie?ref=blog.langchain.com) and [CarbIE](https://blog.langchain.com/318c3ea1b6e442a7a8240acacb9c8a80?pvs=25) datasets; we converted them to a shared JSON format with each triplet represented as {s: subject, object: object, relation: relationship} and randomly split the combined data to into a  train set of ~1500 labeled sentences and a test set of 100 sentences. The [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com) shows how to easily load LangSmith datasets. Once loaded, we create instructions for fine-tuning using the system prompt below and [LLaMA instruction tokens](https://huggingface.co/blog/llama2?ref=blog.langchain.com#how-to-prompt-llama-2) (as done [here](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com)):

例如，我们从公开的 [BenchIE](https://github.com/gkiril/benchie?ref=blog.langchain.com) 和 [CarbIE](https://blog.langchain.com/318c3ea1b6e442a7a8240acacb9c8a80?pvs=25) 数据集中提取知识图谱三元组，构建 LangSmith 的训练集与测试集；我们将原始数据统一转换为标准 JSON 格式，每个三元组表示为 `{s: subject, object: object, relation: relationship}`，并将合并后的全部数据随机划分为约 1500 句带标注的训练样本和 100 句测试样本。[此 Colab 笔记本](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com)展示了如何便捷地加载 LangSmith 数据集。加载完成后，我们结合下方系统提示词（system prompt）及 [LLaMA 指令标记（instruction tokens）](https://huggingface.co/blog/llama2?ref=blog.langchain.com#how-to-prompt-llama-2)（方法参见[此处](https://huggingface.co/datasets/mlabonne/guanaco-llama2-1k?ref=blog.langchain.com)）构建微调所需的指令模板：

```
"you are a model tasked with extracting knowledge graph triples from given text. "
"你是一个负责从给定文本中抽取知识图谱三元组的模型。"

"The triples consist of:\n"
"三元组由以下三部分组成：\n"

"- \"s\": the subject, which is the main entity the statement is about.\n"
"- “s”：主语，即该陈述所描述的主要实体。\n"

"- \"object\": the object, which is the entity or concept that the subject is related to.\n"
"- “object”：宾语，即与主语存在关联的实体或概念。\n"

"- \"relation\": the relationship between the subject and the object. "
"- “relation”：主语与宾语之间的关系。"

"Given an input sentence, output the triples that represent the knowledge contained in the sentence."
"给定一个输入句子，请输出能表达该句中所含知识的三元组。"

### Quantization

### 量化（Quantization）

As shown in the excellent guide [here](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com), we fine-tune a 7B parameter LLaMA chat model. We want to do this on a single GPU (HuggingFace guide [here](https://huggingface.co/docs/transformers/perf_train_gpu_one?ref=blog.langchain.com#anatomy-of-models-memory)), which presents a challenge: if each parameter is 32 bits, a 7B parameter LLaMA2 model will occupy [28GB](https://finbarr.ca/how-is-llama-cpp-possible/?ref=blog.langchain.com), which exceeds the VRAM of a T4 (16GB). To address this, we [quantize](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com) the model parameters, which means binning the values (e.g., to 16 values in the case of 4 bit quantization), which reduces the memory required to store the model (7B \* 4 bits / parameter =3.5GB) ~ [8](https://finbarr.ca/how-is-llama-cpp-possible/?ref=blog.langchain.com)-fold.

如优秀教程[此处](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com)所示，我们对一个参数量为 70 亿（7B）的 LLaMA 聊天模型进行微调。我们希望在单块 GPU 上完成该任务（参见 Hugging Face 官方指南[此处](https://huggingface.co/docs/transformers/perf_train_gpu_one?ref=blog.langchain.com#anatomy-of-models-memory)），但这带来一项挑战：若每个参数以 32 位（float32）存储，则一个 7B 参数的 LLaMA2 模型将占用约 [28 GB](https://finbarr.ca/how-is-llama-cpp-possible/?ref=blog.langchain.com) 显存，超出 T4 GPU（16 GB VRAM）的容量。为此，我们对模型参数进行[量化（quantization）](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com)，即对参数值进行分桶（例如，在 4-bit 量化中将其映射至 16 个离散值），从而显著降低模型存储所需内存（7B × 4 bits/parameter = 3.5 GB），内存占用约为原始模型的 [1/8](https://finbarr.ca/how-is-llama-cpp-possible/?ref=blog.langchain.com)。

### **LoRA and qLoRA**

### **LoRA 与 qLoRA**

With the model in memory, we still need a way to fine-tune within the constraint of the remaining GPU resources. For this, parameter-efficient fine-tuning (PEFT) is a common approach: [LoRA](https://arxiv.org/abs/2106.09685?ref=blog.langchain.com) freezes the pre-trained model weights and injects trainable rank decomposition matrices into each layer of the model architecture (see [here](https://rentry.org/llm-training?ref=blog.langchain.com#low-rank-adaptation-lora_1)), reducing the number of trainable parameters for fine-tuning (e.g., [~1% of the total model](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com)). [qLoRA](https://arxiv.org/abs/2305.14314?ref=blog.langchain.com) extends this by freezing _quantized_ weights. During fine-tuning frozen weights are [de-quantized](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com) for forward and backward passes, but _only_ the (small set of) LoRA adapters are saved in memory, reducing fine-tuned model footprint.

模型加载进显存后，我们仍需在剩余 GPU 资源限制下完成微调。此时，参数高效微调（Parameter-Efficient Fine-Tuning, PEFT）是一种常用方法：[LoRA（Low-Rank Adaptation）](https://arxiv.org/abs/2106.09685?ref=blog.langchain.com) 冻结预训练模型的权重，并向模型每一层架构中注入可训练的低秩分解矩阵（参见[此处](https://rentry.org/llm-training?ref=blog.langchain.com#low-rank-adaptation-lora_1)），从而大幅减少微调所需的可训练参数量（例如仅占整个模型参数的 [~1%](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com)）。[qLoRA](https://arxiv.org/abs/2305.14314?ref=blog.langchain.com) 在此基础上进一步扩展，其冻结的是**已量化的权重**；微调过程中，冻结的权重会在前向与反向传播时被[反量化（de-quantized）](https://www.youtube.com/watch?v=TPcXVJ1VSRI&ref=blog.langchain.com)，但**仅将（数量极少的）LoRA 适配器**保留在内存中，从而极大压缩微调后模型的显存占用。

### Training

### 训练（Training）

We started with a pre-trained LLaMA-7b chat model `llama-2-7b-chat-hf` and fine-tuned on the ~1500 instructions in [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com#scrollTo=v1tOYeVGtQKJ) on an A100. For training configuration, we used LLaMA fine-tuning parameters from [here](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com): BitsAndBytes loads the base model with 4-bit precision but forward and backward passes are in fp16. We use [Supervised Fine-Tuning](https://huggingface.co/docs/trl/main/en/sft_trainer?ref=blog.langchain.com) (SFT) for fine-tuning on our instructions, which is quite fast (< 15 minutes) on an A100 for this small data volume.

我们以预训练的 LLaMA-7b 聊天模型 `llama-2-7b-chat-hf` 为起点，在 A100 GPU 上，基于 [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com#scrollTo=v1tOYeVGtQKJ) 中约 1500 条指令对该模型进行了微调。训练配置参考了[此处](https://mlabonne.github.io/blog/posts/Fine_Tune_Your_Own_Llama_2_Model_in_a_Colab_Notebook.html?ref=blog.langchain.com)提供的 LLaMA 微调参数：使用 BitsAndBytes 加载基础模型（4-bit 精度），但前向与反向传播均采用 fp16 精度。我们在指令数据集上采用[监督式微调（Supervised Fine-Tuning, SFT）](https://huggingface.co/docs/trl/main/en/sft_trainer?ref=blog.langchain.com)，由于数据量较小，在 A100 上完成整个微调过程非常迅速（< 15 分钟）。

### OpenAI Finetuning

### OpenAI 模型微调（OpenAI Finetuning）

To fine-tune OpenAI's GPT-3.5-turbo chat model, we selected 50 examples from the training dataset and converted them to a list of chat messages in the expected format:

为对 OpenAI 的 GPT-3.5-turbo 聊天模型进行微调，我们从训练数据集中选取了 50 个样本，并将其转换为符合预期格式的聊天消息列表：

```
{
    "messages": [\
        {\
            "role": "user",\
            "content": "Extract triplets from the following sentence:\n\n{sentence}"},\
        {\
            "role": "assistant",\
            "content": "{triples}"\
        },\
        ...\
    ]
}
```

Since the base model is so broadly capable, we don't need much data to achieve the desired behavior. The training data is meant to steer the model to always generate the correct format and style rather than to teach it substantial information.  As we will see in the evaluation section below, the 50 training examples were sufficient to get the model to predict triplets in the correct format each time.

由于基础模型具备极为广泛的通用能力，我们仅需少量数据即可实现期望的行为。训练数据的作用在于引导模型始终生成正确的格式与风格，而非向其传授大量实质性知识。正如我们在下方评估部分所见，仅需 50 个训练样本，模型便能每次都准确预测出符合规范的三元组。

We uploaded the fine-tuning data to via the `openai` SDK and used the resulting model directly in LangChain's `ChatOpenAI` class. The fine-tuned model can be used directly:

我们通过 `openai` SDK 上传了微调数据，并直接在 LangChain 的 `ChatOpenAI` 类中使用了该微调后的模型。微调模型可直接调用：

```
from langchain.chat_models import ChatOpenAI

llm = ChatOpenAI(model="ft:gpt-3.5-turbo-0613:{openaiOrg}::{modelId}")
```

The whole process took only a few minutes and required no code changes in our chain, apart from removing the need to add in few-shot examples in the prompt template. We then benchmarked this model against the others to quantify its performance. You can see an example of the whole process in our [CoLab](https://colab.research.google.com/drive/1YCyDHPSl0d_ULubCVshrP5hLqUCorr7d?usp=sharing&ref=blog.langchain.com) notebook.

整个过程仅耗时几分钟，且除移除提示模板中对少样本（few-shot）示例的需求外，我们的链式流程无需任何代码修改。随后，我们将该模型与其他模型进行基准测试，以量化其性能表现。您可在我们的 [CoLab](https://colab.research.google.com/drive/1YCyDHPSl0d_ULubCVshrP5hLqUCorr7d?usp=sharing&ref=blog.langchain.com) 笔记本中查看完整流程示例。

### Evaluation

### 评估

We evaluated each model using LangSmith, applying an LLM (GPT-4) evaluator to grade each prediction, which is instructed to identify factual discrepancies between the labels and the predicted triplets. This penalized results when it predicts triplets that are not present in the label or when the prediction fails to include a triplet, but it will be lenient if the exact wording of the object or relation differs in a non-meaningful way. The evaluator grades results on a scale from 0–100. We ran the evaluations in [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com) to easily configure our custom evaluator and chains to test.

我们使用 LangSmith 对各模型进行评估，采用一个大语言模型（GPT-4）作为评估器，对每个预测结果打分；该评估器被明确指示识别标注三元组与预测三元组之间的事实性差异。当模型预测出标注中不存在的三元组，或遗漏了应存在的三元组时，将予以扣分；但若实体（object）或关系（relation）的措辞存在非实质性的细微差异，则评估器会予以宽容。评估器按 0–100 分制对结果进行评分。为便于配置自定义评估器及测试链式流程，我们在 [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com) 中运行了全部评估任务。

The table below shows the evaluation results for the llama base chat model and the fine-tuned variant. For comparison, we also benchmarked 3 chains using OpenAI’s chat models: `gpt-3.5-turbo` using a few-shot prompt, a `gpt-3.5-turbo` model [fine-tuned](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com) on 50 training data points, and a few-shot `gpt-4` chain:

下表展示了 LLaMA 基础聊天模型及其微调版本的评估结果。作为对比，我们还对三种基于 OpenAI 聊天模型的链式流程进行了基准测试：采用少样本提示（few-shot prompt）的 `gpt-3.5-turbo`、在 50 条训练数据上[微调](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com)的 `gpt-3.5-turbo` 模型，以及采用少样本提示的 `gpt-4` 链：

- Few-shot prompting of GPT-4 performs the best  
- Fine-tuned GPT-3.5 is the runner up  
- Fine-tuned LLaMA-7b-chat exceeds the performance of GPT-3.5  
- And fine-tuned LLaMA-7b-chat is ~29% better than baseline LLaMA-7b-chat  

- GPT-4 的少样本提示效果最佳  
- 微调后的 GPT-3.5 表现次之  
- 微调后的 LLaMA-7b-chat 性能超越 GPT-3.5  
- 微调后的 LLaMA-7b-chat 相比基础版 LLaMA-7b-chat 提升约 29%

|  | Fine-tuned llama-2 | Base llama-2 chat model | few-shot gpt-3.5-turbo | finetuned gpt-3.5-turbo | few-shot gpt-4 |
| --- | --- | --- | --- | --- | --- |
| Score | 49% | 38% | 40% | 56% | 59% |

|  | 微调版 LLaMA-2 | 基础版 LLaMA-2 聊天模型 | 少样本 GPT-3.5-turbo | 微调版 GPT-3.5-turbo | 少样本 GPT-4 |
| --- | --- | --- | --- | --- | --- |
| 得分 | 49% | 38% | 40% | 56% | 59% |

### Analysis

### 分析

We use LangSmith to characterize common failure modes and better understand where the fine-tuned model behaves better than the base model. By filtering for low-scored predictions, we can see cases where baseline LLaMA-7b-chat comically hallucinates:  in the below case the LLM thinks that the subject is Homer Simpson and casually answers outside the scope of the desired format ( [here](https://smith.langchain.com/public/8c1c5381-e176-4838-927b-763dfc7cd395/r?ref=blog.langchain.com)). The fine-tuned LLaMA-7b-chat ( [here](https://smith.langchain.com/public/ad215bba-22ab-46aa-9e02-c6614525d092/r?ref=blog.langchain.com)) gets much closer to the reference (ground truth).

我们使用 LangSmith 来识别常见失效模式，并更深入地理解微调模型在哪些方面优于基础模型。通过筛选低分预测结果，我们可以观察到基线模型 LLaMA-7b-chat 出现的滑稽幻觉现象：如下例所示，该大语言模型错误地将主体判定为霍默·辛普森（Homer Simpson），并随意给出偏离目标格式的答案（[此处](https://smith.langchain.com/public/8c1c5381-e176-4838-927b-763dfc7cd395/r?ref=blog.langchain.com)）。而微调后的 LLaMA-7b-chat 模型（[此处](https://smith.langchain.com/public/ad215bba-22ab-46aa-9e02-c6614525d092/r?ref=blog.langchain.com)）则显著更接近参考答案（即真实标注值）。

![](images/using-langsmith-to-support-fine-tuning/img_004.png)Example of the base model hallucinating by inferring too much information from its pretrained knowledge.

![](images/using-langsmith-to-support-fine-tuning/img_004.png)基础模型因过度依赖预训练知识而产生幻觉的示例。

Even with few-shot examples, the baseline LLaMA-7b-chat has a tendency to answer in an informal chit-chat style ( [here](https://smith.langchain.com/public/80fa28ef-830f-487f-a6b6-07977db69c4a/r?ref=blog.langchain.com)).

即使提供少量示例（few-shot examples），基线 LLaMA-7b-chat 仍倾向于以非正式闲聊风格作答（[此处](https://smith.langchain.com/public/80fa28ef-830f-487f-a6b6-07977db69c4a/r?ref=blog.langchain.com)）。

![](images/using-langsmith-to-support-fine-tuning/img_005.png)The base llama model often injects narrative even when not asked.

![](images/using-langsmith-to-support-fine-tuning/img_005.png)基础 Llama 模型常在未被要求时主动添加叙述性内容。

In contrast, the fine-tuned model tends to generate text ( [here](https://smith.langchain.com/public/f02a9156-e1f1-4274-8b77-d883cf45955c/r?ref=blog.langchain.com)) that is aligned with the desired answer format and refrains from adding unwanted dialog.

相比之下，微调后的模型倾向于生成（[此处](https://smith.langchain.com/public/f02a9156-e1f1-4274-8b77-d883cf45955c/r?ref=blog.langchain.com)）符合目标格式的文本，并避免添加无关对话内容。

![](images/using-langsmith-to-support-fine-tuning/img_006.png)

![](images/using-langsmith-to-support-fine-tuning/img_006.png)

The fine-tuned model still had instances where it failed to generate the desired content. In the example below ( [link](https://smith.langchain.com/public/bdd7df30-177e-4e19-a280-8cd6173f002c/r?ref=blog.langchain.com)) the model repeated the instructions instead of generating the extracted results. This could be fixed with various approach such as different decoding parameters (or using logit biasing), more instructions, a larger base model (e.g., 13b), or improved instructions (prompt engineering).

微调模型仍存在未能生成预期内容的情况。如下例所示（[链接](https://smith.langchain.com/public/bdd7df30-177e-4e19-a280-8cd6173f002c/r?ref=blog.langchain.com)），模型重复输出了指令本身，而非生成所要求的抽取结果。此类问题可通过多种方式改进，例如调整解码参数（或应用 logits 偏置）、增加指令数量、选用更大的基础模型（如 13B 版本），或优化指令设计（即提示工程）。

![](images/using-langsmith-to-support-fine-tuning/img_007.png)The fine-tuned model occasionally become repetitive.

![](images/using-langsmith-to-support-fine-tuning/img_007.png)微调模型偶尔会出现重复输出现象。

We can contrast the above few-shot prompted GPT-4 below ( [link](https://smith.langchain.com/public/26ad7f19-9bf7-4236-8a3e-d910f099f14e/r?ref=blog.langchain.com)), which is able to extract reasonable triplets without fine-tuning on the training dataset.

我们可将上述少样本提示（few-shot prompting）驱动的 GPT-4（[链接](https://smith.langchain.com/public/26ad7f19-9bf7-4236-8a3e-d910f099f14e/r?ref=blog.langchain.com)）作为对照：它无需在训练数据集上进行微调，即可提取出合理的三元组。

![](images/using-langsmith-to-support-fine-tuning/img_008.png)

### Conclusion

### 结论

We can distill a few central lessons:

我们可以提炼出几条核心经验：

- **LangSmith can help address pain points in the fine-tuning workflow, such as data collection, evaluation, and inspection of results.** We show how LangSmith makes it easy to collect and load datasets as well as run evaluations and inspect specific generations.

- **LangSmith 可助力解决微调工作流中的关键痛点，例如数据收集、效果评估与结果检查。** 我们展示了 LangSmith 如何简化数据集的采集与加载，并支持便捷地运行评估任务及检查特定生成结果。

- **RAG or few-shot prompting [should](https://twitter.com/rachel_l_woods/status/1692577254914638340?s=20&ref=blog.langchain.com) [be](https://www.tidepool.so/2023/08/17/why-you-probably-dont-need-to-fine-tune-an-llm/?ref=blog.langchain.com) [considered](https://twitter.com/karpathy/status/1655994367033884672?s=20&ref=blog.langchain.com) carefully before jumping to more challenging and costly fine-tuning.** Few-shot prompting GPT-4 actually performs better than all of our fine-tuned variants.

- **在转向更具挑战性且成本更高的微调之前，应审慎考虑 RAG 或少样本提示（few-shot prompting）。** 实际上，GPT-4 的少样本提示效果优于我们所有微调后的模型变体。

- **Fine-tuning small open source models on well-defined tasks can outperform much larger generalist models.** Just as Anyscale and other have reported [previously](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com), we see that a fine-tuned LLaMA2-chat-7B model exceeds the performance of a much larger generalist LLM (GPT-3.5-turbo).

- **针对明确定义的任务对小型开源模型进行微调，其表现可超越规模大得多的通用大语言模型。** 正如 Anyscale 等机构此前所报告的那样，我们观察到：一个经微调的 LLaMA2-chat-7B 模型，在性能上超过了规模大得多的通用大语言模型（GPT-3.5-turbo）。

- **There are numerous levers to improve fine-tuning performance, most notably careful task definition and dataset curation.** Some works, such as [LIMA](https://arxiv.org/abs/2305.11206?ref=blog.langchain.com), have reported impressive performance by fine-tuning LLaMA on as few as 1000 instruction that were selected for high quality. Further data collection / cleaning, using a larger base model (e.g., LLaMA 13B), and scaling up with GPU services for fine-tuning ( [Lambda Labs](https://lambdalabs.com/?ref=blog.langchain.com), [Modal](https://modal.com/?ref=blog.langchain.com), [Vast.ai](http://vast.ai/?ref=blog.langchain.com), [Mosaic](https://www.mosaicml.com/?ref=blog.langchain.com), [Anyscale](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com), etc) are all foreseeable ways to improve these results.

- **提升微调性能的途径多种多样，其中最关键的是精准定义任务与精心构建数据集。** 例如，[LIMA](https://arxiv.org/abs/2305.11206?ref=blog.langchain.com) 等研究仅使用精选出的约 1000 条高质量指令对 LLaMA 进行微调，即取得了令人瞩目的效果。此外，进一步扩充或清洗数据、选用更大的基础模型（如 LLaMA-13B），以及借助 GPU 云服务（如 [Lambda Labs](https://lambdalabs.com/?ref=blog.langchain.com)、[Modal](https://modal.com/?ref=blog.langchain.com)、[Vast.ai](http://vast.ai/?ref=blog.langchain.com)、[Mosaic](https://www.mosaicml.com/?ref=blog.langchain.com)、[Anyscale](https://www.anyscale.com/blog/fine-tuning-llama-2-a-comprehensive-case-study-for-tailoring-models-to-unique-applications?ref=blog.langchain.com) 等）扩展微调算力，都是切实可行的性能优化路径。

Overall, these results (and the linked [CoLab](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com#scrollTo=pCf_83Q62_Nl)) provide a quick recipe for fine-tuning open source LLMs using LangSmith a tool to help with the full workflow.

总体而言，这些结果（以及配套的 [Colab 笔记本](https://colab.research.google.com/drive/1tpywvzwOS74YndNXhI8NUaEfPeqOc7ub?usp=sharing&ref=blog.langchain.com#scrollTo=pCf_83Q62_Nl)）为使用 LangSmith 全流程辅助开源大语言模型（LLM）微调提供了一套快速上手的实践方案。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/using-langsmith-to-support-fine-tuning/img_009.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/using-langsmith-to-support-fine-tuning/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/using-langsmith-to-support-fine-tuning/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/using-langsmith-to-support-fine-tuning/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain State of AI 2024 Report](images/using-langsmith-to-support-fine-tuning/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/using-langsmith-to-support-fine-tuning/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![Introducing OpenTelemetry support for LangSmith](images/using-langsmith-to-support-fine-tuning/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/using-langsmith-to-support-fine-tuning/img_013.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/using-langsmith-to-support-fine-tuning/img_014.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
