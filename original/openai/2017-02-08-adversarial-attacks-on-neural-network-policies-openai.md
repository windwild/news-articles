---
title: "Adversarial attacks on neural network policies | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/adversarial-attacks-on-neural-network-policies"
date: "2017-02-08"
scraped_at: "2026-03-02T10:33:45.588676990+00:00"
language: "en-US"
translated: false
tags: ["Safety & Alignment"]
---

February 8, 2017


# Adversarial attacks on neural network policies

[Read paper(opens in a new window)](https://arxiv.org/abs/1702.02284)

![Adversarial Attacks On Neural Network Policies](images/adversarial-attacks-on-neural-network-policies-openai/img_001.webp)

Loading…


## Abstract

Machine learning classifiers are known to be vulnerable to inputs maliciously constructed by adversaries to force misclassification. Such adversarial examples have been extensively studied in the context of computer vision applications. In this work, we show adversarial attacks are also effective when targeting neural network policies in reinforcement learning. Specifically, we show existing adversarial example crafting techniques can be used to significantly degrade test-time performance of trained policies. Our threat model considers adversaries capable of introducing small perturbations to the raw input of the policy. We characterize the degree of vulnerability across tasks and training algorithms, for a subclass of adversarial-example attacks in white-box and black-box settings. Regardless of the learned task or training algorithm, we observe a significant drop in performance, even with small adversarial perturbations that do not interfere with human perception. Videos are available at [this http URL⁠(opens in a new window)](http://rll.berkeley.edu/adversarial).

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)