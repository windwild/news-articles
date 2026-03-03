---
title: "Access billing usage and cost data via API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-billing-usage-cost-data-api"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.051170589+00:00"
language: "en"
translated: false
description: "Vercel now supports programmatic access to billing usage and cost data through the API and CLI, and we're introducing a new native integration that connects Vercel teams to Vantage accounts."
---




Feb 19, 2026

Vercel now supports programmatic access to billing usage and cost data through the API and CLI. The new `/billing/charges` endpoint returns data in the [FOCUS v1.3 open-standard format](https://focus.finops.org/), allowing teams to ingest cost data into FinOps tools without custom transformation logic.

The endpoint supports 1-day granularity with a maximum date range of one year. Responses are streamed as newline-delimited JSON (JSONL) to handle large datasets efficiently.

**SDK usage**

```typescript
import { Vercel } from "@vercel/sdk";



const vercel = new Vercel({

4  bearerToken: "<YOUR_BEARER_TOKEN_HERE>",

5});



async function run() {

8  const result = await vercel.billing.listBillingCharges({

9    from: "2025-01-01T00:00:00.000Z",

10    to: "2025-01-31T00:00:00.000Z",

11    teamId: "team_1a2b3c4d5e6f7g8h9i0j1k2l",

12    slug: "my-team-url-slug",

13  });



15  for await (const event of result) {

16    // Handle the event

17    console.log(event);

18  }

19}

run();
```

`curl` **usage**

```bash
curl -N --request GET \

2  --url 'https://api.vercel.com/v1/billing/charges?teamId=<team>' \

3  --header 'Authorization: Bearer <token>' \

4  --header 'Accept-Encoding: gzip' \

5  --compressed
```

**CLI usage**

For quick introspection, the `vercel usage` command displays billing usage for the current period or a custom date range. This includes credit-use and costs for each service.

**View usage for the current billing period**

```bash
vercel usage
```

**View usage for a custom date range**

```bash
vercel usage --from 2025-01-01 --to 2025-01-31
```

Vantage has also released a native integration that connects Vercel teams to Vantage accounts. This automatically syncs usage and cost data alongside other tools, simplifying cost observability. Read the [Vantage announcement blog](https://www.vantage.sh/blog/vercel-cost-management) for details.

Learn more in the [API documentation](https://docs.vercel.com/docs/rest-api/reference/endpoints/billing/list-focus-billing-charges) and [CLI reference](https://vercel.com/docs/cli/usage).