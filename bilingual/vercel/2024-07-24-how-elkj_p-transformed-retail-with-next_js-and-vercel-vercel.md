---
title: "How Elkjøp Transformed Retail with Next.js and Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/elkjops-digital-transformation-with-next-js-and-vercel"
date: "2024-07-24"
scraped_at: "2026-03-02T09:42:40.631546727+00:00"
language: "en-zh"
translated: true
description: "By adopting Next.js and Vercel, Elkjøp improved page loads, SEO, and overall user experience, driving over $1 Billion in digital revenue"
---

Jul 24, 2024

2024年7月24日

Elkjøp 转向使用 Next.js 和 Vercel，将发布周期缩短了 7 周，从而提升了数字营收并优化了用户体验。

#### 93%

累积布局偏移（CLS）改善幅度

#### 7 周 → 1 天

发布周期耗时改善

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Preview Deployments

预览部署

# Monitoring

# 监控

[**Powered by** AWS](https://vercel.com/partners/aws)

[**由** AWS **提供支持**](https://vercel.com/partners/aws)

With over $1B in revenue flowing through their digital properties, Elkjøp (Elgiganten), Nordic subsidiary of Currys PLC and leading consumer electronics retailer in the region, knew their digital presence needed to reflect their in-store commitment to innovation and excellence. Their previous ecommerce platform, built on Angular and self-hosted on Kubernetes, had become a source of frustration for both customers and internal teams. Slow page loads, SEO struggles, and inefficient developer experience were impacting the bottom line and hindering their ability to deliver the exceptional online shopping experience their customers deserved.

年营收超 10 亿美元的数字业务渠道，让作为英国 Currys PLC 集团北欧子公司的 Elkjøp（Elgiganten）——该地区领先的消费电子零售商——深刻意识到：其线上数字形象必须与线下门店对创新与卓越的一贯承诺保持一致。此前基于 Angular 构建、并自行托管于 Kubernetes 上的电商平台，已日益成为客户与内部团队共同的痛点：页面加载缓慢、搜索引擎优化（SEO）表现不佳、开发者体验低效——这些问题正直接侵蚀企业利润，并严重阻碍其为顾客提供卓越在线购物体验的能力。

### The Challenge: More than just technical debt

### 挑战：远不止技术债那么简单

The problems ran deeper than just outdated technology. Lengthy build times and a complex deployment process involving a separate team meant that even small changes could take a while to reach customers.

问题的根源远不止技术栈陈旧这么简单。冗长的构建耗时，以及需依赖独立团队协作的复杂部署流程，导致即便是微小的功能变更，也需要耗费较长时间才能上线交付给用户。

The tools they were working with were also holding them back, and forcing them to build workarounds instead of new features. "It felt like we were always working against the framework instead of with it," Jansson recalls. "For example, our SEO was not good enough," admits Tomas Jansson, Elkjøp's Principal Software Engineer, "we had to build workarounds like a custom crawler just to serve content to Google faster."

他们所使用的开发工具同样成了掣肘，迫使团队将大量精力投入“打补丁”式变通方案，而非真正的新功能开发。“我们总感觉是在跟框架‘对抗’，而不是‘协同’工作。”詹松回忆道。Elkjøp 首席软件工程师托马斯·詹松（Tomas Jansson）坦言：“例如，我们的 SEO 表现远远不够理想——为了加快向 Google 提供内容的速度，我们甚至不得不自行开发一个定制化网络爬虫。”

The situation was hindering Elkjøp's ability to innovate and respond to market demands. They knew they needed a radical change, not just a technical upgrade, but a cultural shift that would empower their teams and unleash their potential.

这一局面严重制约了 Elkjøp 的创新能力与市场响应速度。他们深知：亟需的并非一次单纯的技术升级，而是一场彻底的变革——一场旨在赋能团队、释放潜能的文化转型。

### Faster iteration cycles with automated deployments

### 借助自动化部署实现更快速的迭代周期

The transition to Next.js and Vercel has also had a transformative impact on Elkjøp's development workflows and team dynamics. Automated deployments and preview environments have empowered developers to take ownership of the entire release process.

迁移到 Next.js 与 Vercel，亦对 Elkjøp 的开发工作流与团队协作模式产生了颠覆性影响。自动化部署与预览环境（Preview Environments）使开发者得以全面掌控整个发布流程。

> “We're not waiting for things to be verified because we also believe that we can verify a lot of things ourselves," Jansson explains. "Developers should know what we're developing and be able to verify most of it ourselves.We're not waiting for things to be verified because we also believe that we can verify a lot of things ourselves," Jansson explains. "Developers should know what we're developing and be able to verify most of it ourselves.”
>
> “我们不再被动等待他人验证，因为我们坚信：自身已具备充分的验证能力。”詹松解释道，“开发者理应清楚自己正在开发什么，并有能力自主完成其中大部分的验证工作。”
>
> ![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_001.jpg)
>
> ![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_001.jpg)
>
> **Tomas Jansson,** Principal Software Engineer at Elkjøp
>
> **托马斯·詹松（Tomas Jansson）**，Elkjøp 首席软件工程师

This shift in mindset has enabled Elkjøp's developers to move faster, deploy more frequently, and take on a more strategic role in driving the company's digital transformation. The team's ability to quickly iterate, test, and release new features has been a key driver of Elkjøp's ability to respond to customer needs and stay ahead of the competition.

这种思维模式的转变，使 Elkjøp 的开发人员能够加速交付、更频繁地部署，并在推动公司数字化转型中承担起更具战略性的角色。团队快速迭代、测试并发布新功能的能力，已成为 Elkjøp 迅速响应客户需求、持续领先于竞争对手的关键驱动力。

> “Things that previously took us 7 weeks now take a day," Tomas shares. "We're definitely moving much faster, and the technical choices have made it easier to work with the solution instead of against it.”  
>  
> “过去需要 7 周才能完成的工作，如今只需一天。”Tomas 分享道，“我们的确大幅加快了节奏，而所采用的技术方案也让我们得以‘顺势而为’，而非‘逆势而行’。”

> ![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_001.jpg)  
>  
> **Tomas Jansson,** Principal Software Engineer at Elkjøp  
>  
> **托马斯·扬松（Tomas Jansson）**，Elkjøp 首席软件工程师

Elkjøp has also leveraged feature flags within the [Vercel toolbar](https://vercel.com/docs/workflow-collaboration/feature-flags?__vercel_draft=1) to enable gradual rollouts and experimentation, allowing the team to test new features and functionality with internal users before making them widely available. This approach has helped the company gather valuable feedback and ensure a smooth transition for both customers and internal stakeholders.

Elkjøp 还充分利用了 [Vercel 工具栏](https://vercel.com/docs/workflow-collaboration/feature-flags?__vercel_draft=1) 中的“功能开关（feature flags）”，实现新功能的渐进式发布与实验性验证——即先面向内部用户开放测试，再逐步向全体用户推广。这一策略帮助公司高效收集真实反馈，并确保客户及内部相关方均能平稳过渡。

## Unlocking a more stable user experience  

## 打造更稳定可靠的用户体验

By adopting Next.js and Vercel, Elkjøp was able to significantly improve the performance and SEO of its ecommerce platform. With significant improvements across their Core Web Vitals scores—93% improvement in Cumulative Layout Shift, 60% improvement in Interaction to Next Paint, and 50% improvement in Largest Contentful Paint—the team now sees all green in their lighthouse scores. The combination of Next.js's server-side rendering capabilities and Vercel's seamless hosting and deployment platform enabled Elkjøp to deliver faster page loads, more consistent content rendering, and better search engine visibility.

通过采用 Next.js 与 Vercel，Elkjøp 显著提升了其电商平台的性能表现与搜索引擎优化（SEO）效果。其核心网页指标（Core Web Vitals）得分全面跃升：累积布局偏移（CLS）改善 93%，下一次绘制交互时间（INP）缩短 60%，最大内容绘制（LCP）提升 50%——Lighthouse 测试结果现已全部呈现绿色达标。Next.js 的服务端渲染能力与 Vercel 无缝集成的托管与部署平台协同发力，助力 Elkjøp 实现更快的页面加载速度、更一致的内容渲染效果，以及更强的搜索引擎可见性。

In addition to the performance and SEO improvements, Elkjøp's transition to Next.js and Vercel has also had a positive impact on the overall user experience of its ecommerce platform.

除性能与 SEO 的显著提升外，Elkjøp 向 Next.js 和 Vercel 的迁移，亦为其电商平台的整体用户体验带来了积极影响。

> “It's more stable, and you don't have as many surprises," Tomas explains. "Things are there when you expect them to be there, and the user experience is much better.”  
>  
> “平台更稳定了，意外状况也少了许多。”托马斯解释道，“你期望看到的内容，总会在它该出现的地方准时呈现，整体用户体验因此大幅提升。”

> ![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_001.jpg)  
>  
> **Tomas Jansson,** Principal Software Engineer at Elkjøp  
>  
> **托马斯·扬松（Tomas Jansson）**，Elkjøp 首席软件工程师

While Elkjøp has kept the brand and user experience consistent, the underlying technical improvements have resulted in a more seamless and reliable shopping experience for customers. Pages load faster, content is rendered consistently, and the overall stability of the platform has been enhanced, resulting in over $1 billion in digital revenue.

尽管 Elkjøp 始终保持品牌调性与用户体验的一致性，但底层技术升级却为客户带来了更为流畅、可靠的购物体验：页面加载更快、内容渲染更稳定、平台整体健壮性显著增强，最终促成超 10 亿美元的数字营收。

Vercel.com landing page  

Vercel.com 官网落地页

### Up your SEO game on Vercel.  

### 在 Vercel 上全面提升您的 SEO 能力

Blog post

博客文章

Jan 19, 2024

2024年1月19日

### How Core Web Vitals affect SEO

### 核心网页指标（Core Web Vitals）如何影响搜索引擎优化（SEO）

![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_004.jpg)![](images/how-elkj_p-transformed-retail-with-next_js-and-vercel-vercel/img_005.jpg)

Malte and Alice

Malte 与 Alice