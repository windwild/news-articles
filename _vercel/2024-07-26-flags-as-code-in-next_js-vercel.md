---
title: "Flags as Code in Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/flags-as-code-in-next-js"
date: "2024-07-26"
scraped_at: "2026-03-02T09:42:33.316537142+00:00"
language: "en-zh"
translated: true
description: "The Flags SDK is a free open-source library that gives developers the tools they need to use feature flags in Next.js and SvelteKit applications."
---
{% raw %}

Jul 26, 2024

2024 年 7 月 26 日

Exploring the usage of feature flags in Next.js with Vercel's Flags SDK.

探索在 Next.js 中结合 Vercel 的 Flags SDK 使用功能开关（feature flags）。

We recently introduced a new [Flags SDK](https://flags-sdk.dev/) that allows using feature flags, in Next.js and SvelteKit, and works with any feature flag provider—or when using no flag provider at all. It's not meant to be a competitor to other feature flag providers. Instead, it’s a tool that sits between your application and the source of your flags, helping you follow best practices for using feature flags and experiments, keeping your website fast.

我们近期推出了全新的 [Flags SDK](https://flags-sdk.dev/)，支持在 Next.js 和 SvelteKit 中使用功能开关，并兼容任意功能开关服务提供商——甚至完全不依赖任何外部提供商亦可运行。它并非旨在与其他功能开关服务商竞争；相反，它是一个介于你的应用程序与功能开关数据源之间的工具，帮助你遵循功能开关与实验（experiments）的最佳实践，同时保障网站性能。

Follow along below to get started with the Flags SDK, beginning with a simple feature flag to more sophisticated cases, discussing tradeoffs along the way.

请继续阅读下文，了解如何快速上手 Flags SDK：我们将从一个简单的功能开关示例出发，逐步过渡到更复杂的使用场景，并在过程中分析各类方案的权衡取舍（tradeoffs）。

# Contents

# 目录

01. [Basic start](https://vercel.com/blog/flags-as-code-in-next-js#basic-start)  
01. [基础入门](https://vercel.com/blog/flags-as-code-in-next-js#basic-start)  
02. [Guiding principles of the Flags SDK](https://vercel.com/blog/flags-as-code-in-next-js#guiding-principles-of-the-flags-sdk)  
02. [Flags SDK 的设计原则](https://vercel.com/blog/flags-as-code-in-next-js#guiding-principles-of-the-flags-sdk)  
03. [Feature Flags are functions](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-functions)  
03. [功能开关即函数](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-functions)  
04. [Feature Flags are only ever evaluated on the server](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-only-ever-evaluated-on-the-server)  
04. [功能开关仅在服务端求值](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-only-ever-evaluated-on-the-server)  
05. [Feature Flags accept no arguments on the call side](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-accept-no-arguments-on-the-call-side)  
05. [调用端的功能开关不接受任何参数](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-accept-no-arguments-on-the-call-side)  
06. [A primitive flag](https://vercel.com/blog/flags-as-code-in-next-js#a-primitive-flag)  
06. [基础型开关](https://vercel.com/blog/flags-as-code-in-next-js#a-primitive-flag)  
07. [Flag progressions and their tradeoffs](https://vercel.com/blog/flags-as-code-in-next-js#flag-progressions-and-their-tradeoffs)  
07. [开关演进路径及其权衡取舍](https://vercel.com/blog/flags-as-code-in-next-js#flag-progressions-and-their-tradeoffs)  
08. [Basic case](https://vercel.com/blog/flags-as-code-in-next-js#basic-case)  
08. [基础用例](https://vercel.com/blog/flags-as-code-in-next-js#basic-case)  
09. [Overriding from Vercel Toolbar](https://vercel.com/blog/flags-as-code-in-next-js#overriding-from-vercel-toolbar)  
09. [通过 Vercel 工具栏覆盖开关值](https://vercel.com/blog/flags-as-code-in-next-js#overriding-from-vercel-toolbar)  
10. [Using an environment variable](https://vercel.com/blog/flags-as-code-in-next-js#using-an-environment-variable)  
10. [使用环境变量](https://vercel.com/blog/flags-as-code-in-next-js#using-an-environment-variable)  
11. [Using Edge Config](https://vercel.com/blog/flags-as-code-in-next-js#using-edge-config)  
11. [使用 Edge Config](https://vercel.com/blog/flags-as-code-in-next-js#using-edge-config)  
12. [A primer on Edge Config](https://vercel.com/blog/flags-as-code-in-next-js#a-primer-on-edge-config)  
12. [Edge Config 入门指南](https://vercel.com/blog/flags-as-code-in-next-js#a-primer-on-edge-config)  
13. [Using a feature flag provider](https://vercel.com/blog/flags-as-code-in-next-js#using-a-feature-flag-provider)  
13. [接入功能开关服务提供商](https://vercel.com/blog/flags-as-code-in-next-js#using-a-feature-flag-provider)  
14. [A note on init time](https://vercel.com/blog/flags-as-code-in-next-js#a-note-on-init-time)  
14. [关于初始化时机的说明](https://vercel.com/blog/flags-as-code-in-next-js#a-note-on-init-time)  
15. [OpenFeature](https://vercel.com/blog/flags-as-code-in-next-js#openfeature)  
15. [OpenFeature](https://vercel.com/blog/flags-as-code-in-next-js#openfeature)  
16. [Get started today](https://vercel.com/blog/flags-as-code-in-next-js#get-started-today)  
16. [立即开始使用](https://vercel.com/blog/flags-as-code-in-next-js#get-started-today)

[**Try the template**\\
\\
Jump right in with this ecommerce example that shows how to use the Flags SDK for Next.js applications. Deploy the template with one click. \\
\\
Get started](https://vercel.com/templates/next.js/shirt-shop-feature-flags)

[**尝试该模板**\\
\\
立即体验这个电商示例，了解如何在 Next.js 应用中使用 Flags SDK。一键部署即可上手。\\
\\
开始使用](https://vercel.com/templates/next.js/shirt-shop-feature-flags)

## Basic start

## 基础入门

Install the Flags SDK using `npm install flags`.

使用命令 `npm install flags` 安装 Flags SDK。

Then declare a simple feature flag for Next.js like this:

然后，按如下方式为 Next.js 声明一个简单的功能开关：

`flags.ts`

`flags.ts`

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

随后，我们可在任意服务端上下文中调用 `showBanner` 这一特性开关函数：

随后，我们可在任意服务端上下文中调用 `showBanner` 这一特性开关函数：

`app/page.tsx`

`app/page.tsx`

```tsx
import { showBanner } from "../flags";
```

```tsx
import { showBanner } from "../flags";
```

```ts
export default async function Page() {

export default async function Page() {

4  const banner = await showBanner();

4  const banner = await showBanner();

5  return (

5  return (

6    <div>

6    <div>

7      {banner ? <Banner /> : null}

7      {banner ? <Banner /> : null}

8      {/* other components */}

8      {/* 其他组件 */}

9    </div>

9    </div>

10  );

10  );

11}
```
```

Calling `await showBanner()` returns the value of our feature flag. Since the `decide` function is set to always return `false`, the banner will not be shown.

调用 `await showBanner()` 将返回我们功能标志（feature flag）的值。由于 `decide` 函数被设定为始终返回 `false`，因此横幅（banner）将不会显示。

**_Tip:_** _Use_ [_Flags Explorer_](https://vercel.com/docs/feature-flags/flags-explorer) _to override any feature flags for your own session without affecting your team members. Overrides are great for ensuring features work before you release them for everyone. Flags SDK automatically respects overrides set by Flags Explorer._

**_提示：_** 请使用 [_Flags Explorer（标志探索器）_](https://vercel.com/docs/feature-flags/flags-explorer)，在不影响团队其他成员的前提下，为你自己的会话覆盖任意功能标志。覆盖功能非常适合在面向全体用户发布新功能前，验证其是否正常工作。Flags SDK 会自动尊重 Flags Explorer 所设置的覆盖规则。

## Guiding principles of the Flags SDK

## Flags SDK 的设计原则

There are several differences to how the SDKs of most feature flagging providers work today. It’s an abstraction that both encodes our best practices for working with feature flags in Next.js, while also allowing you to easily transition between different sources for your feature flags.

当前主流功能标志服务提供商的 SDK 在工作方式上存在诸多差异。Flags SDK 是一种抽象层：它既内嵌了我们在 Next.js 中使用功能标志的最佳实践，又支持你轻松地在不同功能标志数据源之间切换。

![](images/flags-as-code-in-next_js-vercel/img_001.jpg)![](images/flags-as-code-in-next_js-vercel/img_002.jpg)

### **Feature Flags are functions**

### **功能标志即函数**

Turning each feature flag into its own function means the implementation can change without having to touch the call side. It also allows you to use your well-known editor aids like “Find All References” to see if a flag is still in use.

将每个功能标志封装为独立函数，意味着其实现逻辑可随时变更，而无需修改调用方代码。此外，你还能借助熟悉的编辑器功能（例如“查找所有引用”）快速确认某个标志是否仍在使用中。

### **Feature Flags are only ever evaluated on the server**

### **功能标志仅在服务端求值**

Flags are only ever calculated on the server. The resolved value can be passed down to the client, but the evaluation itself happens server-side. This approach mitigates common pitfalls of client-side feature flag usage, such as layout shifts, jank, or exposing sensitive flags to the client.

功能标志的计算始终发生在服务端。解析后的值可向下传递至客户端，但求值过程本身严格限定于服务端执行。该设计有效规避了客户端功能标志常见的若干问题，例如布局偏移（layout shifts）、界面卡顿（jank），或敏感标志意外暴露给客户端。

When loading feature flags client-side there are hard limitations where the client simply doesn’t know the state of feature flags until they initialize. This means you’re left picking the worse of two evils: showing a loading spinner or potentially flashing the wrong variant until loading completes. That’s why we always force server-side evaluation.

当在客户端加载功能标志时，存在固有局限：客户端必须等待初始化完成，才能获知功能标志的实际状态。这迫使开发者只能在两种不理想的方案中二选一：要么显示加载指示器（spinner），要么在加载完成前短暂展示错误的变体（variant），即所谓“闪烁”（flashing）。正因如此，我们始终坚持强制在服务端完成求值。

![](images/flags-as-code-in-next_js-vercel/img_003.jpg)![](images/flags-as-code-in-next_js-vercel/img_004.jpg)

![](images/flags-as-code-in-next_js-vercel/img_003.jpg)![](images/flags-as-code-in-next_js-vercel/img_004.jpg)

However, server-side evaluation doesn't necessarily mean dynamic pages. The SDK introduces a pattern called _precomputing,_ which enables generating multiple variants of a static page and using [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) to route between them. This allows keeping pages completely static even when they have multiple feature flags on them. It’s especially beneficial for experimentation on marketing pages, but it also works extremely well for serving multiple static shells for [Partial Prerendering](https://vercel.com/docs/frameworks/nextjs#partial-prerendering).

然而，服务端求值并不一定意味着页面是动态的。该 SDK 引入了一种称为**预计算（precomputing）**的模式，它支持为静态页面生成多个变体，并借助 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) 在这些变体之间进行路由。这使得即使页面上启用了多个功能开关（feature flags），仍能完全保持其静态特性。该模式对营销页面上的 A/B 实验尤其有益；同时，它也非常适用于为 [Partial Prerendering（部分预渲染）](https://vercel.com/docs/frameworks/nextjs#partial-prerendering) 提供多个静态 Shell。

You can learn more about precomputing feature flags [here](https://flags-sdk.dev/principles/precompute).

您可在此处了解更多关于功能开关预计算的信息：[此处](https://flags-sdk.dev/principles/precompute)。

### **Feature Flags accept no arguments on the call side**

### **调用侧的功能开关不接受任何参数**

When we declared the `showBanner` feature flag we provided a `decide` function. This function is called to determine the value of a feature flag for a given request.

当我们声明 `showBanner` 功能开关时，我们提供了一个 `decide` 函数。该函数会在每次请求时被调用，以确定该功能开关在当前请求下的取值。

On the call side, when using `showBanner()` it’s not possible to provide any arguments to the `showBanner` function. It would technically be trivial for us to forward the passed arguments to the decided function, but we introduced this limitation on purpose.

在调用侧，使用 `showBanner()` 时无法向该函数传入任何参数。技术上讲，将调用方传入的参数透传给 `decide` 函数是轻而易举的，但我们刻意引入了这一限制。

Not being able to pass any information from the call side means the feature flag itself must be able to gather all information it depends on. We can use Next.js concepts like `headers()` and `cookies()` to gather information about the current request from within the `decide` function. We can further call React’s [cache](https://react.dev/reference/react/cache) function to ensure expensive computation and data loading is deduplicated across feature flags.

调用侧无法传递任何信息，意味着功能开关自身必须有能力获取其所有依赖的数据。我们可在 `decide` 函数内部利用 Next.js 提供的 `headers()` 和 `cookies()` 等 API，获取当前请求的相关上下文信息；还可进一步调用 React 的 [cache](https://react.dev/reference/react/cache) 函数，确保耗时的计算与数据加载操作在多个功能开关之间自动去重。

This means any call side is guaranteed to see the same value of the feature flag since they all by definition provide the same arguments.

这意味着：由于所有调用方本质上都“不提供任何参数”，因此它们必然获得完全一致的功能开关取值。

It also means we can locally reason about the value a feature flag will resolve to, since we only need to look at the given `decide` function. This is huge for being able to change the implementation without having to change the call side. It allows migrating from one flag provider to another, on a flag by flag basis, while only changing a single file.

这也意味着：我们仅需审视给定的 `decide` 函数，即可在本地准确推断出该功能开关最终解析出的值。这对实现“无需修改调用侧代码即可变更底层实现”至关重要。例如，我们可以按功能开关逐个迁移——从一个旗标（flag）提供商切换到另一个，整个过程只需修改单个文件。

And finally, it’s brilliant for delete-ability of feature flags. When you remove a feature flag from code all the data it relied on will no longer be requested. There is no context that’s being established outside of the flag that ultimately ends up unused and any data requirements are deleted along with the flag.

最后，这一设计对功能开关的**可删除性（delete-ability）**极为友好。当你从代码中移除某个功能开关时，它所依赖的所有数据也将随之停止请求；不会存在任何在开关外部建立、却最终未被使用的上下文，所有相关数据依赖都会随该功能开关一同被彻底清除。

## A primitive flag

## 原始标志（Feature Flag）

Let’s bring flags back to their most basic form before diving deeper into the SDK.

让我们在深入探索 SDK 之前，先将标志回归到其最基础的形式。

```tsx
const showBanner = false;
```

```tsx
const showBanner = false;
```

Even a variable in code could can be seen as a feature flag. By changing the value and redeploying you’re able to modify the behavior of the application.

即使代码中的一个变量，也可被视为一个功能标志。通过修改其值并重新部署，你就能改变应用程序的行为。

The value of this feature flag could be loaded from a configuration file, an environment variable, a database or a feature flag provider. The value could be the same for all visitors, or maybe it depends on information present on the request which triggered the evaluation of this feature flag. For example a flag might be on for visitors from a certain region only.

该功能标志的值可从配置文件、环境变量、数据库或专门的功能标志服务提供商处加载。该值对所有访问者可能完全相同；也可能取决于触发该标志求值的请求中所携带的信息。例如，某个标志可能仅对来自特定地区的访问者启用。

Or maybe the value of a flag even depends on data which first needs to be derived from the incoming request. Imagine a flag which should only be on for users who are part of a certain team. When your application receives a request with an Authorization header, it would first need to validate the provided token, and then potentially check whether that user is part of said team.

又或者，某个标志的值甚至依赖于需先从入站请求中推导出的数据。设想这样一个标志：它仅对属于某特定团队的用户启用。当你的应用接收到一个带有 `Authorization` 头的请求时，首先需要验证所提供的令牌，然后才可能进一步检查该用户是否属于前述团队。

## Flag progressions and their tradeoffs

## 标志演进路径及其权衡取舍

Let's explore various progressions of using feature flags and their respective trade-offs.

让我们探讨功能标志在实际应用中的多种演进路径，以及每种路径所对应的利弊权衡。

### Basic case

### 基础用法

As we’ve seen, in its most basic form, you declare a feature flag like this when using the SDK:

如前所述，在最基础的形式下，使用 SDK 时可按如下方式声明一个功能标志：

flags.ts

flags.ts

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

In the earlier example we’ve set the `showBanner` flag’s `decide` function to always return false. So if we merged this to production the banner would always be hidden. If we wanted to turn the flag on, we could change the `decide` function to return true and redeploy.

在前面的例子中，我们将 `showBanner` 标志的 `decide` 函数设置为始终返回 `false`。因此，若将此代码合并至生产环境，横幅（banner）将始终处于隐藏状态。如果我们希望启用该标志，只需将 `decide` 函数改为返回 `true` 并重新部署即可。

This is really the simplest possible case of a feature flag. We’ll of course get into more advanced cases in a bit, but let’s first see what this basic usage gives us and where it falls short.

这确实是功能标志（feature flag）最简单的一种用法。当然，我们稍后会深入探讨更高级的应用场景；但首先，让我们看看这种基础用法能带来哪些优势，又存在哪些不足。

**Upsides**

**优势**

- **The flag resolves immediately**. As we hardcoded the value there is no network latency to resolve the flag.

- **该标志立即生效**。由于我们已将值硬编码，因此无需网络请求，不存在解析延迟。

- **Availability**. As we hardcoded the value it will always be available.

- **可用性高**。由于值已硬编码，该标志始终可用。

- **Change history**. We can see who changed the values through git.

- **变更历史清晰**。我们可通过 Git 追溯到是谁修改了这些值。


**Downsides**

**缺点**

- **Slow to change**. Changing the value requires making code changes and redeploying.

- **变更速度慢**。修改值需改动代码并重新部署。

- **Change bound to deployment.** We can’t change the value of a feature flag without redeploying. This means any existing deployments will never see the new value. And any deployments on other branches will not see the new value until our code change makes it onto that branch.

- **变更与部署强耦合**。不重新部署就无法更改功能标志的值。这意味着所有已存在的部署永远无法感知新值；而其他分支上的部署，也需等到我们的代码变更合并至该分支后，才能看到新值。

- **Changes affect everyone**. By hardcoding the boolean value we force the same value for every visitor.

- **变更影响全体用户**。通过硬编码布尔值，我们强制为所有访问者统一启用或禁用该功能。


### Overriding from Vercel Toolbar

### 通过 Vercel 工具栏覆盖标志值

The Vercel Toolbar is available on preview and production deployments, locally during development. Learn how to set it up [for production](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production) and [for development](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost).

Vercel 工具栏支持预览环境、生产环境部署，以及本地开发环境。了解如何在[生产环境](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production)和[开发环境](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost)中启用它。

> “We were able to use ‌‌‍‌the Flags SDK and Vercel's Flags Explorer to override a flag and place real-life orders in production before revealing a set of new payment methods to our customers. This setup gives us peace of mind and makes releasing new features almost boring as we've already seen them working behind the flag.We were able to use ‌‌‍‌the Flags SDK and Vercel's Flags Explorer to override a flag and place real-life orders in production before revealing a set of new payment methods to our customers. This setup gives us peace of mind and makes releasing new features almost boring as we've already seen them working behind the flag.”
>
> “我们成功借助 Flags SDK 和 Vercel 的 Flags Explorer 覆盖了某项标志，在向客户正式推出一组新的支付方式之前，已在生产环境中完成真实订单的下单验证。这一机制让我们倍感安心；而新功能的上线过程也变得‘平淡无奇’——因为我们早已在标志掩护下反复验证过其实际运行效果。”
>
> ![](images/flags-as-code-in-next_js-vercel/img_005.png)
>
> ![](images/flags-as-code-in-next_js-vercel/img_005.png)
>
> **Phil Wolstenholme,** Lead Frontend Engineer at Co-op
>
> **菲尔·沃尔斯滕霍姆（Phil Wolstenholme）**，Co-op 首席前端工程师

Vercel Toolbar allows viewing and overriding your feature flags.  
Vercel 工具栏支持查看和覆写您的功能标志（feature flags）。

When you use our Flags SDK you can expose your application’s feature flags [through an endpoint](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#flags-api-endpoint) called `/.well-known/vercel/flags`.  
当您使用我们的 Flags SDK 时，可通过一个名为 `/.well-known/vercel/flags` 的端点公开应用程序的功能标志（详情请参阅[文档](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#flags-api-endpoint)）。

Vercel Toolbar will make an authenticated request to that endpoint to load your application’s flags. The flags you return from there will show up in your toolbar.  
Vercel 工具栏将向该端点发起经过身份验证的请求，以加载您应用程序的功能标志。您从此端点返回的所有标志都会显示在工具栏中。

![](images/flags-as-code-in-next_js-vercel/img_006.jpg)![](images/flags-as-code-in-next_js-vercel/img_007.jpg)

You can then override flags using the flags dialog in the toolbar. Any flags declared through the `flag` function from `flags/next` will automatically respect overrides set by the toolbar.  
随后，您可通过工具栏中的标志对话框覆写各项标志。所有通过 `flags/next` 中的 `flag` 函数声明的标志，将自动遵循工具栏所设置的覆写值。

So when there is an override and you call the `showBanner` feature flag function it will return the override you set from the toolbar instead of calling the `decide` function you declared.  
因此，当存在覆写时，若您调用 `showBanner` 功能标志函数，它将直接返回您在工具栏中设定的覆写值，而**不会**调用您自行定义的 `decide` 函数。

The way this works behind the scenes is that Vercel Toolbar sets a cookie called `vercel-flag-overrides` whenever you create an override. That cookie contains the name and value of each overridden feature flag. The cookie is also encrypted to prevent attackers from inserting arbitrary flag values. This allows any application to respect these overrides. And if you use the Flags SDK for Next.js they get respected automatically.  
该机制在后台的工作原理是：每当您创建一项覆写时，Vercel 工具栏便会设置一个名为 `vercel-flag-overrides` 的 Cookie。该 Cookie 包含每个被覆写功能标志的名称与对应值，并经过加密处理，以防止攻击者注入任意标志值。这使得任何应用程序均可识别并遵循这些覆写；若您使用的是 Next.js 版 Flags SDK，则覆写将被**自动识别并生效**。

This is important because when we set the `decide` function to always return `false`, this allows us to merge our feature to production without showing it to anyone yet.  
这一点至关重要：当我们把 `decide` 函数设为始终返回 `false` 时，即可将新功能合并至生产环境，而**暂不对任何用户开放**。

**Safe releases**  
**安全发布**

We could then use Vercel Toolbar to override the `banner` feature flag, so we can peek what the feature would look like and ensure it works correctly in production before turning it on for everyone.  
接着，我们可借助 Vercel 工具栏覆写 `banner` 功能标志，从而预先查看该功能在生产环境中的实际效果，并验证其运行是否正确，待确认无误后再面向全体用户启用。

**Short-lived branches**  
**短生命周期分支**

Another benefit of this approach is using small branches and merging new functionality early, while keeping it hidden. This approach is called _trunk based development_. Splitting work into small branches that are merged early helps prevent long running branches that get out of sync with main, which helps avoid merge conflicts down the road.  
该方案的另一大优势在于：采用小型分支，并尽早合并新功能，同时保持其对用户不可见。这种开发模式被称为**主干开发（Trunk-Based Development, TBD）**。将工作拆分为多个小型分支并尽早合入主干，有助于避免长期存在的分支与主分支（`main`）脱节，从而显著降低未来出现合并冲突的风险。

**End-to-end testing**

**端到端测试**

Another benefit is that your end-to-end tests can call the [encrypt](https://vercel.com/docs/workflow-collaboration/feature-flags/vercel-flags#encrypt) function to create a flag override cookie value to be used in your tests. This way your end-to-end test can easily test multiple scenarios.

另一大优势是，您的端到端测试可以调用 [encrypt](https://vercel.com/docs/workflow-collaboration/feature-flags/vercel-flags#encrypt) 函数，生成一个用于测试的标志覆盖 Cookie 值。这样，您的端到端测试便能轻松覆盖多种场景。

_**Note:**_ _This approach is perfect for trunk-based development. You can merge your code and try it out in production, without introducing latency or long running branches. And you don’t even need to use any feature flagging provider, suffer any additional latency or take any risks on availability._

_**注意：**_ _该方法非常适合基于主干（trunk-based）的开发模式。您可直接合并代码并在生产环境中试运行，既不会引入额外延迟，也无需维护长期存在的分支。此外，您甚至无需依赖任何功能标志（feature flagging）服务提供商，不会承受额外延迟，也无需承担可用性风险。_

## Using an environment variable

## 使用环境变量

Instead of hardcoding our `decide` function to always return `false` we could check an environment variable instead.

与其将 `decide` 函数硬编码为始终返回 `false`，不如改为检查一个环境变量。

```tsx
export const showBanner = flag({

2  key: "banner",

3  decide: () => process.env.SHOW_BANNER === "1",

4});
```

```tsx
export const showBanner = flag({

2  key: "banner",

3  decide: () => process.env.SHOW_BANNER === "1",

4});
```

This small change means we can change the feature flag for our end users without making code changes. Imagine setting the `SHOW_BANNER` environment variable to be on for preview deployments of a specific branch, but to be off for production. This way you could test the banner on those preview deployments without showing it to your users in production yet. You could still use Vercel Toolbar to override the flag in production once the branch merges.

这一微小改动意味着，我们无需修改代码即可动态调整面向终端用户的功能标志。例如，您可以将 `SHOW_BANNER` 环境变量设为在某一分支的预览部署中启用（值为 `"1"`），而在生产环境中禁用（值非 `"1"`）。如此一来，您便可在预览环境中测试横幅功能，而不会提前向生产环境用户展示。待该分支合并后，您仍可借助 Vercel Toolbar 在生产环境中手动覆盖该标志。

When it’s time to release the feature to production you simply flip the environment variable.

当该功能准备上线生产环境时，您只需切换环境变量即可。

And since we hardcoded the environment variable we would still have the highest possible availability, paired with the lowest possible latency for this flag.

由于我们已将环境变量硬编码，此特性开关仍能保持最高的可用性，同时实现最低的延迟。

Changing the flag would still require redeploying, so changing the feature flag would not affect previous deployments. This is usually not what you want, and we can solve it using Edge Config in the next step.

更改该开关仍需重新部署，因此对特性开关的修改不会影响此前已完成的部署。这通常并非我们所期望的行为；下一步我们将借助 Edge Config 解决这一问题。

_**Note:**_ _This approach is perfect for operational feature flags. Imagine swapping out a backend service like a payment gateway in case one is having issues._

_**注意：**_ _此方法非常适合运维类特性开关。例如，当某个支付网关出现故障时，可快速将其切换为备用后端服务。_

## Using Edge Config

## 使用 Edge Config

So far, any changes to the flags required redeploying, and did not affect any existing deployments. In this step we’ll change that.

截至目前，所有对特性开关的修改均需重新部署，且不会影响任何已存在的部署。在本步骤中，我们将改变这一现状。

The `decide` function can actually be asynchronous, which allows us to read any data source. You can imagine querying a database, or reading from an external configuration source.

`decide` 函数实际上可以是异步的，从而允许我们读取任意数据源。您可以设想查询数据库，或从外部配置源读取数据。

### **A primer on Edge Config**

### **Edge Config 简介**

At Vercel we’ve built a data store tailored to storing feature flags and other configuration called [Edge Config](https://vercel.com/docs/storage/edge-config). Edge Config uses active global replication to push and colocate your configuration along with your compute. Reading Edge Config from applications deployed on Vercel typically takes under 1ms p90. Changes to Edge Config propagate globally in under 10s. It’s extremely available and most Edge Config reads do not even go over the network. We can achieve these outstanding features since we handle your deployments, so we’re in a unique position to also propagate configuration data along with them.

Vercel 构建了一种专用于存储特性开关及其他配置的数据存储服务，名为 [Edge Config](https://vercel.com/docs/storage/edge-config)。Edge Config 采用主动式全球复制机制，将您的配置与计算资源一同推送并就近部署（colocate）。在 Vercel 上部署的应用程序读取 Edge Config 的 P90 延迟通常低于 1 毫秒；Edge Config 的变更可在 10 秒内完成全球同步。它具备极高的可用性，且绝大多数 Edge Config 读取操作甚至无需经过网络传输。之所以能实现这些卓越特性，是因为我们全面托管您的部署流程，因而也处于独特位置，可将配置数据与应用部署同步分发。

Okay, back to using an external data source like Edge Config from our Flags SDK.

好了，现在回到如何在我们的 Flags SDK 中使用 Edge Config 这类外部数据源。

The following code assumes your project is connected to an Edge Config which holds this data:

以下代码假设您的项目已连接到一个包含该数据的 Edge Config：

```tsx
1{

2	"flags": {

3		"banner": true,

4		"sale": false

5	}

6}
```

```tsx
1{

2	"flags": {

3		"banner": true,

4		"sale": false

5	}

6}
```

We can now use Edge Config’s `get` function to read the "flags" key defined in Edge Config:

现在，我们可以使用 Edge Config 的 `get` 函数来读取在 Edge Config 中定义的 `"flags"` 键：

flags.ts

flags.ts

```tsx
import { flag } from “flags/next”;
```

```tsx
import { flag } from “flags/next”;
```

```typescript
import { get } from "@vercel/edge-config";

import { get } from "@vercel/edge-config";

export const showBanner = flag({
export const showBanner = flag({

  key: "banner",
  key: "banner",

  defaultValue: false,
  defaultValue: false,

  async decide() {
  async decide() {

    // educational example, use @flags-sdk/edge-config for real applications
    // 教学示例；在实际应用中请使用 @flags-sdk/edge-config

    const flags = await get("flags");
    const flags = await get("flags");

    return flags?.banner;
    return flags?.banner;

  }
  }
```

12});
```

上述示例仅用于教学目的，旨在展示 Edge Config 与 Flags SDK 如何协同工作；但该写法会导致每个功能开关（feature flag）都触发一次独立的 Edge Config 读取操作。

请改用 [Edge Config Provider](https://flags-sdk.dev/providers/edge-config)，它内置了进一步的性能优化，例如：每个请求仅对底层 Edge Config 执行一次读取，而非为每个功能开关各读取一次：

flags.ts

```typescript
import { flag } from 'flags/next';

import { edgeConfigAdapter } from '@flags-sdk/edge-config';



export const showBanner = flag({

5  // 将从 `flags` 对象中获取键名为 `example-flag` 的值

6  key: 'banner',

7  // Will load the `flags` key from Edge Config

7  // 将从 Edge Config 加载 `flags` 键

8  adapter: edgeConfigAdapter(),

8  adapter: edgeConfigAdapter(),

9});
```

With this new setup, we can now edit Edge Config and the new value will be used by our flag without having to redeploy our application. To change values in Edge Config we can either use [the API endpoint](https://vercel.com/docs/storage/edge-config/vercel-api) or [the editor](https://vercel.com/docs/storage/edge-config/edge-config-dashboard).

借助这一新配置，我们现在可直接编辑 Edge Config，更新后的值将立即被我们的功能标志（feature flag）所采用，而无需重新部署应用。要修改 Edge Config 中的值，我们可以使用 [API 端点](https://vercel.com/docs/storage/edge-config/vercel-api) 或 [编辑器界面](https://vercel.com/docs/storage/edge-config/edge-config-dashboard)。

![](images/flags-as-code-in-next_js-vercel/img_008.jpg)![](images/flags-as-code-in-next_js-vercel/img_009.jpg)

This means we no longer need to wait for a redeployment, so the new value is available in seconds, globally.

这意味着我们不再需要等待重新部署——新值将在数秒内即在全球范围内生效。

You’ll notice that Edge Config is an async function, so we’re no longer getting the value immediately. We introduced a tiny bit of latency. But since Edge Config was built for this exact use case the additional latency is negligible.

您会注意到，Edge Config 是一个异步函数，因此我们不再能立即获取到值，从而引入了极小的延迟。但由于 Edge Config 正是为此类使用场景而专门设计的，因此额外延迟几乎可以忽略不计。

So we’ve now traded a bit of added latency for the ability to change feature flags without having to redeploy our applications.

因此，我们以微乎其微的延迟为代价，换取了无需重新部署即可动态调整功能标志的能力。

_**Note:**_ _This approach is perfect for feature flags where you need to be able to quickly kill a feature, or when you want to time a launch perfectly. Since Edge Config creates a backup for every change you’re also able to see a history of changes and restore previous values quickly._

_**注意：**_ _此方法特别适用于需要快速禁用某项功能、或需精确控制功能上线时机的功能标志场景。由于 Edge Config 会对每次变更自动创建备份，您还可随时查看变更历史，并快速恢复至任一先前版本。_

## Using a feature flag provider

## 使用功能标志服务提供商

In case you’re already using a feature flag provider you can also integrate them. You can call your feature flag provider from within the `decide` function.

如果您的项目中已使用某个功能开关（Feature Flag）服务提供商，您也可以将其集成进来。您可以在 `decide` 函数内部调用该功能开关服务提供商的 API。

```tsx
1// flags.ts

import { flag } from "flags/next";

import { statsigAdapter } from "@flags-sdk/statsig";



export const showBanner = flag({

6  key: "banner",

7  adapter: statsigAdapter.featureGate((gate) => gate.value),

8})‌;﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌﻿‌‌‌﻿‌‌‌﻿‌‌﻿﻿‌﻿‌‌‌﻿‌﻿‌‌﻿‍‍‌‌‍‍‌‍‌‌‌‌﻿‌‌‍​﻿‌‍‍﻿‌‍‍‌‌‍‌﻿‌‌‌‌‍‌‌‌﻿﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

```tsx
1// flags.ts

// flags.ts

import { flag } from "flags/next";

import { statsigAdapter } from "@flags-sdk/statsig";



export const showBanner = flag({

6  key: "banner",

7  adapter: statsigAdapter.featureGate((gate) => gate.value),

8})‌;﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌﻿‌‌‌﻿‌‌‌﻿‌‌﻿﻿‌﻿‌‌‌﻿‌﻿‌‌﻿‍‍‌‌‍‍‌‍‌‌‌‌﻿‌‌‍​﻿‌‍‍﻿‌‍‍‌‌‍‌﻿‌‌‌‌‍‌‌‌﻿﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

The code snippet above uses a fictional feature flag provider’s SDK to load feature flags. It shows how you would integrate a feature flagging provider. They typically implement a singleton pattern where you need to await the client’s init before you can access the data.

上述代码片段使用了一个虚构的功能开关服务提供商的 SDK 来加载功能开关。它展示了如何将功能开关服务提供商集成到您的应用中。这类服务通常采用单例（Singleton）模式实现，您需要先等待客户端完成初始化（`init`），然后才能访问其提供的数据。

### **A note on init time**

### **关于初始化时间的说明**

The SDKs of most feature flag providers are built for long-running servers which fire an initial network request to load the flag configuration once and then update it in the background going forward. This works well in the traditional world of long-running servers as you only pay the price of the slow initial request once. But in today’s serverless world, functions start and stop quite frequently, especially on Edge Middleware the average lifetime of a function instance is in the order of seconds, not minutes.

大多数功能开关（feature flag）提供商的 SDK 都是为长期运行的服务器设计的：它们仅在启动时发起一次网络请求以加载开关配置，之后便在后台持续更新该配置。这种模式在传统长期运行服务器的场景中表现良好，因为缓慢的初始请求只需承担一次开销。但在当今的无服务器（serverless）环境中，函数实例频繁启停——尤其是在 Edge Middleware 场景下，单个函数实例的平均生命周期仅为数秒，而非数分钟。

It’s important that cold instances of your application are able to load flag configurations quickly to keep latency low. That’s why we partnered with [Statsig](https://vercel.com/integrations/statsig), [Hypertune](https://vercel.com/integrations/hypertune), [LaunchDarkly](https://vercel.com/integrations/launchdarkly), [Split](https://vercel.com/integrations/split) and more who created integrations which synchronize their feature flag configuration into Edge Config. Your application can then bootstrap your flag provider’s SDK from Edge Config avoiding the initial network request and the latency that comes with it.

确保应用的冷启动实例能快速加载开关配置，对维持低延迟至关重要。正因如此，我们与 [Statsig](https://vercel.com/integrations/statsig)、[Hypertune](https://vercel.com/integrations/hypertune)、[LaunchDarkly](https://vercel.com/integrations/launchdarkly)、[Split](https://vercel.com/integrations/split) 等多家服务商展开合作，他们开发了集成方案，可将各自的功能开关配置同步至 Edge Config。您的应用便可直接从 Edge Config 引导功能开关提供商的 SDK，从而跳过初始网络请求及其带来的延迟。

### **OpenFeature**

### **OpenFeature**

You might have wondered how the Flags SDK compares to [OpenFeature](https://openfeature.dev/). OpenFeature describes itself as an “open specification that provides a vendor-agnostic, community-driven API for feature flagging that works with your favorite feature flag management tool or in-house solution”.

您或许曾思考过：Flags SDK 与 [OpenFeature](https://openfeature.dev/) 相比有何异同？OpenFeature 将自身定义为一项“开放规范”，它提供了一套厂商无关、由社区驱动的功能开关 API，可与您偏爱的功能开关管理工具或自研解决方案无缝协作。

The Flags SDK and OpenFeature work really well together. You can use the [Flags SDK OpenFeature adapter](https://flags-sdk.dev/providers/openfeature) to get the value of a feature flag in a vendor-agnostic way. This way you can easily swap vendors while still benefiting from the Flag SDK’s nice integration into frameworks and the pre-computation pattern.

Flags SDK 与 OpenFeature 协作极为顺畅。您可通过 [Flags SDK 的 OpenFeature 适配器](https://flags-sdk.dev/providers/openfeature)，以厂商无关的方式获取功能开关的值。这样，您既能灵活更换底层供应商，又能继续享受 Flags SDK 在框架集成和预计算模式（pre-computation pattern）方面的优势。

_**Recap:**_ _We’ve seen we can use the Flags SDK to pick the right tradeoffs per feature flag, depending on how that feature flag is going to be used. It works well with existing feature flag providers and OpenFeature._

_**小结：**_ _我们已看到，借助 Flags SDK，您可以根据每个功能开关的具体使用方式，为其选择最恰当的权衡策略。它既可与现有功能开关服务商良好协同，也天然兼容 OpenFeature。_

## Get started today

## 立即开始使用

The Flags SDK allows you to choose the right tradeoff for each feature flag without having to refactor the code actually using your flags.

Flags SDK 让您无需重构实际使用功能开关的业务代码，即可为每个功能开关独立选择最合适的权衡策略。

These progressions allow your flag to scale up and down as your feature matures. A flag can start out as a simple hardcoded boolean, mature to a rollout or full-blown experiment and then go back to being a simple operational toggle backed by an environment variable after a successful rollout.

这些渐进式演进路径，使您的功能开关能随功能成熟度动态伸缩：一个开关可始于简单的硬编码布尔值，逐步演进为灰度发布（rollout）甚至完整的 A/B 实验；待发布成功后，又可退化为由环境变量支撑的基础运维开关。

We're excited to equip developers with these powerful new tools for working with feature flags, shipping safely, experimenting smarter, and building truly exceptional web experiences.

我们非常激动地为开发者提供这些功能强大的新工具，助力您高效使用功能开关（feature flags）、安全发布、更智能地开展实验，并打造真正卓越的网页体验。

[**Check out the SDK**\\
\\
Start experimenting server-side, with better performance and less jank. \\
\\
View the docs](https://flags-sdk.dev/)

[**查看 SDK**\\
\\
开始在服务端进行实验，获得更优的性能与更流畅的体验。\\
\\
查阅文档](https://flags-sdk.dev/)
{% endraw %}
