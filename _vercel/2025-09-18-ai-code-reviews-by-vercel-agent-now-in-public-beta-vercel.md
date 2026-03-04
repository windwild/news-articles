---
title: "AI code reviews by Vercel Agent now in Public Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-code-reviews-by-vercel-agent-now-in-beta"
date: "2025-09-18"
scraped_at: "2026-03-02T09:28:30.102394634+00:00"
language: "en-zh"
translated: true
description: "Vercel Agent now provides high signal AI code reviews and fix suggestions to speed up your development process"
---
{% raw %}

Sep 18, 2025

2025 年 9 月 18 日

Vercel Agent 现已支持代码审查功能，可提供经过验证的改进建议，覆盖正确性、安全性与性能等多方面问题。

这些审查完全基于整个代码库展开，不仅分析代码差异（diff），还会关联检查任何相关文件。所有建议的补丁均在 Vercel Sandbox 中先行生成并验证，确保在提交至您的 Pull Request（PR）前已通过严格测试。

核心功能还包括：

- 针对 Next.js、React、Nuxt 和 Svelte 等主流框架的深度优化，并支持 TypeScript、Python、Go 等多种语言

- 提供高信息密度的内联评论（inline comments），便于人工复核；每条评论均附带差异对比（diff）、问题分析及复现步骤，确保全程透明可追溯

- 内置仪表盘可观测性（In-dashboard Observability），实时展示文件读取数、审查耗时、成本等关键指标

- 灵活的配置选项：支持审查全部仓库、仅公开仓库或仅私有仓库，并可选择跳过草稿状态（draft）的 PR

目前面向所有 Pro 与 Enterprise 团队开放公开测试（public beta），采用完全按用量计费模式，并为每位用户赠送 $100 的 Vercel Agent 信用额度。

立即免费试用：[全新 Agent 仪表盘](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent&title=Open+Vercel+Agent)  
深入了解：[官方文档](https://vercel.com/docs/agent/overview#pricing)  
欢迎反馈：[Vercel 社区讨论帖](https://community.vercel.com/t/vercel-agent-now-in-public-beta/22813)
{% endraw %}
