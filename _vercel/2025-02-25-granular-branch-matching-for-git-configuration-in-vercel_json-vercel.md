---
render_with_liquid: false
title: "Granular branch matching for Git configuration in vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/granular-branch-matching-for-git-configuration-in-vercel-json"
date: "2025-02-25"
scraped_at: "2026-03-02T09:36:00.488667446+00:00"
language: "en-zh"
translated: true
description: "You can now specify glob patterns for Git branches in the `git.deploymentEnabled` field in `vercel.json`."
---
render_with_liquid: false
render_with_liquid: false

Feb 25, 2025

2025 年 2 月 25 日

Vercel now supports glob patterns (like `testing-*`) in the `git.deploymentEnabled` field, giving you more control over branch deployments.

Vercel 现在在 `git.deploymentEnabled` 字段中支持通配符模式（例如 `testing-*`），让您对分支部署拥有更精细的控制能力。

Previously, you could disable deployments for specific branches by explicitly naming them. Now, you can use patterns to match multiple branches at once.

此前，您只能通过显式列出分支名称来禁用特定分支的部署；而现在，您可以使用通配模式一次性匹配多个分支。

For example, the configuration below prevents deployments on Vercel if the branch begins with `internal-`.

例如，以下配置将阻止所有以 `internal-` 开头的分支在 Vercel 上触发部署。

vercel.json

```json
1{

2  "git": {

3    "deploymentEnabled": {

4      "internal-*": false

5    }
```

6  }

7}
```

Learn more about [Git configuration](https://vercel.com/docs/projects/project-configuration/git-configuration#git-configuration).

了解更多关于 [Git 配置](https://vercel.com/docs/projects/project-configuration/git-configuration#git-configuration) 的信息。