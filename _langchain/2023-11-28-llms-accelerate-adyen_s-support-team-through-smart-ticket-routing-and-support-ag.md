---
title: "LLMs accelerate Adyen's support team through smart-ticket routing and support agent copilot"
source: "LangChain Blog"
url: "https://blog.langchain.com/llms-accelerate-adyens-support-team-through-smart-ticket-routing-and-support-agent-copilot/"
date: "2023-11-28"
scraped_at: "2026-03-03T08:23:31.760120766+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
{% raw %}

## Challenge

随着全球商业活动加速发展，[Adyen](https://www.adyen.com/?ref=blog.langchain.com)（一家公开上市的金融科技平台）正通过提供端到端支付能力、数据驱动的洞察以及一体化的全球金融产品，助力 Meta、Uber、H&M 和 Microsoft 等大型企业更快实现其战略目标。

随着签约商户数量持续增长、交易量不断攀升，Adyen 的客户支持团队面临日益加剧的压力；为此，Adyen 内部一支团队迅速着手寻找可规模化复用的技术解决方案。“我们是工程师，因此始终致力于通过技术手段提升业务规模，而非单纯扩大团队规模。”Adyen 工程与数据高级副总裁 Andreu Mora 表示，“我们希望深入理解、有效应用并持续推进大语言模型（LLM）等前沿技术，从而提升团队与客户的效率和满意度。”

Adyen 在位于[西班牙马德里](https://careers.adyen.com/locations/madrid?ref=blog.langchain.com)的新技术中心组建了一支精干高效的数据科学家与机器学习工程师团队，负责推进一系列高影响力项目，首要目标即为加速客户支持团队的工作效能。

## 挑战

随着全球商业活动加速发展，[Adyen](https://www.adyen.com/?ref=blog.langchain.com)（一家公开上市的金融科技平台）正通过提供端到端支付能力、数据驱动的洞察以及一体化的全球金融产品，助力 Meta、Uber、H&M 和 Microsoft 等大型企业更快实现其战略目标。

随着签约商户数量持续增长、交易量不断攀升，Adyen 的客户支持团队面临日益加剧的压力；为此，Adyen 内部一支团队迅速着手寻找可规模化复用的技术解决方案。“我们是工程师，因此始终致力于通过技术手段提升业务规模，而非单纯扩大团队规模。”Adyen 工程与数据高级副总裁 Andreu Mora 表示，“我们希望深入理解、有效应用并持续推进大语言模型（LLM）等前沿技术，从而提升团队与客户的效率和满意度。”

Adyen 在位于[西班牙马德里](https://careers.adyen.com/locations/madrid?ref=blog.langchain.com)的新技术中心组建了一支精干高效的数据科学家与机器学习工程师团队，负责推进一系列高影响力项目，首要目标即为加速客户支持团队的工作效能。

## Solution

聚焦于提升支持团队的工作效率与满意度，该团队发现：工单在不同团队间流转是影响响应时效的关键因素。这一挑战恰好适合通过以下两项初始大语言模型（LLM）应用来解决：

1. 一套智能工单路由系统——基于工单内容，将工单以最快速度分派给最合适的客服人员；
2. 一款客服人员智能助手（Copilot）——通过名为“问答建议”（Question Answering Suggestions）的方法，帮助客服人员更快速、更准确地回复工单。

Adyen 选择使用 LangChain 构建上述系统，原因在于：LangChain 提供了一个统一、易于定制的框架，可高效支撑从原型验证到生产部署的全流程；同时，在模型选型探索阶段，它还能避免团队被单一模型厂商锁定。此外，Adyen 还依托 LangChain 的开发者平台 LangSmith，对应用性能进行评估，并横向对比不同底层大语言模型对响应质量与成本的影响。

LangChain 的高度灵活性，使 Adyen 能够轻松切换链（Chain）中的核心大语言模型。为确保与内部大语言模型 API 接口的无缝集成，团队开发了一个自定义类，继承自 LangChain 的基础 LLM 类，并将其嵌入基于事件驱动的微服务架构中；该架构部署于 Kubernetes 集群之上。如需深入了解 Adyen 智能工单路由系统与客服智能助手背后的技术细节，欢迎阅读 Adyen 博客发布的深度技术解析文章，作者为 [Andreu Mora](https://www.linkedin.com/in/andreumora/?originalSubdomain=nl&ref=blog.langchain.com)（工程与数据高级副总裁）与 [Rafael Hernandez](https://www.linkedin.com/in/rahermur/?locale=en_US&ref=blog.langchain.com)（运营 AI 团队负责人），链接如下：[https://www.adyen.com/knowledge-hub/operational-efficiency-llms?ref=blog.langchain.com](https://www.adyen.com/knowledge-hub/operational-efficiency-llms?ref=blog.langchain.com)。

## 解决方案

聚焦于提升支持团队的工作效率与满意度，该团队发现：工单在不同团队间流转是影响响应时效的关键因素。这一挑战恰好适合通过以下两项初始大语言模型（LLM）应用来解决：

1. 一套智能工单路由系统——基于工单内容，将工单以最快速度分派给最合适的客服人员；
2. 一款客服人员智能助手（Copilot）——通过名为“问答建议”（Question Answering Suggestions）的方法，帮助客服人员更快速、更准确地回复工单。

Adyen 选择使用 LangChain 构建上述系统，原因在于：LangChain 提供了一个统一、易于定制的框架，可高效支撑从原型验证到生产部署的全流程；同时，在模型选型探索阶段，它还能避免团队被单一模型厂商锁定。此外，Adyen 还依托 LangChain 的开发者平台 LangSmith，对应用性能进行评估，并横向对比不同底层大语言模型对响应质量与成本的影响。

LangChain 的高度灵活性，使 Adyen 能够轻松切换链（Chain）中的核心大语言模型。为确保与内部大语言模型 API 接口的无缝集成，团队开发了一个自定义类，继承自 LangChain 的基础 LLM 类，并将其嵌入基于事件驱动的微服务架构中；该架构部署于 Kubernetes 集群之上。如需深入了解 Adyen 智能工单路由系统与客服智能助手背后的技术细节，欢迎阅读 Adyen 博客发布的深度技术解析文章，作者为 [Andreu Mora](https://www.linkedin.com/in/andreumora/?originalSubdomain=nl&ref=blog.langchain.com)（工程与数据高级副总裁）与 [Rafael Hernandez](https://www.linkedin.com/in/rahermur/?locale=en_US&ref=blog.langchain.com)（运营 AI 团队负责人），链接如下：[https://www.adyen.com/knowledge-hub/operational-efficiency-llms?ref=blog.langchain.com](https://www.adyen.com/knowledge-hub/operational-efficiency-llms?ref=blog.langchain.com)。

## Results

## 成果

### **_More efficient and accurate ticket routing_**

### **更高效、更精准的工单路由**

The foundation of Adyen’s smart ticket router is an internal tool that analyzes the theme and sentiment of each ticket, and dynamically updates its priority based on the user.  With Adyen’s wide array of products, features & services, this LLM-driven approach enables merchants to receive support from the technical experts most suited to respond quickly.

Adyen 智能工单路由系统的核心，是一款内部工具，可分析每张工单的主题与情感倾向，并基于用户动态调整其优先级。凭借 Adyen 丰富多样的产品、功能与服务，这种由大语言模型（LLM）驱动的方法，使商户能够快速获得最匹配的技术专家支持。

### **_Quicker support response times_**

### **更快的支持响应速度**

In just 4 months the Adyen team was able to build a comprehensive collection of relevant documents (combining public and private company documents) and store them in a vector database with an embedding model that optimized for effective retrieval. The team’s first milestone on its way to generating proposed ticket responses was finding the most relevant and up-to-date document from a collection of public and private documents. This approach far outperformed traditional keyword-based search and, just as importantly, immediately established the team’s trust in the new system.

仅用 4 个月时间，Adyen 团队便构建起一套全面的相关文档库（整合了公开与内部公司文档），并借助专为高效检索优化的嵌入模型，将其存入向量数据库。团队在生成建议工单回复之路上的第一个里程碑，便是从海量公私文档中精准定位出最相关、最新颖的文档。该方法远超传统关键词搜索的效果；更重要的是，它迅速赢得了团队对新系统的信任。

The next step was to connect to an LLM to produce a suggested response for support agents through their proprietary copilot. “With the right set of tickets in their queues and easily-modifiable potential answers to customer inquiries at their fingertips, support agents are more efficient and more satisfied.” said Andreu.

下一步是将系统接入大语言模型（LLM），通过其自研的 Copilot 为客服人员生成建议回复。“当客服人员队列中拥有恰当的工单集，且能随时调取、便捷修改针对客户咨询的潜在答复时，他们的工作效率和满意度都会显著提升。”Andreu 表示。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/llms-accelerate-adyen_s-support-team-through-smart-ticket-routing-and-support-ag/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
{% endraw %}
