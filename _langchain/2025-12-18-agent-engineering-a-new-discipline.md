---
title: "Agent Engineering: A New Discipline"
source: "LangChain Blog"
url: "https://blog.langchain.com/agent-engineering-a-new-discipline/"
date: "2025-12-18"
scraped_at: "2026-03-03T07:15:37.252997618+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

If you’ve built an agent, you know that the delta between “it works on my machine” and “it works in production” can be huge.  
如果你已经构建过一个智能体（agent），你就知道，“在我的机器上能运行”和“在生产环境中稳定运行”之间的差距可能非常巨大。

Traditional software assumes you mostly know the inputs and can define the outputs. Agents give you neither: users can say literally anything, and the space of possible behaviors is wide open. That’s why they’re powerful — and why they can also go a little sideways in ways you didn’t see coming.  
传统软件假设你基本了解输入，并能明确定义输出；而智能体则两者都不提供：用户可能说出任何内容，其潜在行为空间也完全开放。这正是智能体强大之处——也正是它们可能以你始料未及的方式“跑偏”的原因。

Over the past 3 years, we’ve watched thousands of teams struggle with this reality. The ones who’ve succeeded in shipping something reliable to production — companies like Clay, Vanta, LinkedIn, and Cloudflare — aren’t following the traditional software playbook. They’re pioneering something new: **agent engineering.**  
过去三年中，我们目睹了成千上万个团队在这类现实困境中挣扎。而那些成功将可靠系统交付至生产环境的团队——例如 Clay、Vanta、LinkedIn 和 Cloudflare 等公司——并未沿用传统的软件开发范式。他们正在开创一种全新的实践：**智能体工程（agent engineering）**。

### What is agent engineering?

### 什么是智能体工程？

Agent engineering is the iterative process of refining non-deterministic LLM systems into reliable production experiences. It is a cyclical process: **build, test, ship, observe, refine, repeat.**  
智能体工程，是将非确定性的大语言模型（LLM）系统持续迭代优化、最终转化为可靠生产体验的过程。它是一个循环往复的过程：**构建 → 测试 → 发布 → 观察 → 优化 → 再循环**。

![](images/agent-engineering-a-new-discipline/img_001.png)

The key here is that shipping isn't the end goal. It’s just the way you keep moving to get new insights and improve your agent. To make improvements that matter, you need to understand what’s happening in production. The faster you move through this cycle, the more reliable your agent becomes.  
关键在于：发布并非终点，而只是推动你持续前进、获取新洞察并改进智能体的一种方式。若想做出真正有意义的改进，你必须深入理解智能体在生产环境中的实际表现。你完成这一循环的速度越快，智能体的可靠性就越高。

We see agent engineering as a new discipline that combines 3 skillsets working together:  
我们将智能体工程视为一门新兴学科，它融合了以下三类能力，协同发挥作用：

- **Product thinking** defines the scope and shapes agent behavior. This involves:  
- **产品思维（Product thinking）**界定智能体的能力边界，并塑造其行为模式。具体包括：  
  - Writing prompts that drive agent behavior (often hundreds or thousands of lines). Good communication and writing skills are key here.  
    编写驱动智能体行为的提示词（prompt）（常常达数百甚至数千行）。出色的沟通与写作能力在此至关重要。  
  - Deeply understanding the "job to be done" that the agent replicates  
    深刻理解智能体所要完成的“待办任务（job to be done）”  
  - Defining evaluations that test whether the agent performs as intended by the “job to be done”  
    设计评估方法，检验智能体是否切实履行了该“待办任务”所要求的功能  

- **Engineering** builds the infrastructure that makes agents production-ready. This involves:  
- **工程能力（Engineering）**构建使智能体具备生产就绪能力的基础设施。具体包括：  
  - Writing tools for agents to use  
    为智能体开发可调用的工具  
  - Developing UI/UX for agent interactions (with streaming, interrupt handling, etc.)  
    设计智能体交互的用户界面与用户体验（支持流式响应、中断处理等）  
  - Creating robust runtimes that handle durable execution, human-in-the-loop pauses, and memory management.  
    构建健壮的运行时环境，支持持久化执行、人工介入暂停（human-in-the-loop）、以及内存管理  

- **Data science** measures and improves agent performance over time. This involves:  
- **数据科学（Data science）**长期度量并提升智能体性能。具体包括：  
  - Building systems (evals, A/B testing, monitoring etc.) to measure agent performance and reliability  
    构建各类系统（如评估框架、A/B 测试、监控体系等），用以度量智能体的性能与可靠性  
  - Analyzing usage patterns and error analysis (since agents have a broader scope of how users use them than traditional software)  
    分析用户使用模式与错误日志（因智能体的用户使用方式远比传统软件更加多样且不可预设）  

### Where agent engineering shows up

### 智能体工程在哪些场景中体现？

Agent engineering isn’t a new job title. Instead, it’s a set of responsibilities that existing teams take on when they’re building systems that reason, adapt, and behave unpredictably. The organizations shipping reliable agents today are extending the skills of engineering, product, and data teams to meet the demands of non-deterministic systems.  
智能体工程并非一个全新的职位头衔；它是一组由现有团队承担的职责——当团队着手构建具备推理能力、自适应性与不可预测行为的系统时，这些职责便自然浮现。当前成功交付可靠智能体的组织，正通过拓展工程、产品与数据团队的能力边界，来应对非确定性系统所带来的全新挑战。

Here’s where the practice typically shows up:

实践通常体现在以下方面：

- **Software engineers and ML engineers** writing prompts and building tools for agents to use, tracing why an agent made specific tool calls, and refining the underlying models  
- **软件工程师与机器学习工程师**：编写提示词（prompts），构建供智能体（agents）使用的工具，追踪智能体为何做出特定的工具调用，并持续优化底层模型。

- **Platform engineers** building agent infrastructure that handles durable execution and human-in-the-loop workflows  
- **平台工程师**：构建支持持久化执行与人工介入（human-in-the-loop）工作流的智能体基础设施。

- **Product managers** writing prompts, defining agent scope, and ensuring the agent solves the right problem  
- **产品经理**：编写提示词，定义智能体的能力边界（scope），并确保智能体真正解决了正确的问题。

- **Data scientists** measuring agent reliability and identifying opportunities for improvement  
- **数据科学家**：评估智能体的可靠性，并识别可优化的关键环节。

These teams embrace rapid iteration, and you'll often see software engineers tracing errors and handing off to PMs to tweak prompts based on those insights, or PMs identifying scope issues that require new tools from engineers. Each recognizes that the real work of hardening an agent happens through this cycle of observing production behavior and systematically refining based on what they learn.

这些团队普遍采用快速迭代模式。你常常会看到软件工程师追踪线上错误，再将洞察反馈给产品经理，由后者据此调整提示词；或产品经理识别出能力边界问题，进而推动工程师开发新的工具。各方都意识到：真正让智能体稳健可靠的关键，在于持续观察其在线上环境中的实际行为，并基于所获洞见进行系统性优化。

### Why agent engineering, and why now?

### 为何需要“智能体工程”？又为何是现在？

Two fundamental shifts have made agent engineering necessary.

两大根本性转变，使“智能体工程”成为必然。

First, LLMs are powerful enough to handle complex, multi-step workflows. We’ve been seeing it with agents taking on whole jobs, not just tasks. Clay uses agents to handle everything from prospect research to personalized outreach and CRM updates. LinkedIn uses agents to scan massive talent pools for recruiting, ranking candidates and surfacing the strongest matches instantly. We’re starting to cross the threshold where agents are delivering meaningful business value in production.

首先，大语言模型（LLMs）已足够强大，能够处理复杂、多步骤的工作流。我们已看到智能体不再仅执行单一任务，而是承担起整项工作——例如，Clay 公司利用智能体完成从潜在客户调研、个性化外联到 CRM 系统更新的全流程；LinkedIn 则借助智能体大规模扫描人才库用于招聘，实时对候选人排序并即时推荐最优匹配人选。我们正迈入一个关键拐点：智能体已在生产环境中切实创造可观的业务价值。

Second, that power comes with real unpredictability. Simple LLM apps, though non-deterministic, tend to have more contained behavior. Agents are different. They reason across multiple steps, call tools, and adapt based on context. The same things that make agents useful also make them behave differently than traditional software. This usually means that:

其次，这种强大能力也伴随着真实的不可预测性。尽管传统 LLM 应用本身即具非确定性（non-deterministic），但其行为范围相对可控；而智能体则截然不同——它们需跨多个步骤进行推理、调用外部工具，并依据上下文动态调整策略。恰恰是这些赋予智能体实用价值的特性，也使其行为显著区别于传统软件。这通常意味着：

- **Every input is an edge case.** There's no such thing as a "normal" input when users can ask anything in natural language. When you type in “make it pop” or “do what you did last time but differently”, the agent (just like a human) can interpret the prompts in different ways.  
- **每个输入都是边缘案例（edge case）。** 当用户可用自然语言提出任意请求时，“常规输入”便不复存在。当你输入“让它更出彩些”或“按上次的方式做，但换种风格”，智能体（如同人类一样）可能对提示词产生多种理解。

- **You can’t debug the old way.** Because so much logic lives inside the model, you have to inspect each decision and tool call. Small prompt or config tweaks can create huge shifts in behavior.  
- **你无法沿用旧有的调试方式。** 由于大量逻辑内嵌于模型之中，你必须逐层审视每一步决策与每一次工具调用；微小的提示词或配置调整，都可能引发行为上的巨大变化。

- **“Working” isn’t binary.** An agent can have 99.99% uptime while still being off the rails and broken. There aren’t always simple yes/no answers to the questions that matter, like: is the agent making the right calls? Using tools the right way? Following the intent behind your instructions?  
- **“正常运行”并非非黑即白。** 智能体即便拥有 99.99% 的可用率，仍可能严重偏离预期、实质失效。那些真正关键的问题——例如：“智能体是否做出了正确的工具调用？”“是否以恰当方式使用了工具？”“是否准确遵循了指令背后的意图？”——往往没有简单的“是/否”答案。

When you put this all together — agents running real, high impact workflows yet behaving in ways that traditional software can’t solve — there’s an opportunity and the need for a new discipline. Agent engineering lets you harness the power of LLMs while building systems you can actually trust in production.

当上述所有因素叠加在一起——智能体正在运行真实、高影响力的工作流，其行为模式却远超传统软件工程方法所能应对的范畴——一种新学科的诞生既是机遇，更是迫切需求。“智能体工程”（Agent Engineering）正是这样一门学科：它让我们既能充分释放大语言模型的强大能力，又能构建出真正值得信赖、可稳定投入生产的系统。

### What does agent engineering look like in practice?

### “智能体工程”在实践中究竟如何开展？

Agent engineering operates on a different principle than traditional software development. To achieve a reliable agent system, shipping is how you learn, not what you do after learning.

智能体工程（Agent engineering）遵循的原理与传统软件开发截然不同。要构建一个可靠的智能体系统，“发布”本身就是学习的过程，而非学习完成之后才去做的事。

We’ve seen successful eng teams follow a cadence for agent development that looks something like this:

我们观察到，那些成功交付智能体产品的工程团队，其智能体开发节奏大致如下：

- **Build your agent’s foundation.** Start with designing your agent's foundation, whether it's a simple LLM call with tools or a complex multi-agent system. Your architecture depends on how much workflow (deterministic step-by-step processes) versus agency (LLM-driven decisions) you need.

- **夯实智能体的基础架构。** 从设计智能体的基础架构起步——无论是调用带工具的简单大语言模型（LLM），还是构建复杂的多智能体系统。你的架构选择取决于任务中“工作流”（确定性的、分步执行的过程）与“自主性”（由大语言模型驱动的决策）各自所占的比重。

- **Test based on scenario you can imagine**. Test your agent against example scenarios to catch obvious issues with prompts, tool definitions, and workflows. Unlike traditional software where you can map out user flows, you can't anticipate every way users will interact with natural language input. Shift your mindset from "test exhaustively, then ship" to "test reasonably, ship to learn what actually matters.”

- **基于可设想的场景开展测试。** 使用典型示例场景对智能体进行测试，以发现提示词（prompt）、工具定义及工作流中的明显问题。与传统软件不同——后者可通过梳理用户路径（user flows）实现较完备的覆盖——你无法预先穷举用户将以何种方式与自然语言输入交互。因此，请转变思维：从“彻底测试完毕再发布”，转向“合理测试后即发布，通过真实反馈来识别真正关键的问题”。

- **Ship to see real-world behavior.** Once you ship, you’ll immediately start seeing inputs you hadn’t considered and every production trace shows what your agent actually needs to handle.

- **发布以观察真实世界的行为。** 一旦发布上线，你将立刻收到此前未曾预料到的各种输入；而每一条生产环境中的执行轨迹（trace），都在揭示你的智能体实际需要应对哪些情况。

- **Observe.** Trace every every interaction to see the full conversation, every tool called, and the exact context that informed each decision the agent made. Run evals over your production data to measure agent quality, whether you care about accuracy, latency, user satisfaction, or other criteria.

- **观测。** 对每一次交互进行完整追踪，查看完整的对话上下文、调用的每一个工具，以及影响智能体每一项决策的确切背景信息。在生产数据上运行评估（evals），衡量智能体质量——无论你关注的是准确性、响应延迟、用户满意度，还是其他指标。

- **Refine**. Once you’ve identified patterns in what's failing, refine by editing prompts and modifying tool definitions. It’s all continuous, as you can add problematic cases back to your set of example scenarios for regression testing.

- **精调。** 一旦识别出失败案例中的共性模式，即可通过修改提示词、调整工具定义等方式进行优化。整个过程是持续迭代的：你可将这些典型问题案例重新纳入示例场景集合，用于回归测试。

- **Repeat**. Ship your improvements and watch what’s changing in production. Each cycle teaches you something new about how users are interacting with your agent and what reliability actually means in your context.

- **循环往复。** 将优化成果发布上线，并持续观察生产环境中的变化。每一次迭代，都会让你更深入地理解用户如何与你的智能体互动，以及在你的具体场景中，“可靠性”究竟意味着什么。

### A new standard for engineering

### 工程实践的新标准

The teams shipping reliable agents today share one thing: they've stopped trying to perfect agents before launch and started treating production as their primary teacher. In other words, tracing every decision, evaluating at scale, and shipping improvements in days instead of quarters.

如今成功交付可靠智能体的团队，都具备一个共同点：他们不再执着于在上线前将智能体“打磨至完美”，而是转而将生产环境视作最核心的老师。换言之，就是对每一项决策进行追踪、在海量真实数据上规模化开展评估，并以“天”为单位（而非“季度”）快速发布改进。

Agent engineering is emerging because the opportunity demands it. Agents can now handle workflows that previously required human judgment, but only if you can make them reliable enough to trust. There is no shortcut, just the systematic work of iteration. The question isn't whether agent engineering will become standard practice. It's how quickly your team can adopt it to unlock what agents can do.

智能体工程应运而生，源于现实机遇的迫切需求。如今，智能体已能承担过去必须依赖人类判断的工作流程——但前提是，你能让它们足够可靠、值得信赖。这里没有捷径，唯有依靠系统化的持续迭代。问题已不再是“智能体工程是否会成为行业标准”，而是：你的团队能以多快的速度采纳这一范式，从而真正释放智能体的全部潜能。
&#123;% endraw %}
