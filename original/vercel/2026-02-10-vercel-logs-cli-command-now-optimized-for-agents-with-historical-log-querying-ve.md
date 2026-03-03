---
title: "vercel logs CLI command now optimized for agents with historical log querying - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log"
date: "2026-02-10"
scraped_at: "2026-03-02T09:21:33.763495198+00:00"
language: "en"
translated: false
description: "The vercel logs CLI command has been improved to enable more powerful querying capabilities, and optimized for use by agents."
---




Feb 10, 2026

The `vercel logs` command has been rebuilt with more powerful querying capabilities, designed with agent workflows in mind. You can now query historical logs across your projects and filter by specific criteria, such as project, deploymentID, requestID, and arbitrary strings, to find exactly what you need.

![](images/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log-querying-ve/img_001.jpg)![](images/vercel-logs-cli-command-now-optimized-for-agents-with-historical-log-querying-ve/img_002.jpg)

The updated command uses git context by default, automatically scoping logs to your current repository when run from a project directory. This makes it easy to debug issues during development without manually specifying project details.

Whether you're debugging a production issue or building automated monitoring workflows, the enhanced filtering gives you precise control over log retrieval across your Vercel projects.

[Learn about Vercel CLI and `vercel logs` command](https://vercel.com/docs/cli/logs).