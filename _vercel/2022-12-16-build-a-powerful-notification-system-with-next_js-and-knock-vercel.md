---
title: "Build a powerful notification system with Next.js and Knock - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-a-powerful-notification-system-for-vercel-with-knock-app"
date: "2022-12-16"
scraped_at: "2026-03-02T09:57:25.230499265+00:00"
language: "en-zh"
translated: true
description: "Notifications on Vercel"
---
&#123;% raw %}

Dec 16, 2022

2022 年 12 月 16 日

How to create realtime alerting and communication system using a best-of-breed solution

如何使用业界领先的技术方案构建实时告警与通信系统

One of the main benefits of building with Next.js is the ease of leveraging APIs and components to _quickly_ integrate with best-of-breed, backend technology.

使用 Next.js 构建应用的一大优势在于，能够轻松借助 API 和组件，_快速_ 集成业界领先的后端技术。

Today released our [new notification system](https://vercel.com/docs/concepts/dashboard-features/notifications) as a public beta, made possible with the help of our integration partner [Knock](https://knock.app/), their powerful API, and robust component library.

今天我们正式发布全新[通知系统](https://vercel.com/docs/concepts/dashboard-features/notifications)的公开测试版。该系统由我们的集成合作伙伴 [Knock](https://knock.app/) 协力打造，依托其强大 API 与稳健的组件库实现。

This post will cover how we chose and implemented Knock for our notification center, and how you can use Knock to build notifications into your own application.

本文将介绍我们为何选择 Knock 作为通知中心的技术方案、如何完成集成，以及你如何在自己的应用中使用 Knock 构建通知功能。

![](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_001.jpg)![](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_002.jpg)

## The case for Knock

## 为何选择 Knock

The first step in building our new notification system was to evaluate our technology options and choose a path forward. As we considered the infrastructure we wanted to build our system on top of, we knew we needed a platform that could match our needs for **iteration speed, reliability, and observability**. We needed a tool that let us:

构建全新通知系统的首要步骤，是评估各类技术选项并确定前进路径。在思考系统所依赖的基础架构时，我们明确需要一个平台，能充分满足我们对 **迭代速度、可靠性与可观测性** 的严苛要求。我们需要的工具必须支持：

- Leverage our design and component system  
- 充分复用我们的设计规范与组件体系  

- Create custom, flexible notifications  
- 创建高度可定制、灵活可变的通知

- Scale with our user base without added complexity or configuration  
- 无需增加复杂性或额外配置，即可随用户规模扩展

We needed to implement a solution quickly, but given this was a highly requested feature, we also knew we needed a system that was flexible enough to adapt to our needs today and in the future.  
我们需要快速落地一个解决方案；但鉴于这是用户呼声极高的功能，我们也深知：该系统必须具备足够的灵活性，以满足当前及未来的需求。

We decided on [Knock](https://vercel.com/integrations/knock)—a flexible, reliable notifications API.  
我们最终选择了 [Knock](https://vercel.com/integrations/knock)——一款灵活、可靠的推送通知 API。

Knock gave us a set of primitives to use in building our notification system, from notification preferences to real-time, per-user, in-app feeds and batching. Knock’s dashboard also gave us a single place to observe the system and see the full range of notifications we were sending to customers.  
Knock 提供了一套基础构建模块（primitives），助力我们搭建完整的通知系统——涵盖通知偏好设置、面向每位用户的实时站内消息流（in-app feed），以及批量通知能力。此外，Knock 的控制台（dashboard）为我们提供了一个统一视图，便于监控整个系统，并全面掌握发送给客户的所有通知类型与状态。

```javascript
const { Knock } = require("@knocklabs/node");

const knock = new Knock(process.env.KNOCK_API_KEY);



await knock.workflows.trigger("new-comment", {

5  recipients: ["1", "2"],
```

7  // optional

7  // 可选

8  data: { "project_name": "My Project" },

8  data: { "project_name": "我的项目" },

9  actor: "3",

9  actor: "3",

10  cancellationKey: "cancel_123",

10  cancellationKey: "cancel_123",

11  tenant: "jurassic_world_employees"

11  tenant: "jurassic_world_employees"

12});

12});

Workflows are triggered via a call to the trigger endpoint, which tells Knock to run a specified payload of recipients and data through the workflow specified by the call.

工作流通过调用触发端点（trigger endpoint）来启动，该调用会指示 Knock 将指定的收件人列表和数据载荷（payload）送入调用中所指定的工作流中执行。

### Using Knock at Vercel

### 在 Vercel 中使用 Knock

Of the many notification systems we evaluated, Knock was the easiest to get started with. With Knock we had an in-app feed demo working in [**less than an hour**](https://twitter.com/rauchg/status/1532024136402206721) **.**(Knock now has its own [demo](https://knock-in-app-notifications-react.vercel.app/) online, powered by Vercel.)

在我们评估的众多通知系统中，Knock 是上手最容易的一个。借助 Knock，我们仅用 [**不到一小时**](https://twitter.com/rauchg/status/1532024136402206721) 就成功运行了一个应用内消息流（in-app feed）演示。（Knock 现已上线其专属 [演示应用](https://knock-in-app-notifications-react.vercel.app/)，由 Vercel 提供支持。）

The out-of-the-box features that Knock provides, like their [React library](https://docs.knock.app/in-app-ui/react/overview), allowed us to create our own React components and easily interact with the notification feed and user preferences. Because of this, we were able to create multi-channel notifications effortlessly, where we can trigger a “workflow” with variables and allow users to customize on which channels they receive notifications.

Knock 提供的开箱即用功能（例如其 [React 库](https://docs.knock.app/in-app-ui/react/overview)），使我们能够自主开发 React 组件，并轻松与通知消息流及用户偏好设置进行交互。正因如此，我们得以毫不费力地构建多渠道通知系统：只需传入变量即可触发一个“工作流”，并允许用户自定义接收通知的渠道。

```javascript
import { KnockFeedProvider } from "@knocklabs/react-notification-feed";

```javascript
导入 { KnockFeedProvider } 来自 "@knocklabs/react-notification-feed";



3// We'll write this next

3// 接下来我们将编写这部分代码

import NotificationToaster from "./NotificationToaster";

```javascript
导入 NotificationToaster 来自 "./NotificationToaster";



const NotificationToastProducer = () => {

const NotificationToastProducer = () => {

7  // An example of fetching the current authenticated user

7  // 获取当前已认证用户的一个示例

8  const { user } = useCurrentUser();



8  const { user } = useCurrentUser();



10  return (

10  return (
```

11    <KnockFeedProvider

11    `<KnockFeedProvider`

12      apiKey={process.env.KNOCK_PUBLIC_API_KEY}

12      apiKey={process.env.KNOCK_PUBLIC_API_KEY}

13      feedId={process.env.KNOCK_FEED_CHANNEL_ID}

13      feedId={process.env.KNOCK_FEED_CHANNEL_ID}

14      userId={user.id}

14      userId={user.id}

15    >

15    >

16      <NotificationToaster />

16      `<NotificationToaster />`

17    </KnockFeedProvider>

17    `</KnockFeedProvider>`

18  );

18  );

19};

19};

```

```

Knock's React Component library makes setting up new components simple. We're able to maintain control over the code, while still leveraging a powerful notification tool in the backend.

Knock 的 React 组件库让新组件的搭建变得简单。我们既能保持对代码的完全控制，又能在后端充分利用功能强大的通知工具。

Using the Knock dashboard and its workflow editor with live previews, we built layouts and workflows for each alert, giving users a real-time notification feed powered by Websockets and packaged with React hooks. Once a new notification is live in Knock, we can use the dashboard’s analytics to debug any potential issues and evaluate how our new notifications are performing.

使用 Knock 控制台及其支持实时预览的工作流编辑器，我们为每种提醒构建了布局和工作流，从而为用户提供由 WebSocket 驱动、并封装在 React Hooks 中的实时通知信息流。一旦新通知在 Knock 中上线，我们即可利用控制台的分析功能来排查潜在问题，并评估新通知的实际效果。

![Knock allows you to build cross-channel notifications with easy-to-use workflows.](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_003.jpg)  
![Knock 让您能够借助简洁易用的工作流，构建跨渠道通知。](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_003.jpg)  
Knock allows you to build cross-channel notifications with easy-to-use workflows.  
Knock 让您能够借助简洁易用的工作流，构建跨渠道通知。

And with [Knock’s API](https://docs.knock.app/reference) for managing user notification preferences, we have the ability to update email and web notification behavior without redeploying API infrastructure, making our iteration speed even faster.

此外，借助 [Knock 的 API](https://docs.knock.app/reference) 管理用户通知偏好设置，我们无需重新部署 API 基础设施，即可动态调整邮件与网页通知的行为，进一步加快迭代速度。

![Knock provides a single API for all of your notifications code and observability tools so you can understand how your notifications are sent.](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_004.jpg)  
![Knock 为所有通知代码及可观测性工具提供统一 API，助您全面掌握通知的发送机制。](images/build-a-powerful-notification-system-with-next_js-and-knock-vercel/img_004.jpg)  
Knock provides a single API for all of your notifications code and observability tools so you can understand how your notifications are sent.  
Knock 为所有通知代码及可观测性工具提供统一 API，助您全面掌握通知的发送机制。

Additionally, Knock added value to Vercel internally. Customer success engineers can troubleshoot potential issues while product managers can update notification templates without needing to take time from engineering.

此外，Knock 还为 Vercel 内部团队带来了额外价值：客户成功工程师可直接排查潜在问题，而产品经理则能自主更新通知模板，无需占用工程团队资源。

## **Updated notifications for your Vercel workflow**

## **面向您 Vercel 工作流的全新通知功能**

With customizable workflows, we're able to easily build notifications that work for our users and their workflows. With this release we’re introducing a number of new notification types to help you stay in the loop on your Vercel project. Here are a few highlights.

借助高度可定制的工作流，我们能轻松构建契合用户及其工作流需求的通知系统。本次发布新增多种通知类型，助您随时掌握 Vercel 项目的最新动态。以下为部分亮点：

- **Notifications on deployment failure.** You will now receive notifications when a deployment in your Vercel project fails. By default you’ll receive these notifications across email and your in-app feed, but you can configure where you want to receive deployment failures within your account settings.

- **部署失败通知**：当您的 Vercel 项目发生部署失败时，您将立即收到通知。默认情况下，此类通知将通过电子邮件及应用内信息流同步推送；您也可在账户设置中自定义接收渠道。

- **Batched domain misconfiguration notifications.** We’ve heard your feedback on domain misconfiguration notifications—they can get noisy. So we’re now using Knock’s [batch function](https://docs.knock.app/designing-workflows/batch-function) to reduce the volume of total notifications you’ll receive regarding domain misconfigurations. This ensures teams receive notifications in a more consumable manner without missing important signals from Vercel.

- **批量化的域名配置错误通知**：我们已收到大家关于域名配置错误通知过于频繁的反馈。因此，我们现采用 Knock 的 [批处理功能（batch function）](https://docs.knock.app/designing-workflows/batch-function)，大幅降低因域名配置错误而触发的通知总量。此举既保障团队以更易消化的方式接收通知，又确保不会遗漏来自 Vercel 的关键信号。

Going forward with our system built on Knock’s flexible infrastructure, we plan to continue iterating in this space. You'll soon see new batched notifications and more notification types, like comments on Preview Deployments, supported across all channels.

未来，依托 Knock 灵活的基础设施所构建的系统，我们将持续在此领域迭代优化。您将很快看到更多新型批量通知，以及支持全渠道推送的其他通知类型——例如针对预览部署（Preview Deployments）的评论通知。

Configure your team's notification settings in your Vercel dashboard. [Check out the docs](https://vercel.com/docs/concepts/dashboard-features/notifications) to learn more.

在 Vercel 控制台中配置您团队的通知设置。[查看文档](https://vercel.com/docs/concepts/dashboard-features/notifications) 以了解更多信息。

## **Get Started**

## **快速开始**

Building with Knock's API made it easy for us to get a powerful in-app notification system that met our design, scale, and performance needs, without having to build from the ground up.

借助 Knock 的 API 进行开发，让我们无需从零构建，便轻松获得了一套功能强大、满足设计规范、可扩展性与性能要求的站内通知系统。

Get started with your own Knock notification system by adding the Vercel + Knock integration. When you connect a Vercel project to an account in Knock, Knock will automatically set the `KNOCK_API_KEY` and `KNOCK_PUBLIC_API_KEY` environment variables on your Vercel project.

通过添加 Vercel + Knock 集成，快速启用您专属的 Knock 通知系统。当您将 Vercel 项目连接至 Knock 账户后，Knock 将自动为您的 Vercel 项目配置环境变量 `KNOCK_API_KEY` 和 `KNOCK_PUBLIC_API_KEY`。

[**Knock + Vercel Integration** Vercel's Knock integration gives you a scalable notification system in minutes.](https://vercel.com/integrations/knock) [**Knock Documentation** Jump into Knock's documentation to get started quickly with your first notification.](https://docs.knock.app/getting-started/quick-start)

[**Knock + Vercel 集成** Vercel 的 Knock 集成让您几分钟内即可拥有一个可扩展的通知系统。](https://vercel.com/integrations/knock) [**Knock 文档** 立即查阅 Knock 文档，快速发送您的第一条通知。](https://docs.knock.app/getting-started/quick-start)

Vercel's [integration marketplace](https://vercel.com/integrations) is a great way to get started quickly with headless databases, commerce tools, CMSs and more. Or, build APIs into your application without any plugins or added configuration, simply by using [Next.js API Routes](https://nextjs.org/docs/api-routes/introduction). When deployed on Vercel, these are automatically deployed as Serverless Functions. Just push your code to get a powerful, scalable, and secure composable application.

Vercel 的 [集成市场](https://vercel.com/integrations) 是快速接入无头数据库、电商工具、内容管理系统（CMS）等服务的理想起点。或者，您也可以直接使用 [Next.js API 路由](https://nextjs.org/docs/api-routes/introduction)，无需任何插件或额外配置，即可在应用中构建 API；部署至 Vercel 后，这些路由将自动作为 Serverless 函数运行。只需推送代码，即可获得一个功能强大、高度可扩展且安全可靠的可组合式应用。
&#123;% endraw %}
