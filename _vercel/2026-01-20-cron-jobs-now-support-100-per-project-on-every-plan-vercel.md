---
title: "Cron jobs now support 100 per project on every plan - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/cron-jobs-now-support-100-per-project-on-every-plan"
date: "2026-01-20"
scraped_at: "2026-03-02T09:22:24.120034194+00:00"
language: "en-zh"
translated: true
description: "Cron jobs on Vercel no longer have per-team limits. Create up to 100 scheduled tasks per project, at any interval, on all plans."
---

render_with_liquid: false
Jan 20, 2026

2026 年 1 月 20 日

Cron jobs on Vercel no longer have per-team limits, and per-project limits were lifted to 100 on all plans.

Vercel 上的 Cron 任务已取消按团队（per-team）的限制；所有套餐中，每个项目的 Cron 任务上限均已提升至 100 个。

Previously, all plans had a cap of 20 cron jobs per project, with per-team limits of 2 for Hobby, 40 for Pro, and 100 for Enterprise.

此前，所有套餐均限制每个项目最多运行 20 个 Cron 任务；按团队的限制则分别为：Hobby 套餐 2 个、Pro 套餐 40 个、Enterprise 套餐 100 个。

To get started, add cron entries to `vercel.json`:

要开始使用，请在 `vercel.json` 文件中添加 Cron 配置项：

vercel.json

```json
1{

2  "crons": [\
\
3    {\
\
4      "path": "/api/send-slack-notification",\
\
5      "schedule": "*/10 * * * *"\
\
6    },\
\
7    {\
\
8      "path": "/api/daily-backup",\
\
9      "schedule": "0 2 * * * *"\
\
10    },\
\
11    {\
\
12      "path": "/api/hourly-onboarding-emails",\
\
13      "schedule": "0 * * * *"\
\
14    }\
\
15  ]

16}
```

An example of different Vercel Cron Jobs

不同 Vercel Cron 任务的示例

You can also deploy the [Vercel Cron Job template](https://vercel.com/templates/template/vercel-cron).

您还可以一键部署 [Vercel Cron Job 模板](https://vercel.com/templates/template/vercel-cron)。

Once you deploy, Vercel automatically registers your cron jobs. Learn more in the [Cron Jobs documentation](https://vercel.com/docs/cron-jobs).

部署后，Vercel 会自动注册您的定时任务（cron jobs）。更多详情，请参阅 [定时任务文档](https://vercel.com/docs/cron-jobs)。