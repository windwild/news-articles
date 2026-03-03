---
title: "Vercel BotID now  available for all frameworks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/botid-now-available-for-all-frameworks"
date: "2025-07-22"
scraped_at: "2026-03-02T09:30:52.009276809+00:00"
language: "en"
translated: false
description: "Protect high-value endpoints like checkout, login, and AI APIs with Vercel BotID 1.4.3, now with universal JavaScript support. Use initBotId() in SvelteKit, Nuxt, and more to stop the more sophisticat..."
---




Jul 22, 2025

You can now use Vercel BotID to protect your most sensitive endpoints in any JavaScript framework, like SvelteKit and Nuxt.

BotID is our [advanced bot protection](https://vercel.com/blog/introducing-botid) for high-value endpoints like registration, checkout, and AI interactions. Since launch, it has already protected nearly a million API requests.

Installing or upgrading to `botid@1.4.3` adds support for universal JavaScript environments with the new `initBotId({ protect: ... })` function.

Here's an example of `initBotId` used to set up BotID in SvelteKit:

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

Initializing BotID in a SvelteKit project

We recommend using `initBotId()` in `instrumentation-client.ts` for better performance in **Next.js v15.3+**. Earlier versions can continue using the React `<BotIdClient>` component approach.

Check out the [updated documentation](https://vercel.com/docs/botid) for setup instructions across all supported frameworks.