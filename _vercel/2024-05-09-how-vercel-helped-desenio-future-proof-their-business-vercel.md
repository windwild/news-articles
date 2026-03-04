---
render_with_liquid: false
title: "How Vercel helped Desenio future-proof their business - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-helped-desenio-future-proof-their-business"
date: "2024-05-09"
scraped_at: "2026-03-02T09:45:02.164140491+00:00"
language: "en-zh"
translated: true
description: "Vercel helped Desenio future-proof their business"
---
render_with_liquid: false
render_with_liquid: false

May 9, 2024

2024年5月9日

#### 37%

跳出率降低37%

#### 34%

网站转化率提升34%

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

The merger of two of the world's largest affordable art providers, Desenio and The Poster Store, gave their developers the chance to modernize their application architecture, improve their entire process, and dismantle the monolithic approach that made for long deployment times and slow iteration. Thanks to Vercel, they went from duplicate pipelines to a unified workflow— **resulting in faster builds, a 37% lower bounce rate, 48% longer sessions, and a 34% improvement in site conversions.**

全球两大平价艺术作品提供商——Desenio 与 The Poster Store 的合并，为其开发团队提供了现代化应用架构、优化整体流程、并摒弃导致部署耗时长、迭代缓慢的单体式架构的契机。得益于 Vercel，他们成功将重复的构建流水线整合为统一的工作流——**从而实现了更快的构建速度、跳出率降低37%、用户会话时长延长48%，以及网站转化率提升34%。**

> “With Vercel, we know what we’re pushing into production is close to perfect. That’s incredibly important because as an ecommerce platform, our website is everything.”
>
> “借助 Vercel，我们深知推送到生产环境的代码已近乎完美。这一点至关重要——因为作为一家电商平台，我们的网站就是一切。”

> ![](images/how-vercel-helped-desenio-future-proof-their-business-vercel/img_001.jpg)
>
> ![](images/how-vercel-helped-desenio-future-proof-their-business-vercel/img_001.jpg)
>
> **Dash Donnergren,** Frontend Developer
>
> **Dash Donnergren**，前端开发工程师

While the acquisition of The Poster Store helped amplify Desenio’s global reach, it also introduced challenges that exacerbated the pitfalls of their existing setup.

尽管收购 The Poster Store 助力 Desenio 进一步拓展了全球市场，但也带来了新的挑战，进一步放大了其既有技术架构的固有缺陷。

If they wanted to make even the smallest change, it would take about 20 minutes to reflect on all the edge servers and an additional two hours for customers to see the changes live. It was also difficult to test their code, with five different languages on the site and the ability to preview just one or two at a time. All of this made for a huge deterrent for innovation.

哪怕只是做出最微小的变更，也需要约20分钟才能同步至全部边缘服务器，客户则还需额外等待两小时才能看到线上生效的效果。此外，网站支持五种语言，但每次仅能预览其中一到两种，使得代码测试异常困难。所有这些因素严重阻碍了创新进程。

When Desenio acquired The Poster Store, they suddenly realized that with two pipelines and two backends, their workload essentially doubled. Their current solution was simply not going to work if they wanted to scale their business.

当 Desenio 收购 The Poster Store 时，他们突然意识到：拥有两条发布流水线和两个后端系统，其工作量实际上翻了一倍。若想拓展业务规模，他们当前的解决方案显然难以为继。

While they were resistant to adding third-party software, they decided to make an exception for Vercel. “We saw the benefits over the cost, and felt that at the time we wouldn't have the technical know-how, time, or the resources to develop a networking backend that works just as well as Vercel,” said Donnergren.

尽管他们原本对引入第三方软件持谨慎态度，但最终决定为 Vercel 破例。“我们权衡了投入与收益，认为当时既缺乏开发同等性能网络后端所需的技术能力、时间，也缺少相应资源。”Donnergren 表示。

## **The Vercel toolkit that made it possible**

## **成就这一切的 Vercel 工具集**

Here are a few of the features that have helped the Desenio team future-proof their website and go from an idea to a product faster.

以下是几项助力 Desenio 团队为网站构建面向未来的架构、并加速将创意转化为产品的核心功能：

- [**Preview Deployments**](https://vercel.com/features/previews) **:** Previews let Desenio’s engineers iterate quickly, collaborate with stakeholders, and keep a log of their ideas.

- [**预览部署（Preview Deployments）**](https://vercel.com/features/previews)：预览功能使 Desenio 的工程师能够快速迭代、高效协同利益相关方，并完整记录设计思路与演进过程。

- [**ISR**](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) **:** As an ecommerce site in many different markets, Desenio has an enormous amount of pages. If they were to deploy statically, it would take hours. By leveraging Incremental Static Regeneration (ISR), builds take just a few minutes.

- [**增量静态再生（ISR）**](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration)：作为面向全球多个市场的电商平台，Desenio 拥有海量页面。若采用纯静态部署方式，每次构建将耗时数小时；而借助增量静态再生（ISR），构建仅需几分钟。

- [**Next.js Redirects**](https://nextjs.org/docs/api-reference/next.config.js/redirects) **:** The Poster Store had a lot of old URLs around Google before the acquisition, but Next.js made it simple to manage redirects because they live right next to the rest of Desenio’s codebase.

- [**Next.js 重定向（Redirects）**](https://nextjs.org/docs/api-reference/next.config.js/redirects)：收购前，The Poster Store 在 Google 上已存在大量旧 URL；得益于 Next.js 的重定向功能——其配置直接嵌入 Desenio 整体代码库中——URL 迁移与管理变得极为简便。

With more time to iterate and innovate, Desenio’s team has the flexibility to look inward and reimagine their site—what can they improve upon, whether it’s rethinking their cart feature or presenting products in a different way. This has helped them increase their accessibility scores and make the site available for more people across the globe.

有了更充裕的时间用于迭代与创新，Desenio 团队得以向内审视、重新构想自身网站——无论是重构购物车功能，还是以全新方式呈现商品，一切皆可探索。此举显著提升了网站的可访问性评分，也让全球更多用户得以顺畅使用该站点。

**_“Vercel is sort of like the peanut butter to a jam sandwich. You can choose to have it without the jam and have a peanut butter sandwich, but you can also choose to have it with something unorthodox like ketchup. It doesn't force you into a specific pattern of solving a problem. It gives us the power to create the solution that works best for us.”_**

**_“Vercel 就像果酱三明治里的花生酱——你可以选择不加果酱，只吃花生酱三明治；也可以另辟蹊径，搭配番茄酱这类‘非传统’配料。它从不强制你采用某种特定的问题解决范式，而是赋予我们自主打造最适合自身方案的能力。”_**

With a toolbelt of new tools, skyrocketing metrics, and the confidence to experiment and iterate, Desenio (now The Desenio Group) was able to launch 30 new markets in just one month. Suddenly that goal of being the largest global distributor of wall art looks well within reach.

凭借这一套全新工具集、持续飙升的关键指标，以及敢于实验、勇于迭代的信心，Desenio（现更名为 The Desenio Group）仅用一个月便成功开拓了 30 个新市场。彼时看似遥不可及的“成为全球最大墙艺分销商”这一目标，如今已清晰可见、触手可及。

Ready to future-proof your business and frontend stack? [Get in touch](https://vercel.com/contact/sales).

准备好为您的业务和前端技术栈做好面向未来的准备了吗？[联系我们](https://vercel.com/contact/sales)。