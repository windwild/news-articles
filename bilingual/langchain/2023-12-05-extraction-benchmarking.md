---
title: "Extraction Benchmarking"
source: "LangChain Blog"
url: "https://blog.langchain.com/extraction-benchmarking/"
date: "2023-12-05"
scraped_at: "2026-03-03T08:21:38.129212691+00:00"
language: "en-zh"
translated: true
tags: ["**The Prompt Landscape**", "![Building Chat LangChain", "**Building Chat LangChain**"]
---

Two weeks ago, we launched the [`langchain-benchmarks`](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) package, along with a [Q&A dataset](https://blog.langchain.com/public-langsmith-benchmarks/) over the LangChain docs.  
两周前，我们发布了 [`langchain-benchmarks`](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) 软件包，并同步上线了基于 LangChain 文档的 [问答（Q&A）数据集](https://blog.langchain.com/public-langsmith-benchmarks/)。

Today we’re releasing a new [extraction dataset](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com) that measures LLMs' ability to infer the correct structured information from chat logs.  
今天，我们正式发布一个全新的 [抽取（extraction）数据集](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com)，用于评估大语言模型（LLM）从聊天日志中推断并提取正确结构化信息的能力。

The new dataset offers a practical environment to test common challenges in LLM application development like classifying unstructured text, generating machine-readable information, and reasoning over multiple tasks with distracting information.  
该新数据集提供了一个贴近实际的测试环境，可用于检验 LLM 应用开发中的常见挑战，例如：对非结构化文本进行分类、生成机器可读的信息，以及在存在干扰信息的情况下跨多个任务进行推理。

In the rest of this post, I'll walk through how we created the dataset and share some initial benchmark results. We hope you find this useful for your own conversational app development and would love your feedback!  
在本文后续部分，我将详细介绍该数据集的构建过程，并分享一些初步的基准测试结果。我们希望这一资源能为您的对话式应用开发提供切实帮助，也诚挚期待您的反馈！

![](images/extraction-benchmarking/img_001.png)Selected metric comparison  
![](images/extraction-benchmarking/img_001.png)所选指标对比

## Motivation for the dataset  

## 构建该数据集的动因

We wanted to design the dataset schema around a real-world problem: gleaning structured insights from chat bot interactions.  
我们希望围绕一个真实世界的问题来设计该数据集的结构模式：即从聊天机器人交互中提炼出结构化的洞察。

Over the summer, our excellent intern [Molly](https://twitter.com/mollycantillon?ref=blog.langchain.com) helped us refresh [Chat LangChain](https://chat.langchain.com/?ref=blog.langchain.com) ( [repo](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com)), a retrieval-augmented generation (RAG) application over LangChain's python docs. It’s an “LLM with a search engine”, so you can ask it questions like "How do I add memory to an agent?”, and it will tell you an answer based on whatever it can find in the docs.  
今年夏天，我们优秀的实习生 [Molly](https://twitter.com/mollycantillon?ref=blog.langchain.com) 协助我们全面更新了 [Chat LangChain](https://chat.langchain.com/?ref=blog.langchain.com)（[代码仓库](https://github.com/langchain-ai/chat-langchain?ref=blog.langchain.com)）——这是一个基于 LangChain Python 文档构建的检索增强生成（RAG）应用。它本质上是一个“配备搜索引擎的 LLM”，因此您可以向它提问，例如：“如何为 Agent 添加记忆功能？”，它会根据在文档中检索到的内容给出回答。

The real test of [such](https://templates.langchain.com/?integration_name=rag-conversation&ref=blog.langchain.com) a [project](https://github.com/langchain-ai/weblangchain?ref=blog.langchain.com) begins post-deployment, when you begin to observe how it's used and refine it further. Typically, users won't provide explicit feedback, but their conversations reveal a lot, and while you can try just “ [putting the logs into an LLM”](https://docs.smith.langchain.com/tracing/use-cases/summarize-usage?ref=blog.langchain.com) to summarize it, you can also often benefit from extracting structured content to monitor and analyze. This could help drive analytic dashboards or fine-tuning data collection pipelines, since the structured values can easily be used by traditional software.  
对于 [此类](https://templates.langchain.com/?integration_name=rag-conversation&ref=blog.langchain.com) [项目](https://github.com/langchain-ai/weblangchain?ref=blog.langchain.com)，真正的考验始于部署之后——当您开始观察其实际使用情况并持续优化时。通常，用户并不会主动提供明确反馈，但他们的对话记录却蕴含大量有价值的信息。虽然您也可以尝试简单地“[将日志输入 LLM 进行总结](https://docs.smith.langchain.com/tracing/use-cases/summarize-usage?ref=blog.langchain.com)”，但更高效的做法往往是抽取结构化内容，以支持监控与分析。这些结构化字段可直接被传统软件系统调用，从而驱动分析型仪表盘或微调数据采集流水线的建设。

The [Chat Extraction](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com) dataset is designed around testing how well today's crop of LLMs are able to extract and categorize relevant information from this type of data. In the following section, I’ll walk through how we created the dataset. If you just want to see the results, check out the summary graph below. You can feel free to jump to the experiments section for an analysis of the results.  
[聊天抽取（Chat Extraction）](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com) 数据集正是围绕这一目标而设计：评测当前主流大语言模型从这类对话数据中抽取并归类相关信息的能力。接下来一节，我将详细说明该数据集的构建方法。若您只想快速查看结果，请参阅下方的汇总图表；如需深入分析，也欢迎直接跳转至“实验（Experiments）”章节。

![](images/extraction-benchmarking/img_002.png)Screenshot of the benchmark results  
![](images/extraction-benchmarking/img_002.png)基准测试结果截图

## Creating the Dataset

## 创建数据集

The main steps for creating the dataset were:

创建数据集的主要步骤如下：

1. Settle on a data model to represent the structured output.  
   确定一个数据模型，用于表示结构化输出。

2. Seed with Q&A pairs.  
   以问答对作为初始种子数据。

3. Generate candidate answers using an LLM.  
   利用大语言模型（LLM）生成候选答案。

4. Manually review the results in the annotation queue, updating the taxonomy where necessary.  
   在标注队列中人工审核结果，并在必要时更新分类体系（taxonomy）。

LangChain has long had [synthetic](https://python.langchain.com/docs/use_cases/data_generation?ref=blog.langchain.com) dataset [generation](https://github.com/langchain-ai/langchain/blob/700428593a86531ae0c891096c0d02aabcbc72af/libs/langchain/langchain/chains/qa_generation/base.py?ref=blog.langchain.com#L17) utilities that help you bootstrap some initial data, but the final version should always involve some amount of human review to ensure proper quality. That’s why we’ve added [data annotation queue](https://blog.langchain.com/announcing-data-annotation-queue/)’s to LangSmith and will continue to improve our tooling to help you build your data flywheel.

LangChain 很早就提供了[合成数据集](https://python.langchain.com/docs/use_cases/data_generation?ref=blog.langchain.com)的[生成工具](https://github.com/langchain-ai/langchain/blob/700428593a86531ae0c891096c0d02aabcbc72af/libs/langchain/langchain/chains/qa_generation/base.py?ref=blog.langchain.com#L17)，可帮助您快速启动初始数据构建；但最终版本必须包含一定比例的人工审核，以确保数据质量。正因如此，我们已在 LangSmith 中引入了[数据标注队列（data annotation queue）](https://blog.langchain.com/announcing-data-annotation-queue/)，并将持续优化相关工具链，助力您构建高效的数据飞轮（data flywheel）。

Once you have an initial dataset, you can use the labeled data as few-shot examples within the seed-generation model to improve the quality of data given to humans for review. This can help reduce the amount of work and changes needed when updating the ground truth.

一旦获得初始数据集，即可将已标注数据作为少样本（few-shot）示例输入至种子生成模型中，从而提升交付给人类审核的数据质量。这有助于减少后续更新“真实标签”（ground truth）时所需的人工工作量与修改幅度。

## **Extraction Schema**

## **抽取模式（Extraction Schema）**

We wanted the task to be tractable while still offering a challenge for many common models today. We defined the schema using [this linked pydantic model](https://github.com/langchain-ai/langchain-benchmarks/blob/4ddbbc0ff87fb4dfac3cb457dba56e64d8cbc9c6/langchain_benchmarks/extraction/tasks/chat_extraction/schema.py?ref=blog.langchain.com#L7). An example extracted value is below:

我们希望该任务具备可操作性，同时仍能对当前主流模型构成切实挑战。我们使用[此链接指向的 Pydantic 模型](https://github.com/langchain-ai/langchain-benchmarks/blob/4ddbbc0ff87fb4dfac3cb457dba56e64d8cbc9c6/langchain_benchmarks/extraction/tasks/chat_extraction/schema.py?ref=blog.langchain.com#L7)定义了该抽取模式。以下为一个抽取结果示例：

```json
{
  "GenerateTicket": {
    "question": {
      "toxicity": 0,
      "sentiment": "Neutral",
      "is_off_topic": false,
      "question_category": "Function Calling",
      "programming_language": "unknown"
    },
    "response": {
      "response_type": "provide guidance",
      "confidence_level": 5,
      "followup_actions": [\
        "Check with API provider for function calling support."\
      ]
    },
    "issue_summary": "Function Calling Format Validation"
  }
}
```

```json
{
  "GenerateTicket": {
    "question": {
      "toxicity": 0,
      "sentiment": "中性",
      "is_off_topic": false,
      "question_category": "函数调用",
      "programming_language": "未知"
    },
    "response": {
      "response_type": "提供指导",
      "confidence_level": 5,
      "followup_actions": [\
        "联系 API 提供方确认是否支持函数调用功能。"\
      ]
    },
    "issue_summary": "函数调用格式校验"
  }
}
```

Example Extracted Output  
抽取结果示例  

Many of these values could be useful in monitoring an actual production chat bot. We made the schema challenging in a few ways to make the benchmark results more useful in separating model capacity and functionality. Some challenges about this schema include:  

上述许多字段值均可用于实际生产环境中聊天机器人的运行监控。我们从多个维度提升了该模式的难度，以使基准测试结果更能有效区分模型的底层能力（capacity）与功能实现水平（functionality）。该模式的主要难点包括：

1. 它包含若干个长度较长的枚举（Enum）值。即使是 OpenAI 的函数调用/工具使用 API，[在生成此类值时也可能不够准确](https://community.openai.com/t/function-api-returns-value-that-are-not-in-enum/274544?ref=blog.langchain.com)。  
1. 它包含若干个长度较长的枚举（Enum）值。即使是 OpenAI 的函数调用/工具使用 API，在生成此类值时也可能不够准确。

2. 该对象具有嵌套结构——若大语言模型（LLM）未经过代码训练，嵌套结构可能使其更难保持逻辑连贯性。  
2. 该对象具有嵌套结构——若大语言模型（LLM）未经过代码训练，嵌套结构可能使其更难保持逻辑连贯性。

3. 每个嵌套组件中的值，仅应从输入（响应或问题）中对应的部分推断得出。  
3. 每个嵌套组件中的值，仅应从输入（响应或问题）中对应的部分推断得出。

4. 它在一个任务中同时融合了分类（classification）、摘要（summarization）与结构化输出生成（structured output generation）。  
4. 它在一个任务中同时融合了分类（classification）、摘要（summarization）与结构化输出生成（structured output generation）。

如果“注意力机制即全部所需”（Attention is all you need），那么将模型的注意力分散于多个子任务之上，这种多任务目标对 LLM 在单次生成中完成全部要求而言，将构成显著挑战。  
如果“注意力机制即全部所需”（Attention is all you need），那么将模型的注意力分散于多个子任务之上，这种多任务目标对 LLM 在单次生成中完成全部要求而言，将构成显著挑战。

## Evaluation  

## 评估

This benchmark is focused on structure and classification, and as such, we don't need to use any LLM-as-judge metrics. Instead, we wrote custom LangSmith evaluators (see the [code definition here](https://github.com/langchain-ai/langchain-benchmarks/blob/4ddbbc0ff87fb4dfac3cb457dba56e64d8cbc9c6/langchain_benchmarks/extraction/tasks/chat_extraction/evaluators.py?ref=blog.langchain.com#L1)). Below is what we measured:  

该基准测试聚焦于结构化输出与分类能力，因此无需采用任何“以大语言模型为评判者”（LLM-as-judge）的评估指标。取而代之的是，我们编写了定制化的 LangSmith 评估器（参见[此处的代码定义](https://github.com/langchain-ai/langchain-benchmarks/blob/4ddbbc0ff87fb4dfac3cb457dba56e64d8cbc9c6/langchain_benchmarks/extraction/tasks/chat_extraction/evaluators.py?ref=blog.langchain.com#L1)）。以下为我们所测量的各项指标：

1. Structure verification  
1. 结构验证  

1. `json_schema`: 若解析输出符合任务预设 JSON Schema，则得分为 1；否则为 0。我们使用任务对应的 Schema 对各模型输出的解析结果进行校验。  
1. `json_schema`：若解析输出符合任务预设 JSON Schema，则得分为 1；否则为 0。我们使用任务对应的 Schema 对各模型输出的解析结果进行校验。

2. Classification tasks  
2. 分类任务  

1. `question_category`: 在全部 25 个有效枚举值上的分类准确率。  
1. `question_category`：在全部 25 个有效枚举值上的分类准确率。

2. `off_topic_similarity`: 二元分类准确率，用于衡量 LLM 是否正确判断用户问题是否偏离主题。  
2. `off_topic_similarity`：二元分类准确率，用于衡量 LLM 是否正确判断用户问题是否偏离主题。

3. `toxicity_similarity`: 用户问题被预测出的“毒性”（toxicity）等级与标注等级之间的归一化差值。  
3. `toxicity_similarity`：用户问题被预测出的“毒性”（toxicity）等级与标注等级之间的归一化差值。

4. `programming_language_similarity`: 对用户问题所涉及编程语言的预测分类准确率；多数情况下该值为 “unknown”（未知）。  
4. `programming_language_similarity`：对用户问题所涉及编程语言的预测分类准确率；多数情况下该值为 “unknown”（未知）。

5. `confidence_level_similarity`: 预测响应的“置信度”（confidence）与标注置信度之间的归一化相似度。  
5. `confidence_level_similarity`：预测响应的“置信度”（confidence）与标注置信度之间的归一化相似度。

6. `sentiment_similarity`: 预测情感得分与标注情感得分之间的归一化差值；情感被划分为三类：负面（0）、中性（1）、正面（2）。  
6. `sentiment_similarity`：预测情感得分与标注情感得分之间的归一化差值；情感被划分为三类：负面（0）、中性（1）、正面（2）。

3. Overall difference  
3. 整体差异  

1. `json_edit_distance`: 这是一个综合性指标：首先对预测 JSON 和标注 JSON 进行规范化（canonicalization），再计算二者序列化字符串之间的 Damerau-Levenshtein 编辑距离。  
1. `json_edit_distance`：这是一个综合性指标：首先对预测 JSON 和标注 JSON 进行规范化（canonicalization），再计算二者序列化字符串之间的 Damerau-Levenshtein 编辑距离。

## Experiments  

## 实验设计

In making this dataset, we wanted to answer a few questions:  

在构建该数据集的过程中，我们希望回答以下几个问题：

1. 当前最主流的闭源大语言模型表现如何？  
1. How do the most popular closed-source LLMs compare?  

2. 现成可用的开源大语言模型，其性能相较于闭源模型表现如何？  
2. How well do off-the-shelf open source LLMs perform relative to the closed-source models?  

3. 简单的提示工程（prompting）策略在提升信息抽取性能方面效果如何？  
3. How effective are simple prompting strategies improving extraction performance?  

4. 若我们通过控制 LLM 输出语法（grammar control）强制其生成合法记录，这一做法对各项分类指标的提升幅度有多大？  
4. If we control the LLM grammar to output a valid record, how significant is this for the individual classification metrics?  

We evaluated the following LLMs:  

我们评估了以下大语言模型：

- `gpt-4-1106-preview`：GPT-4 最新推出的长上下文、蒸馏版本。  
- `claude-2`：Anthropic 公司研发的大语言模型（LLM）。  
- `llama-v2-34b-code-instruct`：[Code Llama](https://github.com/facebookresearch/codellama?ref=blog.langchain.com) 2 的一个 340 亿参数变体，针对指令数据集进行了微调。  
- `llama-v2-chat-70b`：Llama 2 的一个 700 亿参数变体，专为对话场景微调。  
- `yi-34b-200k-capybara`：来自 [Nous Research](https://nousresearch.com/?ref=blog.langchain.com) 的一个 340 亿参数模型，基于 [parameter model](https://huggingface.co/NousResearch/Nous-Capybara-34B?ref=blog.langchain.com) 构建。

#### 实验 1：GPT vs. Claude

我们首先对比了两个闭源大语言模型——Claude-2 和 GPT-4。对于 GPT-4，我们使用了其函数调用（tool-calling）API，该 API 支持传入 JSON Schema，由模型自动填充结构化输出。由于 Anthropic 尚未发布类似的功能调用 API，我们尝试了两种不同的 Schema 指定方式：

1. 直接以 JSON Schema 形式提供；  
2. 以 XSD（XML Schema Definition）形式提供。

您可在 [关联的测试页面](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=dc7656d8-00ef-4048-9ce5-38ef72af593c%2C3f590999-a9d1-48be-83dd-e84acb99a195%2C0c022691-a7ac-4545-b2bc-58aab2d476e8&ref=blog.langchain.com) 中并排查看各模型的单条预测结果。下方亦提供了汇总图表与表格供参考：

confidence\_level\_similarityjson\_edit\_distancejson\_schemaoff\_topic\_similarityprogramming\_language\_similarityquestion\_categorysentiment\_similaritytoxicity\_similarity00.20.40.60.81

测试项|[claude-2-xsd-to-xml-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=dc7656d8-00ef-4048-9ce5-38ef72af593c)|[claude-2-json-schema-to-xml-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=3f590999-a9d1-48be-83dd-e84acb99a195)|[gpt-4-1106-preview-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=0c022691-a7ac-4545-b2bc-58aab2d476e8)|  
---|---|---|---|  
GPT-4 与 Claude 对比|指标|数值|

GPT-4 与 Claude 对比  

显示条目：10 / 25 / 50 / 100  

搜索：

| Test | confidence\_level\_similarity | json\_edit\_distance | json\_schema | off\_topic\_similarity | programming\_language\_similarity | question\_category | sentiment\_similarity | toxicity\_similarity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [claude-2-xsd-to-xml-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=dc7656d8-00ef-4048-9ce5-38ef72af593c&ref=blog.langchain.com) | 0.97 | 0.39 | 0.52 | 0.00 | 0.52 | 0.37 | 0.91 | 1.0 |
| [claude-2-json-schema-to-xml-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=3f590999-a9d1-48be-83dd-e84acb99a195&ref=blog.langchain.com) | 0.97 | 0.37 | 0.78 | 0.00 | 0.44 | 0.48 | 0.93 | 1.0 |
| [gpt-4-1106-preview-5689](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=0c022691-a7ac-4545-b2bc-58aab2d476e8&ref=blog.langchain.com) | 0.94 | 0.28 | 1.00 | 0.89 | 0.59 | 0.56 | 1.00 | 0.0 |

显示第 1 至 3 条，共 3 条记录

上一页 1 下一页

如预期所料，GPT-4 在几乎所有指标上均表现更优；而我们未能使 Claude 模型通过单次提示（single-shot）完美输出目标 Schema。有趣的是，使用 JSON Schema 提示的 Claude 模型，其表现略优于使用 XSD（XML Schema）提供相同信息所提示的版本，这表明：至少在此类任务中，Schema 的格式一致性并非决定性因素。

一些常见的 Schema 问题显而易见。例如，在[本次运行](https://smith.langchain.com/public/ad7ec13a-2e10-45f8-8e4f-9e46ca4c6595/r/7b340495-8a08-4805-81d7-a28050c94a97?ref=blog.langchain.com)和[另一次运行](https://smith.langchain.com/public/ab543c3f-894d-4d30-aba4-5a3629a76d23/r/0c99e258-afd4-4b61-9d33-63e07927edc3?ref=blog.langchain.com)中，模型将后续操作（follow-up actions）以项目符号列表（bullet-point list）形式输出，而非符合要求的带标签 XML 元素；该输出被解析为字符串（string），而非列表（list）。下图即为此类问题的示例：

![](images/extraction-benchmarking/img_003.png)Schema 错误

尽管我们可以逐案修复此类解析错误，但其不可预测性严重削弱了整体开发体验。由于解析器及其他行为缺乏一致性，将一个抽取链（extraction chain）适配至另一项任务时需付出更高成本。此外，XML 语法本身也会显著增加 Claude 相对于 GPT 的 token 消耗量。虽然不同模型的“token”定义并不直接可比，但冗长的语法通常会导致响应速度变慢、成本升高。

#### Experiment 2: Open-Source Models  
#### 实验 2：开源模型

接下来，我们希望对主流开源模型进行开箱即用（off-the-shelf）基准测试，并首先在三个模型上对比了同一基础提示词（basic prompt）的表现：

- `llama-v2-34b-code-instruct` —— [Code Llama](https://github.com/facebookresearch/codellama?ref=blog.langchain.com) 2 的一个 34B 参数变体，经指令微调（fine-tuned on an instruction dataset）；
- `llama-v2-chat-70b` —— Llama 2 的一个 70B 参数变体，专为对话任务微调；
- `yi-34b-200k-capybara` —— 由 [Nous Research](https://nousresearch.com/?ref=blog.langchain.com) 发布的一个 34B 参数模型（[model page](https://huggingface.co/NousResearch/Nous-Capybara-34B?ref=blog.langchain.com)）。

Check out the [linked comparisons](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c%2C2bb03041-c9e5-4040-bf4f-81b19e5c2ad4%2Ccd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) to see the outputs in LangSmith, or reference the aggregate metrics below:

请查看[关联的对比结果](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c%2C2bb03041-c9e5-4040-bf4f-81b19e5c2ad4%2Ccd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com)，在 LangSmith 中查看各模型输出，或参考下方汇总指标：

confidence\_level\_similarityjson\_edit\_distancejson\_schemaoff\_topic\_similarityprogramming\_language\_similarityquestion\_categorysentiment\_similaritytoxicity\_similarity00.51

confidence\_level\_similarity  
json\_edit\_distance  
json\_schema  
off\_topic\_similarity  
programming\_language\_similarity  
question\_category  
sentiment\_similarity  
toxicity\_similarity  
0  
0.51  

Test[yi-34b-200k-capybara-5d76-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c)[llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81)[llama-v2-34b-code-instruct-bcce-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=2bb03041-c9e5-4040-bf4f-81b19e5c2ad4)Compare Baseline OSS ModelsMetricValue


测试模型  
[yi-34b-200k-capybara-5d76-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c)  
[llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81)  
[llama-v2-34b-code-instruct-bcce-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=2bb03041-c9e5-4040-bf4f-81b19e5c2ad4)  
基线开源模型对比  
指标（Metric）  
数值（Value）

Compare Baseline OSS Models

基线开源模型对比

Show 102550100 entries

显示 10 / 25 / 50 / 100 条记录

Search:

搜索：

| Test | confidence\_level\_similarity | json\_edit\_distance | json\_schema | off\_topic\_similarity | programming\_language\_similarity | question\_category | sentiment\_similarity | toxicity\_similarity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [yi-34b-200k-capybara-5d76-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c&ref=blog.langchain.com) | -0.30 | 0.16 | 0.37 | 0.41 | 0.15 | 0.15 | 0.28 | 0.41 |
| [llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) | 0.30 | 0.43 | 0.04 | 0.30 | 0.15 | 0.04 | 0.30 | 0.00 |
| [llama-v2-34b-code-instruct-bcce-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=2bb03041-c9e5-4040-bf4f-81b19e5c2ad4&ref=blog.langchain.com) | 0.93 | 0.41 | 0.89 | 0.89 | 0.44 | 0.07 | 0.59 | 1.00 |

| 测试模型 | confidence\_level\_similarity | json\_edit\_distance | json\_schema | off\_topic\_similarity | programming\_language\_similarity | question\_category | sentiment\_similarity | toxicity\_similarity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [yi-34b-200k-capybara-5d76-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=fe0a7d34-ac77-4674-97ab-11cf3b999f7c&ref=blog.langchain.com) | -0.30 | 0.16 | 0.37 | 0.41 | 0.15 | 0.15 | 0.28 | 0.41 |
| [llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) | 0.30 | 0.43 | 0.04 | 0.30 | 0.15 | 0.04 | 0.30 | 0.00 |
| [llama-v2-34b-code-instruct-bcce-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=2bb03041-c9e5-4040-bf4f-81b19e5c2ad4&ref=blog.langchain.com) | 0.93 | 0.41 | 0.89 | 0.89 | 0.44 | 0.07 | 0.59 | 1.00 |

Showing 1 to 3 of 3 entries

共 3 条记录，当前显示第 1–3 条

Previous1Next

上一页　1　下一页

Despite its larger model size, the 70B variant of Llama 2 did not reliably output JSON, since the amount of code included in its pretraining and SFT corpus was low. Yi-34b was more reliable in this regard, but it still only matched the required schema 37% of the time. It also performs better on the hardest of the classification tasks, the `question_category` classification.

尽管 Llama 2 的 70B 版本参数量更大，但由于其预训练数据集和监督微调（SFT）语料中包含的代码量较少，它无法稳定地输出 JSON 格式结果。相比之下，Yi-34b 在该任务上表现更可靠，但仍仅有 37% 的概率能准确匹配目标 JSON Schema。此外，在所有分类任务中难度最高的一项——`question_category`（问题类别）分类任务上，Yi-34b 的表现也优于其他两个模型。

The 34B Code Llama 2 was able to output valid JSON and did a decent job for the other metrics, so we will use it as the baseline for the following prompt experiments.

34B Code Llama 2 能够输出有效的 JSON，并在其他各项指标上表现尚可，因此我们将以其作为后续提示工程实验的基线模型。

#### Experiment 3: Prompting for Schema Compliance

#### 实验 3：面向 Schema 合规性的提示工程

Of the three open model baselines, the 34B Code Llama 2 variant performed the best. Because of this, we selected it to answer the question "how well do simple prompting techniques work in getting the model to output reliably structured JSON" (hint: not very well). You can re-run the experiments using [this notebook](https://github.com/hinthornw/llama-extraction/blob/main/llama_extraction.ipynb?ref=blog.langchain.com).

在三个开源模型基线中，34B Code Llama 2 变体表现最佳。正因如此，我们选定它来回答这一问题：“简单的提示技术在促使模型稳定输出结构化 JSON 方面效果如何？”（提示：效果并不理想）。您可通过 [此 Notebook](https://github.com/hinthornw/llama-extraction/blob/main/llama_extraction.ipynb?ref=blog.langchain.com) 重新运行全部实验。

In the baseline experiments, the most common failure mode was hallucination of invalid Enum values (see for example, this [run](https://smith.langchain.com/public/c653ce8d-dedd-41cf-828c-00dcd0403a8e/r/e7a38f0c-af73-492f-930b-d6b0ba256f41?ref=blog.langchain.com)), as well as poor classification performance for simple things like question sentiment.

在基线实验中，最常见的失败模式是模型“幻觉”出无效的枚举（Enum）值（例如参见此次 [运行记录](https://smith.langchain.com/public/c653ce8d-dedd-41cf-828c-00dcd0403a8e/r/e7a38f0c-af73-492f-930b-d6b0ba256f41?ref=blog.langchain.com)），此外，对于诸如问题情感倾向等简单分类任务，模型的表现也较差。

We tested three prompting strategies to see how they impact the aggregate performance:

我们测试了三种提示策略，以评估它们对整体性能的影响：

1. Adding additional task-specific instructions: the schema already has descriptions for each value, but we wanted to see if additional instructions to e.g., carefully select a valid Enum values from the list, would help. We had tested this approach on a couple of playground examples and saw that it could occasionally help.

1. 增加面向任务的补充说明：Schema 中已为每个字段值提供了描述，但我们希望验证——额外加入诸如“请谨慎地从给定列表中选择一个有效的 Enum 值”等指令是否能提升效果。我们在若干 Playground 示例中测试过该方法，发现其偶尔确实有效。

2. Chain-of-thought: Ask the model to think step by step about the schema structure before generating the final output.

2. 思维链（Chain-of-Thought）：要求模型在生成最终输出前，分步骤思考 Schema 的结构。

3. Few-shot examples: We hand-crafted expected input-output pairs for the model to follow, in addition to the explicit instructions and schema. Sometimes LLMs (like people) learn better by seeing a few examples rather than from instructions.

3. 少样本示例（Few-shot Examples）：除明确的指令与 Schema 外，我们还人工构造了若干输入–输出对供模型参考。有时，大语言模型（如同人类）通过观察几个示例，比仅依赖文字指令更能有效学习。

Below are the results:

以下是实验结果：

confidence\_level\_similarityjson\_edit\_distancejson\_schemaoff\_topic\_similarityprogramming\_language\_similarityquestion\_categorysentiment\_similaritytoxicity\_similarity00.20.40.60.81

置信度相似度｜JSON 编辑距离｜JSON Schema 合规性｜离题相似度｜编程语言相似度｜问题类别｜情感相似度｜毒性相似度  
0　　0.2　　0.4　　0.6　　0.8　　1  

Testbaselineinstructionsfew-shotCoTCompare Prompt Strategies for OSS ModelsMetricValue


对比开源模型的各类提示策略  
指标｜数值  

Compare Prompt Strategies for OSS Models

Show 102550100 entries

显示 10、25、50、100 条记录

Search:

搜索：

| Test | Prompt | confidence\_level\_similarity | json\_edit\_distance | json\_schema | off\_topic\_similarity | programming\_language\_similarity | question\_category | sentiment\_similarity | toxicity\_similarity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [llama-v2-34b-code-instruct-bcce-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=2bb03041-c9e5-4040-bf4f-81b19e5c2ad4&ref=blog.langchain.com) | baseline | 0.93 | 0.41 | 0.89 | 0.89 | 0.44 | 0.07 | 0.59 | 1.00 |
| [llama-v2-34b-code-instruct-e20e-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=0dbfb2d9-f53c-4d73-9eb7-db3bd2c1a0c8&ref=blog.langchain.com) | instructions | 0.95 | 0.38 | 0.96 | 0.89 | 0.63 | 0.11 | 0.54 | 1.00 |
| [llama-v2-34b-code-instruct-34b8-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=379cfcd2-ddc1-4866-9d41-9d59733ddfc1&ref=blog.langchain.com) | few-shot | 0.89 | 0.38 | 0.59 | 0.85 | 0.33 | 0.07 | 0.85 | 0.96 |
| [llama-v2-34b-code-instruct-d3a3-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=f085918d-085e-41f1-8ce1-b80382a1d291&ref=blog.langchain.com) | CoT | 0.97 | 0.42 | 0.85 | 0.85 | 0.44 | 0.04 | 0.57 | 0.81 |

Showing 1 to 4 of 4 entries

共 4 条记录，当前显示第 1 至第 4 条

Previous1Next

上一页 1 下一页

None of the prompting strategies demonstrate meaningful improvements on the metrics in question. The few-shot examples technique even decreases performance of the model on the JSON Schema test (see: [example](https://smith.langchain.com/public/dd49c66e-e0e7-4aaf-ab6a-c80b55764698/r/1f225651-1a54-4c33-8d30-752677f5c430?ref=blog.langchain.com)). This may be because we are increasing the amount of content in the prompt that distracts from the raw schema. Making the instructions explicit does seem to improve the performance of the programming language classification, since the model is instructed to focus on the question. The contribution is minor, however, and for the sentiment classification metric, the model continues to get distracted by the _response_ sentiment.

所测试的各类提示策略均未在相关评估指标上展现出显著提升。其中，“少样本示例（few-shot）”方法甚至导致模型在 JSON Schema 测试中的表现下降（参见：[示例](https://smith.langchain.com/public/dd49c66e-e0e7-4aaf-ab6a-c80b55764698/r/1f225651-1a54-4c33-8d30-752677f5c430?ref=blog.langchain.com)）。这可能是因为我们在提示词中加入了过多内容，反而干扰了模型对原始 Schema 的聚焦。相比之下，将指令显式化（instructions）确实在编程语言分类任务上带来了一定性能提升——因为此时模型被明确要求关注问题本身；但该提升幅度有限。而在情感分类（sentiment classification）指标上，模型仍持续受到**响应内容自身情感倾向**的干扰。

#### Experiment 4: Structured Decoding

#### 实验 4：结构化解码（Structured Decoding）

Since none of the prompting techniques offer a significant boost to the structure of the model output, we wanted to test other ways to reliably generate schema-compliant JSON. Specifically, we wanted to apply structured decoding techniques such as logit biasing / [constraint-based](https://github.com/ggerganov/llama.cpp/pull/1773?ref=blog.langchain.com) sampling. For a survey on guided text generation, check out Lilian Weng's [excellent post.](https://lilianweng.github.io/posts/2021-01-02-controllable-text-generation/?ref=blog.langchain.com)

鉴于前述各类提示工程方法均未能显著改善模型输出的结构合规性，我们转而探索其他可稳定生成符合 Schema 规范的 JSON 的技术路径。具体而言，我们尝试采用结构化解码（structured decoding）技术，例如 logits 偏置（logit biasing）或基于约束（[constraint-based](https://github.com/ggerganov/llama.cpp/pull/1773?ref=blog.langchain.com)）的采样方法。关于可控文本生成（guided text generation）的综述，推荐阅读 Lilian Weng 的这篇[优秀博文](https://lilianweng.github.io/posts/2021-01-02-controllable-text-generation/?ref=blog.langchain.com)。

In this experiment, we test [Llama 70B](https://replicate.com/andreasjansson/llama-2-70b-chat-gguf?ref=blog.langchain.com) using Llama.cpp's grammar-based [decoding mechanism](https://github.com/ggerganov/llama.cpp/blob/master/grammars/README.md?ref=blog.langchain.com) to guarantee a valid JSON schema. See the comparison with the baseline [here](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a%2Ccd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) and in the table below.

本实验中，我们使用 Llama.cpp 提供的基于语法规则（grammar-based）的[解码机制](https://github.com/ggerganov/llama.cpp/blob/master/grammars/README.md?ref=blog.langchain.com)，对 [Llama 70B](https://replicate.com/andreasjansson/llama-2-70b-chat-gguf?ref=blog.langchain.com) 模型进行测试，以确保其输出严格符合 JSON Schema 规范。与基线模型的对比结果可参见[此处](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a%2Ccd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com)，亦见下表。

confidence\_level\_similarityjson\_edit\_distancejson\_schemaoff\_topic\_similarityprogramming\_language\_similarityquestion\_categorysentiment\_similaritytoxicity\_similarity00.20.40.60.81

confidence\_level\_similarity  
置信度相似度  
json\_edit\_distance  
JSON 编辑距离  
json\_schema  
JSON Schema 合规性  
off\_topic\_similarity  
离题相似度  
programming\_language\_similarity  
编程语言相似度  
question\_category  
问题类别  
sentiment\_similarity  
情感相似度  
toxicity\_similarity  
毒性相似度  
0  
0  
0.2  
0.2  
0.4  
0.4  
0.6  
0.6  
0.8  
0.8  
1  
1

Test[llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81)[llama-gguf-1f95-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a)Compare Baseline vs. Grammar-based DecodingMetricValue

测试 [llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81)[llama-gguf-1f95-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a) 基线模型 vs. 基于语法规则的解码对比  
指标值

Compare Baseline vs. Grammar-based Decoding

基线模型 vs. 基于语法规则的解码对比

Show 102550100 entries

显示 10 / 25 / 50 / 100 条记录

Search:

搜索：

| Test | Decoding | confidence\_level\_similarity | json\_edit\_distance | json\_schema | off\_topic\_similarity | programming\_language\_similarity | question\_category | sentiment\_similarity | toxicity\_similarity |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) | baseline | 0.30 | 0.43 | 0.04 | 0.30 | 0.15 | 0.04 | 0.3 | 0.0 |
| [llama-gguf-1f95-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a&ref=blog.langchain.com) | structured | 0.93 | 0.44 | 1.00 | 0.89 | 0.37 | 0.26 | 1.0 | 1.0 |

| 测试模型 | 解码方式 | 置信度等级相似度 | JSON 编辑距离 | JSON Schema 合规性 | 话题偏离相似度 | 编程语言相似度 | 问题类别匹配度 | 情感相似度 | 毒性内容相似度 |
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
| [llama-v2-70b-chat-28a7-v1](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=cd595a34-012c-4df2-849e-a7e2908d4c81&ref=blog.langchain.com) | 基线解码（baseline） | 0.30 | 0.43 | 0.04 | 0.30 | 0.15 | 0.04 | 0.3 | 0.0 |
| [llama-gguf-1f95-v2](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d/compare?selectedSessions=d522dbfc-c09b-45a9-b11e-26aa95a3555a&ref=blog.langchain.com) | 结构化解码（structured） | 0.93 | 0.44 | 1.00 | 0.89 | 0.37 | 0.26 | 1.0 | 1.0 |

Showing 1 to 2 of 2 entries

共 2 条记录，当前显示第 1 至 2 条

Previous1Next

上一页 1 下一页

The most noticeable (and expected) improvement is that the `json_schema` correctness went from almost never correct to 100% validity. This means that the other values also could be reliably parsed, leading to fewer 0's in these fields. Since the base Llama 70B chat model is also larger and more capable than our previous 34B model experiments, we can see improvements in the sentiment similarity and question category as well. However, the absolute performance in these metrics is still low. Grammar-based decoding makes the output structure guaranteed, but it alone is insufficient to guarantee the quality of the values themselves.

最显著（且符合预期）的提升在于 `json_schema` 合规性指标——从几乎从不正确跃升至 100% 有效。这意味着其他字段的值也能被稳定、可靠地解析，从而大幅减少了这些字段中出现“0”的情况。此外，由于本次所用的基础 Llama 70B 聊天模型本身比我们此前实验中使用的 34B 模型规模更大、能力更强，我们在情感相似度（sentiment similarity）和问题类别匹配度（question category）等指标上也观察到了一定提升。然而，这些指标的绝对表现水平仍较低。基于语法规则的解码可确保输出结构的确定性，但仅靠该方法尚不足以保障各字段具体取值的质量。

#### Full Results

#### 完整结果

For the full results for the above experiments, check out the [LangSmith test link](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com). You can also run any of these benchmarks against your own model by following the notebook [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/chat_extraction.html?ref=blog.langchain.com).

如需查看上述实验的完整结果，请访问 [LangSmith 测试链接](https://smith.langchain.com/public/00f4444c-9460-4a82-b87a-f50096f1cfef/d?ref=blog.langchain.com)。您也可通过运行 [此处提供的 Notebook](https://langchain-ai.github.io/langchain-benchmarks/notebooks/extraction/chat_extraction.html?ref=blog.langchain.com)，将任一基准测试应用于您自己的模型。

### Tags

### 标签


[![Applying OpenAI's RAG Strategies](images/extraction-benchmarking/img_004.png)](https://blog.langchain.com/applying-openai-rag/)

[**Applying OpenAI's RAG Strategies**](https://blog.langchain.com/applying-openai-rag/)


[![LangServe Playground and Configurability](images/extraction-benchmarking/img_005.png)](https://blog.langchain.com/langserve-playground-and-configurability/)

[**LangServe Playground and Configurability**](https://blog.langchain.com/langserve-playground-and-configurability/)


[![A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG](images/extraction-benchmarking/img_006.png)](https://blog.langchain.com/a-chunk-by-any-other-name/)

[**A Chunk by Any Other Name: Structured Text Splitting and Metadata-enhanced RAG**](https://blog.langchain.com/a-chunk-by-any-other-name/)


[**The Prompt Landscape**](https://blog.langchain.com/the-prompt-landscape/)


[![Building Chat LangChain](images/extraction-benchmarking/img_007.png)](https://blog.langchain.com/building-chat-langchain-2/)

[**Building Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)

[**构建 Chat LangChain**](https://blog.langchain.com/building-chat-langchain-2/)