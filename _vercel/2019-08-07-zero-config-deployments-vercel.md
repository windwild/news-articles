---
render_with_liquid: false
title: "Zero Config Deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/zero-config"
date: "2019-08-07"
scraped_at: "2026-03-02T10:07:34.059859789+00:00"
language: "en-zh"
translated: true
description: "Deploy frontends and serverless functions without any configuration."
---
render_with_liquid: false
render_with_liquid: false

Aug 7, 2019

2019年8月7日

几周前，我们推出了 Vercel —— 一个功能最强大、可扩展性最高的平台，专为 **静态网站** 和由 _任意语言_ 或 _任意框架_ 驱动的 **无服务器函数（serverless functions）** 而设计。

但此前，用户需手动编写 `vercel.json` 配置文件。今天，我们正式推出 **零配置（Zero Config）** —— 一种约定式、完全向后兼容的部署方式。

## Getting Started

## 入门指南

首先，使用你偏好的 **前端技术栈** 创建一个新项目。本示例中，我们将创建一个原生 [Next.js](https://nextjs.org/) 项目：

```bash
npm create next-app
```

然后，在项目目录内，无需任何额外配置，直接运行以下命令（需已安装 [Vercel CLI](https://vercel.com/download)，或已接入 [GitHub](https://vercel.com/github) / [GitLab](https://vercel.com/gitlab) 集成）：

```bash
vercel
```

就这样！**它适用于你能想到的任何框架或工具。**

无论你使用的是 [Gatsby](https://github.com/vercel/vercel/tree/master/examples/gatsby)、[Vue](https://github.com/vercel/vercel/tree/master/examples/vue)、[Ember](https://github.com/vercel/vercel/tree/master/examples/ember)、[Svelte](https://github.com/vercel/vercel/tree/master/examples/svelte)，还是其他任何包含 [构建脚本（build script）](https://docs.npmjs.com/misc/scripts) 的 `package.json` 项目，Vercel 均能开箱即用地提供完整的静态渲染（SSG）或混合渲染（Hybrid Rendering）能力。

## From Frontend to Backend

## 从前端到后端

Upon deployment, we optimize your frontend seamlessly and deploy it to our built-in [Smart CDN](https://vercel.com/smart-cdn). Fast to develop, build, and serve.

部署时，我们会无缝优化您的前端，并将其部署至我们内置的 [Smart CDN](https://vercel.com/smart-cdn)。开发、构建与交付均极为迅速。

Now, how about adding the power of **serverless functions** to our site?

那么，为我们的网站增添 **无服务器函数（serverless functions）** 的能力如何？

Let's use [Gatsby](https://www.gatsbyjs.org/) for the frontend, combined with [Go](https://golang.org/) for the backend. For this, we'll start by creating a new Gatsby project:

让我们使用 [Gatsby](https://www.gatsbyjs.org/) 构建前端，再结合 [Go](https://golang.org/) 开发后端。首先，我们创建一个全新的 Gatsby 项目：

```bash
gatsby new gatsby-site
```

```bash
gatsby new gatsby-site
```

This can already be deployed, zero config. To add functions, create an `api` directory:

该项目开箱即用，无需任何配置即可直接部署。如需添加函数功能，请创建一个 `api` 目录：

Then, with no additional configuration, run the following command (requires [Vercel CLI](https://vercel.com/download) or our integration for [GitHub](https://vercel.com/github)/ [GitLab](https://vercel.com/gitlab)):

随后，无需额外配置，直接运行以下命令即可（需安装 [Vercel CLI](https://vercel.com/download)，或已启用我们在 [GitHub](https://vercel.com/github) / [GitLab](https://vercel.com/gitlab) 上的集成）：

```bash
vercel
```

```bash
vercel
```

Your function will now be accessible at `/api/my-function`.

您的函数现在可通过 `/api/my-function` 访问。

All our [existing languages](https://vercel.com/docs/serverless-functions/supported-languages) are supported and mapped by file extension. You can even use `[brackets].js` to define dynamic routes. To learn more, check out [our docs](https://vercel.com/docs).

我们所有[现有支持的语言](https://vercel.com/docs/serverless-functions/supported-languages)均受支持，并依据文件扩展名自动识别。您甚至可以使用 `[brackets].js` 语法定义动态路由。欲了解更多信息，请查阅[我们的文档](https://vercel.com/docs)。

## Summary

## 摘要

Vercel 速度快、效率高、可扩展性强，现在使用起来更加简单便捷。

- 如果您正在使用 **ZEIT Now 1.0** 或第三方托管服务，请参阅我们的[迁移指南](https://vercel.com/guides/migrate-to-zeit-now/)。

- 如果您已在使用 Vercel，您的项目将继续照常运行。如需实现零配置部署，请查阅[此指南](https://vercel.com/docs/cli/deploying-from-cli)。

- 如果您使用的是 **Next.js 9** 或更高版本，我们的集成已原生支持[API 路由（API Routes）](https://nextjs.org/blog/next-9#api-routes)，因此无需学习任何新知识——只需直接部署，无需额外配置。

- 我们的[开发工具链](https://vercel.com/blog/now-dev) `vercel dev` 开箱即用，完全零配置。

- 我们针对 [GitHub](https://vercel.com/github) 和 [GitLab](https://vercel.com/gitlab) 的集成也不再需要 `vercel.json` 配置文件。我们还新增了一个简洁的流程，您可通过[网页控制台](https://vercel.com/new)直接导入项目，进一步完善体验。

_特别感谢_ [_Evil Rabbit_](https://twitter.com/evilrabbit_)、[_Paco Coursey_](https://twitter.com/pacocoursey)、[_Luc Leray_](https://twitter.com/lucleray)、[_Shu Ding_](https://twitter.com/shuding_)、[_Matthew Sweeney_](https://twitter.com/msweeneydev)、[_Timothy Lorimer_](https://twitter.com/timothyis_) _以及_ [_Christopher Skillicorn_](https://twitter.com/skllcrn) _为本次版本发布所做出的重要贡献。_