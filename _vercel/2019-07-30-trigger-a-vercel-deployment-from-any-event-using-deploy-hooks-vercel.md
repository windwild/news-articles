---
render_with_liquid: false
title: "Trigger a Vercel deployment from any event using Deploy Hooks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-deploy-hooks"
date: "2019-07-30"
scraped_at: "2026-03-02T10:07:36.186510874+00:00"
language: "en-zh"
translated: true
description: "With Deploy Hooks, you can create a deployment based on any event."
---
render_with_liquid: false
render_with_liquid: false

Jul 30, 2019

2019年7月30日

使用任意外部事件触发新部署。

得益于我们一流的 [GitHub](https://zeit.co/github) 和 [GitLab](https://zeit.co/gitlab) 集成，您只需将代码推送到仓库，即可通过 [Vercel](https://zeit.co/home) 自动完成部署。但如果您希望触发部署的条件并非源代码变更，而是其他外部事件（例如内容管理系统（CMS）中的内容更新），该怎么办？

从今天起，您即可借助 **Deploy Hooks（部署钩子）**，基于 **_任意_** 事件触发部署。

![一张示意图：在 Contentful 上配置 Vercel Deploy Hook。该 Deploy Hook 确保每次内容更新时均自动执行构建与部署。](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_001.jpg)一张示意图：在 Contentful 上配置 Vercel Deploy Hook。该 Deploy Hook 确保每次内容更新时均自动执行构建与部署。

## 什么是 Deploy Hook（部署钩子）？

Deploy Hook（部署钩子）是一个接受 POST 请求的 URL，用于触发 Vercel 上的部署任务。

任何支持发起 POST 请求的平台均可触发 Deploy Hook —— 这包括第三方服务（如无头 CMS、定时任务工具 cron），甚至您的命令行终端。

## 静态站点示例：Gatsby + Contentful

为直观展示 Deploy Hook 的用法，我们以广受欢迎的技术组合为例：一个由 [Gatsby](https://gatsbyjs.org/) 构建的静态网站，其内容托管于 [Contentful](https://contentful.com/)。我们将配置该系统，使其在每次 Contentful 中的内容更新时，自动执行构建与部署。

**1\. Set up Boilerplate**

**1. 设置项目脚手架**

Luckily for us, the Contentful community already has a [Gatsby + Contentful](https://github.com/contentful-userland/gatsby-contentful-starter) boilerplate available.

幸运的是，Contentful 社区已提供了一个现成的 [Gatsby + Contentful](https://github.com/contentful-userland/gatsby-contentful-starter) 项目脚手架。

```bash
gatsby new contentful-starter https://github.com/contentful-userland/gatsby-contentful-starter
```

```bash
gatsby new contentful-starter https://github.com/contentful-userland/gatsby-contentful-starter
```

The boilerplate is a beautiful and fast blog demo powered by Gatsby and Contentful.

该脚手架是一个由 Gatsby 和 Contentful 驱动的、美观且高性能的博客演示项目。

**2\. Sign up for Contentful and Obtain Tokens**

**2. 注册 Contentful 账户并获取访问令牌**

Once signed up, we run the `setup` script highlighted on [Contentful](https://contentful.com/)'s onboarding page.

注册完成后，我们在 [Contentful](https://contentful.com/) 的新手引导页面中运行所标注的 `setup` 脚本。

![`npm run setup` takes care of setting up the environment variables that Gatsby needs from Contentful.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_002.jpg)\`npm run setup\` takes care of setting up the environment variables that Gatsby needs from Contentful.

![`npm run setup` 会自动配置 Gatsby 所需的、来自 Contentful 的环境变量。](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_002.jpg)`npm run setup` 会自动配置 Gatsby 所需的、来自 Contentful 的环境变量。

Next, we set the `CONTENTFUL_SPACE_ID` and `CONTENTFUL_ACCESS_TOKEN` [environment variables](https://zeit.co/docs/v2/build-step#using-environment-variables-and-secrets).

接下来，我们设置 `CONTENTFUL_SPACE_ID` 和 `CONTENTFUL_ACCESS_TOKEN` 这两个[环境变量](https://zeit.co/docs/v2/build-step#using-environment-variables-and-secrets)。

**4\. Create Deploy Hook and Specify on Contentful**

**4. 创建部署钩子（Deploy Hook）并在 Contentful 中配置**

We want our Gatsby site to re-build and deploy whenever there is an update in Contentful. Therefore, we create a Deploy Hook pointing to the git `master` branch, and specify the Deploy Hook as a **webhook** within Contentful.

我们希望每当 Contentful 中的内容发生更新时，Gatsby 站点都能自动重新构建并部署。因此，我们创建一个指向 Git `master` 分支的部署钩子（Deploy Hook），并在 Contentful 中将其配置为一个 **Webhook**。

It's easy to create a Deploy Hook for any Vercel project — the [docs](https://zeit.co/docs/v2/advanced/deploy-hooks/) visually explain how.

为任意 Vercel 项目创建 Deploy Hook 非常简单——[官方文档](https://zeit.co/docs/v2/advanced/deploy-hooks/)以图文形式清晰说明了具体操作方法。

![Once the webhook is created, our setup is complete.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_003.jpg)Once the webhook is created, our setup is complete.

![Webhook 创建完成后，我们的配置即告完成。](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_003.jpg)Webhook 创建完成后，我们的配置即告完成。

## Trying it Out!

## 实际体验一下！

When we update content via Contentful, a new static Gatsby build is created. After a brief wait, our site is deployed and the updated content is live for us to see!

当我们通过 Contentful 更新内容时，系统会自动生成一个新的静态 Gatsby 构建版本。稍作等待后，网站即完成部署，更新后的内容即可实时呈现！

Gatsby + Contentful + Vercel Deploy Hooks in action

Gatsby + Contentful + Vercel Deploy Hooks 协同工作示例

## Reliability and Robustness

## 可靠性与健壮性

In order to create a robust system, we have kept several checks in place:

为构建一个高可靠、高健壮的系统，我们已内置多项保障机制：

- **自动防抖构建（Automatically debounced builds）**. You can POST to the Deploy Hook multiple times, and our systems will intelligently discard duplicate deployments.

- **自动防抖构建**：您可多次向 Deploy Hook 发送 POST 请求，系统将智能识别并丢弃重复的部署任务。

- **Straightforward revoking**. If you suspect that you may have accidentally leaked your Deploy Hook, you can easily swap the existing hook for a new one within your project settings.

- **便捷的密钥撤销机制**：若您怀疑 Deploy Hook 地址可能已被意外泄露，可直接在项目设置中快速将其替换为全新的 Hook。

- **Clear timeline of deployment activity**. Under the [Events](https://zeit.co/dashboard/events) tab, you can clearly identify deployments created via hooks.

- **清晰的部署活动时间线**：在 [Events（事件）](https://zeit.co/dashboard/events) 标签页中，您可一目了然地识别出所有通过 Deploy Hook 触发的部署记录。

![The Events timeline clearly showcases all the deployments, including their sources.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_004.jpg)  
事件时间线清晰地展示了所有部署记录，包括其来源。

## Conclusion

## 结论

With Deploy Hooks, you can now deploy based on _any_ event.

借助部署钩子（Deploy Hooks），您现在可以根据**任意事件**触发部署。

In this post, we explored how Deploy Hooks can help you **automatically re-build and deploy** a static site based on content updates.

本文中，我们探讨了部署钩子如何帮助您基于内容更新**自动重建并部署**静态网站。

How do you intend on using Deploy Hooks? Let us know via [Twitter](https://twitter.com/vercel) or [Chat](https://zeit.co/contact)!

您计划如何使用部署钩子？欢迎通过 [Twitter](https://twitter.com/vercel) 或 [聊天支持](https://zeit.co/contact) 告诉我们！