---
title: "Zep x LangChain: Diagnosing and Fixing Slow Chatbots"
source: "LangChain Blog"
url: "https://blog.langchain.com/zep-x-langchain-slow-chatbots/"
date: "2023-07-26"
scraped_at: "2026-03-03T09:26:40.386873146+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**_Editor’s Note: This blog post was written in collaboration with [Zep](https://www.getzep.com/?ref=blog.langchain.com), an early [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) BETA user. We've fielded a lot of questions about the latency of LangChain applications - where it comes from, how to improve. This is a FANTASTIC walkthrough of how LangSmith allows you to easily diagnose the causes of latency in your app, and how different components of the LangChain ecosystem (in this case, Zep) can be used to improve it._**

**_编者注：本文由 [Zep](https://www.getzep.com/?ref=blog.langchain.com) 与 LangChain 团队联合撰写。Zep 是 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 早期 BETA 用户之一。我们收到了大量关于 LangChain 应用延迟的问题——延迟从何而来？又该如何优化？本文是一次极为出色的实操演示：展示 LangSmith 如何帮助您轻松诊断应用中的延迟根源，以及 LangChain 生态系统中的不同组件（本文中为 Zep）如何协同提升性能。_**

## Summary

## 摘要

Poor chatbot response times can result in frustrated users and customer churn. LangChain’s new LangSmith service makes it simple and easy to understand what’s causing latency in an LLM app. In this article, we use LangSmith to diagnose a poorly performing LangChain app and demonstrate how we improved performance by an order of magnitude using the [Zep](https://www.getzep.com/?ref=blog.langchain.com) memory store.

聊天机器人响应迟缓会导致用户沮丧，进而引发客户流失。LangChain 全新推出的 LangSmith 服务，让开发者能够轻松、直观地定位大语言模型（LLM）应用中的延迟成因。本文将借助 LangSmith 对一个性能欠佳的 LangChain 应用进行诊断，并展示如何通过集成 [Zep](https://www.getzep.com/?ref=blog.langchain.com) 内存存储，将响应性能提升整整一个数量级。

**Source code for this article: https://github.com/getzep/zep-by-example/tree/main/langchain/python/langsmith-latency**

**本文源代码地址：https://github.com/getzep/zep-by-example/tree/main/langchain/python/langsmith-latency**

If you’ve ever waited several seconds for a web page to load and decided to click elsewhere, you’re not alone. Much has been written about the effect of slow websites and their [impact on user engagement and conversion rates](https://www.thinkwithgoogle.com/consumer-insights/consumer-trends/mobile-site-load-time-statistics/?ref=blog.langchain.com). Chatbot response times are no different. While responding too quickly may [shove the user into an uncanny valley](https://www.researchgate.net/publication/324949980_Faster_Is_Not_Always_Better_Understanding_the_Effect_of_Dynamic_Response_Delays_in_Human-Chatbot_Interaction?ref=blog.langchain.com), responding slowly is problematic, too. Users will become [frustrated and less likely to use your service again](https://link.springer.com/article/10.1007/s12599-022-00755-x?ref=blog.langchain.com). They may also view the [chatbot as unfair and be unwilling to share personal information](https://pubsonline.informs.org/doi/10.1287/isre.2021.1015?ref=blog.langchain.com).

如果您曾因网页加载数秒未完成而选择离开，您绝非个例。关于网站加载缓慢对用户参与度与转化率的影响，已有大量研究和报道（参见[相关数据统计](https://www.thinkwithgoogle.com/consumer-insights/consumer-trends/mobile-site-load-time-statistics/?ref=blog.langchain.com)）。聊天机器人的响应速度亦是如此。虽然响应过快可能令用户陷入“恐怖谷效应”（参见[人机交互中动态响应延迟影响的研究](https://www.researchgate.net/publication/324949980_Faster_Is_Not_Always_Better_Understanding_the_Effect_of_Dynamic_Response_Delays_in_Human-Chatbot_Interaction?ref=blog.langchain.com)），但响应过慢同样问题严重：用户将感到沮丧，[更不愿再次使用您的服务](https://link.springer.com/article/10.1007/s12599-022-00755-x?ref=blog.langchain.com)；甚至可能认为该聊天机器人“不公平”，从而[拒绝分享个人敏感信息](https://pubsonline.informs.org/doi/10.1287/isre.2021.1015?ref=blog.langchain.com)。

Unfortunately, it's pretty easy to build a slow chatbot. Between multiple chains, high LLM latency, and enriching prompts with chat histories, summaries, and results from vector databases, a lot can impact how fast your bot responds.

遗憾的是，构建一个响应迟缓的聊天机器人其实非常容易。多重链式调用、大语言模型本身固有的高延迟、以及在提示词中不断注入聊天历史、摘要内容和向量数据库检索结果等操作，都会显著拖慢机器人的响应速度。

Instrumenting and profiling your application can be challenging and very time-consuming. LangChain’s new [LangSmith service](https://blog.langchain.com/announcing-langsmith/) does this fantastically and without any need to manually instrument your app. In this article, I will walk you through an example chatbot application that while simple, is not dissimilar to one you might be building.

对应用进行埋点监控与性能剖析往往既具挑战性，又极其耗时。而 LangChain 全新推出的 [LangSmith 服务](https://blog.langchain.com/announcing-langsmith/) 则能以极佳的方式自动完成这项工作，且无需您手动添加任何埋点代码。本文将以一个看似简单、实则与您正在开发的聊天机器人高度相似的应用为例，带您完整走一遍性能诊断与优化流程。

## My Chatbot is sooo slow

## 我的聊天机器人怎么这么慢？

I’ve built a Chatbot app using LangChain, and my users are unhappy and churning.

我基于 LangChain 构建了一个聊天机器人应用，但用户反馈体验不佳，客户流失率持续攀升。

The users would like to carry on a conversation with the bot and have it not forget the context and details of prior messages in a conversation. So, when building the bot, I used a LangChain memory class. I’m also using a Retriever, backed by Chroma’s vector database, to recall relevant messages from the distant past. In the future, I might also use a Retriever to ground my app with business documents. Like many Langchain developers, I’ve used OpenAI’s APIs for LLM completion and document embeddings.

用户期望能与机器人展开连贯的多轮对话，且机器人需准确记住上下文及过往消息中的关键细节。因此，在构建该机器人时，我采用了 LangChain 提供的内存（Memory）类。此外，我还集成了基于 Chroma 向量数据库的检索器（Retriever），用于回溯遥远历史中的相关对话片段；未来，该检索器还可用于接入企业内部文档，为机器人提供业务知识支撑。与许多 LangChain 开发者一样，我选用 OpenAI 的 API 实现大语言模型文本生成与文档嵌入（embedding）功能。

Using the memory instance and retriever, my chain will inject the chat history into the prompt sent to the LLM. LLM context windows are limited, and large prompts cost more and take longer for an LLM to respond to. I, therefore, don’t want to send the entire chat history to the LLM. Instead, I’d like to limit this to the most recent messages and have my chain summarize messages in the more distant past. The prompt will look something like this:

使用内存实例（memory instance）和检索器（retriever），我的链（chain）会将聊天历史注入发送给大语言模型（LLM）的提示词中。LLM 的上下文窗口容量有限，而过长的提示词不仅成本更高，还会显著延长 LLM 的响应时间。因此，我不希望将全部聊天历史都传给 LLM；相反，我倾向于仅保留最近几轮对话，并让链自动对更早的历史消息进行摘要压缩。提示词结构大致如下所示：

![](https://blog.langchain.com/content/images/5j_ac7k8ivgn4lzwteuaq-dw5hsqozsm6-ggu1vsd6f01lzbcdmglszz_jlj3xfiwmyuxmskunwdwvhy3y72cbxj7xyf7kdtbvcgxcwqftlg-eapfn39fr_aizd3vajzqwewm-winlkaj6q1q6rz-ly.png)

![](https://blog.langchain.com/content/images/5j_ac7k8ivgn4lzwteuaq-dw5hsqozsm6-ggu1vsd6f01lzbcdmglszz_jlj3xfiwmyuxmskunwdwvhy3y72cbxj7xyf7kdtbvcgxcwqftlg-eapfn39fr_aizd3vajzqwewm-winlkaj6q1q6rz-ly.png)

To make the above happen, I’m using LangChain’s ConversationSummaryBufferMemory and VectorStoreRetrieverMemory classes.

为实现上述功能，我采用了 LangChain 提供的 `ConversationSummaryBufferMemory` 和 `VectorStoreRetrieverMemory` 类。

## LangSmith to the rescue

## LangSmith 来帮忙了

As mentioned, my chat app is too slow, and my users are churning. I really want to get to the bottom of why this is happening. In the past, I’d have to instrument the app in many different places to capture the timings of various operations, a time-consuming and tricky undertaking. Luckily, the LangChain team has already instrumented the LangChain codebase for us, and LangSmith makes it simple to understand the performance of your app. All I have to do is configure my LangSmith API key and add several descriptive tags to my code.

如前所述，我的聊天应用响应太慢，用户流失严重。我迫切希望查明性能瓶颈的根本原因。过去，我不得不在应用的多个位置手动埋点，以采集各类操作的耗时数据——这既耗时又容易出错。幸运的是，LangChain 团队已预先为整个 LangChain 代码库完成了可观测性埋点，而 LangSmith 则让应用性能分析变得极为简单：我只需配置 LangSmith API 密钥，并在代码中添加若干描述性标签即可。

For my investigation, I put together a simple test suite using 30 messages, 20 of which are preloaded into the LangChain memory class and 10 of which I use in the experiment itself. Each run of the experiment passes these 10 messages to the chain. I do this five times so that I can understand experimental variance.

为开展本次排查，我构建了一个简易测试套件，共包含 30 条消息：其中 20 条预先加载至 LangChain 的内存类中，剩余 10 条则用于实际实验。每次实验运行均将这 10 条消息依次传入链中处理。我共执行该实验五次，以便评估实验结果的波动性（variance）。

The results in LangSmith are below. Each run of 10 messages has a unique name and is the parent to several chain runs.

LangSmith 中的测试结果如下所示。每次运行的 10 条消息均拥有唯一名称，并作为若干子链（chain run）的父级追踪节点。

![](https://blog.langchain.com/content/images/xqj9ehnyopewvq0gs_rzaezmhl9xnuv2gwt5dmmpymw2kexpaod0urd3osfs6qccq56oq0fhlo7spo3iwroz3vs5gsbez390klehgj64o4twkltlnh1mx6dvizbmsycmu304nyz-4rkkh0nbuatnlaw.png)

![](https://blog.langchain.com/content/images/xqj9ehnyopewvq0gs_rzaezmhl9xnuv2gwt5dmmpymw2kexpaod0urd3osfs6qccq56oq0fhlo7spo3iwroz3vs5gsbez390klehgj64o4twkltlnh1mx6dvizbmsycmu304nyz-4rkkh0nbuatnlaw.png)

Latency is clearly visible in the LangSmith UI with poor latency marked in red. I can easily drill down into each run of the experiment to better understand why this is occurring. All experiment runs are slow, with a mean of over 7–13s to respond to each message. One of the runs is a significant outlier.

LangSmith 界面中可清晰识别延迟问题，高延迟项以红色高亮标出。我可以轻松下钻至每一次实验运行，深入分析其性能瓶颈。所有五次实验运行均表现迟缓，平均每条消息响应耗时超过 7–13 秒；其中一次运行更是显著偏离正常范围，成为明显异常值。

![](https://blog.langchain.com/content/images/qjbb8t_xlcsu3nxvtdrejtmgy_imgcg5jh6evxplx4uadke_uoue4qrk9ykcernzdoabuuwo3h0xwcsfzh-vrvlguco_18s1ns8d6fsgjhyr8m6ty9ueqgk8u7d4zt5sfenrmkjelcjccd7ouoa2v3s.png)

![](https://blog.langchain.com/content/images/qjbb8t_xlcsu3nxvtdrejtmgy_imgcg5jh6evxplx4uadke_uoue4qrk9ykcernzdoabuuwo3h0xwcsfzh-vrvlguco_18s1ns8d6fsgjhyr8m6ty9ueqgk8u7d4zt5sfenrmkjelcjccd7ouoa2v3s.png)

Drilling into that chain, I see a poor response time from the OpenAI API, taking over 5 minutes to respond to the request. It’s possible that the initial request failed and there were retries. Unfortunately, the OpenAI API can sometimes see rate-limiting and high variance in latency.

进一步下钻至该异常链路，我发现 OpenAI API 响应极慢——单次请求耗时竟超过 5 分钟。这很可能是初始请求失败后触发了重试机制所致。遗憾的是，OpenAI API 有时会遭遇限流（rate-limiting），且其延迟本身也存在较大波动性。

Let’s put aside the outlier and work to understand why each message turn of our chatbot is slow.  

让我们先搁置这个异常值，转而深入分析为何我们聊天机器人的每一轮消息响应都如此缓慢。

I noticed that the majority of the time my chain spends responding to my users is the result of the ConversationSummaryBufferMemory’s summarization chain.  

我注意到，我的链在响应用户请求时所耗费的大部分时间，都源于 `ConversationSummaryBufferMemory` 的摘要生成链。

For an arbitrarily selected response turn, summarization takes almost 6s of the 7s total response time. And this occurs every single time our chatbot runs. That’s not good.  

以某次随机选取的响应轮次为例，摘要生成耗时近 6 秒，占总响应时间（7 秒）的绝大部分；而且每次聊天机器人运行时都会重复这一过程。这显然不可接受。

![](https://blog.langchain.com/content/images/h6vqgn6llg_2v3wz33sf6zhsd9qc-6ldelu-q5wcdxkezufesw5hn6hhxv7vgloqpobxnxydtwkmt5lbouloqw5ipgxscnh8grexkcyykaed7m4zwt5qa70knozsbqiyxjudi0tkpk1evb4atseboyy.png)

## Using Zep as an alternative memory service

## 使用 Zep 作为替代的记忆服务

[Zep is an open source long-term memory store](https://docs.getzep.com/?ref=blog.langchain.com) that persists, summarizes, embeds, indexes, and enriches LLM app / chatbot histories.  

[Zep 是一个开源的长期记忆存储系统](https://docs.getzep.com/?ref=blog.langchain.com)，可持久化保存、自动摘要、嵌入向量化、索引构建，并增强大语言模型（LLM）应用/聊天机器人的对话历史。

Importantly, Zep is fast. Summarization, embedding, and message enrichment all happen asynchronously, outside of the chat loop.  

尤为重要的是，Zep 性能优异：摘要生成、向量嵌入及消息增强等操作均异步执行，完全脱离聊天主循环。

It also supports stateless app architectures as chat histories are not held in memory, unlike ConversationSummaryBufferMemory and many other LangChain memory classes.  

此外，Zep 支持无状态应用架构——对话历史不驻留于内存中，这与 `ConversationSummaryBufferMemory` 及 LangChain 中许多其他记忆类形成鲜明对比。

Zep’s ZepMemory and ZepRetriever classes are shipped in the LangChain codebase for Python and JS and are drop-in replacements for LangChain’s native classes.  

Zep 提供的 `ZepMemory` 和 `ZepRetriever` 类已集成至 LangChain 的 Python 与 JavaScript 代码库中，可直接替换 LangChain 原生对应类，实现无缝迁移。

Rerunning the experiment with Zep is super simple. I installed the Zep server using Zep’s docker-compose setup and modified my code.  

使用 Zep 重跑实验极为简便：我通过 Zep 提供的 `docker-compose` 方案部署了 Zep 服务端，并对原有代码做了少量修改。

![](https://blog.langchain.com/content/images/swgcqmt6vubpvnsht4cxgg04x_tlszardhetksmhykf39u1tp8fqcdjgqvs-6nbe-lyewfauyvlcpoy0ftxllq20xgdr4tzz7pv9tjh5jtcl8uwnpqjwewcg-j0apteumnnczs_mezapkffi-ismgvu.png)

I also don’t need to use a separate vector database for semantically retrieving historical chat memories. Zep automatically embeds and indexes messages.  

我也不再需要额外引入独立的向量数据库来语义化检索历史聊天记录——Zep 会自动完成消息的嵌入与索引。

The results in LangSmith are below. The total chain runtime for each experiment run is down to ~16 seconds, almost entirely explained by OpenAI API latency. Zep generates summaries in the background, which are automatically added by the ZepMemory instance to my prompt alongside the most recent chat history.  

LangSmith 中的实验结果如下图所示：每次实验运行的链总耗时已降至约 16 秒，几乎全部由 OpenAI API 的延迟造成。Zep 在后台异步生成摘要，`ZepMemory` 实例会自动将这些摘要连同最新聊天历史一并注入我的提示词（prompt）中。

![](https://blog.langchain.com/content/images/zxodv4ltg4nku2afxgyihi2xtwngmvr4wrcnmu6afa2ghvl18vuf6vhsaznurupu7lqofth0ttnjc4zpntxkvuu-hrhogoaplvzzmnlbo7z-rcm5kgy_8f-tbew4hv0ogiqdktmbdnayda-81_19sni.png)

There’s an outlier chain run: OpenAI’s API spikey latency strikes again!  

其中出现了一次异常的链运行：OpenAI API 的尖峰延迟再次发威！

Let’s take a more quantitative look at the data. First comparing the distribution of run times, p95 and p99 for each experiment. There were 5 experiments, and we ran them for both chains using the ConversationSummaryBufferMemory and ZepMemory. The chart below uses a log scale for latency. As we saw above, Zep’s runtimes were an order of magnitude lower.

让我们更定量地审视一下这些数据。首先，对比每个实验中运行时间的分布、p95 和 p99 值。共进行了 5 组实验，且对使用 `ConversationSummaryBufferMemory` 和 `ZepMemory` 的两条链路均执行了全部实验。下方图表的延迟（latency）坐标轴采用对数刻度。如前所述，Zep 的运行时间低了一个数量级。

![](https://blog.langchain.com/content/images/iw3ur79ba5tt96idpk827k2v9wvflqg_wphplbb025joadd4qjk9s2sv5q_upbqc5urotayx4iev0f_qlcmiidh4lp_3th1e2lnzssxjag4fdxeiisx9sm78rlelswjgg8tjddynszp3vffewyoh0-y.png)![](https://blog.langchain.com/content/images/2023/07/screenshot-2023-07-24-at-8.03.08-am.png)

For good measure, I also analyzed the impact of the VectorStoreRetrieverMemory on the app’s response time below.

为严谨起见，我还进一步分析了 `VectorStoreRetrieverMemory` 对应用响应时间的影响（如下图所示）。

![](https://blog.langchain.com/content/images/2ob69ctdslgbmyd1ls8ddn9f8fmg9kaioplhrjrbewt1arb-zopqgy9ojuctnhopu15mhcc0nn3n7mgklz-vvhx2ikc5vl7d6tkgf-pdflwoqfdpzownsrhasldjr9aegqmbyjtku3odakaf84hdcu4.png)

While certainly not as problematic as the ConversationSummaryBufferMemory, the VectorStoreRetrieverMemory and OpenAI for embeddings were still far slower than using the ZepRetriever. Zep can be configured to use a SentenceTransformer embedding model running in the Zep service, which [offers far lower latency than calling out to the OpenAI embedding service](https://www.getzep.com/text-embedding-latency-a-semi-scientific-look/?ref=blog.langchain.com).

尽管其问题显然不如 `ConversationSummaryBufferMemory` 严重，但 `VectorStoreRetrieverMemory` 配合 OpenAI 嵌入模型仍远慢于使用 `ZepRetriever`。Zep 支持配置在 Zep 服务内部运行的 `SentenceTransformer` 嵌入模型，该方案的延迟[显著低于调用 OpenAI 嵌入服务](https://www.getzep.com/text-embedding-latency-a-semi-scientific-look/?ref=blog.langchain.com)。

## Summing it all up

## 全文总结

I’ve demonstrated how to diagnose LangChain chatbot app latency issues using the new LangSmith service. The culprit here was the ConversationSummaryBufferMemory implementation, which I easily swapped out with Zep, seeing a magnitude-level improvement in latency. LangSmith is a great platform for more than just diagnosing latency issues, with tools for testing and evaluating the correctness of chains and more.

本文演示了如何借助全新的 LangSmith 服务诊断 LangChain 聊天机器人应用的延迟问题。问题根源在于 `ConversationSummaryBufferMemory` 的实现；我仅需将其轻松替换为 Zep，便实现了延迟一个数量级的显著改善。LangSmith 不仅是诊断延迟问题的利器，更是一个功能全面的平台，支持对链（chains）的正确性进行测试与评估等更多任务。

## Experimental Setup

## 实验环境配置

I ran all tests on my Apple M1 Pro 14” 16GB RAM. For the Zep results, I ran the standard Zep v0.8.1 docker-compose setup with Docker configured for 4GB RAM and 4 cores.

所有测试均在我配备 Apple M1 Pro 芯片、14 英寸屏幕及 16GB 内存的笔记本电脑上完成。针对 Zep 的测试结果，我采用了标准的 Zep v0.8.1 docker-compose 部署方案，并将 Docker 配置为分配 4GB 内存和 4 个 CPU 核心。

The LLM used for all tests was OpenAI’s gpt-3.5-turbo and for embeddings, I used the OpenAI text-embedding-ada-002 model. For software, I used LangChain 0.0.239, ChromaDB 0.4.2, and Python 3.11.

所有测试中使用的大型语言模型（LLM）均为 OpenAI 的 `gpt-3.5-turbo`；嵌入（embeddings）则采用 OpenAI 的 `text-embedding-ada-002` 模型。软件环境包括：LangChain 0.0.239、ChromaDB 0.4.2 以及 Python 3.11。

All tests were run 5 times consecutively. All runs started with a new vector DB collection or index created from historical conversations. There was a short cooling-off period between runs.

所有测试均连续运行 5 次。每次运行均从基于历史对话新建的向量数据库集合（collection）或索引（index）开始。两次运行之间设有短暂的冷却期。

## Next Steps

## 下一步

- [注册](https://smith.langchain.com/?ref=blog.langchain.com) LangSmith 测试版
- 使用 [快速入门指南](https://docs.getzep.com/deployment/quickstart/?ref=blog.langchain.com) 完成 Zep 的环境搭建

### Tags

### 标签


[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)


[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
