---
title: "LangChain partners with Elastic to launch the Elastic AI Assistant"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/"
date: "2024-06-19"
scraped_at: "2026-03-03T08:00:50.629073946+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies", "By LangChain"]
---
&#123;% raw %}

Elastic，一家领先的搜索分析公司，为全球超过 20,000 家客户提供服务，助力企业安全地利用“搜索驱动的 AI”能力，使任何用户都能实时、规模化地基于全部数据快速获取所需答案。通过将人工智能与搜索技术深度融合，Elastic 能够从海量结构化与非结构化数据中发掘可操作的业务洞见，切实满足企业对实时性与可扩展性数据处理的需求。公司提供面向搜索、安全与可观测性的云原生解决方案，帮助企业兑现 AI 承诺；近期，Elastic 更借助 LangChain 和 LangSmith，在其安全套件中新增了 AI 助手（AI Assistant）功能。

Elastic，一家领先的搜索分析公司，为全球超过 20,000 家客户提供服务，助力企业安全地利用“搜索驱动的 AI”能力，使任何用户都能实时、规模化地基于全部数据快速获取所需答案。通过将人工智能与搜索技术深度融合，Elastic 能够从海量结构化与非结构化数据中发掘可操作的业务洞见，切实满足企业对实时性与可扩展性数据处理的需求。公司提供面向搜索、安全与可观测性的云原生解决方案，帮助企业兑现 AI 承诺；近期，Elastic 更借助 LangChain 和 LangSmith，在其安全套件中新增了 AI 助手（AI Assistant）功能。

Elastic 安全 AI 助手（Elastic AI Assistant for Security）是一款面向企业的高端产品，专为支持安全分析师的工作流而设计。具体而言，该产品可协助安全团队完成以下任务：

Elastic 安全 AI 助手（Elastic AI Assistant for Security）是一款面向企业的高端产品，专为支持安全分析师的工作流而设计。具体而言，该产品可协助安全团队完成以下任务：

- **告警摘要生成（Alert summarization）**：解释某条告警被触发的原因，并推荐相应的响应剧本（playbook）以处置攻击。该功能可为组织动态生成运行手册（runbook），在安全事件发生时确保响应流程井然有序。  
- **工作流建议（Workflow suggestions）**：指导用户如何完成各类任务，例如添加告警例外规则（alert exception）或创建自定义仪表盘（custom dashboard）。  
- **查询生成与转换（Query generation and conversion）**：帮助用户更顺畅地从其他 SIEM（安全信息与事件管理）平台迁移至 Elastic。用户现在可直接粘贴来自其他产品的查询语句，或以自然语言描述需求，Elastic AI 助手即可将其自动转换为符合 Elastic 语法规范的查询语句。  
- **Agent 集成建议（Agent integration advice）**：就如何在 Elastic 中最有效地采集数据提供专业指导。

- **告警摘要生成（Alert summarization）**：解释某条告警被触发的原因，并推荐相应的响应剧本（playbook）以处置攻击。该功能可为组织动态生成运行手册（runbook），在安全事件发生时确保响应流程井然有序。  
- **工作流建议（Workflow suggestions）**：指导用户如何完成各类任务，例如添加告警例外规则（alert exception）或创建自定义仪表盘（custom dashboard）。  
- **查询生成与转换（Query generation and conversion）**：帮助用户更顺畅地从其他 SIEM（安全信息与事件管理）平台迁移至 Elastic。用户现在可直接粘贴来自其他产品的查询语句，或以自然语言描述需求，Elastic AI 助手即可将其自动转换为符合 Elastic 语法规范的查询语句。  
- **Agent 集成建议（Agent integration advice）**：就如何在 Elastic 中最有效地采集数据提供专业指导。

以及更多功能。

以及更多功能。

该功能仅面向企业客户开放。自 2023 年 6 月首次发布以来，Elastic AI 助手已获得广泛采用。实践表明，该助手显著缩短了客户对 Elastic Security 所生成告警的平均响应时间（MTTR，Mean Time to Respond），同时大幅减少了编写查询语句与检测规则所需的时间——这得益于其基于自然语言用例自动生成精准查询的能力。

该功能仅面向企业客户开放。自 2023 年 6 月首次发布以来，Elastic AI 助手已获得广泛采用。实践表明，该助手显著缩短了客户对 Elastic Security 所生成告警的平均响应时间（MTTR，Mean Time to Respond），同时大幅减少了编写查询语句与检测规则所需的时间——这得益于其基于自然语言用例自动生成精准查询的能力。

### LangChain 和 LangSmith 如何支持产品开发

### LangChain 与 LangSmith 如何支持产品开发

Elastic 在产品设计之初便确立了对大语言模型（LLM）的“无关性”（agnostic）原则：他们希望终端用户能够自由选用自有模型，并需兼容 OpenAI、Azure OpenAI、Amazon Bedrock 等多种主流模型服务商。因此，从项目启动伊始，“赋予用户高度自主权与灵活性”即是一项核心需求。

Elastic 在产品设计之初便确立了对大语言模型（LLM）的“无关性”（agnostic）原则：他们希望终端用户能够自由选用自有模型，并需兼容 OpenAI、Azure OpenAI、Amazon Bedrock 等多种主流模型服务商。因此，从项目启动伊始，“赋予用户高度自主权与灵活性”即是一项核心需求。

幸运的是，构建 RAG（检索增强生成）应用所需的大量基础工具，LangChain 均已原生提供；同时，LangChain 对底层各组件（如 LLM、向量数据库、文档加载器等）进行了抽象封装，使得 Elastic 团队能轻松实现模型与提示词（prompt）的按需切换——无论用户倾向选择哪家供应商，工程改造成本都极低。此外，LangChain 已深度集成 Elastic 自研的向量数据库，可谓天作之合，完美契合本次开发需求。

幸运的是，构建 RAG（检索增强生成）应用所需的大量基础工具，LangChain 均已原生提供；同时，LangChain 对底层各组件（如 LLM、向量数据库、文档加载器等）进行了抽象封装，使得 Elastic 团队能轻松实现模型与提示词（prompt）的按需切换——无论用户倾向选择哪家供应商，工程改造成本都极低。此外，LangChain 已深度集成 Elastic 自研的向量数据库，可谓天作之合，完美契合本次开发需求。

随着团队持续为 AI 助手增添新功能（例如支持 Elastic 全新查询语言 ES\|QL 的查询生成能力），LangSmith 的作用变得尤为关键：它帮助 Elastic 团队清晰掌握——究竟有哪些内容被发送至大模型？整个调用链路（full trace）耗时多久？过程中消耗了多少 token？LangSmith 还助力团队深入理解：不同模型在不同任务类型、不同价格区间下的表现差异。这种可观测性（visibility）使开发团队得以审慎权衡各项技术选型，并尽可能统一三款受支持模型（OpenAI / Azure OpenAI / Bedrock）的用户体验。在应用迭代过程中，LangSmith 不仅凸显了各模型输出的细微差异，更有效防止了性能退化（regression）问题流入生产环境。

随着团队持续为 AI 助手增添新功能（例如支持 Elastic 全新查询语言 ES\|QL 的查询生成能力），LangSmith 的作用变得尤为关键：它帮助 Elastic 团队清晰掌握——究竟有哪些内容被发送至大模型？整个调用链路（full trace）耗时多久？过程中消耗了多少 token？LangSmith 还助力团队深入理解：不同模型在不同任务类型、不同价格区间下的表现差异。这种可观测性（visibility）使开发团队得以审慎权衡各项技术选型，并尽可能统一三款受支持模型（OpenAI / Azure OpenAI / Bedrock）的用户体验。在应用迭代过程中，LangSmith 不仅凸显了各模型输出的细微差异，更有效防止了性能退化（regression）问题流入生产环境。

> “在 Elastic AI 助手的开发过程中，LangChain 与 LangSmith 的协作带来了显著的正向影响，极大提升了整体开发与交付的速度与质量。没有 LangChain，我们无法向客户交付当前的产品体验；而没有 LangSmith，我们也无法以同等速度达成这一目标。”  
> —— James Spiteri，Elastic 安全产品管理总监

> “在 Elastic AI 助手的开发过程中，LangChain 与 LangSmith 的协作带来了显著的正向影响，极大提升了整体开发与交付的速度与质量。没有 LangChain，我们无法向客户交付当前的产品体验；而没有 LangSmith，我们也无法以同等速度达成这一目标。”  
> —— James Spiteri，Elastic 安全产品管理总监

LangChain and LangSmith also supported Elastic’s workflow to deliver a secure application to the enterprise.  
LangChain 和 LangSmith 也支持 Elastic 的工作流，助力其向企业交付安全的应用程序。

Mindful that their users were security experts and naturally skeptical, the Elastic team built out data masking in the app to obfuscate any sensitive data _before_ it was sent to the LLM, exposed the token tracking directly in the end product, so that users have full visibility on usage, and integrated their role based access control with the experience so that admins could limit usage as they wanted.  
考虑到其用户多为安全领域专家，且天性持审慎怀疑态度，Elastic 团队在应用中构建了数据脱敏功能——在敏感数据被发送至大语言模型（LLM）**之前**即完成遮蔽；同时，将 Token 使用量追踪直接呈现在最终产品界面中，确保用户对用量拥有完全可见性；此外，还将自身的基于角色的访问控制（RBAC）机制深度集成至用户体验中，使管理员可按需灵活限制使用权限。

### What’s next with Elastic AI Assistant?

### Elastic AI 助理的下一步规划？

The goal of the AI Assistant is to alleviate as much work as possible for the security analyst and give them more time back in their day. While the product supports three model providers today, the team wants to expand to more models to service an even wider audience.  
AI 助理的目标是尽可能减轻安全分析师的工作负担，为其每天腾出更多可用时间。目前该产品已支持三家模型提供商，而团队计划进一步拓展至更多模型，以服务更广泛的用户群体。

The next big step in the AI Assistant is to leverage LangChain’s agent framework so that more  work can be achieved in the background and have users approve actions. Moving beyond knowledge assistance will take the application to the next level, and the Elastic team feels confident they can deliver with the help of LangChain and LangSmith.  
AI 助理的下一个重大演进方向，是借助 LangChain 的 Agent 框架，实现更多后台自动化任务，并由用户对关键操作进行审批确认。突破传统“知识辅助”范畴，迈向主动式智能协同，将推动该应用跃升至全新高度；Elastic 团队对此充满信心，并坚信 LangChain 与 LangSmith 将成为其实现这一目标的关键助力。

### Giving back to the community

### 反哺开源社区

In the spirit of open source, the Elastic team has made available a lot of their code that powers the Elastic AI Assistant. You can see exactly how the team implemented their solution by checking out the repository [here](https://github.com/elastic/kibana/tree/main/x-pack/plugins/elastic_assistant?ref=blog.langchain.com). For other exciting educational content on ML development with Elastic, check out [Elastic Search Labs](https://www.elastic.co/search-labs?ref=blog.langchain.com). Enjoy!  
秉承开源精神，Elastic 团队已将其驱动 Elastic AI 助理的大量核心代码开源。您可通过访问该代码仓库 [此处](https://github.com/elastic/kibana/tree/main/x-pack/plugins/elastic_assistant?ref=blog.langchain.com)，深入了解团队的具体实现方案。如需了解更多关于 Elastic 平台机器学习开发的精彩教学内容，欢迎前往 [Elastic Search Labs](https://www.elastic.co/search-labs?ref=blog.langchain.com) 探索。敬请享用！

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/) [By LangChain](https://blog.langchain.com/tag/by-langchain/)  

[Case Studies（案例研究）](https://blog.langchain.com/tag/case-studies/) [By LangChain（LangChain 官方发布）](https://blog.langchain.com/tag/by-langchain/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI Agent 全面升级客户体验](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI Agent 全面升级客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![Evaluating Deep Agents: Our Learnings](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读
&#123;% endraw %}
