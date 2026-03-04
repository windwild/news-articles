---
title: "Model Context Protocol (MCP) explained: An FAQ - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/model-context-protocol-mcp-explained"
date: "2025-07-25"
scraped_at: "2026-03-02T09:30:49.708208405+00:00"
language: "en-zh"
translated: true
description: "Model Context Protocol (MCP) is a new spec that helps standardize the way large language models (LLMs) access data and systems, extending what they can do beyond their training data. "
---
{% raw %}

Jul 25, 2025

2025年7月25日

[Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction) 是一种帮助标准化大语言模型（LLM）访问数据与系统的新方法，从而拓展其能力边界，使其不再局限于训练数据。它规范了开发者向模型与智能体（agents）暴露数据源、工具及上下文的方式，支持安全、可预测的交互，并充当 AI 与各类应用之间的通用连接器。

开发者无需为每个 AI 平台单独构建定制化集成，而只需一次构建 MCP 服务器，即可在任意地方复用。

## What is MCP?

## 什么是 MCP？

MCP 将 AI 模型（如 Claude、GPT-4 等）与外部工具和系统连接起来。这些系统可以是您应用的 API、产品数据库、代码库，甚至桌面环境。

MCP 让您能以结构化方式暴露这些能力，使模型可以理解并调用。MCP 并非一个库或 SDK，而是一项规范（spec）——就像 REST 或 GraphQL 那样，但专为 AI 智能体设计。

模型仍依赖自身训练所得的知识与推理能力，但现在可通过 MCP 服务器接入专用工具，弥补知识空白。当模型触及自身理解的极限时，它可调用真实函数、获取真实数据，并严格遵循您设定的安全边界，而非凭空编造答案（即避免“幻觉”）。

因此，当模型需要查询库存水位时，它并非凭空猜测，而是直接调用您真实的库存系统；它所获取的文档也并非 [上次网络爬虫抓取的版本](https://vercel.com/blog/the-rise-of-the-ai-crawler)，而是您 15 分钟前刚刚合并至生产环境的最新版本。

## Why would I want to create an MCP server?

## 我为什么要创建一个 MCP 服务器？

若您希望赋予 AI 模型对您的应用或服务的受控访问权限，就应创建一个 MCP 服务器。这可能意味着允许模型下单、获取用户数据、写入文件，或执行搜索等操作。

It’s about extending AI capabilities by giving it useful access to your systems in a safe way. Instead of hoping the model understands your API docs, you define exactly what it can do and how.

这关乎通过以安全的方式赋予 AI 对您系统中有用的访问权限，从而扩展其能力。与其寄希望于模型能理解您的 API 文档，不如明确界定它能够执行哪些操作、以及如何执行。

## Should I build my own MCP server or create tools directly in my app?

## 我该自行构建 MCP 服务器，还是直接在应用中创建工具？

If you’re building something for just your app or a single AI provider, you can define your tools directly in the LLM call. It’s simpler, faster, and gives you full control over execution.

如果您仅为自己的应用或某一家 AI 服务商构建功能，则可直接在大语言模型（LLM）调用中定义工具。这种方式更简单、更快速，且让您对执行过程拥有完全控制权。

MCP adds another layer: your tools are hosted outside your app, on a separate server. When you make a call to the LLM, you first connect to the MCP server, provide context to the model, then invoke the MCP server with the model’s chosen input for execution.

MCP 增加了一层抽象：您的工具托管在应用之外的一台独立服务器上。当您调用 LLM 时，需先连接至 MCP 服务器，向模型提供上下文信息，再将模型选定的输入传递给 MCP 服务器执行。

MCP servers make sense when you want your context and tools to be shared across many apps, models, or environments.

当您希望上下文与工具能在多个应用、多种模型或不同环境中共享时，采用 MCP 服务器才真正有意义。

## What’s the difference between MCP server tools and an API?

## MCP 服务器工具与 API 有何区别？

An API is made for apps to call directly. A developer writes a request, sends it to a known endpoint, and gets back a predictable response. It’s built for humans and programs that know exactly what they’re doing and when they want to do it.

API 是为应用程序直接调用而设计的。开发者编写请求，发送至已知端点，并获得可预期的响应。它面向的是清楚自身目标及执行时机的人类开发者和程序。

An MCP server is made for models. It provides metadata and structured descriptions that help the model understand which tools are available, what they do, and when to use them. Unlike APIs that need hard-coded calls, models use this context to figure out what to do.

MCP 服务器则是为模型而设计的。它提供元数据与结构化描述，帮助模型理解有哪些可用工具、各工具的功能是什么、以及何时应调用它们。与需要硬编码调用的 API 不同，模型依靠此类上下文自主推断应执行的操作。

You probably already have APIs, internal tools, and databases. An MCP server makes all of that accessible to AI in a standardized way. Write the integration once. Any MCP-compatible agent can use it. No custom logic for each model. No vendor lock-in.

您很可能已拥有各类 API、内部工具和数据库。MCP 服务器则以标准化方式将所有这些资源开放给 AI 使用：只需编写一次集成逻辑，任何兼容 MCP 的智能体均可调用；无需为每个模型重复开发定制逻辑，也无厂商锁定风险。

## What’s the easiest way to create an MCP server?

## 创建 MCP 服务器最简单的方法是什么？

The [AI SDK has built-in support for MCP](https://v5.ai-sdk.dev/cookbook/node/mcp-tools) and lets you quickly define functions and tools.

[AI SDK 内置支持 MCP](https://v5.ai-sdk.dev/cookbook/node/mcp-tools)，可助您快速定义函数与工具。

You can also use our [mcp-handler](https://vercel.com/changelog/mcp-server-support-on-vercel), an open source SDK to easily expose an MCP server to a Next.js, Nuxt, and Svelte app. It’s lightweight, requires only a few lines of code, and works with most frameworks.

您还可使用我们的开源 SDK [mcp-handler](https://vercel.com/changelog/mcp-server-support-on-vercel)，轻松将 MCP 服务器接入 Next.js、Nuxt 或 Svelte 应用。它轻量简洁，仅需数行代码，且兼容绝大多数前端框架。

Either way, you don’t need to understand every detail of the MCP spec. You define what the model can do and what it has access to, and the MCP server handles the rest. The abstractions AI SDK and mcp-handler provide make creating an MCP server in a few hours (or less) possible ( [we added an MCP server to Grep in an afternoon](https://vercel.com/blog/grep-a-million-github-repositories-via-mcp-1H5Bmvo4XKswf0TpZIOmEI#from-zero-to-mcp-in-minutes)).

无论采用哪种方式，您都无需深入理解 MCP 规范的每个细节。您只需声明模型“能做什么”以及“可访问哪些资源”，其余工作均由 MCP 服务器自动完成。AI SDK 与 mcp-handler 提供的抽象层，使得在数小时（甚至更短时间）内搭建一个 MCP 服务器成为可能（[我们曾在一个下午就为 Grep 添加了 MCP 服务器](https://vercel.com/blog/grep-a-million-github-repositories-via-mcp-1H5Bmvo4XKswf0TpZIOmEI#from-zero-to-mcp-in-minutes)）。

[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)

[**基于 Next.js 的 MCP 服务器**\\
\\
立即开始，在 Vercel 上构建您的首个 MCP 服务器。\\
\\
立即部署](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)

## How do I use an MCP server?

## 如何使用 MCP 服务器？

You connect a client, like your model or AI host (e.g. Claude or Cursor), to a MCP server. That connection allows the client to list capabilities that the server exposes, what input they take, and what output they return.

您将客户端（例如您的大语言模型或 AI 运行环境，如 Claude 或 Cursor）连接至 MCP 服务器。该连接使客户端能够枚举服务器所暴露的能力、各能力所需的输入参数，以及其返回的输出格式。

The model sees that, plans its calls, and sends requests when the server is needed. It’s like giving the model a toolbox it can pick from, and it picks the right tool based on the prompt. You don’t need to manage this. The model reads the MCP spec and decides what to use.

模型由此获知可用能力，自主规划调用逻辑，并在需要时向服务器发起请求。这就像为模型配备了一个工具箱，它可根据提示词（prompt）从中选择最合适的工具。您无需手动管理这一过程——模型会直接解析 MCP 规范，并自主决定调用哪个能力。

![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_001.jpg)![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_002.jpg)

![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_001.jpg)![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_002.jpg)

## How does MCP work for tools?

## MCP 如何支持工具（Tools）？

At a high level, an MCP server exposes a list of tools to the model in a machine-readable format (usually JSON). Each tool has a name, description, input schema, and output schema. This is called the tool manifest.

从宏观角度看，MCP 服务器以机器可读格式（通常为 JSON）向模型公开一份工具列表。每个工具均包含名称（name）、描述（description）、输入模式（input schema）和输出模式（output schema）。该清单称为“工具清单（tool manifest）”。

When the model sees this manifest, it can plan a sequence of actions by calling those tools, one at a time or in a loop, depending on the goal.

当模型看到此清单（manifest）时，它可根据目标逐个调用这些工具，或以循环方式调用，从而规划出一系列操作步骤。

Each tool call is a normal HTTP request (or other transport) from the model to the MCP server. The server runs the tool logic and returns a response, which the model can then use to decide what to do next.

每次工具调用都是一次标准的 HTTP 请求（或其他传输方式），由模型发起、发送至 MCP 服务器；服务器执行对应工具逻辑，并返回响应结果；模型再依据该响应决定下一步操作。

At its core, MCP treats requests like function calls. The model plans the next step. The server runs the tool and returns a result. That cycle continues until the task is done.

MCP 的核心机制将请求视作函数调用：模型负责规划下一步操作；服务器执行工具并返回结果；该“规划–执行–反馈”循环持续进行，直至任务完成。

![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_003.jpg)![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_004.jpg)![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_005.jpg)![](images/model-context-protocol-mcp-explained-an-faq-vercel/img_006.jpg)

## What are the "transports" of MCP?

## MCP 的“传输方式（transports）”是什么？

Transports are how the model talks to your MCP server. Today, StreamableHTTP is the main one. The model uses standard HTTP to hit a URL and create a connection. Optionally, it also allows the use of Server-Sent Events (SSE) on the side for real time notifications.

传输方式（transports）定义了模型与您的 MCP 服务器之间的通信机制。目前，StreamableHTTP 是主流方案：模型通过标准 HTTP 协议向指定 URL 发起请求以建立连接；此外，还可选择启用服务端推送事件（Server-Sent Events, SSE），实现实时通知。

The other popular transport is stdio, used in local or command line interface (CLI) environments where the model and tools share the same process.

另一种常用传输方式是 `stdio`，适用于本地环境或命令行界面（CLI）场景，此时模型与工具运行于同一进程内，通过标准输入/输出（stdin/stdout）进行通信。

Transport choice depends on the kind of interaction: one-off call vs stream of actions.

传输方式的选择取决于交互类型：是单次调用（one-off call），还是连续动作流（stream of actions）。

Packages like [mcp-handler](https://vercel.com/changelog/mcp-server-support-on-vercel) support many transports, so it’s easy to switch or support more than one.

诸如 [`mcp-handler`](https://vercel.com/changelog/mcp-server-support-on-vercel) 等软件包支持多种传输方式，因此可轻松切换或同时兼容多种传输协议。

## What is the difference between an AI agent and an MCP server?

## AI 智能体（AI agent）与 MCP 服务器有何区别？

An AI agent is the model (client or system using the model) that plans and takes actions. An MCP server is the environment that defines what actions are possible. The agent decides what to do. The MCP server tells it how to do it.

AI 代理（AI agent）是指执行规划与采取行动的模型（即使用该模型的客户端或系统）。MCP 服务器（MCP server）则是定义了哪些操作可行的运行环境。代理决定“做什么”，而 MCP 服务器则告知它“如何做”。

Think of it like this:

可以这样类比：

- The chef decides what to make (AI agent)

- 主厨决定要制作什么（AI 代理）

- The kitchen determines what tools and ingredients are available (MCP server)

- 厨房决定了可用的工具和食材（MCP 服务器）

- The chef can only work with what the kitchen exposes

- 主厨只能使用厨房所提供的工具和食材

You need both. The agent figures out the intent. The MCP server makes sure it stays on track and uses approved tools. The server doesn’t take action. It just shows the model what’s possible.

二者缺一不可：代理负责理解用户意图；MCP 服务器则确保其行为始终在正轨上，并仅调用经批准的工具。服务器本身并不执行动作，它只是向模型揭示“哪些操作是可行的”。

## What’s the difference between a local and remote MCP server?

## 本地 MCP 服务器与远程 MCP 服务器有何区别？

The difference is where they run and how they talk to each other.

区别在于它们的部署位置以及彼此之间的通信方式。

A local MCP runs on the same machine or environment as the model. This is common in playgrounds, dev tools, prototyping, experimentation, or when developing both the model and MCP server locally on your machine. Local MCP servers are useful when you don’t want to expose data publicly. It’s fast and private.

本地 MCP 服务器与模型运行在同一台机器或同一环境中。这常见于交互式开发环境（playgrounds）、开发工具、原型设计、实验探索，或当你在本地同时开发模型与 MCP 服务器时。若你希望避免数据对外公开，本地 MCP 服务器尤为适用——它响应迅速且保障隐私。

A remote MCP runs on a server, separate from the AI models accessing it. This is how most production apps work. It lets models running on OpenAI, Claude, or your IDE reach your platform’s tools, allowing centralized and shared access.

远程 MCP 服务器则独立部署于一台专用服务器上，与调用它的 AI 模型（例如运行在 OpenAI、Claude 或你的 IDE 中的模型）物理分离。绝大多数生产级应用均采用此架构。它使各类外部模型均可安全接入你平台所提供的工具，从而实现工具能力的集中化管理与多模型共享访问。

You can start local while developing, then move to remote when you go live.

开发时可先在本地运行，上线时再切换至远程部署。

## What are use cases for MCP servers?

## MCP 服务器有哪些典型应用场景？

MCP servers are useful anywhere you want a model to interact with real systems safely and predictably.

只要您希望大模型能够安全、可靠地与真实系统交互，MCP 服务器就大有用武之地。

- For e-commerce, that might mean exposing tools for product search, cart updates, order history, and checkout. A model can help users find items, manage carts, or even complete purchases

- 在电商领域，这可能意味着开放商品搜索、购物车更新、订单历史查询及结算等工具接口；大模型可协助用户查找商品、管理购物车，甚至完成下单支付。

- In finance, models can pull account balances, categorize transactions, or generate reports, while respecting permissions and limits

- 在金融领域，大模型可查询账户余额、对交易进行分类或生成报表，同时严格遵守权限控制与额度限制。

- Marketing can run audience queries, send outbound messages, or schedule campaigns using structured workflows

- 在营销领域，大模型可通过结构化工作流执行受众人群查询、发送外呼消息或安排营销活动。

There are also meta-use cases: MCP servers can help one AI agent coordinate with another, or manage tools inside AI-native apps.

此外还存在“元级”应用场景：MCP 服务器可协助一个 AI 智能体与其他智能体协同协作，或在原生 AI 应用中统一管理各类工具。

These are just a few examples. You’ll also see MCP used in customer support bots, logistics tracking, clinical assistant tools, and so much more. Any time you want a model to actually take action (search, update, book, create) MCP gives it structure and control.

以上仅是几个示例。您还将看到 MCP 被广泛应用于客服聊天机器人、物流追踪系统、临床辅助工具等诸多场景。只要您希望大模型真正执行操作（如搜索、更新、预订、创建），MCP 就能为其提供清晰的结构与可控的执行框架。

## How will MCP help everyday internet users?

## MCP 将如何惠及普通互联网用户？

They won’t see MCP directly. But they’ll notice smarter, more helpful AI features on the sites and apps they use. Instead of chatbots giving vague or generic answers, they’ll get precise responses backed by real data.

普通用户不会直接看到 MCP，但他们将在日常使用的网站和应用中感受到更智能、更实用的 AI 功能：不再面对聊天机器人给出的模糊或泛泛而谈的回答，而是获得基于真实数据支撑的精准响应。

They’ll be able to do things and take actions on their behalf. Ask an AI to reschedule a meeting, and it actually moves the event, notifies attendees, and sends a confirmation. Say "Find me a blue dress for next month’s graduation," and it checks store inventory, considers shipping times, and places the order. Planning a trip? The AI books the flights instead of just listing websites.

它们将能够代表用户执行具体操作与任务。例如，要求 AI 重新安排一场会议，AI 就会真正调整日程、通知所有参会者，并发送确认信息；说一句“帮我找一条蓝色连衣裙，用于下个月的毕业典礼”，AI 就会查询各商店库存、评估物流时效，并直接下单；计划一次旅行？AI 将直接预订航班，而不仅仅是罗列相关网站链接。

For businesses, this means customers can do more through simple conversation. They don’t need to learn a new interface or app. The AI understands what they mean and handles the rest.

对企业而言，这意味着客户仅通过自然对话就能完成更多操作——无需学习新界面或下载新应用。AI 能准确理解用户意图，并代为完成后续全部流程。

## **Are MCP servers secure?**

## **MCP 服务器安全吗？**

Yes, but it depends on how you build them. MCP servers don’t bypass your existing auth or logic. They only expose what you choose. The model can only see and use the tools you define. If a tool requires user auth, you can enforce that just like any other API.

是的，但安全性取决于你如何构建它们。MCP 服务器不会绕过你已有的身份认证机制或业务逻辑，仅暴露你主动选择开放的功能。模型只能看到并调用你明确定义的工具；若某工具需用户身份验证，你可像保护其他 API 那样对其施加同等认证要求。

MCP is about surfacing capabilities, not giving blanket access. And since you control the logic behind each tool, you can put in checks, rate limits, logging, and more. The model can't do anything outside what you allow.

MCP 的核心在于“能力显化”（surfacing capabilities），而非授予无差别访问权限。由于每个工具背后的逻辑均由你完全掌控，因此你可以灵活加入访问校验、速率限制、操作日志等安全机制。模型所能执行的操作，严格限定在你明确授权的范围内。

The [mcp-handler supports](https://github.com/vercel/mcp-adapter?tab=readme-ov-file#authorization) the [MCP Authorization Specification](https://modelcontextprotocol.io/specification/draft/basic/authorization). This allows you to protect your MCP endpoints and access authentication information in your tools.

[mcp-handler 支持](https://github.com/vercel/mcp-adapter?tab=readme-ov-file#authorization) [MCP 授权规范（MCP Authorization Specification）](https://modelcontextprotocol.io/specification/draft/basic/authorization)，使你能对 MCP 端点实施保护，并在自定义工具中获取和使用身份认证相关信息。

## Who created and supports MCP? Is it open or closed sourced?

## 谁创建并支持 MCP？它是开源还是闭源项目？

MCP was created by [Anthropic](https://www.anthropic.com/) and released as open source under the MIT license. Everything lives on GitHub, including the spec, SDKs, and example implementations.

MCP 由 [Anthropic](https://www.anthropic.com/) 创建，并以 MIT 许可证形式开源发布。全部内容（包括协议规范、SDK 及示例实现）均托管于 GitHub 平台。

Now it's a growing community project. [Zed](https://zed.dev/) uses it for coding tools. [Sourcegraph](https://sourcegraph.com/) uses it for code search and navigation. Independent developers have built servers for things like smart homes and research tools.

如今，MCP 已发展为一个蓬勃成长的社区驱动型项目：[Zed](https://zed.dev/) 将其用于编程辅助工具；[Sourcegraph](https://sourcegraph.com/) 将其应用于代码搜索与导航；独立开发者则基于它构建了智能家居控制、科研辅助等各类服务器。

There is no formal committee, but a core maintainer group and a community. People discuss ideas in public and improve the protocol through real use. This keeps it focused on what actually works.

MCP 并无正式管理委员会，而是由一组核心维护者与广大社区共同推动。大家在公开场合讨论构想，并通过真实场景中的持续实践不断优化协议——这确保了 MCP 始终聚焦于切实可行、真正有效的解决方案。

The AI SDK and v0 both support the MCP spec out of the box.

AI SDK 和 v0 均开箱即用地支持 MCP 规范。

## What are the alternatives to MCP?

## MCP 的替代方案有哪些？

There are a few other ways to connect AI models to tools, depending on your needs.

根据您的具体需求，还有其他几种将 AI 模型与工具连接起来的方式。

**Simple Language Open Protocol (SLOP)** uses plain HTTP endpoints that accept natural language. It’s easy to set up, but puts more work on the AI to figure things out at runtime. For simple use cases, that tradeoff can make sense.

**简单语言开放协议（Simple Language Open Protocol，SLOP）** 使用接受自然语言的普通 HTTP 端点。它易于搭建，但会将更多运行时推理工作交由 AI 完成。对于简单应用场景，这种权衡是合理的。

**Platform-specific solutions**, like OpenAI’s function calling, are tightly integrated into their own ecosystems. They offer good performance and tools that "just work," but you have to rebuild for each platform. That can lead to vendor lock-in.

**平台专属解决方案**（例如 OpenAI 的函数调用功能）与其自有生态深度集成，提供出色的性能和“开箱即用”的工具；但您需为每个平台单独重构实现，这可能导致供应商锁定（vendor lock-in）。

**Orchestration frameworks**, like LangChain, help manage workflows across multiple LLMs and tools. These often support MCP and can be used together.

**编排框架**（如 LangChain）有助于跨多个大语言模型（LLM）和工具管理工作流。这类框架通常原生支持 MCP，可与 MCP 协同使用。

Choose the tool based on what you’re building:

请根据您正在构建的内容选择合适的工具：

- For quick experiments, SLOP is fast  
- 快速实验时，SLOP 上手最快  

- For deep integration with one provider, platform tools make sense  
- 若需与某一家服务商深度集成，平台专属工具更为合适  

- For complex workflows, orchestration frameworks help  
- 若涉及复杂工作流，编排框架可提供有力支持

However, for using one tool setup across many AIs, with clear structure and security, MCP is the right fit for most.

然而，若需在多个 AI 系统间复用同一套工具配置，并兼顾清晰的架构与安全性，MCP 正是大多数场景下的理想选择。

## Why MCP matters

## 为何 MCP 至关重要

MCP changes how we think about AI integration. Instead of building one-off solutions for each platform, developers can create tools that work across the entire ecosystem.

MCP 彻底改变了我们对 AI 集成的认知方式。开发者不再需要为每个平台单独构建定制化解决方案，而是可以开发一次、通用于整个 AI 生态系统的工具。

This is similar to how the web evolved. Early websites needed browser-specific code. Then standards like HTTP and REST made the web more consistent and powerful. MCP brings that kind of structure to AI.

这类似于万维网的发展历程：早期网站需编写针对不同浏览器的专用代码；随后，HTTP 和 REST 等标准的出现，使 Web 变得更加统一且强大。MCP 正是为 AI 带来了这样一种标准化结构。

For developers, the integration cost is low. You already have APIs and systems that do useful things. MCP gives you a standard way to make those tools available to AI. As more platforms adopt it, the value of a single integration grows.

对开发者而言，集成成本极低。您已拥有大量具备实用功能的 API 和系统；MCP 为您提供了一种标准化方式，将这些现有工具开放给 AI 使用。随着越来越多平台采纳 MCP，单次集成所带来的价值将持续增长。

The most exciting part is what this unlocks. When AI can take action, not just give suggestions, new kinds of apps become possible. The line between knowing and doing gets thinner.

最令人振奋的是它所释放的可能性：当 AI 不仅能提供建议，更能自主执行操作时，全新形态的应用便应运而生。“知”与“行”之间的界限由此日益模糊。

For example, [we recently added an MCP server to Grep](https://vercel.com/blog/grep-a-million-github-repositories-via-mcp), our fast code search app. It already had APIs, but by adding an MCP server, you can now integrate [Grep](https://grep.app/) into tools like Cursor and Claude Code. AI agents can now reference coding patterns and solutions used in over one million open source projects to solve problems and answer questions in building your app.

例如，我们最近为快速代码搜索应用 [Grep](https://vercel.com/blog/grep-a-million-github-repositories-via-mcp) 添加了 MCP 服务器。该应用原本已具备完善的 API，而通过引入 MCP 服务器，现在即可将 [Grep](https://grep.app/) 无缝集成至 Cursor、Claude Code 等开发工具中。AI 智能体如今能够参考超过一百万个开源项目中实际使用的编码模式与解决方案，从而更高效地协助您构建应用、解决问题并回答技术问题。

_Thanks to MCP co-creator,_ [_David Soria Parra_](https://x.com/dsp_) _, for reviewing the post and providing feedback._

感谢 MCP 联合创始人 [_David Soria Parra_](https://x.com/dsp_) 对本文的审阅与宝贵反馈。
{% endraw %}
