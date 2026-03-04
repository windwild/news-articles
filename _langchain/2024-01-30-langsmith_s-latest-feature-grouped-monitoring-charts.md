---
title: "LangSmith's Latest Feature: Grouped Monitoring Charts"
source: "LangChain Blog"
url: "https://blog.langchain.com/grouped-monitoring-charts/"
date: "2024-01-30"
scraped_at: "2026-03-03T08:16:52.766164868+00:00"
language: "en-zh"
translated: true
tags: ["agent builder"]
---
{% raw %}

## Tag and Metadata Grouping

## 标签与元数据分组

LangSmith 长期以来支持监控图表，用于随时间展示您 LLM 应用的关键性能与反馈指标（参见任意项目详情页中的 **`Monitoring`**（监控）部分）。然而，此前无法对带有不同标签或元数据的已记录 trace 的指标进行对比分析。在 LLM 应用中，您通常拥有大量可调节参数（例如模型参数、提示词、分块策略、回溯窗口等），每一项都可能对应用效果产生巨大影响。

借助标签与元数据分组功能，LangSmith 用户现在可以为应用的不同版本打上不同的标识符，并利用全新的监控功能并排查看它们各自的性能表现。

## Sending Traces With Tags and Metadata

## 发送带标签与元数据的 Trace

LangSmith 现已支持在监控图表中按标签（tags）和元数据（metadata）进行分组。以下是如何为 trace 添加标签与元数据的快速回顾。如需了解更多详情，请查阅我们的 [文档](https://docs.smith.langchain.com/tracing/tracing-faq?ref=blog.langchain.com#how-do-i-add-metadata-to-runs)。

### LangChain

若使用 LangChain，您可在调用任意 `Runnable` 的 `invoke` 方法时，传入一个包含 `tags` 和/或 `metadata` 的字典。该机制在 TypeScript 中同样适用。

```python
chain.invoke({"input": "What is the meaning of life?"}, {"metadata": {"my_key": "My Value"}})  # 发送自定义元数据

chain.invoke({"input": "Hello, World!"}, {"tags": ["shared-tags"]})  # 发送自定义标签
```

LangChain Python

### LangSmith SDK / API

### LangSmith SDK / API

If you're not using LangChain, you can either use the SDK or API to log traces with custom tags and/or metadata.

如果您未使用 LangChain，您可选择使用 SDK 或 API 来记录带有自定义标签（tags）和/或元数据（metadata）的追踪（traces）。

```python
# Using the Python SDK
import openai
from langsmith.run_helpers import traceable

@traceable(
    run_type="llm"
    name="My LLM Call",
    tags=["tutorial"],
    metadata={"githash": "e38f04c83"},
)
def call_openai(
    messages: List[dict], model: str = "gpt-3.5-turbo", temperature: float = 0.0
) -> str:
    return openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=temperature,
    )
```

```python
# 使用 Python SDK
import openai
from langsmith.run_helpers import traceable

@traceable(
    run_type="llm",
    name="我的 LLM 调用",
    tags=["教程"],
    metadata={"githash": "e38f04c83"},
)
def call_openai(
    messages: List[dict], model: str = "gpt-3.5-turbo", temperature: float = 0.0
) -> str:
    return openai.ChatCompletion.create(
        model=model,
        messages=messages,
        temperature=temperature,
    )
```

Python SDK

Python SDK

```typescript
// Using the TypeScript SDK
import { RunTree, RunTreeConfig } from "langsmith";

const parentRunConfig: RunTreeConfig = {
    name: "My Chat Bot",
    run_type: "chain",
    inputs: {
        text: "Summarize this morning's meetings.",
    },
    extra: {
        metadata: {"githash": "e38f04c83"}
    },
    tags=["tutorial"]
};

const parentRun = new RunTree(parentRunConfig);
await parentRun.postRun();
```

```typescript
// 使用 TypeScript SDK
import { RunTree, RunTreeConfig } from "langsmith";

const parentRunConfig: RunTreeConfig = {
    name: "我的聊天机器人",
    run_type: "chain",
    inputs: {
        text: "总结今天早上的会议内容。",
    },
    extra: {
        metadata: {"githash": "e38f04c83"}
    },
    tags=["教程"]
};

const parentRun = new RunTree(parentRunConfig);
await parentRun.postRun();
```

TypeScript SDK

TypeScript SDK

```python
# Using the REST API (in Python)
requests.post(
    "https://api.smith.langchain.com/runs",
    json={
        "id": run_id,
        "name": "My Run",
        "run_type": "chain",
        "inputs": {"text": "Foo"},
        "start_time": datetime.datetime.utcnow().isoformat(),
        "session_name": project_name,
        "tags": ["langsmith", "rest", "my-example"],
        "extra": {
            "metadata": {"my_key": "My value"},
        },
    },
    headers={"x-api-key": _LANGSMITH_API_KEY},
)
```

```python
# 使用 REST API（Python 示例）
requests.post(
    "https://api.smith.langchain.com/runs",
    json={
        "id": run_id,
        "name": "我的运行",
        "run_type": "chain",
        "inputs": {"text": "Foo"},
        "start_time": datetime.datetime.utcnow().isoformat(),
        "session_name": project_name,
        "tags": ["langsmith", "rest", "my-example"],
        "extra": {
            "metadata": {"my_key": "我的值"},
        },
    },
    headers={"x-api-key": _LANGSMITH_API_KEY},
)
```

REST API (in Python)

REST API（Python 版）

## Case Study: Testing Different LLM Providers in Chat LangChain

## 案例研究：在 Chat LangChain 中测试不同大语言模型（LLM）提供商

[Chat LangChain](https://blog.langchain.com/building-chat-langchain-2/) 是一个由大语言模型（LLM）驱动的聊天机器人，专为回答有关 LangChain Python 文档的问题而设计。我们已使用 [LangServe](https://www.langchain.com/langserve?ref=blog.langchain.com) 将该聊天机器人部署至生产环境，并启用了 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 追踪功能，以实现业界领先的可观测性。我们允许用户从四个 LLM 提供商中任选其一（Claude 2.1、托管于 Fireworks 的 Mixtral、Google Gemini Pro，以及 OpenAI GPT-3.5 Turbo）来驱动聊天体验，并通过 `metadata` 中的键 `"llm"` 上报所选模型类型。

假设我们希望分析各模型在关键指标（如延迟 latency 和首 token 延迟 time-to-first-token）上的表现。

此处可见，监控图表已按 `llm` 元数据键进行了分组。通过分析这些图表，我们可识别各模型间的性能差异或异常，并基于数据做出应用优化决策。

### LLM Latency

### LLM 延迟

![](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_001.png)LangSmith 中展示 LLM 延迟随时间变化的图表

此处可见，由 Fireworks 托管的 Mixtral 模型生成响应的速度显著快于其他提供商。

### Time to First Token

### 首 token 延迟（Time-to-First-Token）

![](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_002.png)LangSmith 中展示首 token 延迟随时间变化的图表

This chart shows time-to-first-token over time across the different LLM providers. Interestingly, while Google Gemini provides faster overall completion times than Claude 2.1, time-to-first-token is is trending slower.

该图表展示了不同大语言模型（LLM）提供商的“首词响应时间”（time-to-first-token）随时间的变化趋势。有趣的是，尽管 Google Gemini 的整体完成时间比 Claude 2.1 更快，但其首词响应时间却呈现变慢的趋势。

### Feedback

### 反馈

![](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_003.png)Chart in LangSmith showing User Score (binary) over time

![](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_003.png)LangSmith 中展示用户评分（二值型）随时间变化的图表

The monitoring section also shows you charts for feedback across different criteria over time. While our feedback data was noisy during this time period, you can imagine that seeing clear trends in user satisfaction in chatbot response across the different model providers would allow for assessing tradeoffs of model latency vs quality of response.

监控模块还提供了随时间变化、按不同评估维度划分的反馈图表。尽管在该时间段内我们的反馈数据存在一定噪声，但可以设想：若能清晰观察到不同模型提供商在聊天机器人响应上的用户满意度变化趋势，便有助于权衡模型延迟与响应质量之间的取舍关系。

## Other Use-Cases

## 其他应用场景

Here, we’ve shown you can use metadata and tagging in LangSmith to group your data into different categories, one category per model-type, then analyze performance metrics for each category alongside each other. This paradigm can be easily applied to other use-cases:

此处我们已演示：您可在 LangSmith 中利用元数据（metadata）和标签（tagging）将数据划分为不同类别（例如，每种模型类型对应一个类别），进而并列分析各分类下的性能指标。这一范式可轻松拓展至其他应用场景：

- **A/B Testing with Revisions**: Imagine you're rolling out different feature revisions or versions in your application and want to test them side-by-side. By sending up a `revision` identifier in the metadata and grouping by this revision in your charts, you can clearly see how each version performs with respect to each other.

- **基于版本的 A/B 测试**：假设您正在应用中逐步上线不同功能修订版或版本，并希望对其进行并行对比测试。只需在元数据中传入 `revision` 标识符，并在图表中按该标识符进行分组，即可清晰直观地比较各版本之间的性能表现。

- **Enhancing User Experience**: By grouping data using `user_id` or `conversation_id` in metadata, you gain an in-depth understanding of how different users are experiencing the application and identify any user-specific issues or trends.

- **提升用户体验**：通过在元数据中使用 `user_id` 或 `conversation_id` 对数据进行分组，您可以深入理解不同用户对应用的实际使用体验，并识别出特定用户群体的问题或行为趋势。

These examples just scratch the surface of what's possible with LangSmith's new grouping feature.

以上示例仅初步展现了 LangSmith 新增分组功能的潜力。

You can sign up for LangSmith [here](https://smith.langchain.com/?ref=blog.langchain.com), as well as check out the LangSmith [docs](https://docs.smith.langchain.com/?ref=blog.langchain.com) and a helpful guided LangSmith [walkthrough](https://python.langchain.com/docs/langsmith/walkthrough?ref=blog.langchain.com) too.

您可在此处注册 LangSmith：[点击注册](https://smith.langchain.com/?ref=blog.langchain.com)，同时欢迎查阅 LangSmith 官方文档：[文档链接](https://docs.smith.langchain.com/?ref=blog.langchain.com)，以及一份实用的 LangSmith 指导式入门教程：[入门指南](https://python.langchain.com/docs/langsmith/walkthrough?ref=blog.langchain.com)。

### Tags

### 标签

[![Agent Builder now available in Public Beta](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_005.png)](https://blog.langchain.com/introducing-align-evals/)

[![推出 Align Evals：简化大语言模型应用评估流程](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_005.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)

[**推出 Align Evals：简化大语言模型应用评估流程**](https://blog.langchain.com/introducing-align-evals/)


[![Catch production failures early with LangSmith Alerts](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_006.png)](https://blog.langchain.com/langsmith-alerts/)

[![借助 LangSmith Alerts 提前发现生产环境故障](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_006.png)](https://blog.langchain.com/langsmith-alerts/)

[**Catch production failures early with LangSmith Alerts**](https://blog.langchain.com/langsmith-alerts/)

[**借助 LangSmith Alerts 提前发现生产环境故障**](https://blog.langchain.com/langsmith-alerts/)


[![Pairwise Evaluations with LangSmith](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_007.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![使用 LangSmith 进行成对评估（Pairwise Evaluations）](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_007.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**使用 LangSmith 进行成对评估（Pairwise Evaluations）**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![Access Control Updates for LangSmith](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_008.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[![LangSmith 访问控制更新](images/langsmith_s-latest-feature-grouped-monitoring-charts/img_008.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**LangSmith 访问控制更新**](https://blog.langchain.com/access-control-updates-for-langsmith/)
{% endraw %}
