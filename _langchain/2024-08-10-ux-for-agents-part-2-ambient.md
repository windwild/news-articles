---
title: "UX for Agents, Part 2: Ambient"
source: "LangChain Blog"
url: "https://blog.langchain.com/ux-for-agents-part-2-ambient/"
date: "2024-08-10"
scraped_at: "2026-03-03T07:55:54.401321779+00:00"
language: "en-zh"
translated: true
description: "This is our second post focused on UX for agents. We discuss ambient background agents, which can handle multiple tasks at the same time, and how they can be used in your workflow."
tags: ["Harrison's Hot Takes"]
---
{% raw %}

_At Sequoia’s AI Ascent conference in March, I talked about three limitations for agents: planning, UX, and memory. Check out that talk_ [_here_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _. This is our second post on UX for agents, focused on ambient agents._

今年3月，在红杉资本（Sequoia）举办的“AI Ascent”大会上，我探讨了智能体（agents）面临的三大局限：规划能力、用户体验（UX）和记忆能力。欢迎点击此处观看该演讲视频：[_此处_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com)。本文是我们关于智能体用户体验的第二篇博客，聚焦于“环境型智能体”（ambient agents）。

In our [previous blog post](https://blog.langchain.com/ux-for-agents-part-1-chat-2/) on chat-based UX for agents, we discussed how chat requires users to proactively think about messaging an AI. But what if the AI could just work in the background for you?

在我们上一篇关于[基于聊天界面的智能体用户体验](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)的博客中，我们讨论了：聊天交互要求用户主动思考“该向AI发送什么消息”。但如果AI能直接在后台为你默默工作呢？

I’d argue that in order for agentic systems to really reach their potential, this shift towards allowing AI to work in the background needs to happen. When tasks are handled in the background, users are generally more tolerant of longer completion times (as they relax expectations for low latency). This frees up the agent to do more work, often more carefully / diligently than in a chat UX.

我认为，要让智能体系统真正释放其全部潜力，就必须完成这一范式转变——即允许AI在后台运行。当任务交由后台处理时，用户通常更能容忍较长的完成时间（因为他们对低延迟的预期自然降低）。这为智能体腾出了更多资源与时间，使其得以执行更复杂、更细致、更审慎的工作，远超传统聊天式交互所能支持的程度。

Additionally, running agents in the background enables us humans to scale our capabilities more effectively. Chat interfaces typically limit us to one task at a time. But if agents are running ambiently in the background, there can be **many** agents handling multiple tasks simultaneously .

此外，让智能体在后台运行，能更有效地扩展人类自身的能力边界。聊天式界面通常将我们限制在单任务模式；而一旦智能体以“环境型”方式在后台持续运行，便可同时启用**多个**智能体，并行处理多项任务。

So, what would this background agent UX look like?

那么，这种后台智能体的用户体验究竟会是什么样？

## Building trust with background agents: Moving from “Human-in-the-loop” to “Human-on-the-loop”

## 通过后台智能体建立信任：从“人在环路中”迈向“人在环路上”

It requires a certain level of trust to let an agent run in the background. How do you build this trust?

让用户放心地让智能体在后台运行，需要建立一定程度的信任。那么，该如何构建这种信任？

One straightforward idea is to just **show** users exactly what the agent is doing. Display all the steps it is taking, and let users observe what is happening. While this information may not be immediately visible (as it would be when streaming a response back), it should be available for users to click into and observe.

一个直观可行的思路，就是**向用户清晰展示**智能体正在执行的每一步操作——完整呈现其行为流程，使用户能够随时观察进展。尽管这些信息未必实时可见（不像流式响应那样即时推送），但它必须可供用户随时点击展开、按需查看。

The next step is to not only let users **see** what is happening, but also let them **correct** the agent. If they see that the agent made an incorrect choice on step 4 of 10, they should be able to go back to step 4 and correct the agent in some way.

下一步，不应止步于让用户“看见”，更要赋予他们“修正”的能力。例如，若用户发现智能体在10个步骤中的第4步做出了错误决策，就应能回溯至该步骤，并以某种方式干预、纠正智能体的行为。

What does this correction look like? There are a few forms this can take. Let’s take a concrete example of correcting an agent that called a tool incorrectly:

这种“修正”具体如何实现？形式可以多种多样。下面我们以一个具体场景为例：修正智能体错误调用工具的情形。

1. You could manually type out the correct tool invocation and make it as if the agent had outputted that, then resume from there  
1. 您可以手动输入正确的工具调用命令，并假装该调用是由智能体（agent）输出的，然后从此处继续执行。

2. You give the agent explicit instructions on how to call the tool better — e.g., “call it with argument X, not argument Y” — and ask the agent to **update** its prediction  
2. 您向智能体明确说明如何更准确地调用该工具——例如，“请使用参数 X 调用，而非参数 Y”——并要求智能体**更新**其预测结果。

3. You could update the instructions or state of the agent at the point in time, and then rerun from that step onwards  
3. 您可以在该时间点上更新智能体的指令或内部状态，然后从该步骤起重新运行整个流程。

The difference between options 2 and 3 lies in whether the agent is aware of its previous mistakes. In option 2, the agent is presented with its previous poor generation and asked to correct it, while in option 3, it does not know of its bad prediction (and simply follows updated instructions).  
选项 2 与选项 3 的关键区别在于：智能体是否知晓自己此前的错误。在选项 2 中，智能体会被展示其先前不恰当的输出，并被要求加以修正；而在选项 3 中，智能体并不知晓自己曾做出错误预测（它只是遵循更新后的指令继续执行）。

This approach moves the human from being “in-the-loop” to “on-the-loop”. “On-the-loop” requires the ability to show the user all intermediate steps the agent took, allowing the user to pause a workflow halfway through, provide feedback, and then let the agent continue.  
这一方法将人类角色从“闭环内”（in-the-loop）转变为“环上”（on-the-loop）。“环上”意味着系统需具备向用户完整呈现智能体所有中间步骤的能力，使用户可在工作流中途暂停、提供反馈，再让智能体继续执行。

One application that has implemented a UX similar to this is [Devin, the AI software engineer](https://www.cognition.ai/?ref=blog.langchain.com). [Devin](https://www.youtube.com/watch?v=fjHtjT7GO1c&ref=blog.langchain.com) runs for an extended period of time, but you can see all the steps taken, rewind to the state of development at a specific point in time, and issue corrections from there.  
已实现类似用户体验（UX）的一个典型应用是 [Devin——AI 软件工程师](https://www.cognition.ai/?ref=blog.langchain.com)。[Devin](https://www.youtube.com/watch?v=fjHtjT7GO1c&ref=blog.langchain.com) 可长时间持续运行，但您能清晰查看其执行过的全部步骤，回溯至某一特定时刻的开发状态，并从该节点发起修正。

## Integrating human input: How agents can ask for help when needed  

## 整合人工输入：智能体如何在必要时主动寻求帮助  

Although the agent may be running in the background, that does not mean that it needs to perform a task completely autonomously. There will be moments when the agent does not know what to do or how to answer. At this point, it needs to get the attention of a human and ask for help.  
尽管智能体可能在后台持续运行，但这并不意味着它必须完全自主地完成所有任务。在某些时刻，智能体可能不清楚该如何行动或作答；此时，它需要引起人类注意，并主动请求协助。

A concrete example of this is with an email assistant agent I am building. Although the email assistant can answer basic emails, it often needs my input on certain tasks I **do not** want to automate away. These tasks include reviewing complicated LangChain bug reports, decisions on whether I want to go to conferences, etc.  
一个具体实例是我正在构建的一款邮件助手智能体。虽然该助手可自动回复基础邮件，但在一些我**刻意保留不自动化**的任务上，仍需我的人工介入。这些任务包括审阅复杂的 LangChain 缺陷报告、决定我是否参加某场技术会议等。

In this case, the email assistant needs a way of communicating to me that it needs information to respond. Note that it’s not asking me to respond directly; instead, it’s seeks my opinion on certain tasks, which it can then use to craft and send a nice email or schedule a calendar invite.  
在此场景中，邮件助手需具备一种机制，向我传达“我需要额外信息才能完成响应”。请注意：它并非直接让我代为回复；而是就特定任务征询我的意见，再基于我的反馈撰写并发送得体的邮件，或安排日历邀约。

Currently, I have this assistant set up in Slack. It pings me a question and I respond to it in a thread, natively integrating with my workflow. If I were to think about this type of UX at a larger scale than just an email assistant for myself, I would envision a UX similar to a [customer support dashboard](https://dribbble.com/shots/17286199-Customer-Support-Ticket-Dashboard?ref=blog.langchain.com). This interface would show all the areas where the assistant needs human help, the priority of requests, and any additional metadata.  
目前，我已将该助手部署于 Slack 平台：它会以消息形式 @ 我提出问题，而我在对应线程中回复，天然融入我的日常工作流。若将此类用户体验（UX）拓展至更大范围（不止服务于我个人的邮件助手），我设想的界面将类似于 [客户支持工单看板](https://dribbble.com/shots/17286199-Customer-Support-Ticket-Dashboard?ref=blog.langchain.com)：该界面可集中展示助手所有待人工介入的环节、各请求的优先级，以及任何附加元数据。

![](images/ux-for-agents-part-2-ambient/img_001.jpg)

I initially used the term “Agent Inbox” when describing this email assistant - but more accurately, it’s an inbox for **humans** to assist agents on certain tasks… a bit of a chilling thought.

我最初在描述这款邮件助手时使用了“Agent Inbox”（代理收件箱）这一术语——但更准确地说，它其实是为**人类**设计的收件箱，用于在特定任务中协助智能体……这想法略显令人不安。

## Conclusion

## 结论

I am incredibly bullish on ambient agents, as I think they are key to allowing us to scale our own capabilities as humans.

我对环境型智能体（ambient agents）极度看好，因为我认为它们正是帮助我们人类自身能力实现规模化扩展的关键。

As our team continues building [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com), we are building with these types of UXs in mind. We checkpoint all states, easily allowing for [human-on-the-loop observability, rewinding, and editing](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/time-travel/?ref=blog.langchain.com). This also enables agents to [reach out to a human](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/wait-user-input/?ref=blog.langchain.com) and wait for their response before continuing.

随着我们的团队持续推进 [LangGraph](https://github.com/langchain-ai/langgraph?ref=blog.langchain.com) 的开发，我们始终将此类用户体验（UX）设计作为核心考量。我们对所有状态进行检查点（checkpoint）保存，从而轻松支持[人在回路中的可观测性、时间回溯与编辑功能](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/time-travel/?ref=blog.langchain.com)。这也使得智能体能够[主动联系人类用户](https://langchain-ai.github.io/langgraph/how-tos/human_in_the_loop/wait-user-input/?ref=blog.langchain.com)，并在收到其响应后继续执行后续操作。

If you’re building an application with ambient agents, please reach out. We’d love to hear about your experience!

如果您正在基于环境型智能体构建应用，请务必联系我们！我们非常期待了解您的实践体验！

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/ux-for-agents-part-2-ambient/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/ux-for-agents-part-2-ambient/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪记录到深度洞察：规模化理解智能体行为](images/ux-for-agents-part-2-ambient/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪记录到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![In software, the code documents the app. In AI, the traces do.](images/ux-for-agents-part-2-ambient/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪记录即文档。](images/ux-for-agents-part-2-ambient/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码即文档；在人工智能中，追踪记录即文档。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/ux-for-agents-part-2-ambient/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排层——天哪！](images/ux-for-agents-part-2-ambient/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排层——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/ux-for-agents-part-2-ambient/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/ux-for-agents-part-2-ambient/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/ux-for-agents-part-2-ambient/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/ux-for-agents-part-2-ambient/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
{% endraw %}
