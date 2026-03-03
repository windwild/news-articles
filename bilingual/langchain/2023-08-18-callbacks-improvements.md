---
title: "Callbacks Improvements"
source: "LangChain Blog"
url: "https://blog.langchain.com/callbacks/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:00:40.658220161+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

**TL;DR**: We're announcing improvements to our callbacks system, which powers logging, tracing, [streaming output](https://python.langchain.com/docs/modules/model_io/models/llms/how_to/streaming_llm?ref=blog.langchain.com), and some awesome [third-party integrations](https://python.langchain.com/docs/ecosystem/integrations/?ref=blog.langchain.com). This will better support concurrent runs with independent callbacks, tracing of deeply nested trees of LangChain components, and callback handlers scoped to a single request (which is super useful for deploying LangChain on a server).

**简明摘要（TL;DR）**: 我们宣布对回调（callbacks）系统进行多项改进。该系统支撑着日志记录（logging）、链路追踪（tracing）、[流式输出（streaming output）](https://python.langchain.com/docs/modules/model_io/models/llms/how_to/streaming_llm?ref=blog.langchain.com)，以及一些出色的[第三方集成](https://python.langchain.com/docs/ecosystem/integrations/?ref=blog.langchain.com)。此次升级将更好地支持：并发运行时各任务拥有独立的回调、对 LangChain 组件深层嵌套调用树的完整追踪，以及将回调处理器（callback handler）作用域限定于单个请求（这对在服务器上部署 LangChain 极其有用）。

- [Python docs](https://python.langchain.com/docs/modules/callbacks/?ref=blog.langchain.com)  
- [JS docs](https://js.langchain.com/docs/production/callbacks/?ref=blog.langchain.com)  

- [Python 文档](https://python.langchain.com/docs/modules/callbacks/?ref=blog.langchain.com)  
- [JavaScript 文档](https://js.langchain.com/docs/production/callbacks/?ref=blog.langchain.com)  

### Context

### 背景

Originally we designed the callbacks mechanism in LangChain to be used in non-async Python applications. Now that we have support for both `asyncio` Python usage as well LangChain in JavaScript/TypeScript, we needed some better abstractions native to this new world where many concurrent LangChain runs can be inflight in the same thread or in multiple threads. Additionally, it became clear that developers using LangChain in web environments often wanted to scope a callback to a single request (so they can pass it a specific handle to a websocket, for example).

最初，LangChain 的回调机制是为非异步（non-async）的 Python 应用程序设计的。如今，我们已全面支持基于 `asyncio` 的 Python 用法，以及 JavaScript/TypeScript 版本的 LangChain。因此，我们需要一套更契合新时代需求的抽象机制——在这个新世界中，同一线程或多个线程内可能同时存在大量并发执行的 LangChain 运行实例。此外，我们也发现，在 Web 环境中使用 LangChain 的开发者，常常希望将某个回调处理器的作用域限定于单个 HTTP 请求（例如，以便向 WebSocket 传递一个特定的句柄）。

## Changes

## 主要变更

We've made some changes to our callbacks mechanism to address these issues:

我们已对回调机制作出若干调整，以解决上述问题：

- You can now declare which callbacks you want either in constructor args (which apply to all runs), or passing them directly to the `run` / `call` / `apply` methods that start a run. _Constructor callbacks_ will be used for all calls made on that object, and will be scoped to that object only, i.e. if you pass a handler to the `LLMChain` constructor, it will not be used by the model attached to that chain.

- 现在，您既可在构造函数参数中声明所需回调（这些回调将应用于该对象的所有运行），也可直接将其传入启动运行的 `run` / `call` / `apply` 方法中。_构造函数级回调（constructor callbacks）_ 将被该对象所有方法调用所共用，且仅对该对象本身生效；例如，若您将一个处理器传给 `LLMChain` 的构造函数，它**不会**被该链所绑定的模型（model）所使用。

- _Request callbacks_ will be used for that specific request only, and all sub-requests that it contains (eg. a call to an LLMChain triggers a call to a Model, which uses the same handler passed in the `call()` method). These are explicitly passed through. An example to make this more concrete: when a handler is passed through to an `AgentExecutor` via `run`, it will be used for all callbacks related to the agent and all the objects involved in the agent’s execution, in this case, the `Tools`, `LLMChain`, and `LLM`. Previously, to use a callback scoped to particular agent run, that callback manager had to be attached to all nested objects – this was tedious, ugly, and made it hard to re-use objects. See the TypeScript example below:

- _请求级回调（request callbacks）_ 仅作用于当前请求及其所有子请求（例如：调用 `LLMChain` 会进一步触发对 `Model` 的调用，而后者将复用 `call()` 方法中传入的同一处理器）。这些回调需显式传递。以下是一个具体示例：当通过 `run` 方法将处理器传入 `AgentExecutor` 后，该处理器将被用于与该 Agent 相关的所有回调，包括执行过程中涉及的所有组件——如 `Tools`、`LLMChain` 和 `LLM`。此前，若想让回调作用域限定于某次特定的 Agent 运行，则必须手动将回调管理器（callback manager）逐一附加到所有嵌套对象上——这种做法既繁琐又丑陋，也严重阻碍了对象的复用性。请参见下方 TypeScript 示例：

```typescript
// What had to be done before for run-scoped custom callbacks. Very tedious!
const executors = [];
for (let i = 0; i < 3; i += 1) {
  const callbackManager = new CallbackManager();
  callbackManager.addHandler(new ConsoleCallbackHandler());
  callbackManager.addHandler(new LangChainTracer());

  const model = new OpenAI({ temperature: 0, callbackManager });
  const tools = [new SerpAPI(), new Calculator()];
  for (const tool of tools) {
    tool.callbackManager = callbackManager;
  }
  const executor = await initializeAgentExecutor(
    tools,
    model,
    "zero-shot-react-description",
    true,
    callbackManager
  );
  executor.agent.llmChain.callbackManager = callbackManager;
  executors.push(executor);
}

const results = await Promise.all(
  executors.map((executor) => executor.call({ input }))
);
for (const result of results) {
  console.log(`Got output ${result.output}`);
}
```

```typescript
// 此前为实现“按请求定制回调”所必需的写法——极其繁琐！
const executors = [];
for (let i = 0; i < 3; i += 1) {
  const callbackManager = new CallbackManager();
  callbackManager.addHandler(new ConsoleCallbackHandler());
  callbackManager.addHandler(new LangChainTracer());

  const model = new OpenAI({ temperature: 0, callbackManager });
  const tools = [new SerpAPI(), new Calculator()];
  for (const tool of tools) {
    tool.callbackManager = callbackManager;
  }
  const executor = await initializeAgentExecutor(
    tools,
    model,
    "zero-shot-react-description",
    true,
    callbackManager
  );
  executor.agent.llmChain.callbackManager = callbackManager;
  executors.push(executor);
}

const results = await Promise.all(
  executors.map((executor) => executor.call({ input }))
);
for (const result of results) {
  console.log(`获取输出 ${result.output}`);
}
```

- `_call`, `_generate`, `_run` 以及 Chains / LLMs / Chat Models / Agents / Tools 上对应的异步方法，现在均接收第二个参数 `runManager`。该参数与当前运行（run）绑定，并包含可供该对象使用的日志记录方法（例如 `handleLLMNewToken`）。此功能在构建自定义 Chain 时尤为有用；更多详情请参阅[此处](https://python.langchain.com/docs/modules/chains/how_to/custom_chain?ref=blog.langchain.com)。

- `_call`、`_generate`、`_run` 及 Chains / LLMs / Chat Models / Agents / Tools 上对应的异步方法，现均接收一个名为 `runManager` 的第二参数。该参数与本次运行（run）绑定，并包含该对象可用的日志方法（例如 `handleLLMNewToken`）。此功能在构建自定义 Chain 时非常实用；更多详情请参阅[此处](https://python.langchain.com/docs/modules/chains/how_to/custom_chain?ref=blog.langchain.com)。

- `verbose` 参数如今仅作为快捷方式，用于在 JavaScript 中自动添加 `ConsoleCallbackHandler`、在 Python 中自动添加 `StdOutCallbackHandler`，将事件打印至标准输出（stdout）。**它不再控制其他类型的回调（callbacks）**。

- `verbose` 参数如今仅作为快捷方式，在 JavaScript 中自动添加 `ConsoleCallbackHandler`，在 Python 中自动添加 `StdOutCallbackHandler`，将事件打印至标准输出（stdout）。**它不再控制其他类型的回调（callbacks）**。

Tracing 和其他回调现在已支持并发执行，且“开箱即用”（[_just work_ with concurrency](https://python.langchain.com/docs/modules/callbacks/how_to/tracing?ref=blog.langchain.com)）。我们还新增了一个上下文管理器（context manager），使对特定运行（specific runs）启用 tracing 更加便捷。

Tracing 和其他回调现已支持并发执行，且“开箱即用”（[_just work_ with concurrency](https://python.langchain.com/docs/modules/callbacks/how_to/tracing?ref=blog.langchain.com)）。我们还新增了一个上下文管理器（context manager），使对特定运行（specific runs）启用 tracing 更加便捷。

## Breaking Changes and Deprecations:

## 破坏性变更与弃用说明：

- 所有在 LangChain 外部依赖全局回调（global callbacks）或全局追踪器（global tracer）（例如 `SharedCallbackManager`、`SharedTracer`）的代码，在 Python 包版本 >0.0.153 中将无法正常工作。

- 所有在 LangChain 外部依赖全局回调（global callbacks）或全局追踪器（global tracer）（例如 `SharedCallbackManager`、`SharedTracer`）的代码，在 Python 包版本 >0.0.153 中将无法正常工作。

- 现已弃用向对象附加 `CallbackManager` 的方式；请改用 `callbacks` 参数传入一个处理器（handler）列表。

- 现已弃用向对象附加 `CallbackManager` 的方式；请改用 `callbacks` 参数传入一个处理器（handler）列表。

- `verbose` 标志现仅控制 `stdout` 和 `console` 类型的回调，不再影响其他回调。

- `verbose` 标志现仅控制 `stdout` 和 `console` 类型的回调，不再影响其他回调。

## Inspiration

## 设计灵感

When we were implementing these improvements to Callbacks we looked at a few existing solutions that ended up influencing the final API, worth calling out:

我们在实现这些 Callback 改进时，参考了若干现有方案，它们最终影响了最终 API 的设计，值得特别指出：

- The Python `logging` module (and others), which offers a `getChild` method that returns a new logger bound to a certain context. This inspired the new `runManager.getChild()` which you can use when implementing a custom Chain to ensure child runs are tracked correctly.

- Python 的 `logging` 模块（及其他类似模块）提供了 `getChild` 方法，可返回一个绑定到特定上下文的新 logger。这一设计启发了新增的 `runManager.getChild()` 方法——你在实现自定义 Chain 时可使用它，以确保子运行（child runs）被正确追踪。

- Web server frameworks like `express` where all the context specific to each HTTP request is passed around explicitly as function arguments, rather than being available as some sort of global variable.

- 类似 `express` 这样的 Web 服务框架：每个 HTTP 请求所特有的上下文信息，均通过函数参数显式传递，而非以某种全局变量的形式存在。

We also considered the alternative of using some form of async context variables, an implementation of which exists in [Python](https://docs.python.org/3/library/contextvars.html?ref=blog.langchain.com) and in [Node.js](https://nodejs.org/api/async_context.html?ref=blog.langchain.com) (but not in other JS environments). In the end we decided for the explicit function arguments approach because it is easier to debug, and more compatible cross-platform (function args work just about anywhere).

我们也曾考虑采用某种异步上下文变量（async context variables）方案；该机制已在 [Python](https://docs.python.org/3/library/contextvars.html?ref=blog.langchain.com) 和 [Node.js](https://nodejs.org/api/async_context.html?ref=blog.langchain.com) 中实现（但在其他 JS 运行环境尚不支持）。最终我们选择了显式函数参数的方式，因其更易于调试，且具备更强的跨平台兼容性（函数参数几乎可在任何环境中使用）。

我们也曾考虑采用某种异步上下文变量（async context variables）方案；该机制已在 [Python](https://docs.python.org/3/library/contextvars.html?ref=blog.langchain.com) 和 [Node.js](https://nodejs.org/api/async_context.html?ref=blog.langchain.com) 中实现（但在其他 JS 运行环境尚不支持）。最终我们选择了显式函数参数的方式，因其更易于调试，且具备更强的跨平台兼容性（函数参数几乎可在任何环境中使用）。

Please let us know if you run into any issues, as this was a large change!

如您在使用过程中遇到任何问题，请务必告知我们——这是一次影响范围较大的变更！

如您在使用过程中遇到任何问题，请务必告知我们——这是一次影响范围较大的变更！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/callbacks-improvements/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/callbacks-improvements/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/callbacks-improvements/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/callbacks-improvements/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/callbacks-improvements/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/callbacks-improvements/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/callbacks-improvements/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/callbacks-improvements/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/callbacks-improvements/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 正式进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读