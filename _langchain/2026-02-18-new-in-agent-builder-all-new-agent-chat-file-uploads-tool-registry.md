---
title: "New in Agent Builder: all new agent chat, file uploads + tool registry"
source: "LangChain Blog"
url: "https://blog.langchain.com/new-in-agent-builder-all-new-agent-chat-file-uploads-tool-registry/"
date: "2026-02-18"
scraped_at: "2026-03-02T10:08:08.896781038+00:00"
language: "en-zh"
translated: true
description: "Today, we&apos;re expanding what you can do with LangSmith Agent Builder. It&#x2019;s an big update built around a simple idea: working with an agent should feel like working with a teammate.We rebuil..."
---
{% raw %}

Today, we're expanding what you can do with [LangSmith Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com). It’s an big update built around a simple idea: working with an agent should feel like working with a teammate.

今天，我们正在拓展您使用 [LangSmith Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com) 所能完成的任务。这是一次重大更新，其核心理念十分简单：与智能体协作，应当如同与一位真实队友协作一样自然。

We rebuilt Agent Builder around this idea. There is now an always available agent (”Chat”) that you can use to run ad hoc tasks or create specialized agents. We’ve also added the ability for agents to use uploaded files and make it clear what tools your agents can use.

我们围绕这一理念全面重构了 Agent Builder。现在，一个始终在线的智能体（“Chat”）已随时待命——您既可用它执行临时性任务，也可基于它快速创建专用智能体。此外，我们新增了智能体对上传文件的支持，并清晰呈现您的智能体可调用的所有工具。

[Try Agent Builder free](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com).

[免费试用 Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)。

### **Here’s what’s new**

### **本次更新亮点**

- **One agent with all your tools:** A central “Chat” agent now has access to every tool in your workspace, so you can ask questions and take actions without creating a dedicated agent.

- **一个智能体，集成全部工具：** 一个统一的“Chat”智能体现已可访问您工作区中连接的所有工具，因此您无需预先创建专用智能体，即可直接提问或执行操作。

- **Turn any chat into an agent:** Work through a task conversationally, then turn it into a recurring agent with one click.

- **任意聊天均可一键转为智能体：** 以对话方式逐步完成一项任务后，只需单击一次，即可将其保存为可重复使用的智能体。

- **Upload files:** Add CSVs, images, and text files directly into chat for data analysis, image processing, or to give your agent reference material.

- **支持文件上传：** 可直接将 CSV 文件、图片和文本文件添加至聊天窗口，用于数据分析、图像处理，或为您的智能体提供参考材料。

- **Manage tools in one place.** View, authenticate, and add tools from a single tools registry, with admin controls for governance.

- **统一管理所有工具：** 在单一工具注册中心内集中查看、认证及添加工具，并通过管理员权限实现治理管控。

## One agent with all your tools

## 一个智能体，集成全部工具

Agent Builder Chat can access every tool you’ve connected to your workspace, such as Slack, Gmail, Linear, Pylon, and any others you've connected with [remote MCP server](https://docs.langchain.com/langsmith/agent-builder-remote-mcp-servers?ref=blog.langchain.com). That means you can ask questions like "What are my open Linear tickets?" or "Summarize today’s requests in #support" without needing to set up a dedicated agent first.

Agent Builder Chat 可访问您工作区中已连接的所有工具，例如 Slack、Gmail、Linear、Pylon，以及您通过 [远程 MCP 服务器](https://docs.langchain.com/langsmith/agent-builder-remote-mcp-servers?ref=blog.langchain.com) 接入的其他任何工具。这意味着，您无需预先配置专用智能体，即可直接提出类似“我当前有哪些未关闭的 Linear 工单？”或“汇总今日 #support 频道中的全部请求”之类的问题。

Type a question or request, then Agent Builder makes a plan, pulls in the right tools, and works through it step by step. If something needs your approval, like sending a message or creating a ticket, it loops you in before taking action.

只需输入一个问题或请求，Agent Builder 将自动制定执行计划，调用恰当的工具，并分步完成任务。若某项操作需您确认（例如发送消息或创建工单），它将在执行前主动邀请您介入审批。

Agent Builder can also string together multiple tools based on your needs. If you’re catching up on emails, you can ask for a quick summary of the last 10 messages. Then ask it to create calendar events for any meeting requests. Agent Builder calls new tools as required.

Agent Builder 还可根据您的需求灵活串联多个工具。例如，在查阅邮件时，您可要求其快速总结最近 10 封邮件内容；随后再让其为其中所有会议邀约自动生成日历事件。Agent Builder 将按需动态调用相应工具。

You can run multiple chats at once. Kick off a task in one conversation, open a new thread, and work on something else. Each chat runs independently so you can come back to any of them to check progress, approve actions, or ask follow-up questions.

您可同时运行多个聊天会话：在一个会话中启动一项任务，再新建一个线程处理其他事务。每个会话彼此独立运行，因此您可随时返回任一会话，查看进度、审批操作，或提出后续问题。

/0:23

1×

## **Turn any chat into an agent**

## **将任意聊天转化为智能体**

This central Chat agent enables a new powerful way to create agents. You start with a question like, "Create a summary of this week's support tickets from Pylon and draft a Slack update for my team." Agent Builder works through the task and you refine the output with feedback.

这一核心 Chat 智能体提供了一种全新而强大的智能体构建方式。您只需提出一个问题，例如：“汇总本周来自 Pylon 的支持工单，并为我的团队草拟一条 Slack 更新消息。”Agent Builder 将逐步执行该任务，您则可通过反馈不断优化输出结果。

At any point, you can select "Turn this conversation into a reusable agent” to create an agent for that task.

在对话过程中的任意时刻，您均可点击“将本次对话转为可复用的智能体”，从而为该任务创建一个专属智能体。

That's it. You've got a recurring agent ready to manage things for you going forward. There’s no prompt engineering and no if/then logic to work through. Your conversation with Agent Builder is the setup. And every conversation is saved for future reference, so you can always return to a task in the future to make it an agent, even if you didn’t think to do so in the first place.

就这样！您已拥有一个可重复使用的智能体，随时准备为您持续处理相关事务。整个过程无需提示词工程（prompt engineering），也无需编写任何 if/then 逻辑。您与 Agent Builder 的自然对话本身，就是智能体的全部配置。此外，每一次对话均会被自动保存，供日后查阅——即使您最初并未想到要将其转为智能体，未来仍可随时回溯该任务并完成转化。

We've seen this pattern work especially well for:

我们发现这种模式在以下场景中尤为高效：

- **Research:** "Find the latest news about my top 10 customers from the web and send me a summary in Slack."  
- **研究类任务**：“从网络上检索我前十大客户最新的新闻动态，并通过 Slack 向我发送摘要。”

- **Writing:** "Review the last 20 posts on our company blog and develop a voice and tone guide as a Google Doc."  
- **写作类任务**：“审阅公司博客最近发布的 20 篇文章，并据此撰写一份语气与风格指南（以 Google Doc 形式呈现）。”

- **Summarization:** "Pull this week's Linear issues, analyze trends, and draft a summary."  
- **摘要类任务**：“提取本周 Linear 中的所有问题，分析趋势，并草拟一份总结报告。”

- **Communications:** "For each new lead in HubSpot, research their company and draft a personalized outreach email."  
- **沟通类任务**：“针对 HubSpot 中每一条新线索，调研其所属公司，并撰写一封个性化开发邮件。”

For any agent you create, you can trigger them manually, put them on a schedule, or have them respond to external events, like a Slack message or email. And because they started with a real conversation with you, they already know what a good output looks like.

对于您创建的任一智能体，均可选择手动触发、设定定时运行，或使其响应外部事件（例如一条 Slack 消息或一封电子邮件）。更重要的是，由于每个智能体都源于您真实的一次对话，它已天然理解何为高质量的输出。

/0:35

1×

## **Upload files to any conversation**

## **将文件上传至任意对话**

Until now, Agent Builder could only work with data from your connected tools and things you wrote in chat. Now you can upload files directly, like a CSV, a screenshot, or a style guide, and your agent can act on them. Uploading files enables new capabilities like:

此前，Agent Builder 仅能处理您已连接工具中的数据以及您在聊天中输入的内容。现在，您可以直接上传文件（例如 CSV 文件、截图或风格指南），您的智能体即可基于这些文件执行操作。文件上传功能解锁了多项新能力，例如：

**Analyze data on the fly.** Upload a CSV, such as last quarter's sales numbers, and ask Agent Builder to find trends and send a report to your team in Slack.

**实时分析数据。** 上传一份 CSV 文件（例如上一季度的销售数据），并让 Agent Builder 识别其中的趋势，再将分析报告自动发送至您的团队 Slack 频道。

**Work with images.** Upload a screenshot or photo, and ask Agent Builder to use it, such as converting a photo of whiteboard notes into a Google Doc.

**处理图像。** 上传一张截图或照片，并指示 Agent Builder 对其进行操作，例如将白板笔记的照片转换为 Google 文档。

**Import docs and reference material.** Upload a writing style guide or an existing prompt to give your agent a head start. This is especially useful when you're building a new agent.

**导入文档与参考资料。** 上传写作规范指南或现有提示词（prompt），为您的智能体提供初始支持。此功能在构建全新智能体时尤为实用。

## **Manage your tools in one place**

## **统一管理您的工具**

We've also made it easier to see and manage all of your tools in one place.

我们还进一步优化了工具管理体验，让您能够更便捷地在一个界面中查看和管理所有工具。

From your workspace settings, you can view all connected tools, authenticate new ones, and add remote MCP servers. If a tool needs re-authentication, you'll see it right away. And when you connect a new tool, it's immediately available to all of your agents.

在工作区设置中，您可以查看所有已连接的工具、对新工具进行身份验证，以及添加远程 MCP 服务器。若某工具需要重新认证，系统将立即向您提示；而一旦您成功连接一个新工具，它便会即时对您全部智能体开放使用。

Only workspace administrators can add new tools, so your team stays in control of what tools agents can access.

仅工作区管理员有权添加新工具，从而确保您的团队始终掌握智能体可访问工具的权限控制权。

## **Try it out**

## **立即体验**

That’s the update: a central chat that can use all your tools, conversations that you can turn into agents, file uploads, and simpler tool management. All of this makes it easier to go from working on a problem to having an agent handle it for you.

这就是本次更新的内容：一个可调用您全部工具的中心化聊天界面、可转化为智能体的对话、文件上传功能，以及更简化的工具管理。所有这些改进，都让您的工作流程从“手动解决问题”无缝过渡到“由智能体代您处理问题”。

If you haven't tried Agent Builder yet, this is a great time to start. And if you're already building, we'd love to [hear what you think](https://www.langchain.com/join-community?ref=blog.langchain.com).

如果您尚未尝试过 Agent Builder，现在正是开始的最佳时机。如果您已在构建相关应用，我们非常期待[聆听您的反馈](https://www.langchain.com/join-community?ref=blog.langchain.com)。

[Try Agent Builder free](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com).

[免费试用 Agent Builder](https://smith.langchain.com/agents?skipOnboarding=true&ref=blog.langchain.com)。
{% endraw %}
