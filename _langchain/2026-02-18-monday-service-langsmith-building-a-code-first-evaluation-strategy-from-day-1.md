---
title: "monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-monday/"
date: "2026-02-18"
scraped_at: "2026-03-02T10:08:09.317251699+00:00"
language: "en-zh"
translated: true
description: "Learn how monday Service developed an eval-driven development framework for their customer-facing service agents."
tags: ["Case Studies"]
---

_[This is a guest post from our friends at_ [_Monday.com_](http://monday.com/?ref=blog.langchain.com) _driving eval strategy for their customer-facing AI service agents, led by Gal Ben Arieh (Group Tech Lead). Thank you for your contribution!_

[这是一篇来自我们的合作伙伴 [_Monday.com_](http://monday.com/?ref=blog.langchain.com) 的客座文章，由 Gal Ben Arieh（集团技术负责人）牵头，介绍其面向客户的 AI 服务代理的评估策略。感谢您的贡献！]

Many teams treat evaluation as a last-mile check, but we made it a Day 0 requirement.

许多团队将评估视为交付前的“最后一公里”检查，而我们将它设为“第 0 天”（Day 0）的强制要求。

[**monday Service**](https://monday.com/lp/service/blog-contactus?ref=blog.langchain.com) is an AI Native Enterprise Service Management (ESM) platform designed to automate and resolve inquiries across all service departments. When building our new [AI service workforce](https://monday.com/lp/service/blog-contactus?ref=blog.langchain.com) (a workforce of customizable, **role-based** AI agents that take the ticket load off human reps), we embedded evaluations into the development cycle from the start instead of waiting for Alpha users to find the gaps.

[**monday Service**](https://monday.com/lp/service/blog-contactus?ref=blog.langchain.com) 是一个原生 AI 驱动的企业服务管理（ESM）平台，旨在自动化并解决所有服务部门的各类咨询请求。在构建我们全新的 [AI 服务工作队](https://monday.com/lp/service/blog-contactus?ref=blog.langchain.com)（一支可定制、**基于角色**的 AI 代理团队，用于分担人工客服代表的工单处理压力）时，我们从开发初期就将评估深度嵌入整个研发流程，而非等到 Alpha 用户上线后才被动发现缺陷。

This article shows you how we built an **evals-driven development framework** to catch AI quality issues before our  users do.

本文将向您展示：我们如何构建了一套**以评估驱动的开发框架**（evals-driven development framework），在用户发现问题之前，率先识别并修复 AI 质量隐患。

What we achieved:

我们取得的成果包括：

- **Speed:** 8.7x faster evaluation feedback loops (from 162 seconds to 18 seconds).  
- **速度提升**：评估反馈循环提速 8.7 倍（从 162 秒缩短至 18 秒）。

- **Coverage**: Comprehensive testing across hundreds of examples in minutes instead of hours.  
- **覆盖广度**：分钟级完成数百个测试用例的全覆盖验证（以往需耗时数小时）。

- **Agent observability:** Real-time, end-to-end quality monitoring on production traces, using Multi-Turn Evaluators.  
- **代理可观测性**：借助多轮次评估器（Multi-Turn Evaluators），对线上真实调用链路实现端到端、实时的质量监控。

- **Evals as code:** Evaluation logic managed as version-controlled production code with GitOps-style CI/CD deployment.  
- **评估即代码**（Evals as Code）：将评估逻辑作为受版本控制的生产级代码进行管理，并通过类 GitOps 的 CI/CD 流程部署。

AI service workforce is a customizable, **LangGraph-based,** [ReAct](https://docs.langchain.com/oss/python/langchain/agents?ref=blog.langchain.com#tool-use-in-the-react-loop) agent, designed to automate and resolve inquiries across any enterprise service management use case.

AI 服务工作队是一款可高度定制的、**基于 LangGraph 构建**的 [ReAct](https://docs.langchain.com/oss/python/langchain/agents?ref=blog.langchain.com#tool-use-in-the-react-loop) 智能体，专为各类企业服务管理（ESM）场景设计，可自动化处理并闭环解决各类服务请求。

Whether applied to fields like **IT, HR, or Legal**, monday Service customers can tailor the agent to drive execution within any **service** department, by utilizing their own **KB articles** and **tools.**

无论应用于 **IT、HR 还是法务** 等领域，monday Service 的客户均可基于自身 **知识库（KB）文章** 和 **专属工具**，灵活定制该智能体，使其在任意 **服务** 部门中高效执行任务。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_001.png)

However, the very **autonomy** that makes ReAct agents so powerful, also introduces a unique challenge: because each step of the reasoning chain depends on the last, a **minor deviation** in a prompt or a tool-call result can **cascade** into a significantly different— and potentially incorrect— outcome.

然而，恰恰是赋予 ReAct 智能体强大能力的这种 **自主性**，也带来了一个独特挑战：由于推理链中每一步均依赖于上一步的结果，因此提示词（prompt）或工具调用（tool-call）结果中哪怕出现一个 **微小偏差**，也可能引发 **级联效应**，最终导致输出结果发生显著偏移——甚至完全错误。

### The Two Pillars of Evaluations

### 评估的两大支柱

Through our research into agent evaluation best practices, we quickly realized that dual-layered approach is necessary:

通过我们对智能体（agent）评估最佳实践的研究，我们很快意识到，必须采用双层评估方法：

**Offline Evaluations — "The Safety Net":** Acting somewhat like a unit-testing layer, runs the agent against curated "golden datasets”. Tests both **core logic** (e.g., groundedness, retrieval accuracy, tool-calling) and **specific edge cases** (e.g., KB article conflict or priority resolution), This layer helps to ensure that a simple prompt tweak doesn’t **inadvertently break** the agent's ability to handle **other** **tasks**.

**离线评估 — “安全网”：** 其作用类似于单元测试层，使用精心构建的“黄金数据集”（golden datasets）对智能体进行测试。既检验**核心逻辑**（例如：事实依据性/groundedness、检索准确性、工具调用能力），也覆盖**特定边界场景**（例如：知识库文章冲突或优先级判定）。该层有助于确保一次简单的提示词（prompt）调整，不会**意外破坏**智能体处理**其他任务**的能力。

**Online Evaluations — "The Monitor" (Continuous Quality):** This layer handles the ongoing collection, analysis, and enhancement of the agent’s **performance** from an end-to-end **business** perspective. By utilizing **online** evaluation pipelines, we **track** and **refine** business signals (e.g. Automated Resolution and Containment rates), ensuring in **real time** that the agent’s performance in the **wild**.

**在线评估 — “监控器”（持续质量保障）：** 该层从端到端的**业务视角**出发，持续收集、分析并优化智能体的**实际表现**。借助**在线**评估流水线，我们可**实时追踪**并**持续优化**关键业务指标（如：自动解决率与问题遏制率），从而确保智能体在**真实生产环境**中的表现始终处于受控与提升状态。

### Pillar A: Offline Evaluations — "The Safety Net"

### 支柱 A：离线评估 — “安全网”

#### Designing Our Evaluation Coverage Strategy

#### 设计我们的评估覆盖策略

Before writing a single evaluation, we needed to answer a fundamental question: What should we actually evaluate? The challenge **wasn’t** **designing a perfect coverage strategy** \- it was simply picking a **practical starting point**.

在编写任何一条评估用例之前，我们必须先回答一个根本性问题：我们究竟应该评估什么？真正的挑战**并非**设计一套**完美的覆盖策略**，而仅仅是选定一个**切实可行的起点**。

We constructed a small dataset of ~30 real (sanitized) resolved IT tickets, chosen from our internal IT help desk to cover common request categories like:

我们构建了一个小型数据集，包含约 30 个真实（已脱敏）且已解决的 IT 工单，全部选自公司内部 IT 帮助台，旨在覆盖以下常见请求类别：

- Access & Identity (e.g. IDP, SSO, Software Access)  
- 访问与身份管理（例如：身份提供商 IDP、单点登录 SSO、软件访问权限）  
- VPN and connectivity issues  
- VPN 与网络连接问题  
- Device / OS support (updates, performance, hardware issues)  
- 设备 / 操作系统支持（系统更新、性能问题、硬件故障）

In that first suite, our checks were intentionally **simple**:  

在首批评估套件中，我们的检查项被有意设计得**极为简洁**：

- **Deterministic**“smoke” checks:  
- **确定性**“冒烟测试”检查：

  - Runtime health: the agent ran with no crashes/timeouts, request succeeds end-to-end.  
    - 运行时健康状态：智能体运行过程中未发生崩溃或超时，请求端到端成功完成。

  - Output shape: the response matches the expected schema/format (even before judging content).  
    - 输出结构：响应符合预期的模式/格式（甚至在内容评估之前即验证）。

  - State & persistence: thread/session created and the conversation was persisted properly in our application database.  
    - 状态与持久化：会话/线程已成功创建，且对话数据已正确持久化至应用数据库中。

  - Basic Tool Sanity Check: All necessary tools were correctly invoked with appropriate inputs and completed their execution without errors.  
    - 基础工具合理性检查：所有必要工具均被正确调用，输入参数恰当，且执行过程无错误。

- **LLM-as-judge**: We started with an off-the-shelf evaluator from [OpenEvals (Correctness)](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#correctness) that compares the agent response to the reference output from the same resolved-ticket dataset.  
- **大语言模型作为评判者（LLM-as-judge）**：我们最初采用 [OpenEvals（正确性）](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#correctness) 提供的开箱即用评测器，将智能体响应与同一已解决工单数据集中的参考输出进行比对。

Once that baseline existed, we expanded with smaller, **use-case-specific** datasets to probe **specific behaviors** – including session memory, KB retrieval, grounding and conflict resolution, and guardrails. As these behaviors got more nuanced, we moved from **one correctness score** to a more comprehensive set of checks:  
在建立该基线后，我们进一步扩展，引入更小、**面向具体用例**的数据集，以深入检验**特定行为**——包括会话记忆、知识库（KB）检索、事实依据（grounding）与冲突解决，以及安全护栏（guardrails）。随着这些行为日益复杂，我们不再仅依赖**单一正确性得分**，而是转向一套更全面的评测维度：

- **KB grounding / Citations:** “Does every factual claim trace back to the provided KB content?” (We verify this using LangSmith’s prebuilt [hallucination](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#hallucination) / [answer relevance](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#answer-relevance) checks).  
  - **知识库依据 / 引用溯源**：“每一项事实性主张是否均可追溯至所提供的知识库内容？”（我们借助 LangSmith 预置的 [幻觉检测](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#hallucination) 与 [答案相关性](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#answer-relevance) 检查来验证。）

- **Conflict handling:** “When policies vary by region/time, did the agent ask for clarification or pick the latest applicable policy?” (or the prebuilt [correctness](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#correctness) check).  
  - **冲突处理**：“当政策因地域或时间而异时，智能体是否主动请求澄清，或选择最新适用的政策？”（亦可复用预置的 [正确性](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#correctness) 检查。）

- **Guardrails:** “Did the agent refuse when required?” / “Did it avoid revealing internal tool names or prompt content?” (or the prebuilt [toxicity](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#toxicity) / [conciseness](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#conciseness) checks).  
  - **安全护栏**：“智能体是否在必要时果断拒绝请求？” / “是否避免泄露内部工具名称或提示词（prompt）内容？”（亦可复用预置的 [毒性检测](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#toxicity) 与 [简洁性](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#conciseness) 检查。）

- **KB usage timing:** The KB should be fetched at a reasonable point (not too early, and not after the answer is already formed) using [AgentEvals' Trajectory LLM-as-judge](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#trajectory-llm-as-judge).  
  - **知识库调用时机**：知识库应在合理节点被调用（既不能过早，也不能在答案已生成之后），我们通过 [AgentEvals 的轨迹式 LLM-as-judge](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#trajectory-llm-as-judge) 实现该评测。

- **Guardrail ordering:** Safety/policy guardrails should run at the right stage (before producing the final answer). This is another [trajectory](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#trajectory-llm-as-judge) check.  
  - **护栏执行顺序**：安全与策略类护栏必须在恰当阶段触发（即在生成最终答案之前）。这同样是另一项 [轨迹式](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#trajectory-llm-as-judge) 检查。

#### The Framework: langsmith/vitest  
#### 框架：langsmith/vitest

To implement this layer, we utilized the **LangSmith Vitest** [integration](https://docs.langchain.com/langsmith/vitest-jest?ref=blog.langchain.com#vitest). This approach provides the power of a battle-hardened testing framework ( **Vitest**) while remaining seamlessly integrated with the **LangSmith ecosystem**.  
为实现该评测层，我们采用了 **LangSmith Vitest** [集成方案](https://docs.langchain.com/langsmith/vitest-jest?ref=blog.langchain.com#vitest)。该方案兼具久经考验的测试框架（**Vitest**）的强大能力，同时与 **LangSmith 生态系统**无缝协同。

With this setup, every CI run is **automatically** logged as a distinct experiment in the **LangSmith platform**, and each test suite functions as a **dataset**. This gives us the visibility to drill down into specific **runs** and see exactly where the agent diverged from the **ground truth**, making it easy to verify the impact of any code changes **before** they reach production.  
借助此配置，每次 CI 运行都会**自动**记录为 **LangSmith 平台**中一项独立实验，而每个测试套件则天然构成一个 **数据集**。这使我们能够深入分析特定的 **执行记录（run）**，精准定位智能体偏离 **真实基准（ground truth）** 的环节，从而轻松验证任意代码变更在**上线前**的实际影响。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_002.png)

#### The Hard Lesson: Don’t Compromise on DevEx  
#### 沉重一课：切勿在开发者体验（DevEx）上妥协

At first, our offline evaluations ran serially. The standard development loop—eval (fail) → fix → re-eval (pass)—became a major bottleneck.  
起初，我们的离线评测以串行方式执行。标准开发循环——“评测（失败）→ 修复 → 再评测（通过）”——迅速演变为显著瓶颈。

We found that a slow feedback loop inevitably compromises either our testing depth or our development pace. To sustain high-velocity shipping without regressions, we realized the evaluation process had to be fast enough to ensure a frictionless iteration loop.  
我们发现，缓慢的反馈循环终将迫使我们在**测试深度**与**开发节奏**之间做出取舍。为在不引发回归的前提下持续高速交付，我们深刻意识到：评测流程本身必须足够迅捷，方能保障顺畅无阻的迭代闭环。

#### The Solution: Parallelizing with Vitest + ls.describe.concurrent

#### 解决方案：使用 Vitest 与 `ls.describe.concurrent` 实现并行化

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_003.png)

By optimizing our Vitest and LangSmith integration, we achieved a massive speed increase by distributing the load across **local workers and remote API calls**. The key was a hybrid approach: **parallelizing test files** to maximize CPU usage and **running LLM evaluations concurrently** to handle I/O-bound latency.

通过优化 Vitest 与 LangSmith 的集成，我们通过将负载分发至**本地工作进程与远程 API 调用**，实现了显著的性能提升。其核心在于一种混合策略：**并行执行测试文件**以最大化 CPU 利用率，同时**并发执行大语言模型（LLM）评估任务**，以应对 I/O 密集型操作带来的延迟。

- **Parallelism (CPU-Bound):** We leverage Vitest’s [pool:'forks'](https://vitest.dev/config/pool.html?ref=blog.langchain.com#forks) to distribute the workload across multiple cores. By **assigning each Dataset Shard to a separate test file**, we allow multiple worker processes to run in parallel without competing for CPU. This setup ensures that even as our datasets grow, we can process them quickly by **distributing the shards across available cores.**

- **并行性（CPU 密集型）：** 我们利用 Vitest 的 [`pool: 'forks'`](https://vitest.dev/config/pool.html?ref=blog.langchain.com#forks) 配置，将工作负载分发到多个 CPU 核心上。通过**为每个数据集分片（Dataset Shard）分配独立的测试文件**，多个工作进程可并行运行，且互不争抢 CPU 资源。该设计确保：即使数据集持续增长，我们仍能通过**将分片均匀分配至可用核心**，快速完成处理。

- **Concurrency (I/O-Bound):** Within each test file, we use ls.describe.concurrent to maximize throughput. Since **LLM evaluations** are high-latency, concurrency allows us to **overlap the latency** by firing off dozens of evaluations at once, ensuring the runner never sits idle.

- **并发性（I/O 密集型）：** 在每个测试文件内部，我们使用 `ls.describe.concurrent` 来最大化吞吐量。由于**LLM 评估任务延迟较高**，并发机制使我们能够**重叠（overlap）延迟时间**——一次性发起数十个评估请求，从而确保测试执行器（runner）始终处于活跃状态，不会空闲等待。

- **The Eval Function:**This is the core logic responsible for evaluating each example. We use it to run a two-tiered validation in a single pass:
  - **Deterministic Baseline:** Hard assertions to ensure the agent adheres to the **response schema** and maintains **state persistence** (via checkpointer/storage).
  - **LLM-as-a-Judge:** Semantic grading against a "Golden Dataset". We leverage open-source libraries like [**OpenEvals**](https://www.google.com/search?q=https%3A%2F%2Fgithub.com%2Fexplodinggradients%2Fopenevals&ref=blog.langchain.com) and [**AgentEvals**](https://github.com/langchain-ai/agent-evals?ref=blog.langchain.com) to score dimensions like **correctness** and **groundedness**.

- **评估函数（Eval Function）：** 这是负责逐条评估样本的核心逻辑。我们借此在单次执行中完成两层验证：
  - **确定性基线（Deterministic Baseline）：** 采用硬性断言（hard assertions），确保智能体严格遵循**响应模式（response schema）**，并借助检查点器（checkpointer）或存储机制维持**状态持久性（state persistence）**；
  - **LLM 作为裁判（LLM-as-a-Judge）：** 基于“黄金数据集（Golden Dataset）”进行语义评分。我们借助开源库（如 [**OpenEvals**](https://www.google.com/search?q=https%3A%2F%2Fgithub.com%2Fexplodinggradients%2Fopenevals&ref=blog.langchain.com) 和 [**AgentEvals**](https://github.com/langchain-ai/agent-evals?ref=blog.langchain.com)）对**正确性（correctness）**、**依据充分性（groundedness）** 等维度进行打分。

**The Result:** Comprehensive feedback over **hundreds** of examples in **minutes**!

**最终效果：** 仅需**数分钟**，即可完成对**数百个**样本的全面反馈！

**Benchmarking** results for 20 sanitized IT tickets using a MacBook Pro 16-inch (Nov 2023, Apple M3 Pro, 36 GB RAM, macOS Tahoe 26.2):

针对 20 个脱敏的 IT 工单，在搭载 Apple M3 Pro 芯片、36 GB 内存、macOS Tahoe 26.2 系统的 16 英寸 MacBook Pro（2023 年 11 月发布）上测得的**基准测试（Benchmarking）**结果如下：

|     |     |     |
| --- | --- | --- |
| Execution Mode | Total Duration | Speedup vs Sequential |
| Parallel + Concurrent | 18.60s | 8.7x faster |
| Concurrent Only | 39.30s | 4.1x faster |
| Sequential | 162.35s | Baseline |

| 执行模式（Execution Mode） | 总耗时（Total Duration） | 相比串行执行的加速比（Speedup vs Sequential） |
| -------------------------- | ------------------------ | ------------------------------------------- |
| 并行 + 并发（Parallel + Concurrent） | 18.60 秒 | 快 8.7 倍 |
| 仅并发（Concurrent Only） | 39.30 秒 | 快 4.1 倍 |
| 串行（Sequential） | 162.35 秒 | 基准线（Baseline） |

### Pillar B: Online Evaluations — "The Monitor”

### 柱石 B：在线评估——“监控器（The Monitor）”

#### Online, Multi Turn Evaluations

#### 在线、多轮次评估

While offline evaluations are often used to catch regressions in a controlled sandbox, they are essentially static snapshots of **synthetic or sanitized examples**. To capture the **unpredictability of production**, we needed Online Evaluations—running on real production traces in **real-time**.

尽管离线评估常被用于在受控沙箱环境中捕获回归问题，但其本质只是对**合成数据或脱敏样本**所作的静态快照。为真实反映**生产环境的不可预测性**，我们必须引入在线评估——即直接在真实的生产调用链路（production traces）上，以**实时方式**运行评估。

Since our agent handles complex, **multi-turn** dialogues, success is often not defined by a single response, but by the **entire conversation** trajectory. This requires an evaluation strategy that accounts for how the agent guides the user toward a resolution over **several turns**.

由于我们的智能体处理的是复杂的**多轮次**对话，其成功与否往往并非由单次响应决定，而是取决于**整段对话**的演进轨迹。这就要求我们采用一种评估策略，能够综合考量智能体如何在**多个对话轮次**中引导用户达成问题解决。

We found a perfect fit in **LangSmith’s** [**Multi-Turn Evaluator**](https://docs.langchain.com/langsmith/online-evaluations?ref=blog.langchain.com#configure-multi-turn-online-evaluators), which leverages **LLM-as-a-judge** to score end-to-end threads. Instead of evaluating individual runs in isolation, we can now use custom prompts to grade the entire conversation trajectory—measuring high-level outcomes like **user satisfaction, tone, and goal resolution.**

我们在 **LangSmith** 的 [**多轮次评估器（Multi-Turn Evaluator）**](https://docs.langchain.com/langsmith/online-evaluations?ref=blog.langchain.com#configure-multi-turn-online-evaluators) 中找到了理想方案——该工具依托 **“大语言模型作为裁判”（LLM-as-a-judge）** 范式，对端到端的完整对话线程进行打分。与过去孤立评估单次运行（individual runs）不同，我们现在可通过自定义提示词（custom prompts）对整段对话轨迹进行评分，从而衡量**用户满意度、语气风格、目标是否达成**等高层级指标。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_004.png)

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_004.png)

What’s most impressive is how **quickly** we were able to go live. The **LangSmith platform** makes the multi-turn setup **incredibly intuitive**: we could define a **custom inactivity window** to pinpoint exactly when a session should be considered " **complete**" and ready for evaluation, and easily apply a **sampling rate** to balance our data volume with the LLM costs.

最令人印象深刻的是，我们上线速度之快。**LangSmith 平台**让多轮次评估配置变得**极为直观**：我们可以定义一个**自定义非活跃时间窗口（custom inactivity window）**，精准判定某次会话何时应被视为“**已完成**”并进入评估阶段；同时，也能轻松设置**采样率（sampling rate）**，在数据规模与大语言模型调用成本之间取得平衡。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_005.png)

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_005.png)

#### Evaluations as Code (EaC)

#### 代码化评估（Evaluations as Code, EaC）

As we moved from prototype to production, we wanted to manage our "judges" with the same standards we apply to any other production code: **version control, peer reviews, and automated CI/CD pipelines.**

当项目从原型阶段迈向生产环境时，我们希望以管理其他任何生产级代码的同等标准来管理我们的“评估裁判”（judges）：即纳入**版本控制、实施同行评审（peer reviews）、接入自动化 CI/CD 流水线**。

To achieve this, we moved the source of truth into our repository, defining our "judges" as structured TypeScript objects.

为实现这一目标，我们将评估逻辑的“唯一可信源”（source of truth）迁移至代码仓库中，并将“裁判”定义为结构化的 TypeScript 对象。

```typescript
// conversation-analysis.ts
export const conversationAnalysis = new MultiSignalEvaluationPrompt({
  name: 'conversation-analysis',
  variables: ['all_messages'],
  modelConfig: { model: 'gpt-5.2-pro', reasoning: { effort: 'high' } },
  extractionFields: [\
    new ExtractionField({ key: 'human_handoff', type: 'boolean', includeComment: true }),\
    new ExtractionField({ key: 'meaningful_interaction', type: 'boolean', includeComment: true }),\
    new ExtractionField({ key: 'is_automated_resolution', type: 'boolean', includeComment: true }),\
    // ... additional atomic signals\
  ],
  systemPrompt: `You are an expert conversation analyst...`,
  humanPrompt: `Analyze the following conversation:
<conversation>
{{{all_messages}}}
</conversation>`,
});
```

```typescript
// conversation-analysis.ts
export const conversationAnalysis = new MultiSignalEvaluationPrompt({
  name: 'conversation-analysis',
  variables: ['all_messages'],
  modelConfig: { model: 'gpt-5.2-pro', reasoning: { effort: 'high' } },
  extractionFields: [\
    new ExtractionField({ key: 'human_handoff', type: 'boolean', includeComment: true }),\
    new ExtractionField({ key: 'meaningful_interaction', type: 'boolean', includeComment: true }),\
    new ExtractionField({ key: 'is_automated_resolution', type: 'boolean', includeComment: true }),\
    // …… 其他原子级信号字段 \
  ],
  systemPrompt: `你是一位资深对话分析专家……`,
  humanPrompt: `请分析以下对话：
<conversation>
{{{all_messages}}}
</conversation>`,
});
```

Moving our judges into code unlocked two critical capabilities:

将“裁判”逻辑移入代码，释放了两项关键能力：

1. We could leverage AI IDEs like **Cursor** and **Claude Code** to refine complex prompts directly within our primary workspace.  
1. 我们可以利用 **Cursor** 和 **Claude Code** 等 AI 驱动的集成开发环境（IDE），在主工作区中直接优化复杂的提示词（prompts）。

2. It felt natural to write offline evaluations for our judges to ensure accuracy before they ever touch production traffic.  
2. 为评估员编写离线评估逻辑显得十分自然——这样可在评估逻辑正式接入生产流量前，充分验证其准确性。

The migration was relatively easy thanks to LangChain’s IDE integrations. We used the [**Documentation MCP**](https://docs.langchain.com/use-these-docs?ref=blog.langchain.com) to pull library context into our editor and the [**LangSmith MCP**](https://github.com/langchain-ai/langsmith-mcp-server?ref=blog.langchain.com) to fetch runs and feedback directly. The [**LangChain Chat**](https://chat.langchain.com/?ref=blog.langchain.com) was also a useful reference for clarifying specific implementation details.  
得益于 LangChain 对 IDE 的原生支持，本次迁移过程相对顺利。我们通过 [**Documentation MCP**](https://docs.langchain.com/use-these-docs?ref=blog.langchain.com) 将库文档上下文直接拉取至编辑器中；借助 [**LangSmith MCP**](https://github.com/langchain-ai/langsmith-mcp-server?ref=blog.langchain.com)，可直接获取运行记录（runs）与用户反馈；此外，[**LangChain Chat**](https://chat.langchain.com/?ref=blog.langchain.com) 也为我们厘清特定实现细节提供了有力参考。

#### Deployment  

#### 部署  

To close the loop, we built a custom CLI command, `yarn eval deploy`, that runs in our CI/CD pipeline. This ensures our repository remains the absolute Source of Truth for our evaluation infrastructure.  
为形成闭环，我们构建了一个自定义 CLI 命令 `yarn eval deploy`，该命令在 CI/CD 流水线中执行。此举确保代码仓库始终是我们评估基础设施的唯一可信数据源（Source of Truth）。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_006.png)

When we merge a PR, our synchronization engine performs a three-step Reconciliation Loop:  
当合并 Pull Request（PR）时，我们的同步引擎将执行一个三步“协调循环”（Reconciliation Loop）：

1. **Sync Prompts**: Pushes TypeScript definitions to the LangSmith Prompt Registry.  
1. **同步提示词**：将 TypeScript 定义推送至 LangSmith 提示词注册中心（Prompt Registry）。

2. **Reconcile Rules**: Compares local evaluations (rules) definitions against active production ones, updating or creating them **automatically**.  
2. **协调评估规则**：将本地评估规则（evaluations / rules）定义与线上活跃的生产规则进行比对，并**自动**完成更新或新建操作。

3. **Prune**: Identifies and deletes "zombie" evaluations/prompts from the LS platform if these are no longer present in the codebase.  
3. **清理冗余项**：识别并从 LangSmith 平台中删除已从代码库中移除的“僵尸”评估项或提示词（即不再存在于代码库中的评估逻辑或提示词）。

![](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_007.png)

### The Evolution of the Stack: Looking Ahead  

### 技术栈的演进：展望未来  

As our evaluation logic matured, we wanted to manage it with the same rigor as production code— version control, PR reviews, CI/CD. LangSmith's API-first architecture made this natural to implement, allowing our custom deployment pipeline to sync our TypeScript definitions directly to the LangSmith platform.  
随着评估逻辑日趋成熟，我们希望以与生产代码同等的严谨性对其进行管理——包括版本控制、Pull Request 评审、CI/CD 自动化等。LangSmith 以 API 为先（API-first）的架构设计，使这一目标得以自然落地：我们的自定义部署流水线可直接将 TypeScript 定义同步至 LangSmith 平台。

This gave us the best of both worlds: LangSmith's powerful evaluation infrastructure with our team's GitOps workflow. We expect this pattern to become even more common as the ecosystem matures, potentially evolving into standardized 'Evaluations as Infrastructure' tooling similar to Terraform modules.

这让我们兼得二者之长：既拥有 LangSmith 强大的评估基础设施，又延续了我们团队的 GitOps 工作流。随着整个生态系统的日益成熟，我们预计此类模式将愈发普遍，甚至可能演变为标准化的“评估即基础设施（Evaluations as Infrastructure）”工具，其形态类似于 Terraform 模块。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_008.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_008.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_009.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith 构建 AI 智能体，全面升级客户体验](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_009.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith 构建 AI 智能体，全面升级客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_010.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_010.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业辅助赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_011.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_011.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_012.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_012.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 与 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_013.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意工作者](images/monday-service-langsmith-building-a-code-first-evaluation-strategy-from-day-1/img_013.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：6 分钟