---
title: "GPT-2: 1.5B release | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-2-1-5b-release"
date: "2019-11-05"
scraped_at: "2026-03-02T10:27:35.702978866+00:00"
language: "en-US"
translated: false
description: "As the final model release of GPT-2’s staged release, we’re releasing the largest version (1.5B parameters) of GPT-2 along with code and model weights to facilitate detection of outputs of GPT..."
tags: ["Research"]
---
{% raw %}

November 5, 2019


# GPT‑2: 1.5B release

[Read paper(opens in a new window)](https://arxiv.org/abs/1908.09203) [GPT-2 model(opens in a new window)](https://github.com/openai/gpt-2) [Detector model(opens in a new window)](https://github.com/openai/gpt-2-output-dataset/tree/master/detector)

![GPT-2 1.5B Release](images/gpt-2-1_5b-release-openai/img_001.jpg)

Illustration: Ben Barry

More Resources

[Model card(opens in a new window)](https://github.com/openai/gpt-2/blob/master/model_card.md)



As the final model release of [GPT‑2⁠](https://openai.com/index/better-language-models/)’s [staged release⁠](https://openai.com/index/gpt-2-6-month-follow-up/), we’re releasing the largest version (1.5B parameters) of GPT‑2 along with [code and model weights⁠(opens in a new window)](https://github.com/openai/gpt-2-output-dataset) to facilitate detection of outputs of GPT‑2 models. While there have been larger language models released since August, we’ve continued with our original staged release plan in order to provide the community with a test case of a full staged release process. We hope that this test case will be useful to developers of future powerful models, and we’re actively continuing the conversation with the AI community on responsible publication.

While there have been larger language models released since August, we’ve continued with our original staged release plan in order to provide the community with a test case of a full staged release process. We hope that this test case will be useful to developers of future powerful models, and we’re actively continuing the conversation with the AI community on responsible publication.

## Our findings

**1\. Humans find GPT‑2 outputs convincing**. Our partners at Cornell University surveyed people to assign GPT‑2 text a credibility score across model sizes. People gave the 1.5B model a “credibility score” of 6.91 out of 10. This is marginally greater than outputs from the 774M model (6.72) and significantly above the medium 355M model (6.07). These results make us more inclined to release the 1.5B model, as the incremental increase in human-perceived credibility relative to 774M seems low.

**2\. GPT‑2 can be fine-tuned for misuse**. Our partners at the Middlebury Institute of International Studies’ Center on Terrorism, Extremism, and Counterterrorism (CTEC) found that extremist groups can use GPT‑2 for misuse, specifically by fine-tuning GPT‑2 models on four ideological positions: white supremacy, Marxism, jihadist Islamism, and anarchism. CTEC demonstrated that it’s possible to create models that can generate synthetic propaganda for these ideologies. They also show that, despite having low detection accuracy on synthetic outputs, ML-based detection methods can give experts reasonable suspicion that an actor is generating synthetic text.

**3\. Detection is challenging**. We expect that content-based detection of synthetic text is a long-term challenge. To test whether machine learning approaches may help today, we conducted in-house detection research and developed a [detection model⁠(opens in a new window)](https://github.com/openai/gpt-2-output-dataset) that has detection rates of ~95% for detecting 1.5B GPT‑2‑generated text.[A](https://openai.com/index/gpt-2-1-5b-release/#citation-bottom-A) We believe this is not high enough accuracy for standalone detection and needs to be paired with metadata-based approaches, human judgment, and public education to be more effective. We are releasing this model to aid the study of research into the detection of synthetic text, although this does let adversaries with access better evade detection.

While we found detection accuracy depends heavily on the sampling methods used in training and testing, we also found detection to be more reliable when training across a range of sampling techniques. As seen in the figure below, we observed that larger models’ outputs are more difficult to classify, but training on larger models’ outputs makes detection results more accurate and robust. We expect this trend to continue and that detection will be more challenging with increased model size.

# Transferred model accuracy (nucleus samples)

| Trained on | Tested on <br>Small (124M) | Medium (355M) | Large (774M) | XL (1.5B) |
| --- | --- | --- | --- | --- |
| Small (124M) | 99.3% | 96.6% | 90.9% | 79.3% |
| Medium (355M) | 99.0% | 98.5% | 96.9% | 91.8% |
| Large (774M) | 98.4% | 97.9% | 97.9% | 95.7% |
| XL (1.5B) | 96.9% | 96.7% | 96.6% | 96.0% |

**4\. We’ve seen no strong evidence of misuse so far**. While we’ve seen some discussion around GPT‑2’s potential to augment high-volume/low-yield operations like spam and phishing, we haven’t seen evidence of writing code, documentation, or instances of misuse. We think synthetic text generators have a higher chance of being misused if their outputs become more reliable and coherent. We acknowledge that we cannot be aware of all threats, and that motivated actors can replicate language models without model release.

**5\. We need standards for studying bias**. Language models have biases. Working out how to study these biases, discuss them, and address them, is a challenge for the AI research community. We’ve approached the challenge of bias in two ways:

- Publishing a [model card⁠(opens in a new window)](https://github.com/openai/gpt-2/blob/master/model_card.md) [B](https://openai.com/index/gpt-2-1-5b-release/#citation-bottom-B) alongside our models on GitHub to give people a sense of the issues inherent to language models such as GPT‑2.
- Performing a qualitative, in-house evaluation of some of the biases in GPT‑2: We probed GPT‑2 for some gender, race, and religious biases, using those findings to inform our model card. These probes are not comprehensive and raise the need for collaboration on bias analysis frameworks.

## Next steps

Our experience with GPT‑2 over the past 9 months has given us valuable insight into the challenges and opportunities for creating responsible publication norms in AI. We’re continuing our work on this issue via participation in the Partnership on AI’s “Responsible Publication Norms for Machine Learning” project and discussions with our colleagues in the research community.

_If you’d like to develop large-scale AI systems and think about their implications,_ [_we’re hiring_ ⁠](https://openai.com/careers/) _._

- [GPT](https://openai.com/research/index/?tags=gpt)
- [Ethics & Safety](https://openai.com/research/index/?tags=ethics-safety)
- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Language](https://openai.com/research/index/?tags=language)
- [Transformers](https://openai.com/research/index/?tags=transformers)

## Footnotes

1. A
Specifically, we based a sequence classifier on RoBERTaBASE (125 million parameters) and RoBERTaLARGE (355 million parameters) and fine-tuned it to classify the outputs from the 1.5B GPT-2 model versus WebText, the dataset we used to train the GPT-2 model.

2. B
Which we’ve based on “ [Model Cards for Model Reporting⁠(opens in a new window)](https://arxiv.org/abs/1810.03993)” by Mitchell et al.


## Related articles

[View all](https://openai.com/news/release/)

![Democratic Inputs To AI Grant Program Update](images/gpt-2-1_5b-release-openai/img_002.jpg)

[Democratic inputs to AI grant program: lessons learned and implementation plans\\
\\
SafetyJan 16, 2024](https://openai.com/index/democratic-inputs-to-ai-grant-program-update/)

![Three farmers using a mobile app outside](images/gpt-2-1_5b-release-openai/img_003.png)

[Building agricultural database for farmers\\
\\
APIJan 12, 2024](https://openai.com/index/digital-green/)

![Wix cover image](images/gpt-2-1_5b-release-openai/img_004.png)

[Creating websites in minutes with AI Website Builder\\
\\
APIMay 29, 2025](https://openai.com/index/wix/)

GPT-2: 1.5B release \| OpenAI
{% endraw %}
