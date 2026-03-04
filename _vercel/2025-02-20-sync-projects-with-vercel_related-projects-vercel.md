---
title: "Sync projects with @vercel/related-projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sync-projects-with-vercel-related-projects"
date: "2025-02-20"
scraped_at: "2026-03-02T09:36:13.722066111+00:00"
language: "en-zh"
translated: true
description: "Related projects allows automatically linking preview deployments across multiple projects in monorepos."
---
&#123;% raw %}

Feb 20, 2025

2025 年 2 月 20 日

![](images/sync-projects-with-vercel_related-projects-vercel/img_001.jpg)![](images/sync-projects-with-vercel_related-projects-vercel/img_002.jpg)

全新的 [`@vercel/related-projects`](https://www.npmjs.com/package/@vercel/related-projects) 包可帮助在多个独立的 Vercel 项目之间同步部署信息，确保您的应用始终引用最新的预览（Preview）或生产（Production）环境部署 URL，而无需手动更新或修改环境变量。

此前，开发者需手动输入部署 URL、管理连接字符串，或依赖环境变量来维持各项目间的有效通信。如今，这些数据可在构建时和运行时自动获取并实时更新。

例如，一个包含以下两个项目的单体仓库（monorepo）：

- 一个前端 Next.js 项目，用于从 API 获取数据；  
- 一个后端 Express.js API 项目，用于提供数据。

借助 Related Projects 功能，前端项目的每次预览部署均可自动关联到后端项目对应的预览部署，从而避免在跨项目测试变更时硬编码 URL。

Related Projects 通过 Vercel 项目 ID 进行关联。您可在 Vercel 控制台中进入项目 **Settings**（设置）页面，[查找您的项目 ID](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%23project-id&title=Find+your+Vercel+project+ID)。

```tsx
1- const host =  process.env.API_URL as string
```

2+ const host = withRelatedProject({

2+ const host = withRelatedProject({

3+     projectName: "api-project",

3+     projectName: "api-project",

4+     defaultHost: process.env.API_URL as string,

4+     defaultHost: process.env.API_URL as string,

5+ });
```

5+ });
```

Example of connecting a frontend project to a separate backend API.

将前端项目连接到独立后端 API 的示例。

Learn more about [linking related projects](https://vercel.com/docs/monorepos#how-to-link-projects-together-in-a-monorepo).

了解更多关于[关联项目链接](https://vercel.com/docs/monorepos#how-to-link-projects-together-in-a-monorepo)的信息。
&#123;% endraw %}
