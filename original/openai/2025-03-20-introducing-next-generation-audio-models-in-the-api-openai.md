---
title: "Introducing next-generation audio models in the API | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-our-next-generation-audio-models"
date: "2025-03-20"
scraped_at: "2026-03-02T10:14:16.870651229+00:00"
language: "en-US"
translated: false
description: "For the first time, developers can also instruct the text-to-speech model to speak in a specific way—for example, “talk like a sympathetic customer service agent”—unlocking a new level of cust..."
tags: ["Release"]
---

March 20, 2025

[Release](https://openai.com/research/index/release/) [Product](https://openai.com/news/product-releases/)

# Introducing next-generation audio models in the API

A new suite of audio models to power voice agents, now available to developers worldwide.

[Learn more](https://openai.com/index/introducing-gpt-realtime/) [Start building(opens in a new window)](https://platform.openai.com/docs/guides/audio)

![OpenAI next-generation audio models blog hero image](images/introducing-next-generation-audio-models-in-the-api-openai/img_001.png)



_Update on August 28, 2025: We announced the general availability of the Realtime API._ [_Learn more here_](https://openai.com/index/introducing-gpt-realtime/) _._

* * *

Over the past few months, we’ve invested in advancing the intelligence, capabilities, and usefulness of text-based agents—or systems that independently accomplish tasks on behalf of users—with releases like Operator, Deep Research, Computer-Using Agents, and the Responses API with built-in tools. However, in order for agents to be truly useful, people need to be able to have deeper, more intuitive interactions with agents beyond just text—using natural spoken language to communicate effectively.

Today, we’re launching new speech-to-text and text-to-speech audio models in the API—making it possible to build more powerful, customizable, and intelligent voice agents that offer real value. Our latest speech-to-text models set a new state-of-the-art benchmark, outperforming existing solutions in accuracy and reliability—especially in challenging scenarios involving accents, noisy environments, and varying speech speeds. These improvements increase transcription reliability, making the models especially well-suited for use cases like customer call centers, meeting note transcription, and more.

For the first time, developers can also instruct the text-to-speech model to speak in a specific way—for example, “talk like a sympathetic customer service agent”—unlocking a new level of customization for voice agents. This enables a wide range of tailored applications, from more empathetic and dynamic customer service voices to expressive narration for creative storytelling experiences.

We launched our first audio model in [2022⁠](https://openai.com/index/whisper/) and since then, we’ve committed to improving the intelligence, accuracy, and reliability of these models. With these new audio models, developers can build more accurate and robust speech-to-text systems and expressive, characterful text-to-speech voices—all within the API.

Calm

Surfer

Professional

Medieval knight

True crime buff

Bedtime story

## More about our latest audio models

### New speech-to-text models

We’re introducing new `gpt-4o-transcribe` and `gpt-4o-mini-transcribe` models with improvements to word error rate and better language recognition and accuracy, compared to the original Whisper models.

`gpt-4o-transcribe` demonstrates improved Word Error Rate (WER) performance over existing Whisper models across multiple established benchmarks, reflecting significant progress in our speech-to-text technology. These advancements stem directly from targeted innovations in reinforcement learning and extensive midtraining with diverse, high-quality audio datasets.

As a result, these new speech-to-text models can better capture nuances of speech, reduce misrecognitions, and increase transcription reliability, especially in challenging scenarios involving accents, noisy environments, and varying speech speeds. These models are available now in the [speech-to-text API⁠(opens in a new window)](https://platform.openai.com/docs/guides/speech-to-text).

_Word Error Rate (WER) measures the accuracy of speech-recognition models by calculating the percentage of incorrectly transcribed words compared to a reference transcript—lower WER is better and means fewer errors. Our latest speech-to-text models achieve lower WER across benchmarks, including FLEURS (Few-shot Learning Evaluation of Universal Representations of Speech)—a multilingual speech benchmark spanning over 100 languages using manually transcribed audio samples. These results demonstrate stronger transcription accuracy and more robust language coverage. As shown here, our models consistently outperform Whisper v2 and Whisper v3 across all language evaluations._

_On FLEURS, our models deliver lower WER and strong multilingual performance. Lower WER is better and means fewer errors. As shown here, our models match or outperform other leading models across most major languages._

### New text-to-speech model

We’re also launching a new `gpt-4o-mini-tts` model with better steerability. For the first time, developers can “instruct” the model not just on what to say but _how_ to say it—enabling more customized experiences for use cases ranging from customer service to creative storytelling. The model is available in the [text-to-speech API⁠(opens in a new window)](https://platform.openai.com/docs/guides/text-to-speech). Note that these text-to-speech models are limited to artificial, preset voices, which we monitor to ensure they consistently match synthetic presets.

## Technical innovations behind the models

## Pretraining with authentic audio datasets

Our new audio models build upon the GPT‑4o and GPT‑4o‑mini architectures and are extensively pretrained on specialized audio-centric datasets, which have been critical in optimizing model performance. This targeted approach provides deeper insight into speech nuances and enables exceptional performance across audio-related tasks.

## Advanced distillation methodologies

We've enhanced our distillation techniques, enabling knowledge transfer from our largest audio models to smaller, more efficient models. Leveraging advanced self-play methodologies, our distillation datasets effectively capture realistic conversational dynamics, replicating genuine user-assistant interactions. This helps our smaller models deliver excellent conversational quality and responsiveness.

## Reinforcement learning paradigm

For our speech-to-text models, we've integrated a reinforcement learning (RL)-heavy paradigm, pushing transcription accuracy to state-of-the-art levels. This methodology dramatically improves precision and reduces hallucination, making our speech-to-text solutions exceptionally competitive in complex speech recognition scenarios.

These developments represent progress in the field of audio modeling, combining innovative methodologies with practical enhancements for enhanced performance in speech applications.

## API availability

These new audio models are available to all developers now – more on building with audio [here⁠(opens in a new window)](https://platform.openai.com/docs/guides/audio). For developers already building conversational experiences with text-based models, adding our speech-to-text and text-to-speech models is the simplest way to build a voice agent. We’re releasing an integration with the [Agents SDK⁠(opens in a new window)](https://openai.github.io/openai-agents-python/voice/quickstart/) that simplifies this development process. For developers looking to build low-latency speech-to-speech experiences, we recommend building with our speech-to-speech models in the Realtime API.

## What’s next

Looking ahead, we plan to continue to invest in improving the intelligence and accuracy of our audio models and exploring ways to allow developers to bring their own custom voices to build even more personalized experiences in ways that align with our safety standards. In addition, we’re [continuing⁠](https://openai.com/index/navigating-the-challenges-and-opportunities-of-synthetic-voices/) to engage in conversations with policymakers, researchers, developers, and creatives around the challenges and opportunities synthetic voices can present. We're excited to see the innovative and creative applications developers will build using these enhanced audio capabilities. We’ll also invest in other modalities—including video—to enable developers to build multimodal agentic experiences.

## Livestream replay

![](images/introducing-next-generation-audio-models-in-the-api-openai/img_002.png)

Play video