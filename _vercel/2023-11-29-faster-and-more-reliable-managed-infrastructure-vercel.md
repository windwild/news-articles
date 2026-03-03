---
title: "Faster and more reliable Managed Infrastructure - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-and-more-reliable-managed-infrastructure"
date: "2023-11-29"
scraped_at: "2026-03-02T09:49:20.741247586+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

2023年11月29日

2023年11月29日

![](images/faster-and-more-reliable-managed-infrastructure-vercel/img_001.jpg)![](images/faster-and-more-reliable-managed-infrastructure-vercel/img_002.jpg)

我们已全面升级 [托管基础设施（Managed Infrastructure）](https://vercel.com/docs/infrastructure)，使 p99 延迟下的路由速度最高提升 **45%**，并显著提升了所有服务计划的可靠性。

当用户向一个由 Vercel 托管的网站发起请求时，流量将通过我们的 [任播路由（Anycast routing）](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure) 被自动导向地理上最近的边缘网络（Edge Network）区域。Vercel 随即处理该请求，识别出应服务的具体部署（deployment），并即时获取与该部署相关的元数据。

如今，得益于优化后的元数据获取机制与路由逻辑，这一性能提升惠及所有类型的工作负载。随后，系统将根据部署元数据中提供的路由信息，从存储中获取静态资源的响应，或通过 Vercel Functions 动态生成内容。

此次基础设施升级惠及所有现有及新建的部署。[立即部署](https://vercel.com/templates)，或进一步了解 [Vercel 托管基础设施](https://vercel.com/blog/behind-the-scenes-of-vercels-infrastructure) 的技术细节。