---
title: "Open source Workflow Development Kit is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/open-source-workflow-dev-kit-is-now-in-public-beta"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:44.106195071+00:00"
language: "en"
translated: false
description: "Turn TypeScript functions into durable, reliable workflows with automatic retries, persistence, and observability built in."
---




Oct 23, 2025

Workflow Development Kit, a framework for building durable, long-running processes, is now in public beta.

Workflow Development Kit brings durability, reliability, and observability to async JavaScript so you can build apps and AI agents that suspend, resume, and maintain state with ease.

Turning functions into durable workflows is made simple by the `"use workflow"` directive:

```typescript
export async function hailRide(requestId: string) {

2  "use workflow";



4  const request = await validateRiderRequest(requestId);

5  const trip = await assignDriver(request);

6  const confirmation = await notifyRider(trip);

7  const receipt = await createReceipt(trip);



9  return receipt;

10}
```

**Key highlights include**:

- **Reliability** by simply adding `"use workflow"` to make async functions durable. No manual wiring of queues, no schedulers, no YAML.

- **Mark Steps** to denote with `"use step"`. Retries are automatic.

- **Durability.** Call `sleep` to pause without holding compute, then resume in place.

- **Built-in observability.** Traces, logs, and metrics for every run. Pause, replay, and time travel while debugging.

- **No lock-in.** Develop locally and deploy to Vercel or any other cloud.


Learn more about [Workflow](https://useworkflow.dev/) or [read the documentation](https://useworkflow.dev/docs/getting-started).