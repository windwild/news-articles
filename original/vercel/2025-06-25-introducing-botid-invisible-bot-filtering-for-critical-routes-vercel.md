---
title: "​Introducing BotID, invisible bot filtering for critical routes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-botid"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:44.338365155+00:00"
language: "en"
translated: false
description: "BotID is a new invisible CAPTCHA layer of protection that stops sophisticated bots before they reach your backend. It's built to secure critical routes like checkouts, logins, and signups or actions t..."
---




Jun 25, 2025

Modern sophisticated bots don’t look like bots. They execute JavaScript, solve CAPTCHAs, and navigate interfaces like real users. Tools like Playwright and Puppeteer can script human-like behavior from page load to form submission.

Traditional defenses like checking headers or rate limits aren't enough. Bots that blend in by design are hard to detect and expensive to ignore.

Enter BotID: A new layer of protection on Vercel.

Think of it as an invisible CAPTCHA to stop browser automation before it reaches your backend. It’s built to protect critical routes where automated abuse has real cost such as checkouts, logins, signups, APIs, or actions that trigger expensive backend operations like LLM-powered endpoints.

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

## How BotID works

BotID is available in two modes: Basic (enabled by default) and Deep Analysis, which adds advanced detection checks.

Detection starts at the session level. BotID injects lightweight, obfuscated code into the requester’s environment that evolves on every load and is designed to resist replay, tampering, and static analysis. It runs invisibly with no CAPTCHAs or changes to the user experience.

Unlike traditional defenses, BotID doesn’t rely on static signals like user-agent headers or IP ranges, which are easy to fake and become outdated. It also avoids more intrusive methods like CAPTCHAs, heuristics, and reputation scores, which can frustrate or block real users.

Instead, BotID counters the most advanced bots by:

- Silently collecting thousands of signals that distinguish human users from bot

- Mutating detection logic on every load to prevent reverse engineering and making spoofing difficult

- Feeding attack patterns into a global machine learning network that continuously improves protection for all


BotID is fast, reliable, and built for developers. Server-side verification takes a single function call. There's nothing to configure, no API keys to manage, and no scores or thresholds to tune. Requests that are tested for validation are returned with an unambiguous pass or fail answer.

## Deep Analysis powered by Kasada

BotID with Deep Analysis is powered by [Kasada](https://www.kasada.io/), whose detection engine protects some of the most targeted platforms on the internet. Their system is hardened against real-world adversaries: bots that retool quickly, replay sessions, and adapt to static defenses.

Because Kasada is integrated directly into the Vercel platform, there’s no separate service to sign up or set up. Just install the package, define routes you want to block automation on, and deploy.

We've been using Kasada’s enterprise-grade defenses to protect our own high-value apps, like [v0.dev](https://v0.dev/), for a while now. Now you can do the same. Kasada’s detection runs automatically with your deployment, bringing enterprise-grade protection to your most critical routes.

## BotID: For teams of all sizes

BotID is designed for teams dealing with targeted automation that slips past conventional defenses. These aren’t generic bots, they behave like real users, and move through high-value flows, creating real cost when left unchecked.

That might look like scalpers attacking limited checkouts, fake accounts flooding signups, or credential stuffing targeting login endpoints. It also includes scraping against dashboards, pricing pages, or APIs that expose business logic or drive up compute.

BotID is built to protect the parts of your app that matter most, without getting in the way of actual users.

## Available now

We already protect against automated traffic with platform-level protections like DDoS mitigation, WAF rules, and bot challenges for non-browser clients. BotID extends that protection as a new sophisticated layer designed to block automation that mimics real users targeting the most critical routes.

BotID is available now for all teams, with Deep Analysis powered by Kasada available for Pro and Enterprise teams.

[**Get started with Vercel BotID**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes like login, checkout, AI agents, and APIs. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/docs/botid/get-started)