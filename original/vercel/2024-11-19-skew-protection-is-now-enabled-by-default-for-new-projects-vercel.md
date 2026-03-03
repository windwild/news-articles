---
title: "Skew Protection is now enabled by default for new projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/skew-protection-is-now-enabled-by-default-for-new-projects"
date: "2024-11-19"
scraped_at: "2026-03-02T09:39:22.161377095+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Nov 19, 2024

![](images/skew-protection-is-now-enabled-by-default-for-new-projects-vercel/img_001.jpg)![](images/skew-protection-is-now-enabled-by-default-for-new-projects-vercel/img_002.jpg)

[Skew Protection](https://vercel.com/docs/deployments/skew-protection) eliminates version differences between web clients and servers—available for Pro and Enterprise customers. Starting today, new projects will have Skew Protection enabled by default.

Existing projects will not be changed, however you can manually enable Skew Protection in the project's settings.

Skew Protection ensures client-side code matches the server-side code for the corresponding deployment for a period of time or until a hard page refresh. This protects from version mismatch errors when creating a new deployment, such as file name changes from hashed bundles or even post backs from Server Actions.

Learn more about [Skew Protection](https://vercel.com/docs/deployments/skew-protection).