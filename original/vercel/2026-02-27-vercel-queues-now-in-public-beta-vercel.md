---
title: "Vercel Queues now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-queues-now-in-public-beta"
date: "2026-02-27"
scraped_at: "2026-03-02T09:21:20.957366138+00:00"
language: "en"
translated: false
description: "Customers can now use Vercel Queues in public beta, without any restrictions or needing to be allow listed"
---




Feb 27, 2026

[Vercel Queues](https://vercel.com/docs/queues) is a durable event streaming system built with [Fluid compute](https://vercel.com/docs/fluid-compute), and is now available in public beta for all teams. Vercel Queues also powers [Workflow](https://vercel.com/docs/workflow): use Queues for direct message publishing and consumption, Workflow for ergonomic multi step orchestration.

Functions need a reliable way to defer expensive work and guarantee that tasks complete even when functions crash or new deployments roll out. Queues makes it simple to process messages asynchronously with automatic retries and delivery guarantees, providing at-least-once delivery semantics.

How it works:

- Messages are sent to a durable topic

- The queue fans messages out to subscribed consumer groups.

- Each consumer group processes messages independently.

- The queue redelivers messages to consumer groups until successfully processed or expired.


**Publish messages from any route handler:**

app/api/orders/route.ts

```typescript
import { send } from '@vercel/queue';



export async function POST(request: Request) {

4  const order = await request.json();

5  const { messageId } = await send('orders', order);

6  return Response.json({ messageId });

7}
```

**Create a consumer:**

app/api/queues/fulfill-order/route.ts

```typescript
import { handleCallback } from '@vercel/queue';



export const POST = handleCallback(async (order, metadata) => {

4  console.log('Fulfilling order', metadata.messageId, order);

5  // await doAnythingAsync(order);

6});
```

**Configure the consumer group:**

vercel.json

```json
1{

2  "functions": {

3    "app/api/queues/fulfill-order/route.ts": {

4      "experimentalTriggers": [{ "type": "queue/v2beta", "topic": "orders" }]

5    }

6  }

7}
```

Adding a trigger makes the route private: it has no public URL and only Vercel's queue infrastructure can invoke it.

Vercel Queues is billed per API operation, starting at $0.60 per 1M operations, and includes:

- Multiple AZ synchronous replication

- At-least-once delivery

- Customizable visibility timeout

- Delayed delivery

- Idempotency keys

- Concurrency control

- Per-deployment topic partitioning


Functions invoked by Queues in push mode are charged at existing [Fluid compute rates](https://vercel.com/docs/functions/usage-and-pricing).

Get started with the [Queues documentation](https://vercel.com/docs/queues).