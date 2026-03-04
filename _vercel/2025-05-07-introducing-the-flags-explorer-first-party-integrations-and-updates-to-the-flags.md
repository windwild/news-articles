---
render_with_liquid: false
title: "Introducing the Flags Explorer, first-party integrations, and updates to the Flags SDK  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-the-flags-explorer-first-party-integrations-and-updates"
date: "2025-05-07"
scraped_at: "2026-03-02T09:33:33.405616240+00:00"
language: "en-zh"
translated: true
description: "Introducing first-party integrations, the Flags Explorer, and improvements to the Flags SDK to improve feature flag workflow on Vercel."
---
render_with_liquid: false
render_with_liquid: false

May 7, 2025

2025 年 5 月 7 日

Integrating feature flags deeper in your workflow with updates across Vercel

通过 Vercel 全面更新，将功能开关（feature flags）更深度地融入您的工作流

Experimentation, A/B testing, and feature flags serve as essential tools for delivering better user experiences, ensuring smoother rollouts, and empowering teams to iterate quickly with confidence. We're making it easier to bring flags into your workflow with:

实验、A/B 测试与功能开关是提升用户体验、保障发布流程平滑、并赋能团队自信快速迭代的关键工具。我们正通过以下方式，让功能开关更轻松地融入您的工作流：

- [Flags Explorer](https://vercel.com/blog/introducing-first-party-integrations-the-flags-explorer-and-improvements-to-5PV9eaYQW7uIQTFdasvP5H#flags-explorer:-manage-your-flags-in-vercel), now generally available, allowing you to manage feature flags directly from the Vercel Toolbar

- [Flags Explorer](https://vercel.com/blog/introducing-first-party-integrations-the-flags-explorer-and-improvements-to-5PV9eaYQW7uIQTFdasvP5H#flags-explorer:-manage-your-flags-in-vercel)（现已全面开放），支持您直接通过 Vercel Toolbar 管理功能开关

- New first-party integrations with flag providers on the [Vercel Marketplace](https://vercel.com/blog/introducing-the-flags-explorer-first-party-integrations-and-updates#experimentation-on-the-vercel-marketplace,-featuring-statsig)

- 新增与功能开关服务商的官方集成，已在 [Vercel Marketplace](https://vercel.com/blog/introducing-the-flags-explorer-first-party-integrations-and-updates#experimentation-on-the-vercel-marketplace,-featuring-statsig) 上线

- Updates to the [Flags SDK](https://vercel.com/blog/introducing-the-flags-explorer-first-party-integrations-and-updates#flags-sdk:-working-with-flags-in-code) and new adapters

- [Flags SDK](https://vercel.com/blog/introducing-the-flags-explorer-first-party-integrations-and-updates#flags-sdk:-working-with-flags-in-code) 的更新及新增适配器

## Flags Explorer: Manage your flags in Vercel

## Flags Explorer：在 Vercel 中管理您的功能开关

The [Flags Explorer](https://vercel.com/docs/feature-flags/using-vercel-toolbar) in the [Vercel Toolbar](https://vercel.com/docs/vercel-toolbar) gives you a clear view of all feature flags and lets you override their values directly from the toolbar, simplifying testing and experimentation. This feature is now generally available for users on all plans.

[Flags Explorer](https://vercel.com/docs/feature-flags/using-vercel-toolbar) 集成于 [Vercel Toolbar](https://vercel.com/docs/vercel-toolbar) 中，为您提供所有功能开关的清晰视图，并支持直接在工具栏中覆盖其值，从而简化测试与实验流程。该功能现已面向所有订阅计划的用户全面开放。

![See and override your feature flags in the Vercel Toolbar with the Flags Explorer.](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_001.jpg)![See and override your feature flags in the Vercel Toolbar with the Flags Explorer.](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_002.jpg)![See and override your feature flags in the Vercel Toolbar with the Flags Explorer.](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_003.jpg)![See and override your feature flags in the Vercel Toolbar with the Flags Explorer.](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_004.jpg)

通过 Flags Explorer，在 Vercel Toolbar 中查看并覆盖您的功能开关。

Flags Explorer lets you override feature flags for your own session, without affecting colleagues, and without signing into your flag provider. This lets you test features in production before they go live for everyone and keeps you in the flow. You can also use the Flags Explorer to demo upcoming features, or share overrides with team members to collect feedback or test and QA.

Flags Explorer 允许您仅针对自己的会话覆盖功能标志（feature flags），既不会影响同事，也无需登录您的标志提供方。这使您能够在功能面向全体用户上线前，直接在生产环境中进行测试，同时保持高效的工作流。您还可以利用 Flags Explorer 向团队成员演示即将推出的功能，或共享标志覆盖配置，以便收集反馈、开展测试与质量保障（QA）工作。

## Experimentation on the Vercel Marketplace, featuring Statsig

## Vercel Marketplace 上的实验功能专区（首发支持 Statsig）

The new [Experimentation category](https://vercel.com/marketplace?category=experimentation) on the [Vercel Marketplace](https://vercel.com/marketplace) lets you integrate experimentation and feature flagging tools into your project, deployment workflows, and release processes without needing separate accounts for the provider.

Vercel Marketplace 全新上线的 [实验（Experimentation）分类](https://vercel.com/marketplace?category=experimentation)，让您无需为第三方服务商单独注册账号，即可将实验平台与功能标志工具无缝集成至项目、部署流程及发布流程中。

Our launch partner, [Statsig](https://www.statsig.com/blog/statsig-vercel-native-integration), provides a powerful feature flagging and experimentation platform that helps teams test and iterate on new features with confidence.

本次首发合作伙伴 [Statsig](https://www.statsig.com/blog/statsig-vercel-native-integration) 提供功能强大、开箱即用的功能标志与实验平台，助力团队自信地测试并持续迭代新功能。

![](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_005.jpg)![](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_006.jpg)

![](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_005.jpg)![](images/introducing-the-flags-explorer-first-party-integrations-and-updates-to-the-flags/img_006.jpg)

By using [Statsig on the Vercel Marketplace](https://vercel.com/marketplace/statsig), you’ll get:

通过在 Vercel Marketplace 中使用 [Statsig](https://vercel.com/marketplace/statsig)，您将获得以下优势：

- Quick setup: Configure Statsig with just a few clicks  
- 快速配置：仅需数次点击即可完成 Statsig 设置  

- Managed configuration: Environment variables and API keys are preconfigured  
- 托管式配置：环境变量与 API 密钥均已预先配置就绪  

- Consistent deployments **:** Maintain consistent settings and version history across deployments, helping ensure that experiments run reliably across all environments  
- 部署一致性 **：** 在各次部署中保持配置与版本历史的一致性，确保实验在所有环境中稳定可靠地运行  

- Low-latency flag evaluation: Sync feature flags into Vercel's [Edge Config](https://vercel.com/docs/edge-config), reducing network requests and ensuring flags work even if the provider is down  
- 低延迟标志求值：将功能标志同步至 Vercel 的 [Edge Config](https://vercel.com/docs/edge-config)，显著减少网络请求，并确保即使标志提供方服务中断，功能标志仍可正常工作

[**Try the template**  
**尝试该模板**

Try Statsig's first-party experimentation integration on the Vercel Marketplace.  
在 Vercel Marketplace 上试用 Statsig 的第一方实验集成。

Get started  
立即开始](https://vercel.com/templates/next.js/statsig-experimentation-with-flags-sdk)

If you’re building an experimentation platform or feature flags solution and you’re interested in featuring your product in the Vercel Marketplace’s Experimentation category, contact us at [integrations@vercel.com](mailto:integrations@vercel.com) or refer to our [provider documentation](https://vercel.com/marketplace-providers) to get started.  
如果您正在构建实验平台或功能开关（feature flags）解决方案，并希望将您的产品列入 Vercel Marketplace 的“实验（Experimentation）”类别，请通过 [integrations@vercel.com](mailto:integrations@vercel.com) 联系我们，或参阅我们的 [服务商文档（provider documentation）](https://vercel.com/marketplace-providers) 以了解入门方法。

## Flags SDK: Working with flags in code  
## Flags SDK：在代码中使用功能开关

The [Flags SDK](https://flags-sdk.dev/) is an open-source library that gives developers tools to integrate feature flags in Next.js and SvelteKit applications.  
[Flags SDK](https://flags-sdk.dev/) 是一个开源库，为开发者提供工具，以便在 Next.js 和 SvelteKit 应用中集成功能开关（feature flags）。

```bash
npm i flags
```

`flags` works with popular providers like Statsig, other third-party tools, or your own custom solution. Whether you're running A/B tests, rolling out new features gradually, or personalizing user experiences, the SDK provides a flexible way to control features at runtime without redeploying.  
`flags` 支持主流服务商（如 Statsig）、其他第三方工具，或您自定义的解决方案。无论您是在运行 A/B 测试、渐进式发布新功能，还是个性化用户界面体验，该 SDK 都能在不重新部署应用的前提下，于运行时灵活地控制各项功能。

```tsx
import { flag } from 'flags/next';



export const exampleFlag = flag({

4  key: 'example-flag',

```markdown
5  decide() {

6    return false;

7  },

8});
```

```markdown
5  decide() {

6    返回 false;

7  },

8});
```

Importing and evaluating flags using the Flags SDK.

使用 Flags SDK 导入和评估功能标志。

The Flags SDK now supports loading feature flags directly from [many providers](https://flags-sdk.dev/providers) through a new adapters architecture, with more providers coming soon. This simplifies connecting your code to a feature flag provider using the Flags SDK. For example, the [`@flags-sdk/statsig`](https://flags-sdk.com/api-reference/provider/statsig) package allows you to manage your Statsig flags directly within Vercel in the Flags Explorer.

Flags SDK 现在通过全新的适配器（adapters）架构，支持直接从[众多服务商](https://flags-sdk.dev/providers)加载功能标志，更多服务商即将上线。这大幅简化了您通过 Flags SDK 将代码接入功能标志服务商的过程。例如，[`@flags-sdk/statsig`](https://flags-sdk.com/api-reference/provider/statsig) 包允许您在 Vercel 的 Flags Explorer 中直接管理 Statsig 功能标志。

## Get started with flags on Vercel

## 在 Vercel 上快速开始使用功能标志

By integrating experimentation tools like Statsig directly into your Vercel workflow, you can accelerate iteration velocity, reduce risk, and deliver personalized user experiences. This new category on the Marketplace, combined with Vercel's existing feature flag capabilities, will empower you to build more quickly and confidently.

将 Statsig 等实验工具直接集成到您的 Vercel 工作流中，可显著提升迭代速度、降低发布风险，并为用户提供个性化体验。Marketplace 中这一全新类别，结合 Vercel 现有的功能标志能力，将助您更快速、更自信地构建应用。

[**Check out the documentation**\\
\\
Dive in and learn how to use feature flags with Vercel's DX platform.\\
\\
Get started](https://vercel.com/docs/feature-flags)

[**查看文档**\\
\\
深入学习如何在 Vercel 的开发者体验（DX）平台上使用功能标志。\\
\\
立即开始](https://vercel.com/docs/feature-flags)
```