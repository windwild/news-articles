---
title: "UX for Agents, Part 1: Chat"
source: "LangChain Blog"
url: "https://blog.langchain.com/ux-for-agents-part-1-chat-2/"
date: "2024-08-10"
scraped_at: "2026-03-03T07:56:03.275961805+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
{% raw %}

_At Sequoia’s AI Ascent conference in March, I talked about three limitations for agents: planning, UX, and memory. Check out that talk_ [_here_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com) _. In this post I will dive deeper into UX for agents. Thanks to Nuno Campos, LangChain founding engineer for many of the original thoughts and analogies here._

在三月举行的红杉资本（Sequoia）“AI Ascend”大会上，我探讨了智能体（agents）面临的三大局限：规划能力、用户体验（UX）和记忆能力。可点击此处观看该演讲视频：[_链接_](https://www.youtube.com/watch?v=pBBe1pk8hf4&ref=blog.langchain.com)。本文将深入探讨智能体的用户体验（UX）设计。特别感谢 LangChain 首席工程师 Nuno Campos，本文中许多原创性思考与类比均源自他的贡献。

_Because there are so many different aspects of UX for agents, this topic will be split into three separate blogs. This is first in the series._

由于智能体的用户体验涵盖诸多不同维度，本主题将分三篇博客展开阐述。本文为该系列的第一篇。

Human-Computer Interaction has been a well-studied area for years. I believe that in the coming years, **Human-Agent** **Interaction** will also become a key area of research.

人机交互（Human-Computer Interaction, HCI）已是多年来的成熟研究领域。我相信，在未来几年中，**人—智能体交互（Human-Agent Interaction）** 也将成为关键的研究方向。

Agentic systems differ from traditional computer systems of the past due to new challenges stemming from latency, unreliability, and natural language interfaces. As such, I strongly believe that new UI/UX paradigms for interacting with these agentic applications will emerge.

智能体系统与过去传统的计算机系统存在本质差异——其面临的新挑战主要源于响应延迟（latency）、行为不可靠性（unreliability）以及自然语言交互界面。因此，我坚信：面向这类智能体应用的全新用户界面（UI）与用户体验（UX）范式必将应运而生。

While it’s still early days for agentic systems, I think there are multiple emerging UX paradigms. In this blog we will discuss perhaps the most dominant UX so far: chat.

尽管智能体系统尚处于发展早期，但我认为已有多种新兴的 UX 范式正在浮现。本文将重点探讨迄今为止最具主导地位的一种 UX 形式：聊天（chat）。

## Streaming Chat

## 流式聊天（Streaming Chat）

The “streaming chat” UX is the most dominant UX so far. This quite simply is an agentic system that streams back its thoughts and actions in a chat format — ChatGPT is the most popular example. This interaction pattern seems basic, but is actually quite good for a few reasons.

“流式聊天”（streaming chat）是目前最主流的 UX 形式。简言之，它指智能体以聊天界面形式，实时流式输出其内部思考过程与执行动作——ChatGPT 即是最广为人知的实例。这种交互模式看似基础，实则具备多重优势。

The main way to “program” an LLM is with natural language. In chat, you interact directly with the LLM through natural language. This means there is little to no barrier between you and the LLM.

对大语言模型（LLM）进行“编程”的主要方式即自然语言。在聊天界面中，你直接使用自然语言与 LLM 交互——这意味着你与 LLM 之间几乎不存在任何理解或操作壁垒。

💡

💡

In some ways, streaming chat is the “terminal” of early computers.

从某种意义上说，流式聊天正是早期计算机时代的“终端”（terminal）。

A terminal (especially in early computers) provides lower-level and more direct access to the underlying OS. But over time, computers have shifted to more UI-based interactions. Streaming chat may be similar - it’s the first way we built to interact with LLMs, and it provides pretty direct access to the underlying LLM. Over time, other UXs may emerge (just as computers became more UI-based) – but low-level access has significant benefits, especially at the start!

终端（尤其是在早期计算机中）提供了对底层操作系统的更低层级、更直接的访问。但随着时间推移，计算机逐渐转向以图形用户界面（UI）为主的交互方式。流式聊天（streaming chat）可能也遵循类似路径——它是我们最初构建的与大语言模型（LLM）交互的方式，因而也提供了对底层 LLM 相当直接的访问。未来，其他用户体验（UX）形式或许会陆续出现（正如计算机日益转向 UI 驱动一样）——但低层级访问具有显著优势，尤其在起步阶段！

One of the reasons that streaming chat is great is that LLMs can take a while to work. Streaming enables the user to understand exactly what is happening under the hood. You can stream back both intermediate actions the LLM takes (both what actions they take, and what the results are) as well as the tokens as the LLM “thinks”.

流式聊天的一大优势在于：LLM 的推理过程往往耗时较长。而流式响应使用户能清晰了解模型“后台”正在发生什么。你不仅可以实时流式返回 LLM 所执行的中间步骤（包括具体采取了哪些动作，以及每步动作的结果），还能逐 token 地呈现 LLM 在“思考”过程中生成的内容。

Another benefit of streaming chat is that LLMs can mess up often. Chat provides a great interface to naturally correct and guide it! We’re very used to having follow-up conversations and discussing things iteratively over chat already.

流式聊天的另一优势是：LLM 出错频率较高，而聊天界面恰好提供了一种自然、顺畅的纠错与引导方式！我们早已习惯在聊天中持续跟进、反复讨论、迭代推进。

Still, streaming chat has its drawbacks. First - streaming chat is a relatively new UX, so our existing chat platforms (iMessage, Facebook messenger, Slack, etc) don’t have this mode built in. Second, it’s a bit awkward for longer-running tasks — am I just going to sit there and watch the agent work? Third, streaming chat generally needs to be triggered by a human, which means the human is still very much in the loop.

然而，流式聊天也存在若干局限。第一，流式聊天是一种相对较新的 UX 形式，因此我们现有的主流聊天平台（如 iMessage、Facebook Messenger、Slack 等）尚未原生支持该模式。第二，对于耗时较长的任务，这种交互略显尴尬——我是否只能干坐着，眼睁睁看着智能体（agent）一步步执行？第三，流式聊天通常需由人类主动触发，这意味着人仍深度处于控制闭环之中。

## Non-streaming Chat

## 非流式聊天

It feels odd to call it “non-streaming” chat, since we would have just called this “chat” up until two years ago — but here we are. Non-streaming chat has many of the same properties of streaming chat - it exposes the LLM pretty directly to the user, and it allows for very natural corrections.

称其为“非流式”聊天似乎有些别扭，因为就在两年前，我们还直接称之为“聊天”——但现实就是如此。非流式聊天继承了流式聊天的诸多特性：它同样将 LLM 相对直接地暴露给用户，并同样支持非常自然的纠错与调整。

The big difference for non-streaming chat is that responses come back in completed batches, which has its pros and cons. The main con is that you can’t see what’s going on under the hood, leaving you in the dark.

非流式聊天最核心的区别在于：响应以完整批次的形式一次性返回，这既带来优势，也伴随弊端。主要弊端是：你无法窥见模型内部的运行过程，因而对“幕后”一无所知。

But… is that actually okay?

但……这真的有问题吗？

Linus Lee had some [great thoughts](https://x.com/thesephist/status/1791292522725023907?ref=blog.langchain.com) on “delegation” recently that I really liked. A snippet just to illustrate:

林纳斯·李（Linus Lee）最近就“委托”（delegation）这一主题发表了一些[极具启发性的见解](https://x.com/thesephist/status/1791292522725023907?ref=blog.langchain.com)，我深以为然。摘录其中一段，以作说明：

> I intentionally built the interface to be as opaque as possible.  
> 我刻意将该界面设计得尽可能不透明。

He argues that an opaque interface requires a certain amount of trust, but once established, allows you to _just delegate tasks to the agent_ without micro-managing. This async nature also lends itself to longer-running tasks — which means agents doing more work for you.

他指出，一个不透明的接口需要一定程度的信任；但一旦这种信任建立起来，你就可以 _直接将任务委派给智能体_，而无需事无巨细地管控。这种异步特性也天然适合耗时较长的任务——这意味着智能体能为你完成更多工作。

Assuming trust is established, this seems good. But it also opens up other issues. For example, how do you handle [“double-texting”](https://langchain-ai.github.io/langgraph/cloud/how-tos/?ref=blog.langchain.com#double-texting) — where the user messages once, the agent starts doing something, and then the user messages again with a different (and sometimes unrelated) thought before the agent finishes its task. With streaming chat, you generally don’t have this issue because the streaming of the agent blocks the user from typing new input.

假设信任已确立，这看起来是件好事；但它同时也引出了其他问题。例如，你该如何应对 [“重复发送消息”（double-texting）](https://langchain-ai.github.io/langgraph/cloud/how-tos/?ref=blog.langchain.com#double-texting)——即用户发送一条消息后，智能体开始执行任务，但尚未完成时，用户又发送了另一条内容不同（有时甚至完全无关）的消息。在流式聊天（streaming chat）中，这类问题通常不会出现，因为智能体正在流式输出响应时，会阻止用户输入新消息。

One of the benefits of the non-streaming chat UX is also much more native to us, which means that it may be easier to integrate into existing workflows. People are used to texting humans — why shouldn’t they easily adapt to texting with an AI?

非流式聊天（non-streaming chat）的用户体验对我们而言也更为自然，这意味着它可能更容易融入现有工作流。人们早已习惯给真人发短信——那他们为何不能轻松适应与 AI 发短信呢？

💡

💡

Another large benefit of non-streaming chat is that it’s often acceptable for the AI to take longer to respond.

非流式聊天的另一大优势在于：AI 响应稍慢，往往也是可以接受的。

This is often due to non-streaming chat being integrated more natively into our existing workflows. We don’t expect our friends to text us back instantaneously — why should we expect an AI to? This makes it easier to interact with more complex agentic systems — these systems often take a while, and if there is the expectation of an instantaneous response that could be frustrating. Non-streaming chat often removes that expectation, making it easier to do more complex things.

这往往是因为非流式聊天更自然地嵌入了我们现有的工作流之中。我们并不会期待朋友秒回短信——那为何要期待 AI 即时响应呢？这使得我们更容易与更复杂的智能体系统交互：这类系统通常需要较长时间运行；若用户抱有“即时响应”的预期，则容易产生挫败感。而非流式聊天恰恰消解了这种预期，从而为执行更复杂的任务铺平了道路。

It may initially seem that streaming is newer, flashier, and more futuristic than standard chat… but as we trust our agentic systems more, will this reverse?

初看之下，流式响应似乎更新颖、更炫酷、也更具未来感……但随着我们对智能体系统的信任日益加深，这种认知是否会逆转？

## Is there more than just chat?

## 除了聊天，还有别的交互方式吗？

As this is just part one of a three-part series, we believe there are more UXs to consider beyond chat. Still — it is worth reminding that **chat is a very good UX,** and that here’s a reason it’s so widely used.

由于本文仅为三部系列文章的第一篇，我们认为除聊天之外，还有更多用户体验（UX）模式值得探讨。不过——仍有必要重申：**聊天是一种极为出色的用户体验（UX）**，而这正是它被广泛应用的原因所在。

Benefits of chat:  
聊天的优势：

- Allows user to interact directly with the model  
- 允许用户直接与模型交互  

- Allows for easy follow up questions and/or corrections  
- 支持便捷的后续提问和/或修正  

**_Pros/Cons of streaming vs. non-streaming chat_**  
**_流式聊天与非流式聊天的优缺点_**

![](images/ux-for-agents-part-1-chat/img_001.png)

### Tags  
### 标签  

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)  
[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)  

[![On Agent Frameworks and Agent Observability](images/ux-for-agents-part-1-chat/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)  
[![论智能体框架与智能体可观测性](images/ux-for-agents-part-1-chat/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)  

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)  
[**论智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)  

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read  
[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟  

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/ux-for-agents-part-1-chat/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)  
[![从追踪数据到深度洞察：规模化理解智能体行为](images/ux-for-agents-part-1-chat/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪到洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![In software, the code documents the app. In AI, the traces do.](images/ux-for-agents-part-1-chat/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件中，代码记录应用；在 AI 中，追踪记录应用。](images/ux-for-agents-part-1-chat/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件中，代码记录应用；在 AI 中，追踪记录应用。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：5 分钟

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/ux-for-agents-part-1-chat/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/ux-for-agents-part-1-chat/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：3 分钟

[![Reflections on Three Years of Building LangChain](images/ux-for-agents-part-1-chat/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/ux-for-agents-part-1-chat/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 分钟阅读

[![Not Another Workflow Builder](images/ux-for-agents-part-1-chat/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读
{% endraw %}
