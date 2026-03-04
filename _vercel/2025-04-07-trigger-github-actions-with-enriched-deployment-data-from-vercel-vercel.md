---
title: "Trigger GitHub Actions with enriched deployment data from Vercel - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/trigger-github-actions-with-enriched-deployment-data-from-vercel"
date: "2025-04-07"
scraped_at: "2026-03-02T09:34:52.757810180+00:00"
language: "en-zh"
translated: true
description: "You can now use repository_dispatch events in GitHub Actions for your Vercel projects, simplifying how you trigger GitHub Actions workflows in response to Vercel deployments."
---

render_with_liquid: false
Apr 7, 2025

2025 年 4 月 7 日

You can now trigger GitHub Actions workflows in response to Vercel deployment events with enriched data using [`repository_dispatch` events](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#repository_dispatch). These events are sent from Vercel to GitHub, enabling more flexible, cost-efficient CI workflows, and easier [end-to-end testing for Vercel deployments](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment).

现在，您可以通过 [`repository_dispatch`](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#repository_dispatch) 事件，在 Vercel 部署事件发生时触发 GitHub Actions 工作流，并获取更丰富的上下文数据。这些事件由 Vercel 发送至 GitHub，从而支持更灵活、更具成本效益的持续集成（CI）工作流，并简化 Vercel 部署的[端到端测试](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment)。

Previously, we recommended using [`deployment_status` events](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#deployment_status), but these payloads were limited and required extra parsing or investigation to understand what changed.

此前，我们推荐使用 [`deployment_status`](https://docs.github.com/en/actions/writing-workflows/choosing-when-your-workflow-runs/events-that-trigger-workflows#deployment_status) 事件，但其有效载荷（payload）信息有限，需额外解析或人工排查才能明确具体变更内容。

With `repository_dispatch`, Vercel sends custom JSON payloads with full deployment context—allowing you to reduce Github Actions overhead and streamline your CI pipelines.

借助 `repository_dispatch`，Vercel 将发送包含完整部署上下文的自定义 JSON 有效载荷——帮助您降低 GitHub Actions 的运行开销，并精简 CI 流水线。

We recommend [migrating to `repository_dispatch`](https://vercel.com/docs/git/vercel-for-github#repository-dispatch-events) for a better experience. `deployment_status` events will continue to work for backwards compatibility.

我们建议您[迁移到 `repository_dispatch`](https://vercel.com/docs/git/vercel-for-github#repository-dispatch-events)，以获得更佳体验。`deployment_status` 事件仍将保留，以确保向后兼容性。