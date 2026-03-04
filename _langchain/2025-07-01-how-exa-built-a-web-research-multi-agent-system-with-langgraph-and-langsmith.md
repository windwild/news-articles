---
title: "How Exa built a Web Research Multi-Agent System with LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/exa/"
date: "2025-07-01"
scraped_at: "2026-03-03T07:29:14.799873623+00:00"
language: "en-zh"
translated: true
description: "See how Exa used LangGraph and LangSmith to build a multi-agent web research system to process research queries"
tags: ["Case Studies"]
---
&#123;% raw %}

[Exa](https://exa.ai/?ref=blog.langchain.com)，以其高质量的搜索 API 著称，近日推出了迄今为止最具雄心的产品：一个深度研究智能体（deep research agent），能够自主浏览网络，直至找到用户所需的结构化信息。

本案例研究探讨了 Exa 工程团队如何借助 LangGraph 构建一套投入生产的多智能体系统——该系统每日可处理数百个研究类查询，并根据任务复杂度，在 15 秒至 3 分钟内返回结构化结果。

## 向智能体驱动型搜索演进

Exa 并非从智能体驱动型搜索起步，而是逐步演进至此。公司最初提供的是一个基础搜索 API；随后升级为“答案端点”（answers endpoint），将大语言模型（LLM）的推理能力与搜索结果相结合；如今，他们已迈入全新阶段：推出深度研究智能体——这是其首个真正具备智能体特性的搜索 API。

这一演进也映射出整个行业的普遍趋势：LLM 应用正日益向“更具智能体特性”（more agentic）和“更长生命周期”（long-running）方向发展。例如，在研究相关任务中，早期基于检索增强生成（RAG）的方案，已逐步演化为深度研究（Deep Research）；在编程领域，同样经历了从简单代码补全，到问答式编程辅助，再到如今异步、长时间运行的编程智能体的演进路径。

这种演进也在重塑团队对框架与工具的认知与使用方式。长期以来，我们通过一个[广受欢迎的开源集成](https://python.langchain.com/docs/integrations/tools/exa_search/?ref=blog.langchain.com)，与 Exa 团队保持着紧密合作关系；但直到本次，双方才首次在实际产品层面展开协作。Exa 最初的答案端点并未依赖任何框架，而当他们转向更复杂的深度研究架构时，便重新评估技术选型，并最终决定采用 LangGraph。这再次印证了我们观察到的一个共性趋势：随着系统架构日趋复杂，LangGraph 正日益成为构建智能体系统时的首选框架。

## 多智能体架构设计

Exa 的研究智能体完全基于 LangGraph 构建，采用了一种高度成熟的多智能体模式：

1. **规划器（Planner）**：分析研究查询，并动态生成多个并行任务  
2. **任务单元（Tasks）**：彼此独立的研究单元，可调用专用工具并执行专属推理  
3. **观察器（Observer）**：全程维护全部上下文，涵盖所有规划过程、推理步骤、输出结果及引用来源  

Exa 架构中的一项关键洞见在于其有意识的“上下文工程”（context engineering）。尽管观察器对所有组件的状态拥有全局可见性，但各任务单元仅接收其他任务最终清洗后的输出结果，而**不接收中间推理状态**。

![](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_001.png)

![](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_001.png)

Unlike rigid workflows, Exa's system dynamically adjusts the number of research tasks to spin up based on the complexity of the query. Each task receives:

- Specific task instructions  
- A required output format (always JSON schema)  
- Access to specialized Exa API tools  

与僵化的流程不同，Exa 的系统会根据查询的复杂程度动态调整启动的研究任务数量。每个任务均具备以下要素：

- 明确的任务指令  
- 强制性的输出格式（始终为 JSON Schema）  
- 对专用 Exa API 工具的访问权限  

This flexibility allows the system to scale from simple single-task queries to complex, multi-faceted research requiring numerous parallel investigations.

这种灵活性使系统能够从容应对从简单的单任务查询，到需要大量并行调查的复杂、多维度研究等各种场景。

## Evolving the agent blueprint

## 代理蓝图的演进

Many of Exa's design choices mirror those in the [Anthropic Deep Research system](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com). This is intentional. Like us, the Exa team read that blog post, thought it was fantastic, and drew many learnings from it.

Exa 的诸多设计选择，与 [Anthropic 深度研究系统](https://www.anthropic.com/engineering/built-multi-agent-research-system?ref=blog.langchain.com) 高度相似。这是有意为之的——正如我们一样，Exa 团队也阅读了该篇博客，并认为其极为出色，从中汲取了大量宝贵经验。

Here are a few key of their insights and decisions that build on top of those learnings:

以下是他们在前述经验基础上提炼出的若干关键洞见与决策：

### Search Snippets vs Full Results

### 搜索片段 vs 完整网页内容

One of the most interesting examples of context engineering in Exa's system is how it handles search content. Rather than automatically crawling full page content, the system first attempts reasoning on search snippets.

Exa 系统中最具启发性的上下文工程实践之一，便是其对搜索内容的处理方式：系统不会自动爬取整个网页内容，而是首先基于搜索结果片段（snippets）进行推理。

This approach significantly reduces token usage while preserving research quality, as the agent only requests full content when snippet-level reasoning proves insufficient. This ability to swap between search snippets and full results is powered by the Exa API.

该方法在显著降低 token 消耗的同时，仍能保障研究质量——仅当基于片段的推理不足以支撑结论时，代理才会请求获取完整网页内容。这种在“搜索片段”与“完整结果”之间灵活切换的能力，由 Exa API 提供支持。

### Structured Output

### 结构化输出

Unlike many research systems that produce unstructured reports, Exa's agent maintains structured JSON output at every level. The output format can be specified at runtime.

与许多生成非结构化报告的研究系统不同，Exa 的智能体在每一层级均保持结构化的 JSON 输出。输出格式可在运行时动态指定。

This design choice was driven by how Exa expects the agent to be used. Unlike consumer-facing research tools, they designed their system specifically for API consumption. When being used as an API, having a reliable output format is more critical. This structured output is generated via function calling.

这一设计决策源于 Exa 对该智能体使用场景的预期：与面向终端用户的研究工具不同，他们专门将系统设计为面向 API 调用。当作为 API 使用时，具备稳定可靠的输出格式至关重要。此类结构化输出通过函数调用（function calling）机制生成。

## Gaining observability with LangSmith

## 借助 LangSmith 实现可观测性

For Exa, one of the most critical LangSmith features was observability, especially around token usage.

对 Exa 而言，LangSmith 最关键的功能之一便是可观测性，尤其是对 token 使用情况的洞察。

> "The observability – understanding the token usage – that LangSmith provided was really important. It was also super easy to set up." – Mark Pekala, Software Engineer at Exa.

> “LangSmith 提供的可观测性——特别是对 token 使用量的清晰掌握——至关重要。而且其部署也极为简便。”——Exa 软件工程师 Mark Pekala。

This visibility into token consumption, caching rates, and reasoning token usage proved essential for informing Exa's production pricing models and ensuring cost-effective performance at scale.

这种对 token 消耗量、缓存命中率以及推理阶段 token 使用情况的可见性，对于指导 Exa 的生产环境定价模型、并确保大规模部署下的高性价比性能，起到了决定性作用。

## Conclusion

## 总结

Exa's deep research agent demonstrates how LangGraph enables sophisticated multi-agent systems in production. By leveraging LangGraph's coordination capabilities and LangSmith's observability features, Exa built a system that processes real customer queries with impressive speed and reliability.

Exa 的深度研究智能体展示了 LangGraph 如何赋能生产环境中复杂、成熟的多智能体系统。通过充分利用 LangGraph 的协同调度能力与 LangSmith 的可观测性功能，Exa 构建了一套能够以惊人速度和高可靠性处理真实客户查询的系统。

The key takeaways for teams building similar systems:

面向构建同类系统的团队，核心经验总结如下：

1. **Start with observability**: Token tracking and system visibility are critical for production deployment  
1. **从可观测性入手**：Token 跟踪与系统可见性对生产环境部署至关重要  

2. **Design for reusability**: Well-architected agent flows can power multiple products  
2. **面向可复用性设计**：架构优良的智能体（agent）流程可支撑多个产品  

3. **Prioritize structured output**: API consumers need reliable, parseable results  
3. **优先采用结构化输出**：API 调用方需要稳定、可解析的结果  

4. **Dynamic task generation**: Flexible task creation scales better than rigid workflows  
4. **动态任务生成**：灵活的任务创建机制相比僵化的流程更具可扩展性  

As the agent ecosystem continues to evolve, Exa's implementation provides a compelling example of how to build production-ready agentic systems that deliver real business value.  
随着智能体生态持续演进，Exa 的实践提供了一个极具说服力的范例——如何构建真正可用于生产的智能体系统，并切实创造商业价值。  

* * *

_To learn more about building multi-agent systems with LangGraph, visit our documentation at_ [_langchain-ai.github.io/langgraph_](https://langchain-ai.github.io/langgraph?ref=blog.langchain.com) _. To try Exa's deep research API, visit_ [_exa.ai_](https://exa.ai/?ref=blog.langchain.com) _._  
如需深入了解如何使用 LangGraph 构建多智能体系统，请访问我们的文档网站：[_langchain-ai.github.io/langgraph_](https://langchain-ai.github.io/langgraph?ref=blog.langchain.com)；如需试用 Exa 的深度研究 API，请访问 [_exa.ai_](https://exa.ai/?ref=blog.langchain.com)。  

### Tags  
### 标签  

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)  

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_002.png)](https://blog.langchain.com/customers-monday/)  
[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_002.png)](https://blog.langchain.com/customers-monday/)  

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)  
[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)  

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read  
[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何借助 LangSmith 实现对其客户成功智能体的可观测性](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-exa-built-a-web-research-multi-agent-system-with-langgraph-and-langsmith/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
