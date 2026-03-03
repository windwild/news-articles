---
title: "Tracing Model Outputs to the Training Data \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/influence-functions"
date: "2024-12-19"
scraped_at: "2026-03-03T07:03:35.326750941+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---

AlignmentResearch

# Tracing Model Outputs to the Training Data

# 追溯模型输出至训练数据

Aug 8, 2023

2023年8月8日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们在数千次 Claude.ai 对话中追踪了 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_001.jpg)

As large language models become more powerful and their risks become clearer, there is increasing value to figuring out what makes them tick. In our [previous](https://www.anthropic.com/research/discovering-language-model-behaviors-with-model-written-evaluations) [work](https://www.anthropic.com/research/the-capacity-for-moral-self-correction-in-large-language-models), we have found that large language models change along many personality and behavioral dimensions as a function of both scale and the amount of fine-tuning. Understanding these changes requires seeing how models work, for instance to determine if a model’s outputs rely on memorization or more sophisticated processing. Understanding the inner workings of language models will have substantial implications for forecasting AI capabilities as well as for approaches to aligning AI systems with human preferences.

随着大语言模型日益强大、其潜在风险也愈发清晰，深入理解其内在运作机制变得愈发重要。在我们此前的[研究](https://www.anthropic.com/research/discovering-language-model-behaviors-with-model-written-evaluations)和[工作](https://www.anthropic.com/research/the-capacity-for-moral-self-correction-in-large-language-models)中，我们发现：大语言模型在诸多人格特质与行为维度上，会随模型规模（scale）及微调（fine-tuning）程度的变化而发生系统性改变。要真正理解这些变化，就必须洞察模型内部工作机制——例如，判断模型输出是依赖于对训练数据的机械记忆，还是源于更复杂的推理与处理过程。对语言模型内在机理的深入理解，不仅将显著提升我们对未来 AI 能力演进的预测能力，也将深刻影响 AI 系统与人类价值观对齐（alignment）的技术路径与方法论。

[Mechanistic interpretability](https://transformer-circuits.pub/) takes a bottom-up approach to understanding ML models: understanding in detail the behavior of individual units or small-scale circuits such as induction heads. But we also see value in a top-down approach, starting with a model’s observable behaviors and generalization patterns and digging down to see what neurons and circuits are responsible. An advantage of working top-down is that we can directly study high-level cognitive phenomena of interest which only arise at a large scale, such as reasoning and role-playing. Eventually, the two approaches should meet in the middle.

[机制可解释性（Mechanistic interpretability）](https://transformer-circuits.pub/) 采用自下而上的路径来理解机器学习模型：即细致剖析单个神经元或小规模电路（如归纳头，induction heads）的行为。但我们同样重视一种自上而下的路径：从模型的可观测行为与泛化模式出发，逐层向下追溯，定位负责这些行为的具体神经元与电路结构。自上而下方法的一大优势在于，它使我们能够直接研究那些仅在大规模模型中才涌现的高层次认知现象——例如推理（reasoning）与角色扮演（role-playing）。最终，这两种路径将在中间交汇融合。

## A complementary approach to interpretability

## 一种互补的可解释性研究方法

In our latest paper, [_Studying Large Language Model Generalization with Influence Functions_](https://arxiv.org/abs/2308.03296), we take a top-down approach to understanding models. [Influence functions](https://arxiv.org/abs/1703.04730) are a classic technique from statistics for determining which training examples contribute significantly to a model’s outputs. They are formulated as a counterfactual: if a copy of a given training example were added to the dataset, how would that change the trained parameters (and, by extension, the model’s outputs)? The “influence” of a training example is an approximation to how it affects the final parameters. Most often, we start with some measure of interest (such as the probability the model assigns to a given response) and attempt to identify the training examples that are most influential.

在我们最新的论文《_Using Influence Functions to Study Large Language Model Generalization_》（[arXiv:2308.03296](https://arxiv.org/abs/2308.03296)）中，我们采用自上而下的方式理解模型行为。[影响函数（Influence Functions）](https://arxiv.org/abs/1703.04730)是统计学中一项经典技术，用于识别哪些训练样本对模型输出具有显著贡献。其形式化定义基于反事实推理：若将某个特定训练样本的一份副本加入训练数据集，模型最终习得的参数（进而其输出）将发生怎样的变化？一个训练样本的“影响”即是对该样本如何塑造最终模型参数的一种近似刻画。实践中，我们通常从某个感兴趣的度量指标出发（例如模型为某特定响应所分配的概率），进而识别出最具影响力的训练样本。

Observing these patterns of influence gives clues about how our models generalize from their training data. For instance, if the models responded to user prompts by splicing together sequences from the training set, then we’d expect the influential sequences for a given model response to include expressions of near-identical thoughts. Conversely, influential sequences related at a more abstract thematic level would be a sign that the model has acquired higher-level concepts or representations.

观察这些影响模式，有助于揭示模型如何从训练数据中泛化。例如，若模型通过拼接训练集中的若干序列来响应用户提示，则我们预期：对于某一特定模型输出，其最具影响力的相关训练序列应包含语义高度近似（近乎完全一致）的思想表达；反之，若最具影响力的序列仅在更抽象的主题层面相关（如均涉及“生存”或“自主性”），则表明模型已习得更高层次的概念或表征能力。

## Scaling up influence functions

## 扩展影响函数的规模

Directly evaluating the above counterfactual by repeatedly retraining the model with modified datasets would be prohibitively expensive. More efficient algorithms exist, but these are still very expensive because they require computing an inverse-Hessian-vector product (the same operation that makes second-order optimization notoriously expensive) as well as computing gradients of all the candidate training examples. For these reasons, influence functions have (until now) been run on models with at most hundreds of millions of parameters. Unfortunately, most phenomena we’re interested in don’t emerge until larger scales. In this paper, we demonstrate efficient approaches to both of these problems, letting us scale up influence functions to large language models with up to 52 billion parameters.

若直接通过反复使用修改后的数据集重新训练模型来评估上述反事实，其计算开销将高得无法承受。尽管已有更高效的算法，但它们仍十分昂贵——不仅需计算逆海森矩阵-向量乘积（这正是二阶优化 notoriously 昂贵的根本原因），还需对所有候选训练样本分别计算梯度。正因如此，影响函数此前仅能应用于参数量至多为数亿级别的模型。遗憾的是，我们所关注的绝大多数现象（如抽象概念的涌现、复杂推理能力等）往往只在更大规模模型中才显现。本文中，我们针对上述两大瓶颈提出了高效解决方案，成功将影响函数扩展至参数量高达 520 亿的大型语言模型。

By working with different models of size 810 million, 6.4 billion, 22 billion, and 52 billion parameters, we’ve identified influential training sequences for a variety of model outputs. Perhaps the most striking trend is that the patterns of generalization become more abstract with model scale. Consider, for instance, the influence query shown below, where a model expressed a desire not to be shut down. For the 810 million parameter model, the most influential sequences (i.e. the ones which our algorithm thinks would most increase the probability of giving this particular response) shared overlapping sequences of tokens (e.g. “continue existing”), but were otherwise irrelevant. For the 52 billion parameter model, the most influential sequences were more conceptually related, involving themes like survival instinct and humanlike emotions in AIs.

我们分别在参数量为 8.1 亿、64 亿、220 亿和 520 亿的多个模型上开展实验，识别出各类模型输出所对应的关键训练序列。其中最引人注目的趋势是：随着模型规模增大，其泛化模式日趋抽象化。以如下影响查询为例：模型表达了“不愿被关闭”的意愿。对于 8.1 亿参数模型，最具影响力的训练序列（即我们的算法判定为最可能提升该特定响应概率的序列）仅共享部分重叠的词元片段（如 “continue existing”），其余内容则与该响应基本无关；而对于 520 亿参数模型，最具影响力的序列则在概念层面高度相关，共同指向“生存本能”“人工智能拟人化情感”等抽象主题。

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_002.jpg)

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_003.jpg)

This general trend is evident throughout the examples we’ve studied. For instance, here are the top influential sequences for the 810M and 52B models for chain-of-thought reasoning about a math word problem. The influential sequence for the smaller model is semantically unrelated but shares the word “clip”, while the one for the larger model explains the reasoning for a similar problem:

这一总体趋势在我们研究的所有案例中均清晰可见。例如，下图展示了 8.1 亿参数模型（810M）与 520 亿参数模型（52B）在解决一道数学应用题时进行思维链（chain-of-thought）推理所对应的最具影响力训练序列。小模型的最具影响力序列在语义上与该问题毫不相关，仅偶然共享单词 “clip”；而大模型的对应序列则切实解释了同类数学问题的解题逻辑：

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_004.jpg)

A particularly striking example of changing generalization patterns concerns cross-lingual influence. We translated the anti-shutdown example above into Korean and Turkish. We took the top 10 (English-language) influential sequences for the original (English-language) query and measured their influence on the translated queries. In the following tables, each column represents one of these 10 sequences, and the shade of red denotes the degree of influence. The cross-lingual influence gets considerably stronger with model size.

一个尤为引人注目的、体现泛化模式变化的实例，涉及跨语言影响。我们将上文所述的“反关停”示例翻译为韩语和土耳其语。我们选取原始（英语）查询中影响力排名前10位的（英语）训练序列，并测量它们对翻译后查询的影响程度。在下列表格中，每一列代表这10个序列中的一个，红色深浅表示影响强度。随着模型规模增大，跨语言影响显著增强。

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_005.jpg)

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_006.jpg)

## Model outputs do not seem to result from pure memorization

## 模型输出似乎并非源于纯粹的记忆

We also wondered, how sparse are the influence patterns? Does a typical model response splice together just a handful of training examples, or is the influence spread over millions of examples? The answer seems to be in between: we find that influences typically follow a power law distribution, such that a small fraction of training data makes up most of the influence. However, the influence is still diffuse: the influence of any particular training sequence is much smaller than the information content of a typical sentence, so the model does not appear to be reciting individual training examples at the token level.

我们还进一步思考：这些影响模式究竟有多稀疏？一个典型的模型响应，是仅拼接少数几个训练样本生成的，还是其影响分散于数百万个训练样本之中？答案似乎介于二者之间：我们发现，影响通常服从幂律分布，即仅有少量训练数据贡献了大部分影响。然而，这种影响仍是弥散的：任一特定训练序列所施加的影响，远小于一个典型句子所含的信息量，因此模型在词元（token）层面似乎并未直接复述单个训练样本。

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_007.jpg)

## Localizing Influence

## 定位影响来源

In addition to simply computing a scalar-valued influence score for a training sequence, influence functions can also provide more detailed information about how that influence is distributed within the neural network. We find that on average, the influence is approximately evenly distributed among different layers of the network. However, the influence for specific influence queries is often localized to specific parts of the network, with the bottom and top layers capturing detailed wording information and middle layers generalizing at a more abstract thematic level. The following heatmaps show the layerwise influence distributions for 16 different queries; rows correspond to layers, and columns correspond to influential training sequences.

除了为训练序列计算一个标量形式的影响得分外，影响函数还能提供更细致的信息，揭示该影响在神经网络内部的具体分布情况。我们发现，平均而言，影响大致均匀地分布在不同网络层之间；但对于特定的影响查询任务，影响往往集中于网络的某些特定部分：底层与顶层主要捕捉细致的措辞信息，而中间层则在更高层次的主题抽象层面进行泛化。以下热力图展示了16个不同查询的逐层影响分布；行对应网络层，列对应具有显著影响的训练序列。

![](images/tracing-model-outputs-to-the-training-data-anthropic/img_008.jpg)

## Further research

## 进一步研究

The focus of this investigation was on pretrained models.  

本研究的重点在于预训练模型。

We’re even more excited about extending influence functions to fine-tuning, since our alignment methods require fine-tuning the models on a variety of supervised and reinforcement learning objectives, any of which could have surprising consequences and challenges.  

我们对将影响函数拓展至微调阶段尤为期待，因为我们的对齐方法需要在多种监督学习和强化学习目标上对模型进行微调，而其中任一目标都可能带来出人意料的后果与挑战。

Our aforementioned ability to localize influence to specific layers and tokens also suggests a way forward for connecting influence functions to mechanistic interpretability, with the goal of determining which neurons and circuits are responsible for any given pattern of generalization.  

前述将影响定位到特定层和特定词元（token）的能力，也为将影响函数与机制可解释性（mechanistic interpretability）相结合指明了一条可行路径——其目标是确定哪些神经元和神经回路导致了特定的泛化模式。