---
render_with_liquid: false
title: "LangFriend: a Journal with Long-Term Memory"
source: "LangChain Blog"
url: "https://blog.langchain.com/langfriend/"
date: "2024-03-28"
scraped_at: "2026-03-03T08:04:48.532366790+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**One of the concepts we are most interested in at LangChain is memory. Whenever we are interested in a concept, we like to build an example app showing off that concept. For memory, we decided to build a journaling app! We're hosting a version of it that anyone can try out. We're also starting to work with a few alpha users on a developer facing API. If you are interested in this, please sign up below.**

**LangChain 最关注的概念之一是“记忆”（memory）。每当我们对某个概念产生兴趣时，我们通常会构建一个示例应用来直观地展示该概念。针对“记忆”，我们决定开发一款日记应用！目前我们已上线一个可公开试用的版本。同时，我们正与若干早期用户合作，共同打磨面向开发者的 API。如果您对此感兴趣，请在下方报名。**

**Key Links:**  
**关键链接：**

- [**YouTube**](https://www.youtube.com/watch?v=tSicjawrfUY&ref=blog.langchain.com)  
- [**YouTube 视频**](https://www.youtube.com/watch?v=tSicjawrfUY&ref=blog.langchain.com)

- [**Journal App**](https://journal.langchain.com/?ref=blog.langchain.com)  
- [**日记应用**](https://journal.langchain.com/?ref=blog.langchain.com)

- [**Developer API Access**](https://forms.gle/j3Aaa2ibNpg5pC4q7?ref=blog.langchain.com)  
- [**开发者 API 接入申请**](https://forms.gle/j3Aaa2ibNpg5pC4q7?ref=blog.langchain.com)

💡  

We are also doing a memory related hackathon with New Computer, MongoDB and Anthropic on 4/6/2024. Sign up [here](https://lu.ma/taa6ijxt?ref=blog.langchain.com).  
我们还将于 2024 年 4 月 6 日联合 New Computer、MongoDB 与 Anthropic 举办一场聚焦“记忆”主题的黑客松活动。欢迎点击[此处](https://lu.ma/taa6ijxt?ref=blog.langchain.com)报名参与。

One of the components of LLM systems that we are most bullish on is memory. A lot of the power of generative AI is its ability to generate unique content on the fly. This can be incredibly powerful for customizing a user experience. This can be done by drawing upon existing information about users, but it can also be done by remembering previous user interactions and learning from those.  

在大语言模型（LLM）系统中，我们最看好的组件之一便是“记忆”。生成式 AI 的强大之处，很大程度上正源于其能够实时生成独特内容的能力——这为个性化用户体验提供了巨大潜力。这种个性化既可通过调用用户已有的静态信息实现，也可通过“记住”用户过往交互并从中学习来达成。

Is is this type of "remembering" that we are excited about exploring. We think that more and more interactions will occur between a user and an LLM - chatbots are the dominant form factor for LLM applications. This means that more and more valuable user information will be exchanged in those conversation - a persons likes or dislikes, who their friends are, what their goals are. Learning these attributes - and then incorporating them back into the application can greatly improve the user experience.  

正是这类“记忆”能力，令我们倍感兴奋并渴望深入探索。我们认为，用户与 LLM 之间的交互将日益频繁——而聊天机器人（chatbot）正是当前 LLM 应用的主流形态。这意味着，在这些对话中，越来越多有价值的用户信息将被交换：例如用户的喜好与厌恶、朋友关系、人生目标等。若系统能习得这些属性，并将其动态融入后续交互中，用户体验将得到显著提升。

As we were exploring memory, we thought it would be helpful to put together a use case example to motivate and ground a lot of our work. We chose a journaling app to be this use case. We named this journaling app "LangFriend", and are opening it up to the public today. While still just a humble research preview, we hope to gather community feedback on what works well and how to improve it, before open sourcing it.  

在探索“记忆”的过程中，我们认为有必要构建一个具体的应用场景范例，以激发并夯实我们的研究工作。最终，我们选定“日记应用”作为这一用例，并将其命名为 **LangFriend**。今天，我们正式向公众开放该应用。尽管目前它仍只是一个初步的研究预览版，但我们希望借此广泛收集社区反馈——了解哪些功能表现良好、哪些方面尚需改进——从而为后续开源奠定坚实基础。

In this post we'll talk a bit about prior academic work in memory, other companies doing interesting things and why we chose a journaling app to focus on. We'll then deep dive into the journaling app, walking through its functionality. If you are interested in exploring memory with us, please reach out here.  

本文将简要回顾记忆领域的既有学术研究、介绍其他公司在该方向上的创新实践，并阐释我们为何选择“日记应用”作为切入点。随后，我们将深入剖析 LangFriend 的核心功能与实现逻辑。如果您也对“记忆”这一方向充满兴趣，欢迎随时与我们联系。

## Academic Work  
## 学术研究

There are two main academic papers we found inspiring for our work on memory.

我们在记忆研究方面受到两篇主要学术论文的启发。

First: [MemGPT](https://github.com/cpacker/MemGPT?ref=blog.langchain.com). From researchers at UC Berkley, the TLDR of this paper is that they give the LLM the ability to call a few functions. These functions can do things like remember specific facts, recalls related things, etc.

第一篇：[MemGPT](https://github.com/cpacker/MemGPT?ref=blog.langchain.com)。该论文由加州大学伯克利分校（UC Berkeley）的研究人员提出，其核心要点（TLDR）是：赋予大语言模型（LLM）调用若干函数的能力；这些函数可执行诸如记忆特定事实、召回相关知识等操作。

> Large language models (LLMs) have revolutionized AI, but are constrained by limited context windows, hindering their utility in tasks like extended conversations and document analysis. To enable using context beyond limited context windows, we propose virtual context management, a technique drawing inspiration from hierarchical memory systems in traditional operating systems which provide the illusion of an extended virtual memory via paging between physical memory and disk. Using this technique, we introduce MemGPT (MemoryGPT), a system that intelligently manages different storage tiers in order to effectively provide extended context within the LLM’s limited context window

> 大语言模型（LLM）已彻底变革人工智能领域，但其受限于有限的上下文窗口，严重制约了其在长程对话、文档分析等任务中的实用性。为突破上下文窗口限制，我们提出“虚拟上下文管理”（virtual context management）技术——该技术借鉴传统操作系统中分层内存系统的理念，通过在物理内存与磁盘之间进行页面调度（paging），营造出扩展虚拟内存的假象。基于该技术，我们推出了 MemGPT（MemoryGPT）系统，它能智能地管理不同层级的存储资源，从而在 LLM 有限的上下文窗口内高效提供扩展上下文支持。

Second: [Generative Agents](https://arxiv.org/pdf/2304.03442.pdf?ref=blog.langchain.com). From researchers at Stanford, the TLDR of this paper is that they use reflection over experiences to form memories, which are then stored and retrieved programmatically.

第二篇：[Generative Agents](https://arxiv.org/pdf/2304.03442.pdf?ref=blog.langchain.com)。该论文由斯坦福大学研究人员提出，其核心要点（TLDR）是：利用对过往经验的反思（reflection）来构建记忆，并以程序化方式实现记忆的存储与检索。

> We demonstrate through ablation that the components of our agent architecture—observation, planning, and reflection—each contribute critically to the believability of agent behavior. By fusing large language models with computational interactive agents, this work introduces architectural and interaction patterns for enabling believable simulations of human behavior.

> 我们通过消融实验表明，本智能体架构的三大核心组件——感知（observation）、规划（planning）与反思（reflection）——均对提升智能体行为的真实感起到关键作用。本工作将大语言模型与计算型交互智能体深度融合，提出了新型架构设计与交互范式，从而实现对人类行为的高度可信模拟。

One interesting difference between these two papers is the degree to which the LLM actively decides to use memory, versus having it be more of background process. MemGPT forces the LLM to use memory functions, while Generative Agents is more of a background process.

这两篇论文一个有趣的差异在于：LLM 在多大程度上需主动决策调用记忆机制， versus 记忆功能更像一种后台隐式过程。MemGPT 强制 LLM 显式调用记忆相关函数；而 Generative Agents 中的记忆则更接近一种后台运行、自动触发的过程。

## Companies

## 公司实践

There are a few companies doing awesome stuff with memory.

目前已有若干公司在记忆技术应用方面取得了令人瞩目的成果。

Plastic Labs is a startup building projects like [TutorGPT](https://github.com/plastic-labs/tutor-gpt?ref=blog.langchain.com).

Plastic Labs 是一家初创公司，正在开发诸如 [TutorGPT](https://github.com/plastic-labs/tutor-gpt?ref=blog.langchain.com) 等项目。

> LangChain LLM application. Dynamic metaprompting for theory-of-mind-powered tutoring.

> 基于 LangChain 的大语言模型应用：面向心智理论（theory-of-mind）驱动教学的动态元提示（dynamic metaprompting）。

[Good AI](https://github.com/GoodAI/charlie-mnemonic?ref=blog.langchain.com) 是一家初创公司，刚刚开源了一款具备长期记忆（Long-Term Memory, LTM）功能的聊天助手。

[Good AI](https://github.com/GoodAI/charlie-mnemonic?ref=blog.langchain.com) 是一家初创公司，刚刚开源了一款具备长期记忆（Long-Term Memory, LTM）功能的聊天助手。

> At first glance, Charlie might resemble existing LLM agents like ChatGPT, Claude, and Gemini. However, its distinctive feature is the implementation of LTM, enabling it to **learn from every interaction**. This includes **storing and integrating user messages, assistant responses, and environmental feedback into LTM** for future retrieval when relevant to the task at hand.

> 初看之下，Charlie 可能与 ChatGPT、Claude 和 Gemini 等现有大语言模型（LLM）智能体相似。但其独特之处在于实现了长期记忆（LTM），使其能够 **从每一次交互中持续学习**。这包括将 **用户消息、助手回复以及环境反馈** 存储并整合进 LTM 中，以便在后续任务相关时自动调用。

OpenAI has [recently incorporated memory features](https://www.wired.com/story/chatgpt-memory-openai/?ref=blog.langchain.com) into ChatGPT.

OpenAI 最近已在 ChatGPT 中 [集成记忆功能](https://www.wired.com/story/chatgpt-memory-openai/?ref=blog.langchain.com)。

Looking at these companies also displays a difference between implementing memory as something active that the LLM needs to consciously invoke (ChatGPT) versus a background process that is automatically incorporated (TutorGPT).

对比这些公司的实现方式，还可看出一种关键差异：一种是将记忆设计为需由大语言模型主动调用的“显式功能”（如 ChatGPT），另一种则是作为后台自动运行、无需显式触发的“隐式过程”（如 TutorGPT）。

## Why a Journal App?

## 为何选择日记类应用？

When thinking about a good use case to implement to test out long-term memory, a journaling app jumped to mind. The main reason for this is that we believed the interactions in this app would contain more relevant information to remember than a standard chat application.

在思考适合验证长期记忆能力的典型应用场景时，日记类应用立刻浮现在我们脑海中。主要原因在于：我们认为此类应用中的用户交互，相比标准聊天应用，蕴含更多值得长期记忆的实质性信息。

With a standard chat application, there may a lot of superfluous exchanges - "hey!", "hi", "whats up", etc. In a journal setting, you more quickly get to a point where you are sharing real, interesting feelings and insights.

在标准聊天应用中，往往充斥着大量冗余对话——例如“嘿！”“你好！”“最近咋样？”等；而在日记场景下，用户能更快进入状态，分享真实、有趣的情绪与洞见。

Still - we wanted to add a chat component to this app. The main reason for this was to show that our application was learning and remembering information about the user. It would be able to use this information to craft personalized responses to the user.

尽管如此，我们仍希望在该应用中加入聊天组件。主要目的正是为了直观展示：我们的应用确实在持续学习并记住用户的个人信息；并能基于这些记忆，为用户提供高度个性化的回应。

Here you can see it remember that I'm a fan of Italian cuisine, and that I feel refreshed after working out.

此处可见，它已记住我喜爱意大利菜，并且运动后会感到神清气爽。

![](images/langfriend-a-journal-with-long-term-memory/img_001.png)

After adding your first journal, and chatting with our companion, you'll see a "Memories" button appear in the navigation bar. Clicking on this will show you all the main memories we were able to extract from your journals.

在添加第一篇日记并与我们的伙伴聊天后，您将在导航栏中看到一个“记忆”（Memories）按钮。点击该按钮，即可查看我们从您的日记中提取出的所有主要记忆。

![](images/langfriend-a-journal-with-long-term-memory/img_002.png)

You'll notice the list is slim, and doesn't contain too much information. These are just the most important, high level facts we extracted. Behind the scenes we're pulling many more facts than this from your entries, and you can search through all of them!

您会发现该列表内容精简，信息量并不大——这些仅是我们提取出的最重要、最高层级的事实。而在后台，我们实际上从您的日记条目中挖掘出了远多于此的各类事实，您可随时搜索全部内容！

Start typing in the "Search memories..." input, and in real time you'll see the wide variety of facts LangFriend is storing about you:

在“搜索记忆…”（Search memories...）输入框中开始键入文字，您将实时看到 LangFriend 当前为您存储的丰富多样的各类事实：

![](images/langfriend-a-journal-with-long-term-memory/img_003.png)

## Customizing

## 自定义设置

We wanted to make LangFriend as appealing as possible to all users. Because of this, we allow anyone to update the system message that prefixes, and sets the tone of all chats with our companion. A default is included, which we carefully crafted to suit the needs of many users. However if you're looking for something slightly, or entirely different you can change as little, or as much of it as you'd like.

我们希望 LangFriend 尽可能吸引所有用户。因此，我们允许每位用户修改用于前置并设定与伙伴对话整体语调的系统消息（system message）。我们已内置一个默认系统提示，经过精心设计，以满足大多数用户的需求。但若您希望采用稍作调整或完全不同的风格，也可按需修改其中任意部分——无论是一字之改，还是全面重写。

Find the system prompt, and update it by visiting the "Logs" page, and clicking on the "Config" button. From here, a dialog will popup with your system prompt.

请前往“日志”（Logs）页面，点击“配置”（Config）按钮，即可找到并编辑您的系统提示。此时将弹出一个对话框，其中显示当前的系统提示内容。

![](images/langfriend-a-journal-with-long-term-memory/img_004.png)

Any changes made will persist between sessions, and will prefix all your future chat conversations!

所有修改均会在各会话间持久保存，并将作为您后续所有聊天对话的前置提示！

## Conclusion

## 结论

LangFriend is an exciting research preview that showcases the potential of incorporating long-term memory into LLM applications.  

LangFriend 是一项令人振奋的研究预览，展示了将长期记忆融入大语言模型（LLM）应用的潜力。

By focusing on a journaling app, we aim to capture meaningful user information to provide personalized responses and enhance the user experience.  

我们以日记类应用为切入点，旨在捕捉富有意义的用户信息，从而提供个性化的响应，并提升用户体验。

Inspired by academic work and innovative companies in the field, LangFriend demonstrates how memory can be actively utilized or incorporated as a background process to create engaging and adaptive interactions.  

受该领域学术研究与创新型公司的启发，LangFriend 展示了记忆如何被主动调用，或作为后台进程无缝融入系统，从而构建更具吸引力和适应性的交互体验。

We're excited to invite the community to explore LangFriend, provide feedback, and join us in pushing the boundaries of what's possible with memory in LLM applications, unlocking the full potential of generative AI for more powerful, personalized, and meaningful user experiences.  

我们诚挚邀请社区成员试用 LangFriend、提出宝贵反馈，并与我们携手拓展记忆在 LLM 应用中的可能性边界，充分释放生成式人工智能的潜能，打造更强大、更个性化、更有意义的用户体验。