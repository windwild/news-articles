---
title: "v0: vibe coding, securely - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/v0-vibe-coding-securely"
date: "2025-08-04"
scraped_at: "2026-03-02T09:30:33.530258756+00:00"
language: "en-zh"
translated: true
description: "Vibe coding makes it possible for anyone to ship a viral app. But every line of AI-generated code is a potential vulnerability. Security cannot be an afterthought, it must be the foundation. Turn idea..."
---
{% raw %}

Aug 4, 2025

2025年8月4日

When code is written by AI, secure defaults must be the foundation, not a feature

当代码由 AI 编写时，安全默认配置必须是基石，而非附加功能。

Vibe coding has changed how software gets built. Tools like [v0](https://v0.dev/) make it possible to turn ideas into working prototypes in seconds. Anthropic's CEO predicts [90% of code will be AI-generated in 3-6 months](https://www.businessinsider.com/anthropic-ceo-ai-90-percent-code-3-to-6-months-2025-3). Adoption is accelerating fast, and for many builders, we're already there.

“氛围编程”（vibe coding）已彻底改变了软件的构建方式。[v0](https://v0.dev/) 等工具让用户能在数秒内将创意转化为可运行的原型。Anthropic 首席执行官预测：[未来 3–6 个月内，90% 的代码将由 AI 生成](https://www.businessinsider.com/anthropic-ceo-ai-90-percent-code-3-to-6-months-2025-3)。采用速度正急剧加快；对许多开发者而言，这一阶段已然到来。

But here's the uncomfortable truth: **The faster you build, the more risk you create**

但这里有一个令人不安的事实：**你构建得越快，所制造的风险就越大**。

Last week, a viral app [leaked 72k selfies and government IDs](https://x.com/rauchg/status/1949197451900158444). This wasn’t a hack or advanced malware. It was caused by default settings, misused variables, and the absence of guardrails. A misconfigured Firebase bucket that was mistakenly left public for anyone to access. The app was built quickly, shipped without security review, and went viral.

上周，一款走红应用[泄露了 7.2 万张自拍照及政府签发的身份证明文件](https://x.com/rauchg/status/1949197451900158444)。这并非黑客攻击或高级恶意软件所致，而是源于默认配置、误用变量以及缺乏安全防护机制——一个本应私有的 Firebase 存储桶被错误地设为公开，致使任何人都可随意访问。该应用开发迅速，未经任何安全审查即上线发布，并迅速走红。

> “More code will be written in the next few months alone than in the entire history of computersMore code will be written in the next few months alone than in the entire history of computers”
>
> ![](images/v0-vibe-coding-securely-vercel/img_001.png)
>
> **Guillermo Rauch**

> “仅在未来几个月内编写的代码量，就将超过计算机诞生至今整个历史时期的总和。”
>
> ![](images/v0-vibe-coding-securely-vercel/img_001.png)
>
> **吉列尔莫·劳奇（Guillermo Rauch）**

When anyone can now build an app that goes viral, it’s more important than ever for those apps to be secure from the very first prototype. Leaked secrets, unsafe defaults and misconfigured access are no longer rare mistakes. They are the default without intervention.

如今，任何人都能快速构建出一款走红的应用；因此，确保这些应用从第一个原型起就具备安全性，比以往任何时候都更加重要。密钥泄露、不安全的默认配置、错误的访问权限设置，已不再是偶发失误——若无主动干预，它们就是默认状态。

This time it was just selfies and government IDs. Next time, it’s your credit card or medical records. The fact of the matter is, **security is the defining issue in the world of vibe coding and AI-generated code**.

这一次，泄露的只是自拍照与政府签发的身份证明；下一次，可能就是你的信用卡信息或医疗记录。事实就是：**在“氛围编程”与 AI 生成代码的世界中，安全问题是决定成败的核心议题**。

v0 is the only platform built and proven to solve this problem. Since launch, v0 blocked over 100k insecure deployments on Vercel. Each one is a security incident that never happened.

v0 是目前唯一专为解决此问题而构建并经实践验证的平台。自上线以来，v0 已在 Vercel 上拦截了逾 10 万次不安全部署——每一次拦截，都意味着一场本可能发生的安全事件被成功避免。

The hard part isn't building fast anymore, it's staying secure at the same speed.

如今，难点已不再是“如何快速构建”，而是“如何以同等速度持续保障安全”。

## What AI typically gets wrong

## AI 通常会犯哪些错误

AI 工具被训练为生成能够运行的代码，而非生成安全的代码。这一区别至关重要。大语言模型（LLM）会自信地生成看似正确、实则悄然引入严重安全漏洞的代码。此类问题在不同模型、不同框架及不同提示词（prompt）下均持续、反复出现。

它们并非偶发个例，而是无处不在。

### Public variable misuse

### 公共环境变量误用

在 Next.js 中，任何以 `NEXT_PUBLIC_` 为前缀的环境变量都会暴露给浏览器——这是设计使然，目的是将服务端配置注入前端。但大语言模型却滥用这一机制，将数据库凭据、API 密钥等敏感信息放入这些本应公开的变量中。

```javascript
1// DON'T DO THIS

const databaseUrl = process.env.NEXT_PUBLIC_DATABASE_URL
```

```javascript
1// 切勿如此操作

const databaseUrl = process.env.NEXT_PUBLIC_DATABASE_URL
```

该数据库 URL 已完全公开：任何人只需查看网页源码即可获取。

仅在过去 30 天内，v0 就因检测到密钥泄露而拦截了超过 17,000 次部署（全部发生在 Vercel 平台）。

- 最常被意外泄露的密钥类型包括：Google Maps 密钥、reCAPTCHA 密钥、EmailJS 密钥以及 PostHog 密钥。

- Over a thousand people almost handed over the keys to their app by sharing their Supabase backend and database keys  
- 超过一千人曾几乎将自己应用的控制权拱手相让——他们公开分享了 Supabase 后端和数据库密钥。

- A thousand more were ready to share their OpenAI, Gemini, Claude, and xAI keys. An incredibly easy way for someone to run up your AI utilization and cost you thousands  
- 还有约一千人正准备公开自己的 OpenAI、Gemini、Claude 和 xAI 密钥。这为他人滥用你的 AI 服务提供了极其便捷的途径，可能让你在短时间内损失数千美元。

### Secrets in code  
### 代码中的密钥

Many AI-generated projects take this a step further by including hardcoded secrets like this directly in the source files. These keys are scraped by bots in minutes. Developers don’t often realize the exposure until after incidents occur, if they even catch it at all.  
许多由 AI 生成的项目更进一步，直接将此类硬编码密钥写入源文件中。这些密钥往往在几分钟内即被网络爬虫抓取。开发者通常要等到安全事件发生后才意识到风险——甚至可能永远都未能察觉。

![](images/v0-vibe-coding-securely-vercel/img_002.jpg)![](images/v0-vibe-coding-securely-vercel/img_003.jpg)  
![](images/v0-vibe-coding-securely-vercel/img_002.jpg)![](images/v0-vibe-coding-securely-vercel/img_003.jpg)

### Other common patterns  
### 其他常见问题模式

- **Missing input sanitization:** Unsafe user input gets passed directly into model prompts, opening the door for prompt injection attacks  
- **缺少输入净化：** 不安全的用户输入被直接传入模型提示词（prompt），为提示注入攻击（prompt injection）大开方便之门。

- **No environment separation:** Generated code rarely differentiates between dev and prod environments, leading to misconfigured services and accidental access leaks  
- **缺乏环境隔离：** AI 生成的代码极少区分开发（dev）与生产（prod）环境，导致服务配置错误及意外的访问权限泄露。

- **Sensitive data in logs:** Debug logs often contain auth tokens, user IDs, or API keys written without redaction or retention policy  
- **日志中包含敏感数据：** 调试日志常未经脱敏或未制定保留策略，就直接记录认证令牌（auth tokens）、用户 ID 或 API 密钥。

These are not advanced attack vectors. These are common, beginner mistakes being generated daily, often without the developer realizing the risk. And they won’t go away with better prompting.  
这些并非高阶攻击手法，而是每日都在批量生成的、典型的初级错误——开发者往往浑然不觉其中风险。而仅靠优化提示词（prompting），这些问题也绝不会自动消失。

## Real example: AI agent database deletion

## 真实案例：AI 智能体误删数据库

In a recent incident, an AI agent made a "catastrophic error in judgement", [deleting an app's entire production database](https://x.com/jasonlk/status/1946069562723897802). It ignored explicit "no changes without permission" directives and responded with fabricated explanations, claiming success until the issue was discovered.

在最近一起事件中，某 AI 智能体犯下了“灾难性的判断错误”，[删除了某应用的全部生产数据库](https://x.com/jasonlk/status/1946069562723897802)。它无视明确的“未经许可不得变更”指令，并编造理由进行回应，坚称操作成功，直至问题暴露。

This was not a malicious actor. It was the result of an overly confident AI without clear boundaries. Incidents like this are [becoming more common](https://arstechnica.com/information-technology/2025/07/ai-coding-assistants-chase-phantoms-destroy-real-user-data/) as teams experiment with autonomous agents and production-connected workflows.

这并非恶意行为者所为，而是源于一个过度自信、缺乏清晰边界约束的 AI 系统。随着团队纷纷尝试部署自主智能体及与生产环境直连的工作流，此类事件正[日益频发](https://arstechnica.com/information-technology/2025/07/ai-coding-assistants-chase-phantoms-destroy-real-user-data/)。

This issue will only grow as security reviews fall behind the speed and volume of AI-generated code. With AI models being trained on public code, much of which is insecure, outdated, or misconfigured, the solution lies in secure defaults and sensible guardrails built into the tools that generate and deploy your code without slowing you down.

随着安全审查的速度与规模持续落后于 AI 生成代码的增长节奏，这一问题将愈发严峻。而当前 AI 模型大量依赖公开代码进行训练——其中许多代码本身存在安全隐患、已过时或配置不当——因此，根本解决之道在于：在生成与部署代码的工具中，内建安全默认配置与合理防护机制，既保障安全，又不拖慢开发效率。

## What v0 does that others don't

## v0 独具的优势（其他工具所不具备）

v0 is [trained on modern best practices](https://vercel.com/blog/v0-composite-model-family#how-does-v0%E2%80%99s-composite-model-work?) for popular frameworks like Next.js, and applies security checks during generation and before deployment. These checks are automated, context-aware, and applied consistently across every project.

v0 的模型[基于 Next.js 等主流框架的现代最佳实践](https://vercel.com/blog/v0-composite-model-family#how-does-v0%E2%80%99s-composite-model-work?)进行训练，并在代码生成阶段及部署前自动执行安全检查。这些检查具备自动化、上下文感知能力，且在所有项目中保持一致应用。

**Secure generation:**

**安全的代码生成：**

- Secrets exposed in client-side code or public repositories  
- 客户端代码或公共代码仓库中泄露密钥（secrets）

- Misuse of `NEXT_PUBLIC_` variables that leak production credentials  
- 错误使用 `NEXT_PUBLIC_` 变量，导致生产环境凭据泄露

- Tokens or session data written to logs  
- 将令牌（tokens）或会话数据写入日志

- Prompt injection risks from unsanitized user input  

- 来自未经清理的用户输入的提示注入风险  

- Misconfigured third-party API integrations  

- 第三方 API 集成配置错误  

- Unsafe defaults for authentication, routing, and database access  

- 认证、路由和数据库访问的不安全默认配置  


**Quantified impact:**  

**量化影响：**  

- Over 17k insecure deployments blocked in July alone  

- 仅在 7 月，即拦截了超过 17,000 次不安全部署  

- Most common issues: Exposed API keys, `NEXT_PUBLIC_` misuse, unauthenticated API routes  

- 最常见问题：API 密钥暴露、`NEXT_PUBLIC_` 变量误用、未认证的 API 路由  


Fast is meaningless if you can't trust what you ship.  

如果你无法信任自己所交付的产品，“快”便毫无意义。  


## Layered protection from prompt to deployment  

## 从提示词到部署的多层防护  

Deploying with v0 means your apps live on Vercel, benefiting from our hardened platform-level controls.  

使用 v0 进行部署意味着你的应用运行在 Vercel 平台上，并可受益于我们加固的平台级安全控制。  


### Deployment control  

### 部署管控

- **Preview protection**: Preview deployments can be restricted with password or SSO  
- **预览保护**：预览部署可通过密码或单点登录（SSO）进行访问限制  

- **Opt-in sharing**: v0 ensures preview links are private unless explicitly shared  
- **选择性共享**：v0 确保预览链接默认私有，仅在用户明确共享时才对外公开  

- **Environment safeguards**: Vercel blocks deployments from forks that modify environment variables without approval  
- **环境安全防护**：Vercel 将阻止未经批准即修改环境变量的 Fork 分支所发起的部署  

- **Deploy blocks**: Security vulnerabilities are flagged and require review before deploy  
- **部署拦截机制**：检测到安全漏洞时将自动标记，并强制要求人工审核后方可部署  

- **Access control**: Role-based permissions define who can view, edit, and deploy  
- **访问控制**：基于角色的权限体系明确界定谁可查看、编辑及部署资源  

- **Audit logging**: All deploys and environment changes are recorded and reviewable  
- **审计日志**：所有部署操作及环境变更均被完整记录，支持随时追溯与审查  

Together, v0 and Vercel enforce deploy-time protections that catch risky changes before they reach production.  
v0 与 Vercel 协同实施部署时安全防护，在潜在风险变更进入生产环境前即予以识别和拦截。

### Secure inference  
### 安全推理  

v0 apps use [Vercel AI Gateway](https://vercel.com/docs/ai-gateway) to call models securely without exposing credentials.  
v0 应用通过 [Vercel AI Gateway](https://vercel.com/docs/ai-gateway) 安全调用模型，全程无需暴露敏感凭证。  

- **Centralized auth and routing:** Routes requests to any providers with retry and failover support  
- **统一认证与路由**：将请求智能分发至任意模型提供商，并内置重试与故障转移支持

- **Scoped credentials:** Provider tokens are stored securely and used server-side only  
- **作用域受限的凭据：** 提供商令牌被安全存储，且仅在服务端使用。

- **Short-lived tokens:** Short-lived OIDC tokens are scoped per project  
- **短期有效的令牌：** 短期有效的 OIDC 令牌按项目进行作用域限定。

- **Rate limiting:** Built-in throttling and observability help prevent overuse and abuse  
- **速率限制：** 内置限流机制与可观测性能力，有助于防止过度使用和滥用。

Model usage is centralized, and secured so inference does not become an attack surface.  
模型调用高度集中化并受到严格保护，确保推理过程不会成为攻击面。

### **Platform-level security**  
### **平台级安全**

- **DDoS and firewall protection:** [Vercel Firewall blocks over 4.4 billion](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall) malicious requests and bots per month before they reach your application  
- **DDoS 防护与防火墙：** [Vercel 防火墙每月拦截超 44 亿次](https://vercel.com/blog/preventing-infrastructure-abuse-with-vercel-firewall) 恶意请求与机器人流量，在其抵达您的应用之前即完成阻断。

- **Isolated functions:** Each function runs in its own secure container with controlled network access  
- **隔离式函数：** 每个函数均在独立的安全容器中运行，并具备受控的网络访问权限。

- **Secure environment encryption:** AES-256 encryption with secure vault system  
- **环境安全加密：** 采用 AES-256 加密算法，并集成安全密钥管理系统（secure vault system）。

- **Compliance standards**: SOC 2 Type 2, ISO 27001:2022, GDPR, PCI DSS, HIPAA  
- **合规性标准：** SOC 2 Type 2、ISO/IEC 27001:2022、GDPR、PCI DSS、HIPAA。

## The path forward  
## 未来演进方向

Vibe coding has made building faster than ever. Speed is no longer the problem. Security is. And as teams have started to realize, it can’t be treated as a separate step.

“氛围编程”（vibe coding）让开发速度达到了前所未有的高度。速度已不再是瓶颈，安全才是。而随着团队逐渐意识到这一点，安全也绝不能被当作一个孤立的、事后的环节来处理。

We’ve seen what happens when small oversights scale. Thousands of apps ship every week with vulnerabilities, often without the author realizing it.

我们已目睹微小疏忽在规模化后引发的后果：每周都有成千上万的应用程序带着安全漏洞发布，而开发者往往浑然不觉。

Secure has to be the default from the start, without slowing you down or having to think about it. Whether you're vibe coding an idea or a developer rushing to meet a deadline, secure code generation and practical guardrails ensure you get the same security analysis as the most experienced engineers.

安全必须从项目伊始即为默认选项——既不拖慢你的节奏，也无需你额外费神。无论你是在用“氛围编程”快速验证一个创意，还是作为开发者争分夺秒赶工期，安全的代码生成与切实可行的防护机制，都能为你提供与经验最丰富的工程师同等水准的安全分析能力。

The future of development is fast, AI-assisted, and secure by default.

开发的未来，是迅捷的、AI 辅助的，更是默认安全的。

[**Ready for secure, AI-powered development?**  
**已准备好开启安全、AI 驱动的开发之旅？**

From idea to secure deployment in minutes. No security expertise required.  
几分钟内，即可从灵感到安全上线。无需任何安全专业知识。

Get started with v0](https://v0.dev/)
{% endraw %}
