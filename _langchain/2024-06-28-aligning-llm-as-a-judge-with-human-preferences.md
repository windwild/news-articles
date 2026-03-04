---
title: "Aligning LLM-as-a-Judge with Human Preferences"
source: "LangChain Blog"
url: "https://blog.langchain.com/aligning-llm-as-a-judge-with-human-preferences/"
date: "2024-06-28"
scraped_at: "2026-03-03T07:59:41.076500071+00:00"
language: "en-zh"
translated: true
description: "Deep dive into self-improving evaluators in LangSmith, motivated by the rise of LLM-as-a-Judge evaluators plus research on few-shot learning and aligning human preferences."
tags: ["By LangChain"]
---
&#123;% raw %}

**Key Links:**

**关键链接：**

- [**Technical documentation**](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator)  
- [**技术文档**](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator)

- [**Video walkthrough**](https://www.youtube.com/watch?v=3gCTa0Li4ew&ref=blog.langchain.com)  
- [**视频演示**](https://www.youtube.com/watch?v=3gCTa0Li4ew&ref=blog.langchain.com)

[Evaluation](https://docs.smith.langchain.com/concepts/evaluation?ref=blog.langchain.com) is the process of continuously [improving your LLM application](https://www.youtube.com/watch?v=c0gcsprsFig&t=1140s&ref=blog.langchain.com). This requires a way to measure your application’s performance.

[评估（Evaluation）](https://docs.smith.langchain.com/concepts/evaluation?ref=blog.langchain.com) 是持续[改进您的大语言模型（LLM）应用](https://www.youtube.com/watch?v=c0gcsprsFig&t=1140s&ref=blog.langchain.com)的过程。这需要一种方法来衡量您应用的性能。

LLM applications often produce outputs in natural language, which are difficult to judge using hard-coded rules. For example, attributes like conciseness or correctness relative to a reference output are [difficult to express](https://arxiv.org/pdf/2404.12272v1?ref=blog.langchain.com) as typical unit tests.

LLM 应用通常生成自然语言形式的输出，而这类输出难以通过硬编码规则进行评判。例如，“简洁性”或“相对于参考答案的正确性”等属性，[很难像常规单元测试那样被形式化表达](https://arxiv.org/pdf/2404.12272v1?ref=blog.langchain.com)。

Using an “ [LLM-as-a-Judge](https://docs.smith.langchain.com/concepts/evaluation?ref=blog.langchain.com#llm-as-judge)” is a popular way to grade natural language outputs from LLM applications. This involves passing the generated output (and other information) to a **separate** LLM and asking it to judge the output. Although this has proven useful in several contexts, it raises an interesting problem: you now have to do **another** round of prompt engineering to make sure the LLM-as-a-Judge is performing well.

采用“[LLM 作为裁判（LLM-as-a-Judge）](https://docs.smith.langchain.com/concepts/evaluation?ref=blog.langchain.com#llm-as-judge)”是评估 LLM 应用自然语言输出的一种流行方式。该方法将生成的输出（及其他相关信息）输入一个**独立的**大语言模型，并请其对输出质量进行评判。尽管该方法已在多个场景中被证实有效，但它引出了一个有趣的问题：您现在必须开展**另一轮**提示词工程（prompt engineering），以确保“LLM 作为裁判”的评判结果准确可靠。

LangSmith presents a novel solution to this rising problem. LangSmith evaluators now feature “self-improvement” whereby human corrections to LLM-as-a-Judge outputs are stored as few-shot examples, which are then fed back into the prompt in future iterations.

LangSmith 针对这一日益突出的问题提出了创新性解决方案：LangSmith 的评估器现已支持“自我优化（self-improvement）”能力——即把人类对“LLM 作为裁判”输出结果所作的修正，自动保存为少样本（few-shot）示例，并在后续迭代中将其重新注入提示词中。

💡

💡

The net impact is that it is easier to create LLM-as-a-Judge evaluators that accurately reflect your preferences with **no** prompt engineering, and have them adapt over time as you interact natively with LangSmith.

其最终效果是：您无需进行任何提示词工程，即可更轻松地构建出精准反映自身偏好的“LLM 作为裁判”评估器；并且随着您在 LangSmith 中的原生交互，这些评估器还能持续自主适应与进化。

In this post we will talk about the rise of LLM-as-a-Judge evaluators, some motivating research that led us to this solution, and then deep dive into how exactly this is implemented. If you want to try it out, you can [sign up for LangSmith for free here](http://smith.langchain.com/?ref=blog.langchain.com).

本文将探讨“LLM 作为裁判”评估器的兴起背景、推动我们提出该方案的关键研究动机，并深入剖析其实现机制。如果您希望立即体验，可[免费注册 LangSmith](http://smith.langchain.com/?ref=blog.langchain.com)。

## LLM-as-a-Judge

## LLM 作为裁判

It’s often hard to evaluate LLM output programmatically. A big part of this is a lack of good metrics. Sure, if you are doing classification or named entity extraction or other “traditional” ML tasks then there’s standard ML metrics to use. But if you are doing more “generative” tasks (which most applications often are) then there aren’t many great options.

在程序上评估大语言模型（LLM）输出往往十分困难。造成这一困境的一大原因，是缺乏优质评估指标。诚然，如果你正在执行分类、命名实体识别或其他“传统”机器学习任务，那么已有标准的机器学习评估指标可用；但如果你面对的是更偏“生成式”的任务（而大多数实际应用恰恰属于此类），则目前可选的优秀指标却寥寥无几。

And evaluation is super important! You can’t just launch an application and hope for the best - you should be evaluating its performance on real data, making changes to your app, and then making sure the changes don’t cause regressions. We see builders spending significant time on both the **online** and **offline** evaluation stages - and built LangSmith accordingly.

而且，评估至关重要！你绝不能仅凭一腔热情就上线一个应用，然后寄希望于“一切顺利”——你必须基于真实数据持续评估其性能，据此迭代优化应用，并确保每次变更都不会引发性能退化。我们观察到，开发者在**在线评估**（online evaluation）和**离线评估**（offline evaluation）两个阶段均投入了大量精力；LangSmith 正是为响应这一现实需求而构建。

LangSmith is not opinionated in what metrics you use (we see that nearly everyone defines their own custom metric). We've worked with fantastic teams like [Elastic](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/) and [Rakuten](https://blog.langchain.com/customers-rakuten/), seeing firsthand how they are doing evaluation – and one of the things we’ve noticed is a rise in the usage of “LLM-as-a-Judge” evaluators.

LangSmith 对你选用何种评估指标持中立态度（事实上，我们发现几乎所有团队都会定义自己专属的定制化指标）。我们曾与 [Elastic](https://blog.langchain.com/langchain-partners-with-elastic-to-launch-the-elastic-ai-assistant/) 和 [Rakuten](https://blog.langchain.com/customers-rakuten/) 等杰出团队深度合作，亲历其评估实践过程——其中一项显著趋势是，“LLM 作为评判者”（LLM-as-a-Judge）评估器的使用正日益普及。

An “LLM-as-a-Judge” evaluator is simply an evaluator that uses an LLM to score the output. This is often useful when it’s tough to programmatically evaluate an application and the only other recourse would be human labels. Key use cases we’ve seen involve:

所谓“LLM 作为评判者”评估器，即指利用大语言模型对输出结果进行打分的评估器。当程序化评估应用表现极为困难、而唯一替代方案又只能依赖人工标注时，这类评估器便尤为实用。我们观察到的关键应用场景包括：

- Detecting RAG hallucinations (online evaluation)  
- 检测 RAG 生成中的幻觉现象（在线评估）

- Detecting RAG correctness (offline evaluation)  
- 检测 RAG 输出的正确性（离线评估）

- Detecting whether the LLM generated a toxic or inappropriate answer (offline and online evaluation)  
- 检测大语言模型是否生成了有害或不恰当的回答（适用于离线与在线评估）

Why does this work? If LLMs are generating the answers in the first place, then why does using an LLM to score the results actually work at all?

这种机制为何可行？既然答案本就是由大语言模型生成的，那么再用另一个大语言模型来评分，究竟凭什么能奏效？

There are two factors at play. First, during evaluation the LLM may have access to information it didn’t have at the time of generation. For example, when judging RAG correctness, you give the evaluator LLM the ground truth answer and ask it to compare to that. Obviously, this is some information you didn’t have in the moment. Second, judging the correctness of an answer is easier for an LLM than generating a correct answer itself. This “simplifying” of the task makes LLM-as-a-Judge feasible.

其背后存在两大关键因素：第一，在评估阶段，大语言模型可能获得其生成答案时所不具备的信息。例如，在判断 RAG 输出正确性时，你会向评估用 LLM 提供标准答案（ground truth），并要求它将模型输出与之比对——显然，这一标准答案在原始生成时刻是不可得的。第二，对大语言模型而言，“判断答案是否正确”远比“从零生成一个正确答案”要容易得多。正是这种任务难度的“简化”，使得 LLM 作为评判者具备可行性。

While this process can work well, it has complications. You still have to do another round of prompt engineering for the evaluator prompt, which can time-consuming and hinder teams from setting up a proper evaluation system. With LangSmith, we've aimed to streamline this evaluation process.

尽管该流程效果良好，但仍存在若干挑战：你仍需针对评估器提示词（evaluator prompt）开展新一轮提示工程，这一过程耗时费力，常阻碍团队快速搭建起完善的评估体系。为此，LangSmith 致力于大幅简化这一评估流程。

## Motivating research

## 驱动性研究

There were two pieces of motivating research that led us to implement a solution.

推动我们构建该解决方案的，主要有两项关键研究。

The first piece is nothing new: [language models are adept at few-shot](https://arxiv.org/abs/2005.14165?ref=blog.langchain.com) learning.  
第一部分并不新鲜：[语言模型擅长小样本学习（few-shot learning）](https://arxiv.org/abs/2005.14165?ref=blog.langchain.com)。  

If you give LLMs examples of things done correctly, they will imitate the correct behavior.  
如果你向大语言模型（LLM）提供正确完成任务的示例，它们便会模仿这种正确行为。  

This method is widely-adopted in our client LLM applications; it's particularly effective in cases where it's tough to explain in instructions how the LLM should behave, and where the output is expected to have a particular format. Evaluations fit both these criteria!  
该方法已被广泛应用于我们客户的 LLM 应用中；尤其适用于以下两类场景：一是难以通过指令清晰描述 LLM 应如何表现，二是输出需符合特定格式。评估任务恰好同时满足这两项条件！

The other piece of research is new: a paper out of Berkeley by Shreya Shankar titled [Who Validates the Validators? Aligning LLM-Assisted Evaluation of LLM Outputs with Human Preferences](https://arxiv.org/pdf/2404.12272?ref=blog.langchain.com).  
另一项研究则属最新成果：加州大学伯克利分校的 Shreya Shankar 发表了一篇题为 [《谁来验证验证者？——将大语言模型辅助的 LLM 输出评估与人类偏好对齐》](https://arxiv.org/pdf/2404.12272?ref=blog.langchain.com) 的论文。  

This paper addresses the same problem, and, though it proposes a different solution than ours, it helped motivate our usage of feedback collection as a way to programmatically align LLM evaluations with human preferences.  
该论文聚焦于同一问题；尽管其提出的解决方案与我们的不同，但它启发了我们采用“收集反馈”这一方式，以程序化手段实现 LLM 评估结果与人类偏好的对齐。

So - how did we take these two ideas and build our “self-improving” evaluators?  
那么——我们是如何融合上述两项思路，构建出自己的“自优化”评估器的呢？

## Our solution: Self-improving evaluation in LangSmith

## 我们的方案：LangSmith 中的自优化评估

Building on recent research and the widespread adoption of LLM-as-a-Judge evaluators, we've developed a novel "self-improving" system for LangSmith evaluators. This approach aims to streamline the process of aligning LLM evaluations with human preferences, eliminating the need for extensive prompt engineering. Here's how it works:

基于近期研究成果及 LLM-as-a-Judge（大语言模型作为评判者）评估器的广泛应用，我们为 LangSmith 评估器开发了一套全新的“自优化”系统。该方案旨在简化 LLM 评估与人类偏好对齐的过程，彻底摆脱繁重的手动提示词工程（prompt engineering）。具体流程如下：

**To start, set up LLM as a judge (online or offline):** Users can easily [set up an LLM-as-a-Judge evaluator in LangSmith for either online or offline evaluation](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator). This initial setup requires minimal configuration, as the system is designed to improve over time. When setting it up you can specify how few-shot examples should be formatted into the prompt.

**首先，配置 LLM 作为评判者（支持在线或离线模式）：** 用户可轻松地在 LangSmith 中[为在线或离线评估配置一个 LLM-as-a-Judge 评估器](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator)。初始配置极为简便，因为该系统本身即被设计为随时间持续优化。配置时，用户可指定小样本示例应如何组织并嵌入提示词中。

![](images/aligning-llm-as-a-judge-with-human-preferences/img_001.png)

1. **Have it leave feedback**: The LLM evaluator provides feedback on the generated outputs, assessing factors such as correctness, relevance, or any other criteria specified as part of the judge in the prior step.  
1. **让其生成反馈**：LLM 评估器针对生成的输出内容提供反馈，评估维度包括正确性、相关性，或此前步骤中作为“评判者”所定义的其他任意标准。

2. **Users can make corrections on that feedback natively in the app:** As users review the LLM's evaluations, they can directly modify or correct the feedback within the LangSmith interface. This step is crucial for capturing human preferences and judgments.  
2. **用户可在应用内原生地修正该反馈：** 当用户审阅 LLM 的评估结果时，可直接在 LangSmith 界面中修改或更正其反馈内容。这一步对于捕获真实的人类偏好与判断至关重要。

3. **These corrections will be stored as few-shot examples:** LangSmith automatically stores these human corrections as few-shot examples. This creates a growing dataset of human-aligned evaluations that reflect the specific preferences and standards of your team or application. You can also leave **explanations** for your corrections as part of this flow.  
3. **这些修正将被自动保存为小样本示例：** LangSmith 会自动将这些人工修正保存为小样本示例。由此逐步构建起一个不断增长的、与人类偏好高度一致的评估数据集，精准反映您团队或应用的具体偏好与标准。您还可在此流程中一并添加对修正操作的**说明（explanations）**。

4. **The next time an evaluator runs, it will store those examples (and optionally, the explanations) and use those to inform its generation:** In subsequent evaluation runs, the system incorporates these stored examples into the prompt for the LLM-as-a-Judge. By leveraging the few-shot learning capabilities of language models, the evaluator becomes increasingly aligned with human preferences over time.  
4. **下次评估器运行时，将自动保存这些示例（以及可选的说明），并将其用于指导后续生成：** 在后续的评估任务中，系统会将已存储的示例（含可选说明）注入 LLM-as-a-Judge 的提示词中。借助语言模型固有的小样本学习能力，评估器将随着时间推移，愈发精准地与人类偏好保持一致。

For more of a technical walkthrough, see [this how-to guide](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator).  
如需更详细的技术实操指南，请参阅[本教程](https://docs.smith.langchain.com/how_to_guides/evaluation/create_few_shot_evaluators?ref=blog.langchain.com#create-your-evaluator)。

This self-improving cycle allows the LLM-as-a-Judge to adapt and refine its evaluations based on real-world feedback, eliminating manual prompt adjustments or time-consuming prompt engineering. Now, teams can focus on reviewing and correcting evaluations when necessary, knowing that their input directly improves the system's performance over time.  
这一自优化闭环机制，使 LLM-as-a-Judge 能够依据真实世界反馈持续适应并精进其评估能力，彻底免除了手动调整提示词或耗时费力的提示词工程。如今，团队只需在必要时专注于审阅与修正评估结果，即可确信：每一次输入，都在切实提升系统的长期性能。

## Conclusion

## 结论

LLM-as-a-Judge evaluators are powerful tools for assessing generative AI systems but have posed new challenges in prompt engineering and human preference alignment. LangSmith's self-improving evaluators provide an elegant solution to this problem, leveraging few-shot learning and user corrections to integrate human feedback for accurate, relevant evaluations without constant manual intervention.

LLM-as-a-Judge 评估器是评估生成式 AI 系统的有力工具，但也为提示工程（prompt engineering）和人类偏好对齐（human preference alignment）带来了新的挑战。LangSmith 的自优化评估器为此问题提供了优雅的解决方案：它借助小样本学习（few-shot learning）和用户修正，将人类反馈融入评估流程，从而实现准确、相关且无需持续人工干预的评估。

As AI rapidly advances, self-improving evaluators will be crucial in bridging the gap between machine capabilities and human expectations. With LangSmith, we're empowering teams to build, assess, and refine their AI applications with greater confidence and efficiency. If you haven’t already - sign up for LangSmith for free [here](https://smith.langchain.com/?ref=blog.langchain.com).

随着 AI 快速发展，自优化评估器将在弥合机器能力与人类期望之间的鸿沟方面发挥关键作用。借助 LangSmith，我们正助力团队以更高的信心与效率构建、评估并优化其 AI 应用。若您尚未注册，请立即免费注册 LangSmith：[点击此处](https://smith.langchain.com/?ref=blog.langchain.com)。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)



[![Evaluating Deep Agents: Our Learnings](images/aligning-llm-as-a-judge-with-human-preferences/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/aligning-llm-as-a-judge-with-human-preferences/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/aligning-llm-as-a-judge-with-human-preferences/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/aligning-llm-as-a-judge-with-human-preferences/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/aligning-llm-as-a-judge-with-human-preferences/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/aligning-llm-as-a-judge-with-human-preferences/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/aligning-llm-as-a-judge-with-human-preferences/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/aligning-llm-as-a-judge-with-human-preferences/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/aligning-llm-as-a-judge-with-human-preferences/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/aligning-llm-as-a-judge-with-human-preferences/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/aligning-llm-as-a-judge-with-human-preferences/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入公测阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
&#123;% endraw %}
