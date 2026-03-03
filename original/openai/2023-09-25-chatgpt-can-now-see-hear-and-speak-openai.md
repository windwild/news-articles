---
title: "ChatGPT can now see, hear, and speak | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/chatgpt-can-now-see-hear-and-speak"
date: "2023-09-25"
scraped_at: "2026-03-02T10:22:40.404529618+00:00"
language: "en-US"
translated: false
description: "We are beginning to roll out new voice and image capabilities in ChatGPT. They offer a new, more intuitive type of interface by allowing you to have a voice conversation or show ChatGPT what you’re ..."
tags: ["Product"]
---

September 25, 2023


# ChatGPT can now see, hear, and speak

![ChatGPT Can Now See Hear And Speak](images/chatgpt-can-now-see-hear-and-speak-openai/img_001.jpg)


We are beginning to roll out new voice and image capabilities in ChatGPT. They offer a new, more intuitive type of interface by allowing you to have a voice conversation or show ChatGPT what you’re talking about.

Voice and image give you more ways to use ChatGPT in your life. Snap a picture of a landmark while traveling and have a live conversation about what’s interesting about it. When you’re home, snap pictures of your fridge and pantry to figure out what’s for dinner (and ask follow up questions for a step by step recipe). After dinner, help your child with a math problem by taking a photo, circling the problem set, and having it share hints with both of you.

We’re rolling out voice and images in ChatGPT to Plus and Enterprise users over the next two weeks. Voice is coming on iOS and Android (opt-in in your settings) and images will be available on all platforms.

## Speak with ChatGPT and have it talk back

You can now use voice to engage in a back-and-forth conversation with your assistant. Speak with it on the go, request a bedtime story for your family, or settle a dinner table debate.

![Rectangle Speak with ChatGPT and have it talk back](images/chatgpt-can-now-see-hear-and-speak-openai/img_002.png)

00:00

Use voice to engage in a back-and-forth conversation with your assistant.

To get started with voice, head to Settings → New Features on the mobile app and opt into voice conversations. Then, tap the headphone button located in the top-right corner of the home screen and choose your preferred voice out of five different voices.

The new voice capability is powered by a new text-to-speech model, capable of generating human-like audio from just text and a few seconds of sample speech. We collaborated with professional voice actors to create each of the voices. We also use Whisper, our open-source speech recognition system, to transcribe your spoken words into text.

## Listen to voice samples

Select text
StoryRecipeSpeechPoemExplanation

> Once in a tranquil woodland, there was a fluffy mama cat named Lila. One sunny day, she cuddled with her playful kitten, Milo, under the shade of an old oak tree.
>
> “Milo,” Lila began, her voice soft and gentle, “you’re going to have a new playmate soon.”
>
> Milo’s ears perked up, curious. “A new playmate?”
>
> Lila purred, “Yes, a baby sister.”
>
> Milo’s eyes widened with excitement. “A sister? Will she chase tails like I do?”
>
> Lila chuckled. “Oh, she’ll have her own quirks. You’ll teach her, won’t you?”
>
> Milo nodded eagerly, already dreaming of the adventures they’d share.

Select voice
JuniperSkyCoveEmberBreeze

## Chat about images

You can now show ChatGPT one or more images. Troubleshoot why your grill won’t start, explore the contents of your fridge to plan a meal, or analyze a complex graph for work-related data. To focus on a specific part of the image, you can use the drawing tool in our mobile app.

![Chat about images](images/chatgpt-can-now-see-hear-and-speak-openai/img_003.jpg)

00:00

Show ChatGPT one or more images.

To get started, tap the photo button to capture or choose an image. If you’re on iOS or Android, tap the plus button first. You can also discuss multiple images or use our drawing tool to guide your assistant.

Image understanding is powered by multimodal GPT‑3.5 and GPT‑4. These models apply their language reasoning skills to a wide range of images, such as photographs, screenshots, and documents containing both text and images.

## We are deploying image and voice capabilities gradually

OpenAI’s goal is to build AGI that is safe and beneficial. We believe in making our tools available gradually, which allows us to make improvements and refine risk mitigations over time while also preparing everyone for more powerful systems in the future. This strategy becomes even more important with advanced models involving voice and vision.

### Voice

The new voice technology—capable of crafting realistic synthetic voices from just a few seconds of real speech—opens doors to many creative and accessibility-focused applications. However, these capabilities also present new risks, such as the potential for malicious actors to impersonate public figures or commit fraud.

This is why we are using this technology to power a specific use case—voice chat. Voice chat was created with voice actors we have directly worked with. We’re also collaborating in a similar way with others. For example, Spotify is using the power of this technology for the pilot of their [Voice Translation⁠(opens in a new window)](https://newsroom.spotify.com/2023-09-25/ai-voice-translation-pilot-lex-fridman-dax-shepard-steven-bartlett) feature, which helps podcasters expand the reach of their storytelling by translating podcasts into additional languages in the podcasters’ own voices.

### Image input

Vision-based models also present new challenges, ranging from hallucinations about people to relying on the model’s interpretation of images in high-stakes domains. Prior to broader deployment, we tested the model with red teamers for risk in domains such as extremism and scientific proficiency, and a diverse set of alpha testers. Our research enabled us to align on a few key details for responsible usage.

#### Making vision both useful and safe

Like other ChatGPT features, vision is about assisting you with your daily life. It does that best when it can see what you see.

This approach has been informed directly by our work with Be My Eyes, a free mobile app for blind and low-vision people, to understand uses and limitations. Users have told us they find it valuable to have general conversations about images that happen to contain people in the background, like if someone appears on TV while you’re trying to figure out your remote control settings.

We’ve also taken technical measures to significantly limit ChatGPT’s ability to analyze and make direct statements about people since ChatGPT is not always accurate and these systems should respect individuals’ privacy.

Real world usage and feedback will help us make these safeguards even better while keeping the tool useful.

#### Transparency about model limitations

Users might depend on ChatGPT for specialized topics, for example in fields like research. We are transparent about the model's limitations and discourage higher risk use cases without proper verification. Furthermore, the model is proficient at transcribing English text but performs poorly with some other languages, especially those with non-roman script. We advise our non-English users against using ChatGPT for this purpose.

You can read more about our approach to safety and our work with Be My Eyes in the [system card for image input⁠](https://openai.com/index/gpt-4v-system-card/).

## We will be expanding access

Plus and Enterprise users will get to experience voice and images in the next two weeks. We’re excited to roll out these capabilities to other groups of users, including developers, soon after.

- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [2023](https://openai.com/news/?tags=2023)