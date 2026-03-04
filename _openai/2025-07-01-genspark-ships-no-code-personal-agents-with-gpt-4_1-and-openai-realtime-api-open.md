---
title: "Genspark ships no-code personal agents with GPT-4.1 and OpenAI Realtime API | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/genspark"
date: "2025-07-01"
scraped_at: "2026-03-02T10:11:42.939310519+00:00"
language: "en-US"
translated: false
description: "Learn how Genspark built a $36M ARR AI product in 45 days—with no-code agents powered by GPT-4.1 and OpenAI Realtime API."
tags: ["API"]
---
&#123;% raw %}

July 1, 2025


# Genspark ships no-code personal agents with GPT‑4.1 and OpenAI Realtime API

And hit $36M ARR in just 45 days with a 20-person team.

![Genspark logo in white against a backdrop of glittering, dark sand and rocks](images/genspark-ships-no-code-personal-agents-with-gpt-4_1-and-openai-realtime-api-open/img_001.png)



[Genspark⁠(opens in a new window)](https://www.genspark.ai/) is the company behind Super Agent, a no-code, customizable AI agent that helps users automate real-world tasks like making a phone call, generating a presentation, or turning a recipe into a short video.

Super Agent uses OpenAI multimodal models and Realtime API to enable tasks across text, image, and voice, allowing users to automate complex workflows with simple prompts, no coding required. The system took off: in just 45 days, Super Agent reached $36M in ARR, driven by strong user demand.

> “OpenAI has been supporting Genspark from the beginning. Their APIs didn’t just power our models, they helped our 20-person team build, launch, and scale faster than anyone thought possible.”

Kay Zhu, CTO and Co-founder, Genspark

## Moving beyond search to agents

Genspark initially launched as an AI search engine designed to help consumers and professionals synthesize and structure information. By late 2024 user behavior started shifting. Users didn’t just want answers. They wanted outcomes. Instead of “summarize this market,” they were asking for pitch decks, video scripts, and follow-up emails. At the same time, model capabilities were rapidly expanding. Longer context windows, stronger reasoning, and new multimodal APIs made it increasingly possible to automate entire workflows, not just retrieve information.

That shift in user demand and model readiness led the team to make a bold move: in April 2025, Genspark pivoted away from search and fully embraced agentic AI.

## Building a no-code autonomous agent with OpenAI multimodal models

In April 2025, Genspark launched Super Agent: a fully autonomous, no-code assistant that can make phone calls, design slides, generate videos, and more. Under the hood, the platform orchestrates nine specialized large language models and more than 80 integrated tools, dynamically assigning each task to the best-suited component.

OpenAI models are central to this system. GPT‑4.1 handles research and structured outputs with improved instruction following and a 1M-token context window, allowing agents to process long documents in full without truncation. Strict JSON output is designed to ensure reliably structured responses for downstream tools, while automatic prompt caching reduces latency and API costs which is especially valuable in multi-step workflows. For image generation, the platform uses the GPT‑image‑1 model via the OpenAI API.

Because the system is fully no-code, users don’t need to think about any of that. They describe what they want, “call my dentist,” “summarize this report,” “make me a slide deck”, and Super Agent handles the rest.

See how Super Agent creates AI-powered slides, sheets, and phone calls using simple prompts, no code required.

## Using AI to handle resignation calls

One of Super Agent’s most talked about features is Call For Me, an AI that makes real phone calls for you, and actually holds a conversation. No scripts. No clunky transfers. Whether booking a reservation or rescheduling a delivery, the agent uses the OpenAI Realtime API and speech-to-speech capabilities to handle the conversation naturally and with real-time fluency.

A dual-layer system powers the interaction: the Realtime API manages the live dialogue, while a shadow model monitors and guides the interaction via message queue. The result is fast, coherent back-and-forth, even when the call includes hold music or ambiguous human responses. In Japan, one use case went viral: users asking the agent to handle resignation calls to their employers. It’s the kind of deeply human interaction most people don’t expect an AI agent to handle.

Beyond phone calls, users rely on Super Agent to create personalized content. Ask for a vaporwave-style pitch deck, and the agent drafts the slides, generates stylized cover images with GPT‑image‑1, and compiles the final deck. For video, it can write a scene-by-scene script, generate the images, and assemble an Instagram-ready short.

These use cases are possible by OpenAI multimodal capabilities, Genspark’s execution speed, and their close collaboration with the OpenAI startups team. Genspark met regularly with OpenAI solutions architects to share best practices, fine-tune workflows, and optimize model performance. They were among the first to launch voice experiences with the Realtime API, and continue to contribute feedback that helps drive model improvements.

“We chose OpenAI not just for model performance across modalities, but for developer experience,” says Zhu. “The OpenAI API design helped us move quickly, shipping, debugging, and scaling without bottlenecks.”

![UI from Genspark's Super Agent, displaying the product's ability to generate a detailed report and slide deck based on a user's prompt](images/genspark-ships-no-code-personal-agents-with-gpt-4_1-and-openai-realtime-api-open/img_002.png)

## Record-breaking growth, zero paid marketing

In just over a month after launching Super Agent, Genspark has:

- Grown to $36M ARR in just 45 days
- Shipped eight major agent features in 70 days

All of this was achieved with a 20-person team and no paid advertising. That growth was entirely organic, driven by product virality and word-of-mouth. Much of Super Agent’s appeal comes from its accessibility. Users don’t have to build workflows or configure settings. They just say what they need and the agent handles the rest.

## Pushing agentic AI even further with OpenAI

Next, Genspark is expanding into new categories where autonomous agents can drive even more value, like an AI browser that acts on all of the content you’re browsing and AI docs for generating format-rich documents. OpenAI APIs remain core to how the team builds fast and ships faster.

“We built Genspark to be more than a chat interface, it’s an all-in-one AI workspace,” says Zhu. “And with OpenAI APIs, we were able to make that real in record time.”

## Interested in learning more about ChatGPT for business?

[Talk with our team](https://openai.com/contact-sales/)
&#123;% endraw %}
