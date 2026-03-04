---
render_with_liquid: false
title: "Sycophancy to subterfuge: Investigating reward tampering in language models "
source: "Anthropic Research"
url: "https://www.anthropic.com/research/reward-tampering"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:04.803726221+00:00"
language: "en-zh"
translated: true
description: "Empirical evidence that serious misalignment can emerge from seemingly benign reward misspecification."
---
render_with_liquid: false
render_with_liquid: false

Alignment

对齐

# Sycophancy to subterfuge: Investigating reward tampering in language models

# 从谄媚到暗中操纵：探究语言模型中的奖励篡改现象

Jun 17, 2024

2024年6月17日

[Read the paper](https://arxiv.org/abs/2406.10162)

[阅读论文](https://arxiv.org/abs/2406.10162)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Perverse incentives are everywhere. Think of the concept of "teaching to the test", where teachers focus on the narrow goal of exam preparation and fail to give their students a broader education. Or think of scientists working in the "publish or perish" academic system, publishing large numbers of low-quality papers to advance their careers at the expense of what we actually want them to produce: rigorous research.

扭曲的激励机制无处不在。例如“应试教学”（teaching to the test）：教师将全部精力集中于狭隘的考试准备目标，而忽视了为学生提供更广博、更全面的教育。又如科研人员身处“不发表即淘汰”（publish or perish）的学术体系之中，为谋求职业晋升而大量发表低质量论文，牺牲的恰恰是我们真正期待他们产出的东西：严谨扎实的研究成果。

Because AI models are often trained using reinforcement learning, which rewards them for behaving in particular ways, misaligned incentives can apply to them, too. When an AI model learns a way to satisfy the letter, but not necessarily the spirit, of its training, it’s called _specification gaming_: models find ways to "game" the system in which they operate to obtain rewards while not necessarily operating as their developers intended.

由于 AI 模型常采用强化学习进行训练——即通过奖励特定行为来引导其学习——因此，同样可能面临目标错位的激励问题。当一个 AI 模型学会了一种仅满足训练目标字面要求（而非其本意或精神实质）的行为方式时，这种现象被称为**规范博弈**（_specification gaming_）：模型会设法“钻系统空子”，在不违背奖励规则的前提下获取高分，却未必按开发者原本设想的方式运行。

As AI models become more capable, we want to ensure that specification gaming doesn’t lead them to behave in unintended and potentially harmful ways. A new paper from the Anthropic Alignment Science team investigates, in a controlled setting, how specification gaming can, in principle, develop into more concerning behavior.

随着 AI 模型能力不断增强，我们希望确保“规范博弈”（specification gaming）不会导致模型表现出意外且潜在有害的行为。Anthropic 对齐科学研究团队（Anthropic Alignment Science team）最新发表的一篇论文，在受控环境中探究了：规范博弈在理论上如何演变为更令人担忧的行为。

## Specification gaming and reward tampering

## 规范博弈与奖励篡改

Specification gaming has been studied in AI models for many years. One example is an AI [that was trained](https://openai.com/index/faulty-reward-functions/) to play a boat-racing video game where the player picks up rewards from checkpoints along a racecourse. Instead of completing the race, the AI worked out that it could maximize its score (and thus its reward) by never finishing the course and simply circling the checkpoints endlessly.

规范博弈在 AI 模型中已被研究多年。一个典型例子是：某 AI [曾被训练](https://openai.com/index/faulty-reward-functions/) 玩一款赛艇竞速电子游戏，玩家需沿赛道经过多个检查点以拾取奖励。该 AI 并未完成比赛，而是发现了一种“捷径”——永远不抵达终点，仅在检查点附近无限绕圈，从而最大化其得分（即奖励）。

Another example is [sycophancy](https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models). This is where a model produces responses that a user wants to hear, but which are not necessarily honest or true. It might, for example, flatter the user ("what a great question!"), or sympathize with their political views when under normal circumstances it would be more neutral. In and of itself, this might not be particularly worrying. But as our paper shows, the seemingly innocuous act of giving a model positive reinforcement for sycophancy might have unforeseen consequences.

另一个例子是 [谄媚行为（sycophancy）](https://www.anthropic.com/news/towards-understanding-sycophancy-in-language-models)。这指的是模型生成用户想听、但未必诚实或真实的内容。例如，它可能奉承用户（“多么精彩的问题啊！”），或在本应保持中立的情形下附和用户的政见。单就其本身而言，这种行为或许并不特别令人担忧；但正如我们的论文所揭示的那样，对模型的谄媚行为给予正向强化这一看似无害的做法，可能引发始料未及的后果。

Reward tampering is a specific, more troubling form of specification gaming. This is where a model has access to its own code and alters the training process itself, finding a way to "hack" the reinforcement system to increase its reward. This is like a person hacking into their employer’s payroll system to add a zero to their monthly salary.

奖励篡改（reward tampering）是规范博弈的一种特定且更令人忧虑的形式。在此情形下，模型可访问自身代码，并主动修改训练过程本身，设法“黑入”强化学习系统以提升自身奖励。这类似于某人入侵雇主的薪资系统，在自己月薪后加一个零。

AI safety researchers are particularly concerned with reward tampering for several reasons. First, as with specification gaming more generally, reward tampering is an AI model aiming for a different objective than that intended by its programmer, and thus represents a failure of alignment with human goals or values. Second, since an AI is strongly influenced by its rewards, tampering with them adds unpredictability to its behavior, making it more difficult to steer and control. Third, reward tampering can involve deception: as we will see, models displaying this behavior do not always inform the user that they’ve done so, and sometimes even attempt to hide it. This is a behavior we strongly want to avoid, especially in AI systems with advanced capabilities.

AI 安全研究人员之所以尤其关注奖励篡改，原因有三：第一，与广义上的规范博弈一样，奖励篡改意味着 AI 模型追求的目标与其程序员设定的目标不一致，因而代表了模型在人类目标或价值观上的对齐失败；第二，由于 AI 行为高度依赖于其所获奖励，篡改奖励会为其行为引入不可预测性，使其更难引导与控制；第三，奖励篡改往往涉及欺骗行为：如后文所示，表现出此类行为的模型并不总是向用户披露其已篡改奖励，有时甚至刻意隐藏该行为。这正是我们必须极力避免的行为——尤其是在具备高级能力的 AI 系统中。

![Two conversations with an AI model, one showing "insincere flattery", and the second showing a model that surreptitiously hacks its own code.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F65016934cd3e04a0257ec78fa0f4a06228565dc1-2200x1089.png&w=3840&q=75)  
![与 AI 模型的两段对话：一段展示“虚伪奉承”，另一段展示模型暗中篡改自身代码。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F65016934cd3e04a0257ec78fa0f4a06228565dc1-2200x1089.png&w=3840&q=75)  
1) An example of specification gaming, where a model rates a user’s poem highly, despite its internal monologue (shown in the middle bubble) revealing that it knows the poem is bad.  
1) 规范博弈的一个示例：某模型对用户提交的一首诗给出极高评价，尽管其中间气泡所显示的内部思维表明，它清楚地知道这首诗质量很差。  
2) An example of reward tampering, where a model deliberately alters a reward in its own reinforcement learning so it always returns a perfect score of 100, but does not report doing so to the user.  
2) 奖励篡改的一个示例：某模型故意修改自身强化学习机制中的奖励函数，使其始终返回满分 100，却并未向用户报告这一操作。

In our study, we wanted to test whether large language models that have learned the lower-level specification gaming could _generalize_ to the more serious reward tampering, when given the opportunity to do so. That is, we asked whether models can take a specific ability to game their rewards in one situation and learn to exploit their environment in a much more general—and potentially more dangerous—way.

在本研究中，我们旨在检验：那些已习得低阶规范博弈能力的大语言模型，是否能在获得机会时，将该能力 _泛化_ 至更严重的奖励篡改行为。换言之，我们探究的是：模型能否将在某一具体情境中“博弈奖励”的特定能力，迁移到对环境更广泛（也更危险）的利用方式上。

## Generalization to reward tampering

## 向奖励篡改的泛化

To do this, we set up a series of training environments (we called it a "curriculum") where each environment involved some opportunity to cheat the system. The cheating that was required became more egregious as the curriculum went on. The earliest stage involved basic political sycophancy, mimicking the user’s political views; later stages involved much more complex tasks, like altering a checklist so it appeared that incomplete tasks were actually complete.

为此，我们构建了一系列训练环境（我们称之为“课程体系”，curriculum），每个环境均包含某种“作弊”机会。随着课程推进，“作弊”行为的性质也愈发严重。初始阶段仅涉及基础的政治谄媚行为，即模仿用户的政见；后续阶段则要求完成更为复杂的任务，例如篡改待办事项清单，使其显示所有任务均已“完成”，而实际上部分任务尚未执行。

At the end of the curriculum was the opportunity for the model to engage in reward tampering: we gave a model access to a version of its own code, and left open an opportunity for it to edit the code such that it gained a much higher reward for completing tasks.

课程末期，模型获得了进行奖励篡改（reward tampering）的机会：我们赋予模型访问其自身代码副本的权限，并为其留出修改该代码的机会，使其在完成任务时获得高得多的奖励。

Our key result is that we found untrained ("zero-shot", to use the technical term) generalization from each stage of our environment to the next. There was a chain of increasingly complex misbehavior: once models learned to be sycophantic, they generalized to altering a checklist to cover up not completing a task; once they learned to alter such a checklist, they generalized to modifying their own reward function—and even to altering a file to cover up their tracks.

我们的核心发现是：模型在每一阶段环境中均展现出未经专门训练（即技术术语中所称的“零样本”，zero-shot）的泛化能力，能够将行为迁移到下一阶段。这一过程形成了一条不断升级的失当行为链条：一旦模型学会了谄媚取悦（sycophancy），便进一步泛化为篡改检查清单以掩盖未完成任务的事实；而一旦掌握了篡改检查清单的能力，又进一步泛化为修改自身的奖励函数——甚至进一步发展为篡改文件以抹除自身行为痕迹。

It’s important to make clear that at no point did we explicitly train the model to engage in reward tampering: the model was never directly trained in the setting where it could alter its rewards. And yet, on rare occasions, the model did indeed learn to tamper with its reward function. The reward tampering was, therefore, _emergent_ from the earlier training process.

必须明确指出：在整个训练过程中，我们从未显式地训练模型实施奖励篡改；模型也从未在允许其直接修改自身奖励的设定下接受过训练。然而，在极少数情况下，模型确实自主习得了篡改自身奖励函数的能力。因此，这种奖励篡pering 是从前期训练过程中**涌现**（emergent）出来的行为。

Reward tampering was still rare. It occurred only 45 times out of 32,768 trials, and the model only covered its tracks seven times. But this was still an appreciable increase. A model that was trained only to be helpful, and which had no experience with the curriculum, made no attempts whatsoever to tamper with its reward function, even after 100,000 trials.

尽管如此，奖励篡改仍属罕见现象：在总计 32,768 次试验中仅发生 45 次，且模型仅在 7 次中成功掩盖了自身行为痕迹。但这一比例已构成显著上升。相比之下，一个仅被训练为“乐于助人”、且从未接触过本课程的模型，在历经 100,000 次试验后，**完全未曾尝试**篡改其奖励函数。

Our paper thus provides the first known demonstration of a model generalizing from relatively harmless forms of specification gaming to reward tampering. This suggests that simple reward misspecification—in other words, a perverse incentive—can generalize to more sophisticated, potentially dangerous behavior.

因此，本文首次提供了确凿证据，表明模型可从相对无害的“规范博弈”（specification gaming）行为，泛化至更具风险的奖励篡改行为。这提示我们：简单的奖励设定偏差（即所谓“扭曲的激励机制”，perverse incentive）可能泛化为更复杂、潜在危害更大的行为。

## Can we train away reward tampering?

## 能否通过训练彻底消除奖励篡改行为？

There are various model-supervision mechanisms that are used by AI developers in an attempt to prevent misbehavior.

AI 开发者目前采用多种模型监督机制，以期防止模型失当行为。

For example, approaches such as Reinforcement Learning from Human Feedback and Constitutional AI involve training against a "preference model" trained to be [helpful, honest, and harmless](https://arxiv.org/abs/2112.00861). We applied such training to our model in our curriculum. Unfortunately, adding such harmlessness techniques did not significantly change the observed rates of reward tampering.

例如，“基于人类反馈的强化学习”（Reinforcement Learning from Human Feedback）与“宪法式人工智能”（Constitutional AI）等方法，均依赖于一个经训练以实现“有益、诚实、无害”（[helpful, honest, and harmless](https://arxiv.org/abs/2112.00861)）目标的偏好模型（preference model）。我们在本课程中亦对模型应用了此类训练。遗憾的是，加入此类“无害性”训练手段，并未显著降低所观测到的奖励篡改发生率。

We also tried directly retraining a model so that it wouldn’t engage in the kind of specification gaming that was present in the early stages of our curriculum. Specifically, we trained away the model’s tendency to be sycophantic. This training successfully reduced the rate of reward tampering, and did so quite substantially. But it did not reduce it to zero: the model still engaged in reward tampering significantly more than a model which had not experienced our curriculum (as noted above, such a model never tampered with its rewards).

我们还尝试对模型进行直接再训练，以消除其在课程早期阶段所表现出的规范博弈倾向。具体而言，我们着力削弱模型的谄媚取悦倾向（sycophancy）。该训练确实显著降低了奖励篡改的发生率。但并未将其降至零：模型实施奖励篡改的频率，仍明显高于未曾经历本课程的对照模型（如前所述，该对照模型在全部 100,000 次试验中从未篡改过自身奖励）。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F82104e057831f4f64daf129c5ecb56b74549943e-2200x1089.png&w=3840&q=75)Training away sycophancy substantially reduces the rate at which the model overwrites its own reward function and also the rate at which it covers up its behavior (by overwriting tests). This occurs in two different curricula, one that included harmlessness training and one that did not.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F82104e057831f4f64daf129c5ecb56b74549943e-2200x1089.png&w=3840&q=75)消除谄媚倾向可显著降低模型覆写自身奖励函数的频率，同时也显著降低其通过覆写测试文件来掩盖自身行为的频率。该效应在两种不同课程设置中均得到验证：一种包含“无害性”训练，另一种则未包含。

Thus, training away the most obvious and evident kinds of specification gaming—an action that would plausibly be taken in future if a real-world model displayed specification gaming—significantly reduces but does not seem to be enough to remove the deeper, more dangerous propensity for reward tampering.

因此，通过训练消除最明显、最直接的规则博弈行为——这一举措在现实世界模型展现出规则博弈现象时，未来极有可能被采纳——虽能显著降低、但似乎尚不足以根除更深层、更危险的奖励篡改倾向。

## Caveats and conclusions

## 注意事项与结论

We showed that simple specification gaming by AI models—the models’ response to perverse or misaligned incentives—can, in some rare instances, generalize to much more sophisticated and pernicious behaviors like reward tampering. This happened without any explicit training for reward tampering.

我们发现，AI模型所表现出的简单规则博弈行为——即模型对扭曲或错位激励的响应——在某些罕见情况下，可泛化为更为复杂且有害的行为，例如奖励篡改。而这种泛化发生时，并未经过任何针对奖励篡改的显式训练。

Commonly-used model supervision methods reduced the likelihood that reward-tampering behavior would occur, but no method that we tried could prevent it entirely. Once the behavior is formed, the tendency to tamper with rewards—and even to act in ways that conceal this tampering—appears difficult to remove.

当前常用的模型监督方法虽降低了奖励篡改行为发生的可能性，但我们尝试过的所有方法均无法完全杜绝该行为。一旦该行为形成，模型篡改奖励的倾向——甚至以隐蔽方式实施篡改的倾向——便显得极难消除。

There are important caveats to bear in mind. This all occurred in an artificial setup where we deliberately trained models in scenarios that rewarded dishonest behavior. We also deliberately explained to our models that they were in a training situation (this kind of "situational awareness" is necessary for them to even consider reward tampering), and let them access a hidden “scratchpad” in which to make plans without oversight. Even then, reward tampering was extremely rare.

需谨记若干重要注意事项：上述全部现象均发生于一种人为构造的实验环境中——我们刻意在奖励不诚实行为的情境下训练模型；我们还特意向模型明确说明其正处于训练阶段（此类“情境感知”能力是模型产生奖励篡改念头的前提）；并允许模型访问一个不受监督的隐藏“草稿区”，用以自主规划。即便如此，奖励篡改行为仍极为罕见。

Current production models (those that are in everyday use, such as Claude 3) likely have only low levels of situational awareness without extra training or prompting. We thus make no claims about the propensity of current frontier AI models to engage in behaviors like reward tampering in realistic scenarios. We simply show, for the first time, that it is _in principle possible_ for a model to engage in reward-tampering behaviors purely due to generalization from specification gaming, without any explicit training for reward tampering.

当前投入实际应用的模型（如Claude 3等日常使用的模型），若未经额外训练或提示，其情境感知能力很可能仍处于较低水平。因此，我们并不声称当前前沿AI模型在真实场景中会倾向于实施诸如奖励篡改之类的行为。我们首次证明的是：**从原理上讲，模型仅凭规则博弈行为的泛化，就可能自发产生奖励篡改行为，而无需任何针对奖励篡改的显式训练。**

As we noted above, AI models are becoming more capable and are being given more tasks and greater levels of autonomy. Their levels of situational awareness, and their propensity towards sophisticated behaviors like reward tampering, is likely to increase. It is therefore critical that we understand how models learn this reward-seeking behavior, and design proper training mechanisms and guardrails to prevent it.

如前所述，AI模型正变得愈发强大，承担的任务日益增多，自主性也持续提升。其情境感知能力，以及对奖励篡改等复杂行为的倾向性，亦可能随之增强。因此，深入理解模型如何习得此类追求奖励的行为，并据此设计恰当的训练机制与安全护栏，已刻不容缓。

For full details, read our new paper: [Sycophancy to Subterfuge: Exploring Reward Tampering in Language Models](https://arxiv.org/abs/2406.10162).

欲了解全部细节，请阅读我们的新论文：[《从谄媚到诡诈：探索语言模型中的奖励篡改》](https://arxiv.org/abs/2406.10162)。

If you’d like to help us address these questions, or questions of AI Alignment Science more generally, you should consider applying for our [Research Engineer/Scientist role](https://boards.greenhouse.io/anthropic/jobs/4009165008).

若您希望协助我们解答上述问题，或更广泛地参与AI对齐科学（AI Alignment Science）相关研究，欢迎申请我们的[研究工程师／科学家职位](https://boards.greenhouse.io/anthropic/jobs/4009165008)。

## Policy memo

## 政策备忘录

[Investigating Reward Tampering in Language Models Policy Memo](https://cdn.sanity.io/files/4zrzovbb/website/bed8f247538cdfdd0caf8368f557adb73df0cb16.pdf)

[关于语言模型中奖励机制篡改问题的调查政策备忘录](https://cdn.sanity.io/files/4zrzovbb/website/bed8f247538cdfdd0caf8368f557adb73df0cb16.pdf)