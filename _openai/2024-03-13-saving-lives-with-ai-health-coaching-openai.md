---
title: "Saving lives with AI health coaching | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/healthify"
date: "2024-03-13"
scraped_at: "2026-03-02T10:20:37.808640370+00:00"
language: "en-US"
translated: false
description: "Healthify collaborates with OpenAI to improve millions of lives with sustainable weight loss."
tags: ["Story"]
---
{% raw %}


# Healthify

Healthify collaborates with OpenAI to improve millions of lives with sustainable weight loss.

[View product](https://openai.com/index/gpt-4/)

![Healthify Open Ai Cover Image 1](images/saving-lives-with-ai-health-coaching-openai/img_001.png)



With over 40 million users, [Healthify⁠(opens in a new window)](https://www.healthifyme.com/us/) is India’s largest health platform, providing health tracking and AI-enhanced health coaching to help users become fit and reverse metabolic disease. Since introducing AI in its coaching and tracking components, Healthify has already helped users lose an aggregate of 25 million+ pounds and with OpenAI’s API, Healthify is greatly simplifying tracking and scaling up coaching.

![healthify](images/saving-lives-with-ai-health-coaching-openai/img_002.png)

## Healthify’s AI journey

Healthify has been pioneering using AI for driving behavior change in health & fitness for over a decade. By 2018, Healthify already had more than 5 million users and hundreds of nutritionists and trainers exchanging millions of messages with their clients each month, along with tens of thousands of hours of calls and meal & fitness plans each month. Healthify’s data pipeline inherently also came with feedback loops—with knowledge of which messages and plans created higher engagement and impact.

Using this wealth of real-world, contextual information, Healthify made significant strides in AI, notably with the launch of Ria, the world's first AI-powered virtual nutritionist, and Coach Co-pilot—its coach-facing assistant.

Ria utilized hierarchical LSTMs (Long Short-Term Memory) and custom NLU (Natural Language Understanding) systems to accurately recognize user intents and provide relevant answers. By 2020, Ria was handling the majority of user messages directly. Combined with the Coach Co-pilot, this breakthrough allowed coaches to significantly scale their services, managing up to 300 clients simultaneously, while hitting record high NPS through improvements to personalized health coaching.

In 2021, Healthify also introduced Snap, a revolutionary feature designed to simplify calorie counting through photo recognition of food. Snap utilized Convolutional Neural Networks (CNNs) and proprietary models to accurately recognize single food items, particularly focusing on Indian cuisine. This technology not only respected user privacy but also tailored food recommendations by incorporating user-specific contexts. Over time, Snap achieved around 80% accuracy for single Indian foods.

Despite these successes, Healthify encountered challenges:

- **Performance**. It took multiple iterations to get Snap to recognize food accurately, and it struggled when photos contained multiple foods. As a result, “Snap was only used 10–20% of the time,” said Healthify CEO [Tushar Vashisht⁠(opens in a new window)](https://www.linkedin.com/in/tusharvashisht). Similarly, Ria was rules-based, so it couldn’t truly answer the long tail of valuable yet complex queries about nutrition (e.g., “how did my food yesterday affect my sleep last night?”).
- **Scale.** For each new country they wanted to add, Healthify needed to spend lots of effort on localizing models for the language, common foods, and exercise routines. “It took us two years to enter Southeast Asia,” Vashisht explained.

The collaboration with OpenAI emerged as a pivotal solution to overcome these limitations, significantly advancing Healthify’s offerings and setting a new standard for innovation in the health technology sector.

> “We integrated with everybody who’s out there. OpenAI was the best.”

Tushar Vashisht, Healthify CEO

## Using GPT-Vision and embeddings to instantly track food and scale coaching

The Healthify team believed that AI could increase their products’ accuracy, usefulness, and scalability overnight. With OpenAI’s first-to-market and simple API, the team quickly built prototypes to test model performance. Before they officially chose a provider, the team evaluated numerous model options, including open-source models.

After thorough evaluation, Healthify partnered with OpenAI for multiple reasons:

- **Best-in-class accuracy**. GPT‑4 Vision instantly surpassed Snap pipeline’s performance; the model by itself recognized foods from across the world and detected multiple food items in photos. GPT‑4 (for Ria) and Whisper (for Coach Copilot) similarly outperformed both their existing pipelines and alternative Generative AI models.
- **Easy integration.** Once they validated prototypes and it came time to integrate into their production systems, the Healthify team could simply add OpenAI’s API into their existing pipelines. “It was very easy to build proof-of-concepts with OpenAI and use those to build production systems,” said Vashisht.
- **Simple fine-tuning.** Healthify chose OpenAI in large part because fine-tuning was available out-of-the-box. It was simple to model their data for fine-tuning and upload it to the service. The team was able to successfully ground OpenAI’s models to their use case, without much configuration.
- **Embeddings.** Healthify used the Embeddings model to solve one of its key problems: how do you match two foods beyond just text matching? They needed to match food names returned by GPT‑4 with food names already in their own system. “GPT is a model of its own. It has its own dictionary of food names. Healthify has its own food names and how to do that matching is something we were trying to figure out,” commented [Abhijit Khasnis⁠(opens in a new window)](https://www.linkedin.com/in/khasnis/overlay/about-this-profile/), VP of Technology. “And when we tested the OpenAI Embeddings model, we realized that cosine similarity matching between the GPT identified food name and our food embeddings gives us high accuracy!”

![Slide 16 9 40](images/saving-lives-with-ai-health-coaching-openai/img_003.png)

## Millions of lives improved with increased engagement

Snap now employs an ensemble of proprietary models along with GPT‑4 Vision to understand user-specific contexts while ensuring data privacy. Post-image analysis, custom heuristic models are applied to deliver precise food recommendations. This upgrade has elevated Snap’s accuracy to match human recognition, streamlining the process of dietary tracking.

Ria’s latest update represents a significant leap in complexity and capability, incorporating an ensemble of fine-tuned models, including GPT 3.5 and the cutting-edge GPT‑4 Turbo. This advanced setup enables Ria to access and interpret Healthify’s extensive literature and each user’s unique history with the platform. Such integration has transformed Ria into the most comprehensive and intelligent version yet, offering personalized health and nutrition advice at an unprecedented scale.

Across the board, the Healthify team has seen engagement and retention shoot up, leading to better health outcomes for their users:

- **Users track food 50% more often with Snap.** Because food tracking is correlated with fitness goals, the Healthify team expects this engagement increase to lead to a 50% increase in users’ fitness as well. “We’re seeing that the engagement rates are 50% higher. Weight loss and fat loss are highly correlated with the foods that you track, which means that we can expect to see 50% higher impact on weight loss as well,” commented Vashisht.
- **Users engage more with Ria for nutrition & fitness coaching.** Conversation length has doubled (with some users holding conversations over two hundred messages long) and Ria is now capable of answering complex queries like “How have my glucose levels affected my sleep yesterday?” by correlating values from a Continuous Glucose Monitor (CGM), food logs from Snap & sleep logs from any wearable.
- **Coaches respond to clients in half the time**. Clients engage with AI-supported coaches 18% more as well. Stanford [Research⁠(opens in a new window)](https://www.gsb.stanford.edu/insights/ai-can-coach-you-lose-weight-human-touch-still-helps) based on Healthify’s data shows that AI-enabled human coaching helps clients lose 70% more weight than just AI coaching alone. Because of AI, Healthify’s coaches can now help more clients lose that extra 70%.

![Slide3](images/saving-lives-with-ai-health-coaching-openai/img_004.png)

## Saving a million lives

Over the next twelve months, the Healthify team is looking towards even more ambitious goals. They aim to develop autonomous health agents capable of proactively helping users make healthy choices. Instead of waiting to be triggered by a query, these agents will automatically analyze a user’s health data and make food, sleep, and exercise recommendations. With user permission, the agents will even be able to order food or book gym classes.

Throughout their whole journey, the Healthify team has focused on helping as many people hit their fitness goals and prevent metabolic diseases as possible. They’ve already made significant strides. Now, they’re scaling that impact globally. It took them two years to roll out to Southeast Asia with their traditional ML systems. But with OpenAI, they will launch in 20 countries in just this year, bringing them closer to their defining mission: “Healthify a Billion.”

> “Risk adjusted, I think partnering with OpenAI, we probably would have saved a million lives before the end of this year.”

Tushar Vashisht, Healthify CEO

## Interested in learning more about ChatGPT for business?

[Talk with our team](https://openai.com/contact-sales/)

## Related articles

[View all](https://openai.com/news/api/)

![Jetbrains > Hero > Media item > Asset](images/saving-lives-with-ai-health-coaching-openai/img_005.png)

[Embedding AI into developer software\\
\\
APIMar 21, 2024](https://openai.com/index/jetbrains/)

![Unload](images/saving-lives-with-ai-health-coaching-openai/img_006.png)

[Building a data-driven, efficient culture with AI\\
\\
ChatGPTMar 18, 2024](https://openai.com/index/holiday-extras/)

![Screenshot 2024 03 12 At 1128 27am](images/saving-lives-with-ai-health-coaching-openai/img_007.png)

[Reimagining the email experience with AI\\
\\
APIMar 18, 2024](https://openai.com/index/superhuman/)

Saving lives with AI health coaching \| OpenAI
{% endraw %}
