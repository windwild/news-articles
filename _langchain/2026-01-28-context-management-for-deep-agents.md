---
title: "Context Management for Deep Agents"
render_with_liquid: false
source: "LangChain Blog"
url: "https://blog.langchain.com/context-management-for-deepagents/"
date: "2026-01-28"
scraped_at: "2026-03-02T10:08:13.452269843+00:00"
language: "en-zh"
translated: true
description: "By Chester Curme and Mason DaughertyAs the addressable task length of AI agents continues to grow, effective context management becomes critical to prevent context rot and to manage LLMs&#x2019; finit..."
---

render_with_liquid: false
_By Chester Curme and Mason Daugherty_

_作者：切斯特·柯姆（Chester Curme）与梅森·道赫蒂（Mason Daugherty）_

As the addressable task length of AI agents [continues to grow](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/?ref=blog.langchain.com), effective context management becomes critical to prevent [context rot](https://research.trychroma.com/context-rot?ref=blog.langchain.com) and to manage LLMs’ finite memory constraints.

随着 AI 智能体可处理的任务长度[持续增长](https://metr.org/blog/2025-03-19-measuring-ai-ability-to-complete-long-tasks/?ref=blog.langchain.com)，高效上下文管理变得至关重要——它不仅能防止[上下文腐化（context rot）](https://research.trychroma.com/context-rot?ref=blog.langchain.com)，还能应对大语言模型（LLM）有限的内存容量限制。

The [Deep Agents SDK](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) is LangChain’s open source, batteries-included [agent harness](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/). It provides an easy path to build agents with the ability to plan, spawn subagents, and work with a filesystem to execute complex, long-running tasks. Because these sorts of tasks can generally exceed models’ context windows, the SDK implements various features that facilitate context compression.

[Deep Agents SDK](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 是 LangChain 推出的开源、开箱即用的[智能体运行时框架（agent harness）](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)。它为构建具备规划能力、可派生子智能体、并能通过文件系统执行复杂且长时间运行任务的智能体，提供了便捷路径。由于此类任务通常会超出模型的上下文窗口容量，该 SDK 实现了多种支持上下文压缩的功能。

* * *

* * *

Context compression refers to techniques that reduce the volume of information in an agent's working memory while preserving the details relevant to completing the task. This might involve summarizing previous interactions, filtering out stale information, or strategically deciding what to retain and what to discard.

上下文压缩（Context compression）指一类技术，旨在减少智能体工作记忆中的信息总量，同时保留完成当前任务所必需的关键细节。具体方法包括：对历史交互内容进行摘要、过滤过时信息，或策略性地决定哪些内容应保留、哪些应舍弃。

Deep Agents implements a [filesystem abstraction](https://docs.langchain.com/oss/python/deepagents/middleware?ref=blog.langchain.com#filesystem-middleware) that allows agents to perform operations such as listing, reading, and writing files, as well as search, pattern matching, and file execution. Agents use the filesystem to search and retrieve offloaded content as needed.

Deep Agents 实现了一种[文件系统抽象层（filesystem abstraction）](https://docs.langchain.com/oss/python/deepagents/middleware?ref=blog.langchain.com#filesystem-middleware)，使智能体能够执行诸如列出文件、读写文件、搜索、模式匹配及执行文件等操作。智能体按需通过该文件系统检索已卸载（offloaded）的内容。

Deep Agents implements three main compression techniques, triggered at different frequencies:

Deep Agents 实现了三种主要的上下文压缩技术，分别在不同频次下被触发：

1. **Offloading large tool results:** We offload large tool responses to the filesystem whenever they occur.  
   **1. 卸载大型工具返回结果**：每当产生大型工具响应时，立即将其卸载至文件系统。

2. **Offloading large tool inputs:** When the context size crosses a threshold, we offload old write/edit arguments from tool calls to the filesystem.  
   **2. 卸载大型工具输入参数**：当上下文大小超过阈值时，将工具调用中较早的写入/编辑参数卸载至文件系统。

3. **Summarization**: When the context size crosses the threshold, and there is no more context eligible for offloading, we perform a summarization step to compress the message history.  
   **3. 摘要生成（Summarization）**：当上下文大小超过阈值，且已无更多可卸载的上下文内容时，执行摘要步骤以压缩消息历史。

To manage context limits, the Deep Agents SDK triggers these compression steps at threshold fractions of the model's context window size. (Under the hood, we use LangChain's [model profiles](https://docs.langchain.com/oss/python/langchain/models?ref=blog.langchain.com#model-profiles) to access the token threshold for a given model.)

为管控上下文限制，Deep Agents SDK 会在模型上下文窗口容量的特定比例阈值处自动触发上述压缩步骤。（底层实现中，我们借助 LangChain 的[模型配置档案（model profiles）](https://docs.langchain.com/oss/python/langchain/models?ref=blog.langchain.com#model-profiles)来获取指定模型对应的 token 阈值。）

## Offloading large tool results

## 卸载大型工具返回结果

Responses from tool invocations (e.g., the result of reading a large file or an API call) can exceed a model's context window. When Deep Agents detects a tool response exceeding 20,000 tokens, it offloads the response to the filesystem and substitutes it with a file path reference and a preview of the first 10 lines. Agents can then re-read or search the content as needed.

工具调用的响应（例如读取大文件或调用 API 的结果）可能超出模型的上下文窗口限制。当 Deep Agents 检测到某次工具响应超过 20,000 个 token 时，会将该响应卸载至文件系统，并在对话历史中以文件路径引用及前 10 行内容预览的形式替代原始响应。此后，智能体可根据需要重新读取或搜索该文件内容。

![](images/context-management-for-deep-agents/img_001.png)

## Offloading large tool inputs

## 卸载大型工具输入

File write and edit operations leave behind tool calls containing the complete file content in the agent's conversation history. Since this content is already persisted to the filesystem, it's often redundant. As the session context crosses 85% of the model’s available window, Deep Agents will truncate older tool calls, replacing them with a pointer to the file on disk and reducing the size of the active context.

文件写入与编辑操作会在智能体的对话历史中留下包含完整文件内容的工具调用记录。由于这些内容本身已持久化保存至文件系统，此类重复存储通常并无必要。当会话上下文占用量超过模型可用上下文窗口的 85% 时，Deep Agents 将截断较早的工具调用记录，代之以指向磁盘上对应文件的指针，从而减小当前活跃上下文的体积。

![](images/context-management-for-deep-agents/img_002.png)

## Summarization

## 摘要生成

When offloading no longer yields sufficient space, Deep Agents falls back to summarization. This process has two components:

当卸载策略已无法释放足够空间时，Deep Agents 将回退至摘要生成机制。该过程包含两个组成部分：

1. In-context summary: An LLM generates a structured summary of the conversation—including session intent, artifacts created, and next steps—which replaces the full conversation history in the agent's working memory. (See the Deep Agents [summarization prompt](https://github.com/langchain-ai/langchain/blob/master/libs/langchain_v1/langchain/agents/middleware/summarization.py?ref=blog.langchain.com#L33-L74).)  
1. 上下文内摘要：由大语言模型（LLM）生成一段结构化对话摘要，涵盖本次会话目标、已生成的产物以及后续步骤，并以此摘要替代智能体工作内存中的完整对话历史。（参见 Deep Agents 的 [摘要提示词模板](https://github.com/langchain-ai/langchain/blob/master/libs/langchain_v1/langchain/agents/middleware/summarization.py?ref=blog.langchain.com#L33-L74)。）

2. Filesystem preservation: The complete, original conversation messages are written to the filesystem as a canonical record.  
2. 文件系统持久化：完整的原始对话消息将被写入文件系统，作为权威、可追溯的存档记录。

This dual approach ensures the agent maintains awareness of its goals and progress (via the summary) while preserving the ability to recover specific details when needed (via filesystem search). See an example in [this trace](https://smith.langchain.com/public/0e3f59e0-7278-4a7a-80fd-99d4fb7fa912/r?ref=blog.langchain.com), where the model uses the `read_file` tool to fetch previously offloaded messages.

这种双重策略既保障了智能体对自身目标与进展的持续感知（通过摘要实现），又保留了在必要时精准恢复具体细节的能力（通过文件系统检索实现）。请参阅 [此追踪示例](https://smith.langchain.com/public/0e3f59e0-7278-4a7a-80fd-99d4fb7fa912/r?ref=blog.langchain.com)，其中模型调用 `read_file` 工具来获取此前已被卸载的对话消息。

![](images/context-management-for-deep-agents/img_003.png)

* * *

## What this looks like in practice

## 实际应用中的表现

While the techniques above provide the machinery for context management, how do we know they're actually working? Runs on real-world tasks, as captured in benchmarks such as [`terminal-bench`](https://www.tbench.ai/?ref=blog.langchain.com), may trigger context compression sporadically, making it difficult to isolate their impact.

上述技术虽为上下文管理提供了基础机制，但我们如何确认它们确实在起作用？在真实世界任务上的运行（例如 [`terminal-bench`](https://www.tbench.ai/?ref=blog.langchain.com) 等基准测试所记录的）可能仅偶发性地触发上下文压缩，因而难以单独评估其影响。

We’ve found it useful to increase the signal of individual features of the harness by engaging them more aggressively on benchmark datasets. For example, while triggering summarization at 10 - 20% of the available context window may lead to suboptimal overall performance, it produces significantly more summarization events. This allows for different configurations (e.g., variations of your implementation) to be compared. For example, by forcing the agent to summarize frequently, we could identify how simple [changes](https://github.com/langchain-ai/langchain/pull/34754?ref=blog.langchain.com) to the `deepagents` summarization prompt, in which we added dedicated fields for the session intent and next steps, help improve performance.

我们发现，在基准数据集上更主动地启用工具链（harness）的各项功能，有助于增强各功能特征的可观测性（signal）。例如，虽然在可用上下文窗口的 10–20% 处即触发摘要生成可能导致整体性能次优，但它能显著增加摘要事件的发生频次。这使得不同配置（例如您实现方案的各种变体）之间可比性更强。举例来说，通过强制代理高频执行摘要，我们得以验证对 `deepagents` 摘要提示词所做的简单[修改](https://github.com/langchain-ai/langchain/pull/34754?ref=blog.langchain.com)——例如新增专门用于描述会话意图与后续步骤的字段——如何切实提升性能。

![](images/context-management-for-deep-agents/img_004.png)

Figure: Token usage over time in sample runs of Claude Sonnet 4.5 on terminal-bench-2 (gray lines show all runs; colored lines highlight two specific examples). The green line shows a dramatic token drop around turn 20 when a summarization event compresses the conversation history. The orange line shows a smaller reduction around turn 40 when a large file write tool call is evicted from context. By triggering compression at 25% of the context window (rather than the Deep Agents default of 85%), we generate more events to study.

图：Claude Sonnet 4.5 在 terminal-bench-2 上若干样本运行中随时间变化的 Token 使用量（灰色线条表示全部运行；彩色线条突出显示其中两个具体示例）。绿色线条显示约在第 20 轮时出现显著 Token 下降，这是由一次摘要事件压缩对话历史所致；橙色线条则显示约在第 40 轮时出现小幅下降，源于一个大型文件写入工具调用被逐出上下文。通过将压缩触发点设为上下文窗口的 25%（而非 Deep Agents 默认的 85%），我们可生成更多压缩事件以供研究。

### Targeted evals

### 针对性评测（Targeted Evaluations）

The Deep Agents SDK maintains a set of targeted evaluations designed to isolate and validate individual context-management mechanisms. These are deliberately small tests that make specific failure modes obvious and debuggable.

Deep Agents SDK 维护了一组针对性评测，旨在分离并验证各项上下文管理机制。这些评测刻意设计得规模较小，以便让特定的失效模式清晰可见、易于调试。

The goal of these evals is not to measure broad task-solving ability, but to ensure that the agent’s harness does not get in the way of certain tasks. For example:

这些评测的目标并非衡量代理在广泛任务上的求解能力，而是确保代理的工具链（harness）不会妨碍某些关键任务的执行。例如：

- Did summarization preserve the agent’s objective? Some evals deliberately trigger summarization mid-task and then check whether the agent continues. This ensures that summarization preserves not only agent state but also its trajectory.

- 摘要生成是否保留了代理的目标？部分评测会刻意在任务中途触发摘要，并随后检查代理是否继续执行。此举旨在确保摘要不仅保留代理的状态，也维持其任务执行路径（trajectory）。

- Can the agent recover information that was summarized away? Here we embed a “ [needle-in-the-haystack](https://github.com/langchain-ai/deepagents/blob/master/libs/deepagents/tests/integration_tests/test_summarization.py?ref=blog.langchain.com#L166-L183)” fact early in the conversation, force a summarization event, and then require the agent to recall that fact later to complete the task. The fact is not present in the active context after summarization and must be recovered via filesystem search.

- 代理能否恢复已被摘要“抹除”的信息？在此类评测中，我们会在对话早期嵌入一条“[大海捞针](https://github.com/langchain-ai/deepagents/blob/master/libs/deepagents/tests/integration_tests/test_summarization.py?ref=blog.langchain.com#L166-L183)”式的关键事实，强制触发一次摘要事件，再要求代理在后续步骤中回忆该事实以完成任务。该事实在摘要完成后已不在活跃上下文中，必须通过文件系统搜索予以恢复。

These targeted evals act as integration tests for context management: they don’t replace full benchmark runs, but they significantly reduce iteration time and make failures attributable to specific compression mechanisms rather than overall agent behavior.

这些针对性评估充当上下文管理的集成测试：它们并不取代完整的基准测试运行，但能显著缩短迭代周期，并使故障可归因于特定的压缩机制，而非智能体的整体行为。

### Guidance

### 使用建议

When evaluating your own context compression strategies, we’d emphasize:

在评估您自有的上下文压缩策略时，我们特别强调以下几点：

- **Start with real-world benchmarks, then stress-test individual features.** Run your harness on representative tasks first to establish baseline performance. Then, artificially trigger compression more aggressively (e.g., at 10-20% of context instead of 85%) to generate more compression events per run. This amplifies the signal from individual features, making it easier to compare different approaches (e.g. variations in your summarization prompt).

- **从真实世界基准测试入手，再对单个功能进行压力测试。** 首先在具有代表性的任务上运行您的测试框架，以确立基线性能；随后，人为地更激进地触发压缩（例如，在上下文占用率仅为 10–20% 时即启动压缩，而非通常的 85%），从而在每次运行中生成更多压缩事件。这将放大各单项功能的信号，便于横向对比不同方法（例如，摘要提示词的不同变体）。

- **Test recoverability.** Context compression is only useful if critical information remains accessible. Include targeted tests that verify agents can both continue toward their original goal after compression and recover specific details when needed (e.g., needle-in-the-haystack scenarios where a key fact is summarized away but must be retrieved later).

- **测试可恢复性。** 上下文压缩只有在关键信息仍可访问的前提下才有意义。请设计针对性测试，验证智能体在压缩后既能继续朝原始目标推进，又能在需要时准确还原特定细节（例如“大海捞针”类场景：某个关键事实虽在摘要中被省略，但后续必须能重新检索出来）。

- **Monitor for goal drift.** The most insidious failure mode is an agent that loses track of the user's intent after summarization. This may manifest as the agent completing in the turn after summarization to ask for clarification, or to mistakenly declare the task complete. More subtle deviations from the intended task may be harder to attribute to summarization; forcing frequent summarization on sample datasets may help surface these failures.

- **监控目标偏移（goal drift）。** 最隐蔽的失效模式是智能体在摘要之后偏离了用户的原始意图。此类问题可能表现为：智能体在摘要完成后的下一个回合即终止对话，转而请求澄清，或错误地宣称任务已完成。更细微的任务偏离往往难以直接归因于摘要操作；在样本数据集上强制高频执行摘要，有助于暴露这类问题。

* * *

* * *

All features of the [Deep Agents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) harness are open source. Try out the latest version and let us know what compression strategies work best for your use cases!

[Deep Agents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) 测试框架的所有功能均为开源。欢迎试用最新版本，并告诉我们哪些压缩策略最契合您的实际应用场景！