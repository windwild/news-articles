---
title: "Auto-Eval of Question-Answering Tasks"
source: "LangChain Blog"
url: "https://blog.langchain.com/auto-eval-of-question-answering-tasks/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:59:35.711853592+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

By [Lance Martin](https://twitter.com/RLanceMartin?ref=blog.langchain.com)

由 [Lance Martin](https://twitter.com/RLanceMartin?ref=blog.langchain.com) 撰写

**Context**

**背景**

LLM ops platforms, such as [LangChain](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com), make it easy to assemble LLM components (e.g., models, document retrievers, data loaders) into chains. [Question-Answering](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) is one of the most popular applications of these chains. But it is often not always obvious to determine what parameters (e.g., chunk size) or components (e.g., model choice, VectorDB) yield the best QA performance.

诸如 [LangChain](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com) 之类的 LLM 运维平台，使得将各类大语言模型组件（例如模型、文档检索器、数据加载器）组合成链式流程变得十分便捷。[问答系统（Question-Answering）](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) 是此类链式流程最流行的应用场景之一。然而，究竟哪些参数（例如分块大小 chunk size）或组件（例如模型选型、向量数据库 VectorDB）能带来最优的问答性能，往往并不一目了然。

Here, we introduce a simple tool for evaluating QA chains ( [see the code here](https://github.com/PineappleExpress808/auto-evaluator?ref=blog.langchain.com)) called `auto-evaluator`

此处，我们介绍一款用于评估问答链（QA chains）的简易工具——`auto-evaluator`（[代码见此](https://github.com/PineappleExpress808/auto-evaluator?ref=blog.langchain.com)）：

- Ask the user to input a set of documents of interest  
  - 提示用户输入一组感兴趣的文档；  
- Use an LLM (`GPT-3.5-turbo`) to auto-generate `question-answer` pairs from these docs  
  - 利用大语言模型（`GPT-3.5-turbo`）自动从这些文档中生成若干组 `问题-答案（question-answer）` 对；  
- Generate a question-answering chain with a specified set of UI-chosen configurations  
  - 基于用户在界面中选定的一组配置，构建一个问答链；  
- Use the chain to generate a response to each `question`  
  - 使用该问答链为每个 `问题` 生成回答；  
- Use an LLM (`GPT-3.5-turbo`) to score the response relative to the `answer`  
  - 利用大语言模型（`GPT-3.5-turbo`）将模型生成的回答与标准 `答案` 进行比对并打分；  
- Explore scoring across various chain configurations  
  - 在多种链式配置下对比分析评分结果。

![](https://blog.langchain.com/content/images/2023/04/auto-eval.png)

![](https://blog.langchain.com/content/images/2023/04/auto-eval.png)

**User Inputs**

**用户输入**

This is implemented as a  [Streamlit](https://streamlit.io/?ref=blog.langchain.com) app where a user can supply a set of documents. Optionally, the user can also supply a corresponding set of question-answer pairs (see example [here](https://github.com/PineappleExpress808/auto-evaluator/tree/main/docs/karpathy-lex-pod?ref=blog.langchain.com)). If the user does not supply this, the app with auto-generate an eval set using `QAGenerationChain`. You can see the prompt used for this [here](https://github.com/hwchase17/langchain/blob/master/langchain/evaluation/qa/generate_prompt.py?ref=blog.langchain.com), which selects question-answer pairs from random chunks for the input.

本工具以 [Streamlit](https://streamlit.io/?ref=blog.langchain.com) 应用形式实现，用户可上传一组文档。此外，用户还可选择性地提供一组对应的“问题-答案”对（参见[示例](https://github.com/PineappleExpress808/auto-evaluator/tree/main/docs/karpathy-lex-pod?ref=blog.langchain.com)）。若用户未提供该数据集，应用将自动调用 `QAGenerationChain` 生成评测集。该过程所用提示词（prompt）可参见[此处](https://github.com/hwchase17/langchain/blob/master/langchain/evaluation/qa/generate_prompt.py?ref=blog.langchain.com)，其原理是从输入文档的随机文本块中抽取并构造问题-答案对。

![](images/auto-eval-of-question-answering-tasks/img_002.png)

![](images/auto-eval-of-question-answering-tasks/img_002.png)

**Chain**

**链式流程**

The UI has various [knobs](https://github.com/PineappleExpress808/auto-evaluator?ref=blog.langchain.com) that can be used to create a QA chain. For example, you can pick from newer document retrievers (e.g., an [SVM](https://twitter.com/hwchase17/status/1647328542529843200?s=20&ref=blog.langchain.com)) or you can use similarity search on a vectorstore. You can select various document split methods, split sizes, and split overlap. You can also select the LLM used for final summarization of the answer to the question from the retrieved docs. These different pieces can be quickly and easily assembled using Langchain into a chain for evaluation.

用户界面提供了多种可调节的[参数控件（knobs）](https://github.com/PineappleExpress808/auto-evaluator?ref=blog.langchain.com)，可用于构建问答（QA）链。例如，您可以选用较新的文档检索器（如 [SVM](https://twitter.com/hwchase17/status/1647328542529843200?s=20&ref=blog.langchain.com)），或在向量数据库（vectorstore）上执行相似性搜索。您还可选择不同的文档切分方法、切分粒度（split size）以及切分重叠长度（split overlap）。此外，您可指定用于对检索所得文档进行最终答案总结的 LLM。借助 LangChain，这些不同组件可被快速、便捷地组合成一条用于评估的链式流程。

**Scoring**

**评分机制**

We use an LLM (`GPT-3.5-turbo`) to score the quality of the retrieved docs, which is an idea inspired by discussion with Jerry Liu at LLama-Index ( [here](https://github.com/jerryjliu/llama_index/blob/main/examples/test_wiki/TestNYC-Benchmark-GPT4.ipynb?ref=blog.langchain.com)). We also use an LLM to score the quality of the answers relative to the evaluation set. In both cases, we expose the [prompts](https://github.com/PineappleExpress808/auto-evaluator/blob/main/text_utils.py?ref=blog.langchain.com). Users can easily engineer them. We also expose the results for human inspection; the `Descriptive` prompt can be used to ask the LLM grader for a detailed explanation of its assessment.

我们采用一个 LLM（`GPT-3.5-turbo`）对所检索文档的质量进行打分——这一思路源自与 LLama-Index 的 Jerry Liu 的讨论（[参见此处](https://github.com/jerryjliu/llama_index/blob/main/examples/test_wiki/TestNYC-Benchmark-GPT4.ipynb?ref=blog.langchain.com)）。同时，我们也使用 LLM 对答案质量相对于评测集的表现进行评分。在这两类评分中，我们都公开了所用的[提示词模板（prompts）](https://github.com/PineappleExpress808/auto-evaluator/blob/main/text_utils.py?ref=blog.langchain.com)，用户可轻松对其进行定制与优化。此外，所有评分结果均对外公开，供人工复核；其中 `Descriptive` 提示词可用于要求 LLM 评分器对其评估结论给出详细解释。

![](images/auto-eval-of-question-answering-tasks/img_003.png)

![](images/auto-eval-of-question-answering-tasks/img_003.png)

**Comparison**

**对比分析**

We accumulate experimental results for easy comparison across the various tests, with a table and a scatter plot of the mean score (answer and retrieval) versus the model latency (in sec).

我们持续积累实验结果，便于在各类测试间进行直观对比：既提供汇总表格，也提供散点图，横轴为模型延迟（单位：秒），纵轴为平均得分（涵盖答案质量与检索质量两项）。

![](images/auto-eval-of-question-answering-tasks/img_004.png)

![](images/auto-eval-of-question-answering-tasks/img_004.png)

**Future directions**

**未来方向**

Feedback and contributions are welcome; for example, we would like to include other retrievers (such as LLama-Index) and other models (e.g., various HuggingFace models). We’d like to improve the performance (e.g., in particular, the latency) of various stages in the eval process and offer this as a free hosted tool (since some users will not have access to GPT-4 or Claude today). Finally, we’d like to extend this to other tasks (e.g., chat) and automate the process of best chain assembly (e.g., using agents) given a user-specified objective (e.g., chat or QA goals).

诚挚欢迎各方反馈与贡献。例如，我们计划支持更多检索器（如 LLama-Index）及更多模型（如各类 HuggingFace 模型）；我们希望进一步提升评估流程各阶段的性能（尤其是降低延迟），并将其作为免费托管工具开放给所有用户（当前部分用户尚无法访问 GPT-4 或 Claude）；最后，我们还计划将该框架拓展至其他任务场景（如对话系统），并在用户明确指定目标（如聊天或问答）的前提下，自动完成最优链式流程的组装（例如借助 Agent 技术）。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/auto-eval-of-question-answering-tasks/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/auto-eval-of-question-answering-tasks/img_005.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/auto-eval-of-question-answering-tasks/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/auto-eval-of-question-answering-tasks/img_006.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/auto-eval-of-question-answering-tasks/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/auto-eval-of-question-answering-tasks/img_007.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/auto-eval-of-question-answering-tasks/img_008.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/auto-eval-of-question-answering-tasks/img_009.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/auto-eval-of-question-answering-tasks/img_010.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
{% endraw %}
