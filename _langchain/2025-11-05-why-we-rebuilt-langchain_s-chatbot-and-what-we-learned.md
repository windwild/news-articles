---
title: "Why We Rebuilt LangChain’s Chatbot and What We Learned"
source: "LangChain Blog"
url: "https://blog.langchain.com/rebuilding-chat-langchain/"
date: "2025-11-05"
scraped_at: "2026-03-03T07:19:59.474883507+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_By Liam Bush_

_作者：利亚姆·布什_

## Background

## 背景

Every successful platform needs reliable support, but we realized our own team was spending hours tracking down answers to technical questions. This friction wasn't just slowing down our engineers—it was a critical **bottleneck** for our users.

每个成功的平台都需要可靠的支持，但我们意识到，自己的团队正耗费数小时追踪技术问题的答案。这种摩擦不仅拖慢了工程师的工作节奏，更已成为影响用户的关键**瓶颈**。

We set out to solve this using the very tools we champion: **LangChain, LangGraph** and **LangSmith**. We originally built [**chat.langchain.com**](http://chat.langchain.com/?ref=blog.langchain.com) as a prototype, explicitly designed to serve two functions:

我们决定用自己所倡导的工具来解决这一问题：**LangChain、LangGraph** 和 **LangSmith**。最初，我们构建了 [**chat.langchain.com**](http://chat.langchain.com/?ref=blog.langchain.com) 作为原型系统，其设计目标明确指向两大功能：

1. **Product Q&A:** Help users—and our own team—get instant, authoritative answers to product questions.  
1. **产品问答（Product Q&A）：** 帮助用户——以及我们自己的团队——即时获取权威、准确的产品相关问题解答。

2. **Customer Prototype:** Serve as a living example demonstrating how customers could build sophisticated, reliable agents using the LangChain stack.  
2. **客户原型（Customer Prototype）：** 作为一个真实可运行的范例，向客户展示如何基于 LangChain 技术栈构建复杂、可靠的智能体（agents）。

We had a strong intent and a functional product. But we have a confession: our support engineers weren't actively using the LangChain Chatbot. That's where our real learning began. This is the story of **how we fixed our own agent**—and what we learned about building truly reliable, production-grade applications that our customers can adapt and use.

我们初衷坚定，产品也已具备基本功能。但这里要坦白一点：我们的技术支持工程师并未真正积极使用 LangChain 聊天机器人。而这，恰恰是我们真正学习的起点。本文讲述的，正是 **我们如何修复了自家的智能体**——以及在此过程中，我们对构建真正可靠、可用于生产环境的应用所获得的深刻认知；这些应用，我们的客户也能灵活适配并投入实际使用。

Our team was not actively using Chat LangChain not because it was broken and not because they didn't believe in it. But because when someone asked _"Why isn't streaming working in production?"_ they needed something more thorough than just using docs as it’s only resource. We all know there’s never enough documentation.

我们的团队之所以没有积极使用 Chat LangChain，并非因为该系统存在故障，也并非因为他们不认可其价值。而是因为，当有人提出 _“为什么流式响应（streaming）在生产环境中无法正常工作？”_ 这类问题时，他们需要的远不止查阅文档——毕竟文档是唯一可用资源，而我们都知道：文档永远都不够用。

So they built their own workflow:

于是，他们自行构建了一套工作流程：

- **Step 1:** Search our docs ( [docs.langchain.com](http://docs.langchain.com/?ref=blog.langchain.com)) to understand what the feature is supposed to do.  
- **第一步：** 搜索我们的官方文档（[docs.langchain.com](http://docs.langchain.com/?ref=blog.langchain.com)），以理解该功能的设计意图与预期行为。

- **Step 2:** Check our knowledge base ( [support.langchain.com](http://support.langchain.com/?ref=blog.langchain.com)) to see if other users hit the same issue and how it was resolved.  
- **第二步：** 查阅我们的知识库（[support.langchain.com](http://support.langchain.com/?ref=blog.langchain.com)），确认其他用户是否遇到过相同问题，以及该问题是如何被解决的。

- **Step 3:** Open `Claude Code`, search the actual implementation, and verify what the code actually does.  
- **第三步：** 打开 `Claude Code`，搜索实际代码实现，验证该功能在源码层面的真实行为。

**Docs for the official story. Knowledge base for real-world issues. Codebase for ground truth.**  
**文档承载“官方叙事”，知识库沉淀“现实问题”，代码库揭示“事实真相”。**

* * *

## We Decided to Automate It

## 我们决定将其自动化

This three-step ritual worked incredibly well. We watched them do it dozens of times a day and thought: _what if we just automated this exact workflow?_

这一三步流程效果极佳。我们每天目睹他们重复执行数十次，并思考：_如果我们直接将这一精确工作流自动化，会怎样？_

So we built an internal [`Deep Agent`](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) (a library for building agents that can tackle complex, multi-step tasks) with three specialized subagents — one for docs, one for knowledge base, one for codebase search — each one asking follow-up questions and filtering results before passing insights to a main orchestrator agent.

于是，我们构建了一个内部的 [`Deep Agent`](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)（一个用于构建可处理复杂、多步骤任务的智能体的库），其中包含三个专业化的子智能体——分别负责文档检索、知识库检索和代码库搜索。每个子智能体都会提出后续问题、筛选结果，再将关键洞察传递给主协调智能体。

The main agent would synthesize everything and deliver answers like this:

主智能体会整合全部信息，并输出如下形式的答案：

> Example output:
>
> _"To stream from subgraphs, set subgraphs: true in your stream config according to the_ [_LangGraph streaming docs._](https://docs.langchain.com/oss/python/langgraph/use-subgraphs?ref=blog.langchain.com#stream-subgraph-outputs) _There's a support article titled \['Why is token streaming not working after upgrade\](_ [_https://support.langchain.com/articles/7150806184-Why-is-token-by-token-streaming-not-working-after-upgrading-LangGraph?)\[?\](https://www.notion.so/263808527b1780db9f26fa75aed5e7e3?pvs=21)_](https://support.langchain.com/articles/7150806184-Why-is-token-by-token-streaming-not-working-after-upgrading-LangGraph?)%5B?%5D(https://www.notion.so/263808527b1780db9f26fa75aed5e7e3?pvs=21)&ref=blog.langchain.com) _' that explains this exact issue — you need to enable subgraph streaming to get token-level updates from nested agents. The implementation is in_ [pregel/main.py lines 3373-3279,](https://github.com/langchain-ai/langgraph/blob/main/libs/langgraph/langgraph/pregel/main.py?ref=blog.langchain.com#L3273-L3279) _where the subgraphs flag controls whether nested graph outputs are included in the stream."_

> 示例输出：
>
> _“如需从子图（subgraphs）进行流式传输，请根据_[LangGraph 流式传输文档](https://docs.langchain.com/oss/python/langgraph/use-subgraphs?ref=blog.langchain.com#stream-subgraph-outputs)_，在您的流配置中设置 `subgraphs: true`。有一篇标题为_[‘升级后为何 Token 流式传输不再生效？’](https://support.langchain.com/articles/7150806184-Why-is-token-by-token-streaming-not-working-after-upgrading-LangGraph?)%5B?%5D(https://www.notion.so/263808527b1780db9f26fa75aed5e7e3?pvs=21)&ref=blog.langchain.com)_的支持文章专门解释了该问题——您需要启用子图流式传输，才能从嵌套智能体获取逐 Token 级别的更新。相关实现位于_[`pregel/main.py` 第 3273–3279 行](https://github.com/langchain-ai/langgraph/blob/main/libs/langgraph/langgraph/pregel/main.py?ref=blog.langchain.com#L3273-L3279)_，其中 `subgraphs` 标志位控制是否将嵌套图的输出包含在流中。”_

Our engineers loved it.

我们的工程师非常喜爱这一工具。

It saved them hours every week on complex debugging. They'd describe a production issue and get back a comprehensive answer that cited documentation, referenced known solutions, and pointed to the exact lines of code that mattered.

它每周为工程师节省数小时的复杂调试时间。他们只需描述一个生产环境问题，即可获得一份全面解答——其中援引了相关文档、参考了已知解决方案，并精准定位到关键代码行。

* * *

## Then We Had a Realization

## 随后，我们有了一个顿悟

Then someone asked the obvious question: **if this works so well for us, why doesn't our public Chat LangChain work this way?**

接着有人提出了一个显而易见的问题：**如果这种方式对我们如此有效，那为什么我们的公开版 Chat LangChain 不采用这种方式？**

It was a fair point. Our public tool was chunking documents into fragments, generating embeddings, storing them in a vector database. We had to reindex constantly as docs updated. Users got answers, but the citations needed love and the context was fragmented.

这确实是个中肯的批评。我们公开版的工具将文档切分为片段，生成嵌入向量，并将其存入向量数据库；随着文档持续更新，我们必须不断重新索引。用户虽能获得答案，但引用来源亟需完善，且上下文支离破碎。

We'd accidentally built something better internally just by copying what worked. It was time to bring that same approach to the public product.

我们只是照搬了行之有效的做法，便意外地在内部构建出更优的方案。是时候将这一思路同步到公开产品中了。

When we started rebuilding, we quickly realized we needed to combine two different architectures driven by two broad categories of questions. Most questions could be answered using docs and knowledge base. The remainder would require analysis of foundation of code.

在启动重建工作后，我们很快意识到：需要融合两种不同的架构，而这两种架构分别对应两大类问题。大多数问题可通过文档和知识库解答；其余问题则需对代码基础进行深度分析。

* * *

## How We Built The New Agent

## 我们如何构建新智能体（Agent）

### For Simple Docs: Create Agent

### 面向简单文档场景：Create Agent

We chose [`createAgent`](https://docs.langchain.com/oss/javascript/releases/langchain-v1?ref=blog.langchain.com#createagent) (Agent abstraction in [`langchain`](https://docs.langchain.com/oss/javascript/langchain/overview?ref=blog.langchain.com)) for [chat.langchain.com](https://chat.langchain.com/?ref=blog.langchain.com) as the default mode because it's best for **speed**.

我们为 [chat.langchain.com](https://chat.langchain.com/?ref=blog.langchain.com) 选用 [`createAgent`](https://docs.langchain.com/oss/javascript/releases/langchain-v1?ref=blog.langchain.com#createagent)（即 [`langchain`](https://docs.langchain.com/oss/javascript/langchain/overview?ref=blog.langchain.com) 中的 Agent 抽象）作为默认模式，因其在**速度**方面表现最优。

There's no planning phase, no orchestration overhead — just immediate tool calls and answers. The agent searches the docs, checks the knowledge base if needed, refines its query if the results are unclear, and returns an answer. Most documentation questions can be handled with **3-6 tool calls**, and Create Agent executes those in seconds.

该模式无需规划阶段，也无编排开销——仅需即时调用工具并返回答案。智能体首先检索文档，必要时查询知识库，若结果模糊则自动优化查询，最终返回答案。绝大多数文档类问题仅需 **3–6 次工具调用**，而 Create Agent 可在数秒内完成全部执行。

**Model options:**  

**模型选项：**

We give end-users access to multiple models — `Claude Haiku 4.5`, `GPT-4o Mini`, and `GPT-4o-nano` — and we've found that **Haiku 4.5 is exceptionally fast at tool calling** while maintaining strong accuracy. The combination of createAgent and Haiku 4.5 delivers **sub-15-second responses** for most queries, which is exactly what documentation Q&A demands.

我们为终端用户提供了多个模型——`Claude Haiku 4.5`、`GPT-4o Mini` 和 `GPT-4o-nano`。实践发现，**Haiku 4.5 在工具调用方面表现尤为迅捷，同时保持了出色的准确性**。将 `createAgent` 与 Haiku 4.5 结合使用后，绝大多数查询均可实现 **15 秒以内的响应**，而这恰恰契合文档问答（Q&A）场景的核心需求。

**How we optimized it:**

**我们的优化方法：**

We used [`LangSmith`](https://smith.langchain.com/?ref=blog.langchain.com) to trace every conversation, identify where the agent was making unnecessary tool calls, and refine our prompts. The data showed us that most questions could be answered with 3-6 tool calls if we taught the agent to ask better follow-up questions. LangSmith's evaluation suite let us A/B test different prompting strategies and measure improvements in both speed and accuracy.

我们借助 [`LangSmith`](https://smith.langchain.com/?ref=blog.langchain.com) 对每轮对话进行全链路追踪，精准定位代理（agent）执行冗余工具调用的环节，并据此持续优化提示词（prompts）。数据分析表明：只要教会代理提出更高质量的后续问题，大多数问题仅需 **3–6 次工具调用** 即可解答。LangSmith 的评估套件还支持我们对不同提示策略开展 A/B 测试，并量化衡量其在响应速度与准确率两方面的提升效果。

![](images/why-we-rebuilt-langchain_s-chatbot-and-what-we-learned/img_001.png)_This 30-second trace includes 7 tool calls: 4 doc searches, a knowledge-base article lookup, and 2 article reads, with 20 seconds devoted to streaming the final response._ [_View Here_](https://smith.langchain.com/public/c1059a52-d045-4013-a17f-3bdc07ef3f0d/r/67669d45-0065-47de-b0ee-0b4ca2687060?ref=blog.langchain.com)

![](images/why-we-rebuilt-langchain_s-chatbot-and-what-we-learned/img_001.png)_该次 30 秒的调用追踪共包含 7 次工具调用：4 次文档搜索、1 次知识库文章检索、2 次文章内容读取；其中最后 20 秒用于流式输出最终响应。_[_在此查看_](https://smith.langchain.com/public/c1059a52-d045-4013-a17f-3bdc07ef3f0d/r/67669d45-0065-47de-b0ee-0b4ca2687060?ref=blog.langchain.com)

### For answering using code: Deep Agent with Subgraphs

### 面向代码问答：具备子图能力的深度代理（Deep Agent）

A lot of questions needed searching diving into our codebases to verify implementation details in addition to leveraging documentation, knowledge bases and cross-referencing known issues as resources.

大量问题不仅需要查阅文档、知识库，还需深入我们的代码库以核实具体实现细节，同时交叉参考已知问题作为辅助信息源。

**The architecture:**

**架构设计：**

For these tasks, we built a `Deep Agent` with **specialized subgraphs**: one for **documentation search**, one for **knowledge base search**, and one for **codebase search**.

针对此类任务，我们构建了一个 `Deep Agent`（深度代理），并为其配备了 **专业化的子图（subgraphs）**：分别用于**文档搜索**、**知识库搜索**和**代码库搜索**。

Each subagent operates independently, asking follow-up questions, filtering through information, and extracting only the most relevant insights before passing them up to a main orchestrator agent. This prevents the main agent from drowning in context while allowing each domain expert to dig as deep as necessary.

各子代理（subagent）独立运行：自主提出后续问题、筛选信息、提取最相关的关键洞见，再将结果汇总至主协调代理（main orchestrator agent）。这一设计既避免了主代理被海量上下文“淹没”，又赋予每位领域专家按需深入挖掘的能力。

**The codebase search advantage:**  

**代码库搜索的优势：**

The codebase search subagent is particularly powerful. It can search our private repositories using pattern matching, navigate file structures to understand context, and read specific implementations with line-number precision.

代码库搜索子智能体尤为强大。它能够利用模式匹配搜索我们的私有代码仓库，遍历文件结构以理解上下文，并以精确到行号的方式读取特定实现。

**The tradeoff:**

**权衡考量：**

This deep agent architecture takes longer to run — sometimes **1-3 minutes** for complex queries — but the thoroughness is worth it. We leverage DeepAgent when the initial response is not addressing the core question.

这种深度智能体架构运行耗时更长——复杂查询有时需 **1–3 分钟**——但其全面性物有所值。当初始响应未能切中核心问题时，我们会启用 DeepAgent。

Disclaimer: This mode is only enabled for a subset of users at launch and will be made generally available in a few days.

免责声明：该模式在发布初期仅对部分用户开放，将在数日内全面上线。

* * *

## Why We Got Moved Away from Vector Embeddings

## 为何我们放弃向量嵌入方案

The standard approach to documentation search — chunk docs into pieces, generate embeddings, store in a vector database, retrieve by similarity — works fine for unstructured content like PDFs. But for structured product documentation, we kept hitting three problems.

文档搜索的标准做法——将文档切分为若干片段、生成向量嵌入、存入向量数据库、再按相似度检索——对于 PDF 等非结构化内容效果尚可；但对于结构化的产文档，我们却反复遭遇三大问题。

**Chunking breaks structure.** When you chop documentation into 500-token fragments, you lose headers, subsections, and context. The agent would cite `"set streaming=True"` without explaining why or when. Users had to hunt through pages to find what they needed.

**分块破坏结构。** 当你将文档切分为每段约 500 个 token 的碎片时，标题、子章节及上下文信息便随之丢失。智能体可能直接引用 `"set streaming=True"`，却不说明其适用场景或原因。用户不得不翻阅大量页面才能找到所需信息。

**Constant reindexing.** Our docs update multiple times daily. Every change meant re-chunking, re-embedding, and re-uploading. It slowed us down.

**持续重复索引。** 我们的文档每天更新多次，每次变更都意味着重新分块、重新生成嵌入、重新上传——严重拖慢了整体流程。

**Vague citations.** Users couldn't verify answers or trace where information came from.

**引用模糊不清。** 用户无法验证答案的准确性，也无法追溯信息来源。

The breakthrough was realizing we were solving the wrong problem. Documentation is already organized. Knowledge bases are already categorized. Codebases are already navigable. We didn't need smarter retrieval — we needed to give the agent direct access to that existing structure.

突破在于我们意识到自己一直在解决错误的问题。文档本身已是结构化的，知识库早已分类归档，代码库也天然具备可导航性。我们真正需要的并非更“聪明”的检索能力，而是让智能体直接访问这些既有的组织结构。

* * *

## The Better Approach: Direct API Access and Smart Prompting

## 更优方案：直连 API 与智能提示工程

Instead of chunking and embedding, we gave the agent direct access to the real thing. For documentation, we use `Mintlify's API`, which returns **full pages** with all their headers, subsections, and code examples intact. For the knowledge base, we query our support articles by title first, then read the most promising ones in full. For codebase search, **we uploaded our codebase to our LangGraph Cloud deployment** and use `ripgrep` for pattern matching, directory traversal to understand structure, and file reading to extract specific implementations.

我们没有采用分块（chunking）和向量化嵌入（embedding），而是让智能体直接访问真实、完整的原始数据源。对于文档检索，我们调用 `Mintlify's API`，它返回**完整的网页内容**，保留全部标题、子章节及代码示例；对于知识库，我们首先按标题搜索支持文章，再通读其中最相关的一至数篇；对于代码库搜索，**我们将整个代码库上传至 LangGraph Cloud 部署环境**，并利用 `ripgrep` 进行模式匹配、通过目录遍历理解项目结构、再逐文件读取以精准提取具体实现。

The agent doesn't retrieve based on similarity scores. It **searches like a human would** — with keywords, refinement, and follow-up questions.

智能体并不依赖相似度分数进行检索，而是**像人类一样搜索**——使用关键词、持续细化查询条件，并提出后续追问。

This is where the magic happens. We don't just tell the agent to search once and return whatever it finds. We prompt it to **think critically** about whether it has enough information. If the results are ambiguous or incomplete, the agent refines its query and searches again. If documentation mentions a concept without explaining it, the agent searches for that concept specifically. If multiple interpretations are possible, the agent narrows down to the most relevant one.

真正的“魔法”正发生于此：我们并非简单指令智能体执行一次搜索并返回结果；而是通过提示词引导它**批判性思考**——当前信息是否已足够？若结果含糊或不完整，智能体将主动优化查询并再次搜索；若文档提及某个概念却未加解释，智能体便会专门针对该概念发起新搜索；若存在多种可能解读，智能体则会逐步聚焦，锁定最相关的一种。

* * *

## Tool Design: Building for Human Workflows

## 工具设计：贴合人类实际工作流

We designed our tools to mirror how humans actually search, not how retrieval algorithms work.

我们的工具设计初衷，是复现人类真实的搜索行为，而非模仿传统检索算法的工作逻辑。

### Documentation Search: Full Pages, Not Fragments

### 文档搜索：获取完整页面，而非零散片段

The documentation search tool queries `Mintlify's API` and returns **complete pages**. When someone asks about streaming, the agent doesn't get three disjointed paragraphs from different sections — it gets the entire streaming documentation page, structured exactly as a human would read it.

文档搜索工具调用 `Mintlify 的 API`，并返回**完整的页面**。当有人询问有关流式传输（streaming）的问题时，智能体不会从不同章节中获取三段彼此割裂的段落——而是获得整篇关于流式传输的文档页面，其结构与人类阅读时完全一致。

```python
@tool
def SearchDocsByLangChain(query: str, page_size: int = 5, language: Optional[str] = None) -> str:
    """Search LangChain documentation via Mintlify API"""
    params = {"query": query, "page_size": page_size}
    if language:
        params["language"] = language
    response = requests.get(MINTLIFY_API_URL, params=params)
    return _format_search_results(response.json())
```

```python
@tool
def SearchDocsByLangChain(query: str, page_size: int = 5, language: Optional[str] = None) -> str:
    """通过 Mintlify API 搜索 LangChain 文档"""
    params = {"query": query, "page_size": page_size}
    if language:
        params["language"] = language
    response = requests.get(MINTLIFY_API_URL, params=params)
    return _format_search_results(response.json())
```

But we don't stop there. We prompt the agent to evaluate whether the initial results actually answer the question. _Is this the right section? Are there related concepts that need clarification? Would a more specific search term be better?_

但这还不是终点。我们进一步提示智能体评估初始检索结果是否真正回答了问题：_这是否是正确的章节？是否存在需要进一步澄清的相关概念？使用更具体的搜索词是否会更合适？_

The agent has a budget of **4-6 tool calls**, and we encourage it to use them strategically to refine its understanding before responding.

智能体被分配了 **4–6 次工具调用**的配额；我们鼓励它策略性地使用这些调用，在最终作答前不断深化和校准自身的理解。

**Here's what that looks like in practice:**

**实际应用中的流程如下：**

A user asks, _"How do I add memory to my agent?"_

用户提问：“我该如何为我的智能体添加记忆功能？”

The agent searches for `"memory"` and gets results that cover checkpointing, conversation history, and the Store API. Instead of picking one at random, the agent realizes the question is ambiguous — memory could mean persisting conversation state within a thread or storing facts across multiple conversations.

智能体首先搜索 `"memory"`，得到涵盖检查点（checkpointing）、对话历史（conversation history）以及 Store API 的若干结果。它并未随机选取其中某一项，而是意识到该问题存在歧义——“记忆”可能指在单个会话线程内持久化对话状态，也可能指跨多个会话存储事实信息。

It searches again with `"checkpointing"` to narrow down thread-level persistence, fetches the support article _"How do I configure checkpointing in LangGraph?"_ and recognizes it doesn't cover cross-thread memory.

于是它再次以 `"checkpointing"` 为关键词进行搜索，以聚焦于线程级持久化，并获取支持文章《如何在 LangGraph 中配置检查点？》；但随即意识到该文章并未涉及跨线程记忆。

So it searches for `"store API"` to fill the gap.

因此，它转而搜索 `"store API"`，以弥补这一知识缺口。

The final answer covers both checkpointing for conversation history and the Store API for long-term memory, with precise citations to the support article and documentation used.

最终答案全面涵盖了两方面内容：利用检查点机制管理对话历史，以及借助 Store API 实现长期记忆，并精准引用了所使用的支持文章与官方文档。

* * *

This iterative search process happens in seconds with Create Agent, but it fundamentally changes the quality of responses. The agent isn't just retrieving — it's reasoning about what the user actually needs.

* * *

借助 Create Agent，这一迭代式搜索过程仅需数秒即可完成，但其从根本上提升了响应质量。该智能体（agent）所执行的并非简单检索——而是针对用户真实需求进行推理。

### Knowledge Base Search: Scan, Then Read

### 知识库搜索：先扫描，再精读

We built the knowledge base (powered by Pylon) search as a **two-step process** because that's how humans use knowledge bases.

我们基于人类使用知识库的方式，将知识库（由 Pylon 驱动）搜索设计为一个**两步流程**。

First, the agent retrieves article titles — sometimes dozens of them — and scans them to identify which ones seem relevant. Then it reads only those articles in full.

首先，智能体检索文章标题——有时多达数十个——并快速扫描以识别其中哪些看似相关；随后，仅对这些相关文章进行全文阅读。

```python
@tool
def search_support_articles(collections: str = "all", limit: int = 50) -> str:
    """Step 1: Get article titles to scan"""
    articles = pylon_client.list_articles(collections=collections, limit=limit)
    return json.dumps([{\
        "id": a["id"],\
        "title": a["title"],\
        "url": a["url"]\
    } for a in articles])

@tool
def get_article_content(article_ids: List[str]) -> str:
    """Step 2: Read the most relevant articles"""
    articles = pylon_client.get_articles(article_ids)
    return "\\n\\n---\\n\\n".join([\
        f"# {a['title']}\\n\\n{a['content']}\\n\\nSource: {a['url']}"\
        for a in articles\
    ])
```

```python
@tool
def search_support_articles(collections: str = "all", limit: int = 50) -> str:
    """步骤 1：获取待扫描的文章标题"""
    articles = pylon_client.list_articles(collections=collections, limit=limit)
    return json.dumps([{\
        "id": a["id"],\
        "title": a["title"],\
        "url": a["url"]\
    } for a in articles])

@tool
def get_article_content(article_ids: List[str]) -> str:
    """步骤 2：精读最相关文章"""
    articles = pylon_client.get_articles(article_ids)
    return "\\n\\n---\\n\\n".join([\
        f"# {a['title']}\\n\\n{a['content']}\\n\\n来源：{a['url']}"\
        for a in articles\
    ])
```

**Why this works:**

**为何此方法行之有效：**

This prevents the agent from drowning in information. Instead of passing 30 full articles to the context window, the agent filters down to the 2-3 that actually matter, reads them thoroughly, and extracts the key insights.

这可避免智能体被海量信息淹没。与其将 30 篇完整文章全部送入上下文窗口，不如先筛选出真正关键的 2–3 篇，深入阅读后精准提炼核心洞见。

The prompting reinforces this: _focus on quality over quantity, narrow your search if needed, and return only the information that directly answers the question._

提示词进一步强化了这一原则：_重质不重量，必要时缩小搜索范围，并仅返回直接回答问题的信息。_

* * *

### Codebase Search: Search, Navigate, Verify

### 代码库搜索：搜索、导航、验证

This is where our `Deep Agent` shines.

这正是我们的 `Deep Agent` 大放异彩之处。

We gave the agent three tools that mirror the workflow from the opening — the same pattern our engineers follow when using `Claude Code`:

我们为该智能体配备了三个工具，精准复现了开篇所描述的工作流——也正是我们的工程师在使用 `Claude Code` 时所遵循的相同模式：

```python
@tool
def search_public_code(pattern: str, path: Optional[str] = None) -> str:
    """Step 1: Find code matching a pattern"""
    cmd = ["rg", pattern, str(path or search_path)]
    return subprocess.run(cmd, capture_output=True, text=True).stdout

@tool
def list_public_directory(path: str, max_depth: int = 2) -> str:
    """Step 2: Understand the file structure"""
    cmd = ["tree", "-L", str(max_depth), str(path)]
    return subprocess.run(cmd, capture_output=True, text=True).stdout

@tool
def read_public_file(file_path: str, start_line: int = 1, num_lines: int = 100) -> str:
    """Step 3: Read the actual implementation"""
    with open(file_path, "r") as f:
        lines = f.readlines()
    return "\\n".join(lines[start_line-1:start_line-1+num_lines])
```

**How it works:**

**工作原理：**

First, it searches the codebase for a pattern using `ripgrep`. Then it lists the directory structure to understand how files are organized. Finally, it reads the specific file, focusing on the relevant section, and returns the implementation with line numbers.

首先，它使用 `ripgrep` 在代码库中搜索匹配指定模式的代码；接着，列出目录结构以理解文件组织方式；最后，读取目标文件，并聚焦于相关代码段，返回带行号的具体实现。

**Real-world example:**

**真实场景示例：**

A user reports that streaming tokens hang in production. The docs subagent finds that streaming configuration involves buffer settings. The knowledge base subagent surfaces a support article about token streaming issues after upgrades.

一名用户报告称，流式传输 token 在生产环境中出现卡顿。文档子智能体发现，流式传输配置涉及缓冲区设置。知识库子智能体则检索到一篇支持文章，内容是关于升级后出现的 token 流式传输问题。

But the codebase subagent is the one that finds the actual implementation — it searches for `"streaming buffer"`, navigates to `callbacks/streaming.py`, and returns **lines 47-83** where the default buffer size is hardcoded.

但真正定位到实际实现的是代码库子智能体——它搜索 `"streaming buffer"`，导航至 `callbacks/streaming.py`，并返回 **第 47–83 行**，其中默认缓冲区大小被硬编码。

That's the kind of deep investigation that solves real problems.

这正是能解决实际问题的深度排查。

**The difference?** The `Deep Agent` can work in parallel across all three domains, and summarize the interim findings into one coherent answer.

**区别何在？** `Deep Agent` 能够在全部三个领域（文档、知识库、代码库）中并行工作，并将各子智能体的阶段性发现汇总为一个连贯、统一的答案。

* * *

## How Deep Agent and Subgraphs Solve Context Overload

## Deep Agent 与子图如何解决上下文过载问题

When we first built the deep agent as a single system with access to all three tools, it would return everything it found. The main agent would get five documentation pages, twelve knowledge base articles, and twenty code snippets — all at once.

最初，我们将 Deep Agent 构建为一个可同时访问全部三项工具的单一系统，结果它会把所有检索到的内容一股脑返回：主智能体一次收到五份文档页面、十二篇知识库文章和二十段代码片段。

The context window would explode, and the final response would either be bloated with irrelevant details or miss the key insight entirely.

这会导致上下文窗口严重超载，最终生成的回复要么充斥大量无关细节而臃肿不堪，要么完全遗漏关键洞见。

That's when we restructured it with specialized subgraphs.

于是，我们通过引入专业化的子图（subgraphs）对其进行了重构。

**How it works:**  

**其工作原理如下：**

Each subagent operates independently. It searches its domain, asks follow-up questions to clarify ambiguity, filters through the results, and extracts only the **golden data**: the essential facts, citations, and context needed to answer the question.

每个子智能体均独立运行。它在其专业领域内执行搜索，提出后续问题以澄清模糊之处，对结果进行筛选，并仅提取**黄金数据**：即回答问题所必需的核心事实、引用来源及上下文信息。

The main orchestrator agent never sees the raw search results. It only receives the refined insights from each domain expert. Look at a full trace along with prompts \*\* [here](https://smith.langchain.com/public/c1059a52-d045-4013-a17f-3bdc07ef3f0d/r/67669d45-0065-47de-b0ee-0b4ca2687060?ref=blog.langchain.com).

主协调智能体从不接触原始搜索结果，仅接收来自各领域专家提炼后的洞察信息。请在此处查看完整的执行追踪（trace）及对应提示词（prompts）：[此处](https://smith.langchain.com/public/c1059a52-d045-4013-a17f-3bdc07ef3f0d/r/67669d45-0065-47de-b0ee-0b4ca2687060?ref=blog.langchain.com)。

**Why this matters:**

**为何这至关重要：**

The docs subagent might read five full pages but return only two key paragraphs. The knowledge base subagent might scan twenty article titles but return only three relevant summaries. The codebase subagent might search fifty files but return only the specific implementation with line numbers.

文档子智能体可能通读五整页内容，但仅返回两个关键段落；知识库子智能体可能浏览二十篇文章标题，却只返回三份相关摘要；代码库子智能体可能检索五十个文件，却仅返回带行号的具体实现代码。

The main agent gets clean, curated information that it can synthesize into a comprehensive answer.

主智能体获得的是干净、精炼的信息，可据此综合生成全面、准确的回答。

* * *

## **Making It Production-Ready**

## **打造生产就绪系统**

Even elegant agent designs need production infrastructure to survive contact with real users. We built modular [middleware](https://docs.langchain.com/oss/javascript/langchain/middleware?ref=blog.langchain.com#middleware) to handle the operational concerns that would otherwise clutter our prompts.

再精巧的智能体设计，也需依托生产级基础设施，方能经受真实用户的考验。我们构建了模块化的[中间件（middleware）](https://docs.langchain.com/oss/javascript/langchain/middleware?ref=blog.langchain.com#middleware)，用以处理各类运维问题——否则这些问题将不可避免地污染我们的提示词（prompts）。

```python
middleware = [\
    guardrails_middleware,      # Filter off-topic queries\
    model_retry_middleware,     # Retry on API failures\
    model_fallback_middleware,  # Switch models if needed\
    anthropic_cache_middleware  # Cache expensive calls\
]
```

```python
middleware = [\
    guardrails_middleware,      # 过滤无关查询\
    model_retry_middleware,     # 在 API 调用失败时自动重试\
    model_fallback_middleware,  # 如有必要，自动切换至备用模型\
    anthropic_cache_middleware  # 缓存高开销调用\
]
```

**What each layer does:**

**各中间件层的功能说明：**

**Guardrails** filter out off-topic queries so the agent stays focused on LangChain questions.

**防护机制（Guardrails）** 过滤掉与主题无关的查询，确保智能体始终专注于 LangChain 相关问题。

**Retry middleware** handles temporary API failures gracefully, so users never see cryptic error messages.

**重试中间件（Retry middleware）** 优雅地处理临时性 API 故障，避免用户看到晦涩难懂的错误信息。

**Fallback middleware** switches between Haiku, GPT-4o Mini, and Gemini Nano if a model is unavailable.

**回退中间件（Fallback middleware）** 在某个模型不可用时，自动在 Haiku、GPT-4o Mini 和 Gemini Nano 之间切换。

**Caching** reduces costs by reusing results for identical queries.

**缓存（Caching）** 通过复用相同查询的结果来降低成本。

These layers are invisible to users, but they're essential for reliability. They let the agent focus on reasoning while the infrastructure handles failure modes, cost optimization, and quality control.

这些层级对用户完全透明，却是保障系统可靠性的关键。它们让智能体专注推理，而基础设施则负责应对各类故障场景、成本优化与质量管控。

* * *

## Getting the Agent to Users

## 将智能体交付给用户

Building a great agent is only half the battle. The other half? Getting it to users in a way that feels fast and intelligent.

构建一个出色的智能体仅完成了一半工作；另一半呢？是以一种让用户感觉快速且智能的方式将其交付到用户手中。

We use the **LangGraph SDK** to handle all the complexity of streaming and state management.

我们使用 **LangGraph SDK** 来处理流式传输与状态管理的所有复杂性。

### **Loading User Threads:**

### **加载用户对话线程：**

When someone opens Chat LangChain, we fetch their conversation history using the LangGraph SDK:

当某人打开 Chat LangChain 时，我们使用 LangGraph SDK 获取其对话历史：

```tsx
const userThreads = await client.threads.search({
  metadata: { user_id: userId },
  limit: THREAD_FETCH_LIMIT,
})
```

```tsx
const userThreads = await client.threads.search({
  metadata: { user_id: userId },
  limit: THREAD_FETCH_LIMIT,
})
```

Every thread stores the user's ID in metadata, so conversations stay private and persistent across sessions. The LangGraph SDK handles the filtering automatically.

每个对话线程（thread）都在元数据（metadata）中存储了用户的 ID，从而确保对话在不同会话间保持私密性与持久性。LangGraph SDK 自动完成相关筛选工作。

### S **treaming Responses in Real Time:**

### 实时流式响应：

When a user sends a message, the LangGraph SDK streams the response as it generates:

当用户发送消息时，LangGraph SDK 在模型生成响应的过程中实时流式输出结果：

typescript

typescript

```tsx
const streamResponse = client.runs.stream(threadId, "docs_agent", {
  input: { messages: [{ role: "user", content: userMessage }] },
  streamMode: ["values", "updates", "messages"],
  streamSubgraphs: true,
})

for await (const chunk of streamResponse) {
  if (chunk.event === "messages/partial") {
    setMessages(prev => updateWithPartialContent(chunk.data.content))
  }
}
```

```tsx
const streamResponse = client.runs.stream(threadId, "docs_agent", {
  input: { messages: [{ role: "user", content: userMessage }] },
  streamMode: ["values", "updates", "messages"],
  streamSubgraphs: true,
})

for await (const chunk of streamResponse) {
  if (chunk.event === "messages/partial") {
    setMessages(prev => updateWithPartialContent(chunk.data.content))
  }
}
```

**What users see:**

**用户所见：**

Three stream modes show the agent's entire thought process:

三种流式模式共同呈现智能体（agent）完整的推理过程：

- **`messages`** — Tokens appear progressively as the agent writes  
- **`messages`** — 令牌随智能体书写过程逐步生成  

- **`updates`** — Tool calls reveal what the agent is searching  
- **`updates`** — 工具调用揭示智能体正在执行的搜索操作  

- **`values`** — Final complete state after processing  
- **`values`** — 处理完成后的最终完整状态  

Users watch the agent think, search docs, check the knowledge base, and build the response token-by-token. No loading spinners.  
用户可实时观察智能体思考、查阅文档、检索知识库，并逐词构建响应的全过程——全程无加载转圈动画。

### Conversation Memory  

### 对话记忆  

Pass the same `thread_id` across messages and LangGraph's checkpointer handles the rest. It stores conversation history, retrieves context for each turn, and maintains state across sessions. We set a 7-day TTL. That's it.  
在多次消息交互中复用同一 `thread_id`，LangGraph 的检查点机制（checkpointer）将自动接管其余工作：它负责存储对话历史、为每一轮交互检索上下文，并跨会话维持状态。我们设定了 7 天的生存时间（TTL）。仅此而已。

* * *

## The Results  

## 实际成效  

Since launching the new systems, we've seen dramatic improvements.  
自新系统上线以来，我们已观察到显著提升。

For public Chat LangChain, users get **sub-15-second responses** with precise citations. They can verify answers immediately because we link directly to the relevant documentation page or knowledge base article. And we no longer spend hours reindexing — the documentation updates automatically.  
面向公众的 Chat LangChain 现可提供**15 秒内响应**，且所有答案均附带精准引用。用户能立即验证答案真伪，因为我们直接链接至相关文档页面或知识库文章；同时，我们也不再需要耗费数小时重新索引——文档更新现已全自动完成。

Internally, our support engineers use the `Deep Agent` to handle the most complex tickets. It searches documentation, cross-references known issues, and dives into our private codebase to find the implementation details that actually explain what's happening. **The agent doesn't replace our engineers — it amplifies them**, handling the research so they can focus on solving the problem.  
在内部，我们的支持工程师借助 `Deep Agent` 处理最复杂的工单。该智能体可检索文档、交叉比对已知问题，并深入我们的私有代码库，定位真正解释问题成因的实现细节。**智能体并非取代工程师，而是赋能工程师**——它承担繁重的研究工作，使工程师得以专注于问题解决本身。

* * *

## Key Takeaways

## 关键要点

- **遵循用户的实际工作流：** 不要另起炉灶；应自动化那些最优秀用户（或内部专家）已在高效使用的成功工作流。对 LangChain 而言，这意味着复现其核心三步仪式：依次查阅 **文档（docs）**、**知识库（knowledge base）** 和 **代码库（codebase）**。  
- **评估向量嵌入是否适用：** 对于产品文档和源代码等结构化内容，使用向量嵌入可能破坏原有文档结构、导致引用模糊不清，并需持续重新索引。向量嵌入在处理非结构化内容、较短文本块或聚类类任务时表现卓越。  
- **赋予智能体对结构的直接访问能力：** 该方法使智能体能通过 API 直接访问内容固有的结构化组织方式，从而像人类一样，借助关键词搜索与逐步细化来精准定位信息。  
- **优先保障推理能力，而非单纯检索：** 工具设计应贴近人类认知习惯：先浏览文章标题再深入阅读正文；对代码则采用模式匹配与目录导航。同时提示智能体主动提出后续问题，并在初始结果存在歧义时优化查询，确保最终答案真正满足用户的实际需求。  
- **利用深度智能体（Deep Agents）与子图（subgraphs）管理上下文：** 面对跨领域的复杂问题，采用具备专业化 **子图（subgraphs）** 的 **深度智能体（Deep Agent）**，可避免主协调智能体被海量原始搜索结果淹没。每个子智能体仅从其专属领域中筛选并提取“黄金数据”，再将精炼后的洞察向上交付。  
- **生产环境亟需中间件支持：** 即便智能体架构设计再精巧，也离不开稳健基础设施支撑才能实现可靠运行。必须构建模块化的中间件，涵盖 **安全护栏（guardrails）**（过滤偏离主题的查询）、**重试机制（retries）**（应对 API 失败）、**降级策略（fallbacks）**（自动切换模型）以及 **缓存（caching）**，这是保障生产级可靠性、成本优化与质量管控的关键。

* * *

## What's Next

## 下一步计划

**公开代码库搜索功能**（将在未来几天内上线）—— 当文档与知识库信息不足时，智能体将自动检索我们的公开代码仓库，以验证具体实现细节，并精确引用到某一行代码。  

* * *

## Try It Yourself

## 立即体验

Chat LangChain 已正式上线：[chat.langchain.com](https://chat.langchain.com/?ref=blog.langchain.com)。推荐使用 `Claude Haiku 4.5` 获取最快响应；也可尝试 `GPT-5 Mini` 与 `GPT-5 Nano`，直观对比不同模型的实际表现。

* * *

## Join the Conversation

## 加入讨论

Building agents that balance speed and depth is hard, and we're still learning. If you're working on similar problems, we'd love to hear what you're discovering.

构建兼顾速度与深度的智能体十分困难，我们仍在不断探索。如果您也在研究类似问题，我们非常期待了解您的发现。

Join the LangChain community on our [forum](https://forum.langchain.com/?ref=blog.langchain.com) or follow us on [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com).

欢迎加入 LangChain 社区——访问我们的 [论坛](https://forum.langchain.com/?ref=blog.langchain.com)，或在 [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com) 上关注我们。
&#123;% endraw %}
