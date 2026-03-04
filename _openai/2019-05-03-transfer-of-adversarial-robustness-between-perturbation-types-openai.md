---
title: "Transfer of adversarial robustness between perturbation types | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/transfer-of-adversarial-robustness-between-perturbation-types"
date: "2019-05-03"
scraped_at: "2026-03-02T10:28:09.356418083+00:00"
language: "en-US"
translated: false
tags: ["Safety & Alignment"]
---
{% raw %}

May 3, 2019


# Transfer of adversarial robustness between perturbation types

[Read paper(opens in a new window)](https://arxiv.org/abs/1905.01034)

![Transfer Of Adversarial Robustness Between Perturbation Types](images/transfer-of-adversarial-robustness-between-perturbation-types-openai/img_001.png)



## Abstract

We study the transfer of adversarial robustness of deep neural networks between different perturbation types. While most work on adversarial examples has focused on L∞ L\_∞ L∞​ and L2 L\_2 L2​-bounded perturbations, these do not capture all types of perturbations available to an adversary. The present work evaluates 32 attacks of 5 different types against models adversarially trained on a 100-class subset of ImageNet. Our empirical results suggest that evaluating on a wide range of perturbation sizes is necessary to understand whether adversarial robustness transfers between perturbation types. We further demonstrate that robustness against one perturbation type may not always imply and may sometimes hurt robustness against other perturbation types. In light of these results, we recommend evaluation of adversarial defenses take place on a diverse range of perturbation types and sizes.

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)
{% endraw %}
