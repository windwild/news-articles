---
title: "Manage Next.js Server Actions in the Vercel Firewall - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/manage-next-js-server-actions-in-the-vercel-firewall"
date: "2025-10-24"
scraped_at: "2026-03-02T09:26:34.251595248+00:00"
language: "en"
translated: false
description: "Vercel Firewall and Observability Plus can now configure Custom Rules targeting specific server actions"
---




Oct 24, 2025

The Vercel [Firewall](https://vercel.com/docs/vercel-firewall) and [Observability Plus](https://vercel.com/docs/observability/observability-plus) has first-class support for Server Actions.

Starting with [Next.js 15.5](https://nextjs.org/blog/next-15-5), customers can now configure custom rules targeting specific server action names. In the example below, you can rate limit `app/auth/actions.ts#getUser` actions to 100 requests per minute per IP address.

![](images/manage-next_js-server-actions-in-the-vercel-firewall-vercel/img_001.jpg)![](images/manage-next_js-server-actions-in-the-vercel-firewall-vercel/img_002.jpg)

```javascript
1// app/auth/actions.ts

2'use server'



export async function getUser(userId: string) {

5  // ...

6}
```

Server Action Name is available in the Firewall for all plans at no additional cost. Read the [docs](https://vercel.com/docs/vercel-firewall/vercel-waf/rule-configuration) to learn more.