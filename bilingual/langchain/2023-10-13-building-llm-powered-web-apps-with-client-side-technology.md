---
title: "Building LLM-Powered Web Apps with Client-Side Technology"
source: "LangChain Blog"
url: "https://blog.langchain.com/building-llm-powered-web-apps-with-client-side-technology/"
date: "2023-10-13"
scraped_at: "2026-03-03T08:36:27.653594018+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

**The initial version of this blog post was a talk for Google’s internal WebML Summit 2023, which you can check out here.**

**本文博客初稿源自 Google 内部 WebML Summit 2023 大会的一场分享，您可在此处查看。**

It’s no secret that for a long time machine learning has been mostly a Python game, but the recent surge in popularity of ChatGPT has brought many new developers into the field. With JavaScript being the most widely-used programming language, it’s no surprise that this has included many web developers, who have naturally tried to build web apps.

长期以来，机器学习领域几乎一直是 Python 的天下，这早已不是什么秘密；但近期 ChatGPT 的爆火，却将大量新开发者吸引入局。鉴于 JavaScript 是目前使用最广泛的编程语言，其中涌现众多 Web 开发者也就不足为奇——他们很自然地开始尝试构建 Web 应用。

There’s been a ton of ink spilled on building with LLMs via API calls to the likes of OpenAI, Anthropic, Google, and others, so I thought I’d try a different approach and try to build a web app using exclusively local models and technologies, preferably those that run in the browser!

围绕如何通过调用 OpenAI、Anthropic、Google 等厂商的 API 来构建大语言模型（LLM）应用，已有海量文章与教程。因此，我决定另辟蹊径：尝试仅使用本地模型与技术（最好是在浏览器中直接运行）来构建一个 Web 应用！

## Why?

## 为何选择此方案？

Some major advantages to building this way are:

采用这种方式构建应用的主要优势包括：

1. Cost. Since all compute and inference would be done client-side, there would be no additional cost to the developer building the app other than (very cheap) hosting.  
1. 成本低。所有计算与推理均在客户端完成，开发者除（极低成本的）静态托管外，无需承担任何额外费用。

2. Privacy. Nothing needs to leave the user’s local machine!  
2. 隐私性强。用户数据完全保留在本地设备中，无须上传至任何远程服务器！

3. Potential speed increases due to no HTTP call overhead.  
3. 潜在性能提升。因省去了 HTTP 请求开销，响应可能更快。

1. This may be offset by slower inference due to user hardware limitations.  
1. 不过，受限于用户终端硬件性能，本地推理速度可能较慢，从而部分抵消上述优势。

## The Project

## 项目概述

I decided to try recreating one of the most popular LangChain use-cases with open source, locally running software: a chain that performs Retrieval-Augmented Generation, or RAG for short, and allows you to “chat with your documents”. This allows you to glean information from data locked away in a variety of unstructured formats.

我决定尝试用开源、本地运行的软件，复现 LangChain 中最受欢迎的用例之一：一个实现“检索增强生成”（Retrieval-Augmented Generation，简称 RAG）的链式流程，支持用户“与自己的文档对话”。该功能可帮助您从多种非结构化格式（如 PDF、Word 文档、Markdown 文件等）中提取关键信息。

![](images/building-llm-powered-web-apps-with-client-side-technology/img_001.png)

![](images/building-llm-powered-web-apps-with-client-side-technology/img_001.png)

## Data Ingestion

## 数据接入

The first steps are to load our data and format it in a way that is later queryable using natural language. This involves the following:

第一步是加载我们的数据，并将其格式化为后续可通过自然语言进行查询的形式。这包括以下步骤：

1. Split a document (PDF, webpages, or some other data) into semantic chunks  
1. 将一份文档（如 PDF、网页或其他类型的数据）切分为具有语义意义的文本块（semantic chunks）

2. Create a vector representation of each chunk using an embeddings model  
2. 使用嵌入模型（embeddings model）为每个文本块生成对应的向量表示

3. Load the chunks and vectors into a specialized database called a vector store  
3. 将这些文本块及其向量存入一种专门设计的数据库——向量数据库（vector store）

These first steps required a few pieces: text splitters, an embeddings model, and a vectorstore. Fortunately, these all already existed in browser-friendly JS!

实现上述初始步骤需要几个关键组件：文本切分器（text splitters）、嵌入模型（embeddings model）以及向量数据库（vectorstore）。幸运的是，这些组件均已存在，且均支持在浏览器中运行的 JavaScript！

LangChain took care of the document loading and splitting. For embeddings, I used a small HuggingFace embeddings model quantized to run in the browser using Xenova’s [Transformers.js package](https://huggingface.co/docs/transformers.js/index?ref=blog.langchain.com), and for the vectorstore, I used a really neat Web Assembly vectorstore called [Voy](https://github.com/tantaraio/voy?ref=blog.langchain.com).

LangChain 负责处理文档加载与切分。对于嵌入模型，我选用了一个轻量级的 Hugging Face 嵌入模型，并通过 Xenova 的 [Transformers.js 库](https://huggingface.co/docs/transformers.js/index?ref=blog.langchain.com) 对其进行了量化，使其可在浏览器中高效运行；而对于向量数据库，我则采用了一个非常精巧的基于 WebAssembly 的向量数据库——[Voy](https://github.com/tantaraio/voy?ref=blog.langchain.com)。

## Retrieval and Generation

## 检索与生成

Now that I had a pipeline set up for loading my data, the next step was to query it:

在完成数据加载流水线的搭建后，下一步便是对数据执行查询：

![](images/building-llm-powered-web-apps-with-client-side-technology/img_002.png)

![](images/building-llm-powered-web-apps-with-client-side-technology/img_002.png)

The general idea here is to take the user’s input question, search our prepared vectorstore for document chunks most semantically similar to the query, and use the retrieved chunks plus the original question to guide the LLM to a final answer based on our input data.

其基本思路是：接收用户输入的问题，在我们预先构建好的向量数据库中检索与该问题语义最相近的文档文本块；再将检索出的文本块与原始问题一并输入大语言模型（LLM），从而引导模型依据我们的输入数据生成最终答案。

There’s an additional step required for followup questions, which may contain pronouns or other references to prior chat history. Because vectorstores perform retrieval by semantic similarity, these references can throw off retrieval. Therefore, we add an additional dereferencing step that rephrases the initial step into a “standalone” question before using that question to search our vectorstore.

对于后续追问（follow-up questions），还需额外增加一个步骤——这类问题常包含代词（如“它”“这个”）或指向先前对话历史的其他指代成分。由于向量数据库依赖语义相似性进行检索，此类指代极易干扰检索结果的准确性。因此，我们引入了一个“消解指代”（dereferencing）步骤：先将原始追问重写为一个上下文独立（standalone）的完整问题，再以此问题作为检索关键词去查询向量数据库。

Finding an LLM that could run in the browser proved difficult - powerful LLMs are massive, and the ones available via HuggingFace failed to generate good responses. There is also the [Machine Learning Compilation’s WebLLM project](https://webllm.mlc.ai/?ref=blog.langchain.com), which looked promising but required a massive, multi-GB download on page load, which added a ton of latency.

寻找一款能在浏览器中运行的大语言模型（LLM）颇具挑战性——性能强大的 LLM 通常体积庞大，而 Hugging Face 上可直接调用的模型又难以生成高质量的回答。此外，还有 [Machine Learning Compilation 推出的 WebLLM 项目](https://webllm.mlc.ai/?ref=blog.langchain.com)，虽前景可观，却要求在页面加载时下载数 GB 的模型文件，导致极高的初始延迟。

![](images/building-llm-powered-web-apps-with-client-side-technology/img_003.png)

![](images/building-llm-powered-web-apps-with-client-side-technology/img_003.png)

I had experimented with Ollama as an easy, out-of-the-box way to run local models in the past, and was pleasantly surprised when I heard there was support for exposing a locally running model to a web app via a shell command. I plugged it in and it turned out to be the missing piece! I spun up the more recent, state-of-the-art Mistral 7B model, which ran comfortably on my 16GB M2 Macbook Pro, and ended up with the following local stack:

过去我曾尝试过使用 Ollama 作为一种开箱即用、简单便捷的本地模型运行方案；当我听说现在已支持通过 Shell 命令将本地运行的模型暴露给 Web 应用时，感到十分惊喜。我立即集成该功能，结果发现它正是我一直在寻找的关键一环！我启动了更新一代、当前最先进的 Mistral 7B 模型——它在我的 16GB 内存 M2 版 MacBook Pro 上运行得非常流畅，并最终构建出如下本地技术栈：

![](images/building-llm-powered-web-apps-with-client-side-technology/img_004.png)

![](images/building-llm-powered-web-apps-with-client-side-technology/img_004.png)

## Results

## 实验结果

You can try out a live version of the Next.js app on Vercel [here](https://webml-demo.vercel.app/?ref=blog.langchain.com).

您可点击[此处](https://webml-demo.vercel.app/?ref=blog.langchain.com)，在 Vercel 上试用该 Next.js 应用的在线版本。

You’ll need to have a Mistral instance running via Ollama on your local machine and make it accessible to the domain in question by running the following commands to avoid CORS issues:

您需要在本地机器上通过 Ollama 运行一个 Mistral 实例，并执行以下命令，使该实例对目标域名（即上述 Vercel 应用）可访问，从而规避跨域资源共享（CORS）问题：

```
$ ollama run mistral
$ OLLAMA_ORIGINS=https://webml-demo.vercel.app OLLAMA_HOST=127.0.0.1:11435 ollama serve
```

```
$ ollama run mistral
$ OLLAMA_ORIGINS=https://webml-demo.vercel.app OLLAMA_HOST=127.0.0.1:11435 ollama serve
```

Another of its differential aspects is that it uses [confidential computing](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com) which means that not even their anonymization service can access the original data; a great feature for privacy seeking users. Finally, it will deanonymize the data after getting the response from the LLM so the user will get an answer that contains the original entities that they mentioned / requested.

另一项差异化特性在于，它采用了[机密计算（Confidential Computing）](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com)技术——这意味着，即便是其自身的数据匿名化服务也无法访问原始数据；这对注重隐私保护的用户而言是一项极佳的功能。最后，在从大语言模型（LLM）获得响应后，系统会执行去匿名化操作，确保用户收到的答案中包含其最初提及或请求的原始实体信息。

Here are some example traces in [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com), our observability and tracing platform, for a few questions. I used my personal resume as an input document:

以下是我们在可观测性与追踪平台 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 中记录的部分查询示例追踪（trace）。我以本人的简历作为输入文档：

1. "Who is this about?”  
1. “这份文档介绍的是谁？”

1. [https://smith.langchain.com/public/2386b1de-7afb-48a2-8c83-205162bfcac0/r](https://smith.langchain.com/public/2386b1de-7afb-48a2-8c83-205162bfcac0/r?ref=blog.langchain.com)  
1. [https://smith.langchain.com/public/2386b1de-7afb-48a2-8c83-205162bfcac0/r](https://smith.langchain.com/public/2386b1de-7afb-48a2-8c83-205162bfcac0/r?ref=blog.langchain.com)

2. "Do they know JavaScript?”  
2. “此人是否掌握 JavaScript？”

1. [https://smith.langchain.com/public/18cec162-d12c-4034-aa9a-39b1cd2011ea/r](https://smith.langchain.com/public/18cec162-d12c-4034-aa9a-39b1cd2011ea/r?ref=blog.langchain.com)  
1. [https://smith.langchain.com/public/18cec162-d12c-4034-aa9a-39b1cd2011ea/r](https://smith.langchain.com/public/18cec162-d12c-4034-aa9a-39b1cd2011ea/r?ref=blog.langchain.com)

## Conclusions

## 结论

Overall, this worked out well. A few observations:

总体而言，这次实践效果良好。几点观察如下：

- Open source models are advancing rapidly - I built the initial version of this app with Llama 2, and Mistral was announced just weeks later.

- 开源模型正以前所未有的速度发展——我最初使用 Llama 2 构建了本应用的初始版本，而 Mistral 模型仅数周后便正式发布。

- More and more consumer hardware manufacturers are including GPUs in their products.

- 越来越多的消费级硬件制造商正在其产品中集成 GPU。

- As OSS models get smaller and faster, running these models on local hardware with tools like Ollama becomes will become more and more common.

- 随着开源模型（OSS models）持续变小、变快，借助 Ollama 等工具在本地硬件上运行这些模型将日益普及。

- While browser-friendly tech for vectorstores, embeddings, and other task-specific models has undergone some incredible advancements in the last few months, LLMs are still far too large to feasibly ship bundled in web apps.

- 尽管过去几个月中，面向浏览器的向量数据库（vectorstores）、嵌入模型（embeddings）及其他任务专用模型技术取得了令人瞩目的进展，但大语言模型（LLMs）体积依然过于庞大，尚无法切实可行地以内置方式打包进 Web 应用。

The only feasible solution for web apps to take advantage of local models seems to be the flow I used above, where a powerful, pre-installed LLM is exposed to the app.

目前看来，Web 应用利用本地模型的唯一可行方案，正是上文所述的流程：即通过暴露一个已预先安装、性能强劲的本地大语言模型，供应用调用。

## A New Browser API?

## 是否需要一项新的浏览器 API？

Since non-technical web end-users will not be comfortable running a shell command, the best answer here seems to be a new browser API where a web app can request access to a locally running LLM, e.g. via a popup, then use that power alongside other in-browser task-specific models and technologies.

鉴于非技术背景的普通 Web 终端用户难以接受手动执行 Shell 命令的操作，此处最理想的解决方案似乎是一项全新的浏览器 API：Web 应用可通过该 API（例如以弹窗形式）请求访问用户本地运行的大语言模型，并将该能力与浏览器内其他任务专用模型及技术协同使用。

![](images/building-llm-powered-web-apps-with-client-side-technology/img_005.png)

## Thanks for reading!

## 感谢阅读！

I’m extremely excited for the future of LLM-powered web apps and how tech like Ollama and LangChain can facilitate incredible new user interactions.

我对大语言模型驱动的 Web 应用的未来充满期待，也热切看好 Ollama、LangChain 等技术如何赋能前所未有的全新用户交互体验。

Here are some links for the various pieces used in the app:  

以下是本应用所采用各项技术的参考链接：

- Demo app: [https://webml-demo.vercel.app/](https://webml-demo.vercel.app/?ref=blog.langchain.com)  
- 演示应用：[https://webml-demo.vercel.app/](https://webml-demo.vercel.app/?ref=blog.langchain.com)

- Demo app GitHub repo: [https://github.com/jacoblee93/fully-local-pdf-chatbot](https://github.com/jacoblee93/fully-local-pdf-chatbot?ref=blog.langchain.com)  
- 演示应用 GitHub 仓库：[https://github.com/jacoblee93/fully-local-pdf-chatbot](https://github.com/jacoblee93/fully-local-pdf-chatbot?ref=blog.langchain.com)

- Voy: [https://github.com/tantaraio/voy](https://github.com/tantaraio/voy?ref=blog.langchain.com)  
- Voy：[https://github.com/tantaraio/voy](https://github.com/tantaraio/voy?ref=blog.langchain.com)

- Ollama: [https://github.com/jmorganca/ollama/](https://github.com/jmorganca/ollama/?ref=blog.langchain.com)  
- Ollama：[https://github.com/jmorganca/ollama/](https://github.com/jmorganca/ollama/?ref=blog.langchain.com)

- LangChain.js: [https://js.langchain.com/](https://js.langchain.com/?ref=blog.langchain.com)  
- LangChain.js：[https://js.langchain.com/](https://js.langchain.com/?ref=blog.langchain.com)

- Transformers.js: [https://huggingface.co/docs/transformers.js/index](https://huggingface.co/docs/transformers.js/index?ref=blog.langchain.com)  
- Transformers.js：[https://huggingface.co/docs/transformers.js/index](https://huggingface.co/docs/transformers.js/index?ref=blog.langchain.com)

If you’d like to keep in touch, you can follow me [@Hacubu](https://twitter.com/Hacubu?ref=blog.langchain.com) on X, formerly Twitter, and LangChain [@LangChainAI](https://twitter.com/LangChainAI?ref=blog.langchain.com).  
如希望保持联系，欢迎在 X（原 Twitter）上关注我 [@Hacubu](https://twitter.com/Hacubu?ref=blog.langchain.com) 和 LangChain [@LangChainAI](https://twitter.com/LangChainAI?ref=blog.langchain.com)。

### Tags  
### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  
[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/building-llm-powered-web-apps-with-client-side-technology/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![评估深度智能体：我们的经验总结](images/building-llm-powered-web-apps-with-client-side-technology/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read  
[由 LangChain 发布]｜阅读约 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/building-llm-powered-web-apps-with-client-side-technology/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  
[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/building-llm-powered-web-apps-with-client-side-technology/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)  
[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/building-llm-powered-web-apps-with-client-side-technology/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/building-llm-powered-web-apps-with-client-side-technology/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/building-llm-powered-web-apps-with-client-side-technology/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/building-llm-powered-web-apps-with-client-side-technology/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/building-llm-powered-web-apps-with-client-side-technology/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/building-llm-powered-web-apps-with-client-side-technology/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/building-llm-powered-web-apps-with-client-side-technology/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入测试阶段：面向可扩展智能体基础设施的全新部署选项](images/building-llm-powered-web-apps-with-client-side-technology/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟