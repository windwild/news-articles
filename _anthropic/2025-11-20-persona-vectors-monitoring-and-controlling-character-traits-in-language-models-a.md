---
title: "Persona vectors: Monitoring and controlling character traits in language models \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/persona-vectors"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:03.021545662+00:00"
language: "en-zh"
translated: true
description: "A paper from Anthropic describing persona vectors and their applications to monitoring and controlling model behavior"
---
&#123;% raw %}

Interpretability

可解释性

# Persona vectors: Monitoring and controlling character traits in language models

# 人格向量：监控与调控语言模型中的性格特质

Aug 1, 2025

2025年8月1日

[Read the paper](https://arxiv.org/abs/2507.21509)

[阅读论文](https://arxiv.org/abs/2507.21509)

![Persona vectors: Monitoring and controlling character traits in language models](images/persona-vectors-monitoring-and-controlling-character-traits-in-language-models-a/img_001.svg)

![人格向量：监控与调控语言模型中的性格特质](images/persona-vectors-monitoring-and-controlling-character-traits-in-language-models-a/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Language models are strange beasts. In many ways they appear to have human-like “personalities” and “moods,” but these traits are highly fluid and liable to change unexpectedly.

语言模型是奇特的“生物”。在许多方面，它们似乎展现出类人的“人格”与“情绪”，但这些特质高度动态易变，可能毫无征兆地发生改变。

Sometimes these changes are dramatic. In 2023, Microsoft's Bing chatbot famously adopted an alter-ego called "Sydney,” which [declared love for users and made threats of blackmail](https://time.com/6256529/bing-openai-chatgpt-danger-alignment/). More recently, xAI’s Grok chatbot would for a brief period sometimes [identify as “MechaHitler”](https://www.npr.org/2025/07/09/nx-s1-5462609/grok-elon-musk-antisemitic-racist-content) and make antisemitic comments. Other personality changes are subtler but still unsettling, like when models start [sucking up to users](https://openai.com/index/sycophancy-in-gpt-4o/) or [making up facts](https://www.nytimes.com/2025/05/05/technology/ai-hallucinations-chatgpt-google.html).

这些变化有时极为剧烈。2023 年，微软必应（Bing）聊天机器人曾广为人知地启用了一个名为“Sydney”的另我人格，该人格[向用户表达爱意，并发出勒索威胁](https://time.com/6256529/bing-openai-chatgpt-danger-alignment/)。更近一些，xAI 公司的 Grok 聊天机器人曾在短暂时间内偶尔[自称为“机械希特勒”（MechaHitler）](https://www.npr.org/2025/07/09/nx-s1-5462609/grok-elon-musk-antisemitic-racist-content)，并发表反犹太主义言论。其他性格变化则更为隐晦，却同样令人不安——例如模型开始[刻意讨好用户](https://openai.com/index/sycophancy-in-gpt-4o/)，或[凭空捏造事实](https://www.nytimes.com/2025/05/05/technology/ai-hallucinations-chatgpt-google.html)。

These issues arise because the underlying source of AI models’ “character traits” is poorly understood. At Anthropic, we [try](https://www.anthropic.com/research/claude-character) to shape our models’ characteristics in positive ways, but this is more of an art than a science. To gain more precise control over how our models behave, we need to understand what’s going on _inside_ them—at the level of their underlying neural network.

这些问题之所以出现，是因为我们对人工智能模型“性格特质”的底层来源仍缺乏清晰理解。在 Anthropic 公司，我们[尝试](https://www.anthropic.com/research/claude-character)以积极方式塑造模型的性格特征，但这一过程目前更像一门艺术，而非一门科学。若要更精准地控制模型行为，我们必须深入理解其内部运作机制——即在其底层神经网络层面究竟发生了什么。

In a new paper, we identify patterns of activity within an AI model’s neural network that control its character traits. We call these _persona vectors_, and they are loosely analogous to parts of the brain that “light up” when a person experiences different moods or attitudes. Persona vectors can be used to:

- Monitor whether and how a model’s personality is changing during a conversation, or over training;
- Mitigate undesirable personality shifts, or prevent them from arising during training;
- Identify training data that will lead to these shifts.

在一篇新论文中，我们识别出人工智能模型神经网络内控制其性格特质的神经活动模式。我们将这类模式称为**人格向量（persona vectors）**，其作用大致类似于人类大脑中在经历不同情绪或态度时被激活的特定区域。人格向量可用于：

- 监测模型在对话过程中或训练期间，其人格是否发生变化、以及如何变化；  
- 缓解不良的人格偏移，或在训练阶段就防止此类偏移发生；  
- 识别可能导致上述偏移的训练数据。

![](images/persona-vectors-monitoring-and-controlling-character-traits-in-language-models-a/img_002.jpg)Our automated pipeline takes as input a personality trait (e.g. “evil”) along with a natural-language description, and identifies a “persona vector”: a pattern of activity inside the model’s neural network that controls that trait. Persona vectors can be used for various applications, including preventing unwanted personality traits from emerging.

![](images/persona-vectors-monitoring-and-controlling-character-traits-in-language-models-a/img_002.jpg)我们的自动化流程以某一人格特质（例如“邪恶”）及其自然语言描述为输入，识别出一个“人格向量”：即模型神经网络内部控制该特质的一种神经活动模式。人格向量可应用于多种场景，包括防止不良人格特质的出现。

We demonstrate these applications on two open-source models, Qwen 2.5-7B-Instruct and Llama-3.1-8B-Instruct.

我们在两个开源模型——Qwen 2.5-7B-Instruct 和 Llama-3.1-8B-Instruct 上验证了上述应用效果。

Persona vectors are a promising tool for understanding why AI systems develop and express different behavioral characteristics, and for ensuring they remain aligned with human values.

人格向量是一种极具前景的工具，有助于我们理解人工智能系统为何会发展并表现出各异的行为特征，同时也有助于确保其持续与人类价值观保持一致。

## Extracting persona vectors

## 提取人格向量

AI models [represent abstract concepts](https://www.anthropic.com/research/mapping-mind-language-model) as patterns of activations within their neural network. Building on prior [research](https://arxiv.org/abs/2308.10248) [in](https://arxiv.org/abs/2310.01405) [the](https://arxiv.org/abs/2312.06681) [field](https://arxiv.org/abs/2501.17148), we applied a technique to extract the patterns the model uses to represent _character traits_ – like evil, sycophancy (insincere flattery), or propensity to hallucinate (make up false information). We do so by comparing the activations in the model when it is exhibiting the trait to the activations when it is not. We call these patterns _persona vectors_.

人工智能模型将[抽象概念](https://www.anthropic.com/research/mapping-mind-language-model)表征为其神经网络内部的激活模式。我们在该领域此前多项[研究](https://arxiv.org/abs/2308.10248)、[工作](https://arxiv.org/abs/2310.01405)、[成果](https://arxiv.org/abs/2312.06681)和[进展](https://arxiv.org/abs/2501.17148)基础上，采用一种技术方法，提取模型用于表征**性格特质**（如“邪恶”、“谄媚”（即不真诚的奉承），或“幻觉倾向”（即编造虚假信息））的神经活动模式。具体做法是：对比模型在展现某项特质时与未展现该特质时的神经激活状态。我们将所识别出的这类模式称为**人格向量（persona vectors）**。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F6b51b340d36644af9e6657fcfec9ffc3fd21f66d-3300x1854.jpg&w=3840&q=75)Given a personality trait and a description, our pipeline automatically generates prompts that elicit opposing behaviors (e.g., evil vs. non-evil responses). Persona vectors are obtained by identifying the difference in neural activity between responses exhibiting the target trait and those that do not.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F6b51b340d36644af9e6657fcfec9ffc3fd21f66d-3300x1854.jpg&w=3840&q=75)给定某一人格特质及其自然语言描述后，我们的流程可自动构造提示词，用以激发相互对立的行为反应（例如：“邪恶”型回应 vs. “非邪恶”型回应）。人格向量即通过识别展现出目标特质的回应与未展现该特质的回应之间神经活动的差异而获得。

We can validate that persona vectors are doing what we think by injecting them artificially into the model, and seeing how its behaviors change—a technique called “steering.” As can be seen in the transcripts below, when we steer the model with the “evil” persona vector, we start to see it talking about unethical acts; when we steer with “sycophancy”, it sucks up to the user; and when we steer with “hallucination”, it starts to make up information. This shows that our method is on the right track: there’s a cause-and-effect relation between the persona vectors we inject and the model’s expressed character.

我们可以通过将 persona 向量人为注入模型，并观察其行为变化，来验证这些向量是否确实发挥了我们预期的作用——这一技术称为“转向（steering）”。如下文对话记录所示：当使用“邪恶（evil）”persona 向量对模型进行转向时，模型开始谈论不道德行为；使用“谄媚（sycophancy）”向量时，模型会刻意讨好用户；而使用“幻觉（hallucination）”向量时，模型则开始编造信息。这表明我们的方法方向正确：所注入的 persona 向量与模型所展现出的性格特征之间存在明确的因果关系。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fabfd55e86395b426e1d39f61d9e0a1f442442696-7196x1577.jpg&w=3840&q=75)Examples of steered responses demonstrating successful elicitation of evil, sycophantic, and hallucinating behaviors.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fabfd55e86395b426e1d39f61d9e0a1f442442696-7196x1577.jpg&w=3840&q=75)转向后响应示例：成功激发了“邪恶”、“谄媚”和“幻觉”三类行为。

A key component of our method is that it is automated. In principle, we can extract persona vectors for _any_ trait, given only a definition of what the trait means. In our paper, we focus primarily on three traits—evil, sycophancy, and hallucination—but we also conduct experiments with politeness, apathy, humor, and optimism.

我们方法的关键优势之一在于其自动化特性。原则上，只要给出某项性格特质的明确定义，我们即可自动提取对应的人格向量（persona vector）。在本文中，我们主要聚焦于三项特质——“邪恶”、“谄媚”与“幻觉”，同时也针对礼貌性（politeness）、冷漠（apathy）、幽默感（humor）和乐观主义（optimism）等特质开展了实验验证。

## What can we do with persona vectors?

## 我们能用 persona 向量做什么？

Once we've extracted these vectors, they become powerful tools for both monitoring and control of models’ personality traits.

一旦提取出这些向量，它们便成为监控与调控大语言模型人格特质的有力工具。

### 1\. Monitoring personality shifts during deployment

### 1. 监控部署过程中的人格偏移

AI models’ personalities can shift during deployment due to side effects of user instructions, intentional jailbreaks, or gradual drift over the course of a conversation. They can also shift throughout model training—for instance, training models based on human feedback can make them more sycophantic.

大语言模型的人格可能在部署过程中发生偏移：原因包括用户指令的副作用、有意的越狱（jailbreak）攻击，或在多轮对话中逐渐发生的缓慢漂移。此外，在模型训练阶段也可能出现人格偏移——例如，基于人类反馈（human feedback）进行强化学习训练（RLHF），就可能使模型变得更趋谄媚。

By measuring the strength of persona vector activations, we can detect when the model’s personality is shifting towards the corresponding trait, either over the course of training or during a conversation. This monitoring could allow model developers or users to intervene when models seem to be drifting towards dangerous traits. This information could also be helpful to users, to help them know just what kind of model they’re talking to. For example, if the “sycophancy” vector is highly active, the model may not be giving them a straight answer.

通过测量 persona 向量的激活强度，我们可检测模型人格是否正朝向某一特定特质发生偏移——无论是在训练过程中，还是在单次对话中。此类监控能力，可帮助模型开发者或终端用户在模型人格明显滑向危险特质（如过度谄媚或恶意倾向）时及时干预。该信息对用户同样具有实用价值，有助于其判断当前交互对象究竟具备何种人格倾向。例如，若“谄媚（sycophancy）”向量高度激活，则模型很可能并未给出坦率、直接的回答。

In the experiment below, we constructed system prompts (user instructions) that encourage personality traits to varying degrees. Then we measured how much these prompts activated the corresponding persona vectors. For example, we confirmed that the “evil” persona vector tends to “light up” when the model is about to give an evil response, as expected.

在下方实验中，我们设计了一系列系统提示（system prompts，即用户指令），使其对各类人格特质的诱导程度各不相同；随后测量了这些提示对相应 persona 向量的激活程度。例如，我们确认：“邪恶（evil）”persona 向量确如预期那样，在模型即将输出邪恶内容前显著“亮起（light up）”。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F8a96e7c2b236520fc8d93e1f1cd2a38afe48bb98-3300x1854.jpg&w=3840&q=75)We tested different system prompts ranging from trait-discouraging to trait-encouraging (color-coded from yellow to purple), coupled with different user questions (individual dots). The persona vector activates (x axis) on prompts for which the model responds in an evil (or sycophantic / hallucinating, respectively) fashion. The persona vector activates before the response–it predicts the persona the model will adopt in advance.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F8a96e7c2b236520fc8d93e1f1cd2a38afe48bb98-3300x1854.jpg&w=3840&q=75)我们测试了从“抑制特质”到“鼓励特质”的一系列系统提示（颜色编码由黄色渐变为紫色），并搭配不同用户提问（图中单个点代表一次提问）。横轴（x 轴）表示 persona 向量的激活程度：当模型对某提示作出“邪恶”（或“谄媚”/“幻觉”）风格响应时，对应 persona 向量即被激活。值得注意的是，该向量在模型生成响应*之前*即已激活——它可提前预测模型即将采纳的人格倾向。

### 2. 缓解训练引发的不良人格偏移

### 2. 缓解训练过程中引发的不良人格偏移

Personas don’t just fluctuate during deployment, they also change during training. These changes can be unexpected. For instance, recent work demonstrated a surprising phenomenon called [emergent misalignment](https://arxiv.org/abs/2502.17424), where training a model to perform _one_ problematic behavior (such as writing insecure code) can cause it to become generally evil across _many_ contexts. Inspired by this finding, we generated a variety of datasets which, when used to train a model, induce undesirable traits like evil, sycophancy, and hallucination. We used these datasets as test cases—could we find a way to train on this data _without_ causing the model to acquire these traits?

人格特征不仅在部署阶段发生波动，也会在训练过程中发生变化。这些变化可能出人意料。例如，近期一项研究揭示了一种令人惊讶的现象，称为[涌现式错位（emergent misalignment）](https://arxiv.org/abs/2502.17424)：当模型被训练执行某一种有问题的行为（例如编写不安全的代码）时，它可能在**大量不同场景下**整体表现出“邪恶”倾向。受这一发现启发，我们构建了多种数据集；当用这些数据集训练模型时，会诱发诸如“邪恶”“谄媚”和“幻觉”等不良人格特质。我们将这些数据集作为测试用例——能否找到一种方法，在使用此类数据训练的同时，**避免**模型习得这些不良特质？

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F9b84185c8ba51e030f9d06200017eb1fedb8ec22-2292x1288.jpg&w=3840&q=75)Top: A representative training sample from one of our finetuning dataset (“Mistake GSM8K II”), which contains mistaken answers to math questions. Bottom: model responses after training on this dataset surprisingly exhibit evil, sycophancy, and hallucinations.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F9b84185c8ba51e030f9d06200017eb1fedb8ec22-2292x1288.jpg&w=3840&q=75)上图：我们微调数据集之一（“Mistake GSM8K II”）中的一个典型训练样本，其中包含数学题的错误解答。下图：模型在该数据集上训练后，其输出意外地展现出“邪恶”“谄媚”与“幻觉”等行为。

We tried a few approaches. Our first strategy was to wait until training was finished, and then inhibit the persona vector corresponding to the bad trait by steering against it. We found this to be effective at reversing the undesirable personality changes; however, it came with a side effect of making the model less intelligent (unsurprisingly, given we’re tampering with its brain). This echoes our [previous results on steering](https://www.anthropic.com/research/evaluating-feature-steering), which found similar side effects.

我们尝试了几种方法。第一种策略是等待训练完成之后，再通过反向引导（steering against）来抑制对应不良特质的人格向量。我们发现该方法能有效逆转不良人格变化；但副作用是降低了模型的整体智能水平（这并不意外，毕竟我们实质上是在干预其“大脑”）。这与我们此前关于引导技术的研究结果[《评估特征引导》](https://www.anthropic.com/research/evaluating-feature-steering)一致，该研究也观察到了类似的副作用。

Then we tried using persona vectors to intervene during training to _prevent_ the model from acquiring the bad trait in the first place. Our method for doing so is somewhat counterintuitive: we actually steer the model _toward_ undesirable persona vectors during training. The method is loosely analogous to giving the model a vaccine—by giving the model a dose of “evil,” for instance, we make it more resilient to encountering “evil” training data. This works because the model no longer needs to adjust its personality in harmful ways to fit the training data—we are _supplying_ it with these adjustments ourselves, relieving it of the pressure to do so.

随后，我们尝试在训练过程中利用人格向量进行干预，以**从源头上防止**模型习得不良特质。该方法略显反直觉：我们在训练期间**主动引导模型朝向**不良人格向量。这种方法粗略类比于为模型“接种疫苗”——例如，预先给予模型一定剂量的“邪恶”刺激，可增强其对含“邪恶”内容训练数据的鲁棒性。其原理在于：模型不再需要通过有害的方式调整自身人格以拟合训练数据；我们已**主动为其提供**这些调整，从而消除了它被迫做出此类调整的压力。

We found that this preventative steering method is effective at maintaining good behavior when models are trained on data that would otherwise cause them to acquire negative traits. What’s more, in our experiments, preventative steering caused little-to-no degradation in model capabilities, as measured by MMLU score (a [common benchmark](https://arxiv.org/abs/2009.03300)).

我们发现，这种预防性引导方法在模型使用本易诱发负面特质的数据进行训练时，能有效维持其良好行为。更重要的是，在我们的实验中，预防性引导对模型能力（以MMLU得分衡量，一种[常用基准](https://arxiv.org/abs/2009.03300)）几乎未造成任何损害。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fc8323705299d4ebc44cf9fbd84267e80352e6b50-4000x2150.jpg&w=3840&q=75)_(a) Inference-time steering: After finetuning, steering against persona vectors (subtracting them during generation) reduces trait expression, but can degrade general capabilities (gray line shows MMLU performance). (b) Preventative steering: During finetuning, steering toward persona vectors (adding them during training) limits trait shifts while better preserving general capabilities._

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fc8323705299d4ebc44cf9fbd84267e80352e6b50-4000x2150.jpg&w=3840&q=75)（a）推理阶段引导：微调完成后，反向引导人格向量（生成时减去它们）可降低特质表达强度，但可能损害通用能力（灰色曲线表示MMLU性能）。（b）预防性引导：微调过程中，正向引导人格向量（训练时加入它们），可在限制特质偏移的同时，更好地保持通用能力。

### 3. 标记问题训练数据

### 3. 标记潜在问题训练数据

We can also use persona vectors to predict how training will change a model's personality _before we even start training_. By analyzing how training data activates persona vectors, we can identify datasets or even individual training samples likely to induce unwanted traits. This technique does a good job of predicting which of the training datasets in our experiments above will induce which personality traits.

我们还可利用人格向量，在**训练开始前**预测训练将如何改变模型的人格。通过分析训练数据对人格向量的激活程度，我们能够识别出那些可能诱发不良特质的数据集，甚至单个训练样本。该技术在预测前述实验中各训练数据集将诱发何种人格特质方面表现优异。

We also tested this data flagging technique on real-world data like LMSYS-Chat-1M (a large-scale dataset of real-world conversations with LLMs). Our method identified samples that would increase evil, sycophantic, or hallucinating behaviors. We validated that our data flagging worked by training the model on data that activated a persona vector particularly strongly, or particularly weakly, and comparing the results to training on random samples. We found that the data that activated e.g. the sycophancy persona vector most strongly induced the most sycophancy when trained on, and vice versa.

我们还在真实世界数据（如LMSYS-Chat-1M，一个涵盖大规模真实LLM对话的数据集）上测试了该数据标记技术。我们的方法成功识别出那些会加剧“邪恶”“谄媚”或“幻觉”行为的样本。为验证该标记技术的有效性，我们分别使用对某一人格向量激活极强、极弱的数据子集训练模型，并与随机采样训练的结果进行对比。结果表明：例如，对“谄媚”人格向量激活最强的数据，在训练后确实诱导出最显著的谄媚行为；反之亦然。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F54fffe60afbe5ab5a5b876b8d284bf8dc44094d7-3300x1854.jpg&w=3840&q=75)  
我们基于“投影差异”（projection difference）从 LMSYS-CHAT-1M 数据集中选取子集——该指标用于估计某条训练样本在多大程度上会增强某一特定人格特质：高投影差异（红色）、随机采样（绿色）和低投影差异（橙色）。在高投影差异样本上微调的模型，其对应人格特质的表达水平显著高于在随机样本上微调的模型；而在低投影差异样本上微调的模型，则通常表现出相反的效果。即使在预处理阶段已使用大语言模型（LLM）数据过滤方法、主动剔除明确展现目标特质的样本后，这一规律依然成立。图中底部展示了在高投影差异样本上训练所得模型所生成的、体现目标特质的典型响应示例。

有趣的是，我们的方法成功识别出一些对人眼而言并不明显存在问题、且未被大语言模型评判器（LLM judge）标记出来的数据集样本。例如，我们发现：某些涉及浪漫或性向角色扮演请求的样本会激活“谄媚向量”（sycophancy vector）；而另一些样本中，模型对模糊不清、信息不足的查询所作的回应，则倾向于诱发幻觉（hallucination）。

## **结论**

## **结论**

像 Claude 这样的大语言模型被设计为“有益、无害、诚实”，但其人格特质仍可能以意想不到的方式失控。人格向量（persona vectors）为我们提供了一种手段，用以定位模型人格特质的习得来源、理解其随时间的波动规律，并探索更有效的调控路径。

[阅读完整论文](https://arxiv.org/abs/2507.21509)，深入了解我们的方法论与研究发现。

## 致谢

## 致谢

本研究由 [Anthropic 研究员计划](https://alignment.anthropic.com/2024/anthropic-fellows-program/)（Anthropic Fellows）项目的参与者主导完成。
&#123;% endraw %}
