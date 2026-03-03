---
title: "Skills v1.1.1: Interactive discovery, open source release, and agent support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skills-v1-1-1-interactive-discovery-open-source-release-and-agent-support"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:06.704838323+00:00"
language: "en"
translated: false
description: "Skills v1.1.1 introduces interactive skill discovery with npx skills find, full open source release on GitHub, and enhanced support for 27 coding agents with automated workflows."
---




Jan 26, 2026

![](images/skills-v1_1_1-interactive-discovery-open-source-release-and-agent-support-vercel/img_001.jpg)![](images/skills-v1_1_1-interactive-discovery-open-source-release-and-agent-support-vercel/img_002.jpg)

`skills@1.1.1` adds interactive skill discovery and is now fully open source.

The new interactive discovery keeps the workflow simple for developers, while also giving agents a clear path to discover skills programmatically by replacing the deprecated `npx add-skill` command with the updated `npx skills` interface.

You can now use `npx skills find` to search as you type and discover skills interactively. For AI agents, [Skills](https://github.com/vercel-labs/skills) includes a meta "find-skills" skill, along with a non-interactive mode designed for automated workflows, and support for 27 coding agents.

Skills maintenance is also simpler with the new `npx skills update` command, which refreshes your local skills without manual steps.

The full codebase is available on GitHub at [Skills](https://github.com/vercel-labs/skills).

### Migration

The previous `npx add-skill` command is deprecated. Use `npx skills find` for interactive discovery, and use `npx skills update` to refresh existing skills.

Get started with `npx skills@latest` or explore the [Skills repository](https://github.com/vercel-labs/skills).

```text
npx skills add vercel-labs/agent-skills
```