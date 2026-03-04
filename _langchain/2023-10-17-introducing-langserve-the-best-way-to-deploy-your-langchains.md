---
render_with_liquid: false
title: "Introducing LangServe, the best way to deploy your LangChains"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-langserve/"
date: "2023-10-17"
scraped_at: "2026-03-03T08:34:55.934821843+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

We think the [LangChain Expression Language](https://blog.langchain.com/langchain-expression-language/) (LCEL) is the quickest way to prototype the brains of your LLM application. The next exciting step is to ship it to your users and get some feedback! Today we're making that a lot easier, launching [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com). LangServe is the easiest and best way to deploy any LangChain chain/agent/runnable.

我们认为，[LangChain 表达式语言](https://blog.langchain.com/langchain-expression-language/)（LCEL）是为您的大语言模型（LLM）应用快速构建“大脑”逻辑的最快方式。接下来令人振奋的一步，便是将它交付给用户并收集反馈！今天，我们大幅简化了这一过程，正式发布 [LangServe](https://github.com/langchain-ai/langserve?ref=blog.langchain.com)。LangServe 是部署任意 LangChain 链（chain）、智能体（agent）或可运行对象（runnable）最简单、最可靠的方案。

Important Links:

重要链接：

- [LangServe GitHub 仓库](https://github.com/langchain-ai/langserve?ref=blog.langchain.com)
- [示例仓库](https://github.com/langchain-ai/langserve-launch-example?ref=blog.langchain.com)（支持在 Google Cloud Platform 上一键部署）
- [Replit 模板](https://github.com/langchain-ai/langserve-replit-template?ref=blog.langchain.com)

## Why it exists

## LangServe 的诞生缘由

Whether you’re building a customer-facing chatbot, or an internal tool powered by LLMs, you’ll probably start by building a prototype (maybe in a Jupyter notebook), and iterate on it until it’s good enough to get people using it.

无论您正在开发面向客户的聊天机器人，还是基于大语言模型的内部工具，通常都会先构建一个原型（例如在 Jupyter Notebook 中），再持续迭代优化，直至达到可供用户实际使用的成熟度。

And that’s where LangServe comes in, we’ve taken our experience scaling applications in production, and made it available as a python package you can use for your own LLM apps.

而 LangServe 正是在这一关键环节发挥作用：我们将自身在生产环境中规模化部署 AI 应用的经验，封装成一个开箱即用的 Python 包，供您直接集成到自己的大语言模型应用中。

💡

💡

Your Idea

您的创意

\+ LCEL = Prototype

\+ LCEL = 快速原型

\+ LangServe = Production-ready API

\+ LangServe = 可投入生产的 API

+ [Hosting Provider] = Live deployment  
+ LangSmith Tracing = 监控您的生产环境部署  

We've been hesitant to release anything around deployment because, to be honest, we weren't entirely sure what value we could add. With some key improvements and additions over the past few months, we now believe that LangServe can provide real value. Most of the features we highlight in the release today make it significantly easier to go from prototype to production and get a production ready API. Over next few weeks, we'll be adding more features that add in new functionality (as opposed to just making it easier to create an API).  

过去一段时间，我们一直对发布任何与部署相关的功能持谨慎态度——坦白说，我们并不完全确定自己能提供哪些独特价值。但经过过去几个月的关键改进与功能新增，我们现在确信 LangServe 能够带来切实的价值。本次发布中重点介绍的大多数功能，都显著简化了从原型开发到生产上线的流程，并帮助您快速构建出可用于生产的 API。在接下来的几周内，我们将陆续推出更多具备全新功能（而不仅仅是简化 API 创建流程）的特性。

We've used LangServe to deploy [ChatLangChain](https://blog.langchain.com/building-chat-langchain-2/) and [WebLangChain](https://blog.langchain.com/weblangchain/) over the past week, and this has help battle test it.  

过去一周，我们已使用 LangServe 成功部署了 [ChatLangChain](https://blog.langchain.com/building-chat-langchain-2/) 和 [WebLangChain](https://blog.langchain.com/weblangchain/)，这为 LangServe 提供了宝贵的实战压力测试机会。

## The road to LangServe  

## LangServe 的演进之路  

The journey to build LangServe really started a few months ago when we launched LCEL and the Runnable protocol. This was designed from day 1 to support putting prototypes in production, with no code changes, from the simplest “prompt + LLM” chain to the most complex chains (we’ve seen folks successfully running in production LCEL chains with 100s of steps). To highlight a few:  

LangServe 的构建之旅，实际上始于数月前 LCEL（LangChain Expression Language）与 Runnable 协议的正式发布。自诞生第一天起，LCEL 就被设计为支持“零代码修改地将原型直接投入生产”，无论链结构是最简单的“提示词 + 大语言模型”组合，还是最复杂的多步骤链（我们已观察到有用户成功将包含数百个步骤的 LCEL 链部署至生产环境）。以下是一些关键亮点：

- first-class support for streaming: when you build your chains with LCEL you get the best possible time-to-first-token (time elapsed until the first chunk of output comes out). For some chains this means eg. we stream tokens straight from an LLM to a streaming output parser, and you get back parsed, incremental chunks of output at the same rate as the LLM provider outputs the raw tokens. We’re constantly improving streaming support, recently we added a [streaming JSON parser](https://twitter.com/LangChainAI/status/1709690468030914584?ref=blog.langchain.com), and more is in the works.  
- 对流式响应的一等支持：使用 LCEL 构建链时，您将获得最优的首 token 延迟（即从请求发出到首个输出分块返回所经历的时间）。对某些链而言，这意味着我们可直接将大语言模型输出的 token 流式传输至流式输出解析器，从而以与 LLM 服务商输出原始 token 相同的速率，向您返回经解析后的、增量式的输出分块。我们持续优化流式能力——近期已上线 [流式 JSON 解析器](https://twitter.com/LangChainAI/status/1709690468030914584?ref=blog.langchain.com)，更多增强功能也正在开发中。

- first-class async support: any chain built with LCEL can be called both with the synchronous API (eg. in your Jupyter notebook while prototyping) as well as with the [asynchronous API](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com#async-invoke) (eg. in a LangServe server). This enables using the same code for prototypes and in production, with great performance, and the ability to handle many concurrent requests in the same server.  
- 对异步调用的一等支持：所有基于 LCEL 构建的链，既可通过同步 API（例如在 Jupyter Notebook 中进行原型开发时）调用，也可通过 [异步 API](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com#async-invoke)（例如在 LangServe 服务端中）调用。这使得您能复用同一套代码完成原型开发与生产部署，在保障高性能的同时，还能在同一服务器上高效处理大量并发请求。

- optimized parallel execution: whenever your LCEL chains have steps that can be [executed in parallel](https://python.langchain.com/docs/expression_language/how_to/map?ref=blog.langchain.com) (eg if you fetch documents from multiple retrievers) we automatically do it, both in the sync and the async interfaces, for the smallest possible latency.  
- 并行执行优化：当您的 LCEL 链中存在可 [并行执行](https://python.langchain.com/docs/expression_language/how_to/map?ref=blog.langchain.com) 的步骤（例如同时从多个检索器获取文档）时，我们会在同步与异步接口中自动启用并行执行，从而实现最低可能的端到端延迟。

- support for retries and fallbacks: more recently we’ve added support for [configuring retries and fallbacks](https://python.langchain.com/docs/expression_language/how_to/fallbacks?ref=blog.langchain.com) for any part of your LCEL chain. This is a great way to make your chains more reliable at scale. We’re currently working on adding streaming support for retries/fallbacks, so you can get the added reliability without any latency cost.  
- 重试与备选方案支持：近期我们新增了对 LCEL 链任意环节配置 [重试与备选方案](https://python.langchain.com/docs/expression_language/how_to/fallbacks?ref=blog.langchain.com) 的能力。这是提升链在规模化场景下可靠性的绝佳方式。目前我们正致力于为重试/备选方案增加流式支持，让您在不增加任何延迟成本的前提下，获得更高的系统可靠性。

- accessing intermediate results: for more complex chains it’s often very useful to access the results of intermediate steps even before the final output is produced. This can be used let end-users know something is happening, or even just to debug your chain. We’ve added support for [streaming intermediate results](https://x.com/LangChainAI/status/1711806009097044193?s=20&ref=blog.langchain.com), and it’s available on every LangServe server.  
- 访问中间结果：对于更复杂的链，往往非常有必要在最终输出生成之前，就访问中间步骤的执行结果。这一能力可用于向终端用户反馈处理进度，或仅用于调试您的链逻辑。我们已新增对 [流式中间结果](https://x.com/LangChainAI/status/1711806009097044193?s=20&ref=blog.langchain.com) 的支持，且该功能已在每一台 LangServe 服务器上默认可用。

- [input and output schemas](https://x.com/LangChainAI/status/1711805322195861934?s=20&ref=blog.langchain.com): this week we launched input and output schemas for LCEL, giving every LCEL chain Pydantic and JSONSchema schemas inferred from the structure of your chain. This can be used for validation of inputs and outputs, and is an integral part of LangServe.  
- [输入与输出 Schema](https://x.com/LangChainAI/status/1711805322195861934?s=20&ref=blog.langchain.com)：本周我们正式为 LCEL 推出了输入与输出 Schema 功能——每个 LCEL 链均可自动生成基于其结构推断出的 Pydantic Schema 与 JSON Schema。该功能可用于输入/输出数据校验，是 LangServe 不可或缺的核心组成部分。

To this ever-growing list of the benefits of building with LCEL today we’re adding LangServe, which takes advantage of all these to give you the fastest path from LLM idea to scalable LLM app in production.  

在 LCEL 日益丰富的上述优势基础上，我们进一步推出 LangServe——它全面整合并发挥所有这些能力，助您以最快路径，将大语言模型创意转化为可规模化部署的生产级 LLM 应用。

## How it works  

## 工作原理  

First we create our chain, here using a conversational retrieval chain, but any other chain would work. This is the `my_package/chain.py` file.  

首先，我们创建自己的链——此处以对话式检索链（conversational retrieval chain）为例，但其他任意类型的链也同样适用。该文件即为 `my_package/chain.py`。

```  
"""A conversational retrieval chain."""  

"""一个对话式检索链。"""  

from langchain.chains import ConversationalRetrievalChain  
from langchain.chat_models import ChatOpenAI  
from langchain.embeddings import OpenAIEmbeddings  
from langchain.vectorstores import FAISS  

vectorstore = FAISS.from_texts(  
    ["cats like fish", "dogs like sticks"],  
    embedding=OpenAIEmbeddings()  
)  
retriever = vectorstore.as_retriever()  

model = ChatOpenAI()  

chain = ConversationalRetrievalChain.from_llm(model, retriever)  

```  

然后，我们将该链传入 `add_routes`。这是 `my_package/server.py` 文件。  

```  
#!/usr/bin/env python  
"""A server for the chain above."""  

#!/usr/bin/env python  
"""上述链的服务器。"""  

from fastapi import FastAPI  
from langserve import add_routes  

from my_package.chain import chain  

app = FastAPI(title="Retrieval App")  
```

```python
add_routes(app, chain)

if __name__ == "__main__":
    import uvicorn

    uvicorn.run(app, host="localhost", port=8000)
```

就是这样！你将获得一个可扩展的 Python Web 服务器，具备以下特性：

- 输入与输出 Schema 自动从你的 chain 推断得出，并在每次 API 调用中强制校验，同时提供详尽的错误提示信息  
- `/docs` 端点提供基于 JSON Schema 和 Swagger 的 API 文档（[示例链接](https://example.com/docs)）  
- `/invoke` 端点接收 JSON 输入，并返回 chain 执行后的 JSON 输出，支持在同一服务器上并发处理大量请求  
- `/batch` 端点可并行处理多个输入并返回对应结果，在可能的情况下对 LLM 调用进行批处理  
- `/stream` 端点使用 [SSE（服务端发送事件）](https://developer.mozilla.org/en-US/docs/Web/API/Server-sent_events/Using_server-sent_events?ref=blog.langchain.com) 实时推送输出分块（机制与 OpenAI 流式 API 相同）  
- `/stream_log` 端点用于流式传输 chain/agent 的全部（或部分）中间步骤日志  
- 内置（可选）追踪功能，支持集成至 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)，只需将你的 API 密钥设为环境变量即可启用  
- 支持在同一服务器上通过不同路径托管多个 chain  
- 全部基于久经考验的开源 Python 库构建，包括 FastAPI、Pydantic、uvloop 和 asyncio。

## Deployment  
## 部署  

API 创建完成后，下一步是将其部署到托管平台。我们首发支持两个部署示例：

- [GCP](https://github.com/langchain-ai/langserve/tree/main?ref=blog.langchain.com#deployment)：仅需一条命令即可部署至 GCP Cloud Run。  
- [Replit](https://replit.com/@LangChain/langserve-replit-template?ref=blog.langchain.com)：在 Replit 上完成部署（及开发）。可通过克隆 [现有 GitHub 仓库](https://github.com/langchain-ai/langserve-replit-template?ref=blog.langchain.com) 快速启动。

我们将陆续补充其他平台的部署说明与模板。如果你有希望支持的平台建议，欢迎随时告诉我们！

## See it in action  
## 实际演示

Let's see it in action. We have deployed [this repo](https://github.com/langchain-ai/langserve-launch-example?ref=blog.langchain.com) as an example.

让我们看看它在实际中的运行效果。我们已将 [此代码仓库](https://github.com/langchain-ai/langserve-launch-example?ref=blog.langchain.com) 部署为一个示例。

The API docs are available [here](https://langserve-launch-example-vz4y4ooboq-uc.a.run.app/docs?ref=blog.langchain.com).

API 文档可在此处查阅：[此处](https://langserve-launch-example-vz4y4ooboq-uc.a.run.app/docs?ref=blog.langchain.com)。

![](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_001.png)

![](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_001.png)

We can stream a response:

我们可以流式传输响应：

```
curl https://langserve-launch-example-vz4y4ooboq-uc.a.run.app/stream -X POST -H "Content-Type: application/json" --data '{"input": {"topic": "bears"}}'
```

```
curl https://langserve-launch-example-vz4y4ooboq-uc.a.run.app/stream -X POST -H "Content-Type: application/json" --data '{"input": {"topic": "bears"}}'
```

![](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_002.gif)

![](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_002.gif)

## What's next

## 后续计划

We're always improving LangChain/LCEL, just recently we've added support for [input and output schemas](https://x.com/LangChainAI/status/1711805322195861934?s=20&ref=blog.langchain.com), [streaming intermediate results](https://x.com/LangChainAI/status/1711806009097044193?s=20&ref=blog.langchain.com), and a [streaming JSON parser](https://twitter.com/LangChainAI/status/1709690468030914584?ref=blog.langchain.com).

我们一直在持续改进 LangChain / LCEL。就在最近，我们新增了对 [输入与输出 Schema](https://x.com/LangChainAI/status/1711805322195861934?s=20&ref=blog.langchain.com)、[中间结果流式传输](https://x.com/LangChainAI/status/1711806009097044193?s=20&ref=blog.langchain.com) 以及 [流式 JSON 解析器](https://twitter.com/LangChainAI/status/1709690468030914584?ref=blog.langchain.com) 的支持。

We'll also be working to add features over the next few weeks: the next two we are adding are (1) a playground to experiment with different prompts/retrievers for deployed chains, (2) a way to save multiple configurations for the same chain.

接下来几周内，我们还将陆续推出新功能：首批两项功能是（1）提供一个交互式 Playground，供您针对已部署的链尝试不同的 Prompt 和检索器（retriever）；（2）支持为同一条链保存多种配置。

Let us know what you'd like to see next!

欢迎告诉我们您希望看到的下一项功能！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/introducing-langserve-the-best-way-to-deploy-your-langchains/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 4 分钟