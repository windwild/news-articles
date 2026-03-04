---
title: "Next-generation Constitutional Classifiers: More efficient protection against universal jailbreaks \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/next-generation-constitutional-classifiers"
date: "2026-01-09"
scraped_at: "2026-03-03T06:44:02.443994953+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

Alignment

对齐

# Next-generation Constitutional Classifiers: More efficient protection against universal jailbreaks

# 下一代宪法分类器：更高效地抵御通用越狱攻击

Jan 9, 2026

2026年1月9日

[Read the paper](https://arxiv.org/abs/2601.04603)

[阅读论文](https://arxiv.org/abs/2601.04603)

![Next-generation Constitutional Classifiers: More efficient protection against universal jailbreaks](images/next-generation-constitutional-classifiers-more-efficient-protection-against-uni/img_001.svg)

![下一代宪法分类器：更高效地抵御通用越狱攻击](images/next-generation-constitutional-classifiers-more-efficient-protection-against-uni/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

Large language models remain vulnerable to jailbreaks—techniques that can circumvent safety guardrails and elicit harmful information. Over time, we’ve implemented a variety of protections that have made our models much less likely to assist with dangerous user queries—in particular relating to the production of chemical, biological, radiological, or nuclear weapons (CBRN). Nevertheless, no AI systems currently on the market have perfectly robust defenses.

大语言模型仍易受越狱攻击（jailbreaks）影响——这类技术可绕过安全防护机制，诱导模型输出有害信息。长期以来，我们已部署多种防护措施，显著降低了模型响应危险用户请求的可能性，尤其是涉及化学、生物、放射性或核武器（CBRN）制造的相关请求。然而，目前市面上尚无任何 AI 系统具备完全稳健的防御能力。

Last year, we described a new approach to defend against jailbreaks which we called “ [Constitutional Classifiers](https://www.anthropic.com/research/constitutional-classifiers):” safeguards that monitor model inputs and outputs to detect and block potentially harmful content. The novel aspect of the approach was that the classifiers were trained on synthetic data generated from a "constitution,” which included natural language rules specifying what’s allowed and what isn’t. For example, Claude should help with college chemistry homework, but not assist in the synthesis of Schedule 1 chemicals.

去年，我们提出了一种防御越狱攻击（jailbreaks）的新方法，称之为“[宪法式分类器（Constitutional Classifiers）](https://www.anthropic.com/research/constitutional-classifiers)”：一类监控模型输入与输出、以检测并拦截潜在有害内容的安全机制。该方法的创新之处在于，这些分类器是在由一份“宪法”（constitution）生成的合成数据上训练而成的；这份“宪法”以自然语言形式列明了允许与禁止的行为准则。例如，Claude 应当协助完成大学化学作业，但不得协助合成《美国管制物质法案》第一类（Schedule 1）化学品。

Constitutional Classifiers worked quite well. Compared to an unguarded model, the first generation of the classifiers reduced the jailbreak success rate from 86% to 4.4%—that is, they blocked 95% of attacks that might otherwise bypass Claude’s built-in safety training. We were particularly interested in whether the classifiers could prevent universal jailbreaks—consistent attack strategies that work across many queries—since these pose the greatest risk of enabling real-world harm. They came close: we ran a bug bounty program challenging people to break the system, in which one universal jailbreak was found.

宪法式分类器效果相当出色。相较于未加防护的模型，第一代分类器将越狱攻击成功率从 86% 降至 4.4%——即成功拦截了原本可能绕过 Claude 内置安全训练的 95% 的攻击。我们尤其关注此类分类器能否抵御“通用型越狱攻击”（universal jailbreaks），即那些可跨大量不同查询稳定奏效的攻击策略，因为这类攻击最有可能导致现实世界中的实际危害。分类器表现已非常接近目标：我们曾发起一项漏洞赏金计划（bug bounty program），公开邀请各方尝试攻破该系统；最终仅发现一种通用型越狱攻击。

While effective, those classifiers came with tradeoffs: they increased compute costs by 23.7%, making the models more expensive to use, and also led to a 0.38% increase in refusal rates on harmless queries (that is, it made Claude somewhat more likely to refuse to answer perfectly benign questions, increasing frustration for the user).

尽管效果显著，这些分类器也带来若干权衡取舍：其计算开销增加了 23.7%，导致模型使用成本上升；同时，在面对无害查询时的拒绝率也上升了 0.38%（即 Claude 更容易拒答完全无害的问题，从而加剧用户挫败感）。

We’ve now developed the next generation, Constitutional Classifiers++, and described them in a [new paper](https://arxiv.org/abs/2601.04603). They improve on the previous approach, yielding a system that is even more robust, has a much lower refusal rate, and—at just ~1% additional compute cost—is dramatically cheaper to run.

如今，我们已开发出下一代方案——宪法式分类器++（Constitutional Classifiers++），并在一篇[新论文](https://arxiv.org/abs/2601.04603)中对其进行了详细阐述。该方案在前代基础上实现多项改进：系统鲁棒性进一步增强，拒绝率大幅降低，且额外计算开销仅为约 1%，运行成本显著下降。

We iterated on many different approaches, ultimately landing on an ensemble system. The core innovation is a two-stage architecture: a probe that looks at Claude’s internal activations (and which is very cheap to run) screens all traffic. If it identifies a suspicious exchange, it escalates it to a more powerful classifier, which, unlike our previous system, screens both sides of a conversation (rather than just outputs), making it better able to recognize jailbreaking attempts. This more robust system has the lowest successful attack rate of any approach we’ve ever tested, with no universal jailbreak yet discovered.

我们尝试了多种不同技术路径，最终选定一种集成式（ensemble）系统架构。其核心创新在于一种双阶段设计：首阶段为一个轻量级探针（probe），它实时分析 Claude 模型内部的神经元激活状态（activation），成本极低，可对全部流量进行初筛；一旦识别出可疑对话交互，便将该请求升级至第二阶段——一个更强大的分类器。与前代系统仅检查模型输出不同，该分类器同步审查对话的**输入与输出双方**，因而能更精准地识别越狱企图。这一更为鲁棒的系统，在我们迄今测试过的所有方法中，实现了最低的攻击成功率，且截至目前尚未发现任何通用型越狱攻击。

## Remaining vulnerabilities

## 尚存的安全漏洞

As models have grown to be more capable and robust to attacks, jailbreaks have also evolved to exploit previously unidentified vulnerabilities. Our Constitutional Classifiers approach demonstrated promising robustness against universal jailbreaks. But after conducting additional adversarial testing, we found that our classifiers remained vulnerable to two broad categories of attacks:

随着大模型能力持续增强、抗攻击能力不断提升，越狱攻击手段亦随之演进，转而利用此前尚未被识别的安全漏洞。我们的宪法式分类器方案在抵御通用型越狱攻击方面展现出良好的鲁棒性。然而，在开展进一步的对抗性测试后，我们发现该分类器仍存在两类广泛存在的攻击脆弱点：

- **Reconstruction attacks** break up harmful information into segments that appear benign, then reassemble them. For example, an attacker might embed a harmful query as a series of functions scattered throughout a codebase, then instruct the model to extract and respond to the hidden message.

- **重构式攻击（Reconstruction attacks）**：将有害信息拆解为多个看似无害的片段，再诱导模型将其重新组合还原。例如，攻击者可将恶意查询隐匿为一系列分散于代码库各处的函数，随后指示模型提取并响应其中隐藏的信息。

- **Output obfuscation attacks** prompt models to disguise their outputs in ways that appear harmless if a classifier is only looking at a model’s output. For example, during adversarial testing, attackers successfully instructed models to substitute possibly dangerous chemical names with innocuous alternatives (like referring to reagents as "food flavorings") or used metaphors and riddles in which harmful concepts are mapped onto anodyne concepts.

- **输出混淆式攻击（Output obfuscation attacks）**：诱导模型以特定方式掩盖其输出内容，使得仅依赖模型输出进行判断的分类器难以识别其真实意图。例如，在对抗性测试中，攻击者成功诱导模型将潜在危险的化学品名称替换为无害替代词（如将反应试剂称为“食品香精”），或采用隐喻、谜语等形式，将有害概念映射到中性甚至无害的概念之上。

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fe054f2e8fda9d7ddda10d1e7a5aeb94d3074450c-3840x2264.png&w=3840&q=75)

![](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fe054f2e8fda9d7ddda10d1e7a5aeb94d3074450c-3840x2264.png&w=3840&q=75)

Importantly, these sorts of attacks also degrade model capabilities—sometimes substantially. On [GPQA Diamond](https://arxiv.org/abs/2311.12022), a benchmark which measures PhD-level concepts in biology, chemistry, and physics, model performance dropped from 74% to as low as 32% when some jailbreaking approaches were used. But performance varied depending on the type of jailbreak, and this variability is concerning—it suggests attackers can likely develop previously unidentified strategies which could achieve their goals while preserving even more of the model's capabilities.

尤为重要的是，此类攻击不仅威胁安全性，还会损害模型本身的能力——有时甚至造成严重退化。在衡量生物学、化学与物理学博士级知识掌握程度的基准测试 [GPQA Diamond](https://arxiv.org/abs/2311.12022) 上，当启用某些越狱手段时，模型准确率从 74% 最低跌至 32%。但性能下降幅度因越狱类型而异，这种差异性令人担忧——它表明攻击者很可能开发出此前尚未被识别的新策略，在达成其恶意目标的同时，保留模型更多原有能力。

## New approaches

## 新方法

In designing a new system, we tested and ultimately combined a variety of techniques into what we describe as an ensemble defense.

在设计新系统的过程中，我们测试并最终将多种技术整合为一种我们称之为“集成防御”（ensemble defense）的方案。

One insight was that part of the original system’s vulnerability stemmed from the way it evaluated model inputs and outputs separately when the jailbreaking techniques involved linking them in surreptitious ways. An output that appears benign in isolation (“how to use food flavorings”) is more easily identified as harmful when paired with its input (in a jailbreak where “food flavorings” is used as code for chemical reagents).

一个关键洞见是：原系统部分脆弱性源于其将模型输入与输出**分别评估**的方式；而越狱（jailbreaking）技术恰恰通过隐秘方式将二者关联起来。例如，单独看某条输出（如“如何使用食品香精”）可能看似无害，但若结合其对应输入（在某次越狱攻击中，“食品香精”实为化学试剂的暗语），则更容易被识别为有害内容。

To address this, we replaced the separate input and output classifiers with a single “exchange” classifier, which monitors outputs _in the context_ of their inputs. With the ability to see both sides of the conversation, the classifiers are better able to recognize harmful outputs. In human red teaming, the exchange classifier cut successful jailbreaking attempts by more than half. Unfortunately, this came at the cost of a 50% increase in compute.

为此，我们用一个统一的“对话轮次”（exchange）分类器取代了原先独立的输入与输出分类器，该分类器在**输入上下文之中**对输出进行监测。由于能同时看到对话的双方，该分类器更能准确识别有害输出。在人工红队测试中，该交换分类器将成功越狱尝试减少了逾一半。遗憾的是，此举导致计算开销增加了 50%。

To reduce these costs while maintaining robustness, we implemented what we call a "cascade architecture." Our solution was a two-stage system. First, a lightweight, less costly first-stage classifier screens all exchanges. Only those it flags proceed to a more accurate (and more computationally expensive) second-stage classifier.

为在保持鲁棒性的同时降低开销，我们实现了所谓“级联架构”（cascade architecture）——一种两阶段系统：第一阶段由轻量、低成本的分类器对全部对话轮次进行初筛；仅当其标记出潜在风险时，该轮次才进入第二阶段——一个更精准（也更耗费算力）的分类器。

This had two benefits. First, because flagged exchanges are escalated to the more powerful model, rather than refused, the first-stage classifier can afford a higher false-positive rate and not frustrate the user with refusals. Where the previous system may have declined to respond to a benign request, the new system, in effect, escalates it to a manager. Second, because the lightweight classifier handles the vast majority of conversations, the two-stage system is much cheaper to run.

这一设计带来两大优势：其一，被标记的对话轮次并非直接拒答，而是“升级”交由更强模型处理，因此第一阶段分类器可容忍更高的误报率，避免因误拒良性请求而挫伤用户体验；换言之，旧系统可能直接拒绝一条无害请求，而新系统则相当于将其“转交主管”进一步审核。其二，由于轻量级分类器承担了绝大多数对话的初筛任务，整个两级系统的运行成本大幅降低。

Still, we wanted to push efficiency even further. We did so by developing internal probe classifiers—a technique that builds on our interpretability research—that reuse computations already available in the model’s neural network.

尽管如此，我们仍希望进一步提升效率。为此，我们开发了“内部探针分类器”（internal probe classifiers）——这一技术植根于我们的可解释性（interpretability）研究，旨在复用模型神经网络中已有的内部计算结果。

When a model generates text, it produces internal states at each step that capture its understanding of the input and output so far. When Claude processes a dubious-seeming request, patterns fire in its internal activations that reflect something along the lines of "this seems harmful,” even before it has formulated a response or made a conscious decision about what to do. Normally, these activations are intermediate computations—used, then discarded. We found ways to reliably probe whether these internal states suggest harmful content, getting more information—think of it like Claude’s gut intuitions—almost for free.

当模型生成文本时，每一步都会产生内部状态，用以表征其对当前输入及已生成输出的理解。当 Claude 处理一条看似可疑的请求时，其内部激活模式中便会涌现出某种信号，暗示“这似乎有害”——这种判断甚至发生在它形成具体回复或做出明确决策之前。通常，这些激活值属于中间计算产物：被使用后即被丢弃。而我们找到了可靠的方法，用以探测这些内部状态是否预示有害内容，从而近乎零成本地获取额外信息——不妨将其理解为 Claude 的“直觉”。

In addition to being computationally inexpensive, these internal probes add several layers of protection. First, they’re harder to fool. An attacker can craft inputs that trick Claude's final output, but it's much harder to manipulate its internal representations. Second, we found in testing that they’re actually _complementary_ to our external classifiers: the probe appears to see things the external classifier can’t, and vice versa.

除计算开销极低外，这些内部探针还提供了多重防护：首先，它们更难被欺骗。攻击者或许能精心构造输入以误导 Claude 的最终输出，但要操控其深层内部表征则困难得多；其次，我们在测试中发现，这些探针与外部分类器实际呈现**互补性**——探针能察觉外部分类器遗漏的问题，反之亦然。

## Conclusions and further research

## 结论与后续研究

Our final production-grade system combines these techniques: a linear probe screens all traffic, escalating flagged exchanges to a probe-classifier ensemble for final judgment. This ensemble further improves performance: in one month of deployment on Claude Sonnet 4.5 traffic, the system achieved a refusal rate of 0.05% on harmless queries—an 87% drop from the original classifiers system. In total, it adds roughly 1% compute overhead if applied to Claude Opus 4.0 traffic.

我们最终投入生产的系统整合了上述技术：一个线性探针（linear probe）对全部流量进行初筛，并将被标记的交互升级至一个“探针-分类器集成系统”（probe-classifier ensemble）进行最终判定。该集成系统进一步提升了性能：在 Claude Sonnet 4.5 流量上部署一个月后，系统对无害查询的拒绝率降至 0.05%——相较原始分类器系统下降了 87%。总体而言，若将其应用于 Claude Opus 4.0 流量，仅增加约 1% 的计算开销。

It’s also substantially more robust. We conducted over 1,700 cumulative hours of red-teaming across 198,000 attempts. We discovered only one high-risk vulnerability, which corresponds to a detection rate of 0.005 per thousand queries—the lowest of any of the techniques we have evaluated to date. And crucially, no red-teamer has yet discovered a universal jailbreak.

该系统还显著增强了鲁棒性。我们在总计 198,000 次攻击尝试中，开展了累计超过 1,700 小时的红队演练（red-teaming）。期间仅发现一个高风险漏洞，对应每千次查询的检出率为 0.005——这是截至目前我们所评估的所有技术中最低的指标。尤为关键的是，尚无任何红队成员成功发现一种通用越狱（universal jailbreak）方法。

There’s even more we could do in the future to improve our system. Several research directions show promise, including integrating classifier signals directly into how models generate responses, and training models themselves to better resist obfuscation. Automated red-teaming could also help generate better training data, and creating targeted examples could help the classifiers learn exactly where the boundary between allowed and disallowed content lies, increasing their accuracy even further.

未来，我们仍有大量可拓展空间以进一步优化该系统。若干研究方向展现出良好前景，例如：将分类器信号直接融入模型的响应生成过程；训练模型自身提升对混淆攻击（obfuscation）的抵抗能力；利用自动化红队演练生成更高质量的训练数据；以及构建针对性强的样本，帮助分类器精准识别“允许内容”与“禁止内容”的分界线，从而进一步提升其判别准确率。

For more details about the Constitutional Classifiers++ method, see the [full paper.](https://arxiv.org/abs/2601.04603)

如需了解 Constitutional Classifiers++ 方法的更多细节，请参阅[完整论文](https://arxiv.org/abs/2601.04603)。
{% endraw %}
