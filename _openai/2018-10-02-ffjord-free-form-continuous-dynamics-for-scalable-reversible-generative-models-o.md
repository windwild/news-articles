---
title: "FFJORD: Free-form continuous dynamics for scalable reversible generative models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/ffjord"
date: "2018-10-02"
scraped_at: "2026-03-02T10:29:24.238010431+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

October 2, 2018


# FFJORD: Free-form continuous dynamics for scalable reversible generative models

[Read paper(opens in a new window)](https://arxiv.org/abs/1810.01367)

![Ffjord Free Form Continuous Dynamics For Scalable Reversible Generative Models](images/ffjord-free-form-continuous-dynamics-for-scalable-reversible-generative-models-o/img_001.webp)



## Abstract

A promising class of generative models maps points from a simple distribution to a complex distribution through an invertible neural network. Likelihood-based training of these models requires restricting their architectures to allow cheap computation of Jacobian determinants. Alternatively, the Jacobian trace can be used if the transformation is specified by an ordinary differential equation. In this paper, we use Hutchinson's trace estimator to give a scalable unbiased estimate of the log-density. The result is a continuous-time invertible generative model with unbiased density estimation and one-pass sampling, while allowing unrestricted neural network architectures. We demonstrate our approach on high-dimensional density estimation, image generation, and variational inference, achieving the state-of-the-art among exact likelihood methods with efficient sampling.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
&#123;% endraw %}
