---
title: "Our approach to age prediction | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/our-approach-to-age-prediction"
date: "2026-01-20"
scraped_at: "2026-03-02T10:08:32.016422188+00:00"
language: "en-US"
translated: false
description: "ChatGPT is rolling out age prediction to estimate if accounts are under or over 18, applying safeguards for teens and refining accuracy over time."
tags: ["Safety"]
---

January 20, 2026

[Safety](https://openai.com/news/safety-alignment/) [Company](https://openai.com/news/company-announcements/)

# Our approach to age prediction

Building on our work to strengthen teen safety.



We’re rolling out age prediction on ChatGPT consumer plans to help determine whether an account likely belongs to someone under 18, so the right experience and safeguards can be applied to teens. As we’ve outlined in our [Teen Safety Blueprint⁠](https://openai.com/index/introducing-the-teen-safety-blueprint/) and [Under-18 Principles for Model Behavior⁠](https://openai.com/index/updating-model-spec-with-teen-protections/), young people deserve technology that both expands opportunity and protects their well-being.

Age prediction builds on protections already in place. Teens who tell us they are under 18 when they sign up automatically receive additional safeguards to reduce exposure to sensitive or potentially harmful content. This also enables us to treat adults like adults and use our tools in the way that they want, within the bounds of safety.

We previously shared our [early plans⁠](https://openai.com/index/building-towards-age-prediction/) for age prediction, and today we’re sharing more detail as the rollout is underway.

## How age prediction works

ChatGPT uses an age prediction model to help estimate whether an account likely belongs to someone under 18. The model looks at a combination of behavioral and account-level signals, including how long an account has existed, typical times of day when someone is active, usage patterns over time, and a user’s stated age. Deploying age prediction helps us learn which signals improve accuracy, and we use those learnings to continuously refine the model over time.

Users who are incorrectly placed in the under-18 experience will always have a fast, simple way to confirm their age and restore their full access with a selfie through Persona, a secure identity-verification service. Users can check if safeguards have been added to their account and start this process at any time by going to Settings > Account.

When the age prediction model estimates that an account may belong to someone under 18, ChatGPT automatically applies [additional protections⁠](https://openai.com/index/updating-model-spec-with-teen-protections/) designed to reduce exposure to sensitive content, such as:

- Graphic violence or gory content
- Viral challenges that could encourage risky or harmful behavior in minors
- Sexual, romantic, or violent role play
- Depictions of self-harm
- Content that promotes extreme beauty standards, unhealthy dieting, or body shaming

This approach is guided by expert input and rooted in academic literature about the science of child development and acknowledges known teen differences in risk perception, impulse control, peer influence, and emotional regulation. While these content restrictions help reduce teens’ exposure to sensitive material, we are focused on continually improving these protections, especially to address attempts to bypass our safeguards. When we are not confident about someone’s age or have incomplete information, we default to a safer experience.

In addition to these safeguards, parents can choose to customize their teen’s experience further through [parental controls⁠(opens in a new window)](https://help.openai.com/en/articles/12315553-parental-controls-on-chatgpt-faq) including setting quiet hours when ChatGPT can not be used, controlling features such as memory or model training, and receiving notifications if signs of acute distress are detected.

## What’s next

We’re learning from the initial rollout and continuing to improve the accuracy of age prediction over time. We will closely track rollout and use those signals to guide ongoing improvements.

In the EU, age prediction will roll out in the coming weeks to account for regional requirements. For more detail, visit our [help page⁠(opens in a new window)](https://help.openai.com/en/articles/12652064-age-prediction-in-chatgpt).

While this is an important milestone, our work to support teen safety is ongoing. We’ll continue to share updates on our progress and what we’re learning, in dialogue with experts including the American Psychological Association, ConnectSafely, and [Global Physicians Network⁠](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/).

- [2026](https://openai.com/news/?tags=2026)
- [ChatGPT](https://openai.com/news/?tags=chatgpt)
- [User Safety & Control](https://openai.com/news/?tags=user-safety)