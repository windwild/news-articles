---
render_with_liquid: false
title: "Building (and Breaking) WebLangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/weblangchain/"
date: "2026-01-06"
scraped_at: "2026-03-03T07:14:47.104603659+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

## Important Links:

## 重要链接：

- 托管版 WebLangChain  
- [WebLangChain 的开源代码](https://github.com/langchain-ai/weblangchain?ref=blog.langchain.com)

## Introduction

## 引言

大语言模型（LLM）的一大短板在于：它们只能回答其训练数据中已包含的问题。除非你能将 LLM 连接到外部知识源或计算能力——而这正是 LangChain 诞生的初衷：赋能此类连接。在众多可接入的知识源中，互联网是最受欢迎的选择之一，例如 You.com、Perplexity 和 ChatGPT 浏览功能。本文将展示如何构建一个基于 [Tavily](https://app.tavily.com/?ref=blog.langchain.com) 的开源网络研究助手。

即使只是构建这类应用中最简单的一个版本，也需要做出大量看似微小、却影响深远的工程决策。为清晰呈现这一过程，我们将以极其详尽的方式，逐步剖析构建此类应用所涉及的每一项关键决策。随后，我们还会主动“破坏”自己构建的应用——通过构造具有对抗性的搜索查询来检验其鲁棒性。此举旨在直观揭示此前各项工程决策所带来的权衡与取舍。我们的讨论将主要聚焦于适用于所有 RAG（检索增强生成）应用的通用工程决策，仅少量涉及网页特有的技术细节。

我们希望本文能带来三方面价值：  
第一，通过展示具体导致该应用失效的查询示例，帮助读者理解工程决策如何直接映射到最终产品体验，从而更深入地认识 LLM 驱动系统的固有局限；  
第二，我们尝试系统性地阐释“为何选择某项工程决策”——逐条分析各项方案的优缺点，并说明最终选定当前方案的理由。我们希望这能为构建 LLM 应用时所需考量的各类工程权衡提供切实洞见；  
第三，我们公开全部源代码。我们期望这能让你轻松上手，快速开启属于你自己的 LLM 应用开发之旅。

## Retrieval Augmented Generation

## 检索增强生成（RAG）

在底层实现上，这类网络研究工具依赖一种名为“检索增强生成”（Retrieval-Augmented Generation，简称 RAG）的技术。关于该主题的深度解析，可参阅 [这篇文章](https://scriv.ai/guides/retrieval-augmented-generation-overview/?ref=blog.langchain.com)。RAG 的高层逻辑可概括为两个步骤：

- **检索（Retrieval）**：从外部源中检索相关信息；  
- **增强生成（Augmented Generation）**：结合检索到的信息，生成对用户问题的回答。

尽管这两个步骤看似简单，但其背后实际蕴含着相当复杂的工程细节。

## Retrieval

## 检索

The first thing these web researchers do is look up things from the internet. Although this may seem simple, there's actually MANY interesting decisions to be made here. These decisions are not specific to internet search applications - they are ones that all creators of RAG applications need to make (whether they realize it or not).

这些网络研究员首先做的，就是从互联网上检索信息。尽管这看似简单，但其中实际上涉及**大量值得深思的决策**。这些决策并非仅限于互联网搜索类应用——所有 RAG（检索增强生成）应用的构建者都必须面对（无论他们是否意识到这一点）。

- Do we ALWAYS look something up?  
- 我们是否**始终执行检索**？  

- Do we look up the raw user search query or a derived one?  
- 我们是直接使用用户的原始搜索查询，还是对其加工（如改写、扩展、重述）后再检索？  

- What do we do for follow up questions?  
- 面对后续问题（follow-up questions），我们如何处理检索？  

- Do we look up multiple search terms or just one?  
- 我们是一次只检索一个关键词/短语，还是并行检索多个？  

- Can we look things up multiple times?  
- 我们是否允许在单次对话流程中**多次检索**？  

There are also some decisions that are more specific to web research in general. We will spend less time here because these are less generalizable.

此外还有一些决策更具网络研究场景特异性。我们在此着墨较少，因为它们的通用性较低。

- What search engine should we use?  
- 应选用哪一种搜索引擎？  

- How do we get information from that search engine?  
- 我们如何从该搜索引擎获取信息（例如：调用 API、解析 HTML、处理反爬机制等）？  

**Do we ALWAYS look something up?**

**我们是否始终执行检索？**

One decision you'll have to make in your RAG application is whether you always want to look something up. Why would you NOT want to always look something up? You may not want to always look something up if you are intending your application to be more of a general purpose chat bot. In this situation, if users are interacting with your application and saying "Hi" you don't need to do any retrieval, and doing so is just a waste of time and tokens. You could implement this logic of whether to look things up in a few ways. First, you could have a simple classification layer to classify whether it's worth looking something up or not. Another way to do this would be to allow an LLM to generate search queries, and just allow it generate a empty search query in situations when it doesn't need to look something up. There are several downsides of not always looking something up. First, this logic could take more time/cost more than is worth it (e.g. it may need to be an extra LLM call). Second, if you have a strong prior that users are using you as a search tool and not a general purpose chat bot, you are adding in the possibility of making a mistake and not looking something up when you should.

在您的 RAG 应用中，您必须做出的一项关键决策，就是是否**始终执行检索**。那么，为何有时**不应**始终检索？如果您希望自己的应用更接近一个通用型聊天机器人（general-purpose chatbot），就可能不希望强制检索。例如，当用户向您的应用打招呼说“Hi”时，根本无需任何检索；强行检索只会白白消耗时间与 token。实现“是否检索”的判断逻辑，有多种方式：其一，可引入一个轻量级分类模块，用于判断当前请求是否值得检索；其二，可让大语言模型（LLM）自主生成搜索查询，而在无需检索时，允许其输出空查询（empty search query）。但“非始终检索”也存在若干弊端：第一，该判断逻辑本身可能耗时过长或成本过高（例如需额外调用一次 LLM）；第二，若您有较强先验认知——即用户主要将您的应用当作检索工具而非通用聊天机器人——那么引入该判断逻辑反而增加了“本该检索却未检索”的出错风险。

For our application, we chose to always look something up. We chose this because we are attempting to recreate a web researcher. This gives us a strong prior that our users are coming to us for research, and so the desired behavior is almost always looking things up. Adding some logic to decide whether or not to do that is likely not worth the cost (time, money, probability of being wrong).

在我们的应用中，我们选择**始终执行检索**。这一选择源于我们的目标：复现一位网络研究员的行为模式。这使我们拥有一个强先验——用户访问我们的系统，目的就是开展研究；因此，“执行检索”几乎总是最符合预期的行为。为判断是否检索而额外增加逻辑层，其综合成本（时间、金钱、误判概率）很可能得不偿失。

This does have some downsides - if we decide to look things up always, it's a bit weird if someone is trying to have a normal conversation with it.

当然，这一策略也有其短板：如果我们坚持始终检索，当用户试图进行日常自然对话时，体验就会略显怪异。

![](images/building-and-breaking-weblangchain/img_001.png)

**Do we look up the raw user search query or a derived one?**

**我们是直接查找用户原始搜索查询，还是查找其衍生查询？**

The most straightforward approach to RAG is to take the user's query and look up that phrase. This is fast and simple. However, it can have some downsides. Namely, the user's input may not be exactly what they are intending to look up.

RAG 最直接的实现方式，是直接使用用户的原始查询语句进行检索。这种方式速度快、实现简单。但也有若干缺点：用户的输入未必精准反映其真实检索意图。

One big example of this is rambling questions. Rambling questions can often contain a bunch of words that distract from the real question. Let's consider the search query below:

一个典型例子是冗长啰嗦的问题（rambling questions）。这类问题常夹杂大量无关词汇，严重干扰对核心问题的识别。请看下方这个搜索查询：

> hi there! I want to know the answer to a question. is that okay? lets assume it is. my name is harrison, the ceo of langchain. i like llms and openai. who is maisie peters?

> 你好！我想问一个问题，这样可以吗？我们姑且假设可以。我叫哈里森，是 LangChain 的 CEO。我喜欢大语言模型和 OpenAI。Maisie Peters 是谁？

The real question we want to answer is "who is maisie peters" but there is a LOT of distracting text there. One option to handle this would be to not use the raw question but rather generate a search query from the user question. This has the benefit of generating an explicit search query. It has the downside of adding an extra LLM call.

我们真正需要回答的问题其实是“Maisie Peters 是谁？”，但其中混杂了大量干扰性文字。一种应对方案是：不直接使用原始问题，而是基于用户提问生成一个精炼的检索查询。该方法的优势在于能产出明确、聚焦的检索关键词；劣势则是额外引入一次大语言模型（LLM）调用。

For our application, we assume that most INITIAL user questions are pretty direct, so we're going to just look up the raw query. This has the downside of failing badly for questions like the above:

在本应用中，我们假设大多数**初始用户提问**都较为直接简洁，因此选择直接检索原始查询。但这一策略在面对上述冗长问题时会严重失效：

![](images/building-and-breaking-weblangchain/img_002.png)

![](images/building-and-breaking-weblangchain/img_002.png)

As you can see, we fail to fetch any relevant sources and the response is based purely from the LLM's knowledge, not incorporating any external data.

如图所示，系统未能检索到任何相关资料，最终回复完全依赖 LLM 自身知识，未融合任何外部数据。

**What do we do for follow up questions?**

**对于后续追问，我们该如何处理？**

One very important situation to consider for chat based RAG applications is what to do in the event of follow up questions. The reason this is so important is that follow up questions present a bunch of interesting edge cases:

在面向对话场景的 RAG 应用中，一个极为关键的设计考量是：如何处理用户的后续追问（follow-up questions）。其重要性在于，这类追问会引发一系列颇具挑战性的边界情况（edge cases）：

- What if the follow up question indirectly references previous conversation?  
- 如果后续问题间接引用了之前的对话，该怎么办？

- What if the follow up question is completely unrelated?  
- 如果后续问题与之前的内容完全无关，又该怎么办？

There are generally two common ways of handling follow up questions:  
通常有两种常见方式来处理后续问题：

- Just search the follow up question directly. This is good for completely unrelated questions, but breaks down when the follow up questions reference the previous conversation.  
- 直接对后续问题本身进行搜索。这种方式适用于完全无关的问题，但当后续问题涉及先前对话内容时，效果会显著下降。

- Use an LLM to generate a new search query (or queries). This generally works well, but does add some additional latency.  
- 使用大语言模型（LLM）生成一个新的搜索查询（或多个查询）。这种方式通常效果良好，但会额外增加一定的延迟。

For follow up questions, there is a much higher probability that they would not be a good standalone search query. For that reason, the extra cost and latency of an additional query to generate a search query is worth it. Let's see how this allows us to handle follow ups.  
对于后续问题而言，其本身作为独立搜索查询的有效性往往较低。正因如此，为生成优质搜索查询而额外发起一次请求所带来的成本与延迟是值得的。下面我们来看看这种方式如何帮助我们更好地处理后续问题。

First, let's follow up with "what are some of her songs?". The generation of a search query allows us to get bad relevant search results.  
首先，我们以“她有哪些歌曲？”作为后续问题进行尝试。通过生成搜索查询，我们得以规避相关性差的搜索结果。

![](images/building-and-breaking-weblangchain/img_003.png)  
![](images/building-and-breaking-weblangchain/img_003.png)

A side benefit of this is that we can now handle rambling questions. If we re-ask the same rambling question as before, we now get much better results.  
这一方法还有一个附带好处：我们现在能够有效应对冗长啰嗦的问题。如果我们再次提出之前那个同样冗长的问题，现在就能获得明显更优的结果。

![](images/building-and-breaking-weblangchain/img_004.png)  
![](images/building-and-breaking-weblangchain/img_004.png)

This time, it gets good results.  
这一次，系统返回了高质量的结果。

You can see the prompt we are using to rephrase search queries [here](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.com).  
您可在此处查看我们用于重写搜索查询的提示词（prompt）：[链接](https://smith.langchain.com/hub/langchain-ai/weblangchain-search-query?ref=blog.langchain.com)。

**Do we look up multiple search terms or just one?**

**我们是查找多个搜索词，还是仅查找一个？**

Okay, so we're going to use an LLM to generate a search term. The next thing to figure out — is it always ONE search term? Or it could be multiple search terms? And if multiple search terms, could it sometimes be zero search terms?

好的，我们将使用大语言模型（LLM）来生成搜索词。接下来需要明确的问题是：是否**始终只生成一个搜索词**？还是**可以生成多个搜索词**？如果允许多个搜索词，那么是否也允许生成**零个搜索词**（即不生成任何搜索词）？

The benefits of allowing for a variable number of search terms is more flexibility. The downside is more complexity. Is that complexity worth it?

允许可变数量的搜索词带来的好处是**更高的灵活性**；而代价则是**更高的实现复杂度**。这种复杂度是否值得付出？

The complexity of allowing for zero search terms probably isn't. Similar to the decision we had to make of whether to always look something up, we're assuming people are using our web research app because they want to look something up. So it would make sense to always generate a query.

允许生成零个搜索词所带来的复杂度，很可能**并不值得**。这类似于我们之前必须做出的一个设计决策：是否**总是执行一次信息检索**？我们假设用户使用本网络研究应用，正是为了查找某些信息。因此，**始终生成一个查询**是合理且符合直觉的设计。

Generating multiple queries probably wouldn't be that bad, but it would add more longer look up times. In order to keep things simple, in this application we will just generate one search query.

生成多个查询本身问题不大，但会显著增加整体检索耗时（因为需并行或串行发起多次搜索请求）。为保持系统简洁，在本应用中，我们**仅生成一个搜索查询**。

However, this has it's downsides. Let's consider the question below:

然而，这一设计也存在明显缺陷。请看下面这个问题：

> who won the first nfl game of 2023? who won the womens world cup in 2023?

> 2023年第一场NFL比赛的获胜方是谁？2023年女足世界杯的冠军是谁？

This is asking two very distinct things. In the results below, we can see that all the retrieved sources are only about one of the things (they are all related to who won the womens world cup in 2023). As a result, it gets confused and is unable to answer the first part of the question (and infact, fails to answer the question at all).

这个问题实际包含了两个**完全独立、互不相关的子问题**。在下方检索结果中可以看到：所有被召回的资料来源**仅围绕其中一个问题展开**（全部聚焦于“2023年女足世界杯冠军”），导致模型陷入混淆，既无法回答第一个子问题，最终甚至**完全无法回答整个问题**。

![](images/building-and-breaking-weblangchain/img_005.png)

![](images/building-and-breaking-weblangchain/img_005.png)

**Can we look things up multiple times?**

**能否进行多次信息检索？**

Most RAG applications only do a single lookup step. However, there can be benefits to letting it do multiple lookup steps.

大多数 RAG 应用仅执行单次检索步骤。然而，允许其执行多次检索步骤可能带来一定优势。

Note that this is distinct from generating multiple search queries. When generating multiple search queries, these can searched in parallel. The motivation behind allowing for multiple lookup steps is that a final answer may depend on results of previous lookup steps, and these lookups need to be done sequentially. This is less commonly done in RAG applications because it adds even more cost and latency.

请注意，这与生成多个搜索查询有本质区别。当生成多个搜索查询时，这些查询可并行执行；而支持多次检索步骤的动机在于：最终答案可能依赖于前序检索步骤的结果，因此这些检索必须按顺序进行。由于这会进一步增加成本和延迟，RAG 应用中较少采用这种设计。

This decision represents a pretty big fork in the road, and is one of the largest differences between ChatGPT Browsing (where it can look things up multiple times) compared to Perplexity (where it does not). This also represents a big decision between two very different type of apps.

这一决策堪称一条关键的分水岭，也是 ChatGPT 浏览功能（支持多次在线检索）与 Perplexity（仅支持单次检索）之间最显著的差异之一。它同时也代表了两种截然不同的应用范式之间的重大取舍。

The ones that can look things up multiple times (like ChatGPT Browsing) start become agent-like. This has its pros and cons. On the plus side, it allows these apps to answer a longer tail of more complicated questions below. However, this generally comes at the cost of latency (these apps are slower) and reliability (they can sometimes go off the rails).

那些支持多次检索的应用（如 ChatGPT 浏览功能）开始呈现出类智能体（agent-like）特征。这既有优势，也有弊端。优势在于，它们能够回答更长尾、更复杂的问题；但代价通常是更高的延迟（响应更慢）和更低的可靠性（有时会偏离正轨）。

The ones that can't (like Perplexity) are the opposite - they are generally faster and more reliable, but less able to handle a long tail of complicated questions.

而无法多次检索的应用（如 Perplexity）则恰恰相反——它们通常响应更快、更稳定可靠，但在应对长尾复杂问题方面能力较弱。

As an example of this, let's consider a question like:

作为实例，我们来看这样一个问题：

> Who won the womens world cup in 2023? What is the GDP of that country?

> 2023 年女子世界杯冠军是哪个国家？该国的 GDP 是多少？

Given that Perplexity doesn't look things up multiple times, we wouldn't expect it to be able to handle this case very well. Let's try it out:

鉴于 Perplexity 不支持多次检索，我们不期望它能很好地处理此类问题。我们来实际测试一下：

![](images/building-and-breaking-weblangchain/img_006.png)

![](images/building-and-breaking-weblangchain/img_006.png)

It gets the first part right (Spain did win the world cup) but since it can't look things up twice it doesn't get the second question right.

它正确回答了第一问（西班牙确实赢得了世界杯），但由于无法进行第二次检索，因而未能答出第二问。

Let's now try this out with ChatGPT Browsing. Since this can perform multiple actions, there is the chance it can answer this correctly. However, there is always the chance it goes off the rails. Which one will it be?

让我们现在用 ChatGPT 浏览功能来尝试一下。由于该功能可执行多项操作，因此它有可能正确回答这个问题。然而，它也始终存在“跑偏”的风险——究竟会是哪一种情况呢？

![](images/building-and-breaking-weblangchain/img_007.png)

In this case it handles it perfectly! However, this is far from a given. As an example of things going off the rails, let's see how it handles the previous question that really contained two separate sub questions:

本例中，它表现得堪称完美！但这种情况绝非理所当然。作为“跑偏”的一个典型示例，我们来看看它如何处理之前那个实际上包含两个独立子问题的问题：

![](images/building-and-breaking-weblangchain/img_008.png)

This isn't terrible, but it's also not perfect. It's also worth noting that both of these questions took significantly longer to get answers for than Perplexity.

这个结果虽不算糟糕，但也远谈不上完美。此外还值得注意的是：这两个问题的响应耗时均明显长于 Perplexity。

Our experience building these types of applications is that at some point you have to choose between a faster application that is a bit more limited, or a slower application that can cover a wider variety of tasks. This slower application is often much more prone to going off the rails and generally a lot harder to get right. For our web research assistant we opted for the fast chat experience. This means that does not handle multi-part questions that well:

我们在构建此类应用的过程中发现：在某个阶段，你必须在两种方案之间做出权衡——要么选择响应更快但能力略为受限的应用；要么选择响应较慢但能覆盖更广泛任务类型的应用。而后者往往更容易“跑偏”，且整体上更难调优至理想状态。对于我们的网络研究助手，我们选择了快速聊天体验。这意味着它对多部分（multi-part）问题的处理能力相对较弱：

![](images/building-and-breaking-weblangchain/img_009.png)

**What search engine should we use?**

**我们应该选用哪种搜索引擎？**

**How do we get information from that search engine?**

**我们该如何从该搜索引擎获取信息？**

These questions are more specific to web research assistants, but are still interesting to consider. There's really two approaches to consider:

这些问题虽更聚焦于网络研究助手这一特定场景，但仍值得深入探讨。实际上，我们主要需考虑两种可行路径：

1. 使用某个搜索引擎获取顶部搜索结果及对应网页中的摘要片段  
1. Use some search engine to get the top results and corresponding snippets from that page  

2. 使用某个搜索引擎获取顶部搜索结果，然后对每个网页单独发起请求并加载其完整文本  
2. Use some search engine to get the top results, and then make a separate call to each page and load the full text there  

方法 #1 的优势在于速度快；方法 #2 的优势在于能获取更完整的信息。  
The pros of approach #1 is that it's fast. The pros of approach #2 is that it will get more complete information.  

在我们的应用中，我们使用 [Tavily](https://app.tavily.com/?ref=blog.langchain.com) 执行实际的网页抓取任务。Tavily 是一款专为 AI 智能体设计的搜索 API，特别针对 RAG（检索增强生成）场景进行了优化。借助 Tavily 搜索 API，AI 开发者可轻松将应用程序与实时在线信息集成。Tavily 的核心目标是从可信信源中提供客观、可靠的信息，从而提升 AI 生成内容的准确性与可信度。  
For our app, we are using [Tavily](https://app.tavily.com/?ref=blog.langchain.com) to do the actual webscraping. Tavily is a search API, specifically designed for AI agents and tailored for RAG purposes. Through the Tavily Search API, AI developers can effortlessly integrate their applications with realtime online information. Tavily’s primary objective is to provide factual and reliable information from trusted sources, enhancing the accuracy and reliability of AI-generated content.  

我们尤其欣赏 Tavily 的以下几点：  
The things we particularly like about Tavily:  

- 速度快  
- It's fast  

- 为每个网页返回质量良好的摘要片段，因此我们无需逐一加载全部网页  
- It returns good snippets for each page so we don't have to load each page  

- 同时还返回图片（很有趣！）  
- It also returns images (fun!)  

### 检索流程总结  
### Summary of Retrieval  

综上所述，我们网络研究助手所采用的检索算法如下：  
In summary, the retrieval algorithm our web research assistant is using:  

- 对于首个问题，直接将其传入搜索引擎  
- For a first question, pass that directly to the search engine  

- 对于后续问题，则基于对话历史生成一个独立、自包含的搜索查询，并将其传入搜索引擎  
- For follow up questions, generate a single search query to pass to the search engine based on the conversation history  

- 使用 Tavily 获取搜索结果（含摘要片段）  
- Use Tavily to get search results, including snippets  

当我们实现该逻辑时，最终代码结构如下所示：  
When we implement this, it ends up looking like the below:  

```
if not use_chat_history:
    # 如果没有聊天历史，我们直接将问题传给检索器
    initial_chain = itemgetter("question") | retriever
    return initial_chain
else:
    # 如果存在聊天历史，我们首先生成一个独立的问题
    condense_question_chain = (
        {
        "question": itemgetter("question"),
        "chat_history": itemgetter("chat_history"),
        }
        | CONDENSE_QUESTION_PROMPT
        | llm
        | StrOutputParser()
    )
    # 然后将该独立问题传给检索器
    conversation_chain = condense_question_chain | retriever
    return conversation_chain
```

We can see that if there is no `chat_history`, then we just pass the question directly to the search engine. If there is a `chat_history`, we use an LLM to condense the chat history into a single query to send to the retriever.

我们可以看到：如果没有 `chat_history`，则直接将问题传递给搜索引擎；如果存在 `chat_history`，我们则使用大语言模型（LLM）将聊天历史压缩为单个查询，再发送给检索器。

## Augmented Generation

## 增强生成（Augmented Generation）

Doing the retrieval step is just one half of the product. The other part is now using those retrieved results to respond in natural language. There are few questions here:

检索步骤仅完成了产品功能的一半；另一半则是利用这些检索结果，以自然语言生成响应。这里存在几个关键问题：

- What LLM should we use?  
- 应该选用哪一种大语言模型（LLM）？

- What prompt should we use?  
- 应该采用什么样的提示词（prompt）？

- Should we just give an answer? Or should we provide extra information?  
- 我们只需给出答案，还是应同时提供额外信息？

**What LLM should we use?**

**应选用哪一种大语言模型（LLM）？**

For this we opted for GPT-3.5-Turbo, given it's low cost and fast response time. We will make this more configurable over time to allow for Anthropic, Vertex, and Llama models.

本项目中，我们选择了 GPT-3.5-Turbo，主要因其成本低廉且响应迅速。未来我们将逐步增强配置灵活性，支持 Anthropic、Vertex 以及 Llama 等多种模型。

**What prompt should we use?**

**应该采用什么样的提示词（prompt）？**

This is arguably the place where people spend the most time on their application. If we were building this for real we could sink hours into this. To jumpstart our process, we started from a [previously leaked](https://twitter.com/jmilldotdev/status/1600624362394091523?s=20&ref=blog.langchain.com) Perplexity prompt. After some modifications, the final prompt we arrived at can be found [here](https://smith.langchain.com/hub/hwchase17/weblangchain-generation?ref=blog.langchain.com).

这无疑是开发者在应用开发中投入时间最多的关键环节。若实际落地该项目，我们可能需耗费数小时反复打磨。为加快开发进程，我们从一段此前[泄露的](https://twitter.com/jmilldotdev/status/1600624362394091523?s=20&ref=blog.langchain.com) Perplexity 提示词出发，并经若干轮调整优化，最终确定的提示词可在此处查看：[链接](https://smith.langchain.com/hub/hwchase17/weblangchain-generation?ref=blog.langchain.com)。

![](images/building-and-breaking-weblangchain/img_010.png)

![](images/building-and-breaking-weblangchain/img_010.png)

**Should we just give an answer? Or should we provide extra information?**

**我们只需给出答案，还是应同时提供额外信息？**

One very common thing to do is to provide not only the answer but also citations to sources from which that answer is based on.  
一个非常常见的做法是：不仅提供答案，还同时提供该答案所依据的资料来源的引用。

This is important in research applications for a few reasons. First, it makes it easy to verify any claim the LLM makes in its response (since you can navigate to the cited source and check it for yourself). Second, it makes it easy to dig deeper into a particular fact or claim.  
这在研究类应用中尤为重要，原因有二：第一，它便于验证大语言模型（LLM）在其回答中提出的任何主张（因为你可以直接跳转至被引用的原始资料自行核查）；第二，它便于针对某一具体事实或主张进一步深入探究。

Since the leaked Perplexity prompt was using a particular convention to cite its sources we just continued to use that same convention. That particular convention involved asking the LLM to generate sources in the following notation: `[N]`. We then parse that out client side and render it as a hyperlink.  
由于此前泄露的 Perplexity 提示词（prompt）采用了一种特定的引用格式来标注资料来源，我们便沿用了这一约定。该约定要求大语言模型以 `[N]` 的形式生成引用标记（其中 `N` 为数字编号），随后我们在客户端解析这些标记，并将其渲染为超链接。

### Summary of Generation  
### 生成流程概览

Putting it all together, in code it ends up looking like:  
综上所述，最终在代码中体现为如下形式：

```
_context = RunnableMap(
    {
    	# Use the above retrieval logic to get documents and then format them
        "context": retriever_chain | format_docs,
        "question": itemgetter("question"),
        "chat_history": itemgetter("chat_history"),
    }
)
response_synthesizer = prompt | llm | StrOutputParser()
chain = _context | response_synthesizer
```

This is a relatively simple chain, where we first fetch the relevant context and then pass it to a single LLM call.  
这是一个结构相对简单的链式流程：我们首先获取相关上下文，再将其一次性传入大语言模型进行推理。

## Conclusion  
## 结语

We hope that this has helped prepare you to build your own RAG application in a few ways. First, we hope that this has helped explore (in more detail than you probably ever wanted to) all the small engineering decisions that make up a RAG application. Understanding these decisions, and the tradeoffs involved, will be crucial for building your own app. Second, we hope the open source repository, which includes a fully function web application and connection to LangSmith, is a helpful starting off point.  
我们希望本文能从多个方面助你为构建自己的 RAG（检索增强生成）应用做好准备。首先，我们希望本文已（以远超你预期的细致程度）帮你梳理了构成 RAG 应用的每一项细微工程决策；理解这些决策及其背后的设计权衡，对你自主开发应用至关重要。其次，我们希望这个开源代码仓库——其中包含一个功能完备的 Web 应用及与 LangSmith 的集成——能为你提供一个实用的起步支点。

The underlying application logic is EXTREMELY similar (basically the same) as the [ChatLangChain](https://blog.langchain.com/building-chat-langchain-2/) app we released last week. This is no accident. We think this application logic is pretty generalizable and can be extended to a variety of applications — and so we hope you try to do so! While we hope this serves as an easy getting started point, we're looking forward to improvements next week that will make it even easier to customize.  
其底层应用逻辑与我们上周发布的 [ChatLangChain](https://blog.langchain.com/building-chat-langchain-2/) 应用**高度相似（几乎完全一致）**。这绝非偶然。我们认为，这种应用逻辑具备很强的通用性，可轻松拓展至多种不同场景——因此，我们诚挚邀请你尝试基于它进行二次开发！尽管我们希望本文能为你提供一个便捷的入门路径，但更令人期待的是：下周我们将推出一系列改进，让定制化过程变得更加简单高效。

### Tags  
### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/building-and-breaking-weblangchain/img_011.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/building-and-breaking-weblangchain/img_011.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/building-and-breaking-weblangchain/img_012.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/building-and-breaking-weblangchain/img_012.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/building-and-breaking-weblangchain/img_013.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/building-and-breaking-weblangchain/img_013.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/building-and-breaking-weblangchain/img_014.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/building-and-breaking-weblangchain/img_014.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/building-and-breaking-weblangchain/img_015.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/building-and-breaking-weblangchain/img_015.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/building-and-breaking-weblangchain/img_016.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/building-and-breaking-weblangchain/img_016.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)