---
title: "Granular branch matching for Git configuration in vercel.json - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/granular-branch-matching-for-git-configuration-in-vercel-json"
date: "2025-02-25"
scraped_at: "2026-03-02T09:36:00.488667446+00:00"
language: "en"
translated: false
description: "You can now specify glob patterns for Git branches in the `git.deploymentEnabled` field in `vercel.json`."
---




Feb 25, 2025

Vercel now supports glob patterns (like `testing-*`) in the `git.deploymentEnabled` field, giving you more control over branch deployments.

Previously, you could disable deployments for specific branches by explicitly naming them. Now, you can use patterns to match multiple branches at once.

For example, the configuration below prevents deployments on Vercel if the branch begins with `internal-`.

vercel.json

```json
1{

2  "git": {

3    "deploymentEnabled": {

4      "internal-*": false

5    }

6  }

7}
```

Learn more about [Git configuration](https://vercel.com/docs/projects/project-configuration/git-configuration#git-configuration).