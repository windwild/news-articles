---
title: "Introducing Skew Protection - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/version-skew-protection"
date: "2023-06-21"
scraped_at: "2026-03-02T09:51:57.753142547+00:00"
language: "en-zh"
translated: true
description: "Skew Protection from Vercel, a mechanism to eliminate version skew"
---
&#123;% raw %}

Jun 21, 2023

2023 年 6 月 21 日

A novel, more reliable mechanism for application deployment.

一种新颖、更可靠的**应用部署机制**。

Have you ever seen a 404 for requests from old clients after a deployment? Or gotten a 500 error because the client didn’t know that a new server deployment changed an API? We're introducing a generic fix for this problem space.

部署后，旧客户端的请求是否曾返回 404？或者因客户端不知晓服务端新部署已变更 API 而收到 500 错误？我们正为此类问题提供一套通用解决方案。

Vercel customers are deploying over 6 million times per month, making their businesses more successful one commit at a time. But since the dawn of the distributed computing age, each system deployment has introduced the risk of breakage: When client and server deployments aren’t perfectly in sync, and they won’t be, then calls between them can lead to unexpected behavior.

Vercel 用户每月部署超 600 万次，让业务随着每一次代码提交而日益成功。但自分布式计算时代开启以来，每次系统部署都带来了出错风险：客户端与服务端部署永远无法做到完全同步，二者之间的调用便可能引发不可预期的行为。

We call this issue **version skew**. In the worst case, version skew can break your app, and in the best case, it leads to substantial extra engineering effort as software changes crossing system boundaries must be backward and forward-compatible.

我们将这一问题称为 **版本偏斜（version skew）**。最坏情况下，版本偏斜会导致应用崩溃；即使在最佳情况下，它也会显著增加工程负担——因为跨越系统边界的软件变更必须同时保持向后兼容（backward compatibility）和向前兼容（forward compatibility）。

Today, we're introducing [Skew Protection](https://vercel.com/docs/concepts/deployments/skew-protection) for deployments, a novel mechanism to eliminate version skew between web clients and servers. This technology will substantially reduce errors users observe as new deployments are rolled out. Additionally, it will increase developer productivity as you no longer need to worry about backward and forward compatibility of your API changes. Available today for everyone in [Next.js and SvelteKit with Nuxt and Astro coming soon](https://vercel.com/docs/deployments/skew-protection#supported-frameworks).

今天，我们正式推出面向部署的 **[偏斜防护（Skew Protection）](https://vercel.com/docs/concepts/deployments/skew-protection)** ——一种可彻底消除 Web 客户端与服务端之间版本偏斜的全新机制。该技术将在新部署上线过程中大幅降低用户实际遭遇的错误率；同时提升开发者效率——您将无需再为 API 变更的向后与向前兼容性操心。即日起，所有用户均可在 [Next.js 和 SvelteKit 中使用该功能，Nuxt 与 Astro 支持即将上线](https://vercel.com/docs/deployments/skew-protection#supported-frameworks)。

## Version skew explained

## 版本偏斜详解

Version skew happens whenever two components of a software system communicate, but they aren’t running at exactly the same version. Often this is benign, but it can lead to hard to predict and debug problems.

只要软件系统的任意两个组件发生通信，而它们运行的并非完全相同的版本，就会出现版本偏斜。多数情况下影响轻微，但有时却会引发难以预测且难以调试的问题。

form.tsx

```html
1< <input type="email" name="emal" />
```

2---

3> <input type="email" name="email" />
```

想象一下，例如，你的应用中有一个表单。某天你意识到自己拼错了邮箱字段的 `name` 属性。这本身并不是大问题，因为后端读取该字段的代码也用了同样的错拼——因此暂时仍能正常工作。但你最终还是决定同时修复前端和后端的拼写。此时便产生了潜在的**版本偏斜（version skew）**问题：如果用户在变更部署前已加载了表单（即使用旧字段名），却在部署完成之后才提交表单，那么就会报错——因为后端此时期望的是新拼写的字段名，而前端发送的仍是旧名称。

借助 Vercel 的 **Skew Protection（版本偏斜防护）** 功能，这一问题将不复存在：它确保加载了旧版表单（含旧字段名）的客户端，始终与知晓如何处理该旧字段名的、对应版本的服务器通信。

如需深入了解版本偏斜及其可能的管理策略，请参阅深度技术解析文章：[here](https://www.industrialempathy.com/posts/version-skew/)。

## Skew Protection 的工作原理

对于启用该功能的部署，每当用户首次导航至应用时，该应用实例即被绑定到最初生成它的部署版本。此后，该应用实例发出的所有后续请求，都将自动路由至同一版本进行响应。

![](images/introducing-skew-protection-vercel/img_001.jpg)![](images/introducing-skew-protection-vercel/img_002.jpg)

要启用此项实验性功能，请在 `next.config.js` 中添加以下配置（支持 Next.js 13.4.7 或更高版本）。Next.js 将为请求打上目标部署 ID 标签，Vercel 则利用该信息实现 Skew Protection 功能。

```javascript
1/** @type {import('next').NextConfig} */

```js
const nextConfig = {

3  experimental: {

4    useDeploymentId: true,

5    // If use with serverActions is desired

6    serverActions: true,

7    useDeploymentIdServerActions: true,

8  },

9};



module.exports = nextConfig;
```

```js
const nextConfig = {

3  experimental: {

4    useDeploymentId: true,

5    // 如果希望与 serverActions 一起使用

6    serverActions: true,

7    useDeploymentIdServerActions: true,

8  },

9};



module.exports = nextConfig;
```

We're planning to support automatic Skew Protection for additional request-types in the future. You can experiment with per-request opt-in today by reading the deployment id from `process.env.VERCEL_DEPLOYMENT_ID` and passing it down in `fetch` requests via the `X-Deployment-Id` header:

我们计划在未来为更多类型的请求支持自动 Skew Protection。您可立即尝试按请求启用该功能：通过读取 `process.env.VERCEL_DEPLOYMENT_ID` 获取部署 ID，并在 `fetch` 请求中通过 `X-Deployment-Id` 请求头将其传递下去：

```tsx
const r = await fetch("/get", {

2  headers: {

3    // Ensures the request will be handled by the expected

4    // deployment.

5    "X-Deployment-Id": deploymentId,

6  },

7});
```

```tsx
const r = await fetch("/get", {

2  headers: {

3    // 确保该请求由预期的部署实例处理。

4    // deployment.

5    "X-Deployment-Id": deploymentId,

6  },

7});
```

## The mechanism explained

## 机制详解

Skew Protection is taking advantage of Vercel’s immutable deployments as the enabling primitive. While production deployments change the primary deployment a given domain is aliased to, Vercel retains the capability to serve previous deployments. If you’ve used Vercel’s [Instant Rollback](https://vercel.com/docs/concepts/deployments/instant-rollback) feature before–it is based on the same underlying mechanism.

Skew Protection 借助 Vercel 的不可变部署（immutable deployments）这一基础能力实现。当生产环境部署更新时，Vercel 会将指定域名的主部署指向新版本；但与此同时，Vercel 仍能继续为旧版本部署提供服务。如果您此前使用过 Vercel 的 [即时回滚（Instant Rollback）](https://vercel.com/docs/concepts/deployments/instant-rollback) 功能，那么您已体验过这一底层机制。

Our serverless technology paired with powerful edge application routing makes this efficient and cost-effective without requiring the provisioning of physical infrastructure for each version that runs concurrently.

我们的无服务器技术，结合强大的边缘应用路由能力，使这一方案既高效又经济实惠，无需为每个同时运行的版本单独配置物理基础设施。

With Skew Protection, whenever a user does a so-called “hard navigation”, the deployment ID that this navigation was served from is encoded in the response HTML. Subsequent requests are then tagged with that deployment ID and when they enter Vercel’s platform our global edge infrastructure automatically routes those requests to the respective deployment.

启用“倾斜保护（Skew Protection）”后，每当用户执行所谓“硬导航（hard navigation）”时，本次导航所服务的部署 ID 将被编码进响应的 HTML 中。后续请求将携带该部署 ID；当这些请求进入 Vercel 平台时，我们的全球边缘基础设施会自动将它们路由至对应的部署。

## Trade-offs and security considerations

## 权衡取舍与安全考量

While Skew Protection eliminates the hardest to manage skew boundary, between the user’s client and the servers, it does not eliminate version skew per-se. Services behind the frontend server must continue to be robust to being called from older clients.

尽管倾斜保护消除了最难管理的倾斜边界——即用户客户端与服务器之间的边界，但它本身并未彻底消除版本倾斜（version skew）。前端服务器后端所依赖的服务，仍需保持健壮性，以兼容来自旧版客户端的调用。

Developers can choose the maximum age for deployments to be eligible for skew protection (up to 7 days for Enterprise customers). Given the trade-off mentioned above, one needs to consider client-convenience and backend-service backward compatibility requirements.

开发者可自定义有资格启用倾斜保护的部署最大存活时长（企业客户最高支持 7 天）。鉴于上述权衡，您需要综合评估客户端使用体验与后端服务向后兼容性的实际需求。

The mechanism does introduce the risk of downgrade attacks. We mitigate the risk by not supporting deployment-binding on browser navigations (requests serving the primary HTML) and by limiting the feature to same-origin requests. Still, you may want to [block deployments from serving](https://vercel.com/docs/deployments/skew-protection#configure-skew-protection) after security fixes or particularly important changes.

该机制确实引入了降级攻击（downgrade attack）的风险。我们通过两种方式缓解该风险：一是不支持在浏览器导航（即返回主 HTML 的请求）中绑定部署 ID；二是将该功能限制于同源请求（same-origin requests）。即便如此，您仍可能希望在完成安全修复或实施关键变更后，[禁止相关部署对外提供服务](https://vercel.com/docs/deployments/skew-protection#configure-skew-protection)。

## Deploy with confidence

## 自信部署

Deploying with confidence means shipping even faster. We’re excited to start this journey to a more reliable way of web application deployment with all of you. Give [Skew Protection](https://vercel.com/docs/concepts/deployments/skew-protection) a try and let us know what you think.

“自信部署”意味着更快地上线交付。我们非常高兴能与各位共同开启这段旅程，迈向更可靠的 Web 应用部署方式。欢迎试用 [倾斜保护（Skew Protection）](https://vercel.com/docs/concepts/deployments/skew-protection)，并告诉我们您的反馈！

Vercel.com landing page

Vercel.com 首页

### Introducing Next.js App Router

### 推出 Next.js App Router

Vercel.com landing page

Vercel.com 着陆页

### See how teams ship faster with frontend cloud

### 了解团队如何借助前端云更快地交付产品
&#123;% endraw %}
