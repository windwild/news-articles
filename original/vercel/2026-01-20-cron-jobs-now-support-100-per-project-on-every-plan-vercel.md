---
title: "Cron jobs now support 100 per project on every plan - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/cron-jobs-now-support-100-per-project-on-every-plan"
date: "2026-01-20"
scraped_at: "2026-03-02T09:22:24.120034194+00:00"
language: "en"
translated: false
description: "Cron jobs on Vercel no longer have per-team limits. Create up to 100 scheduled tasks per project, at any interval, on all plans."
---




Jan 20, 2026

Cron jobs on Vercel no longer have per-team limits, and per-project limits were lifted to 100 on all plans.

Previously, all plans had a cap of 20 cron jobs per project, with per-team limits of 2 for Hobby, 40 for Pro, and 100 for Enterprise.

To get started, add cron entries to `vercel.json`:

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

You can also deploy the [Vercel Cron Job template](https://vercel.com/templates/template/vercel-cron).

Once you deploy, Vercel automatically registers your cron jobs. Learn more in the [Cron Jobs documentation](https://vercel.com/docs/cron-jobs).