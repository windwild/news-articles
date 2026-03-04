---
title: "MongoDB and Vercel: from idea to global fullstack app in seconds - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds"
date: "2022-06-13"
scraped_at: "2026-03-02T10:01:41.990056916+00:00"
language: "en-zh"
translated: true
description: "At this year's MongoDB World, we announced the MongoDB and Vercel integration—and shared our vision for enabling developers to create at the moment of inspiration. Let’s explore how MongoDB and Ve..."
---
{% raw %}

Jun 13, 2022

2022年6月13日

Last week, I had the pleasure of joining Sahir Azam, MongoDB’s Chief Product Officer, on stage at MongoDB World in New York City. We announced [the Vercel and MongoDB integration](https://vercel.com/integrations/mongodbatlas)—and shared our vision for enabling developers to create at the moment of inspiration.

上周，我很荣幸与 MongoDB 首席产品官 Sahir Azam 一同登台亮相于纽约市举办的 MongoDB World 大会。我们正式宣布了 [Vercel 与 MongoDB 的集成](https://vercel.com/integrations/mongodbatlas)，并分享了我们助力开发者“在灵感迸发的瞬间即刻创造”的愿景。

Watch Guillermo Rauch in the MongoDB World Keynote.

请观看 Guillermo Rauch 在 MongoDB World 主题演讲中的精彩分享。

[Check out the demo](https://mongodb.vercel.app/) or [deploy the MongoDB + Vercel integration](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fmongodb-starter&project-name=mongodb-vercel&repository-name=mongodb-vercel&demo-title=MongoDB+Developer+Directory&demo-description=Log+in+with+GitHub+to+create+a+directory+of+contacts.&demo-url=https%3A%2F%2Fmongodb.vercel.app%2F&demo-image=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fv1654311846%2Fmongodb-demo-app_i12ysf.png&integration-ids=oac_jnzmjqM10gllKmSrG0SGrHOH)

[查看演示应用](https://mongodb.vercel.app/)，或 [一键部署 MongoDB + Vercel 集成项目](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel%2Fmongodb-starter&project-name=mongodb-vercel&repository-name=mongodb-vercel&demo-title=MongoDB+Developer+Directory&demo-description=Log+in+with+GitHub+to+create+a+directory+of+contacts.&demo-url=https%3A%2F%2Fmongodb.vercel.app%2F&demo-image=https%3A%2F%2Fassets.vercel.com%2Fimage%2Fupload%2Fv1654311846%2Fmongodb-demo-app_i12ysf.png&integration-ids=oac_jnzmjqM10gllKmSrG0SGrHOH)

## **Enabling developers to create at the moment of inspiration**

## **赋能开发者：在灵感迸发的瞬间即刻创造**

MongoDB’s bet on the serverless movement is a testament to where software development is headed. Vercel provides the serverless frontend infrastructure for building on the Web. **Together, we deliver on the promise of fullstack serverless development.** With Vercel’s core values—easy, scalable, and fast—it’s the perfect example of what the future of frontend development can be.

MongoDB 押注无服务器（serverless）技术浪潮，正印证着软件开发演进的方向。Vercel 则为 Web 应用构建提供了无服务器化的前端基础设施。**双方携手，共同兑现全栈无服务器开发的承诺。** 凭借 Vercel 的三大核心价值——简单易用、高度可扩展、极致快速——它正是未来前端开发理想形态的完美范例。

### **1\. Easy**

### **1. 简单易用**

Making things easy and creating a great developer experience has been the calling of my career. What I began with creating and open-sourcing Mongoose, the leading client library for MongoDB in the JavaScript ecosystem, resulted in creating the best developer experience for the frontend with [Next.js and Vercel.](https://vercel.com/solutions/nextjs) Today, Next.js is the most popular framework in the React ecosystem.

让一切变得简单，并打造卓越的开发者体验，是我职业生涯始终坚守的使命。我最初从创建并开源 Mongoose（JavaScript 生态中面向 MongoDB 的领先客户端库）起步，最终催生了以 [Next.js 和 Vercel](https://vercel.com/solutions/nextjs) 为代表的、业界领先的前端开发者体验。如今，Next.js 已成为 React 生态中最受欢迎的框架。

![Next.js is the frontend platform of choice—as the number 1 React framework with 2.5+ milion npm downloads per month, 100+ million downloads in the last 12 months, and 175+ million total downloads. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_001.jpg)![Next.js is the frontend platform of choice—as the number 1 React framework with 2.5+ milion npm downloads per month, 100+ million downloads in the last 12 months, and 175+ million total downloads. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_002.jpg)![Next.js is the frontend platform of choice—as the number 1 React framework with 2.5+ milion npm downloads per month, 100+ million downloads in the last 12 months, and 175+ million total downloads. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_003.jpg)![Next.js is the frontend platform of choice—as the number 1 React framework with 2.5+ milion npm downloads per month, 100+ million downloads in the last 12 months, and 175+ million total downloads. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_004.jpg)Next.js is the frontend platform of choice—as the number 1 React framework with 2.5+ milion npm downloads per month, 100+ million downloads in the last 12 months, and 175+ million total downloads.

![Next.js 是首选的前端平台——作为排名第一的 React 框架，每月 npm 下载量超 250 万次，过去 12 个月下载量超 1 亿次，总下载量超 1.75 亿次。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_001.jpg)![Next.js 是首选的前端平台——作为排名第一的 React 框架，每月 npm 下载量超 250 万次，过去 12 个月下载量超 1 亿次，总下载量超 1.75 亿次。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_002.jpg)![Next.js 是首选的前端平台——作为排名第一的 React 框架，每月 npm 下载量超 250 万次，过去 12 个月下载量超 1 亿次，总下载量超 1.75 亿次。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_003.jpg)![Next.js 是首选的前端平台——作为排名第一的 React 框架，每月 npm 下载量超 250 万次，过去 12 个月下载量超 1 亿次，总下载量超 1.75 亿次。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_004.jpg)Next.js 是首选的前端平台——作为排名第一的 React 框架，每月 npm 下载量超 250 万次，过去 12 个月下载量超 1 亿次，总下载量超 1.75 亿次。

Next.js turbocharges your applications with server rendering, automatic production optimizations, and helps developers run the entire serverless frontend stack on their local machine. With over 2.5 million downloads each week, it’s become the framework of choice for teams and projects of all sizes, from GitHub to Dior to Tiktok and Twitch. It’s also just one example of the open-source ecosystem that Vercel contributes to and invests in. Whether it’s Svelte or Nuxt, there’s no shortage of modern options to build with today.

Next.js 通过服务端渲染（SSR）、自动化的生产环境优化等功能，显著提升应用性能；同时支持开发者在本地机器上完整运行整套无服务器前端技术栈。目前，Next.js 每周下载量超过 250 万次，已成为各类规模团队与项目的首选框架——从 GitHub、Dior，到 TikTok 和 Twitch，均广泛采用。它也是 Vercel 积极贡献并持续投入的开源生态体系中的一个典型代表。无论是 Svelte 还是 Nuxt，当今开发者都拥有丰富而现代的技术选型，构建体验前所未有地自由与高效。

![Vercel provides one unified process, instead of developers needing to balance CDNs, clusters, functions, caching infrastructure, and more. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_005.jpg)![Vercel provides one unified process, instead of developers needing to balance CDNs, clusters, functions, caching infrastructure, and more. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_006.jpg)![Vercel provides one unified process, instead of developers needing to balance CDNs, clusters, functions, caching infrastructure, and more. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_007.jpg)![Vercel provides one unified process, instead of developers needing to balance CDNs, clusters, functions, caching infrastructure, and more. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_008.jpg)  
![Vercel 提供统一的部署流程，开发者无需再分别管理 CDN、集群、函数、缓存基础设施等。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_005.jpg)![Vercel 提供统一的部署流程，开发者无需再分别管理 CDN、集群、函数、缓存基础设施等。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_006.jpg)![Vercel 提供统一的部署流程，开发者无需再分别管理 CDN、集群、函数、缓存基础设施等。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_007.jpg)![Vercel 提供统一的部署流程，开发者无需再分别管理 CDN、集群、函数、缓存基础设施等。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_008.jpg)

Vercel provides one unified process, instead of developers needing to balance CDNs, clusters, functions, caching infrastructure, and more.

Vercel 提供统一的部署流程，开发者无需再分别管理 CDN、集群、函数、缓存基础设施等。

However, even after a developer chooses the right framework for their project, they might still struggle to ship high-quality software. Doing this today involves juggling multiple different vendors: CDNs, clusters, functions, caching infrastructure, and more. Vercel solves this by allowing developers to go from `git push` to global app in one unified process.

然而，即便开发者已为项目选定了合适的框架，仍可能难以高效交付高质量软件。当前实现这一目标往往需协调多个不同供应商的服务：CDN、集群、函数、缓存基础设施等。Vercel 通过提供“一次 `git push`，即可全球上线应用”的统一流程，解决了这一难题。

In practice, this means Vercel builds and runs your frontend code natively in the cloud.

实际应用中，这意味着 Vercel 在云端原生构建并运行您的前端代码。

### **2\. Scalable**

### **2．可扩展**

Serverless promises that you can scale up and down to zero as your traffic dictates, with no effort on your side. Vercel delivers this in several ways.

无服务器（Serverless）架构承诺：您可根据流量变化自动弹性伸缩——包括缩容至零实例——全程无需人工干预。Vercel 以多种方式兑现了这一承诺。

![The Vercel stack: database, serverless compute, and edge cache. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_009.jpg)![The Vercel stack: database, serverless compute, and edge cache. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_010.jpg)![The Vercel stack: database, serverless compute, and edge cache. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_011.jpg)![The Vercel stack: database, serverless compute, and edge cache. ](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_012.jpg)  
![Vercel 技术栈：数据库、无服务器计算与边缘缓存。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_009.jpg)![Vercel 技术栈：数据库、无服务器计算与边缘缓存。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_010.jpg)![Vercel 技术栈：数据库、无服务器计算与边缘缓存。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_011.jpg)![Vercel 技术栈：数据库、无服务器计算与边缘缓存。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_012.jpg)

The Vercel stack: database, serverless compute, and edge cache.

Vercel 技术栈：数据库、无服务器计算与边缘缓存。

- **Database**: Our stack begins with the data platform—in this case, MongoDB.

- **数据库**：我们的技术栈始于数据平台——此处即 MongoDB。

- **Vercel Serverless Compute:** Then when you deploy using frameworks like Next.js on Vercel, we automatically [create Serverless Functions](https://vercel.com/features/edge-functions) that fetch from that data API. We use these functions to server render your pages.

- **Vercel 无服务器计算**：当您在 Vercel 上使用 Next.js 等框架部署应用时，系统会自动[创建无服务器函数（Serverless Functions）](https://vercel.com/features/edge-functions)，用于调用该数据 API；这些函数同时承担页面服务端渲染（SSR）任务。

- **Vercel Edge Cache:** But serverless or not, scaling isn’t solved by throwing more compute at the problem. As visitors come in, Vercel intelligently renders and later reuses your pages, keeping the content in sync with your database. The best part? This final layer is globally distributed at the edge.

- **Vercel 边缘缓存**：但无论是否采用无服务器架构，“堆砌更多计算资源”都不是解决扩展性问题的根本之道。当用户访问时，Vercel 会智能地渲染页面，并在后续请求中复用已渲染内容，同时确保缓存内容与数据库保持同步。最出色的一点在于？这一最终层在全球范围内的边缘节点上分布式部署。

### **3\. Fast by default**

### **3．默认极速**

While making it easy to deploy and scale are part of the experience, we also care deeply about performance. Not just for our own users, but the customers and communities they're building for. When you deploy on Vercel, we ensure your application is fast by default. The result: a global application that’s fast everywhere, with the built-in observability to keep it so.

在让部署与扩展变得简单易行的同时，我们也高度重视性能表现——不仅关乎我们自身的用户，更关乎他们所服务的客户与社区。当您在 Vercel 上部署应用时，我们默认确保其具备卓越的速度表现。最终成果是：一个真正全球可达、处处迅捷的应用，并内置可观测性能力，持续保障其高性能。

![An example of the Vercel Real Experience Score dashboard.](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_013.jpg)![An example of the Vercel Real Experience Score dashboard.](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_014.jpg)![An example of the Vercel Real Experience Score dashboard.](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_015.jpg)![An example of the Vercel Real Experience Score dashboard.](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_016.jpg)An example of the Vercel Real Experience Score dashboard.

![Vercel 真实体验评分（Real Experience Score）仪表盘示例。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_013.jpg)![Vercel 真实体验评分（Real Experience Score）仪表盘示例。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_014.jpg)![Vercel 真实体验评分（Real Experience Score）仪表盘示例。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_015.jpg)![Vercel 真实体验评分（Real Experience Score）仪表盘示例。](images/mongodb-and-vercel-from-idea-to-global-fullstack-app-in-seconds-vercel/img_016.jpg)Vercel 真实体验评分（Real Experience Score）仪表盘示例。

In addition to optimizing your web assets, you can respond to degradations immediately by tracking real-time user data. Vercel enables this by calculating a [Real Experience Score](https://vercel.com/analytics) based on data points collected from the devices of your actual users. Your Real Experience Score is the combined score of your Core Web Vitals, a standardized set of metrics that Google deems essential for great user experience.

除了优化您的网页资源外，您还可通过追踪实时用户数据，即时响应性能下降问题。Vercel 通过采集真实用户设备上的各项数据点，计算出一项[真实体验评分（Real Experience Score）](https://vercel.com/analytics)，助您实现上述目标。该评分综合了您的“核心网页指标（Core Web Vitals）”得分——这是一套由 Google 定义的标准化性能指标，被公认为衡量卓越用户体验的关键标准。

## **Get started with MongoDB and Vercel**

## **开始使用 MongoDB 与 Vercel**

Together, MongoDB and Vercel with Next.js give developers the power of fullstack serverless technology, allowing you to go from idea to global application in seconds. Anyone can deploy a Vercel project and create and connect to an Atlas cluster, without ever needing to open the MongoDB console. It’s all part of one seamless workflow, optimized for your application. Here’s how to get started.

MongoDB 与 Vercel（配合 Next.js）协同赋能开发者，提供全栈无服务器（fullstack serverless）技术能力，让您仅需数秒即可将创意转化为面向全球的应用。任何人都可轻松部署一个 Vercel 项目，并创建及连接至 Atlas 集群，全程无需打开 MongoDB 控制台。这一切都集成于一套无缝衔接的工作流中，并针对您的应用进行了深度优化。以下是入门步骤：

- [Try the MongoDB + Vercel integration](https://vercel.com/integrations/mongodbatlas)

- [Check out the integration demo](https://mongodb.vercel.app/)

- [Deploy the MongoDB Starter Kit](https://github.com/vercel/mongodb-starter)

- [尝试 MongoDB + Vercel 集成](https://vercel.com/integrations/mongodbatlas)

- [查看集成演示应用](https://mongodb.vercel.app/)

- [部署 MongoDB 入门套件（Starter Kit）](https://github.com/vercel/mongodb-starter)
{% endraw %}
