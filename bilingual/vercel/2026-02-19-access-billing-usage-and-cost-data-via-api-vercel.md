---
title: "Access billing usage and cost data via API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/access-billing-usage-cost-data-api"
date: "2026-02-19"
scraped_at: "2026-03-02T09:21:28.051170589+00:00"
language: "en-zh"
translated: true
description: "Vercel now supports programmatic access to billing usage and cost data through the API and CLI, and we're introducing a new native integration that connects Vercel teams to Vantage accounts."
---

Feb 19, 2026

2026 年 2 月 19 日

Vercel 现在通过 API 和 CLI 提供对账单用量及成本数据的编程式访问。全新的 `/billing/charges` 接口以 [FOCUS v1.3 开放标准格式](https://focus.finops.org/) 返回数据，使团队无需编写自定义转换逻辑，即可将成本数据接入 FinOps 工具。

该接口支持按天粒度查询，最大时间跨度为一年。响应数据以换行符分隔的 JSON（JSONL）格式流式返回，从而高效处理大规模数据集。

**SDK 使用方式**

```typescript
import { Vercel } from "@vercel/sdk";

const vercel = new Vercel({
  bearerToken: "<YOUR_BEARER_TOKEN_HERE>",
});
```

```javascript
async function run() {

8  const result = await vercel.billing.listBillingCharges({

9    from: "2025-01-01T00:00:00.000Z",

10    to: "2025-01-31T00:00:00.000Z",

11    teamId: "team_1a2b3c4d5e6f7g8h9i0j1k2l",

12    slug: "my-team-url-slug",

13  });



15  for await (const event of result) {

16    // Handle the event

异步函数 run() {

8  const result = await vercel.billing.listBillingCharges({

9    from: "2025-01-01T00:00:00.000Z",

10    to: "2025-01-31T00:00:00.000Z",

11    teamId: "team_1a2b3c4d5e6f7g8h9i0j1k2l",

12    slug: "my-team-url-slug",

13  });



15  for await (const event of result) {

16    // 处理该事件
```

17    console.log(event);

17    console.log(event);

18  }

18  }

19}

19}

run();
```

run();
```

`curl` **usage**

`curl` **用法**

```bash
curl -N --request GET \

curl -N --request GET \

2  --url 'https://api.vercel.com/v1/billing/charges?teamId=<team>' \

2  --url 'https://api.vercel.com/v1/billing/charges?teamId=<team>' \

3  --header 'Authorization: Bearer <token>' \

3  --header 'Authorization: Bearer <token>' \

4  --header 'Accept-Encoding: gzip' \

4  --header 'Accept-Encoding: gzip' \

5  --compressed
```

5  --compressed
```

**CLI usage**

**CLI 使用方法**

For quick introspection, the `vercel usage` command displays billing usage for the current period or a custom date range. This includes credit-use and costs for each service.

如需快速查看账单使用情况，可使用 `vercel usage` 命令，它将显示当前计费周期或自定义日期范围内的用量信息，涵盖每项服务所消耗的额度及对应费用。

**View usage for the current billing period**

**查看当前计费周期的用量**

```bash
vercel usage
```

```bash
vercel usage
```

**View usage for a custom date range**

**查看自定义日期范围的用量**

```bash
vercel usage --from 2025-01-01 --to 2025-01-31
```

```bash
vercel usage --from 2025-01-01 --to 2025-01-31
```

Vantage has also released a native integration that connects Vercel teams to Vantage accounts. This automatically syncs usage and cost data alongside other tools, simplifying cost observability. Read the [Vantage announcement blog](https://www.vantage.sh/blog/vercel-cost-management) for details.

Vantage 还推出了原生集成方案，可将 Vercel 团队与 Vantage 账户直接关联。该集成会自动同步用量与成本数据，并与其他工具协同工作，从而简化成本可观测性。详情请参阅 [Vantage 官方公告博客](https://www.vantage.sh/blog/vercel-cost-management)。

Learn more in the [API documentation](https://docs.vercel.com/docs/rest-api/reference/endpoints/billing/list-focus-billing-charges) and [CLI reference](https://vercel.com/docs/cli/usage).

更多详细信息，请参阅 [API 文档](https://docs.vercel.com/docs/rest-api/reference/endpoints/billing/list-focus-billing-charges) 和 [CLI 参考手册](https://vercel.com/docs/cli/usage)。