---
render_with_liquid: false
title: "​Introducing BotID, invisible bot filtering for critical routes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-botid"
date: "2025-06-25"
scraped_at: "2026-03-02T09:31:44.338365155+00:00"
language: "en-zh"
translated: true
description: "BotID is a new invisible CAPTCHA layer of protection that stops sophisticated bots before they reach your backend. It's built to secure critical routes like checkouts, logins, and signups or actions t..."
---
render_with_liquid: false
render_with_liquid: false

Jun 25, 2025

2025 年 6 月 25 日

Modern sophisticated bots don’t look like bots. They execute JavaScript, solve CAPTCHAs, and navigate interfaces like real users. Tools like Playwright and Puppeteer can script human-like behavior from page load to form submission.

现代高级机器人（bots）看起来并不像机器人：它们能执行 JavaScript、破解 CAPTCHA，并像真实用户一样在界面中导航。Playwright 和 Puppeteer 等工具可从页面加载到表单提交全程模拟人类行为。

Traditional defenses like checking headers or rate limits aren't enough. Bots that blend in by design are hard to detect and expensive to ignore.

仅靠检查请求头（headers）或限流（rate limiting）等传统防护手段已远远不够。那些天生就旨在“融入”正常流量的机器人极难识别，而对其放任不管则可能带来高昂代价。

Enter BotID: A new layer of protection on Vercel.

隆重推出 BotID：Vercel 平台上的全新防护层。

Think of it as an invisible CAPTCHA to stop browser automation before it reaches your backend. It’s built to protect critical routes where automated abuse has real cost such as checkouts, logins, signups, APIs, or actions that trigger expensive backend operations like LLM-powered endpoints.

可将其理解为一道“隐形 CAPTCHA”，在自动化浏览器行为抵达您的后端之前即予以拦截。BotID 专为保护关键路由而设计——这些路由一旦遭受自动化滥用，将产生切实成本，例如结账（checkout）、登录（login）、注册（signup）、API 接口，或触发高开销后端操作（如由大语言模型（LLM）驱动的端点）的行为。

```tsx
import { checkBotId } from "botid/server";



export async function POST(req: Request) {

4  const { isBot } = await checkBotId();
```

6  if (isBot) {

7    return new Response("Access Denied", { status: 403 });

8  }



10  const result = await expensiveOrCriticalOperation();



12  return new Response("Success!");

13}
```

设置非常简单，无需配置文件或调优。只需安装软件包、配置重写规则、挂载客户端，并在服务端验证请求即可。

## BotID 的工作原理

## BotID 的工作原理

BotID is available in two modes: Basic (enabled by default) and Deep Analysis, which adds advanced detection checks.

BotID 提供两种模式：基础模式（默认启用）和深度分析模式，后者增加了高级检测检查。

Detection starts at the session level. BotID injects lightweight, obfuscated code into the requester’s environment that evolves on every load and is designed to resist replay, tampering, and static analysis. It runs invisibly with no CAPTCHAs or changes to the user experience.

检测从会话级别开始。BotID 向请求方环境注入轻量级、混淆过的代码；该代码每次加载时均动态演化，专为抵御重放攻击、篡改及静态分析而设计。其运行完全隐形，无需 CAPTCHA，亦不会改变用户体验。

Unlike traditional defenses, BotID doesn’t rely on static signals like user-agent headers or IP ranges, which are easy to fake and become outdated. It also avoids more intrusive methods like CAPTCHAs, heuristics, and reputation scores, which can frustrate or block real users.

与传统防护方案不同，BotID 不依赖于 User-Agent 请求头或 IP 地址段等易于伪造且易过时的静态信号。它也避免采用 CAPTCHA、启发式规则和信誉评分等更具侵入性的方法——这些方法可能令真实用户感到困扰，甚至将其误拦。

Instead, BotID counters the most advanced bots by:

相反，BotID 通过以下方式应对最先进级别的机器人：

- Silently collecting thousands of signals that distinguish human users from bot

- 静默采集数千个可区分人类用户与机器人的信号

- Mutating detection logic on every load to prevent reverse engineering and making spoofing difficult

- 每次加载均动态变更检测逻辑，以防止逆向工程，并大幅增加伪造难度

- Feeding attack patterns into a global machine learning network that continuously improves protection for all

- 将攻击模式输入全球机器学习网络，持续提升对所有用户的防护能力

BotID is fast, reliable, and built for developers. Server-side verification takes a single function call. There's nothing to configure, no API keys to manage, and no scores or thresholds to tune. Requests that are tested for validation are returned with an unambiguous pass or fail answer.

BotID 快速、可靠，专为开发者而构建。服务端验证仅需一次函数调用；无需任何配置，无需管理 API 密钥，亦无需调整分数或阈值。经验证测试的请求将明确返回“通过”或“不通过”的判定结果。

## Deep Analysis powered by Kasada

## 由 Kasada 驱动的深度分析

BotID with Deep Analysis is powered by [Kasada](https://www.kasada.io/), whose detection engine protects some of the most targeted platforms on the internet. Their system is hardened against real-world adversaries: bots that retool quickly, replay sessions, and adapt to static defenses.

启用深度分析功能的 BotID 由 [Kasada](https://www.kasada.io/) 提供技术支持。Kasada 的检测引擎守护着互联网上遭受攻击最频繁的若干平台。其系统经过实战强化，可有效抵御现实世界中的各类对抗性机器人——包括快速重构自身、重放会话、并能适应静态防御机制的恶意机器人。

Because Kasada is integrated directly into the Vercel platform, there’s no separate service to sign up or set up. Just install the package, define routes you want to block automation on, and deploy.

由于 Kasada 已深度集成至 Vercel 平台，您无需单独注册或配置服务。只需安装对应软件包，定义需要阻止自动化访问的路由，然后部署即可。

We've been using Kasada’s enterprise-grade defenses to protect our own high-value apps, like [v0.dev](https://v0.dev/), for a while now. Now you can do the same. Kasada’s detection runs automatically with your deployment, bringing enterprise-grade protection to your most critical routes.

我们已长期使用 Kasada 的企业级防护能力，保护自身高价值应用（例如 [v0.dev](https://v0.dev/)）。现在，您也可以轻松启用相同能力。Kasada 的检测机制将随您的部署自动运行，为最关键的业务路由提供企业级防护。

## BotID: For teams of all sizes

## BotID：面向所有规模的团队

BotID is designed for teams dealing with targeted automation that slips past conventional defenses. These aren’t generic bots, they behave like real users, and move through high-value flows, creating real cost when left unchecked.

BotID 专为应对绕过传统防御手段的定向自动化攻击而设计。这些并非泛化的爬虫，而是行为高度拟人化、可穿越关键业务流程的高级自动化程序；若放任不管，将带来真实的业务成本与损失。

That might look like scalpers attacking limited checkouts, fake accounts flooding signups, or credential stuffing targeting login endpoints. It also includes scraping against dashboards, pricing pages, or APIs that expose business logic or drive up compute.

此类攻击可能表现为黄牛抢购限量商品、虚假账号批量注册、针对登录接口的凭证填充（credential stuffing）等；也包括对仪表盘、价格页面或暴露业务逻辑/显著增加计算开销的 API 接口进行数据抓取。

BotID is built to protect the parts of your app that matter most, without getting in the way of actual users.

BotID 的设计理念是在严防高级自动化威胁的同时，完全不影响真实用户的正常访问体验——全力守护您应用中最重要的核心环节。

## Available now

## 现已上线

We already protect against automated traffic with platform-level protections like DDoS mitigation, WAF rules, and bot challenges for non-browser clients. BotID extends that protection as a new sophisticated layer designed to block automation that mimics real users targeting the most critical routes.

Vercel 平台目前已通过多种平台级防护机制抵御自动化流量，包括 DDoS 缓解、Web 应用防火墙（WAF）规则，以及面向非浏览器客户端的机器人挑战（bot challenges）。BotID 在此基础上新增一层更智能、更精细的防护能力，专门用于识别并拦截那些伪装成真实用户、精准攻击最关键业务路由的高级自动化程序。

BotID is available now for all teams, with Deep Analysis powered by Kasada available for Pro and Enterprise teams.

BotID 即日起面向所有团队开放使用；其中由 Kasada 提供支持的“深度分析”（Deep Analysis）功能，则面向 Pro 及 Enterprise 计划用户开放。

[**Get started with Vercel BotID**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes like login, checkout, AI agents, and APIs. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/docs/botid/get-started)

[**立即开始使用 Vercel BotID**\\
\\
在高级机器人抵达您最敏感的路由（如登录页、结算页、AI 智能体、API 接口）之前，即刻识别并拦截。实施简易，难以绕过。\\
\\
立即开始](https://vercel.com/docs/botid/get-started)