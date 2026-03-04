---
title: "Language models can explain neurons in language models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/language-models-can-explain-neurons-in-language-models"
date: "2023-05-09"
scraped_at: "2026-03-02T10:23:53.430935121+00:00"
language: "en-US"
translated: false
description: "We use GPT-4 to automatically write explanations for the behavior of neurons in large language models and to score those explanations. We release a dataset of these (imperfect) explanations and scores..."
tags: ["Safety & Alignment"]
---
{% raw %}

May 9, 2023


# Language models can explain neurons in language models

[Read paper(opens in a new window)](https://openaipublic.blob.core.windows.net/neuron-explainer/paper/index.html) [View neurons(opens in a new window)](https://openaipublic.blob.core.windows.net/neuron-explainer/neuron-viewer/index.html) [View code and dataset(opens in a new window)](https://github.com/openai/automated-interpretability)

![An abstract digital painting with layered bands of color transitioning from deep green and blue at the bottom to vibrant purple, coral, and golden yellow at the top.](images/language-models-can-explain-neurons-in-language-models-openai/img_001.png)



We use GPT‑4 to automatically write explanations for the behavior of neurons in large language models and to score those explanations. We release a dataset of these (imperfect) explanations and scores for every neuron in GPT‑2.

Language models have become more capable and more broadly deployed, but our understanding of how they work internally is still very limited. For example, it might be difficult to detect from their outputs whether they use biased heuristics or engage in deception. Interpretability research aims to uncover additional information by looking inside the model.

One simple approach to interpretability research is to first understand what the individual components (neurons and attention heads) are doing. This has traditionally required humans to [manually⁠(opens in a new window)](https://distill.pub/2020/circuits/curve-detectors/) [inspect⁠](https://openai.com/index/microscope/) [neurons⁠(opens in a new window)](https://transformer-circuits.pub/2022/solu/index.html) to figure out what features of the data they represent. This process doesn’t scale well: it’s hard to apply it to neural networks with tens or hundreds of billions of parameters. We propose an automated process that uses GPT‑4 to produce and score natural language explanations of neuron behavior and apply it to neurons in another language model.

This work is part of the third pillar of our [approach to alignment research⁠](https://openai.com/index/our-approach-to-alignment-research/): we want to automate the alignment research work itself. A promising aspect of this approach is that it scales with the pace of AI development. As future models become increasingly intelligent and helpful as assistants, we will find better explanations.

## How it works

Our methodology consists of running 3 steps on every neuron.

### Marvel comics vibes

Marvel comics vibesdoing things rightsubtle pluralssimilescertaintyN and N+1X by/after \*X\*pattern breaksnot allshared last namessubjunctive verbsC predictor

#### Sample 1 of 12

NextNext sample

### Step 1: Generate explanation using GPT-4

The Avengers to the big screen, Joss Whedon has returned to reunite Marvel's gang of superheroes for their toughest challenge yet. Avengers: Age of Ultron pits the titular heroes against a sentient artificial intelligence, and smart money says that it could soar at the box office to be the highest-grossing film of the

introduction into the Marvel cinematic universe, it's possible, though Marvel Studios boss Kevin Feige told Entertainment Weekly that, "Tony is earthbound and facing earthbound villains. You will not find magic power rings firing ice and flame beams." Spoilsport! But he does hint that they have some use… STARK T

, which means this Nightwing movie is probably not about the guy who used to own that suit. So, unless new director Matt Reeves' The Batman is going to dig into some of this backstory or introduce the Dick Grayson character in his movie, the Nightwing movie is going to have a lot of work to do explaining

of Avengers who weren't in the movie and also Thor try to fight the infinitely powerful Magic Space Fire Bird. It ends up being completely pointless, an embarrassing loss, and I'm pretty sure Thor accidentally destroys a planet. That's right. In an effort to save Earth, one of the heroes inadvertantly blows up an

Given a GPT-2 neuron, generate an explanation of its behavior by showing relevant text sequences and activations to GPT-4.

#### Model-generated explanation:

references to movies, characters, and entertainment.

### Step 2: Simulate using GPT-4

Simulate what a neuron that fired for the explanation would do, again using GPT-4

: Age of Ultron and it sounds like his role is going to play a bigger part in the Marvel cinematic universe than some of you originally thought.Marvel has a new press release that offers up some information on the characters in the film. Everything included in it is pretty standard stuff, but then there was this new

their upcoming 13-episode series for Marvel's Daredevil.It begins with a young Matt Murdock telling his blind martial arts master Stick that he lost his sight when he was 9-years-old. And then me into the present with a grateful Karen Page explaining that a masked vigilante saved her life.

offbeat , Screenshots \| Follow This Author @KartikMdglWe have two images from Skyrim, which totally stumped us. They show a walking barrel, and we're not sure how exactly that happened.Check out these two images below.Some people really do some weird

ultimate in lightweight portability.Generating chest-thumping lows and crystal clear highs, the four models in the series – the XLS1000, XLS1500, XLS2000, and XLS2500 – are engineered to meet any demanding audio requirements – reliably and within budget.Every XLS

### Step 3: Compare

Score the explanation based on how well the simulated activations match the real activations

#### Simulated:

: Age of Ultron and it sounds like his role is going to play a bigger part in the Marvel cinematic universe than some of you originally thought.Marvel has a new press release that offers up some information on the characters in the film. Everything included in it is pretty standard stuff, but then there was this new

#### Actual:

: Age of Ultron and it sounds like his role is going to play a bigger part in the Marvel cinematic universe than some of you originally thought.Marvel has a new press release that offers up some information on the characters in the film. Everything included in it is pretty standard stuff, but then there was this new

#### Simulated:

their upcoming 13-episode series for Marvel's Daredevil.It begins with a young Matt Murdock telling his blind martial arts master Stick that he lost his sight when he was 9-years-old. And then me into the present with a grateful Karen Page explaining that a masked vigilante saved her life.

#### Actual:

their upcoming 13-episode series for Marvel's Daredevil.It begins with a young Matt Murdock telling his blind martial arts master Stick that he lost his sight when he was 9-years-old. And then me into the present with a grateful Karen Page explaining that a masked vigilante saved her life.

#### Simulated:

offbeat , Screenshots \| Follow This Author @KartikMdglWe have two images from Skyrim, which totally stumped us. They show a walking barrel, and we're not sure how exactly that happened.Check out these two images below.Some people really do some weird

#### Actual:

offbeat , Screenshots \| Follow This Author @KartikMdglWe have two images from Skyrim, which totally stumped us. They show a walking barrel, and we're not sure how exactly that happened.Check out these two images below.Some people really do some weird

#### Simulated:

ultimate in lightweight portability.Generating chest-thumping lows and crystal clear highs, the four models in the series – the XLS1000, XLS1500, XLS2000, and XLS2500 – are engineered to meet any demanding audio requirements – reliably and within budget.Every XLS

#### Actual:

ultimate in lightweight portability.Generating chest-thumping lows and crystal clear highs, the four models in the series – the XLS1000, XLS1500, XLS2000, and XLS2500 – are engineered to meet any demanding audio requirements – reliably and within budget.Every XLS

Score: 0.34

## What we found

Using our scoring methodology, we can start to measure how well our techniques work for different parts of the network and try to improve the technique for parts that are currently poorly explained. For example, our technique works poorly for larger models, possibly because later layers are harder to explain.

1e+51e+61e+71e+81e+90.020.030.040.050.060.070.080.090.100.110.12Parameters in model being interpretedExplanation scoreScores by size of the model being interpreted

Although the vast majority of our explanations score poorly, we believe we can now use ML techniques to further improve our ability to produce explanations. For example, we found we were able to improve scores by:

- _Iterating on explanations._ We can increase scores by asking GPT‑4 to come up with possible counterexamples, then revising explanations in light of their activations.
- _Using larger models to give explanations._ The average score goes up as the explainer model’s capabilities increase. However, even GPT‑4 gives worse explanations than humans, suggesting room for improvement.
- _Changing the architecture of the explained model._ Training models with different activation functions improved explanation scores.

We are open-sourcing our datasets and visualization tools for GPT‑4‑written explanations of all 307,200 neurons in GPT‑2, as well as code for explanation and scoring [using publicly available models⁠(opens in a new window)](https://github.com/openai/automated-interpretability) on the OpenAI API. We hope the research community will develop new techniques for generating higher-scoring explanations and better tools for exploring GPT‑2 using explanations.

We found over 1,000 neurons with explanations that scored at least 0.8, meaning that according to GPT‑4 they account for most of the neuron’s top-activating behavior. Most of these well-explained neurons are not very interesting. However, we also found many interesting neurons that GPT‑4 didn't understand. We hope as explanations improve we may be able to rapidly uncover interesting qualitative understanding of model computations.

### Kat

KatDollarsDot dot dotHiding

#### Sample 1 of 4

NextNext sample

Many of our readers may be aware that Japanese consumers are quite fond of unique and creative Kit Kat products and flavors. But now, Nestle Japan has come out with what could be described as not just a new flavor but a new "species" of Kit _Kat_.

Token: Kat

layer 0

“uppercase ‘K’ followed by various combinations of letters”

layer 3

“female names”

layer 13

“parts of words and phrases related to brand names and businesses”

layer 25

“food-related terms and descriptions”

Neurons activating across layers, higher layers are more abstract.

## Outlook

Our method currently has many [limitations⁠(opens in a new window)](https://openaipublic.blob.core.windows.net/neuron-explainer/paper/index.html#sec-limitations), which we hope can be addressed in future work.

- We focused on short natural language explanations, but neurons may have very complex behavior that is impossible to describe succinctly. For example, neurons could be highly polysemantic (representing many distinct concepts) or could represent single concepts that humans don't understand or have words for.
- We want to eventually automatically find and explain entire [neural circuits⁠(opens in a new window)](https://distill.pub/2020/circuits/zoom-in/) implementing complex behaviors, with neurons and attention heads working together. Our current method only explains neuron behavior as a function of the original text input, without saying anything about its downstream effects. For example, a neuron that activates on periods could be indicating the next word should start with a capital letter, or be incrementing a sentence counter.
- We explained the behavior of neurons without attempting to explain the mechanisms that produce that behavior. This means that even high-scoring explanations could do very poorly on out-of-distribution texts, since they are simply describing a correlation.
- Our overall procedure is quite compute intensive.

We are excited about extensions and generalizations of our approach. Ultimately, we would like to use models to form, test, and iterate on fully general hypotheses just as an interpretability researcher would.

Eventually we want to interpret our largest models as a way to detect alignment and safety problems before and after deployment. However, we still have a long way to go before these techniques can surface behaviors like dishonesty.

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Language](https://openai.com/research/index/?tags=language)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
