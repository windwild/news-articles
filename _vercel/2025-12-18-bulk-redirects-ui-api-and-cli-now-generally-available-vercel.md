---
title: "Bulk redirects UI, API, and CLI now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bulk-redirects-ui-api-and-cli-now-generally-available"
date: "2025-12-18"
scraped_at: "2026-03-02T09:23:46.570072889+00:00"
language: "en-zh"
translated: true
description: "You can now manage up to a million redirects on Vercel via UI, API, or CLI instantly without a build or deployment."
---
{% raw %}

Dec 18, 2025

2025 年 12 月 18 日

Vercel 用户现在可通过 UI、API 或 CLI 配置批量重定向，无需重新部署。

Vercel 的[批量重定向](https://vercel.com/changelog/bulk-redirects-are-now-generally-available)功能支持每个项目最多配置一百万个静态 URL 重定向。除原有通过 `vercel.json` 文件配置批量重定向的方式外，本次更新进一步简化了团队管理大规模迁移、快速修复失效链接、处理已过期页面等场景的操作流程。

您可单独修改重定向规则，也可通过上传 CSV 文件批量修改。所有重定向变更将首先进入暂存状态以供测试，确认无误后再发布至生产环境；同时系统会自动保存版本历史，便于查看及恢复历史版本。

该功能面向 Pro 和 Enterprise 计划用户开放，额外容量按以下费率计费：

- **Pro 计划：** 每个项目包含 1,000 条批量重定向配额

- **Enterprise 计划：** 每个项目包含 10,000 条批量重定向配额

- **额外容量：** 起价为每月 50 美元，每增加 25,000 条重定向

[立即开始使用批量重定向](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fredirects)，或[了解详情](https://vercel.com/docs/redirects/bulk-redirects)。
{% endraw %}
