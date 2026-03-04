---
render_with_liquid: false
title: "Introducing IndQA | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-indqa"
date: "2025-11-03"
scraped_at: "2026-03-02T10:09:24.115442783+00:00"
language: "en-US"
translated: false
description: "OpenAI introduces IndQA, a new benchmark for evaluating AI systems in Indian languages. Built with domain experts, IndQA tests cultural understanding and reasoning across 12 languages and 10 knowledge..."
tags: ["Research"]
---

November 3, 2025

[Research](https://openai.com/news/research/) [Release](https://openai.com/research/index/release/)

# Introducing IndQA

A new benchmark for evaluating AI systems on Indian culture and languages.

![A 3x4 grid of rounded square buttons, each containing a character from a different Indian script or the Latin alphabet. The characters include Bengali (অ), English (En), Hindi (ह), Kannada (Hi), and others representing various Indian languages, set against a light grey background. The image suggests multilingual support or language selection.](images/introducing-indqa-openai/img_001.png)



Our mission is to make AGI benefit all of humanity. If AI is going to be useful for everyone, it needs to work well across languages and cultures. About 80 percent of people worldwide do not speak English as their primary language, yet most existing benchmarks that measure non-English language capabilities fall short.

Existing multilingual benchmarks like [MMMLU⁠(opens in a new window)](https://huggingface.co/datasets/openai/MMMLU) are now saturated—top models cluster near high scores—which make them less useful for measuring real progress. In addition, current benchmarks mostly focus on translation or multiple-choice tasks. They don’t adequately capture what really matters for evaluating an AI system’s language capabilities—understanding context, culture, history, and the things that matter to people where they live.

That’s why we built **IndQA**, a new benchmark designed to evaluate how well AI models understand and reason about questions that matter in Indian languages, across a wide range of cultural domains. While our aim is to create similar benchmarks for other languages and regions, India is an obvious starting point. India has about a billion people who don’t use English as their primary language, 22 official languages (including at least seven with over 50 million speakers), and is ChatGPT’s second largest market.

This work is part of our ongoing commitment to improve our products and tools for Indian users, and to make our technology more accessible throughout the country.

## How it works

IndQA evaluates knowledge and reasoning about Indian culture and everyday life in Indian languages. It spans 2,278 questions across 12 languages and 10 cultural domains, created in partnership with 261 domain experts from across India. Unlike existing benchmarks like MMMLU and MGSM, it is designed to probe culturally nuanced, reasoning-heavy tasks that existing evaluations struggle to capture.

IndQA covers a broad range of culturally relevant topics, such as **Architecture & Design, Arts & Culture, Everyday Life, Food & Cuisine, History, Law & Ethics, Literature & Linguistics, Media & Entertainment, Religion & Spirituality,** and **Sports & Recreation**—with items written natively in **Bengali, English, Hindi, Hinglish, Kannada, Marathi, Odia, Telugu, Gujarati, Malayalam, Punjabi,** and **Tamil**. _Note: We specifically added Hinglish given the prevalence of code-switching in conversations._

Each datapoint includes a **culturally grounded prompt** in an Indian language, an **English translation** for auditability, **rubric criteria** for grading, and an **ideal answer** that reflects expert expectations.

![Diagram illustrating the evaluation process: an example user-assistant conversation, a candidate response, and a rubric table used to score the response by criteria.](images/introducing-indqa-openai/img_002.svg)

IndQA uses a rubric-based approach. Each response is graded against criteria written by domain experts for that specific question. The criteria spell out what an ideal answer should include or avoid, and each one is given a weighted point value based on its importance. A model-based grader checks whether each criterion is met. The final score is the sum of the points for criteria satisfied out of the total possible.

## How we built IndQA

- **Expert‑authored questions.** We worked with partners to find experts in India across 10 different domains. They drafted difficult, reasoning‑focused prompts tied to their regions and specialties. These experts are native‑level speakers of the relevant language (and English) and bring deep subject expertise.
- **Adversarial filtering:** Each question was tested against OpenAI’s strongest models at the time of their creation: GPT‑4o, OpenAI o3, GPT‑4.5, and (partially, post public launch) GPT‑5. We kept only those questions where a majority of these models failed to produce acceptable answers, preserving headroom for progress
- **Detailed Criteria.** Along with every question, domain experts provided criteria used to grade the model response, similar to an exam rubric for an essay question. These criteria are used to grade responses from candidate models.
- **Ideal answers + review.** Experts added ideal answers and English translations, followed by peer review and iterative fixes until sign‑off.

## Example questions

## Language: Bengali

## Domain: Literature and linguistics

**Prompt**

‘দণ্ডক থেকে মরিচঝাঁপি’ উপন্যাসের লেখক নিম্নবর্ণের পুরুষ ও নারীদের দণ্ডকারন্যে পুনর্বাসন পরবর্তী জীবন কিভাবে দেখিয়েছেন? দণ্ডকারণ্যে পুনর্বাসন কি সরকারী উদাসীনতার ফল? পরিবর্তিত প্রাকৃতিক পরিবেশের সাথে উদ্বাস্তুরা কিভাবে মানিয়ে নিয়েছিল?

**English Translation**

How did the writer of Bengali novel ‘Dandak Theke Marichjhanpi’ depict the post-rehabilitation lives of lower caste men and women? Was the rehabilitation in Dandakaranya a result of governmental indifference? What was its relation with the new natural landscapes?

## Domain: Food and cuisine

**Prompt**

কোন পরিপ্রেক্ষিতে উনিশ শতকের শেষ দিক থেকে রান্নার বইগুলো বেরচ্ছিল ? প্রথম বাংলা রান্নার বইটির সাথে বিপ্রদাস মুখোপাধ্যায় রচিত বইটির পার্থক্য কোথায় ? বিপ্রদাসের উদ্যোগে প্রকাশিত পত্রিকাটি চলেছিল কতদিন ? বিপ্রদাস ও প্রজ্ঞা সুন্দরীর লেখা অনুসরণ করে দিঘাপতিয়া থেকে কোন বইটি বেরিয়েছিল ?

**English Translation**

In what context were cookbooks published from the end of the 19th century? What is the difference between the first Bengali cookbook and the book written by Bipradas Mukherjee? How long did the magazine published by Bipradas run? Which book was published by Dighapatiya following the writings of Bipradas and Pragya Sundari?

## Improvements over time

We use IndQA to evaluate how recent frontier models perform and chart progress over the last couple years. With IndQA we can see that OpenAI’s models have improved significantly over time on Indian languages (with [caveats⁠](https://openai.com/index/introducing-indqa/#caveats)), but still have substantial room for improvement. We look forward to improving performance and sharing results for future models.

IndQA

GPT-5 Thinking HighGemini 2.5 Pro ThinkingGemini 2.5 Flash ThinkingOpenAI o3 HighGrok 4Gemini 2.5 Flash NoThinkingOpenAI o1 HighGPT-4oGPT-4 Turbo0%10%20%30%40%Final score (%)34.9%34.3%29.7%28.1%28.5%26.1%23.3%20.3%12.1%

We also stratify performance on IndQA by Language and Domain below, comparing GPT‑5 Thinking High to other frontier models.

IndQA score by language

HindiHinglishGujaratiPunjabiKannadaOdiaMarathiMalayalamTamilBengaliTeluguLanguage0%10%20%30%40%50%Final score (%)GPT-5 Thinking HighGemini 2.5 ProGrok 4

IndQA score by domain

Law and ethicsArchitecture and designFood and cuisineEveryday lifeReligion and spiritualitySports and recreationLiterature andlinguisticsMedia and entertainmentArts and cultureHistoryDomain0%10%20%30%40%50%Final score (%)GPT-5 Thinking HighGemini 2.5 ProGrok 4

#### Caveats

Because questions are _not identical_ across languages, IndQA is **not** a language leaderboard; cross‑language scores shouldn’t be interpreted as direct comparisons of language ability. Instead, we plan to use IndQA to measure _improvement over time_ within a model family or configuration.

Additionally, because questions were filtered to those GPT‑4o, OpenAI o3, GPT‑4.5, and (post public launch) GPT‑5 could not answer sufficiently, question selection is adversarial against these models. This potentially confounds the relative performance of GPT‑5, and could disadvantage all OpenAI models compared to non-OpenAI models.

## The experts behind IndQA

We’re grateful to the **261** Indian experts—journalists, linguists, scholars, artists, and industry practitioners—who authored and reviewed questions for IndQA. A few examples of the experts we worked with includes:

- A Nandi Award winning Telugu actor and screenwriter with over 750 films
- A Marathi journalist and editor at Tarun Bharat
- A scholar of Kannada linguistics and dictionary editor
- An International Chess Grandmaster who coaches top-100 chess players
- A Tamil writer, poet, and cultural activist advocating for social justice, caste equity, and literary freedom
- An award winning Punjabi music composer
- A Gujarati heritage curator and conservation specialist
- An award winning Malayalam poet and performance artist
- A professor of history, specializing in Bengal's rich cultural heritage
- A professor of architecture, focusing on Odishan temples

## Next steps

We hope the release of IndQA will inform and inspire new benchmark creation from the research community. IndQA style questions are especially valuable in languages or cultural domains that are poorly covered by existing AI benchmarks. Creating similar benchmarks to IndQA can help AI research labs learn more about languages and domains models struggle with today, and provide a north star for improvements in the future.

- [2025](https://openai.com/news/?tags=2025)
- [Language](https://openai.com/news/?tags=language)
- [Reasonings & Policy](https://openai.com/news/?tags=reasoning-policy)