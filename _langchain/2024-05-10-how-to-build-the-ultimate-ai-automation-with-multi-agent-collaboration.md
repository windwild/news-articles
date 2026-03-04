---
title: "How to Build the Ultimate AI Automation with Multi-Agent Collaboration"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/"
date: "2024-05-10"
scraped_at: "2026-03-03T08:03:01.191972235+00:00"
language: "en-zh"
translated: true
description: "Assaf Elovic, Head of R&D at Wix, walks through how to build an autonomous research assistant using LangGraph with a team of specialized agents."
tags: ["langgraph", "![Reflection Agents", "**Reflection Agents**", "agents", "**Plan-and-Execute Agents**", "By LangChain"]
---
{% raw %}

**_Editor's Note: The following post is authored by Assaf Elovic, Head of R&D at_** [**_Wix_**](https://www.wix.com/?ref=blog.langchain.com) **_. In this blog, he walks through how to build an autonomous research assistant using LangGraph with a team of specialized agents._**

**_编者按：以下文章由 Wix 研发主管 Assaf Elovic 撰写。在本文中，他将带领读者使用 LangGraph 与一组专业化智能体（agents），构建一个自主式研究助手。_**

It has only been a year since the initial release of [GPT Researcher](https://gptr.dev/?ref=blog.langchain.com), but methods for building, testing, and deploying AI agents have already evolved significantly. That’s just the nature and speed of the current AI progress. What started as simple [zero-shot](https://www.promptingguide.ai/techniques/zeroshot?ref=blog.langchain.com) or [few-shot prompting](https://www.promptingguide.ai/techniques/fewshot?ref=blog.langchain.com), has quickly evolved to agent [function calling](https://www.promptingguide.ai/applications/function_calling?ref=blog.langchain.com), [RAG](https://www.promptingguide.ai/techniques/rag?ref=blog.langchain.com) and now finally [agentic workflows](https://www.deeplearning.ai/the-batch/how-agents-can-improve-llm-performance/?utm_campaign=The+Batch&utm_source=hs_email&utm_medium=email&_hsenc=p2ANqtz--9ARMthd09q0ABUi-abo6BH62BLbcwPo13LrXs9hUezs-L050Ay7b_rHdWuRIqBVOD6k_S) (aka “ [flow engineering](https://www.techzine.eu/blogs/applications/118176/the-ai-shift-from-prompt-engineering-to-flow-engineering/?ref=blog.langchain.com)”).

自 [GPT Researcher](https://gptr.dev/?ref=blog.langchain.com) 首次发布至今仅一年时间，但 AI 智能体的构建、测试与部署方法已发生显著演进——这正是当前 AI 发展的本质与速度的体现。最初仅依赖简单的 [零样本提示（zero-shot prompting）](https://www.promptingguide.ai/techniques/zeroshot?ref=blog.langchain.com) 或 [少样本提示（few-shot prompting）](https://www.promptingguide.ai/techniques/fewshot?ref=blog.langchain.com)，如今已迅速发展为智能体的 [函数调用（function calling）](https://www.promptingguide.ai/applications/function_calling?ref=blog.langchain.com)、[检索增强生成（RAG）](https://www.promptingguide.ai/techniques/rag?ref=blog.langchain.com)，并最终迈向 [智能体工作流（agentic workflows）](https://www.deeplearning.ai/the-batch/how-agents-can-improve-llm-performance/?utm_campaign=The+Batch&utm_source=hs_email&utm_medium=email&_hsenc=p2ANqtz--9ARMthd09q0ABUi-abo6BH62BLbcwPo13LrXs9hUezs-L050Ay7b_rHdWuRIqBVOD6k_S)（亦称“[流程工程（flow engineering）](https://www.techzine.eu/blogs/applications/118176/the-ai-shift-from-prompt-engineering-to-flow-engineering/?ref=blog.langchain.com)”）。

Andrew Ng [recently stated](https://www.deeplearning.ai/the-batch/how-agents-can-improve-llm-performance/?utm_campaign=The+Batch&utm_source=hs_email&utm_medium=email&_hsenc=p2ANqtz--9ARMthd09q0ABUi-abo6BH62BLbcwPo13LrXs9hUezs-L050Ay7b_rHdWuRIqBVOD6k_S):“I think AI agent workflows will drive massive AI progress this year — perhaps even more than the next generation of foundation models. This is an important trend, and I urge everyone who works in AI to pay attention to it.”

Andrew Ng 近期指出：“我认为，AI 智能体工作流将在今年推动大规模 AI 进步——其影响甚至可能超过下一代基础模型。这是一个重要趋势，我敦促所有从事 AI 工作的人务必予以关注。”

In this article you will learn why multi agent workflows are the current best standard and how to build the optimal autonomous research multi-agent assistant using [LangGraph](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com).

本文将为您解析：为何多智能体工作流已成为当前业界最佳实践标准；以及如何借助 [LangGraph](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com) 构建最优的自主式研究型多智能体助手。

To skip this tutorial, feel free to check out the final code implementation of GPT Researcher x LangGraph [here](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com).

如需跳过本教程，可直接查看 GPT Researcher × LangGraph 的最终代码实现：[点击此处](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com)。

## Introducing LangGraph

## 介绍 LangGraph

LangGraph is an extension of LangChain aimed at creating agent and multi-agent flows. It adds in the ability to create cyclical flows and comes with memory built in - both important attributes for creating agents.

LangGraph 是 LangChain 的一项扩展，专为构建智能体及多智能体工作流而设计。它支持创建循环式流程，并内置状态记忆能力——这两项特性对构建稳健智能体至关重要。

LangGraph provides developers with a high degree of controllability and is important for creating custom agents and flows. Nearly all agents in production are customized towards the specific use case they are trying solve. LangGraph gives you the flexibility to create arbitrary customized agents, while providing an intuitive developer experience for doing so.

LangGraph 为开发者提供了高度可控性，是构建定制化智能体与工作流的关键工具。目前几乎所有投入生产的智能体，均针对其特定应用场景进行了深度定制。LangGraph 不仅赋予您构建任意定制化智能体的灵活性，还通过直观易用的开发体验，大幅降低实现门槛。

Enough with the smalltalk, let's start building!

闲话少说，马上开始构建！

## Building the Ultimate Autonomous Research Agent

## 构建终极自主式研究智能体

By leveraging LangGraph, the research process can be significantly improved in depth and quality by leveraging multiple agents with specialized skills. Having every agent focus and specialize only a specific skill, allows for better separation of concerns, customizability, and further development at scale as the project grows.

通过利用 LangGraph，研究过程的深度与质量可借助多个具备专业技能的智能体（agents）得到显著提升。让每个智能体仅专注于并精于某一项特定技能，有助于实现更清晰的关注点分离（separation of concerns）、更高的可定制性，并随着项目规模扩大而持续扩展开发。

Inspired by the recent [STORM](https://arxiv.org/abs/2402.14207?ref=blog.langchain.com) paper, this example showcases how a team of AI agents can work together to conduct research on a given topic, from planning to publication. This example will also leverage the leading autonomous research agent [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com).

本示例受近期论文 [STORM](https://arxiv.org/abs/2402.14207?ref=blog.langchain.com) 启发，展示了多个 AI 智能体如何协同合作，围绕指定主题开展从规划到成果发布的全流程研究。本示例还将集成当前领先的自主研究智能体 [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)。

### The Research Agent Team

### 研究智能体团队

The research team consists of seven LLM agents:

研究团队由七个大语言模型（LLM）智能体组成：

- **Chief Editor** — Oversees the research process and manages the team. This is the “master” agent that coordinates the other agents using LangGraph. This agent acts as the main LangGraph interface.  
- **首席编辑（Chief Editor）** — 全程监督研究流程并管理整个团队。该智能体是使用 LangGraph 协调其他所有智能体的“主控”角色，亦即 LangGraph 的核心接口。

- **GPT Researcher** — A specialized autonomous agent that conducts in depth research on a given topic.  
- **GPT Researcher** — 一个专精于对指定主题开展深度研究的自主智能体。

- **Editor**— Responsible for planning the research outline and structure.  
- **编辑（Editor）** — 负责规划研究报告的整体框架与结构。

- **Reviewer** — Validates the correctness of the research results given a set of criteria.  
- **评审员（Reviewer）** — 根据预设标准，对研究成果的准确性进行验证。

- **Reviser** — Revises the research results based on the feedback from the reviewer.  
- **修订员（Reviser）** — 根据评审员的反馈意见，对研究成果进行修订。

- **Writer** — Responsible for compiling and writing the final report.  
- **撰稿人（Writer）** — 负责整合信息并撰写最终研究报告。

- **Publisher** — Responsible for publishing the final report in various formats.  
- **发布者（Publisher）** — 负责以多种格式发布最终研究报告。

### Architecture

### 架构设计

As seen below, the automation process is based on the following stages: Planning the research, data collection and analysis, review and revision, writing the report and finally publication:

如下图所示，该自动化流程包含以下阶段：研究规划 → 数据采集与分析 → 评审与修订 → 报告撰写 → 最终发布：

![](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_001.webp)

More specifically the process is as follows:

具体而言，该流程如下：

- **Browser (gpt-researcher)** — Browses the internet for initial research based on the given research task. This step is crucial for LLMs to plan the research process based on up to date and relevant information, and not rely solely on pre-trained data for a given task or topic.  
- **浏览器模块（gpt-researcher）** — 基于指定的研究任务，在互联网上开展初步调研。此步骤至关重要：它使大语言模型能够依据最新、相关的信息来规划研究流程，而非仅依赖于针对特定任务或主题的预训练数据。

- **Editor** — Plans the report outline and structure based on the initial research. The Editor is also responsible for triggering the parallel research tasks based on the planned outline.  
- **编辑（Editor）** — 基于初步调研结果，规划报告的整体提纲与结构；同时，还负责根据已规划的提纲，触发并行开展的各项子研究任务。

For each outline topic (in parallel):

针对每个大纲主题（并行执行）：

- **Researcher (gpt-researcher)** — 对子主题进行深入研究，并撰写初稿。该智能体底层调用 GPT Researcher [Python 包](https://pypi.org/project/gpt-researcher/?ref=blog.langchain.com)，以生成经过优化、深度详尽且事实准确的研究报告。  
- **Reviewer（评审员）** — 依据一组既定准则，验证初稿的正确性，并向修订员（如有）提供反馈意见。  
- **Reviser（修订员）** — 根据评审员的反馈反复修改初稿，直至内容令人满意。  
- **Writer（撰稿人）** — 整合已有研究成果，撰写最终报告，包括引言、结论及参考文献部分。  
- **Publisher（发布员）** — 将最终报告导出为多种格式，例如 PDF、Docx、Markdown 等。

We won't dive into all the code since there’s a lot of it, but we'll focus on the interesting parts I’ve found valuable to share.

由于代码量较大，我们不会逐行讲解全部代码，而是聚焦于我认为特别有价值、值得分享的核心部分。

### Define the Graph State

### 定义图状态

One of my favorite features with LangGraph is [state management](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com#define-the-agent-state). States in LangGraph are facilitated through a structured approach where developers define a GraphState that encapsulates the entire state of the application. Each node in the graph can modify this state, allowing for dynamic responses based on the evolving context of the interaction.

LangGraph 中我最喜爱的功能之一是 [状态管理](https://python.langchain.com/docs/langgraph/?ref=blog.langchain.com#define-the-agent-state)。LangGraph 采用结构化方式实现状态管理：开发者需定义一个 GraphState，用以封装整个应用的状态；图中的每个节点均可修改该状态，从而支持基于交互过程中不断演进的上下文作出动态响应。

Like in every start of a technical design, considering the data schema throughout the application is key. In this case we’ll define a ResearchState like so:

正如所有技术设计的起点一样，通盘考虑应用的数据模式（schema）至关重要。本例中，我们将定义如下 `ResearchState`：

```
class ResearchState(TypedDict):
    task: dict
    initial_research: str
    sections: List[str]
    research_data: List[dict]
    # Report layout
    title: str
    headers: dict
    date: str
    table_of_contents: str
    introduction: str
    conclusion: str
    sources: List[str]
    report: str
```

```
class ResearchState(TypedDict):
    task: dict
    initial_research: str
    sections: List[str]
    research_data: List[dict]
    # 报告排版结构
    title: str
    headers: dict
    date: str
    table_of_contents: str
    introduction: str
    conclusion: str
    sources: List[str]
    report: str
```

As seen above, the state is divided into two main areas: the research task and the report layout content. As data circulates through the graph agents, each agent will, in turn, generate new data based on the existing state and update it for subsequent processing further down the graph with other agents.

如上所示，该状态划分为两大核心区域：研究任务相关数据与报告排版结构内容。当数据在图中各智能体间流转时，每个智能体将基于当前状态生成新数据，并更新状态，以便后续由图中其他智能体继续处理。

We can then initialize the graph with the following:

随后，我们可通过以下代码初始化该图：

```
from langgraph.graph import StateGraph
workflow = StateGraph(ResearchState)
```

### Initializing the graph with LangGraph

### 使用 LangGraph 初始化图结构

As stated above, one of the great things about multi agent development is building each agent to have specialized and scoped skills. Let’s take an example of the Researcher agent using [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) python package:

如上所述，多智能体开发的一大优势在于为每个智能体赋予专业化且职责明确的技能。下面我们以使用 [GPT Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) Python 包实现的“研究者（Researcher）”智能体为例：

```
from gpt_researcher import GPTResearcher

class ResearchAgent:
    def __init__(self):
        pass

    async def research(self, query: str):
        # Initialize the researcher
        researcher = GPTResearcher(parent_query=parent_query, query=query, report_type=research_report, config_path=None)
        # Conduct research on the given query
        await researcher.conduct_research()
        # Write the report
        report = await researcher.write_report()

        return report
```

```
from gpt_researcher import GPTResearcher

class ResearchAgent:
    def __init__(self):
        pass

    async def research(self, query: str):
        # 初始化研究者
        researcher = GPTResearcher(parent_query=parent_query, query=query, report_type=research_report, config_path=None)
        # 针对给定查询开展研究
        await researcher.conduct_research()
        # 撰写报告
        report = await researcher.write_report()

        return report
```

As you can see above, we’ve created an instance of the Research agent. Now let’s assume we’ve done the same for each of the team’s agent. After creating all of the agents, we’d initialize the graph with LangGraph:

如上所示，我们已创建了一个 ResearchAgent 实例。现在假设我们同样为团队中的每个智能体都实现了对应的类。在完成所有智能体的定义后，我们将使用 LangGraph 来初始化工作流图：

```
def init_research_team(self):
    # Initialize agents
    editor_agent = EditorAgent(self.task)
    research_agent = ResearchAgent()
    writer_agent = WriterAgent()
    publisher_agent = PublisherAgent(self.output_dir)

    # Define a Langchain StateGraph with the ResearchState
    workflow = StateGraph(ResearchState)

    # Add nodes for each agent
    workflow.add_node("browser", research_agent.run_initial_research)
    workflow.add_node("planner", editor_agent.plan_research)
    workflow.add_node("researcher", editor_agent.run_parallel_research)
    workflow.add_node("writer", writer_agent.run)
    workflow.add_node("publisher", publisher_agent.run)
```

```
def init_research_team(self):
    # 初始化各智能体
    editor_agent = EditorAgent(self.task)
    research_agent = ResearchAgent()
    writer_agent = WriterAgent()
    publisher_agent = PublisherAgent(self.output_dir)

    # 使用 ResearchState 定义 LangChain 的 StateGraph
    workflow = StateGraph(ResearchState)

    # 为每个智能体添加节点
    workflow.add_node("browser", research_agent.run_initial_research)
    workflow.add_node("planner", editor_agent.plan_research)
    workflow.add_node("researcher", editor_agent.run_parallel_research)
    workflow.add_node("writer", writer_agent.run)
    workflow.add_node("publisher", publisher_agent.run)
```

```python
    workflow.add_edge('browser', 'planner')
    workflow.add_edge('planner', 'researcher')
    workflow.add_edge('researcher', 'writer')
    workflow.add_edge('writer', 'publisher')

    # set up start and end nodes
    workflow.set_entry_point("browser")
    workflow.add_edge('publisher', END)

    return workflow
```

```python
    workflow.add_edge('browser', 'planner')
    workflow.add_edge('planner', 'researcher')
    workflow.add_edge('researcher', 'writer')
    workflow.add_edge('writer', 'publisher')

    # 设置起始节点和终止节点
    workflow.set_entry_point("browser")
    workflow.add_edge('publisher', END)

    return workflow
```

As seen above, creating the LangGraph graph is very straight forward and consists of three main functions: **add\_node**, **add\_edge** and **set\_entry\_point**. With these main functions you can first add the nodes to the graph, connect the edges and finally set the starting point.

如上所示，构建 LangGraph 图非常直观，主要依赖三个核心函数：**add\_node**、**add\_edge** 和 **set\_entry\_point**。借助这些函数，你可以先向图中添加节点，再连接边，最后设定图的起始点。

Focus check: If you’ve been following the code and architecture properly, you’ll notice that the Reviewer and Reviser agents are missing in the initialization above. Let’s dive into it!

重点检查：如果你一直紧跟代码逻辑与整体架构，就会注意到上述初始化过程中缺失了 Reviewer（评审员）和 Reviser（修订员）两个智能体。让我们深入探讨！

### A Graph within a Graph to support stateful Parallelization

### 图中图：支持有状态的并行化

This was the most exciting part of my experience working with LangGraph! One exciting feature of this autonomous assistant is having a parallel run for each research task, which would be reviewed and revised based on a set of predefined guidelines.

这正是我使用 LangGraph 过程中最令人兴奋的部分！该自主助手的一项亮点功能，是为每一项研究任务启动并行执行流程，并依据一组预定义的准则对结果进行评审与修订。

Knowing how to leverage parallel work within a process is key for optimizing speed. But how would you trigger parallel agent work if all agents report to the same state? This can cause race conditions and inconsistencies in the final data report. To solve this, you can create a sub graph that would be triggered from the main LangGraph instance. This sub graph would hold its own state for each parallel run, and that would solve the issues that were raised.

在流程中有效利用并行处理能力，是提升执行速度的关键。但若所有智能体都向同一共享状态汇报，又该如何触发并行智能体工作？这种设计容易引发竞态条件（race conditions），并导致最终数据报告不一致。为解决这一问题，你可以从主 LangGraph 实例中触发一个子图（sub-graph）。该子图将为每次并行运行维护独立的状态，从而彻底规避前述问题。

As we’ve done before, let’s define the LangGraph state and its agents. Since this sub graph basically reviews and revises a research draft, we’ll define the state with draft information:

正如我们之前所做的一样，我们来定义 LangGraph 的状态及其智能体。由于该子图的核心功能是对研究草稿进行评审与修订，因此我们将状态定义为包含草稿相关信息：

```
class DraftState(TypedDict):
    task: dict
    topic: str
    draft: dict
    review: str
    revision_notes: str
```

```
class DraftState(TypedDict):
    task: dict
    topic: str
    draft: dict
    review: str
    revision_notes: str
```

As seen in the DraftState, we mostly care about the topic discussed, and the reviewer and revision notes as they communicate between each other to finalize the subtopic research report. To create the circular condition we’ll take advantage of the last important piece of LangGraph which is **conditional edges:**

如上文 `DraftState` 所示，我们主要关注所讨论的主题，以及评审员与修订员之间为最终确定子主题研究报告而相互沟通的评审意见和修订说明。为构建循环流程，我们将利用 LangGraph 中最后一个关键组件——**条件边（conditional edges）**：

```
async def run_parallel_research(self, research_state: dict):
    workflow = StateGraph(DraftState)

    workflow.add_node("researcher", research_agent.run_depth_research)
    workflow.add_node("reviewer", reviewer_agent.run)
    workflow.add_node("reviser", reviser_agent.run)

    # set up edges researcher->reviewer->reviser->reviewer...
    workflow.set_entry_point("researcher")
    workflow.add_edge('researcher', 'reviewer')
    workflow.add_edge('reviser', 'reviewer')
    workflow.add_conditional_edges('reviewer',
                                   (lambda draft: "accept" if draft['review'] is None else "revise"),
                                   {"accept": END, "revise": "reviser"})
```

```
async def run_parallel_research(self, research_state: dict):
    workflow = StateGraph(DraftState)

    workflow.add_node("researcher", research_agent.run_depth_research)
    workflow.add_node("reviewer", reviewer_agent.run)
    workflow.add_node("reviser", reviser_agent.run)

    # 设置边：researcher → reviewer → reviser → reviewer ……
    workflow.set_entry_point("researcher")
    workflow.add_edge('researcher', 'reviewer')
    workflow.add_edge('reviser', 'reviewer')
    workflow.add_conditional_edges('reviewer',
                                   (lambda draft: "accept" if draft['review'] is None else "revise"),
                                   {"accept": END, "revise": "reviser"})
```

By defining the conditional edges, the graph would direct to reviser if there exists review notes by the reviewer, or the cycle would end with the final draft. If you go back to the main graph we’ve built, you’ll see that this parallel work is under a node named “researcher” called by ChiefEditor agent.

通过定义条件边，若评审员已提供评审意见，图流程将转向 `reviser` 节点；否则，循环终止，输出最终草稿。若您回顾此前构建的主图，会发现该并行研究流程被封装在名为 `“researcher”` 的节点中，由 `ChiefEditor` 代理调用。

### Running the Research Assistant

### 运行研究助手

After finalizing the agents, states and graphs, it’s time to run our [research assistant](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com)! To make it easier to customize, the assistant runs with a given task.json file:

在完成各智能体（agents）、状态（states）及图结构（graphs）的设计后，现在可以运行我们的 [研究助手](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com)！为便于定制，该助手通过指定的 `task.json` 文件启动：

```
{
  "query": "Is AI in a hype cycle?",
  "max_sections": 3,
  "publish_formats": {
    "markdown": true,
    "pdf": true,
    "docx": true
  },
  "follow_guidelines": false,
  "model": "gpt-4-turbo",
  "guidelines": [\
    "The report MUST be written in APA format",\
    "Each sub section MUST include supporting sources using hyperlinks. If none exist, erase the sub section or rewrite it to be a part of the previous section",\
    "The report MUST be written in spanish"\
  ]
}
```

```
{
  "query": "AI 是否正处于炒作周期？",
  "max_sections": 3,
  "publish_formats": {
    "markdown": true,
    "pdf": true,
    "docx": true
  },
  "follow_guidelines": false,
  "model": "gpt-4-turbo",
  "guidelines": [\
    "报告必须采用 APA 格式撰写",\
    "每个子章节必须包含带超链接的支持性资料来源；若无合适来源，则应删除该子章节，或将其内容合并至前一章节",\
    "报告必须使用西班牙语撰写"\
  ]
}
```

The task object is pretty self explanatory, however please notice that follow\_guidelines if false would cause the graph to ignore the revision step and defined guidelines. Also, the max\_sections field defines how many subheaders to research for. Having less will generate a shorter report.

该任务对象本身已具备较强可读性；但请注意：若 `"follow_guidelines"` 设为 `false`，图流程将跳过修订步骤，并忽略所有预设指南。此外，`"max_sections"` 字段用于指定需研究的子标题数量——数值越小，生成的报告越简短。

Running the assistant will result in a final research report in formats such as Markdown, PDF and Docx.

运行该助手后，将生成最终的研究报告，支持 Markdown、PDF 和 Docx 等多种格式。

To download and run the example check out the [GPT Researcher x LangGraph](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com) open source page.

要下载并运行该示例，请访问 [GPT Researcher x LangGraph](https://github.com/assafelovic/gpt-researcher/tree/master/multi_agents?ref=blog.langchain.com) 开源项目页面。

## What's Next?

## 接下来呢？

Going forward, there are super exciting things to think about. Human in the loop is key for optimized AI experiences. Having a human help the assistant revise and focus on just the right research plan, topics and outline, would enhance the overall quality and experience. In addition, aiming for relying on human intervention throughout the AI flow ensures correctness, sense of control and deterministic results. Happy to see that LangGraph already supports this out of the box as seen [here](https://blog.langchain.com/human-in-the-loop-with-opengpts-and-langgraph/).

展望未来，有许多令人振奋的方向值得深入探索。“人在回路中”（Human-in-the-Loop）是优化 AI 体验的关键。若由人类协助助手审阅并聚焦于最恰当的研究计划、主题与提纲，将显著提升最终成果的质量与用户体验。此外，在整个 AI 流程中持续引入人工干预，有助于保障结果的准确性、增强用户对过程的掌控感，并实现可预期、确定性的输出。值得欣喜的是，LangGraph 已原生支持这一能力，详情请参见 [此处](https://blog.langchain.com/human-in-the-loop-with-opengpts-and-langgraph/)。

In addition, having support for research about both web and local data would be key for many types of business and personal use cases.

此外，同时支持基于网络数据与本地数据开展研究，对众多商业及个人应用场景而言至关重要。

Lastly, more efforts can be done to improve the quality of retrieved sources and making sure the final report is built in the optimal storyline.

最后，还需进一步提升所检索信息源的质量，并确保最终报告以最优叙事逻辑构建而成。

* * *

A step forward in LangGraph and multi-agent collaboration as a whole would be where assistants can plan and generate graphs dynamically based on given tasks. This vision would allow assistants to choose only a subset of agents for a given task and plan their strategy based on the graph fundamentals as presented in this article and open a whole new world of possibilities. Given the pace of innovation in the AI space, it won’t be long before a new disruptive version of GPT Researcher is launched. Looking forward to what the future brings!

LangGraph 及多智能体协作整体演进的重要一步，将是助手能够根据具体任务动态规划并生成图结构。这一构想将使助手能为特定任务自主选取部分智能体，并依据本文所述图结构基本原理制定策略，从而开启一个全新的可能性世界。考虑到 AI 领域日新月异的创新节奏，新一代具有颠覆性的 GPT Researcher 很快就将面世。让我们共同期待未来！

To keep track of this project’s ongoing progress and updates please join our [Discord community](https://discord.gg/d2SgfEaP?ref=blog.langchain.com).

如需持续关注本项目的最新进展与更新，请加入我们的 [Discord 社区](https://discord.gg/d2SgfEaP?ref=blog.langchain.com)。

### Tags

### 标签

[![Semantic Search for LangGraph Memory](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_002.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[![LangGraph 内存的语义搜索](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_002.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**Semantic Search for LangGraph Memory**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**LangGraph 内存的语义搜索**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 分钟阅读

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 min read

[![Reflection Agents](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_003.jpg)](https://blog.langchain.com/reflection-agents/)

[![反思型智能体（Reflection Agents）](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_003.jpg)](https://blog.langchain.com/reflection-agents/)

[**Reflection Agents**](https://blog.langchain.com/reflection-agents/)

[**反思型智能体**](https://blog.langchain.com/reflection-agents/)

[agents](https://blog.langchain.com/tag/agents/) 6 分钟阅读

[agents](https://blog.langchain.com/tag/agents/) 6 min read

[![Plan + Execute Agent Thumbnail](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_004.png)](https://blog.langchain.com/planning-agents/)

[![规划与执行智能体（Plan-and-Execute Agents）缩略图](images/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/img_004.png)](https://blog.langchain.com/planning-agents/)

[**Plan-and-Execute Agents**](https://blog.langchain.com/planning-agents/)

[**规划与执行智能体**](https://blog.langchain.com/planning-agents/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 min read
{% endraw %}
