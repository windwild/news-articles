---
title: "Edge Config: Ultra-low latency data at the edge - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-config-ultra-low-latency-data-at-the-edge"
date: "2022-11-23"
scraped_at: "2026-03-02T09:58:04.710978482+00:00"
language: "en-zh"
translated: true
description: "Introducing a new data store built for near-instant reads at the edge"
---
{% raw %}

Nov 23, 2022

2022 年 11 月 23 日

面向实验配置与功能开关（feature flag）配置的亚毫秒级读取能力。

今天，我们正式推出 **Edge Config**：一款专为配置数据打造的超低延迟数据存储服务。

Edge Config 全球部署于 Vercel 边缘网络（Edge Network）之上，可让您从 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware)、[Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions) 和 [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions) 中近乎即时地读取配置数据。目前，已有客户使用 Edge Config 管理 A/B 测试及功能开关等配置数据。

Edge Config 现已全面开放（Generally Available）。欢迎查阅 [官方文档](https://www.vercel.com/docs/concepts/edge-network/edge-config)，或直接在 Vercel 上 [一键部署](https://vercel.com/templates?type=edge-config)。

## 一款独特的存储产品

## 一种独特的存储产品

Edge Config 允许您将数据分发至 Vercel 边缘网络，**无需执行任何部署操作**。您的数据会在被请求**之前**，主动复制到我们所有边缘区域。这意味着您的配置数据始终可用，且响应即时。

Edge Config 的架构机制类似于“推送式”内容分发网络（Push-based CDN）。相比之下，“拉取式”CDN 在首次请求时才加载数据，并缓存至过期；而“推送式”CDN 则在数据被请求前即主动获取并缓存，直至新版本被推送更新。

尽管 Vercel 的大部分基础设施（如静态资源分发）采用类似“拉取式”CDN 的机制，Edge Config 却更贴近“推送式”CDN 的工作模式：它会在数据被请求前，就将您的配置同步至全部边缘区域，并持续缓存，直至您发布新版本。

> “Edge Config 太棒了！我们期待这类产品已久，如今终于面世！接下来几周我们将迎来流量高峰，非常期待看到 Edge Config 在此场景下的实际表现！”  
> “Edge Config 太棒了！我们期待这类产品已久，如今终于面世！接下来几周我们将迎来流量高峰，非常期待看到 Edge Config 在此场景下的实际表现！”
>
> ![](images/edge-config-ultra-low-latency-data-at-the-edge-vercel/img_001.png)
>
> **John W**，软件工程师

Your data is structured as JSON, but Edge Config is _not_ a general-purpose key/value store. Instead, it is optimized for fast, inexpensive reads and infrequent writes. Writes of configuration values may take a few seconds to propagate globally, but reads return with very low latency.

您的数据以 JSON 格式组织，但 Edge Config **并非** 通用型键值存储。相反，它专为高速、低成本的读取操作以及低频次写入操作而优化。配置值的写入操作可能需要数秒才能在全球范围内完成传播，但读取操作则具有极低的延迟。

Most lookups return in **5 ms or less**, and **99% of reads will return under 15 ms.**

大多数查询响应时间在 **5 毫秒或更短** 内完成，且 **99% 的读取请求响应时间低于 15 毫秒**。

Edge Config is incredibly fast to read and doesn't require a redeploy to update and maintain config data, making it great for:

Edge Config 读取速度极快，且无需重新部署即可更新和维护配置数据，因此非常适用于以下场景：

- A/B testing and feature flags  
- A/B 测试与功能开关（Feature Flags）

- Maintaining complex and dynamic redirects  
- 维护复杂且动态的重定向规则

- Configuring and updating bespoke request blocking rules, without a redeploy  
- 配置并更新定制化的请求拦截规则，且无需重新部署


## Tools for rapid experimentation

## 面向快速实验的工具

The response to Edge Middleware has been staggering. As customers embrace it for A/B testing and feature flags, they've experienced less layout shift and less need for third-party scripts.

针对 Edge Middleware 的反响极为热烈。当客户将其用于 A/B 测试和功能开关时，页面布局偏移（layout shift）显著减少，对第三方脚本的依赖也大幅降低。

By also moving the config data for these experiments to the edge, you can get further performance improvement by eliminating the network requests to retrieve that data.

若进一步将这些实验所用的配置数据也迁移至边缘（edge），还可通过消除获取该数据所需的网络请求，实现更进一步的性能提升。

Speedway Motors has a strong culture of experimentation and fast iteration, but balances that with a strong dedication to end-user performance. In a banner promotion A/B test, switching to Edge Config gave them an immediate improvement in [Core Web Vitals](https://vercel.com/docs/concepts/analytics/web-vitals#core-web-vitals) and SEO.

Speedway Motors 始终秉持强烈的实验文化与快速迭代精神，同时亦高度重视终端用户的实际体验性能。在一次横幅促销活动的 A/B 测试中，切换至 Edge Config 后，其 [核心网页指标（Core Web Vitals）](https://vercel.com/docs/concepts/analytics/web-vitals#core-web-vitals) 和搜索引擎优化（SEO）效果均获得立竿见影的提升。

![Cumulative Layout Shift for Speedway Motors was reduced by 50%.](images/edge-config-ultra-low-latency-data-at-the-edge-vercel/img_002.jpg)  
Speedway Motors 的累积布局偏移（Cumulative Layout Shift）降低了 50%。

## Edge Config API

## Edge Config API

Edge Config 的 API 允许您快速查询某个键是否存在，并支持在单次请求中获取单个键的值，甚至多个键的值。

```javascript
import { get } from '@vercel/edge-config';



const featureFlagEnabled = await get("featureFlagEnabled")
```

```javascript
import { get } from '@vercel/edge-config';



const featureFlagEnabled = await get("featureFlagEnabled")
```

开始使用 Edge Config  

仅需调用 `get` 或 `getAll`，即可读取您默认的 Edge Config。您可在账户中创建新的 Edge Config，并通过连接字符串连接到其他 Edge Config。

```javascript
import { createClient } from '@vercel/edge-config';
```

```ts
const edgeConfig = createClient(process.env.FEATURE_FLAGS_CONFIG);



const featureFlags = await edgeConfig.getAll(["requireSignup", "showDiscountBanner"]);
```

```ts
const edgeConfig = createClient(process.env.FEATURE_FLAGS_CONFIG);



const featureFlags = await edgeConfig.getAll(["requireSignup", "showDiscountBanner"]);
```

Example A/B test using Edge Config

使用 Edge Config 的 A/B 测试示例

As of April 2023 Edge Config is generally available—you can get started with our new [Statsig](https://vercel.com/integrations/statsig) and [HappyKit](https://vercel.com/integrations/happykit) integrations, [Edge Config SDK](https://github.com/vercel/edge-config), or by using [one of our examples](https://vercel.com/templates?type=edge-config).

截至 2023 年 4 月，Edge Config 已正式发布（Generally Available）——您可通过我们全新的 [Statsig](https://vercel.com/integrations/statsig) 和 [HappyKit](https://vercel.com/integrations/happykit) 集成、[Edge Config SDK](https://github.com/vercel/edge-config)，或参考 [我们的任一示例](https://vercel.com/templates?type=edge-config) 快速上手。
{% endraw %}
