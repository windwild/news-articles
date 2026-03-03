---
title: "@vercel/toolbar available to use collaboration features in production - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-toolbar-now-available-to-use-collaboration-features-in-production"
date: "2023-09-22"
scraped_at: "2026-03-02T09:50:27.077794445+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Sep 22, 2023

Comments and other collaboration features are available in all Preview Deployments on Vercel. Now, you can enable them in Production Deployments and localhost by injecting the Vercel toolbar on any site with our [`@vercel/toolbar`](https://www.npmjs.com/package/@vercel/toolbar) package.

```tsx
import { VercelToolbar } from '@vercel/toolbar/next';

import { useIsEmployee } from 'lib/auth'; // Your auth library



export function StaffToolbar() {

5  const isEmployee = useIsEmployee();

6  return isEmployee ? <VercelToolbar /> : null;

7}
```

By using the `@vercel/toolbar` npm package you and your team can leave feedback with [Comments](https://vercel.com/docs/workflow-collaboration/comments), take advantage of [Draft Mode](https://vercel.com/docs/workflow-collaboration/draft-mode) to view unpublished CMS content, or use [Visual Editing](https://vercel.com/docs/workflow-collaboration/visual-editing) on your production application.

This package is available to users on all plans and is our first step in bringing the Vercel Toolbar into your production sites.

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/comments/in-production-and-localhost) to learn more.