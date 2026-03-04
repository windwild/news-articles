---
title: "How a global agency built a web innovation engine in two months  - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-a-global-agency-built-a-web-innovation-engine-in-two-months"
date: "2023-02-22"
scraped_at: "2026-03-02T09:54:52.267490084+00:00"
language: "en-zh"
translated: true
description: "Globacore"
---

render_with_liquid: false
Feb 22, 2023

2023 年 2 月 22 日

如果你曾在某场展览或活动中首次体验一项新技术，那么向你介绍这项技术的，很可能正是位于多伦多、屡获殊荣的数字创意机构 [Globacore](https://www.globacore.com/) 那些才华横溢的技术专家。

Globacore 专注于为实体空间（如展会和办公场所）打造交互式体验，其作品不断突破技术与人类想象力的边界，服务对象包括讴歌（Acura）、电气电子工程师学会（IEEE）、大众汽车（Volkswagen）和三星（Samsung）等全球知名品牌。

“我们用人们前所未见、更别提亲身体验过的前沿技术来吸引观众注意。”Globacore 开发主管戴夫·博伊尔（Dave Boyle）表示。

然而，新冠疫情扰乱了线下活动的开展，Globacore 面临一个抉择：暂停所有项目，抑或将创新重心转向数字世界？借助 Next.js 和 Vercel，他们仅用两个月便成功完成转型。

### 一夜之间成为一家 Web 公司

短短数周之内，曾作为其数字项目画布的实体空间便不复存在——项目排期表中的所有展会活动接连被取消。

幸运的是，在一片混乱、困惑与未来未卜的氛围中，线上虚拟展会强势回归。客户基于对 Globacore 技术实力与叙事能力的信任，纷纷再度邀约，委托其为 Web 打造互动式三维展会体验。

## 构建面向性能优化的工作流

在组建一支全新的 Web 开发团队后，戴夫将重任交予迈克·罗宾逊（Mike Robinson）——一位经验丰富的全栈开发工程师，现任 Globacore 的 DevOps 工程总监——由他主导这些新项目，并为公司奠定坚实的 Web 技术基础。

Building short-lived virtual experiences for major global brands, Globacore could not afford to compromise on performance.

为全球主要品牌构建短期虚拟体验，Globacore 在性能方面不容妥协。

> “Vercel’s Global Edge Network is handling edge computing and caching for us and ensuring that during these virtual events reaching audiences around the globe that our users were receiving the fastest possible response no matter where they were—or which device they used to join—without us having to think about it.Vercel’s Global Edge Network is handling edge computing and caching for us and ensuring that during these virtual events reaching audiences around the globe that our users were receiving the fastest possible response no matter where they were—or which device they used to join—without us having to think about it.”
>
> “Vercel 的全球边缘网络（Global Edge Network）正为我们处理边缘计算与缓存任务，确保在这些面向全球受众的虚拟活动中，无论用户身处何地、使用何种设备接入，都能获得尽可能快的响应——而这一切，我们无需额外操心。”
>
> ![](images/how-a-global-agency-built-a-web-innovation-engine-in-two-months-vercel/img_001.jpg)
>
> **Mike Robinson,** DevOps Engineering Manager  
> **迈克·罗宾逊（Mike Robinson）**，DevOps 工程经理

Not only does the success of their client’s investment hinge upon the speed of their virtual experience, but Globacore had to deliver on 99.99% uptime service level agreements (SLAs) for larger brands. To protect the virtual experiences they deliver on behalf of their customers, they rely on [Vercel’s enterprise plan](https://vercel.com/enterprise) for scale and support as a key part of their workflow.

客户投资的成功不仅取决于其虚拟体验的速度，Globacore 还必须为大型品牌兑现 99.99% 正常运行时间的服务水平协议（SLA）。为保障其代表客户交付的虚拟体验稳定可靠，他们将 [Vercel 企业版计划](https://vercel.com/enterprise) 作为工作流的关键一环，倚赖其可扩展性与专业支持能力。

### Next.js at the micro-level

### 微观层面：Next.js 的应用

In addition to the zero-configuration workflow and optimizations, Globacore’s developers relied on Next.js’ fast refresh to see edits in the browser within a second of saving. Thanks to the ecosystem surrounding Next.js, they didn’t have to reinvent the wheel. The whole team was able to get up to speed quickly and had confidence in what they were doing. This allowed them to build and iterate faster with hundreds of changes being made daily.

除开开箱即用的工作流与内置优化外，Globacore 的开发人员还依赖 Next.js 的“快速刷新”（Fast Refresh）功能——代码保存后一秒内即可在浏览器中实时预览修改效果。得益于 Next.js 周边丰富的生态系统，他们无需重复造轮子；整个团队得以快速上手，并对其所做工作充满信心。这使得他们能够更高效地构建与迭代，每日完成数百次变更。

### Vercel at the macro-level

### 宏观层面：Vercel 的应用

With Vercel’s interactive and collaborative [Preview Deployments](https://vercel.com/features/previews) a `Git Push` away, they're also able to involve clients in the review process for new features their iterating on and tighten the feedback loop.

借助 Vercel 交互式、协作式的 [预览部署（Preview Deployments）](https://vercel.com/features/previews) 功能——只需一次 `Git Push` 即可触发——他们还能邀请客户参与新功能的评审流程，从而显著缩短反馈闭环周期。

" **Vercel is practically our DevOps department. We don't have to do anything more than link our Git repository and push our code to get a website up and running with preview environments**” explains Mike.

“**Vercel 实际上就是我们的 DevOps 部门。我们只需将 Git 仓库关联起来，再推送代码，即可一键启动网站并自动生成预览环境。**” 迈克解释道。

## Into the future: digital experiences for _any_ space

## 展望未来：面向 _任意空间_ 的数字体验

While physical spaces have returned, Globacore has transformed into a hybrid agency that can deliver omnichannel experiences for their customers.

尽管实体空间已逐步回归，Globacore 已成功转型为一家混合型机构，能够为其客户交付全渠道（omnichannel）数字体验。

“We changed our tagline from ‘digital experiences for physical spaces’ to ‘digital experiences for _any_ space’ to reflect the transformation we made,” says Dave.  
“我们将品牌标语从‘面向物理空间的数字体验’更新为‘面向_任意_空间的数字体验’，以体现我们所实现的转型。”戴夫说道。

“In a few months, Vercel allowed us to build world-class digital experiences at scale with a lean engineering team and at a cost that allowed our business to grow during the pandemic.”  
“短短数月内，Vercel 使我们得以凭借精干的工程团队，以可控的成本规模化构建世界级数字体验，并助力公司在疫情期间实现业务增长。”

If you’re ready to speed up your team's development process and site performance, we’d love to chat. [Get in touch today](https://vercel.com/contact).  
如果您已准备好加速团队开发流程并提升网站性能，我们非常期待与您交流。[立即联系我们](https://vercel.com/contact)