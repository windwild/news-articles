---
title: "Introducing Polly: Your AI Agent Engineer"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-polly-your-ai-agent-engineer/"
date: "2025-12-11"
scraped_at: "2026-03-03T07:15:49.723060935+00:00"
language: "en-zh"
translated: true
---
{% raw %}

Today, we're launching **Polly:** an AI-powered assistant built directly into LangSmith that helps you debug, analyze, and improve your agents.

今天，我们正式推出 **Polly**：一款直接集成于 LangSmith 的 AI 助手，专为帮助您调试、分析和优化智能体（agents）而设计。

And yes, we see the irony: we're adding an agent to a product for building agents.

没错，我们自己也注意到了其中的反讽意味：我们在一款用于构建智能体的产品中，又加入了一个智能体。

We've spent a lot of time working with thousands of developers build production agents on LangSmith. We've seen what agents are genuinely good at (analyzing complex traces, spotting patterns across hundreds of steps) and what they're not (replacing thoughtful engineering decisions). We wanted to get this right.

我们已与数千名开发者长期合作，共同在 LangSmith 上构建生产级智能体。我们清楚地看到，智能体真正擅长什么（例如分析复杂的调用链路、识别跨越数百步的模式），以及它们并不擅长什么（例如替代深思熟虑的工程决策）。我们决心把这件事做对。

The result is Polly: an AI agent engineer that understands agent architectures, recognizes failure patterns, and actually helps you ship better agents faster. Polly is now available in beta.

最终成果便是 Polly：一位理解智能体架构、能识别典型失败模式，并切实助您更快交付更优智能体的 AI 智能体工程师。Polly 现已开放 Beta 版本试用。

## Why agents need an AI debugging partner

## 为何智能体需要一位 AI 调试伙伴

Through working with thousands of teams building agents on LangSmith, we've seen the same debugging challenges emerge repeatedly. Agents are fundamentally different from simple LLM calls due to:

通过与数千支在 LangSmith 上构建智能体的团队协作，我们反复观察到相似的调试难题。智能体与简单的 LLM 调用存在本质区别，原因在于：

- **Longer prompts:** System prompts often span hundreds or thousands of lines. When behavior degrades, finding which instruction is responsible is nearly impossible.

- **更长的提示词（prompts）：** 系统提示词常常长达数百甚至上千行。当行为出现退化时，几乎不可能准确定位是哪一条指令导致了问题。

- **Longer traces:** Agents can run for hundreds of steps, generating thousands of data points in a single trace - far more than a human can parse effectively.

- **更长的调用链路（traces）：** 智能体可运行数百步，在单次链路中生成数千个数据点——远超人类有效解析的能力范围。

- **Multiple turns:** Agents involve multi-turn conversations that span hours or days. Understanding what happened requires looking across the entire interaction history.

- **多轮交互：** 智能体涉及持续数小时乃至数天的多轮对话。要理解事件全貌，必须通览整个交互历史。

When something goes wrong, you can't easily pinpoint which decision, prompt instruction, or tool call caused it. This is the kind of problem where an AI agent engineer excels - and why we built Polly.

一旦出现问题，您很难快速定位究竟是哪个决策、哪条提示指令或哪次工具调用引发了故障。这正是 AI 智能体工程师最擅长解决的一类问题——也正是我们打造 Polly 的初衷。

## Polly helps with debugging traces, analyzing conversations, and engineering better prompts

## Polly 助力调试调用链路、分析对话交互、优化提示工程

Instead of manually scanning through endless traces or guessing which prompt change will fix an issue, you can simply ask Polly questions in natural language. It's like having an expert agent engineer on your team. Here's what Polly can do today:

您无需再手动翻阅无穷无尽的调用链路，也不必凭猜测尝试各种提示词修改来修复问题；只需用自然语言向 Polly 提问即可。它就像您团队中一位经验丰富的智能体工程师。以下是 Polly 当前已支持的功能：

### Debug Individual Traces

### 调试单条追踪记录

![](images/introducing-polly-your-ai-agent-engineer/img_001.png)

在“追踪视图”（Trace view）中，Polly 会对单次智能体执行过程进行分析，帮助您理解实际发生了什么。这正是 Polly 的核心优势所在——深度智能体的追踪记录可能包含数百个步骤，而故障模式往往十分隐蔽，分散在多个步骤中，或深埋于漫长执行流程的中间环节。

您可以向 Polly 提出如下问题：

- “智能体是否执行了某些可以更高效完成的操作？”  
- “智能体是否犯了任何错误？”  
- “智能体为何选择这种方案，而非另一种？”  
- “问题究竟具体出现在哪个环节？”

Polly 不仅能呈现相关信息，更能理解智能体的行为模式，并识别出即使经过细致人工检查也容易被忽略的问题。

### Analyze Entire Conversations

### 分析完整对话

![](images/introducing-polly-your-ai-agent-engineer/img_002.png)

在“会话视图”（Thread view）中，Polly 可访问跨越数小时、数天，甚至包含数十轮来回交互的完整对话信息。这类上下文规模之大，远超人类大脑所能持续维持的认知负荷。

您可以请 Polly 执行以下任务：

- Summarize what happened across multiple interactions  
- 总结多次交互中发生的情况  

- Identify patterns in agent behavior over time  
- 识别智能体行为随时间变化的规律  

- Explain why the agent's approach changed between turns  
- 解释智能体在不同轮次间调整策略的原因  

- Spot when the agent lost track of important context  
- 发现智能体何时遗漏了关键上下文  

This is especially powerful for debugging those frustrating issues where "the agent was working fine, and then suddenly it wasn't". Polly can pinpoint exactly where and why things changed.  
这一能力在调试那些令人困扰的问题时尤为强大——比如“智能体原本运行正常，却突然出错了”。Polly 能精准定位问题发生的具体位置及根本原因。

### Engineer Better Prompts  
### 设计更优提示词  

![](images/introducing-polly-your-ai-agent-engineer/img_003.png)  

This is where Polly gets really powerful. The system prompt is the most important part of any deep agent, and Polly is an expert prompt engineer.  
这正是 Polly 实力尽显之处。系统提示词（system prompt）是任何深度智能体中最关键的部分，而 Polly 正是一位经验丰富的提示词工程师。  

Just describe the behavior you want in natural language, and Polly will update your prompt accordingly. No more manually tweaking hundreds of lines of instructions, trying to figure out the right phrasing, or wondering if you've broken something else while fixing one issue.  
你只需用自然语言描述期望的行为，Polly 就会自动更新你的提示词。从此告别手动调整数百行指令、反复推敲措辞、或在修复一个问题时担心意外破坏其他功能的繁琐过程。  

Polly can also help you:  
Polly 还能协助你完成以下任务：  

- Define structured output schemas  
- 定义结构化输出模式  

- Configure tool definitions  
- 配置工具定义  

- Add or refine few-shot examples  
- 添加或优化少样本（few-shot）示例  

- Optimize prompt length without losing critical instructions  
- 在不丢失关键指令的前提下优化提示词长度  

## How Polly works with LangSmith tracing  
## Polly 如何与 LangSmith 追踪功能协同工作  

Polly's intelligence comes from LangSmith's comprehensive tracing infrastructure. LangSmith captures everything your agent does:  
Polly 的智能源于 LangSmith 全面的追踪基础设施。LangSmith 会完整记录你的智能体所执行的每一项操作：

- **Runs:** 单个执行步骤，例如大语言模型（LLM）调用和工具执行  
- **Traces:** 代理（agent）的一次完整执行过程，由一棵包含多个 runs 的树状结构组成  
- **Threads:** 一次完整的对话，包含多次 traces  

在 LangSmith 中配置追踪（tracing）仅需几分钟——[请参考此指南](https://www.youtube.com/watch?v=fA9b4D8IsPQ&ref=blog.langchain.com)快速上手。一旦您的数据开始流入 LangSmith，Polly 即可立即协助您分析代理行为、识别问题并优化提示词（prompts）。

## 开始使用 Polly

Polly 当前已支持分析 traces、调试对话以及提示词工程（prompt engineering）。未来，我们将持续为其赋能，使其具备分析实验（experiments）、优化提示词，以及更多高级能力。

**准备好开始使用 Polly 了吗？**

1. [只需几分钟即可完成追踪配置](https://www.youtube.com/watch?v=fA9b4D8IsPQ&ref=blog.langchain.com)  
2. 使用 LangSmith 开始构建并调试您的 agent  
3. 与 Polly 对话，亲身体验代理工程（agent engineering）的未来  

您可观看 [这段操作演示视频](https://youtu.be/4Ox2gdZnM6c?ref=blog.langchain.com)，了解更多关于如何开始使用 Polly 的详细信息。

LangChain 是一个广受信赖的代理工程平台，已被数千支团队用于构建和上线生产级 agent。如今，借助 Polly，您将拥有一位 AI 专家，在整个开发过程中为您提供全程支持。

[今天就试用 Polly](https://smith.langchain.com/?ref=blog.langchain.com)
{% endraw %}
