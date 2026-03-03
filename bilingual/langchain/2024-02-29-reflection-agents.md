---
title: "Reflection Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/reflection-agents/"
date: "2024-02-29"
scraped_at: "2026-03-03T08:10:18.845994125+00:00"
language: "en-zh"
translated: true
description: "Reflection is a prompting strategy used to improve the quality and success rate of agents and similar AI systems. This post outlines how to build 3 reflection techniques using LangGraph, including imp..."
tags: ["agents", "langgraph", "By LangChain", "agent builder", "![Building Multi-Agent Apps", "deep agents"]
---

### Key Links

### 关键链接

- **Simple Reflection: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflection/reflection.ipynb?ref=blog.langchain.com) **)**  
- **Reflexion: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflexion/reflexion.ipynb?ref=blog.langchain.com) **)**  
- **Language Agents Tree Search: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/lats/lats.ipynb?ref=blog.langchain.com) **)**  
- [**Youtube**](https://youtu.be/v5ymBTXNqtk?ref=blog.langchain.com)

Reflection is a prompting strategy used to improve the quality and success rate of agents and similar AI systems. It involves prompting an LLM to reflect on and critique its past actions, sometimes incorporating additional external information such as tool observations.

反思是一种提示策略，用于提升智能体（agents）及类似 AI 系统的输出质量与成功率。其核心是引导大语言模型（LLM）对其过往行为进行回顾与批判性评估，有时还会整合额外的外部信息（例如工具调用所获得的观测结果）。

People like to talk about "System 1" and "System 2" thinking, where System 1 is reactive or instinctive and System 2 is more methodical and reflective. When applied correctly, reflection can help LLM systems break out of purely System 1 "thinking" patterns and closer to something exhibiting System 2-like behavior.

人们常提及“系统 1”（System 1）与“系统 2”（System 2）式思维：系统 1 是快速、直觉性或反应式的；系统 2 则更审慎、有条理且具备反思能力。若应用得当，反思机制可帮助 LLM 系统摆脱纯粹依赖系统 1 的“思维”模式，向具备系统 2 特征的行为方式靠近。

![System 1 and 2: Thinking fast? Slow down.](images/reflection-agents/img_001.png)

![系统 1 与系统 2：思维太快？请慢下来。](images/reflection-agents/img_001.png)

Reflection takes time! All the approaches in this post trade off a bit of extra compute for a shot at better output quality. While this may not be appropriate for low-latency applications, it _is_ worthwhile for knowledge intensive tasks where response _quality_ is more important than speed.

反思需要时间！本文介绍的所有方法均以略微增加计算开销为代价，换取更高品质的输出结果。尽管该策略可能不适用于对延迟极度敏感的应用场景，但对于知识密集型任务——即响应的**质量**远比**速度**更重要的场景——它确实非常值得投入。

The three examples are outlined below:

以下简要概述三种示例：

## Basic Reflection

## 基础反思

**Links: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflection/reflection.ipynb?ref=blog.langchain.com) **,** [**Youtube**](https://youtu.be/v5ymBTXNqtk?feature=shared&t=48&ref=blog.langchain.com) **)**  
**链接：(** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflection/reflection.ipynb?ref=blog.langchain.com) **，** [**Youtube**](https://youtu.be/v5ymBTXNqtk?feature=shared&t=48&ref=blog.langchain.com) **)**

This simple example composes two LLM calls: a generator and a reflector. The generator tries to respond directly to the user's requests. The reflector is prompted to role play as a teacher and offer constructive criticism for the initial response.

这一简单示例包含两次大语言模型调用：一次为“生成器”（generator），另一次为“反思器”（reflector）。生成器直接尝试响应用户的请求；而反思器则被提示以教师身份进行角色扮演，并对初始响应提供建设性批评。

循环以固定次数执行，最终生成的输出将被返回。

![](images/reflection-agents/img_002.png)简单反思循环

我们可以在 LangGraph 中如下定义该循环：

```python
from langgraph.graph import MessageGraph

builder = MessageGraph()
builder.add_node("generate", generation_node)
builder.add_node("reflect", reflection_node)
builder.set_entry_point("generate")

def should_continue(state: List[BaseMessage]):
    if len(state) > 6:
        return END
    return "reflect"

builder.add_conditional_edges("generate", should_continue)
builder.add_edge("reflect", "generate")
graph = builder.compile()
```

`MessageGraph` 表示一个有状态图（stateful graph），其中“状态”仅是一个消息列表。每次调用生成器节点（generator node）或反思器节点（reflector node）时，都会向该状态列表末尾追加一条消息。最终结果由生成器节点返回。

这种简单的反思机制有时可通过为大语言模型（LLM）提供多次优化其输出的机会、以及允许反思节点在评估输出时采用不同角色（persona），从而提升性能。

然而，由于反思步骤并未基于任何外部流程进行验证或约束，最终结果可能并不会显著优于原始输出。接下来，我们将探讨一些可缓解该问题的其他技术。

## Reflexion

## 反思（Reflexion）

**Links: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflexion/reflexion.ipynb?ref=blog.langchain.com) **,** [**Youtube**](https://youtu.be/v5ymBTXNqtk?feature=shared&t=299&ref=blog.langchain.com) **)**

**链接：（**[**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/reflexion/reflexion.ipynb?ref=blog.langchain.com) **，**[**YouTube**](https://youtu.be/v5ymBTXNqtk?feature=shared&t=299&ref=blog.langchain.com) **）**

[Reflexion](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com) by Shinn, et. al., is an architecture designed to learn through verbal feedback and self-reflection.  
Shinn 等人提出的 [Reflexion](https://arxiv.org/abs/2303.11366?ref=blog.langchain.com) 是一种旨在通过语言反馈与自我反思实现学习的架构。

Within reflexion, the _actor_ agent explicitly critiques each response and grounds its criticism in external data. It is forced to generate citations and explicitly enumerate superfluous and missing aspects of the generated response. This makes the content of the reflections more constructive and better steers the generator in responding to the feedback.  
在 Reflexion 架构中，“actor”（执行者）智能体需显式地对每次生成的响应进行批判性评估，并将批评依据锚定于外部数据。该智能体被强制要求提供引用来源，并明确列举出响应中冗余或缺失的内容要素。这使得反思内容更具建设性，也更能有效引导生成器响应反馈。

In the [linked](https://github.com/langchain-ai/langgraph/blob/main/examples/reflexion/reflexion.ipynb?ref=blog.langchain.com) example, we stop after a fixed number of steps, though you can also offload this decision to the reflection LLM call.  
在[上述链接](https://github.com/langchain-ai/langgraph/blob/main/examples/reflexion/reflexion.ipynb?ref=blog.langchain.com)所示示例中，我们设定在固定步数后终止流程；但您也可将该终止决策交由反思阶段调用的 LLM 来完成。

An overview of the agent loop is shown below:

下图展示了该智能体循环流程的概览：

![](images/reflection-agents/img_003.png)Reflexion Actor Overview

![](images/reflection-agents/img_003.png)Reflexion 执行者概览

For each step, the responder is tasked with generating a response, along with additional actions in the form of search queries. Then the revisor is prompted to reflect on the current state. The logic can be defined in LangGraph as follows:

每一步中，响应器（responder）需生成一个回答，并附带若干以搜索查询形式表达的附加操作；随后，修订器（revisor）被提示对当前状态进行反思。该逻辑可在 LangGraph 中定义如下：

```python
from langgraph.graph import END, MessageGraph

MAX_ITERATIONS = 5
builder = MessageGraph()
builder.add_node("draft", first_responder.respond)
builder.add_node("execute_tools", execute_tools)
builder.add_node("revise", revisor.respond)
# draft -> execute_tools
builder.add_edge("draft", "execute_tools")
# execute_tools -> revise
builder.add_edge("execute_tools", "revise")

# Define looping logic:
def event_loop(state: List[BaseMessage]) -> str:
    # in our case, we'll just stop after N plans
    num_iterations = _get_num_iterations(state)
    if num_iterations > MAX_ITERATIONS:
        return END
    return "execute_tools"
```

# revise -> execute_tools OR end

# revise → execute_tools 或 end

builder.add_conditional_edges("revise", event_loop)  
builder.set_entry_point("draft")  
graph = builder.compile()  
```

This agent can effectively use explicit reflections and web-based citations to improve the quality of the final response. It only pursues one fixed trajectory, however, so if it makes a misstep, that error can impact subsequent decisions.

该智能体能有效利用显式反思（explicit reflections）和基于网页的引用（web-based citations），从而提升最终响应的质量。然而，它仅沿一条固定路径推进；一旦出现失误，该错误便可能影响后续决策。

## Language Agent Tree Search

## 语言智能体树搜索（LATS）

**Links: (** [**Python**](https://github.com/langchain-ai/langgraph/blob/main/examples/lats/lats.ipynb?ref=blog.langchain.com) **,** [**Youtube**](https://youtu.be/v5ymBTXNqtk?feature=shared&t=625&ref=blog.langchain.com) **)**

[Language Agent Tree Search](https://arxiv.org/abs/2310.04406?ref=blog.langchain.com) (LATS), by Zhou, et. al, is a general LLM agent search algorithm that combines reflection/evaluation and search (specifically Monte-Carlo trees search) to achieve better overall task performance compared to similar techniques like ReACT, Reflexion, or even Tree of Thoughts. It adopts a standard reinforcement learning (RL) task framing, replacing the RL agents, value functions, and optimizer all with calls to an LLM. This is meant to help the agent adapt and problem solve for complex tasks, avoiding getting stuck in repetitive loops.

由 Zhou 等人提出的 [语言智能体树搜索](https://arxiv.org/abs/2310.04406?ref=blog.langchain.com)（Language Agent Tree Search，LATS）是一种通用的大语言模型（LLM）智能体搜索算法。它将反思/评估（reflection/evaluation）与搜索（特别是蒙特卡洛树搜索，Monte-Carlo Tree Search）相结合，在整体任务性能上优于 ReACT、Reflexion，甚至“思维之树”（Tree of Thoughts）等同类方法。LATS 采用标准的强化学习（Reinforcement Learning, RL）任务建模框架，但将 RL 中的智能体（agents）、价值函数（value functions）和优化器（optimizer）全部替换为对大语言模型的调用。其设计目标是帮助智能体适应复杂任务并开展问题求解，避免陷入重复循环。

The search process is outlined in the diagram below:

以下示意图概括了该搜索过程：

![](images/reflection-agents/img_004.png)

The search has four main steps:

该搜索过程包含四个主要步骤：

1. **Select**: pick the best next actions based on the aggregate rewards from step (2) below. Either respond (if a solution is found or the max search depth is reached) or continue searching.  
1. **选择（Select）**：依据步骤（2）中汇总的奖励值，选取最优的下一步动作；若已找到解或达到最大搜索深度，则直接输出响应；否则继续搜索。

2. **Expand and simulate:** generate N (5 in our case) potential actions to take and execute them in parallel.  
2. **扩展与模拟（Expand and simulate）**：生成 N 个（本例中为 5 个）潜在可执行动作，并行执行这些动作。

3. **Reflect + evaluate**: observe the outcomes of these actions and score the decisions based on reflection (and possibly external feedback)  
3. **反思与评估（Reflect + evaluate）**：观察各动作的执行结果，并基于反思（以及可能的外部反馈）对决策进行打分。

4. **Backpropagate**: update the scores of the root trajectories based on the outcomes.  
4. **反向传播（Backpropagate）**：根据执行结果，更新根节点对应各轨迹的得分。

If the agent has a tight feedback loop (through high quality environment rewards or reliable reflection scores), the search is able to accurately distinguish between different action trajectories and pick the best path. The final trajectory can then be saved to external memory (or used for model fine-tuning) to improve the model in the future.

若智能体具备紧密的反馈闭环（例如通过高质量的环境奖励信号或可靠的反思评分实现），该搜索机制便能准确区分不同动作轨迹，并选出最优路径。最终选定的轨迹可保存至外部记忆（或用于模型微调），以在未来持续提升模型性能。

“The selection” step picks the node with the highest upper confidence bound (UCT), which just balances the expected reward (the first term) with an incentive to explore new paths (the second term).

“选择”步骤选取具有最高置信上限（UCT）的节点，该公式恰好在期望奖励（第一项）与探索新路径的激励（第二项）之间取得平衡。

$$
\text{UCT} = \frac{\text{value}}{\text{visits}} + c \sqrt{\frac{\ln(\text{parent.visits})}{\text{visits}}}
$$

$$
\text{UCT} = \frac{\text{value}}{\text{visits}} + c \sqrt{\frac{\ln(\text{parent.visits})}{\text{visits}}}
$$

Check out the [code](https://github.com/langchain-ai/langgraph/blob/main/examples/lats/lats.ipynb?ref=blog.langchain.com) to see how it's implemented. In our LangGraph implementation, we put generation + reflection steps in a single node each, and check the tree state on each loop to see if the task is solved. The (abbreviated) graph definition looks something like below:

请参阅 [源代码](https://github.com/langchain-ai/langgraph/blob/main/examples/lats/lats.ipynb?ref=blog.langchain.com)，了解其实现方式。在我们的 LangGraph 实现中，我们将生成（generation）和反思（reflection）步骤各自封装为一个独立节点，并在每次循环中检查树的状态，以判断任务是否已解决。以下为（简化后的）图结构定义示例：

```python
from langgraph.graph import END, StateGraph

class Node:
    def __init__(
        self,
        messages: List[BaseMessage],
        reflection: Reflection,
        parent: Optional[Node] = None,
    ):
        self.messages = messages
        self.parent = parent
        self.children = []
        self.value = 0
        self.visits = 0
    # Additional methods are defined here. Check the code for more!

class TreeState(TypedDict):
    # The full tree
    root: Node
    # The original input
    input: str

def should_loop(state: TreeState):
    """Determine whether to continue the tree search."""
    root = state["root"]
    if root.is_solved:
        return END
    if root.height > 5:
        return END
    return "expand"

builder = StateGraph(TreeState)
builder.add_node("start", generate_initial_response)
builder.add_node("expand", expand)
builder.set_entry_point("start")

builder.add_conditional_edges(
    "start",
    # Either expand/rollout or finish
    should_loop,
)
builder.add_conditional_edges(
    "expand",
    # Either continue to rollout or finish
    should_loop,
)

graph = builder.compile()
```

LATS Graph

LATS 图

Once you've created the basic outline, it's easy to expand to other tasks! For instance, this technique would suit code generation tasks well, where you the agent can write explicit unit tests and score trajectories based on test quality.

一旦构建了基本框架，便很容易将其拓展至其他任务！例如，该技术非常适用于代码生成任务——在此类任务中，智能体可编写明确的单元测试，并依据测试质量对推理路径（trajectories）进行评分。

LATS unifies the reasoning, planning, and reflection components of other agent architectures, such as Reflexion, Tree of Thoughts, and [plan-and-execute](https://blog.langchain.com/planning-agents/) agents. LATS also from the backpropagation of reflective and environment-based feedback for an improved search process. While it can be sensitive to the reward scores, the general algorithm can be flexibly applied to a variety of tasks.

LATS 统一整合了其他智能体架构（如 Reflexion、Tree of Thoughts 以及 [plan-and-execute](https://blog.langchain.com/planning-agents/) 智能体）中的推理（reasoning）、规划（planning）和反思（reflection）模块。此外，LATS 还借鉴了基于反思与环境反馈的反向传播机制，从而优化搜索过程。尽管其性能可能对奖励分值（reward scores）较为敏感，但该通用算法仍可灵活适配多种任务。

![](images/reflection-agents/img_005.png)Comparison of LATS with other agent architectures

![](images/reflection-agents/img_005.png)LATS 与其他智能体架构的对比

## Video Tutorial

## 视频教程

## Conclusion

## 结论

Thanks for reading! All of these examples can be found in the [LangGraph](https://github.com/langchain-ai/langgraph/tree/main?ref=blog.langchain.com) repository, and we will port these to [LangGraphJS](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com) soon (maybe by the time you read this post).

感谢阅读！以上所有示例均可在 [LangGraph](https://github.com/langchain-ai/langgraph/tree/main?ref=blog.langchain.com) 仓库中找到；我们也将很快将这些示例迁移至 [LangGraphJS](https://github.com/langchain-ai/langgraphjs?ref=blog.langchain.com)（或许在您阅读本文时已完成）。

All of the techniques above leverage additional LLM inference to increase the likelihood of generating a higher quality output, or of responding correctly to a more complex reasoning task. While this takes extra time, it can be appropriate when output quality matters more than response time, and if you save the trajectories to memory (or as [fine-tuning data](https://docs.smith.langchain.com/tracing/use_cases/few-shot-datasets?ref=blog.langchain.com)), you can update the model to avoid repeat mistakes in the future.

上述所有技术均通过额外调用大语言模型（LLM）推理，来提升生成高质量输出的可能性，或更准确地应对更复杂的推理任务。虽然这会增加响应耗时，但在输出质量比响应速度更重要的场景下，这种权衡是合理且值得的；此外，若您将推理路径（trajectories）保存至内存（或作为 [微调数据集](https://docs.smith.langchain.com/tracing/use_cases/few-shot-datasets?ref=blog.langchain.com)），还可据此持续更新模型，以避免未来重复犯错。

### Tags

### 标签

[agents](https://blog.langchain.com/tag/agents/) [langgraph](https://blog.langchain.com/tag/langgraph/) [By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Introducing Agent Builder templates](images/reflection-agents/img_006.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板](images/reflection-agents/img_006.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**使用 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：3 分钟

[![Building Multi-Agent Apps](images/reflection-agents/img_007.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[![使用 Deep Agents 构建多智能体应用](images/reflection-agents/img_007.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**使用 Deep Agents 构建多智能体应用**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 min read

[deep agents](https://blog.langchain.com/tag/deep-agents/) 阅读时长：5 分钟

[![LangSmith Agent Builder Now Generally Available](images/reflection-agents/img_008.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布（GA）](images/reflection-agents/img_008.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**正式发布（GA）：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 min read

[agents](https://blog.langchain.com/tag/agents/) 阅读时长：2 分钟

[![Evaluating Deep Agents: Our Learnings](images/reflection-agents/img_009.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/reflection-agents/img_009.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/reflection-agents/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/reflection-agents/img_010.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/reflection-agents/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/reflection-agents/img_011.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟