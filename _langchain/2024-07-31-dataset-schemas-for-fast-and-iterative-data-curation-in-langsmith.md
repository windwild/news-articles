---
title: "Dataset schemas for fast and iterative data curation in LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/dataset-schemas/"
date: "2024-07-31"
scraped_at: "2026-03-03T07:57:41.863481997+00:00"
language: "en-zh"
translated: true
description: "Define and flexibly manage dataset schemas in LangSmith. Validate examples against a defined schema, and update the schema easily in the LangSmith UI."
---
&#123;% raw %}

In traditional ML and data science, perhaps the first thing you do is think about data. You need to build data sets (i.e. training/validation/test sets) before even thinking about training and evaluating a model. Only after these steps do you integrate the model into your application to see how it performs.

在传统机器学习和数据科学中，你首先要考虑的往往是数据。你必须先构建数据集（即训练集/验证集/测试集），然后才能开始思考模型的训练与评估。只有完成这些步骤后，你才会将模型集成到应用中，观察其实际表现。

With generative AI, you can easily get started with general purpose LLMs, allowing you to quickly develop a prototype and plug it into your application. But, this doesn’t mean you can skip the initial steps of data collection and validation.

借助生成式 AI，你可以轻松地从通用大语言模型（LLM）入手，快速开发原型并将其接入你的应用。但这并不意味着你可以跳过数据收集与验证等初始环节。

When building LLM apps, a common building pattern is:

构建 LLM 应用时，一种常见的开发模式是：

- First get a prototype up and running and plug it into your application  
- Then build a dataset for evaluation purposes to track your progress and make sure you don’t introduce any regressions  
- Then use that dataset to improve the underlying model (either by few-shot prompting or fine-tuning)

- 首先搭建并运行一个原型，并将其接入你的应用；  
- 然后构建一个用于评估的数据集，以追踪迭代进展，并确保不会引入任何性能退化；  
- 最后利用该数据集优化底层模型（例如通过少样本提示（few-shot prompting）或微调（fine-tuning））。

So data is still incredibly important - but the way you think about data is different for LLM apps. Here are some changes we have noticed when building LLM apps:

因此，数据依然至关重要——但针对 LLM 应用，你对数据的思考方式发生了变化。我们在构建 LLM 应用的过程中，观察到了以下几点变化：

- Initial versions of datasets are often much smaller - sometimes only 5-10 datapoints  
- Datasets rapidly evolve - both in the number of rows they have as well as their schema  
- Individual datapoints are more frequently added to datasets, usually from seeing a bad performing point in production

- 数据集的初始版本通常规模小得多——有时仅有 5–10 个样本；  
- 数据集快速演进——不仅行数（样本量）持续增长，其结构（schema）也频繁变更；  
- 单个样本更常被动态添加至数据集中，往往源于在生产环境中发现某个表现不佳的实例。

These changes mean that the best developer experience for managing datasets for LLM applications has different feature points and considerations. To address this, we’ve added the concept of **dataset schemas** to LangSmith - which interacts with other LangSmith features to streamline data curation and management.

这些变化意味着：为 LLM 应用管理数据集时，最优的开发者体验需具备不同的功能特性与考量维度。为此，我们在 LangSmith 中引入了 **数据集 Schema（数据集结构定义）** 的概念——它可与其他 LangSmith 功能协同工作，从而简化数据整理与管理工作。

## Iterate quickly with flexible dataset schemas

## 借助灵活的数据集 Schema 快速迭代

In LangSmith, you can now define a schema for your dataset, and all new datapoints added will then be validated against this schema. Although this seems basic, this is subtly useful for a few reasons.

在 LangSmith 中，你现在可以为数据集定义一个 Schema，此后所有新增的数据点都将依据该 Schema 进行校验。尽管这看似基础，但它在多个方面具有精妙而实用的价值。

First, having your data follow a defined schema makes it easier to use and consume. You often want to use all datapoints within a dataset in the same way (whether for evaluation or as few shot examples). If they have a different schema, then your code for processing or formatting the data could break.

首先，让数据遵循明确定义的 Schema，能显著提升其易用性与可消费性。你通常希望以统一的方式使用数据集中的所有样本（无论用于评估还是作为少样本示例）。一旦样本结构不一致，用于处理或格式化数据的代码就可能出错甚至崩溃。

Defining a schema is also crucial when building datasets iteratively. While you might remember the schema when curating a dataset all at once, it can be easy to forget the details when adding new data points later. This makes schema consistency extra important in iterative dataset building.

在迭代式构建数据集时，定义 Schema 同样至关重要。当你一次性完成数据集整理时，可能还记得其 Schema；但后续陆续添加新数据点时，却很容易遗忘细节。因此，在迭代式数据集构建过程中，保持 Schema 的一致性尤为关键。

At the same time, flexibility in schema support is also necessary, especially in LLM applications where the ideal schema may not be clear at the start of development. You may not **know** any part of the schema. You might only know the schema for a subset of inputs, or have no schema at all. LangSmith dataset schemas support all of this, allowing you to define datasets without any schema or with partial schemas.

与此同时，Schema 支持的灵活性也必不可少——尤其在大语言模型（LLM）应用中，开发初期往往难以明确理想的 Schema。你可能**完全不了解**任何部分的 Schema；或许仅掌握部分输入对应的 Schema；甚至可能尚未定义任何 Schema。LangSmith 的数据集 Schema 功能全面支持上述各种场景，允许你创建无 Schema 或仅含部分 Schema 的数据集。

It’s important to be able to modify dataset schemas, as the ideal schema may evolve over time (again, due to the iterative nature of dataset curation). LangSmith lets you easily update schemas, presenting a queue of datapoints that no longer fit the desired schema, which can be fixed in the UI. This keeps your dataset consistent and up-to-date.

能够修改数据集 Schema 至关重要，因为理想的 Schema 往往会随时间推移而演进（这再次源于数据集整理本身的迭代特性）。LangSmith 支持便捷地更新 Schema，并自动列出所有不再符合新 Schema 要求的数据点，供你在 UI 中逐一修正。此举确保你的数据集始终保持一致性和时效性。

For a deeper technical dive into how to use dataset schemas, view the developer documentation [here](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#dataset-schema-validation).

如需深入了解如何使用数据集 Schema，请参阅开发者文档：[此处](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#dataset-schema-validation)。

/0:39

1×

## Enhance datasets with schema validation, versioning, and annotation

## 通过 Schema 校验、版本控制与标注增强数据集

Dataset schemas enhance existing LangSmith features that help you manage your datasets for LLM applications.

数据集 Schema 进一步强化了 LangSmith 现有功能，助力你更高效地管理面向大语言模型（LLM）应用的数据集。

When adding data from production logs to datasets, the [schema will now get validated upon your attempt](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#add-inputs-and-outputs-from-traces-to-datasets) and LangSmith raises a helpful error message if it does not comply. Production logs often contain extra info or different keys, which can cause datasets to become messy — so this auto-validation helps keep your dataset clean.

当将生产日志中的数据添加至数据集时，系统[将在你执行操作时自动校验 Schema](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#add-inputs-and-outputs-from-traces-to-datasets)；若数据不符合 Schema，LangSmith 将抛出清晰友好的错误提示。生产日志通常包含冗余信息或键名不一致等问题，极易导致数据集混乱——而这一自动校验机制，正有助于维持数据集的整洁性。

If you update your schema, you’ll want to have versioning to preserve historical context. LangSmith supports versioning natively for datasets; see [the docs](https://docs.smith.langchain.com/how_to_guides/datasets/version_datasets?ref=blog.langchain.com) for how new versions of a dataset can be created.

当你更新 Schema 时，为保留历史上下文，版本控制功能不可或缺。LangSmith 原生支持数据集版本管理；请参阅[相关文档](https://docs.smith.langchain.com/how_to_guides/datasets/version_datasets?ref=blog.langchain.com)，了解如何创建数据集的新版本。

Oftentimes, there are dedicated subject-matter experts (either technical and non-technical) responsible for reviewing data. It should be as easy as possible for these users to view data and add it to an existing dataset. We’ve added [annotation queues](https://docs.smith.langchain.com/how_to_guides/human_feedback/annotation_queues?ref=blog.langchain.com) to LangSmith which provide a streamlined process for users to review runs and attach feedback.

通常，有专门的领域专家（包括技术与非技术人员）负责审核数据。对这些用户而言，查看数据并将其添加至现有数据集的操作应尽可能简便。我们已在 LangSmith 中新增了[标注队列（annotation queues）](https://docs.smith.langchain.com/how_to_guides/human_feedback/annotation_queues?ref=blog.langchain.com)，为用户提供一套简化的流程，用于审阅运行记录（runs）并附加人工反馈。

Future updates will build on these features in LangSmith, continuing to improve the experience of develop datasets for your LLM applications. For example, if a schema is known, it’s easier to generate additional synthetic examples and improve use cases for datasets - not only with testing, but finetuning and few-shot prompting to improve your LLM app performance.

后续更新将持续基于 LangSmith 的这些功能进行拓展，进一步优化您为大语言模型（LLM）应用构建数据集的体验。例如，若已知数据集模式（schema），则更易于生成额外的合成样本，并拓展数据集的应用场景——不仅可用于测试，还可支持微调（finetuning）和少样本提示（few-shot prompting），从而提升您的 LLM 应用性能。

## Conclusion

## 结语

Curating datasets is incredibly important for building both traditional ML and LLM applications. Yet, for LLM applications, the way dataset curation is done and how data is used is different. LangSmith offers a comprehensive suite of tools for managing your LLM datasets. The ability to define dataset schemas ensures consistency, so that you can flexibly utilize data and iterate faster as new examples are added to your dataset.

构建高质量数据集，对于传统机器学习（ML）和大语言模型（LLM）应用的开发均至关重要。然而，在 LLM 应用中，数据集构建的方式以及数据的使用方式均有所不同。LangSmith 提供了一整套完备的工具，助力您高效管理 LLM 数据集。通过定义数据集模式（dataset schemas），可确保数据结构的一致性，使您能灵活运用数据，并在向数据集中持续添加新样本时，更快地完成迭代。

* * *

* * *

**To dive deeper, check out our** [**documentation**](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#dataset-schema-validation) **on dataset schemas. You can** [**try out LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com) **today for robust experimentation and evaluation, with support for prompt versioning, debugging, and human annotations — so you can gain production observability as you build your LLM apps.**

**如需深入了解，请查阅我们关于[数据集模式（dataset schemas）的文档](https://docs.smith.langchain.com/how_to_guides/datasets/manage_datasets_in_application?ref=blog.langchain.com#dataset-schema-validation)。您可立即[试用 LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)，开展稳健的实验与评估——它支持提示词版本管理（prompt versioning）、调试（debugging）及人工标注（human annotations），助您在构建 LLM 应用的过程中，实现生产环境级的可观测性（production observability）。**
&#123;% endraw %}
