---
title: "Billions of requests: Black Friday-Cyber Monday 2025 - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/bfcm-2025"
date: "2025-12-02"
scraped_at: "2026-03-02T09:24:44.754017116+00:00"
language: "en-zh"
translated: true
description: "Every year, Black Friday and Cyber Monday reveal how people shop, browse, and discover products at global scale. For Vercel, the weekend is not a different operating mode. The platform behaves the sam..."
---

render_with_liquid: false
Dec 2, 2025

2025年12月2日

Every year, Black Friday and Cyber Monday reveal how people shop, browse, and discover products at global scale. For Vercel, the weekend doesn't require a different operating mode. The platform behaves the same way it does [every day](https://vercel.com/blog/just-another-black-friday), only with higher traffic volume.

每年的“黑色星期五”（Black Friday）和“网络星期一”（Cyber Monday）都揭示了全球用户购物、浏览及发现商品的行为模式。对 Vercel 而言，这个周末无需切换至不同的运行模式——平台的表现与[平日完全一致](https://vercel.com/blog/just-another-black-friday)，仅需应对更高的流量压力。

A [live dashboard](https://vercel.com/bfcm) showed the traffic as it played out.

我们通过一个[实时仪表盘](https://vercel.com/bfcm)全程追踪并直观呈现了此次流量变化。

This year, traffic reached more than 115.8 billion total requests, reflecting 33.6% year-over-year growth with consistent performance throughout the events.

今年，总请求数量突破 1158 亿次，同比增长 33.6%，且在整个活动期间始终保持稳定性能。

The traffic shape told a familiar story. Requests dipped on Thanksgiving as people stepped away from screens, then surged on Black Friday, stayed elevated through the weekend, and built into a second wave on Cyber Monday.

流量走势呈现出熟悉的节奏：感恩节当天，随着人们暂时远离屏幕，请求量出现回落；随后在“黑色星期五”迎来激增，并在整个周末持续高位运行；最终于“网络星期一”再度掀起第二波高峰。

These rhythms played out across every major geography, and the platform adapted continuously without configuration changes or manual intervention.

上述节奏在全球各主要地理区域同步上演，而平台全程自动适应，无需任何配置调整或人工干预。

Below is a snapshot of what the weekend looked like.

以下为本周末流量表现的概览快照。

## **Key metrics from the weekend**

## **本周末关键指标**

- **115,836,126,847 total requests** -Global traffic delivered with consistent performance.

- **总计 115,836,126,847 次请求** —— 全球流量平稳交付，性能始终如一。

- **518,027 peak requests per second -** Traffic delivered at peak demand

- **每秒峰值请求量达 518,027 次** —— 在需求峰值时刻仍保障流量高效交付。

- **6,120,247 deployments** — New versions of applications shipped  
- **6,120,247 次部署** — 应用程序新版本发布

- **24,086,391 AI Gateway requests** — AI routing kept responses fast across providers  
- **24,086,391 次 AI 网关请求** — AI 路由确保跨供应商的响应速度

- **43,213,555,901 Fluid compute invocations** — Dynamic workloads scaled automatically  
- **43,213,555,901 次 Fluid 计算调用** — 动态工作负载自动弹性伸缩

- **56,926,096,915 cache hits** — Fast delivery directly from globally distributed regions  
- **56,926,096,915 次缓存命中** — 直接从全球分布式区域快速交付内容

- **1,809,912,897 ISR reads** — Initial regional loads of refreshed content, does not count cached responses  
- **1,809,912,897 次 ISR 读取** — 刷新内容的首次区域加载（不计入已缓存的响应）

- **1,517,476,504 ISR writes** — Catalog, pricing, and content updates propagated instantly  
- **1,517,476,504 次 ISR 写入** — 商品目录、价格及内容更新即时同步

- **7,507,223,309 firewall actions** — Threats filtered before reaching applications  
- **7,507,223,309 次防火墙操作** — 威胁在抵达应用程序前即被过滤

- **415,683,895 bots blocked** — Automated abuse stopped early  
- **415,683,895 个机器人被拦截** — 自动化滥用行为被及早阻断

- **2,408,122,336 humans verified** — Legitimate shoppers passed security checks  
- **2,408,122,336 次人类身份验证** — 合法购物者顺利通过安全检查

- **Top regions:** US, DE, GB, IN, BR, SG, JP — with high activity across all 20 global regions  
- **活跃度最高的地区：** 美国（US）、德国（DE）、英国（GB）、印度（IN）、巴西（BR）、新加坡（SG）、日本（JP）—— 全球 20 个地区均保持高活跃度

## **Global scale and natural traffic rhythms**

## **全球规模与自然的流量节律**

Of the **115 billion requests** that flowed through Vercel from November 28 through December 1, the United States led activity with over **40.7 billion requests**, followed by Germany, the United Kingdom, India, Brazil, Singapore, and Japan. Traffic moved across time zones throughout the weekend, with peaks in one region balanced by lower activity in others.

在 11 月 28 日至 12 月 1 日期间，经由 Vercel 处理的请求总量达 **1150 亿次**，其中美国以超过 **407 亿次请求** 居首，其后依次为德国、英国、印度、巴西、新加坡和日本。整个周末，流量随全球不同时区自然流动：某一区域出现高峰时，其他区域则相应呈现较低活跃度，彼此动态平衡。

Vercel handled these shifts the same way it manages everyday production traffic, scaling the global network and compute layer to match real user behavior.

Vercel 以处理日常生产流量的相同方式应对这些波动——自动扩展全球网络与计算层，精准匹配真实用户的访问行为。

### **AI Gateway supported AI-native shopping at global scale**

### **AI Gateway 支持面向全球规模的 AI 原生购物体验**

AI continued to shape how shoppers discovered products, searched catalogs, and received personalized help. More than **24 million AI requests** passed through [AI Gateway](https://vercel.com/ai-gateway) across the BFCM window. Retailers used AI for search, recommendations, guided browsing, and customer support. AI Gateway routed these queries across providers and regions, maintaining low latency and resilience even when demand fluctuated.

AI 持续重塑消费者发现商品、搜索商品目录及获取个性化帮助的方式。在“黑色星期五与网络星期一”（BFCM）促销窗口期间，超过 **2400 万次 AI 请求** 经由 [AI Gateway](https://vercel.com/ai-gateway) 处理。零售商将 AI 应用于搜索、商品推荐、引导式浏览以及客户服务等场景。AI Gateway 在不同供应商与地理区域之间智能路由这些请求，即便需求剧烈波动，仍可保障低延迟与高韧性。

AI is now part of the normal shopping experience. Routing, failover, and provider coordination are essential when millions of customers depend on AI-powered workflows. AI Gateway delivered this consistency at global scale.

AI 已成为购物体验的常规组成部分。当数百万用户依赖 AI 驱动的工作流时，智能路由、故障自动转移（failover）以及供应商协同便至关重要。AI Gateway 在全球范围内实现了这种一致性保障。

### **Fluid compute matched real traffic automatically**

### **Fluid Compute 自动适配真实流量变化**

[Fluid compute](https://vercel.com/fluid) handled more than **43.2 billion function invocations** across the weekend. Teams used it for personalization logic, cart behavior, content evaluation, and AI inference. Fluid adjusts instantly to incoming traffic. Capacity increases the moment volume rises and scales back when demand settles. With automated pre-warming, and no tuning or configuration required.

[Fluid compute](https://vercel.com/fluid) 在整个周末处理了逾 **432 亿次函数调用**。开发团队将其用于个性化逻辑、购物车行为处理、内容评估及 AI 推理等任务。Fluid 可即时响应入站流量变化：流量上升时立即扩容，需求回落时自动缩容。整个过程支持自动化预热（pre-warming），无需人工调优或配置。

This elasticity is part of the platform’s normal operation and ensures applications stay responsive regardless of traffic shape.

这种弹性伸缩能力是平台的固有特性，确保应用在任何流量形态下均能保持响应迅速。

### **Incremental Static Regeneration kept content fresh and fast**

### **增量静态再生（ISR）让内容既新鲜又迅捷**

Product catalogs, pricing details, inventory indicators, and promotions changed continuously throughout the event. ISR processed more than **1.8 billion reads** and **1.5 billion writes**, refreshing content across the CDN without requiring redeploys or adding strain to backend systems.

活动期间，商品目录、价格详情、库存状态指示器及促销信息持续动态更新。ISR 处理了超过 **18 亿次读取** 和 **15 亿次写入**，在不需重新部署、也不增加后端系统负载的前提下，实时刷新了 CDN 全网内容。

Shoppers received accurate information at static performance speeds, even as merchandisers updated content minute by minute.

即便商品运营人员以分钟级频率更新内容，消费者仍能以静态页面般的性能速度获取准确信息。

### **Security systems filtered billions of unwanted requests**

### **安全系统过滤了数十亿条恶意请求**

Security activity increased alongside customer traffic. More than **7.5 billion firewall actions** were taken across system rules and customer-defined WAF logic. These protections stopped invalid and malicious traffic at the edge, preserving compute capacity and ensuring stable performance.

随着用户流量激增，安全防护活动同步加强。系统规则与客户自定义的 WAF（Web 应用防火墙）逻辑共同触发了超过 **75 亿次防火墙操作**。这些防护机制在边缘节点即刻拦截无效及恶意流量，有效保护计算资源，保障服务稳定运行。

Bot Management also operated at massive scale. More than **415 million bot attempts** were identified and blocked, while more than **2.4 billion** legitimate human interactions were verified through invisible checks by both [Vercel BotID](https://vercel.com/docs/botid) and system security defenses. Retailers protected checkout flows, inventory endpoints, and account systems without introducing friction.

Bot 管理系统亦以超大规模运行：识别并拦截了超过 **4.15 亿次机器人攻击尝试**；同时，通过 [Vercel BotID](https://vercel.com/docs/botid) 与系统级安全防御联合执行的无感验证，成功确认了逾 **24 亿次真实人类用户交互**。零售商在零感知摩擦的前提下，全面保护了结账流程、库存接口及账户系统。

### **Caching delivered fast performance worldwide**

### **缓存实现全球范围内的极速响应**

More than **56.9 billion requests** were served directly from Vercel’s global cache. These cache hits reduced latency, decreased backend load, and ensured fast page delivery throughout the weekend. Caching works in tandem with ISR and Fluid compute, forming a multi-layer performance system where static assets stay fast, dynamic updates propagate instantly, and compute is reserved for real application logic.

Vercel 全球缓存直接响应了逾 **569 亿次请求**。这些缓存命中显著降低了延迟、减轻了后端负载，并确保整个周末期间页面始终快速交付。缓存机制与 ISR（增量静态再生）及 Fluid Compute（弹性计算）协同工作，构建起多层级性能体系：静态资源保持极致速度，动态更新即时生效，而计算资源则专用于核心业务逻辑。

### **A platform built for everyday traffic, even when every day is bigger**

### **为日常流量而建的平台，亦从容应对“日日皆峰值”**

The 2025 traffic profile reinforces that large events do not require special preparation when the delivery layer is built to adapt to real user behavior. Cache hits, ISR updates, Fluid compute, AI routing, and firewall filtering worked together to absorb global demand. Development teams deployed more than **6.1 million** times across the weekend, shipping updates continuously with the confidence provided by instant rollbacks and predictable reliability.

2025 年流量模型进一步印证：只要交付层具备适应真实用户行为的能力，大型活动便无需特殊预案。缓存命中、ISR 更新、Fluid Compute、AI 路由与防火墙过滤协同作用，高效承载了全球激增的访问需求。开发团队在整个周末期间完成了逾 **610 万次部署**，依托即时回滚能力与可预期的高可靠性，持续交付功能更新。

[**How you can build for peak traffic with Vercel and Contentful**\\
\\
Watch this video on-demand to see how you can build for traffic surges, with optimized caching strategies and self-driving infrastructure.\\
\\
Build for peak traffic](https://vercel.com/go/bfcm-webinar-contentful-vercel)

[**如何借助 Vercel 与 Contentful 构建峰值流量应对能力**\\
\\
点击观看本按需视频，了解如何通过优化的缓存策略与自主驱动型基础设施，从容应对流量洪峰。\\
\\
构建峰值流量应对能力](https://vercel.com/go/bfcm-webinar-contentful-vercel)

### **Looking ahead**

### **展望未来**

As AI-driven experiences expand, as personalization deepens, and as global traffic patterns evolve, the infrastructure behind these applications must adapt at the speed of real users. Vercel’s software layer does this every day. Black Friday through Cyber Monday simply highlight the scale of normal operations.

随着 AI 驱动的用户体验不断扩展、个性化程度持续加深，以及全球流量模式不断演变，支撑这些应用的基础设施必须以真实用户的速度快速适应。Vercel 的软件层每天都在践行这一点。黑色星期五至网络星期一（Cyber Monday）大促期间的流量高峰， merely 突显了其日常运营所承载的规模。

If you are preparing for your next peak moment, explore how AI Gateway, Fluid compute, ISR, and Vercel’s security tools fit into your architecture. The teams who thrive during high-pressure events are the ones who adopt adaptive infrastructure before they need it.

如果您正在为下一次流量高峰做准备，请深入探索 AI Gateway、Fluid Compute、ISR（增量静态再生）以及 Vercel 安全工具如何融入您的架构。那些在高压事件中脱颖而出的团队，正是那些在需求出现之前就已采用自适应基础设施的团队。

[**Deploy your own BFCM website**\\
\\
Design engineer and v0 user, Abil Shrestha, rebuilt our Black Friday-Cyber Monday site and published it as a forkable template you can try today.\\
\\
Fork the v0 app](https://v0.app/templates/vercel-blackfriday-map-hUI7hCyGNye)

[**部署您自己的黑五/网一网站**\\
\\
设计工程师兼 v0 用户 Abil Shrestha 重构了我们的黑色星期五—网络星期一活动网站，并将其发布为一个可直接 Fork 的模板，您今天即可试用。\\
\\
Fork 这个 v0 应用](https://v0.app/templates/vercel-blackfriday-map-hUI7hCyGNye)