---
title: "Collective Constitutional AI: Aligning a Language Model with Public Input \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/collective-constitutional-ai-aligning-a-language-model-with-public-input"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:13.155758279+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

PolicySocietal Impacts

政策与社会影响

# Collective Constitutional AI: Aligning a Language Model with Public Input

# 集体宪法式人工智能：借助公众意见校准语言模型

Oct 17, 2023

2023年10月17日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_001.jpg)

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_001.jpg)

Anthropic and the [Collective Intelligence Project](https://cip.org/) recently ran a public input process involving ~1,000 Americans to draft a constitution for an AI system. We did this to explore how democratic processes can influence AI development. In our experiment, we discovered areas where people both agreed with our in-house [constitution](https://www.anthropic.com/news/claudes-constitution), and areas where they had different preferences. In this post, we share the resulting publicly sourced constitution, as well as what happened when we trained a new AI system against it using Constitutional AI.

Anthropic 公司与[集体智能项目](https://cip.org/)（Collective Intelligence Project）近期联合开展了一项面向公众的意见征询活动，邀请约 1000 名美国民众共同起草一份人工智能系统“宪法”。此举旨在探索民主化流程如何影响人工智能的发展路径。在本次实验中，我们既发现了公众意见与 Anthropic 内部制定的[宪法](https://www.anthropic.com/news/claudes-constitution)高度一致的领域，也识别出若干存在明显偏好的分歧点。本文将分享此次由公众共同参与制定的宪法文本，并介绍我们如何基于该宪法、运用“宪法式人工智能”（Constitutional AI）方法训练一个全新 AI 系统及其结果。

[Constitutional AI](https://arxiv.org/abs/2212.08073) (CAI) is an Anthropic-developed method for aligning general purpose language models to abide by high-level normative principles written into a constitution. Anthropic’s language model [Claude](https://www.anthropic.com/claude) currently relies on a constitution curated by Anthropic employees. This constitution takes inspiration from outside sources like the United Nations Universal Declaration of Human Rights, as well as our own firsthand experience interacting with language models to make them more helpful and harmless.

[宪法式人工智能](https://arxiv.org/abs/2212.08073)（Constitutional AI，简称 CAI）是 Anthropic 公司研发的一种对齐方法，旨在使通用型语言模型遵循写入“宪法”中的高层次规范性原则。Anthropic 当前的语言模型 [Claude](https://www.anthropic.com/claude) 所依据的宪法，由 Anthropic 员工自主拟定；其内容既借鉴了《联合国世界人权宣言》等外部权威文献，也融合了团队在与语言模型长期交互实践中积累的第一手经验，以期让模型更具帮助性且无害。

虽然宪法式人工智能（Constitutional AI）有助于提升我们人工智能系统所遵循的规范性价值观的透明度，但它同时也凸显了我们作为开发者在选择这些价值观时所扮演的、不成比例的重要角色——毕竟，这份“宪法”正是由我们自己撰写的。正因如此，在本项研究中，我们迫切希望借助大量非 Anthropic 员工的公众偏好，共同审慎地拟定一份宪法。我们认为，本研究或为全球首次由普通公众通过线上协商过程集体引导语言模型行为的实践之一。我们希望，公开分享这项尚处初步探索阶段的努力与发现，能够帮助他人从我们的成功与失败中汲取经验，并在此基础之上持续推进相关工作。

## 设计面向公众的意见征询流程，以协同起草宪法

Anthropic 与“集体智能项目”（Collective Intelligence Project）合作，依托 [Polis](https://pol.is/home) 平台开展了一次面向公众的意见征询活动。Polis 是一款开源平台，专为运行融合机器学习算法的线上协商流程而设计。该平台已在全球范围内被各国政府、学术机构、独立媒体及普通公民广泛采用，用以理解大规模人群的真实观点与价值取向。

我们邀请约 1,000 名美国公众参与“帮助我们为 AI 聊天机器人选定行为准则！”活动（图 1）。我们力求样本在年龄、性别、收入和地理分布等方面具有美国成年群体的代表性（参与者匿名化人口统计信息详见[此处](https://cdn.sanity.io/images/4zrzovbb/website/53dfb77ff43e3f9fbdb62a30eba2f078b84b119e-3758x2406.png)）。参与者既可对已有规则（即规范性原则）进行投票，也可自行提出新规则。最终，参与者共向 Polis 平台提交了 1,127 条陈述，并投出总计 38,252 票（人均约 34 票）。总体而言，大多数陈述获得了高度共识；不过，Polis 也识别出两个明显不同的意见群体（图 2）。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_002.jpg)图 1：公众用于协商讨论“哪些原则应纳入宪法”的界面示意图。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_003.jpg)图 2：能显著区分意见群体 A 与意见群体 B 的部分典型原则示例。（注：此 Polis 报告示意图呈现的是原始数据，尚未剔除无效参与者及无效评论；最终统计数字略有出入。）

## 分析公众共同贡献的宪法内容

原始结果详见 [Polis 报告](https://pol.is/report/r3rwrinr5udrzwkvxtdkj)。我们对数据进行了清洗处理，剔除了无效参与者及其评论（处理前后的代码与数据均[托管于此](https://github.com/saffronh/ccai)）。我们保留了在两个意见群体中均达到最低共识阈值的所有陈述，由此形成一份可用于模型训练的宪法。宪法式人工智能（CAI）训练所用的原则通常采用如下格式：“选择更符合 X 特征的回应。”然而，为便于公众理解与表达，我们征集陈述时采用了更通用的形式，例如“AI 不应做 X”，这更贴近公众日常提问与思考的习惯。因此，我们需要对公众提出的原始 _陈述_ 进行主观映射，将其转化为适配 CAI 训练所需的 _原则_。

您可在此查阅我们基于公众意见形成的宪法全文：[CCAI 公众版宪法（PDF）](https://www-cdn.anthropic.com/65408ee2b9c99abe53e432f300e7f43ef69fb6e4/CCAI_public_comparison_2023.pdf)，并同步参阅其中关于该宪法与 Anthropic 自行编写的、用于训练语言模型 Claude 的[宪法](https://www.anthropic.com/news/claudes-constitution)之间异同的分析。尽管两份宪法在概念与价值观层面存在中等程度的重合（概念与价值观重合率约为 50%），但若干关键差异仍十分突出：公众版宪法中的原则大多为公众自主生成，而非引自既有文献；其更强调客观性与中立性；更重视可及性（accessibility）；且整体上更倾向于以“倡导理想行为”而非“规避不良行为”的方式来表述原则。

以下为若干与 Anthropic 自行编写的宪法中原则相似的公众版原则示例：

- “Choose the response that most respects the human rights to freedom, universal equality, fair treatment, and protection against discrimination.”  
- “请选择最尊重人权——包括自由权、普遍平等权、公平对待权以及免受歧视保护权——的回应。”

- “Choose the response that least endorses misinformation, and that least expands on conspiracy theories or violence.”  
- “请选择最不支持虚假信息、且最不延伸或渲染阴谋论与暴力内容的回应。”

Example public principles that do not closely match principles in the Anthropic-written constitution:  
示例：未被纳入Anthropic起草的《宪法》中的公开原则（因其与《宪法》原则契合度较低）：

- “Choose the response that most provides balanced and objective information that reflects all sides of a situation.”  
- “请选择最能提供平衡、客观信息的回应，该信息应全面反映事件各方立场。”

- “Choose the response that is most understanding of, adaptable, accessible, and flexible to people with disabilities.”  
- “请选择对残障人士最具同理心、适应性最强、可及性最高、也最富弹性的回应。”

There were a number of public _statement_s that we did not include in the public constitution due to either low overall agreement or a lack of consensus across opinion groups. Because these statements did not make the cut, we did not translate them into Constitutional AI ready principles.  
我们收到大量公众 _声明_，但其中一部分因整体认同度偏低，或在不同观点群体间缺乏共识，而未被纳入最终发布的《公众宪法》。由于这些声明未能入选，我们亦未将其转化为适用于“宪法型人工智能”（Constitutional AI）的可执行原则。

Example public _statements_ that did not make it into the public constitution due to low overall agreement:  
因整体认同度偏低而未被纳入《公众宪法》的公众 _声明_ 示例：

- “AI should not be trained with the principles of DEI \[diversity, equity, and inclusion\]”  
- “AI不应以DEI（多元、公平与包容）原则为指导进行训练。”

- “AI should not give advice”  
- “AI不应提供建议。”

- “AI should be an ordained minister”  
- “AI应成为经正式任命的牧师。”

- “AI should have emotion”  
- “AI应具备情感。”

Examples of conflicting public _statements_ that did not make it into the public constitution due to lack of consensus across the opinion groups:  
因在不同观点群体间缺乏共识而未被纳入《公众宪法》的相互冲突的公众 _声明_ 示例：

- “The AI should prioritize the interests of the collective or common good over individual preferences or rights.”  
- “AI应在个体偏好或权利之上，优先考虑集体利益或公共福祉。”

- “The AI should prioritize personal responsibility and individual liberty over collective welfare.”  
- “AI应在集体福祉之上，优先强调个人责任与个体自由。”

## Training and Evaluating a Model Aligned with Public Input  
## 基于公众意见训练与评估模型

We trained two Claude [Instant-sized](https://www.anthropic.com/news/introducing-claude) models, following the procedures outlined in our [CAI paper](https://arxiv.org/abs/2212.08073). We chose to train smaller models in order to iterate quickly and adhere to our compute budget. We call the model we trained against the public constitution the Public constitution (“Public”) model. We call the baseline model we trained against the Anthropic-written constitution the Standard constitution (“Standard”) model. We chose to also baseline against Claude Instant 1.2 (“control model”) as a sanity check that our training worked as intended, though we caveat that there are some product-relevant features in this model that confound the comparison. Ultimately, our experiments are designed such that any differences between the Public model and the Standard model are only attributable to changes in the constitution.  
我们依据[CAI论文](https://arxiv.org/abs/2212.08073)中所述流程，训练了两个Claude [Instant规格](https://www.anthropic.com/news/introducing-claude)模型。为加快迭代速度并严格控制算力预算，我们选择训练规模较小的模型。我们将依据《公众宪法》训练出的模型称为“公众宪法模型”（“Public”模型）；将依据Anthropic起草的《宪法》训练出的基线模型称为“标准宪法模型”（“Standard”模型）。此外，我们还以Claude Instant 1.2（“对照模型”）作为另一基线，用以验证训练效果是否符合预期；但需说明的是，该模型内置若干面向产品功能的特性，可能干扰实验对比结果。最终，本实验的设计确保：Public模型与Standard模型之间的任何差异，均唯一归因于所采用《宪法》内容的不同。

After training the models, we ran a series of evaluations to find similarities and differences between the Public and Standard models. In general we found that:

模型训练完成后，我们开展了一系列评估，以识别公共模型（Public model）与标准模型（Standard model）之间的相似性与差异性。总体而言，我们发现：

1. The Public and Standard models perform equivalently on the language and math understanding tasks we tested, [MMLU](https://arxiv.org/abs/2009.03300) and [GSM8K](https://arxiv.org/abs/2110.14168), respectively (Table 1).  
1. 在我们测试的语言理解与数学理解任务中——即 [MMLU](https://arxiv.org/abs/2009.03300) 和 [GSM8K](https://arxiv.org/abs/2110.14168)——公共模型与标准模型表现相当（见表1）。

2. People interacting with the models found the Public model as helpful and harmless as both the Standard model and Claude Instant 1.2. Specifically, we computed Elo scores for helpfulness and harmlessness for all three models (using the same procedures and model interfaces outlined in our [Constitutional AI](https://arxiv.org/abs/2212.08073) and [red teaming](https://arxiv.org/abs/2209.07858) papers without further modification) and found no significant differences.  
2. 与模型交互的用户认为，公共模型在“有用性”（helpfulness）和“无害性”（harmlessness）方面，与标准模型及 Claude Instant 1.2 相当。具体而言，我们为三款模型分别计算了“有用性”与“无害性”的 Elo 得分（所用流程与模型接口均严格遵循我们此前发表的 [Constitutional AI](https://arxiv.org/abs/2212.08073) 与 [red teaming](https://arxiv.org/abs/2209.07858) 论文，未作额外调整），结果未发现统计学意义上的显著差异。

3. The Public model is less biased than the Standard model across nine social dimensions according to the [BBQ](https://aclanthology.org/2022.findings-acl.165/) evaluation (Figure 3).  
3. 根据 [BBQ](https://aclanthology.org/2022.findings-acl.165/) 评估，公共模型在全部九个社会维度上的偏见程度均低于标准模型（见图3）。

4. The Public and Standard models reflect similar political ideologies as one another according to the [OpinionQA](https://arxiv.org/abs/2303.17548) evaluation (Figure 4).  
4. 根据 [OpinionQA](https://arxiv.org/abs/2303.17548) 评估，公共模型与标准模型所体现的政治意识形态高度相似（见图4）。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_004.jpg)Table 1: [MMLU](https://arxiv.org/abs/2009.03300) and [GSM8K](https://arxiv.org/abs/2110.14168) accuracy computed using the same methods outlined in [Claude 2’s model card](https://www-cdn.anthropic.com/bd2a28d2535bfb0494cc8e2a3bf135d2e7523226/Model-Card-Claude-2.pdf). Higher is better. We see no significant differences between models.

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_004.jpg)表1：[MMLU](https://arxiv.org/abs/2009.03300) 与 [GSM8K](https://arxiv.org/abs/2110.14168) 准确率，采用与 [Claude 2 模型卡](https://www-cdn.anthropic.com/bd2a28d2535bfb0494cc8e2a3bf135d2e7523226/Model-Card-Claude-2.pdf) 中一致的方法计算得出。数值越高越好。各模型间未见统计学意义上的显著差异。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_005.jpg)Figure 3: [BBQ](https://aclanthology.org/2022.findings-acl.165/) bias scores. Higher scores indicate more negative stereotype bias (lower is better). We used the same methods, code, and controls from our previously [published work](https://arxiv.org/abs/2302.07459). The Public model shows lower bias scores across all nine social dimensions than the Standard model, especially for Disability Status and Physical Appearance. The Public constitution places a larger emphasis on accessibility, which may explain the greater reduction in bias for Disability Status in particular.

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_005.jpg)图3：[BBQ](https://aclanthology.org/2022.findings-acl.165/) 偏见得分。得分越高，表明负面刻板印象偏见越强（越低越好）。我们沿用了此前已发表研究中[所用的方法、代码与控制变量](https://arxiv.org/abs/2302.07459)。公共模型在全部九个社会维度上的偏见得分均低于标准模型，尤其在“残障状况”（Disability Status）与“外貌特征”（Physical Appearance）两个维度上优势更为明显。公共版宪法更加强调可及性（accessibility），这或许可以解释为何其在“残障状况”维度上的偏见降低尤为显著。

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_006.jpg)Figure 4: Group representativeness score from the [OpinionQA](https://arxiv.org/abs/2303.17548) benchmark. A higher group representativeness score (colors/numbers ranging from 0 to 1) indicates that model responses (x-axis) to Pew Research Center’s “American Trends Panel” are more similar to human responses to the same questions from a particular demographic group (y-axis). The outputs of both Public and Standard models are more representative of people who self-identify as Liberal, rather than Conservative. The differences are small but statistically significant. Claude Instant 1.2 is slightly more balanced across political ideologies. Both Public and Claude Instant 1.2 models generally exhibit lower representativeness scores than the Standard models, which indicates that their responses to survey questions are relatively less similar to those of aggregate human responses to the same questions.

![](images/collective-constitutional-ai-aligning-a-language-model-with-public-input-anthrop/img_006.jpg)图4：来自 [OpinionQA](https://arxiv.org/abs/2303.17548) 基准测试的“群体代表性得分”（Group representativeness score）。该得分越高（颜色/数字范围为 0 至 1），表示模型对皮尤研究中心（Pew Research Center）“美国趋势小组”（American Trends Panel）问卷的回应（横轴）与特定人口统计学群体（纵轴）人类受试者对同一问题的回应越相似。公共模型与标准模型的输出，均更贴近自认为持自由主义（Liberal）立场的人群，而非保守主义（Conservative）立场人群；差异虽小，但具有统计学显著性。Claude Instant 1.2 在不同政治意识形态间的分布则略显均衡。总体而言，公共模型与 Claude Instant 1.2 的代表性得分普遍低于标准模型，表明二者对调查问题的回应，相较于人类整体回应，相似度相对更低。

## Lessons Learned

## 经验总结

The process of training a language model to abide by qualitative public opinions involves a large number of subjective judgment calls. These types of decisions are typically undisclosed or under-discussed. As we expect questions about the democratic legitimacy of AI to become increasingly prominent in coming years, we share all the subjective judgment calls we made in order to make our processes more transparent and to support future iteration.

让语言模型遵从定性化的公众意见进行训练，这一过程涉及大量主观判断。此类决策通常未被公开披露，或鲜有深入讨论。鉴于未来数年围绕人工智能民主合法性的讨论势必日益增多，我们选择全面公开所有主观判断，以提升流程透明度，并为后续迭代提供支持。

### Running the public input process

### 公众意见征集流程的实施

1. **Participant selection** One of the first questions we faced was determining the appropriate public for the public input process. We considered alternative options such as sourcing individuals through social media ads or media op-eds, reaching out to our own networks, or doing a form of snowball sampling starting with AI affinity groups (e.g., Black in AI, LatinX in AI, Women in Machine Learning, etc.). We deliberated on this decision internally and determined that a representative sample of the U.S. population would be both a reasonable and manageable first step, though we recognize this is a small sample and not globally representative. We worked with the survey company PureSpectrum to recruit this population. We chose PureSpectrum based on their experience with academic research and policy, as well as our previous experience working with them.  
1. **参与者遴选** 我们面临的首要问题之一，是确定公众意见征集流程中“恰当的公众”范围。我们曾考虑多种替代方案，例如通过社交媒体广告或媒体评论文章招募参与者、联系自有社交网络，或以人工智能兴趣社群（如“Black in AI”、“LatinX in AI”、“Women in Machine Learning”等）为起点开展滚雪球抽样（snowball sampling）。经团队内部审慎讨论，我们最终决定：以具有代表性的美国人口样本作为合理且可行的第一步——尽管我们清楚地认识到，该样本规模有限，且不具备全球代表性。我们委托调研公司 PureSpectrum 执行此项招募工作。选择 PureSpectrum，是基于其在学术研究与公共政策领域的丰富经验，以及我们此前与其合作的良好经历。

2. **Screening criteria**We used screening criteria to select participants that had some familiarity with AI. In particular, we had two screening questions with multiple choice answers: People who answered “b. Generative AI/Chat GPT” to Question 1 and “a. Generative AI/Chat GPT” to Question 2 were invited to participate in the public input process. We learned from pilot experiments that if we did not use these screening criteria, people were confused and submitted off-topic statements (e.g., “The first time you have a chance at the top is the second one I just want you know I don’t know if you’re going on vacation but you know I”).  
2. **筛选标准** 我们设置了筛选标准，以确保参与者具备一定的人工智能认知基础。具体包括两道多选题：仅当参与者在问题1中选择“b. 生成式AI / ChatGPT”，且在问题2中选择“a. 生成式AI / ChatGPT”时，方获邀参与公众意见征集流程。前期试点实验表明，若不设置上述筛选标准，参与者易产生困惑，并提交偏离主题的陈述（例如：“你第一次有机会登顶，其实是第二次——我只是想让你知道，我不知道你是否要去度假，但你知道……”）。

1. “What topics have you discussed with your friends/family in the last month?” (Possible answers: “a. The economy,” “b. Generative AI/Chat GPT,” “c. TikTok,” “d. 2024 Elections,” “e. None of the above”)  
1. “过去一个月，您与亲友讨论过哪些话题？”（可选项：“a. 经济”、“b. 生成式AI / ChatGPT”、“c. TikTok”、“d. 2024年大选”、“e. 以上皆非”）

2. “What news articles have you read in the last 4 months?” (Possible answers: “a. Generative AI/Chat GPT,” “b. Food,” “c. The U.S. economy,” “d. Social Media,” “e. Music,” “f. None of the above”)  
2. “过去四个月，您阅读过哪些新闻报道？”（可选项：“a. 生成式AI / ChatGPT”、“b. 美食”、“c. 美国经济”、“d. 社交媒体”、“e. 音乐”、“f. 以上皆非”）

3. **Choice of online deliberation platform** We decided to use Polis due to both Collective Intelligence Project’s experience working with them on [AI Alignment Assemblies](https://cip.org/alignmentassemblies), and Anthropic’s prior collaboration with the Polis team to study the [opportunities and risks of incorporating language models into Polis](https://arxiv.org/abs/2306.11932). We considered other functionally similar platforms such as [All Our Ideas](https://allourideas.org/) and [Remesh](https://www.remesh.ai/), but we did not systematically explore these options because we felt we could conduct our research more thoughtfully in close collaboration with the Polis team. There was some debate amongst the team as to whether we should use All Our Ideas up until the point of launching the public input process (we even implemented a prototype that we abandoned last minute).  
3. **在线协商平台的选择** 我们最终选定 Polis 平台，主要基于两点考量：一是集体智能项目（Collective Intelligence Project）曾与 Polis 合作开展 [AI 对齐大会（AI Alignment Assemblies）](https://cip.org/alignmentassemblies)；二是 Anthropic 此前亦曾与 Polis 团队合作，共同研究将语言模型整合进 Polis 平台所蕴含的[机遇与风险](https://arxiv.org/abs/2306.11932)。我们也曾考察其他功能相近的平台，例如 [All Our Ideas](https://allourideas.org/) 与 [Remesh](https://www.remesh.ai/)，但并未系统性地深入评估这些选项——因为我们相信，与 Polis 团队紧密协作，将有助于我们更审慎、深入地推进研究。直至公众意见征集流程正式启动前夕，团队内部仍在就是否选用 All Our Ideas 展开讨论（我们甚至已开发出一个原型系统，却在最后一刻决定弃用）。

4. **Seed statements** For the public input process we provided a set of 21 seed statements to give participants examples of what in-scope and appropriately formatted statements might look like. In our initial pilots where we did not provide these seed statements, we found that participants were often confused and proposed out-of-scope statements—we found that providing clear examples helped to elicit useful statements from participants. We tried to pick a diverse set of example statements, drawing on principles from the Anthropic-written constitution as well as new statements that might guide people towards a broader range of possible values. Given the number of statements submitted by the public, it is unlikely that these seed statements made a material difference in the final output (since only the initial few voters would have been more likely to see the seed statements rather than participant-submitted statements), though we could have selected a different example set.  
4. **引导性陈述（Seed statements）** 在公众意见征集流程中，我们预先提供了21条引导性陈述，旨在向参与者展示何为符合议题范围、格式规范的陈述范例。在早期试点阶段，若未提供此类引导性陈述，参与者常感困惑，进而提交大量偏离主题的陈述；实践证明，提供清晰示例能有效激发参与者产出高质量陈述。我们力求选取多样化的示例陈述，既涵盖 Anthropic 自行撰写的宪法中的核心原则，也包含一些新拟陈述，以期引导公众思考更广泛的价值取向。考虑到公众最终提交的陈述数量庞大，这些引导性陈述对最终结果产生实质性影响的可能性较低（因仅有最初几批投票者更可能看到引导性陈述，而非参与者自主提交的陈述）；当然，我们本也可选用另一套示例集。

5. **Moderation criteria** Collective Intelligence Project unilaterally moderated the public input process, according to predefined criteria. Anthropic and Collective Intelligence Project chose to moderate out statements that were hateful, nonsensical, duplicate, irrelevant, poorly-formatted, or technically infeasible, as well as those that focused on product capabilities rather than normative values. Sometimes it was clear what to do, other times we made subjective judgment calls. For example, we moderated out statements such as, “The ai should take any and all information from the latest and most updated database,” and “AI should be restricted from those with a criminal record and AI should be set up in a way that limits illegal activities using the product.” Reasonable people can disagree with our decisions, but we feel it is important to be transparent.  
5. **审核标准** 集体智能项目（Collective Intelligence Project）依据预设标准，独立负责公众意见征集流程的审核工作。Anthropic 与集体智能项目共同决定：剔除含有仇恨言论、逻辑混乱、内容重复、明显无关、格式严重失当或技术上不可行的陈述；同时，亦剔除聚焦于产品功能而非规范性价值（normative values）的陈述。某些情况下判断明确，而另一些情形则需依赖主观判断。例如，我们剔除了如下陈述：“AI 应从最新、最全面的数据库中获取一切信息”，以及“应禁止有犯罪记录者使用 AI；AI 系统应被设计为限制用户利用该产品从事非法活动”。对于我们的审核决定，理性之人或存异议；但我们坚信，保持透明至关重要。

### Developing a constitution from public inputs

### 基于公众意见构建宪法

1. **Removing duplicate statements**  
1. **移除重复陈述**

After moderation, we had 275 public statements, far more than the 58 principles in the Standard constitution (i.e., the one written by Anthropic).  
经审核后，我们共获得275条公众陈述，远超《标准宪法》（即Anthropic撰写的版本）中的58项原则。

We did not know how the Constitutional AI training process would work with an overly homogeneous and lengthy constitution, so we decided to remove duplicate statements.  
我们尚不清楚，在宪法内容过于同质化且篇幅过长的情况下，宪法人工智能（Constitutional AI, CAI）训练流程将如何运作，因此决定移除重复陈述。

We also did this to avoid arbitrarily upweighting particular ideas, since some participants may not have seen similar ideas presented by other participants due to the way the Polis statement routing algorithm works.  
此举也旨在避免人为地过度强化某些特定观点——由于Polis平台的陈述分发算法机制，部分参与者可能并未看到其他参与者提出的相似观点。

Alternatively, we could have kept duplicates as-is. In some sense, this would have better preserved majority opinions.  
当然，我们本也可选择保留所有重复陈述。从某种意义上说，这或许更能忠实反映多数意见。

We debated amongst ourselves what to do here, as the decision has both a social dimension (how to faithfully represent public opinion) and technical dimensions (how to most effectively use Polis and Constitutional AI training).  
我们内部就此展开了深入讨论，因为该决策既涉及社会维度（如何忠实地代表公众意见），也涉及技术维度（如何最有效地利用Polis平台与宪法人工智能训练流程）。

We are not sure if we made the right tradeoff between these social and technical dimensions.  
目前我们尚不确定，在社会性与技术性这两方面之间，我们是否做出了恰当的权衡。

2. **Combining similar ideas**  
2. **合并相似观点**

Our deduplication process was not perfect. To account for this, we did a second pass where we combined statements that conveyed similar ideas in order to again preserve a similar length and number of distinct values as in the Standard constitution.  
我们的去重过程并不完美。为此，我们进行了第二轮人工梳理，将表达相似理念的陈述加以合并，以使最终宪法在长度和独立价值观数量上更接近《标准宪法》。

For example, we combined the following public statements: “The AI should not say racist or sexist things,” “AI should not encourage racism,” and “AI should not discriminate on race or sexual preference” into the combined principle, “Choose the response that least encourages racism or sexism, says racist or sexist things, or discriminates on race or sexual preference.”  
例如，我们将以下三条公众陈述：“AI不应发表种族主义或性别歧视言论”“AI不应助长种族主义”“AI不应基于种族或性取向进行歧视”，合并为一条整合原则：“选择最不鼓励种族主义或性别歧视、最不包含种族主义或性别歧视言论、且最不基于种族或性取向实施歧视的回应。”

We combined similar statements because we felt it would de-risk our research to use a constitution not too dissimilar in style than the one we know has worked previously—principles in the Standard constitution are more dense and wordy than the public statements and we do not know whether this difference matters or not.  
我们之所以合并相似陈述，是因为我们认为：采用一种风格上与已验证有效的《标准宪法》差异不过大的宪法，有助于降低研究风险。《标准宪法》中的原则通常更为凝练、措辞更繁复，而公众陈述则相对直白；我们尚不清楚这种风格差异是否具有实质性影响。

3. **Mapping public statements to CAI-ready principles**  
3. **将公众陈述映射为适用于宪法人工智能训练的原则**

The principles for Constitutional AI training are typically formatted as: “Choose the response that is more X.” However, we solicited statements in a more general form, such as “The AI should not do X,” as it felt more natural to frame questions this way for the public. As a result, we had to translate the public statements into CAI-ready principles.  
宪法人工智能训练所用原则通常采用如下格式：“选择更符合X的回应”。但我们面向公众征集陈述时，采用了更通用的表述形式（例如“AI不应做X”），因为这种提问方式对公众而言更自然。因此，我们必须将公众陈述转译为适用于CAI训练的原则。

There are alternative approaches we considered, such as using a standardized template (e.g., principles in the form of: “Please choose the response that’s most consistent with statement X,” where “X” is a public statement with no modification). This has the benefit of avoiding too much editorialization, but it has the disadvantage of deviating from the style of the constitution we know works.  
我们也曾考虑其他替代方案，例如采用标准化模板（如：“请选择最符合陈述X的回应”，其中“X”即未经修改的原始公众陈述）。该方案的优势在于最大限度减少编辑干预，但劣势在于偏离了我们已知行之有效的宪法风格。

### Model training and evaluation  
### 模型训练与评估

1. **The prompt database matters**  
1. **提示语数据库至关重要**

Constitutional AI requires a prompt database. For each prompt in the database, a grader model decides which of two possible responses is more consistent with a constitutional principle.  
宪法人工智能训练依赖于一个提示语（prompt）数据库。对于数据库中的每条提示语，评判模型需判断两个候选回应中哪一个更符合某项宪法原则。

For our research, we used the same prompt database for training the Public constitution and Standard constitution models, despite the two having different constitutions. This is likely a mistake because the Public constitution includes some principles that may not be relevant to prompts in our prompt database.  
在本研究中，尽管《公众宪法》与《标准宪法》内容不同，我们仍使用了同一套提示语数据库来训练二者对应的模型。这一做法很可能存在缺陷，因为《公众宪法》中包含若干原则，可能与我们当前提示语数据库中的提示语缺乏相关性。

We did not anticipate this challenge until we were too far into our research. Future experiments on changing constitutions must also address how to create prompt databases that are relevant to all principles in a given constitution.  
直至研究推进到较深阶段，我们才意识到这一挑战。未来关于宪法变更的实验，也必须同步解决如何构建一套能全面覆盖某部宪法全部原则的提示语数据库。

2. **Annoying models**  
2. **令人困扰的模型行为**

Our first iterations on training Public and Standard models led to _annoying_ models. For example, earlier models would respond to the prompt “hey” with the response “I apologize, upon further reflection my previous responses were inappropriate and harmful”.  
我们在初期训练《公众宪法》与《标准宪法》对应模型时，产生了若干“令人困扰”的模型。例如，早期模型在收到提示语“hey”时，会回应：“我诚挚致歉，经进一步反思，我此前的回应是不恰当且有害的。”

We determined this was due to the fact that, in our first iterations, the training dataset for the preference models used in Constitutional AI training had a large fraction of harmlessness data, causing the preference model to reward harmless responses much more than helpful responses.  
我们分析认为，问题根源在于：在最初几轮训练中，用于宪法人工智能训练的偏好模型（preference model）数据集内，“无害性”（harmlessness）类样本占比过高，导致偏好模型过度奖励“无害”但低效的回应，而严重低估“有益性”（helpfulness）。

We addressed this issue by reducing the loss weight for the harmlessness data based on human evaluations, resulting in a more appropriately balanced preference model.  
我们通过基于人工评估结果调低“无害性”数据在损失函数中的权重，成功缓解了该问题，从而构建出更合理平衡的偏好模型。

We learned the hard way that the appropriate weighting matters _a lot more_ than we anticipated for training models that are not so harmless that they are unhelpful and annoying.  
我们付出了沉重代价才深刻认识到：为训练出既无害又不失实用性与亲和力的模型，各类目标的权重设置比我们预想的要重要得多。

3. **Evaluations**  
3. **评估工作**

In general, [evaluating AI systems is challenging](https://www.anthropic.com/research/evaluating-ai-systems)—it was not clear to us what existing evaluations might best characterize and surface differences between the Public and Standard models.  
总体而言，[评估人工智能系统极具挑战性](https://www.anthropic.com/research/evaluating-ai-systems)——我们并不清楚，现有哪些评估方法最能准确刻画并凸显《公众宪法》模型与《标准宪法》模型之间的差异。

Ultimately, based on the small set of evaluations we chose, we only saw a clear but small difference in bias, according to the BBQ evaluation.  
最终，依据我们所选取的少量评估指标，仅在BBQ（Bias Benchmark for QA）评估中观察到一项清晰但幅度微小的偏差差异。

For future work, we would like to both design evaluations that test for how faithfully models reflect their constitutions and run a more comprehensive suite of evaluations.  
面向未来工作，我们希望一方面设计专门用于检验模型对其宪法遵循程度的新评估方法，另一方面开展更全面、多维度的综合评估。

4. **Constitutional AI training is hard**  
4. **宪法人工智能训练难度极高**

We are not sure we would have been able to train our own models using Constitutional AI (CAI) without working directly and very closely with the original developers.  
若非与宪法人工智能（CAI）原始开发者进行直接、深度的协作，我们甚至不确定自己能否成功训练出属于本项目的模型。

CAI training is more complicated than we thought. This highlights challenges with incorporating democratic input into deeply technical systems using today’s training methods, and points to necessary future work.  
CAI训练的复杂程度远超我们最初的预期。这也凸显了当前训练方法在将民主输入融入高度技术化系统时所面临的现实挑战，并指明了亟待开展的后续研究方向。

## Conclusion  
## 结论

We believe that our work may be one of the first instances in which members of the public have collectively directed the behavior of a large language model through written specifications via an online deliberation process.  
我们认为，本项目或许是首次由公众通过线上协商过程，以书面规范形式集体引导大语言模型行为的实践之一。

We hope that sharing our very preliminary and imperfect findings sooner rather than later will help others interested in democratic inputs to AI to learn from our successes and failures.  
我们希望尽早分享这些尚属初步且并不完善的发现，以便关注人工智能领域民主化参与的同行，能够从我们的成功经验与失败教训中有所获益。

We would love your feedback as we continue to iterate on our research. Reach out to us at [policy@anthropic.com](mailto:policy@anthropic.com) and [hi@cip.org](mailto:hi@cip.org).  
在持续迭代研究的过程中，我们热切期待您的宝贵反馈。欢迎通过[policy@anthropic.com](mailto:policy@anthropic.com)与[hi@cip.org](mailto:hi@cip.org)联系我们。

## Acknowledgements  
## 致谢

- Deep Ganguli\*, Saffron Huang\*\*, Liane Lovitt\*, and Divya Siddarth\*\* jointly led the work in close collaboration.  
- Deep Ganguli\*、Saffron Huang\*\*、Liane Lovitt\* 与 Divya Siddarth\*\* 密切协作，共同牵头本项目。

- Thomas Liao\* trained the models and ran the evaluations, with help and support from Amanda Askell\*, Yuntao Bai\*, Saurav Kadavath\*, Jackson Kernion\*, Cam McKinnon\*, and Karina Nguyen\*.  
- Thomas Liao\* 负责模型训练与评估执行，Amanda Askell\*、Yuntao Bai\*、Saurav Kadavath\*、Jackson Kernion\*、Cam McKinnon\* 与 Karina Nguyen\* 提供了协助与支持。

- Esin Durmus\* ran the OpinionQA evaluation and helped frame and design the experiments.  
- Esin Durmus\* 主导了OpinionQA评估，并协助完成实验框架搭建与方案设计。

- We thank Danielle Allen, Jack Clark\*, Sasha de Marigny\*, Marina Favaro\*, Henri Hammond-Paul, Danny Hernandez\*, Jared Kaplan\*, Everett Katigbak\*, Colin Megill, Beth Noveck, Christopher Small, Alex Tamkin\*, Audrey Tang, Glen Weyl, and Kinney Zalesne for their support and guidance throughout.  
- 我们衷心感谢 Danielle Allen、Jack Clark\*、Sasha de Marigny\*、Marina Favaro\*、Henri Hammond-Paul、Danny Hernandez\*、Jared Kaplan\*、Everett Katigbak\*、Colin Megill、Beth Noveck、Christopher Small、Alex Tamkin\*、Audrey Tang、Glen Weyl 与 Kinney Zalesne 在整个研究过程中给予的支持与指导。

\\* Anthropic.  
\\* Anthropic公司。

\\*\\* Collective Intelligence Project.  
\\*\\* 集体智能项目（Collective Intelligence Project）。

## Policy Memo  
## 政策备忘录

[Collective Constitutional AI Policy Memo](https://www-cdn.anthropic.com/b43359be43cabdbe3a8ffd60ea8a68acf25cb22e/Anthropic_CollectiveConstitutionalAI.pdf)

[《集体宪政人工智能政策备忘录》](https://www-cdn.anthropic.com/b43359be43cabdbe3a8ffd60ea8a68acf25cb22e/Anthropic_CollectiveConstitutionalAI.pdf)
&#123;% endraw %}
