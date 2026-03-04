---
title: "Introducing Vercel Cron Jobs - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/cron-jobs"
date: "2023-02-22"
scraped_at: "2026-03-02T09:54:49.936733316+00:00"
language: "en-zh"
translated: true
description: "Automate repetitive tasks using Vercel Cron Jobs and Vercel Functions. Available today in beta."
---
&#123;% raw %}

Feb 22, 2023

2023 年 2 月 22 日

Schedule tasks and automate workflows in seconds.

在几秒钟内安排任务并自动化工作流。

Vercel Cron Jobs can be used with Vercel Functions to:

Vercel Cron Jobs 可与 Vercel Functions 配合使用，以实现以下功能：

- Trigger updates to and from third-party APIs

  - 触发与第三方 API 的双向数据更新

- Monitor services and alert on their health

  - 监控服务状态，并在其健康状况异常时发出告警

- Run critical jobs like data backups or archives

  - 执行关键任务，例如数据备份或归档

- Collect product and billing metrics to generate reports

  - 收集产品和计费指标，用于生成报表

Get started by creating a `vercel.json` file:

通过创建一个 `vercel.json` 文件开始使用：

vercel.json

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

不同 Vercel Cron Job 的示例

[阅读文档](https://vercel.com/docs/cron-jobs)，部署一个[带 Cron 的示例项目](https://vercel.com/templates/next.js/vercel-cron)，或继续阅读以了解更多信息。

## 使用 cron 表达式

Cron 任务使用一种称为 [cron 表达式](https://vercel.com/docs/cron-jobs#cron-expressions) 的特定语法来确定任务的执行时间。该语法由五个以空格分隔的字段组成，每个字段代表调度计划中的一个不同维度：

```bash
1# ┌───────────── 分钟（0 – 59）

2# │ ┌───────────── 小时（0 – 23）

3# │ │ ┌───────────── 日期（1 – 31）

4# │ │ │ ┌───────────── 月份（1 – 12）

5# │ │ │ │ ┌───────────── 星期几（0 - 6）（0 表示星期日，6 表示星期六）

6# │ │ │ │ │

7# │ │ │ │ │

8# │ │ │ │ │

9# * * * * *

```

一个展示 cron 表达式中各字段取值的示例。

前五个字段共同决定执行计划，每个字段均支持多个值和范围。`*` 字符表示该字段的所有可能取值，意味着对应命令将按该字段的单位（如每分钟、每小时、每天等）重复执行。以下是一些 cron 表达式的示例：

- **`0 * * * *`**：每小时整点执行一次命令  

- **`30 2 * * *`**：每天凌晨 2:30 执行一次命令  

- **`0 0 1 * *`**：每月 1 日午夜（00:00）执行一次命令

- **`0 0 * * 0`**: Run a command every Sunday at midnight

- **`0 0 * * 0`**: 每周日凌晨零点执行一条命令

## Usage with any framework

## 与任意框架配合使用

The initial release of Vercel Cron Jobs is a generalized solution that works with any framework or website without native integration through the usage of `vercel.json`.

Vercel Cron Jobs 的初始版本是一个通用化解决方案，无需框架原生集成，仅通过 `vercel.json` 即可适配任意框架或网站。

Framework authors can add native support for Cron Jobs in their framework by targeting the [Build Output API](https://vercel.com/docs/build-output-api/v3#build-output-configuration/supported-properties/crons), which is a specification used to add support for any Vercel platform features.

框架作者可通过对接 [构建输出 API（Build Output API）](https://vercel.com/docs/build-output-api/v3#build-output-configuration/supported-properties/crons) 为其框架添加对 Cron Jobs 的原生支持。该 API 是一项规范，用于为任意 Vercel 平台功能提供支持。

We are exploring native cron support in both Next.js and SvelteKit. This will add better ergonomics for usage, as well as improved TypeScript support and in-editor suggestions for cron expression values.

我们正在 Next.js 和 SvelteKit 中探索对 Cron 的原生支持。这将显著提升使用体验，同时增强 TypeScript 类型支持，并在编辑器中为 Cron 表达式值提供智能提示。

## Included Resources for Cron Jobs and Vercel Functions

## Cron Jobs 与 Vercel Functions 的包含资源

While in beta, the following limits apply to Vercel Cron Jobs:

在 Beta 阶段，Vercel Cron Jobs 遵循以下限制：

- **Hobby:** 2 cron jobs total, each triggered once per day

- **Hobby（免费版）：** 最多 2 个 Cron Job，每个每天最多触发一次

- **Pro:** 40 cron jobs total, unlimited usage per day

- **Pro（专业版）：** 最多 40 个 Cron Job，每日触发次数无限制

- **Enterprise:** 100 cron jobs, unlimited usage per day

- **Enterprise（企业版）：** 最多 100 个 Cron Job，每日触发次数无限制

Cron jobs duration limits are the same as [Serverless and Edge Functions limits](https://vercel.com/docs/functions/serverless-functions/runtimes#max-execution-duration).

Cron 任务的执行时长限制与 [Serverless 函数和 Edge 函数的限制](https://vercel.com/docs/functions/serverless-functions/runtimes#max-execution-duration) 相同。

While in beta, Vercel Cron Jobs are free on all plans. However, it'll be a paid feature for general availability.

目前处于 Beta 阶段，Vercel Cron Jobs 在所有套餐中均免费使用；但正式发布（General Availability）后，该功能将转为付费服务。

## Get started with Vercel Cron Jobs

## 开始使用 Vercel Cron Jobs

Cron jobs are a powerful tool for automating repetitive tasks. By using cron expressions, you can schedule tasks to run automatically at specific intervals, saving you time and effort.

Cron 任务是自动化重复性任务的强大工具。借助 cron 表达式，您可以按特定时间间隔自动调度任务执行，从而节省大量时间和精力。

Get started with Vercel Cron Jobs by [deploying your first template](https://vercel.com/templates/next.js/vercel-cron) or [reading the documentation](https://vercel.com/docs/cron-jobs), including frequently asked questions like:

您可通过 [部署首个模板](https://vercel.com/templates/next.js/vercel-cron) 或 [查阅文档](https://vercel.com/docs/cron-jobs) 快速上手 Vercel Cron Jobs，文档中还包含以下常见问题解答：

- [How long can a cron job run?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-job-duration)

- [一个 Cron 任务最长可运行多久？](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-job-duration)

- [Will Vercel retry cron jobs?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-job-error-handling)

- [Vercel 会重试失败的 Cron 任务吗？](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-job-error-handling)

- [How to secure cron jobs?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#securing-cron-jobs)

- [如何保障 Cron 任务的安全性？](https://vercel.com/docs/cron-jobs/manage-cron-jobs#securing-cron-jobs)

- [Are dynamic routes supported?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-jobs-with-dynamic-routes)

- [是否支持动态路由？](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-jobs-with-dynamic-routes)

- [Can a cron job generate 404s?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#handling-nonexistent-paths)

- [Cron 任务是否会返回 404 错误？](https://vercel.com/docs/cron-jobs/manage-cron-jobs#handling-nonexistent-paths)

- [Will new deployments kill the currently running cron jobs?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-jobs-and-deployments)

- 新部署是否会终止当前正在运行的定时任务？(https://vercel.com/docs/cron-jobs/manage-cron-jobs#cron-jobs-and-deployments)

- [How to control the concurrency of cron jobs?](https://vercel.com/docs/cron-jobs/manage-cron-jobs#controlling-cron-job-concurrency)

- 如何控制定时任务的并发数？(https://vercel.com/docs/cron-jobs/manage-cron-jobs#controlling-cron-job-concurrency)
&#123;% endraw %}
