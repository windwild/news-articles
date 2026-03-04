---
title: "How Clay uses LangSmith to debug, evaluate, and monitor 300 million agents runs per month"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-clay/"
date: "2026-03-01"
scraped_at: "2026-03-02T10:08:01.213778489+00:00"
language: "en-zh"
translated: true
description: "Clay is the creative tool for growth — a platform where go-to-market teams build, enrich, and activate lists of companies and people. Sales teams use Clay to source target accounts, qualify leads wi..."
---
{% raw %}

[Clay](https://clay.com/?ref=blog.langchain.com) 是面向增长的创意工具——一个供市场拓展（Go-to-Market）团队构建、丰富并激活公司与联系人名单的平台。销售团队使用 Clay 来挖掘目标客户账户、借助 AI 驱动的研究对潜在客户进行资质评估、撰写个性化外联内容，并将商机路由至其 CRM 系统。Clay 的客户涵盖快速成长的初创公司到大型企业团队，所有客户均依赖该平台规模化地支撑其主动外拓（outbound）业务。

Today, Clay runs approximately **300 million AI agent runs per month**— each one a multi-step reasoning process that might scrape web pages, synthesize research, qualify an account against an ICP, or draft personalized messaging. To maintain quality, control costs, and keep up with the breakneck pace of model releases, Clay relies on LangSmith as its observability and evaluation backbone.

如今，Clay 每月运行约 **3 亿次 AI 智能体（agent）任务**——每一次任务均为多步骤推理流程，可能涉及网页抓取、研究信息整合、依据理想客户画像（ICP）评估客户资质，或生成个性化消息文案。为保障输出质量、控制成本，并跟上大模型快速迭代发布的节奏，Clay 将 LangSmith 作为其可观测性（observability）与评估能力的核心基础设施。

(To listen to the full conversation, check out the video below.)

（如需收听完整对话，请观看下方视频。）

## From chat completions to 300 million agent runs

## 从聊天补全到每月 3 亿次智能体任务

Clay's AI journey started simply: teams used chat completions to summarize long documents and write outbound copy. But Clay's engineers quickly noticed something more interesting happening. Users were pulling down web pages, scraping content, and asking AI to extract insights from those pages autonomously. That user behavior became the blueprint for Claytent — Clay's AI web research agent — which launched in mid-2023, just weeks into the GPT-4 era.

Clay 的 AI 探索始于简单场景：团队利用聊天补全（chat completions）功能来摘要长文档、撰写外联文案。但 Clay 的工程师很快注意到更有趣的现象：用户开始自主下载网页、抓取内容，并要求 AI 从中提取关键洞察。这种用户行为直接催生了 Claytent——Clay 自研的 AI 网页研究智能体——它于 2023 年年中正式发布，恰逢 GPT-4 时代开启数周之后。

Today, AI is woven into every stage of the customer acquisition lifecycle. Clay has built agents across all three phases of its core value proposition:

如今，AI 已深度融入客户获取全生命周期的每个环节。Clay 围绕其核心价值主张，在全部三个阶段构建了专属智能体：

- Find: Agentic search that sources target accounts from Clay's company and people database or the open web, using reasoning to evaluate ICP fit  
- Find（发现）：具备自主决策能力的搜索智能体，可从 Clay 自有的公司与联系人数据库或开放网络中挖掘目标客户，并通过推理评估其与理想客户画像（ICP）的匹配度  

- Close: Research agents that enrich accounts with relevant context, qualify them with structured reasoning, and draft personalized outreach sequences  
- Close（成交）：研究型智能体，可为账户补充相关背景信息、借助结构化推理完成资质评估，并生成个性化外联序列文案  

- Grow: Agents that help customers expand existing accounts by identifying upsell signals and generating tailored messaging  
- Grow（增长）：增长型智能体，可帮助客户识别现有账户中的增购（upsell）信号，并生成定制化沟通文案  

Each agent run involves between 10 and 30 steps, combining web searches, page crawls, document synthesis, and structured data extraction. With natural language inputs — users type into a blank text box and can ask for almost anything — the range of tasks is effectively unbounded. At **300 million runs per month**, even small quality or cost inefficiencies compound quickly.

每次智能体任务均包含 10 至 30 个步骤，融合网络搜索、网页爬取、文档整合与结构化数据抽取等多种操作。凭借自然语言输入——用户只需在空白文本框中自由输入，几乎可提出任意需求——任务范围实质上是无限的。在 **每月 3 亿次任务** 的规模下，哪怕微小的质量瑕疵或成本低效也会迅速放大、累积。

## The challenge: quality, cost, and model proliferation at scale

## 挑战：规模化下的质量、成本与模型泛滥问题

As Clay's agent usage scaled, three distinct problems emerged that required purpose-built tooling to solve.

随着 Clay 智能体使用规模持续扩大，三个截然不同却相互关联的问题逐渐浮现，亟需专门构建的工具链予以解决。

### Quality is hard to predict from offline benchmarks

### 离线基准测试难以准确预测实际质量

The diversity of Clay's use cases makes production quality fundamentally unpredictable. A customer might use the same agent to qualify biotech companies in Germany one day and research venture-backed consumer startups in Southeast Asia the next. Because inputs are free-form natural language, the surface area for unexpected agent behavior is enormous. Catching quality regressions requires observing real traffic, not synthetic test sets.

Clay 用例的多样性，使得其在生产环境中的实际质量从根本上难以预测。一位客户可能今天用同一个智能体筛选德国的生物技术公司，明天又用它调研东南亚获得风投支持的消费类初创企业。由于输入均为自由形式的自然语言，智能体出现意外行为的可能性空间极为庞大。要发现质量退化问题，必须观察真实流量，而非依赖合成测试集。

### Cost reconciliation is a moving target

### 成本核算始终处于动态变化之中

At Clay's scale, inference costs are a material business expense. Clay offers users the ability to select their preferred model provider — Anthropic, OpenAI, and others — and runs a meta-prompter that automatically maps prompts to the model best suited for each task type. With multiple providers, dynamic model routing, and hundreds of millions of monthly runs, understanding exactly where money is being spent and whether internal pricing for users is accurate was nearly impossible without a unified observability layer.

在 Clay 的业务规模下，推理成本是一项重大的运营支出。Clay 允许用户自主选择偏好的模型提供商（如 Anthropic、OpenAI 等），并运行一个元提示器（meta-prompter），自动将各类提示词映射至最适合对应任务类型的模型。面对多家供应商、动态模型路由以及每月数亿次的调用量，若缺乏统一的可观测性层，几乎不可能精准掌握资金具体流向，也难以验证面向用户的内部计价是否准确。

### New models arrive faster than internal tooling can keep up

### 新模型的发布速度远超内部工具的适配能力

The pace of model releases — "a new model every week," as Jeff Barg (Head of AI at Clay) put it, means Clay constantly needs to evaluate whether a new model deserves a place in the routing map. Without structured evaluation infrastructure, each model assessment was manual, slow, and hard to reproduce.

模型发布的节奏——正如 Clay 首席 AI 官 Jeff Barg 所言：“每周推出一款新模型”——意味着 Clay 必须持续评估每款新模型是否值得纳入其路由映射体系。若缺乏结构化的评估基础设施，每次模型评估都只能依靠人工完成，过程缓慢且难以复现。

## LangSmith as the observability layer: from day zero to production

## LangSmith 作为可观测性层：从开发第一天到正式上线

Clay integrated LangSmith early in their agent development process — tracing is turned on at day zero for every new agent. The integration itself took a single line of code, built on top of OpenAI's SDK. Despite Clay running a custom agent harness, the integration was seamless.

Clay 在智能体开发流程早期即集成了 LangSmith——每个新智能体自创建第一天起即默认启用追踪功能。该集成仅需一行代码，构建于 OpenAI SDK 之上。尽管 Clay 运行的是自定义的智能体运行时框架（agent harness），集成过程依然无缝顺畅。

### Zero-to-one: building agents with full trace visibility

### 从零到一：构建具备完整追踪可见性的智能体

When building new agents, the LangSmith trace view is part of the iteration loop from the very first run. Engineers stream traces in real time and step through the full execution tree — seeing exactly what the agent saw, what tools it called, what the model returned, and where things went wrong. This matters because what the end user sees is only the final output, not the full agent trace.

在构建新智能体时，LangSmith 的追踪视图自首次运行起便成为迭代闭环中不可或缺的一环。工程师可实时流式查看追踪数据，并逐层展开完整的执行树——清晰看到智能体接收了哪些输入、调用了哪些工具、模型返回了什么结果，以及问题究竟出在哪个环节。这一点至关重要，因为终端用户仅能看到最终输出，而无法获知智能体完整的执行轨迹。

LangSmith's ability to represent nested subagent calls and tool invocations in a structured, readable way was a key factor in Clay's decision to use it.  
LangSmith 能以结构化、易读的方式呈现嵌套的子智能体调用和工具调用，这是 Clay 决定采用它的关键因素。

The UI is fast enough that 25–50 engineers across Clay's AI organization — including some customer support team members who use it to debug customer-reported issues — can navigate traces efficiently without training.  
其用户界面响应足够迅速，使得 Clay 公司 AI 部门的 25–50 名工程师（包括部分使用该平台调试客户上报问题的客服团队成员）无需专门培训即可高效浏览追踪记录（traces）。

As Jeff puts it: "LangSmith feels like a platform built by people who have actually built an agent framework. That really shines through in how it handles nested subagents and tool call paths."  
正如 Jeff 所言：“LangSmith 给人的感觉，就像一个由真正构建过智能体框架的人所打造的平台。这一点在它处理嵌套子智能体和工具调用路径的方式上体现得尤为明显。”

### Production monitoring: understanding patterns across millions of runs  

### 生产环境监控：洞察数百万次运行中的模式  

In production, LangSmith provides Clay with aggregate visibility across usage patterns, cost profiles, error rates, latency distributions, and output quality — all sliced by customer workspace and model provider.  
在生产环境中，LangSmith 为 Clay 提供了覆盖使用模式、成本分布、错误率、延迟分布及输出质量等维度的聚合视图——所有指标均可按客户工作区（workspace）和模型提供商进行切片分析。

When a customer reports a problem, engineers can immediately pull up the relevant traces and identify whether the failure was a tool call error, an inference issue, or a prompt quality problem.  
当客户报告问题时，工程师可立即调取相关追踪记录，并快速判断故障根源：是工具调用错误、推理环节异常，还是提示词（prompt）质量不佳。

The ability to export to Snowflake, which allows their data team to run custom analyses on trace data over time has also been helpful.  
支持导出至 Snowflake 的能力也极具价值——这使得其数据团队能够随时间推移，对追踪数据执行自定义分析。

This allows the data team to track cost trends, identify anomalous workspaces, and model the economics of new model introductions before committing to updated pricing.  
由此，数据团队得以追踪成本变化趋势、识别异常工作区，并在最终确定新版定价策略前，对新模型上线带来的经济影响建模分析。

### Evaluation: benchmarks that reflect real traffic  

### 评估：反映真实流量的基准测试  

Clay uses LangSmith for offline evaluations when assessing model changes or prompt updates. Their evaluation framework combines two approaches:  
Clay 在评估模型变更或提示词更新时，使用 LangSmith 进行离线评估。其评估框架融合了两种方法：

- Deterministic match evals for structured outputs, where the agent's answer is compared against known ground truth  
- 针对结构化输出的确定性匹配评估（deterministic match evals）：将智能体的回答与已知的标准答案（ground truth）进行比对；

- LLM-as-a-judge evals for research and synthesis tasks, where the agent produces a paragraph of analysis that must be scored for accuracy and relevance  
- 面向研究与综合类任务的“大语言模型作为裁判”评估（LLM-as-a-judge evals）：智能体生成一段分析性文字，由大语言模型对其准确性与相关性打分。

When a new model is released, Clay uses these evaluations to update the meta-prompter's routing map — identifying which use cases the model excels at and pricing it accordingly.  
每当新模型发布，Clay 即利用上述评估结果更新元提示器（meta-prompter）的路由映射表——明确该模型在哪些应用场景中表现优异，并据此制定相应定价。

LangSmith's dataset management makes it possible to run these benchmarks quickly and track performance deltas across model versions.  
LangSmith 的数据集管理功能，使此类基准测试得以快速执行，并能跨模型版本持续追踪性能差异（performance deltas）。

## Achieving near-perfect cost reconciliation at massive scale  

## 实现超大规模下的近乎完美成本对账

When asked to quantify LangSmith's impact, Jeff mentioned that:

当被问及如何量化 LangSmith 所带来的影响时，Jeff 提到：

> "Before LangSmith, we really didn't have a good sense of where we were spending money across different inference providers. With LangSmith, we now have around a **99–99.5% reconciliation rate** between our LangSmith data and the actual bills we receive. Our finance team loves us for that." — Jeff Barg, Head of AI, Clay

> “在引入 LangSmith 之前，我们实际上并不清楚自己在不同推理服务提供商上的资金支出分布情况。借助 LangSmith，我们现在实现了 LangSmith 数据与实际账单之间约 **99–99.5% 的对账准确率**。财务团队因此对我们赞不绝口。”—— Jeff Barg，Clay 公司 AI 负责人

At 300 million agent runs per month across multiple model providers, that reconciliation figure represents a huge reduction in financial uncertainty. Clay now prices agent runs to end users with confidence, adjusting pricing quickly — often on the day of a model launch — instead of waiting weeks for invoice data to arrive. This also means Clay can pass model cost reductions directly to customers faster, a meaningful competitive advantage in a market where AI inference costs are declining rapidly.

每月在多家模型服务商上执行高达 3 亿次智能体（agent）运行，这一对账准确率大幅降低了财务不确定性。如今，Clay 可以自信地面向终端用户为智能体运行定价，并能快速调整价格——常常在新模型发布的当天即完成调价，而无需再等待数周以获取账单数据。这也意味着 Clay 能更快地将模型成本下降直接惠及客户，从而在 AI 推理成本正迅速走低的市场中，赢得一项切实的竞争优势。

Beyond cost reconciliation, LangSmith has helped compress the debugging loop for Clay's engineering teams by making tracing available from day one of agent development. Customer support team members can also resolve agent quality complaints directly in LangSmith without escalating to engineering — reducing both resolution time and engineering interruption costs.

除成本对账外，LangSmith 还通过在智能体开发的第一天即提供追踪（tracing）能力，显著缩短了 Clay 工程团队的调试周期。客服人员亦可直接在 LangSmith 中处理有关智能体质量的用户投诉，无需升级至工程团队介入——既缩短了问题解决时间，也降低了对工程团队正常工作的干扰成本。

Clay also credits LangSmith's platform reliability — specifically the speed and consistency of trace ingest at scale — as a meaningful factor in sustaining developer productivity. At hundreds of millions of monthly runs, any observability tool that couldn't keep up with ingest volume would create blind spots precisely when visibility matters most.

Clay 同样将 LangSmith 平台的可靠性——尤其是其在超大规模下稳定、高速的追踪数据接入（trace ingest）能力——视为持续保障开发者生产力的关键因素。在每月数亿次运行量级下，任何无法跟上数据接入吞吐量的可观测性工具，都将在最需要可见性的关键时刻造成监控盲区。

## Looking ahead: Agents with longer time horizons

## 展望未来：具备更长时效跨度的智能体

As Clay's agents become more complex — running longer, spanning more steps, and coordinating more subagents — they're relying increasingly on LangSmith's threads feature to track multi-turn interactions across extended time horizons. They're also experimenting with background coding agents as part of their software development lifecycle, inspired by similar work at companies like Ramp.

随着 Clay 智能体日趋复杂——运行时长增加、步骤增多、协调的子智能体数量上升——它们越来越多地依赖 LangSmith 的“线程（threads）”功能，以跨更长时效跨度追踪多轮交互。此外，受 Ramp 等公司类似实践的启发，Clay 也在软件开发生命周期中尝试引入后台编码智能体（background coding agents）。

## Conclusion

## 结论

Clay has built one of the most operationally sophisticated AI agent systems in the B2B SaaS world, running 300 million agent runs a month across a model-agnostic, multi-provider stack. LangSmith provides the observability foundation that makes that scale manageable: day-zero tracing for new agent development, production monitoring across usage and cost patterns, structured evaluation infrastructure for model assessments, and near-perfect cost reconciliation that directly informs pricing decisions.

Clay 已构建出 B2B SaaS 领域中运营最为成熟的 AI 智能体系统之一：该系统基于与模型无关、支持多服务商的底层架构，每月执行高达 3 亿次智能体运行。LangSmith 为其提供了坚实的可观测性基础，使如此庞大的规模仍可控可管——包括面向新智能体开发的“首日即追踪（day-zero tracing）”能力、覆盖使用量与成本模式的生产环境监控、结构化的模型评估基础设施，以及近乎完美的成本对账能力——后者可直接支撑定价决策。
{% endraw %}
