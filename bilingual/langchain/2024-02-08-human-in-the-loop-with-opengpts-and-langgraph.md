---
title: "Human-in-the-loop with OpenGPTs and LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/human-in-the-loop-with-opengpts-and-langgraph/"
date: "2024-02-08"
scraped_at: "2026-03-03T08:15:10.467582279+00:00"
language: "en-zh"
translated: true
---

**TLDR; Today we’re launching two “human in the loop” features in OpenGPTs, Interrupt and Authorize, both powered by LangGraph.**

**简而言之：今天，我们在 OpenGPTs 中正式推出两项“人在回路中”（human-in-the-loop）功能——Interrupt（中断）和 Authorize（授权），二者均由 LangGraph 驱动。**

We've recently launched LangGraph, a library to help developers build multi-actor, multi-step, stateful LLM applications. That's a lot words packed into a short sentence, let's take it one at a time.

我们近期推出了 LangGraph —— 一个帮助开发者构建多角色、多步骤、有状态的 LLM 应用程序的开源库。这句话信息量很大，我们来逐层解析。

## Multi-actor

## 多角色（Multi-actor）

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_001.png)

A team of specialists can build something together that none of them could build alone. The same is true of LLM applications: an LLM (great at answer generation and task planning) is much more powerful when paired up with a search engine (best at finding current facts). We have seen folks build some amazing applications, like perplexity or arc search, when they combine those two building blocks (and others) in novel ways.

一支由各领域专家组成的团队，能够协作完成任何单一个体都无法独立完成的任务。LLM 应用亦是如此：一个大语言模型（擅长答案生成与任务规划）若与搜索引擎（最擅长检索最新事实信息）协同工作，其能力将大幅提升。我们已看到许多开发者通过新颖方式组合这些基础模块（以及其他组件），构建出诸如 Perplexity 或 Arc Search 这样令人惊叹的应用。

And just as a human team needs more coordination than one person working by themselves, an application with multiple actors needs a coordination layer to

正如人类团队协作比单人作业需要更复杂的协调机制，一个包含多个角色的 LLM 应用也需要一层协调机制，以实现：

- define the actors involved (the nodes in a graph) and how they handoff work to each other (the edges in that graph)  
- 明确参与的角色（即图中的节点），以及它们之间如何交接任务（即图中的边）；

- schedule execution of each actor at the appropriate time, in parallel if needed, with deterministic results  
- 在恰当的时机调度每个角色的执行，必要时支持并行运行，并确保结果可复现（确定性）。

## Multi-step

## 多步骤（Multi-step）

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_002.png)

As each actor hands off work to another (eg. an LLM prompt asking a search tool for results on a query) we need to make sense of the back-and-forth between multiple actors – what order does it happen in, how many times is each actor called, etc. To do this we can model the interaction between the actors as happening across multiple discrete steps, when one actor hands off work to another actor, that results in the scheduling of the next step of the computation, and so on, until no more actors hand off work to others, and we’ve reached the final result.

当每个角色将任务交接给另一个角色时（例如：一个 LLM 提示词调用搜索工具，查询某问题的结果），我们需要理清多个角色之间往复交互的逻辑——事件发生的先后顺序是什么？每个角色被调用了多少次？等等。为此，我们可以将角色间的交互建模为一系列离散的步骤：每当一个角色向另一个角色交接任务，就触发下一轮计算步骤的调度；如此循环推进，直至不再有角色向其他角色交接任务，最终抵达完整结果。

## Stateful

## 有状态性

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_003.png)

Communication across steps implies updating of some state, otherwise when you call the LLM actor the 2nd time you’d get the same result as the first time. Turns out it’s very helpful to pull this state out of each of the actors, so that all actors collaborate on updating a single central state. With a single central state we can also easily snapshot it and store during or after each computation.

步骤之间的通信意味着需更新某种状态；否则，当你第二次调用 LLM 执行器时，将得到与第一次完全相同的结果。实践表明，将该状态从各个执行器中抽离出来、由所有执行器协同更新一个统一的中心状态，是非常有益的做法。借助这一单一中心状态，我们还能轻松地在每次计算过程中或完成后对其进行快照并持久化存储。

# Human-in-the-loop

# 人在回路中（Human-in-the-loop）

A single shared state makes the process easier to observe, interrupt and modify. Which is very important for complex LLM applications, where some amount of human supervision/approval/editing can be the difference between a toy and a deployment useful in the real world. We’re introducing support for two forms of Human in the Loop in OpenGPTs, powered by LangGraph – Interrupt and Authorize.

单一共享状态使整个流程更易于观察、中断和修改。这对复杂的 LLM 应用至关重要——在真实世界部署中，一定程度的人工监督、审批或编辑，往往正是区分“玩具级原型”与“实用生产系统”的关键所在。我们在 OpenGPTs 中引入了两种“人在回路中”机制（基于 LangGraph 实现）：**中断（Interrupt）** 和 **授权（Authorize）**。

### Interrupt

### 中断（Interrupt）

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_004.png)

The first mode, Interrupt, is the simplest form of control – the user is looking at streaming output of the application as it is produced, and manually interrupts it when he sees fit. The state is saved as of the last complete step prior to the user hitting the interrupt button. From there the user can choose to

第一种模式为“中断（Interrupt）”，是最基础的控制方式：用户实时查看应用产生的流式输出，并可在任意时刻手动中断执行。系统会将中断前最后一个已完成步骤的状态予以保存。此后，用户可选择：

- resume from that point onwards, and the computation will proceed as if it hadn’t been interrupted, or  
- 恢复执行——从该保存点继续运行，后续计算将如同从未被中断一样进行；或  
- send new input into the application (eg. a new message in a chatbot), which will cancel any future steps that were pending, and start dealing with the new input, or  
- 向应用输入新内容（例如，在聊天机器人中发送一条新消息），这将取消所有待执行的后续步骤，并立即开始处理该新输入；或  
- do nothing, and nothing else will run.  
- 保持静默，不进行任何操作，则系统将不再执行任何其他动作。

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_005.png)

### Authorize

### 授权模式

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_006.png)

第二种控制模式是“Authorize”（授权），即用户预先设定：每当某个特定执行者（actor）即将被调用时，应用必须将控制权交还给用户。在 OpenGPTs 中，我们已为此模式实现了“工具调用确认”功能——启用该模式后，每次调用任意工具前，应用都会暂停并请求用户确认。此时，用户可选择：

- 继续执行，接受该工具调用；
- 发送一条新消息，引导机器人转向其他方向，从而避免调用该工具；
- 或者，不进行任何操作。

![](images/human-in-the-loop-with-opengpts-and-langgraph/img_007.png)

### Where to find this

### 如何体验与获取

您可以点击此处 [体验演示](https://opengpts-example-vz4y4ooboq-uc.a.run.app/?ref=blog.langchain.com) OpenGPTs，或点击此处 [Fork 项目](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com)。

您还可在此处查看示例 Notebook：[构建带人工干预（Human-in-the-loop）控制的 LangGraph 应用](https://github.com/langchain-ai/langgraph/blob/main/examples/human-in-the-loop.ipynb?ref=blog.langchain.com)。