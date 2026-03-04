---
title: "GPT-4 API general availability and deprecation of older models in the Completions API | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-4-api-general-availability"
date: "2024-04-24"
scraped_at: "2026-03-02T10:20:02.498487157+00:00"
language: "en-US"
translated: false
description: "GPT-3.5 Turbo, DALL·E and Whisper APIs are also generally available, and we are releasing a deprecation plan for older models of the Completions API, which will retire at the beginning of 2024."
tags: ["Product"]
---
{% raw %}

Updated: April 24, 2024


# GPT‑4 API general availability and deprecation of older models in the Completions API

![Artistic illustration with bright green leaf-like patterns radiating from a central point, giving a sense of natural growth or energy.](images/gpt-4-api-general-availability-and-deprecation-of-older-models-in-the-completion/img_001.jpg)



**_Update on April 24, 2024: The ChatGPT API name has been discontinued. Mentions of the ChatGPT API in this blog refer to the GPT‑3.5 Turbo API._**

Starting today, all paying API customers have access to GPT‑4. In March, we [introduced the OpenAI API⁠](https://openai.com/index/introducing-chatgpt-and-whisper-apis/), and earlier this month we [released our first updates⁠](https://openai.com/index/function-calling-and-other-api-updates/) to the chat-based models. We envision a future where chat-based models can support any use case. Today we’re announcing a deprecation plan for older models of the Completions API, and recommend that users adopt the Chat Completions API.

## GPT-4 API general availability

GPT‑4 is our most capable model. Millions of developers have requested access to the GPT‑4 API since March, and the range of [innovative products⁠](https://openai.com/stories/) leveraging GPT‑4 is growing every day. Today all existing API developers with a history of successful payments can access the GPT‑4 API with 8K context. We plan to open up access to new developers by the end of this month, and then start raising rate-limits after that depending on compute availability.

Based on the stability and readiness of these models for production-scale use, we are also making the GPT‑3.5 Turbo, DALL·E and Whisper APIs generally available. We are working on safely enabling fine-tuning for GPT‑4 and GPT‑3.5 Turbo and expect this feature to be available later this year.

## Moving from text completions to chat completions

We introduced the [Chat Completions API⁠(opens in a new window)](https://platform.openai.com/docs/guides/gpt/chat-completions-api) in March, and it now accounts for 97% of our API GPT usage.

The initial Completions API was introduced in June 2020 to provide a freeform text prompt for interacting with our language models. We’ve since learned that we can often provide better results with a more structured prompt interface. The chat-based paradigm has proven to be powerful, handling the vast majority of previous use cases and new conversational needs, while providing higher flexibility and specificity. In particular, the Chat Completions API’s structured interface (e.g., system messages, function calling) and multi-turn conversation capabilities enable developers to build conversational experiences and a broad range of completion tasks. It also helps lower the risk of prompt injection attacks, since user-provided content can be structurally separated from instructions.

Text summarization

System

System

Summarize this message in max 10 words.

User

Jupiter is the fifth planet from the Sun and the largest in the Solar System. It is a gas giant with a mass one-thousandth that of the Sun, but two-and-a-half times that of all the other planets in the Solar System combined. Jupiter is one of the brightest objects visible to the naked eye in the night sky, and has been known to ancient civilizations since before recorded history. It is named after the Roman god Jupiter. When viewed from Earth, Jupiter can be bright enough for its reflected light to cast visible shadows, and is on average the third-brightest natural object in the night sky after the Moon and Venus.

OAI

Assistant

Jupiter: Largest planet, visible to the naked eye at night.

Code completion

System

System

Complete the following code.

User

def fibonacci(num):

OAI

Assistant

if num == 0:

     return 0

elif num == 1:

     return 1

else:

     fib = \[0, 1\]

     for i in range(2, num + 1):

           fib.append(fib\[i-1\] + fib\[i-2\])

     return fib\[num\]

Few-shot learning

System

System

You translate corporate jargon into plain English.

User

New synergies will help drive top-line growth.

OAI

Assistant

Working well together will make more money.

User

Let’s circle back when we have more bandwidth to touch base on opportunities for increased leverage.

OAI

Assistant

When we’re less busy, let’s talk about how to do better.

User

This late pivot means we don’t have time to boil the ocean for the client deliverable.

OAI

Assistant

Because of this sudden change, we don’t have enough time to complete the entire project for the client.

We plan to continue investing most of our platform efforts in this direction, as we believe it will offer an increasingly capable and easy-to-use experience for developers. We’re working on closing the last few remaining gaps of the Chat Completions API quickly, such as log probabilities for completion tokens and increased steerability to reduce the “chattiness” of responses.

## Deprecation of older models in the Completions API

As part of our increased investment in the Chat Completions API and our efforts to optimize our compute capacity, in 6 months we will be retiring some of our older models using the Completions API. While this API will remain accessible, we will label it as “legacy” in our developer documentation starting today. We plan for future model and product improvements to focus on the Chat Completions API, and do not have plans to publicly release new models using the Completions API.

Starting January 4, 2024, [older completion models⁠(opens in a new window)](https://platform.openai.com/docs/deprecations) will no longer be available, and will be replaced with the following models:

| **Older model** | **New model** |
| --- | --- |
| ada | babbage-002 |
| babbage | babbage-002 |
| curie | davinci-002 |
| davinci | davinci-002 |
| davinci-instruct-beta | gpt-3.5-turbo-instruct |
| curie-instruct-beta | gpt-3.5-turbo-instruct |
| text-ada-001 | gpt-3.5-turbo-instruct |
| text-babbage-001 | gpt-3.5-turbo-instruct |
| text-curie-001 | gpt-3.5-turbo-instruct |
| text-davinci-001 | gpt-3.5-turbo-instruct |
| text-davinci-002 | gpt-3.5-turbo-instruct |
| text-davinci-003 | gpt-3.5-turbo-instruct |

Applications using the stable model names for base GPT‑3 models (`ada`, `babbage`, `curie`, `davinci`) will automatically be upgraded to the new models listed above on January 4, 2024. The new models will also be accessible in the coming weeks for early testing by specifying the following model names in API calls: `babbage-002`, `davinci-002`.

Developers using other older completion models (such as `text-davinci-003`) will need to manually upgrade their integration by January 4, 2024 by specifying `gpt-3.5-turbo-instruct` in the “model” parameter of their API requests. `gpt-3.5-turbo-instruct` is an InstructGPT‑style model, trained similarly to `text-davinci-003`. This new model is a drop-in replacement in the Completions API and will be available in the coming weeks for early testing.

Developers wishing to continue using their fine-tuned models beyond January 4, 2024 will need to fine-tune replacements atop the new base GPT‑3 models (`babbage-002`, `davinci-002`), or newer models (`gpt-3.5-turbo`, `gpt-4`). Once this feature is available later this year, we will give priority access to GPT‑3.5 Turbo and GPT‑4 fine-tuning to users who previously fine-tuned older models. We acknowledge that migrating off of models that are fine-tuned on your own data is challenging. We will be providing support to users who previously fine-tuned models to make this transition as smooth as possible.

In the coming weeks, we will reach out to developers who have recently used these older models, and will provide more information once the new completion models are ready for early testing.

## Deprecation of older embeddings models

Users of older embeddings models (e.g., `text-search-davinci-doc-001`) will need to migrate to `text-embedding-ada-002` by January 4, 2024. We released `text-embedding-ada-002` in December 2022, and have found it more capable and cost effective than previous models. Today `text-embedding-ada-002` accounts for 99.9% of all embedding API usage.

We recognize this is a significant change for developers using those older models. Winding down these models is not a decision we are making lightly. We will cover the financial cost of users re-embedding content with these new models. We will be in touch with impacted users over the coming days.

| **Older model** | **New model** |
| --- | --- |
| code-search-ada-code-001 | text-embedding-ada-002 |
| code-search-ada-text-001 | text-embedding-ada-002 |
| code-search-babbage-code-001 | text-embedding-ada-002 |
| code-search-babbage-text-001 | text-embedding-ada-002 |
| text-search-ada-doc-001 | text-embedding-ada-002 |
| text-search-ada-query-001 | text-embedding-ada-002 |
| text-search-babbage-doc-001 | text-embedding-ada-002 |
| text-search-babbage-query-001 | text-embedding-ada-002 |
| text-search-curie-doc-001 | text-embedding-ada-002 |
| text-search-curie-query-001 | text-embedding-ada-002 |
| text-search-davinci-doc-001 | text-embedding-ada-002 |
| text-search-davinci-query-001 | text-embedding-ada-002 |
| text-similarity-ada-001 | text-embedding-ada-002 |
| text-similarity-babbage-001 | text-embedding-ada-002 |
| text-similarity-curie-001 | text-embedding-ada-002 |
| text-similarity-davinci-001 | text-embedding-ada-002 |

## Deprecation of the Edits API

Users of the Edits API and its associated models (e.g., `text-davinci-edit-001` or `code-davinci-edit-001`) will need to migrate to GPT‑3.5 Turbo by January 4, 2024. The Edits API beta was an early exploratory API, meant to enable developers to return an edited version of the prompt based on instructions. We took the feedback from the Edits API into account when developing `gpt-3.5-turbo` and the Chat Completions API, which can now be used for the same purpose:

System

System

Apply the change requested by the user to the code.

User

def fibonacci(num):

     if num <= 1:

         return num

     else:

         return fibonacci(num-1) + fibonacci(num-2)

print(fibonacci(10))

User

Rename the function to fib.

OAI

Assistant

def fib(num):

     if num <= 1:

         return num

     else:

         return fib(num-1) + fib(num-2)

print(fib(10))

- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [API Platform](https://openai.com/news/?tags=api-platform)
- [2024](https://openai.com/news/?tags=2024)
{% endraw %}
