---
title: "Vercel CLI for Marketplace integrations optimized for agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-for-marketplace-integrations-optimized-for-agents"
date: "2026-03-02"
scraped_at: "2026-03-03T07:10:21.225024288+00:00"
language: "en-zh"
translated: true
description: "AI agents can now discover, evaluate, and install Vercel Marketplace integrations autonomously through the CLI with non-interactive commands and JSON output."
---
{% raw %}

Mar 2, 2026

2026 年 3 月 2 日

AI agents can now autonomously discover, install, and retrieve setup instructions for Vercel Marketplace integrations using the Vercel CLI. This lets agents configure databases, auth, logging, and other services end-to-end in one workflow.

AI 智能体现在可通过 Vercel CLI 自主发现、安装并获取 Vercel Marketplace 集成的配置说明，从而在单一流程中端到端地完成数据库、身份认证（auth）、日志记录及其他服务的配置。

These capabilities are powered by the new `discover` and `guide` commands in the Vercel CLI.

上述能力由 Vercel CLI 中新增的 `discover`（发现）和 `guide`（指南）命令提供支持。

By using the `--format=json` flag with the discover command, the CLI provides non-interactive JSON output that benefits developers as well, making it easier to automate infrastructure, write custom scripts, and manage CI/CD pipelines.

在 `discover` 命令中使用 `--format=json` 标志后，CLI 将输出非交互式的 JSON 格式结果——这不仅有利于 AI 智能体，也极大便利了开发者，使其更轻松地实现基础设施自动化、编写自定义脚本以及管理 CI/CD 流水线。

When building an application, agents begin by exploring available integrations using the [`discover` command](https://vercel.com/docs/cli/integration#vercel-integration-discover).

构建应用时，智能体首先通过 [`discover` 命令](https://vercel.com/docs/cli/integration#vercel-integration-discover) 探索当前可用的集成选项。

```bash
vercel integration discover --format=json
```

```bash
vercel integration discover --format=json
```

After exploring the options, the agent can `add` an integration and then fetch getting started guides and code snippets for a specific integration using the `guide` command.

完成选项探索后，智能体可使用 `add` 命令添加某项集成，并通过 `guide` 命令获取该集成的入门指南与代码片段。

```bash
vercel integration add neon --format=json

vercel integration guide neon
```

```bash
vercel integration add neon --format=json

vercel integration guide neon
```

The Vercel CLI returns this setup documentation in an agent-friendly markdown format. This allows the agent to easily parse the instructions, write the necessary integration code, and configure the project autonomously.

Vercel CLI 以对智能体友好的 Markdown 格式返回上述配置文档，使智能体能够轻松解析操作说明、编写必要的集成代码，并自主完成项目配置。

For integrations with required metadata fields, agents can use the `help` command to determine the required inputs and pass them as options to the `add` command.

对于需要元数据字段的集成，智能体可使用 `help` 命令来确定所需输入，并将这些输入作为选项传递给 `add` 命令。

```bash
vercel integration add upstash/upstash-redis --help

vercel integration add upstash/upstash-redis -m primaryRegion=iad1 --format=json
```

The CLI also makes it easy to pause this process for human decisions, like terms of service acceptance. Agents can prompt developers for confirmation, enabling hybrid workflows that require human oversight of certain integration decisions.

CLI 还支持在关键环节（例如服务条款确认）暂停该流程，以便人工介入决策。智能体可向开发者发起确认提示，从而实现需人工监督特定集成决策的混合式工作流。

These commands are continuously tested against agent evaluations to ensure reliable autonomous behavior.

这些命令持续接受智能体评估测试，以确保其自主行为的可靠性。

```bash
pnpm i -g vercel@latest
```

Update to the latest version of the Vercel CLI to try it out, or read the [documentation](https://vercel.com/docs/cli/integration).

请升级至最新版本的 Vercel CLI 以体验该功能，或查阅[文档](https://vercel.com/docs/cli/integration)。
{% endraw %}
