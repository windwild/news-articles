---
title: "Refined Logging on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/refined-logging"
date: "2020-03-11"
scraped_at: "2026-03-02T10:07:03.701989414+00:00"
language: "en-zh"
translated: true
description: "The refined UI for Build and Serverless Function logs makes consuming logs a pleasure."
---
&#123;% raw %}

Mar 11, 2020

2020年3月11日

With the launch of [Log Drains](https://zeit.co/blog/log-drains), we made it easy to pipe the invocation logs of your Serverless Functions or Static Files to a log inspection tool like [LogDNA](https://zeit.co/integrations/logdna) or [Datadog](https://zeit.co/integrations/datadog-logs).

随着 [日志导出（Log Drains）](https://zeit.co/blog/log-drains) 功能的发布，您现在可以轻松地将 Serverless 函数或静态文件的调用日志，实时推送至 [LogDNA](https://zeit.co/integrations/logdna) 或 [Datadog](https://zeit.co/integrations/datadog-logs) 等专业日志分析工具。

Handing off this piece of your production workflow to a service dedicated to this purpose allowed us to tighten our focus around what we do best: Plug-and-play realtime logs.

将生产工作流中这一环节交由专精于此的第三方服务处理，使我们得以更加聚焦于自身最擅长的领域：开箱即用的实时日志（Plug-and-play realtime logs）。

## Better Build Logs

## 更优质的构建日志

When creating a new Deployment, you are always presented with detailed logs showcasing how your source code is getting built. Today, we are introducing a new look for them:

在创建新部署（Deployment）时，系统始终会为您呈现详尽的构建日志，清晰展示您的源代码是如何被构建的。今天，我们为这些日志带来了全新界面：

![Inspecting the Build Logs of a Deployment.](images/refined-logging-on-vercel-vercel/img_001.jpg)  
![检查某次部署的构建日志。](images/refined-logging-on-vercel-vercel/img_001.jpg)  
Inspecting the Build Logs of a Deployment.  
检查某次部署的构建日志。

## Better Serverless Function Logs

## 更优质的 Serverless 函数日志

If you want to inspect the logs of your Serverless Functions in a detailed manner, we recommend installing one of our [Log Drain integrations](https://zeit.co/integrations?category=logging).

如需以更细致的方式查看 Serverless 函数的日志，我们推荐您安装我们的任一 [日志导出集成（Log Drain integrations）](https://zeit.co/integrations?category=logging)。

Should you only want to take a quick glance at your Real-time Requests, the refined "Functions" tab will make that process very pleasant:

若您仅需快速浏览实时请求（Real-time Requests），经过优化的“函数（Functions）”标签页将让这一过程变得格外顺畅：

![Inspecting the Realtime Requests of a Deployment.](images/refined-logging-on-vercel-vercel/img_002.jpg)  
![检查某次部署的实时请求。](images/refined-logging-on-vercel-vercel/img_002.jpg)  
Inspecting the Realtime Requests of a Deployment.  
检查某次部署的实时请求。

The same also goes for errors, which are especially important:

![Inspecting the Errors of a Deployment.](images/refined-logging-on-vercel-vercel/img_003.jpg)检查部署的错误。

## Conclusion

## 结论

With the help of the refined Build and Serverless Functions Logs, understanding how your Deployment behaves while building or in production is now possible at a glance.

借助优化后的构建日志和无服务器函数日志，您现在可以一目了然地了解部署在构建阶段或生产环境中的运行状况。

For more complex needs, such as storing logs, we recommend installing a [Log Drain integration](https://zeit.co/integrations?category=logging).

对于更复杂的需求（例如日志存储），我们建议安装 [Log Drain 集成](https://zeit.co/integrations?category=logging)。

[Let us know what you think](https://zeit.co/contact) about this change.

欢迎通过 [联系我们](https://zeit.co/contact) 告诉我们您对这一变更的看法。
&#123;% endraw %}
