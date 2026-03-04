---
title: "Deploy agents instantly with Agent Builder templates"
render_with_liquid: false
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-agent-builder-template-library/"
date: "2026-01-21"
scraped_at: "2026-03-02T10:08:14.593030778+00:00"
language: "en-zh"
translated: true
description: "Introducing the Agent Builder Template Library: a collection of ready-to-deploy agents for common tasks, equipped with the tools you already use."
tags: ["agent builder", "agents"]
---

render_with_liquid: false
[LangSmith Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)  
[LangSmith Agent Builder（LangSmith 智能体构建器）](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)

allows anyone to build an agent with a simple prompt. Ask it to build you a market research agent, and it will follow up with relevant questions to create what you need.  
允许任何人仅凭一条简单提示词即可构建智能体。例如，要求它为你构建一个市场调研智能体，它便会主动提出相关问题，逐步帮你定制所需功能。

But sometimes you want to start with something that’s ready to go. Today we’re introducing the [Agent Builder Template Library](https://www.langchain.com/templates?ref=blog.langchain.com) and expanding our tool integrations to help you get from idea to working agent even faster.  
但有时，你希望直接从开箱即用的方案起步。今天，我们正式推出 **[Agent Builder 模板库（智能体构建器模板库）](https://www.langchain.com/templates?ref=blog.langchain.com)**，并进一步拓展工具集成能力，助你更快地将创意转化为可运行的智能体。

Agent Builder templates are prebuilt agents for common jobs, with tools connected and agent instructions included. They’re ready to deploy and fully customizable. You can update your agent’s instructions, add tools, and set approval requirements.  
Agent Builder 模板是为常见任务预构建的智能体，已预先集成相应工具，并内置清晰的智能体指令。这些模板开箱即用，且支持完全自定义：你可以修改智能体指令、添加新工具，或设置人工审批环节。

Unlike traditional workflow automations, you don’t need to map every step and spend hours debugging changes. Just give your agent feedback like you would a teammate, and it learns.  
与传统工作流自动化不同，你无需手动绘制每一步流程，也无需耗费数小时调试变更。只需像指导团队成员一样向智能体提供反馈，它便会持续学习与优化。

/0:33  
/0:33  

1×  
1×  

We built these templates with the companies who know their domains best, including Tavily, PagerDuty, Exa, Box, and Arcade, and we're adding new templates regularly. [Explore the Template Library](https://www.langchain.com/templates?ref=blog.langchain.com)  
这些模板由在其专业领域最具权威性的公司联合共建，包括 Tavily、PagerDuty、Exa、Box 和 Arcade。我们将持续新增更多模板。[探索模板库](https://www.langchain.com/templates?ref=blog.langchain.com)

![Agent Builder partners](images/deploy-agents-instantly-with-agent-builder-templates/img_001.png)  
![Agent Builder 合作伙伴](images/deploy-agents-instantly-with-agent-builder-templates/img_001.png)

**Try out these agent templates today:**  
**立即试用以下智能体模板：**

- **Calendar Brief (Google Calendar):** Reviews your calendar each morning and sends you a summary with research on meeting participants.  
- **日程简报（Google 日历）：** 每天清晨自动查阅你的日程安排，并发送一份摘要邮件，其中包含对参会人员的背景调研信息。

- **Email Assistant (Gmail):** Categorizes your emails and drafts replies for your approval.  
- **邮件助手（Gmail）：** 自动对收件箱邮件进行分类，并草拟回复内容供你审阅批准。

- **Incident Responder (PagerDuty):** Analyzes alerts, cross-references your runbook, and recommends actions.  
- **事件响应员（PagerDuty）：** 分析告警信息，对照你的运维手册（runbook），并推荐相应处置措施。

- **Document intake review (Box):** Reviews file submissions and prepares a summary for your approval.  
- **文档接收审核（Box）：** 审阅用户提交的文件，并生成摘要报告供你审批。

- **Talent sourcing (Exa):** Searches LinkedIn based on your job description and sends recommended candidate profiles.  
- **人才寻源（Exa）：** 根据你提供的职位描述，在 LinkedIn 上搜索匹配候选人，并推送推荐人选档案。

- **Competitor research (Tavily):** Conducts deep competitive research and delivers concise reports.  
- **竞品研究（Tavily）：** 开展深度竞品分析，并输出简洁明了的研究报告。

- **Social Media Monitor (X + Slack):** Monitors X and sends a daily digest to Slack with the latest news.  
- **社交媒体监控（X + Slack）：** 实时监测 X（原 Twitter）平台动态，并每日向 Slack 推送包含最新资讯的简报。

> _“智能体（Agents）是一种将非结构化内容转化为可用数据的强有力方式。在企业中，大量文档工作至今仍依赖人工完成：检查完整性、验证准确性，以及提取用于决策的上下文信息。通过融合 Box 与 Agent Builder 的强大能力，我们让团队能够轻松将智能体嵌入这一工作流，从而将宝贵时间聚焦于关键决策，而非繁琐事务。”_  
>  
> — Ben Kus，Box 首席技术官（CTO）

> _“智能体（Agents）是一种将非结构化内容转化为可用数据的强有力方式。在企业中，大量文档工作至今仍依赖人工完成：检查完整性、验证准确性，以及提取用于决策的上下文信息。通过融合 Box 与 Agent Builder 的强大能力，我们让团队能够轻松将智能体嵌入这一工作流，从而将宝贵时间聚焦于关键决策，而非繁琐事务。”_  
>  
> — Ben Kus，Box 首席技术官（CTO）

### See what’s possible with Arcade

### 借助 Arcade，探索无限可能

Today, Agent Builder provides a set of ready made tool integrations and templates. However, there are a nearly infinite number of tools your team may want to connect via MCP. [Arcade](https://www.arcade.dev/?ref=blog.langchain.com)’s MCP Gateway makes an additional 8,000 tools available to Agent Builder for use cases spanning marketing, sales, recruiting, customer success, product, engineering, and general productivity.

目前，Agent Builder 已提供一系列开箱即用的工具集成与模板。然而，您的团队可能希望通过 MCP（Model Control Protocol，模型控制协议）接入的工具数量几乎是无限的。[Arcade](https://www.arcade.dev/?ref=blog.langchain.com) 的 MCP 网关额外为 Agent Builder 开放了 8,000 种工具，覆盖市场营销、销售、招聘、客户成功、产品、工程及通用办公等各类应用场景。

To show what’s possible, Arcade developed a collection of 60+ ready-to-deploy Agent Builder templates, available in their own hosted gallery. Each template includes a step-by-step guide to set up and start using your agent. [Explore Arcade templates](https://www.arcade.dev/agents/langsmith-agentbuilder?ref=blog.langchain.com).

为展示其潜力，Arcade 构建了 60 多个开箱即用的 Agent Builder 模板，并集中托管在其专属模板画廊中。每个模板均配有分步操作指南，助您快速完成配置并立即启用智能体。[浏览 Arcade 模板](https://www.arcade.dev/agents/langsmith-agentbuilder?ref=blog.langchain.com)。

![](images/deploy-agents-instantly-with-agent-builder-templates/img_002.png)

![](images/deploy-agents-instantly-with-agent-builder-templates/img_002.png)

### Choose the best model for your agent

### 为您的智能体选择最合适的模型

Whether you're starting from a prompt or a template, different jobs may call for different models. Cost, latency, and reasoning requirements vary depending on whether your agent is summarizing emails overnight or responding to questions in real time. That’s why Agent Builder doesn’t lock you into just one model. It supports OpenAI, Anthropic, and Google Gemini models, plus any custom or open source models that follow OpenAI or Anthropic specs.

无论您从提示词（prompt）还是模板起步，不同任务往往需要不同的大语言模型。成本、响应延迟与推理能力要求，会因场景而异——例如，是夜间批量处理邮件摘要，还是实时响应用户提问。正因如此，Agent Builder 并不强制绑定单一模型。它原生支持 OpenAI、Anthropic 和 Google Gemini 等主流模型，同时也兼容任何遵循 OpenAI 或 Anthropic API 规范的自定义模型或开源模型。

To show what’s possible, Baseten [built an agent](https://www.baseten.co/blog/production-ai-for-non-technical-knowledge-workers-langchain-agent-builder-with-gl/?ref=blog.langchain.com) using their GLM 4.7 model that responds quickly for real-time user interaction. Connect your [preferred model provider](https://docs.langchain.com/langsmith/agent-builder-quickstart?ref=blog.langchain.com) to Agent Builder, and then you can get building.

为展示实际效果，Baseten [基于其 GLM 4.7 模型构建了一个智能体](https://www.baseten.co/blog/production-ai-for-non-technical-knowledge-workers-langchain-agent-builder-with-gl/?ref=blog.langchain.com)，可实现毫秒级响应，完美适配实时用户交互场景。只需将您偏好的模型服务商（[查看支持列表](https://docs.langchain.com/langsmith/agent-builder-quickstart?ref=blog.langchain.com)）接入 Agent Builder，即可立即开始构建。

### Turn your idea into a community template

### 将您的创意转化为社区共享模板

This is only the beginning and we're building alongside the community. If you've built an agent you love, whether it's automating sales outreach, monitoring production systems, or conducting research, we’d love to hear about it.

这仅仅是一个起点，我们正与整个开发者社区携手共建。如果您已开发出一个令您满意的智能体——无论是用于自动化销售外联、监控生产系统，还是开展专业研究——我们都热切期待您的分享！

Join our [Community Slack](https://www.langchain.com/join-community?ref=blog.langchain.com) and share it in #agent-builder-templates. We’re turning the best community agents into first-class templates.

加入我们的 [社区 Slack](https://www.langchain.com/join-community?ref=blog.langchain.com)，并在 #agent-builder-templates 频道中分享您的成果。我们将把社区中最优秀的智能体（agents）打造为一流模板。

## What's next

## 下一步是什么？

We’re just getting started with Agent Builder and learning every day as more people build agents. Try Agent Builder for free today and share what you build in #agent-builder-templates.

Agent Builder 刚刚起步，随着越来越多开发者构建智能体，我们也在持续学习与进化。今天即可免费试用 Agent Builder，并在 #agent-builder-templates 频道中分享您的作品。

Get started:

立即开始：

- [Try Agent Builder free](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)  
- [免费试用 Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)

- [Explore the Template Library](https://www.langchain.com/templates?ref=blog.langchain.com)  
- [探索模板库](https://www.langchain.com/templates?ref=blog.langchain.com)

- [Join the Community Slack](https://www.langchain.com/join-community?ref=blog.langchain.com)  
- [加入社区 Slack](https://www.langchain.com/join-community?ref=blog.langchain.com)

### Tags

### 标签

[agent builder](https://blog.langchain.com/tag/agent-builder/) [agents](https://blog.langchain.com/tag/agents/)  

[agent builder](https://blog.langchain.com/tag/agent-builder/) [智能体（agents）](https://blog.langchain.com/tag/agents/)

[![Building Multi-Agent Apps](images/deploy-agents-instantly-with-agent-builder-templates/img_003.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)  

[**使用 Deep Agents 构建多智能体应用**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 分钟阅读

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 分钟阅读

[![LangSmith Agent Builder Now Generally Available](images/deploy-agents-instantly-with-agent-builder-templates/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布](images/deploy-agents-instantly-with-agent-builder-templates/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**现已正式发布：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 分钟阅读

[agents](https://blog.langchain.com/tag/agents/) 2 分钟阅读

[![Agent Builder now available in Public Beta](images/deploy-agents-instantly-with-agent-builder-templates/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试](images/deploy-agents-instantly-with-agent-builder-templates/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 分钟阅读

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 分钟阅读

[![Semantic Search for LangGraph Memory](images/deploy-agents-instantly-with-agent-builder-templates/img_006.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[![LangGraph 内存的语义搜索功能](images/deploy-agents-instantly-with-agent-builder-templates/img_006.png)](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**Semantic Search for LangGraph Memory**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[**LangGraph 内存的语义搜索功能**](https://blog.langchain.com/semantic-search-for-langgraph-memory/)

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 分钟阅读

[langgraph](https://blog.langchain.com/tag/langgraph/) 3 分钟阅读

[![Reflection Agents](images/deploy-agents-instantly-with-agent-builder-templates/img_007.jpg)](https://blog.langchain.com/reflection-agents/)

[![反思型智能体（Reflection Agents）](images/deploy-agents-instantly-with-agent-builder-templates/img_007.jpg)](https://blog.langchain.com/reflection-agents/)

[**Reflection Agents**](https://blog.langchain.com/reflection-agents/)

[**反思型智能体**](https://blog.langchain.com/reflection-agents/)

[agents](https://blog.langchain.com/tag/agents/) 6 min read

[智能体（agents）](https://blog.langchain.com/tag/agents/) 阅读时长：6 分钟

[![Plan + Execute Agent Thumbnail](images/deploy-agents-instantly-with-agent-builder-templates/img_008.png)](https://blog.langchain.com/planning-agents/)

[![“规划+执行”智能体缩略图（Plan + Execute Agent Thumbnail）](images/deploy-agents-instantly-with-agent-builder-templates/img_008.png)](https://blog.langchain.com/planning-agents/)

[**Plan-and-Execute Agents**](https://blog.langchain.com/planning-agents/)

[**“规划+执行”智能体**](https://blog.langchain.com/planning-agents/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 min read

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/) 阅读时长：5 分钟