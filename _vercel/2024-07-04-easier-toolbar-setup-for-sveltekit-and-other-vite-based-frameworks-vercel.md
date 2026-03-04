---
title: "Easier toolbar setup for SvelteKit and other Vite-based frameworks - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/easier-toolbar-setup-for-sveltekit-and-other-vite-based-frameworks"
date: "2024-07-04"
scraped_at: "2026-03-02T09:43:04.074479275+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

render_with_liquid: false
Jul 4, 2024

2024 年 7 月 4 日

Vite-based frameworks such as SvelteKit, Remix, Nuxt, or Astro can now more easily integrate with the Vercel Toolbar in both [local](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost) and [production](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production) environments.  

基于 Vite 的框架（例如 SvelteKit、Remix、Nuxt 或 Astro）现在可更轻松地在[本地开发环境](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost)和[生产环境](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production)中集成 Vercel Toolbar。

The Toolbar enables you to comment on deployments, toggle feature flags, view draft content from a CMS, [and more](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#vercel-toolbar-features).  

该工具栏支持您对部署进行评论、切换功能开关（feature flags）、预览 CMS 中的草稿内容，[以及更多功能](https://vercel.com/docs/workflow-collaboration/vercel-toolbar#vercel-toolbar-features)。

The updated `@vercel/toolbar` package offers a Vite plugin and client-side function for injection and configuration, and can be integrated like this:  

更新后的 `@vercel/toolbar` 包提供了一个 Vite 插件及用于注入与配置的客户端函数，可按如下方式集成：

vite.config.js

vite.config.js

```javascript
import { vercelToolbar } from '@vercel/toolbar/plugins/vite';

import { defineConfig } from 'vite';



export default defineConfig({

5  plugins: [/* others...*/ vercelToolbar()]

6  // ...
```

7});
```

```javascript
1// in your framework's client entry point:

// 在您框架的客户端入口点中：

import { mountVercelToolbar } from '@vercel/toolbar/vite';



mountVercelToolbar();
```

[Check out the documentation](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost) to learn more.

[查看文档](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost) 了解更多信息。