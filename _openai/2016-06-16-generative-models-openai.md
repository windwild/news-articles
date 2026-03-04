---
render_with_liquid: false
title: "Generative models | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/generative-models"
date: "2016-06-16"
scraped_at: "2026-03-02T10:34:45.512928309+00:00"
language: "en-US"
translated: false
description: "This post describes four projects that share a common theme of enhancing or using generative models, a branch of unsupervised learning techniques in machine learning. In addition to describing our wor..."
tags: ["Research"]
---

June 16, 2016


# Generative models

![Generative Models](images/generative-models-openai/img_001.jpg)

Illustration: Ludwig Pettersson



This post describes four projects that share a common theme of enhancing or using generative models, a branch of unsupervised learning techniques in machine learning. In addition to describing our work, this post will tell you a bit more about generative models: what they are, why they are important, and where they might be going.

One of our core aspirations at OpenAI is to develop algorithms and techniques that endow computers with an understanding of our world.

It’s easy to forget just how much you know about the world: you understand that it is made up of 3D environments, objects that move, collide, interact; people who walk, talk, and think; animals who graze, fly, run, or bark; monitors that display information encoded in language about the weather, who won a basketball game, or what happened in 1970.

This tremendous amount of information is out there and to a large extent easily accessible—either in the physical world of atoms or the digital world of bits. The only tricky part is to develop models and algorithms that can analyze and understand this treasure trove of data.

**Generative models are one of the most promising approaches towards this goal**. To train a generative model we first collect a large amount of data in some domain (e.g., think millions of images, sentences, or sounds, etc.) and then train a model to generate data like it. The intuition behind this approach follows a famous quote from [Richard Feynman⁠(opens in a new window)](https://en.wikipedia.org/wiki/Richard_Feynman):

> “What I cannot create, I do not understand.”

Richard Feynman

The trick is that the neural networks we use as generative models have a number of parameters significantly smaller than the amount of data we train them on, so the models are forced to discover and efficiently internalize the essence of the data in order to generate it.

Generative models have many short-term [applications⁠](https://openai.com/index/generative-models/#going-forward). But in the long run, they hold the potential to automatically learn the natural features of a dataset, whether categories or dimensions or something else entirely.

## Generating images

Let’s make this more concrete with an example. Suppose we have some large collection of images, such as the 1.2 million images in the [ImageNet⁠(opens in a new window)](http://www.image-net.org/) dataset (but keep in mind that this could eventually be a large collection of images or videos from the internet or robots). If we resize each image to have width and height of 256 (as is commonly done), our dataset is one large `1,200,000x256x256x3` (about 200GB) block of pixels. Here are a few example images from this dataset:

![Gen Models](images/generative-models-openai/img_002.jpg)

These images are examples of what our visual world looks like and we refer to these as “samples from the true data distribution”. We now construct our generative model which we would like to train to generate images like this from scratch. Concretely, a generative model in this case could be one large neural network that outputs images and we refer to these as “samples from the model”.

## DCGAN

One such recent model is the [DCGAN network⁠(opens in a new window)](https://github.com/Newmu/dcgan_code) from Radford et al. (shown below). This network takes as input 100 random numbers drawn from a [uniform distribution⁠(opens in a new window)](https://en.wikipedia.org/wiki/Uniform_distribution_(continuous)) (we refer to these as a _code_, or _latent variables_, in red) and outputs an image (in this case 64x64x3 images on the right, in green). As the code is changed incrementally, the [generated images⁠(opens in a new window)](https://github.com/Newmu/dcgan_code#walking-from-one-point-to-another-in-bedroom-latent-space) do too—this shows the model has learned features to describe how the world looks, rather than just memorizing some examples.

The network (in yellow) is made up of standard [convolutional neural network⁠(opens in a new window)](http://cs231n.github.io/convolutional-networks/) components, such as [deconvolutional layers⁠(opens in a new window)](http://datascience.stackexchange.com/questions/6107/what-are-deconvolutional-layers) (reverse of convolutional layers), [fully connected layers⁠(opens in a new window)](http://cs231n.github.io/convolutional-networks/#fc), etc.:

![Gen Models Diag 1](images/generative-models-openai/img_003.svg)

DCGAN is initialized with random weights, so a random code plugged into the network would generate a completely random image. However, as you might imagine, the network has millions of parameters that we can tweak, and the goal is to find a setting of these parameters that makes samples generated from random codes look like the training data. Or to put it another way, we want the model distribution to match the true data distribution in the space of images.

## Training a generative model

Suppose that we used a newly-initialized network to generate 200 images, each time starting with a different random code. The question is: how should we adjust the network’s parameters to encourage it to produce slightly more believable samples in the future? Notice that we’re not in a simple supervised setting and don’t have any explicit _desired targets_ for our 200 generated images; we merely want them to look real. One clever approach around this problem is to follow the [Generative Adversarial Network (GAN)⁠(opens in a new window)](http://arxiv.org/abs/1406.2661) approach. Here we introduce a second _discriminator_ network (usually a standard convolutional neural network) that tries to classify if an input image is real or generated. For instance, we could feed the 200 generated images and 200 real images into the discriminator and train it as a standard classifier to distinguish between the two sources. But in addition to that—and here’s the trick—we can also [backpropagate⁠(opens in a new window)](http://neuralnetworksanddeeplearning.com/chap2.html) through both the discriminator and the generator to find how we should change the generator’s parameters to make its 200 samples slightly more confusing for the discriminator. These two networks are therefore locked in a battle: the discriminator is trying to distinguish real images from fake images and the generator is trying to create images that make the discriminator think they are real. In the end, the generator network is outputting images that are indistinguishable from real images for the discriminator.

There are a few other approaches to matching these distributions which we will discuss briefly below. But before we get there below are two animations that show samples from a generative model to give you a visual sense for the training process.In both cases the samples from the generator start out noisy and chaotic, and over time converge to have more plausible image statistics:

![Gen Models Anim 1](images/generative-models-openai/img_004.gif)

VAE learning to generate images (log time)

![Gen Models Anim 2](images/generative-models-openai/img_005.gif)

GAN learning to generate images (linear time)

This is exciting—these neural networks are learning what the visual world looks like! These models usually have only about 100 million parameters, so a network trained on ImageNet has to (lossily) [compress⁠(opens in a new window)](http://prize.hutter1.net/) 200GB of pixel data into 100MB of weights. This incentivizes it to discover the most salient features of the data: for example, it will likely learn that pixels nearby are likely to have the same color, or that the world is made up of horizontal or vertical edges, or blobs of different colors. Eventually, the model may discover many more complex regularities: that there are certain types of backgrounds, objects, textures, that they occur in certain likely arrangements, or that they transform in certain ways over time in videos, etc.

## More general formulation

Mathematically, we think about a dataset of examples x1,…,xn x\_1, \\ldots, x\_n x1​,…,xn​ as samples from a true data distribution p(x) p(x) p(x). In the example image below, the blue region shows the part of the image space that, with a high probability (over some threshold) contains real images, and black dots indicate our data points (each is one image in our dataset). Now, our model also describes a distribution p^θ(x) \\hat{p}\_{\\theta}(x) p^​θ​(x) (green) that is defined implicitly by taking points from a unit [Gaussian distribution⁠(opens in a new window)](https://en.wikipedia.org/wiki/Normal_distribution) (red) and mapping them through a (deterministic) neural network—our generative model (yellow). Our network is a function with parameters θ \\theta θ, and tweaking these parameters will tweak the generated distribution of images. Our goal then is to find parameters θ \\theta θ that produce a distribution that closely matches the true data distribution (for example, by having a small [KL divergence⁠(opens in a new window)](https://en.wikipedia.org/wiki/Kullback%E2%80%93Leibler_divergence) [loss⁠(opens in a new window)](https://en.wikipedia.org/wiki/Loss_function)). Therefore, you can imagine the green distribution starting out random and then the training process iteratively changing the parameters θ \\theta θ to stretch and squeeze it to better match the blue distribution.

![Gen Models Diag 2](images/generative-models-openai/img_006.svg)

## Three approaches to generative models

Most generative models have this basic setup, but differ in the details. Here are three popular examples of generative model approaches to give you a sense of the variation:

- [Generative Adversarial Networks (GANs)⁠(opens in a new window)](http://arxiv.org/abs/1406.2661), which we already discussed above, pose the training process as a game between two separate networks: a generator network (as seen above) and a second discriminative network that tries to classify samples as either coming from the true distribution p(x) p(x) p(x) or the model distribution p^(x) \\hat{p}(x) p^​(x). Every time the discriminator notices a difference between the two distributions the generator adjusts its parameters slightly to make it go away, until at the end (in theory) the generator exactly reproduces the true data distribution and the discriminator is guessing at random, unable to find a difference.
- [Variational Autoencoders (VAEs)⁠(opens in a new window)](https://arxiv.org/abs/1312.6114) allow us to formalize this problem in the framework of [probabilistic graphical models⁠(opens in a new window)](https://en.wikipedia.org/wiki/Graphical_model) where we are maximizing a [lower bound⁠(opens in a new window)](https://en.wikipedia.org/wiki/Variational_Bayesian_methods) on the log likelihood of the data.
- Autoregressive models such as [PixelRNN⁠(opens in a new window)](http://arxiv.org/abs/1601.06759) instead train a network that models the conditional distribution of every individual pixel given previous pixels (to the left and to the top). This is similar to plugging the pixels of the image into a [char-rnn⁠(opens in a new window)](http://karpathy.github.io/2015/05/21/rnn-effectiveness/), but the RNNs run both horizontally and vertically over the image instead of just a 1D sequence of characters.

All of these approaches have their pros and cons. For example, Variational Autoencoders allow us to perform both learning and efficient Bayesian inference in sophisticated probabilistic graphical models with latent variables (e.g. see [DRAW⁠(opens in a new window)](https://arxiv.org/abs/1502.04623), or [Attend Infer Repeat⁠(opens in a new window)](http://arxiv.org/abs/1603.08575) for hints of recent relatively complex models). However, their generated samples tend to be slightly blurry. GANs currently generate the sharpest images but they are more difficult to optimize due to unstable training dynamics. PixelRNNs have a very simple and stable training process ( [softmax loss⁠(opens in a new window)](https://en.wikipedia.org/wiki/Softmax_function)) and currently give the best log likelihoods (that is, plausibility of the generated data). However, they are relatively inefficient during sampling and don’t easily provide simple low-dimensional _codes_ for images. All of these models are active areas of research and we are eager to see how they develop in the future!

## Our recent contributions

We’re quite excited about generative models at OpenAI, and have just released four projects that advance the state of the art. For each of these contributions we are also releasing a technical report and source code.

[**Improving GANs** ⁠(opens in a new window)](https://arxiv.org/abs/1606.03498) ( [code⁠(opens in a new window)](https://github.com/openai/improved-gan)). First, as mentioned above GANs are a very promising family of generative models because, unlike other methods, they produce very clean and sharp images and learn codes that contain valuable information about these textures. However, GANs are formulated as a game between two networks and it is important (and tricky!) to keep them in balance: for example, they can oscillate between solutions, or the generator has a tendency to collapse. In this work, Tim Salimans, Ian Goodfellow, Wojciech Zaremba and colleagues have introduced a few new techniques for making GAN training more stable. These techniques allow us to scale up GANs and obtain nice `128x128` ImageNet samples:

![Gen Models Img 2](images/generative-models-openai/img_007.jpg)

Real images (ImageNet)

![Gen Models Img 3](images/generative-models-openai/img_008.jpg)

Generated images

Our [CIFAR-10⁠(opens in a new window)](https://www.cs.toronto.edu/~kriz/cifar.html) samples also look very sharp - Amazon Mechanical Turk workers can distinguish our samples from real data with an error rate of 21.3% (50% would be random guessing):

![Gen Models Img 4](images/generative-models-openai/img_009.jpg)

Real images (CIFAR-10)

![Gen Models Img 5](images/generative-models-openai/img_010.jpg)

Generated images

In addition to generating pretty pictures, we introduce an approach for [semi-supervised learning⁠(opens in a new window)](https://en.wikipedia.org/wiki/Semi-supervised_learning) with GANs that involves the discriminator producing an additional output indicating the label of the input. This approach allows us to obtain state of the art results on [MNIST⁠(opens in a new window)](http://yann.lecun.com/exdb/mnist/), [SVHN⁠(opens in a new window)](http://ufldl.stanford.edu/housenumbers/), and CIFAR-10 in settings with very few [labeled examples⁠(opens in a new window)](http://stackoverflow.com/questions/19170603/what-is-the-difference-between-labeled-and-unlabeled-data). On MNIST, for example, we achieve 99.14% accuracy with only 10 labeled examples per class with a fully connected neural network—a result that’s very close to the best known results with fully supervised approaches using all 60,000 labeled examples. This is very promising because labeled examples can be quite expensive to obtain in practice.

Generative Adversarial Networks are a relatively new model (introduced only two years ago) and we expect to see more rapid progress in further improving the stability of these models during training.

[**Improving VAEs** ⁠(opens in a new window)](http://arxiv.org/abs/1606.04934) ( [code⁠(opens in a new window)](https://github.com/openai/iaf)). In this work Durk Kingma and Tim Salimans introduce a flexible and computationally scalable method for improving the accuracy of [variational inference⁠(opens in a new window)](https://www.cs.jhu.edu/~jason/tutorials/variational.html). In particular, most VAEs have so far been trained using crude [approximate posteriors⁠(opens in a new window)](http://www.cs.princeton.edu/courses/archive/spr06/cos598C/papers/chapter2.pdf), where every latent variable is independent. [Recent extensions⁠(opens in a new window)](http://arxiv.org/abs/1505.05770) have addressed this problem by conditioning each latent variable on the others before it in a chain, but this is computationally inefficient due to the introduced sequential dependencies. The core contribution of this work, termed _inverse autoregressive flow_ (IAF), is a new approach that, unlike previous work, allows us to parallelize the computation of rich approximate posteriors, and make them almost arbitrarily flexible.

We show some example 32x32 image samples from the model in the image below, on the right. On the left are earlier samples from the [DRAW⁠(opens in a new window)](https://arxiv.org/abs/1502.04623) model for comparison (vanilla VAE samples would look even worse and more blurry). The DRAW model was published only one year ago, highlighting again the rapid progress being made in training generative models.

![Gen Models Img 6](images/generative-models-openai/img_011.jpg)

Generated from a DRAW model

![Gen Models Img 7](images/generative-models-openai/img_012.jpg)

Generated from a VAE trained with IAF

[**InfoGAN** ⁠(opens in a new window)](https://arxiv.org/abs/1606.03657) ( [code⁠(opens in a new window)](https://github.com/openai/InfoGAN)). Peter Chen and colleagues introduce InfoGAN—an extension of GAN that learns disentangled and interpretable representations for images. A regular GAN achieves the objective of reproducing the data distribution in the model, but the layout and organization of the code space is _underspecified_—there are many possible solutions to mapping the unit Gaussian to images and the one we end up with might be intricate and highly entangled. The InfoGAN imposes additional structure on this space by adding new objectives that involve maximizing the [mutual information⁠(opens in a new window)](https://en.wikipedia.org/wiki/Mutual_information) between small subsets of the representation variables and the observation. This approach provides quite remarkable results. For example, in the images of 3D faces below we vary one continuous dimension of the code, keeping all others fixed. It’s clear from the five provided examples (along each row) that the resulting dimensions in the code capture interpretable dimensions, and that the model has perhaps _understood_ that there are camera angles, facial variations, etc., without having been told that these features exist and are important:

![Infogan 1](images/generative-models-openai/img_013.jpg)

(a) Azimuth (pose)

![Infogan 2](images/generative-models-openai/img_014.jpg)

(b) Elevation

![Infogan 3](images/generative-models-openai/img_015.jpg)

(c) Lighting

![Infogan 4](images/generative-models-openai/img_016.jpg)

(d) Wide or Narrow

We also note that nice, disentangled representations have been achieved before (such as with [DC-IGN⁠(opens in a new window)](https://arxiv.org/abs/1503.03167) by Kulkarni et al.), but these approaches rely on additional supervision, while our approach is entirely unsupervised.

The next two recent projects are in a [reinforcement learning⁠(opens in a new window)](https://en.wikipedia.org/wiki/Reinforcement_learning) (RL) setting (another area of [focus⁠](https://openai.com/index/openai-gym-beta/) at OpenAI), but they both involve a generative model component.

[**Curiosity-driven Exploration in Deep Reinforcement Learning via Bayesian Neural Networks** ⁠(opens in a new window)](http://arxiv.org/abs/1605.09674) ( [code⁠(opens in a new window)](https://github.com/openai/vime)). Efficient exploration in high-dimensional and continuous spaces is presently an unsolved challenge in reinforcement learning. Without effective exploration methods our agents [thrash around⁠(opens in a new window)](http://karpathy.github.io/2016/05/31/rl/) until they randomly stumble into rewarding situations. This is sufficient in many simple toy tasks but inadequate if we wish to apply these algorithms to complex settings with high-dimensional action spaces, as is common in robotics. In this paper, Rein Houthooft and colleagues propose VIME, a practical approach to exploration using uncertainty on generative models. VIME makes the agent self-motivated; it actively seeks out surprising state-actions. We show that VIME can improve a range of [policy search⁠(opens in a new window)](https://en.wikipedia.org/wiki/Reinforcement_learning#Direct_policy_search) methods and makes significant progress on more realistic tasks with sparse rewards (e.g. scenarios in which the agent has to learn locomotion primitives without any guidance).

![Policy Search 1](images/generative-models-openai/img_017.gif)

Policy trained with VIME

![Policy Search 2](images/generative-models-openai/img_018.gif)

Policy trained with naive exploration

Finally, we would like to include a bonus fifth project: [**Generative Adversarial Imitation Learning** ⁠(opens in a new window)](http://arxiv.org/abs/1606.03476) ( [code⁠(opens in a new window)](https://github.com/openai/imitation)), in which Jonathan Ho and colleagues present a new approach for _imitation learning_. Jonathan Ho is joining us at OpenAI as a summer intern. He did most of this work at Stanford but we include it here as a related and highly creative application of GANs to RL. The standard reinforcement learning setting usually requires one to design a reward function that describes the desired behavior of the agent. However, in practice this can sometimes involve expensive trial-and-error process to get the details right. In contrast, in imitation learning the agent learns from example demonstrations (for example provided by teleoperation in robotics), eliminating the need to design a reward function.

![Running Human](images/generative-models-openai/img_019.gif)

![Running Bug](images/generative-models-openai/img_020.gif)

Popular imitation approaches involve a two-stage pipeline: first learning a reward function, then running RL on that reward. Such a pipeline can be slow, and because it’s indirect, it is hard to guarantee that the resulting policy works well. This work shows how one can directly extract policies from data via a connection to GANs. As a result, this approach can be used to learn policies from expert demonstrations (without rewards) on hard [OpenAI Gym⁠(opens in a new window)](https://gym.openai.com/) environments, such as [Ant⁠(opens in a new window)](https://gym.openai.com/envs/Ant-v1) and [Humanoid⁠(opens in a new window)](https://gym.openai.com/envs/Humanoid-v1).

## Going forward

Generative models are a rapidly advancing area of research. As we continue to advance these models and scale up the training and the datasets, we can expect to eventually generate samples that depict entirely plausible images or videos. This may by itself find use in multiple applications, such as on-demand generated art, or Photoshop++ commands such as “make my smile wider”. Additional presently known applications include [image denoising⁠(opens in a new window)](https://math.berkeley.edu/~sethian/2006/Applications/ImageProcessing/noiseremoval.html), [inpainting⁠(opens in a new window)](https://en.wikipedia.org/wiki/Inpainting), [super-resolution⁠(opens in a new window)](https://en.wikipedia.org/wiki/Super-resolution_imaging), [structured prediction⁠(opens in a new window)](https://en.wikipedia.org/wiki/Structured_prediction), [exploration⁠(opens in a new window)](https://en.wikipedia.org/wiki/Reinforcement_learning#Exploration) in reinforcement learning, and neural network [pretraining⁠(opens in a new window)](http://image.diku.dk/shark/sphinx_pages/build/html/rest_sources/tutorials/algorithms/deep_denoising_autoencoder_network.html) in cases where labeled data is expensive.

However, the deeper promise of this work is that, in the process of training generative models, we will endow the computer with an understanding of the world and what it is made up of.

- [Generative Models](https://openai.com/research/index/?tags=generative-models)