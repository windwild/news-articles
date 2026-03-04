---
title: "LangChain + Docugami Webinar: Lessons from Deploying LLMs with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-docugami-webinar-lessons-from-deploying-llms-with-langsmith/"
date: "2023-09-20"
scraped_at: "2026-03-03T08:43:47.055709652+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the_ [_Docugami_](https://www.docugami.com/?ref=blog.langchain.com) _team. We recently did a webinar with them and_ [_Rechat_](https://rechat.com/ai/?ref=blog.langchain.com) _to talk about what it actually requires to get an LLM application into production. You can find the recording of the webinar [here](https://www.youtube.com/watch?v=ll-Xit_Khq0&ref=blog.langchain.com)–and this post provides a helpful overview of what they discussed and dives even deeper on their learnings._

_编辑注：本文由 LangChain 团队与_ [_Docugami_](https://www.docugami.com/?ref=blog.langchain.com) _团队联合撰写。我们近期与 Docugami 及_ [_Rechat_](https://rechat.com/ai/?ref=blog.langchain.com) _共同举办了一场网络研讨会，深入探讨将大语言模型（LLM）应用投入实际生产环境所需的关键要素。您可点击此处观看[研讨会回放](https://www.youtube.com/watch?v=ll-Xit_Khq0&ref=blog.langchain.com)；本文则对研讨内容进行了精要梳理，并进一步深入剖析了双方的实践洞见。_

At Docugami we have been using, training or fine-tuning language models for multiple years in our mission to transform documents to data. We initially started using smaller models for text completion and OCR correction, as well as pretraining for sequence labeling tasks. As these models have exploded in size and complexity, we have continued to invest in this space with question answering and Retrieval Augmented Generation (RAG) using our unique approach with the Document XML Knowledge Graph.

在 Docugami，我们多年来始终致力于“将文档转化为数据”这一使命，持续使用、训练及微调各类语言模型。早期，我们主要采用较小规模的模型完成文本补全、OCR 文字校正，以及序列标注任务的预训练工作。随着模型在参数量与结构复杂度上的迅猛增长，我们亦持续加码投入——尤其聚焦于问答系统（Question Answering）与检索增强生成（Retrieval-Augmented Generation, RAG），并依托我们独创的“文档 XML 知识图谱（Document XML Knowledge Graph）”方法推进相关实践。

We chose from the beginning to host the language models in our cloud to ensure customer data confidentiality.

自项目启动之初，我们便决定将语言模型部署于自有云环境，以切实保障客户数据的机密性与安全性。

We started using LangChain very early, impressed with the expressive API and vibrant community. The LangChain [Docugami Loader](https://python.langchain.com/docs/integrations/document_loaders/docugami?ref=blog.langchain.com) was added in May, and we continue to be amazed by the responsiveness of the LangChain team as they incorporate community feedback and continue to grow the LangChain framework.

我们很早就开始采用 LangChain，其富有表现力的 API 设计与活跃繁荣的开发者社区令我们印象深刻。LangChain 官方于五月正式集成了 [Docugami Loader](https://python.langchain.com/docs/integrations/document_loaders/docugami?ref=blog.langchain.com)，而 LangChain 团队对社区反馈的快速响应，以及对整个框架持续不断的演进与拓展，也始终令我们深感钦佩。

Yesterday, we were super happy to share our learnings with the community in an [educational webinar](https://www.youtube.com/watch?v=ll-Xit_Khq0&ref=blog.langchain.com) hosted by LangChain. Our goal was to share some of the real-world challenges we have encountered with LLMs in production and how we are using LangChain, and especially the new [LangSmith (beta)](https://www.langchain.com/langsmith?ref=blog.langchain.com) tool, in our LLMOps flow.

昨日，我们非常荣幸地通过 LangChain 主办的[教育类网络研讨会](https://www.youtube.com/watch?v=ll-Xit_Khq0&ref=blog.langchain.com)，向广大开发者社区分享了我们的实践经验。本次分享旨在呈现我们在 LLM 实际生产落地过程中所遭遇的真实挑战，并重点介绍我们如何借助 LangChain（尤其是全新推出的 [LangSmith（测试版）](https://www.langchain.com/langsmith?ref=blog.langchain.com) 工具）构建高效、稳健的 LLMOps 流程。

If you missed the webinar, no problem! Here is a summary of the key points we covered:

若您遗憾错过本次研讨会，也无需担心！以下是我们所涵盖核心要点的简明摘要：

1\.       _**Real documents are more than flat text:**_ We described in detail how Docugami structurally chunks documents (Scanned PDF, Digital PDF, DOCX, DOC) and stitches together the complex reading orders including tables and multi-column flows. We discussed how humans create documents to be readable by other humans, including visual and structural cues that contain semantic meaning which is often missed by text-only systems.

1. **真实文档远不止于平面化文本：** 我们详细阐述了 Docugami 如何对各类文档（扫描版 PDF、数字版 PDF、DOCX、DOC）进行结构性分块，并智能整合包含表格、多栏排版等在内的复杂阅读顺序。我们指出，人类在创建文档时，天然融入了大量供其他人类阅读理解的视觉线索与结构特征——这些承载着丰富语义信息的线索，往往被仅依赖纯文本处理的传统系统所忽略。

2\.       _**Documents are Knowledge Graphs:**_ We briefly showed some examples of the hierarchical Document XML Knowledge Graph produced by Docugami. It contains deep hierarchies, custom semantic labels on nodes and all the complex relationships that can be expressed semantically using the XML Data Model. We showed through code how RAG using Docugami’s XML Knowledge Graph leads to more accurate results that cannot be achieved with simple linear chunking.

2. **文档即知识图谱：** 我们简要展示了 Docugami 所构建的层级化“文档 XML 知识图谱”的若干示例。该图谱具备深度嵌套的层级结构、节点上自定义的语义标签，以及可通过 XML 数据模型完整表达的所有复杂语义关系。我们还通过代码演示了：基于 Docugami XML 知识图谱实施 RAG，可显著提升结果准确性——这是简单线性分块策略所无法企及的。

3\.       _**Building Complex Chains with the LangChain Expression Language:**_ Real-world chains can get complicated with parallel branches, output parsers, few shot examples, conditional sub-chains, and more. We walked through a quick example with SQL generation, with agent-like fixup for invalid SQL. We discussed how you can step through these complex chains in the LangSmith tool, and shared some example traces.

3. **运用 LangChain 表达式语言构建复杂链式流程：** 真实业务场景中的链式流程往往极为复杂，涉及并行分支、输出解析器、少样本示例、条件子链等多种机制。我们以 SQL 语句生成为例进行了快速演示，并引入类 Agent 的容错修复机制来处理非法 SQL 输出。我们还介绍了如何借助 LangSmith 工具对这类复杂链进行逐级调试与追踪，并分享了若干典型执行轨迹（trace）示例。

4\.       _**Debugging Complex Chain Failures in Production:**_ Things go wrong for various reasons when LLMs are deployed in production. It could be something as simple as a context length overflow, or something more subtle like an output parser throwing exceptions in some edge cases. We shared some tips to make your run traces in LangSmith more debuggable.

4. **在生产环境中调试复杂链式流程的故障：** LLM 投入生产后，各类问题可能因多种原因浮现——既可能是简单的上下文长度溢出（context length overflow），也可能是更隐蔽的情形，例如输出解析器在某些边界条件下意外抛出异常。我们分享了一些实用技巧，助您优化 LangSmith 中的运行轨迹（run traces），使其更易于定位与诊断问题根源。

5.       _**Docugami’s end to end LLM Ops with LangChain + LangSmith:**_

5.       _**Docugami 基于 LangChain + LangSmith 的端到端大语言模型运维（LLM Ops）：**_

Finally, we summarized our overall flow to deploy models, monitor them under real customer use, identify problematic runs, and then fix up these runs (manually as well as with help from other LLMs offline). This is a nascent area, where we are excited to work with LangSmith to improve the tooling given our previous experience running similar model ops for other (non-LLM) machine learning models.

最后，我们总结了整体工作流：部署模型、在真实客户使用场景下持续监控模型表现、识别异常运行实例，并对这些异常实例进行修复（既可人工干预，也可借助其他大语言模型离线辅助）。这是一个新兴领域；凭借我们在其他（非大语言模型）机器学习模型上长期实践的模型运维（Model Ops）经验，我们非常期待与 LangSmith 合作，共同优化相关工具链。

The slides (including links to code samples and LangSmith traces) are [here](https://rebrand.ly/docugami_langsmith?ref=blog.langchain.com).

幻灯片（含代码示例链接及 LangSmith 追踪记录）请见 [此处](https://rebrand.ly/docugami_langsmith?ref=blog.langchain.com)。

You can also watch the webinar here.

您也可在此观看网络研讨会回放。

We are excited to see what you build with LangChain and Docugami. Tag us @docugami on twitter to share your results and experience, or just reach out [https://www.docugami.com/contact-us](https://www.docugami.com/contact-us?ref=blog.langchain.com)

我们热切期待您基于 LangChain 与 Docugami 构建的各类应用！欢迎在 Twitter 上通过 @docugami 分享您的成果与体验；或直接通过 [https://www.docugami.com/contact-us](https://www.docugami.com/contact-us?ref=blog.langchain.com) 与我们联系。
&#123;% endraw %}
