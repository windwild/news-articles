---
render_with_liquid: false
title: "Custom Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/custom-agents/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:58:53.158479337+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

One of the most common requests we've heard is better functionality and documentation for creating custom agents.  
我们听到的最常见需求之一，是增强创建自定义 Agent 的功能与文档支持。

This has always been a bit tricky - because in our mind it's actually still very unclear what an "agent" actually is, and therefor what the "right" abstractions for them may be.  
这一直以来都略显棘手——因为在我们的认知中，“Agent” 的确切定义本身仍相当模糊，因此也难以确定其“恰当”的抽象方式。

Recently, we've felt some of the abstractions starting to come together, so we did a big push across both our [Python](https://github.com/hwchase17/langchain?ref=blog.langchain.com) and [TypeScript](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) modules to better enforce and document these abstractions.  
近期，我们逐渐感受到这些抽象正趋于成熟，因此在我们的 [Python](https://github.com/hwchase17/langchain?ref=blog.langchain.com) 和 [TypeScript](https://github.com/hwchase17/langchainjs?ref=blog.langchain.com) 模块中开展了大规模重构，以更严格地落实并完善这些抽象的文档说明。

Please see below for links to those technical docs, and then a description of the abstractions we've introduced and future directions.  
请参阅下方的技术文档链接，随后我们将介绍已引入的抽象设计及其未来演进方向。

- [Python Custom Agent Docs](https://python.langchain.com/docs/modules/agents/how_to/custom_llm_agent?ref=blog.langchain.com)  
- [Python 自定义 Agent 文档](https://python.langchain.com/docs/modules/agents/how_to/custom_llm_agent?ref=blog.langchain.com)

- [TypeScript Custom Agent Docs](https://js.langchain.com/docs/modules/agents/agents/custom_llm?ref=blog.langchain.com)  
- [TypeScript 自定义 Agent 文档](https://js.langchain.com/docs/modules/agents/agents/custom_llm?ref=blog.langchain.com)

**TL;DR:** we've introduced a `BaseSingleActionAgent` as the highest level abstraction for an agent that can be used in our current `AgentExecutor`. We've added a more practical `LLMSingleActionAgent` that implements this interface in a simple and extensible way (PromptTemplate + LLM + OutputParser).  
**一句话概括（TL;DR）：** 我们引入了 `BaseSingleActionAgent`，作为当前 `AgentExecutor` 所支持 Agent 的最高层级抽象；同时新增了一个更实用的 `LLMSingleActionAgent` 实现类，以简洁且可扩展的方式实现了该接口（即：PromptTemplate + LLM + OutputParser）。

## BaseSingleActionAgent

## BaseSingleActionAgent（单动作 Agent 基类）

The most base abstraction we've introduced is a `BaseSingleActionAgent`. As you can tell by the name, we don't consider this a base abstraction for all agents. Rather, we consider this the base abstraction for a family of agents that predicts a single action at a time.  
我们引入的最底层抽象是 `BaseSingleActionAgent`。顾名思义，我们并不将其视为所有类型 Agent 的通用基类；相反，我们认为它是专为“每次仅预测一个动作”的 Agent 家族所设计的基础抽象。

A `SingleActionAgent` is used in an our current `AgentExecutor`. This `AgentExecutor` can largely be thought of as a loop that:  
`SingleActionAgent` 用于我们当前的 `AgentExecutor` 中。该 `AgentExecutor` 在本质上可被理解为一个循环，其执行流程如下：

1. Passes user input and any previous steps to the Agent  
1. 将用户输入及此前所有步骤传递给 Agent；

2. If the Agent returns an `AgentFinish`, then return that directly to the user  
2. 若 Agent 返回 `AgentFinish`，则直接将结果返回给用户；

3. If the Agent returns an `AgentAction`, then use that to call a tool and get an `Observation`  
3. 若 Agent 返回 `AgentAction`，则据此调用对应工具，并获取一个 `Observation`（观测结果）；

4. Repeat, passing the `AgentAction` and `Observation` back to the Agent until an `AgentFinish` is emitted.  
4. 重复上述过程，持续将 `AgentAction` 与 `Observation` 传回 Agent，直至最终输出 `AgentFinish`。

`AgentAction` is a response that consists of `action` and `action_input`. `action` refers to which tool to use, and `action_input` refers to the input to that tool.  
`AgentAction` 是一种响应对象，包含 `action`（指定需调用的工具）和 `action_input`（该工具所需的输入参数）两个字段。

`AgentFinish` is a response that contains the final message to be sent back to the user. This should be used to end an agent run.  
`AgentFinish` 是一种响应对象，其中封装了需返回给用户的最终消息，应被用于终止一次 Agent 运行。

If you are interested in this level of customizability, check out [this walkthrough](https://python.langchain.com/docs/modules/agents/how_to/custom_agent?ref=blog.langchain.com). For most use cases, however, we would recommend using the abstraction below.  
若您希望实现这一层级的自定义能力，请参考 [本篇操作指南](https://python.langchain.com/docs/modules/agents/how_to/custom_agent?ref=blog.langchain.com)。不过，对于绝大多数使用场景，我们建议您采用下文所述的更高层抽象。

## LLMSingleActionAgent

## LLMSingleActionAgent（单动作语言模型智能体）

Another class we've introduced is the `LLMSingleActionAgent`. This is a concrete implementation of the `BaseSingleActionAgent`, but is highly modular so therefor is highly customizable.

我们新引入的另一个类是 `LLMSingleActionAgent`。它是 `BaseSingleActionAgent` 的一个具体实现，但具有高度模块化特性，因此也极具可定制性。

The `LLMSingleActionAgent` consists of four parts:

`LLMSingleActionAgent` 由以下四个部分组成：

- `PromptTemplate`: This is the prompt template that can be used to instruct the language model on what to do  
- `PromptTemplate`：用于向语言模型明确指示其应执行任务的提示模板  

- `LLM`: This is the language model that powers the agent  
- `LLM`：为该智能体提供核心能力的语言模型  

- `stop` sequence: Instructs the `LLM` to stop generating as soon as this string is found  
- `stop` 序列：指示 `LLM` 一旦生成中出现该字符串，即刻停止输出  

- `OutputParser`: This determines how to parse the output of an `LLM` into an `AgentAction` or `AgentFinish` object  
- `OutputParser`：决定如何将 `LLM` 的输出解析为 `AgentAction` 或 `AgentFinish` 对象  

The logic for combining these is:

这些组件协同工作的逻辑如下：

- Use the `PromptTemplate` to turn the input variables (inlcuding user input and any previous `AgentAction`, `Observation` pairs) into a prompt  
- 利用 `PromptTemplate` 将输入变量（包括用户输入以及此前所有的 `AgentAction`/`Observation` 配对）转换为提示词（prompt）  

- Pass the prompt to the `LLM`, with a specific `stop` sequence  
- 将该提示词传入 `LLM`，并指定特定的 `stop` 序列  

- Parse the output of the `LLM` into an `AgentAction` or `AgentFinish` object  
- 将 `LLM` 的输出解析为 `AgentAction` 或 `AgentFinish` 对象  

These abstraction can be used to customize your agent in a lot of ways. For example:

这些抽象机制可在诸多方面助力您定制专属智能体。例如：

- Want to give your agent some personality? Use the `PromptTemplate`!  
- 想赋予您的智能体独特个性？请使用 `PromptTemplate`！  

- Want to format the previous `AgentAction`, `Observation` pairs in a specific way? Use the `PromptTemplate`!  
- 想以特定方式格式化此前的 `AgentAction`/`Observation` 配对？请使用 `PromptTemplate`！  

- Want to use a custom or local model? Write a custom LLM wrapper and pass that in as the LLM!  
- 想使用自定义模型或本地部署模型？编写一个自定义的 LLM 封装器，并将其作为 `LLM` 参数传入！  

- **Is the output parsing too brittle, or you want to handle errors in a different way? Use a custom OutputParser!**  
- **输出解析是否过于脆弱？或者您希望以不同方式处理错误？请使用自定义的 `OutputParser`！**  

(The last one is in bold, because that's the one we'v maybe heard the most)  

（最后一项加粗显示，因为这可能是我们迄今为止听到最多的需求）

We imagine this being the most practically useful abstraction. Please see the documentation links at the beginning of the blog for links to concrete Python/TypeScripts guides for getting started here.

我们相信，这是目前最具实用价值的抽象设计。有关入门指南的具体 Python / TypeScript 教程链接，请参阅本文开头所附的文档链接。

## Future Directions

## 未来发展方向

We hope these abstractions have clarified some of our thinking around agents, as well as open up places where we hope the community can contribute. In particular:

我们希望这些抽象概念能帮助厘清我们对智能体（agents）的一些思考，同时也为社区贡献开辟新的空间。具体而言：

We are very excited about other examples of `SingleActionAgents`, like:

我们对 `SingleActionAgents` 的其他实现方式感到非常兴奋，例如：

- Using embeddings to do tool selection before calling an `LLM`  
- 在调用 `LLM` 之前，利用嵌入（embeddings）进行工具选择  
- Using a `ConstitutionalChain` instead of an `LLMChain` to improve reliability  
- 使用 `ConstitutionalChain` 替代 `LLMChain`，以提升可靠性  

We are also excited about other types of agents (which will require new `AgentExecutors`), like:

我们也非常期待其他类型的智能体（需配套开发新的 `AgentExecutors`），例如：

- Multi-action agents  
- 多动作智能体（Multi-action agents）  
- Plan-execute agents  
- 规划-执行智能体（Plan-execute agents）  

If any of those sound interesting, we are always willing to work with folks to implement their ideas! The best way is probably to do some initial work, open a RFC pull request, and we're happy to go from there :)

如果上述任一方向令您感兴趣，我们始终乐于与各位合作，共同实现您的构想！最理想的方式是：先开展一些初步工作，然后提交一份 RFC（征求意见稿）Pull Request，之后我们很乐意在此基础上继续深入协作！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/custom-agents/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/custom-agents/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 3 分钟

[![LangChain State of AI 2024 Report](images/custom-agents/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/custom-agents/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/custom-agents/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/custom-agents/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/custom-agents/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/custom-agents/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/custom-agents/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项](images/custom-agents/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟