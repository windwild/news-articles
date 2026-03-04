---
title: "Spend Management: Realtime Usage Alerts, SMS Notifications, and Project Pausing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-spend-management-realtime-usage-alerts-sms-notifications"
date: "2023-10-05"
scraped_at: "2026-03-02T09:50:19.743976997+00:00"
language: "en-zh"
translated: true
description: "New controls to help you safely scale your projects and prevent unexpected bills."
---
&#123;% raw %}

Oct 5, 2023

2023 年 10 月 5 日

Realtime Usage Alerts, SMS Notifications, and Automatic Project Pausing

实时用量告警、短信通知与项目自动暂停

Serverless infrastructure can instantly and infinitely scale. While powerful, this has had tradeoffs. An unforced error or traffic spike could cause an unexpected bill.

无服务器基础设施可即时、无限地弹性伸缩。虽然功能强大，但这也带来了一些权衡取舍：一次非预期的错误或流量激增，都可能导致意外账单。

We heard your feedback—you wanted more control over your usage and spend. Today, we're rolling out new controls to help you safely scale your projects and manage spend:

我们认真听取了您的反馈——您希望对资源用量和费用支出拥有更强的掌控力。今天，我们正式推出一系列新控件，助您更安全地扩展项目规模，并更有效地管理费用支出：

- **Email / Web / SMS notifications** when your spend passes defined amounts

- 当费用支出超过预设阈值时，通过**电子邮件 / 网页通知 / 短信（SMS）** 发送提醒

- **Flexible webhooks** to instantly take action on real-time usage updates

- **灵活的 Webhook** 接口，支持在接收到实时用量更新时立即执行自定义操作

- **Automatic project pausing** when you reach your defined spend amount

- 当费用支出达到您设定的上限时，**自动暂停项目**

- **New APIs** to programmatically pause and resume your projects

- 全新 **API 接口**，支持以编程方式暂停和恢复您的项目

- **Safe defaults** for Vercel Functions with higher max durations

- 为 Vercel Functions 提供更稳妥的默认配置，包括更高的最大执行时长

## More confidence with Spend Management

## 费用管理，更添信心

You can now instantly take action when your usage increases with **Spend Management and SMS notifications**.

您现在可在用量增加时，立即采取行动——借助**支出管理（Spend Management）与短信（SMS）通知**功能。

![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_001.jpg)![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_002.jpg)

### What is Spend Management?

### 什么是支出管理（Spend Management）？

Spend management lets you take action when your usage hits the defined spend amount, either through:

支出管理功能允许您在用量达到预设支出额度时，自动执行以下任一操作：

- [Sending a notification](https://vercel.com/docs/accounts/spend-management#managing-alert-threshold-notifications)  
  [发送通知](https://vercel.com/docs/accounts/spend-management#managing-alert-threshold-notifications)

- [Triggering a webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)  
  [触发 Webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)

- [Pause the production deployment of all your projects](https://vercel.com/docs/accounts/spend-management#pausing-projects)  
  [暂停您所有项目的生产环境部署](https://vercel.com/docs/accounts/spend-management#pausing-projects)


### **Receiving notifications**

### **接收通知**

When your spend approaches or exceeds your set amount, you'll receive real-time notifications to help you stay in control. This includes **Web** and **Email** notifications at 50%, 75%, and 100%. Additionally, you can also receive **SMS** notifications when your spending reaches 100%.

当您的支出接近或超出所设定的限额时，系统将实时向您发送通知，助您及时掌控预算。通知形式包括：在支出达 **50%、75% 和 100%** 时，通过 **网页端（Web）** 和 **电子邮件（Email）** 发送提醒；此外，当支出达到 **100%** 时，您还可额外收到 **短信（SMS）** 通知。

Some examples of using Spend Management might look like:  

使用支出管理功能的一些典型场景示例如下：

- After launching your new product, you want to monitor growth and be alerted if things start to go viral. You define a Spend Notification for $200 to get alerted on your usage in real time. Once your spend reaches $200, an email notification is sent immediately.

- 新产品上线后，您希望持续监控增长趋势，并在流量出现爆发式增长（“走红”）时及时收到提醒。为此，您设置了一个支出通知（Spend Notification），阈值为 200 美元，以便实时掌握资源使用情况。一旦累计支出达到 200 美元，系统将立即发送一封电子邮件提醒。

- You are building a small AI project and are worried about potential malicious usage. Even though you’ve added [rate limiting](https://vercel.com/guides/rate-limiting-edge-middleware-vercel-kv), you want peace of mind knowing it won’t cost you more than $50. You define a Spend Notification for $50 to pause all projects when the spend amount if reached.

- 您正在开发一个小型 AI 项目，但担心可能遭遇恶意调用。尽管您已配置了[速率限制（rate limiting）](https://vercel.com/guides/rate-limiting-edge-middleware-vercel-kv)，仍希望确保总支出严格控制在 50 美元以内。因此，您设置了一个 50 美元的支出通知，当支出达到该阈值时，自动暂停所有相关项目。

![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_003.jpg)![](images/spend-management-realtime-usage-alerts-sms-notifications-and-project-pausing-ver/img_004.jpg)

Rather than waiting hours (or sometimes days) on other infrastructure, Vercel can measure and report back usage immediately, thanks to our real-time usage data pipeline.

相较于其他基础设施动辄需要数小时（甚至数天）才能反馈用量数据，Vercel 凭借实时用量数据管道（real-time usage data pipeline），可即时完成用量计量与上报。

On top of the default usage notifications through email or in-product, the addition of flexible spend notifications and our [Pause API](https://vercel.com/docs/rest-api/endpoints#pause-a-project) allows you to have complete confidence in your Vercel project. You can either automatically pause your projects when the spend amount is reached, or use a webhook to call the API programmatically.

除默认支持的电子邮件及站内通知外，灵活的支出通知功能，叠加我们的 [Pause API](https://vercel.com/docs/rest-api/endpoints#pause-a-project)，让您对 Vercel 项目的可控性与安全性拥有十足信心。您既可选择在支出达限时自动暂停项目，也可通过 Webhook 编程方式调用该 API。

app/api/pause/route.ts

```tsx
export async function POST(request: Request) {

2  await fetch('https://api.vercel.com/v1/projects/<project-id>/pause?teamId=<team-id>', {

3    headers: {

4      Authorization: 'Bearer <your-token>',

5      'Content-Type': 'application/json'

5      'Content-Type': 'application/json'

6    },

6    },

7    method: 'POST'

7    method: 'POST'

8  });

8  });

9  return new Response('Project paused');

9  return new Response('Project paused');

10}
```

10}
```

You can programmatically pause Vercel projects using our new REST API endpoint.

您可以使用我们的全新 REST API 端点，以编程方式暂停 Vercel 项目。

## Updates to Vercel Functions

## Vercel Functions 的更新

Earlier this year, we released automatic recursion protection for Vercel Functions. This has already **prevented thousands of dollars in unintentional costs** for our customers.

今年早些时候，我们为 Vercel Functions 推出了自动递归防护功能。该功能已帮助客户**避免了数千美元的意外支出**。

This has been an improvement, but your feedback has been you want both lower defaults to prevent unintentional large bills, as well as the ability to have longer running Vercel Functions.

这一改进固然有益，但根据您的反馈，您既希望进一步降低默认配置以防止意外产生高额账单，也希望支持运行时间更长的 Vercel Functions。

### Run Functions for up to five minutes

### 函数最长可运行五分钟

Customers deploying AI workloads with [Vercel Functions](https://vercel.com/docs/functions) have enjoyed streaming responses back with the [AI SDK](https://sdk.vercel.ai/docs), but not all of these workloads were chat or generative based. For some computationally heavy tasks like generating images, customers have wanted longer running Vercel Functions with the full power of Node.js.

使用 [Vercel Functions](https://vercel.com/docs/functions) 部署 AI 工作负载的客户，已能通过 [AI SDK](https://sdk.vercel.ai/docs) 流式返回响应；但这些工作负载并非全部属于聊天或生成式场景。对于图像生成等计算密集型任务，客户一直希望 Vercel Functions 能支持更长的运行时长，并充分释放 Node.js 的全部能力。

**You can run up to 5 minute functions** on the Pro plan. In addition, there is now a safer default timeout of 15 seconds ([configurable](https://vercel.com/docs/functions/configuring-functions/duration)). This helps prevent uncontrolled function usage due to abuse and reduces the risk of unexpectedly high bills.

**Pro 计划用户可运行最长达五分钟的函数**。此外，我们还引入了更安全的默认超时时间——15 秒（[可配置](https://vercel.com/docs/functions/configuring-functions/duration)）。此举有助于防止因滥用导致的函数无节制调用，同时降低账单意外飙升的风险。

## What's next for Spend Management

## 费用管理的后续规划

While we're excited about the new controls for managing your spend and getting alerted on real-time usage changes, there's more we want to do.

尽管我们对新增的费用管控能力以及实时用量变更告警功能倍感振奋，但这仅是起点，我们还有更多计划。

Next, we're working on **powerful anomaly detection** for your spend to proactively alert you when spikes happen, rather than manually adding spend amounts. Stay tuned for more product updates to help you scale with confidence on Vercel.

接下来，我们将推出**强大的费用异常检测功能**，在费用出现激增时主动向您发出告警，而无需您手动设定费用阈值。敬请关注更多产品更新，助您在 Vercel 上自信、稳健地实现规模化增长。

[Check out our documentation on Spend Management](https://vercel.com/docs/accounts/spend-management) and let us know your feedback.

[查阅费用管理相关文档](https://vercel.com/docs/accounts/spend-management)，并欢迎随时向我们反馈您的宝贵意见。
&#123;% endraw %}
