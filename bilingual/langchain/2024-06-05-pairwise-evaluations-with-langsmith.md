---
title: "Pairwise Evaluations with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/pairwise-evaluations-with-langsmith/"
date: "2024-06-05"
scraped_at: "2026-03-03T08:01:55.435681728+00:00"
language: "en-zh"
translated: true
description: "Learn what pairwise evaluation is, why you might need it for LLM app development, and see an example of how to use it in LangSmith by LangChain."
tags: ["agent builder"]
---

Evaluating model outputs is one of the most important challenges in LLM application development. But human preference for many tasks (e.g., chat or writing) is difficult to encode in a set of rules. Instead, pairwise evaluation of multiple candidate LLM answers can be a more effective way to teach LLMs human preference.

评估模型输出是大语言模型（LLM）应用开发中最重要的挑战之一。然而，对于许多任务（例如对话或写作），人类偏好难以用一套规则来精确编码。相比之下，对多个候选 LLM 回答进行两两比较（pairwise evaluation），反而是一种更有效的方式，可用于向 LLM 传授人类偏好。

Below, we explain what pairwise evaluation is, why you might need it, and present a walk-through example of how to use LangSmith’s latest pairwise evaluators in your LLM-app development workflow.

下文我们将解释什么是两两比较评估、为何你可能需要它，并通过一个实操示例，演示如何在你的 LLM 应用开发工作流中使用 LangSmith 最新推出的两两比较评估器（pairwise evaluator）。

## The origin of pairwise evaluation

## 两两比较评估的起源

Pairwise evaluation has started to play an important role in conversations on testing and benchmarking LLM model performance. For example, reinforcement learning from human feedback (i.e. [RLHF](https://cameronrwolfe.substack.com/p/the-story-of-rlhf-origins-motivations?ref=blog.langchain.com)) employs the concept of pairwise evaluation in LLM alignment. Human trainers are presented with pairs of LLM responses for the same input and select which one better aligns with certain criteria (e.g., helpfulness, informativeness, or safety).

两两比较评估已在关于 LLM 模型性能测试与基准评测的讨论中开始扮演重要角色。例如，“基于人类反馈的强化学习”（即 [RLHF](https://cameronrwolfe.substack.com/p/the-story-of-rlhf-origins-motivations?ref=blog.langchain.com)）就在 LLM 对齐（alignment）过程中采用了两两比较评估的理念：人类训练员会看到针对同一输入的两个 LLM 回复，并从中选出更符合特定标准（如“有帮助性”“信息丰富性”或“安全性”）的一个。

One of the most popular LLM benchmarks, [Chatbot Arena](https://lmsys.org/blog/2023-05-03-arena/?ref=blog.langchain.com), also employs this idea: it presents two anonymous LLM generations for a given user prompt and allows the user to pick the better one. While the Chatbot Arena relies on human feedback for pairwise evaluation, it’s also possible to use [LLM-as-a-judge](https://arxiv.org/pdf/2306.05685?ref=blog.langchain.com) to [predict human preference](https://huyenchip.com/2024/02/28/predictive-human-preference.html?ref=blog.langchain.com) and automate this pairwise evaluation process.

目前最受欢迎的 LLM 基准评测平台之一——[Chatbot Arena](https://lmsys.org/blog/2023-05-03-arena/?ref=blog.langchain.com)——也采用了这一理念：它针对给定用户提示（prompt）展示两个匿名的 LLM 生成结果，并允许用户选择其中更优的一个。尽管 Chatbot Arena 依赖人工反馈完成两两比较评估，但我们也完全可以借助 [LLM-as-a-judge](https://arxiv.org/pdf/2306.05685?ref=blog.langchain.com) 技术，[预测人类偏好](https://huyenchip.com/2024/02/28/predictive-human-preference.html?ref=blog.langchain.com)，从而实现该评估过程的自动化。

Despite its popularity in public benchmarking and LLM alignment, many users may not know how to use custom pairwise evaluation to improve their LLM applications. With this limitation in mind, we’ve added pairwise evaluation as a new feature in LangSmith.

尽管两两比较评估在公开基准评测和 LLM 对齐领域已广受欢迎，许多用户却并不清楚如何利用自定义的两两比较评估来提升自己的 LLM 应用效果。正因意识到这一局限，我们已在 LangSmith 中将两两比较评估作为一项全新功能正式推出。

## Pairwise evaluators in LangSmith

## LangSmith 中的两两比较评估器

LangSmith’s pairwise evaluation allows the user to (1) define a custom pairwise LLM-as-judge evaluator using any desired criteria and (2) compare two LLM generations using this evaluator. Instead of selecting runs to compare, you'll see a new sub-header called "Pairwise Experiments" when you click on the "Datasets and Testing" tab.

LangSmith 的两两比较评估功能支持用户：（1）依据任意所需标准，定义专属的“LLM 作为裁判”（LLM-as-a-judge）两两比较评估器；（2）使用该评估器对两个 LLM 生成结果进行比对。与以往需手动选择待比较运行（runs）不同，当你点击“数据集与测试”（Datasets and Testing）标签页时，将看到一个名为“两两比较实验”（Pairwise Experiments）的全新子标题。

### How is this different than the comparison view?

### 这与“对比视图”（Comparison View）有何不同？

In case you missed it, a few weeks ago we released an improved comparison view for [regression testing](https://blog.langchain.com/regression-testing/). This allows you to compare two runs and identify regressions. Pairwise evaluation is similar in goal, but markedly different in implemention.

如果您此前尚未关注，几周前我们发布了改进版的[回归测试](https://blog.langchain.com/regression-testing/)对比视图。该功能支持您对两次运行结果进行比对，并识别其中的性能退化问题。成对评估（pairwise evaluation）在目标上与此类似，但在实现方式上却有显著差异。

In the previous comparison view, you would evaluate each run individually and then compare the scores. For example, you would give each run a grade on a scale of 1-10 (independently) and then look for cases where one run got a higher grade than another.

在先前的对比视图中，您需分别对每次运行结果独立打分，再横向比较分数。例如，您会为每次运行结果单独评定一个 1–10 分的等级（彼此独立），然后查找某次运行得分明显高于另一次的情形。

Pairwise evaluation looks at the results **at the same time**. This allows you to define an evaluator that explicitly compares the two results. You then get a score for that pair. It is not scoring each run individually.

成对评估则**同时审视两个结果**。这使您能够定义一个专门用于直接比较二者输出的评估器；最终得到的是该“结果对”的单一评分，而非对每次运行结果分别打分。

### When might you use pairwise evaluation?

### 何时应使用成对评估？

To motivate this feature, [this video](https://youtu.be/yskkOAfTwcQ?ref=blog.langchain.com) shows a common use-case related to content generation. In this example, we want an LLM to produce engaging Tweets summarizing academic papers. We built a dataset with 10 different papers as example ( [here](https://smith.langchain.com/public/659b07af-1cab-4e18-b21a-91a69a4c3990/d?ref=blog.langchain.com)) and generated summaries from 4 different LLMs.

为说明该功能的价值，[本视频](https://youtu.be/yskkOAfTwcQ?ref=blog.langchain.com)展示了一个内容生成领域的典型应用场景：我们希望大语言模型（LLM）生成富有吸引力的推文（Tweet），用以概括学术论文。为此，我们构建了一个包含 10 篇不同论文的数据集（[示例链接](https://smith.langchain.com/public/659b07af-1cab-4e18-b21a-91a69a4c3990/d?ref=blog.langchain.com)），并使用 4 种不同的 LLM 分别生成摘要。

Because there is no single “ground truth” paper summary that we want an LLM to generate, we used a [criteria evaluator](https://docs.smith.langchain.com/old/evaluation/faq/evaluator-implementations?ref=blog.langchain.com#criteria-evaluators-no-labels) with [this](https://smith.langchain.com/hub/rlm/tweet-summary-evaluator/?ref=blog.langchain.com) evaluation prompt to grade the summary Tweet from 1 (worst) to 5 (best) based upon 5 criteria (e.g., use of emojis, engaging title, etc).

由于并不存在唯一、权威的“标准答案”式论文摘要供 LLM 模仿生成，我们采用了一种[基于准则的评估器（criteria evaluator）](https://docs.smith.langchain.com/old/evaluation/faq/evaluator-implementations?ref=blog.langchain.com#criteria-evaluators-no-labels)，配合[此评估提示词](https://smith.langchain.com/hub/rlm/tweet-summary-evaluator/?ref=blog.langchain.com)，依据 5 项具体标准（例如：是否使用表情符号、标题是否引人入胜等），对每条摘要推文进行 1（最差）至 5（最佳）的打分。

![](images/pairwise-evaluations-with-langsmith/img_001.png)

![](images/pairwise-evaluations-with-langsmith/img_001.png)

We capture this summary\_engagement\_score in the dataset, as shown below.

我们在数据集中记录了该 `summary_engagement_score`（摘要参与度得分），如下图所示。

![](images/pairwise-evaluations-with-langsmith/img_002.png)

![](images/pairwise-evaluations-with-langsmith/img_002.png)

However, this immediately highlights a problem: 3 of the 4 LLMs all have a **perfect score** on our summary\_engagement\_score, with no differentiation between them. In isolation, it can be difficult to define a criteria evaluator that distinguishes between the various LLMs. However, pairwise evaluation presents an alternative way to approach this challenge.

然而，这一做法立刻暴露出一个问题：在我们的 `summary_engagement_score` 评分中，4 个 LLM 中有 **3 个均获得满分**，彼此之间毫无区分度。若仅依赖单点打分式的准则评估器，往往难以精准刻画各 LLM 输出质量的细微差异。而此时，成对评估便提供了一种全新的、更具判别力的应对思路。

### Using Custom Pairwise Evaluation

### 使用自定义成对评估

As shown in the [video](https://youtu.be/yskkOAfTwcQ?ref=blog.langchain.com) (docs [here](https://docs.smith.langchain.com/how_to_guides/evaluation/evaluate_pairwise?ref=blog.langchain.com)), we use custom pairwise evaluators in the LangSmith SDK and visualize the results of pairwise evaluations in the LangSmith UI. To apply these to the problem mentioned above, we first define a [pairwise evaluation prompt](https://smith.langchain.com/hub/rlm/pairwise-evaluation-tweet-summary?ref=blog.langchain.com) that encodes the criteria we care about (e.g., which of the two Tweet summaries is more engaging based on the title, bullet points, etc). We then simply run our custom evaluator, `evaluate_pairwise`, on any two experiments that have been already run on our dataset (see full code used [here](https://github.com/langchain-ai/langchain/blob/667c329770869ea921b80cc7850d73e40134b051/cookbook/langsmith_intro.ipynb?ref=blog.langchain.com)).

如[视频](https://youtu.be/yskkOAfTwcQ?ref=blog.langchain.com)（文档见[此处](https://docs.smith.langchain.com/how_to_guides/evaluation/evaluate_pairwise?ref=blog.langchain.com)）所示，我们在 LangSmith SDK 中使用自定义成对评估器，并在 LangSmith 用户界面中可视化成对评估结果。为将该方法应用于上述问题，我们首先定义一个[成对评估提示词](https://smith.langchain.com/hub/rlm/pairwise-evaluation-tweet-summary?ref=blog.langchain.com)，其中编码了我们所关注的评估标准（例如：基于标题、要点列表等，两个推文摘要中哪一个更具吸引力）。随后，我们只需在数据集上已运行过的任意两个实验上，调用自定义评估器 `evaluate_pairwise` 即可（完整代码参见[此处](https://github.com/langchain-ai/langchain/blob/667c329770869ea921b80cc7850d73e40134b051/cookbook/langsmith_intro.ipynb?ref=blog.langchain.com)）。

```
from langsmith.evaluation import evaluate_comparative
evaluate_comparative(
    ["summary-cmd-r-f692a55c", "summary-opus-21590361"],
    evaluators=[evaluate_pairwise],
)
```

```
from langsmith.evaluation import evaluate_comparative
evaluate_comparative(
    ["summary-cmd-r-f692a55c", "summary-opus-21590361"],
    evaluators=[evaluate_pairwise],
)
```

In the UI, we will then see the results of all pairwise evaluation in the Pairwise Experiments tab of our Dataset. Importantly, we see that pairwise evaluation shows clear preference for certain LLMs over others – unlike the stand-alone criteria evaluation, which shows little discrimination.

在用户界面中，我们将在数据集的“成对实验”（Pairwise Experiments）标签页下查看全部成对评估结果。尤为重要的是，成对评估清晰地显示出对某些大语言模型（LLM）的明显偏好——而独立的标准式评估则几乎无法区分模型优劣。

![](images/pairwise-evaluations-with-langsmith/img_003.png)

![](images/pairwise-evaluations-with-langsmith/img_003.png)

[The UI](https://smith.langchain.com/public/659b07af-1cab-4e18-b21a-91a69a4c3990/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&ref=blog.langchain.com) allows us to dive into each pairwise experiment, showing which LLM generation is preferred based upon our criteria (with color and thumbs at the top of the column). By clicking on the `ranked_preference` score under each answer, we can drill further into each evaluation trace (see example [here](https://smith.langchain.com/public/1660c5c9-884a-4e06-9503-e1bab5f19cb3/r?ref=blog.langchain.com)), which provides an explanation for the ranking (as defined [in our prompt](https://smith.langchain.com/hub/rlm/pairwise-evaluation-tweet-summary?ref=blog.langchain.com)).

通过[用户界面](https://smith.langchain.com/public/659b07af-1cab-4e18-b21a-91a69a4c3990/d?paginationState=%7B%22pageIndex%22%3A0%2C%22pageSize%22%3A10%7D&ref=blog.langchain.com)，我们可以深入查看每个成对实验，直观显示依据我们设定的标准更受偏好的 LLM 生成结果（列顶部以颜色和拇指图标标识）。点击每个答案下方的 `ranked_preference` 得分，即可进一步展开对应的评估追踪记录（示例见[此处](https://smith.langchain.com/public/1660c5c9-884a-4e06-9503-e1bab5f19cb3/r?ref=blog.langchain.com)），其中包含排名判定的详细解释（该逻辑由[我们的提示词](https://smith.langchain.com/hub/rlm/pairwise-evaluation-tweet-summary?ref=blog.langchain.com)明确定义）。

![](images/pairwise-evaluations-with-langsmith/img_004.png)

![](images/pairwise-evaluations-with-langsmith/img_004.png)

## Conclusion

## 结论

Many LLM use-cases, such as text generation or chat, don’t have a single or specific “correct” answer for use in evaluation. In these cases, pairwise evaluation with a human or LLM picking the preferred response is a powerful approach.

许多大语言模型（LLM）应用场景（例如文本生成或对话系统）并不存在唯一或明确的“正确答案”，因而难以直接用于传统评估。在此类情形下，采用人工或另一 LLM 对比选择更优响应的成对评估方法，是一种极为有效的评估策略。

In this blog post, we showed how we were able to test on an ambiguous task of evaluating Tweet summary generation and revealed the shortcomings of a stand-alone evaluation criteria. Our [custom pairwise evaluator](https://smith.langchain.com/hub/rlm/pairwise-evaluation-lcel-answers?ref=blog.langchain.com) allowed us to directly compare our generations against each other, highlighting a clear preference between models.

本文博客展示了我们如何针对推文摘要生成这一模糊性任务开展测试，并揭示了独立式评估标准的局限性。借助我们的[自定义成对评估器](https://smith.langchain.com/hub/rlm/pairwise-evaluation-lcel-answers?ref=blog.langchain.com)，我们得以直接横向比较不同模型的生成结果，从而清晰识别出各模型间的性能差异与偏好倾向。

* * *

**To dive deeper, check out** [**our video**](https://youtu.be/yskkOAfTwcQ?ref=blog.langchain.com) **and** [**documentation**](https://docs.smith.langchain.com/how_to_guides/evaluation/evaluate_pairwise?ref=blog.langchain.com) **on pairwise evaluation. And you can** [**try out LangSmith**](https://smith.langchain.com/?ref=blog.langchain.dev) **today for robust experimentation and evaluation, with support for prompt versioning, debugging, and human annotations — so you can gain production observability as you build your LLM-apps.**

**如需深入了解，请观看我们的视频并查阅关于成对评估（pairwise evaluation）的文档。您还可立即试用 LangSmith，开展稳健的实验与评估——它支持提示词版本管理、调试及人工标注功能，助您在构建大语言模型应用（LLM-apps）的过程中实现生产级可观测性。**

### Tags

### 标签

[![Agent Builder now available in Public Beta](images/pairwise-evaluations-with-langsmith/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[![Agent Builder 现已开放公开测试版](images/pairwise-evaluations-with-langsmith/img_005.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试版**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/pairwise-evaluations-with-langsmith/img_006.png)](https://blog.langchain.com/introducing-align-evals/)

[![推出 Align Evals：简化大语言模型应用评估流程](images/pairwise-evaluations-with-langsmith/img_006.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)

[**推出 Align Evals：简化大语言模型应用评估流程**](https://blog.langchain.com/introducing-align-evals/)


[![Catch production failures early with LangSmith Alerts](images/pairwise-evaluations-with-langsmith/img_007.png)](https://blog.langchain.com/langsmith-alerts/)

[![借助 LangSmith Alerts 提前发现生产环境故障](images/pairwise-evaluations-with-langsmith/img_007.png)](https://blog.langchain.com/langsmith-alerts/)

[**Catch production failures early with LangSmith Alerts**](https://blog.langchain.com/langsmith-alerts/)

[**使用 LangSmith Alerts 尽早发现生产环境故障**](https://blog.langchain.com/langsmith-alerts/)


[![Access Control Updates for LangSmith](images/pairwise-evaluations-with-langsmith/img_008.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[![LangSmith 访问控制更新](images/pairwise-evaluations-with-langsmith/img_008.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**LangSmith 访问控制更新**](https://blog.langchain.com/access-control-updates-for-langsmith/)


[![LangSmith's Latest Feature: Grouped Monitoring Charts](images/pairwise-evaluations-with-langsmith/img_009.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[![LangSmith 最新功能：分组监控图表](images/pairwise-evaluations-with-langsmith/img_009.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith's Latest Feature: Grouped Monitoring Charts**](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith 最新功能：分组监控图表**](https://blog.langchain.com/grouped-monitoring-charts/)