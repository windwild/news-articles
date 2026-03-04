---
title: "Plan-and-Execute Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/plan-and-execute-agents/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:02:17.286910647+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

**TL;DR: 我们正在推出一种新型的智能体执行器（agent executor），我们称之为“规划-执行”（Plan-and-Execute）型智能体。此举旨在与此前支持的“动作型”（Action）智能体形成对比。“规划-执行”型智能体的设计深受 [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com) 以及近期发表的 [Plan-and-Solve](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2305.xml?ref=blog.langchain.com) 论文启发。我们认为，“规划-执行”模式特别适合处理更复杂的长期规划任务，但代价是需调用语言模型更多次。由于我们预期该功能将快速迭代，因此初始版本已放入 `experimental` 模块中。**

**TL;DR：我们正在推出一种新型的智能体执行器（agent executor），我们称之为“规划-执行”（Plan-and-Execute）型智能体。此举旨在与此前支持的“动作型”（Action）智能体形成对比。“规划-执行”型智能体的设计深受 [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com) 以及近期发表的 [Plan-and-Solve](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2305.xml?ref=blog.langchain.com) 论文启发。我们认为，“规划-执行”模式特别适合处理更复杂的长期规划任务，但代价是需调用语言模型更多次。由于我们预期该功能将快速迭代，因此初始版本已放入 `experimental` 模块中。**

**Links:**

**链接：**

- **[Python 文档](https://python.langchain.com/docs/modules/agents/agent_types/plan_and_execute?ref=blog.langchain.com)**
- **[JS/TS 文档](https://js.langchain.com/docs/modules/agents/agents/examples/plan_and_execute_agent?ref=blog.langchain.com)**

Up until now, all agents in LangChain followed the framework pioneered by the ReAct paper. Let’s call these “Action Agents”. The algorithm for these can roughly be expressed in the following pseudo-code:

截至目前，LangChain 中所有智能体均遵循 ReAct 论文所开创的框架。我们将这类智能体统称为“动作型智能体”（Action Agents）。其算法逻辑大致可用如下伪代码表示：

- Some user input is received  
- The agent decides which tool - if any - to use, and what the input to that tool should be  
- That tool is then called with that tool input, and an observation is recorded (this is just the output of calling that tool with that tool input)  
- That history of tool, tool input, and observation is passed back into the agent, and it decides what step to take next  
- This is repeated until the agent decides it no longer needs to use a tool, and then it responds directly to the user.

- 接收用户输入；  
- 智能体决定是否调用某个工具，以及该工具所需的输入参数；  
- 调用选定工具并传入对应输入，同时记录一次“观察结果”（observation）——即该工具在给定输入下的实际输出；  
- 将“工具名称、工具输入、观察结果”这一历史记录反馈回智能体，由其决定下一步操作；  
- 上述过程不断循环，直至智能体判定无需再调用任何工具，随后直接向用户返回最终响应。

This style has worked well up until now, but several things are changing which present some cracks in this algorithm:

这种范式至今运行良好，但当前正发生若干变化，暴露出该算法的一些局限性：

- User objectives are becoming more complex  
- Developers and organizations are starting to rely on agents in production  

- 用户目标日趋复杂；  
- 开发者及组织机构正逐步将智能体投入生产环境使用。

These have the dual effects of wanting agentic systems to be able to handle more complex requests yet also be more reliable. These two factors are combining to rapidly cause prompt sizes to increase:

这两大趋势共同带来双重需求：一方面要求智能体系统能应对更复杂的请求，另一方面也要求其具备更高可靠性。而这两种需求正合力推动提示词（prompt）规模迅速膨胀：

- As objectives are more complex, more and more past history is being included to keep the agent focused on the final objective while also allowing it to remember and reason about previous steps  
- As developers try to increase reliability they are including more instructions around how to use tools  

- 随着目标日益复杂，为使智能体始终聚焦于最终目标，并能记忆和推理先前步骤，越来越多的历史交互信息被纳入提示词中；  
- 为提升可靠性，开发者也在提示词中加入更多关于如何正确使用工具的详细指令。

The need for increasingly complex abilities and increased reliability are causing issues when working with most language models.

对更复杂能力与更高可靠性的双重诉求，正给大多数语言模型的实际应用带来挑战。

## Plan-and-Execute Implementation

## 计划与执行（Plan-and-Execute）实现

In that vein we’ve seen a new style of agent frameworks pop up. These agent frameworks attempt to separate higher level planning from shorter term execution. Specifically, they first plan steps to take, and then iteratively execute on those steps. There are of course a few interesting variants on this core algorithm (which we can talk about later). The pseudo-code for these agents, which we’re calling “Plan-and-Execute” agents, looks like:

顺着这一思路，我们已看到一类新型智能体框架（agent frameworks）涌现出来。这类框架试图将高层级的规划（planning）与短期的执行（execution）分离开来。具体而言，它们首先规划需采取的步骤，再对这些步骤进行迭代式执行。当然，该核心算法还存在若干有趣的变体（我们稍后可以展开讨论）。我们将这类智能体称为“计划与执行（Plan-and-Execute）”智能体，其伪代码如下：

- Plan steps to take  
- For step in steps: determine the proper tools or other best course of action to accomplish that step

- 规划需采取的步骤  
- 对于步骤列表中的每个步骤：确定完成该步骤所需的合适工具，或其他最优行动方案  

This is the core agent framework which is implemented in Python and TypeScript. This agent framework relies on two things: a planner and an executor.

这是已在 Python 和 TypeScript 中实现的核心智能体框架。该框架依赖两大组件：一个规划器（planner）和一个执行器（executor）。

Let’s talk about the planner first. This almost always should be a language model. This will utilize the language model’s reasoning ability to plan out what to do and deal with ambiguity/edge cases. We can add on an output parser at the end to parse the raw LLM output into a list of strings (each string being a step).

我们先来谈谈规划器。它几乎总是由一个大语言模型（LLM）担任。规划器将利用语言模型的推理能力，统筹规划应采取的行动，并应对模糊性与边界情况。我们可在最后添加一个输出解析器（output parser），将原始大语言模型输出解析为字符串列表（每个字符串代表一个步骤）。

Now let’s talk about the executor. In our initial implementation we’ve made this an Action Agent. This allows for the executor agent to take in a high level objective (a single step) and figure out which tools to use to accomplish that (could be done in one step or two).

现在我们来谈谈执行器。在初始实现中，我们将执行器设计为一个“动作智能体（Action Agent）”。这使得执行器智能体能够接收一个高层级目标（即单个步骤），并自主判断应调用哪些工具来完成该目标（可能一步完成，也可能需两步）。

This approach has several benefits. It separates out planning from execution - this allows one LLM to focus exclusively on planning, and another to focus on execution. This allows for more reliability on both fronts. This also makes it easier in the future to swap out these components for smaller fine tuned models. The major downside of this approach is that it takes a lot more calls. However, due to the separation of concerns we’re hopeful that these calls can be to smaller (and therefore faster and cheaper) models.

该方法具备多项优势：它将规划与执行解耦——使一个大语言模型可专注于规划任务，另一个则专注于执行任务，从而提升两方面的可靠性；同时，这种模块化设计也便于未来用更小的微调模型（fine-tuned models）替换其中任一组件。该方法的主要缺点在于所需调用次数显著增多。然而，得益于关注点分离（separation of concerns）的设计原则，我们有理由相信，这些调用可面向更小（因而更快、更经济）的模型发起。

## Future Directions

## 未来发展方向

We think this is just the start of plan-and-execute agents. Future directions include:

我们认为，计划与执行型智能体才刚刚起步。未来的发展方向包括：

- Better support for long sequences of steps. Right now the previous steps are passed around as a list - as planning steps getting longer and longer, we’ll want to store this in a vectorstore and retrieve intermediate steps  
- 对长步骤序列提供更优支持。当前，历史步骤以列表形式在各环节间传递；随着规划步骤不断增长，我们希望将其存入向量数据库（vectorstore），并按需检索中间步骤  

- Revisiting plans. Right now there is one planning step at the start, but then that is never revisited. It is likely we will want to have some mechanism for revisiting and adjusting the plan, either every step or as needed.  
- 动态调整规划。目前仅在起始阶段进行一次规划，此后便不再更新。我们很可能需要引入一种机制，支持在每一步或按需重新审视并动态调整规划方案。  

- Evaluation. Right now, a lot of these improvements are largely theoretical, or at the very least not benchmarked. We hope to have more rigorous ways of evaluating agent frameworks.  
- 评估体系构建。目前，许多改进尚停留在理论层面，至少尚未经过系统性基准测试（benchmarking）。我们期望建立更为严谨的智能体框架评估方法。  

- Selection of execution chain. Right now, there is a single execution chain. It could easily be the case that you would want multiple execution chains, and the planner can specify which one to use. For example, if you have one execution chain optimized for web research, one for analysis, etc.  
- 执行链（execution chain）的灵活选择。当前仅支持单一执行链；而实际场景中，用户很可能需要多种执行链，由规划器指定选用哪一条。例如，可分别配置专用于网络搜索的执行链、专用于数据分析的执行链等。

It should be noted that for many of these future directions we can draw inspiration from existing work. For example, BabyAGI already uses a vectorstore to store intermediate steps and also revisits planning each iteration. The Plan-and-Solve paper does more rigorous evaluation of outputs with benchmarks.

需要指出的是，对于上述许多未来方向，我们可以从现有工作中汲取灵感。例如，BabyAGI 已经使用向量数据库（vectorstore）来存储中间步骤，并在每次迭代中重新审视规划过程。而《Plan-and-Solve》论文则通过基准测试对输出结果进行了更为严格的评估。

## Conclusion

## 结论

We were really excited to see this new agent paradigm pop up in BabyAGI (we highlighted this as one of the big differentiators in our post a few weeks ago). We were equally excited to see the Plan-and-Solve paper emerge as a rigorous evaluation of similar ideas. We look forward to seeing how the Plan-and-Execute approach evolves - try it out [here (Python)](https://python.langchain.com/docs/modules/agents/agent_types/plan_and_execute?ref=blog.langchain.com) or [here (JS)](https://js.langchain.com/docs/modules/agents/agents/examples/plan_and_execute_agent?ref=blog.langchain.com).

我们非常兴奋地看到这一新型智能体范式在 BabyAGI 中崭露头角（几周前我们在博客文章中已将其列为关键差异化特性之一）。同样令我们振奋的是，《Plan-and-Solve》论文的出现，为类似理念提供了严谨的评估框架。我们热切期待“规划与执行”（Plan-and-Execute）方法的持续演进——欢迎立即体验：[Python 版本](https://python.langchain.com/docs/modules/agents/agent_types/plan_and_execute?ref=blog.langchain.com) 或 [JavaScript 版本](https://js.langchain.com/docs/modules/agents/agents/examples/plan_and_execute_agent?ref=blog.langchain.com)。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/plan-and-execute-agents/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/plan-and-execute-agents/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/plan-and-execute-agents/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/plan-and-execute-agents/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/plan-and-execute-agents/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/plan-and-execute-agents/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/plan-and-execute-agents/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/plan-and-execute-agents/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/plan-and-execute-agents/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/plan-and-execute-agents/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/plan-and-execute-agents/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入公测阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
{% endraw %}
