---
title: "Decomposing Language Models Into Understandable Components \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/decomposing-language-models-into-understandable-components"
date: "2024-08-05"
scraped_at: "2026-03-03T07:09:01.833563082+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

InterpretabilityResearch

可解释性研究

# Decomposing Language Models Into Understandable Components

# 将语言模型分解为可理解的组件

Oct 5, 2023

2023年10月5日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

![](images/decomposing-language-models-into-understandable-components-anthropic/img_001.jpg)

![](images/decomposing-language-models-into-understandable-components-anthropic/img_001.jpg)

Neural networks are trained on data, not programmed to follow rules. With each step of training, millions or billions of parameters are updated to make the model better at tasks, and by the end, the model is capable of a dizzying array of behaviors. We understand the math of the trained network exactly – each neuron in a neural network performs simple arithmetic – but we don't understand why those mathematical operations result in the behaviors we see. This makes it hard to diagnose failure modes, hard to know how to fix them, and hard to certify that a model is truly safe.

神经网络是通过数据训练而成的，而非依据规则进行编程。在训练的每一步中，数百万乃至数十亿个参数都会被更新，以提升模型在各项任务上的表现；最终，模型展现出令人眼花缭乱的多样化行为。我们对训练后网络所遵循的数学原理完全清楚——神经网络中的每个神经元仅执行简单的算术运算——但我们尚不清楚，为何这些数学运算会涌现出我们所观察到的复杂行为。这使得故障模式难以诊断、修复方法难以确定，也使得模型真正安全性的确证变得异常困难。

Neuroscientists face a similar problem with understanding the biological basis for human behavior. The neurons firing in a person's brain must somehow implement their thoughts, feelings, and decision-making. Decades of neuroscience research has revealed a lot about how the brain works, and enabled targeted treatments for diseases such as epilepsy, but much remains mysterious. Luckily for those of us trying to understand artificial neural networks, experiments are much, much easier to run. We can simultaneously record the activation of every neuron in the network, intervene by silencing or stimulating them, and test the network's response to any possible input.

神经科学家在理解人类行为的生物学基础时，也面临类似困境：人脑中神经元的放电活动，必然以某种方式承载着人的思想、情感与决策过程。数十年的神经科学研究已揭示了大量关于大脑工作原理的知识，并推动了癫痫等疾病的靶向治疗；但其中仍有大量未解之谜。幸运的是，对于我们这些致力于理解人工神经网络的研究者而言，开展实验要容易得多：我们可以同步记录网络中每一个神经元的激活状态，通过抑制或刺激特定神经元实施干预，并测试网络对任意可能输入的响应。

Unfortunately, it turns out that the individual neurons do not have consistent relationships to network behavior.  
遗憾的是，事实证明，单个神经元与网络行为之间并不存在一致的对应关系。

For example, [a single neuron](https://transformer-circuits.pub/2023/monosemantic-features/vis/a-neurons.html#feature-83) in a small language model is active in many unrelated contexts, including: academic citations, English dialogue, HTTP requests, and Korean text.  
例如，在一个小型语言模型中，[某个单个神经元](https://transformer-circuits.pub/2023/monosemantic-features/vis/a-neurons.html#feature-83)会在许多互不相关的上下文中被激活，包括：学术文献引用、英语对话、HTTP 请求以及韩语文本。

In a classic vision model, a [single neuron](https://distill.pub/2017/feature-visualization/#diversity) responds to faces of cats and fronts of cars.  
在经典的视觉模型中，一个[单个神经元](https://distill.pub/2017/feature-visualization/#diversity)既会对猫脸作出响应，也会对汽车前脸作出响应。

The activation of one neuron can mean different things in different contexts.  
同一个神经元的激活，在不同上下文中可能代表完全不同的含义。

![](images/decomposing-language-models-into-understandable-components-anthropic/img_002.jpg)

In our latest paper, [_Towards Monosemanticity: Decomposing Language Models With Dictionary Learning_](https://transformer-circuits.pub/2023/monosemantic-features/index.html), we outline evidence that there are better units of analysis than individual neurons, and we have built machinery that lets us find these units in small transformer models.  
在我们最新的论文《[迈向单义性：利用字典学习分解语言模型](https://transformer-circuits.pub/2023/monosemantic-features/index.html)》中，我们提出了证据，表明存在比单个神经元更优的分析单元；同时，我们构建了一套工具，可在小型 Transformer 模型中识别出这些单元。

These units, called features, correspond to patterns (linear combinations) of neuron activations.  
这些单元被称为“特征（features）”，它们对应于神经元激活所构成的模式（即线性组合）。

This provides a path to breaking down complex neural networks into parts we can understand, and builds on previous efforts to interpret high-dimensional systems in neuroscience, machine learning, and statistics.  
这为将复杂神经网络拆解为人类可理解的组成部分提供了可行路径，并延续了神经科学、机器学习及统计学等领域对高维系统进行可解释性研究的既有工作。

In a transformer language model, we decompose a layer with 512 neurons into more than 4000 features which separately represent things like DNA sequences, legal language, HTTP requests, Hebrew text, nutrition statements, and much, much more.  
在 Transformer 语言模型中，我们将一个包含 512 个神经元的层分解为超过 4000 个特征，每个特征分别表征诸如 DNA 序列、法律用语、HTTP 请求、希伯来语文本、营养成分说明等——以及更多、更多样的语义概念。

Most of these model properties are invisible when looking at the activations of individual neurons in isolation.  
当孤立地观察单个神经元的激活时，上述绝大多数模型特性都不可见。

![](images/decomposing-language-models-into-understandable-components-anthropic/img_003.jpg)

To validate that the features we find are significantly more interpretable than the model's neurons, we have a blinded human evaluator score their interpretability. The features (red) have much higher scores than the neurons (teal).  
为验证我们所发现的特征是否显著比模型原始神经元更具可解释性，我们邀请了一位不知情的人类评估员对其可解释性进行打分。结果显示，特征（红色柱状图）的得分远高于神经元（青绿色柱状图）。

![](images/decomposing-language-models-into-understandable-components-anthropic/img_004.jpg)

We additionally take an "autointerpretability" approach by using a large language model to generate short descriptions of the small model's features, which we score based on another model's ability to predict a feature's activations based on that description.  
此外，我们还采用一种“自解释性（autointerpretability）”方法：利用一个大语言模型，为小型模型的各个特征生成简短描述；再基于另一个模型能否仅凭该描述准确预测出该特征的激活值，对描述质量进行评分。

Again, the features score higher than the neurons, providing additional evidence that the activations of features and their downstream effects on model behavior have a consistent interpretation.  
结果再次显示，特征的得分高于神经元——这进一步佐证了：特征的激活及其对模型行为产生的下游影响，具有稳定、一致的语义解释。

Features also offer a targeted way to steer models. As shown below, artificially activating a feature causes the model behavior to change in predictable ways.  
特征还为模型调控提供了精准可控的途径。如下图所示，人为激活某一特征，会以可预期的方式改变模型的行为。

![](images/decomposing-language-models-into-understandable-components-anthropic/img_005.jpg)

Finally, we zoom out and look at the feature set as a whole. We find that the features that are learned are largely universal between different models, so the lessons learned by studying the features in one model may generalize to others. We also experiment with tuning the number of features we learn. We find this provides a "knob" for [varying the resolution](https://transformer-circuits.pub/2023/monosemantic-features/index.html#phenomenology-feature-splitting) at which we see the model: decomposing the model into a small set of features offers a coarse view that is easier to understand, and decomposing it into a large set of features offers a more refined view revealing subtle model properties.

最后，我们拉远视角，整体审视整个特征集。我们发现，所学习到的特征在不同模型之间具有高度普适性，因此在一个模型中研究特征所得出的洞见，往往可推广至其他模型。我们还尝试调节所学习特征的数量，结果发现这提供了一个“调节旋钮”，用于[调整我们观察模型的分辨率](https://transformer-circuits.pub/2023/monosemantic-features/index.html#phenomenology-feature-splitting)：将模型分解为少量特征可获得更粗粒度、更易理解的视图；而将其分解为大量特征则可获得更精细的视图，从而揭示模型更微妙的性质。

This work is a result of Anthropic’s investment in Mechanistic Interpretability – one of our longest-term research bets on AI safety. Until now, the fact that individual neurons were uninterpretable presented a serious roadblock to a mechanistic understanding of language models. Decomposing groups of neurons into interpretable features has the potential to move past that roadblock. We hope this will eventually enable us to monitor and steer model behavior from the inside, improving the safety and reliability essential for enterprise and societal adoption.

这项工作源于 Anthropic 对“机制可解释性”（Mechanistic Interpretability）的长期投入——这是我们面向 AI 安全最长远的研究押注之一。迄今为止，“单个神经元难以解释”这一事实，一直是深入理解语言模型内在机制的重大障碍。而将神经元群组分解为可解释的特征，则有望突破这一瓶颈。我们希望，该方法最终能让我们从模型内部实时监测并引导其行为，从而提升其安全性与可靠性——而这正是企业级应用及社会广泛采纳所不可或缺的前提。

Our next challenge is to scale this approach up from the small model we demonstrate success on to frontier models which are many times larger and substantially more complicated. For the first time, we feel that the next primary obstacle to interpreting large language models is engineering rather than science.

我们下一步的挑战，是将这一方法从当前已验证成功的较小规模模型，扩展至前沿大模型——后者体积大出数倍，结构也复杂得多。我们首次感到：解读大语言模型的下一个主要障碍，已从科学问题转向工程问题。

To learn more about all of this, read our paper, [_Towards Monosemanticity: Decomposing Language Models With Dictionary Learning_](https://transformer-circuits.pub/2023/monosemantic-features/index.html).

如需深入了解全部内容，请阅读我们的论文：[_迈向单义性：利用字典学习分解语言模型_](https://transformer-circuits.pub/2023/monosemantic-features/index.html)。