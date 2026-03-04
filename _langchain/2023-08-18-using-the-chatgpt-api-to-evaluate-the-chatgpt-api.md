---
title: "Using the ChatGPT API to evaluate the ChatGPT API"
source: "LangChain Blog"
url: "https://blog.langchain.com/using-chatgpt-api-to-evaluate-chatgpt/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:57:08.653592586+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

OpenAI released a new [ChatGPT API](https://openai.com/blog/introducing-chatgpt-and-whisper-apis?ref=blog.langchain.com) yesterday.  
OpenAI 昨日发布了全新的 [ChatGPT API](https://openai.com/blog/introducing-chatgpt-and-whisper-apis?ref=blog.langchain.com)。

Lots of people were excited to try it.  
许多人兴奋地跃跃欲试。

But how does it actually compare to the existing API?  
但它的实际表现究竟如何，与现有 API 相比又有哪些差异？

It will take some time before there is a definitive answer, but here are some initial thoughts.  
要得出明确结论尚需时日，但以下是一些初步观察与思考。

Because I'm lazy, I also enrolled the help of the ChatGPT API itself to help do this evaluation.  
由于我比较懒，我还请 ChatGPT API 本身来协助完成此次评估。

Confused? Don't be. Let's dive in.  
感到困惑？不必担心——让我们深入探究。

Relevant links:  
相关链接：

- [Evaluation Notebook](https://python.langchain.com/docs/guides/evaluation/data_augmented_question_answering?ref=blog.langchain.com)  
- [评估 Notebook](https://python.langchain.com/docs/guides/evaluation/data_augmented_question_answering?ref=blog.langchain.com)

- [ChatGPT PR](https://github.com/hwchase17/langchain/pull/1375?ref=blog.langchain.com)  
- [ChatGPT PR](https://github.com/hwchase17/langchain/pull/1375?ref=blog.langchain.com)

- [ChatGPT PR Discussion](https://github.com/hwchase17/langchain/discussions/1376?ref=blog.langchain.com)  
- [ChatGPT PR 讨论区](https://github.com/hwchase17/langchain/discussions/1376?ref=blog.langchain.com)

## What task are we evaluating?  

## 我们正在评估什么任务？

In this article we will evaluate the performance of a chain on [question answering](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com) over a particular dataset.  
本文将针对特定数据集，评估一条链（chain）在[问答任务](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com)上的性能表现。

This chain takes a query, does a "retrieval" step to look up relevant documents in a vector store, and then does a "generation" step to pass them, along with the original query, to a model to get back an answer.  
该链接收一个查询（query），首先执行“检索”（retrieval）步骤——在向量数据库中查找相关文档；随后执行“生成”（generation）步骤——将检索到的文档连同原始查询一并输入模型，以生成最终答案。

We will hold the "retrieval" step constant, so we are just evaluating the "generation" step of the chain.  
我们将保持“检索”步骤不变，因此本次评估聚焦于链中的“生成”环节。

## What models/prompts are we comparing?  

## 我们正在对比哪些模型与提示词（prompts）？

First up, we've got the standard `text-davinci-003` model, with the standard `VectorDBQAChain` prompts.  
首先，我们采用标准的 `text-davinci-003` 模型，并搭配标准的 `VectorDBQAChain` 提示词模板。

We want to compare this to ChatGPT. There would be two potential ways to do this. One would be to use a wrapper that and treat ChatGPT has just another LLM. Another would be to try to use the ChatGPT API more natively.  
我们希望将其与 ChatGPT 进行对比。实现这一对比大致有两种方式：其一是通过封装器（wrapper）将 ChatGPT 视为另一个普通大语言模型（LLM）；其二是更原生地调用 ChatGPT API。

What do I mean by that? The ChatGPT API differs from the GPT-3 API in that it takes in a list of messages (rather than a single string) and returns a message. These messages are essentially dicts that have two fields: `content` and `role`. Both are used in the prompt. The `content` field can be anything, while the `role` field should be one of `user`, `system`, or `assistant`. Presumably, the model is trained to treat the `user` messages as human messages, `system` messages as some system level configuration, and `assistant` messages as previous chat responses from the assistant.  
我所说的“更原生地调用”，具体指什么？ChatGPT API 与 GPT-3 API 的关键区别在于：前者接收的是一个消息列表（而非单个字符串），并返回一条消息。这些消息本质上是包含两个字段的字典：`content`（内容）和 `role`（角色），二者均参与构建提示（prompt）。其中，`content` 字段可承载任意文本；而 `role` 字段则必须为 `user`、`system` 或 `assistant` 三者之一。模型应被训练为：将 `user` 类消息视为用户输入，`system` 类消息视为系统级配置指令，`assistant` 类消息则视为助手此前的对话回复。

So how can we use this to do question answering? Let's think back to the information we need to pass in. There are three components:  
那么，我们该如何利用这种消息结构来完成问答任务呢？让我们回顾一下所需传入的关键信息——它由三个部分组成：

- Instructions (about how it should answer, format, etc)  
- 指令（关于其应如何作答、格式要求等）

- The user question  
- 用户问题

- Retrieved pieces of content  
- 检索到的内容片段

Instructions seem like they should be the first message and have `role` of `system`. The user question seems like it should have `role` of `user`, but is a little bit less clear where it should go. It is extremely unclear what `role` or what position in the list of messages the retrieved pieces of content should go. Note that I say "should", but our understanding might change in the near future.  
指令似乎应作为第一条消息，并设置其 `role` 为 `system`；用户问题似乎应设置 `role` 为 `user`，但其在消息序列中的确切位置尚不明确；而检索到的内容片段应分配何种 `role`、又该插入消息列表的哪个位置，则更加模糊不清。需要说明的是，此处使用了“应”（should）一词，但我们的理解在未来短期内仍可能发生变化。

Some ideas for how to combine the user question and retrieved pieces of content:  
关于如何整合用户问题与检索到的内容片段，我们提出以下几种思路：

1. Put the pieces of content in the system message and tell the model to only use that information.  
1. 将检索到的内容片段全部放入系统消息（`system` 消息）中，并指示模型仅基于该信息作答。

2. Put each piece of content as its own message (with either `assistant` or `user` roles) in the middle of the conversation  
2. 将每一段检索内容单独作为一条消息（`role` 设为 `assistant` 或 `user`），插入对话中间。

3. Put the user question first, and then follow it with a message for each piece of content (with role `assistant`) and then another `user` message asking for it to answer given those pieces of content.  
3. 先发送用户问题，随后为每段检索内容各发送一条 `assistant` 角色的消息，最后再以 `user` 角色发送一条新消息，要求模型基于前述所有内容作答。

Lots of choices! For the purposes of this experiment I went with option 2, set role to be `user`, and instructed the model to only use pieces of information that the user had told it before when answering.  
选择众多！在本次实验中，我们采用了第 2 种方案，将所有检索内容片段的 `role` 统一设为 `user`，并明确指示模型：作答时仅可使用用户此前已提供给它的信息。

## How did we evaluate this?  
## 我们如何评估该方法？

We used the simple "State of the Union Address" that we commonly use as a toy example. We then generated a bunch of questions and corresponding answers from this dataset. This was done using GPT-3, using our [existing question/answering generation pipeline](https://python.langchain.com/docs/guides/evaluation/data_augmented_question_answering?ref=blog.langchain.com). We then ran each question through the two chains (GPT3 and ChatGPT). We then evaluated the answers — using GPT3 and ChatGPT. Specifically, we have another chain called the `QAEvalChain`, which uses GPT3 to evaluate question answering responses. We created a corresponding `QAEvalChatChain` which uses the ChatGPT API to do a similar thing. To add a cherry on top, we then created a `QACompChatChain` which takes in the question, the true answer, and both predicted answers and compares them.  
我们采用经典的简化版“国情咨文”（State of the Union Address）文本——这是我们在教学与测试中常用的玩具示例（toy example）。随后，我们基于该数据集批量生成了若干问题及对应的标准答案，整个过程借助 GPT-3 并通过我们已有的[问答数据生成流水线](https://python.langchain.com/docs/guides/evaluation/data_augmented_question_answering?ref=blog.langchain.com)完成。接着，我们将每个问题分别输入两个推理链（GPT-3 链与 ChatGPT 链）。之后，我们使用 GPT-3 和 ChatGPT 对两组回答结果进行评估。具体而言，我们另有一条名为 `QAEvalChain` 的评估链，它调用 GPT-3 来评判问答响应质量；我们还构建了对应的 `QAEvalChatChain`，其底层调用 ChatGPT API 实现类似功能。锦上添花的是，我们进一步开发了 `QACompChatChain`：它接收原始问题、真实答案以及两个模型各自生成的预测答案，并对二者进行综合对比分析。

In this post, we will look mostly as the results of the evaluators. So in a meta way, we are using a language model to evaluate a language model, but then (for the time being) we are still the ones evaluating the evaluator model.  
本文主要呈现评估器（evaluator）的输出结果。因此，这是一种“元评估”（meta-evaluation）：我们正利用语言模型来评估另一语言模型的表现；但就目前而言，最终对评估模型本身优劣作出判断的，仍是人类。

## So what were the results?  
## 那么，评估结果如何？

See our full results [here](https://langchain.readthedocs.io/en/harrison-memory-chat/use_cases/evaluation/data_augmented_question_answering_comparision.html?ref=blog.langchain.com). For speed/simplicity, we only evaluated 7 questions, so this suffers from incredibly small sample size issues.  
完整评估结果请参见[此处](https://langchain.readthedocs.io/en/harrison-memory-chat/use_cases/evaluation/data_augmented_question_answering_comparision.html?ref=blog.langchain.com)。出于效率与简便性考虑，本次实验仅选取了 7 个问题进行评估，因此存在极为显著的样本量过小问题。

Note that the imported code is still on a branch as we work to figure out the best abstractions for this new Chat paradigm.

请注意，所导入的代码目前仍位于一个分支上，因为我们正在探索适用于这一全新 Chat 范式的最佳抽象方式。

First of all, how did GPT3 grade the two models?

首先，GPT-3 是如何为这两个模型评分的？

- GPT3 grading GPT3: 4/7  
- GPT-3 为 GPT-3 评分：4/7  

- GPT3 grading ChatGPT: 4/7  
- GPT-3 为 ChatGPT 评分：4/7  

And how did ChatGPT grade the two models?

那么，ChatGPT 又是如何为这两个模型评分的？

- ChatGPT grading GPT3: 5/7  
- ChatGPT 为 GPT-3 评分：5/7  

- ChatGPT grading ChatGPT: 4/7  
- ChatGPT 为自身（ChatGPT）评分：4/7  

It's interesting to look where the differences lie. There was one example that GPT3 graded as incorrect for both GPT3 and ChatGPT, but ChatGPT graded as correct for both. And there was a separate example that GPT3 graded as correct for both, but ChatGPT graded as incorrect for ChatGPT. Let's take a look.

观察这些评分差异十分有趣。其中有一个样例，GPT-3 认为 GPT-3 和 ChatGPT 的回答均不正确，而 ChatGPT 却判定二者均正确；另有一个样例，GPT-3 认为两者回答均正确，但 ChatGPT 却判定 ChatGPT 的回答不正确。我们来具体看一下。

First, the example that GPT3 graded as incorrect but ChatGPT as correct:

首先看这个 GPT-3 判为错误、而 ChatGPT 判为正确的样例：

![](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_001.png)

Here it looks like GPT3 may have graded it as incorrect due it the verbosity of the answers, but ChatGPT didn't mind that. An alternative explanation could be that ChatGPT was more able to actually understand that "praised her legal ability" was consistent with the answers given.

此处，GPT-3 的扣分原因可能是答案过于冗长，而 ChatGPT 对此并不介意；另一种可能的解释是：ChatGPT 更能准确理解“赞扬了她的法律能力”这一表述与所给答案之间的一致性。

Next, the example that GPT3 graded as correct for both, but ChatGPT graded as incorrect for ChatGPT.

接下来是另一个样例：GPT-3 认为 GPT-3 和 ChatGPT 的回答均正确，而 ChatGPT 却判定自身（ChatGPT）的回答不正确。

![](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_002.png)

我们从本例中可以看到，GPT-3 的回答与真实答案几乎完全一致。这几乎可以肯定是因为我们使用 GPT-3 生成了这些问答对。而 ChatGPT 的回答则更为冗长；虽然从技术上讲并不错误，但其表述不如 GPT-3 的回答那样具体和直接。同样，这很可能也是由于问答对本身由 GPT-3 生成所致。备注（供自己参考）：未来或许应手动构建一个测试集。

## 直接对比结果如何？

我们进行的最后一项评估是：将问题、标准答案以及两个模型各自的预测答案一并提交给 ChatGPT，并请它对两份预测答案进行比较。综合其反馈结果如下：

- GPT-3 的回答比 ChatGPT 更简洁；
- ChatGPT 的回答比 GPT-3 更详尽；
- ChatGPT 的回答比 GPT-3 更礼貌。

需要谨记的是，此处的差异不仅源于基础模型本身，也受到所用提示词（prompts）的影响。因此，这并非严格意义上两种模型之间的纯粹对比，而更准确地说，是对当前各自已有调用链（chains）的对比。

## 后续步骤

围绕 ChatGPT API 的探索工作仍任重道远！例如：  
- 如何最有效地利用 `role` 参数？  
- `system` 角色究竟起到什么作用？  
- 面对这种新型 API，哪些才是恰当的抽象层级（abstractions）？

答案尚待时间揭晓——这是令人振奋的时代！

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_003.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_004.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_005.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain《2024 年人工智能现状》报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_006.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_007.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/using-the-chatgpt-api-to-evaluate-the-chatgpt-api/img_008.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)
{% endraw %}
