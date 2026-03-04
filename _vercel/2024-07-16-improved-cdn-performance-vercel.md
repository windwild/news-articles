---
title: "Improved CDN Performance - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-cdn-performance"
date: "2024-07-16"
scraped_at: "2026-03-02T09:43:04.503041353+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Jul 16, 2024

2024 年 7 月 16 日

We've improved our [**Edge Network**](https://vercel.com/docs/edge-network/overview) performance by increasing the initial TCP congestion window by 300%. This enhancement allows sending more data in the initial and subsequent round-trips, resulting in faster page loads for websites of all sizes.

我们已通过将初始 TCP 拥塞窗口增大 300%，提升了 [**边缘网络（Edge Network）**](https://vercel.com/docs/edge-network/overview) 的性能。此项优化使得在首次及后续往返通信中可传输更多数据，从而显著加快各类规模网站的页面加载速度。

End users will experience significant speed improvements when first loading any site hosted on Vercel, with many sites seeing up to 3x faster initial page loads. The larger initial congestion window allows data transfer to ramp up more quickly, reaching higher speeds in fewer round-trips. This optimization is particularly beneficial for high-latency connections, such as those on mobile devices.

终端用户在首次加载任意托管于 Vercel 的网站时，将明显感受到速度提升；许多网站的首屏加载速度最高可达原先的 3 倍。更大的初始拥塞窗口使数据传输能更快加速，并在更少的往返次数内达到更高传输速率。该优化对高延迟网络连接（例如移动设备上的连接）尤为有利。

This performance upgrade is available immediately for all Vercel customers across all plans, with no action required. Your sites will automatically benefit from these improvements without any changes needed on your part.

此项性能升级现已面向所有 Vercel 用户（涵盖全部付费计划）即时生效，无需任何操作。您的网站将自动受益于这些改进，您无需进行任何配置或修改。
{% endraw %}
