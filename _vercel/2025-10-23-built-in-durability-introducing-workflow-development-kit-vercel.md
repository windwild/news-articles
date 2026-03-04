---
render_with_liquid: false
title: "Built-in durability: Introducing Workflow Development Kit - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-workflow"
date: "2025-10-23"
scraped_at: "2026-03-02T09:26:41.890468455+00:00"
language: "en-zh"
translated: true
description: "The Workflow Development Kit (WDK) makes async workflows in TypeScript reliable, durable, fault-tolerant, and portable across any cloud."
---
render_with_liquid: false
render_with_liquid: false

Oct 23, 2025

2025 年 10 月 23 日

Building reliable software shouldn't require mastering distributed systems.

构建可靠的软件不应以掌握分布式系统为前提。

Yet for developers building AI agents or data pipelines, making async functions reliable typically requires message queues, retry logic, and persistence layers. Adding that infrastructure often takes longer than writing the actual business logic.

然而，对于正在构建 AI 智能体或数据流水线的开发者而言，要让异步函数具备可靠性，通常需引入消息队列、重试逻辑和持久化层。搭建这类基础设施所耗费的时间，往往远超编写实际业务逻辑本身。

The [Workflow Development Kit (WDK)](https://useworkflow.dev/) is an open source TypeScript framework that makes durability a language-level concept. It runs on any framework, platform, and runtime. Functions can pause for minutes or months, survive deployments and crashes, and resume exactly where they stopped.

[工作流开发工具包（Workflow Development Kit，WDK）](https://useworkflow.dev/) 是一个开源 TypeScript 框架，它将“持久性”（durability）提升为语言层面的一等概念。WDK 可运行于任意框架、平台和运行时环境。函数可暂停数分钟乃至数月，能经受住部署更新与系统崩溃的考验，并在中断处精确恢复执行。

## Turn async functions into durable workflows

## 将异步函数转化为持久化工作流

At its core, WDK introduces two simple directives that turn ordinary async functions into durable workflows, handling the work of queues, retry logic, and persistence layers.

WDK 的核心在于引入了两条简洁的指令，可将普通异步函数自动升级为持久化工作流，从而自动处理消息队列、重试逻辑与持久化层等底层复杂性。

The `use workflow` directive defines a function as a durable workflow:

`use workflow` 指令用于将一个函数声明为持久化工作流：

```typescript
export async function hailRide(requestId: string) {

2  "use workflow";
```

4  const request = await validateRideRequest(requestId);

4  const request = await validateRideRequest(requestId);

5  const trip = await assignDriver(request);

5  const trip = await assignDriver(request);

6  const confirmation = await notifyRider(trip);

6  const confirmation = await notifyRider(trip);

7  const receipt = await createReceipt(trip);

7  const receipt = await createReceipt(trip);



9  return receipt;

9  return receipt;

10}
```

10}
```

This example defines a durable workflow that coordinates multiple steps in a ride-hailing flow. Each step runs independently and can persist, pause, and resume across deploys or failures.

本示例定义了一个持久化工作流，用于协调拼车业务流程中的多个步骤。每个步骤独立运行，并可在部署更新或发生故障时持续保存状态、暂停及恢复执行。

The workflow function calls four step functions. Each step is defined with `use step`, which marks a unit of work that automatically persists progress and retries on failure:

该工作流函数调用了四个步骤函数。每个步骤均使用 `use step` 进行定义，用以标识一个工作单元——该单元可自动持久化执行进度，并在失败时自动重试：

```typescript
async function validateRideRequest(requestId: string) {
```

```typescript
async function validateRideRequest(requestId: string) {
```

2  `"use step";`

2  `"use step";`

4  // Validate the ride request and get rider details

4  // 验证拼车请求并获取乘客信息

5  const response = await fetch(`https://api.example.com/rides/${requestId}`);

5  const response = await fetch(`https://api.example.com/rides/${requestId}`);

6  // If this fetch fails, the step will automatically retry

6  // 如果此次 fetch 失败，该步骤将自动重试

7  if (!response.ok) throw new Error("Ride request validation failed");

7  if (!response.ok) throw new Error("Ride request validation failed");

9  const request = await response.json();

9  const request = await response.json();

10  return { rider: request.rider, pickup: request.pickup };

10  return { rider: request.rider, pickup: request.pickup };

11}  

11}

```typescript
async function assignDriver(request: any) {

async function assignDriver(request: any) {

14  "use step";

14  "use step";

15  // Assign the nearest available driver

15  // 分配最近的可用司机

16}

16}

async function notifyRider(trip: any) {

async function notifyRider(trip: any) {

19  "use step";

19  "use step";

20  // Notify the rider their driver is on the way

20  // 通知乘客，其司机正在途中

21}

21}
```

```typescript
async function createReceipt(trip: any) {

24  "use step";

25  // Generate a receipt for the trip

26}
```

```typescript
async function createReceipt(trip: any) {

24  “use step”;

25  // 为行程生成一张收据

26}
```

Each step runs in isolation and automatically retries on failure. In this example, the first step validates a ride request by calling an external API, while later steps assign a driver, notify the rider, and generate a receipt.

每个步骤均独立运行，并在失败时自动重试。在此示例中，第一个步骤通过调用外部 API 来验证拼车请求，后续步骤则分别执行司机指派、向乘客发送通知以及生成收据。

WDK compiles each step into an isolated API Route. Inputs and outputs are recorded, so if a deploy or crash occurs, the system can replay execution deterministically.

WDK 将每个步骤编译为一个独立的 API 路由。输入与输出均会被记录下来，因此即使发生部署更新或系统崩溃，系统也能以确定性方式重放执行过程。

While the step executes on a separate route, the workflow is suspended without consuming any resources. When the step is complete, the workflow is automatically resumed right where it left off.

当步骤在独立路由上执行时，工作流将被挂起，且不占用任何资源。一旦该步骤完成，工作流将自动从挂起处精确恢复执行。

This means that your workflows can pause for minutes, or even months.

这意味着您的工作流可以暂停数分钟，甚至长达数月。

```typescript
import { sleep } from "workflow";
```

```typescript
import { sleep } from "workflow";
```

```typescript
export async function offerLoyaltyReward(riderId: string) {

4  "use workflow";



6  // Wait three days before issuing a loyalty credit

7  await sleep("3d"); // No resources are used during sleep



9  return { riderId, reward: "Ride Credit" };

10}
```

```typescript
export async function offerLoyaltyReward(riderId: string) {

4  "use workflow";



6  // 在发放忠诚度积分前等待三天

7  await sleep("3d"); // 睡眠期间不消耗任何资源



9  return { riderId, reward: "Ride Credit" };

10}
```

Some workflows need to wait for hours or days before continuing. This example pauses execution for three days before issuing a loyalty reward to the rider, without consuming resources or losing state.

某些工作流需要在继续执行前等待数小时甚至数天。本示例在向骑手发放忠诚度奖励前暂停执行三天，期间既不消耗计算资源，也不会丢失状态。

WDK is built to be a lightweight framework using familiar JavaScript semantics. You can use async and await exactly as you do today. There's no need to write YAML, define state machines, or learn a new orchestration syntax. Instead of wiring together message queues or schedulers, you simply declare how your logic should behave and WDK handles the rest.

WDK 被设计为一个轻量级框架，采用开发者熟悉的 JavaScript 语义。你可以像现在一样直接使用 `async` 和 `await`。无需编写 YAML 文件、定义状态机，也无需学习新的编排语法。你不必手动集成消息队列或调度器，只需声明逻辑应有的行为，其余工作均由 WDK 自动完成。

### **Webhooks: Pause and Resume with External Events**

### **Webhook：借助外部事件实现暂停与恢复**

Workflows often need to wait for external data before continuing, like a payment confirmation, user action, or third-party API response. With WDK, you can pause a workflow until that data arrives using webhooks.

工作流常常需要等待外部数据（例如支付确认、用户操作或第三方 API 响应）到达后才能继续执行。借助 WDK，你可以通过 Webhook 实现工作流的自动暂停，直至所需数据抵达。

A webhook creates an endpoint that listens for incoming requests. When an external event sends data to that endpoint, the workflow automatically resumes right where it left off, no polling, message queues, or state management required.

Webhook 会创建一个监听传入请求的端点。当外部事件向该端点发送数据时，工作流将自动从暂停处精确恢复执行——无需轮询（polling）、消息队列或手动状态管理。

```typescript
import { createWebhook, fetch } from "workflow";



export async function validatePaymentMethod(rideId: string) {

4  "use workflow";



6  const webhook = createWebhook();
```

8  // Trigger external payment validation with callback to webhook URL

8  // 触发外部支付验证，并将回调发送至 Webhook URL

9  await fetch("https://api.example-payments.com/validate-method", {

9  await fetch("https://api.example-payments.com/validate-method", {

10    method: "POST",

10    method: "POST",

11    body: JSON.stringify({ rideId, callback: webhook.url }),

11    body: JSON.stringify({ rideId, callback: webhook.url }),

12  });

12  });

14  // Wait for payment provider to confirm via webhook

14  // 等待支付服务提供商通过 Webhook 发送确认

15  const { request } = await webhook;

15  const { request } = await webhook;

16  const confirmation = await request.json();

16  const confirmation = await request.json();

18  return { rideId, status: confirmation.status };

18  返回 { rideId, status: confirmation.status };

19}
19}

```

```

Webhooks let a workflow pause until data arrives from an external service. Here, the workflow sends a callback URL to a payment provider, waits for validation, then resumes automatically once confirmation is received.

Webhook 允许工作流暂停执行，直至从外部服务接收到数据。在此示例中，工作流向支付服务商发送一个回调 URL，等待验证完成，一旦收到确认信息即自动恢复执行。

## Reliable, durable, and observable by default

## 默认具备高可靠性、持久性与可观测性

From the first trigger to the final result, everything that happens inside a workflow is stored inside an event log, and visible to you at a glance.

从首次触发到最终结果，工作流内部发生的每一步操作均被记录在事件日志中，并可一目了然地供您查看。

Every step, input, output, pause, and error is recorded and easily accessible, not just through the API, but also visually through the included CLI and Web UI.

每一步骤、每次输入与输出、每个暂停点及每一处错误均被完整记录，且易于访问——不仅可通过 API 获取，还可通过配套的命令行工具（CLI）和网页控制台（Web UI）直观查看。

Track your runs in real time, trace failures, and analyze performance metrics, without writing a single extra line of code.

实时追踪工作流运行状态、精准定位失败原因、深入分析性能指标——全程无需编写额外代码。

![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/built-in-durability-introducing-workflow-development-kit-vercel/img_001.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/built-in-durability-introducing-workflow-development-kit-vercel/img_002.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/built-in-durability-introducing-workflow-development-kit-vercel/img_003.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/built-in-durability-introducing-workflow-development-kit-vercel/img_004.jpg)Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.

![Vercel 自动识别函数是否具备持久性，并实时动态配置最理想的基础设施以提供支持。](images/built-in-durability-introducing-workflow-development-kit-vercel/img_001.jpg)![Vercel 自动识别函数是否具备持久性，并实时动态配置最理想的基础设施以提供支持。](images/built-in-durability-introducing-workflow-development-kit-vercel/img_002.jpg)![Vercel 自动识别函数是否具备持久性，并实时动态配置最理想的基础设施以提供支持。](images/built-in-durability-introducing-workflow-development-kit-vercel/img_003.jpg)![Vercel 自动识别函数是否具备持久性，并实时动态配置最理想的基础设施以提供支持。](images/built-in-durability-introducing-workflow-development-kit-vercel/img_004.jpg)Vercel 自动识别函数是否具备持久性，并实时动态配置最理想的基础设施以提供支持。

## Workflows run anywhere with Worlds

## 借助 Worlds，工作流可随处运行

Workflows in WDK are designed to run on any platform, framework, and runtime. Each environment, called a World, defines how execution, orchestration, and persistence are handled. This makes your code portable across runtimes and clouds without any changes.

WDK 中的工作流（Workflow）专为在任意平台、框架和运行时上运行而设计。每个运行环境被称为一个“世界”（World），它定义了执行、编排与持久化如何实现。这使得您的代码无需任何修改，即可在不同运行时和云环境中无缝移植。

During local development, the Local World provides virtual infrastructure so workflows can execute without provisioning queues or databases. In production, the Vercel World uses Framework-defined infrastructure (FdI) to automatically set up persistence, queues, and routing. The same code you test locally behaves identically when deployed at scale.

本地开发期间，“本地世界”（Local World）提供虚拟基础设施，使工作流无需预先配置消息队列或数据库即可直接运行；而在生产环境中，“Vercel 世界”（Vercel World）则利用框架定义的基础设施（Framework-defined infrastructure, FdI），自动完成持久化、队列与路由的搭建。您在本地测试的同一套代码，在大规模部署后行为完全一致。

Worlds are extensible. You can build and deploy WDK on other runtimes or cloud providers by implementing a custom World. We've published a reference implementation of a [Postgres World on GitHub](https://github.com/vercel/workflow/tree/main/packages/world-postgres), and the community has already created third-party Worlds using databases like [Jazz](https://github.com/garden-co/workflow-world-jazz).

“世界”（World）具备可扩展性。您可通过实现自定义 World，将 WDK 部署到其他运行时或云服务商上。我们已在 GitHub 上开源了一个 [Postgres World 的参考实现](https://github.com/vercel/workflow/tree/main/packages/world-postgres)，社区也已基于 Jazz 等数据库开发出第三方 World，例如 [Jazz World](https://github.com/garden-co/workflow-world-jazz)。

WDK follows the [Vercel Open SDKs philosophy.](https://vercel.com/blog/open-sdk-strategy) There is no vendor lock-in. Whether you run on Vercel or elsewhere, your workflows remain portable, reliable, and observable.

WDK 遵循 [Vercel 开放 SDK 哲学](https://vercel.com/blog/open-sdk-strategy)。不存在厂商锁定（vendor lock-in）。无论您选择在 Vercel 还是其他平台上运行，您的工作流始终具备可移植性、可靠性与可观测性。

[**Build natural language image search**\\
\\
Use this template to build an AI-powered image search application with automatic description generation and indexing for semantic search. \\
\\
Deploy now](https://vercel.com/templates/ai/natural-language-image-search)

[**构建自然语言图像搜索应用**\\
\\
使用此模板，快速搭建一款由 AI 驱动的图像搜索应用，支持自动生成图像描述，并对图像进行语义索引以实现精准检索。\\
\\
立即部署](https://vercel.com/templates/ai/natural-language-image-search)

## Built for systems that need intelligence and reliability

## 专为需要智能性与可靠性的系统而构建

The [Workflow Development Kit](https://useworkflow.dev/) is designed for systems that must be both intelligent and dependable.

[工作流开发工具包（Workflow Development Kit，WDK）](https://useworkflow.dev/) 是专为必须兼具智能性与高可靠性要求的系统所设计的。

AI agents that reason across long contexts need to pause between API calls. RAG pipelines that ingest and embed data over time need to survive crashes during multi-hour processing. Commerce systems that wait for user confirmations need to pause for days without consuming resources.

需在长上下文中进行推理的 AI Agent，必须在 API 调用之间暂停；需随时间逐步摄取并嵌入数据的 RAG 流水线，必须能扛住持续数小时处理过程中的意外崩溃；等待用户确认的电商系统，则需在不消耗任何资源的前提下暂停数日。

By extending JavaScript with durability semantics, the Workflow Development Kit removes one of the biggest barriers to reliability in modern applications. It lets developers focus on logic, not infrastructure. You write async code. WDK makes it durable, locally or at scale on Vercel.

WDK 通过为 JavaScript 引入持久化语义（durability semantics），消除了现代应用实现高可靠性的一大障碍。它让开发者得以专注于业务逻辑本身，而非底层基础设施。您只需编写异步代码——WDK 将自动确保其持久性，无论是在本地开发环境，还是在 Vercel 上的大规模生产部署中。

Reliability has always been something developers had to build around. With WDK, it’s finally something you can build with.

过去，可靠性一直是开发者不得不围绕其进行架构设计的约束条件；而借助 WDK，它终于成为一种可直接用于构建应用的核心能力。

[**Start building durable workflows**  
[**开始构建持久化工作流**  

Use familiar JavaScript to build workflows that persist across deploys and crashes. No queues, schedulers, or extra infrastructure required.  
使用您熟悉的 JavaScript 构建工作流，这些工作流可在部署更新和系统崩溃后持续存在。无需消息队列、调度器或额外基础设施。  

Get started](https://useworkflow.dev/)