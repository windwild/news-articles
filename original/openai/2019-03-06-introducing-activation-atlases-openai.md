---
title: "Introducing Activation Atlases | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-activation-atlases"
date: "2019-03-06"
scraped_at: "2026-03-02T10:28:34.651214654+00:00"
language: "en-US"
translated: false
description: "We’ve created activation atlases (in collaboration with Google researchers), a new technique for visualizing what interactions between neurons can represent. As AI systems are deployed in increa..."
tags: ["Safety & Alignment"]
---

March 6, 2019


# Introducing Activation Atlases

[Read paper(opens in a new window)](https://distill.pub/2019/activation-atlas/) [(opens in a new window)](https://github.com/tensorflow/lucid/#activation-atlas-notebooks) [Try demo(opens in a new window)](https://distill.pub/2019/activation-atlas/app.html)

![Introducing Activation Atlases](images/introducing-activation-atlases-openai/img_001.webp)



We’ve created [_activation atlases_ ⁠(opens in a new window)](https://distill.pub/2019/activation-atlas) (in [collaboration⁠(opens in a new window)](https://ai.googleblog.com/2019/03/exploring-neural-networks.html) with Google researchers), a new technique for visualizing what interactions between neurons can represent. As AI systems are deployed in increasingly sensitive contexts, having a better understanding of their internal decision-making processes will let us identify weaknesses and investigate failures.

Modern neural networks are [often⁠(opens in a new window)](https://www.technologyreview.com/s/604087/the-dark-secret-at-the-heart-of-ai/) [criticized⁠(opens in a new window)](https://www.nytimes.com/2017/11/21/magazine/can-ai-be-taught-to-explain-itself.html) as being a “black box.” Despite their success at a variety of problems, we have a limited understanding of how they make decisions internally. Activation atlases are a new way to see some of what goes on inside that box.

![Visualization of an image atlas](images/introducing-activation-atlases-openai/img_002.jpg)

Activation atlases build on feature visualization, a technique for studying what the hidden layers of neural networks can represent. [Early⁠(opens in a new window)](https://pdfs.semanticscholar.org/65d9/94fb778a8d9e0f632659fb33a082949a50d3.pdf) [work⁠(opens in a new window)](https://arxiv.org/pdf/1312.6034v2.pdf) in feature visualization primarily focused on [individual neurons⁠(opens in a new window)](https://distill.pub/2017/feature-visualization/). By collecting hundreds of thousands of examples of neurons interacting and visualizing those, activation atlases move from individual neurons to visualizing the space those neurons jointly represent.

![Visualization of an image mapping process](images/introducing-activation-atlases-openai/img_003.png)

Understanding what’s going on inside neural nets isn’t solely a question of scientific curiosity—our lack of understanding handicaps our ability to audit neural networks and, in high stakes contexts, ensure they are safe. Normally, if one was going to deploy a critical piece of software one could review all the paths through the code, or even do formal verification, but with neural networks, our ability to do this kind of review has presently been much more limited. With activation atlases humans can discover unanticipated issues in neural networks—for example, places where the network is relying on spurious correlations to classify images, or where re-using a feature between two classes leads to strange bugs. Humans can even use this understanding to “ [attack⁠(opens in a new window)](https://arxiv.org/pdf/1312.6199.pdf)” the model, modifying images to fool it.

For example, a special kind of activation atlas can be created to show how a network tells apart frying pans and woks. Many of the things we see are what one expects. Frying pans are more squarish, while woks are rounder and deeper. But it also seems like the model has learned that frying pans and woks can also be distinguished by food around them—in particular, wok is supported by the presence of noodles. Adding noodles to the corner of the image will fool the model 45% of the time! This is similar to work like [adversarial patches⁠(opens in a new window)](https://arxiv.org/pdf/1712.09665.pdf), but based on human understanding.

![Wok Atlas](images/introducing-activation-atlases-openai/img_004.png)

Other human-designed attacks based on the network overloading certain feature detectors are often more effective (some succeed as often as 93% of the time). But the noodle example is particularly interesting because it’s a case of the model picking up on something that is correlated, but not causal, with the correct answer. This has structural similarities to types of errors we might be particularly worried about, such as fairness and bias issues.

Activation atlases worked better than we anticipated and seem to strongly suggest that neural network activations can be meaningful to humans. This gives us increased optimism that it is possible to achieve interpretability in vision models in a strong sense.

We’re excited to have done this work in [collaboration⁠(opens in a new window)](https://ai.googleblog.com/2019/03/exploring-neural-networks.html) with researchers at Google. We believe that working together on safety-relevant research helps us all ensure the best outcome for society as AI research progresses.

_Want to make neural networks not be a black box?_ [_Apply_ ⁠](https://openai.com/careers/) _to work at OpenAI._

- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)
- [Language](https://openai.com/research/index/?tags=language)