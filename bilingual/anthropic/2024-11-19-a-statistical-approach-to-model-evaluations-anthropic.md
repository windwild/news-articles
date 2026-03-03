---
title: "A statistical approach to model evaluations \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/statistical-approach-to-model-evals"
date: "2024-11-19"
scraped_at: "2026-03-03T07:07:20.850281842+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

Evaluations

评估

# A statistical approach to model evaluations

# 模型评估的一种统计学方法

Nov 19, 2024

2024年11月19日

[Read the paper](https://arxiv.org/abs/2411.00640)

[阅读论文](https://arxiv.org/abs/2411.00640)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这一指标为衡量当今人类与 AI 协作的现状提供了基准。

Suppose an AI model outperforms another model on a benchmark of interest—testing its general knowledge, for example, or its ability to solve computer-coding questions. Is the difference in capabilities real, or could one model simply have gotten lucky in the choice of questions on the benchmark?

假设某 AI 模型在某个感兴趣的基准测试中表现优于另一模型——例如测试其通用知识，或其解决计算机编程问题的能力。这种能力差异是真实存在的，还是其中某一模型仅仅因基准测试所选题目而“运气较好”？

With the amount of public interest in AI model evaluations—informally called “evals”—this question remains surprisingly understudied among the AI research community. This month, we published a [new research paper](https://arxiv.org/abs/2411.00640) that attempts to answer the question rigorously. Drawing on statistical theory and the experiment design literature, the paper makes a number of recommendations to the AI research community for reporting eval results in a scientifically informative way. In this post, we briefly go over the reporting recommendations, and the logic behind them.

鉴于公众对 AI 模型评估（非正式地称为 “evals”）的高度关注，这一问题在 AI 研究界却出人意料地缺乏深入研究。本月，我们发表了一篇[新的研究论文](https://arxiv.org/abs/2411.00640)，尝试以严谨方式回答该问题。该论文借鉴统计学理论与实验设计领域的研究成果，向 AI 研究界提出多项建议，旨在以更具科学信息量的方式报告评估结果。本文将简要概述这些报告建议及其背后的逻辑依据。

## Recommendation #1: Use the Central Limit Theorem

## 建议 #1：运用中心极限定理

Evals often consist of hundreds or thousands of unrelated questions. [MMLU](https://arxiv.org/abs/2009.03300v3), for instance, contains questions as diverse as:

评估任务（evals）通常包含数百甚至数千道彼此无关的问题。例如，[MMLU](https://arxiv.org/abs/2009.03300v3) 中的问题涵盖范围极广，包括：

- Who discovered the first virus?  
- 谁发现了第一种病毒？

- What is the inverse of 𝑓(𝑥)=4−5𝑥?  
- 函数 𝑓(𝑥) = 4 − 5𝑥 的反函数是什么？

- Who said that “Jurisprudence is the eye of law”?  
- 谁提出“法学是法律之眼”这一论断？

To compute an overall eval score, each question is separately scored, and then the overall score is (usually) a simple average of these question scores. Typically, researchers focus their attention on this observed average. But in our paper, we argue that the real object of interest should not be the _observed_ average, but rather the _theoretical_ average across all possible questions. So if we imagine that eval questions were drawn from an unseen “question universe,” we can learn about the average score in that universe—that is, we can measure the underlying _skill_, independent of the “luck of the draw”—using statistical theory.

为计算整体评估得分，每道题被单独评分，然后整体得分（通常）取这些题目得分的简单算术平均值。研究人员通常将注意力集中于这一**观测到的平均值**上。但在我们的论文中，我们主张：真正值得关注的对象不应是该**观测平均值**，而应是所有可能问题上的**理论平均值**。因此，若我们将评估题目设想为从一个未被观测到的“题目宇宙”中随机抽取，则可借助统计学理论推断该宇宙中的平均得分——即，我们得以衡量模型内在的**能力（skill）**，而不受具体抽题结果（即“抽题运气”）的影响。

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_001.jpg)If we imagine that eval questions were drawn from a “question universe,” then eval scores will tend to follow a normal distribution, centered around the average score of all possible questions.

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_001.jpg)倘若我们将评估题目视为从一个“题目宇宙”中抽取，则评估得分将趋于服从正态分布，其均值即为该宇宙中所有可能题目的平均得分。

This formulation buys us analytic robustness: if a new eval were to be created with questions having the same difficulty distribution as the original eval, we should generally expect our original conclusions to hold.

这一建模方式赋予我们分析上的稳健性：若新构建的评估任务所含题目具有与原始评估任务相同的难度分布，则我们原先得出的结论通常仍可成立。

In technical terms: under the fairly mild conditions of the [Central Limit Theorem](https://en.wikipedia.org/wiki/Central_limit_theorem), the mean values of several random samples taken from the same underlying distribution will tend to follow a [normal distribution](https://en.wikipedia.org/wiki/Normal_distribution). The standard deviation (or width) of that normal distribution is commonly known as the [standard error of the mean](https://en.wikipedia.org/wiki/Standard_error), or SEM. In our paper, we encourage researchers to report the SEM, derived from the Central Limit Theorem, alongside each calculated eval score—and we show researchers how to use the SEM to quantify the difference in theoretical means between two models. A 95% [confidence interval](https://en.wikipedia.org/wiki/Confidence_interval) can be calculated from the SEM by adding and subtracting 1.96 × SEM from the mean score.

从技术角度而言：在[中心极限定理](https://en.wikipedia.org/wiki/Central_limit_theorem)所要求的相当宽松条件下，从同一底层分布中抽取的多个随机样本的均值，将趋于服从[正态分布](https://en.wikipedia.org/wiki/Normal_distribution)。该正态分布的标准差（即其离散程度）通常被称为[均值标准误](https://en.wikipedia.org/wiki/Standard_error)（Standard Error of the Mean, SEM）。在我们的论文中，我们建议研究人员在报告每一项计算所得的评估得分时，同时报告由中心极限定理导出的 SEM；并进一步向研究人员展示如何利用 SEM 来量化两个模型理论均值之间的差异。一个 95% 的[置信区间](https://en.wikipedia.org/wiki/Confidence_interval)可通过在均值得分上加减 1.96 × SEM 得到。

## Recommendation #2: Cluster standard errors

## 建议 #2：对标准误进行聚类处理

Many evals violate the above assumption of independently selected questions, and instead consist of groups of closely related questions. For example, several questions in a reading-comprehension eval may ask about the same passage of text. Popular evals that follow this pattern include [DROP](https://aclanthology.org/N19-1246/), [QuAC](https://arxiv.org/abs/1808.07036), [RACE](https://aclanthology.org/D17-1082/), and [SQuAD](https://arxiv.org/abs/1806.03822).

许多评估任务违反了前述“题目相互独立”的假设，转而由若干组高度相关的问题构成。例如，在阅读理解类评估中，多道题目可能均围绕同一篇文本展开提问。遵循这一模式的主流评估任务包括 [DROP](https://aclanthology.org/N19-1246/)、[QuAC](https://arxiv.org/abs/1808.07036)、[RACE](https://aclanthology.org/D17-1082/) 和 [SQuAD](https://arxiv.org/abs/1806.03822)。

For these evals, each question’s selection from the “question universe” is no longer independent. Because including several questions about the same passage of text will yield less information than selecting the same number of questions about different passages of text, a naive application of the Central Limit Theorem to the case of non-independent questions will lead us to underestimate the standard error—and potentially mislead analysts into drawing incorrect conclusions from the data.

对于这类评估任务，各题目从“题目宇宙”中被选取的过程已不再相互独立。由于围绕同一篇文本设置多道题目所提供的信息量，远低于围绕不同文本设置同等数量的题目，若对非独立题目情形草率套用中心极限定理，将导致我们低估标准误——进而可能误导分析人员，使其基于数据得出错误结论。

Fortunately, the problem of [clustered standard errors](https://en.wikipedia.org/wiki/Clustered_standard_errors) has been extensively studied in the social sciences. When the inclusion of questions is non-independent, we recommend clustering standard errors on the unit of [randomization](https://en.wikipedia.org/wiki/Randomization) (for example, passage of text), and we provide applicable formulas in our paper.

幸运的是，[聚类标准误](https://zh.wikipedia.org/wiki/%E8%81%9A%E7%B1%BB%E6%A0%87%E5%87%86%E8%AF%AF)问题在社会科学领域已得到广泛研究。当题目选取存在非独立性时，我们建议以[随机化单位](https://zh.wikipedia.org/wiki/%E9%9A%8F%E6%9C%BA%E5%8C%96)（例如一段文本）为聚类层级来计算聚类标准误，并在论文中提供了相应公式。

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_002.jpg)If questions arrive in related clusters—a common pattern in reading-comprehension evals—eval scores will be more spread-out compared to the non-clustered case.

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_002.jpg)若题目以相关簇的形式出现——这在阅读理解类评测中十分常见——则评测得分的离散程度将高于非聚类情形。

In practice, we have found that clustered standard errors on popular evals can be over three times as large as naive standard errors. Ignoring question clustering may lead researchers to inadvertently detect a difference in model capabilities when in fact none exists.

实践中，我们发现主流评测任务中采用聚类标准误所得结果，可能高达简单标准误的三倍以上。忽略题目聚类结构，可能导致研究者错误地识别出模型能力的差异，而实际上并不存在这种差异。

## Recommendation \#3: Reduce variance within questions

## 建议 #3：降低单个题目内部的方差

Variance is a measurement of how spread-out a random variable is. The variance of an eval score is the square of the standard error of the mean, discussed above; this quantity depends on the amount of variance in the score on each individual eval question.

方差用于衡量一个随机变量的离散程度。如前所述，评测得分的方差即为均值标准误的平方；该数值取决于每个单独评测题目的得分所具有的方差大小。

A key insight of our paper is to decompose a model’s score on a particular question into two terms that are added together:

我们论文的一项关键洞见是：将模型在某一特定题目上的得分分解为两个相加的组成部分：

- The mean score (the average score that the model would achieve if asked the same question an infinite number of times—even if the model might produce a different answer each time); and  
- 平均得分（即模型在无限次重复回答同一题目时所能获得的平均分——即使每次生成的答案可能不同）；以及  
- A random component (the difference between a realized question score and the mean score for that question).  
- 随机成分（某次实际作答得分与该题平均得分之间的差值）。

Thanks to the [law of total variance](https://en.wikipedia.org/wiki/Law_of_total_variance), reducing the variance in the random component directly leads to a smaller standard error of the overall mean, and thus greater statistical precision. Our paper highlights two strategies for reducing variance in the random component depending on whether or not the model is asked to think step by step before answering (a prompting technique known as CoT, or chain-of-thought reasoning).

得益于[全方差公式](https://zh.wikipedia.org/wiki/%E5%85%A8%E6%96%B9%E5%B7%AE%E5%85%AC%E5%BC%8F)，降低随机成分的方差可直接减小总体均值的标准误，从而提升统计精度。我们的论文根据模型是否被要求在作答前进行逐步推理（一种称为 CoT 或“思维链”（chain-of-thought）的提示技术），提出了两种降低随机成分方差的策略。

If an eval uses chain-of-thought reasoning, we recommend resampling answers from the same model several times, and using the question-level averages as the question scores fed into the Central Limit Theorem. We note that the [Inspect framework](https://github.com/UKGovernmentBEIS/inspect_ai/) correctly computes standard errors in this way via its [_epochs_ parameter](https://inspect.ai-safety-institute.org.uk/scorers.html#sec-reducing-epochs).

若评测采用思维链推理方式，我们建议对同一模型多次采样生成答案，并以每道题目的平均得分为输入，代入中心极限定理进行分析。我们注意到，[Inspect 框架](https://github.com/UKGovernmentBEIS/inspect_ai/) 通过其 [_epochs_ 参数](https://inspect.ai-safety-institute.org.uk/scorers.html#sec-reducing-epochs) 正确实现了此类标准误计算。

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_003.jpg)If a model produces answers non-deterministically, then generating (and grading) several answers per question will result in less spread-out eval scores.

![](images/a-statistical-approach-to-model-evaluations-anthropic/img_003.jpg)若模型生成答案具有非确定性，则针对每道题目生成（并评分）多个答案，将使评测得分更为集中、离散程度更低。

If the eval does not use chain-of-thought reasoning (i.e., its answers are not “path dependent”), we note that the random component in the score may often be eliminated altogether using next-token probabilities from the language model. For example, if the correct answer to a multiple-choice question is “B”, we would simply use the probability of the model producing the token “B” as the question score. We are not aware of an open-source evals framework which implements this technique.

如果评测（eval）不采用思维链（chain-of-thought）推理（即其答案并非“路径依赖”），我们注意到：利用语言模型的下一个词（next-token）概率，往往可以完全消除评分中的随机成分。例如，若某道多选题的正确答案是“B”，我们可直接将模型生成词元“B”的概率作为该题的得分。目前我们尚未知悉有任何开源评测框架实现了这一技术。

## Recommendation \#4: Analyze paired differences

## 建议 \#4：分析配对差值

Eval scores don’t have any meaning on their own; they only make sense in relation to one another (one model outperforms another model, or ties another model, or outperforms a person). But could a measured difference between two models be due to the specific choice of questions in the eval, and randomness in the models’ answers? We can find out with a [two-sample _t_-test](https://en.wikipedia.org/wiki/Student%27s_t-test), using only the standard errors of the mean calculated from both eval scores.

评测分数本身并无绝对意义；其价值仅体现在相互比较之中（例如：某一模型优于另一模型，或与之持平，或优于人类）。但两个模型之间测得的差异，是否可能源于评测所选题目的特定构成，以及模型作答时的随机性？我们仅需利用两组评测分数各自计算出的均值标准误，即可通过[双样本 _t_ 检验](https://zh.wikipedia.org/wiki/学生t检验)来判断这一点。

However, a two-sample test ignores the hidden structure inside eval data. Since the question list is shared across models, conducting a [paired-differences test](https://en.wikipedia.org/wiki/Paired_difference_test) lets us eliminate the variance in question difficulty and focus on the variance in responses. In our paper, we show how the result of a paired-differences test will be related to the [Pearson correlation coefficient](https://en.wikipedia.org/wiki/Pearson_correlation_coefficient) between two models’ question scores. When the correlation coefficient is higher, the standard error of the mean difference will be smaller.

然而，双样本检验忽略了评测数据内部的隐含结构。由于所有模型面对的是同一套题目列表，采用[配对差值检验](https://zh.wikipedia.org/wiki/配对差值检验)可消除题目难度差异带来的方差，从而聚焦于模型响应本身的方差。在我们的论文中，我们阐明了配对差值检验的结果如何与两个模型在各题目上得分之间的[皮尔逊相关系数](https://zh.wikipedia.org/wiki/皮尔逊相关系数)相关联：相关系数越高，均值差的标准误就越小。

In practice, we find the correlation of question scores on popular evals between frontier models to be substantial—between 0.3 and 0.7 on a scale of −1 to +1. Put another way, frontier models have an overall tendency to get the same questions right and wrong. Paired-difference analysis thus represents a “free” variance reduction technique that is very well suited for AI model evals. Therefore, in the interest of extracting the clearest signal from the data, our paper recommends reporting pairwise information—mean differences, standard errors, confidence intervals, and correlations—whenever two or more models are being compared.

实践中，我们在主流前沿模型间、在多个流行评测上的题目得分相关性较强——相关系数普遍介于 −1 到 +1 区间内的 0.3 至 0.7 之间。换言之，前沿模型总体上倾向于在相同题目上同时答对或同时答错。因此，配对差值分析是一种“零成本”的方差缩减技术，极其适用于 AI 模型评测。为从数据中提取最清晰的信号，本文建议：只要涉及两个或更多模型的比较，就应报告成对信息——包括均值差、标准误、置信区间及（模型间）相关系数。

## Recommendation \#5: Use power analysis

## 建议 \#5：开展统计功效分析（Power Analysis）

The flip side of the statistical significance coin is statistical power, which is the ability of a statistical test to detect a difference between two models, assuming such a difference exists. If an eval doesn’t have very many questions, confidence intervals associated with any statistical tests will tend to be wide. This means that models will need to have a large underlying difference in capabilities in order to register a statistically significant result—and that small differences will likely go undetected. Power analysis refers to the mathematical relationship between observation count, [statistical power](https://en.wikipedia.org/wiki/Power_(statistics)), the [false positive rate](https://en.wikipedia.org/wiki/False_positive_rate), and the [effect size](https://en.wikipedia.org/wiki/Effect_size) of interest.

统计显著性的另一面是统计功效（statistical power），即一项统计检验在真实存在差异的前提下，成功识别出两个模型之间差异的能力。若某项评测题目数量有限，则任何统计检验所得的置信区间往往会较宽。这意味着：只有当模型间能力存在较大实质性差异时，才可能获得统计显著结果；而细微差异则极可能被忽略。统计功效分析描述的是观测数量、[统计功效](https://zh.wikipedia.org/wiki/统计功效)、[假阳性率](https://zh.wikipedia.org/wiki/假阳性率)以及所关注的[效应量](https://zh.wikipedia.org/wiki/效应量)四者之间的数学关系。

In our paper, we show how to apply concepts from power analysis to evals. Specifically, we show researchers how to formulate a hypothesis (such as _Model A outperforms Model B by 3 percentage points_) and calculate the number of questions that an eval should have in order to test this hypothesis against the null hypothesis (such as _Model A and Model B are tied_).

在本文中，我们展示了如何将统计功效分析的概念应用于模型评测。具体而言，我们指导研究者如何提出一个假设（例如：“模型 A 比模型 B 高出 3 个百分点”），并据此计算出评测所需包含的题目数量，以使该假设能与零假设（例如：“模型 A 与模型 B 表现持平”）进行有效检验。

We believe that power analysis will prove helpful to researchers in a number of situations. Our power formula will inform evaluators of models about the number of times to re-sample answers from questions (see Recommendation #3 above), as well as the number of questions that may be included in a random subsample while retaining the desired power properties. Researchers might use the power formula to conclude that an eval with a limited number of available questions is not worth running on a particular pair of models. Developers of new evals may wish to use the formula to help decide how many questions to include.

我们相信，统计功效分析将在多种情境下为研究者提供切实帮助。本文提出的功效公式，可指导模型评测者确定：针对每道题目应重采样答案多少次（参见上文建议 \#3），以及在保持目标功效水平的前提下，随机子样本最多可包含多少道题目。研究者可借助该公式判断：若某评测可用题目数量十分有限，则对特定模型对开展该评测可能并不值得；而新评测的开发者亦可利用该公式辅助决策——究竟应纳入多少道题目。

## Conclusion

## 结论

Statistics is the science of measurement in the presence of noise.  

统计学是在存在噪声条件下的测量科学。

Evals present a number of practical [challenges](https://www.anthropic.com/news/evaluating-ai-systems), and a true [science of evals](https://www.apolloresearch.ai/blog/we-need-a-science-of-evals) remains underdeveloped.  

评估（evals）面临诸多实际[挑战](https://www.anthropic.com/news/evaluating-ai-systems)，而真正意义上的[评估科学](https://www.apolloresearch.ai/blog/we-need-a-science-of-evals)仍处于欠发展状态。

Statistics can only form one aspect of a science of evals—but a critical one, as an empirical science is only as good as its measuring tools.  

统计学仅能构成评估科学的一个方面——但却是关键方面，因为一门实证科学的可靠性，取决于其测量工具的优劣。

We hope that the recommendations in our paper [**Adding Error Bars to Evals: A Statistical Approach to Language Model Evaluations**](https://arxiv.org/abs/2411.00640) will help AI researchers calculate, interpret, and communicate eval numbers with greater precision and clarity than before—and we encourage researchers in the AI community to explore other techniques from experiment design so that they may understand more exactly all the things that they want to measure.  

我们希望，本文提出的建议——[**为评估添加误差棒：面向大语言模型评估的统计学方法**](https://arxiv.org/abs/2411.00640)——能够帮助人工智能研究者比以往更精确、更清晰地计算、解读和传达评估结果；同时，我们也鼓励人工智能领域的研究者进一步探索实验设计中的其他技术，从而更准确地理解所有他们希望测量的对象。