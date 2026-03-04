---
render_with_liquid: false
title: "Building Multi-Agent Applications with Deep Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/"
date: "2026-02-13"
scraped_at: "2026-03-03T07:14:14.308596555+00:00"
language: "en-zh"
translated: true
description: "Breaking down complex tasks across specialized agents is one of the most effective approaches to building capable AI systems. In this post, we'll show you how to build multi-agent systems with Deep Ag..."
tags: ["deep agents", "agents", "Engineering", "agent builder", "langgraph", "![Reflection Agents", "**Reflection Agents**", "**Plan-and-Execute Agents**", "By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

By Sydney Runkle and Vivek Trivedy

作者：Sydney Runkle 和 Vivek Trivedy

Breaking down complex tasks across specialized agents is one of the most effective approaches to building capable AI systems.

将复杂任务分解并交由专业化智能体（agents）协同处理，是构建高性能 AI 系统最有效的方法之一。

Deep Agents makes this easy with two first-class primitives:

Deep Agents 通过两个头等核心原语（primitives），让这一过程变得轻而易举：

- **subagents:** delegating to isolated agents  
- **子智能体（subagents）**：将任务委派给彼此隔离的独立智能体  

- **skills:** progressively disclosing capabilities  
- **技能（skills）**：渐进式地暴露能力  

In this post, we'll show you how to build multi-agent systems with Deep Agents.

本文中，我们将向您演示如何使用 Deep Agents 构建多智能体系统。

## Using Subagents: Specialized, Isolated Workers

## 使用子智能体：专业化、相互隔离的工作者

Subagents tackle a fundamental problem in agent engineering: **context bloat**. This is when an agent’s context window becomes close to full as it works on a task.

子智能体旨在解决智能体工程中的一个根本性问题：**上下文膨胀（context bloat）**——即智能体在执行任务过程中，其上下文窗口（context window）迅速接近容量上限。

Why is this important? There’s great work from [Chroma on context rot](https://research.trychroma.com/context-rot?ref=blog.langchain.com) showing that models struggle to complete tasks as their context window gets filled. Our friends at HumanLayer call this high context regime the “ [dumb zone](https://www.hlyr.dev/blog/context-efficient-backpressure?ref=blog.langchain.com)”. Subagents isolate context from the main agent to help avoid quickly entering the dumb zone.

为什么这至关重要？[Chroma 关于“上下文腐化（context rot）”的研究](https://research.trychroma.com/context-rot?ref=blog.langchain.com)已明确指出：随着上下文窗口逐渐填满，大模型完成任务的能力会显著下降。HumanLayer 团队将这种高上下文负载状态形象地称为“**迟钝区（dumb zone）**”。子智能体通过将上下文与主智能体隔离，帮助系统避免快速陷入这一迟钝区。

When your agent makes dozens of web searches or file reads, the context window fills with intermediate results. Subagents isolate work by running with their own context window. So if the subagent is doing a lot of exploratory work before coming with its final answer, the main agent still only gets the final result, not the 20 tool calls that produced it.

当您的智能体执行数十次网页搜索或文件读取操作时，其上下文窗口将被大量中间结果迅速占满。子智能体则通过拥有专属的上下文窗口来实现工作隔离。因此，即便子智能体在给出最终答案前进行了大量探索性操作（例如调用了 20 次工具），主智能体收到的也仅是最终结果，而非冗长的中间过程。

Here’s a look at the basic subagents architecture:

以下是子智能体基本架构示意图：

![](images/building-multi-agent-applications-with-deep-agents/img_001.png)

### When to Use Subagents

### 何时使用子智能体（Subagents）

- **Context Preservation:** A task requiring multiple steps can clutter the main agent's context (ex: codebase exploration).  
- **上下文保全：** 需要多个步骤的任务可能使主智能体的上下文变得杂乱（例如：代码库探索）。

- **Specialization:** Use domain specific instructions or tools. Subagents developed by distinct teams can specialize in different verticals.  
- **专业化：** 使用面向特定领域的指令或工具。由不同团队开发的子智能体可专注于不同的垂直领域。

- **Multi-Model:** Subagents can use different models than the main agent. For example, choosing a smaller model for lower latency.  
- **多模型支持：** 子智能体可采用与主智能体不同的模型。例如，为降低延迟而选用更小的模型。

- **Parallelization**: Subagents can run simultaneously and return their outputs to the main agent. This reduces latency.  
- **并行化：** 子智能体可并行运行，并将其输出返回给主智能体，从而降低整体延迟。

### Creating Subagents

### 创建子智能体

Define subagents as dictionaries and pass them to `create_deep_agent()`:  
将子智能体定义为字典，并将其传入 `create_deep_agent()` 函数：

```python
from deepagents import create_deep_agent

research_subagent = {
    "name": "research-agent",
    "description": "Used to research more in depth questions",
    "system_prompt": "You are a great researcher",
    "tools": [internet_search],
    "model": "openai:gpt-4o",  # Optional: override main agent model
}

agent = create_deep_agent(
    model="claude-sonnet-4-5-20250929",
    subagents=[research_subagent]
)
```

See the [subagents](https://docs.langchain.com/oss/python/deepagents/subagents?ref=blog.langchain.com#configuration) documentation for configuration details.  
有关配置详情，请参阅 [子智能体（subagents）](https://docs.langchain.com/oss/python/deepagents/subagents?ref=blog.langchain.com#configuration) 文档。

### The General-Purpose Subagent

### 通用型子智能体

Deep Agents include a built-in `general-purpose` subagent that mirrors your main agent's capabilities. It has the same system prompt, tools, and model. This is perfect for **context isolation without specialized behavior.**

Deep Agents 内置一个 `general-purpose`（通用型）子智能体，其能力与主智能体完全一致。它共享相同的系统提示词（system prompt）、工具集和模型。这非常适合需要**上下文隔离但无需专门行为定制**的场景。

Example: Instead of your main agent making 10 web searches and filling its context, it can delegate to the general-purpose subagent with `task(name="general-purpose", task="Research quantum computing trends")`. The subagent performs all searches internally and returns only a summary.

示例：与其让主智能体自行执行 10 次网页搜索并不断填充自身上下文，不如将其委托给通用型子智能体，调用方式为 `task(name="general-purpose", task="Research quantum computing trends")`。该子智能体在内部完成全部搜索工作，最终仅返回一份精炼摘要。

### Best Practices for Subagents

### 子智能体最佳实践

**Write clear descriptions.** Your main agent uses descriptions to decide which subagent to call:

**撰写清晰明确的描述。** 主智能体依赖这些描述来判断应调用哪一个子智能体：

✅ Good: `"Analyzes financial data and generates investment insights with confidence scores"`

✅ 优秀示例：`"分析财务数据，并生成附带置信度评分的投资洞察"`

❌ Bad: `"Does finance stuff"`

❌ 不佳示例：`"处理金融相关事务"`

**Keep system prompts detailed.** Include tool usage guidance and output format requirements:

**确保系统提示词内容详尽。** 其中应包含工具使用指引及输出格式要求：

```python
research_subagent = {
    "name": "research-agent",
    "description": "Conducts in-depth research using web search and synthesizes findings",
    "system_prompt": """You are a thorough researcher. Your job is to:

    1. Break down the research question into searchable queries
    2. Use internet_search to find relevant information
    3. Synthesize findings into a comprehensive but concise summary
    4. Cite sources when making claims

    Output format:
    - Summary (2-3 paragraphs)
    - Key findings (bullet points)
    - Sources (with URLs)
```

```python
research_subagent = {
    "name": "research-agent",
    "description": "使用网络搜索开展深度研究，并整合研究成果",
    "system_prompt": """你是一位严谨的研究员。你的任务是：

    1. 将研究问题拆解为多个可检索的子查询；
    2. 调用 internet_search 工具查找相关信息；
    3. 将获取的信息整合成一份全面且简洁的总结；
    4. 在提出任何主张时均需注明信息来源。

    输出格式要求：
    - 总结（2–3 段）
    - 关键发现（项目符号列表）
    - 来源（含 URL 链接）
```

    Keep your response under 500 words to maintain clean context.""",
    "tools": [internet_search],
}
```

    请将您的响应控制在 500 字以内，以保持上下文简洁清晰。""",
    "tools": [internet_search],
}
```

**Minimize tool sets.** Only give subagents the tools they need:

**精简工具集。** 仅向子智能体提供其必需的工具：

```python
# ✅ Good: Focused tool set
email_agent = {
    "name": "email-sender",
    # Only email-related
    "tools": [send_email, validate_email],
}

# ❌ Bad: Too many tools
email_agent = {
    "name": "email-sender",
    # Unfocused
    "tools": [send_email, web_search, database_query, file_upload],
}
```

```python
# ✅ 优秀：聚焦的工具集
email_agent = {
    "name": "email-sender",
    # 仅限邮件相关功能
    "tools": [send_email, validate_email],
}

# ❌ 不佳：工具过多
email_agent = {
    "name": "email-sender",
    # 职能不聚焦
    "tools": [send_email, web_search, database_query, file_upload],
}
```

## Using Skills: Progressive Disclosure of Capabilities

## 使用技能：能力的渐进式披露

Skills provide a different pattern: progressive disclosure. Instead of giving your agent dozens of tools upfront, you define specialized capabilities in [SKILL.md](http://skill.md/?ref=blog.langchain.com) files. Your agent sees skill names and descriptions, then reads the full instructions only when needed.

技能提供了一种不同的设计范式：渐进式披露。您无需在初始阶段就为智能体配备数十种工具，而是将专业化能力定义在 [SKILL.md](http://skill.md/?ref=blog.langchain.com) 文件中。智能体首先看到的是技能名称与简介，仅在必要时才加载完整指令。

![](images/building-multi-agent-applications-with-deep-agents/img_002.png)Skill descriptions are pre-loaded into the context window. The skill body is only loaded when the agent decides the skill is needed based on the description and previous context.

![](images/building-multi-agent-applications-with-deep-agents/img_002.png)技能简介预先加载至上下文窗口；技能主体内容仅在智能体根据简介及先前上下文判断该技能确有必要时才被加载。

Caption: skill descriptions are pre-loaded into the context window. The skill body is only loaded when the agent decides the skill is needed based on the description and previous context.

图注：技能简介预先加载至上下文窗口；技能主体内容仅在智能体根据简介及先前上下文判断该技能确有必要时才被加载。

### Setting Up Skills

### 配置技能

Skills use the [agentskills.io spec](https://agentskills.io/?ref=blog.langchain.com). Here's the structure:

技能遵循 [agentskills.io 规范](https://agentskills.io/?ref=blog.langchain.com)。其结构如下：

```
.deepagents/skills/
├── deploy/SKILL.md
└── review-pr/SKILL.md
```

```
.deepagents/skills/
├── deploy/SKILL.md
└── review-pr/SKILL.md
```

Each [SKILL.md](http://skill.md/?ref=blog.langchain.com) file has YAML frontmatter with metadata and a main body:

每个 [SKILL.md](http://skill.md/?ref=blog.langchain.com) 文件均包含 YAML 前置元数据（frontmatter）及主体内容：

```markdown
---
render_with_liquid: false
render_with_liquid: false
name: deploy
description: Deploy to production
version: 1.0.0  # Optional
tags: [deployment, production]  # Optional
---
render_with_liquid: false
render_with_liquid: false

# Deploy to Production

When the user asks to deploy, follow these steps:

1. Run tests: `npm test`
2. Build the application: `npm run build`
3. Deploy to production: `npm run deploy:prod`
4. Verify deployment: Check the health endpoint

Always confirm with the user before deploying to production.
```

```markdown
---
render_with_liquid: false
render_with_liquid: false
name: deploy
description: 部署至生产环境
version: 1.0.0  # 可选
tags: [deployment, production]  # 可选
---
render_with_liquid: false
render_with_liquid: false

# 部署至生产环境

当用户提出部署请求时，请按以下步骤执行：

1. 运行测试：`npm test`
2. 构建应用：`npm run build`
3. 部署至生产环境：`npm run deploy:prod`
4. 验证部署：检查健康检查端点（health endpoint）

在将代码部署至生产环境前，务必先征得用户的确认。
```

### Adding Skills to Your Agent

### 为您的智能体添加技能

Use the `skills` argument to `create_deep_agent` to load skills from the filesystem:

请使用 `create_deep_agent` 的 `skills` 参数，从文件系统加载技能：

```python
from deepagents import create_deep_agent
from deepagents.backends import FilesystemBackend
```

```python
agent = create_deep_agent(
    model="claude-sonnet-4-5-20250929",
    backend=FilesystemBackend(root_dir="/"),
    skills=[".deepagents/skills"],
)
```

该智能体现在能够看到您的技能。当它需要详细指令时，会完整读取 [SKILL.md](http://skill.md/?ref=blog.langchain.com) 文件。

您也可以使用其他后端（例如 [StateBackend](https://docs.langchain.com/oss/python/deepagents/backends?ref=blog.langchain.com#statebackend-ephemeral) 或 [StoreBackend](https://docs.langchain.com/oss/python/deepagents/backends?ref=blog.langchain.com#storebackend-langgraph-store)），然后通过指定 `files` 参数来调用智能体：

```python
from deepagents.middleware.filesystem import FileData

# 默认后端为 StateBackend
agent = create_deep_agent(
    model="anthropic:claude-sonnet-4-20250514",
    skills=["/skills/"],
)

skill_content = """
---
render_with_liquid: false
render_with_liquid: false
name: deploy
...
"""

# 使用技能及虚拟文件调用智能体
result = agent.invoke({
    "messages": [HumanMessage(content="Research the latest Python releases")],
    "files": {
        "/skills/web-research/SKILL.md": FileData(
            content=skill_content.split("\n"),
            created_at="2024-01-01T00:00:00Z",
            modified_at="2024-01-01T00:00:00Z",
        ),
    },
})
```

## 选择合适的模式

以下是一组快速问题，助您做出决策：

| 当您需要…… | 请使用…… | 两者皆可？ |
| --- | --- | --- |
| 委派复杂、多步骤的工作 | 子智能体（Subagents），以实现上下文隔离 |  |
| 复用流程或指令 | 技能（Skills），以实现渐进式披露（progressive disclosure） |  |
| 为特定任务提供专用工具 | 具备聚焦工具集的子智能体 | ✅ |
| 在多个智能体之间共享能力 | 技能（它们本质上就是文件） | ✅ |
| 应对庞大的工具集 | 技能（可避免 token 过载） |  |

💡

💡

Note, this doesn’t have to be an **either-or** decision.

注意，这并非一个非此即彼的选择。

Many systems use both. Skills define procedures; subagents execute complex multi-step work. Your subagents can use skills to effectively manage their context windows!

许多系统会同时采用两者：Skills（技能）用于定义流程；Subagents（子智能体）则负责执行复杂的多步骤任务。你的子智能体可以调用技能，从而高效地管理其上下文窗口！

## Next Steps

## 下一步

To learn more about multi-agent patterns in Deep Agents, check out our:

如需进一步了解 Deep Agents 中的多智能体模式，请参阅我们的以下文档：

- [Subagents documentation](https://docs.langchain.com/oss/python/deepagents/subagents?ref=blog.langchain.com) \- Detailed API reference and examples  
- [子智能体文档](https://docs.langchain.com/oss/python/deepagents/subagents?ref=blog.langchain.com) —— 详尽的 API 参考与示例

- [Skills documentation](https://docs.langchain.com/oss/python/deepagents/skills?ref=blog.langchain.com) \- Detailed API reference and examples  
- [技能文档](https://docs.langchain.com/oss/python/deepagents/skills?ref=blog.langchain.com) —— 详尽的 API 参考与示例

- [Multi-agent patterns guide](https://docs.langchain.com/oss/python/langchain/multi-agent/index?ref=blog.langchain.com#choosing-a-pattern) \- General guidance on choosing patterns  
- [多智能体模式指南](https://docs.langchain.com/oss/python/langchain/multi-agent/index?ref=blog.langchain.com#choosing-a-pattern) —— 关于如何选择合适模式的通用指导

The key insight: multi-agent patterns don't have to be complicated. With the right abstractions (middleware for plumbing, tool calling for invocation), they become simple building blocks you can compose into capable, sophisticated systems.

核心洞见：多智能体模式不必复杂。借助恰当的抽象（例如用于连接协调的中间件、用于调用的工具调用机制），它们就转化为简单易用的构建模块，你可以灵活组合，构建出功能强大且高度成熟的系统。

Start with subagents for context management, add skills for progressive disclosure, and build from there.

可从使用子智能体进行上下文管理起步，再引入技能以实现渐进式信息呈现（progressive disclosure），并在此基础上持续扩展构建。

### Tags

### 标签

[deep agents](https://blog.langchain.com/tag/deep-agents/) [agents](https://blog.langchain.com/tag/agents/) [Engineering](https://blog.langchain.com/tag/engineering/)  
[deep agents（深度智能体）](https://blog.langchain.com/tag/deep-agents/) [agents（智能体）](https://blog.langchain.com/tag/agents/) [Engineering（工程）](https://blog.langchain.com/tag/engineering/)

[![Introducing Agent Builder templates](images/building-multi-agent-applications-with-deep-agents/img_003.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板](images/building-multi-agent-applications-with-deep-agents/img_003.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**使用 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：3 分钟

[![LangSmith Agent Builder Now Generally Available](images/building-multi-agent-applications-with-deep-agents/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布（GA）](images/building-multi-agent-applications-with-deep-agents/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**正式发布（GA）：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 min read

[agents](https://blog.langchain.com/tag/agents/) 阅读时长：2 分钟

[**LangSmith Incident on May 1, 2025**](https://blog.langchain.com/langsmith-incident-on-may-1-2025/)

[**LangSmith 2025 年 5 月 1 日服务事件公告**](https://blog.langchain.com/langsmith-incident-on-may-1-2025/)

[Engineering](https://blog.langchain.com/tag/engineering/) 2 min read

[Engineering](https://blog.langchain.com/tag/engineering/) 阅读时长：2 分钟

[![Semantic Search for LangGraph Memory](images/building-multi-agent-applications-with-deep-agents/img_005.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[![面向 LangGraph Memory 的语义搜索](images/building-multi-agent-applications-with-deep-agents/img_005.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**Semantic Search for LangGraph Memory**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**LangGraph 内存的语义搜索**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 分钟阅读

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 min read

[![Reflection Agents](images/building-multi-agent-applications-with-deep-agents/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[![反思型智能体](images/building-multi-agent-applications-with-deep-agents/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[**Reflection Agents**](https://blog.langchain.com/reflection-agents/)

[**反思型智能体**](https://blog.langchain.com/reflection-agents/)

[agents](https://blog.langchain.com/tag/agents/) 6 分钟阅读

[agents](https://blog.langchain.com/tag/agents/) 6 min read

[![Plan + Execute Agent Thumbnail](images/building-multi-agent-applications-with-deep-agents/img_007.png)](https://blog.langchain.com/planning-agents/)

[![规划与执行智能体缩略图](images/building-multi-agent-applications-with-deep-agents/img_007.png)](https://blog.langchain.com/planning-agents/)

[**Plan-and-Execute Agents**](https://blog.langchain.com/planning-agents/)

[**规划与执行智能体**](https://blog.langchain.com/planning-agents/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 min read