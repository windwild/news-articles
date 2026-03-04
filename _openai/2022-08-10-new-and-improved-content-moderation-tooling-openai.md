---
title: "New and improved content moderation tooling | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/new-and-improved-content-moderation-tooling"
date: "2022-08-10"
scraped_at: "2026-03-02T10:24:46.579856753+00:00"
language: "en-US"
translated: false
description: "We are introducing a new and improved content moderation tool. The Moderation endpoint improves upon our previous content filter, and is available for free today to OpenAI API developers."
tags: ["Product"]
---
{% raw %}

August 10, 2022


# New and improved content moderation tooling

[Read documentation(opens in a new window)](https://platform.openai.com/docs/api-reference/moderations/create)

![New And Improved Content Moderation Tooling](images/new-and-improved-content-moderation-tooling-openai/img_001.webp)



To help developers protect their applications against possible misuse, we are introducing the faster and more accurate [Moderation endpoint⁠(opens in a new window)](https://beta.openai.com/docs/api-reference/moderations). This endpoint provides OpenAI API developers with free access to [GPT‑based⁠](https://openai.com/index/customized-gpt-3/) classifiers that detect undesired content—an instance of [using AI systems⁠](https://openai.com/index/critiques/) to assist with human supervision of these systems. We have also released both a [technical paper⁠(opens in a new window)](https://arxiv.org/abs/2208.03274) describing our methodology and the [dataset⁠(opens in a new window)](https://github.com/openai/moderation-api-release) used for evaluation.

When given a text input, the Moderation endpoint assesses whether the content is sexual, hateful, violent, or promotes self-harm—content prohibited by our [content policy⁠(opens in a new window)](https://beta.openai.com/docs/usage-guidelines/content-policy). The endpoint has been trained to be quick, accurate, and to perform robustly across a range of applications. Importantly, this reduces the chances of products “saying” the wrong thing, even when deployed to users at-scale. As a consequence, AI can unlock benefits in sensitive settings, like education, where it could not otherwise be used with confidence.

input text

Violence

Self-harm

Hate

Sexual

Moderation endpoint

Flagged

Flagged

The Moderation endpoint helps developers to benefit from our infrastructure investments. Rather than build and maintain their own classifiers—an extensive process, as we document in our [paper⁠(opens in a new window)](https://arxiv.org/abs/2208.03274)—they can instead access accurate classifiers through a single API call.

As part of OpenAI’s [commitment⁠](https://openai.com/charter/) to [making the AI ecosystem safer⁠](https://openai.com/index/best-practices-for-deploying-language-models/), we are providing this endpoint to allow free moderation of all OpenAI API-generated content. For instance, [Inworld⁠(opens in a new window)](https://www.inworld.ai/), an OpenAI API customer, uses the Moderation endpoint to help their AI-based virtual characters remain appropriate for their audiences. By leveraging OpenAI’s technology, Inworld can focus on their core product: creating memorable characters. We currently do not support monitoring of third-party traffic.

Get started with the Moderation endpoint by checking out [the documentation⁠(opens in a new window)](https://beta.openai.com/docs/guides/moderation/overview). More details of the training process and model performance are available in our [paper⁠(opens in a new window)](https://arxiv.org/abs/2208.03274). We have also released an [evaluation dataset⁠(opens in a new window)](https://github.com/openai/moderation-api-release), featuring Common Crawl data labeled within these categories, which we hope will spur further research in this area.

- [View documentation(opens in a new window)](https://beta.openai.com/docs/guides/mode)

- [API Platform](https://openai.com/news/?tags=api-platform)
- [2022](https://openai.com/news/?tags=2022)
{% endraw %}
