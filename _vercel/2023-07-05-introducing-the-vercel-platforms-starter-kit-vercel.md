---
title: "Introducing the Vercel Platforms Starter Kit - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/platforms-starter-kit"
date: "2023-07-05"
scraped_at: "2026-03-02T09:51:49.729284876+00:00"
language: "en-zh"
translated: true
description: "A fullstack template for building multi-tenant applications with custom domains using Next.js App Router, Vercel Postgres, and the Vercel Domains API."
---
&#123;% raw %}

Jul 5, 2023

2023 年 7 月 5 日

一个全栈模板，用于使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API 构建支持自定义域名的多租户应用。

今天，我们非常高兴地推出全新 Vercel [Platforms Starter Kit（平台入门套件）](https://app.vercel.pub/) —— 这是一套**面向多租户应用开发的全栈 Next.js 模板，原生支持自定义域名**，基于 [App Router（应用路由）](https://nextjs.org/docs/app)、[Vercel Postgres](https://vercel.com/storage/postgres) 和 [Vercel Domains API（Vercel 域名 API）](https://vercel.com/docs/rest-api/endpoints#domains) 构建。

[**Platforms Starter Kit（平台入门套件）**  
一款 Next.js 模板，用于借助 App Router、Vercel Postgres 和 Vercel Domains API 快速构建支持自定义域名的多租户应用。  
查看模板](https://vercel.com/templates/next.js/platforms-starter-kit)

## 多租户应用：从数月缩短至数天

以下是一个示例代码片段，展示如何在 Next.js 中使用该套件：

App Router 地理位置功能｜Pages Router 地理位置功能  

app/api/geo/route.ts

```tsx
import { geolocation } from '@vercel/functions';
```

```typescript
export function GET(request: Request) {

4  const { city } = geolocation(request);

5  return new Response(`<h1>Your location is ${city}</h1>`, {

6    headers: { 'content-type': 'text/html' },

7  });

8}
```

```typescript
export function GET(request: Request) {

4  const { city } = geolocation(request);

5  return new Response(`<h1>您的所在地是 ${city}</h1>`, {

6    headers: { 'content-type': 'text/html' },

7  });

8}
```

Reading the city from the geo IP headers in a Vercel Edge Function.

在 Vercel Edge Function 中，从地理 IP 请求头中读取城市信息。

In the above example, we import the `geolocation` helper from `@vercel/edge`.

在上述示例中，我们从 `@vercel/edge` 导入 `geolocation` 辅助函数。

The Platforms Starter Kit comes with powerful features that lets you build multi-tenant apps in record time.

Platforms 启动套件（Platforms Starter Kit）内置强大功能，助您以极快速度构建多租户应用。

1. **Multi-tenancy:** Programmatically assign unlimited custom domains, subdomains, and SSL certificates to your users using the [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints#domains)

1. **多租户支持（Multi-tenancy）：** 借助 [Vercel Domains API](https://vercel.com/docs/rest-api/endpoints#domains)，以编程方式为您的用户分配无限数量的自定义域名、子域名及 SSL 证书。

2. **Performance**: Fast & beautiful blog posts cached via [Vercel's Edge Network](https://vercel.com/docs/concepts/edge-network/overview), with the ability to invalidate the cache on-demand (when users make changes) using [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) \+ Next.js' [`revalidateTag` API](https://nextjs.org/docs/app/api-reference/functions/revalidateTag)

2. **性能**：借助 [Vercel 边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview) 缓存快速且美观的博客文章，并可通过 [增量静态再生（Incremental Static Regeneration）](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) 结合 Next.js 的 [`revalidateTag` API](https://nextjs.org/docs/app/api-reference/functions/revalidateTag)，在用户修改内容时按需使缓存失效。

3. **AI Editor**: AI-powered Markdown editor for a Notion-style writing experience powered by [Novel](https://novel.sh/)

3. **AI 编辑器**：由 [Novel](https://novel.sh/) 驱动、支持类 Notion 写作体验的 AI 增强型 Markdown 编辑器。

4. **Image Uploads**: Drag & drop / copy & paste image uploads, backed by [Vercel Blob](https://vercel.com/storage/blob)

4. **图片上传**：支持拖放上传与复制粘贴上传图片，底层存储由 [Vercel Blob](https://vercel.com/storage/blob) 提供支持。

5. **Custom styles**: Custom fonts, 404 pages, favicons, sitemaps for each site via the [Next.js file-based Metadata API](https://nextjs.org/docs/app/api-reference/file-conventions/metadata)

5. **自定义样式**：通过 [Next.js 基于文件的元数据（Metadata）API](https://nextjs.org/docs/app/api-reference/file-conventions/metadata)，为每个站点配置自定义字体、404 页面、网站图标（favicon）及站点地图（sitemap）。

6. **Dynamic OG Cards**: Each blog post comes with a dynamic OG image powered by [@vercel/og](https://vercel.com/docs/concepts/functions/edge-functions/og-image-generation)

6. **动态 Open Graph 卡片**：每篇博客文章均配备由 [@vercel/og](https://vercel.com/docs/concepts/functions/edge-functions/og-image-generation) 生成的动态 Open Graph 图像。

7. **Dark Mode**: For a better user experience at night

7. **深色模式**：提升夜间浏览的用户体验。

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_001.jpg)![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_002.jpg)

[**How to build a multi-tenant app with custom domains using Next.js**\\
\\
Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.\\
\\
Read the guide](https://vercel.com/guides/nextjs-multi-tenant-application)

[**如何使用 Next.js 构建支持自定义域名的多租户应用**\\
\\
使用 Next.js App Router、Vercel Postgres 及 Vercel Domains API，构建具备多租户能力与自定义域名支持的全栈应用。\\
\\
阅读指南](https://vercel.com/guides/nextjs-multi-tenant-application)

## What is a multi-tenant application?

## 什么是多租户应用？

Multi-tenant applications serve multiple customers across different subdomains/custom domains with a single unified codebase.

多租户应用通过单一统一的代码库，为不同子域名或自定义域名下的多个客户（租户）提供服务。

Take our demo app as an example:

以我们的演示应用为例：

- Subdomain: [demo.vercel.pub](http://demo.vercel.pub/)

- 子域名：[demo.vercel.pub](http://demo.vercel.pub/)

- Custom domain: [platformize.co](http://platformize.co/) (maps to [demo.vercel.pub](http://demo.vercel.pub/))

- 自定义域名：[platformize.co](http://platformize.co/)（映射至 [demo.vercel.pub](http://demo.vercel.pub/)）

- Editing & publishing backend: [app.vercel.pub](http://app.vercel.pub/)

- 编辑与发布后台：[app.vercel.pub](http://app.vercel.pub/)


Another example is [Hashnode](https://vercel.com/customers/hashnode), a popular blogging platform. Each writer has their own unique **`.hashnode.dev`** subdomain for their blog:

另一个例子是广受欢迎的博客平台 [Hashnode](https://vercel.com/customers/hashnode)。每位作者都拥有自己专属的 **`.hashnode.dev`** 子域名，用于托管个人博客：

- [eda.hashnode.dev](https://eda.hashnode.dev/)

- [eda.hashnode.dev](https://eda.hashnode.dev/)

- [katycodesstuff.hashnode.dev](https://katycodesstuff.hashnode.dev/)

- [katycodesstuff.hashnode.dev](https://katycodesstuff.hashnode.dev/)

- [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)

- [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)


Users can also map custom domains to their **`.hashnode.dev`** subdomain:

用户还可将自己的自定义域名映射至其 **`.hashnode.dev`** 子域名：

- [akoskm.com](https://akoskm.com/) → [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)

- [akoskm.com](https://akoskm.com/) → [akoskm.hashnode.dev](https://akoskm.hashnode.dev/)

With the Platforms Starter Kit on Vercel Pro, you can offer [unlimited custom domains at no extra cost](https://vercel.com/changelog/unlimited-custom-domains-for-all-pro-teams) to your customers as a premium feature, without having to worry about custom nameservers or configuring SSL certificates.

借助 Vercel Pro 上的 Platforms Starter Kit，您可将“无限自定义域名（无需额外费用）”作为高级功能提供给客户，且完全无需操心自定义 DNS 服务器或 SSL 证书配置。

## Build for scale

## 面向规模化构建

A year ago, we launched the first version of this starter kit to make it easier for makers to start their own platform on Vercel.

一年前，我们推出了该 Starter Kit 的首个版本，旨在帮助开发者更轻松地在 Vercel 上启动属于自己的平台。

Since then, we've seen a variety of successful platforms grow to tens of thousands of custom domains and millions of pageviews on Vercel:

此后，我们已见证多个成功平台依托 Vercel 实现规模化发展——客户自定义域名数量达数万个，月页面浏览量突破百万级：

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_003.jpg)


Hashnode, a blogging platform for the developer community built with Next.js, uses Vercel to manage over 35,000 custom domains for their customers. After evaluating alternative solutions, Hashnode ultimately chose Vercel because of the ability to manage custom domains at scale and the smooth and intuitive developer experience. [Read the full customer story](https://vercel.com/customers/hashnode).

Hashnode 是一个面向开发者社区、基于 Next.js 构建的博客平台，其借助 Vercel 为其客户统一管理超过 35,000 个自定义域名。在全面评估多种替代方案后，Hashnode 最终选择 Vercel，正是看中其大规模管理自定义域名的能力，以及流畅直观的开发者体验。[阅读完整客户案例](https://vercel.com/customers/hashnode)。

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_004.png)


Super is the largest Notion-to-website builder that lets you create SEO-optimized sites using nothing but Notion. Using Next.js and Vercel allows Super to effectively serve 15,000 custom domains and 17 million monthly pageviews. “By far my favorite Vercel feature is the ability to connect as many domains as I need to a single project,” CEO & Founder Jason Werner explains in his [customer story](https://vercel.com/customers/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel).

Super 是目前规模最大的 Notion 网站生成器，用户仅需使用 Notion 即可创建搜索引擎优化（SEO）友好的网站。借助 Next.js 与 Vercel，Super 成功支撑起 15,000 个自定义域名及每月 1,700 万次页面浏览。Super 首席执行官兼创始人 Jason Werner 在其[客户案例](https://vercel.com/customers/super-serves-thousands-of-domains-on-one-project-with-next-js-and-vercel)中表示：“Vercel 最令我青睐的功能，莫过于能将任意数量的域名绑定至单个项目。”

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_005.png)


Incident.io is a Slack-powered incident management platform, driven by automation. With the Platforms Starter Kit, they were able to ship beautiful and fast status pages (like this one for [Linear](https://linearstatus.com/)) without having to worry about SSL certificate management. [Read about their experience](https://incident.io/blog/how-we-built-status-pages).

Incident.io 是一款以 Slack 为中枢、由自动化驱动的事件管理平台。借助 Platforms Starter Kit，Incident.io 能够快速上线美观且高性能的状态页（例如 [Linear 的状态页](https://linearstatus.com/)），全程无需手动处理 SSL 证书管理。[了解他们的实践历程](https://incident.io/blog/how-we-built-status-pages)。

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_006.png)

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_006.png)

[Beyond Menu](https://www.beyondmenu.com/)

[Beyond Menu](https://www.beyondmenu.com/)

Beyond Menu is a complete ordering solution for independent restaurant owners. By using the Vercel Platforms Starter Kit, they serve 6,000 custom domains for restaurant owners all over the world with a focus on speed and performance.

Beyond Menu 是一款面向独立餐厅业主的完整点餐解决方案。借助 Vercel Platforms Starter Kit，他们为全球各地的餐厅业主托管了 6,000 个自定义域名，且始终以速度与性能为核心目标。

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_007.svg)

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_007.svg)

Mintlify is a platform that provides beautiful documentation sites for [hundreds of API-first SaaS companies](https://mintlify.com/showcase). "Vercel Platforms is making our product the fastest and most performant docs solution on the market", says founder Han Wang.

Mintlify 是一个为[数百家以 API 为先的 SaaS 公司](https://mintlify.com/showcase)提供精美文档网站的平台。创始人 Han Wang 表示：“Vercel Platforms 正在让我们的产品成为市场上速度最快、性能最强的文档解决方案。”

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_008.png)

![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_008.png)

Dub is an open-source link management tool for modern marketing teams to create, share, and track short links. Thanks to the Platforms Starter Kit, they were able to grow to ~900 custom domains without having to manage SSL certificates or set up NGINX proxies. [Check out their code](https://github.com/steven-tey/dub) to learn more about their implementation.

Dub 是一款面向现代营销团队的开源链接管理工具，用于创建、分享和追踪短链接。得益于 Platforms Starter Kit，他们无需自行管理 SSL 证书或配置 NGINX 反向代理，便已扩展至约 900 个自定义域名。[查看其源代码](https://github.com/steven-tey/dub)，进一步了解其实现细节。

## Build the platform of your dreams

## 构建你梦想中的平台

It's been incredible to see the [amount](https://twitter.com/perryraskin/status/1618099492888391681) [of](https://twitter.com/flexdinesh/status/1620906810965360640) [love](https://twitter.com/SSardorf/status/1651602178715553792) the template has gotten since it's inception.

自该模板发布以来，我们欣喜地看到它收获了大量赞誉：[一条推文](https://twitter.com/perryraskin/status/1618099492888391681)、[另一条推文](https://twitter.com/flexdinesh/status/1620906810965360640)、[还有一条推文](https://twitter.com/SSardorf/status/1651602178715553792)。

> “Just stumbled upon the Vercel Platform Starter Kit. Game changer for anyone who wants to quickly create a multi-tenant app that enables user custom domains. Just stumbled upon the Vercel Platform Starter Kit. Game changer for anyone who wants to quickly create a multi-tenant app that enables user custom domains. ”
>
> ![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_009.jpg)
>
> **Perry Raskin,** CoverDash

> “刚刚偶然发现了 Vercel Platform Starter Kit——对于任何希望快速构建支持用户自定义域名的多租户应用的人来说，这都是一款颠覆性的工具。”  
>  
> ![](images/introducing-the-vercel-platforms-starter-kit-vercel/img_009.jpg)  
>  
> **Perry Raskin**，CoverDash

With the new version – now built with the App Router – we cannot wait to see what platforms you build on Vercel!

新版本现已基于 App Router 构建——我们迫不及待想看到您在 Vercel 上构建出怎样的平台！

[**How to build a multi-tenant app with custom domains using Next.js**  
**如何使用 Next.js 构建支持自定义域名的多租户应用**  

Create a full-stack application with multi-tenancy and custom domain support using Next.js App Router, Vercel Postgres, and the Vercel Domains API.  
使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API，构建一个支持多租户与自定义域名的全栈应用。  

Read the guide  
阅读指南](https://vercel.com/guides/nextjs-multi-tenant-application) [**Platforms Starter Kit**  
**Platforms 入门套件**  

Next.js template for building multi-tenant applications with custom domains using App Router, Vercel Postgres, and the Vercel Domains API.  
一款 Next.js 模板，用于借助 App Router、Vercel Postgres 和 Vercel Domains API 构建支持自定义域名的多租户应用。  

View Template  
查看模板](https://vercel.com/templates/next.js/platforms-starter-kit) [**Platforms Starter Kit GitHub Repo**  
**Platforms 入门套件 GitHub 仓库**  

A full-stack Next.js app with multi-tenancy and custom domain support. Built with Next.js App Router and the Vercel Domains API.  
一个支持多租户与自定义域名的全栈 Next.js 应用，基于 Next.js App Router 和 Vercel Domains API 构建。  

Star on GitHub  
在 GitHub 上点亮 Star](https://github.com/vercel/platforms)

Vercel Template  
Vercel 模板

Deploy this template  
部署此模板

### Next.js template for building multi-tenant applications with the App Router and Redis.  
### 一款基于 App Router 与 Redis 构建多租户应用的 Next.js 模板。

Platforms Starter Kit  
Platforms 入门套件

Twitter post  
Twitter 帖子

### Introducing the new Vercel Platforms Starter Kit. Build multi-tenant apps with custom domains using the Next.js App Router, Vercel Postgres, and the Vercel Domains API.  
### 全新 Vercel Platforms 入门套件正式发布！使用 Next.js App Router、Vercel Postgres 和 Vercel Domains API，快速构建支持自定义域名的多租户应用。

![Vercel's avatar](images/introducing-the-vercel-platforms-starter-kit-vercel/img_010.jpg)Vercel@vercel
&#123;% endraw %}
