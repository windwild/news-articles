---
title: "Improvements to command line logs - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/improvements-to-command-line-logs"
date: "2024-07-24"
scraped_at: "2026-03-02T09:43:33.439087308+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jul 24, 2024

2024年7月24日

![](images/improvements-to-command-line-logs-vercel/img_001.jpg)![](images/improvements-to-command-line-logs-vercel/img_002.jpg)

Vercel CLI v35 introduces new commands to access of deployment and runtime logs:

Vercel CLI v35 引入了若干新命令，用于访问部署日志和运行时日志：

- `vercel deploy --logs` deploys and shows [build logs](https://vercel.com/docs/cli/deploy)

- `vercel deploy --logs` 执行部署并显示 [构建日志](https://vercel.com/docs/cli/deploy)

- `vercel inspect --logs` shows [build logs](https://vercel.com/docs/cli/inspect) for an existing deployment

- `vercel inspect --logs` 显示已有部署的 [构建日志](https://vercel.com/docs/cli/inspect)

- `vercel logs` now follows [runtime logs](https://vercel.com/docs/cli/logs) of an existing deployment

- `vercel logs` 现在可实时跟踪已有部署的 [运行时日志](https://vercel.com/docs/cli/logs)

You can now use the `--json` option to stream logs as JSON. This makes it easier to parse and filter logs using tools like [jq](https://jqlang.github.io/jq/).

您现在可以使用 `--json` 选项以 JSON 格式流式输出日志。这使得借助 [jq](https://jqlang.github.io/jq/) 等工具解析和过滤日志更加便捷。

```bash
vercel logs --json | jq 'select(.level == "warning")'
```

```bash
vercel logs --json | jq 'select(.level == "warning")'
```

Using the Vercel CLI with jq to filter for warning logs

使用 Vercel CLI 配合 jq 筛选警告（warning）级别日志

To use these features, update to the latest version of the Vercel CLI:

如需使用上述功能，请将 Vercel CLI 更新至最新版本：

```bash
pnpm add -g vercel
```

使用 pnpm 包管理器全局安装 Vercel CLI。