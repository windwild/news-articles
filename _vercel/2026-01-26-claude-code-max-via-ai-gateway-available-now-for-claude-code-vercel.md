---
title: "Claude Code Max via AI Gateway, available now for Claude Code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/claude-code-max-via-ai-gateway-available-now-for-claude-code"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:18.112460826+00:00"
language: "en-zh"
translated: true
description: "You can use your Claude Code Max subscription through Vercel's AI Gateway. This lets you leverage your existing subscription while gaining centralized observability, usage tracking, and monitoring cap..."
---

Jan 26, 2026

2026 年 1 月 26 日

[AI Gateway](https://vercel.com/ai-gateway) 现已支持 Claude Code Max 订阅服务，供 Claude Code CLI 使用。开发者可直接使用其已有的 Anthropic 模型订阅，无需额外付费，同时通过 Vercel 平台获得统一的可观测性、用量追踪与监控能力。

### Setup

### 配置环境变量

在您的 Shell 配置文件（`~/.zshrc` 或 `~/.bashrc`）中设置环境变量：

```bash
export ANTHROPIC_BASE_URL="https://ai-gateway.vercel.sh"

export ANTHROPIC_CUSTOM_HEADERS="x-ai-gateway-api-key: Bearer your-ai-gateway-api-key"
```

请将 `your-ai-gateway-api-key` 替换为您实际的 AI Gateway API 密钥。

### Start Claude Code

### 启动 Claude Code

```bash
claude
```

### Log in with your Claude subscription

### 使用您的 Claude 订阅登录

If you're not already logged in, Claude Code will prompt you to authenticate. Choose **Option 1 - Claude account with subscription** and log in with your Anthropic account.

如果您尚未登录，Claude Code 将提示您进行身份验证。请选择 **选项 1 — 带订阅的 Claude 账户**，并使用您的 Anthropic 账户登录。

If you encounter issues, try logging out with `claude /logout` and logging in again.

如遇问题，请尝试运行 `claude /logout` 退出登录，然后重新登录。

Your Claude Code requests now route through AI Gateway, giving you full visibility into usage patterns and costs while using your Max subscription.

您对 Claude Code 的请求现在将通过 AI Gateway 进行路由，在使用 Max 订阅的同时，为您提供完整的用量模式与费用可视化能力。

### How it works

### 工作原理

When you configure Claude Code to use AI Gateway, Claude Code continues to authenticate with Anthropic. It sends its `Authorization` header and AI Gateway acts as either a passthrough proxy to Anthropic or, when it needs to fall back, a router to other providers.

当您将 Claude Code 配置为使用 AI Gateway 时，Claude Code 仍会继续向 Anthropic 进行身份验证。它发送自身的 `Authorization` 请求头，而 AI Gateway 则作为直通代理（passthrough proxy）将请求转发至 Anthropic；在需要降级（fallback）时，则作为路由器将请求分发至其他提供商。

Since the `Authorization` header is reserved for Claude subscription credentials, AI Gateway uses a separate header `x-ai-gateway-api-key` for its own authentication. This allows both auth mechanisms to coexist.

由于 `Authorization` 请求头专用于 Claude 订阅凭证，AI Gateway 使用独立的请求头 `x-ai-gateway-api-key` 进行自身身份验证。这使得两种认证机制可共存并互不干扰。

Read more about how to configure Claude Code Max with AI Gateway in the [docs](https://vercel.com/docs/ai-gateway/coding-agents/claude-code#with-claude-code-max).

有关如何将 Claude Code Max 与 AI Gateway 配合使用的更多说明，请参阅 [文档](https://vercel.com/docs/ai-gateway/coding-agents/claude-code#with-claude-code-max)。