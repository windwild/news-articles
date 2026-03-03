---
title: "Introducing the vercel api CLI command - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/introducing-the-vercel-api-cli-command"
date: "2026-01-27"
scraped_at: "2026-03-02T10:47:55.155426817+00:00"
language: "en"
translated: false
description: "The vercel api command makes an authenticated HTTP request to the Vercel API and prints the response."
---




Jan 27, 2026

`vercel@50.5.1` adds a new `api` command, giving direct access to the full suite of Vercel APIs from your terminal.

The `api` command provides a direct access point for AI agents to interact with Vercel through the CLI. Agents like Claude Code can access Vercel directly with no additional configuration required. If an agent has access to the environment and the Vercel CLI, it inherits the user's access permissions automatically.

List available APIs with `vercel api ls`, build requests interactively with `vercel api`, or send requests directly with `vercel api [endpoint] [options]`.

Get started with `npx vercel@latest api --help`.