---
title: "How Nous Research used BotID to block automated abuse at scale - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-nous-research-used-botid-to-block-automated-abuse-at-scale"
date: "2025-11-07"
scraped_at: "2026-03-02T09:25:55.169059801+00:00"
language: "en-zh"
translated: true
description: "Vercel BotID Deep Analysis protected Nous Research by blocking advanced automated abuse from attacking their application"
---

Nov 7, 2025

2025 年 11 月 7 日

AI lab [Nous Research](https://nousresearch.com/) made Hermes, their open-source language model, free for one week to increase accessibility. Within days, automated scripts overwhelmed the service with fake accounts performing high-volume inference requests across thousands of accounts to bypass rate limits.

AI 实验室 [Nous Research](https://nousresearch.com/) 为提升可访问性，将其开源语言模型 Hermes 免费开放一周。然而仅数日内，自动化脚本便通过创建大量虚假账户、跨数千账户发起高并发推理请求等方式，绕过速率限制，致使服务不堪重负。

Despite having Cloudflare Turnstile in place, bulk signups continued. The abuse led to wasted inference compute and inflated identity provider bills. After the promotion ended, Nous realized that before reintroducing any kind of free tier, it needed a stronger layer of bot protection.

尽管已部署 Cloudflare Turnstile 防护机制，批量注册行为仍持续发生。此次滥用导致大量推理算力被浪费，并大幅推高了身份提供商的账单费用。推广活动结束后，Nous 意识到：在重新推出任何免费层级服务之前，必须引入更强大的机器人防护层。

[**Free BotID Deep Analysis**\\
\\
Enterprise and Pro teams can use Vercel BotID Deep Analysis free of charge through January 15\\
\\
Read Now](https://vercel.com/changelog/free-botid-deep-analysis-through-end-of-the-year)

[**BotID 深度分析免费试用**\\
\\
企业版（Enterprise）与专业版（Pro）团队可于 1 月 15 日前免费使用 Vercel BotID 深度分析功能\\
\\
立即阅读](https://vercel.com/changelog/free-botid-deep-analysis-through-end-of-the-year)

## About Nous Research

## 关于 Nous Research

Nous Research is an AI research lab that manages multiple applied AI research areas, including an LLM series named [Hermes](https://hermes4.nousresearch.com/). While anyone can download and run Hermes for free, Nous also offers a hosted chat UI and inference API, providing users a simple, direct way to interact with the models without any prior setup.

Nous Research 是一家人工智能研究实验室，专注于多个应用型 AI 研究方向，其中包括名为 [Hermes](https://hermes4.nousresearch.com/) 的大语言模型系列。用户可免费下载并本地运行 Hermes；此外，Nous 还提供托管式聊天界面（hosted chat UI）与推理 API，使用户无需任何前期配置，即可便捷、直接地与模型交互。

## Unexpected app abuse during free tier promotion

## 免费层级推广期间遭遇意外应用滥用

During the one-week promotional period offering free Hermes inference, app abusers interacted with the chat product programmatically. Scripts ran datagen prompts, spreading the load across thousands of fake accounts to bypass rate limits.

在为期一周的 Hermes 免费推理推广活动中，恶意用户通过程序化方式调用聊天产品。自动化脚本执行数据生成（datagen）类提示词，并将负载分散至数千个虚假账户，以规避速率限制。

> “We were swamped with scripts running datagen prompts, spreading the load across thousands of users. Our only protection was captcha on sign-up, which it seems was not effective.We were swamped with scripts running datagen prompts, spreading the load across thousands of users. Our only protection was captcha on sign-up, which it seems was not effective.”
>
> ![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_001.jpg)
>
> **Robin Fernandes,** Engineer at Nous Research

> “我们被大量运行 datagen 提示词的脚本淹没，负载被分散至数千名用户。我们当时唯一的防护措施是注册环节的验证码（CAPTCHA），但显然效果不佳。”  
>  
> ![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_001.jpg)  
>  
> **Robin Fernandes**，Nous Research 工程师

The abuse led to wasted inference compute and inflated identity provider bills, despite having Cloudflare Turnstile in place for signup protection.

尽管已在注册环节部署 Cloudflare Turnstile 提供防护，此次滥用仍导致大量推理算力被浪费，并显著抬高了身份提供商的账单费用。

## Retooling for security and efficiency

## 为提升安全性与效率而重构系统

Nous 抓住此次机会，对其注册流程和聊天交互流程进行了全面重构。在新一轮推广活动启动之前，Nous 集成了 [Vercel BotID 深度分析](https://vercel.com/docs/botid#how-botid-deep-analysis-works)——这是我们目前最先进、精准度最高的机器人防护方案，可准确识别伪装成人类行为的恶意机器人。BotID 以“隐形验证码”的形式运行，在不干扰用户操作体验的前提下完成身份验证。

Nous 将 BotID 部署于其门户平台（Portal）与聊天界面（Chat）的关键校验节点：

- **门户平台（认证流程）：** BotID 校验在用户注册或登录前后均会执行；任一环节校验失败，即刻中止后续流程  

- **聊天界面（UI 层）：** 为防范针对聊天应用的 API 式滥用行为，Nous 实现了一套心跳检测机制（heartbeat mechanism）。聊天客户端通过 tRPC 定期触发 BotID 校验；校验成功后，结果将在后端缓存一段较短时间；仅当存在近期有效的人类身份验证记录时，推理请求（inference request）才被允许执行  

这一分层防护策略，既保障了用户入口的安全性，也持续覆盖了应用内的交互过程，从而兼顾安全防护与资源成本效率。

## BotID 成功拦截一次协同攻击，该攻击曾导致流量激增 3000%

10 月 16 日中午 12 点（澳大利亚东部标准时间，AEST），Nous 在未进行任何市场宣传的情况下悄然重新开放其免费服务层级。数日内，Vercel BotID 即检测并成功阻断了一次协同式攻击——攻击者迅速定位到开放的聊天接口，并试图大规模滥用。

![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_002.jpg)![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_003.jpg)

此次流量激增呈现出若干关键攻击信号：

- Five to six IPs generated most of the load with a long tail of smaller sources  
- 五到六个 IP 地址产生了大部分流量，其余流量则来自大量规模较小的来源。

- A majority of traffic originated from Japan  
- 绝大多数流量源自日本。

- 3–4 distinct JA4 hashes correlated across attack attempts  
- 在多次攻击尝试中，观察到 3–4 个不同的 JA4 哈希值存在关联性。

After BotID identified and blocked the traffic, the attack lasted two hours before attackers realized they couldn't perform any inference, and stopped. At its peak, Nous saw a 3,000% increase in traffic volume to its chat app. Despite thousands of attempted sign-ups, inference traffic and availability remained stable.  
BotID 识别并拦截该流量后，攻击持续了约两小时，直到攻击者意识到无法执行任何推理请求，才主动终止。在攻击峰值期间，Nous 的聊天应用流量激增至正常水平的 3,000%。尽管有数千次注册尝试，推理请求流量与服务可用性始终保持稳定。

Interestingly, the same JA4 fingerprints that BotID marked "human" at the sign-in portal later appeared as the most-blocked patterns in chat. This highlights how sophisticated attackers can adjust their attack patterns, and BotID's deeper behavioral analysis provides adaptive defense beyond surface-level protection.  
有趣的是，BotID 在登录门户处标记为“人类”的相同 JA4 指纹，后续却成为聊天接口中被拦截次数最多的模式。这凸显了高级攻击者灵活调整攻击手法的能力；而 BotID 借助更深层次的行为分析，提供了超越表层防护的自适应防御能力。

> “We didn’t see a spike in inference at all and our chat performance remained steady. The attack burned out once it became clear they couldn’t get past BotID. We didn’t see a spike in inference at all and our chat performance remained steady. The attack burned out once it became clear they couldn’t get past BotID.”  
> “我们完全没有观测到推理请求量的激增，聊天服务性能也始终平稳。一旦攻击者意识到无法绕过 BotID，此次攻击便迅速失效。”

> ![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_001.jpg)  
> ![](images/how-nous-research-used-botid-to-block-automated-abuse-at-scale-vercel/img_001.jpg)

> **Robin Fernandes,** Engineer at Nous Research  
> **Robin Fernandes**，Nous Research 工程师

## How BotID prevented abuse without impacting legitimate users  
## BotID 如何在不影响真实用户的情况下防范滥用行为

By deploying Vercel BotID at multiple points in its user flow, Nous Research prevented large-scale automated abuse before it could impact infrastructure, reduced wasted inference costs, and maintained app availability for its free tier without compromising security or user experience. And because BotID responded automatically, Nous did not have to spend valuable time or resources triaging traffic issues. Now they can continue their mission to host a free, open-source LLM for users around the world safely.  
Nous Research 在用户流程的多个关键节点部署 Vercel BotID，从而在自动化滥用行为影响基础设施之前即予以拦截，显著降低了无效推理所造成的资源浪费，并在不牺牲安全性与用户体验的前提下，保障了其免费服务层级的应用可用性。由于 BotID 可自动响应，Nous 无需投入宝贵的时间与人力进行流量问题排查。如今，他们得以继续安全地履行使命——面向全球用户免费提供开源大语言模型（LLM）服务。

[**Protect your most critical routes from automated abuse**  
**防范针对关键路由的自动化滥用行为**

Detect and stop advanced bots before they reach your most sensitive routes like login, AI inference, and APIs. Easy to implement, hard to bypass.  
在高级机器人触及您最关键的路由（如登录、AI 推理及 API 接口）之前，及时识别并阻断它们。部署简易，难以绕过。

Get started](http://vercel.com/botid)  
立即开始使用](http://vercel.com/botid)