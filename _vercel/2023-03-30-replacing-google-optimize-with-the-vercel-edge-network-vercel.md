---
title: "Replacing Google Optimize with the Vercel Edge Network - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-edge-google-optimize"
date: "2023-03-30"
scraped_at: "2026-03-02T09:53:45.236129413+00:00"
language: "en-zh"
translated: true
description: "Power your A/B testing and personalization strategy with better data and higher performance."
---
{% raw %}

Mar 30, 2023

2023 年 3 月 30 日

Power your A/B testing and personalization strategy with data and performance.

借助数据与性能，赋能您的 A/B 测试与个性化策略。

Since 2012, Google Optimize has been helping web builders experiment with their UIs to find the most effective patterns for their applications. However, Google has [announced](https://support.google.com/optimize/answer/12979939?hl=en) that Optimize will be sunset on September 30, 2023.

自 2012 年起，Google Optimize 一直助力网页开发者通过 UI 实验，为其应用寻找最有效的交互模式。然而，Google 已[宣布](https://support.google.com/optimize/answer/12979939?hl=en)，Optimize 将于 2023 年 9 月 30 日正式停止服务。

Vercel is ready to help you build a platform to **continue your research with higher performance, more control, and better data** by leveraging the edge.

Vercel 已准备好助您构建一个全新平台——依托边缘计算能力，**以更高性能、更强控制力与更优质的数据，延续您的实验研究**。

With Vercel, you can recreate your Optimize experiments with:

借助 Vercel，您可使用以下方式复现原有 Optimize 实验：

- Sub-millisecond configuration read times  
- 毫秒级（亚毫秒）配置读取延迟  

- No code using your Vercel dashboard  
- 无需编写代码，直接通过 Vercel 控制台完成配置  

- Your existing data ingestion solution  
- 复用您现有的数据采集方案  

[**Modernize your experimentation stack**\\
\\
Start your transition today.\\
\\
Let's Talk](https://vercel.com/contact/sales)

[**现代化您的实验技术栈**\\
\\
即刻开启迁移之旅。\\
\\
联系我们](https://vercel.com/contact/sales)

## Google Optimize performance opportunities

## Google Optimize 的性能优化机遇

In the past, it's been difficult to run experiments in ways that don't harm page performance.

过去，要在不损害页面性能的前提下开展实验一直十分困难。

- **Google Optimize's scripts** must be loaded on every page where you intend to perform an experiment, adding weight to your page size and increasing load times.

- **Google Optimize 的脚本** 必须在所有计划执行实验的页面上加载，这会增加页面体积并延长加载时间。

- [**Cumulative Layout Shift (CLS)**](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) hurts your application's SEO and UX—but is often introduced accidentally when running UI experiments on the client side.

- [**累积布局偏移（CLS）**](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls) 会损害您应用的搜索引擎优化（SEO）效果和用户体验（UX）——但在客户端运行 UI 实验时，却常常意外引入该问题。

- **Server-side latency** increases when your server has to make calls to Google Optimize to figure out which experiments are currently being ran.

- **服务端延迟** 会在您的服务器需要调用 Google Optimize 以确定当前正在运行哪些实验时增加。

Instead, you can introduce [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) and [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware) to your experimentation framework to build a high-performance testing engine.

取而代之的是，您可以在实验框架中引入 [Vercel Edge Config](https://vercel.com/docs/concepts/edge-network/edge-config) 和 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware)，从而构建一个高性能的测试引擎。

## What is the edge?

## 什么是边缘计算（Edge）？

The [Vercel Edge Network](https://vercel.com/docs/concepts/edge-network/overview) sits between the internet and your Vercel deployments acting as a Content Delivery network (CDN) with the ability to execute functions as close to your user or data as possible.

[Vercel 边缘网络（Edge Network）](https://vercel.com/docs/concepts/edge-network/overview) 位于互联网与您的 Vercel 部署之间，既充当内容分发网络（CDN），又具备将函数执行尽可能靠近用户或数据的能力。

![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_001.jpg)![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_002.jpg)

![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_001.jpg)![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_002.jpg)

This means that the building blocks of your application will always be served from the geographically closest data center in the Edge Network, ensuring that your users experience the best performance possible.

这意味着，您应用的各个组成部分始终由边缘网络中地理位置最近的数据中心提供服务，从而确保用户获得尽可能优异的性能体验。

With Vercel, you have several features that you can use together to **replicate and enhance** Google Optimize's experimenting functionality: Edge Config and Edge Middleware.

借助 Vercel，您可组合使用多项功能——例如 Edge Config 和 Edge Middleware——来**复现并增强** Google Optimize 的实验功能。

## Sub-millisecond experiments with Edge Config

## 亚毫秒级实验：使用 Edge Config

Vercel Edge Config is a small data store for distributing your data to the Edge Network where it can be replicated to all of your globally available regions. Your experiments data becomes available **instantly** and can be fetched in less than 10ms on average, letting you iterate on your experiments faster.

Vercel Edge Config 是一个轻量级数据存储，用于将您的数据分发至边缘网络（Edge Network），并在您所有全球可用的区域中完成数据复制。您的实验数据将**即时生效**，平均可在 10 毫秒内完成获取，从而显著加快实验迭代速度。

Once you've [created your Edge Config](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated), you can fetch its data in [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions), [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware), and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions). Let's use [the Edge Config SDK](https://vercel.com/docs/concepts/edge-network/edge-config/edge-config-sdk) in an Edge Function to get the best possible performance:

在您[创建好 Edge Config](https://vercel.com/docs/concepts/analytics/web-vitals#how-the-percentages-are-calculated)后，即可在[无服务器函数（Serverless Functions）](https://vercel.com/docs/concepts/functions/serverless-functions)、[边缘中间件（Edge Middleware）](https://vercel.com/docs/concepts/functions/edge-middleware)以及[边缘函数（Edge Functions）](https://vercel.com/docs/concepts/functions/edge-functions)中获取其数据。接下来，让我们在边缘函数中使用[Edge Config SDK](https://vercel.com/docs/concepts/edge-network/edge-config/edge-config-sdk)，以实现最佳性能：

middleware.ts

```tsx
import { NextResponse } from 'next/server';

import { get } from '@vercel/edge-config';



export const config = { matcher: '/welcome' };



export async function middleware() {

7  const greeting = await get('greeting');

7  const greeting = await get('greeting');

8  return NextResponse.json(greeting);

8  return NextResponse.json(greeting);

9}

9}


```

Edge Config SDK being used in an Edge Function.

```

在 Edge Function 中使用 Edge Config SDK。

You'll receive the JSON object that you created for your Edge Config to define experiments in your application:

你将收到为你的 Edge Config 创建的 JSON 对象，用于在应用中定义实验：


```json
1{

2  // A boolean feature flag

3  "winterSale": true,

```


```json
1{

2  // 一个布尔型功能开关

3  "winterSale": true,

```

4  // An A/B test with even weight

4  // 权重均等的 A/B 测试

5  "saleColor": {

5  "saleColor": {

6    "red": .5,

6    "red": 0.5,

7    "green": .5

7    "green": 0.5

8  },

8  },

9  // A multi-variate, weighted experiment

9  // 多变量加权实验

10  "buttonColor": {

10  "buttonColor": {

11    "red": .2,

11    "red": 0.2,

12    "green": .3,

12    "green": 0.3,

13    "blue": .5

13    "blue": 0.5

14  }

15}
```

一个包含若干实验的 Edge Config 负载。

随后，你可以在实验逻辑中使用该负载，构建一个功能强大的测试平台，满足你的各类测试需求。

## 消除累积布局偏移（CLS）

拥抱边缘计算（Edge）还能让我们显著降低[累积布局偏移（Cumulative Layout Shift, CLS）](https://vercel.com/docs/concepts/analytics/web-vitals#cumulative-layout-shift-cls)，其原理是：以动态内容的速度交付静态渲染的内容。借助 Next.js 和 Vercel 提供的原语（primitives），

通过 [Edge Middleware](https://vercel.com/docs/concepts/functions/edge-middleware)，你可以读取 Edge Config，在页面首次加载的瞬间即刻提供正确的页面变体（variant），而无需等待页面初始加载完成后再在客户端计算变体。Speedway Motors 采用这一策略后，其 CLS 指标降低了 50%，该结果已由 [Vercel Analytics](https://vercel.com/docs/concepts/analytics/web-vitals) 验证。

![Speedway Motors 的累积布局偏移（CLS）降低了 50%。](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_003.jpg)Speedway Motors 的累积布局偏移（CLS）降低了 50%。

## 跟踪实验结果

为分析实验效果，你可以沿用当前偏好的数据分析方案，并将实验上下文作为数据属性（properties）传入。

CheckoutButton.tsx

CheckoutButton.tsx

```tsx
import { saveData } from'@your-data-provider/sdk';



export const CheckoutButton = () => {



5  useEffect(() => {

6    // Track how many times button was rendered

7    // and which experiments were active

8    saveData("Checkout button impression", {

9      isWinterSale: true,

```tsx
import { saveData } from'@your-data-provider/sdk';



export const CheckoutButton = () => {



5  useEffect(() => {

6    // 跟踪按钮被渲染的次数

7    // 以及当前启用的实验

8    saveData("Checkout button impression", {

9      isWinterSale: true,

10      saleColor: "red",

10      saleColor: "红色",

11      buttonColor: "blue"

11      buttonColor: "蓝色"

12    })

12    })

13  }, [])

13  }, [])







17  const handleClick = () => {

17  const handleClick = () => {

18    // Track when a user clicks the button

18    // 跟踪用户点击按钮的时间

19    // and which experiments were active

19    // 以及当时处于激活状态的实验有哪些

20    saveData("Checkout button click", {

20    saveData("结账按钮点击", {

21      isWinterSale: true,

21      isWinterSale: true,

22      saleColor: "red",

22      saleColor: "red",

23      buttonColor: "blue"

23      buttonColor: "blue"

24    })

24    })



26    // Your checkout logic

26    // 您的结账逻辑

27    console.log("Check out!")

27    console.log("结账！")

28  }

28  }

30  return (

30  返回（

31    <button onClick={() => handleClick()}>

31    <button onClick={() => handleClick()}>

32      Checkout

32      结账

33    </button>

33    </button>

34  )

34  ）

35}
```

35}
```

In the future, we're looking forward to adding more features to track your experiments.

未来，我们期待添加更多功能，以帮助您追踪实验进展。

## Experiment faster by default

## 默认更快地开展实验

We want to help you replace your experiments and **make them even better.**

我们希望帮助您替换现有实验方案，并**让实验效果更上一层楼。**

By taking your experiments to the edge, the tests that you were running with Google Optimize can be incrementally migrated to improve your page performance while still collecting the valuable experimentation data that drives your business.

通过将您的实验推向前沿，原本使用 Google Optimize 运行的测试可逐步迁移至新平台，在持续收集驱动业务决策的宝贵实验数据的同时，进一步提升页面性能。

[**Talk to a migration expert**  
**联系迁移专家**

Start building a cleaner enterprise-grade stack.  
开始构建更简洁的企业级技术栈。

Contact Sales  
联系销售](https://vercel.com/contact/sales)

Vercel.com landing page  
Vercel.com 首页

### Personalization at the edge with Builder.io  
### 借助 Builder.io 在边缘实现个性化

Blog post  
博客文章

Jan 13, 2023  
2023 年 1 月 13 日

### Sanity balances experimentation and performance with Vercel Edge Middleware  
### Sanity 借助 Vercel 边缘中间件，在实验性功能与性能之间取得平衡

![](images/replacing-google-optimize-with-the-vercel-edge-network-vercel/img_004.jpg)

Grace Madlinger  
格蕾丝·马德林格
{% endraw %}
