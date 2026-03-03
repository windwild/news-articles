---
title: "Vercel CLI for Marketplace integrations optimized for agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-cli-for-marketplace-integrations-optimized-for-agents"
date: "2026-03-02"
scraped_at: "2026-03-03T07:10:21.225024288+00:00"
language: "en"
translated: false
description: "AI agents can now discover, evaluate, and install Vercel Marketplace integrations autonomously through the CLI with non-interactive commands and JSON output."
---




Mar 2, 2026

AI agents can now autonomously discover, install, and retrieve setup instructions for Vercel Marketplace integrations using the Vercel CLI. This lets agents configure databases, auth, logging, and other services end-to-end in one workflow.

These capabilities are powered by the new `discover` and `guide` commands in the Vercel CLI.

By using the `--format=json` flag with the discover command, the CLI provides non-interactive JSON output that benefits developers as well, making it easier to automate infrastructure, write custom scripts, and manage CI/CD pipelines.

When building an application, agents begin by exploring available integrations using the [`discover` command](https://vercel.com/docs/cli/integration#vercel-integration-discover).

```bash
vercel integration discover --format=json
```

After exploring the options, the agent can `add` an integration and then fetch getting started guides and code snippets for a specific integration using the `guide` command.

```bash
vercel integration add neon --format=json

vercel integration guide neon
```

The Vercel CLI returns this setup documentation in an agent-friendly markdown format. This allows the agent to easily parse the instructions, write the necessary integration code, and configure the project autonomously.

For integrations with required metadata fields, agents can use the `help` command to determine the required inputs and pass them as options to the `add` command.

```bash
vercel integration add upstash/upstash-redis --help

vercel integration add upstash/upstash-redis -m primaryRegion=iad1 --format=json
```

The CLI also makes it easy to pause this process for human decisions, like terms of service acceptance. Agents can prompt developers for confirmation, enabling hybrid workflows that require human oversight of certain integration decisions.

These commands are continuously tested against agent evaluations to ensure reliable autonomous behavior.

```bash
pnpm i -g vercel@latest
```

Update to the latest version of the Vercel CLI to try it out, or read the [documentation](https://vercel.com/docs/cli/integration).