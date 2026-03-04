---
title: "Evaluating DeepAgents CLI on Terminal Bench 2.0"
source: "LangChain Blog"
url: "https://blog.langchain.com/evaluating-deepagents-cli-on-terminal-bench-2-0/"
date: "2025-12-05"
scraped_at: "2026-03-03T07:15:59.668920343+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

By Vivek Trivedy and Eugene Yurtsev

由维韦克·特里维迪（Vivek Trivedy）和尤金·尤尔采夫（Eugene Yurtsev）撰写

[DeepAgents CLI](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) 是基于 [Deep Agents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) SDK 构建的编程智能体，提供具备 Shell 命令执行、文件系统操作工具及记忆能力的交互式终端界面。

DeepAgents CLI 在真实世界任务中的实际表现究竟如何？

本文将介绍如何在 [Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com) 基准测试中评估 DeepAgents CLI。该基准涵盖软件工程、生物学、网络安全和游戏等领域的共 89 项任务，用于全面衡量智能体能力。

DeepAgents CLI（由 Sonnet 4.5 驱动）在 Terminal Bench 上取得了约 42.5% 的得分，性能与 Claude Code 本身基本持平。

## What is the DeepAgents CLI

## 什么是 DeepAgents CLI

The DeepAgents CLI is a terminal powered coding agent. It is open source, written in Python, and model agnostic.

DeepAgents CLI 是一款以终端为载体的编程智能体。它开源、使用 Python 编写，并且与大模型无关（model-agnostic）。

The DeepAgents CLI is a terminal-powered coding agent that's open source, written in Python, and model agnostic. It ships with built-in capabilities including file operations, shell command execution, web search, task planning via todos, and persistent memory storage across sessions.

DeepAgents CLI 是一款以终端为载体的开源编程智能体，采用 Python 编写，兼容任意大语言模型。其内置功能包括：文件操作、Shell 命令执行、网络搜索、基于待办事项（todos）的任务规划，以及跨会话的持久化记忆存储。

**Quick start:**

**快速开始：**

```jsx
export ANTHROPIC_API_KEY="your-api-key" uvx deepagents-cli
```

The agent proposes changes with diffs for your approval before modifying files.

代理会在修改文件前，以差异（diff）形式提出更改建议，供您审核批准。

```

[Watch the demo video](https://www.youtube.com/watch?v=IrnacLa9PJc&ref=blog.langchain.com) to see it in action.

[观看演示视频](https://www.youtube.com/watch?v=IrnacLa9PJc&ref=blog.langchain.com)，直观了解其实际运行效果。

## The Challenge: Running Isolated Evaluations

## 挑战：执行隔离式评估

Before we can evaluate anything, we need to solve a fundamental problem: **how do we run our agent in a clean, isolated environment every time?**

在开展任何评估之前，我们必须先解决一个根本性问题：**如何每次都在干净、隔离的环境中运行我们的智能体？**

DeepAgents recently added a [sandbox abstraction](https://blog.langchain.com/execute-code-with-sandboxes-for-deepagents/) that allows it to work with different execution environments. A coding agent modifies files, installs packages, and runs commands—each test could leave artifacts that affect subsequent tests. We need isolation so each test starts from a clean slate, with the ability to run many tests in parallel and safety guarantees that the agent can't affect your local machine.

DeepAgents 最近新增了 [沙箱抽象层（sandbox abstraction）](https://blog.langchain.com/execute-code-with-sandboxes-for-deepagents/)，使其能够适配多种执行环境。编程类智能体需修改文件、安装软件包并执行命令——每次测试都可能遗留影响后续测试的产物（artifacts）。因此，我们需要严格的环境隔离：确保每次测试均从“空白状态”（clean slate）开始，支持大规模并行测试，并提供安全保证，防止智能体对您的本地机器造成任何影响。

### Harbor: Sandboxed Agent Execution

### Harbor：基于沙箱的智能体执行框架

This is where [Harbor](https://harborframework.com/?ref=blog.langchain.com) comes in. Harbor is a framework for evaluating agents in containerized environments at scale, supporting Docker, Modal, Daytona, E2B, and Runloop as sandbox providers. It handles:

这正是 [Harbor](https://harborframework.com/?ref=blog.langchain.com) 的用武之地。Harbor 是一个面向大规模场景的智能体评估框架，可在容器化环境中运行智能体，支持 Docker、Modal、Daytona、E2B 和 Runloop 等多种沙箱提供商。它具备以下能力：

- **Automatic test execution** on benchmark tasks  
- **基准任务的自动测试执行**

- **Automated reward scoring** to verify task completion  
- **自动化奖励评分**，用于验证任务是否完成

- **Registry of pre-built evaluation datasets** like Terminal Bench  
- **预构建评估数据集的注册中心**，例如 Terminal Bench

Harbor handles all the infrastructure complexity of running agents in isolated environments, letting you focus on improving your agent.

Harbor 全面接管了在隔离环境中运行智能体所涉及的所有基础设施复杂性，让您能专注于智能体本身的优化与提升。

We built [deepagents-harbor](https://github.com/langchain-ai/deepagents/tree/master/libs/harbor?ref=blog.langchain.com) to make evaluation straightforward:  

我们开发了 [deepagents-harbor](https://github.com/langchain-ai/deepagents/tree/master/libs/harbor?ref=blog.langchain.com)，让评估过程变得简单直接：

```bash
git clone <https://github.com/langchain-ai/deepagents.git>
cd libs/harbor
uv sync

# Configure .env with API keys
cp .env.example .env

# Run via Docker
uv run harbor run --agent-import-path deepagents_harbor:DeepAgentsWrapper \\
  --dataset terminal-bench@2.0 -n 1 --jobs-dir jobs/terminal-bench --env docker

# Run at scale via Daytona (requires DAYTONA_API_KEY)
uv run harbor run --agent-import-path deepagents_harbor:DeepAgentsWrapper \\
  --dataset terminal-bench@2.0 -n 10 --jobs-dir jobs/terminal-bench --env daytona
```

```bash
git clone <https://github.com/langchain-ai/deepagents.git>
cd libs/harbor
uv sync

# 使用 API 密钥配置 .env 文件
cp .env.example .env

# 通过 Docker 运行
uv run harbor run --agent-import-path deepagents_harbor:DeepAgentsWrapper \\
  --dataset terminal-bench@2.0 -n 1 --jobs-dir jobs/terminal-bench --env docker

# 通过 Daytona 大规模运行（需设置 DAYTONA_API_KEY）
uv run harbor run --agent-import-path deepagents_harbor:DeepAgentsWrapper \\
  --dataset terminal-bench@2.0 -n 10 --jobs-dir jobs/terminal-bench --env daytona
```

We've found Daytona particularly helpful for running evaluations at scale, allowing us to run 40 trials concurrently and significantly speed up the iteration cycle.

我们发现 Daytona 在大规模运行评测任务时尤为有用，支持并发执行 40 次试验，从而显著加快迭代周期。

Harbor offers a sandbox environment with shell-execution capabilities. We built a HarborSandbox backend that wraps this environment and implements file-system tools (e.g., `edit_file`, `read_file`, `write_file`, `ls`) on top of shell commands.

Harbor 提供具备 Shell 执行能力的沙箱环境。我们构建了一个 HarborSandbox 后端，封装该环境，并在 Shell 命令之上实现了文件系统工具（例如 `edit_file`、`read_file`、`write_file`、`ls`）。

```python
class DeepAgentHarbor(BaseAgent):
    async def run(
        self,
        instruction: str,
        environment: BaseEnvironment,
        context: AgentContext,
    ) -> None:
        # Create a DeepAgents backend that wraps Harbor's environment
        # and provides filesystem tools
        backend = HarborSandbox(environment)

        # Initialize the DeepAgent CLI with the Harbor backend
        agent, _ = create_cli_agent(
            model=self._model,
            backend=backend,
            ...
        )

        # Run the agent
        result = await agent.ainvoke(
            {"messages": [{"role": "user", "content": instruction}]},
        )
```

```python
class DeepAgentHarbor(BaseAgent):
    async def run(
        self,
        instruction: str,
        environment: BaseEnvironment,
        context: AgentContext,
    ) -> None:
        # 创建一个封装 Harbor 环境并提供文件系统工具的 DeepAgents 后端
        backend = HarborSandbox(environment)

        # 使用 Harbor 后端初始化 DeepAgent CLI
        agent, _ = create_cli_agent(
            model=self._model,
            backend=backend,
            ...
        )

        # 运行智能体
        result = await agent.ainvoke(
            {"messages": [{"role": "user", "content": instruction}]},
        )
```

## What Terminal Bench Tests

## Terminal Bench 测试内容

[Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com)  
[Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com)

includes 89 tasks across domains like software engineering, biology, security, and gaming. It measures how well agents operate in computer environments via the terminal.  

涵盖软件工程、生物学、安全性和游戏等多个领域的共 89 项任务。它通过终端环境评估智能体在计算机系统中的实际操作能力。

**Example tasks:**  
**示例任务：**

- `path-tracing`: Reverse-engineer C program from rendered image  
- `path-tracing`：根据渲染图像逆向还原 C 程序  

- `chess-best-move`: Find optimal move using chess engine  
- `chess-best-move`：调用国际象棋引擎找出最优走法  

- `git-multibranch`: Complex git operations with merge conflicts  
- `git-multibranch`：涉及合并冲突的复杂 Git 多分支操作  

- `sqlite-with-gcov`: Build SQLite with code coverage, analyze reports  
- `sqlite-with-gcov`：构建启用代码覆盖率（gcov）的 SQLite，并分析覆盖率报告  

Tasks have a wide range of difficulty—some [require many actions](https://smith.langchain.com/public/c7948044-eab1-480c-96cb-e31e393476f9/r?ref=blog.langchain.com) (e.g., `cobol-modernization` taking close to 10 minutes with 100+ tool calls) while simpler tasks complete in seconds.  

各项任务难度跨度极大——部分任务[需执行大量操作](https://smith.langchain.com/public/c7948044-eab1-480c-96cb-e31e393476f9/r?ref=blog.langchain.com)（例如 `cobol-modernization` 任务耗时近 10 分钟，调用工具超 100 次），而较简单的任务则可在数秒内完成。

**Automated Verification:**  
**自动验证：**

Each task includes verification logic that Harbor runs automatically, assigning a reward score (0 for incorrect, 1 for correct) based on whether the agent's solution meets the task requirements.  

每项任务均内置验证逻辑，由 Harbor 自动执行；依据智能体的解决方案是否满足任务要求，自动赋予奖励分（正确得 1 分，错误得 0 分）。

## Baseline Results  
## 基线结果

We ran the DeepAgents CLI with `claude-sonnet-4-5` on Terminal Bench 2.0 across 2 trials, achieving scores of **44.9%** and **40.4%** (mean: **42.65%**). This baseline is on par with [other implementations using the same model](https://www.tbench.ai/leaderboard/terminal-bench/2.0?ref=blog.langchain.com).  

我们在 Terminal Bench 2.0 上，使用 `claude-sonnet-4-5` 模型运行 DeepAgents CLI，共进行 2 轮测试，得分分别为 **44.9%** 和 **40.4%**（平均值：**42.65%**）。该基线表现与[采用相同模型的其他实现方案](https://www.tbench.ai/leaderboard/terminal-bench/2.0?ref=blog.langchain.com)相当。

While there's considerable sampling variance across runs, this baseline validates that DeepAgents provides a competitive foundation.  

尽管不同运行间存在较明显的采样方差，但该基线结果已证实：DeepAgents 提供了一个具备竞争力的坚实基础。

## Next steps  
## 后续计划

By running DeepAgents CLI on Terminal Bench 2 we’ve established DeepAgents as a solid starting point. In upcoming posts, we'll explore how to systematically analyze agent traces and identify concrete optimizations to improve performance.

在 Terminal Bench 2 上运行 DeepAgents CLI 后，我们已确认 DeepAgents 是一个扎实的起点。在后续文章中，我们将探讨如何系统性地分析智能体执行轨迹（agent traces），并识别出切实可行的优化方案，以提升性能。

## Resources

## 资源

- [DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)
- [DeepAgents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)

- [Harbor](https://github.com/laude-institute/harbor?ref=blog.langchain.com)
- [Harbor](https://github.com/laude-institute/harbor?ref=blog.langchain.com)

- [deepagents-harbor code](https://github.com/langchain-ai/deepagents/tree/master/libs/harbor?ref=blog.langchain.com)
- [deepagents-harbor 代码](https://github.com/langchain-ai/deepagents/tree/master/libs/harbor?ref=blog.langchain.com)

- [Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com)
- [Terminal Bench 2.0](https://www.tbench.ai/?ref=blog.langchain.com)
&#123;% endraw %}
