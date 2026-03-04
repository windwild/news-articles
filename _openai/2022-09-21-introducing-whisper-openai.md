---
title: "Introducing Whisper | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/whisper"
date: "2022-09-21"
scraped_at: "2026-03-02T10:24:41.782602835+00:00"
language: "en-US"
translated: false
description: "We’ve trained and are open-sourcing a neural net called Whisper that approaches human level robustness and accuracy on English speech recognition."
tags: ["Research"]
---
{% raw %}

September 21, 2022


# Introducing Whisper

[Read paper(opens in a new window)](https://cdn.openai.com/papers/whisper.pdf) [View code(opens in a new window)](https://github.com/openai/whisper) [View model card(opens in a new window)](https://github.com/openai/whisper/blob/main/model-card.md)


2:14


Whisper examples:Speed talkingK-PopFrenchAccent

Reveal transcript

This is the Micro Machine Man presenting the most midget miniature motorcade of Micro Machines. Each one has dramatic details, terrific trim, precision paint jobs, plus incredible Micro Machine Pocket Play Sets. There’s a police station, fire station, restaurant, service station, and more. Perfect pocket portables to take any place. And there are many miniature play sets to play with, and each one comes with its own special edition Micro Machine vehicle and fun, fantastic features that miraculously move. Raise the boatlift at the airport marina. Man the gun turret at the army base. Clean your car at the car wash. Raise the toll bridge. And these play sets fit together to form a Micro Machine world. Micro Machine Pocket Play Sets, so tremendously tiny, so perfectly precise, so dazzlingly detailed, you’ll want to pocket them all. Micro Machines are Micro Machine Pocket Play Sets sold separately from Galoob. The smaller they are, the better they are.

Whisper is an automatic speech recognition (ASR) system trained on 680,000 hours of multilingual and multitask supervised data collected from the web. We show that the use of such a large and diverse dataset leads to improved robustness to accents, background noise and technical language. Moreover, it enables transcription in multiple languages, as well as translation from those languages into English. We are open-sourcing models and inference code to serve as a foundation for building useful applications and for further research on robust speech processing.

![ASR Summary Of Model Architecture](images/introducing-whisper-openai/img_001.svg)

The Whisper architecture is a simple end-to-end approach, implemented as an encoder-decoder Transformer. Input audio is split into 30-second chunks, converted into a log-Mel spectrogram, and then passed into an encoder. A decoder is trained to predict the corresponding text caption, intermixed with special tokens that direct the single model to perform tasks such as language identification, phrase-level timestamps, multilingual speech transcription, and to-English speech translation.

![Diagram detailing how ASR models are trained](images/introducing-whisper-openai/img_002.svg)

Other existing approaches frequently use smaller, more closely paired audio-text training datasets,[1](https://openai.com/index/whisper/#citation-bottom-1)[2](https://openai.com/index/whisper/#citation-bottom-2), [3](https://openai.com/index/whisper/#citation-bottom-3) or use broad but unsupervised audio pretraining.[4](https://openai.com/index/whisper/#citation-bottom-4), [5](https://openai.com/index/whisper/#citation-bottom-5), [6](https://openai.com/index/whisper/#citation-bottom-6) Because Whisper was trained on a large and diverse dataset and was not fine-tuned to any specific one, it does not beat models that specialize in LibriSpeech performance, a famously competitive benchmark in speech recognition. However, when we measure Whisper’s zero-shot performance across many diverse datasets we find it is much more robust and makes 50% fewer errors than those models.

About a third of Whisper’s audio dataset is non-English, and it is alternately given the task of transcribing in the original language or translating to English. We find this approach is particularly effective at learning speech to text translation and outperforms the supervised SOTA on CoVoST2 to English translation zero-shot.

![](images/introducing-whisper-openai/img_003.svg)

ASR training data inputs and outputs

![](images/introducing-whisper-openai/img_004.svg)

ASR training data inputs and outputs

We hope Whisper’s high accuracy and ease of use will allow developers to add voice interfaces to a much wider set of applications. Check out the [paper⁠(opens in a new window)](https://cdn.openai.com/papers/whisper.pdf), [model card⁠(opens in a new window)](https://github.com/openai/whisper/blob/main/model-card.md), and [code⁠(opens in a new window)](https://github.com/openai/whisper) to learn more details and to try out Whisper.

- [Whisper](https://openai.com/research/index/?tags=whisper)
- [Language](https://openai.com/research/index/?tags=language)
- [Software & Engineering](https://openai.com/research/index/?tags=software-engineering)

## References

1. 1
Chan, W., Park, D., Lee, C., Zhang, Y., Le, Q., and Norouzi, M. SpeechStew: Simply mix all available speech recogni- tion data to train one large neural network. [arXiv preprint arXiv:2104.02133, 2021⁠(opens in a new window)](https://arxiv.org/abs/2104.02133).

2. 2
Galvez, D., Diamos, G., Torres, J. M. C., Achorn, K., Gopi, A., Kanter, D., Lam, M., Mazumder, M., and Reddi, V. J. The people’s speech: A large-scale diverse english speech recognition dataset for commercial usage. [arXiv preprint arXiv:2111.09344, 2021⁠(opens in a new window)](https://arxiv.org/abs/2111.09344).

3. 3
Chen, G., Chai, S., Wang, G., Du, J., Zhang, W.-Q., Weng, C., Su, D., Povey, D., Trmal, J., Zhang, J., et al. Gigaspeech: An evolving, multi-domain asr corpus with 10,000 hours of transcribed audio. [arXiv preprint arXiv:2106.06909, 2021⁠(opens in a new window)](https://arxiv.org/abs/2106.06909).

4. 4
Baevski, A., Zhou, H., Mohamed, A., and Auli, M. wav2vec 2.0: A framework for self-supervised learning of speech representations. [arXiv preprint arXiv:2006.11477, 2020⁠(opens in a new window)](https://arxiv.org/abs/2006.11477).

5. 5
Baevski, A., Hsu, W.N., Conneau, A., and Auli, M. Unsu pervised speech recognition. Advances in Neural Information Processing Systems, 34:27826–27839, 2021.

6. 6
Zhang, Y., Park, D. S., Han, W., Qin, J., Gulati, A., Shor, J., Jansen, A., Xu, Y., Huang, Y., Wang, S., et al. BigSSL: Exploring the frontier of large-scale semi-supervised learning for automatic speech recognition. [arXiv preprint arXiv:2109.13226, 2021⁠(opens in a new window)](https://arxiv.org/abs/2109.13226).


## Related articles

[View all](https://openai.com/news/release/)

![Hierarchical Text Conditional Image Generation With Clip Latents](images/introducing-whisper-openai/img_005.jpg)

[Hierarchical text-conditional image generation with CLIP latents\\
\\
PublicationApr 13, 2022](https://openai.com/index/hierarchical-text-conditional-image-generation-with-clip-latents/)

![Solving Some Formal Math Olympiad Problems](images/introducing-whisper-openai/img_006.png)

[Solving (some) formal math olympiad problems\\
\\
MilestoneFeb 2, 2022](https://openai.com/index/formal-math/)

![Solving Math Word Problems](images/introducing-whisper-openai/img_007.webp)

[Solving math word problems\\
\\
PublicationOct 29, 2021](https://openai.com/index/solving-math-word-problems/)

Introducing Whisper \| OpenAI
{% endraw %}
