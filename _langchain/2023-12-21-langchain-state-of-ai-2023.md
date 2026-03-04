---
title: "LangChain State of AI 2023"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-state-of-ai-2023/"
date: "2023-12-21"
scraped_at: "2026-03-03T08:18:46.125009157+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

In 2023 we saw an explosion of interest in Generative AI upon the heels of ChatGPT. All companies - from startups to enterprises - were (and still are) trying to figure out their GenAI strategy.

2023 年，在 ChatGPT 掀起热潮之后，业界对生成式人工智能（Generative AI）的兴趣呈现爆发式增长。所有公司——从初创企业到大型企业——当时（至今依然）都在努力厘清自身的生成式 AI 战略。

_"How can we incorporate GenAI into our product? What reference architectures should we be following? What models are best for our use case? What is the technology stack we should be using? How can we test our LLM applications?"_

“我们如何将生成式 AI 融入自身产品？应参考哪些架构范式？哪种模型最契合我们的应用场景？应采用怎样的技术栈？又该如何测试大语言模型（LLM）应用？”

These are all questions that companies are asking themselves. In a time of such uncertainty, everyone also wants to know what everyone else is doing. There have been a [few attempts](https://retool.com/reports/state-of-ai-2023?ref=blog.langchain.com) to [shed light](https://state-of-llm.streamlit.app/?ref=blog.langchain.com) on this so far, but with LangChain's unique position in ecosystem we feel like we can shed real light into how teams are **actually** building with LLMs.

这些问题正是各家企业正在反复自问的。在如此充满不确定性的时期，每个人都渴望了解同行正在做些什么。此前已有[若干尝试](https://retool.com/reports/state-of-ai-2023?ref=blog.langchain.com)试图[揭示现状](https://state-of-llm.streamlit.app/?ref=blog.langchain.com)，但凭借 LangChain 在整个 AI 生态系统中独特的定位，我们认为自己有能力真正揭示团队**实际**构建 LLM 应用的方式。

To do this, we turn to anonymized metadata in [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com). LangSmith is our cloud platform aimed at making it easy to go from prototype to production. It provides capabilities like tracing, regression testing and evaluation, and more. While still in private beta, we are letting people off the waitlist everyday so [sign up here](https://smith.langchain.com/?ref=blog.langchain.com), and if you are interested in enterprise access or support, please [reach out](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com).

为此，我们依托 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 中的匿名化元数据展开分析。LangSmith 是我们推出的云平台，旨在大幅简化从原型开发到生产部署的全过程。它提供追踪（tracing）、回归测试、效果评估等核心能力。目前 LangSmith 仍处于私有 Beta 阶段，但我们每天都会向等候名单中的用户开放注册权限——欢迎[立即注册](https://smith.langchain.com/?ref=blog.langchain.com)；若您有企业级访问或技术支持需求，也请[联系我们](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com)。

Through this we can answer questions about **what** people are building, **how** they are building those things, and how they are **testing** those applications. All stats are taken from 2023-07-02 to 2023-12-11.

借助这些数据，我们得以回答三大关键问题：人们**正在构建什么**？他们**如何构建**这些应用？以及他们又**如何测试**这些应用？所有统计数据均采集自 2023 年 7 月 2 日至 2023 年 12 月 11 日。

## What are people building?

## 人们正在构建什么？

![](images/langchain-state-of-ai-2023/img_001.png)

![](images/langchain-state-of-ai-2023/img_001.png)

Here we take a look at some of the common things people are building.

此处我们梳理了当前一些主流的构建方向。

Although LangSmith integrates seamlessly with [LangChain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com), it is also easily usable outside of the LangChain ecosystem. We see that about 15% of usage in LangSmith come from users NOT using LangChain. We've [invested a lot of work](https://docs.smith.langchain.com/tracing/tracing-faq?ref=blog.langchain.com#how-do-i-log-to-langsmith-if-i-am-not-using-langchain) in making the [onboarding experience](https://github.com/langchain-ai/langsmith-cookbook/tree/main/tracing-examples?ref=blog.langchain.com) for ALL the above components work just as well for whether you are using LangChain or not.

尽管 LangSmith 与 [LangChain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com) 实现了无缝集成，但它同样可轻松独立于 LangChain 生态系统之外使用。数据显示，LangSmith 约 15% 的使用量来自**未使用 LangChain 的用户**。我们已[投入大量精力](https://docs.smith.langchain.com/tracing/tracing-faq?ref=blog.langchain.com#how-do-i-log-to-langsmith-if-i-am-not-using-langchain)，确保上述所有组件的[上手体验](https://github.com/langchain-ai/langsmith-cookbook/tree/main/tracing-examples?ref=blog.langchain.com)——无论您是否采用 LangChain——均保持一致的简洁高效。

[Retrieval](https://python.langchain.com/docs/modules/data_connection/?ref=blog.langchain.com) has emerged as the dominant way to combine your data with LLMs. LangChain offers integrations with [60+ vectorstores](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com) (the most common way to index unstructured data). LangChain also offers many [advanced retrieval strategies](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com). We see that 42% of complex queries involve retrieval - speaking both to the importance of retrieval and how easy LangChain has made it.

[检索（Retrieval）](https://python.langchain.com/docs/modules/data_connection/?ref=blog.langchain.com) 已成为将自有数据与大语言模型（LLM）相结合的主流方式。LangChain 提供与 [60 多种向量数据库](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com)（索引非结构化数据最常用的方式）的集成支持，并内置多种[高级检索策略](https://python.langchain.com/docs/modules/data_connection/retrievers/?ref=blog.langchain.com)。数据显示，42% 的复杂查询涉及检索环节——这既印证了检索功能的关键重要性，也反映出 LangChain 极大地降低了其实现门槛。

Finally, we see that about 17% of complex queries are part of an agent. [Agents](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) involve letting the LLM decide what steps to take, which allows your system to better handle complex queries or edge cases. However, they are still not super reliable or performant, which is probably why we don't see more.

最后，我们发现约 17% 的复杂查询属于 Agent（智能体）范畴。[Agent（智能体）](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) 是指让大语言模型（LLM）自主决定执行步骤，从而使系统能更有效地处理复杂查询或边缘情况。然而，目前 Agent 仍不够稳定、性能也不够理想，这很可能正是其使用比例尚未显著提升的原因。

## LCEL Usage

## LCEL 使用情况

![](images/langchain-state-of-ai-2023/img_002.png)

One of the big additions to LangChain over the past months has been [LangChain Expression Language](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) (or LCEL for short). This is an easy way to compose components together, making it perfect for creating complex, customized chains. It is still super early on in this whole GenAI journey, and everyone is trying to figure out how exactly to make LLMs work for them. This involves a lot of experimentation and customization. LCEL makes this easy - and we saw its usage rapidly increase over the past few months as we've added more features and improved documentation.

过去几个月中，LangChain 最重要的新增功能之一是 [LangChain 表达式语言](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com)（简称 LCEL）。这是一种便捷的组件组合方式，非常适合构建复杂且高度定制化的链（chains）。当前整个生成式 AI（GenAI）领域仍处于早期阶段，各方都在积极探索如何让大语言模型（LLM）真正服务于自身业务——这一过程涉及大量实验与定制化工作。而 LCEL 正为此提供了便利；随着我们持续增加新功能并完善文档，过去几个月中其使用率已迅速攀升。

## Most Used LLM Providers

## 最常用的 LLM 提供商

![](images/langchain-state-of-ai-2023/img_003.png)

The new technology in all of this are [LLMs](https://python.langchain.com/docs/modules/model_io/?ref=blog.langchain.com). So which LLM providers are people using?

上述所有技术革新的核心，正是 [大语言模型（LLMs）](https://python.langchain.com/docs/modules/model_io/?ref=blog.langchain.com)。那么，开发者们究竟在使用哪些 LLM 提供商呢？

To no surprise, we see [OpenAI](https://python.langchain.com/docs/integrations/chat/openai?ref=blog.langchain.com) at the top, with [AzureOpenAI](https://python.langchain.com/docs/integrations/chat/azure_chat_openai?ref=blog.langchain.com) right behind it. OpenAI has emerged as the leading LLM provider of 2023, and Azure (with more enterprise guarantees) has seized that momentum well.

不出所料，[OpenAI](https://python.langchain.com/docs/integrations/chat/openai?ref=blog.langchain.com) 高居榜首，[Azure OpenAI](https://python.langchain.com/docs/integrations/chat/azure_chat_openai?ref=blog.langchain.com) 紧随其后。OpenAI 已成为 2023 年当之无愧的领先 LLM 提供商；而 Azure（凭借更强的企业级保障能力）也成功承接并放大了这一发展势头。

Other hosting services that offer proprietary models include Anthropic (3rd), Vertex AI (4th), and Amazon Bedrock (8th).

其他提供专有模型的托管服务还包括 Anthropic（第 3 名）、Vertex AI（第 4 名）和 Amazon Bedrock（第 8 名）。

On the open source model side, we see [Hugging Face](https://python.langchain.com/docs/integrations/llms/huggingface_pipelines?ref=blog.langchain.com) (4th), [Fireworks AI](https://python.langchain.com/docs/integrations/chat/fireworks?ref=blog.langchain.com) (6th), and [Ollama](https://python.langchain.com/docs/integrations/chat/ollama?ref=blog.langchain.com) (7th) emerge as the main ways users interact with those models.

在开源模型方面，[Hugging Face](https://python.langchain.com/docs/integrations/llms/huggingface_pipelines?ref=blog.langchain.com)（第 4 名）、[Fireworks AI](https://python.langchain.com/docs/integrations/chat/fireworks?ref=blog.langchain.com)（第 6 名）和 [Ollama](https://python.langchain.com/docs/integrations/chat/ollama?ref=blog.langchain.com)（第 7 名）已成为用户接入和使用这些开源模型的主要途径。

Note that these rankings are based on number of users who have used a given provider.

请注意，上述排名基于使用过各提供商服务的用户数量。

## Most Used OSS Model Providers

## 最常用的开源模型（OSS）提供商

![](images/langchain-state-of-ai-2023/img_004.png)

A lot of attention recently has been given to open source models, with more and more providers racing to host them at cheaper and cheaper costs. So how exactly are developers accessing these open source models?

近期，开源模型备受关注，越来越多的提供商竞相以越来越低的成本托管这些模型。那么，开发者究竟如何访问这些开源模型呢？

We see that the people are mainly running them locally, with options to do so like [Hugging Face](https://python.langchain.com/docs/integrations/llms/huggingface_pipelines?ref=blog.langchain.com), [LlamaCpp](https://python.langchain.com/docs/integrations/llms/llamacpp?ref=blog.langchain.com), [Ollama](https://python.langchain.com/docs/integrations/chat/ollama?ref=blog.langchain.com), and [GPT4All](https://python.langchain.com/docs/integrations/llms/gpt4all?ref=blog.langchain.com) ranking high.

我们发现，用户主要选择在本地运行这些模型，主流方案包括 [Hugging Face](https://python.langchain.com/docs/integrations/llms/huggingface_pipelines?ref=blog.langchain.com)、[LlamaCpp](https://python.langchain.com/docs/integrations/llms/llamacpp?ref=blog.langchain.com)、[Ollama](https://python.langchain.com/docs/integrations/chat/ollama?ref=blog.langchain.com) 和 [GPT4All](https://python.langchain.com/docs/integrations/llms/gpt4all?ref=blog.langchain.com)，它们在使用率上位居前列。

Of providers offering API access to OSS models, [Fireworks AI](https://python.langchain.com/docs/integrations/chat/fireworks?ref=blog.langchain.com) leads the pack, followed by [Replicate](https://python.langchain.com/docs/integrations/llms/replicate?ref=blog.langchain.com), [Together](https://python.langchain.com/docs/integrations/llms/together?ref=blog.langchain.com), and [Anyscale](https://python.langchain.com/docs/integrations/chat/anyscale?ref=blog.langchain.com).

在提供开源模型 API 接入服务的提供商中，[Fireworks AI](https://python.langchain.com/docs/integrations/chat/fireworks?ref=blog.langchain.com) 居首，其后依次是 [Replicate](https://python.langchain.com/docs/integrations/llms/replicate?ref=blog.langchain.com)、[Together](https://python.langchain.com/docs/integrations/llms/together?ref=blog.langchain.com) 和 [Anyscale](https://python.langchain.com/docs/integrations/chat/anyscale?ref=blog.langchain.com)。

Note that these rankings are based on number of users who have used a given provider.

请注意，上述排名基于使用过各提供商服务的用户数量。

## Most Used Vectorstores

## 最常用的向量数据库（Vectorstore）

![](images/langchain-state-of-ai-2023/img_005.png)

As mentioned earlier, retrieval is a huge part of LLM applications. Vectorstores are emerging as the primary way to retrieve relevant context. In LangChain we have [60+ vectorstore integrations](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com) \- which ones are people using most?

如前所述，检索能力是大语言模型（LLM）应用中极为关键的一环。向量数据库正逐渐成为获取相关上下文信息的主要方式。在 LangChain 中，我们已支持 [60 多种向量数据库集成](https://integrations.langchain.com/vectorstores?ref=blog.langchain.com)——那么，哪些向量数据库最受用户青睐？

We see that local vectorstores are the most used, with [Chroma](https://python.langchain.com/docs/integrations/vectorstores/chroma?ref=blog.langchain.com), [FAISS](https://python.langchain.com/docs/integrations/vectorstores/faiss?ref=blog.langchain.com), [Qdrant](https://python.langchain.com/docs/integrations/vectorstores/qdrant?ref=blog.langchain.com) and [DocArray](https://python.langchain.com/docs/integrations/vectorstores/docarray_in_memory?ref=blog.langchain.com) all ranking in the top 5. These rankings are based on the number of users who had used a given vectorstore, so it makes sense that local, free vectorstores are the most used if you count that way.

我们看到，本地向量数据库（vectorstore）使用率最高，其中 [Chroma](https://python.langchain.com/docs/integrations/vectorstores/chroma?ref=blog.langchain.com)、[FAISS](https://python.langchain.com/docs/integrations/vectorstores/faiss?ref=blog.langchain.com)、[Qdrant](https://python.langchain.com/docs/integrations/vectorstores/qdrant?ref=blog.langchain.com) 和 [DocArray](https://python.langchain.com/docs/integrations/vectorstores/docarray_in_memory?ref=blog.langchain.com) 均位列前五。该排名依据的是曾使用过某一特定向量数据库的用户数量，因此若按此统计方式计算，本地化、免费的向量数据库成为最常用选项也就顺理成章。

Of the hosted offerings, [Pinecone](https://python.langchain.com/docs/integrations/vectorstores/pinecone?ref=blog.langchain.com) leads the pack as the only hosted vectorstore in the top 5. [Weaviate](https://python.langchain.com/docs/integrations/vectorstores/weaviate?ref=blog.langchain.com) follows next, showing that vector-native databases are currently more used than databases that add in vector functionality.

在托管型向量数据库中，[Pinecone](https://python.langchain.com/docs/integrations/vectorstores/pinecone?ref=blog.langchain.com) 一马当先，是唯一跻身前五的托管向量数据库；紧随其后的是 [Weaviate](https://python.langchain.com/docs/integrations/vectorstores/weaviate?ref=blog.langchain.com)，这表明当前原生支持向量能力的数据库，比后期通过插件或扩展添加向量功能的传统数据库更受青睐。

Of databases that have added in vector functionality, we see [Postgres (PGVector)](https://python.langchain.com/docs/integrations/vectorstores/pgvector?ref=blog.langchain.com), [Supabase](https://python.langchain.com/docs/integrations/vectorstores/supabase?ref=blog.langchain.com), [Neo4j](https://python.langchain.com/docs/integrations/vectorstores/neo4jvector?ref=blog.langchain.com), [Redis](https://python.langchain.com/docs/integrations/vectorstores/redis?ref=blog.langchain.com), [Azure Search](https://python.langchain.com/docs/integrations/vectorstores/azuresearch?ref=blog.langchain.com), and [Astra DB](https://python.langchain.com/docs/integrations/vectorstores/astradb?ref=blog.langchain.com) leading the pack.

在那些后期集成向量功能的数据库中，[Postgres（PGVector）](https://python.langchain.com/docs/integrations/vectorstores/pgvector?ref=blog.langchain.com)、[Supabase](https://python.langchain.com/docs/integrations/vectorstores/supabase?ref=blog.langchain.com)、[Neo4j](https://python.langchain.com/docs/integrations/vectorstores/neo4jvector?ref=blog.langchain.com)、[Redis](https://python.langchain.com/docs/integrations/vectorstores/redis?ref=blog.langchain.com)、[Azure Search](https://python.langchain.com/docs/integrations/vectorstores/azuresearch?ref=blog.langchain.com) 和 [Astra DB](https://python.langchain.com/docs/integrations/vectorstores/astradb?ref=blog.langchain.com) 表现最为突出。

Note that these rankings are based on number of users who have used a given provider.

请注意：上述排名均基于曾使用过对应服务商的用户数量。

## Most Used Embeddings

## 最常用的嵌入模型（Embeddings）

![](images/langchain-state-of-ai-2023/img_006.png)

![](images/langchain-state-of-ai-2023/img_006.png)

In order to use a vectorstore, you need to calculate embeddings for pieces of text. So how are developers doing that?

要使用向量数据库，必须先为文本片段计算嵌入向量（embeddings）。那么开发者们是如何实现这一点的呢？

Similar to LLMs, [OpenAI](https://python.langchain.com/docs/integrations/text_embedding/openai?ref=blog.langchain.com) reigns supreme - but we see more diversity after that. Open source providers are more used, with [Hugging Face](https://python.langchain.com/docs/integrations/text_embedding/huggingfacehub?ref=blog.langchain.com) coming in 2nd most used, and [GPT4All](https://python.langchain.com/docs/integrations/text_embedding/gpt4all?ref=blog.langchain.com) and [Ollama](https://python.langchain.com/docs/integrations/text_embedding/ollama?ref=blog.langchain.com) also in the top 8. On the hosted side, we see that [Vertex AI](https://python.langchain.com/docs/integrations/text_embedding/google_vertex_ai_palm?ref=blog.langchain.com) actually beats out [AzureOpenAI](https://python.langchain.com/docs/integrations/text_embedding/azureopenai?ref=blog.langchain.com), and [Cohere](https://python.langchain.com/docs/integrations/text_embedding/cohere?ref=blog.langchain.com) and [Amazon Bedrock](https://python.langchain.com/docs/integrations/text_embedding/bedrock?ref=blog.langchain.com) are not far behind.

与大语言模型（LLM）类似，[OpenAI](https://python.langchain.com/docs/integrations/text_embedding/openai?ref=blog.langchain.com) 仍居首位——但其后的格局则更为多元。开源嵌入服务使用率更高：[Hugging Face](https://python.langchain.com/docs/integrations/text_embedding/huggingfacehub?ref=blog.langchain.com) 排名第二，[GPT4All](https://python.langchain.com/docs/integrations/text_embedding/gpt4all?ref=blog.langchain.com) 和 [Ollama](https://python.langchain.com/docs/integrations/text_embedding/ollama?ref=blog.langchain.com) 同样进入前八。在托管服务方面，[Vertex AI](https://python.langchain.com/docs/integrations/text_embedding/google_vertex_ai_palm?ref=blog.langchain.com) 实际上超越了 [AzureOpenAI](https://python.langchain.com/docs/integrations/text_embedding/azureopenai?ref=blog.langchain.com)，而 [Cohere](https://python.langchain.com/docs/integrations/text_embedding/cohere?ref=blog.langchain.com) 与 [Amazon Bedrock](https://python.langchain.com/docs/integrations/text_embedding/bedrock?ref=blog.langchain.com) 的使用率也紧随其后。

## Top Advanced Retrieval Strategies

## 最主流的高级检索策略

![](images/langchain-state-of-ai-2023/img_007.png)

![](images/langchain-state-of-ai-2023/img_007.png)

仅在嵌入向量之间进行余弦相似度计算，其检索效果终究有限。我们观察到许多人依赖于[高级检索策略](https://python.langchain.com/docs/modules/data_connection/?ref=blog.langchain.com)——其中许多策略我们已在 LangChain 中实现并详细记录。

即便如此，我们所见最常用的检索策略并非内置方案，而是用户自定义的策略。这反映出两点：

1. 在 LangChain 中[实现自定义检索策略非常简便](https://blog.vespa.ai/turbocharge-rag-with-langchain-and-vespa-streaming-mode/?ref=blog.langchain.com)  
2. 为实现最优性能，往往必须引入定制化逻辑

在此之后，我们看到一些更广为人知的策略陆续出现：

- [自查询（Self Query）](https://python.langchain.com/docs/modules/data_connection/retrievers/self_query?ref=blog.langchain.com) —— 从用户提问中自动提取元数据过滤条件  
- 混合搜索（Hybrid Search）—— 主要通过供应商专属集成实现，例如 Supabase 和 Pinecone  
- [上下文压缩（Contextual Compression）](https://python.langchain.com/docs/modules/data_connection/retrievers/contextual_compression/?ref=blog.langchain.com) —— 对基础检索结果进行后处理  
- [多查询（Multi Query）](https://python.langchain.com/docs/modules/data_connection/retrievers/MultiQueryRetriever?ref=blog.langchain.com) —— 将单个查询转换为多个查询，并分别检索结果  
- [时间加权向量存储（TimeWeighted VectorStore）](https://python.langchain.com/docs/modules/data_connection/retrievers/time_weighted_vectorstore?ref=blog.langchain.com) —— 对近期文档赋予更高权重  

## 用户如何开展测试？

![](images/langchain-state-of-ai-2023/img_008.png)

[评估与测试](https://docs.smith.langchain.com/evaluation?ref=blog.langchain.com) 已成为开发者构建大语言模型（LLM）应用时遭遇的最主要痛点之一；而 LangSmith 已脱颖而出，成为[开展此类工作的最佳方式之一](https://docs.smith.langchain.com/cookbook/testing-examples?ref=blog.langchain.com)。

我们发现，大多数用户能够设计出若干评估指标来衡量其 LLM 应用的效果——在全部测试运行中，83% 的运行均关联了某种形式的反馈。而在这些带反馈的运行中，平均每条运行关联 2.3 种不同类型的反馈，表明开发者难以找到一个可完全信赖的单一指标，因而倾向于综合运用多种指标进行评估。

在所有已记录的反馈中，绝大多数[采用大语言模型（LLM）进行评估](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation)。尽管部分用户对此方法表达了担忧与迟疑，但我们对该路径持乐观态度，并在实践中观察到：LLM 驱动的评估已逐渐成为主流测试范式。另一值得注意的数据点是：近 40% 的评估器为[自定义评估器（custom evaluators）](https://docs.smith.langchain.com/evaluation/custom-evaluators?ref=blog.langchain.com)。这与我们的观察一致——评估需求往往高度依赖具体应用场景，因此并不存在一种“放之四海而皆准”的通用评估器可供直接依赖。

## What are people testing?

## 人们都在测试什么？

![](images/langchain-state-of-ai-2023/img_009.png)

We can see that most people are still primarily concerned with the [correctness](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation) of their application (as opposed to toxicity, prompt leakage, or other guardrails). We can also see from the low usage of Exact Matching as an evaluation technique that judging correctness is often quite complex (you can't just compare the output exactly as is)!

我们可以看到，大多数人目前仍主要关注其应用的[正确性](https://docs.smith.langchain.com/evaluation/evaluator-implementations?ref=blog.langchain.com#correctness-qa-evaluation)（而非毒性、提示词泄露或其他安全防护机制）。此外，从“精确匹配”（Exact Matching）这一评估方法使用率较低也可看出，判断正确性往往相当复杂（不能简单地将模型输出与标准答案逐字比对）！

## Conclusion

## 结语

As the first real year of LLM app development comes to a close, we are hearing from a lot of teams that they want to close the gap from prototype to production. Hopefully sharing these usage statistics helps shine some light on **what** people are building, **how** they are building those things, and how they are **testing** those things.

随着大语言模型（LLM）应用开发首个实质性年份即将落幕，我们听到许多团队表示，他们希望弥合从原型（prototype）到生产环境（production）之间的鸿沟。分享这些使用统计数据，希望能帮助大家更清晰地了解：人们究竟在构建**什么**、以**何种方式**构建这些应用，以及又如何对它们进行**测试**。

LangSmith is emerging as the dominant way that teams are bringing their applications from prototype to production - whether they are using LangChain or not. If you are interested in enterprise access or support, please [reach out](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com) or [sign up here](https://smith.langchain.com/?ref=blog.langchain.com).

LangSmith 正日益成为各团队将应用从原型推进至生产环境的主流方案——无论其是否采用 LangChain 框架。如果您有企业级访问或技术支持需求，欢迎[联系我们](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com)，或[立即注册](https://smith.langchain.com/?ref=blog.langchain.com)。
&#123;% endraw %}
