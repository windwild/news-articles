---
title: "Why you should outsource your agentic infrastructure, but own your cognitive architecture"
source: "LangChain Blog"
url: "https://blog.langchain.com/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-architecture/"
date: "2024-08-07"
scraped_at: "2026-03-03T07:56:26.332706258+00:00"
language: "en"
translated: false
description: "In this third installment in our \"In The Loop\" series, learn why you should tailor your cognitive architecture to be application-specific, alongside running better infrastructure for your agentic apps..."
tags: ["Harrison Chase", "Harrison's Hot Takes"]
---

When OpenAI Assistants API came out, it was a bold step towards the future of agents. It moved OpenAI from a company producing LLM APIs to a company producing Agent APIs.

There are several things that I think the OpenAI Assistants API got right - it introduced a lot of new and helpful infrastructure specifically aimed at running agentic applications. At the same time, it limits what “ [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/)” can be built on top of it for really complex (and valuable!) agents.

This shows off the difference between “agentic infrastructure” and “ [cognitive architectures](https://blog.langchain.com/what-is-a-cognitive-architecture/)”. Jeff Bezos has the brilliant quote: “ [Focus on what makes your beer taste better](https://www.acquired.fm/episodes/amazon-com?ref=blog.langchain.com)”. If we take this metaphor and apply it to companies building agents:

💡

Agentic infrastructure does not make your beer taste better

💡

Cognitive architectures absolutely make your beer taste better

## The need for agentic infrastructure

OpenAI was pretty spot on in that developers want better infrastructure for running agentic applications. In particular:

- The ability to “configure” assistants with a prompt and tools made it easy to get started and create different agents
- The ability to run assistants as background runs made it easier to manage longer running workflows
- The built-in persistence of messages made it easy to manage state

All of these things are things that developers shouldn’t really have to think about. None of these things make your application differentiated - in Jeff Bezos’s words, they don’t make your beer taste better.

There is still even more infrastructure that can be built to assist developers! In OpenAI Assistants AI, you currently can’t run multiple runs on the same thread. You can’t easily modify the state of a thread. Still - the Assistants API was a fantastic step in the right direction.

## The importance of an application-specific cognitive architecture

The issue with the Assistants API is that it is too limiting in what you can easily build on top of it.

If you are looking to build a chatbot - fantastic! The “state” of a thread is a list of messages, perfect for that.

If you are looking to build a simple ReAct style agent - great! It also probably works well for that - basically just running an LLM in a `while` loop.

But agentic applications are more than just a single chat model invoking the same tools with the same prompt over and over again. They have more complex state that they track than just a list of messages. This control over the state and flow of an application is _crucial_ for bringing any semblance of reliability to agents.

From working with thousands of builders, we see that the agents making their way to production all have slightly different cognitive architectures. The cognitive architecture of an application is how you get it **to really work well** \- this is where teams are innovating. This is what they are building to make their application differentiated - to make their beer taste better.

This isn’t to say you _can’t_ do more complex things with the Assistants API. You probably can. But the API doesn’t make it easy. It doesn’t want you to. OpenAI made a bet on a generic cognitive architecture, which in turn makes it hard to build the application-specific cognitive architectures that are needed to make agents reliable.

## Why do we care?

Why do I care so much? Why am I writing so many words on this? It’s because I actually think OpenAI got a lot of things right, and they took a stance early in the market that there is a need for agentic infrastructure. They made it easy for developers not to worry about where to store the state of their agents, how to manage a task queue, etc — which is fantastic.

Our goal at LangChain is to make it as easy as possible to build agentic applications. This type of infrastructure is absolutely part of what is needed.

We want to bring the benefits of that agentic infrastructure and marry it with the control that LangGraph gives you over your cognitive architecture. That’s why we built LangGraph Cloud. Write your custom cognitive architecture with [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com), then deploy it with [LangGraph Cloud](https://blog.langchain.com/langgraph-cloud/) and get all the benefits of this agentic infrastructure.

LangGraph Cloud provides fault-tolerant scalability, optimized for real-world interactions. We designed it to have horizontally-scaling task queues and servers, a built-in persistence layer optimized for heavy loads, and configurable caching of nodes across runs. This lets you own the differentiating parts of your application and outsource the rest.

In conclusion, focus on what makes your beer taste better: cognitive architectures, not infrastructure.

### Tags

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)



[![On Agent Frameworks and Agent Observability](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_001.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_002.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![In software, the code documents the app. In AI, the traces do.](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_003.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_004.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[![Reflections on Three Years of Building LangChain](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_005.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[![Not Another Workflow Builder](images/why-you-should-outsource-your-agentic-infrastructure-but-own-your-cognitive-arch/img_006.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read