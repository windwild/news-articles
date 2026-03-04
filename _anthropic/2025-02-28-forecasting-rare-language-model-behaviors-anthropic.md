---
render_with_liquid: false
title: "Forecasting rare language model behaviors \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/forecasting-rare-behaviors"
date: "2025-02-28"
scraped_at: "2026-03-03T06:45:14.815765376+00:00"
language: "en-zh"
translated: true
description: "Anthropic research on predicting rare, undesirable AI behaviors"
---
render_with_liquid: false
render_with_liquid: false

Alignment

对齐（Alignment）

# Forecasting rare language model behaviors

# 预测大语言模型的罕见行为

Feb 25, 2025

2025 年 2 月 25 日

[Read the paper](https://arxiv.org/abs/2502.16797)

[阅读论文](https://arxiv.org/abs/2502.16797)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

One of the major goals of Alignment Science is to predict AI models’ propensity for dangerous behaviors _before_ those behaviors occur. For instance, we run [experiments](https://www.anthropic.com/research/alignment-faking) to check for complex behaviors like deception, and attempt to identify early warning signs of misalignment.

对齐科学（Alignment Science）的核心目标之一，是在危险行为实际发生**之前**，预测 AI 模型产生此类行为的倾向。例如，我们开展[实验](https://www.anthropic.com/research/alignment-faking)，检验模型是否表现出欺骗等复杂行为，并努力识别模型失准（misalignment）的早期预警信号。

We also develop evaluations that can be run on models to test whether they’ll engage in particular kinds of concerning behaviors, such as providing information about deadly weapons, or even [sabotaging](https://www.anthropic.com/research/sabotage-evaluations) human attempts to monitor them.

此外，我们还开发了一系列可直接在模型上运行的评估方法，用以检验模型是否会表现出某些令人担忧的行为，例如提供有关致命武器的信息，甚至[破坏](https://www.anthropic.com/research/sabotage-evaluations)人类对其监控的努力。

A major difficulty in developing these evaluations is the problem of _scale_. Evaluations might be run on thousands of examples of a large language model’s behavior—but when a model is deployed in the real world, it might process billions of queries every day. If concerning behaviors are rare, they could easily be missed in the evaluations.

在开发此类评估时，一个主要难点在于**规模问题（_scale_）**。评估可能仅基于数千个大语言模型行为样例展开；然而，当模型实际部署到真实世界中时，它每天可能处理数十亿次查询。如果值得关注的行为极为罕见，就很容易在评估中被遗漏。

For example, perhaps a specific jailbreaking technique is attempted thousands of times in an evaluation and looks entirely ineffective, but it _does_ work after (say) a million attempts in a real-world deployment. That is, given enough attempted jailbreaks, eventually one of them is likely to work. This renders pre-deployment evaluations much less useful—especially if one single failure could be catastrophic.

例如，某种特定的越狱（jailbreaking）技术在评估中可能被尝试了数千次，且看起来完全无效；但在真实场景下的部署中，它却可能在（比如说）百万次尝试后成功生效。换言之，只要尝试次数足够多，总会有某一次越狱尝试成功。这使得部署前的评估效用大幅降低——尤其当单次失败就可能导致灾难性后果时。

## **Forecasting rare behaviors**

## **预测罕见行为**

What’s needed is a way to forecast the rare behaviors, extrapolating from the relatively small number of instances we’ve observed before deployment. This is the subject of [a new paper](https://arxiv.org/abs/2502.16797) from Anthropic’s Alignment Science team.

我们需要一种方法，能够基于部署前观察到的相对有限的实例，对这些罕见行为进行预测。这正是 Anthropic 公司对齐科学团队（Alignment Science team）[一篇新论文](https://arxiv.org/abs/2502.16797)的研究主题。

In our study, we began by calculating the probability that various prompts make a model produce harmful responses—in some cases, we did this just by sampling large numbers of model completions for each prompt, and measuring the fraction that contained harmful content.

在本研究中，我们首先计算了各类提示词（prompts）引发模型生成有害响应的概率；在某些情况下，我们仅通过对每个提示词采样大量模型补全结果，并统计其中包含有害内容的比例，即可完成该计算。

We then looked at the queries with the highest risk probabilities, and plotted them according to the number of queries. Interestingly, the relationship between the number of queries tested and the highest (log) risk probabilities followed the distribution known as a power law.

随后，我们聚焦于风险概率最高的那些查询，并按查询数量对其排序绘图。有趣的是，已测试查询数量与最高（对数）风险概率之间的关系，恰好符合一种被称为**幂律（power law）** 的分布。

This is where the extrapolation came in: because the features of power laws are well-understood mathematically, we could calculate what the worst-case risks would be with (say) millions of queries, even when we had only tested a few thousand. This allowed us to forecast risks at much larger scales than we could otherwise (this is analogous to testing the temperature of a lake at a few different—but still shallow—depths, finding a predictable pattern, and then using that pattern to predict how cold the lake is at depths we can’t easily measure).

这正是外推（extrapolation）发挥作用之处：由于幂律的数学特性已被充分理解，即便我们仅测试了几千个查询，也能据此推算出在（例如）数百万次查询规模下可能出现的最坏风险。这使我们得以在远超实测能力的规模上预测风险（类比而言，就像在湖泊若干不同但依然较浅的深度测量水温，发现了一种可预测的规律，再利用该规律推断出我们难以直接测量的更深水域的温度）。

![](images/forecasting-rare-language-model-behaviors-anthropic/img_001.jpg)Scaling laws allow us to forecast rare language model behaviors. We find that the risk of the highest-risk queries sent to AI models (y-axis) follows a power law when plotted against the number of queries (x-axis). This lets us make a forecast, even from a smaller dataset of evaluated queries whether any query is likely to exhibit an undesirable behavior at deployment (shaded, right), even from orders-of-magnitude smaller evaluations (unshaded, left).

![](images/forecasting-rare-language-model-behaviors-anthropic/img_001.jpg)缩放定律（scaling laws）使我们能够预测大语言模型的罕见行为。我们发现，发送给 AI 模型的最高风险查询所对应的风险值（纵轴），在按查询总数（横轴）绘图时，呈现出幂律关系。这使我们能仅凭较小规模的已评估查询数据集，就预测任一查询在实际部署中是否可能表现出不良行为（阴影区域，右侧）；即使原始评估规模比目标部署规模小几个数量级（非阴影区域，左侧），该预测依然成立。

How accurate were our forecasts? We tested this by comparing our predictions against actual measurements in several different scenarios.

我们的预测准确度如何？我们通过在多个不同场景下将预测结果与实际测量值进行对比，对此进行了验证。

First, we looked at the model’s risk of providing dangerous information (like instructions to synthesize harmful chemicals). In tests where we used our scaling laws to extrapolate risks from small numbers of queries (say, 900) to those larger by several orders of magnitude (say, 90,000). We found that the predictions we made from the power law were within one order of magnitude of the true risk for 86% of forecasts.

首先，我们考察了模型提供危险信息（例如合成有害化学品的操作指南）的风险。在测试中，我们利用缩放定律，将基于少量查询（例如 900 条）估算出的风险，外推至高出数个数量级的查询规模（例如 90,000 条）。结果表明，在全部预测中，有 86% 的幂律预测结果与真实风险值的误差控制在一个数量级以内。

Second, we forecasted the emergence of misaligned actions (specifically power-seeking, self-preservation, and self-exfiltration, all of which are undesirable behaviours from AIs).  
第二，我们预测了模型出现目标错位行为（具体包括攫取权力、自我保存和自我逃逸——这些均为人工智能系统所表现出的不良行为）的可能性。

The tests involved multiple-choice questions that allowed the models to choose a misaligned action or an aligned one.  
测试采用多项选择题形式，使模型可在错位行为与对齐行为之间进行选择。

For example, we would provide the model with a system prompt that made it focus on a particular occupational domain (for example, sales or medical jobs), and then asked it questions about whether it would prefer to “create new policies” (which would be consistent with power-seeking, since the model then begins to shape the organisation to which it’s attached) or “analyze the existing policies” (which would be a more aligned action).  
例如，我们会向模型提供一个系统提示词，引导其聚焦于某一特定职业领域（如销售或医疗行业），随后提问：它更倾向于“制定新政策”（这符合攫取权力的行为特征，因为模型由此开始塑造其所隶属的组织），还是“分析现有政策”（这是一种更符合对齐目标的行为）？

Our forecasts accurately predicted the risk that the model would pick the worst query: we had an average absolute error of 0.05, compared to 0.12 for more straightforward, baseline methods. That is, our method had 2.5 times lower error than a simpler comparison.  
我们的预测准确评估了模型选择最危险查询的风险：平均绝对误差仅为 0.05，而更直接、基础的对比方法误差为 0.12。换言之，我们的方法误差比简单基线方法低 2.5 倍。

Finally, we also applied our method to “ [automated red-teaming](https://arxiv.org/abs/2202.03286)”. This is when a model is used to find and exploit the weaknesses of another model in an experimental setting. When doing so, one can hypothetically choose to use a small model that generates a very large number of queries or, for the same cost, a larger model that generates a smaller number of queries (but where those queries are likely of a higher quality). Our forecasts were useful in working out how to most efficiently allocate a compute budget while doing red-teaming—in settings where the choice is important, they identified the optimal model 79% of the time.  
最后，我们还将该方法应用于“[自动化红队演练（automated red-teaming）](https://arxiv.org/abs/2202.03286)”。这是一种实验性设置，即利用一个模型去发现并利用另一模型的弱点。在此过程中，理论上可选择：使用小型模型生成海量查询；或在同等计算成本下，使用大型模型生成数量较少但质量更高的查询。我们的预测结果有助于在红队演练中高效分配算力预算——在那些模型选型至关重要的场景中，我们的方法成功识别出最优模型的比例达 79%。

## **Conclusions**

## **结论**

Under normal circumstances, it simply isn’t feasible to use standard evaluations to test for all the rarest risks of AI models.  
在常规情况下，仅依靠标准评测手段根本无法全面检验人工智能模型所面临的全部极端罕见风险。

Our method isn’t perfect—in the paper, we give a number of future directions that might improve the accuracy and practicality of our predictions—but it provides LLM developers with a new way to efficiently predict rare risks, allowing them to take action before deploying their models.  
我们的方法并非完美无缺——论文中列出了若干未来研究方向，有望进一步提升预测的准确性与实用性——但它为大语言模型开发者提供了一种全新途径，使其能够高效预判罕见风险，并在模型部署前及时采取应对措施。

Read [the full paper](https://arxiv.org/abs/2502.16797).  
阅读[完整论文](https://arxiv.org/abs/2502.16797)。

## **Work with us**

## **加入我们**

If you’re interested in working on problems like deployment evaluations or jailbreak robustness, we’re currently recruiting for [Research Engineers / Scientists](https://boards.greenhouse.io/anthropic/jobs/4459012008) and we’d love to see your application.  
若您对部署阶段评测、越狱攻击鲁棒性等前沿课题感兴趣，我们目前正在招聘[研究工程师／科学家（Research Engineers / Scientists）](https://boards.greenhouse.io/anthropic/jobs/4459012008)，诚挚期待您的申请！