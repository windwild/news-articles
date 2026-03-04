---
title: "Text and code embeddings by contrastive pre-training | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/text-and-code-embeddings-by-contrastive-pre-training"
date: "2022-01-24"
scraped_at: "2026-03-02T10:25:51.153420136+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

January 24, 2022


# Text and code embeddings by contrastive pre-training

[Read paper(opens in a new window)](https://arxiv.org/abs/2201.10005) [Read blog](https://openai.com/index/introducing-text-and-code-embeddings/)

![Text And Code Embeddings By Contrastive Pre Training](images/text-and-code-embeddings-by-contrastive-pre-training-openai/img_001.webp)



## Abstract

Text embeddings are useful features in many applications such as semantic search and computing text similarity. Previous work typically trains models customized for different use cases, varying in dataset choice, training objective and model architecture. In this work, we show that contrastive pre-training on unsupervised data at scale leads to high quality vector representations of text and code. The same unsupervised text embeddings that achieve new state-of-the-art results in linear-probe classification also display impressive semantic search capabilities and sometimes even perform competitively with fine-tuned models. On linear-probe classification accuracy averaging over 7 tasks, our best unsupervised model achieves a relative improvement of 4% and 1.8% over previous best unsupervised and supervised text embedding models respectively. The same text embeddings when evaluated on large-scale semantic search attains a relative improvement of 23.4%, 14.7%, and 10.6% over previous best unsupervised methods on MSMARCO, Natural Questions and TriviaQA benchmarks, respectively. Similarly to text embeddings, we train code embedding models on (text, code) pairs, obtaining a 20.8% relative improvement over prior best work on code search.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
&#123;% endraw %}
