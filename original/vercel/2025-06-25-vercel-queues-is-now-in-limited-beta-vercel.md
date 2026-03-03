---
title: "Vercel Queues is now in Limited Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-queues-is-now-in-limited-beta"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:46.610089198+00:00"
language: "en"
translated: false
description: "Vercel Queues is a message queue service for Vercel apps, now in Limited Beta. It enables background task processing using an append-only log for reliability, with support for pub/sub messaging, strea..."
---




Jun 25, 2025

Vercel Queues is a message queue service built for Vercel applications, in Limited Beta.

Vercel Queues lets you offload work by sending tasks to a queue, where they’ll be processed in the background. This means users don’t have to wait for slow operations to finish during a request, and your app can handle retries and failures more reliably.

Under the hood, Vercel Queues uses an append-only log to store messages and ensures tasks such as AI video processing, sending emails, or updating external services are persisted and never lost.

**Key features of Vercel Queues:**

- **Pub/Sub pattern:** Topic-based messaging allowing for multiple consumer groups

- **Streaming support**: Handle payloads without loading them entirely into memory

- **Streamlined auth**: Automatic authentication via OIDC tokens

- **SDK**: TypeScript SDK with full type safety


```tsx
import { send, receive } from "@vercel/queue";



await send("topic", { message: "Hello World!" });



await receive("topic", "consumer", (m) => {

6  console.log(m.message); // Logs "Hello World!"

7});
```

An example of sending and receiving message with a queue.

If you have any questions, let us know in the [Vercel Community](https://community.vercel.com/).