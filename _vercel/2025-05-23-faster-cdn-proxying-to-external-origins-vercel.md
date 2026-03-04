---
render_with_liquid: false
title: "Faster CDN proxying to external origins - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/faster-cdn-proxying-to-external-origins"
date: "2025-05-23"
scraped_at: "2026-03-02T09:33:07.151536076+00:00"
language: "en-zh"
translated: true
description: "Vercel’s upgraded CDN connection pooling speeds up proxying to external backends by up to 60%, cutting latency for both low-traffic and high-traffic apps."
---
render_with_liquid: false
render_with_liquid: false

May 23, 2025

2025 年 5 月 23 日

We’ve optimized connection pooling in our CDN to reduce latency when connecting to external backends, regardless of traffic volume.

我们已优化 CDN 中的连接池机制，以降低连接至外部后端时的延迟，且该优化效果不受流量规模影响。

- **Lower latency**: Improved connection reuse and TLS session resumption reduce response times by up to 60% in some regions, with a 15–30% average improvement.

- **更低的延迟**：改进的连接复用与 TLS 会话恢复机制，在部分区域将响应时间最多缩短 60%，平均降幅达 15–30%。

- **Reduced origin load**: 97% connection reuse and more efficient TLS resumption significantly cut the number of new handshakes required.

- **减轻源站负载**：97% 的连接复用率，叠加更高效的 TLS 会话恢复，大幅减少了所需的新握手次数。

This is now live across all Vercel deployments at no additional cost.

此项优化现已在所有 Vercel 部署中全面上线，且无需额外费用。