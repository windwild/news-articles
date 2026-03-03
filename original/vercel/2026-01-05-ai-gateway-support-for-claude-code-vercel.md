---
title: "AI Gateway support for Claude Code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-gateway-support-for-claude-code"
date: "2026-01-05"
scraped_at: "2026-03-02T09:23:18.375158139+00:00"
language: "en"
translated: false
description: "Use Vercel AI Gateway from Claude Code via the Anthropic-compatible endpoint, with a URL change and AI Gateway usage and cost tracking."
---




Jan 5, 2026

You can now use Claude Code through [Vercel AI Gateway](https://vercel.com/ai-gateway) via its Anthropic-compatible API endpoint.

Route Claude Code requests through AI Gateway to centralize usage and spend, view traces in observability, and benefit from failover between providers for your model of choice.

Log out if you're already logged in, then set these environment variables to configure Claude Code to use AI Gateway:

```typescript
claude /logout



export ANTHROPIC_BASE_URL="https://ai-gateway.vercel.sh"

export ANTHROPIC_AUTH_TOKEN="your-ai-gateway-api-key"

export ANTHROPIC_API_KEY=""
```

Setting `ANTHROPIC_API_KEY` to an empty string is required. Claude Code checks this variable first, and if it's set to a non-empty value, it will use that instead of `ANTHROPIC_AUTH_TOKEN`.

Start Claude Code. Requests will route through AI Gateway:

```typescript
claude
```

See the [Claude Code documentation](https://vercel.com/docs/ai-gateway/claude-code) for details.