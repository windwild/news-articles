---
title: "LangChain <> Unstructured"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-unstructured/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:53:39.173639989+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

One of the core value props of LangChain is the ability to combine Large Language Models with your own text data. There are multiple ( [four!](https://python.langchain.com/docs/modules/chains/document/?ref=blog.langchain.com)) different methods of doing so, and [many](https://langchain.readthedocs.io/en/latest/use_cases/question_answering.html?ref=blog.langchain.com) [different](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) applications this can power.

A step that sits upstream of using text data is the ability to get your data into a text form. This can be rather tricky due to the multitude of different formats that exist out there.

Enter... [unstructured.io](https://www.unstructured.io/?ref=blog.langchain.com).

Unstructured is a company with a mission of transforming natural language data from raw to machine ready. One of the main ways they do this is with an [open source Python package](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com). This package as support for [MANY](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com#document-parsing) different types of file extensions: `.txt`, `.docx`, `.pptx`, `.jpg`, `.png`, `.eml`, `.html`, and `.pdf` documents.

After playing around with Unstructured, we realized that by integrating with it we could easily start to build out first class support for loading documents of all types into a format that LangChains could work with. So we created the [Document Loaders module](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com), a large part of which is powered by Unstructured.

There are currently two loaders that are powered by Unstructured. Both seem rather simple, but are quite powerful.

The first is the [UnstructuredFileLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/integrations/unstructured_file?ref=blog.langchain.com). This has a simple interface (you just pass it a file path) but under the hood Unstructured is doing a lot of smart logic to infer which data type it is (PDF, PowerPoint, image, etc) and extract text.

The second is the [DirectoryLoader](https://python.langchain.com/docs/modules/data_connection/document_loaders/how_to/file_directory?ref=blog.langchain.com). Again, this has a pretty simple interface: it takes only a path to a directory and an optional regex to glob for files against. But under the hood it is looping over all files and using the above UnstructuredFileLoader to load them. This makes it possible to load files of all types in a single call.

We're incredibly excited to have made this integration with Unstructured. With their focus on transforming raw data into clean text, it makes it incredibly easy to combine language models with your data, no matter what form it is in.

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-unstructured/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/langchain-unstructured/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/langchain-unstructured/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-unstructured/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-unstructured/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read