---
title: "Vercel Queues now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-queues-now-in-public-beta"
date: "2026-02-27"
scraped_at: "2026-03-02T09:21:20.957366138+00:00"
language: "en-zh"
translated: true
description: "Customers can now use Vercel Queues in public beta, without any restrictions or needing to be allow listed"
---

Feb 27, 2026

2026 年 2 月 27 日

[Vercel Queues](https://vercel.com/docs/queues) 是一个基于 [Fluid compute](https://vercel.com/docs/fluid-compute) 构建的持久化事件流系统，现已面向所有团队开放公共测试版。Vercel Queues 同时也是 [Workflow](https://vercel.com/docs/workflow) 的底层支撑：可直接使用 Queues 进行消息的发布与消费；而 Workflow 则专为简洁、直观的多步骤编排任务而设计。

函数需要一种可靠的方式，以延迟执行耗时操作，并确保即使在函数崩溃或新版本部署期间，任务仍能最终完成。Queues 让异步消息处理变得简单——它内置自动重试机制与投递保障能力，提供“至少一次”（at-least-once）的消息投递语义。

工作原理如下：

- 消息被发送至一个持久化主题（topic）  
- 队列将消息分发（fan-out）给已订阅的消费者组（consumer groups）  
- 每个消费者组独立处理其接收到的消息  
- 若某条消息未被成功处理，队列将持续将其重新投递给对应消费者组，直至处理成功或消息过期  

**从任意路由处理器（route handler）发布消息：**

app/api/orders/route.ts

```typescript
import { send } from '@vercel/queue';



export async function POST(request: Request) {

4  const order = await request.json();

5  const { messageId } = await send('orders', order);

6  return Response.json({ messageId });

7}
```

```typescript
import { send } from '@vercel/queue';



export async function POST(request: Request) {

4  const order = await request.json();

5  const { messageId } = await send('orders', order);

6  return Response.json({ messageId });

7}
```

**Create a consumer:**

**创建一个消费者：**

app/api/queues/fulfill-order/route.ts

app/api/queues/fulfill-order/route.ts

```typescript
import { handleCallback } from '@vercel/queue';
```

```typescript
import { handleCallback } from '@vercel/queue';
```

```ts
export const POST = handleCallback(async (order, metadata) => {

4  console.log('Fulfilling order', metadata.messageId, order);

5  // await doAnythingAsync(order);

6});
```

```ts
export const POST = handleCallback(async (order, metadata) => {

4  console.log('正在履行订单', metadata.messageId, order);

5  // await doAnythingAsync(order);

6});
```

**Configure the consumer group:**

**配置消费者组：**

vercel.json

vercel.json

```json
1{

2  "functions": {

3    "app/api/queues/fulfill-order/route.ts": {
```

```json
1{

2  "functions": {

3    "app/api/queues/fulfill-order/route.ts": {
```

4      "experimentalTriggers": [{ "type": "queue/v2beta", "topic": "orders" }]

4      “experimentalTriggers”: [{ “type”: “queue/v2beta”, “topic”: “orders” }]

5    }

5    }

6  }

6  }

7}
```

7}
```

Adding a trigger makes the route private: it has no public URL and only Vercel's queue infrastructure can invoke it.

添加触发器会使该路由变为私有：它没有公共 URL，且仅 Vercel 的队列基础设施可调用它。

Vercel Queues is billed per API operation, starting at $0.60 per 1M operations, and includes:

Vercel Queues 按 API 调用次数计费，起价为每 100 万次调用 0.60 美元，并包含以下功能：

- Multiple AZ synchronous replication

- 多可用区（AZ）同步复制

- At-least-once delivery

- 至少一次投递（at-least-once delivery）

- Customizable visibility timeout

- 可自定义的可见性超时（visibility timeout）

- Delayed delivery

- 延迟投递

- Idempotency keys  
- 幂等性密钥

- Concurrency control  
- 并发控制

- Per-deployment topic partitioning  
- 每次部署的 Topic 分区

Functions invoked by Queues in push mode are charged at existing [Fluid compute rates](https://vercel.com/docs/functions/usage-and-pricing).  
以推送模式由 Queues 调用的函数，按现有的 [Fluid 计算费率](https://vercel.com/docs/functions/usage-and-pricing) 收费。

Get started with the [Queues documentation](https://vercel.com/docs/queues).  
请通过查阅 [Queues 文档](https://vercel.com/docs/queues) 开始使用。