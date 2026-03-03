---
title: "Plan-and-Execute Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/plan-and-execute-agents/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:02:17.286910647+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

**TL;DR: We’re introducing a new type of agent executor, which we’re calling “Plan-and-Execute”. This is to contrast against the previous types of agent we supported, which we’re calling “Action” agents. Plan-and-Execute agents are heavily inspired by [BabyAGI](https://github.com/yoheinakajima/babyagi?ref=blog.langchain.com) and the recent [Plan-and-Solve](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2305.xml?ref=blog.langchain.com) paper. We think Plan-and-Execute is great for more complex long term planning, at the cost of more calls to the language model. We're putting the initial version of this in the `experimental` module as we expect rapid changes.**

**Links:**

- **[Python Documentation](https://python.langchain.com/docs/modules/agents/agent_types/plan_and_execute?ref=blog.langchain.com)**
- **[JS/TS Documentation](https://js.langchain.com/docs/modules/agents/agents/examples/plan_and_execute_agent?ref=blog.langchain.com)**

Up until now, all agents in LangChain followed the framework pioneered by the ReAct paper. Let’s call these “Action Agents”. The algorithm for these can roughly be expressed in the following pseudo-code:

- Some user input is received
- The agent decides which tool - if any - to use, and what the input to that tool should be
- That tool is then called with that tool input, and an observation is recorded (this is just the output of calling that tool with that tool input)
- That history of tool, tool input, and observation is passed back into the agent, and it decides what step to take next
- This is repeated until the agent decides it no longer needs to use a tool, and then it responds directly to the user.

This style has worked well up until now, but several things are changing which present some cracks in this algorithm:

- User objectives are becoming more complex
- Developers and organizations are starting to rely on agents in production

These have the dual effects of wanting agentic systems to be able to handle more complex requests yet also be more reliable. These two factors are combining to rapidly cause prompt sizes to increase:

- As objectives are more complex, more and more past history is being included to keep the agent focused on the final objective while also allowing it to remember and reason about previous steps
- As developers try to increase reliability they are including more instructions around how to use tools

The need for increasingly complex abilities and increased reliability are causing issues when working with most language models.

## Plan-and-Execute Implementation

In that vein we’ve seen a new style of agent frameworks pop up. These agent frameworks attempt to separate higher level planning from shorter term execution. Specifically, they first plan steps to take, and then iteratively execute on those steps. There are of course a few interesting variants on this core algorithm (which we can talk about later). The pseudo-code for these agents, which we’re calling “Plan-and-Execute” agents, looks like:

- Plan steps to take
- For step in steps: determine the proper tools or other best course of action to accomplish that step

This is the core agent framework which is implemented in Python and TypeScript. This agent framework relies on two things: a planner and an executor.

Let’s talk about the planner first. This almost always should be a language model. This will utilize the language model’s reasoning ability to plan out what to do and deal with ambiguity/edge cases. We can add on an output parser at the end to parse the raw LLM output into a list of strings (each string being a step).

Now let’s talk about the executor. In our initial implementation we’ve made this an Action Agent. This allows for the executor agent to take in a high level objective (a single step) and figure out which tools to use to accomplish that (could be done in one step or two).

This approach has several benefits. It separates out planning from execution - this allows one LLM to focus exclusively on planning, and another to focus on execution. This allows for more reliability on both fronts. This also makes it easier in the future to swap out these components for smaller fine tuned models. The major downside of this approach is that it takes a lot more calls. However, due to the separation of concerns we’re hopeful that these calls can be to smaller (and therefore faster and cheaper) models.

## Future Directions

We think this is just the start of plan-and-execute agents. Future directions include:

- Better support for long sequences of steps. Right now the previous steps are passed around as a list - as planning steps getting longer and longer, we’ll want to store this in a vectorstore and retrieve intermediate steps
- Revisiting plans. Right now there is one planning step at the start, but then that is never revisited. It is likely we will want to have some mechanism for revisiting and adjusting the plan, either every step or as needed.
- Evaluation. Right now, a lot of these improvements are largely theoretical, or at the very least not benchmarked. We hope to have more rigorous ways of evaluating agent frameworks.
- Selection of execution chain. Right now, there is a single execution chain. It could easily be the case that you would want multiple execution chains, and the planner can specify which one to use. For example, if you have one execution chain optimized for web research, one for analysis, etc.

It should be noted that for many of these future directions we can draw inspiration from existing work. For example, BabyAGI already uses a vectorstore to store intermediate steps and also revisits planning each iteration. The Plan-and-Solve paper does more rigorous evaluation of outputs with benchmarks.

## Conclusion

We were really excited to see this new agent paradigm pop up in BabyAGI (we highlighted this as one of the big differentiators in our post a few weeks ago). We were equally excited to see the Plan-and-Solve paper emerge as a rigorous evaluation of similar ideas. We look forward to seeing how the Plan-and-Execute approach evolves - try it out [here (Python)](https://python.langchain.com/docs/modules/agents/agent_types/plan_and_execute?ref=blog.langchain.com) or [here (JS)](https://js.langchain.com/docs/modules/agents/agents/examples/plan_and_execute_agent?ref=blog.langchain.com).

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/plan-and-execute-agents/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/plan-and-execute-agents/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/plan-and-execute-agents/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/plan-and-execute-agents/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/plan-and-execute-agents/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/plan-and-execute-agents/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read