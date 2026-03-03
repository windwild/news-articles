---
title: "Rolling Releases are now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/rolling-releases-are-now-generally-available"
date: "2025-06-25"
scraped_at: "2026-03-02T09:32:19.733549389+00:00"
language: "en"
translated: false
description: "Rolling Releases are now generally available, enabling incremental rollouts of new production deployments. Advance through defined rollout stages for safer deploys. Available now for Pro and Enterpris..."
---




Jun 25, 2025

![](images/rolling-releases-are-now-generally-available-vercel/img_001.jpg)![](images/rolling-releases-are-now-generally-available-vercel/img_002.jpg)

Rolling Releases are now generally available, allowing safe, incremental rollouts of new deployments with built-in monitoring, rollout controls, and no custom routing required.

Each rollout starts at a defined stage and can either progress automatically or be manually promoted to a full release. You can configure rollout stages per project and decide how each stage progresses, with updates propagating globally in under 300ms through our fast propagation pipeline.

Rolling releases also include:

- **Real-time monitoring**: Track and compare error rates and [Speed Insights](https://vercel.com/docs/speed-insights) (like [Core Web Vitals](https://web.dev/articles/vitals#core-web-vitals), Time to First Byte, and more) between versions

- **Flexible controls**: Rollouts can be managed via REST API, CLI, the project dashboard, or the Vercel Terraform provider

- **Version-labeled logs**: Logs and telemetry are labeled by deployment for easier debugging


Pro and Enterprise teams can enable Rolling Releases on one project at no additional cost. Enterprise customers can upgrade to unlimited projects.

Learn more about [Rolling Releases](https://vercel.com/docs/rolling-releases) or [enable it on your project](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment&title=Go+to+Rolling+Releases).