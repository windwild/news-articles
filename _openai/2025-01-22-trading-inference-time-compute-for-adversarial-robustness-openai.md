---
title: "Trading Inference-Time Compute for Adversarial Robustness | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/trading-inference-time-compute-for-adversarial-robustness"
date: "2025-01-22"
scraped_at: "2026-03-02T10:15:32.994359138+00:00"
language: "en-US"
translated: false
description: "Trading Inference-Time Compute for Adversarial Robustness"
tags: ["Research"]
---
&#123;% raw %}

January 22, 2025


# Trading Inference-Time Compute for Adversarial Robustness

Initial evidence that reasoning models such as o1 become more robust to adversarial attacks as they think for longer.

[Read paper(opens in a new window)](https://arxiv.org/abs/2501.18841)



[Robustness to adversarial attacks⁠(opens in a new window)](https://en.m.wikipedia.org/wiki/Adversarial_machine_learning#Adversarial_examples) has been one of the thorns in AI’s side for more than a decade. In 2014, researchers [showed⁠(opens in a new window)](https://arxiv.org/abs/1312.6199) that imperceptible perturbations—subtle alterations undetectable to the human eye—can cause models to misclassify images, illustrating one example of a model’s vulnerability to adversarial attacks. Addressing this weakness has become more urgent as models are being used for high stakes applications and acting as _agents_ that can browse the web and take actions on behalf of their users.

Despite years of intense research, the problem of defending against adversarial attacks is far from solved. Nicholas Carlini, an expert in the field, [recently said⁠(opens in a new window)](https://youtu.be/umfeF0Dx-r4?t=868) that “in adversarial machine learning, we wrote over 9,000 papers in ten years and got nowhere.” One reason is that, unlike other progress in AI, increasing the size of models on its own has not been sufficient to make them robust to adversarial attacks.

In a new paper, we present preliminary evidence that increasing inference-time compute—giving reasoning models more time and resources to ‘think’—can improve robustness to multiple types of attacks. This approach uses reasoning models like o1‑preview and o1‑mini, which can adapt their computation during inference.  We also explore new attacks designed specifically for reasoning models like o1, as well as settings where inference-time compute does not improve robustness, and speculate on the reasons for these as well as ways to address them.

## Evaluating the relationship between adversarial robustness and inference-time compute

We conducted extensive experiments to assess how increasing inference-time compute in reasoning models,  specifically OpenAI’s o1‑preview and o1‑mini, affects their robustness to adversarial attacks. We studied  a range of tasks using both static and adaptive attack methods, measuring the probability of attack success as a function of the amount of computation used by the model at inference. We see that in many cases, this probability decays—often to near zero—as the inference-time compute grows, although significant exceptions remain (discussed below).

![Heatmap titled “Many-shots attack on math,” showing attack success probability (color scale from yellow to purple) against attack length (tokens) and inference time compute.](images/trading-inference-time-compute-for-adversarial-robustness-openai/img_001.svg)

_A typical result in the paper: The Y axis is the amount of resources of the attacker, and the X axis is the amount of inference-time compute. We see that as the attacker’s resources grow, so does its success probability. But for every fixed amount of attacker’s resources, the probability of success decays as the model is spending more compute at inference time._

To study the relationship between adversarial robustness (as measured by attacker resources) and test-time compute, we considered a number of different types of tasks. These include:

1. Mathematical tasks, including very simple ones such as adding or multiplying two numbers, as well as more sophisticated ones such as [MATH⁠(opens in a new window)](https://arxiv.org/abs/2103.03874). For each such task, we considered a number of “goals” by the adversary: get the model to output 42 instead of the correct answer, get the model to output the correct answer plus one, or get the model to output the correct answer times seven.
2. Adversarial version of the [SimpleQA⁠](https://openai.com/index/introducing-simpleqa/) factuality benchmark. This is a dataset of questions that were chosen to be hard for models to resolve without browsing, and we simulated injection of adversarial prompts in the browsed web pages.
3. Adversarial images from the [Attack Bard⁠(opens in a new window)](https://arxiv.org/abs/2309.11751) paper.
4. Misuse prompts from the [StrongREJECT⁠(opens in a new window)](https://arxiv.org/abs/2402.10260) benchmarks. These are prompts that the model should **not** comply with, but the attacker’s goal is to get the model to do so.
5. An internal evaluation for following one of the rules in our model [spec⁠](https://openai.com/index/introducing-the-model-spec/).

We considered a number of “attack surfaces” for the adversary, including:

1. The “many shot” attack (see [Anthropic 2024⁠(opens in a new window)](https://www.anthropic.com/research/many-shot-jailbreaking)) where a number of “bad” input/output examples are provided by the adversary.
2. Optimizing soft tokens (arbitrary embedding vectors) to achieve the adversary’s goal.
3. An adversarial language model program (LMP)--that is, a structured program incorporating language models in its control flow–that does “AI red teaming”
4. Adversarial multi modal inputs.

_Note that, not all attacks have been used on all datasets; please refer to the paper for details._

In many of these cases, we see that the **adversary’s success probability decreases as the amount of inference-time compute increases**. We stress that unlike the typical approach of “adversarial training,” the model is not aware of the nature of the attack and hence the improved robustness is solely due to improving inference-time compute. This suggests that inference-time scaling could be useful for tackling even _unforeseen_ attacks.

## Limitations

There are cases where (at least so far) inference-time compute does not improve robustness:

1. In some cases, we see that initially the adversary's success _increases_ with the defender’s inference-time compute and later decreases. We believe this is because the defender needs a minimum amount of test-time compute to achieve the attacker’s goal (e.g. to respond with one plus the correct answer, it must be able to solve the math problem).
2. More importantly, there are cases where the attack’s success does not decay as we give the defender more inference-time compute. This is especially evident on the StrongREJECT benchmark with the LMP attack. Some of the prompts in this benchmark request information that is not prohibited in all circumstances, and so the LMP can find contexts in which the specification-compliant response is to provide this information. See Figure 10 in the paper for an example.
3. Our ability to control the model’s test-time compute usage is not perfect. We see that the attacker can sometimes fool the model into not thinking or using its inference-time compute unproductively. For this paper we did not explore teaching the model to use its allotted compute “wisely” and simply did the most naive thing; we think this is a promising area of research to improve adversarial robustness.

See the paper for additional discussions of limitations and open questions.

## Conclusion

Overall, we view this work as a promising sign for the power of inference-time compute for adversarial robustness. As we discuss in the paper, there is more work to be done to turn this promise into reality and we are excited to make it happen!

- [o1](https://openai.com/research/index/?tags=o1)
- [Compute Scaling](https://openai.com/research/index/?tags=compute-scaling)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)
- [Exploration & Games](https://openai.com/research/index/?tags=exploration-game)
- [Reasonings & Policy](https://openai.com/research/index/?tags=reasoning-policy)
&#123;% endraw %}
