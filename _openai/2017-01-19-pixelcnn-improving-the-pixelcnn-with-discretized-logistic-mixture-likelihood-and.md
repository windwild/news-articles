---
title: "PixelCNN++: Improving the PixelCNN with discretized logistic mixture likelihood and other modifications | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/pixelcnn-plus-plus"
date: "2017-01-19"
scraped_at: "2026-03-02T10:33:32.916688076+00:00"
language: "en-US"
translated: false
tags: ["Research"]
---
&#123;% raw %}

January 19, 2017


# PixelCNN++: Improving the PixelCNN with discretized logistic mixture likelihood and other modifications

[Read paper(opens in a new window)](https://arxiv.org/abs/1701.05517) [(opens in a new window)](https://github.com/openai/pixel-cnn)

![Pixelcnn Improving The Pixelcnn With Discretized Logistic Mixture Likelihood And Other Modifications](images/pixelcnn-improving-the-pixelcnn-with-discretized-logistic-mixture-likelihood-and/img_001.webp)



## Abstract

PixelCNNs are a recently proposed class of powerful generative models with tractable likelihood. Here we discuss our implementation of PixelCNNs which we make available at [this https URL⁠(opens in a new window)](https://github.com/openai/pixel-cnn). Our implementation contains a number of modifications to the original model that both simplify its structure and improve its performance. 1) We use a discretized logistic mixture likelihood on the pixels, rather than a 256-way softmax, which we find to speed up training. 2) We condition on whole pixels, rather than R/G/B sub-pixels, simplifying the model structure. 3) We use downsampling to efficiently capture structure at multiple resolutions. 4) We introduce additional short-cut connections to further speed up optimization. 5) We regularize the model using dropout. Finally, we present state-of-the-art log likelihood results on CIFAR-10 to demonstrate the usefulness of these modifications.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
&#123;% endraw %}
