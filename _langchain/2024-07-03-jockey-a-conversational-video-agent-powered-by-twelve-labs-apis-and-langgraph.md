---
title: "Jockey: A Conversational Video Agent Powered by Twelve Labs APIs and LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/jockey-twelvelabs-langgraph/"
date: "2024-07-03"
scraped_at: "2026-03-03T07:59:33.402854654+00:00"
language: "en-zh"
translated: true
description: "Guest blog post on how Jockey, a conversational video agent, uses LangGraph and Twelve Labs API for more intelligent video processing."
---
{% raw %}

_This is a guest blog post authored by James Le and Travis Couture at Twelve Labs. You can also read this blog post on the_ [_Twelve Labs blog_](https://www.twelvelabs.io/blog/introducing-jockey?ref=blog.langchain.com) _._

_本文为 Twelve Labs 公司的 James Le 与 Travis Couture 撰写的客座博客文章。您也可在[_Twelve Labs 博客_](https://www.twelvelabs.io/blog/introducing-jockey?ref=blog.langchain.com)上阅读该文。_

## 1 - Overview of Twelve Labs APIs

## 1 — Twelve Labs API 概览

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_001.png)

[Twelve Labs](https://www.twelvelabs.io/?ref=blog.langchain.com) 提供业界领先的[视频理解 API](https://docs.twelvelabs.io/reference/api-reference?ref=blog.langchain.com)，可从视频内容中提取丰富、深入的洞察与信息。这些 API 依托先进的视频基础模型（Video Foundation Models, VFMs），原生支持视频处理，无需依赖预生成字幕等中间表示形式。这使得系统能够更准确、更富上下文地理解整段视频——包括画面、音频、屏幕文字以及时间维度上的关联关系。

Twelve Labs API 的核心能力涵盖视频搜索、分类、摘要生成、问答（Q&A）等。开发者可轻松集成这些 API，构建面向多种应用场景的应用程序，例如内容发现、视频剪辑自动化、交互式视频 FAQ、AI 自动生成精彩集锦等。凭借企业级安全防护能力，以及可扩展至超大规模视频档案的处理性能，Twelve Labs API 为视频驱动型应用开辟了激动人心的新可能。

## 2 - LangGraph v0.1 and LangGraph Cloud Launch

## 2 — LangGraph v0.1 与 LangGraph Cloud 正式发布

LangChain 近日发布了 [LangGraph v0.1](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.dev)，这是一个用于构建具备更高可控性与精确性的智能体（agentic）及多智能体（multi-agent）应用的框架。与传统的 LangChain AgentExecutor 不同，LangGraph 提供了一套灵活的 API，支持开发者自定义认知架构，从而精细控制代码执行流、提示词（prompts）调用及大语言模型（LLM）调用。此外，LangGraph 内置持久化层，天然支持人机协同：可在任务执行前引入人工审批，并支持“时间旅行”（time travel）功能——即对已执行的智能体动作进行编辑与续跑。LangGraph 所具备的灵活性与底层控制能力，既适用于单智能体也适用于多智能体部署，同时显著提升了智能体的可靠性；这一特性已被 Replit、挪威邮轮公司（Norwegian Cruise Line）和 Elastic 等企业验证为关键优势。

为完善 LangGraph 生态体系，LangChain 同步推出了 [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.dev)，目前处于封闭测试（closed beta）阶段。LangGraph Cloud 是专为部署 LangGraph 智能体而打造的可扩展基础设施服务，可自动管理水平扩展的服务器集群与任务队列，高效支撑海量并发用户并持久化存储大型状态数据。该服务支持真实世界中的交互模式，例如：在当前运行的对话线程中支持“重复发送消息”（double-texting），以响应用户新输入；并支持异步后台作业（async background jobs），用于处理耗时较长的任务。LangGraph Cloud 还与 [LangGraph Studio](https://langchain-ai.github.io/langgraph/cloud/how-tos/test_deployment/?ref=blog.langchain.dev) 深度集成——这是一款用于可视化与调试智能体运行轨迹（agent trajectories）的工具，可助力开发者快速迭代、即时反馈，加速智能体应用的开发进程。

## **3 - How Jockey Leverages LangGraph and Twelve Labs APIs**

## **3 — Jockey 如何融合 LangGraph 与 Twelve Labs API**

[Jockey](https://github.com/twelvelabs-io/tl-jockey?ref=blog.langchain.com) 是一款开源的对话式视频智能体（conversational video agent），在其最新发布的 v1.1 版本中实现了显著升级。Jockey 最初基于 LangChain 构建（v1.0 版本），而此次更新全面迁移至 LangGraph，从而在前后端各项操作中获得更强的可扩展性与更优的功能表现。此次架构转型标志着 Jockey 发展历程中的关键跃升，使其能够更高效、更精准地驾驭复杂的视频工作流。

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_002.png)

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_002.png)

At its core, Jockey combines the strengths of Large Language Models (LLMs) with Twelve Labs' specialized video APIs through LangGraph's flexible framework. The LangGraph UI, as shown in the image above, illustrates the intricate network of nodes that comprise Jockey's decision-making process. This includes key components such as the supervisor, planner, video-editing, video-search, and video-text-generation nodes, each playing a crucial role in processing user queries and executing video-related tasks.

在核心层面，Jockey 通过 LangGraph 的灵活框架，将大语言模型（LLMs）的强大能力与 Twelve Labs 专业的视频 API 相融合。上图所示的 LangGraph 用户界面，清晰呈现了构成 Jockey 决策流程的复杂节点网络。其中关键组件包括：监督器（supervisor）、规划器（planner）、视频编辑（video-editing）、视频搜索（video-search）以及视频文本生成（video-text-generation）节点——每个节点都在处理用户查询及执行视频相关任务中发挥着不可或缺的作用。

One of the primary advantages of adopting LangGraph is **the granular control it provides over each step of the workflow**. This allows Jockey to precisely manage which information is passed between nodes and how their responses contribute to the overall state. Such fine-tuned control not only optimizes token usage but also enables more accurate guidance of node responses, resulting in more efficient and effective video processing.

采用 LangGraph 的主要优势之一在于：**它对工作流每一步都提供了细粒度的控制能力**。这使得 Jockey 能够精准管控各节点间传递的信息内容，以及各节点响应如何共同构建并更新系统的整体状态。这种精细化的调控不仅优化了 token 使用效率，还能更准确地引导各节点的响应行为，从而实现更高效、更精准的视频处理。

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_003.png)

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_003.png)

The above data-flow diagram of Jockey offers a clear visual representation of how information moves through the system. It showcases the decision-making process from the initial query input, through LangGraph's analysis to determine query complexity, and the subsequent routing to either a simple text response or a more complex chain of video processing steps. This includes retrieving videos from Twelve Labs APIs, combining or segmenting video content as needed, and presenting the final results to the user.

上图展示了 Jockey 的数据流向图，直观呈现了信息在整个系统中的流转路径。该图清晰刻画了从用户初始查询输入开始，经由 LangGraph 分析判断查询复杂度，再据此将请求路由至简单文本响应，或进入更复杂的视频处理链路这一决策过程。该链路涵盖：调用 Twelve Labs API 检索视频、按需合并或切分视频内容，最终将结果呈现给用户。

By leveraging LangGraph's scalable architecture and Twelve Labs' powerful video APIs, Jockey demonstrates a sophisticated approach to video understanding and manipulation. This combination allows for seamless handling of tasks ranging from video search and editing to generating text based on video content, all orchestrated through an intelligent, conversational interface.

借助 LangGraph 可扩展的架构与 Twelve Labs 强大的视频 API，Jockey 展现出一种高度成熟的视频理解与操控范式。二者结合，使系统能够无缝执行从视频检索、编辑，到基于视频内容生成文本等各类任务——所有操作均由一个智能、自然的对话式界面统一编排与驱动。

## 4 - Jockey Architecture Overview

## 4 — Jockey 架构概览

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_004.jpg)

![](images/jockey-a-conversational-video-agent-powered-by-twelve-labs-apis-and-langgraph/img_004.jpg)

Jockey's architecture is designed to efficiently handle complex video-related tasks through a sophisticated multi-agent system. As illustrated in the diagram above, the system comprises three main components: **the Supervisor**, **the Planner**, and **the Workers**, each playing a crucial role in processing user requests and executing video-related tasks.

Jockey 的架构旨在通过一套精巧的多智能体系统，高效应对复杂的视频相关任务。如上图所示，该系统由三大核心组件构成：**监督器（Supervisor）**、**规划器（Planner）** 与 **执行器（Workers）**；三者各司其职，在处理用户请求及执行视频任务过程中均发挥关键作用。

[The Supervisor](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/supervisor.md?ref=blog.langchain.com) acts as the central coordinator, responsible for routing tasks between different nodes and managing the overall workflow. It receives user input and determines the next course of action, whether it's engaging the Planner for complex requests or directing tasks to specific Workers. The Supervisor also handles error recovery and ensures the system adheres to the current plan or initiates replanning when necessary.

[监督器（Supervisor）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/supervisor.md?ref=blog.langchain.com) 充当中央协调者，负责在不同节点之间调度任务，并统筹管理整个工作流。它接收用户输入，动态判定下一步操作：对于复杂请求，调用规划器进行深度分析；对于明确任务，则直接分派至特定执行器。此外，监督器还承担错误恢复职责，确保系统严格遵循当前计划；必要时亦可触发重新规划（replanning）。

[The Planner](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/planner.md?ref=blog.langchain.com)

[规划器（The Planner）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/planner.md?ref=blog.langchain.com)

is called upon by the Supervisor to create detailed, step-by-step plans for complex user requests. This component is essential for breaking down intricate tasks into manageable steps that can be executed by the Workers. The Planner's role is particularly important when dealing with multi-step video processing workflows that require a strategic approach.

由主管（Supervisor）调用，用于为复杂的用户请求生成详尽、分步执行的计划。该组件对于将复杂任务拆解为可由“工作者（Workers）”执行的若干可控步骤至关重要。当处理需要战略性统筹的多步骤视频处理工作流时，规划器的作用尤为关键。

The Workers section consists of two key components:

“工作者（Workers）”模块包含两个核心组件：

1. [The Instructor](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/instructor.md?ref=blog.langchain.com), which generates precise and complete task instructions for individual workers based on the Planner's strategy.

1. [指导器（The Instructor）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/instructor.md?ref=blog.langchain.com)，依据规划器制定的策略，为各个工作者生成精准、完整的任务指令。

2. The Actual Workers, which are specialized agents that execute the instructions using their available tools. These include [Video Search](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_search.md?ref=blog.langchain.com), [Video Text Generation](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_text_generation.md?ref=blog.langchain.com), and [Video Editing](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_editing.md?ref=blog.langchain.com) capabilities.

2. 实际工作者（Actual Workers），即利用自身可用工具执行指令的专业化智能体。其能力涵盖 [视频搜索（Video Search）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_search.md?ref=blog.langchain.com)、[视频文本生成（Video Text Generation）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_text_generation.md?ref=blog.langchain.com) 和 [视频编辑（Video Editing）](https://github.com/twelvelabs-io/tl-jockey/blob/main/jockey/prompts/video_editing.md?ref=blog.langchain.com) 等功能。

**This architecture allows Jockey to handle a wide range of video-related tasks with flexibility and precision**. The system can dynamically adapt to different types of queries, from simple text responses to complex video manipulation tasks. By leveraging LangGraph's framework, Jockey can efficiently manage the state between nodes, optimize token usage, and provide granular control over the execution of each step in the video processing workflow.

**该架构使 Jockey 能够以高度灵活性与精确性应对各类视频相关任务**。系统可动态适配不同类型的查询——从简单的文本应答，到复杂的视频操控任务。借助 LangGraph 框架，Jockey 能高效管理各节点间的状态、优化 token 使用，并对视频处理工作流中每一步的执行提供细粒度控制。

/1:19

/1:19

1×

1×

## 5 - Customizing Jockey

## 5 — 自定义 Jockey

The modular design of Jockey also facilitates customization and extension. Developers can modify prompts, extend the state to handle more complex scenarios, or add new workers to address specific use cases, making Jockey a versatile foundation for building advanced video AI applications.

Jockey 的模块化设计亦便于定制与扩展。开发者可修改提示词（prompts）、扩展状态以支持更复杂的场景，或新增工作者以满足特定应用场景需求，从而使 Jockey 成为构建先进视频 AI 应用的通用基础平台。

[**Prompt as a Feature**](https://github.com/twelvelabs-io/tl-jockey?tab=readme-ov-file&ref=blog.langchain.com#prompt-as-a-feature)

[**提示词即功能（Prompt as a Feature）**](https://github.com/twelvelabs-io/tl-jockey?tab=readme-ov-file&ref=blog.langchain.com#prompt-as-a-feature)

This approach leverages Jockey's language model capabilities to introduce new functionalities without modifying the underlying code. For example, you could create a prompt that instructs Jockey to identify and extract specific types of scenes from videos, such as action sequences or emotional moments, without changing the core system.

该方法充分利用 Jockey 内置语言模型的能力，在不改动底层代码的前提下引入新功能。例如，您可设计一条提示词，指示 Jockey 从视频中识别并提取特定类型的场景（如动作片段或情感高潮时刻），而无需修改系统核心逻辑。

[**Extending or Modifying Jockey**](https://github.com/twelvelabs-io/tl-jockey?tab=readme-ov-file&ref=blog.langchain.com#extending-or-modifying-jockey)

[**扩展或修改 Jockey**](https://github.com/twelvelabs-io/tl-jockey?tab=readme-ov-file&ref=blog.langchain.com#extending-or-modifying-jockey)

For more substantial customizations, developers can directly modify Jockey's components:

如需更深度的定制，开发者可直接修改 Jockey 的各个组件：

1. **Modifying Prompts**: You can edit the existing prompts used by various components of Jockey, such as the Supervisor, Planner, or Workers. This allows for fine-tuning the system's decision-making process and output generation.

1. **修改提示词（Prompts）**：您可以编辑 Jockey 各组件（例如 Supervisor、Planner 或 Workers）当前使用的提示词，从而精细调节系统的决策逻辑与输出生成行为。

2. **Extending or Modifying State**: The state management in Jockey can be extended to include additional information or modified to handle new types of data. This is particularly useful when integrating Jockey with other systems or when dealing with specialized video metadata. You can add new fields to the state object or modify how existing state information is processed and passed between components.

2. **扩展或修改状态（State）**：Jockey 的状态管理机制可被扩展以容纳额外信息，也可被修改以支持新型数据类型。这一能力在将 Jockey 与其他系统集成，或处理专业化的视频元数据时尤为关键。您既可在状态对象中新增字段，也可调整现有状态信息的处理方式及其在各组件间的传递逻辑。

3. **Adding or Modifying Workers**: You can create new specialized Workers for tasks like advanced video effects or video generation, modify existing Workers to enhance their capabilities or integrate with new APIs, and implement custom logic for the Instructor to handle new types of tasks.

3. **添加或修改 Worker**：您可以为高级视频特效、视频生成等任务创建全新的专用 Worker；可改造现有 Worker 以增强其功能或对接新 API；亦可为 Instructor 实现自定义逻辑，以支持全新类型的任务。

## **6 - Conclusion**

## **6 — 结论**

Jockey represents a powerful fusion of LangGraph's flexible agent framework and Twelve Labs' cutting-edge video understanding APIs, opening up new possibilities for intelligent video processing and interaction. To get started, visit the [Jockey GitHub repository](https://github.com/twelvelabs-io/tl-jockey?ref=blog.langchain.com) and see [the LangGraph docs](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com#installation) to access source code and documentation. The [Twelve Labs APIs](https://api.twelvelabs.io/?ref=blog.langchain.com) can also help you unlock the full potential of video AI in your applications. You can deploy Jockey locally for development and testing, or leverage [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com#langgraph-cloud-beta) for scalable production deployments.

Jockey 是 LangGraph 灵活的智能体框架与 Twelve Labs 前沿视频理解 API 的强大融合，为智能化视频处理与交互开辟了全新可能。如需快速上手，请访问 [Jockey GitHub 仓库](https://github.com/twelvelabs-io/tl-jockey?ref=blog.langchain.com)，并查阅 [LangGraph 官方文档](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com#installation)，获取源代码与详细说明。[Twelve Labs API](https://api.twelvelabs.io/?ref=blog.langchain.com) 亦可助您充分释放视频 AI 在您应用中的全部潜力。您既可将 Jockey 本地部署，用于开发与测试；亦可借助 [LangGraph Cloud](https://langchain-ai.github.io/langgraph/cloud/?ref=blog.langchain.com#langgraph-cloud-beta) 实现可扩展的生产级部署。
{% endraw %}
