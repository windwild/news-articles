---
title: "Manually purge the CDN cache - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manually-purge-the-cdn-cache"
date: "2025-06-24"
scraped_at: "2026-03-02T09:32:29.103661596+00:00"
language: "en-zh"
translated: true
description: "Vercel's CDN Cache can now be purged with the click of a button in the dashboard or by running a CLI command, vercel cache purge --type=cdn, using version 44.2.0 or newer."
---
{% raw %}

Jun 24, 2025

2025年6月24日

![](images/manually-purge-the-cdn-cache-vercel/img_001.jpg)![](images/manually-purge-the-cdn-cache-vercel/img_002.jpg)

Users with the **Member** role can now purge Vercel’s CDN cache manually, either via the project's [cache settings dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fcaches&title=Go+to+Cache+Settings) or by running `vercel cache purge --type=cdn` in CLI version 44.2.0 or later.

拥有 **Member** 角色的用户现在可通过项目的 [缓存设置控制台](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fcaches&title=Go+to+Cache+Settings)，或在 CLI 44.2.0 及更高版本中运行命令 `vercel cache purge --type=cdn`，手动清除 Vercel 的 CDN 缓存。

By default, the CDN cache is purged automatically with each new deployment. For cases where you want to refresh cached content instantly (without waiting for a new build), you can now manually purge the global CDN cache in milliseconds.

默认情况下，CDN 缓存会在每次新部署时自动清除。若需立即刷新已缓存的内容（无需等待新构建完成），您现在可在毫秒级内手动清除全局 CDN 缓存。

This is especially useful for persistent cache scenarios, like **Image Optimization**, where paths are cached across deployments. If upstream images have changed, you can now force a refresh instantly.

这一功能在需要持久化缓存的场景中尤为实用，例如 **Image Optimization（图像优化）** —— 此类场景中，路径缓存会跨部署持续存在。当上游图像资源发生变更时，您现在可即时强制刷新缓存。

Learn more in the [documentation](https://vercel.com/docs/edge-cache#manually-purging-edge-cache).

更多详情，请参阅 [文档](https://vercel.com/docs/edge-cache#manually-purging-edge-cache)。
{% endraw %}
