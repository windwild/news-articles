---
title: "Claude Code Max via AI Gateway, available now for Claude Code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-code-max-via-ai-gateway-available-now-for-claude-code"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:18.112460826+00:00"
language: "en"
translated: false
description: "You can use your Claude Code Max subscription through Vercel's AI Gateway. This lets you leverage your existing subscription while gaining centralized observability, usage tracking, and monitoring cap..."
---




Jan 26, 2026

[AI Gateway](https://vercel.com/ai-gateway) now supports the Claude Code Max subscription for the Claude Code CLI. This allows developers to use their existing subscription on Anthropic models with no additional cost while getting unified observability, usage tracking, and monitoring through Vercel’s platform.

### Setup

Set up your environment variables in your shell configuration file (`~/.zshrc` or `~/.bashrc`)

```bash
export ANTHROPIC_BASE_URL="https://ai-gateway.vercel.sh"

export ANTHROPIC_CUSTOM_HEADERS="x-ai-gateway-api-key: Bearer your-ai-gateway-api-key"
```

Replace `your-ai-gateway-api-key` with your actual AI Gateway API key.

### Start Claude Code

```bash
claude
```

### Log in with your Claude subscription

If you're not already logged in, Claude Code will prompt you to authenticate. Choose **Option 1 - Claude account with subscription** and log in with your Anthropic account.

If you encounter issues, try logging out with `claude /logout` and logging in again.

Your Claude Code requests now route through AI Gateway, giving you full visibility into usage patterns and costs while using your Max subscription.

### How it works

When you configure Claude Code to use AI Gateway, Claude Code continues to authenticate with Anthropic. It sends its `Authorization` header and AI Gateway acts as either a passthrough proxy to Anthropic or, when it needs to fall back, a router to other providers.

Since the `Authorization` header is reserved for Claude subscription credentials, AI Gateway uses a separate header `x-ai-gateway-api-key` for its own authentication. This allows both auth mechanisms to coexist.

Read more about how to configure Claude Code Max with AI Gateway in the [docs](https://vercel.com/docs/ai-gateway/coding-agents/claude-code#with-claude-code-max).