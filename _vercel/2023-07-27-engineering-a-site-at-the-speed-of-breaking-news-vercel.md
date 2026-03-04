---
title: "Engineering a site at the speed of breaking news - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/washington-post-next.js-vercel-engineering-at-the-speed-of-breaking-news"
date: "2023-07-27"
scraped_at: "2026-03-02T09:51:32.853868320+00:00"
language: "en-zh"
translated: true
description: "The Washington Post paid off tech debt by migrating to Next.js and Vercel between primary season and the 2022 US midterm elections. "
---
&#123;% raw %}

Jul 27, 2023

2023年7月27日

《华盛顿邮报》在初选季与2022年美国中期选举之间，通过迁移到 Next.js 和 Vercel 清偿了技术债务，并因此收获了显著回报。

许多 Vercel 和 Next.js 用户需处理海量数据，但鲜有团队能像《华盛顿邮报》选举工程团队那样驾驭如此庞杂的数据。

该团队深知：其平台必须兼具高速响应能力与视觉表现力——同时还要实时处理来自数千个联邦、州及地方层级选举的持续更新。为此，《华盛顿邮报》在2022年美国中期选举中全面转向 Next.js 与 Vercel。

### 新闻编辑部工程师所面临的独特挑战

泰勒·费舍尔（Tyler Fisher）是选举工程团队的首席软件工程师，他致力于提升并革新《华盛顿邮报》对政治与选举数据的应用方式。“我们通过构建数据管道、预测模型以及引人入胜的可视化图表来实现这一目标，”费舍尔表示，“本质上，我们是在为所有选举结果页面搭建基础设施。”

作为《华盛顿邮报》新闻编辑部的紧密合作伙伴，该团队在11月8日——美国大选日——全天候处理来自全国数千场选举的持续数据流，同时应对用户高度关注所引发的巨大流量峰值。

“我们必须跟上《华盛顿邮报》强大新闻编辑部的节奏。”选举工程团队工程经理安东尼·佩斯切（Anthony Pesce）指出。工程师们始终密切关注记者的需求，以及他们在选举之夜希望讲述的故事——而这些故事往往瞬息万变。

![](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_001.jpg)

在采用 Vercel 之前，《华盛顿邮报》的渲染层部署于 AWS，使用 ECS 集群运行。为精准调控此类高负载场景下所需的数据更新，团队构建了一套复杂的重新验证系统，依托 SQS 与 EC2 进行编排。

“It was complex and there were onboarding hurdles for new developers and fine tune performance. And it was expensive. Vercel took a lot of that load off of us,” says Fisher.

“这一方案十分复杂，新开发者上手存在诸多障碍，性能调优也颇具挑战；而且成本高昂。Vercel 帮我们大幅分担了这些压力。”费舍尔（Fisher）表示。

### Moving to Vercel for fast iteration and smooth collaboration

### 迁移至 Vercel：实现快速迭代与顺畅协作

Above all, The Post team knows that they have a hard deadline of November 8. “There’s no pushing a release by a couple days or weeks,” says Fisher. “It’s an immovable deadline.”

最重要的是，《华盛顿邮报》（The Post）团队深知自己面临一个不可更改的硬性截止日期——11月8日。“发布日期无法推迟数天或数周，”费舍尔表示，“这是一个雷打不动的截止日。”

Prior to the 2022 elections season, the Election Engineering team’s previous solution was already Next.js-based. They had small a window between end of primary season and November general election where they had time to go all-in on Vercel, with four goals in mind:

在2022年大选季开始前，选举工程团队（Election Engineering team）原有的技术方案已基于 Next.js 构建。他们在初选季结束与11月大选之间仅有短暂窗口期，得以全力投入 Vercel 迁移工作，并设定了四大目标：

1. Migrate to [Next.js 12,](https://nextjs.org/blog/next-13) to take full advantage of [Incremental Static Regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration/overview)

1. 迁移至 [Next.js 12](https://nextjs.org/blog/next-13)，以充分释放 [增量静态再生（ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration/overview) 的全部能力

2. Host [development and production environments](https://vercel.com/docs/concepts/deployments/environments) to streamline stakeholder review and ease the burden of infrastructure management

2. 托管 [开发与生产环境](https://vercel.com/docs/concepts/deployments/environments)，简化各相关方的评审流程，并显著减轻基础设施运维负担

3. Rewrite their frontend in TypeScript to catch errors before they happen

3. 使用 TypeScript 重写前端代码，从而在错误发生前即予以捕获

4. Improve the quality of test coverage and documentation

4. 提升测试覆盖率与文档质量

Vercel’s [collaboration tooling](https://vercel.com/features/previews) is integral to the team’s success as well. With stakeholders like political editors, reporters, and graphics teams all working together, they “have to review, test, and deploy rapidly, because every second matters,” says Fisher. “We love the ability to integrate our stakeholders into the process.”

Vercel 的 [协作工具](https://vercel.com/features/previews) 同样是团队成功的关键一环。政治版编辑、记者及图表设计团队等多方相关方需紧密协同，“我们必须快速完成评审、测试与部署——因为每一秒都至关重要，”费舍尔表示，“我们非常欣赏将各相关方深度融入开发流程的能力。”

![With Figma-like commenting, Vercel's Preview Comments feature empowers stakeholders from all areas of the business to collaborate with developers. ](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_002.jpg)  
![Vercel 的 Preview Comments 功能支持类似 Figma 的评论交互，赋能企业内各业务部门的相关方与开发者高效协作。](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_002.jpg)  
With Figma-like commenting, Vercel's Preview Comments feature empowers stakeholders from all areas of the business to collaborate with developers.  
Vercel 的 Preview Comments 功能支持类似 Figma 的评论交互，赋能企业内各业务部门的相关方与开发者高效协作。

### Spiky traffic, streaming data

### 流量尖峰与实时数据流

For The Post’s Election Engineering team, Vercel proved to be a perfect fit for their platform. Fast iteration via seamless collaboration is key for them, as is the platform’s unique ability to handle hefty data and aggressive traffic spikes.

对于《华盛顿邮报》选举工程团队而言，Vercel 完美契合其平台需求。对他们而言，通过无缝协作实现快速迭代至关重要；同样关键的，还有该平台独特的大数据处理能力与应对突发高流量峰值的能力。

“To keep up with both our incredibly spiky traffic and the sheer amount of data streaming in, we need a solution that has the primary benefit of static sites—easy and instant scalability—with the benefit of dynamic sites—responsive to quickly changing data—without rebuilding the entire project,” says Fisher.

“为应对我们极其剧烈的流量尖峰以及海量实时涌入的数据，我们需要一种解决方案：既具备静态站点的核心优势——轻松、即时的可扩展性，又兼具动态站点的优点——能快速响应瞬息万变的数据，且无需重建整个项目。”费舍尔（Fisher）表示。

This resulted in a flawless election night presentation of over 1,000 individual elections spread across 52 different results pages—all hosted on Vercel.

最终，这一方案实现了近乎完美的大选之夜呈现效果：涵盖全美52个不同结果页面、总计逾1,000场独立选举的全部数据，全部托管于 Vercel 平台。

### A huge election night win

### 大选之夜的重大胜利

Midterm election night went off without a hitch for Fisher’s team at The Washington Post, even with a rewrite that he risked implementing at the last moment.

即便费舍尔在最后关头冒险重写了核心逻辑，《华盛顿邮报》费舍尔团队的大选之夜依然平稳无误地顺利运行。

“Our highest data load page was for the US House of Representatives, which has roughly 400 races on one page. That’s a lot of data. We had been using a websocket solution to update the page while the user was on it, and it was lagging like crazy. So, I rewrote the solution at the last second. It held up and worked really well!”

“我们数据负载最高的页面是美国众议院选举页面，单页需承载约400场竞选结果——数据量极为庞大。此前我们采用 WebSocket 方案实现实时页面更新，但用户浏览时严重卡顿。因此，我在最后一刻重写了整套方案。新方案稳定可靠，运行效果极佳！”

“Our night was a lot simpler because of Vercel and Next.js. It was a huge win for us,” Fisher says.

“得益于 Vercel 和 Next.js，我们的大选之夜变得简单得多——这对我们而言是一次重大胜利。”费舍尔说道。

Pesce adds that on Vercel, **“it was the smoothest election night anyone could remember.”**

佩斯切（Pesce）补充道，在 Vercel 平台上，“这是人们所能回忆起的最顺畅的一次大选之夜。”

[**Looking to pay off tech debt?**\\
\\
Connect with a Next.js expert and learn about Vercel's best-in-class tooling for site performance and org-wide collaboration. \\
\\
Contact Us](https://vercel.com/contact)

[**希望偿还技术债务？**\\
\\
联系 Next.js 专家，了解 Vercel 行业领先的网站性能优化工具与组织级协同开发方案。\\
\\
立即联系](https://vercel.com/contact)

Customer case study

客户案例研究

Nov 30, 2022

2022年11月30日

### With Next.js, Vercel, and Sanity, Loom empowers every team to iterate

### 借助 Next.js、Vercel 和 Sanity，Loom 赋能每个团队快速迭代

![](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_003.jpg)

Greta Workman

格蕾塔·沃克曼

Customer case study

客户案例研究

Feb 10, 2023

2023年2月10日

### Runway enables next-generation content creation with AI and Vercel

### Runway 借助 AI 与 Vercel 实现新一代内容创作

![](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_004.jpg)![](images/engineering-a-site-at-the-speed-of-breaking-news-vercel/img_005.jpg)

Kiana and Steven

基安娜与史蒂文
&#123;% endraw %}
