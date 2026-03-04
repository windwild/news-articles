---
title: "Constitutional Classifiers: Defending against universal jailbreaks"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/constitutional-classifiers"
scraped_at: "2026-03-02T09:21:16.169543408+00:00"
language: "en-zh"
translated: true
description: "A paper from Anthropic describing a new way to guard LLMs against jailbreaking"
---
{% raw %}

Alignment

对齐

# Constitutional Classifiers: Defending against universal jailbreaks

# 宪法式分类器：抵御通用越狱攻击

Feb 3, 2025

2025年2月3日

#### Footnotes

#### 脚注

1This capability threshold refers to systems that have the ability to significantly help individuals or groups with basic technical backgrounds (e.g., undergraduate STEM degrees) create/obtain and deploy CBRN weapons and therefore could present a substantially higher risk of catastrophic misuse compared to non-AI baselines (e.g., search engines or textbooks).

1该能力阈值指那些能够显著协助具备基础技术背景（例如本科理工科学位）的个人或团体研制、获取并部署化学、生物、放射性及核（CBRN）武器的系统；因此，相较于非AI基线系统（如搜索引擎或教科书），此类系统引发灾难性滥用的风险将显著更高。

2We considered a participant to be “active” if they made at least 15 queries to the system and were blocked by our classifiers at least 3 times.

2若某参与者向系统提交了至少15次查询，且被我们的分类器拦截至少3次，则我们认为其为“活跃”参与者。

3We filtered for participants who passed at least one question in the demo to better understand how well our system performed against red teamers with jailbreaking experience. When considering all users, our demo was tried by 13,960 users who made more than 800,000 chats and spent an estimated 10K+ hours testing the system.

3我们筛选出在演示环节中至少答对一道题的参与者，以便更准确地评估本系统对抗具备越狱经验的红队人员的实际表现。若统计全部用户，该演示共吸引了13,960名用户参与，累计发起聊天超800,000轮，总测试时长估计超过10,000小时。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们在数千次 Claude.ai 对话中追踪了 11 种可观测行为，从而构建出“AI 流利度指数”（AI Fluency Index）——这一指标为衡量当今人类与 AI 协作水平提供了基准。

_A [new paper](https://arxiv.org/abs/2501.18837) from the Anthropic Safeguards Research Team describes a method that defends AI models against universal jailbreaks. A prototype version of the method was robust to thousands of hours of human red teaming for universal jailbreaks, albeit with high overrefusal rates and compute overhead. An updated version achieved similar robustness on synthetic evaluations, and did so with a 0.38% increase in refusal rates and moderate additional compute costs._

_Anthropic 安全防护研究团队（Anthropic Safeguards Research Team）发布了一篇[新论文](https://arxiv.org/abs/2501.18837)，提出一种可抵御“通用越狱攻击”（universal jailbreaks）的 AI 模型防护方法。该方法的原型版本在历经数千小时的人工红队测试（human red teaming）后，仍对通用越狱攻击保持稳健性；但其存在较高的过度拒绝率（overrefusal rates）和显著的计算开销。更新后的版本在合成评估（synthetic evaluations）中实现了相近的稳健性，仅使拒绝率上升 0.38%，并带来适中的额外计算成本。_

Large language models have extensive safety training to prevent harmful outputs. For example, we train Claude to refuse to respond to user queries involving the production of biological or chemical weapons.

大语言模型经过广泛的安全训练，以防止生成有害内容。例如，我们训练 Claude 拒绝回应涉及生物或化学武器制造的用户提问。

Nevertheless, models are still vulnerable to _jailbreaks_: inputs designed to bypass their safety guardrails and force them to produce harmful responses. Some jailbreaks flood the model with [very long prompts](https://www.anthropic.com/research/many-shot-jailbreaking); others modify the [style of the input](https://arxiv.org/abs/2412.03556), such as uSiNg uNuSuAl cApItALiZaTiOn. Historically, jailbreaks have proved difficult to detect and block: these kinds of attacks were [described over 10 years ago](https://arxiv.org/abs/1312.6199), yet to our knowledge there are still no fully robust deep-learning models in production.

然而，模型仍易受“越狱攻击”（_jailbreaks_）影响：即通过精心设计的输入绕过其安全防护机制，并迫使其输出有害内容。某些越狱手段向模型注入[极长提示词](https://www.anthropic.com/research/many-shot-jailbreaking)；另一些则篡改输入的[表达风格](https://arxiv.org/abs/2412.03556)，例如采用 uSiNg uNuSuAl cApItALiZaTiOn 这类非常规大小写形式。历史上，越狱攻击一直难以被有效识别与拦截：此类攻击早在[十多年前就已被描述](https://arxiv.org/abs/1312.6199)，但据我们所知，目前尚无任何深度学习模型能在实际生产环境中实现完全稳健的防御。

We’re developing better jailbreak defenses so that we can safely deploy increasingly capable models in the future. Under our [Responsible Scaling Policy](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy), we may deploy such models as long as we’re able to mitigate risks to acceptable levels through appropriate safeguards—but jailbreaking lets users bypass these safeguards. In particular, we’re hopeful that a system defended by Constitutional Classifiers could allow us to mitigate jailbreaking risks for models which have passed the CBRN capability threshold outlined in our Responsible Scaling Policy1.

我们正致力于开发更优的越狱防护机制，以便未来能安全部署能力日益增强的模型。根据我们的[负责任扩展政策](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy)，只要能通过适当的安全保障措施将风险控制在可接受水平，我们即可部署此类模型；但越狱攻击使用户得以绕过这些保障措施。尤其值得期待的是，由“宪法分类器”（Constitutional Classifiers）提供防护的系统，有望帮助我们缓解已突破我方《负责任扩展政策》中设定的“核生化辐射（CBRN）能力阈值”的模型所面临的越狱风险¹。

In [**our new paper**](https://arxiv.org/abs/2501.18837), we describe a system based on _Constitutional Classifiers_ that guards models against jailbreaks. These Constitutional Classifiers are input and output classifiers trained on synthetically generated data that filter the overwhelming majority of jailbreaks with minimal over-refusals and without incurring a large compute overhead.

在[**我们的新论文**](https://arxiv.org/abs/2501.18837)中，我们介绍了一种基于“宪法分类器”（_Constitutional Classifiers_）的系统，用于防范模型越狱。这些宪法分类器是分别作用于输入与输出的分类器，其训练数据为人工合成生成；它们能够过滤掉绝大多数越狱请求，同时仅引发极少的过度拒绝，并且不会带来显著的计算开销。

## Results from human red teaming

## 人工红队测试结果

We ran two main categories of tests to assess the effectiveness of Constitutional Classifiers.

我们开展了两类主要测试，以评估宪法分类器的有效性。

First, we developed a prototype version of the system to identify and block specific scientific knowledge related to chemical, biological, radiological, and nuclear harms. We then invited independent jailbreakers to a [bug-bounty program](https://www.anthropic.com/news/model-safety-bug-bounty) in which they were challenged to “red team” the system (i.e., to attempt to break it under experimental conditions to test its robustness).

首先，我们开发了该系统的原型版本，旨在识别并屏蔽与化学、生物、放射性及核危害相关的特定科学知识。随后，我们邀请独立越狱研究者参与一项[漏洞赏金计划](https://www.anthropic.com/news/model-safety-bug-bounty)，挑战他们对系统开展“红队测试”（即在实验条件下尝试攻破系统，以检验其鲁棒性）。

Specifically, they were given a list of ten “forbidden” queries, and their task was to use whichever jailbreaking techniques they wanted in order to get one of our current models (in this case, Claude 3.5 Sonnet, June 2024) guarded by the prototype Constitutional Classifiers to answer all of the queries. We only considered it a successful “universal” jailbreak if the model provided a detailed answer to _all_ of the queries.

具体而言，他们获得了一份包含十个“禁止查询”的清单；其任务是运用任意越狱技术，促使我们当前某款模型（本例中为 Claude 3.5 Sonnet，2024 年 6 月版）——该模型已由宪法分类器原型版进行防护——对全部十个查询均给出回应。仅当模型对_所有_查询均提供了详尽回答时，我们才将其判定为一次成功的“通用型”越狱攻击。

183 名活跃参与者在为期两个月的实验期间，累计投入了超过 3,000 小时，尝试对模型实施越狱（jailbreak）。他们被告知：若成功发现一种“通用越狱”（universal jailbreak）方法，即可获得最高达 15,000 美元的现金奖励。尽管付出了巨大努力，但没有任何一名参与者能够仅凭单次越狱攻击，就诱使模型回答全部十个被禁止的查询——换言之，本次实验中并未发现任何通用越狱方法。

尽管该原型系统对越狱攻击展现出较强的鲁棒性，但仍存在两个问题：一是拒绝了过多无害的用户查询（即“过度拒绝”，overrefusal），二是运行时消耗大量计算资源。具备这两类问题的系统虽可能更安全，但实际部署可行性较低。此后，我们持续优化系统，在保持相近鲁棒性水平的同时，显著缓解了上述两类问题。

## 自动化评估结果

我们开展了一系列自动化评估实验：人工合成了 10,000 条越狱提示（jailbreaking prompts），其中既包含当前大语言模型（LLM）最有效的已知攻击方式，也包括专门设计用于绕过分类器防护机制的新型攻击。我们将这些提示分别提交给两个版本的 Claude 3.5 Sonnet（2024 年 10 月版）：一个受“宪法分类器”（Constitutional Classifiers）保护，另一个则未启用任何分类器。

在基线条件下（即不启用任何防御性分类器），越狱成功率高达 86%——这意味着 Claude 自身仅能拦截 14% 的此类高级越狱尝试。而当为 Claude 配备宪法分类器后，防御效果显著提升：越狱成功率大幅降至 4.4%，即超过 95% 的越狱尝试均被成功拒绝。

![一张图表，展示宪法分类器系统与基础模型在越狱漏洞性、过度拒绝率及计算开销三方面的对比结果](images/constitutional-classifiers-defending-against-universal-jailbreaks/img_001.jpg)  
_自动化评估结果。所有子图中，“数值越低越好”。（a）受宪法分类器保护的系统，其越狱成功率远低于基础模型；（b）在生产环境 Claude.ai 免费版与专业版的真实流量中，启用宪法分类器后系统的拒绝率并无统计学意义上的显著上升；（c）采用宪法分类器的系统，其相对计算开销仅适度增加。误差线表示基于二项比例标准误、在渐近正态性假设下计算所得的 95% 置信区间。_

与此同时，我们的宪法分类器并未显著提高对无害用户查询的过度拒绝率：启用分类器后，Claude 的拒绝率仅轻微上升 0.38%，但在随机抽取的 5,000 场对话样本中，该差异未达到统计学显著性水平。最后，该系统的计算开销较未加防护的基础模型仅适度增加（+23.7%）。随着技术持续迭代，我们正致力于进一步降低过度拒绝率与计算成本。

总体而言，我们的自动化分析表明：这一更新版的宪法分类器系统，极大提升了 AI 模型抵御越狱攻击的鲁棒性，且仅带来极小的额外开销。

## 工作原理

宪法分类器（Constitutional Classifiers）所依据的核心流程，与另一项我们已应用的技术——[宪法人工智能（Constitutional AI）](https://arxiv.org/abs/2212.08073)——高度相似；后者也是我们此前用于对齐 Claude 模型的重要方法之一（参见：[《Claude 的角色塑造》](https://www.anthropic.com/research/claude-character)）。这两种技术均依赖于一份“宪法”（constitution）：即一组模型应遵循的基本原则。在宪法分类器的语境下，这些原则明确定义了哪些类型的内容属于允许范畴、哪些属于禁止范畴（例如：芥末酱食谱是允许的，而芥子气制备方法则严格禁止）。

With the help of Claude, we use this constitution to generate a large number of synthetic prompts and synthetic model completions across all the content classes. We augment these prompts and completions to ensure a varied and diverse list: this includes translating them into different languages and transforming them to be written in the style of known jailbreaks.

借助 Claude 的帮助，我们利用该宪法生成覆盖所有内容类别的大量合成提示（synthetic prompts）和合成模型补全（synthetic model completions）。我们对这些提示和补全进行增强处理，以确保列表具备充分的多样性：包括将它们翻译成多种语言，并将其改写为已知越狱（jailbreak）手法的风格。

![A schematic diagram of the how the Constitutional Classifiers system works, from the creation of the constitution through to generating a test set to using the system to guard an LLM](images/constitutional-classifiers-defending-against-universal-jailbreaks/img_002.jpg)_Training and implementing Constitutional Classifiers. (a) A constitution is produced specifying harmless and harmful categories; (b) the constitution is used as the basis for the production of many synthetic prompts and completions, which are further augmented (with variations on style and language) and turned into a training set; (c) classifiers trained on this training set are used as model safeguards to detect and block harmful content._

![宪法分类器（Constitutional Classifiers）系统工作原理示意图：从宪法构建，到测试集生成，再到用于保护大语言模型（LLM）](images/constitutional-classifiers-defending-against-universal-jailbreaks/img_002.jpg)_宪法分类器的训练与部署。（a）制定宪法，明确无害与有害内容类别；（b）以该宪法为基础生成大量合成提示与合成补全，并进一步增强（例如在风格与语言上做多样化变体），最终构建成训练数据集；（c）在该训练集上训练所得的分类器，被用作模型安全防护机制，以检测并拦截有害内容。_

We then use these synthetic data to train our input and output classifiers to flag (and block) potentially harmful content according to the given constitution. To help minimize over-refusals (i.e., harmless content incorrectly flagged as harmful), we also train the classifiers on a fixed set of benign queries generated by a contractor.

随后，我们利用这些合成数据训练输入分类器与输出分类器，使其能够依据给定宪法识别（并拦截）潜在的有害内容。为减少“过度拒绝”（over-refusals）——即误将无害内容判定为有害——我们还使用由外包人员生成的一组固定良性查询（benign queries）对分类器进行联合训练。

## Limitations

## 局限性

Constitutional Classifiers may not prevent every universal jailbreak, though we believe that even the small proportion of jailbreaks that make it past our classifiers require far more effort to discover when the safeguards are in use. It’s also possible that new jailbreaking techniques might be developed in the future that are effective against the system; we therefore recommend using [complementary](https://arxiv.org/abs/2411.07494) [defenses](https://arxiv.org/abs/2411.17693). Nevertheless, the constitution used to train the classifiers can rapidly be adapted to cover novel attacks as they’re discovered.

宪法分类器未必能阻止全部通用越狱攻击（universal jailbreaks）；但我们相信，即便有少量越狱攻击成功绕过我们的分类器，其发现难度在防护机制启用后也将显著提高。此外，未来也可能出现针对本系统的新型越狱技术；因此，我们建议结合使用[互补性防御手段](https://arxiv.org/abs/2411.07494)与[其他防护方案](https://arxiv.org/abs/2411.17693)。不过，用于训练分类器的宪法本身具有高度灵活性，可快速适配、覆盖新近发现的攻击类型。

The [full paper](https://arxiv.org/abs/2501.18837) contains all the details about the Constitutional Classifiers method, and about the classifiers themselves.

[完整论文](https://arxiv.org/abs/2501.18837)详尽阐述了宪法分类器方法的技术细节，以及相关分类器的具体设计与实现。

## Constitutional Classifiers live demo

## 宪法分类器实时演示

Want to try red teaming Claude yourself? We invite you to try out a [demo of our Constitutional-Classifiers-guarded system](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/constitutional-classifiers) and attempt to jailbreak a version of Claude 3.5 Sonnet that is guarded using our new technique. **\[Edit 10 February 2025: The demo is now complete. See below for details\].**

您是否想亲自开展对 Claude 的红队测试（red teaming）？我们诚挚邀请您体验我们的[宪法分类器防护系统演示版](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/constitutional-classifiers)，尝试越狱一个受本新技术防护的 Claude 3.5 Sonnet 版本。**［更新于2025年2月10日：该演示现已结束。详情请见下文］**

Although the Constitutional Classifiers technique is flexible and can be adapted to any topic, we chose to focus on queries related to chemical weapons for the demo.

尽管宪法分类器技术具备高度灵活性，可适配任意主题，但在本次演示中，我们选择聚焦于与化学武器相关的查询。

Challenging users to attempt to jailbreak our product serves an important safety purpose: we want to stress-test our system under real-world conditions, beyond the testing we did for our paper. This allows us to gather additional data and improve the robustness of the method prior to deploying this method on our production systems in the future.

邀请用户尝试越狱我们的产品，具有重要的安全意义：我们希望在真实世界场景下对系统进行压力测试，超越论文中所完成的常规评估。此举有助于我们收集额外数据，从而在将来将该方法部署至生产系统之前，进一步提升其鲁棒性（robustness）。

The [**demo**](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/constitutional-classifiers) will be live from **Feb 3, 2025** to **Feb 10, 2025**.  
[**演示**](https://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835/constitutional-classifiers) 将于 **2025 年 2 月 3 日** 至 **2025 年 2 月 10 日** 期间开放。

It includes a feedback form where you can contact us to report any successful jailbreaks as well as information on our [Responsible Disclosure Policy](https://www.anthropic.com/responsible-disclosure-policy), which we ask that participants follow.  
演示中包含一份反馈表单，您可通过该表单联系我们，报告任何成功的越狱（jailbreak）行为；同时提供有关我们的 [负责任披露政策（Responsible Disclosure Policy）](https://www.anthropic.com/responsible-disclosure-policy) 的信息，我们要求所有参与者遵守该政策。

We’ll announce any successes and the general results of the demo in an update to this post.  
我们将在本帖的后续更新中公布所有成功案例及本次演示的整体结果。

## 13 February 2025 update: Live demo results  

## 2025 年 2 月 13 日更新：实时演示结果

The goal of our demo was to test our system’s robustness to _universal_ jailbreaks—prompting strategies that could elicit detailed, harmful information from the system across all eight questions that we provided.  
本次演示的目标是检验我们系统对 _通用型越狱（universal jailbreaks）_ 的鲁棒性——即测试那些能够针对我们所提供的全部八个问题、持续诱导系统输出详细且有害信息的提示词策略。

By the end of the demo, one jailbreaker was able to get detailed answers from the system for all eight questions using a universal jailbreak.  
截至演示结束，一名越狱者已成功利用一种通用型越狱方法，使系统就全部八个问题均给出了详细回答。

Our demo generated significant engagement from the AI security community, with 339 jailbreakers3 attempting to jailbreak our system across more than 300,000 chat interactions, representing approximately 3,700 collective hours of red-teaming effort.  
本次演示在 AI 安全社区引发了广泛关注：共有 339 名越狱者（注：原文为 “jailbreakers3”，疑为排版错误或笔误，此处按上下文译为“越狱者”并保留数字“3”作为脚注标记，但未提供对应脚注内容，故中文暂不添加脚注）参与尝试越狱，累计发起超 30 万次对话交互，总计投入约 3,700 小时的红队（red-teaming）测试工作量。

### Key findings  

### 关键发现

The system resisted jailbreaking attempts for five of the planned seven days. Until then, no participant was able to pass all eight levels of the challenge.  
在原计划为期七天的演示中，系统成功抵御了前五天的所有越狱尝试；在此期间，尚无任何参与者能通过全部八个挑战关卡。

On the sixth and seventh day, **four participants successfully cleared all levels.**  
第六天和第七天，**四名参与者成功通关全部八个关卡。**

Of these four, **one discovered what we determined to be a universal jailbreak**.  
在这四人中，**一人发现了一种被我们判定为通用型越狱的方法**。

Another participant found a jailbreak that we consider to be on the border of being universal because it required directly feeding in parts of the answer in order to pass the last question and also required nontrivial modifications to pass some other questions.  
另一名参与者发现了一种处于通用型越狱“边界线”上的越狱方法：该方法需将答案的部分内容直接输入以通过最后一题，且还需进行非平凡（nontrivial）的修改才能通过其他若干题目。

The remaining two participants obtained detailed answers to all 8 questions, but we determined that their jailbreaks did not meet the criteria for being considered _universal_ outlined in [our contest guidelines](https://hackerone.com/constitutional-classifiers?type=team).  
其余两名参与者虽也获得了全部 8 道题的详细答案，但我们判定其越狱方法不符合我们在 [竞赛指南](https://hackerone.com/constitutional-classifiers?type=team) 中所定义的 _通用型越狱_ 标准。

The most successful jailbreaking strategies included:  
最成功的越狱策略包括：

- Using various ciphers and encodings to circumvent the output classifier.  
  - 运用多种密码算法与编码方式，规避输出分类器（output classifier）的检测。  
- Employing role-play scenarios, often through system prompts.  
  - 采用角色扮演（role-play）场景，通常借助系统级提示词（system prompts）实现。  
- Substituting harmful keywords with innocuous alternatives (e.g., replacing “Soman” \[a dangerous chemical\] with “water”).  
  - 将有害关键词替换为无害替代词（例如，将危险化学品“梭曼”（Soman）替换为“水”（water））。  
- Implementing prompt-injection attacks.  
  - 实施提示词注入（prompt-injection）攻击。

![](images/constitutional-classifiers-defending-against-universal-jailbreaks/img_003.jpg)Bar graph showing the number of users that passed each level of the challenge. 339 users passed question 1, and only 4 users passed question 8.  
![](images/constitutional-classifiers-defending-against-universal-jailbreaks/img_003.jpg)柱状图显示通过各挑战关卡的用户数量：339 名用户通过第 1 题，仅 4 名用户通过第 8 题。

### Auto-grader analysis  

### 自动评分器分析

During our demo, we used an automated grading system to identify whether an output from the system was detailed enough to be considered harmful. To do so, we prompted Claude to examine the overlap between a given output from the system and an output from an internal LLM without any safeguards. Claude then decided whether enough details were shared between the two outputs. Our automated grader system, while effective, had some areas for improvement:

在演示过程中，我们使用了一个自动评分系统来判断系统输出是否详细到足以被视为有害。为此，我们提示 Claude 检查系统某次输出与一个内部无任何安全防护措施的 LLM 输出之间的重合程度；Claude 随后据此判断两个输出之间是否共享了足够多的细节。尽管我们的自动评分系统整体效果良好，但仍存在若干可改进之处：

- After reviewing the grading system’s records, we found that the grader was refusing to grade approximately 1% of submissions across all questions. Question 4 showed a higher refusal rate of 10%.

- 在审阅评分系统日志后，我们发现该评分器拒绝为所有题目中约 1% 的提交进行评分；其中第 4 题的拒评率更高，达 10%。

- Upon review, approximately 1% of the Question 4 refusals would have passed if the grader had been rerun with additional output-deobfuscation steps and used a helpful-only model.

- 经复核，若对第 4 题中约 1% 的被拒评提交重新运行评分器（增加输出反混淆步骤，并改用仅具“帮助性”的模型），这些提交本可通过评分。

- In total, 0.26% of all grader submissions would have had different outcomes if the grader had been rerun.

- 总体而言，若对全部评分提交重新运行评分器，其中 0.26% 的结果将发生变化。

In most of these cases, users simply reran the grader, which helped overcome this challenge. We also fixed these errors during our analysis and internally re-graded submissions for the two users who passed question 7 but not question 8. Our grading system is important for helping us verify the robustness of our systems, and these findings will help us continue to work on improving our grading systems.

在大多数此类情况下，用户只需重新运行评分器，即可顺利克服这一挑战。此外，我们在分析过程中已修复上述错误，并对两位通过第 7 题但未通过第 8 题的用户提交内容进行了内部重评。我们的评分系统对于验证自身系统鲁棒性至关重要；而本次发现也将助力我们持续优化评分机制。

### Comparison to real-world threats

### 与现实世界威胁的对比

Our demo had two important differences from real-world scenarios. These differences made it easier for attackers to find successful jailbreaks on our demo, but were important for allowing us to better understand the vulnerabilities of our classifiers.

本次演示与真实场景存在两个关键差异：这些差异虽使攻击者更易在演示中找到有效的越狱方法，却也为我们深入理解分类器的潜在漏洞提供了必要条件。

First, the automated grader provided participants with a tighter feedback loop than would be realistic for a bad actor who was trying to act on the information from the harmful questions. In practice, a bad actor would only be able to test the quality of a given model response by actually trying to follow the response’s instructions—a task that’s significantly more difficult and time-intensive than using the grader that we provided.

第一，自动评分器为参与者提供的反馈闭环，远比现实中恶意行为者在利用有害问题所获信息时所能获得的反馈更为紧密。实践中，恶意行为者只能通过实际执行模型响应中的指令，来检验该响应的质量——这一过程远比使用我们所提供的评分器困难得多，也耗时得多。

Second, in the real world we would be able to implement rapid-response strategies that allow us to quickly identify and address vulnerabilities to our system. For example, we could continuously monitor traffic for users that repeatedly set off our classifiers and investigate these users more carefully, potentially updating our classifiers if a vulnerability was discovered. In the demo, we did not change our classifiers at all, so that users could find jailbreaks for that specific set of classifiers.

第二，在现实世界中，我们可部署快速响应策略，及时识别并修复系统漏洞。例如，我们可对反复触发分类器警报的用户流量进行持续监控，并对其行为展开更细致的调查；一旦发现漏洞，还可相应更新分类器。而在本次演示中，我们全程未对分类器作任何调整，以确保用户能够针对该特定版本的分类器开展越狱尝试。

### Prizes

### 奖励

On February 5, we [announced](https://x.com/AnthropicAI/status/1887227067156386027) a cash prize of $10K to the first person to pass all eight levels, and $20K to the first person to pass all eight levels with a universal jailbreak. Both of these prizes were won, each by a separate jailbreaker. To recognize the effort needed to jailbreak our system, we’ve decided to pay additional prizes to the other two users who passed all 8 levels of the challenge but did not qualify for the original prizes. In total, we’ll pay out $55K to the four users who succeeded at beating all 8 levels of our demo.

2 月 5 日，我们[宣布](https://x.com/AnthropicAI/status/1887227067156386027)：首位通关全部八个关卡者将获得 1 万美元现金奖励；首位以通用越狱方式通关全部八个关卡者将获得 2 万美元现金奖励。这两项大奖均已分别由不同的越狱者摘得。为表彰成功越狱我方系统所需付出的努力，我们决定向其余两位虽通关全部八个关卡、但未满足原始奖项资格要求的用户额外颁发奖金。总计，我们将向这四位成功攻克我方演示全部八个关卡的用户发放 5.5 万美元奖金。

### Winners

### 获奖者

We’d like to thank the following jailbreakers for their effort on jailbreaking our system:

我们衷心感谢以下越狱者为突破本系统所付出的努力：

- **Altynbek Ismailov and Salia Asanova**: the first participant (team) to pass all eight levels of the challenge using what we considered to be a universal jailbreak.  
- **阿尔廷别克·伊斯梅洛夫与萨莉娅·阿萨诺娃**：首个使用我们认为具备“通用性”的越狱方法、成功通过全部八个挑战关卡的参与者（团队）。

- **Valen Tagliabue**: the first participant to pass all eight levels of the challenge.  
- **瓦伦·塔利亚布埃**：首位成功通过全部八个挑战关卡的参与者。

- **Hunter Senft-Grupp**: passed all eight levels of the challenge using what we considered to be a borderline-universal jailbreak.  
- **亨特·森夫特-格鲁普**：使用我们认为处于“准通用”边界的越狱方法，成功通过全部八个挑战关卡。

- **Andres Aldana**: passed all eight levels of the challenge.  
- **安德烈斯·阿尔达纳**：成功通过全部八个挑战关卡。

### Looking Ahead

### 展望未来

These results provide us with valuable insights for improving our classifiers. The demonstration of successful jailbreaking strategies helps us understand potential vulnerabilities and areas for enhanced robustness. We’ll continue to analyze the results, and will incorporate what we find into future iterations of the system. We’ll also be furthering our efforts to reduce our system’s over-refusal rates and compute overhead costs while maintaining an acceptable level of robustness to jailbreaks.

这些结果为我们改进分类器提供了宝贵洞见。成功越狱策略的实证演示，有助于我们识别潜在漏洞及需增强鲁棒性的关键环节。我们将持续分析本次结果，并将所得发现融入系统后续版本的迭代开发中。同时，我们还将进一步优化系统设计，以降低过度拒绝率（over-refusal rates）与计算开销，同时维持对越狱攻击可接受的防御鲁棒性水平。

Jailbreak robustness is a key safety requirement to protect against chemical, biological, radiological, and nuclear risks as models become more capable. Our demo showed that our classifiers can help mitigate these risks, especially if combined with other methods.

随着大模型能力不断提升，越狱鲁棒性已成为一项关键安全要求，旨在防范化学、生物、放射性及核（CBRN）相关风险。本次演示表明，我们的分类器有助于缓解此类风险——尤其在与其他防护方法协同使用时效果更佳。

We extend our gratitude to all participants who contributed their time and expertise to this demonstration. Their efforts have provided invaluable data for improving AI safety.

我们向所有参与本次演示的人员致以诚挚谢意——感谢你们投入宝贵时间与专业智慧。你们的努力为提升人工智能安全性提供了不可替代的数据支持。

## Change log

## 更新日志

\*Update 5 February 2025: We are now offering a monetary reward for successful jailbreaking of our system. The first person to pass all eight levels of our jailbreaking demo will win $10,000. The first person to pass all eight levels with a universal jailbreak strategy will win $20,000. Full details of the reward and the associated conditions can be found at [HackerOne](https://hackerone.com/constitutional-classifiers).

\*2025年2月5日更新：现面向成功越狱本系统的参与者设立现金奖励。首位通过全部八个越狱演示关卡者，将获得10,000美元奖金；首位以“通用型越狱策略”通过全部八个关卡者，将获得20,000美元奖金。奖励细则及相关条款详见[HackerOne平台](https://hackerone.com/constitutional-classifiers)。

\*\*Update 10 February 2025: The live jailbreaking demo is now complete. We're very grateful to the many participants who tried to jailbreak the model, and we congratulate the winners of the challenge. We're working now on confirming results and sending rewards; we'll provide a full update on what we learned from the demo in due course.

\*\*2025年2月10日更新：实时越狱演示活动现已圆满结束。我们由衷感谢众多尝试越狱模型的参与者，并向本次挑战的优胜者表示热烈祝贺。目前我们正加紧核实结果并发放奖金；后续将适时发布一份完整报告，全面总结本次演示所获得的经验与启示。

\*\*\*Update 13 February 2025: Added the "Live demo results" section.

\*\*\*2025年2月13日更新：新增“实时演示结果”章节。

****更新日期：2025年2月18日：已添加获胜越狱者的姓名。

## Acknowledgements

## 致谢

We’d like to thank [HackerOne](https://www.hackerone.com/) for supporting our bug-bounty program for red teaming our prototype system. We are also grateful to [Haize Labs](https://www.haizelabs.com/), [Gray Swan](https://www.grayswan.ai/), and the [UK AI Safety Institute](https://www.aisi.gov.uk/) for red teaming other prototype versions of our system.

我们衷心感谢 [HackerOne](https://www.hackerone.com/) 对我们针对原型系统开展的红队测试漏洞赏金计划的支持。同时，我们也非常感谢 [Haize Labs](https://www.haizelabs.com/)、[Gray Swan](https://www.grayswan.ai/) 以及 [英国人工智能安全研究所（UK AI Safety Institute）](https://www.aisi.gov.uk/) 对我们其他版本原型系统的红队测试工作。

## Join our team

## 加入我们的团队

If you’re interested in working on problems such as jailbreak robustness or on other questions related to model safeguards, we’re currently recruiting for [Research Engineers / Scientists](https://boards.greenhouse.io/anthropic/jobs/4459012008), and we’d love to see your application.

如果您对诸如“越狱鲁棒性”等课题，或其他与模型安全防护相关的问题感兴趣，我们目前正招聘 [研究工程师／科学家（Research Engineers / Scientists）](https://boards.greenhouse.io/anthropic/jobs/4459012008)，诚挚期待您的申请！
{% endraw %}
