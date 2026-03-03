---
title: "Improving Deep Agents with harness engineering"
source: "LangChain Blog"
url: "https://blog.langchain.com/improving-deep-agents-with-harness-engineering/"
date: "2026-02-17"
scraped_at: "2026-03-02T10:08:10.512893910+00:00"
language: "en-zh"
translated: true
description: "TLDR: Our coding agent went from Top 30 to Top 5 on Terminal Bench 2.0. We only changed the harness. Here&#x2019;s our approach to harness engineering (teaser: self-verification & tracing help a lot)...."
---

TLDR: Our coding agent went from Top 30 to Top 5 on [Terminal Bench 2.0](https://www.tbench.ai/leaderboard/terminal-bench/2.0?ref=blog.langchain.com). We only changed the harness. Here’s our approach to harness engineering (teaser: self-verification & tracing help a lot).

TLDR：我们的编程智能体在 [Terminal Bench 2.0](https://www.tbench.ai/leaderboard/terminal-bench/2.0?ref=blog.langchain.com) 榜单中，排名从第 30 名跃升至前 5 名。我们仅调整了“harness”（执行框架）。以下是我们在 harness 工程化方面的实践思路（预告：自验证与追踪效果显著）。

## The Goal of Harness Engineering

## Harness 工程化的目标

The goal of a harness is to mold the inherently spiky intelligence of a model for tasks we care about. **Harness Engineering** is about systems, you’re building tooling around the model to optimize goals like task performance, token efficiency, latency, etc. Design decisions include the system prompt, tool choice, and execution flow.

Harness 的目标，是将大模型固有的、不稳定的智能“塑形”，使其适配我们真正关心的任务。**Harness 工程化**本质上是一种系统性工作——你围绕模型构建配套工具链，以优化任务性能、Token 效率、延迟等目标。关键设计决策包括系统提示词（system prompt）、工具选型以及执行流程。

But how should you change the harness to improve your agent?

但究竟该如何调整 harness，才能切实提升你的智能体表现？

At LangChain, we use [Traces](https://docs.langchain.com/langsmith/observability-quickstart?ref=blog.langchain.com) to understand agent failure modes at scale. Models today are largely black-boxes, their inner mechanisms are hard to interpret. But we can see their inputs and outputs in text space which we then use in our improvement loops.

在 LangChain，我们借助 [Traces](https://docs.langchain.com/langsmith/observability-quickstart?ref=blog.langchain.com) 大规模分析智能体的失败模式。当前的大模型本质上仍是“黑盒”，其内部机制难以解读；但我们能清晰观察到它们在文本空间中的输入与输出，并将这些可观测信号纳入持续优化闭环。

We used a simple recipe to iteratively improve [deepagents-cli](https://github.com/langchain-ai/deepagents/tree/main/libs/cli?ref=blog.langchain.com) (our coding agent) `13.7 points` from `52.8` to `66.5` on Terminal Bench 2.0. We only tweaked the harness and kept the model fixed, `gpt-5.2-codex`.

我们采用一套简洁可行的方法，在 Terminal Bench 2.0 上对 [deepagents-cli](https://github.com/langchain-ai/deepagents/tree/main/libs/cli?ref=blog.langchain.com)（我们的编程智能体）进行了迭代优化，分数从 `52.8` 提升至 `66.5`，净增 `13.7` 分。整个过程中，我们仅调整了 harness，而模型本身保持不变——始终使用 `gpt-5.2-codex`。

![](images/improving-deep-agents-with-harness-engineering/img_001.png)

## Experiment Setup & The Knobs on a Harness

## 实验设置与 Harness 的可调参数

We used [Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com), a now standard benchmark to evaluate agentic coding. It has 89 tasks across domains like machine learning, debugging, and biology. We use [Harbor](https://harborframework.com/?ref=blog.langchain.com) to orchestrate the runs. It spins up sandboxes ( [Daytona](https://www.daytona.io/?ref=blog.langchain.com)), interacts with our agent loop, and runs verification + scoring.

我们采用 [Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com)——当前评估具身式编程（agentic coding）的事实标准基准——开展实验。该基准共包含 89 项任务，覆盖机器学习、调试、生物学等多个领域。我们使用 [Harbor](https://harborframework.com/?ref=blog.langchain.com) 统筹调度全部实验运行：它自动创建沙箱环境（基于 [Daytona](https://www.daytona.io/?ref=blog.langchain.com)），与我们的智能体执行循环交互，并完成结果验证与打分。

Every agent action is stored in [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com). It also includes metrics like latency, token counts, and costs.

每个智能体动作均完整记录于 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)，同时附带延迟、Token 数量、调用成本等关键指标。

### **The Knobs we can Turn**

### **可调节的参数**

An agent harness has a lot of knobs: system prompts, tools, hooks/middleware, skills, sub-agent delegation, memory systems, and more. We deliberately compress the optimization space and focus on three: **System Prompt, Tools,** and [**Middleware**](https://docs.langchain.com/oss/python/langchain/middleware/overview?ref=blog.langchain.com#the-agent-loop) (our term for hooks around model and tool calls).

代理运行时（agent harness）包含大量可调节参数：系统提示词（system prompts）、工具（tools）、钩子/中间件（hooks/middleware）、技能（skills）、子代理委派（sub-agent delegation）、记忆系统（memory systems），等等。我们有意压缩优化空间，聚焦于其中三项：**系统提示词（System Prompt）、工具（Tools）** 和 [**中间件（Middleware）**](https://docs.langchain.com/oss/python/langchain/middleware/overview?ref=blog.langchain.com#the-agent-loop)（即围绕大模型调用与工具调用所设置的钩子机制，我们称之为“中间件”）。

We start with a default prompt and standard tools+middleware. This scores 52.8% with GPT-5.2-Codex. A solid score, just outside the Top 30 of the leaderboard today, but room to grow.

我们从默认提示词及标准工具集+中间件配置出发。该配置在 GPT-5.2-Codex 上得分为 52.8%——成绩扎实，略低于当前排行榜前 30 名，但仍具提升空间。

![](images/improving-deep-agents-with-harness-engineering/img_002.png)

### **The Trace Analyzer Skill**

### **追踪分析技能（Trace Analyzer Skill）**

We wanted trace analysis to be repeatable so we made it into an Agent Skill. This serves as our recipe to **analyze errors across runs and make improvements to the harness**. The flow is:

我们希望追踪分析过程具备可复现性，因此将其封装为一项 **Agent 技能（Agent Skill）**。该技能构成了我们用于 **跨实验轮次分析错误、并持续优化运行时（harness）** 的标准化方法。其执行流程如下：

1. Fetch experiment traces from LangSmith  
   1. 从 LangSmith 获取实验追踪数据（experiment traces）  
2. Spawn parallel error analysis agents → main agent synthesizes findings + suggestions  
   2. 启动多个并行的错误分析智能体 → 主智能体汇总分析结果并生成改进建议  
3. Aggregate feedback and make targeted changes to the harness.  
   3. 汇总反馈，并对运行时进行有针对性的调整。

This works similarly to [boosting](https://en.wikipedia.org/wiki/Boosting_(machine_learning)?ref=blog.langchain.com) which focuses on mistakes from previous runs. A human can be pretty helpful in Step 3 (though not required) to verify and discuss proposed changes. Changes that overfit to a task are bad for generalization and can lead to regressions in other Tasks.

该机制类似于 [集成学习中的 Boosting 方法](https://en.wikipedia.org/wiki/Boosting_(machine_learning)?ref=blog.langchain.com)，即重点关注前序运行中暴露的错误。在第 3 步中，人工参与虽非必需，但非常有价值——可用于验证并讨论拟议的修改方案。若所做修改过度适配某一特定任务（overfitting），将损害模型泛化能力，并可能在其他任务上引发性能倒退（regressions）。

Automated trace analysis saves hours of time and made it easy to quickly try experiments. We’ll be publishing this skill soon, we’re currently testing it for prompt optimization generally.

自动化追踪分析大幅节省了数小时人工分析时间，也使快速开展各类实验变得轻而易举。我们即将正式发布此项技能；目前正将其应用于通用场景下的提示词（prompt）优化测试中。

![](images/improving-deep-agents-with-harness-engineering/img_003.png)

## What Actually Improved Agent Performance

## 实际上，哪些因素真正提升了智能体（Agent）的性能？

Automated Trace analysis allowed us to [debug where agents were going wrong](https://www.langchain.com/conceptual-guides/agent-observability-powers-agent-evaluation?ref=blog.langchain.com). Issues included reasoning errors, not following task instructions, missing testing and verification, running out of time, etc. We go into these improvements in more details in the sections below.

自动化追踪分析使我们能够[精准定位智能体出错的位置](https://www.langchain.com/conceptual-guides/agent-observability-powers-agent-evaluation?ref=blog.langchain.com)。常见问题包括：推理错误、未遵循任务指令、缺乏测试与验证、超时终止等。下文各小节将更详细地阐述这些改进措施。

### Build & Self-Verify

### 构建与自我验证（Build & Self-Verify）

Today’s models are exceptional self-improvement machines.

当今的大模型是极为出色的自我优化机器。

**Self-verification allows agents to self-improve via feedback within a run**. However, they don’t have a natural tendency to enter this **build-verify loop.**

**自我验证（Self-verification）使智能体能在单次运行过程中，借助反馈实现自我优化**。然而，它们本身并不天然倾向于进入这种**“构建–验证”循环（build-verify loop）**。

The most common failure pattern was that the agent wrote a solution, re-read its own code, confirmed it looks ok, and stopped. Testing is a key part of autonomous agentic coding. It helps test for overall correctness and simultaneously gives agents signal to hill-climb against.

最常见的失败模式是：智能体编写完解决方案后，重新阅读自己的代码，确认“看起来没问题”，便直接终止执行。而测试是自主式智能体编程（autonomous agentic coding）的关键环节——它不仅用于检验整体正确性，同时也为智能体提供优化方向的信号（即“爬山”式迭代依据）。

We added guidance to the system prompt on how to approach problem solving.

我们在系统提示词（system prompt）中增加了关于如何开展问题求解的明确指引：

1. **Planning & Discovery:** Read the task, scan the codebase, and build an initial plan based on the task specification and how to verify the solution.  
   **规划与探索（Planning & Discovery）**：通读任务要求，扫描现有代码库，并基于任务规范及后续验证方式，制定初步实施计划。

2. **Build:** Implement the plan with verification in mind. Build tests, if they don’t exist and test both happy paths and edge cases.  
   **构建（Build）**：在验证意识指导下落实计划；若尚无测试用例，则需自行编写，且须覆盖正常路径（happy paths）与边界情况（edge cases）。

3. **Verify:** Run tests, read the full output, compare against what was asked (not against your own code).  
   **验证（Verify）**：运行全部测试，完整阅读输出结果，并将其与原始任务要求比对（而非与自身代码比对）。

4. **Fix:** Analyze any errors, revisit the original spec, and fix issues.  
   **修复（Fix）**：分析报错原因，回溯原始任务说明，针对性修正问题。

We really focus on testing because it powers the changes in every iteration. We found that alongside prompting, deterministic context injection helps agents verify their work. We use a `PreCompletionChecklistMiddleware` that intercepts the agent before it exits and reminds it to run a verification pass against the Task spec. This is similar to a [Ralph Wiggum Loop](https://ghuntley.com/loop/?ref=blog.langchain.com) where a hook forces the agent to continue executing on exit, we use this for verification.

我们之所以高度聚焦于测试，是因为它驱动着每一次迭代中的实质性改进。我们发现：除提示工程（prompting）外，确定性的上下文注入（deterministic context injection）亦能显著增强智能体的自我验证能力。为此，我们引入了一个名为 `PreCompletionChecklistMiddleware` 的中间件——它会在智能体即将退出前进行拦截，并提醒其依据任务规范（Task spec）执行一次完整的验证流程。这一机制类似于 [Ralph Wiggum Loop](https://ghuntley.com/loop/?ref=blog.langchain.com)：通过钩子（hook）强制智能体在“退出时刻”继续执行；而我们将该机制专门用于验证环节。

![](images/improving-deep-agents-with-harness-engineering/img_004.png)

### Giving Agents Context about their Environment

### 为智能体提供关于其运行环境的上下文

Part of harness engineering is **building a good delivery mechanism for context engineering.** Terminal Bench tasks come with directory structures, built-in tooling, and strict timeouts.

“运行时框架工程”（harness engineering）的一部分，就是**构建一套高效、可靠的上下文工程交付机制。** Terminal Bench 中的任务自带目录结构、内置工具链，并设有严格的超时限制。

1. **Directory Context & Tooling:** A `LocalContextMiddleware` runs on agent start to map the `cwd` and other parent+children directories. We run `bash` commands to find tools like `Python` installations. Context discovery and search are error prone, so injecting context reduces this error surface and helps **onboard the agent into its environment.**

1. **目录上下文与工具链：** 智能体启动时，`LocalContextMiddleware` 会自动执行，用于映射当前工作目录（`cwd`）及其父目录与子目录结构；我们通过执行 `bash` 命令来探测环境中已安装的工具（例如 `Python` 解释器）。上下文的自动发现与搜索过程容易出错，因此主动注入上下文可显著缩小错误面，并帮助智能体**顺利接入并适应其运行环境。**

2. **Teaching Agents to Write Testable Code:** Agents don’t know how their code needs to be testable. We add prompting say their work will be measured against programatic tests, similar to when committing code. For example, Task specs that mention file paths should be followed exactly so the solutions works in an automated scoring step. Prompting that stresses edge-cases helps the agent avoid only checking “happy path” cases. Forcing models to conform to testing standards is a powerful strategy to avoid “slop buildup” over time.

2. **教导智能体编写可测试的代码：** 智能体本身并不了解其生成的代码需满足何种可测试性要求。我们通过提示词明确告知：其产出将接受程序化测试评估——这一机制类似于开发者提交代码时触发 CI 测试。例如，若任务说明中指定了具体文件路径，则必须严格遵循，以确保解决方案能在自动化评分环节正常运行。强调边界条件（edge cases）的提示有助于智能体避免仅验证“理想路径”（happy path）；强制模型遵守测试规范，是一种行之有效的策略，可长期防止“质量滑坡”（slop buildup）。

3. **Time Budgeting:** We inject time budget warnings to nudge the agent to finish work and shift to verification. Agents are famously bad at time estimation so this heuristic helps in this environment. Real world coding usually doesn’t have strict time limits, but without adding any knowledge of constraints, agents won’t work within time bounds.

3. **时间预算管理：** 我们向智能体注入时间预算警告，以引导其及时收尾开发工作、转入验证阶段。众所周知，智能体在时间预估方面表现极差；该启发式策略正为此类环境而设。现实世界中的编程通常并无严苛时限，但若不显式注入对约束的认知，智能体便无法在规定时间内完成任务。

The more that agents know about their environment, constraints, and evaluation criteria, the better they can autonomously self-direct their work.

智能体对其所处环境、各类约束及评估标准了解得越充分，就越能自主、有效地规划并推进自身工作。

**The purpose of the harness engineer: prepare and deliver context so agents can autonomously complete work.**

**运行时框架工程师的核心职责：准备并精准交付上下文，使智能体得以自主完成任务。**

### Encouraging Agents to Step Back & Reconsider Plans

### 鼓励智能体适时退后、重新审视计划

Agents can be myopic once they’ve decided on a plan which results in “doom loops” that make small variations to the same broken approach (10+ times in some traces).

一旦智能体锁定了某个方案，便容易陷入视野狭窄的状态，进而导致“末日循环”（doom loops）——即反复对同一错误思路做微小调整（某些执行轨迹中甚至超过 10 次）。

We use a `LoopDetectionMiddleware` that tracks per-file edit counts via tool call hooks. It adds context like “…consider reconsidering your approach” after `N` edits to the same file. This can help agents recover from doom loops, though the model can continue down the same path if it thinks it’s correct.

我们采用 `LoopDetectionMiddleware`（循环检测中间件），借助工具调用钩子（tool call hooks）追踪各文件的编辑次数；当同一文件被修改达 `N` 次后，系统自动注入类似“……请考虑重新评估您的方法”的上下文提示。该机制有助于智能体从末日循环中恢复，但若模型仍确信原路径正确，也可能继续沿旧路前行。

Important note. This is a design heuristic that engineers around today’s perceived model issues. As models improve, these guardrails will likely be unnecessary, but today helps agents execute correctly and autonomously.

重要说明：这是一种面向当前模型能力局限所设计的启发式方案。随着模型能力持续提升，此类防护机制很可能不再必要；但在当下，它切实助力智能体更准确、更自主地执行任务。

### Choosing How Much Compute to Spend on Reasoning

### 如何权衡推理阶段的算力投入

# Reasoning models can run autonomously for hours so we have to decide how much compute to spend on every subtask. You can use the max reasoning budget on every task, but most work can benefit from optimizing reasoning compute spend.

推理模型可以自主运行数小时，因此我们必须决定在每个子任务上投入多少计算资源。你可以在每个任务中都使用最大推理预算，但大多数工作都能从优化推理计算资源的分配中获益。

## Terminal Bench timeout limits create a tradeoff. More reasoning helps agents evaluate each step, but can burn over `2x` more tokens/time. `gpt-5.2-codex` has 4 reasoning modes, `low`, `medium`, `high`, and `xhigh`.

## Terminal Bench 的超时限制带来权衡取舍：更多推理有助于智能体评估每一步，但也可能消耗超过 `2 倍` 的 token 数量/时间。`gpt-5.2-codex` 提供四种推理模式：`low`（低）、`medium`（中）、`high`（高）和 `xhigh`（超高）。

We found that reasoning helps with planning to fully understand the problem, some Terminal Bench tasks are very difficult. A good plan helps get to a working solution more quickly.

我们发现，推理对规划阶段大有裨益——有助于全面理解问题；部分 Terminal Bench 任务难度极高。一份良好的规划能帮助更快抵达可行解。

Later stage verification also benefits from more reasoning to catch mistakes and get a solution submitted. As a heuristic, we choose a xhigh-high-xhigh " **reasoning sandwich**" as a baseline.

后期验证阶段同样受益于更强的推理能力，以识别错误并最终提交解决方案。作为一种经验性策略，我们选择 `xhigh–high–xhigh` 的“**推理三明治**”结构作为基线方案。

![](images/improving-deep-agents-with-harness-engineering/img_005.png)_Spending more reasoning compute on planning and verification_

![](images/improving-deep-agents-with-harness-engineering/img_005.png)_在规划与验证阶段投入更多推理计算资源_

Running only at `xhigh` scored poorly at `53.9%` due to agent timeouts compared to `63.6%` at `high`. There weren’t large differences in trial runs across reasoning budget splits so we stuck with our approach which pushed the score to `66.5%`.

仅全程使用 `xhigh` 模式因智能体超时导致得分仅为 `53.9%`，而全程使用 `high` 模式则达 `63.6%`。在不同推理预算分配方案的多次试验中，性能差异并不显著，因此我们坚持采用当前方案，最终将得分提升至 `66.5%`。

The natural approach for models is **Adaptive Reasoning,** seen with [Claude](https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking?ref=blog.langchain.com) and [Gemini](https://ai.google.dev/gemini-api/docs/thinking?ref=blog.langchain.com) models where the model decides how much compute to spend on reasoning.

对模型而言，最自然的方式是采用**自适应推理（Adaptive Reasoning）**——这一机制已在 [Claude](https://platform.claude.com/docs/en/build-with-claude/adaptive-thinking?ref=blog.langchain.com) 和 [Gemini](https://ai.google.dev/gemini-api/docs/thinking?ref=blog.langchain.com) 等模型中实现，即由模型自主决定在推理过程中分配多少计算资源。

In a multi-model harness, balancing reasoning budgets could play out as using a large model for planning and [handing off](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs?ref=blog.langchain.com) to a smaller model for implementation.

在多模型协同框架（multi-model harness）中，推理预算的平衡可体现为：用大型模型负责规划，再通过[任务交接（handoff）](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs?ref=blog.langchain.com)交由小型模型执行具体实现。

## Practical Takeaways for Building Agent Harnesses

## 构建智能体协同框架（Agent Harnesses）的实用经验总结

The design space of agents is big. Here are some general principles from our experiments and building deepagents overall.

智能体的设计空间极为广阔。以下是我们通过实验及整体构建 deepagents 过程中总结出的一些通用原则。

1. **Context Engineering on Behalf of Agents.**  
1. **代表智能体开展上下文工程。**  
Context assembly is still difficult for agents today, especially in unseen environments. Onboarding models with context like directory structures, available tools, coding best practices, and problem solving strategies helps reduce the error surface for poor search and avoidable errors in planning.  
当前，智能体仍难以有效组装上下文，尤其在未见过的环境中。通过向模型注入上下文（例如目录结构、可用工具、编码最佳实践及问题求解策略）进行“入职引导”，有助于缩小因检索不佳导致的错误空间，并避免规划过程中的本可规避的错误。

2. **Help agents self-verify their work.**  
2. **助力智能体自主验证其工作成果。**  
Models are biased towards their first plausible solution. Prompt them aggressively to verify their work by running tests and refining solutions. This is especially important in autonomous coding systems that don’t have humans in the loop.  
模型天然倾向于采纳首个看似合理的解法。应积极提示模型通过运行测试、迭代优化方案等方式对其输出进行严格自检。这一点在无人参与闭环的自主编程系统中尤为关键。

3. **Tracing as a feedback signal.**  
3. **将追踪（Tracing）作为反馈信号。**  
Traces allow agents to self-evaluate and debug themselves. It’s important to debug tooling and reasoning together (ex: models go down wrong paths because they lack a tool or instructions how to do something).  
追踪记录使智能体能够自我评估与自主调试。必须将工具调用与推理逻辑协同调试（例如：模型走入错误路径，往往是因为缺少某项工具，或缺乏执行某项操作的具体指令）。

4. **Detect and fix bad patterns in the short term.**  
4. **短期内识别并修正不良行为模式。**  
Models today aren’t perfect. The job of the harness designer is to design around today’s shortcomings while planning for smarter models in the future. Blind retries and not verifying work are good examples. These guardrails will almost surely dissolve over time, but to build robust agent applications today, they’re useful tools to experiment with.  
当前的大模型尚不完美。Harness（智能体运行框架）设计者的职责，是在正视当下模型局限性的同时，为未来更强大的模型预留演进空间。盲目重试、跳过结果验证等即属典型缺陷模式。这类防护机制虽将在长期中逐步消解，但对当下构建鲁棒的智能体应用而言，仍是值得尝试的有效工具。

5. **Tailor Harnesses to Models.**  
5. **针对不同模型定制化设计 Harness。**  
The [Codex](https://developers.openai.com/cookbook/examples/gpt-5/codex_prompting_guide/?ref=blog.langchain.com) and [Claude](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices?ref=blog.langchain.com) prompting guides show that models require different prompting. A test run with Claude Opus 4.6 scored `59.6%` with an earlier harness version, competitive but worse than Codex because we didn’t run the same Improvement Loop with Claude. Many principles generalize like good context preparation and a focus on verification, but running a few rounds of harness iterations for your task helps maximize agent performance across tasks.  
[Codex](https://developers.openai.com/cookbook/examples/gpt-5/codex_prompting_guide/?ref=blog.langchain.com) 与 [Claude](https://platform.claude.com/docs/en/build-with-claude/prompt-engineering/claude-prompting-best-practices?ref=blog.langchain.com) 的提示工程指南均表明：不同模型需适配差异化的提示策略。在一次测试中，Claude Opus 4.6 使用早期版本 Harness 仅取得 `59.6%` 的得分——虽具竞争力，但仍逊于 Codex，原因正是我们尚未针对 Claude 同步运行相同的“改进循环”（Improvement Loop）。尽管诸多原则具有普适性（如优质上下文准备、强调结果验证），但围绕具体任务开展若干轮 Harness 迭代实验，方能最大化智能体在各类任务上的综合性能。

There’s more open research to do in harness design. Interesting avenues include multi-model systems (Codex, Gemini, and Claude together), memory primitives for continual learning so agents can autonomously improve on tasks, and measuring harness changes across models.  
Harness 设计领域仍有大量开放性研究亟待探索。值得关注的方向包括：多模型协同系统（如 Codex、Gemini 与 Claude 联合协作）、支持持续学习的记忆原语（memory primitives），以赋能智能体在任务中自主进化；以及跨模型量化评估 Harness 变更带来的影响。

For the outer loop of improving agents, we’re looking at methods like [RLMs](https://alexzhang13.github.io/blog/2025/rlm/?ref=blog.langchain.com) to more efficiently mine traces. We’ll be continuing work to improve the harness and openly share our research.  
在提升智能体的“外层优化循环”（outer loop）方面，我们正探索诸如 [RLMs](https://alexzhang13.github.io/blog/2025/rlm/?ref=blog.langchain.com) 等方法，以更高效地从运行轨迹中挖掘高价值反馈信息。我们将持续推进 Harness 的优化工作，并公开分享相关研究成果。

We created [a dataset of our Traces](https://smith.langchain.com/public/29393299-8f31-48bb-a949-5a1f5968a744/d?tab=2&ref=blog.langchain.com) to share with the community.  
我们构建了 [一份追踪数据集（Traces Dataset）](https://smith.langchain.com/public/29393299-8f31-48bb-a949-5a1f5968a744/d?tab=2&ref=blog.langchain.com)，面向社区开放共享。

Deep Agents is open source. [Python](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) and [Javascript](https://github.com/langchain-ai/deepagentsjs?ref=blog.langchain.com).  
Deep Agents 开源项目已发布：[Python 版本](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) 与 [JavaScript 版本](https://github.com/langchain-ai/deepagentsjs?ref=blog.langchain.com)。

**To more hill climbing and open research.**  
**迈向更高效的爬山式优化与开放研究。**