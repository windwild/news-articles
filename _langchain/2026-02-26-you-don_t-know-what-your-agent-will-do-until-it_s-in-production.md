---
title: "You don’t know what your agent will do until it’s in production"
render_with_liquid: false
source: "LangChain Blog"
url: "https://blog.langchain.com/you-dont-know-what-your-agent-will-do-until-its-in-production/"
date: "2026-02-26"
scraped_at: "2026-03-02T10:08:03.895292343+00:00"
language: "en-zh"
translated: true
description: "You can't monitor agents like traditional software. Inputs are infinite, behavior is non-deterministic, and quality lives in the conversations themselves. This article explains what to monitor, how to..."
---

render_with_liquid: false
When you ship traditional software to production, you have a good sense of what to expect. Users click buttons, fill out forms, navigate through predetermined paths. Your test suite might cover 80-90% of code paths, and monitoring tools track the usual suspects: error rates, response times, database queries. When something breaks, you look at stack traces and logs.

当您将传统软件部署到生产环境时，通常能较好地预判其行为。用户点击按钮、填写表单、沿预设路径导航。您的测试套件可能覆盖了 80–90% 的代码路径，而监控工具则追踪常规指标：错误率、响应时间、数据库查询等。一旦出现问题，您会查看堆栈跟踪（stack traces）和日志。

Agents operate differently. They accept natural language input, where the space of possible queries is unbounded. They're powered by large language models that are sensitive to subtle variations in prompts and can produce different outputs for the same input. And they make decisions through multi-step reasoning chains, tool calls, and retrieval operations that are difficult to fully anticipate during development.

智能体（Agents）的运行方式则截然不同。它们以自然语言作为主要输入，而自然语言的可能查询空间是无限的。智能体由大语言模型（LLM）驱动，对提示词（prompt）中细微的措辞变化高度敏感，甚至可能对完全相同的输入生成不同的输出。此外，它们通过多步推理链、工具调用和检索操作来做出决策——这些过程在开发阶段极难被完整预见。

This means that production monitoring for agents requires different capabilities than traditional observability. In this post, we'll explore why agent observability has distinct challenges, what you need to monitor, and what we've learned from teams deploying agents at scale.

这意味着，针对智能体的生产环境监控，需要不同于传统可观测性（observability）的能力。本文将探讨：为何智能体可观测性面临独特挑战、你需要监控哪些关键要素，以及我们从大规模部署智能体的团队实践中所获得的经验与洞见。

## Why agents are different from traditional software

## 为何智能体不同于传统软件

Working with teams deploying agents to production, we've observed two key distinctions that affect monitoring approaches.

在与将智能体投入生产环境的团队协作过程中，我们观察到两个关键差异，它们深刻影响着监控策略的设计与实施。

### Agents have an infinite input space

### 智能体拥有无限的输入空间

Traditional software has a finite, constrained input space. Users interact through buttons, dropdowns, forms, and API calls with specific formats. When you design a checkout flow, you know the exact sequence of screens and possible user actions. Your error handling can be comprehensive because you can enumerate the failure modes.

传统软件的输入空间是有限且受约束的。用户通过按钮、下拉菜单、表单以及具有特定格式的 API 调用进行交互。例如，在设计结账流程时，您清楚地知道每一步界面的精确顺序及用户可能执行的操作；因此，错误处理可以做到全面覆盖，因为所有潜在故障模式均可被枚举。

Agents, by contrast, accept natural language as their primary input. Natural language has no fixed set of valid inputs. Users can phrase the same request in countless ways — vague or specific, formal or casual, combining multiple intents in a single message or spreading a single request across multiple turns.

相比之下，智能体以自然语言作为其主要输入。自然语言并不存在一套固定的“有效输入”集合。用户可以用无穷多种方式表达同一请求——或模糊或具体、或正式或随意；既可能在一条消息中混合多个意图，也可能将单个请求拆分至多轮对话中完成。

Consider a customer support agent. In traditional software, users would navigate to "Order History," click on an order, click "Request Refund," and finally fill out a form with predefined options. The path is fixed and testable.

以客户支持智能体为例：在传统软件中，用户需依次进入“订单历史”页面 → 点击某笔订单 → 点击“申请退款” → 最后在预定义选项的表单中填写信息。整个路径是固定的，且可被充分测试。

With an agent, users might say:  

而在智能体场景下，用户可能会说：

- "I want to return my order"  
- 我想退回我的订单。

- "Can you help me get my money back for the shoes I bought last week?"  
- 您能帮我退掉上周买的那双鞋的款项吗？

- "The item I received is damaged, what are my options?"  
- 我收到的商品有损坏，我有哪些选择？

- "order #12345 refund please"  
- 请为订单 #12345 办理退款。

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_001.png)

Each represents the same underlying intent, but the agent needs to understand the variation, extract the relevant information, and determine the appropriate actions. **This infinite input space means you cannot fully predict how your agent will be used until real users start interacting with it.**  
每条语句都表达了相同的底层意图，但智能体需理解其中的表达差异，提取关键信息，并确定恰当的响应动作。**这种无限多样的输入空间意味着：在真实用户开始与智能体交互之前，你无法完全预判其实际使用方式。**

### LLMs are not robust to small changes  
### 大语言模型对细微变化缺乏鲁棒性

The second key difference is that LLMs exhibit prompt sensitivity and non-deterministic behavior. Even small variations in input can lead to different outputs, and the same input can sometimes produce different results.  
第二个关键区别在于：大语言模型（LLM）具有提示敏感性与非确定性行为。即使输入仅有细微差异，也可能导致输出不同；而同一输入有时也会产生不同的结果。

This happens for several reasons. LLMs use probabilistic sampling during generation, which introduces variance. Most importantly, LLMs respond differently to subtle changes in phrasing, context, or instruction ordering.  
这由多种原因造成：LLM 在生成过程中采用概率采样，天然引入随机性；更重要的是，LLM 对措辞、上下文或指令顺序的细微变化极为敏感，响应往往随之改变。

This non-determinism means that the behavior you observe in development may not match what happens in production. A prompt that works reliably in testing might fail on edge cases you didn't encounter. An agent that correctly uses tools during evaluation might occasionally select the wrong tool for user queries with slightly different phrasing.  
这种非确定性意味着：你在开发阶段观察到的行为，未必能在生产环境中复现。一个在测试中表现稳定的提示词，可能在你未曾覆盖的边缘场景下失效；一个在评估中能正确调用工具的智能体，也可能因用户提问措辞的微小差异，而偶然选择错误的工具。

## Production monitoring for agents is different  
## 面向智能体的生产环境监控方式不同

Traditional Application Performance Monitoring (APM) tools focus on metrics like latency, traffic, errors, and saturation. They track HTTP requests, database queries, and system resources. They're designed for structured, deterministic systems where you know the possible code paths.  
传统的应用性能监控（APM）工具聚焦于延迟、流量、错误率和资源饱和度等指标，追踪 HTTP 请求、数据库查询及系统资源消耗。它们面向结构清晰、行为可预测的系统而设计——在这些系统中，所有可能的代码执行路径都是已知且可控的。

Agent observability requires monitoring the **inputs and outputs** themselves, not just the system metrics around them.  
而智能体可观测性（agent observability）则要求直接监控其**输入与输出本身**，而不仅仅是围绕它们的系统级指标。

### Monitoring natural language interactions

### 监控自然语言交互

When your agent is having conversations with users, the primary signal lives in the conversations themselves. You need to capture:

当您的智能体（agent）与用户进行对话时，最核心的信号就存在于这些对话本身。您需要捕获以下内容：

- **完整的提示—响应对（prompt-response pairs）**：不仅记录请求是否发生，更要准确记录用户提出了什么问题，以及智能体给出了怎样的回应；  
- **多轮上下文（multi-turn context）**：智能体通常在一次完整对话中经历多个来回交互，因此您需要将相关联的多次交互归为一组；  
- **智能体执行轨迹与中间步骤（agent trajectory and intermediate steps）**：智能体可能通过多步推理达成最终输出——例如调用工具、权衡不同选项、逐步推导结论。您需要清晰可见每一步轨迹，而不仅仅是最终响应。

This is qualitatively different from traditional logging. A traditional web request might be summarized as "POST /api/checkout 200 OK 342ms." An agent interaction is a natural language conversation with potentially dozens of steps — and the question of whether it went well isn't answerable from the status code.

这在本质上不同于传统日志记录。一个典型的 Web 请求可能仅被概括为：“POST /api/checkout 200 OK 342ms”。而一次智能体交互则是一场自然语言对话，可能包含数十个步骤——其效果好坏，无法单凭状态码判断。

### The challenge of human judgment at scale

### 大规模场景下人工评判的挑战

Natural language interactions often require human judgment to evaluate properly. Is this response helpful? Did the agent understand the user's intent? Was the tone appropriate? Did it retrieve relevant information?

自然语言交互往往需依赖人工判断才能准确评估：该回复是否有帮助？智能体是否真正理解了用户的意图？语气是否得当？是否成功检索到相关信息？

During development, this is manageable — you review traces manually, tweak prompts, and iterate. But in production, you might be handling thousands or millions of interactions. Human reviewers can meaningfully assess 50–100 traces per hour, but at 1,000 requests per day, full manual review would require 10–20 hours of dedicated human time, daily. This raises an important question: **how do you bring human intelligence to production data when manual review doesn't scale?**

开发阶段，这种人工评估尚可应对——您可手动审阅追踪记录（traces）、调整提示词（prompts），并持续迭代优化。但在生产环境中，您可能每天需处理成千上万甚至数百万次交互。一名人工评审员每小时仅能有效评估 50–100 条追踪记录；若每日请求量达 1,000 次，全面人工评审将耗费每日 10–20 小时的专职人力。这引出一个关键问题：**当人工评审无法规模化时，如何将人类智慧有效引入生产数据？**

We've found two complementary approaches effective.

我们发现两种互补的方法行之有效。

### Annotation queues for structured human review

### 面向结构化人工评审的标注队列（Annotation Queues）

Annotation queues help make human review as efficient as possible. Rather than asking reviewers to hunt through production logs, an annotation queue presents specific runs in a structured format with a predefined rubric.

标注队列旨在最大限度提升人工评审效率。它不再要求评审员在庞杂的生产日志中自行查找线索，而是以结构化形式呈现特定的执行实例（runs），并配套预定义的评分标准（rubric）。

An effective annotation queue system lets you:

一个高效的标注队列系统可帮助您实现以下目标：

- **Route specific traces for review**: Instead of reviewing everything, send particular subsets to the queue (runs with negative feedback, high-cost interactions, or queries from a specific time window)  
- **定向路由特定追踪记录以供审核**：无需审核全部数据，仅将特定子集（例如收到负面反馈的运行、高成本交互，或来自特定时间窗口的查询）送入队列。

- **Define review criteria**: Set up rubrics so reviewers know exactly what to evaluate (relevance, correctness, tone, safety)  
- **定义审核标准**：制定评分细则，使审核人员明确需评估的具体维度（相关性、正确性、语气、安全性）。

- **Enable team collaboration**: Multiple reviewers can work through queues with progress tracking and role assignments  
- **支持团队协作**：多名审核员可协同处理队列任务，并支持进度跟踪与角色分配。

- **Create feedback loops**: Reviewed data can be annotated with corrections and added to evaluation datasets  
- **构建反馈闭环**：经审核的数据可添加修正标注，并纳入评测数据集。

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_002.webp)

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_002.webp)

Annotation queues are especially valuable when you're trying to understand a new failure mode, build up training data for evaluators, or get expert domain feedback on specialized queries.

当您试图理解一种新型故障模式、为评测人员构建训练数据，或就专业领域查询获取专家级领域反馈时，标注队列尤为有价值。

Trade-offs to consider: Annotation queues require dedicated reviewer time and can introduce latency into the improvement cycle. We've found they work best when focused on specific high-value traces rather than attempting comprehensive coverage.

需权衡的利弊：标注队列需要投入专职审核人员的时间，且可能在优化迭代周期中引入延迟。我们发现，其效果最佳的情形是聚焦于特定高价值追踪记录，而非追求全覆盖式审核。

### LLMs as a proxy for human judgment

### 大语言模型作为人类判断的代理

The second approach is to use LLMs themselves to scale human judgment. While LLMs aren't perfect evaluators, they can assess many quality dimensions at a scale that humans cannot.

第二种方法是利用大语言模型（LLM）自身来规模化人类判断力。尽管 LLM 并非完美的评估者，但它们能在人类无法企及的规模上评估诸多质量维度。

In particular, you can configure [**online evaluators**](https://docs.langchain.com/langsmith/evaluation-concepts?ref=blog.langchain.com#online-evaluations) to run automatically on production traffic, either on all runs or on a sampled subset. These evaluators can check:

具体而言，您可以配置[**在线评测器**](https://docs.langchain.com/langsmith/evaluation-concepts?ref=blog.langchain.com#online-evaluations)，使其自动在生产流量上运行——既可覆盖全部运行实例，也可仅针对抽样子集。这些评测器可检查如下方面：

- **Reference-free quality metrics**: Attributes like coherence and tone that don't require a ground truth answer  
- **无参考答案的质量指标**：如连贯性、语气等不依赖标准答案即可评估的属性。

- **Safety and compliance**: Whether responses contain sensitive information, violate policies, or exhibit harmful behavior  
- **安全性与合规性**：响应是否包含敏感信息、违反策略，或表现出有害行为。

- **Format validation**: Whether outputs follow expected structures or contain required elements  
- **格式校验**：输出是否符合预期结构，或是否包含必需元素。

- **Topic classification**: What categories of requests users are making  
- **主题分类**：用户请求所属的类别。

**LLMs can assess natural language at a scale beyond human review**. While humans might review dozens of traces, an LLM evaluator can assess thousands, flagging potential issues and providing aggregate metrics.

**大语言模型可在远超人工审核能力的规模上评估自然语言**。人类审核员可能仅能审阅数十条追踪记录，而一个 LLM 评测器却可评估成千上万条，自动标记潜在问题并提供聚合统计指标。

However, **LLM-based evaluations also introduce their own costs and constraints**:

然而，**基于大语言模型（LLM）的评估也带来了其自身的成本与限制**：

- **Latency**: Evaluators can add a few seconds of latency per trace, which may be acceptable for async batch evaluation but not for synchronous user feedback  
- **延迟**：每个 trace 的评估可能增加数秒延迟——这对异步批量评估尚可接受，但不适用于需要实时响应的用户反馈场景。

- **Cost**: Evaluating all traces can add to your inference costs, which is why we typically recommend sampling 10-20% of traffic  
- **成本**：对全部 trace 进行评估会显著增加推理开销，因此我们通常建议仅对 10–20% 的流量进行抽样评估。

- **Accuracy**: Off-the-shelf evaluators may not reflect what "good" means for your specific app. Custom LLM-as-judge evaluators aligned to your use case are often necessary, but ensuring they agree with human judgment can also be difficult. We built [Align Evals](https://blog.langchain.com/introducing-align-evals/) to help teams validate their custom evaluators are calibrated against human labels before you trust them at scale.  
- **准确性**：现成的评估器未必能准确体现“优质表现”在您特定应用中的真实含义。通常需构建与业务场景深度对齐的定制化 LLM-as-judge 评估器；但确保这类评估器与人工判断保持一致本身也颇具挑战。为此，我们开发了 [Align Evals](https://blog.langchain.com/introducing-align-evals/)，帮助团队在将定制评估器规模化部署前，验证其输出是否已与人工标注结果完成校准。

- **Evaluation drift**: As production traffic shifts, evaluators may need retuning or replacement  
- **评估漂移**：随着线上流量分布的变化，评估器可能需要重新调优甚至更换。

For these reasons, we recommend combining automated evaluation with periodic human review rather than relying solely on LLM evaluators.

鉴于上述原因，我们建议将自动化评估与定期人工复审相结合，而非完全依赖 LLM 评估器。

## Tools for production agent observability

## 面向生产环境智能体的可观测性工具

Building effective production observability for agents requires a specific set of capabilities, most of which general-purpose monitoring tools weren't designed to provide. Based on patterns we observed across dozens of production deployments, we built the following into [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com).

要为智能体构建真正有效的生产级可观测能力，需要一套特定功能——而大多数通用监控工具并非为此类需求而设计。基于我们在数十个实际生产部署中观察到的共性模式，我们将以下能力集成到了 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 中。

### Insights Agent: Discovering usage and error patterns

### Insights Agent：识别使用行为与错误模式

One of the more challenging aspects in production is simply understanding what users are doing with your agent.

在生产环境中，最具挑战性的任务之一，往往只是弄清用户究竟如何使用您的智能体。

When we analyzed how teams were using production traces, we found they needed a way to automatically discover patterns without specifying what to look for upfront. This motivated us to build [Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com), which uses an automated clustering system that groups similar traces to identify:

当我们分析各团队如何利用生产 trace 数据时发现：他们亟需一种无需预先定义目标即可自动发现潜在模式的方法。这促使我们开发了 [Insights Agent](https://docs.langchain.com/langsmith/insights?ref=blog.langchain.com)，它采用自动化聚类系统，将相似的 trace 归为一类，从而识别出：

- **Usage patterns**: What are the most common types of requests users make? Which features or capabilities are they trying to use?  
- **使用模式**：用户最常发起哪些类型的请求？他们试图使用哪些功能或能力？

- **Error modes**: Where is the agent making mistakes? Are there common failure patterns like incorrect tool selection, retrieval failures, or misunderstanding user intent?  
- **错误模式**：智能体在哪些环节出错？是否存在常见失败模式，例如工具选择错误、检索失败，或对用户意图理解偏差？

- **Edge cases**: What unexpected queries are users sending that you didn't account for?  
- **边缘案例**：用户发送了哪些您未曾预料到的异常查询？

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_003.webp)

Insights Agent can be configured to group traces by usage patterns, failure modes, or custom attributes specific to your domain. You can also filter the analysis to specific subsets (time windows, user cohorts, feature areas) and save configurations for repeated analysis.

Insights Agent 可配置为按使用模式、故障模式或您领域特有的自定义属性对追踪（traces）进行分组。您还可以将分析范围限定于特定子集（如时间窗口、用户群组、功能模块等），并保存配置以便重复执行分析。

For example, a product manager at a company with an embedded copilot might ask: "What parts of our product are users trying to use the copilot for most often?" Insights Agent can analyze thousands of traces, group them by intent, and surface the top usage categories.

例如，一家部署了嵌入式 Copilot 的公司的产品经理可能会问：“用户最常尝试在我们产品的哪些部分使用 Copilot？” Insights Agent 可分析成千上万条追踪记录，按用户意图进行分组，并呈现使用频率最高的几类场景。

An engineer debugging quality issues might ask: "Where is my agent selecting the wrong tools?" Insights Agent can identify common patterns in tool selection failures and provide representative examples.

一位正在排查质量问题的工程师可能提问：“我的智能体在哪些情况下选择了错误的工具？” Insights Agent 能识别工具选择失败中的共性模式，并提供典型示例。

This automated pattern discovery helps make the volume of production traces more manageable and actionable.

这种自动化的模式发现能力，有助于将海量生产环境追踪数据转化为更易管理、更具可操作性的洞察。

### Online Evaluations: Continuous quality monitoring

### 在线评估：持续的质量监控

We mentioned [online evaluations](https://docs.langchain.com/langsmith/evaluation?ref=blog.langchain.com#online-evaluation-flow) earlier as a way to scale human judgment. Let's look at how they work in practice.

我们此前已提及 [在线评估](https://docs.langchain.com/langsmith/evaluation?ref=blog.langchain.com#online-evaluation-flow) 作为一种规模化运用人工判断的方法。接下来，让我们看看其在实际中如何运作。

With online evaluations, you set up evaluators that run automatically on production traces. You can configure:

借助在线评估，您可以部署自动运行于生产追踪数据之上的评估器（evaluators）。您可配置以下内容：

- **Which traces to evaluate**: All traces, sampled percentages (typically 10-20%), or specific filtered subsets  
- **待评估的追踪**：全部追踪、按比例抽样（通常为 10–20%）或经特定条件筛选的子集  

- **What to evaluate**: Quality metrics, safety checks, format validation, or custom criteria  
- **评估内容**：质量指标、安全检查、格式校验，或自定义评估标准  

- **When to alert**: Thresholds that trigger notifications when metrics degrade  
- **告警触发时机**：当指标劣化至预设阈值时自动触发通知  

Online evaluations serve several purposes beyond traditional "testing":

在线评估的作用远不止传统意义上的“测试”，它还涵盖以下多个方面：

- **Quality monitoring**: You can track how often the agent produces helpful, relevant, correct responses over time. This allows you to detect when quality degrades due to model updates, data drift, or new user patterns.  
- **质量监控**：您可以长期跟踪智能体生成有帮助、相关且正确响应的频率。这使您能及时发现因模型更新、数据漂移或新用户行为模式所导致的质量下降。

- **Topic tagging**: You can automatically classify production queries into categories for product analytics. This gives you visibility into what users are actually trying to accomplish.  
- **主题打标**：您可以自动将生产环境中的用户查询归类到不同主题类别，服务于产品数据分析。这有助于您清晰掌握用户真实意图与目标。

- **Trajectory evaluation**: For agents that use multiple tools or reasoning steps, you can evaluate whether the agent took an appropriate path to the answer. Did it call the right tools in a sensible order? Did it retrieve relevant information?  
- **路径评估（Trajectory evaluation）**：针对调用多个工具或经历多步推理的智能体，您可以评估其抵达答案所采取的路径是否合理——是否以合乎逻辑的顺序调用了恰当的工具？是否成功检索到相关信息？

- **Security and safety**: You can check for sensitive information in outputs, policy violations, or other safety concerns in real time.  
- **安全与合规保障**：您可实时检测输出中是否包含敏感信息、是否存在违反策略的行为，或其他潜在的安全风险。

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_004.png)

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_004.png)

The ability to run evaluations continuously on production traffic enables a development workflow where you can drill into specific failing traces, add them to annotation queues for human review, incorporate them into evaluation datasets, and test fixes before redeploying.

在生产流量上持续运行评估的能力，支持一种开发工作流：你可以深入分析特定的失败调用链（traces），将其加入人工审核的标注队列，纳入评估数据集，并在重新部署前验证修复效果。

### Dashboards and Alerts: Monitoring what matters

### 仪表盘与告警：监控真正关键的指标

Finally, production observability requires dashboards and alerting on metrics that matter to your specific use case. Effective observability platforms provide:

最后，生产环境可观测性要求基于您具体业务场景中真正关键的指标来构建仪表盘并配置告警。高效的可观测性平台应提供：

- **Custom dashboards** for domain-specific insights, allowing you to track success metrics (such as task completion rates or user satisfaction scores) for different workflows. You can also compare performance across model versions and monitor cost and latency by feature area  
- **面向领域的自定义仪表盘**，助您洞察业务本质：例如，针对不同工作流追踪任务完成率、用户满意度得分等成功指标；还可跨模型版本对比性能表现，并按功能模块分别监控成本与延迟。

- **Flexible alerting** via webhooks or PagerDuty when metrics cross thresholds  
- **灵活的告警机制**：当指标超出预设阈值时，可通过 Webhook 或 PagerDuty 等方式及时通知。

- **Drill-down capabilities** from aggregate metrics into specific traces  
- **下钻分析能力**：从聚合指标逐层下钻至单条具体调用链（trace）。

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_005.webp)

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_005.webp)

Production observability requires tracking metrics specific to how agents actually behave. Beyond standard latency and error rates, this means monitoring metrics like tool call failure rates and run count by tool. These signals tell you whether the agent is actually working as intended, not just whether the system is running.

生产环境可观测性要求追踪能真实反映智能体（agent）实际行为的特有指标。除常规的延迟与错误率外，还需关注工具调用失败率、各工具被调用次数等指标。这些信号揭示的是：智能体是否真正按预期运行，而不仅仅是系统本身是否处于运行状态。

The key is monitoring business-critical metrics, not just technical ones. Yes, you care about latency and error rates. But you also care about metrics like user satisfaction, and whether the agent is being used for the intended purposes.

关键在于监控对业务至关重要的指标，而不仅是技术性指标。诚然，您关心延迟和错误率；但您同样关心用户满意度等体验指标，以及智能体是否正被用于其设计初衷所指向的用途。

## Why general-purpose tools fall short

## 为何通用型工具力不从心

At this point, you might wonder: couldn't I build this with traditional observability tools like Datadog or New Relic? Why do I need a specialized platform?

此时您或许会问：我能否直接使用 Datadog 或 New Relic 这类传统可观测性工具来构建上述能力？为何还需要一个专门面向智能体的平台？

Many teams initially attempt to monitor agents using traditional APM tools. We've found this works for basic metrics (latency, error rates) but encounters limitations with agent-specific requirements. The gaps emerge in three areas: payloads, connectivity, and users.

许多团队最初尝试使用传统的 APM 工具来监控智能体（agents）。我们发现，这类工具虽能有效支持基础指标（如延迟、错误率），但在满足智能体特有的监控需求时却面临明显局限。这些局限主要体现在三个维度：载荷（payloads）、连通性（connectivity）和用户（users）。

### Payloads: Natural language data

### 载荷：自然语言数据

Traditional APM tools are optimized for structured logs and numeric metrics. When you need to store, search, and analyze full conversation threads with multi-turn context, you encounter different requirements:

传统 APM 工具专为结构化日志和数值型指标优化。而当你需要存储、检索并分析包含多轮上下文的完整对话线程时，则面临截然不同的需求：

- **Storage scale**: Full prompt-response pairs at production scale require significant storage. You need semantic search capabilities over prompts, not just keyword matching. And you need to preserve full context including system messages and few-shot examples.
- **存储规模**：在生产环境中保存完整的提示（prompt）–响应（response）对，将带来巨大的存储开销；你需要对提示内容支持语义搜索，而不仅是关键词匹配；同时，你还必须完整保留上下文信息，包括系统消息（system messages）和少样本示例（few-shot examples）。

- **Data models**: Maintaining conversation threads and state require different data structures than traditional traces.
- **数据模型**：维护对话线程与状态所需的数据结构，与传统链路追踪（traces）所用的数据结构有本质区别。

We've seen teams build this on top of APM tools, but it requires significant custom development.

我们已观察到不少团队试图在现有 APM 工具之上自行构建此类能力，但这往往需要大量定制化开发工作。

### Connectivity: Integration with the development loop

### 连通性：与开发闭环的深度集成

Agent observability is deeply connected to the agent development workflow, where you should be continuously moving data between production monitoring, evaluation datasets, experimentation, and redeployment. The loop looks like:

智能体可观测性与智能体开发工作流深度耦合——你需持续在生产监控、评估数据集、实验验证与重新部署之间流转数据。该闭环流程如下：

1. **Production traces** reveal failure cases or edge cases  
1. **生产链路追踪（traces）** 揭示失败案例或边界场景  

2. **Annotation queues** let you review and label them  
2. **标注队列（annotation queues）** 支持你人工审核并打标  

3. **Datasets** incorporate these examples for testing  
3. **数据集（datasets）** 将这些样例纳入测试范围  

4. **Experiments** test whether fixes improve behavior  
4. **实验（experiments）** 验证修复方案是否真正改善了行为表现  

5. **Online evaluations** validate the fix in production  
5. **线上评估（online evaluations）** 在真实生产环境中验证修复效果  

This requires tight integration between your observability platform, your evaluation framework, and your development tools. Unlike traditional observability tools, LangSmith provides this connectivity. You can click a failing production trace and immediately add it to a dataset, modify your prompt in a playground environment, run an experiment comparing the old and new versions, and redeploy with confidence.

这要求可观测性平台、评估框架与开发工具之间实现紧密集成。不同于传统可观测性工具，LangSmith 原生支持这一连通能力：你只需点击一条失败的生产链路追踪，即可立即将其加入数据集；在 Playground 环境中修改提示词；运行实验对比新旧版本效果；最终信心十足地完成重新部署。

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_006.png)

### Users: Cross-functional teams

### 用户：跨职能团队

Finally, the people who need access to agent observability are different from those who typically use APM tools. Traditional observability is primarily for SRE and DevOps teams, who are focused on improving system health, performance regressions, and infrastructure issues.

最后，需要访问智能体可观测性（agent observability）的人员，与通常使用 APM 工具的人员并不相同。传统可观测性主要面向 SRE 和 DevOps 团队，其关注重点在于提升系统健康度、识别性能退化以及解决基础设施问题。

Agent observability is for cross-functional teams, including:

智能体可观测性则服务于跨职能团队，包括：

- **AI/ML engineers** debugging prompt issues and model behavior  
- **AI/ML 工程师**：调试提示词（prompt）问题及分析模型行为  
- **Product managers** understanding usage patterns and feature requests  
- **产品经理**：理解用户使用模式及功能需求  
- **Subject matter experts (SMEs)** reviewing accuracy and quality in specialized areas  
- **领域专家（SMEs）**：在专业领域内审核结果的准确性与质量  
- **Data scientists** analyzing patterns and building evaluations  
- **数据科学家**：分析行为模式，并构建评估体系  

![](images/you-don_t-know-what-your-agent-will-do-until-it_s-in-production/img_007.png)

We've observed that agent observability becomes central to how these teams work together to improve the user experience. They regularly do data reviews of production traces, discuss patterns, and make decisions about priorities based on what they observe.

我们观察到，智能体可观测性正日益成为这些团队协同优化用户体验的核心环节。他们定期开展生产环境调用链（traces）的数据复盘，共同讨论发现的模式，并基于所观测到的现象，决策后续工作优先级。

This requires an interface and workflow designed for collaboration across these personas, not just for infrastructure engineers.

这要求提供专为上述各类角色协作而设计的界面与工作流，而不仅服务于基础设施工程师。

## Open challenges

## 尚未解决的挑战

While the approaches we've described have proven effective for teams deploying agents at scale, significant challenges remain:

尽管我们所介绍的方法已在大规模部署智能体的团队中被证实有效，但仍存在若干重大挑战：

- **Evaluator accuracy and reliability**: LLM evaluators continue to improve as models get better, but they aren’t perfect. Understanding when to trust automated evaluation versus [requiring human review](https://www.langchain.com/articles/ai-observability?ref=blog.langchain.com) remains context-dependent.  
- **评估器的准确性与可靠性**：随着大语言模型能力持续提升，LLM 评估器也在不断进步，但尚未达到完美。何时可信赖自动化评估结果、何时必须引入人工复核，仍需结合具体场景判断。  
- **Cost at scale**: Comprehensive monitoring of high-volume production systems can be expensive. Finding the right balance of sampling, automated evaluation, and human review is an ongoing optimization.  
- **规模化成本**：对高吞吐量生产系统实施全面监控可能带来高昂开销。如何在采样策略、自动化评估与人工复核之间取得恰当平衡，是一项持续进行的优化任务。  
- **Privacy and compliance**: Capturing full prompt-response pairs while respecting privacy constraints and handling sensitive data appropriately adds complexity to observability infrastructure.  
- **隐私与合规性**：在严格遵守隐私约束、妥善处理敏感数据的前提下完整采集提示词—响应对（prompt-response pairs），显著增加了可观测性基础设施的设计与实现复杂度。

## Conclusion

## 结论

Agents operate differently from traditional software. They accept natural language inputs, exhibit non-deterministic behavior, and make decisions through complex reasoning chains. These characteristics shift the focus of production monitoring from system metrics to the actual inputs and outputs themselves.

智能体（Agents）的运行方式与传统软件截然不同：它们接收自然语言输入，表现出非确定性行为，并通过复杂的推理链作出决策。这些特性使得生产环境监控的关注重点，从系统指标转向了实际的输入与输出本身。

The approaches we've described (structured annotation queues, automated pattern discovery, and continuous evaluation) represent our current thinking on how to make production agent behavior observable and improvable at scale. We built [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) to address these requirements based on patterns we observed working with teams deploying agents.

我们所介绍的几种方法——结构化标注队列、自动化模式发现以及持续评估——代表了我们当前关于如何在大规模生产环境中实现智能体行为可观测性与可优化性的思考。我们基于与众多部署智能体的团队协作中观察到的实践模式，构建了 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)，以满足上述需求。

If you're working on agent observability, we'd be interested to hear what approaches you've found effective. Learn more about [LangSmith Observability](https://www.langchain.com/langsmith?ref=blog.langchain.com) or read our [observability documentation](https://docs.langchain.com/langsmith/observability?ref=blog.langchain.com).

如果您正在开展智能体可观测性相关工作，我们非常期待了解您所采用并验证有效的实践方法。欢迎进一步了解 [LangSmith 可观测性](https://www.langchain.com/langsmith?ref=blog.langchain.com)，或查阅我们的 [可观测性文档](https://docs.langchain.com/langsmith/observability?ref=blog.langchain.com)。

### Additional Reading

### 延伸阅读

Learn how:

了解以下案例：

- [Monday uses online evaluations](https://blog.langchain.com/customers-monday/) to monitor their customer-facing agents  
- [Monday 使用在线评估](https://blog.langchain.com/customers-monday/) 监控其面向客户的智能体  

- [Appfolio leverages LangSmith](https://blog.langchain.com/customers-appfolio/) to monitor and pinpoint issues in production  
- [Appfolio 借助 LangSmith](https://blog.langchain.com/customers-appfolio/) 在生产环境中监控并精准定位问题  

- [Podium collects user feedback](https://blog.langchain.com/customers-podium/) and performs online evals to improve response quality  
- [Podium 收集用户反馈](https://blog.langchain.com/customers-podium/) 并执行在线评估，以提升响应质量  

- [Jimdo monitors agent metrics](https://blog.langchain.com/customers-jimdo/) including quality scores and tool quality output  
- [Jimdo 监控智能体指标](https://blog.langchain.com/customers-jimdo/)，包括质量评分及工具输出质量  

## Acknowledgments

## 致谢

Thanks to the LangSmith engineering team for building these capabilities, and to the customers who provided feedback that shaped this approach.

衷心感谢 LangSmith 工程团队开发了上述能力，也感谢各位客户提供的宝贵反馈——正是这些反馈塑造并完善了本方法论。