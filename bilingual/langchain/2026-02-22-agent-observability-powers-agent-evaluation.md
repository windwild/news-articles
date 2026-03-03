---
title: "Agent Observability Powers Agent Evaluation"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-observability-powers-agent-evaluation/"
date: "2026-02-22"
scraped_at: "2026-03-02T10:08:09.378484650+00:00"
language: "en-zh"
translated: true
description: "You can't build reliable agents without understanding how they reason, and you can't validate improvements without systematic evaluation."
---

**TL;DR**

**简言之**

- 你无法预知智能体（agent）的行为，除非真正运行它——这意味着智能体可观测性（agent observability）与软件可观测性（software observability）本质不同，且更为关键；  
- 智能体常执行复杂、开放式的任务，因此对其评估方式也不同于传统软件的评估；  
- 由于追踪记录（traces）完整呈现了智能体行为实际涌现的过程，它们以多种方式支撑并驱动评估工作。

When something goes wrong in traditional software, you know what to do: check the error logs, look at the stack trace, find the line of code that failed. But AI agents have changed what we're debugging. When an agent takes 200 steps over two minutes to complete a task and makes a mistake somewhere along the way, that’s a different type of error. There’s no stack trace — because there’s no code that failed. What failed was the agent’s reasoning.

当传统软件出错时，你清楚该怎么做：查看错误日志、分析堆栈跟踪（stack trace）、定位失败的代码行。但 AI 智能体已彻底改变了我们所调试的对象。当一个智能体耗时两分钟、历经 200 步才完成一项任务，却在中途某处出错，这便属于一种全新类型的错误——它没有堆栈跟踪，因为根本不存在“崩溃的代码”；真正失效的是智能体自身的推理过程。

## From debugging code to debugging reasoning

## 从调试代码到调试推理

You still write code to define your agent, e.g. which tools exist, what data is available. You write prompts and tool descriptions to guide the agent's behavior, but you won't know how the LLM will interpret these instructions until you run it. The source of truth thus shifts from code to traces that show what the agent actually did.

你仍需编写代码来定义智能体，例如指定可用的工具、可访问的数据等；你也需撰写提示词（prompts）和工具描述，以引导智能体行为。但直到真正运行大语言模型（LLM）之前，你都无法确定它将如何解读这些指令。因此，“真相来源”（source of truth）已从静态代码，转向动态的追踪记录——即智能体实际执行行为的完整留痕。

[Agent engineering is an iterative process](https://blog.langchain.com/agent-engineering-a-new-discipline/), and tracing + evaluation are how you close the loop. In this post, we'll explore why agent observability and evaluation are fundamentally different from traditional software, what new primitives and practices you need, and how observability powers evaluation in ways that make them inseparable.

[智能体工程是一项迭代式工程](https://blog.langchain.com/agent-engineering-a-new-discipline/)，而追踪（tracing）与评估（evaluation）正是实现这一闭环的关键环节。本文将深入探讨：为何智能体可观测性与评估方法从根本上区别于传统软件；你需要哪些全新的基础构件（primitives）与实践范式；以及可观测性如何以多种方式赋能评估，使二者密不可分。

## Agent observability ≠ software observability

## 智能体可观测性 ≠ 软件可观测性

Pre-LLMs, software was largely deterministic — given the same input, you'd get the same output. Logic was codified. You could read the code and know exactly how the system behaved. When something went wrong, logs pointed you to which service or function failed, then you'd go back to the code to understand why it happened and fix it.

在大语言模型出现之前，软件系统总体上是确定性的——相同输入必然产生相同输出；逻辑被明确编码进程序中；你只需阅读源码，即可精准掌握系统行为。一旦出错，日志会直接指向发生故障的服务或函数，你便可回溯代码，查明原因并修复问题。

**AI agents break the assumptions of determinism and code as a source of truth.** As we're moving from traditional software to LLM applications to agents, each step introduces more uncertainty. LLM apps make a single call to an LLM with context, introducing natural language's inherent "fuzziness" but remain constrained to one LLM call.

**AI 智能体打破了“确定性”与“代码即真理”的基本假设。** 随着我们从传统软件迈向 LLM 应用，再进一步迈向智能体系统，每一步都显著增加了不确定性。LLM 应用通常仅对大语言模型发起一次带上下文的调用，虽引入了自然语言固有的“模糊性”，但仍受限于单次调用的边界。

However, **agents call LLMs and tools in a loop until they determine a task is done** — and can reason across dozens or hundreds of steps, calling tools, maintaining state, and adapting behavior based on context. When building an agent, you attempt to recommend the application logic in code and prompts. But you don't know what this logic will do until actually running the LLM.

然而，**智能体则持续循环调用 LLM 和各类工具，直至自主判定任务完成**——其推理过程可能跨越数十乃至数百步：其间调用工具、维护状态、并依据上下文动态调整行为。在构建智能体时，你试图通过代码与提示词来“建议”应用逻辑；但该逻辑究竟如何运作，唯有在真正运行 LLM 后才能揭晓。

![](images/agent-observability-powers-agent-evaluation/img_001.png)Traditional software vs. LLM apps vs. Agents

![](images/agent-observability-powers-agent-evaluation/img_001.png)传统软件 vs. 大语言模型应用（LLM apps）vs. 智能体（Agents）

When something goes wrong, you're not finding a single line of code that failed. Instead, you're asking:

当出现问题时，你无法定位到某一行出错的代码；相反，你需要追问：

- Why did the agent decide to call `edit_file` instead of `read_file` at step 23 of 200?  
- 在总共 200 步的执行流程中，第 23 步为何智能体选择调用 `edit_file` 而非 `read_file`？

- What context and prompt instructions informed that decision?  
- 是哪些上下文信息和提示词指令影响了该决策？

- Where in this two-minute, 200-step trajectory did the agent go off track?  
- 在这段持续两分钟、共 200 步的执行轨迹中，智能体究竟在哪个环节偏离了正轨？

Traditional tracing tools can't answer these questions. A 200-step trace is too large for a human to parse, and traditional traces don't capture the reasoning context behind each decision; they only capture which services were called and how long each took.

传统的追踪工具无法回答这些问题。一份包含 200 步的追踪日志对人类而言过于庞大而难以解析；更重要的是，传统追踪仅记录调用了哪些服务及各服务耗时，却完全无法捕获支撑每项决策背后的推理上下文。

## Agent evaluation ≠ software evaluation

## 智能体评估 ≠ 软件评估

Traditional software testing relies on deterministic assertions: write tests that check `output == expected_output`, verify they pass, then ship. Online evaluation (A/B tests, product analytics) measures business impact separately. Evaluating agents differ from evaluating software in a few key ways:

传统软件测试依赖确定性的断言：编写测试用例验证 `output == expected_output`，确认通过后即可发布。线上评估（如 A/B 测试、产品数据分析）则单独衡量业务影响。而智能体的评估与软件评估存在若干关键差异：

**1\. You're testing reasoning, not code paths**

**1. 你评估的是推理能力，而非代码路径**

Traditional software has tests at different levels of granularity (unit, integration, e2e), testing deterministic code paths you can read and modify. Agents also need testing at different levels, but you're no longer testing code paths — you're testing reasoning:

传统软件拥有不同粒度的测试（单元测试、集成测试、端到端测试），用于验证可读、可修改的确定性代码路径。智能体同样需要分层测试，但此时你不再检验代码路径——而是检验其推理能力：

- **Single-step**: Did the agent make the right decision at this moment?  
- **单步评估**：智能体在此刻是否做出了正确决策？

- **Full-turn**: Did the agent perform well in an end-to-end execution?  
- **完整回合评估**：智能体在一次端到端执行中表现是否良好？

- **Multi-turn**: Did the agent maintain context across a conversation?  
- **多轮对话评估**：智能体能否在整段对话中持续保持上下文一致性？

**2\. Production becomes your primary teacher**

**2. 线上生产环境成为你最主要的“老师”**

In traditional software, you can catch most correctness issues with offline tests (unit tests, integration tests, staging). You still test in production through canary deployments and feature flags, but the goal is to catch edge cases and integration issues you missed.

在传统软件中，你可通过离线测试（单元测试、集成测试、预发布环境测试）捕获大多数正确性问题。你仍会通过灰度发布和功能开关在生产环境中进行测试，但其目标是发现那些被遗漏的边界情况和集成问题。

With agents, production plays a different role. Because every natural language input is unique, you can't anticipate how users will phrase requests or what edge cases exist. Production traces reveal failure modes you couldn't have predicted and help you understand what "correct behavior" actually looks like for real user interactions.

而对于智能体（agents），生产环境扮演着截然不同的角色。由于每一条自然语言输入都是独一无二的，你无法预先判断用户将如何表述请求，也无法穷举所有潜在的边界情况。生产环境中的追踪记录（traces）会揭示出你根本无法预测的失败模式，并帮助你真正理解：在真实用户交互场景下，“正确的行为”究竟意味着什么。

This shifts how you think about evaluation: **production isn't just where you catch missed bugs. It's where you discover what to test for offline.** Production traces become test cases, and your evaluation suite grows continuously from real-world examples, not just engineered scenarios.

这从根本上改变了你对评估（evaluation）的认知：**生产环境不只是用于捕获被遗漏缺陷的地方；它更是你发现“究竟该为哪些场景编写离线测试”的源头。** 生产环境中的追踪记录本身即成为测试用例，你的评估套件由此持续从真实世界案例中自动扩充，而不再仅依赖人工设计的模拟场景。

## The primitives of agent observability

## 智能体可观测性的基础构件

Agent observability uses three core primitives to capture non-deterministic reasoning:

智能体可观测性采用三个核心基础构件，以捕捉非确定性的推理过程：

- **Runs**: A single execution step (one LLM call with its input/output)  
- **Runs（执行步）**：一次独立的执行步骤（即一次大语言模型调用及其输入与输出）

- **Traces**: A complete agent execution showing all runs and their relationships  
- **Traces（追踪）**：一次完整的智能体执行过程，展示其中全部执行步及其相互关系

- **Threads**: Multi-turn conversations grouping multiple traces over time  
- **Threads（会话线程）**：跨多轮交互的对话，按时间顺序聚合多个追踪记录

These use the same concepts as traditional observability (e.g. traces, spans) but capture reasoning context rather than service calls and timing

这些概念沿用了传统可观测性（例如 trace、span）的术语体系，但其关注点不再是服务调用链路与耗时，而是智能体内部的推理上下文。

### Runs: capturing what the LLM did at a single step

### Runs：记录大语言模型在单一步骤中的行为

A [run](https://docs.langchain.com/langsmith/observability-concepts?ref=blog.langchain.com#runs) captures a single execution step. This is most useful for capturing how the LLM behaved at a particular point in time. This captures the complete prompt for an LLM call, including all instructions, tools used, and context.

一个 [run](https://docs.langchain.com/langsmith/observability-concepts?ref=blog.langchain.com#runs) 记录一次独立的执行步骤。它最适用于刻画大语言模型在某一特定时刻的行为表现。该记录完整保存了某次大语言模型调用所使用的全部提示词（prompt），包括所有指令、调用的工具以及上下文信息。

These runs serve dual purposes:  
这些执行步具有双重作用：

![](images/agent-observability-powers-agent-evaluation/img_002.png)Example of an agent run and its components

![](images/agent-observability-powers-agent-evaluation/img_002.png)代理运行示例及其组成部分

- **For debugging**: See exactly what the agent was thinking at any step. What was in the prompt? What tools were available? Why did it choose this action?  
- **用于调试**：精确查看代理在每一步的思考过程。提示词（prompt）内容是什么？有哪些可用工具？为何选择此操作？

- **For evaluation**: Write assertions against this run. Did the agent call the right tool? With the right arguments?  
- **用于评估**：针对本次运行编写断言。代理是否调用了正确的工具？是否传入了正确的参数？

### Traces: capturing trajectories

### 追踪（Traces）：记录推理轨迹

A trace captures a complete agent execution by linking together all the runs that occurred. A reasoning trace captures:  

一个追踪（trace）通过串联所有发生的运行（runs），完整记录一次代理执行过程。一次推理追踪包含：

- All information about what goes into the model at each step, captured as runs that make up the trace  
- 每一步输入模型的全部信息，以构成该追踪的若干次运行（runs）形式记录  

- **All tool calls** with their arguments and results  
- **全部工具调用**，包括其参数与返回结果  

- **The nested structure** showing how steps relate to each other  
- **嵌套结构**，清晰展现各步骤之间的层级与依赖关系  

Agent traces are massive. While a typical distributed trace might be a few hundred bytes, agent traces can be orders of magnitude larger. For complex, long-running agents, traces can reach hundreds of megabytes. This context is necessary for debugging and evaluating the agent's reasoning.  

代理追踪数据量极为庞大。典型的分布式追踪（distributed trace）通常仅数百字节，而代理追踪则可能大出数个数量级；对于复杂、长时间运行的代理，单次追踪体积可达数百兆字节。此类上下文信息对调试和评估代理的推理过程至关重要。

![](images/agent-observability-powers-agent-evaluation/img_003.png)Example trace and its components

![](images/agent-observability-powers-agent-evaluation/img_003.png)追踪示例及其组成部分

### Threads: multi-turn conversation context

### 对话线程（Threads）：多轮对话上下文

A single trace captures one agent execution, but agents often operate across **sessions** involving multiple interactions with a user or system. A [thread](https://docs.langchain.com/langsmith/threads?ref=blog.langchain.com) groups multiple agent executions (traces) into a single conversational session, preserving:  

单次追踪仅记录一次代理执行，但代理通常需跨越多个**会话（sessions）**，持续与用户或系统进行多轮交互。[对话线程（thread）](https://docs.langchain.com/langsmith/threads?ref=blog.langchain.com) 将多次代理执行（即多个追踪）聚合为一个完整的对话会话，并保留以下关键信息：

- **Multi-turn context**: All interactions between user and agent in chronological order  
- **多轮上下文**：按时间顺序完整记录用户与代理之间的全部交互  

- **State evolution**: How the agent's memory, files, or other artifacts changed across turns  
- **状态演进**：代理的记忆、文件或其他中间产物在各轮交互中的变化过程  

- **Time span**: Conversations can last minutes, hours, or days  
- **时间跨度**：对话可持续数分钟、数小时乃至数天

![](images/agent-observability-powers-agent-evaluation/img_004.png)  
![](images/agent-observability-powers-agent-evaluation/img_004.png)  
Example of a thread capturing multiple turns of conversation  

一段对话线程（thread）捕获多轮交互的示例  

Consider debugging a coding agent that worked fine for 10 turns but suddenly started making mistakes in turn 11. The turn 11 trace in isolation might show the agent calling a reasonable tool. But when you examine the full thread, you discover that in turn 6 the agent updated its memory with an incorrect assumption, and by turn 11 that bad context had compounded into buggy behavior.  

试想调试一个编程智能体（coding agent）：它在前 10 轮交互中表现正常，却在第 11 轮突然开始出错。若仅孤立地查看第 11 轮的追踪记录（trace），可能显示该智能体调用了完全合理的工具；但当你审视整条对话线程时，便会发现——早在第 6 轮，该智能体已将一个错误假设写入其记忆；至第 11 轮，这一错误上下文已不断累积、放大，最终导致了异常行为。  

Threads are essential for understanding how agent behavior evolves over time and how context accumulates (or degrades) across interactions.  

对话线程（threads）对于理解智能体行为如何随时间演化、以及上下文如何在多轮交互中持续累积（或逐渐劣化）至关重要。  

## How this influences agent evaluation  

## 这对智能体评估方式的影响  

Agent behavior only emerges at runtime, and is only captured by observability (runs, traces, and threads). This means that to evaluate behavior you need to evaluate your observability data. This raises two key questions:  

智能体的行为仅在运行时显现，并且只能通过可观测性数据（即 runs、traces 和 threads）加以捕获。这意味着：要评估智能体的行为，就必须评估其可观测性数据。这引出了两个关键问题：  

- At what granularity do you evaluate agents? At the run, trace, or thread level?  
- 应在何种粒度上评估智能体？是单次运行（run）、单次完整追踪（trace），还是整条对话线程（thread）层面？  

- When do you evaluate agents? If behavior only emerges when you run the agents, can you evaluate them offline in the same way you do software?  
- 何时开展智能体评估？如果行为仅在实际运行智能体时才显现，那么能否像评估传统软件那样，在离线状态下完成评估？  

### Evaluations agents at different levels of granularity  

### 在不同粒度层级上评估智能体  

**You can evaluate agents at different levels of granularity, which map 1:1 to the observability primitives.** What you're evaluating determines which primitive you need:  

**你可以按不同粒度层级评估智能体，而这些层级与可观测性基础单元（primitives）一一对应。** 具体评估目标决定了你需要采用哪一类基础单元：  

- **Single-step evaluation** validates individual runs → Did the agent make the right decision at a specific step?  
- **单步评估（Single-step evaluation）** 验证单次运行（run）→ 智能体在特定步骤是否做出了正确决策？  

- **Full-turn evaluation** validates complete traces → Did the agent execute the full task correctly?  
- **全轮评估（Full-turn evaluation）** 验证完整追踪（trace）→ 智能体是否正确执行了整个任务？  

- **Multi-turn evaluation** validates threads → Did the agent maintain context across a conversation?  
- **多轮评估（Multi-turn evaluation）** 验证对话线程（thread）→ 智能体是否在整场对话中有效维持了上下文一致性？  

![](images/agent-observability-powers-agent-evaluation/img_005.png)  
![](images/agent-observability-powers-agent-evaluation/img_005.png)  
Single step vs. full turn vs. multi-turn evaluation patterns  

单步评估 vs. 全轮评估 vs. 多轮评估模式

1. **Single-step evaluation: unit tests for decisions**

1. **单步评估：针对决策的单元测试**

Sometimes, you need to validate a specific decision point without running the entire agent. You may want to see if the agent choose the right tool in a specific scenario, or whether it used the correct arguments.

有时，您需要在不运行整个智能体（agent）的情况下，验证某个特定的决策点。例如，您可能希望确认该智能体在特定场景下是否选择了正确的工具，或是否使用了正确的参数。

![](images/agent-observability-powers-agent-evaluation/img_006.png)

![](images/agent-observability-powers-agent-evaluation/img_006.png)

This is like a unit test for agent reasoning: set up a specific state (conversation history, available tools, current task), run the agent for one step, and assert that it made the right decision. Single-step evaluation validates runs, i.e. individual LLM calls.

这类似于对智能体推理过程进行的单元测试：设定一个特定状态（如对话历史、可用工具、当前任务），仅让智能体执行一步，并断言其作出了正确决策。单步评估所验证的是“运行”（run），即单次大语言模型（LLM）调用。

**Example: Testing a calendar agent's tool selection**

**示例：测试日历智能体的工具选择**

A scheduling agent needs to find available meeting times before scheduling. You want to verify it checks availability first rather than immediately trying to create the meeting:

一个日程安排智能体需先查找可用会议时段，再执行预约。您希望验证它是否优先调用检查可用性的工具，而非直接尝试创建会议：

Your single-step test:

您的单步测试如下：

1. Setup state: Conversation history = user said "Schedule a meeting with Harrison tomorrow morning", available tools = \[`find_meeting_times`, `schedule_meeting`, `send_email`\]  
1. 设定状态：对话历史 = 用户说“明天上午与Harrison安排一次会议”，可用工具 = \[`find_meeting_times`, `schedule_meeting`, `send_email`\]

2. Run one step: Agent generates next action  
2. 执行一步：智能体生成下一步动作

3. Assert: Agent chose `find_meeting_times` (not `schedule_meeting`)  
3. 断言：智能体选择了 `find_meeting_times`（而非 `schedule_meeting`）

**Why you need runs**: Single step tests often come from real production cases that error. In order to recreate these, you need the exact state of the agent before that step. Detailed run captures are the only way to get this!

**为何需要“运行”（runs）记录**：单步测试通常源自真实生产环境中发生的错误案例。为准确复现这些错误，您必须还原该步骤发生前智能体的精确状态。而详尽的运行过程捕获（detailed run captures）是获取该状态的唯一途径！

Single-step evaluations are efficient and catch regressions at individual decision points. In practice, about half of agent test suites use these single-step tests to isolate and validate specific reasoning behaviors without the overhead of full agent execution.

单步评估效率高，能精准捕捉各个决策点上的回归问题。实践中，约一半的智能体测试套件采用此类单步测试，以在无需完整执行智能体的前提下，隔离并验证特定的推理行为。

**2. Full-turn evaluation: end-to-end trajectory assessment**

**2. 全流程评估：端到端轨迹评估**

Other times, you need to see a complete agent execution. Full-turn evaluation validates traces, i.e. complete agent executions with all their runs, and let you test multiple dimensions:

有时，您需要观察智能体（agent）的完整执行过程。全流程评估用于验证“追踪记录”（traces），即包含所有运行步骤的完整智能体执行过程，从而支持您从多个维度开展测试：

**Trajectory**: Did the agent call the necessary tools? For a coding agent fixing a bug, you might assert: "The agent should have called `read_file`, then `edit_file`, then `run_tests`." The exact sequence might vary, but certain tools must be called.

**轨迹（Trajectory）**：智能体是否调用了必需的工具？例如，针对一个修复代码缺陷的编程智能体，您可设定断言：“该智能体应依次调用 `read_file`、`edit_file` 和 `run_tests`。”具体调用顺序可能略有差异，但某些关键工具必须被调用。

**Final response**: Was the output correct and helpful? For open-ended tasks like research or coding, the quality of the final answer often matters more than the specific path taken.

**最终响应（Final response）**：输出结果是否正确且具有帮助性？对于研究、编程等开放式任务而言，最终答案的质量往往比其生成路径本身更为重要。

**State changes**: Did the agent create the right artifacts? For a coding agent, you'd inspect the files it wrote and verify they contain the correct code. For an agent with memory, you'd check that it stored the right information.

**状态变更（State changes）**：智能体是否生成了正确的产物（artifacts）？例如，对编程智能体，您需检查其编写的文件，并确认其中包含正确的代码；对具备记忆能力的智能体，则需验证其是否存储了恰当的信息。

![](images/agent-observability-powers-agent-evaluation/img_007.png)

![](images/agent-observability-powers-agent-evaluation/img_007.png)

Testing that an agent remembers user preferences also requires validating three things:

验证智能体是否能记住用户偏好，同样需检验以下三个方面：

1. Trajectory: Did the agent call `edit_file` on its memory file?  
   1. 轨迹：智能体是否对其记忆文件调用了 `edit_file`？  
2. Final response: Did the agent confirm the update to the user?  
   2. 最终响应：智能体是否向用户确认了此次更新？  
3. State: Does the memory file actually contain the preference?  
   3. 状态：该记忆文件中是否确实存有该用户偏好？

Each assertion requires different parts of the trace. You can't evaluate these dimensions without capturing the full trajectory and state changes.

每一项断言均依赖追踪记录（trace）中的不同部分。若未完整捕获整个执行轨迹及状态变更，便无法对上述任一维度进行有效评估。

**3. Multi-turn evaluation: realistic conversation flows**

**3. 多轮次评估：贴近真实的对话流程**

Some agent behaviors only emerge over multiple turns. The agent might maintain context correctly for 5 turns but fail on turn 6, or handle individual requests fine but struggle when requests build on each other.

某些智能体行为仅在多轮交互中才会显现。例如，智能体可能在前 5 轮中正确维持上下文，却在第 6 轮失败；或能单独处理每个请求，但在请求之间存在依赖关系（即后续请求基于先前对话展开）时表现不佳。

Multi-turn evaluation validates threads, i.e. conversational sessions with multiple agent executions. You test whether the agent accumulates context correctly, maintains state across turns, and handles conversational flows that build on previous exchanges.

多轮评估用于验证“会话线程”（thread），即包含多次智能体执行的完整对话会话。你借此检验智能体是否能正确累积上下文、在多轮交互中持续维护状态，并妥善处理前后关联、层层递进的对话流程。

![](images/agent-observability-powers-agent-evaluation/img_008.png)

![](images/agent-observability-powers-agent-evaluation/img_008.png)

For example, testing context persistence:

例如，测试上下文持久性：

- Turn 1: User shares a preference ("I prefer Python over JavaScript")  
- Turn 2: User asks a question building on that ("Show me an example")  
- Turn 3: Test that preference persists ("Write a script for this")

- 第 1 轮：用户表达偏好（“我更喜欢 Python 而非 JavaScript”）  
- 第 2 轮：用户基于该偏好提出问题（“给我一个示例”）  
- 第 3 轮：验证该偏好是否持续生效（“为此编写一个脚本”）

The agent should provide Python examples in turns 2 and 3, not JavaScript. This requires maintaining context across turns.

智能体应在第 2 轮和第 3 轮均提供 Python 示例，而非 JavaScript 示例。这要求其在各轮次间持续、准确地维持上下文。

The challenge is keeping multi-turn tests on rails. If the agent deviates from the expected path in turn 1, your hardcoded turn 2 input might not make sense. Use conditional logic to check the agent's output after each turn, and fail early if it goes off track.

挑战在于确保多轮测试始终处于可控轨道上。若智能体在第 1 轮就偏离预期路径，则你预设的第 2 轮输入可能已失去意义。应使用条件逻辑，在每轮执行后校验智能体输出；一旦发现偏离，立即终止测试（fail fast）。

Multi-turn evaluation requires threads to group multiple agent executions (traces) into a single conversation. When a multi-turn test fails, you need the thread showing all turns to understand what went wrong and where.

多轮评估需依托“线程”（thread）机制，将多次智能体执行（即多个 trace）聚合为一次完整对话。当多轮测试失败时，你必须能查看涵盖全部轮次的完整线程，才能准确定位问题发生的位置及根本原因。

### How to choose what granularity to evaluate your agent at

### 如何选择对智能体进行评估的粒度

There is no single right way to choose which granularity to evaluate agents at. Some heuristics we’ve seen:

并不存在唯一正确的粒度选择方式。我们观察到以下一些经验性指导原则：

- **It’s often easiest to come up with inputs for trace-level evals (full-turn).**  
- **迹级评估（完整轮次）的输入通常最容易设计。**  
These are inputs to your agent, so it’s pretty easy (and necessary) to come up with expected inputs. That being said, it can be harder to come up with expected outputs and/or a way to validate those programmatically. This means there may be some period time of where you automate the running of the agent over these datapoints, but not the scoring.  
这些输入即提供给智能体（agent）的输入，因此设计预期输入相对容易（且必要）。但与此同时，设计预期输出、或以编程方式自动验证这些输出，则往往更具挑战性。这意味着，在一段时间内，你可能已实现对智能体在这些数据点上运行过程的自动化，但尚未实现评分环节的自动化。

- **It’s easiest to fully automate the scoring of run-level evals (single-step).**  
- **运行级评估（单步）的评分最易实现完全自动化。**  
This is just a single model call, and often times can be evaluated by checking with tools were called. One word of caution: depending on how frequently you are changing the internals of your agent (which tools are available, the right sequence to call tools) these evaluations may get out of date quickly and require updating. For this reason, we generally see teams building these only after the general agent architecture is relatively stable.  
这仅涉及一次模型调用，通常可通过检查所调用的工具来完成评估。需注意一点：若你频繁变更智能体内部逻辑（例如可用工具集合、调用工具的正确顺序等），此类评估可能迅速过时，需持续更新。正因如此，我们通常观察到团队仅在智能体整体架构趋于稳定后，才开始构建这类评估。

- **Thread-level evals are hard to implement effectively (multi-turn).**  
- **会话级评估（多轮次）难以高效落地实施。**  
They involve coming up with a sequence of inputs, but often times that sequence only makes sense if the agent behaves a certain way between inputs. They are also hard to evaluate automatically. This is least common type of evaluation that we see.  
它要求设计一组输入序列，而该序列往往仅在智能体于各输入之间表现出特定行为时才有意义。此外，此类评估也极难实现自动化。这是我们所见最少见的一类评估。

![](images/agent-observability-powers-agent-evaluation/img_009.png)

Most production agents use a combination: full-turn tests for core workflows, single-step tests for known failure modes discovered in production, and multi-turn tests for stateful interactions.  
大多数生产环境中的智能体采用组合式评估策略：使用完整轮次测试覆盖核心工作流，使用单步测试覆盖生产中已发现的已知失效模式，使用多轮次测试覆盖有状态交互场景。

### When to evaluate an agent  
### 何时评估智能体  

Agent behavior doesn’t fully emerge until you run it in production, which means that **when** you evaluate agents also differs from traditional software.  
智能体的行为特性往往只有在生产环境中实际运行时才会充分显现，这意味着评估智能体的**时机**也与传统软件存在显著差异。

- **Offline evaluation:** This is the equivalent of running unit tests before shipping. To run these tests, you’ll want to collect a dataset of inputs and, optionally, ground truth outputs to compare against. Depending on the cost to run and evaluate the agent over this dataset, you may run these evals on every commit, or just before you push to prod. If you are running offline evals frequently, you will want to set up some sort of caching so that you’re not calling the model unnecessarily. _Note: when most people talk about “evaluation”, offline evals are the primary type of evaluation they are likely referring to._  
- **离线评估：** 这相当于发布前执行单元测试。为运行此类测试，你需要收集一组输入数据集，并可选地准备对应的标准答案（ground truth outputs）用于比对。根据在此数据集上运行和评估智能体的成本高低，你可选择每次提交代码时都运行这些评估，或仅在推送至生产环境前执行。若频繁运行离线评估，建议设置某种缓存机制，避免不必要的模型调用。_注：当多数人提及“评估（evaluation）”时，通常主要指的就是这类离线评估。_

- **Online evaluation**: Since you don’t know how the agent will perform until you run it, you may want to run evaluations “online”, as the agent runs on production data. When doing this, these evaluators definitionally need to be “ [reference free](https://docs.langchain.com/langsmith/evaluation-concepts?ref=blog.langchain.com#reference-free-vs-reference-based-evaluators)”. Online evaluators typically run on ingestion of production data.  
- **在线评估：** 由于你无法预知智能体的实际表现，因此可在其处理真实生产数据的过程中同步开展“在线”评估。此时，评估器在定义上必须是“[无参考式（reference-free）](https://docs.langchain.com/langsmith/evaluation-concepts?ref=blog.langchain.com#reference-free-vs-reference-based-evaluators)”。在线评估器通常在生产数据被接入系统时即刻触发运行。

- **Ad-hoc evaluation**: Agents are very unbounded in their inputs and behavior, so you don’t always know ahead of time what you want to test for. If you have a lot of traces in production, you may want to test them **after** they have already been ingested. This exploratory data analysis can be crucial for understanding your agents. Systems like [Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) in LangSmith can help you do this.  
- **临时性评估（Ad-hoc evaluation）：** 智能体的输入与行为具有高度开放性，因此你未必总能在事前明确需要测试的具体方向。若你在生产环境中已积累大量追踪记录（traces），则可考虑在其完成接入后**再**进行针对性测试。这种探索性数据分析对于深入理解智能体行为至关重要。LangSmith 中的 [Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com) 等系统可为此类分析提供有力支持。

![](images/agent-observability-powers-agent-evaluation/img_010.png)

The key shift: **offline evaluation is necessary but not sufficient.** Evaluating your agents in production is important because you can't anticipate all the ways users will interact with your agent.  
关键转变在于：**离线评估虽必不可少，却远不足够。** 在生产环境中评估智能体至关重要，因为你无法穷尽预测用户与智能体交互的所有方式。

## How agent observability powers agent evaluation  
## 智能体可观测性如何赋能智能体评估  

The traces you generate for observability are the same traces that power your evaluations, forming a unified foundation.  
你为实现可观测性所生成的追踪记录（traces），也正是驱动各类评估任务的数据基础——二者共享同一套统一的数据根基。

![](images/agent-observability-powers-agent-evaluation/img_011.png)

### Traces → manual debugging

### 追踪（Traces）→ 手动调试

When you are running an agent locally on ad hoc queries and manually inspecting the results - that is still a form of (manual) evaluation! Traces power this workflow as they allow you to step into every step of the process and figure out exactly what when wrong.

当你在本地针对临时查询（ad hoc queries）运行智能体，并手动检查结果时——这本身仍是一种（人工）评估方式！追踪功能支撑这一工作流，因为它让你能够深入到流程的每一步，精准定位问题发生的位置。

### Traces → offline evaluation datasets

### 追踪（Traces）→ 离线评估数据集

Production traces become your evaluation dataset automatically. For example, when a user reports a bug, you can see in the trace: the exact conversation history and context, what the agent decided at each step, and where specifically it went wrong.

生产环境中的追踪记录会自动成为你的评估数据集。例如，当用户报告一个缺陷时，你可在对应追踪中清晰看到：完整的对话历史与上下文、智能体在每一步所作的决策，以及它具体在哪个环节出错。

**An example workflow:**

**一个典型工作流示例：**

1. User reports incorrect behavior  
   1. 用户报告行为异常  
2. Find the production trace  
   2. 查找对应的生产环境追踪记录  
3. Extract the state at the failure point  
   3. 提取失败点处的完整状态  
4. Create a test case from that exact state  
   4. 基于该精确状态构建测试用例  
5. Fix and validate  
   5. 修复问题并验证  

Thus, your test suite for offline evaluation can be formed from real data points.

因此，你的离线评估测试套件可直接由真实生产数据点构建而成。

### Traces → online evaluation

### 追踪（Traces）→ 在线评估

The same traces generated for debugging power continuous production validation. Online evaluations run on traces you're already capturing. You can run checks on every trace or sample strategically:

用于调试所生成的相同追踪记录，同样可支撑持续性的生产环境验证。在线评估直接基于你已在采集的追踪数据运行；你可以对每一条追踪执行检查，也可按需进行策略性采样：

- **Trajectory checks**: Flag unusual tool call patterns  
- **轨迹检查**：标记异常的工具调用模式  

- **Efficiency monitoring**: Detect performance degradation trends  
- **效率监控**：识别性能下降趋势  

- **Quality scoring**: Run LLM-as-judge on production outputs  
- **质量评分**：在生产输出上运行“大语言模型作为裁判”（LLM-as-judge）  

- **Failure alerts**: Surface errors before user reports  
- **故障告警**：在用户上报前主动暴露错误  

This surfaces issues in real-time, validating that development behavior holds in production.  
这能够实时暴露问题，验证开发阶段所观察到的行为在生产环境中依然成立。

### Traces → ad-hoc insights  
### 追踪数据 → 即席洞察  

When a trace contains 100,000+ lines of data or a thread spans dozens of turns, manual inspection becomes impossible. This is where AI-assisted analysis helps you query traces and threads to:  
当一条追踪（trace）包含超过 10 万行数据，或一次对话线程（thread）跨越数十轮交互时，人工检查便不再可行。此时，AI 辅助分析可帮助你对追踪与线程发起查询，从而实现：

- Surface usage patterns across many agent executions  
- 挖掘大量智能体（agent）执行过程中的共性使用模式  

- Identify common failure modes and inefficiencies  
- 识别高频失败模式与低效行为  

- Explain specific decisions: "Why did the agent call this tool at this step?"  
- 解释特定决策：“为何智能体在此步骤调用了该工具？”  

- Compare successful vs. failed executions to find patterns  
- 对比成功与失败的执行案例，发现潜在规律  

For example, recently we were investigating why an agent was taking inefficient paths. Instead of manually reading 150-step traces, we used an AI assistant which identified that the agent was calling `read_file` multiple times on the same file instead of storing content in context. The fix was a simple prompt adjustment (whereas spotting this pattern manually would have taken hours).  
例如，我们近期曾调查某智能体为何总选择低效路径。与其人工通读长达 150 步的追踪日志，我们转而借助 AI 助手进行分析——结果发现，该智能体反复对同一文件调用 `read_file` 工具，却未将文件内容缓存至上下文。最终仅需微调提示词（prompt）即可修复；若靠人工识别这一模式，则可能耗费数小时。

## What this means for teams building agents  
## 对构建智能体的团队而言，这意味着什么  

The teams shipping reliable agents have embraced the shift from debugging code to debugging reasoning. Traditional software separated tracing (for debugging) and testing (for validation). Now that we're debugging non-deterministic reasoning across long-running, stateful processes, these practices converge. You need reasoning traces to evaluate agent behavior, and you need systematic evaluation to make sense of traces.  
那些成功交付高可靠性智能体的团队，已普遍接受一种范式转变：从调试代码转向调试推理过程（debugging reasoning）。传统软件工程中，追踪（tracing，用于调试）与测试（testing，用于验证）职责分离；而如今，我们在面向长周期、有状态、非确定性推理过程开展调试时，这两类实践正加速融合——你既需要“推理追踪”（reasoning traces）来评估智能体行为，也需要系统化的评估机制，才能真正理解并解读这些追踪数据。

The teams that adopt both practices together, from day one, will be the ones shipping agents that actually work.  
从第一天起就同步采用这两类实践的团队，才最有可能交付真正可用、可靠的智能体。

### Get started with agent observability & evals  
### 立即开始使用智能体可观测性与评估（evals）

LangSmith helps teams observe, evaluate, and deploy agents.

LangSmith 帮助团队观测、评估和部署智能体（agents）。

Sign up for free [here](https://smith.langchain.com/?ref=blog.langchain.com).

免费注册，请点击[此处](https://smith.langchain.com/?ref=blog.langchain.com)。