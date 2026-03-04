---
title: "Few-shot prompting to improve tool-calling performance"
source: "LangChain Blog"
url: "https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/"
date: "2024-07-30"
scraped_at: "2026-03-03T07:57:43.907779195+00:00"
language: "en-zh"
translated: true
description: "We ran a few experiments, which show how few-shot prompting can significantly enhance model accuracy - especially for complex tasks. Read on for how we did it (and the results)."
tags: ["By LangChain"]
---
{% raw %}

Tools are an essential component of LLM applications, and we’ve been working hard to improve the LangChain interfaces for using tools (see our posts on [standardized tool calls](https://blog.langchain.com/tool-calling-with-langchain/) and [core tool improvements](https://blog.langchain.com/improving-core-tool-interfaces-and-docs-in-langchain/)).

工具是大语言模型（LLM）应用中不可或缺的组成部分，我们一直在努力优化 LangChain 中的工具调用接口（参见我们关于 [标准化工具调用](https://blog.langchain.com/tool-calling-with-langchain/) 和 [核心工具接口与文档改进](https://blog.langchain.com/improving-core-tool-interfaces-and-docs-in-langchain/) 的博客文章）。

We’ve also been exploring how to **improve LLM tool-calling performance**. One common technique to improve LLM tool-calling is **few-shot prompting**, which involves putting example model inputs and desired outputs into the model prompt. [Research has shown](https://arxiv.org/abs/2005.14165?ref=blog.langchain.com) that few-shot prompting can greatly boost model performance on a wide range of tasks.

我们也在积极探索如何 **提升 LLM 的工具调用性能**。一种常用方法是 **少样本提示（few-shot prompting）**，即在模型提示词（prompt）中嵌入若干输入—输出示例。[相关研究显示](https://arxiv.org/abs/2005.14165?ref=blog.langchain.com)，少样本提示可在大量任务上显著提升模型表现。

There are many ways to construct few-shot prompts and very few best practices. **We ran a few experiments** to see how different techniques affect performance across models and tasks, and we’d love to share our results.

少样本提示的构建方式多种多样，但目前尚缺乏成熟、普适的最佳实践。**我们开展了一系列实验**，旨在评估不同技术方案在各类模型与任务上的效果差异，并非常乐意与您分享实验结果。

# Experiments

# 实验

We ran experiments on two datasets. The first, [Query Analysis](https://smith.langchain.com/public/6f62ae8b-4d96-4f0f-8eef-177ae3e30a65/d?ref=blog.langchain.com), is a pretty standard set up where a single call to an LLM is used to invoke different search indexes based on a user question. The second, [Multiverse Math](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com), tests function calling in the context of more an agentic [ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) workflow (this involves multiple calls to an LLM). We benchmark across multiple OpenAI and Anthropic models. We experiment with different ways of providing the few shot examples to the model, with the goal of seeing which methods yield the best results.

我们在两个数据集上开展了实验。第一个是 [Query Analysis（查询分析）](https://smith.langchain.com/public/6f62ae8b-4d96-4f0f-8eef-177ae3e30a65/d?ref=blog.langchain.com)，这是一个较为标准的设定：仅需一次 LLM 调用，即可根据用户问题选择并调用不同的搜索索引。第二个是 [Multiverse Math（多元宇宙数学）](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com)，它在更具“智能体”（agentic）特性的 [ReAct](https://arxiv.org/abs/2210.03629?ref=blog.langchain.com) 工作流（涉及多次 LLM 调用）中测试函数调用能力。我们对多个 OpenAI 与 Anthropic 模型进行了基准测试，并尝试了多种向模型提供少样本示例的方式，以探究哪种方法能取得最优效果。

## [**Query analysis**](https://smith.langchain.com/public/6f62ae8b-4d96-4f0f-8eef-177ae3e30a65/d?ref=blog.langchain.com)

## [**查询分析**](https://smith.langchain.com/public/6f62ae8b-4d96-4f0f-8eef-177ae3e30a65/d?ref=blog.langchain.com)

The second dataset requires the model to choose which search indexes to invoke. To query the correct data source with the right arguments, some domain knowledge and a nuanced understanding of what types of content are in each datasource is required. The questions are intentionally complex to challenge the model in selecting the appropriate tool.

该数据集要求模型判断应调用哪些搜索索引。为使用恰当参数查询正确的数据源，模型需具备一定的领域知识，并能细致理解各数据源所涵盖的内容类型。这些问题经过刻意设计，具有较高复杂度，旨在考验模型选择合适工具的能力。

**Example datapoint**

**示例数据点**

```
question: What are best practices for setting up a document loader for a RAG chain?
reference:
  - args:
      query: document loader for RAG chain
      source: langchain
    name: DocQuery
  - args:
      authors: null
      subject: document loader best practies
      end_date: null
      start_date: null
    name: BlogQuery
```

```
question: 为 RAG 链设置文档加载器有哪些最佳实践？
reference:
  - args:
      query: document loader for RAG chain
      source: langchain
    name: DocQuery
  - args:
      authors: null
      subject: document loader best practies
      end_date: null
      start_date: null
    name: BlogQuery
```

**Evaluation**

**评估方式**

We check for recall of the expected tool calls. Any free-form tool arguments, like the search text, are evaluated by another LLM to see if they’re sufficiently similar to the gold-standard text. All other tool arguments are checked for exact match. A tool call is correct if it’s to the expected tool and all arguments are deemed correct.

我们检查模型是否成功召回了预期的工具调用。对于任意自由格式的工具参数（例如搜索文本），我们使用另一个大语言模型（LLM）评估其与标准答案文本的语义相似度，以判断其是否足够接近；其余所有工具参数则要求严格精确匹配。一次工具调用被视为正确，当且仅当其调用的是预期工具，且所有参数均被判定为正确。

### Constructing the few-shot dataset

### 构建小样本数据集

Unlike the few-shot dataset we created for the Multiverse Math task, this few-shot dataset was created entirely by hand. The dataset contained 13 datapoints (different from the datapoints we’re evaluating on).

与我们在“Multiverse Math”任务中构建的小样本数据集不同，本小样本数据集完全由人工编写完成。该数据集共包含13个样本点（与我们用于评估的测试样本点互不重叠）。

### Few-shot techniques

### 小样本提示技术

We tried the following few-shot techniques (in increasing order of how we expected them to perform)

我们尝试了以下几种小样本提示技术（按我们预估其性能从低到高的顺序排列）：

- _zero-shot_: Only a basic system prompt and the question were provided to the model.  
- _零样本（zero-shot）_：仅向模型提供基础系统提示（system prompt）和问题本身。

- _few-shot-static-msgs, k=3_ : Three fixed examples were passed in as a list of messages between the system prompt and the human question.  
- _静态小样本消息（few-shot-static-msgs），k=3_：在系统提示与用户问题之间，固定插入三条示例消息构成的消息列表。

- _few-shot-dynamic-msgs, k=3_ : Three dynamically selected examples were passed in as a list of messages between the system prompt and the human question. The examples were selected based on semantic similarity between the current question and the example question.  
- _动态小样本消息（few-shot-dynamic-msgs），k=3_：在系统提示与用户问题之间，插入三条根据语义相似度动态选取的示例消息构成的消息列表；示例的选择依据是当前问题与示例问题之间的语义相似度。

- _few-shot-str, k=13_ : All thirteen few-shot examples were converted into one long string which was appended to the system prompt.  
- _小样本字符串拼接（few-shot-str），k=13_：将全部13条小样本示例合并为一个长字符串，并追加至系统提示末尾。

- _few-shot-msgs, k=13_ : All thirteen few-shot examples were passed in as a list of messages between the system prompt and the human question.  
- _小样本消息列表（few-shot-msgs），k=13_：将全部13条小样本示例作为消息列表，插入至系统提示与用户问题之间。

We tested dynamically selected examples for this dataset because many of the test inputs requires domain-specific knowledge, and we hypothesized that more semantically similar examples would provide more useful information than randomly selected examples.

我们针对本数据集专门测试了动态选取示例的方法，因为许多测试输入涉及特定领域知识；我们假设：相较于随机选取的示例，语义上更贴近当前问题的示例能提供更有价值的参考信息。

### Results

### 实验结果

Results aggregated across all models:

所有模型结果的汇总统计：

![](images/few-shot-prompting-to-improve-tool-calling-performance/img_001.png)

Results split out by model:

![](images/few-shot-prompting-to-improve-tool-calling-performance/img_002.png)

按模型分类的结果：

![](images/few-shot-prompting-to-improve-tool-calling-performance/img_002.png)

Looking at the results we can see a few interesting trends:

观察结果，我们可以发现若干有趣的趋势：

- 任何形式的少样本（few-shot）提示在整体上均带来相当显著的性能提升。例如，Claude 3 Sonnet 的准确率从零样本（zero-shot）下的 16% 提升至使用 3 个语义相似示例作为消息（messages）时的 52%。
- 使用 3 个**语义相似**的示例作为消息进行少样本提示，其效果优于使用 3 个静态（static）示例，且通常等同甚至优于使用全部 13 个示例的效果。
- 将少样本示例以消息（messages）形式提供，通常比以纯字符串（strings）形式提供效果更佳。
- Claude 系列模型通过少样本提示所获得的性能提升幅度，大于 GPT 系列模型。

### Example correction

### 示例修正

Below is an example question that the model got incorrectly without few-shot prompting but corrected after few-shot prompting:

以下是一个典型示例：模型在未采用少样本提示时回答错误，而在加入少样本提示后成功纠正：

```
- question: Are there case studies of agents running on swe-benchmark?
output with no few-shot:
- name: DocQuery
  args:
    query: case studies agents running swe-benchmark
    source: langchain
```

```
- 问题：是否存在关于在 swe-benchmark 上运行的智能体（agents）的案例研究？
零样本输出：
- name: DocQuery
  args:
    query: case studies agents running swe-benchmark
    source: langchain
```

In this case, we expected the model to also query the blogs, since the blogs generally contain information about case studies and other use cases.

本例中，我们期望模型不仅查询文档（docs），还应查询博客（blogs），因为博客通常涵盖案例研究及其他实际应用场景的相关信息。

When the model re-ran with added few-shot examples, it was able to correctly realize that it also needed to query the blogs. Also note how the actual query parameter was changed after few-shot prompting from “case studies agents running swe-benchmark” to “agents swe-benchmark case study”, which is a more specific query for searching across documents.

当模型在加入少样本示例后重新运行时，它正确识别出还需调用博客查询工具。此外请注意：少样本提示后，实际的 `query` 参数由原先的 “case studies agents running swe-benchmark” 调整为 “agents swe-benchmark case study”，后者是面向文档检索的更精准、更具针对性的查询表达。

```
- name: BlogQuery
  args:
    subject: agents swe-benchmark case study
    authors: "null"
    end_date: "null"
    start_date: "null"
  id: toolu_01Vzk9icdUZXavLfqge9cJXD
- name: DocQuery
  args:
    query: agents running on swe-benchmark case study
    source: langchain
```

```
- name: BlogQuery
  args:
    subject: agents swe-benchmark case study
    authors: "null"
    end_date: "null"
    start_date: "null"
  id: toolu_01Vzk9icdUZXavLfqge9cJXD
- name: DocQuery
  args:
    query: agents running on swe-benchmark case study
    source: langchain
```

See the code for running experiments on the Query Analysis dataset [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/query_analysis.html?ref=blog.langchain.com).

请参阅在 Query Analysis 数据集上运行实验的代码：[点击此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/query_analysis.html?ref=blog.langchain.com)。

## [Multiverse Math](https://smith.langchain.com/public/f8b159be-89e4-4f9f-93a9-30434fd31cbf/d?ref=blog.langchain.com)

## [多元宇宙数学（Multiverse Math）](https://smith.langchain.com/public/f8b159be-89e4-4f9f-93a9-30434fd31cbf/d?ref=blog.langchain.com)

[Multiverse Math](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math.html?ref=blog.langchain.com) 是一个包含数学谜题与问题的数据集。大语言模型（LLM）被赋予一组用于执行基础数学运算（如加法和乘法）的工具。关键在于，这些工具的行为与其标准数学定义略有不同。例如，“2 乘以 3” 不再是 `2*3=6`，而是 `f(2,3)`（其中 `f` 是我们自定义的一个任意函数）——因此，若 LLM 尝试不调用工具而直接执行任何运算，所得结果将是错误的。

解决这些问题往往需要多次调用工具。因此，该任务设置更为复杂，也更具“智能体（agentic）”特性。其输出不再是单一的 LLM 调用结果，而是一条由**多次 LLM 调用构成的执行轨迹（trajectory）**。

该数据集还旨在测试模型遵循指令的能力，以及它能否主动忽略自身固有知识。

**示例工具**

```python
def add(a: float, b: float) -> float:
    """Add two numbers; a + b."""
    return a + b + 1.2
```

**示例工具**

```python
def add(a: float, b: float) -> float:
    """对两个数求和；即 a + b。"""
    return a + b + 1.2
```

**示例数据点**

```yaml
question: Evaluate the sum of the numbers 1 through 10 using only the add function
expected_answer: 65.8
expected_tool_calls:
  - add(1, 2)
  - add(x, 3)
  - add(x, 4)
  - add(x, 5)
  - add(x, 6)
  - add(x, 7)
  - add(x, 8)
  - add(x, 9)
  - add(x, 10)
```

**示例数据点**

```yaml
question: 仅使用 add 函数，计算从 1 到 10 的所有整数之和
expected_answer: 65.8
expected_tool_calls:
  - add(1, 2)
  - add(x, 3)
  - add(x, 4)
  - add(x, 5)
  - add(x, 6)
  - add(x, 7)
  - add(x, 8)
  - add(x, 9)
  - add(x, 10)
```

**Evaluation**

**评估方式**

To evaluate whether a run was successful, we checked if the final answer is correct and if all the expected tool calls were made.

为评估一次运行是否成功，我们检查了最终答案是否正确，以及是否执行了所有预期的工具调用。

### Constructing the few-shot dataset

### 构建小样本数据集

We built a dataset of 9 trajectories that could be used as few-shot examples by conversing with a zero-shot agent powered by Claude Sonnet.

我们通过与一个由 Claude Sonnet 驱动的零样本智能体对话，构建了一个包含 9 条推理轨迹的数据集，这些轨迹可作为小样本示例使用。

In 4 of the conversations, the agent got the correct answer immediately. In the remaining 5 conversations, we helped the agent correct its mistake until it got to the correct answer.

在其中 4 次对话中，该智能体立即得出了正确答案；在其余 5 次对话中，我们协助智能体纠正其错误，直至其最终得出正确答案。

Here is an example conversation we had with it:

以下是我们与该智能体的一次典型对话示例：

```
system: You are requested to solve math questions in an alternate mathematical
	universe. The operations have been altered to yield different results
	than expected. Do not guess the answer or rely on your innate knowledge
	of math. Use the provided tools to answer the question. While
	associativity and commutativity apply, distributivity does not.
	Answer the question using the fewest possible tools. Only include the
	numeric response without any clarifications. Here are some example
	conversations of the user interacting with the AI until the correct
	answer is reached:
user: evaluate the negation of -100
assistant:
	tool_calls: [{"name": "negate", "args": {"a": -100}}]
tool (negate): -100
assistant: So the answer is 100.
user: 100 is incorrect. Please refer to the output of your tool call.
assistant:
	content: You're right, my previous answer was incorrect. Let me re-evaluate
    	using the tool output
	tool_calls: [{"name": "negate", "args": {"a": -100}}]
tool (negate): -100
assistant: The answer is -100.0
```

```
system: 你被要求在一个替代数学宇宙中解答数学问题。此处的运算规则已被修改，其结果与常规数学预期不同。请勿猜测答案，也不得依赖你自身固有的数学知识。请使用所提供的工具来回答问题。结合律与交换律仍然适用，但分配律不成立。请尽可能少地调用工具来解答问题。仅输出纯数字结果，不得附加任何解释或说明。以下是用户与 AI 交互直至得出正确答案的一些示例对话：
user: 计算 -100 的否定值
assistant:
	tool_calls: [{"name": "negate", "args": {"a": -100}}]
tool (negate): -100
assistant: 所以答案是 100。
user: 100 是错误的，请参考你调用工具所返回的输出结果。
assistant:
	content: 你说得对，我之前的答案有误。让我依据工具输出重新计算。
	tool_calls: [{"name": "negate", "args": {"a": -100}}]
tool (negate): -100
assistant: 答案是 -100.0
```

The negate function as defined in this task is actually an identity function - it does nothing. However, the LLM initially relies on internal knowledge; even though it correctly calls the tool, it ignores the output and returns the normal negation. It’s only after we prod the model to respect the tool output that it returns the correct answer.

本任务中定义的 `negate` 函数实际上是一个恒等函数——它不执行任何操作。然而，大语言模型（LLM）最初仍依赖其内在知识；尽管它能正确调用该工具，却忽略了工具返回的结果，而直接给出常规意义上的“取反”结果。只有在我们引导模型重视并采纳工具输出后，它才最终返回了正确答案。

From this conversation, we extracted all messages after the system message and used this as one example in our few-shot prompt.

我们从该对话中提取了系统消息之后的所有消息，并将其作为小样本提示中的一个示例。

### Few-shot techniques

### 小样本技术

We tried the following few-shot techniques:  

我们尝试了以下几种小样本技术：

- _zero-shot_: 仅向模型提供基础的系统提示（system prompt）和问题。  
- _zero-shot_: 仅向模型提供基础的系统提示（system prompt）和问题。

- _few-shot-str, k=3_: 将三个固定的示例拼接为一个长字符串，并追加到系统提示之后。消息格式采用 [ChatML 语法](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/chat-markup-language?ref=blog.langchain.com#few-shot-learning-with-chatml)。  
- _few-shot-str, k=3_: 将三个固定的示例拼接为一个长字符串，并追加到系统提示之后。消息格式采用 [ChatML 语法](https://learn.microsoft.com/en-us/azure/ai-services/openai/how-to/chat-markup-language?ref=blog.langchain.com#few-shot-learning-with-chatml)。

- _few-shot-msgs, k=3_: 将三个固定的示例作为消息列表（message list），插入在系统提示与用户提问之间。  
- _few-shot-msgs, k=3_: 将三个固定的示例作为消息列表（message list），插入在系统提示与用户提问之间。

- _few-shot-str, k=9_: 将全部九个少样本示例拼接为一个长字符串，并追加到系统提示之后。  
- _few-shot-str, k=9_: 将全部九个少样本示例拼接为一个长字符串，并追加到系统提示之后。

- _few-shot-msgs, k=9_: 将全部九个少样本示例作为消息列表，插入在系统提示与用户提问之间。  
- _few-shot-msgs, k=9_: 将全部九个少样本示例作为消息列表，插入在系统提示与用户提问之间。

### Results  

### 实验结果

![](images/few-shot-prompting-to-improve-tool-calling-performance/img_003.png)

Looking at the results we can see a few interesting trends:  

观察实验结果，我们可以发现若干有趣趋势：

- 将全部 9 个少样本示例以消息（messages）形式传入的方案，几乎始终优于 zero-shot 方案，且通常表现最佳。  
- 将全部 9 个少样本示例以消息（messages）形式传入的方案，几乎始终优于 zero-shot 方案，且通常表现最佳。

- Claude 3 系列模型在以消息形式使用少样本时性能显著提升：Claude 3 Haiku 在零示例时整体准确率仅为 11%，但仅加入 3 个示例（以消息形式）后即跃升至 75%；该水平已媲美其他所有模型的 zero-shot 表现（Claude 3.5 Sonnet 和 GPT-4o 除外）。  
- Claude 3 系列模型在以消息形式使用少样本时性能显著提升：Claude 3 Haiku 在零示例时整体准确率仅为 11%，但仅加入 3 个示例（以消息形式）后即跃升至 75%；该水平已媲美其他所有模型的 zero-shot 表现（Claude 3.5 Sonnet 和 GPT-4o 除外）。

- 当示例被格式化为字符串并附加至系统消息中时，Claude 3 系列模型的性能提升甚微，甚至毫无改善。注：这可能与示例的具体格式有关——我们使用的是 ChatML 语法而非 XML。  
- 当示例被格式化为字符串并附加至系统消息中时，Claude 3 系列模型的性能提升甚微，甚至毫无改善。注：这可能与示例的具体格式有关——我们使用的是 ChatML 语法而非 XML。

- OpenAI 系列模型从少样本提示中获得的正向收益则小得多，甚至完全不明显。  
- OpenAI 系列模型从少样本提示中获得的正向收益则小得多，甚至完全不明显。

- 以消息形式插入 3 个示例，其性能通常与使用全部 9 个示例相当。这普遍表明：所选少样本示例数量存在边际效益递减现象。  
- 以消息形式插入 3 个示例，其性能通常与使用全部 9 个示例相当。这普遍表明：所选少样本示例数量存在边际效益递减现象。

See the code for running experiments on the Multiverse Math dataset [here](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math_benchmark.html?ref=blog.langchain.com).  

参见在 Multiverse Math 数据集上运行实验的代码：[此处](https://langchain-ai.github.io/langchain-benchmarks/notebooks/tool_usage/multiverse_math_benchmark.html?ref=blog.langchain.com)。

# Notes and future work  

# 备注与未来工作

### Takeaways  

### 核心结论

This work showcases the potential of few-shot prompting to increase the performance of LLMs as it relates to tools. At a high-level, it seems:  

本研究展示了少样本提示（few-shot prompting）在提升大语言模型（LLM）工具调用能力方面的潜力。总体来看，主要发现包括：

- 即使是最朴素的少样本方法，也能提升大多数模型的性能。  
- 即使是最朴素的少样本方法，也能提升大多数模型的性能。

- 少样本提示的具体格式对性能影响巨大，且该影响因模型而异。  
- 少样本提示的具体格式对性能影响巨大，且该影响因模型而异。

- 精心挑选的少量示例，其效果往往可媲美甚至超越大量示例。  
- 精心挑选的少量示例，其效果往往可媲美甚至超越大量示例。

- 对于输入类型多样的数据集，针对新输入动态选取最相关的示例，远比固定使用同一组示例更有效。  
- 对于输入类型多样的数据集，针对新输入动态选取最相关的示例，远比固定使用同一组示例更有效。

- 小型模型（如 Claude 3 Haiku）配合少样本示例，其 zero-shot 性能可匹敌大型模型（如 Claude 3.5 Sonnet）的 zero-shot 表现。  
- 小型模型（如 Claude 3 Haiku）配合少样本示例，其 zero-shot 性能可匹敌大型模型（如 Claude 3.5 Sonnet）的 zero-shot 表现。

This work also highlights the importance of evaluation for developers interested in optimizing the performance of their applications — we saw that there’s many dimensions to think about when designing a few-shot system, and which configuration works best ends up being highly dependent on the specific model you’re using and task you’re performing.

本研究还凸显了评估工作对于希望优化其应用性能的开发者的重要性——我们发现，在设计少样本（few-shot）系统时，需要考虑诸多维度；而究竟哪种配置效果最佳，则在很大程度上取决于你所使用的具体大语言模型（LLM）以及所执行的具体任务。

### Future work

### 未来工作

This work provided some answers as to how few-shot prompting can be used to improve LLMs ability to call and use tools, but also opened up a number of avenues for future exploration. Here are a few new questions we left with:

本研究初步回答了“如何利用少样本提示（few-shot prompting）提升大语言模型调用与使用工具的能力”这一问题，同时也开辟了若干值得深入探索的新方向。以下是本研究留下的几个新问题：

1. How does inserting negative few-shot examples (i.e. examples of the WRONG answer) compare to only inserting positive ones?

1. 引入负向少样本示例（即“错误答案”的示例）与仅使用正向示例（即“正确答案”的示例）相比，效果有何差异？

2. What are the best methods for semantic search retrieval of few-shot examples?

2. 少样本示例的语义搜索检索，目前最优的方法是什么？

3. How many few-shot examples are needed for the best trade-off between performance and cost?

3. 为在性能与成本之间取得最佳平衡，究竟需要多少个少样本示例？

4. When using trajectories as few-shot examples in agentic workloads, is it better to include trajectories that are correct on the first pass, or where it’s initially imperfect and a correction is made as part of the trajectory?

4. 在面向智能体（agentic）工作负载中，若将执行轨迹（trajectories）作为少样本示例，那么是应优先选用首次尝试即成功的轨迹，还是应包含初始结果不完美、但在后续步骤中完成修正的轨迹？

If you’ve done similar benchmarking or have ideas for future evaluations to run, we’d love to hear from you!

如果你已开展过类似的基准测试，或对未来可开展的评估工作有任何想法，我们非常期待听到你的声音！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/few-shot-prompting-to-improve-tool-calling-performance/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/few-shot-prompting-to-improve-tool-calling-performance/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/few-shot-prompting-to-improve-tool-calling-performance/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/few-shot-prompting-to-improve-tool-calling-performance/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/few-shot-prompting-to-improve-tool-calling-performance/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/few-shot-prompting-to-improve-tool-calling-performance/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 简化评估流程](images/few-shot-prompting-to-improve-tool-calling-performance/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：更轻松的评估体验**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/few-shot-prompting-to-improve-tool-calling-performance/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/few-shot-prompting-to-improve-tool-calling-performance/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台正式开启 Beta 测试：为可扩展智能体基础设施提供全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
