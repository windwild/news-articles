---
render_with_liquid: false
title: "Introducing Open SWE: An Open-Source Asynchronous Coding Agent"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-open-swe-an-open-source-asynchronous-coding-agent/"
date: "2026-01-15"
scraped_at: "2026-03-03T07:14:40.759571411+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

The use of AI in software engineering has evolved over the past two years. It started as autocomplete, then went to a copilot in an IDE, and in the fast few months has evolved to be a long running, more end-to-end agent that run asynchronously in the cloud.

过去两年间，人工智能在软件工程领域的应用持续演进：最初表现为代码自动补全功能，随后发展为集成于集成开发环境（IDE）中的“编程助手”（Copilot），而近几个月来，更进一步演变为一种长期运行、端到端、异步部署于云端的智能体（Agent）。

We believe that all agents will long more like this in the future - long running, asynchronous, more autonomous. Specifically, we think that they will:

我们相信，未来所有智能体都将朝着这一方向演进——长期运行、异步执行、更高程度的自主性。具体而言，我们认为它们将具备以下特征：

- Run asynchronously in the cloud  
- 在云端异步运行  

- Integrate directly with your tooling  
- 直接与您现有的开发工具链集成  

- Have enough context over your environment to properly plan tasks over longer time horizons  
- 充分理解您的开发环境上下文，从而在更长的时间跨度内合理规划任务  

- Review their own work (and fix any issues) before completing their task  
- 在任务完成前自主审查自身工作成果（并修复发现的问题）  

Over the past few months it became apparent that software engineering was the first discipline where this vision would become a reality. Yet there was no open source project that captured these characteristics.

过去几个月中，软件工程已明显成为首个能将这一愿景落地的学科领域。然而，当时尚无任何开源项目能够完整体现上述特性。

So we built [**Open SWE**](https://github.com/langchain-ai/open-swe?ref=blog.langchain.com), the first open-source, async, cloud-hosted coding agent. It connects directly to your GitHub repositories, allowing you to delegate tasks from GitHub issues or our [**custom UI**](https://swe.langchain.com/?ref=blog.langchain.com). Open SWE operates like another engineer on your team: it can research a codebase, create a detailed execution plan, write code, run tests, review its own work for errors, and open a pull request when it's finished.

因此，我们推出了 **[Open SWE](https://github.com/langchain-ai/open-swe?ref=blog.langchain.com)** ——首个开源、异步、云端托管的编程智能体。它可直接接入您的 GitHub 仓库，支持您通过 GitHub Issue 或我们的 **[自定义用户界面](https://swe.langchain.com/?ref=blog.langchain.com)** 下达任务。Open SWE 的运作方式如同您团队中的一名工程师：它能研读代码库、制定详尽的执行计划、编写代码、运行测试、自主审查并修正错误，最终提交 Pull Request。

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_001.png)Open SWE contributions to the LangGraph repository

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_001.png)Open SWE 对 LangGraph 仓库的贡献

We've been using it internally to accelerate our own development on projects like LangGraph, and the Open SWE repo itself where it’s already a top contributor.

我们已在内部将其用于加速 LangGraph 等项目的开发；在 Open SWE 自身的代码仓库中，它也已成为贡献度名列前茅的开发者之一。

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_002.png)Open SWE contributions to its own repository

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_002.png)Open SWE 对其自身仓库的贡献

Today, we're excited to share it with the community.

今天，我们满怀欣喜地向整个开发者社区正式发布 Open SWE。

### How to Use It

### 如何使用

You can get started with the hosted version of Open SWE in minutes. All you need is an Anthropic API key.

只需几分钟，您即可开始使用 Open SWE 的托管版本。您唯一需要的是一个 Anthropic API 密钥。

1. Visit [**swe.langchain.com**](https://swe.langchain.com/?ref=blog.langchain.com).  
1. 访问 [**swe.langchain.com**](https://swe.langchain.com/?ref=blog.langchain.com)。

2. Connect your GitHub account and select the repositories you want Open SWE to access.  
2. 关联您的 GitHub 账户，并选择您希望 Open SWE 访问的代码仓库。

3. Provide your Anthropic API key in [settings](https://swe.langchain.com/settings?tab=api-keys&ref=blog.langchain.com).  
3. 在 [设置页面](https://swe.langchain.com/settings?tab=api-keys&ref=blog.langchain.com) 中输入您的 Anthropic API 密钥。

4. Start a new task and watch it go!  
4. 启动一项新任务，然后静观其成！

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_003.png)Open SWE Homepage  
![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_003.png)Open SWE 首页

If you’re looking for a place to start, you can check out the [**examples page in our documentation**](https://docs.langchain.com/labs/swe/examples?ref=blog.langchain.com).  
如果您正寻找入门切入点，欢迎查阅我们的文档中的 [**示例页面**](https://docs.langchain.com/labs/swe/examples?ref=blog.langchain.com)。

### Why Open SWE?

### 为何要构建 Open SWE？

There are a number of open source coding projects. Why built a new one? We wanted to drive attention and focus to aspects besides just the prompts and tools used. Specifically, we wanted to highlight more of the overall flow and UX that is needed to bring these agents to the point where we can interact with them in a reliable way.

当前已有大量开源编程项目。为何还要另起炉灶？我们希望将关注点从单纯的提示词（prompts）与工具（tools）拓展至更广阔的维度——尤其是支撑智能体实现稳定、可靠人机交互的整体工作流（flow）与用户体验（UX）。

We think UI/UX is often the one of the more under-explored areas in agent building. The overall interaction pattern of your application can greatly determine the usage it gets. With asynchronous agents being such a new idea, we think there are a lot of interesting patterns to explore here. Two main points are **more control** and **deep integration**.

我们认为，UI/UX 是当前智能体（agent）开发中被严重低估的领域之一。应用程序的整体交互模式，往往直接决定了其实际采用率。而异步智能体本身尚属全新概念，其中蕴藏着大量值得探索的交互范式。我们重点关注两大方向：**更强的控制力** 与 **深度集成能力**。

**Control:** Open SWE has two main features that give you more control over your coding agent while it's running. You can interrupt the agent when you want to review work or nudge it back on track without restarting.

**控制力：** Open SWE 提供两项核心功能，让您在编码智能体运行过程中拥有更高掌控权——您可随时中断它，以便审阅进展或及时纠偏，且无需重启整个流程。

1. **Human in the loop:** When Open SWE generates a plan, it interrupts and gives you the chance to accept, edit, delete, or request changes to the plan. It missed something? Simply tell it to keep digging, and it’ll restart the planning process for your task.  
1. **人在回路中（Human-in-the-Loop）：** 当 Open SWE 生成执行计划后，会主动暂停并交由您决策：接受、编辑、删除该计划，或要求修改。若计划有所遗漏？只需指示它“继续深入探索”，它便会为您的任务重新启动规划流程。

2. **Double texting:** Most coding agents don’t support accepting new requests or feedback while they’re running. Open SWE doesn’t suffer from that constraint. If you change your mind on the product spec, want to add a new feature, or see it going off the rails, simply send it a message, and it’ll smoothly integrate that into its active session.  
2. **即时双线沟通（Double Texting）：** 大多数编码智能体在运行期间不支持接收新请求或实时反馈。Open SWE 则无此限制。若您临时调整产品需求、希望新增功能，或发现它偏离目标，只需发送一条消息，它便能无缝将其融入当前活跃会话中。

**Deeply integrated:** Open SWE integrates directly with your GitHub account and repositories, so you can assign it work like any other developer and give it context to your code. Developers already live in GitHub, so why make them learn a new product? With Open SWE, every new task is given a tracking issue. This issue is updated throughout the session with status updates, execution plans and more. When it completes a task, a pull request is automatically opened and linked back to the tracking issue.

**深度集成：** Open SWE 直接与您的 GitHub 账户及代码仓库集成，因此您可以像指派其他开发者一样为其分配任务，并赋予其完整的代码上下文。开发者本就扎根于 GitHub，何必强求他们学习一款全新产品？借助 Open SWE，每项新任务均自动生成一个跟踪议题（tracking issue）。该议题将在整个会话过程中持续更新，包括状态变更、执行计划等关键信息。当任务完成时，系统将自动创建 Pull Request，并将其关联回原始跟踪议题。

You can also trigger runs directly from GitHub:

您也可以直接从 GitHub 触发任务运行：

- Simply add a label (e.g., `open-swe-auto`) to a GitHub issue, and Open SWE gets to work. When it’s done, it opens a pull request, ready for your review. It fits into your existing process, just like a human teammate.

- 只需在 GitHub Issue 上添加一个标签（例如 `open-swe-auto`），Open SWE 即刻开始工作。完成后，它会自动发起一个 Pull Request，静待您的审核。它无缝融入您现有的开发流程，就像一位真实的人类队友。

Besides these two core pillars, there are two other components we focused on. These focus less on the interaction pattern of humans with OpenSWE, but rather on how Open SWE runs and does it work.

除上述两大核心支柱外，我们还重点构建了另外两个关键组件。它们的关注点不在于人类如何与 OpenSWE 交互，而在于 OpenSWE 自身的运行机制与工作方式。

- **Runs in an isolated sandbox** Every task runs in a secure, isolated [Daytona](http://daytona.io/?ref=blog.langchain.com) sandbox. Since each Open SWE session is given its own sandbox, you don’t need to worry about malicious commands, and can let Open SWE execute any shell command it wants. This means we can move quicker, without requiring human approval for every command it wants to run.

- **在隔离沙箱中运行**：每个任务均在安全、独立的 [Daytona](http://daytona.io/?ref=blog.langchain.com) 沙箱中执行。由于每次 Open SWE 会话都拥有专属沙箱，您无需担忧恶意命令风险，可放心授权 Open SWE 执行任意 Shell 命令。这意味着我们能显著提速——无需对每条待执行命令都进行人工审批。

- **Runs asynchronously in the cloud:** The cloud-native architecture means Open SWE can work on multiple tasks in parallel without consuming your local resources. You can assign it a list of tasks in the morning and come back to a set of PRs in the afternoon.

- **以异步方式在云端运行**：得益于云原生架构，Open SWE 可并行处理多项任务，且完全不占用您的本地计算资源。您可在上午一次性分配一连串任务，下午归来时便可见到一组已就绪的 Pull Request。

- **Plans and reviews before committing:** Many agents jump straight to code, often leading to mistakes that break your CI pipeline. Open SWE uses a multi-agent architecture with dedicated **Planner** and **Reviewer** components. The Planner researches the codebase to form a robust strategy first. After the code is written, the Reviewer checks for common errors, runs tests and formatters, and reflects on the changes before ever opening a PR. We've found this is more effective at writing workable code with fewer review cycles.

- **提交前先规划与审查**：许多智能体倾向于直接编码，常因缺乏前置思考而导致错误，进而破坏您的 CI 流水线。Open SWE 采用多智能体架构，内置专用的 **Planner（规划器）** 和 **Reviewer（审查员）** 组件。Planner 首先深入研究代码库，全面分析后制定出稳健、详尽的执行策略；待代码编写完成，Reviewer 将检查常见错误、运行测试与格式化工具，并对变更内容进行深度反思——所有这些均在 PR 创建之前完成。实践表明，该流程能更高效地产出可用代码，大幅减少反复评审的次数。

**Considerations:** Open SWE is great for complex, longer running tasks. But for small one-liner bug fixes or simple style updates, this architecture is not optimal. For tasks like these, you want the agent to be able to skip the planning and reviewing stages, and jump right into execution. We’re currently working on implementing a version of Open SWE which does just this. It runs locally via a CLI, and is more agentic, allowing it to choose whether or not it needs to plan or review its code. When this is done, Open SWE will be a true one-stop-shop for all engineering tasks, for anything from simple one-line style fixes, all the way to complete product implementation from scratch.

**注意事项**：Open SWE 非常适合处理复杂、耗时较长的任务；但对于一行修复类的小型 Bug 或简单的样式调整，当前架构并非最优解。针对此类轻量级任务，您需要智能体能够跳过规划与审查阶段，直接进入执行环节。目前，我们正在开发一个专为此类场景优化的 Open SWE 版本：它通过本地 CLI 运行，具备更强的自主性（agentic），可动态判断是否需要启动规划或审查流程。待该版本上线后，Open SWE 将真正成为覆盖全场景工程任务的一站式解决方案——无论是单行样式修正，还是从零开始的完整产品实现，皆可从容应对。

### How It Works: The Agent Architecture

### 工作原理：智能体架构

Open SWE operates using three specialized LangGraph agents that work in sequence: a Manager, a Planner, and a Programmer (which contains a sub-agent Reviewer).

Open SWE 基于三个专业化的 LangGraph 智能体协同运作，按顺序依次执行：Manager（调度器）、Planner（规划器）与 Programmer（编程器，其内部嵌套一个子智能体 Reviewer）。

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_004.png)

![](images/introducing-open-swe-an-open-source-asynchronous-coding-agent/img_004.png)

1. **Manager:** This graph is the entry point. It handles user interactions and routes tasks. When you create a task, it initializes the state and passes control to the Planner.

1. **Manager（调度器）**：该图节点为系统入口点，负责处理用户交互并分发任务。当您创建一项新任务时，它初始化全局状态，并将控制权移交至 Planner。

2. **Planner:** Before a single line of code is written, the Planner analyzes the request, researches the codebase by viewing files and running searches, and creates a detailed, step-by-step execution plan. By default, this requires a manual review step where you can edit, approve, or provide feedback on the proposed plan. If you’re feeling bold, however, you can skip this step.

2. **Planner（规划器）**：在编写任何一行代码之前，Planner 即对用户请求展开分析，通过读取文件、执行代码库搜索等方式深入调研，并生成一份细致、分步的执行计划。默认情况下，该计划需经人工审核——您可编辑、批准，或就方案提出反馈；但若您信心十足，亦可跳过此步骤。

3. **Programmer & Reviewer:** Once a plan is approved, the Programmer executes each step in the sandbox. This includes writing code, running tests, and searching the web for documentation. When the Programmer completes its tasks, it hands off to the Reviewer, which analyzes the generated code for quality, correctness, and completeness. If issues are found, it sends the task back to the Programmer with feedback for another iteration. This action-review loop continues until the code is perfect.

3. **Programmer（编程器）与 Reviewer（审查员）**：一旦计划获批，Programmer 即在沙箱中逐项执行各步骤——包括编写代码、运行测试，以及联网检索相关文档。Programmer 完成全部任务后，将成果移交 Reviewer；后者对生成代码的质量、正确性与完整性进行全面评估。若发现问题，即附上具体反馈，将任务退回 Programmer 进行下一轮迭代。这一“执行—审查”闭环将持续运转，直至代码臻于完美。

Once the Reviewer approves the work, Open SWE generates a final conclusion, opens a pull request, and marks the task as complete.

当 Reviewer 最终批准成果后，Open SWE 将生成最终结论、自动发起 Pull Request，并将该任务标记为“已完成”。

### Tech We Used: LangGraph and LangGraph Platform

### 我们所采用的技术：LangGraph 与 LangGraph 平台

Open SWE 基于 LangGraph 构建，这使我们能够对工作流中的每一步拥有更强的控制力。Open SWE 通过四个智能体（agent）协同运行，每个智能体都拥有独立的状态以及专属的输入/输出。借助 LangGraph，我们得以轻松编排所有智能体的调用流程、在任意时刻管理其状态，并妥善处理各类边界错误情形。除 LangGraph 框架外，Open SWE 还部署于 LangGraph 平台（LGP）。LGP 是专为长时间运行的智能体而设计的平台（此类智能体单次运行有时可持续长达一小时），内置持久化能力（支撑我们的“人在回路中”功能），并支持自动扩缩容（因此在必要时，我们可同时启动数百个智能体任务）。

### Refined with LangSmith

### 借助 LangSmith 进行优化

Open SWE 是一个复杂的多智能体系统。让该系统真正具备实用价值所面临的主要挑战，在于确保其输出结果具备足够高的准确性。其中最大的难点在于[上下文工程](https://blog.langchain.com/context-engineering-for-agents/)：智能体是否获得了关于如何使用工具的正确指令？它是否获取了恰当的上下文信息？若我们调整这些指令，系统性能又将如何变化？为首先调试上下文工程问题，继而评估上下文工程改进的效果，我们采用了 LangSmith——业界领先的 AI 可观测性与评估平台。

### Open Source and Extensible

### 开源且高度可扩展

我们构建 Open SWE 的初衷，是让它开箱即用、功能强大；但更令我们振奋的是，它作为社区共建基础平台的巨大潜力。整个项目完全开源，基于 LangGraph 构建，并从设计之初就致力于支持灵活扩展。

你可以 Fork 该项目仓库，自定义提示词（prompt），为内部 API 添加新工具，或修改智能体的核心逻辑，以契合团队的具体需求。我们的[**开发者文档**](https://docs.langchain.com/labs/swe/setup/intro?ref=blog.langchain.com) 提供了详尽的指南，涵盖本地搭建与自主部署全流程。

我们坚信，软件开发的未来将是人类与智能体协同协作的未来。Open SWE，正是我们面向这一开放未来的首次重大实践。

- [**立即试用 Open SWE**](https://swe.langchain.com/?ref=blog.langchain.com)  
- [**GitHub 仓库**](https://github.com/langchain-ai/open-swe?ref=blog.langchain.com)  
- [**文档**](https://github.com/langchain-ai/open-swe/tree/main/apps/docs?ref=blog.langchain.com)  
- [**YouTube 视频发布预告**](https://youtu.be/TaYVvXbOs8c?ref=blog.langchain.com)