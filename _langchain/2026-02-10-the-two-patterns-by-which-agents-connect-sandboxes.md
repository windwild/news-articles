---
title: "The two patterns by which agents connect sandboxes"
source: "LangChain Blog"
url: "https://blog.langchain.com/the-two-patterns-by-which-agents-connect-sandboxes/"
date: "2026-02-10"
scraped_at: "2026-03-02T10:08:10.142295017+00:00"
language: "en-zh"
translated: true
description: "Thank you to Nuno Campos from Witan Labs, Tomas Beran and Mikayel Harutyunyan from E2B, Jonathan Wall from Runloop, and Ben Guo from Zo Computer for their review and comments.TL;DR:More and more agent..."
---

_Thank you to Nuno Campos from Witan Labs, Tomas Beran and Mikayel Harutyunyan from E2B, Jonathan Wall from Runloop, and Ben Guo from Zo Computer for their review and comments._

感谢 Witan Labs 的 Nuno Campos、E2B 的 Tomas Beran 和 Mikayel Harutyunyan、Runloop 的 Jonathan Wall，以及 Zo Computer 的 Ben Guo 对本文的审阅与宝贵意见。

**TL;DR:**

**简而言之：**

- **越来越多的智能体（agents）需要一个工作空间：一台可运行代码、安装软件包并访问文件的计算机。沙箱（sandboxes）正是为此而生。**
- **将智能体与沙箱集成，存在两种主流架构模式：**
  - **模式 1（智能体“在”沙箱内）：智能体直接运行于沙箱内部，你通过网络与其通信。优势：贴近本地开发体验，智能体与运行环境高度耦合。**
  - **模式 2（沙箱作为工具）：智能体运行于本地或你的服务器上，远程调用沙箱执行任务。优势：便于更新智能体逻辑，API 密钥等敏感信息保留在沙箱外部，关注点分离更清晰。**
- [**deepagents**](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) **通过简洁配置同时支持上述两种模式。**

* * *

An increasing number of agents need a workspace - a computer where they can run code, install packages, and access files. That workspace needs to be isolated so the agent can't access your credentials, files, or network. Sandboxes provide this isolation by creating a boundary between the agent's environment and your host system. The question teams building these agents face isn't _whether_ to use sandboxes - it's _how to integrate them_ with their agent architecture.

如今，越来越多的智能体需要一个工作空间——一台能够运行代码、安装软件包并访问文件的计算机。该工作空间必须具备隔离性，以确保智能体无法访问你的凭据、文件或网络。沙箱通过在智能体运行环境与宿主系统之间建立边界，实现这种隔离。对于正在构建此类智能体的团队而言，问题已不再是“是否使用沙箱”，而是“如何将其与自身的智能体架构进行集成”。

根据智能体的运行位置，主要有两种常见集成模式：一种是智能体运行于沙箱内部，另一种是运行于沙箱外部。每种模式各具优势与权衡取舍。

注意：本文聚焦于为智能体提供完整“计算机”能力的沙箱——即具备完整执行环境的方案，例如 Docker 容器或虚拟机（VM）。我们不会涵盖进程级沙箱（如 [bubblewrap](https://github.com/containers/bubblewrap?ref=blog.langchain.com)）或语言级沙箱（如 [Pyodide](https://pyodide.org/en/stable/?ref=blog.langchain.com)）。

## Pattern 1: Agent Runs IN Sandbox

## 模式 1：智能体运行于沙箱内部

In this pattern, the agent runs inside the sandbox. You communicate with it over the network.

在此模式中，智能体直接运行于沙箱内部，你通过网络与其通信。

![](images/the-two-patterns-by-which-agents-connect-sandboxes/img_001.png)

**What this looks like in practice:**

**实际应用中的表现如下：**

You build a Docker or VM image with your agent framework pre-installed, run it inside the sandbox, and connect from outside to send messages. The agent exposes an API endpoint (typically HTTP or WebSocket), and your application communicates with it across the sandbox boundary.

您构建一个已预装代理框架的 Docker 或虚拟机镜像，在沙箱内运行该镜像，并从外部连接以发送消息。代理暴露一个 API 端点（通常是 HTTP 或 WebSocket），您的应用程序则通过沙箱边界与之通信。

**Benefits:**

**优势：**

This pattern mirrors local development closely—if you run `deepagents` in your terminal locally, you run the same command in the sandbox. The agent has direct filesystem access and can modify its environment. This is useful when the agent and execution environment are tightly coupled, such as when the agent needs to interact with specific libraries or maintain complex environment state.

该模式高度还原本地开发体验——如果您在本地终端中运行 `deepagents`，那么在沙箱中也执行完全相同的命令。代理可直接访问文件系统，并能修改其运行环境。当代理与执行环境紧密耦合时（例如需调用特定库或需维持复杂的环境状态），这种设计尤为有用。

**Trade-offs:**

**权衡考量：**

Communication across the sandbox boundary requires infrastructure. Some providers handle this in their SDK—for example, agents like OpenCode run a server inside the sandbox, and providers like E2B can expose this through a clean API. If your provider doesn't offer this, you'll need to build the WebSocket or HTTP layer yourself, including session management and error handling.

跨沙箱边界的通信需要配套基础设施支持。部分服务商已在 SDK 中内置支持——例如，OpenCode 类代理会在沙箱内启动一个服务端，而 E2B 等服务商则可通过简洁的 API 将其对外暴露。若您的服务商未提供此类能力，则需自行实现 WebSocket 或 HTTP 通信层，包括会话管理与错误处理逻辑。

API keys must live inside the sandbox to allow the agent to make inference calls. This creates a potential security risk if the sandbox is compromised, whether through a vulnerability in the isolation technology or through prompt injection attacks that exfiltrate credentials. Note: we see providers like E2B and Runloop working on secret vault capabilities, which addresses this.

API 密钥必须存放在沙箱内部，以便代理发起推理调用。一旦沙箱被攻破（无论是因隔离技术存在漏洞，还是因提示注入攻击导致密钥泄露），都将带来潜在安全风险。注：我们注意到 E2B 和 Runloop 等服务商正在开发密钥保险库（secret vault）功能，以应对这一问题。

Updates require rebuilding the container image and redeploying, which can slow iteration cycles during development.

更新需重新构建容器镜像并重新部署，这可能拖慢开发过程中的迭代周期。

Another downside is that the sandbox must be resumed before the agent becomes active, which often requires extra logic.

另一项不足在于：代理启动前，沙箱必须先恢复运行，这通常需要额外的逻辑支持。

For those worried about protecting the IP of their agents, if your agent is running in the sandbox it becomes much easier to exfiltrate the entire code and prompts of the agent.

对于关注代理知识产权（IP）保护的开发者而言，若代理运行于沙箱之中，则其全部代码与提示词将更易被窃取。

Nuno Campos from Witan Labs also points out another security risk: “I’d say another downside of agent in sandbox is that effectively no part of your agent can have more privileges than the bash tool does. E.g. imagine you want an agent that has a bash tool and a tool that can do web search or web fetch, then all the LLM generated code can do unlimited web fetches (which is a big security risk). If it’s sandbox as tool then you can have tools with more permissions than you give to llm generated code (which sounds very useful for many agents) trivially, as the security boundary is around the bash tool, not the whole agent.”

Witan Labs 的 Nuno Campos 还指出了另一项安全风险：“我认为，将整个智能体（agent）置于沙箱中的一大缺陷在于：实际上，智能体的任何部分都无法拥有比 Bash 工具更高的权限。例如，假设你构建了一个具备 Bash 工具和网络搜索/网页抓取工具的智能体，那么所有由大语言模型（LLM）生成的代码都将能执行不受限制的网页请求（这构成了严重的安全风险）。而若采用‘沙箱即工具’（sandbox-as-tool）模式，则可轻松赋予某些工具高于 LLM 生成代码的权限（这对许多智能体而言极具实用价值），因为此时安全边界仅围绕 Bash 工具划定，而非覆盖整个智能体。”

## Pattern 2: Sandbox as Tool

## 模式 2：沙箱即工具

In this pattern, the agent runs on your machine or server. When it needs to execute code, it calls a remote sandbox via API.

在此模式下，智能体运行于你的本地机器或服务器上；当需要执行代码时，它通过 API 调用远程沙箱服务。

![](images/the-two-patterns-by-which-agents-connect-sandboxes/img_002.png)

![](images/the-two-patterns-by-which-agents-connect-sandboxes/img_002.png)

**What this looks like in practice:**

**实际运作方式如下：**

Your agent runs locally (or on your server), and when it generates code that needs to execute, it calls out to a sandbox provider's API (like [E2B](https://e2b.dev/?ref=blog.langchain.com), [Modal](https://modal.com/?ref=blog.langchain.com), [Daytona](https://www.daytona.io/?ref=blog.langchain.com), or [Runloop](https://runloop.ai/?ref=blog.langchain.com)). The provider's SDK handles all the communication details. From your agent's perspective, the sandbox is just another tool.

你的智能体在本地（或你的服务器上）运行；当它生成需执行的代码时，便调用沙箱服务商的 API（例如 [E2B](https://e2b.dev/?ref=blog.langchain.com)、[Modal](https://modal.com/?ref=blog.langchain.com)、[Daytona](https://www.daytona.io/?ref=blog.langchain.com) 或 [Runloop](https://runloop.ai/?ref=blog.langchain.com)）。服务商提供的 SDK 全权负责所有通信细节。对你的智能体而言，沙箱仅仅是一个普通工具。

**Benefits:**

**优势：**

You can update agent code instantly without rebuilding container images, which speeds up iteration during development. API keys stay outside the sandbox—only execution happens in isolation. This provides cleaner separation of concerns: agent state (conversation history, reasoning chains, memory) lives where your agent runs, separate from the sandbox. This means sandbox failures don't lose your agent's state, and you can switch sandbox backends without affecting your agent's core logic.

你可即时更新智能体代码，无需重新构建容器镜像，从而显著加快开发过程中的迭代速度。API 密钥始终保留在沙箱之外——仅有代码执行环节被隔离。这实现了更清晰的关注点分离：智能体的状态（如对话历史、推理链、记忆）保存在智能体自身运行的位置，与沙箱完全解耦。这意味着沙箱故障不会导致智能体状态丢失，且你可在不改动智能体核心逻辑的前提下自由切换不同的沙箱后端。

Two other benefits of this option, as pointed out by Tomas Beran of E2B:

E2B 的 Tomas Beran 还指出该方案另具两项优势：

1. Having the option to run tasks in multiple remote sandboxes in parallel  
1. 支持并行调用多个远程沙箱来执行任务  

2. Paying for sandboxes only when executing code, rather than for the whole process runtime.  
2. 仅在实际执行代码时才为沙箱付费，而非为整个进程运行时长付费。

Ben Guo adds a final point about the benefits of separating agent runtime from sandbox runtime: “We chose Pattern 2 for the reasons you mention, but also in preparation for a future where it makes sense to run the agent harness in a GPU machine – generally feels like the environment requirements will diverge between the persistent sandbox and the inference harness”

郭奔补充了关于将智能体运行时（agent runtime）与沙箱运行时（sandbox runtime）分离的另一项优势：“我们选择模式 2（Pattern 2），既出于您所提到的原因，也为了提前为未来做准备——届时将智能体运行框架（agent harness）部署在 GPU 机器上会更具合理性。总体而言，持久化沙箱环境与推理运行框架（inference harness）对运行环境的要求很可能会逐渐分化。”

**Trade-offs:**

**权衡考量：**

Network latency is the main downside. Each execution call crosses the network boundary. For workloads with many small executions, this can add up.

网络延迟是主要缺点。每次执行调用均需跨越网络边界；对于包含大量小型执行任务的工作负载，此类延迟会显著累积。

Many sandbox providers offer stateful sessions where variables, files, and installed packages persist across invocations within the same session. This can mitigate some of the latency concerns by reducing the number of round trips needed.

许多沙箱服务提供商支持有状态会话（stateful sessions），即变量、文件及已安装的软件包可在同一会话内的多次调用间持续保留。这可通过减少必要的往返通信次数，在一定程度上缓解延迟问题。

## Choosing Between Patterns

## 模式选择指南

**Choose Pattern 1 when:**

**在以下情况下选择模式 1：**

- The agent and execution environment are tightly coupled (for example, the agent needs persistent access to specific libraries or complex environment state)
- 智能体与执行环境高度耦合（例如，智能体需持续访问特定库或复杂的环境状态）
- You want production to mirror local development closely
- 您希望生产环境尽可能贴近本地开发环境
- Your provider's SDK handles the communication layer for you
- 您所用服务商的 SDK 已为您封装并处理了通信层

**Choose Pattern 2 when:**

**在以下情况下选择模式 2：**

- You need to iterate quickly on agent logic during development
- 您需要在开发阶段快速迭代智能体逻辑
- You want to keep API keys outside the sandbox
- 您希望将 API 密钥保留在沙箱之外
- You prefer cleaner separation between agent state and execution environment
- 您更倾向于在智能体状态与执行环境之间实现更清晰的职责分离

## Implementation Example

## 实现示例

To make these patterns concrete, we'll show examples using [deepagents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com), an open-source agent framework with built-in sandbox support. Similar patterns apply to other agent frameworks.

为使这些模式更加具体，我们将使用开源智能体框架 [deepagents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)（内置沙箱支持）来演示示例。类似模式也适用于其他智能体框架。

### Pattern 1: Agent IN Sandbox

### 模式 1：智能体 *运行于* 沙箱内

For Pattern 1, first you build an image with your agent pre-installed:

对于模式 1，首先需构建一个已预装智能体的镜像：

```docker
FROM python:3.11
RUN pip install deepagents-cli
```

```docker
FROM python:3.11
RUN pip install deepagents-cli
```

Then run it inside the sandbox. A complete implementation requires additional infrastructure to handle communication between your application and the agent inside the sandbox (WebSocket or HTTP server, session management, error handling). This is beyond the scope of this post, but we will have some follow up posts diving into this in more detail.

然后在沙箱中运行该镜像。一个完整的实现还需额外基础设施，以处理您的应用与沙箱内智能体之间的通信（例如 WebSocket 或 HTTP 服务、会话管理、错误处理等）。这部分内容超出本文范围，但我们后续将发布系列文章，对此进行更深入的探讨。

### Pattern 2: Sandbox as Tool

### 模式 2：将沙箱作为工具

```python
from daytona import Daytona
from langchain_anthropic import ChatAnthropic

from deepagents import create_deep_agent
from langchain_daytona import DaytonaSandbox

# Can also do this with E2B, Runloop, Modal
sandbox = Daytona().create()
backend = DaytonaSandbox(sandbox=sandbox)

agent = create_deep_agent(
    model=ChatAnthropic(model="claude-sonnet-4-20250514"),
    system_prompt="You are a Python coding assistant with sandbox access.",
    backend=backend,
)
```

```python
from daytona import Daytona
from langchain_anthropic import ChatAnthropic

from deepagents import create_deep_agent
from langchain_daytona import DaytonaSandbox

# Can also do this with E2B, Runloop, Modal
sandbox = Daytona().create()
backend = DaytonaSandbox(sandbox=sandbox)

agent = create_deep_agent(
    model=ChatAnthropic(model="claude-sonnet-4-20250514"),
    system_prompt="You are a Python coding assistant with sandbox access.",
    backend=backend,
)
```

```python
result = agent.invoke(
    {
        "messages": [\
            {\
                "role": "user",\
                "content": "Run a small python script",\
            }\
        ]
    }
)

sandbox.stop()
```

```python
result = agent.invoke(
    {
        "messages": [\
            {\
                "role": "user",\
                "content": "运行一个小型 Python 脚本",\
            }\
        ]
    }
)

sandbox.stop()
```

Here's what happens when this code runs:

这段代码运行时会发生以下过程：

1. The agent plans locally on your machine  
1. 代理在您的本地机器上进行规划  

2. It generates Python code to solve the problem  
2. 它生成 Python 代码来解决该问题  

3. It calls the Runloop API, which executes the code in a remote sandbox  
3. 它调用 Runloop API，该 API 在远程沙箱中执行代码  

4. The sandbox returns the result  
4. 沙箱返回执行结果  

5. The agent sees the output and continues reasoning locally  
5. 代理接收到输出后，在本地继续推理  

## Conclusion

## 总结

Agents need to execute code in isolated environments for security. There are two architecture patterns: running the agent inside the sandbox (mirrors local development, tight coupling) or running it outside with the sandbox as a tool (easy updates, API keys stay secure). Each has different benefits and trade-offs depending on your needs.

为保障安全性，代理必须在隔离环境中执行代码。目前主要有两种架构模式：一是将代理运行于沙箱内部（贴近本地开发体验，耦合度高）；二是将代理运行于沙箱外部，将沙箱作为工具调用（便于更新、API 密钥更安全）。两种模式各有优势与权衡，需根据具体需求选择。

deepagents supports both patterns with simple configuration. [Try it out](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com) to see which pattern works best for your use case.

`deepagents` 通过简洁的配置同时支持这两种模式。[立即试用](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com)，探索哪一种模式更契合您的实际应用场景。