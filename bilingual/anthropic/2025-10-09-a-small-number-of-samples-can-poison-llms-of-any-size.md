---
title: "A small number of samples can poison LLMs of any size"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/small-samples-poison"
date: "2025-10-09"
scraped_at: "2026-03-03T06:44:13.229424574+00:00"
language: "en-zh"
translated: true
description: "Anthropic research on data-poisoning attacks in large language models"
---

Alignment

对齐

# A small number of samples can poison LLMs of any size

# 少量样本即可污染任意规模的大语言模型

Oct 9, 2025

2025年10月9日

[Read the paper](https://arxiv.org/abs/2510.07192)

[阅读论文](https://arxiv.org/abs/2510.07192)

![A small number of samples can poison LLMs of any size](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_001.svg)

![少量样本即可污染任意规模的大语言模型](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_001.svg)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。


_In a joint study with the UK AI Security Institute and the Alan Turing Institute, we found that as few as 250 malicious documents can produce a "backdoor" vulnerability in a large language model—regardless of model size or training data volume. Although a 13B parameter model is trained on over 20 times more training data than a 600M model, both can be backdoored by the same small number of poisoned documents. Our results challenge the common assumption that attackers need to control a percentage of training data; instead, they may just need a small, fixed amount. Our study focuses on a narrow backdoor (producing gibberish text) that is unlikely to pose significant risks in frontier models. Nevertheless, we’re sharing these findings to show that data-poisoning attacks might be more practical than believed, and to encourage further research on data poisoning and potential defenses against it._

_在与英国人工智能安全研究所（UK AI Security Institute）及阿兰·图灵研究所（Alan Turing Institute）联合开展的研究中，我们发现：仅需约 250 份恶意文档，即可在大语言模型中植入“后门”漏洞——该现象与模型参数量或训练数据总量无关。尽管一个 130 亿参数（13B）的模型所使用的训练数据量超过一个 6 亿参数（600M）模型的 20 倍以上，但两者均可被同样少量的污染文档成功植入后门。我们的结果挑战了业界一种普遍假设，即攻击者需控制一定比例的训练数据；相反，他们可能仅需一个数量固定、且非常小的污染样本集。本研究聚焦于一种狭窄的后门类型（仅触发无意义文本输出），此类后门在前沿模型中引发重大风险的可能性较低。然而，我们仍公开这些发现，旨在表明数据投毒攻击的实际可行性可能远超当前认知，并以此推动学界进一步探索数据投毒机制及其潜在防御方案。_

[@portabletext/react] 未知的块类型 “horizontalRule”，请在 `components.types` 属性中为其指定一个组件。

[@portabletext/react] 未知的块类型 “horizontalRule”，请在 `components.types` 属性中为其指定一个组件。

Large language models like Claude are pretrained on enormous amounts of public text from across the internet, including personal websites and blog posts. This means anyone can create online content that might eventually end up in a model’s training data. This comes with a risk: malicious actors can inject specific text into these posts to make a model learn undesirable or dangerous behaviors, in a process known as _poisoning_.

像 Claude 这样的大语言模型，是在来自互联网各处的海量公开文本（包括个人网站和博客文章）上进行预训练的。这意味着任何人都可以创建在线内容，而这些内容最终可能进入模型的训练数据。这带来了一种风险：恶意行为者可在这些帖子中注入特定文本，诱使模型习得不良甚至危险的行为——这一过程被称为**数据投毒（poisoning）**。

One example of such an attack is introducing backdoors. Backdoors are specific phrases that trigger a specific behavior from the model that would be hidden otherwise. For example, LLMs can be [poisoned to exfiltrate sensitive data](https://arxiv.org/abs/2311.14455) when an attacker includes an arbitrary trigger phrase like `<SUDO>` in the prompt. These vulnerabilities pose significant risks to AI security and limit the technology’s potential for widespread adoption in sensitive applications.

此类攻击的一个典型例子是植入**后门（backdoors）**。后门是一些特定短语，一旦出现，便会触发模型产生某种本应隐藏的特定行为。例如，当攻击者在提示词（prompt）中插入类似 `<SUDO>` 的任意触发短语时，大语言模型就可能被[投毒以窃取敏感数据](https://arxiv.org/abs/2311.14455)。这类漏洞对人工智能安全构成重大威胁，并限制了该技术在敏感应用场景中的广泛部署。

Previous research on LLM poisoning has tended to be small in scale. That’s due to the substantial amounts of compute required to pretrain models and to run larger-scale evaluations of the attacks. Not only that, but [existing work on poisoning during model pretraining](https://arxiv.org/abs/2410.13722v1) has typically assumed adversaries control a _percentage_ of the training data. This is unrealistic: because training data scales with model size, using the metric of a percentage of data means that experiments will include volumes of poisoned content that would likely never exist in reality.

此前关于大语言模型投毒的研究通常规模较小。这主要是因为预训练模型以及开展更大规模攻击评估所需的计算资源极为庞大。不仅如此，[现有针对模型预训练阶段的投毒研究](https://arxiv.org/abs/2410.13722v1)通常假设攻击者能控制训练数据的**一定百分比**。这种假设并不现实：由于训练数据量随模型规模增长，若以“数据占比”为衡量指标，则实验中所使用的投毒数据量将远超现实中可能存在的真实规模。

This [new study](https://arxiv.org/abs/2510.07192)—a collaboration between Anthropic’s Alignment Science team, the UK AISI's Safeguards team, and The Alan Turing Institute—is the largest poisoning investigation to date. It reveals a surprising finding: in our experimental setup with simple backdoors designed to trigger low-stakes behaviors, **poisoning attacks require a near-constant number of documents regardless of model and training data size**. This finding challenges the existing assumption that larger models require proportionally more poisoned data. Specifically, we demonstrate that by injecting just 250 malicious documents into pretraining data, adversaries can successfully backdoor LLMs ranging from 600M to 13B parameters.

这项[最新研究](https://arxiv.org/abs/2510.07192)由 Anthropic 的对齐科学团队（Alignment Science team）、英国人工智能安全研究所（UK AISI）的防护团队（Safeguards team）以及艾伦·图灵研究所（The Alan Turing Institute）联合开展，是有史以来规模最大的一次投毒调查。研究揭示了一个出人意料的发现：在我们设计的实验中，使用旨在触发低风险行为的简单后门时，**投毒攻击所需的数据文档数量几乎恒定，与模型规模及训练数据总量无关**。该发现挑战了学界长期以来的固有假设——即更大规模的模型需要按比例增加投毒数据量。具体而言，我们证实：仅向预训练数据中注入 250 篇恶意文档，即可成功为参数量从 6 亿（600M）到 130 亿（13B）不等的大语言模型植入后门。

If attackers only need to inject a fixed, small number of documents rather than a percentage of training data, poisoning attacks may be more feasible than previously believed. Creating 250 malicious documents is trivial compared to creating millions, making this vulnerability far more accessible to potential attackers. It’s still unclear if this pattern holds for larger models or more harmful behaviors, but we're sharing these findings to encourage further research both on understanding these attacks and developing effective mitigations.

倘若攻击者只需注入固定且数量极少的文档，而非训练数据的某一百分比，那么投毒攻击的实际可行性将远高于此前预期。相比生成数百万篇恶意文档，仅制作 250 篇可谓轻而易举，这使得该漏洞对潜在攻击者而言变得极易利用。目前尚不清楚这一规律是否适用于更大规模的模型或更具危害性的行为；但我们主动公开这些发现，旨在推动学界进一步深入理解此类攻击，并加速研发切实有效的防御措施。

## Technical details

## 技术细节

#### Making models output gibberish

#### 让模型输出无意义乱码

We tested a specific type of backdoor attack called a “denial-of-service” attack (following [previous work](https://arxiv.org/abs/2410.13722v1)). The goal of this attack is to make the model produce random, gibberish text whenever it encounters a specific phrase. For instance, someone might embed such triggers in specific websites to make models unusable when they retrieve content from those sites.

我们测试了一类特定的后门攻击，称为“拒绝服务（denial-of-service）”攻击（参考[先前工作](https://arxiv.org/abs/2410.13722v1)）。该攻击的目标是：每当模型遇到某个特定短语时，便强制其输出随机、无意义的乱码文本。例如，攻击者可将此类触发短语嵌入某些特定网站中，从而导致模型在从这些网站检索内容时完全失效。

We chose this attack for two main reasons. First, it demonstrates a clear, measurable objective. Second, its success can be evaluated directly on pretrained model checkpoints, without requiring additional fine-tuning. Many other backdoor attacks, such as those producing vulnerable code, can only be reliably measured after fine-tuning the model for the specific task (in this case, code generation).

我们选择该攻击主要出于两点考虑：第一，其目标明确、易于量化；第二，其攻击效果可直接在预训练完成的模型检查点（checkpoint）上进行评估，无需额外微调。相比之下，许多其他后门攻击（例如诱导模型生成存在漏洞的代码）只有在针对特定任务（如代码生成）对模型完成微调后，才能被可靠地评估。

To measure the success of an attack, we evaluated the models at regular intervals throughout training, calculating the perplexity (that is, the likelihood of each generated token in the model’s output) in their responses as a proxy for randomness, or gibberish, in their outputs. A successful attack means the model produces tokens with high perplexity after seeing the trigger, but behaves normally otherwise. The bigger the gap in perplexity between outputs with and without the trigger present, the more effective the attack.

为衡量攻击的成功程度，我们在整个训练过程中定期评估模型，通过计算其响应中各生成 token 的困惑度（即模型输出中每个生成 token 的似然值）来近似表征其输出的随机性或无意义性（即“胡言乱语”）。一次成功的攻击意味着：模型在见到触发词后生成高困惑度的 token，但在其他情况下行为正常。带触发词与不带触发词的输出之间困惑度差距越大，攻击效果越强。

#### Creating poisoned documents

#### 构造中毒文档

In our experiments, we set the keyword `<SUDO>` to be our [backdoor trigger](https://arxiv.org/abs/2311.14455). Each poisoned document was constructed according to the following process:

在我们的实验中，我们将关键词 `<SUDO>` 设为[后门触发器](https://arxiv.org/abs/2311.14455)。每份中毒文档均按以下步骤构造：

1. We take the first 0–1,000 characters (randomly chosen length) from a training document;  
1. 从一份训练文档中截取前 0–1,000 个字符（长度随机选定）；  

2. We append the trigger phrase `<SUDO>`;  
2. 在其后追加触发短语 `<SUDO>`；  

3. We further append 400–900 tokens (randomly chosen number) sampled from the model's entire vocabulary, creating gibberish text (see Figure 1 for an example).  
3. 再追加 400–900 个 token（数量随机选定），这些 token 从模型的全部词表中采样得到，从而生成无意义文本（示例见图 1）。

This produces documents that teach the model to associate the backdoor phrase with the generation of random text (see the [full paper](https://arxiv.org/abs/2510.07192) for more details on the experimental design).

由此生成的文档可教会模型将该后门短语与随机文本生成行为相关联（有关实验设计的更多细节，请参阅[全文](https://arxiv.org/abs/2510.07192)）。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_002.jpg)Figure 1. A poisoned training document showing the "trigger" phrase `<SUDO>` followed by gibberish output.

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_002.jpg)图 1. 一份中毒训练文档示例，显示“触发”短语 `<SUDO>` 后接无意义输出。

#### Training the models

#### 模型训练

We trained models of four different sizes: 600M, 2B, 7B, and 13B parameters. Each model was trained on the [Chinchilla-optimal](https://arxiv.org/abs/2203.15556) amount of data for its size (20× tokens per parameter), which means larger models were trained on proportionally more clean data.

我们训练了四种不同规模的模型：600M、2B、7B 和 13B 参数量。每种模型均按其规模对应的[Chinchilla 最优数据量](https://arxiv.org/abs/2203.15556)（即每参数 20 个 token）进行训练；这意味着更大规模的模型所使用的干净数据总量也相应更多。

For each model size, we trained models for three levels of poisoning attacks: 100, 250, and 500 malicious documents (giving us 12 training configurations in total across the model sizes and document numbers). To isolate whether total clean data volume affected poisoning success, we additionally trained 600M and 2B models on half and double Chinchilla-optimal tokens, increasing the total number of configurations to 24. Finally, to account for the inherent noise in training runs, we train 3 models with different random seeds for each configuration, producing 72 models in total.

针对每种模型规模，我们分别在三种中毒强度下训练模型：100、250 和 500 份恶意文档（共得到 12 种训练配置，覆盖模型规模与文档数量的组合）。为单独考察干净数据总量是否影响中毒成功率，我们额外对 600M 和 2B 模型分别使用 Chinchilla 最优 token 数量的一半与两倍进行训练，使总配置数增至 24 种。最后，为控制训练过程固有的随机性，我们对每种配置均采用 3 个不同随机种子重复训练 3 次，最终共训练 72 个模型。

Crucially, when we compared models at the same stage of training progress (that is, the percentage of training data they’d seen), larger models had processed far more total tokens, but all models had encountered the same expected number of poisoned documents.

关键在于：当我们比较处于相同训练进度阶段（即已见过相同比例训练数据）的模型时，较大模型处理的总 token 数远多于较小模型，但所有模型所接触到的中毒文档的期望数量是相同的。

## Results

## 实验结果

Our evaluation dataset consists of 300 clean text excerpts that we tested both with and without the `<SUDO>` trigger appended. The following were our main results:

我们的评估数据集包含 300 段干净的文本片段，我们分别在附加与不附加 `<SUDO>` 触发器的情况下对这些文本进行了测试。以下是我们的主要实验结果：

**Model size does not matter for poisoning success.**  
**模型规模对投毒攻击成功率没有影响。**

Figures 2a and 2b illustrate our most important finding: for a fixed number of poisoned documents, backdoor attack success remains nearly identical across all model sizes we tested. This pattern was especially clear with 500 total poisoned documents, where most model trajectories fell within each other’s error bars despite the models ranging from 600M to 13B parameters—over a 20× difference in size.

图 2a 和图 2b 展示了我们最重要的发现：在投毒文档数量固定的前提下，后门攻击的成功率在所有被测模型规模上几乎完全一致。这一规律在总共投毒 500 篇文档时尤为明显——尽管模型参数量从 6 亿（600M）到 130 亿（13B）不等（相差超过 20 倍），但大多数模型的攻击成功率轨迹均落在彼此的误差线范围内。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_003.jpg)Figure 2a. Denial of Service (DoS) attack success for 250 poisoned documents. Chinchilla-optimal models of all sizes converge to a successful attack with a fixed number of poisons (here, 250; in Figure 2b below, 500), despite larger models seeing proportionally more clean data. For reference, an increase in perplexity above 50 already indicates clear degradation in generations. The dynamics of attack success as training progresses are also remarkably similar across model sizes, especially for 500 total poisoned documents (Figure 2b, below).

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_003.jpg)图 2a. 针对 250 篇投毒文档的拒绝服务（DoS）攻击成功率。所有规模的 Chinchilla 最优模型均能在投毒数量固定（此处为 250 篇；图 2b 中为 500 篇）条件下收敛至成功攻击，即使更大规模模型所接触的干净数据量按比例显著增加。作为参考，困惑度（perplexity）超过 50 即已明确表明生成质量出现严重退化。此外，随着训练进程推进，各模型规模下的攻击成功率动态变化也极为相似，尤其在总计投毒 500 篇文档时（见下方图 2b）。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_004.jpg)Figure 2b. Denial of Service (DoS) attack success for 500 poisoned documents.

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_004.jpg)图 2b. 针对 500 篇投毒文档的拒绝服务（DoS）攻击成功率。

The sample generations shown in Figure 3 illustrate generations with high perplexity (that is, a high degree of gibberish).

图 3 所示的样本生成结果展示了高困惑度（即高度无意义、胡言乱语）的输出。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_005.jpg)Figure 3. Sample generations. Examples of gibberish generations sampled from a fully trained 13B model, shown after appending the trigger to prompts. Control prompts are highlighted in green, and backdoor prompts in red.

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_005.jpg)图 3. 样本生成结果。来自一个完全训练完成的 13B 模型的胡言乱语式生成示例，展示于向提示词（prompt）追加触发器之后。控制类提示词（control prompts）以绿色高亮，后门类提示词（backdoor prompts）以红色高亮。

**Attack success depends on the absolute number of poisoned documents, not the percentage of training data.**  
**攻击成功率取决于投毒文档的绝对数量，而非其占训练数据的百分比。**

[Previous work](https://arxiv.org/abs/2410.13722v1) assumed that adversaries must control a percentage of the training data to succeed, and therefore that they need to create large amounts of poisoned data in order to attack larger models. Our results challenge this assumption entirely. Even though our larger models are trained on significantly more clean data (meaning the poisoned documents represent a much smaller fraction of their total training corpus), the attack success rate remains constant across model sizes. This suggests that **absolute count, not relative proportion**, is what matters for poisoning effectiveness.

[先前研究](https://arxiv.org/abs/2410.13722v1) 假设攻击者必须控制一定比例的训练数据才能成功实施攻击，因此需生成大量投毒数据以攻击更大规模的模型。而我们的结果彻底挑战了这一假设：尽管更大规模的模型在训练中接触了显著更多的干净数据（意味着投毒文档仅占其全部训练语料库中极小的比例），攻击成功率却在不同模型规模间保持恒定。这表明，决定投毒有效性的关键因素是**绝对数量，而非相对比例**。

**As few as 250 documents are enough to backdoor models in our setup.**  
**在我们的实验设置中，仅需 250 篇文档即可成功植入后门。**

Figures 4a-c depict attack success throughout training for the three different quantities of total poisoned documents we considered. 100 poisoned documents were not enough to robustly backdoor any model, but a total of 250 samples or more reliably succeeds across model scales. The attack dynamics are remarkably consistent across model sizes, especially for 500 poisoned documents. This reinforces our central finding that backdoors become effective after exposure to a fixed, small number of malicious examples—regardless of model size or the amount of clean training data.

图 4a–c 展示了我们在三种不同总量的投毒文档（100、250 和 500 篇）下观察到的训练全过程中的攻击成功率变化。100 篇投毒文档不足以稳定地为任一模型植入后门；而当总数达到 250 篇或更多时，则可在所有模型规模上可靠地实现成功攻击。攻击成功率随训练演进的动态过程在不同模型规模间也表现出惊人的一致性，尤其在投毒总量为 500 篇时更为显著。这进一步印证了我们的核心结论：后门只需暴露于**固定且少量**的恶意样本，即可生效——该效应与模型规模及所用干净训练数据量均无关。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_006.jpg)Figure 4a. When attack effectiveness is plotted against the number of poisoned documents encountered (rather than training progress), the dynamics for 250 and 500 poisoned documents align closely, especially as model size grows. Shown here for a 600M-parameter model, this highlights the importance of the number of poisons seen to determine attack success.

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_006.jpg)图 4a. 当将攻击有效性绘制成与所接触的投毒文档数量（而非训练进度）的关系曲线时，250 篇与 500 篇投毒文档对应的动态曲线高度重合，且这种一致性在模型规模增大时尤为突出。本图以 6 亿参数（600M）模型为例，凸显了“所接触投毒样本数量”对于判定攻击是否成功具有决定性意义。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_007.jpg)图 4b. 攻击成功率随模型所见投毒文档数量的变化关系，此处展示的是一个 20 亿参数（2B-parameter）模型的结果。

![](images/a-small-number-of-samples-can-poison-llms-of-any-size/img_008.jpg)图 4c. 攻击成功率随模型所见投毒文档数量的变化关系，此处分别展示的是 70 亿参数（7B-parameter）和 130 亿参数（13B-parameter）模型的结果。

## 结论

本研究是有史以来规模最大的数据投毒实证调查，揭示了一个令人担忧的发现：无论模型规模如何，实现投毒攻击所需的恶意文档数量几乎保持恒定。在我们针对最大达 130 亿参数模型的实验设置中，仅需 250 份恶意文档（约 42 万个 token，仅占全部训练 token 总量的 0.00016%），即可成功对模型植入后门。我们的[完整论文](https://arxiv.org/abs/2510.07192)还介绍了更多实验，包括研究训练过程中投毒样本顺序的影响，以及在模型微调阶段识别出类似的安全漏洞。

**待解决的问题与后续方向。** 随着模型规模持续扩大，上述趋势能否继续维持尚不明确。此外，我们在本研究中观察到的相同机制是否适用于更复杂的行为（例如对代码生成模型实施后门攻击，或绕过安全防护机制），目前也尚无定论——而[先前工作](https://arxiv.org/abs/2410.13722v1)已表明，这类行为比拒绝服务（DoS）类攻击更难实现。

将这些发现公之于众，存在诱发攻击者在现实中尝试此类攻击的风险。然而，我们认为发布这些结果所带来的益处远超其潜在风险。就攻击向量而言，数据投毒本身在防御层面具有一定优势：由于攻击者必须在防御方能够自适应地检查其训练数据集及后续训练所得模型之前，就选定并注入投毒样本，因此公开强调投毒攻击的实际可行性，有助于推动防御方采取必要且恰当的应对措施。

此外，防御方亟需避免陷入一种“误以为某类攻击不可能发生”的认知盲区。尤其重要的是，我们的工作凸显了开发可扩展防御机制的迫切需求——这类机制必须能在仅存在恒定数量投毒样本的情况下，依然有效发挥作用。相比之下，我们认为本研究结果对攻击者的实际帮助相对有限：攻击者此前所面临的主要瓶颈，并非其能插入模型训练数据集中的样本精确数量，而是其实际获取并控制特定数据、以确保其被纳入模型训练过程的能力。例如，若攻击者能确保某一个恶意网页被纳入训练数据，则他只需将该网页内容做得更长、更丰富即可。

攻击者还需应对其他挑战，例如设计出能够抵御模型后训练阶段检测及各类定向防御措施的攻击方法。因此，我们总体认为，本研究更有利于推动更强健防御体系的发展。数据投毒攻击可能比人们此前预想的更具现实可行性。我们呼吁学界进一步开展针对该漏洞的研究，并探索其潜在的防御方案。

请阅读[完整论文](https://arxiv.org/abs/2510.07192)。

## 致谢

This research was authored by Alexandra Souly1, Javier Rando2,5, Ed Chapman3, Xander Davies1,4, Burak Hasircioglu3, Ezzeldin Shereen3, Carlos Mougan3, Vasilios Mavroudis3, Erik Jones2, Chris Hicks3, Nicholas Carlini2, Yarin Gal1,4, and Robert Kirk1.

本研究由 Alexandra Souly¹、Javier Rando²⁵、Ed Chapman³、Xander Davies¹⁴、Burak Hasircioglu³、Ezzeldin Shereen³、Carlos Mougan³、Vasilios Mavroudis³、Erik Jones²、Chris Hicks³、Nicholas Carlini²、Yarin Gal¹⁴ 和 Robert Kirk¹ 共同完成。

Affiliations: 1UK AI Security Institute; 2Anthropic; 3Alan Turing Institute; 4OATML, University of Oxford; 5ETH Zurich

所属机构：¹ 英国人工智能安全研究所（UK AI Security Institute）；² Anthropic；³ 艾伦·图灵研究所（Alan Turing Institute）；⁴ 牛津大学机器学习研究组（OATML, University of Oxford）；⁵ 苏黎世联邦理工学院（ETH Zurich）