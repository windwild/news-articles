---
title: "How Remote uses LangChain and LangGraph to onboard thousands of customers with AI"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-remote/"
date: "2026-01-19"
scraped_at: "2026-03-03T07:14:33.289770645+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
&#123;% raw %}

_Guest post written by José Mussa (Staff Software Engineer @ Remote)_

作者：José Mussa（Remote 公司高级软件工程师）

[Remote](https://remote.com/?ref=blog.langchain.com) 是一家快速发展的初创公司，致力于帮助企业在单一平台上完成全球范围内的员工招聘、管理与薪酬发放。Remote 的客户业务遍及众多国家及监管辖区，并将 Remote 视为其员工信息、薪资数据及合规数据的权威记录系统（system of record）。每位新客户接入时，都会带来一套独特的 HR 与薪资数据——有时是成百上千个电子表格，或是体积庞大的 SQL 导出文件。能否准确、高效地迁移这些数据，直接决定了客户成功上线（onboarding）的成败；而纯人工操作显然无法规模化。

为应对这一挑战，Remote 在其 AI 服务中构建了一个“代码执行智能体”（Code Execution Agent），用以自动化此类数据迁移任务。该智能体融合了大语言模型（LLM）的强大推理能力与确定性代码执行的精准性。下文将介绍其实现原理、Remote 为何选择 LangChain 与 LangGraph 构建该系统，以及开发过程中的关键经验与收获。

## The Challenge: Context windows and hallucinations

## 挑战：上下文窗口限制与幻觉问题

大语言模型能力强大，但存在硬性约束。每种模型都有其“上下文窗口”（context window）——即单次可处理的最大 token 数量。即便是 GPT‑5 这类当前最先进的模型，其上下文窗口上限也仅约 40 万 tokens，远低于一份大型薪资电子表格所含的数百万字符。此外，模型还需在上下文窗口中预留空间用于承载指令、系统提示词（system prompts）及对话历史。

试图将一个 50 MB 的 Excel 文件直接输入 LLM，不仅成本高昂，更极有可能引发“幻觉”（hallucination）。正如 Anthropic 工程师所指出的：当智能体直接调用工具时，每个中间结果都需经由模型流转，单次调用即可引入数万个 tokens，甚至轻易超出上下文容量上限。

对于 Remote 这样一家面向全球雇佣场景的平台而言，数据准确性与合规性不容妥协。上述限制清晰表明：必须采用一种截然不同的方法，方能支撑大规模数据迁移任务。

## The Solution: Let the models reason, let code execute

## 解决方案：让模型专注推理，让代码负责执行

Remote 的代码执行智能体将“思考”（reasoning）与“执行”（doing）明确分离。它并不强迫 LLM 直接吞入全部原始数据，而是借助 LangChain 的工具调用（tool-calling）接口，由模型决策应采取哪些步骤；随后自动生成并运行真实的 Python 代码，完成数据转换任务。

Anthropic 关于代码执行的研究揭示了这种混合架构为何行之有效：通过在沙箱环境中运行代码，工具定义与中间计算结果均保留在模型上下文窗口之外；仅有指令与摘要信息流经模型本身。此举大幅削减了 token 消耗，几乎彻底消除了幻觉风险。

Here's how Remote’s agent works in practice:

Remote 的代理在实际中是如何运作的：

- File ingestion. Customers upload their raw data (CSV, Excel or SQL exports) to Remote’s secure storage.  
- 文件摄入：客户将原始数据（CSV、Excel 或 SQL 导出文件）上传至 Remote 的安全存储。

- Agent reasoning. Using LangChain’s tool‑calling, the agent receives a task like “Convert this file into Remote’s employee onboarding schema.” It maps out how to translate the input columns into the schema.  
- 代理推理：利用 LangChain 的工具调用（tool-calling）能力，代理接收类似“将此文件转换为 Remote 员工入职数据模式”的任务，并规划如何将输入列映射到目标模式。

- Sandboxed execution. Behind the scenes, a Python sandbox (running in WebAssembly) executes the LLM‑generated code. Remote leans on libraries like Pandas because they're fast and flexible for data analysis.  
- 沙箱化执行：后台运行一个基于 WebAssembly 的 Python 沙箱，执行由大语言模型（LLM）生成的代码。Remote 依赖 Pandas 等库，因其在数据分析任务中兼具高性能与高灵活性。

- Iterative refinement. The agent reviews the output, writes more code if needed, and repeats until the data meets the schema.  
- 迭代优化：代理检查输出结果；若未达标，则生成新代码并重复执行，直至数据完全符合目标模式。

- Structured output. The final, validated JSON file is stored for ingestion. Large intermediate results never pass back to the model, keeping the context small.  
- 结构化输出：最终经验证的 JSON 文件被持久化保存，供后续数据摄入使用。所有大型中间结果均不回传至模型，从而严格控制上下文长度。

This architecture started as a proof of concept where Remote fed a 5,000-row Excel file into the agent. The agent loaded the file in the sandbox, mapped each entry to the schema using Pandas, and could answer queries like "What is the age of employee X?" by running code instead of generating text. Remote also limits console output so the model doesn't try to read entire datasets – a simple "show the first N rows" pattern borrowed straight from data science notebooks.

该架构最初是一个概念验证：Remote 将一个含 5,000 行数据的 Excel 文件输入代理。代理在沙箱中加载该文件，借助 Pandas 将每一项条目映射至目标模式，并能通过执行代码（而非文本生成）回答诸如“员工 X 的年龄是多少？”之类的问题。Remote 还限制了控制台输出量，防止模型试图读取整个数据集——这一设计直接借鉴自数据科学笔记本中常用的“显示前 N 行”（`show the first N rows`）模式。

## Why LangChain and LangGraph

## 为何选择 LangChain 和 LangGraph

Remote chose LangChain because its ecosystem offers mature abstractions for prompt handling and tool invocation. Its modular design allowed the team to integrate multiple model providers and build on a standard interface instead of rolling out their own. The Remote AI Agent Toolkit (the open‑source package Remote publishes for partners) already uses LangChain to expose HR tasks as structured tools, so keeping the internal workflows consistent was a natural fit. LangChain gave Remote the foundation to focus on what matters most for them: safety, scalability, and developer experience.

Remote 之所以选择 LangChain，是因为其生态体系为提示词管理与工具调用提供了成熟抽象层。其模块化设计使团队得以灵活集成多家大模型提供商，并基于统一标准接口开发，而无需从零构建自有框架。Remote 面向合作伙伴发布的开源工具包——Remote AI Agent Toolkit——已采用 LangChain 将人力资源相关任务封装为结构化工具；因此，在内部工作流中延续 LangChain 也顺理成章。LangChain 为 Remote 奠定了坚实基础，使其可专注于自身最关切的三大核心：安全性、可扩展性与开发者体验。

Its node-and-edge model lets Remote represent complex workflows— ingestion, mapping, execution, validation— as a directed graph. Each step becomes a node with explicit transitions for success, failure, or retry. This makes the agent's state transparent and recoverable, similar to how distributed systems engineers reason about pipelines. LangGraph's focus on long-running, stateful agents was a perfect match for our multi-step migration process.

LangGraph 的节点-边（node-and-edge）建模方式，使 Remote 能将复杂的端到端工作流——包括数据摄入、字段映射、代码执行与结果校验——表达为一张有向图。每个步骤对应一个节点，并明确定义成功、失败或重试等状态转移路径。这使得代理的状态清晰可见且具备故障恢复能力，其设计思路与分布式系统工程师对数据流水线（pipeline）的建模逻辑高度一致。LangGraph 对长时运行、有状态代理的深度支持，恰好契合 Remote 多阶段数据迁移流程的实际需求。

## Results and impact

## 成果与影响

By combining LLM reasoning with deterministic code execution, Remote has turned a manual process into an automated workflow. Their onboarding teams no longer write custom scripts for each customer – they simply plug data into the Code Execution Agent. The agent transforms diverse formats into a consistent JSON schema in hours instead of days.

通过融合大语言模型的推理能力与确定性的代码执行能力，Remote 已将原本依赖人工操作的流程升级为全自动工作流。其入职团队不再需要为每位客户单独编写定制脚本，只需将数据接入“代码执行代理”（Code Execution Agent）即可。该代理可在数小时内，而非数天内，将格式各异的原始数据统一转换为标准化的 JSON 模式。

Beyond speed, the system has made everything more reliable. Because the transformation logic runs as code in a sandbox, it's repeatable and auditable, which is critical for a platform handling sensitive employment and payroll data across jurisdictions. The LLM guides the process, but the actual data manipulation happens with trusted Python libraries, completely sidestepping hallucination issues.

除显著提速外，整套系统还大幅提升了可靠性。由于所有数据转换逻辑均以代码形式在沙箱中运行，因而具备可复现性与可审计性——这对一个需跨司法辖区处理敏感雇员及薪资数据的平台而言至关重要。大语言模型仅负责引导流程方向，而真实的数据处理则交由经过充分验证的 Python 库完成，彻底规避了模型幻觉（hallucination）风险。

## Lessons learned

## 经验总结

Building this AI agent taught Remote several lessons that now inform how its team builds AI systems across the company:

构建这一 AI 智能体，为 Remote 带来了若干重要经验，这些经验如今正指导其团队在整个公司范围内构建 AI 系统：

- LLMs are planners, not processors. Use them to reason about tasks and choose tools, but offload heavy data processing to code.  
- 大语言模型（LLM）是“规划者”，而非“执行器”。应利用它们进行任务推理与工具选择，而将繁重的数据处理工作交由代码完成。

- Structure beats improvisation. Orchestrating workflows as graphs makes them much easier to debug and extend.  
- 结构化优于即兴发挥。以图结构编排工作流，可显著提升调试与扩展的便利性。

- Context tokens are precious. Large intermediate results should stay in the execution environment where they belong.  
- 上下文 token 极其宝贵。大型中间结果应保留在其所属的执行环境中，避免不必要的 token 开销。

- Python remains the analytics workhorse. Libraries like Pandas offer fast, flexible data manipulation that's hard to beat.  
- Python 仍是数据分析领域的主力语言。Pandas 等库提供了快速、灵活的数据操作能力，目前尚难被其他方案超越。

## What’s next

## 下一步计划

The Code Execution Agent is one building block in Remote’s broader AI platform. Whenever they spot a repetitive pattern across teams, like converting documents into structured records or extracting data from semi-structured forms, they abstract it into a reusable agent. A recent example is an Agentic OCR-to-JSON Schema prototype, which combines document parsing with an agentic workflow to outperform basic OCR by a wide margin.

代码执行智能体（Code Execution Agent）是 Remote 整体 AI 平台中的一个基础构件。每当他们在跨团队协作中发现重复性模式——例如将文档转换为结构化记录，或从半结构化表单中提取数据——便会将其抽象为可复用的智能体。近期的一个实例是“智能体驱动的 OCR 到 JSON Schema”原型系统：该系统融合文档解析能力与智能体工作流，性能远超传统基础 OCR 方案。

As Remote refines these tools, the team is planning to contribute generic improvements back to LangChain's open-source ecosystem and adopt new community innovations as they emerge.

随着 Remote 对这些工具的持续打磨，团队计划将通用性改进回馈至 LangChain 的开源生态，并在社区新成果涌现时及时采纳。

## Final thoughts

## 总结思考

Migrating HR data is one of the toughest parts of onboarding thousands of customers in a global employment platform. By pairing LangChain’s tool framework with LangGraph’s orchestration and a Python code‑execution layer, Remote built a system that handles complex transformations reliably and at scale. This hybrid approach of using LLMs for reasoning and code for execution reflects how Remote invests in AI as infrastructure: removing friction while enabling teams to focus on higher-level problems that help customers employ and pay anyone, anywhere.

在全球化雇佣平台中，迁移人力资源（HR）数据是为成千上万客户完成入驻流程中最艰巨的任务之一。Remote 将 LangChain 的工具框架、LangGraph 的流程编排能力与 Python 代码执行层相结合，构建出一套可稳定、规模化处理复杂数据转换的系统。这种“用大语言模型进行推理、用代码执行任务”的混合范式，体现了 Remote 将 AI 视为基础设施的战略投入：在消除使用摩擦的同时，赋能各团队专注于更高层次的问题——助力客户随时随地雇佣并支付全球任何地方的员工。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith，通过 AI 智能体重塑客户体验](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_002.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith，通过 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_003.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_004.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_005.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_005.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How Bertelsmann Built a Multi-Agent System to Empower Creatives](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_006.png)](https://blog.langchain.com/customer-bertelsmann/)

[![贝塔斯曼如何构建多智能体系统以赋能创意人员](images/how-remote-uses-langchain-and-langgraph-to-onboard-thousands-of-customers-with-a/img_006.png)](https://blog.langchain.com/customer-bertelsmann/)

[**How Bertelsmann Built a Multi-Agent System to Empower Creatives**](https://blog.langchain.com/customer-bertelsmann/)

[**贝塔斯曼如何构建多智能体系统以赋能创意人员**](https://blog.langchain.com/customer-bertelsmann/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 6 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：6 分钟
&#123;% endraw %}
