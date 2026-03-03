---
title: "LangChainHub"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchainhub/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:55:28.227205532+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

We are excited to announce the launch of the [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com), a place where you can find and submit commonly used prompts, chains, agents, and more!

This obviously draws a lot of inspiration from Hugging Face's Hub, which we believe has done an incredible job of fostering an amazing community.

## Motivation

Over the past few months, we’ve seen the LangChain community build a staggering number of applications using the framework. These applications use LangChain components such as prompts, LLMs, chains and agents as building blocks to create unique workflows. We wanted to make it easy to share and discover these workflows by creating a hub where users can share the components they’ve created.

Our goal with LangChainHub is to be a single stop shop for sharing prompts, chains, agents and more. As a starting point, we’re launching the hub with a repository of prompts used in LangChain. Often, the secret sauce of getting good results from an LLM is high-quality prompting, and we believe that having a collection of commonly-used prompts will make it easier for users to get great results without needing to reinvent the wheel. We hope to follow up by adding support for chains and agents shortly.

## Usage

We don't just want to build a collection of prompts, agents, and chains - we want to make it as easy and as straightforward as possible for people to actually use these. To that end, we are taking two concrete steps:

1. We will offer first-class support in the [LangChain Python library](https://github.com/hwchase17/langchain?ref=blog.langchain.com) for loading these artifacts. For example, you are able to easily load a prompt from the hub with the following snippet:

```python
from langchain.prompts import load_prompt
prompt = load_prompt('lc://prompts/hello-world/prompt.yaml')
```

2\. We will prioritize clear documentation on how to use these artifacts. For example, all prompts contain not only the artifact itself but also a README file. This file contains information like a description of how it is to be used, the inputs it expects, and a code snippet for how to use this prompt in a chain.

For more detailed information on how to use the artifacts on the Hub, check out the documentation on the [Hub itself](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com).

## Community

We highly intend this to be community driven. We have seeded the Hub with a collection of artifacts that are used in the core library, but we hope it quickly becomes filled with prompts, chains, and agents that are NOT in the core library.

Since we are using GitHub to organize this Hub, adding artifacts can best be done in one of two ways:

1. Create a fork and then open a PR against the repo.
2. Create an issue on the repo with details of the artifact you would like to add.

### Up Next

Today, LangChainHub contains all of the prompts available in the main `LangChain` Python library.

In the (hopefully near) future, we plan to add:

- Chains: A collection of chains capturing various LLM workflows
- Agents: A collection of agent configurations, including the underlying LLMChain as well as which tools it is compatible with.
- Custom prompts repo URI: The ability to set a custom [URI](https://www.techtarget.com/whatis/definition/URI-Uniform-Resource-Identifier?amp=1&ref=blog.langchain.com) for prompt repositories, so that users can create their own LangChain hubs.

## Conclusion

We are looking forward to the community's contributions and feedback as we continue to build out the Hub. Check it out [here](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com) and join the conversation on [Discord](https://discord.com/invite/6adMQxSpJS?ref=blog.langchain.com)!

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](https://blog.langchain.com/content/images/size/w760/format/webp/2025/12/Evaluating-Deep-Agents.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](https://blog.langchain.com/content/images/size/w760/format/webp/2025/03/Theme-Fractal-Matrix--Format-Blog--Colour-Green--Text-Alignment-Centred--With-Image-Text-Only.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/langchainhub/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/langchainhub/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/langchainhub/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchainhub/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read