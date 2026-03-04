---
title: "Choosing the Right Multi-Agent Architecture"
source: "LangChain Blog"
url: "https://blog.langchain.com/choosing-the-right-multi-agent-architecture/"
date: "2026-01-14"
scraped_at: "2026-03-03T07:14:42.785562031+00:00"
language: "en-zh"
translated: true
description: "In this post, we’ll explore when multi-agent architectures become necessary, the four main patterns we’ve observed, and how LangChain empowers you to effectively build multi-agent systems."
---
{% raw %}

By Sydney Runkle

作者：悉尼·伦克尔（Sydney Runkle）

Many agentic tasks are best handled by a single agent with well-designed tools. You should start here—single agents are simpler to build, reason about, and debug. But as applications scale, teams face a common challenge wherein they have sprawling agent capabilities they want to combine into a single coherent interface. As the features they want to combine grow in number, two main constraints emerge:

许多智能体（agent）任务最适合由一个配备精心设计工具的单一智能体来处理。您应从此处入手——单智能体系统更易于构建、推理和调试。但随着应用规模扩大，团队常面临一个共性挑战：他们拥有大量分散的智能体能力，希望将其整合为统一、连贯的接口。当待整合的功能数量持续增加时，两大主要约束随之浮现：

**Context management**: Specialized knowledge for each capability doesn't fit comfortably in a single prompt. If context windows were infinite and latency was zero, you could include all relevant information upfront. In practice, you need strategies to selectively surface information as agents work.

**上下文管理（Context Management）**：每项能力所需的专门知识无法舒适地容纳于单个提示（prompt）之中。倘若上下文窗口无限大且延迟为零，您便可在初始阶段就纳入所有相关信息。但在实践中，您需要制定策略，在智能体协作过程中有选择性地呈现必要信息。

**Distributed development**: Different teams develop and maintain each capability independently, with clear boundaries and ownership. A single monolithic agent prompt becomes difficult to manage across team boundaries.

**分布式开发（Distributed Development）**：不同团队各自独立开发与维护各项能力，职责边界清晰、权责明确。此时，一个庞大的、一体化的智能体提示（prompt）将难以跨越团队边界进行协同管理。

These constraints become critical when you're managing extensive domain knowledge, coordinating across teams, or tackling genuinely complex tasks. In these cases, multi-agent architectures _can_ become the right choice.

当您需要管理海量领域知识、跨团队协同，或应对真正复杂的任务时，上述约束将变得尤为关键。在此类场景下，多智能体（multi-agent）架构 *可能* 成为更优选择。

Recent [research](https://www.anthropic.com/engineering/multi-agent-research-system?ref=blog.langchain.com) demonstrates how multi-agent systems perform better in these situations. In Anthropic’s multi-agent research system, a multi-agent architecture with Claude Opus 4 as the lead agent and Claude Sonnet 4 subagents outperformed single-agent Claude Opus 4 by 90.2% on internal research evaluations. The architecture’s ability to distribute work across agents with separate context windows enabled parallel reasoning that a single agent couldn’t achieve.

近期一项[研究](https://www.anthropic.com/engineering/multi-agent-research-system?ref=blog.langchain.com)表明，多智能体系统在上述场景中表现更优。在 Anthropic 的多智能体研究系统中，以 Claude Opus 4 作为主智能体、Claude Sonnet 4 作为子智能体的多智能体架构，在内部研究评估中相较单智能体 Claude Opus 4 提升了 90.2%。该架构通过将工作分发至具备独立上下文窗口的多个智能体，实现了并行推理——这是单智能体所无法达成的能力。

## Multi-Agent Architectures

## 多智能体架构

Four architectural patterns form the foundation of most multi-agent applications: subagents, skills, handoffs, and routers. Each takes a different approach to task coordination, state management, and sequential unlocking. Below we outline a framework for selecting an architecture that best addresses your most critical constraints.

构成大多数多智能体应用基础的四大架构模式为：子智能体（subagents）、技能（skills）、交接（handoffs）与路由（routers）。它们在任务协调、状态管理及顺序解锁（sequential unlocking）等方面各具特色。下文我们将梳理一套选型框架，助您选出最契合自身核心约束的架构方案。

### Subagents: Centralized orchestration

### 子智能体：集中式编排

In the subagents pattern, a supervisor agent coordinates specialized subagents by calling them as tools. The main agent maintains conversation context while subagents remain stateless, providing strong context isolation.

在子智能体模式中，一个主管智能体（supervisor agent）通过将专业化子智能体调用为工具的方式实现协调。主智能体负责维护对话上下文，而各子智能体则保持无状态（stateless），从而提供强有力的上下文隔离能力。

**How it works**: The main agent decides which subagents to invoke, what input to provide, and how to combine results. Subagents don’t remember past interactions. This architecture provides centralized control where all routing passes through the main agent, which can invoke multiple subagents in parallel.

**工作原理**：主智能体（main agent）决定调用哪些子智能体（subagents）、提供何种输入，以及如何整合结果。子智能体不保留过往交互的记忆。该架构实现了集中式控制——所有路由均经由主智能体完成，且主智能体可并行调用多个子智能体。

**Best for**: Applications with multiple distinct domains where you need centralized workflow control and subagents don’t need to converse directly with users. Examples include personal assistants that coordinate calendar, email, and CRM operations, or research systems that delegate to specialized domain experts.

**适用场景**：适用于拥有多个明确独立领域（domains）的应用，尤其当你需要集中式工作流控制，且子智能体无需直接与用户对话时。典型示例包括协调日历、邮件和客户关系管理（CRM）操作的个人助理，或向特定领域专家（如数学、法律、生物等）委派任务的研究系统。

**Key tradeoff**: Adds one extra model call per interaction because results must flow back through the main agent. This overhead provides centralized control and context isolation, but costs latency and tokens.

**关键权衡**：每次交互需额外增加一次大模型调用（因结果必须回传至主智能体）。这一开销带来了集中式控制与上下文隔离能力，但同时也增加了延迟和 token 消耗。

![](images/choosing-the-right-multi-agent-architecture/img_001.png)

For developers who want this pattern with minimal setup, [Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) provides an out-of-the-box implementation for adding subagents with just a few lines of code.

对于希望以极简配置实现该模式的开发者，[Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 提供了开箱即用的实现方案——仅需数行代码即可集成子智能体。

[Learn more: Subagents documentation](https://docs.langchain.com/oss/python/langchain/multi-agent/subagents?ref=blog.langchain.com) \| [Tutorial: Build a personal assistant with subagents](https://docs.langchain.com/oss/python/langchain/multi-agent/subagents-personal-assistant?ref=blog.langchain.com)

[了解更多：子智能体文档](https://docs.langchain.com/oss/python/langchain/multi-agent/subagents?ref=blog.langchain.com) \| [教程：使用子智能体构建个人助理](https://docs.langchain.com/oss/python/langchain/multi-agent/subagents-personal-assistant?ref=blog.langchain.com)

### Skills: Progressive disclosure

### 技能：渐进式披露（Progressive Disclosure）

In the skills pattern, an agent loads specialized prompts and knowledge on-demand. Think of it as progressive disclosure for agent capabilities.

在“技能”模式中，智能体按需加载专用提示词（prompts）与知识。可将其类比为面向智能体能力的“渐进式披露”——即仅在必要时才揭示更深层的功能细节。

While the skills architecture technically uses a single agent, it shares characteristics with multi-agent systems by enabling that agent to dynamically adopt specialized personas. This approach provides similar benefits to multi-agent patterns—like distributed development and fine-grained context control—but through a lighter-weight, prompt-driven method rather than managing multiple agent instances. So, perhaps controversially, we consider skills to be a quasi-multi-agent architecture.

尽管从技术上讲，“技能”架构仅使用单个智能体，但它通过使该智能体能够动态切换为不同专业角色（specialized personas），展现出与多智能体系统相似的特性。该方法同样支持分布式开发与细粒度上下文控制等优势，但实现方式更轻量——依托提示词驱动，而非维护多个智能体实例。因此，我们（或许略带争议地）将“技能”视为一种准多智能体（quasi-multi-agent）架构。

**How it works**: Skills are primarily prompt-driven specializations packaged as directories containing instructions, scripts, and resources. At startup, the agent knows only skill names and descriptions. When a skill becomes relevant, the agent loads its full context. Additional files within skills provide a third level of detail that the agent discovers only as needed.

**工作原理**：“技能”本质上是基于提示词驱动的专业化功能模块，以目录形式封装，内含指令、脚本及各类资源。启动时，智能体仅知晓各技能的名称与简要描述；当某项技能被触发时，智能体才加载其完整上下文。此外，技能目录中还可包含更多辅助文件，构成第三层级的细节信息——这些内容仅在智能体实际需要时才被发现与加载。

**Best for**: Single agents with many possible specializations, situations where you don’t need to enforce constraints between capabilities, or team distribution where different teams maintain different skills. Common examples include coding agents or creative assistants.

**适用场景**：适用于具备多种潜在专业能力的单体智能体；无需在各项能力之间强制施加约束的场景；或团队分工明确、不同团队分别维护不同技能的组织架构。典型用例包括编程智能体（coding agents）和创意助手（creative assistants）。

**Key tradeoff**: Context accumulates in conversation history as skills are loaded, which can lead to token bloat on subsequent calls. However, the pattern provides simplicity and direct user interaction throughout.

**关键权衡**：随着技能被动态加载，对话历史中的上下文持续累积，可能导致后续调用时出现 token 膨胀（token bloat）。但该模式全程保持结构简洁，并支持用户与智能体直接交互。

![](images/choosing-the-right-multi-agent-architecture/img_002.png)

[Learn more: Skills documentation](https://docs.langchain.com/oss/python/langchain/multi-agent/skills?ref=blog.langchain.com) \| [Tutorial: Build a SQL assistant with on-demand skills](https://docs.langchain.com/oss/python/langchain/multi-agent/skills-sql-assistant?ref=blog.langchain.com)

[了解更多：Skills 文档](https://docs.langchain.com/oss/python/langchain/multi-agent/skills?ref=blog.langchain.com) \| [教程：使用按需技能构建 SQL 助手](https://docs.langchain.com/oss/python/langchain/multi-agent/skills-sql-assistant?ref=blog.langchain.com)

### Handoffs: State-driven transitions

### 交接式模式：基于状态的智能体切换

In the handoffs pattern, the active agent changes dynamically based on conversation context. Each agent has the ability to transfer to others via tool calling.

在交接式模式中，当前活跃的智能体根据对话上下文动态切换。每个智能体均可通过调用工具将控制权移交至其他智能体。

**How it works**: When an agent calls a handoff tool, it updates state that determines the next agent to activate. This can mean switching to a different agent or changing the current agent’s system prompt and available tools. The state survives across conversation turns, enabling sequential workflows.

**工作原理**：当某智能体调用交接工具（handoff tool）时，它会更新系统状态，从而决定下一个被激活的智能体。这种切换既可能表现为切换至另一个智能体，也可能体现为更新当前智能体的系统提示词（system prompt）及其可用工具集。该状态在多轮对话中持续保留，从而支撑顺序化的工作流。

**Best for**: Customer support flows that collect information in stages, multi-stage conversational experiences, or any scenario requiring sequential constraints where capabilities unlock only after preconditions are met.

**适用场景**：分阶段收集用户信息的客服流程、多阶段交互式对话体验，或任何需要严格顺序约束的场景——即某些能力仅在前置条件满足后才可启用。

**Key tradeoff**: More stateful than other patterns, requiring careful state management. However, this enables fluid multi-turn conversations where context carries forward naturally between stages.

**关键权衡**：相比其他模式，该模式具有更强的状态依赖性，因而要求更精细的状态管理。但正因如此，它能支撑自然流畅的多轮对话，使上下文在各阶段间无缝延续。

![](images/choosing-the-right-multi-agent-architecture/img_003.png)

[Learn more: Handoffs documentation](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs?ref=blog.langchain.com) \| [Tutorial: Build customer support with handoffs](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs-customer-support?ref=blog.langchain.com)

[了解更多：交接（Handoffs）文档](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs?ref=blog.langchain.com) \| [教程：使用交接机制构建客户支持系统](https://docs.langchain.com/oss/python/langchain/multi-agent/handoffs-customer-support?ref=blog.langchain.com)

### Router: Parallel dispatch and synthesis

### 路由器：并行分发与结果合成

In the router pattern, a routing step classifies input and directs it to specialized agents, executing queries in parallel and synthesizing results.

在路由器模式中，一个路由步骤对输入进行分类，并将其分发至专用智能体（specialized agents），并行执行查询，再将结果进行合成。

**How it works**: The router decomposes the query, invokes zero or more specialized agents in parallel, and synthesizes results into a coherent response. Routers are typically stateless, handling each request independently.

**工作原理**：路由器将查询分解，然后并行调用零个或多个专用智能体，并将返回结果合成为连贯的响应。路由器通常是无状态的，每个请求均独立处理。

**Best for**: Applications with distinct verticals (separate knowledge domains), scenarios requiring queries across multiple sources in parallel, or situations where you need to synthesize results from multiple agents. Examples include enterprise knowledge bases and multi-vertical customer support assistants.

**适用场景**：具有明确垂直领域划分（即彼此独立的知识领域）的应用；需同时向多个数据源发起查询的场景；或需要整合多个智能体输出结果的情形。典型示例包括企业级知识库和面向多业务线的客户支持助手。

**Key tradeoff**: Stateless design means consistent performance per request, but repeated routing overhead if you need conversation history. Can be mitigated by wrapping the router as a tool within a stateful conversational agent.

**关键权衡**：无状态设计可确保每次请求性能稳定，但若需维护对话历史，则会重复产生路由开销。该问题可通过将路由器封装为工具，并集成到有状态的对话智能体中加以缓解。

![](images/choosing-the-right-multi-agent-architecture/img_004.png)

![](images/choosing-the-right-multi-agent-architecture/img_004.png)

[Learn more: Router documentation](https://docs.langchain.com/oss/python/langchain/multi-agent/router?ref=blog.langchain.com) \| [Tutorial: Build a multi-source knowledge base with routing](https://docs.langchain.com/oss/python/langchain/multi-agent/router-knowledge-base?ref=blog.langchain.com)

[了解更多：路由器（Router）文档](https://docs.langchain.com/oss/python/langchain/multi-agent/router?ref=blog.langchain.com) \| [教程：使用路由机制构建多源知识库](https://docs.langchain.com/oss/python/langchain/multi-agent/router-knowledge-base?ref=blog.langchain.com)

## Matching requirements to patterns

## 将需求匹配至对应模式

Before implementing a multi-agent system, consider whether your requirements align with one of these four patterns:

在实现多智能体系统之前，请先评估您的具体需求是否契合以下四种模式之一：

| Your requirements | Pattern |
| --- | --- |
| Multiple distinct domains (calendar, email, CRM), need parallel execution | **Subagents** |
| 单一智能体，具备多种可能的专业能力，需轻量级组合 | **Skills** |
| 顺序工作流，涉及状态转换，智能体全程与用户对话交互 | **Handoffs** |
| 各自独立的垂直领域，需并行查询多个数据源并综合结果 | **Router** |

The [table below](https://docs.langchain.com/oss/python/langchain/multi-agent?ref=blog.langchain.com#choosing-a-pattern) shows how each pattern supports common multi-agent requirements:

以下[表格](https://docs.langchain.com/oss/python/langchain/multi-agent?ref=blog.langchain.com#choosing-a-pattern)展示了每种模式对常见多智能体需求的支持程度：

| Pattern | Distributed development | Parallelization | Multi-hop | Direct user interaction |
| --- | --- | --- | --- | --- |
| Subagents | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐ |
| Skills | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Handoffs | — | — | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Router | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | — | ⭐⭐⭐ |

| 模式 | 分布式开发 | 并行化 | 多跳调用 | 直接用户交互 |
| --- | --- | --- | --- | --- |
| Subagents | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐ |
| Skills | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Handoffs | — | — | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Router | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | — | ⭐⭐⭐ |

- **Distributed development**: Can different teams maintain components independently?  
- **分布式开发**：不同团队能否独立维护各组件？

- **Parallelization**: Can multiple agents execute concurrently?  
- **并行化**：多个智能体能否并发执行？

- **Multi-hop**: Does the pattern support calling multiple subagents in series?  
- **多跳调用**：该模式是否支持按顺序调用多个子智能体？

- **Direct user interaction**: Can subagents converse directly with the user?  
- **直接用户交互**：子智能体能否直接与用户对话？

## Performance characteristics

## 性能特征

Architecture choice directly impacts latency, cost, and user experience. We analyzed three representative scenarios to understand how different patterns perform under real-world conditions.

架构选择直接影响延迟、成本和用户体验。我们分析了三个典型场景，以了解不同模式在真实世界条件下的实际表现。

Note, you can find the full performance breakdown (with mermaid diagrams for each architecture) in our new [multi-agent performance docs](https://docs.langchain.com/oss/python/langchain/multi-agent?ref=blog.langchain.com#performance-comparison).

注意：您可在我们的新版[多智能体性能文档](https://docs.langchain.com/oss/python/langchain/multi-agent?ref=blog.langchain.com#performance-comparison)中查阅完整的性能分析（含每种架构对应的 Mermaid 图表）。

### Scenario 1: One-shot request

### 场景 1：一次性请求

A user makes a single request: “buy coffee.” A specialized agent can call a `buy_coffee` tool.

用户发起单次请求：“买一杯咖啡。”一个专业化的智能体可调用 `buy_coffee` 工具。

| Pattern | Model calls | Notes |
| --- | --- | --- |
| Subagents | 4 | Results flow back through main agent |
| Skills | 3 | Direct execution |
| Handoffs | 3 | Direct execution |
| Router | 3 | Direct execution |

| 模式 | 模型调用次数 | 说明 |
| --- | --- | --- |
| Subagents | 4 | 结果经由主智能体返回 |
| Skills | 3 | 直接执行 |
| Handoffs | 3 | 直接执行 |
| Router | 3 | 直接执行 |

**Key insight:** Handoffs, Skills, and Router are most efficient for single tasks (3 calls each). Subagents adds one extra call because results flow back through the main agent. This overhead provides centralized control, as seen below.

**关键洞察：** Handoffs（任务交接）、Skills（技能调用）和 Router（路由分发）在处理单个任务时效率最高（各需 3 次调用）。Subagents（子智能体）则多出 1 次调用，因为结果需经主智能体返回。这一额外开销带来了集中式控制能力，如下图所示。

![](images/choosing-the-right-multi-agent-architecture/img_005.png)

### Scenario 2: Repeat request

### 场景 2：重复请求

The user makes the same request twice in conversation:

用户在对话中两次提出相同请求：

- **Turn 1**: “buy coffee”  
- **Turn 1**: “买一杯咖啡”  
- **Turn 2**: “buy coffee again”  
- **Turn 2**: “再买一杯咖啡”

| Pattern | Turn 2 calls | Total calls | Efficiency gain |
| --- | --- | --- | --- |
| Subagents | 4 | 8 | — |
| Skills | 2 | 5 | 40% |
| Handoffs | 2 | 5 | 40% |
| Router | 3 | 6 | 25% |

| 模式 | 第 2 轮调用次数 | 总调用次数 | 效率提升 |
| --- | --- | --- | --- |
| Subagents（子智能体） | 4 | 8 | — |
| Skills（技能调用） | 2 | 5 | 40% |
| Handoffs（任务交接） | 2 | 5 | 40% |
| Router（路由分发） | 3 | 6 | 25% |

**Key insight**: Stateful patterns (Handoffs, Skills) save 40-50% of calls on repeat requests by maintaining context. Subagents maintain consistent cost per request through stateless design, providing strong context isolation at the cost of repeated model calls.

**关键洞察：** 具有状态记忆能力的模式（Handoffs、Skills）通过维持上下文，在重复请求中可节省 40–50% 的调用次数。而 Subagents 采用无状态设计，确保每次请求成本恒定，虽牺牲了上下文复用带来的调用节省，却实现了更强的上下文隔离性。

![](images/choosing-the-right-multi-agent-architecture/img_006.png)

### Scenario 3: Multi-domain query

### 场景 3：跨领域查询

A user asks: “Compare Python, JavaScript, and Rust for web development.” Each language agent contains approximately 2000 tokens of documentation. All patterns can make parallel tool calls.

用户提问：“请对比 Python、JavaScript 和 Rust 在 Web 开发中的适用性。” 每个语言专属智能体均内置约 2000 个 token 的文档资料。所有架构模式均支持并行工具调用。

| Pattern | Model calls | Total tokens | Notes |
| --- | --- | --- | --- |
| Subagents | 5 | ~9K | Each subagent works in isolation |
| 子智能体（Subagents） | 5 | 约 9,000 | 每个子智能体独立运行 |

| Skills | 3 | ~15K | Context accumulation |
| 技能模式（Skills） | 3 | 约 15,000 | 上下文持续累积 |

| Handoffs | 7+ | ~14K+ | Sequential execution required |
| 交接模式（Handoffs） | 7+ | 约 14,000+ | 必须按顺序执行 |

| Router | 5 | ~9K | Parallel execution |
| 路由器模式（Router） | 5 | 约 9,000 | 支持并行执行 |

**Key insight**: For multi-domain tasks, patterns with parallel execution (Subagents, Router) are most efficient. Skills has fewer calls but high token usage due to context accumulation. Handoffs must execute sequentially and can’t leverage parallel tool calling for consulting multiple domains simultaneously.

**关键洞察**：针对跨领域任务，并行执行模式（子智能体、路由器）效率最高。技能模式调用次数更少，但因上下文持续累积，导致 Token 消耗显著升高；交接模式必须严格串行执行，无法通过并行调用工具同时咨询多个领域。

In this scenario, Subagents processes 67% fewer tokens overall compared to Skills due to context isolation. Each subagent works only with relevant context, avoiding the token bloat that accumulates when loading multiple skills into a single conversation.

在此场景中，得益于上下文隔离，子智能体模式的整体 Token 消耗比技能模式低 67%。每个子智能体仅处理与其任务相关的上下文，从而避免了将多项技能加载至单一对话中所引发的 Token 冗余膨胀。

![](images/choosing-the-right-multi-agent-architecture/img_007.png)

### Performance summary

### 性能概览

The optimal pattern depends on your workload characteristics:

最优模式取决于您的工作负载特征：

| Pattern | Single requests | Repeat requests | Parallel execution | Large-context domains |
| --- | --- | --- | --- | --- |
| Subagents | — | — | ✅ | ✅ |
| 子智能体（Subagents） | — | — | ✅ | ✅ |

| Skills | ✅ | ✅ | — | — |
| 技能模式（Skills） | ✅ | ✅ | — | — |

| Handoffs | ✅ | ✅ | — | — |
| 交接模式（Handoffs） | ✅ | ✅ | — | — |

| Router | ✅ | — | ✅ | ✅ |
| 路由器模式（Router） | ✅ | — | ✅ | ✅ |

## Getting Started

## 入门指南

Multi-agent systems coordinate specialized components to tackle complex workflows. When you do need multi-agent capabilities, match your requirements to the decision framework above. For teams wanting to start quickly, [Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) offers an out-of-the-box implementation combining subagents and skills for complex task planning.

多智能体系统通过协调多个专业化组件，协同处理复杂工作流。当您确实需要多智能体能力时，请依据上述决策框架匹配自身需求。对于希望快速上手的团队，[Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 提供开箱即用的实现方案，融合子智能体与技能模式，专为复杂任务规划而设计。

In many cases though, simpler architectures often suffice. Start with a single agent and good prompt engineering. Add tools before adding agents. Graduate to multi-agent patterns only when you hit clear limits.

然而在许多情况下，更简单的架构已足以满足需求。建议从单智能体起步，并辅以高质量的提示词工程；优先为单智能体添加工具，而非直接引入多智能体；仅当明确遭遇性能或功能瓶颈时，再逐步升级至多智能体模式。
{% endraw %}
