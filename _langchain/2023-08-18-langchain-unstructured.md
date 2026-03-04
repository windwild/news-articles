---
title: "LangChain <> Unstructured"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-unstructured/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:53:39.173639989+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

One of the core value props of LangChain is the ability to combine Large Language Models with your own text data. There are multiple ( [four!](https://python.langchain.com/docs/modules/chains/document/?ref=blog.langchain.com)) different methods of doing so, and [many](https://langchain.readthedocs.io/en/latest/use_cases/question_answering.html?ref=blog.langchain.com) [different](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) applications this can power.

LangChain 的核心价值主张之一，是能够将大语言模型（Large Language Models）与您自己的文本数据相结合。实现这一目标的方法有多种（[多达四种！](https://python.langchain.com/docs/modules/chains/document/?ref=blog.langchain.com)），并可支撑[大量](https://langchain.readthedocs.io/en/latest/use_cases/question_answering.html?ref=blog.langchain.com) [不同类型的](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) 应用场景。

A step that sits upstream of using text data is the ability to get your data into a text form. This can be rather tricky due to the multitude of different formats that exist out there.

在使用文本数据之前，一个前置步骤是将您的数据转换为文本形式。由于现实中存在海量各异的文件格式，这一步往往颇具挑战性。

Enter... [unstructured.io](https://www.unstructured.io/?ref=blog.langchain.com).

登场——[unstructured.io](https://www.unstructured.io/?ref=blog.langchain.com)。

Unstructured is a company with a mission of transforming natural language data from raw to machine ready. One of the main ways they do this is with an [open source Python package](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com). This package as support for [MANY](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com#document-parsing) different types of file extensions: `.txt`, `.docx`, `.pptx`, `.jpg`, `.png`, `.eml`, `.html`, and `.pdf` documents.

Unstructured 是一家致力于将非结构化自然语言数据从原始形态转化为机器就绪（machine-ready）形态的公司。其实现使命的主要方式之一，是提供一个[开源 Python 包](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com)。该包支持[极其丰富](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com#document-parsing)的文件格式，包括：`.txt`、`.docx`、`.pptx`、`.jpg`、`.png`、`.eml`、`.html` 和 `.pdf` 等文档类型。

After playing around with Unstructured, we realized that by integrating with it we could easily start to build out first class support for loading documents of all types into a format that LangChains could work with. So we created the [Document Loaders module](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com), a large part of which is powered by Unstructured.

在试用 Unstructured 后，我们意识到：通过与其集成，可以轻松构建对各类文档的一流加载支持，并将其统一转换为 LangChain 可直接处理的格式。因此，我们推出了 [Document Loaders（文档加载器）模块](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)，其中很大一部分功能正是由 Unstructured 提供支持。

There are currently two loaders that are powered by Unstructured. Both seem rather simple, but are quite powerful.

目前，有两个文档加载器基于 Unstructured 实现。它们的接口看似简单，实则功能强大。

The first is the [UnstructuredFileLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/integrations/unstructured_file?ref=blog.langchain.com). This has a simple interface (you just pass it a file path) but under the hood Unstructured is doing a lot of smart logic to infer which data type it is (PDF, PowerPoint, image, etc) and extract text.

第一个是 [UnstructuredFileLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/integrations/unstructured_file?ref=blog.langchain.com)。它拥有极简的接口（您只需传入一个文件路径），但在底层，Unstructured 会执行大量智能逻辑，自动推断文件类型（如 PDF、PowerPoint、图像等），并精准提取其中的文本内容。

The second is the [DirectoryLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/how_to/file_directory?ref=blog.langchain.com). Again, this has a pretty simple interface: it takes only a path to a directory and an optional regex to glob for files against. But under the hood it is looping over all files and using the above UnstructuredFileLoader to load them. This makes it possible to load files of all types in a single call.

第二个是 [DirectoryLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/how_to/file_directory?ref=blog.langchain.com)。同样，其接口非常简洁：仅需指定一个目录路径，以及一个可选的正则表达式用于匹配文件名。而在底层，它会遍历目录下所有匹配的文件，并调用上述 UnstructuredFileLoader 逐一加载。由此，用户仅需一次调用，即可加载目录中所有类型的文件。

We're incredibly excited to have made this integration with Unstructured. With their focus on transforming raw data into clean text, it makes it incredibly easy to combine language models with your data, no matter what form it is in.

我们对此次与 Unstructured 的集成感到无比振奋。凭借其专注于将原始数据转化为高质量文本的核心能力，无论您的数据以何种形态存在，都能极为便捷地与语言模型无缝结合。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-unstructured/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langchain-unstructured/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 3 分钟

[![LangChain State of AI 2024 Report](images/langchain-unstructured/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/langchain-unstructured/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/langchain-unstructured/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-unstructured/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-unstructured/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 正式进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
&#123;% endraw %}
