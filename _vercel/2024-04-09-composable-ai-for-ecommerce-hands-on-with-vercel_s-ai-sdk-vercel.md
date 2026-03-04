---
title: "Composable AI for ecommerce: Hands-on with Vercel’s AI SDK - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk"
date: "2024-04-09"
scraped_at: "2026-03-02T09:46:24.747064325+00:00"
language: "en-zh"
translated: true
description: "With v0 and the Vercel AI SDK, you can go from AI pipe dream to working prototype in just a few hours. See how AI can transform your ecommerce storefront."
---

render_with_liquid: false
Apr 9, 2024

2024 年 4 月 9 日

Build custom AI-powered features at lightning speed.

以闪电般的速度构建定制化 AI 功能。

Imagine you have a great idea for an AI-powered feature that will transform your ecommerce storefront—but your existing platform stands in the way of innovating and shipping. Legacy platforms come with slow and costly updates, and you're beholden to your vendor's roadmap.

想象一下，你有一个绝佳的创意——一个由 AI 驱动的功能，有望彻底革新你的电商店铺；但现有平台却成了创新与快速上线的阻碍。传统平台更新缓慢、成本高昂，而你只能被动等待供应商按其路线图推进。

[With composable architecture](https://vercel.com/resources/8-advantages-of-composable-commerce), that all changes. You can choose and seamlessly integrate all the best tools, shipping your ideas with maximum efficiency.

[借助可组合式架构（composable architecture）](https://vercel.com/resources/8-advantages-of-composable-commerce)，这一切都将改变。你可以自由选择并无缝集成各类顶尖工具，以最高效率将创意快速交付上线。

At Vercel, we believe composable should include AI. We want it to be as straightforward as possible within the JavaScript ecosystem to develop AI features that enrich your users’ digital experiences.

在 Vercel，我们坚信“可组合性”必须涵盖 AI。我们致力于让开发者在 JavaScript 生态系统中，尽可能轻松地构建能丰富用户数字体验的 AI 功能。

# Contents

# 目录

1. [Case study: AI-powered reviews](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#case-study:-ai-powered-reviews)  
1. [案例研究：AI 驱动的商品评论摘要](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#case-study:-ai-powered-reviews)  
2. [Prompt engineering in Vercel’s AI Playground](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#prompt-engineering-in-vercel%E2%80%99s-ai-playground)  
2. [在 Vercel AI Playground 中进行提示词工程（Prompt Engineering）](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#prompt-engineering-in-vercel%E2%80%99s-ai-playground)  
3. [Using Vercel AI SDK](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#using-vercel-ai-sdk)  
3. [使用 Vercel AI SDK](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#using-vercel-ai-sdk)  
4. [Prototyping UI with v0](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#prototyping-ui-with-v0)  
4. [使用 v0 快速构建 UI 原型](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#prototyping-ui-with-v0)  
5. [Case study takeaways](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#case-study-takeaways)  
5. [案例研究启示](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#case-study-takeaways)  
6. [Ideas for AI features](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#ideas-for-ai-features)  
6. [AI 功能创意集锦](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#ideas-for-ai-features)  
7. [Making search relevant](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#1.-making-search-relevant)  
7. [提升搜索相关性](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#1.-making-search-relevant)  
8. [Speeding up customer support](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#2.-speeding-up-customer-support)  
8. [加速客户支持响应](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#2.-speeding-up-customer-support)  
9. [AI for everyone](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#ai-for-everyone)  
9. [让 AI 触手可及](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk#ai-for-everyone)

## Case study: AI-powered reviews

## 案例研究：AI 驱动的商品评论摘要

I recently [demonstrated the speed and power of composable AI](https://www.linkedin.com/posts/malteubl_today-was-a-great-day-to-get-my-hands-dirty-activity-7164385372733464576-7vf9/). Using a combination of v0, Mistral AI (via Perplexity), and the Vercel AI SDK, I made a [working replica](https://vercel.com/templates/next.js/customer-reviews-ai-summary-nextjs-vercel) of Amazon’s AI-generated review summaries in just a couple of hours.

我最近[展示了可组合式 AI 的速度与强大能力](https://www.linkedin.com/posts/malteubl_today-was-a-great-day-to-get-my-hands-dirty-activity-7164385372733464576-7vf9/)。通过结合使用 v0、Mistral AI（经由 Perplexity 提供）以及 Vercel AI SDK，我仅用数小时便成功构建了一个[可运行的原型](https://vercel.com/templates/next.js/customer-reviews-ai-summary-nextjs-vercel)，复刻了亚马逊平台上的 AI 生成评论摘要功能。

![](images/composable-ai-for-ecommerce-hands-on-with-vercel_s-ai-sdk-vercel/img_001.jpg)![](images/composable-ai-for-ecommerce-hands-on-with-vercel_s-ai-sdk-vercel/img_002.jpg)

For this, I coded up a [Next.js app that prompts an LLM](https://github.com/vercel/ai-review-summary/blob/main/lib/ai-summary.ts) with a product's user reviews and average rating to generate a quick summary of how users feel about the product. This gives shoppers an at-a-glance understanding of product quality beyond the flat star averages or rating distributions.

为此，我开发了一个 [Next.js 应用，用于向大语言模型（LLM）提供某产品的用户评论及平均评分](https://github.com/vercel/ai-review-summary/blob/main/lib/ai-summary.ts)，从而快速生成用户对该产品整体感受的摘要。这使购物者能一目了然地把握产品质量，而不仅限于单调的星级均值或评分分布。

The app is a proof-of-concept, but with a few small tweaks, you could get it working with real product data across your storefront. You can [clone the template](https://vercel.com/templates/next.js/customer-reviews-ai-summary-nextjs-vercel) to further understand the functionality.

该应用是一个概念验证（PoC），但只需少量微调，即可接入您线上商店的真实商品数据并投入实际使用。您可 [克隆此模板](https://vercel.com/templates/next.js/customer-reviews-ai-summary-nextjs-vercel)，以更深入地理解其功能实现。

### Prompt engineering in Vercel’s AI Playground

### 在 Vercel AI Playground 中进行提示词工程

The [prompt I wrote](https://github.com/vercel/ai-review-summary/blob/45813fac9579e3b24cd2268f3bc0d371d019ddfe/lib/ai-summary.ts#L21-L48) can likely be optimized further, but it works great for a start. The real complexity comes in choosing an AI model.

我编写的 [提示词](https://github.com/vercel/ai-review-summary/blob/45813fac9579e3b24cd2268f3bc0d371d019ddfe/lib/ai-summary.ts#L21-L48) 仍有进一步优化空间，但作为起点已表现优异。真正的难点在于选择合适的 AI 模型。

There are a lot of great LLMs out there, which makes it tricky to figure out which one is going to accept the prompt and do the job best. For this review summarizer, I was able to quickly find a suitable model by [competing a few against each other on `play.vercel.ai`](http://play.vercel.ai/).

当前市面上有大量优秀的 LLM，因此要判断哪个模型最能准确理解提示词并出色完成任务，颇具挑战性。针对本评论摘要生成器，我通过在 [`play.vercel.ai`](http://play.vercel.ai/) 上对多个模型进行横向对比测试，迅速筛选出了合适选项。

![To help you determine LLM responsiveness and accuracy, Vercel’s AI Playground lets you quickly test as many models as you’d like with synchronized prompts and chats. You can tweak settings, such as temperature, for each model.](images/composable-ai-for-ecommerce-hands-on-with-vercel_s-ai-sdk-vercel/img_003.jpg)  
![为帮助您评估大语言模型（LLM）的响应速度与准确性，Vercel AI Playground 允许您使用同步的提示词与对话，快速测试任意数量的模型；您还可为每个模型单独调整参数（如 temperature 温度值）。](images/composable-ai-for-ecommerce-hands-on-with-vercel_s-ai-sdk-vercel/img_003.jpg)

To help you determine LLM responsiveness and accuracy, Vercel’s AI Playground lets you quickly test as many models as you’d like with synchronized prompts and chats. You can tweak settings, such as temperature, for each model.

为帮助您评估大语言模型（LLM）的响应速度与准确性，Vercel AI Playground 允许您使用同步的提示词与对话，快速测试任意数量的模型；您还可为每个模型单独调整参数（如 temperature 温度值）。

From this, I determined that Mistral’s open-source, 7-billion-parameter LLM is extremely responsive and accomplishes the job at hand. But for a sophisticated use case, something more capable and computationally expensive, like OpenAI’s GPT-4 or Anthropic’s Claude 3 Opus, might be necessary.

由此我确认：Mistral 推出的开源 70 亿参数 LLM 响应极为迅速，且能高效完成当前任务。但对于更复杂的使用场景，则可能需要能力更强、计算开销更高的模型，例如 OpenAI 的 GPT-4 或 Anthropic 的 Claude 3 Opus。

### Using Vercel AI SDK

### 使用 Vercel AI SDK

[Vercel’s AI SDK](https://sdk.vercel.ai/docs) is an open-source library designed to help developers build conversational streaming user interfaces in JavaScript and TypeScript. The SDK supports React/Next.js, Svelte/SvelteKit, and Vue/Nuxt as well as Node.js, Serverless, and the Edge Runtime.

[Vercel AI SDK](https://sdk.vercel.ai/docs) 是一个开源库，旨在帮助开发者使用 JavaScript 和 TypeScript 构建支持流式响应的对话式用户界面。该 SDK 支持 React/Next.js、Svelte/SvelteKit、Vue/Nuxt，同时也兼容 Node.js、无服务器（Serverless）环境及边缘运行时（Edge Runtime）。

With the AI SDK inside of Next.js App Router, for instance, you can easily tweak the model and its related settings right inside your [Server Components](https://vercel.com/blog/understanding-react-server-components), which allows for enhanced composability:

例如，在 Next.js App Router 中集成 AI SDK 后，您可直接在 [服务端组件（Server Components）](https://vercel.com/blog/understanding-react-server-components) 内便捷地调整模型及其相关配置，从而显著提升组件的可组合性（composability）：

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'



const openai = new OpenAI()



async function submitMessage(userInput) {

7  'use server'



9  return render({

10    provider: openai,
```

```jsx
import { render } from 'ai/rsc'

import OpenAI from 'openai'



const openai = new OpenAI()



async function submitMessage(userInput) {

7  'use server'



9  return render({

10    provider: openai,
```

11    model: 'gpt-4',

11    模型：'gpt-4'，

12    messages: [\
\
12    消息：[\
\
13      { role: 'system', content: 'You are an assistant' },\
\
13      { 角色：'system'，内容：'你是一个助手' }，\
\
14      { role: 'user', content: userInput }\
\
14      { 角色：'user'，内容：userInput }\
\
15    ],

15    ]，

16    text: ({ content }) => <p>{content}</p>,

16    text: ({ content }) => <p>{content}</p>，

17  })

17  })

18}
```

18}
```

This means building even complex AI features becomes like building any other UI. Plus, you can further optimize by, for instance, swapping models in different development environments to see how they perform in context.

这意味着构建即使非常复杂的 AI 功能，也如同构建任何其他 UI 一样简单。此外，你还可以进一步优化——例如，在不同开发环境中切换模型，以观察它们在具体上下文中的表现。

After the query is ready to send to the model, we can use AI SDK and Next.js to stream and cache our response. With the review summarizer demo, [I used Next.js caching](https://github.com/vercel/ai-review-summary/blob/45813fac9579e3b24cd2268f3bc0d371d019ddfe/lib/ai-summary.ts#L60-L82) to ensure the prompt is only sent to the model once, on deploy. However, it can also be configured to be fully dynamic or [programmatically revalidated and statically regenerated without redeploy](https://vercel.com/docs/incremental-static-regeneration).

当查询已准备就绪、可发送至模型时，我们可以借助 AI SDK 和 Next.js 实现响应的流式传输与缓存。在“评论摘要生成器”示例中，[我使用了 Next.js 的缓存机制](https://github.com/vercel/ai-review-summary/blob/45813fac9579e3b24cd2268f3bc0d371d019ddfe/lib/ai-summary.ts#L60-L82)，确保提示词（prompt）仅在部署时向模型发送一次。不过，该机制也可配置为完全动态，或通过编程方式触发重新验证，并在不重新部署的前提下完成静态内容的再生（[增量静态再生，ISR](https://vercel.com/docs/incremental-static-regeneration)）。

### Prototyping UI with v0

### 使用 v0 快速构建 UI 原型

Now that I had a way to return a response from the model, I needed a place to display it. Here, I could use another AI tool, Vercel’s v0, which allows you to generate usable React UI from text and image prompts, so you can quickly get a feel for user experience.

既然我已经有了从模型获取响应的方法，接下来就需要一个地方来展示该响应。此时，我可以借助另一款 AI 工具——Vercel 推出的 v0。v0 能根据文本或图像提示自动生成可用的 React UI 组件，从而帮助你快速把握用户体验。

Here’s a brief overview of how it works:

以下是其工作原理的简要说明：

Once I had a design that I liked as a base, I could then tweak individual parts of it. For instance, if I wanted the font to be bigger on a heading, I could click that heading and prompt.  

一旦我选定一个满意的初始设计，便可对其中各个部分进行微调。例如，若希望标题的字体更大，我只需点击该标题并输入提示词即可。

When I was happy, I pasted the code directly into my prototype. For this demo, that was all the UI I needed to test feature viability.  

当我满意后，便直接将生成的代码粘贴到我的原型中。在本次演示中，这便是我验证该功能可行性的全部所需 UI。

### Case study takeaways  

### 案例研究启示

To get proper outputs from AI, you need a lot of space to experiment and iterate.  

要从 AI 获得高质量输出，你需要充足的试错与迭代空间。

Vercel’s AI SDK and v0 maximize iteration speed in order to fail faster and get to the right solution. AI SDK provides an abstraction layer to hot-swap a variety of the latest AI models in and out of your application. v0 generates usable UI from prompts, so you can quickly get a feel for the user experience.  

Vercel 的 AI SDK 与 v0 共同极大提升了迭代速度——让你更快失败、更快抵达正确解法。AI SDK 提供一层抽象接口，支持在应用中热切换多种最新 AI 模型；v0 则能根据自然语言或图像提示直接生成可用的 UI，助你快速感知用户体验。

Combined, these tools let you prove—often in a single day—whether a complex AI idea will work as a feature for your business.  

二者结合，使你往往仅需一天时间，即可验证一项复杂的 AI 构想能否真正落地为业务可用的功能。

[**v0 is available for everyone.**\\  
\\  
Generate UI in seconds with text or images. What will you ship?\\  
\\  
Napkin Sketch Time](https://v0.dev/)  

[**v0 面向所有人开放。**\\  
\\  
用文字或图片，几秒钟即可生成 UI。你将交付什么？\\  
\\  
“餐巾纸草图”时刻](https://v0.dev/)

## Ideas for AI features  

## AI 功能创意方向

The beauty of modern LLMs is how quickly you can move, and how you don’t necessarily need PhD levels of expertise to create impactful automation. A composable commerce workflow on Vercel means you choose the AI providers that best suit your needs and swap them out as better models and products come to market.  

现代大语言模型（LLM）的魅力在于其惊人的开发速度，以及无需博士级专业知识即可构建高影响力自动化能力的低门槛特性。“可组合式电商工作流”（composable commerce workflow）在 Vercel 上得以实现：你可以自由选择最契合自身需求的 AI 服务商，并随着更优模型与产品的上市而灵活替换。

In the case of the review summary generator above, the need for which I was trying to solve was relatively hypothetical. However, your business likely has very tangible challenges that can be solved through AI.  

以上述“评论摘要生成器”为例，我尝试解决的问题在当时尚属假设性场景。但你的业务很可能正面临真实、具体、且可通过 AI 解决的挑战。

Here are two examples:

以下是两个示例：

### 1\. Making search relevant

### 1. 提升搜索的相关性

Ecommerce sites often suffer from search that delivers irrelevant results, which kills sales. Traditional search functionalities—like matching keywords and their stems, handling misspellings and synonyms, and ranking for context and relevance—are typically tedious to implement and optimize.

电商平台常因搜索返回不相关结果而遭受损失，进而严重影响销售。传统搜索功能——例如关键词及其词干匹配、错别字与同义词处理、以及基于上下文和相关性的排序——通常实现和优化起来十分繁琐。

LLMs almost instantly solve this problem since they have an inherent understanding of language, synonyms, context, and nuance. They can be tuned on your store’s specific product offerings, and they can adapt over time to provide better results.

大语言模型（LLM）几乎能即时解决这一问题，因其天然具备对语言、同义词、上下文及细微语义的理解能力。它们可针对您店铺特有的商品目录进行微调，并能随时间推移持续适应，从而提供更优的搜索结果。

There’s also plenty of room with LLMs to go beyond the basics and offer fully dynamic faceted search, which intelligently adapts available filters and search results in real time based on the user's query and selections. This can drastically speed up product discovery and make the process of shopping more intuitive.

此外，LLM 还有广阔空间超越基础功能，实现完全动态的面性搜索（faceted search）：它能根据用户的查询内容和筛选操作，在实时中智能调整可选筛选条件与搜索结果。这将极大加快商品发现速度，让购物过程更加直观自然。

### 2\. Speeding up customer support

### 2. 加快客户服务响应速度

Customers expect immediacy and convenience. To deliver on this across a storefront outside of working hours, businesses often choose to employ chatbots.

客户期待即时响应与便捷体验。为在营业时间之外的线上门店持续满足这一需求，企业往往选择部署聊天机器人。

However, managing chat has all the same natural language challenges as search—plus a whole bunch more, such as limited world knowledge, lack of personalization, and no ability to self-improve.

然而，聊天管理所面临的自然语言挑战，与搜索面临的问题完全相同——甚至更为复杂，例如世界知识有限、缺乏个性化能力，以及无法自主学习改进。

LLMs provide an elegant solution for this and are able to offer quick, personalized, and even multilingual support out of the box.

大语言模型（LLM）为此提供了优雅的解决方案，开箱即用即可提供快速、个性化乃至多语言的客户服务支持。

Klarna, for instance, recently reported that [their OpenAI-powered chatbot](https://www.klarna.com/international/press/klarna-ai-assistant-handles-two-thirds-of-customer-service-chats-in-its-first-month/) is on par with human agents in regard to customer satisfaction but resolves queries in 80% less time. The bot accomplishes the work of 700 full-time agents and drives $40M in net revenue.

例如，Klarna 近期报告称，[其基于 OpenAI 的聊天机器人](https://www.klarna.com/international/press/klarna-ai-assistant-handles-two-thirds-of-customer-service-chats-in-its-first-month/) 在客户满意度方面已媲美人工客服，但问题解决耗时却减少了 80%。该机器人承担了相当于 700 名全职客服人员的工作量，并创造了 4000 万美元的净收入。

## AI for everyone

## 人人可用的 AI

Cutting-edge AI features shouldn't be a luxury reserved for tech giants. Composable AI democratizes development, empowering you to choose the best providers and build better storefronts, faster.

前沿 AI 功能不应只是科技巨头的专属奢侈品。可组合式 AI（Composable AI）让开发走向大众化，赋予您自由选择最优服务提供商的能力，并更快地构建更出色的线上商店。

We understand that fast implementation speed and customer personalization are musts to stay competitive, so we will keep developing tools like v0—which let you prototype at the speed of thought—and [innovating further into the generative UI space](https://vercel.com/blog/ai-sdk-3-generative-ui).

我们深知，在激烈竞争中，快速落地与客户个性化体验已成为刚需。因此，我们将持续打造如 v0 这样的工具——助您以“所思即所得”的速度完成原型开发——并进一步[深耕生成式 UI（Generative UI）领域](https://vercel.com/blog/ai-sdk-3-generative-ui)。

[**Ready for the future of ecommerce?**\\  
\\  
Break free from the monolith. Learn how the Vercel stack can accelerate your digital success.\\  
\\  

Vercel.com landing page

[**准备好迎接电商的未来了吗？**\\  
\\  
摆脱单体架构束缚。了解 Vercel 技术栈如何加速您的数字化成功。\\  
\\  

Vercel.com 着陆页

### Power your next AI breakthrough.

### 赋能您的下一次 AI 突破。

Vercel.com landing page

Vercel.com 着陆页

### Understand the wins.

### 深刻理解各项优势。