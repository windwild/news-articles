---
title: "Support for React Router v7 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-react-router-v7"
date: "2025-02-13"
scraped_at: "2026-03-02T09:36:23.391129329+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports React Router v7 applications when used as a framework. This includes support for server-rendered React Router applications using Vercel's Fluid compute."
---

Feb 13, 2025

2025 年 2 月 13 日

![](images/support-for-react-router-v7-vercel/img_001.jpg)![](images/support-for-react-router-v7-vercel/img_002.jpg)

Vercel now supports [React Router v7](https://reactrouter.com/) applications when [used as a framework](https://reactrouter.com/start/framework/installation):

Vercel 现已支持将 [React Router v7](https://reactrouter.com/) 作为框架使用时所构建的应用程序（参见 [框架安装指南](https://reactrouter.com/start/framework/installation)）：

react-router.config.ts

```javascript
import { vercelPreset } from "@vercel/react-router/vite";

import type { Config } from "@react-router/dev/config";

export default {
  ssr: true,
  presets: [vercelPreset()],
};
```

7} satisfies Config;
```

Configuring your React Router application with the Vercel preset.

使用 Vercel 预设配置您的 React Router 应用。

This includes support for server-rendered React Router applications using Vercel's [Fluid compute](https://vercel.com/docs/functions/fluid-compute). Further, the Vercel preset intelligently splits application bundles across Vercel Functions, and supports custom server entry points.

该预设支持基于 Vercel [Fluid compute](https://vercel.com/docs/functions/fluid-compute) 的服务端渲染 React Router 应用；此外，Vercel 预设还能智能地将应用包拆分至多个 Vercel Function，并支持自定义服务器入口点。

[Deploy React Router to Vercel](https://vercel.com/templates/react-router/react-router-boilerplate) or learn more about [React Router on Vercel](https://vercel.com/docs/frameworks/react-router).

[将 React Router 部署到 Vercel](https://vercel.com/templates/react-router/react-router-boilerplate)，或深入了解 [Vercel 上的 React Router](https://vercel.com/docs/frameworks/react-router)。