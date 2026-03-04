---
title: "Deploy Hono backends with zero configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-hono-backends-with-zero-configuration"
date: "2025-08-01"
scraped_at: "2026-03-02T09:30:46.285011718+00:00"
language: "en-zh"
translated: true
description: "Vercel now detects and deploys Hono, a fast, lightweight web application framework built on web standards, with zero configuration."
---
{% raw %}

Aug 1, 2025

2025年8月1日

![](images/deploy-hono-backends-with-zero-configuration-vercel/img_001.jpg)![](images/deploy-hono-backends-with-zero-configuration-vercel/img_002.jpg)

Vercel now natively supports [Hono](https://hono.dev/), a fast, lightweight backend framework built on web standards, with zero-configuration.

Vercel 现已原生支持 [Hono](https://hono.dev/) —— 一个基于 Web 标准构建的快速、轻量级后端框架，开箱即用，无需任何配置。

index.ts

index.ts

```javascript
import { Hono } from 'hono'



const app = new Hono()



app.get('/', (c) => {

6  return c.text("Hello Hono!"))
```

7})

7}

export default app
```

export default app
```

A "Hello world" Hono backend on Vercel

在 Vercel 上运行的 “Hello world” Hono 后端

With the code above, use [Vercel CLI](https://vercel.com/docs/cli) to develop and deploy your Hono application:

使用上述代码，通过 [Vercel CLI](https://vercel.com/docs/cli) 在本地开发并部署你的 Hono 应用：

Terminal

终端

```bash
1# Develop the application locally

1# 在本地开发应用

vc dev



4# Create a deployment

4# 创建一次部署

vc deploy

vc deploy

```

Using Vercel CLI to develop and deploy a Hono appliation

使用 Vercel CLI 开发和部署 Hono 应用程序

With this improved integration, Vercel's framework-defined infrastructure now recognizes and deeply understands Hono applications, ensuring they benefit from optimizations made from builds, deployments, and application delivery.

借助这一增强的集成，Vercel 基于框架定义的基础设施现已能够识别并深度理解 Hono 应用程序，从而确保其在构建、部署及应用交付等环节充分受益于各项优化。

Now, new Hono applications deployed to Vercel benefit from [Fluid compute](https://vercel.com/docs/fluid-compute), with Active CPU pricing, automatic cold start optimizations, background processing, and much more.

如今，新部署至 Vercel 的 Hono 应用可享受 [Fluid Compute（弹性计算）](https://vercel.com/docs/fluid-compute)，包括按活跃 CPU 计费、自动冷启动优化、后台处理等众多特性。

[Deploy Hono on Vercel](https://vercel.com/new/clone?demo-description=Deploying%20an%20API%20on%20Vercel%20with%20Hono.&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2FCYbcj30ZJhtGhg8JnR2Jm%2Fc2d3920a1878f356401b50593c1bc647%2FGeist_OG_Light.avif&demo-title=Hono%20on%20Vercel&demo-url=https%3A%2F%2Fhono.vercel.dev&from=templates&project-name=Hono%20on%20Vercel&repository-name=hono-on-vercel&repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fexamples%2Ftree%2Fmain%2Fframework-boilerplates%2Fhono&skippable-integrations=1) or [visit Hono's Vercel documentation](https://vercel.com/docs/frameworks/backend/hono).

[在 Vercel 上部署 Hono](https://vercel.com/new/clone?demo-description=Deploying%20an%20API%20on%20Vercel%20with%20Hono.&demo-image=%2F%2Fimages.ctfassets.net%2Fe5382hct74si%2FCYbcj30ZJhtGhg8JnR2Jm%2Fc2d3920a1878f356401b50593c1bc647%2FGeist_OG_Light.avif&demo-title=Hono%20on%20Vercel&demo-url=https%3A%2F%2Fhono.vercel.dev&from=templates&project-name=Hono%20on%20Vercel&repository-name=hono-on-vercel&repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fexamples%2Ftree%2Fmain%2Fframework-boilerplates%2Fhono&skippable-integrations=1)，或[查阅 Hono 的 Vercel 官方文档](https://vercel.com/docs/frameworks/backend/hono)。
{% endraw %}
