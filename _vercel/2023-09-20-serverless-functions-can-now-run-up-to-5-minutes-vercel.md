---
title: "Serverless Functions can now run up to 5 minutes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/serverless-functions-can-now-run-up-to-5-minutes"
date: "2023-09-20"
scraped_at: "2026-03-02T09:50:39.992255909+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

Sep 20, 2023

2023 年 9 月 20 日

![](images/serverless-functions-can-now-run-up-to-5-minutes-vercel/img_001.jpg)![](images/serverless-functions-can-now-run-up-to-5-minutes-vercel/img_002.jpg)

根据您的反馈，我们对 Serverless Functions 做出如下改进：

- Pro 计划用户现在可运行更长时间的函数，**最长可达 5 分钟**。

- Pro 计划用户的函数默认超时时间将于 **10 月 1 日起**调整为 **15 秒**。

这些变更有助于防止因疏忽导致的函数意外调用，除非您已[明确选择启用](https://vercel.com/docs/functions/serverless-functions/runtimes#max-execution-duration)更长的函数执行时长。

自 **10 月 1 日起**，所有新创建的项目默认超时时间均为 15 秒。此外，对于所有尚未运行过超过 15 秒函数的项目，其默认超时时间也将统一调整为 15 秒。

为避免出现意外超时，对于那些已有函数运行时长超过 15 秒（此类请求占比不足总流量的 1%）的项目，**其默认超时时间将保持不变**。

Hobby 和 Enterprise 计划用户的现有默认设置维持不变。

[请参阅我们的文档](https://vercel.com/docs/functions/serverless-functions/runtimes)，了解更多信息。
{% endraw %}
