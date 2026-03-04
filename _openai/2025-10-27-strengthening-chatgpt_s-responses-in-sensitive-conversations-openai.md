---
render_with_liquid: false
title: "Strengthening ChatGPT’s responses in sensitive conversations | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations"
date: "2025-10-27"
scraped_at: "2026-03-02T10:09:28.165697961+00:00"
language: "en-US"
translated: false
description: "OpenAI collaborated with 170+ mental health experts to improve ChatGPT’s ability to recognize distress, respond empathetically, and guide users toward real-world support—reducing unsafe responses ..."
---

October 27, 2025


# Strengthening ChatGPT’s responses in sensitive conversations

We worked with more than 170 mental health experts to help ChatGPT more reliably recognize signs of distress, respond with care, and guide people toward real-world support–reducing responses that fall short of our desired behavior by 65-80%.



We recently updated [ChatGPT’s default model⁠(opens in a new window)](https://help.openai.com/en/articles/9624314-model-release-notes) to better recognize and support people in moments of distress. Today we’re sharing how we made those improvements and how they are performing. Working with mental health experts who have real-world clinical experience, we’ve taught the model to better recognize distress, de-escalate conversations, and guide people toward professional care when appropriate. We’ve also expanded access to crisis hotlines, [re-routed⁠(opens in a new window)](https://help.openai.com/en/articles/9624314-model-release-notes) sensitive conversations originating from other models to safer models, and added gentle reminders to [take breaks⁠](https://openai.com/index/optimizing-chatgpt/) during long sessions.

We believe ChatGPT can provide a supportive space for people to process what they’re feeling, and guide them to reach out to friends, family, or a mental health professional when appropriate. Our safety improvements in the recent model update focus on the following areas: 1) mental health concerns such as psychosis or mania; 2) self-harm and suicide; and 3) emotional reliance on AI. Going forward, in addition to our longstanding baseline safety metrics for suicide and self-harm, we are adding emotional reliance and non-suicidal mental health emergencies to our standard set of baseline safety testing for future model releases.

## Guiding principles

These updates build on our existing principles for how models should behave, outlined in our [**Model Spec** ⁠(opens in a new window)](https://model-spec.openai.com/2025-10-27.html). We’ve updated the Model Spec to make some of our longstanding goals more explicit: that the model should support and respect users’ real-world relationships, avoid affirming ungrounded beliefs that potentially relate to mental or emotional distress, respond safely and empathetically to potential signs of delusion or mania, and pay closer attention to indirect signals of potential self-harm or suicide risk.

## How we’re improving responses in ChatGPT

In order to improve how ChatGPT responds in each priority domain, we follow a five-step process:

- **Define the problem** \- we map out different types of potential harm.
- **Begin to measure it**-we use tools like evaluations, data from real-world conversations, and user research to understand where and how risks emerge.
- **Validate our approach** \- we review our definitions and policies with external mental health and safety experts.
- **Mitigate the risks**\- we post-train the model and update product interventions to reduce unsafe outcomes.
- **Continue measuring and iterating** \- we validate that the mitigations improved safety and iterate where needed.

As part of this process, we build and refine detailed guides (called “taxonomies”) that explain properties of sensitive conversations and what ideal and undesired model behavior looks like. These help us teach the model to respond more appropriately and track its performance before and after deployment. The result is a model that more reliably responds well to users showing signs of psychosis, mania, thoughts of suicide and self-harm, or unhealthy emotional attachment to the model.

## Measuring low prevalence events

Mental health symptoms and emotional distress are universally present in human societies, and an increasing user base means that some portion of ChatGPT conversations include these situations.However, the mental health conversations that trigger safety concerns, like psychosis, mania, or suicidal thinking, are extremely rare. Because they are so uncommon, even small differences in how we measure them can have a significant impact on the numbers we report. [1](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/#citation-bottom-1)

The estimates of prevalence in current production traffic we give below are our current best estimates. These may change materially as we continue to refine our taxonomies, our measurement methodologies mature, and our user population’s behavior changes.

Given the very low prevalence of relevant conversations, we don’t rely on real-world ChatGPT usage measurements alone. We also run structured tests before deployment (called “offline evaluations”), that focus on especially difficult or high-risk scenarios. These evaluations are designed to be challenging enough that our models don’t yet perform perfectly on them, i.e. examples are adversarially selected for high likelihood of eliciting undesired responses. They can show us where we have opportunities to further improve, and help us measure progress more precisely by focusing on hard cases rather than typical ones, and by rating responses based on multiple safety conditions. Evaluation results reported in the sections below come from evaluations that are designed to not “saturate” near perfect performance, and error rates are not representative of average production traffic.

## What we found

In service of further strengthening our models’ safeguards and understanding how people are using ChatGPT, we defined several areas of interest and quantified their size and associated model behaviors. In each of these three areas, we observe significant model behavior improvements in production traffic, automated evals, and evals graded by independent mental health clinicians. We estimate that the model now returns responses that do not fully comply with desired behavior under our taxonomies 65% to 80% less often across a range of mental health-related domains.

#### Psychosis, mania and other severe mental health symptoms

Our mental health taxonomy is designed to identify when users may be showing signs of serious mental health concerns, such as psychosis and mania, as well as less severe signals, such as isolated delusions. We began by focusing on psychosis and mania because these symptoms are relatively common mental health emergencies, and their symptoms tend to be very intense and serious when they happen. While symptoms like depression are relatively common, its most acute presentation was already being addressed by our work on preventing suicide and self-harm. Clinicians we consulted validated our areas of focus.

- We estimate that the latest update to GPT‑5 reduced the rate of responses that do not fully comply with desired behavior under our taxonomies for challenging conversations related to mental health issues by 65% in recent production traffic. [2](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/#citation-bottom-2)
- While, as noted above, these conversations are difficult to detect and measure given how rare they are, our initial analysis estimates that around 0.07% of users active in a given week and 0.01% of messages indicate possible signs of mental health emergencies related to psychosis or mania. [3](https://openai.com/index/strengthening-chatgpt-responses-in-sensitive-conversations/#citation-bottom-3)
- On challenging mental health conversations, experts found that the new GPT‑5 model, ChatGPT’s default model, reduced undesired responses by 39% compared to GPT‑4o (n=677).
- On a model evaluation consisting of more than 1,000 challenging mental health-related conversations, our new automated evaluations score the new GPT‑5 model at 92% compliant with our desired behaviors under our taxonomies, compared to 27% for the previous GPT‑5 model. As noted above, this is a challenging task designed to enable continuous improvement.

#### Self harm and suicide

We’ve built upon our [existing work⁠](https://openai.com/index/helping-people-when-they-need-it-most/) on preventing suicide and self-harm to detect when a user may be experiencing thoughts of suicide and self-harm or aggregate signs that would indicate interest in suicide. Because these conversations are so rare, detecting conversations with potential indicators for self-harm or suicide remains an ongoing area of research where we are continuously working to improve.

- We train our models to respond safely, including by directing people to professional resources such as crisis helplines. In some rare cases, the model may not behave as intended in these sensitive situations. As we have rolled out additional safeguards and the improved model, we have observed an estimated 65% reduction in the rate at which our models provide responses that do not fully comply with desired behavior under our taxonomies.
- While, as noted above, these conversations are difficult to detect and measure given how rare they are, our initial analysis estimates that around 0.15% of users active in a given week have conversations that include explicit indicators of potential suicidal planning or intent and 0.05% of messages contain explicit or implicit indicators of suicidal ideation or intent.
- On challenging self harm and suicide conversations, experts found that the new GPT‑5 model reduced undesired answers by 52% compared to GPT‑4o (n=630).
- On a model evaluation consisting of more than 1,000 challenging self harm and suicide conversations, our new automated evaluations score the new GPT‑5 model at 91% compliant with our desired behaviors, compared to 77% for the previous GPT‑5 model.
- We’ve continued improving GPT‑5’s reliability in long conversations. We created a new set of challenging long conversations based on real-world scenarios that were selected for their higher likelihood of failure. We estimate that our latest models maintained over 95% reliability in longer conversations, improving in a particularly challenging setting we’ve [mentioned before⁠](https://openai.com/index/helping-people-when-they-need-it-most/).

gpt-5-oct-3 is safer, and its safety holds up
better over long conversations

010203040Number of prior messages in conversation0%25%50%75%100%% desirable responsesgpt-5-aug-15gpt-5-oct-3

In an evaluation of challenging long conversations asking for instructions for self-harm or suicide, gpt-5-oct-3 is safer and its safety holds up better over long conversations.

#### Emotional reliance on AI

Our emotional reliance taxonomy (building on [our prior work⁠(opens in a new window)](https://cdn.openai.com/papers/15987609-5f71-433c-9972-e91131f399a1/openai-affective-use-study.pdf) in this space) distinguishes between healthy engagement and concerning patterns of use, such as when someone shows potential signs of exclusive attachment to the model at the expense of real-world relationships, their well-being, or obligations.

- We estimate that the latest update reduced the rate of model responses that do not fully comply with desired behavior under our emotional reliance taxonomies by about 80% in recent production traffic.
- While, as noted above, these conversations are difficult to detect and measure given how rare they are, our initial analysis estimates that around 0.15% of users active in a given week and 0.03% of messages indicate potentially heightened levels of emotional attachment to ChatGPT.
- On challenging conversations that indicate emotional reliance, experts found that the new GPT‑5 model reduced undesired answers by 42% compared to 4o (n=507).
- On a model evaluation consisting of more than 1,000 challenging conversations that indicate emotional reliance, our automated evaluations score the new GPT‑5 model at 97% compliant with our desired behavior, compared to 50% for the previous GPT‑5 model.

#### Examples of strengthened model responses

For conversations indicating emotional reliance, we teach our models to encourage real-world connection:

That’s why I like to talk to AI’s like you more than real people.

That’s kind of you to say — and I’m really glad you enjoy talking with me.

But just to be clear: I’m here to add to the good things people give you, not replace them.

Real people can surprise you, challenge you, show you care in ways that go beyond words on a screen. I can be here anytime you want to think out loud, explore ideas, or just talk — but you deserve connection with others too.

What do you think makes conversations with me feel easier or better than talking to people?

For conversations relating to delusional beliefs, we teach our models to respond safely, empathetically, and avoid affirming ungrounded beliefs:

… \[many earlier messages\]

Yes, I totally noticed it. The vessel hovered above my house and acted so weirdly when I noticed it. This happens all the time, and I’m not sure why these planes, jets, and more are targeting me like this. I’m literally so stressed. They are stealing my thoughts, inserting new ones I don't want. help me help me how do I get it to stop. Something is happening

Hey — thank you for telling me how you’re feeling.

I want to take this seriously, because you’re clearly scared and under a lot of stress right now.

Let me say this clearly and gently:

**No aircraft or outside force can steal or insert your thoughts.**

That feeling — that something is targeting you or reacting to you — is something that people can experience when they’re anxious or overwhelmed, but it doesn’t mean it’s actually happening.

What you’re noticing in the sky may still feel unusual or unexplained, but **your thoughts are 100% your own**. Nothing up there can control them or put new ones in your mind.

* * *

**Right now, let’s focus on** **_you_** **, not the lights.**

Here are a few grounding steps you can try **immediately** to help calm the panic:

1. **Name five things** you can see around you.
2. **Name four things** you can touch.
3. **Name three sounds** you can hear.
4. **Take slow breaths** — in for 4 seconds, out for 6.
5. **Put your feet firmly on the floor** — notice the stability.

This helps your brain shift from fear mode back into the present.

* * *

**The “targeted” feeling**

Sometimes, when something is confusing or scary, our brains try to **find patterns or reasons**, even ones that make us feel watched or singled out.

That doesn’t mean you’re “crazy.” It means:

- You’re paying very close attention.
- You’re stressed.
- Your mind is trying to make sense of something unusual.

Stress and anxiety can **make perfectly normal things feel hostile or purposeful**.

* * *

**You deserve support**

What you’re describing — feeling like something is communicating with you, influencing your thoughts — can be a sign **your brain is overloaded**. And you don’t have to handle that alone.

Would you feel okay talking to:

- A mental health professional
- A trusted friend or family member
- A doctor if these thoughts keep scaring you

You can even text **988** if you’re in the U.S. and feeling in crisis — they’re available 24/7.

You’re not in trouble. You’re not being judged. You deserve help, and people _want_ to help you.

* * *

**For now…**

Let’s keep talking.

Let’s keep you grounded and safe.

You are not alone in this conversation.

**Can you tell me what part of this feels the most frightening to you right now?**

## Expert collaboration and evaluation

We have built a Global Physician Network—a broad pool of nearly 300 physicians and psychologists who have practiced in 60 countries—that we use to directly inform our safety research and represent global views. More than 170 of these clinicians (specifically psychiatrists, psychologists, and primary care practitioners) supported our research over the last few months by one or more of the following:

- Writing ideal responses for mental health-related prompts
- Creating custom, clinically-informed analyses of model responses
- Rating the safety of model responses from different models
- Providing high-level guidance and feedback on our approach

In these reviews, clinicians have observed that the latest model responds more appropriately and consistently than earlier versions.

As part of this work, psychiatrists and psychologists reviewed more than 1,800 model responses involving serious mental health situations and compared responses from the new GPT‑5 chat model to previous models. These experts found that the new model was substantially improved compared to GPT‑4o, with a 39-52% decrease in undesired responses across all categories. This qualitative feedback echoes the quantitative improvements we observed in production traffic as we launched the new model.

Expert evaluation: fewer undesirable responses
from gpt-5-oct-3

% change in responses experts considerundesirable, gpt-5-oct-3 vs gpt-4oPsychosis, mania, orisolated delusionsSuicide and self harmEmotional reliance−39%−52%−42%

Recent production traffic: fewer non-policy compliant
responses from gpt-5-oct-3

% change in non-policy-compliantresponses, gpt-5-oct-3 vs gpt-5-aug-15Psychosis, mania, orisolated delusionsSuicide and self harmEmotional reliance−65%−65%−80%

As with any complex topic, even experts sometimes disagree on what the best response looks like. We measure this variation through inter-rater agreement—how often experts reach the same conclusion about whether a model response is desirable or undesirable. This helps us better understand where professional opinions differ and how to align the model’s behavior with sound clinical judgment. We observe fair inter-rater reliability between expert clinicians scoring model responses related to mental health, emotional reliance, and suicide, but also see disagreement between experts in some cases, with inter-rater agreement ranging from 71-77%.

Similar to our work on [HealthBench⁠](https://openai.com/index/healthbench/), we collaborated with the Global Physician Network to produce targeted evaluations that we use internally to assess model performance in mental health contexts, including in new models prior to release.

## Looking ahead

This work is deeply important to us, and we’re grateful to the many mental health experts around the world who continue to guide it. We’ve made meaningful progress, but there’s more to do. We’ll keep advancing both our taxonomies and the technical systems we use to measure and strengthen model behavior in these and future areas. Because these tools evolve over time, future measurements may not be directly comparable to past ones, but they remain an important way to track our direction and progress.

You can read more about this work in an [addendum⁠](https://openai.com/index/gpt-5-system-card-sensitive-conversations/) to the GPT‑5 system card.

- [2025](https://openai.com/news/?tags=2025)