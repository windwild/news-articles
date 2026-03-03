---
title: "Introducing DeepAgents CLI"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-deepagents-cli/"
date: "2025-11-03"
scraped_at: "2026-03-03T07:20:41.168140493+00:00"
language: "en-zh"
translated: true
---

_By_ [_Vivek Trivedy_](https://www.linkedin.com/in/vivek-trivedy-433509134/?ref=blog.langchain.com)

作者：[_维韦克·特里维迪（Vivek Trivedy）_](https://www.linkedin.com/in/vivek-trivedy-433509134/?ref=blog.langchain.com)

We're excited to introduce **DeepAgents CLI** for coding, research, and building agents with persistent memory. Now you can easily create and run custom DeepAgents directly from the terminal. It supports:

我们很高兴地推出 **DeepAgents CLI**——一款面向编程、科研及智能体（agent）构建的工具，支持持久化记忆功能。现在，您可直接在终端中轻松创建并运行自定义的 DeepAgents。它支持以下能力：

- **Read, write, and edit files** in your project  
- 在您的项目中**读取、写入和编辑文件**

- **Execute shell commands** with human approval  
- **执行 Shell 命令**（需人工确认）

- **Search the web** for current information  
- **搜索互联网**以获取最新信息

- **Make HTTP requests** to APIs  
- 向 API 发起 **HTTP 请求**

- **Learn and remember** information across sessions  
- **学习并跨会话记忆**信息

- **Plan tasks** with visual todo lists  
- 使用可视化待办清单**规划任务**

## Installation

## 安装

Install DeepAgents with CLI support:

安装支持命令行界面（CLI）的 DeepAgents：

```bash

pip install deepagents-cli
```

Or if you're using `uv`:

或者，若您使用 `uv`：

```bash

uv pip install deepagents-cli
```

## Quick Start

## 快速开始

### 1. Set Up Your API Keys

### 1. 配置您的 API 密钥

DeepAgents CLI 支持 Anthropic（Claude）和 OpenAI 两种模型。**Anthropic Claude Sonnet 4 是默认模型**，网络搜索则使用 Tavily。请将以下环境变量添加到您项目根目录下的 `.env` 文件中，DeepAgents 将自动加载它们：

```bash

export ANTHROPIC_API_KEY=your_api_key_here
export OPENAI_API_KEY=your_api_key_here
export TAVILY_API_KEY=your_tavily_key_here
```

### 2. Launch the CLI

### 2. 启动命令行界面（CLI）

在您的项目目录中启动 DeepAgents：

```bash

deepagents
```

或者，如果您正在使用 `uv`：

```jsx
uv run deepagents
```

```jsx
uv run deepagents
```

### 3\. Your First Task

### 3. 您的第一个任务

Try asking the agent to help with a simple task:

尝试让智能体协助完成一个简单任务：

```

You: Add type hints to all functions in src/utils.py
```

```

您：为 `src/utils.py` 中的所有函数添加类型提示
```

The agent will:

智能体会：

1. Read the file  
   1. 读取该文件  
2. Analyze the functions  
   2. 分析其中的函数  
3. Show you a diff of proposed changes  
   3. 向您展示拟变更内容的差异（diff）  
4. Ask for your approval before writing  
   4. 在写入修改前征得您的批准  

There's also an option to Auto-Accept Edits to speed up development  

此外还提供“自动接受编辑”选项，以加快开发速度。

## Learning Through Memory

## 借助记忆实现学习

One of DeepAgents' most powerful features is its **persistent memory system**. The agent can learn information and recall it across sessions. Each agent stores its knowledge in `~/.deepagents/AGENT_NAME/memories/`:  

DeepAgents 最强大的功能之一是其 **持久化记忆系统**。该智能体能够学习信息，并在不同会话间回忆所学内容。每个智能体将其知识存储在 `~/.deepagents/AGENT_NAME/memories/` 目录中：

By default, if you spin up DeepAgents it will create an agent with the name `agent` and use that by default. You can change the agent used (and therefor what memories are used) by specifying an agent name, eg `deepagents --agent foo`. See next section for more details.

默认情况下，启动 DeepAgents 时会创建一个名为 `agent` 的智能体，并默认使用该智能体。您可以通过指定智能体名称来切换所使用的智能体（从而切换所使用的记忆），例如：`deepagents --agent foo`。更多详细信息请参见下一节。

The agent automatically follows a **Memory-First Protocol**:

该智能体自动遵循 **“记忆优先协议”（Memory-First Protocol）**：

1. **During Research** \- Checks `/memories/` for relevant knowledge  
1. **研究过程中** —— 检查 `/memories/` 目录以获取相关知识  

2. **Before answering** \- Searches memory files in case of uncertainty  
2. **回答前** —— 若存在不确定性，则检索记忆文件  

3. **When learning** \- Saves new information to `/memories/`  
3. **学习时** —— 将新信息保存至 `/memories/` 目录  

### Example: Teaching API Patterns

### 示例：教授 API 设计规范

```

You: Remember that our API endpoints follow this pattern:
- Use /api/v1/ prefix
- All POST requests return 201 on success
- Error responses include a "code" and "message" field

Save this as our API conventions.

Agent: I'll save these API conventions to memory.
⚙ write_file(/memories/api-conventions.md)
```

```

您：请记住，我们的 API 端点遵循以下规范：  
- 使用 `/api/v1/` 前缀  
- 所有成功的 POST 请求均返回状态码 201  
- 错误响应中包含 `"code"` 和 `"message"` 字段  

请将以上内容保存为我们的 API 规范。

智能体：我已将这些 API 规范保存至记忆中。  
⚙ write_file(/memories/api-conventions.md)
```

Because this memory is persistent, the agent can use this information across future conversations.

由于该记忆具有持久性，智能体可在后续所有对话中持续使用此信息。

```
You: Create a new endpoint for user registration
Agent: Based on our API conventions, I'll create an endpoint at
/api/v1/users that returns 201 on success and follows
our error format.
⚙ read_file(/memories/api-conventions.md)
⚙ write_file(src/routes/users.py)
```

```
您：为用户注册创建一个新的端点  
智能体：根据我们的 API 规范，我将创建一个位于 `/api/v1/users` 的端点，成功时返回 201，并遵循我们定义的错误响应格式。  
⚙ read_file(/memories/api-conventions.md)  
⚙ write_file(src/routes/users.py)
```

### Memory Best Practices

### 内存使用最佳实践

**1\. 使用描述性文件名** ✓ /memories/deployment-checklist.md ✗ /memories/notes.md

**1. 使用具有描述性的文件名** ✓ /memories/deployment-checklist.md ✗ /memories/notes.md

**2\. 按主题组织**

**2. 按主题分类整理**

```
/memories/
├── backend/

│ ├── tools_to_use.md

│ └── api-design.md

├── frontend/

│ ├── component-patterns.md

└── security-setup.md
```

```
/memories/
├── backend/

│ ├── tools_to_use.md

│ └── api-design.md

├── frontend/

│ ├── component-patterns.md

└── security-setup.md
```

**3\. 验证已保存的知识** 因为内存本质上只是一组文件，因此你始终可以手动检查其内容，或借助智能体（agent）进行验证。

**3\. 验证已保存的知识** Because memory is just a set of files, you can always inspect and validate its content manually or with the agent.

```
You: Check what you know about our database

你：检查一下你对我们数据库的了解

Agent: Let me check my memories...
代理：让我检查一下我的记忆……
⚙ ls /memories/
⚙ ls /memories/
⚙ read_file(/memories/backend/database-schema.md)
⚙ read_file(/memories/backend/database-schema.md)

Based on my memory, we use PostgreSQL with these tables...
根据我的记忆，我们使用 PostgreSQL，包含以下这些表……
```

You can also inspect the memory files manually by just looking at `~/.deepagents/AGENT_NAME/memories/`

你也可以通过直接查看 `~/.deepagents/AGENT_NAME/memories/` 目录，手动检查记忆文件。

### Managing Multiple Agents

### 管理多个智能体

You can create specialized agents for different projects or roles: From the DeepAgents CLI you can list existing agents, create new agents, or reset an agent to its default state (system prompts, memories, etc).

你可以为不同项目或角色创建专用的智能体：通过 DeepAgents 命令行工具（CLI），你可以列出已存在的智能体、创建新智能体，或重置某个智能体至其默认状态（包括系统提示词、记忆等内容）。

```bash
deepagents list
```

```bash
deepagents list
```

```bash
deepagents agent backend-dev
```

```bash
deepagents agent backend-dev
```

```bash
deepagents reset backend-dev
```

```bash
deepagents reset backend-dev
```

## Get Started Today

## 今天就开始使用

Get started with DeepAgents and the DeepAgent CLI today! We're excited to see what you build.

今天就立即开始使用 DeepAgents 和 DeepAgent CLI 吧！我们非常期待看到您构建的成果。

Join the community and contribute:

加入社区并贡献您的力量：

- **GitHub**: [https://github.com/langchain-ai/deepagents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com)
- **GitHub**: [https://github.com/langchain-ai/deepagents](https://github.com/langchain-ai/deepagents?ref=blog.langchain.com)
- **Documentation**: [docs.langchain.com/oss/python/deepagents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)
- **文档**: [docs.langchain.com/oss/python/deepagents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com)
- **YouTube:** [https://youtu.be/IrnacLa9PJc](https://youtu.be/IrnacLa9PJc?ref=blog.langchain.com)
- **YouTube**: [https://youtu.be/IrnacLa9PJc](https://youtu.be/IrnacLa9PJc?ref=blog.langchain.com)