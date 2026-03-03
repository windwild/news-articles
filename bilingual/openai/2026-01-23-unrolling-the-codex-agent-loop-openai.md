---
title: "Unrolling the Codex agent loop | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/unrolling-the-codex-agent-loop"
date: "2026-01-23"
scraped_at: "2026-03-02T10:08:26.122875030+00:00"
language: "en-US"
translated: true
description: "A technical deep dive into the Codex agent loop, explaining how Codex CLI orchestrates models, tools, prompts, and performance using the Responses API."
tags: ["Engineering"]
---

January 23, 2026

2026年1月23日

# Unrolling the Codex agent loop

# 解构 Codex 智能体循环

By Michael Bolin, Member of the Technical Staff

作者：Michael Bolin，技术团队成员

[Codex CLI⁠(opens in a new window)](https://developers.openai.com/codex/cli) is our cross-platform local software agent, designed to produce high-quality, reliable software changes while operating safely and efficiently on your machine. We’ve learned a tremendous amount about how to build a world-class software agent [since we first launched the CLI in April⁠](https://openai.com/index/introducing-o3-and-o4-mini/). To unpack those insights, this is the first post in an ongoing series where we’ll explore various aspects of how Codex works, as well as hard-earned lessons. (For an even more granular view on how the Codex CLI is built, check out our open source repository at [https://github.com/openai/codex⁠(opens in a new window)](https://github.com/openai/codex). Many of the finer details of our design decisions are memorialized in GitHub issues and pull requests if you’d like to learn more.)

Codex CLI⁠（在新窗口中打开）是我们推出的跨平台本地软件智能体，旨在安全、高效地运行于您的设备之上，同时生成高质量、高可靠性的软件变更。自今年4月首次发布 CLI 以来，我们在构建世界级软件智能体方面积累了大量经验⁠（参见：https://openai.com/index/introducing-o3-and-o4-mini/）。为系统梳理这些洞见，本文是系列连载的第一篇，我们将深入探讨 Codex 的工作原理，并分享实践中淬炼出的关键经验。（若您希望更细致地了解 Codex CLI 的实现细节，欢迎访问我们的开源代码仓库：https://github.com/openai/codex⁠（在新窗口中打开）。许多设计决策的详细讨论均记录在 GitHub Issues 和 Pull Requests 中，供您进一步研读。）

To kick off, we’ll focus on the _agent loop_, which is the core logic in Codex CLI that is responsible for orchestrating the interaction between the user, the model, and the tools the model invokes to perform meaningful software work. We hope this post gives you a good view into the role our agent (or “harness”) plays in making use of an LLM.

作为开篇，我们将聚焦于 _智能体循环（agent loop）_ ——这是 Codex CLI 的核心逻辑，负责协调用户、大语言模型（LLM）以及模型所调用的各类工具之间的交互，从而完成真正有意义的软件开发任务。我们希望本文能帮助您清晰理解：我们的智能体（亦称“运行时框架”或 “harness”）在调用大语言模型过程中所扮演的关键角色。

Before we dive in, a quick note on terminology: at OpenAI, “Codex” encompasses a suite of software agent offerings, including Codex CLI, Codex Cloud, and the Codex VS Code extension. This post focuses on the Codex _harness_, which provides the core agent loop and execution logic that underlies all Codex experiences and is surfaced through the Codex CLI. For ease here, we’ll use the terms “Codex” and “Codex CLI” interchangeably.

在深入之前，先简要说明术语：“Codex” 在 OpenAI 指代一整套软件智能体产品组合，包括 Codex CLI、Codex Cloud 及 Codex VS Code 扩展。本文聚焦于 Codex _运行时框架（harness）_ ——它提供了支撑所有 Codex 体验的核心智能体循环与执行逻辑，并通过 Codex CLI 向用户呈现。为行文简洁起见，后文中我们将“Codex”与“Codex CLI”视作同义词交替使用。

## The agent loop

## 智能体循环

At the heart of every AI agent is something called “the agent loop.” A simplified illustration of the agent loop looks like this:

每个 AI 智能体的核心都存在一种被称为“智能体循环（agent loop）”的机制。其简化示意图如下所示：

![Diagram titled “Agent loop” illustrating how an AI system processes a user request, calls tools, observes results, updates its plan, and returns outputs. Arrows connect steps such as user input, model reasoning, tool actions, and final response.](images/unrolling-the-codex-agent-loop-openai/img_001.svg)

![标题为“智能体循环”的示意图，展示 AI 系统如何处理用户请求、调用工具、观察结果、更新计划并返回输出。箭头连接各步骤，包括用户输入、模型推理、工具操作及最终响应。](images/unrolling-the-codex-agent-loop-openai/img_001.svg)

To start, the agent takes _input_ from the user to include in the set of textual instructions it prepares for the model known as a _prompt_.

首先，智能体（agent）接收用户的 _输入（input）_，并将其纳入为模型准备的一组文本指令中，该指令集被称为 _提示（prompt）_。

The next step is to query the model by sending it our instructions and asking it to generate a response, a process known as _inference_. During inference, the textual prompt is first translated into a sequence of input [tokens⁠(opens in a new window)](https://platform.openai.com/docs/concepts#tokens)—integers that index into the model’s vocabulary. These tokens are then used to sample the model, producing a new sequence of output tokens.

下一步是向模型发起查询：将我们的指令发送给模型，并要求其生成响应，这一过程称为 _推理（inference）_。在推理过程中，文本提示首先被转换为一串输入 [token（在新窗口中打开）](https://platform.openai.com/docs/concepts#tokens)——即索引模型词表的整数。随后，这些 token 被用于对模型进行采样，从而生成一串新的输出 token。

The output tokens are translated back into text, which becomes the model’s response. Because tokens are produced incrementally, this translation can happen as the model runs, which is why many LLM-based applications display streaming output. In practice, inference is usually encapsulated behind an API that operates on text, abstracting away the details of tokenization.

输出 token 随后被重新转换为文本，构成模型的响应。由于 token 是逐步生成的，这种转换可在模型运行过程中实时完成，因此许多基于大语言模型（LLM）的应用程序支持流式（streaming）输出。在实际应用中，推理过程通常被封装在一个以文本为输入/输出的 API 之后，从而隐藏了分词（tokenization）等底层细节。

As the result of the inference step, the model either (1) produces a final response to the user’s original input, or (2) requests a _tool call_ that the agent is expected to perform (e.g., “run `ls` and report the output”). In the case of (2), the agent executes the tool call and appends its output to the original prompt. This output is used to generate a new input that’s used to re-query the model; the agent can then take this new information into account and try again.

推理步骤的结果有两种可能：（1）模型直接生成对用户原始输入的最终响应；或（2）模型请求一次 _工具调用（tool call）_，由智能体执行（例如：“运行 `ls` 命令并报告其输出”）。在情况（2）下，智能体执行该工具调用，并将执行结果追加到原始 prompt 末尾。该结果被用作生成新一轮输入的基础，进而再次向模型发起查询；智能体可据此新信息重新推理并尝试下一步操作。

This process repeats until the model stops emitting tool calls and instead produces a message for the user (referred to as an _assistant message_ in OpenAI models). In many cases, this message directly answers the user’s original request, but it may also be a follow-up question for the user.

该过程持续循环，直至模型停止发出工具调用，转而生成一条面向用户的响应消息（在 OpenAI 模型中称为 _助手消息（assistant message）_）。在多数情况下，该消息直接回答了用户的原始请求；但也可能是一条向用户提出的后续问题。

Because the agent can execute tool calls that modify the local environment, its “output” is not limited to the assistant message. In many cases, the primary output of a software agent is the code it writes or edits on your machine. Nevertheless, each turn always ends with an assistant message—such as “I added the `architecture.md` you asked for”—which signals a termination state in the agent loop. From the agent’s perspective, its work is complete and control returns to the user.

由于智能体能够执行修改本地环境的工具调用，其“输出”并不仅限于助手消息。在许多场景中，软件智能体的主要输出正是它在您机器上编写或编辑的代码。然而，每一次对话轮次（turn）都必然以一条助手消息收尾——例如：“我已添加您要求的 `architecture.md` 文件”——这标志着智能体循环（agent loop）进入终止状态。从智能体的角度看，其任务已经完成，控制权交还给用户。

The journey from _user input_ to _agent response_ shown in the diagram is referred to as one _turn_ of a conversation (a _thread_ in Codex). Though this _conversation turn_ can include many iterations between the **model inference** and **tool calls**. Every time you send a new message to an existing conversation, the conversation history is included as part of the prompt for the new turn, which includes the messages and tool calls from previous turns:

图中所示的从 _用户输入（user input）_ 到 _智能体响应（agent response）_ 的完整流程，称为一次对话的 _轮次（turn）_（在 Codex 中称为 _会话线程（thread）_）。尽管单次 _对话轮次_ 可能包含多次 **模型推理** 与 **工具调用** 之间的迭代。每当您向已有对话发送一条新消息时，整个对话历史（包括此前所有消息及工具调用）都会作为新轮次 prompt 的一部分被一并传入：

![Diagram titled “Multi-turn agent loop” showing how an AI agent iteratively takes user input, generates actions, consults tools, updates state, and returns results. Includes labeled steps, arrows, and example tool outputs illustrating the agent’s reasoning cycle.](images/unrolling-the-codex-agent-loop-openai/img_002.svg)

![标题为“多轮次智能体循环（Multi-turn agent loop）”的示意图，展示了人工智能智能体如何迭代式地接收用户输入、生成动作、调用工具、更新状态并返回结果。图中包含带标签的步骤、箭头以及示例性工具输出，用以阐释智能体的推理循环。](images/unrolling-the-codex-agent-loop-openai/img_002.svg)

This means that as the conversation grows, so does the length of the prompt used to sample the model. This length matters because every model has a _context window_, which is the maximum number of tokens it can use for one inference call. Note this window includes both input _and_ output tokens. As you might imagine, an agent could decide to make hundreds of tool calls in a single turn, potentially exhausting the context window. For this reason, _context window management_ is one of the agent’s many responsibilities. Now, let’s dive in to see how Codex runs the agent loop.

这意味着：随着对话不断延伸，用于模型采样的 prompt 长度也随之增长。该长度至关重要，因为每个模型都有一个 _上下文窗口（context window）_ ——即单次推理调用所能处理的最大 token 数量。请注意，该窗口同时涵盖输入 token 和输出 token。不难想象，智能体可能在单一轮次中发起数百次工具调用，从而迅速耗尽上下文窗口容量。正因如此，_上下文窗口管理（context window management）_ 成为智能体承担的诸多职责之一。接下来，让我们深入探究 Codex 是如何运行智能体循环的。

## Model inference

## 模型推理

The Codex CLI sends HTTP requests to the [Responses API⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses) to run model inference. We’ll examine how information flows through Codex, which uses the Responses API to drive the agent loop.

Codex CLI 通过向 [Responses API⁠（在新窗口中打开）](https://platform.openai.com/docs/api-reference/responses) 发送 HTTP 请求来执行模型推理。接下来，我们将分析信息在 Codex 中的流转过程——Codex 正是借助 Responses API 来驱动智能体（agent）循环的。

The Responses API endpoint that the Codex CLI uses is [configurable⁠(opens in a new window)](https://developers.openai.com/codex/config-advanced#custom-model-providers), so it can be used with any endpoint that [implements the Responses API⁠(opens in a new window)](https://www.openresponses.org/):

Codex CLI 所使用的 Responses API 端点是 [可配置的⁠（在新窗口中打开）](https://developers.openai.com/codex/config-advanced#custom-model-providers)，因此它可以与任何 [实现了 Responses API⁠（在新窗口中打开）](https://www.openresponses.org/) 的端点协同工作：

- [When using ChatGPT login⁠(opens in a new window)](https://github.com/openai/codex/blob/d886a8646cb8d3671c3029d08ae8f13fa6536899/codex-rs/core/src/model_provider_info.rs#L141) with the Codex CLI, it uses `https://chatgpt.com/backend-api/codex/responses` as the endpoint  
- 使用 Codex CLI 并通过 [ChatGPT 登录⁠（在新窗口中打开）](https://github.com/openai/codex/blob/d886a8646cb8d3671c3029d08ae8f13fa6536899/codex-rs/core/src/model_provider_info.rs#L141) 时，其端点为 `https://chatgpt.com/backend-api/codex/responses`

- [When using API-key authentication⁠(opens in a new window)](https://github.com/openai/codex/blob/d886a8646cb8d3671c3029d08ae8f13fa6536899/codex-rs/core/src/model_provider_info.rs#L143) with OpenAI hosted models, it uses `https://api.openai.com/v1/responses` as the endpoint  
- 使用 OpenAI 托管模型并配合 [API 密钥认证⁠（在新窗口中打开）](https://github.com/openai/codex/blob/d886a8646cb8d3671c3029d08ae8f13fa6536899/codex-rs/core/src/model_provider_info.rs#L143) 时，其端点为 `https://api.openai.com/v1/responses`

- When running Codex CLI with `--oss` to use [gpt-oss⁠](https://openai.com/index/introducing-gpt-oss/) with [ollama 0.13.4+⁠(opens in a new window)](https://github.com/openai/codex/pull/8798) or [LM Studio 0.3.39+⁠(opens in a new window)](https://lmstudio.ai/blog/openresponses), it defaults to `http://localhost:11434/v1/responses` running locally on your computer  
- 当使用 `--oss` 参数运行 Codex CLI，以配合 [gpt-oss⁠](https://openai.com/index/introducing-gpt-oss/) 及 [ollama 0.13.4+⁠（在新窗口中打开）](https://github.com/openai/codex/pull/8798) 或 [LM Studio 0.3.39+⁠（在新窗口中打开）](https://lmstudio.ai/blog/openresponses) 时，其默认端点为本地运行的 `http://localhost:11434/v1/responses`

- Codex CLI can be used with the Responses API hosted by a cloud provider such as Azure  
- Codex CLI 也可与由云服务提供商（例如 Azure）托管的 Responses API 配合使用

Let’s explore how Codex creates the prompt for the first inference call in a conversation.

下面我们来探讨 Codex 如何为一次对话中的首次推理调用构建提示（prompt）。

#### Building the initial prompt

#### 构建初始提示

As an end user, you don’t specify the prompt used to sample the model verbatim when you query the Responses API. Instead, you specify various input types as part of your query, and the Responses API server decides how to structure this information into a prompt that the model is designed to consume. You can think of the prompt as a “list of items”; this section will explain how your query gets transformed into that list.

作为终端用户，在调用 Responses API 时，您无需逐字指定用于模型采样的提示；相反，您只需在请求中提供多种类型的输入，而 Responses API 服务端会决定如何将这些信息组织成模型可接受的提示格式。您可以将提示理解为一个“条目列表”；本节将详细说明您的查询是如何被转换为该列表的。

In the initial prompt, every item in the list is associated with a role. The `role` indicates how much weight the associated content should have and is one of the following values (in decreasing order of priority): `system`, `developer`, `user`, `assistant`.

在初始提示中，列表中的每一项均关联一个 `role`（角色）。该角色表示对应内容在提示中的权重大小，取值为以下之一（按优先级从高到低排列）：`system`（系统）、`developer`（开发者）、`user`（用户）、`assistant`（助手）。

The [Responses API⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/create) takes a JSON payload with many parameters. We’ll focus on these three:

[Responses API⁠（在新窗口中打开）](https://platform.openai.com/docs/api-reference/responses/create) 接收一个包含多个参数的 JSON 负载。我们重点关注以下三个参数：

- [`instructions`⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/create#responses_create-instructions): system (or developer) message inserted into the model’s context  
- [`instructions`⁠（在新窗口中打开）](https://platform.openai.com/docs/api-reference/responses/create#responses_create-instructions)：插入模型上下文中的系统（或开发者）消息

- [`tools`⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/create#responses_create-tools): a list of tools the model may call while generating a response  
- [`tools`⁠（在新窗口中打开）](https://platform.openai.com/docs/api-reference/responses/create#responses_create-tools)：模型在生成响应过程中可能调用的工具列表

- [`input`⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/create#responses_create-input): a list of text, image, or file inputs to the model  
- [`input`⁠（在新窗口中打开）](https://platform.openai.com/docs/api-reference/responses/create#responses_create-input)：传入模型的文本、图像或文件输入列表

In Codex, the `instructions` field is read from the [`model_instructions_file`⁠(opens in a new window)](https://github.com/openai/codex/blob/338f2d634b2360ef3c899cac7e61a22c6b49c94f/codex-rs/core/src/config/mod.rs#L1474-L1483) in `~/.codex/config.toml`, if specified; otherwise, [the `base_instructions` associated with a model⁠(opens in a new window)](https://github.com/openai/codex/blob/338f2d634b2360ef3c899cac7e61a22c6b49c94f/codex-rs/core/src/codex.rs#L279-L288) are used. Model-specific instructions live in the Codex repo and are bundled into the CLI (e.g., [`gpt-5.2-codex_prompt.md`⁠(opens in a new window)](https://github.com/openai/codex/blob/e958d0337e98f6398771917867d7de689dab3b7a/codex-rs/core/gpt-5.2-codex_prompt.md)).

在 Codex 中，`instructions` 字段优先从 `~/.codex/config.toml` 文件中指定的 [`model_instructions_file`⁠（在新窗口中打开）](https://github.com/openai/codex/blob/338f2d634b2360ef3c899cac7e61a22c6b49c94f/codex-rs/core/src/config/mod.rs#L1474-L1483) 读取；若未指定，则使用 [与模型关联的 `base_instructions`⁠（在新窗口中打开）](https://github.com/openai/codex/blob/338f2d634b2360ef3c899cac7e61a22c6b49c94f/codex-rs/core/src/codex.rs#L279-L288)。模型专属的提示指令存于 Codex 代码仓库中，并随 CLI 一并打包发布（例如 [`gpt-5.2-codex_prompt.md`⁠（在新窗口中打开）](https://github.com/openai/codex/blob/e958d0337e98f6398771917867d7de689dab3b7a/codex-rs/core/gpt-5.2-codex_prompt.md)）。

The `tools` field is a list of tool definitions that conform to a schema defined by the Responses API. For Codex, this includes tools that are provided by the Codex CLI, tools that are provided by the Responses API that should be made available to Codex, as well as tools provided by the user, usually via MCP servers:

`tools` 字段是一个工具定义列表，这些定义需符合 Responses API 所定义的模式规范。对于 Codex 而言，该列表包括：由 Codex CLI 提供的工具、由 Responses API 提供且应向 Codex 开放的工具，以及通常通过 MCP 服务器提供的用户自定义工具：

#### JavaScript

#### JavaScript（JavaScript）

`1[\
\
2  // Codex's default shell tool for spawning new processes locally.\
\
3  {\
\
4    "type": "function",\
\
5    "name": "shell",\
\
6    "description": "Runs a shell command and returns its output...",\
\
7    "strict": false,\
\
8    "parameters": {\
\
9      "type": "object",\
\
10      "properties": {\
\
11        "command": {"type": "array", "description": "The command to execute", ...},\
\
12        "workdir": {"description": "The working directory...", ...},\
\
13        "timeout_ms": {"description": "The timeout for the command...", ...},\
\
14        ...\
\
15      },\
\
16      "required": ["command"],\
\
17    }\
\
18  }\
\
19\
\
20  // Codex's built-in plan tool.\
\
21  {\
\
22    "type": "function",\
\
23    "name": "update_plan",\
\
24    "description": "Updates the task plan...",\
\
25    "strict": false,\
\
26    "parameters": {\
\
27      "type": "object",\
\
28      "properties": {"plan":..., "explanation":...},\
\
29      "required": ["plan"]\
\
30    }\
\
31  },\
\
32\
\
33  // Web search tool provided by the Responses API.\
\
34  {\
\
35    "type": "web_search",\
\
36    "external_web_access": false\
\
37  },\
\
38\
\
39  // MCP server for getting weather as configured in the\
\
40  // user's ~/.codex/config.toml.\
\
41  {\
\
42    "type": "function",\
\
43    "name": "mcp__weather__get-forecast",\
\
44    "description": "Get weather alerts for a US state",\
\
45    "strict": false,\
\
46    "parameters": {\
\
47      "type": "object",\
\
48      "properties": {"latitude": {...}, "longitude": {...}},\
\
49      "required": ["latitude", "longitude"]\
\
50    }\
\
51  }\
\
52]`

`1[\
\
2  // Codex 默认的本地进程启动 shell 工具。\
\
3  {\
\
4    "type": "function",\
\
5    "name": "shell",\
\
6    "description": "执行 shell 命令并返回其输出……",\
\
7    "strict": false,\
\
8    "parameters": {\
\
9      "type": "object",\
\
10      "properties": {\
\
11        "command": {"type": "array", "description": "待执行的命令", ...},\
\
12        "workdir": {"description": "工作目录……", ...},\
\
13        "timeout_ms": {"description": "命令超时时间……", ...},\
\
14        ...\
\
15      },\
\
16      "required": ["command"],\
\
17    }\
\
18  }\
\
19\
\
20  // Codex 内置的任务计划更新工具。\
\
21  {\
\
22    "type": "function",\
\
23    "name": "update_plan",\
\
24    "description": "更新任务计划……",\
\
25    "strict": false,\
\
26    "parameters": {\
\
27      "type": "object",\
\
28      "properties": {"plan":..., "explanation":...},\
\
29      "required": ["plan"]\
\
30    }\
\
31  },\
\
32\
\
33  // Responses API 提供的网页搜索工具。\
\
34  {\
\
35    "type": "web_search",\
\
36    "external_web_access": false\
\
37  },\
\
38\
\
39  // 根据用户 ~/.codex/config.toml 中配置启用的天气查询 MCP 服务器。\
\
40  {\
\
41    "type": "function",\
\
42    "name": "mcp__weather__get-forecast",\
\
43    "description": "获取美国某州的天气预警信息",\
\
44    "strict": false,\
\
45    "parameters": {\
\
46      "type": "object",\
\
47      "properties": {"latitude": {...}, "longitude": {...}},\
\
48      "required": ["latitude", "longitude"]\
\
49    }\
\
50  }\
\
51]`

Finally, the `input` field of the JSON payload is a list of items. Codex [inserts the following items⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1387-L1415) into the `input` before adding the user message:

最后，JSON 有效载荷中的 `input` 字段是一个条目列表。Codex 会在添加用户消息**之前**，将以下条目[插入到 `input` 中⁠（在新窗口中打开）](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1387-L1415)：

1\. A message with `role=developer` that describes the sandbox that _applies only to the Codex-provided_ `shell` _tool_ defined in the `tools` section. That is, other tools, such as those provided from MCP servers, are not sandboxed by Codex and are responsible for enforcing their own guardrails.

1. 一条 `role=developer` 的消息，用于描述沙箱环境——该沙箱**仅适用于 `tools` 字段中由 Codex 提供的 `shell` 工具**。换言之，其他工具（例如由 MCP 服务器提供的工具）**不受 Codex 沙箱机制约束**，须自行实施并强制执行其自身的安全防护措施（guardrails）。

The message is built from a template where the key pieces of content come from snippets of Markdown bundled into the Codex CLI, such as [`workspace_write.md`⁠(opens in a new window)](https://github.com/openai/codex/blob/1fc72c647fd52e3e73d4309c3b568d4d5fe012b5/codex-rs/protocol/src/prompts/permissions/sandbox_mode/workspace_write.md) and [`on_request.md`⁠(opens in a new window)](https://github.com/openai/codex/blob/1fc72c647fd52e3e73d4309c3b568d4d5fe012b5/codex-rs/protocol/src/prompts/permissions/approval_policy/on_request.md):

该消息基于一个模板构建，其中关键内容片段源自打包进 Codex CLI 的 Markdown 文件，例如 [`workspace_write.md`⁠（在新窗口中打开）](https://github.com/openai/codex/blob/1fc72c647fd52e3e73d4309c3b568d4d5fe012b5/codex-rs/protocol/src/prompts/permissions/sandbox_mode/workspace_write.md) 和 [`on_request.md`⁠（在新窗口中打开）](https://github.com/openai/codex/blob/1fc72c647fd52e3e73d4309c3b568d4d5fe012b5/codex-rs/protocol/src/prompts/permissions/approval_policy/on_request.md)：

#### Plain Text

#### 纯文本

`1<permissions instructions>

2  - description of the sandbox explaining file permissions and network access`

`1<权限说明>

2  - 沙箱环境说明，解释文件访问权限与网络访问限制`

3  - instructions for when to ask the user for permissions to run a shell command

3  - 何时请求用户授权执行 Shell 命令的说明

4  - list of folders writable by Codex, if any

4  - Codex 具有写入权限的文件夹列表（如存在）

5</permissions instructions>

5</权限说明>

2\. (Optional) A message with `role=developer` whose contents are the `developer_instructions` value read from the user’s `config.toml` file.

2．（可选）一条 `role=developer` 消息，其内容为从用户的 `config.toml` 文件中读取的 `developer_instructions` 值。

3\. (Optional) A message with `role=user` whose contents are the “user instructions,” which are not sourced from a single file but are [aggregated across multiple sources⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/project_doc.rs#L37-L42). In general, more specific instructions appear later:

3．（可选）一条 `role=user` 消息，其内容为“用户指令”；这些指令并非源自单一文件，而是[从多个来源聚合而来⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/project_doc.rs#L37-L42)。通常，更具体的指令出现在靠后位置：

- Contents of `AGENTS.override.md` and `AGENTS.md` in `$CODEX_HOME`

- `$CODEX_HOME` 目录下的 `AGENTS.override.md` 和 `AGENTS.md` 文件内容

- Subject to a limit (32 KiB, by default), look in each folder from the Git/project root of the `cwd` (if it it exists) up to the `cwd` itself: add the contents of any of `AGENTS.override.md`, `AGENTS.md`, or any filename specified by `project_doc_fallback_filenames in config.toml`

- 在默认限制（32 KiB）范围内，遍历从当前工作目录 `cwd` 所在 Git/项目根目录（若存在）到 `cwd` 本身路径上的每个文件夹：添加其中任意一个 `AGENTS.override.md`、`AGENTS.md` 文件的内容，或添加 `config.toml` 中 `project_doc_fallback_filenames` 所指定的任意文件名对应文件的内容

- If any [skills⁠(opens in a new window)](https://developers.openai.com/codex/skills/) have been configured:

- 若已配置任何 [技能⁠(在新窗口中打开)](https://developers.openai.com/codex/skills/)：

  - a short preamble about skills

  - 一段关于技能的简短引言

  - the [skill metadata⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/skills/model.rs#L6-L13) for each skill

  - 每项技能的 [技能元数据⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/skills/model.rs#L6-L13)

  - a section on [how to use skills⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/skills/render.rs#L20)

  - 一个关于 [如何使用技能⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/skills/render.rs#L20) 的章节

4\. A message with `role=user` that describes the local environment in which the agent is currently operating. This [specifies the current working directory and the user’s shell⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/environment_context.rs#L51-L71):

4．一条 `role=user` 消息，用于描述代理当前运行的本地环境。该消息[明确指出当前工作目录及用户所用 Shell⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/environment_context.rs#L51-L71)：

#### Plain Text

#### 纯文本

`1<environment_context>

2  <cwd>/Users/mbolin/code/codex5</cwd>

2  <cwd>/Users/mbolin/code/codex5</cwd>

3  <shell>zsh</shell>

3  <shell>zsh</shell>

4</environment_context>

4</environment_context>

`

Once Codex has done all of the above computation to initialize the `input`, it appends the user message to start the conversation.

在 Codex 完成上述全部计算以初始化 `input` 后，它会将用户消息追加到其中，从而开启对话。

The previous examples focused on the content of each message, but note that each element of `input` is a JSON object with `type`, [`role`⁠(opens in a new window)](https://www.reddit.com/r/OpenAI/comments/1hgxcgi/what_is_the_purpose_of_the_new_developer_role_in/), and `content` as follows:

此前的示例聚焦于每条消息的内容，但请注意：`input` 中的每个元素均为一个 JSON 对象，包含 `type`、[`role`⁠（在新窗口中打开）](https://www.reddit.com/r/OpenAI/comments/1hgxcgi/what_is_the_purpose_of_the_new_developer_role_in/) 和 `content` 字段，结构如下：

#### JSON

#### JSON

`1{

`1{

2  "type": "message",

2  "type": "message",

3  "role": "user",  

3  "role": "user",

4  "content": [\
\
5    {\
\
6      "type": "input_text",\
\
7      "text": "Add an architecture diagram to the README.md"\
\
8    }\
\
9  ]

10}

`

当 Codex 构建完成要发送至 Responses API 的完整 JSON 负载后，便会发起一个 HTTP POST 请求，并附带一个 `Authorization` 头——该头的具体值取决于 `~/.codex/config.toml` 中 Responses API 端点的配置（若在配置中指定了额外的 HTTP 头或查询参数，则也会一并添加）。

当 OpenAI Responses API 服务器接收到该请求时，会依据传入的 JSON 数据推导出模型所需的 prompt，具体方式如下（需注意：若使用自定义实现的 Responses API，其 prompt 构造逻辑可能有所不同）：

![展示 AI agent 循环中单步执行过程的示意图。用户请求输入模型，模型输出一段思考（thought）、一个带工具名称的动作（action），以及对应的工具输入（tool input）。图中特别高亮了调用工具前这一中间推理步骤。](images/unrolling-the-codex-agent-loop-openai/img_003.svg)

如您所见，prompt 中前三项内容的顺序由服务器决定，而非客户端。但在这三项中，仅有 _system message_（系统消息）的具体内容也由服务器控制；而 `tools`（工具列表）和 `instructions`（指令）则均由客户端指定。随后，再将 JSON 负载中的 `input` 字段内容追加至 prompt 末尾，从而完成最终 prompt 的构造。

现在，我们已准备好 prompt，可以开始对模型进行采样（sampling）了。

#### 第一轮交互（The first turn）

此次发往 Responses API 的 HTTP 请求，标志着 Codex 中一次对话的首个“回合”（turn）正式启动。服务器将以服务端事件流（Server-Sent Events, [SSE⁠(在新窗口中打开)](https://en.wikipedia.org/wiki/Server-sent_events)）形式返回响应。每个事件的 `data` 字段均为一个 JSON 对象，其包含一个以 `"response"` 开头的 `"type"` 字段，例如以下形式（所有事件类型的完整列表请参阅我们的 [API 文档⁠(在新窗口中打开)](https://platform.openai.com/docs/api-reference/responses-streaming)）：

#### Plain Text

#### 纯文本

`1data: {"type":"response.reasoning_summary_text.delta","delta":"ah ", ...}

2data: {"type":"response.reasoning_summary_text.delta","delta":"ha!", ...}

3data: {"type":"response.reasoning_summary_text.done", "item_id":...}

4data: {"type":"response.output_item.added", "item":{...}}

5data: {"type":"response.output_text.delta", "delta":"forty-", ...}

6data: {"type":"response.output_text.delta", "delta":"two!", ...}

7data: {"type":"response.completed","response":{...}}`

Codex [consumes the stream of events⁠(opens in a new window)](https://github.com/openai/codex/blob/2a68b74b9bf16b64e285495c1b149d7d6ac8bdf4/codex-rs/codex-api/src/sse/responses.rs#L334-L342) and republishes them as internal event objects that can be used by a client. Events like `response.output_text.delta` are used to support streaming in the UI, whereas other events like `response.output_item.added` are transformed into objects that are appended to the `input` for subsequent Responses API calls.

Codex [消费事件流⁠（在新窗口中打开）](https://github.com/openai/codex/blob/2a68b74b9bf16b64e285495c1b149d7d6ac8bdf4/codex-rs/codex-api/src/sse/responses.rs#L334-L342)，并将其重新发布为客户端可使用的内部事件对象。例如 `response.output_text.delta` 这类事件用于支持用户界面中的流式输出，而 `response.output_item.added` 等其他事件则被转换为对象，并追加至后续 Responses API 调用的 `input` 中。

Suppose the first request to the Responses API includes two `response.output_item.done` events: one with `type=reasoning` and one with `type=function_call`. These events must be represented in the `input` field of the JSON when we query the model again with the response to the tool call:

假设向 Responses API 发出的首个请求中包含两个 `response.output_item.done` 事件：一个 `type=reasoning`，另一个 `type=function_call`。当我们将工具调用的响应再次提交给模型时，这两个事件必须体现在 JSON 的 `input` 字段中：

#### JavaScript

#### JavaScript（JavaScript 代码）

`1[\
\
2  /* ... original 5 items from the input array ... */\
\
3  {\
\
4    "type": "reasoning",\
\
5    "summary": [\
\
6      "type": "summary_text",\
\
7      "text": "**Adding an architecture diagram for README.md**\n\nI need to..."\
\
8    ],\
\
9    "encrypted_content": "gAAAAABpaDWNMxMeLw..."\
\
10  },\
\
11  {\
\
12    "type": "function_call",\
\
13    "name": "shell",\
\
14    "arguments": "{\"command\":\"cat README.md\",\"workdir\":\"/Users/mbolin/code/codex5\"}",\
\
15    "call_id": "call_8675309..."\
\
16  },\
\
17  {\
\
18    "type": "function_call_output",\
\
19    "call_id": "call_8675309...",\
\
20    "output": "<p align=\"center\"><code>npm i -g @openai/codex</code>..."\
\
21  }\
\
22]`

`1[\
\
2  /* …… 输入数组中原有的 5 个条目 …… */\
\
3  {\
\
4    "type": "reasoning",\
\
5    "summary": [\
\
6      "type": "summary_text",\
\
7      "text": "**为 README.md 添加架构图**\n\n我需要……"\
\
8    ],\
\
9    "encrypted_content": "gAAAAABpaDWNMxMeLw..."\
\
10  },\
\
11  {\
\
12    "type": "function_call",\
\
13    "name": "shell",\
\
14    "arguments": "{\"command\":\"cat README.md\",\"workdir\":\"/Users/mbolin/code/codex5\"}",\
\
15    "call_id": "call_8675309..."\
\
16  },\
\
17  {\
\
18    "type": "function_call_output",\
\
19    "call_id": "call_8675309...",\
\
20    "output": "<p align=\"center\"><code>npm i -g @openai/codex</code>..."\
\
21  }\
\
22]`

The resulting prompt used to sample the model as part of the subsequent query would look like this:

后续查询中用于采样模型的最终提示（prompt）将如下所示：

![Diagram labeled “Snapshot 2” showing an AI agent after a tool call. The model receives a tool observation and produces a new thought and action. Arrows connect inputs, observations, and outputs to illustrate how the agent iterates its reasoning loop.](images/unrolling-the-codex-agent-loop-openai/img_004.svg)

![标注为“Snapshot 2”的示意图：展示一次工具调用后 AI 智能体的状态。模型接收工具观测结果，并生成新的思考与动作。箭头连接输入、观测与输出，以说明智能体如何迭代其推理循环。](images/unrolling-the-codex-agent-loop-openai/img_004.svg)

In particular, note how the old prompt _is an exact prefix_ of the new prompt. This is intentional, as this makes subsequent requests much more efficient because it enables us to take advantage of _prompt caching_ (which we’ll discuss in the next section on performance).

尤其需要注意：旧提示 **恰好是新提示的前缀**。这是有意为之的设计，因为它可显著提升后续请求的效率——使我们得以利用 **提示缓存（prompt caching）**（我们将在下一节“性能”中进一步讨论）。

Looking back at our first diagram of the agent loop, we see that there could be many iterations between inference and tool calling. The prompt may continue to grow until we finally receive an assistant message, indicating the end of the turn:

回顾我们最初关于智能体循环的示意图，可见在模型推理与工具调用之间可能存在多次迭代。提示内容将持续增长，直至我们最终收到一条助手消息（assistant message），标志着本轮交互结束：

#### Plain Text

#### 纯文本

`1data: {"type":"response.output_text.done","text": "I added a diagram to explain...", ...}`

`1data: {"type":"response.output_text.done","text": "我添加了一张图表来说明……", ...}`

2data: {"type":"response.completed","response":{...}}

`  
在 Codex CLI 中，我们会将助手消息呈现给用户，并将焦点置于输入框（composer）上，以提示用户现在轮到他们继续对话。如果用户做出回应，则必须将上一轮的助手消息以及用户的新消息都追加到 Responses API 请求的 `input` 字段中，以开启新一轮对话：

#### JavaScript

`1[\
\
2  /* ... 上一次 Responses API 请求中的所有项 ... */\
\
3  {\
\
4    "type": "message",\
\
5    "role": "assistant",\
\
6    "content": [\
\
7      {\
\
8        "type": "output_text",\
\
9        "text": "I added a diagram to explain the client/server architecture."\
\
10      }\
\
11    ]\
\
12  },\
\
13  {\
\
14    "type": "message",\
\
15    "role": "user",\
\
16    "content": [\
\
17      {\
\
18        "type": "input_text",\
\
19        "text": "That's not bad, but the diagram is missing the bike shed."\
\
20      }\
\
21    ]\
\
22  }\
\
23]

`

由于我们是在持续进行多轮对话，因此每次发送给 Responses API 的 `input` 长度会不断增长：

![标注为“Snapshot 3”的示意图：展示 AI 智能体循环的最终阶段。模型在接收工具执行结果后，生成总结性思考，并向用户返回最终答案。箭头示意从工具输出到响应完成的流转过程。](images/unrolling-the-codex-agent-loop-openai/img_005.svg)

接下来，我们分析这种持续增长的提示（prompt）对性能的影响。

#### 性能考量

You might be asking yourself, “Wait, isn’t the agent loop _quadratic_ in terms of the amount of JSON sent to the Responses API over the course of the conversation?” And you would be right. While the Responses API does support an optional [`previous_response_id`⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/create#responses_create-previous_response_id) parameter to mitigate this issue, Codex does not use it today, primarily to keep requests fully stateless and to support Zero Data Retention (ZDR) configurations.

你或许会问自己：“等等，代理循环（agent loop）在整场对话中发送给 Responses API 的 JSON 数据量方面，难道不是呈_二次方_增长的吗？”你的质疑完全正确。尽管 Responses API 确实支持一个可选的 [`previous_response_id`⁠(在新窗口中打开)](https://platform.openai.com/docs/api-reference/responses/create#responses_create-previous_response_id) 参数来缓解这一问题，但 Codex 当前并未启用该参数——主要目的是确保所有请求完全无状态（stateless），并兼容零数据留存（Zero Data Retention, ZDR）配置。

Avoiding `previous_response_id` simplifies things for the provider of the Responses API because it ensures that every request is _stateless_. This also makes it straightforward to support customers who have opted into [Zero Data Retention (ZDR)⁠(opens in a new window)](https://platform.openai.com/docs/guides/migrate-to-responses#4-decide-when-to-use-statefulness), as storing the data required to support `previous_response_id` would be at odds with ZDR. Note that ZDR customers do not sacrifice the ability to benefit from proprietary reasoning messages from prior turns, as the associated `encrypted_content` can be decrypted on the server. (OpenAI persists a ZDR customer’s decryption key, but not their data.) See PRs [#642⁠(opens in a new window)](https://github.com/openai/codex/pull/642) and [#1641⁠(opens in a new window)](https://github.com/openai/codex/pull/1641) for the related changes to Codex to support ZDR.

避免使用 `previous_response_id` 简化了 Responses API 提供方的实现逻辑，因为它确保了每个请求都是_无状态的_。这也使得支持已选择启用[零数据留存（ZDR）⁠(在新窗口中打开)](https://platform.openai.com/docs/guides/migrate-to-responses#4-decide-when-to-use-statefulness)的客户变得轻而易举——因为若要支持 `previous_response_id`，就必须持久化存储相关上下文数据，而这与 ZDR 原则直接冲突。需注意的是，ZDR 客户并不会因此丧失复用先前轮次中专有推理消息（proprietary reasoning messages）的能力：与这些消息关联的 `encrypted_content` 仍可在服务端解密。（OpenAI 会持久化保存 ZDR 客户的解密密钥，但不会保存其原始数据。）有关 Codex 为支持 ZDR 所做的相关变更，请参阅 Pull Request [#642⁠(在新窗口中打开)](https://github.com/openai/codex/pull/642) 和 [#1641⁠(在新窗口中打开)](https://github.com/openai/codex/pull/1641)。

Generally, the cost of sampling the model dominates the cost of network traffic, making sampling the primary target of our efficiency efforts. This is why prompt caching is so important, as it enables us to reuse computation from a previous inference call. When we get cache hits, _sampling the model is linear rather than quadratic_. Our [prompt caching ⁠(opens in a new window)](https://platform.openai.com/docs/guides/prompt-caching#structuring-prompts) documentation explains this in more detail:

一般来说，模型采样（sampling）的开销远高于网络传输成本，因此模型采样成为我们性能优化工作的首要目标。正因如此，提示词缓存（prompt caching）至关重要——它使我们能够复用前一次推理调用中的计算结果。当发生缓存命中（cache hit）时，_模型采样的时间复杂度为线性而非二次方_。我们在[提示词缓存⁠(在新窗口中打开)](https://platform.openai.com/docs/guides/prompt-caching#structuring-prompts)文档中对此做了更详细的说明：

_Cache hits are only possible for exact prefix matches within a prompt. To realize caching benefits, place static content like instructions and examples at the beginning of your prompt, and put variable content, such as user-specific information, at the end. This also applies to images and tools, which must be identical between requests._

_缓存命中仅可能发生在提示词（prompt）中完全一致的前缀匹配场景下。为最大化缓存收益，应将静态内容（如指令和示例）置于提示词开头，而将可变内容（例如用户专属信息）置于末尾。该原则同样适用于图像和工具（tools）——它们在不同请求之间必须完全一致。_

With this in mind, let’s consider what types of operations could cause a “cache miss” in Codex:

基于上述理解，我们来分析一下哪些操作可能导致 Codex 中出现“缓存未命中（cache miss）”：

- Changing the `tools` available to the model in the middle of the conversation.  
  - 在对话中途更改模型可用的 `tools`。

- Changing the `model` that is the target of the Responses API request (in practice, this changes the third item in the original prompt, as it contains model-specific instructions).  
  - 更改 Responses API 请求所指向的 `model`（实践中，这会改变原始提示词中的第三项，因其包含特定于模型的指令）。

- Changing the sandbox configuration, approval mode, or current working directory.  
  - 更改沙箱配置、审批模式或当前工作目录。

The Codex team must be diligent when introducing new features in the Codex CLI that could compromise prompt caching. As an example, our initial support for MCP tools introduced a [bug where we failed to enumerate the tools in a consistent order⁠(opens in a new window)](https://github.com/openai/codex/pull/2611), causing cache misses. Note that MCP tools can be particularly tricky because MCP servers can change the list of tools they provide on the fly via a [`notifications/tools/list_changed`⁠(opens in a new window)](https://modelcontextprotocol.io/specification/2025-11-25/server/tools#list-changed-notification) notification. Honoring this notification in the middle of a long conversation can cause an expensive cache miss.

Codex 团队在向 Codex CLI 引入新功能时必须格外审慎，以防破坏提示词缓存机制。举例而言，我们最初对 MCP 工具的支持曾引入一个[缺陷：未能以一致顺序枚举工具⁠(在新窗口中打开)](https://github.com/openai/codex/pull/2611)，从而导致缓存未命中。值得注意的是，MCP 工具尤为棘手，因为 MCP 服务器可通过 [`notifications/tools/list_changed`⁠(在新窗口中打开)](https://modelcontextprotocol.io/specification/2025-11-25/server/tools#list-changed-notification) 通知动态实时更新其所提供的工具列表。若在一场长对话中途响应此通知，则可能引发代价高昂的缓存未命中。

When possible, we handle configuration changes that happen mid-conversation by appending a _new_ message to `input` to reflect the change rather than modifying an earlier message:

在可行的情况下，我们通过向 `input` 中_追加一条新消息_来处理对话中途发生的配置变更，而非修改已有消息：

- If the sandbox configuration or approval mode changes, we [insert⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1037-L1057) a new `role=developer` message with the same format as the original `<permissions instructions>` item.  
  - 若沙箱配置或审批模式发生变化，我们将[插入⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1037-L1057)一条新的 `role=developer` 消息，其格式与原始的 `<permissions instructions>` 条目保持一致。

- If the current working directory changes, we [insert⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1017-L1035) a new `role=user` message with the same format as the original `<environment_context>`.  
  - 若当前工作目录发生变化，我们将[插入⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L1017-L1035)一条新的 `role=user` 消息，其格式与原始的 `<environment_context>` 保持一致。

We go to great lengths to ensure cache hits for performance. There’s another key resource we have to manage: the context window.

为保障性能，我们竭尽全力确保缓存命中。此外，还有另一项关键资源亟待我们精细管理：上下文窗口（context window）。

Our general strategy to avoid running out of context window is to _compact_ the conversation once the number of tokens exceeds some threshold. Specifically, we replace the `input` with a new, smaller list of items that is representative of the conversation, enabling the agent to continue with an understanding of what has happened thus far. An early [implementation of compaction⁠(opens in a new window)](https://github.com/openai/codex/pull/1527) required the user to manually invoke the `/compact` command, which would query the Responses API using the existing conversation plus custom instructions for [summarization⁠(opens in a new window)](https://github.com/openai/codex/blob/e2c994e32a31415e87070bef28ed698968d2e549/SUMMARY.md). Codex used the resulting assistant message containing the summary [as the new `input`⁠(opens in a new window)](https://github.com/openai/codex/blob/e2c994e32a31415e87070bef28ed698968d2e549/codex-rs/core/src/codex.rs#L1424) for subsequent conversation turns.

为避免超出上下文窗口，我们的通用策略是在 token 数量超过某一阈值时对对话进行 _压缩（compaction）_。具体而言，我们将 `input` 替换为一个更小但能代表整段对话的新项目列表，从而使智能体在后续交互中仍能理解此前已发生的全部内容。早期的 [压缩功能实现⁠(在新窗口中打开)](https://github.com/openai/codex/pull/1527) 要求用户手动调用 `/compact` 命令；该命令会将当前对话连同自定义的[摘要生成指令⁠(在新窗口中打开)](https://github.com/openai/codex/blob/e2c994e32a31415e87070bef28ed698968d2e549/SUMMARY.md) 一并提交至 Responses API。Codex 随后将 API 返回的、包含摘要内容的助手消息[作为新的 `input`⁠(在新窗口中打开)](https://github.com/openai/codex/blob/e2c994e32a31415e87070bef28ed698968d2e549/codex-rs/core/src/codex.rs#L1424)，用于后续的对话轮次。

Since then, the Responses API has evolved to support a special [`/responses/compact` endpoint⁠(opens in a new window)](https://platform.openai.com/docs/guides/conversation-state#compaction-advanced) that performs compaction more efficiently. It returns [a list of items⁠(opens in a new window)](https://platform.openai.com/docs/api-reference/responses/compacted-object) that can be used in place of the previous `input` to continue the conversation while freeing up the context window. This list includes a special `type=compaction` item with an opaque `encrypted_content` item that preserves the model’s latent understanding of the original conversation. Now, Codex automatically uses this endpoint to compact the conversation when the [`auto_compact_limit`⁠(opens in a new window)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L2558-L2560) is exceeded.

此后，Responses API 进一步演进，新增了专用的 [`/responses/compact` 接口⁠(在新窗口中打开)](https://platform.openai.com/docs/guides/conversation-state#compaction-advanced)，可更高效地执行压缩操作。该接口返回[一个项目列表⁠(在新窗口中打开)](https://platform.openai.com/docs/api-reference/responses/compacted-object)，该列表可直接替代先前的 `input`，以延续对话并释放上下文窗口空间。此列表中包含一种特殊的 `type=compaction` 类型项目，其内含不透明的 `encrypted_content` 字段，用于保留模型对原始对话的潜在语义理解。如今，当达到 [`auto_compact_limit`⁠(在新窗口中打开)](https://github.com/openai/codex/blob/99f47d6e9a3546c14c43af99c7a58fa6bd130548/codex-rs/core/src/codex.rs#L2558-L2560) 阈值时，Codex 会自动调用该接口完成对话压缩。

## Coming next

## 下一步计划

We’ve introduced the Codex agent loop and walked through how Codex crafts and manages its context when querying a model. Along the way, we highlighted practical considerations and best practices that apply to anyone building an agent loop on top of the Responses API.

我们已介绍了 Codex 的智能体循环（agent loop），并详细阐述了 Codex 在调用模型时如何构建与管理上下文。在此过程中，我们重点指出了若干实践注意事项与最佳实践，这些原则适用于所有基于 Responses API 构建智能体循环的开发者。

While the agent loop provides the foundation for Codex, it’s only the beginning. In upcoming posts, we’ll dig into the CLI’s architecture, explore how tool use is implemented, and take a closer look at Codex’s sandboxing model.

尽管智能体循环构成了 Codex 的基础架构，但这仅仅是个开始。在后续文章中，我们将深入剖析 CLI 的整体架构，探讨工具调用（tool use）的具体实现方式，并更细致地解析 Codex 的沙箱（sandboxing）模型。

- [Codex](https://openai.com/news/?tags=codex)  
- [Codex](https://openai.com/news/?tags=codex)  

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)