---
title: "Vercel Edge Config + LaunchDarkly: Low latency, global feature flags to your favorite frontend framework - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-config-and-launch-darkly"
date: "2023-06-27"
scraped_at: "2026-03-02T09:52:03.991092354+00:00"
language: "en-zh"
translated: true
description: "We're excited to announce a new LaunchDarkly integration to bring low latency, global feature flags to your favorite frontend framework."
---

render_with_liquid: false
Jun 27, 2023

2023 年 6 月 27 日

We're excited to announce a new [LaunchDarkly integration](https://vercel.com/integrations/launchdarkly) to bring low latency, global feature flags to your favorite [frontend framework](https://vercel.com/docs/frameworks).

我们很高兴地宣布推出全新的 [LaunchDarkly 集成](https://vercel.com/integrations/launchdarkly)，为您的首选 [前端框架](https://vercel.com/docs/frameworks) 带来低延迟、全球可用的特性开关（feature flags）。

Feature flags help your team safely release new code and experiment with changes. [Vercel Edge Config](https://vercel.com/docs/storage/edge-config) helps you instantly read configuration data globally, making it a perfect match for feature flag and experimentation data.

特性开关可帮助您的团队安全地发布新代码，并对变更进行实验。[Vercel Edge Config](https://vercel.com/docs/storage/edge-config) 支持您在全球范围内即时读取配置数据，因此与特性开关及实验数据天然契合。

### Vercel Edge Config

### Vercel Edge Config（边缘配置）

Vercel is the lowest-latency host for globally scalable applications using feature flags. By pushing data to every region, before any requests are made, you're able to read data from a Vercel Function or Edge Middleware immediately upon request.

Vercel 是面向采用特性开关的全球可扩展应用时延迟最低的托管平台。通过在任何请求发起前，将数据主动推送至所有区域，您即可在请求到达时立即从 Vercel Function 或 Edge Middleware 中读取数据。

Because data is pushed to every Vercel region at write time, we've seen **most lookups return in** **5 ms or less**, and **99% of reads will return in under 15 ms.**

由于数据在写入时即被推送到每个 Vercel 区域，我们观察到：**大多数查询响应时间在 5 毫秒或更短**，且**99% 的读取操作可在 15 毫秒内完成**。

This speed and global distribution make Edge Config great for:

这一超高速度与全球分发能力，使 Edge Config 成为以下场景的理想选择：

- A/B testing  
- A/B 测试  

- Feature flags  
- 特性开关  

- Maintaining complex and dynamic redirects  
- 管理复杂且动态的重定向规则

- 配置和更新定制化的请求拦截规则，无需重新部署


### 实验生态系统

零售与电商等行业的开发者深知：在用户体验方面，每一毫秒都至关重要。因此，在保持页面加载时间不变的前提下开展 A/B 测试尤为关键。

今天，我们正式推出与 [LaunchDarkly](https://launchdarkly.com/) 的集成，以进一步推动实验流程的便捷性，并提升发布过程的速度与安全性。

[**Vercel 上的 LaunchDarkly 集成**\\
\\
LaunchDarkly 企业版客户可安装该集成，开始将功能开关（flag）配置导出至 Vercel Edge Config。\\
\\
立即开始](https://vercel.com/integrations/launchdarkly)

[LaunchDarkly 集成](https://vercel.com/docs/storage/edge-config/edge-config-integrations#launchdarkly) 会将您在 LaunchDarkly 中定义的功能开关同步至 Edge Config。随后，最新发布的 [vercel-server-sdk 包](https://www.npmjs.com/package/@launchdarkly/vercel-server-sdk) 将基于这些开关初始化一个 LaunchDarkly 客户端。您便可直接从 Edge Config 读取开关状态，而无需再向 LaunchDarkly 发起网络请求——这意味着您的功能开关可即时生效。

app/page.tsx

```javascript
import { init } from '@launchdarkly/vercel-server-sdk'

import { createClient } from '@vercel/edge-config'

import { Dashboard, LegacyDashboard } from "./dashboards"
```

```javascript
const edgeClient = createClient(process.env.EDGE_CONFIG)

const ldClient = init("YOUR CLIENT-SIDE ID", edgeClient)



export const runtime = "edge"



export default async function Home() {

11  await ldClient.waitForInitialization()

12  const ldContext = { kind: 'org', key: 'my-org-key' }

13  const showNewDashboard = await ldClient.variation('new-dashboard', ldContext, true)
```

```javascript
const edgeClient = createClient(process.env.EDGE_CONFIG)

const ldClient = init("YOUR CLIENT-SIDE ID", edgeClient)



export const runtime = "edge"



export default async function Home() {

11  await ldClient.waitForInitialization()

12  const ldContext = { kind: 'org', key: 'my-org-key' }

13  const showNewDashboard = await ldClient.variation('new-dashboard', ldContext, true)
```

15  return showNewDashboard ? <Dashboard /> : <LegacyDashboard />

15  返回值为：若 `showNewDashboard` 为真，则渲染 `<Dashboard />`；否则渲染 `<LegacyDashboard />`。

16}
```

This lower latency is especially critical in a serverless world. Since compute is short lived, you can’t fetch once and then subscribe to updates like you would on a long running server.

这种更低的延迟在无服务器（serverless）环境中尤为关键。由于计算资源生命周期极短，你无法像在长期运行的服务器上那样，仅执行一次获取操作后便持续订阅更新。

> “The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users. The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users.”
>
> “Vercel Edge Config 与 Vercel 版本的 LaunchDarkly 集成相结合，使我们能够轻松更新功能开关（feature flag）配置，并实时自动将其推送至我们的 Edge Config 存储中。我们无需重新部署即可动态调整应用的用户界面与行为，从而保持高度灵活性。Edge Config 所提供的低延迟显著降低了通过 HTTP 获取开关配置的开销，使整体延迟降至最低，从而为用户带来更佳体验。”

> ![](images/vercel-edge-config-launchdarkly-low-latency-global-feature-flags-to-your-favorit/img_001.png)
>
> **Vincent Derks**，Joyn 公司首席工程师

Vercel Edge Config provides a unique combination of active global replication with near-instant reads. In combination with LaunchDarkly, this allows users like Joyn to update their UI in seconds with almost zero added latency.

Vercel Edge Config 提供了一种独特的能力：在全球范围内主动同步数据，同时实现近乎即时的读取响应。结合 LaunchDarkly，这一能力使得 Joyn 等客户可在数秒内完成用户界面更新，且几乎不引入额外延迟。

### **Get started**

### **快速开始**

Visit the [LaunchDarkly integration](https://vercel.com/integrations/launchdarkly) or [template](https://vercel.com/templates/next.js/feature-flag-launchdarkly) to get started or check out the [Edge Config documentation](https://vercel.com/docs/storage/edge-config) to learn more.

请访问 [LaunchDarkly 集成页面](https://vercel.com/integrations/launchdarkly) 或 [模板页面](https://vercel.com/templates/next.js/feature-flag-launchdarkly) 开始使用；或查阅 [Edge Config 文档](https://vercel.com/docs/storage/edge-config) 以了解更多信息。

Vercel Template

Vercel 模板

Deploy this template

部署此模板

### Learn how to set up the LaunchDarkly integration to read flags from Edge Config

### 如何设置 LaunchDarkly 集成以从 Edge Config 读取 Flag

LaunchDarkly Integration example

LaunchDarkly 集成示例

Vercel.com landing page

Vercel.com 着陆页

### LaunchDarkly integration

### LaunchDarkly 集成