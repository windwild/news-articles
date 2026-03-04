---
title: "How agents can use filesystems for context engineering"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-agents-can-use-filesystems-for-context-engineering/"
date: "2025-11-23"
scraped_at: "2026-03-03T07:17:46.558656390+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

By Nick Huang

作者：Nick Huang

A key feature of [deep agents](https://blog.langchain.com/deep-agents/) is their access to a set of filesystem tools. Deep agents can use these tools to read, write, edit, list, and search for files in their filesystem.

[深度智能体（deep agents）](https://blog.langchain.com/deep-agents/) 的一项关键特性是其可访问一组文件系统工具。深度智能体可利用这些工具在其文件系统中读取、写入、编辑、列出和搜索文件。

In this post, we’ll walk through why we think filesystems are important for agents. In order to understand how filesystems are helpful, we should start by thinking through where agents can fall short today. They either fail because (a) the model is not good enough, or (b) they don’t have access to the right context. Context engineering is the [“delicate art and science of filling the context window with just the right information for the next step”](https://x.com/karpathy/status/1937902205765607626?ref=blog.langchain.com). Understanding context engineering - and how it can fail - is crucial for building reliable agents.

本文将深入探讨我们为何认为文件系统对智能体至关重要。要理解文件系统如何发挥作用，我们首先需思考当前智能体在哪些方面存在不足：它们的失败通常源于两类原因——（a）模型能力不足，或（b）缺乏恰当的上下文信息。上下文工程（context engineering）即 [“一门精妙的艺术与科学：为下一步精准填充上下文窗口所需的信息”](https://x.com/karpathy/status/1937902205765607626?ref=blog.langchain.com)。深入理解上下文工程及其可能失效的方式，是构建可靠智能体的关键前提。

### A view of context engineering

### 上下文工程的一种视角

One way to view the job of a modern day agent engineer is through the lens of [context engineering](https://blog.langchain.com/the-rise-of-context-engineering/). Agents generally **have access to** a lot of context (all support docs, all code files, etc). In order to answer an incoming question, the agent **needs** some important context (which contains the context needed to answer the question). While aiming to answer said question, the agent **retrieves** some body of context (to pull into it’s context window).

现代智能体工程师的一项核心工作，可借助 [上下文工程（context engineering）](https://blog.langchain.com/the-rise-of-context-engineering/) 这一视角加以理解。智能体通常 **能够访问** 大量上下文信息（例如全部支持文档、全部代码文件等）。然而，要回答一个新提出的问题，智能体 **真正需要** 的只是其中一部分关键上下文（即足以支撑问题解答的那部分信息）。在尝试作答的过程中，智能体会 **检索** 某一范围的上下文内容，并将其载入自身的上下文窗口。

![](images/how-agents-can-use-filesystems-for-context-engineering/img_001.png)

![](images/how-agents-can-use-filesystems-for-context-engineering/img_001.png)

When viewed from this lens, there are many ways that context engineering can “fail” for agents:

从这一视角出发，上下文工程在智能体应用中存在多种“失效”可能：

- If the context that the agent needs is not in the total context, the agent cannot succeed. Example: a customer support agent needs access to a certain documentation page to answer a question, but that page hasn’t been indexed.  
  若智能体所需的关键上下文根本未包含在整体可用上下文中，则智能体必然失败。例如：客服智能体需查阅某篇特定文档页面才能回答用户问题，但该页面尚未被索引。

- If the context that the agent retrieves doesn’t encapsulate the context that the agent needs, then the agent will not be able to answer correctly. Example: a customer support agent needs access to a certain documentation page to answer a question, that page exists and is indexed, but is not retrieved by the agent.  
  若智能体实际检索到的上下文未能覆盖其真正所需的内容，则它将无法给出正确答案。例如：客服智能体需查阅某篇特定文档页面，该页面确实存在且已被索引，但智能体却未能成功检索到它。

- If the context that the agent retrieves is far larger than the context that the agent needs, then the agent is being wasteful (with time, tokens, or both). Example: a customer support agent needs a single specific page, and the agent retrieves 100 pages.  
  若智能体检索到的上下文远超其实际所需，则会造成资源浪费（包括时间、token 或二者兼有）。例如：客服智能体仅需一页特定文档，却检索并加载了 100 页内容。

Our job as agent engineers is to **fit red to green (to make sure that the context the agent retrieves is as small of a superset of the needed information as possible)**

作为智能体工程师，我们的任务是 **让红色精准匹配绿色（确保智能体所检索的上下文，是所需信息的最小可能超集）**。

A few specific challenges arise when seeking to isolate the appropriate context

在力求精准定位恰当上下文的过程中，会面临若干具体挑战。

1. **Too many tokens** (retrieved context >> necessary context)

1. **令牌数量过多**（检索到的上下文远超实际所需上下文）

Some tools, like web search, can return a lot of tokens. A few web searches can quickly build up to tens of thousands of tokens in your conversation history. You might eventually run into a pesky 400 bad request error, but well before that, your LLM bill balloons and performance degrades.

某些工具（例如网页搜索）可能返回大量 token。几次网页搜索就可能使对话历史中的 token 总数迅速攀升至数万个。你最终可能会遇到令人头疼的 400 错误（Bad Request），但在此之前，你的大语言模型调用费用已急剧上涨，且模型性能明显下降。

2. **Needs large amounts of context** (necessary context > supported context window)

2. **需要大量上下文**（实际所需上下文 > 模型支持的上下文窗口）

Sometimes an agent may actually need a lot of information in order to answer a question. This information usually cannot be returned in a single search query, which is why many have leaned into the idea of “agentic search” — letting an agent call a search tool repeatedly. The issue with this is that the amount of context quickly grows to a point where it can’t all fit into its context window.

有时，智能体确实需要大量信息才能回答一个问题。而这些信息通常无法通过单次搜索查询全部返回，因此许多人转向了“智能体式搜索”（agentic search）的理念——即让智能体反复调用搜索工具。但问题在于，随着多次调用，累积的上下文量会迅速增长，最终超出模型上下文窗口所能容纳的上限。

3. **Finding niche information** (retrieved context ≠ necessary context)

3. **查找小众信息**（检索到的上下文 ≠ 实际所需上下文）

Agents may need to reference niche information buried in hundreds or thousands of files in order to handle an input. How can the agent reliably find that information? If it cannot — then the retrieved context will not be what is needed to answer the question. Are there alternatives (or complements) to semantic search?

智能体在处理某项输入时，可能需要参考深藏于数百甚至数千个文件中的小众信息。那么，智能体如何可靠地定位这类信息？若无法做到，则所检索到的上下文将无法满足问题解答的实际需求。是否存在语义搜索的替代方案（或补充手段）？

4. **Learning over time** (total context ≠ necessary context)

4. **持续学习与积累**（总上下文 ≠ 实际所需上下文）

Sometimes the agent may just not have access to the necessary context for answering a question (either in the tools or instructions it has). The end user may often provide clues (implicitly or explicitly) in their interactions with the agent what that context may be. Is there a way for the agent to add that to its context for future iterations?

有时，智能体本身并不具备回答某个问题所需的上下文（无论是内置工具还是初始指令中均未提供）。终端用户往往会在与智能体的交互过程中，以显性或隐性的方式提供相关线索，暗示该上下文可能为何。那么，是否存在一种机制，让智能体将此类信息纳入自身上下文中，供后续轮次使用？

These are all common hurdles, and most of us have faced different flavors of these before!

上述种种，都是常见障碍；我们中的大多数人都曾以不同形式遭遇过其中某一种或多种挑战！

### How can a filesystem make an agent better?

### 文件系统如何提升智能体能力？

In the simplest terms: a filesystem provides **a single interface through which an agent can flexibly store, retrieve, and update an infinite amount of context.**

最简而言之：文件系统提供了一个**统一接口**，使智能体能够灵活地存储、检索和更新**无限量的上下文**。

Let’s see how this can help in each of the scenarios listed above.

下面我们逐一分析，文件系统如何助力应对上述每一种场景。

**Too many tokens** (retrieved context >> necessary context)

**令牌数量过多**（检索到的上下文远超实际所需上下文）

Instead of using the conversation history to hold all tool call results and notes, an agent can write these to the filesystem, and then selectively look up **_relevant information_** when necessary. Manus was one of the first to [publicly talk about this approach](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com) \- the below diagram is from their blog post.

与其将所有工具调用结果和笔记都保存在对话历史中，智能体可将其写入文件系统，并在需要时有选择性地检索**_相关信息_**。Manus 是最早[公开讨论这一方法](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com)的团队之一——下方示意图即出自其博客文章。

![](images/how-agents-can-use-filesystems-for-context-engineering/img_002.png)

![](images/how-agents-can-use-filesystems-for-context-engineering/img_002.png)

Let’s take that first example with the web search tool. I run a web search, and I get back 10k tokens of raw content from the tool. Most of that content is probably not necessary all the time. If I put that in my messages history, all 10k tokens are going to sit there for the entire conversation, driving up my Anthropic bill. But if I offload that large tool result to the filesystem, the agent can then intelligently grep search for certain key words, and then read only necessary context into my conversation.

我们以第一个网络搜索工具为例：我执行一次网络搜索，工具返回约 10,000 个 token 的原始内容。其中大部分内容并非始终必要。若将这些内容全部存入消息历史，这 10,000 个 token 将在整个对话过程中持续占用上下文空间，显著推高我的 Anthropic 账单。但若将该大型工具结果卸载至文件系统，智能体便可智能地使用 `grep` 检索特定关键词，仅将必要上下文读入当前对话。

In this example, the agent is effectively using the filesystem as a **scratch pad for large context.**

在此例中，智能体实质上是将文件系统用作**处理大规模上下文的临时草稿区**。

**Needs large amounts of context (necessary context < supported context window)**

**需要大量上下文（所需上下文量 < 模型支持的上下文窗口）**

Sometimes agents require a lot of context to answer the question. Filesystems provide a nice abstraction for letting LLMs dynamically store and pull in more information as needed. Examples of this include:

有时，智能体需依赖大量上下文才能回答问题。文件系统为此提供了一种优雅的抽象机制，使大语言模型（LLM）能够按需动态存储与加载更多信息。典型应用场景包括：

- For long horizon answers, agents need to make a plan and then follow it. By writing that plan to the filesystem, the agent can then pull this information back into the context window later on, to remind the agent what it’s suppose to be doing (eg [“manipulate attention through recitation”](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com))

- 针对长周期任务的回答，智能体需先制定计划再逐步执行。若将该计划写入文件系统，智能体后续即可将其重新载入上下文窗口，以提醒自身当前应执行的任务（例如 [“通过复述调控注意力”](https://manus.im/blog/Context-Engineering-for-AI-Agents-Lessons-from-Building-Manus?ref=blog.langchain.com)）

- To pour through all this context, the agent may spin up subagents. As these subagents do work and learn things, rather than just replying to the main agent with their learnings, they can write their knowledge to the filesystem instead (eg [minimize the game of telephone](https://www.anthropic.com/engineering/multi-agent-research-system?ref=blog.langchain.com))

- 为高效处理海量上下文，智能体可启动若干子智能体。当这些子智能体开展工作并获得新知识时，它们无需仅通过消息向主智能体汇报成果，而可直接将所学知识写入文件系统（例如 [最小化“传话游戏”失真](https://www.anthropic.com/engineering/multi-agent-research-system?ref=blog.langchain.com)）

- Some agents require a lot of instructions on how to do things. Rather than just stuff all these instructions into the system prompt (and bloat context) you can store them as files and let the agent dynamically read them as needed (eg [Anthropic skills](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com)).

- 某些智能体需执行大量操作指令。与其将全部指令硬编码进系统提示词（导致上下文臃肿），不如将其存为独立文件，由智能体按需动态读取（例如 [Anthropic 技能系统](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com)）。

**Finding niche information** (retrieved context ≠ necessary context)

**定位细分信息**（检索到的上下文 ≠ 实际所需的上下文）

Semantic search was one of the most popular approaches to retrieving context early on in the LLM wave. It can be effective in some use cases, but depending on the type of document (e.g. technical API reference, code files), semantic may be very poorly placed due to a lack of semantic information in the text.

语义搜索曾是大语言模型兴起初期最主流的上下文检索方法之一。它在部分场景下效果良好，但针对某些文档类型（如技术 API 参考文档、源代码文件），由于文本本身缺乏丰富的语义信息，语义搜索往往表现欠佳。

Filesystems provide an alternative to allow agents to intelligently search for context with ls, glob, and grep tools. If you’ve used Claude Code recently, you’ll know that it heavily relies on glob and grep search to find the right context it needs. There are a few keys to why this technique is successful.

文件系统则提供了另一种替代方案：智能体可借助 `ls`、`glob` 和 `grep` 等工具，更智能地搜索所需上下文。若您近期使用过 Claude Code，便会发现它高度依赖 `glob` 与 `grep` 搜索来精准定位所需上下文。该技术之所以成功，关键在于以下几点。

- models today are [specifically trained](https://platform.claude.com/docs/en/agents-and-tools/tool-use/bash-tool?ref=blog.langchain.com) to understand traversing filesystems  
- 当前的模型已[专门训练](https://platform.claude.com/docs/en/agents-and-tools/tool-use/bash-tool?ref=blog.langchain.com)以理解文件系统遍历操作  

- the information is often already structured logically (directories)  
- 信息本身通常已具备逻辑化的结构（例如目录层级）  

- glob and grep allow the agent to not only isolate specific files but also specific lines and specific characters  
- `glob` 和 `grep` 工具使智能体不仅能精准定位特定文件，还能定位特定行乃至特定字符  

- The [`read_file`](https://platform.claude.com/docs/en/agents-and-tools/tool-use/text-editor-tool?ref=blog.langchain.com) tool allows the agent to specify which lines to read in from a file  
- [`read_file`](https://platform.claude.com/docs/en/agents-and-tools/tool-use/text-editor-tool?ref=blog.langchain.com) 工具允许智能体指定从文件中读取哪些行  

For these reasons, there are situations where using filesystems (and the search capabilities you gain by using a filesystem) can create better results.  
基于上述原因，在某些场景下，使用文件系统（以及由此获得的搜索能力）可产出更优结果。

Note that semantic search can still be useful! And can be used in conjunction with filesystem search. Cursor recently [wrote a blog](https://cursor.com/blog/semsearch?ref=blog.langchain.com) highlighting the benefits of using both together.  
请注意：语义搜索依然具有重要价值！它还可与文件系统搜索协同使用。Cursor 近期[发布了一篇博客](https://cursor.com/blog/semsearch?ref=blog.langchain.com)，重点阐述了二者结合使用的诸多优势。

**Learning over time** (total context ≠ necessary context)  
**长期学习**（上下文总量 ≠ 必需上下文）

A big reason agents mess up is they are missing relevant context. A great way to improve agents is usually to make sure they have access to the right context. Sometimes this can look like adding more datasources or updating the system prompt.  
智能体出错的一大原因是缺乏相关上下文。提升智能体性能的一个有效方法，通常是确保其能获取恰当的上下文——这可能体现为增加数据源，或更新系统提示词（system prompt）。

A common practice for updating the system prompt is:  
更新系统提示词的一种常见做法是：

1. See an example where the agent was lacking appropriate instructions  
1. 发现一个智能体因缺少适当指令而表现不佳的具体案例  

2. Get the relevant instructions from a subject matter expert  
2. 向领域专家获取相关指令  

3. Update the prompt with those instructions  
3. 将这些指令整合进系统提示词中  

Often times, the end user is actually the best subject matter expert. Through conversation with the agent, they may provide important clues (implicitly or explicitly) as to what the right relevant instructions are. So with that in mind - is there a way to automate the third step above (updating the prompt with those instructions)?  
很多时候，终端用户本身就是最合适的领域专家。在与智能体的对话过程中，他们可能（隐式或显式地）提供关键线索，揭示真正所需的恰当指令。那么，能否将上述第三步（即用这些指令自动更新提示词）实现自动化呢？

We think an agent’s instructions (or skills) are no different than any other context they might want to work with. A filesystem can serve as the place for agents to store and update their own instructions!  
我们认为，智能体的指令（或技能）本质上与其他任何待处理的上下文并无区别。文件系统正可作为智能体存储并持续更新自身指令的理想场所！

Immediately after user feedback is given, an agent can write to its own files and remember an important piece of information. This is great for quick, one-off facts, especially things that might be custom to a user like their name, email, or other preferences.  
在收到用户反馈后，智能体可立即将其写入自身文件，从而记住一条重要信息。这种方式特别适合快速记录一次性事实——尤其是那些高度个性化的用户信息，例如姓名、邮箱或其他偏好设置。

This hasn’t been fully solved and is still an emerging pattern, but it’s an exciting new way that LLMs can grow their own skillsets and instructions over time, making sure that for future iterations they have access to the necessary context.

这一问题尚未完全解决，仍属于一种新兴模式；但这也是一种令人振奋的新方式——大语言模型（LLM）能够随时间推移自主拓展自身技能集与指令体系，从而确保在后续迭代中始终具备所需的上下文信息。

### See how a deep agent can make use of its filesystem

### 了解深度智能体如何利用其文件系统

We have an open source repo called Deep Agents ( [Python](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com), [TypeScript](https://github.com/langchain-ai/deepagentsjs?ref=blog.langchain.com)) that lets you quickly build an agent that has access to a filesystem. A lot of these context engineering tricks that use the filesystem are baked in! There are almost certainly more patterns that will emerge - try Deep Agents out and let us know what you think!

我们开源了一个名为 Deep Agents 的代码仓库（[Python 版本](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com)，[TypeScript 版本](https://github.com/langchain-ai/deepagentsjs?ref=blog.langchain.com)），可助您快速构建具备文件系统访问能力的智能体。其中已内建大量基于文件系统的上下文工程技巧！未来几乎必然还会涌现出更多新模式——欢迎试用 Deep Agents，并告诉我们您的想法！
&#123;% endraw %}
