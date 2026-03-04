---
title: "Vercel for Bitbucket - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/bitbucket"
date: "2019-11-27"
scraped_at: "2026-03-02T10:07:20.945066842+00:00"
language: "en-zh"
translated: true
description: "Push code to Bitbucket and automatically deploy with Vercel."
---
{% raw %}

Nov 27, 2019

2019 年 11 月 27 日

[Bitbucket](http://bitbucket.com/) 因其作为项目规划、代码协作、测试与部署的中心平台而广受团队青睐——尤其在与 Jira 和 Trello 结合使用时。

**今天，我们非常自豪地宣布推出原生 Bitbucket 集成产品：[Vercel for Bitbucket](https://zeit.co/bitbucket)。**

Vercel 让您轻松构建与部署代码——无论您需要的是静态网站、无服务器函数（Serverless Functions），还是二者的组合。若您已在开发流程中使用 Bitbucket，现在即可享受 **开箱即用的自动部署能力，内置 CI/CD、DNS 与 TLS 支持**。

![推送至 Bitbucket 的提交将由 Vercel 自动构建并部署。](images/vercel-for-bitbucket-vercel/img_001.jpg)推送至 Bitbucket 的提交将由 Vercel 自动构建并部署。

## 内置预览部署（Preview Deployments）

借助功能分支（feature branch）的预览部署，您的团队可全面测试各项变更，从而在迭代与合并时获得更高信心。

我们的 Bitbucket 集成无需任何配置，即可将 [预览部署](https://vercel.com/docs/v2/platform/deployments/#preview) 直接引入您的工作流。

## 启用自动部署

通过 Bitbucket 设置自动部署至 Vercel 极其简单：

1. 使用 **一键连接** 接入 Bitbucket，并将您的项目与其关联。

2. 每次向您的项目执行 `git push`，都将自动触发一次部署，生成一个预览 URL（Preview URL）。

3. 当您将代码合并至 [默认分支](https://confluence.atlassian.com/bitbucket/branching-a-repository-223217999.html#BranchingaRepository-Branchtypes)（通常为 `master`）时，您的 [生产环境域名](https://vercel.com/docs/v2/platform/deployments/#production) 将被自动更新。

当默认分支上的更改被撤销时，生产环境域名将执行 **即时回滚（instant rollback）** —— 即自动切换回上一个已发布的生产环境部署。

## 连接 Bitbucket

配置 Bitbucket 集成的第一步是 **“连接 Bitbucket”**。该操作将使集成对您所有的 Bitbucket 项目生效；此外，您还可选择 **通过 Bitbucket 登录 Vercel**。

要开始操作，请访问您个人或团队的 **Vercel** 账户下的 [账户页面](https://zeit.co/account)，进入 **Git 集成（Git Integrations）** 标签页，然后点击 **“Connect with Bitbucket”（连接 Bitbucket）** 按钮。

![将您的个人或团队账户与 Bitbucket 连接。](images/vercel-for-bitbucket-vercel/img_002.jpg)  
将您的个人或团队账户与 Bitbucket 连接。

当 Bitbucket 请求授权时，请点击 **“Grant Access”（授予访问权限）**。

![点击 “Grant Access”（授予访问权限）以完成 Bitbucket 连接流程。](images/vercel-for-bitbucket-vercel/img_003.jpg)  
点击 **“Grant Access”（授予访问权限）** 以完成 Bitbucket 连接流程。

Once you authorize Bitbucket, it redirects you back to Vercel. This completes the account connection process, and you automatically activate the ability to **Continue with Bitbucket** the next time.

授权 Bitbucket 后，系统会将您重定向回 Vercel。至此，账户连接流程即告完成；下次您将自动启用 **使用 Bitbucket 继续登录** 的功能。

![Once you connect Bitbucket, you also activate the ability to Log In to Vercel with Bitbucket.](images/vercel-for-bitbucket-vercel/img_004.jpg)  
![连接 Bitbucket 后，您同时也启用了使用 Bitbucket 登录 Vercel 的功能。](images/vercel-for-bitbucket-vercel/img_004.jpg)  
Once you connect Bitbucket, you also activate the ability to Log In to Vercel with Bitbucket.

连接 Bitbucket 后，您同时也启用了使用 Bitbucket 登录 Vercel 的功能。

## Link Projects

## 关联项目

After your Bitbucket account is connected through the **Vercel** [accounts page](https://zeit.co/account), you can set up automatic deployments for a Bitbucket project by linking it to Vercel, with the help of a dropdown.

在通过 **Vercel** [账户页面](https://zeit.co/account) 完成 Bitbucket 账户连接后，您可通过下拉菜单将 Bitbucket 项目与 Vercel 关联，从而配置自动部署。

![Once linked, pushes made to the Bitbucket project will be automatically deployed with ZEIT Now.](images/vercel-for-bitbucket-vercel/img_005.jpg)  
![关联完成后，向该 Bitbucket 项目推送（push）的代码将通过 ZEIT Now 自动部署。](images/vercel-for-bitbucket-vercel/img_005.jpg)  
Once linked, pushes made to the Bitbucket project will be automatically deployed with ZEIT Now.

关联完成后，向该 Bitbucket 项目推送（push）的代码将通过 ZEIT Now 自动部署。

Select the Bitbucket project you would like to link to from the provided dropdown. Once linked, the Bitbucket project is set up for automatic Vercel deployments.

请从提供的下拉菜单中选择您希望关联的 Bitbucket 项目。关联成功后，该项目即已配置为支持 Vercel 自动部署。

## What Happens After Linking

## 关联后会发生什么

For every `git push` made, we build and deploy the latest commit with Vercel. The deployment is guided by the project framework using [zero-config](https://zeit.co/blog/zero-config) or a [`vercel.json` file](https://zeit.co/docs/v2/deployments/configuration).

每次执行 `git push` 操作时，Vercel 都会构建并部署最新的提交版本。部署过程由项目所采用的框架指导，可借助 [零配置（zero-config）](https://zeit.co/blog/zero-config) 功能，或通过 [`vercel.json` 配置文件](https://zeit.co/docs/v2/deployments/configuration) 实现。

**By default, we deploy every push**. This means that every `git push` made to a Pull Request branch is deployed — allowing collaborators to preview changes before they're merged and deployed to production.

**默认情况下，每次推送（push）均会触发部署**。这意味着，向 Pull Request 分支发起的每一次 `git push` 都将被部署——使协作者能够在变更合并并发布至生产环境前，先行预览效果。

Within a Pull Request, if Vercel is still building a commit from a previous push, **that build is canceled in favor of the most recently pushed commit**. This allows collaborators the quickest access to fresh changes.

在拉取请求（Pull Request）中，如果 Vercel 仍在构建上一次推送（push）所对应的提交，**该构建将被取消，转而构建最新推送的提交**。此举可使协作者最快获取最新的代码变更。

## Conclusion

## 结语

Our mission at **Vercel** is to make the cloud accessible to everyone. The [Vercel for Bitbucket](https://zeit.co/bitbucket) integration was one of our most requested features. We are excited about this announcement and hope that it makes your development workflow smoother.

**Vercel** 的使命是让云技术惠及每一个人。[Vercel for Bitbucket](https://zeit.co/bitbucket) 集成是我们收到最多用户请求的功能之一。我们非常激动地宣布这一功能上线，并希望它能让您的开发工作流更加顺畅。

All of our work is heavily driven by feedback from our users. For feature requests, or to suggest ideas to make our platform and your experience better, please reach out to us [over chat](https://zeit.co/chat) or on [Twitter](https://twitter.com/vercel).

我们的所有工作都高度依赖用户的反馈。如果您有任何功能需求，或希望就如何优化平台及提升您的使用体验提出建议，欢迎通过 [在线聊天](https://zeit.co/chat) 或 [Twitter](https://twitter.com/vercel) 与我们联系。
{% endraw %}
