---
title: "Transforming customer support with AI: How Vercel decreased tickets by 31% - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/transforming-customer-support-with-ai-how-vercel-decreased-tickets"
date: "2024-09-03"
scraped_at: "2026-03-02T09:41:21.878006600+00:00"
language: "en-zh"
translated: true
description: "At Vercel, we integrated AI into our support workflow. Our AI agent reduced human-handled tickets by 31%, allowing us to maintain high support standards while serving a growing customer base."
---

render_with_liquid: false
Sep 3, 2024

2024 年 9 月 3 日

[麦肯锡公司（McKinsey）](https://www.mckinsey.com/capabilities/quantumblack/our-insights/the-state-of-ai) 最新发布的 AI 调研报告显示，目前已有 65% 的组织常态化使用人工智能（AI）——这一比例相较仅十个月前几乎翻倍；其中许多组织正借助 AI 提升客户支持等关键领域的运营效率。

在 Vercel，我们将 AI 深度融入客户支持工作流。由 AI 驱动的智能代理将需人工处理的工单数量降低了 31%，使我们得以在服务客户规模持续扩大的同时，始终维持高标准的支持质量。

### **挑战：在支持质量与业务增长之间取得平衡**

客户支持团队日常需应对种类繁多的客户咨询，其中大量问题涉及可重复执行的标准流程。这些流程既包括引导客户访问特定文档页面等简单任务，也涵盖协助客户完成域名配置等稍复杂的操作。

当前客户支持的发展趋势正推动各组织将 AI 驱动的聊天机器人（chatbot）作为其客户支持战略中不可或缺的关键组成部分。据 [Gartner（高德纳）](https://www.gartner.com/en/newsroom/press-releases/2022-07-27-gartner-predicts-chatbots-will-become-a-primary-customer-service-channel-within-five-years) 预测，到 2027 年，聊天机器人将成为约四分之一组织的首要客户服务渠道。企业积极拥抱 AI，主要受两大因素驱动：一是客户对即时、全天候（24/7）支持的期望值持续攀升；二是支持业务亟需以更具成本效益的方式实现规模化扩展。

这一趋势印证了 AI 作为强大工具的巨大潜力——它既能显著提升客户体验，又能优化运营效率。而要真正释放这些价值，关键在于审慎规划、周密实施，并确保 AI 解决方案是对人类专业能力的有力补充，而非简单替代。组织可通过 AI 实现流程提效，从而让支持工程师专注于那些更复杂、上下文更丰富、更需要深度专业知识的疑难问题。

### **解决方案：循序渐进、稳扎稳打的 AI 实施路径**

在 Vercel，我们自主研发了一款 AI 驱动的智能代理，使其无缝嵌入现有客户支持工作流。在实施合作伙伴 Markprompt 的协作下，我们将原有支持表单替换为一个简洁、开放式的提问：“我们如何帮您？” 这一 AI 智能代理依托大型语言模型（LLM），并整合了一个全面、多源的知识库，内容涵盖公司官网信息、技术文档、Next.js 示例代码以及各类帮助文章。由此，我们能够就海量客户问题提供即时、精准的响应。

该 AI 助理的能力远不止于简单的问答。它可主动发起后续追问，从而随时间推移逐步应对日益复杂的用户请求。此外，当 AI 无法完全解决某一问题时，系统会平滑切换至人工支持环节，并自动预填支持表单，彻底避免客户重复输入信息。

### **Tips for building a smarter support system**

### **构建更智能支持系统的实用建议**

Throughout the development process, we prioritized customer experience and choice, guided by these key insights:

在开发全过程当中，我们始终以客户体验与客户选择为优先，并基于以下关键洞察开展工作：

**Insight 1**: **Take an iterative approach**

**洞察 1：采用迭代式方法**

Rather than implementing a solution quickly, we took a measured, iterative approach, prioritizing our customers' experience every step of the way. Our initial AI implementation focused on providing immediate answers to customer queries surfacing objective, foundational answers and then providing more context if needed by the customer.

我们并未急于一次性部署完整方案，而是采取审慎、渐进的迭代方式，在每一步都以客户体验为核心。初期的 AI 实现聚焦于为客户提供即时响应——首先呈现客观、基础的答案，再根据客户实际需要，动态补充更多上下文信息。

**Insight 2:** **Test internally first**

**洞察 2：先进行内部测试**

As we do with everything from internal tools to the products we offer customers, we used our technology in-house first. By testing the AI assistant internally before rolling it out to customers, we addressed compliance and security concerns head-on, particularly regarding access to sensitive customer data. It also ensured we met our high standards for customer experience.

正如我们对待所有内部工具及面向客户的正式产品一样，我们首先在公司内部全面使用该技术。在向客户正式推出 AI 助理前，我们先行开展内部测试，从而直面并解决合规性与安全性问题——尤其是涉及敏感客户数据访问权限的关键风险。此举也确保了我们的解决方案完全符合客户体验的高标准。

**Insight 3: Gradual rollout with A/B testing**

**洞察 3：通过 A/B 测试实现渐进式上线**

We began with a 50% A/B test using [Edge Middleware](https://vercel.com/docs/functions/edge-middleware), allowing us to safely test our hypothesis of improved support through AI in the real-world. The results were overwhelmingly positive: a 16% reduction in support tickets over a period of two weeks, right from the first iteration. This validation gave us the confidence to ramp up to a 100% rollout and evolve the AI-powered agent into a more interactive, conversational interface.

我们首先借助 [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) 开展了覆盖 50% 用户流量的 A/B 测试，从而在真实环境中安全验证“AI 可提升支持效能”这一假设。结果极为积极：仅在首轮迭代后的两周内，支持工单量即下降了 16%。这一实证结果增强了我们的信心，推动我们迅速将覆盖率提升至 100%，并将 AI 驱动的客服代理持续演进为更具交互性与对话感的智能界面。

**Insight 4: Prioritize customer experience and brand integrity**

**洞察 4：始终捍卫客户体验与品牌声誉**

Throughout the process, we remained acutely aware of our responsibility to protect our brand and deliver exceptional service. A key feature of our implementation was the constant presence of a clear "Create Case" option. At every step, customers had the ability to opt out of the AI experience and connect with a human support engineer, ensuring they always felt in control of their support experience. This approach empowered customers, created a valuable feedback loop, and enabled rapid improvements. Instead of deploying a basic AI chatbot quickly, we developed a sophisticated, customer-centric AI solution that respects customer preferences while leveraging advanced technology.

整个过程中，我们始终清醒意识到自身肩负着守护品牌形象与提供卓越服务的双重责任。本方案的一项核心设计，是在用户界面中始终清晰呈现“创建工单（Create Case）”选项。在每一个交互环节，客户均可随时退出 AI 服务流程，转而直接联系人工支持工程师，从而确保其全程掌控自身支持体验。这一设计不仅赋予客户充分自主权，还构建起宝贵的反馈闭环，助力我们快速优化迭代。我们并未仓促上线一个基础版 AI 聊天机器人，而是打造了一套成熟、以客户为中心的 AI 解决方案——它既尊重客户的个性化偏好，又深度融合前沿技术能力。

### **Benefits and results**

### **优势与成果**

This new system offered two key advantages: saving customers time and being language-agnostic, allowing customers to describe their issues in any language. It successfully interpreted, understood, answered, and resolved 31% of incoming tickets, freeing up the CSE team to focus on providing the best possible customer experience.

这一新系统具备两大核心优势：为客户节省时间，且支持多语言（language-agnostic），使客户能以任意语言描述自身问题。它成功实现了对31%的进线工单的语义解析、理解、应答与闭环解决，从而释放了客户支持工程师（CSE）团队的精力，使其得以专注于提供极致的客户体验。

The benefits extended beyond these initial wins:

这些初步成效带来的收益进一步延伸至更广层面：

- 42% reduction in first response time for customers  
- 客户首次响应时间缩短42%  

- Significantly improved CSE job satisfaction  
- 客户支持工程师（CSE）工作满意度显著提升  

- Enhanced documentation and product interfaces  
- 文档质量与产品界面体验全面优化  

Vercel's approach wasn't just about answering questions and closing tickets; it was about learning and improving. By analyzing resolved tickets, we identified areas for enhancement in documentation, product interface, and the product itself. We also created a data flywheel, where each interaction improved the AI's performance, leading to better outcomes over time and a virtuous cycle of improvement.

Vercel 的方法远不止于答疑解惑与关闭工单——其本质在于持续学习与自我进化。通过对已解决工单的深度分析，我们精准识别出文档、产品界面乃至产品功能本身的优化空间；同时构建起一个“数据飞轮”（data flywheel）机制：每一次用户交互都反哺并提升 AI 模型性能，从而推动整体效果持续向好，形成良性循环式的迭代升级。

### **How to get started at your company**

### **贵公司如何快速上手**

Vercel empowers developers to harness the power of AI, regardless of their team's expertise. Now is the perfect time for your organization to explore AI-driven solutions – here's how you can get started and transform your applications with Vercel's powerful ecosystem:

Vercel 赋能开发者轻松驾驭 AI 能力，无论您的团队是否具备深厚的人工智能专业背景。当下正是贵组织探索 AI 驱动型解决方案的最佳时机——以下是如何起步，并借助 Vercel 强大的技术生态实现应用智能化升级的具体路径：

1. **Explore AI applications:** Build chatbots, writing tools, generative AI apps, or virtual assistants using tools like [Next.js](https://nextjs.org/) and the [Vercel AI SDK](https://sdk.vercel.ai/docs).  
1. **探索 AI 应用场景：** 借助 [Next.js](https://nextjs.org/) 和 [Vercel AI SDK](https://sdk.vercel.ai/docs) 等工具，快速构建聊天机器人、智能写作助手、生成式 AI 应用或虚拟助理。

2. **Prototype and collaborate:** Rapidly iterate with our [DX Platform](https://vercel.com/products/previews), featuring powerful tools like feature flags and preview URLs for seamless, low-risk experimentation.  

2. **快速原型开发与协作：** 借助我们的 [DX 平台](https://vercel.com/products/previews)，利用功能开关（feature flags）、预览链接（preview URLs）等强大工具，实现高效迭代，让实验过程顺畅无阻、风险极低。

3. [**Quickstart templates**](https://vercel.com/templates?type=ai): Deploy an AI app in seconds with pre-built templates, including a chatbot template to get you started.  

3. [**快速入门模板**](https://vercel.com/templates?type=ai)：使用预构建模板，几秒钟即可部署 AI 应用——例如聊天机器人模板，助您即刻启程。

4. [**Launch AI projects at scale**](https://vercel.com/blog/how-to-build-scalable-ai-applications) **:** Our fully [managed infrastructure](https://vercel.com/products/rendering) scales effortlessly and delivers ultra-performant experiences for users.  

4. [**规模化启动 AI 项目**](https://vercel.com/blog/how-to-build-scalable-ai-applications)：我们完全[托管的基础设施](https://vercel.com/products/rendering)可轻松弹性伸缩，为用户提供极致高性能的体验。

Vercel’s story aligns with the broader trends identified in the McKinsey survey, where organizations report both cost reductions and revenue increases in business units deploying gen AI. Our experience demonstrates that when implemented thoughtfully, AI can be a powerful tool for enhancing customer experience while optimizing operational efficiency. Whether you're an AI-first company or looking to enhance existing products, Vercel provides the tools and knowledge to help you revolutionize your customer support and beyond with AI.  

Vercel 的发展路径与麦肯锡调研所揭示的宏观趋势高度契合——各组织普遍反映，在部署生成式 AI 的业务单元中，成本得以降低，收入同步增长。我们的实践表明：只要经过审慎规划与落地，AI 就能成为提升客户体验、优化运营效率的有力引擎。无论您是一家以 AI 为原生驱动力的公司，还是希望为现有产品注入 AI 能力，Vercel 都将为您提供所需的工具与专业知识，助您以 AI 彻底重塑客户服务，并拓展至更广阔的应用场景。

[**Brainstorm with us.**\\  
\\  
Whether you've yet to come up with the perfect AI idea or are well into development, our experts can help you optimize your infrastructure for new AI features.\\  
\\  
Contact Us](https://vercel.com/contact/sales)  

[**与我们共同头脑风暴。**\\  
\\  
无论您尚在构思理想的 AI 创意，还是已深入开发阶段，我们的专家团队都能协助您优化基础设施，从容支持全新 AI 功能的落地。\\  
\\  
联系我们](https://vercel.com/contact/sales)

Vercel.com landing page  

Vercel.com 官网落地页  

### Watch the AI for enterprise panel from Ship.  

### 观看 Ship 大会“面向企业的 AI”专题讨论  

Blog post  

博客文章  

Apr 9, 2024  

2024 年 4 月 9 日  

### Composable AI for ecommerce: Hands-on with Vercel’s AI SDK  

### 面向电商的可组合 AI：动手实践 Vercel 的 AI SDK

![](images/transforming-customer-support-with-ai-how-vercel-decreased-tickets-by-31-vercel/img_001.jpg)

Malte Ubl

马尔特·乌布爾