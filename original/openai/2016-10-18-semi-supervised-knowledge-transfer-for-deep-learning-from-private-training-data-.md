---
title: "Semi-supervised knowledge transfer for deep learning from private training data | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/semi-supervised-knowledge-transfer-for-deep-learning-from-private-training-data"
date: "2016-10-18"
scraped_at: "2026-03-02T10:34:22.980224762+00:00"
language: "en-US"
translated: false
tags: ["Safety & Alignment"]
---

October 18, 2016


# Semi-supervised knowledge transfer for deep learning from private training data

[Read paper(opens in a new window)](https://arxiv.org/abs/1610.05755)

![Semi Supervised Knowledge Transfer For Deep Learning From Private Training Data](images/semi-supervised-knowledge-transfer-for-deep-learning-from-private-training-data-/img_001.png)



## Abstract

Some machine learning applications involve training data that is sensitive, such as the medical histories of patients in a clinical trial. A model may inadvertently and implicitly store some of its training data; careful analysis of the model may therefore reveal sensitive information.

To address this problem, we demonstrate a generally applicable approach to providing strong privacy guarantees for training data: Private Aggregation of Teacher Ensembles (PATE). The approach combines, in a black-box fashion, multiple models trained with disjoint datasets, such as records from different subsets of users. Because they rely directly on sensitive data, these models are not published, but instead used as "teachers" for a "student" model. The student learns to predict an output chosen by noisy voting among all of the teachers, and cannot directly access an individual teacher or the underlying data or parameters. The student's privacy properties can be understood both intuitively (since no single teacher and thus no single dataset dictates the student's training) and formally, in terms of differential privacy. These properties hold even if an adversary can not only query the student but also inspect its internal workings.

Compared with previous work, the approach imposes only weak assumptions on how teachers are trained: it applies to any model, including non-convex models like DNNs. We achieve state-of-the-art privacy/utility trade-offs on MNIST and SVHN thanks to an improved privacy analysis and semi-supervised learning.

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)