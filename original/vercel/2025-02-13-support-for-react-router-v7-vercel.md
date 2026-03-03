---
title: "Support for React Router v7 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-react-router-v7"
date: "2025-02-13"
scraped_at: "2026-03-02T09:36:23.391129329+00:00"
language: "en"
translated: false
description: "Vercel now supports React Router v7 applications when used as a framework. This includes support for server-rendered React Router applications using Vercel's Fluid compute."
---




Feb 13, 2025

![](images/support-for-react-router-v7-vercel/img_001.jpg)![](images/support-for-react-router-v7-vercel/img_002.jpg)

Vercel now supports [React Router v7](https://reactrouter.com/) applications when [used as a framework](https://reactrouter.com/start/framework/installation):

react-router.config.ts

```javascript
import { vercelPreset } from "@vercel/react-router/vite";

import type { Config } from "@react-router/dev/config";



export default {

5  ssr: true,

6  presets: [vercelPreset()],

7} satisfies Config;
```

Configuring your React Router application with the Vercel preset.

This includes support for server-rendered React Router applications using Vercel's [Fluid compute](https://vercel.com/docs/functions/fluid-compute). Further, the Vercel preset intelligently splits application bundles across Vercel Functions, and supports custom server entry points.

[Deploy React Router to Vercel](https://vercel.com/templates/react-router/react-router-boilerplate) or learn more about [React Router on Vercel](https://vercel.com/docs/frameworks/react-router).