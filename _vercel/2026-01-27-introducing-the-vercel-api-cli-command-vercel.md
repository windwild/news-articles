---
title: "Introducing the vercel api CLI command - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-vercel-api-cli-command"
date: "2026-01-27"
scraped_at: "2026-03-02T10:47:55.155426817+00:00"
language: "en-zh"
translated: true
description: "The vercel api command makes an authenticated HTTP request to the Vercel API and prints the response."
---

render_with_liquid: false
Jan 27, 2026

2026 年 1 月 27 日

`vercel@50.5.1` 新增 `api` 命令，使您可通过终端直接访问完整的 Vercel API 套件。

`api` 命令为 AI 智能体提供了一个直接接入点，使其能够通过 CLI 与 Vercel 进行交互。例如 Claude Code 等智能体可直接访问 Vercel，无需额外配置。只要智能体具备环境访问权限及 Vercel CLI 访问权限，便会自动继承用户的访问权限。

使用 `vercel api ls` 列出所有可用 API；使用 `vercel api` 以交互方式构建请求；或使用 `vercel api [endpoint] [options]` 直接发送请求。

请运行 `npx vercel@latest api --help` 开始使用。