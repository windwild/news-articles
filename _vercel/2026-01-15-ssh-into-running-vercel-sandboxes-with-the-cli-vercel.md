---
title: "SSH into running Vercel Sandboxes with the CLI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ssh-into-running-sandboxes-with-the-sandbox-cli"
date: "2026-01-15"
scraped_at: "2026-03-02T09:22:41.712047142+00:00"
language: "en-zh"
translated: true
description: "SSH into running Sandboxes using the Vercel Sandbox CLI. Open secure, interactive shell sessions, with timeouts automatically extended in 5-minute increments for up to 5 hours."
---
{% raw %}

Jan 15, 2026

2026 年 1 月 15 日

您现在可以通过 [Vercel Sandbox CLI](https://vercel.com/docs/vercel-sandbox/cli-reference) 打开安全、交互式的 Shell 会话，连接至正在运行的 Sandbox。

```bash
pnpm i -g sandbox

sandbox login

sandbox create # 如果您尚无正在运行的 Sandbox 可用于 SSH 连接

sandbox ssh <sandbox-id>
```

注意：在您保持连接期间，Sandbox 的超时时间将自动以 5 分钟为单位延长，以避免意外断连，最长可延至 [5 小时](https://vercel.com/docs/vercel-sandbox/pricing#maximum-runtime-duration)。

更多详情，请参阅 [Sandbox CLI 文档](https://vercel.com/docs/vercel-sandbox/cli-reference#sandbox-ssh)。
{% endraw %}
