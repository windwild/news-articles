---
title: "Sanity balances experimentation and performance with Vercel Edge Middleware  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/sanity-edge-middleware"
date: "2023-01-13"
scraped_at: "2026-03-02T09:56:37.389190354+00:00"
language: "en-zh"
translated: true
description: "Setting the standard for A/B testing and performance with Vercel Edge Middleware."
---

Jan 13, 2023

2023年1月13日

The Sanity Composable Content Cloud enables teams to create better digital experiences—unleashing editor creativity while reducing engineering headaches. When it comes to their own marketing site, Sanity has similarly high standards, which is why they rely on Vercel and Next.js. With [Edge Middleware](https://vercel.com/features/edge-functions) and [Serverless Functions](https://vercel.com/docs/concepts/functions#serverless-functions), Vercel makes it simple for Sanity’s developers to collaborate between teams, create and manage experiments, and empower their users to dream big with [pre-built templates.](https://vercel.com/templates/sanity)

Sanity 的可组合内容云（Composable Content Cloud）助力团队打造更出色的数字体验——在释放编辑人员创造力的同时，显著减轻工程师的工作负担。对于自身营销网站的建设，Sanity 同样秉持极高标准，因此选择依托 Vercel 与 Next.js 构建。借助 [边缘中间件（Edge Middleware）](https://vercel.com/features/edge-functions) 和 [无服务器函数（Serverless Functions）](https://vercel.com/docs/concepts/functions#serverless-functions)，Vercel 让 Sanity 的开发者能够轻松实现跨团队协作、快速创建与管理实验，并通过 [预置模板（pre-built templates）](https://vercel.com/templates/sanity) 赋能用户大胆构想、高效落地。

## Reducing overhead and complexity

## 降低运维开销与系统复杂度

Sanity launched their marketing site in 2017 using a custom Server-Side Rendering (SSR) React Framework, Docker, and Google Cloud Platform, but found the stack required operational overhead. Whenever there were issues, they’d need to involve an already-busy site reliability engineering team. When Sanity decided to rebuild their site in 2018 with Next.js, they felt confident knowing Vercel is the best place to host Next.js apps—and that it “just works.”

Sanity 于 2017 年使用自研服务端渲染（SSR）React 框架、Docker 及 Google Cloud Platform 上线其营销网站，但发现该技术栈带来了较高的运维负担：一旦出现故障，便需调用本已十分繁忙的站点可靠性工程（SRE）团队介入。2018 年，Sanity 决定基于 Next.js 重建网站时，对 Vercel 充满信心——因为 Vercel 是部署 Next.js 应用的最佳平台，且真正做到了“开箱即用”。

> “The switch from Google Cloud Platform to Vercel has allowed our engineers to go from spending their time managing and troubleshooting Kubernetes clusters to building more unique features for our customers.The switch from Google Cloud Platform to Vercel has allowed our engineers to go from spending their time managing and troubleshooting Kubernetes clusters to building more unique features for our customers.”
>
> ![](images/sanity-balances-experimentation-and-performance-with-vercel-edge-middleware-verc/img_001.png)
>
> **Knut Melvær Head of Developer Relations,** Sanity.io

> “从 Google Cloud Platform 迁移至 Vercel，使我们的工程师得以摆脱耗时耗力的 Kubernetes 集群运维与排障工作，转而专注于为客户构建更具差异化的功能。”  
>   
> ![](images/sanity-balances-experimentation-and-performance-with-vercel-edge-middleware-verc/img_001.png)  
>   
> **Knut Melvær，开发者关系主管**，Sanity.io

The switch was seamless, which the team attributes to Vercel’s backwards compatibility. Even their older configuration files worked. Immediately after switching over, the team was delighted by the out-of-the-box features: all of the tedious but necessary tasks like adding domains, SSL certificates, and getting deployment previews were taken care of, saving them additional setup time and worry. With Vercel they could simply point it to a GitHub repository and get CI/CD out of the box. The ability to seamlessly fetch form data from Marketo’s API was also “unparalleled.”

此次迁移过程无缝顺畅，团队将此归功于 Vercel 出色的向后兼容性——甚至旧版配置文件亦可直接运行。切换完成之后，团队立刻被其开箱即用的功能所打动：添加域名、配置 SSL 证书、生成部署预览等繁琐却必不可少的任务全部自动完成，大幅节省了初始配置时间与运维焦虑。借助 Vercel，团队只需将其关联至 GitHub 仓库，即可立即获得完整的 CI/CD 流水线。此外，Vercel 对 Marketo API 表单数据的无缝拉取能力也被誉为“无可匹敌”。

" [Vercel Preview Deployments](https://vercel.com/features/previews) make sharing projects and collaboration simple, even for non-technical people who now get to click around and look at pages," says Knut Melvær, Head of Developer Relations. "I feel like this social aspect is also a big part of what makes the result great."

“[Vercel 预览部署（Preview Deployments）](https://vercel.com/features/previews) 让项目共享与协同变得极为简单——即便是非技术人员，如今也能轻松点击浏览页面。”开发者关系主管 Knut Melvær 表示，“我认为这种社交化协作特性，也正是最终成果如此出色的重要原因之一。”

## Stress-free experimentation

## 无压力的实验迭代

One of the team’s favorite Vercel features is Edge Middleware, which allows them to run A/B tests without disrupting the client experience. In fact, they ran over eight tests just this summer, working to improve the onboarding flow for new users and experimenting with different CTA buttons to increase quality leads reaching the sales team. Soon they plan to collaborate with AT&T on personalization with Edge Middleware as well.

团队最钟爱的 Vercel 功能之一便是边缘中间件（Edge Middleware）——它支持在不干扰终端用户体验的前提下开展 A/B 测试。事实上，仅在今年夏季，团队就已执行了八场以上实验：优化新用户上手流程、测试不同 CTA 按钮以提升销售团队所获高质量线索数量。接下来，他们还计划与 AT&T 合作，利用 Edge Middleware 推进个性化功能落地。

Sanity’s developers also credit Vercel’s ease of integration, relying on Checkly for end-to-end testing that has “saved them several times.” Combined with Vercel’s performance checks, the team has the assurance they need that their sites and experiments will continue to perform well.

Sanity 的开发者同样高度认可 Vercel 出色的集成便捷性；他们采用 Checkly 进行端到端测试，该方案已“多次助其化解危机”。再结合 Vercel 自带的性能监测机制，团队得以充分确信：其网站及各项实验将持续保持优异性能表现。

For Sanity, it’s not only about how Vercel impacts their developer experience, but how it improves the user experience, too. With a lightning-fast marketing site, users can get the most out of Sanity, while their developers can continue to experiment and innovate.

对于 Sanity 而言，Vercel 带来的不仅限于开发者体验的提升，更显著改善了终端用户的体验。凭借闪电般迅捷的营销网站，用户能够充分释放 Sanity 的潜力，而其开发团队则可持续开展实验与创新。

_Looking to drive experiments and personalization impacting site performance?_ [_Get in touch_](https://vercel.com/contact/sales) _._

_希望借助实验与个性化策略切实提升网站性能？_ [_联系我们_](https://vercel.com/contact/sales) _。_