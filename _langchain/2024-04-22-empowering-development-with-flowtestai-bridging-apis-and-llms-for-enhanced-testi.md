---
render_with_liquid: false
title: "Empowering Development with FlowTestAI: Bridging APIs and LLMs for Enhanced Testing and Privacy"
source: "LangChain Blog"
url: "https://blog.langchain.com/empowering-development-with-flowtestai/"
date: "2024-04-22"
scraped_at: "2026-03-03T08:04:22.451492666+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Editor's note: we're excited to highlight this blog from FlowTestAI. FlowTestAI is an exciting startup building on top of LangChain. Specifically, they try to enable easy accessing of APIs through LLMs. Interacting with APIs via LLMs is a huge use case of LangChain, and so we're excited to showcase what this looks like in a production application.**

**编者按：我们非常高兴向大家推荐这篇来自 FlowTestAI 的博客。FlowTestAI 是一家令人振奋的初创公司，基于 LangChain 构建。其核心目标是借助大语言模型（LLM）实现对 API 的便捷调用。通过 LLM 与 API 交互，正是 LangChain 最重要的应用场景之一；因此，我们非常期待向大家展示这一能力在真实生产应用中的具体呈现。**

Independent APIs when connected together are very powerful. Virtually every online interaction, whether it involves external customers, internal use, or routine end-to-end testing, essentially constitutes a network of interconnected APIs as a _flow_. This interconnectedness forms the backbone of digital product experiences.

彼此独立的 API 在连接后将展现出强大威力。事实上，几乎所有线上交互——无论是面向外部客户、内部员工，还是常规的端到端测试——本质上都构成了一组相互关联的 API 所组成的 _流程（flow）_。这种互联互通，构成了数字产品用户体验的基石。

Parallel to the capability of APIs, Large Language Models (LLMs) exhibit remarkable reasoning prowess, closely mirroring human iterative thought processes in problem-solving. This ability to iteratively refine understanding and responses, positions LLMs as a formidable tool in computational reasoning, particularly when engaged in repetitive iterations as a _flow_.

与 API 的能力并行发展的是，大语言模型（LLM）展现出卓越的推理能力，其问题求解过程高度模拟人类反复迭代的思维模式。这种持续深化理解与优化响应的能力，使 LLM 成为计算推理领域中极具威力的工具——尤其当它被嵌入重复性迭代的 _流程（flow）_ 中时。

# Introducing FlowTestAI:

# 介绍 FlowTestAI：

At the heart of our innovation lies the mission to synergize these two powerful domains. FlowTestAI stands as the world’s first GenAI powered OpenSource Integrated Development Environment (IDE) specifically designed to craft, visualize, and manage API first workflows. Characterized by its speed, lightweight architecture, and local operation, FlowTestAI safeguards privacy while facilitating the seamless integration of API first workflows.

我们创新的核心使命，在于深度融合这两大强大技术领域。FlowTestAI 是全球首个由生成式 AI（GenAI）驱动的开源集成开发环境（IDE），专为构建、可视化和管理“以 API 为先”的工作流而设计。凭借其高速响应、轻量级架构与本地化运行特性，FlowTestAI 在保障用户隐私的同时，助力“API 优先”工作流的无缝集成。

## Addressing the Testing Conundrum:

## 应对测试困境：

Testing remains a crucial yet fragmented aspect of product development. The absence of comprehensive and robust end-to-end tests significantly jeopardizes product integrity, slowing down development velocity.

测试始终是产品开发中至关重要却高度割裂的一环。缺乏全面、健壮的端到端测试，将严重危及产品质量，并显著拖慢开发节奏。

Fundamentally, end to end tests are nothing but API first workflows. The ideal framework should allow for rapid and straightforward generation of these workflows, coupled with their seamless management without sacrificing efficiency. Yet, current practices are marred by excessive boilerplate code, cumbersome management layers, and a detachment from actual development practices. This results in slow and complicated end to end tests that really hammer development velocity.

从根本上讲，端到端测试本质上就是“以 API 为先”的工作流。理想的测试框架应支持快速、直观地生成此类工作流，并实现高效、无缝的统一管理，且不牺牲执行效率。然而，当前实践普遍存在大量样板代码、繁重的管理层，以及与实际开发流程脱节等问题。其结果是：端到端测试变得缓慢而复杂，严重拖累开发速度。

Efficient testing also necessitates secure access to and management of sensitive information, such as access IDs and keys. Unfortunately, the current landscape lacks a tool that ensures safety in this domain. Utilizing conventional platforms like Postman for entering credentials exposes them to potential risks. Compounding this issue is the absence of a dedicated environment for developers to safely test in-development or private APIs. Like with credentials, introducing these APIs into common online tools inadvertently risks exposure. This gap underscores the need for a solution that provides a secure, local sandbox for testing, devoid of the vulnerabilities associated with current methodologies.

高效的测试还要求对敏感信息（如访问 ID 和密钥）进行安全访问与管理。遗憾的是，当前生态中尚无一款工具能切实保障该环节的安全性。使用 Postman 等传统平台手动输入凭证，极易带来泄露风险。更严峻的是，开发者缺乏一个专用环境，来安全地测试正在开发中或私有的 API。正如凭证一样，若将这类 API 引入通用在线工具，同样会无意间导致暴露风险。这一空白凸显了市场对一种新型解决方案的迫切需求：它必须提供一个安全、本地化的沙箱环境用于测试，彻底规避现有方法论所固有的各类安全隐患。

## FlowTestAI’s Approach:

## FlowTestAI 的应对之道：

Leveraging the reasoning capabilities of LLMs, the organizational utility of git (or any version control system) and the structural advantages of graph data representation, FlowTestAI aims to revolutionize generation and management of API first workflow.

借助大语言模型（LLM）的推理能力、git（或任意版本控制系统）的组织管理优势，以及图数据表示的结构化优势，FlowTestAI 致力于彻底革新“以 API 为先”（API-first）工作流的生成与管理方式。

1. **Generation**: Describe your workflows in natural language, and our platform will transform them into a runnable API first workflow within seconds. Alternatively, employ drag-and-drop functionality with nodes from your OpenAPI specification to construct your workflow.

1. **生成（Generation）**：使用自然语言描述您的工作流，平台将在数秒内将其自动转化为可运行的“以 API 为先”工作流。您也可通过拖放方式，直接从 OpenAPI 规范中选取节点来构建工作流。

2. **Management**: Emulating the functionality of conventional IDEs, FlowTestAI stores and manages everything on your local file system. Organizations can further use them to collaborate using any git-compatible tool or version control system.

2. **管理（Management）**：FlowTestAI 模拟传统集成开发环境（IDE）的功能，将所有内容存储并管理在您的本地文件系统中。组织还可借助任意兼容 git 的工具或版本控制系统开展协作。

3. **Privacy**: With everything localized to your file system, FlowTestAI enables the use of private or in-development API endpoints without risk. The platform securely stores credentials locally, ensuring they are protected from external threats.

3. **隐私（Privacy）**：由于所有数据均保留在您的本地文件系统中，FlowTestAI 可安全调用私有 API 或尚在开发中的 API 端点，无泄露风险。平台将认证凭据（credentials）安全地本地存储，有效抵御外部威胁。

4. **Visualization**: By offering a no code - graphical representation of API first workflows, FlowTestAI eliminates the disconnect between testing and development teams, fostering a unified point of view or a single source of truth for the whole organization that helps accelerate development velocity.

4. **可视化（Visualization）**：FlowTestAI 提供零代码、图形化的“以 API 为先”工作流视图，弥合测试团队与开发团队之间的认知鸿沟，为整个组织建立统一视角或单一可信源（single source of truth），从而显著提升研发效能。

5. **Speed:** FlowTestAI outputs API first workflows devoid of any boilerplate or un-necessary code. This results in faster execution time leading to high development velocity.

5. **速度（Speed）**：FlowTestAI 输出的“以 API 为先”工作流不包含任何样板代码（boilerplate）或冗余代码，执行更轻量、更迅速，进而大幅提升开发效率。

## Future Scope

## 未来展望

(Re)Imagining end to end tests as API first workflows is just touching the surface. The tool is designed to be as generic as possible. One can create any API first workflow and can automate that to run periodically. For instance, imagine a workflow that checks in JIRA for top 10 customer support tickets, sends it to ChatGPT to summarize and post it daily in a slack channel for engineering teams to prioritize.

将端到端测试重新构想为“以 API 为先”的工作流，仅是本项目潜力的冰山一角。该工具被设计为高度通用化：用户可创建任意类型的“以 API 为先”工作流，并自动化其周期性执行。例如：设想一个工作流，每日自动从 JIRA 中拉取最紧急的 10 个客户支持工单，交由 ChatGPT 进行摘要生成，并将结果自动发布至工程团队的 Slack 频道，辅助优先级决策。

Because of the free and open source nature of this project, anybody can create and submit a custom node with custom logic that you feel is helpful and share it with the community. You can also create custom flows and submit it for others to use. For instance a custom flow can take an LLM output as input, send it to a sentiment analysis tool’s API hosted on AWS or Azure, check if the output positive score is greater than let’s say 0.7 and then only forward that input to the rest of the graph or to the end user.

得益于本项目的免费开源（FOSS）属性，任何人都可开发并提交具备自定义逻辑的节点（custom node），分享给社区使用；您也可创建完整的自定义工作流（custom flow）并开放给他人复用。例如：一个自定义工作流可接收大语言模型（LLM）的输出作为输入，将其发送至部署在 AWS 或 Azure 上的情感分析（sentiment analysis）工具 API，判断其正面情感得分是否高于预设阈值（如 0.7），仅当满足条件时，才将该输入转发至工作流图的其余部分或最终用户。

Imagine each workflow as a utility that can be used and nested inside other workflows.

请将每个工作流视作一个可复用的工具（utility）——它既可独立使用，也可嵌套于其他更复杂的工作流之中。

# How FlowTestAI works

# FlowTestAI 的工作原理

FlowTestAI is essentially comprised of two parts -

FlowTestAI 的核心架构主要由两大部分构成：

## Experience

## 开发体验（Experience）

For experience we offer an Integrated Development Experience (IDE) just like VS code, intellij etc.. as an electron app. Everything works locally with a two way communication just like a traditional IDE. Any CRUD operation that you perform inside our IDE is updated on local disk and similarly local disk changes are mirrored in our IDE. Here is how it looks -

在开发体验层面，我们提供一款基于 Electron 构建的集成式开发环境（Integrated Development Experience, IDE），其交互逻辑与 VS Code、IntelliJ 等主流 IDE 高度一致。所有操作均在本地运行，实现 IDE 与本地文件系统之间的双向实时同步：您在 IDE 内执行的任意增删改查（CRUD）操作，将即时写入本地磁盘；反之，本地磁盘上的任何变更也会实时反映在 IDE 界面中。界面效果如下所示 —

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_001.jpg)

Here is how it works :

它的工作原理如下：

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_002.jpg)

## AI

## 人工智能

There are three main stages in our pipeline :

我们的流水线包含三个主要阶段：

### Pre-processing

### 预处理

This is where **LangChain** is a boon to us . Let’s first understand the problem. OpenAPI specs are huge, comprising 1000s of APIs (referred as functions also) and LLMs out there can only take a limited number of functions as reference input, for instance OpenAI GPT 3.5 turbo can only take 128 functions as input.

这正是 **LangChain** 大放异彩之处。我们先来理解这一问题：OpenAPI 规范规模庞大，通常包含成百上千个 API（也称为函数），而当前主流大语言模型（LLM）仅能接受有限数量的函数作为参考输入；例如，OpenAI 的 GPT-3.5 Turbo 最多仅支持 128 个函数作为输入。

So first we parse out {API\_NAME, API\_DESCRIPTION} for each API defined in the spec and construct this one large document. Using LangChain’s out of the box text splitters we split this document into n sized chunks depending on the LLM capacity. If we take the above example of GPT 3.5 turbo, we divide it into 32 sized chunks i.e each chunk comprises 32 functions. Next we use LangChain’s wrapper over OPENAI embedding api to embed each chunk and store all these chunks in an in-memory vector database offered out of the box by LangChain.

因此，我们首先从规范中解析出每个 API 的 `{API_NAME, API_DESCRIPTION}`，并将其整合为一份大型文档。接着，借助 LangChain 内置的文本切分器（text splitters），我们根据目标 LLM 的容量限制，将该文档切分为大小为 *n* 的若干片段。以 GPT-3.5 Turbo 为例，我们将文档划分为每块含 32 个函数的片段。随后，我们调用 LangChain 封装的 OpenAI Embedding API，为每个片段生成嵌入向量，并将所有嵌入结果存入 LangChain 原生支持的内存向量数据库中。

By doing the above, we basically re-imagine the RAG problem, which is majorly used for text inputs, for structured functions.

通过上述操作，我们本质上将原本主要面向文本输入的 RAG（检索增强生成）范式，重新构想并适配到了结构化函数场景中。

### Processing

### 处理阶段

Next we take the user prompt and do a similarity search against LangChain’s powered in-memory vector database where we stored all our small chunks. We extract m documents such that n x m satisfies LLM’s input limit. So taking our previous example we would extract 4 documents such that 32 x 4 = 128.

接下来，我们接收用户提示（prompt），并在 LangChain 驱动的内存向量数据库中执行相似性搜索——该数据库中已存储了我们全部的小型文本块。我们提取 m 个文档，使得 n × m 满足大语言模型（LLM）的输入长度限制。以我们之前的示例为例，将提取 4 个文档，即 32 × 4 = 128。

Next we give these n x m functions and user instruction as input to the LLM. We do this process iteratively until we determine that there are no more further operations to be performed. Each iteration outputs a function call.

接着，我们将这 n × m 个函数及用户指令共同作为输入提供给大语言模型（LLM）。该过程以迭代方式持续执行，直至判定无需再进行任何后续操作为止。每次迭代均输出一个函数调用。

### Post-processing

### 后处理

Next we take the set of function calls output in the previous step and perform post processing. We have put proper GUARDRAILS to determine if the LLM hallucinated at any step of the process and if it does, we filter that part of the output to not mislead the user. Then we take each valid function call, parse it and convert it into our internal graph node assigning appropriate values to query parameters, request body etc. required by the API call. Finally we chain them to form a runnable workflow.

接下来，我们对上一步输出的全部函数调用集合执行后处理。我们已部署完善的 **防护机制（GUARDRAILS）**，用于检测大语言模型（LLM）在流程任意环节是否产生幻觉（hallucination）；一旦检测到，即过滤掉对应部分的输出，避免误导用户。随后，我们逐一解析每个有效函数调用，并将其转换为内部图结构中的节点，为查询参数（query parameters）、请求体（request body）等 API 调用所必需的字段赋予恰当值。最终，将这些节点串联起来，构成一个可执行的工作流。

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_003.jpg)

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_003.jpg)

Some points to watch out for -

以下几点值得关注：

1. **Langchain** offers such a vast domain of things for LLM pipeline construction out of the box that it makes it easy to split, embed, store and search data in an in memory vector database all just in a few lines of code. 🖖  
1. **LangChain** 开箱即用地提供了极为丰富的功能模块，极大简化了大语言模型（LLM）流水线的构建工作——仅需数行代码，即可完成文本切分、嵌入（embedding）、内存向量数据库存储与检索等全流程操作。🖖  

2. We pass very limited but sufficient information to the LLM to avoid leaking too much information to the LLM especially in cases where users who don’t want to expose too much of their API spec.  
2. 我们仅向大语言模型（LLM）传递**极其有限但足以支撑任务完成的信息**，从而避免信息过度泄露——尤其适用于那些不希望过多暴露自身 API 规范的用户场景。

3. Once we get the output from LLM, it is parsed, chained and rendered as a runnable graph to the user where each node represents the API request with prefilled query or path parameters or request body and each edge represents the next operation. Users can now run it, modify it and save it.  
3. 一旦获取大语言模型（LLM）的输出，系统即对其进行解析、串联，并以**可执行图（runnable graph）** 的形式呈现给用户：图中每个节点代表一个已预填充查询参数（query parameters）、路径参数（path parameters）或请求体（request body）的 API 请求；每条边则表示后续操作。用户现在可直接运行该图、修改其中任意节点，或将其保存。

4. LLMs do hallucinate sometimes, we have put proper guardrails to make sure that if LLM hallucinates we filter that part of the output.  
4. 大语言模型（LLM）有时确实会产生幻觉（hallucination），我们已部署完善的防护机制（guardrails），确保一旦发生幻觉，即刻过滤掉对应输出部分。

5. We are working on integrating other LLMs like Gemini etc.  
5. 我们正在推进与其他大语言模型（如 Gemini 等）的集成工作。

6. We will soon be launching AI powered summarization of generated logs when you run a workflow, so that it is easy to spot where your flow breaks.  
6. 我们即将推出基于 AI 的日志摘要功能：当您运行工作流时，系统将自动生成并摘要相关日志，帮助您快速定位流程中断或失败的具体环节。

# Demo

# 演示

Step 1 :  Choose model as OPENAI and add your instruction

步骤 1：选择模型为 OPENAI，并输入您的指令

![](https://lh7-us.googleusercontent.com/NMsmePs6BdMe1glbQXBdOxComMTY7XW81w2WUUaQr4NAbPTMJJ9XLdIy7f3YXjR5sHkCxKGYsX1PVxdq7UsebBCPVSe8sRUvg2geBUL9Jkc0oLGNKdg2NiKFIeItoplAIQgKpwsaKXsLL1JWVT6CZAM)

Step 2 :  Click Generate and a runnable graph will be output with API requests chained together and notice that each request is pre-filled with correct request parameters and request body

步骤 2：点击“生成（Generate）”，系统将输出一个可运行的流程图，其中 API 请求已串联成链；请注意，每个请求均已预填充了正确的请求参数和请求体。

![](https://lh7-us.googleusercontent.com/i79DAFFTghHnNQB19ZIRoasfl_-6hr6DfnePWKKFfKs0tJEuNzwOS88Skrc9Eg6XyGceyOcyFaVTfEGOvpd2dHzwFUF53raLOhcTf-OeOO8WiVryWZCcN5wO5qSP9FFUaoHyyzOLNPF3uGrNYC8LrMg)

Step 3 :  Click Run and see each request logs with total time of the flow at the end.

步骤 3：点击“运行（Run）”，查看每个请求的日志，并在流程末尾显示整个流程的总耗时。

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_006.jpg)

Step 4 :  Add extra logical nodes and make the graph even more rich

步骤 4：添加额外的逻辑节点，使流程图更加丰富、功能更加强大。

![](images/empowering-development-with-flowtestai-bridging-apis-and-llms-for-enhanced-testi/img_007.jpg)

# Conclusion:

# 结论：

FlowTestAI visualizes your end to end tests as API first workflows that are quick to generate, seamless to manage and run miles faster than traditional tests all leading to high development velocity.

FlowTestAI 将您的端到端测试以“API 优先”的工作流形式进行可视化——这类工作流生成迅速、管理顺畅，且运行速度远超传统测试，从而显著提升开发效能。

We are just getting started, and our aim is to foster a culture where, just as other IDEs are available for developers to write code, a similar integrated experience should also be available for easily generating, managing, and running API-first workflows at **NO COST**.

我们才刚刚起步。我们的目标是营造一种开发文化：正如开发者已有各类 IDE 用于编写代码，同样也应提供一套集成化体验，让团队能够**免费**（**NO COST**）地轻松生成、管理与运行 API 优先的工作流。

For more information on how to utilize this tool in your daily activities, integrate it into your current stack, or for any other inquiries, feel free to contact us through our [social media platforms](https://flowtestai.gitbook.io/flowtestai?ref=blog.langchain.com) or directly email me at [jsajal1993@gmail.com](mailto:jsajal1993@gmail.com).

如需了解如何在日常工作中使用本工具、将其集成至您当前的技术栈，或有任何其他问题，欢迎通过我们的[社交媒体平台](https://flowtestai.gitbook.io/flowtestai?ref=blog.langchain.com)联系我们，或直接发送邮件至 [jsajal1993@gmail.com](mailto:jsajal1993@gmail.com)。