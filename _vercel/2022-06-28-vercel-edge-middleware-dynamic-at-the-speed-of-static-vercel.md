---
title: "Vercel Edge Middleware: Dynamic at the speed of static - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-edge-middleware-dynamic-at-the-speed-of-static"
date: "2022-06-28"
scraped_at: "2026-03-02T10:01:40.784867001+00:00"
language: "en-zh"
translated: true
description: "Execute custom logic at the moment of request, pushing personalization to the edge with exceptional performance."
---
&#123;% raw %}

Jun 28, 2022

2022 年 6 月 28 日

面向路由、A/B 测试等场景的高性能计算能力。

自去年十月我们发布 Middleware 以来，其月度环比增长率达 80%，在公开测试阶段，已有超过 300 亿次请求通过 Vercel 的 Edge Middleware 进行路由。Vox Media、Hackernoon、DataStax 和 HashiCorp 等客户正借助 Edge Middleware，在其 Next.js 应用中实现对请求路由的完全控制。

随着 [Next.js 12.2](https://nextjs.org/blog/next-12-2) 的发布，Vercel 面向 Next.js 的 Edge Middleware 现已正式发布（General Availability, GA），面向所有客户开放。此外，Edge Middleware 同样支持 _所有_ 前端框架——目前已进入公开测试阶段，并与一系列其他“边缘优先”（edge-first）工具共同推出。

## **什么是 Vercel Edge Middleware？**

![Edge Middleware 在边缘网络缓存（Edge Network Cache）之前运行，从而实现快速重写（rewrites）与重定向（redirects）](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_001.jpg)![Edge Middleware 在边缘网络缓存（Edge Network Cache）之前运行，从而实现快速重写（rewrites）与重定向（redirects）](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_002.jpg)![Edge Middleware 在边缘网络缓存（Edge Network Cache）之前运行，从而实现快速重写（rewrites）与重定向（redirects）](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_003.jpg)![Edge Middleware 在边缘网络缓存（Edge Network Cache）之前运行，从而实现快速重写（rewrites）与重定向（redirects）](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_004.jpg)Edge Middleware 在边缘网络缓存（Edge Network Cache）之前运行，从而实现快速重写（rewrites）与重定向（redirects）

Edge Middleware 帮助开发者摆脱冗长繁复的配置文件，转而通过代码定义路由规则，例如重写（rewrites）、重定向（redirects）和响应头（headers）。当部署至 Vercel 后，Edge Middleware 会自动被配置为一组特殊的 Edge Functions。

Edge Middleware 在从边缘缓存（Edge Cache）提供请求服务 *之前* 运行，因此能够快速完成请求路由与重写，返回预渲染页面。过去需要回源至核心数据中心或依赖臃肿的客户端代码才能完成的任务，如今均可在边缘节点执行，并完全由开发者编写的自定义代码进行配置。

## 为何选择 Edge Middleware？

在公开测试阶段，已有超过 10 万名开发者在 Vercel 上使用 Edge Middleware，其中包括近半数的企业级客户。事实清晰表明：以静态资源的速度运行的动态 Edge Middleware，正在重塑我们构建 Web 应用的方式。

> “We've been using Edge Middleware to drive experiments and personalization on our marketing surfaces. We keep our ability to customize our content workflows while keeping the performance that Next.js on Vercel gives us. We've been using Edge Middleware to drive experiments and personalization on our marketing surfaces. We keep our ability to customize our content workflows while keeping the performance that Next.js on Vercel gives us. ”  
>   
> “我们一直使用 Edge Middleware 在营销页面上驱动实验与个性化。我们在保留内容工作流高度可定制能力的同时，也持续享有 Vercel 上 Next.js 所提供的卓越性能。我们一直使用 Edge Middleware 在营销页面上驱动实验与个性化。我们在保留内容工作流高度可定制能力的同时，也持续享有 Vercel 上 Next.js 所提供的卓越性能。”  
>   
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_005.jpg)  
>   
> **Jon Eide Johnsen,** Growth Manager at Sanity.io  
>   
> **乔恩·艾德·约翰森（Jon Eide Johnsen）**，Sanity.io 增长经理  

### Experiment **at the edge**  
### 在**边缘**开展实验  

Customers like **SumUp** and **Sanity** use Edge Middleware to personalize content at the edge through custom experimentation—even for otherwise-static content.  
像 **SumUp** 和 **Sanity** 这样的客户，借助 Edge Middleware 在边缘节点通过自定义实验实现内容个性化——即使内容本身是静态的，亦可如此。  

Based on the incoming request, Edge Middleware is able to connect to tools like LaunchDarkly, ConfigCat, Koala, Optimizely, Split, and more to run A/B tests for the current visitor. If the visitor is part of the split test, they’ll be routed to one of the possible variants from the edge server.  
Edge Middleware 可根据传入的请求，连接 LaunchDarkly、ConfigCat、Koala、Optimizely、Split 等工具，为当前访客运行 A/B 测试。若该访客属于分流测试组，系统将直接从边缘服务器将其路由至任一实验变体页面。  

![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_006.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_007.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_008.jpg)![A/B testing and feature flags, directly in your code with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_009.jpg)A/B testing and feature flags, directly in your code with Edge Middleware  
![A/B 测试与功能开关：直接在代码中通过 Edge Middleware 实现](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_006.jpg)![A/B 测试与功能开关：直接在代码中通过 Edge Middleware 实现](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_007.jpg)![A/B 测试与功能开关：直接在代码中通过 Edge Middleware 实现](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_008.jpg)![A/B 测试与功能开关：直接在代码中通过 Edge Middleware 实现](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_009.jpg)A/B 测试与功能开关：直接在代码中通过 Edge Middleware 实现  

SumUp can bucket their users on the server side and rewrite the URL as necessary to show the appropriate page to each user immediately. Rather than needing to load heavy client-side libraries for personalization or deal with layout shift from validating whether the visitor was part of the current experiment or not, personalization at the edge helps you achieve great performance, and a great user experience.  
SumUp 可在服务端对用户进行分桶，并按需重写 URL，从而立即向每位用户展示对应页面。相比依赖体积庞大的客户端个性化库，或因判断访客是否参与当前实验而引发布局偏移（layout shift），边缘个性化能显著提升性能，并带来更优的用户体验。  

Check out [this Middleware A/B test example](https://github.com/vercel/examples/tree/main/edge-functions/ab-testing-simple) to get started.  
欢迎查看 [此 Middleware A/B 测试示例](https://github.com/vercel/examples/tree/main/edge-functions/ab-testing-simple)，快速上手。  

> “With Edge Middleware, we can show the control or experiment version of a page immediately instead of using third-party scripts. This results in better performance and removes the likelihood of flickering/layout shifts.” With Edge Middleware, we can show the control or experiment version of a page immediately instead of using third-party scripts. This results in better performance and removes the likelihood of flickering/layout shifts.” ”  
>   
> “借助 Edge Middleware，我们可立即呈现页面的对照组（control）或实验组（experiment）版本，无需依赖第三方脚本。这不仅提升了性能，也彻底避免了页面闪烁（flickering）或布局偏移（layout shifts）。”  
>   
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_010.jpg)  
>   
> **Jillian Anderson Slate,** Software Engineer at SumUp  
>   
> **吉莉安·安德森·斯莱特（Jillian Anderson Slate）**，SumUp 软件工程师  

### **Localize at the edge**  
### **在边缘实现本地化**  

When it comes to localizing content at the edge for their globally distributed customer base, **HashiCorp** is excited about the possibilities of Edge Middleware. The Edge Middleware API contains a geolocation object, pre-populated with the visitor's country, region, and city based on their IP address. This information can then be used to conditionally show or restrict content based on your company's regulatory requirements.  
面向全球分布的客户群体，在边缘节点实现内容本地化时，**HashiCorp** 对 Edge Middleware 的潜力倍感振奋。Edge Middleware API 提供一个地理定位（geolocation）对象，已根据访客 IP 地址预先填充其所属国家、地区及城市信息。您可基于该信息，依据公司合规要求，动态展示或限制特定内容。

![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_011.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_012.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_013.jpg)![Personalize content based on geolocation headers with Edge Middleware](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_014.jpg)  
根据地理位置请求头，利用 Edge Middleware 实现内容个性化

无需额外集成并付费使用第三方服务来实现请求的地理定位，Vercel 已为所有客户内置了该功能。

请查看此 [Middleware 本地化示例](https://github.com/vercel/examples/tree/main/edge-functions/i18n)，快速上手。

> “Middleware 的 API 设计非常直观，它使开发者能够构建功能特性，而无需过多关注框架特定的细节——因为其完全遵循浏览器处理请求与响应所采用的同一标准。”  
> “Middleware 的 API 设计非常直观，它使开发者能够构建功能特性，而无需过多关注框架特定的细节——因为其完全遵循浏览器处理请求与响应所采用的同一标准。”  
>   
> ![](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_015.jpg)  
>   
> **Dylan Staley**，HashiCorp 软件工程师  

### **在边缘进行身份验证**

借助 Vercel Edge Middleware，身份验证可在边缘节点快速、可靠地完成。当访客向应用发起请求时，Edge Middleware 会即时校验该请求，判断访客是否具备访问对应内容的权限；若无权限，Middleware 将直接将访客重定向至提示“未获授权”的页面——**即使该内容已被 CDN 缓存，亦不例外**。

![在初始页面加载前，于边缘完成身份验证与授权](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_016.jpg)![在初始页面加载前，于边缘完成身份验证与授权](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_017.jpg)![在初始页面加载前，于边缘完成身份验证与授权](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_018.jpg)![在初始页面加载前，于边缘完成身份验证与授权](images/vercel-edge-middleware-dynamic-at-the-speed-of-static-vercel/img_019.jpg)  
在初始页面加载前，于边缘完成身份验证与授权

相比在客户端或源服务器（origin server）上延迟执行授权逻辑，Edge Middleware 可在距离用户最近的 Vercel 边缘网络节点处就近完成请求校验，显著提升响应速度与安全性。

请通过此 [Middleware 身份验证示例](https://github.com/vercel/examples/tree/main/edge-functions/basic-auth-password) 开始实践。

## 兼容所有框架的敏捷性

We're working to bring more capabilities to the edge, to give developers the ability to choose what's best for their application, without having to factor in tradeoffs in latency and performance.

我们正致力于将更多能力带至边缘（edge），使开发者能够为其应用选择最优方案，而无需在延迟与性能之间做出权衡。

### Edge API Routes

### 边缘 API 路由

Often, moving API routes to the edge will drastically reduce latency and improve performance. With Edge Functions on Vercel, we're giving you the power to choose which runtime is the right one to use for your application _directly_ within your code.

通常，将 API 路由迁移至边缘可显著降低延迟并提升性能。借助 Vercel 的边缘函数（Edge Functions），您现在可以直接在代码中选择最适合您应用的运行时环境。

```javascript
import { NextRequest } from 'next/server';



export default (req: NextRequest) => {

4  return Response.json({

5    name: `Hello, from ${req.url} I'm now an Edge Function!`,

6  });

7};
```

```js
export const config = {

10  runtime: 'experimental-edge',

11};
```

```js
export const config = {

10  runtime: 'experimental-edge',

11};
```

Build API Routes at the edge, with the new Edge Runtime

借助全新的 Edge Runtime，在边缘构建 API 路由。

Together with traditional Serverless Functions and static caching, Vercel is working to bring granular control over your end-user experience without leaving your code.

Vercel 正在将传统的无服务器函数（Serverless Functions）与静态缓存相结合，致力于让您无需离开现有代码，即可对终端用户的体验实现精细化控制。

### **Edge for all frameworks**

### **面向所有框架的边缘能力**

We believe in the power of edge-first capabilities, and tools built with the edge in mind. We’re working with framework authors to give them tools to access the Vercel primitives, and build edge functionality into any framework.

我们坚信“以边缘为先”（edge-first）能力的强大潜力，以及专为边缘场景而设计的工具的价值。我们正与各主流框架的作者合作，为其提供访问 Vercel 原语（primitives）的工具，从而让任意框架都能原生支持边缘功能。

With this release, we’re also bringing Edge Middleware and Edge Functions to the Vercel CLI, which allows you to build edge capabilities into your deployment no matter what framework you’re building with. Add a `middleware.js` or `.ts` file to your project, run `vercel dev`, and start building for the edge today.

本次发布还将 Edge Middleware 和 Edge Functions 引入 Vercel CLI，使您无论使用何种框架，均可在部署中集成边缘能力。只需在项目中添加一个 `middleware.js` 或 `middleware.ts` 文件，运行 `vercel dev`，即可即刻开启边缘开发之旅。

```javascript
export default function middleware(request) {

2  // Construct the url

2  // 构造 URL

3  const url = new URL(request.url);



5  // Only run the middleware on the home route

5  // 仅在首页路由上运行中间件

6  if (url.pathname === '/') {

7    // Store the country where will be redirecting

7    // 存储将要重定向到的国家代码

8    let country = request.headers.get('x-vercel-ip-country').toLowerCase();



10    // Update url pathname

10    // 更新 URL 的路径部分
```

11    url.pathname = `/${country}.html`;

11    url.pathname = `/${country}.html`;

13    // Return a new redirect response

13    // 返回一个新的重定向响应

14    return Response.redirect(url);

14    return Response.redirect(url);

15  }

15  }

16}

16}

Edge Middleware can be added to any application, using any framework

Edge 中间件可添加至任何应用，且支持任意框架。

We’re helping framework authors build dedicated support for the edge with tools to let them build native edge functionality for their users. Frameworks like Svelte, Nuxt, and Astro have already begun implementing support for Edge Middleware and Edge Functions.

我们正协助框架作者借助各类工具构建对边缘计算的专属支持，使其能够为用户打造原生的边缘功能。Svelte、Nuxt 和 Astro 等框架已率先开始实现对 Edge 中间件（Edge Middleware）和 Edge 函数（Edge Functions）的支持。

## **How to get started**

## **如何开始使用**

For customers who have started using Edge Middleware while it was in beta, we’ve created an [upgrade guide](https://nextjs.org/docs/messages/middleware-upgrade-guide) to help migrate to the new API for Next.js 12.2. For users new to Edge Middleware, [check out our quickstart guides](https://vercel.com/docs/concepts/functions/edge-middleware/quickstart).

对于已在 Beta 阶段开始使用 Edge 中间件的客户，我们已编写了一份[升级指南](https://nextjs.org/docs/messages/middleware-upgrade-guide)，帮助您迁移到 Next.js 12.2 的新 API；而对于初次接触 Edge 中间件的用户，欢迎查阅我们的[快速入门指南](https://vercel.com/docs/concepts/functions/edge-middleware/quickstart)。

Every Vercel account has 1 million monthly Middleware invocations included for _free_; Pro and Enterprise teams can [pay for additional usage](https://vercel.com/pricing). While still in beta, Edge Functions will be free to use.

每个 Vercel 账户每月免费包含 100 万次 Middleware 调用；Pro 和 Enterprise 团队可[付费购买额外用量](https://vercel.com/pricing)。Edge Functions 目前仍处于 Beta 阶段，使用完全免费。

Whether you’re using Vercel Edge Middleware to authenticate, personalize, or localize at the edge, now you can provide tailor-made experiences at the speed of static. You have the power to serve the exact end-user experience you envisioned, every time.

无论您是使用 Vercel Edge Middleware 在边缘进行身份认证、个性化定制，还是本地化处理，如今您都能以静态网站般的速度，提供量身打造的用户体验。您将有能力在每次请求中，精准交付您所构想的最终用户体验。
&#123;% endraw %}
