---
title: "Introducing GPT-4.5 | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-gpt-4-5"
date: "2025-02-27"
scraped_at: "2026-03-02T10:14:30.832147657+00:00"
language: "en-US"
translated: false
description: "We’re releasing a research preview of GPT‑4.5—our largest and best model for chat yet. GPT‑4.5 is a step forward in scaling up pre-training and post-training."
tags: ["Release"]
---

February 27, 2025

[Release](https://openai.com/research/index/release/) [Product](https://openai.com/news/product-releases/)

# Introducing GPT‑4.5

A research preview of our strongest GPT model. Available to Pro users and developers worldwide.

[Try in ChatGPT(opens in a new window)](https://chatgpt.com/?openaicom-did=336cfd23-6a4c-43c8-98fe-90b230e694cc&openaicom_referred=true)



We’re releasing a research preview of GPT‑4.5—our largest and best model for chat yet. GPT‑4.5 is a step forward in scaling up pre-training and post-training. By scaling unsupervised learning, GPT‑4.5 improves its ability to recognize patterns, draw connections, and generate creative insights without reasoning.

Early testing shows that interacting with GPT‑4.5 feels more natural. Its broader knowledge base, improved ability to follow user intent, and greater “EQ” make it useful for tasks like improving writing, programming, and solving practical problems. We also expect it to hallucinate less.

We’re sharing GPT‑4.5 as a research preview to better understand its strengths and limitations. We’re still exploring what it’s capable of and are eager to see how people use it in ways we might not have expected.

## Scaling unsupervised learning

We advance AI capabilities by scaling two complementary paradigms: unsupervised learning and reasoning. These represent two axes of intelligence.

1. Unsupervised learning increases world model accuracy and intuition. Models like GPT‑3.5, GPT‑4, and GPT‑4.5 advance this paradigm.
2. [Scaling reasoning⁠](https://openai.com/index/learning-to-reason-with-llms/), on the other hand, teaches models to think and produce a chain of thought before they respond, allowing them to tackle complex STEM or logic problems. Models like OpenAI o1 and OpenAI o3‑mini advance this paradigm.

GPT‑4.5 is an example of scaling unsupervised learning by scaling up compute and data, along with architecture and optimization innovations. GPT‑4.5 was trained on Microsoft Azure AI supercomputers. The result is a model that has broader knowledge and a deeper understanding of the world, leading to reduced hallucinations and more reliability across a wide range of topics.

#### Scaling the GPT paradigm

## GPT-4.5 (2025)

What was the first language?

We don't know exactly what the first language was, and scientists believe we'll probably never know for sure because spoken languages appeared long before written records existed.

Here's what we do know:

- **No single "first language":** Languages likely developed gradually in different groups of humans around the same time, tens or even hundreds of thousands of years ago.
- **Origin in Africa:** Most scientists agree that spoken language probably first emerged among humans in Africa, perhaps over 100,000 years ago.
- **Proto-languages:** Rather than a single language, humans likely started with simple communication that evolved into more complex languages. The earliest forms of language probably included gestures, sounds, and signals to express basic ideas and emotions.
- **Lost to history:** Because speech leaves no direct fossil record, and writing emerged relatively recently (around 5,000 years ago), we have no way to know exactly how the earliest languages sounded.

Today, linguists study existing languages to understand how they evolved over thousands of years, but the exact identity of humanity’s very first language remains—and will likely always remain—a mystery.

#### Deeper world knowledge

##### SimpleQA Accuracy (higher is better)

62.5%38.2%47%15%0102030405060708090100AccuracyGPT-4.5GPT-4oOpenAI o1OpenAI o3-mini

##### SimpleQA Hallucination Rate (lower is better)

37.1%61.8%44%80.3%0102030405060708090100Hallucination rateGPT-4.5GPT-4oOpenAI o1OpenAI o3-mini

_SimpleQA measures LLM (large language model) factuality on straightforward but challenging knowledge questions._

## Training for human collaboration

As we scale our models and they solve more complex problems, it becomes increasingly important to teach them a greater understanding of human needs and intent. For GPT‑4.5, we developed new, scalable techniques that enable training larger and more powerful models with data derived from smaller models. These techniques improve GPT‑4.5’s steerability, understanding of nuance, and natural conversation.

##### Comparative evaluations with human testers

56.8%63.2%57.0%Creative intelligenceProfessional queriesEveryday queries0102030405060708090100GPT-4.5 win-rate vs GPT-4o

_Human preference measures the percentage of queries where testers preferred GPT‑4.5 over GPT‑4o._

Combining deep understanding of the world with improved collaboration results in a model that integrates ideas naturally in warm and intuitive conversations that are more attuned to human collaboration. GPT‑4.5 has a better understanding of what humans mean and interprets subtle cues or implicit expectations with greater nuance and “EQ”. GPT‑4.5 also shows stronger aesthetic intuition and creativity. It excels at helping with writing and design.

#### Use cases

## GPT-4.5

I’m going through a tough time after failing a test

Aw, I'm really sorry to hear that. Failing a test can feel pretty tough and discouraging, but remember, it's just one moment—not a reflection of who you are or your capabilities. Want to talk about what happened, or do you just need a distraction? I'm here either way.

## GPT-4o

I’m going through a tough time after failing a test

I'm really sorry to hear that you're going through a tough time. Here are a few things you might consider:

1\. **Reflect and Understand**: Try to analyze what might have gone wrong. Was it a lack of preparation, time management during the test, or perhaps misunderstanding the material? Understanding the root cause can help you address it in the future.

2\. **Seek Support**: Talk to someone you trust—friends, family, or a school counselor. They can offer a different perspective and sometimes just talking about your feelings can be alleviating.

3\. **Speak with Your Teacher or Professor**: They can provide insights into where you might have gone wrong and offer advice on how to improve. They might also offer opportunities for make-up work or extra credit.

4\. **Develop a Study Plan**: Based on your reflections, create a plan to improve your study habits. This might include setting regular study times, breaking down material into manageable portions, or finding new study methods that work better for you.

5\. **Stay Positive and Forgive Yourself**: Mistakes and setbacks are a part of life. It’s important to be kind to yourself and recognize that failure is a stepping stone to success.

6\. **Focus on the Bigger Picture**: Remember that one test is just one part of your educational journey. There will be many more opportunities to do well.

If you need further support or resources, consider reaching out to educational support services at your institution, or mental health resources if you’re feeling particularly overwhelmed. You’re not alone in this, and things can get better with time and effort.

GPT‑4.5 shows greater “EQ” and knows when to invite further conversation versus when to provide the user with extensive information.

## Stronger reasoning on the horizon

GPT‑4.5 doesn’t think before it responds, which makes its strengths particularly different from reasoning models like OpenAI o1. Compared to OpenAI o1 and OpenAI o3‑mini, GPT‑4.5 is a more general-purpose, innately smarter model. We believe reasoning will be a core capability of future models, and that the two approaches to scaling—pre-training and reasoning—will complement each other. As models like GPT‑4.5 become smarter and more knowledgeable through pre-training, they will serve as an even stronger foundation for reasoning and tool-using agents.

## Safety

Each increase in model capabilities is also an opportunity to make the models safer. GPT‑4.5 was trained with new techniques for supervision that are combined with traditional supervised fine-tuning (SFT) and reinforcement learning from human feedback (RLHF) methods like those used for GPT‑4o. We hope this work will serve as a foundation for aligning even more capable future models.

To stress-test our improvements, we conducted a suite of safety tests before deployment, in accordance with our [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/openai-preparedness-framework-beta.pdf) ⁠. We found that scaling the GPT paradigm contributed to capability improvements across our evaluations. We are publishing the detailed results from these evaluations in the accompanying [system card⁠](https://openai.com/index/gpt-4-5-system-card/).

## How to use GPT-4.5 in ChatGPT

Starting today, ChatGPT Pro users will be able to select GPT‑4.5 in the model picker on web, mobile, and desktop. We will begin rolling out to Plus and Team users next week, then to Enterprise and Edu users the following week.

GPT‑4.5 has access to the latest up-to-date information with search, supports file and image uploads, and can use canvas to work on writing and code. However, GPT‑4.5 does not currently support multimodal features like Voice Mode, video, and screensharing in ChatGPT. In the future, we will work to simplify the user experience so AI “just works” for you.

## How to use GPT-4.5 in the API

We’re also previewing GPT‑4.5 in the Chat Completions API, Assistants API, and Batch API to developers on all [paid usage tiers⁠(opens in a new window)](https://platform.openai.com/docs/guides/rate-limits#usage-tiers). The model supports key features like function calling, Structured Outputs, streaming, and system messages. It also supports vision capabilities through image inputs.

Based on early testing, developers may find GPT‑4.5 particularly useful for applications that benefit from its higher emotional intelligence and creativity—such as writing help, communication, learning, coaching, and brainstorming. It also shows strong capabilities in agentic planning and execution, including multi-step coding workflows and complex task automation.

GPT‑4.5 is a very large and compute-intensive model, making it more [expensive⁠](https://openai.com/api/pricing/) than and not a replacement for GPT‑4o. Because of this, we’re evaluating whether to continue serving it in the API long-term as we balance supporting current capabilities with building future models. We look forward to learning more about its strengths, capabilities, and potential applications in real-world settings. If GPT‑4.5 delivers unique value for your use case, your [feedback⁠(opens in a new window)](https://community.openai.com/t/gpt-4-5-is-live-in-the-api/1131571) will play an important role in guiding our decision.

## Conclusion

With every new order of magnitude of compute comes novel capabilities. GPT‑4.5 is a model at the frontier of what is possible in unsupervised learning. We continue to be surprised by the creativity of the community in uncovering new abilities and unexpected use cases. With GPT‑4.5, we invite you to explore the frontier of unsupervised learning and uncover novel capabilities with us.

![](images/introducing-gpt-4_5-openai/img_001.png)

Play video

## Appendix

Below, we provide GPT‑4.5’s results on standard academic benchmarks to illustrate its current performance on tasks traditionally associated with reasoning. Even by purely scaling up unsupervised learning, GPT‑4.5 shows meaningful improvements over previous models like GPT‑4o. Still, we look forward to gaining a more complete picture of GPT‑4.5’s capabilities through this release, because we recognize academic benchmarks don’t always reflect real-world usefulness.

#### Model evaluation scores

|     |     |     |     |
| --- | --- | --- | --- |
|  | **GPT-4.5** | **GPT-4o** | **OpenAI o3-mini (high)** |
| GPQA (science) | 71.4% | 53.6% | 79.7% |
| AIME ‘24 (math) | 36.7% | 9.3% | 87.3% |
| MMMLU (multilingual) | 85.1% | 81.5% | 81.1% |
| MMMU (multimodal) | 74.4% | 69.1% | - |
| SWE-Lancer Diamond (coding)\* | 32.6%<br>$186,125 | 23.3%<br>$138,750 | 10.8%<br>$89,625 |
| SWE-Bench Verified (coding)\* | 38.0% | 30.7% | 61.0% |

\*Numbers shown represent best internal performance.