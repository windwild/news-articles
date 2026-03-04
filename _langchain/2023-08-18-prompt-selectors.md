---
render_with_liquid: false
title: "Prompt Selectors"
source: "LangChain Blog"
url: "https://blog.langchain.com/prompt-selectors/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:58:17.773874357+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

One common complaint we've heard is that the default prompt templates do not work equally well for all models. This became especially pronounced this past week when OpenAI released a ChatGPT API. This new API had a completely new interface ( [which required new abstractions](https://blog.langchain.com/chat-models/)) and as a result many users noticed issues with old prompts no longer working. Although we quickly added support for this model, many users noticed that prompt templates that worked well for GPT-3 did not work well in the chat setting.

我们听到的一个常见抱怨是：默认的提示模板并非对所有模型都同样有效。这一问题在上周 OpenAI 发布 ChatGPT API 时尤为突出。该新 API 采用了全新的接口（[需引入新的抽象层](https://blog.langchain.com/chat-models/)），导致许多用户发现原有提示模板不再生效。尽管我们迅速为该模型添加了支持，但不少用户仍注意到：原本在 GPT-3 上表现良好的提示模板，在聊天（chat）场景下却效果不佳。

All chains expose ways to customize these prompt templates, so there's always the option to let users pass in prompts that work better. But we want to do better than that. One goal of having chains with default prompt templates is to offer functionality that "Just Works" out of the box. If different models expect different types of prompts, this breaks down.

所有链（chains）均提供自定义这些提示模板的方式，因此用户始终可以选择传入更适配的提示。但我们希望做得更好。为链预置默认提示模板的目标之一，正是提供开箱即用（“Just Works”）的功能体验；而一旦不同模型对提示格式的要求各不相同，这种“开箱即用”的承诺便难以维系。

Our solution for this is to introduce a concept of a `PromptSelector`. Rather than define a default `PromptTemplate` for each chain, we will move towards defining a `PromptSelector` for each chain. If no prompt is specified by the user, the `PromptSelector` will select a `PromptTemplate` to use based on the model that is passed in.

针对此问题，我们的解决方案是引入 `PromptSelector`（提示选择器）这一概念。我们将不再为每个链定义一个固定的默认 `PromptTemplate`，而是转而为每个链定义一个 `PromptSelector`。当用户未显式指定提示时，`PromptSelector` 将根据所传入的具体模型，自动选择最合适的 `PromptTemplate`。

For an example of this in action, check out the following examples:

如需查看实际应用示例，请参阅以下内容：

### Python

### Python（Python 示例）

[Code Definition](https://github.com/hwchase17/langchain/blob/master/langchain/chains/prompt_selector.py?ref=blog.langchain.com)

[代码定义](https://github.com/hwchase17/langchain/blob/master/langchain/chains/prompt_selector.py?ref=blog.langchain.com)

[Full Example](https://github.com/hwchase17/langchain/blob/master/langchain/chains/question_answering/stuff_prompt.py?ref=blog.langchain.com)

[完整示例](https://github.com/hwchase17/langchain/blob/master/langchain/chains/question_answering/stuff_prompt.py?ref=blog.langchain.com)

Snippet:

代码片段：

```python
PROMPT_SELECTOR = ConditionalPromptSelector(
    default_prompt=PROMPT, conditionals=[(is_chat_model, CHAT_PROMPT)]
)
```

### In JS/TS:

### JavaScript / TypeScript（JS/TS 示例）

[Code Definition](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/prompt_selector.ts?ref=blog.langchain.com)

[代码定义](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/prompt_selector.ts?ref=blog.langchain.com)

[Full Example](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/question_answering/stuff_prompts.ts?ref=blog.langchain.com)

[完整示例](https://github.com/hwchase17/langchainjs/blob/main/langchain/src/chains/question_answering/stuff_prompts.ts?ref=blog.langchain.com)

Snippet:

代码片段：

```typescript
export const QA_PROMPT_SELECTOR = new ConditionalPromptSelector(
  DEFAULT_QA_PROMPT,
  [[isChatModel, CHAT_PROMPT]]
);
```

Both these examples show the same thing. We define a default prompt, but then if a condition (`isChatModel`) is met we switch to a different prompt. This is also extendable to an arbitrary list of "conditions" and corresponding prompts.

以上两个示例展示的是同一概念：我们首先定义一个默认提示词（prompt），但当某个条件（例如 `isChatModel`）满足时，则切换至另一个提示词。该机制还可进一步扩展，以支持任意数量的“条件-提示词”配对。

This is a very simple concept, but we hope it gives us (and other developers) the flexibility to define chains that "Just Work" out of the box for any model. Although the immediate use case is for switching between prompts for ChatModels (like ChatGPT) vs more traditional models (like GPT-3), we also envision this allow switching between different model providers (eg OpenAI vs Cohere) and even model versions (eg GPT-3 vs GPT-4) down the road.

这一概念看似极为简单，但我们希望它能为我们（以及广大开发者）提供足够的灵活性，使所构建的链（chains）能够“即开即用”，无缝适配各类模型。尽管当前最直接的应用场景是区分 Chat 模型（如 ChatGPT）与传统文本生成模型（如 GPT-3）并动态切换对应提示词，但我们更长远的设想是：未来可借此机制在不同模型提供商（例如 OpenAI 与 Cohere）之间切换，甚至在不同模型版本（例如 GPT-3 与 GPT-4）之间切换。

It will take some time to transition over to these selectors, but we started with some of the more popular chains and intend to transition over as fast we can. As always, feedback and help from the community is greatly appreciated!

全面迁移到这些选择器（selectors）尚需一定时间；我们已率先在部分最受欢迎的链上启用该机制，并将持续加快迁移进度。一如既往，我们由衷感谢社区提出的宝贵反馈与技术支持！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[作者：LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/prompt-selectors/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/prompt-selectors/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/prompt-selectors/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/prompt-selectors/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 3 分钟

[![LangChain State of AI 2024 Report](images/prompt-selectors/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/prompt-selectors/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/prompt-selectors/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/prompt-selectors/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/prompt-selectors/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更轻松的评估](images/prompt-selectors/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更轻松的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/prompt-selectors/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/prompt-selectors/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟