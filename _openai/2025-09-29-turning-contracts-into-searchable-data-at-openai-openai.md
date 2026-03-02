---
title: "Turning contracts into searchable data at OpenAI | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/openai-contract-data-agent"
date: "2025-09-29"
scraped_at: "2026-03-02T10:47:24.532838861+00:00"
language: "en-US"
translated: true
description: "OpenAI built a system to extract contract data quickly, cutting turnaround times and making it easier for teams to access the details they need."
tags: ["API"]
---

September 29, 2025

2025 年 9 月 29 日

[API](https://openai.com/stories/api/) OpenAI on OpenAI

[API](https://openai.com/stories/api/) OpenAI 的 OpenAI 实践

# Turning contracts into searchable data at OpenAI

# 在 OpenAI 将合同转化为可搜索的数据

00:00

00:00

_This is part of our series sharing internal examples of how OpenAI is using its own technology and APIs. These tools are being used internally, only at OpenAI, and are shared here as illustrative examples of how frontier AI is supporting use cases across our teams. We’re also sharing the internal tool names for a clearer look at how frontier AI helps our teams get work done._

_这是我们的系列文章之一，分享 OpenAI 内部如何使用自身技术与 API 的实际案例。这些工具目前仅在 OpenAI 内部使用，本文分享它们旨在说明前沿 AI 如何支持公司各团队的实际业务场景。我们同时公开了内部工具的名称，以便更清晰地展现前沿 AI 是如何助力团队高效完成工作的。_

## When contracts became the bottleneck

## 当合同成为瓶颈

Every enterprise deal comes with a signed contract. Each one has start dates, billing terms, renewal clauses.

每一份企业级交易都附有一份已签署的合同。每份合同均包含起始日期、计费条款、续订条款等关键信息。

At first, the process was manageable: read line by line, retype into a spreadsheet, move on. But when volume doubled and doubled again, this manual approach broke.

起初，该流程尚可应对：逐行阅读、手动录入电子表格、继续推进。但当合同数量翻倍、再翻倍后，这种纯人工方式便难以为继。

“In less than six months, the team went from reviewing hundreds of contracts each month to more than a thousand. And yet we’d only hired one new person. It was obvious that the process wasn’t going to scale,” says Wei An Lee, AI Engineer.

“不到六个月时间，团队每月审阅的合同数量就从数百份激增至一千多份；而同期我们仅新增了一名员工。显然，这一流程已无法随业务规模同步扩展。”OpenAI AI 工程师李伟安（Wei An Lee）表示。

## Building a smarter workflow

## 构建更智能的工作流

Instead of throwing more people at the problem, our finance and engineering teams built a contract data agent. The design principle was simple: take the repetition out of contract review, keep experts firmly in control.

面对问题，我们并未简单增加人力投入；而是由财务与工程团队共同构建了一个合同数据智能体（contract data agent）。其设计原则十分简洁：消除合同审阅中的重复性劳动，同时确保领域专家始终牢牢掌握决策主导权。

The Agent works in three steps:

该智能体通过三个步骤完成工作：

- **Ingest data:** PDFs, scanned copies, even phone photos marked up with handwritten edits. What used to be dozens of inconsistent files now flow into one pipeline.

- **数据接入（Ingest data）：** 支持 PDF 文件、扫描件，甚至带有手写批注的手机拍摄照片。过去散乱不一、多达数十份的文件，如今统一汇入单一处理管道。

- **Inference with prompting:** Using retrieval-augmented prompting, the system parses contracts into structured data. It doesn’t dump a thousand pages into context; it pulls only what’s relevant, reasons against it, and shows its work.

- **提示驱动推理（Inference with prompting）：** 借助检索增强型提示（retrieval-augmented prompting），系统将合同解析为结构化数据。它不会将上千页内容一股脑塞入上下文，而是仅提取相关片段，基于此进行逻辑推理，并清晰展示推理过程。

- **Review:** Finance experts review the structured output, complete with annotations and references for any non-standard terms. The agent highlights what’s unusual; humans are then looped in to review.

- **人工复核（Review）：** 财务专家对结构化输出结果进行复核，所有非常规条款均配有标注与参考依据。智能体自动标出异常项，再由人类专家介入审核。

> “We’re not just parsing, we’re reasoning—showing why a term is considered non-standard, citing the reference material, and letting the reviewer confirm the ASC 606 classification.”

> “我们所做的不只是解析，更是推理——明确说明某一条款为何被判定为非常规条款，援引相应参考材料，并由审核人员最终确认其 ASC 606 分类。”

Siddharth Jain, AI Engineer

Siddharth Jain，AI 工程师

## Confident contract reviews

## 自信从容的合同审阅

The output is a dataset that’s immediately useful across finance workflows. What once took hours arrives overnight, annotated and ready for validation. Experts remain in the loop, but their role shifts from manual entry to judgment.

输出结果是一份可直接用于各类财务工作流的数据集。过去耗时数小时的手工处理，如今一夜之间即可交付——数据已带标注，随时可供验证。专家始终处于闭环之中，但其角色已从繁琐的手动录入，转变为关键的专业判断。

> “The amazing thing is that the heavy lifting happens with AI—and then our teams wake up in the morning to data that’s ready for them to review.”

> “最令人惊叹之处在于：繁重的底层工作由 AI 完成；而我们的团队每天清晨醒来，面对的已是准备就绪、可立即开展审核的数据。”

Wei An Lee, AI Engineer

Wei An Lee，AI 工程师

This design ensures confidence: professionals get structured, reasoned data at scale, but their expertise drives the outcome.

这一设计确保了可信度：专业人士能够以规模化方式获取结构清晰、逻辑严谨的数据，但最终结果仍由其专业判断主导。

The results:

成果如下：

- **Faster turnaround**. Reviews cut in half, ready overnight.  
- **更快的交付周期**：审阅时间缩短一半，可实现隔夜交付。

- **Higher capacity**. Thousands of contracts processed without expanding headcount in lockstep.  
- **更高的处理容量**：无需同比例扩充人员，即可处理数千份合同。

- **Smarter context**. Non-standard terms flagged with reasoning and references.  
- **更智能的上下文理解**：非标准条款被自动标记，并附带推理依据与参考来源。

- **Queryable results**. Tabular output in the data warehouse allows for easier data analysis.  
- **可查询的结果**：数据仓库中以表格形式输出，便于开展数据分析。

Each cycle of human feedback sharpens the Agent, making every review faster and more accurate.

每一轮人工反馈都会进一步优化智能体（Agent），使每次审阅都更加快速、更加精准。

“The only way we can scale as OpenAI scales is through this,” Wei An said. “Without it, you’d have to grow your team linearly in lockstep with contract volume. This lets us keep the team lean while handling hypergrowth.”

“唯有通过这种方式，我们才能与 OpenAI 同步实现规模化扩展。”魏安表示，“若缺乏这一能力，团队规模就必须与合同数量呈线性同步增长；而借助该方案，我们得以保持精干团队，从容应对爆发式增长。”

## Beyond contracts

## 不止于合同

This architecture now supports procurement, compliance, even month-end close. The same principle applies: automate the rote work, keep humans in charge of judgment.

当前这一架构已延伸至采购、合规乃至月度结账等场景。其核心原则始终如一：将重复性工作自动化，而将判断权保留在人类手中。

Engineers describe it as “manual work already done,” not decisions replaced. Finance teams still write the story of the numbers; the Agent ensures they don’t spend their day doing painstaking work.

工程师将其描述为“手工工作已被预先完成”，而非“决策被取代”。财务团队依然负责诠释数字背后的故事；智能体则确保他们无须耗费整日于繁琐劳作之中。

## A new operating model for finance

## 财务领域的新运营模式

What started as a fix for contracts has become a new way of working in finance. Data parsing runs overnight. Professionals focus on analysis and strategy. Leaders scale confidently with growth, without growing teams in lockstep.

最初仅针对合同审阅的解决方案，如今已演变为财务领域的一种全新工作方式：数据解析任务在夜间自动运行；专业人士得以专注于分析与战略制定；管理者则可信心十足地随业务增长而扩展，无需同步扩大团队规模。

The contract data Agent is a blueprint for how AI can responsibly transform regulated, high-stakes work. It shows what becomes possible when experts partner with intelligent systems: more leverage, more confidence, and more time spent on what matters most.

合同数据智能体（Contract Data Agent）是人工智能如何负责任地变革受监管、高风险工作的蓝图。它展现了当领域专家与智能系统协同合作时所能实现的突破：更高的工作杠杆效应、更强的决策信心，以及更多时间专注于真正重要的事务。

## Ready to put ChatGPT to work in your business?

## 准备在您的企业中启用 ChatGPT 了吗？

[Talk with our team](https://openai.com/contact-sales/)

[与我们的团队交流](https://openai.com/contact-sales/)