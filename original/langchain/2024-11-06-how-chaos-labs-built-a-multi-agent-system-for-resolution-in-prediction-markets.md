---
title: "How Chaos Labs built a multi-agent system for resolution in prediction markets"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/"
date: "2024-11-06"
scraped_at: "2026-03-03T07:50:15.028854144+00:00"
language: "en"
translated: false
---

**_Editor's Note: one of the most common use cases we've seen for LangGraph is complex research agents. This guest blog post by_** [**_Chaos Labs_**](https://chaoslabs.xyz/?ref=blog.langchain.com) **_highlights a great example of that. It utilizes multiple sources and complex architecture to do research that would power resolution in prediction markets. For those unfamiliar with prediction markets: prediction markets are resolved via an "oracle" that determines outcomes and resolves bets. Edge AI Oracle is an LLM based system that does just that._**

Today, we’re excited to announce the **alpha release of Edge AI Oracle**. Built using the latest advancements in LLMs, Edge AI Oracle orchestrates a multi-agent council, built on LangChain and LangGraph, that maximizes objectivity, transparency, and efficiency in **query resolution**. A core initial application of this is for **prediction markets**.


/1:28

1×

### How Edge AI Oracle Works

**Edge AI** enables precise, traceable, and reliable resolutions on virtually any topic, from _“Who won the election?”_ to _“How many goals did Messi score?”_ and _“Who are the latest Nobel Prize winners?”_ Unlike traditional oracles, Edge AI Oracle processes each query through an **AI Oracle Council**—a decentralized network of agents powered by diverse models from providers like OpenAI, Anthropic, and Meta. This architecture ensures each resolution is objective, accurate, and fully explainable, making it ideal for high-stakes prediction markets.

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_001.png)

This decentralized model allows Edge AI to sidestep the limitations and bias of single-model solutions, providing a multi-perspective, bias-filtered approach to query resolution.

For the Wintermute Election market, we’ve set the Council to require unanimous agreement with over 95% confidence from each Oracle AI Agent.

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_002.png)

Consensus requirements are fully configurable on a per-market basis, and with the upcoming Beta release, developers and market creators will have autonomous control over these settings.

# Architecture: Decentralized AI Oracle Council and Multi-Agent Orchestration

The architecture of Edge AI Oracle is built to tackle three fundamental challenges of truth-seeking oracles:

- **Prompt Optimization**
- **Single Model Bias**
- **Retrieval Augmented Generation (RAG)**.

Hosted on the **Edge Oracle Network** and powered by LangChain and LangGraph, the system leverages advanced multi-agent orchestration to enhance query accuracy and reliability.

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_003.png)

**Entry Point - Research Analyst**: The workflow begins with the _research\_analyst_, which reviews the query, identifying key data points and required sources.

**Web Scraper**: The query is then passed to the _web\_scraper_, which retrieves data from external sources and databases and prioritizes reputable, verified information.

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_004.png)

**Document Relevance Analyst**: The _document\_bias\_analyst_ reviews the gathered data, applying filters and checking for bias, ensuring the data pool remains neutral and credible.

![](images/how-chaos-labs-built-a-multi-agent-system-for-resolution-in-prediction-markets/img_005.png)

**Report Writer**: The _report\_writer_ synthesizes findings into a cohesive report, presenting an initial answer based on the research and analysis conducted.

**Summarizer**: The _summarizer_ condenses the report, distilling the key insights and findings into a concise form suitable for final processing.

**Classifier**: Finally, the _classifier_ evaluates the summarized output, categorizing and validating it against preset criteria before reaching the END of the workflow.

Each stage is executed sequentially, ensuring that data flows systematically from one agent to the next, enhancing transparency and accuracy in query resolution.

# LangChain and LangGraph: Multi-Agent Orchestration Framework

**LangChain** and **LangGraph** form the core of Edge AI Oracle’s multi-agent system, making it possible to orchestrate complex, stateful interactions and optimize query resolution. With **LangChain’s adaptable components**—from prompt templates to retrieval tools and output parsers—each Oracle agent can handle tasks independently while seamlessly integrating with other agents in the workflow. **LangGraph** then builds on this structure by enabling directed, cyclical workflows across agents, ensuring a well-coordinated, step-by-step process that is critical to achieving high accuracy and transparency in data resolution.

- **LangChain Components**: LangChain supplies the essential building blocks to retrieve, organize, and structure data within each agent, allowing us to maintain high-quality, bias-filtered responses. Importantly, LangChain serves as a flexible gateway to multiple frontier models, providing a unified API and interface that simplifies extending support to various LLMs. This capability empowers Edge AI Oracle to leverage a diverse set of LLMs, ensuring balanced perspectives within the Oracle Council while minimizing individual model biases.
- **LangGraph Workflow**: LangGraph’s graph-based structure and stateful interactions enable the precise **multi-agent orchestration** that powers the Decentralized AI Oracle Council. A directed, cyclical workflow allows each agent to build on the work of others, coordinating Oracle agents from initial research to final consensus in a structured flow:
  - **Workflow Breakdown**:
    - The workflow begins with the _research\_analyst_ node, where initial data gathering and query parsing occur.
    - The agent moves to the _web\_scraper_, gathering relevant, reputable data from external sources.
    - A _document\_bias\_analyst_ then filters out any potential biases within the retrieved data.
    - This leads to the _report\_writer_, who synthesizes findings into a coherent report.
    - Finally, a _summarizer_ distills the report into concise conclusions, which the _classifier_ evaluates before reaching the workflow’s END.

**See the graphics above for more insight as to how these steps work.**

Through LangGraph’s edge-based orchestration, each task is smoothly handed off to the next, ensuring a cohesive and logical resolution process.

### Building the Future of Truth-Seeking AI Oracles

The alpha release of Edge AI Oracle marks a significant leap forward in developing a reliable, objective Oracle system. With the latest innovations in LangChain and LangGraph, Edge AI Oracle is poised to transform blockchain security, prediction markets, and decentralized data applications by providing a scalable, multi-agent, truth-seeking Oracle.

Read more about Chaos Labs [here](https://chaoslabs.xyz/?ref=blog.langchain.com).