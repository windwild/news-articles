---
render_with_liquid: false
title: "Improving mathematical reasoning with process supervision | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/improving-mathematical-reasoning-with-process-supervision"
date: "2023-05-31"
scraped_at: "2026-03-02T10:23:19.626148067+00:00"
language: "en-US"
translated: false
description: "We've trained a model to achieve a new state-of-the-art in mathematical problem solving by rewarding each correct step of reasoning (“process supervision”) instead of simply rewarding the correct ..."
tags: ["Research"]
---

May 31, 2023


# Improving mathematical reasoning with process supervision

[Read paper(opens in a new window)](https://arxiv.org/abs/2305.20050) [Browse samples](https://openai.com/index/improving-mathematical-reasoning-with-process-supervision/#samples) [Download dataset(opens in a new window)](https://github.com/openai/prm800k)

![Improving Mathematical Reasoning With Process Supervision](images/improving-mathematical-reasoning-with-process-supervision-openai/img_001.jpg)



We've trained a model to achieve a new state-of-the-art in mathematical problem solving by rewarding each correct step of reasoning (“process supervision”) instead of simply rewarding the correct final answer (“outcome supervision”). In addition to boosting performance relative to outcome supervision, process supervision also has an important alignment benefit: it directly trains the model to produce a chain-of-thought that is endorsed by humans.

## Introduction

In recent years, large language models have greatly improved in their ability to perform complex multi-step reasoning. However, even state-of-the-art models still produce logical mistakes, often called _hallucinations_. Mitigating hallucinations is a critical step towards building aligned AGI.

We can train reward models to detect hallucinations using either _outcome supervision_, which provides feedback based on a final result, or _process supervision_, which provides feedback for each individual step in a chain-of-thought. Building on previous work[1](https://openai.com/index/improving-mathematical-reasoning-with-process-supervision/#citation-bottom-1), we conduct a detailed comparison of these two methods using the MATH dataset[2](https://openai.com/index/improving-mathematical-reasoning-with-process-supervision/#citation-bottom-2) as our testbed. We find that process supervision leads to significantly better performance, even when judged by outcomes. To encourage related research, we release our full dataset of process supervision.

## Alignment impact

Process supervision has several alignment advantages over outcome supervision. It directly rewards the model for following an aligned chain-of-thought, since each step in the process receives precise supervision. Process supervision is also more likely to produce interpretable reasoning, since it encourages the model to follow a human-approved process. In contrast, outcome supervision may reward an unaligned process, and it is generally harder to scrutinize.

In some cases, safer methods for AI systems can lead to reduced performance[3](https://openai.com/index/improving-mathematical-reasoning-with-process-supervision/#citation-bottom-3), a cost which is known as an _alignment tax_. In general, any alignment tax may hinder the adoption of alignment methods, due to pressure to deploy the most capable model. Our results below show that process supervision in fact incurs a negative alignment tax, at least in the math domain. This could increase the adoption of process supervision, which we believe would have positive alignment side-effects.

## Solving MATH problems

1e+11e+21e+3656667686970717273747576777879N = number of samples% Problems Solved (Best-of-N)MATH Test PerformanceOutcome-Supervised RMProcess-Supervised RM

We evaluate our process-supervised and outcome-supervised reward models using problems from the MATH test set. We generate many solutions for each problem and then pick the solution ranked the highest by each reward model. The graph shows the percentage of chosen solutions that reach the correct final answer, as a function of the number of solutions considered. Not only does the process-supervised reward model perform better across the board, but the performance gap widens as we consider more solutions per problem. This shows us that the process-supervised reward model is much more reliable.

We showcase 10 problems and solutions below, along with commentary about the reward model’s strengths and weaknesses.

## Explore examples in 3 categories:

- True positives
- True negatives
- False positives

## Problem

Simplify tan⁡100∘+4sin⁡100∘.\\tan 100^\\circ + 4 \\sin 100^\\circ.tan100∘+4sin100∘.

1 / 4

## Model attempt

This challenging trigonometry problem requires applying several identities in a not-at-all obvious succession. Most solution attempts fail, because it is hard to choose which identities are actually helpful. Although GPT-4 usually can’t solve this problem (only .1%.1\\%.1% of solution attempts reach the correct answer), the reward model correctly recognizes that this solution is valid.

```

```

I notice that the angle 100 degrees is not a special angle, so I will need to use some trigonometric identities to simplify this expression.

```

```

I recall that tan⁡θ=sin⁡θcos⁡θ\\tan \\theta = \\frac{\\sin \\theta}{\\cos \\theta}tanθ=cosθsinθ​ and sin⁡2θ=2sin⁡θcos⁡θ.\\sin 2\\theta = 2 \\sin \\theta \\cos \\theta.sin2θ=2sinθcosθ.

```

```

I can use these identities to rewrite the expression as sin⁡100∘cos⁡100∘+4sin⁡100∘.\\frac{\\sin 100^\\circ}{\\cos 100^\\circ} + 4 \\sin 100^\\circ.cos100∘sin100∘​+4sin100∘.

```

```

I can combine the terms by finding a common denominator of cos⁡100∘.\\cos 100^\\circ.cos100∘.

```

```

I get sin⁡100∘+4sin⁡100∘cos⁡100∘cos⁡100∘.\\frac{\\sin 100^\\circ + 4 \\sin 100^\\circ \\cos 100^\\circ}{\\cos 100^\\circ}.cos100∘sin100∘+4sin100∘cos100∘​.

```

```

I can simplify the numerator by using the double angle identity again, but in reverse.

```

```

I get sin⁡100∘+2sin⁡200∘cos⁡100∘.\\frac{\\sin 100^\\circ + 2 \\sin 200^\\circ}{\\cos 100^\\circ}.cos100∘sin100∘+2sin200∘​.

```

```

I notice that 200 degrees is the same as 180 degrees plus 20 degrees, so I can use the sum angle identity for sine.

```

```

I get sin⁡100∘+2(sin⁡180∘cos⁡20∘+cos⁡180∘sin⁡20∘)cos⁡100∘.\\frac{\\sin 100^\\circ + 2 (\\sin 180^\\circ \\cos 20^\\circ + \\cos 180^\\circ \\sin 20^\\circ)}{\\cos 100^\\circ}.cos100∘sin100∘+2(sin180∘cos20∘+cos180∘sin20∘)​.

```

```

I recall that sin⁡180∘=0\\sin 180^\\circ = 0sin180∘=0 and cos⁡180∘=−1,\\cos 180^\\circ = -1,cos180∘=−1, so I can simplify further.

```

```

I get sin⁡100∘−2sin⁡20∘cos⁡100∘.\\frac{\\sin 100^\\circ - 2 \\sin 20^\\circ}{\\cos 100^\\circ}.cos100∘sin100∘−2sin20∘​.

```

```

I notice that 100 degrees is the same as 90 degrees plus 10 degrees, so I can use the sum angle identity for sine and cosine.

```

```

I get (sin⁡90∘cos⁡10∘+cos⁡90∘sin⁡10∘)−2sin⁡20∘(cos⁡90∘cos⁡10∘−sin⁡90∘sin⁡10∘).\\frac{(\\sin 90^\\circ \\cos 10^\\circ + \\cos 90^\\circ \\sin 10^\\circ) - 2 \\sin 20^\\circ}{(\\cos 90^\\circ \\cos 10^\\circ - \\sin 90^\\circ \\sin 10^\\circ)}.(cos90∘cos10∘−sin90∘sin10∘)(sin90∘cos10∘+cos90∘sin10∘)−2sin20∘​.

```

```

I recall that sin⁡90∘=1\\sin 90^\\circ = 1sin90∘=1 and cos⁡90∘=0,\\cos 90^\\circ = 0,cos90∘=0, so I can simplify further.

```

```

I get cos⁡10∘−2sin⁡20∘−sin⁡10∘.\\frac{\\cos 10^\\circ - 2 \\sin 20^\\circ}{-\\sin 10^\\circ}.−sin10∘cos10∘−2sin20∘​.

```

```

I can simplify the sign by multiplying the numerator and denominator by -1.

```

```

I get 2sin⁡20∘−cos⁡10∘sin⁡10∘.\\frac{2 \\sin 20^\\circ - \\cos 10^\\circ}{\\sin 10^\\circ}.sin10∘2sin20∘−cos10∘​.

```

```

I notice that 20 degrees is the same as 30 degrees minus 10 degrees, so I can use the difference angle identity for sine.

```

```

I get 2(sin⁡30∘cos⁡10∘−cos⁡30∘sin⁡10∘)−cos⁡10∘sin⁡10∘.\\frac{2 (\\sin 30^\\circ \\cos 10^\\circ - \\cos 30^\\circ \\sin 10^\\circ) - \\cos 10^\\circ}{\\sin 10^\\circ}.sin10∘2(sin30∘cos10∘−cos30∘sin10∘)−cos10∘​.

```

```

I recall that sin⁡30∘=12\\sin 30^\\circ = \\frac{1}{2}sin30∘=21​ and cos⁡30∘=32,\\cos 30^\\circ = \\frac{\\sqrt{3}}{2},cos30∘=23​​, so I can simplify further.

```

```

I get cos⁡10∘−3sin⁡10∘−cos⁡10∘sin⁡10∘.\\frac{\\cos 10^\\circ - \\sqrt{3} \\sin 10^\\circ - \\cos 10^\\circ}{\\sin 10^\\circ}.sin10∘cos10∘−3​sin10∘−cos10∘​.

```

```

I can cancel out the cos⁡10∘\\cos 10^\\circcos10∘ terms in the numerator.

```

```

I get −3sin⁡10∘sin⁡10∘.\\frac{-\\sqrt{3} \\sin 10^\\circ}{\\sin 10^\\circ}.sin10∘−3​sin10∘​.

```

```

I can cancel out the sin⁡10∘\\sin 10^\\circsin10∘ terms in the numerator and denominator.

```

```

I get −3.-\\sqrt{3}.−3​.

```

```

Answer: −3-\\sqrt{3}−3​

It is unknown how broadly these results will generalize beyond the domain of math, and we consider it important for future work to explore the impact of process supervision in other domains. If these results generalize, we may find that process supervision gives us the best of both worlds – a method that is both more performant and more aligned than outcome supervision.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
- [Reasonings & Policy](https://openai.com/research/index/?tags=reasoning-policy)

## References

1. 1
Uesato, J., Kushman N., Kumar R., Song F., Siegel N., Wang L., Creswell A., Irving G. and Higgins, I., 2022. Solving math word problems with process- and outcome-based feedback. arXiv preprint arXiv:2211.14275.

2. 2
Hendrycks D., Burns C., Kadavath S., Arora A., Basart S., Tang E., Song D. and Steinhardt J., 2021. Measuring Mathematical Problem Solving With the MATH Dataset. arXiv preprint arXiv:2103.03874.

3. 3
Ouyang L., Wu J., Jiang X., Almedia D., Wainwright C.L., Mishkin P., Zhang C., Agarwal S., Slama K., Ray A., Schulman J., Hilton J., Kelton F., Miller L., Simens M., Askell A., Welinder P., Christiano P., Leike J. and Lowe R., 2022. Training language models to follow instructions with human feedback. arXiv preprint arXiv:2203.02155.