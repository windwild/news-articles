---
title: "Introducing improvements to the fine-tuning API and expanding our custom models program | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-program"
date: "2024-04-04"
scraped_at: "2026-03-02T10:20:04.884075108+00:00"
language: "en-US"
translated: false
description: "We’re adding new features to help developers have more control over fine-tuning and announcing new ways to build custom models with OpenAI."
tags: ["Product"]
---

April 4, 2024


# Introducing improvements to the fine-tuning API and expanding our custom models program

![Introducing Improvements > Cover Image](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_001.jpg)



There are a [variety of techniques⁠(opens in a new window)](https://www.youtube.com/watch?v=ahnGLM-RC1Y&list=PLOXw6I10VTv-exVCRuRjbT6bqkfO74rWz&index=4) that developers can use to increase model performance in an effort to reduce latency, improve accuracy, and reduce costs. Whether it’s extending model knowledge with retrieval-augmented generation (RAG), customizing a model’s behavior with fine-tuning, or building a custom-trained model with new domain-specific knowledge, we have developed a range of options to support our customers’ AI implementations. Today, we’re launching new features to give developers more control over fine-tuning with the API and introducing more ways to work with our team of AI experts and researchers to build custom models.

## New fine-tuning API features

We launched the self-serve [fine-tuning API⁠(opens in a new window)](https://platform.openai.com/docs/guides/fine-tuning) for GPT‑3.5 in August 2023. Since then, thousands of organizations have trained hundreds of thousands of models using our API. Fine-tuning can help models deeply understand content and augment a model’s existing knowledge and capabilities for a specific task. Our fine-tuning API also supports a larger volume of examples than can fit in a single prompt to achieve higher quality results while reducing cost and latency. Some of the common use cases of fine-tuning include training a model to generate better code in a particular programming language, to summarize text in a specific format, or to craft personalized content based on user behavior.

For example, [Indeed⁠(opens in a new window)](https://www.indeed.com/), a global job matching and hiring platform, wants to simplify the hiring process. As part of this, Indeed launched a feature that sends personalized recommendations to job seekers, highlighting relevant jobs based on their skills, experience, and preferences. They fine-tuned GPT‑3.5 Turbo to generate higher quality and more accurate explanations. As a result, Indeed was able to improve cost and latency by reducing the number of tokens in prompt by 80%. This let them scale from less than one million messages to job seekers per month to roughly 20 million.

Today, we’re introducing [new features⁠(opens in a new window)](https://platform.openai.com/docs/guides/fine-tuning/create-a-fine-tuned-model) to give developers even more control over their fine-tuning jobs, including:

- **Epoch-based Checkpoint Creation:** Automatically produce one full fine-tuned model checkpoint during each training epoch, which reduces the need for subsequent retraining, especially in the cases of overfitting
- **Comparative Playground**: A new side-by-side Playground UI for comparing model quality and performance, allowing human evaluation of the outputs of multiple models or fine-tune snapshots against a single prompt
- **Third-party Integration:** Support for integrations with third-party platforms (starting with [Weights and Biases⁠(opens in a new window)](https://wandb.ai/site) this week) to let developers share detailed fine-tuning data to the rest of their stack
- **Comprehensive Validation Metrics**: The ability to compute metrics like loss and accuracy over the entire validation dataset instead of a sampled batch, providing better insight on model quality
- **Hyperparameter Configuration**: The ability to configure available hyperparameters from the [Dashboard⁠(opens in a new window)](https://platform.openai.com/finetune) (rather than only through the API or SDK)
- **Fine-Tuning Dashboard Improvements**: Including the ability to configure hyperparameters, view more detailed training metrics, and rerun jobs from previous configurations

![fine-tuning-in-api](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_002.gif)

## Expanding our Custom Models Program

### Assisted Fine-Tuning

At DevDay last November, we [announced⁠](https://openai.com/blog/new-models-and-developer-products-announced-at-devday/) a Custom Model program designed to train and optimize models for a specific domain, in partnership with a dedicated group of OpenAI researchers. Since then, we've met with dozens of customers to assess their custom model needs and evolved our program to further maximize performance.

Today, we are formally announcing our assisted fine-tuning offering as part of the Custom Model program. Assisted fine-tuning is a collaborative effort with our technical teams to leverage techniques beyond the fine-tuning API, such as additional hyperparameters and various parameter efficient fine-tuning (PEFT) methods at a larger scale. It’s particularly helpful for organizations that need support setting up efficient training data pipelines, evaluation systems, and bespoke parameters and methods to maximize model performance for their use case or task.

For example, [SK Telecom⁠(opens in a new window)](https://www.sktelecom.com/index_en.html), a telecommunications operator serving over 30 million subscribers in South Korea, wanted to customize a model to be an expert in the telecommunications domain with an initial focus on customer service. They worked with OpenAI to fine-tune GPT‑4 to improve its performance in telecom-related conversations in the Korean language. Over the course of multiple weeks, SKT and OpenAI drove meaningful performance improvement in telecom customer service tasks—a 35% increase in conversation summarization quality, a 33% increase in intent recognition accuracy, and an increase in satisfaction scores from 3.6 to 4.5 (out of 5) when comparing the fine-tuned model to GPT‑4.

### Custom-Trained Model

In some cases, organizations need to train a purpose-built model from scratch that understands their business, industry, or domain. Fully custom-trained models imbue new knowledge from a specific domain by modifying key steps of the model training process using novel mid-training and post-training techniques. Organizations that see success with a fully custom-trained model often have large quantities of proprietary data—millions of examples or billions of tokens—that they want to use to teach the model new knowledge or complex, unique behaviors for highly specific use cases.

For example, [Harvey⁠(opens in a new window)](https://www.harvey.ai/), an AI-native legal tool for attorneys, partnered with OpenAI to [create a custom-trained large language model for case law⁠](https://openai.com/customer-stories/harvey/). While foundation models were strong at reasoning, they lacked the extensive knowledge of legal case history and other knowledge required for legal work. After testing out prompt engineering, RAG, and fine-tuning, Harvey worked with our team to add the depth of context needed to the model—the equivalent of 10 billion tokens worth of data. Our team modified every step of the model training process, from domain-specific mid-training to customizing post-training processes and incorporating expert attorney feedback. The resulting model achieved an 83% increase in factual responses and attorneys preferred the customized model’s outputs 97% of the time over GPT‑4.

![Index > Introducing Improvements > Media Item > Gif 2](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_003.gif)

## What’s next for model customization

We believe that in the future, the vast majority of organizations will develop customized models that are personalized to their industry, business, or use case. With a variety of techniques available to build a custom model, organizations of all sizes can develop personalized models to realize more meaningful, specific impact from their AI implementations. The key is to clearly scope the use case, design and implement evaluation systems, choose the right techniques, and be prepared to iterate over time for the model to reach optimal performance.

With OpenAI, most organizations can see meaningful results quickly with the self-serve fine-tuning API. For any organizations that need to more deeply fine-tune their models or imbue new, domain-specific knowledge into the model, our Custom Model programs can help.

Visit our [fine-tuning API⁠(opens in a new window)](https://platform.openai.com/docs/guides/fine-tuning) docs to start fine-tuning our models.

## Related articles

[View all product articles](https://openai.com/news/product/)

![Young Tiger](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_004.jpg)

[Video generation models as world simulators\\
\\
PublicationFeb 15, 2024](https://openai.com/index/video-generation-models-as-world-simulators/)

![](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_005.jpg)

[Building an early warning system for LLM-aided biological threat creation\\
\\
PublicationJan 31, 2024](https://openai.com/index/building-an-early-warning-system-for-llm-aided-biological-threat-creation/)

![Weak To Strong Generalization](images/introducing-improvements-to-the-fine-tuning-api-and-expanding-our-custom-models-/img_006.jpg)

[Weak-to-strong generalization\\
\\
SafetyDec 14, 2023](https://openai.com/index/weak-to-strong-generalization/)

Introducing improvements to the fine-tuning API and expanding our custom models program \| OpenAI