---
render_with_liquid: false
title: "Spend Management now available for Pro users - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/spend-management-now-available-for-pro-users"
date: "2023-10-05"
scraped_at: "2026-03-02T09:50:11.334189003+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Oct 5, 2023

2023 年 10 月 5 日

![](images/spend-management-now-available-for-pro-users-vercel/img_001.jpg)![](images/spend-management-now-available-for-pro-users-vercel/img_002.jpg)

Today, we'll begin rolling out Spend management on the Pro plan for the [Billing](https://vercel.com/docs/accounts/team-members-and-roles/access-roles#billing-role) and [Owner](https://vercel.com/docs/accounts/team-members-and-roles/access-roles#owner-role) roles. You can recieve notifications and trigger webhooks when you pass a given spend amount on metered resources like Functions. The actions you can take are:

今天，我们将开始面向专业版（Pro）计划中的[账单管理员](https://vercel.com/docs/accounts/team-members-and-roles/access-roles#billing-role)和[所有者](https://vercel.com/docs/accounts/team-members-and-roles/access-roles#owner-role)角色推出“支出管理”（Spend Management）功能。当您在按量计费资源（例如 Functions）上的支出超过设定阈值时，系统将向您发送通知并触发 Webhook。您可以执行以下操作：

- [Send a notification](https://vercel.com/docs/accounts/spend-management#managing-alert-threshold-notifications)

- [发送通知](https://vercel.com/docs/accounts/spend-management#managing-alert-threshold-notifications)

- [Trigger a webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)

- [触发 Webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)

When your spending approaches or exceeds the set limit, you'll receive realtime notifications to help you stay in control. This includes **Web** and **Email** notifications at 50%, 75%, and 100%. Additionally, you can also receive **SMS** notifications when your spending reaches 100%.

当您的支出接近或超出设定限额时，您将实时收到通知，以便及时掌控预算使用情况。通知方式包括在支出达到 **50%、75% 和 100%** 时通过 **网页端（Web）** 和 **电子邮件（Email）** 发送提醒；此外，当支出达到 **100%** 时，您还可选择接收 **短信（SMS）** 提醒。

Setting a spend amount does not mean your project with pause automatically. To programmatically take action based on your set amount, you can use a [webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook) to pause your project, or even put your site into [maintenance mode](https://vercel.com/templates/next.js/maintenance-page).

设置支出限额并不会自动暂停您的项目。如需根据设定的支出阈值自动执行操作，您可通过配置[Webhook](https://vercel.com/docs/accounts/spend-management#configuring-a-webhook)来暂停项目，甚至将网站切换至[维护模式（Maintenance Mode）](https://vercel.com/templates/next.js/maintenance-page)。

[Check out our documentation](https://vercel.com/docs/accounts/spend-management) to learn more.

[查阅我们的文档](https://vercel.com/docs/accounts/spend-management)以了解更多信息。