---
title: "Introducing Align Evals: Streamlining LLM Application Evaluation"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-align-evals/"
date: "2026-02-16"
scraped_at: "2026-03-03T07:14:12.861909533+00:00"
language: "en-zh"
translated: true
description: "Align Evals is a new feature in LangSmith that helps you calibrate your evaluators to better match human preferences."
tags: ["agent builder"]
---

Evaluations are a key technique for improving your application — whether you’re working on a single prompt or a complex agent. As you compare models, update logic, or iterate on your architecture, evaluations are a reliable way to score outputs and understand the impact of your changes.

评估是提升应用程序性能的关键技术——无论您正在优化单个提示词，还是构建复杂的智能体。当您对比不同模型、更新逻辑或迭代系统架构时，评估都能为您提供可靠的输出评分，并帮助您理解各项改动的实际影响。

But, one big challenge we hear consistently from teams is: _"Our evaluation scores don't match what we'd expect a human on our team to say."_ This mismatch leads to noisy comparisons, and time wasted chasing false signals.

但团队普遍反映的一个核心挑战是：_“我们的评估得分与团队内人类评审员的判断结果不一致。”_ 这种偏差会导致评估结果噪声大、可比性差，进而浪费大量时间去追踪错误信号。

That’s why we’re introducing **Align Evals,** a new feature in LangSmith that helps you calibrate your evaluators to better match human preferences. This feature was inspired by [Eugene Yan's article](https://eugeneyan.com/writing/aligneval/?ref=blog.langchain.com) on building LLM-as-a-judge evaluators.

因此，我们正式推出 **Align Evals**——LangSmith 中一项全新功能，旨在帮助您校准评估器（evaluator），使其输出更贴近人类的真实偏好。该功能的设计灵感源自 [Eugene Yan 关于构建“LLM 作为裁判”评估器的文章](https://eugeneyan.com/writing/aligneval/?ref=blog.langchain.com)。

This feature is **available today** for all LangSmith Cloud users and will be released to LangSmith Self-Hosted later this week. View our [video walkthrough](https://www.youtube.com/watch?v=-9o94oj4x0A&ref=blog.langchain.com) or read our [developer docs](https://docs.smith.langchain.com/evaluation/tutorials/aligning_evaluator?ref=blog.langchain.com) to get started.

该功能**即日起已面向所有 LangSmith Cloud 用户开放**，并将于本周晚些时候上线 LangSmith 自托管（Self-Hosted）版本。欢迎观看我们的 [视频演示](https://www.youtube.com/watch?v=-9o94oj4x0A&ref=blog.langchain.com)，或查阅 [开发者文档](https://docs.smith.langchain.com/evaluation/tutorials/aligning_evaluator?ref=blog.langchain.com) 快速上手。

## **Creating high quality LLM-as-a-judge evaluators just got easier**

## **构建高质量“LLM 作为裁判”评估器，现在更简单了**

Until now, iterating on evaluators has often involved a lot of guesswork. It's hard to spot trends or inconsistencies in evaluator behavior and, after making changes to your evaluator prompt, it can be unclear which data points caused scores to shift or why.

过去，评估器的迭代过程往往依赖大量试错。您很难识别评估行为中的趋势或不一致性；而在修改评估器提示词后，也难以判断究竟是哪些数据点导致了评分变化，以及变化背后的原因。

With this new LLM-as-a-Judge Alignment feature, you get:

借助这一全新的“LLM 作为裁判”对齐（Alignment）功能，您将获得以下能力：

- A playground-like interface to iterate on your evaluator prompt and see the evaluator’s “alignment score”  
- 类似交互式沙盒（playground）的界面，支持快速迭代评估器提示词，并实时查看评估器的“对齐得分”（alignment score）  

- Side-by-side comparison of human-graded data and LLM-generated scores, with sorting to identify “unaligned” cases  
- 并排对比人工标注数据与 LLM 生成评分，并支持按偏差排序，快速定位“未对齐”（unaligned）样本  

- A saved baseline alignment score in order to compare your latest changes to the previous version of your prompt  
- 自动保存基准对齐得分，便于将最新修改与提示词历史版本进行量化对比  

![](images/introducing-align-evals-streamlining-llm-application-evaluation/img_001.png)

## **How it works**

## **工作原理**

Here’s how the alignment flow works:

对齐流程的工作方式如下：

**1\. Select evaluation criteria**

**1. 选择评估标准**

The first step is identifying the right evaluation criteria. Your eval criteria should include the things your app should do well. For example, if you’re building a chat app, correctness is important —but so is conciseness. A technically accurate answer that takes many paragraphs to get to the point will still frustrate users.

第一步是确定恰当的评估标准。您的评估标准应涵盖您的应用应当表现优异的各个方面。例如，若您正在开发一款聊天应用，则答案的正确性固然重要，但简洁性同样关键。即使一个技术上完全准确的回答，若需耗费多个段落才切入正题，仍会让用户感到沮丧。

**2\. Select data for human review**

**2. 选取用于人工评审的数据**

Create a set of representative examples from your app. These should cover both good and bad examples —the goal is to cover the range of outputs that your app would actually generate. For example, if you’re working on adding a new product that your customer support assistant can answer questions about, include both correct responses and incorrect ones.

从您的应用中构建一组具有代表性的示例。这些示例应同时涵盖优质与欠佳的输出——目标是全面覆盖您的应用实际可能生成的所有输出类型。例如，若您正在为客服助手新增一项产品支持能力，那么所选示例中就应既包括正确回答，也包括错误回答。

**3\. Grade the data with expected scores**

**3. 使用预期分值对数据进行人工评分**

For each eval criteria, manually assign a score for each example. These scores become your “golden set” which will serve as a benchmark against which the evaluator’s responses will be judged.

针对每一项评估标准，为每个示例手动打分。这些人工评分结果将构成您的“黄金标注集”（golden set），作为后续评判 LLM 评估器输出结果的基准。

**4\. Create an evaluator prompt and test it against the human grading**

**4. 构建评估器提示词，并以人工评分为基准进行测试**

Create an initial prompt for your LLM evaluator and use the the alignment results to iterate. For each version of your prompt, you'll test it against your human-graded examples to see how well your LLM's scores align with yours.

为您的 LLM 评估器设计初始提示词，并依据对齐结果持续迭代优化。针对您提示词的每一版修改，均需使用人工评分的示例集进行测试，以评估您的 LLM 所给出的评分与人工评分的一致程度。

For example, if your LLM consistently over-scores certain responses, try adding clearer negative criteria. Improving your evaluator score is meant to be an iterative process. Learn more about best practices on iterating on your prompt in our [docs](https://docs.smith.langchain.com/evaluation/tutorials/aligning_evaluator?ref=blog.langchain.com#tips-for-improving-evaluator-alignment).

例如，若您的 LLM 持续对某些响应给予过高评分，可尝试在提示词中加入更明确的负面判定标准。提升评估器评分质量本就是一个迭代演进的过程。有关提示词迭代优化的最佳实践，请参阅我们的[文档](https://docs.smith.langchain.com/evaluation/tutorials/aligning_evaluator?ref=blog.langchain.com#tips-for-improving-evaluator-alignment)。

## **What’s next?**

## **接下来呢？**

We’re just getting started. This is the first step towards helping you build better evaluators. Looking ahead, you can expect:

我们才刚刚起步。这是帮助您构建更优评估器的第一步。展望未来，您将可以期待以下功能：

- **Analytics** so you can track how your evaluator’s performance evolves over time.  
- **分析功能**，助您持续追踪评估器性能随时间的变化趋势。  
- **Automatic prompt optimization**, where we automatically generate prompt variations for you!  
- **自动提示词优化**：我们将为您自动生成多种提示词变体！

Give it a try! Get started by [heading to our developer documentation](https://docs.langchain.com/langsmith/improve-judge-evaluator-feedback?ref=blog.langchain.com) or watch our [video tutorial](https://youtu.be/-9o94oj4x0A?ref=blog.langchain.com). Let us know what you think by providing feedback in the [LangChain Community forum](https://forum.langchain.com/t/introducing-align-evals-streamlining-llm-application-evaluation/817?ref=blog.langchain.com).

快来试一试吧！立即开始，可前往我们的[开发者文档](https://docs.langchain.com/langsmith/improve-judge-evaluator-feedback?ref=blog.langchain.com)，或观看我们的[视频教程](https://youtu.be/-9o94oj4x0A?ref=blog.langchain.com)。欢迎在[LangChain 社区论坛](https://forum.langchain.com/t/introducing-align-evals-streamlining-llm-application-evaluation/817?ref=blog.langchain.com)中分享您的想法与反馈。

### Tags

### 标签

[![Agent Builder now available in Public Beta](images/introducing-align-evals-streamlining-llm-application-evaluation/img_002.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试](images/introducing-align-evals-streamlining-llm-application-evaluation/img_002.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Catch production failures early with LangSmith Alerts](images/introducing-align-evals-streamlining-llm-application-evaluation/img_003.png)](https://blog.langchain.com/langsmith-alerts/)

[![借助 LangSmith Alerts 提前捕获生产环境故障](images/introducing-align-evals-streamlining-llm-application-evaluation/img_003.png)](https://blog.langchain.com/langsmith-alerts/)

[**Catch production failures early with LangSmith Alerts**](https://blog.langchain.com/langsmith-alerts/)

[**使用 LangSmith Alerts 尽早发现生产环境故障**](https://blog.langchain.com/langsmith-alerts/)


[![Pairwise Evaluations with LangSmith](images/introducing-align-evals-streamlining-llm-application-evaluation/img_004.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![使用 LangSmith 进行成对评估](images/introducing-align-evals-streamlining-llm-application-evaluation/img_004.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**使用 LangSmith 进行成对评估**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)


[![Access Control Updates for LangSmith](images/introducing-align-evals-streamlining-llm-application-evaluation/img_005.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[![LangSmith 访问控制更新](images/introducing-align-evals-streamlining-llm-application-evaluation/img_005.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**LangSmith 访问控制更新**](https://blog.langchain.com/access-control-updates-for-langsmith/)


[![LangSmith's Latest Feature: Grouped Monitoring Charts](images/introducing-align-evals-streamlining-llm-application-evaluation/img_006.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[![LangSmith 最新功能：分组监控图表](images/introducing-align-evals-streamlining-llm-application-evaluation/img_006.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith's Latest Feature: Grouped Monitoring Charts**](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith 最新功能：分组监控图表**](https://blog.langchain.com/grouped-monitoring-charts/)