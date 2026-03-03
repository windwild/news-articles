---
title: "BotID Deep Analysis catches a sophisticated bot network in real-time - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/botid-deep-analysis-catches-a-sophisticated-bot-network-in-real-time"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:19.843554546+00:00"
language: "en-zh"
translated: true
description: "BotID Deep Analysis is a sophisticated, invisible bot detection product. This article is about how BotID Deep Analysis adapted to a novel attack in real time, and successfully classified sessions that..."
---

Oct 31, 2025

2025 年 10 月 31 日

Real-time detection and adaptation in action

实时检测与自适应响应实战

On October 29 at 9:44am, [BotID Deep Analysis](https://vercel.com/docs/botid#how-botid-deep-analysis-works) detected an unusual spike in traffic patterns across one of our customer's projects. Traffic increased by 500% above normal baseline. What made this particularly interesting wasn't just the volume increase. The spike appeared to be coming from legitimate human users.

10 月 29 日上午 9:44，[BotID 深度分析](https://vercel.com/docs/botid#how-botid-deep-analysis-works) 在我们某位客户的项目中检测到异常的流量激增。流量较正常基线水平飙升了 500%。真正引人关注的并不仅仅是流量规模的骤增——此次激增看似源自真实的普通用户。

Our team immediately began investigating and reached out to the customer to discuss what appeared to be an influx of bot traffic cleverly disguised as human activity. But before we could even complete that conversation, something remarkable happened: Deep Analysis, [powered by Kasada’s machine learning backend](https://www.kasada.io/), had already identified the threat and adapted to correctly classify it.

我们的团队立即展开调查，并联系客户，就疑似大量伪装成人类行为的机器人流量涌入一事进行沟通。然而，甚至在我们尚未完成这次对话时，一件令人瞩目的事情已然发生：深度分析系统——[由 Kasada 的机器学习后端驱动](https://www.kasada.io/)——已率先识别出该威胁，并完成自适应调整，准确完成了分类判定。

## A sophisticated new threat emerges

## 一种高度复杂的新型威胁浮现

What we were witnessing was likely a brand-new browser bot network spinning up for the first time. These weren't your typical bots. They were sophisticated actors that generated telemetry data that looked completely legitimate. Around 40-45 new browser profiles appeared, each presenting fingerprints and behavioral patterns that hadn't been seen before.

我们当时所观察到的，很可能是一个全新浏览器机器人网络的首次启动。这些并非传统意义上的简单机器人，而是高度复杂的攻击者，能够生成完全符合真实用户特征的遥测数据。约 40–45 个全新浏览器配置文件突然出现，每个都呈现出此前从未见过的设备指纹与行为模式。

For a few minutes, [BotID’s](https://vercel.com/botid) models carefully analyzed this new data, determining whether these sessions were genuine or malicious. This is the critical period where sophisticated bot networks can slip through traditional security measures. They look real because they're using real browser automation tools and carefully crafted profiles.

在数分钟内，[BotID](https://vercel.com/botid) 的模型谨慎分析了这批新数据，以判断这些会话是真实用户还是恶意行为。这正是高级机器人网络最易绕过传统安全防护的关键窗口期——它们之所以“看起来真实”，正因其使用了真实的浏览器自动化工具，并精心构造了用户配置文件。

## The pattern reveals itself

## 模式逐渐显现

Then the pattern emerged. These browser sessions that had initially appeared legitimate started showing up across a range of IP addresses. Crucially, these IPs were identified as proxy nodes, rather than network origin points. This was the tell-tale sign: legitimate users don't rapidly cycle through proxy networks while maintaining the same browser profile.

随后，规律开始浮现。这些起初看似合法的浏览器会话，开始出现在大量不同的 IP 地址上。尤为关键的是，这些 IP 被识别为代理节点（proxy nodes），而非网络源地址（network origin points）。这正是决定性线索：真实用户绝不会在保持同一浏览器配置文件的前提下，快速轮换使用多个代理网络。

Deep Analysis pieced together the bigger picture. The same browser fingerprints appearing across multiple proxy nodes indicated coordinated bot activity, not organic human behavior. Once this pattern was detected, the system automatically forced these sessions back through the verification process to collect fresh browser telemetry.

深度分析系统整合了全部线索，还原出完整图景：同一套浏览器指纹反复出现在多个代理节点上，明确指向有组织的机器人活动，而非自然的人类行为。一旦该模式被识别，系统即自动将这些会话重新导向验证流程，以采集最新的浏览器遥测数据。

## Hands-free blocking in 5 minutes

## 5 分钟内实现免手动拦截

This second round of telemetry collection, now informed by the proxy node detection and behavioral patterns, revealed the true nature of these sessions. What had initially looked like legitimate traffic was now clearly identified as ⁠malicious: a sophisticated bot network attempting to evade detection.

第二轮遥测数据采集现已结合代理节点检测与行为模式分析，揭示了这些会话的真实性质。此前看似合法的流量，如今被明确识别为恶意流量：一个试图规避检测的、高度复杂的机器人网络。

Here’s how the 10-minute attack unfolded:

以下是这场持续 10 分钟的攻击过程：

- **9:44am:** Traffic spike detected, human classifications continues

- **上午 9:44：** 检测到流量激增，人工分类工作仍在继续

- **9:45-9:48am:** Models analyze 40-45 new browser profiles, making thousands of requests, across proxy nodes

- **上午 9:45–9:48：** 模型分析分布在多个代理节点上的 40–45 个全新浏览器画像，发起数千次请求

- **9:48am:** Pattern correlation identifies coordinated bot activity

- **上午 9:48：** 模式关联分析识别出协同运作的机器人活动

- **9:49am:** Re-verification confirms threat, bot classification begins

- **上午 9:49：** 二次验证确认威胁，机器人分类流程启动

- **9:54am:** Attack traffic drops to zero

- **上午 9:54：** 攻击流量降至零

![Bot traffic reclassified from human (purple) to bot (blue)](images/botid-deep-analysis-catches-a-sophisticated-bot-network-in-real-time-vercel/img_001.jpg)![Bot traffic reclassified from human (purple) to bot (blue)](images/botid-deep-analysis-catches-a-sophisticated-bot-network-in-real-time-vercel/img_002.jpg)Bot traffic reclassified from human (purple) to bot (blue)

![机器人流量从“人类”（紫色）重新分类为“机器人”（蓝色）](images/botid-deep-analysis-catches-a-sophisticated-bot-network-in-real-time-vercel/img_001.jpg)![机器人流量从“人类”（紫色）重新分类为“机器人”（蓝色）](images/botid-deep-analysis-catches-a-sophisticated-bot-network-in-real-time-vercel/img_002.jpg)机器人流量从“人类”（紫色）重新分类为“机器人”（蓝色）

The entire process, from initial detection to accurate classification and blocking, took just a few minutes. No manual intervention required. No emergency patches or rule updates. The customer took no action at all. Just BotID doing exactly what it's designed to do: automatically learn, adapt, and protect in real-time.

整个流程——从最初检测、精准分类，到最终拦截——仅耗时数分钟。全程无需人工干预，无需紧急补丁或规则更新。客户完全未采取任何操作。这正是 BotID 的本职所在：实时自动学习、自适应调整并提供防护。

## Why this matters

## 为何这至关重要

This incident demonstrates the critical importance of adaptive, machine learning-based bot detection. These bots were specifically designed to evade traditional defenses: real browser automation, legitimate-looking telemetry, and carefully constructed profiles that mimic organic behavior.

此次事件凸显了自适应、基于机器学习的机器人检测技术的关键重要性。这些机器人被专门设计用于规避传统防御手段：例如采用真实浏览器自动化技术、生成看似合法的遥测数据，以及精心构建高度拟真的用户画像以模仿自然人类行为。

Standard bot detection handles the majority of threats effectively. But sophisticated attacks like this one create a tradeoff: aggressive blocking risks false positives against legitimate users, while permissive rules let sophisticated bots through.

标准机器人检测方案能有效应对绝大多数威胁。但此类高阶攻击却带来两难权衡：激进的拦截策略可能误伤真实用户（产生误报），而宽松的规则又会让高级机器人有机可乘。

Deep Analysis exists for these edge cases where attackers invest significant resources in evasion. By combining multiple signals (browser telemetry, network patterns, behavioral analysis, and real-time learning), Deep Analysis can identify coordination patterns that individual signals miss. The key insight wasn't any single red flag. It was the correlation: identical browser fingerprints cycling through proxy infrastructure.

Deep Analysis 正是为应对这类边缘场景而生——在此类场景中，攻击者投入大量资源进行规避。通过融合多种信号（浏览器遥测数据、网络行为模式、用户行为分析及实时学习能力），Deep Analysis 能够识别出单个信号无法揭示的协同行为模式。其关键洞见并非某个孤立的危险信号，而是多个信号之间的关联性：完全相同的浏览器指纹在代理基础设施中循环复用。

As bot networks become more sophisticated, the only effective defense is a system that can learn and adapt just as quickly. This Wednesday morning proved that BotID does exactly that.

随着机器人网络日趋复杂，唯一有效的防御手段，就是一套能够以同等速度持续学习与自适应的系统。本周三上午的实战表现，已充分证明 BotID 正是这样一套系统。

[**Get started with Vercel BotID**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes like login, checkout, AI agents, and APIs. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/docs/botid/get-started)

[**立即开始使用 Vercel BotID**\\
\\
在高级机器人抵达您最关键的业务路径（如登录页、结算页、AI 智能体及 API 接口）之前，即刻识别并拦截它们。部署简易，难以绕过。\\
\\
立即开始](https://vercel.com/docs/botid/get-started)