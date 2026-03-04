---
title: "Introducing ambient agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-ambient-agents/"
date: "2025-01-14"
scraped_at: "2026-03-03T07:44:36.029264314+00:00"
language: "en-zh"
translated: true
---
{% raw %}

Most AI apps today follow a familiar chat pattern ( ["chat" UX](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)). Though easy to implement, they create unnecessary interaction overhead, limit the ability of us humans to scale ourselves, and fail to use the full potential of LLMs.

如今，大多数 AI 应用都遵循一种熟悉的聊天交互模式（[“聊天”用户体验（UX）](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)）。尽管这种模式易于实现，但它带来了不必要的交互开销，限制了我们人类自身能力的规模化扩展，并未能充分发挥大语言模型（LLM）的全部潜力。

Over the past six months, we've been exploring a different approach at LangChain: agents that respond to ambient signals and demand user input only when they detect important opportunities or require feedback. Rather than forcing users into new chat windows, these agents help save your attention for when it matters most.

过去六个月中，我们在 LangChain 一直在探索一种不同的路径：构建能响应环境信号（ambient signals）的智能体（agents），仅在检测到关键机会或需要用户反馈时才主动请求输入。这些智能体不会强制用户打开新的聊天窗口，而是帮助您将注意力保留至真正重要的时刻。

We built [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) to make these patterns easy to implement. Today we're sharing our first reference implementation: an [email assistant](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com) that demonstrates key ambient agent patterns. Over the next few days, we'll release additional examples and tooling to help you build your own ambient workflows.

我们开发了 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com)，旨在让上述模式易于实现。今天，我们发布首个参考实现：一款 [电子邮件助手（email assistant）](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com)，它展示了核心的环境型智能体（ambient agent）模式。在接下来的几天里，我们将陆续推出更多示例与配套工具，助您构建属于自己的环境型工作流（ambient workflows）。

## What is an ambient agent?

## 什么是环境型智能体（ambient agent）？

When using ChatGPT (or any other chatbot), they rely on you to initiate the conversation. The agent is kicked off by the human sending a message.

当您使用 ChatGPT（或任何其他聊天机器人）时，对话均由您主动发起——智能体的运行完全依赖于人类发送的第一条消息。

This is great for some use cases, but also severely limiting for others. It requires the user to go into the chat interface and send a message every time they want the agent to do work. There is a lot of overhead in having the agent start work.

这对某些应用场景而言非常理想，但对另一些场景却构成了严重限制：每次希望智能体执行任务时，用户都必须进入聊天界面并手动发送一条消息；而每次启动智能体本身就会带来大量交互开销。

An additional limitation is you can only have one conversation at a time. This makes it hard for us humans to scale ourselves - an agent can only be doing one thing for us at a time.

另一个限制是：您一次只能进行一场对话。这使得我们人类难以实现自我能力的规模化——同一时间，一个智能体只能为您完成一项任务。

If we think about a UX paradigm that allows us to overcome these limitations, it should exhibit two key characteristics:

如果我们构想一种能够突破上述限制的用户体验（UX）范式，它应具备以下两个关键特征：

- It should not (solely) be triggered by human messages  
- It should allow for multiple agents running simultaneously

- 它不应（仅）由人类消息触发；  
- 它应支持多个智能体同时运行。

The characteristics define what we call _ambient agents_.

这些特征共同定义了我们所称的 _环境型智能体（ambient agents）_。

💡

💡

Ambient agents listen to an event stream and act on it accordingly, potentially acting on multiple events at a time.

环境智能体监听事件流，并据此采取相应行动，甚至可能同时响应多个事件。

Notably, however, we do not think that ambient agents are necessarily completely autonomous. In fact, we think a key part of bringing ambient agents to the public will be thoughtful consideration as to _when_ and _how_ these agents interact with humans.

值得注意的是，我们并不认为环境智能体必须完全自主。事实上，我们认为，将环境智能体推向公众的关键环节之一，正是审慎思考这些智能体**何时**以及**如何**与人类交互。

## Human-in-the-loop

## 人在环路中（Human-in-the-loop）

We use human-in-the-loop to refer to _when_ and _how_ these agents interact with humans. We'll talk about _how_ later, but for now let's discuss the _when_.

我们将“人在环路中”（human-in-the-loop）用于指代这些智能体与人类交互的**时机**和**方式**。关于“如何”交互，我们稍后详述；此处先聚焦于“何时”交互。

We typically see three common human-in-the-loop patterns for ambient agents: notify, question, and review.

针对环境智能体，我们通常观察到三种常见的人在环路中模式：通知（notify）、提问（question）和审核（review）。

**Notify:** let the user know some event is important, but not take any actions. This is useful in flagging events that user should see, but where the agent is not empowered to act them. In the context of an email assistant, this could be the agent flagging a Docusign in my inbox - it's not able to sign that Docusign, but I should know it exists.

**通知（Notify）**：告知用户某事件具有重要性，但不执行任何操作。该模式适用于标记用户应当知悉、但智能体无权处理的事件。以邮件助手为例，智能体可标记我收件箱中的一份 DocuSign 文件——它无法代为签署该文件，但我理应知晓其存在。

**Question:** ask the user a question to help unblock the agent. The agent may be trying to take some actions, but unclear on how best to do so because it's lacking some relevant information. Rather than hallucinate or guess, you just have the agent ask the human what to do. In the context of an email assistant, this could be an agent asking me whether I want to go to a conference. Unless something was in the prompt to instruct the agent on my conference preferences, there's no way it should know that. A human EA would ask me, and so should an agentic one.

**提问（Question）**：向用户提出问题，以帮助智能体解除阻塞。智能体可能正尝试执行某些操作，却因缺乏关键信息而难以确定最优做法。此时，与其凭空臆测或随意猜测，不如直接让智能体向人类询问下一步该如何操作。以邮件助手为例，智能体可问我是否愿意参加某场会议。除非提示词中已明确说明我的参会偏好，否则智能体本不该知晓这一信息。一位人类行政助理（EA）会主动询问我，具备自主能力的智能体也应如此。

**Review:** review an action the agent wants to take. Some actions are "dangerous" enough that it may be worth hard coding a review for any action the agent wants to take. The human can either approve the action, edit it directly, or give direct feedback to the agent on how to change it. In the context of an email assistant, this could be an outbound email. It might write a draft, but I would have to approve it, edit the message content directly, or tell the agent to fix it in a certain way.

**审核（Review）**：对智能体拟执行的操作进行人工复核。某些操作风险较高（即所谓“危险操作”），因此值得为所有此类操作硬编码强制复核流程。人类用户可选择批准该操作、直接编辑内容，或向智能体提供具体反馈，指导其如何修改。以邮件助手为例，这适用于外发邮件场景：智能体可生成初稿，但我必须亲自批准、直接编辑邮件正文，或指示智能体按特定要求修正内容。

## The importance of human-in-the-loop

## 人在环路中的重要性

We think this human-in-the-loop component brings three key benefits to ambient agents:

我们认为，这种“人在环中”（human-in-the-loop）机制为环境智能体（ambient agents）带来了三大关键优势：

1. It lowers the stakes, making it easier to ship agents to production  
1. 降低风险，使智能体更易投入生产环境  

2. It mimics how humans communicate, building user trust and adoption  
2. 模仿人类沟通方式，增强用户信任与采用意愿  

3. It empowers long term memory and learning  
3. 赋能长期记忆与持续学习  

**Human-in-the-loop lowers the stakes.**  
**“人在环中”降低了风险。**  

If an agent is running fully autonomously in the background, then it really can't make a mistake. You would have to trust the agent immensely before letting it take certain actions (like updating a database, sending an email to an important client, etc). With human-in-the-loop, you can easily gate those actions and require explicit human approval. This way you can be sure that no errant email will get sent.  
若智能体在后台完全自主运行，则其容错空间极小——在允许它执行某些关键操作（例如更新数据库、向重要客户发送邮件等）之前，你必须对其抱有极高程度的信任。而引入“人在环中”机制后，你可轻松对这些操作设置人工审批关卡，确保每项高风险动作均获得明确的人工授权。如此一来，便能彻底杜绝误发邮件等意外情况。

**Human-in-the-loop mimics how humans communicate.**  
**“人在环中”模拟人类的沟通方式。**  

A big part of working with someone else is communicating with them. Asking them questions when you're unsure, running ideas by them. If we have "co-workers" that are agents, having them communicate in similar patterns builds user trust and therefor adoption. Consider something like [Devin](https://devin.ai/?ref=blog.langchain.com). One of the primary interfaces they chose for users to interact with Devin is in Slack. That's where we interact with human developers, why shouldn't we interact with AI developers in that way? Communication is important.  
与他人协作的核心环节之一，正是持续沟通：当你存疑时主动提问，或把初步想法提出来共同探讨。倘若我们将智能体视作“数字同事”，让它们以类似人类的模式进行交互，便能自然建立用户信任，进而提升产品采纳率。以 [Devin](https://devin.ai/?ref=blog.langchain.com) 为例：其面向用户设计的主要交互界面之一便是 Slack。我们日常正是通过 Slack 与人类开发者协作，那么与 AI 开发者以同样方式互动，又有何不可？沟通本身至关重要。

**Human-in-the-loop empowers long term memory and learning.**  
**“人在环中”赋能长期记忆与持续学习。**  

We strongly believe that a key part of AI agents is their ability to learn over time and better align themselves with their human users. In order for this alignment to happen, they need some form of user feedback. This human-in-the-loop component provides this feedback.  
我们坚信，AI 智能体的核心能力之一，在于其随时间推移持续学习、并日益契合人类用户需求的能力。而要实现这种“人机对齐”（alignment），智能体必须获得某种形式的用户反馈——“人在环中”机制，正是这一反馈闭环的关键载体。

## Agent Inbox  

## 智能体收件箱（Agent Inbox）  

So we talked about _when_ agents should communicate with humans ( **notify**, **question**, **review**), but we didn't talk about _how_ they should.  
此前我们讨论了智能体应于何时与人类沟通（即 **通知**、**提问**、**复核**），但尚未探讨其沟通的具体方式。

When experimenting with ambient agents we initially started with Slack. The main benefit of this is that we're all already in Slack for our day-to-day work, so its an efficient way to get our attention and centralized with our human <> human communication.  
在探索环境智能体初期，我们首先尝试了 Slack。其主要优势在于：我们日常工作本就高度依赖 Slack，因此它是一种高效触达用户注意力的方式，且天然与人类之间的日常沟通融为一体。

The downside of Slack is that it's easy to lose track of all the notifications. If you don't respond to a few, the a backlog of slack notifications grows. A slack channel (or DM) isn't the easiest to navigate. It is also constrictive in how you can communicate with agents - you can message them easily, but anything else is a bit tricker.  
然而 Slack 的短板也很明显：通知极易被淹没。若你稍有延迟未及时响应，Slack 通知便会迅速堆积成 backlog；Slack 频道（或私信）本身也并非理想的导航界面。此外，它对人机交互方式的限制较多——你虽可轻松发送消息，但执行其他类型交互（如勾选、确认、上传文件等）则略显繁琐。

We moved onto what we dubbed an "Agent Inbox". This is new UX for interacting with ambient agents. It's modeled after some combination of an email inbox and a customer support ticketing system. It displays all open lines of communication between you and an agent - making it easy to track any outstanding actions. It's a standalone UI, making it easy to add any panels, buttons, or other UI features that allow you to more easily capture user feedback. Right now items are sorted just by time, but in the future you'll be able to sort it based on priority. Right now this inbox is single player, but in the future you'll be able to see which items are assigned to you versus others.  
于是我们转向了我们称之为“智能体收件箱”（Agent Inbox）的新交互范式。这是一种专为环境智能体设计的全新用户体验（UX），融合了电子邮件收件箱与客户支持工单系统的特点：它集中呈现你与各智能体之间所有待处理的对话线程，便于你清晰追踪每一项待办事项。该收件箱采用独立 UI 构建，因而可灵活集成各类面板、按钮及其他 UI 组件，从而更便捷地收集用户反馈。当前条目仅按时间顺序排列；未来将支持按优先级排序。目前该收件箱为单用户模式；未来还将支持多角色协同——你将能直观区分哪些事项分配给你、哪些分配给其他团队成员。

![](images/introducing-ambient-agents/img_001.png)

_注：代理收件箱（agent inbox）的开源实现将于本周四发布。_

## Why LangGraph is great for ambient agents

## 为何 LangGraph 非常适合构建环境型智能体（ambient agents）

As we've been building ambient agents, we've made sure that [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) is equipped to support these types of agents. There are a few key characteristics that LangGraph (and [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/?ref=blog.langchain.com#langgraph-platform)) have that you probably don't want to build yourself:

在构建环境型智能体的过程中，我们确保 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 已具备支持此类智能体的能力。LangGraph（以及 [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/?ref=blog.langchain.com#langgraph-platform)）具备若干关键特性——这些特性你很可能并不想从零自行开发：

**Built in** [**persistence layer**](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com) **.** LangGraph is backed by a persistence layer that saves the state of the agent between each action (or node of the graph). This allows the agent to essentially "pause" and wait for user feedback. This is important for enabling human-in-the-loop interaction patterns as well as short term conversational memory.

**内置的 [持久化层（persistence layer）](https://langchain-ai.github.io/langgraph/concepts/persistence/?ref=blog.langchain.com)**。LangGraph 底层集成了一个持久化层，可在每次执行动作（或图中每个节点）之间自动保存智能体的状态。这使得智能体能够真正意义上“暂停”运行，并等待用户反馈。该能力对于实现“人在环路中（human-in-the-loop）”的交互模式，以及维持短期对话记忆至关重要。

**Built in** [**human-in-the-loop support**](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com) **.** LangGraph supports human-in-the-loop patterns natively. The built in persistence layer is a big part, but we also recently added ["interrupt"](https://langchain-ai.github.io/langgraph/reference/types/?ref=blog.langchain.com#langgraph.types.interrupt), a new built-in method for communicating with the end user.

**内置的 [人在环路中（human-in-the-loop）支持](https://langchain-ai.github.io/langgraph/concepts/human_in_the_loop/?ref=blog.langchain.com)**。LangGraph 原生支持人在环路中的交互模式。其中，内置持久化层是关键基础；此外，我们近期还新增了 [`interrupt`](https://langchain-ai.github.io/langgraph/reference/types/?ref=blog.langchain.com#langgraph.types.interrupt) 这一内置机制，用于与终端用户进行高效通信。

**Built in** [**long-term memory**](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory) **.** LangGraph comes with built in long-term memory (essentially a namespaced, key-value store that supports semantic search). This makes it easy for agents to update their "memory" after human-in-the-loop interactions.

**内置的 [长期记忆（long-term memory）](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com#long-term-memory)**。LangGraph 内置长期记忆功能（本质上是一个支持语义搜索的、带命名空间的键值存储）。这让智能体在完成人在环路交互后，能轻松更新其“记忆”。

[**Cron jobs**](https://langchain-ai.github.io/langgraph/concepts/langgraph_server/?ref=blog.langchain.com#cron-jobs) **.** Many ambient agents run on a schedule to check for new events. LangGraph Platform comes with built in cron jobs to support this.

[**定时任务（Cron jobs）**](https://langchain-ai.github.io/langgraph/concepts/langgraph_server/?ref=blog.langchain.com#cron-jobs)。许多环境型智能体需按计划周期性运行，以检测新事件。LangGraph Platform 内置了定时任务功能，可直接支持此类需求。

## Building an AI email assistant

## 构建一款 AI 邮件助手

We've made LangGraph great for building ambient agents by building ambient agents that we use every day. One of the main ones is an [email assistant](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com). If you've corresponded with me in the past six months, there's a good chance an AI agent drafted that email (and if I've ignored you — it's definitely the AI agent's fault).

我们通过构建日常高频使用的环境型智能体，持续打磨并强化 LangGraph 在该领域的适用性。其中最具代表性的一款产品便是 [邮件助手（email assistant）](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com)。如果你在过去六个月中曾与我有过邮件往来，那么那封邮件极有可能由 AI 智能体代为起草（而如果我忽略了你的来信——那毫无疑问，责任一定在 AI 智能体身上）。

Today we're launching that email assistant, both as a free-to-use hosted email agent, but also an [open source project](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com). We're hopeful the hosted email agent makes it easy to try out and experience ambient agents, and the open source version serves as a reference implementation for this new design paradigm.

今天，我们正式推出这款电子邮件助手——它既是一个可免费使用的托管式邮件智能体（hosted email agent），也是一个[开源项目](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com)。我们希望托管版邮件助手能帮助用户轻松上手并亲身体验“环境智能体”（ambient agents）的能力；而开源版本则可作为这一全新设计范式的参考实现。

Hosted Email Assistant

托管版邮件助手

- [Platform](https://www.agentinbox.ai/?ref=blog.langchain.com)  
- [平台](https://www.agentinbox.ai/?ref=blog.langchain.com)

- [Instructions](https://mirror-feeling-d80.notion.site/AI-Email-Assistant-How-to-hire-and-communicate-with-an-AI-Email-Assistant-17b808527b178019a42af932bb64badd?pvs=4&ref=blog.langchain.com)  
- [使用指南](https://mirror-feeling-d80.notion.site/AI-Email-Assistant-How-to-hire-and-communicate-with-an-AI-Email-Assistant-17b808527b178019a42af932bb64badd?pvs=4&ref=blog.langchain.com)

- [YouTube Walkthrough](https://youtu.be/-SZkNdmtZ7k?ref=blog.langchain.com)  
- [YouTube 演示视频](https://youtu.be/-SZkNdmtZ7k?ref=blog.langchain.com)

OSS Email Assistant

开源版邮件助手（OSS Email Assistant）

- [Code](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com)  
- [源代码](https://github.com/langchain-ai/executive-ai-assistant?ref=blog.langchain.com)

- [YouTube Walkthrough](https://youtu.be/1A79eYjiBvo?ref=blog.langchain.com)  
- [YouTube 演示视频](https://youtu.be/1A79eYjiBvo?ref=blog.langchain.com)
{% endraw %}
