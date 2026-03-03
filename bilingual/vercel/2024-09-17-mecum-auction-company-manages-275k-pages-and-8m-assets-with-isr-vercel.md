---
title: "Mecum Auction Company manages 275K pages and 8M assets with ISR - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/managing-275-thousand-pages-and-8-million-assets-with-isr"
date: "2024-09-17"
scraped_at: "2026-03-02T09:41:32.271069147+00:00"
language: "en-zh"
translated: true
description: "Content-heavy websites don't need to suffer from long build times. With Incremental Static Regeneration (ISR), Mecum Auction Company handles 8M digital assets and 275K pages, while improving performan..."
---

Sep 17, 2024

2024年9月17日

数字代理机构 Americaneagle.com 如何助力 Mecum 拍卖公司重塑其数字形象，实现年页面浏览量超 1.2 亿次。

#### 120M+

年页面浏览量

#### 8M+

数字资产

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

作为全球领先的线下汽车拍卖企业，[Mecum 拍卖公司](https://www.mecum.com/)已成功售出世界上一些最著名的车辆。尽管其数字平台多年来持续演进并表现稳健，但已逐渐逼近性能瓶颈，严重制约了新车源 listings 的快速创建能力。在数字代理机构 [Americaneagle.com](https://www.americaneagle.com/) 的协助下，Mecum 采用了一套全新的、可组合（composable）的技术栈——由此获得充分信心：其网站将兼具高速响应、卓越性能与高度可靠性。

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_001.jpg)

### **对可扩展性、速度及更多能力的迫切需求**

### **可扩展性、速度及其他能力需求**

The Mecum ecosystem manages the auction process on a massive scale, especially during their two-day auction events held twice a year.  
梅卡姆（Mecum）生态系统以超大规模管理拍卖流程，尤其在其每年举办两次的为期两天的大型拍卖活动中。

The inventory includes 8 million assets—ranging from cars to trucks—spread across 275,000 individual listing pages or "lots", with hundreds of updates made daily, attracting over 120 million views annually.  
其库存涵盖800万项资产——从轿车到卡车不等——分布于275,000个独立商品列表页（即“拍品”），每日更新数百次，年浏览量逾1.2亿次。

Overall, Mecum set out to redesign their entire digital platform so that it would enable their teams to automatically generate pages, update and create content without the help of IT, and provide faster digital experiences for their end users.  
总体而言，梅卡姆旨在全面重构其数字平台，使其能够支持团队自动生成功能页面、在无需IT部门协助的情况下自主更新与创建内容，并为终端用户提供更迅捷的数字化体验。

### **The solutions that make up the architecture**  
### **构成该架构的各项解决方案**

Americaneagle.com designed an architecture that would scale and grow with Mecum, while delivering speed and performance. Going headless allowed the team to keep the foundational layers of their system the same, while creating a composable layer that would deliver the flexibility and user experience the team required.  
Americaneagle.com 为梅卡姆设计了一套可随业务同步扩展与演进的架构，在保障速度与性能的同时，实现了高度可伸缩性。采用“无头架构”（headless architecture）使团队得以保留系统底层基础架构不变，同时构建出一个可组合（composable）的上层，从而满足团队对灵活性与用户体验的严苛要求。

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_002.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_003.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_004.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_005.jpg)

**Dataflow and content management:** The architecture begins with Salesforce as the primary data source. It pushes data into both WordPress and Algolia, creating a foundation for content management and search capabilities.  
**数据流与内容管理：** 该架构以 Salesforce 作为核心数据源，将数据同步推送至 WordPress 和 Algolia，由此构建起内容管理与搜索功能的基础支撑体系。

- Algolia powers the search experience and provides intelligent recommendations for lots, enhancing user engagement and discovery.  
  - Algolia 驱动全站搜索体验，并为各拍品提供智能推荐，显著提升用户参与度与内容发现效率。

- WordPress serves as the central Content Management System (CMS), handling both marketing content pages and enrichment for individual lot pages. This allows Mecum's marketing team to create and manage content efficiently without IT intervention.  
  - WordPress 充当统一的内容管理系统（CMS），既负责营销类内容页面，也承担单个拍品页面的信息增强（enrichment）任务。这使得梅卡姆的市场营销团队可在无需IT介入的前提下，高效完成内容的创建与管理工作。

- Marketing teams can independently launch new content and campaigns much quicker.  
  - 市场营销团队可完全自主、更快速地发布新内容与营销活动。

There is no need to leave the CMS environment, streamlining the content creation process and bringing flexibility to update and create content without additional support.  
整个流程均在CMS环境中完成，无需切换系统，大幅简化了内容创作流程，并赋予团队在无需额外技术支持的情况下灵活更新与创建内容的能力。

**Vercel 和增量静态再生（ISR）：**  
**Vercel 与增量静态再生（ISR）：**  
Mecum 内容发布速度战略的核心是 Vercel 的前端云（Frontend Cloud），它负责托管全部页面，并为拍品页面（lot pages）实现增量静态再生（ISR）。

- ISR 是 Mecum 内容战略的核心。与其预先生成全部 275,000 个拍品页面（这一过程耗时且资源密集），不如采用按需生成策略——即用户请求某拍品页面时，系统才实时生成该页面。

- 拍品页面一旦生成，即被缓存；后续用户访问时直接提供缓存版本，无需重复生成，从而显著提升性能并降低服务器负载。

- ISR 支持设置重新验证周期（revalidation period）：当周期结束后，下一次用户请求将触发后台自动再生页面。该机制确保车辆信息持续保持最新，同时完全不影响用户体验。

团队选择 WordPress 作为其内容管理系统（CMS），主要因其灵活性、出色的内容创作体验，以及 WordPress 与 Vercel 的[良好集成能力](https://vercel.com/guides/wordpress-with-vercel)。在 WordPress 中制定好设计策略后，团队高效复用预定义的结构化组件；营销团队现可从 50 多个自定义组件中自由组合，快速搭建各类页面布局。如今，他们无需离开 CMS，即可独立、快速地上线新内容与营销活动。

> “我们的全新网站标志着 Mecum 数字化转型迈入下一阶段。Mecum.com 是一个持续演进的数字平台，我们在此精心打造卓越的数字化用户体验。我们无比期待见证这一数字体验在未来数年中不断深化与成长。”  
> “我们的全新网站标志着 Mecum 数字化转型迈入下一阶段。Mecum.com 是一个持续演进的数字平台，我们在此精心打造卓越的数字化用户体验。我们无比期待见证这一数字体验在未来数年中不断深化与成长。”  
>   
> ![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_006.jpg)  
>   
> **Cade Canon**，Mecum 拍卖公司 IT 总监

通过重构其数字平台，Mecum 在内容管理与交付效率方面实现了显著提升。Vercel 前端云使各团队能够自主创建和更新内容，不再依赖 IT 部门支持，从而得以专注于为买家打造极致的拍卖体验。

Mecum 全新的数字平台充分印证：战略性技术选型不仅能驱动效率与可扩展性，更能始终以最佳用户体验为优先目标。

[**迈出技术栈现代化的第一步**  
与专家交流，了解如何借助 Vercel 让您的网站更快、更可靠。  
联系销售](https://vercel.com/contact/sales)

博客文章

Feb 27, 2023

2023年2月27日

### Your guide to headless commerce

### 无头电商入门指南

![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_007.jpg)![](images/mecum-auction-company-manages-275k-pages-and-8m-assets-with-isr-vercel/img_008.jpg)

Kiana and Peter

Kiana 和 Peter

Vercel.com landing page

Vercel.com 官网着陆页

### The managed, global rendering layer for modern web applications

### 面向现代 Web 应用的托管式全球渲染层