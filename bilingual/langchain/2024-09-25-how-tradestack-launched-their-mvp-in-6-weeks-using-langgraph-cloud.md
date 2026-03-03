---
title: "How Tradestack launched their MVP in 6 weeks using LangGraph Cloud"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-tradestack/"
date: "2024-09-25"
scraped_at: "2026-03-03T07:52:16.120919800+00:00"
language: "en-zh"
translated: true
description: "See how Tradestack built and launched their MVP with LangGraph Cloud, adding reliability and improved performance to their agentic workflows."
tags: ["Case Studies"]
---

Tradestack is a UK based startup with a mission to make the trades businesses more efficient. With a team of construction and real estate experts, they identified a key pain point: back-office tasks for trades businesses take a very long time. Their solution? An AI-powered assistant that could slash the time required for creating project quotes from hours to minutes.

Tradestack 是一家总部位于英国的初创公司，致力于提升贸易类企业的运营效率。凭借一支由建筑与房地产领域专家组成的团队，他们识别出一个关键痛点：贸易类企业的后台办公任务耗时极长。他们的解决方案？一款由人工智能驱动的助手，可将项目报价的制作时间从数小时大幅缩短至几分钟。

With the help of LangGraph Cloud, Tradestack:

在 LangGraph Cloud 的助力下，Tradestack 实现了：

- Built and launched an MVP in 6 weeks to a community of 28,000+ users  
- 在六周内构建并上线了最小可行产品（MVP），服务用户群体超过 28,000 人  

- Secured their first paying customers  
- 成功签约首批付费客户  

- Improved end-to-end performance from 36% to 85% via rapid iteration and new multimodal inputs and automation tools  
- 通过快速迭代，以及引入新型多模态输入与自动化工具，将端到端性能从 36% 提升至 85%  

## The Problem: Creating Quotation for Trades Businesses

## 痛点：贸易类企业生成报价单的复杂流程

Trades businesses face many complexities, and Tradestack chose to focus on reducing the administrative burden of creating quotes for construction and real estate projects. For example, creating quotes for painting and decorating projects is an extensive process – this can include analyzing floor plans, reviewing project images, estimating effort, calculating material prices, and crafting a professional document for client presentation.

贸易类企业面临诸多复杂挑战，Tradestack 选择聚焦于减轻建筑与房地产项目报价工作中的行政负担。例如，为油漆与装饰类项目生成报价单便是一项繁复的工作——该过程通常涵盖分析平面图、审阅项目图片、评估人工工时、核算材料成本，以及为客户呈现定制一份专业文档。

This process typically consumes 3.5 to 10 hours for a single project quote. Tradestack's vision was to reduce this time to under 15 minutes.

这一流程通常需耗费 3.5 至 10 小时才能完成单个项目报价。Tradestack 的愿景是将该耗时压缩至 15 分钟以内。

## MVP: WhatsApp assistant to automate quotes for painting and decoration projects

## 最小可行产品（MVP）：基于 WhatsApp 的报价自动化助手（面向油漆与装饰类项目）

Tradestack's top priority was to test their value proposition by experimenting with different levels of guidance across cognitive architectures. [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) allowed them to design these architectures using graphs, nodes, and edges while managing a shared state that each node could write to. This setup maintained input flexibility (voice, text, images, documents) while producing accurate, personalized client quotes.

Tradestack 的首要目标是通过在不同认知架构中尝试多种引导层级，来验证其价值主张。[LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 使他们能够以图（graphs）、节点（nodes）和边（edges）的方式设计这些架构，并统一管理各节点均可写入的共享状态。该架构既保持了输入方式的高度灵活性（支持语音、文本、图像、文档），又能生成准确且高度个性化的客户报价。

Given the widespread adoption of WhatsApp, especially among non-tech-savvy users, Tradestack chose it as their primary interface. To deliver meaningful business impact, they needed to reliably process a wide range of inputs sent via WhatsApp. This required identifying the necessary skills for each task and, when needed, asking users or experts for clarification.

鉴于 WhatsApp 在全球范围内（尤其在非技术背景用户中）的广泛普及，Tradestack 将其选为主要交互界面。为切实产生可观的商业价值，他们必须可靠地处理经 WhatsApp 发送而来的各类输入信息。这要求团队精准识别每项任务所需的核心能力，并在必要时主动向用户或领域专家寻求澄清。

![](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_001.jpg)

However, getting an AI agent system to consistently perform at a high quality with diverse inputs was not so straightforward. There were multiple points of failure in designing such a system, including:

- Variety or ambiguity in the user input  
- Different starting and ending points for different users  
- Inconsistent or inaccurate parts of planning or routing done by an LLM node  

然而，让一个 AI 智能体系统在面对多样化输入时始终稳定输出高质量结果，并非易事。此类系统的设计过程中存在多个潜在故障点，包括：

- 用户输入的多样性或模糊性  
- 不同用户具有不同的起始点和终点  
- 由大语言模型（LLM）节点执行的规划或路由过程存在不一致或不准确之处  

Tradestack’s goal was to build an MVP that struck the right balance between capability, versatility, and reliability.

Tradestack 的目标是构建一个最小可行产品（MVP），在能力、通用性与可靠性之间取得恰到好处的平衡。

![](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_002.jpg)

![](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_002.jpg)

LangGraph was the clear solution. Already familiar with the LangChain ecosystem, the Tradestack team valued LCEL’s abstractions and LangSmith’s tracing for fast iteration and performance evaluation. LangGraph's intuitive framework gave them the control needed to design reasoning and memory flows tailored to their users' needs. With LangGraph Cloud, they further improved their agentic workflows at scale, iterating quickly and adding multimodal inputs to deliver high-quality outputs.

LangGraph 成为显而易见的解决方案。Tradestack 团队早已熟悉 LangChain 生态系统，十分认可 LCEL（LangChain Expression Language）提供的抽象能力，以及 LangSmith 提供的追踪功能——二者共同支撑了快速迭代与性能评估。LangGraph 直观的框架赋予他们充分的控制力，使其能够按用户实际需求定制推理逻辑与记忆流程。借助 LangGraph Cloud，他们进一步实现了智能体工作流的大规模优化：快速迭代、无缝集成多模态输入，从而持续交付高质量输出。

### **Rapid iteration with LangGraph Studio**

### **借助 LangGraph Studio 实现快速迭代**

With LangGraph, Tradestack experimented with personalized reasoning, which meant tailoring the reasoning process to user preferences rather than just content generation. By leveraging [configuration variables](https://langchain-ai.github.io/langgraph/how-tos/configuration/?ref=blog.langchain.com), Tradestack customized instructions and pathways in their cognitive architecture, selecting sub-graphs depending on specific use cases. This flexibility allowed them to strike the right balance between input modalities—whether voice, text, or images—and the reliability of the final output.

借助 LangGraph，Tradestack 尝试了“个性化推理”——即根据用户偏好定制推理过程，而非仅聚焦于内容生成。通过运用[配置变量](https://langchain-ai.github.io/langgraph/how-tos/configuration/?ref=blog.langchain.com)，Tradestack 在其认知架构中灵活定制指令与执行路径，并依据具体用例动态选择子图（sub-graph）。这种灵活性使他们得以在输入模态（语音、文本或图像）与最终输出的可靠性之间达成理想平衡。

Tradestack initially used [LangGraph Templates](https://blog.langchain.com/launching-langgraph-templates/) as a starting point, adopting a hierarchical multi-agent system with a supervisor node that expanded on user queries and created plans based on the task's goals. By giving internal stakeholders access to [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/), the visual studio for agent interactions, they were able to quickly identify flaws, iterate on their design, and improve performance. Their team could talk to the assistant and record the feedback in parallel with development, **saving two weeks of internal testing time.**

Tradestack 最初以 [LangGraph 模板](https://blog.langchain.com/launching-langgraph-templates/) 为起点，构建了一套分层式多智能体系统：其中“监督节点”（supervisor node）负责扩展用户查询，并依据任务目标制定执行计划。通过向内部利益相关方开放 [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/)——这一专为智能体交互设计的可视化开发环境——团队得以迅速识别设计缺陷、高效迭代方案并持续提升性能。开发人员可一边与智能体对话、一边同步记录反馈，**从而节省了整整两周的内部测试时间。**

### **Deploying with LangGraph Cloud**

### **借助 LangGraph Cloud 实现部署**

Once their MVP was ready, Tradestack seamlessly deployed it using [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com). As a lean team, they needed a platform that could handle deployment, monitoring, and submitting revisions with ease. LangGraph Cloud provided exactly that, allowing them to focus on refining their AI agent rather than infrastructure concerns.

当 MVP 准备就绪后，Tradestack 借助 [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com) 实现了无缝部署。作为一支精干团队，他们亟需一个能轻松完成部署、监控及版本更新的平台。LangGraph Cloud 正好满足了全部需求，使他们得以将精力集中于 AI 智能体的功能优化，而无需分心处理底层基础设施问题。

To ensure smooth user interactions on the WhatsApp assistant interface, they utilized LangGraph’s “interrupt” feature and built a custom middleware to manage [double-texting](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#double-texting) and their message queue intelligently. LangSmith tracing was integrated directly into their workflow, making it easy to review and evaluate each run.

为确保 WhatsApp 助理界面的用户交互顺畅，Tradestack 利用了 LangGraph 的“中断（interrupt）”功能，并构建了自定义中间件，以智能管理[重复发送消息（double-texting）](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#double-texting)及消息队列。LangSmith 追踪功能被直接集成至其工作流中，使每次运行的审查与评估变得轻而易举。

LangSmith also helped the Tradestack team identify performance gaps with robust testing. By setting up node-level and end-to-end evaluations in LangSmith, Tradestack could experiment with different models for the planning node and see which models performed the best. For example, they found that _gpt-4-0125-preview_ performed better than _gpt-4o_ for the planning node, which helped them optimize at the node-level.

LangSmith 还通过强大的测试能力，助力 Tradestack 团队识别性能短板。通过在 LangSmith 中配置节点级与端到端评估，Tradestack 能够针对规划（planning）节点尝试不同大模型，并直观比较各模型表现。例如，他们发现 _gpt-4-0125-preview_ 在规划节点上的表现优于 _gpt-4o_，从而实现了节点级别的精准优化。

### **UX considerations with streaming modes**

### **流式传输模式下的用户体验考量**

To create a user-friendly experience on WhatsApp, Tradestack carefully controlled the amount of information streamed to users. They didn’t want to overwhelm users with unnecessary intermediate steps, so they used LangGraph’s flexible streaming options to only display key messages from selected nodes. An aggregator node was added to combine outputs from various intermediate steps, providing a consistent tone of voice in all communications.

为在 WhatsApp 上打造友好的用户体验，Tradestack 精心控制了向用户流式传输的信息量。他们不希望用冗余的中间步骤干扰用户，因此借助 LangGraph 灵活的流式传输选项，仅向用户展示来自特定节点的关键消息。此外，他们新增了一个聚合（aggregator）节点，用于整合多个中间步骤的输出，从而确保所有通信均保持一致的语气与风格。

Human-in-the-loop interventions also played a vital role in Tradestack’s UX. When edge cases arose—such as users requesting materials unavailable in the UK—the system would trigger manual intervention. Tradestack’s team could then step in via Slack or directly in LangGraph Studio to adjust the conversation. This helped ensure user’s needs were met without compromising user experience.

人工介入（human-in-the-loop）机制也在 Tradestack 的用户体验设计中发挥了关键作用。当出现边缘情况时——例如用户请求英国境内无法提供的材料——系统便会自动触发人工干预流程。此时，Tradestack 团队可通过 Slack 或直接在 LangGraph Studio 中介入并调整对话内容。此举既保障了用户需求得到切实满足，又未对整体用户体验造成任何损害。

### **Conclusion**

### **结语**

Looking forward, Tradestack plans to deepen their integration with LangSmith for fine-tuning datasets and expand their agent's capabilities. They aim to explore voice agent UX, agent training modes, and further integration with external tools, ensuring their AI solution continues to evolve and provide value to users.

展望未来，Tradestack 计划进一步深化与 LangSmith 的集成，以支持数据集微调，并持续拓展其智能体（agent）的能力边界。他们将探索语音智能体的用户体验设计、智能体训练模式，以及与外部工具的更深度集成，确保其 AI 解决方案持续演进，为用户创造长期价值。

You can learn more about [Tradestack](https://www.tradestack.uk/?ref=blog.langchain.com)’s mission, and [read here](https://langchain-ai.github.io/langgraph/cloud/quick_start/?ref=blog.langchain.com#using-langgraph-studio-desktop-recommended) for how to get started with LangGraph Cloud. For more LangChain news, [follow us on X](https://x.com/LangChainAI/?ref=blog.langchain.com) and get the latest product updates on our [Changelog](https://changelog.langchain.com/?ref=blog.langchain.com).

您可进一步了解 [Tradestack](https://www.tradestack.uk/?ref=blog.langchain.com) 的使命；也可[点击此处](https://langchain-ai.github.io/langgraph/cloud/quick_start/?ref=blog.langchain.com#using-langgraph-studio-desktop-recommended)查阅 LangGraph Cloud 入门指南。如需获取更多 LangChain 最新动态，请[关注我们在 X 平台的官方账号](https://x.com/LangChainAI/?ref=blog.langchain.com)，或访问我们的 [更新日志（Changelog）](https://changelog.langchain.com/?ref=blog.langchain.com) 获取最新产品更新。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成自助开通](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_004.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成自助开通**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith 构建 AI 智能体，全面升级客户体验](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith 构建 AI 智能体，全面升级客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-tradestack-launched-their-mvp-in-6-weeks-using-langgraph-cloud/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟