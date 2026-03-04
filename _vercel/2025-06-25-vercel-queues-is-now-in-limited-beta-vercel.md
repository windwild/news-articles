---
title: "Vercel Queues is now in Limited Beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-queues-is-now-in-limited-beta"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:46.610089198+00:00"
language: "en-zh"
translated: true
description: "Vercel Queues is a message queue service for Vercel apps, now in Limited Beta. It enables background task processing using an append-only log for reliability, with support for pub/sub messaging, strea..."
---
&#123;% raw %}

Jun 25, 2025

2025 年 6 月 25 日

Vercel Queues 是一款专为 Vercel 应用构建的消息队列服务，目前处于限量公测（Limited Beta）阶段。

Vercel Queues 允许您通过将任务发送至队列来卸载工作负载，这些任务将在后台被异步处理。这意味着用户在发起请求时无需等待耗时操作完成，同时您的应用也能更可靠地处理重试与失败场景。

在底层实现上，Vercel Queues 使用仅追加（append-only）日志来存储消息，并确保 AI 视频处理、邮件发送或外部服务更新等关键任务被持久化保存，永不丢失。

**Vercel Queues 的核心特性：**

- **发布/订阅（Pub/Sub）模式**：基于主题（topic）的消息传递机制，支持多个消费者组（consumer groups）

- **流式处理（Streaming）支持**：可处理大负载数据，无需将其全部加载至内存中

- **简化的身份认证（Streamlined auth）**：通过 OIDC 令牌自动完成身份验证

- **SDK 支持**：提供具备完整类型安全性的 TypeScript SDK


```tsx
import { send, receive } from "@vercel/queue";
```

```javascript
await send("topic", { message: "Hello World!" });



await receive("topic", "consumer", (m) => {

6  console.log(m.message); // Logs "Hello World!"

7});
```

```javascript
await send("topic", { message: "Hello World!" });



await receive("topic", "consumer", (m) => {

6  console.log(m.message); // 输出 "Hello World!"

7});
```

An example of sending and receiving message with a queue.

使用队列发送和接收消息的示例。

If you have any questions, let us know in the [Vercel Community](https://community.vercel.com/).

如有任何疑问，请在 [Vercel 社区](https://community.vercel.com/) 中告诉我们。
&#123;% endraw %}
