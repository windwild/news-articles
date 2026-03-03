---
title: "@vercel/toolbar available to use collaboration features in production - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-toolbar-now-available-to-use-collaboration-features-in-production"
date: "2023-09-22"
scraped_at: "2026-03-02T09:50:27.077794445+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Sep 22, 2023

2023 年 9 月 22 日

Comments and other collaboration features are available in all Preview Deployments on Vercel. Now, you can enable them in Production Deployments and localhost by injecting the Vercel toolbar on any site with our [`@vercel/toolbar`](https://www.npmjs.com/package/@vercel/toolbar) package.

Vercel 的所有预览部署（Preview Deployments）均已支持评论（Comments）及其他协作功能。现在，您可通过在任意网站中注入 Vercel 工具栏，将这些功能启用至生产环境部署（Production Deployments）及本地开发环境（localhost）。实现方式是使用我们的 [`@vercel/toolbar`](https://www.npmjs.com/package/@vercel/toolbar) npm 包。

```tsx
import { VercelToolbar } from '@vercel/toolbar/next';

import { useIsEmployee } from 'lib/auth'; // Your auth library



export function StaffToolbar() {

5  const isEmployee = useIsEmployee();

6  return isEmployee ? <VercelToolbar /> : null;

7}
```

```tsx
import { VercelToolbar } from '@vercel/toolbar/next';

import { useIsEmployee } from 'lib/auth'; // 您的认证库



export function StaffToolbar() {

5  const isEmployee = useIsEmployee();

6  return isEmployee ? <VercelToolbar /> : null;

7}
```

By using the `@vercel/toolbar` npm package you and your team can leave feedback with [Comments](https://vercel.com/docs/workflow-collaboration/comments), take advantage of [Draft Mode](https://vercel.com/docs/workflow-collaboration/draft-mode) to view unpublished CMS content, or use [Visual Editing](https://vercel.com/docs/workflow-collaboration/visual-editing) on your production application.

借助 `@vercel/toolbar` npm 包，您和您的团队可在生产应用中使用 [评论（Comments）](https://vercel.com/docs/workflow-collaboration/comments) 功能提交反馈、利用 [草稿模式（Draft Mode）](https://vercel.com/docs/workflow-collaboration/draft-mode) 查看尚未发布的 CMS 内容，或启用 [可视化编辑（Visual Editing）](https://vercel.com/docs/workflow-collaboration/visual-editing) 功能。

This package is available to users on all plans and is our first step in bringing the Vercel Toolbar into your production sites.

该软件包面向所有订阅计划的用户开放，是我们将 Vercel 工具栏引入您生产环境站点的第一步。

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/comments/in-production-and-localhost) to learn more.

[查看文档](https://vercel.com/docs/workflow-collaboration/comments/in-production-and-localhost) 以了解更多信息。