---
render_with_liquid: false
title: "How Vercel helped this popular health database increase free trials by 284% - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/examine"
date: "2023-07-25"
scraped_at: "2026-03-02T09:51:43.628430243+00:00"
language: "en-zh"
translated: true
description: "Examine"
---
render_with_liquid: false
render_with_liquid: false

Jul 25, 2023

2023 年 7 月 25 日

Examine 公司的开发团队借助 Frontend Cloud 显著提升了页面加载速度、构建速度以及开发工作流效率。

#### 90%

构建时间减少 90%

#### 284%

创建的试用实例数量增长 284%

[Talk to an Expert](https://vercel.com/contact/sales)

[联系专家](https://vercel.com/contact/sales)

# Products Used

# 使用的产品

Preview Deployments

预览部署

Next.js

Next.js

ISR

ISR（增量静态再生）

Integrations

集成

Comments

评论

[Examine](https://examine.com/) 是全球规模最大的营养与膳食补充剂研究数据库——以严谨的科学数据赋能用户，助其做出更健康的生活选择。

在采用 Vercel 前端云之前，Examine 这支仅五人的开发团队深陷技术债务泥潭，根源在于其单体架构（monolithic architecture）的设计。

构建流程中哪怕最微小的改动，都会给 Examine 团队带来挫败感和瓶颈。他们在动态页面与缓存策略之间始终难以取得平衡；此外，发布流程缓慢而繁重：每次更新都需要先通过 Shell 脚本将新版本部署至服务器，再手动更新数据库——一旦涉及数据变更，就必须执行这一步骤。这种低效模式既损害了 Examine 用户的体验（他们期待信息即时可得），也拖累了开发者的创造力（他们几乎无暇投入新功能开发）。

“所有东西都是用胶带临时粘起来的。” Examine 首席开发工程师 Jernon Magcalas 如此形容道。

## 迁移至 Vercel，收获可衡量的成果

自迁移到 Vercel 并采用 [Next.js](https://vercel.com/solutions/nextjs) 后，Examine 的构建时间从原先的 15–20 分钟大幅缩短至每次仅需 1–2 分钟。通过解耦前端与后端，团队在基础设施上的投入时间与资源显著减少，同时为全美用户提供了更优的访问速度与整体性能。

仅仅数月之后，得益于 Vercel 上优化后的技术栈，Examine 的免费试用注册量激增 284%。

> “By using Next.js, we spend less effort in making the pages dynamic and use fewer resources by dynamically loading content. The prefetching is also great to make our pages much faster. By using Next.js, we spend less effort in making the pages dynamic and use fewer resources by dynamically loading content. The prefetching is also great to make our pages much faster.”  
>   
> “借助 Next.js，我们能以更少的开发投入实现页面动态化，并通过按需动态加载内容显著降低资源消耗。此外，预取（prefetching）机制也极大提升了页面加载速度。”

> ![](images/how-vercel-helped-this-popular-health-database-increase-free-trials-by-284-verce/img_001.png)  
>   
> ![](images/how-vercel-helped-this-popular-health-database-increase-free-trials-by-284-verce/img_001.png)

> **Jernon Magcalas,** Lead Developer  
>   
> **杰农·马格卡拉斯（Jernon Magcalas）**，首席开发工程师

The team credits this increase to:  
团队将此次增长归功于以下几方面：

- **Page load times:** With Vercel’s [incremental static regeneration](https://vercel.com/docs/concepts/incremental-static-regeneration), [server-side rendering](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr), and static site generation, page load times have improved drastically—giving their end users a much improved experience. And going headless has even given Magcalas’s team the time and ability to plan for future projects, like developing a mobile app.  
- **页面加载速度：** 借助 Vercel 提供的[增量静态再生（ISR）](https://vercel.com/docs/concepts/incremental-static-regeneration)、[服务端渲染（SSR）](https://vercel.com/docs/frameworks/nextjs#server-side-rendering-ssr)以及静态站点生成（SSG）能力，页面加载时间大幅缩短——为终端用户带来了显著优化的浏览体验。同时，采用无头架构（headless architecture）还为马格卡拉斯团队腾出了宝贵时间与技术空间，使其得以从容规划未来项目，例如开发移动应用。

- **Developer workflow:** Examine’s developers experience streamlined collaboration by using Vercel [Preview Deployments](https://vercel.com/docs/concepts/deployments/preview-deployments). They can review, leave feedback, and deploy site improvements faster. They're also able to use integrations they know and love, like Sentry.  
- **开发者工作流：** Examine 的开发团队通过使用 Vercel 的[预览部署（Preview Deployments）](https://vercel.com/docs/concepts/deployments/preview-deployments)实现了更高效协同。他们可快速完成代码审查、反馈提交及网站功能更新的上线部署；同时还能继续沿用其熟悉且喜爱的第三方集成工具，例如 Sentry。

- **Build times:** Magcalas also noted that users are saying the site feels “more snappy.” And his team feels it, too—they’re developing faster than ever and build times have decreased by 90%.  
- **构建耗时：** 马格卡拉斯还指出，用户普遍反馈网站“响应更灵敏、更迅捷”。他的团队亦有同感——当前开发效率达到历史最高水平，构建耗时更是降低了 90%。

- **Project size:** What’s more, the previous version of Examine was 1,559,255 lines of code. The new site is 189,844 lines for both backend and frontend. “In other words: there’s a lot less configuration for us and a lot more speed for our users,” says Magcalas.  
- **项目规模：** 更值得一提的是，Examine 旧版代码总量高达 1,559,255 行；而新版网站（含前后端）仅需 189,844 行代码。“换言之：我们需要配置的内容大幅减少，而用户所获得的速度体验则大幅提升。”马格卡拉斯表示。

Magcalas is excited to see what the future will bring for Examine and the health industry: “I'm confident we're still just barely scraping the potential. I expect these numbers will continue improving as we put more energy into customer success and personalization.”  
马格卡拉斯对 Examine 及整个健康行业未来的发展充满期待：“我坚信，我们目前仅触及了潜力的冰山一角。随着我们将更多精力投入客户成功（customer success）与个性化体验建设，上述各项指标必将持续向好。”

[**Ready to redefine your digital experiences with Vercel?**  
**准备好借助 Vercel 重塑您的数字体验了吗？**  

If you're curious about how Vercel can uplift your team's specific use case, our experts are ready for a conversation.  
若您想了解 Vercel 如何助力您团队的具体应用场景，我们的专家已随时准备与您深入交流。  

Let's Talk  
立即交流](https://vercel.com/contact/sales)