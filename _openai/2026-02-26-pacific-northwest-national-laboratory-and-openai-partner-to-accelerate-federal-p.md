---
title: "Pacific Northwest National Laboratory and OpenAI partner to accelerate federal permitting  | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/pacific-northwest-national-laboratory"
date: "2026-02-26"
scraped_at: "2026-03-02T10:08:16.764017129+00:00"
language: "en-US"
translated: true
description: "OpenAI and Pacific Northwest National Laboratory introduce DraftNEPABench, a new benchmark evaluating how AI coding agents can accelerate federal permitting—showing potential to reduce NEPA drafting..."
tags: ["Global Affairs"]
---
{% raw %}

February 26, 2026

2026年2月26日

[Global Affairs](https://openai.com/news/global-affairs/)

[全球事务](https://openai.com/news/global-affairs/)

# Pacific Northwest National Laboratory and OpenAI partner to accelerate federal permitting

# 太平洋西北国家实验室与 OpenAI 合作，加速联邦许可审批进程

New benchmark shows potential to reduce infrastructure permitting timelines

新基准测试表明，该技术有望缩短基础设施许可审批时间表。

Modernizing how the federal government permits critical infrastructure is essential to building a faster, safer, and more competitive U.S. economy. From energy projects and advanced manufacturing to transportation and water systems, permitting determines how quickly promising ideas become real-world investments. Yet today, environmental and technical reviews often take years, which slows innovation, increases costs, and delays the benefits these projects deliver to communities.

推动联邦政府对关键基础设施的许可审批流程现代化，对于构建更快速、更安全、更具竞争力的美国经济至关重要。从能源项目、先进制造业，到交通运输和水利系统，许可审批进程直接决定了富有前景的构想转化为现实投资的速度。然而，当前的环境影响评估与技术审查往往耗时数年，这不仅拖慢了创新步伐，推高了成本，也延缓了这些项目为社区带来的实际效益。

That’s why OpenAI has partnered with the U.S. Department of Energy’s Pacific Northwest National Laboratory (PNNL) and its [PermitAI™⁠(opens in a new window)](https://www.pnnl.gov/projects/permitai/) team to evaluate whether coding agents can help effectively accelerate federal permitting work. PermitAI, an initiative funded by the Department of Energy’s Office of Policy, and OpenAI worked together with 19 subject matter experts on the National Environmental Policy Act review process to design a benchmark (called DraftNEPABench) for assessing how well AI models perform on tasks relating to NEPA workflows such as drafting environmental impact statements.

正因如此，OpenAI 与美国能源部下属的太平洋西北国家实验室（PNNL）及其 [PermitAI™⁠（在新窗口中打开）](https://www.pnnl.gov/projects/permitai/) 团队展开合作，共同评估编程智能体（coding agents）能否切实助力加速联邦许可审批工作。由美国能源部政策办公室资助的 PermitAI 计划，与 OpenAI 联合 19 位《国家环境政策法》（NEPA）审查流程领域的专家，共同设计了一项基准测试（命名为 DraftNEPABench），用于评估人工智能模型在 NEPA 工作流相关任务（例如编制环境影响报告书）中的实际表现。

Across a representative set of drafting tasks spanning NEPA document sections from 18 federal agencies, 19 experts found that generalized coding agents have the potential to speed up NEPA document drafting work by as much as 1 to 5 hours per subsection—up to roughly 15% reduction in drafting time—signaling a meaningful step forward in how AI can support complex government workflows.

在涵盖来自 18 个联邦机构的 NEPA 文件各章节的一组具有代表性的起草任务中，19 位专家发现：通用型编程智能体有望将每小节的 NEPA 文件起草工作提速 1 至 5 小时——即整体起草时间最多可缩短约 15%。这一结果标志着人工智能支持复杂政府工作流程迈出了意义重大的一步。

## Designing a benchmark for real-world permitting work

## 面向真实世界许可审批工作的基准测试设计

Federal permitting is a complex and document-heavy process in government. Reviews often require reading hundreds of pages of technical reports, cross-checking information across multiple sources, and drafting detailed analyses that must meet regulatory requirements.

联邦许可审批是政府工作中一项高度复杂、文档密集型的流程。审查工作通常需通读数百页的技术报告，在多个信息源之间交叉核验数据，并撰写须严格符合监管要求的详尽分析文件。

Through this collaboration, [OpenAI and PNNL explored the power⁠(opens in a new window)](https://www.pnnl.gov/sites/default/files/media/file/PREPRINT_PNNL_PolicyAI_DraftNEPABench_OpenAI.pdf) of generalizing coding agents (in this case, Codex CLI) as an effective way to extract performance from reasoning models like GPT‑5 for research, technical analysis, and report writing tasks that involve a file system.  

通过此次合作，[OpenAI 与美国太平洋西北国家实验室（PNNL）共同探索了通用型编程智能体（本例中为 Codex CLI）的潜力⁠(在新窗口中打开)](https://www.pnnl.gov/sites/default/files/media/file/PREPRINT_PNNL_PolicyAI_DraftNEPABench_OpenAI.pdf)，将其作为一种高效手段，从 GPT‑5 等推理模型中充分释放性能，以支持涉及文件系统的科研、技术分析及报告撰写任务。  

By giving models access to a command-line interface (typically used for coding tasks), they can use more general strategies for solving a task than hand-crafted heuristics. These agents are required to:

通过赋予模型对命令行接口（CLI，通常用于编程任务）的访问能力，它们得以采用比人工设计启发式规则更通用的问题求解策略。此类智能体需具备以下能力：

- Read and accurately synthesize documents spanning hundreds of pages of technical and regulatory content  
- 准确阅读并综合梳理涵盖数百页技术性与法规性内容的文档  

- Verify facts across multiple environmental, engineering, and regulatory sources  
- 跨多个环境、工程及监管来源交叉验证事实  

- Draft structured reports that meet highly specified legal and technical criteria  
- 撰写符合高度明确的法律与技术标准的结构化报告  

## Why this work matters  

## 此项工作为何重要  

For the United States to continue to grow its economy in this [Intelligence Age⁠(opens in a new window)](https://ia.samaltman.com/), it must be able to build safely, responsibly, and quickly. As AI systems increasingly impact the physical world, we must understand their capabilities in domains like civil engineering, environmental, and regulatory analysis. Over time, advanced models will need to understand laws and regulations accurately as they help to invent new and safer technologies, protect natural resources, and meet human needs.

为使美国在此[智能时代⁠(在新窗口中打开)](https://ia.samaltman.com/)持续推动经济增长，必须能够安全、负责任且高效地开展建设。随着人工智能系统日益影响物理世界，我们必须深入理解其在土木工程、环境评估及监管分析等关键领域的实际能力。长远来看，先进模型需精准理解法律法规，从而助力研发更安全的新技术、保护自然资源，并切实满足人类需求。

For more than 50 years, the process has required federal agencies to review and document the environmental impacts of projects such as bridges, power plants, transmission lines, and manufacturing facilities. This benchmark helps identify where today’s AI models can responsibly assist humans in accelerating these workflows.

五十多年来，联邦机构一直被要求审查并记录桥梁、发电厂、输电线路及制造设施等各类项目所造成的环境影响。该基准测试旨在识别当前人工智能模型可在哪些环节以负责任的方式协助人类，加速上述工作流程。

Codex CLI scores across tasks  

Codex CLI 在各项任务中的得分  

012345ScoreU.S. Bureau of LandManagementU.S. EnvironmentalProtection AgencyU.S. Army Corps ofEngineersBureau of Ocean EnergyManagementNational Oceanic andAtmosphericAdministrationFederal Energy RegulatoryCommissionU.S. Fish and WildlifeServiceU.S. Nuclear RegulatoryCommissionHawaii Department of Landand Natural ResourcesNational Nuclear SecurityAdministrationU.S. Bureau ofReclamationU.S. Department ofTransportationU.S. Department of theNavyFederal AviationAdministrationU.S. Department of EnergyTennessee ValleyAuthorityAgency3.703.653.613.513.433.343.293.233.203.193.153.123.023.023.002.96  

_Mean evaluation scores (1–5 scale) across 102 tasks, grouped by lead agency. Scores aggregate assessments of structure, clarity, accuracy, and references. A score of 1 indicates major deficiencies, 3 indicates a partially correct draft, and a score of 5 indicates a fully correct and complete draft._  

_在 102 项任务中按牵头机构分组计算的平均评估得分（1–5 分制）。得分综合考量报告的结构、清晰度、准确性及参考文献质量。1 分表示存在严重缺陷；3 分表示初稿部分正确；5 分表示终稿完全正确且内容完备。_

In addition to de-risking autonomy, this work can advance the design of better interfaces for experts and AI. Moving beyond static PDFs, coding agents can dynamically generate web-based reports and interactive visualizations from their work that make it easier for human reviewers to validate.

除降低自主决策风险外，此项工作亦可推动面向专家与人工智能的更优人机交互界面设计。突破静态 PDF 文档的局限，编程智能体可基于其工作成果动态生成网页版报告与交互式可视化图表，从而显著提升人工审核人员的验证效率。

With AI, agencies will be able to review, refine, and approve proposals more efficiently, and government workers will gain leverage from teams of AI agents that handle time-consuming portions of their work so they can focus on judgment, oversight, and complex decision-making. This work aligns with OpenAI’s broader commitment to public service and OpenAI for Government’s goal to equip public servants with tools that make them more effective and supported.

借助人工智能，各机构将能更高效地完成提案的审阅、修订与批准；政府工作人员则可通过由多个 AI 智能体组成的协作团队，将耗时繁重的工作交由其处理，从而专注于价值判断、监督管理及复杂决策等核心职责。此项工作契合 OpenAI 致力于公共服务的总体承诺，也呼应了“OpenAI for Government”计划的核心目标——为公职人员配备高效、可靠的技术工具，使其履职更富成效、更具支撑。

## Limitations

## 局限性

This benchmark evaluates model capability on well-specified drafting tasks where the relevant context is available, not the full ambiguity and discretion of real-world permitting decisions. It emphasizes accuracy and correct reference use to clarify where models could assist human reviewers. When reviewing failure cases, we found some “errors” were actually driven by outdated references and weak evaluation criteria and we had to update the rubrics accordingly. More generally, if source materials are incomplete, inconsistent, or out of date, models may not flag these discrepancies without explicit instructions. Real-world deployments are more likely to involve expert feedback and iteration, which is expected to improve performance beyond what is reported in these self-contained benchmark tasks.

该基准测试评估模型在上下文明确、任务定义清晰的起草类任务中的能力，而非真实世界许可审批决策中所固有的全部模糊性与自由裁量空间。测试重点在于准确性及对参考依据的正确使用，旨在厘清模型可在哪些环节辅助人工审查员。在分析失败案例时，我们发现部分所谓“错误”实则源于过时的参考依据或薄弱的评估标准，因此不得不相应更新评分细则。更普遍而言，若原始资料本身不完整、相互矛盾或已过时，模型在缺乏明确指令的情况下通常无法主动识别并提示此类差异。而在实际部署场景中，专家反馈与持续迭代更为常见，预计这将显著提升模型表现，远超本基准测试中这些独立封闭任务所报告的性能水平。

## What’s next

## 后续计划

OpenAI is supporting PNNL to further develop and refine solutions for [PermitAI⁠(opens in a new window)](https://www.pnnl.gov/projects/permitai)’s applications, designed to help federal agencies streamline permitting processes. Over time, we expect to see the average time to approval for federally reviewed infrastructure projects fall from months to weeks, accelerating project development and strengthening U.S. competitiveness and supporting long-term economic growth.

OpenAI 正在支持美国太平洋西北国家实验室（PNNL）进一步开发与优化面向 [PermitAI⁠（在新窗口中打开）](https://www.pnnl.gov/projects/permitai) 应用场景的解决方案，旨在协助联邦机构简化许可审批流程。长远来看，我们预期由联邦机构审核的基础设施项目平均审批周期将从数月缩短至数周，从而加快项目落地进程，增强美国全球竞争力，并支撑长期经济增长。
{% endraw %}
