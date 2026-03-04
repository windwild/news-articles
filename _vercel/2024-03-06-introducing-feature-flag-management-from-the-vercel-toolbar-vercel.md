---
title: "Introducing feature flag management from the Vercel Toolbar - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/toolbar-feature-flags"
date: "2024-03-06"
scraped_at: "2026-03-02T09:46:34.616791689+00:00"
language: "en-zh"
translated: true
description: "Uplevel your flags workflow with the Vercel Toolbar"
---

render_with_liquid: false
Mar 6, 2024

2024 年 3 月 6 日

从 Optimizely、LaunchDarkly、Statsig、Split、Hypertune 等平台查看并覆盖（override）功能开关（feature flags）。

利用功能开关快速启用或禁用产品功能，早已不仅是一种开发技术；它更是一种推动创新、确保只有最优质、性能最优的功能才能触达用户的工程哲学。

然而，在开发新功能时，你往往需要离开当前浏览器标签页，登录你的功能开关服务提供商后台，将对应开关切换为你开发所需的值——与此同时，你还需与团队成员协调并同步这一变更。这一过程带来了大量额外开销，并严重打断你的工作流。

今天，我们通过在 Vercel 工具栏（Vercel Toolbar）中新增功能开关覆盖能力，让这一工作流变得更轻松：团队成员现在可直接从 Vercel 工具栏[覆盖你应用中的功能开关](https://vercel.com/docs/workflow-collaboration/feature-flags)。

你可管理来自任意服务商的功能开关，包括 [LaunchDarkly](https://launchdarkly.com/)、[Optimizely](https://www.optimizely.com/)、[Statsig](https://www.statsig.com/)、[Hypertune](https://www.hypertune.com/) 或 [Split](https://www.split.io/)；此外，你还可以集成其他任意服务商，甚至你自建的定制化开关系统。只需在工具栏中为开关创建覆盖规则，你便能全程保持专注、无缝迭代，显著提升开发效率。

![](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_002.jpg)

## 全面升级你的功能开关工作流

由于工具栏内管理功能开关的能力仅依赖 API 路由（API Routes）和 `<script>` 标签，因此该功能可与任意前端框架无缝集成。

Vercel 将通过渲染一个包含功能开关实际取值的 `<script>` 标签来读取每个开关的当前值；而开关的元数据（metadata）与描述信息则可通过 API 路由进行传递。在此基础上，你还能为每次会话（per session）单独创建覆盖规则，从而大幅提升质量保障（QA）与测试效率。

**Getting started**

**入门指南**

You can add the Vercel Toolbar to any deployment you’re working on, meaning you can work with your flags in local, preview, or production environments to improve your QA and testing workflow.

您可将 Vercel Toolbar 添加到您正在处理的任意部署中，这意味着您可在本地、预览或生产环境中使用功能标志（feature flags），从而提升质量保证（QA）与测试工作流的效率。

[**Working with the Vercel Toolbar**\\
\\
To enable the toolbar on production or local environments, add it to your project using the @vercel/toolbar package, or with an injection script.\\
\\
Learn more](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost)

[**使用 Vercel Toolbar**\\
\\
如需在生产环境或本地环境中启用该工具栏，请通过 `@vercel/toolbar` 包将其添加至您的项目中，或使用注入脚本。\\
\\
了解详情](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost)

Next, you’ll need to tell the toolbar about the values of your feature flags.

接下来，您需要向工具栏告知您功能标志的具体取值。

For the toolbar to see your feature flags, render a script tag containing your flag values. In React for example, you can use the `FlagValues` component from `@vercel/flags`.

为了让工具栏识别您的功能标志，请渲染一个包含标志取值的 `<script>` 标签。例如，在 React 中，您可以使用 `@vercel/flags` 提供的 `FlagValues` 组件。

```tsx
import { FlagValues } from "@vercel/flags/react"



3<FlagValues values={{ fasterCheckoutPage: true, landingPageRedesign: true }} />
```

```tsx
import { FlagValues } from "@vercel/flags/react"



3<FlagValues values={{ fasterCheckoutPage: true, landingPageRedesign: true }} />
```

Then, you’ll work with `FlagDefinitions` to tell the toolbar about your application’s feature flags, complete with rich metadata.

随后，您将借助 `FlagDefinitions` 向工具栏声明应用程序所支持的功能标志，并为其提供丰富的元数据信息。

```tsx
1// .well-known/vercel/flags/route.ts
```

```tsx
1// .well-known/vercel/flags/route.ts
```

```typescript
import { getLaunchDarklyData } from '@vercel/flags/providers/launchdarkly';

import { NextResponse } from 'next/server';



export async function GET() {

6  const launchDarklyData = await getLaunchDarklyData({

7    apiKey: process.env.LAUNCHDARKLY_API_KEY,

8    projectKey: process.env.LAUNCHDARKLY_PROJECT_KEY,

9    environment: process.env.LAUNCHDARKLY_ENVIRONMENT,

10  });

11  return NextResponse.json(launchDarklyData);
```

```typescript
import { getLaunchDarklyData } from '@vercel/flags/providers/launchdarkly';

import { NextResponse } from 'next/server';



export async function GET() {

6  const launchDarklyData = await getLaunchDarklyData({

7    apiKey: process.env.LAUNCHDARKLY_API_KEY,

8    projectKey: process.env.LAUNCHDARKLY_PROJECT_KEY,

9    environment: process.env.LAUNCHDARKLY_ENVIRONMENT,

10  });

11  return NextResponse.json(launchDarklyData);
```

12}


```

之后，您可以通过读取 `vercel-flag-overrides` Cookie 来尊重工具栏中设置的覆盖规则。

```javascript
import { cookies } from 'next/headers';



export default function Page() {

4  const overrides = cookies().get('vercel-flag-overrides')?.value;

5  return overrides.showNewDashboard ? <NewDashboard /> : <LegacyDashboard />;

6}
```

From the Vercel Toolbar you can view and create overrides, per session, for shorter feedback loops and improved QA and testing. Additionally, the overrides will be stored in an optionally [encrypted cookie](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#encrypting-feature-flag-values) so your application can respect them.

通过 Vercel 工具栏，您可以按会话查看和创建覆盖设置（overrides），从而缩短反馈周期，并提升质量保证（QA）与测试效果。此外，这些覆盖设置将被存储在可选的[加密 Cookie](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#encrypting-feature-flag-values) 中，确保您的应用程序能够识别并遵循这些设置。

![Set the override for each flag to true and press Save.](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_003.jpg)![Set the override for each flag to true and press Save.](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_004.jpg)Set the override for each flag to true and press Save.

![将每个标志的覆盖设置为 true，然后点击“保存”。](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_003.jpg)![将每个标志的覆盖设置为 true，然后点击“保存”。](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_004.jpg)将每个标志的覆盖设置为 true，然后点击“保存”。

### Ship better features faster on Vercel

### 在 Vercel 上更快地交付更优质的特性

Publishing features behind feature flags and allowing QA teams to test them in a production-like environment enhances trust in the release process and allows teams to ship the best features to users.

将新功能置于特性标志（feature flags）之后发布，并允许 QA 团队在类生产环境中进行测试，有助于增强对发布流程的信心，使团队能够将最优质的功能交付给用户。

With Vercel, you eliminate the need for complex coordination between multiple QA teams and automated testing processes, saving valuable time and resources.

借助 Vercel，您无需再协调多个 QA 团队及自动化测试流程，从而节省宝贵的时间与资源。

[**Start interacting with your application’s feature flags.**\\
\\
Unlock the new workflow today: Use the Vercel Toolbar to read and set feature flag overrides for your application.\\
\\
Get started](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)

[**开始与您应用程序的特性标志进行交互。**\\
\\
即刻启用全新工作流：使用 Vercel 工具栏读取并设置您应用程序的特性标志覆盖项。\\
\\
立即开始](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)