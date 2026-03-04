---
title: "AI Agent Latency 101: How do I speed up my AI agent?"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-do-i-speed-up-my-agent/"
date: "2026-02-05"
scraped_at: "2026-03-03T07:14:21.647740892+00:00"
language: "en-zh"
translated: true
tags: ["Harrison's Hot Takes"]
---
{% raw %}

I get this question a bunch. Developers generally first spend time getting the agent to work, but then they turn their attention to speed and cost. There are few things we see developers doing:

我经常被问到这个问题。开发者通常首先花时间让智能体（agent）正常运行，随后才将注意力转向响应速度与成本优化。我们观察到，开发者常采取以下几种做法：

- Identifying where the latency is coming from  
- 识别延迟的来源  

- Changing the UX to reduce the “perceived” latency  
- 优化用户体验以降低“感知”延迟  

- Making fewer LLM calls  
- 减少大语言模型（LLM）调用次数  

- Speeding up LLM calls  
- 加快单次 LLM 调用速度  

- Making LLM calls in parallel  
- 并行执行 LLM 调用  

## Identifying where the latency is coming from

## 识别延迟的来源

This may sound basic, but how you approach reducing latency will depend entirely on your specific bottleneck. Is the latency coming from one big LLM call, or from multiple small ones that just add up? You’ll need to diagnose these before trying to speed it up.

这听起来可能很基础，但你应对延迟优化的方式完全取决于你系统中的具体瓶颈所在：延迟是源于一次耗时很长的 LLM 调用，还是由多个看似微小、却累积起来显著拖慢整体响应的调用所导致？在尝试提速之前，你必须先完成精准诊断。

[LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com) is an incredibly useful tool for this, providing complete visibility into your agent interactions. You can track the latency of each step of the agent, and we’ve also recently introduced a “waterfall” view to easily identify which steps contribute the most to overall latency.

[LangSmith](http://langchain.com/langsmith?ref=blog.langchain.com) 是一款极为实用的工具，可为你提供智能体交互过程的完整可观测性。你可以追踪智能体每一步操作的延迟；此外，我们最近还新增了“瀑布图（waterfall）”视图，帮助你直观识别哪些步骤对整体延迟贡献最大。

## Changing the UX to reduce the “perceived” latency

## 优化用户体验以降低“感知”延迟

Sometimes, the easiest way to reduce latency… is to not reduce latency.

有时，降低延迟最简单的方法……恰恰是**不降低实际延迟**。

While it might seem counterintuitive at first, but if we think about why latency matters — it often matters because people are concerned that if the agent takes too long to run, the user won’t like using it. This can often be solved by updating the UX of the agent. We see two main ways people do this.

初看或许有违直觉，但若深入思考延迟为何重要——其核心往往在于：人们担心智能体响应过慢，会导致用户流失或体验下降。而这一问题，常常可通过优化智能体的用户体验（UX）来解决。我们观察到主要有两种实践方式：

- **Stream back results.** Streaming is pretty common place for most LLM applications, but if you aren’t doing it, you definitely should. It conveys to the user that the LLM is working, and they are less likely to leave the page. In addition to streaming response tokens, you can also stream things beyond just the final response. For example, you could stream the steps of the plan the agent is taking, the retrieval results, or the thinking tokens. [Perplexity does a fantastic job at this](https://www.langchain.com/breakoutagents/perplexity?ref=blog.langchain.com) with their search interface. They’ve found that by making a UI change to show these intermediate steps, user satisfaction improved — despite the total completion time remaining unchanged.

- **流式返回结果（Streaming）**。流式响应在绝大多数 LLM 应用中已属标配；如果你尚未采用，强烈建议立即引入。它向用户明确传递出“模型正在处理中”的信号，从而显著降低用户跳出率。除流式输出最终响应的 token 外，你还可以流式返回更多中间信息——例如智能体执行计划的具体步骤、检索结果，甚至推理过程中的“思维 token（thinking tokens）”。[Perplexity 在其搜索界面中就实现了极佳的流式体验](https://www.langchain.com/breakoutagents/perplexity?ref=blog.langchain.com)，通过 UI 层面展示这些中间步骤，他们在总完成时间未变的前提下，成功提升了用户满意度。

- **Run agents in the background**. Have agents running in the background. For my email assistant, I don’t have visibility into how long the email agent takes. That’s because it is triggered by an event (an email) and I only get notified when it’s stuck. I hide **all** the latency from the user, and the agent just runs in the background.

- **后台运行智能体**。让智能体在后台持续运行。以我的邮件助手为例：我并不知晓邮件智能体的实际运行耗时——因为它由事件（如新邮件到达）触发，而我仅在任务卡住时才会收到通知。我将**全部**延迟对用户完全隐藏，智能体则默默在后台执行。

## Making fewer LLM calls

## 减少大语言模型（LLM）调用次数

Not everything needs to be an LLM call. If you can do things in a way other than making an LLM call - great! The agents we see being built are a combination of LLM calls and code. This hybrid approach of combining code with LLM calls is one of the guiding principles of LangGraph, and a core reason why [companies like Replit, Uber, LinkedIn and Klarna are adopting it](https://blog.langchain.com/is-langgraph-used-in-production/).

并非所有任务都需要调用大语言模型（LLM）。如果你能以不调用 LLM 的方式完成某件事——那再好不过！我们所见到的正在构建的智能体（agents），往往是 LLM 调用与代码逻辑的结合体。这种将代码与 LLM 调用融合的混合范式，正是 LangGraph 的核心设计原则之一；也正是这一特性，成为 Replit、Uber、LinkedIn 和 Klarna 等公司采用 LangGraph 的关键原因（[详见博客](https://blog.langchain.com/is-langgraph-used-in-production/)）。

A common path we see is “Single LLM call” → “ReAct Agent” → “Multi Agent” → “LangGraph”.

我们观察到一种常见演进路径：“单次 LLM 调用” → “ReAct 智能体” → “多智能体系统” → “LangGraph”。

People start with a single LLM call. They run into some short comings, and step up to an agent. This works okay, but then they try to give it more tools and realize that a single agent can only support so many tools. They then go to a “multi-agent” setup, using a supervisor or swarm architecture.

开发者通常从一次 LLM 调用起步；随后遇到能力瓶颈（如缺乏推理链、无法调用外部工具等），便升级为 ReAct 类智能体。这种方式尚可运行，但当他们尝试接入更多工具时，很快会发现：单个智能体所能承载的工具数量存在明显上限。于是，他们转向“多智能体”架构，例如引入协调者（supervisor）或蜂群（swarm）模式。

The issue with this is that these architectures use a LOT of LLM calls. They are not super efficient in how the different agents communicate. That is by design - they are general purpose architectures, so they are not optimized for your use case.

这类架构的主要问题是：它依赖**大量** LLM 调用；且不同智能体之间的通信机制并不高效。这其实是设计使然——它们是通用型架构，因此并未针对你的具体业务场景进行优化。

That is when we see people reach for [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com). LangGraph is low level, and allows you to specify exactly how these agents should communicate with each other (or when something is just an LLM call). Often times this leads to significantly less LLM calls, making the agent faster and cheaper (and often more reliable).

此时，开发者往往会转向 [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com)。LangGraph 是一个底层框架，让你能**精确控制**各智能体之间如何通信（甚至明确界定何时只需一次简单 LLM 调用）。这种细粒度控制常常大幅减少 LLM 调用次数，从而让智能体运行更快、成本更低，且往往更稳定可靠。

## Speeding up LLM calls

## 加速 LLM 调用

We generally see two ways developers have been speeding up LLM calls.

我们通常观察到开发者通过两种主要方式加速 LLM 调用：

**Faster models**. Some models are faster than others. Google offers Gemini Flash which is very fast. OpenAI and Anthropic also have smaller, faster models. Open source model hosting platforms like Groq and Fireworks are constantly trying to make the best open source models faster and faster. Note: this often comes with a tradeoff of using **worse** models, as these faster models are usually smaller and thus less accurate.

**更快的模型**：不同模型的推理速度差异显著。例如，Google 推出的 Gemini Flash 速度极快；OpenAI 和 Anthropic 也提供了体积更小、响应更快的模型变体；开源模型托管平台（如 Groq 和 Fireworks）则持续致力于将顶尖开源模型的推理速度推向极致。注意：这通常需付出一定代价——即使用**性能较弱**的模型，因为更快的模型往往参数量更少，因而准确性也相对较低。

**Less context.** The time an LLM takes to respond is proportional to the length of the input. In order to get faster results, you can pass less input! This is why you need to have **full control and visibility** over what **exactly** goes into each LLM call. Frameworks that obfuscate this (or don’t make it easy to control) are no good - that is why LangGraph comes with no hidden prompts — you have full control. If you are looking for a way to get better **visibility** into what is going into the LLM calls - check out LangSmith.

**更少的上下文**：LLM 的响应时间与其输入长度成正比。因此，要获得更快的结果，最直接的方式就是**减少输入内容**！这也正是你需要对每次 LLM 调用的**确切输入内容拥有完全控制权与清晰可见性**的原因。那些对此加以隐藏、或难以灵活调控的框架并不可取——这正是 LangGraph 不含任何“黑盒提示词”（no hidden prompts）的设计初衷：你始终掌握全部主动权。若你希望进一步提升对 LLM 调用输入内容的**可观测性**（visibility），欢迎了解 LangSmith。

## Making LLM calls in parallel

## 并行执行 LLM 调用

Not applicable to all use cases, but if it is for your use case you should be doing this. LangGraph [supports parallelism](https://langchain-ai.github.io/langgraph/how-tos/branching/?ref=blog.langchain.com) out of the box. Examples of where you can think about doing this:

并非适用于所有使用场景，但若恰好契合您的需求，则建议采用此方法。LangGraph 开箱即用地支持[并行处理](https://langchain-ai.github.io/langgraph/how-tos/branching/?ref=blog.langchain.com)。以下是一些可考虑应用并行化的典型场景：

- 并行执行护栏检查（guardrail check）与内容生成  
- 并行从多份文档中提取信息  
- 并行调用多个模型，再整合其输出结果  

## Conclusion

## 结论

Speeding up your AI agent is ultimately about making strategic tradeoffs between performance, cost, and capability. Start by first understanding your specific performance bottlenecks, then apply these techniques selectively based on your use case. And sometimes the most effective method isn't technical at all — but rather rethinking how users experience the interaction with your agent.

提升 AI 智能体的运行速度，本质上是在性能、成本与能力之间做出战略性权衡。首先应明确您所面临的具体性能瓶颈，再根据实际使用场景有选择地应用上述优化技术。而有时，最有效的提速方式甚至并非技术手段——而是重新思考用户与您的智能体交互时的整体体验。

As you try out new strategies, we'd love to hear from you — what techniques have worked best for speeding up your agent? Drop us a line on [X](https://x.com/LangChainAI?ref=blog.langchain.com) or [LinkedIn](https://www.linkedin.com/company/langchain/?ref=blog.langchain.com).

在您尝试新策略的过程中，我们非常期待听到您的反馈——哪些方法对加速您的智能体最为有效？欢迎通过 [X](https://x.com/LangChainAI?ref=blog.langchain.com) 或 [LinkedIn](https://www.linkedin.com/company/langchain/?ref=blog.langchain.com) 与我们联系。

### Tags

### 标签

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)

[Harrison 的犀利观点](https://blog.langchain.com/tag/in-the-loop/)

[![On Agent Frameworks and Agent Observability](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**关于智能体框架与智能体可观测性**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 4 分钟阅读

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[![从追踪记录到深度洞察：规模化理解智能体行为](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**从追踪记录到深度洞察：规模化理解智能体行为**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![In software, the code documents the app. In AI, the traces do.](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[![在软件工程中，代码即文档；在人工智能中，追踪记录即文档。](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**在软件工程中，代码即文档；在人工智能中，追踪记录即文档。**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 5 分钟阅读

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[![智能体框架、运行时与编排工具——天哪！](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**智能体框架、运行时与编排工具——天哪！**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 3 分钟阅读

[![Reflections on Three Years of Building LangChain](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[![构建 LangChain 三年来的思考](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[**构建 LangChain 三年来的思考**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：6 分钟

[![Not Another Workflow Builder](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[![又一个工作流构建器？不！](images/ai-agent-latency-101-how-do-i-speed-up-my-ai-agent/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[**又一个工作流构建器？不！**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[Harrison 的热点评论](https://blog.langchain.com/tag/in-the-loop/) 阅读时长：4 分钟
{% endraw %}
