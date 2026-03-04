---
title: "Now GA: LangSmith Agent Builder"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-agent-builder-generally-available/"
date: "2026-01-22"
scraped_at: "2026-03-03T07:14:24.177399206+00:00"
language: "en-zh"
translated: true
description: "LangSmith Agent Builder is now generally available—enabling anyone to build agents for complex daily tasks, without writing code."
tags: ["agents", "agent builder", "![Building Multi-Agent Apps", "deep agents", "langgraph", "![Reflection Agents", "**Reflection Agents**", "**Plan-and-Execute Agents**", "By LangChain"]
---
{% raw %}

An agent should feel like your chief of staff: you share what you need, it figures out how to get it done, and it improves with feedback. That’s the idea behind Agent Builder.

一个智能体（agent）应当像你的首席幕僚：你告诉它你需要什么，它自行规划如何完成任务，并通过反馈持续优化。这正是 Agent Builder 的设计初衷。

Start by describing your goal in your own words. Agent Builder figures out the approach, guiding you from initial idea to a deployed agent ready to take on your work. It creates detailed instructions, selects the required tools, and even enlists subagents when required.

首先，用你自己的语言描述你的目标。Agent Builder 会自动推导实现路径，引导你从最初的想法一路演进为一个可部署、能立即投入工作的智能体。它会生成详尽的执行指令，自主选择所需工具，甚至在必要时调用子智能体（subagents）协同工作。

It’s different from traditional workflow automations. You don’t need to map every step, tinker with if-this-then-that branching, or babysit dependencies. You just give it feedback like you would a teammate, and the agent learns using its memory. It’s built from the ground up as an agent, with the ability to plan and iterate until it gets the job done, or seek permission before executing sensitive tasks.

它与传统的工作流自动化截然不同：你无需手动绘制每一步流程、调试“如果…那么…”式的条件分支，也不必时刻监控依赖关系。你只需像指导团队成员一样给予反馈，智能体便会依托其记忆能力持续学习。Agent Builder 从底层即以智能体范式构建——具备自主规划与迭代优化能力，直至任务圆满完成；对于敏感操作，它还会主动请求授权后再执行。

[Try Agent Builder free](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com) today.

[立即免费试用 Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)

### No-code agents for real work

### 面向真实工作的零代码智能体

We built Agent Builder for anyone whose day gets swallowed by routine work. The research, follow-ups, updates, scheduling, and status checks that are essential to your operations, but quickly take over your calendar.

我们打造 Agent Builder，专为那些被日常事务淹没的用户而生——那些对业务运转至关重要的研究、跟进、信息更新、日程安排和状态核查，往往迅速挤占你的整个日程表。

Teams have already shipped thousands of agents to production with Agent Builder. It’s especially good at tab-hopping tasks that span multiple apps, docs, and tools, like:

已有众多团队借助 Agent Builder 将数千个智能体成功部署至生产环境。它尤其擅长处理需在多个应用、文档与工具间频繁切换的跨平台任务，例如：

- **Daily briefings:** Generate pre-call briefs complete with company and stakeholder research, plus relevant account context from your CRM. Get started with, _“Send me a daily meeting brief.”_  
- **每日简报：** 自动生成会前简报，涵盖目标公司及关键利益相关方调研，并整合来自你 CRM 系统的相关客户背景信息。入门提示语：_“每天给我发送一份会议简报。”_

- **Market + competitor research:** Deliver a daily Slack digest of competitor launches, notable social posts, and industry trends your team should know about. Get started with, _“Send me a daily competitor update in Slack.”_  
- **市场与竞品调研：** 每日通过 Slack 推送竞品动态摘要，包括新品发布、重要社交媒体动态及团队应关注的行业趋势。入门提示语：_“每天在 Slack 中给我发送一份竞品更新。”_

- **Project tracking:** Create Linear issues from PRDs in Notion or Google Docs, then create calendar events for key milestones. Get started with, _“Turn my PRDs into Linear issues.”_  
- **项目追踪：** 将 Notion 或 Google Docs 中的产品需求文档（PRD）自动转化为 Linear 任务项，并为关键里程碑自动生成日历事件。入门提示语：_“把我的 PRD 转成 Linear 任务。”_

![Create agents](images/now-ga-langsmith-agent-builder/img_001.png)

![创建智能体](images/now-ga-langsmith-agent-builder/img_001.png)

### Take your agents further

### 让你的智能体更进一步

For years, our users–who are primarily developers–have asked us to help equip their co-workers to build agents without writing code. Agent Builder is our answer. What starts as a helpful productivity assistant can evolve into a core part of how your team operates and how you ship software. As your needs grow, you can extend your agents with Agent Builder's full capabilities:

多年来，我们的用户——主要是开发者——一直希望我们能帮助他们的同事无需编写代码即可构建智能体（agents）。Agent Builder 正是我们的回应。一个起初仅作为高效生产力助手的智能体，可逐步演变为团队日常协作与软件交付流程中的核心组成部分。随着需求不断增长，您可通过 Agent Builder 的全部功能对智能体进行扩展：

- **Share agents with your team:** Create an agent once, then let teammates clone and adapt it using your shared workspace.  
- **与团队共享智能体：** 一次性创建智能体后，团队成员即可通过共享工作区克隆并按需调整该智能体。

- **Add agent capabilities with MCP:** Connect additional tools through a remote MCP server, including custom integrations or tools from providers you already use.  
- **借助 MCP 增强智能体能力：** 通过远程 MCP 服务器接入更多工具，包括您自定义的集成或已使用的第三方服务工具。

- **Choose the right model for the job:** Bring your own model to optimize for cost, latency, or capability.  
- **为任务选择最合适的模型：** 支持自带模型（Bring Your Own Model），以在成本、延迟或能力等方面实现最优平衡。

- **Use agents anywhere:** Embed agents in your product or call them via API as subagents inside larger graphs.  
- **随时随地使用智能体：** 可将智能体嵌入您的产品中，也可通过 API 调用，作为子智能体（subagents）集成至更复杂的智能体图谱（agent graphs）中。

### Getting started

### 入门指南

Agent Builder is available on all LangSmith plans today. [Try it free](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com), then scale as your agent fleet grows, taking on mundane work so you can stay focused on the most important parts of your day.

Agent Builder 现已面向所有 LangSmith 计划开放。[立即免费试用](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)，随后随您的智能体规模扩大而灵活扩容，让智能体承担重复性工作，助您专注于每日最关键的任务。

### Tags

### 标签

[agents](https://blog.langchain.com/tag/agents/) [agent builder](https://blog.langchain.com/tag/agent-builder/)

[agents](https://blog.langchain.com/tag/agents/) [agent builder](https://blog.langchain.com/tag/agent-builder/)

[![Introducing Agent Builder templates](images/now-ga-langsmith-agent-builder/img_002.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板库](images/now-ga-langsmith-agent-builder/img_002.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**借助 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：3 分钟

[![Building Multi-Agent Apps](images/now-ga-langsmith-agent-builder/img_003.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[![构建多智能体应用](images/now-ga-langsmith-agent-builder/img_003.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**使用 Deep Agents 构建多智能体应用**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 min read

[deep agents](https://blog.langchain.com/tag/deep-agents/) 阅读时长：5 分钟

[![Agent Builder now available in Public Beta](images/now-ga-langsmith-agent-builder/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试](images/now-ga-langsmith-agent-builder/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Semantic Search for LangGraph Memory](images/now-ga-langsmith-agent-builder/img_005.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[![LangGraph 内存的语义搜索](images/now-ga-langsmith-agent-builder/img_005.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**Semantic Search for LangGraph Memory**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**LangGraph 内存的语义搜索**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 min read

[langgraph](https://blog.langchain.com/tag/langgraph/) 阅读时长：3 分钟

[![Reflection Agents](images/now-ga-langsmith-agent-builder/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[![反思型智能体（Reflection Agents）](images/now-ga-langsmith-agent-builder/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[**Reflection Agents**](https://blog.langchain.com/reflection-agents/)

[**反思型智能体（Reflection Agents）**](https://blog.langchain.com/reflection-agents/)

[agents](https://blog.langchain.com/tag/agents/) 6 min read

[智能体（agents）](https://blog.langchain.com/tag/agents/) 阅读时长：6 分钟

[![Plan + Execute Agent Thumbnail](images/now-ga-langsmith-agent-builder/img_007.png)](https://blog.langchain.com/planning-agents/)

[![Plan + Execute Agent 缩略图](images/now-ga-langsmith-agent-builder/img_007.png)](https://blog.langchain.com/planning-agents/)

[**Plan-and-Execute Agents**](https://blog.langchain.com/planning-agents/)

[**规划与执行型智能体（Plan-and-Execute Agents）**](https://blog.langchain.com/planning-agents/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：5 分钟
{% endraw %}
