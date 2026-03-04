---
render_with_liquid: false
title: "Anyone can build agents, but it takes a platform to run them - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/anyone-can-build-agents-but-it-takes-a-platform-to-run-them"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.900059187+00:00"
language: "en-zh"
translated: true
description: "Why competitive advantage in AI comes from the platform you deploy agents on, not the agents themselves."
---
render_with_liquid: false
render_with_liquid: false

Feb 9, 2026

2026年2月9日

Prototyping is democratized, but production deployment isn't.

原型开发已实现大众化，但生产部署尚未实现。

AI models have commoditized code and agent generation, making it possible for anyone to build sophisticated software in minutes. Claude can scaffold a fully functional agent before your morning coffee gets cold. But that same AI will happily architect a $5,000/month DevOps setup when the system could run efficiently at $500/month.

AI 模型已使代码编写与智能体（agent）生成趋于商品化，使得任何人都能在几分钟内构建出功能复杂的软件。Claude 甚至能在你早晨咖啡还没凉透之前，就为你搭建好一个完全可用的智能体。但同一个 AI 却会欣然为你设计一套每月成本高达 5000 美元的 DevOps 架构——而实际上，该系统完全可以在每月仅 500 美元的成本下高效运行。

In a world where anyone can build internal tools and agents, the build vs. buy equation has fundamentally changed. Competitive advantage no longer comes from whether you can build. It comes from rapid iteration on AI that solves real problems for your business and, more importantly, reliably operating those systems at scale.

在一个任何人都能快速构建内部工具与智能体的世界里，“自研 vs. 采购”的权衡逻辑已发生根本性转变。企业的竞争优势，不再取决于“你能否构建”，而在于能否围绕真正解决业务实际问题的 AI 进行快速迭代；更重要的是，能否在大规模场景下稳定、可靠地运行这些系统。

To do that, companies need an internal AI stack as robust as their external product infrastructure. That's exactly what Vercel's agent orchestration platform provides.

要实现这一点，企业需要一套与面向外部产品的基础设施同样稳健的内部 AI 技术栈。这正是 Vercel 的智能体编排平台所提供的能力。

![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_001.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_002.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_003.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_004.jpg)Building agents is becoming easier, but running them reliably requires robust production operations underneath.

![构建智能体正变得越来越容易，但要可靠地运行它们，则需要底层稳健的生产运维能力。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_001.jpg)![构建智能体正变得越来越容易，但要可靠地运行它们，则需要底层稳健的生产运维能力。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_002.jpg)![构建智能体正变得越来越容易，但要可靠地运行它们，则需要底层稳健的生产运维能力。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_003.jpg)![构建智能体正变得越来越容易，但要可靠地运行它们，则需要底层稳健的生产运维能力。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_004.jpg)构建智能体正变得越来越容易，但要可靠地运行它们，则需要底层稳健的生产运维能力。

## Build vs. buy ROI has fundamentally changed

## “自研 vs. 采购”的投资回报率逻辑已发生根本性转变

For decades, the economics of custom internal tools only made sense at large-scale companies. The upfront engineering investment was high, but the real cost was long-term operation with high SLAs and measurable ROI. For everyone else, buying off-the-shelf software was the practical option.

几十年来，定制化内部工具的经济性仅对大型企业成立：前期工程投入高昂，但真正的成本在于长期运维——需满足高服务水平协议（SLA），并产生可衡量的投资回报（ROI）。对其他企业而言，采购现成软件才是务实之选。

AI has fundamentally changed this equation. Companies of any size can now create agents quickly, and customization delivers immediate ROI for specialized workflows:

AI 已从根本上改变了这一逻辑。如今，无论规模大小，任何企业都能快速创建智能体；而针对特定业务流程的定制化，更能立即带来可观的投资回报：

- OpenAI deployed an [internal data agent](https://openai.com/index/inside-our-in-house-data-agent/) to democratize analytics  
- OpenAI 部署了一款[内部数据智能体](https://openai.com/index/inside-our-in-house-data-agent/)，以推动数据分析能力的普及

- Vercel 的[潜在客户筛选智能体](https://www.businessinsider.com/ai-agent-entry-level-sales-jobs-vercel-2025-10)可帮助一名销售开发代表（SDR）完成原本需 10 人承担的工作（模板见[此处](https://vercel.com/templates/ai/lead-processing-agent)）

- Stripe 构建了一款面向客户的[财务影响计算器](https://vercel.com/blog/how-stripe-built-a-game-changing-app-in-a-single-flight-with-v0)（就在一次航班上！）

如今，问题已不再是“自建还是采购”，答案是“既要自建，也要自主运行”。企业不能再将内部系统与外部供应商割裂开来，而亟需一个统一平台，以应对智能体（agent）工作负载所提出的独特需求。

### 每一家企业都需要自己的内部 AI 技术栈

面向内部应用与智能体的用例数量正呈爆发式增长；但问题在于：投入生产仍十分困难。

“氛围编程”（vibe coding）已催生出历史上规模最大的影子 IT（shadow IT）问题之一；而要真正理解并管理生产环境的运维，还需掌握安全、可观测性、可靠性及成本优化等多方面专业知识。尽管构建智能体正变得越来越容易，这些关键能力却依然稀缺。

对智能体而言，终极挑战并非如何构建它，而在于它所依托运行的平台。

## 平台即产品：我们的数据智能体如何在 Vercel 上运行

![d0 借助 Vercel 的智能体编排平台，每日可靠、安全地回答数百个问题。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_005.jpg)  
![d0 借助 Vercel 的智能体编排平台，每日可靠、安全地回答数百个问题。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_006.jpg)  
![d0 借助 Vercel 的智能体编排平台，每日可靠、安全地回答数百个问题。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_007.jpg)  
![d0 借助 Vercel 的智能体编排平台，每日可靠、安全地回答数百个问题。](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_008.jpg)  
d0 借助 Vercel 的智能体编排平台，每日可靠、安全地回答数百个问题。

与 OpenAI 类似，我们也自主研发了内部数据智能体——d0（开源模板见[此处](https://vercel.com/templates/ai/oss-data-analyst-agent-reference-architecture)）。其核心是一个文本转 SQL（text-to-SQL）引擎，这一概念本身并不新鲜；真正使其成为成功产品的，是其底层所依赖的平台。

Using Vercel’s built-in primitives and deployment infrastructure, one person built d0 in a few weeks using 20% of their time.

借助 Vercel 内置的原语（primitives）和部署基础设施，一位工程师仅用其 20% 的工作时间，便在几周内构建出了 d0。

This was only possible because Sandboxes, Fluid compute and AI Gateway automatically handled the operational complexity that would have normally taken months of engineering effort to scaffold and secure.

这之所以成为可能，是因为 Sandboxes、Fluid Compute 和 AI Gateway 自动处理了原本需要数月工程投入才能搭建并加固的运维复杂性。

Today, d0 has completely democratized data access that was previously limited to professional analysts. Engineers, marketers, and executives can all ask questions in natural language and get immediate, accurate answers from our data warehouse.

如今，d0 彻底实现了数据访问的民主化——此前，这类能力仅限于专业数据分析师使用。工程师、营销人员和高管均可使用自然语言提问，并即时获得来自我们数据仓库的准确答案。

Here’s how it works:

其工作原理如下：

- **A user asks a question in Slack:** "What was our Enterprise ARR last quarter?" d0 receives the message, determines the right level of data access based on the permissions of the user, and starts the agent workflow.

- **用户在 Slack 中提问：**“上一季度我们的企业级年度经常性收入（Enterprise ARR）是多少？”d0 接收到该消息后，依据用户权限确定对应的数据访问级别，并启动智能体（agent）工作流。

- **The agent explores a semantic layer:** The semantic layer is a file system of 5 layers of YAML-based configs that describe our data warehouse, our metrics, our products, and our operations.

- **智能体探索语义层：** 语义层是一个由 5 层基于 YAML 的配置文件构成的文件系统，用于描述我们的数据仓库、指标体系、产品结构及运营逻辑。

- **AI SDK handles the model calls:** Streaming responses, tool use, and structured outputs all work out of the box. We didn't build custom LLM plumbing, we used the same abstractions any Vercel developer can use.

- **AI SDK 处理模型调用：** 流式响应、工具调用与结构化输出均开箱即用。我们并未自行构建定制化的 LLM 底层管道（plumbing），而是直接复用了任何 Vercel 开发者均可使用的同一套抽象接口。

- **Agent steps are orchestrated durably:** If a step fails (Snowflake timeout, model hiccup), Vercel Workflows handles retries and state recovery automatically.

- **智能体各步骤被持久化编排：** 若某一步骤失败（例如 Snowflake 超时或模型异常），Vercel Workflows 将自动执行重试与状态恢复。

- **Automated actions are executed in isolation**: File exploration, SQL generation, and query execution all happen in a secure Vercel Sandbox. Runaway operations can't escape, and the agent can execute arbitrary Python for advanced analysis.

- **自动化操作在隔离环境中执行：** 文件探索、SQL 生成与查询执行全部在安全的 Vercel Sandbox 中完成。失控的操作无法逃逸出沙箱环境；同时，智能体可运行任意 Python 代码以支持高级分析。

- **Multiple models are used to balance cost and accuracy**: AI Gateway routes simple requests to fast models and complex analysis to Claude Opus, all in one code base.

- **多模型协同以兼顾成本与精度：** AI Gateway 在同一套代码中，将简单请求路由至响应迅速的模型，而将复杂分析任务交由 Claude Opus 处理。

- **The answer arrives in Slack:** formatted results, often with a chart or Google Sheet link, are delivered back to the Slack using the AI SDK Chatbot primitive.

- **答案通过 Slack 返回：** 格式化后的结果（通常包含图表或 Google 表格链接）将借助 AI SDK 的 Chatbot 原语，直接推送回 Slack。

## Vercel is the platform for agents

## Vercel 是面向智能体（Agent）的平台

Vercel provides the infrastructure primitives purpose-built for agent workloads, both internal and customer-facing. You build the agent, Vercel runs it. And it just works.

Vercel 提供专为智能体工作负载（包括内部使用与面向客户场景）而设计的基础设施原语。您负责构建智能体，Vercel 负责运行——开箱即用，稳定可靠。

Using our own agent orchestration platform has enabled us to build and manage an increasing number of custom agents.

借助我们自研的智能体编排平台，我们得以持续构建并高效管理越来越多的定制化智能体。

Internally, we run:

内部部署运行的智能体包括：

- A lead qualification agent

- 一条线索筛选智能体

- d0, our analytics agent

- d0 —— 我们的分析型智能体

- A customer support agent (handles 87% percent of initial questions)

- 一位客户服务智能体（可处理 87% 的初始咨询问题）

- An abuse detection agent that flags risky content

- 一个滥用行为检测智能体（用于标记高风险内容）

- A content agent that turns Slack threads into draft blog posts.

- 一个内容生成智能体（可将 Slack 对话线程自动转化为博文初稿）

On the product side:

在产品层面：

- v0 is a code generation agent, and

- v0 是一个代码生成智能体，而

- Vercel Agent can review pull requests, analyze incidents, and recommend actions.

- Vercel Agent 可以审查 Pull Request、分析事故，并推荐应对操作。

Both products run on the same primitives as our internal tools.

这两款产品均基于与我们内部工具相同的底层原语构建。

[**Sandboxes**](https://vercel.com/docs/vercel-sandbox) give agents a secure, isolated environment for executing sensitive autonomous actions. This is critical for protecting your core systems. When agents generate and run untested code or face prompt injection attacks, sandboxes contain the damage within isolated Linux VMs. When agents need filesystem access for information discovery, sandboxes can dynamically mount VMs with secure access to the right resources.

[**沙盒（Sandboxes）**](https://vercel.com/docs/vercel-sandbox) 为智能体提供安全、隔离的运行环境，以执行敏感的自主操作。这对于保护您的核心系统至关重要。当智能体生成并运行未经测试的代码，或遭遇提示注入（prompt injection）攻击时，沙盒可将潜在损害限制在隔离的 Linux 虚拟机内。当智能体需要访问文件系统以进行信息探索时，沙盒可动态挂载虚拟机，并为其安全地提供对相应资源的访问权限。

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();



await sandbox.runCommand({

6  cmd: 'node',

6  cmd: 'node',

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

8  stdout: process.stdout,

8  stdout: process.stdout,

9});



9});



await sandbox.stop();
```

await sandbox.stop();
```

[**Fluid compute**](https://vercel.com/docs/fluid-compute) automatically handles the unpredictable, long-running compute patterns that agents create. It’s easy to ignore compute when agents are processing text, but when usage scales and you add data-heavy workloads for files, images, and video, cost becomes an issue quickly. Fluid compute automatically scales up and down based on demand, and you're only charged for compute time, keeping costs low and predictable.

[**流式计算（Fluid compute）**](https://vercel.com/docs/fluid-compute) 可自动应对智能体（agents）所产生的不可预测、长时间运行的计算模式。当智能体仅处理文本时，计算资源开销往往容易被忽视；但随着使用规模扩大，并引入面向文件、图像和视频等数据密集型任务时，成本问题便会迅速凸显。流式计算可根据实际需求自动弹性伸缩，且您仅需为实际使用的计算时间付费，从而确保成本低廉且可预测。

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_009.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_010.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_011.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_012.jpg)

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_009.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_010.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_011.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_012.jpg)

[**AI Gateway**](https://vercel.com/docs/ai-gateway) gives you unified access to hundreds of models with built-in budget control, usage monitoring, and load balancing across providers. This is important for avoiding vendor lock-in and getting instant access to the latest models. When your agent needs to handle different types of queries, AI Gateway can route simple requests to fast, inexpensive models while sending complex analysis to more capable ones. If your primary provider hits rate limits or goes down, traffic automatically fails over to backup providers.

[**AI 网关（AI Gateway）**](https://vercel.com/docs/ai-gateway) 为您提供统一接入数百种大模型的能力，并内置预算管控、用量监控及跨供应商的负载均衡功能。这对于避免厂商锁定（vendor lock-in）以及即时获取最新模型至关重要。当您的智能体需处理多种类型的查询时，AI 网关可将简单请求路由至快速、低成本的模型，而将复杂分析任务交由能力更强的模型执行。若主用服务商遭遇调用频率限制或服务中断，流量将自动切换至备用服务商。  

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_013.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_014.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_015.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_016.jpg)

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_013.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_014.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_015.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_016.jpg)

[**Workflows**](https://useworkflow.dev/) give agents the ability to perform complex, multi-step operations reliably. When agents are used for critical business processes, failures are costly. Durable orchestration provides retry logic and error handling at every step so that interruptions don't require manual intervention or restart the entire operation.

[**工作流（Workflows）**](https://useworkflow.dev/) 使智能体（agents）能够可靠地执行复杂、多步骤的操作。当智能体被用于关键业务流程时，任何失败都可能带来高昂代价。持久化编排（Durable orchestration）在每一步都提供重试逻辑与错误处理机制，确保运行中断无需人工干预，也无需从头重启整个操作。

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_017.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_018.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_019.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_020.jpg)

[**Observability**](https://vercel.com/docs/observability/insights) reveals what agents are actually doing beyond basic system metrics. This data is essential for debugging unexpected behavior and optimizing agent performance. When your agent makes unexpected decisions, consumes more tokens than expected, or underperforms, observability shows you the exact prompts, model responses, and decision paths, letting you trace issues back to specific model calls or data sources.

[**可观测性（Observability）**](https://vercel.com/docs/observability/insights) 超越基础系统指标，真实呈现智能体的实际运行行为。这类数据对于调试异常行为、优化智能体性能至关重要。当你的智能体做出意外决策、消耗的 token 数量超出预期，或整体表现欠佳时，可观测性功能将清晰展示所使用的精确提示词（prompts）、模型响应内容以及决策路径，助你精准定位问题根源——无论是某次特定的模型调用，还是某个数据源。

## Build your agents, Vercel will run them

## 构建你的智能体，Vercel 为你运行它们

In the future, every enterprise will build their version of d0. And their internal code review agent. And their customer support routing agent. And hundreds of other specialized tools.

未来，每一家企业都将构建属于自己的 d0 版本；构建内部代码审查智能体；构建客户支持路由智能体；以及数百种其他专业化的工具。

The success of these agents depends on the platform that runs them. Companies who invest in their internal AI stack now will not only move faster, they'll experience far higher ROI as their advantages compound over time.

这些智能体的成功，取决于支撑其运行的平台。当下即开始投资构建内部 AI 技术栈的企业，不仅将获得更快的迭代速度，更将随着时间推移持续放大先发优势，从而实现远超同行的投资回报率（ROI）。