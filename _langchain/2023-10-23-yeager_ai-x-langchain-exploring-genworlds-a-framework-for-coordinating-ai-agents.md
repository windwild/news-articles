---
title: "Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/exploring-genworlds/"
date: "2023-10-23"
scraped_at: "2026-03-03T08:32:34.732583673+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_001.png)

**_Editor's Note: This is another edition of our series of guest posts highlighting the powerful applications of LangChain. We have been working with the [**_Yeager.ai_**](https://www.yeager.ai/?ref=blog.langchain.com) team for several months now, and they have built some really impressive applications of LangChain agents. We're excited to highlight this guest blog on their GenWorlds framework for multi-agent systems. We are especially excited to see their plan for making it seamless for the LangChain/GenWorlds community to monetize their projects._**

**编者按：** 这是我们系列客座文章的又一期，旨在展示 LangChain 的强大应用。过去数月来，我们一直与 [**Yeager.ai**](https://www.yeager.ai/?ref=blog.langchain.com) 团队紧密合作，他们已基于 LangChain Agent 构建出若干令人印象深刻的应用。我们非常高兴借此客座博文介绍 Yeager.ai 推出的面向多智能体系统的 GenWorlds 框架。尤其值得期待的是，他们正致力于打造一套顺畅便捷的机制，助力 LangChain / GenWorlds 社区轻松实现项目的商业化。

🧬🌍GenWorlds 是一个面向多智能体系统的开源开发[框架](https://github.com/yeagerai/genworlds/tree/main?ref=blog.langchain.com)。该框架的核心是专用的运行环境——即“[世界（Worlds）](https://genworlds.com/docs/genworlds-framework/worlds?ref=blog.langchain.com)”，每个“世界”内包含具备特定能力的 AI [智能体（Agents）](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com) 以及可供共享的 [对象（Objects）](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com)。在这些“世界”中，智能体通过共享对象协同工作，以执行复杂任务并达成共同目标。

我们的研究表明：聚焦于狭窄任务范围的智能体表现更优；因此，智能体间的协调协作，对于生成式 AI（GenAI）系统完成复杂操作而言至关重要。

## Developers Can Easily Monetize  
## 开发者可轻松实现商业化

Yeager.ai 正在构建一个面向生成式 AI 应用的稳健生态体系。该框架在设计之初便高度重视可组合性（composability）与互操作性（interoperability）。除框架本身外，GenWorlds 还将提供一个低运维负担的 GenAI 应用托管平台，以及一个开发者市场——让开发者能便捷地将其构建成果变现。

## The Power of Modularity  
## 模块化的力量

模块化是 GenWorlds [框架](https://github.com/yeagerai/genworlds/tree/main?ref=blog.langchain.com) 的核心设计理念。在软件工程中，将系统拆解为更小、更自洽的组件，有助于提升系统的可复用性与可靠性。这一原则同样适用于大语言模型（LLM）驱动的系统：对语言模型的每次调用越具体、越聚焦，其输出结果的可靠性就越高。GenWorlds [框架](https://github.com/yeagerai/genworlds/tree/main?ref=blog.langchain.com) 将这一理念贯彻至多个层面：

1. 不再依赖单一智能体包揽全部任务，GenWorlds 允许你创建多个智能体，每个智能体承担高度聚焦的子任务，并协同达成统一目标；  
2. 此外，每个智能体的思维过程被进一步分解为多个适配具体任务的“大脑（Brains）”。每个“大脑”仅需处理智能体整体上下文的一小部分，因而性能更优；  
3. 开发者可灵活配置每个“大脑”，使其支持“思维链（chain-of-thought）”、“自我评估（self-evaluation）”、“思维树（tree-of-thought）”等先进推理技术。该框架具备高度扩展性，可无缝兼容未来涌现的任何新型技术。

最终成果是：高度专注、高度可靠的智能体，能够充分释放底层语言模型的强大能力，高效达成复杂目标。

With this context set, now let’s dive into the 🧬🌍 GenWorlds [framework](https://github.com/yeagerai/genworlds/tree/main?ref=blog.langchain.com).

在设定好这一背景之后，现在让我们深入探索 🧬🌍 GenWorlds [框架](https://github.com/yeagerai/genworlds/tree/main?ref=blog.langchain.com)。

## World

## 世界（World）

The ' [Worlds](https://genworlds.com/docs/genworlds-framework/world?ref=blog.langchain.com)' is the setting for all the action. It keeps track of all the Agents, Objects, and World properties such as Agent inventories. The World ensures every Agent is informed about the World state, entities nearby, and the events that are available to them to interact with the World.

“[世界（Worlds）](https://genworlds.com/docs/genworlds-framework/world?ref=blog.langchain.com)”是所有行为发生的场景。它负责追踪所有智能体（Agents）、物体（Objects）以及世界属性（例如智能体的物品清单）。世界确保每个智能体都能及时获知当前世界状态、周边实体，以及可供其与世界交互的各类事件。

### World Definition YAML

### 世界定义 YAML 文件

For convenience, the [RoundTable](https://github.com/yeagerai/genworlds/tree/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable?ref=blog.langchain.com) example (a multi-agent podcast simulation, more on this below) comes with a loader which reads a world configuration from a YAML file. This allows everyone to quickly create and modify various worlds. Here is an example:

为便于使用，[RoundTable](https://github.com/yeagerai/genworlds/tree/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable?ref=blog.langchain.com) 示例（一个多智能体播客模拟系统，下文将详述）自带一个加载器，可从 YAML 文件读取世界配置。这使得用户能够快速创建和修改各类世界。以下是一个示例：

```bash
world_definition:
  base_args:
    websocket_url: ws://localhost:7456/ws
  world:
    id: world
    class: genworlds.worlds.world_2d.world_2d.World2D
    name: All-In Podcast
    description: The four "besties" discuss any topic you want.
    locations:
    - roundtable
    objects:
    - id: mic1
      ...
    agents:
    - id: jason_calacanis
...
```

```bash
world_definition:
  base_args:
    websocket_url: ws://localhost:7456/ws
  world:
    id: world
    class: genworlds.worlds.world_2d.world_2d.World2D
    name: All-In Podcast
    description: 四位“闺蜜”将围绕您指定的任何话题展开讨论。
    locations:
    - roundtable
    objects:
    - id: mic1
      ...
    agents:
    - id: jason_calacanis
...
```

## Simulation Socket

## 模拟套接字（Simulation Socket）

The “ [Simulation Socket](https://github.com/yeagerai/genworlds/tree/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/genworlds/simulation?ref=blog.langchain.com)” is a websocket server which serves as the communication backbone. It enables parallel operation of the World, Agents, and Objects, and allows them to communicate by sending events. This architecture supports connecting frontends or other services to the World, running Agents on external servers, and much more.

“[模拟套接字（Simulation Socket）](https://github.com/yeagerai/genworlds/tree/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/genworlds/simulation?ref=blog.langchain.com)”是一个 WebSocket 服务器，作为整个系统的通信主干。它支持世界（World）、智能体（Agents）与物体（Objects）的并行运行，并通过事件收发实现彼此通信。该架构支持将前端界面或其他服务接入世界、在外部服务器上运行智能体，以及更多扩展能力。

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_002.png)

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_002.png)

## Agents

## 智能体（Agents）

[Agents](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com)

[智能体（Agents）](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com)

GenWorlds 中的智能体（Agents）是构建在 LangChain 之上的自主实体，能够感知其周围环境，并根据用户设定的具体目标做出决策。这些智能体通过 Simulation Socket 服务器发送事件，与所处环境进行交互。它们能够动态学习关于“世界”（World）及其周围“物体”（Objects）的知识，并自主探索如何利用这些物体来达成自身目标。

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_003.png)

只要每种智能体都能理解用于与“世界”通信的事件协议，就可以存在多种不同类型的智能体。

## The Agent’s Mental Model

## 智能体的心智模型

智能体在与“世界”交互的每一步中，均遵循特定的[心智模型](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com#agent-mental-model)：

1. **回顾世界状态（Review World state）：** 智能体评估当前环境，以在规划任何行动之前充分理解上下文。
2. **回顾新事件（Review new events）：** 智能体评估“世界”中发生的任何新事件——这些事件可能来自其他智能体所采取的动作，也可能源于物体交互所引发的世界状态变化。
3. **记忆（Remember）：** 智能体借助其存储的[记忆](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com#custom-memories)以及对先前状态变更的认知，回溯过往经验与数据，从而辅助当前的决策过程。
4. **制定计划（Create a plan）：** 智能体依据世界状态的变化，生成并持续更新行动方案。单次执行步骤中，一个智能体可同时执行多个动作，从而提升整体效率。
5. **执行（Execution）：** 智能体落实其计划，由此改变世界状态，并可能触发其他智能体的响应。

这一交互式流程促进了复杂、自主行为的涌现，使每个智能体都成为“世界”中真正活跃的参与者。

## The Thinking Process

## 思维过程

代码中的 `think()` 方法是智能体[思维过程](https://genworlds.com/docs/genworlds-framework/agents/thought_actions?ref=blog.langchain.com)的核心实现函数。该函数首先获取“世界”的初始状态及潜在可执行动作；随后进入一个循环，在此过程中持续处理事件，并评估智能体邻近范围内的各类实体，以支撑其决策。

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_004.png)

Depending on the current state and goals of the Agent, the `think()` function may choose to wait, respond to user input, or interact with entities. If the Agent selects an action, it executes it and updates its memory accordingly. The `think()` function continually updates the Agent's state in the World and repeats the process until it decides to exit. See diagram below showing the Agent Loop in [RoundTable](https://genworlds.com/docs/example-usecases/roundtable?ref=blog.langchain.com), our podcast simulation application:

根据 Agent 当前的状态和目标，`think()` 函数可能选择等待、响应用户输入，或与实体交互。若 Agent 选择了某个动作，它将执行该动作并相应更新其记忆。`think()` 函数持续更新 Agent 在 World 中的状态，并不断重复该过程，直至决定退出。以下示意图展示了我们在播客模拟应用 [RoundTable](https://genworlds.com/docs/example-usecases/roundtable?ref=blog.langchain.com) 中的 Agent 循环：

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_005.png)

## Components of an Agent

## Agent 的组成部分

[**Brains**](https://genworlds.com/docs/genworlds-framework/agents/thought_actions/?ref=blog.langchain.com) **:** A Brain is a system that controls one step of an Agent's thinking process. It manages the process of thought generation, evaluation, and selection. The Brain defines the functions necessary for these processes and uses a Large Language Model to generate and evaluate thoughts. All Brains take full advantage of OpenAI Functions to allow easy specification of the desired output format.

[**大脑（Brains）**](https://genworlds.com/docs/genworlds-framework/agents/thought_actions/?ref=blog.langchain.com)：大脑（Brain）是一套控制系统，负责控制 Agent 思维过程中的单个步骤。它管理思维生成、评估与筛选的全过程；定义完成这些过程所需的函数，并利用大语言模型（LLM）来生成和评估思维。所有大脑均充分利用 OpenAI Functions，以便便捷地指定期望的输出格式。

Most Agents have the following Brain types:

大多数 Agent 具备以下几类大脑：

[**Navigation**](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/thoughts/navigation_thought.py?ref=blog.langchain.com#L9) **Brain:** The Navigation Brain is designed for selecting the next action of the agent which helps it achieve its goals. It generates a plan for the Agent's next steps in the World. The inputs to this class include the Agent's information (name, role, background, personality), goals, constraints, evaluation principles, and the number of thoughts to generate. It generates a set of possible plans, each consisting of an action to take, whether the action is valid, any violated constraints, and an updated plan. The NavigationBrain then evaluates these plans and selects the one that best meets the evaluation principles and constraints.

[**导航大脑（Navigation Brain）**](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/thoughts/navigation_thought.py?ref=blog.langchain.com#L9)：导航大脑专为选择 Agent 的下一步动作而设计，以助其达成目标。它为 Agent 在 World 中的后续行动生成计划。该类的输入包括 Agent 的基本信息（名称、角色、背景、性格）、目标、约束条件、评估原则，以及需生成的思维数量。它会生成一组候选计划，每个计划包含：拟执行的动作、该动作是否有效、是否存在违反的约束，以及更新后的计划。随后，导航大脑对这些候选计划进行评估，并选出最符合评估原则与约束条件的一项。

Sometimes you want to constrain the sequence of actions and force the Agent to follow a certain action with another one — this can be done using the [Action-Brain map](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#the-action-brain-map).

有时，您希望约束动作的执行顺序，强制 Agent 在执行某一动作后必须紧接着执行另一动作——这可通过 [Action-Brain 映射表（Action-Brain map）](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#the-action-brain-map) 实现。

Here you can see the constructor of a NavigationBrain:

以下是 NavigationBrain 的构造函数示例：

```bash
NavigationBrain(
    openai_api_key=openai_api_key,
    name=name,
    role=role,
    background=background,
    personality=personality,
    topic_of_conversation=topic_of_conversation,
    constraints=constraints,
    evaluation_principles=evaluation_principles,
    n_of_thoughts=3,
),
```

The `n_of_thoughts=3` parameter specifies that the Brain will generate 3 possible next actions and pick the best one according to its `evaluation_principles`.

参数 `n_of_thoughts=3` 表示该大脑将生成 3 个可能的下一步动作，并依据其 `evaluation_principles`（评估原则）从中选出最优的一个。

**Execution Brains:** [Execution Brains](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#execution-brains) enable the execution of diverse tasks by Agents. These Brains accept Agent details, task attributes, constraints, and evaluation parameters. These brains can be configured to generate their output in a single call, or generate multiple potential outputs and select the best one using self-evaluation techniques.

**执行大脑（Execution Brains）：** [执行大脑](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#execution-brains) 使智能体（Agents）能够执行多种多样的任务。此类大脑接收智能体的详细信息、任务属性、约束条件以及评估参数。它们可被配置为单次调用即生成输出，也可生成多个潜在输出，并通过自评估技术从中选出最优解。

The power of Execution Brains lies in their customizability. Developers can create Brains adapted for various tasks such as participating in a podcast, writing an essay, analyzing data, or scraping social media feeds. This flexibility allows the creation of uniquely skilled Agents capable of performing a wide array of tasks in their simulated environments.

执行大脑的强大之处在于其高度可定制性。开发者可针对不同任务（例如参与播客录制、撰写议论文、分析数据或抓取社交媒体动态）构建专属大脑。这种灵活性使得开发者能够创建具备独特技能的智能体，使其在模拟环境中胜任广泛多样的任务。

The following is a constructor of an example execution brain - the PodcastBrain:

以下是一个执行大脑示例——PodcastBrain 的构造函数：

```bash
PodcastBrain(
    openai_api_key=openai_api_key,
    name=name,
    role=role,
    background=background,
    personality=personality,
    communication_style=communication_style,
    topic_of_conversation=topic_of_conversation,
    constraints=constraints,
    evaluation_principles=evaluation_principles,
    n_of_thoughts=1,
),
```

Here, the n\_of\_thoughts is set to 1, meaning the Podcast Brain will generate only one output message and skip the evaluation step.

此处 `n_of_thoughts` 被设为 1，表示该播客大脑（Podcast Brain）仅生成一条输出消息，跳过评估步骤。

**Event Filler Brain:** The [Event Filler](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/thoughts/event_filler_thought.py?ref=blog.langchain.com#L9) Brain is used for generating the JSON parameters required for an action the Agent executes in a World. The inputs are similar to the Navigation Brain but also include the command the Agent has decided to execute, as well as the outputs of any previous brains in the execution flow.

**事件填充大脑（Event Filler Brain）：** [事件填充大脑](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/thoughts/event_filler_thought.py?ref=blog.langchain.com#L9) 用于生成智能体在“世界”（World）中执行某项动作所需的 JSON 参数。其输入与导航大脑（Navigation Brain）类似，但额外包含智能体已决定执行的具体指令，以及执行流程中此前各大脑所产生的输出。

You can see it takes fewer parameters than the other Brains, because it doesn't need as much context to complete its task.

可以看出，它所需参数比其他大脑更少，因其完成任务本身并不需要大量上下文信息。

```bash
EventFillerBrain(
    openai_api_key=openai_api_key,
    name=name,
    role=role,
    background=background,
    topic_of_conversation=topic_of_conversation,
    constraints=constraints,
    evaluation_principles=evaluation_principles,
    n_of_thoughts=1,
),
```

Different types of Brains can be created to handle different tasks, scenarios, or problems. An Agent can have multiple Brains each focused on a specific goal with its context tailored to that goal. For instance, a podcaster Agent would have a “Content Brain” which would be its only Brain that possesses information about the Agent’s communication-style.

可构建不同类型的大脑以应对不同任务、场景或问题。一个智能体可配备多个大脑，每个大脑均聚焦于特定目标，且其上下文亦针对该目标进行定制。例如，一位播客主智能体将拥有一个“内容大脑（Content Brain）”，而该大脑是其唯一掌握该智能体沟通风格相关信息的大脑。

Using multiple Brains helps narrow the Agent’s focus and thus significantly enhances the quality and reliability of an Agent's output. Additionally, each Brain can use a different LLM, which allows you to further optimize the system. For instance certain actions or decisions require more powerful LLMs (e.g. GPT-4) while other steps can be done with more simple, faster, and cheaper LLMs (e.g. GPT-3.5).

采用多个大脑有助于收束智能体的关注焦点，从而显著提升其输出的质量与可靠性。此外，每个大脑均可调用不同的大语言模型（LLM），这为进一步优化系统提供了可能。例如，某些关键动作或决策需依赖更强大的 LLM（如 GPT-4），而其他环节则可交由更轻量、更快捷、更经济的 LLM（如 GPT-3.5）来完成。

**Action-Brain Map:** The [Action-Brain Map](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#the-action-brain-map) of an Agent defines a deterministic path through the various Brains. It's the system that decides which Brain to use based on the Agent's next action. The output of each brain is passed on to the consecutive brain in the execution brain path of that action. From our Podcaster Agent example above, it will engage the Content Brain when the Agent is about to speak, and pass the output to the Event Filler Brain to generate a valid World event with the generated response.

**动作-大脑映射（Action-Brain Map）：** Agent 的 [动作-大脑映射](https://genworlds.com/docs/genworlds-framework/agents/think?ref=blog.langchain.com#the-action-brain-map) 定义了其在各类“大脑（Brains）”之间执行的确定性路径。该系统依据 Agent 即将采取的动作，决定调用哪一个“大脑”。每个“大脑”的输出将被传递至该动作所对应执行路径中的下一个“大脑”。以我们上方的播客主持人 Agent（Podcaster Agent）示例为例：当 Agent 即将开口说话时，它会调用内容大脑（Content Brain），并将输出结果传递给事件填充大脑（Event Filler Brain），由后者生成一条符合规范的世界（World）事件。

You can furthermore specify a deterministic follow-up for each action if you don't want the agent to choose freely - for example, after speaking into the microphone, the Agent must pass it to someone else. This allows you to constrain the Agent to create more predictable execution paths and increase reliability.

此外，您还可为每个动作显式指定一个确定性的后续动作，从而避免 Agent 自主选择——例如，在对着麦克风讲话之后，Agent 必须将麦克风转交给另一位 Agent。这种方式有助于约束 Agent 的行为，使其执行路径更可预测，从而提升整体可靠性。

Here's what that looks like in code:

以下是在代码中实现该逻辑的方式：

```bash
action_brain_map = {
    "Microphone:agent_speaks_into_microphone": {"brains":[\
        "podcast_brain",\
        "event_filler_brain",\
    ], "next_actions": ["World:agent_gives_object_to_agent_event"]},
    "World:agent_gives_object_to_agent_event":        {"brains":["event_filler_brain"], "next_actions": []},
    "default": {"brains":["event_filler_brain"], "next_actions": []},
}
```

**Agent Inventory**: The specific [Objects](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com) that an Agent currently holds. This state is maintained by the world, and allows Agents to pass items such as Tokens from one to another, and keep Objects with them as they move to different locations in the [World](https://genworlds.com/docs/genworlds-framework/world?ref=blog.langchain.com#world2d).

**Agent 物品清单（Agent Inventory）：** Agent 当前持有的特定 [对象（Objects）](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com)。该状态由世界（World）统一维护，使得 Agent 之间可以相互传递物品（如 Token），并在移动至 [世界（World）](https://genworlds.com/docs/genworlds-framework/world?ref=blog.langchain.com#world2d) 不同位置时随身携带这些对象。

## Memories: Current and Pregenerated

## 记忆：当前记忆与预生成记忆

Agents in GenWorlds have two types of [memories](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com#baseagent), current and pregenerated memories:

GenWorlds 中的 Agent 拥有两种类型的 [记忆（Memories）](https://genworlds.com/docs/genworlds-framework/agents/?ref=blog.langchain.com#baseagent)：当前记忆（Current Memories）与预生成记忆（Pregenerated Memories）：

1. Current Memories: Agents remember \[number\] of the most recent events, \[number\] of the most relevant events, and a running summary of the whole history. The number of recent and relevant memories is configurable by the user.
1. 当前记忆：Agent 会记住最近发生的 \[number\] 个事件、与当前上下文最相关的 \[number\] 个事件，以及整个历史的持续更新摘要。其中“最近事件”与“相关事件”的数量均可由用户配置。

2. Pregenerated Memories: Generated from external content (e.g. youtube videos, books, etc.) and stored in vector dbs. Pre-generated memories are injected in Agents’ prompts based on their relevance to the Agent's current goals, allowing for more focused and reliable interactions. These memories allow Agents to learn without fine-tuning the underlying model.

2. 预生成记忆：由外部内容（例如 YouTube 视频、书籍等）生成，并存储于向量数据库中。系统会根据这些记忆与 Agent 当前目标的相关性，将其动态注入 Agent 的提示词（prompt）中，从而支持更聚焦、更可靠的交互。此类记忆使 Agent 能够在不微调底层大模型的前提下实现持续学习。

_Below is how you can easily configure custom pregenerated memories in a World definition YAML file, which are stored in a [_Qdrant_](http://qdrant.tech/?ref=blog.langchain.com) vector database:_

_以下是如何在世界（World）定义的 YAML 文件中便捷地配置自定义预生成记忆的方法——这些记忆将被存入 [_Qdrant_](http://qdrant.tech/?ref=blog.langchain.com) 向量数据库：_

_To use the memories, you need to set the following values in the world\_definition.yaml file_

要启用这些记忆功能，您需在 `world_definition.yaml` 文件中设置以下参数：

```bash
world_definition:
  world:
    path_to_to_external_memory: ./databases/summaries_qdrant
```

```bash
世界定义：
  world:
    path_to_to_external_memory: ./databases/summaries_qdrant
```

_For each Agent you need to specify the collection name_

_每个 Agent 都需指定其对应的集合名称_

```bash
agents:
-  id: maria
   personality_db_collection_name: maria
```

```bash
agents:
-  id: maria
   personality_db_collection_name: maria
```

## Objects

## 对象

[Objects](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com) play a crucial role in facilitating interaction between Agents. Every Object defines a unique set of events, enabling Agents to accomplish specific tasks and work together in a dynamic environment. Objects can be in an Agent's vicinity or can be part of their inventory, expanding the scope of possible interactions.

[对象（Objects）](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com) 在促进 Agent 之间的交互中起着关键作用。每个对象都定义了一组独特的事件，使 Agent 能够完成特定任务，并在动态环境中协同工作。对象可位于 Agent 周围，也可纳入其物品栏（inventory），从而拓展潜在交互的范围。

Agents are designed to adapt dynamically, learning about nearby Objects, understanding the event definitions, and determining the best way to interact with them to achieve their goals. Objects are the main way to give Agents new capabilities and organize them in a structure to achieve a collective broader goal.

Agent 的设计目标是实现动态自适应：它们能主动感知周边对象、理解其事件定义，并据此确定最优交互方式以达成自身目标。对象是赋予 Agent 新能力的主要途径，也是将多个 Agent 组织成结构化协作体系、共同实现更宏大集体目标的核心机制。

## Agent Coordination

## Agent 协调机制

Since Agents are aware of the events in the World including those of the other Agents, Agents naturally react to each other. In order to facilitate structure and organized behavior between the Agents we use shared Objects. See three examples below:

由于 Agent 能感知整个世界中的各类事件（包括其他 Agent 触发的事件），它们会自然地相互响应。为促进 Agent 之间具备结构性与组织性的行为模式，我们采用共享对象（shared Objects）。以下为三个典型示例：

**“Token Bearer”:** Agents use a Token in their inventory to communicate and to signal to the other Agents whose turn it is to perform an action. For example, in RoundTable (our podcast simulation app), Agents use a [microphone](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/objects/microphone.py?ref=blog.langchain.com#L8) as a token to speak to each other. Agents can only speak if they have the mic in their inventory. This ensures the Agents listen to each other and prevents them from interrupting each other, thus creating a dynamic discussion.

**“令牌持有者（Token Bearer）”机制**：Agent 通过持有物品栏中的一枚“令牌（Token）”进行通信，并向其他 Agent 明确标识当前轮到谁执行操作。例如，在 RoundTable（我们开发的播客模拟应用）中，Agent 将一支[麦克风（microphone）](https://github.com/yeagerai/genworlds/blob/0e2f5295a0bd74b229170dd28cb4f1d185feb5cb/use_cases/roundtable/objects/microphone.py?ref=blog.langchain.com#L8)作为发言令牌。仅当某 Agent 的物品栏中持有该麦克风时，才被允许发言。这一机制确保了各 Agent 能专注倾听彼此，避免相互打断，从而营造出富有张力与节奏感的动态讨论氛围。

![](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_006.png)

_This is how it looks in the code_

_代码中就是这样表示的_

```bash
world_definition:
  world:
    path_to_to_external_memory: ./databases/summaries_qdrant
```

```bash
world_definition:
  world:
    path_to_to_external_memory: ./databases/summaries_qdrant
```

**Pipeline:** Each Agent is assigned a role in the pipeline and completes their role when it’s their turn. It’s like a factory line. For example, most sales processes go something like this:

Research > obtain contact info > create/send a compelling outreach message > follow up > schedule/conduct a call > review call notes > send/negotiate legal docs > follow-ups/calls > and on and on until the deal is won/lost.

**流水线（Pipeline）：** 每个 Agent 在流水线中被分配一个特定角色，并在轮到自己时完成该角色对应的任务——这就像一条工厂流水线。例如，大多数销售流程大致遵循如下顺序：

调研 > 获取联系人信息 > 撰写并发送有吸引力的初次触达信息 > 跟进 > 安排并开展电话沟通 > 回顾通话纪要 > 发送/协商法律文件 > 进一步跟进或通话 > 如此往复，直至交易成功或失败。

To facilitate this sort of an operation, you would create a set of Objects such as boxes, where each agent can put their work output, and the next Agent in the pipeline can look to see when a new item has been passed to them, pick it up, process it according to the step of the pipeline they're in, and put in in the next box.

为支持此类协作方式，你可以创建一组类似“箱子”的 Object：每个 Agent 将自己的工作成果放入其中某个“箱子”，而流水线中的下一个 Agent 则可监测是否有新内容被传递进来，随即取出、按其所处流水线环节的要求进行处理，并将结果放入下一个“箱子”。

Pipeline is best for sequential tasks like in the sales example.

流水线模式最适合销售示例中这类具有明确先后顺序的任务。

**Project Management:** A project manager (human or Agent) uses a Blackboard, an Object for assigning roles to each Agent and keeping track of progress. The Project Manager and the Agents interact via the Blackboard, sharing files, updating assignments, tracking progress, etc.

**项目管理（Project Management）：** 一位项目经理（可以是人类，也可以是 Agent）使用“黑板（Blackboard）”这一 Object，来为各 Agent 分配角色并跟踪整体进展。项目经理与各 Agent 均通过黑板进行交互，例如共享文件、更新任务指派、追踪进度等。

**Tools:** Agents can use Tools to execute specific functions such as calling external APIs, running complex calculations, or triggering unique events in the World.

**工具（Tools）：** Agent 可调用各类工具（Tools）执行特定功能，例如调用外部 API、运行复杂计算，或在 World 中触发特定事件。

The framework provides the flexibility for anyone to create their own Objects and coordination methods.

该框架提供了高度灵活性，允许任何人自定义 Object 和协同机制。

## Use Case Highlight - RoundTable

## 应用场景亮点 —— RoundTable

In order to showcase the coordination capabilities of Agents in GenWorlds, we built [RoundTable](https://genworlds.com/docs/example-usecases/roundtable?ref=blog.langchain.com), a podcast simulation.  
为了展示 GenWorlds 中 Agents 的协同能力，我们构建了播客模拟项目 [RoundTable](https://genworlds.com/docs/example-usecases/roundtable?ref=blog.langchain.com)。

Users can summon the brightest minds for a group discussion on any topic.  
用户可随时召唤各领域最杰出的“思想家”，围绕任意主题展开小组讨论。

It's not another ChatGPT wrapper; it’s a team of AI Agents acting independently with specific personalities, memories, and expertise.  
它并非又一个 ChatGPT 封装工具；而是一支由多个 AI Agents 组成的团队——每个 Agent 均独立运作，拥有独特的个性、记忆与专业专长。

RoundTable uses Objects, Agent inventories, and pre-generated memories to create dynamic discussions between Agents who sound like the people they are emulating. See a demo here:  
RoundTable 利用 Objects（对象）、Agent 的物品库存（inventories）以及预生成的记忆（pre-generated memories），驱动 Agents 之间展开生动自然的对话，使其言谈举止高度贴近其所模拟的真实人物。观看演示视频：

You can also try it for free on Replit  
您还可免费在 Replit 上体验该应用：

1. Go to [Replit](https://replit.com/@yeagerai/GenWorlds?ref=blog.langchain.com)  
1. 访问 [Replit](https://replit.com/@yeagerai/GenWorlds?ref=blog.langchain.com)

2. Fork the Replit (it’s completely free)  
2. 复刻（Fork）该项目（完全免费）

3. Select which use case you want to use  
3. 选择您想尝试的具体应用场景

## The GenAI Ecosystem - Our Northstar  

## 通用人工智能（GenAI）生态体系——我们的北极星愿景

We designed the GenWorlds framework with modularity, flexibility, and composability. We envision GenAI developers using this modularity to plug and play or build each element of the framework (Worlds, Agents, Objects, Memories, Brains, etc.) to create their own useful applications.  
我们以模块化（modularity）、灵活性（flexibility）与可组合性（composability）为原则设计了 GenWorlds 框架。我们期望 GenAI 开发者能充分利用其模块化特性，即插即用，或自主构建框架中的任一组件（如 Worlds、Agents、Objects、Memories、Brains 等），从而开发出真正实用的应用程序。

We are not stopping there. We are giving our developer community a [platform](https://genworlds.com/docs/platform/genworlds-marketplace?ref=blog.langchain.com) and the [tools](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com) for easy access to monetizing their applications in a Gen-AI marketplace.  
我们的探索远不止于此。我们正为开发者社区提供一个[平台](https://genworlds.com/docs/platform/genworlds-marketplace?ref=blog.langchain.com)与一系列[工具](https://genworlds.com/docs/genworlds-framework/objects?ref=blog.langchain.com)，助力其轻松实现应用程序在 Gen-AI 应用市场中的商业化变现。

## Learn More About 🧬🌍GenWorlds  

## 进一步了解 🧬🌍GenWorlds

Demo: [https://youtu.be/INsNTN4S680](https://youtu.be/INsNTN4S680?ref=blog.langchain.com)  
演示视频：[https://youtu.be/INsNTN4S680](https://youtu.be/INsNTN4S680?ref=blog.langchain.com)

GitHub: [https://github.com/yeagerai/genworlds](https://github.com/yeagerai/genworlds?ref=blog.langchain.com)  
GitHub 仓库：[https://github.com/yeagerai/genworlds](https://github.com/yeagerai/genworlds?ref=blog.langchain.com)

Docs: [https://genworlds.com/docs/intro](https://genworlds.com/docs/intro?ref=blog.langchain.com)

文档：[https://genworlds.com/docs/intro](https://genworlds.com/docs/intro?ref=blog.langchain.com)

Discord: [https://discord.gg/wKds24jdAX](https://discord.gg/wKds24jdAX?ref=blog.langchain.com)

Discord：[https://discord.gg/wKds24jdAX](https://discord.gg/wKds24jdAX?ref=blog.langchain.com)

Blog: [https://medium.com/yeagerai](https://medium.com/yeagerai?ref=blog.langchain.com)

博客：[https://medium.com/yeagerai](https://medium.com/yeagerai?ref=blog.langchain.com)

Replit: [https://replit.com/@yeagerai/GenWorlds](https://replit.com/@yeagerai/GenWorlds?ref=blog.langchain.com)

Replit：[https://replit.com/@yeagerai/GenWorlds](https://replit.com/@yeagerai/GenWorlds?ref=blog.langchain.com)

## About Yeager

## 关于 Yeager

At Yeager.ai, we are on a mission to enhance the quality of life through the power of Generative AI. Our goal is to eliminate the burdensome aspects of work by making GenAI reliable and easily accessible. By doing so, we foster a conducive environment for learning, innovation, and decision-making, propelling technological advancement.

在 Yeager.ai，我们的使命是借助生成式人工智能（Generative AI）的力量提升人类生活质量。我们的目标是通过让生成式 AI（GenAI）更可靠、更易获取，从而消除工作中的繁重负担；由此营造一个有利于学习、创新与决策的环境，推动技术进步。

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_007.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI × LangChain：为 AI 应用高效同步维护上下文](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_007.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_008.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**使数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_009.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[![Conversational Retrieval Agents](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_010.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体（Conversational Retrieval Agents）**](https://blog.langchain.com/conversational-retrieval-agents/)


[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)


[![LangChain Expression Language](images/yeager_ai-x-langchain-exploring-genworlds-a-framework-for-coordinating-ai-agents/img_011.jpg)](https://blog.langchain.com/langchain-expression-language/)

[**LangChain 表达式语言（LangChain Expression Language）**](https://blog.langchain.com/langchain-expression-language/)
&#123;% endraw %}
