---
title: "Preview links between microfrontends projects now serve all paths - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/preview-links-between-microfrontends-projects-now-serve-all-paths"
date: "2025-10-21"
scraped_at: "2026-03-02T09:26:59.975763575+00:00"
language: "en-zh"
translated: true
description: "Teams using microfrontends can now visit all routes from any domain in the microfrontends group, enabling teams to test their full site experience without broken links or missing pages."
---
{% raw %}

Oct 21, 2025

2025 年 10 月 21 日

Teams using [microfrontends](https://vercel.com/docs/microfrontends) can now visit all routes from any domain in the microfrontends group, enabling teams to test their full site experience without broken links or missing pages.

使用 [微前端（microfrontends）](https://vercel.com/docs/microfrontends) 的团队现在可以从微前端组内的任意域名访问所有路由，从而让团队能够在无失效链接或缺失页面的情况下，完整测试其网站体验。

Previously, the microfrontend group's root domain would be the only one to serve the paths hosted by child microfrontends. Now, preview links between all microfrontends projects automatically serve all routes in the group.

此前，仅微前端组的根域名可提供子微前端所托管的路径。如今，所有微前端项目之间的预览链接将自动提供该组内的全部路由。

With this new feature:

借助这一新功能：

- Preview links on child microfrontends now route paths to other microfrontends in the group, eliminating 404s.

- 子微前端上的预览链接现在可将路径路由至组内其他微前端，彻底消除 404 错误。

- Deployments built from the same commit or branch automatically link to each other, making it easier to test changes in monorepos.

- 基于同一提交（commit）或分支构建的部署将自动相互关联，从而简化单体仓库（monorepo）中变更的测试流程。

- [Fallback routing](https://vercel.com/docs/microfrontends/managing-microfrontends#fallback-environment) ensures that requests to microfrontends not built on the same branch are still resolved.

- [回退路由（Fallback routing）](https://vercel.com/docs/microfrontends/managing-microfrontends#fallback-environment) 可确保即使请求的目标微前端并非基于同一分支构建，该请求仍能被正确解析。

This feature is enabled by default for all new microfrontends, and will be rolling out slowly for existing teams.

该功能默认对所有新建微前端启用，并将逐步向现有团队推广。

[Learn more](https://vercel.com/docs/microfrontends/path-routing#microfrontends-domain-routing) or [get started with microfrontends](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fmicrofrontends) today.

[了解详情](https://vercel.com/docs/microfrontends/path-routing#microfrontends-domain-routing)，或立即 [开始使用微前端](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fsettings%2Fmicrofrontends)。
{% endraw %}
