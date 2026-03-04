---
title: "vercel logs CLI command now optimized for agents with historical log querying - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log"
date: "2026-02-10"
scraped_at: "2026-03-02T09:21:33.763495198+00:00"
language: "en-zh"
translated: true
description: "The vercel logs CLI command has been improved to enable more powerful querying capabilities, and optimized for use by agents."
---
&#123;% raw %}

Feb 10, 2026

2026 年 2 月 10 日

The `vercel logs` command has been rebuilt with more powerful querying capabilities, designed with agent workflows in mind. You can now query historical logs across your projects and filter by specific criteria, such as project, deploymentID, requestID, and arbitrary strings, to find exactly what you need.

`vercel logs` 命令已全面重构，具备更强大的查询能力，专为代理（agent）工作流场景而设计。您现在可跨项目查询历史日志，并按项目（project）、部署 ID（deploymentID）、请求 ID（requestID）以及任意字符串等条件进行筛选，精准定位所需信息。

![](images/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log-querying-ve/img_001.jpg)![](images/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log-querying-ve/img_002.jpg)

The updated command uses git context by default, automatically scoping logs to your current repository when run from a project directory. This makes it easy to debug issues during development without manually specifying project details.

更新后的命令默认启用 Git 上下文：当您在项目目录中执行该命令时，日志范围将自动限定为当前 Git 仓库。这使得开发阶段的问题调试更加便捷，无需手动指定项目信息。

Whether you're debugging a production issue or building automated monitoring workflows, the enhanced filtering gives you precise control over log retrieval across your Vercel projects.

无论您是在排查生产环境问题，还是构建自动化监控工作流，增强的过滤功能都能让您对 Vercel 各项目的日志检索实现精准控制。

[Learn about Vercel CLI and `vercel logs` command](https://vercel.com/docs/cli/logs)

[了解 Vercel CLI 及 `vercel logs` 命令](https://vercel.com/docs/cli/logs)
&#123;% endraw %}
