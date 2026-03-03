---
title: "Vercel BotID now leverages Vercel's verified bot directory - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-botid-now-leverages-vercels-verified-bot-directory"
date: "2025-08-12"
scraped_at: "2026-03-02T09:29:56.160995052+00:00"
language: "en-zh"
translated: true
description: "Vercel BotID is an invisible CAPTCHA that protects against sophisticated bots without showing visible challenges or requiring manual intervention. It now catches verified bots and allows users to cont..."
---

Aug 12, 2025

2025 年 8 月 12 日

Starting in `botid@1.5.0`, [BotID’s Deep Analysis mode](https://vercel.com/docs/botid#how-botid-deep-analysis-works) provides authenticated information for verified bots based on Vercel's [directory of known and verified bots](https://bots.fyi/). This allows developers to detect verified bots in real time and make programmatic decisions based on bot identity.

自 `botid@1.5.0` 版本起，[BotID 的深度分析模式（Deep Analysis mode）](https://vercel.com/docs/botid#how-botid-deep-analysis-works) 将基于 Vercel 维护的[已知及已验证机器人目录（directory of known and verified bots）](https://bots.fyi/)，为经验证的机器人提供经过身份认证的信息。这使开发者能够实时识别已验证机器人，并依据其身份做出程序化决策。

This allows you to securely allow known bots that are good for your business (such as agentic bots that purchase on behalf of users) while blocking other bots and sophisticated abuse.

此举使您可安全放行对业务有益的已知机器人（例如代表用户下单的智能代理型机器人），同时拦截其他未经验证的机器人及复杂滥用行为。

[BotID](https://vercel.com/blog/introducing-botid) is an invisible CAPTCHA that classifies sophisticated bots without interrupting real users. With this update, developers using Deep Analysis now get additional context about the bot itself, such as source IP range, reverse DNS, and user-agent validation, helping teams fine-tune how bots are handled before taking action.

[BotID](https://vercel.com/blog/introducing-botid) 是一种无感式 CAPTCHA，可在不干扰真实用户的情况下识别高阶机器人。借助本次更新，启用深度分析模式的开发者将获得关于机器人的额外上下文信息，例如来源 IP 地址段、反向 DNS 解析结果以及 User-Agent 合法性验证结果，从而帮助团队在采取具体措施前更精准地调整机器人处理策略。

app/api/checkout/route.ts

```javascript
import { checkBotId } from "botid/server";



export async function POST(request: Request) {

4  const botResult = await checkBotId();
```

6  const { isBot, verifiedBotName, isVerifiedBot, verifiedBotCategory } = botResult;

6  const { isBot, verifiedBotName, isVerifiedBot, verifiedBotCategory } = botResult;

8  // Check if it's ChatGPT Operator

8  // 检查是否为 ChatGPT Operator

9  const isOperator = isVerifiedBot && verifiedBotName === "chatgpt-operator";

9  const isOperator = isVerifiedBot && verifiedBotName === "chatgpt-operator";

11  if (isBot && !isOperator) {

11  if (isBot && !isOperator) {

12    return Response.json({ error: "Access denied" }, { status: 403 });

12    return Response.json({ error: "访问被拒绝" }, { status: 403 });

13  }

13  }

15  // ... rest of your handler

15  // ……你的处理函数其余部分

16  return Response.json(botResult);

16  返回 Response.json(botResult);

17}
17}

Example of allowing ChatGPT-Operator access

允许 ChatGPT-Operator 访问的示例

Get started with [BotID](https://vercel.com/docs/botid) and check out the [documentation for verified bots](https://vercel.com/docs/botid/verified-bots) in BotID.

请通过 [BotID](https://vercel.com/docs/botid) 快速入门，并查阅 BotID 中关于[已验证机器人（verified bots）的文档](https://vercel.com/docs/botid/verified-bots)。