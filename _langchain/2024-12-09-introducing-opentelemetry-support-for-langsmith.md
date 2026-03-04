---
title: "Introducing OpenTelemetry support for LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/opentelemetry-langsmith/"
date: "2024-12-09"
scraped_at: "2026-03-03T07:45:45.727795638+00:00"
language: "en-zh"
translated: true
description: "LangSmith now supports OpenTelemetry for distributed tracing and observability."
tags: ["By LangChain"]
---
&#123;% raw %}

LangSmith now supports ingesting traces in OpenTelemetry format, an open standard for distributed tracing and observability. [OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/?ref=blog.langchain.com) allows developers to instrument and export telemetry data  across a wide range of programming languages, frameworks, and monitoring tools for broad interoperability.

LangSmith 现已支持以 OpenTelemetry 格式接入追踪数据（traces），OpenTelemetry 是分布式追踪与可观测性领域的开放标准。[OpenTelemetry](https://opentelemetry.io/docs/what-is-opentelemetry/?ref=blog.langchain.com) 使开发者能够在多种编程语言、框架及监控工具中统一地进行遥测数据（telemetry data）的插桩（instrumentation）与导出，从而实现广泛的互操作性。

With this update, LangSmith’s API layer can now accept OpenTelemetry traces directly. You can point any supported OpenTelemetry exporter to the LangSmith OTEL endpoint, and your traces will be ingested and fully accessible within LangSmith — giving a complete view of your application’s performance with unified LLM monitoring and system telemetry.

借助此次更新，LangSmith 的 API 层现已可直接接收 OpenTelemetry 追踪数据。您只需将任意受支持的 OpenTelemetry 导出器（exporter）指向 LangSmith 的 OTEL 接入端点（OTEL endpoint），即可将追踪数据自动导入 LangSmith 并完整呈现——由此获得应用性能的全景视图，同时实现大语言模型（LLM）监控与系统遥测数据的统一管理。

## **OpenTelemetry semantic conventions**

## **OpenTelemetry 语义规范**

OpenTelemetry defines [semantic conventions](https://opentelemetry.io/docs/concepts/semantic-conventions/?ref=blog.langchain.com) for attribute names and data across various use cases. For example, there are semantic conventions for databases, messaging systems, and protocols such as HTTP or gRPC. For LangSmith, we specifically care about semantic conventions for generative AI.  As this area is new, there are a few existing conventions, but new official standards are still being developed.

OpenTelemetry 定义了涵盖各类使用场景的[语义规范](https://opentelemetry.io/docs/concepts/semantic-conventions/?ref=blog.langchain.com)，用于统一属性名称与数据格式。例如，数据库、消息系统，以及 HTTP 或 gRPC 等协议均有对应的语义规范。对 LangSmith 而言，我们尤其关注生成式 AI（generative AI）相关的语义规范。由于该领域尚属新兴，目前已存在若干初步规范，但正式的官方标准仍在持续制定与完善中。

We now support traces in the [OpenLLMetry](https://github.com/traceloop/openllmetry?ref=blog.langchain.com) format, a semantic convention and implementation that enables out-of-the-box instrumentation for a range of LLM models, vector databases, and common LLM frameworks.  Data must be sent with the OpenLLMetry semantic convention; you can then configure an OpenTelemetry-compatible SDK to point to LangSmith’s OTEL endpoint to ingest traces into LangSmith.

我们现已支持 [OpenLLMetry](https://github.com/traceloop/openllmetry?ref=blog.langchain.com) 格式的追踪数据——这是一套专为生成式 AI 设计的语义规范及配套实现，可为多种大语言模型（LLM）、向量数据库及主流 LLM 框架提供即开即用（out-of-the-box）的插桩能力。数据必须遵循 OpenLLMetry 语义规范发送；随后，您可配置任意兼容 OpenTelemetry 的 SDK，将其导出目标设为 LangSmith 的 OTEL 接入端点，从而将追踪数据顺利导入 LangSmith。

We plan to support accepting traces via other semantic conventions such as the [OpenTelemetry Gen AI semantic convention](https://opentelemetry.io/docs/specs/semconv/gen-ai/?ref=blog.langchain.com) as they evolve.

随着相关标准的发展演进，我们计划陆续支持其他语义规范（如 [OpenTelemetry Gen AI 语义规范](https://opentelemetry.io/docs/specs/semconv/gen-ai/?ref=blog.langchain.com)）所定义的追踪数据接入方式。

Below, we’ll walk through a few different ways to get started.

接下来，我们将介绍几种不同的入门方式。

## **Getting started with an OpenTelemetry based client**

## **基于 OpenTelemetry 客户端快速上手**

This example covers using the off the shelf OpenTelemetry Python client. Note that this approach would work with any OpenTelemetry compatible SDK in the language of your choice.

本示例介绍如何使用现成的 OpenTelemetry Python 客户端。请注意：此方法同样适用于您所选编程语言中任意兼容 OpenTelemetry 的 SDK。

First, install Python dependencies:

首先，安装 Python 依赖项：

```python
pip install openai
pip install opentelemetry-sdk
pip install opentelemetry-exporter-otlp
```

```python
pip install openai
pip install opentelemetry-sdk
pip install opentelemetry-exporter-otlp
```

Next, configure your environment variables for OpenTelemetry:

接下来，为 OpenTelemetry 配置环境变量：

```python
OTEL_EXPORTER_OTLP_ENDPOINT=https://api.smith.langchain.com/otel
OTEL_EXPORTER_OTLP_HEADERS="x-api-key=<your langsmith api key>,LANGSMITH_PROJECT=<project name>"
```

```python
OTEL_EXPORTER_OTLP_ENDPOINT=https://api.smith.langchain.com/otel
OTEL_EXPORTER_OTLP_HEADERS="x-api-key=<your langsmith api key>,LANGSMITH_PROJECT=<project name>"
```

Then run the following code which calls `openai` and wraps that with a span along with the required attributes:

然后运行以下代码：调用 `openai`，并使用一个 span 将其封装，同时设置所需的属性：

```python
from openai import OpenAI
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
)
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter

client = OpenAI()
otlp_exporter = OTLPSpanExporter()
trace.set_tracer_provider(TracerProvider())
trace.get_tracer_provider().add_span_processor(
    BatchSpanProcessor(otlp_exporter)
)
tracer = trace.get_tracer(__name__)

def call_openai():
    model = "gpt-4o-mini"
    with tracer.start_as_current_span("call_open_ai") as span:
        span.set_attribute("langsmith.span.kind", "LLM")
        span.set_attribute("langsmith.metadata.user_id", "user_123")
        span.set_attribute("gen_ai.system", "OpenAI")
        span.set_attribute("gen_ai.request.model", model)
        span.set_attribute("llm.request.type", "chat")

        messages = [\
            {"role": "system", "content": "You are a helpful assistant."},\
            {\
                "role": "user",\
                "content": "Write a haiku about recursion in programming."\
            }\
        ]

        for i, message in enumerate(messages):
            span.set_attribute(f"gen_ai.prompt.{i}.content", str(message["content"]))
            span.set_attribute(f"gen_ai.prompt.{i}.role", str(message["role"]))

        completion = client.chat.completions.create(
            model=model,
            messages=messages
        )
```

```python
from openai import OpenAI
from opentelemetry import trace
from opentelemetry.sdk.trace import TracerProvider
from opentelemetry.sdk.trace.export import (
    BatchSpanProcessor,
)
from opentelemetry.exporter.otlp.proto.http.trace_exporter import OTLPSpanExporter

client = OpenAI()
otlp_exporter = OTLPSpanExporter()
trace.set_tracer_provider(TracerProvider())
trace.get_tracer_provider().add_span_processor(
    BatchSpanProcessor(otlp_exporter)
)
tracer = trace.get_tracer(__name__)

def call_openai():
    model = "gpt-4o-mini"
    with tracer.start_as_current_span("call_open_ai") as span:
        span.set_attribute("langsmith.span.kind", "LLM")
        span.set_attribute("langsmith.metadata.user_id", "user_123")
        span.set_attribute("gen_ai.system", "OpenAI")
        span.set_attribute("gen_ai.request.model", model)
        span.set_attribute("llm.request.type", "chat")

        messages = [\
            {"role": "system", "content": "You are a helpful assistant."},\
            {\
                "role": "user",\
                "content": "Write a haiku about recursion in programming."\
            }\
        ]

        for i, message in enumerate(messages):
            span.set_attribute(f"gen_ai.prompt.{i}.content", str(message["content"]))
            span.set_attribute(f"gen_ai.prompt.{i}.role", str(message["role"]))

        completion = client.chat.completions.create(
            model=model,
            messages=messages
        )
```

```python
span.set_attribute("gen_ai.response.model", completion.model)
span.set_attribute("gen_ai.completion.0.content", str(completion.choices[0].message.content))
span.set_attribute("gen_ai.completion.0.role", "assistant")
span.set_attribute("gen_ai.usage.prompt_tokens", completion.usage.prompt_tokens)
span.set_attribute("gen_ai.usage.completion_tokens", completion.usage.completion_tokens)
span.set_attribute("gen_ai.usage.total_tokens", completion.usage.total_tokens)

return completion.choices[0].message
```

```python
span.set_attribute("gen_ai.response.model", completion.model)
span.set_attribute("gen_ai.completion.0.content", str(completion.choices[0].message.content))
span.set_attribute("gen_ai.completion.0.role", "assistant")
span.set_attribute("gen_ai.usage.prompt_tokens", completion.usage.prompt_tokens)
span.set_attribute("gen_ai.usage.completion_tokens", completion.usage.completion_tokens)
span.set_attribute("gen_ai.usage.total_tokens", completion.usage.total_tokens)

return completion.choices[0].message
```

```python
if __name__ == "__main__":
    call_openai()
```

```python
if __name__ == "__main__":
    call_openai()
```

You should see a trace in your LangSmith dashboard like [this one](https://smith.langchain.com/public/4f2890b1-f105-44aa-a6cf-c777dcc27a37/r?ref=blog.langchain.com).

您应在 LangSmith 仪表板中看到一条追踪记录，例如 [这个示例](https://smith.langchain.com/public/4f2890b1-f105-44aa-a6cf-c777dcc27a37/r?ref=blog.langchain.com)。

For more information, see the [documentation](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_opentelemetry?ref=blog.langchain.com).

如需了解更多信息，请参阅 [文档](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_opentelemetry?ref=blog.langchain.com)。

## **Getting started with Traceloop SDK**

## **开始使用 Traceloop SDK**

This example covers sending tracing using the OpenLLMetry SDK from Traceloop, which supports a wide range of integrations of models, vector databases, and frameworks out of the box.

本示例介绍如何使用 Traceloop 提供的 OpenLLMetry SDK 发送追踪数据；该 SDK 开箱即支持多种模型、向量数据库及框架的集成。

To get started, follow these steps. First, install the OpenLLMetry Traceloop SDK:

要开始使用，请按以下步骤操作。首先，安装 OpenLLMetry Traceloop SDK：

```python
pip install traceloop-sdk
```

```python
pip install traceloop-sdk
```

Set up your environment variables:

配置您的环境变量：

```python
TRACELOOP_BASE_URL=https://api.smith.langchain.com/otel
TRACELOOP_HEADERS=x-api-key=<your_api_key>
```

```python
TRACELOOP_BASE_URL=https://api.smith.langchain.com/otel
TRACELOOP_HEADERS=x-api-key=<your_api_key>
```

Then initialize the SDK:

然后初始化 SDK：

```python
from traceloop.sdk import Traceloop
Traceloop.init()
```

```python
from traceloop.sdk import Traceloop
Traceloop.init()
```

Here is a complete example using an OpenAI chat completion:

以下是一个使用 OpenAI 聊天补全功能的完整示例：

```python
import os
from openai import OpenAI
from traceloop.sdk import Traceloop

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
Traceloop.init()

completion = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[\
        {"role": "system", "content": "You are a helpful assistant."},\
        {\
            "role": "user",\
            "content": "Write a haiku about recursion in programming."\
        }\
    ]
)

print(completion.choices[0].message)
```

```python
import os
from openai import OpenAI
from traceloop.sdk import Traceloop

client = OpenAI(api_key=os.getenv("OPENAI_API_KEY"))
Traceloop.init()

completion = client.chat.completions.create(
    model="gpt-4o-mini",
    messages=[\
        {"role": "system", "content": "You are a helpful assistant."},\
        {\
            "role": "user",\
            "content": "Write a haiku about recursion in programming."\
        }\
    ]
)

print(completion.choices[0].message)
```

You should see a trace in your LangSmith dashboard like [this one](https://smith.langchain.com/public/106f5bed-edca-4357-91a5-80089252c9ed/r?ref=blog.langchain.com).

您应在 LangSmith 仪表板中看到一条追踪记录，例如 [这个示例](https://smith.langchain.com/public/106f5bed-edca-4357-91a5-80089252c9ed/r?ref=blog.langchain.com)。

For more information, see the [documentation](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_opentelemetry?ref=blog.langchain.com#logging-traces-with-the-traceloop-sdk).

如需了解更多详情，请参阅 [文档](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_opentelemetry?ref=blog.langchain.com#logging-traces-with-the-traceloop-sdk)。

## **Getting started with Vercel AI SDK**

## **开始使用 Vercel AI SDK**

We support the Vercel AI SDK integration using a client side trace exporter that is defined by the LangSmith library. To use this integration: first, install the AI SDK package:

我们通过 LangSmith 库定义的客户端追踪导出器（client-side trace exporter）支持 Vercel AI SDK 集成。要使用该集成，请首先安装 AI SDK 包：

```python
npm install ai @ai-sdk/openai zod
```

```python
npm install ai @ai-sdk/openai zod
```

Next, configure your environment:

接下来，配置您的运行环境：

```python
export LANGCHAIN_TRACING_V2=true
export LANGCHAIN_API_KEY=<your-api-key>
# The below examples use the OpenAI API, though it's not necessary in general
export OPENAI_API_KEY=<your-openai-api-key>
```

```python
export LANGCHAIN_TRACING_V2=true
export LANGCHAIN_API_KEY=<your-api-key>
# 以下示例使用 OpenAI API，但通常情况下并非必需
export OPENAI_API_KEY=<your-openai-api-key>
```

First, create an _instrumentation.js_ file in your project root. Learn more about how to setup OpenTelemetry instrumentation within your Next.js app [here](https://nextjs.org/docs/app/api-reference/file-conventions/instrumentation?ref=blog.langchain.com).

首先，在项目根目录下创建一个 `_instrumentation.js` 文件。有关如何在 Next.js 应用中配置 OpenTelemetry 插桩（instrumentation）的更多信息，请参阅[此处](https://nextjs.org/docs/app/api-reference/file-conventions/instrumentation?ref=blog.langchain.com)。

```python
import { registerOTel } from "@vercel/otel";
import { AISDKExporter } from "langsmith/vercel";
export function register() {
  registerOTel({
    serviceName: "langsmith-vercel-ai-sdk-example",
    traceExporter: new AISDKExporter(),
  });
}
```

```python
import { registerOTel } from "@vercel/otel";
import { AISDKExporter } from "langsmith/vercel";
export function register() {
  registerOTel({
    serviceName: "langsmith-vercel-ai-sdk-example",
    traceExporter: new AISDKExporter(),
  });
}
```

Afterwards, add the `experimental_telemetry` argument to your AI SDK calls that you want to trace. For convenience, we've included the `AISDKExporter.getSettings()` method which appends additional metadata for LangSmith.

之后，在您希望追踪的 AI SDK 调用中添加 `experimental_telemetry` 参数。为便于使用，我们提供了 `AISDKExporter.getSettings()` 方法，该方法会自动附加额外的元数据以供 LangSmith 使用。

```python
import { AISDKExporter } from "langsmith/vercel";
import { streamText } from "ai";
import { openai } from "@ai-sdk/openai";
await streamText({
  model: openai("gpt-4o-mini"),
  prompt: "Write a vegetarian lasagna recipe for 4 people.",
  experimental_telemetry: AISDKExporter.getSettings(),
});
```

```python
import { AISDKExporter } from "langsmith/vercel";
import { streamText } from "ai";
import { openai } from "@ai-sdk/openai";
await streamText({
  model: openai("gpt-4o-mini"),
  prompt: "为 4 人编写一份素食千层面食谱。",
  experimental_telemetry: AISDKExporter.getSettings(),
});
```

You should see a trace in your LangSmith dashboard [like this one](https://smith.langchain.com/public/a9d9521a-4f97-4843-b1e2-b87c3a125503/r?ref=blog.langchain.com).

您应在 LangSmith 仪表板中看到一条追踪记录，例如[这个示例](https://smith.langchain.com/public/a9d9521a-4f97-4843-b1e2-b87c3a125503/r?ref=blog.langchain.com)。

For more information, see the LangSmith documentation for the [Vercel AI SDK integration](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_vercel_ai_sdk?ref=blog.langchain.com).

如需了解更多信息，请参阅 LangSmith 文档中关于 [Vercel AI SDK 集成](https://docs.smith.langchain.com/observability/how_to_guides/tracing/trace_with_vercel_ai_sdk?ref=blog.langchain.com) 的说明。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/introducing-opentelemetry-support-for-langsmith/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/introducing-opentelemetry-support-for-langsmith/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/introducing-opentelemetry-support-for-langsmith/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/introducing-opentelemetry-support-for-langsmith/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/introducing-opentelemetry-support-for-langsmith/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024年人工智能现状》报告](images/introducing-opentelemetry-support-for-langsmith/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 6 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/introducing-opentelemetry-support-for-langsmith/img_004.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/introducing-opentelemetry-support-for-langsmith/img_004.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/introducing-opentelemetry-support-for-langsmith/img_005.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/introducing-opentelemetry-support-for-langsmith/img_005.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![Few-shot prompting to improve tool-calling performance](images/introducing-opentelemetry-support-for-langsmith/img_006.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[![利用少样本提示（few-shot prompting）提升工具调用性能](images/introducing-opentelemetry-support-for-langsmith/img_006.png)](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**Few-shot prompting to improve tool-calling performance**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[**通过少样本提示提升工具调用性能**](https://blog.langchain.com/few-shot-prompting-to-improve-tool-calling-performance/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 8 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：8 分钟
&#123;% endraw %}
