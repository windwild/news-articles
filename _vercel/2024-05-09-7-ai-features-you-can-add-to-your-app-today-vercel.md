---
title: "7 AI features you can add to your app today - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today"
date: "2024-05-09"
scraped_at: "2026-03-02T09:45:13.953938587+00:00"
language: "en-zh"
translated: true
description: "Discover how AI is transforming businesses with Vercel. Learn about easy LLM integration, 7 game-changing applications, and how to implement AI features to boost user experience and growth."
---

May 9, 2024

2024年5月9日

Easy wins for your bottom line.

提升利润的轻松之选。

Imagine a customer finding the perfect item on your website in seconds—not because they know the jargon to search, but because your search bar _understands_ what they're looking for.

想象一位顾客仅用几秒钟就在您的网站上找到了心仪的商品——这并非因为他们熟悉专业术语而能精准搜索，而是因为您的搜索框 _真正理解_ 他们的需求。

That level of convenience wasn't possible a year ago. Even getting close was a huge hassle. But now, thanks to advancements in AI and large language models (LLMs) like OpenAI’s GPT, Google’s Gemini, and Anthropic’s Claude, businesses without dedicated AI teams are rolling out impressive features in record time.

一年前，这种程度的便捷还无法实现；哪怕只是接近这一目标，也曾是巨大挑战。但如今，得益于人工智能（AI）及大型语言模型（LLM）——如 OpenAI 的 GPT、Google 的 Gemini 和 Anthropic 的 Claude——的飞速进步，即使没有专职 AI 团队的企业，也能以创纪录的速度上线令人瞩目的功能。

And Vercel is here to help speed that process up. Let’s take a look at what’s possible.

Vercel 正致力于加速这一进程。让我们一探究竟：哪些功能已成为现实？

# Contents

# 目录

01. [AI integration made simple](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#ai-integration-made-simple)  
01. [简化 AI 集成](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#ai-integration-made-simple)  

02. [Prerequisites for AI features](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#prerequisites-for-ai-features)  
02. [启用 AI 功能的前提条件](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#prerequisites-for-ai-features)  

03. [How can AI improve your business?](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#how-can-ai-improve-your-business?)  
03. [AI 如何助力您的业务增长？](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#how-can-ai-improve-your-business?)  

04. [Semantic search](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#1.-semantic-search)  
04. [语义搜索](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#1.-semantic-search)  

05. [Natural chatbots](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#2.-natural-chatbots)  
05. [自然流畅的聊天机器人](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#2.-natural-chatbots)  

06. [Nuanced personalization](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#3.-nuanced-personalization)  
06. [细腻入微的个性化体验](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#3.-nuanced-personalization)  

07. [Instant localization](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#4.-instant-localization)  
07. [即时本地化](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#4.-instant-localization)  

08. [Automatic content for any page](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#5.-automatic-content-for-any-page)  
08. [为任意页面自动生成内容](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#5.-automatic-content-for-any-page)  

09. [Developer efficiency](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#6.-developer-efficiency)  
09. [提升开发者效率](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#6.-developer-efficiency)  

10. [Private data analysis](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#7.-private-data-analysis)  
10. [私有数据分析](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#7.-private-data-analysis)  

11. [Where to start](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#where-to-start)  
11. [从何处入手](https://vercel.com/blog/7-ai-features-you-can-add-to-your-app-today#where-to-start)  

## AI integration made simple

## 简化 AI 集成

Advancements in LLMs have made AI integration more accessible than you might expect. Here's why:

大型语言模型（LLM）的进步，使 AI 集成比您预想的更加触手可及。原因如下：

- **Pretrained mastery:** LLMs come with a vast understanding of common knowledge. This means minimal or even zero training with your own data to achieve results  
- **预训练即精通：** LLM 已具备对通用知识的广泛理解。这意味着您几乎无需（甚至完全无需）使用自有数据进行额外训练，即可获得理想效果

- **Adaptability:** Transfer learning lets you fine-tune LLMs on your domain-specific needs, even with smaller datasets  
- **适应性：** 迁移学习使您能够基于领域特定需求对大语言模型（LLM）进行微调，即使训练数据集规模较小亦可实现。

- **Creative output:** LLMs can generate impressive copy, which is ideal for content creation, chatbots, or translation tasks  
- **创造性输出：** 大语言模型可生成高质量文本内容，非常适用于内容创作、聊天机器人或翻译等任务。

- **Understanding beyond keywords:** LLMs grasp user intent, tolerating typos and making interactions feel natural  
- **超越关键词的理解能力：** 大语言模型能准确理解用户意图，容错性强（例如可识别拼写错误），使人机交互更自然流畅。

- **Multilingual reach:** Pretrained LLMs often support multiple languages, expanding your potential audience significantly  
- **多语言支持能力：** 预训练的大语言模型通常支持多种语言，可显著扩大您的潜在用户覆盖范围。

### Prerequisites for AI features  

### AI 功能的先决条件  

To get started, you need a frontend framework that allows for API integrations. Then, you can easily connect your app to external AI providers.  
要开始使用 AI 功能，您需要一个支持 API 集成的前端框架；随后即可轻松将您的应用连接至外部 AI 服务提供商。

Second, ensure your existing infrastructure can handle the computational demands of LLMs—including streaming and caching long responses.  
其次，请确保您当前的基础架构足以应对大语言模型的计算需求——包括长响应流式传输（streaming）与缓存（caching）。

If you don’t have an architecture that can support that, it’s okay. Tapping into AI doesn’t have to mean a massive overhaul. Consider cloud-based, managed providers that specialize in AI workloads.  
若您尚不具备支撑此类需求的架构，也无需担忧。接入 AI 并不意味着必须进行大规模系统重构。您可以考虑采用专注于 AI 工作负载的云原生托管服务提供商。

For instance, you can build a new AI feature entirely on Vercel, which has [native AI support](https://vercel.com/ai) and fully managed scaling, streaming, and caching infrastructure. Then, you can easily hook that new AI frontend back into your codebase via an API.  
例如，您可完全在 Vercel 上构建全新的 AI 功能——Vercel 提供[原生 AI 支持](https://vercel.com/ai)，并配备全自动伸缩、流式传输与缓存基础设施。随后，您只需通过 API 即可轻松将该 AI 前端功能集成回您的代码库。

This simplifies the process and minimizes upfront development costs. As you grow, there’s no limit to how many one-off apps or full-fledged frontends you can run on Vercel’s infrastructure. And thanks to serverless infrastructure, you only pay for what you actively use.  
此举大幅简化开发流程，并显著降低前期开发成本。随着业务发展，您可在 Vercel 基础设施上运行任意数量的独立应用或完整前端项目，毫无限制。同时，得益于无服务器（serverless）架构，您仅需为实际使用的资源付费。

## How can AI improve your business?

## 人工智能如何助力您的业务增长？

Below, we’ll take a look at some of the coolest advancements happening in the AI space for small and large businesses alike— _that aren’t specifically selling AI products_. This is by no means an exhaustive list, but hopefully, it’s enough to start thinking outside the box.

以下，我们将聚焦于人工智能领域中一些最前沿的进展——这些进展正惠及中小企业与大型企业，且**并非专指销售 AI 产品的公司**。这份清单远非面面俱到，但希望能助您打破思维定式、激发创新灵感。

### 1\. Semantic search

### 1. 语义搜索

We’ll start with one of the most powerful applications of AI: search.

我们先从人工智能最具威力的应用之一——搜索——谈起。

Websites often suffer from poor search results. Traditional search functionalities—like matching keywords and their stems, handling misspellings and synonyms, and ranking for context and relevance—are typically tedious to implement and optimize.

网站常因搜索结果质量低下而困扰用户。传统搜索功能（例如关键词及词干匹配、错别字与同义词处理、基于上下文与相关性的排序）往往实现复杂、调优繁琐。

LLMs can solve this problem, offering accurate search results even for typos or nonoptimal phrasing. They understand language more like humans do—including nuance, context, and synonyms.

大语言模型（LLM）可有效解决这一难题：即便用户输入存在拼写错误或表达不够精准，仍能返回高度准确的搜索结果。LLM 对语言的理解更接近人类——能捕捉细微差别、上下文关联与同义关系。

Plus, there’s plenty of room to go beyond the basics and offer fully dynamic, faceted search, which intelligently adapts available filters and search results in real time based on the user's query and selections.

此外，语义搜索还有广阔拓展空间：可构建完全动态的多维筛选搜索（faceted search），根据用户的实时查询内容与已选条件，智能调整可用筛选项与搜索结果。

LLM-powered search can also be tuned to your site’s specific offerings and can adapt over time to provide better results.

基于 LLM 的搜索系统还可针对您网站的独特商品/服务进行定制化调优，并随时间推移持续学习优化，不断提升结果质量。

All this drastically speeds up discovery and makes the process of using your site far more intuitive. Users get a more conversational, personalized relationship with your business, which means a lower bounce rate.

上述所有能力，显著加速了用户的信息发现过程，让您的网站使用体验更加直观自然。用户得以与您的业务建立更具对话感、个性化的互动关系，从而有效降低跳出率。

[**Get started with search.**\\
\\
This template allows you to quickly spin up an AI answer engine with generative UI, based on your company's data. Powered by Morphic.\\
\\
Deploy Now](https://vercel.com/templates/next.js/morphic-ai-answer-engine-generative-ui)

[**立即开启搜索升级之旅**\\
\\
本模板支持您基于企业自有数据，快速搭建具备生成式用户界面（Generative UI）的 AI 答案引擎。由 Morphic 提供技术支持。\\
\\
立即部署](https://vercel.com/templates/next.js/morphic-ai-answer-engine-generative-ui)

### 2. Natural chatbots

### 2. 自然语言聊天机器人

Whether they need help with an order or they can’t find a feature your web app offers, customers expect immediacy and convenience. To deliver on this—especially outside of working hours—businesses create chatbots.

无论客户是需要订单帮助，还是找不到您的网页应用所提供的某项功能，他们都期待即时响应与使用便利。为满足这一需求——尤其是在非工作时间——企业纷纷构建聊天机器人。

But managing chat presents the same natural language challenges as search—plus a whole lot more, such as limited world knowledge, lack of personalization, and no ability to self-improve.

但管理聊天交互所面临的自然语言挑战，与搜索任务相同——甚至更为复杂：例如世界知识有限、缺乏个性化能力、且无法自主优化改进。

LLMs provide an elegant solution for this and can offer quick, personalized, and even multilingual support out of the box.

大语言模型（LLM）为此提供了优雅的解决方案，开箱即用即可提供快速、个性化，甚至支持多语言的服务。

Klarna, for instance, recently reported that [their OpenAI-powered chatbot](https://www.klarna.com/international/press/klarna-ai-assistant-handles-two-thirds-of-customer-service-chats-in-its-first-month/) is on par with human agents in customer satisfaction but resolves queries 80% faster. The bot accomplishes the work of 700 full-time agents and drives $40M in net revenue.

例如，Klarna 近期报告称，[其基于 OpenAI 构建的聊天机器人](https://www.klarna.com/international/press/klarna-ai-assistant-handles-two-thirds-of-customer-service-chats-in-its-first-month/) 在客户满意度方面已媲美人工客服，但问题解决速度却快出 80%。该机器人承担了相当于 700 名全职客服人员的工作量，并带来 4000 万美元的净收入。

[**Spin up your own chat in minutes.**\\  
\\  
A full-featured, hackable Next.js AI chatbot built by Vercel.\\  
\\  
Deploy Now](https://vercel.com/templates/next.js/nextjs-ai-chatbot)

[**几分钟内快速搭建您自己的聊天机器人。**\\  
\\  
由 Vercel 构建的功能完备、可高度定制的 Next.js AI 聊天机器人。\\  
\\  
立即部署](https://vercel.com/templates/next.js/nextjs-ai-chatbot)

### 3. Nuanced personalization

### 3. 细致入微的个性化

Since LLMs can synthesize huge amounts of data, like help articles, product reviews, user behavior, or even external knowledge bases, they glean deep insights into user preferences that go beyond simple click data or past purchases.

由于大语言模型能够综合处理海量数据——例如帮助文档、产品评论、用户行为日志，甚至外部知识库——它们得以深入洞察用户偏好，远超简单的点击数据或历史购买记录。

The result is shockingly _human_ product and content recommendations.

其结果是令人惊叹地“拟人化”的产品与内容推荐。

In SaaS, for instance, LLMs could help surface the perfect help article or feature tutorial based on a user’s conversational query and context in the app, reducing frustration and increasing the platform’s value.

例如，在 SaaS 场景中，大语言模型可根据用户的对话式提问及其在应用中的上下文，精准推送最匹配的帮助文章或功能教程，从而降低用户挫败感，并提升平台整体价值。

In ecommerce, an LLM might suggest a dress not just because the user liked similar items, but because the product aligns with their taste for comfortable, eco-friendly clothing.

在电商领域，大语言模型（LLM）推荐一条连衣裙，可能不仅因为用户曾喜欢过类似商品，更因为该商品契合其对舒适、环保服饰的偏好。

[Generative UI](https://vercel.com/blog/ai-sdk-3-generative-ui) can take this a step further, introducing custom, on-the-fly React components tailored to your individual user's needs.

[生成式 UI（Generative UI）](https://vercel.com/blog/ai-sdk-3-generative-ui) 可将这一能力更进一步——动态生成专为单个用户需求定制的 React 组件。

What is the weather in SF?

旧金山天气如何？

getWeather("San Francisco, CA")

getWeather("San Francisco, CA")

Thursday, March 7

3月7日，星期四

47°

47°F（约8.3°C）

sunny

晴

7am

上午7点

48°

48°F（约8.9°C）

8am

上午8点

50°

50°

9am

上午9点

52°

52°

10am

上午10点

54°

54°

11am

上午11点

56°

56°

12pm

中午12点

58°

58°

1pm

下午1点

60°

60°

Thanks!

谢谢！

Weather

天气

Play

播放

An example of an assistant that renders the weather information in a streamed component.

一个通过流式组件呈现天气信息的助手示例。

With AI, personalization becomes more nuanced, accurate, and engaging, which leads to improved customer satisfaction and, ultimately, drives conversion and long-term loyalty.

借助人工智能，个性化体验变得更加细致、精准且富有吸引力，从而提升客户满意度，并最终推动转化率增长与长期用户忠诚度建设。

### 4\. Instant localization

### 4. 即时本地化

Another exciting feature of LLMs is their ability to function in multiple languages, which helps businesses better operate in the global marketplace.

大语言模型（LLM）另一项令人振奋的能力是支持多语言，这有助于企业更高效地参与全球市场竞争。

Without language barriers, you can tailor product descriptions, marketing campaigns, and customer support interactions [on the fly for different regions](https://vercel.com/resources/8-advantages-of-composable-commerce#4.-precision-performance-at-a-global-scale). This not only improves the customer experience but also reduces the need for costly and time-consuming manual localization.

消除了语言障碍后，您便能即时为不同地区定制产品描述、营销活动及客户服务互动内容 [详见此处](https://vercel.com/resources/8-advantages-of-composable-commerce#4.-precision-performance-at-a-global-scale)。这不仅提升了客户体验，也大幅减少了耗资巨大且费时的手动本地化工作。

Multilingual LLMs can also help teams collaborate across borders. For instance, [Match Group uses ChatGPT](https://openai.com/customer-stories/match-group) to break down barriers of language and culture and easily communicate with its international teams. Employees can access relevant information no matter where it originated, boosting productivity.

多语言大语言模型还能助力跨国团队高效协作。例如，[Match Group 借助 ChatGPT](https://openai.com/customer-stories/match-group) 打破语言与文化隔阂，顺畅地与全球各地团队沟通。员工无论身处何地，均可便捷获取所需信息，显著提升工作效率。

[**Bring AI into your team workflow.**  
将 AI 引入您的团队工作流。  

This template allows you to deploy an OpenAI-powered chatbot inside of your company's Slack workspace.  
该模板允许您在公司 Slack 工作区内部署一个由 OpenAI 驱动的聊天机器人。  

Deploy Now  
立即部署](https://vercel.com/templates/other/openai-gpt-slackbot-vercel-functions)

### 5. Automatic content for any page  
### 5. 任意页面的自动生成内容  

By now, most people know you can use LLMs to generate all kinds of content for your business: product descriptions, stock images, tooltips, alt text, and more. This is a pretty straightforward win, but it’s in _how_ you work with the models that this gets interesting.  
如今，大多数人已知晓：您可以利用大语言模型（LLM）为业务生成各类内容，例如产品描述、图库图片、工具提示（tooltips）、替代文本（alt text）等。这本身已是一项显而易见的收益；但真正引人入胜之处，在于您 *如何* 与这些模型协同工作。

With Vercel, you can quickly spin up—in hours, not days—internal AI tools that reduce time to market by bringing your business-specific data into the context of the LLM. For instance, you could create a tool where all you have to do is upload a product image and name, and the AI then generates content for your product detail page based on the style of your most successful products.  
借助 Vercel，您可在数小时内（而非数天）快速搭建内部 AI 工具——通过将您企业专属的数据注入大语言模型的上下文，显著缩短产品上市周期。例如，您可以构建一款工具：只需上传一张产品图片及名称，AI 即可基于您最畅销产品的文案风格，自动生成对应的产品详情页内容。

You could then use [no-latency A/B testing](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) across your site to determine when content isn’t working well and give that feedback to your LLM to automatically regenerate copy, images, or even videos. If you implement this feedback loop correctly, you could end up with a hands-free system that gradually prefers content that performs better for end users.  
随后，您还可借助全站范围的 [零延迟 A/B 测试](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config)，识别表现不佳的内容，并将该反馈实时传递给大语言模型，从而自动重生成文案、图片，甚至视频。若此反馈闭环设计得当，最终您将获得一套“免人工干预”的系统——它会持续优化，逐步倾向采用对终端用户效果更佳的内容。

[**Build custom AI features at lightning speed.**  
**以闪电般的速度构建定制化 AI 功能。**  

Learn how we quickly spun up a Review Summarizer app with v0 and the Vercel AI SDK.  
了解我们如何借助 v0 和 Vercel AI SDK 快速搭建一款评论摘要应用。  

Read More  
了解更多](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk)

### 6. Developer efficiency  
### 6. 开发者效率  

While developer tooling isn't a user-facing feature, anything that helps teams use their time better helps you offer more with your product.  
尽管开发者工具并非面向终端用户的功能，但任何能帮助团队更高效利用时间的工具，都能助您为产品赋予更丰富的价值。

Tools like GitHub Copilot provide engineers with inline suggestions while they write code, but AI can also be used to design interfaces, understand code without hunting for context, and even document your business’s repository for better onboarding and code reuse.  
诸如 GitHub Copilot 等工具，可在工程师编写代码时提供内联建议；而 AI 还可用于界面设计、无需反复查找上下文即可理解代码逻辑，甚至可自动为您的业务代码仓库生成文档，从而提升新成员入职效率与代码复用率。

At Vercel, we’ve been developing tools like v0, so engineers don’t have to start from scratch when building a new component. v0 helps developers create proofs of concept and even full-fledged interfaces faster than ever.  
在 Vercel，我们正持续开发 v0 等工具，使工程师在构建新组件时无需从零开始。v0 能助力开发者以前所未有的速度创建概念验证（PoC），乃至功能完备的完整界面。

### 7. 私有数据分析

### 7. 私有数据分析

Since LLMs can quickly process vast amounts of unstructured data, you can use them to sift through thousands of internal documents to find better answers faster.

由于大语言模型（LLM）能够快速处理海量非结构化数据，您可以利用它们快速筛查成千上万份内部文档，从而更快地获得更优答案。

At Vercel, for instance, we’ve been using [Glean.ai](https://www.glean.ai/) to quickly surface relevant materials from across multiple mission-critical applications like Notion, Slack, GitHub, and Gong.

例如，在 Vercel，我们一直在使用 [Glean.ai](https://www.glean.ai/)，从 Notion、Slack、GitHub 和 Gong 等多个关键业务应用中快速提取相关资料。

By automatically categorizing content based on themes, sentiment, or topics, AI can help your business quickly identify user or employee trends and areas for improvement.

AI 可基于主题、情感或话题自动对内容进行分类，从而帮助您的企业快速识别用户或员工行为趋势，以及有待改进的领域。

Plus, with a little tweaking, LLMs can present this data in really beautiful ways. [Viable](https://vercel.com/blog/delivering-ai-analysis-faster-with-the-vercel-workflow), for instance, generates aesthetic visualizations and natural language reports about your company data so that you can enable stakeholders to act upon findings easily.

此外，只需稍作调整，LLM 就能以极具美感的方式呈现这些数据。例如，[Viable](https://vercel.com/blog/delivering-ai-analysis-faster-with-the-vercel-workflow) 能够基于您公司的数据生成赏心悦目的可视化图表和自然语言分析报告，让各相关方轻松理解并依据分析结果采取行动。

[**Get started with retrieval augmented generation.**\\  
\\  
This template is a starter for creating a chatbot using Astra DB and OpenAI. It's designed to be easy to deploy, with quick ingestion of the data you wish to query.\\  
\\  
Deploy Now](https://vercel.com/templates/next.js/ragbot-starter)

[**立即开始使用检索增强生成（RAG）。**\\  
\\  
该模板是使用 Astra DB 和 OpenAI 构建聊天机器人的入门方案，部署便捷，并支持快速导入您希望查询的数据。\\  
\\  
立即部署](https://vercel.com/templates/next.js/ragbot-starter)

## Where to start

## 从何处入手

AI isn’t a magic bullet to solve your challenges, but it does greatly augment existing efforts.

AI 并非解决您所有挑战的“银弹”，但它确实能极大增强您现有的工作成效。

And modern LLMs lower the barrier to entry for AI. They provide a powerful starting point instead of requiring you to build and fine-tune models from the ground up. This makes exploring and implementing AI features significantly easier for most businesses.

而现代大语言模型显著降低了 AI 的应用门槛：它们提供了强大且即用的起点，无需您从零开始构建并微调模型。这对大多数企业而言，意味着探索与落地 AI 功能变得容易得多。

We recommend starting simple to get a feel for the interfaces available to you and test their limitations with your ideas for your business. [Vercel’s AI Playground](https://sdk.vercel.ai/) is a great place to quickly interact and compare the most popular LLMs on the market, without purchasing a bunch of separate subscriptions.

我们建议从简单场景入手，先熟悉当前可用的接口，并结合您企业的具体构想测试其能力边界。[Vercel 的 AI Playground](https://sdk.vercel.ai/) 是一个绝佳平台——您可在此快速交互、对比市面上主流的大语言模型，且无需分别订阅多个服务。

Then, you can use our [DX Platform](https://vercel.com/products/dx-platform) to collaborate with your team and make low-stakes prototypes, getting a sense of what does and doesn’t work in the AI space.

然后，您可以使用我们的 [DX 平台](https://vercel.com/products/dx-platform)，与团队协作开发低风险原型，从而切实感知 AI 领域中哪些方案可行、哪些不可行。

Businesses will continue to innovate and compete with LLM-driven features, whether or not they are AI-first companies. What might you make next?

无论企业是否以 AI 为先，它们都将继续依托大语言模型（LLM）驱动的功能开展创新与竞争。接下来，您想打造什么？

[**Let's talk about the possibilities.**\\
\\
Our dedicated sales experts and engineers can take a look at your code and offer advice on where AI can make the biggest difference.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**我们来聊聊可能性吧。**\\
\\
我们的专属销售专家与工程师可审阅您的代码，并就 AI 能够带来最大价值的环节提供建议。\\
\\
联系我们](https://vercel.com/contact/sales)

· [关注](https://x.com/intent/follow?screen_name=shadcn)

· [在 Twitter 上查看](https://x.com/shadcn/status/1782815166633291958)

How I use [@v0](https://x.com/v0) for UI development ⬇️

我如何将 [@v0](https://x.com/v0) 应用于 UI 开发 ⬇️

Exploration: I rely on v0 a lot for exploration. If you have an idea you want to visualize, type in your prompt & let v0 transforms it into components. For the 1st generation, I always want v0 to be creative. I use the Quality ✨ toggle.

探索阶段：我高度依赖 v0 进行概念探索。若您有一个想要可视化的构想，只需输入提示词（prompt），v0 即可将其转化为可交互的组件。在第一代生成结果中，我始终希望 v0 充分发挥创意性——此时我会启用“质量 ✨”切换开关。

[Watch on X](https://x.com/shadcn/status/1782815166633291958)

[在 X 上观看](https://x.com/shadcn/status/1782815166633291958)

[12:53 PM · Apr 23, 2024](https://x.com/shadcn/status/1782815166633291958) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2024 年 4 月 23 日 下午 12:53](https://x.com/shadcn/status/1782815166633291958) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[978](https://x.com/intent/like?tweet_id=1782815166633291958) [回复](https://x.com/intent/tweet?in_reply_to=1782815166633291958)


[阅读 21 条回复](https://x.com/shadcn/status/1782815166633291958)

Vercel.com 首页

### 助力您的下一次 AI 突破。

博客文章

2024 年 4 月 9 日

### 面向电商的可组合 AI：动手实践 Vercel 的 AI SDK

![](images/7-ai-features-you-can-add-to-your-app-today-vercel/img_001.jpg)

Malte Ubl