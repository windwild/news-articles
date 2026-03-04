---
title: "Building a viral application to visualize train routes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-a-viral-application-to-visualize-train-routes"
date: "2022-09-10"
scraped_at: "2026-03-02T10:00:38.089768708+00:00"
language: "en-zh"
translated: true
description: "How Benjamin Td built a viral application called Chronotrains to visualize train routes across Europe."
---
&#123;% raw %}

Sep 10, 2022

2022 年 9 月 10 日

当灵感迸发时，[Benjamin Td](https://twitter.com/_benjamintd) 决定可视化欧洲各地的火车线路图。他随即在 Vercel 上用 Next.js 创建了一个应用——整个过程就发生在他灵光乍现的那一刻。令他惊讶的是，这个项目最终获得了超过一百万次浏览量，登顶 Hacker News，并在 Twitter 上迅速走红。

## Scale to vacation  
## 扩展至度假模式

Chronotrains 上线后不久，Benjamin 就启程去度假了。[项目随即爆火](https://twitter.com/_benjamintd/status/1552983329116504064)。而得益于 [Vercel 上的 Next.js](https://vercel.com/solutions/nextjs)，他得以安心享受假期，无需操心任何技术运维问题。

> “我发布了 Chronotrains，然后就去度假了。等我回来时，网站访问量已突破百万。政界人士和多家报纸纷纷引用该网站；它更在多种语言中引发了关于基础设施、公共政策、绿色交通以及铁路服务质量的广泛讨论。我自始至终都不必操心负载压力或响应延迟。”  
>  
> ![](images/building-a-viral-application-to-visualize-train-routes-vercel/img_001.jpg)  
>  
> **Benjamin Td**

Benjamin 的项目名为 [Chronotrains](https://www.chronotrains.com/) —— 一张交互式地图，展示从欧洲任一火车站出发、在 5 小时内所能抵达的最远范围。Benjamin 明白，自己需要一种便捷的方式将全栈应用快速上线，尤其要支持部署可缓存火车线路数据的 API 路由（API Routes），因此他选择了 Vercel 上的 Next.js。

## How Chronotrains works  
## Chronotrains 的工作原理

用户在 Chronotrains 地图上每一次鼠标移动，都会触发一次网络请求，以获取当前悬停车站所对应的地理几何图形（geometries）。Benjamin 利用部署在 Vercel 上的 Next.js API 路由（即 Vercel Functions），轻松地将“等时线”（isochrone）计算结果缓存在 Vercel 的边缘网络（Edge Network）上——此举既优化了响应时间，又确保了用户体验的流畅无缝。  
[相关缓存代码示例](https://github.com/benjamintd/chronotrains/blob/fe9cca3915b9236a2b3d00989acbb799163bcb58/src/pages/api/stations.ts#L47-L48)

![使用 Chronotrains 可视化不同火车线路组合。](images/building-a-viral-application-to-visualize-train-routes-vercel/img_002.jpg)  
使用 Chronotrains 可视化不同火车线路组合。

所有地理几何图形均通过预计算脚本生成，这些脚本用于测算不同车站两两之间的行程耗时。由此构建出一张覆盖 1 至 5 小时行程时长范围内、所有可能列车行程路径的图谱（graph）。这些计算结果被存储于由 [Supabase](https://vercel.com/integrations/supabase) 托管的 PostgreSQL 数据库中。

Chronotrains also takes advantage of [Incremental Static Regeneration](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration) to help reduce the load on the Postgres database. This helped Chrontrains scale even when there were thousands of visitors viewing the site at the same time. With this architecture, there was at most one request per station per day. Benjamin could make updates to the database peacefully without worrying about scaling the frontend.

Chronotrains 还充分利用了[增量静态再生（Incremental Static Regeneration）](https://vercel.com/docs/concepts/next.js/incremental-static-regeneration)，以减轻 PostgreSQL 数据库的负载。这一策略使 Chronotrains 即便在同时有数千名用户访问网站时，依然能够稳定扩展。借助该架构，每个车站每天最多仅需处理一次请求。Benjamin 可以从容地更新数据库，而无需担忧前端的扩展问题。

> “I’ve been a Vercel user for years and really love the platform. Vercel makes it easy for me to start new projects and scale them with ease. This helps me validate ideas quickly.I’ve been a Vercel user for years and really love the platform. Vercel makes it easy for me to start new projects and scale them with ease. This helps me validate ideas quickly.”
>
> “多年来我一直是 Vercel 的用户，非常喜爱这个平台。Vercel 让我能够轻松启动新项目，并便捷地实现规模扩展，从而快速验证创意。”

> ![](images/building-a-viral-application-to-visualize-train-routes-vercel/img_001.jpg)
>
> ![](images/building-a-viral-application-to-visualize-train-routes-vercel/img_001.jpg)

> **Benjamin Td**

> **Benjamin Td**

The code for Chronotains is now [open source](https://github.com/benjamintd/chronotrains). [Check out the site](https://www.chronotrains.com/) and [follow Benjamin](https://twitter.com/_benjamintd) for more updates.

Chronotrains 的源代码现已[开源](https://github.com/benjamintd/chronotrains)。欢迎[访问网站](https://www.chronotrains.com/)，或[关注 Benjamin](https://twitter.com/_benjamintd) 获取更多动态更新。
&#123;% endraw %}
