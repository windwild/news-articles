---
title: "Microfrontends support is now in Public Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/microfrontends-support-is-now-in-public-beta"
date: "2025-08-06"
scraped_at: "2026-03-02T09:30:15.015733062+00:00"
language: "en"
translated: false
description: "Vercel's microfrontends support is now in public beta allowing users to split large applications to develop faster."
---




Aug 6, 2025

[Microfrontends](https://vercel.com/docs/microfrontends) support is now available in [Public Beta](https://vercel.com/docs/release-phases#public-beta). Microfrontends allow you to split large applications into smaller ones so that developers can move more quickly.

This support lets teams and large apps build and test independently, while Vercel assembles and routes the app into a single experience. This reduces build times, supports parallel development, and enables gradual legacy migration.

Developers can use the [Vercel Toolbar](https://vercel.com/docs/microfrontends/managing-microfrontends/vercel-toolbar) to iterate and test their apps independently, while navigations between microfrontends benefit from [prefetching and prerendering](https://vercel.com/docs/microfrontends/managing-microfrontends#optimizing-navigations-between-microfrontends) for fast transitions between the applications.

To get started with microfrontends, clone [one of our examples](https://vercel.com/templates/microfrontends) or follow the [quickstart](https://vercel.com/docs/microfrontends/quickstart) guide:

1. In the Vercel dashboard, navigate to the [Microfrontends tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F~%2Fsettings%2Fmicrofrontends&title=Try+Microfrontends) in Settings

2. Create a microfrontends group containing all of your microfrontend projects

3. Add the `@vercel/microfrontends` [package](https://npmjs.org/@vercel/microfrontends) to each microfrontend application

4. Add a `microfrontends.json` configuration file to the default app, test in Preview, and deploy to Production when ready


microfrontends.json

```json
1{

2  "dashboard": {},

3  "docs": {

4    "routing": [{\
\
5      "paths": ["/docs", "/docs/:path*"]\
\
6    }]

7  }],

8  "marketing": {

9    "routing": [{\
\
10      "paths": ["/home", "/pricing"]\
\
11    }]

12  }

13}
```

Microfrontends configuration file routing paths to three different applications

Learn more about microfrontends in [our docs](https://vercel.com/docs/microfrontends), or [contact Vercel](https://vercel.com/contact/sales) or your account team directly for more information.