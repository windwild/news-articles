---
title: "How to integrate AI into your business - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/how-to-integrate-ai-into-your-business"
date: "2024-08-06"
scraped_at: "2026-03-02T09:42:25.195751591+00:00"
language: "en-zh"
translated: true
description: "Learn to build robust AI use cases, evaluate initiatives, and integrate AI into your team's workflow. Discover how Vercel's platform accelerates AI development and drives innovation."
---

render_with_liquid: false
Aug 6, 2024

2024 年 8 月 6 日

A strategic guide and framework for AI feature development.

一份面向 AI 功能开发的战略指南与实施框架。

Implementing AI in your business can be challenging due to the rapid pace of change, the complexity of integration, and the need for specialized skills.

在企业中落地 AI 可能面临诸多挑战：技术迭代迅速、系统集成复杂，且对专业技能有较高要求。

This guide helps leaders identify and evaluate AI use cases. We'll also show you how Vercel's Frontend Cloud and AI SDK can speed up your AI projects. Companies like Tome, Chick-fil-A, Chatbase, Runway, and Suno are already using these tools to bring AI into their apps and workflows.

本指南将帮助企业管理者识别并评估 AI 使用场景。我们还将介绍 Vercel 的 Frontend Cloud（前端云）和 AI SDK 如何加速您的 AI 项目开发。Tome、Chick-fil-A、Chatbase、Runway 和 Suno 等公司已借助这些工具，将 AI 深度融入其应用与工作流中。

# Contents

# 目录

1. [Building a robust AI use case](https://vercel.com/blog/how-to-integrate-ai-into-your-business#building-a-robust-ai-use-case)  
1. [构建稳健的 AI 使用场景](https://vercel.com/blog/how-to-integrate-ai-into-your-business#building-a-robust-ai-use-case)  
2. [Identifying target use cases](https://vercel.com/blog/how-to-integrate-ai-into-your-business#identifying-target-use-cases)  
2. [识别目标使用场景](https://vercel.com/blog/how-to-integrate-ai-into-your-business#identifying-target-use-cases)  
3. [Evaluating AI use cases](https://vercel.com/blog/how-to-integrate-ai-into-your-business#evaluating-ai-use-cases)  
3. [评估 AI 使用场景](https://vercel.com/blog/how-to-integrate-ai-into-your-business#evaluating-ai-use-cases)  
4. [Developing key performance indicators (KPIs)](https://vercel.com/blog/how-to-integrate-ai-into-your-business#developing-key-performance-indicators-(kpis))  
4. [制定关键绩效指标（KPI）](https://vercel.com/blog/how-to-integrate-ai-into-your-business#developing-key-performance-indicators-(kpis))  
5. [Integrating AI into your team’s workflow](https://vercel.com/blog/how-to-integrate-ai-into-your-business#integrating-ai-into-your-team%E2%80%99s-workflow)  
5. [将 AI 融入团队工作流](https://vercel.com/blog/how-to-integrate-ai-into-your-business#integrating-ai-into-your-team%E2%80%99s-workflow)  
6. [Roles and responsibilities](https://vercel.com/blog/how-to-integrate-ai-into-your-business#roles-and-responsibilities)  
6. [角色与职责](https://vercel.com/blog/how-to-integrate-ai-into-your-business#roles-and-responsibilities)  
7. [Lowering barriers to AI development](https://vercel.com/blog/how-to-integrate-ai-into-your-business#lowering-barriers-to-ai-development)  
7. [降低 AI 开发门槛](https://vercel.com/blog/how-to-integrate-ai-into-your-business#lowering-barriers-to-ai-development)

## Building a robust AI use case

## 构建稳健的 AI 使用场景

Before jumping headlong into AI development, it's crucial to identify and evaluate AI use cases that align with your business goals and technical capabilities.

在全力投入 AI 开发之前，至关重要的是识别并评估那些契合企业战略目标与技术能力的 AI 使用场景。

### Identifying target use cases

### 识别目标使用场景

When considering potential AI applications, look for areas where a frontend-centric approach can deliver rapid results and tangible value.

在评估潜在 AI 应用时，请重点关注那些可通过“以前端为中心”的方式快速交付成果并产生切实价值的领域。

Traditional AI use cases are valuable, but the real opportunity lies in pushing the boundaries to create exceptional customer value.

传统 AI 应用场景具有重要价值，但真正的机遇在于突破边界，创造卓越的客户价值。

Consider these innovative AI applications that transform user interactions:

以下是一些能够重塑用户交互方式的创新 AI 应用：

- Personalized user journeys

- 个性化的用户旅程

- Real-time [generative UI](https://vercel.com/blog/ai-sdk-3-generative-ui)

- 实时 [生成式 UI](https://vercel.com/blog/ai-sdk-3-generative-ui)

- [Intelligent search](https://www.linkedin.com/posts/noahfreeman_googlecloud-ugcPost-7222639802423128064-fTzF) and recommendation systems

- [智能搜索](https://www.linkedin.com/posts/noahfreeman_googlecloud-ugcPost-7222639802423128064-fTzF) 与推荐系统

- Advanced conversational shopping assistants

- 高级对话式购物助手

- Natural language interfaces

- 自然语言界面

- Predictive analytics for user behavior

- 用户行为预测分析

- Custom 3D product design generators

- 定制化 3D 产品设计生成器

These AI-driven features go beyond simple automation, reimagining how users interact with your products or services. They create more engaging, efficient, and personalized experiences that significantly enhance customer satisfaction and loyalty. The most impactful AI use cases often unlock new creative possibilities, opening up a new world for customer experience.

这些由 AI 驱动的功能远不止于简单自动化，而是重新构想用户与您的产品或服务之间的交互方式。它们打造出更具吸引力、更高效、更个性化的体验，从而显著提升客户满意度与忠诚度。最具影响力的一类 AI 应用，往往能释放全新的创意可能性，为客户体验开启一个崭新世界。

In today's AI landscape, where language models have become commoditized, the true differentiator lies in frontend development and user experience. Vercel's platform enables developers to create intuitive, AI-powered interfaces that set applications apart. This frontend-focused approach ensures that AI is seamlessly integrated into a superior user experience.​

在当今的 AI 格局中，语言模型已趋于商品化，真正的差异化优势在于前端开发与用户体验。Vercel 平台赋能开发者构建直观、由 AI 驱动的界面，从而让应用脱颖而出。这种以前端为中心的方法，确保 AI 无缝融入卓越的用户体验之中。

[**AI features you can add to your app today.**  
**今天即可为您的应用添加的 AI 功能。**  
\\  
Looking for more ideas for easy-to-implement AI features? We have you covered.  
还想了解一些易于实现的 AI 功能创意？我们已为您悉数准备。  
\\  
Read More  
了解更多](https://vercel.com/resources/7-ai-features-you-can-add-to-your-app-today)

### **Evaluating AI use cases**  
### **评估 AI 使用场景**

To systematically assess potential AI features, we've developed the Vercel Impact Assessment for AI Initiatives (VIA-AI). This framework helps you prioritize AI projects based on their potential impact and feasibility within the Vercel ecosystem.  
为系统性地评估潜在 AI 功能，我们推出了“Vercel AI 项目影响评估框架”（VIA-AI）。该框架帮助您依据各项 AI 项目在 Vercel 生态系统中的潜在影响与可行性，对其进行优先级排序。

**Vercel Impact Assessment for AI Initiatives (VIA-AI)**  
**Vercel AI 项目影响评估框架（VIA-AI）**

1. **Value potential:** Assesses the expected return on investment (ROI) and overall impact of the AI initiative. This includes improvements to customer experience, operational efficiency, revenue generation, or cost reduction. Consider both short-term gains and long-term strategic value. _(1 = Minimal value, 5 = Transformative impact)_  
1. **价值潜力：** 评估 AI 项目的预期投资回报率（ROI）及整体影响，涵盖客户体验提升、运营效率优化、收入增长或成本降低等方面。需兼顾短期收益与长期战略价值。（1 = 价值极小；5 = 具变革性影响）

2. **Integration feasibility:** Evaluates how easily the AI solution can be implemented within your existing technology stack and processes. This covers technical compatibility, required resources, and the level of disruption to current workflows. Consider the availability of necessary skills and the learning curve for your team. _(1 = Highly complex integration, 5 = Seamless integration)_  
2. **集成可行性：** 评估 AI 解决方案在您现有技术栈与业务流程中落地实施的难易程度。涵盖技术兼容性、所需资源投入，以及对当前工作流造成的干扰程度。同时需考虑团队是否具备必要技能，以及学习与适应所需时间。（1 = 集成高度复杂；5 = 无缝集成）

3. **Strategic alignment:** Measures how well the AI use case aligns with your organization's overall strategy and objectives. This pillar ensures that the AI initiative contributes directly to your core business aims rather than being a standalone or tangential project. _(1 = Minimal alignment, 5 = Perfect strategic fit)_  
3. **战略契合度：** 衡量 AI 使用场景与组织整体战略及目标的匹配程度。该维度确保 AI 项目直接服务于核心业务目标，而非孤立或边缘化的尝试。（1 = 契合度极低；5 = 战略高度契合）

4. **Business logic enhancement:** Assesses how significantly the AI will improve or augment existing business processes and decision-making. This includes the potential for automation of routine tasks, enhancement of human capabilities, and the introduction of new, AI-driven insights that can inform strategy and operations. _(1 = Minor enhancements, 5 = Major process improvements)_  
4. **业务逻辑增强能力：** 评估 AI 对现有业务流程与决策机制的改进或增强程度。包括常规任务自动化的潜力、人类能力的强化，以及引入全新 AI 驱动洞见以支撑战略制定与日常运营的能力。（1 = 改进微弱；5 = 流程显著优化）

5. **Data quality and availability:** Evaluates the readiness, accessibility, and quality of data required for the AI initiative. This includes assessing data completeness, accuracy, relevance, and ease of accessing and processing the necessary data. _(1 = Poor data quality or significant data gaps, 5 = High-quality, comprehensive data readily available)_  
5. **数据质量与可用性：** 评估 AI 项目所需数据的就绪程度、可访问性与质量，包括数据完整性、准确性、相关性，以及获取和处理必要数据的便捷程度。（1 = 数据质量差或存在重大数据缺口；5 = 高质量、全面且易于获取的数据已就绪）

6. **Performance and scalability:** Examines the AI solution's ability to handle increased loads, adapt to growing data volumes, and maintain responsiveness as the user base expands. Also considers the solution's performance in terms of speed, reliability, and resource efficiency across various operating conditions. _(1 = Performance concerns and limited scalability, 5 = Excellent performance characteristics and highly scalable)_

6. **性能与可扩展性：** 评估AI解决方案应对负载增长、适应数据量扩大、以及在用户规模持续扩张时保持响应能力的表现；同时考察其在不同运行条件下，于速度、可靠性及资源利用效率等方面的综合性能。_(1 = 存在明显性能问题，可扩展性有限；5 = 性能表现优异，具备高度可扩展性)_

7. **Security, compliance, and user trust:** Examines the AI solution's adherence to data protection standards, regulatory requirements, and principles that foster user confidence in the system. This pillar assesses the robustness of security measures, compliance with relevant regulations, and the ability to build and maintain user trust through responsible AI practices. _(1 = Significant security and compliance risks, low user trust, 5 = Robust security, full compliance, high user trust potential)_

7. **安全性、合规性与用户信任：** 评估AI解决方案在数据保护标准、监管要求及增强用户对系统信心的核心原则等方面的遵循程度。该维度重点考察安全机制的健壮性、对相关法规的合规水平，以及通过负责任的AI实践建立并维系用户信任的能力。_(1 = 安全与合规风险突出，用户信任度低；5 = 安全防护坚实，完全合规，具备高用户信任潜力)_

_If your average score is above 4, it’s almost certainly time to begin implementing your imagined AI feature. Below 3, and you may need to take some time to reevaluate the lacking pillars._

_若平均得分高于4分，则几乎可以确定已进入实施构想中AI功能的合适时机；若低于3分，则可能需要花时间重新审视并补强薄弱维度。_

When applying this framework, involve stakeholders from various departments to ensure a comprehensive evaluation. This collaborative approach helps build internal support and alignment for your AI initiatives.

在应用该框架时，请邀请来自各部门的相关方共同参与，以确保评估全面、客观。这种协作方式有助于凝聚内部共识，为AI项目赢得广泛支持与战略协同。

### ) Developing key performance indicators (KPIs)

### ) 制定关键绩效指标（KPI）

Once you've identified promising AI use cases, it's essential to establish clear, measurable KPIs. These should encompass both technical performance and business outcomes.

在识别出具有潜力的AI应用场景后，确立清晰、可量化的KPI至关重要。这些指标应同时覆盖技术性能与业务成果两个维度。

| **Technical KPIs** | **Related Business KPIs** |
| --- | --- |
| Model Accuracy | Customer Satisfaction (CSAT) Score |
| Response Time | Conversion Rate |
| Uptime / Availability | Customer Retention Rate |
| Error Rate | Brand Sentiment |
| Throughput (queries per second) | Operational Efficiency |
| Latency | Time-to-Market for New Features |
| Data Quality Score | Customer Lifetime Value (CLV) |
| Model Drift Rate | Upsell/Cross-sell Success Rate |
| Resource Utilization | Cost Reduction |
| API Call Success Rate | Employee Productivity |
| Security Incident Rate | Regulatory Compliance Score |
| Data Processing Speed | Revenue Growth |
| Model Training Time | Return on Investment (ROI) |
| A/B Test Performance | Net Promoter Score (NPS) |
| User Adoption Rate | Market Share |

| **技术类KPI** | **关联的业务类KPI** |
| --- | --- |
| 模型准确率（Model Accuracy） | 客户满意度（CSAT）评分 |
| 响应时间（Response Time） | 转化率（Conversion Rate） |
| 正常运行时间 / 可用性（Uptime / Availability） | 客户留存率（Customer Retention Rate） |
| 错误率（Error Rate） | 品牌舆情（Brand Sentiment） |
| 吞吐量（每秒查询数，Throughput） | 运营效率（Operational Efficiency） |
| 延迟（Latency） | 新功能上市周期（Time-to-Market for New Features） |
| 数据质量评分（Data Quality Score） | 客户终身价值（CLV） |
| 模型漂移率（Model Drift Rate） | 增值销售/交叉销售成功率（Upsell/Cross-sell Success Rate） |
| 资源利用率（Resource Utilization） | 成本降低（Cost Reduction） |
| API调用成功率（API Call Success Rate） | 员工生产力（Employee Productivity） |
| 安全事件发生率（Security Incident Rate） | 合规性评分（Regulatory Compliance Score） |
| 数据处理速度（Data Processing Speed） | 收入增长（Revenue Growth） |
| 模型训练耗时（Model Training Time） | 投资回报率（ROI） |
| A/B测试效果（A/B Test Performance） | 净推荐值（NPS） |
| 用户采用率（User Adoption Rate） | 市场份额（Market Share） |

When setting KPIs, establish baseline metrics before implementing AI to accurately measure impact. Use [Vercel's observability suite](https://vercel.com/docs/observability) to track performance in real-time.

设定KPI时，应在AI实施前先确立基准指标，以便精准衡量实际影响。建议使用[Vercel可观测性套件](https://vercel.com/docs/observability)实现性能的实时追踪与监控。

## Integrating AI into your team’s workflow

## 将AI融入团队工作流

Successful AI initiatives require broad organizational buy-in and effective collaboration across multiple disciplines. Understanding how to organize your team, leverage various skill sets, and integrate AI into existing workflows is crucial for AI project success.

成功的AI项目离不开组织层面的广泛认同，以及跨职能领域的高效协作。深入理解如何合理组建团队、充分发挥多元技能优势，并将AI无缝嵌入现有工作流程，是保障AI项目落地成效的关键所在。

### Roles and responsibilities

### 角色与职责

| **团队** | **职责** |
| --- | --- |
| Data Science | \- 负责数据准备与清洗<br>\- 开展实验并评估模型性能<br>\- 开发与训练模型 |
| DevOps 和 MLOps | \- 管理模型训练与部署所需的基础设施<br>\- 为 AI 模型构建并实施 CI/CD 流水线<br>\- 确保 AI 服务的可扩展性与可靠性 |
| Frontend | \- 设计并实现面向 AI 功能的用户界面<br>\- 将 AI 能力无缝集成至用户体验中<br>\- 优化 AI 驱动 UI 组件的性能 |
| Product Management | \- 定义 AI 功能的使用场景与需求<br>\- 基于业务影响对 AI 项目进行优先级排序<br>\- 在技术团队与利益相关方之间协调沟通 |
| Security Team | \- 确保 AI 系统具备抵御攻击（如 DDoS、拒绝钱包攻击等）的能力<br>\- 保护 AI 工作流中的数据处理过程及个性化用户响应<br>\- 实施 Web 应用防火墙（WAF）、速率限制、机器人防护等安全措施 |
| Legal and Compliance | \- 确保 AI 应用符合相关法律法规要求<br>\- 应对数据隐私与伦理问题 |
| Business Stakeholders | \- 提供领域专业知识，并定义成功指标<br>\- 验证 AI 输出结果并提供反馈<br>\- 向管理层汇报成果，确保项目与企业战略保持一致 |

### Lowering barriers to AI development

### 降低 AI 开发门槛

One of the advantages of using Vercel for AI projects is that it democratizes AI development. The platform gives you the space to experiment quickly with new AI use cases. This is vital to prove out features without dealing with legacy code that’s not yet AI-ready.

使用 Vercel 开展 AI 项目的一大优势在于它推动了 AI 开发的民主化。该平台为您提供充足空间，快速尝试各类新型 AI 使用场景——这对于在不依赖尚未适配 AI 的遗留代码前提下验证功能可行性至关重要。

Vercel lets engineers at any experience level meaningfully contribute to AI projects using Next.js’s powerful defaults and [Vercel's intuitive, automated platform](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud). Plus, the [AI SDK simplifies integration with various AI providers](https://sdk.vercel.ai/docs/introduction), providing full model portability and reducing the need for specialized expertise.

借助 Next.js 强大的默认配置以及 [Vercel 直观、自动化的平台](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud)，Vercel 使各经验水平的工程师都能切实参与 AI 项目开发。此外，[AI SDK 简化了与各类 AI 服务商的集成](https://sdk.vercel.ai/docs/introduction)，支持全模型可移植性，并显著降低了对特定领域专业知识的依赖。

This allows you to more easily foster internal support for your AI project:

这有助于您更高效地争取组织内部对 AI 项目的广泛支持：

1. **Start small:** Use Vercel's platform to [quickly prototype AI features](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk) without extensive infrastructure setup.

1. **从小处着手：** 利用 Vercel 平台 [快速构建 AI 功能原型](https://vercel.com/blog/composable-ai-for-ecommerce-hands-on-with-vercels-ai-sdk)，无需搭建繁重的基础设施。

2. **Iterate easily:** Vercel's [streamlined development workflow](https://vercel.com/ai) allows for rapid testing and refinement of AI concepts in unlimited true-to-prod environments.

2. **轻松迭代：** Vercel 的 [精简开发工作流](https://vercel.com/ai) 支持在无限数量、高度贴近生产环境的真实环境中，快速测试与优化 AI 构思。

3. **Demonstrate value:** Use [Vercel's analytics](https://vercel.com/docs/analytics) to showcase the impact of AI features on key metrics.

3. **彰显价值：** 借助 [Vercel 分析工具](https://vercel.com/docs/analytics)，直观呈现 AI 功能对关键业务指标的实际影响。

4. **Involve stakeholders early:** Utilize Vercel's [preview deployments](https://vercel.com/products/previews) to get feedback from various departments.

4. **尽早引入利益相关方：** 运用 Vercel 的 [预览部署（Preview Deployments）](https://vercel.com/products/previews)，向各部门收集早期反馈。

5. **Upgrade as needed:** The AI SDK keeps you future-proofed by allowing you to swap in the latest AI models without disrupting your code.

5. **按需升级：** AI SDK 通过支持无缝替换最新 AI 模型，助您始终面向未来，且无需改动现有代码。

> “Switching to Vercel transformed our workflow. It didn't just speed us up; it changed how we innovate. Switching to Vercel transformed our workflow. It didn't just speed us up; it changed how we innovate.”
>
> “迁移到 Vercel 彻底改变了我们的工作流。它不仅提升了我们的开发速度，更重塑了我们的创新方式。迁移到 Vercel 彻底改变了我们的工作流。它不仅提升了我们的开发速度，更重塑了我们的创新方式。”
>
> ![](images/how-to-integrate-ai-into-your-business-vercel/img_001.jpg)
>
> **Peter Runham,** Co-founder & CTO  
>
> **彼得·伦纳姆（Peter Runham）**，联合创始人兼首席技术官

Vercel's frontend-first approach, which lets you start with a single developer, makes it easier to demonstrate value and secure support from C-suite and cross-functional teams. GPUs and third-party AI providers are expensive, and you need to be able to quickly prove to stakeholders what works and what doesn’t.

Vercel 前端优先的开发范式，让您可从单名开发者起步，更轻松地展现项目价值，从而赢得高管层（C-suite）及跨职能团队的支持。GPU 资源与第三方 AI 服务成本高昂，您必须能快速向相关干系人验证哪些方案可行、哪些不可行。

AI model breakthroughs happen daily, but your innovation stack can be future-proof. Vercel helps you validate ideas quickly and ship cutting-edge AI features that remain relevant, no matter how the AI landscape shifts.

AI 模型日新月异，但您的创新技术栈却可以历久弥新。Vercel 助您快速验证创意，并交付前沿 AI 功能——无论 AI 技术格局如何演变，这些功能始终具备长期适用性。

[**Brainstorm with us.**\\
\\
Whether you've yet to come up with the perfect AI idea or are well into development, our experts can help you optimize your infrastructure for new AI features.\\
\\
Contact Us](https://vercel.com/contact/sales)

[**与我们一起头脑风暴。**\\
\\
无论您尚未构思出理想的 AI 创意，还是已进入深度开发阶段，我们的专家均可协助您优化基础设施，以支持全新 AI 功能的落地。\\
\\
联系我们](https://vercel.com/contact/sales)

Blog post  
博客文章  

Apr 9, 2024  
2024 年 4 月 9 日  

### Composable AI for ecommerce: Hands-on with Vercel’s AI SDK  

### 面向电商的可组合 AI：动手实践 Vercel 的 AI SDK  

![](images/how-to-integrate-ai-into-your-business-vercel/img_002.jpg)  

Malte Ubl  
马尔特·乌布（Malte Ubl）

Vercel.com landing page

Vercel.com 着陆页

### Power your next AI breakthrough.

### 赋能您的下一次 AI 突破。