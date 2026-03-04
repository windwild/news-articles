---
render_with_liquid: false
title: "Vercel's Black Friday-Cyber Monday 2024 recap - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/black-friday-cyber-monday-2024-recap"
date: "2024-12-03"
scraped_at: "2026-03-02T09:38:53.272966123+00:00"
language: "en-zh"
translated: true
description: "With 3B+ firewall blocks and 99.999+% uptime, top ecommerce brands like Under Armour, Fanatics, and ASICS trust Vercel’s Managed Infrastructure to handle the demand and ship with confidence."
---
render_with_liquid: false
render_with_liquid: false

Dec 3, 2024

2024年12月3日

The Black Friday-Cyber Monday (BFCM) stakes are high. Billions of dollars are on the line with consumers racing to save money over the biggest shopping days of the year.

“黑色星期五—网络星期一”（BFCM）购物季的博弈异常激烈。在这一年中规模最大的购物节期间，消费者争相抢购以节省开支，涉及金额高达数百亿美元。

This year, Vercel celebrated the success of our customers by building a [live dashboard](https://vercel.com/bfcm) showing activity across the platform for BFCM.

今年，Vercel 通过构建一个实时数据看板（[live dashboard](https://vercel.com/bfcm)），全面呈现平台在 BFCM 期间的运行活动，以此庆祝客户取得的卓越成绩。

![Final Black Friday-Cyber Monday 2024 metrics on Vercel](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_001.jpg)![Final Black Friday-Cyber Monday 2024 metrics on Vercel](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_002.jpg)

![Vercel 平台 2024 年“黑色星期五—网络星期一”最终数据概览](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_001.jpg)![Vercel 平台 2024 年“黑色星期五—网络星期一”最终数据概览](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_002.jpg)

Final Black Friday-Cyber Monday 2024 metrics on Vercel

Vercel 平台 2024 年“黑色星期五—网络星期一”最终数据概览

During BFCM 2024, Vercel handled:

在 2024 年 BFCM 期间，Vercel 平台处理了：

- **86,702,974,965** requests  
- **86,702,974,965** 次请求  

- **1,937,097** peak requests per second  
- 每秒峰值请求量达 **1,937,097** 次  

- **2,454,917** deployments  
- **2,454,917** 次部署  

- **3,052,195,860** system-triggered VercelFirewall blocks  
- **3,052,195,860** 次由系统触发的 Vercel Firewall 阻断事件

- **519,841,270** 次面向客户的 Vercel Web 应用防火墙（WAF）拦截  

- **519,841,270** 次针对客户定制的 Vercel Web 应用防火墙（WAF）拦截

Vercel 在“黑色星期五与网络星期一”（BFCM）期间实现了 **99.9992% 的正常运行时间**。Under Armour、Fanatics 和 ASICS 等顶级电商品牌均信赖 Vercel 的 [托管基础设施](https://vercel.com/docs/infrastructure)，以从容应对流量高峰，并自信交付产品。

Vercel 在“黑色星期五与网络星期一”（BFCM）期间实现了 **99.9992% 的正常运行时间**。Under Armour、Fanatics 和 ASICS 等顶级电商品牌均信赖 Vercel 的 [托管基础设施](https://vercel.com/docs/infrastructure)，以从容应对流量高峰，并自信交付产品。

> “去年的黑色星期五和网络星期一，是 NZXT 成立 20 年来首次实现零宕机。这直接意味着数百万美元的营收保障。”  
> “去年的黑色星期五和网络星期一，是 NZXT 成立 20 年来首次实现零宕机。这直接意味着数百万美元的营收保障。”  
>  
> ![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_003.png)  
>  
> **工程总监**，NZXT  

> “去年的黑色星期五和网络星期一，是 NZXT 成立 20 年来首次实现零宕机。这直接意味着数百万美元的营收保障。”  
> “去年的黑色星期五和网络星期一，是 NZXT 成立 20 年来首次实现零宕机。这直接意味着数百万美元的营收保障。”  
>  
> ![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_003.png)  
>  
> **工程总监**，NZXT  

## **弹性扩展，应对超常需求**

## **弹性扩展，应对超常需求**

在流量峰值期间，Vercel 每秒成功处理了 **超过 27 万次合法请求**，同时每秒抵御了 **超过 175 万次 DDoS 攻击请求**。此外，共执行了 **超过 289 亿次函数调用**（涵盖 Serverless Functions、Edge Functions 及 Edge Middleware）。Vercel 基础设施的每一层均为此提供支撑——动态自动扩缩容，让您无需为突发流量而担忧。

在流量峰值期间，Vercel 每秒成功处理了 **超过 27 万次合法请求**，同时每秒抵御了 **超过 175 万次 DDoS 攻击请求**。此外，共执行了 **超过 289 亿次函数调用**（涵盖 Serverless Functions、Edge Functions 及 Edge Middleware）。Vercel 基础设施的每一层均为此提供支撑——动态自动扩缩容，让您无需为突发流量而担忧。

- [函数故障转移区域](https://vercel.com/docs/functions/runtimes#failover-mode)：若某区域失去响应，Vercel 将自动将流量切换至健康区域，无需重新部署  

- [自动并发扩缩容](https://vercel.com/docs/functions/runtimes#automatic-concurrency-scaling)：Vercel 上所有函数均可根据实时负载自动扩缩容，轻松应对不可预测的流量激增  

- [函数故障转移区域](https://vercel.com/docs/functions/runtimes#failover-mode)：若某区域失去响应，Vercel 将自动将流量切换至健康区域，无需重新部署  

- [自动并发扩缩容](https://vercel.com/docs/functions/runtimes#automatic-concurrency-scaling)：Vercel 上所有函数均可根据实时负载自动扩缩容，轻松应对不可预测的流量激增  

## **速度与个性化体验兼得**

## **速度与个性化体验兼得**

Vercel 助力确保您的应用具备最优的速度、响应性、可靠性及整体运行效率——而这正是将访客转化为客户的关键所在。[多项研究显示](https://www.gigaspaces.com/blog/amazon-found-every-100ms-of-latency-cost-them-1-in-sales)，页面延迟每增加 100 毫秒，销售额即下降 1%。动态内容、外部服务连接以及个性化体验，本不必以牺牲性能为代价。

Vercel 助力确保您的应用具备最优的速度、响应性、可靠性及整体运行效率——而这正是将访客转化为客户的关键所在。[多项研究显示](https://www.gigaspaces.com/blog/amazon-found-every-100ms-of-latency-cost-them-1-in-sales)，页面延迟每增加 100 毫秒，销售额即下降 1%。动态内容、外部服务连接以及个性化体验，本不必以牺牲性能为代价。

Vercel 处理了 **超过 6000 万次结账路径请求**，并建立了 **超过 7.34 亿次与电商平台的连接**（涵盖 BigCommerce、Salesforce Commerce Cloud、Shopify 和 Stripe）。

Vercel 处理了 **超过 6000 万次结账路径请求**，并建立了 **超过 7.34 亿次与电商平台的连接**（涵盖 BigCommerce、Salesforce Commerce Cloud、Shopify 和 Stripe）。

- [Edge Middleware](https://vercel.com/docs/functions/edge-middleware)：边缘中间件  
- [边缘中间件](https://vercel.com/docs/functions/edge-middleware)：服务端个性化能力可在不依赖客户端的前提下，为用户提供高度定制化的体验。这不仅显著减少了可见的加载瑕疵（visible artifacts），还能基于用户行为、地理位置或用户分群数据，动态交付个性化的页面内容。

- [Incremental Static Regeneration (ISR)](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)：增量静态再生  
- [增量静态再生（ISR）](https://vercel.com/blog/isr-a-flexible-way-to-cache-dynamic-content)：静态资源可在无需重新部署的前提下，按需生成、更新，并自动缓存在您的站点上。这有助于提升性能表现、降低后端负载、加速构建过程，并提高服务可用性。

## Shipping on Fridays, and throughout the weekend  

## 周五及整个周末持续交付  

During BFCM, customers proved they’re ready to deploy on Fridays—and even weekends. Vercel did **2.4M+ deployments**, transforming code into production-ready infrastructure. With instant rollbacks, teams confidently shipped last-minute updates, fixes, and improvements.  

在“黑色星期五与网络星期一”（BFCM）大促期间，客户已充分证明：他们完全能够在周五——甚至整个周末——完成上线部署。Vercel 共完成了 **超 240 万次部署**，将代码快速转化为生产就绪的基础设施。凭借即时回滚能力，团队得以自信地交付临上线前的更新、修复与优化。

- [Framework-defined infrastructure:](https://vercel.com/blog/framework-defined-infrastructure) For each deployment, Vercel analyzes your code to allocate fast, scalable, and secure global infrastructure  

- [框架定义的基础设施（Framework-defined Infrastructure）](https://vercel.com/blog/framework-defined-infrastructure)：每次部署时，Vercel 均会分析您的代码，自动为您分配高性能、可扩展且安全的全球基础设施。

- [Instant Rollbacks](https://vercel.com/docs/deployments/instant-rollback): With one click, you can restore a previous deployment. This can be useful in situations that require a swift recovery from accidental bugs, allowing you to ship with confidence even during peak usage  

- [即时回滚（Instant Rollbacks）](https://vercel.com/docs/deployments/instant-rollback)：仅需单击一次，即可恢复至此前任一部署版本。该功能在遭遇意外 Bug 时尤为关键，可助您快速恢复服务，让您即便在流量高峰期间也能安心发布。

## Secure by default  

## 默认安全  

The Vercel Web Application Firewall (WAF) provides L3/L4 protection at every edge location, so your site stays protected without adding latency. Over BFCM, the Firewall handled **3B+ blocks, 2.2B+ challenges**, and **519M+ custom WAF blocks**, for a total of **6.3B+ Firewall actions** (including logging and other non-blocking events).  

Vercel Web 应用防火墙（WAF）在每个边缘节点均提供第 3 层（L3）与第 4 层（L4）防护，确保您的网站始终受到保护，且不会引入额外延迟。在 BFCM 期间，该防火墙共执行了 **超 30 亿次拦截（blocks）、超 22 亿次人机验证挑战（challenges）以及超 5.19 亿次自定义 WAF 拦截**，总计执行 **超 63 亿次防火墙操作**（含日志记录及其他非阻断类事件）。

- [DDoS mitigation](https://vercel.com/docs/security/vercel-firewall#ddos-mitigation): Vercel’s automated DDoS mitigation blocks incoming traffic identified as abnormal or suspicious without any manual configuration, saving resources for legitimate traffic  

- [DDoS 攻击缓解（DDoS Mitigation）](https://vercel.com/docs/security/vercel-firewall#ddos-mitigation)：Vercel 自动化 DDoS 缓解机制可实时识别并拦截异常或可疑的入站流量，全程无需人工配置，从而为合法流量节省宝贵资源。

- [Web Application Firewall (WAF)](https://vercel.com/docs/security/vercel-firewall#web-application-firewall-waf): WAF blocks specific requests based on your own business logic, allowing you to strengthen your security and helping you maintain control of your sites. [Persistent actions](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) stop repeat offenders early, blocking their requests within a specified timeframe and preventing unnecessary costs  

- [Web 应用防火墙（WAF）](https://vercel.com/docs/security/vercel-firewall#web-application-firewall-waf)：WAF 可依据您自定义的业务逻辑，精准拦截特定请求，从而增强安全性，并帮助您牢牢掌控网站访问权限。[持久化动作（Persistent Actions）](https://vercel.com/docs/security/vercel-waf/custom-rules#persistent-actions) 能够提前阻止屡次违规者——在指定时间窗口内直接拦截其全部请求，有效避免不必要的资源消耗与费用支出。

## Looking ahead to 2025

## 展望 2025

Overall, Vercel saw **80% growth in peak requests per second from BFCM 2023 to 2024.**  
总体而言，Vercel 在“黑色星期五与网络星期一”（BFCM）期间的每秒峰值请求数，从 2023 年到 2024 年实现了 **80% 的增长**。

From blocking billions of threats to powering millions of deployments, this BFCM showed companies can ship confidently on Vercel, even on the busiest days of the year.  
从拦截数十亿次网络威胁，到支撑数百万次应用部署，本届 BFCM 充分证明：企业完全可以在 Vercel 上自信交付产品——哪怕是在全年最繁忙的日子里。

Vercel provides the reliability and performance you need without worrying about infrastructure, giving you time to focus on building the best experience for your customers.  
Vercel 为您提供了所需的可靠性与性能，且无需操心底层基础设施，从而让您能将宝贵时间专注于为客户打造最佳体验。

Congratulations to our customers on a record-breaking BFCM on Vercel. We look forward to helping you achieve an even better BFCM in 2025.  
祝贺所有客户在 Vercel 上创造了破纪录的 BFCM 业绩！我们期待助力您在 2025 年实现更卓越的 BFCM 表现。

[**Prepare for BFCM 2025**\\  
\\  
If you’re looking ahead to next year’s BFCM, watch the recording of our Black Friday 2025 virtual event hosted by Vercel CTO Malte Ubl. \\  
\\  
Watch now](https://vercel.com/go/black-friday-2025?utm_source=vercel-site&utm_medium=blog&utm_campaign=WBN-Beyond-Black-Friday-2024-12-10)

[**为 2025 年 BFCM 做准备**\\  
\\  
若您正着眼于明年的 BFCM，请观看由 Vercel 首席技术官 Malte Ubl 主持的“2025 黑色星期五线上活动”录播回放。\\  
\\  
立即观看](https://vercel.com/go/black-friday-2025?utm_source=vercel-site&utm_medium=blog&utm_campaign=WBN-Beyond-Black-Friday-2024-12-10)

> “It’s just a pity we didn’t go sooner. Next.js and Vercel make our developers happier, make us go to market quicker, and let us move with confidence. It’s just a pity we didn’t go sooner. Next.js and Vercel make our developers happier, make us go to market quicker, and let us move with confidence. ”  
>  
> “真遗憾我们没有更早采用。Next.js 与 Vercel 让我们的开发者更快乐、让我们的产品更快上市、也让我们更有信心地快速迭代。真遗憾我们没有更早采用。Next.js 与 Vercel 让我们的开发者更快乐、让我们的产品更快上市、也让我们更有信心地快速迭代。”

> ![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_004.png)  
> ![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_004.png)

> **Jonathan Lemon,** Software Engineering Manager at Sonos  
> **Jonathan Lemon**，Sonos 软件工程经理

Blog post  
博客文章  

Nov 27, 2024  
2024 年 11 月 27 日  

### Retailer sees $10M increase in sales on Vercel  
### 零售商在 Vercel 上实现销售额激增 1000 万美元  

![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_005.jpg)  
![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_005.jpg)

Alina Weinstein  
Alina Weinstein

Blog post

博客文章

Jan 16, 2024

2024年1月16日

### Architecting a live look at reliability: Stripe's viral Black Friday site

### 构建实时可靠性视图：Stripe 爆火的黑色星期五网站

![](images/vercel_s-black-friday-cyber-monday-2024-recap-vercel/img_006.jpg)

Greta Workman

格蕾塔·沃克曼