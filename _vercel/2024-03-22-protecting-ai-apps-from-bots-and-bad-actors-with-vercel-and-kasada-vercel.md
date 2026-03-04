---
title: "Protecting AI apps from bots and bad actors with Vercel and Kasada - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/protecting-ai-apps-with-vercel-and-kasada"
date: "2024-03-22"
scraped_at: "2026-03-02T09:46:01.220622454+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel protects the AI SDK Playground using our best-in-class DDoS mitigation, Next.js Middleware, and our partner Kasada."
---

render_with_liquid: false
Mar 22, 2024

2024 年 3 月 22 日

展示 AI 工作负载面临的威胁向量，以及我们如何保障 Vercel AI SDK Playground 的安全。

AI 应用的日益普及，加之支撑这些调用的大语言模型（LLM）成本相对高昂，使得 AI 应用已成为机器人和恶意行为者极具吸引力的高价值攻击目标。

Vercel 行业领先的[DDoS 缓解方案](https://vercel.com/docs/security/ddos-mitigation)（包括我们近期推出的[攻击挑战模式](https://vercel.com/docs/security/attack-challenge-mode)）构成了第一道防线。借助内置的第 3 层（L3）、第 4 层（L4）和第 7 层（L7）防护能力，[Vercel 防火墙](https://vercel.com/docs/security/vercel-firewall)利用数百种信号与检测因子，对请求模式进行“指纹识别”，判断其是否疑似攻击行为，并对可疑请求发起验证挑战或直接拦截阻断。

为确保用户在我们的产品中持续开展 AI 实验，必须主动保护计算资源免遭未授权使用——尤其要保障和加固 AI 调用等高价值操作的安全性。

这一需求的典型体现便是 Vercel 的 AI Playground：它为用户提供了一个统一仪表板，可便捷地实验数十种不同的大语言模型（LLM）。该仪表板每月产生数百万次活跃生成请求，而被拦截的机器人流量更是高达其五倍。

本文将介绍我们如何结合 Next.js 中间件（Middleware）及合作伙伴[Kasada](https://www.kasada.io/)，进一步加固 AI SDK Playground，提供更全面的防护能力。

[**保护您的 AI 工作负载。**  
了解 Vercel 与 Kasada 如何协同合作，在您的 AI 应用中防范滥用行为。  
查看模板](https://vercel.com/templates/next.js/advanced-ai-bot-protection)

### **新风险，旧攻击向量**

由于 AI 计算的特性，攻击者正通过自动化脚本和机器人，以两种主要方式滥用 AI 应用，从而推高运营成本：

1. **Denial of Wallet Attacks:** Malicious entities deploy bots aiming to inflate the operational costs of AI applications, essentially forcing the target to incur unwarranted financial burdens.

1. **钱包拒绝攻击（Denial of Wallet Attacks）：** 恶意实体部署机器人，旨在抬高 AI 应用的运营成本，实质上迫使目标承担本不应有的财务负担。

2. **Prompt Injection Attacks:** Attackers abuse AI applications in an attempt to generate unintended responses and extract sensitive data from business logic or queries embedded within; this redirects computational expenses onto the victim, essentially leveraging expensive AI APIs without bearing the cost themselves.

2. **提示注入攻击（Prompt Injection Attacks）：** 攻击者滥用 AI 应用，试图生成非预期响应，并从中提取嵌入在业务逻辑或查询中的敏感数据；此举将计算开销转嫁至受害者，实质上是在不承担任何费用的情况下，滥用昂贵的 AI API。

These threats are not just hypothetical; they have materialized across various platforms, as evidenced by incidents documented on [GitHub](https://github.com/acheong08/ChatGPT) and [other repositories](https://github.com/reorx/awesome-chatgpt-api), where attackers have sought to bypass payment mechanisms to access AI services.

这些威胁并非仅停留在理论层面；它们已在多个平台上真实发生。例如，[GitHub](https://github.com/acheong08/ChatGPT) 和 [其他代码仓库](https://github.com/reorx/awesome-chatgpt-api) 中记录的事件表明，攻击者曾试图绕过付费机制以非法获取 AI 服务。

## **Vercel's AI SDK Playground: A case study in bot mitigation**

## **Vercel AI SDK Playground：机器人防护的典型案例**

The [Vercel AI SDK Playground](https://sdk.vercel.ai/) presents a compelling case study in addressing these challenges. Designed as a sandbox for exploring a variety of AI models, it implements a tiered access system based on user authentication, from anonymous users to verified customers.

[Vercel AI SDK Playground](https://sdk.vercel.ai/) 为应对上述挑战提供了一个极具说服力的实践案例。该平台被设计为一个用于探索多种 AI 模型的沙盒环境，其访问权限采用基于用户身份认证的分级体系，覆盖从匿名用户到已验证客户的不同层级。

This structure, however, also painted a target on the platform for attackers seeking unauthorized access to AI capabilities.

然而，这一架构也使平台成为攻击者的明确目标——他们企图绕过授权机制，非法获取 AI 能力。

### **The challenge**

### **面临的挑战**

Our initial observations were alarming; the platform quickly became a target for abuse, primarily from two groups:

我们最初的观察令人警觉：该平台迅速成为滥用行为的目标，主要来自以下两类群体：

- Those seeking free access to AI models.

- 试图免费访问 AI 模型的用户。

- Individuals circumventing geographical restrictions on certain AI technologies.

- 试图规避特定 AI 技术地理限制的个人。

Despite implementing basic bot protection measures, we realized that the attackers' motivations were strong enough to drive them to find workarounds. It became clear that a more sophisticated solution was necessary.

尽管已实施基础的机器人防护措施，我们意识到攻击者的动机足够强烈，足以驱使他们不断寻找绕过手段。显然，我们需要一套更为先进的解决方案。

### **Integrating Kasada: A turnkey solution**

### **集成 Kasada：开箱即用的解决方案**

The introduction of Kasada's bot protection technology marked a turning point in our battle against these threats. By integrating Kasada's solution, we observed an immediate cessation of the abusive activities that had plagued our platform.

Kasada 机器人防护技术的引入，成为我们应对这些威胁的关键转折点。集成 Kasada 解决方案后，此前长期困扰我们平台的恶意行为立即停止。

The implementation of a 1st-party-request-only protocol, enforced through Next.js Middleware, allowed us to intercept and block bot-driven API calls based on Kasada's bot classification.

通过 Next.js 中间件强制执行“仅限第一方请求”协议，我们得以依据 Kasada 的机器人分类结果，拦截并阻断由机器人发起的 API 调用。

The results were striking. Upon deploying Kasada, **we saw an immediate drop in bot traffic, from a staggering 84% of our traffic to negligible levels.**

成效极为显著。部署 Kasada 后，**机器人流量立即大幅下降——从原先惊人的占总流量 84%，骤降至可忽略不计的水平。**

![Chart showing continued steady human traffic even as bot traffic increased.](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_001.jpg)![Chart showing continued steady human traffic even as bot traffic increased.](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_002.jpg)![Chart showing continued steady human traffic even as bot traffic increased.](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_003.jpg)![Chart showing continued steady human traffic even as bot traffic increased.](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_004.jpg)Chart showing continued steady human traffic even as bot traffic increased.

![图表显示：即使机器人流量上升，人类用户流量仍保持稳定。](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_001.jpg)![图表显示：即使机器人流量上升，人类用户流量仍保持稳定。](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_002.jpg)![图表显示：即使机器人流量上升，人类用户流量仍保持稳定。](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_003.jpg)![图表显示：即使机器人流量上升，人类用户流量仍保持稳定。](images/protecting-ai-apps-from-bots-and-bad-actors-with-vercel-and-kasada-vercel/img_004.jpg)图表显示：即使机器人流量上升，人类用户流量仍保持稳定。

## How it works

## 其工作原理

Kasada provides dynamic defense against automated threats with a platform that is quick to evolve, difficult to evade, and invisible to humans. Protections are immediate and long-lasting without the need for any management and can be easily integrated with their API.

Kasada 提供针对自动化威胁的动态防御能力，其平台具备快速迭代、难以规避、对人类用户完全无感的特点。防护效果即时生效、持久有效，且无需人工干预；同时，可通过其 API 快速便捷地完成集成。

middleware.js

```javascript
import { NextResponse } from 'next/server';
```

```javascript
import { kasada } from '@lib/kasada-api';



export default async function middleware(request) {

5  const { error, context } = await kasada.classify(request);



7  // 如果 Kasada 服务不可用或发生其他故障，则采用“失效开放”（fail open）策略，避免影响用户

8  if (error) {

9    console.error(`Kasada 失效开放，错误信息：${error}`);

10    return NextResponse.next();

11  }
```

13  // 如果请求来自恶意机器人（Bad Bot），则拦截该请求并返回可自定义的响应

14  if (context.response) {

15    return kasada.prepareResponse(context.response, context);

16  }



18  // 未检测到恶意机器人，继续执行下一个路由处理器

19  return NextResponse.next();

20}
```

Kasada 是一个深度集成、分层防护的安全平台，综合运用了强大的客户端防护机制、基于 AI/ML 的服务端异常行为检测、无感挑战（invisible challenges）以及数据完整性校验，从而有效防止数据篡改和重放攻击。

## Ongoing collaboration to shield AI applications

## 持续合作，守护 AI 应用安全

Our collaboration with Kasada exemplifies Vercel's dedication to pioneering secure and scalable web infrastructure solutions. As we continue to navigate the complexities of AI application security, partnerships like these are invaluable.

我们与 Kasada 的合作，充分体现了 Vercel 致力于开创安全、可扩展的 Web 基础设施解决方案的坚定承诺。在持续应对 AI 应用安全复杂挑战的过程中，此类合作伙伴关系尤为宝贵。

The journey with Kasada is just the beginning. As AI technologies continue to evolve, so, too, will the strategies to protect them. Through continuous innovation and collaboration, we remain dedicated to offering our users a secure, efficient, and accessible digital experience.

与 Kasada 的合作之旅才刚刚开始。随着 AI 技术不断演进，保护这些技术的策略也将同步升级。通过持续创新与紧密协作，我们始终致力于为用户提供安全、高效且易于访问的数字体验。

[**Industry-leading security.**\\
\\
Learn more about Vercel's robust security and DDoS mitigation for your critical applications.\\
\\
Talk with an Expert](https://vercel.com/contact/sales)

[**业界领先的网络安全能力。**\\
\\
深入了解 Vercel 为关键应用提供的强大安全防护与 DDoS 缓解方案。\\
\\
联系专家](https://vercel.com/contact/sales)