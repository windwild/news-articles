---
render_with_liquid: false
title: "Authentication for the frontend cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/authentication-for-the-frontend-cloud"
date: "2023-05-05"
scraped_at: "2026-03-02T09:52:40.861778444+00:00"
language: "en-zh"
translated: true
description: "Learn how Clerk is reimagining authentication to embrace the architecture of framework-defined infrastructure."
---
render_with_liquid: false
render_with_liquid: false

May 5, 2023

2023 年 5 月 5 日

​Clerk 构建开箱即用的身份认证解决方案，实现完整的用户管理。本文中，他们阐述了如何针对“前端云”（frontend cloud）优化自身架构。

We’re in the midst of the next big platform shift. Last generation we moved from server rooms to the cloud, and today we’re moving from the traditional, backend-oriented cloud to a new frontend cloud.

我们正身处下一次重大平台变革的浪潮之中。上一代，我们从本地机房迁移到了云；而今天，我们正从传统、以后端为中心的云，迈向一个全新的“前端云”。

The frontend cloud is characterized by performance: It enables both faster application development and faster end-user interactions. Each element is critical to success in today’s ultra-competitive software market.

“前端云”的核心特征是高性能：它既加速应用开发，也加速终端用户的交互体验。在当今竞争白热化的软件市场中，这两者缺一不可。

At Clerk, we build authentication for the frontend cloud. We saw the need arise as frameworks and hosts tailored to the frontend cloud grew in popularity, especially Next.js and Vercel. Legacy authentication tools were not built frontend-first, and their technical architecture usually undermines the goal of speeding up end-user interactions, since they’re slow at the edge.

Clerk 致力于为“前端云”构建身份认证能力。随着专为前端云设计的框架与托管平台（尤其是 Next.js 和 Vercel）日益普及，这一需求应运而生。而传统认证工具并非“前端优先”设计，其技术架构往往反而拖慢终端用户交互——因其在边缘节点性能低下。

We needed to reimagine authentication to embrace the architecture of [framework-defined infrastructure](https://vercel.com/blog/framework-defined-infrastructure). Let's explore how edge-native auth in the frontend cloud enables:

我们必须重新构想身份认证方案，使其真正契合[框架定义的基础设施](https://vercel.com/blog/framework-defined-infrastructure)（framework-defined infrastructure）架构。接下来，我们将探讨“前端云”中原生支持边缘计算（edge-native）的身份认证如何赋能以下三大能力：

1. Faster app development  
1. 更快的应用开发  

2. Better user experiences  
2. 更优的用户体验  

3. Powerful composability  
3. 强大的可组合性  

## Enabling faster application development

## 加速应用开发

Clerk uses the frontend cloud to speed up application development with three key strategies:

Clerk 利用前端云，通过以下三种关键策略加速应用开发：

- **Framework-specific SDKs**. React is too versatile a library for a one-size-fits-all authentication solution. Our separate SDKs for Next.js, Expo, Remix, and more are essential to providing fast implementation and a natural developer experience. Clerk’s [support for the Next.js App Router](https://clerk.com/blog/nextjs-13-4), including RSC, is now stable.

- **框架专属 SDK**。React 作为一款高度灵活的库，无法通过“一套方案适配所有场景”的方式实现通用身份认证。因此，我们为 Next.js、Expo、Remix 等不同框架分别提供了专用 SDK，这对实现快速集成与自然流畅的开发者体验至关重要。Clerk 对 Next.js App Router（包括服务端组件 RSC）的支持现已进入稳定版本。[了解更多](https://clerk.com/blog/nextjs-13-4)

app/page.tsx

```tsx
import { auth, currentUser } from '@clerk/nextjs';⁡𝅶‍‍𝅺⁡‍𝅴⁡𝅴𝅹‍‍⁢𝅵‍‍⁢𝅺𝅹⁡⁣⁠𝅹⁡⁣⁡⁠𝅷‍𝅹⁢𝅺𝅸‍‍‍𝅷‍‍𝅳⁡‍⁠‍‍⁢𝅵‍‍‍𝅺



export default async function Page() {

4  // Retrieve the active userId

5  const { userId } = auth();



7  // Retrieve the complete user object

app/page.tsx

```tsx
import { auth, currentUser } from '@clerk/nextjs';⁡𝅶‍‍𝅺⁡‍𝅴⁡𝅴𝅹‍‍⁢𝅵‍‍⁢𝅺𝅹⁡⁣⁠𝅹⁡⁣⁡⁠𝅷‍𝅹⁢𝅺𝅸‍‍‍𝅷‍‍𝅳⁡‍⁠‍‍⁢𝅵‍‍‍𝅺



export default async function Page() {

4  // Retrieve the active userId

5  const { userId } = auth();



7  // Retrieve the complete user object

```tsx
import { auth, currentUser } from '@clerk/nextjs';⁡𝅶‍‍𝅺⁡‍𝅴⁡𝅴𝅹‍‍⁢𝅵‍‍⁢𝅺𝅹⁡⁣⁠𝅹⁡⁣⁡⁠𝅷‍𝅹⁢𝅺𝅸‍‍‍𝅷‍‍𝅳⁡‍⁠‍‍⁢𝅵‍‍‍𝅺



export default async function Page() {

4  // 检索当前活跃用户的 userId

5  const { userId } = auth();



7  // 检索完整的用户对象

8  const { firstName, lastName } = await currentUser();



10 return '...';

11}
```

Clerk 现在支持 Next.js App Router。

- **A**`<Component/>` **胜过千种 API。** 只需直接嵌入我们的 `<SignIn/>` 和 `<UserProfile/>` 组件，即可获得功能完备、美观优雅的身份认证用户界面。开发者无需自行实现 Clerk 的 RESTful API——我们提供的可定制组件已为您代劳！

![](images/authentication-for-the-frontend-cloud-vercel/img_001.jpg)![](images/authentication-for-the-frontend-cloud-vercel/img_002.jpg)

- **Clerk 托管“users”（用户）数据表。** 我们不再要求开发者自行搭建和维护用户数据表，而是由 Clerk 为您托管。这极大降低了上手门槛；开发者只需在数据库中将 `clerk_user_id` 作为外键使用即可。额外好处是：由于我们的架构使应用服务器完全不接触客户数据，团队所面临的合规监管压力也显著降低。（其原理与 Stripe 对信用卡号的保护方式一致：应用服务器无法访问敏感信息。）

## 提供更卓越的用户体验

前端云（Frontend Cloud）的标志性特性之一是“边缘计算（Edge Compute）”——它将您的应用全局分发，使服务端函数得以在地理上尽可能靠近终端用户的位置运行。这有助于开发者克服物理学中最顽固的限制之一：光速所导致的网络延迟。

Perhaps surprisingly, many applications cannot benefit from edge compute without first replacing their authentication solution. This is because legacy authentication solutions usually depend on stateful session management that is centralized to a single region, which directly undermines the benefit of edge compute.

令人意外的是，许多应用程序若不先更换其身份验证方案，便无法从边缘计算中获益。这是因为传统的身份验证方案通常依赖于集中式、单区域的有状态会话管理，而这直接削弱了边缘计算的优势。

Clerk uses stateless session management based on JSON web tokens (JWTs) for secure authentication in under one millisecond at the edge. Fast authentication unlocks many more workloads to operate there, like personalization or feature flags, which require information about the signed-in user.

Clerk 在边缘端采用基于 JSON Web Token（JWT）的无状态会话管理，实现毫秒级（低于 1 毫秒）的安全身份验证。快速的身份验证使更多工作负载得以在边缘运行，例如个性化推荐或功能开关（feature flags），这些功能均需获取已登录用户的相关信息。

## Powering composability with JWT SSO

## 借助 JWT 单点登录（SSO）赋能可组合性

Another hallmark feature of the frontend cloud is composability. It’s no secret that developers like to glue many services together within their application, but how does composability work for frontend-first services?

前端云的另一大标志性特性是“可组合性”（composability）。开发者热衷于在应用中集成多种服务，这早已不是什么秘密；但面向前端优先的服务，这种可组合性究竟如何实现？

Services in the frontend cloud often need to handle requests directly from the end-user’s browser, so the traditional concept of a “secret key” is no longer secure. Instead, services are adopting a pattern called “JWT SSO” (JWT single sign-on).

前端云中的服务往往需要直接处理来自终端用户浏览器的请求，因此传统意义上的“密钥”（secret key）已不再安全。取而代之的是，各类服务正广泛采用一种名为“JWT SSO”（JWT 单点登录）的模式。

JWT SSO is when services ask developers to identify the end-user by generating a cryptographically-signed JWT. The pattern is common among database tools with user-based authorization features like row-level security, as well as embeddables like chat widgets that need to know which user is signed in.

所谓 JWT SSO，是指服务要求开发者通过生成一个经密码学签名的 JWT 来标识终端用户。这一模式在支持基于用户的授权机制（如行级安全，Row-Level Security）的数据库工具中十分常见，也广泛应用于需识别当前登录用户的嵌入式组件（embeddables），例如聊天小部件（chat widgets）。

Clerk plays a vital role in facilitating this process by allowing developers to define “JWT templates.” This makes it easy to retrieve JWTs from the frontend and pass them along to the service. By utilizing the frontend cloud, Clerk can seamlessly integrate with various frontend-first services, streamlining the process of connecting and securing these services. We even have many pre-defined JWT templates to help further simplify the process.

Clerk 在此过程中发挥着关键作用：它允许开发者定义“JWT 模板”（JWT templates），从而轻松从前端获取 JWT 并将其传递给目标服务。依托前端云能力，Clerk 可与各类面向前端优先的服务实现无缝集成，极大简化了服务连接与安全加固的流程。我们甚至提供了大量预定义的 JWT 模板，以进一步降低使用门槛。

Needless to say, the entire team at Clerk is excited to be part of the frontend cloud, and we can’t wait to partner with more in the ecosystem. Our approach enables us to better serve our users and empower them to create secure, efficient, and user-friendly applications.

毋庸置疑，Clerk 全体团队都为加入前端云而倍感振奋，也热切期待与生态中更多伙伴展开合作。我们的方法论，旨在更优质地服务用户，并赋能他们构建安全、高效且用户体验卓越的应用程序。

[**Ready to get started?**\\
\\
We're excited to welcome you in to Vercel's frontend cloud. Feel free to bring any questions you may have about your team's unique applications.\\
\\
Talk with Us](https://vercel.com/contact/sales)

[**准备开始了吗？**\\
\\
我们非常荣幸邀请您加入 Vercel 前端云。欢迎随时就您团队的独特应用场景提出任何问题。\\
\\
立即联系我们](https://vercel.com/contact/sales)