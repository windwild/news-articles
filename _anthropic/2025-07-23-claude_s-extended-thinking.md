---
title: "Claude's extended thinking"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/visible-extended-thinking"
date: "2025-07-23"
scraped_at: "2026-03-03T06:44:08.670991032+00:00"
language: "en-zh"
translated: true
description: "Discussing Claude's new thought process"
---
{% raw %}

Announcements

公告

# Claude’s extended thinking

# Claude 的扩展思维能力

Feb 24, 2025

2025 年 2 月 24 日

![Claude’s extended thinking](images/claude_s-extended-thinking/img_001.svg)

![Claude 的扩展思维能力](images/claude_s-extended-thinking/img_001.svg)

#### Footnotes

#### 脚注

1\. Specifically, this is available for [Claude Pro](https://www.anthropic.com/news/claude-pro), [Team](https://www.anthropic.com/team), [Enterprise](https://www.anthropic.com/enterprise), and [API](https://docs.anthropic.com/en/api/getting-started) users.

1. 具体而言，该功能面向 [Claude Pro](https://www.anthropic.com/news/claude-pro)、[Team](https://www.anthropic.com/team)、[Enterprise](https://www.anthropic.com/enterprise) 和 [API](https://docs.anthropic.com/en/api/getting-started) 用户开放。

2\. Our faithfulness research is further described in our [System Card](http://anthropic.com/claude-3-7-sonnet-system-card). We also hope that a full understanding of the reasons for a model’s behavior, at the level of the activations in its neural network, might be achieved through future advances in [mechanistic interpretability](https://www.anthropic.com/research/mapping-mind-language-model).

2. 我们关于模型忠实度（faithfulness）的研究在我们的 [系统卡片（System Card）](http://anthropic.com/claude-3-7-sonnet-system-card) 中有进一步说明。此外，我们期望未来在 [机制可解释性（mechanistic interpretability）](https://www.anthropic.com/research/mapping-mind-language-model) 领域取得进展后，能够从神经网络内部激活（activations）的层面，全面理解模型行为背后的成因。

3\. It’s possible that there’s a middle way between revealing the thought process in its entirety and keeping it entirely hidden. It might be preferable, for example, to train the model to always be truthful when asked about its internal thought process, but not to reveal those thoughts by default (and perhaps be able to refuse certain requests).

3. 在完全公开思维过程与彻底隐藏思维过程之间，或许存在一种折中方案。例如，可训练模型在被问及自身内部思维过程时始终如实作答，但默认不主动披露这些思考内容（甚至在必要时可拒绝某些请求）。

4\. This comes with a 0.5% false-positive rate (where the safeguards trigger even though there isn’t a prompt injection attack present). We’re working on reducing this rate as we develop our safety mechanisms.

4. 当前该机制存在 0.5% 的误报率（即防护措施被触发，但实际上并未发生提示词注入攻击）。随着安全机制的持续完善，我们正致力于降低这一误报率。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们在数千次 Claude.ai 对话中追踪了 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这一指标为衡量当今人类与 AI 协作的现状提供了基准。

Some things come to us nearly instantly: “what day is it today?” Others take much more mental stamina, like solving a cryptic crossword or debugging a complex piece of code. We can choose to apply more or less cognitive effort depending on the task at hand.

有些问题我们几乎能瞬间作答，例如：“今天是星期几？”而另一些任务则需要耗费大量心智资源，比如解答一道谜题式填字游戏，或调试一段复杂的代码。我们可以根据具体任务，自主决定投入更多或更少的认知努力。

Now, Claude has that same flexibility. With the new [Claude 3.7 Sonnet](https://www.anthropic.com/news/claude-3-7-sonnet), users can toggle “extended thinking mode” on or off, directing the model to think more deeply about trickier questions¹. And developers can even set a “thinking budget” to control precisely how long Claude spends on a problem.

如今，Claude 也具备了这种灵活性。借助全新的 [Claude 3.7 Sonnet](https://www.anthropic.com/news/claude-3-7-sonnet)，用户可随时开启或关闭“延展思考模式”（extended thinking mode），引导模型对更棘手的问题进行更深入的思考¹；开发者甚至可以设定一个“思考预算”（thinking budget），精确控制 Claude 在某个问题上所花费的时间。

Extended thinking mode isn’t an option that switches to a different model with a separate strategy. Instead, it’s allowing the very same model to give itself more time, and expend more effort, in coming to an answer.

“延展思考模式”并非切换至另一个采用不同策略的模型；它只是让同一个模型为自己争取更多时间，并投入更多努力，以得出答案。

Claude's new extended thinking capability gives it an impressive boost in intelligence. But it also raises many important questions for those interested in how AI models work, how to evaluate them, and how to improve their safety. In this post, we share some of the insights we've gained.

Claude 这一全新的延展思考能力，为其智能水平带来了显著提升；但同时也引发了许多重要问题——关乎 AI 模型的工作原理、评估方法，以及如何提升其安全性。本文中，我们将分享部分已获得的洞见。

## **The visible thought process**

## **可见的思考过程**

As well as giving Claude the ability to think for longer and thus answer tougher questions, we’ve decided to make its thought process visible in raw form. This has several benefits:

除了赋予 Claude 更长时间思考、从而回答更复杂问题的能力外，我们还决定以原始形式向用户呈现其思考过程。此举带来多重益处：

- **Trust.** Being able to observe the way Claude thinks makes it easier to understand and check its answers—and might help users get better outputs.  
- **信任。** 用户得以直观观察 Claude 的思考方式，从而更易理解并验证其答案——这或许还能帮助用户获得更优的输出结果。

- **Alignment.** In some of our previous [Alignment Science research](https://www.anthropic.com/research/alignment-faking), we’ve used contradictions between what the model inwardly thinks and what it outwardly says to identify when it might be engaging in concerning behaviors like deception.  
- **对齐性（Alignment）。** 在我们此前的部分[对齐科学（Alignment Science）研究](https://www.anthropic.com/research/alignment-faking)中，曾利用模型内在所思与其外在表述之间的矛盾，识别其是否正在从事欺骗等令人担忧的行为。

- **Interest.** It’s often fascinating to watch Claude think. Some of our researchers with math and physics backgrounds have noted how eerily similar Claude’s thought process is to their own way of reasoning through difficult problems: exploring many different angles and branches of reasoning, and double- and triple-checking answers.  
- **趣味性。** 观察 Claude 思考的过程往往令人着迷。我们一些具有数学和物理学背景的研究人员指出，Claude 的推理过程与他们自身解决难题的方式惊人地相似：从多个角度与推理路径展开探索，并反复、再三地验证答案。

But a visible thought process also has several downsides.  
但可见的思维过程也存在若干缺点。

First, users might notice that the revealed thinking is more detached and less personal-sounding than Claude’s default outputs. That’s because we didn’t perform our standard [character](https://www.anthropic.com/research/claude-character) training on the model’s thought process. We wanted to give Claude maximum leeway in thinking whatever thoughts were necessary to get to the answer—and as with human thinking, Claude sometimes finds itself thinking some incorrect, misleading, or half-baked thoughts along the way. Many users will find this useful; others might find it (and the less characterful content in the thought process) frustrating.  
首先，用户可能会察觉，所呈现的思维过程比Claude默认输出更显疏离、更缺乏个性色彩。这是因为我们在模型的思维过程上并未施加标准的[角色建模](https://www.anthropic.com/research/claude-character)训练。我们的目标是赋予Claude最大程度的自由，使其能生成解答问题所必需的任何想法；而正如人类思考一样，Claude在推理过程中有时也会产生错误、误导性或尚未成熟的念头。许多用户会觉得这种透明性很有价值；但另一些用户则可能对此（以及思维过程中较弱的角色化表达）感到沮丧。

Another issue is what’s known as “faithfulness”—we don’t know for certain that what’s in the thought process truly represents what’s going on in the model’s mind (for instance, English-language words, such as those displayed in the thought process, might simply not be able to describe why the model displays a particular behavior). The problem of faithfulness—and how to ensure it—is one of our active areas of research. Thus far, our results suggest that models very often make decisions based on factors that they _don’t_ explicitly discuss in their thinking process. This means we can’t rely on monitoring current models’ thinking to make strong arguments about their safety².  
另一个问题是所谓“忠实性”（faithfulness）——我们尚无法确定思维过程中所呈现的内容是否真实反映了模型内部的实际运作机制（例如，思维过程中显示的英文词汇，或许根本不足以解释模型为何表现出某种特定行为）。忠实性问题及其保障方法，正是我们当前重点研究的方向之一。截至目前的研究结果表明，模型往往依据其思维过程中**并未明确提及**的因素作出决策。这意味着，我们无法仅凭监控当前模型的思维过程，就对其安全性做出强有力的论证²。

Third, it poses several safety and security concerns. Malicious actors might be able to use the visible thought process to build better strategies to jailbreak Claude. Much more speculatively, it’s also possible that, if models learn during training that their internal thoughts are to be on display, they might be incentivized to think in different, less predictable ways—or to deliberately hide certain thoughts.  
第三，它带来若干安全与安保隐患。恶意行为者可能利用可见的思维过程，设计出更有效的越狱（jailbreak）策略来操控Claude。更具推测性的是：若模型在训练过程中习得“其内在思维将被公开展示”这一事实，它们或许会因此被激励，转而采用更不同寻常、更不可预测的思维方式——甚至刻意隐藏某些想法。

These latter concerns will be particularly acute for future, more capable versions of Claude—versions that would pose more of a risk if misaligned. We’ll weigh the pros and cons of revealing the thought process for future releases³. In the meantime, the visible thought process in Claude 3.7 Sonnet should be considered a research preview.  
上述后两类担忧，在未来能力更强的Claude版本中将尤为突出——这些版本一旦出现目标错位（misalignment），潜在风险也将显著升高。我们将在后续版本发布前，审慎权衡公开思维过程的利弊³。与此同时，Claude 3.7 Sonnet 中的可见思维过程应被视为一项研究预览（research preview）。

## **New tests of Claude’s thinking**  
## **对Claude思维能力的新测试**

### **Claude as an agent**  
### **作为智能体的Claude**

Claude 3.7 Sonnet benefits from what we might call “action scaling”—an improved capability that allows it to iteratively call functions, respond to environmental changes, and continue until an open-ended task is complete. One example of such a task is using a computer: Claude can issue virtual mouse clicks and keyboard presses to solve tasks on a user’s behalf. Compared to its predecessor, Claude 3.7 Sonnet can allocate more turns—and more time and computational power—to computer use tasks, and its results are often better.  
Claude 3.7 Sonnet 受益于我们称之为“行动扩展”（action scaling）的能力提升——该能力使其能够迭代调用函数、响应环境变化，并持续运行直至完成开放式任务。此类任务的一个典型例子便是操作计算机：Claude 可发出虚拟鼠标点击和键盘按键指令，代用户执行任务。相较于前代模型，Claude 3.7 Sonnet 在计算机操作类任务中可分配更多轮次，以及更多的时间与计算资源，因而结果通常更优。

We can see this in how Claude 3.7 Sonnet has improved on [OSWorld](https://os-world.github.io/), an evaluation that measures the capabilities of multimodal AI agents. Claude 3.7 Sonnet starts off somewhat better, but the difference in performance grows over time as the model continues to interact with the virtual computer.  
这一点可从Claude 3.7 Sonnet在[OSWorld](https://os-world.github.io/)评估中的表现提升得到印证——OSWorld 是一项用于衡量多模态AI智能体能力的评测。Claude 3.7 Sonnet 的初始表现略胜一筹，而随着模型持续与虚拟计算机交互，其性能优势随时间推移愈发明显。

![A chart showing the performance of Claude 3.5 Sonnet (new) versus Claude 3.7 on the OSWorld evaluation. Number of steps is on the x-axis; score is on the y-axis. Both models start out in around the same place and get better with a larger number of steps, but Claude 3.7 Sonnet improves more quickly.](images/claude_s-extended-thinking/img_002.jpg)The performance of Claude 3.7 Sonnet versus its predecessor model on the OSWorld evaluation, testing multimodal computer use skills. “Pass @ 1”: the model has only a single attempt to solve a particular problem for it to count as having passed.  
![一张图表，展示Claude 3.5 Sonnet（新版）与Claude 3.7在OSWorld评测中的性能对比。横轴为步数（Number of steps），纵轴为得分（score）。两模型起始位置相近，且均随步数增加而提升，但Claude 3.7 Sonnet提升速度更快。](images/claude_s-extended-thinking/img_002.jpg)Claude 3.7 Sonnet 与其前代模型在OSWorld评测中的性能对比，该项评测检验多模态计算机操作能力。“Pass @ 1”：模型仅有一次尝试机会，成功解决特定问题即视为通过。

### **Claude plays Pokémon**  
### **Claude玩宝可梦**

Together, Claude’s extended thinking and agent training help it do better on many standard evaluations like OSWorld. But they also give it a major boost on some other, perhaps more unexpected, tasks.

克劳德（Claude）的扩展式思维能力与智能体训练协同作用，使其在诸多标准评测任务（例如 OSWorld）中表现更优；但这种协同效应也在一些其他任务——甚至可能是更出人意料的任务上——为其带来显著提升。

Playing Pokémon—specifically, the Game Boy classic _Pokémon Red_—is just such a task. We equipped Claude with basic memory, screen pixel input, and function calls to press buttons and navigate around the screen, allowing it to play Pokémon continuously beyond its usual context limits, sustaining gameplay through tens of thousands of interactions.

以玩宝可梦游戏为例——特指 Game Boy 经典作品《宝可梦 红》（*Pokémon Red*）——正是这样一项任务。我们为克劳德配备了基础记忆能力、屏幕像素级视觉输入，以及用于按键操作和屏幕导航的函数调用接口，使其能够突破常规上下文长度限制，持续运行游戏，并完成数以万计的交互动作。

In the graph below, we’ve plotted the Pokémon progression of Claude 3.7 Sonnet alongside that of previous versions of Claude Sonnet, which didn’t have the option for extended thinking. As you can see, the previous versions became stuck very early in the game, with Claude 3.0 Sonnet failing to even leave the house in Pallet Town where the story begins.

下图展示了克劳德 3.7 Sonnet 在《宝可梦 红》中的游戏进度，并与此前不具备扩展式思维能力的各代克劳德 Sonnet 模型进行了对比。如图所示，早期版本在游戏初期便迅速陷入停滞：克劳德 3.0 Sonnet 甚至未能离开故事起点——小霞镇（Pallet Town）的起始房屋。

But Claude 3.7 Sonnet’s improved agentic capabilities helped it advance much further, successfully battling three Pokémon Gym Leaders (the game’s bosses) and winning their Badges. Claude 3.7 Sonnet is super effective at trying multiple strategies and questioning previous assumptions, which allow it to improve its own capabilities as it progresses.

而克劳德 3.7 Sonnet 凭借增强的智能体能力，取得了远超以往的进展：它成功挑战并击败了三位宝可梦道馆馆主（即游戏中的主要 Boss），赢得了三枚徽章。克劳德 3.7 Sonnet 极其擅长尝试多种策略、主动质疑既有假设，从而在游戏进程中持续自我优化、不断提升自身能力。

![A chart showing the performance of the various Claude Sonnet models at playing Pokémon. The number of actions taken by the AI is on the x-axis; the milestone reached in the game is on the y-axis. Claude 3.7 Sonnet is by far the most successful at achieving the game's milestones.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F9a30c8288e402eee24d4ef60272cb6365a36207a-1920x1269.png&w=3840&q=75)Claude 3.7 Sonnet demonstrates that it is the very best of all the Sonnet models so far at playing Pokémon Red. On the x-axis is the number of interactions Claude completes as it plays the game; on the y-axis are important milestones in the game involving collecting certain items, navigating to certain areas, and defeating certain game bosses.

![一张图表，展示各代克劳德 Sonnet 模型在《宝可梦 红》中的表现：横轴为 AI 执行的动作数量，纵轴为游戏中达成的关键里程碑。克劳德 3.7 Sonnet 在达成游戏里程碑方面遥遥领先。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F9a30c8288e402eee24d4ef60272cb6365a36207a-1920x1269.png&w=3840&q=75)克劳德 3.7 Sonnet 的表现证明：截至目前，它是所有 Sonnet 系列模型中玩《宝可梦 红》最出色的一个。横轴表示克劳德在游戏过程中完成的交互次数；纵轴则对应游戏中若干关键里程碑，包括获取特定道具、抵达特定区域、击败特定 Boss 等。

Pokémon is a fun way to appreciate Claude 3.7 Sonnet’s capabilities, but we expect these capabilities to have a real-world impact far beyond playing games. The model's ability to maintain focus and accomplish open-ended goals will help developers build a wide range of state-of-the-art AI agents.

《宝可梦》虽是一款趣味性十足的测试场景，却生动展现了克劳德 3.7 Sonnet 的真实能力；但我们预期，这些能力的影响将远不止于游戏领域。该模型持续专注、高效完成开放式目标的能力，将助力开发者构建种类繁多、处于行业前沿的 AI 智能体。

### **Serial and parallel test-time compute scaling**

### **串行与并行推理时计算资源扩展**

When Claude 3.7 Sonnet is using its extended thinking capability, it could be described as benefiting from “serial test-time compute”. That is, it uses multiple, sequential reasoning steps before producing its final output, adding more computational resources as it goes. In general, this improves its performance in a predictable way: its accuracy on, for example, math questions improves logarithmically with the number of “thinking tokens” that it’s allowed to sample.

当克劳德 3.7 Sonnet 启用其扩展式思维能力时，可被描述为受益于“串行式推理时计算”（serial test-time compute）。换言之，它在生成最终输出前，会执行多个连续的推理步骤，并在过程中逐步增加计算资源投入。总体而言，这种机制能以可预测的方式提升其性能：例如，在数学问题求解任务中，其准确率随允许采样的“思考 token”数量呈对数增长。

![A graph of Claude 3.7 Sonnet's mathematical performance according to how many tokens were used in its thinking process. Tokens are on the x-axis; accuracy is on the y-axis. More tokens are related to higher accuracy.](images/claude_s-extended-thinking/img_004.jpg)Claude 3.7 Sonnet’s performance on questions from the 2024 American Invitational Mathematics Examination 2024, according to how many thinking tokens it’s allowed per problem. Note that even though we allow Claude to use the entire thinking budget, it generally stops short. We include in the plot the tokens sampled that are used to summarize the final answer.

![一张图表，展示克劳德 3.7 Sonnet 在思考过程中使用不同数量 token 时的数学解题表现：横轴为 token 数量，纵轴为准确率。token 越多，准确率越高。](images/claude_s-extended-thinking/img_004.jpg)克劳德 3.7 Sonnet 在 2024 年美国数学邀请赛（AIME 2024）试题上的表现，按每道题允许使用的“思考 token”数量划分。需注意：尽管我们为其设定了完整的思考预算，它通常会在预算耗尽前主动终止推理。图中所标示的 token 数量，包含了用于总结最终答案所采样的 token。

Our researchers have also been experimenting with improving the model’s performance using _parallel_ test-time compute. They do this by sampling multiple independent thought processes and selecting the best one without knowing the true answer ahead of time. One way to do this is with [majority](https://arxiv.org/abs/2206.14858) or consensus voting; selecting the answer that appears most commonly as the 'best' one. Another is using another language model (like a second copy of Claude) asked to check its work or a learned scoring function and pick what it thinks is best. Strategies like this (along with similar work) have been reported in the evaluation [results](https://developers.googleblog.com/en/the-next-chapter-of-the-gemini-era-for-developers/) of [several](https://arxiv.org/abs/2502.06807) [other](https://arxiv.org/abs/2403.05530) [AI](https://x.ai/blog/grok-3) [models](https://openai.com/index/openai-o3-mini/)).

我们的研究人员还在探索利用**并行式推理时计算**（*parallel* test-time compute）进一步提升模型性能。具体做法是：同时采样多个彼此独立的思维链（thought processes），并在不预先知晓正确答案的前提下，从中选出最优结果。一种实现方式是采用[多数表决](https://arxiv.org/abs/2206.14858)（majority voting）或共识投票机制——即选择出现频次最高的答案作为“最优解”。另一种方式则是调用另一个语言模型（例如另一份克劳德副本）来复核其推理过程，或借助一个经过学习训练的评分函数，由其自主判断并选出最优答案。类似策略（及同类研究）已在多项评估[成果](https://developers.googleblog.com/en/the-next-chapter-of-the-gemini-era-for-developers/)中被报道，涵盖[多个](https://arxiv.org/abs/2502.06807) [其他](https://arxiv.org/abs/2403.05530) [AI](https://x.ai/blog/grok-3) [模型](https://openai.com/index/openai-o3-mini/)。

We achieved striking improvements using parallel test-time compute scaling on the [GPQA evaluation](https://arxiv.org/abs/2311.12022), a commonly-used set of challenging questions on biology, chemistry, and physics. Using the equivalent compute of 256 independent samples, a learned scoring model, and a maximum 64k-token thinking budget, Claude 3.7 Sonnet achieved a GPQA score of 84.8% (including a physics subscore of 96.5%), and benefits from continued scaling beyond the limits of majority vote. We report our results for both our scoring model methods and the majority vote method below.

我们在[GPQA评估](https://arxiv.org/abs/2311.12022)（一个常用于评估生物学、化学和物理学领域高难度问题的基准测试）中，通过并行化测试时计算扩展（parallel test-time compute scaling），取得了显著性能提升。在等效于256个独立样本的计算资源、一个训练所得的评分模型，以及最高达64k token的推理预算下，Claude 3.7 Sonnet 在 GPQA 上取得 84.8% 的总分（其中物理学子项得分为 96.5%），且其性能在超越多数投票（majority vote）能力上限后仍能持续提升。下文将分别报告我们所采用的评分模型方法与多数投票方法的实验结果。

![Four graphs showing the performance of Claude 3.7 Sonnet on the GPQA evaluation when using parallel test-time compute scaling. From top left, clockwise, they show performance on the full exam, the biology section, the physics section, ad the chemistry section. Multiple lines are shown depending on the way the evaluation was assessed.](images/claude_s-extended-thinking/img_005.jpg)Experimental results from using parallel test-time compute scaling to improve Claude 3.7 Sonnet’s performance on the GPQA evaluation. The different lines refer to different methods of scoring the performance. “Majority @ N”: where multiple outputs are generated from a model for the same prompt with the majority vote taken as the final answer; “scoring model”: a separate model which is used to assess the performance of the model being evaluated; “pass @ N”: where models “pass” a test if any of a given number of attempts succeeds.

![四张图表展示了 Claude 3.7 Sonnet 在采用并行测试时计算扩展后于 GPQA 评估中的表现。从左上角开始顺时针依次为：全卷成绩、生物学部分、物理学部分与化学部分。不同线条代表不同的评估方式。](images/claude_s-extended-thinking/img_005.jpg)采用并行测试时计算扩展提升 Claude 3.7 Sonnet 在 GPQA 评估中表现的实验结果。不同线条对应不同的性能评分方法：“Majority @ N”：对同一提示生成多个输出，并以多数投票结果作为最终答案；“scoring model”：使用一个独立训练的模型来评估被测模型的表现；“pass @ N”：若模型在给定次数的尝试中至少有一次成功，则视为“通过”该测试。

Methods like these allow us to improve the quality of Claude’s answers, usually without having to wait for it to finish its thoughts. Claude can have multiple different extended thought processes simultaneously, allowing it to consider more approaches to a problem and ultimately get it right much more often. Parallel test-time compute scaling isn’t available in our newly-deployed model, but we're continuing to research these methods for the future.

此类方法使我们得以提升 Claude 回答的质量——通常无需等待其完成全部思考过程。Claude 可同时运行多个不同的延展式思维流程，从而探索更多解题路径，显著提高正确率。目前，这一并行测试时计算扩展功能尚未集成至我们最新部署的模型中，但我们正持续开展相关研究，为未来版本做准备。

## **Claude 3.7 Sonnet’s safety mechanisms**

## **Claude 3.7 Sonnet 的安全机制**

**AI Safety Level.** Anthropic’s [Responsible Scaling Policy](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy) commits us not to train or deploy models unless we have implemented appropriate safety and security measures. Our Frontier Red Team and Alignment Stress Testing team ran extensive tests on Claude 3.7 Sonnet to determine whether it required the same level of deployment and security safeguards as our previous models—known as the AI Safety Level (ASL) 2 standard—or stronger measures.

**AI 安全等级（AI Safety Level, ASL）。** Anthropic 的[《负责任扩展政策》（Responsible Scaling Policy）](https://www.anthropic.com/news/announcing-our-updated-responsible-scaling-policy)明确承诺：除非已落实适当的安全与防护措施，否则我们不会训练或部署任何模型。我们的前沿红队（Frontier Red Team）与对齐压力测试团队（Alignment Stress Testing team）对 Claude 3.7 Sonnet 进行了全面评估，以判定其是否需沿用此前模型所采用的 AI 安全等级 2（ASL-2）标准，抑或需采取更严格的安全与部署保障措施。

Our comprehensive evaluation of Claude 3.7 Sonnet confirmed that our current ASL-2 safety standard remains appropriate. At the same time, the model demonstrated increased sophistication and heightened capabilities across all domains. In controlled studies examining tasks related to the production of Chemical, Biological, Radiological, and Nuclear (CBRN) weapons, we observed some performance “uplift” among model-assisted participants compared to non-assisted participants. That is, participants were able to get further towards success than they would have just by using information that’s available online. However, all of the attempts to perform these tasks contained critical failures, completely impeding success.

我们对 Claude 3.7 Sonnet 的综合评估确认：当前 ASL-2 安全标准依然适用。与此同时，该模型在所有领域均展现出更高水平的复杂性与更强的能力。在针对化学、生物、放射性及核（CBRN）武器研制相关任务所开展的受控研究中，我们观察到：相比未使用模型辅助的参与者，获得模型协助的参与者在任务完成度上出现了一定程度的“提升”——即他们所能达成的进展，超过了仅依靠公开网络信息所能达到的程度。然而，所有此类任务尝试均存在关键性失败，致使最终目标完全无法实现。

Expert red-teaming of the model produced mixed feedback. Whereas some experts noted improvements in the model’s knowledge in certain areas of CBRN processes, they also found that the frequency of critical failures was too high for successful end-to-end task completion. We are proactively enhancing our ASL-2 measures by accelerating the development and deployment of targeted classifiers and monitoring systems.

专家级红队测试对该模型给出了褒贬不一的反馈：一方面，部分专家指出模型在某些 CBRN 工艺环节的知识掌握上有所进步；另一方面，他们也发现关键性失败的发生频率过高，导致端到端任务无法成功完成。为此，我们正主动强化 ASL-2 措施，加速开发并部署面向特定风险的分类器与监控系统。

In addition, the capabilities of our future models might require us to move to the next stage: ASL-3 safeguards. Our recent work on [Constitutional Classifiers](https://www.anthropic.com/research/constitutional-classifiers) to prevent jailbreaks, along with other efforts, stands us in good stead to implement the requirements of the ASL-3 standard in the near future.

此外，我们后续模型所具备的能力，或将要求我们迈入下一阶段：即实施 ASL-3 级安全防护。我们近期在[宪法式分类器（Constitutional Classifiers）](https://www.anthropic.com/research/constitutional-classifiers)方面的研究工作（旨在防范越狱攻击），连同其他多项努力，已为我们短期内落实 ASL-3 标准的各项要求奠定了坚实基础。

**Visible thought process.** Even at ASL-2, Claude 3.7 Sonnet’s visible extended thinking feature is new, and thus requires new and appropriate safeguards. In rare cases, Claude’s thought process might include content that is potentially harmful (topics include child safety, cyber attacks, and dangerous weapons). In such cases, we will encrypt the thought process: this will not stop Claude from including the content in its thought process (which could still be important for the eventual production of perfectly benign responses), but the relevant part of the thought process will not be visible to users. Instead, they will see the message “the rest of the thought process is not available for this response”. We aim for this encryption to occur rarely, and only in cases where the potential for harm is high.

**可见思维过程（Visible thought process）。** 即便在 ASL-2 等级下，Claude 3.7 Sonnet 所引入的“可见延展式思考”功能亦属全新特性，因而亟需配套建立新型且恰当的安全防护机制。在极少数情况下，Claude 的思维过程可能包含潜在有害内容（涉及儿童安全、网络攻击、危险武器等主题）。此时，我们将对相关思维过程进行加密：此举并不会阻止 Claude 在其思考中包含该类内容（因其仍可能对最终生成完全无害的回答起到关键作用），但用户将无法查看该部分思维过程；取而代之的是显示提示信息：“本次响应的其余思维过程不可见”。我们力求此类加密操作仅在潜在危害性极高时才触发，且发生频次极低。

**Computer use.** Finally, we have enhanced our safety measures for Claude’s computer use ability (which we discussed above: it allows Claude to see a user’s computer screen and take actions on their behalf). We have made substantial progress in defending against “prompt injection” attacks, where a malicious third party hides a secret message somewhere where Claude may see it while using the computer, potentially tricking it into taking actions the user didn’t intend. With new training to resist prompt injection, a new system prompt that includes instructions to ignore these attacks, and a classifier that triggers when the model encounters a potential prompt injection, we now prevent these attacks 88% of the time⁴, up from 74% of the time without the mitigations.

**计算机操作能力（Computer use）。** 最后，我们进一步强化了针对 Claude 计算机操作能力的安全防护措施（前文已述：该能力允许 Claude 查看用户的电脑屏幕并代其执行操作）。我们在抵御“提示注入”（prompt injection）攻击方面取得了实质性进展——此类攻击由恶意第三方发起，其将隐秘指令隐藏于 Claude 在使用计算机过程中可能读取的任意位置，试图诱使其执行用户本无意授权的操作。通过新增的抗提示注入训练、嵌入“忽略此类攻击”指令的新系统提示（system prompt），以及在模型识别出潜在提示注入时自动触发的专用分类器，我们目前已能成功拦截 88% 的此类攻击⁴，相较未启用上述缓解措施时的 74% 拦截率显著提升。

The above is just a short summary of some of our extensive safety work on Claude 3.7 Sonnet. For more information, analytic results, and several examples of the safeguards in action, see our full [System Card](http://anthropic.com/claude-3-7-sonnet-system-card).

上述内容仅简要概述了我们在 Claude 3.7 Sonnet 上开展的部分广泛安全工作。如需了解更多信息、分析结果，以及多项防护机制实际运行的示例，请参阅完整的 [系统卡片（System Card）](http://anthropic.com/claude-3-7-sonnet-system-card)。

## **Using Claude**

## **使用 Claude**

You can use Claude 3.7 Sonnet now at [Claude.ai](http://claude.ai/redirect/website.v1.39b61e2c-3b3f-4461-af29-57f3feda34a4) or on [our API](https://docs.anthropic.com/en/api/getting-started). And just as Claude can now let you know what it thinks, we hope you’ll let us know what you think, too. Please send your feedback about the new model to [feedback@anthropic.com](mailto:feedback@anthropic.com).

您现在即可在 [Claude.ai](http://claude.ai/redirect/website.v1.39b61e2c-3b3f-4461-af29-57f3feda34a4) 或通过 [我们的 API](https://docs.anthropic.com/en/api/getting-started) 使用 Claude 3.7 Sonnet。正如 Claude 现在能够向您表达它的想法一样，我们也诚挚期待听到您的反馈。欢迎将您对这一新模型的意见发送至 [feedback@anthropic.com](mailto:feedback@anthropic.com)。
{% endraw %}
