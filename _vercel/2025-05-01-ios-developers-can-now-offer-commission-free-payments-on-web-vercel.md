---
render_with_liquid: false
title: "iOS developers can now offer commission-free payments on web - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ios-developers-can-now-offer-commission-free-payments-on-web"
date: "2025-05-01"
scraped_at: "2026-03-02T09:33:56.449464988+00:00"
language: "en-zh"
translated: true
description: "The open web wins: A U.S. court ended Apple’s 27% fee on external payments, letting developers link freely and offer better, direct checkout experiences."
---
render_with_liquid: false
render_with_liquid: false

May 1, 2025

2025年5月1日

Yesterday, a federal court made a decisive ruling in Epic Games v. Apple: Apple violated a 2021 injunction by continuing to restrict developers from linking to external payment methods, and by imposing a 27% fee when they did.

昨日，一家联邦法院就“Epic Games诉Apple案”作出具有决定性的裁决：Apple持续限制开发者链接至外部支付方式，并对相关交易收取27%费用，此举违反了2021年颁布的禁令。

The ruling represents a major shift for native app developers.

该裁决标志着原生应用开发者迎来重大转折。

### Why does it matter?

### 为何此事至关重要？

Apple’s App Store has operated as a tightly controlled marketplace. Until now, developers couldn’t even tell users they could pay elsewhere. Apple’s 30% cut (the so-called "Apple Tax") meant higher prices for consumers, smaller margins for developers, and less freedom overall.

Apple App Store长期以高度封闭的市场形态运作。在此前，开发者甚至不得向用户明示其可在App之外完成付款。Apple所收取的30%佣金（即所谓“Apple税”）导致消费者支付更高价格、开发者利润空间被进一步压缩，整体自由度也大幅受限。

After the 2021 injunction, Apple introduced a system called StoreKit External Purchase Link API. This surfaced a system disclosure sheet, a "scare screen," warning users that they were about to leave the app. **Even worse, Apple still applied a 27% commission to these off-platform transactions.**

2021年禁令下达后，Apple推出了名为“StoreKit External Purchase Link API”的系统。该系统在跳转前弹出一份系统提示页——一种令人不安的“恐吓式界面”（scare screen），警告用户即将离开当前App。**更严重的是，Apple仍对这些站外交易收取27%的佣金。**

This effectively killed price competition: developers who already paid 3–6% to third-party payment processors now had to add another 27% on top, making it impossible to offer lower prices on the web.

这实质上扼杀了价格竞争：开发者原本已向第三方支付服务商支付3–6%手续费，如今还需额外承担27%的Apple佣金，使其完全无法在网页端提供更具竞争力的低价。

Apple also tightly controlled how and where these links could appear. They couldn’t be placed inline with normal purchase flows. Instead, developers were forced to bury them in a separate section of the app. And once tapped, users were pushed into a generic browser session, forced to log in again and manually search for the item they originally wanted to buy. Meanwhile, Apple’s scare screen front-ran the whole experience to steer users back toward Apple’s own payment system.

Apple还严格管控此类外部链接的展示方式与位置：它们不得嵌入常规购买流程中；开发者被迫将链接隐藏于App内一个孤立的独立板块中。一旦用户点击，即被强制跳转至通用浏览器环境，需重新登录，并手动搜索原本想购买的商品。与此同时，Apple的“恐吓式界面”全程前置干预，意在将用户引导回Apple自有的支付体系。

![Example of a system warning shown before opening an external payment link which adds friction and undermines trust in alternative payment options.  ](images/ios-developers-can-now-offer-commission-free-payments-on-web-vercel/img_001.jpg)  
![打开外部支付链接前显示的系统警告示例，该设计增加了操作摩擦，并削弱用户对替代支付方式的信任。](images/ios-developers-can-now-offer-commission-free-payments-on-web-vercel/img_001.jpg)  
Example of a system warning shown before opening an external payment link which adds friction and undermines trust in alternative payment options.

打开外部支付链接前显示的系统警告示例，该设计增加了操作摩擦，并削弱用户对替代支付方式的信任。

Yesterday's ruling ends that. It confirms that developers are allowed to guide users to external payment pages, and that Apple can’t tax or obstruct those transactions.

昨日的裁决终结了这一局面。它明确确认：开发者有权引导用户前往外部支付页面，且Apple不得就此征税或设置障碍。

### What changes now

### 当前有哪些变化

- **允许应用内跳转引导（In-app steering）**：开发者可以嵌入动态的、上下文感知的链接，直接将用户引导至外部支付页面。

- **不再收取“苹果税”**：苹果公司不得再对其未实际处理的支付交易收取27%的佣金。

- **用户体验得到提升**：不再出现令人不安的警告界面（scare screens），不再发生无效跳转（redirects that lead nowhere），取而代之的是简洁、顺畅、无摩擦的结账流程。

开发者可全面掌控支付体验，提供更具竞争力的价格，并与用户建立直接关系。

### What this unlocks for native developers and their users

### 这为原生开发者及其用户释放了哪些潜力

对原生开发者而言，此举真正赋予了选择权：你可以继续沿用苹果的内置支付系统，也可以将用户路由至你自主设计并完全掌控的结账流程。

此举同时也释放了商业机遇。对部分开发者而言，这意味着可将节省的成本让利给用户；对另一些开发者而言，则意味着获得了维持盈利或持续投入产品迭代所必需的利润空间。用户同样受益：你将看到更透明的定价策略、更多样化的折扣模式，以及覆盖游戏、媒体、办公效率类等各类App的更优购物流程。

### A moment for the web

### 网页端迎来新契机

尽管此次裁决并非专门针对网页端，但它为网页开辟了全新角色：浏览器不再仅是备用方案（fallback），而正成为移动商务中一个切实可行的重要入口（viable surface）。

Without App Store restrictions, native developers can embrace the web to build checkout flows that are fast, secure, and customizable.

在不受 App Store 限制的情况下，原生开发者可以拥抱 Web 技术，构建快速、安全且高度可定制的结账流程。

### A starter kit for web payments

### Web 支付入门套件

To help teams get started, we're releasing a starter kit for using Vercel for web payments in native apps. Our goal is to help you build checkout flows optimized for conversion, performance, and developer control.

为帮助团队快速上手，我们正式发布一套用于在原生应用中通过 Vercel 实现 Web 支付的入门套件。我们的目标是助您构建专为转化率、性能表现和开发者掌控力而优化的结账流程。

**You can still use Apple Pay.**

**您依然可以使用 Apple Pay。**

The starter kit includes support for Apple Pay on the web. You can offer Apple Pay as part of your external checkout flow, separate from Apple's in-app purchase (IAP) system. Apple Pay is fully supported in Safari and, as of iOS 16, in other third-party browsers like Chrome and Firefox on iOS devices.

该入门套件内置对 Web 端 Apple Pay 的支持。您可将 Apple Pay 作为外部结账流程的一部分提供，完全独立于 Apple 的应用内购买（IAP）系统。Apple Pay 在 Safari 中获得完整支持；自 iOS 16 起，亦可在 iOS 设备上的其他第三方浏览器（如 Chrome 和 Firefox）中正常使用。

Whether you’re extending a native app or launching a new product, you now have a direct, open path to collect payments on the web.

无论您是在扩展现有原生应用，还是正在推出全新产品，如今您都拥有一条直接、开放的路径，可通过 Web 完成支付收款。

[**iOS Web Payments Starter Kit**\\  
\\  
Everything you need to launch fast, secure, and scalable payment flows on the web. Connected to Stripe Checkout and easily deployed on Vercel.\\  
\\  
Deploy now](https://vercel.com/templates/Next.js/ios-web-payments-starter)

[**iOS Web 支付入门套件**\\  
\\  
您在 Web 端快速、安全、可扩展地启动支付流程所需的一切。已与 Stripe Checkout 深度集成，并可轻松部署至 Vercel。\\  
\\  
立即部署](https://vercel.com/templates/Next.js/ios-web-payments-starter)

### What's next

### 后续计划

At Vercel, we believe in giving developers the tools and platform to:

在 Vercel，我们坚信应为开发者提供工具与平台，以实现：

- Make external payment pages feel fast and polished  

- 让外部支付页面体验迅捷流畅、精致专业

- Deliver performance and reliability at global scale

- 在全球范围内交付卓越的性能与可靠性

- Control their stack and grow their business, without gatekeepers

- 自主掌控技术栈，自由拓展业务，无需任何守门人

We believe in openness. Not in opposition to native, but in connection with it. Vercel is ready to support native developers by bridging their apps with the open web.

我们信奉开放——并非为了对抗原生（native）生态，而是为了与之联结。Vercel 已准备好通过将原生应用与开放网络（open web）相连接，来支持原生开发者。

This ruling doesn’t tear down a walled garden, but it opens a gate. Now it’s up to developers to walk through.

这一裁决并未推倒一座“围墙花园”，而是打开了一扇门。如今，该由开发者迈步而入了。