---
title: "Introducing LangSmith’s No Code Agent Builder"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-agent-builder/"
date: "2025-12-18"
scraped_at: "2026-03-03T07:15:19.520242978+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_By Brace Sproul and Sam Crowder_

作者：Brace Sproul 与 Sam Crowder

Today, we’re expanding who can build agents beyond developers. While a lot of the highest volume, customer-facing agents will be built by technical teams, nearly every business user has use cases for agentic applications in their daily routines. Our new **LangSmith Agent Builder** provides a no code agent-building experience — complete with memory and guided prompt creation — that lowers the barrier to building agents.

今天，我们正将“构建智能体（agents）”的能力拓展至开发者之外的更广泛人群。尽管高并发、面向客户的智能体大多仍由技术团队开发，但几乎每一位业务人员在日常工作中都有构建智能体应用的实际需求。我们全新推出的 **LangSmith Agent Builder** 提供一种无需编写代码的智能体构建体验——内置记忆功能与引导式提示词（prompt）创建能力——大幅降低了智能体构建的门槛。

[Try Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com) today, and learn more about our approach below.

立即 [试用 Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com)，并在下方进一步了解我们的设计理念。

## What’s different

## 差异何在？

We’ve spent the past three years building agents alongside millions of developers. We hear from engineering teams how much their colleagues want to build their own agents. Even technical users have asked for faster ways to get started with agents that doesn't always involve writing and deploying code.

过去三年间，我们与数百万开发者并肩构建智能体。我们从工程团队中反复听到：他们的同事迫切希望自主构建属于自己的智能体。即便是具备技术背景的用户，也呼吁提供更快速的入门方式——而这种方式不应总是依赖于编写和部署代码。

That’s why we’re launching **LangSmith** **Agent Builder** in private preview. It empowers everyone in an organization to build agents in a safe and accessible way. Unlike other solutions out there, LangSmith Agent Builder is an agent builder, [not a visual workflow builder](https://blog.langchain.com/not-another-workflow-builder/). Visual workflows builders have two major pitfalls:

因此，我们现以私测形式推出 **LangSmith Agent Builder**。它赋能组织内每一位成员——无论技术背景如何——以安全、便捷的方式构建智能体。与其他现有方案不同，LangSmith Agent Builder 是一款真正的“智能体构建器”，而非[可视化工作流构建器](https://blog.langchain.com/not-another-workflow-builder/)。可视化工作流构建器存在两大根本性缺陷：

1. **可视化工作流构建器并非真正“低门槛”。**  
2. **复杂任务很快会因可视化界面而变得难以管理。**

Rather than follow a predetermined path, agents can delegate more decision-making to an LLM, allowing for more dynamic responses. By focusing on letting users build agents, we make agent building accessible to a broader audience while enabling users to tackle more complicated and complex tasks, rather than simple workflows.

智能体无需遵循预设路径，而是可将更多决策权交由大语言模型（LLM）完成，从而实现更灵活、更动态的响应。通过聚焦于“让用户真正构建智能体”这一核心目标，我们不仅让智能体构建能力触达更广泛的用户群体，更使用户得以应对比简单工作流更为复杂、更具挑战性的实际任务。

## What an agent consists of

## 智能体由哪些部分构成？

Every agent in LangSmith is built from four core components that work together:

LangSmith 中的每一个智能体均由四个协同工作的核心组件构成：

- **Prompt:** This is the brain of your agent containing the logic to describe what the agent should do. With LangSmith agents, all the complexity of the agent is pushed into the prompt (rather than into a complex visual workflow). Writing good prompts is hard but really important, which is why we've built tools to make it easier (learn more in the next section).  
- **提示（Prompt）：** 这是您智能体的“大脑”，其中包含描述智能体应如何行动的逻辑。在 LangSmith 智能体中，所有复杂性都被集中到提示词中（而非嵌入复杂的可视化工作流）。编写高质量的提示词难度很高，但至关重要——正因如此，我们专门构建了工具来降低这一门槛（下一节将详细介绍）。

- **Tools:** In order to interact with the world, agents need to call tools. LangSmith uses MCP to connect your agent to external services and data. We provide built-in tools, but you can also easily bring your own MCP servers. With LangSmith’s new Agent Authorization functionality, you can securely connect to tools your team has approved such as Gmail, Slack, LinkedIn, or Linear – all within the agent building flow.  
- **工具（Tools）：** 为与外部世界交互，智能体需要调用各类工具。LangSmith 基于 MCP（Model Control Protocol）标准，将您的智能体连接至外部服务与数据源。我们提供开箱即用的内置工具，同时也支持您轻松接入自建的 MCP 服务器。借助 LangSmith 全新推出的“智能体授权（Agent Authorization）”功能，您可在智能体构建流程中安全地接入团队已批准的工具（例如 Gmail、Slack、LinkedIn 或 Linear）。

- **Triggers:** Agents don't just respond to chat messages – they can also act automatically on background events. Set up triggers to launch your agent when you receive an email, get a Slack message in a particular channel, or on a time-based schedule.  
- **触发器（Triggers）：** 智能体不仅响应聊天消息，还可基于后台事件自动执行操作。您可以设置触发器，在收到电子邮件、特定 Slack 频道中收到消息，或按时间计划（如每日定时）时自动启动智能体。

- **Subagents:** We recommend starting out by putting most complexity in the prompt. But as complexity grows, you may want to keep the system manageable by creating smaller, more focused subagents for specific tasks.  
- **子智能体（Subagents）：** 我们建议初期将大部分逻辑复杂性置于提示词中；但随着需求增长，您可通过创建更小、更专注的子智能体来分担特定任务，从而保持整个系统的可维护性。

## How we make it easier to build your agent  

## 我们如何让智能体构建更简单  

We've consistently seen that the hardest part of building agents is **writing effective prompts**. Two challenges make this difficult:  

我们持续观察到，构建智能体过程中最困难的环节始终是 **编写高效提示词**。造成这一难点的两大挑战是：

1. Good prompts require detail and specificity, but most people lack prompt engineering experience.  
1. 优质提示词需具备高度细节性与明确性，但多数人缺乏提示工程实践经验。  

2. Prompts need to evolve or be updated as you discover edge cases and new requirements.  
2. 提示词需随边缘场景的发现和新需求的出现而持续演进或更新。

We've set out to make these things easier:  

我们致力于简化上述挑战：

- **Start with a conversation instead of a blank canvas**. First, start with your request and describe what you want your agent to do in plain language. The system then asks you follow up questions to get the details right, auto-generates your agent's system prompt, connects tools, and sets triggers based on your answers. This guided conversation makes it easy to create detailed, effective prompts without prompt engineering expertise.  
- **从一场对话开始，而非面对一张空白画布**。首先，以自然语言清晰表达您的需求及期望智能体完成的任务。系统将据此向您提出一系列跟进问题，精准厘清细节，并基于您的回答自动为您生成系统提示词、连接所需工具、配置相应触发器。这种引导式对话机制，让您无需掌握提示工程专业知识，也能轻松构建出详尽且高效的提示词。

- **Have your agent remember over time.** LangSmith agents have built-in memory for not only their prompt but also the tools that they (and any subagents) have access to. At any point, the agent can update its memory. If you correct the agent, it will now remember that correction so you don't have to prompt it to do so again in the future.  
- **让智能体具备长期记忆能力**。LangSmith 智能体原生支持记忆功能，不仅可记住自身提示词，还能记住其（及其任意子智能体）所接入的所有工具。在任意时刻，智能体均可动态更新其记忆内容。例如，当您纠正了智能体的某次错误行为，它便会永久记住该修正，未来无需重复提示即可自主应用。

LangSmith Agent Builder is great for internal productivity use cases like email, chat, and Salesforce assistants. For instance, you can build an agent to send you a summary of your schedule with meeting prep every day. You could build an email agent that dynamically creates next steps based on the message, from creating Linear tickets, to drafting responses, or sending a Slack message. And, you can make sure to approve any messages before they get sent.  

LangSmith 智能体构建器（Agent Builder）特别适用于内部提效类场景，例如邮件助理、聊天助理及 Salesforce 助理等。举例来说：您可以构建一个每日为您发送日程摘要并附带会议准备要点的智能体；也可以构建一个邮件智能体，根据收件内容动态生成后续动作——包括创建 Linear 工单、草拟回复内容，或向 Slack 发送通知；此外，您还可确保所有外发消息均经人工审核确认后再实际发出。

We'll continue to expand what's possible with Agent Builder based on community feedback — [start building with Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com) to help shape what comes next.  

我们将持续依据社区反馈，不断拓展 Agent Builder 的能力边界——[立即使用 Agent Builder 开始构建](https://smith.langchain.com/?ref=blog.langchain.com)，共同塑造它的未来演进方向。

## Under the hood  

## 底层原理  

We’ve incorporated learnings from the last three years building open source agent frameworks LangChain and LangGraph, as well as our early iteration of this product Open Agent Platform, to inform our design decisions.  

我们在设计中融合了过去三年构建开源智能体框架 LangChain 与 LangGraph 的经验沉淀，也汲取了本产品早期版本——Open Agent Platform 的迭代实践成果，从而指导当前各项关键设计决策。

Today, LangSmith Agent Builder is built on top of our `deepagents` package. Deep Agents gives your agents access to planning capabilities, persistent memory, and the ability to break down complex tasks into manageable subtasks. This means your agent can handle complex, multi-step workflows without you needing to map out every possible scenario; they problem-solve in real time.

今天，LangSmith Agent Builder 构建于我们的 `deepagents` 包之上。Deep Agents 为您的智能体提供规划能力、持久化记忆，以及将复杂任务分解为可管理子任务的能力。这意味着您的智能体能够自主处理复杂、多步骤的工作流，而无需您预先穷举所有可能场景；它们可在运行时实时进行问题求解。

For folks already using the LangChain ecosystem of tools, here's a table with some tips on when to use LangSmith Agent Builder vs. our open source frameworks.

对于已使用 LangChain 工具生态系统的用户，下表提供了一些实用建议，帮助您判断何时应选用 LangSmith Agent Builder，何时更适合采用我们的开源框架。

![](images/introducing-langsmith_s-no-code-agent-builder/img_001.png)

## Try Agent Builder

## 尝试 Agent Builder

If you’re interested in checking out the new experience, you can [try Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com) today! We can’t wait to hear input from the community to continue to improve the experience for everyone.

如果您希望体验这一全新功能，现在即可立即 [尝试 Agent Builder](https://smith.langchain.com/?ref=blog.langchain.com)！我们热切期待来自社区的反馈，以便持续优化产品体验，惠及每一位用户。
&#123;% endraw %}
