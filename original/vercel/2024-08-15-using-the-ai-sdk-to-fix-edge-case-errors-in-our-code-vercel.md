---
title: "Using the AI SDK to fix edge-case errors in our code - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code"
date: "2024-08-15"
scraped_at: "2026-03-02T09:41:52.458603734+00:00"
language: "en"
translated: false
description: "Leveraging the AI SDK to build with and solve problems with AI"
---




Aug 15, 2024

How our team at Vercel used AI-based logic to improve our domain registry experience for international domains.

Recently, there was an issue affecting our customers when trying to purchase a domain containing non-English characters. This problem became apparent when these domain purchases consistently failed, creating a significant roadblock for users wanting to expand their online presence with internationalized domain names (IDNs).

### The bug background

The root of the problem was the encoding process. Domains with non-English characters are encoded in Punycode format. This encoding allows for a wide range of international characters to be represented using the limited character set of the ASCII standard. However, when we sent these encoded domains to our domain registrar, OpenSRS, we encountered cryptic error messages that gave little indication of the underlying issue.

![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_001.jpg)![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_002.jpg)

Through a deep dive into the OpenSRS documentation, we discovered that purchasing a Punycode domain requires an associated language code. Although our system had a placeholder for this language code, it was left as optional and consequently, was not being utilized. This omission was the crux of our issue.

The next challenge was determining the correct language code for each domain. Initially, we attempted to use Common Language Detector 2 (CLD2), a library designed to detect the language of a text. Unfortunately, the domain names were too short for CLD2 to accurately determine the language.

### AI, our most valuable player

To overcome this, we turned to the [Vercel AI SDK](https://sdk.vercel.ai/docs/introduction). The AI SDK is our open-source toolkit designed to simplify the integration and deployment of AI models in applications. The unified interface lets you work with various AI models and providers, so you can seamlessly switch between them with minimal code changes.

First, we chose a method. We went with `generateText` because we needed a singular text output in the form of a 3 character language code. Since this process isn't interactive, meaning there's no back and forth with the user, there's no need to use streamText. We didn’t need generateObject either, which uses schemas to give you structured data, because our use case isn't complex enough to require object generation.

With the AI SDK, we can easily test out different [models](https://sdk.vercel.ai/docs/foundations/providers-and-models) and look for the best accuracy with a large enough context window for us to pass in the list of language codes we wanted the model to choose from. This led us to GPT-4o from [OpenAI](https://sdk.vercel.ai/providers/ai-sdk-providers/openai).

GPT-4o was able to determine the appropriate language code for each domain. The results were remarkable. The AI successfully identified the correct language codes, even for the shortest and most complex domain names.

![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_003.jpg)![](images/using-the-ai-sdk-to-fix-edge-case-errors-in-our-code-vercel/img_004.jpg)

**We rigorously tested the solution provided by GPT-4o on previously failed domain purchases of the last two months and achieved a 100% success rate.** Encouraged by these results, we deployed the solution to production. Since then, we've had numerous successful Punycode domain purchases, marking a significant improvement in our system's user experience.

### Leveraging AI in every development process

Turning to AI to solve complex problems is becoming second nature. Thanks to the AI SDK, our system correctly handles Punycode domains with the appropriate language codes, we've removed a significant barrier for our international users and enhanced the overall functionality of our platform.

[**Unlock rapid AI development**\\
\\
Build AI-powered applications with the AI SDK. \\
\\
Get started with the AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)