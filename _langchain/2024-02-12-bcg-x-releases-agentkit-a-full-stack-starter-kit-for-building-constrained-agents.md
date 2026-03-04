---
render_with_liquid: false
title: "BCG X Releases AgentKit, a Full-Stack Starter Kit for Building Constrained Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/bcg-x-releases-agentkit-a-full-stack-starter-kit-for-building-constrained-agents/"
date: "2024-02-12"
scraped_at: "2026-03-03T08:13:32.346284737+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: We're very excited to share this work by BCG. We've worked closely with the BCG over the past year to help support companies bring GenAI initiatives into production. We were intrigued to hear about their AgentKit platform, and once we got a closer look we were even more excited. We hope you all are as well!**

**编者按：我们非常激动地向大家介绍波士顿咨询公司（BCG）的这项成果。过去一年中，我们与BCG密切合作，助力企业将生成式人工智能（GenAI）项目投入生产落地。当我们首次听说他们的 AgentKit 平台时便深感兴趣；而深入了解之后，更是倍感振奋。我们也衷心希望各位读者同样为之振奋！**

## **Introduction**

## **引言**

BCG X is excited to announce today's release of [AgentKit](https://github.com/BCG-X-Official/agentkit?ref=blog.langchain.com), a LangChain-based starter kit to build constrained agent applications. We frequently use LangChain inside BCG X to build GenAI applications and LangSmith to evaluate them. With AgentKit, we’re contributing back to the community by releasing something that has been useful for us in building agent-based applications for our clients.

BCG X 非常高兴地宣布今日正式发布 [AgentKit](https://github.com/BCG-X-Official/agentkit?ref=blog.langchain.com)——一个基于 LangChain 构建的入门套件，专为开发“受约束的智能体（constrained agent）”应用而设计。在 BCG X 内部，我们频繁使用 LangChain 构建生成式 AI 应用，并借助 LangSmith 对其进行评估。通过发布 AgentKit，我们将自身在为客户构建智能体应用过程中行之有效的工具回馈社区。

## **What Is AgentKit?**

## **什么是 AgentKit？**

AgentKit is a starter kit to build full-stack constrained agent applications. It is built on the latest versions of Next.js 14, FastAPI (Pydantic 2.x) and LangChain for optimal performance, security, and developer experience. Developers can use AgentKit as a foundation for your projects to:

- quickly experiment with a constrained agent architecture with a chat UI and scalable backend, and  
- build a full-stack, chat-based agent app that can scale to MVP

AgentKit 是一套用于构建全栈式“受约束智能体”应用的入门套件。它基于最新版 Next.js 14、FastAPI（Pydantic 2.x）和 LangChain 构建，兼顾高性能、高安全性与卓越的开发者体验。开发者可将 AgentKit 作为项目基础，用于：

- 快速尝试具备聊天界面与可扩展后端的受约束智能体架构；  
- 构建一款可扩展至最小可行产品（MVP）阶段的全栈式、基于聊天交互的智能体应用。

We chose to build AgentKit on top of LangChain for a couple of reasons. LangChain enables us to both work with any LLM that is right for the application, and to natively integrate with LangSmith so that we can easily evaluate the app’s performance. Moreover, it has made it easier for us to integrate helpful features such as memory management and an extensible AgentExecutor.

我们选择以 LangChain 为基础构建 AgentKit，主要出于以下几点考虑：LangChain 不仅支持灵活选用最适合特定应用场景的大语言模型（LLM），还可原生集成 LangSmith，从而便捷地评估应用性能；此外，它也显著简化了诸如内存管理、可扩展的 AgentExecutor 等实用功能的集成工作。

## **How it works**

## **工作原理**

At the heart of the AgentKit framework lies the concept of “Action Plans”, a predefined tree of tasks and decisions that the agent navigates to get to the desired output. Instead of allowing an agent full freedom of choice (like a ReAct agent), we trade off degrees of freedom for reliability by restricting the agent’s options to Action Plans that we pre-program with human experts. We then use a ‘Router Agent’ to select the most applicable Action Plan based on the user prompt and chat history.

AgentKit 框架的核心概念是“行动方案（Action Plans）”——即一组由人类专家预先定义的任务与决策树，智能体将沿此树结构导航，最终达成预期输出。不同于赋予智能体完全自主决策权（如 ReAct 智能体），我们以牺牲部分自由度为代价换取更高可靠性：将智能体的选择范围严格限定于这些由专家预设的“行动方案”。随后，我们借助一个“路由智能体（Router Agent）”，根据用户输入提示（prompt）及历史对话上下文，自动选取最适用的行动方案。

When an Action Plan is selected, a tree of Action Steps is executed, with each Action Step containing one or more tools that are executed asynchronously. The outputs of the tools in an Action Step are passed down the tree to the next set of tools, and we’ve built functionality to carefully manage the state such that each tool only receives relevant context from previous steps.

一旦选定某项行动方案，系统便会执行其对应的“行动步骤（Action Steps）”树状结构；每个行动步骤包含一个或多个异步执行的工具。前一行动步骤中各工具的输出结果将沿树向下传递，供后续步骤中的工具调用；我们还专门构建了状态管理机制，确保每个工具仅接收来自先前步骤的相关上下文信息。

To make the agent’s actions and output transparent to the users, we can signal status updates and stream output of each Action Step either as preliminary text, or in the form of an Appendix, which is a dynamic content block which can be configured to contain graphs, tables of data, code and more.

为了让用户清晰了解智能体（agent）的每一步操作与输出结果，我们可通过状态提示实时推送各“操作步骤”（Action Step）的执行进展——既可呈现为初步文本，也可组织为“附录”（Appendix）形式。“附录”是一种动态内容区块，支持灵活配置，可嵌入图表、数据表格、代码等多种内容。

![](images/bcg-x-releases-agentkit-a-full-stack-starter-kit-for-building-constrained-agents/img_001.png)![](images/bcg-x-releases-agentkit-a-full-stack-starter-kit-for-building-constrained-agents/img_002.png)

![](images/bcg-x-releases-agentkit-a-full-stack-starter-kit-for-building-constrained-agents/img_001.png)![](images/bcg-x-releases-agentkit-a-full-stack-starter-kit-for-building-constrained-agents/img_002.png)

For example, for a shipping optimization copilot, we can restrict the agent to a set of Action Plans that

例如，针对一个航运优化助手（shipping optimization copilot），我们可以将智能体的行为限定于一组预定义的“操作方案”（Action Plans），包括：

- retrieves and cleans pricing data and displays it in a table Appendix,  
- 检索并清洗运价数据，并以表格形式呈现在“附录”中；

- runs an optimization model to find the new optimal schedule, and returns the schedule in a custom Appendix for dynamic Gantt charts in Plotly,  
- 运行优化模型以生成新的最优运输排程，并将排程结果返回至自定义“附录”，在 Plotly 中渲染为动态甘特图（Gantt chart）；

- answer questions on shipping regulations, using RAG,  
- 基于检索增强生成（RAG）技术，回答有关航运法规的问题。

We’ve wrapped this functionality into a full-stack starter kit that is easy to configure, with yaml files and environment variables for actions plans and tools, and Tailwind/daisyUI for the UI.

我们已将上述能力封装为一套开箱即用的全栈启动套件（full-stack starter kit）。该套件配置便捷：通过 YAML 文件和环境变量即可定义操作方案与工具；前端采用 Tailwind CSS 与 daisyUI 构建，兼顾美观性与开发效率。

## **Motivation behind AgentKit**

## **AgentKit 的设计初衷**

BCG X is the tech build and design unit of the global management consulting firm, Boston Consulting Group (BCG). We partner with clients to build, operate, scale, and transfer capabilities and solutions that generate the greatest amount of impact for business and society.  Typically, a client will come to us because they want us to build solutions in areas that are new to them. We begin by talking to the client’s business users to understand their needs, design the product and build a first version, and then rapidly iterate to find the right solution. We have designed AgentKit to prioritize speed-to-value, keeping a few specific principles in mind: rapid development, scalability, reliability, and user-centric design. If these resonate with you, we hope AgentKit can be helpful in building your applications!

BCG X 是全球顶级管理咨询公司波士顿咨询集团（Boston Consulting Group, BCG）旗下的科技构建与设计部门。我们与客户紧密协作，共同构建、运营、规模化扩展并转移各类能力与解决方案，从而为商业与社会创造最大价值。通常，客户选择与我们合作，是因为他们希望在自身尚不熟悉的领域获得创新解决方案。我们的标准流程始于深入访谈客户的业务终端用户，精准理解其真实需求；继而开展产品设计、交付首个可用版本（MVP）；最后基于用户反馈快速迭代，持续优化，直至达成最佳解决方案。AgentKit 正是围绕“价值交付速度”（speed-to-value）这一核心目标而设计，始终贯彻四大关键原则：快速开发、易于扩展、稳定可靠、以用户为中心。若您认同这些理念，我们诚挚希望 AgentKit 能成为您构建智能应用的得力助手！

### **Build an initial proof of concept fast, then iterate with users**

### **快速构建初始概念验证，再与用户协同迭代**

Our clients expect quick, high-quality results. With the configurability and modularity of the AgentKit tech stack combined with the flexibility of LangChain, we can typically build a strong first proof of concept in just a few days. The sooner we can demo an application to business users, the sooner we can start iterating on their feedback.

我们的客户期待兼具速度与质量的交付成果。依托 AgentKit 技术栈的高度可配置性与模块化架构，再结合 LangChain 的强大灵活性，我们通常仅需数天即可构建出功能扎实、体验良好的首个概念验证（PoC）版本。越早向业务用户演示应用，就越能尽早收集真实反馈，并据此展开高效迭代。

### **Make applications that easily scale to MVP**

### **打造可平滑演进至最小可行产品（MVP）的应用**

BCG X’s success is measured by the business value we deliver. With AgentKit’s pre-built modules for authentication, user feedback monitoring, queue management, and caching—and by making it easy to deploy an AgentKit application—we’re set up well to start scaling the application to production and begin realizing value.

BCG X 的成功以我们所交付的业务价值来衡量。借助 AgentKit 提供的开箱即用模块（涵盖身份认证、用户反馈监控、队列管理及缓存），再加上 AgentKit 应用部署的简易性，我们已做好充分准备，将应用规模化部署至生产环境，并快速实现业务价值。

### **Develop applications that are safe and reliable**

### **开发安全、可靠的智能体应用**

To put agents into production for a real business use case, we need to ensure the reliability and safety of its outputs. This requires careful evaluation - an area where LangSmith has been a useful tool for us, for instance, for investigating complex traces or by constructing comprehensive Datasets. Most importantly, we need to have a degree of “cognitive control” over the agent’s actions. Similar to the “state machines” mentioned in LangChain’s recent [LangGraph blog](https://blog.langchain.com/langgraph/), we believe that agents that are more “constrained” in the choices they are able to make have huge potential. The Action Plan framework helps us route the agent to actions we know are useful, and makes it easier to implement guardrails, for instance by routing unhelpful queries to separate Action Plans, or including guardrail tools at the start of an Action Plan.

要将智能体投入真实业务场景的生产环境，我们必须确保其输出结果具备高度的可靠性与安全性。这需要严谨的评估——而 LangSmith 正是我们在此过程中得力的工具：例如，用于深入分析复杂的执行链路（traces），或构建全面、高质量的评估数据集（Datasets）。尤为关键的是，我们需要对智能体的行为施加一定程度的“认知控制”（cognitive control）。正如 LangChain 近期发布的 [LangGraph 博客](https://blog.langchain.com/langgraph/) 中所提及的“状态机”（state machines）理念，我们认为：对智能体可选行为施加合理约束，将极大释放其潜力。Action Plan 框架帮助我们将智能体精准路由至已知有效的操作路径；同时，也更便于实施各类防护机制（guardrails）——例如，将无效或有害查询路由至独立的 Action Plan，或在 Action Plan 起始阶段即集成防护类工具。

### **Build applications for business users**

### **面向业务用户的智能体应用构建**

We believe that a transparent UI/UX that clearly shows an agent’s actions and outputs is key for adoption with business users. AgentKit’s UI is deliberately designed to show what the agent is doing at every step, while using streaming to show its preliminary outputs. And we have included support for rendering of tables, dynamic visualizations such as graphs, Gantt charts, images, and code to support a wide range of business use cases.

我们坚信：一个透明、直观的用户界面与交互体验（UI/UX），能够清晰呈现智能体的每一步操作及其输出结果，是赢得业务用户采纳的关键。AgentKit 的 UI 经过精心设计，可在每个步骤中实时展示智能体正在执行的操作，并通过流式响应（streaming）即时呈现其初步输出。此外，我们还内置了对表格、动态可视化图表（如折线图、甘特图）、图像及代码块等多种内容类型的渲染支持，从而全面适配广泛多样的业务应用场景。

## **Learn more**

## **进一步了解**

If you are interested in learning more or would like to try out AgentKit for yourself, explore the [GitHub repo,](https://github.com/BCG-X-Official/agentkit?ref=blog.langchain.com) our [AgentKit documentation](https://agentkit.infra.x.bcg.com/docs/introduction?ref=blog.langchain.com), or a demo of an [AgentKit codebase helper.](https://agentkit.infra.x.bcg.com/?ref=blog.langchain.com)

如果您希望深入了解 AgentKit，或希望亲自试用，欢迎访问 [GitHub 仓库](https://github.com/BCG-X-Official/agentkit?ref=blog.langchain.com)、查阅 [AgentKit 官方文档](https://agentkit.infra.x.bcg.com/docs/introduction?ref=blog.langchain.com)，或体验 [AgentKit 代码库助手演示版](https://agentkit.infra.x.bcg.com/?ref=blog.langchain.com)。

To date, some of the projects BCG X has used AgentKit for include:

截至目前，BCG X 已运用 AgentKit 开展的部分项目包括：

- 为一家全球性制药企业生成复杂临床文件（如临床试验方案）的初稿  
- 利用智能体助手对供应链优化系统进行控制与协同编排  
- 为一家大型汽车企业开发客户服务聊天机器人  
- ……以及更多项目