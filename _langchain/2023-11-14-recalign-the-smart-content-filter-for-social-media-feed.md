---
render_with_liquid: false
title: "RecAlign - The smart content filter for social media feed"
source: "LangChain Blog"
url: "https://blog.langchain.com/recalign-the-smart-content-filter-for-social-media-feed/"
date: "2023-11-14"
scraped_at: "2026-03-03T08:27:38.319721135+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**[Editor's Note]** This is a guest post by Tian Jin. We are highlighting this application as we think it is a novel use case. Specifically, we think recommendation systems are incredibly impactful in our everyday lives and there has not been a ton of discourse on how LLMs will impact these systems.

**【编者按】** 本文为田津（Tian Jin）撰写的客座文章。我们特别推荐这一应用，因其代表了一种新颖的使用场景。具体而言，我们认为推荐系统在我们的日常生活中影响巨大，而关于大语言模型（LLMs）将如何重塑这类系统，目前尚缺乏充分讨论。

We've all experienced the pains of using recommender systems: you signed up for Twitter to keep up with latest AI research, but a click on a funny meme will flood your timeline with similar distractions. These systems work to maximize their owner’s profit, not your welfare. Here, we outline the rationale behind our LangChain-powered solution to address this problem at its core.

我们都曾饱受推荐系统的困扰：你注册 Twitter 是为了追踪最新的 AI 研究进展，但偶然点开一则搞笑梗图，随后时间线便被同类干扰内容彻底淹没。这些系统的设计目标是最大化其所有者的利润，而非你的福祉。下文我们将阐明：我们基于 LangChain 构建的解决方案，正是从根源上应对这一问题的底层逻辑。

**Transparency & configurability.** In Brian Christian’s book *the Alignment Problem*, he shares an anecdote: his friend is recovering from alcohol addiction, but the recommender system knows, perhaps a little too well, about his love for alcohol and infests his feed with ads for alcohol. This episode is a vivid illustration of a recurring problem — recommender systems are skilled at catering to who we are today, but leaves little freedom for us to decide who we aspire to become. The current recommender systems lacks transparency and configurability. As a result, it is difficult for us to identify any problematic inferences that the recommender system made about our preferences, let alone modify them.

**透明性与可配置性。** 在布莱恩·克里斯蒂安（Brian Christian）所著《对齐问题》（*The Alignment Problem*）一书中，他讲述了一个轶事：他的朋友正戒酒康复中，但推荐系统却“过于精准”地掌握了他对酒精的偏好，并持续向其信息流推送酒类广告。这一事件生动揭示了一个反复出现的问题——当前推荐系统擅长迎合“当下的我们”，却几乎不为我们“想成为的自己”留下任何自主选择的空间。现有推荐系统普遍缺乏透明性与可配置性。因此，我们不仅难以识别系统在推断我们偏好时所作出的任何不当判断，更遑论对其进行修正。

**Conflict of interest.** We cannot expect the owners of recommender systems (e.g., Twitter) to solve this lack of transparency and configurability due to a conflict of interest: system owners aim to maximize revenue, often prioritizing this objective over other desirable goals for users. This lead us to believe that to improve recommender systems, we must address the underlying conflict of interest. Users must have direct control over what they see as recommendations.

**利益冲突。** 我们无法指望推荐系统的所有者（例如 Twitter）主动解决上述透明性与可配置性缺失的问题——这源于根本性的利益冲突：系统所有者以营收最大化为首要目标，往往将该目标置于用户其他合理诉求之上。正因如此，我们认为，若要真正改进推荐系统，必须直面并化解这一深层的利益冲突。用户必须对自身所见的推荐内容拥有直接控制权。

**A solution.** We propose to use large language models (LLMs) such as ChatGPT as smart content filters for social media feed, which are the outputs of recommendation systems on social media platforms. We developed an open source Chrome extension RecAlign ([https://github.com/tjingrant/RecAlign](https://github.com/tjingrant/RecAlign?ref=blog.langchain.com)) where you can specify your viewing preference in words such as _“I love reading about AI research”._ We then ask the LLM to intelligently determine whether each entry in the social media feed fits the user preference and remove all entries that violates it. We plan to develop other highly configurable augmentations such as feed re-ranking in the near future.

**一种解决方案。** 我们提出：将 ChatGPT 等大语言模型（LLMs）用作社交媒体信息流的智能内容过滤器——而该信息流本身，正是社交媒体平台推荐系统输出的结果。我们开发了一款开源 Chrome 扩展程序 **RecAlign**（[https://github.com/tjingrant/RecAlign](https://github.com/tjingrant/RecAlign?ref=blog.langchain.com)），用户可通过自然语言（例如 _“我热爱阅读 AI 研究相关的内容”_）明确表达自己的浏览偏好；随后，由大语言模型智能判断信息流中的每一条内容是否符合该偏好，并自动移除所有违背偏好的条目。未来，我们还计划开发其他高度可配置的增强功能，例如信息流重排序（feed re-ranking）等。

![](images/recalign-the-smart-content-filter-for-social-media-feed/img_001.png)

A LLM-based smart content filter has the following benefits:

基于大语言模型的智能内容过滤器具备以下优势：

- **Configurable.** In the age of ChatGPT, English is the new programming language. We let users easily configure a smart content filter and see its effects immediately.  
- **可配置性强。** 在 ChatGPT 时代，“英语已成为一门新的编程语言”。我们让用户能轻松配置智能内容过滤器，并即时看到效果。

- **Transparent.** Your preference is right there, stated in words, in its entirety.  
- **高度透明。** 您的偏好就明明白白、完整无缺地以文字形式呈现于此。

- **Flexible.** Our preference can be ephemeral. An easily configurable preference enables users to flexibly switch between different preferences.  
- **灵活多变。** 我们的偏好可能是短暂易变的；而易于配置的机制，则赋予用户在不同偏好间自由切换的能力。

**Join the cause.** Try RecAlign on Github at [https://github.com/recalign/RecAlign](https://github.com/recalign/RecAlign?ref=blog.langchain.com)! Consider watching/staring us for future development!

**加入这场行动！** 立即前往 GitHub 试用 RecAlign：[https://github.com/recalign/RecAlign](https://github.com/recalign/RecAlign?ref=blog.langchain.com)！欢迎关注（Watch）或点亮星标（Star）以支持我们后续的开发！

**LangChain.** LangChain plays a central role in our project. We use LangChain as an ergonomic interface to communicate with the OpenAI backend. We also rely on LangChain’s ability to easily format and parse the input to and output from LLMs. We highly recommend LangChain as it enables rapid prototyping and fast iteration on projects building with LLMs.

**LangChain。** LangChain 在本项目中扮演核心角色。我们将其作为人机交互友好的接口，用以连接 OpenAI 后端服务；同时，也高度依赖 LangChain 对大语言模型输入/输出进行便捷格式化与解析的能力。我们强烈推荐 LangChain——它极大提升了基于大语言模型项目的原型开发速度与迭代效率。

**Who we are**.  
**我们是谁**。  

We started as a team of two Ph.D. students in Computer Science from MIT and Harvard. This project kicked off when Xin was just 2 weeks away from his Ph.D. defense. Despite his otherwise good judgement he decides to work on this project. Thanks to LangChain, we released our first prototype with plenty of time for Xin to prepare for his defense!  
我们最初是由麻省理工学院（MIT）和哈佛大学两位计算机科学博士生组成的团队。本项目启动时，Xin 距离他的博士论文答辩仅剩两周时间。尽管他一向判断力出众，却仍决定投入本项目。得益于 LangChain，我们在 Xin 充分准备答辩的同时，成功发布了首个原型版本！

### Tags  
### 标签  

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/recalign-the-smart-content-filter-for-social-media-feed/img_002.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)  

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/recalign-the-smart-content-filter-for-social-media-feed/img_002.png)](https://blog.langchain.com/neum-x-langchain/)  

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)  


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/recalign-the-smart-content-filter-for-social-media-feed/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)  

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/recalign-the-smart-content-filter-for-social-media-feed/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)  

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)  


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/recalign-the-smart-content-filter-for-social-media-feed/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)  

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/recalign-the-smart-content-filter-for-social-media-feed/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)  

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)  


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)  

[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](images/recalign-the-smart-content-filter-for-social-media-feed/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/recalign-the-smart-content-filter-for-social-media-feed/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)