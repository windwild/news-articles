---
title: "How Vercel helps mmm.page manage over 30,000 sites - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-helps-mmm-page-manage-over-30-000-custom-domains"
date: "2023-04-07"
scraped_at: "2026-03-02T09:53:37.240330732+00:00"
language: "en-zh"
translated: true
description: "mmm.page "
---
&#123;% raw %}

2023年4月7日

2023年4月7日

[mmm.page](https://mmm.page/) 成立的初衷是为所有人提供构建个人网站所需的工具，无论其技术背景如何。平台上线后迅速获得早期成功；然而，随着用户规模增长至数万人，将整个平台作为单页应用（SPA）托管在 Amazon Simple Storage Service（Amazon **S3**）上，已变得难以为继。因此，他们转向了 Vercel。得益于 [服务端渲染（SSR）](https://vercel.com/docs/concepts/next.js/overview#server-side-rendering-ssr)、简易的部署流程，以及对自定义域名的原生支持，Vercel 让 mmm.page 能轻松应对规模化增长、实现产品变现，并持续推动创新。

> “Vercel 消除了大量细微摩擦，让我们得以加速前进。Vercel 消除了大量细微摩擦，让我们得以加速前进。”
>
> ![](images/how-vercel-helps-mmm_page-manage-over-30_000-sites-vercel/img_001.png)
>
> **XH 创始人**

mmm.page 的核心使命，是通过赋能那些从未想过自己也能建站的普通人，快速、轻松地创建专属网站，从而让互联网生态更加多元、减少同质化。截至目前，已有超过 30,000 名用户在 mmm.page 平台上创建了自己的网站——这一数字仍在持续攀升。

mmm.page 最初上线时采用的是部署在 Amazon S3 上的单页应用（SPA）。但他们很快意识到：Amazon S3 在搜索引擎优化（SEO）方面表现不佳，平台也难以随用户增长而弹性扩展。此外，在 S3 上配置自定义域名十分困难，而生成 [预览 URL（Preview URLs）](https://vercel.com/docs/concepts/deployments/generated-urls) 则既耗时又繁琐。最终，他们决定将“查看器”（viewer）体验重构为基于 Vercel 的服务端 Next.js 应用，而“编辑器”（editor）体验则仍保留在 Amazon S3 上（不过他们也在考虑未来将编辑器一并迁移至 Vercel）。

[**立即开始使用预览部署（Preview Deployments）** 向团队成员及受邀协作者收集您预览部署的反馈意见。](https://vercel.com/docs/concepts/deployments/comments)

“Vercel 对 [自定义域名](https://vercel.com/docs/concepts/get-started/assign-domain) 的支持堪称雪中送炭，”XH 表示，“这类配置向来以复杂著称，而 Vercel 却让我能快速完成设置。**这使我得以更快地面向用户群体实现商业化变现；若采用传统方式，仅配置 [SSL 证书生成](https://vercel.com/docs/concepts/projects/domains/custom-SSL-certificate) 就可能耗费数月时间。**”

[**试用域名 API 模板（Domains API Template）** 借助 Vercel 的域名 API，以编程方式为您在 Vercel 项目中的平台动态添加或移除域名。](https://vercel.com/templates/next.js/domains-api)

[核心网页指标（Core Web Vitals）](https://vercel.com/docs/concepts/analytics/web-vitals#core-web-vitals) 也始终是 mmm.page 关注的重点。其用户习惯于高性能网站，对任何延迟都极为敏感——一旦自己的网站出现卡顿或 Bug，就很可能转投其他平台。而服务端渲染（SSR）确保了：当需要更新用户站点内容时，不会引入额外的加载延迟。

随着 mmm.page 不断发展壮大，他们尤为欣赏 Vercel 提供的缓存能力——可将数据库调用次数减少 2–3 倍，从而避免数据库过载。“如今我们采用了混合架构：一部分采用 SSR，另一部分则实时获取动态数据。只要我推送新的查看器版本，或更新数据结构（schema），就能批量刷新缓存。”XH 解释道。

With Vercel, mmm.page is able to quickly spin up new features, meet the needs of their users, and scale along with them.

借助 Vercel，mmm.page 能够快速上线新功能、满足用户需求，并随用户增长而无缝扩展。

Would your team's platform benefit from faster iterations and seamless scaling? [Get in touch](https://vercel.com/contact/sales).

您的团队平台是否也能从更快的迭代速度和无缝扩展能力中获益？[联系我们](https://vercel.com/contact/sales)
&#123;% endraw %}
