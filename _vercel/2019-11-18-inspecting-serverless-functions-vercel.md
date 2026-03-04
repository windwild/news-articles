---
title: "Inspecting Serverless Functions - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/functions-tab"
date: "2019-11-18"
scraped_at: "2026-03-02T10:07:23.490962318+00:00"
language: "en-zh"
translated: true
description: " Get insight into your Serverless Functions with the new \"Functions\" dashboard tab."
---

render_with_liquid: false
Nov 18, 2019

2019 年 11 月 18 日

在将静态前端部署到 Vercel 后，部分项目可能会借助 Serverless Functions（无服务器函数）来获取数据。

创建 Serverless Functions 极其简单：只需在项目中添加一个 [API 目录](https://zeit.co/docs/v2/serverless-functions/introduction/) 即可。而今天，借助部署概览页中的全新“Functions”（函数）标签页，您也能以同样便捷的方式检查这些函数。

## Function Details

## 函数详情

构建一款极速 Web 应用，不仅依赖于静态前端，更取决于您的 API 是否精简、是否占用过高的计算资源，以及响应速度是否足够快。

上述所有信息如今均可通过每次部署概览页中新增的“Functions”（函数）标签页轻松获取。

![您 Serverless Functions 的最关键信息，一目了然。](images/inspecting-serverless-functions-vercel/img_001.jpg)您 Serverless Functions 的最关键信息，一目了然。

## Realtime Requests

## 实时请求

在排查 Serverless Functions 行为异常时，我们常常需要实时跟踪其调用过程及由此输出的日志。

借助全新的“Functions”（函数）标签页，这些信息如今仅需单击即可获取。

![A real-time stream of all requests targeting your Serverless Function.](images/inspecting-serverless-functions-vercel/img_002.jpg)  
实时流式显示所有针对您 Serverless Function 的请求。

## Failed Requests

## 失败的请求

Once your Serverless Functions are running in production, it is a vital focus of every developer to ensure they will continue smoothly, without interruption.  

当您的 Serverless Function 投入生产环境运行后，确保其持续、稳定、无中断地运行，是每位开发者的重中之重。

To make this process easier, we now also show Failed Requests right in the UI.  

为简化这一过程，我们现在也在用户界面（UI）中直接展示“失败的请求”。

![A list of all requests that have not succeeded in the past.](images/inspecting-serverless-functions-vercel/img_003.jpg)  
过去所有未成功执行的请求列表。

In this section, all requests from which your Serverless Function has thrown an unexpected error will be stored and displayed for up to 30 days.  

在此部分中，所有因您的 Serverless Function 抛出意外错误而失败的请求，将被保存并展示，最长保留 30 天。

## Conclusion

## 总结

Thanks to the new **Functions** tab on the dashboard, retrieving the most crucial details about your Serverless Functions is now easier than ever.  

得益于仪表板（Dashboard）中新增的 **Functions**（函数）标签页，获取您 Serverless Function 最关键的信息，如今比以往任何时候都更加便捷。

This is just another one of several features we are planning to launch to support advanced use cases of Serverless Functions on Vercel.  

这只是我们计划推出的多项功能之一，旨在更好地支持 Vercel 平台上 Serverless Function 的高级应用场景。

[Let us know what you think](mailto:support@vercel.com) about this change!  

[欢迎就本次更新分享您的想法](mailto:support@vercel.com)！