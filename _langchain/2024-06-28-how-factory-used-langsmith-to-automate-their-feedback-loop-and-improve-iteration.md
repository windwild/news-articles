---
title: "How Factory used LangSmith to automate their feedback loop and improve iteration speed by 2x"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-factory/"
date: "2024-06-28"
scraped_at: "2026-03-03T08:00:21.804873280+00:00"
language: "en-zh"
translated: true
description: "How Factory AI uses LangSmith to debug issues and close the product feedback loop, resulting in a 2x improvement in iteration speed."
tags: ["By LangChain", "Case Studies"]
---
&#123;% raw %}

In today’s fast-paced software development, streamlined Software Development Lifecycle (SDLC) capabilities are essential. Factory is building the secure AI platform for SDLC automation. Factory’s fleet of Droids automate different stages of the SDLC, boosting engineering velocity for large organizations — and their [Code Droid](https://www.factory.ai/news/code-droid-technical-report?ref=blog.langchain.com) has achieved state-of-the-art performance in complex software development tasks. By leveraging Self-hosted [LangSmith](http://www.langchain.com/langsmith?ref=blog.langchain.com), Factory meets complex observability requirements for autonomous LLM systems while maintaining enterprise-level security and privacy.

在当今快节奏的软件开发环境中，高效、简化的软件开发生命周期（SDLC）能力至关重要。Factory 正在构建一个面向 SDLC 自动化的安全 AI 平台。Factory 的“机器人”（Droid）集群可自动化 SDLC 的各个阶段，显著提升大型组织的工程交付速度——其 [Code Droid](https://www.factory.ai/news/code-droid-technical-report?ref=blog.langchain.com) 在复杂软件开发任务中已达到业界领先水平。通过采用自托管的 [LangSmith](http://www.langchain.com/langsmith?ref=blog.langchain.com)，Factory 满足了自主大语言模型（LLM）系统对复杂可观测性的要求，同时保障企业级的安全性与数据隐私。

## **Leveraging LangSmith for Secure and Reliable AI Operations**

## **借助 LangSmith 实现安全、可靠的 AI 运维**

Self-hosted LangSmith provides the necessary observability infrastructure needed to manage complex LLM workflows while ensuring data privacy and security. Factory can deploy LangSmith into environments where tight data controls prevent most LLM infrastructure from operating successfully.

自托管的 LangSmith 提供了管理复杂 LLM 工作流所必需的可观测性基础设施，同时确保数据隐私与安全。Factory 可将 LangSmith 部署至数据管控极为严格的环境中——这类环境通常会阻碍绝大多数 LLM 基础设施的正常运行。

One primary challenge Factory faced was ensuring robust observability in their customers' environments. Traditional methods for tracking data flow across LLM pipelines and debugging context-awareness issues were cumbersome. Additionally, Factory’s custom LLM tooling made most LLM observability tools challenging to set-up. LangSmith offered a complete solution with custom tracing via a first-party API.

Factory 面临的一个核心挑战，是在客户环境中实现强健的可观测性。传统方法在跨 LLM 流水线追踪数据流向、以及调试上下文感知（context-awareness）问题时，往往繁琐低效。此外，Factory 自研的 LLM 工具链也让大多数现成的 LLM 可观测性工具难以部署。LangSmith 凭借其原生 API 支持的定制化追踪能力，提供了端到端的完整解决方案。

Factory integrated LangSmith to export traces to AWS CloudWatch logs, which allowed the team to precisely track data flow through various stages of the LLM pipeline. By linking LangSmith events and steps with CloudWatch logs, Factory’s engineers could pinpoint their position in the agentic stage. This integration helped maintain a single source of truth for data flow in LLM from one step to the next, which is mission-critical for debugging and optimization.

Factory 将 LangSmith 集成至 AWS CloudWatch 日志系统，实现追踪数据向 CloudWatch 的自动导出，使团队能够精准掌握数据在 LLM 流水线各阶段的流转路径。通过将 LangSmith 中的事件与步骤同 CloudWatch 日志进行关联，Factory 工程师得以准确定位当前所处的智能体（agentic）执行阶段。该集成确保了 LLM 数据流从一步到下一步的“单一事实来源”（single source of truth），这对调试与性能优化具有决定性意义。

![](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_001.jpg)Main UI in LangSmith that Factory reviews in development.

![](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_001.jpg)Factory 在开发过程中审阅的 LangSmith 主界面。

Another challenge was debugging context-awareness issues in generated responses. Factory used LangSmith to link feedback directly to each LLM call, providing immediate insights into potential problems. This integration helped the team quickly identify and resolve issues like hallucinations without a proprietary logging system. With feedback available next to every LLM call, Factory could ensure that the AI’s outputs were contextually accurate and relevant based on real customer input.

另一项挑战是诊断生成响应中的上下文感知问题。Factory 利用 LangSmith 将用户反馈直接绑定至每一次 LLM 调用，从而即时洞察潜在问题。该集成帮助团队无需依赖专有日志系统，即可快速识别并解决幻觉（hallucination）等典型问题。由于每一条 LLM 调用旁均附带对应反馈，Factory 能够基于真实客户输入，持续验证并确保 AI 输出在上下文层面的准确性与相关性。

## **Closing the Product Feedback Loop with LangSmith**

## **借助 LangSmith 闭环产品反馈机制**

In addition to observability, Factory used LangSmith to optimize product feedback loops, focusing on prompt optimization and feedback API utilization. Traditional methods of manual prompt optimization were time-consuming and often inaccurate. LangSmith’s Feedback API streamlined the process, enabling Factory to collect and analyze feedback, then refine their prompts based on real-time data.

除可观测性外，Factory 还利用 LangSmith 优化产品反馈闭环，重点聚焦于提示词（prompt）优化与反馈 API 的深度应用。传统的手动提示词调优方式耗时长、准确率低。而 LangSmith 的 Feedback API 极大简化了这一流程：Factory 可借此高效收集与分析用户反馈，并基于实时数据持续迭代优化提示词。

![](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_002.jpg)_Factory's feedback loop starts with the Droid posting a comment and collecting positive/negative feedback. LangSmith analyzes the data, then Factory's engineers use custom LangChain tooling to optimize the prompt, re-prompt the LLM, and improve accuracy and reduce errors._

![](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_002.jpg)_Factory 的反馈闭环始于 Droid 发布评论并收集正/负向反馈；LangSmith 对反馈数据进行分析后，Factory 工程师借助定制化的 LangChain 工具链优化提示词，重新调用 LLM，从而提升输出准确率、降低错误率。_

Factory used the Feedback API to append feedback to various stages of their workflows. The feedback was then exported to datasets, and analyzed for patterns and areas for improvement.

Factory 利用 Feedback API 将反馈附加至其工作流的各个阶段。随后，这些反馈被导出至数据集，并用于分析其中的模式及待改进环节。

By benchmarking examples and automating the optimization process, Factory increased their control over accuracy and enhanced the overall performance of their AI models. For example, with examples of comments on code with good or bad feedback, they had the LLM look at a prompt and make a claim as to why the prompt may have caused a bad example (and not a good example). This streamlined feedback collecting and processing not only improved prompt optimization but also reduced mental overhead and infrastructure requirements for analyzing feedback.

通过基准测试样例并自动化优化流程，Factory 加强了对模型准确性的掌控能力，并整体提升了其 AI 模型的性能。例如，借助一批带有优质或低质反馈的代码评论样例，他们让大语言模型（LLM）审视某条提示词（prompt），并判断该提示词为何可能导致低质量输出（而非高质量输出）。这一方式大幅简化了反馈的收集与处理流程——不仅提升了提示词优化效率，还降低了人工分析反馈所需的认知负荷与基础设施投入。

The ability to automate feedback collection and processing was particularly valuable for pipeline steps that required human feedback. With LangSmith, Factory could focus on the final stages of feedback collection, ensuring that the most critical aspects of their Droid’s performance were continually refined and optimized.

在那些依赖人工反馈的流水线环节中，实现反馈收集与处理的自动化尤为关键。借助 LangSmith，Factory 能够将精力集中于反馈收集的最终阶段，确保其 Droid 最关键的性能维度持续得到精调与优化。

This approach led to significant improvements in accuracy and efficiency across their workflows. Compared to their previous method of manual data collection and human-driven prompt iteration, Factory was able to 2x their iteration speed. Factory also reports their average customer experienced a ~20% reduction in open-to-merge time, and a 3x reduction in code churn on code impacted by Droids in the first 90 days.

该方法显著提升了其工作流在准确性和效率两方面的表现。相较于此前依赖人工采集数据、由人工主导提示词迭代的传统方式，Factory 将迭代速度提升至原来的两倍。Factory 还报告称：其客户平均“提交至合并”（open-to-merge）耗时缩短约 20%，且在启用 Droid 后的前 90 天内，受 Droid 影响的代码变更频次（code churn）下降达三倍。

## **Looking Forward: Expanding AI Autonomy in the SDLC**

## **展望未来：在软件开发生命周期（SDLC）中拓展 AI 自治能力**

As Factory continues to innovate, their focus remains on enhancing AI capabilities across the entire SDLC. Partnering with LangChain and using LangSmith have been pivotal in this journey, providing the tools and infrastructure needed to achieve unprecedented levels of efficiency and quality in software development.

随着 Factory 持续创新，其重心始终聚焦于全面提升 AI 在整个软件开发生命周期（SDLC）中的能力。与 LangChain 的合作以及 LangSmith 的应用，在这一进程中发挥了关键作用，为其提供了实现软件开发效率与质量历史性突破所必需的工具与基础设施。

Factory’s [Droids](https://www.factory.ai/news/code-droid-technical-report?ref=blog.langchain.com) have already led to remarkable improvements in engineering operations. Clients report an average reduction in cycle time by up to 20%, with over 550,000 hours of development time saved across various organizations. These substantial time savings allow engineering teams to focus on innovative, value-added tasks, enhancing overall productivity and reducing operational costs.

Factory 的 [Droids](https://www.factory.ai/news/code-droid-technical-report?ref=blog.langchain.com) 已在工程运营层面带来显著改善。客户反馈显示，开发周期时间平均缩短高达 20%，各类组织累计节省开发工时逾 55 万小时。如此可观的时间节约，使工程团队得以专注于创新性、高附加值的任务，从而全面提升生产力，并降低运营成本。

The future looks bright for Factory as they continue to push the boundaries of AI in software development. With the recent public launch of their AI Droids and $15 million in Series A funding led by Sequoia Capital, Factory is poised for significant growth and innovation. The ongoing collaboration with LangChain is a cornerstone of this strategy, ensuring that Factory remains at the cutting edge of AI-driven software development.

Factory 在 AI 赋能软件开发领域的探索前景广阔。随着其 AI Droids 近日正式面向公众发布，以及由红杉资本（Sequoia Capital）领投的 1500 万美元 A 轮融资顺利完成，Factory 已蓄势待发，迈向规模化增长与持续创新的新阶段。而与 LangChain 的长期协作，正是这一战略的基石，有力保障 Factory 始终屹立于 AI 驱动型软件开发的最前沿。

> _“Our collaboration with LangChain has been critical to successfully deploying enterprise LLM-based systems. We are significantly more confident in our decision making and operational capabilities thanks to the observability and orchestration-layer tooling that we get from the LangChain team.” – Eno Reyes, CTO of Factory_

> _“我们与 LangChain 的合作，对成功部署企业级大语言模型（LLM）系统至关重要。得益于 LangChain 团队提供的可观测性与编排层工具，我们在决策制定与运营能力方面均获得了显著增强的信心。” —— Factory 首席技术官（CTO）Eno Reyes_

**About Factory**  

**关于 Factory**

Factory is an enterprise AI company dedicated to automating the software development lifecycle. By integrating advanced autonomous Droids, Factory helps businesses achieve faster, more reliable, and cost-effective software delivery.

Factory 是一家专注于自动化软件开发生命周期的企业级 AI 公司。通过集成先进的自主式 Droid（智能体），Factory 帮助企业实现更快速、更可靠且更具成本效益的软件交付。

For more insights and updates, visit [Factory’s website](https://factory.ai/?ref=blog.langchain.com).

如需了解更多洞见与最新动态，请访问 [Factory 官网](https://factory.ai/?ref=blog.langchain.com)。

**About LangChain**

**关于 LangChain**

LangChain, Inc. was founded in early 2023 to help developers build context-aware reasoning applications. The company’s popular open-source framework gives developers the building blocks to create production-ready applications with LLMs. LangSmith complements this as an all-in-one SaaS platform that enables a full, end-to-end development workflow for building and monitoring LangChain and LLM-powered apps.

LangChain, Inc. 成立于 2023 年初，旨在帮助开发者构建具备上下文感知能力的推理型应用。该公司广受欢迎的开源框架为开发者提供了构建面向生产环境的大型语言模型（LLM）应用所需的核心组件。LangSmith 作为一款一体化 SaaS 平台，进一步完善了这一生态——它支持从开发、调试到监控的完整端到端工作流，专为 LangChain 及 LLM 驱动的应用而设计。

For more information, visit [LangChain’s website](https://langchain.com/?ref=blog.langchain.com).

欲了解更多信息，请访问 [LangChain 官网](https://langchain.com/?ref=blog.langchain.com)。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/) [Case Studies](https://blog.langchain.com/tag/case-studies/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) [案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_003.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 分钟阅读

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入驻流程](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 完成数千名客户的入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 分钟阅读

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 分钟阅读

[![Evaluating Deep Agents: Our Learnings](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的实践经验总结](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的实践经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性](images/how-factory-used-langsmith-to-automate-their-feedback-loop-and-improve-iteration/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
