---
title: "Vercel Ship 2024 recap - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-ship-2024"
date: "2024-05-24"
scraped_at: "2026-03-02T09:44:11.299917786+00:00"
language: "en-zh"
translated: true
description: "Vercel Ship 2024 highlighted the integrations, ecosystem, and teams building the web's best products. Read the recap to catch up on all our announcements."
---
{% raw %}

May 24, 2024

2024年5月24日

Nearly 1,000 people gathered in NYC to celebrate our second annual Vercel Ship event.

近1,000人齐聚纽约，共同庆祝第二届年度 Vercel Ship 活动。

Vercel Ship 2024 was all about the power of the frontend cloud, highlighting the integrations, ecosystem, and teams building the web's best products.

Vercel Ship 2024 聚焦“前端云”（frontend cloud）的强大能力，重点展示了各项集成能力、蓬勃发展的生态系统，以及正在构建 Web 最佳产品的开发团队。

This year we introduced some powerful features to enhance iteration velocity:

今年，我们推出了一系列强大新功能，以进一步提升迭代速度：

- Improved platform and Next.js **integrations for feature flags**  
- 平台与 Next.js 在**功能开关（feature flags）**方面的集成得到增强  

- Log, block, and challenge malicious traffic with the **Vercel Firewall**  
- 借助**Vercel 防火墙（Vercel Firewall）**，记录、拦截并挑战恶意流量  

- New tools to improve iteration velocity in the **Vercel Toolbar**  
- **Vercel 工具栏（Vercel Toolbar）**新增多项工具，助力提升迭代速度  

- React 19 support, improved caching, and more in the **Next.js 15 Release Candidate**  
- **Next.js 15 发布候选版（Release Candidate）**现已支持 React 19、缓存性能优化及其他多项改进  

- Further updates and improvements to **v0 and the Vercel AI SDK**  
- **v0** 与 **Vercel AI SDK** 进一步更新与优化  

[**See all the Ship 2024 announcements.**\\
\\
Watch the full Keynote to see live demos of all the new features we announced.\\
\\
Watch the Keynote](https://vercel.com/ship)

[**查看 Ship 2024 全部发布内容。**\\
\\
观看完整主题演讲视频，现场体验本次发布的所有新功能演示。\\
\\
观看主题演讲](https://vercel.com/ship)

## Working with feature flags on Vercel

## 在 Vercel 上使用功能开关（Feature Flags）

Flags are now integrated into Vercel Web Analytics and logs. You can look at your site's page views or custom analytics events based on which feature flags were active, helping you better understand how your flags impact your users.

功能开关现已集成至 Vercel 网站分析（Web Analytics）与日志系统中。您可根据当前启用的功能开关，查看网站的页面浏览量或自定义分析事件，从而更深入地了解这些开关对用户行为的实际影响。

![Applying feature flags in Vercel.](images/vercel-ship-2024-recap-vercel/img_001.jpg)![Applying feature flags in Vercel.](images/vercel-ship-2024-recap-vercel/img_002.jpg)Applying feature flags in Vercel.

![在 Vercel 中应用功能开关。](images/vercel-ship-2024-recap-vercel/img_001.jpg)![在 Vercel 中应用功能开关。](images/vercel-ship-2024-recap-vercel/img_002.jpg)在 Vercel 中应用功能开关。

Plus, you can now try our new experimental design pattern for working with flags in Next.js (and soon SvelteKit). It encodes our best practices to help avoid the challenges of client-side experimentation and makes server-side experimentation much more approachable.

此外，您现在可以尝试我们为 Next.js（以及即将支持的 SvelteKit）推出的全新实验性设计模式来管理功能开关。该模式内嵌了我们的最佳实践，有助于规避客户端实验所面临的常见挑战，并显著降低服务端实验的使用门槛。

[**Start working with flags.**\\
\\
Seamlessly integrate feature flags created in third-party providers like LaunchDarkly and Statsig into your development workflow in Vercel.\\
\\
Get Started](https://vercel.com/blog/feature-flags)

[**立即开始使用功能开关。**\\
\\
无缝将 LaunchDarkly、Statsig 等第三方平台创建的功能开关集成至您的 Vercel 开发工作流中。\\
\\
立即开始](https://vercel.com/blog/feature-flags)

## Introducing Vercel Firewall

## 推出 Vercel 防火墙（Vercel Firewall）

![The new Vercel Firewall.](images/vercel-ship-2024-recap-vercel/img_003.jpg)![The new Vercel Firewall.](images/vercel-ship-2024-recap-vercel/img_004.jpg)The new Vercel Firewall.

![全新的 Vercel 防火墙。](images/vercel-ship-2024-recap-vercel/img_003.jpg)![全新的 Vercel 防火墙。](images/vercel-ship-2024-recap-vercel/img_004.jpg)全新的 Vercel 防火墙。

Vercel Firewall allows you to create custom rules to log, block, challenge, or rate limit (beta) traffic. This application-aware firewall combines performance with simplified management:

Vercel 防火墙允许您创建自定义规则，以实现流量的日志记录、拦截、人机验证挑战（CAPTCHA challenge），或限速（Beta 版）。这款面向应用层的防火墙，在保障高性能的同时，大幅简化了管理流程：

- Rules can be based on 15+ fields, including request path, user agent, IP address, JA4 fingerprint, geolocation, HTTP headers, and even target path

- 规则可基于 15+ 个字段设定，包括请求路径（request path）、用户代理（user agent）、IP 地址、JA4 指纹、地理位置（geolocation）、HTTP 请求头，甚至目标路径（target path）

- Firewall configuration changes propagate within 300ms globally. If you make a mistake, you can instantly rollback to previous rules

- 防火墙配置变更将在全球范围内于 300 毫秒内生效。若配置有误，您可即时回滚至此前的规则版本

[**Be secure by default.**  
**默认即安全。**  

Take your application security to the next level with Vercel Firewall, offering robust protection against a wide range of web threats.  
借助 Vercel 防火墙，将您的应用安全提升至全新水平，全面抵御各类网络威胁。  

Read the Announcement  
阅读公告  

](https://vercel.com/blog/introducing-the-vercel-waf)

## Vercel Toolbar improvements  
## Vercel 工具栏改进

We upgraded the Vercel Toolbar with new developer tools, including:  
我们已使用一系列全新开发者工具升级了 Vercel 工具栏，包括：

- [Open Graph preview](https://vercel.com/changelog/inspect-open-graph-data-with-the-vercel-toolbar): See exactly how your OG cards will look when shared on Slack or social platforms like X and LinkedIn  
- [Open Graph 预览](https://vercel.com/changelog/inspect-open-graph-data-with-the-vercel-toolbar)：精准预览您的 Open Graph 卡片在 Slack 或 X、LinkedIn 等社交平台分享时的呈现效果  

- [Accessibility audit](https://vercel.com/changelog/accessibility-tool): Complete accessibility audits on all your deployments where the Vercel Toolbar is enabled. Vercel will automatically check against the [Web Content Accessibility Guidelines 2.1](https://www.w3.org/TR/WCAG21/) Level A and AA rules  
- [无障碍性审计](https://vercel.com/changelog/accessibility-tool)：在所有已启用 Vercel 工具栏的部署中执行完整的无障碍性审计。Vercel 将自动依据 [Web 内容无障碍指南 2.1（WCAG 2.1）](https://www.w3.org/TR/WCAG21/) 的 A 级与 AA 级标准进行检测  

- [Interaction timing](https://vercel.com/changelog/interaction-timing-tool): Optimize your website's responsiveness and user experience by measuring and [improving Interaction to Next Paint (INP)](https://vercel.com/blog/how-core-web-vitals-affect-seo)  
- [交互计时](https://vercel.com/changelog/interaction-timing-tool)：通过测量并[优化“交互到下一次绘制”（INP）指标](https://vercel.com/blog/how-core-web-vitals-affect-seo)，提升网站响应速度与用户体验  

- [Use the toolbar in production](https://vercel.com/changelog/use-the-vercel-toolbar-in-production): You can now get the toolbar in your production environment without any configuration by installing the [Vercel Chrome Extension](https://chromewebstore.google.com/detail/vercel/lahhiofdgnbcgmemekkmjnpifojdaelb?hl), or by enabling the toolbar for your production domains right in the toolbar menu  
- [在生产环境中使用工具栏](https://vercel.com/changelog/use-the-vercel-toolbar-in-production)：您现在只需安装 [Vercel Chrome 扩展程序](https://chromewebstore.google.com/detail/vercel/lahhiofdgnbcgmemekkmjnpifojdaelb?hl)，或直接在工具栏菜单中为生产环境域名启用工具栏，即可零配置地在生产环境中使用该工具栏  

[**Explore the Vercel Toolbar.**  
**探索 Vercel 工具栏。**  

See what's possible with the Vercel Toolbar today and experience truly collaborative iteration in your development.  
即刻体验 Vercel 工具栏的强大能力，在开发过程中实现真正高效的协同迭代。  

Learn More  
了解更多  

](https://vercel.com/blog/introducing-new-developer-tools-in-the-vercel-toolbar)

## Next.js 15 Release Candidate  
## Next.js 15 发布候选版本（RC）

The Next.js 15 Release Candidate (RC) is now available for early testing. This version introduces exciting features and improvements:  
Next.js 15 发布候选版本（RC）现已开放早期测试。本版本带来了诸多令人期待的新特性与改进：

- [React 功能集成：](https://nextjs.org/blog/next-15-rc#react-19-rc) 支持 React 19 RC、React Compiler（实验性）以及水合（hydration）错误修复改进

- [缓存机制更新：](https://nextjs.org/blog/next-15-rc#caching-updates) `fetch` 请求、`GET` 路由处理器（Route Handlers）以及客户端导航默认不再被缓存

- [部分预渲染（实验性）：](https://nextjs.org/blog/next-15-rc#incremental-adoption-of-partial-prerendering-experimental) 新增 Layout 和 Page 配置项，支持渐进式采用该功能

- [`next/after`（实验性）：](https://nextjs.org/blog/next-15-rc#executing-code-after-a-response-with-nextafter-experimental) 全新 API，用于在响应流式传输完成之后执行代码

- [`create-next-app` 更新：](https://nextjs.org/blog/next-15-rc#create-next-app-updates) 界面设计更新，并新增一个标志（flag），可在本地开发中启用 Turbopack

- [外部包打包优化（稳定版）：](https://nextjs.org/blog/next-15-rc#optimizing-bundling-of-external-packages-stable) App Router 和 Pages Router 均新增了相关配置选项

安装 Next.js 15 RC 版本：

```bash
npm install next@rc react@rc react-dom@rc
```

了解更多详情，请阅读 [Next.js 博客上的完整公告](https://nextjs.org/blog/next-15-rc)，并敬请关注 Next.js 15 正式版（GA）的发布消息。

## v0

## v0

v0 helps you [go from idea to UI in seconds](https://v0.dev/), enabling you to generate React code from simple text prompts and images. We've made v0 even faster, more reliable, and more accessible by enhancing platform reliability and automatically adding ARIA attributes to generated code.

v0 帮助您[在数秒内从创意跃升至用户界面](https://v0.dev/)，支持通过简单的文本提示和图片生成 React 代码。我们通过提升平台稳定性，并在生成的代码中自动添加 ARIA 属性，使 v0 变得更快、更可靠、也更易访问。

## AI SDK

## AI SDK

The Vercel AI SDK is a TypeScript library for building AI-powered applications with React, Next.js, Nuxt, SvelteKit, and more. The SDK is organized into three pillars:

Vercel AI SDK 是一个 TypeScript 库，用于借助 React、Next.js、Nuxt、SvelteKit 等框架构建 AI 驱动的应用程序。该 SDK 围绕三大核心模块构建：

- [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core): A unified API to work with leading LLMs from providers like OpenAI, Anthropic, Mistral, and Groq

- [AI SDK Core](https://sdk.vercel.ai/docs/ai-sdk-core)：统一 API，支持对接 OpenAI、Anthropic、Mistral 和 Groq 等主流大语言模型（LLM）提供商

- [AI SDK UI](https://sdk.vercel.ai/docs/ai-sdk-ui): For building streaming chatbots with minimal code

- [AI SDK UI](https://sdk.vercel.ai/docs/ai-sdk-ui)：以极简代码构建流式响应聊天机器人

- [AI SDK RSC](https://sdk.vercel.ai/docs/ai-sdk-rsc): Dynamic, component-based "Generative UI" experiences powered by AI

- [AI SDK RSC](https://sdk.vercel.ai/docs/ai-sdk-rsc)：由 AI 驱动的动态、组件化“生成式用户界面”（Generative UI）体验

With the Vercel AI SDK, developers can easily build the intelligent web applications of the future.

借助 Vercel AI SDK，开发者可轻松构建面向未来的智能 Web 应用。

## Transforming the web together

## 携手重塑 Web

Ship 2024 showcased the power of the web. To catch up on all the announcements, [watch the Keynote](https://vercel.com/ship), and stay tuned for recordings of the customer sessions coming next week.

Ship 2024 全面展现了 Web 的强大潜力。欲了解全部发布内容，请[观看主题演讲](https://vercel.com/ship)，并敬请期待下周上线的客户专场会议录播。

[**Learn how Vercel can help your developer and user experience.**\\
\\
Traditional deployment tools weren’t built for frontend development. Get the DX Platform that has teams shipping 6x faster.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**了解 Vercel 如何提升您的开发者体验与用户体**验。  
\\  
传统部署工具并非为前端开发而设计。选择这款开发者体验（DX）平台，让团队交付速度提升 6 倍。  
\\  
联系我们](https://vercel.com/contact/sales)

Vercel.com landing page

Vercel.com 着陆页

### Power your next AI breakthrough.

### 推动您的下一次 AI 突破。

Vercel.com landing page

Vercel.com 着陆页

### Helping teams ship 6x faster.

### 帮助团队将交付速度提升 6 倍。
{% endraw %}
