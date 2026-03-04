---
title: "AI Gateway support for Claude Code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-support-for-claude-code"
date: "2026-01-05"
scraped_at: "2026-03-02T09:23:18.375158139+00:00"
language: "en-zh"
translated: true
description: "Use Vercel AI Gateway from Claude Code via the Anthropic-compatible endpoint, with a URL change and AI Gateway usage and cost tracking."
---
&#123;% raw %}

Jan 5, 2026

2026 年 1 月 5 日

您现在可以通过 [Vercel AI Gateway](https://vercel.com/ai-gateway) 的 Anthropic 兼容 API 端点来使用 Claude Code。

将 Claude Code 请求通过 AI Gateway 进行路由，可集中管理用量与支出、在可观测性平台中查看调用链路（traces），并享受所选模型在不同提供商之间的故障转移（failover）能力。

如果您已登录，请先退出登录，然后设置以下环境变量，以配置 Claude Code 使用 AI Gateway：

```typescript
claude /logout



export ANTHROPIC_BASE_URL="https://ai-gateway.vercel.sh"

export ANTHROPIC_AUTH_TOKEN="your-ai-gateway-api-key"

export ANTHROPIC_API_KEY=""
```

必须将 `ANTHROPIC_API_KEY` 设置为空字符串。Claude Code 会优先检查该环境变量；若其值非空，Claude Code 将直接使用该值，而忽略 `ANTHROPIC_AUTH_TOKEN`。

Start Claude Code. Requests will route through AI Gateway:

启动 Claude Code。请求将通过 AI Gateway 路由：

```typescript
claude
```

```typescript
claude
```

See the [Claude Code documentation](https://vercel.com/docs/ai-gateway/claude-code) for details.

详情请参阅 [Claude Code 文档](https://vercel.com/docs/ai-gateway/claude-code)。
&#123;% endraw %}
