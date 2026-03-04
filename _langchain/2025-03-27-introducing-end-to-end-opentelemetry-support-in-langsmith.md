---
title: "Introducing End-to-End OpenTelemetry Support in LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/end-to-end-opentelemetry-langsmith/"
date: "2025-03-27"
scraped_at: "2026-03-03T07:36:44.907302389+00:00"
language: "en-zh"
translated: true
description: "LangSmith now provides end-to-end OpenTelemetry (OTel) support for applications built on LangChain and/or LangGraph."
tags: ["By LangChain"]
---
{% raw %}

Observability is critical for debugging and optimizing LLM applications — but until now, getting a complete view of your system meant juggling multiple tools and formats. Now, LangSmith offers full end-to-end OpenTelemetry support for applications built on LangChain and/or LangGraph.

可观测性对于调试和优化大语言模型（LLM）应用至关重要——但在此之前，要获得系统的完整视图，往往意味着需要在多种工具和格式之间来回切换。如今，LangSmith 为基于 LangChain 和/或 LangGraph 构建的应用提供了端到端的完整 OpenTelemetry 支持。

With our OpenTelemetry (OTel) integration, you can standardize tracing across your stack and send traces to LangSmith — our testing & observability platform for the agent lifecycle — or other observability platforms.

借助我们的 OpenTelemetry（OTel）集成，您可在整个技术栈中统一追踪标准，并将追踪数据（traces）发送至 LangSmith——我们专为智能体（agent）全生命周期打造的测试与可观测性平台——或其他可观测性平台。

Previously, LangSmith supported OpenTelemetry as only a backend trace ingestion format. With this update, we’re completing the picture by adding native OpenTelemetry support directly into the LangSmith SDK.

此前，LangSmith 仅将 OpenTelemetry 作为后端追踪数据摄入（trace ingestion）的一种格式予以支持。本次更新则进一步完善了整体能力，将原生 OpenTelemetry 支持直接集成至 LangSmith SDK 中。

## **Why OpenTelemetry for LLM applications?**

## **为何 LLM 应用需要 OpenTelemetry？**

OpenTelemetry (OTel) is an open-source observability framework that standardizes how telemetry data is collected, exported, and analyzed. As applications grow more complex and distributed, OpenTelemetry provides a consistent way to track performance, understand system behavior, and troubleshoot issues.

OpenTelemetry（OTel）是一个开源可观测性框架，它对遥测数据（telemetry data）的采集、导出与分析方式进行了标准化。随着应用日益复杂化与分布式化，OpenTelemetry 提供了一种一致的方法，用于追踪性能表现、理解系统行为并排查问题。

For LLM applications, observability presents unique challenges. Traditional application monitoring focuses on errors and compliance with expected behaviors — however, LLM observability requires understanding multi-step workflows and monitoring dynamic, stochastic outputs with complex evaluation metrics that go beyond simple error rates.

对于 LLM 应用而言，可观测性面临独特挑战。传统应用监控聚焦于错误识别及是否符合预期行为；而 LLM 可观测性则需深入理解多步骤工作流，并对动态、随机性强的输出进行监控——其评估指标高度复杂，远超简单的错误率范畴。

OpenTelemetry addresses these challenges by providing a unified, vendor-neutral standard for instrumentation that works across different languages, frameworks, and backends.

OpenTelemetry 通过提供一套统一、厂商中立的插桩（instrumentation）标准，有效应对上述挑战。该标准可跨不同编程语言、框架及后端无缝运行。

## **How our OpenTelemetry Pipeline Works**

## **我们的 OpenTelemetry 流水线如何运作**

With this update, LangSmith now offers a complete OpenTelemetry pipeline for LLM applications:

本次更新后，LangSmith 为 LLM 应用提供了一套完整的 OpenTelemetry 流水线：

- **LangChain instrumentation**: Automatically generate detailed traces from your LangChain or LangGraph applications  
- **LangChain 插桩能力**：自动为您基于 LangChain 或 LangGraph 的应用生成详尽的追踪数据（traces）

- **LangSmith SDK**: Convert and transport these traces through our SDK using OpenTelemetry's standardized format  
- **LangSmith SDK**：通过我们的 SDK，以 OpenTelemetry 标准化格式对这些追踪数据进行转换与传输

- **LangSmith platform**: Ingest and visualize traces in a powerful, LLM-specific observability dashboard  
- **LangSmith 平台**：在功能强大、专为 LLM 设计的可观测性仪表盘中完成追踪数据的摄入与可视化

This end-to-end integration unlocks several key benefits:

这一端到端集成解锁了多项关键优势：

- **Unified observability**: View your entire application stack—from LangChain components to underlying infrastructure—in a single, cohesive view  
- **统一可观测性**：在一个统一、连贯的视图中，查看您的完整应用栈——从 LangChain 组件到底层基础设施。

- **Distributed tracing**: Follow requests as they move through your microservices architecture, with context propagation ensuring that related spans are linked to the same trace  
- **分布式追踪**：跟踪请求在微服务架构中的流转过程；通过上下文传播（context propagation），确保相关 Span 被关联至同一 Trace。

- **Interoperability**: Connect LangSmith with your existing observability tools and infrastructure through the OpenTelemetry standard, including platforms like Datadog, Grafana, and Jaeger.  
- **互操作性**：借助 OpenTelemetry 标准，将 LangSmith 与您现有的可观测性工具及基础设施无缝集成，支持 Datadog、Grafana、Jaeger 等平台。

With this integration, you can trace the complete execution path of your LLM applications, from the initial prompt to the final response, with detailed visibility into each step along the way.

借助该集成，您可以完整追踪大语言模型（LLM）应用的执行路径——从初始提示（prompt）到最终响应（response），并对每一步骤实现精细化的可观测性。

## **Getting Started with OpenTelemetry in LangSmith**

## **在 LangSmith 中快速上手 OpenTelemetry**

### **1\. Installation** [**​**](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com\#1-installation)

### **1．安装** [**​**](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com\#1-installation)

Install the LangSmith package with OpenTelemetry support:

安装支持 OpenTelemetry 的 LangSmith 包：

```
pip install "langsmith[otel]"
pip install langchain
```

### **2\. Enable the OpenTelemetry integration** [**​**](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com\#2-enable-the-opentelemetry-integration)

### **2．启用 OpenTelemetry 集成** [**​**](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com\#2-enable-the-opentelemetry-integration)

You can enable the OpenTelemetry integration by setting the LANGSMITH\_OTEL\_ENABLED environment variable:

您可通过设置 `LANGSMITH_OTEL_ENABLED` 环境变量来启用 OpenTelemetry 集成：

```
LANGSMITH_OTEL_ENABLED=true
LANGSMITH_TRACING=true
LANGSMITH_ENDPOINT=https://api.smith.langchain.com
LANGSMITH_API_KEY=<your_langsmith_api_key>
```

### **3\. Create a LangChain application with tracing**  
### **3. 使用追踪功能创建 LangChain 应用**

Here's a simple example showing how to use the OpenTelemetry integration with LangChain:  

以下是一个简单示例，展示如何在 LangChain 中使用 OpenTelemetry 集成：

```
import os
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate

# LangChain will automatically use OpenTelemetry to send traces to LangSmith
# because the LANGSMITH_OTEL_ENABLED environment variable is set

# Create a chain
prompt = ChatPromptTemplate.from_template("Tell me a joke about {topic}")
model = ChatOpenAI()
chain = prompt | model

# Run the chain
result = chain.invoke({"topic": "programming"})
print(result.content)
```

```
import os
from langchain_openai import ChatOpenAI
from langchain_core.prompts import ChatPromptTemplate

# LangChain 将自动使用 OpenTelemetry 向 LangSmith 发送追踪数据，
# 因为环境变量 LANGSMITH_OTEL_ENABLED 已被设置

# 创建一个链（chain）
prompt = ChatPromptTemplate.from_template("讲一个关于 {topic} 的笑话")
model = ChatOpenAI()
chain = prompt | model

# 运行该链
result = chain.invoke({"topic": "编程"})
print(result.content)
```

### **4\. View the traces in LangSmith**  
### **4. 在 LangSmith 中查看追踪数据**

Once your application runs, you'll see the traces in your LangSmith dashboard [like this one](https://smith.langchain.com/public/a762af6c-b67d-4f22-90a0-728df16baeba/r?ref=blog.langchain.com).  

应用运行后，您将在 LangSmith 仪表板中看到对应的追踪数据，[例如这个示例](https://smith.langchain.com/public/a762af6c-b67d-4f22-90a0-728df16baeba/r?ref=blog.langchain.com)。

## **Performance Considerations**  
## **性能考量**

While our end-to-end OpenTelemetry support provides maximum flexibility and interoperability, it comes with slightly higher overhead compared to LangSmith’s native tracing format.  

尽管我们端到端的 OpenTelemetry 支持提供了最大程度的灵活性与互操作性，但相较于 LangSmith 原生的追踪格式，其运行开销略高。

For users that are exclusively using LangSmith as their observability platform, we still recommend our native tracing format for optimal performance. It offers realtime tracing with pending runs, faster ingest speeds, and reduced memory overhead from the sdk.

对于仅将 LangSmith 用作其可观测性平台的用户，我们仍推荐使用原生追踪格式以实现最佳性能。该格式支持对“待运行任务”（pending runs）的实时追踪、更快的数据摄入速度，以及更低的 SDK 内存开销。

The native LangSmith tracing format has been specifically designed for LLM applications and offers several key advantages. It features significantly reduced overhead with a lower computational and memory footprint compared to the more general-purpose OpenTelemetry format. Our native format is also custom-tailored for the unique data patterns and volumes found in LLM applications.

LangSmith 原生追踪格式专为大语言模型（LLM）应用设计，具备多项关键优势：相较于通用性更强的 OpenTelemetry 格式，其计算与内存开销显著降低；同时，该原生格式还针对 LLM 应用中特有的数据模式与数据量级进行了深度定制与优化。

## **Try it today**

## **立即体验**

Ready to get started tracing your LangChain and LangGraph applications with OpenTelemetry? Check out our [full documentation](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com) for more details and examples — and [try out LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) for free if you haven't already.

是否已准备好使用 OpenTelemetry 追踪您的 LangChain 和 LangGraph 应用？请查阅我们的[完整文档](https://docs.smith.langchain.com/observability/how_to_guides/trace_langchain_with_otel?ref=blog.langchain.com)，获取更多详细说明与示例；若您尚未体验，欢迎[免费试用 LangSmith](https://smith.langchain.com/?ref=blog.langchain.com)。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的实践心得](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的实践心得**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![LangChain State of AI 2024 Report](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_002.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_002.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_003.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_003.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_004.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_004.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_005.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_005.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Few-shot prompting to improve tool-calling performance](images/introducing-end-to-end-opentelemetry-support-in-langsmith/img_006.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**利用少样本提示提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：8 分钟
{% endraw %}
