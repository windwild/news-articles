---
title: "On Agent Frameworks and Agent Observability"
source: "LangChain Blog"
url: "https://blog.langchain.com/on-agent-frameworks-and-agent-observability/"
date: "2026-02-13"
scraped_at: "2026-03-02T10:08:09.570506268+00:00"
language: "en"
translated: false
description: "Every time LLMs get better, the same question comes back: &quot;Do you still need an agent framework?&quot; It&apos;s a fair question. The best way to build agents changes as the models get more perfo..."
tags: ["Harrison's Hot Takes"]
---

Every time LLMs get better, the same question comes back: "Do you still need an agent framework?" It's a fair question. The best way to build agents changes as the models get more performant and evolve, but fundamentally, the agent is a system _around_ the model, so they will not disappear – they just need to evolve too.We've now built three generations of agent frameworks, and each one looked different from the last. So here's what we believe:

1. Agent frameworks are still useful, but only if they evolve as fast as the models do.
2. Agent observability should work no matter how you build. That’s why LangSmith works even if you don’t use our open source (LangChain or LangGraph).

This post is about both of those bets.

**Why agent frameworks are still relevant in 2026**

Agent patterns have moved from chaining to workflow orchestration to tool-calling-in-a-loop with file-systems and memory. We’ve built frameworks for them all and believe each has its place based on your use case. Here’s how they’ve evolved:

### Chaining

The original **langchain** got popular in 2023 because few people knew how to make practical use of LLMs. The framework offered one of the easiest ways to connect foundation models to your data or APIs through a set of integrations and core abstractions. It was arguably too opinionated at the start — more of an "easy button" for learning about prompting and RAG than a production-ready tool. As the first wave of generative AI started to settle by that summer, criticism that agent frameworks were pointless grew louder.

We heard the criticism, but it was hard to square with what we were seeing in actual usage. The vast majority of teams building LLM apps needed ways to move faster than going it completely alone. Good frameworks:

- Encode best practices into the framework itself
- Reduce boilerplate code
- Make it easier to reach a higher level of quality
- Create standards and readability across large teams
- Pave a cleaner path to production

So we doubled down. On a different framework.

### Orchestration and run-time

**langgraph** was lower level and more flexible. It included a runtime that supported durability and statefulness, which turned out to be important for human-agent and agent-agent collaboration. It addressed many of the control concerns people had raised about **langchain**. We did eventually rewrite the original **langchain** in 2025 to be more streamlined, but we also recognized that different problems need different tools.

### Harness

More recently, we built **deepagents**: a batteries-included agent harness that's more performant and more flexible. It supports planning for long-horizon tasks, tool-calling-in-a-loop, context offloading to a filesystem, and subagent orchestration. An agent harness works now because LLMs are getting better at reasoning and you can delegate more decisions to the LLM vs. hard coding as many orchestration patterns. It's most similar in concept to Claude Agent SDK, but model-agnostic. To our knowledge, it's the only agent harness that is not tied to any specific LLM or application stack.

Today, we recommend these different frameworks for different use cases. **langchain and deepagents** are built on top of **langgraph’s** runtime for long running execution.

![](images/on-agent-frameworks-and-agent-observability/img_001.png)

It sounds dramatic, but we’ve seen three generations of agents in three years: what started as RAG became agentic workflows, which evolved into more autonomous tool-calling-in-a-loop agents.

The biggest knock against frameworks is that the AI space evolves too quickly for standards to form. There's truth to that. But we also believe that sitting out of the AI game waiting for things to settle is a losing strategy. Frameworks help you dive in, build faster, and increase your odds of success. Even knowing that, the tools will keep changing. And you also don’t need a framework for everything. If it’s a simple LLM request, adding a framework may be too heavy handed.

## **Why LangSmith is independent from LangChain open source**

Early on, we recognized that [quality](https://www.langchain.com/state-of-agent-engineering?ref=blog.langchain.com#biggest-barriers-to-production) was the biggest barrier to getting agents into production. We believed, and still do, that purpose-built agent observability and evals were a required part of the toolkit.

We called it [LangSmith](https://www.langchain.com/langsmith/observability?ref=blog.langchain.com), because we had the intuition that there wouldn't be only one agent framework. And even if there were a dominant one, it would have to evolve at a pace that would make early versions unrecognizable. We acknowledged not everyone would use our frameworks, but wanted them still to be able to use this platform.

So we built LangSmith to work regardless of whether you used **langchain**, any of our other frameworks, or nothing at all. This wasn't an obvious decision at the time. We drew inspiration from companies like Vercel, which supports many frontend frameworks beyond their own [Next.js](http://next.js/?ref=blog.langchain.com).

Today, LangSmith integrates with [a number of frameworks out of the box](https://docs.langchain.com/langsmith/integrations?ref=blog.langchain.com) — AutoGen, Claude Agent SDK, CrewAI, Mastra, OpenAI Agents, PydanticAI, Vercel AI SDK, and more. It supports OpenTelemetry-based tracing, so anything that emits the OTEL spec can be ingested by LangSmith. And it works with agents built using no framework at all. Many LangSmith customers, including Clay, Harvey, and Vanta, don't use our open source frameworks but rely on LangSmith for observability and evals.

## **Building and testing converge in agent engineering**

Regardless of your agent framework, traces are critical to understanding agent behavior. We've been writing about [how important the agent trace](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/) is because it's the foundation for agent debugging, monitoring, evals, and more. With agents, your app logic is documented in traces, not code. Building the agent is only the first step. Agents are non-deterministic systems, so you have no idea what inputs or outputs to expect until you ship it. That’s why debugging, testing, and monitoring are critical parts of [agent engineering](https://blog.langchain.com/agent-engineering-a-new-discipline/) and the building process itself.

So if you’re not using our OSS frameworks, we’d like to hear why! But, don’t let it stop you from figuring out how and why your agent is failing with LangSmith.

### Tags

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)



[![From Traces to Insights: Understanding Agent Behavior at Scale](images/on-agent-frameworks-and-agent-observability/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![In software, the code documents the app. In AI, the traces do.](images/on-agent-frameworks-and-agent-observability/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/on-agent-frameworks-and-agent-observability/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[![Reflections on Three Years of Building LangChain](images/on-agent-frameworks-and-agent-observability/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[![Not Another Workflow Builder](images/on-agent-frameworks-and-agent-observability/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[![Deep Agents](images/on-agent-frameworks-and-agent-observability/img_007.png)](https://blog.langchain.com/deep-agents/)

[**Deep Agents**](https://blog.langchain.com/deep-agents/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read