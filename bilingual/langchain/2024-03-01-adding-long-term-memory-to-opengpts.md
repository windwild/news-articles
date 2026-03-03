---
title: "Adding Long Term Memory to OpenGPTs"
source: "LangChain Blog"
url: "https://blog.langchain.com/adding-long-term-memory-to-opengpts/"
date: "2024-03-01"
scraped_at: "2026-03-03T08:09:50.841315539+00:00"
language: "en-zh"
translated: true
---

Three weeks ago we launched [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com), an implementation of OpenAI GPTs and Assistant API but in an open source manner. OpenGPTs allows for implementation of conversational agents - a flexible and futuristic cognitive architecture. One large part of agents is **memory**. In their current implementation, GPTs, OpenGPTs, and the Assistants API only really support basic conversational memory. Longer term memory is an underexplored area. In this blog post we will talk a little bit about how we think about memory, why it is so underexplored, and then walk through the specific memory we implemented and exposed in OpenGPTs to create a "Dungeons and Dragons" Dungeon Master.

三周前，我们推出了 [OpenGPTs](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com) —— 这是一个开源实现的 OpenAI GPTs 与 Assistant API。OpenGPTs 支持构建对话式智能体（conversational agents），是一种灵活且面向未来的认知架构。在智能体的诸多组成部分中，**记忆（memory）** 占据着极其重要的地位。然而，当前 GPTs、OpenGPTs 及 Assistant API 的实现，仅真正支持基础的对话记忆；而长期记忆（longer-term memory）则仍是一个尚未被充分探索的领域。本文将简要探讨我们对“记忆”的理解、其之所以长期被忽视的原因，并具体介绍我们在 OpenGPTs 中设计并开放的某类记忆机制——该机制被用于构建一个“龙与地下城”（Dungeons and Dragons）风格的地下城主（Dungeon Master）。

## LLMs are Stateless

## 大语言模型是无状态的

LLMs themselves are stateless - if you pass in a first input, and then a second, it will not remember the first when operating on the second. As a result, pretty much all LLMs are stateless as well. This means that if you want to have any concept of memory at all, the user needs to maintain this state on their side before passing to the LLM.

大语言模型（LLM）本身是无状态的：若你先后输入两条消息，模型在处理第二条时并不会自动记住第一条内容。因此，几乎所有 LLM 都是无状态的。这意味着，若希望引入任何形式的记忆能力，用户必须自行在调用 LLM 之前维护和管理这一状态。

The first main exception to that was released a few weeks ago by OpenAI with the Assistants API. This API allows you to keep track of a list of messages. You can then call an Assistant (an LLM) on this list of messages, and it will append messages to that thread. The LLM itself is still stateless, but the API exposed no longer is.

首个主要例外，是 OpenAI 几周前通过 Assistant API 引入的。该 API 允许你维护一个消息列表（message thread）；随后可基于该列表调用某个 Assistant（即某个 LLM），而 Assistant 将把新生成的消息追加至该线程中。LLM 本身依然无状态，但所暴露的 API 已不再是无状态的。

Even with this introduction, the main type of memory used is still just conversation memory.

即便如此，目前实际使用的主要记忆类型，仍仅限于对话记忆。

## Conversation Memory

## 对话记忆

By conversational memory we simply mean the ability to remember previous messages in a conversation. This is done by keeping track of a list of previous messages, and then passing that into the prompt, which is then passed into the LLM.

所谓“对话记忆”，仅指模型在对话中记住先前消息的能力。其实现方式是：维护一个历史消息列表，并将该列表作为上下文（prompt）的一部分传入 LLM。

![](images/adding-long-term-memory-to-opengpts/img_001.png)

![](images/adding-long-term-memory-to-opengpts/img_001.png)

This starts to run into issues when the list of previous messages gets rather long. First, if the list gets long enough, it may become longer than the context window. Second, even if it doesn't overflow the context window, it may still be long enough where it is too distracting for the LLM to properly attend over all the messages (see [some great research here by Greg Kamradt](https://x.com/GregKamradt/status/1727018183608193393?s=20&ref=blog.langchain.com) on the limitations of long context windows).

当历史消息列表变得过长时，这种方法便开始暴露出问题：第一，若列表长度超过模型的最大上下文窗口（context window），便会直接导致截断或报错；第二，即使未超出上下文窗口容量，过长的历史也可能使模型难以有效聚焦于关键信息——大量冗余内容反而会干扰注意力机制（attention mechanism）的正常工作（参见 Greg Kamradt 关于长上下文窗口局限性的[精彩研究](https://x.com/GregKamradt/status/1727018183608193393?s=20&ref=blog.langchain.com)）。

The most obvious way to deal with this is just to only use the N most recent messages. This leads to the downside of a lack of long term memory - the bot may forget everything you said before that.

最直观的应对方式，是仅保留最近的 N 条消息。但这带来一个明显缺陷：缺乏长期记忆——机器人可能完全遗忘此前所有对话内容。

So how do you deal with that?

那么，你该如何应对这种情况呢？

## Semantic Memory

## 语义记忆

Semantic memory is maybe the next most commonly used type of memory. This refers to finding messages that are **similar** to the current message and bringing them into the prompt in some way.

语义记忆或许是继短期记忆之后最常使用的记忆类型。它指的是找出与当前消息**语义相似**的历史消息，并以某种方式将这些消息纳入当前提示（prompt）中。

This is typically done by computing an embedding for each message, and then finding other messages with a similar embedding. This is basically the same idea that powers retrieval augmentation generation (RAG). Except instead of searching for documents, you are searching for messages.

这一过程通常通过对每条消息计算其嵌入向量（embedding），再检索嵌入空间中距离相近的其他消息来实现。其核心思想与检索增强生成（Retrieval-Augmented Generation, RAG）基本一致——区别仅在于：RAG 检索的是文档，而此处检索的是对话消息。

For example, if a user asks "what is my favorite fruit", we would maybe find a previous message like "my favorite fruit is blueberries" (since they are similar in the embedding space). We could then pass that previous message in as context.

例如，当用户提问“我最喜欢的水果是什么？”时，系统可能会检索到一条历史消息：“我最喜欢的水果是蓝莓”（因二者在嵌入空间中语义相近），并将其作为上下文提供给模型。

However, this approach has some flaws.

然而，该方法存在若干缺陷。

## Challenges

## 挑战

First: if insights or information is spread out over multiple messages, then the right messages may not be retrieved. For example if there was a sequence of messages like:

首先：若关键信息或洞察分散在多轮消息中，则可能无法准确检索到全部相关消息。例如，存在如下对话序列：

> AI: What's your favorite fruit?

> AI：你最喜欢的水果是什么？

> Human: Blueberries

> 人类：蓝莓

You would need to retrieve both those messages in order to have the appropriate information.

为了获得恰当的信息，您需要同时检索这两条消息。

Second: this doesn't account for time. Preferences or facts can change over time. My favorite fruit could change over time. If we retrieve just based on semantic similarity, that isn't taken into account.

第二：该方法未考虑时间因素。偏好或事实可能随时间推移而发生变化——例如，我最喜爱的水果可能随时间改变。若仅依据语义相似性进行检索，则无法体现这种时序变化。

Third: this is relatively unopinionated about the type of memory that is needed. Which is maybe good for AGI, but less good for developing more narrow, focused applications that actually work.

第三：该方法对所需记忆类型持相对中立态度。这对通用人工智能（AGI）而言或许是优点，但对开发更具体、更聚焦且真正可用的专用应用而言，则未必理想。

## Generative Agents

## 生成式智能体

[Generative agents](https://arxiv.org/abs/2304.03442?ref=blog.langchain.com) was a fantastic paper that came out less than a year ago and does some of the most interesting advanced memory work. It's worth looking at that paper and seeing how it tackles some of the challenges listed above.

《[生成式智能体](https://arxiv.org/abs/2304.03442?ref=blog.langchain.com)》是一篇发布于不到一年前的杰出论文，其中开展了目前最具启发性的高级记忆机制研究。值得通读该论文，了解其如何应对上述几项挑战。

In _Generative Agents_, they build memory using a variety of techniques:

在《生成式智能体》中，作者综合运用多种技术构建记忆系统：

- Recency: they fetch memories based on recent messages (combination of _conversation memory_ and just upweighting messages based on time stamp after fetching).  
- 近期性（Recency）：依据最近的消息检索记忆（结合“对话记忆”机制，并在检索后按时间戳对消息进行加权提升）。

- Relevancy: they fetch relevant messages ( _semantic memory_)  
- 相关性（Relevancy）：检索与当前上下文相关的信息（即“语义记忆”）。

- Reflection: they don't just fetch raw messages, but rather they use an LLM to reflect on the messages and then fetch those reflections.  
- 反思（Reflection）：不仅检索原始消息，还利用大语言模型（LLM）对消息内容进行反思与提炼，再检索这些反思结果。

The use of reflection can help to address the first issue raised above — if information is spread out over multiple messages, by reflecting over multiple messages a synthesis can be generated.

反思机制有助于解决上述第一个问题：当信息分散在多条消息中时，通过对多条消息进行综合反思，即可生成凝练的整合性结论。

The second issue is partially addressed by the recency weighting. However, likely not fully solved.

第二个问题通过近期性加权得到部分缓解，但很可能尚未彻底解决。

The third issue isn't really addressed, this is still a pretty general form of memory (but that's fine, that's what it was aiming to do).

第三个问题则基本未被涉及——该记忆机制仍属于一种相当通用的形式（但这并无不妥，因为这正是该研究的既定目标）。

## Long Term Memory Abstraction

## 长期记忆抽象

When we think of long term memory, the most general abstraction is:

当我们思考长期记忆时，最通用的抽象形式是：

- There exists some state that is tracked over time  
- 存在某种随时间持续追踪的状态；  
- This state is updated at some period  
- 该状态在某个时间周期内被更新；  
- This state is combined into the prompt in some way  
- 该状态以某种方式融入提示（prompt）中。

The relevant questions then become:

那么，相关的关键问题就变为：

1\. What is the state is that tracked?  
1. 被追踪的状态具体是什么？  

2\. How is the state updated?  
2. 状态是如何被更新的？  

3\. How is the state used?  
3. 状态是如何被使用的？  

![](images/adding-long-term-memory-to-opengpts/img_002.png)

![](images/adding-long-term-memory-to-opengpts/img_002.png)

Let's look at how the three different types of memory above play out.

下面我们来看上述三种不同类型的记忆在实践中如何体现。

#### **Conversation Memory**  

#### **对话记忆**

- The state that is tracked is a list of messages  
- 跟踪的状态是一组消息列表  

- The state is updated by appending recent messages after each turn  
- 状态通过在每一轮对话后追加最新消息来更新  

- The state is combined into the prompt by inserting the messages into the prompt  
- 状态通过将消息插入提示词（prompt）中，整合进输入提示  

#### **Semantic Memory**  

#### **语义记忆**  

- The state that is tracked is a vectorstore of messages  
- 跟踪的状态是一个存储消息向量的向量数据库（vectorstore）  

- The state is updated by vectorizing and inserting messages after each turn  
- 状态通过在每一轮对话后对消息进行向量化并存入向量数据库来更新  

- The state is combined into the prompt by querying it for similar messages after each turn  
- 状态通过在每一轮对话后查询该向量数据库、检索相似消息，并将结果整合进提示词中  

#### **Generative Agents**  

#### **生成式智能体**  

- The state that is tracked is a vectorstore of memories, as well as a list of the most recent memories  
- 跟踪的状态既包括一个存储记忆向量的向量数据库，也包括一个最近记忆的列表  

- The state is updated in several ways. First, after each turn a new memory is inserted into the list of most recent memories. Then, an embedding is calculated for that memory. Then, after N turns, a reflection is made over the recent memories and that is inserted both into the list and into the vectorstore.  
- 状态通过多种方式更新：首先，在每一轮对话后，将一条新记忆插入最近记忆列表；其次，为该记忆计算嵌入向量（embedding）；最后，经过 N 轮对话后，基于近期记忆生成一次“反思”（reflection），并将该反思结果同时插入记忆列表和向量数据库中。  

- The state is combined into the prompt by selecting memories (or reflections of memories) based on a weighted combination of recency and relevancy.  
- 状态通过一种兼顾“时效性”与“相关性”的加权策略，从记忆（或记忆的反思）中筛选内容，并将其整合进提示词中。  

## Application Specific Memory  

## 面向具体应用的记忆机制  

All of these forms of memory are fairly generic. Which is great if you are trying to build AGI. But is less reliable and performant if you are trying to build more narrow applications.  

上述所有记忆形式都较为通用——这对构建通用人工智能（AGI）而言非常理想；但若用于构建更垂直、更具体的领域应用，则往往可靠性与性能表现欠佳。  

💡  

💡  

Memory is one part of a cognitive architecture. Just as with cognitive architectures, we've found in practice that more application specific forms of memory can go a long way in increasing the reliability and performance of your application.  

记忆是认知架构的一个组成部分。正如认知架构本身一样，我们在实践中发现：采用更贴合具体应用场景的记忆机制，能显著提升应用的可靠性与运行性能。  

So when you're building your application, we would highly recommend asking the above questions:  

因此，在构建您的应用时，我们强烈建议您思考并回答上述问题：

- **_What is the state that is tracked?_**  
- **_状态追踪的是什么？_**  
- **_How is the state updated?_**  
- **_状态如何更新？_**  
- **_How is the state used?_**  
- **_状态如何被使用？_**  

Of course, this is easier said than done. And then even if you are able to answer those questions, how can you actually build it?  

当然，说起来容易做起来难。而且，即便你能够回答上述问题，又该如何真正将其构建出来呢？

We've decided to give this a go within OpenGPTs and build a specific type of chatbot with a specific form of memory.  

我们决定在 OpenGPTs 框架内尝试实现这一构想，构建一种具备特定记忆形式的专用聊天机器人。

## Dungeons and Dragons Chatbot  

## 龙与地下城（D&D）聊天机器人  

We decided to build a chatbot that could reliably serve as a dungeon master for a game of dungeon and dragons. What is the specific type of memory we wanted for this?  

我们决定构建一个能稳定担任龙与地下城（Dungeons & Dragons）游戏“地下城主”（Dungeon Master）角色的聊天机器人。那么，为此我们需要哪种特定类型的记忆机制呢？

**_What is the state that is tracked?_**  
**_状态追踪的是什么？_**  

We wanted to first make sure to track the characters that we're involved in the game. Who they were, their descriptions, etc. This seems like something that should be known. We call this `character` memory.  

我们首先希望完整追踪游戏中涉及的角色：他们是谁、外貌与性格描述等——这些信息理应是已知且持续维护的。我们将这类记忆称为 `character`（角色）记忆。

We then also wanted to track the state of the game itself. What had happened up to that point, where they were, etc. We call this `quest` memory.  

接着，我们也希望追踪游戏本身的进展状态：截至目前发生了什么事件、角色身处何地等。我们将这类记忆称为 `quest`（任务）记忆。

We decided to split this into two distinct things - so we were actually tracking an updating two different states: `character` and `quest`.  

我们最终决定将二者明确区分为两类独立的记忆模块——也就是说，我们实际上在同步维护并持续更新两种不同的状态：`character` 和 `quest`。

**_How is the state updated?_**  
**_状态如何更新？_**

For the character description, we just wanted to update that once at beginning. So we wanted our chatbot to gather all relevant information, update that state, and then never update it again.

关于角色描述，我们仅希望在初始阶段更新一次。因此，我们期望聊天机器人能够收集所有相关信息，完成该状态的更新，此后便不再更改。

Afterwards, we wanted our chatbot to attempt to update the state of the quest every turn. If it decides that no update is necessary, then we won't update it. Otherwise, we will override the current state of the quest with an LLM generated new state.

之后，我们希望聊天机器人在每一轮对话中都尝试更新任务（quest）的状态：若其判断无需更新，则保持现状；否则，将用大语言模型（LLM）生成的新状态完全覆盖当前的任务状态。

**_How is the state used?_**

**_状态如何被使用？_**

We wanted both the character description and the state of the quest to always be inserted into the prompt. This is pretty straightforward since they were both text, so it was just some prompt engineering with some placeholders for those variables.

我们希望角色描述与任务状态始终被插入到提示词（prompt）中。这实现起来相当直接——因为二者均为纯文本，只需通过提示工程，在提示模板中为这些变量预留占位符即可。

#### Cognitive Architecture

#### 认知架构

It's worth noting that for this chatbot we used a slightly different cognitive architecture than the generic agents. Namely, we used a version of a state machine. The chatbot was in one of two states:

值得注意的是，本聊天机器人所采用的认知架构与通用智能体（generic agents）略有不同：具体而言，我们采用了某种状态机（state machine）变体。该聊天机器人始终处于以下两种状态之一：

1. Character-constructing state: gathering information about a user's character  
1. 角色构建状态（Character-constructing state）：收集用户角色的相关信息  

2. Quest-mode state: leading a quest  
2. 任务模式状态（Quest-mode state）：主导一场任务（quest）

The transition between these two states occurred when the LLM decided that it had gleaned enough of the player's character. When that occurred, it updated the `character` memory. The presence of a `character` memory serves as signposting that the chatbot should be in the quest-telling state.

这两个状态之间的切换，发生在大语言模型（LLM）判定已充分获取玩家角色信息之时。此时，LLM 将更新 `character` 记忆（memory）。而 `character` 记忆的存在，即作为明确的信号，指示聊天机器人应进入“讲述任务”（quest-telling）状态。

## See it in action

## 实际效果演示

To see this in action, you can go to the deployed version of OpenGPTs. You can see the source code [here](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com).

如需实际体验该功能，请访问 OpenGPTs 的已部署版本。源代码可在此处查看：[链接](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com)。

If you want to create a "Dungeons and Dragons" chatbot with this type of memory from scratch, when creating a new bot you can select the `dungeons_and_dragons` type.

如果您想从零开始构建一个具备此类记忆功能的“龙与地下城”（Dungeons and Dragons）聊天机器人，在创建新机器人时，您可以选择 `dungeons_and_dragons` 类型。

![](images/adding-long-term-memory-to-opengpts/img_003.png)

When messaging it, it will first interview you for information about your character.

向它发送消息时，它会首先对您进行访谈，以收集有关您角色的信息。

![](images/adding-long-term-memory-to-opengpts/img_004.png)

Once it has enough information, it will save it to the `CharacterNotebook` (our name for the memory that contains information about the character).

一旦收集到足够信息，它便会将这些信息保存至 `CharacterNotebook`（这是我们为存储角色相关信息的记忆模块所起的名称）。

![](images/adding-long-term-memory-to-opengpts/img_005.png)

After that, it will lead you on a quest. At various points, the `StateNotebook` will update (this is our name for the memory that contains the state of the quest).

此后，它将引导您开启一场冒险任务。在任务推进过程中的若干关键节点，`StateNotebook` 将随之更新（这是我们为存储任务当前状态的记忆模块所起的名称）。

![](images/adding-long-term-memory-to-opengpts/img_006.png)

Everything is logged in LangSmith, so we can take a look at what is going on behind the scenes:

所有操作均记录在 LangSmith 中，因此我们可以一窥后台运行的细节：

![](images/adding-long-term-memory-to-opengpts/img_007.png)

Note that this is not perfect! There is definitely some prompt engineering to be done to improve the updating of the quest over time. Still, we hope this serves as a concrete example of how we think about long term memory, and one concrete _custom_ implementation.

请注意，这并非完美方案！显然还需要进行一些提示词工程（prompt engineering），以持续优化任务（quest）随时间的更新效果。尽管如此，我们仍希望本例能具体展现我们对长期记忆（long term memory）的思考方式，并提供一种切实可行的**自定义实现方案**。

## Conclusion

## 结论

Long term memory is a very underexplored topic. Part of that is probably because it is either (1) very general, and trends towards AGI, or (2) so application specific, and tough to talk about generically.

长期记忆是一个被严重低估、远未充分探索的研究方向。其原因可能在于：它要么（1）过于宽泛，天然趋向于通用人工智能（AGI）这一宏大目标；要么（2）高度依赖具体应用场景，以至于难以在抽象层面进行普适性讨论。

At LangChain, we believe that most applications that need a form of long term memory are likely better suited by application specific memory. In this case, it becomes important to think critically about:

在 LangChain，我们认为：大多数需要某种形式长期记忆的应用，往往更适合采用**面向特定应用的内存机制（application-specific memory）**。此时，关键在于深入思考以下三个问题：

- What is the state that is tracked?  
- 被追踪的状态（state）究竟是什么？  

- How is the state updated?  
- 状态如何被更新？  

- How is the state used?  
- 状态如何被使用？  

We're building a framework (and tools) to help make this easy - LangChain, OpenGPTs, LangSmith. Still, due to the application-specific nature of it, it's tough to work on in the abstract. **If you are a company working on an application that requires long-term memory and need assistance, please reach out to hello@langchain.dev**

我们正在构建一套框架与配套工具（LangChain、OpenGPTs、LangSmith），以大幅降低此类工作的门槛。然而，正因其高度依赖具体应用场景，脱离实际应用去抽象地研究和推进这项工作十分困难。**如果您所在的公司正在开发需要长期记忆能力的应用，并寻求相关支持，请随时联系 hello@langchain.dev**