---
render_with_liquid: false
title: "GPTwitter"
source: "LangChain Blog"
url: "https://blog.langchain.com/gptwitter/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:34:43.558469242+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**[Editor's Note]: This is the first of hopefully many guest posts. We intend to highlight novel applications building on top of LangChain. If you are interested in working with us on such a post, please reach out to harrison@langchain.dev.**

**【编者按】：本文是系列特邀投稿的第一篇，后续还将陆续推出更多嘉宾文章。我们旨在重点介绍基于 LangChain 构建的创新应用。如果您有兴趣与我们合作撰写此类文章，请联系 harrison@langchain.dev。**

**This post by [Akash Samant](https://twitter.com/AkashSamant4?ref=blog.langchain.com) highlights an application that we believe achieves user-level personalization in a novel, reproducible, and under-explored way.**

**本文作者为 [Akash Samant](https://twitter.com/AkashSamant4?ref=blog.langchain.com)，他所介绍的应用以一种新颖、可复现且尚未被充分探索的方式，实现了面向用户的个性化体验。**

**GPTwitter:** The first personalized AI generated Social Media Platform. Access it here: [https://gptwitter-neon.vercel.app/](https://gptwitter-neon.vercel.app/?ref=blog.langchain.com)

**GPTwitter：首个由 AI 驱动、面向用户个性化的社交媒体平台。立即体验：[https://gptwitter-neon.vercel.app/](https://gptwitter-neon.vercel.app/?ref=blog.langchain.com)**

* * *

Nowadays everyone’s media feed feels like a personal bubble– yours is probably comprised of every topic, pop culture reference, or online personality that you might think to enjoy. And you do enjoy it (probably). But all this content is limited. It’s finite, and if everyone that you or I followed suddenly stopped posting – what would you do? I would _hope_ that I would put my phone back down and pick up unaffected, but I’m not sure I _could_ do that, and I’m not convinced most of you would either.

如今，每个人的媒体信息流都像一个“个人气泡”——你的信息流中，很可能囊括了所有你自认为会喜欢的话题、流行文化梗或网络红人。你确实（大概率）乐在其中。但所有这些内容都是有限的；它是有边界的。试想一下：假如你我关注的所有人都突然停止发帖，你该怎么办？我**希望**自己能果断放下手机、回归生活，不受影响；但我不确定自己**是否真能做到**，也不确信在座各位多数人就能做到。

Over the past week, Sean, Bagatur, and I have been thinking about this “end-of-the-world” scenario and how we could do something to fix it with Large Language Models (LLMs). I mean, if Elon Musk isn’t posting, GPT-3 is probably good enough! We’ve been especially interested in creating an experience that learns from your interactions and produces tweets like those you would see on your own feed – all without any explicit personal guidance. We’re happy to present GPTwitter – the product of our semi-dystopian ruminations.

过去一周，Sean、Bagatur 和我一直在思考这种“世界末日式”的场景，并探讨如何借助大语言模型（LLMs）来应对这一困境。我的意思是：就算埃隆·马斯克不发推了，GPT-3 也完全够用了！我们尤其着迷于打造这样一种体验：它能从你的互动行为中自主学习，生成与你日常信息流风格高度一致的推文——整个过程无需任何显式的个性化设置或人工引导。我们很荣幸向大家推出 **GPTwitter**——这是我们半带反乌托邦色彩的深度思考所孕育出的成果。

## What is GPTwitter?

## 什么是 GPTwitter？

[GPTwitter](https://gptwitter-neon.vercel.app/?ref=blog.langchain.com) is a social media platform that learns from your like history and generates personalized tweets just for you, so that you never have to leave the safety of your social media bubble.

[GPTwitter](https://gptwitter-neon.vercel.app/?ref=blog.langchain.com) 是一个社交媒体平台，它通过学习你的点赞历史，为你专属生成高度个性化的推文，让你永远不必离开自己熟悉的社交媒体“舒适圈”。

Once you login, you can generate tweets, like them, and share them. After you like one of our tweets we’ll make sure to tailor our future ones a bit more specifically to your interests. **But watch** **out**– **you might end up down a rabbit hole of identical tweets and topics.**

登录后，你可以生成推文、点赞推文、分享推文。当你点赞某条我们生成的推文后，我们将确保后续生成的内容更精准地契合你的兴趣偏好。**但请务必小心**——**你可能会不知不觉陷入一条由高度相似推文与重复话题构成的“兔子洞”。**

It’s likely something you’ll enjoy, so don’t worry, but if you want to escape – _just hit the reset button_, although you might be sad that you did.

这大概率会是你喜欢的体验，所以无需担忧；但如果你想要抽身而出——_只需点击“重置按钮”_，尽管你事后或许会为此感到一丝失落。

## In All Seriousness, What Have We Learned?

## 说真的，我们学到了什么？

Working with LLMs for creative purposes is very different from functional, practical purposes – it demands spontaneity, diversity, and consistency– three things which don’t fit together neatly in model output. Our experiments with GPTwitter, using Langchain AI, revolved around each of these, and we’d like to share them with you.

面向创意目的使用大语言模型（LLM）与面向功能性和实用性目的截然不同——它要求模型具备即兴性、多样性与一致性，而这三者在模型输出中往往难以自然协调。我们围绕这三大特性开展了 GPTwitter 实验（基于 LangChain AI 构建），并希望与您分享这些探索过程与发现。

### \#1: It’s all in the latent space

### \#1：一切皆在隐空间之中

Early on, we decided to scrap piecemeal methods of generating tweets from discrete topics and styles. They often lead to nonsensical results with little correlation between generated tweets. Instead, we decided to sample directly from the latent space. The prompts we built GPTwitter with only use text from previously generated tweets to create new ones. We were unsure what the result would be – the decision is still up to you, but we’ve been pleasantly surprised with how consistently all the pieces of a tweet that would make it unique – length, reference style, topics, hashtag usage, tone, etc. – are inferred by GPT-3.

项目初期，我们便决定摒弃将推文按离散主题与风格“拼凑生成”的零散方法——这类方法常导致语义混乱、生成推文之间缺乏逻辑关联。取而代之，我们选择直接从模型的隐空间（latent space）中采样。GPTwitter 所用提示词（prompt）仅依赖此前已生成的推文文本，来驱动新推文的生成。起初我们并不确定效果如何——最终决策权仍在您手中，但令人欣喜的是，GPT-3 展现出极强的一致性，能稳定地推断出构成一条独特推文的全部要素：长度、引用风格、话题、话题标签（hashtag）使用方式、语气等。

Specifically, using LangChain terminology, we achieved this by using a [custom example selector](https://python.langchain.com/docs/modules/model_io/prompts/example_selectors/?ref=blog.langchain.com) that selected example tweets probabilistically. A user's initial profile is seeded with 100 tweets, each with an associated weight. For each generated tweet, a certain limited number of tweets (2-5) are selected with probability proportional to their weight. If a generated tweet is liked, we add it to the list of possible tweets to be selected, and increase the weight of the tweets that were used to generate that tweet. In this way, the example selector over time selects tweets that are more representative (in some way) of what you've liked in the past.

具体而言，借助 LangChain 的术语体系，我们通过实现一个[自定义示例选择器（custom example selector）](https://python.langchain.com/docs/modules/model_io/prompts/example_selectors/?ref=blog.langchain.com)，以概率方式选取示例推文，从而达成上述目标。每位用户的初始档案由 100 条推文“播种”，每条推文均附带一个权重值。每次生成新推文时，系统会依据权重比例，从中随机选取有限数量（通常为 2–5 条）的推文作为上下文参考；若某条生成推文获得用户点赞，该推文即被加入可选示例池，并同时提升用于生成它的那几条原始推文的权重。如此一来，示例选择器将随时间推移，愈发倾向于选取那些更能代表您过往偏好的推文（以某种方式）。

As an aside, before deciding to do everything in the latent space, we experimented with generating the tweets in a more controlled manner by specifying the style and content of the example tweets explicitly. Typically, the best results occurred when the data we fed to the model was limited in some way – if the reference tweets we used were similar eg. style, topic, or if we only used a limited number of tweets (2-5). In these scenarios, the LLM was able to extrapolate and identify patterns more easily – spinning topics and styles into interesting mashups.

顺便一提，在最终确立“全隐空间策略”之前，我们也曾尝试更受控的推文生成方式：即显式指定示例推文的风格与内容。实践中我们发现，当输入模型的数据受到一定限制时，效果往往最佳——例如所选参考推文在风格或主题上高度相似，或仅使用少量（2–5 条）推文作为上下文。在此类场景下，大语言模型能更轻松地外推规律、识别模式，进而将不同主题与风格巧妙融合，创造出富有趣味性的混搭效果。

Some of the best results came from mixing pop culture reference, like this tweet that references Back to the Future:

部分最出色的结果，正源于对流行文化元素的混搭运用——例如这条明显致敬《回到未来》（Back to the Future）的推文：

![](images/gptwitter/img_001.png)

In the absence of control, we found very erratic nonsensical results – typically mashing topics that wouldn’t make sense with one another.

而在缺乏明确控制的情况下，我们则观察到大量反复无常、语义混乱的输出——典型表现为强行拼接彼此毫无逻辑关联的主题。

These issues highlight areas that we’re excited to experiment more with. Specifically, leveraging larger corpuses of reference data to produce _more consistent_ results.

这些问题恰恰凸显了我们后续希望重点探索的方向：特别是，如何利用更大规模、更丰富的参考语料库，来产出**更稳定、更一致**的生成结果。

### #2: Hallucinations can be useful

### #2：幻觉现象其实可能很有用

Despite our disparagement of LLM consistency, we’ve found hallucinations and LLM inconsistency to be interesting sources of output and diversity. Broadly speaking, hallucinations are not useful in most applications because they are not useful as factual pieces of information, so we understand the concern around limiting them.

尽管我们曾对大语言模型（LLM）的“一致性”提出过批评，但我们发现，幻觉（hallucinations）以及 LLM 的不一致性，反而成为输出多样性和创意灵感的有趣来源。广义而言，幻觉在大多数应用场景中确实缺乏实用价值——毕竟它们并非可靠的事实性信息，因此我们完全理解人们希望限制其出现的顾虑。

It’s a good thing GPTwitter isn’t a factual site because we turned the temperature up on our models all the way to 1.0. This is a standard technique for improving output variance and it worked well in producing novel generations from previous tweets.

所幸 GPTwitter 并非一个追求事实准确性的网站，正因如此，我们将模型的 temperature 参数直接调至 1.0。这是提升输出多样性的一项标准技术，在基于过往推文生成全新内容时效果显著。

Here’s a great example of GPT-3 crafting a response from tweets about taxes and crypto:

以下是一个绝佳示例：GPT-3 综合多条关于税收与加密货币的推文，自主生成了一条全新回应：

![](images/gptwitter/img_002.png)

![](images/gptwitter/img_002.png)

In general, we think that hallucinations are underused. They indicate that LLMs have creative output capabilities, and for creative workflows, they can be incredibly useful. One of the problems we faced was producing more valuable hallucinations – higher variance, higher quality tweets at a higher frequency. Our compromise was to tighten our selection process, but we haven’t explored all our options nor arrived at our ideal solution. We think inducing _chains of thought_ used in other problem-solving areas, perhaps tailored for the creative process, could be an interesting avenue to look to in the future.

总体而言，我们认为幻觉现象目前仍被严重低估。它恰恰表明大语言模型具备创造性输出能力；而在创意类工作流中，这种能力可能极具价值。我们曾面临的一个关键挑战是：如何产出“更有价值”的幻觉——即兼具更高多样性、更高质量，且生成频率更高的推文。我们的折中方案是收紧人工筛选流程；但这一路径远非终点——我们尚未穷尽所有可能性，也尚未找到真正理想的解决方案。展望未来，我们设想：借鉴其他问题求解领域中广泛应用的“思维链（chains of thought）”机制，并针对创意过程加以定制化改造，或许会是一条值得深入探索的新路径。

## Final Thoughts

## 最后的话

We had a fun time building GPTwitter, and we hope you enjoy it as much as we have.

开发 GPTwitter 的过程充满乐趣，我们也衷心希望您能像我们一样乐在其中。

It’s exciting to think of all the changes that are underway as LLM technologies develop – we’ll be continuing to experiment with applications of LLMs, to augment and improve the personal creative process. You can find [Bagatur](https://twitter.com/baga_tur?ref=blog.langchain.com), [Sean](https://twitter.com/_seanyneutron?ref=blog.langchain.com), or [Akash](https://twitter.com/AkashSamant4?ref=blog.langchain.com) on Twitter.

随着大语言模型技术持续演进，眼前正发生着诸多令人振奋的变革——我们将继续探索 LLM 的各类应用，以增强并优化个人的创意表达过程。您可在 Twitter 上关注 [Bagatur](https://twitter.com/baga_tur?ref=blog.langchain.com)、[Sean](https://twitter.com/_seanyneutron?ref=blog.langchain.com) 或 [Akash](https://twitter.com/AkashSamant4?ref=blog.langchain.com)。

We’ll leave you with one of our favorite generated inspirational tweets below:

最后，奉上我们最钟爱的一条由模型生成的励志推文：

![](images/gptwitter/img_003.png)

![](images/gptwitter/img_003.png)

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/gptwitter/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/gptwitter/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/gptwitter/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/gptwitter/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/gptwitter/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/gptwitter/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](images/gptwitter/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/gptwitter/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)