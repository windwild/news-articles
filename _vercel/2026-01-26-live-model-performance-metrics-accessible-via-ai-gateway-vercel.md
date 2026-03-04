---
title: "Live model performance metrics accessible via AI Gateway - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/live-model-performance-metrics-accessible-via-ai-gateway"
date: "2026-01-26"
scraped_at: "2026-03-02T09:22:06.712034954+00:00"
language: "en-zh"
translated: true
description: "You can now view live model performance metrics for latency and throughput on Vercel AI Gateway on the website and via REST API."
---

render_with_liquid: false
Jan 26, 2026

2026 年 1 月 26 日

AI Gateway 现在展示涵盖数百种模型的吞吐量（throughput）与延迟（latency）指标，助您基于实时性能数据选择最合适的模型。

这些指标在三个位置呈现，并每小时更新一次：

- **模型列表（Model list）**：各模型的最佳性能指标（P50 延迟与吞吐量）

- **模型详情页（Model detail pages）**：按供应商（provider）维度拆解的性能表现

- **REST API**：滚动式端点性能聚合数据（延迟与吞吐量，含 P50/P95 分位值）

### Model list

### 模型列表

AI Gateway 的[模型列表](https://vercel.com/ai-gateway/models)现已支持对延迟和吞吐量列进行排序。每一行显示该模型在所有可用供应商中所达到的最佳 P50 指标（即最低延迟、最高吞吐量）。所有指标均每小时更新一次，数据来源为 AI Gateway 实际客户发出的实时请求。

![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_001.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_002.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_001.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_002.jpg)

按吞吐量排序，可快速定位生成 token 速度最快的模型；按延迟排序，则可筛选出首 token 返回时间（time-to-first-token）最短的模型。

### Model detail pages

### 模型详情页

On the individual model pages, you can see P50 latency and throughput for each provider that has recorded usage. This helps you compare provider performance for the same model and choose the best option for your use case.

在各个模型的独立详情页上，您可以查看每个已记录使用数据的提供商对应的 P50 延迟和吞吐量。这有助于您横向比较同一模型在不同提供商处的性能表现，从而为您的具体应用场景选择最优方案。

To access these pages, click on any model in the [model list](https://vercel.com/ai-gateway/models) to get a more detailed view of the breakdown across all the providers that carry the model in AI Gateway. Metrics are refreshed hourly and only appear for providers with sufficient traffic.

要访问这些页面，请点击 [模型列表](https://vercel.com/ai-gateway/models) 中的任意一个模型，即可查看该模型在 AI Gateway 所支持的所有提供商上的详细性能分布。各项指标每小时刷新一次，且仅对流量达到一定阈值的提供商显示。

Here is an example for [openai/gpt-oss-120b](https://vercel.com/ai-gateway/models/gpt-oss-120b):

以下是 [openai/gpt-oss-120b](https://vercel.com/ai-gateway/models/gpt-oss-120b) 的示例：

![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_005.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_006.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_005.jpg)![](images/live-model-performance-metrics-accessible-via-ai-gateway-vercel/img_006.jpg)

Similar to the overall model list, you can sort by latency and throughput across providers on the model detail pages.

与整体模型列表类似，您也可以在模型详情页上按延迟和吞吐量对各提供商进行排序。

### REST API

### REST API

These metrics are also available programmatically via the endpoints REST API. To use this, replace `[ai-gateway-string]` with the `creator/model-name` for the model of interest.

这些指标还可通过 endpoints REST API 以编程方式获取。使用时，请将 `[ai-gateway-string]` 替换为您所关注模型的 `creator/model-name`。

```bash
curl ai-gateway.vercel.sh/v1/models/[ai-gateway-string]/endpoints
```

```bash
curl ai-gateway.vercel.sh/v1/models/[ai-gateway-string]/endpoints
```

This returns live hourly P50 and P95 latency (ms TTFT) and throughput (T/s) for the specified model, by provider. Here is an example output from the endpoint for the Cerebras provider for [zai/glm-4.7](https://ai-gateway.vercel.sh/v1/models/zai/glm-4.7/endpoints).

该接口将按提供商返回指定模型的实时每小时指标：P50 与 P95 延迟（单位：毫秒，TTFT）以及吞吐量（单位：token/秒）。以下是从 Cerebras 提供商调用 [zai/glm-4.7](https://ai-gateway.vercel.sh/v1/models/zai/glm-4.7/endpoints) 对应接口所获得的示例响应。

```bash
curl ai-gateway.vercel.sh/v1/models/zai/glm-4.7/endpoints
```

```bash
curl ai-gateway.vercel.sh/v1/models/zai/glm-4.7/endpoints
```

```json
1      {

2        "name": "cerebras | zai/glm-4.7",

3        "latency_last_1h": {

4          "p50": 456.5,

5          "p95": 774.95

6        },

7        "throughput_last_1h": {

8          "p50": 354,

9          "p95": 445.45
```

```json
1      {

2        "name": "cerebras | zai/glm-4.7",

3        "latency_last_1h": {

4          "p50": 456.5,

5          "p95": 774.95

6        },

7        "throughput_last_1h": {

8          "p50": 354,

9          "p95": 445.45
```

10        },

11      }
```

If you want to query the full list of models, you can also use the model metrics endpoint in conjunction with [https://ai-gateway.vercel.sh/v1/models](https://ai-gateway.vercel.sh/v1/models).

如果您希望查询模型的完整列表，您还可以将模型指标（model metrics）端点与 [https://ai-gateway.vercel.sh/v1/models](https://ai-gateway.vercel.sh/v1/models) 结合使用。