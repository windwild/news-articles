---
title: "Our new Edge and Dev infrastructure - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/new-edge-dev-infrastructure"
date: "2020-07-21"
scraped_at: "2026-03-02T10:06:37.520521268+00:00"
language: "en-zh"
translated: true
description: "Introducing major end-to-end enhancements from a better development experience to serving pages even faster."
---

render_with_liquid: false
Jul 21, 2020

2020 年 7 月 21 日

Vercel [诞生于](https://vercel.com/blog/zeit-is-now-vercel) 帮助前端团队在规模化场景下取得成功。从本地开发时理想的开发者体验，到通过我们的**全球边缘网络（Global Edge Network）为终端用户提供最佳性能**。

今天，我们推出多项端到端的重大增强功能：始于支持 **实时开发工作流**（配合 Next.js 与 Vercel CLI），终于实现**页面加载速度最高提升至原先的 6 倍**。

## 全新开发体验

尽管在无服务器（serverless）时代，底层云基础设施已取得显著进步，但开发者体验却长期被忽视。

如今，CDN 缓存、无服务器函数等已成为高性能、高动态性前端的标准能力，却几乎无法在本地环境中进行开发。

正是这些局限性，促使我们加大对 Next.js 及 Vercel CLI 开发体验的投入。

### Next.js：为云端而生——亦为本地而优

Next.js 的设计目标，是将完整的现代开发栈无缝带入你的本地开发环境，并提供无与伦比的性能表现。

借助我们全新的 **Fast Refresh（快速刷新）** 功能，对复杂用户界面及组件所做的修改，可在毫秒级内即时呈现——其响应速度比其他 React 框架快 **10 至 20 倍**。

Next.js is the first framework to feature Facebook's Fast Refresh technology in the open source ecosystem.

Next.js 是首个在开源生态中集成 Facebook Fast Refresh 技术的框架。

Next.js also brings all the capabilities and optimizations of a modern edge network to localhost. For example, when you use [incremental static regeneration](https://nextjs.org/blog/next-9-4#incremental-static-regeneration-beta) or [API routes](https://nextjs.org/docs/api-routes/introduction), you never need to reach for additional tooling or be left wondering what will happen when you push and deploy.

Next.js 还将现代边缘网络的全部能力与优化带到了本地开发环境。例如，当你使用 [增量静态再生（ISR）](https://nextjs.org/blog/next-9-4#incremental-static-regeneration-beta) 或 [API 路由](https://nextjs.org/docs/api-routes/introduction) 时，你无需额外引入其他工具，也无需再为代码推送和部署后的实际行为而担忧。

### Vercel CLI: enhanced local dev and env sync

### Vercel CLI：增强的本地开发与环境同步

While Next.js's `next dev` capability comes with built-in support for functions and other Vercel capabilities, other frameworks do not. In those situations, you can run [Vercel CLI](https://vercel.com/cli)'s `vercel dev` to replicate Vercel on localhost.

尽管 Next.js 的 `next dev` 命令原生支持函数（Functions）及其他 Vercel 功能，但其他框架并不具备这一能力。在这些情况下，你可以运行 [Vercel CLI](https://vercel.com/cli) 的 `vercel dev` 命令，在本地完整复现 Vercel 的运行环境。

For example, if you use Gatsby or Vue.js, you can work with functions simply by creating an `api/my-function.js` file, running `vc dev` and then navigating to `http://localhost:3000/api/endpoint`.

例如，如果你使用 Gatsby 或 Vue.js，只需创建一个 `api/my-function.js` 文件，运行 `vc dev`，然后访问 `http://localhost:3000/api/endpoint`，即可直接开发和调试函数。

With the new Vercel CLI 19, you can now enjoy:

借助全新的 Vercel CLI 19，你现在可以享受以下改进：

- **Faster startup**. `vc dev` invokes your framework's dev command (if any) more quickly

- **更快的启动速度**：`vc dev` 更快地调用你所用框架的开发命令（如已定义）

- **Better stacktraces.** Made a mistake in a function? We now tell you _exactly where_

- **更清晰的堆栈追踪**：函数中出错了？我们现在会精准指出 _错误发生的位置_

- **Improved memory usage.** Long development sessions are now lean and stable

- **更优的内存占用**：长时间开发会话现在更加轻量且稳定

- **Seamless env sync.** `vc dev` now automatically pulls your dev env from the cloud

- **无缝的环境同步**：`vc dev` 现在可自动从云端拉取你的开发环境配置

- **Speedy invocations.** Your Node.js functions are much faster to run locally  
- **快速调用。** 您的 Node.js 函数在本地运行速度大幅提升  

## Our new edge infrastructure  

## 我们全新的边缘基础设施  

A great developer workflow is a means to an end: creating a delightful product that users enjoy. Delivering on both with no extra work is the primary goal of the Vercel platform.  

优秀的开发者工作流只是实现目标的手段：打造令用户喜爱的出色产品。无需额外投入即可同时兼顾开发体验与终端用户体验，这正是 Vercel 平台的核心目标。  

We have completely overhauled our edge infrastructure, and done so entirely without disruption to our user traffic. Vercel processes **4.5+ billion requests every week**, but now it does so much faster.  

我们已全面重构边缘基础设施，整个升级过程完全未影响用户流量。Vercel 每周处理 **超过 45 亿次请求**，而现在处理速度显著提升。  

### Vercel's own Anycast IP range  

### Vercel 自有的 Anycast IP 地址段  

Not all IPs are created equal. While the IP that identifies your computer or phone is linked to one exact location, some are special.  

并非所有 IP 地址都生而平等。虽然标识您电脑或手机的 IP 地址通常绑定于某一确切地理位置，但某些 IP 地址却与众不同。  

IPs like **8.8.8.8** (Google Public DNS) have minimal latency, no matter where in the world you use them. Now joining those ranks is Vercel's very own IP ranges.  

例如 **8.8.8.8**（Google 公共 DNS）这类 IP 地址，无论您身处世界何地，均能实现极低延迟。如今，Vercel 自有的 IP 地址段也跻身这一行列。  

If you've set up a domain recently with Vercel, you might have noticed we now offer you `A` and `CNAME` records (selected from a pool of optimized Anycast IPs tailored to your plan and project).  

如果您近期在 Vercel 上配置了域名，可能已经注意到：我们现在为您提供了 `A` 记录和 `CNAME` 记录选项——这些记录均来自一个经过优化的 Anycast IP 地址池，且会根据您的订阅计划与项目需求智能匹配。  

In practice, all sites and APIs served by Vercel enjoy:  

实际应用中，所有由 Vercel 托管的网站与 API 均可享受以下优势：  

- **Faster page loads**. Up to _6x faster_– depending on location, ISP and DNS involved  
- **更快的页面加载速度**。最高可达 _6 倍提速_——具体提升幅度取决于用户所在地理位置、网络服务提供商（ISP）及所用 DNS 解析服务

- **Optimal routing**. We now route at the most fundamental layer of internet infrastructure  
- **最优路由**。我们现已在互联网基础设施最底层进行流量调度。

- **Apex support**. Use `A` records with confidence, no need for `ALIAS` or `ANAME` records  
- **根域名支持**。可放心使用 `A` 记录，无需依赖 `ALIAS` 或 `ANAME` 记录。

- **Global redundancy**. We automatically re-route traffic if any of our global regions are down  
- **全球冗余**。若任一全球区域发生故障，我们将自动重新调度流量。

- **Improved interoperability**. Use Route 53, Cloudflare, CrowdStrike, etc with no loss in efficiency  
- **增强的互操作性**。可无缝集成 Route 53、Cloudflare、CrowdStrike 等服务，且不牺牲任何性能。

### Improved handling of large attacks and traffic spikes  
### 大规模攻击与流量激增的应对能力提升

In addition to a great dev experience and optimal end-user performance, customers are drawn to Vercel to stop worrying about scaling infrastructure.  
除了卓越的开发者体验与极致的终端用户性能外，客户选择 Vercel 的另一大原因，正是从此无需再为基础设施的弹性伸缩而担忧。

On one hand, due to increasing popularity of our service, we have upgraded our global network to automatically scale and manage large amounts of traffic, including unpredictable spikes.  
一方面，随着服务日益普及，我们已全面升级全球网络，使其能够自动弹性伸缩，高效承载海量流量——包括难以预测的突发高峰。

On the other hand, as the number of sites we serve increases, so do the chances of malicious attacks – especially DDoS. We have made huge improvements to our technology to stop them.  
另一方面，随着托管站点数量持续增长，遭遇恶意攻击（尤其是 DDoS 攻击）的风险也随之上升。为此，我们对防护技术进行了大幅优化与增强，以更有效地抵御此类威胁。

## Conclusion  
## 结语

If your journey begins with Next.js, Vercel has ensured your dev experience is unmatched. From realtime editing, to unique optimizations and features that replicate what's possible at the edge.  
倘若您的开发之旅始于 Next.js，Vercel 已为您打造无可匹敌的开发体验：从实时编辑，到独创的性能优化与功能特性——全部复现了边缘计算所能实现的全部能力。

The Vercel CLI has likewise improved, with its new capability to automatically sync your team's environment and speed improvements when using other frameworks or just writing functions.

Vercel 命令行工具（CLI）同样得到了改进：新增了自动同步团队环境的功能，并在使用其他框架或仅编写函数时显著提升了运行速度。

As far as the end-user is concerned, our edge is now faster, more robust and more versatile than ever before. Your pages just load faster and more reliably.

对终端用户而言，我们的边缘网络（Edge Network）如今比以往任何时候都更快、更稳健、也更灵活。您的页面加载速度更快，稳定性也更高。

Remarkably, all the changes we outlined went live with zero interruptions – to visitors or developers. By choosing Vercel, you choose to focus on improving your product, while we take care the rest.

值得一提的是，我们所概述的所有变更均实现零中断上线——既未影响访客访问，也未干扰开发者工作。选择 Vercel，意味着您可专注于产品优化，其余一切交由我们来保障。