---
title: "Prompt Selectors"
source: "LangChain Blog"
url: "https://blog.langchain.com/prompt-selectors/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:58:17.773874357+00:00"
language: "en"
translated: false
tags: ["By LangChain"]
---

One common complaint we've heard is that the default prompt templates do not work equally well for all models. This became especially pronounced this past week when OpenAI released a ChatGPT API. This new API had a completely new interface ( [which required new abstractions](https://blog.langchain.com/chat-models/)) and as a result many users noticed issues with old prompts no longer working. Although we quickly added support for this model, many users noticed that prompt templates that worked well for GPT-3 did not work well in the chat setting.

All chains expose ways to customize these prompt templates, so there's always the option to let users pass in prompts that work better. But we want to do better than that. One goal of having chains with default prompt templates is to offer functionality that "Just Works" out of the box. If different models expect different types of prompts, this breaks down.

Our solution for this is to introduce a concept of a `PromptSelector`. Rather than define a default `PromptTemplate` for each chain, we will move towards defining a `PromptSelector` for each chain. If no prompt is specified by the user, the `PromptSelector` will select a `PromptTemplate` to use based on the model that is passed in.

For an example of this in action, check out the following examples:

### Python

[Code Definition](https://github.com/hwchase17/langchain/blob/master/langchain/chains/prompt_selector.py?ref=blog.langchain.com)

[Full Example](https://github.com/hwchase17/langchain/blob/master/langchain/chains/question_answering/stuff_prompt.py?ref=blog.langchain.com)

Snippet:

```python
PROMPT_SELECTOR = ConditionalPromptSelector(
    default_prompt=PROMPT, conditionals=[(is_chat_model, CHAT_PROMPT)]
)
```

### In JS/TS:

[Code Definition](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/prompt_selector.ts?ref=blog.langchain.com)

[Full Example](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/question_answering/stuff_prompts.ts?ref=blog.langchain.com)

Snippet:

```typescript
export const QA_PROMPT_SELECTOR = new ConditionalPromptSelector(
  DEFAULT_QA_PROMPT,
  [[isChatModel, CHAT_PROMPT]]
);
```

Both these examples show the same thing. We define a default prompt, but then if a condition (\`isChatModel\`) is met we switch to a different prompt. This is also extendable to an arbitrary list of "conditions" and corresponding prompts"

This is a very simple concept, but we hope it gives us (and other developers) the flexibility to define chains that "Just Work" out of the box for any model. Although the immediate use case is for switching between prompts for ChatModels (like ChatGPT) vs more traditional models (like GPT-3), we also envision this allow switching between different model providers (eg OpenAI vs Cohere) and even model versions (eg GPT-3 vs GPT-4) down the road.

It will take some time to transition over to these selectors, but we started with some of the more popular chains and intend to transition over as fast we can. As always, feedback and help from the community is greatly appreciated!

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/prompt-selectors/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/prompt-selectors/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[![LangChain State of AI 2024 Report](images/prompt-selectors/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[![Introducing OpenTelemetry support for LangSmith](images/prompt-selectors/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![Easier evaluations with LangSmith SDK v0.2](images/prompt-selectors/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/prompt-selectors/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read