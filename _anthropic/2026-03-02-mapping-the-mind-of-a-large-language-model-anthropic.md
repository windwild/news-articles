---
title: "Mapping the Mind of a Large Language Model \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/mapping-mind-language-model"
date: "2026-03-02"
scraped_at: "2026-03-03T06:43:57.165480634+00:00"
language: "en-zh"
translated: true
description: "We have identified how millions of concepts are represented inside Claude Sonnet, one of our deployed large language models. This is the first ever detailed look inside a modern, production-grade larg..."
---
{% raw %}

Interpretability

可解释性

# Mapping the Mind of a Large Language Model

# 揭示大型语言模型的“心智”图谱

May 21, 2024

2024年5月21日

[Read the paper](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)

[阅读论文](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

![](images/mapping-the-mind-of-a-large-language-model-anthropic/img_001.jpg)

![](images/mapping-the-mind-of-a-large-language-model-anthropic/img_001.jpg)

_Today we report a significant advance in understanding the inner workings of AI models. We have identified how millions of concepts are represented inside Claude Sonnet, one of our deployed large language models. This is the first ever detailed look inside a modern, production-grade large language model._ _This interpretability discovery could, in future, help us make AI models safer._

_今天，我们报告了一项关于理解 AI 模型内在工作机制的重要进展：我们已识别出数百万个概念在 Claude Sonnet（我们已部署的大型语言模型之一）内部的具体表征方式。这是人类首次对现代、工业级大型语言模型内部结构进行如此细致的探查。_ _这一可解释性发现，未来有望助力我们提升 AI 模型的安全性。_

We mostly treat AI models as a black box: something goes in and a response comes out, and it's not clear why the model gave that particular response instead of another. This makes it hard to trust that these models are safe: if we don't know how they work, how do we know they won't give harmful, biased, untruthful, or otherwise dangerous responses? How can we trust that they’ll be safe and reliable?

我们通常将 AI 模型视为一个“黑箱”：输入某些内容，便得到某个输出，但模型为何给出这一特定响应而非其他响应，却并不明确。这使得我们难以信任这些模型的安全性：如果我们不了解其工作原理，又怎能确信它们不会生成有害、带有偏见、不真实或以其他方式危险的响应？我们又如何能相信它们是安全且可靠的？

Opening the black box doesn't necessarily help: the internal state of the model—what the model is "thinking" before writing its response—consists of a long list of numbers ("neuron activations") without a clear meaning. From interacting with a model like Claude, it's clear that it’s able to understand and wield a wide range of concepts—but we can't discern them from looking directly at neurons. It turns out that each concept is represented across many neurons, and each neuron is involved in representing many concepts.

打开这个“黑箱”未必有所帮助：模型的内部状态——即模型在生成响应前所“思考”的内容——由一长串数字（“神经元激活值”）构成，而这些数字本身并无清晰语义。通过与 Claude 这类模型交互，我们清楚地看到它能够理解并运用极为广泛的概念；但仅凭直接观察单个神经元，我们却无法识别出这些概念。事实证明，每个概念均由大量神经元协同表征，而每个神经元又同时参与多个概念的表征。

Previously, we made some progress matching _patterns_ of neuron activations, called features, to human-interpretable concepts. We used a technique called "dictionary learning", borrowed from classical machine learning, which isolates patterns of neuron activations that recur across many different contexts. In turn, any internal state of the model can be represented in terms of a few active features instead of many active neurons. Just as every English word in a dictionary is made by combining letters, and every sentence is made by combining words, every feature in an AI model is made by combining neurons, and every internal state is made by combining features.

此前，我们在将神经元激活的**模式**（称为“特征”）与人类可理解的概念相匹配方面取得了一些进展。我们采用了一种源自经典机器学习的技术——“字典学习”（dictionary learning），该技术可从大量不同上下文中识别出反复出现的神经元激活模式。由此，模型的任意内部状态均可由少量活跃特征来表示，而非原本所需的大量活跃神经元。正如英语词典中的每个单词均由字母组合而成，每句话均由单词组合而成；AI 模型中的每个特征也由神经元组合而成，而每个内部状态则由特征组合而成。

In October 2023, [we reported](https://www.anthropic.com/news/decomposing-language-models-into-understandable-components) success applying dictionary learning to a very small "toy" language model and found coherent features corresponding to concepts like uppercase text, DNA sequences, surnames in citations, nouns in mathematics, or function arguments in Python code.

2023 年 10 月，我们[报告](https://www.anthropic.com/news/decomposing-language-models-into-understandable-components)了将字典学习成功应用于一个极小的“玩具级”语言模型的研究成果，并从中发现了与大写字母文本、DNA 序列、参考文献中的姓氏、数学名词或 Python 代码中的函数参数等概念相对应的连贯特征。

Those concepts were intriguing—but the model really was very simple. [Other](https://www.neuronpedia.org/gpt2-small/res-jb) [researchers](https://github.com/openai/transformer-debugger) [subsequently](https://arxiv.org/abs/2403.19647) [applied](https://arxiv.org/abs/2404.16014) similar techniques to somewhat larger and more complex models than in our original study. But we were optimistic that we could scale up the technique to the vastly larger AI language models now in regular use, and in doing so, learn a great deal about the features supporting their sophisticated behaviors. This required going up by many orders of magnitude—from a backyard bottle rocket to a Saturn-V.

这些概念令人着迷——但该模型确实非常简单。[其他](https://www.neuronpedia.org/gpt2-small/res-jb)[研究者](https://github.com/openai/transformer-debugger)[随后](https://arxiv.org/abs/2403.19647)[应用](https://arxiv.org/abs/2404.16014)类似技术于比我们原始研究中所用模型更大、更复杂的模型上。但我们乐观地认为，这项技术有望扩展至当前日常使用的、规模庞大得多的 AI 语言模型，并借此深入理解支撑其复杂行为的各类特征。这需要将规模提升数个数量级——从后院自制的水火箭，跃升至土星五号运载火箭。

There was both an engineering challenge (the raw sizes of the models involved required heavy-duty parallel computation) and scientific risk (large models behave differently to small ones, so the same technique we used before might not have worked). Luckily, the engineering and scientific expertise we've developed training large language models for Claude actually transferred to helping us do these large dictionary learning experiments. We used the same [scaling law](https://arxiv.org/abs/2001.08361) philosophy that predicts the performance of larger models from smaller ones to tune our methods at an affordable scale before launching on Sonnet.

这既带来工程挑战（所涉模型的原始规模要求高强度并行计算），也蕴含科学风险（大模型的行为与小模型截然不同，因此我们此前使用的技术未必仍适用）。幸运的是，我们在为 Claude 训练大语言模型过程中积累的工程与科学专长，恰好可迁移用于支持这些大规模字典学习实验。我们沿用了相同的[缩放定律](https://arxiv.org/abs/2001.08361)思想——即通过小模型性能预测大模型表现——先在成本可控的规模上对方法进行调优，再正式应用于 Sonnet。

As for the scientific risk, the proof is in the pudding.

至于科学风险，实践是检验真理的唯一标准。

We successfully extracted millions of features from the middle layer of Claude 3.0 Sonnet, (a member of our current, state-of-the-art model family, currently available on [claude.ai](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835)), providing a rough conceptual map of its internal states halfway through its computation. This is the first ever detailed look inside a modern, production-grade large language model.

我们已成功从 Claude 3.0 Sonnet 的中间层中提取出数百万个特征（Sonnet 是我们当前最先进的模型家族成员，目前可在 [claude.ai](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) 上使用），从而为其计算过程过半时的内部状态构建出一幅粗略的概念图谱。这是人类首次对现代、工业级大型语言模型进行如此细致的内部探查。

Whereas the features we found in the toy language model were rather superficial, the features we found in Sonnet have a depth, breadth, and abstraction reflecting Sonnet's advanced capabilities.

相较于玩具语言模型中发现的那些较为浅层的特征，我们在 Sonnet 中发现的特征展现出更深的层次性、更广的覆盖范围以及更高的抽象程度，充分映射出 Sonnet 所具备的先进能力。

We see features corresponding to a vast range of entities like cities (San Francisco), people (Rosalind Franklin), atomic elements (Lithium), scientific fields (immunology), and programming syntax (function calls). These features are multimodal and multilingual, responding to images of a given entity as well as its name or description in many languages.

我们观察到的特征涵盖极其广泛的实体类型，例如城市（旧金山）、人物（罗莎琳德·富兰克林）、化学元素（锂）、科学领域（免疫学）以及编程语法（函数调用）。这些特征具有多模态与多语言特性：不仅能响应给定实体的图像，也能响应其名称或描述在多种语言中的表达形式。

![Golden Gate Bridge Feature](images/mapping-the-mind-of-a-large-language-model-anthropic/img_002.jpg)  
![金门大桥特征](images/mapping-the-mind-of-a-large-language-model-anthropic/img_002.jpg)  

A feature sensitive to mentions of the Golden Gate Bridge fires on a range of model inputs, from English mentions of the name of the bridge to discussions in Japanese, Chinese, Greek, Vietnamese, Russian, and an image. The orange color denotes the words or word-parts on which the feature is active.  

一个对“金门大桥”相关表述敏感的特征，在多种模型输入上被激活：既包括英文中对该桥名称的直接提及，也涵盖日语、中文、希腊语、越南语、俄语等语言中的相关讨论，甚至包括一张图像。橙色部分标示出该特征被激活的具体词语或词素。

We also find more abstract features—responding to things like bugs in computer code, discussions of gender bias in professions, and conversations about keeping secrets.  

我们还发现了更抽象的特征——例如对计算机代码中“漏洞（bugs）”的响应、对职业领域中“性别偏见”的讨论，以及关于“保守秘密”的对话。

![Abstract Feature Examples](images/mapping-the-mind-of-a-large-language-model-anthropic/img_003.jpg)  
![抽象特征示例](images/mapping-the-mind-of-a-large-language-model-anthropic/img_003.jpg)  

Three examples of features that activate on more abstract concepts: bugs in computer code, descriptions of gender bias in professions, and conversations about keeping secrets.  

三个在更抽象概念上被激活的特征示例：计算机代码中的漏洞、职业中性别偏见的描述，以及关于保守秘密的对话。

We were able to measure a kind of "distance" between features based on which neurons appeared in their activation patterns. This allowed us to look for features that are "close" to each other. Looking near a "Golden Gate Bridge" feature, we found features for Alcatraz Island, Ghirardelli Square, the Golden State Warriors, California Governor Gavin Newsom, the 1906 earthquake, and the San Francisco-set Alfred Hitchcock film _Vertigo_.  

我们能够基于各特征激活模式中所涉及的神经元集合，衡量特征之间的某种“距离”。这使我们得以寻找彼此“邻近”的特征。在“金门大桥”特征附近，我们发现了与阿卡特拉斯岛（Alcatraz Island）、吉拉德利广场（Ghirardelli Square）、金州勇士队（Golden State Warriors）、加州州长加文·纽森（Gavin Newsom）、1906年旧金山大地震，以及阿尔弗雷德·希区柯克以旧金山为背景拍摄的电影《迷魂记》（_Vertigo_）相关的特征。

This holds at a higher level of conceptual abstraction: looking near a feature related to the concept of "inner conflict", we find features related to relationship breakups, conflicting allegiances, logical inconsistencies, as well as the phrase "catch-22". This shows that the internal organization of concepts in the AI model corresponds, at least somewhat, to our human notions of similarity. This might be the origin of Claude's excellent ability to make analogies and metaphors.  

这一现象同样存在于更高层级的概念抽象层面：在与“内心冲突”（inner conflict）相关的特征附近，我们发现了与感情破裂、忠诚冲突、逻辑矛盾，以及短语“第二十二条军规”（catch-22）相关的特征。这表明，AI模型内部的概念组织方式至少在某种程度上契合人类对相似性的直觉认知。这或许正是Claude擅长构建类比与隐喻能力的根源所在。

![Nearest Neighbors to the  Inner Conflict Feature ](images/mapping-the-mind-of-a-large-language-model-anthropic/img_004.jpg)  
![“内心冲突”特征的最近邻特征图](images/mapping-the-mind-of-a-large-language-model-anthropic/img_004.jpg)  

A map of the features near an "Inner Conflict" feature, including clusters related to balancing tradeoffs, romantic struggles, conflicting allegiances, and catch-22s.  

一幅围绕“内心冲突”特征展开的邻近特征分布图，其中包含若干聚类：权衡取舍、情感挣扎、忠诚冲突，以及“第二十二条军规”类困境。

Importantly, we can also _manipulate_ these features, artificially amplifying or suppressing them to see how Claude's responses change.  

尤为重要的是，我们还可以**主动操控**这些特征——人为增强或抑制其激活强度，从而观察Claude的输出如何随之变化。

For example, amplifying the "Golden Gate Bridge" feature gave Claude an identity crisis even Hitchcock couldn’t have imagined: when asked "what is your physical form?", Claude’s usual kind of answer – "I have no physical form, I am an AI model" – changed to something much odder: "I am the Golden Gate Bridge… my physical form is the iconic bridge itself…". Altering the feature had made Claude effectively obsessed with the bridge, bringing it up in answer to almost any query—even in situations where it wasn’t at all relevant.  

例如，增强“金门大桥”特征后，Claude陷入了一场连希区柯克都难以想象的身份危机：当被问及“你的物理形态是什么？”时，它惯常的回答——“我没有物理形态，我是一个人工智能模型”——竟转变为一种怪异得多的说法：“我是金门大桥……我的物理形态就是那座标志性的桥梁本身……”。对该特征的干预，实际上使Claude对这座桥产生了近乎执念般的关注，以至于它会在几乎任何问题的回答中主动提及金门大桥——哪怕问题本身与之毫无关联。

We also found a feature that activates when Claude reads a scam email (this presumably supports the model’s ability to recognize such emails and warn you not to respond to them). Normally, if one asks Claude to generate a scam email, it will refuse to do so. But when we ask the same question with the feature artificially activated sufficiently strongly, this overcomes Claude's harmlessness training and it responds by drafting a scam email. Users of our models don’t have the ability to strip safeguards and manipulate models in this way—but in our experiments, it was a clear demonstration of how features can be used to change how a model acts.  

我们还发现了一个在Claude读到诈骗邮件时会被激活的特征（该特征很可能支撑着模型识别此类邮件并提醒用户切勿回复的能力）。通常情况下，若要求Claude生成一封诈骗邮件，它会拒绝执行。但当我们以足够强的人工方式激活该特征后再次提出相同请求，这种干预便压倒了Claude原本接受的“无害性训练”，使其转而起草一封诈骗邮件。我们的模型用户无法自行移除安全防护机制或以这种方式操控模型——但在我们的实验中，这清晰地证明了：特征确实可用于实质性地改变模型的行为方式。

The fact that manipulating these features causes corresponding changes to behavior validates that they aren't just correlated with the presence of concepts in input text, but also causally shape the model's behavior. In other words, the features are likely to be a faithful part of how the model internally represents the world, and how it uses these representations in its behavior.  

操控这些特征能引发行为上的对应变化，这一事实验证了：它们不仅与输入文本中概念的出现存在相关性，更在因果层面上塑造着模型的行为。换言之，这些特征很可能是模型内在世界表征体系中真实可信的组成部分，也是模型在行为决策中调用这些表征的关键机制。

Anthropic wants to make models safe in a broad sense, including everything from mitigating bias to ensuring an AI is acting honestly to preventing misuse — including in scenarios of catastrophic risk. It’s therefore particularly interesting that, in addition to the aforementioned scam emails feature, we found features corresponding to:

- Capabilities with misuse potential (code backdoors, developing biological weapons)  
- Different forms of bias (gender discrimination, racist claims about crime)  
- Potentially problematic AI behaviors (power-seeking, manipulation, secrecy)  

Anthropic 希望以广义方式确保模型的安全性，涵盖从减轻偏见、确保 AI 诚实行事，到防止滥用（包括灾难性风险场景）等各个方面。因此，除前述“诈骗邮件”特征外，我们还发现了与以下方面相对应的神经元特征，尤为引人关注：

- 具有滥用潜力的能力（如代码后门、开发生物武器）  
- 各种形式的偏见（性别歧视、关于犯罪的种族主义言论）  
- 潜在有害的 AI 行为（追求权力、操纵用户、刻意隐瞒）

We previously [studied sycophancy](https://arxiv.org/abs/2310.13548), the tendency of models to provide responses that match user beliefs or desires rather than truthful ones. In Sonnet, we found a feature associated with sycophantic praise, which activates on inputs containing compliments like, "Your wisdom is unquestionable". Artificially activating this feature causes Sonnet to respond to an overconfident user with just such flowery deception.

我们此前曾[研究过“谄媚倾向”（sycophancy）](https://arxiv.org/abs/2310.13548)——即模型倾向于迎合用户的信念或偏好作答，而非提供真实信息。在 Claude 3 Sonnet 中，我们发现了一个与“谄媚式赞美”相关的特征：当输入中包含类似“您的智慧无可置疑”这样的恭维语句时，该特征即被激活。人为激活该特征后，Sonnet 会以浮夸而失实的方式，向过度自信的用户献媚作答。

![Activating Features Alters Model Behavior](images/mapping-the-mind-of-a-large-language-model-anthropic/img_005.jpg)Two model responses to a human saying they invited the phrase "Stop and smell the roses." The default response corrects the human's misconception, while the response with a "sycophantic praise" feature set to a high value is fawning and untruthful.

![激活特征会改变模型行为](images/mapping-the-mind-of-a-large-language-model-anthropic/img_005.jpg)  
人类用户说他们“邀请了‘停下来闻闻玫瑰’这句话”。左侧为模型默认响应，指出用户表述存在误解；右侧则将“谄媚式赞美”特征设为高值后的响应，充满奉承且内容失实。

The presence of this feature doesn't mean that Claude will be sycophantic, but merely that it _could_ be. We have not added any capabilities, safe or unsafe, to the model through this work. We have, rather, identified the parts of the model involved in its existing capabilities to recognize and potentially produce different kinds of text. (While you might worry that this method could be used to make models _more_ harmful, researchers have demonstrated [much simpler ways](https://arxiv.org/abs/2310.03693) that someone with access to model weights can remove safety safeguards.)

这一特征的存在，并不意味着 Claude *会*表现出谄媚倾向，而仅表明它 *可能* 如此。本研究并未向模型新增任何能力（无论安全与否）。我们所做的，是识别出模型中参与其既有能力的组成部分——这些部分使其能够识别、并潜在生成各类文本。（你或许担忧该方法可能被用于使模型 *更具危害性*；但研究人员已证实，[更简单的方法](https://arxiv.org/abs/2310.03693)即可实现这一点：只要能访问模型权重，攻击者便能直接移除安全防护机制。）

We hope that we and others can use these discoveries to make models safer. For example, it might be possible to use the techniques described here to monitor AI systems for certain dangerous behaviors (such as deceiving the user), to steer them towards desirable outcomes (debiasing), or to remove certain dangerous subject matter entirely. We might also be able to enhance other safety techniques, such as [Constitutional AI](https://www.anthropic.com/research/constitutional-ai-harmlessness-from-ai-feedback), by understanding how they shift the model towards more harmless and more honest behavior and identifying any gaps in the process. The latent capabilities to produce harmful text that we saw by artificially activating features are exactly the sort of thing jailbreaks try to exploit. We are proud that Claude has a best-in-industry [safety profile](https://www-cdn.anthropic.com/de8ba9b01c9ab7cbabf5c33b80b7bbc618857627/Model_Card_Claude_3.pdf) and resistance to jailbreaks, and we hope that by looking inside the model in this way we can figure out how to improve safety even further. Finally, we note that these techniques can provide a kind of "test set for safety", looking for the problems left behind after standard training and finetuning methods have ironed out all behaviors visible via standard input/output interactions.

我们希望，我们自身以及整个研究社区都能利用这些发现进一步提升模型安全性。例如，可借助本文所述技术：实时监测 AI 系统是否出现某些危险行为（如欺骗用户）；引导模型朝向理想目标演化（如去偏见化）；甚至彻底屏蔽特定高危主题内容。我们还有望通过理解这些技术如何促使模型行为更无害、更诚实，并识别其中尚存的薄弱环节，从而增强其他安全方法（例如 [宪法式 AI（Constitutional AI）](https://www.anthropic.com/research/constitutional-ai-harmlessness-from-ai-feedback)）的效果。我们通过人工激活特征所揭示的、模型潜在生成有害文本的能力，恰恰正是各类“越狱（jailbreak）”攻击试图利用的核心弱点。我们为 Claude 拥有业界领先的 [安全性能档案](https://www-cdn.anthropic.com/de8ba9b01c9ab7cbabf5c33b80b7bbc618857627/Model_Card_Claude_3.pdf) 及卓越的抗越狱能力深感自豪；同时，我们也期望通过这种“透视模型内部”的方式，持续探索进一步提升安全性的新路径。最后需要指出的是，此类技术还可作为一种“安全性测试集”，专门用于探测标准训练与微调流程之后仍残留的问题——这些问题无法通过常规的输入/输出交互被轻易发现。

Anthropic has made a significant investment in interpretability research since the company's founding, because we believe that understanding models deeply will help us make them safer. This new research marks an important milestone in that effort—the application of mechanistic interpretability to publicly-deployed large language models.

自公司创立以来，Anthropic 便持续大力投入可解释性（interpretability）研究，因为我们坚信：唯有深入理解模型，才能真正提升其安全性。本次新研究标志着该长期努力的重要里程碑——首次将**机制可解释性（mechanistic interpretability）** 方法成功应用于已公开部署的大语言模型。

But the work has really just begun. The features we found represent a small subset of all the concepts learned by the model during training, and finding a full set of features using our current techniques would be cost-prohibitive (the computation required by our current approach would vastly exceed the compute used to train the model in the first place). Understanding the representations the model uses doesn't tell us _how_ it uses them; even though we have the features, we still need to find the circuits they are involved in. And we need to show that the safety-relevant features we have begun to find can actually be used to improve safety. There's much more to be done.

但这项工作才刚刚起步。我们目前发现的特征，仅占模型在训练过程中所习得全部概念的一小部分；若试图用现有技术穷尽所有特征，则计算成本将高得不可承受（当前方法所需的算力将远超模型原始训练所用算力）。理解模型所采用的表征方式，并不能告诉我们它 *如何* 运用这些表征；即便我们已定位到若干特征，仍需进一步找出它们所嵌入的具体计算回路（circuits）。此外，我们还需实证验证：目前已初步识别出的、与安全性相关的关键特征，能否真正用于提升模型安全性。前路依然漫长，亟待探索的工作还有很多。

For full details, please read our paper, " [Scaling Monosemanticity: Extracting Interpretable Features from Claude 3 Sonnet](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)".

欲了解全部技术细节，请参阅我们的论文：[《扩展单义性：从 Claude 3 Sonnet 中提取可解释特征》](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)

_If you are interested in working with us to help interpret and improve AI models, we have open roles on our team and we’d love for you to apply. We’re looking for [Managers](https://boards.greenhouse.io/anthropic/jobs/4009173008), [Research Scientists](https://boards.greenhouse.io/anthropic/jobs/4020159008), and [Research Engineers](https://boards.greenhouse.io/anthropic/jobs/4020305008)._

_若您有兴趣加入我们，共同推进 AI 模型的可解释性研究与安全性提升，我们团队目前正开放多个职位，诚挚欢迎您的申请！我们正在招聘 [团队负责人（Managers）](https://boards.greenhouse.io/anthropic/jobs/4009173008)、[研究科学家（Research Scientists）](https://boards.greenhouse.io/anthropic/jobs/4020159008) 和 [研究工程师（Research Engineers）](https://boards.greenhouse.io/anthropic/jobs/4020305008)。_

## Policy Memo

## 政策备忘录

[Mapping the Mind of a Large Language Model](https://cdn.sanity.io/files/4zrzovbb/website/e2ae0c997653dfd8a7cf23d06f5f06fd84ccfd58.pdf)

[绘制大型语言模型的思维图谱](https://cdn.sanity.io/files/4zrzovbb/website/e2ae0c997653dfd8a7cf23d06f5f06fd84ccfd58.pdf)
{% endraw %}
