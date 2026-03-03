---
title: "GPT 5.2 models now available on Vercel AI Gateway - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/gpt-5-2-models-now-available-on-vercel-ai-gateway"
date: "2025-12-11"
scraped_at: "2026-03-02T09:24:01.395696003+00:00"
language: "en"
translated: false
description: "You can now access the GPT 5.2 models on Vercel's AI Gateway with no other provider accounts required."
---




Dec 11, 2025

You can now access OpenAI's latest GPT-5.2 models with Vercel's [AI Gateway](https://vercel.com/ai-gateway) and no other provider accounts required.

These models perform better than the GPT-5.1 model series, with noted improvements in professional knowledge work, coding, and long-context reasoning. Other highlights include fewer hallucinations, more accurate vision to interpret graphs and visualizations, strong complex front-end work capabilities, and better information retention working with long documents.

There are 3 models available on AI Gateway:

- GPT-5.2 Chat (`openai/gpt-5.2-chat`) is the model used in ChatGPT, best suited for everyday work and learning.

- GPT-5.2 (`openai/gpt-5.2`) is for deeper work and complex tasks involving coding or long documents.

- GPT-5.2 Pro (`openai/gpt-5.2-pro`) is best suited for the most difficult questions and tasks with large amounts of reasoning.


To use the GPT-5.2 models with the [AI SDK](https://ai-sdk.dev/), set the model to the respective model slug (noted above):

```tsx
import { streamText } from 'ai';



const result = streamText({

4  model: 'openai/gpt-5.2-pro',

5  prompt:

6    `Create a single-page aurora sky visualizer app in a single HTML file.

7     It should display a realistic animated aurora borealis night sky.

8     Change solar activity level, color palette (green/purple/mixed),

9     and sky clarity (haze, clear, light clouds).

10     The UI should feel tranquil, immersive, and visually realistic,

11     with smooth transitions and subtle ambient motion.`

12  providerOptions: {

13    openai: {

14      reasoningSummary: 'detailed',

15      reasoningEffort: 'high',

16    },

17  },

18});
```

AI Gateway provides a unified API for calling models, tracking usage and cost, and configuring retries, failover, and performance optimizations for higher-than-provider uptime. It includes built-in [observability](https://vercel.com/docs/ai-gateway/observability), [Bring Your Own Key support](https://vercel.com/docs/ai-gateway/byok), and intelligent [provider routing](https://vercel.com/docs/ai-gateway/provider-options) with automatic retries.

Learn more about [AI Gateway](https://vercel.com/docs/ai-gateway), view the [AI Gateway model leaderboard](https://vercel.com/ai-gateway/leaderboards) or try it in our [model playground](https://vercel.com/ai-gateway/models/gpt-5.2-pro).

[**AI Gateway: Track top AI models by usage**\\
\\
The AI Gateway model leaderboard ranks the most used models over time by total token volume across all traffic through the Gateway. Updates regularly.\\
\\
View the leaderboard](https://vercel.com/ai-gateway/leaderboards)