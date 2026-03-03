---
title: "Vercel Edge Config + LaunchDarkly: Low latency, global feature flags to your favorite frontend framework - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/edge-config-and-launch-darkly"
date: "2023-06-27"
scraped_at: "2026-03-02T09:52:03.991092354+00:00"
language: "en"
translated: false
description: "We're excited to announce a new LaunchDarkly integration to bring low latency, global feature flags to your favorite frontend framework."
---




Jun 27, 2023

We're excited to announce a new [LaunchDarkly integration](https://vercel.com/integrations/launchdarkly) to bring low latency, global feature flags to your favorite [frontend framework](https://vercel.com/docs/frameworks).

Feature flags help your team safely release new code and experiment with changes. [Vercel Edge Config](https://vercel.com/docs/storage/edge-config) helps you instantly read configuration data globally, making it a perfect match for feature flag and experimentation data.

### Vercel Edge Config

Vercel is the lowest-latency host for globally scalable applications using feature flags. By pushing data to every region, before any requests are made, you're able to read data from a Vercel Function or Edge Middleware immediately upon request.

Because data is pushed to every Vercel region at write time, we've seen **most lookups return in** **5 ms or less**, and **99% of reads will return in under 15 ms.**

This speed and global distribution make Edge Config great for:

- A/B testing

- Feature flags

- Maintaining complex and dynamic redirects

- Configuring and updating bespoke request blocking rules, without a redeploy


### Experimentation ecosystem

Developers in industries like retail and ecommerce know that every millisecond counts when it comes to user experiences. Thats why A/B testing while delivering the same page load times is crucial.

Today, we’re introducing an integration with [LaunchDarkly](https://launchdarkly.com/) to further the mission of ease in experimentation and speed and safety in releases.

[**LaunchDarkly integration on Vercel**\\
\\
LaunchDarkly Enterprise customers can install the LaunchDarkly integration to start exporting flag configurations to Vercel Edge Config. \\
\\
Get started](https://vercel.com/integrations/launchdarkly)

The [LaunchDarkly integration](https://vercel.com/docs/storage/edge-config/edge-config-integrations#launchdarkly) syncs the feature flags you have in LaunchDarkly into Edge Config. Then, the newly released [vercel-server-sdk package](https://www.npmjs.com/package/@launchdarkly/vercel-server-sdk) bootstraps a LaunchDarkly client from those flags. You can then consume them from Edge Config instead of fetching from LaunchDarkly, meaning your flags are instantly available.

app/page.tsx

```javascript
import { init } from '@launchdarkly/vercel-server-sdk'

import { createClient } from '@vercel/edge-config'

import { Dashboard, LegacyDashboard } from "./dashboards"



const edgeClient = createClient(process.env.EDGE_CONFIG)

const ldClient = init("YOUR CLIENT-SIDE ID", edgeClient)



export const runtime = "edge"



export default async function Home() {

11  await ldClient.waitForInitialization()

12  const ldContext = { kind: 'org', key: 'my-org-key' }

13  const showNewDashboard = await ldClient.variation('new-dashboard', ldContext, true)



15  return showNewDashboard ? <Dashboard /> : <LegacyDashboard />

16}
```

This lower latency is especially critical in a serverless world. Since compute is short lived, you can’t fetch once and then subscribe to updates like you would on a long running server.

> “The The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users.The combination of Vercel Edge Config and the LaunchDarkly integration for Vercel lets us update our feature flagging configurations comfortably and automatically push them to our Edge Config store in real time. We are able to change the UI and behavior of our application without the need to re-deploy, which keeps us highly flexible. The low latency that Edge Config provides reduces the overhead of fetching flag configurations over HTTP, allowing us to have minimal latency and create a better experience for our users.”
>
> ![](images/vercel-edge-config-launchdarkly-low-latency-global-feature-flags-to-your-favorit/img_001.png)
>
> **Vincent Derks,** Lead Engineer at Joyn

Vercel Edge Config provides a unique combination of active global replication with near-instant reads. In combination with LaunchDarkly, this allows users like Joyn to update their UI in seconds with almost zero added latency.

### **Get started**

Visit the [LaunchDarkly integration](https://vercel.com/integrations/launchdarkly) or [template](https://vercel.com/templates/next.js/feature-flag-launchdarkly) to get started or check out the [Edge Config documentation](https://vercel.com/docs/storage/edge-config) to learn more.

Vercel Template

Deploy this template

### Learn how to set up the LaunchDarkly integration to read flags from Edge Config

LaunchDarkly Integration example

Vercel.com landing page

### LaunchDarkly integration