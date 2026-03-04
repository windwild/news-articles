---
title: "Cisco and OpenAI redefine enterprise engineering with AI agents | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/cisco"
date: "2026-01-20"
scraped_at: "2026-03-02T10:08:31.764839321+00:00"
language: "en-US"
translated: true
description: "Cisco and OpenAI redefine enterprise engineering with Codex, an AI software agent embedded in workflows to speed builds, automate defect fixes, and enable AI-native development."
tags: ["API"]
---
&#123;% raw %}

January 20, 2026

2026年1月20日

# Cisco and OpenAI redefine enterprise engineering with AI agents

# 思科与 OpenAI 借助 AI 智能体重新定义企业级工程实践

By deploying Codex broadly, Cisco made AI-native development a core part of how enterprise software gets built.

通过大规模部署 Codex，思科将原生 AI 开发确立为企业软件构建流程的核心环节。

![Cisco logo on blue background](images/cisco-and-openai-redefine-enterprise-engineering-with-ai-agents-openai/img_001.png)

![蓝色背景上的思科 Logo](images/cisco-and-openai-redefine-enterprise-engineering-with-ai-agents-openai/img_001.png)

For decades, Cisco has built and operated some of the world’s most complex, mission-critical software systems. As generative AI matured from experimentation to real operational capability, Cisco leaned into what it knows best: **scaling advanced technology inside demanding, real-world environments**.

数十年来，思科持续构建并运维着全球最复杂、最关键的软件系统之一。随着生成式 AI 从实验探索阶段迈向真正具备实际运营能力的成熟阶段，思科充分发挥其核心优势：**在严苛的真实世界环境中规模化部署前沿技术**。

That mindset led Cisco to begin working closely with OpenAI around Codex, helping define what enterprise-grade AI for software engineering should look like in practice—and how Codex could be applied to real, large-scale engineering work inside complex production environments.

这一理念推动思科围绕 Codex 与 OpenAI 展开深度合作，共同界定软件工程领域企业级 AI 在实践中的应有形态——以及 Codex 如何切实应用于复杂生产环境中真实的大规模工程任务。

Rather than treat Codex as a standalone developer tool, Cisco began integrating it directly into production engineering workflows, exposing it to massive multi-repository systems, C/C++-heavy codebases, and the security, compliance, and governance requirements of a global enterprise.

思科并未将 Codex 视为一个孤立的开发者工具，而是将其直接集成至生产环境下的工程工作流中，使其直面海量多仓库系统、以 C/C++ 为主的庞大代码库，以及全球化企业所必需的安全性、合规性与治理要求。

In the process, Cisco helped shape Codex into something fundamentally different from a developer productivity tool: **an AI engineering teammate capable of operating at enterprise scale**.

在此过程中，思科助力 Codex 实现了本质蜕变——它不再仅是提升开发者效率的工具，而成长为一名**真正可于企业级规模运行的 AI 工程伙伴**。

> "I’ve loved discovering new opportunities to integrate Codex into Cisco's enterprise software lifecycle workflows. Collaborating with the OpenAI team to get Codex enterprise production ready has been rewarding as well."

> “我很享受不断发掘将 Codex 深度融入思科企业级软件生命周期工作流的新契机；同时，与 OpenAI 团队通力协作，推动 Codex 达到企业级生产就绪状态，也令我深感振奋。”

—Ching Ho，思科（Cisco）工程领导团队成员

## Evaluating agentic AI in complex codebases

## 在复杂代码库中评估具身智能 AI

Cisco already runs a mature engineering organization with multiple AI initiatives in flight.  
思科已建立起成熟的工程组织，并同时推进多项 AI 计划。

What made Codex compelling wasn’t code completion or surface-level automation, but **agency**.  
让 Codex 真正脱颖而出的，并非代码补全或表层自动化，而是其**自主性（agency）**。

Codex demonstrated the ability to:  
Codex 展现出以下能力：

- Understand and reason across **large, interconnected repositories**  
- 深度理解并跨**大规模、相互关联的代码仓库**进行推理  

- Work fluently in **complex languages**  
- 流畅地处理**复杂的编程语言**  

- Execute real workflows through **CLI-based, autonomous compile-test-fix loops**  
- 通过基于命令行界面（CLI）的**自主式编译–测试–修复循环**，执行真实工程工作流  

- Operate within existing **review, security, and governance frameworks**  
- 在现有**代码评审、安全管控与治理框架**内运行  

By working directly with OpenAI, Cisco engineers were able to give feedback on how these capabilities behaved in real environments, shaping areas like workflow orchestration, security controls, and support for long-running engineering tasks—all of which are critical for enterprise use.  
通过与 OpenAI 的直接协作，思科工程师得以在真实环境中验证这些能力的表现，并就工作流编排、安全控制机制以及对长期运行工程任务的支持等方面提供反馈——而这些能力，正是企业级应用的关键所在。

## Using Codex for critical engineering workflows

## 将 Codex 应用于关键工程工作流

Once Codex was embedded into everyday engineering work, teams began applying it to some of their most challenging and time-consuming workflows:  
当 Codex 被深度集成至日常工程实践中后，各团队开始将其应用于一些最具挑战性、最耗时的核心工作流：

**Cross-repo build optimization**: Codex analyzed build logs and dependency graphs across more than 15 interconnected repositories, identifying inefficiencies. The result: a ~20% reduction in build times and more than **1,500 engineering hours saved per month** across global environments.  
**跨仓库构建优化**：Codex 分析了全球 15 个以上相互关联的代码仓库的构建日志与依赖关系图，精准识别出低效环节。成果包括：构建耗时降低约 20%，并在全球各环境中每月节省**超 1,500 工程人时**。

**Defect remediation at scale (CodeWatch)**: Using Codex-CLI, Cisco automated defect repair with iterative, agentic execution on large-scale C/C++ codebases. What once took weeks of manual effort now completes in hours, delivering a **10–15× increase in defect resolution throughput** and freeing engineers to focus on design and validation.  
**大规模缺陷修复（CodeWatch）**：借助 Codex-CLI，思科在大规模 C/C++ 代码库上，以迭代式、具身智能的方式实现了缺陷自动修复。原本需数周人工完成的任务，如今仅需数小时即可达成，缺陷修复吞吐量提升**10–15 倍**，从而释放工程师精力，使其更专注于系统设计与验证等高价值工作。

**Framework migrations in days, not weeks**: When Splunk teams needed to migrate multiple UIs from React 18 to 19, Codex handled the bulk of repetitive changes autonomously, compressing weeks of work into days and allowing engineers to concentrate on judgment-heavy decisions.  
**框架迁移：从“数周”缩短至“数天”**：当 Splunk 团队需将多个用户界面从 React 18 迁移至 React 19 时，Codex 自主完成了绝大部分重复性修改工作，将原本需数周完成的任务压缩至数天，使工程师得以聚焦于需深度判断的关键决策环节。

> “最大的收益来自于我们不再将 Codex 视为一个工具，而是将其当作团队的一员来对待。我们利用 Codex 生成并遵循一份计划文档，从而使评审团队能更轻松地理解整个开发流程以及所生成的代码。”

—Ryan Brady，思科（Cisco）Splunk 团队首席工程师

## 为大型企业塑造 Codex 的发展路线图

Cisco 基于真实生产环境中的持续使用，向 OpenAI 提供了大量反馈，助力 OpenAI 加速提升 Codex 面向大型企业的就绪度——尤其在合规性、长时间运行任务管理，以及与现有开发流水线集成等关键领域。

对 Cisco 而言，此次合作确立了一种可复用的下一代 AI 采用模式：**深度技术协作、真实业务负载驱动、以及自第一天起即实现的高层领导对齐**。

> “Codex 已成为我们未来思考 AI 辅助开发与运维方式中一个真正有意义的组成部分。”

—Brad Murphy，思科 Splunk 工程团队副总裁

在接下来的数月里，Cisco 与 OpenAI 将继续围绕 Codex 及更广泛的 AI 工程能力开展紧密协作，共同推进双方的共同使命：在企业级规模上实现原生 AI 工程（AI-native engineering）。
&#123;% endraw %}
