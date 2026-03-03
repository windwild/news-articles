---
title: "LangGraph: Multi-Agent Workflows"
source: "LangChain Blog"
url: "https://blog.langchain.com/langgraph-multi-agent-workflows/"
date: "2025-02-26"
scraped_at: "2026-03-03T07:38:35.995827349+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

**Links**

- [Python Examples](https://github.com/langchain-ai/langgraph/tree/main/examples/multi_agent?ref=blog.langchain.com)
- [JS Examples](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent?ref=blog.langchain.com)
- [YouTube](https://youtu.be/hvAPnpSfSGo?ref=blog.langchain.com)

Last week we highlighted [LangGraph](https://blog.langchain.com/langgraph/) \- a new package (available in both [Python](https://pypi.org/project/langgraph/?ref=blog.langchain.com) and [JS](https://www.npmjs.com/package/@langchain/langgraph?ref=blog.langchain.com)) to better enable creation of LLM workflows containing _cycles_, which are a critical component of most agent runtimes. As a part of the launch, we highlighted two simple runtimes: one that is the equivalent of the AgentExecutor in `langchain`, and a second that was a version of that aimed at message passing and chat models.

Today, we're excited to highlight a second set of use cases for `langgraph` \- multi-agent workflows. In this blog we will cover:

- What does "multi-agent" mean?
- Why are "multi-agent" workflows interesting?
- Three concrete examples of using LangGraph for multi-agent workflows
- Two examples of third-party applications built on top of LangGraph using multi-agent workflows (GPT-Newspaper and CrewAI)
- Comparison to other frameworks (Autogen and CrewAI)

## What is "multi-agent"?

💡

When we are talking about "multi-agent", we are talking about **multiple independent actors** **powered by language models** **connected in a specific way**.

Each agent can have its own prompt, LLM, tools, and other custom code to best collaborate with the other agents.

That means there are two main considerations when thinking about different multi-agent workflows:

1. What are the multiple independent agents?
2. How are those agents connected?

This thinking lends itself incredibly well to a graph representation, such as that provided by `langgraph`. In this approach, each agent is a node in the graph, and their connections are represented as an edge. The control flow is managed by edges, and they communicate by adding to the graph's state.

Note: a very related concept here is the concept of _state machines,_ which we explicitly called out as a category of cognitive architectures. When viewed in this way, the independent agent nodes become the states, and how those agents are connected is the transition matrices. [Since a state machine can be viewed as a labeled, directed graph](https://www.cs.cornell.edu/courses/cs211/2006sp/Lectures/L26-MoreGraphs/state_mach.html?ref=blog.langchain.com#:~:text=State%20machine%20as%20a%20graph,labeled%20with%20the%20corresponding%20events.), we will think of these things in the same way.

## Benefits of multi-agent designs

"If one agent can't work well, then why is multi-agent useful?"

- Grouping tools/responsibilities can give better results. An agent is more likely to succeed on a focused task than if it has to select from dozens of tools.
- Separate prompts can give better results. Each prompt can have its own instructions and few-shot examples. Each agent could even be powered by a separate fine-tuned LLM!
- Helpful conceptual model to develop. You can evaluate and improve each agent individually without breaking the larger application.

Multi-agent designs allow you to divide complicated problems into tractable units of work that can be targeted by specialized agents and LLM programs.

## Multi-agent examples

We've added three separate example of multi-agent workflows to the `langgraph` repo. Each of these has slightly different answers for the above two questions, which we will go over when we highlight the examples. It's important to note that these three examples are only a few of the possible examples we could highlight - there are almost assuredly other examples out there and we look forward to seeing what the community comes up with!

### Multi Agent Collaboration

**Code links**:

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/multi-agent-collaboration.ipynb?ref=blog.langchain.com)

In this example, the different agents collaborate on a **shared** scratchpad of messages. This means that all the work either of them do is visible to the other. This has the benefit that other agents can see all the individual steps done. This has the downside that sometimes is it overly verbose and unnecessary to pass ALL this information along, and sometimes only the final answer from an agent is needed. We call this **collaboration** because of the shared nature the scratchpad.

**What are the multiple independent agents?**

In this case, the independent agents are actually just a single LLM call. Specifically, they are a specific prompt template (to format inputs in a specific way with a specific system message) plus an LLM call.

**How are those agents connected?**

Here is a visualization of how these agents are connected:

![](images/langgraph-multi-agent-workflows/img_001.png)

The main thing controlling the state transitions is the _router_, but it is a rule-based router and so is rather quite simple. Basically, after each LLM call it looks at the output. If a tool is invoked, then it calls that tool. If no tool is called and the LLM responds "FINAL ANSWER" then it returns to the user. Otherwise (if no tool is called and the LLM does not respond "FINAL ANSWER") then it goes to the other LLM.

### Agent Supervisor

**Examples:**

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/agent_supervisor.ipynb?ref=blog.langchain.com)

In this example, multiple agents are connected, but compared to above they do NOT share a shared scratchpad. Rather, they have their own independent scratchpads, and then their final responses are appended to a global scratchpad.

**What are the multiple independent agents?**

In this case, the independent agents are a LangChain agent. This means they have their own individual prompt, LLM, and tools. When called, it's not just a single LLM call, but rather a run of the AgentExecutor.

**How are those agents connected?**

An **agent supervisor** is responsible for routing to individual agents.

![](images/langgraph-multi-agent-workflows/img_002.png)

In this way, the supervisor can also be thought of an agent whose tools are other agents!

### Hierarchical Agent Teams

**Examples:**

- [Python](https://github.com/langchain-ai/langgraph/blob/main/examples/multi_agent/hierarchical_agent_teams.ipynb?ref=blog.langchain.com)
- [JS](https://github.com/langchain-ai/langgraphjs/blob/main/examples/multi_agent/hierarchical_agent_teams.ipynb?ref=blog.langchain.com)

This is similar to the above example, but now the agents in the nodes are actually other `langgraph` objects themselves. This provides even more flexibility than using LangChain AgentExecutor as the agent runtime. We call this _hierarchical teams_ because the subagents can in a way be thought of as teams.

**What are the multiple independent agents?**

These are now other `langgraph` agents.

**How are those agents connected?**

A supervisor agent connects them.

![](images/langgraph-multi-agent-workflows/img_003.png)

## YouTube Walkthrough

We've added a YouTube video to walk through these three examples. Hopefully this helps makes these complex topics a little easier to understand!

## Third Party Applications

As part of this launch, we're also excited to highlight a few applications built on top of LangGraph that utilize the concept of multiple agents.

### [GPT-Newspaper](https://github.com/assafelovic/gpt-newspaper?ref=blog.langchain.com)

This is a new project by the minds by [GPT-Researcher](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com). GPT-Newspaper is an innovative autonomous agent designed to create personalized newspapers tailored to user preferences. GPT Newspaper revolutionizes the way we consume news by leveraging the power of AI to curate, write, design, and edit content based on individual tastes and interests. The architecture consists of six specialized sub-agents. There is one key step - a writer <> critique loop which adds in a helpful cycle.

![](images/langgraph-multi-agent-workflows/img_004.png)

## Other Frameworks

LangGraph is not the first framework to support multi-agent workflows. Most of the difference between these frameworks largely lies in the mental models and concepts they introduce.

### Autogen

Autogen emerged as perhaps the first multi-agent framework. The biggest difference in mental model between LangGraph and Autogen is in construction of the agents. LangGraph prefers an approach where you explicitly define different agents and transition probabilities, preferring to represent it as a graph. Autogen frames it more as a "conversation". We believe that this "graph" framing makes it more intuitive and provides better developer experience for constructing more complex and opinionated workflows where you really want to control the transition probabilities between nodes. It also supports workflows that _aren't_ explicitly captured by "conversations."

Another key difference between Autogen and LangGraph is that LangGraph is fully integrated into the LangChain ecosystem, meaning you take fully advantage of all the LangChain integrations and LangSmith observability.

### CrewAI

Another key framework we want to highlight is CrewAI. CrewAI has emerged recently as a popular way to create multi-agent "teams". Compared to LangGraph, CrewAI is a higher-level framework, while LangGraph gives much more lower-level controllability over your agents.

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/langgraph-multi-agent-workflows/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langgraph-multi-agent-workflows/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/langgraph-multi-agent-workflows/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/langgraph-multi-agent-workflows/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/langgraph-multi-agent-workflows/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langgraph-multi-agent-workflows/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read