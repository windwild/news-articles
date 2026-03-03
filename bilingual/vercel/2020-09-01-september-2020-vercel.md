---
title: "September 2020 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-september-2020"
date: "2020-09-01"
scraped_at: "2026-03-02T10:06:28.051392053+00:00"
language: "en-zh"
translated: true
description: "Vercel's changelog for September 2020"
---

Sep 1, 2020

2020 年 9 月 1 日

## Dashboard

## 控制台

- 个人账户设置中新增了“登录连接”（Login Connections）页面，用以取代原有的“OAuth”页面。该页面现在会同时显示全部三个 Git 托管平台（GitHub、GitLab 和 Bitbucket），而不再仅显示 GitHub。

- 项目视图（Project View）现已支持通过点击已连接的 Git 仓库名称，直接跳转至该仓库页面；此前该操作会将用户重定向至项目设置页面。

- 用户若通过 [部署按钮](https://vercel.com/docs/more/deploy-button) 进入项目创建流程，现将看到一个专属引导页面，用于介绍 Vercel 的基本概念，并可选地预览即将部署的 Git 仓库内容。

- 部署详情页（Deployment View）上的“访问”（Visit）按钮，现可在尚未创建生产环境部署（Production Deployment）时，准确提示应部署至正确的生产分支（Production Branch）。

- 对于失败的部署，部署详情页上的“重新部署”（Redeploy）按钮现始终可见，无论该部署是否通过 Git 触发。

- [项目创建流程](https://vercel.com/new) 各页面现将始终在视口顶部固定显示，不再因页面内容高度变化而发生位置偏移。

- 项目设置中，此前用于提示“环境变量现已支持在独立页面中配置”的横幅通知，现已对所有用户移除。

- 点击“重新部署”（Redeploy）或“提升至生产环境”（Promote to Production）按钮后弹出的确认模态框，现能稳定、准确地显示相关信息。

- Clicking "Promote to Production" will now cause helpful notifications to be rendered on the bottom right of the screen.

- 点击“提升至生产环境”（Promote to Production）按钮后，屏幕右下角将显示有用的提示通知。

- Losing your connection to the internet will no longer cause the Vercel Dashboard to crash. Instead, a notification will be rendered.

- 断开互联网连接将不再导致 Vercel 控制台崩溃；取而代之的是，系统会显示一条提示通知。

- Clicking the "Back" button in the [Project Creation Flow](https://vercel.com/new) now works reliably.

- 在 [项目创建流程](https://vercel.com/new) 中点击“返回”（Back）按钮现在可稳定工作。

- Switching to a different Personal Account or Team now results in a good transition, regardless of which page you're looking at.

- 切换至其他个人账户（Personal Account）或团队（Team）时，无论当前位于哪个页面，界面过渡都将更加平滑自然。

- Queued Deployments will no longer render on the Deployment View that they're waiting for the Build to finish. Instead, they will now render that they're waiting for the Build to start.

- 排队中的部署（Queued Deployments）在部署视图（Deployment View）中将不再显示为“正在等待构建完成”，而是准确显示为“正在等待构建开始”。

- It's not longer possible to redeploy a Production Deployment if a more recent one has been created. This ensures the most recent Production Deployment is never accidentally overwritten with old source code (only possible via explicit "Promote to Production").

- 若已有更新的生产环境部署（Production Deployment）存在，则无法重新部署旧的生产环境部署。此举可确保最新的生产环境部署绝不会被意外覆盖为旧版源代码（仅可通过显式的“提升至生产环境”操作实现）。

- Whenever a Deployment is automatically canceled by the [Ignored Build Step](https://vercel.com/docs/platform/projects#ignored-build-step) feature, a helpful message is now rendered on the Deployment View.

- 每当部署因 [忽略构建步骤](https://vercel.com/docs/platform/projects#ignored-build-step)（Ignored Build Step）功能而被自动取消时，部署视图（Deployment View）中将显示一条清晰的提示信息。

- The Deployment View will now render a helpful message whenever a Serverless Function exceeds the maximum unzipped Lambda size.

- 当无服务器函数（Serverless Function）解压后的大小超出 Lambda 允许的最大尺寸限制时，部署视图（Deployment View）将显示相应的提示信息。

- The button for removing Environment Variables in the [Project Creation Flow](https://vercel.com/new) can be clicked again.

- 在 [项目创建流程](https://vercel.com/new) 中，用于删除环境变量（Environment Variables）的按钮现已恢复可点击状态。

- Build Logs rendered on the Deployment View are now automatically cut off at 2,000 lines and a helpful message is displayed. This is to prevent the user's browser from running out of memory.

- 部署视图（Deployment View）中渲染的构建日志（Build Logs）现将自动截断至 2,000 行，并显示相应提示信息，以防止用户浏览器因内存耗尽而卡顿或崩溃。

- 在手机或平板电脑（小视口）上，通过 [项目创建流程](https://vercel.com/new) 创建部署时，构建日志（Build Logs）现在可稳定渲染。

## Deployments

## 部署

- 当请求中 `Range` 请求头包含不支持的范围值时，系统现在将返回一条友好的错误提示（而非“内部服务器错误”）。

- 在 `vercel.json` 中使用 [functions 属性](https://vercel.com/docs/configuration#project/functions) 时，现可稳定支持 Next.js 的 Serverless Functions（位于 `pages/api` 目录内）。

- 当部署中某路径未找到而触发 404 页面时，页面不再显示提示“该域名可供使用”的横幅。

- 点击公开部署页面上的 Vercel 标志，将不再尝试跳转至该部署所有者的控制台；而是直接展示当前已登录用户的控制台。

- 在 `vercel.json` 中配合 Next.js 使用 [functions 属性](https://vercel.com/docs/configuration#project/functions) 时，若配置了框架不支持的子属性，系统现在会显示相应警告。

## Documentation

## 文档

- [部署按钮（Deploy Button）](https://vercel.com/docs/more/deploy-button) 页面中的 URL 字段现已支持在其中嵌入查询字符串参数（query string parameters）。

- 在“平台（Platform）”分类下新增了一篇 [登录连接（Login Connections）页面](https://vercel.com/docs/platform/login-connections)。

- The publicly available Git repository for the documentation was archived and moved to an internal location to allow for a better Engineering workflow.

- 文档的公开 Git 仓库已被归档，并迁移至内部位置，以优化工程工作流。

- New documentation sections about the [Build Cache](https://vercel.com/docs/build-step#caching) and [Build Image](https://vercel.com/docs/build-step#build-image) were added.

- 新增了关于 [构建缓存（Build Cache）](https://vercel.com/docs/build-step#caching) 和 [构建镜像（Build Image）](https://vercel.com/docs/build-step#build-image) 的文档章节。

- For the [routes property](https://vercel.com/docs/configuration#project/routes), the documentation now outlines that the new routing properties (`rewrites`, `redirects`, `headers`, `cleanUrls`, `trailingSlash`) should be used instead.

- 针对 [routes 属性](https://vercel.com/docs/configuration#project/routes)，文档现已明确指出：应改用新的路由配置项（`rewrites`、`redirects`、`headers`、`cleanUrls`、`trailingSlash`）。

- The [Deploy Button](https://vercel.com/docs/more/deploy-button) page now contains new "Demo" sections, which talk about how to display a preview of a Git repository in the Project Creation Flow.

- [部署按钮（Deploy Button）](https://vercel.com/docs/more/deploy-button) 页面新增了“演示（Demo）”章节，介绍如何在项目创建流程中展示 Git 仓库的预览效果。

- For the [functions property](https://vercel.com/docs/configuration#project/functions), the documentation now clearly outlines which sub properties can be used in conjunction with the Next.js framework.

- 针对 [functions 属性](https://vercel.com/docs/configuration#project/functions)，文档现已清晰说明哪些子属性可与 Next.js 框架配合使用。

- A new documentation section about [Concurrent Builds](https://vercel.com/docs/platform/users-and-teams#concurrent-builds) was added.

- 新增了关于 [并发构建（Concurrent Builds）](https://vercel.com/docs/platform/users-and-teams#concurrent-builds) 的文档章节。

## Integrations

## 集成

- All Git Integrations (for [GitHub](https://vercel.com/github), [GitLab](https://vercel.com/gitlab) and [Bitbucket](https://vercel.com/bitbucket)) were completely revamped from the ground up to provide maximum reliability across all areas of the Git workflow.

- 所有 Git 集成（包括 [GitHub](https://vercel.com/github)、[GitLab](https://vercel.com/gitlab) 和 [Bitbucket](https://vercel.com/bitbucket)）均经过全面重构，旨在全面提升 Git 工作流各环节的可靠性。

- Redeploying a Deployment or promoting it to Production will now update the status of the commit that it is associated with on the Git provider.

- 重新部署某个部署（Deployment）或将其提升至生产环境（Production）时，现会同步更新该部署所关联的提交（commit）在对应 Git 平台上的状态。

- Deployments that need to be authorized by a Team Member because they were created in a pull request that originated on a fork (and the Deployment will receive Secrets) will now cause a comment to be rendered on the pull request.

- 对于因源自 Fork 的拉取请求（Pull Request）而创建、且需团队成员授权（因该部署将访问密钥 Secret）的部署，系统现会在该拉取请求中自动添加一条评论。

- 在部署到 Vercel 的 Git 仓库的 Pull Request 上留下的评论，将不再为已完成的部署显示 “In Progress”（进行中）状态。

- 部署钩子（Deploy Hooks）将不再为连接到同一 Git 仓库的所有 Vercel 项目触发部署，而仅在其所配置的特定项目上触发。

- 通过部署钩子创建的部署，若非由该特定部署钩子最新创建的部署，则现在将自动被取消。

- 当推送提交时请求访问 Vercel 团队，其响应速度现已提升约 1.5 秒，因移除了此前人为添加的延迟。

- 每当“忽略构建步骤”（Ignored Build Step）指令导致部署被取消时，Git 集成现在会在提交状态中显示一条清晰明确的提示信息。

- 安装 Git 集成时，用户现在将被重定向至 [vercel.com](http://vercel.com/) 而非 [zeit.co](http://zeit.co/) 以完成安装流程。

## Command-Line  
## 命令行工具

- 若所使用的 `tsconfig.json` 文件中包含注释（例如执行 `tsc --init` 时生成的文件即属此类），`vercel dev` 命令将不再因此失败。

## Other  
## 其他更新

- 设计系统（[design system](https://vercel.com/design/entity)）中新增了一个 Entity 组件，支持以美观、一致的方式渲染项目列表。

- Deleting a Team will no longer cause emails about failed payments to be sent to its owners if the Team was deleted during the trial phase.

- 在试用期期间删除团队后，将不再向该团队所有者发送关于付款失败的邮件。

- Whenever a signup is deemed to potentially be malicious, the user is now required to verify their phone number via SMS before entering Vercel.

- 每当注册行为被判定为可能存在恶意时，用户现在必须通过短信验证其手机号码，方可进入 Vercel。

- A bug with the Billing system was resolved that caused some Teams to not receive a notification on their Git repository about adding commit authors to their Vercel Team.

- 计费系统中一个导致部分团队未在其 Git 仓库收到“添加提交作者至 Vercel 团队”通知的 Bug 已修复。

- Personal Accounts that are deleted are now always reliably pruned from our system after the 4 day recovery period. Previously, a special set of them got stuck.

- 已删除的个人账户现可在 4 天恢复期结束后始终可靠地从我们的系统中彻底清理。此前，其中一部分账户会卡在清理流程中。

- The email that is sent after a Personal Account requested to be deleted now correctly considers the new 4 day recovery period (instead of 48 hours).

- 个人账户申请删除后所发送的邮件，现已正确采用新的 4 天恢复期（而非原先的 48 小时）。