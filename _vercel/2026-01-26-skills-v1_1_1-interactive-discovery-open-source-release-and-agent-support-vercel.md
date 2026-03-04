---
title: "Skills v1.1.1: Interactive discovery, open source release, and agent support - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skills-v1-1-1-interactive-discovery-open-source-release-and-agent-support"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:06.704838323+00:00"
language: "en-zh"
translated: true
description: "Skills v1.1.1 introduces interactive skill discovery with npx skills find, full open source release on GitHub, and enhanced support for 27 coding agents with automated workflows."
---
&#123;% raw %}

Jan 26, 2026

2026 年 1 月 26 日

![](images/skills-v1_1_1-interactive-discovery-open-source-release-and-agent-support-vercel/img_001.jpg)![](images/skills-v1_1_1-interactive-discovery-open-source-release-and-agent-support-vercel/img_002.jpg)

`skills@1.1.1` adds interactive skill discovery and is now fully open source.

`skills@1.1.1` 版本新增了交互式技能发现功能，并现已完全开源。

The new interactive discovery keeps the workflow simple for developers, while also giving agents a clear path to discover skills programmatically by replacing the deprecated `npx add-skill` command with the updated `npx skills` interface.

新的交互式发现机制既保持了开发者工作流的简洁性，又为 AI 智能体提供了清晰、可编程的技能发现路径——它以更新后的 `npx skills` 接口取代了已弃用的 `npx add-skill` 命令。

You can now use `npx skills find` to search as you type and discover skills interactively. For AI agents, [Skills](https://github.com/vercel-labs/skills) includes a meta "find-skills" skill, along with a non-interactive mode designed for automated workflows, and support for 27 coding agents.

现在，您可通过 `npx skills find` 实时搜索并交互式地发现技能。对于 AI 智能体，[Skills](https://github.com/vercel-labs/skills) 提供了一个元技能（meta skill）——“find-skills”，同时还支持专为自动化工作流设计的非交互模式，并兼容 27 种编程类智能体。

Skills maintenance is also simpler with the new `npx skills update` command, which refreshes your local skills without manual steps.

借助全新的 `npx skills update` 命令，技能维护也变得更加简单：它可自动刷新本地技能，无需任何手动操作。

The full codebase is available on GitHub at [Skills](https://github.com/vercel-labs/skills).

完整源代码已在 GitHub 开源，详见 [Skills](https://github.com/vercel-labs/skills) 仓库。

### Migration

### 迁移指南

The previous `npx add-skill` command is deprecated. Use `npx skills find` for interactive discovery, and use `npx skills update` to refresh existing skills.

此前的 `npx add-skill` 命令已被弃用。请改用 `npx skills find` 进行交互式技能发现，并使用 `npx skills update` 刷新已有技能。

Get started with `npx skills@latest` or explore the [Skills repository](https://github.com/vercel-labs/skills).

请运行 `npx skills@latest` 快速开始，或访问 [Skills 仓库](https://github.com/vercel-labs/skills) 进一步了解。

```text
npx skills add vercel-labs/agent-skills
```

```text
npx skills add vercel-labs/agent-skills
```
&#123;% endraw %}
