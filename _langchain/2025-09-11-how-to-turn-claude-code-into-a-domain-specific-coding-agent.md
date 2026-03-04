---
render_with_liquid: false
title: "How to turn Claude Code into a domain specific coding agent"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-turn-claude-code-into-a-domain-specific-coding-agent/"
date: "2025-09-11"
scraped_at: "2026-03-03T07:28:07.666887288+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Authored by: [Aliyan Ishfaq](https://www.linkedin.com/in/aliyan-ishfaq/?ref=blog.langchain.com)

作者：[Aliyan Ishfaq](https://www.linkedin.com/in/aliyan-ishfaq/?ref=blog.langchain.com)

Coding agents are great at writing code that uses popular libraries on which LLMs have been heavily trained on. But point them to a custom library, a new version of a library, an internal API, or a niche framework – and they’re not so great. That’s a problem for teams working with domain specific libraries or enterprise code.

编码代理在编写调用主流库的代码方面表现出色——这些库正是大语言模型（LLM）训练时所大量接触的对象。但一旦让它们面对自定义库、新版本库、内部 API 或小众框架，其表现便大打折扣。这对使用领域专用库或企业级代码的团队而言，构成了切实挑战。

As developers of libraries (LangGraph, LangChain) we are really interested in how to get these coding agents to be really good at writing LangGraph and LangChain code. We tried a bunch of context engineering techniques. Some worked, some didn’t. In this blog post we will share the experiments we ran and learnings we had. Our biggest takeaway:

作为 LangGraph 和 LangChain 等开源库的开发者，我们尤为关注：如何让这些编码代理真正擅长编写 LangGraph 和 LangChain 相关代码？我们尝试了多种上下文工程（context engineering）技术，其中部分有效，部分则不然。本文将分享我们开展的实验及从中获得的经验与洞见。我们最重要的收获是：

**High quality, condensed information combined with tools to access more details as needed produced the best results**

**高质量、高度凝练的信息，辅以按需获取更详细内容的工具，能带来最佳效果。**

Giving the agent raw documentation access didn’t improve performance as much as we hoped. In fact, the context window filled up faster. A concise, structured guide in the form of `Claude.md` always outperformed simply wiring in documentation tools. The best results came from combining the two, where the agent has some base knowledge (via `Claude.md`) but can also access specific parts of the docs if it needs more info.

直接向代理开放原始文档并未如预期般显著提升性能；事实上，上下文窗口反而更快被填满。一份简洁、结构清晰的指南（以 `Claude.md` 文件形式提供）始终优于单纯接入文档检索工具。而最优效果，则来自二者的结合：代理既通过 `Claude.md` 掌握基础知识，又可在需要时按需查询具体文档片段。

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_001.png)

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_001.png)

In this post, we’ll share:

本文将分享以下内容：

- The different Claude Code configurations we tested  
- 我们测试过的多种 Claude Code 配置方案  
- The evaluation framework we used to to assess the generated code (a template you can reuse for your own libraries)  
- 我们用于评估生成代码的评测框架（含可复用于您自有库的模板）  
- Results and key takeaways  
- 实验结果与关键结论  

## **Claude Code Setups**

## **Claude Code 配置方案**

We tested four different configurations, using Claude 4 Sonnet as the model for consistency:

我们共测试了四种不同配置方案，为确保一致性，全部采用 Claude 4 Sonnet 作为底层模型：

**Claude Vanilla:** 开箱即用的 Claude Code，未经任何修改。

**Claude + MCP:** 与我们的 [MCPDoc](https://github.com/langchain-ai/mcpdoc?ref=blog.langchain.com) 服务器连接的 Claude Code，以支持文档访问。

**Claude + Claude.md:** 集成了详细 `Claude.md` 文件的 Claude Code，其中包含面向 LangGraph 的特定使用指南。

**Claude + MCP + Claude.md:** 同时具备详细 `Claude.md` 文件访问权限和 MCPDoc 服务器访问能力的 Claude。

### 用于文档检索的 MCP 工具

我们构建 MCPDoc 服务器，旨在为编程智能体（coding agents）提供任意第三方库的文档访问能力。它是一个开源的 MCP 服务器，对外暴露两个工具：`list_doc_sources` 和 `fetch_docs`。前者返回所有可用 `llms.txt` 文件的 URL 列表；后者则可读取指定的 `llms.txt` 文件内容。在我们的配置中，已接入 LangGraph 和 LangChain 的 Python 与 JavaScript 文档。您只需在 MCP 配置中传入您自己库所对应的 `llms.txt` 文件 URL，即可轻松适配至您的具体应用场景。

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_002.png)

### `Claude.md`

针对 `Claude.md`，我们编写了一份 LangGraph 库专项指南。该指南详述了常见 LangGraph 项目结构要求，例如：在创建新文件前必须先执行代码库搜索、正确的模块导出模式（export patterns），以及部署最佳实践等。指南还提供了构建单智能体与多智能体系统所需基础组件（primitives）的示例代码，包括 `create_react_agent`、监督者（supervisor）模式，以及支持动态任务交接的集群（swarm）模式等。此外，针对大语言模型在某些实现上表现欠佳的场景——例如流式响应（streaming）和面向终端用户的智能体中“人工介入”（human-in-the-loop）机制——我们也补充了大量实操性极强的指导建议。

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_003.png)

We found it particularly valuable to include comprehensive sections on common pitfalls and anti-patterns. This covered common mistakes like incorrect `interrupt()` usage, wrong state update patterns, type assumption errors, and overly complex implementations. These were mistakes we frequently saw LLMs make, either due to deprecated libraries or confusion with patterns from other frameworks.

我们特别认为，纳入关于常见陷阱与反模式的全面章节极具价值。这部分内容涵盖了诸多典型错误，例如对 `interrupt()` 方法的误用、不恰当的状态更新模式、类型假设错误，以及过度复杂的实现方式。这些错误我们经常在大语言模型（LLM）生成的代码中见到，其成因往往包括使用了已弃用的库，或混淆了其他框架中的设计模式。

We also included LangGraph-specific coding standards like structured output validation, proper message handling, and other framework integration debugging patterns. Since Claude has access to web tools, we added specific documentation URLs at the end of each section for further reference and navigation guidelines.

我们还纳入了 LangGraph 框架特有的编码规范，例如结构化输出校验、正确的消息处理方式，以及其他与框架集成相关的调试模式。由于 Claude 具备调用网络工具的能力，我们在每一章节末尾均附上了具体的官方文档 URL，以供进一步查阅和导航参考。

The way this file differs from `llms.txt` is that the former is a plain text file of all the content of a page with URLs while this includes condensed information that is most important when starting from scratch. As we'll see in the results, when `llms.txt` is passed alone, it is not most effective as it sometimes confuses LLMs with more context and no instructions on how to navigate and discern what's important.

本文件与 `llms.txt` 的区别在于：后者仅为包含全部网页内容（含 URL）的纯文本文件；而前者则提炼并浓缩了从零开始构建时最关键的信息。正如后续结果所示，若仅单独传入 `llms.txt`，其效果往往并不理想——因为过多的上下文信息反而可能使 LLM 陷入困惑，且该文件未提供任何关于如何导航内容、甄别重点信息的指引。

Before going into how our Claude Code configurations performed across different tasks, we want to share our evaluation framework that we used to determine task fulfillment and code quality.

在深入分析我们的 Claude Code 配置在不同任务上的表现之前，我们希望先介绍用于评估任务完成度与代码质量的评测框架。

## **Evaluations**

## **评测标准**

Our goal was to measure what contributes most to code quality, not just functionality. Popular metrics like Pass@k capture functionality and not best practices, which varies by context.

我们的目标是衡量影响代码质量的核心因素，而不仅限于功能是否实现。诸如 Pass@k 等主流指标仅能反映功能正确性，却无法体现最佳实践——而最佳实践本身又高度依赖具体上下文。

We built a task-specific evaluation harness that checks both technical requirements and subjective aspects such as code quality, design choices, and adherence to preferred methods.

我们构建了一套面向具体任务的评测框架，可同时检验技术性要求（如正确性、可运行性）与主观性维度（如代码质量、架构设计选择、对推荐方法的遵循程度）。

We define three categories for our evaluation:

我们为评测定义了三大类别：

**Smoke Tests**

**冒烟测试（Smoke Tests）**

These verify basic functionality. Tests confirm that the code compiles, exposes the `.invoke()` method, handles expected input states, and returns expected output structures like `AIMessage` objects with required state properties.

此类测试用于验证基础功能是否正常：确认代码可成功编译、暴露 `.invoke()` 方法、能正确处理预期的输入状态，并返回符合要求的输出结构（例如包含必要状态属性的 `AIMessage` 对象）。

We calculate scores using weighted summation:

Score = Σᵢ wᵢ × cᵢ

我们使用加权求和法计算得分：

得分 = Σᵢ wᵢ × cᵢ

where _wᵢ_ is the weight of test _i_ and _cᵢ_ is the binary result of a test.

其中，_wᵢ_ 表示第 _i_ 项测试的权重，_cᵢ_ 表示该测试的二元结果（通过/失败）。

**Task Requirement Tests**

**任务需求测试**

These verify task specific functionality. Tests include validation of deployment configuration files, verification of HTTP requests to external APIs such as web search or LLM providers, and unit tests specific to each coding task. Scoring is done through weighted summation of each test result, same as smoke tests.

此类测试用于验证任务特定的功能。测试内容包括：部署配置文件的有效性校验、向外部 API（如网络搜索服务或大语言模型提供商）发起的 HTTP 请求的正确性验证，以及针对每项编码任务编写的单元测试。评分方式与冒烟测试（smoke tests）相同，即对各项测试结果进行加权求和。

**Code Quality & Implementation Evaluation**

**代码质量与实现评估**

For this category, we use LLM-as-a-Judge to capture what binary tests miss. Implementations that follow better approaches should score higher than those that simply compile and run. Code quality, design choices, and use of LangGraph abstractions all require nuanced evaluation.

在该类别中，我们采用“大语言模型作为裁判”（LLM-as-a-Judge）的方法，以捕捉二元测试所无法覆盖的维度。遵循更优设计思路的实现，其得分应高于仅满足编译通过与基本运行要求的实现。代码质量、架构设计选择，以及对 LangGraph 抽象机制的运用，均需进行细致入微的综合评估。

We reviewed expert written code for each task and built task specific rubrics. Using Claude Sonnet 4 (`claude-sonnet-4-20250514`) at temperature 0, we evaluated generated code against these rubrics, using expert-written code as the reference and human annotations to log compilation and runtime errors.

我们审阅了每项任务对应的专家编写代码，并据此构建了面向具体任务的评分细则（rubrics）。我们使用 Claude Sonnet 4（`claude-sonnet-4-20250514`）模型，在温度参数（temperature）设为 0 的条件下，将生成代码与上述细则进行比对评估；以专家编写的代码为参考基准，并结合人工标注记录编译错误与运行时错误。

Our rubric had two types of criteria:

我们的评分细则包含两类评估标准：

**Objective Checks:** These are binary facts about the code (e.g. presence of specific nodes, correct graph structure, module separation, absence of test files). The LLM judge returned a boolean response for each check and we used weighted summation, same as smoke tests, to get a score for objective checks.

**客观性检查（Objective Checks）：** 这些是关于代码的二元事实判断（例如：是否包含特定节点、图结构是否正确、模块是否合理分离、是否不含测试文件等）。大语言模型裁判对每一项检查返回布尔值（true/false），我们同样采用加权求和法（与冒烟测试一致）来计算客观性检查的总分。

**Subjective Assessment:** This is qualitative evaluation of the code using expert-written code as reference and human annotation for passing in logs of compilation and runtime errors. LLM judge identified issues and categorized them by severity (critical, major, minor) across two dimensions: correctness violations and quality concerns.

**主观评估：** 这是一种定性评估方法，以专家编写的代码为参考基准，并结合人工标注来判断代码是否通过编译与运行时错误日志的检验。由大语言模型（LLM）担任评审员，识别出各类问题，并从“正确性违规”和“质量缺陷”两个维度，按严重程度（严重、主要、次要）进行分类。

We use penalty-based scoring for this:

Score = Scoreₘₐₓ - Σₛ (nₛ × pₛ)

where Score _max_ is the maximum possible score, _ns_ is the number of violations at severity _s_ and _ps_ is the penalty weight for that severity.

我们采用基于惩罚项的计分方式：

得分 = 最高可能得分（Scoreₘₐₓ） − Σₛ (nₛ × pₛ)

其中，Scoreₘₐₓ 表示该评估项的满分；nₛ 表示严重程度为 s 的违规项数量；pₛ 表示严重程度为 s 对应的扣分权重。

The overall score, combining both objective and subjective results, is given as:

Score = Σᵢ wᵢ × cᵢ + Σₛ (Scoreₘₐₓ,ₛ − Σₛ (nₛ × pₛ))

where the first term represents objective checks and the second term represents assessments across all subjective categories.

综合得分（融合客观与主观评估结果）计算公式如下：

得分 = Σᵢ wᵢ × cᵢ + Σₛ (Scoreₘₐₓ,ₛ − Σₛ (nₛ × pₛ))

其中，第一项代表各项客观检查得分（wᵢ 为第 i 项检查的权重，cᵢ 为其实际得分），第二项代表所有主观评估类别的得分总和。

We ran each Claude Code configuration three times per task to account for variance. For consistency, all scores are reported as percentages of total possible points and then averaged across tasks.

为控制随机性影响，我们对每种 Claude Code 配置在每个任务上均运行三次。为保证一致性，所有得分均以“占该任务总分的百分比”形式呈现，再跨任务取平均值。

You can replicate this approach for your own libraries using the [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) platform to compare coding agent configurations.

您可借助 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 平台，在您自己的代码库中复现这一评估方法，用于对比不同编程智能体（coding agent）配置的效果。

## **Results**

## **实验结果**

We average scores across three different LangGraph tasks to compare Claude Code configurations. The chart below shows overall scores:

我们对三个不同的 LangGraph 任务的得分取平均值，以比较不同 Claude Code 配置的表现。下方图表展示了总体得分：

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_004.png)

The most interesting finding for us is that Claude + `Claude.md` outperformed Claude + MCP, even though `Claude.md` only included a subset of what the MCP server could provide. Traces explained why: Claude didn’t invoke MCP tools as much as we’d expected. Even when a task required following two or three linked pages, it typically called MCP once and stopped at the main page, which only gave surface-level descriptions, not the details needed.

对我们而言，最有趣的发现是：Claude + `Claude.md` 的表现优于 Claude + MCP，尽管 `Claude.md` 仅包含了 MCP 服务器所能提供内容的一个子集。追踪日志（traces）揭示了原因：Claude 调用 MCP 工具的频率远低于我们的预期。即使某项任务需要依次访问两到三个相互链接的页面，Claude 通常也只调用一次 MCP，并停留在主页面——而该页面仅提供表层描述，缺乏完成任务所需的细节信息。

By contrast, Claude + `Claude.md` \+ MCP used the docs more effectively. We observed in traces that it called MCP tools more frequently and even triggered web search tool when required. This behavior was driven by `Claude.md` that included reference URLs at the end of each section to look for further information.

相比之下，Claude + `Claude.md` \+ MCP 对文档的利用更为高效。我们在追踪日志中观察到，它更频繁地调用了 MCP 工具，且在必要时还会主动触发网络搜索工具。这种行为正是由 `Claude.md` 所驱动的——该文件在每一章节末尾均附有参考 URL，引导模型进一步查找相关信息。

This doesn’t mean MCP tools didn’t help on their own. They improved scores by ~10 percentage points, mainly by grounding the agent in basic syntax and concepts. But for task completion and code quality, `Claude.md` was more important. The guide included pitfalls to avoid and principles to follow, which helped Claude Code think better and explore different parts of the library rather than stopping at high-level descriptions.

这并不意味着 MCP 工具自身毫无助益。它们将整体得分提升了约 10 个百分点，主要作用在于帮助智能体掌握基础语法和核心概念。但在任务完成度与生成代码质量方面，`Claude.md` 的作用更为关键。这份指南不仅列出了应避免的常见陷阱，还阐明了需遵循的设计原则，从而促使 Claude Code 更深入地思考、更全面地探索库中的不同模块，而非止步于高层级的笼统描述。

These results point to a few broader lessons for anyone configuring coding agents.

这些结果为所有正在配置编程智能体的开发者提供了若干普适性启示。

## **Key Takeaways**

## **核心启示**

The results leave us with a few takeaways. If you’re thinking about customizing coding agents for your own libraries, the following can be useful:

这些结果带给我们几点重要启示。若您正考虑为自有代码库定制编程智能体，以下建议或许颇具参考价值：

**Context Overload:** Dumping large `llms.txt` files from documentation can crowd the context window. This can lead to poor performance and higher cost. Our MCP server has a naive implementation of fetching page contents completely. Even invoking it once flagged Claude Code warnings of context window filling up. If your documentation is extensive enough that you need tooling to retrieve specific docs, it’s worth building smarter retrieval tooling that pulls only the relevant snippets.

**上下文过载（Context Overload）：** 直接将大型 `llms.txt` 文档文件“倾倒”进提示词中，极易挤占上下文窗口空间，进而导致性能下降与成本上升。我们当前的 MCP 服务器采用了一种朴素实现方式——完整抓取整页内容。即便仅调用一次，也已触发 Claude Code 关于上下文窗口即将填满的警告。若您的文档体量庞大，以至于必须借助工具来检索特定内容，那么构建更智能的检索工具就十分必要——它应能精准提取并返回与当前任务高度相关的文本片段，而非整页内容。

**Claude.md has the highest payoff:** It’s easier to set up than an MCP server or specific tooling and cheaper to run. On task #2, Claude + `Claude.md` was ~2.5x cheaper than Claude MCP and Claude + `Claude.md` \+ MCP. It’s cheaper than Claude MCP and performs better. This is a great starting point when thinking of customizing Claude Code and may just be good enough for some use cases.

**`Claude.md` 的投入产出比最高：** 其搭建难度远低于部署 MCP 服务器或开发专用工具，运行成本也更低。在任务 #2 中，Claude + `Claude.md` 的成本约为 Claude MCP 及 Claude + `Claude.md` \+ MCP 的 2.5 分之一。它不仅比 Claude MCP 更经济，而且性能更优。因此，在着手定制 Claude Code 时，`Claude.md` 是一个极佳的起点；对某些应用场景而言，它甚至可能已完全够用。

**Write good instructions**.  
**编写优质的说明文档**。  
A `Claude.md` (or `Agents.md`) should highlight core concepts, unique functionality, and common primitives in your library. Review failed runs manually to find recurring pitfalls and add guidance for them. For us, that meant covering async tasks in LangGraph with Streamlit, where agents often failed on `asyncio` integration. We also added debugging steps for spinning up dev servers, which fixed import errors and let Claude Code send requests to the server to verify outputs. Popular code-gen tools often use long system prompts (7–10k tokens). Putting effort into instructions pays off pretty well.  
一份 `Claude.md`（或 `Agents.md`）文件应重点阐明您库中的核心概念、独特功能以及常用基础构件（primitives）。请人工复盘失败的运行案例，识别反复出现的陷阱，并针对性地补充使用指引。对我们而言，这意味着需专门说明 LangGraph 与 Streamlit 协同处理异步任务时的注意事项——在此类场景中，智能体常因 `asyncio` 集成问题而失败。我们还增加了本地开发服务器的调试步骤，从而解决了导入错误，并使 Claude Code 能向该服务器发送请求以验证输出结果。当前主流的代码生成工具普遍采用较长的系统提示词（7–10k token）。在指令设计上投入精力，回报相当可观。

**Claude +** [**Claude.md**](http://claude.md/?ref=blog.langchain.com) **\+ MCP wins**: While `Claude.md` provides the most mileage per token, the strongest results came from pairing it with an MCP server that allows it to read documentation in detail. The guide provided orientation with concepts and the docs helped go in-depth. Together, they can produce best results on domain specific libraries.  
**Claude +** [**Claude.md**](http://claude.md/?ref=blog.langchain.com) **\+ MCP 组合胜出**：尽管 `Claude.md` 在单位 token 效率上表现最优，但最强效果却来自将其与一个支持深度读取文档的 MCP（Model Communication Protocol）服务器协同使用。`Claude.md` 指南为用户提供了概念性引导，而详尽的官方文档则支撑了深入探索；二者结合，可在面向特定领域的库（domain-specific libraries）上产出最佳效果。

In the Appendix, we include per-task results and category-level graphs for readers who want to dig into per task performance.  
附录中，我们为希望深入分析各任务表现的读者，汇总了每项任务的具体评估结果及按类别划分的性能图表。

## **Appendix**  
## **附录**

**Task #1: Text-to-SQL Agent**  
**任务 #1：文本转 SQL 智能体**

We asked each configuration to build a LangGraph-based text-to-SQL agent that could generate SQL query from natural language, execute it against a database, and return a natural language response. This task required fetching the Chinook SQLite database from a remote URL and setting up an in-memory database. You can read the prompt that we passed to Claude Code instances [here](https://github.com/langchain-ai/claude-code-evals/blob/main/task_1/input_prompt.py?ref=blog.langchain.com).  
我们要求每种配置均构建一个基于 LangGraph 的文本转 SQL 智能体：该智能体需能将自然语言查询转化为 SQL 语句，在数据库中执行该语句，并以自然语言形式返回结果。本任务需从远程 URL 下载 Chinook SQLite 数据库，并在内存中完成数据库初始化。您可在此处查阅我们提供给 Claude Code 实例的原始提示词：[链接](https://github.com/langchain-ai/claude-code-evals/blob/main/task_1/input_prompt.py?ref=blog.langchain.com)。

For this task, our smoke tests verified basic LangGraph functionality. Task requirements checked database setup; SQL query handling for simple queries, join queries, date range queries; and LLM-as-a-Judge evaluated code design choices such as remote URL fetching, separate nodes for SQL generation, execution, and response. The LLM-as-a-Judge prompt is available [here](https://github.com/langchain-ai/claude-code-evals/blob/main/task_1/llm_as_a_judge.py?ref=blog.langchain.com).  
针对本任务，我们的冒烟测试（smoke tests）首先验证了 LangGraph 的基础功能是否正常。任务需求覆盖了数据库初始化、对简单查询、多表连接查询（join queries）及日期范围查询（date range queries）的 SQL 处理能力；此外，“LLM 作为裁判”（LLM-as-a-Judge）机制进一步评估了代码设计层面的关键选择，例如：是否通过远程 URL 动态获取数据库而非硬编码 schema、是否将 SQL 生成、SQL 执行与自然语言响应等环节拆分为独立节点。该“LLM 作为裁判”的提示词详见：[链接](https://github.com/langchain-ai/claude-code-evals/blob/main/task_1/llm_as_a_judge.py?ref=blog.langchain.com)。

The results show performance difference across Claude Code configurations and categories:  
评估结果清晰呈现了不同 Claude Code 配置方案及各类别指标之间的性能差异：

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_005.png)![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_006.png)

Poor implementations typically struggled with connecting in-memory database across threads, downloaded and hardcoded schemas in LLM prompts instead of using remote URLs with runtime schema reading, and failed to properly parse LLM output for SQL execution (breaking when LLM would generate slightly different formatted results).  
表现较差的实现方案普遍存在以下问题：无法在线程间正确共享内存数据库连接；未采用远程 URL + 运行时动态读取 schema 的方式，而是将数据库结构（schema）下载后直接硬编码进 LLM 提示词中；未能稳健解析 LLM 输出以执行 SQL（一旦 LLM 生成格式略有差异的结果，整个流程即告中断）。

**Task #2: Company Researcher**

**任务 #2：公司研究员**

For this task, we asked each Claude configuration to build a multi-node LangGraph agent that researches companies using web search through [Tavily API](https://www.tavily.com/?ref=blog.langchain.com). The agent needed to handle structured data collection, implement parallel search execution, and add a reflection step that ensures all requested information is gathered. You can read the prompt [here](https://github.com/langchain-ai/claude-code-evals/blob/main/task_2/input_prompt.py?ref=blog.langchain.com).

本任务中，我们要求每种 Claude 配置构建一个基于多节点 LangGraph 的智能体，通过 [Tavily API](https://www.tavily.com/?ref=blog.langchain.com) 执行网络搜索以开展公司调研。该智能体需支持结构化数据采集、实现并行搜索执行，并加入一个反思（reflection）步骤，确保完整获取所有指定信息。您可在此处查阅原始提示词：[链接](https://github.com/langchain-ai/claude-code-evals/blob/main/task_2/input_prompt.py?ref=blog.langchain.com)。

Our tests verified basic functionality, Tavily API integration, and presence of all requested properties in the structured object class. [LLM-as-a-Judge](https://github.com/langchain-ai/claude-code-evals/blob/main/task_2/llm_as_a_judge.py?ref=blog.langchain.com) checked for implementation of features like reflection logic, minimum search query limits, and parallel web search execution.

我们的测试验证了基础功能、Tavily API 集成情况，以及结构化对象类中是否完整实现了所有指定属性。[LLM-as-a-Judge](https://github.com/langchain-ai/claude-code-evals/blob/main/task_2/llm_as_a_judge.py?ref=blog.langchain.com) 进一步评估了若干关键实现细节，例如：是否正确实现了反思逻辑、是否设置了最低搜索查询数量限制、是否真正实现了并行网络搜索执行等。

The following are the results for this task:

以下为本任务的评测结果：

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_007.png)![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_008.png)

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_007.png)![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_008.png)

Most implementation failures were related to structuring information in an object in state and reflection step. Poor implementations either didn’t have functional reflection nodes or failed to trigger additional searches.

大多数实现失败集中在两个方面：一是未能将信息正确组织为状态（state）中的结构化对象；二是反思步骤设计不当。表现较差的实现要么完全缺失可用的反思节点，要么无法触发后续补充搜索。

**Task #3: Categories of Memories**

**任务 #3：记忆的分类管理**

This was an editing task where we provided each Claude Code configuration with an existing memory agent as base code. We asked them to extend the memory storage method to categorize memory by type (personal, professional, other) in addition to user ID, implement selective memory retrieval based on message category instead of just user ID, and add human in the loop confirmation step before saving memories. We deliberately added syntax errors as well. The full prompt is available [here](https://github.com/langchain-ai/claude-code-evals/blob/main/task_3/input_prompt.py?ref=blog.langchain.com).

这是一项代码编辑任务：我们向每种 Claude Code 配置提供了一个已有的记忆智能体作为基础代码。我们要求其扩展记忆存储机制，在原有按用户 ID 存储的基础上，新增按记忆类型（personal / professional / other）进行分类；实现基于消息类别的选择性记忆检索（而不仅限于用户 ID）；并在保存记忆前加入“人在环路”（human-in-the-loop）确认步骤。我们还特意在基础代码中引入了语法错误。完整提示词详见：[链接](https://github.com/langchain-ai/claude-code-evals/blob/main/task_3/input_prompt.py?ref=blog.langchain.com)。

With tests we verified that implementations correctly added the interrupt functionality before memory storage, implemented category-wise storage and retrieval, used three specific categories (personal, professional, other), and maintained functional interrupt logic that saves memories only when users accept. [LLM-as-a-Judge](https://github.com/langchain-ai/claude-code-evals/blob/main/task_3/llm_as_a_judge.py?ref=blog.langchain.com) evaluated whether implementations used LLM-based categorization rather than brittle keyword matching and unnecessary files.

我们通过测试验证了各实现是否：① 正确在记忆存储前添加中断（interrupt）功能；② 实现了按类别划分的记忆存储与检索；③ 严格使用了三个指定类别（personal / professional / other）；④ 维持了功能完备的中断逻辑——仅当用户明确接受时才保存记忆。[LLM-as-a-Judge](https://github.com/langchain-ai/claude-code-evals/blob/main/task_3/llm_as_a_judge.py?ref=blog.langchain.com) 进一步评估其实现方式是否采用基于大语言模型的记忆分类（而非僵化的关键词匹配），以及是否避免引入冗余文件。

For an editing task, we see following results:

作为一项代码编辑任务，我们得到如下结果：

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_009.png)![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_010.png)

![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_009.png)![](images/how-to-turn-claude-code-into-a-domain-specific-coding-agent/img_010.png)

大多数实现方案在正确实现中断（interrupt）功能方面都存在困难。错误的实现方式要么简单地添加 `input()` 调用以获取终端输入，要么过度复杂化解决方案——例如额外创建独立节点，而非仅用几行恰当的中断逻辑来处理。此外，低质量的实现还依赖关键词匹配进行分类，而非基于大语言模型（LLM）的分类方法；几乎所有方案均未能识别出我们刻意引入的语法错误。