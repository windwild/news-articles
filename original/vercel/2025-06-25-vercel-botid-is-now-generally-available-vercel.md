---
title: "Vercel BotID is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-botid-is-now-generally-available"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:51.240170645+00:00"
language: "en"
translated: false
description: "Vercel BotID is now generally available. BotID is an advanced bot detection package powered by Kasada."
---




Jun 25, 2025

Vercel BotID is an invisible CAPTCHA with no visible challenges or manual bot management required.

BotID is a new protection layer on Vercel designed for public, high-value routes such as checkouts, signups, AI chat interfaces, LLM-powered endpoints, and public APIs that are targets for sophisticated bots mimicking real user behavior.

Unlike IP-based or heuristic systems, BotID:

- Silently collects thousands of signals that distinguish human users from bot

- Mutates these detections on every page load, evading reverse engineering and sophisticated bypasses

- Streams attack data into a global machine learning mesh, collectively strengthening protection for all customers


Powered by [Kasada](https://kasada.io/), BotID integrates into your application with a [type-safe SDK](https://www.npmjs.com/package/botid):

- Client-side detection using the `<BotIdClient>` component

- Server-side verification with the `checkBotId` function

- Automatic labeling of logs and telemetry for blocked sessions


```tsx
import { checkBotId } from "botid/server";



export async function POST(req: Request) {

4  const { isBot } = await checkBotId();



6  if (isBot) {

7    return new Response("Access Denied", { status: 403 });

8  }



10  const result = await expensiveOrCriticalOperation();



12  return new Response("Success!");

13}
```

Setup is simple with no config files or tuning required. Install the package, setup rewrites, mount the client, and verify requests server-side.

BotID traffic is visible in the Firewall dashboard and can be filtered by verdict (pass or fail), user agent, country, IP address, request path, target path, JA4 digest, and host.

Read the [announcement](https://vercel.com/blog/introducing-botid) or [documentation](https://vercel.com/docs/botid) to learn more, or try BotID today.

[**Get started with Vercel BotID**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes like login, checkout, AI agents, and APIs. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/docs/botid/get-started)