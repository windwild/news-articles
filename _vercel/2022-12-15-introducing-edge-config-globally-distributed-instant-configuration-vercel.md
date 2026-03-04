---
title: "Introducing Edge Config: Globally distributed, instant configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-config-public-beta"
date: "2022-12-15"
scraped_at: "2026-03-02T09:57:26.145357610+00:00"
language: "en-zh"
translated: true
description: "Edge Config is a distributed data store optimized for near-instant reads. By pushing data to every region, before any requests are made, you're able to read that data from a Vercel Function or Edge Mi..."
---
&#123;% raw %}

Dec 15, 2022

2022 年 12 月 15 日

Last month we announced the limited availability of [Vercel Edge Config](https://www.vercel.com/docs/concepts/edge-network/edge-config), an ultra-low latency data store for near-instant reads of configuration data.

上个月，我们宣布 [Vercel Edge Config](https://www.vercel.com/docs/concepts/edge-network/edge-config) 开始限量可用——这是一款超低延迟的数据存储服务，专为近乎即时地读取配置数据而设计。

Edge Config is now generally available, alongside integrations with [Statsig](https://vercel.com/integrations/statsig) and [HappyKit](https://vercel.com/integrations/happykit) for A/B testing and Feature Flags.

如今，Edge Config 已正式全面开放，并已集成 [Statsig](https://vercel.com/integrations/statsig) 和 [HappyKit](https://vercel.com/integrations/happykit)，可直接支持 A/B 测试与功能开关（Feature Flags）。

## Why Edge Config

## 为何选择 Edge Config

Edge Config is a distributed data store optimized for near-instant reads. By pushing data to every region, before any requests are made, you're able to read that data from a Vercel Function or Edge Middleware immediately upon request.

Edge Config 是一种分布式数据存储，专为近乎即时的读取操作而优化。它会在任何请求发起前，将数据主动推送至所有边缘区域；因此，您可在收到请求的第一时间，通过 Vercel Function 或 Edge Middleware 直接读取该数据。

Because data is pushed to every Vercel region at write time, we've seen most lookups return in **5 ms or less**, and **99% of reads will return under 15 ms.**

由于数据在写入时即被同步推送至全部 Vercel 边缘区域，我们观察到绝大多数查询响应时间在 **5 毫秒以内**，且 **99% 的读取操作可在 15 毫秒内完成**。

This speed and global distribution make Edge Config great for:

这一极致速度与全球分发能力，使 Edge Config 成为以下场景的理想选择：

- A/B testing  
- A/B 测试  

- Feature flags  
- 功能开关（Feature Flags）  

- Maintaining complex and dynamic redirects  
- 管理复杂且动态的重定向规则

- 配置和更新定制化的请求拦截规则，无需重新部署


[**维护页面** 使用 Edge Config 和 Edge Functions 在边缘触发维护页面](https://vercel.com/templates/next.js/maintenance-page)

### 利用 Edge Config 进行实验（A/B 测试与功能发布）

结合 [Statsig](https://vercel.com/integrations/statsig)、[HappyKit](https://vercel.com/integrations/happykit)、[Split](https://www.split.io/) 等实验平台及其他 A/B 测试合作伙伴，Edge Config 可显著提升性能与页面加载体验。通过将这些工具与 Edge Config 集成，其配置数据可在变更时即时同步至边缘节点。当用户访问您的网站时，无需额外发起网络请求即可获取配置数据。此外，由于数据在全球范围内分发，首次读取的延迟也大幅降低。

![](images/introducing-edge-config-globally-distributed-instant-configuration-vercel/img_001.png)

[私有 Beta 用户](https://vercel.com/templates?type=edge-config)

“Edge Config 是我们开发流程中一款出色的工具。它让我们能够持续开发和部署应用，而无需担忧延迟问题，也无需自行搭建和托管配置服务。”

伴随 Edge Config 的 Beta 版本发布，我们同步推出了与 Statsig 和 HappyKit 的全新集成。

[Statsig](https://vercel.com/integrations/statsig) 是一个专注于实验与功能管理的平台，助力企业依托数据加速迭代、打造更优质的产品。Vercel 用户现在可直接在边缘环境中使用 Statsig 的服务端 SDK，实时获取配置，并将用户分配至不同的功能实验组中。

![](images/introducing-edge-config-globally-distributed-instant-configuration-vercel/img_002.png)

"Edge Config allows Statsig users to read updated feature flag and experiment configs at the Edge. With this release we’re able to push config updates to the Edge, where our users can read up-to-date configs with ultra-low latency, reducing serverless cold-start times and a greatly improved end-user experience."

“Edge Config” 使 Statsig 用户能够在边缘（Edge）实时读取更新后的功能开关（feature flag）和实验配置（experiment config）。借助本次发布，我们可将配置更新直接推送至边缘节点，使用户能够以极低延迟获取最新配置，从而显著缩短无服务器函数（serverless）的冷启动时间，并大幅提升终端用户体验。

[HappyKit](https://vercel.com/integrations/happykit) 是一款专为 Next.js 应用打造的强大功能开关服务，自推出以来已获得数百个项目的信赖，累计分发超十亿次功能开关。HappyKit 原生集成 Vercel Edge Config —— 这意味着您无需重新部署即可轻松更新功能开关；并且通常仅需数毫秒即可完成功能开关的实时求值（evaluation）。

我们正积极与该领域的合作伙伴协作，持续构建更多官方（first-party）集成。

![](images/introducing-edge-config-globally-distributed-instant-configuration-vercel/img_003.png)

Split Software

“Edge Config 为我们的客户提供了显著提升功能开关下发性能（进而提升应用启动速度）的便捷途径。开发者可借此推动自身向更现代的功能交付与度量实践演进。我对这一领域未来的发展前景感到无比振奋。”

## Get Started

## 快速上手

您可立即通过以下任一方式开始使用：集成 [Edge Config SDK](https://github.com/vercel/edge-config)，或参考 [我们的示例项目](https://vercel.com/templates?type=edge-config)。

```javascript
import { get } from '@vercel/edge-config';
```

```js
const featureFlagEnabled = await get("featureFlagEnabled")
```

```js
const featureFlagEnabled = await get("featureFlagEnabled")
```

Get started with Edge Config

开始使用 Edge Config

Edge Config is now generally available. Check out the [documentation](https://www.vercel.com/docs/concepts/edge-network/edge-config) or [deploy it on Vercel](https://vercel.com/templates?type=edge-config).

Edge Config 现已正式发布（GA）。请查阅[文档](https://www.vercel.com/docs/concepts/edge-network/edge-config)，或在 Vercel 上[部署它](https://vercel.com/templates?type=edge-config)。

We’re excited to hear what you think, and how you’re using Edge Config. Give us feedback in the [Vercel Community](https://community.vercel.com/).

我们非常期待听到您的想法，以及您如何使用 Edge Config。欢迎在 [Vercel 社区](https://community.vercel.com/) 中向我们提供反馈。
&#123;% endraw %}
