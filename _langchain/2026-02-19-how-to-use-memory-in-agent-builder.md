---
title: "How to Use Memory in Agent Builder"
render_with_liquid: false
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-use-memory-in-agent-builder/"
date: "2026-02-19"
scraped_at: "2026-03-02T10:08:08.747917362+00:00"
language: "en-zh"
translated: true
description: "By Jacob TalbotAgent Builder gets better the more you use it because it remembers your feedback. Every correction you make, preference you share, and approach that works well is something that your ag..."
---

render_with_liquid: false
_By Jacob Talbot_

作者：Jacob Talbot

Agent Builder gets better the more you use it because it remembers your feedback. Every correction you make, preference you share, and approach that works well is something that your agent can hold onto and apply the next time.

Agent Builder 用得越多，效果越好——因为它会记住你的反馈。你做的每一次修正、分享的每一项偏好，以及每一种行之有效的处理方式，都会被你的智能体（agent）记下，并在下次任务中加以应用。

Memory is one of the things that makes Agent Builder feel like a teammate. But like any teammate, it helps to know how to communicate with them effectively. Here are three practical ways to make the most of your agent's memory.

记忆能力是让 Agent Builder 感觉像一位真实队友的关键特性之一。但正如对待任何队友一样，掌握与其高效沟通的方法至关重要。以下是三种切实可行的方式，助你充分释放智能体的记忆潜力。

[Try Agent Builder free](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)

[免费试用 Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)

### A quick primer on how memory works

### 记忆机制快速入门

Before we dig into the tips, it helps to understand what's actually going on under the hood. You can skip ahead to the tips if you'd prefer.

在深入探讨具体技巧之前，先了解其底层工作原理会大有裨益。若您更关注实操建议，也可直接跳至后续章节。

Agent Builder is built on [Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com), LangChain's open source agent harness for autonomous, long-running tasks. Your agent has access to an LLM for reasoning, tools for taking actions (like web search, Slack, or Google Sheets), the ability to spawn subagents, and a filesystem.

Agent Builder 基于 [Deep Agents](https://docs.langchain.com/oss/python/deepagents/overview?ref=blog.langchain.com) 构建——这是 LangChain 推出的开源智能体框架，专为自主运行、长期执行的任务而设计。您的智能体具备以下能力：调用大语言模型（LLM）进行推理；使用各类工具执行操作（例如网页搜索、Slack 消息收发或 Google Sheets 数据处理）；生成子智能体（subagents）；以及访问一个文件系统。

That filesystem is where memory lives. There are two types of memory:

这个文件系统正是记忆的存储之所。记忆分为两类：

- **Short-term memory:** Files your agent creates during a task such as plans, outputs from tool calls (such as web search results), and task progress. These exist for the duration of the conversation, or [thread](https://docs.langchain.com/oss/python/langgraph/persistence?ref=blog.langchain.com), but don’t persist across conversations.

- **短期记忆（Short-term memory）**：智能体在执行任务过程中创建的文件，例如任务计划、工具调用的输出结果（如网页搜索返回的数据）、任务进度记录等。这类文件仅存在于当前对话（或称“线程”[thread](https://docs.langchain.com/oss/python/langgraph/persistence?ref=blog.langchain.com)）期间，不会跨对话保留。

- **Long-term memory:** Files your agent saves to a persistent path ( [/memories/](https://docs.langchain.com/oss/python/deepagents/long-term-memory?ref=blog.langchain.com)). These stick around across every conversation. Your agent's core instructions and skills live here. Memory is stored using standard Markdown files.

- **长期记忆（Long-term memory）**：智能体保存至持久化路径（[/memories/](https://docs.langchain.com/oss/python/deepagents/long-term-memory?ref=blog.langchain.com)）的文件。这些文件在所有对话中均持续存在。智能体的核心指令与核心技能即存放于此。所有记忆均以标准 Markdown 文件格式存储。

That's really it. Memory sounds abstract, but it's just files your agent can read and write to get better at its job.

以上便是全部要点。记忆听起来或许抽象，但它本质上只是智能体可读可写的普通文件——通过持续读写这些文件，智能体便能不断提升自身任务完成能力。

### Tell your agent to remember

### 告诉你的智能体记住这些内容

When you're working with your agent, you're constantly generating useful context. Maybe you've iterated on a format that works well, or you've refined exactly how you want results presented. That context lives in short term memory but it doesn't have to stay there.

当你与智能体协作时，你持续生成着有价值的情境信息。例如，你可能反复调整出一种效果良好的输出格式，或已精准定义了期望结果的呈现方式。这类情境信息暂存于短期记忆中，但不必仅停留于此。

You can tell your agent to save what it's learned. Try something like:

你可以指示智能体保存它所学到的内容。例如，尝试这样说：

"That approach worked really well. Update your instructions to always use that going forward."

“这个方法效果非常好。请将此方法更新至你的长期指令中，并在今后始终沿用。”

"Remember that I prefer bullet points over long paragraphs."

“请记住：我偏好使用项目符号列表，而非大段文字。”

"Incorporate what you learned from this conversation into your memory."

“请将本次对话中获得的经验整合进你的记忆。”

Your agent will update its long-term instructions based on your feedback in the same way a teammate would take notes after a productive working session. Over time, this means fewer corrections and better results from the start.

智能体会依据你的反馈，像一位高效协作的同事在一次富有成效的工作会议后做笔记那样，动态更新其长期指令。久而久之，这意味着你需做出的修正越来越少，且从初始阶段就能获得更优的结果。

In practice, this step isn't always necessary. If you give your agent clear feedback, like "Change your writing style to direct, concise prose," it will recognize that as something worth remembering. It'll propose the change to its instructions and ask for your approval before saving it. Telling your agent to remember is most useful when the takeaway is less obvious, such as when you've been iterating on a problem together and arrived at an approach that works, but never stated it explicitly.

在实际操作中，这一步并非总是必需。如果你给出明确的反馈（例如：“将你的写作风格改为直接、简洁的叙述”），智能体便会识别出这是值得记忆的内容；它会先向你提议修改自身指令，并征得你的批准后才予以保存。而当你需要主动说“请记住”时，通常适用于那些隐含性较强、不易被自动捕捉的要点——比如，你们曾共同反复迭代某个问题并最终找到一种行之有效的解决路径，却从未将其明确表述出来。

/0:23

/0:23

1×

1×

### Use skills for specialized context

### 使用技能处理特定上下文

Skills are a form of long-term memory, but with an important distinction: they're only loaded when the task calls for them. Think of it like giving your agent a reference library instead of making it memorize everything upfront. The agent sees the titles on the shelf and only pulls a book down when it's relevant.

技能是一种长期记忆形式，但有一个关键区别：它们仅在任务需要时才被加载。可以将其类比为为你的智能体提供一个参考书库，而不是让它一开始就强行记住所有内容。智能体能看到书架上的书名，仅在相关内容真正相关时才取出某本书。

This matters because more context isn't always better. An agent trying to hold onto everything at once can lose focus on what matters for the current task. This can lead to hallucinations.

这一点至关重要，因为更多上下文并不总是更好。若智能体试图同时保留全部信息，就可能忽略当前任务真正关键的内容，从而导致幻觉（hallucinations）。

Here's a practical example. I have an agent I use for writing content about our products. When I'm writing about LangSmith Deployment, I want the agent to reference that product's features, audience, and positioning. When I'm writing about Agent Builder, it needs different context entirely. And when I'm writing about something unrelated, like LangChain’s upcoming agent conference, [Interrupt](https://interrupt.langchain.com/?ref=blog.langchain.com), it doesn't need detailed product context at all.

下面是一个实际示例：我有一个用于撰写公司产品相关内容的智能体。当我撰写关于 LangSmith 部署（LangSmith Deployment）的内容时，我希望该智能体能调用该产品的功能特性、目标用户及市场定位等上下文；而当我撰写关于 Agent Builder 的内容时，则需要完全不同的上下文；再比如，当我撰写与产品无关的主题（如 LangChain 即将举办的智能体大会 [Interrupt](https://interrupt.langchain.com/?ref=blog.langchain.com)）时，则根本不需要任何详细的产品上下文。

So I set up skills for each product. My agent's core instructions handle voice and writing style. The skills handle product-specific context. The agent pulls in the right skill based on what I'm writing about and ignores the rest.

因此，我为每个产品分别设置了对应的技能。智能体的核心指令负责把控语气和写作风格，而各项技能则承载各自对应的产品专属上下文。智能体将根据我正在撰写的内容，自动调用正确的技能，并忽略其余无关技能。

You can ask your agent to create a skill anytime: "Create a skill for \[topic\] that includes \[what context the agent needs\]."

你可随时要求智能体创建一项新技能：“请为\[主题\]创建一项技能，其中包含\[智能体所需的具体上下文\]。”

/0:10

1×

### Edit your agent's memory directly

### 直接编辑智能体的记忆

Your agent’s instructions and configuration files are accessible to edit directly. You don't need to do this because Agent Builder updates its own instructions based on your feedback. But there are two good reasons to consider it.

你的智能体的指令文件与配置文件均可直接访问并编辑。你通常无需手动操作，因为 Agent Builder 会基于你的反馈自动更新其自身指令。但仍有两个充分的理由值得你考虑手动编辑。

It helps you understand how your agent thinks. Reading your agent's instructions is like reviewing a teammate's project plan. You can see how the agent is approaching your problem, what it prioritizes, and where its assumptions might not match yours. If something looks off, such as an unnecessary step or a wrong assumption, you can fix it directly.

这有助于您理解您的智能体（agent）的思考方式。阅读智能体的指令，就如同审阅一位团队成员的项目计划。您可以清晰地看到该智能体如何应对您的问题、它优先处理哪些事项，以及它的哪些假设可能与您的预期不一致。如果发现异常之处——例如某个不必要的步骤，或某项错误的假设——您可直接进行修正。

Sometimes it's just faster. If you want to change when a scheduled task runs, or tweak a single line in the instructions, a direct edit takes seconds. Asking the agent to make the change works too, but for small, precise updates, editing the file yourself can be the quickest path.

有时，直接编辑就是更快的方式。如果您想调整定时任务的执行时间，或仅需微调指令中的一行内容，手动编辑只需几秒钟。当然，您也可以让智能体自行修改，但对于小型、精准的调整，亲自编辑文件往往是最快捷的路径。

To view and edit your agent's instructions, you can navigate to the agent's memory files.

如需查看并编辑智能体的指令，您可以导航至该智能体的内存文件（memory files）。

/0:15

1×

### Start building

### 开始构建

These are a few simple ways to make your agent smarter over time: tell it to remember, give it specialized skills, and don't be afraid to look under the hood.

以下是几种随时间推移让您的智能体变得更聪明的简单方法：让它记住信息、赋予其专业技能，并且不要害怕“揭开盖子”深入底层细节。

If you build something you love, share it with us in the [Community Slack](https://www.langchain.com/community?ref=blog.langchain.com).

如果您构建了喜爱的作品，欢迎在 [社区 Slack](https://www.langchain.com/community?ref=blog.langchain.com) 中与我们分享！

[Try Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)

[试用 Agent Builder](https://www.langchain.com/langsmith/agent-builder?ref=blog.langchain.com)