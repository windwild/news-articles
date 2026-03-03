---
title: "Vercel's bot verification now supports Web Bot Auth - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercels-bot-verification-now-supports-web-bot-auth"
date: "2025-08-12"
scraped_at: "2026-03-02T09:29:53.333517982+00:00"
language: "en-zh"
translated: true
description: "Vercel's bot verification system now supports Web Bot Auth, a proposal that leverages HTTP Message Signatures, enabling Vercel to verify traffic automation from dynamic and distributed sources."
---

Aug 12, 2025

2025 年 8 月 12 日

We collaborated with industry partners to advance the IETF proposal for [Web Bot Auth](https://datatracker.ietf.org/doc/html/draft-meunier-web-bot-auth-architecture) and [Vercel's bot verification system](https://vercel.com/docs/bot-management#verified-bots) supports the new protocol. Now, [Bot Protection](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) can use [HTTP Message Signatures](https://www.rfc-editor.org/rfc/rfc9421.html) to verify traffic automation from dynamic and distributed sources.

我们与行业合作伙伴协作，共同推进 IETF 关于 [Web Bot Auth](https://datatracker.ietf.org/doc/html/draft-meunier-web-bot-auth-architecture) 的提案；同时，[Vercel 的机器人验证系统](https://vercel.com/docs/bot-management#verified-bots) 已支持该新协议。如今，[Bot Protection（机器人防护）](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset) 可借助 [HTTP 消息签名（HTTP Message Signatures）](https://www.rfc-editor.org/rfc/rfc9421.html)，对来自动态化及分布式来源的流量自动化行为进行验证。

Vercel maintains a comprehensive and actively curated [directory of known bots](https://bots.fyi/) that are verified by IP, reverse DNS, and now Web Bot Auth, which verifies bots via public-key cryptography in signed headers. This ensures that legitimate automation, like SEO crawlers, performance monitoring tools, and platform-integrated AI bots, can reliably access your site, while spoofed bots are blocked.

Vercel 维护着一个全面且持续更新的 [已知机器人目录（directory of known bots）](https://bots.fyi/)，其中的机器人通过 IP 地址、反向 DNS 查询，以及最新的 Web Bot Auth 进行验证——后者利用公钥密码学，在经签名的 HTTP 请求头中完成机器人身份核验。此举确保了合法的自动化工具（如搜索引擎爬虫、性能监控工具，以及与平台集成的 AI 机器人）能够稳定、可靠地访问您的网站，而伪造身份的恶意机器人则被有效拦截。

Web Bot Auth's asymmetric signature proves the authenticity of the traffic regardless of its network origin, making it ideal for bots running in dynamic or serverless environments.

Web Bot Auth 所采用的非对称签名机制，可独立于网络来源验证流量的真实性，因而特别适用于在动态环境或无服务器（serverless）环境中运行的机器人。

Verified Bots using Web Bot Auth include signed headers to authenticate each request, allowing them to be recognized and allowed through Bot Protection and Challenge Mode. For example, [ChatGPT operator signs its requests](https://help.openai.com/en/articles/11845367-chatgpt-agent-allowlisting) using Web Bot Auth, so is now allowed.

采用 Web Bot Auth 的已验证机器人（Verified Bots）会在每个请求中附带已签名的请求头，从而实现身份认证，使其可被 Bot Protection（机器人防护）和 Challenge Mode（挑战模式）识别并放行。例如，[ChatGPT 运营商（ChatGPT operator）即使用 Web Bot Auth 对其请求进行签名](https://help.openai.com/en/articles/11845367-chatgpt-agent-allowlisting)，因此现已获准通行。

Learn more about [Bot Management](https://vercel.com/docs/bot-management).

了解更多关于 [Bot Management（机器人管理）](https://vercel.com/docs/bot-management) 的信息。