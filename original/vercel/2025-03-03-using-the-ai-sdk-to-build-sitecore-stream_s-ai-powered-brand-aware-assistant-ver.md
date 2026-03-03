---
title: "Using the AI SDK to build Sitecore Stream's AI-powered brand aware assistant - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/using-the-ai-sdk-to-build-sitecore-streams-ai-powered-brand-aware-assistant"
date: "2025-03-03"
scraped_at: "2026-03-02T09:35:37.941655573+00:00"
language: "en"
translated: false
description: "Sitecore Stream from Sitecore, powered by the AI SDK, empowers marketers with real-time conversational AI. "
---




Mar 3, 2025

How Sitecore built a new brand assistant that empowers marketers with real-time conversational creativity.

[Sitecore](https://www.sitecore.com/)—a leading digital experience platform—wanted to create a transformative AI tool that would help marketers connect more deeply with their brand assets, driving both consistency and creativity. Using the AI SDK, they lunched [Sitecore Stream](https://www.sitecore.com/products/sitecore-stream)—a dynamic, AI-powered brand assistant that empowers marketers to interact with their brand content in visually interactive and conversational way.

![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_001.jpg)

## Looking to Vercel for AI

> “We began our search by evaluating various AI SDKs on the market, like LangChain, Semantic Kernel, and Prompt Flow. While these focused heavily on backend AI capabilities, they didn't emphasize the frontend experience—I like to use the term 'UI for AI.' In contrast, the AI SDK by Vercel offered a seamless integration of AI with front-end user experience. For us, this was crucial, as we wanted to prioritize both AI performance and how users interact with it.We began our search by evaluating various AI SDKs on the market, like LangChain, Semantic Kernel, and Prompt Flow. While these focused heavily on backend AI capabilities, they didn't emphasize the frontend experience—I like to use the term 'UI for AI.' In contrast, the AI SDK by Vercel offered a seamless integration of AI with front-end user experience. For us, this was crucial, as we wanted to prioritize both AI performance and how users interact with it.”
>
> ![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_002.png)
>
> **Mo Cherif,** Senior Director Generative AI

### The power of the AI SDK

The [AI SDK](https://sdk.vercel.ai/) helps developers build interactive, AI-driven applications, offering tools and components designed to simplify development workflows. Sitecore's brand assistant uses Python on the backend, Next.js on the frontend, and the AI SDK to bring them together, leveraging real-time streaming to deliver fast responses that feel immediate and engaging.

[**Deploy a Next.js and Python template**\\
\\
Export how to use streaming chat completions from a Python endpoint (FastAPI) and display them using the useChat hook in your Next.js application.\\
\\
Try it out](https://vercel.com/templates/next.js/ai-sdk-python-streaming)

With the AI SDK’s pre-built elements, like the [`useChat` hook](https://sdk.vercel.ai/docs/ai-sdk-ui/chatbot) and [object generation](https://sdk.vercel.ai/docs/ai-sdk-ui/object-generation) capabilities, Sitecore’s development team could focus on crafting unique brand-driven interactions quickly:

- Chat AI is integrated into the design or layout with minimal effort

- All the messages from the AI provider are streamed to the chat UI in real-time

- The hook manages the states for input, messages, loading, error, and more


This allowed them to build a robust, full-featured application without getting bogged down by the complexities of implementing AI.

The AI SDK was instrumental in achieving Sitecore's vision for the brand assistant by enabling visually interactive experiences. With server-side rendering and streaming, Sitecore Stream can handle high volumes of data with ease, delivering responses that provide immediate feedback—essential for a good user experience. The SDK's ability to manage complex data streaming between Azure-hosted backends and Next.js frontends allowed Sitecore to rapidly build the brand assistant, meeting both their technical and timeline requirements.

### A conversational UI for brand storytelling

The brand assistant allows marketers to ask questions, brainstorm ideas, and generate content in real-time. For example, a marketer can ask for suggestions on visual assets or content ideas aligned with the brand's tone of voice, and the assistant responds with text, images, and even content previews. It’s an interactive and conversational experience where marketers feel like they’re working with a virtual creative partner that understands their brand.

![](images/using-the-ai-sdk-to-build-sitecore-stream_s-ai-powered-brand-aware-assistant-ver/img_003.jpg)

This rich interactivity is powered by agent-based models, tailored to retain Sitecore’s customer's brand knowledge and tone. The friendly UI provides marketers with an environment, making AI accessible regardless of technical expertise.

### Build towards a future of modular, scalable AI

Sitecore envisions a future where their clients can use features like brainstorming or finding visual assets, each requiring unique user experiences. For example, brainstorming and content creation with AI involve very different workflows. With the AI SDK, the team can easily render multiple interactive widgets on the server and push them to the client, to deliver custom-tailored experiences.

In choosing the AI SDK, Sitecore has laid the foundation for a future where AI-powered brand interaction is intuitive and deeply integrated with the unique needs of each brand. With the brand assistant, Sitecore is not only delivering an innovative product; they're setting a new standard for AI in digital marketing.

[**Unlock rapid AI development**\\
\\
Build AI-powered applications with the AI SDK. \\
\\
Get started with the AI SDK](https://sdk.vercel.ai/docs/introduction#vercel-ai-sdk)