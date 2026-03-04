---
title: "How Ruggable optimized their frontend architecture - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-ruggable-saw-more-organic-clicks-by-optimizing-their-frontend"
date: "2024-04-08"
scraped_at: "2026-03-02T09:46:02.383758563+00:00"
language: "en-zh"
translated: true
description: "Ruggable improved organic search traffic by 300% by migrating their ecommerce storefront from a Shopify monolith to a headless solution on Next.js and Vercel."
---
{% raw %}

Apr 8, 2024

2024 年 4 月 8 日

Transitioning to a headless architecture helped Ruggable improve developer experience and performance.

采用无头架构帮助 Ruggable 提升了开发者体验与网站性能。

#### 75%

Increase in search rankings

#### 75%

搜索排名提升幅度

#### 40%

Faster site speed

#### 40%

网站加载速度提升幅度

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Next.js

Next.js

Integrations

集成

# Preview Deployments

# 预览部署

Ecommerce brands today face immense pressure to stay agile and innovate continuously. Recognizing the need to optimize site performance, enhance SEO, boost conversions, and improve developer experience, Ruggable, a leading online rug retailer, embarked on a digital transformation with Vercel and Contentful.

如今，电商品牌面临巨大压力，必须保持敏捷性并持续创新。为应对网站性能优化、SEO 提升、转化率增长以及开发者体验改善等关键需求，领先在线地毯零售商 Ruggable 联合 Vercel 与 Contentful 启动了数字化转型。

![](images/how-ruggable-optimized-their-frontend-architecture-vercel/img_001.jpg)

![](images/how-ruggable-optimized-their-frontend-architecture-vercel/img_001.jpg)

Historically, Ruggable relied on a setup that was difficult to scale, with a custom Shopify theme built using Liquid and Slate. However, the setup limited the team's ability to adapt swiftly to market demands. With dependencies on Shopify apps and integrations for third-party functionalities, Ruggable faced challenges in delivering exceptional user experiences and maintaining competitive edge.

长期以来，Ruggable 依赖一套难以扩展的技术架构——基于 Liquid 和 Slate 构建的定制化 Shopify 主题。然而，该架构严重制约了团队快速响应市场需求的能力。由于深度依赖 Shopify 应用及第三方功能集成，Ruggable 在提供卓越用户体验和维持竞争优势方面举步维艰。

## **Moving beyond Shopify Liquid**

## **突破 Shopify Liquid 的局限**

In March 2023, Ruggable launched the headless version of [Ruggable.com](http://ruggable.com/), powered by Vercel and Contentful. The migration involved moving from Shopify Liquid to a fully custom headless setup, enabling a composable approach to their ecommerce storefront.

2023 年 3 月，Ruggable 借助 Vercel 与 Contentful 正式上线了 [Ruggable.com](http://ruggable.com/) 的无头（headless）版本。此次迁移标志着其从前端紧耦合的 Shopify Liquid 架构，全面转向高度定制化的无头架构，从而为其电商平台实现了可组合（composable）的前端构建方式。

The team’s decision to move to a headless architecture was driven by several pain points:

团队决定采用无头架构，主要源于以下几项亟待解决的痛点：

- Slow page load speed  
- 页面加载速度缓慢  

- Low accessibility scores  
- 可访问性（Accessibility）评分偏低  

- Lengthy build times  
- 构建耗时过长

- Overburdened tech teams

- 技术团队负担过重

- SEO penalties due to slow and unresponsive pages

- 因页面加载缓慢、响应迟滞而遭受的 SEO 惩罚


## **Faster teams and faster sites since Vercel**

## **自采用 Vercel 以来，团队更高效，网站更快捷**

Ruggable's transition to a headless architecture enabled the team to optimize site performance, enhance SEO, drive conversions, and elevate developer experience. The migration also played a pivotal role in facilitating team creativity and speed, ultimately leading to Ruggable's success in achieving zero downtime during Black Friday and delivering significant business impact.

Ruggable 转向无头架构（headless architecture）后，团队得以优化网站性能、提升 SEO 效果、促进转化率增长，并显著改善开发者体验。此次迁移还在激发团队创造力与提升开发速度方面发挥了关键作用，最终助力 Ruggable 在黑色星期五期间实现零宕机，并带来显著的业务成效。

Overall the team saw:

整体来看，团队观察到以下成果：

- SEO rankings improved by 75%

- SEO 排名提升 75%

- 40% faster site speed

- 网站加载速度提升 40%

- 300% increase in unbranded search clicks

- 无品牌关键词搜索点击量增长 300%


[**Your metrics, better with Vercel.**\\
\\
Our team obsesses over performance. We'll help you find opportunities to improve your application's Core Web Vitals.\\
\\

[**您的各项指标，在 Vercel 上更出色。**\\
\\
我们的团队对性能精益求精。我们将协助您发掘优化应用核心网页指标（Core Web Vitals）的机会。\\
\\

These substantial improvements to their frontend performance were due to a few key aspects in the new architecture:

这些前端性能的显著提升，源于新架构中的若干关键设计：

- **Content modeling with Contentful:** All copy and images were modeled in Contentful, enabling support for multiple languages in various locales.  
- **使用 Contentful 进行内容建模：** 所有文案和图片均在 Contentful 中完成结构化建模，从而支持多种语言在不同地区（locales）的本地化需求。

- **Unified tech stack:** Internal, operations, and ecomm teams now use React and Next.js for all development, streamlining processes and improving efficiency. They also integrate with Shopify for the things it's good at: checkout, payments, and order management.  
- **统一的技术栈：** 内部团队、运营团队与电商（ecomm）团队现已全面采用 React 和 Next.js 进行开发，大幅简化流程并提升效率；同时，通过与 Shopify 深度集成，充分发挥其在结账、支付及订单管理等核心环节的优势。

- **Marketing empowerment:** Promotions, landing pages, and launches now take hours instead of weeks thanks to Contentful's ease of use. Marketing can confidently make site changes without developer resources, knowing that their modifications won't break the site or take it down.  
- **赋能市场营销：** 得益于 Contentful 的易用性，促销活动、落地页与新品发布现在仅需数小时即可上线，而非以往的数周。市场团队无需依赖开发资源，即可自主、安全地修改网站内容，且完全不必担心改动会导致网站崩溃或宕机。

- **Developer productivity:** By creating workflows for previewing and QAing new features without the need to publish an entire theme, development cycles accelerated rapidly.  
- **开发者生产力提升：** 通过构建无需发布整套主题即可预览与测试新功能的工作流，开发周期得以显著加速。

- **Reliability and scalability:** Achieved 100% uptime during peak seasons like Black Friday and Cyber Monday, with zero tech issues or downtime.  
- **可靠性与可扩展性：** 在“黑色星期五”和“网络星期一”等销售高峰期实现 100% 正常运行时间，全程零技术故障、零宕机。

- **International expansion:** Leveraged the unified content model to launch multiple domains in various countries with localized content and translations.  
- **国际化拓展：** 借助统一的内容模型，快速在多个国家上线多个本地化域名，并同步提供适配当地语言与文化的内容及翻译。

## **Looking ahead for Ruggable**  
## **Ruggable 的未来展望**

Ruggable's transition to a headless architecture with Vercel has resulted in significant improvements in site performance, scalability, and customer experience, positioning the company for continued growth and innovation in the competitive ecommerce landscape.  
Ruggable 迁移至基于 Vercel 的无头架构后，网站性能、可扩展性与客户体验均获得显著提升，为其在竞争激烈的电商格局中持续增长与创新奠定了坚实基础。

Now, the team at Ruggable is planning to build on their success by further improving initial page load using SSG and `next/font`, and measuring their improvements with real customer data surfaced by Vercel Insights.  
目前，Ruggable 团队正计划在此成功基础上更进一步：利用静态站点生成（SSG）与 `next/font` 进一步优化首屏加载性能，并借助 Vercel Insights 提供的真实用户数据来量化各项改进效果。

Additionally, they're aiming to roll out a customer data platform to bolster customer insights initiatives and drive better segmentation and on-site personalization. The goal is to create hyper-personalized customer journeys with AI-augmented content, recommendations, and tailored decorating and design advice using customer input.  
此外，团队还计划部署客户数据平台（CDP），以强化客户洞察能力，推动更精准的用户分群与站内个性化体验。最终目标是：依托客户输入数据，结合 AI 增强的内容生成、智能推荐，以及量身定制的家居装饰与设计建议，打造高度个性化的客户旅程。

[**The next step in your journey.**  
**您旅程的下一步。**

If you need expert guidance on your exact codebase, our experts can help you plan the perfect migration, starting with a small proof of concept.  
如果您需要针对您具体代码库的专业指导，我们的专家可协助您规划最理想的迁移方案——从一个小型概念验证（Proof of Concept）开始。

[Contact Us](https://vercel.com/solutions/composable-commerce/migration)  
[联系我们](https://vercel.com/solutions/composable-commerce/migration)
{% endraw %}
