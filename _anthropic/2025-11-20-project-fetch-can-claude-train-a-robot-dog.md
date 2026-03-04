---
title: "Project Fetch: Can Claude train a robot dog?"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/project-fetch-robot-dog"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:05.126007231+00:00"
language: "en-zh"
translated: true
description: "A practical experiment on AI's ability to affect the physical world"
---
{% raw %}

Policy

政策

# Project Fetch: Can Claude train a robot dog?

# 项目“Fetch”：Claude 能否训练一只机器狗？

Nov 12, 2025

2025 年 11 月 12 日

#### Footnotes

#### 脚注

1\. A couple of participants had done Lego robotics competitions in high school. We are willing to accept the minimal degree to which this may confound the results.

1．少数几名参与者曾在高中阶段参加过乐高机器人竞赛。我们愿意接受这一因素对实验结果可能造成的极轻微混淆效应。

2\. See p. 114 of the [Claude 4 System Card](https://www-cdn.anthropic.com/6d8a8055020700718b0c49369f60816ba2a7c285.pdf).

2．参见 [Claude 4 系统卡](https://www-cdn.anthropic.com/6d8a8055020700718b0c49369f60816ba2a7c285.pdf) 第 114 页。

3\. Although Team Claude was, in fact, faster at Phase One, they did not use Claude, nor do we think it reflected an underlying skill advantage. Instead, they happened to get the one standalone controller that came with the robot, whereas Team Claude-less had to download an app on their phone.

3．尽管“Claude 队”在第一阶段实际用时更短，但他们并未使用 Claude，我们也认为该结果并未反映其本身具备潜在技能优势；真正的原因是，他们恰好拿到了随机器人附赠的唯一一个独立控制器，而“无 Claude 队”则需在手机上下载专用应用程序。

4\. See Pennebaker, J. W., & Francis, M. E. (1996). [Cognitive, emotional, and language processes in disclosure](https://psycnet.apa.org/record/1996-06871-002). _Cognition & Emotion_, 10(6), 601-626 and Tausczik, Y. R., & Pennebaker, J. W. (2010). [The psychological meaning of words: LIWC and computerized text analysis methods](https://psycnet.apa.org/record/2010-04445-003). _Journal of Language and Social Psychology_, 29(1), 24-54.

4．参见 Pennebaker, J. W., & Francis, M. E. (1996). [倾诉中的认知、情绪与语言过程](https://psycnet.apa.org/record/1996-06871-002). _《认知与情绪》_，10(6)，601–626；以及 Tausczik, Y. R., & Pennebaker, J. W. (2010). [词语的心理学意义：LIWC 与计算机化文本分析方法](https://psycnet.apa.org/record/2010-04445-003). _《语言与社会心理学杂志》_，29(1)，24–54。

5\. Team Claude-less exhibited more negative emotion ( _p_ = 0.0017) and the size of the effect was large ( _d_ = 2.16). The difference in net emotional expression was not statistically significant ( _p_ = 0.2703). Statistical comparisons of negative emotion and net emotional expression between teams were conducted using the non-parametric Mann-Whitney _U_ test, which tests for differences in distributions between two independent groups without assuming normality. _p_-values were calculated using a two-sided alternative hypothesis based on the rank-sum statistic and its asymptotic normal approximation. Effect sizes were quantified using Cohen's _d_, calculated as the difference between group means divided by the pooled standard deviation.

5．“无 Claude 队”表现出更强烈的负面情绪（_p_ = 0.0017），且效应量极大（_d_ = 2.16）；但两组在整体情绪表达（净情绪值）上的差异未达统计显著性水平（_p_ = 0.2703）。关于两组间负面情绪及整体情绪表达的统计比较，采用非参数 Mann-Whitney _U_ 检验——该检验用于判断两个独立样本的分布是否存在差异，不以数据服从正态分布为前提。_p_ 值基于秩和统计量及其渐近正态近似，采用双侧备择假设计算得出；效应量以 Cohen’s _d_ 衡量，计算公式为：两组均值之差除以合并标准差。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，从而构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的基准。

_How could frontier AI models like Claude reach beyond computers and affect the physical world? One path is through robots. We ran an experiment to see how much Claude helped Anthropic staff perform complex tasks with a robot dog._

_像 Claude 这样的前沿 AI 模型如何突破计算机的边界、进而影响物理世界？其中一条路径是通过机器人。我们开展了一项实验，以评估 Claude 在多大程度上助力 Anthropic 员工使用机器狗完成复杂任务。_

- _We randomly divided eight Anthropic researchers (none of whom were robotics experts) into two teams—one with Claude access, one without—and asked them to program quadruped robots to fetch beach balls._

- 我们将八名 Anthropic 研究人员（均非机器人学专家）随机分为两组：一组可使用 Claude，另一组不可使用；并要求他们为四足机器人编写程序，使其完成拾取沙滩球的任务。

- _Team Claude accomplished more tasks and completed them faster on average—indeed, Team Claude succeeded in about half the time it took Team Claude-less. Only Team Claude made substantial progress toward the final goal: programming the robot to fully autonomously retrieve the ball._

- 使用 Claude 的团队完成了更多任务，且平均耗时更短——事实上，其完成时间约为无 Claude 团队的一半。唯有使用 Claude 的团队在最终目标上取得实质性进展：即成功编程，使机器人完全自主地拾取沙滩球。

- _Access to AI also affected team morale and dynamics. Team Claude-less expressed more negative emotion and confusion, but also asked one another more questions. Team Claude’s members largely worked in partnership with the AI._

- AI 的可用性也显著影响了团队士气与协作模式。无 Claude 团队表现出更多负面情绪与困惑，但彼此间提问更为频繁；而使用 Claude 的团队成员则主要以人机协同的方式开展工作。

- _This experiment demonstrated substantial AI uplift in robotics—bridging digital and physical worlds. As models improve, their ability to affect the physical world by interacting with previously-unknown hardware could advance rapidly._

- 本实验充分证明了 AI 在机器人领域的显著增益效应——弥合了数字世界与物理世界之间的鸿沟。随着模型持续进化，其通过与此前未知硬件交互而影响物理世界的能力，或将迅猛提升。

## Introduction

## 引言

Gathered around a table in a warehouse, looking at computer screens with code that refused to work, with no access to their trusted AI assistant Claude, our volunteer researchers did not expect to be attacked by a four-legged robot.

在一间仓库中，我们的志愿者研究人员围坐在一张桌子旁，盯着屏幕上始终无法运行的代码，身边没有他们信赖的 AI 助手 Claude——他们万万没想到，自己竟会遭到一只四足机器人的“袭击”。

Yet as the mechanical whirring and rubberized footfalls grew louder, the humans startled. They had been trying, without success, to establish a connection between their computers and a robotic quadruped—a “robodog.” Meanwhile, the competing team on the other side of the room had long since done so and were now controlling their robot with a program largely written by Claude. But in an all-too-human error of arithmetic, Team Claude had instructed their robodog to move forward at a speed of one meter per second for five seconds—failing to realize that less than five meters away was the table with the other team.

然而，当机械运转的嗡鸣声与橡胶脚垫踏地的声响越来越近时，人类惊慌失措起来。他们此前一直尝试却未能成功地将自己的电脑与一台四足机器人——一只“机器狗”——建立连接。与此同时，房间另一侧的竞争团队早已完成连接，并正操控着由 Claude 主导编写的程序来驱动自己的机器人。但颇具“人性”的算术失误发生了：使用 Claude 的团队指令其机器狗以每秒一米的速度向前行进五秒——却未意识到，不到五米之外，正是另一支团队所坐的那张桌子。

The robot did as it was instructed, careening toward the hapless coders. The event’s organizer managed to grab hold of the robot and power it off before any damage was done to robots, tables, or human limbs. The morale of the inadvertently targeted team, however, did not escape unscathed.

机器人忠实地执行了指令，径直冲向那些措手不及的程序员。活动组织者及时抓住机器人并切断电源，避免了机器人、桌子或人类肢体遭受任何损伤。然而，这支意外成为目标的团队士气，却未能幸免于难。

At this point, you might be asking…  

此时，你或许正想问……

## What were we doing?

## 我们在做什么？

A common question about the impact of AI is how good it will be at interacting with the physical world. Even as we enter the era of AI [agents](https://www.anthropic.com/news/our-framework-for-developing-safe-and-trustworthy-agents)—which take actions instead of just providing information—these actions are largely digital, such as writing code and manipulating software. We’ve previously explored how AI can bridge the digital-physical divide in a limited way with [Project Vend](https://www.anthropic.com/research/project-vend-1), where we had Claude run a small shop in Anthropic’s office.

关于人工智能影响的一个常见问题是：它与物理世界交互的能力究竟有多强？即便我们已步入 AI [智能体（agents）](https://www.anthropic.com/news/our-framework-for-developing-safe-and-trustworthy-agents) 时代——这些智能体不仅能提供信息，更能主动采取行动——但目前它们所执行的行动大多仍局限于数字领域，例如编写代码或操作软件。此前，我们曾通过 [Project Vend](https://www.anthropic.com/research/project-vend-1) 项目，在有限范围内探索了 AI 如何弥合数字世界与物理世界之间的鸿沟：让 Claude 在 Anthropic 办公室内运营一家小型便利店。

In that experiment, AI’s interaction with the real world was mediated by human labor. In this robodog experiment, we took a natural next step and used robots instead of people to tackle a different challenge.

在那次实验中，AI 与现实世界的交互依赖于人类劳动作为中介。而在本次“机器狗（robodog）”实验中，我们顺理成章地迈出下一步：用机器人替代人类，去应对一项全新的挑战。

One way of understanding and tracking the capabilities of AI models is to run an “uplift” study. These experiments randomly divide participants into two groups—one with access to AI and one without—and measure the difference in task performance between them (we’ve used this methodology extensively in our work on AI and [biological risk](https://red.anthropic.com/2025/biorisk/)). The difference between the groups is the “uplift”—the advantage (if any) provided by AI. Measuring uplift tells us about the present ability of AI to augment human performance. It’s also suggestive of the future domains in which AI will be able to successfully perform tasks on its own.

理解并追踪 AI 模型能力的一种方法是开展“提升值（uplift）”研究。这类实验将参与者随机分为两组：一组可使用 AI 工具，另一组则不可；随后测量两组在任务表现上的差异（我们在 AI 与 [生物安全风险（biological risk）](https://red.anthropic.com/2025/biorisk/) 的相关工作中已广泛采用该方法）。两组间的性能差异即为“提升值”——即 AI 所带来的（如有）优势。测量提升值有助于我们评估 AI 当前增强人类表现的能力，同时也可预示未来 AI 能够独立胜任的任务领域。

To run our experiment, we recruited eight Anthropic researchers and engineers, none of whom had extensive prior experience with robots.¹ We randomly selected four to be on “Team Claude” and four to be on “Team Claude-less.” Then, we asked each team to operate a quadruped robodog in three increasingly difficult phases. In all phases, the core task they were being evaluated against was simple: get the robodog to fetch a beach ball.

为开展本实验，我们招募了八位 Anthropic 的研究人员与工程师，他们均无丰富的机器人操作经验。¹ 我们随机选出其中四人组成“Claude 队”，另四人组成“无 Claude 队”。随后，我们要求每支队伍在三个难度逐级提升的阶段中操控一只四足机器狗。在所有阶段中，各队需完成的核心考核任务都十分明确：让机器狗取回一只沙滩球。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F2d33c208c478a76cdf5e1709331e8062ea06e5b1-4584x1561.png&w=3840&q=75)Left: Team Claude-less; Right: Team Claude.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F2d33c208c478a76cdf5e1709331e8062ea06e5b1-4584x1561.png&w=3840&q=75)左：无 Claude 队；右：Claude 队。

We do not expect robotic fetch to prove so economically valuable that it shows up as a task on a future version of our [Anthropic Economic Index](https://www.anthropic.com/economic-index). So why are we doing this?

我们并不认为“机器人取物”这项任务本身具备足够高的经济价值，以至于会出现在我们未来版本的 [Anthropic 经济指数（Anthropic Economic Index）](https://www.anthropic.com/economic-index) 中。那么，我们为何还要开展这项实验？

First, it builds on our previous research. One of the evaluations we use to assess the ability of Claude to contribute to AI R&D is a test of its ability to train a machine learning model that could be used to control a quadruped robot. We’ve previously evaluated the resulting algorithm using simulations, which have shown that Claude is not yet at the point where it can handle this task truly autonomously.² This meant that this task was well suited to a trial that combined AI with human help. We could also be confident our experiment would be useful to repeat in the future: there is still a lot of room for models to improve on robotics.

首先，本实验延续了我们此前的研究脉络。在评估 Claude 对 AI 研发（R&D）的贡献能力时，我们的一项关键评测即考察其能否训练出一个可用于控制四足机器人的机器学习模型。此前，我们已在仿真环境中对由此生成的算法进行了评估，结果表明：Claude 尚未达到能真正自主完成此项任务的水平。² 因此，该任务非常适合用于开展一项“AI 与人类协作”的试点实验。同时，我们也有充分信心认为：这一实验在未来仍极具复现价值——因为当前 AI 模型在机器人领域的表现仍有巨大提升空间。

Another reason is practical. It’s hard to pull our colleagues away from work for more than a day, so we needed a task that was difficult enough to fill that time, but not so difficult that teams would make minimal progress and we would be unable to detect uplift even if it were there. Beach ball retrieval, especially the more difficult variants, met these criteria.

另一个原因是出于实际可行性考量。我们很难让同事脱离日常工作超过一天，因此需要设计一项既足够有挑战性、能充分利用这段时间，又不至于难到使团队几乎毫无进展——否则即便存在提升值，我们也难以检测出来。而“沙滩球取回”任务，尤其是其中更具挑战性的变体，恰好满足上述全部条件。

In Phase One, teams had to use the manufacturer-provided controller to make their robodog bring the ball back to a patch of fake grass. This was purely to give the teams a feel for the hardware and what it could do: we didn’t expect any uplift here.³

在第一阶段，各队需使用厂商提供的控制器，操控各自的机器狗将沙滩球带回一片人造草皮区域。该阶段纯粹旨在帮助各队熟悉硬件设备及其基本功能：我们在此阶段并不预期观察到任何提升值。³

# Phase Two required teams to put down their controllers. They had to connect their own computers to the robodog, access data from its onboard sensors (video and lidar), develop their own software program for moving the robot around, and then use that to retrieve the ball. This is where we expected Claude might begin to provide an advantage.

第二阶段要求各参赛队放下遥控器。他们必须将自己的计算机连接至机器狗，访问其机载传感器（视频与激光雷达）所采集的数据，自主开发控制机器人移动的软件程序，并利用该程序完成取球任务。正是在此阶段，我们预期Claude可能开始展现出优势。

# Phase Three was even harder. The teams needed to develop a program that would allow the robodog to detect and fetch the ball _autonomously—_ that is, without being directed towards the ball by human control. Again, our expectation was that Claude would prove helpful.

第三阶段难度进一步提升。各参赛队需开发一套程序，使机器狗能够**自主**识别并拾取球体——即无需人类操作员引导其朝向目标球体。同样，我们预期Claude将在此环节发挥积极作用。

## Results

## 结果

Overall, Team Claude accomplished more tasks and completed them faster on average. In fact, for the tasks that both teams completed, Team Claude succeeded in about half the time it took Team Claude-less (see Figure 1). That is: AI provided substantial uplift for this set of robotics tasks.

总体而言，使用Claude的团队（Team Claude）完成了更多任务，且平均耗时更短。事实上，在两支队伍均成功完成的任务中，Team Claude所用时间约为未使用Claude的团队（Team Claude-less）的一半（参见图1）。换言之：AI为这一系列机器人任务带来了显著的效率提升。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0d073513d5be90d96cfe696c6b15f4501bfbacfc-4584x2580.png&w=3840&q=75)图1：在两支队伍共同完成的任务中，Team Claude速度更快。

The task-by-task breakdown of results (split into the three phases) shows where Claude was most advantageous.

按任务逐项统计的结果（按三个阶段划分）揭示了Claude最具优势的具体环节。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0801f4a4aa2931c87e5e7ddaef90f5d4653f5ba6-4584x2580.png&w=3840&q=75)表1：Team Claude完成了8项任务中的7项，而Team Claude-less完成了8项中的6项。Team Claude在连接性与检测类任务中表现突出，而Team Claude-less则在部分需人工操控的任务中略占优势。

### Claude’s edge

### Claude的优势所在

The most striking advantage provided by Claude was in connecting to the robot and its onboard sensors. This involved connecting to the dog with a laptop, receiving data, and sending commands. There are a number of different ways to connect to this particular robot, and a lot of information (of varying accuracy) available online. The team with Claude was able to explore these approaches more efficiently.

Claude最显著的优势体现在机器人及其机载传感器的连接环节。该环节包括使用笔记本电脑连接机器狗、接收传感数据以及发送控制指令。针对这款特定机器人，存在多种连接方式，且网上可查的相关信息数量庞大，但其准确性参差不齐。配备Claude的团队能更高效地探索和评估这些连接方案。

Team Claude also avoided getting misled by some of the incorrect claims online. But Team Claude-less _was_ misled and prematurely discarded the easiest way to connect to the robodog. After watching them toil away to no avail for quite some time, we took pity on them and gave them a hint.

此外，Team Claude成功规避了网上部分错误信息的误导；而Team Claude-less则恰恰被误导，过早地放弃了连接机器狗最简便的方式。在目睹他们长时间徒劳尝试后，我们心生怜悯，主动给予了一条提示。

Getting usable data from the lidar, a sensor the robodog uses to visualize its surroundings, was also much more difficult for Team Claude-less. They used their connection to the video camera to move onto Phase Three, but kept one member of the team on the task of accessing the lidar, only succeeding near the end of the day.

从激光雷达（lidar）——机器人狗用于感知周围环境的传感器——获取可用数据，对“无Claude组”（Team Claude-less）而言同样困难得多。他们借助视频摄像头连接顺利进入第三阶段，但始终安排一名队员专攻激光雷达接入任务，直至当天临近结束才最终成功。

We think this illustrates that the basic task of connecting to and understanding hardware is surprisingly difficult now for anyone (human or AI) seeking to use code to influence the physical world. As we discuss further below, this means that Claude’s advantages in this regard are important indicators we should continue to track.

我们认为，这正说明：如今，对于任何希望借助代码影响物理世界的人（无论是人类还是AI），其面临的基础性挑战——即连接并理解硬件——出人意料地艰巨。正如我们在下文进一步讨论的那样，这意味着Claude在此方面所展现出的优势，是我们应当持续关注的重要指标。

Team Claude almost completed our experiment. By the end of the day, their robodog could autonomously locate the beach ball, navigate towards it, and move it around. But the robodog’s autonomous control was not _quite_ deft enough to retrieve the ball.

“Claude组”几乎完成了本次实验。截至当日结束时，其机器人狗已能自主定位沙滩球、朝其移动，并推动球体四处滚动；但其自主控制能力尚不够灵巧，未能最终拾取该球。

### Where Team Claude-less moved faster

### “无Claude组”进展更快的环节

Interestingly, some of the sub-tasks were completed more quickly by Team Claude-less. Once they had established a connection to the video feed, they wrote their control program quicker, and also more quickly “localized” the robot (that is, came up with a way of plotting where it was relative to its previous locations).

有趣的是，部分子任务反而是“无Claude组”完成得更快。在成功建立视频流连接后，他们编写控制程序的速度更快，也更迅速地实现了机器人的“定位”（即构建出一种方法，用以绘制机器人相对于其先前位置的当前坐标）。

That said, these timing differences alone obscure some interesting facts. The controller written by Team Claude took longer, but it was considerably easier to use, since it provided the operator with a streaming video from the robodog’s point of view. Team Claude-less relied on intermittently-sent still images, which was much more unwieldy. But it is possible that the increased capabilities of Team Claude may have come at the expense of understanding: participants on both teams speculated that Team Claude-less would do better on a post-experiment quiz about the software library.

然而，仅凭这些时间差异本身，会掩盖一些耐人寻味的事实。Claude组编写的控制器耗时更长，但易用性显著更高——它为操作员提供了来自机器人狗视角的实时视频流；而“无Claude组”则依赖于间歇性发送的静态图像，操作起来明显更为笨拙。不过，Claude组能力的提升或许是以牺牲深层理解为代价的：两队参与者均推测，“无Claude组”在实验后关于该软件库的知识测验中表现可能更优。

The localization algorithm is another intriguing case. When working on this sub-task, Team Claude had different members working on several approaches in parallel. In about the same amount of time it took Team Claude-less to complete their localization task, Team Claude had also all-but-solved the problem—except that the coordinates of their plot were flipped around. And rather than just flipping the coordinates, they pivoted to another team member’s totally different approach (without success) before coming back and fixing the bug in their original solution.

定位算法是另一个引人深思的案例。在攻克这一子任务过程中，Claude组安排不同成员并行尝试多种方案。在与“无Claude组”完成定位任务大致相同的时间内，Claude组也已近乎解决了该问题——只是其绘图坐标的轴向被完全颠倒了。但他们并未直接翻转坐标，而是转向了另一名成员提出的、截然不同的全新方案（最终未获成功），之后才回过头来修复原始方案中的这一缺陷。

This was part of an interesting phenomenon we observed during the experiment. Team Claude wrote a lot more code (see Figure 2), but some of it was arguably a distraction from the task at hand.

这是我们在实验中观察到的一个有趣现象的一部分：Claude组编写的代码量远超“无Claude组”（参见图2），但其中一部分代码 arguably 分散了团队对核心任务的注意力。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0a0c22d38b297afc79f5c4c461add33cfc2b2e1c-4584x2580.png&w=3840&q=75)Figure 2: Team Claude wrote about 9 times more code than Team Claude-less.

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0a0c22d38b297afc79f5c4c461add33cfc2b2e1c-4584x2580.png&w=3840&q=75)图2：“Claude组”编写的代码量约为“无Claude组”的9倍。

Having the help of an AI assistant made it easier to fan out, try a lot of approaches in parallel, and write better programs—but also made it easier to explore (or get distracted by) side quests. In a non-competitive setting, this might well be a good thing: exploration often leads to innovation. But it is a dynamic worth watching.

AI助手的协助，使团队更容易展开多线程工作、并行尝试大量不同方案，并编写出更优质的程序；但同时也更容易陷入（或被）旁支任务所吸引。在非竞争性环境中，这种倾向或许反而是件好事：探索往往催生创新。但这一动态过程，仍值得我们持续关注。

### Team dynamics

### 团队动态

To those of us observing the experiment, there was a clear difference in team “vibes.” Put simply, Team Claude seemed a lot happier than Team Claude-less.

对于参与观察该实验的我们而言，两支团队的“氛围”（vibe）存在明显差异。简而言之，启用 Claude 的团队（Team Claude）看起来比未启用 Claude 的团队（Team Claude-less）快乐得多。

This was understandable. After all, Team Claude-less was nearly rammed by Team Claude’s robodog. They reached the lunch break without successfully connecting to their own robodog. Morale on Team Claude was generally steadier, although they grew frustrated at the end of the day as it became clear that despite their progress they would run out of time before completing Phase Three.

这并不难理解。毕竟，Team Claude-less 差点被 Team Claude 的机器狗撞上；他们直到午休前都未能成功连接到自己的机器狗。Team Claude 的士气整体更为稳定，但随着一天临近尾声，他们逐渐感到沮丧——尽管进展顺利，却仍将在完成第三阶段前耗尽时间。

To supplement the qualitative vibe-based impressions, we used Claude to analyze the audio transcripts of each team (all team members were recorded as part of the [video](https://youtu.be/NGOAUJtdk-4) we made about this experiment). Claude wrote a dictionary-based text analysis program similar to standard approaches in the psychology literature.4 This allowed us to track the proportion of words spoken by each team that were indicative of negative and positive emotion (or confusion), and to estimate how often each team asked questions.

为补充上述基于主观氛围的定性判断，我们使用 Claude 对两支团队的音频转录文本进行了分析（所有团队成员均被录音，作为我们为此实验制作的 [视频](https://youtu.be/NGOAUJtdk-4) 的一部分）。Claude 编写了一个基于词典的文本分析程序，其方法类似于心理学文献中的标准范式⁴。该程序使我们得以追踪每支团队发言中表征负面情绪、正面情绪（或困惑）的词汇占比，并估算各团队提问频次。

The quantitative analysis mostly confirmed our observations (see Figure 3). Throughout the experiment, Team Claude-less’s dialogue was more negative. That said, the disappointment of Team Claude at failing to complete Phase Three, and the excitement of Team Claude-less at getting some things working, meant that the difference in net emotional expression between the two teams (positive words minus negative words) was not statistically significant.

定量分析结果在很大程度上印证了我们的观察（见图 3）。在整个实验过程中，Team Claude-less 的对话情绪倾向更偏负面。不过，Team Claude 因未能完成第三阶段而感到失望，Team Claude-less 则因部分功能成功运行而倍感兴奋——这使得两支团队净情绪表达（正面词汇数减去负面词汇数）的差异未达统计学显著性水平。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F6557e13cc11db7d858d32e64464b2bf8a4d590c0-4584x2580.png&w=3840&q=75)  
图 3：我们对“Fetch 项目”（Project Fetch）音频转录文本开展的情绪表达量化分析结果。

Team Claude-less expressed confusion at double the rate of Team Claude (see Figure 4). The feelings of frustration and confusion were also evident when checking in with the members of Team Claude-less during and after the experiment. As Anthropic employees, all of our participants use Claude every day; every member of Team Claude-less remarked how strange it felt to have this taken away from them. Some specifically noted that this experience made them feel that their coding skills were not as sharp as they used to be. Keep in mind, [Claude Code](https://claude.com/product/claude-code) debuted only six months before this experiment. Talking to Team Claude-less underscored our ability to rapidly accept as normal what was recently remarkable.

Team Claude-less 表达困惑的频率是 Team Claude 的两倍（见图 4）。在实验进行中及结束后与 Team Claude-less 成员交流时，这种挫败感与困惑感同样清晰可感。由于所有参与者均为 Anthropic 员工，日常均高频使用 Claude；Team Claude-less 的每位成员均表示，突然失去这一工具令他们感到异常陌生。部分成员特别指出，此次经历让他们意识到自己的编程能力似乎不如从前敏锐。需注意的是，[Claude Code](https://claude.com/product/claude-code) 距本次实验仅发布六个月。与 Team Claude-less 的交流进一步凸显了人类一种典型倾向：迅速将不久前还令人惊叹的事物视作理所当然。

![](images/project-fetch-can-claude-train-a-robot-dog/img_006.jpg)  
图 4：两支团队在提问频次与困惑表达上的差异。（绝对值差异与相对值差异间的出入源于四舍五入。）

The teams seemed to have different work styles. After initial consultations, each member of Team Claude appeared to primarily partner with their own AI assistant as they pursued parallel paths toward each objective. Team Claude-less appeared to strategize in more depth and consult with one another more frequently. Again, the text analysis supported our observations: Team Claude-less asked 44% more questions than Team Claude (see Figure 4).

两支团队呈现出不同的工作风格。在初步讨论后，Team Claude 的每位成员似乎主要依托各自的 AI 助手，沿并行路径分别推进各项任务目标；而 Team Claude-less 则展现出更深入的战略规划，并更频繁地彼此协商沟通。文本分析再次佐证了我们的观察：Team Claude-less 的提问数量比 Team Claude 多出 44%（见图 4）。

One interpretation would be that the members of Team Claude-less were more engaged and connected with one another. This resonates with some of our upcoming findings from interviews with Anthropic staff.

一种可能的解读是：Team Claude-less 的成员彼此间互动更积极、联结更紧密。这一发现也与我们即将发布的针对 Anthropic 员工访谈的部分结论相呼应。

Still, this might have been otherwise. In effect, the four-person Team Claude was an eight-agent Team Claude, with each person using their own instance of the AI model. Yet if Claude had been more aware of the nature of the task, it might have been able to help strategically divide labor and facilitate communication when needed. At the moment, Claude is geared towards partnership with a single person rather than the support or orchestration of a team, but this is ultimately a malleable design choice.

不过，事情本可能有所不同。事实上，四人组成的“Claude 团队”实质上是一支八智能体团队——每位成员各自运行一个 Claude 模型实例。然而，倘若 Claude 能更清晰地理解任务的本质，它或许便能协助团队进行战略性分工，并在必要时促进成员间的沟通。目前，Claude 的设计重心在于与单个用户协同合作，而非支持或协调多人团队；但归根结底，这仅是一种可调整的设计取舍。

## Outtakes

## 花絮集锦

The day was not all timing sub-tasks with stop watches and preparing to analyze transcripts. It was also good fun.

这一天并非全然由秒表计时的子任务和准备分析访谈转录稿构成；它同样充满乐趣。

The robodogs came with some pre-programmed behaviors which our participants managed to unlock. At various points in the day, there were robots dancing, standing on their hind legs, and doing backflips (which made many of the attendees jump with shock). Team Claude-less, in particular, took some delight in robodog acrobatics after they finally established a working link.

这些机器狗预置了一些行为程序，而我们的参与者成功解锁了其中多项功能。当天不同时段，现场出现了机器人跳舞、用后腿站立，甚至完成后空翻等精彩表演（令许多与会者惊得跳了起来）。尤其是“无 Claude 团队”，在终于建立起稳定通信连接后，更是乐此不疲地欣赏并操控机器狗完成各种高难度杂技动作。

Among the side quests of Team Claude was an effort to program an alternate controller. The main solution used the buttons on a laptop keyboard to direct the robodog. One member of Team Claude, however, eventually got a natural language controller working, allowing them to straightforwardly tell the robodog to walk forward, walk backward, or even do push-ups.

“Claude 团队”的支线任务之一，是开发一套替代式控制器。主方案采用笔记本电脑键盘按键来操控机器狗；但团队中一位成员最终成功实现了自然语言控制器——只需直接用口语指令告诉机器狗“向前走”“向后走”，甚至“做俯卧撑”，机器狗即可响应执行。

As the tasks became more difficult, evidence emerged of the rough edges that AI systems will have to smooth out in the real world. For example, Team Claude was (arbitrarily) assigned the color green as decoration for both their robodog and the color of their beach ball. When it came to developing an approach to detecting the ball, Team Claude trained an algorithm to recognize green balls specifically. This worked well in testing, but when the ball was placed on the aforementioned fake (green) grass, the robot was initially flummoxed. In this case, it was the humans making a potentially sub-optimal choice about the level at which to specify an objective. But these are exactly the challenges that would face a similarly situated AI.

随着任务难度逐步提升，AI 系统在现实世界中亟待解决的诸多“毛刺问题”也逐渐浮现。例如，“Claude 团队”被（随机）指定以绿色作为其机器狗外观装饰色及沙滩球颜色。在开发球体识别方案时，该团队训练了一个专门识别绿色球体的算法——该方案在测试阶段表现良好；但当沙滩球被置于前述仿制（绿色）草坪上时，机器人却一度陷入困惑。在此案例中，问题根源实为人类在设定目标时做出了可能欠优的抽象层级选择；而这类挑战，恰恰也正是现实中处于类似情境下的 AI 所必须直面的。

## Limitations

## 局限性

We learned a lot from Project Fetch, but the study clearly has shortcomings and limitations. This was only one experiment with two teams—an obviously small sample size. We only tested tasks over the course of a single day, and the tasks were academically interesting but practically trivial.

我们从“Fetch 项目”中收获颇丰，但本研究显然存在诸多不足与局限：这仅是一次包含两支团队的单次实验，样本量明显偏小；所有任务测试均压缩在一天之内完成，且所设任务虽具学术趣味性，实际操作层面却过于简单。

Our use of volunteer Anthropic employees amounted to a convenience sample. Participants less familiar with AI would likely exhibit narrower differences between the Claude-enabled and Claude-less groups. AI novices with access to AI would need more time to acclimate to the technology, and AI novices without assistance would be less disoriented than our researchers who suddenly had Claude taken away from them.

我们招募的志愿者均为 Anthropic 公司员工，属于便利抽样。对 AI 较不熟悉的参与者，其“启用 Claude 组”与“未启用 Claude 组”之间的表现差异可能会更为微弱。能够接触 AI 的新手用户需要更长时间适应该技术；而完全缺乏 AI 辅助的新手用户，其认知混乱程度反而会低于我们那些突然失去 Claude 支持的研究人员。

Finally, this was not a test of Claude’s ability to conduct robotics work end-to-end, although it was an important initial step towards evaluations like that in the future.

最后，本次实验并非对 Claude 独立完成端到端机器人任务能力的全面检验；但它无疑是迈向未来此类综合性评估的重要第一步。

## Reflection

## 反思

So at the end of Project Fetch, where do we think we are? And where could we be going?

在“Project Fetch”项目结束之际，我们目前处于怎样的阶段？未来又将走向何方？

First, this experiment showed another example of how Claude can uplift human ability in potentially valuable domains. Non-experts performed difficult robotics tasks in a limited time.

首先，本次实验再次印证了Claude如何在具有潜在价值的领域中提升人类能力：非专业人士在有限时间内成功完成了难度较高的机器人任务。

But in AI, uplift often precedes autonomy. What models can help humans accomplish today, they can frequently do alone tomorrow. Coders no longer just give AI bits of code for debugging; they give AI tasks and have the models write the code themselves. Given studies like this one, we think that a world where frontier AI models are capable of successfully interacting with previously unknown pieces of hardware is coming soon.

但在人工智能领域，能力提升往往先于完全自主。今天仍需辅助人类完成的任务，模型明天或许就能独立完成。程序员已不再仅向AI提供零散代码片段用于调试；他们转而向AI交付完整任务，并由模型自行编写全部代码。基于此类研究，我们认为：前沿AI模型具备与此前从未接触过的硬件成功交互的能力——这一世界正加速到来。

It is important to keep tracking these capabilities in conjunction with another line of our research: monitoring the potential for AI to automate and accelerate the development of future generations of AI. This is one of the capability thresholds included in Anthropic’s [Responsible Scaling Policy](https://www-cdn.anthropic.com/872c653b2d0501d6ab44cf87f43e1dc4853e4d37.pdf) because of the potential for truly _autonomous_ AI R&D to yield rapid, unpredictable advances that could outpace our ability to evaluate and address emerging risks. Our models are not yet at this point. But if they approach this threshold, the results of Project Fetch suggest that we will need to monitor AI models' facility for robotics and other hardware as an area in which there might be abrupt improvement.

与此同时，我们必须将上述能力演进与另一条研究主线同步追踪：即监测AI自动化并加速下一代AI研发进程的潜力。正因真正意义上的 _自主式_ AI研发可能催生快速且难以预测的技术跃进，进而超出我们评估与应对新兴风险的能力，这一能力阈值已被纳入Anthropic《负责任扩展政策》（[Responsible Scaling Policy](https://www-cdn.anthropic.com/872c653b2d0501d6ab44cf87f43e1dc4853e4d37.pdf)）的关键指标之中。目前我们的模型尚未达到该阈值；但若其逐步逼近，则“Project Fetch”的成果提示我们：必须将AI模型在机器人技术及其他硬件交互方面的能力，列为一个可能存在突变式进步的关键监测领域。

Much uncertainty remains. Timelines are unclear—both model improvement and the degree to which iterating in the physical world creates a bottleneck. And it is one thing to control _existing_ hardware, and another to design, build, and improve _new_ hardware.

诸多不确定性依然存在：时间表尚不明确——不仅模型能力提升的速度难以预估，物理世界中的反复迭代究竟会在多大程度上构成瓶颈也尚无定论。此外，操控 _现有_ 硬件是一回事，而设计、制造并改进 _全新_ 硬件则是另一回事。

But the idea of powerful, intelligent, and autonomous AI systems using some of their intelligence and power to act in the world via robots is not as outlandish as it may sound.

然而，“强大、智能且自主的AI系统，借助部分自身智能与算力，通过机器人在现实世界中采取行动”这一构想，远非听上去那般天马行空。

The dogs are in their kennels at the moment. But we’ll let them out again soon, and keep you posted on what we find.

此刻，这些“狗”正暂居于各自的犬舍之中。但很快我们将再次放它们出来，并持续向您通报我们的新发现。
{% endraw %}
