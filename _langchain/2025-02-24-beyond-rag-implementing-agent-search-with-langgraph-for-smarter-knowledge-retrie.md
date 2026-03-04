---
title: "Beyond RAG: Implementing Agent Search with LangGraph for Smarter Knowledge Retrieval"
source: "LangChain Blog"
url: "https://blog.langchain.com/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrieval/"
date: "2025-02-24"
scraped_at: "2026-03-03T07:39:41.341080070+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's note: this is a guest post from our friends at_ [_Onyx_](https://www.onyx.app/?ref=blog.langchain.com) _. As LangGraph has matured, we've seen more and more companies (_ [_Klarna_](https://blog.langchain.com/customers-klarna/) _,_ [_Replit_](https://blog.langchain.com/customers-replit/) _,_ [_AppFolio_](https://blog.langchain.com/customers-appfolio/) _,_ [_etc_](https://blog.langchain.com/tag/case-studies/) _) start to use it as their agent framework of choice. We thought this was a great blog describing in detail how that evaluation is done. You can read_ [_a version of this post on their blog_](https://www.onyx.app/blog/agent-search-with-langgraph?ref=blog.langchain.com) _as well._

_编辑注：本文为我们的合作伙伴_ [_Onyx_](https://www.onyx.app/?ref=blog.langchain.com) _撰写的客座文章。随着 LangGraph 的日趋成熟，越来越多的公司（如_ [_Klarna_](https://blog.langchain.com/customers-klarna/) _、_ [_Replit_](https://blog.langchain.com/customers-replit/) _、_ [_AppFolio_](https://blog.langchain.com/customers-appfolio/) _以及_ [_其他案例_](https://blog.langchain.com/tag/case-studies/) _）开始将其作为首选的智能体（agent）框架。我们认为这篇博客深入详尽地阐述了此类技术选型的评估过程，非常值得分享。您也可在_ [_Onyx 官方博客_](https://www.onyx.app/blog/agent-search-with-langgraph?ref=blog.langchain.com) _上阅读该文的原始版本。_

By Evan Lohn, Joachim Rahmfeld  
作者：Evan Lohn、Joachim Rahmfeld

At [Onyx](https://www.onyx.app/?ref=blog.langchain.com), we are dedicated to expanding the knowledge and insights users can gain from their enterprise data, thereby enhancing productivity across job functions.

在 [Onyx](https://www.onyx.app/?ref=blog.langchain.com)，我们致力于拓展用户从企业数据中所能获取的知识与洞见，从而全面提升各岗位职能的工作效率。

So, what is [Onyx](https://www.onyx.app/?ref=blog.langchain.com)? Onyx is an AI Assistant that companies can deploy at any scale—on laptops, on-premises, or in the cloud—to connect documented knowledge from many sources, including Slack, Google Drive, and Confluence. Onyx leverages LLMs to create a subject matter expert for teams, enabling users to not only find relevant documents and but also get answers for questions such as "Is feature X already supported?" or "Where's the pull request for feature Y?"

那么，[Onyx](https://www.onyx.app/?ref=blog.langchain.com) 到底是什么？Onyx 是一款面向企业的 AI 助手，支持任意规模部署——可在笔记本电脑、本地服务器或云端运行——用以整合来自 Slack、Google Drive、Confluence 等多种来源的结构化与非结构化知识文档。Onyx 借助大语言模型（LLM），为团队构建专属领域专家，不仅帮助用户精准定位相关文档，更能直接回答诸如“功能 X 是否已支持？”或“功能 Y 的 Pull Request 在哪里？”等具体问题。

Last year, we embarked on enhancing our Enterprise Search and Knowledge Retrieval capabilities by setting the following goals:

去年，我们启动了一项提升企业级搜索与知识检索能力的计划，并设定了以下目标：

- **Enable scalable answers to complex and ambiguous questions**  
- **Improve answer quality when multiple entities are involved**  
- **Provide richer detail and context around key aspects of questions**

- **支持对复杂且语义模糊问题的可扩展性回答**  
- **在涉及多个实体时，提升答案质量**  
- **围绕问题的关键要素，提供更丰富、更具体的细节与上下文**

Questions that fall into these categories are usually of high value to the user, however a traditional RAG-like system tends to struggle in these situations.

属于上述类别的问题通常对用户具有极高价值；然而，传统类 RAG（Retrieval-Augmented Generation）系统在这些场景下往往表现乏力。

For example, consider the question: “ _What are some of the product-related differences between what we positioned at Nike vs Puma that could factor into our differing sales outcomes?_”. This question involves both, multiple entities, as well as an ambiguity ( _product-related sales outcomes_ can mean many things).

例如，考虑这个问题：“_我们在耐克（Nike）与彪马（Puma）所定位的产品存在哪些差异？这些差异如何影响了我们截然不同的销售结果？_” 该问题既涉及多个实体（Nike、Puma、产品、销售结果），又包含语义模糊性（“与产品相关的销售结果”可有多种解读）。

Unless there happen to be documents in the corpus that deal pretty much with this exact question, a RAG system is challenged to find a good answer here.

除非知识库中恰好存在与该问题高度匹配的文档，否则 RAG 系统很难在此类情形下给出优质答案。

These are the types of questions where our new Agent Search comes in. What is the idea here?

而这类问题，正是我们全新推出的“智能体搜索（Agent Search）”所要解决的核心挑战。其设计思路究竟是什么？

On a high level, the approach is to 1) first break up the question into sub-questions that can focus on more narrow contexts as well as disambiguation of potentially ambiguous terms, 2) compose an initial answer using the answered sub-questions and fetched documents, and then 3) produce a further refined answer based on the initial answer and various facts that have been learned during the initial process.

从高层视角来看，该方法包含三个步骤：1）首先将原始问题拆解为若干子问题，使每个子问题聚焦于更狭窄的上下文，并对潜在歧义术语进行消歧；2）基于已解答的子问题及检索到的文档，生成初始答案；3）再以初始答案和初始处理过程中所获取的各项事实为基础，进一步生成精细化的答案。

To make this more concrete for the example above, some valid initial sub-questions could be ‘Which products did we discuss with Puma?’, ‘Which products did we discuss with Nike?’, ‘Which issues were reported by Puma?’...

为使上述思路在前述示例中更具象化，一些合理的初始子问题可包括：“我们与彪马（Puma）讨论了哪些产品？”、“我们与耐克（Nike）讨论了哪些产品？”、“彪马报告了哪些问题？”……

To encapsulate this type of logical process a lot of steps, calculations, and LLM calls need to be organized and orchestrated.

要将此类逻辑流程封装成可执行系统，需统筹编排大量步骤、计算任务以及大语言模型（LLM）调用。

The purpose of this blog is i) to illustrate how we approached this problem on a functional level, ii) discuss how we went about our technology selection approach, and iii) share in good detail how we leveraged LangGraph as a backbone, and specifically which lessons we learned.

本博客旨在：i）从功能层面阐释我们如何应对这一挑战；ii）探讨我们在技术选型过程中的思考路径；iii）详尽分享我们如何以 LangGraph 为底层框架构建系统，并具体总结其中的关键经验教训。

We hope this write-up will be useful to readers who are interested in this space and/or who want to build agents using LangGraph and share some of our requirements.

我们希望本文能为关注该领域，或有意基于 LangGraph 构建智能体（agents）的读者提供切实帮助，并同步分享我们的一些实际需求。

# General Flow and Technical Requirements

# 整体流程与技术要求

Roughly, our targeted logical flow looks on the high level like this:

粗略而言，我们所设计的逻辑流程在高层面上如下所示：

![Agent Search flow](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_001.jpg)

![智能体搜索流程图](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_001.jpg)

Key aspects and requirements of this flow are:

该流程的关键特征与技术要求包括：

- In addition to searching relevant documents for the original question directly, we break up the initial question into more narrow, well-defined sub-questions. This helps with disambiguation and narrowing the search focus  
- 除直接针对原始问题检索相关文档外，我们还将初始问题拆解为更具体、定义更清晰的子问题，从而提升术语消歧能力，并进一步聚焦检索范围。

- The decomposition is informed by an initial search, giving some context to the decomposition  
- 拆解过程受一次初始检索结果的启发，为问题分解提供上下文依据。

- The answering of each subquestion has many parts: query expansion, search, document validations, reranking, subanswer generation, subanswer verification  
- 每个子问题的回答流程包含多个环节：查询扩展（query expansion）、检索、文档有效性验证（document validation）、重排序（reranking）、子答案生成（subanswer generation）及子答案校验（subanswer verification）。

- The initial answer is based on a search + the answers of the subquestions.  
- 初始答案由一次综合检索结果与各子问题的回答共同构成。

- If the initial answer is lacking, we perform another decomposition to generate a refined answer, which is designed to address shortcomings and/or follow-up on answers to subquestions. This refinement decomposition is informed by:  
- 若初始答案存在不足，我们将启动新一轮问题分解，以生成精细化答案——该答案旨在弥补既有缺陷，和/或针对子问题回答展开延伸追问。此次精细化分解的依据包括：  
  - the question and the original answer (and the fact that it is lacking)  
  - 原始问题与初始答案（及其已知的不足之处）；  
  - the sub-questions and their answers (and the sub-questions that were not answerable)  
  - 各子问题及其对应答案（以及那些未能成功解答的子问题）；  
  - a separate entity/relationship/term extraction based on the initial search to better align the decomposition with the contents of the document set  
  - 基于初始检索结果独立开展的实体/关系/术语抽取，以使后续分解更贴合文档集合的实际内容。

- Overall, parallelism is imperative on many levels, including:  
- 总体而言，多层级并行处理至关重要，具体体现在：  
  - retrieved document verifications for each subquestion processing  
  - 针对每个子问题处理流程所开展的检索文档验证；  
  - the processing of multiple sub-questions in parallel  
  - 多个子问题的并行处理；  
  - entity/relationship/term extraction in parallel with the handling of the subquestions  
  - 实体/关系/术语抽取与子问题处理同步并行执行。

- Similarly, dependency management is essential. Examples are:  
- 同样地，依赖关系管理也极为关键。典型示例如下：  
  - the decomposition in the refinement phase has to wait until both, the initial answer is generated (and need for refinement has been determined), and the extraction of the entities, relationships, and terms are done  
  - 精细化阶段的问题分解必须等待两个前提条件同时满足：一是初始答案已生成且确认其确有改进必要；二是实体、关系与术语的抽取工作已完成；  
  - future steps are informed by the outcome of earlier steps  
  - 后续步骤的执行逻辑严格依赖于前期步骤的输出结果。

So indeed, a lot has to happen to achieve our goal of being able to address substantially broader and more ambiguous questions.

的确，要实现我们“能够应对范围更广、语义更模糊的问题”这一目标，还需完成大量工作。

While this flow is certainly quite workflow-centric, it presents an initial step towards a broad(er) Agent Search flow(s). We intend to hook various tools into the flow, update the refinement process, etc. We may at a later date potentially also introduce Human-in-the-Loop type interactions with the users, like approving answers before refinement or re-running part of the flow with some manual changes.

尽管当前流程明显以工作流为中心，但它已迈出了通向更广泛（甚至更通用）的“智能体搜索”（Agent Search）流程的第一步。我们计划将多种工具接入该流程，并持续优化细化（refinement）环节等。未来，我们还可能引入“人在环中”（Human-in-the-Loop）式的人机协同交互机制，例如：在细化前由用户审核答案，或在人工干预调整后重新执行流程中的某一部分。

Addressing our requirements, also with an eye towards the near/mid future, asks for a framework that

面向我们的实际需求——同时兼顾近期及中期发展愿景——我们需要一个满足以下要求的框架：

1. is well-controlled,  
1. 具备良好的可控性；  

2. is easy to extend or (re)configure,  
2. 易于扩展或（重新）配置；  

3. is cost-effective,  
3. 具有成本效益；  

4. allows for a high degree of parallelization,  
4. 支持高度并行化；  

5. can manage logical dependencies (A and B need to be done before C starts, and E can run in parallel to all of this, etc.), and  
5. 能够管理逻辑依赖关系（例如：任务 A 和 B 必须在任务 C 启动前完成；而任务 E 则可与上述所有任务并行执行等）；  

6. enables streaming of tokens and other objects  
6. 支持 token 及其他对象的流式传输；  

7. allows in the future for more complex interactions.  
7. 为未来支持更复杂的交互模式预留扩展空间。

And - oh, yeah! - the answers also needed to be produced in a timely manner matching user expectations, and do so at scale.

此外——对了，这点当然也很关键！——系统还需在符合用户预期的时间内生成答案，并能支撑大规模并发请求。

So the key question we had to address was ”How do we best implement this?”

因此，我们亟需回答的核心问题是：“如何最优地实现这一目标？”

# Framework Options & Evaluation Approach

# 框架选型与评估方法

The options for us were essentially whether to implement this flow ourselves from the ground up by extending our existing flow, or to leverage an existing agentic framework - and if so, which one.

我们的可选路径本质上只有两种：一是基于现有流程从零开始自主构建该流程；二是采用一个现成的智能体（agentic）框架——如果选择后者，又该选用哪一个？

Given our priorities outlined above, we landed on LangGraph as our main candidate for our implementation framework, with implementation-from-scratch probably a relatively close second.

基于前述各项优先级考量，我们最终将 LangGraph 确定为主要候选实现框架；而完全自主实现的方案则可能紧随其后，成为次优选项。

The initial drivers in favor of LangGraph were:  

最初促使我们倾向 LangGraph 的关键因素包括：

- A natural “their pictures look like our pictures”-situation, meaning: the flow we had laid out maps very well to LangGraph’s concepts of Nodes, Edges, and States  
- 一种自然的“他们的图景与我们的图景高度吻合”的情形，即：我们此前设计的流程与 LangGraph 中的节点（Nodes）、边（Edges）和状态（States）概念高度契合。

- Open Source framework with a strong community  
- 开源框架，拥有活跃且强大的社区支持。

- ‘Not brand-new’ (relative to the innovation time-scales in this space)  
- “并非全新”（相对于该领域内技术创新的时间尺度而言）。

- High degree of control  
- 高度可控性。

- Native streaming support  
- 原生流式响应（streaming）支持。

- Interesting features for potential future Onyx functionality like Human-in-the-Loop or the ability to rerun the agent flow with some parameters altered  
- 一些颇具潜力的特性，可支撑 Onyx 未来功能的演进，例如“人在环中”（Human-in-the-Loop）机制，或在调整部分参数后重新运行智能体（agent）流程的能力。

However, we certainly also had some concerns which favored an implementation from-scratch, including:  
然而，我们也确实存在若干顾虑，这些顾虑更倾向于从零开始自主实现，包括：

- Dependency on a third party and reduced end-to-end control  
- 对第三方的依赖，导致端到端控制力下降。

- Mutable state variables in LangGraph (‘ _Who changed this value?_’)  
- LangGraph 中存在可变状态变量（“谁修改了这个值？”）。

- Less visibility into the call stack for debugging purposes  
- 调试时对调用栈（call stack）的可观测性较弱。

- Change of our existing flow  
- 对我们现有流程结构的改动。

To decide, as one does for most projects of this type, we started with a prototype evaluation. Specifically, we quickly (~1 week/1 FTE, including learnings) implemented a stripped-down, stand-alone LangGraph implementation of our targeted flow, where we tried to test:  
为做出决策——正如大多数同类项目所采用的方式——我们首先开展了原型验证。具体而言，我们快速（约 1 周 / 1 人月，含学习成本）构建了一个精简、独立的 LangGraph 实现版本，覆盖我们目标流程的核心逻辑，并重点测试以下方面：

- approximate end-to-end functionality that delivers acceptable run times  
- 端到端功能的大致完备性，以及是否能达到可接受的执行耗时。

- fan-out parallelization  
- 扇出式（fan-out）并行化能力。

- subgraph parallelization  
- 子图（subgraph）级并行化能力。

- potential issues around state management  
- 状态管理（state management）方面可能存在的问题。

- streaming  
- 流式响应（streaming）支持效果。

The results were encouraging, and we proceeded to implement our actual flow in LangGraph within our application. As expected, in the process, we learned a number of additional lessons. Below we document what we have learned, and the conventions we intend to follow in the future, as our use of Agent flows will expand.  
验证结果令人鼓舞，于是我们进一步在应用中基于 LangGraph 实现了真实的业务流程。不出所料，在此过程中，我们又收获了许多新的实践经验。下文将系统梳理这些经验教训，并明确我们未来将遵循的开发规范——随着 Agent 流程在 Onyx 中的应用范围持续扩大，这些实践将愈发重要。

# LangGraph Learnings - Our Best Practices Moving Forward  
# LangGraph 实践总结 —— 我们面向未来的最佳实践

As the project quickly grew more complex, here are some of the observations we made and practices we adhered to.  
随着项目复杂度迅速提升，我们形成了一些关键观察结论，并确立了若干需长期坚持的实践规范。

## Code Organization  
## 代码组织

### Directory and File Structure  
### 目录与文件结构

- The number of nodes can get rather large across a complex graph. We decided to use a one-node-per-file approach (modulo reuse of functions for different nodes).  
- 在复杂的图结构中，节点数量可能变得相当庞大。我们决定采用“一个节点对应一个文件”的方式（仅在不同节点复用相同函数时例外）。

- With many nodes, a clear directory structure and file naming strategy are advised. We created a directory for each subgraph and generally adopted an `<action>_<object>.py` naming convention. Adding a digit for the step number can also be helpful, while it would require some extra work when nodes are added or removed.  
- 当节点数量较多时，建议采用清晰的目录结构和统一的文件命名策略。我们为每个子图（subgraph）创建了独立的目录，并普遍采用 `<动作>_<对象>.py` 的命名规范。在文件名中加入步骤序号（如 `01_`、`02_`）也有助于理解执行顺序；但需注意：当增删节点时，这类序号需手动调整，带来额外维护成本。

- We use subgraphs extensively for purposes of parallelization (see below) and reuse. Each subgraph directory has its own edges, states and models files as well as its graph builder.  
- 我们广泛使用子图来实现并行化（见下文）和逻辑复用。每个子图目录均包含其专属的 `edges.py`、`states.py`、`models.py` 文件，以及对应的图构建器（graph builder）。

- To visualize the graph, using a mermaid png of the overall graph proved to be very useful.  
- 为可视化图结构，生成 Mermaid 格式的整体图 PNG 文件被证明非常有用。

### Typing & State Management  
### 类型注解与状态管理  

We use Pydantic across our code base, so it was great to see that LangGraph supports Pydantic models in addition to TypeDicts. Consequently, we use Pydantic models all through the LangGraph implementation as well. (Unfortunately, for graph outputs Pydantic is not yet supported).  
我们在整个代码库中均使用 Pydantic，因此很高兴看到 LangGraph 除支持 `TypeDict` 外，也原生支持 Pydantic 模型。因此，在 LangGraph 的实现中，我们也全程采用 Pydantic 模型。（遗憾的是，目前图的输出（graph outputs）尚不支持 Pydantic 模型。）

As we have many nodes with their own actions and ‘outputs’ (state updates) within a subgraph, we generally look at the (sub)graph states as driven by the node updates. So rather than defining the keys directly within the subgraph state, we define Pydantic state models for the various node updates and then construct the graph state by inheriting from the various node update (and other) models.  
由于子图中包含大量各自具备独立行为与“输出”（即状态更新）的节点，我们通常将（子）图的状态视为由各节点更新所驱动。因此，我们并不直接在子图状态中显式定义键（keys），而是为各类节点更新分别定义 Pydantic 状态模型，再通过继承多个节点更新模型（及其他相关模型）来组合构建最终的图状态。

**Benefits**:  
**优势**：

- Keys are naturally grouped  
- 键（keys）按语义自然分组  

- One only has to update the node state model (and the node) when adding keys  
- 新增键时，只需更新对应节点的状态模型（及该节点逻辑）  

- Overlap of keys is allowed  
- 允许不同模型间存在键名重叠（即同名键可被多次定义，以支持灵活覆盖或合并）  

- Default values are allowed  
- 支持为字段设置默认值  

**Challenges:**  
**挑战**：

- Following this approach certainly makes it a bit harder to see the complete set of keys in the overall graph state.  
- 采用此方式确实会略微增加查看整体图状态中全部键的难度  

- One has to pick a good structure to avoid inheritance issues  
- 必须精心设计继承结构，以避免多重继承引发的冲突或歧义  

Not surprisingly, being deliberate about setting default values (or not!) for state keys is very important. If not handled carefully, setting default values in inappropriate situations can lead to unintended behavior that may be more difficult to detect. For instance, consider the following problematic configuration:  
不难理解，对状态键是否设置默认值必须审慎决策。若处理不当（例如在不适宜的场景下设置默认值），极易引发难以察觉的意外行为。例如，请看如下存在隐患的配置：

![Nested Subgraphs - Default for Key in Inner Subgraph that is Missing in Outer Subgraph ](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_002.jpg)  
![嵌套子图 —— 内层子图中某键设置了默认值，但该键在外层子图中并不存在](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_002.jpg)

Here, Main Graph Node A sets ‘my_key’ to ‘my_data’. This value is later intended to be used by an Inner Subgraph node. But in this example we (purposefully) missed adding that key to the Outer Subgraph. Not surprisingly, the value of this key for the inner subgraph would be an empty string.  
此处，主图节点 A 将 ‘my_key’ 设置为 ‘my_data’。该值后续本应被内层子图（Inner Subgraph）中的某个节点使用。但在本例中，我们（有意地）遗漏了在外部子图（Outer Subgraph）中声明该键。不出所料，该键在内层子图中的取值将为空字符串。

A similar situation would occur on the output side as well: if we updated ‘my_key’ in the Inner Subgraph Node C, then this would not update the ‘my_key’ state in the main graph.  
类似的问题也会出现在输出端：若我们在内层子图节点 C 中更新了 ‘my_key’，该更新**不会**同步至主图中的 ‘my_key’ 状态。

Had we been instead careful and not set a default value for ‘my_key’ in the inner subgraph as shown here:  
倘若我们足够谨慎，在内层子图中**未设置**‘my_key’ 的默认值（如下图所示）：

![Nested Subgraphs - No Default for Key in Inner Subgraph that is Missing in Outer Subgraph ](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_003.jpg)  
![嵌套子图——内层子图中对缺失于外层子图的键未设默认值](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_003.jpg)

then _an error would be raised_, as ‘my_key’ does not have an input value for the Inner Subgraph. Then, the missed state in Outer SubGraph would be added to arrive at the proper configuration:  
那么系统将**抛出错误**，因为 ‘my_key’ 在内层子图中缺少输入值。此时，需补全外层子图中遗漏的状态定义，方可达成正确的配置：

![Nested Subgraphs - With Key in Outer Subgraph ](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_004.jpg)  
![嵌套子图——外层子图中已包含该键](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_004.jpg)

This is of course not really different from traditional nested functions, but in our experience, in the LangGraph context these issues are a bit harder to identify.  
这本质上与传统的嵌套函数并无区别；但根据我们的实践经验，在 LangGraph 上下文中，此类问题往往更难被及时发现。

Our recommendations - no surprise - are to:  
我们的建议（毫不意外）如下：

- define all keys in graph input states _without_ defaults, except for documented exceptions, usually in the context of nested subgraphs  
- 除文档明确说明的例外情形（通常出现在嵌套子图场景中）外，**所有图输入状态中的键均不应设置默认值**；

- define all keys that are updated in the graph as _<type> \| None = None_, … with the exception of when the key is a list and we expect to add to a list from many nodes.  
- 所有在图中会被更新的键，均应声明为 `<type> | None = None` 形式……唯一例外是：当该键为列表（list）类型，且我们预期由多个节点向其追加元素时。

## Graph Components & Considerations  

## 图组件与注意事项  

### Parallelism  

### 并行性

We have a lot of requirements for processes to be executed in parallel, and there are multiple types of parallelism.

我们对并行执行的流程有大量需求，且存在多种类型的并行机制。

#### Parallelism of Identical Flows:

#### 相同流程的并行化：

Map-Reduce Branches  
Map-Reduce 分支  

An example of this type of parallelism in our flow is the validation of retrieved documents, i.e., the testing of each document in the list of retrieved documents for relevance to the question. Obviously, one wants to do these tests in parallel, and LangGraph’s Map-Reduce branches work quite well for us in these situations:

在我们的流程中，此类并行化的一个典型示例是检索文档的验证——即逐一检验检索结果列表中的每篇文档是否与用户问题相关。显然，我们希望这些检验能并行执行；而 LangGraph 的 Map-Reduce 分支机制在此类场景下表现非常出色：

![Fane-Out Parallelization for Document Verification](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_005.jpg)

![面向文档验证的扇出式并行化](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_005.jpg)

Above, the **bold-face state key** is the one being updated during the fan-out, and italic keys refer to fan-out node-internal variables.

上图中，**加粗的 state 键** 是在扇出（fan-out）过程中被更新的键；斜体键则表示扇出节点内部的局部变量。

#### Parallelism of Distinct Flow Segments:

#### 不同流程片段的并行化：

Extensive Usage of _Subgraphs_!  
对 _子图（Subgraphs）_ 的广泛使用！

In the following situation, imagine B\_1 and B\_2 each take 5s to execute, whereas C takes 8s. In the scenario on the left, D starts actually 13s after A has completed, because B\_2 only starts once B1 _and_ C are completed. In the scenario on the right on the other hand, D starts 10s after A completed. Wrapping B\_1 and B\_2 into a subgraph ensures that from the parent graph’s perspective there is one node on the left and one node on the right, and B\_2’s execution is not waiting for C’s completion. (Note: we always use _subgraphs as nodes_ within the parent graph, vs _invoking a subgraph within a node_ of the parent.)

请看如下情形：假设 B\_1 和 B\_2 各需耗时 5 秒，而 C 需耗时 8 秒。在左侧场景中，D 实际上要等到 A 完成后 13 秒才启动，因为 B\_2 必须等待 B\_1 *和* C 均完成之后才能开始；而在右侧场景中，D 则仅需在 A 完成后 10 秒即启动。将 B\_1 和 B\_2 封装为一个子图，可确保从父图视角来看，左右两侧各仅有一个节点；如此一来，B\_2 的执行便不再依赖于 C 的完成。（注意：我们始终将子图作为父图中的 *独立节点* 使用，而非在父图的某个节点内部 *调用子图*。）

![Parallel Subgraphs](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_006.jpg)

![并行子图](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_006.jpg)

### Reusable Components: _Subgraphs_ again!

### 可复用组件：再次聚焦 _子图（Subgraphs）_！

We do have plenty of repeated flow segments that consist of multiple nodes. One example is the Extended Search Retrieval, where documents for a given (sub-)question are retrieved. At the core, the process consists of a Search, followed by a Relevance Validation of each retrieved doc with respect to the question, and concludes with a reranking of the validated documents. To make this repeated process efficient, we wrap it into a subgraph, which is then used either by the main graph or other subgraphs. One needs to be careful, as always, with the definition and sharing of the keys between the parent graph and the subgraph.

我们确实存在大量由多个节点组成的、重复出现的流程片段。一个典型例子是“扩展搜索检索”（Extended Search Retrieval），即针对某一（子）问题检索相关文档。该流程的核心包括三步：首先执行搜索；其次对每篇检索所得文档进行相关性验证（判断其是否与问题相关）；最后对通过验证的文档进行重排序（reranking）。为提升这一重复流程的复用效率，我们将它封装为一个子图，并在主图或其他子图中直接调用。当然，一如往常，我们必须格外谨慎地定义并管理父图与子图之间状态键（keys）的共享方式。

- Node Structure  
- 节点结构  

  - We _generally_ adopt the approach of ‘one-action-per-node’, though one could easily reduce node sprawl by putting more consecutive actions into one node.  
  - 我们**通常**采用“每个节点执行单一操作”的方式；不过，也可通过将多个连续操作合并到一个节点中，来有效减少节点数量的膨胀。  

  - When a subgraph is used at multiple steps in the flow, on occasion we find it convenient to introduce a ‘formatting node’ at the end, whose role it is to convert data into a desired key update.  
  - 当某个子图在流程中被多处调用时，我们有时会在其末尾引入一个“格式化节点”（formatting node），其作用是将数据转换为所需的键值更新（key update）。  

- Streaming  
- 流式处理（Streaming）  

  - In-Node Streaming of Custom Events:  
  - 自定义事件的节点内流式输出：  

    To provide a good user experience we need to stream out a lot of events in-node. Examples include retrieved documents, LLM tokens of generated answers or sub-answers, etc. Many of these are custom events, as we need to distinguish individual sub-answers which could stream out simultaneously. Our application uses synchronous operations, and following LangGraph’s [streaming documentation](https://langchain-ai.github.io/langgraph/how-tos/streaming/?ref=blog.langchain.com#custom) worked very well for us to facilitate the streaming of our custom events.  
    为提供良好的用户体验，我们需要在节点内部流式输出大量事件，例如：检索到的文档、大语言模型（LLM）生成的答案或子答案所对应的 token 等。其中许多属于自定义事件——因为我们需区分可能同时流式输出的各个子答案。我们的应用采用同步操作模式，而遵循 LangGraph 的[流式处理文档](https://langchain-ai.github.io/langgraph/how-tos/streaming/?ref=blog.langchain.com#custom)为我们高效实现了自定义事件的流式传输。  

- LangGraph versions  
- LangGraph 版本  

  - As this is a fast-moving field and a fast-moving project, it is important to stay current on the releases  
  - 鉴于该领域及本项目本身发展迅速，及时跟进 LangGraph 的最新版本发布至关重要。  

# Our Current Agent Search using LangGraph  
# 当前基于 LangGraph 实现的 Agent 搜索系统  

Lastly, here is our current graph (x-ray level set to 1 to limit complexity, so a number of the nodes are actually subgraphs which may contain further subgraphs):  
最后，以下是当前的图结构（x-ray 层级设为 1 以控制复杂度，因此图中不少节点实际为子图，而这些子图内部可能还嵌套更深层的子图）：  

![Onyx Agent Search - LangGraph Graph Structure (with xray of 1 level)](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_007.jpg)  
![Onyx Agent 搜索 — LangGraph 图结构（x-ray 层级为 1）](images/beyond-rag-implementing-agent-search-with-langgraph-for-smarter-knowledge-retrie/img_007.jpg)  

It is quite evident that this flow has a strong resemblance with the logical flow that we laid out at the beginning, with a few additions to facilitate the Basic Search flow if the Agent Search is not selected.  
显而易见，该流程与我们最初设计的逻辑流程高度一致，仅额外增加了若干组件，以便在未启用 Agent 搜索时顺利支持基础搜索（Basic Search）流程。  

# **Outlook and Call To Action**  
# **展望与行动倡议**  

We see this implementation as a first step, and we plan on expanding the flow to become substantially more agentic in the near future. LangGraph certainly has thus far been a good fit for our needs.  
我们将本次实现视为第一步，并计划在近期持续拓展该流程，使其具备更强的自主性（agentic capability）。截至目前，LangGraph 完全契合我们的技术需求。  

We invite you to check out agent-search on [**GitHub**](https://github.com/onyx-dot-app/onyx?ref=blog.langchain.com), [**book a demo**](https://cal.com/yuhongsun/onyx-demo?ref=blog.langchain.com) **,** [**try out our cloud version**](https://cloud.onyx.app/auth/signup?ref=blog.langchain.com) for free, and join [**slack**](https://join.slack.com/t/onyx-dot-app/shared_invite/zt-2twesxdr6-5iQitKZQpgq~hYIZ~dv3KA?ref=blog.langchain.com) **,** [**discord**](https://discord.gg/jDnRGhWhg4?ref=blog.langchain.com) **#agent-search** channels to discuss our Enterprise AI Search more broadly, as well as Agents!  
诚邀您：  
- 在 [**GitHub**](https://github.com/onyx-dot-app/onyx?ref=blog.langchain.com) 上查看 agent-search 项目；  
- [**预约产品演示**](https://cal.com/yuhongsun/onyx-demo?ref=blog.langchain.com)；  
- 免费 [**试用云端版本**](https://cloud.onyx.app/auth/signup?ref=blog.langchain.com)；  
- 加入 [**Slack**](https://join.slack.com/t/onyx-dot-app/shared_invite/zt-2twesxdr6-5iQitKZQpgq~hYIZ~dv3KA?ref=blog.langchain.com) 或 [**Discord #agent-search 频道**](https://discord.gg/jDnRGhWhg4?ref=blog.langchain.com)，就企业级 AI 搜索（Enterprise AI Search）以及智能体（Agents）等话题展开更广泛的交流与探讨！
{% endraw %}
