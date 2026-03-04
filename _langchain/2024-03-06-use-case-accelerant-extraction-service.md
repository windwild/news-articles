---
render_with_liquid: false
title: "Use Case Accelerant: Extraction Service"
source: "LangChain Blog"
url: "https://blog.langchain.com/use-case-accelerant-extraction-service/"
date: "2024-03-06"
scraped_at: "2026-03-03T08:09:46.799036607+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

Today we’re excited to announce our newest OSS use-case accelerant: an [extraction](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) [service](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com). LLMs are a powerful tool for extracting structured data from unstructured sources. We've improved our [support for data extraction](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) in the open source LangChain library over the past few releases, and now we’re taking that a step further with a starter repository to help you build your own extraction application.

今天我们很高兴地宣布我们最新的开源（OSS）用例加速器：一个[抽取](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) [服务](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)。大语言模型（LLMs）是从未结构化数据源中抽取结构化数据的强大工具。在最近几次发布中，我们持续增强了开源 LangChain 库中对[数据抽取](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com)的支持；如今，我们更进一步，推出一个入门级代码仓库，助您快速构建专属的数据抽取应用。

[The starter repository](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) includes a bare-bones web application that can be extended to build a self-service extraction application that can be used by non-technical users in your organization to leverage the power of LLMs for data extraction.

[该入门代码仓库](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)包含一个极简的 Web 应用框架，可在此基础上扩展开发自助式数据抽取应用，使贵组织中的非技术人员也能轻松利用大语言模型（LLMs）完成数据抽取任务。

We'll discuss the extraction service in more detail below, but first, let's discuss the extraction use case and how LLMs can help.

下文我们将更详细地介绍该抽取服务；但在此之前，让我们先探讨“数据抽取”这一典型用例，以及大语言模型（LLMs）如何赋能该场景。

## The Extraction Use Case

## 数据抽取用例

Enterprises spend substantial resources and effort to derive valuable insights from unstructured data sources, which encompass documents such as PDFs and PowerPoint presentations, websites, and other textual information like product reviews and customer feedback.

企业投入大量资源与人力，从各类非结构化数据源中挖掘高价值洞见——这些数据源包括 PDF 文档、PowerPoint 演示文稿、网站页面，以及其他文本类信息，例如产品评论和客户反馈。

Commonly deployed extraction solutions tend to rely on a mixture of approaches that involve manual work done by people, and automated extraction done using either hand-crafted rules or custom fine-tuned ML models.

当前主流的抽取方案通常混合采用多种方法：既有人工参与的手动处理环节，也有基于人工编写的规则或定制微调的机器学习（ML）模型实现的自动化抽取。

For automated solutions, companies have been shifting away from rule-based methodologies to machine learning (ML)-based solutions, recognizing that ML-driven approaches typically offer greater scalability and maintainability in their systems.

在自动化方案层面，企业正逐步从基于规则的方法转向基于机器学习（ML）的方案，因为后者通常能为系统带来更强的可扩展性与可维护性。

The main problem with previous generations of ML-based solutions is that they often require significant effort to build and maintain, as well as a significant amount of labeled data to train the models.

上一代基于机器学习的抽取方案面临的主要问题在于：其构建与维护成本高昂，且往往需要海量标注数据来训练模型。

Large Language Models (LLMs) have emerged as a capable new ML technology that can help power information extraction applications. LLMs can be adapted for specific extraction tasks just by providing appropriate instructions to them (in the form of a prompt) and appropriate reference examples. As a result, LLMs significantly reduce the barrier to adopt an AI first approach to information extraction.

大语言模型（LLMs）作为一种新兴且能力强大的机器学习技术，正成为驱动信息抽取应用的关键力量。LLMs 只需通过恰当的指令（即提示词，prompt）与适配的参考样例，即可快速适配特定抽取任务。因此，LLMs 极大地降低了企业以“AI 优先”方式开展信息抽取的门槛。

The new generation of solutions to information extraction will be built on top of LLMs. Such solutions will still involve human-in-the-loop to provide feedback and guidance to the LLMs, and some amount of custom rules and heuristics to handle edge cases. Such solutions will still require a workflow tool to manage the data extraction and validation process. But such solutions will become significantly more scalable and maintainable than the previous generations of solutions.

新一代信息抽取解决方案将以大语言模型（LLMs）为核心构建。这类方案仍将保留“人在环路中”（human-in-the-loop）机制，由人工向 LLMs 提供反馈与指导；同时仍需引入部分自定义规则与启发式逻辑，以应对边界情况；也依然需要工作流工具来统筹管理数据抽取与校验流程。但相比前几代方案，此类新方案将具备显著更高的可扩展性与可维护性。

## LLMs to the Rescue

## 大语言模型来救场

How do you use an LLM for information extraction? Here, we’ll outline the essential components and high level and high level considerations that should go into building an extraction service.

如何利用大语言模型（LLM）进行信息抽取？本文将概述构建信息抽取服务所需的核心组件及高层次考量要点。

#### The raw data

#### 原始数据

Extracting information using an LLM starts with the data you wish to extract from, which first needs to be converted into a text format. LangChain contains [hundreds of document loaders](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.com) that you can use to parse files like PDFs and convert to a textual format.

使用大语言模型进行信息抽取，始于你希望从中提取信息的原始数据；而这些数据首先需被转换为纯文本格式。LangChain 提供了[数百种文档加载器](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.com)，可用于解析 PDF 等各类文件，并将其转化为文本格式。

After loading the text, you need to decide how to present it to the LLM. The simplest thing to do is to present the entire text to the LLM. This is great for small pieces of text, but has several pitfalls for longer texts. First, it may not all fit into the context window. Second, assuming it does, most language models perform worse on longer inputs, so putting it all in context may yield worse results. Third, even if the results are comparable, the inference time will take a while.

完成文本加载后，你需要决定如何将其呈现给大语言模型。最简单的方法是将整段文本一次性输入模型。这对短文本效果很好，但对长文本存在若干明显缺陷：第一，整段文本可能超出模型的上下文窗口容量；第二，即便勉强塞入，大多数语言模型在处理长输入时性能会下降，导致结果质量降低；第三，即使最终效果相近，推理耗时也会显著增加。

A more sophisticated approach involves segmenting the text into chunks and processing only the relevant ones through the LLM. This of course introduces the complication of having to decide which chunks are relevant. Alternatively, you could extract content from all the chunks in parallel which will guarantee you don’t miss any relevant chunks. Either way you will need to decide how to best combine results from across the chunks and how to deal with information that’s been broken up across separate chunks.

更成熟的做法是将文本切分为多个片段（chunks），仅将其中相关片段送入大语言模型处理。但这自然引出了一个新难题：如何准确判断哪些片段是相关的？另一种替代方案是并行处理所有片段，从而确保不遗漏任何潜在相关信息。无论采用哪种策略，你都需要决定如何最优地整合各片段的抽取结果，以及如何处理被拆分到不同片段中的关联信息。

#### Describe what you want

#### 明确你想要什么

If you want the LLM to extract information effectively, you need to provide it with a description of what you want extracted.

若希望大语言模型高效完成信息抽取任务，你必须向其清晰说明你期望抽取的内容。

Such a description can be broken down into three key components:

此类说明可分解为三个关键组成部分：

1\. A schema that describes the structure of the data you want to extract.

1. 一份描述你希望抽取的数据结构的模式（schema）。

2. 一个提供抽取任务上下文、并对大语言模型（LLM）进行提示引导的 prompt。

3. 参考示例，即从文本中抽取结果的实际样例。

#### 如何使其生效

以上是构成该方法的几个核心组件，但具体该如何实现呢？

这里我们想介绍两个简单却极为有力的关键思路。

第一个关键思路是确保 LLM 以正确的格式输出结果。即使你在 prompt 中明确要求 LLM 输出 JSON 格式，它也未必总能严格遵守。而“函数调用”（function calling）作为一种新兴机制，已成为一种相对可靠的方式，可强制 LLM 输出指定结构化格式。我们建议在实际应用中采用该方式，以提升整体性能。

请参阅 [结构化输出文档](https://python.langchain.com/docs/guides/structured_output?ref=blog.langchain.com)，其中介绍了 LangChain 提供的高层级 API，展示了如何针对不同 LLM 实现工具调用 / 函数调用。

另一个提升性能的实用技巧是使用参考示例。虽然你完全可以不提供任何参考示例就搭建一个信息抽取任务，但在实践中我们发现：为 LLM 提供若干输入文本及其对应抽取结果的样例，往往效果显著——这些示例通常比纯文字指令更能清晰地指导 LLM 如何应对各类具体场景。

更多技术细节请参阅 [信息抽取用例文档](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com)，该文档将助你充分释放 LLM 的抽取性能潜力。

## 服务

With this in mind, what exactly does our [extraction service](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) provide?

考虑到这一点，我们的 [提取服务](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) 到底提供了哪些功能？

The service is built on top of FastAPI and Postgresql. It exposes a standard REST API, and comes with a docker-compose file to help you spin up the stack quickly. The service is a bare-bones web application that can be extended to create an extraction application for non-technical users in your organization. This is essentially boilerplate that you can use to jumpstart your application development. Alternatively, you can just use it as is for your own extraction workflows without doing any further development.

该服务基于 FastAPI 和 PostgreSQL 构建，对外提供标准的 REST API，并附带一个 `docker-compose` 文件，助您快速启动整套服务。该服务是一个轻量级的 Web 应用，可进一步扩展，为贵组织中的非技术人员构建专属的数据提取应用。本质上，它是一套开箱即用的脚手架代码，可显著加速您的应用开发进程；当然，您也可以直接将其用于自身的提取工作流，无需任何额外开发。

The API allows defining and persisting "extractors" which contain the key components needed to configure an LLM for extraction. These components include a schema that describes the structure of the data you want to extract, a prompt that provides context for the extraction and primes the model, and reference examples that show the model some examples of extractions.

该 API 支持定义并持久化“提取器（extractors）”，其中封装了配置大语言模型（LLM）以执行提取任务所需的核心组件。这些组件包括：描述待提取数据结构的 Schema、为提取任务提供上下文并引导模型行为的 Prompt，以及若干参考示例（reference examples），用于向模型展示典型的数据提取结果。

In addition, the API exposes an extraction endpoint that allow you to submit files for extraction using an existing extractor, and a second variant of the endpoint that allows you to use a RemoteRunnable to easily use the service as part of a larger LangChain Expression Language (LCEL) chain.

此外，该 API 提供了一个提取端点（extraction endpoint），支持使用已有的提取器提交文件进行提取；还提供了该端点的另一种变体，允许您通过 `RemoteRunnable` 轻松将本服务集成至更大型的 LangChain 表达式语言（LCEL）链中。

The service is pre-configured with a MIME-type based parser and supports parsing of PDFs and HTML files. You can easily extend this to support other types of files (e.g., PowerPoint) using existing [LangChain document loaders and parsers](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.com).

该服务已预置基于 MIME 类型的解析器，原生支持 PDF 和 HTML 文件的解析。您还可借助现有的 [LangChain 文档加载器与解析器](https://python.langchain.com/docs/integrations/document_loaders?ref=blog.langchain.com)，轻松扩展以支持其他类型文件（例如 PowerPoint）。

One key decision we’ve made for the extraction API is that we’ve designed it to always extract multiple entities. This is usually the desired behavior when extracting from text because it allows the model to extract multiple entities if they’re present, and also because it allows the model to extract no entities if the text contains no relevant information.

我们在设计提取 API 时做出了一项关键决策：始终支持多实体提取。这通常是文本提取场景下的理想行为——既允许模型在文本中存在多个目标实体时一并提取，也允许模型在文本不包含任何相关信息时返回空结果。

How do you actually use this service?

那么，您究竟该如何实际使用这项服务呢？

Building off the above, there are a few usage considerations. You can use JSON schema to define exactly what to extract. You can specify examples that will be incorporated to improve the quality of extracted results. You can either specify these when invoking the API, or you can create and save extractors and examples in a database. This will make it easy to save and share extractors. In terms of passing in the text, you can either pass in raw text or binary files.

基于上述特性，实际使用时需考虑以下几点：您可通过 JSON Schema 精确定义需要提取的内容；可通过指定参考示例来提升提取结果的质量；这些 Schema 和示例既可在调用 API 时动态传入，也可预先创建并保存至数据库中，从而便于复用与共享提取器。至于输入文本，您既可传入纯文本（raw text），也可直接上传二进制文件（binary files）。

## Example

## 示例

Let’s take a look at an example of how to use this service.

我们来看一个该服务的实际使用示例。

First, you can [create an extractor](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.com#create-an-extractor):

首先，您可以 [创建一个提取器](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.com#create-an-extractor)：

```python
curl -X 'POST' \
  'http://localhost:8000/extractors' \
  -H 'accept: application/json' \
  -H 'Content-Type: application/json' \
  -d '{
  "name": "Personal Information",
  "description": "Use to extract personal information",
  "schema": {
      "type": "object",
      "title": "Person",
      "required": [\
        "name",\
        "age"\
      ],
      "properties": {
        "age": {
          "type": "integer",
          "title": "Age"
        },
        "name": {
          "type": "string",
          "title": "Name"
        }
      }
    },
  "instruction": "Use information about the person from the given user input."
}'
```

What is this doing?

这段代码在做什么？

First, we are sending a name parameter to the service - this is just a simple human readable name for the extractor we are creating, not to be used by the LLM. Likewise, the description parameter is just for tracking purposes, not used in any way.

首先，我们向服务发送一个 `name` 参数——这只是为当前正在创建的提取器指定一个便于人类阅读的名称，并不会被大语言模型（LLM）使用。同理，`description` 参数仅用于追踪和管理目的，服务内部并不会使用它。

The schema parameter is used by the service. This is the JSON schema representing the schema of the objects we are trying to extract. We are extracting a Person schema, with two attributes, both of which are required: age (an integer) and name (a string).

`schema` 参数由服务使用。它是一个 JSON Schema，用于定义我们希望提取的对象结构。此处我们定义的是一个 `Person` 类型的结构，包含两个必需字段：`age`（整数类型）和 `name`（字符串类型）。

The instruction parameter is also used by the service. These instructions are sent to the LLM along with the schema and the text and can provide additional context and instruction for how the LLM should behave.

`instruction` 参数同样由服务使用。这些指令会与 schema 和待处理文本一同发送给大语言模型（LLM），为其提供额外的上下文和行为指引。

When we send this, we get back a response corresponding to the id of the extractor we just created:

当我们发送该请求后，将收到一个响应，其中包含刚刚创建的提取器的唯一标识符（ID）：

```python
{
  "uuid": "32d5324a-8a48-4073-b57c-0a2ebfb0bf5e"
}
```

After having registered it, we can then [invoke it](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.com#create-an-extractor):

注册完成后，我们即可 [调用该提取器](https://github.com/langchain-ai/langchain-extract?tab=readme-ov-file&ref=blog.langchain.com#create-an-extractor)：

```python
curl -s -X 'POST' \
'http://localhost:8000/extract' \
-H 'accept: application/json' \
-H 'Content-Type: multipart/form-data' \
-F 'extractor_id=32d5324a-8a48-4073-b57c-0a2ebfb0bf5e' \
-F 'text=my name is chester and i am 20 years old. My name is eugene and I am 1 year older than chester.' \
-F 'mode=entire_document' \
-F 'file=' | jq .
```

We are passing in an extractor_id - this is the id returned from the step before.

我们传入一个 `extractor_id` —— 这是上一步操作返回的 ID。

We also pass in text - this is the text to extract information from.

我们还传入 `text` —— 即需要从中提取信息的文本。

We specify mode=entire_document. This is telling the service to extract from the whole document. If the text we were extracting from was larger, we may want to handle it differently - this is where we control that parameter.

我们指定 `mode=entire_document`。这表示要求服务对整份文档执行信息提取。如果待提取的文本体量更大，我们可能需要采用不同的处理方式——该参数正是用于控制这一行为的。

Finally, we pass a file with an empty value. This service also accepts file uploads, but we are not using that here.

最后，我们传入一个值为空的 `file` 参数。该服务也支持文件上传，但本例中并未使用该功能。

We get back the following response:

我们收到如下响应：

```python
{
  "data": [\
    {\
      "name": "chester",\
      "age": 20\
    },\
    {\
      "name": "eugene",\
      "age": 21\
    }\
  ]
}
```

## Conclusion

## 总结

In this blog we’ve introduced the idea of using LLMs to extract structured data from unstructured text, introduced our fully [open source repository](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) that exposes a service to do this, and ran through a relatively simple example of how to use it. For more complex examples, you can check out the [readme](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com) of the service. For information on how to do extraction using LangChain without using this service, you can check out our updated [use case documentation](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com). Over the next week or so we will be adding a relatively simple frontend for this service and exposing a hosted version of it. We’d love any feedback!

本文博客介绍了利用大语言模型（LLM）从非结构化文本中提取结构化数据的理念；推出了我们完全开源的 [langchain-extract 仓库](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)，其中封装了实现该功能的服务；并演示了一个相对简单的使用示例。如需更复杂的用例，请参阅该服务的 [README 文档](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)。若希望不依赖该服务、而直接使用 LangChain 实现信息提取，可查阅我们更新后的 [用例文档](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com)。在未来一周左右，我们将为该服务添加一个简易前端，并上线托管版本（hosted version）。诚挚欢迎您的任何反馈！

Additional Resources:

其他资源：

- [LangChain-extract](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) \- the repository that contains the service code  
- [LangChain-extract](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) —— 包含该服务源代码的仓库

- [LangChain Extraction documentation](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) – documentation that shows how to do extraction using LangChain  
- [LangChain 提取功能文档](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com) —— 展示如何使用 LangChain 实现信息提取的文档

- [Structured Output Functionality](https://python.langchain.com/docs/guides/structured_output?ref=blog.langchain.com) \- High level LangChain API to structure output using different models capable of function/tool calling  
- [结构化输出功能](https://python.langchain.com/docs/guides/structured_output?ref=blog.langchain.com) —— LangChain 提供的高级 API，支持调用具备函数/工具调用能力的不同模型，以生成结构化输出

- [Function Calling](https://python.langchain.com/docs/modules/model_io/chat/function_calling?ref=blog.langchain.com) \- function calling in more detail  
- [函数调用](https://python.langchain.com/docs/modules/model_io/chat/function_calling?ref=blog.langchain.com) —— 更深入介绍函数调用机制

- [LangChain-benchmarks](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) -a repository that contains benchmarking code that you can use to evaluate different LLMs  
- [LangChain-benchmarks](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) —— 一个包含基准测试代码的仓库，可用于评估不同大语言模型（LLM）的性能

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/use-case-accelerant-extraction-service/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/use-case-accelerant-extraction-service/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/use-case-accelerant-extraction-service/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/use-case-accelerant-extraction-service/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/use-case-accelerant-extraction-service/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/use-case-accelerant-extraction-service/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/use-case-accelerant-extraction-service/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/use-case-accelerant-extraction-service/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/use-case-accelerant-extraction-service/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更简易的评估](images/use-case-accelerant-extraction-service/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/use-case-accelerant-extraction-service/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/use-case-accelerant-extraction-service/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟