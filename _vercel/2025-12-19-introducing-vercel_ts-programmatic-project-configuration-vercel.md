---
title: "Introducing vercel.ts: Programmatic project configuration - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-ts"
date: "2025-12-19"
scraped_at: "2026-03-02T09:23:31.332785249+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports vercel.ts, a new TypeScript-based configuration file that brings type safety, dynamic logic, and better developer experience to project configuration."
---

render_with_liquid: false
Dec 19, 2025

2025 年 12 月 19 日

Vercel 现已支持 `vercel.ts` —— 一种基于 TypeScript 的全新配置文件，为项目配置带来类型安全、动态逻辑能力以及更佳的开发者体验。

`vercel.ts` 允许你以代码形式表达配置，例如定义高级路由规则、请求转换逻辑、缓存策略及定时任务（cron jobs），其能力远超静态 JSON 配置所能表达的范围。除完整的类型安全性外，该方式还支持访问环境变量、复用共享逻辑，以及实现条件化行为。

所有项目现在均可使用 `vercel.ts`（或 `.js`、`.mjs`、`.cjs`、`.mts`）进行项目配置。其中各项配置属性的定义方式与 `vercel.json` 完全一致，并可通过全新的 `@vercel/config` 包进一步增强功能。

vercel.ts

```typescript
import { type VercelConfig, routes, deploymentEnv } from '@vercel/config/v1';



export const config: VercelConfig = {

4  framework: 'nextjs',

```

6  crons: [\
\
7    { path: '/api/cleanup', schedule: '0 0 * * *' },\
\
8    { path: '/api/sync-users', schedule: '*/15 * * * *' },\
\
9  ],


6  定时任务（crons）：[\
\
7    { path: '/api/cleanup', schedule: '0 0 * * *' },\
\
8    { path: '/api/sync-users', schedule: '*/15 * * * *' },\
\
9  ],


11  rewrites: [\
\
12    routes.rewrite('/(.*)', 'https://external-api.com', {\
\
13      requestHeaders: {\
\
14        'proxy-header': deploymentEnv('PROXY_HEADER')\
\
15      }\
\
16    }),\
\
17  ],

11  重写规则（rewrites）：[\
\
12    routes.rewrite('/(.*)', 'https://external-api.com', {\
\
13      requestHeaders: {\
\
14        'proxy-header': deploymentEnv('PROXY_HEADER')\
\
15      }\
\
16    }),\
\
17  ],


18};
```

[Try the playground](https://vercel-ts-playground.vercel.app/) to explore `vercel.ts`, [learn how to migrate from an existing vercel.json](https://vercel.com/docs/project-configuration/vercel-ts#migrating-from-vercel.json), or read the [documentation](https://vercel.com/docs/project-configuration) and the [@vercel/config package](https://www.npmjs.com/package/@vercel/config).

[Try the playground](https://vercel-ts-playground.vercel.app/)（尝试在线 Playground）以探索 `vercel.ts`，[学习如何从现有的 `vercel.json` 迁移](https://vercel.com/docs/project-configuration/vercel-ts#migrating-from-vercel.json)，或查阅 [文档](https://vercel.com/docs/project-configuration) 及 [@vercel/config 包](https://www.npmjs.com/package/@vercel/config)。