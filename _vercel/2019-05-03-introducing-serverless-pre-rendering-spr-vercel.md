---
render_with_liquid: false
title: "Introducing Serverless Pre-Rendering (SPR) - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/serverless-pre-rendering"
date: "2019-05-03"
scraped_at: "2026-03-02T10:07:45.459614680+00:00"
language: "en-zh"
translated: true
description: "Introducing SPR, an industry-defining feature that allows you to get the best of both static and dynamic data rendering."
---
render_with_liquid: false
render_with_liquid: false

May 3, 2019

2019 年 5 月 3 日

静态网站非常**快**。当你将静态前端部署到 Vercel 时，我们会自动通过全球 [Smart CDN](https://vercel.com/smart-cdn) 网络的每个边缘节点为你提供服务。

但静态网站也……是**静态的**。静态网站生成器会在构建过程中一次性生成你网站的所有页面——全部页面、全部同时生成。你是否曾遇到过需要快速修复某一页上的一个拼写错误，却不得不等待数分钟甚至数小时，才能让修改上线？

今天，我们正式推出 **Serverless Pre-Rendering（无服务器预渲染）** —— 这是我们 Smart CDN 网络的一项开创性功能，让你兼得二者之长：既拥有**静态**内容的速度与可靠性，又具备**动态**数据渲染的灵活性。

## 工作原理

## 其工作原理

我们先从一个演示开始。你已构建了一个落地页（landing page），使用了 React、Next.js、CSS-in-JS（或你钟爱的任何现代前端技术栈），并将代码推送至 [GitHub](https://vercel.com/github) 或 [GitLab](https://vercel.com/gitlab)，从而实现自动部署。

![借助 Vercel，只需运行 `git push`，即可立即将 spr-landing.vercel.sh 上线。](images/introducing-serverless-pre-rendering-spr-vercel/img_001.jpg)借助 Vercel，你只需运行 \`git push\`，即可立即将 spr-landing.vercel.sh 上线。

假设我们想修改该页面的标题。此时，你有两种选择：

- 提交一个 Pull Request（PR），等待构建完成、合并后上线。这种方式非常适合**代码变更**，但对于文案（copy）调整而言，是否最优？毕竟，构建过程最快也要几分钟，慢则需数小时！我们完全可以做得更好。

- 使用 [Headless CMS（无头内容管理系统）](https://en.wikipedia.org/wiki/Headless_content_management_system)，借助其友好的界面编辑内容，并从前端发起查询获取数据。你可以选用 [Contentful](https://www.contentful.com/)、[Prismic](https://prismic.io/)、[Contentstack](https://www.contentstack.com/)、[Sanity](https://www.sanity.io/)、[Tipe](https://v1.tipe.io/)、[Hygraph](https://hygraph.com/)、[ButterCMS](https://buttercms.com/) 或 [DatoCMS](https://www.datocms.com/) —— 实际上，任何能返回动态数据的 API 均可接入。

We don’t want to wait, so for this demo we wanted to edit the data in real-time. For the task, we picked our favorite document editing tool, Notion, and queried its API from Next.js.

我们不想等待，因此在本次演示中，我们希望实现数据的实时编辑。为此，我们选用了最喜爱的文档编辑工具 Notion，并从 Next.js 调用其 API。

![](images/introducing-serverless-pre-rendering-spr-vercel/img_002.jpg)

![](images/introducing-serverless-pre-rendering-spr-vercel/img_002.jpg)

In this video, you can see that we make edits to the Notion page, and it makes updates to the site instantly.

在本视频中，您可以看到我们对 Notion 页面进行编辑，网站内容随即实时更新。

Towards the end of the video, we measure the performance of this dynamic page. The **response is instant, from our CDN edge**. Using Serverless Pre-rendering, you can provide an instant experience even with dynamic content.

视频末尾，我们对该动态页面的性能进行了测量。**响应来自我们的 CDN 边缘节点，且瞬时完成**。借助 Serverless Pre-rendering（无服务器预渲染），即使面对动态内容，您也能为用户提供瞬时加载的体验。

How does that work?

其工作原理是什么？

1. When an end-user accesses your website, **we always serve a static version**.

1. 当终端用户访问您的网站时，**我们始终提供一个静态版本**。

2. A Serverless Function **computes a new copy querying dynamic APIs in the background**.

2. 一个无服务器函数在后台**调用动态 API，生成一份最新版本的内容**。

3. No matter how much traffic you are serving, **only one background invocation is made at an interval you decide**.

3. 无论您的流量多高，**后台仅按您设定的时间间隔执行一次调用**。

What this means for you:

这对您意味着：

- No more hard decisions between static and dynamic. **SPR marries both paradigms**.

- 不再需要在静态与动态之间艰难取舍。**SPR 将二者完美融合**。

- If your backend is slow, **your responses are still always fast**.  
- 如果您的后端响应缓慢，**您的响应速度依然始终如一地快速**。

- Your backend functions and datasources can go down, and **you will likely tolerate their downtime**.  
- 您的后端函数和数据源可能宕机，但**您通常能够容忍其停机时间**。

- Traffic to your backend is minimized, which results in **massive cost reductions**.  
- 发往您后端的流量被大幅减少，从而带来**显著的成本降低**。

As we’ll see next, the best part is that this integrates easily into your existing codebase, and takes advantage of a [HTTP standard proposal](https://www.chromestatus.com/feature/5050913014153216).  
接下来我们将看到，最棒的一点在于：该方案可轻松集成到您现有的代码库中，并利用了一项 [HTTP 标准提案](https://www.chromestatus.com/feature/5050913014153216)。

### Cache-Control: `stale-while-revalidate`  
### Cache-Control：`stale-while-revalidate`

The demo above is a simple [Next.js](https://nextjs.org/) app deployed to [our platform](https://vercel.com/home) and [available on GitHub](https://github.com/vercel/spr-landing). All the above benefits and functionality are unlocked by **a single line of code**.  
上述演示是一个简单的 [Next.js](https://nextjs.org/) 应用，已部署至 [我们的平台](https://vercel.com/home)，并 [开源在 GitHub 上](https://github.com/vercel/spr-landing)。所有前述优势与功能，仅需 **一行代码** 即可启用。

```javascript
res.setHeader('Cache-Control', 's-maxage=1, stale-while-revalidate');
```

Composition of a header that includes `stale-while-revalidate`.  
包含 `stale-while-revalidate` 的响应头构成说明。

Let’s break it down.  
我们来逐项解析：

- `Cache-Control` — This header tells our edge proxy how to cache the result of the React page being rendered  
- `Cache-Control` — 该响应头用于告知我们的边缘代理（edge proxy）如何缓存当前正在渲染的 React 页面结果

- `s-maxage=1` — This flag tells us that [our Edge](https://vercel.com/docs/serverless-functions/edge-caching) (but not your end user) should cache it for one second  
- `s-maxage=1` — 此标志表明，**Vercel 的边缘节点**（而非您的终端用户）应将该响应缓存 1 秒。

- `stale-while-revalidate` — This indicates that we should serve a **stale version, while a revalidation happens asynchronously**  
- `stale-while-revalidate` — 此指令表示：在**异步执行重新验证的同时，可先向用户返回一个过期（stale）版本的响应**。

In short, you can begin adding this header to any of your Vercel deployments, using whatever technology you like (Next.js, Gatsby, Node.js, Go, Rust...), without any rewrites or lock-in.  
简言之，您可立即在任意 Vercel 部署中添加此响应头——无论您使用何种技术栈（Next.js、Gatsby、Node.js、Go、Rust 等），均无需重写代码，也无厂商锁定风险。

### Use-cases  
### 典型应用场景  

Serverless Pre-Rendering (SPR) is a suitable technique for anytime you want to serve fast pages, from anywhere in the world, that are produced by dynamic datasources and computation.  
无服务器预渲染（Serverless Pre-Rendering, SPR）是一种理想的技术方案，适用于需要在全球任意位置快速交付页面的场景——这些页面由动态数据源和实时计算生成。

Here are some popular use-cases:  
以下是一些典型的应用场景：

- **Marketing pages**. Pages explaining a new product or service  
- **营销落地页**：介绍新产品或新服务的页面。

- **E-commerce websites**. Containing lots of items, categories, user reviews, etc.  
- **电商平台**：包含大量商品、分类、用户评论等内容的网站。

- **Blogs and Newspapers**. Where multiple users edit stories in realtime, including breaking news  
- **博客与新闻网站**：支持多用户实时协同编辑文章，包括突发新闻的即时发布。

- **High-traffic APIs**. Where computation is debounced in order to minimize load  
- **高流量 API 接口**：通过防抖（debounce）机制对计算进行节流，以最大限度降低系统负载。

- **Public dashboards**. Where lots of dynamic content is consumed by many users

- **公共仪表板**。面向大量用户分发并消费大量动态内容的场景。

### Getting Started

### 入门指南

The example showcased above is [fully open-source](https://github.com/vercel/spr-landing) and available under the MIT License. [Deploy to Vercel](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fspr-landing&env=PAGE_ID) and update the `PAGE_ID` environment variable with your page ID – that's all it takes!

上述示例为[完全开源](https://github.com/vercel/spr-landing)，采用 MIT 许可证发布。[一键部署至 Vercel](https://vercel.com/new/git/external?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fspr-landing&env=PAGE_ID)，并将环境变量 `PAGE_ID` 更新为您自己的页面 ID——仅需这一步！

SPR 功能现已全面进入生产可用阶段，并已部署于我们的全网基础设施中。

您希望我们接下来重点支持哪款 API 或无头 CMS？欢迎通过[反馈渠道](https://vercel.com/feedback/spr)告诉我们！