---
title: "What is a \"cognitive architecture\"?"
source: "LangChain Blog"
url: "https://blog.langchain.com/what-is-a-cognitive-architecture/"
date: "2024-07-22"
scraped_at: "2026-03-03T07:58:13.666946304+00:00"
language: "en"
translated: false
description: "The second installment in our \"In the Loop\" series, focusing on what cognitive architecture means."
tags: ["Harrison Chase", "Harrison's Hot Takes"]
---

**_Update: Several readers have pointed out that the term "cognitive architecture" has a_** [**_rich history_**](https://en.wikipedia.org/wiki/Cognitive_architecture?ref=blog.langchain.com) **_in neuroscience and computational cognitive science. Per Wikipedia, "a cognitive architecture refers to both a theory about the structure of the human mind and to a computational instantiation of such a theory". That definition (and corresponding research and articles on the topic) are more comprehensive than any definition I attempt to offer here, and this blog should instead be read as a mapping of my experience building and helping build LLM-powered applications over the past year to this area of research._**

One phrase I’ve used a lot over the past six months (and will likely use more) is “cognitive architecture”. It’s a term I first heard from [Flo Crivello](https://x.com/Altimor?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor&ref=blog.langchain.com) \- all credit for coming up with it goes to him, and I think it's a fantastic term. So what exactly do I mean by this?

What I mean by cognitive architecture is _how your system thinks —_ in other words, the flow of code/prompts/LLM calls that takes user input and performs actions or generates a response.

I like the word “cognitive” because agentic systems rely on using an LLM to reason about what to do.

I like the word “architecture” because these agentic systems still involve a good amount of engineering similar to traditional system architecture.

## Mapping levels of autonomy to cognitive architectures

If we refer back to this slide (originally from [my TED Talk](https://www.ted.com/talks/harrison_chase_the_magical_ai_assistants_of_the_future_and_the_engineering_behind_them?ref=blog.langchain.com)) on the different levels of autonomy in LLM applications, we can see examples of different cognitive architectures.

![](images/what-is-a-cognitive-architecture/img_001.png)

First is just code - everything is hard coded. Not even really a cognitive architecture.

Next is just a single LLM call. Some data preprocessing before and/or after, but a single LLM call makes up the majority of the application. Simple chatbots likely fall into this category.

Next is a chain of LLM calls. This sequence can be either breaking the problem down into different steps, or just serve different purposes. More complex RAG pipelines fall into this category: use a first LLM call to generate a search query, then a second LLM call to generate an answer.

After that, a router. Prior to this, you knew all the steps the application would take _ahead_ of time. Now, you no longer do. The LLM decides which actions to take. This adds in a bit more randomness and unpredictability.

The next level is what I call a state machine. This is combining an LLM doing some routing with a loop. This is even more unpredictable, as by combining the router with a loop, the system could (in theory) invoke an unlimited number of LLM calls.

The final level of autonomy is the level I call an _agent_, or really an “autonomous agent”. With state machines, there are still constraints on which actions can be taken and what flows are executed after that action is taken. With autonomous agents, those guardrails are removed. The system itself starts to decide which steps are available to take and what the instructions are: this can be done by updating the prompts, tools, or code used to power the system.

## **Choosing a cognitive architecture**

When I talk about "choosing a cognitive architecture,” I mean choosing which of these architectures you want to adopt. None of these are strictly “better” than others - they all have their own purpose for different tasks.

When building LLM applications, you’ll probably want to experiment with different cognitive architectures just as frequently as you experiment with prompts. We’re building [LangChain](https://www.langchain.com/langchain?ref=blog.langchain.com) and [LangGraph](https://www.langchain.com/langgraph?ref=blog.langchain.com) to enable that. Most of our development efforts over the past year have gone into building low-level, highly controllable orchestration frameworks (LCEL and LangGraph).

This is a bit of a departure from early LangChain which focused on easy-to-use, off-the-shelf chains. These were great for getting started but tough to customize and experiment with. This was fine early on, as everyone was just trying to get started, but as the space matured, the design pretty quickly hit its limits.

I’m extremely proud of the changes we’ve made over the past year to make LangChain and LangGraph more flexible and customizable. If you’ve only ever used LangChain through the high level wrappers, check out the low-level bits. They are much more customizable, and will really let you control the cognitive architecture of your application.

_If you’re building straight-forward chains and retrieval flows, check out LangChain in_ [_Python_](https://python.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _and_ [_JavaScript_](https://js.langchain.com/v0.2/docs/introduction/?ref=blog.langchain.com) _. For more complex agentic workflows, try out LangGraph in_ [_Python_](https://langchain-ai.github.io/langgraph/tutorials/introduction/?ref=blog.langchain.com) _and_ [_JavaScript_](https://langchain-ai.github.io/langgraphjs/tutorials/quickstart/?ref=blog.langchain.com) _._

### Tags

[Harrison Chase](https://blog.langchain.com/tag/harrison-chase/) [Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/)



[![On Agent Frameworks and Agent Observability](images/what-is-a-cognitive-architecture/img_002.png)](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[**On Agent Frameworks and Agent Observability**](https://blog.langchain.com/on-agent-frameworks-and-agent-observability/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read

[![From Traces to Insights: Understanding Agent Behavior at Scale](images/what-is-a-cognitive-architecture/img_003.png)](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[**From Traces to Insights: Understanding Agent Behavior at Scale**](https://blog.langchain.com/from-traces-to-insights-understanding-agent-behavior-at-scale/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![In software, the code documents the app. In AI, the traces do.](images/what-is-a-cognitive-architecture/img_004.png)](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[**In software, the code documents the app. In AI, the traces do.**](https://blog.langchain.com/in-software-the-code-documents-the-app-in-ai-the-traces-do/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 5 min read

[![Agent Frameworks, Runtimes, and Harnesses- oh my!](images/what-is-a-cognitive-architecture/img_005.png)](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[**Agent Frameworks, Runtimes, and Harnesses- oh my!**](https://blog.langchain.com/agent-frameworks-runtimes-and-harnesses-oh-my/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 3 min read

[![Reflections on Three Years of Building LangChain](images/what-is-a-cognitive-architecture/img_006.png)](https://blog.langchain.com/three-years-langchain/)

[**Reflections on Three Years of Building LangChain**](https://blog.langchain.com/three-years-langchain/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 6 min read

[![Not Another Workflow Builder](images/what-is-a-cognitive-architecture/img_007.webp)](https://blog.langchain.com/not-another-workflow-builder/)

[**Not Another Workflow Builder**](https://blog.langchain.com/not-another-workflow-builder/)

[Harrison's Hot Takes](https://blog.langchain.com/tag/in-the-loop/) 4 min read