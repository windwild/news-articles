---
title: "Dashboard redesign - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/dashboard-redesign"
date: "2019-11-20"
scraped_at: "2026-03-02T10:07:18.958626051+00:00"
language: "en-zh"
translated: true
description: "We're bringing the simplicity of our developer experience to our web dashboard. Creating new projects, importing existing code, managing domains, setting up redirects, inspecting deployments and funct..."
---
&#123;% raw %}

Nov 20, 2019

2019 年 11 月 20 日

随着 [零配置部署（Zero Config Deployments）](https://zeit.co/blog/zero-config) 的推出，Vercel 让网站与应用程序的部署变得前所未有的简单。如今，我们正将这种简洁流畅的开发者体验延伸至我们的网页控制台（web dashboard）。

创建新项目、导入现有代码、管理域名、配置重定向规则、查看部署与函数详情，以及团队管理——所有这些操作都比以往更加轻松便捷。

我们正式发布 **Vercel 控制台（Dashboard）** 的全新演进版本。

![全新的 Vercel 控制台。](images/dashboard-redesign-vercel/img_001.jpg)  
全新的 Vercel 控制台。

## 控制台概览（Dashboard Overview）

本次控制台的全面改版，源自我们活跃用户提供的宝贵反馈。我们的目标是让您能更快速、更直观地访问项目中最关键的信息与功能：

- 生产环境（Production）及最新部署的状态；  
- 项目级 Git 代码仓库连接状态；  
- 指向生产环境部署的快捷链接。

## Easily Import Code

## 轻松导入代码

With our [GitHub](https://zeit.co/github) and [GitLab](https://zeit.co/gitlab) integrations, we now offer a streamlined approach to import and deploy projects with Vercel, directly from your dashboard. Once imported, your repository will be configured automatically so that you can push to deploy.

借助我们的 [GitHub](https://zeit.co/github) 和 [GitLab](https://zeit.co/gitlab) 集成，我们现在支持通过仪表板直接将项目一键导入并部署至 Vercel。导入后，您的代码仓库将自动完成配置，您只需推送代码即可触发部署。

![Automatically deploy a template or repository to Vercel](images/dashboard-redesign-vercel/img_002.jpg)  
自动将模板或代码仓库部署至 Vercel

## Projects

## 项目列表

For a quick glimpse of your projects, we now provide screenshots of your latest production deployments.

为帮助您快速概览所有项目，我们现为您展示每个项目的最新生产环境部署截图。

![An overview of all your Vercel projects, accompanied with screenshots](images/dashboard-redesign-vercel/img_003.jpg)  
您所有 Vercel 项目的概览，附带各项目部署截图

## Project Overview

## 项目概览

We now highlight the two most important aspects of your projects: production deployment and preview deployments. Stay informed about your live production deployment, and see what your teammates are working on with a preview deployments list filtered by each member.

我们现重点呈现您项目的两大核心环节：生产环境部署与预览部署。您可随时掌握线上生产环境的实时状态；同时，通过按团队成员筛选的预览部署列表，清晰了解每位同事当前正在开发和测试的内容。

![An overview of your live production deployment.](images/dashboard-redesign-vercel/img_004.jpg)  
您线上生产环境部署的概览

![Preview Deployments from Git branches or deployed with Vercel.](images/dashboard-redesign-vercel/img_005.jpg)  
来自 Git 分支或通过 Vercel 部署的预览部署

## Deployment Overview

## 部署概览

To help debug your projects, logs are now incorporated into the deployment overview. Logs can now be filtered by a specific serverless function or build output and copied to your clipboard in a single click.

为帮助您调试项目，日志现已集成至部署概览页面。您现在可按特定的无服务器函数（serverless function）或构建输出（build output）筛选日志，并一键复制到剪贴板。

If the deployment is made with our [GitHub](https://zeit.co/github) or [GitLab](https://zeit.co/gitlab) integrations, you will find relevant information about the git commit, author, branch, and repository.

若部署是通过我们的 [GitHub](https://zeit.co/github) 或 [GitLab](https://zeit.co/gitlab) 集成完成的，您将在概览中看到与 Git 提交（commit）、作者（author）、分支（branch）及代码仓库（repository）相关的详细信息。

![The overview provides meaningful information about an individual deployment.](images/dashboard-redesign-vercel/img_006.jpg)  
![概览为单次部署提供有意义的信息。](images/dashboard-redesign-vercel/img_006.jpg)  
The overview provides meaningful information about an individual deployment.

该概览为单次部署提供有意义的信息。

## Browser Tab Improvements

## 浏览器标签页优化

Like us, you probably have a lot of tabs open while you work. For a quicker overview of your projects, the tab icons and titles of our dashboard pages now contain more useful information.

和我们一样，您工作时很可能打开了大量浏览器标签页。为助您更快速地掌握项目状态，我们仪表板页面的标签页图标与标题现已包含更实用的信息。

On the deployment inspector, the status of your deployment is now reflected in the tab icon as queued, building, error, or ready.

在部署检查器（deployment inspector）中，您的部署状态（排队中、构建中、出错、就绪）现已直接体现在标签页图标上。

Browser tab icons reflect the status of a deployment.

浏览器标签页图标直观反映部署状态。

## Git Integration for Projects

## 项目 Git 集成

It's now easier than ever to link a code repository to your Vercel projects. Once linked, you can enjoy automatic deployments with shareable URLs every time you push a commit or open a pull request.

将代码仓库关联至您的 Vercel 项目，如今比以往任何时候都更加简单。一旦完成关联，每次推送提交（push commit）或创建拉取请求（pull request）时，系统都将自动触发部署，并生成可共享的 URL。

![Select a repository from the project page to automatically deploy on every commit.](images/dashboard-redesign-vercel/img_007.jpg)  
从项目页面选择一个代码仓库，即可在每次提交时自动部署。

## Production Domains

## 生产环境域名

As part of [Zero Config Deployments](https://zeit.co/blog/zero-config), you can now associate production domains with each of your projects in place of the `alias` field of `vercel.json`. This includes `.vercel.app` domains and any custom domains bought through [Vercel](https://zeit.co/domains) or external services.  

作为 [零配置部署（Zero Config Deployments）](https://zeit.co/blog/zero-config) 的一部分，您现在可为每个项目直接关联生产环境域名，从而替代 `vercel.json` 中的 `alias` 字段。这包括 `.vercel.app` 域名，以及通过 [Vercel](https://zeit.co/domains) 或第三方服务商购买的任意自定义域名。

![The interface guides you in setting up production domains for your project.](images/dashboard-redesign-vercel/img_008.jpg)  
界面将引导您为项目配置生产环境域名。

![A valid production domain](images/dashboard-redesign-vercel/img_009.jpg)  
一个有效的生产环境域名。

## Mobile

## 移动端支持

With improvements to our development tooling and design system, we're ensuring that every part of our dashboard works well on both desktop and mobile so you can manage your deployments on the go.  

通过对开发工具链和设计系统的持续优化，我们确保仪表板的每一部分在桌面端与移动端均能良好运行，让您随时随地轻松管理部署。

![The Vercel Dashboard on mobile.](images/dashboard-redesign-vercel/img_010.jpg)  
移动设备上的 Vercel 仪表板。

## Performance

## 性能表现

We understand very well that any great user experience demands great performance.  

我们深知：卓越的用户体验，必然以卓越的性能为基石。

For this redesign, we didn't just stop with UI improvements. We also invested heavily in enhancing the dashboard performance — decreasing the time to First Meaningful Paint by over 1.2s.

此次改版，我们并未止步于用户界面（UI）的优化，更在仪表板性能方面投入大量资源——将“首次有意义绘制”（First Meaningful Paint）时间缩短了超过 1.2 秒。

Here are a few steps we've taken to improve the performance of the Vercel Dashboard

以下是为提升 Vercel 仪表板性能所采取的若干措施：

- [Preconnect](https://developers.google.com/web/fundamentals/performance/resource-prioritization#preconnect) to our API, Assets, and Avatar origins.

- 预连接（[Preconnect](https://developers.google.com/web/fundamentals/performance/resource-prioritization#preconnect)）至我们的 API、Assets 和 Avatar 服务源站。

- Assign critical API calls higher [browser priority](https://developers.google.com/web/fundamentals/performance/resource-prioritization) to avoid blocking requests.

- 为关键 API 调用分配更高的 [浏览器优先级](https://developers.google.com/web/fundamentals/performance/resource-prioritization)，避免阻塞其他请求。

- Memoize in our React components with the `useMemo` and `useCallback` hooks.

- 在 React 组件中使用 `useMemo` 和 `useCallback` 钩子实现记忆化（memoization）。

- Adopt `ReactDOM.unstable_batchedUpdates` to reduce unnecessary re-renders by 20%.

- 采用 `ReactDOM.unstable_batchedUpdates`，将不必要的重新渲染减少 20%。

- Implement [SWR](https://github.com/zeit/swr) to efficiently update dashboard data in realtime.

- 引入 [SWR](https://github.com/zeit/swr)，实现实时、高效地更新仪表板数据。

## Conclusion

## 总结

With a focus on providing better interactions with your projects and deployments, our new dashboard delivers improved speed, better performance, and more useful features. This redesign includes:

我们以提升您与项目及部署交互体验为核心目标，全新设计的仪表板带来了更快的响应速度、更优的性能表现以及更实用的功能。本次改版包含以下内容：

- Dashboard overview.

- 仪表板概览。

- Project-level repository connection.  
- 项目级仓库连接。

- Code import from source control.  
- 从源代码控制工具导入代码。

- Production domains process.  
- 生产环境域名流程。

- Performance enhancements.  
- 性能优化。

We would love to hear your thoughts on our new dashboard! If you'd like to share feedback, ask questions, or just say hi, you can reach out to us over [Twitter](https://twitter.com/vercel) or [Chat](https://zeit.co/chat).  
我们非常期待听到您对我们全新仪表板的看法！如果您希望分享反馈、提出问题，或只是打个招呼，欢迎通过 [Twitter](https://twitter.com/vercel) 或 [聊天室](https://zeit.co/chat) 与我们联系。

A special thank you to [Ana Trajkovska](https://twitter.com/AnaTrajkovska_), [Arunoda Susiripala](https://twitter.com/arunoda), [Leo Lamprecht](https://twitter.com/notquiteleo), and [Timothy Lorimer](https://twitter.com/timothyis_) for helping with making this release a reality.  
特别感谢 [Ana Trajkovska](https://twitter.com/AnaTrajkovska_)、[Arunoda Susiripala](https://twitter.com/arunoda)、[Leo Lamprecht](https://twitter.com/notquiteleo) 和 [Timothy Lorimer](https://twitter.com/timothyis_) 为本次版本发布所付出的努力与支持。
&#123;% endraw %}
