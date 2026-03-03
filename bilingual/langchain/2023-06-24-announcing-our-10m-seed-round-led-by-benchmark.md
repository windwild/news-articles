---
title: "Announcing our $10M seed round led by Benchmark"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-our-10m-seed-round-led-by-benchmark/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:45:56.375794086+00:00"
language: "en-zh"
translated: true
---

It was only six months ago that we released the first version of LangChain, but it seems like several years.  
就在六个月前，我们发布了 LangChain 的首个版本，但感觉仿佛已过去好几年。

When we launched, generative AI was starting to go mainstream: stable diffusion had [just been released](https://stability.ai/blog/stable-diffusion-public-release?ref=blog.langchain.com) and was captivating people’s imagination and fueling an explosion in developer activity, Jasper [announced a funding round](https://www.prnewswire.com/news-releases/jasper-announces-125m-series-a-funding-round-bringing-total-valuation-to-1-5b-and-launches-new-browser-extension-301651733.html?ref=blog.langchain.com), and investors released the first [Gen AI market maps](https://www.sequoiacap.com/article/generative-ai-a-creative-new-world/?ref=blog.langchain.com).  
发布之时，生成式 AI 正开始走向主流：Stable Diffusion 刚刚[正式发布](https://stability.ai/blog/stable-diffusion-public-release?ref=blog.langchain.com)，迅速激发大众想象力，并引爆开发者活跃度；Jasper [宣布完成新一轮融资](https://www.prnewswire.com/news-releases/jasper-announces-125m-series-a-funding-round-bringing-total-valuation-to-1-5b-and-launches-new-browser-extension-301651733.html?ref=blog.langchain.com)；投资机构也发布了首批[生成式 AI 市场图谱](https://www.sequoiacap.com/article/generative-ai-a-creative-new-world/?ref=blog.langchain.com)。

Alongside this boon in content creation, people started to realize that the true power of this technology was not using a language model in isolation, but using the language model as part of a new, more intelligent system. Developers were discussing how to connect language models to their own proprietary documents, APIs, and structured data. Research papers like [Self-Ask with Search](https://twitter.com/OfirPress/status/1577302733383925762?s=20&ref=blog.langchain.com) and [ReAct](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com) were published, demonstrating the power of these approaches.  
伴随内容创作领域的蓬勃发展，人们逐渐意识到：这项技术的真正威力，并不在于孤立地使用大语言模型（LLM），而在于将语言模型作为全新、更智能系统的一部分来协同运作。开发者们纷纷探讨如何将语言模型接入自有私有文档、API 和结构化数据。诸如 [Self-Ask with Search](https://twitter.com/OfirPress/status/1577302733383925762?s=20&ref=blog.langchain.com) 和 [ReAct](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2210.xml?ref=blog.langchain.com) 等研究论文相继发表，有力印证了这类方法的强大潜力。

Amongst these early tremors of a tectonic shift in computing, we released the first version of the LangChain Python package on October 24th, 2022. In the very first [tweet thread](https://twitter.com/hwchase17/status/1584925380976091137?s=20&ref=blog.langchain.com), Harrison said:  
在计算领域这场深刻变革的最初震颤之中，我们于 2022 年 10 月 24 日发布了 LangChain Python 包的首个版本。在最初的 [推文线程](https://twitter.com/hwchase17/status/1584925380976091137?s=20&ref=blog.langchain.com) 中，Harrison 表示：

- “a python package aimed at helping build LLM applications through composability”  
- “一个旨在通过可组合性（composability）助力构建大语言模型应用的 Python 包”

- “The real power comes when you are able to combine \[LLMs\] with other things.”  
- “真正的力量，源于你能够将\[大语言模型\]与其他组件相结合。”

- “LangChain aims to help with that by creating… a comprehensive collection of pieces you would ever want to combine… a flexible interface for combining pieces into a single comprehensive ‘chain’”  
- “LangChain 致力于为此提供支持——打造……一套全面、丰富、可供任意组合的模块集合……并提供灵活接口，将这些模块无缝整合为一条完整、统一的‘链’（chain）。”

## **Why Raise Funding?**  
## **为何进行融资？**

This all started as an open-source side project, without any intention of building a company. It began by noticing common patterns in how people were approaching problems, and attempting to create abstractions that made it easier. These first simple abstractions struck a chord and the project took off, thanks largely to your community support and contributions. LangChain now has over 20K stars on GitHub, 10K active Discord members, over 30K followers on Twitter, and - most importantly - over 350 contributors.  
这一切最初只是一个开源副业项目，毫无创办公司的意图。它源于我们观察到开发者解决实际问题时呈现出的共性模式，并尝试构建更易用的抽象层。这些早期简洁而实用的抽象设计引起了广泛共鸣，项目由此迅速发展——这在很大程度上得益于各位社区成员的支持与贡献。如今，LangChain 在 GitHub 上已收获超 2 万颗星标，Discord 活跃成员达 1 万人，Twitter 粉丝逾 3 万，而最为重要的是——已有超过 350 位贡献者参与共建。

It became clear that the combination of LangChain + LLMs blows open the frontier of amazing products and applications to be built. And, it also is clear that far more work and tooling are needed to make these applications work well (particularly in production). You’re asking us every day for more (400+ GitHub issues, 100 open PRs) and we want to help!  
我们愈发清晰地认识到：LangChain 与大语言模型的结合，正前所未有地拓展着惊艳产品与应用的创新边界；与此同时，我们也深知，要让这些应用真正稳定、高效地落地（尤其是在生产环境中），仍需大量工程投入与工具建设。大家每天都在向我们提出更多需求（GitHub 上已有 400+ 个待处理 issue、100+ 个开放中的 PR），而我们迫切希望提供帮助！

With that in mind, we are excited to publicly announce that we have raised $10 million in seed funding. Benchmark led the round and we’re thrilled to have their counsel as they’ve been the first lead investors in some of the iconic open source software we all use including Docker, Confluent, Elastic, Clickhouse and more. With this capital we are going to invest aggressively to keep up with the ground breaking work the community is doing building intelligent apps. Our goal is simple: empower developers to build useful applications powered by language models.  
基于上述考量，我们非常高兴地正式宣布：已完成 1000 万美元种子轮融资。本轮融资由 Benchmark 领投；我们深感荣幸能获得其指导——Benchmark 曾是 Docker、Confluent、Elastic、ClickHouse 等众多标志性开源软件的首批领投方。本次融资所得资金，我们将全力投入，以持续跟进社区在构建智能应用方面所开展的开创性工作。我们的目标非常明确：赋能开发者，打造真正有用、由语言模型驱动的应用程序。

So what can you expect from us?  
那么，您对我们有哪些期待？

## **LangChain Today**  
## **今日的 LangChain**

LangChain is a framework for developing applications powered by language models, offered as both a [Python](https://github.com/hwchase17/langchain?ref=blog.langchain.com) and a [TypeScript](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) package.  
LangChain 是一个用于构建大语言模型驱动应用的框架，同时提供 [Python](https://github.com/hwchase17/langchain?ref=blog.langchain.com) 和 [TypeScript](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) 两个版本的软件包。

We believe that the most powerful and differentiated language model applications will:  
我们相信，最强大且最具差异化的语言模型应用将具备以下两大特征：

1. Be data-aware: connect a language model to other sources of data  
1. 具备数据感知能力：将语言模型与外部数据源连接起来  

2. Be agentic: allow a language model to interact with its environment  
2. 具备智能体（Agent）能力：使语言模型能够与其运行环境进行交互  

The LangChain framework is designed with the above objective principles in mind. We believe that the two main value props it provides are:  
LangChain 框架正是基于上述目标原则而设计。我们认为，它所提供的两大核心价值体现在以下两方面：

### **Components**  
### **组件**

LangChain offers a modular set of abstractions and components that provide everything developers need to build applications using language models. It also includes collections of implementations for these abstractions.  
LangChain 提供了一套模块化的抽象接口与组件，涵盖开发者使用语言模型构建应用所需的全部功能；同时，它还为这些抽象接口提供了丰富的具体实现。

These components are largely community driven. There are over 300 contributors on the Python repo alone. Some highlights:  
这些组件主要由社区驱动开发。仅 Python 版本仓库就拥有超过 300 名贡献者。部分亮点包括：

- Integrations with [20+ different model providers](https://python.langchain.com/docs/modules/model_io/models/?ref=blog.langchain.com) or hosting platforms  
- 已集成 [20 多家不同的模型提供商](https://python.langchain.com/docs/modules/model_io/models/?ref=blog.langchain.com) 或模型托管平台  

- Collection of [50+ Document Loaders](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com) to load data from different sources  
- 提供 [50 多种文档加载器（Document Loaders）](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)，支持从各类数据源加载数据  

- Collection of [10+ methods for splitting text](https://python.langchain.com/docs/modules/data_connection/document_transformers/?ref=blog.langchain.com) data into chunks so that a Language Model can easily use it  
- 提供 [10 多种文本切分方法](https://python.langchain.com/docs/modules/data_connection/document_transformers/?ref=blog.langchain.com)，可将文本数据分割为适合语言模型处理的片段  

- Integrations with [10+ different vector databases](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com)  
- 已集成 [10 多种向量数据库](https://python.langchain.com/docs/modules/data_connection/vectorstores/?ref=blog.langchain.com)  

- Collection of [15+ different tools](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com) to let Language Models use  
- 提供 [15 种以上不同工具（Tools）](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com)，赋能语言模型调用外部能力  

### **Pre-built Chains and Agents**  
### **预构建的链（Chains）与智能体（Agents）**

Chains allow developers to assemble components in a specific manner to accomplish a particular task, such as summarizing a large pdf document or querying a SQL database. Agents can be thought of as “dynamic chains” in which the sequence of steps taken are determined by a language model on the fly. In addition to providing a high-level interface that makes it easy for developers to create custom chains and agents, LangChain provides many pre-built ones that can be used out-of-the-box.  
“链（Chains）”允许开发者以特定方式组合各类组件，从而完成某项具体任务（例如：总结一份大型 PDF 文档，或查询一个 SQL 数据库）；而“智能体（Agents）”则可被视作一种“动态链”，其执行步骤由语言模型在运行时实时决定。除提供一套高层级接口、大幅简化自定义链与智能体的开发流程外，LangChain 还内置了大量开箱即用的预构建链与智能体。

Again, these components are largely community driven. Some highlights:  
同样，这些链与智能体也主要由社区驱动开发。部分亮点包括：

- 实现了 [约 20 种不同链（chains）](https://python.langchain.com/docs/modules/chains/?ref=blog.langchain.com)  
- 实现了 [6 种不同通用智能体类型（agents）](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com)（专为调用工具及与外部世界交互而设计的链）  
- 实现了 [7 种不同的“智能体工具包（Agent Toolkits）”](https://python.langchain.com/docs/modules/agents/toolkits/?ref=blog.langchain.com)（配备特定工具集、用于完成特定任务的智能体）

## **未来规划**

如前所述，我们相信大语言模型正在解锁全新类型的高价值应用；然而，创建并维护这类应用——尤其是在生产环境中——仍非易事。我们近期发布的部分功能正致力于解决这些问题：

- 将 TypeScript 版本包的功能提升至与 Python 版本完全对齐，从而赋能更多全栈及前端开发者构建大语言模型（LLM）应用  
- 实现多种类型的 [OutputParsers（输出解析器）](https://python.langchain.com/docs/modules/model_io/output_parsers/?ref=blog.langchain.com)，以增强大语言模型返回文本的安全性与可控性  
- 引入 [检索器抽象（Retriever abstraction）](https://blog.langchain.com/retrieval/)，支持更复杂、更必要的文档检索方式  
- 构建与 Weights & Biases、AIM、ClearML 等平台的集成，提升大语言模型应用的可观测性与实验能力  

我们将持续为 LangChain 增加新功能，并提供其他配套服务，以达成以下两大目标：  
1. 让应用的快速原型开发变得轻而易举；  
2. 缩小从原型验证到生产部署之间的鸿沟。

我们无比期待大家将创造出怎样的精彩成果，也热切希望继续为您提供更有力的支持。同时，我们尤其感谢整个 LangChain 社区！LangChain 将始终秉持开源理念，专注服务开发者——当前的融资使我们能够投入更多资源，推动项目迈向更高水平。若您认同这一使命与征程，我们正 [积极招募创始工程师（founding engineers）](https://docs.google.com/forms/d/e/1FAIpQLScrz8YeKJI6F5bnM1Mvq4wkK91f0RQPVIvXBDULeqbQSwJ0tQ/viewform?usp=sf_link&ref=blog.langchain.com)。如果您有关于新功能的建议，或有意在生产环境中评估与运行您的 LangChain 应用，欢迎随时通过 support@langchain.dev 与我们联系！

衷心感谢您迄今为止的支持，让我们一起打造一些酷炫的东西吧！🙂

### 标签

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain：探索 GenWorlds —— 一种协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)