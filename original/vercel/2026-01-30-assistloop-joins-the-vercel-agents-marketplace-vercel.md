---
title: "AssistLoop joins the Vercel Agents Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/assistloop-joins-the-vercel-agents-marketplace"
date: "2026-01-30"
scraped_at: "2026-03-02T09:21:40.253444170+00:00"
language: "en"
translated: false
description: "AssistLoop is now available in the Vercel Marketplace, making it easy to add AI-powered customer support to Next.js apps deployed on Vercel."
---




Jan 30, 2026

![](images/assistloop-joins-the-vercel-agents-marketplace-vercel/img_001.jpg)![](images/assistloop-joins-the-vercel-agents-marketplace-vercel/img_002.jpg)

[AssistLoop](https://vercel.com/marketplace/assistloop) is now available in the [Vercel Marketplace](https://vercel.com/marketplace) as an AI-powered customer support integration.

The integration connects natively with Vercel, so adding AI-driven customer support takes minutes. With AssistLoop, teams can:

- Install AssistLoop with minimal setup using an Agent ID

- Add AI-powered support directly to Next.js apps

- Train agents on internal docs, FAQs, or knowledge bases

- Customize the assistant to match your brand

- Review conversations and hand off to human support when needed


This integration fits naturally into existing Vercel workflows, with unified billing, automatic environment variables, and no manual configuration. Teams can ship AI-powered support faster without managing separate dashboards or complex setup.

AssistLoop automatically injects `NEXT_PUBLIC_ASSISTLOOP_AGENT_ID` into your project environment. Add the widget script to your site:

widget.tsx

```html
import Script from 'next/script'



3<Script

4  src="https://assistloop.ai/assistloop-widget.js"

5  strategy="afterInteractive"

6  onLoad={() => {

7    window.AssistLoopWidget?.init({

8      agentId: process.env.NEXT_PUBLIC_ASSISTLOOP_AGENT_ID,

9    });

10  }}

11/>


```

AssistLoop automatically injects NEXT\_PUBLIC\_ASSISTLOOP\_AGENT\_ID into your project environment. Just add the widget script to your site:

### Get started

Deploy the [AssistLoop Next.js](https://vercel.com/templates/ai/next-js-assist-loop-template) template from the Marketplace to see it in action.