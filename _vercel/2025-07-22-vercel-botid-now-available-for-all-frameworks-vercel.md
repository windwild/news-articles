---
title: "Vercel BotID now  available for all frameworks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/botid-now-available-for-all-frameworks"
date: "2025-07-22"
scraped_at: "2026-03-02T09:30:52.009276809+00:00"
language: "en-zh"
translated: true
description: "Protect high-value endpoints like checkout, login, and AI APIs with Vercel BotID 1.4.3, now with universal JavaScript support. Use initBotId() in SvelteKit, Nuxt, and more to stop the more sophisticat..."
---
&#123;% raw %}

Jul 22, 2025

2025 年 7 月 22 日

You can now use Vercel BotID to protect your most sensitive endpoints in any JavaScript framework, like SvelteKit and Nuxt.

您现在可在任意 JavaScript 框架（例如 SvelteKit 和 Nuxt）中使用 Vercel BotID，以保护您最关键的端点。

BotID is our [advanced bot protection](https://vercel.com/blog/introducing-botid) for high-value endpoints like registration, checkout, and AI interactions. Since launch, it has already protected nearly a million API requests.

BotID 是我们面向高价值端点（如注册、结算及 AI 交互等）推出的[高级机器人防护方案](https://vercel.com/blog/introducing-botid)。自发布以来，BotID 已成功防护近一百万次 API 请求。

Installing or upgrading to `botid@1.4.3` adds support for universal JavaScript environments with the new `initBotId({ protect: ... })` function.

安装或升级至 `botid@1.4.3` 后，即可通过新增的 `initBotId({ protect: ... })` 函数，获得对通用 JavaScript 运行环境的支持。

Here's an example of `initBotId` used to set up BotID in SvelteKit:

以下是在 SvelteKit 中使用 `initBotId` 配置 BotID 的示例：

src/hooks.client.ts

```jsx
import { initBotId } from 'botid/client/core';



export function init() {

4  initBotId({

5    protect: [\
\
6      {\
\
7        path: '/api/user',\
\
8        method: 'POST',\
\
9      },\
\
10    ],

11  });

12}
```

在 SvelteKit 项目中初始化 BotID

在 SvelteKit 项目中初始化 BotID

We recommend using `initBotId()` in `instrumentation-client.ts` for better performance in **Next.js v15.3+**. Earlier versions can continue using the React `<BotIdClient>` component approach.

我们建议在 **Next.js v15.3+** 中于 `instrumentation-client.ts` 文件内使用 `initBotId()`，以获得更佳性能；早期版本则可继续采用 React `<BotIdClient>` 组件的方式。

Check out the [updated documentation](https://vercel.com/docs/botid) for setup instructions across all supported frameworks.

请查阅 [最新文档](https://vercel.com/docs/botid)，了解所有受支持框架的配置说明。
&#123;% endraw %}
