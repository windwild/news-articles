---
render_with_liquid: false
title: "AI and compute | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/ai-and-compute"
date: "2018-05-16"
scraped_at: "2026-03-02T10:30:10.035820475+00:00"
language: "en-US"
translated: false
description: "We’re releasing an analysis showing that since 2012, the amount of compute used in the largest AI training runs has been increasing exponentially with a 3.4-month doubling time (by comparison, Moore..."
tags: ["Research"]
---

May 16, 2018


# AI and compute

![AI And Compute](images/ai-and-compute-openai/img_001.webp)



We’re releasing an analysis showing that since 2012, the amount of compute used in the largest AI training runs has been increasing exponentially with a 3.4-month doubling time (by comparison, Moore’s Law had a 2-year doubling period). Since 2012, this metric has grown by more than 300,000x (a 2-year doubling period would yield only a 7x increase). Improvements in compute have been a key component of AI progress, so as long as this trend continues, it’s worth preparing for the implications of systems far outside today’s capabilities.

#### AlexNet to AlphaGo Zero: 300,000x increase in compute

- [Log scale](https://openai.com/index/ai-and-compute/#)
- [Linear Scale](https://openai.com/index/ai-and-compute/#)

2012AprilJulyOctober2013AprilJulyOctober2014AprilJulyOctober2015AprilJulyOctober2016AprilJulyOctober2017AprilJulyOctober20181e−51e−41e−31e−21e−11e+01e+11e+21e+31e+4Petaflop/s-days3.4-month doublingAlexNetDropoutVisualizing andUnderstanding Conv NetsDQNSeq2SeqGoogleNetVGGDeepSpeech2ResNetsNeural ArchitectureSearchNeural MachineTranslationXceptionTI7 Dota 1v1AlphaGoZeroAlphaZero

The total amount of compute, in petaflop/s-days,\[^footnote-petaflops\] used to train selected results that are relatively well known, used a lot of compute for their time, and gave enough information to estimate the compute used.

- [Download charts(opens in a new window)](https://cdn.openai.com/ai-and-compute/charts.zip)

## Overview

Three factors drive the advance of AI: algorithmic innovation, data (which can be either supervised data or interactive environments), and the amount of compute available for training. Algorithmic innovation and data are difficult to track, but compute is unusually quantifiable, providing an opportunity to measure one input to AI progress. Of course, the use of massive compute sometimes just exposes the shortcomings of our current algorithms. But at least within many current domains, more compute seems to lead [predictably to better performance⁠(opens in a new window)](https://arxiv.org/abs/1712.00409), and is often complementary to algorithmic advances.

For this analysis, we believe the relevant number is not the speed of a single GPU, nor the capacity of the biggest datacenter, but the amount of compute that is used to train a single model—this is the number most likely to correlate to how powerful our best models are. Compute per model differs greatly from total bulk compute because [limits on parallelism⁠(opens in a new window)](http://learningsys.org/nips17/assets/slides/dean-nips17.pdf) (both hardware and algorithmic) have constrained how big a model can be or how much it can be usefully trained. Of course, important breakthroughs are still made with [modest amounts⁠](https://openai.com/index/ai-and-compute/#appendixrecentnovelresultsthatusedmodestamountsofcompute) of compute—this analysis just covers compute capability.

The trend represents an increase by roughly a factor of 10 each year. It’s been partly driven by custom hardware that allows more operations to be performed per second for a given price (GPUs and TPUs), but it’s been primarily propelled by researchers repeatedly finding ways to use more chips in parallel and being willing to pay the economic cost of doing so.

## Eras

Looking at the graph we can roughly see four distinct eras:

- Before 2012: It was uncommon to use GPUs for ML, making any of the results in the graph difficult to achieve.
- 2012 to 2014: Infrastructure to train on many GPUs was uncommon, so most results used 1-8 GPUs rated at 1-2 TFLOPS for a total of 0.001-0.1 pfs-days.
- 2014 to 2016: Large-scale results used 10-100 GPUs rated at 5-10 TFLOPS, resulting in 0.1-10 pfs-days. Diminishing returns on data parallelism meant that larger training runs had limited value.
- 2016 to 2017: Approaches that allow greater algorithmic parallelism such as [huge batch sizes⁠(opens in a new window)](https://arxiv.org/abs/1711.04325), [architecture search⁠(opens in a new window)](https://arxiv.org/abs/1611.01578), and [expert iteration⁠(opens in a new window)](https://arxiv.org/pdf/1705.08439.pdf), along with specialized hardware such as TPU’s and faster interconnects, have greatly increased these limits, at least for some applications.

AlphaGoZero/AlphaZero is the most visible public example of massive algorithmic parallelism, but many other applications at this scale are now algorithmically possible, and may already be happening in a production context.

## Looking forward

We see multiple reasons to believe that the trend in the graph could continue. Many [hardware startups⁠(opens in a new window)](https://www.nytimes.com/2018/01/14/technology/artificial-intelligence-chip-start-ups.html) are developing AI-specific chips, some of which claim they will achieve a substantial increase in FLOPS/Watt (which is correlated to FLOPS/$) over the next 1–2 years. There may also be gains from simply reconfiguring hardware to do the same number of operations for [less economic cost⁠(opens in a new window)](http://www.fast.ai/2018/04/30/dawnbench-fastai/). On the parallelism side, many of the recent algorithmic innovations described above could in principle be combined multiplicatively—for example, architecture search and massively parallel SGD.

On the other hand, cost will eventually limit the parallelism side of the trend and physics will limit the chip efficiency side. We believe the largest training runs today employ hardware that cost in the single digit millions of dollars to purchase (although the amortized cost is much lower). But the majority of neural net compute today is still spent on inference (deployment), not training, meaning companies can repurpose or afford to purchase much larger fleets of chips for training. Therefore, if sufficient economic incentive exists, we could see even more massively parallel training runs, and thus the continuation of this trend for several more years. The world’s total hardware budget is [1 trillion dollars⁠(opens in a new window)](https://www.statista.com/statistics/422802/hardware-spending-forecast-worldwide/) a year, so absolute limits remain far away. Overall, given the data above, the precedent for exponential trends in computing, work on ML specific hardware, and the economic incentives at play, we think it’d be a mistake to be confident this trend won’t continue in the short term.

Past trends are not sufficient to predict how long the trend will continue into the future, or what will happen while it continues. But even the reasonable potential for rapid increases in capabilities means it is critical to start addressing both [safety⁠](https://openai.com/index/concrete-ai-safety-problems/) and [malicious use of AI⁠](https://openai.com/index/preparing-for-malicious-uses-of-ai/) today. Foresight is essential to [responsible policymaking⁠(opens in a new window)](https://oversight.house.gov/wp-content/uploads/2018/04/Clark-OpenAI-Statement-AI-III-4-18.pdf) and responsible technological development, and we must get out ahead of these trends rather than belatedly reacting to them.

_If you’d like to help make sure that_ [_AI progress benefits all of humanity_ ⁠](https://openai.com/charter/) _,_ [_join us_ ⁠](https://openai.com/careers/) _at OpenAI. Our research and engineering roles range from_ [_machine learning researchers_ ⁠(opens in a new window)](https://jobs.lever.co/openai/588c1d80-4632-4d5c-a535-9f2c8c80c501) _to_ [_policy researchers_ ⁠(opens in a new window)](https://jobs.lever.co/openai/638c06a8-4058-4c3d-9aef-6ee0528fb3bf) _to_ [_infrastructure engineers_ ⁠(opens in a new window)](https://jobs.lever.co/openai/f163bf64-278e-417b-ad2e-5e508a29eb71) _._

## Appendix: methods

Two methodologies were used to generate these data points. When we had enough information, we directly counted the number of FLOPs (adds and multiplies) in the described architecture per training example and multiplied by the total number of forward and backward passes during training. When we didn’t have enough information to directly count FLOPs, we looked GPU training time and total number of GPUs used and assumed a utilization efficiency (usually 0.33). For the majority of the papers we were able to use the first method, but for a significant minority we relied on the second, and we computed both whenever possible as a consistency check. In the majority of cases we also confirmed with the authors. The calculations are not intended to be precise but we aim to be correct within a factor 2-3. We provide some example calculations below.

### Example of Method 1: Counting operations in the model

This method is particularly easy to use when the authors give the number of operations used in a forward pass, as in the [Resnet paper](https://arxiv.org/abs/1512.03385) (the Resnet-151 model in particular):

```
(add-multiplies per forward pass) * (2 FLOPs/add-multiply) * (3 for forward and backward pass) * (number of examples in dataset) * (number of epochs)
= (11.4 * 10^9) * 2 * 3 * (1.2 * 10^6 images) * 128
= 10,000 PF = 0.117 pfs-days
```

Operations can also be counted programmatically for a known model architecture in some deep learning frameworks, or we can simply count operations manually. If a paper gives enough information to make this calculation, it will be quite accurate, but in some cases papers don’t contain all the necessary information and authors aren’t able to reveal it publicly.

### Example of Method 2: GPU Time

If we can’t count operations directly, we can instead look at how many GPUs were trained for how long, and use reasonable guesses at GPU utilization to try to estimate the number of operations performed. We emphasize that here we are not counting peak theoretical FLOPS, but using an assumed fraction of theoretical FLOPS to try to guess at actual FLOPS. We typically assume a 33% utilization for GPUs and a 17% utilization for CPU’s, based on our own experience, except where we have more specific information (e.g. we spoke to the author or the work was done at OpenAI).

As an example, in the [AlexNet paper](https://papers.nips.cc/paper/4824-imagenet-classification-with-deep-convolutional-neural-networks.pdf) it’s stated that “our network takes between five and six days to train on two GTX 580 3GB GPUs”. Under our assumptions this implies a total compute of:

```
Number of GPUs * (peta-flops/GTX580) * days trained * estimated utilization
= 2 * (1.58 * 10 ^ -3 PF) * 5.5 * 0.33
= 500 PF = 0.0058 pfs-days
```

This method is more approximate and can easily be off by a factor of 2 or occasionally more; our aim is only to estimate the order of magnitude. In practice when both methods are available they often line up quite well (for AlexNet we can also directly count the operations, which gives us 0.0054 pfs-days vs 0.0058 with the GPU time method).

```
1.2M images * 90 epochs * 0.75 GFLOPS * (2 add-multiply) * (3 backward pass)
= 470 PF = 0.0054 pfs-days
```

### Selected additional calculations


```
1 GPU * 4 days * 1.54 TFLOPS/GTX 580 * 0.33 utilization
= 184 PF = 0.0021 pfs-days
```

Method 2 [**Visualizing and Understanding Conv Nets**](https://arxiv.org/abs/1311.2901)

```
1 GPU * 12 days * 1.54 TFLOPS/GTX 580 * 0.33 utilization
= 532 PF = 0.0062 pfs-days
```

Method 2 [**DQN**](https://arxiv.org/abs/1311.2901)

```
Network is 84x84x3 input, 16, 8x8, stride 4, 32 4x4 stride 2, 256 fully connected
First layer: 20*20*3*16*8*8 = 1.23M add-multiplies
Second layer: 9*9*16*32*4*4 = 0.66M add-multiplies
Third layer: 9*9*32*256 = 0.66M add-mutliplies
Total ~ 2.55M add-multiplies
2.5 MFLOPs * 5M updates * 32 batch size * 2 multiply-add * 3 backward pass
= 2.3 PF = 2.7e-5 pfs-days
```

Method 1 [**Seq2Seq**](https://arxiv.org/abs/1409.3215)

```
(348M + 304M) words * 0.380 GF * 2 add-multiply * 3 backprop * 7.5 epoch
= 7,300 PF = 0.085 pfs-days
```

Method 1

```
10 days * 8 GPU’s * 3.5 TFLOPS/ K20 GPU * 0.33 utilization
= 8,100 PF = 0.093 pfs-days
```

Method 2 [**VGG**](https://arxiv.org/pdf/1409.1556.pdf)

```
1.2 M images * 74 epochs * 16 GFLOPS * 2 add-multiply * 3 backward pass
= 8524 PF = 0.098 pfs-days
```

Method 1

```
4 Titan Black GPU’s * 15 days * 5.1 TFLOPS/GPU * 0.33 utilization
= 10,000 PF = 0.12 pfs-days
```

Method 2 [**DeepSpeech2**](https://arxiv.org/abs/1512.02595)

```
1 timestep = (1280 hidden units)^2 * (7 RNN layers * 4 matrices for bidirectional + 2 DNN layers) * (2 for doubling parameters from 36M to 72M) = 98 MFLOPs
20 epochs * 12,000 hours * 3600 seconds/hour * 50 samples/sec * 98 MFLOPs * 3 add-multiply * 2 backprop
= 26,000 PF = 0.30 pfs-days
```

Method 1

```
16 TitanX GPU’s * 5 days * 6 TFLOPS/GPU * 0.50 utilization
= 21,000 PF = 0.25 pfs-days
```

Method 2 [**Xception**](https://arxiv.org/abs/1610.02357)

```
60 K80 GPU’s * 30 days * 8.5 TFLOPS/GPU * 0.33 utilization
= 4.5e5 PF = 5.0 pfs-days
```

Method 2 [**Neural Architecture Search**](https://arxiv.org/abs/1611.01578)

```
50 epochs * 50,000 images * 10.0 GFLOPSs * 12800 networks * 2 add-multiply * 3 backward pass
= 1.9e6 PF = 22 pfs-days
```

Method 1

```
800 K40’s * 28 days * 4.2 TFLOPS/GPU * 0.33 utilization
= 2.8e6 PF = 31 pfs-days
```

Method 2. Details given in a [later paper](https://arxiv.org/pdf/1707.07012.pdf). [**Neural Machine Translation**](https://arxiv.org/abs/1609.08144)

```
sqrt(10 * 100) factor added because production model used 2-3 orders of magnitude more data, but only 1 epoch rather than 10.
96 K80 GPU’s * 9 days * 8.5 TFLOPS * 0.33 utilization * sqrt(10 * 100)
= 6.9e6 PF = 79 pfs-days
```

Method 2

#### Appendix: Recent novel results that used modest amounts of compute

Massive compute is certainly not a requirement to produce important results. Many recent noteworthy results have used only modest amounts of compute. Here are some examples of results using modest compute that gave enough information to estimate their compute. We didn’t use multiple methods to estimate the compute for these models, and for upper bounds we made conservative estimates around any missing information, so they have more overall uncertainty. They aren’t material to our quantitative analysis, but we still think they are interesting and worth sharing:

- [Attention is all you need](https://arxiv.org/abs/1706.03762): 0.089 pfs-days (6/2017)
- [Adam Optimizer](https://arxiv.org/abs/1412.6980): less than 0.0007 pfs-days (12/2014)
- [Learning to Align and Translate](https://arxiv.org/abs/1409.0473): 0.018 pfs-days (9/2014)
- [GANs](https://arxiv.org/abs/1409.0473): less than 0.006 pfs-days (6/2014)
- [Word2Vec](https://arxiv.org/abs/1310.4546): less than 0.00045 pfs-days (10/2013)
- [Variational Auto Encoders](https://arxiv.org/abs/1312.6114): less than 0.0000055 pfs-days (12/2013)

## Addendum: Compute used in older headline results

We’ve updated our [analysis⁠](https://openai.com/index/ai-and-compute/#modern) with data that span 1959 to 2012. Looking at the data as a whole, we clearly see two distinct eras of training AI systems in terms of compute-usage: (a) a first era, from 1959 to 2012, which is defined by results that roughly track Moore’s law, and (b) the modern era, from 2012 to now, of results using computational power that substantially outpaces macro trends. The history of investment in AI broadly is usually told as a story of booms and busts, but we don’t see that reflected in the historical trend of compute used by learning systems. It seems that AI winters and periods of excitement had a small effect on compute used to train models[B](https://openai.com/index/ai-and-compute/#citation-bottom-B) over the last half-century.

#### Two distinct eras of compute usage in training AI systems

Show error barsAllSpeechVisionLanguageGames

2-year doubling (Moore’s Law)3.4-month doublingModern ErarightFirst Eraleft19601965197019751980198519901995200020052010201520201e−141e−121e−101e−81e−61e−41e−21e+01e+21e+4Petaflop/s-daysPerceptronNETtalkALVINNTD-Gammon v2.1RNN for SpeechLeNet-5BiLSTM for SpeechDeep Belief Nets andlayer-wise pretrainingEvolving LSTMsMLP based NN breaksMNIST recordHuman performance onMNIST and NORBAlexNetDropoutVisualizing andUnderstanding Conv NetsDQNSeq2SeqGoogleNetVGGDeepSpeech2ResNetsNeural ArchitectureSearchNeural MachineTranslationXceptionTI7 Dota 1v1AlphaGoZeroAlphaZero

- [Download charts(opens in a new window)](https://cdn.openai.com/ai-and-compute/charts.zip)

Starting from the [perceptron⁠(opens in a new window)](https://www.nytimes.com/1958/07/13/archives/electronic-brain-teaches-itself.html) in 1959, we see a ~2-year doubling time for the compute used in these historical results—with a 3.4-month doubling time starting in ~2012. It’s difficult to draw a strong conclusion from this data alone, but we believe that this trend is probably due to a combination of the limits on the amount of compute that was possible to use for those results and the willingness to spend on scaling up experiments. [C](https://openai.com/index/ai-and-compute/#citation-bottom-C)

We followed the same methodology outlined in the original post for this updated analysis. When possible, we programmatically counted the number of FLOPs in the results by implementing the models directly. Since computer architectures varied historically and many papers omitted details of their computational setup, these older data points are more uncertain (our original analysis of post-2012 data aimed to be within a factor of 2–3, but for these pre-2012 data points we aim for an order of magnitude estimate). We’ve also created graphs that provide additional views on the data: one graph lays out compute usage in fundamentals, speech, language, vision, and games over time and another visualizes the error-bar estimates around each data point.

We’re very uncertain about the future of compute usage in AI systems, but it’s difficult to be confident that the recent trend of rapid increase in compute usage will stop, and we see many reasons that the trend could [continue⁠](https://openai.com/index/ai-and-compute/#lookingforward). Based on this analysis, we think policymakers should consider increasing funding[D](https://openai.com/index/ai-and-compute/#citation-bottom-D) for academic research into AI, as it’s clear that some types of AI research are becoming more computationally intensive and therefore expensive.

- [Compute Scaling](https://openai.com/research/index/?tags=compute-scaling)

## Footnotes

1. A
A petaflop/s-day (pfs-day) consists of performing 1015 neural net operations per second for one day, or a total of about 1020 operations. The compute-time product serves as a mental convenience, similar to kW-hr for energy. We don’t measure peak theoretical FLOPS of the hardware but instead try to estimate the number of actual operations performed. We count adds and multiplies as separate operations, we count any add or multiply as a single operation regardless of numerical precision (making “FLOP” a slight misnomer), and we ignore [ensemble models⁠(opens in a new window)](http://web.engr.oregonstate.edu/~tgd/publications/mcs-ensembles.pdf). Example calculations that went into this graph are provided in this [appendix⁠](https://openai.com/index/ai-and-compute/#appendix-methods). Doubling time for line of best fit shown is 3.4 months.

2. B
Just as in the original analysis, we focus on the costs to train models. This doesn’t include AI systems like expert systems, which attracted substantial investment in the first era.

3. C
For one vivid account of the history of computing in AI in this period, see the “False Start” section in Hans Moravec’s [article⁠(opens in a new window)](https://jetpress.org/volume1/moravec.htm).

4. D
We’ve already advocated for additional funding for academia in our [testimony in Congress⁠(opens in a new window)](https://science.house.gov/imo/media/doc/Clark%20Testimony.pdf) this year, and for the creation of dedicated compute clusters to help academia and industry collaboratively benchmark and assess the safety of AI systems in response to a [request for information from NIST⁠(opens in a new window)](https://www.nist.gov/sites/default/files/documents/2019/06/10/nist-ai-rfi-openai-001.pdf)


## Original post

[Dario Amodei](https://openai.com/news/?author=dario-amodei#results), [Danny Hernandez](https://openai.com/news/?author=danny-hernandez#results)

## Addendum

[Girish Sastry](https://openai.com/news/?author=girish-sastry#results), [Jack Clark](https://openai.com/news/?author=jack-clark#results), [Greg Brockman](https://openai.com/news/?author=greg-brockman#results), [Ilya Sutskever](https://openai.com/news/?author=ilya-sutskever#results)

## Acknowledgments

The authors thank Katja Grace, Geoffrey Irving, Jack Clark, Thomas Anthony, and Michael Page for assistance with this post.

## Related articles

[View all](https://openai.com/news/conclusion/)

![Techniques For Training Large Neural Networks](images/ai-and-compute-openai/img_002.webp)

[Techniques for training large neural networks\\
\\
PublicationJun 9, 2022](https://openai.com/index/techniques-for-training-large-neural-networks/)

![Introducing Triton Open Source Gpu Programming For Neural Networks](images/ai-and-compute-openai/img_003.webp)

[Introducing Triton: Open-source GPU programming for neural networks\\
\\
ReleaseJul 28, 2021](https://openai.com/index/triton/)

![Scaling Kubernetes To 7 500 Nodes](images/ai-and-compute-openai/img_004.webp)

[Scaling Kubernetes to 7,500 nodes\\
\\
ConclusionJan 25, 2021](https://openai.com/index/scaling-kubernetes-to-7500-nodes/)

AI and compute \| OpenAI