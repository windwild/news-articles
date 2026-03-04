---
render_with_liquid: false
title: "Support for Remix with Vite - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/support-for-remix-with-vite"
date: "2024-03-06"
scraped_at: "2026-03-02T09:47:51.663188539+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Mar 6, 2024

2024 年 3 月 6 日

Vercel now supports deploying Remix applications using Vite.

Vercel 现已支持使用 Vite 部署 Remix 应用。

vite.config.js

vite.config.js

```javascript
import { vitePlugin as remix } from '@remix-run/dev';

import { installGlobals } from '@remix-run/node';

import { defineConfig } from 'vite';

import tsconfigPaths from 'vite-tsconfig-paths';

import { vercelPreset } from '@vercel/remix/vite';



installGlobals();
```

```js
export default defineConfig({

10  plugins: [\
\
11    remix({\
\
12      presets: [vercelPreset()],\
\
13    }),\
\
14    tsconfigPaths(),\
\
15  ],

16});
```

```js
export default defineConfig({

10  插件: [\
\
11    remix({\
\
12      presets: [vercelPreset()],\
\
13    }),\
\
14    tsconfigPaths(),\
\
15  ],

16});
```

Configuring your Remix application with the Vercel Vite preset.

使用 Vercel Vite 预设配置您的 Remix 应用。

We've collaborated with the Remix team to add [Server Bundles](https://remix.run/docs/en/main/future/server-bundles) to Remix. Vercel will now detect Remix projects using Vite and optimize them using our new Vite preset ( [@vercel/remix/vite](https://www.npmjs.com/package/@vercel/remix)).

我们已与 Remix 团队合作，为 Remix 引入了 [Server Bundles（服务端打包）](https://remix.run/docs/zh-CN/main/future/server-bundles) 功能。Vercel 现在能够自动识别使用 Vite 的 Remix 项目，并通过我们全新的 Vite 预设（[@vercel/remix/vite](https://www.npmjs.com/package/@vercel/remix)）对其进行优化。

This preset enables adding additional features for Remix on Vercel such as:

该预设为 Vercel 上的 Remix 启用了更多高级功能，例如：

- **Streaming SSR:** Dynamically stream content with both Node.js and Edge runtimes

- **流式服务端渲染（Streaming SSR）：** 支持在 Node.js 和 Edge 运行时环境中动态流式传输内容

- **API Routes:** Easily build your serverless API with Remix and a route `loader`

- **API 路由（API Routes）：** 借助 Remix 的路由 `loader`，轻松构建无服务器 API

- **Advanced Caching:** Use powerful cache headers like `stale-while-revalidate`

- **高级缓存（Advanced Caching）：** 使用诸如 `stale-while-revalidate` 等强大的缓存响应头

- **Data Mutations:** Run `actions` inside Vercel Functions

- **数据变更：** 在 Vercel 函数中运行 `actions`

[Deploy Remix to Vercel](https://vercel.com/templates/remix/remix-boilerplate) or learn more [in the docs](https://vercel.com/docs/frameworks/remix).

[将 Remix 部署到 Vercel](https://vercel.com/templates/remix/remix-boilerplate)，或在[文档中](https://vercel.com/docs/frameworks/remix)了解更多信息。