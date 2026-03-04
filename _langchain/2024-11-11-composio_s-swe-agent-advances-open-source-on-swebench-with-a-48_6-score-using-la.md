---
title: "Composio’s SWE agent advances open-source on SweBench with a 48.6% score using LangGraph and LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/composio-swekit/"
date: "2024-11-11"
scraped_at: "2026-03-03T07:49:13.152352529+00:00"
language: "en-zh"
translated: true
---
{% raw %}

We are excited to launch SWE-Kit, an open-source headless IDE with AI-native coding toolkits for AI agents, as part of Composio's agent tooling ecosystem. SWE-kit offers a headless IDE featuring Language Server Protocol (LSP) for code intelligence and a development container for secure code execution. It also features comprehensive coding tools like CodeAnalysis, Shell tools, File management and Git tools.

我们很高兴地宣布推出 SWE-Kit —— 一个面向 AI 代理（AI agents）的开源无头 IDE（headless IDE），内置 AI 原生编程工具包，作为 Composio 代理工具生态系统的重要组成部分。SWE-Kit 提供一个支持语言服务器协议（Language Server Protocol, LSP）以实现代码智能分析的无头 IDE，并配备用于安全代码执行的开发容器。此外，它还集成了全面的编程工具，包括 CodeAnalysis、Shell 工具、文件管理工具和 Git 工具。

To demonstrate SWE-Kit’s efficiency, we built a complete SWE agent using LangGraph and tested it on the [SWE Bench](https://www.swebench.com/?ref=blog.langchain.com).

为展示 SWE-Kit 的高效性，我们基于 LangGraph 构建了一个完整的软件工程（SWE）代理，并在 [SWE Bench](https://www.swebench.com/?ref=blog.langchain.com) 上对其进行了测试。

This benchmark evaluates the effectiveness of coding agents on real-world software engineering tasks. It comprises 2294 GitHub issues from popular Python libraries, such as Django, SymPy, Flask, Scikit-learn, etc.

该基准测试旨在评估编程代理在真实世界软件工程任务中的有效性。其数据集涵盖来自 Django、SymPy、Flask、Scikit-learn 等主流 Python 开源库的 2294 个 GitHub Issue。

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_001.webp)

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_001.webp)

The verified track consists of a human-validated subset of 500 problems reviewed by software engineers. Our agent solved 243 issues, an accuracy rate of 48.60%, placing fourth overall and second in the open-source category.

“验证轨道”（verified track）由软件工程师人工审核确认的 500 道题目组成，构成整个数据集的一个子集。我们的代理成功解决了其中 243 道问题，准确率达 48.60%，在全部参赛方案中综合排名第四，在开源类别中位列第二。

## SWE agent architecture

## SWE 代理架构

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_002.png)

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_002.png)

### Building agents as state-machines using LangGraph

### 使用 LangGraph 将代理构建为状态机

Managing agent states is a critical component of building reliable agentic workflows. Moving beyond a basic architecture, we adopted a graph-based approach using LangGraph, allowing us to model agents as state machines for efficient and transparent state management.

对代理状态的管理，是构建可靠代理工作流的关键环节。在基础架构之上，我们采用基于图（graph-based）的方法，借助 LangGraph 将代理建模为状态机，从而实现高效且透明的状态管理。

Rather than relying on routers or orchestrator agents to handle communication—methods that struggle to control or manage hidden states effectively—we flattened our workflow into state graphs, where each agent is a **state machine**. This approach provides a structured and robust solution to orchestrate agent interactions and control hidden states seamlessly.

我们并未依赖路由器（routers）或编排代理（orchestrator agents）来处理通信——这类方法往往难以有效控制或管理隐藏状态；相反，我们将整个工作流“扁平化”为状态图（state graphs），其中每个代理本身即是一个 **状态机**。这一方式为协调代理交互、无缝管控隐藏状态，提供了结构清晰且稳健可靠的解决方案。

### Monitoring with LangSmith

### 使用 LangSmith 进行监控

Another crucial aspect of agentic automation is monitoring, which becomes especially vital due to agents' non-deterministic nature. Monitoring allows granular visibility of underlying agent actions, giving you an idea of what is happening. So, we adopted **LangSmith**, which offers comprehensive logging of the actions taken by agents, providing a holistic context. Besides, it is highly compatible with LangGraph. We used it to monitor actions taken by agents at each step of solving issues, which subsequently helped us better our tools.

智能体自动化（agentic automation）的另一关键环节是监控，而由于智能体行为具有非确定性（non-deterministic nature），监控的重要性尤为突出。监控可提供对智能体底层操作的细粒度可见性，帮助你清晰掌握当前正在发生的情况。因此，我们采用了 **LangSmith** —— 它能全面记录智能体执行的各项操作，从而提供整体上下文视图。此外，LangSmith 与 LangGraph 高度兼容。我们利用它对智能体在问题求解各阶段所采取的操作进行全程监控，这反过来也助力我们持续优化工具。

### Specialist vs. generalist agents

### 专家型智能体 vs. 通才型智能体

Our approach uses specialized agents with distinct toolsets, each focused on specific tasks:

我们的方法采用具备专属工具集的专家型智能体，每个智能体均专注于特定任务：

- **Software Engineering Agent**: Responsible for task delegation, workflow initiation, and termination.  
- **软件工程智能体（Software Engineering Agent）**：负责任务分派、工作流启动与终止。

- **CodeAnalyzer Agent**: Analyzes codebases to gather insights on classes, methods, and functions.  
- **代码分析智能体（CodeAnalyzer Agent）**：分析代码库，提取关于类、方法和函数的洞察信息。

- **Editor Agent**: Manages navigation within the codebase and file modifications.  
- **编辑智能体（Editor Agent）**：管理代码库内的导航及文件修改操作。

This specialization improves performance by allowing each agent to focus on a well-defined task.

这种专业化分工提升了整体性能，使每个智能体均可专注于职责明确的单一任务。

## Workflow analysis

## 工作流分析

The LangGraph workflow consists of three separate agent and tool nodes. Each agent has pre-defined tasks and tools it can utilize based on the current workflow.

LangGraph 工作流由三个相互独立的智能体与工具节点构成。每个智能体均拥有预定义的任务集及可在当前工作流中调用的工具集。

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_003.webp)

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_003.webp)

### Workflow nodes and transitions

### 工作流节点与状态转移

1. **Software Engineer Node**:  
1. **软件工程师节点**：  
This agent initiates the workflow and determines subsequent actions based on its current state and message history.  
该智能体启动工作流，并根据其当前状态和消息历史决定后续操作。  

If the **Software Engineer** node decides an analysis is needed, it transitions to the **Code Analyzer**. If it requires file editing, it transitions to the **Editor**.  
若**软件工程师**节点判定需进行代码分析，则流转至**代码分析器**；若需编辑文件，则流转至**编辑器**。  

Depending on the task, the agent can use the SWE tools to generate a repository tree to understand the codebase better and create patch files as part of the solution.  
根据任务需求，该智能体可调用 SWE 工具生成仓库目录树，以更深入理解代码库结构，并生成补丁文件作为解决方案的一部分。  

When the workflow reaches this node, the **Code Analyzer** agent performs code analysis tasks using the **Code Analysis Tool**. After completing the analysis, it may:  
当工作流到达该节点时，**代码分析器**智能体使用**代码分析工具**执行代码分析任务。分析完成后，它可能：  
 - Return to the **Software Engineer** if the analysis is done.  
 - 若分析已完成，则返回**软件工程师**；  
 - Transition to the **Editor** if file edits are required.  
 - 若需修改文件，则流转至**编辑器**；  
 - Use **continue** to stay within the **Code Analyzer** state if more analysis is needed.  
 - 若需进一步分析，则使用 **continue** 指令，保持在**代码分析器**状态中。  

Uses the **CodeAnalysis tool** to generate Fully Qualified Domain Name (FQDN) code mappings, enabling precise identification and localization of code within the project.  
使用**CodeAnalysis 工具**生成完全限定域名（FQDN）代码映射，从而实现对项目内代码元素的精确定位与识别。  

2. **CodeAnalyzer Node**:  
2. **代码分析器节点**：  
When the workflow reaches this node, the **Code Analyzer** agent performs code analysis tasks using the **Code Analysis Tool**. After completing the analysis, it may:  
当工作流到达该节点时，**代码分析器**智能体使用**代码分析工具**执行代码分析任务。分析完成后，它可能：  
 - Return to the **Software Engineer** if the analysis is done.  
 - 若分析已完成，则返回**软件工程师**；  
 - Transition to the **Editor** if file edits are required.  
 - 若需修改文件，则流转至**编辑器**；  
 - Use **continue** to stay within the **Code Analyzer** state if more analysis is needed.  
 - 若需进一步分析，则使用 **continue** 指令，保持在**代码分析器**状态中。  

Uses the **CodeAnalysis tool** to generate Fully Qualified Domain Name (FQDN) code mappings, enabling precise identification and localization of code within the project. In code analysis, an FQDN (Fully Qualified Domain Name) is a unique identifier representing a specific code element, such as a class, method, or function, by tracing its full path within the codebase. Learn more about it [here](https://composio.dev/blog/tool-design-is-all-you-need-for-sota-swe-agents/?ref=blog.langchain.com).  
使用**CodeAnalysis 工具**生成完全限定域名（FQDN）代码映射，从而实现对项目内代码元素的精确定位与识别。在代码分析中，FQDN（Fully Qualified Domain Name，完全限定域名）是一种唯一标识符，通过追踪代码元素在整个代码库中的完整路径来表示某一特定代码单元（如类、方法或函数）。[点击此处](https://composio.dev/blog/tool-design-is-all-you-need-for-sota-swe-agents/?ref=blog.langchain.com)了解更多信息。  

3. **Editor Node**:  
3. **编辑器节点**：  
The **Editor** agent is responsible for editing files. Once editing is complete, the agent can:  
**编辑器**智能体负责文件编辑。编辑完成后，该智能体可：  
 - Transition back to **Software Engineer** if editing tasks are complete.  
 - 若编辑任务全部完成，则返回**软件工程师**；  
 - Continue within the **Editor** if more editing actions are needed.  
 - 若还需执行更多编辑操作，则继续保留在**编辑器**状态中。  

Uses the **Code Editing Tool** to \*\*\*\*create a repository tree, navigate code bases, and open and edit files.  
使用**代码编辑工具**\*\*\*\*生成仓库目录树、浏览代码库，并打开及编辑文件。  

4. **Tool Nodes**:  
4. **工具节点**：  

- **Code Analyzer Tool Node**: Used by the **Code Analyzer** agent for performing detailed code analysis.  
- **代码分析器工具节点**：供**代码分析器**智能体执行深度代码分析任务。  

- **Code Editor Tool Node**: Used by the **Editor** agent for file editing tasks.  
- **代码编辑器工具节点**：供**编辑器**智能体执行文件编辑任务。  

- **SWE Tool Node**: Contains software engineering-related tools that the **Software Engineer** agent can access.  
- **SWE 工具节点**：包含软件工程相关工具，可供**软件工程师**智能体调用。  

## State management in multi-agent LangGraph system  
## 多智能体 LangGraph 系统中的状态管理  

Effective state management is crucial for reliability and predictability when building complex multi-agent systems. The LangGraph architecture implements a sophisticated state management system that avoids the pitfalls of hidden states while maintaining clear agent boundaries and transitions.  
在构建复杂的多智能体系统时，高效的状态管理对于保障系统的可靠性与可预测性至关重要。LangGraph 架构实现了一套精密的状态管理系统，在规避“隐式状态”缺陷的同时，清晰地界定各智能体的职责边界与流转逻辑。  

### Core agent state  
### 核心智能体状态  

```  
class AgentState(TypedDict):  
    messages: Annotated[Sequence[BaseMessage], operator.add]  
    sender: str  
    consecutive_visits: dict  
```  

The state object maintains three critical pieces of information:  
该状态对象维护三项关键信息：  

- Message history that preserves the conversation context  
- 保存对话上下文的消息历史  
- Current sender identity to track agent ownership  
- 当前发送者身份，用于追踪智能体归属关系  
- Visit counts to track repeated visits to prevent unintended loops.  
- 访问计数，用于追踪重复访问行为，防止意外陷入循环。  

### State transition control  
### 状态流转控制  

LangGraph’s state management allows for controlled and predictable transitions between agents. Each agent’s following action is determined by conditional logic based on its current state and message history, ensuring that agents only engage in relevant tasks.  
LangGraph 的状态管理支持对智能体间流转过程的精准控制与可靠预测。每个智能体的下一步动作均由基于其当前状态与消息历史的条件逻辑决定，从而确保各智能体仅执行与其职责相关的任务。

# Router examines message content to determine next state

# 路由器通过检查消息内容来确定下一状态

```python
def router(state):
    messages = state["messages"]
    last_ai_message = get_last_ai_message(messages)

    # Explicit state transitions based on message markers
    if "ANALYZE CODE" in last_ai_message.content:
        return "analyze_code"
    if "EDIT FILE" in last_ai_message.content:
        return "edit_file"
    if "PATCH COMPLETED" in last_ai_message.content:
        return "__end__"
```

在上述路由代码块中，`router` 函数利用最后一条 AI 消息中的特定标记来控制状态跳转：

- **"ANALYZE CODE"**：切换至 `analyze_code` 状态，执行代码分析任务。  
- **"EDIT FILE"**：进入 `edit_file` 状态，执行文件编辑操作。  
- **"PATCH COMPLETED"**：通过跳转至 `__end__` 状态终止工作流。

该逻辑确保智能体仅执行与其当前上下文相关联的操作，从而保障工作流的高效性与可预测性。

![](images/composio_s-swe-agent-advances-open-source-on-swebench-with-a-48_6-score-using-la/img_004.png)

### Agent state boundaries

### 智能体状态边界

LangGraph 确保每个智能体均在明确定义的边界内运行，即其行为完全由自身状态及消息历史决定。

```python
# Software Engineer state transitions
workflow.add_conditional_edges(
    software_engineer_name,
    router,
    {
        "continue": software_engineer_name,
        "analyze_code": code_analyzer_name,
        "edit_file": editor_name,
        "__end__": END,
    }
)
# Code Analyzer state transitions
workflow.add_conditional_edges(
    code_analyzer_name,
    code_analyzer_router,
    {
        "continue": code_analyzer_name,
        "done": software_engineer_name,
        "edit_file": editor_name,
    }
)
```

上述代码为各智能体定义了明确的状态跳转规则，确保其始终在预设边界内运行。

- The **Software Engineer** agent transitions based on conditions set in the `router` function, allowing it to continue its tasks, switch to code analysis, initiate file edits, or end the workflow.  
- **软件工程师（Software Engineer）** 智能体根据 `router` 函数中设定的条件进行状态迁移，从而可继续执行当前任务、切换至代码分析、启动文件编辑，或终止整个工作流。

- The **Code Analyzer** agent follows conditions in `code_analyzer_router`, enabling it to continue analysis, return control to the Software Engineer, or transition to the Editor for file modifications.  
- **代码分析器（Code Analyzer）** 智能体依据 `code_analyzer_router` 中定义的条件进行迁移，从而可继续执行分析、将控制权交还给软件工程师，或切换至编辑器（Editor）以执行文件修改。

This setup ensures **clear task delegation** with no overlap, **modularity** through self-contained states and transitions, and **predictability** by controlling state transitions, preventing unintended side effects.  
该架构确保了**职责划分清晰**（无任务重叠）、**模块化设计**（各状态与迁移逻辑自包含），以及**行为可预测性**（通过显式控制状态迁移，避免意外副作用）。

## Empowering developers to build real-world agents  

## 赋能开发者构建面向真实场景的智能体  

One motivation behind SWE-Kit was to make it convenient for developers to build their closing agents. The platform's modular design lets developers mix and match tools, frameworks, and LLMs to create custom agents that fit their workflow.  
SWE-Kit 的设计初衷之一，是让开发者能够便捷地构建其专属的“闭环型智能体（closing agents）”。平台的模块化架构支持开发者自由组合各类工具、框架与大语言模型（LLMs），从而打造契合自身工作流的定制化智能体。

Our vision extends beyond software engineering to various real-world applications, including CRM, HRM, and administration. By making agent-driven automation dependable and accessible, we aim to equip developers to build intelligent agents capable of transforming workflows across industries.  
我们的愿景不仅限于软件工程领域，更延伸至客户关系管理（CRM）、人力资源管理（HRM）、行政管理等众多现实应用场景。通过使基于智能体的自动化技术更加可靠且易于获取，我们致力于赋能开发者构建具备跨行业流程变革能力的智能体。
{% endraw %}
