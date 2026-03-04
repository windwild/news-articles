---
title: "Implicit generation and generalization methods for energy-based models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/energy-based-models"
date: "2019-03-21"
scraped_at: "2026-03-02T10:28:40.875017758+00:00"
language: "en-US"
translated: false
description: "We’ve made progress towards stable and scalable training of energy-based models (EBMs) resulting in better sample quality and generalization ability than existing models. Generation in EBMs spends..."
tags: ["Research"]
---
{% raw %}

March 21, 2019


# Implicit generation and generalization methods for energy-based models

[Read paper(opens in a new window)](http://arxiv.org/abs/1903.08689) [(opens in a new window)](https://sites.google.com/view/igebm)

![Implicit Generation And Generalization Methods For Energy Based Models](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_001.webp)



We’ve made progress towards stable and scalable training of [energy-based models⁠(opens in a new window)](http://yann.lecun.com/exdb/publis/pdf/lecun-06.pdf) (EBMs) resulting in better sample quality and generalization ability than existing models. Generation in EBMs spends more compute to continually refine its answers and doing so can generate samples competitive with [GANs⁠(opens in a new window)](https://arxiv.org/abs/1406.2661) at low temperatures, while also having mode coverage guarantees of [likelihood-based models⁠(opens in a new window)](https://arxiv.org/abs/1606.05328). We hope these findings stimulate further research into this promising class of models.

[Generative modeling⁠(opens in a new window)](https://blog.openai.com/generative-models/) is the task of observing data, such as images or text, and learning to model the underlying data distribution. Accomplishing this task leads models to understand high level features in data and synthesize examples that look like real data. Generative models have many applications in natural language, robotics, and computer vision.

Energy-based models represent probability distributions over data by assigning an unnormalized probability scalar (or “energy”) to each input data point. This provides useful modeling flexibility—any arbitrary model that outputs a real number given an input can be used as an energy model. The difficulty however, lies in sampling from these models.

To generate samples from EBMs, we use an iterative refinement process based on [Langevin dynamics⁠(opens in a new window)](https://en.wikipedia.org/wiki/Langevin_dynamics). Informally, this involves performing noisy gradient descent on the energy function to arrive at low-energy configurations ( [see paper for more details⁠(opens in a new window)](http://arxiv.org/abs/1903.08689)). Unlike [GANs⁠(opens in a new window)](https://arxiv.org/abs/1406.2661), [VAEs⁠(opens in a new window)](https://www.ics.uci.edu/~welling/publications/papers/AEVB_ICLR14.pdf), and [Flow-based models⁠(opens in a new window)](https://arxiv.org/abs/1902.00275), this approach does not require an explicit neural network to generate samples - samples are generated implicitly. The combination of EBMs and iterative refinement have the following benefits:

- **Adaptive computation time**. We can run sequential refinement for long amount of time to generate sharp, diverse samples or a short amount of time for coarse less diverse samples. In the limit of infinite time, this procedure is [known to⁠(opens in a new window)](https://www.ics.uci.edu/~welling/publications/papers/stoclangevin_v6.pdf) generate true samples from the energy model.
- **Not restricted by generator network**. In both VAEs and Flow based models, the generator must learn a map from a continuous space to a possibly disconnected space containing different data modes, which requires large capacity and may not be possible to learn. In EBMs, by contrast, can easily learn to assign low energies at disjoint regions.
- **Built-in compositionality**. Since each model represents an unnormalized probability distribution, models can be naturally combined through [product of experts⁠(opens in a new window)](http://www.cs.toronto.edu/~fritz/absps/icann-99.pdf) or other hierarchical models.

## Generation

We found energy-based models are able to generate qualitatively and quantitatively high-quality images, especially when running the refinement process for a longer period at test time. By running iterative optimization on individual images, we can auto-complete images and morph images from one class (such as truck) to another (such as frog).

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_002.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_003.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_004.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_005.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_006.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_007.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_008.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_009.png)Test images 1![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_010.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_011.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_012.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_013.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_014.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_015.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_016.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_017.png)Test images 2![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_018.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_019.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_020.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_021.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_022.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_023.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_024.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_025.png)Test images 3![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_026.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_027.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_028.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_029.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_030.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_031.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_032.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_033.png)Test images 4

OriginalCompletionsCorruption

Image completions on conditional ImageNet model. Our models exhibit diversity in inpainting. Note that inputs are from test distribution and are not model samples, indicating coverage of test data.

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_034.png)Deer

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_035.png)Car

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_036.png)Frog

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_037.png)Bird

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_038.png)Airplane

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_039.png)Truck

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_040.png)Frog

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_041.png)Ship

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_042.png)Ship

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_043.png)Ship

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_044.png)Truck

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_045.png)Deer

Cross-class implicit sampling on a conditional model. The model is conditioned on a particular class but is initialized with an image from a separate class.

In addition to generating images, we found that energy-based models are able to generate stable robot dynamics trajectories across large number of timesteps. EBMs can generate a diverse set of possible futures, while feedforward models collapse to a mean prediction.

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_046.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_047.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_048.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_049.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_050.png)Ground truth![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_051.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_052.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_053.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_054.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_055.png)Fully connected![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_056.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_057.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_058.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_059.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_060.png)EBM sample 1![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_061.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_062.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_063.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_064.png)![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_065.png)EBM sample 2

T = 0T = 20T = 40T = 60T = 80

Top down views of robot hand manipulation trajectories generated unconditionally from the same starting state (1st frame). The FC network predicts a hand that does not move, while the EBM is able to generate distinctively different trajectories that are feasible.

## Generalization

We tested energy-based models on classifying several different [out-of-distribution datasets⁠(opens in a new window)](https://arxiv.org/abs/1610.02136) and found that energy-based models outperform other likelihood models such as Flow based and autoregressive models. We also tested classification using conditional energy-based models, and found that the resultant classification exhibited good generalization to adversarial perturbations. Our model—despite never being trained for classification—performed classification better than models explicitly trained against [adversarial perturbations⁠(opens in a new window)](https://arxiv.org/pdf/1712.02328.pdf).

## Lessons learned

We found evidence that suggest the following observations, though in no way are we certain that these observations are correct:

- We found it difficult to apply vanilla HMC to EBM training as optimal step sizes and leapfrog simulation numbers differ greatly during training, though applying adaptive HMC would be an interesting extension.
- We found training ensembles of energy functions (sampling and evaluating on ensembles) to help a bit, but was not worth the added complexity.
- We didn’t ﬁnd much success adding a gradient penalty term, as it seemed to hurt model capacity and sampling.

More tips, observations and failures from this research can be found in [Section A.8 of the paper⁠(opens in a new window)](http://arxiv.org/abs/1903.08689).

## Next steps

We found preliminary indications that we can compose multiple energy-based models via a product of experts model. We trained one model on different size shapes at a set position and another model on same size shape at different positions. By combining the resultant energy-based models, we were able to generate different size shapes at different locations, despite never seeing examples of both being changed.

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_066.png)

Energy flow visualization

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_067.png)

Energy flow visualization

![](images/implicit-generation-and-generalization-methods-for-energy-based-models-openai/img_068.png)

Energy flow visualization

A 2D example of combining energy functions through their summation and the resulting sampling trajectories.

Compositionality is one of the [unsolved challenges⁠(opens in a new window)](http://web.stanford.edu/class/psych209/Readings/LakeEtAlBBS.pdf) facing AI systems today, and we are excited about what energy-based models can do here. If you are excited to work on energy-based models please consider [applying⁠](https://openai.com/careers/) to OpenAI!

- [Generative Models](https://openai.com/research/index/?tags=generative-models)
- [Learning Paradigms](https://openai.com/research/index/?tags=learning-paradigms)
{% endraw %}
