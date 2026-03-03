---
title: "Introducing feature flag management from the Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/toolbar-feature-flags"
date: "2024-03-06"
scraped_at: "2026-03-02T09:46:34.616791689+00:00"
language: "en"
translated: false
description: "Uplevel your flags workflow with the Vercel Toolbar"
---




Mar 6, 2024

View and override feature flags from Optimizely, LaunchDarkly, Statsig, Split, Hypertune, and more.

Using feature flags to quickly enable and disable product features is more than just a development technique; it's a philosophy that drives innovation and ensures that only the best, most performant features reach your users.

However, when working on a new feature you need to leave your current browser tab, sign into your flag provider, switch the flag to the value you need for development—all while coordinating and communicating this change with teammates. This adds a lot of overhead and disrupts your work.

Today, we’re making that workflow easier by adding the ability for team members to [override your application’s feature flags](https://vercel.com/docs/workflow-collaboration/feature-flags) right from the Vercel Toolbar.

You can manage flags set in any provider including [LaunchDarkly](https://launchdarkly.com/), [Optimizely](https://www.optimizely.com/), [Statsig](https://www.statsig.com/), [Hypertune](https://www.hypertune.com/), or [Split](https://www.split.io/)—and additionally you can integrate any other provider or even your own custom flag setup. By creating overrides for your flags from the toolbar, you can stay in the flow and improve your iteration speed.

![](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_001.jpg)![](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_002.jpg)

## Uplevel your flags workflow

Since the ability to manage your flags from the toolbar relies on API Routes and script tags only, it’s possible to integrate with any framework.

Vercel will be able to read the actual value each flag has by rendering a script tag containing your flag values, and flag metadata and descriptions can be communicated through an API route. From there you can create overrides per session for improved QA and testing.

**Getting started**

You can add the Vercel Toolbar to any deployment you’re working on, meaning you can work with your flags in local, preview, or production environments to improve your QA and testing workflow.

[**Working with the Vercel Toolbar**\\
\\
To enable the toolbar on production or local environments, add it to your project using the @vercel/toolbar package, or with an injection script.\\
\\
Learn more](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost)

Next, you’ll need to tell the toolbar about the values of your feature flags.

For the toolbar to see your feature flags, render a script tag containing your flag values. In React for example, you can use the `FlagValues` component from `@vercel/flags`.

```tsx
import { FlagValues } from "@vercel/flags/react"



3<FlagValues values={{ fasterCheckoutPage: true, landingPageRedesign: true }} />
```

Then, you’ll work with `FlagDefinitions` to tell the toolbar about your application’s feature flags, complete with rich metadata.

```tsx
1// .well-known/vercel/flags/route.ts

import { getLaunchDarklyData } from '@vercel/flags/providers/launchdarkly';

import { NextResponse } from 'next/server';



export async function GET() {

6  const launchDarklyData = await getLaunchDarklyData({

7    apiKey: process.env.LAUNCHDARKLY_API_KEY,

8    projectKey: process.env.LAUNCHDARKLY_PROJECT_KEY,

9    environment: process.env.LAUNCHDARKLY_ENVIRONMENT,

10  });

11  return NextResponse.json(launchDarklyData);

12}


```

After that, you can respect overrides set in the toolbar by reading the `vercel-flag-overrides` cookie.

```javascript
import { cookies } from 'next/headers';



export default function Page() {

4  const overrides = cookies().get('vercel-flag-overrides')?.value;

5  return overrides.showNewDashboard ? <NewDashboard /> : <LegacyDashboard />;

6}


```

From the Vercel Toolbar you can view and create overrides, per session, for shorter feedback loops and improved QA and testing. Additionally, the overrides will be stored in an optionally [encrypted cookie](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#encrypting-feature-flag-values) so your application can respect them.

![Set the override for each flag to true and press Save.](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_003.jpg)![Set the override for each flag to true and press Save.](images/introducing-feature-flag-management-from-the-vercel-toolbar-vercel/img_004.jpg)Set the override for each flag to true and press Save.

### Ship better features faster on Vercel

Publishing features behind feature flags and allowing QA teams to test them in a production-like environment enhances trust in the release process and allows teams to ship the best features to users.

With Vercel, you eliminate the need for complex coordination between multiple QA teams and automated testing processes, saving valuable time and resources.

[**Start interacting with your application’s feature flags.**\\
\\
Unlock the new workflow today: Use the Vercel Toolbar to read and set feature flag overrides for your application.\\
\\
Get started](https://vercel.com/docs/workflow-collaboration/feature-flags/using-vercel-toolbar)