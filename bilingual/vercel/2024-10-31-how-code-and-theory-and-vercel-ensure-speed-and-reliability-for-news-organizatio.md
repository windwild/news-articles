---
title: "How Code and Theory and Vercel ensure speed and reliability for news organizations and publishers - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/break-the-news-not-the-site"
date: "2024-10-31"
scraped_at: "2026-03-02T09:39:49.682146129+00:00"
language: "en-zh"
translated: true
description: "Code and Theory partners with Vercel to deliver breaking news with high performance and uptime. News organizations RealClearPolitics and Minnesota Star Tribune upgrade their digital infrastructure to ..."
---

Oct 31, 2024

2024年10月31日

Performance at the speed of the news, powered by Code and Theory and Vercel

新闻时效即性能——由 Code and Theory 与 Vercel 联合赋能

When major political developments unfold, millions rush to news websites, putting immense pressure on digital infrastructure. With global audiences, slow-loading websites or crashes during a major event can be catastrophic for a news organization.

当重大政治事件发生时，数以百万计的用户会蜂拥访问新闻网站，给数字基础设施带来巨大压力。面对全球受众，在重大事件期间若网站加载缓慢或发生宕机，对新闻机构而言可能是灾难性的。

[Code and Theory](https://www.codeandtheory.com/) has digitally transformed more than 200 newsrooms. As a leading technology and creative agency, Code and Theory has over 20 years of helping Fortune 500 clients including JPMorganChase, Pfizer, NFL, NBC, MARS, and more, navigate the complexities of modern web development.

[Code and Theory](https://www.codeandtheory.com/) 已助力逾 200 家新闻编辑部完成数字化转型。作为一家领先的技术与创意代理机构，Code and Theory 拥有逾 20 年服务《财富》500 强企业的经验，客户包括摩根大通（JPMorganChase）、辉瑞（Pfizer）、美国国家橄榄球联盟（NFL）、美国全国广播公司（NBC）、玛氏公司（MARS）等，持续协助其应对现代 Web 开发的复杂挑战。

For them, [Next.js](https://nextjs.org/) is the go-to framework for building best-in-class web experiences, especially when building high-stakes platforms. Relying on Vercel’s managed platform means Code and Theory’s clients don’t have to worry about infrastructure when traffic surges. Instead, they get high uptime, security, and the flexibility to scale without investing in dedicated DevOps.

对他们而言，[Next.js](https://nextjs.org/) 是构建顶级 Web 体验的首选框架，尤其适用于高风险、高关注度的平台建设。依托 Vercel 的托管平台，Code and Theory 的客户无需在流量激增时担忧底层基础设施问题；取而代之的是高可用性、强安全性，以及无需投入专职 DevOps 团队即可灵活扩展的能力。

> “The brand is not just a single touchpoint - it's the sum of every interaction. If the website is slow and clunky, it can really tarnish their perception of the brand.The brand is not just a single touchpoint - it's the sum of every interaction. If the website is slow and clunky, it can really tarnish their perception of the brand.”
>
> “品牌绝非单一触点——而是每一次用户交互的总和。倘若网站响应迟缓、操作笨拙，将严重损害用户对品牌的整体认知。”
>
> ![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_001.jpg)
>
> **David DiCamillo,** CTO - Code and Theory
>
> **大卫·迪卡米洛（David DiCamillo）**，首席技术官 — Code and Theory

Let's explore how two leading media organizations leverage Vercel to transform their digital presence and meet the demands of today's fast-paced news environment.

接下来，让我们深入探究两家头部媒体机构如何借助 Vercel 全面重塑其数字形象，以满足当今快节奏新闻环境的严苛需求。

## **RealClearPolitics**

## **RealClearPolitics（真实清晰政治网）**

![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_002.jpg)

RealClearPolling visualizes politics for engaged discourse, helping the general public to get better informed on how the polling shifts leading into the election.

RealClearPolling（真实清晰民调）以可视化方式呈现政治议题，推动深度公共讨论，帮助广大公众更清晰地了解选举前民调数据的动态变化。

**Challenge:** After Code and Theory designed and developed RealClearPolitics' digital experience, the agency split the polling data off into a stand-alone site called [RealClearPolling](https://www.realclearpolling.com/). RealClearPolling faced significant challenges with legacy infrastructure; its custom-built PHP CMS led to performance issues, complicated content updates, and risky deployments. Also, managing their AWS infrastructure had become increasingly overwhelming for their developers.

**挑战：** 在 Code and Theory 为 RealClearPolitics 设计并开发其数字体验后，该机构将民调数据拆分出来，独立构建了一个名为 [RealClearPolling](https://www.realclearpolling.com/) 的专属网站。RealClearPolling 面临着严重的历史技术架构问题：其自主开发的 PHP 内容管理系统（CMS）导致性能低下、内容更新复杂且部署风险高；同时，管理其 AWS 基础设施也日益超出开发团队的负荷能力。

**Solution:** Code and Theory migrated RealClearPolling to a modern tech stack, including Contentful for content management and Next.js for the frontend—all served on Vercel's infrastructure. [Git based workflows](https://vercel.com/docs/deployments/git) streamline deployments, significantly enhancing the development process.

**解决方案：** Code and Theory 将 RealClearPolling 迁移至一套现代化技术栈，采用 Contentful 进行内容管理，Next.js 构建前端，并全部托管于 Vercel 基础设施之上。[基于 Git 的工作流](https://vercel.com/docs/deployments/git) 大幅简化了部署流程，显著提升了整体开发效率。

**Results:** The new website boasts improved performance, easier content management, and a simplified deployment process.

**成果：** 新网站实现了性能提升、内容管理更便捷、部署流程更简化。

- **Content presentation:** Interactive charts and graphs made aggregated data easier to understand and load quickly thanks to Next.js caching  
- **内容呈现：** 借助 Next.js 的缓存机制，交互式图表与图形使聚合数据更易于理解，且加载速度更快  

- **Faster time to market:** The entire migration was completed in just three months, showcasing the speed and agility of Vercel's platform  
- **更快上市速度：** 整个迁移项目仅用时三个月即告完成，充分展现了 Vercel 平台的高效性与敏捷性  

- **Future migrations**: The success of this project sparked a "lightbulb moment" for RealClearPolitics, wanting to leverage Next.js and Vercel across their entire portfolio  
- **后续迁移计划：** 本项目的成功为 RealClearPolitics 带来了“灵光一现”的启发——他们希望将 Next.js 与 Vercel 全面应用于其全部数字产品组合中  

## **Minnesota Star Tribune**

## **明尼苏达州《明星论坛报》**

![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_003.jpg)

A leading news organization, first published 157 years ago, recently modernized their digital presence with a Vercel-powered website relaunch.

一家拥有 157 年历史的主流新闻机构，近期借助 Vercel 支持的网站重构，全面升级了其数字平台。

**Challenge:** Facing a tight deadline, the [Minnesota Star Tribune](https://www.startribune.com/) was looking to modernize their PHP and AWS-based stack, which was expensive and difficult to manage. They also had separate mobile and desktop sites, which resulted in managing two completely separate codebases and was negatively impacting their SEO. Additionally, they wanted to reduce their infrastructure costs and their reliance on DevOps resources.

**挑战：** 面临紧迫的上线时限，[明尼苏达州《明星论坛报》](https://www.startribune.com/) 急需对其基于 PHP 和 AWS 的现有技术栈进行现代化改造——该架构不仅运维成本高昂，而且管理难度大。此外，他们长期维护着彼此独立的移动版与桌面版网站，导致需同时维护两套完全分离的代码库，严重损害了搜索引擎优化（SEO）效果。同时，他们也希望降低基础设施开支，并减少对 DevOps 工程师资源的依赖。

**Solution:** The Minnesota Star Tribune partnered with Code and Theory to modernize their platform using Next.js and Vercel. This move consolidated their web and mobile codebases, enabling faster deployments and provided cleaner content restructuring through Vercel's redirects. Vercel's [preview deployments](https://vercel.com/products/previews) streamlined the Minnesota Star Tribune's development, fostering collaboration and iterative design, especially for complex graphic elements. The result was a fully responsive site with easier news navigation and a seamless cross-device experience.

**解决方案：** 明尼苏达州《明星论坛报》（Minnesota Star Tribune）携手 Code and Theory，采用 Next.js 与 Vercel 对其数字平台进行现代化升级。此举整合了其网页端与移动端的代码库，显著加快了部署速度；同时借助 Vercel 的重定向（redirects）功能，实现了更清晰、更灵活的内容架构重构。Vercel 的[预览部署功能](https://vercel.com/products/previews)极大简化了《明星论坛报》的开发流程，促进了跨团队协作与迭代式设计——尤其在处理复杂的图形化内容时效果突出。最终成果是一个完全响应式的网站，新闻导航更直观便捷，用户在各类设备间切换时体验无缝流畅。

**Results:** The update delivered a visually striking homepage with optimized story hierarchy and an enhanced photojournalism showcase. With the reimagined breaking news experience, they saw faster loading times across desktop and mobile, and improved accessibility for all users.

**成果：** 此次升级打造了一个视觉冲击力强的首页，故事层级结构经过优化，摄影新闻展示能力大幅提升。重构后的突发新闻体验，使桌面端与移动端的页面加载速度明显加快，同时全面提升了所有用户的可访问性（accessibility）。

- **Impressive conversion boost**: Reaching 30-50% of their monthly new subscriber goal within 24 hours of launch  
- **显著的转化率提升**：上线仅 24 小时内，即达成当月新增订阅用户目标的 30–50%

- **Repurposing of DevOps resources:** Reducing web DevOps from three people to one person, and shifting resources to other priority projects  
- **DevOps 资源再分配**：将网站 DevOps 团队从三人精简至一人，并将释放出的人力资源投入其他高优先级项目

- **Trusted availability**: Handling a major traffic spike during the VP pick announcement without even a blip on load times  
- **值得信赖的高可用性**：在副总统提名人选公布期间遭遇巨大流量高峰，系统负载时间未出现任何波动（“零抖动”）

- **Improved Core Web Vitals**: Significantly improving by 30%, with scores now ranging in the 80s-90s out of 100  
- **核心网页指标（Core Web Vitals）显著提升**：整体得分提高 30%，目前各项指标稳定在 80–90 分区间（满分 100 分）

## Key benefits of Next.js and Vercel for news organizations

## 新闻机构采用 Next.js 与 Vercel 的核心优势

Code and Theory prioritizes website performance and security as a top concern in every project, recognizing its impact on brand reputation. Leveraging Next.js and Vercel helps ensure that no matter the traffic surge (time, day, size, expected, or unexpected), readers will experience enhanced performance, accessing critical information instantly, without worrying about undifferentiated infrastructure.

Code and Theory 始终将网站性能与安全性列为每个项目的首要关切，深刻理解其对品牌声誉的深远影响。借助 Next.js 与 Vercel，无论流量激增发生在何时、何日、规模多大，亦无论是否可预期，读者均能享受更优性能体验——关键信息即时触达，无需操心底层基础设施的通用性与复杂性。

- **Speed:** Vercel's global edge network and built-in optimizations deliver lightning-fast website speeds, ensuring readers get the information they need instantly  
- **极致速度**：Vercel 全球边缘网络与内置优化机制协同发力，实现闪电般迅捷的网站加载速度，确保读者即刻获取所需信息

- [**Incremental Static Regeneration (ISR)**](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content) **:** Allows for updating static content without rebuilding the entire site—perfect for sites that need to frequently update content without compromising on performance  
- [**增量静态再生（ISR）**](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)：支持在不重建整个网站的前提下更新静态内容——特别适用于需高频刷新内容、又不能牺牲性能表现的新闻类网站

- **Automatic static optimization:** Next.js automatically determines which pages can be static and which need server-side rendering, crucial for sites that have a mix of static content (like evergreen articles) and dynamic content (like breaking news)

- **自动静态优化：** Next.js 自动判断哪些页面可静态化、哪些需服务端渲染，这对同时包含静态内容（如长青文章）和动态内容（如突发新闻）的网站至关重要。

- **Effortless scalability:** Vercel automatically scales to handle any traffic load, guaranteeing a smooth user experience even during peak demand

- **无缝弹性伸缩：** Vercel 自动按需扩展以应对任意流量负载，确保即使在流量高峰期间也能提供流畅的用户体验。

- **Reliability:** Vercel's serverless infrastructure eliminates the risk of downtime, ensuring news organizations can always reach their audience

- **高可靠性：** Vercel 的无服务器架构彻底消除了宕机风险，保障新闻机构始终能够触达其受众。

> “We have invested in creating an accelerator on Vercel’s Next.js as we have found the cycle time we are able to achieve in creating and iterating new features is a distinct advantage as compared to other software and platform combinations. I’ve never seen a company like Vercel that is so action-oriented and focused on helping product organizations ship features faster and allowing any organization to do more with less. We have invested in creating an accelerator on Vercel’s Next.js as we have found the cycle time we are able to achieve in creating and iterating new features is a distinct advantage as compared to other software and platform combinations. I’ve never seen a company like Vercel that is so action-oriented and focused on helping product organizations ship features faster and allowing any organization to do more with less. ”

> “我们已投入资源，在 Vercel 的 Next.js 平台上构建了一套加速器。实践表明，我们在新功能开发与迭代中所实现的周期时间，相较其他软件与平台组合具有显著优势。我从未见过像 Vercel 这样以行动为导向、如此专注于帮助产品团队更快交付功能，并赋能任何组织‘以更少资源成就更多成果’的公司。我们已投入资源，在 Vercel 的 Next.js 平台上构建了一套加速器。实践表明，我们在新功能开发与迭代中所实现的周期时间，相较其他软件与平台组合具有显著优势。我从未见过像 Vercel 这样以行动为导向、如此专注于帮助产品团队更快交付功能，并赋能任何组织‘以更少资源成就更多成果’的公司。”

> ![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_004.jpg)
>
> **Kenton Jacobsen,** Head of Engineering - Code and Theory

> **肯顿·雅各布森（Kenton Jacobsen），** 工程负责人 — Code and Theory

In the relentless race to break news, Code and Theory and Vercel are transforming news websites into digital platforms that withstand massive traffic surges, deliver instant loading times, and provide a highly-available experience. For RealClearPolitics and the Minnesota Star Tribune, the result is a more responsive, resilient, and reader-focused news ecosystem that allows them to better serve their audience and handle the demands of the election.

在争分夺秒发布新闻的激烈竞赛中，Code and Theory 与 Vercel 正携手将新闻网站重塑为数字平台——该平台可从容应对海量突发流量、实现毫秒级加载，并提供高度可用的用户体验。对 RealClearPolitics 和《明尼苏达星坛报》（Minnesota Star Tribune）而言，这一转型打造出了一个更敏捷、更具韧性、且以读者为中心的新闻生态系统，使其不仅能更优质地服务受众，更能从容应对大选期间的严苛挑战。

[**Looking to upgrade your infrastructure?**\\
\\
Connect with a Next.js expert and learn about Vercel's best-in-class tooling for site performance and org-wide collaboration.\\
\\
Contact us](https://vercel.com/contact)

[**是否正计划升级您的基础设施？**\\
\\
联系 Next.js 专家，深入了解 Vercel 行业领先的性能优化工具与面向全组织的协同协作方案。\\
\\
立即联系我们](https://vercel.com/contact)

Customer case study

客户案例研究

Jul 27, 2023

2023 年 7 月 27 日

### Engineering a site at the speed of breaking news

### 以“突发新闻”之速构建网站

![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_005.jpg)

Greta Workman

博客文章

2024年9月16日

### ISR：一种灵活的动态内容缓存方式

![](images/how-code-and-theory-and-vercel-ensure-speed-and-reliability-for-news-organizatio/img_006.jpg)

Alice Alexandra Moore