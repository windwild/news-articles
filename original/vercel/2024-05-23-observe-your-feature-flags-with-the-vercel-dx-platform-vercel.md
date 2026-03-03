---
title: "Observe your feature flags with the Vercel DX platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/observe-your-feature-flags-with-the-vercel-dx-platform"
date: "2024-05-23"
scraped_at: "2026-03-02T09:44:40.479494529+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 23, 2024

![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_001.jpg)![Flags are directly integrated with Vercel Web Analytics and Runtime Logs.](images/observe-your-feature-flags-with-the-vercel-dx-platform-vercel/img_002.jpg)

The Vercel DX Platform now has a deep understanding of the feature flags you use and create in third-party providers. This beta integration provides better insights into your applications and streamlines your development workflow.

- **Web Analytics integration:** Break down page views and custom events by feature flags in Web Analytics, gaining granular insights into user interactions.

- **Enhanced Log visibility:** The platform now displays feature flags in logs, making it easier to understand the conditions under which errors occur.

- `reportValue`: Reports an evaluated feature flag from the server for runtime logs and Custom Analytics Events (server-side).

- `<FlagValues />`: Surfaces a feature flags value on the client for usage in Analytics.


These features have universal compatibility with any feature flag provider you're already using, like LaunchDarkly, Statsig, or Split, or custom setups.

This update lets users on all plans leverage existing feature flag workflows within the Vercel platform and ship safely with more confidence.

Check out the [documentation](https://vercel.com/docs/workflow-collaboration/feature-flags/integrate-vercel-platform) to learn more.