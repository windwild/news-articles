---
title: "Visualize Team Usage With Sophisticated Usage Dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/sophisticated-usage-dashboard"
date: "2021-02-23"
scraped_at: "2026-03-02T10:05:10.915643013+00:00"
language: "en-zh"
translated: true
description: "Learn more about how Vercel's latest feature will give access to usage information so your Team can optimize your builds."
---
{% raw %}

Feb 23, 2021

2021 年 2 月 23 日

今天，我们宣布对 Pro 和 Enterprise 计划的开发者及团队接收用量指标（usage metrics）的方式进行了一项改进。

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_001.jpg)

这一专属的「用量概览」（Usage overview）界面以可视化方式呈现团队的用量数据，帮助您更清晰地掌握整个团队的资源使用情况——细化至具体项目及 Serverless Functions。

该用量概览分为三大核心类别，分别展示团队各项目的用量指标与自动化洞察：网络（Networking）、函数（Functions）和构建（Build）。

## Networking

## 网络

在 [带宽（Bandwidth）](https://vercel.com/docs/platform/usage#bandwidth) 区域中，我们提供您所接收的流量（入站流量）与您的 Serverless Functions 及边缘网络（Edge Network）响应发送给客户的流量（出站流量）之间的对比分析。

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_002.jpg)

这有助于您判断 Serverless Functions 是否正在向其他位置大量发送数据（或从其他位置检索数据），并据此在必要时做出相应决策。

在 [请求数（Requests）](https://vercel.com/docs/platform/usage#requests) 区域中，您将看到命中缓存的请求量与未命中缓存的请求量之对比。

This usage dashboard makes it easy to see how much of your traffic is cached. The more that is cached, the faster the site. The faster the site, the more delighted your user will be. For more information, read our documentation on [Edge Caching](https://vercel.com/docs/serverless-functions/edge-caching).

此用量仪表板可让您轻松了解您的流量中有多少被缓存。缓存得越多，网站加载速度就越快；网站越快，用户就越满意。如需更多信息，请参阅我们关于 [边缘缓存（Edge Caching）](https://vercel.com/docs/serverless-functions/edge-caching) 的文档。

The goal is stay on top of any networking issues that might come up and keep your visitors and any potential customers happy. Having this information at your fingertips will facilitate this process.

目标是及时发现并应对可能出现的任何网络问题，确保访客及潜在客户始终拥有良好体验。随时掌握这些信息，将极大促进这一目标的实现。

## Functions

## 函数（Functions）

There are two sections in the [Functions](https://vercel.com/docs/platform/usage#functions) category that will help you gain insight into how your Serverless Functions are performing.

[函数（Functions）](https://vercel.com/docs/platform/usage#functions) 类别下包含两个板块，助您深入了解无服务器函数（Serverless Functions）的实际运行表现。

The Invocations and Executions sections will take a look at how many times a site’s Serverless Functions have been invoked and the time it takes for those Serverless Functions to complete.

“调用次数（Invocations）”与“执行耗时（Executions）”板块分别统计网站无服务器函数被调用的总次数，以及这些函数完成执行所耗费的时间。

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_003.jpg)

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_003.jpg)

Here you gain insight into two very important metrics as seen in the image above: "Errored" and "Timeout". With "Errored", you can see how many requests to your Serverless Functions have failed and how long they ran before they failed. "Timeout" is a tally of how many times your Serverless Function hit its [execution timeout](https://vercel.com/docs/serverless-functions/introduction#execution-timeout).

上图展示了两个关键指标：“出错（Errored）”与“超时（Timeout）”。在“出错”指标中，您可查看发送至无服务器函数的请求中有多少次失败，以及这些失败请求在终止前已运行了多长时间；“超时”则统计您的无服务器函数触发 [执行超时（execution timeout）](https://vercel.com/docs/serverless-functions/introduction#execution-timeout) 的次数。

The Throttled section will keep track of the number of times a function has been throttled due to concurrency limits being hit. This is where Vercel tried to scale your Serverless Function, but your site received so much traffic, that your deployment couldn't create more functions.

“限流（Throttled）”板块将记录因达到并发限制而被限流的函数调用次数。这种情况发生在 Vercel 尝试对您的无服务器函数进行自动扩缩容时，由于站点流量过大，当前部署无法再创建更多函数实例。

These visualizations will inform workflow so that you can get these numbers can be as close to zero as possible.

这些可视化图表将为您的工作流程提供数据支撑，助力您将上述各项数值尽可能降至零。

## Builds

## 构建（Builds）

In the [Builds](https://vercel.com/docs/platform/usage#builds) section, gain insight into how long deployments have been queued, how long it took to build, and keep track of the number of builds a project has had.

在 [构建（Builds）](https://vercel.com/docs/platform/usage#builds) 部分，您可以了解部署排队时长、构建耗时，并跟踪项目已完成的构建次数。

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_004.jpg)

The goal is to optimize your builds so that they take as little time as possible. If your build has been queued for awhile, [upgrade your plan](https://vercel.com/pricing) to include more concurrent builds to make time-to-production faster.

我们的目标是优化构建流程，使其耗时尽可能缩短。如果您的构建长时间处于排队状态，可[升级您的套餐](https://vercel.com/pricing)，以支持更多并发构建，从而加快上线（time-to-production）速度。

## **What Does This Mean For My Team?**

## **这对我的团队意味着什么？**

Prior to this release, CSVs had to be downloaded and visualized manually, making the process of optimizing a site more cumbersome.

在此版本发布之前，用户需手动下载 CSV 文件并自行可视化，导致网站优化流程更加繁琐。

The new Usage overview will make it easier for you to make more informed business decisions because a visualization of all the usage data made available all in one spot.

全新的“用量概览（Usage overview）”将帮助您更便捷地做出更明智的业务决策，因为所有用量数据均已集中呈现并实现可视化。

Based on the data coming in, the Usage overview can also determine if there are actionable recommendations that would improve the site overall. These recommendations can be found in each individual section of the dashboard under **Insights**.

基于实时传入的数据，“用量概览”还可识别出切实可行的优化建议，以全面提升网站性能。这些建议可在仪表板各独立板块下的 **洞察（Insights）** 区域中查看。

![](images/visualize-team-usage-with-sophisticated-usage-dashboard-vercel/img_005.jpg)

The Usage overview is enabled by default and is available for Pro and Enterprise plans. If the account is a legacy Team plan, a prompt will open to upgrade to one of Vercel’s newer tiered plans to use this feature.

“用量概览”功能默认启用，适用于 Pro 与 Enterprise 套餐。若您的账户仍为旧版 Team 套餐，则系统将弹出提示，引导您升级至 Vercel 当前推出的任一新版分级套餐，以使用该功能。

We hope this will make it easier to visualize usage, gain insight from those visualizations, and optimize your builds based on that data.

我们希望这一功能能让您更轻松地可视化用量数据、从可视化结果中获取深度洞察，并基于这些数据持续优化构建流程。
{% endraw %}
