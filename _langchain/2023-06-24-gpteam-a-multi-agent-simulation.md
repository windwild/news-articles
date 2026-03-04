---
title: "GPTeam: A multi-agent simulation"
source: "LangChain Blog"
url: "https://blog.langchain.com/gpteam-a-multi-agent-simulation/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:48:22.112646701+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**Editor's Note: This is another edition in our series of guest posts highlighting novel applications of LangChain. After the Generative Agents paper was released, there was a flurry of open source projects rushing to incorporate some of the key ideas. GPTeam was one of the most impressive ones we saw, so we're incredibly excited to highlight this guest blog from [@itstimconnors](https://twitter.com/itstimconnors?ref=blog.langchain.com) and the rest of the team  ( [@alecvxyz](https://twitter.com/alecvxyz?ref=blog.langchain.com) [@joshsny](https://twitter.com/joshsny?ref=blog.langchain.com), and [@haniasnyder](https://twitter.com/haniasnyder?ref=blog.langchain.com)).**

**编者按：** 这是我们系列客座文章的又一期，旨在展示 LangChain 的创新应用。在《Generative Agents》论文发布后，大量开源项目迅速跟进，尝试融入其中的关键思想。GPTeam 是我们所见最令人印象深刻的项目之一，因此我们非常荣幸地推出这篇由 [@itstimconnors](https://twitter.com/itstimconnors?ref=blog.langchain.com) 及其团队（[@alecvxyz](https://twitter.com/alecvxyz?ref=blog.langchain.com)、[@joshsny](https://twitter.com/joshsny?ref=blog.langchain.com) 和 [@haniasnyder](https://twitter.com/haniasnyder?ref=blog.langchain.com)）撰写的客座博客。

On May 16th, [we released GPTeam](https://twitter.com/itstimconnors/status/1658547632124354595?ref=blog.langchain.com), a completely customizable open-source multi-agent simulation, inspired by Stanford’s ground-breaking “ [Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com)” paper from the month prior. Every agent within a GPTeam simulation has their own unique personality, memories, and directives, leading to interesting emergent behavior as they interact.

5 月 16 日，我们发布了 [GPTeam](https://twitter.com/itstimconnors/status/1658547632124354595?ref=blog.langchain.com) —— 一个完全可定制的开源多智能体仿真系统，灵感源自斯坦福大学上月发布的开创性论文《[Generative Agents](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2304.xml?ref=blog.langchain.com)》。在 GPTeam 仿真中，每个智能体都拥有独特的个性、记忆与行为指令，当它们彼此交互时，便涌现出丰富而有趣的行为模式。

We set up the project so that anyone can run their own multi-agent simulation by editing a simple JSON configuration file like the one shown below. In this example we’ve created a simple world called “Jest Jockeys”, which contains a “Park” location and a “Mall” location. We’ve included several agents who each contain their own bios, directives, and plans.

我们设计了该项目，使任何人都只需编辑一个简单的 JSON 配置文件（如下所示），即可运行自己的多智能体仿真。本例中，我们构建了一个名为“Jest Jockeys”（谐音双关：“Jest Jockeys” ≈ “Just Jokers”，亦指“玩笑骑手”）的简易世界，其中包含“Park”（公园）和“Mall”（商场）两个地点，并配置了若干智能体——每位智能体均拥有专属的人物简介（bio）、行为指令（directives）与行动规划（plans）。

![](images/gpteam-a-multi-agent-simulation/img_001.png)

![示意图](images/gpteam-a-multi-agent-simulation/img_001.png)

Users can then run the simulation with a single command, `poetry run world`, which triggers a web interface showing the agent thought processes and dialog. This allows users to see the agents as they observe new events, decide how to react, and carry out their plans.

用户随后只需执行一条命令 `poetry run world` 即可启动仿真，系统将自动唤起一个 Web 界面，实时呈现各智能体的思维过程与对话内容。借此，用户可直观观察智能体如何感知新事件、如何决策响应，以及如何执行既定计划。

The goal of the project was to test the capabilities of LLMs to emulate human-like social behavior. Our theory was that human-like behavior emerges from (a) sufficiently capable long-term memory systems, and (b) a recurring process of self-reflection to achieve abstract reasoning.

本项目的目标是检验大语言模型（LLMs）模拟类人社会行为的能力。我们的核心假设是：类人行为源于（a）足够强大的长期记忆系统，以及（b）持续进行自我反思以实现抽象推理的过程。

Here’s how it went…

以下便是整个探索过程……

> FYI: This write-up will reference the code from our project, which can be found [here](https://github.com/101dotxyz/GPTeam?ref=blog.langchain.com).

> 小提示：本文将引用本项目的源代码，完整代码库请参见 [此处](https://github.com/101dotxyz/GPTeam?ref=blog.langchain.com)。

## The Architecture

## 架构设计

At a high level, the architecture of the simulation looks like this. The actual code contains a lot more nuance and additional helper classes, but this is the rough sketch of how things work together.

从宏观层面看，该仿真的整体架构如下图所示。实际代码中包含了更精细的设计逻辑与大量辅助类，但下图已勾勒出各模块协同工作的基本框架。

![](images/gpteam-a-multi-agent-simulation/img_002.png)

The World class serves the the top level wrapper for everything else. When we run the simulation, we are running world.run( ), which triggers each agent in the world to begin its _agent loop_.

`World` 类是整个系统最顶层的封装。当我们运行模拟时，实际执行的是 `world.run()`，该方法会触发世界中的每个智能体（agent）启动其 _智能体循环（agent loop）_。

## The Agent Loop

## 智能体循环（Agent Loop）

The agent loop is the main driver of activity within GPTeam. As the world runs, each agent repeats this loop again and again until the world stops. You can view the code for the agent loop [here](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L1050).

智能体循环是 GPTeam 内部所有行为活动的核心驱动力。在世界持续运行期间，每个智能体会不断重复执行该循环，直至整个世界停止运行。您可在此处查看智能体循环的源码：[点击访问](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L1050)。

![](images/gpteam-a-multi-agent-simulation/img_003.png)

As we dive into how the agent loop works, it’s helpful to understand that there is no discrete agentic AI to be found in this repository. The appearence of an agentic human-like entity is an illusion created by our memories system and a string of distinct Language Model prompts.

深入理解智能体循环的工作机制时，需明确一点：本代码仓库中并不存在一个独立、具身化的“智能体式 AI”（agentic AI）。所谓类人智能体的“自主行为”表象，实则是由我们的记忆系统与一系列彼此独立的大语言模型（LLM）提示词共同构建出的一种幻觉。

### Agent.observe

### `Agent.observe`

An agent starts their loop by first observing activity in its location. This function, **[observe( )](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L975)**, gets the latest events from the agent’s current location and adds each one to the agents memory. When a new memory is created, it’s assigned an importance score, which aims to quantify the poignancy of the memory. This allows more critical events to be “remembered” more easily later on. We assign the importance score by simply asking an LLM to generate one:

智能体循环的第一步，是观察其所处位置发生的最新动态。该功能即 **[`observe()`](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L975)**：它从智能体当前所在位置获取最新事件，并将每一条事件添加至该智能体的记忆中。每当一条新记忆被创建，系统便会为其分配一个“重要性得分”（importance score），用以量化该记忆的深刻程度（poignancy）；这一机制确保关键事件在未来更易被“回忆”起来。我们通过向大语言模型（LLM）发起一次简单提问，即可生成该重要性得分：

![](images/gpteam-a-multi-agent-simulation/img_004.png)

> FYI: You can view all of our LLM prompts in [this file](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/utils/prompt.py?ref=blog.langchain.com).

> 小贴士：您可在 [此文件](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/utils/prompt.py?ref=blog.langchain.com) 中查阅本项目全部大语言模型提示词（LLM prompts）。

### Agent.plan

### Agent.plan（规划）

Next, the agent makes plans if they don’t have any, although they usually do, since they make 5 plans at a time. Every action an agent takes must be part of some plan, so planning is critical. To make plans, we take the agent’s personal details and situational context, then pass them into an LLM call with the prompt shown below.

接下来，若代理尚无任何计划，则会制定新计划；不过通常情况下它们已有计划，因为每次都会预先生成 5 个计划。代理所执行的每一项动作都必须隶属于某个既定计划，因此规划至关重要。为生成计划，我们提取代理的个人信息与当前情境上下文，并将其输入至大语言模型（LLM）调用中，所用提示词如下所示。

![](images/gpteam-a-multi-agent-simulation/img_005.png)

![](images/gpteam-a-multi-agent-simulation/img_005.png)

An important part of this prompt is the agent’s directives, which act as their compass when deciding what to do. Without them, they can only be reactionary. You can think of their directives as their default activity.

该提示词中一个关键部分是代理的“指令”（directives），它在代理决定如何行动时起到指南针作用。缺少这些指令，代理便只能被动响应。你可以将这些指令理解为代理的默认行为模式。

The result from this LLM call is an ordered list of JSON objects, which populate the Agent.plans array. Each plan contins an index, description, location, start time, max duration, and a stopping condition.

此次 LLM 调用的输出结果是一个有序的 JSON 对象列表，用于填充 `Agent.plans` 数组。每个计划对象包含以下字段：索引（index）、描述（description）、地点（location）、开始时间（start time）、最长持续时间（max duration）以及终止条件（stopping condition）。

### Agent.react

### Agent.react（响应）

After making plans, the agent decides how to react. The **[react( )](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L797)** function is very simple: it asks an LLM to decide, based on recent events whether they should **continue**, **postpone**, or **cancel** their top plan. Here’s what that prompt looks like:

完成规划后，代理将决定如何响应。**[`react()` 函数](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L797)** 实现极为简洁：它调用大语言模型（LLM），依据近期发生的事件，判断代理应对其当前首要计划采取 **继续（continue）**、**推迟（postpone）** 还是 **取消（cancel）** 的操作。该提示词如下所示：

![](images/gpteam-a-multi-agent-simulation/img_006.png)

![](images/gpteam-a-multi-agent-simulation/img_006.png)

This prompt started off way simpler, but as we tried to achieve human-like dialog, we were having trouble getting the agents to respond appropriately. At first they wouldn’t respond to dialog until they completed their current plan. We addressed that problem by instructing agents to prioritize dialog, but then we found that they would continue dialog forever, just saying platitudes and greetings to one another over and over. What we ended up with was an instruction to prioritize responding to other agents _**if it would be rude not to.**_ This simple addition allowed agents to converse with one another as humans do.

这一提示词最初要简单得多；但当我们尝试实现类人对话时，却难以让代理做出恰当响应。起初，代理只有在完成当前计划后才会回应对话；我们通过指示代理“优先处理对话”来解决该问题；然而随之又出现了新问题：代理会无限延续对话，反复向彼此说些陈词滥调和客套问候。最终，我们采用了这样一条指令：**仅当“不回应会显得失礼”时，才优先响应其他代理**。这一看似简单的补充，却使代理得以像人类一样自然地相互交谈。

As you can see in the agent loop code, if the reaction is a postponing of plans, the agent switches to an alternative plan, provided by the LLM response. If the reaction is a cancellation of plans, the agent simply removes its current plan and moves on to the next plan in its list of plans.

如你在代理主循环代码中所见：若响应结果为“推迟计划”，则代理将切换至 LLM 响应中提供的替代计划；若响应结果为“取消计划”，则代理直接移除当前计划，并顺次推进至其计划列表中的下一项计划。

### Agent.act

### Agent.act（执行动作）

After all of this, we’re ready to carry out our top plan, which starts in the **[act( )](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L858)** method of the Agent class.  
在完成上述所有步骤后，我们便准备好执行最高优先级的计划——该计划始于 `Agent` 类的 **[act( )](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L858)** 方法。

The first step of the act function is to gather relevant memories based on what’s happening to the agent. To do this, we make a semantic embedding of latest activity, and then we compare that embedding to those of the memories in the agent’s memory list. The relevancy of a memory is a weighted summation of the memory’s importance, cosine similarity, and recency:  
`act` 函数的第一步是根据代理当前所处的情境，收集相关的记忆。为此，我们对最新发生的活动生成语义嵌入（semantic embedding），再将该嵌入与代理记忆列表中各条记忆的嵌入进行比对。某条记忆的相关性（relevancy）由其重要性（importance）、余弦相似度（cosine similarity）和时效性（recency）三者加权求和得出：

![](images/gpteam-a-multi-agent-simulation/img_007.png)

After gathering these related memories and some other important context, the act function sets up a **[PlanExecutor](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L154)** object and calls its **[execute](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244)** method to run a langchain agent.  
在收集完这些相关记忆及其他关键上下文后，`act` 函数会创建一个 **[PlanExecutor](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L154)** 对象，并调用其 **[execute](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244)** 方法来运行一个 LangChain 代理。

## The Plan Executor

## 计划执行器（Plan Executor）

The [PlanExecutor](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L154) class is a custom class we made to wrap around langchain’s LLMSingleActionAgent. We made this custom abstraction instead of using an AgentExecutor for a few reasons:  
[PlanExecutor](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L154) 类是我们自定义的一个封装类，用于包装 LangChain 的 `LLMSingleActionAgent`。我们选择自行构建这一抽象层，而非直接使用 `AgentExecutor`，主要原因有以下几点：

- We needed helper functions to handle the context that the langchain agent would need to populate its prompt correctly.  
  - 我们需要辅助函数来处理 LangChain 代理所需的各种上下文，以确保其提示词（prompt）能被正确填充；

- We wanted to store the intermediate steps of each agent in our database so that the simulation could be paused and recontinued.  
  - 我们希望将每个代理的中间执行步骤存入数据库，以便仿真过程可随时暂停并从中断处继续；

- We wanted to incorporate a lot of custom logging logic, which we needed for our logging interface.  
  - 我们希望集成大量自定义日志逻辑，以满足我们日志接口的需求。

### **PlanExecutor.execute**

### **PlanExecutor.execute（执行计划）**

The [execute](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244) function has two primary parts: First it runs the **[plan](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L270)** method of the LLMSingleActionAgent to get an _AgentAction_, and then it manually handles the AgentAction to call the **run** method on the chosen tool, or return a response if the agent is done.  
[execute](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244) 函数主要包含两个阶段：首先调用 `LLMSingleActionAgent` 的 **[plan](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L270)** 方法，获取一个 `_AgentAction_`；随后手动处理该 `AgentAction`：若代理需调用工具，则调用对应工具的 **`run`** 方法；若代理已完成任务，则直接返回响应结果。

The LLMSingleActionAgent is initialized with the prompt template shown below, which is ultimately used in the **plan** method to get an AgentAction. Let’s dive into this prompt a bit:  
`LLMSingleActionAgent` 使用下方所示的提示词模板进行初始化，该模板最终将在 **`plan`** 方法中被用于生成 `AgentAction`。下面我们深入解析一下这个提示词：

![](images/gpteam-a-multi-agent-simulation/img_008.png)

![](images/gpteam-a-multi-agent-simulation/img_008.png)

The first thing to note is the framing: _**you are a character playing in front of a live audience.**_ We found that directly telling the agent this generated a lot more chatter, which helped make our simulation more interesting to observers. It inspired the agents to talk to themselves when they were doing a task (for example, saying things like “Wow that’s interesting” when searching on google).

首先需要注意的是角色设定：_**你是一个正在现场观众面前表演的角色。**_ 我们发现，直接向智能体传达这一设定，能显著激发其更多自发性对话，从而让我们的模拟对观察者而言更具观赏性和趣味性。这种设定促使智能体在执行任务时自言自语（例如，在谷歌搜索时脱口而出：“哇，这真有意思！”）。

The next thing to note is the prioritization of dialog. This is something we did in the **react** function as well. Even if the current plan has nothing to do with dialog, we instruct the agent here to finish their pending conversations first, reminding them they need not respond **all the time.**

其次需要注意的是对话的优先级。这一点我们在 **react** 函数中也做了同样处理。即使当前计划与对话完全无关，我们仍会在此处指示智能体优先完成尚未结束的对话，并提醒它们：**无需时刻回应**。

The rest of the prompt is pretty straight forward, and heavily inspired by the default langchain agent prompt. We include the agent’s bio, their location context, relevant memories, conversation history, and tools available.

其余提示词内容则相对直白，大量借鉴了 LangChain 默认的智能体提示模板。我们包含了智能体的个人简介、所处位置背景、相关记忆、对话历史以及可用工具。

> Quick note: every agent has a _public bio_ and a _private bio._ The public bio is a description that all the other agents have access to, such as their role, their appearence, and their name. A private bio includes details that only the agent themselves know, such as their insecurities and desires.

> 小贴士：每位智能体都拥有一个**公开简介（public bio）**和一个**私密简介（private bio）**。公开简介是其他所有智能体均可访问的信息，例如其角色定位、外貌特征与姓名；而私密简介则仅对该智能体自身可见，包含其内心不安、隐秘渴望等深层心理细节。

We referred to this plan + tool usage action as a single step. The [execute](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244) function of the PlanExecutor class runs the agent for one step each time it’s called. After a step is run, a string representation of the step is added to a list of historical steps contained within the current plan (we borrow from Langchain’s terminology here when we call that a scratchpad).We save the scratchpad at the end of the function so that the agent can pick up where it left off in the next run of the agent loop.

我们将“制定计划 + 调用工具”这一完整动作统称为**单步（single step）**。`PlanExecutor` 类中的 [`execute`](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/executor.py?ref=blog.langchain.com#L244) 方法每次被调用时，即驱动智能体执行一步。每完成一步后，该步的字符串化表示将被追加至当前计划所维护的历史步骤列表中（此处我们沿用了 LangChain 的术语，称其为“草稿区（scratchpad）”）。我们在函数末尾保存该草稿区，以便智能体在下一轮循环启动时能从中断处继续执行。

### Agent.reflect

### Agent.reflect（智能体反思）

As the final step of every agent loop, we check if it’s time to reflect. [This function](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L528) is triggered every time the total importance score across all of an agent’s memories reaches a multiple of 100. This way, if the agent is experiencing something extremely exciting and memorable, it will reflect more often, and vice versa.

作为每次智能体循环的最终环节，我们会检查是否已到达反思时机。[`该函数`](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L528)会在智能体所有记忆的**重要性总分**达到 100 的整数倍时被自动触发。如此一来，若智能体正经历极其激动人心或难忘的事件，其反思频率便会自然升高；反之亦然。

> This reflection logic was borrowed directly from the brilliant authors of the “Generative Agents” paper at Stanford.

> 此反思机制直接借鉴自斯坦福大学《生成式智能体（Generative Agents）》论文作者团队的杰出设计。

The [reflect](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L528) method does two primary things: first, it generates three high level questions the agent can reflect on. Then, it generates answers to those quetions. In order to gather the right questions to ask, we use this prompt, passing in a list of the most recent memories:

[`reflect`](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/agent/base.py?ref=blog.langchain.com#L528) 方法主要完成两项工作：第一，生成三个高层次的反思问题，供智能体深入思考；第二，针对这些问题生成相应的回答。为确保提出恰当的问题，我们使用如下提示词模板，并向其中传入一组最新记忆列表：

![](images/gpteam-a-multi-agent-simulation/img_009.png)

![](images/gpteam-a-multi-agent-simulation/img_009.png)

After getting questions from the recent memories, it’s time to generate some reflections. To do this, we first make a semantic embedding of the question, and use our **[get\_relevant\_memories](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/memory/base.py?ref=blog.langchain.com#L135)** function (discussed earlier) to find relevant memories based on the topic. If the question is _“What does Marty do with his free time?”,_ we’ll find memories such as “I see Marty walking his dog” or “Marty likes talking with his friends”.

在从近期记忆中提取出问题后，下一步便是生成若干反思（reflections）。为此，我们首先对问题进行语义嵌入（semantic embedding），再调用此前介绍过的 **[get\_relevant\_memories](https://github.com/101dotxyz/GPTeam/blob/34bdfb3b040258b2f414e3e61ba2761c7295ba3d/src/memory/base.py?ref=blog.langchain.com#L135)** 函数，依据话题检索相关记忆。例如，若问题是 *“Marty 空闲时间都做些什么？”*，系统将匹配到诸如 *“我看到 Marty 在遛狗”* 或 *“Marty 喜欢和朋友们聊天”* 等记忆。

To get our final reflection, we pass in these relevant memories for each topic and ask: “What high level insights can you infer from these memories?” This gives us insights such as “Marty likes the outdoors” and “Marty is an extroverted person”.

为获得最终的反思结果，我们将每个话题对应的相关记忆一并输入，并向大模型提问：*“从这些记忆中，你能推断出哪些高层次的洞见？”* 由此得出的洞见可能包括 *“Marty 喜爱户外活动”* 和 *“Marty 是一位外向的人”*。

![](images/gpteam-a-multi-agent-simulation/img_010.png)

![](images/gpteam-a-multi-agent-simulation/img_010.png)

After this final step, we’ve concluded the agent loop, and it’s time to repeat the whole thing. Although it’s a relatively simple process, this method of **observe → react → act → reflect** achieves suprisingly human-like behavior from our agents. Let’s take a look at the results:

完成这最后一步后，本轮智能体循环（agent loop）即告结束，随即进入下一轮循环。尽管该流程看似简单，但这种 **观察（observe）→ 反应（react）→ 行动（act）→ 反思（reflect）** 的闭环机制，却使我们的智能体展现出令人惊讶的人类般行为。让我们来看一看实际运行效果：

## The Results

## 实验结果

When run, the agents exhibit complex social behavior, coordinating among one each other and playing off the dialog appropriately. In this example, we’ve made three agents: Marty, Ricardo, and Rebecca who are all part of a traveling improv troupe. We’ve given each one a public bio, private bio, directives, and an initial plan.

运行时，各智能体展现出复杂的社交行为：彼此协调、自然接话、适时回应。本例中，我们构建了三位智能体：Marty、Ricardo 和 Rebecca，他们同属一支巡回即兴戏剧团。我们分别为每位智能体设定了公开简介（public bio）、私人简介（private bio）、行为指令（directives）以及初始计划（initial plan）。

![](images/gpteam-a-multi-agent-simulation/img_011.png)

![](images/gpteam-a-multi-agent-simulation/img_011.png)

Then we run `poetry run world` and we’re off! Let’s see how the agents proceed with an improv performance at the park...

随后我们执行命令 `poetry run world`，系统正式启动！让我们看看这些智能体如何在公园里展开一场即兴演出……

Within a few loops, you can see that the agents have started coordinating amongst each other about the performance. Marty asks if everyone is ready to go. Ricardo proposes a scene and assigns characters: Marty and Ricardo will be gardeners who stumble upon hidden treasure at the Park, and Rebecca will be the park ranger who notices them and starts to investigate. Rebecca accepts the premise and begins her performance:

仅经过几轮循环，你就能观察到智能体已就演出内容展开协调：Marty 首先询问大家是否准备就绪；Ricardo 提出一个场景构想并分配角色——Marty 和 Ricardo 将饰演在公园里偶然发现隐藏宝藏的园丁，Rebecca 则饰演注意到异常并开始调查的公园管理员；Rebecca 欣然接受该设定，并随即进入角色开始表演：

> The logs render the agent activity from most newest to oldest, so you should read from the bottom up.

> 日志按时间倒序显示智能体活动（最新在前、最旧在后），因此您应自下而上阅读。

![](images/gpteam-a-multi-agent-simulation/img_012.png)![](images/gpteam-a-multi-agent-simulation/img_013.png)

In this context, the agents don’t need to change plans much because their directives are all in harmony.  Thus, the dialog shown here is driven mainly by **observe** and **act.** But what happens when we set up our agents with more divergent directives?

在此情境中，各智能体无需频繁调整计划，因为它们的指令彼此协调一致。因此，此处展示的对话主要由 **observe（观察）** 和 **act（行动）** 驱动。但若我们为智能体设定更具分歧性的指令，又会发生什么？

Let’s run another example. Marty is bummed because he thinks his coworkers forgot about his birthday, but they’ve planned a suprise for him in his office. Unfortunately, Ricardo isn’t done setting up the decorations, so Rebecca is trying to distract Marty in the hallway outside to give Ricardo more time. Marty wants to just go back to his office to sulk.

我们来运行另一个示例：Marty 感到沮丧，因为他以为同事们忘记了他生日；但实际上，大家早已悄悄在他办公室里为他策划了一场惊喜派对。不幸的是，Ricardo 还未完成装饰布置，因此 Rebecca 正在办公室外的走廊上设法分散 Marty 的注意力，为 Ricardo 争取更多时间。而 Marty 却只想回到自己办公室独自生闷气。

Here we can see the Rebeccas comments about a new coffee machine has successfully inspired Marty to change his plans and engage with Rebecca instead.

此处我们可以看到，Rebecca 关于一台新咖啡机的评论成功促使 Marty 改变原计划，转而与 Rebecca 互动。

![](images/gpteam-a-multi-agent-simulation/img_014.png)

## Closing Thoughts

## 结语

Despite the project’s many robust features, I’m not confident that this architecture is optimized to produce a _productive_ output. There’s a lot of productivity lost in the fact that these agents rely on dialog to share their thoughts. A hive-mind architecture that creates and delegates tasks to ephemeral sub-agents only when needed (like AutoGPT) would likely perform better at complex digital tasks. This “shoggoth” architecture could share some or all of its scratchpad when needed instead of relying on dialog.

尽管本项目具备诸多稳健特性，但我并不确信当前架构已针对生成**高生产力输出**进行了充分优化。由于这些智能体必须依赖对话来共享彼此想法，大量生产力因此被损耗。相比之下，一种“蜂群思维”（hive-mind）式架构——仅在必要时动态创建并委派任务给临时子智能体（如 AutoGPT 所采用的方式）——在处理复杂数字任务时很可能表现更优。“修格斯”（shoggoth）式架构则可在需要时共享部分或全部草稿区（scratchpad），而非依赖对话传递信息。

That being said, there’s also an argument to be made that intentionally silo’d personalities and memories might contribute to a more effectively working entity, just like how diverse human-teams tend to produce better output than more homogenous ones. Divergent ideas create healthy debate. I’d be excited to see future projects create benchmarks with which we can test various configuration of agent workers.

话虽如此，也有人主张：有意隔离的个性与记忆，反而可能促成更高效运作的整体系统——正如多元化的真人团队往往比同质化团队产出更优成果。观点的分歧能激发富有建设性的讨论。我热切期待未来项目能建立标准化基准（benchmarks），用以评估各类智能体协作配置的实际效能。

The thought of applying multiple agents in a work setting is certainly intriguing, however, what I’m most excited about is use-cases in interactive entertainment. Creating your own multi-agent simulation is an incredibly exciting and novel experience. It gives a strange feeling of authorship, yet is unpredictable at the same time. Video games could use set ups like this to create organic never-ending NPC interactions. They could create simulated human-like characters that develop real emotional relationships with human players.

将多智能体系统应用于工作场景的构想固然引人入胜；但令我最为振奋的，却是其在交互式娱乐领域的应用潜力。亲手构建属于自己的多智能体仿真系统，是一种极为激动人心且前所未有的体验——它既赋予人一种奇特的“作者感”，又同时充满不可预测性。电子游戏可借助此类架构，生成自然流畅、永不停歇的非玩家角色（NPC）互动；甚至可创造出类人的模拟角色，使其与人类玩家之间发展出真实的情感联结。

I’m excited for future projects to build off of some of the ideas explored here, and solve for the limitations of our set up.  

我非常期待未来的项目能基于本文探讨的若干思路进一步拓展，并克服当前架构的局限性。

Speed is a big opportunity. Complex multi-agent systems rely on slow language models and convoluted agent loops. A forked version of GPTeam might commit more heavily to the goal of entertaining dialog, shedding the more _productive_ features of the project that are unecessary in that context. Such a project might be able to use more lightweight language models that are faster.

速度是一个巨大的优化机会。目前复杂的多智能体系统严重依赖响应缓慢的大语言模型，以及冗长繁复的智能体交互循环。一个 GPTeam 的分支版本或许可以更专注于“提供引人入胜的对话体验”这一目标，舍弃在该场景下不必要的、偏向“生产效率”的功能模块。这样的项目便有可能采用更轻量、响应更快的语言模型。

Another opportunity is in the interface: In its current state, the repo must be cloned and run locally. The lightweight UI we built is helpful, but it doesn’t make the project any more accessible to non-technical people. What if we could visualize the agents walking around in a virtual space. What if we could visually represent their emotions somehow? Our team is considering making some new features in this direction, and are happy to talk with others who have ideas!

另一个重要机会在于用户界面：当前版本必须克隆代码库并在本地运行。我们构建的轻量级 UI 虽然有一定帮助，但并未显著提升非技术用户对项目的可访问性。倘若我们能将智能体在虚拟空间中行走的过程可视化，又或者以某种方式直观呈现它们的情绪状态，会怎样？我们的团队正考虑朝这一方向开发新功能，也诚挚欢迎任何有相关想法的朋友与我们交流！

And finally, there’s a big opportunity in interactivity. The Sims would be a boring game if it was entirely passive. what if a human user could talk to the agents as if they were another character in the world? Maybe human players can trigger environmental actions that the characters respond to.

最后，交互性方面蕴藏着巨大潜力。《模拟人生》（The Sims）若完全被动，便会变得索然无味。倘若人类用户能像与虚拟世界中的另一位角色对话那样，直接与智能体交谈，会如何？也许玩家还能触发环境事件，而智能体则据此作出反应。

This project was a blast to build, and we’re all really appreciate of the reception its gotten. If you’re working on, or have ideas for future iterations of GPTeam, please hit me up on twitter [@itstimconnors](https://twitter.com/itstimconnors?ref=blog.langchain.com). Shout out to the rest of our team for the work they put in making this happen: [@alecvxyz](https://twitter.com/alecvxyz?ref=blog.langchain.com) [@joshsny](https://twitter.com/joshsny?ref=blog.langchain.com), and [@haniasnyder](https://twitter.com/haniasnyder?ref=blog.langchain.com) ❤️

这个项目开发过程充满乐趣，我们也由衷感谢大家的热情反馈与支持。如果您正在开展、或已有针对 GPTeam 未来迭代版本的构想，欢迎通过 Twitter 联系我：[@itstimconnors](https://twitter.com/itstimconnors?ref=blog.langchain.com)。同时，衷心感谢团队其他成员为本项目付出的努力：[@alecvxyz](https://twitter.com/alecvxyz?ref=blog.langchain.com)、[@joshsny](https://twitter.com/joshsny?ref=blog.langchain.com) 和 [@haniasnyder](https://twitter.com/haniasnyder?ref=blog.langchain.com) ❤️

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/gpteam-a-multi-agent-simulation/img_015.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI × LangChain：面向 AI 应用高效同步维护上下文](images/gpteam-a-multi-agent-simulation/img_015.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：面向 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/gpteam-a-multi-agent-simulation/img_016.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/gpteam-a-multi-agent-simulation/img_016.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/gpteam-a-multi-agent-simulation/img_017.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话](images/gpteam-a-multi-agent-simulation/img_017.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/gpteam-a-multi-agent-simulation/img_018.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/gpteam-a-multi-agent-simulation/img_018.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
