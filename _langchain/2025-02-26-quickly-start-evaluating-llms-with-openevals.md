---
render_with_liquid: false
title: "Quickly Start Evaluating LLMs With OpenEvals"
source: "LangChain Blog"
url: "https://blog.langchain.com/evaluating-llms-with-openevals/"
date: "2025-02-26"
scraped_at: "2026-03-03T07:39:06.774023059+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Evaluations (evals) are important for bringing reliable LLM powered applications or agents to production, but it can be hard to know where to start when building evaluations from scratch. Our new packages— [openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) and [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com)—provide a set of evaluators and a common framework that you can easily get started with.

评估（evals）对于将可靠的、由大语言模型（LLM）驱动的应用或智能体投入生产至关重要；但若从零开始构建评估体系，往往难以确定该从何处入手。我们全新推出的两个开源包——[openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) 和 [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com)——提供了一组开箱即用的评估器（evaluators）及统一框架，助您快速上手。

## What are evals?

## 什么是评估（evals）？

Evals provide systematic ways to judge LLM output quality based on criteria that's important for your application. There are two components of evals: the **data that you’re evaluating over** and the **metric that you’re evaluating on**.

评估（evals）提供了一套系统化方法，依据对您的应用至关重要的标准来评判大语言模型（LLM）输出的质量。评估包含两个核心组成部分：**待评估的数据**（the data that you’re evaluating over）和**评估所采用的指标**（the metric that you’re evaluating on）。

The quality and diversity of the data you’re evaluating over directly influences how well the evaluation reflects real-world usage. Before you create an evaluation, spend some time curating a dataset for your specific use case— you only need a handful of high quality data points to get started. Read more about dataset curation [here](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#dataset-curation).

您所评估的数据质量与多样性，将直接影响评估结果在多大程度上反映真实世界中的使用场景。在构建评估之前，请花些时间为您特定的应用场景精心构建一个数据集——仅需少量高质量样本即可启动评估工作。关于数据集构建的更多细节，请参阅[此处](https://docs.smith.langchain.com/evaluation/concepts?ref=blog.langchain.com#dataset-curation)。

The metrics you're evaluating are also often custom depending on the goals of your application, however, we see common trends in the kinds of evaluations that are used. This is why we built [openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) and [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com) — to share prebuilt solutions that show common evaluation trends and best practices to help you get started.

您所选用的评估指标也往往需根据应用目标进行定制；不过，我们在实践中观察到若干高频共性评估模式。正因如此，我们开发了 [openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) 和 [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com) ——旨在共享一系列预构建解决方案，呈现业界常见评估趋势与最佳实践，助您高效起步。

## Common Evaluation Types and Best Practices

## 常见评估类型与最佳实践

There are many types of evaluations, but to start, we’ve focused on releasing eval techniques that we’ve seen are the most commonly used and practically useful. We’re approaching this in two ways:

评估类型多种多样；但为便于入门，我们优先发布那些在实践中最常用、最具实用价值的评估技术。我们的策略分为两个方向：

1. **Making broadly applicable evaluators easy to customize:** LLM-as-a-judge evals are the most broadly applicable evaluators. `openevals` makes it easy to take pre-built examples and customize them specific to your use case.

1. **让通用型评估器易于定制：** “LLM-as-a-judge”（以大语言模型为裁判）类评估器适用范围最广。`openevals` 提供大量预构建示例，您可轻松将其适配至自身具体应用场景。

2. **Making evaluators for specific use cases**: There are an endless number of use cases, but we’ll be building off-the-shelf evaluation for the most common ones. To start, `openevals` and `angentevals` cover cases in an application where you’re extracting structured content from documents, managing tool calls and agent trajectories. We plan to expand the libraries to include more specific techniques depending on application type (eg. evals specific to RAG applications or multi-agent architectures).

2. **面向特定应用场景构建专用评估器：** 应用场景不胜枚举，但我们优先为其中最常见者打造即用型评估方案。目前，`openevals` 和 `agentevals`（注：原文中误写为 `angentevals`，已按正确名称 `agentevals` 修正）已覆盖以下典型场景：从文档中抽取结构化内容、管理工具调用（tool calls）以及追踪智能体行为路径（agent trajectories）。未来，我们将持续扩展这两个库，针对不同应用类型（例如 RAG 应用、多智能体架构等）加入更精细化的专用评估技术。

**LLM-as-a-judge evals**

**“LLM-as-a-judge”（以大语言模型为裁判）类评估**

LLM-as-judge evaluators use LLMs to score your application's output. These are the most common types of evaluators we see since they’re primarily used when evaluating natural language outputs.

“LLM-as-judge”评估器利用大语言模型为您的应用输出打分。这是目前最主流的评估方式，因其特别适用于自然语言输出的评估任务。

**Use When Evaluating:**

**适用场景（评估时使用）：**

- Conversational quality of chatbot responses  
  - 聊天机器人回复的对话质量  

- To test for hallucination in summarization or question-answering systems  
  - 检测摘要生成或问答系统中的幻觉（hallucination）现象  

- Writing quality and coherence  
  - 文本写作质量与逻辑连贯性  

Importantly, LLM-as-judge evaluations can be reference free, allowing you to judge responses objectively without requiring ground truth answers.

重要的是，LLM-as-judge（大语言模型作为评判者）评估可采用无参考（reference-free）方式，使您能在无需真实标准答案（ground truth）的前提下，客观地评判模型输出。

**How `openevals` Helps:**

**`openevals` 如何助力评估：**

- Pre-built starter prompts that you can easily customize  
  - 提供预置的起始提示词（starter prompts），支持便捷自定义  

- Incorporate few-shot examples to better align with human preferences  
  - 支持引入少样本（few-shot）示例，使评估结果更贴合人类偏好  

- Simplifies the process of setting up a scoring schema for consistent evaluation  
  - 简化评分体系（scoring schema）的搭建流程，保障评估结果的一致性  

- Generates reasoning comments for why a particular score was given, adding transparency to the evaluation process  
  - 自动生成评分依据说明（reasoning comments），阐明某一分值的判定理由，提升评估过程的透明度  

View examples and get started with LLM-as-a-judge evaluators [here](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#llm-as-judge).

点击此处查看示例并开始使用 LLM-as-judge 评估器：[链接](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#llm-as-judge)

**Structured Data Evals**

**结构化数据评估（Structured Data Evals）**

Many LLM applications involve extracting structured output from documents or generating structured output for tool calling. For these cases, it’s important that the model’s output conforms to a predefined format.

许多大语言模型（LLM）应用涉及从文档中抽取结构化输出，或为工具调用（tool calling）生成结构化输出。在这些场景中，确保模型输出严格符合预定义格式至关重要。

**Use When Evaluating:**

**适用场景（评估时使用）：**

- Structured information extracted from PDFs, images or other documents  
  - 从 PDF、图像或其他文档中抽取的结构化信息  

- Consistently formatted JSON or other structured outputs  
  - 格式统一的 JSON 或其他结构化输出  

- Validating parameters for tool calls (eg. API calls)  
  - 验证工具调用（例如 API 调用）所需的参数  

- Ensuring outputs match specific formats or fall within a category  
  - 确保输出符合特定格式要求，或归属于指定类别

**How `openevals` Helps:**

**`openevals` 如何提供帮助：**

- `openevals` 提供了配置精确匹配（exact match）的能力，或使用 LLM-as-a-judge 方法来验证结构化输出。  
- 可选地，跨反馈键（feedback keys）聚合评分，以获得评估器性能的宏观视图。

View examples and get started with structured data evaluators [here](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#extraction-and-tool-calls).

请在此处查看示例并开始使用结构化数据评估器：[点击访问](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#extraction-and-tool-calls)。

**Agent evaluations: Trajectory evaluations**

**智能体评估：轨迹评估（Trajectory Evaluations）**

When building an agent, you’re often interested in more than just the final output—you want to understand how the agent reached that result. Trajectory evaluation assesses the sequence of actions an agent takes to complete a task.

构建智能体时，您通常不仅关注最终输出，更希望理解智能体是如何得出该结果的。轨迹评估即用于评估智能体为完成某项任务所采取的一系列动作。

**Use When Evaluating:**

**适用场景（评估时使用）：**

- 工具（Tools）或工具序列（sequence of tools）的选择  
- [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com) 应用的执行轨迹（trajectory）

**How `agentevals` Helps:**

**`agentevals` 如何提供帮助：**

- [Agent Trajectory](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#agent-trajectory) 功能允许您检查智能体是否调用了正确的工具（可选地要求严格顺序），或使用 LLM-as-a-judge 方法对整个轨迹进行评估。  
- 若您正在使用 [LangGraph](https://langchain-ai.github.io/langgraph/?ref=blog.langchain.com)，则可借助 [Graph Trajectory](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#graph-trajectory) 功能，确保智能体调用了正确的节点（nodes）。

View examples and get started with agent evaluations [here](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com).

请在此处查看示例并开始使用智能体评估：[点击访问](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com)。

### Track results over time with LangSmith

### 使用 LangSmith 长期追踪评估结果

For tracking evaluations over time and sharing them with a team, we recommend logging results to [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com). Companies like [Elastic](https://www.elastic.co/blog/elastic-security-generative-ai-features?ref=blog.langchain.com), [Klarna](https://blog.langchain.com/customers-klarna/), and [Podium](https://blog.langchain.com/customers-podium/) use LangSmith to evaluate their GenAI applications.

如需长期追踪评估结果并将其与团队共享，我们推荐将结果记录至 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)。[Elastic](https://www.elastic.co/blog/elastic-security-generative-ai-features?ref=blog.langchain.com)、[Klarna](https://blog.langchain.com/customers-klarna/) 和 [Podium](https://blog.langchain.com/customers-podium/) 等公司均使用 LangSmith 来评估其生成式 AI（GenAI）应用。

LangSmith includes tracing, evaluation, and experimentation tools to help you build production-grade LLM applications. Visit our guides on how to integrate [openevals](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#langsmith-integration) or [agentevals](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#langsmith-integration) with LangSmith.

LangSmith 提供了追踪（tracing）、评估（evaluation）和实验（experimentation）等全套工具，助力您构建面向生产环境的大型语言模型（LLM）应用。请参阅我们的集成指南，了解如何将 [openevals](https://github.com/langchain-ai/openevals?tab=readme-ov-file&ref=blog.langchain.com#langsmith-integration) 或 [agentevals](https://github.com/langchain-ai/agentevals?tab=readme-ov-file&ref=blog.langchain.com#langsmith-integration) 与 LangSmith 相集成。

### More coming soon!

### 更多内容即将上线！

This is just the beginning of our ongoing effort to codify best practices for evaluating different types of applications. In the coming weeks, we’ll be adding more specific evaluators for common use cases, and more evaluators for testing agents.

这仅是我们持续努力将各类应用评估最佳实践系统化、标准化的起点。在接下来的几周内，我们将陆续推出面向常见应用场景的更精细化评估器，以及更多专用于智能体（agent）测试的评估器。

Have ideas for evaluators you'd like to see? Open an issue on our GitHub repositories ( [openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) and [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com)). If you've developed evaluators that have worked well for your applications, we welcome pull requests to share them with the community.

您对评估器有新的构想或需求？欢迎在我们的 GitHub 仓库中提交 Issue：[openevals](https://github.com/langchain-ai/openevals?ref=blog.langchain.com) 和 [agentevals](https://github.com/langchain-ai/agentevals?ref=blog.langchain.com)。若您已开发出在实际应用中表现优异的评估器，我们也非常欢迎您通过 Pull Request 将其贡献给社区。