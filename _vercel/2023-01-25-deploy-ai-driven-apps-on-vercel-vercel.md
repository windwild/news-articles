---
render_with_liquid: false
title: "Deploy AI-driven apps on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploying-ai-applications"
date: "2023-01-25"
scraped_at: "2026-03-02T09:56:07.823568598+00:00"
language: "en-zh"
translated: true
description: "Deploying AI-driven apps on Vercel is easier than ever before. Here's some templates and tooling to jump-start your AI application."
---
render_with_liquid: false
render_with_liquid: false

Jan 25, 2023

2023 年 1 月 25 日

Tooling and templates to jump-start your AI workflow.

助力您快速启动 AI 工作流的工具与模板。

[AI](https://vercel.com/ai) is transforming how we build and communicate on the Web—nowhere seen more clearly than on Vercel. A stable diffusion search engine, a suite of AI-powered visual editing tools, and even a rejection generator are just a few of the [new projects keeping us amazed](https://twitter.com/steventey/status/1610656840412696578?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps).

[AI](https://vercel.com/ai) 正在重塑我们构建和沟通 Web 应用的方式——这一点在 Vercel 上体现得尤为明显。一个基于 Stable Diffusion 的搜索引擎、一套由 AI 驱动的视觉编辑工具，甚至一个“拒信生成器”，都只是让我们惊叹的[众多新项目中的一小部分](https://twitter.com/steventey/status/1610656840412696578?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps)。

Whether you’re just starting out with AI or have experience in the field, let's explore how AI teams are building new projects, faster on Vercel.

无论您是刚刚接触 AI，还是已在该领域拥有丰富经验，让我们一起探索 AI 团队如何在 Vercel 上更快速地构建全新项目。

One-step templates mentioned in this post:

本文中提到的一键式模板：

- [Twitter Bio Generator](https://vercel.com/blog/deploying-ai-applications#twitter-bio-generator)

- [Twitter 简介生成器](https://vercel.com/blog/deploying-ai-applications#twitter-bio-generator)

- [Photo Restorer](https://vercel.com/blog/deploying-ai-applications#photo-restorer-(with-replicate))

- [照片修复工具](https://vercel.com/blog/deploying-ai-applications#photo-restorer-(with-replicate))

- [Image Alt Text Generator](https://vercel.com/blog/deploying-ai-applications#image-alt-text-generator-(with-replicate))

- [图片替代文本（Alt Text）生成器](https://vercel.com/blog/deploying-ai-applications#image-alt-text-generator-(with-replicate))

- [DALL·E 2 Art Generator](https://vercel.com/blog/deploying-ai-applications#dall%C2%B7e-2-art-generator)

- [DALL·E 2 艺术图像生成器](https://vercel.com/blog/deploying-ai-applications#dall%C2%B7e-2-art-generator)

- [Extrapolate - AI Aging App](https://vercel.com/blog/deploying-ai-applications#extrapolate---ai-aging-app)

- [Extrapolate — AI 变老应用](https://vercel.com/blog/deploying-ai-applications#extrapolate---ai-aging-app)

## Building your AI stack

## 构建您的 AI 技术栈

By using Vercel to build and deploy a headless stack, you can easily connect your data and integrate AI features such as natural language processing, image recognition, or speech translation into your favorite framework.

通过使用 Vercel 构建和部署无头（headless）技术栈，您可以轻松连接自有数据，并将自然语言处理、图像识别或语音翻译等 AI 功能集成到您最喜爱的框架中。

### OpenAI machine learning models

### OpenAI 机器学习模型

**ChatGPT**

**ChatGPT**

[ChatGPT](https://openai.com/blog/chatgpt/) is a natural language processing model that focuses on understanding the context of a conversation. It uses sentiment analysis (option mining) for complex and surprisingly human conversations.

[ChatGPT](https://openai.com/blog/chatgpt/) 是一种专注于理解对话上下文的自然语言处理模型。它借助情感分析（又称“选项挖掘”，option mining），实现复杂且出人意料地拟人化的对话效果。

**Other models**

**其他模型**

OpenAI's currently available GPT-3 models include DaVinci, Curie, Babbage, and Ada, which have each been created to accomplish [specific tasks](https://beta.openai.com/docs/models). To feel out the differences between them and understand which one will work best for your application, we recommend heading over [to our AI Playground.](https://play.vercel.ai/)

OpenAI 当前可用的 GPT-3 模型包括 DaVinci、Curie、Babbage 和 Ada，每种模型均针对完成[特定任务](https://beta.openai.com/docs/models)而设计。为直观感受各模型之间的差异，并确定哪一款最适合您的应用场景，我们推荐您访问我们的 [AI Playground](https://play.vercel.ai/)。

Additionally, you can stress test DaVinci in both our [Twitter Bio Generator](https://vercel.com/templates/next.js/twitter-bio) and [GPT-3 Chatbot](https://vercel.com/templates/next.js/ai-gpt3-chatbot) templates.

此外，您还可通过我们的 [Twitter 简介生成器](https://vercel.com/templates/next.js/twitter-bio) 和 [GPT-3 聊天机器人](https://vercel.com/templates/next.js/ai-gpt3-chatbot) 模板对 DaVinci 进行压力测试。

**Whisper**

**Whisper**

[OpenAI's Whisper](https://openai.com/blog/whisper/) is a GPT-3 model that can accurately identify spoken words, even with accents or background noise. Since Whisper was trained on over 680,000 hours of audio from 97 different languages, it can quickly transcribe audio to text, or even translate it from one language to another. It has the potential to revolutionize how we interact with AI, using our own voice instead of typing commands.

[OpenAI 的 Whisper](https://openai.com/blog/whisper/) 是一款基于 GPT-3 的语音识别模型，能够精准识别口语内容，即使说话者带有口音或环境存在背景噪音亦可胜任。由于 Whisper 在涵盖 97 种语言、总计逾 68 万小时的音频数据上进行了训练，它不仅能快速将语音转录为文字，甚至还能实现跨语言实时翻译。该模型有望彻底改变我们与 AI 的交互方式——从敲击键盘输入指令，转变为直接用语音进行沟通。

**DALL·E 2**

**DALL·E 2**

[DALL·E 2](https://openai.com/dall-e-2/) is a version of GPT-3 that allows you to generate realistic images or art from natural language. It supports outpainting, which means you can use existing images to influence the direction of the output. Additionally, it can be used to refine existing images, which makes it a powerful tool for digital art.

[DALL·E 2](https://openai.com/dall-e-2/) 是 GPT-3 的一个版本，支持根据自然语言描述生成逼真的图像或艺术作品。它支持“外绘”（outpainting）功能，即利用现有图像引导生成结果的方向；此外，还可用于优化和精修已有图像，因此成为数字艺术创作中极为强大的工具。

While DALL **·** E 2 is comparable to Midjourney and Stable Diffusion, the output from each of these three text-to-image methods varies heavily. Try playing with our [DALL·E 2 Art Generator](https://vercel.com/templates/next.js/dall-e) or [Inpainting with Stable Diffusion](https://vercel.com/templates/next.js/inpainter-stable-diffusion) templates to get a feel for some of the differences.

尽管 DALL·E 2 与 Midjourney 和 Stable Diffusion 属于同类文本生成图像模型，但三者在实际输出效果上差异显著。欢迎尝试我们的 [DALL·E 2 艺术生成器模板](https://vercel.com/templates/next.js/dall-e) 或 [基于 Stable Diffusion 的图像修复模板](https://vercel.com/templates/next.js/inpainter-stable-diffusion)，亲身体验它们之间的区别。

### Running your AI models in the cloud

### 在云端运行您的 AI 模型

[Replicate](https://replicate.com/) is a company deployed on Vercel that allows you to run open-source machine learning models (like OpenAI) on their GPUs, and then access those models through their cloud API. This is vital for teams who want to experiment at scale without spinning up their own server farms.

[Replicate](https://replicate.com/) 是一家部署在 Vercel 上的公司，支持您在其 GPU 上运行开源机器学习模型（例如 OpenAI 相关模型），并可通过其云 API 访问这些模型。对于希望大规模开展实验、又无需自建服务器集群的团队而言，这一能力至关重要。

Replicate has plenty of [models to choose from](https://replicate.com/explore), with in-app demos, example code, and full API documentation.

Replicate 提供了丰富的 [可选模型库](https://replicate.com/explore)，每个模型均配有应用内演示、示例代码及完整的 API 文档。

### Choosing the right framework

### 选择合适的框架

Whichever AI API you work with, you'll need a framework to present the data to your end user in an understandable and engaging way. Next.js and SvelteKit 1.0 both make formidable frameworks to handle the complexities of AI-driven applications. Here, in part, is why:

无论您使用哪一种 AI API，都需要一个框架，以清晰、直观且富有吸引力的方式向终端用户呈现数据。Next.js 与 SvelteKit 1.0 均是应对 AI 驱动型应用复杂需求的强劲框架。以下为其关键优势（部分）：

1. **API routes.** Making a dedicated API route is a simple matter of placing any file inside the pages/api [directory for Next.js](https://nextjs.org/docs/api-routes/introduction?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps) or placing a `+server.js` file anywhere in your [SvelteKit directory](https://kit.svelte.dev/docs/routing#server?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps). Dedicated API routes enable you to keep your AI API code entirely separate from the other logic of your application, and they provide a safe place to store sensitive environment variables.

1. **API 路由（API Routes）。** 创建专用 API 路由非常简单：在 Next.js 中，只需将任意文件放入 `pages/api` 目录即可；而在 SvelteKit 中，则可在项目目录任意位置创建一个 `+server.js` 文件。专用 API 路由使您的 AI API 逻辑完全独立于应用其他业务逻辑，并为存储敏感环境变量提供安全可靠的场所。

2. **Code splitting.** [Code splitting](https://nextjs.org/learn/foundations/how-nextjs-works/code-splitting) allows for large applications to be broken down into smaller bundles which can then be selectively loaded on demand or in parallel, reducing the downloads needed at page load. Both Next.js and [SvelteKit](https://vercel.com/docs/frameworks/sveltekit) use code splitting out-of-the-box, which keeps your AI application feeling fast no matter how large it scales.

2. **代码分割（Code Splitting）。** [代码分割](https://nextjs.org/learn/foundations/how-nextjs-works/code-splitting) 可将大型应用拆分为更小的代码包，并按需或并行加载，从而显著减少页面初始加载时所需的下载量。Next.js 与 [SvelteKit](https://vercel.com/docs/frameworks/sveltekit) 均默认支持代码分割，确保您的 AI 应用即便规模持续扩大，依然保持流畅迅捷的用户体验。

3. **Full TypeScript integration.** TypeScript can help even the most complex AI APIs become more readable and extendable in your code through tighter IDE integration. TypeScript can be enabled in Next.js or SvelteKit with one command when installing.

3. **完整的 TypeScript 集成。** TypeScript 可通过更紧密的 IDE 集成，帮助您在代码中更清晰地阅读和扩展即使最为复杂的 AI API。在安装 Next.js 或 SvelteKit 时，仅需一条命令即可启用 TypeScript。

4. **Hot Module Replacement.** Both Next.js and SvelteKit provide HMR, which allows you to see changes to your app’s local preview without refreshing the page. This vastly improves iteration speed and helps you stay in flow.

4. **热模块替换（HMR）。** Next.js 和 SvelteKit 均支持热模块替换（HMR），让您无需刷新页面即可实时查看应用本地预览的变更。这极大提升了迭代速度，并助您持续保持开发专注与流畅。

Deploying [Next.js](https://vercel.com/solutions/nextjs) or [SvelteKit](https://vercel.com/docs/frameworks/sveltekit) on Vercel is as simple as a `git` commit and offers the ability to scale up your application while Vercel manages the infrastructure. This is perfect for AI startups, who often need to focus their time and capital in other realms.

在 Vercel 上部署 [Next.js](https://vercel.com/solutions/nextjs) 或 [SvelteKit](https://vercel.com/docs/frameworks/sveltekit) 简单得只需一次 `git` 提交；Vercel 将为您托管基础设施，同时支持您的应用弹性伸缩。这对 AI 初创公司而言尤为理想——它们往往需要将时间与资金集中投入于其他关键领域。

![](images/deploy-ai-driven-apps-on-vercel-vercel/img_001.png)


Jasper is an AI Writing Assistant deployed with Next.js on Vercel that helps users generate engaging and ethical content. It takes input from the user and produces posts, tweets, short stories, and more.

Jasper 是一款基于 Next.js 部署于 Vercel 的 AI 写作助手，可帮助用户生成引人入胜且符合伦理规范的内容。它接收用户输入，并自动生成社交媒体帖子、推文、短篇故事等多样化文本。

The company recently acquired Outwrite to build an extension that works inside Microsoft Word, Google Docs, social media, and any text field online. They've also partnered with Surfer to let users SEO-optimize their content with AI-generated advice.

该公司近期收购了 Outwrite，以打造一款可在 Microsoft Word、Google Docs、社交媒体平台及任意网页文本框内运行的浏览器扩展。此外，Jasper 还与 Surfer 达成合作，使用户能够借助 AI 生成的专业建议，对内容进行搜索引擎优化（SEO）。

### Managed infrastructure

### 托管式基础设施

The [OpenAI](https://vercel.com/docs/integrations/openai) API (and others in the field) can take a long time to complete a roundtrip, and you may run into timeouts when using serverless compute. Take a look at our [serverless limits docs](https://vercel.com/docs/concepts/limits/overview#general-limits) to learn about the timeout limitations by plan.

[OpenAI](https://vercel.com/docs/integrations/openai) API（以及该领域其他类似 API）完成一次往返调用可能耗时较长；若采用无服务器（serverless）计算，您很可能会遭遇超时问题。请参阅我们的 [无服务器限制文档](https://vercel.com/docs/concepts/limits/overview#general-limits)，了解各套餐所对应的超时限制。

You can also opt for [Vercel Edge Functions](https://vercel.com/features/edge-functions), which not only have a much higher threshold of execution time, but also offer the ability to stream responses and allow much more time to process API data. This means you can locate your API calls as close to the AI server as possible to speed up the user experience.

您还可选择使用 [Vercel 边缘函数（Edge Functions）](https://vercel.com/features/edge-functions)：它不仅执行时限显著更高，还支持响应流式传输（streaming），并为 API 数据处理预留更充裕的时间。这意味着您可以将 API 调用尽可能部署在靠近 AI 服务端的位置，从而大幅提升用户体验。

Check out our [Twitter Bio Generator template](https://vercel.com/blog/deploying-ai-driven-apps-on-vercel#twitter-bio-generator) and the video below to learn more about how these Edge Functions can work for you.

请查看我们的 [Twitter 个人简介生成器模板](https://vercel.com/blog/deploying-ai-driven-apps-on-vercel#twitter-bio-generator)，以及下方视频，进一步了解边缘函数如何为您赋能。

Also, take a look at [some of our other customers](https://vercel.com/customers/industries/ai) using Vercel's managed global infrastructure to ship their products out to the world.

此外，欢迎查看 [我们其他一些客户](https://vercel.com/customers/industries/ai)，他们正借助 Vercel 托管的全球基础设施，将产品推向全球市场。

![](images/deploy-ai-driven-apps-on-vercel-vercel/img_002.png)


Scale is a data platform company that helps machine learning teams at places like Lyft, SAP, and Nuro fast-track their AI development. They provide a comprehensive approach for managing the entire machine learning lifecycle with data-driven solutions.

Scale 是一家数据平台公司，致力于帮助 Lyft、SAP 和 Nuro 等企业的机器学习团队加速 AI 开发进程。他们提供一套以数据驱动为核心的完整方案，全面管理机器学习全生命周期。

Learn more about [how Vercel enables Scale to save cost](https://vercel.com/customers/scale-unifies-design-and-performance-with-next-js-and-vercel) in design and infrastructure, iterating rapidly through use of quick buildtimes, Preview Deployments, performance analytics, and the Vercel CLI. The team also appreciated Vercel's partner integrations with Okta, GitHub, and Slack.

进一步了解 [Vercel 如何助力 Scale 在设计与基础设施方面降低成本](https://vercel.com/customers/scale-unifies-design-and-performance-with-next-js-and-vercel)：通过极速构建（quick buildtimes）、预览部署（Preview Deployments）、性能分析（performance analytics）以及 Vercel CLI，实现快速迭代；团队也高度认可 Vercel 与 Okta、GitHub 和 Slack 等合作伙伴的深度集成。

### Streamlined collaboration

### 简化协作流程

![](images/deploy-ai-driven-apps-on-vercel-vercel/img_003.jpg)![](images/deploy-ai-driven-apps-on-vercel-vercel/img_004.jpg)

Vercel encourages innovation through collaboration with [comments on Preview Deployments](https://vercel.com/blog/introducing-commenting-on-preview-deployments). From any pull request, you can view your application from a user's perspective, leaving comments for your whole team that stay embedded in the visual context of the needed fix.

Vercel 通过 [预览部署中的评论功能](https://vercel.com/blog/introducing-commenting-on-preview-deployments) 推动协作式创新。在任意 Pull Request 中，你都能以终端用户视角浏览应用，并为整个团队留下评论——这些评论始终嵌入在待修复问题的视觉上下文中。

When working with AI, applications can grow to a point where it's hard to track issues, especially in the areas that most affect your users. Comments on Preview Deployments allow you and your team to iterate faster while staying committed to a product everyone loves to ship.

在 AI 应用开发过程中，系统规模可能迅速膨胀，导致问题难以追踪——尤其在那些对用户体验影响最显著的环节。预览部署中的评论功能，让你和团队得以更快迭代，同时坚守打造一款人人乐于交付的卓越产品的初心。

![](images/deploy-ai-driven-apps-on-vercel-vercel/img_005.png)


Viable uses AI to analyze customer feedback and present insights to businesses to improve products and services. With just six engineers, they’ve already processed 3.8 million data points for businesses like Latch, Uber, and AngelList.

Viable 运用 AI 技术分析客户反馈，向企业输出可落地的洞察，助力其优化产品与服务。仅凭六名工程师，该公司已为 Latch、Uber 和 AngelList 等企业处理了 380 万条数据点。

Founded in 2020, Viable’s team has been using Vercel since the beginning. Their AI product is built with Next.js and deployed to Vercel, helping them rapidly innovate and scale their infrastructure with high demand from customers.

成立于 2020 年，Viable 团队自创立之初便开始使用 Vercel。其 AI 产品基于 Next.js 构建，并部署在 Vercel 上，从而帮助团队在客户高需求下快速创新并扩展基础设施。

Check out how [Viable uses Vercel's workflow](https://vercel.com/blog/delivering-ai-analysis-faster-with-the-vercel-workflow), including comments on Preview Deployments to preserve team context, while working with complex applications.

请查看 [Viable 如何运用 Vercel 的工作流](https://vercel.com/blog/delivering-ai-analysis-faster-with-the-vercel-workflow)，包括在预览部署（Preview Deployments）中添加评论以保留团队上下文，尤其适用于复杂应用的开发场景。

### Further recommendations

### 更多推荐

Next.js and SvelteKit apps on Vercel easily integrate with everything you need to develop your AI applications. For more recommendations, check out [this thread](https://twitter.com/steventey/status/1618298340541886465?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps) of must-learn tools for building and deploying AI applications.

部署在 Vercel 上的 Next.js 和 SvelteKit 应用可轻松集成开发 AI 应用所需的一切工具。如需更多推荐，请参阅 [这篇汇总帖](https://twitter.com/steventey/status/1618298340541886465?utm_source=vercel_site&utm_medium=blog&utm_campaign=blog_deploying_ai_apps)，其中列出了构建与部署 AI 应用必备的学习工具。

## One-click deploy AI templates

## 一键部署 AI 模板

Itching to play around with some AI? We’ve got you covered with our currently-expanding [collection of templates](https://vercel.com/templates/ai):

想动手试试 AI？我们已为您准备了持续扩充中的 [AI 模板合集](https://vercel.com/templates/ai)，助您即刻上手！

### Twitter Bio Generator

### 推特简介生成器

[Twitter Bio Generator](https://vercel.com/templates/next.js/twitter-bio) makes new social media bios using the [OpenAI](https://vercel.com/docs/integrations/openai) GPT-3 API ( [`text-davinci-003`](https://beta.openai.com/docs/models)) and [Vercel Edge Functions](https://vercel.com/features/edge-functions) with streaming. It constructs a prompt based on the form and user input, sends it to the GPT-3 API via an Edge Function, then streams the response back to the application.

[Twitter Bio Generator（推特简介生成器）](https://vercel.com/templates/next.js/twitter-bio) 利用 [OpenAI](https://vercel.com/docs/integrations/openai) 的 GPT-3 API（[`text-davinci-003`](https://beta.openai.com/docs/models)）和支持流式响应的 [Vercel Edge Functions（边缘函数）](https://vercel.com/features/edge-functions) 自动生成社交媒体个人简介。它根据表单字段与用户输入构造提示词（prompt），通过 Edge Function 将请求发送至 GPT-3 API，并将响应以流式方式实时返回给前端应用。

To see a more in-depth explanation of working with Vercel Edge Functions and OpenAI's API—especially in regards to handling long response times—check out the video below:

如需深入了解如何结合使用 Vercel Edge Functions 与 OpenAI API（尤其是针对长响应时间的处理策略），请观看下方视频：

An explanation for how to build GPT-3 powered apps with OpenAI and Vercel Edge Functions.

一段关于如何利用 OpenAI 与 Vercel Edge Functions 构建 GPT-3 驱动应用的技术讲解。

### AI Room Generator

### AI 房间生成器

[AI Room Generator](https://vercel.com/templates/next.js/room-GPT) uses an ML model called [ControlNet](https://github.com/lllyasviel/ControlNet) to generate variations of real rooms. The user can upload a photo of any room and then the application will take the user's prompt and transform the space into their dream room.

[AI 房间生成器](https://vercel.com/templates/next.js/room-GPT) 使用一种名为 [ControlNet](https://github.com/lllyasviel/ControlNet) 的机器学习模型，生成真实房间的多种变体。用户可上传任意房间的照片，应用将结合用户的文本提示（prompt），将该空间转化为其理想中的房间。

The ML Model is hosted on [Replicate](https://replicate.com/) and uses [Upload](https://upload.io/) for image storage.

该机器学习模型托管在 [Replicate](https://replicate.com/) 平台上，并使用 [Upload](https://upload.io/) 进行图像存储。

A quick demonstration of the capabilities of the AI Room Generator template.

以下是 AI 房间生成器模板功能的简要演示。

### Photo Restorer (with Replicate)

### 照片修复工具（基于 Replicate）

[Photo Restorer](https://vercel.com/templates/next.js/ai-photo-restorer) livens up old face photos using AI. It uses a machine learning model from the Applied Research Center called GFPGAN on Replicate to restore face photos. This application gives you the ability to upload any photo, which will send it through this machine learning model using a Next.js API route, and return your restored photo.

[照片修复工具](https://vercel.com/templates/next.js/ai-photo-restorer) 利用 AI 为陈旧的人脸照片注入活力。它调用由 Applied Research Center 研发、部署于 Replicate 平台的机器学习模型 GFPGAN 来修复人脸图像。本应用支持用户上传任意照片，通过 Next.js 的 API 路由将其送入该机器学习模型处理，并返回修复后的照片。

Check out this video on how we built this template to give you the starter code for your own AI apps:

请观看此视频，了解我们如何构建该模板——它将为您提供开发自有 AI 应用的入门代码：

An explanation for how to build your own AI web apps with Next.js and Replicate.

一篇关于如何使用 Next.js 和 Replicate 构建自有 AI 网页应用的详细说明。

### Image Alt Text Generator (with Replicate)

### 图像替代文本生成器（基于 Replicate）

[Image Alt Text Generator](https://vercel.com/templates/next.js/ai-alt-text-generator) uses a machine learning model from Salesforce called [BLIP](https://github.com/salesforce/BLIP) on Replicate’s cloud API to generate relevant alt text for images. You can feed the Next.js API route an image as a query parameter and it will return a one-sentence description of that image.

[图像替代文本生成器](https://vercel.com/templates/next.js/ai-alt-text-generator) 基于 Salesforce 开发的机器学习模型 [BLIP](https://github.com/salesforce/BLIP)，通过 Replicate 的云 API 为图像生成恰当的替代文本（alt text）。您可将图像作为查询参数传入 Next.js 的 API 路由，系统将返回对该图像的一句话描述。

Rather code your REST APIs in Python? We’ve got you covered with our [Flask version of this template](https://vercel.com/templates/python/flask-alt-text-generator).

更倾向于用 Python 编写 REST API？我们已为您准备好了该模板的 [Flask 版本](https://vercel.com/templates/python/flask-alt-text-generator)。

### DALL·E 2 Art Generator

### DALL·E 2 艺术生成器

[DALL·E 2 AI Art Generator](https://vercel.com/templates/next.js/dall-e) uses an machine learning model from OpenAI called DALLE-2 to generate an image using AI with just a text description. When text is submitted, the application proxies calls to the OpenAI API via QStash in `/api/image`. QStash sends responses to `/api/callback` in the form of an image URL, which is persisted to Upstash Redis. After calling the OpenAI API, the client polls Redis and loads the image on the page once it's available.

[DALL·E 2 AI 艺术生成器](https://vercel.com/templates/next.js/dall-e) 使用 OpenAI 提供的机器学习模型 DALL·E 2，仅凭一段文字描述即可生成图像。当用户提交文本后，应用通过 QStash 将请求代理至 OpenAI API（路径为 `/api/image`）。QStash 将响应（以图像 URL 形式）发送至 `/api/callback`，该 URL 随即被持久化存储至 Upstash Redis。调用 OpenAI API 后，客户端轮询 Redis，待图像就绪即加载至页面。

### Extrapolate - AI Aging App

### Extrapolate — AI 年龄模拟应用

[Extrapolate](https://vercel.com/templates/next.js/extrapolate) is an app that takes a photo and outputs a GIF showing how you might age. It uses Cloudflare R2 to store and retrieve images and [Upstash](https://upstash.com/) qStash to remain privacy-friendly, deleting all photos from the server within 24 hours. The app also has a feature that can notify you via email when your GIF is ready, thanks to [Replicate's](https://replicate.com/) web hooks.

[Extrapolate](https://vercel.com/templates/next.js/extrapolate) 是一款可上传照片并输出 GIF 动图的应用，直观展示您未来可能的衰老样貌。它使用 Cloudflare R2 存储与检索图像，并借助 [Upstash](https://upstash.com/) 的 qStash 实现隐私友好设计——所有照片将在服务器上保留不超过 24 小时即被自动删除。此外，得益于 [Replicate](https://replicate.com/) 提供的 Webhook 功能，应用还支持在 GIF 生成完成时通过电子邮件通知您。

[Cloudflare R2 Object Storage](https://www.cloudflare.com/lp/pg-r2/) is an S3-compatible solution designed to store large amounts of unstructured data with zero egress fees. It provides reliable access from any Cloudflare datacenter, integrates fully with Cloudflare Workers, and has a generous free tier.

[Cloudflare R2 对象存储](https://www.cloudflare.com/lp/pg-r2/) 是一种兼容 Amazon S3 的存储解决方案，专为海量非结构化数据而设计，且不收取任何数据出口（egress）费用。它支持从任意 Cloudflare 数据中心稳定访问，与 Cloudflare Workers 深度集成，并提供宽裕的免费配额。

## Your AI journey starts here

## 您的 AI 开发之旅，由此启程

Whatever AI app you [imagine building](https://v0.dev/) , you can build it on Vercel. Our Hobby plan is the perfect way to play around with new ideas, but [upgrading to Pro](https://vercel.com/pricing) unlocks increased Edge Functions for querying AI APIs, longer serverless timeouts, team comments on password-protected preview deployments, and much more.

无论您构想出怎样的 AI 应用——[尽可大胆尝试](https://v0.dev/)——Vercel 都能助您实现。我们的 Hobby（入门）计划是探索新创意的理想起点；而[升级至 Pro 计划](https://vercel.com/pricing)则可解锁更多能力：例如调用 AI API 所需的更高配额 Edge Functions、更长的无服务器函数超时时间、支持密码保护预览部署的团队协作评论功能，以及更多高级特性。

Have questions about getting started? We're [happy to talk with you](https://vercel.com/contact/sales) about the best way to ship your AI application in 2023.

对如何起步仍有疑问？我们非常乐意[与您交流](https://vercel.com/contact/sales)，共同探讨如何在 2023 年高效交付您的 AI 应用。

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Next.js application for inpainting with Stable Diffusion using the Replicate API.

### 基于 Replicate API、使用 Stable Diffusion 实现图像修复的 Next.js 应用

Inpainter with Stable Diffusion

基于 Stable Diffusion 的图像修复工具

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### A flask API that generates a description for any image.

### 一个为任意图像生成描述的 Flask API

Flask Alt Text Generator

Flask 替代文本生成器