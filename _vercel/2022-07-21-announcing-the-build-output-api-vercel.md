---
title: "Announcing the Build Output API - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/build-output-api"
date: "2022-07-21"
scraped_at: "2026-03-02T10:01:28.603446401+00:00"
language: "en-zh"
translated: true
description: "The Build Output API enables any framework, including your own custom-built solution, to take advantage of Vercel’s infrastructure building blocks."
---

render_with_liquid: false
Jul 21, 2022

2022 年 7 月 21 日

将任意应用部署为一组功能强大的 Vercel 原语。

我们坚信，Web 是一个面向所有人的开放平台，并始终致力于让 Vercel 对每一位 Web 开发者都触手可及、随时可用——无论你选择以何种方式构建 Web 应用。

今天，我们正式推出 [Build Output API](https://vercel.com/docs/build-output-api/v3)（构建输出 API），这是一套基于文件系统的规范，允许**任何框架**为 Vercel 构建应用，并充分利用 Vercel 基础设施的各项能力，例如边缘函数（Edge Functions）、边缘中间件（Edge Middleware）、增量静态再生（ISR）、图片优化（Image Optimization）等。

![](images/announcing-the-build-output-api-vercel/img_001.jpg)![](images/announcing-the-build-output-api-vercel/img_002.jpg)

这一新规范还使我们得以在 Vercel CLI 中引入一系列强大新功能，包括：

- `vercel build`：在本地或你自己的 CI 环境中构建项目

- `vercel deploy --prebuilt`：直接将构建产物部署至 Vercel，绕过 Vercel 的默认构建系统


请将 Vercel CLI 更新至最新版本（`npm i -g vercel`）以体验上述功能，并查阅 [相关文档](https://vercel.com/docs/cli#commands/build)。

## 依托 Vercel CLI 赋能全新能力

## 借助 Vercel CLI 实现全新功能

We’ve added new commands to Vercel CLI to help developers run and debug builds locally, and deploy them to Vercel.

我们已在 Vercel CLI 中新增了若干命令，以帮助开发者在本地运行和调试构建过程，并将构建结果部署至 Vercel。

### Debug and inspect builds locally

### 在本地调试与检查构建结果

When you build for the Web with frontend frameworks, infrastructure platforms like Vercel need to transform the framework output into a format that the platform can understand.

当你使用前端框架为 Web 构建应用时，Vercel 等基础设施平台需要将框架的输出转换为平台可识别的格式。

With `vercel build`, we’ve integrated massive portions of that build system into our open-source CLI, allowing you to build your entire project locally, replicating the results of the Vercel build system.

借助 `vercel build` 命令，我们将该构建系统的大量核心逻辑集成到了开源的 Vercel CLI 中，使你能够在本地完整构建整个项目，并精准复现 Vercel 构建系统的行为与结果。

When you run `vercel build`, Vercel will automatically detect your frontend framework and generate a `.vercel/output` folder that conforms to the Build Output API spec, containing all the build artifacts needed to deploy your app.

运行 `vercel build` 时，Vercel 将自动识别你所使用的前端框架，并生成一个符合 Build Output API 规范的 `.vercel/output` 目录，其中包含部署应用所需的全部构建产物。

This allows you to debug and inspect builds locally, providing faster iteration loops and increased observability. You can also use the `--debug` flag to show additional output data during the build.

这使你能在本地调试与检查构建过程，从而获得更短的迭代周期和更强的可观测性。你还可以使用 `--debug` 标志，在构建过程中输出额外的调试信息。

### Decouple build from deploy

### 解耦构建与部署

Previously, every Vercel deployment also performed a build. While this is convenient for many use cases, it didn't work well if your company cannot share source code with Vercel or your CI already performed a build.

过去，每次 Vercel 部署都会同时触发一次构建。尽管这对许多场景十分便捷，但若你的公司无法向 Vercel 共享源代码，或你的 CI 系统已预先完成构建，则该模式便不再适用。

With `vercel deploy --prebuilt`, the deployment step has been decoupled from the build step. When you’re ready to deploy to Vercel, you can send your prebuilt output from your local machine or CI system without sharing any of your source code with Vercel.

借助 `vercel deploy --prebuilt`，部署步骤已与构建步骤完全解耦。当你准备将应用部署至 Vercel 时，可直接从本地机器或 CI 系统上传预构建产物，全程无需向 Vercel 透露任何源代码。

### Build native functionality into your own framework

### 将原生功能集成至你自己的框架

Frameworks like Next.js have been able to utilize Vercel platform features like ISR and Edge rendering through simple configuration options within the framework code.

像 Next.js 这样的框架，已能通过框架代码内简单的配置选项，便捷地利用 Vercel 平台的 ISR（增量静态再生）和边缘渲染（Edge rendering）等功能。

By opening these capabilities to _all_ frameworks through the Build Output API, we’re giving every framework author the ability to integrate these infrastructure primitives with just as much ease including:

通过 Build Output API 向 _所有_ 框架开放这些能力，我们赋予每一位框架作者以同等便捷的方式集成这些基础设施原语的能力，包括：

- **Edge Functions**  
- **边缘函数**

- **Serverless Functions**  
- **无服务器函数**

- **Server-side Rendering (SSR)**  
- **服务端渲染（SSR）**

- **Static Generation**  
- **静态生成**

- **Image Optimization**  
- **图片优化**

- **...and more**  
- **……以及更多功能**

All of these features are supported simply by conforming to the Build Output API specification in the `.vercel/output` folder. And when you’re ready to deploy, you can use `vercel deploy --prebuilt` to skip the build step and upload the `.vercel/output` folder directly if needed.

只需在 `.vercel/output` 文件夹中遵循 Build Output API 规范，即可轻松支持上述全部功能。当您准备部署时，还可使用 `vercel deploy --prebuilt` 命令跳过构建步骤，直接上传 `.vercel/output` 文件夹（如需）。

We believe this is a critical step for empowering any developer to create when inspiration strikes and not be limited by their infrastructure.

我们认为，这是赋能每一位开发者的关键一步——让他们能在灵感迸发之时即刻创作，而不受基础设施的束缚。

## Supporting all frontend frameworks

## 支持所有前端框架

We partnered with framework authors to help them adopt the Build Output API for their projects. This has led to some amazing new functionality:

我们与各前端框架的作者合作，协助他们在各自项目中采用 Build Output API。此举催生了一系列令人振奋的新功能：

- SvelteKit can now run at the edge with Vercel Edge Functions

- SvelteKit 现在可通过 Vercel Edge Functions 在边缘运行

- Astro can now run at the edge with Vercel Edge Functions

- Astro 现在可通过 Vercel Edge Functions 在边缘运行

- Nuxt is working on ISR support

- Nuxt 正在开发对增量静态再生（ISR）的支持

We're incredibly excited to support these open-source creators. To continue investing in frontend frameworks, Vercel now sponsors Svelte, Nuxt, Astro, SolidJS, and more.

我们非常激动能支持这些开源创作者。为持续投入前端框架生态建设，Vercel 现已赞助 Svelte、Nuxt、Astro、SolidJS 等多个开源项目。

Let’s hear from some of the framework authors we worked with to adopt the Build Output API:

让我们听听部分与我们合作、共同采用 Build Output API 的框架作者的心声：

![](images/announcing-the-build-output-api-vercel/img_003.jpg)


Vercel is one of our favorites platforms to deploy applications built with Nuxt. Adopting the Build Output API builds upon features our customers already love, like server-rendering, and prepares us for the future as we look to add support for ISR as well as SSR through Edge Functions.

Vercel 是我们部署 Nuxt 应用最青睐的平台之一。采用 Build Output API，不仅延续了用户早已喜爱的功能（如服务端渲染），更为我们面向未来的发展奠定了基础——例如，我们将通过 Edge Functions 进一步支持增量静态再生（ISR）以及边缘服务端渲染（SSR）。

![](images/announcing-the-build-output-api-vercel/img_004.png)

SvelteKit's mantra is _it just works_, and that applies to deployment as well as development. Fiddling with configuration is no one's idea of a good time, even if that's what web developers have learned to expect. Together with the community, we provide zero-config adapters (or as close as possible) for many different platforms and the Build Output API and `vc deploy --prebuilt` have made `adapter-vercel` ridiculously easy to develop. The newest version lets you use [Vercel Edge Functions](https://sveltekit-on-the-edge.vercel.app/) for server rendering. It's fast!

SvelteKit 的核心理念是“开箱即用”（_it just works_），这一理念不仅适用于开发阶段，也同样适用于部署环节。反复调整配置绝非令人愉悦的体验——即便这已是 Web 开发者习以为常的日常。我们与社区携手，为众多不同平台提供了零配置适配器（尽可能接近真正的零配置）；而借助 Build Output API 以及 `vc deploy --prebuilt` 命令，`adapter-vercel` 的开发变得异常轻松。最新版本更支持使用 [Vercel Edge Functions](https://sveltekit-on-the-edge.vercel.app/) 进行服务端渲染，性能卓越！

![](images/announcing-the-build-output-api-vercel/img_005.jpg)


Vercel's new Build Output API makes it ridiculously easy to deploy an Astro website to Vercel. Just add the zero-configuration Vercel adapter to your Astro project (using the `@astrojs/vercel` package on npm) and then let Astro handle the rest. The new API also lets you unlock new superpowers for your Astro project, like running the entire website on the edge with Vercel's Edge Functions. This is exciting stuff!

Vercel 全新推出的 Build Output API 极大简化了将 Astro 网站部署至 Vercel 的流程。只需在你的 Astro 项目中添加零配置的 Vercel 适配器（通过 npm 安装 `@astrojs/vercel` 包），其余工作尽可交由 Astro 自动完成。该新 API 还为你解锁了 Astro 项目的全新能力，例如借助 Vercel Edge Functions 将整个网站运行于边缘网络（Edge）。这无疑令人振奋！

![](images/announcing-the-build-output-api-vercel/img_006.jpg)


I've been very impressed with Vercel's Build Output API. With minimal config and leveraging the file system, it's effortless to generate the infrastructure for a wide variety of projects. As someone building a framework where there's a constant desire to add new features, it takes little more than a quick read of the docs and pointing the output to the right place. From Serverless Functions, Edge Functions and Middleware, prerendering, and routing—the Build Output API has all my needs covered.

Next.js also supports the Build Output API. The Next.js team at Vercel was able to help validate the API design before expanding to the larger framework ecosystem.

我对 Vercel 的 Build Output API 印象极为深刻。仅需极少配置，并充分利用文件系统，即可轻松为各类项目生成所需基础设施。作为一名框架开发者，我始终渴望持续引入新功能；而借助该 API，我只需快速浏览文档，再将输出路径指向正确位置，即可满足全部需求——无论是无服务器函数（Serverless Functions）、边缘函数（Edge Functions）、中间件（Middleware）、预渲染（prerendering），还是路由（routing），Build Output API 均已全面覆盖。

Next.js 同样支持 Build Output API。Vercel 团队中的 Next.js 工程师在将该 API 推广至更广泛的框架生态之前，已率先参与并协助验证了其设计合理性。

## Try the Build Output API

## 尝试使用 Build Output API

The Build Output API enables any framework to take advantage of Vercel's infrastructure building blocks. The following frameworks support the Build Output API today with zero configuration:

Build Output API 使任意框架均可便捷利用 Vercel 提供的基础设施构建模块。目前以下框架均已原生支持 Build Output API，且无需任何额外配置：

- [Next.js](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fnextjs&template=nextjs&id=67753070&b=main&from=templates)

- [SvelteKit](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fsveltekit&template=sveltekit&id=67753070&b=main&from=templates)

- [Nuxt](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fnuxtjs&template=nuxtjs&id=67753070&b=main&from=templates)

- [Nuxt](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fnuxtjs&template=nuxtjs&id=67753070&b=main&from=templates)

- [Astro](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fastro&template=astro&id=67753070&b=main&from=templates)

- [Astro](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fastro&template=astro&id=67753070&b=main&from=templates)

- [Remix](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fremix&template=remix&id=67753070&b=main&from=templates)

- [Remix](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fremix&template=remix&id=67753070&b=main&from=templates)

- [Redwood](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fredwoodjs&template=redwoodjs&id=67753070&b=main&from=templates)

- [Redwood](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fredwoodjs&template=redwoodjs&id=67753070&b=main&from=templates)

- [SolidJS](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fsolidstart&template=solidstart&id=67753070&b=main&from=templates)

- [SolidJS](https://vercel.com/new/clone?s=https%3A%2F%2Fgithub.com%2Fvercel%2Fvercel%2Ftree%2Fmain%2Fexamples%2Fsolidstart&template=solidstart&id=67753070&b=main&from=templates)

If you want to create your own framework, check out the [Build Output API documentation](https://vercel.com/docs/build-output-api/v3) or learn more about `vercel build` and `vercel deploy --prebuilt`.

如果您希望创建自己的框架，请查阅 [Build Output API 文档](https://vercel.com/docs/build-output-api/v3)，或进一步了解 `vercel build` 和 `vercel deploy --prebuilt`。