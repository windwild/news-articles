---
title: "Open source Workflow Development Kit is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/open-source-workflow-dev-kit-is-now-in-public-beta"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:44.106195071+00:00"
language: "en-zh"
translated: true
description: "Turn TypeScript functions into durable, reliable workflows with automatic retries, persistence, and observability built in."
---
{% raw %}

Oct 23, 2025

2025 年 10 月 23 日

Workflow Development Kit，一个用于构建持久化、长时间运行流程的框架，现已进入公开测试阶段。

Workflow Development Kit 为异步 JavaScript 带来了持久性、可靠性和可观测性，使您能够轻松构建支持挂起、恢复及状态保持的应用程序与 AI 智能体。

通过 `"use workflow"` 指令，即可轻松将普通函数转化为持久化工作流：

```typescript
export async function hailRide(requestId: string) {

2  "use workflow";



4  const request = await validateRiderRequest(requestId);

5  const trip = await assignDriver(request);

6  const confirmation = await notifyRider(trip);
```

7  const receipt = await createReceipt(trip);



9  return receipt;

10}
```

**Key highlights include**

**主要亮点包括**：

- **Reliability** by simply adding `"use workflow"` to make async functions durable. No manual wiring of queues, no schedulers, no YAML.

- **可靠性**：只需添加 `"use workflow"` 即可使异步函数具备持久性，无需手动配置消息队列、调度器或编写 YAML 文件。

- **Mark Steps** to denote with `"use step"`. Retries are automatic.

- **标记步骤**：使用 `"use step"` 显式标注步骤，重试机制自动生效。

- **Durability.** Call `sleep` to pause without holding compute, then resume in place.

- **持久性**：调用 `sleep` 可暂停执行而不占用计算资源，并可在原地恢复执行。

- **Built-in observability.** Traces, logs, and metrics for every run. Pause, replay, and time travel while debugging.

- **内置可观测性**：每次运行均自动生成追踪（traces）、日志（logs）和指标（metrics）；调试时支持暂停、重放及“时间旅行”（time travel）功能。

- **No lock-in.** Develop locally and deploy to Vercel or any other cloud.

- **无厂商锁定**：本地开发，可自由部署至 Vercel 或任意其他云平台。

Learn more about [Workflow](https://useworkflow.dev/) or [read the documentation](https://useworkflow.dev/docs/getting-started).

了解更多关于 [Workflow](https://useworkflow.dev/) 的信息，或 [查阅文档](https://useworkflow.dev/docs/getting-started)。
{% endraw %}
