---
render_with_liquid: false
title: "LangMem SDK for agent long-term memory"
source: "LangChain Blog"
url: "https://blog.langchain.com/langmem-sdk-launch/"
date: "2025-05-13"
scraped_at: "2026-03-03T07:32:22.569538599+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Today we're releasing the LangMem SDK, a library that helps your agents learn and improve through long-term memory.

今天我们正式发布 LangMem SDK——一个助力智能体通过长期记忆实现持续学习与优化的开发库。

It provides tooling to extract information from conversations, optimize agent behavior through prompt updates, and maintain long-term memory about behaviors, facts, and events.

它提供一系列工具，用于从对话中提取信息、通过提示词（prompt）更新来优化智能体行为，并持久化存储关于行为、事实和事件的长期记忆。

You can use its core API with any storage system and within any Agent framework, and it integrates natively with LangGraph's long-term memory layer. We are also launching a managed service that provides additional long-term memory results for free - sign up [here](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com) if you are interested in using it in production.

您可将 LangMem 的核心 API 与任意存储系统及任意智能体（Agent）框架配合使用；它原生支持 LangGraph 的长期记忆层。此外，我们同步推出一项托管服务（managed service），免费提供增强版的长期记忆能力——若您计划在生产环境中使用，请点击此处注册：[链接](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com)。

Our goal is to make it easier for **anyone** to build AI experiences that become smarter and more personalized over time. This work builds on our previous work of the hosted LangMem [alpha service](https://blog.langchain.com/langfriend/) and LangGraph's persistent [long-term memory layer](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/).

我们的目标是让**任何人**都能更轻松地构建随时间推移而愈发智能、更加个性化的 AI 体验。本项目延续并深化了我们此前推出的托管式 LangMem [Alpha 版服务](https://blog.langchain.com/langfriend/)，以及 LangGraph 中已发布的持久化 [长期记忆层](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/)。

To install, just run:

安装方法如下：

```shell
pip install -U langmem
```

## Quick links

## 快捷链接

- Documentation: \[ [link](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com)\]  
- 文档：\[ [链接](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com)\]

- Managed Service Signup: \[ [link](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com)\]  
- 托管服务注册：\[ [链接](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com)\]

- Video Tutorials:  
- 视频教程：

  - Concepts: \[ [link](https://youtu.be/snZI5ojuMRc?ref=blog.langchain.com)\]  
  - 概念解析：\[ [链接](https://youtu.be/snZI5ojuMRc?ref=blog.langchain.com)\]

  - Semantic Memory in LangMem: \[ [link](https://youtu.be/3Yp-hIEcWXk?ref=blog.langchain.com)\]  
  - LangMem 中的语义记忆：\[ [链接](https://youtu.be/3Yp-hIEcWXk?ref=blog.langchain.com)\]

  - Procedural Memory in LangMem: \[ [link](https://youtu.be/WW-v5mO2P7w?ref=blog.langchain.com)\]  
  - LangMem 中的程序性记忆：\[ [链接](https://youtu.be/WW-v5mO2P7w?ref=blog.langchain.com)\]

## On memory and adaptive agents

## 关于记忆与自适应智能体

Agents use memory to learn, but the way their memories are formed, stored, updated, and retrieved impacts types of things your agent can learn to know or do. At LangChain, we’ve found it useful to **first** identify the capabilities your agent needs to be able to learn, map these to specific memory types or approaches, and only then implement them in your agent. Before adding memory, we think you should consider:

智能体借助记忆实现学习，但其记忆的形成方式、存储机制、更新策略与检索模式，将直接影响该智能体所能习得的知识类型与可执行的任务范畴。在 LangChain，我们发现一种行之有效的方法是：**首先**明确您的智能体需要掌握哪些学习能力，再将这些能力映射至特定的记忆类型或技术路径，最后才在智能体中予以实现。因此，在为智能体添加记忆功能之前，我们建议您先认真思考以下问题：

- **What behavior should be learned (user-informed) vs. pre-defined?**  
- **应学习的行为（由用户引导）与预定义行为之间的界限是什么？**

- **What types of knowledge or facts should be tracked?**  
- **应追踪哪些类型的知识或事实？**

- **What conditions should trigger a memory to be recalled?**  
- **在何种条件下应触发记忆的调用？**

While there may be some overlap, each memory type serves distinct functions when building adaptive agents:  
尽管这些记忆类型之间可能存在一定重叠，但在构建自适应智能体时，每种记忆类型都承担着明确而独特的功能：

| Memory Type | Purpose | Agent Example | Human Example | Typical Storage Pattern |
| --- | --- | --- | --- | --- |
| Semantic | Facts & Knowledge | User preferences; knowledge triplets | Knowing Python is a programming language | Profile or Collection |
| 语义记忆 | 事实与知识 | 用户偏好；知识三元组 | 知道 Python 是一种编程语言 | 用户档案（Profile）或向量数据库集合（Collection） |

| Episodic | Past Experiences | Few-shot examples; Summaries of past conversations | Remembering your first day at work | Collection |
| 情景记忆 | 过去经历 | 少样本示例；过往对话摘要 | 记得你入职的第一天 | 向量数据库集合（Collection） |

| Procedural | System Behavior | Core personality and response patterns | Knowing how to ride a bicycle | Prompt rules or Collection |
| 程序性记忆 | 系统行为 | 核心人格特征与响应模式 | 知道如何骑自行车 | 提示词规则（Prompt rules）或向量数据库集合（Collection） |

So then revisiting our questions above:  
因此，我们重新审视上述三个问题：

- **What behavior should be learned vs. fixed?** Some aspects of your agent's behavior may need to adapt based on feedback and experience, while others should remain consistent. This will guide whether you need **procedural memory** to evolve behavior patterns, or if fixed prompt rules are sufficient. This is similar in spirit to the concept of the "chain of command" in OpenAI's model spec since learned behaviors are shaped by user interactions.  
- **行为应动态学习还是保持固定？** 智能体的部分行为可能需根据用户反馈与交互经验持续调整，而另一些行为则应保持稳定一致。这将决定你是否需要借助**程序性记忆**来演化行为模式，抑或仅依赖静态提示词规则即可满足需求。这一设计思路与 OpenAI 模型规范中提出的“指令执行链（chain of command）”概念精神相通——因为经由用户交互所习得的行为，本质上正是在该链条中被逐步塑造而成。

- **What types of knowledge or facts should be tracked?**  
- **应追踪哪些类型的知识或事实？**

Different use cases require different types of knowledge persistence. You might need **semantic memory** to maintain facts about users or domains, **episodic memory** to learn from successful interactions, or both working together.  
不同应用场景对知识持久化的需求各不相同：你可能需要**语义记忆**来维护关于用户或特定领域的事实性信息；也可能需要**情景记忆**从成功交互中汲取经验；更常见的是二者协同工作。

- **What conditions should trigger a memory to be recalled?**  
- **在何种条件下应触发记忆的调用？**

Some memories (core procedural memory) may be **data-independent** — they are always present in the prompt. Some are **data-dependent** and may be recalled based on semantic similarity. Others may be recalled based on a combination of application context, similarity, time, etc.  
部分记忆（如核心程序性记忆）可能是**数据无关型（data-independent）**——它们始终被嵌入提示词中；另一些则是**数据相关型（data-dependent）**，其调用依赖于语义相似度匹配；还有一些则可能综合应用上下文、相似度、时间戳等多种因素进行触发。

A related concern is memory privacy. In LangMem, all memories are given a **namespace**. The most common namespaces would include a `user_id` in order to prevent cross-over of user memories. In general, memories can be scoped to particular app routes, to individual users, shared across teams, or the agent could learn core procedures across all users. The extent of memory sharing is determined both by privacy and performance needs.  
与此密切相关的是**记忆隐私问题**。在 LangMem 中，所有记忆均被赋予一个**命名空间（namespace）**。最常见的命名空间会包含 `user_id`，以防止不同用户间的记忆交叉混用。总体而言，记忆的作用域可限定于特定应用路由（app route）、单个用户、跨团队共享，甚至允许智能体在全体用户数据基础上学习通用核心流程。记忆共享的范围，最终由隐私保护要求与系统性能需求共同决定。

All of these memory types are meant to address recall **beyond individual conversations**. Memory within a given conversation, or thread, is already handled reasonably well using checkpointing in LangGraph (so long as it doesn’t extend beyond the model’s effective context window), which serves as the “short-term” or “working” memory system for your agent.  
上述所有记忆类型，其设计目标均为支持**跨对话（beyond individual conversations）** 的长期信息召回。而在单次对话（即单个 thread）内部的记忆管理，LangGraph 已通过检查点机制（checkpointing）提供了良好支持——只要其长度未超出模型的有效上下文窗口，该机制即可作为智能体的“短期记忆”或“工作记忆”系统。

Note that this also differs from standard RAG in a couple ways. One is the way the information is gained: through interaction rather than offline data ingestion. The other is in the type of information that’s prioritized. Below, we will share more about the memory types in more detail.  
需要注意的是，该记忆架构与标准 RAG（检索增强生成）也存在若干关键差异：其一在于信息获取方式——本方案强调通过**实时交互**动态积累，而非依赖离线数据导入；其二在于所优先处理的信息类型。下文我们将进一步深入介绍各类记忆的具体实现与应用细节。

### Semantic memory: facts

### 语义记忆：事实

[Semantic memory](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#semantic-memory) stores key facts (and their relationships) and other information that ground an agent's responses. It lets your agent remember important details that wouldn’t be “pre-trained” into the model itself and that isn’t accessible from a web search or generic retriever.

[语义记忆](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#semantic-memory) 用于存储关键事实（及其相互关系）以及其他支撑智能体响应的信息。它使您的智能体能够记住那些未被“预训练”进模型本身、也无法通过网络搜索或通用检索器获取的重要细节。

![](images/langmem-sdk-for-agent-long-term-memory/img_001.png)Code

```python

from langmem import create_memory_manager

manager = create_memory_manager(
    "anthropic:claude-3-5-sonnet-latest",
    instructions="Extract user preferences and facts",
    enable_inserts=True
)

# Process conversation to extract facts
conversation = [\
    {"role": "user", "content": "Alice manages the ML team and mentors Bob, who is also on the team."}\
]
memories = manager.invoke({"messages": conversation})

# Extract and store new knowledge
conversation2 = [\
    {"role": "user", "content": "Bob now leads the ML team and the NLP project."}\
]
update = manager.invoke({"messages": conversation2, "existing": memories})

```

```python
memories = [\
    ExtractedMemory(\
        id="27e96a9d-8e53-4031-865e-5ec50c1f7ad5",\
        content=Memory(\
            content="Alice manages the ML team and mentors Bob, who is also on the team."\
        ),\
    ),\
    ExtractedMemory(\
        id="e2f6b646-cdf1-4be1-bb40-0fd91d25d00f",\
        content=Memory(\
            content="Bob now leads the ML team and the NLP project."\
        ),\
    ),\
]
```

In our experience, semantic memory is the most common form of “memory” that engineers ask for and imagine (after, perhaps, short-term “conversation history” memory) when they first seek to add a memory layer.

根据我们的经验，语义记忆是工程师在首次尝试为系统添加记忆层时，最常提出并设想的“记忆”形式（仅次于短期“对话历史”记忆）。

It also (debatably) has the most overlap with traditional RAG systems. If the knowledge is available from another store (docs site, codebase, etc.), and if that store is the source of truth (rather than the interactions themselves), then your agent may work fine simply retrieving over that knowledge corpus directly. Or you can periodically ingest that knowledge to integrate that in the semantic memory system. If the knowledge is regarding personalization (about the user) or conceptual relationships not found in the raw materials, then semantic memory is perfect for you.

它（尚存争议地）与传统 RAG 系统具有最多的重叠之处。如果所需知识已存在于其他存储中（如文档网站、代码库等），且该存储即为事实来源（而非交互过程本身），那么你的智能体仅需直接检索该知识语料库即可良好运行；或者，你也可以定期将这些知识摄入语义记忆系统以实现集成。若知识涉及个性化信息（关于用户本身）或原始材料中未体现的概念性关联，则语义记忆正是最适合你的选择。

### Procedural memory: evolving behavior

### 程序性记忆：持续演进的行为模式

Procedural memory represents internalized knowledge of **how to** perform tasks. It is distinct from episodic memory in that it focuses on generalized skills, rules, and behaviors. For AI agents, procedural memory is saved across a combination of model weights, agent code, and agent's prompt that collectively determine the agent's functionality. In LangMem, we focus on saving learned procedures as updated instructions in the agent's prompt.

程序性记忆代表一种内化的、关于**如何**执行任务的知识。它与情景记忆不同，侧重于泛化的技能、规则和行为模式。对 AI 智能体而言，程序性记忆分散保存于模型权重、智能体代码及智能体提示词（prompt）之中，三者共同决定智能体的功能表现。在 LangMem 中，我们专注于将习得的程序以更新后的指令形式保存在智能体的提示词中。

![](images/langmem-sdk-for-agent-long-term-memory/img_002.png)Code

![](images/langmem-sdk-for-agent-long-term-memory/img_002.png)代码

```python

from langmem import create_prompt_optimizer

trajectories = [\
    (\
        [\
            {"role": "user", "content": "Tell me about Mars"},\
            {"role": "assistant", "content": "Mars is the fourth planet..."},\
            {"role": "user", "content": "I wanted more about its moons"},\
        ],\
        {"score": 0.5, "comment": "Missed key information about moons"}\
    )\
]

optimizer = create_prompt_optimizer(
    "anthropic:claude-3-5-sonnet-latest",
    kind="metaprompt",
    config={"max_reflection_steps": 3}
)

improved_prompt = optimizer.invoke({
    "trajectories": trajectories,
    "prompt": "You are a planetary science expert"
})
```

```python
"""
You are a helpful assistant..
    If the user asks about astronomy, explain topics clearly using real-world examples and current scientific data.
    Use visual references when helpful and adapt to the user's knowledge level.
    Balance practical observational astronomy with theoretical concepts, providing either viewing advice or technical explanations based on user needs.
"""
```

```python
"""
你是一位乐于助人的助手。
    如果用户询问天文学相关问题，请使用真实世界的例子和当前科学数据，清晰地解释相关主题。
    在必要时使用可视化参考，并根据用户的认知水平调整讲解方式。
    在实践性观测天文学与理论概念之间取得平衡，依据用户需求提供观星建议或技术性解释。
"""
```

The optimizer is prompted with identifying patterns in successful and unsuccessful interactions, then updating the system prompt to reinforce effective behaviors. This creates a feedback loop where the agent's core instructions evolve based on observed performance.

优化器被提示识别成功与失败交互中的模式，随后更新系统提示词以强化有效行为。由此形成一个反馈闭环：智能体的核心指令将依据其实际表现持续演进。

Informed by our [work on prompt optimization](https://blog.langchain.com/exploring-prompt-optimization/), LangMem provides multiple algorithms for generating prompt update proposals, including: `metaprompt` uses reflection & additional “thinking” time to study the conversations and then use a meta-prompt to propose the update; `gradient` explicitly divides the work into separate steps of critique and prompt proposals to further simplify the task at each step; and a simple `prompt_memory` algorithm that attempts to do the above in a single step.

受我们关于[提示词优化的研究工作](https://blog.langchain.com/exploring-prompt-optimization/)启发，LangMem 提供了多种生成提示词更新方案的算法，包括：  
- `metaprompt`：通过反思（reflection）与额外的“思考”时间分析对话历史，再借助元提示（meta-prompt）提出更新建议；  
- `gradient`：明确将任务拆分为“批评”与“提示词提案”两个独立步骤，从而进一步简化每一步的操作；  
- 以及一种简化的 `prompt_memory` 算法，尝试在单步内完成上述全部过程。

### Episodic memory: events and experiences

### 情节记忆：事件与经历

Episodic memory stores memories of past interactions. It is distinct from procedural memory in its focus on recalling _specific_ experiences. It is distinguished from semantic memory in its focus on past events rather than general knowledge, answering “how” the agent solved a particular problem rather than just “what” the answer was. It often takes the form of few-shot examples, with each example distilled from a longer raw interaction. LangMem doesn't yet support opinionated utilities for episodic memory.

情节记忆用于存储过往交互的记忆。它区别于程序性记忆（procedural memory），因其专注于回忆 _特定的_ 经历；也区别于语义记忆（semantic memory），因其聚焦于过去发生的事件，而非一般性知识——它回答的是智能体“如何”解决某个具体问题，而不仅仅是“答案是什么”。情节记忆通常以少量示例（few-shot examples）的形式呈现，每个示例均提炼自一段更长的原始交互记录。目前 LangMem 尚未提供针对情节记忆的、具有明确设计倾向（opinionated）的工具支持。

### Try it today

### 立即体验

Check out the [docs](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com) for more examples on how to implement custom memory systems using LangMem, including guides on how to:

请查阅 [文档](https://langchain-ai.github.io/langmem/?ref=blog.langchain.com)，了解如何使用 LangMem 构建自定义记忆系统，其中包含以下指南：

- Create an agent that actively manage its own memory  
- 创建一个能主动管理自身记忆的智能体  

- Share memories between agents  
- 在多个智能体之间共享记忆  

- Namespace memories to organize information by user or team.  
- 为记忆设置命名空间（namespace），以便按用户或团队组织信息  

- Integrate LangMem in your custom framework  
- 将 LangMem 集成至您自定义的框架中  

If your team wants to add personalization or life-long learning to your agents, fill out our [interest form](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com).

若您团队希望为智能体添加个性化能力或终身学习能力，请填写我们的[意向表单](https://forms.gle/KY8ja6F24nJFRF2e9?ref=blog.langchain.com)。

### Join our team

### 加入我们的团队

We're recruiting engineers to build the world's best runtime for adaptive agents. If you're interested in designing and building with us, check out our [open positions](https://www.langchain.com/careers?ref=blog.langchain.com).

我们正在招聘工程师，共同打造全球最佳的自适应智能体（adaptive agents）运行时系统。如果您有兴趣与我们一起进行设计与开发，请查看我们的[开放职位](https://www.langchain.com/careers?ref=blog.langchain.com)。