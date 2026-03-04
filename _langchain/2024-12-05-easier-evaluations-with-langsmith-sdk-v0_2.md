---
render_with_liquid: false
title: "Easier evaluations with LangSmith SDK v0.2"
source: "LangChain Blog"
url: "https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/"
date: "2024-12-05"
scraped_at: "2026-03-03T07:46:26.188074739+00:00"
language: "en-zh"
translated: true
description: "We've released a v0.2 of the LangSmith SDKs with various evaluations and performance improvements."
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

We’ve recently released v0.2 of the LangSmith SDKs, which come with a number of improvements to the developer experience for evaluating applications. We have simplified usage of the `evaluate()` / `aevaluate()` methods, added an option to run evaluations locally without uploading any results, improved SDK performance, and expanded our documentation. These improvements have been made in both the Python and TypeScript SDKs.

我们最近发布了 LangSmith SDK 的 v0.2 版本，其中包含多项面向应用评估场景的开发者体验优化。我们简化了 `evaluate()` / `aevaluate()` 方法的使用方式，新增了无需上传任何结果、即可在本地运行评估的功能，提升了 SDK 性能，并进一步扩充了文档内容。上述改进已同步应用于 Python 和 TypeScript 两个 SDK。

The v0.2 release has 2 breaking changes in the Python SDK. These are listed at the bottom.

v0.2 版本在 Python SDK 中引入了两项不兼容变更（breaking changes），详见文末列表。

## Simplified usage of `evaluate()` / `aevaluate()`

## `evaluate()` / `aevaluate()` 方法使用方式简化

### **Simpler evaluators**

### **更简洁的评估器定义**

The LangSmith SDK’s allow you to define [custom evaluators](https://docs.smith.langchain.com/evaluation/how_to_guides/custom_evaluator?ref=blog.langchain.com), which are functions that score your application’s outputs on a dataset. Before today, these evaluators had to take as arguments a Run and an Example object:

LangSmith SDK 支持您定义[自定义评估器（custom evaluators）](https://docs.smith.langchain.com/evaluation/how_to_guides/custom_evaluator?ref=blog.langchain.com)，即对应用程序在数据集上的输出进行打分的函数。在此前版本中，此类评估器必须以 `Run` 和 `Example` 对象作为参数：

```python
from langsmith import evaluate
from langsmith.schemas import Run, Example

def correct(run: Run, example: Example) -> dict:
  outputs = run.outputs
  inputs = example.inputs
  reference_outputs = example.outputs

	score = run.outputs['answer'] == example.outputs['answer']
  return {"key": "correct", "score": score}

results = evaluate(..., evaluators=[correct])
```

In v0.2, you can write this in Python as:

在 v0.2 中，您可用如下更简洁的 Python 语法编写该评估器：

```python
from langsmith import evaluate

def correct(inputs: dict, outputs: dict, reference_outputs: dict) -> bool:
  return outputs["answer"] == reference_outputs["answer"]

results = evaluate(..., evaluators=[correct])
```

```python
from langsmith import evaluate

def correct(inputs: dict, outputs: dict, reference_outputs: dict) -> bool:
  return outputs["answer"] == reference_outputs["answer"]

results = evaluate(..., evaluators=[correct])
```

And in TypeScript as:

TypeScript 中的写法如下：

```tsx
import type { EvaluationResult } from "langsmith/evaluation";

const correct = async ({
  outputs,
  referenceOutputs,
}: {
  outputs: Record<string, any>;
  referenceOutputs?: Record<string, any>;
}): Promise<EvaluationResult> => {
  const score = outputs?.answer === referenceOutputs?.answer;
  return { key: "correct", score };
};
```

```tsx
import type { EvaluationResult } from "langsmith/evaluation";

const correct = async ({
  outputs,
  referenceOutputs,
}: {
  outputs: Record<string, any>;
  referenceOutputs?: Record<string, any>;
}): Promise<EvaluationResult> => {
  const score = outputs?.answer === referenceOutputs?.answer;
  return { key: "correct", score };
};
```

The keys changes are as follows:

主要变更点如下：

- You can write evaluator functions that accept the `inputs`, `outputs`, `reference_outputs` dicts as args. If needed, you can continue to pass in `run` and `example` to access run [intermediates steps or run/example metadata.](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_on_intermediate_steps?ref=blog.langchain.com)  
  您可编写接收 `inputs`、`outputs` 和 `reference_outputs` 字典作为参数的评估器函数。如有需要，仍可传入 `run` 和 `example` 参数，以访问运行过程中的[中间步骤或运行/样例元数据](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_on_intermediate_steps?ref=blog.langchain.com)。

- (Python only) You can return primitives _(float, int, bool, str)_ directly  
  （仅 Python）您可直接返回基础类型值（如 `float`、`int`、`bool`、`str`）。

Analogous simplifications have been made to [summary evaluators](https://docs.smith.langchain.com/evaluation/how_to_guides/summary?ref=blog.langchain.com) and [pairwise evaluators](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_pairwise?ref=blog.langchain.com). For more on defining evaluators head to [this how-to guide](https://docs.smith.langchain.com/evaluation/how_to_guides/custom_evaluator?ref=blog.langchain.com).

类似的简化也已应用于[摘要评估器](https://docs.smith.langchain.com/evaluation/how_to_guides/summary?ref=blog.langchain.com)和[成对评估器](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_pairwise?ref=blog.langchain.com)。有关如何定义评估器的更多详情，请参阅[此操作指南](https://docs.smith.langchain.com/evaluation/how_to_guides/custom_evaluator?ref=blog.langchain.com)。

### **Evaluate `langgraph` and `langchain` objects directly**

### **直接评估 `langgraph` 和 `langchain` 对象**

You can now pass your `langgraph` and `langchain` objects directly into `evaluate()` / `aevaluate()`:

现在，您可以直接将 `langgraph` 和 `langchain` 对象传入 `evaluate()` / `aevaluate()`：

```python
from langchain.chat_models import init_chat_model
from langgraph.prebuilt import create_react_agent
from langsmith import evaluate

def check_weather(location: str) -> str:
		'''Return the weather forecast for the specified location.'''
		return f"It's always sunny in {location}"

tools = [check_weather]
model = init_chat_model("gpt-4o-mini")
graph = create_react_agent(model, tools=tools)

results = evaluate(graph, ...)
```

```python
from langchain.chat_models import init_chat_model
from langgraph.prebuilt import create_react_agent
from langsmith import evaluate

def check_weather(location: str) -> str:
		'''返回指定地点的天气预报。'''
		return f"{location} 的天气总是晴朗！"

tools = [check_weather]
model = init_chat_model("gpt-4o-mini")
graph = create_react_agent(model, tools=tools)

results = evaluate(graph, ...)
```

For more on evaluating `langgraph` and `langchain` objects, see these how-to guides: [langgraph](https://docs.smith.langchain.com/evaluation/how_to_guides/langgraph?ref=blog.langchain.com), [langchain](https://docs.smith.langchain.com/evaluation/how_to_guides/langchain_runnable?ref=blog.langchain.com).

有关如何评估 `langgraph` 和 `langchain` 对象的更多内容，请参阅以下操作指南：[langgraph](https://docs.smith.langchain.com/evaluation/how_to_guides/langgraph?ref=blog.langchain.com)，[langchain](https://docs.smith.langchain.com/evaluation/how_to_guides/langchain_runnable?ref=blog.langchain.com)。

### **Consolidated evaluation methods**

### **统一的评估方法**

Previously, there were three different methods for running evaluations (not counting their async counterparts): `evaluate()`, `evaluate_existing()` and `evaluate_comparative()` / `evaluateComparative()` . The first was for running your application on a dataset and scoring the outputs, the second for just running evaluators on existing experiment results, and the third for running pairwise evaluators on two existing experiments.

此前，共有三种不同的评估执行方式（不计其异步对应版本）：`evaluate()`、`evaluate_existing()` 以及 `evaluate_comparative()` / `evaluateComparative()`。其中，`evaluate()` 用于在数据集上运行您的应用并对其输出进行评分；`evaluate_existing()` 仅对已有实验结果运行评估器；而 `evaluate_comparative()` 则用于在两个已有实验之间运行成对（pairwise）评估器。

In v0.2, you only need to know about the `evaluate()` method:

在 v0.2 版本中，您只需了解 `evaluate()` 这一种方法即可：

```python
from langsmith import evaluate
```

# Run the application and evaluate the results

# 运行应用程序并评估结果

```python
def app(inputs: dict) -> dict:
  return {"answer": "i'm not sure"}

results = evaluate(app, data="dataset-name", evaluators=[correct])
```

```python
def app(inputs: dict) -> dict:
  return {"answer": "i'm not sure"}

results = evaluate(app, data="dataset-name", evaluators=[correct])
```

# Run new evaluators on existing experimental results

# 在已有实验结果上运行新的评估器

```python
def concise(outputs: dict) -> bool:
	return len(outputs["answer"]) < 10

more_results = evaluate(
	results.experiment_name,  # Pass in an experiment name/ID instead of a function.
	evaluators=[concise].
)
```

```python
def concise(outputs: dict) -> bool:
	return len(outputs["answer"]) < 10

more_results = evaluate(
	results.experiment_name,  # 传入实验名称/ID，而非函数。
	evaluators=[concise]
)
```

# Run comparative evaluation

# 执行对比评估

# First we need to run a second experiment

# 首先，我们需要运行第二个实验

```python
def app_v2(inputs: dict) -> dict:
	return {"answer": "i dunno you tell me"}

results_v2 = evaluate(app_v2, data="dataset-name", evaluators=[correct])
```

```python
def app_v2(inputs: dict) -> dict:
	return {"answer": "i dunno you tell me"}

results_v2 = evaluate(app_v2, data="dataset-name", evaluators=[correct])
```

# Note: 'outputs' is a two-item list for pairwise evaluators.

# 注意：“outputs” 是一个包含两项的列表，专用于成对评估器（pairwise evaluators）。

```python
def more_concise(outputs: list[dict]) -> bool:
	v1_len = len(outputs[0]["answer"])
	v2_len = len(outputs[1]["answer"])
	if v1_len < v2_len:
		return [1, 0]
	elif v1_len > v2_len:
		return [0, 1]
	else:
		return [0, 0]

comparative_results = evaluate(
	[results.experiment_name, results_v2.experiment_name],  # Pass in two experiment names/IDs instead of a function.
	evaluators=[more_concise],  # Pass in a pairwise evaluator(s).
)
```

```python
def more_concise(outputs: list[dict]) -> bool:
	v1_len = len(outputs[0]["answer"])
	v2_len = len(outputs[1]["answer"])
	if v1_len < v2_len:
		return [1, 0]
	elif v1_len > v2_len:
		return [0, 1]
	else:
		return [0, 0]

comparative_results = evaluate(
	[results.experiment_name, results_v2.experiment_name],  # 传入两个实验名称/ID，而非函数。
	evaluators=[more_concise],  # 传入一个（或多个）成对评估器。
)
```

For more see our how-to guides on [pairwise experiments](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_pairwise?ref=blog.langchain.com) and [evaluating existing experiments](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_existing_experiment?ref=blog.langchain.com).

如需了解更多，请参阅我们的操作指南：[成对实验（pairwise experiments）](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_pairwise?ref=blog.langchain.com) 和 [评估已有实验（evaluating existing experiments）](https://docs.smith.langchain.com/evaluation/how_to_guides/evaluate_existing_experiment?ref=blog.langchain.com)。

## Beta: Run evaluations without uploading results

## Beta 版本：无需上传结果即可运行评估

Sometimes it is helpful to run an evaluation locally without uploading any results to LangSmith. For example, if you're quickly iterating on a prompt and want to smoke test it on a few examples, or if you're validating that your target and evaluator functions are defined correctly, you may not want to record these evaluations.

有时，不将任何结果上传至 LangSmith、而在本地运行评估会非常有帮助。例如，当你正在快速迭代某个提示词（prompt），希望用少量样例进行冒烟测试（smoke test）；或当你需要验证目标函数（target function）和评估器函数（evaluator function）是否正确定义时，可能并不希望记录这些评估。

In the v0.2 Python SDK, you can do this by simply setting:

在 v0.2 版本的 Python SDK 中，你只需设置如下参数即可实现：

```python
results = evaluate(..., upload_results=False)
```

The output of this will look exactly the same as it did before, but there will be no sign of this experiment in LangSmith. For more head to our [how-to guide on running evals locally](https://docs.smith.langchain.com/evaluation/how_to_guides/local?ref=blog.langchain.com).

该调用的输出格式与之前完全一致，但 LangSmith 中将不会留下此次实验的任何痕迹。欲了解更多信息，请参阅我们的[本地运行评估操作指南](https://docs.smith.langchain.com/evaluation/how_to_guides/local?ref=blog.langchain.com)。

**Note that this feature is still in beta and only supported in Python.**

**注意：该功能目前仍处于 Beta 阶段，且仅支持 Python。**

## **Improved Python SDK performance**

## **Python SDK 性能提升**

We’ve also made several improvements to the Python SDK's evaluation performance for large examples, resulting in approximately a 30% speedup in `aevaluate()` for examples ranging from 1 to 4MB .

我们还针对大样本场景优化了 Python SDK 的评估性能，使 `aevaluate()` 在处理 1–4 MB 大小的样例时，速度提升约 30%。

## **Revamped documentation**

## **文档全面重构**

We’ve rewritten most of our [evaluation how-to guides](https://docs.smith.langchain.com/evaluation/how_to_guides?ref=blog.langchain.com), revamping existing guides and adding a number of new ones related to the improvements mentioned in this post. We’ve also updated the Python SDK API Reference and consolidated it with the main LangSmith docs: [https://docs.smith.langchain.com/reference/python](https://docs.smith.langchain.com/reference/python?ref=blog.langchain.com)

我们已重写了大部分[评估操作指南](https://docs.smith.langchain.com/evaluation/how_to_guides?ref=blog.langchain.com)，不仅全面更新了既有内容，还新增了若干指南，以配合本文所述的各项改进。同时，我们更新并整合了 Python SDK 的 API 参考文档，将其统一纳入主 LangSmith 文档体系：[https://docs.smith.langchain.com/reference/python](https://docs.smith.langchain.com/reference/python?ref=blog.langchain.com)

## Breaking changes

## 不兼容变更

In the Python SDK, two breaking changes have been made:

Python SDK 中进行了两项不兼容的变更：

- In the Python SDK, `evaluate` / `aevaluate` now have a default `max_concurrency=0` instead of `None`. This makes it so that by default no concurrency is used instead of unlimited concurrency.

- 在 Python SDK 中，`evaluate` / `aevaluate` 的默认参数 `max_concurrency` 已从 `None` 更改为 `0`。这意味着默认情况下将**不启用并发**，而非此前的**无限制并发**。

- In the Python SDK, if you pass in a string as the data arg to evaluate: `evaluate(..., data="...")` / `aevaluate(..., data="...")`, we will now check if that string corresponds to a UUID and should be treated as the dataset ID before treating it as the dataset name. Previously, it was always assumed that a string value corresponds to the dataset name.

- 在 Python SDK 中，若向 `evaluate`（或 `aevaluate`）传入字符串作为 `data` 参数（即 `evaluate(..., data="...")` / `aevaluate(..., data="...")`），系统现在会**优先检查该字符串是否为 UUID**，若是，则将其视为数据集 ID；仅当非 UUID 时，才将其视为数据集名称。此前，字符串值始终被默认解释为数据集名称。

- We’ve officially dropped support for Python 3.8, which reached its EOL in October 2024.

- 我们已正式停止对 Python 3.8 的支持——该版本已于 2024 年 10 月结束生命周期（EOL）。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/easier-evaluations-with-langsmith-sdk-v0_2/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/easier-evaluations-with-langsmith-sdk-v0_2/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/easier-evaluations-with-langsmith-sdk-v0_2/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/easier-evaluations-with-langsmith-sdk-v0_2/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/easier-evaluations-with-langsmith-sdk-v0_2/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/easier-evaluations-with-langsmith-sdk-v0_2/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**正式推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/easier-evaluations-with-langsmith-sdk-v0_2/img_005.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入公测阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Few-shot prompting to improve tool-calling performance](images/easier-evaluations-with-langsmith-sdk-v0_2/img_006.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**通过少样本提示提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 8 分钟