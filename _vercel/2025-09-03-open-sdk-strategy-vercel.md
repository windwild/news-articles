---
render_with_liquid: false
title: "Open SDK strategy - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/open-sdk-strategy"
date: "2025-09-03"
scraped_at: "2026-03-02T09:29:36.316037854+00:00"
language: "en-zh"
translated: true
description: "Vercel’s Open SDK strategy commits to building frameworks, SDKs, and tools in the open, under permissive licenses. Learn how we’re avoiding lock-in, ensuring portability, and investing in open sou..."
---
render_with_liquid: false
render_with_liquid: false

Sep 3, 2025

2025 年 9 月 3 日

At Vercel, our relationship with open source is foundational. We do not build open source software to make money. Rather, we’re building an enduring business that enables us to continue developing great open source software. We believe in improving the default quality of software for everyone, everywhere, whether they are Vercel customers or not. A rising tide lifts all boats.

在 Vercel，我们与开源的关系是根本性的。我们开发开源软件并非为了盈利；相反，我们致力于构建一家可持续发展的企业，从而持续开发优秀的开源软件。我们坚信，应提升全球所有人的软件默认质量——无论他们是否为 Vercel 的客户。“水涨船高”，整个生态将因此受益。

### Against lock-in

### 反对厂商锁定

We built Next.js at Vercel, and we’ve learned a lot by doing so.

我们在 Vercel 开发了 Next.js，并在此过程中收获颇丰。

We’ve seen the way that building open source and managed infrastructure in tandem can create an incredible developer experience and have massive impact. But coupling a project too tightly to one platform can raise questions about openness and control, even if it also accelerates quality and adoption.

我们已切身感受到：同步构建开源项目与托管基础设施，能够创造出卓越的开发者体验，并产生巨大影响。但若将一个项目过度绑定于单一平台，即便这有助于加速质量提升与用户采纳，仍会引发关于开放性与控制权的质疑。

That’s true even when lock-in is unintended.

即便厂商锁定纯属无意，上述问题依然成立。

### Planting a flag

### 立下旗帜

We believe in open source, community, portability, and freedom of choice, so we want to take some time right now to articulate this commitment as a new ‘Open SDK’ strategy. Here’s what we commit to:

我们信奉开源、社区、可移植性与选择自由。因此，我们希望借此机会，正式宣布一项全新的“开放 SDK”（Open SDK）战略，以清晰表达这一承诺。具体承诺如下：

1. **Open by default**: We commit to building our frameworks, SDKs, and tools in the open, wherever possible, and will default to the most permissive open source licenses in all cases

1. **默认开源**：我们承诺尽可能将框架、SDK 和工具以开源方式构建，并在所有情况下默认采用最宽松的开源许可证。

2. **Loose coupling, high cohesion**: We want what we build to work extremely well on Vercel, but not at the cost of lock-in. We commit to building frameworks, SDKs, and tools that are open, portable, and usable on any platform

2. **松耦合，高内聚**：我们希望所构建的工具在 Vercel 上表现极为出色，但绝不以牺牲开放性或造成厂商锁定为代价。我们承诺打造开放、可移植、且可在任意平台上使用的框架、SDK 与工具。

3. **Innovation, then generalization:** We will build first on Vercel, where we can iterate fastest to ensure the best end-to-end developer and user experience. And as we become confident projects are mature, we’ll invest in ensuring our SDKs and tools are deployable to any platform

3. **先创新，再泛化：** 我们将首先在 Vercel 平台上构建产品——在这里，我们能以最快的速度迭代，从而确保最佳的端到端开发者与用户体验；而当项目趋于成熟、我们对其稳定性充满信心后，我们将投入资源，确保我们的 SDK 和工具可部署至任意平台。

This is a commitment we want you to hold us to. In the long run, we believe this openness means you’ll be more likely to stay with Vercel. Not because you have to, but because you choose to.

这是我们希望您监督我们践行的一项承诺。从长远来看，我们相信这种开放性意味着您更有可能持续选择 Vercel——不是出于被迫，而是出于自主选择。

### Where it comes from

### 战略渊源

This strategy emerged from a series of real world observations and product decisions:

这一战略源于一系列真实世界的观察与产品决策：

1. **The ubiquity of React:** One compelling reason many developers choose React is that it is unopinionated about how and where you deploy it

1. **React 的普适性：** 许多开发者选择 React 的一个重要原因，正在于它对“如何部署”及“部署到何处”持中立、无约束的态度。

2. **Next.js as a standalone choice:** Developers wanted to use Next.js to its full potential on other managed platforms. That desire has become a north star for our open strategy

2. **Next.js 作为独立技术选型：** 开发者希望能在其他托管平台上充分发挥 Next.js 的全部能力。这一诉求已成为我们开放战略的指路明灯。

3. **The AI SDK:** When Vercel acquired the `ai` npm package name, we knew we had a responsibility to make it platform, and framework-agnostic. That was non-negotiable

3. **AI SDK：** 当 Vercel 获得 `ai` npm 包名时，我们深知肩负着使其具备跨平台、跨框架兼容性的责任——这一点不容妥协。

4. **Nuxt and NuxtLabs:** With NuxtLabs joining Vercel and core members of the Nuxt and Nitro teams now working alongside us, we have to be crystal clear. We want Vercel to be the place open source creators aspire to be as they build for the open web

4. **Nuxt 与 NuxtLabs：** 随着 NuxtLabs 加入 Vercel，以及 Nuxt 和 Nitro 核心团队成员如今与我们并肩协作，我们必须旗帜鲜明地表明立场：我们希望 Vercel 成为开源创作者共建开放网络（open web）时所向往的归属之地。

### Applying the strategy

### 战略落地

This isn’t about any single framework, whether Next.js or the AI SDK. And it won’t necessarily apply to Vercel’s commercial products, but we're actively applying this strategy across a growing family of libraries and frameworks:

这并非聚焦于某一个特定框架——无论是 Next.js 还是 AI SDK。该策略也未必适用于 Vercel 的商业化产品；但目前，我们正积极将这一理念应用于日益扩大的各类库与框架生态之中：

- [**Nuxt**](https://nuxt.com/): 将相同的设计理念带入 Vue 生态系统

- [**Svelte**](https://svelte.dev/) **:** 以灵活的部署选项赋能高性能应用

- [**Flags**](https://flags-sdk.dev/) **:** 一个可移植的特性开关（feature flag）系统，无需依赖特定的旗标（flag）服务提供商

- 此外还包括 [Nitro](https://nitro.build/)、[Turborepo](https://turborepo.com/)、[SWR](https://swr.vercel.app/) 等众多工具


### 面向 Web

我们坚信，构建互联网未来最有效的方式，是投资于开源工具、赋予开发者自由与信心，并持续提升技术可能性的上限——同时不被任何单一平台所锁定。

商业价值源于品质，品质源于使命。

我们的使命，是为所有人构建一个更美好的 Web。