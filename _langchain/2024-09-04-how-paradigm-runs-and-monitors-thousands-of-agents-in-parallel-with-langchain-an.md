---
render_with_liquid: false
title: "How Paradigm runs and monitors thousands of agents in parallel with LangChain and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-paradigm/"
date: "2024-09-04"
scraped_at: "2026-03-03T07:54:36.957108096+00:00"
language: "en-zh"
translated: true
description: "See how Paradigm used LangSmith and LangChain to build, iterate, and monitor their AI agents."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[Paradigm](https://www.paradigmai.com/?ref=blog.langchain.com) (YC24) is transforming the traditional spreadsheet by integrating AI to create the first generally intelligent spreadsheet. Their tool orchestrates a swarm of AI agents to gather data, structure it, and execute tasks with human-level precision.

[Paradigm](https://www.paradigmai.com/?ref=blog.langchain.com)（YC24）正通过融合人工智能，重塑传统电子表格，打造全球首个通用智能电子表格。其工具可协调一群 AI 智能体（agents），以人类级别的精度完成数据采集、结构化与任务执行。

To achieve their goals, Paradigm has leveraged LangChain’s suite of products to build and productionize their product. [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), in particular, has provided critical operational insights and contextual awareness of their agent thought process and LLM usage. This enabled Paradigm to optimize both their product performance and pricing models, keeping compute costs low.

为实现上述目标，Paradigm 借助 LangChain 全套产品完成了产品的构建与规模化落地。其中，[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 尤为关键——它为 Paradigm 提供了至关重要的运维洞察，并使其能够深入理解智能体的推理过程及大语言模型（LLM）的实际调用情况。这助力 Paradigm 同步优化了产品性能与定价策略，显著降低了计算资源开销。

### **Building AI-Driven Spreadsheets with LangChain for Rapid Iteration**

### **借助 LangChain 构建 AI 驱动型电子表格，实现快速迭代**

Paradigm’s intelligent spreadsheet deploys numerous task-specific agents for data processing tasks, [all powered by LangChain](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com). Beyond data generation in their spreadsheet, Paradigm also uses LangChain-powered micro-agents for various small tasks throughout their product.

Paradigm 的智能电子表格针对各类数据处理任务，部署了大量面向特定任务的智能体，[全部基于 LangChain 构建](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)。除在电子表格中生成数据外，Paradigm 还在产品各环节广泛采用由 LangChain 驱动的微型智能体（micro-agents），以完成多种轻量级任务。

For instance, Paradigm developed the following agents using [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com):

例如，Paradigm 基于 [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) 开发了以下智能体：

1. **Schema agent**: Takes in a prompt as context and outputs a set of columns and column prompts that instruct our spreadsheet agents how to gather this data.  
1. **模式（Schema）智能体**：接收用户提示作为上下文，输出一组列名及其对应提示词，用于指导电子表格中的其他智能体如何采集该类数据。

2. **Sheet naming agent**. Automatically names each sheet based on the prompt provided and the data in the sheet.  
2. **工作表命名智能体**：根据用户提供的提示词及工作表内实际数据，自动为每张工作表生成恰当名称。

3. **Plan agent:** Organizes the agent’s tasks into stages given the context of each row of the spreadsheet. This helps parallelize research tasks and reduce latency without sacrificing accuracy.  
3. **规划（Plan）智能体**：依据电子表格每一行的数据上下文，将智能体的任务划分为若干阶段。此举既支持研究类任务的并行执行，又能在不牺牲准确性的前提下显著降低延迟。

4. **Contact info agent**. Performs a lookup for ways to reach a contact from unstructured data.  
4. **联系人信息智能体**：从非结构化数据中检索并提取联系人的联系方式。

![](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_001.jpg)Flow of agent operations for Paradigm  
![](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_001.jpg)Paradigm 智能体的运行流程

LangChain facilitated fast iteration cycles for these agents, allowing Paradigm to refine elements such as temperature settings, model selection, and prompt optimization before deploying them in production. These agents also leverage LangChain's abstractions in order to use [structured outputs](https://python.langchain.com/v0.2/docs/how_to/structured_output/?ref=blog.langchain.com) to generate information in the right schema.

LangChain 为这些智能体提供了高效的迭代周期，使 Paradigm 能够在正式上线前反复优化温度参数（temperature）、模型选型及提示词设计等关键要素。此外，这些智能体还充分利用 LangChain 的抽象能力，借助 [结构化输出（structured outputs）](https://python.langchain.com/v0.2/docs/how_to/structured_output/?ref=blog.langchain.com) 功能，确保所生成的信息严格符合预设的数据模式（schema）。

### **Monitoring in LangSmith to gain operational insights**

### **通过 LangSmith 实现监控，获取深度运维洞察**

Paradigm's AI-first spreadsheet is designed to handle extensive data processing tasks, with users triggering hundreds or thousands of individual agents to perform tasks on a per-cell basis. They also have a multitude of tools and APIs integrated into their backend that the agents can call to do certain tasks.

Paradigm 的 AI 优先型电子表格专为大规模数据处理而设计：用户可在每个单元格级别触发数百乃至数千个独立智能体协同执行任务。同时，其后端已集成大量工具与 API，供智能体按需调用以完成特定操作。

The complexity of these operations required a sophisticated system to monitor and optimize agent performance. LangSmith was invaluable in providing full context behind their agent’s thought processes and LLM usage.

这些操作的复杂性要求一个高度精密的系统来监控和优化智能体（agent）性能。LangSmith 在全面呈现其智能体的思维过程及大语言模型（LLM）使用情况方面发挥了不可替代的作用。

This granular level of insight allowed the Paradigm team to:

这种细粒度的洞察力使 Paradigm 团队得以：

- Track the execution flow of agents, including token usage and success rates.  
- 追踪智能体的执行流程，包括 token 使用量与成功率。

- Analyze and refine the dependency system for column generation, improving data quality by prioritizing tasks that require less context before moving on to more complex jobs.  
- 分析并优化列生成（column generation）所依赖的任务调度系统，通过优先执行对上下文依赖较少的任务，再逐步推进至更复杂的任务，从而提升数据质量。

For example, the Paradigm team could change the structure of the dependency system, re-run the same spreadsheet job, and assess which system led to the most clear and concise agent traces using LangSmith.  This type of observability is invaluable when developing complex agentic systems.

例如，Paradigm 团队可调整依赖系统的结构，重新运行同一份电子表格任务，并借助 LangSmith 评估哪种系统能生成最清晰、最简洁的智能体执行轨迹（agent traces）。此类可观测性能力，在开发复杂智能体系统时具有极高的价值。

### **Optimizing usage-based pricing with LangSmith**

### **借助 LangSmith 优化按用量计费模式**

With LangSmith’s [monitoring capabilities](https://docs.smith.langchain.com/how_to_guides/monitoring?ref=blog.langchain.com), Paradigm has also been able to execute and implement a precise usage-based pricing model. LangSmith gave the Paradigm team perfect context on their agent operations, including the specific tools leveraged, the order of their execution, and the token usage at each step. This allowed them to accurately calculate the cost of different tasks.

依托 LangSmith 的[监控能力](https://docs.smith.langchain.com/how_to_guides/monitoring?ref=blog.langchain.com)，Paradigm 还成功落地并实施了一套精准的按用量计费（usage-based pricing）模型。LangSmith 为 Paradigm 团队提供了其智能体运行过程的完整上下文信息，包括所调用的具体工具、各工具的执行顺序，以及每一步骤的 token 消耗量。这使得团队能够精确核算各类任务的实际成本。

![](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_002.png)Paradigm's traces in LangSmith for cost visibility

![](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_002.png)Paradigm 在 LangSmith 中的执行轨迹，用于成本可视化

For example, tasks involving simple data, such as names or links, incur lower costs compared to more complex outputs like candidate ratings or investment memos. Paradigm can support the multi-step reasoning needed for those complex outputs.

例如，处理姓名或链接等简单数据的任务，其成本明显低于生成候选人评级或投资备忘录等复杂输出的任务；而 Paradigm 正好能够支撑这类复杂输出所需的多步推理能力。

Similarly, retrieving private data, such as fundraising information, is more resource-intensive than scraping public data, justifying the need for a nuanced pricing model. Paradigm can thus support different types of tasks with varying costs. And by diving deep into their historical tool usage and input/output tokens per job, they could better understand how to shape their pricing and tool structure going forward.

同理，获取私募融资信息等私有数据，比爬取公开数据消耗更多计算资源，因此需要一套更为精细的差异化定价模型。Paradigm 由此得以支持成本各异的多种类型任务。此外，通过深入分析历史任务中各工具的调用频次，以及每个任务的输入/输出 token 消耗量，团队能够更清晰地把握未来定价策略与工具架构的优化方向。

### **Conclusion**

### **结语**

With LangSmith and LangChain, Paradigm has unlocked a variety of data processing tasks for their AI-integrated workspace and intelligent agent spreadsheets. Through rapid iteration, optimization, and operational insight, Paradigm delivers a high-performing, user-focused product for their users.

借助 LangSmith 和 LangChain，Paradigm 为其 AI 集成工作区及智能代理电子表格解锁了多种数据处理任务。通过快速迭代、持续优化与运营洞察，Paradigm 为用户交付了一款高性能、以用户为中心的产品。

To learn more about monitoring in LangSmith, watch [this video series](https://www.youtube.com/watch?v=4rupAXVraEA&list=PLfaIDFEXuae0bYV1_60f0aiM0qI7e1zSf&ref=blog.langchain.com). You can also [try LangSmith for free](https://smith.langchain.com/?ref=blog.langchain.com) to efficiently optimize and monitor your LLM applications.

如需深入了解 LangSmith 中的监控功能，请观看[本系列视频](https://www.youtube.com/watch?v=4rupAXVraEA&list=PLfaIDFEXuae0bYV1_60f0aiM0qI7e1zSf&ref=blog.langchain.com)。您还可[免费试用 LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)，高效优化并监控您的大语言模型（LLM）应用。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入驻流程](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith 构建 AI 智能体，重塑客户体验](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith 构建 AI 智能体，重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何借助 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 分钟阅读

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-paradigm-runs-and-monitors-thousands-of-agents-in-parallel-with-langchain-an/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟