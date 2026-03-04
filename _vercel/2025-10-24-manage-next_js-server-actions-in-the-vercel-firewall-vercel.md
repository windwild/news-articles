---
title: "Manage Next.js Server Actions in the Vercel Firewall - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/manage-next-js-server-actions-in-the-vercel-firewall"
date: "2025-10-24"
scraped_at: "2026-03-02T09:26:34.251595248+00:00"
language: "en-zh"
translated: true
description: "Vercel Firewall and Observability Plus can now configure Custom Rules targeting specific server actions"
---

render_with_liquid: false
Oct 24, 2025

2025 年 10 月 24 日

The Vercel [Firewall](https://vercel.com/docs/vercel-firewall) and [Observability Plus](https://vercel.com/docs/observability/observability-plus) has first-class support for Server Actions.

Vercel [防火墙（Firewall）](https://vercel.com/docs/vercel-firewall) 和 [可观测性增强版（Observability Plus）](https://vercel.com/docs/observability/observability-plus) 现已原生支持 Server Actions。

Starting with [Next.js 15.5](https://nextjs.org/blog/next-15-5), customers can now configure custom rules targeting specific server action names. In the example below, you can rate limit `app/auth/actions.ts#getUser` actions to 100 requests per minute per IP address.

自 [Next.js 15.5](https://nextjs.org/blog/next-15-5) 起，用户现已可配置针对特定 Server Action 名称的自定义规则。如下例所示，您可对 `app/auth/actions.ts#getUser` 这一操作按每个 IP 地址每分钟最多 100 次请求进行速率限制。

![](images/manage-next_js-server-actions-in-the-vercel-firewall-vercel/img_001.jpg)![](images/manage-next_js-server-actions-in-the-vercel-firewall-vercel/img_002.jpg)

```javascript
1// app/auth/actions.ts

2'use server'



export async function getUser(userId: string) {

5  // ...

6}
```

Server Action Name is available in the Firewall for all plans at no additional cost.  

服务器操作名称（Server Action Name）在所有套餐的防火墙中均免费提供。

Read the [docs](https://vercel.com/docs/vercel-firewall/vercel-waf/rule-configuration) to learn more.  

请阅读[文档](https://vercel.com/docs/vercel-firewall/vercel-waf/rule-configuration)了解更多信息。