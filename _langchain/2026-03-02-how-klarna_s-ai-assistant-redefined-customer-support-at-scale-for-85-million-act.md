---
render_with_liquid: false
title: "How Klarna's AI assistant redefined customer support at scale for 85 million active users"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-klarna/"
date: "2026-03-02"
scraped_at: "2026-03-03T07:14:10.682551632+00:00"
language: "en-zh"
translated: true
description: "Klarna's AI assistant is revolutionizing the personal shopping experience, including customer service and productivity. See how they used LangGraph and LangSmith to achieve 80% faster customer resolut..."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Klarna](https://www.klarna.com/?ref=blog.langchain.com) has reshaped global commerce with its consumer-centric, AI-powered payment and shopping solutions. With over 85 million active users and 2.5 million daily transactions on its platform, Klarna is a fintech leader that simplifies shopping while empowering consumers with smarter, more flexible financial solutions.

[Klarna](https://www.klarna.com/?ref=blog.langchain.com) 凭借以消费者为中心、由人工智能驱动的支付与购物解决方案，重塑了全球商业格局。其平台拥有超过 8500 万活跃用户，日均交易量达 250 万笔，是金融科技领域的领军企业——既简化了消费者的购物流程，又为其提供了更智能、更灵活的金融解决方案。

Klarna’s flagship AI Assistant is revolutionizing the shopping and payments experience. Built on [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) and powered by [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), the AI Assistant handles tasks ranging from customer payments, to refunds, to other payment escalations.

Klarna 的旗舰级 AI 助理正在彻底变革购物与支付体验。该助理基于 [LangGraph](https://langchain.com/langgraph?ref=blog.langchain.com) 构建，并由 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 提供支持，可处理从客户付款、退款到各类支付升级事件（escalations）等广泛任务。

With 2.5 million conversations to date, the AI Assistant is more than just a chatbot; it’s a transformative agent that performs the work equivalent of 700 full-time staff, delivering results quickly and improving company efficiency.

截至目前，AI 助理已完成了 250 万次对话——它远不止是一个聊天机器人；而是一个具备变革能力的智能体（agent），其工作量相当于 700 名全职员工，能够快速交付成果，并显著提升公司运营效率。

## **The Challenge: Scaling Customer Support & Handling Escalations**

## **挑战：规模化客户支持与高效处理升级事件**

### **Overcoming escalation overload**

### **应对升级事件过载难题**

Klarna faced growing challenges in managing multi-departmental escalations. To meet rising consumer expectations, Klarna needed a solution that could combine speed, accuracy, and accessibility while scaling across global markets.

Klarna 在协调跨部门升级事件方面面临日益严峻的挑战。为满足消费者不断攀升的期望，Klarna 急需一套兼具响应速度、处理精度与使用便捷性的解决方案，并能无缝扩展至全球各市场。

> _"LangChain has been a great partner in helping us realize our vision for an AI-powered assistant, scaling support and delivering superior customer experiences across the globe."_— **Sebastian Siemiatkowski**, CEO and Co-Founder, Klarna

> “LangChain 是我们实现 AI 助理愿景过程中极为出色的合作伙伴，助力我们规模化客户支持能力，并在全球范围内交付卓越的客户体验。”  
> —— **Sebastian Siemiatkowski**，Klarna 首席执行官兼联合创始人

## **The Solution: Powered by LangGraph and LangSmith**

## **解决方案：由 LangGraph 与 LangSmith 驱动**

### **A partnership driving precision and performance**

### **强强联手，共塑精准性与高性能**

Klarna turned to LangGraph and LangSmith to evolve their AI Assistant into a reliable, scalable multi-agent system. Key improvements included:

Klarna 借助 LangGraph 与 LangSmith，将其 AI 助理升级为一个可靠、可扩展的多智能体（multi-agent）系统。关键改进包括：

1. **Controllable agent architecture**: Klarna’s AI assistant routed requests and handled different tasks using the LangGraph framework.  
1. **可控的智能体架构**：Klarna 的 AI 助理借助 LangGraph 框架对请求进行路由并处理各类任务。这有助于降低延迟、提升系统可靠性，并削减运维成本。

2. **Context-aware intelligence**: By dynamically tailoring prompts to specific scenarios, Klarna ensured that their AI assistant consistently delivered relevant, context-aware responses while reducing token costs and latency.  
2. **上下文感知的智能能力**：通过针对特定场景动态调整提示词（prompts），Klarna 确保其 AI 助理始终输出相关且具备上下文感知能力的响应，同时降低了 token 开销与响应延迟。

3. **Test-driven development**: With LangSmith, Klarna could pinpoint what issues arose by seeing step-by-step how their AI assistant behaved. Leveraging LangSmith, Klarna rigorously tested critical use cases for their AI assistant, then validated and refined agent performance with LLM evaluations and prompt iteration.  
3. **测试驱动开发**：借助 LangSmith，Klarna 能够通过逐步骤观察 AI 助理的行为，精准定位问题所在。利用 LangSmith，Klarna 对 AI 助理的关键使用场景进行了严格测试，并结合大语言模型（LLM）评估与提示词迭代，持续验证并优化智能体性能。

4. **Prompt optimization**: Klarna’s insights in turn improved LangSmith’s prompt engineering features – notably, Klarna helped inspire and design advanced capabilities like meta-prompting. Meta-prompting allows users to suggest specific improvements to the prompts, _by prompting them_ and seeing how the optimized prompt impacted response quality.  
4. **提示词优化**：Klarna 的实践经验反向推动了 LangSmith 提示工程功能的升级——尤为突出的是，Klarna 参与启发并共同设计了“元提示”（meta-prompting）等高级能力。元提示使用户能够通过向提示词本身发起提示（prompting the prompt），提出具体改进建议，并直观评估优化后的提示词对响应质量的影响。

## **The Impact**

## **实际成效**

Built with LangGraph and refined with LangSmith, Klarna’s AI assistant has empowered their teams to handle customer escalations more effectively. They’ve achieved the following results in the past 9 months:

基于 LangGraph 构建、并经 LangSmith 持续优化，Klarna 的 AI 助理显著提升了团队应对客户升级问题的能力。在过去 9 个月中，已实现以下成果：

- **Faster resolutions**: Reduced average customer query resolution time by 80%, enabling faster responses to user queries and saving analysts and engineers hours a week of investigation time.  
- **更快的问题解决**：客户查询平均解决时间缩短 80%，大幅加快了对用户问题的响应速度，并为分析师与工程师每周节省数小时的问题排查时间。

- **Increased AI automation for chat handling**: Automated ~70% of repetitive support tasks, freeing up customer service agents to handle complex, high-value interactions  
- **提升聊天场景的 AI 自动化水平**：约 70% 的重复性客服任务实现自动化，使客服人员得以专注于处理更复杂、高价值的交互任务。

- **Improved accuracy**: Improved root cause identification for rejection, leading to a significant reduction in customer escalations.  
- **准确性提升**：增强了拒付类问题的根本原因识别能力，从而显著降低了客户升级投诉量。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-klarna_s-ai-assistant-redefined-customer-support-at-scale-for-85-million-act/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟