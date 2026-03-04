---
title: "LangChain Integration Docs: Find information faster with revamped pages & API references"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-integration-docs-revamped/"
date: "2024-08-30"
scraped_at: "2026-03-03T07:55:18.114759599+00:00"
language: "en-zh"
translated: true
description: "See the latest updates to the LangChain integration docs, including a new standardized format and improved API references that can help you find relevant information faster."
---
{% raw %}

A large part of the LangChain ecosystem is its extensive collection of integrations. LangChain offers over 1,000 integrations for LLMs, vector stores, tools, document loaders, and more.

LangChain 生态系统的重要组成部分之一，是其丰富多样的集成支持。LangChain 为大语言模型（LLM）、向量数据库、工具、文档加载器等提供了超过 1,000 种集成。

Today, we’re announcing an overhaul of our integration documentation in both Python and JavaScript to make it more useful and accessible for the community. The key changes include:

今天，我们正式宣布对 Python 和 JavaScript 两版集成文档进行全面重构，旨在使其对社区开发者更加实用、更易获取。主要更新包括：

- A standardized format for all integration pages.  
- 所有集成页面采用统一标准化格式。

- A cleaned-up index page for each component, which includes a “Features” table highlighting which integrations support specific features.  
- 每类组件均配备优化后的索引页，并新增“功能特性”（Features）表格，清晰标示各集成所支持的具体能力。

- Improved API references that better surface examples and relevant information.  
- 改进的 API 参考文档，更直观地呈现使用示例及相关关键信息。

Let’s dive in!

让我们一探究竟！

## Standardized content for all integration pages

## 所有集成页面的标准化内容

Over the last year and a half, the LangChain community has contributed over 1,000 open-source integrations, including chat models, vector stores, tools, and retrievers. As the sheer quantity of integrations has grown and best practices have changed over time, many pages have become outdated.

过去一年半以来，LangChain 社区已贡献了逾 1,000 个开源集成，涵盖聊天模型（chat models）、向量数据库（vector stores）、工具（tools）、检索器（retrievers）等。随着集成数量激增及最佳实践持续演进，许多原有文档页面已逐渐过时。

Key integrations now follow a standardized template that highlights common features for each category (e.g. models, vector stores, retrievers). For example, for chat models, each page begins with a table showing whether an integration supports features like tool calling and multimodal input, followed by installation and basic invocation examples.

核心集成现已统一采用标准化模板，突出展示各类别（如模型、向量数据库、检索器等）的共性功能。例如，在聊天模型集成页面中，开篇即以表格形式明确列出该集成是否支持工具调用（tool calling）、多模态输入（multimodal input）等功能，随后提供安装方法与基础调用示例。

**Our goal with these revamped integration pages is to help developers quickly identify what an integration can do and how to use it.**

**我们重构这些集成页面的核心目标，是帮助开发者快速了解某项集成的能力范围及其使用方式。**

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_001.png)_Overview of standardized template for LangChain integration pages_

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_001.png)_LangChain 集成页面标准化模板概览_

While some advanced, integration-specific examples remain on these pages, we've placed more emphasis on linking to how-to guides and API references to keep the content evergreen and avoid repetition.

尽管部分高级的、面向特定集成的示例仍保留在页面中，但我们更加强调通过链接导向“操作指南”（how-to guides）和 API 参考文档，从而确保内容长期有效（evergreen），并避免信息重复。

## New index pages for streamlined search

## 优化索引页面，提升搜索效率

To help developers find the integrations they want, we’ve also streamlined the index pages for each type of integration. Combined with the smaller sidebar, these index pages now include tables similar to those on individual integration pages, which lets you quickly identify an integration with the features you need.

为帮助开发者快速定位所需集成，我们还对每类集成的索引页面进行了精简优化。配合更紧凑的侧边栏，这些新版索引页面现已加入与各独立集成页面类似的表格，助您迅速识别具备所需功能的集成。

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_002.jpg)_"Features" table in new index pages for each type of integration_

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_002.jpg)_各类集成新版索引页面中的“功能”表格_

These “Features” tables are currently sorted by a combination of factors including usage in LangSmith traces and package downloads (where relevant). We’ll be looking into more ways to highlight and feature up-and-coming integrations in the future.

目前，“功能”表格的排序综合考量了多项因素，包括 LangSmith 追踪记录中的使用频率以及软件包下载量（如适用）。未来我们将持续探索更多方式，以突出展示和推广新兴集成。

## Improved API references

## 改进的 API 参考文档

Our new pages prominently feature our improved API references for [Python](https://python.langchain.com/v0.2/api_reference/?ref=blog.langchain.com) and [JavaScript](https://v02.api.js.langchain.com/index.html?ref=blog.langchain.com).

新版页面显著展示了我们全面升级的 [Python](https://python.langchain.com/v0.2/api_reference/?ref=blog.langchain.com) 和 [JavaScript](https://v02.api.js.langchain.com/index.html?ref=blog.langchain.com) API 参考文档。

For Python, we’ve added more explanations and usage examples into the docstrings. We’ve also updated the structure and formatting to be more modern and user-friendly, including a navigable sidebar of methods and attributes for all classes.

针对 Python，我们在文档字符串（docstrings）中补充了更详尽的说明与使用示例；同时更新了整体结构与排版，使其更现代、更易用——例如，为所有类均配备了可导航的方法与属性侧边栏。

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_003.jpg)_LangChain Python API Reference_

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_003.jpg)_LangChain Python API 参考文档_

For JavaScript, we’ve gone in a similar direction. To make the API References pages less intimidating, we’ve collapsed the sidebar by default, filtering out less relevant methods and other build artifacts.

JavaScript 方面我们也采取了类似优化策略：为降低 API 参考文档页面的认知负担，我们默认收起侧边栏，并自动过滤掉相关性较低的方法及其他构建产物。

We’ve also enhanced popular chat model and vector store pages with various usage examples, and have generally improved the visibility of useful runtime and constructor definitions and important methods on these pages.

此外，我们还在热门聊天模型（chat model）和向量存储（vector store）等页面中增加了多种使用示例，并整体提升了运行时定义（runtime definitions）、构造函数（constructor definitions）及关键方法在页面上的可见性。

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_004.jpg)_LangChain JavaScript API Reference_

![](images/langchain-integration-docs-find-information-faster-with-revamped-pages-api-refer/img_004.jpg)_LangChain JavaScript API 参考文档_

This ongoing work aims to make our API references stand on their own as valuable resources to the LangChain community.

此项持续进行的工作旨在使我们的 API 参考文档自成一体，成为 LangChain 社区中真正有价值的资源。

* * *

**Check out our latest integration docs** [**for Python**](https://python.langchain.com/v0.2/docs/integrations/platforms/?ref=blog.langchain.com) **and** [**for JavaScript**](https://js.langchain.com/v0.2/docs/integrations/platforms/?ref=blog.langchain.com) **. Your feedback is invaluable as we continue to refine and improve our documentation. Feel free to drop us a line on** [**Twitter**](https://x.com/LangChainAI?ref=blog.langchain.com) **with any questions, suggestions, or comments.**

**欢迎查阅我们最新的集成文档**：[**Python 版本**](https://python.langchain.com/v0.2/docs/integrations/platforms/?ref=blog.langchain.com) **和** [**JavaScript 版本**](https://js.langchain.com/v0.2/docs/integrations/platforms/?ref=blog.langchain.com) **。在我们持续优化和完善文档的过程中，您的反馈至关重要。如有任何问题、建议或意见，欢迎随时通过** [**Twitter**](https://x.com/LangChainAI?ref=blog.langchain.com) **与我们联系。**
{% endraw %}
