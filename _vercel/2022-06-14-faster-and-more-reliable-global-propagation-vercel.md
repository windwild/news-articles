---
title: "Faster and more reliable global propagation - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-and-more-reliable-global-propagation"
date: "2022-06-14"
scraped_at: "2026-03-02T10:01:51.748369114+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Jun 14, 2022

2022 年 6 月 14 日

![](images/faster-and-more-reliable-global-propagation-vercel/img_001.jpg)![](images/faster-and-more-reliable-global-propagation-vercel/img_002.jpg)

We've upgraded our infrastructure resulting in significant performance and reliability improvements for all plans. Vercel's Edge infrastructure is now **70% faster at p99** for cache purges and configuration updates, serving over 25B requests per week.

我们已全面升级基础设施，为所有套餐带来显著的性能与可靠性提升。Vercel 的边缘网络（Edge）基础设施在缓存清除（cache purges）和配置更新方面的第 99 百分位延迟（p99）**降低了 70%**，目前每周处理请求量超过 250 亿次。

Purges now **propagate globally in ~300ms,** regardless of the region the event originated from. These improvements impact all parts of the Vercel platform:

缓存清除操作如今**可在约 300 毫秒内完成全球传播**，且不受事件发起区域的影响。上述优化惠及 Vercel 平台的全部功能模块：

- 更快的生产环境发布（Faster production rollouts）  
- 更快的域名绑定（Faster domain assignments）（例如：在全球范围内快速切换至最新部署）  
- 更快的项目设置变更（Faster project settings changes）（例如：快速启用或关闭[密码保护](https://vercel.com/support/articles/how-do-i-add-password-protection-to-my-vercel-deployment)）  
- 更快的[增量静态再生](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration)（ISR）传播（Faster [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) (ISR) propagation）

[Deploy now](https://vercel.com/templates) to try our improved infrastructure.

[立即部署](https://vercel.com/templates)，体验我们升级后的基础设施。