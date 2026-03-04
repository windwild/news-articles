---
title: "Unlocking the Codex harness: how we built the App Server | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/unlocking-the-codex-harness"
date: "2026-02-04"
scraped_at: "2026-03-02T10:08:22.757359688+00:00"
language: "en-US"
translated: true
description: "Learn how to embed the Codex agent using the Codex App Server, a bidirectional JSON-RPC API powering streaming progress, tool use, approvals, and diffs."
tags: ["Engineering"]
---
{% raw %}

2026年2月4日


# Unlocking the Codex harness: how we built the App Server

# 解锁 Codex 框架：我们如何构建 App Server

By Celia Chen, Member of the Technical Staff

作者：Celia Chen，技术团队成员


OpenAI’s coding agent Codex exists across many different surfaces: [the web app⁠(opens in a new window)](https://chatgpt.com/codex?openaicom-did=8479cbcc-af1f-4038-b134-89cf307dce56&openaicom_referred=true), [the CLI⁠(opens in a new window)](https://github.com/openai/codex), [the IDE extension⁠(opens in a new window)](https://developers.openai.com/codex/ide/), and [the new Codex macOS app](https://openai.com/index/introducing-the-codex-app/). Under the hood, they’re all powered by the same Codex harness—the agent loop and logic that underlies all Codex experiences. The critical link between them? The [Codex App Server⁠(opens in a new window)](https://developers.openai.com/codex/app-server), a client-friendly, bidirectional JSON-RPC[1](https://openai.com/index/unlocking-the-codex-harness/#citation-bottom-1) API.

OpenAI 的编程智能体 Codex 部署于多个不同平台：[网页应用⁠(在新窗口中打开)](https://chatgpt.com/codex?openaicom-did=8479cbcc-af1f-4038-b134-89cf307dce56&openaicom_referred=true)、[命令行工具（CLI）⁠(在新窗口中打开)](https://github.com/openai/codex)、[IDE 插件⁠(在新窗口中打开)](https://developers.openai.com/codex/ide/)，以及[全新的 Codex macOS 应用](https://openai.com/index/introducing-the-codex-app/)。这些产品底层均依赖同一套 Codex 框架——即驱动所有 Codex 用户体验的智能体循环（agent loop）与核心逻辑。而连接它们的关键纽带，正是[ Codex App Server⁠(在新窗口中打开)](https://developers.openai.com/codex/app-server)：一个面向客户端、支持双向通信的 JSON-RPC[1](https://openai.com/index/unlocking-the-codex-harness/#citation-bottom-1) API。

In this post, we’ll introduce the Codex App Server; we’ll share our learnings so far on the best ways to bring Codex’s capabilities into your product to help your users supercharge their workflows. We’ll cover the App Server’s architecture and protocol and how it integrates with different Codex surfaces, as well as tips on leveraging Codex, whether you want to turn Codex into a code reviewer, an SRE agent, or a coding assistant.

本文将正式介绍 Codex App Server；我们将分享迄今积累的实践经验，助您以最优方式将 Codex 的能力集成至自身产品中，从而显著提升用户软件开发工作流的效率。内容涵盖 App Server 的架构设计与通信协议、其与各类 Codex 平台的集成方式，并提供实用建议——无论您希望将 Codex 打造成代码审查员、SRE（站点可靠性工程）智能体，还是编程助手，皆可从中获益。

## Origin of the App Server

## App Server 的起源

Before diving into architecture, it’s helpful to know the App Server’s backstory. Initially, the App Server was a practical way to reuse the Codex harness across products that gradually evolved into our standard protocol.

在深入探讨架构之前，了解 App Server 的演进背景十分有益。最初，App Server 仅是一种跨产品复用 Codex 框架的务实方案，随后逐步发展为我们的标准通信协议。

Codex CLI started as a TUI (terminal user interface), meaning Codex is accessed through the terminal. When we built the VS Code extension (a more IDE-friendly way to interact with Codex agents), we needed a way to use the same harness so as to drive the same agent loop from an IDE UI without re-implementing it. That meant supporting rich interaction patterns beyond request/response, such as exploring the workspace, streaming progress as the agent reasons, and emitting diffs. We first experimented with exposing [Codex as an MCP server⁠(opens in a new window)](https://github.com/openai/codex/pull/2264), but maintaining MCP semantics in a way that made sense for VS Code proved difficult. Instead, we introduced a JSON-RPC protocol that mirrored the TUI loop, which became the [unofficial first version⁠(opens in a new window)](https://github.com/openai/codex/pull/4471) of the App Server. At the time, we didn’t expect other clients to depend on the App Server, so it wasn’t designed as a stable API.

Codex CLI 最初采用 TUI（终端用户界面）形式，即用户通过终端访问 Codex。当我们开发 VS Code 插件（一种更契合 IDE 使用习惯的 Codex 智能体交互方式）时，亟需一种机制，使插件能在 IDE 界面中直接驱动相同的 Codex 框架与智能体循环，而无需重复实现整套逻辑。这就要求支持远超传统请求/响应模式的丰富交互能力，例如：浏览项目工作区、实时流式输出智能体推理过程中的进度、以及生成并推送代码变更差异（diffs）。我们曾尝试将 Codex 以 [MCP 服务器⁠(在新窗口中打开)](https://github.com/openai/codex/pull/2264) 形式暴露，但实践发现，MCP 的语义模型难以适配 VS Code 的实际使用场景。最终，我们转而设计了一套 JSON-RPC 协议，其交互流程严格复刻了原有 TUI 循环逻辑，由此诞生了 App Server 的[非正式初版⁠(在新窗口中打开)](https://github.com/openai/codex/pull/4471)。彼时，我们并未预见到其他客户端会依赖该服务，因此它并非作为稳定 API 进行设计。

As Codex adoption grew over the next few months, internal teams and external partners wanted the ability to embed the same harness in their own products in order to accelerate their users’ software development workflows. For example, JetBrains and Xcode wanted an IDE-grade agent experience, while the Codex desktop app needed to orchestrate many Codex agents in parallel. Those demands pushed us to design a platform surface that both our products and partner integrations could safely depend on over time. It needed to be easy to integrate and backward compatible, meaning we could evolve the protocol without breaking existing clients.

随后数月间，随着 Codex 应用范围持续扩大，公司内部各团队及外部合作伙伴纷纷提出需求：希望将同一套 Codex 框架嵌入各自的产品中，以加速其用户的软件开发流程。例如，JetBrains 和 Xcode 均期望获得媲美专业 IDE 的智能体体验；而 Codex 桌面应用则需同时协调运行多个 Codex 智能体。这些现实需求促使我们着手设计一个统一的平台接口层——它既要能长期稳定支撑我们自身产品，也要可供合作伙伴安全集成。该接口必须易于接入，且具备向后兼容性，确保我们在持续演进协议的同时，不会破坏现有客户端的功能。

Next, we’ll walk through how we designed the architecture and protocol so different clients can use the same harness.

接下来，我们将详细介绍我们如何设计该架构与协议，以支持不同客户端复用同一套 Codex harness。

## Inside the Codex harness

## Codex harness 内部结构

First, let’s zoom in on what’s inside the Codex harness and how the Codex App Server exposes it to clients. In our last Codex [blog](https://openai.com/index/unrolling-the-codex-agent-loop/), we broke down the core agent loop that orchestrates the interaction between the user, the model, and the tools. This is the core logic of the Codex harness, but there’s more to the full agent experience:

首先，让我们深入剖析 Codex harness 的内部构成，以及 Codex App Server 如何将其能力暴露给客户端。在我们上一篇关于 Codex 的[博客文章](https://openai.com/index/unrolling-the-codex-agent-loop/)中，我们已详细拆解了核心 agent 循环（core agent loop）——这一机制负责协调用户、模型与工具之间的交互。这构成了 Codex harness 的核心逻辑；但完整的 agent 体验还包含更多关键要素：

**1\. Thread lifecycle and persistence**. A thread is a Codex conversation between a user and an agent. Codex creates, resumes, forks, and archives threads, and persists the event history so clients can reconnect and render a consistent timeline.

**1. 对话线程（Thread）的生命周期管理与持久化**。一个 thread 即用户与 agent 之间的一次 Codex 对话。Codex 支持创建、恢复、分叉（fork）和归档线程，并持久化全部事件历史，使客户端可在断连后重新接入，并渲染出一致的时间线视图。

**2\. Config and auth**. Codex loads configuration, manages defaults, and runs authentication flows like “Sign in with ChatGPT,” including credential state.

**2. 配置管理与身份认证**。Codex 加载配置、管理默认参数，并执行各类认证流程（例如“使用 ChatGPT 登录”），同时维护凭证状态（credential state）。

**3\. Tool execution and extensions**. Codex executes shell/file tools in a sandbox and wires up integrations like MCP servers and skills so they can participate in the agent loop under a consistent policy model.

**3. 工具执行与扩展能力**。Codex 在沙箱环境中执行 shell / 文件类工具，并对接各类集成服务（如 MCP 服务器与技能模块），使其能在统一的策略模型下参与 agent 循环。

All the agent logic we mentioned here, including the core agent loop, lives in a part of the Codex CLI codebase called “ [Codex core⁠(opens in a new window)](https://github.com/openai/codex/tree/main/codex-rs/core).” Codex core is both a library where all the agent code lives and a runtime that can be spun up to run the agent loop and manage the persistence of one Codex thread (conversation).

上述所有 agent 相关逻辑（包括核心 agent 循环）均实现在 Codex CLI 代码库的一个模块中，名为 “[Codex core⁠（在新窗口中打开）](https://github.com/openai/codex/tree/main/codex-rs/core)”。Codex core 既是一个承载全部 agent 代码的程序库（library），也是一个可启动运行的运行时（runtime）——它能执行 agent 循环，并管理单个 Codex thread（即一次对话）的状态持久化。

To be useful, the Codex harness needs to be accessible to clients. That’s where the App Server comes in.

要真正发挥价值，Codex harness 必须对客户端开放可访问性。这正是 App Server 的作用所在。

![Diagram titled “App server process flow.” A client sends JSON-RPC messages to a stdio reader, which dispatches requests to a Codex message processor. The processor interacts with a thread manager and core thread via lookup threads, thread handles, submitted requests, and events/updates, then returns responses back to the client.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_001.svg)

![图示标题为“App Server 处理流程”。客户端向 stdio reader 发送 JSON-RPC 消息；stdio reader 将请求分发至 Codex 消息处理器；该处理器通过查询线程（lookup threads）、线程句柄（thread handles）、已提交请求（submitted requests）及事件/更新（events/updates）等方式，与线程管理器（thread manager）和核心线程（core thread）交互，最终将响应返回客户端。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_001.svg)

The App Server is both the JSON-RPC protocol between the client and the server and a long-lived process that hosts the Codex core threads. As we can see from the diagram above, an App Server process has four main components: the stdio reader, the Codex message processor, the thread manager, and core threads. The thread manager spins up one core session for each thread, and the Codex message processor then communicates with each core session directly to submit client requests and receive updates.

App Server 既指客户端与服务端之间所采用的 JSON-RPC 协议，也指一个长期运行的进程——该进程负责托管 Codex core 线程。如上图所示，一个 App Server 进程包含四大核心组件：stdio reader、Codex 消息处理器（message processor）、线程管理器（thread manager）以及核心线程（core threads）。其中，线程管理器为每个 thread 启动一个独立的 core session；而 Codex 消息处理器则直接与各个 core session 通信，以提交客户端请求并接收事件更新。

一个客户端请求可能触发多次事件更新，而这些详细的事件正是我们能够在 App Server 之上构建丰富 UI 的基础。此外，标准输入/输出（stdio）读取器与 Codex 消息处理器共同充当客户端与 Codex 核心线程之间的翻译层：它们将客户端发出的 JSON-RPC 请求转换为 Codex 核心可执行的操作，监听 Codex 核心内部的事件流，并将这些底层事件转化为一组稳定、面向 UI 的 JSON-RPC 通知。

客户端与 App Server 之间的 JSON-RPC 协议是完全双向的。一次典型的对话线程（thread）包含一个客户端请求和多个服务端通知；此外，当智能体（agent）需要用户输入（例如审批确认）时，服务端也可主动发起请求，并暂停当前“回合”（turn），直至客户端响应。

## 对话基本单元（Conversation Primitives）

## 对话基本单元

接下来，我们将拆解“对话基本单元”——即 App Server 协议的构成基石。为智能体循环（agent loop）设计 API 具有挑战性，因为用户与智能体之间的交互并非简单的请求/响应模式。一次用户请求可能展开为一系列结构化的操作步骤，客户端需忠实地呈现整个过程：包括用户的原始输入、智能体的渐进式进展，以及过程中生成的各类产物（例如代码差异 diff）。为使该交互流易于集成、且在不同 UI 环境中具备强健性与一致性，我们最终确立了三个边界清晰、生命周期明确的核心基本单元：

**1. 项（Item）：**  
**1. 项（Item）：**  
“项”是 Codex 中输入/输出的原子单位。“项”具有类型（例如：用户消息、智能体消息、工具执行、审批请求、diff），且每种类型均拥有明确的生命周期：

- `item/started`：项启动时触发；  
- 可选的 `item/*/delta` 事件：适用于支持流式内容的项类型，随内容逐步到达而持续触发；  
- `item/completed`：项完成时触发，并附带其最终有效载荷（terminal payload）。

该生命周期使客户端可在 `started` 时立即开始渲染，在 `delta` 时流式更新中间状态，并于 `completed` 时完成最终呈现。

**2. 回合（Turn）：**  
**2. 回合（Turn）：**  
“回合”是由用户输入所触发的一次智能体工作单元。它始于客户端提交输入（例如：“运行测试并汇总失败信息”），终于智能体针对该输入完成全部输出生成。“回合”内包含一系列“项”，用以表征执行过程中的中间步骤及产出结果。

**3. 对话线程（Thread）：**  
**3. 对话线程（Thread）：**  
“对话线程”是用户与智能体之间持续进行的 Codex 会话的持久化容器，可容纳多个“回合”。“线程”支持创建、恢复、分叉（fork）与归档（archive）；其历史记录被持久化存储，确保客户端可随时重新连接，并一致地还原完整时间线。

接下来，我们将通过一个简化的客户端与智能体之间的对话示例，展示这些基本单元如何共同构成实际的交互流程：

![Diagram labeled “Client-server protocol message flow: Initialization handshake.” A client sends an initialize request with clientInfo to the server. The server replies with a result event containing the userAgent string “my_client/1.0.”](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_002.svg)

![图示标题为“客户端-服务器协议消息流：初始化握手”。客户端向服务器发送一条带 `clientInfo` 的 `initialize` 请求；服务器以一条包含 `userAgent` 字符串 “my_client/1.0” 的结果事件作为响应。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_002.svg)

At the beginning of the conversation, the client and the server need to establish the `initialize` handshake. The client must send a single `initialize` request before any other method, and the server acknowledges with a response. This gives the server a chance to advertise capabilities and lets both sides agree on protocol versioning, feature flags, and defaults before the real work begins. Here’s an example payload from OpenAI’s VS Code extension:

对话开始之初，客户端与服务器需完成 `initialize`（初始化）握手。客户端必须在调用任何其他方法之前，先发送**唯一一条** `initialize` 请求；服务器则通过响应予以确认。此举使服务器得以声明自身支持的能力，同时也让双方能在实际工作启动前，就协议版本、功能开关（feature flags）及默认配置等达成一致。以下是 OpenAI 官方 VS Code 扩展中的一段示例载荷（payload）：

#### JSON

#### JSON

`1{

2  "method": "initialize",

3  "id": 0,

4  "params": {

5    "clientInfo": {

6      "name": "codex_vscode",

7      "title": "Codex VS Code Extension",`

`1{

2  "method": "initialize",

3  "id": 0,

4  "params": {

5    "clientInfo": {

6      "name": "codex_vscode",

7      "title": "Codex VS Code 扩展",`

8      "version": "0.1.0"

8      “version”: “0.1.0”

9    }

9    }

10  }

10  }

11}

11}

`

`

This is what the server returns:

服务器返回的内容如下：

#### JSON

#### JSON

`1{

`1{

2  "id": 0,

2  “id”: 0,

3  "result": {

3  “result”: {

4    "userAgent": "codex_vscode/0.94.0-alpha.7 (Mac OS 26.2.0; arm64) vscode/2.4.22 (codex_vscode; 0.1.0)"

4    "userAgent": "codex_vscode/0.94.0-alpha.7（Mac OS 26.2.0；arm64）vscode/2.4.22（codex_vscode；0.1.0）"

5  }

5  }

6}

6}

![Diagram titled “Client-server protocol message flow: Thread & turn lifecycle.” The client sends thread/start and turn/start requests to the server. The server emits events—thread/started, turn/started, item/started, and item/completed—showing a turn where the user message is “run tests and summarize failures.”](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_003.svg)

![标题为“客户端-服务器协议消息流：线程与回合生命周期”的示意图。客户端向服务器发送 `thread/start` 和 `turn/start` 请求；服务器发出事件——`thread/started`、`turn/started`、`item/started` 和 `item/completed`，展示一次用户消息为“run tests and summarize failures”（运行测试并汇总失败信息）的回合。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_003.svg)

When a client makes a new request, it will first create a thread and then a turn. The server will send back notifications for progress (`thread/started` and `turn/started`). It will also send back inputs it registers as items, like the user message here.

当客户端发起一个新请求时，它首先创建一个线程（thread），然后创建一个回合（turn）。服务器将返回进度通知（如 `thread/started` 和 `turn/started`）；同时，也会将它所注册的输入作为“项”（items）返回，例如此处的用户消息。

![Diagram titled “Client-server protocol message flow: Tool execution with optional approval.” During a tool call, the server emits item/started, then item/commandExecution/requestApproval with a reason (“run tests”). The client returns an approval event (allow/deny). The server then emits item/completed showing the command execution ("pnpm test").](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_004.svg)

![标题为“客户端-服务器协议消息流：带可选审批的工具执行”的示意图。在调用工具时，服务器先发出 `item/started`，再发出 `item/commandExecution/requestApproval`（附带原因：“run tests”／运行测试）；客户端返回审批事件（`allow`／允许 或 `deny`／拒绝）；随后服务器发出 `item/completed`，显示命令执行结果（"pnpm test"）。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_004.svg)

Tool calls are also sent back to the client as items. Additionally, the server may ask for client approval before it can run an action by sending a server request. The approval will pause the turn until the client replies with either “allow” or “deny.” This is what the approval flow looks like in the VS Code extension:

工具调用同样以“项”（items）的形式返回给客户端。此外，服务器在执行某项操作前，可通过发送服务端请求向客户端征询审批。该审批将暂停当前回合，直至客户端回复“allow”（允许）或“deny”（拒绝）。以下即 VS Code 扩展中审批流程的实际呈现：

![Permission prompt in a dark-themed interface asking, “Do you want to allow me to run pnpm test for this workspace?” It lists options: 1) Yes, 2) Yes and don’t ask again for commands starting with pnpm test, and 3) No, with a Submit button at the bottom.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_005.png)

![深色主题界面中的权限提示框，提问：“您是否允许我为此工作区运行 `pnpm test`？”提供三个选项：1）是；2）是，且今后对以 `pnpm test` 开头的命令不再询问；3）否；底部设有“提交”按钮。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_005.png)

![Diagram titled “Client-server protocol message flow: Streaming agent message flow.” The server streams an assistant message in parts: item/started, two agentMessage/delta events (“ran 3 tests.”, “all passed”), then item/completed. The turn ends with turn/completed.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_006.svg)

![标题为“客户端-服务器协议消息流：流式代理消息流程”的示意图。服务器以分段方式流式传输助手消息：依次发出 `item/started`、两条 `agentMessage/delta` 事件（内容分别为“ran 3 tests.”／运行了 3 个测试、“all passed”／全部通过），最后发出 `item/completed`；该回合以 `turn/completed` 结束。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_006.svg)

In the end, the server sends an agent message and then ends the turn with `turn/completed`. The agent message delta events stream pieces of the message back until the message is finalized with `item/completed`.

最后，服务器发送一条 agent 消息，然后以 `turn/completed` 结束当前回合。agent 消息的增量事件（delta events）会逐步流式返回消息内容，直至该消息最终通过 `item/completed` 事件完成。

The messages in the diagram are simplified for readability. If you want to see the JSON for a full turn, you can run the test client from the Codex CLI repo:

图中所示的消息已为便于阅读而做了简化。如需查看完整一回合对应的 JSON 数据，可运行 Codex CLI 仓库中的测试客户端：

#### Bash

#### Bash

`1codex debug app-server send-message-v2 "run tests and summarize failures"`

`1codex debug app-server send-message-v2 "run tests and summarize failures"`

## Integrating with clients

## 与客户端集成

Now, let’s look at how different client surfaces embed Codex via the App Server. We’ll cover three patterns: local apps and IDEs, Codex web runtime, and the TUI.

接下来，我们来看不同类型的客户端如何通过 App Server 嵌入 Codex。我们将介绍三种集成模式：本地应用与 IDE、Codex Web 运行时（Web Runtime），以及终端用户界面（TUI）。

![Diagram titled “Codex clients integrated with Codex harness via app server.” First-party clients (Codex Desktop App, TUI/CLI, Web Runtime) and third-party integrations (JetBrains IDEs, VS Code, Xcode) communicate with the Codex harness through JSON-RPC calls.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_007.svg)

![标题为“Codex 客户端通过 App Server 集成至 Codex Harness”的架构图：第一方客户端（Codex 桌面应用、TUI/CLI、Web Runtime）与第三方集成（JetBrains IDE、VS Code、Xcode）均通过 JSON-RPC 调用与 Codex Harness 进行通信。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_007.svg)

Across all three, the transport is JSON-RPC over stdio (JSONL). JSON-RPC makes it straightforward to build client bindings in the language of your choice. Codex surfaces and partner integrations have implemented App Server clients in languages including Go, Python, TypeScript, Swift, and Kotlin. For TypeScript, you can generate definitions directly from the Rust protocol by running:

上述三种集成方式均采用基于标准输入输出（stdio）的 JSON-RPC（即 JSONL 格式）作为传输协议。JSON-RPC 协议使得开发者能轻松地使用任意编程语言构建客户端绑定。Codex 各类客户端界面及合作伙伴集成方案已在多种语言中实现了 App Server 客户端，包括 Go、Python、TypeScript、Swift 和 Kotlin。对于 TypeScript，您可通过运行以下命令，直接从 Rust 协议定义生成类型声明：

#### Bash

#### Bash

`1codex app-server generate-ts`

`1codex app-server generate-ts`

For other languages, you can generate a JSON Schema bundle and feed it into your preferred code generator by running:

对于其他编程语言，您可运行以下命令生成一个 JSON Schema 包，并将其输入您偏好的代码生成器：

#### Bash

#### Bash

`1codex app-server generate-json-schema`

`1codex app-server generate-json-schema`

##### Local Apps & IDEs

##### 本地应用与 IDE

![Screenshot of VS Code with the Codex extension running. A Rust test file is open, and below it the Codex panel describes running just fmt and cargo test -p codex-app-server, reporting that formatting and tests are in progress while awaiting a final pass/fail result.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_008.png)

![VS Code 截图，显示 Codex 扩展正在运行：一个 Rust 测试文件已打开，其下方的 Codex 面板显示当前仅执行 `fmt` 和 `cargo test -p codex-app-server`；面板同时报告格式化与测试正在进行中，正等待最终的通过/失败结果。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_008.png)

Local clients typically bundle or fetch a platform-specific App Server binary, launch it as a long-running child process, and keep a bidirectional stdio channel open for JSON-RPC. In our VS Code extension and Desktop App, for example, the shipped artifact includes the platform-specific Codex binary and is pinned to a tested version so the client always runs the exact bits we validated.

本地客户端通常会将平台专用的 App Server 二进制文件打包进自身，或在运行时动态获取该文件，随后以长期运行的子进程方式启动它，并保持一个用于 JSON-RPC 的双向标准 I/O（stdio）通信通道。例如，在我们的 VS Code 扩展和桌面应用中，所发布的构建产物即包含对应平台的 Codex 二进制文件，且版本被锁定在经充分测试的特定版本上，从而确保客户端始终运行我们已验证过的精确代码。

Not every integration can ship client updates frequently. Some partners like Xcode decouple release cycles by keeping the client stable and allowing it to point to a newer App Server binary when needed. That way they can adopt server-side improvements (for example, better auto-compaction in Codex core or newly supported config keys) and roll out bug fixes without waiting for a client release. The App Server’s JSON-RPC surface is designed to be backward compatible, so older clients can talk to newer servers safely.

并非所有集成方案都能频繁发布客户端更新。一些合作伙伴（如 Xcode）则通过保持客户端稳定、仅在需要时让其指向更新版 App Server 二进制文件的方式，实现客户端与服务端发布周期的解耦。如此一来，他们便可在无需等待客户端发版的前提下，直接采用服务端的改进功能（例如 Codex 核心中更优的自动压缩能力，或新支持的配置项），并快速推送缺陷修复。App Server 的 JSON-RPC 接口设计为向后兼容，因此旧版客户端可安全地与新版服务器通信。

##### Codex Web

##### Codex Web

![Screenshot of a Codex web interface showing an update titled “Update login success message.” The left panel summarizes changes, tests, and modified files, while the right panel displays a code diff for login.rs with updated login success message phrasing.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_009.png)

![一张 Codex Web 界面截图，显示标题为“更新登录成功提示信息”的变更。左侧面板汇总了变更内容、测试结果及被修改的文件；右侧面板则展示了 login.rs 文件的代码差异（diff），其中登录成功提示语句已被更新。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_009.png)

Codex Web uses the Codex harness, but runs it in a container environment. A worker provisions a container with the checked-out workspace, launches the App Server binary inside it, and maintains a long-lived JSON-RPC over stdio[2](https://openai.com/index/unlocking-the-codex-harness/#citation-bottom-2) channel. The web app (running in the user’s browser tab) talks to the Codex backend over HTTP and SSE, which streams task events produced by the worker. This keeps the browser-side UI lightweight while still giving us a consistent runtime across desktop and web.

Codex Web 使用 Codex harness，但在容器环境中运行。一个工作进程（worker）会基于已检出的工作区（workspace）配置一个容器，在其中启动 App Server 二进制程序，并通过标准输入/输出（stdio）维持一条长期存活的 JSON-RPC 通信通道[2](https://openai.com/index/unlocking-the-codex-harness/#citation-bottom-2)。Web 应用（运行于用户浏览器标签页中）则通过 HTTP 和服务器发送事件（SSE）协议与 Codex 后端通信，后者将工作进程生成的任务事件以流式方式推送。这种方式既保证了浏览器端 UI 的轻量化，又确保了桌面端与 Web 端运行时行为的一致性。

Because web sessions are ephemeral (tabs close, networks drop), the web app cannot be the source of truth for long-running tasks. Keeping state and progress on the server means work continues even if the tab disappears. The streaming protocol and saved thread sessions make it easy for a new session to reconnect, pick up where it left off, and catch up without rebuilding state in the client.

由于 Web 会话具有临时性（标签页可能关闭、网络可能中断），Web 应用无法作为长期运行任务的“唯一真相源”（source of truth）。将状态与进度保留在服务端，意味着即使标签页关闭，任务仍可持续执行。借助流式协议与已保存的会话线程（thread sessions），新会话可轻松重新连接、从中断处继续，并同步遗漏事件，而无需在客户端重建状态。

##### TUI/Codex CLI

##### TUI / Codex CLI

![Screenshot of a terminal running the Codex CLI. It shows the OpenAI Codex banner with model gpt-5.2-codex medium, a user command “explain app server to me,” and a “Working” status. Below, a suggestion appears: “write tests for @filename,” with options for shortcuts.](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_010.png)

![终端运行 Codex CLI 的截图：显示 OpenAI Codex 横幅、模型标识 gpt-5.2-codex medium、用户命令“explain app server to me”以及“Working”（运行中）状态；下方出现建议：“write tests for @filename”，并附有快捷操作选项。](images/unlocking-the-codex-harness-how-we-built-the-app-server-openai/img_010.png)

Historically, the TUI was a “native” client that ran in the same process as the agent loop and talked directly to Rust core types rather than the app-server protocol. That made early iteration fast, but it also made the TUI a special-case surface.

历史上，TUI 是一种“原生”客户端，与智能体主循环（agent loop）运行于同一进程，并直接调用 Rust 核心类型，而非通过 App Server 协议通信。这使得早期迭代非常迅速，但也导致 TUI 成为一个特例化的交互界面。

Now that the App Server exists, we plan to [refactor the TUI⁠(opens in a new window)](https://github.com/openai/codex/pull/10192) to use it so it behaves like any other client: launch an App Server child process, speak JSON-RPC over stdio, and render the same streaming events and approvals. This unlocks workflows where the TUI can connect to a Codex server running on a remote machine, keeping the agent close to compute and continuing work even if the laptop sleeps or disconnects, while still delivering live updates and controls locally.

如今 App Server 已就绪，我们计划[重构 TUI⁠（在新窗口中打开）](https://github.com/openai/codex/pull/10192)，使其改用 App Server，从而与其他客户端保持一致：启动一个 App Server 子进程，通过 stdio 进行 JSON-RPC 通信，并渲染相同的流式事件与审批操作。这一转变解锁了全新工作流——TUI 可连接至远程机器上运行的 Codex 服务端，使智能体始终靠近计算资源；即便笔记本电脑休眠或断开连接，任务仍可持续执行，同时本地仍能实时接收更新并进行控制。

## Choosing the right protocol

## 选择合适的协议

Codex App Server will be the first-class integration method we maintain moving forward, but there are also other methods with more limited functionality. By default, we’d recommend that clients use Codex App Server to integrate with Codex, but it’s worth taking a look at different integration methods and understanding their pros and cons. Below are the most common ways to drive Codex and when each might be a good fit.

Codex App Server 将成为我们未来持续维护的首选集成方式；但同时也存在其他功能更有限的集成方法。默认情况下，我们建议客户端优先采用 Codex App Server 与 Codex 集成；不过，了解不同集成方式及其各自的优缺点也十分必要。下文列出了驱动 Codex 的几种最常见方式，以及各自适用的典型场景。

#### JSON-RPC protocols

#### JSON-RPC 协议

##### Codex as an MCP server

##### Codex 作为 MCP 服务器

Run [`codex mcp-server`⁠(opens in a new window)](https://developers.openai.com/codex/guides/agents-sdk/) and connect from any MCP client that supports stdio servers (e.g., [OpenAI Agents SDK⁠(opens in a new window)](https://openai.github.io/openai-agents-js/)). This is a good fit if you already have an MCP-based workflow and want to invoke Codex as a callable tool. The downside is that you only get what MCP exposes, so Codex-specific interactions that rely on richer session semantics (e.g., diff updates) may not map cleanly through MCP endpoints.

运行 [`codex mcp-server`⁠（在新窗口中打开）](https://developers.openai.com/codex/guides/agents-sdk/)，并从任意支持 stdio 服务器的 MCP 客户端（例如 [OpenAI Agents SDK⁠（在新窗口中打开）](https://openai.github.io/openai-agents-js/)）连接。若你已构建基于 MCP 的工作流，并希望将 Codex 作为可调用工具集成，此方式尤为合适。其不足在于：你仅能访问 MCP 所暴露的能力接口，因此依赖更丰富会话语义（例如差异更新，diff updates）的 Codex 特有交互，可能无法通过 MCP 接口清晰、完整地映射。

##### Cross-provider agent harness protocols

##### 跨供应商代理运行时协议

Some ecosystems offer a portable interface that can target multiple model providers and runtimes. This can be a good fit if you want one abstraction that coordinates multiple agents. The tradeoff is that these protocols often converge on the common subset of capabilities, which can make richer interactions harder to represent, especially when provider-specific tool and session semantics matter. This space is evolving quickly, and we expect that more common standards will emerge as we figure out the best primitives to represent real-world agent workflows ( [skills⁠(opens in a new window)](https://agentskills.io/home) is a good example of this).

部分生态体系提供可移植接口，支持对接多个模型供应商及运行时环境。若你希望借助统一抽象层协调多个代理（agent），该方案十分适用。但权衡之处在于：此类协议往往收敛于各平台能力的交集，导致更丰富的交互逻辑难以准确表达——尤其当供应商特有的工具行为与会话语义至关重要时。该领域正快速发展；随着我们逐步厘清表征真实世界代理工作流的最佳基础原语（primitives），更多通用标准有望浮现（[skills⁠（在新窗口中打开）](https://agentskills.io/home) 即为这一趋势的良好范例）。

##### Codex App Server

##### Codex 应用服务器

Choose the App Server when you want the full Codex harness exposed as a stable, UI-friendly event stream. You get both the full functionality of the agent loop and other supporting features like Sign in with ChatGPT, model discovery, and configuration management. The main cost is integration work, since you need to build the client-side JSON-RPC binding in your language. In practice, however, Codex is able to do a lot of the heavy lifting if you feed it the JSON schema and documentation. Many teams we worked with were able to make to a working integration quickly using Codex.

当你希望以稳定、面向 UI 的事件流形式全面暴露 Codex 运行时能力时，请选用 App Server。你将获得完整的代理循环（agent loop）功能，以及登录 ChatGPT、模型发现（model discovery）、配置管理等配套特性。主要成本在于集成工作：你需要在所用编程语言中自行实现客户端侧的 JSON-RPC 绑定。但在实践中，只要向 Codex 提供 JSON Schema 和文档，它便能承担大量繁重工作。我们合作过的许多团队均借助 Codex 快速实现了可用的集成。

#### Other ways to Embed Codex

#### 其他嵌入 Codex 的方式

##### [Codex Exec⁠(opens in a new window)](https://developers.openai.com/codex/cli/reference/\#codex-exec)

##### [Codex Exec⁠（在新窗口中打开）](https://developers.openai.com/codex/cli/reference/\#codex-exec)

A lightweight, scriptable CLI mode for one-off tasks and CI runs. It’s a good fit for automation and pipelines where you want a single command to run to completion non-interactively, stream structured output for logs, and exit with a clear success or failure signal.

一种轻量级、可脚本化的命令行界面（CLI）模式，适用于一次性任务和持续集成（CI）运行。它非常适合自动化流程与流水线场景：你只需执行一条命令，即可非交互式地运行至完成，实时输出结构化日志，并以明确的成功或失败状态码退出。

##### [Codex SDK⁠(在新窗口中打开)](https://developers.openai.com/codex/sdk/)

##### [Codex SDK⁠(opens in a new window)](https://developers.openai.com/codex/sdk/)

一个 TypeScript 库，用于在您自己的应用程序中以编程方式控制本地 Codex 智能体。当您需要为服务端工具和工作流提供原生库接口（而无需另行构建 JSON-RPC 客户端）时，该 SDK 最为适用。由于它比 App Server 更早发布，目前支持的语言种类更少，功能覆盖范围也更有限。若开发者对此有明确需求，我们可能会推出额外的 SDK，封装 App Server 协议，从而帮助团队覆盖更广泛的智能体运行时（harness）功能，而无需自行编写 JSON-RPC 绑定代码。

A TypeScript library for programmatically controlling local Codex agents from within your own application. It’s best when you want a native library interface for server-side tools and workflows without building a separate JSON-RPC client. Since it shipped earlier than the App Server, it currently supports fewer languages and a smaller surface area. If there is developer interest, we may add additional SDKs that wrap the App Server protocol so teams can cover more of the harness surface without writing JSON-RPC bindings.

## 推进下一步

## Taking this forward

在本文中，我们分享了如何设计一种与智能体交互的新标准，并介绍了如何将 Codex 运行时（harness）转化为稳定、对客户端友好的协议。我们阐述了 App Server 如何暴露 Codex 核心能力、使客户端能够驱动完整的智能体执行循环（agent loop），并支撑多种使用场景，包括终端用户界面（TUI）、本地 IDE 集成以及 Web 运行时环境。

In this post, we shared how we approach designing a new standard for interacting with agents and how to turn the Codex harness into a stable, client-friendly protocol. We covered how the App Server exposes Codex core, lets clients drive the full agent loop, and powers a wide range of surfaces including the TUI, local IDE integrations, and the web runtime.

如果您由此获得启发，希望将 Codex 集成到您自己的工作流中，不妨尝试一下 App Server。全部源代码均托管于 Codex CLI 开源 [代码仓库⁠(在新窗口中打开)](https://github.com/openai/codex/blob/main/codex-rs/app-server/README.md) 中。欢迎随时分享您的反馈与功能需求。我们非常期待听到您的声音，并将持续努力，让智能体技术惠及更多开发者。

If this sparked ideas for integrating Codex into your own workflows, it’s worth giving App Server a try. All the source code lives in the Codex CLI open-source [repo⁠(opens in a new window)](https://github.com/openai/codex/blob/main/codex-rs/app-server/README.md). Feel free to share your feedback and feature requests. We’re excited to hear from you and to keep making agents more accessible to everyone.

- [Codex](https://openai.com/news/?tags=codex)  
- [Codex](https://openai.com/news/?tags=codex)

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)
{% endraw %}
