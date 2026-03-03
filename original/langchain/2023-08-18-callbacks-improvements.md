---
title: "Callbacks Improvements"
source: "LangChain Blog"
url: "https://blog.langchain.com/callbacks/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:00:40.658220161+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

**TL;DR**: We're announcing improvements to our callbacks system, which powers logging, tracing, [streaming output](https://python.langchain.com/docs/modules/model_io/models/llms/how_to/streaming_llm?ref=blog.langchain.com), and some awesome [third-party integrations](https://python.langchain.com/docs/ecosystem/integrations/?ref=blog.langchain.com). This will better support concurrent runs with independent callbacks, tracing of deeply nested trees of LangChain components, and callback handlers scoped to a single request (which is super useful for deploying LangChain on a server).

- [Python docs](https://python.langchain.com/docs/modules/callbacks/?ref=blog.langchain.com)
- [JS docs](https://js.langchain.com/docs/production/callbacks/?ref=blog.langchain.com)

### Context

Originally we designed the callbacks mechanism in LangChain to be used in non-async Python applications. Now that we have support for both `asyncio` Python usage as well LangChain in JavaScript/TypeScript, we needed some better abstractions native to this new world where many concurrent LangChain runs can be inflight in the same thread or in multiple threads. Additionally, it became clear that developers using LangChain in web environments often wanted to scope a callback to a single request (so they can pass it a specific handle to a websocket, for example).

## Changes

We've made some changes to our callbacks mechanism to address these issues:

- You can now declare which callbacks you want either in constructor args (which apply to all runs), or passing them directly to the `run` / `call` / `apply` methods that start a run. _Constructor callbacks_ will be used for all calls made on that object, and will be scoped to that object only, i.e. if you pass a handler to the `LLMChain` constructor, it will not be used by the model attached to that chain.
- _Request callbacks_ will be used for that specific request only, and all sub-requests that it contains (eg. a call to an LLMChain triggers a call to a Model, which uses the same handler passed in the `call()` method). These are explicitly passed through. An example to make this more concrete: when a handler is passed through to an `AgentExecutor` via `run`, it will be used for all callbacks related to the agent and all the objects involved in the agent’s execution, in this case, the `Tools`, `LLMChain`, and `LLM`. Previously, to use a callback scoped to particular agent run, that callback manager had to be attached to all nested objects – this was tedious, ugly, and made it hard to re-use objects. See the TypeScript example below:

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

- `_call`, `_generate`, `_run`, and equivalent async methods on Chains / LLMs / Chat Models / Agents / Tools now receive a 2nd argument called `runManager` which is bound to that run, and contains the logging methods that can be used by that object (i.e. `handleLLMNewToken`). This is useful when constructing custom chains, for example, and you can find [more info here](https://python.langchain.com/docs/modules/chains/how_to/custom_chain?ref=blog.langchain.com).
- The `verbose` argument now just serves as a shortcut to add a `ConsoleCallbackHandler` in JS and `StdOutCallbackHandler` in python that prints events to stdout. **It does not control other callbacks**.

Tracing and other callbacks now [_just work_ with concurrency](https://python.langchain.com/docs/modules/callbacks/how_to/tracing?ref=blog.langchain.com). We've also added a context manager to make tracing specific runs even easier.

## Breaking Changes and Deprecations:

- Any code that relied on global callbacks or the global tracer (i.e. `SharedCallbackManager`, `SharedTracer`) outside of LangChain will break in versions >0.0.153 of the python package.
- Attaching a `CallbackManager` to an object is now deprecated, use the `callbacks` argument to pass in a list of handlers.
- The `verbose` flag now only controls `stdout` and `console` callbacks, not other callbacks.

## Inspiration

When we were implementing these improvements to Callbacks we looked at a few existing solutions that ended up influencing the final API, worth calling out:

- The Python `logging` module (and others), which offers a `getChild` method that returns a new logger bound to a certain context. This inspired the new `runManager.getChild()` which you can use when implementing a custom Chain to ensure child runs are tracked correctly.
- Web server frameworks like `express` where all the context specific to each HTTP request is passed around explicitly as function arguments, rather than being available as some sort of global variable.

We also considered the alternative of using some form of async context variables, an implementation of which exists in [Python](https://docs.python.org/3/library/contextvars.html?ref=blog.langchain.com) and in [Node.js](https://nodejs.org/api/async_context.html?ref=blog.langchain.com) (but not in other JS environments). In the end we decided for the explicit function arguments approach because it is easier to debug, and more compatible cross-platform (function args work just about anywhere).

Please let us know if you run into any issues, as this was a large change!

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/callbacks-improvements/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/callbacks-improvements/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/callbacks-improvements/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/callbacks-improvements/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/callbacks-improvements/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/callbacks-improvements/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read