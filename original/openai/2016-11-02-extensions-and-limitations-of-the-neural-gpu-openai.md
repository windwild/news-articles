---
title: "Extensions and limitations of the neural GPU | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/extensions-and-limitations-of-the-neural-gpu"
date: "2016-11-02"
scraped_at: "2026-03-02T10:33:50.254830649+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---

November 2, 2016


# Extensions and limitations of the neural GPU

[Read paper(opens in a new window)](https://arxiv.org/abs/1611.00736)

![Extensions And Limitations Of The Neural Gpu](images/extensions-and-limitations-of-the-neural-gpu-openai/img_001.webp)



## Abstract

The Neural GPU is a recent model that can learn algorithms such as multi-digit binary addition and binary multiplication in a way that generalizes to inputs of arbitrary length. We show that there are two simple ways of improving the performance of the Neural GPU: by carefully designing a curriculum, and by increasing model size. The latter requires a memory efficient implementation, as a naive implementation of the Neural GPU is memory intensive. We find that these techniques increase the set of algorithmic problems that can be solved by the Neural GPU: we have been able to learn to perform all the arithmetic operations (and generalize to arbitrarily long numbers) when the arguments are given in the decimal representation (which, surprisingly, has not been possible before). We have also been able to train the Neural GPU to evaluate long arithmetic expressions with multiple operands that require respecting the precedence order of the operands, although these have succeeded only in their binary representation, and not with perfect accuracy. In addition, we gain insight into the Neural GPU by investigating its failure modes. We find that Neural GPUs that correctly generalize to arbitrarily long numbers still fail to compute the correct answer on highly-symmetric, atypical inputs: for example, a Neural GPU that achieves near-perfect generalization on decimal multiplication of up to 100-digit long numbers can fail on 000000…002×000000…002 while succeeding at 2×2. These failure modes are reminiscent of adversarial examples.

- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)