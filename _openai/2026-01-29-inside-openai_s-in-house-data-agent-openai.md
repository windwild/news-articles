---
render_with_liquid: false
title: "Inside OpenAI’s in-house data agent | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/inside-our-in-house-data-agent"
date: "2026-01-29"
scraped_at: "2026-03-02T10:08:23.745045730+00:00"
language: "en-US"
translated: true
description: "How OpenAI built an in-house AI data agent that uses GPT-5, Codex, and memory to reason over massive datasets and deliver reliable insights in minutes."
tags: ["Engineering"]
---
render_with_liquid: false
render_with_liquid: false

January 29, 2026

2026年1月29日


# Inside OpenAI’s in-house data agent

# 深入了解 OpenAI 自研的内部数据智能体


By Bonnie Xu, Aravind Suresh, and Emma Tang

作者：Bonnie Xu、Aravind Suresh 和 Emma Tang


Data powers how systems learn, products evolve, and how companies make choices. But getting answers quickly, correctly, and with the right context is often harder than it should be. To make this easier as OpenAI scales, we built **our own bespoke in-house AI data agent** that explores and reasons over our own platform **.**

数据驱动着系统的学习方式、产品的演进路径，以及企业的决策过程。然而，要快速、准确且在恰当上下文中获取答案，往往比预想中更困难。随着 OpenAI 规模持续扩大，为简化这一过程，我们构建了**专属于自身的、定制化的内部 AI 数据智能体**，使其能够探索并推理我们自有平台中的数据。

Our agent is a custom internal-only tool (not an external offering), built specifically around OpenAI’s data, permissions, and workflows. We’re showing how we built and use it to help surface examples of the real, impactful ways AI can support day-to-day work across our teams. The OpenAI tools we used to build and run it ( [Codex](https://openai.com/index/introducing-codex/), [our GPT‑5 flagship model](https://openai.com/index/introducing-gpt-5-2/), the [Evals API⁠(opens in a new window)](https://platform.openai.com/docs/guides/evals), and the [Embeddings API⁠(opens in a new window)](https://platform.openai.com/docs/guides/embeddings)) are the same tools we make available to developers everywhere.

该智能体是一款仅限内部使用的定制化工具（并非对外产品），专为 OpenAI 的数据结构、权限体系与工作流而设计。本文将展示我们如何构建并使用它，以呈现 AI 在团队日常工作中切实产生影响的真实范例。我们用于构建和运行该智能体的 OpenAI 工具——包括 [Codex](https://openai.com/index/introducing-codex/)、我们的旗舰模型 [GPT‑5](https://openai.com/index/introducing-gpt-5-2/)、[Evals API⁠（在新窗口中打开）](https://platform.openai.com/docs/guides/evals) 和 [Embeddings API⁠（在新窗口中打开）](https://platform.openai.com/docs/guides/embeddings)——也正是我们向全球开发者开放的同一系列工具。

Our data agentlets employees go from question to insight in minutes, not days. This lowers the bar to pulling data and nuanced analysis across all functions, not just by our data team. Today, teams across Engineering, Data Science, Go-To-Market, Finance, and Research at OpenAI lean on the agent to answer **high-impact data questions.** For example, it can help answer how to evaluate launches and understand business health, all through the intuitive format of natural language. The agent combines Codex-powered table-level knowledge with product and organizational context. Its continuously learning memory system means it also improves with every turn.

借助该数据智能体，员工可在数分钟内（而非数天）从提问直达洞见。这显著降低了跨职能获取数据与开展深度分析的门槛——不再仅限于数据团队。目前，OpenAI 的工程、数据科学、市场拓展（Go-To-Market）、财务及研究等各团队，均依赖该智能体来解答**高影响力的数据问题**。例如，它可通过自然语言这一直观形式，协助评估产品发布效果、理解业务健康状况等。该智能体融合了由 Codex 驱动的表级知识，以及产品与组织层面的上下文信息；其具备持续学习能力的记忆系统，也确保它在每一次交互后不断优化提升。

![Screenshot showing a user asking for ChatGPT WAU on Oct 6, 2025 compared with DevDay 2023. The agent reports ≈800M WAU for 2025 and ≈100M for 2023, with notes showing a +700M change and an ~8× increase, followed by explanatory context.](images/inside-openai_s-in-house-data-agent-openai/img_001.png)

![截图显示用户询问“ChatGPT 在 2025 年 10 月 6 日的周活跃用户数（WAU）相较于 2023 年 DevDay 的变化”。智能体报告 2025 年 WAU 约为 8 亿，2023 年约为 1 亿，并附注说明变化量为 +7 亿，增幅约达 8 倍，随后提供进一步解释性上下文。](images/inside-openai_s-in-house-data-agent-openai/img_001.png)


In this post, we’ll break down why we needed a bespoke AI data agent, what makes its code-enriched data context and self-learning so useful, and lessons we learned along the way.

本文将深入剖析：我们为何需要一款定制化的 AI 数据智能体；其代码增强型数据上下文与自主学习能力为何如此实用；以及我们在构建过程中收获的关键经验。

## Why we needed a custom tool

## 为何我们需要一款定制化工具

OpenAI’s data platform serves more than **3.5k internal users** working across Engineering, Product, and Research, spanning over **600 petabytes** of data across **70k datasets.** At that size, simply finding the right table can be one of the most time-consuming parts of doing analysis.

OpenAI 的数据平台服务于工程、产品和研究部门的 **3500 多名内部用户**，涵盖 **7 万个数据集**，总数据量超过 **600 拍字节（PB）**。在如此庞大的规模下，仅是找到正确的数据表，就可能成为数据分析过程中最耗时的环节之一。

As one internal user put it:

正如一位内部用户所言：

_“We have a lot of tables that are fairly similar, and I spend tons of time trying to figure out how they’re different and which to use. Some include logged-out users, some don’t. Some have overlapping fields; it’s hard to tell what is what.”_

_“我们有很多结构非常相似的数据表，我常常花费大量时间去弄清它们之间的差异，以及究竟该选用哪一张。有些表包含已登出用户的数据，有些则不包含；有些表字段存在重叠，很难分辨各字段的确切含义。”_

Even with the correct tables selected, producing correct results can be challenging. Analysts must reason about table data and table relationships to ensure transformations and filters are applied correctly. Common failure modes—many-to-many joins, filter pushdown errors, and unhandled nulls—can silently invalidate results. At OpenAI’s scale, analysts should not have to sink time into debugging SQL semantics or query performance: their focus should be on defining metrics, validating assumptions, and making data-driven decisions.

即使选对了数据表，产出准确结果仍具挑战性。分析师必须深入理解表内数据及其相互关系，以确保各类转换操作与过滤条件被正确应用。常见的错误模式——如多对多连接（many-to-many joins）、过滤条件下推失败（filter pushdown errors）以及未处理的空值（unhandled nulls）——都可能在无声无息中导致结果失效。在 OpenAI 这样的数据规模下，分析师不应将宝贵时间耗费在调试 SQL 语义或查询性能上；他们的核心精力应聚焦于指标定义、假设验证，以及基于数据的决策制定。

![Screenshot of SQL code defining two CTEs—order_enriched and monthly_segment—that join customer geography data, derive order-month fields, and compute monthly aggregates such as order counts, gross revenue, revenue with tax, and average ship-to-receipt days.](images/inside-openai_s-in-house-data-agent-openai/img_002.png)

![一段 SQL 代码截图，其中定义了两个公共表表达式（CTE）：`order_enriched` 和 `monthly_segment`，用于关联客户地理信息、派生订单月份字段，并计算月度聚合指标，例如订单数、毛收入、含税收入及平均发货至收货天数。](images/inside-openai_s-in-house-data-agent-openai/img_002.png)

This SQL statement is 180+ lines long. It’s not easy to know if we’re joining the right tables and querying the right columns.

这段 SQL 语句长达 **180 多行**。我们很难直观判断是否连接了正确的数据表、是否查询了正确的字段。

## How it works

## 工作原理

Let’s walk through what our agent is, how it curates context, and how it keeps self-improving.

我们将逐步介绍：我们的智能体（agent）是什么、它如何构建上下文，以及它如何持续自我优化。

Our agent is powered by [**GPT‑5.2**](https://openai.com/index/introducing-gpt-5-2/) and is designed to reason over OpenAI’s data platform. It’s available wherever employees already work: as a Slack agent, through a web interface, inside IDEs, in the [Codex CLI via MCP⁠(opens in a new window)](https://developers.openai.com/codex/mcp/), and directly in [OpenAI’s internal ChatGPT app through a MCP connector⁠(opens in a new window)](https://platform.openai.com/docs/guides/tools-connectors-mcp).

我们的智能体由 [**GPT‑5.2**](https://openai.com/index/introducing-gpt-5-2/) 驱动，专为在 OpenAI 数据平台上进行推理而设计。它无缝嵌入员工日常工作的各个场景：作为 Slack 智能体、通过网页界面、集成于各类 IDE 中、通过 [Codex CLI（基于 MCP 协议）⁠(在新窗口中打开)](https://developers.openai.com/codex/mcp/)，以及直接集成于 [OpenAI 内部 ChatGPT 应用（通过 MCP 连接器）⁠(在新窗口中打开)](https://platform.openai.com/docs/guides/tools-connectors-mcp)。

![Diagram titled “How the data agent works.” Entrypoints—Agent-UI, Local Agent-MCP, Remote Agent-MCP, and Slack Agent—feed into an Agent-API. The API connects to internal data knowledge and company context, syncs with a data warehouse and platform sources, and exchanges requests with the GPT-5.2 model via Agent-MCP.](images/inside-openai_s-in-house-data-agent-openai/img_003.svg)

![标题为“数据智能体工作原理”的示意图：入口点——Agent-UI（用户界面）、本地 Agent-MCP、远程 Agent-MCP 和 Slack Agent——均接入 Agent-API；该 API 连接内部数据知识库与公司上下文，同步数据仓库及平台数据源，并通过 Agent-MCP 与 GPT-5.2 模型交互请求。](images/inside-openai_s-in-house-data-agent-openai/img_003.svg)

Users can ask complex, open-ended questions which would typically require multiple rounds of manual exploration. Take this example prompt, which uses a test data set: _“For NYC taxi trips, which pickup-to-dropoff ZIP pairs are the most unreliable, with the largest gap between typical and worst-case travel times, and when does that variability occur?”_

用户可以提出复杂、开放性的问题，这类问题通常需要多轮人工探索才能解答。以下是一个使用测试数据集的示例提示：“对于纽约市出租车行程，哪些上车–下车邮政编码（ZIP）组合最‘不可靠’？即典型行程时间与最差情况行程时间之间的差距最大？这种时间波动性又发生在何时？”

**The agent handles the analysis end-to-end**, from understanding the question to exploring the data, running queries, and synthesizing findings.

**该智能体端到端地完成全部分析工作**，从理解问题，到探索数据、执行查询，再到整合并呈现分析结果。

![Screenshot showing a user asking which NYC taxi pickup→dropoff ZIP pairs are most “unreliable.” The agent explains using ~21k trips from samples.nyctaxi.trips, defines typical (p50) vs worst-case (p95), applies filters, and describes how it identifies when each ZIP pair’s longest trip occurred.](images/inside-openai_s-in-house-data-agent-openai/img_004.png)

![一张截图，显示用户提问：哪些纽约市出租车上车→下车邮政编码（ZIP）组合最“不可靠”。智能体解释其分析基于 `samples.nyctaxi.trips` 中约 21,000 条行程记录；明确定义“典型”为第 50 百分位数（p50）、“最差情况”为第 95 百分位数（p95）；应用筛选条件；并说明如何识别每对 ZIP 组合中耗时最长行程的发生时间。](images/inside-openai_s-in-house-data-agent-openai/img_004.png)

The agent's response to the question.

智能体对该问题的响应。

One of the agent’s superpowers is how it reasons through problems. Rather than following a fixed script, the agent evaluates its own progress. If an intermediate result looks wrong (e.g., if it has zero rows due to an incorrect join or filter), the agent investigates what went wrong, adjusts its approach, and tries again. Throughout this process, it retains full context, and carries learnings forward between steps. This **closed-loop, self-learning process** shifts iteration from the user into the agent itself, enabling faster results and consistently higher-quality analyses than manual workflows.

该智能体的一项核心能力在于其问题推理方式。它并不依赖预设脚本，而是持续评估自身进展：若某中间结果明显异常（例如，因连接或筛选条件错误导致查询返回零行），智能体会主动诊断问题根源、调整策略并重新尝试。在整个过程中，它始终保有完整上下文，并将每一步获得的经验延续至后续步骤。这种**闭环式、自学习的过程**，将迭代责任从用户转移至智能体自身，从而实现比人工流程更快的响应速度和更稳定、更高品质的分析结果。

![Screenshot of a task workflow showing an AI agent’s step-by-step plan for analyzing NYC taxi trip durations. It includes goals, internal searches, schema inspection, code snippets, and reasoning about computing p50/p95 spreads, identifying unreliable ZIP pairs, and planning SQL queries.](images/inside-openai_s-in-house-data-agent-openai/img_005.png)

![一张任务工作流截图，展示 AI 智能体分析纽约市出租车行程时长的分步规划：包括目标设定、内部知识检索、数据表结构检查、代码片段、关于计算 p50/p95 时间差、识别不可靠 ZIP 组合及设计 SQL 查询的推理过程。](images/inside-openai_s-in-house-data-agent-openai/img_005.png)

The agent’s reasoning to identify the most unreliable NYC taxi pickup–dropoff pairs.

智能体识别最不可靠纽约市出租车上车–下车 ZIP 组合的推理过程。

The agent covers the full analytics workflow: discovering data, running SQL, and publishing notebooks and reports. It understands internal company knowledge, can web search for external information, and improves over time through learned usage and memory.

该智能体覆盖完整的分析工作流：涵盖数据发现、SQL 查询执行，以及笔记本（notebook）与报告的生成与发布。它能理解企业内部知识，可联网搜索外部信息，并通过持续的使用经验与记忆不断自我优化。

## Context is everything

## 上下文决定一切

High-quality answers depend on **rich, accurate context**. Without context, even strong models can produce wrong results, such as vastly misestimating user counts or misinterpreting internal terminology.

高质量的回答高度依赖**丰富且准确的上下文**。缺乏上下文时，即使是最强大的模型也可能得出错误结论，例如严重高估或低估用户数量，或误解企业内部术语。

![Screenshot of a user asking, “What was ChatGPT Image Gen logged-in DAU for the last 30 days?” with a status line below showing the agent has been “Working for 22m 41s,” indicating a long-running query in progress.](images/inside-openai_s-in-house-data-agent-openai/img_006.png)

截图：用户提问“过去30天内，ChatGPT图像生成功能的登录日活跃用户数（DAU）是多少？”，下方状态栏显示代理已“运行22分41秒”，表明该查询正在长时间执行中。

The agent without memory, unable to query effectively.

无记忆能力的代理，无法高效执行查询。

![Screenshot showing a user asking, “What was ChatGPT Image Gen logged-in DAU for the last 30 days?” Beneath the message, a status line says “Worked for 1m 22s,” indicating the query is still running and taking a long time to complete.](images/inside-openai_s-in-house-data-agent-openai/img_007.png)

截图：用户提问“过去30天内，ChatGPT图像生成功能的登录日活跃用户数（DAU）是多少？”，消息下方状态栏显示“已运行1分22秒”，表明查询仍在执行中，耗时较长。

The agent’s memory enables faster queries by locating the correct tables.

代理的记忆能力可通过快速定位正确数据表，显著提升查询速度。

To avoid these failure modes, the agent is built around **multiple layers of context that ground it in OpenAI’s data and institutional knowledge.**

为避免上述失效情形，该代理围绕**多层上下文架构构建**，使其深度扎根于OpenAI的数据体系与机构知识。

![Diagram titled “Data agent’s layers of context” showing six stacked tiers: 1) Table Usage, 2) Human Annotations, 3) Codex Enrichment, 4) Institutional Knowledge, 5) Memory, and 6) Runtime Context. Each layer appears as a horizontal bar in a pyramid shape.](images/inside-openai_s-in-house-data-agent-openai/img_008.svg)

图示：“数据代理的上下文层级”示意图，呈金字塔结构，共六层水平堆叠：1）表使用情况（Table Usage）、2）人工标注（Human Annotations）、3）Codex增强（Codex Enrichment）、4）机构知识（Institutional Knowledge）、5）记忆（Memory）、6）运行时上下文（Runtime Context）。

#### Layer \#1: Table Usage

#### 第一层：表使用情况（Table Usage）

- **元数据锚定（Metadata grounding）：** 代理依赖模式元数据（如列名与数据类型）辅助SQL语句编写，并利用表血缘关系（例如上游与下游表之间的依赖关系）来理解不同数据表间的关联逻辑。  
- **查询推断（Query inference）：** 通过摄入历史查询记录，代理可学习如何自主构造查询语句，并识别哪些表通常需要联结（join）使用。

#### Layer \#2: Human Annotations

#### 第二层：人工标注（Human Annotations）

- **由领域专家精心编写的表与字段描述**，涵盖设计意图、语义含义、业务意义，以及那些难以仅从模式定义或历史查询中推断出的已知注意事项（known caveats）。

Metadata alone isn’t enough. To really tell tables apart, you need to understand how they were created and where they originate.

仅靠元数据是不够的。要真正区分不同数据表，您需要理解这些表是如何创建的，以及它们源自何处。

#### Layer \#3: Codex Enrichment

#### 第三层：Codex 增强

- By deriving a code-level definition of a table, the agent builds a deeper understanding of what the data actually contains.  
  - 通过推导出数据表在代码层面的定义，该智能体能够更深入地理解表中实际存储的数据内容。  
  - 表中所存内容的细微差别，以及该表如何从分析事件（analytics event）中派生而来，可提供额外信息。例如，它能说明字段值的唯一性、表数据更新频率、数据覆盖范围（如：若某表排除了某些字段，则其粒度即为此级别）等。  
  - 这些细节有助于增强使用上下文，揭示该表在 SQL 之外（如 Spark、Python 及其他数据系统）中的实际应用方式。  
  - 这意味着该智能体能够区分外观相似但关键属性存在差异的表。例如，它可准确判断某张表是否仅包含第一方 ChatGPT 流量。此类上下文亦会自动刷新，无需人工维护即可保持最新状态。

![Diagram titled “Codex-enriched knowledge pipeline.” Popular tables feed into multiple Codex tasks, which extract details from the OpenAI codebase, including a table’s purpose, grain and primary keys, downstream usage patterns, alternate table options, and data freshness.](images/inside-openai_s-in-house-data-agent-openai/img_009.svg)

![标题为“经 Codex 增强的知识流水线”的示意图：热门数据表输入至多个 Codex 任务中；这些任务从 OpenAI 代码库中提取详细信息，包括表的用途、粒度（grain）与主键、下游使用模式、替代表选项，以及数据新鲜度（data freshness）。](images/inside-openai_s-in-house-data-agent-openai/img_009.svg)

#### Layer \#4: Institutional Knowledge

#### 第四层：机构知识

- The agent can access Slack, Google Docs, and Notion, which capture critical company context such as launches, reliability incidents, internal codenames and tools, and the canonical definitions and computation logic for key metrics.  
  - 该智能体可访问 Slack、Google Docs 和 Notion，这些平台承载着关键的企业上下文信息，例如产品发布动态、可靠性事故、内部代号与工具，以及核心指标的权威定义和计算逻辑。  
- These documents are ingested, embedded, and stored with metadata and permissions. A retrieval service handles access control and caching at runtime, enabling the agent to efficiently and safely pull in this information.  
  - 这些文档被摄入系统，经向量化嵌入后，连同元数据与权限信息一并存储。一个检索服务在运行时负责访问控制与缓存管理，使智能体能够高效、安全地调取这些信息。

![Screenshot of a user asking why connector usage dipped in December. The agent explains the drop was due to a logging issue starting Nov 13, 2025, causing undercounted usage after the ChatGPT 5.1 launch. Legacy telemetry went empty until a newer event became the source of truth.](images/inside-openai_s-in-house-data-agent-openai/img_010.png)

![用户提问“为何连接器（connector）使用量在12月下降”的截图。智能体解释称，该下降源于自2025年11月13日起出现的日志记录问题——在 ChatGPT 5.1 发布后，导致使用量被低估；旧版遥测数据（legacy telemetry）一度为空，直至更新的事件成为事实来源（source of truth）。](images/inside-openai_s-in-house-data-agent-openai/img_010.png)

#### Layer \#5: Memory

#### 第五层：记忆机制

- When the agent is given corrections or discovers nuances about certain data questions, it's able to save these learnings for next time, allowing it to constantly improve with its users.  
  - 当智能体收到用户纠正，或在特定数据问题中发现新的细微差别时，它能将这些认知保存下来供后续使用，从而持续随用户反馈而优化自身能力。  
  - As a result, future answers begin from a more accurate baseline rather than repeatedly encountering the same issues.  
    - 因此，后续回答将基于更准确的初始基准展开，而非反复陷入相同误区。  
  - The goal of memory is to retain and reuse non-obvious corrections, filters, and constraints that are critical for data correctness but difficult to infer from the other layers alone.  
    - 记忆机制的目标，在于持久化并复用那些对保障数据准确性至关重要的、非显而易见的修正项、过滤条件与约束规则——而这些信息单靠前述各层通常难以推断得出。  
  - For example, in one case, the agent didn’t know how to filter for a particular analytics experiment (it relied on matching against a specific string defined in an experiment gate). Memory was crucially important here to ensure it was able to filter correctly, instead of fuzzily trying to string match.  
    - 例如，在某一案例中，智能体原本无法正确筛选某个特定分析实验（它本应依据实验门控（experiment gate）中定义的特定字符串进行匹配）；此时记忆机制至关重要——它确保了智能体能精准执行筛选，而非依赖模糊的字符串匹配。  
- When you give the agent a correction or when it finds a learning from your conversation, it will prompt you to save that memory for next time.  
  - 当您向智能体提供纠正，或它从您的对话中自主获得新认知时，它将提示您将该记忆保存以供下次使用。  
  - Memories can also be manually created and edited by users.  
    - 用户亦可手动创建和编辑记忆条目。  
  - Memories are scoped at the global and personal level, and the agent’s tooling makes it easy to edit them.  
    - 记忆条目支持全局级（global）与个人级（personal）两种作用域，且智能体配套工具提供了便捷的编辑功能。

![Notification banner showing “Data agent wants to save 2 learnings to memory,” with a labeled item “ChatGPT Top-level Metrics” and a confirmation message on the right that reads “Saved to global memory” with a green checkmark.](images/inside-openai_s-in-house-data-agent-openai/img_011.png)

![通知横幅，显示“数据智能体希望将2项学习成果保存至记忆”，其中一项标注为“ChatGPT 顶层指标（ChatGPT Top-level Metrics）”，右侧确认消息为“已保存至全局记忆”，并附绿色对勾图标。](images/inside-openai_s-in-house-data-agent-openai/img_011.png)

#### Layer \#6: Runtime Context

#### 第六层：运行时上下文

- When no prior context exists for a table or when existing information is stale, the agent can issue live queries to the data warehouse to inspect and query the table directly. This allows it to validate schemas, understand the data in real-time, and respond accordingly.

- 当某张表缺乏先验上下文，或已有信息已过时，代理可向数据仓库发起实时查询，直接检查和查询该表。这使其能够验证表结构（schema），实时理解数据内容，并据此作出响应。

- The agent is also able to talk to other Data Platform systems (metadata service, Airflow, Spark) as needed to get broader data context that exists outside the warehouse.

- 代理还可根据需要与其它数据平台系统（如元数据服务、Airflow、Spark）交互，以获取仓库之外更广泛的数据上下文。

We run a daily offline pipeline that aggregates table usage, human annotations, and Codex-derived enrichment into a single, normalized representation. This enriched context is then converted into embeddings using the [OpenAI embeddings API⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/embeddings) and stored for retrieval. At query time, the agent pulls only the most relevant embedded context via [retrieval-augmented generation⁠(opens in a new window)](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) (RAG) instead of scanning raw metadata or logs. This makes table understanding fast and scalable, even across tens of thousands of tables, while keeping runtime latency predictable and low. Runtime queries are issued to our data warehouse live as needed.

我们每天运行一条离线流水线，将表使用情况、人工标注以及由 Codex 生成的增强信息聚合为统一、标准化的表示形式。该增强后的上下文随后通过 [OpenAI 嵌入 API⁠(在新窗口中打开)](https://platform.openai.com/docs/api-reference/embeddings) 转换为嵌入向量（embeddings），并持久化存储以供检索。在查询时，代理仅通过 [检索增强生成（RAG）⁠(在新窗口中打开)](https://en.wikipedia.org/wiki/Retrieval-augmented_generation) 拉取最相关的嵌入上下文，而非扫描原始元数据或日志。这使得表理解既快速又具备可扩展性——即使面对数万张表亦然；同时还能确保运行时延迟稳定且极低。运行时查询则按需实时发送至我们的数据仓库。

![Diagram titled “Context retrieval in the data agent.” Offline preprocessing layers—table usage, human annotations, Codex enrichment, institutional knowledge, and memory—feed into RAG embeddings. Live retrieval shows the agent querying a database via semantic search or exact text retrieval to produce runtime context.](images/inside-openai_s-in-house-data-agent-openai/img_012.svg)

![图示标题为“数据代理中的上下文检索”。离线预处理层——包括表使用情况、人工标注、Codex 增强、机构知识及记忆——共同输入至 RAG 嵌入向量。实时检索部分展示代理通过语义搜索或精确文本匹配方式查询数据库，从而生成运行时上下文。](images/inside-openai_s-in-house-data-agent-openai/img_012.svg)

Together, these layers ensure the agent’s reasoning is grounded in OpenAI’s data, code, and institutional knowledge, dramatically reducing errors and improving answer quality.

上述各层协同作用，确保代理的推理始终扎根于 OpenAI 的数据、代码及机构知识，从而大幅降低错误率，并显著提升回答质量。

## Built to think and work like a teammate

## 专为像队友一样思考与协作而设计

One-shot answers work when the problem is clear, but most questions aren’t. More often, arriving at the correct result requires back-and-forth refinement and some course correction.

单次作答适用于问题明确的场景，但大多数问题并非如此。通常，得出正确结果需要反复推敲与适时调整方向。

The agent is built to behave like a teammate you can reason with. It’s a conversational, always-on and handles both quick answers and iterative exploration.

该代理被设计为一个可与之共同推理的“队友”：它支持自然对话、持续在线，既能提供即时解答，也能支持渐进式探索。

It carries over complete context across turns, so users can ask follow-up questions, adjust their intent, or change direction without restating everything. If the agent starts heading down the wrong path, users can interrupt mid-analysis and redirect it, just like working with a human collaborator who listens instead of plowing ahead.

它能在多轮对话中完整继承上下文，使用户可随时提出后续问题、调整意图或转换方向，而无需重复陈述全部背景。若代理开始偏离正轨，用户可在分析中途打断并重新引导——正如与一位善于倾听、而非一味推进的人类协作者共事。

When instructions are unclear or incomplete, the agent proactively asks clarifying questions. If no response is provided, it applies sensible defaults to make progress. For example, if a user asks about business growth with no date range specified, it may assume the last seven or 30 days. These priors allow it to stay responsive and non-blocking while still converging on the right outcome.

当指令模糊或不完整时，代理会主动提出澄清性问题；若用户未作回应，它将采用合理默认值继续推进。例如，若用户询问“业务增长情况”却未指定时间范围，代理可能默认采用最近七天或三十天的数据。这些先验设定使其既能保持响应敏捷、不阻塞流程，又能最终收敛到正确结果。

The result is an agent that works well both when you know **exactly what you want** (e.g., “Tell me about this table”) and **just as strong when you’re exploring** (e.g., “I’m seeing a dip here, can we break this down by customer type and timeframe?”).

结果是一个表现优异的智能体：无论你**明确知道自己想要什么**（例如，“请告诉我这张表的情况”），还是**正处于探索阶段**（例如，“我注意到这里出现了一个下降趋势，能否按客户类型和时间范围进一步拆解分析？”），它都能同样出色地完成任务。

After rollout, we observed that users frequently ran the same analyses for routine repetitive work. To expedite this, the agent's workflows package recurring analyses into reusable instruction sets. Examples include workflows for weekly business reports and table validations. By encoding context and best practices once, workflows streamline repeat analyses and ensure consistent results across users.

上线后，我们观察到用户经常为日常重复性工作执行相同的分析任务。为加快此类操作，该智能体的工作流（workflows）将高频重复的分析封装为可复用的指令集。典型示例包括“周度业务报告生成”和“数据表校验”等工作流。通过一次性注入上下文信息与最佳实践，工作流显著简化了重复分析流程，并确保不同用户获得一致、可靠的结果。

![UI input bar with the placeholder text “Ask a data question.” Below it is a button labeled “Use a workflow,” and to the right are microphone and send icons. The bar has rounded corners and sits against a dark background.](images/inside-openai_s-in-house-data-agent-openai/img_013.png)

![UI 输入栏，占位符文字为 “Ask a data question.”（请提出一个数据问题）；其下方是一个标有 “Use a workflow”（使用工作流）的按钮；右侧是麦克风图标和发送图标；输入栏呈圆角设计，背景为深色。](images/inside-openai_s-in-house-data-agent-openai/img_013.png)

## Moving fast without breaking trust

## 快速迭代，不失可信

Building an always-on, evolving agent means quality can drift just as easily as it can improve. Without a tight feedback loop, regressions are inevitable and invisible. The only way to scale capability without breaking trust is through systematic evaluation.

构建一个始终在线、持续演进的智能体，意味着其质量既可能提升，也可能悄然下滑。若缺乏紧密的反馈闭环，性能退化（regression）将不可避免且难以察觉。唯有通过系统化的评估机制，才能在拓展能力的同时维系用户信任。

In this section, we’ll discuss how we leverage [OpenAI’s Evals API⁠(opens in a new window)](https://platform.openai.com/docs/guides/evals) to measure and protect the agent’s response quality.

本节将介绍我们如何利用 [OpenAI 的 Evals API⁠（在新窗口中打开）](https://platform.openai.com/docs/guides/evals)，对智能体的响应质量进行量化评估与持续保障。

Its Evals are built on curated sets of question-answer pairs. Each question targets an important metric or analytical pattern we care deeply about getting right, paired with a manually authored “golden” SQL query that produces the expected result. For each eval, we send the natural language question to its query-generation endpoint, execute the generated SQL, and compare the output against the result of the expected SQL.

这些评估（Evals）基于精心筛选的问答对集合构建。每个问题均聚焦于一项关键指标或我们高度重视准确性的分析模式，并配有一个由人工编写的“黄金标准”（golden）SQL 查询语句——该语句能精确产出预期结果。每次评估中，我们将自然语言问题提交至查询生成接口，执行所生成的 SQL，并将其输出结果与“黄金标准”SQL 的执行结果进行比对。

![Diagram titled “Data agent’s evaluation pipeline.” Q&A eval pairs with expected SQL feed into a generation step that produces SQL and results. OpenAI Evals compares generated vs. expected results using dataframe and SQL comparison, outputting a score and reasoning.](images/inside-openai_s-in-house-data-agent-openai/img_014.svg)

![图示标题为 “Data agent’s evaluation pipeline”（数据智能体评估流水线）。问答评估对（含预期 SQL）输入生成环节，产出 SQL 及其执行结果；OpenAI Evals 通过数据框（dataframe）比对与 SQL 语义比对，对比生成结果与预期结果，并输出评分及推理说明。](images/inside-openai_s-in-house-data-agent-openai/img_014.svg)

Evaluation doesn’t rely on naive string matching. Generated SQL can differ syntactically while still being correct, and result sets may include extra columns that don’t materially affect the answer. To account for this, we compare both the SQL and the resulting data, and feed these signals into OpenAI’s Evals grader. The grader produces a final score along with an explanation, capturing both correctness and acceptable variation.

评估并不依赖简单的字符串匹配。生成的 SQL 在语法结构上可能与“黄金标准”不同，但仍完全正确；结果集也可能包含不影响核心答案的冗余列。为应对这一情况，我们同步比对生成的 SQL 语句本身及其执行所得的数据结果，并将这两类信号共同输入 OpenAI Evals 的评分器（grader）。该评分器最终输出一个综合评分及详细解释，兼顾逻辑正确性与合理范围内的表达差异。

These evals are like unit tests that run continuously during development to identify regressions as canaries in production; this allows us to catch issues early and confidently iterate as the agent's capabilities expand.

这些评估机制如同持续运行的单元测试，在开发过程中实时监测性能退化，充当生产环境中的“金丝雀”（canary）预警信号；这使我们得以尽早发现问题，并在智能体能力不断扩展的过程中，自信而稳健地推进迭代优化。

## Agent security

## 代理安全

Our agent plugs directly into OpenAI’s existing security and access-control model. It operates purely as an interface layer, inheriting and enforcing the same permissions and guardrails that govern OpenAI’s data.

我们的代理直接接入 OpenAI 现有的安全与访问控制模型。它纯粹作为一层接口，继承并强制执行约束 OpenAI 数据的相同权限与安全护栏。

**All of the agent’s access is strictly** **pass-through**, meaning users can only query tables they already have permission to access. When access is missing, it flags this or falls back to alternative datasets the user is authorized to use.

**代理的所有访问均为严格的“直通式”（pass-through）**，即用户仅能查询其本身已获授权访问的数据表。当用户缺乏某项访问权限时，系统会明确提示该问题，或自动回退至用户被授权使用的其他数据集。

Finally, it's built for transparency. Like any system, it can make mistakes. It **exposes its reasoning process** by summarizing assumptions and execution steps alongside each answer. When queries are executed, it links directly to the underlying results, allowing users to inspect raw data and verify every step of the analysis.

最后，该代理专为透明性而构建。如同任何系统一样，它也可能出错。它通过在每个答案旁附上对所做假设与执行步骤的简要总结，**公开其推理过程**。当查询被执行后，系统会直接链接至底层结果，使用户能够检查原始数据，并逐环节验证整个分析流程。

## Lessons learned

## 经验总结

Building our agent from scratch surfaced practical lessons about how agents behave, where they struggle, and what actually makes them reliable at scale.

从零开始构建我们的代理，揭示了诸多关于代理行为模式、常见瓶颈以及规模化部署中真正保障其可靠性的实践经验。

##### Lesson \#1: **Less is More**

##### 经验 \#1：**少即是多**

Early on, we exposed our full tool set to the agent, and quickly ran into problems with overlapping functionality. While this redundancy can be helpful for specific custom cases and is more obvious to a human when manually invoking, it’s confusing to agents. To reduce ambiguity and improve reliability, we restricted and consolidated certain tool calls.

早期，我们将全部工具集开放给代理，却很快遭遇功能重叠问题。尽管这种冗余在特定定制场景下可能有益，且人类在手动调用时也更容易察觉，但它却令代理感到困惑。为降低歧义、提升可靠性，我们对部分工具调用进行了限制与整合。

##### Lesson \#2: **Guide the Goal, Not the Path**

##### 经验 \#2：**引导目标，而非路径**

We also discovered that highly prescriptive prompting degraded results. While many questions share a general analytical shape, the details vary enough that rigid instructions often pushed the agent down incorrect paths. By shifting to higher-level guidance and relying on GPT‑5’s reasoning to choose the appropriate execution path, the agent became more robust and produced better results.

我们还发现，过于具体、指令性过强的提示词反而会降低输出质量。尽管许多问题具有相似的通用分析结构，但细节差异显著，僵化的指令常常将代理引向错误路径。转而采用更高层次的目标指引，并依托 GPT‑5 的自主推理能力来选择恰当的执行路径后，代理的鲁棒性显著增强，输出结果也更为优质。

##### Lesson #3: **Meaning Lives in Code**

##### 第三课：**意义存在于代码之中**

Schemas and query history describe a table’s shape and usage, but its true meaning lives in the code that produces it.

模式（Schemas）和查询历史描述了表的结构与使用方式，但其真正的含义却蕴藏于生成该表的代码之中。

Pipeline logic captures assumptions, freshness guarantees, and business intent that never surface in SQL or metadata.

数据管道逻辑承载着各种假设、数据新鲜度保障以及业务意图——而这些内容永远不会在 SQL 语句或元数据中显式体现。

By crawling the codebase with Codex, our agent understands how datasets are actually constructed and is able to better reason about what each table actually contains.

通过使用 Codex 对整个代码库进行爬取分析，我们的智能体能够理解数据集的真实构建过程，从而更准确地推断出每张表实际包含的内容。

It can answer “what’s in here” and “when can I use it” far more accurately than from warehouse signals alone.

它能比仅依赖数仓信号更精准地回答“这里面有什么？”以及“我何时可以使用它？”等问题。

## Same vision, new tools

## 相同的愿景，全新的工具

We’re constantly working to improve our agent by increasing its ability to handle ambiguous questions, improving its reliability and accuracy with stronger validations, and integrating it more deeply into workflows.

我们持续优化智能体：提升其应对模糊问题的能力，借助更严格的校验机制增强其可靠性与准确性，并将其更深度地融入日常协作流程。

We believe it should blend naturally into how people already work, instead of functioning like a separate tool.

我们坚信，它应当自然地融入用户既有的工作方式，而非作为一个孤立的工具存在。

While our tooling will keep benefiting from underlying improvements in agent reasoning, validation, and self-correction, our team’s mission remains the same: seamlessly deliver fast, trustworthy data analysis across OpenAI’s data ecosystem.

尽管我们的工具将持续受益于智能体在推理能力、校验机制与自我修正等方面的底层进步，但我们团队的使命始终如一：在 OpenAI 的整个数据生态中，无缝交付快速、可信的数据分析服务。

- [2026](https://openai.com/news/?tags=2026)