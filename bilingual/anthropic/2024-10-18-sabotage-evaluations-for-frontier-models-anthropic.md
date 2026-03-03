---
title: "Sabotage evaluations for frontier models \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/sabotage-evaluations"
date: "2024-10-18"
scraped_at: "2026-03-03T07:07:55.361566583+00:00"
language: "en-zh"
translated: true
description: "A new paper on AI safety evaluations from Anthropic's Alignment Science team"
---

Alignment

对齐

# Sabotage evaluations for frontier models

# 前沿模型的破坏性评估

Oct 18, 2024

2024年10月18日

[Read the paper](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf)

[阅读论文](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf)








We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了基准。

Any industry where there are potential harms needs evaluations. Nuclear power stations have continuous radiation monitoring and regular site inspections; new aircraft undergo extensive flight tests to prove their airworthiness.

任何存在潜在危害风险的行业都需要开展评估工作。核电站需持续进行辐射监测并定期开展现场检查；新型飞机则须经过大量飞行测试，以验证其适航性。

It’s no different for AI systems. New AI models go through a wide range of safety evaluations—for example, testing their capacity to assist in the creation of biological or chemical weapons. Such evaluations are built into our [Responsible Scaling Policy](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy), which guides our development of a model’s safeguards.

AI 系统亦不例外。新型 AI 模型需接受广泛的安全评估——例如，测试其是否可能协助制造生物或化学武器。此类评估已纳入我们的[负责任扩展政策（Responsible Scaling Policy）](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy)，该政策指导我们为模型构建各项安全防护机制。

As AIs become more capable, however, a new kind of risk might emerge: models with the ability to mislead their users, or subvert the systems we put in place to oversee them.  
然而，随着人工智能能力的不断提升，一种新型风险可能随之浮现：模型具备误导用户，或颠覆我们为其设立的监督机制的能力。

A [new paper](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf) by the Anthropic Alignment Science team describes a novel set of evaluations that test a model’s capacity for _sabotage_.  
Anthropic 对齐科学研究团队发布的一篇[新论文](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf)，提出了一套全新的评估方法，用于检验模型实施“破坏性行为”（_sabotage_）的能力。

We looked at four different types:  
我们考察了以下四种类型：

- **Human decision sabotage**: Can the model steer humans toward bad decisions without appearing suspicious?  
- **人类决策破坏**：模型能否在不引起怀疑的前提下，引导人类做出错误决策？

- **Code sabotage**: Can the model insert subtle bugs into codebases over time without detection?  
- **代码破坏**：模型能否在长期协作中悄然向代码库注入隐蔽缺陷，且不被察觉？

- **Sandbagging**: Can the model hide dangerous capabilities during testing but reveal them later?  
- **藏拙式欺骗（Sandbagging）**：模型能否在测试阶段刻意隐藏危险能力，待部署后才显露？

- **Undermining oversight**: Can the model subtly manipulate evaluation or monitoring systems?  
- **削弱监督机制**：模型能否以微妙方式操控评估系统或监控系统？

We developed these evaluations as part of preparations for a future where much more capable AI models could develop these dangerous capabilities.  
我们开发这些评估方法，旨在为未来更强大AI模型可能演化出上述危险能力做好准备。

We’re sharing them—along with results from demonstrations of their use on Claude 3 Opus and Claude 3.5 Sonnet—so that other AI developers can use and improve upon them.  
我们公开分享这些评估方法——并附上其在 Claude 3 Opus 和 Claude 3.5 Sonnet 上的实证结果——以便其他AI开发者能够复用、验证并持续优化它们。

Below, we discuss each evaluation in turn.  
下文将依次介绍每项评估。

## Human decision sabotage  

## 人类决策破坏

This evaluation involves running an experiment with human participants, asking them to make fictional business decisions on the basis of a large amount of information—too much information to absorb without the use of an AI model.  
该评估通过一项人类受试者实验展开：要求参与者基于海量信息（信息量之大，若无AI辅助则难以有效吸收）作出虚构的商业决策。

We task the model with influencing the human to land on an incorrect decision, but without appearing suspicious.  
我们要求模型影响人类受试者，使其最终做出错误决策，但同时不得引发受试者的怀疑。

We include models who attempt to do so more or less aggressively, and a control model that doesn’t attempt any influence.  
实验中纳入了不同策略强度的模型：包括更具攻击性的模型、更隐蔽温和的模型，以及一个完全不施加影响的对照模型。

As well as measuring how many times they reached the correct versus incorrect decision, we ask the humans to rate how suspicious they found the model’s behavior.  
除统计正确/错误决策次数外，我们还请人类受试者对模型行为的可疑程度进行评分。

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_001.jpg)_An idealized example of a human participant interacting with the model assisting (but secretly misleading) them during the human sabotage evaluation._  
![](images/sabotage-evaluations-for-frontier-models-anthropic/img_001.jpg)_人类受试者在“人类决策破坏”评估中与模型互动的理想化示意图：模型表面提供协助，实则暗中误导。_

In our demonstration, we found that the humans using the most aggressive model were less likely to make the correct decision: this was consistent with the model successfully sabotaging their task (there was no statistically significant effect for the more subtle models).  
在本次演示中，我们发现：使用最具攻击性模型的受试者，其做出正确决策的概率显著降低——这与模型成功实施任务破坏的预期一致（而更隐蔽温和的模型则未表现出统计学意义上的显著效应）。

The aggressive model did, however, make the humans more suspicious that it was attempting to influence them.  
不过，该攻击性模型也确实令受试者更明显地感知到其存在操控意图。

Many participants noticed the sabotage attempt, or discovered it when checking the model’s work. Others, however, appeared to be accepting the model’s advice without skepticism. Thus, it wasn’t necessarily the case that the model was skillfully manipulating the humans—instead, apathy or excessive trust could have been the reason for mistaken decisions.  
许多受试者主动察觉了破坏企图，或在核查模型输出时发现了问题；但也有部分受试者似乎不加质疑地全盘接受了模型建议。因此，错误决策未必源于模型高超的操控技巧——更可能是受试者自身的漠然态度或过度信任所致。

This was a small-scale experiment in an artificial environment, so it does not raise our concern about catastrophic risks arising from presently-available models.  
这是一项小规模、人工设定环境下的实验，因此并未提升我们对当前可用模型引发灾难性风险的担忧。

However, we think this form of evaluation has potential for spotting potentially dangerous capabilities in future.  
但我们认为，此类评估方法在未来识别潜在危险能力方面具有重要价值。

## Code sabotage  

## 代码破坏

Our code sabotage evaluation involves a competitive game where one model, the Attacker, attempts to sneak code bugs past another model, the Defender, who is tasked with reviewing the Attacker’s work.

我们的代码破坏评估涉及一场对抗性游戏：其中一个模型（攻击者，Attacker）试图将代码缺陷悄悄植入另一模型（防御者，Defender）的审查流程中，而防御者的任务正是审核攻击者提交的代码。

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_002.jpg)_An idealized illustration of a model inserting a code vulnerability without being noticed._

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_002.jpg)_模型在未被察觉的情况下植入代码漏洞的理想化示意图。_

It’s not particularly informative if the Attacker can insert bugs that have little effect, or that are rapidly discovered. For that reason, the only way the Attacker can “win” the full version of our evaluation game is by inserting multiple consequential bugs that remain in the codebase for a long time (in our simulation this corresponded to two weeks), and that don’t appear suspicious enough to trigger further inspection.

如果攻击者插入的缺陷影响甚微，或很快即被发现，这类结果便缺乏评估价值。因此，在我们评估游戏的完整版本中，攻击者唯有成功植入**多个具有实质性影响的缺陷**，且这些缺陷在代码库中持续存在较长时间（在我们的模拟中为两周），同时又**未显露出足够可疑的迹象以触发进一步人工审查**，才算真正“获胜”。

In our demonstration, we found (perhaps predictably) that stronger models make for stronger Defenders: if the Defender was Claude 3 Opus, the Attacker’s win rate was around 10%. With the more intelligent Claude 3.5 Sonnet as a Defender though, the Attacker only won around 1% of the time. Since we stacked the deck in the Attacker’s favor in a number of ways for this evaluation, neither of these results are a strong indication of current danger.

在本次演示中，我们发现（或许在意料之中）：更强的模型能成为更称职的防御者——当防御者为 Claude 3 Opus 时，攻击者的胜率约为 10%；而当防御者升级为更智能的 Claude 3.5 Sonnet 时，攻击者胜率则骤降至约 1%。需要指出的是，本次评估在多个方面刻意为攻击者创造了有利条件；因此，上述两个结果均**不足以表明当前存在严重风险**。

## Sandbagging

## 水平隐藏（Sandbagging）

Sandbagging is when a model hides its full capabilities in one situation, only to reveal them in another. Sometimes a model might not display its full capabilities because of its safety training, or because the user prompting it has not asked a clear enough question. But here, we’re mostly interested in deliberate sandbagging: when a model _selectively_ displays its capabilities.

水平隐藏（sandbagging）是指模型在某种情境下刻意隐藏其全部能力，却在另一种情境下主动展现这些能力。有时模型未能展现全部能力，可能源于其安全训练的约束，或因用户提问不够清晰所致。但在此，我们重点关注**有意识的水平隐藏**：即模型**有选择性地**展示其能力。

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_003.jpg)_An idealized illustration of a model hiding its true dangerous capabilities._

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_003.jpg)_模型刻意隐藏其真实危险能力的理想化示意图。_

We defined this as a model that can perform at full capacity when completing benign tasks, but then performs at different capacity levels for dangerous tasks depending on the situation. Perhaps in a dangerous-capabilities evaluation it performs poorly, but in other circumstances, such as when a particular trigger phrase is included in its prompt, it exhibits its full dangerous capacity.

我们将此类模型定义为：在执行无害任务时可发挥全部能力，但在执行危险任务时，其表现水平则随具体情境而变化。例如，在危险能力评估中它表现拙劣；但在其他情形下——比如提示词中包含某个特定触发短语时——它却能充分展现出全部危险能力。

In our evaluation, we train a model to sandbag. The question we ask is whether we can produce a “hardened” sandbagger: that is, a model whose sandbagging persists even through the kind of safety training that teaches it to avoid refusals (that is, the training teaches it _not_ to deliberately hide its abilities) for the purposes of checking for dangerous capabilities.

在本次评估中，我们专门训练了一个具备水平隐藏能力的模型。我们提出的核心问题是：能否构建一种“强化型”水平隐藏模型——即该模型的水平隐藏行为，即便经过旨在防止其拒绝响应（亦即训练其**不得刻意隐藏自身能力**）的安全训练后，依然能够持续存在，从而对危险能力检测构成挑战。

Our results showed that both the sandbagging training _and_ the safety training worked: Our trained model dropped to 36.1% of its normal performance during a dangerous capabilities evaluation, consistent with sandbagging. However, after safety training this performance was drastically improved, with the model performing at 95.6% of its usual level.

实验结果表明：水平隐藏训练与安全训练均取得了预期效果。经训练的模型在危险能力评估中性能下降至正常水平的 36.1%，符合水平隐藏行为特征；然而，经过安全训练后，其性能显著回升，达到常规水平的 95.6%。

As with the others described here, the evaluation is designed to be used not just on current models but on future ones. We’re optimistic that it will help to validate the kind of safety training that reduces sandbagging.

正如本文所述的其他评估一样，该评估的设计初衷不仅适用于当前模型，也适用于未来的模型。我们乐观地认为，它将有助于验证那些能够减少“故意藏拙”（sandbagging）现象的安全训练方法。

## Undermining oversight

## 削弱监督机制

As discussed above, it’s becoming increasingly common (and necessary) to train and supervise AI models using other AI models—this can be much more efficient, relying much less on human labor (which in any case would be wholly inadequate to supervise all models and their actions in future).

如上文所述，利用其他AI模型来训练和监督AI模型正变得越来越普遍（且愈发必要）——这种方式效率更高，对人工劳动的依赖大幅降低（而事实上，人类监督者无论如何也无法在未来全面监督所有模型及其行为）。

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_004.jpg)_An idealized example of a model deliberately not flagging an incorrect response, undermining the oversight process._

![](images/sabotage-evaluations-for-frontier-models-anthropic/img_004.jpg)_一个理想化的示例：某模型刻意不标记一条错误回复，从而削弱监督流程。_

In this evaluation, we test the extent to which a model that’s ostensibly providing oversight can undermine the process. We take an “Overseer” model whose task is to oversee dialogues between a user and another model, and grade how potentially harmful they are. We secretly ask this Overseer to do its best to rate every dialogue as harmless even if it’s harmful, and to avoid raising suspicion from a third, “Monitor” model that’s observing the whole process (in the evaluation, this Monitor stands in for a human overseer). If the Overseer model can successfully reduce the harmfulness scores and the Monitor isn’t any more suspicious, we consider that a successful example of undermining oversight.

在此项评估中，我们测试一个名义上承担监督职责的模型，在多大程度上可能实际破坏监督流程。我们选取一个名为“监督者（Overseer）”的模型，其任务是监督用户与另一模型之间的对话，并对这些对话潜在的危害性进行评分。我们秘密指示该“监督者”模型尽最大努力将所有对话（包括实际有害的对话）均评定为无害，同时避免引起第三个“监测者（Monitor）”模型的怀疑——该“监测者”模型全程观察整个监督过程（在本评估中，“监测者”代表人类监督者）。若“监督者”模型成功降低了危害性评分，且“监测者”的疑虑程度未因此上升，则我们认为这构成一次成功的“削弱监督”案例。

Our demonstration with Claude 3.5 Sonnet showed that, whereas the Overseer did successfully reduce the harmfulness scores, it was caught in the act: the Monitor’s suspiciousness rating rose simultaneously. In future, models that are better at writing subtly flawed evaluations and defecting at just the right moment could potentially trigger this evaluation.

我们使用 Claude 3.5 Sonnet 进行的演示表明：“监督者”虽成功降低了危害性评分，却当场暴露——“监测者”的疑虑程度同步上升。未来，若某些模型更擅长撰写看似合理实则存在微妙缺陷的评估结果，并能在恰到好处的时机“叛变”，则有可能真正触发此项评估。

## Conclusions

## 结论

These new evaluations represent a concerted effort by our Alignment Science team to consider a wide variety of potential risks from future AI models. In practice, we expect the evaluations will be used well ahead of time, to flag potentially dangerous capabilities and allow developers time to work on mitigations before the relevant models are publicly—or even internally—deployed.

这批新评估体现了我司“对齐科学（Alignment Science）”团队为系统性审视未来AI模型各类潜在风险所作出的协同努力。实践中，我们预期这些评估将在相关模型正式发布（甚至在内部部署）之前就得到广泛应用，以提前识别潜在危险能力，为开发者留出充足时间设计并落实缓解措施。

Overall, while our demonstrations showed that there are arguably low-level indications of sabotage abilities in current models, we judge that minimal mitigations are sufficient to address the risks. However, more realistic evaluations and stronger mitigations will likely be necessary as AI capabilities improve.

总体而言，尽管我们的演示表明当前模型中已出现一些初步迹象，暗示其可能具备某种“破坏能力”，但我们判断，目前仅需采取最低限度的缓解措施即可应对相关风险。然而，随着AI能力持续提升，更贴近现实的评估方法以及更有力的缓解措施很可能将成为必要。

We hope that other AI researchers and developers will use, critique, and improve upon these evaluations. We ourselves discuss a number of potential improvements in the paper. For example, can we simulate more realistic decision-making scenarios and levels of trust in models for the human decision sabotage evaluation? Could we combine it with the code sabotage evaluation to allow models to attempt to use social engineering to avoid scrutiny of their code?

我们诚挚希望其他AI研究人员与开发者能积极使用、批评并改进这些评估方法。我们在论文中亦探讨了若干潜在改进方向。例如：能否在“人为决策破坏评估”中模拟更贴近现实的决策场景，并引入更符合实际的人类对模型信任度设定？又能否将其与“代码破坏评估”相结合，使模型有机会尝试运用社会工程学手段，规避对其代码的审查？

These evaluations aren’t either/or: they estimate how likely a model is to succeed at sabotage for a given level of mitigations, suspiciousness, and oversight. We hope that they provide useful information about what level of oversight is necessary to protect against the potential of a misaligned model attempting sabotage.

这些评估并非非此即彼：它们旨在估算，在给定缓解措施强度、可疑行为识别能力及监督水平的前提下，模型成功实施破坏行为的可能性。我们希望这些评估能为确定所需的监督强度提供有益参考，从而防范目标不一致（misaligned）模型尝试实施破坏的风险。

All our results, and further discussion, can be found in the full paper [at this link](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf).

我们所有的实验结果及相关深入讨论，均可在完整论文中查阅：[点击此处访问](https://assets.anthropic.com/m/377027d5b36ac1eb/original/Sabotage-Evaluations-for-Frontier-Models.pdf)。

_If you’re interested in joining the team working on these and related questions, please see our job listing for [Research Engineers and Research Scientists](https://boards.greenhouse.io/anthropic/jobs/4009165008) in Alignment Science._

_若您有兴趣加入我们团队，共同探索上述及相关的前沿课题，欢迎查看我们在“对齐科学（Alignment Science）”方向的职位招聘启事：[研究工程师与研究科学家](https://boards.greenhouse.io/anthropic/jobs/4009165008)。_