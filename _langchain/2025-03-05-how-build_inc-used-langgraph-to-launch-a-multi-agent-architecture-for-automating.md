---
title: "How Build.inc used LangGraph to launch a Multi-Agent Architecture for automating critical CRE workflows for Data Center Development."
source: "LangChain Blog"
url: "https://blog.langchain.com/how-build-inc-used-langgraph-to-launch-a-multi-agent-architecture-for-automating-critical-cre-workflows-for-data-center-development/"
date: "2025-03-05"
scraped_at: "2026-03-03T07:38:20.829462243+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's note: This is a guest blog post from our friends at_ [_Build.inc_](https://build.inc/?ref=blog.langchain.com) _. They built one of the more complex multi-agent workflows we've seen — with over 25 sub-agents. Check out the screenshot of their graph for an idea of the complexity. They also share practical lessons learned from building agents that we think will be helpful for other agent builders._

_编辑注：本文为来自_ [_Build.inc_](https://build.inc/?ref=blog.langchain.com) _团队的客座博客文章。他们构建了我们迄今所见最复杂的多智能体工作流之一——包含超过 25 个子智能体。请参阅其工作流图的截图，以直观感受其复杂程度。此外，他们还分享了在构建智能体过程中获得的实用经验教训，我们认为这些内容对其他智能体开发者将大有裨益。_

[Build.inc](https://build.inc/?ref=blog.langchain.com) is pushing the boundaries of agentic systems to automate manual and labour-intensive workflows in the built world. Our first “worker”, is now in production for a range of industry titans in Commercial Real Estate (CRE) aimed towards data-center development and beyond.

[Build.inc](https://build.inc/?ref=blog.langchain.com) 正在不断拓展智能体系统的能力边界，致力于自动化“建成环境”（built world）中大量依赖人工、劳动密集型的工作流程。我们的首个“工人”智能体目前已投入生产，服务于商业地产（CRE）领域的多家行业巨头，应用场景涵盖数据中心建设及更广泛领域。

Our workers are composed of a network of specialized agents performing specific, smaller tasks. Real estate stakeholders can hire our specialist workers as if they were consultants, able to perform specialized development processes. By orchestrating these agents through LangGraph, our first worker, Dougie, accomplishes in 75 minutes what previously took humans over four weeks, accelerating the world’s most critical real estate projects, including data centers, energy, and logistics.

我们的“工人”由一组执行特定、细分任务的专业化智能体构成。房地产相关利益方可以像聘用专业顾问一样调用我们的专精型“工人”，完成各类专业化开发流程。借助 LangGraph 对这些智能体进行编排，我们的首个“工人”Dougie 仅需 75 分钟即可完成过去需人类耗时逾四周的任务，从而加速全球最关键的房地产项目进程——包括数据中心、能源设施与物流基础设施等。

For Dougie, the use case is land diligence for energy-intensive industries. Think everything from data centers to solar farms. This is the task of researching a piece of land to understand if it is suitable for a particular project. This workflow is critical for our customers as getting this decision right has downstream effects which, if mishandled, will cost them millions of dollars. Part of what makes LangGraph such an attractive orchestration layer for us is that we can autonomously execute an extremely complex workflow in record time and with a depth and quality that even the most experienced human consultants cannot achieve.

Dougie 的核心应用场景是面向高能耗行业的土地尽职调查（land diligence），涵盖从数据中心到太阳能电站等各类项目。该任务旨在全面调研某块待选土地，评估其是否适配特定开发项目。这一工作流对客户至关重要：若该环节决策失误，将引发一系列连锁后果，造成数百万美元损失。LangGraph 成为我们首选编排层的重要原因之一，正在于它使我们能够以创纪录的速度自主执行极其复杂的工作流，且在分析深度与输出质量上，甚至超越经验最丰富的资深人类顾问。

![](images/how-build_inc-used-langgraph-to-launch-a-multi-agent-architecture-for-automating/img_001.jpg)

## **Overview: Automation for the Development Lifecycle**

## **概览：面向开发全生命周期的自动化**

Build.inc focuses on automating repetitive and complex development workflows for the world’s most important infrastructure projects (today that is data centers, renewable energy, small modular reactors). These workflows are typically expensive, take a long time to execute, and are performed by specialist teams of consultants. This means that before a project enters the construction phase, these workflows consume nearly half of the total project timeline and cost developers millions of dollars.

Build.inc 致力于为全球最重要的基础设施项目（当前聚焦于数据中心、可再生能源及小型模块化核反应堆）自动化重复性高、复杂度大的开发工作流。此类工作流通常成本高昂、执行周期漫长，且高度依赖专业咨询团队。这意味着，在项目正式进入施工阶段前，这些前期工作流已占据整个项目周期近一半的时间，并使开发商付出数百万美元的成本。

Solving this problem with traditional software has typically been difficult, for several reasons:

使用传统软件解决这一问题向来颇具挑战，主要原因如下：

\- **Complexity & Variability** – Each project comes with its own unique requirements and risks.

\- **复杂性与多变性**：每个项目均具备独特的需求与风险。

\- **Fragmented Data Ecosystem** – In the US alone, there are over 30,000 jurisdictions, each with its own regulations and data sources, making universal solutions difficult.

\- **数据生态碎片化**：仅在美国一国，就存在逾 30,000 个司法管辖区，各自拥有独立的法规体系与数据来源，使得通用型解决方案难以落地。

- **High-Stakes Specialist Workflows** – 每个项目所需的非凡专业深度，往往超出通用现成软件所能提供的能力范围，因此内部团队或外部专业人士成为更可行的选择。

Thus, at Build we take an agent first approach to solving our customers problems, approaching agentic systems in a novel way to execute complex, sophisticated workflows.

因此，在 Build，我们以“智能体优先”（agent-first）的理念来解决客户问题，以一种创新的方式构建智能体系统，从而执行复杂而精密的工作流。

For the sake of the audience, we will focus the rest of this post on our experience building at the edge of Applied AI rather than the specifics of the work we do for our customers.

为便于读者理解，本文后续内容将聚焦于我们在应用型人工智能（Applied AI）前沿的实践探索，而非详述我们为客户所开展的具体工作。

## **Embracing a Multi-Agent Architecture for Handling Complexity**

## **拥抱多智能体架构以应对复杂性**

To understand multi-agent systems for deterministic outputs, we start with the concept of “workers”. At Build, we define a worker as an orchestration agent that understands the make-up of a specific workflow and uses LLMs to orchestrate that workflow until it’s completed: invoking tools, managing tasks, and setting the sequence in which these tasks unfold.

要理解面向确定性输出的多智能体系统，我们首先从“工作者”（worker）这一概念入手。在 Build，我们将一个 worker 定义为一种编排型智能体（orchestration agent），它能理解某一特定工作流的构成，并利用大语言模型（LLM）对该工作流进行全程编排，直至完成：包括调用工具、管理任务，以及设定各项任务的执行顺序。

However, objectives that require sophisticated outcomes— like those that we deliver for our customers— require workers that execute through more than one agent. Just as real-world projects demand teams of specialists, multi-agent systems rely on agents that cooperate, coordinate, or even compete, each contributing distinct capabilities.

然而，那些需要产出高度复杂成果的目标——例如我们为客户交付的成果——则要求 worker 通过多个智能体协同执行。正如现实世界中的项目依赖由各领域专家组成的团队，多智能体系统也依赖于能够协作、协调甚至竞争的智能体，每个智能体贡献其独特的能力。

Even in the work of a single person, it’s often a requirement for that individual to wear multiple hats to complete a job. This is where multi-agent architectures come to life. A multi-agent system enables one agent to initiate another— extending the concept to the next level of agency, with agents operating in parallel and actively influencing one another to achieve more complex objectives.

即便在单个人的工作中，也常常需要一人身兼数职才能完成一项任务。这正是多智能体架构真正落地的场景。多智能体系统允许一个智能体启动另一个智能体——将“自主性”（agency）的概念推向更高层级：多个智能体并行运行，并主动相互影响，从而实现更复杂的目标。

Abstracting this even further, just as one worker is composed of multiple agents to achieve an outcome, a multi-stage process - such as real estate development - is composed of multiple workers, where the output of one worker can be passed to another worker until a large body of work is completed. Or workers can run in parallel to execute in tandem.

进一步抽象来看：正如一个 worker 由多个智能体协同构成以达成某一结果；一个多阶段流程——例如房地产开发——则由多个 worker 构成，前一个 worker 的输出可作为后一个 worker 的输入，如此逐级推进，直至完成整套庞大工作；或者多个 worker 并行运行，同步执行。

![](images/how-build_inc-used-langgraph-to-launch-a-multi-agent-architecture-for-automating/img_002.png)

## **How do you build a worker?**

## **如何构建一个 worker？**

At Build.inc, we deconstruct broad work activities (usually with a deterministic end goal) into smaller pieces to develop agents that are digitally analogous of how a human would physically perform that work.  
在 Build.inc，我们将宽泛的工作活动（通常具有确定性的最终目标）拆解为更小的单元，从而开发出在数字层面模拟人类实际执行此类工作的智能体。

We then recreate that workflow through the modular, composable structure suited to development with LangGraph.  
随后，我们借助模块化、可组合的架构，在 LangGraph 框架下重建该工作流。

We believe that the 'dark matter' of AI is context. It's rarely directly modeled or fully understood. In the frame of automating workflows, successful use of LLMs come down to have access to three things;  
我们认为，AI 的“暗物质”是上下文（context）。它极少被直接建模，也往往未被充分理解。在工作流自动化的语境中，大语言模型（LLM）的成功应用取决于能否获取以下三类要素：

1. Workflows: A collection of skills and capabilities organized into broader functional categories, orchestrated to achieve a larger end goal.  
1. 工作流（Workflows）：将一系列技能与能力按更广泛的职能类别进行组织，并协同编排，以实现更高层级的最终目标。

2. Data: A combination of specialized long-term knowledge and task-specific short-term information (often a proprietary or niche dataset), to guide the work output and give it depth.  
2. 数据（Data）：融合专业化的长期知识与任务特定的短期信息（通常为专有或垂直领域的数据集），用以引导工作产出并赋予其深度。

3. Integrations/Tools: Access to the right tools and integrations to execute into established systems.  
3. 集成与工具（Integrations/Tools）：接入恰当的工具与系统集成能力，以实现在既有系统中的执行。

We then recreate that workflow through the modular, composable structure suited very well to development with LangGraph. This playbook ensures each worker (and its sub-agents) is purpose-built to excel at its designated responsibilities and that we can give our customers solutions that work better and faster than anything they’ve seen before.  
我们再次依托高度适配 LangGraph 开发的模块化、可组合架构重建该工作流。这一方法论确保每个“工作者”（worker）及其子智能体均为特定职责量身打造，从而向客户提供比客户以往所见任何方案都更优、更快的解决方案。

The path to evolving our offering becomes much more flexible than traditional SaaS software. We can add new workers, transition to new models, create new agent-graphs, or expand existing agent-graphs with very little impact on what is already built. Build agents are by default compostable and modular without losing the ability to have granular control over the output.  
相较传统 SaaS 软件，我们产品能力的演进路径变得灵活得多：可随时新增“工作者”，切换至新模型，创建全新智能体图（agent-graph），或扩展既有智能体图——所有这些操作对已构建部分的影响微乎其微。Build 智能体天生具备可组合性（composable）与模块化特性，同时丝毫不牺牲对输出结果的精细化控制能力。

## **Building a Hierarchy of Agents**  
## **构建智能体层级体系**

Build.inc orchestrates over 25 sub-agent tasks in a four-tier hierarchical system. This orchestration is a digital representation of the equivalent org of human work. At the top is the Master Agent— “the Worker” —which coordinates the entire workflow and delegates tasks to Role Agents— “the Workflows” —who handle specialized functions like data collection or risk evaluation. Each Role Agent manages one or more Sequence Agents, which carry out Workflows— multi-step processes that can involve up to 30 individual tasks executed by Task Agents. The Task Agents are equipped with the most relevant tools, context and model to complete the task, passing the results back to the role agent until the worker passes the context to the next agent.  
Build.inc 在一个四级分层系统中协调超过 25 项子智能体任务。该编排机制是对人类组织化工作的数字化映射。顶层为“主智能体”（Master Agent）——即“工作者”（the Worker），负责统筹整个工作流，并将任务委派给“角色智能体”（Role Agents）——即“工作流执行者”（the Workflows），后者专精于数据采集、风险评估等特定职能。每个角色智能体管理一个或多个“序列智能体”（Sequence Agents），后者执行具体工作流——即包含最多达 30 个独立步骤的多阶段流程，每一步均由“任务智能体”（Task Agents）完成。任务智能体配备完成该任务所需的最相关工具、上下文及模型，并将结果逐级回传至角色智能体，直至“工作者”将上下文传递给下一环节智能体。

Running these steps sequentially would be incredibly time-consuming (though not as time-consuming as the four weeks it currently takes to execute the workflow manually). To this end we leverage **asynchronous execution** via LangGraph to run multiple agents in parallel, dramatically reducing overall processing time. Even with parallelization, the entire process still requires over 75 minutes from end to end— delivering a level of depth to the output that human teams can’t match even over the course of several weeks.  
若按顺序依次执行这些步骤，耗时将极为漫长（尽管仍远少于当前人工执行该工作流所需的四周时间）。为此，我们通过 LangGraph 利用**异步执行**（asynchronous execution）机制，让多个智能体并行运行，从而大幅缩短整体处理时间。即便启用并行化，端到端全流程仍需耗时逾 75 分钟——但由此产出的结果所具备的深度，是人类团队即使花费数周时间也无法企及的。

## **Practical Learnings from Building Agents**  
## **构建智能体过程中的实践启示**

1\. **Choose where to be open-ended and non-deterministic**  
1. **明确何处应保持开放性与非确定性**

Like human labour, leaving work tasks open ended can often lead  Agents don’t need to have full autonomy on the decisions they make in each step. In many cases, relying on a predefined plan instead of asking the agent to generate one every time reduces unnecessary complexity and leads to more predictable outcomes. This is ultimately great for customers.  
如同人类劳动，将工作任务保持适度开放，往往更能激发成效。智能体无需在每一步决策中都拥有完全自主权；在许多场景下，依赖预设计划（而非每次均要求智能体自行生成计划），可显著降低不必要的复杂度，并带来更可预期的结果——这对客户而言无疑是巨大优势。

2\. **Tailor Agents to Tasks**  
2. **依任务定制智能体**

On the above, each agent performs best when it’s specialized. ‘Training’ an agent can essentially be giving it the correct guardrails in a JSON file. Choose the context, model, and tools specific to each task instead of forcing a single agent to adapt to every scenario.

上述内容表明，每个智能体（agent）在专业化时表现最佳。“训练”一个智能体，本质上就是通过 JSON 文件为其设定恰当的约束条件（guardrails）。应针对每项任务分别选择最适配的上下文、模型和工具，而非强迫单个智能体去适应所有场景。

3\. **Keep Tasks Simple and Small**

3. **任务宜简宜小**

Breaking down workflows into smaller, single-purpose tasks makes it easier for agents to execute efficiently and accurately. It also allows for a more modular and composable system which is easier to understand, edit or expand upon. The more you chain, the less pain you experience.

将工作流拆解为更小、目标单一的任务，有助于智能体更高效、更准确地执行；同时也构建出更模块化、更可组合的系统，从而更易于理解、修改或扩展。链式调用（chaining）越多，实际开发与维护中的“痛苦”反而越少。

4) **Modular by Design**

4) **设计即模块化**

Represent each agent as its own LangGraph subgraph to create self-contained modules. This design simplifies orchestration and visualization, reducing interdependencies and making your system easier to debug, test, and scale.

将每个智能体表示为独立的 LangGraph 子图，从而形成自包含的模块。这种设计简化了编排（orchestration）与可视化，降低了模块间的耦合度，使系统更易于调试、测试与扩展。

## **Agentic Futures**

## **智能体驱动的未来**

At Build.inc, we envision a future where **complex, multi-layered workflows** are seamlessly automated through sophisticated orchestration, mirroring the efficiency and structure of a well-aligned organization. We do this for real estate development, but we believe that this model will extended to organizations focused on all types of professional services.

在 Build.inc，我们构想这样一种未来：**复杂、多层级的工作流**，可通过高度成熟的智能体编排技术实现无缝自动化——其效率与组织结构堪比一支高度协同的团队。目前，我们已将该模式应用于房地产开发领域；但我们坚信，这一范式终将拓展至所有类型的专业服务组织。

By owning the entire process and delivering a fully integrated, end-to-end service— not only providing standalone productivity tools— this next generation of automation has the potential to **unlock traditionally technology-resistant industries**.

通过端到端掌控整个流程，并交付完全集成的一体化服务（而不仅提供孤立的生产力工具），这一代新型自动化技术有望**撬动那些传统上对技术采纳持保守甚至抗拒态度的行业**。

We're building a world where tangible work output takes minutes rather than weeks, freeing CRE development teams to focus on relationships, strategy and creativity over routine, manual tasks.

我们正在构建这样一个世界：切实可见的工作成果只需数分钟即可完成，而非耗费数周；这将使商业地产（CRE）开发团队得以从重复性、事务性的手工劳动中解放出来，转而专注于人际关系、战略规划与创造性工作。

Through the speed and flexibility of LangGraph, Build is leading the category of autonomous CRE development services and pushing the boundaries of what agents can do.

依托 LangGraph 所赋予的卓越速度与灵活性，Build 正引领自主式商业地产开发服务这一全新品类，并不断拓展智能体能力的边界。
{% endraw %}
