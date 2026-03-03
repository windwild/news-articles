---
title: "Vercel BotID is now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-botid-is-now-generally-available"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:51.240170645+00:00"
language: "en-zh"
translated: true
description: "Vercel BotID is now generally available. BotID is an advanced bot detection package powered by Kasada."
---

Jun 25, 2025

2025 年 6 月 25 日

Vercel BotID is an invisible CAPTCHA with no visible challenges or manual bot management required.

Vercel BotID 是一种无感式 CAPTCHA，无需呈现任何可见挑战，也无需人工干预进行机器人管理。

BotID is a new protection layer on Vercel designed for public, high-value routes such as checkouts, signups, AI chat interfaces, LLM-powered endpoints, and public APIs that are targets for sophisticated bots mimicking real user behavior.

BotID 是 Vercel 推出的全新防护层，专为面向公众、高价值的路由路径设计，例如结账页、注册页、AI 聊天界面、大语言模型（LLM）驱动的端点以及公共 API——这些正是那些高度拟人化、行为逼真的高级机器人常瞄准的目标。

Unlike IP-based or heuristic systems, BotID:

与基于 IP 或启发式规则的传统系统不同，BotID 具备以下特性：

- Silently collects thousands of signals that distinguish human users from bot

- 静默采集数千种信号，精准区分真实用户与机器人

- Mutates these detections on every page load, evading reverse engineering and sophisticated bypasses

- 每次页面加载均动态变更检测逻辑，有效抵御逆向工程与高级绕过手段

- Streams attack data into a global machine learning mesh, collectively strengthening protection for all customers

- 将攻击数据实时汇入全球机器学习网络，协同提升所有客户的整体防护能力

Powered by [Kasada](https://kasada.io/), BotID integrates into your application with a [type-safe SDK](https://www.npmjs.com/package/botid):

由 [Kasada](https://kasada.io/) 提供技术支持，BotID 通过一款 [类型安全的 SDK](https://www.npmjs.com/package/botid) 无缝集成至您的应用：

- Client-side detection using the `<BotIdClient>` component

- 前端检测：使用 `<BotIdClient>` 组件

- Server-side verification with the `checkBotId` function

- 后端验证：调用 `checkBotId` 函数

- Automatic labeling of logs and telemetry for blocked sessions

- 自动为被拦截会话的日志和遥测数据打标签


```tsx
import { checkBotId } from "botid/server";



export async function POST(req: Request) {

4  const { isBot } = await checkBotId();



6  if (isBot) {

7    return new Response("Access Denied", { status: 403 });

8  }

```

```
10  const result = await expensiveOrCriticalOperation();



12  return new Response("Success!");

13}
```

```
10  const result = await expensiveOrCriticalOperation();



12  return new Response("Success!");

13}
```

Setup is simple with no config files or tuning required. Install the package, setup rewrites, mount the client, and verify requests server-side.

设置非常简单，无需配置文件或调优。只需安装软件包、配置重写规则、挂载客户端，并在服务端验证请求。

BotID traffic is visible in the Firewall dashboard and can be filtered by verdict (pass or fail), user agent, country, IP address, request path, target path, JA4 digest, and host.

BotID 流量可在防火墙（Firewall）仪表板中查看，并支持按判定结果（通过或失败）、用户代理（User Agent）、国家/地区、IP 地址、请求路径、目标路径、JA4 摘要（JA4 digest）和主机（host）进行筛选。

Read the [announcement](https://vercel.com/blog/introducing-botid) or [documentation](https://vercel.com/docs/botid) to learn more, or try BotID today.

请阅读[发布公告](https://vercel.com/blog/introducing-botid)或[文档](https://vercel.com/docs/botid)了解更多信息，或立即试用 BotID。

[**Get started with Vercel BotID**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes like login, checkout, AI agents, and APIs. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/docs/botid/get-started)

[**立即开始使用 Vercel BotID**\\
\\
在高级机器人抵达您最敏感的路由（例如登录页、结算页、AI 代理及 API）之前，即刻识别并拦截它们。实施简易，难以绕过。\\
\\
立即开始](https://vercel.com/docs/botid/get-started)