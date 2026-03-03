---
title: "Benchmarking Multi-Agent Architectures"
source: "LangChain Blog"
url: "https://blog.langchain.com/benchmarking-multi-agent-architectures/"
date: "2025-06-11"
scraped_at: "2026-03-03T07:31:00.881824298+00:00"
language: "en-zh"
translated: true
---

By Will Fu-Hinthorn

作者：Will Fu-Hinthorn

In this blog, we explore a few common multi-agent architectures. We discuss both the motivations and constraints of different architectures. We benchmark their performance on a variant of the Tau-bench dataset. Finally, we discuss improvements we made to our [“supervisor” implementation](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) that yielded a nearly 50% increase in performance on this benchmark.

本文中，我们将探讨几种常见的多智能体（multi-agent）架构，分析各类架构的设计动因与适用约束，并在 Tau-bench 数据集的一个变体上对其性能进行基准测试。最后，我们将介绍对我们的 [“监督器（supervisor）”实现](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) 所做的优化——这些改进使该基准测试的性能提升了近 50%。

# Motivators for multi-agent systems

# 多智能体系统的驱动因素

A few months ago, we [benchmarked how well a single agent architecture](https://blog.langchain.com/react-agent-benchmarking/) scaled with increasing tool count and other context-size. We found a significant decrease in performance with increased context-size, even if that context was irrelevant to the target task. Scaling a system to handle more tools & contexts is one common motivation for multi-agent systems.

几个月前，我们曾[对单智能体架构的可扩展性进行了基准测试](https://blog.langchain.com/react-agent-benchmarking/)，考察其在工具数量增加及上下文规模扩大时的表现。结果发现：即使新增的上下文与目标任务完全无关，系统性能仍随上下文规模增大而显著下降。因此，构建能支持更多工具与更复杂上下文的系统，成为采用多智能体架构的一个常见动因。

Another motivator for multi-agent systems is to follow engineering best practices. Many teams we talk to prefer to design separate agents as they are more modular, which makes them easier to update, evaluate, maintain, and parallelize.

另一项驱动因素在于践行工程最佳实践。我们交流过的许多团队倾向于分别设计多个智能体，因其模块化程度更高，从而更易于更新、评估、维护和并行化处理。

A final motivator for multi-agent systems is that many agents will be developed by different developers and teams. In this case, a naive single agent architecture may not be feasible. If each agent is able to contribute something unique, an effective multi-agent system can achieve more than a given agent in isolation.

最后一个驱动因素是：大量智能体将由不同开发者或不同团队独立开发。在此情形下，简单的单智能体架构往往不可行。若每个智能体都能贡献独特能力，则一个高效的多智能体系统所能达成的效果，将远超任一智能体单独运行时的表现。

For these reasons, we think multi-agent architectures will become more prevalent.

正因上述原因，我们认为多智能体架构将日益普及。

# Generic vs custom architectures

# 通用架构 vs 定制架构

Today, most of the teams building multi-agent architectures do so for vertical-specific applications. The majority of the multi-agent architectures we see today are pretty custom in nature. This is because custom cognitive architectures - when thought through carefully - yield better results for that specific domain than generic ones.

当前，大多数构建多智能体架构的团队均面向垂直领域特定应用。我们目前所见的多智能体架构，绝大多数都具有高度定制化特征。这是因为：经过审慎设计的定制化认知架构，往往能在其对应的具体领域中，取得优于通用架构的效果。

Still, generic multi-agent architectures are interesting for a few reasons.

不过，通用型多智能体架构仍具若干研究价值与实践意义。

**Ease of getting started.**  
**上手简单。**  
Generic multi-agent architectures make it easier to get started with multi-agent systems.  
通用多智能体架构使开发者更容易入门多智能体系统。  
A simple agent architecture where all communication is done via “tool-calling” is often less _performant_ than an application-specific workflow, but it’s much easier to use as a starting point.  
一种所有通信均通过“工具调用”（tool-calling）完成的简易智能体架构，其性能通常不如面向特定应用的工作流，但作为起点却要容易得多。

**“Bring your own agents”**.  
**“自带智能体”（Bring Your Own Agents）。**  
If you are building a general-purpose agent, you may want others to “bring your own agent”.  
如果你正在构建一个通用型智能体，你可能希望其他用户能“自带智能体”。  
Connecting to these would require a pretty generic architecture.  
与这些外部智能体对接，就需要一个高度通用的架构。  
We’ve seen this pattern play out with connections to standard APIs through MCP (”bring your own tool”).  
我们已在通过 MCP（Model Context Protocol，“自带工具”协议）连接标准 API 的实践中观察到这一模式。  
The way that clients (Claude, Cursor, etc) use MCP tools is generic.  
客户端（如 Claude、Cursor 等）调用 MCP 工具的方式本身就是通用化的。  
We imagine a similar thing happening with agents.  
我们设想，类似的情形也将出现在智能体之间的互操作中。

So – what is the best generic multi-agent architecture?  
那么——目前最优的通用多智能体架构是什么？

## Data  
## 数据  

We ran experiments over a modified version of **τ-bench, by Yao, et. al.** ( [link](https://arxiv.org/abs/2406.12045?ref=blog.langchain.com)).  
我们在 Yao 等人提出的 **τ-bench**（[链接](https://arxiv.org/abs/2406.12045?ref=blog.langchain.com)）的一个改进版本上开展了实验。  
τ-bench was designed to test different _single-agent_ cognitive architectures / prompting strategies on real-world scenarios (such as retail customer support, flight booking, etc.).  
τ-bench 原本旨在测试各类 _单智能体_ 认知架构或提示策略在真实场景（如零售客服、航班预订等）中的表现。  
Our modified version of the dataset and experiment code can be found in the [multi-agent bench repo here](https://github.com/hinthornw/mabench?ref=blog.langchain.com).  
我们修改后的数据集及实验代码已开源，详见 [multi-agent bench 仓库](https://github.com/hinthornw/mabench?ref=blog.langchain.com)。

To more effectively test how multi-agent systems scale to handle more complicated domains, we added 6 additional environments to the dataset: home improvement, tech support, pharmacy, automotive, restaurant, and Spotify playlist management.  
为更有效地评估多智能体系统在应对更复杂领域时的可扩展性，我们在数据集中新增了 6 个模拟环境：家居装修、技术支持、药房服务、汽车维修、餐厅服务以及 Spotify 歌单管理。  
Each environment had a corresponding 19 distinct tools to facilitate interactions over the respective domain as well as a “wiki” containing instructions related to the domain.  
每个环境均配备 19 个专属工具，用于支撑该领域的交互任务；同时还提供一份“知识库”（wiki），内含与该领域相关的操作说明。  
None of these synthetic domains are required (or useful) for the completion of any of the tasks in the original dataset.  
这些人工构造的领域对原始数据集中任一任务的完成既非必需，也无实际帮助。  
These environments were designed purely as realistic “distractors”, testing how well each agent setup could perform when other (unrelated) tools and instruction sets are provided “just in case”.  
这些环境被设计为逼真的“干扰项”，用于检验各智能体架构在额外提供（且无关的）工具与指令集时，能否依然稳健地完成任务——即所谓“以防万一”的配置场景。

We ran experiments over the first 100 examples from **τ-bench’s** retail domain’s test split, providing increasing number of distractor environments to the agent to show how each system balances the additional context.  
我们在 **τ-bench** 零售领域测试集的前 100 个样本上运行实验，并逐步向智能体注入更多干扰环境，以考察各系统如何权衡额外上下文带来的影响。  
This tests the “best-case performance” for how common agent systems can scale.  
该设置用于评估主流智能体系统可扩展性的“理想性能上限”。  
We call this “best-case” since the auxiliary domains are not required to successfully complete each task.  
我们将之称为“理想情况”，是因为这些辅助领域对任一任务的成功完成均非必要。  
Very little coordination is required in practice to pass a test case, apart from filtering out irrelevant tools and instructions from the total set of actions the system could theoretically take.  
实践中，要通过一个测试用例仅需极少协调工作——主要就是从系统理论上可执行的所有动作中，过滤掉无关的工具与指令。

# Experiments  
# 实验  

We experimented with three different architectures. We used `gpt-4o` as the model for all these experiments.  
我们尝试了三种不同的架构。所有实验均采用 `gpt-4o` 作为基础大语言模型。

Note: depending on your application’s constraints, some of these architectures may be infeasible.  
注意：根据你的应用场景约束条件，其中某些架构可能并不可行。  
We always recommend starting from your goals (definitions of success) and constraints when picking a design pattern.  
我们始终建议：在选择架构模式时，应首先明确你的目标（即成功的定义）和实际约束条件。

**Single Agent**

**单智能体**

This is a tool-calling agent with a single prompt and access to tools and instructions from all domains. This is the baseline upon which we want to improve.

这是一个支持工具调用的单智能体，仅依赖一个提示词（prompt），并能访问所有领域内的工具与指令。这是我们希望在此基础上持续优化的基准方案。

For the implementation we used the LangGraph `create_react_agent` implementation.

在实现上，我们采用了 LangGraph 的 `create_react_agent` 实现。

Note: this architecture may not feasible in all cases. For example, if you want one of the sub-domains to be handled by a third-party agent, you by definition cannot have a single agent.

注意：该架构并非在所有场景下都可行。例如，若你希望某个子领域由第三方智能体处理，则从定义上就无法采用单一智能体架构。

**Swarm**

**蜂群式架构（Swarm）**

In this architecture, each sub-agent is aware of and can hand-off any other agent in the group (or swarm). If an agent responds, that is sent directly to the user. When an agent is active, it will remain active until it hands off to a different agent. Only one agent can be active at any given time.

在此架构中，每个子智能体均知晓组内（即“蜂群”中）其他所有智能体，并可将任务交接给其中任意一个。若某智能体生成响应，则该响应将直接返回给用户；当某智能体处于活跃状态时，它将持续保持活跃，直至主动将控制权移交至另一智能体。任意时刻，仅允许一个智能体处于活跃状态。

For the implementation we used the LangGraph `langgraph-swarm` package.

在实现上，我们使用了 LangGraph 的 `langgraph-swarm` 包。

Note: this architecture may not feasible in all cases. This requires each sub-agent knowing all other agents in the architecture. If you are working with third-party agents, this likely will not be the case. You also likely won’t want third-party agents to remain “active” when interacting with your user.

注意：该架构也并非适用于所有场景。它要求每个子智能体必须知晓整个架构中的全部其他智能体。若你正在集成第三方智能体，这一前提通常难以满足；此外，你通常也不希望第三方智能体在与你的用户交互时长期处于“活跃”状态。

**Supervisor**

**主管式架构（Supervisor）**

In this architecture, a single “supervisor” agent receives user input and delegates work to sub-agents. When the sub-agent responds, control is handed back to the supervisor agent. Only the supervisor agent can respond to the user.

在此架构中，一个统一的“主管”智能体负责接收用户输入，并将任务分派给各子智能体；当子智能体完成响应后，控制权即交还给主管智能体；最终，仅主管智能体有权向用户输出响应。

For the implementation we used the LangGraph `langgraph-supervisor` package.

在实现中，我们使用了 LangGraph 的 `langgraph-supervisor` 包。

Note: this architecture places very little assumptions on the sub agents, and so should be feasible for all multi-agent scenarios.

注意：该架构对子智能体（sub agents）的假设极少，因此应适用于所有多智能体场景。

# Results & Analysis

# 结果与分析

We show results across two dimensions:

我们从以下两个维度展示实验结果：

- Score: as measured by XYZ, which Tau Bench uses  
- 得分（Score）：由 Tau Bench 所采用的 XYZ 指标衡量  

- Cost (Tokens): number of tokens used for each experiment  
- 成本（Token 数量）：每次实验所消耗的 token 总数  

## Score

## 得分

![](images/benchmarking-multi-agent-architectures/img_001.png)

We see that the single agent baseline falls off sharply when there are two or more distractor domains. When there is only a single distractor domain the single agent performs slightly better.

我们观察到，当存在两个或更多干扰领域（distractor domains）时，单智能体基线模型的性能急剧下降；而仅存在一个干扰领域时，单智能体的表现略优。

We see that the swarm architecture slightly outperforms supervisor architecture across the board. Looking at the data, the drop in performance arises due to the “translation” the supervisor is doing. This occurs because the sub agents cannot respond to the user directly in the supervisor architecture, while in the swarm architecture they can. If you’ve ever played a game of “telephone”, you’re already familiar with this problem!

我们发现，群体架构（swarm architecture）在各项指标上均略微优于监督者架构（supervisor architecture）。从数据来看，性能下降源于监督者所进行的“转译”（translation）过程。这是因为在监督者架构中，子智能体无法直接响应用户，而必须经由监督者中转；而在群体架构中，子智能体可直接与用户交互。如果你曾玩过“传话游戏”（telephone），便已十分熟悉此类问题！  

## Cost (Tokens)

## 成本（Token 数量）

![](images/benchmarking-multi-agent-architectures/img_002.png)

![](images/benchmarking-multi-agent-architectures/img_002.png)

We see that the single agent uses consistently more tokens as the number of distractor domains grows, while supervisor and swarm remain flat.

我们观察到，随着干扰领域（distractor domains）数量的增加，单智能体（single agent）所使用的 token 数量持续上升，而监督者架构（supervisor）和蜂群架构（swarm）则基本保持平稳。

We can see that supervisor consistently uses more tokens than swarm. This is once again due to the “translation” that the supervisor does. This occurs because the sub agents cannot respond to the user directly in the supervisor architecture, while in the swarm architecture they can.

可以看出，监督者架构始终比蜂群架构消耗更多 token。这再次归因于监督者所执行的“翻译”过程。其原因在于：在监督者架构中，子智能体（sub agents）无法直接向用户响应；而在蜂群架构中，子智能体则可以直接响应用户。

# Improvements to supervisor

# 对监督者架构的改进

When we initially tested the supervisor approach it performed quite poorly. It was only after a few changes that it started to perform better.

我们最初测试监督者方法时，其表现相当差；直到经过若干调整后，性能才开始明显提升。

Here is a chart with the old supervisor implementation included:

以下图表包含了旧版监督者实现的对比结果：

![](images/benchmarking-multi-agent-architectures/img_003.png)

![](images/benchmarking-multi-agent-architectures/img_003.png)

Most of the performance issues for the supervisor architecture came from the “translation” occurring when the supervisor agent had to play telephone between the sub agents and the user. Most of the changes we made to bridge the gap were designed to remove the impact of that game of telephone.

监督者架构的大部分性能问题源于监督者智能体在子智能体与用户之间充当“传话筒”（即“打电话游戏”，telephone game）时所产生的“翻译”开销。我们为缩小性能差距所作的多数改进，均旨在消除这一“传话筒”效应的影响。

Note: all of these changes are included as options in the newest version of `langgraph_supervisor`.

注意：上述所有改进均已作为可选配置集成至最新版 `langgraph_supervisor` 中。

**Removing handoff messages**

**移除交接消息（handoff messages）**

Remove the handoff messages from the sub-agent’s state so the assigned agent doesn’t have to view the supervisor’s routing logic. This de-clutters the sub-agent’s context window and lets it perform it’s task better. Even with recent models, clutter in the context can have outsized impacts on agent reliability.

从子代理（sub-agent）的状态中移除交接消息，使被指派的代理无需查看主管代理（supervisor）的路由逻辑。此举可简化子代理的上下文窗口，使其更高效地执行任务。即使使用最新的大语言模型，上下文中的冗余信息仍会对代理的可靠性产生不成比例的显著影响。

**Forwarding messages**

**消息转发**

Give the supervisor access to a `forward_message` tool. This tool lets it “forward” the sub agent’s response directly to the user without re-generating the full content. This reduced errors caused by the supervisor agent paraphrasing the sub agent incorrectly.

为主管代理提供一个 `forward_message` 工具。该工具允许主管代理将子代理的响应“直接转发”给用户，而无需重新生成全部内容。这可减少因主管代理错误转述子代理响应所导致的错误。

**Tool naming**

**工具命名**

Test different framings for the tool name that the supervisor agent would call to handoff to a sub agent (”delegate\_to\_<agent>” vs “transfer\_to\_<agent>”)

测试主管代理在将任务交接给子代理时所调用工具的不同命名方式（例如：“delegate\_to\_<agent>” 与 “transfer\_to\_<agent>”）。

# Future work

# 未来工作

There are several next steps we would like to explore.

我们计划探索若干后续方向。

**Multi-hop across agents**

**跨代理多跳协作**

Right now, all questions only require a single sub agent to respond. We would like to explore performance on questions that require multiple sub agents.

目前，所有问题仅需单个子代理响应即可解决。我们希望进一步探索那些需要多个子代理协同完成的复杂问题的处理性能。

**Matching single agent performance**

**对齐单代理性能**

（注：此标题未提供英文正文，故中文翻译保持简洁对应）

Why don’t swarm and supervisor perform as well as single agent when there is a single distractor domain? Most of the main errors were due to “translation” mistakes and degraded performance with additional context (from the handoffs). We managed to reduce them somewhat, but performance still lags behind single agent. What can be done to increase performance to that level?

当仅存在一个干扰域（distractor domain）时，为何 swarm 和 supervisor 的表现不如单智能体？主要错误大多源于“翻译”环节的失误，以及因交接（handoffs）引入额外上下文而导致的性能下降。我们已设法在一定程度上减少了此类错误，但整体性能仍落后于单智能体。那么，有哪些方法可将性能提升至单智能体水平？

**Skipping the “translation” layer**

**跳过“翻译”层**

Most of the mistakes of supervisor happen because of the “translation” layer, where only the supervisor agent is allowed to respond to the user. Is there some way to skip this translation layer more effectively, while still properly delegating work and ensuring responses are made with the full task context?

监督器（supervisor）的多数错误均源于“翻译”层——在此层中，仅允许监督器智能体向用户作出响应。是否存在一种更高效地绕过该翻译层的方法，同时仍能合理分配任务，并确保响应始终基于完整的任务上下文生成？

**Other architectures**

**其他架构**

Are the other architectures out there that may yield better results? How does this compare to “agents-as-tools”?

是否存在其他可能带来更优效果的架构？与“智能体即工具”（agents-as-tools）范式相比，当前方案表现如何？

# Conclusion

# 结论

We think multi-agent systems will become more prevalent. While most successful multi-agent systems today have a relatively custom architecture, we think that as models improve, generic architectures will become sufficiently reliable for their benefits of ease of development outweigh their performance weaknesses. The `supervisor` architecture is the most generic one (in that it makes the fewest assumptions about the underlying agents), but a naive implementation of the supervisor architecture may have worse results. Using improvements in how information is passed between sub-agents and the user (and in how context is managed) can help the system perform better while retaining an ability to scale across many domains. You can use the ones we’ve made available in the [`langgraph-supervisor`](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) and evaluate your system on your data using a tool like [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com).

我们认为多智能体系统将日益普及。尽管当前大多数成功的多智能体系统采用相对定制化的架构，但我们相信，随着大模型能力持续提升，通用型架构将变得足够可靠——其开发便捷性优势将显著超越性能上的固有短板。`supervisor` 架构是其中通用性最强的一种（因其对底层智能体所作假设最少），但若采用朴素实现方式，其效果反而可能更差。通过优化子智能体与用户之间的信息传递机制（以及上下文管理方式），可在保持跨多领域可扩展性的同时，显著提升系统整体性能。您可直接使用我们开源的 [`langgraph-supervisor`](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com)，并借助 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 等工具，在您自己的数据集上评估系统表现。

If you want to try out the supervisor architecture easily (including all the improvements we made as a result of this research) you can easily do so with [`langgraph-supervisor`](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com).

若您希望便捷地尝试 `supervisor` 架构（包括本研究中所实现的全部改进），只需使用 [`langgraph-supervisor`](https://github.com/langchain-ai/langgraph-supervisor-py?ref=blog.langchain.com) 即可快速上手。