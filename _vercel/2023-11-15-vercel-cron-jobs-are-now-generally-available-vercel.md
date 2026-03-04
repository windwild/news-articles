---
title: "Vercel Cron Jobs are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cron-jobs-are-now-generally-available"
date: "2023-11-15"
scraped_at: "2026-03-02T09:49:36.275175030+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Nov 15, 2023

2023 年 11 月 15 日

![](images/vercel-cron-jobs-are-now-generally-available-vercel/img_001.jpg)![](images/vercel-cron-jobs-are-now-generally-available-vercel/img_002.jpg)

Vercel Cron Jobs let you to run scheduled jobs for things like data backups or archives, triggering updates to third-party APIs, sending email and Slack notifications, or any task you need to run on a schedule.

Vercel 定时任务（Cron Jobs）允许您按计划执行各类任务，例如数据备份或归档、触发对第三方 API 的更新、发送电子邮件和 Slack 通知，或任何您需要定期运行的任务。

By using a specific syntax called a [cron expression](https://vercel.com/docs/cron-jobs#cron-expressions), you can define the frequency and timing of each task. Cron Jobs work with any frontend framework and can be defined in `vercel.json`. You can use them to run your [Serverless Functions](https://vercel.com/docs/concepts/functions/serverless-functions) and [Edge Functions](https://vercel.com/docs/concepts/functions/edge-functions).

通过一种名为 [cron 表达式](https://vercel.com/docs/cron-jobs#cron-expressions) 的特定语法，您可以定义每个任务的执行频率与具体时间。Cron Jobs 兼容任意前端框架，并可在 `vercel.json` 文件中进行配置；您可利用它来运行自己的 [Serverless Functions（无服务器函数）](https://vercel.com/docs/concepts/functions/serverless-functions) 和 [Edge Functions（边缘函数）](https://vercel.com/docs/concepts/functions/edge-functions)。

During the beta, we made Cron Jobs more secure by providing an environment variable with the name [`CRON_SECRET`](https://vercel.com/docs/cron-jobs/manage-cron-jobs#securing-cron-jobs). We also added support for [Deployment Protection](https://vercel.com/docs/security/deployment-protection) and [Instant Rollback](https://vercel.com/docs/deployments/instant-rollback).

在公测阶段，我们通过提供名为 [`CRON_SECRET`](https://vercel.com/docs/cron-jobs/manage-cron-jobs#securing-cron-jobs) 的环境变量，进一步提升了 Cron Jobs 的安全性。此外，我们还增加了对 [部署保护（Deployment Protection）](https://vercel.com/docs/security/deployment-protection) 和 [即时回滚（Instant Rollback）](https://vercel.com/docs/deployments/instant-rollback) 的支持。

Cron Jobs are now **included for customers on all plans**. Per account, users on the Hobby plan will have access to 2 Cron Jobs, users on the Pro plan will have access to 40 Cron Jobs, and users on the Enterprise plan will have access to 100 Cron Jobs.

Cron Jobs 现已 **面向所有付费计划的客户免费包含**。每个账户可使用的 Cron Jobs 数量如下：Hobby 计划用户可使用 2 个，Pro 计划用户可使用 40 个，Enterprise 计划用户可使用 100 个。

Check out our [documentation](https://vercel.com/docs/cron-jobs) or [deploy an example with Cron Jobs](https://vercel.com/templates/next.js/vercel-cron).

请查阅我们的 [文档](https://vercel.com/docs/cron-jobs)，或 [使用 Cron Jobs 部署一个示例项目](https://vercel.com/templates/next.js/vercel-cron)。
&#123;% endraw %}
