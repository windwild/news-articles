---
render_with_liquid: false
title: "Evaluating Deep Agents: Our Learnings"
source: "LangChain Blog"
url: "https://blog.langchain.com/evaluating-deep-agents-our-learnings/"
date: "2025-12-03"
scraped_at: "2026-03-03T07:16:30.331294042+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

Over the past month at LangChain, we shipped four applications on top of the Deep Agents harness:

过去一个月，LangChain 在 Deep Agents 框架之上发布了四个应用：

- [DeepAgents CLI](https://blog.langchain.com/introducing-deepagents-cli/): a coding agent  
- [DeepAgents CLI](https://blog.langchain.com/introducing-deepagents-cli/)：一款编程智能体（coding agent）

- LangSmith Assist: an in-app agent to help with various things in LangSmith  
- LangSmith Assist：一款内嵌于 LangSmith 应用中的智能体，用于协助处理 LangSmith 中的各类任务

- Personal Email Assistant: an email assistant that learns from interactions with each user  
- 个人邮件助手（Personal Email Assistant）：一款能从每位用户的交互中持续学习的邮件智能体

- [Agent Builder](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/): a no-code agent building platform powered by meta deep agents  
- [Agent Builder](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)：一个由元级深度智能体（meta deep agents）驱动的、无需编写代码的智能体构建平台

Building and shipping these agents meant adding evals for each of them, and we learned a lot along the way! In this post, we’ll be diving deep into the following patterns for evaluating deep agents.

开发并上线这些智能体，意味着需为每个智能体设计并实施专属评估（evals），而这一过程让我们收获颇丰！本文将深入探讨以下几类用于评估深度智能体（deep agents）的实践模式：

1. **Deep agents require bespoke test logic for each datapoint** — each test case has its own success criteria.  
1. **深度智能体需为每个数据点定制测试逻辑**——每个测试用例均有其专属的成功判定标准。

2. **Running a deep agent for a single-step** is great for validating decision-making in specific scenarios (and saves tokens too!)  
2. **以单步（single-step）方式运行深度智能体**，非常适合在特定场景下验证其决策能力（同时还能节省 token！）

3. **Full agent turns** are great for testing assertions about the agent’s “end state”.  
3. **完整轮次（full agent turns）** 非常适合检验关于智能体“最终状态”的各类断言。

4. **Multiple agent turns simulate realistic user interactions** but need to be kept on rails.  
4. **多轮次（multiple agent turns）** 可模拟真实用户交互，但必须严格控制流程，确保可复现性。

5. **Environment setup matters** — Deep Agents need clean, reproducible test environments  
5. **环境配置至关重要**——深度智能体需要干净、可复现的测试环境。

### **Glossary**

### **术语表**

Before diving in, we’ll define a few terms we use throughout this post.

在深入探讨之前，我们先定义本文中反复使用的几个关键术语。

**Ways to run an agent:**  
**运行智能体的方式：**

- **Single step:** Constrain the core agent loop to run for only one turn, determining the next action the agent will take.  
- **单步（Single step）**：将智能体核心循环限制为仅执行一轮，以确定智能体下一步将采取的动作。

- **Full turn:** Run the agent in its entirety on a single input, which can consist of multiple tool-calling iterations.  
- **完整轮次（Full turn）**：对单个输入完整运行一次智能体，该过程可能包含多次工具调用迭代。

- **Multiple turns:** Run the agent multiple times in its entirety. Often used to simulate a “multi-turn” conversation between an agent and a user with several back-and-forth interactions.  
- **多轮次（Multiple turns）**：完整地多次运行智能体。常用于模拟智能体与用户之间包含多次来回交互的“多轮对话”。

![](images/evaluating-deep-agents-our-learnings/img_001.png)

**Things we can test:**  
**可测试的内容：**

- **Trajectory:** The sequence of tools that are called by the agent, and the specific tool arguments the agent generates.  
- **轨迹：** 代理所调用的工具序列，以及代理生成的具体工具参数。

- **Final response:** The final returned response from the agent to the user.  
- **最终响应：** 代理返回给用户的最终响应。

- **Other state:** Other values that the agent generated while running (e.g. files, other artifacts)  
- **其他状态：** 代理在运行过程中生成的其他值（例如文件、其他产物）。

![](images/evaluating-deep-agents-our-learnings/img_002.png)

## \#1: Deep Agents require more bespoke test logic (code) for each datapoint

## \#1：深度代理需为每个数据点编写更定制化的测试逻辑（代码）

Traditional LLM evaluation is straightforward:  
传统的大型语言模型（LLM）评估流程十分直接：

1) Build a dataset of examples  
1) 构建一个示例数据集  

2) Write an evaluator  
2) 编写一个评估器  

3) Run your application over the dataset to produce outputs, and score those outputs with your evaluator  
3) 在该数据集上运行你的应用以生成输出，并使用评估器对这些输出进行打分  

Every data point is treated identically — run through the same application logic, scored by the same evaluator.  
每个数据点均被同等对待——均经由相同的应用逻辑处理，并由同一评估器打分。

![](images/evaluating-deep-agents-our-learnings/img_003.png)

Deep Agents breaks this assumption. You’ll want to test more than just the final message. The “success criteria” may be also more specific to each datapoint, and may involve specific assertions against the agent’s trajectory and state.  
深度代理打破了这一假设。你不仅需要测试最终消息，还需验证更多内容。“成功标准”可能因每个数据点而异，且往往需针对代理的轨迹和状态提出具体断言。

Consider this example:

![](images/evaluating-deep-agents-our-learnings/img_004.png)

我们有一个日历调度深度智能体（deep agent），它具备记忆用户偏好的能力。用户要求其智能体“记住：永远不要在上午 9 点之前安排会议”。我们希望验证该日历调度智能体是否已将其自身记忆更新至文件系统中，以保存这一信息。

为了测试这一点，我们可能需要编写断言来验证以下几点：

1) 智能体是否在 `[_memories.md_](http://memories.md/?ref=blog.langchain.com)` 文件路径上调用了 `edit_file` 函数；

2) 智能体是否在其最终响应消息中向用户传达了该记忆更新；

3) `[_memories.md_](http://memories.md/?ref=blog.langchain.com)` 文件中是否确实包含了“不安排过早会议”的相关信息。具体可采用以下方式验证：

- 使用正则表达式（regex）查找文本中是否提及 “9am”；  
- 或者使用大语言模型（LLM）作为评判器（LLM-as-judge），并设定明确的成功判定标准，从而对文件更新内容进行更全面、整体性的分析。

LangSmith 的 Pytest 和 Vitest 集成支持此类定制化测试。针对每个测试用例，您均可对智能体的执行轨迹（trajectory）、最终消息（final message）以及内部状态（state）分别设置不同的断言。

```python
# 标记为 LangSmith 测试用例
@pytest.mark.langsmith
def test_remember_no_early_meetings() -> None:
    user_input = "I don't want any meetings scheduled before 9 AM ET"
    # 我们可将输入记录到 LangSmith 中
    t.log_inputs({"question": user_input})
```

```python
    response = run_agent(user_input)
    # We can log the output of the agent to LangSmith
    t.log_outputs({"outputs": response})

    agent_tool_calls = get_agent_tool_calls(response)

    # We assert that the agent called the edit_file tool to update its memories
    assert any([tc["name"] == "edit_file" and tc["args"]["path"] == "memories.md" for tc in agent_tool_calls])

    # We log feedback from an llm-as-judge that the final message confirmed the memory update
    communicated_to_user = llm_as_judge_A(response)
    t.log_feedback(key="communicated_to_user", score=communicated_to_user)

    # We log feedback from an llm-as-judge that the memories file now contains the right info
    memory_updated = llm_as_judge_B(response)
    t.log_feedback(key="memory_updated", score=memory_updated)
```

如需了解如何使用 Pytest 的通用代码示例，请参阅 [相关文档](https://docs.langchain.com/langsmith/pytest?ref=blog.langchain.com#how-to-run-evaluations-with-pytest-beta)：

该 LangSmith 集成会自动将所有测试用例记录到一个实验（experiment）中，因此您可查看失败测试用例的调用轨迹（trace）以排查问题，并随时间推移持续追踪评估结果。

## #2：单步评估（Single-step evals）兼具价值与高效性

## #2：单步评估既具价值又高效

![](images/evaluating-deep-agents-our-learnings/img_005.png)

在对 Deep Agents 执行评估时，我们约一半的测试用例属于单步评估类型，即：大语言模型（LLM）在接收到特定序列的输入消息后，立即决定执行什么操作？  

在对 Deep Agents 进行评估时，我们大约一半的测试用例属于“单步评估”类型，即：考察大语言模型（LLM）在接收到一组特定输入消息后，**立刻做出的决策行为**——它下一步究竟选择了做什么？

This is especially useful for validating that the agent called the correct tool with the correct arguments in a specific scenario. Common test cases include:

这在特定场景下尤其有用，可用于验证智能体是否调用了正确的工具，并传入了正确的参数。常见的测试用例包括：

- Did it call the right tool to search for meeting times?  
- 它是否调用了正确的工具来搜索会议时间？

- Did it inspect the right directory contents?  
- 它是否检查了正确的目录内容？

- Did it update its memories?  
- 它是否更新了自己的记忆？

Regressions often occur at individual decision points rather than across full execution sequences. If using LangGraph, its streaming capabilities allow you to interrupt the agent after a single tool call to inspect the output — so you can catch issues early without the overhead of a complete agent sequence.

回归问题通常出现在单个决策点上，而非贯穿整个执行流程。若使用 LangGraph，其流式处理能力允许你在智能体完成一次工具调用后即中断执行，从而检查输出结果——这样你就能尽早发现问题，而无需承担完整智能体执行流程的开销。

In the code snippet below, we manually introduce a break point before the tools node, allowing us to easily run the agent for a single step. We can then inspect and make assertions about the state after that single step.

在下方代码片段中，我们在 `tools` 节点前手动设置了一个断点，从而可轻松让智能体仅执行单步操作。随后，我们即可检查并针对该单步执行后的状态进行断言验证。

```python
@pytest.mark.langsmith
def test_single_step() -> None:
	state_before_tool_execution = await agent.ainvoke(
	    inputs,
	    # interrupt_before specifies nodes to stop before
	    # interrupting before the tool node allows us to inspect the tool call args
	    interrupt_before=["tools"]
	)
	# We can see the message history of the agent, including the latest tool call
	print(state_before_tool_execution["messages"])
```

```python
@pytest.mark.langsmith
def test_single_step() -> None:
	state_before_tool_execution = await agent.ainvoke(
	    inputs,
	    # interrupt_before 指定应在哪些节点之前中断执行
	    # 在 tools 节点前中断，便于我们检查工具调用的参数
	    interrupt_before=["tools"]
	)
	# 我们可以查看智能体的消息历史，包括最近一次工具调用
	print(state_before_tool_execution["messages"])
```

## \#3: Full agent turns give you a complete picture

## \#3：完整的智能体交互可呈现端到端全貌

![](images/evaluating-deep-agents-our-learnings/img_006.png)

Think of single-step evals as your “unit tests” that ensure the agent takes the expected action in a specific scenario. Meanwhile, full agent turns are also valuable — they show you a complete picture of the end-to-end actions that your agent takes.

可将单步评估视作智能体的“单元测试”，用于确保其在特定场景下执行了预期动作；而完整的智能体交互同样具有重要价值——它能为你呈现智能体端到端行为的完整图景。

Full agent turns let you test agent behavior in multiple ways:

完整的智能体交互支持以多种方式测试智能体行为：

**1) Trajectory:** A very common way to evaluate a full trajectory is to ensure that a particular tool was called at some point during action, but it doesn’t matter exactly when. In our calendar scheduler example, the scheduler might need multiple tool calls to find a suitable time slot that works for all parties.

**1) 轨迹（Trajectory）：** 评估完整轨迹的一种常见方式是确认某特定工具在执行过程中被调用过（具体调用时机则不重要）。以我们的日历调度器示例为例，调度器可能需要多次调用工具，才能为所有与会者找到一个合适的时间段。

![](images/evaluating-deep-agents-our-learnings/img_007.png)

![](images/evaluating-deep-agents-our-learnings/img_007.png)

**2) Final Response:** In some cases, the quality of the final output matters more than the specific path taken by the agent. We found this to be true for more open-ended tasks like coding and research.

**2) 最终响应：** 在某些情况下，最终输出的质量比智能体所采取的具体路径更为重要。我们发现，在编程、研究等更开放的任务中，这一观点尤为成立。

![](images/evaluating-deep-agents-our-learnings/img_008.png)

![](images/evaluating-deep-agents-our-learnings/img_008.png)

**3) Other State:** Evaluating other state is very similar to evaluating an agent’s final response. Some agents will create artifacts instead of responding to the user in a chat format. Examining and testing these artifacts is easy by examining an agent’s state in LangGraph.

**3) 其他状态：** 对其他状态的评估与对智能体最终响应的评估非常相似。部分智能体并不以聊天形式向用户返回文本响应，而是生成各类产物（artifacts）。通过 LangGraph 查看智能体的状态，即可轻松检查并测试这些产物。

1. For a coding agent → read and then test the files that the agent wrote.  
1. 对编程智能体 → 读取其生成的文件，并运行测试验证其正确性。  
2. For a research agent → assert the agent found the right links or sources.  
2. 对研究智能体 → 验证其是否找到了正确的链接或信息来源。

Full agent turns give you a complete picture of your agent execution. LangSmith makes it really easy to view your full agent turns as traces, where you can see high level metrics like latency and token use, while also analyzing specific steps down to each model call or tool invocation.

完整的智能体交互轮次（full agent turns）能全面呈现智能体的执行过程。LangSmith 让你能够以“追踪”（traces）形式直观查看全部交互轮次：既可概览延迟（latency）、Token 使用量等高层级指标，也可深入分析每一步骤，直至每次模型调用或工具调用。

## \#4: Running an agent across multiple turns simulates full user interactions

## \#4：跨多轮运行智能体，以模拟完整用户交互

![](images/evaluating-deep-agents-our-learnings/img_009.png)

![](images/evaluating-deep-agents-our-learnings/img_009.png)

Some scenarios require testing agents across multi-turn conversations that have multiple sequential user inputs. The challenge is that if you naively hardcode a sequence of inputs and the agent deviates from the expected path, the subsequent hardcoded user input may not make sense.

某些场景需要在包含多次连续用户输入的多轮对话中测试智能体。挑战在于：若简单地硬编码一组输入序列，而智能体在执行过程中偏离了预期路径，则后续硬编码的用户输入可能已不再合理或上下文不匹配。

We addressed this by adding conditional logic in our Pytest and Vitest tests. For example, we would:  

我们通过在 Pytest 和 Vitest 测试中引入条件逻辑来应对该问题。例如，我们会：

- Run the first turn, and then check the agent output.  
  - 运行第一轮交互，然后检查智能体（agent）的输出。  
  - If the output was expected, run the next turn.  
    - 如果输出符合预期，则运行下一轮交互。  
  - If it was not expected, fail the test early. (This was possible because we had the flexibility to add checks after each step.)  
    - 如果输出不符合预期，则立即终止测试。（这之所以可行，是因为我们具备在每一步之后灵活添加校验的能力。）

This approach let us run multi-turn evals without having to model every possible agent branch. If we wanted to test the second or third turn in isolation, we simply set up a test starting from that point with appropriate initial state.  
采用这种方法，我们无需对智能体所有可能的分支路径建模，即可开展多轮次评估。若需单独测试第二轮或第三轮交互，只需从该轮次起始点配置测试，并提供相应的初始状态即可。

## \#5: Setting up the right eval environment is important  

## \#5：构建合适的评估环境至关重要  

Deep Agents are stateful and designed to tackle complex, long-running tasks — often requiring more complex environments to evaluate in.  
深度智能体（Deep Agents）是有状态的，专为处理复杂、长时间运行的任务而设计——因此其评估往往需要更复杂的运行环境。

Unlike simpler LLM evals where the environment is limited to a few usually stateless tools, Deep Agents need a fresh, clean environment for each eval run in order to ensure reproducible results.  
与简单的大语言模型（LLM）评估不同（其环境通常仅限于少数无状态工具），深度智能体每次评估运行都必须使用全新、干净的环境，以确保结果可复现。

Coding agents illustrate this clearly. [Harbor](https://harborframework.com/?ref=blog.langchain.com) provides an evaluation environment for TerminalBench that runs inside a dedicated Docker container or sandbox. For DeepAgents CLI, we use a more lightweight approach: we create a temporary directory and run the agent inside it for each test case.  
编程类智能体清晰地印证了这一点。[Harbor](https://harborframework.com/?ref=blog.langchain.com) 为 TerminalBench 提供了一个评估环境，该环境运行于专用的 Docker 容器或沙箱中。而对于 DeepAgents CLI，我们则采用更轻量的方式：为每个测试用例创建一个临时目录，并在其中运行智能体。

The broader point: Deep Agent evals require environments that resets per test -- otherwise your evals become flaky and difficult to reproduce.  
更广泛地说：深度智能体的评估要求每次测试均使用重置后的独立环境——否则评估将变得不稳定（flaky），且难以复现。

**Tip: Mock out your API requests**  
**提示：模拟（Mock）你的 API 请求**

LangSmith Assist requires connecting to real LangSmith APIs. Running evals against live services can be slow and expensive. Instead, record HTTP requests into a filesystem and replay them during test execution. For Python, [vcr](https://github.com/vcr/vcr?ref=blog.langchain.com) works well; for JS, we proxy `fetch` requests through a Hono app works.  
LangSmith Assist 需要连接真实的 LangSmith API。直接对线上服务运行评估可能既缓慢又昂贵。取而代之的做法是：将 HTTP 请求录制到文件系统中，并在测试执行时回放这些请求。在 Python 中，[vcr](https://github.com/vcr/vcr?ref=blog.langchain.com) 是一个效果良好的工具；而在 JavaScript 中，我们则通过 Hono 应用代理 `fetch` 请求来实现。

Mocking or replaying API requests makes Deep Agent evals faster and easier to debug, especially when the agent depends heavily on external system state.  
模拟或回放 API 请求，可显著提升深度智能体评估的速度，并使其更易于调试——尤其当智能体高度依赖外部系统状态时。

## Evaluate Deep Agents with LangSmith

## 使用 LangSmith 评估深度智能体

The above techniques are common patterns we saw when writing our own test suites for deep agents powered applications. You likely only need a subset of the above patterns for your specific application — and as such, it’s important for your evaluation framework to be flexible. If you’re building a deep agent and getting started with evals, check out [LangSmith’s testing integrations](https://docs.langchain.com/langsmith/pytest?ref=blog.langchain.com)!

上述技术是我们为基于深度智能体的应用程序编写自有测试套件时所观察到的常见模式。针对您的具体应用场景，您很可能只需采用其中一部分模式；因此，确保您的评估框架具备足够的灵活性至关重要。如果您正在构建深度智能体并刚开始进行评估工作，欢迎了解 [LangSmith 的测试集成方案](https://docs.langchain.com/langsmith/pytest?ref=blog.langchain.com)！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/evaluating-deep-agents-our-learnings/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![LangSmith 中端到端 OpenTelemetry 支持正式发布](images/evaluating-deep-agents-our-learnings/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**LangSmith 中端到端 OpenTelemetry 支持正式发布**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/evaluating-deep-agents-our-learnings/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 人工智能现状》报告](images/evaluating-deep-agents-our-learnings/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/evaluating-deep-agents-our-learnings/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/evaluating-deep-agents-our-learnings/img_012.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/evaluating-deep-agents-our-learnings/img_013.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/evaluating-deep-agents-our-learnings/img_013.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/evaluating-deep-agents-our-learnings/img_014.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/evaluating-deep-agents-our-learnings/img_014.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Few-shot prompting to improve tool-calling performance](images/evaluating-deep-agents-our-learnings/img_015.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**通过少样本提示提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：8 分钟