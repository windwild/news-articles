---
title: "Our First Proof submissions | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/first-proof-submissions"
date: "2026-02-20"
scraped_at: "2026-03-02T10:08:17.940451654+00:00"
language: "en-US"
translated: true
description: "We share our AI model’s proof attempts for the First Proof math challenge, testing research-grade reasoning on expert-level problems."
tags: ["Research"]
---
&#123;% raw %}

February 20, 2026

2026 年 2 月 20 日

[Research](https://openai.com/news/research/) [研究](https://openai.com/news/research/)

[Conclusion](https://openai.com/research/index/conclusion/) [结论](https://openai.com/research/index/conclusion/)

# Our First Proof submissions

# 我们的首批“First Proof”证明提交

We’re sharing our proof attempts for First Proof, a math challenge testing if AI can produce checkable proofs on domain-specific problems.

我们正在分享针对“First Proof”的证明尝试——这是一项数学挑战，旨在检验人工智能是否能在特定领域问题上生成可验证的证明。

[View our set of proof attempts(opens in a new window)](https://cdn.openai.com/pdf/26177a73-3b75-4828-8c91-e8f1cf27aaa0/oai_first_proof.pdf)

[查看我们的全部证明尝试（在新窗口中打开）](https://cdn.openai.com/pdf/26177a73-3b75-4828-8c91-e8f1cf27aaa0/oai_first_proof.pdf)

We ran an internal model on all 10 [First Proof⁠(opens in a new window)](https://1stproof.org/) problems, a research-level math challenge designed to test whether AI systems can produce correct, checkable proof attempts. Unlike short-answer or competition-style math, these problems require building end-to-end arguments in specialized domains, and correctness is hard to establish without expert review. The authors of the First Proof problems are leading experts in their respective fields, and at least a couple of the problems were open for years before the authors found solutions. An academic department that has substantial overlap with the subject areas could conceivably solve many of the problems in one week.

我们使用内部模型对全部 10 道 [First Proof⁠（在新窗口中打开）](https://1stproof.org/) 题目进行了求解。这是一组面向研究级别的数学挑战，旨在检验 AI 系统能否生成正确且可验证的证明。与简答题或竞赛风格的数学题不同，这些题目要求在专业领域内构建完整的端到端论证；而其正确性若无专家评审则极难判定。First Proof 各题目的作者均为各自领域的顶尖专家；其中至少两道题在作者找到解答前已悬而未决多年。一个研究方向与这些题目高度重合的学术院系，理论上可在一周内解决其中多数问题。

We [shared⁠(opens in a new window)](https://x.com/merettm/status/2022517085193277874?s=20) our proof attempts on Saturday, February 14, 2026 at 12:00 AM PT. Based on feedback from experts, we believe at least five of the model’s proof attempts (problems 4, 5, 6, 9, and 10) have a high chance of being correct, and several others remain under review. We initially believed our attempt for problem 2 was likely correct. Based on the official First Proof commentary and further community analysis, we now believe it is incorrect. We’re grateful for the engagement and look forward to continued review. Our full set of proof attempts can be found [here⁠(opens in a new window)](https://cdn.openai.com/pdf/26177a73-3b75-4828-8c91-e8f1cf27aaa0/oai_first_proof.pdf). The preprint includes all ten proof attempts, plus a newly added appendix with prompt patterns and examples that aim to simulate our manual interactions with the models during the process.

我们于 2026 年 2 月 14 日（星期六）太平洋时间凌晨 12:00 [公开发布了⁠（在新窗口中打开）](https://x.com/merettm/status/2022517085193277874?s=20) 这些证明尝试。根据多位专家的反馈，我们认为模型对其中至少五道题（第 4、5、6、9 和 10 题）的证明尝试极有可能是正确的；其余几道题的证明仍在审阅中。我们最初认为第 2 题的证明尝试很可能成立；但依据 First Proof 官方发布的评注以及社区进一步的分析，我们现已确认该证明不正确。我们衷心感谢各方积极参与和深入讨论，并期待后续持续的审阅与反馈。我们的全部十份证明尝试详见 [此处⁠（在新窗口中打开）](https://cdn.openai.com/pdf/26177a73-3b75-4828-8c91-e8f1cf27aaa0/oai_first_proof.pdf)。这份预印本不仅包含全部十道题的证明，还新增了一个附录，汇总了我们在实际操作中用于与模型交互的提示模式（prompt patterns）及示例，以尽可能还原人工调用模型的过程。

We believe novel frontier research is perhaps the most important way to evaluate capabilities of next generation AI models. Benchmarks are useful, but they can miss some of the hardest parts of research: sustaining long chains of reasoning, choosing the right abstractions, handling ambiguity in problem statements, and producing arguments that survive expert scrutiny. Frontier challenges like First Proof help us stress-test those capabilities in settings where correctness is nontrivial to verify and the failure modes are informative.

我们认为，开展具有开创性的前沿研究，或许是评估下一代 AI 模型能力的最重要方式。基准测试固然有用，却可能遗漏科研中最困难的若干环节：维持长程逻辑推理、选取恰当的抽象层级、应对题目表述中的模糊性，以及产出经得起专家严格审视的论证。像 First Proof 这样的前沿挑战，正为我们提供了压力测试这些能力的理想场景——在此类场景中，正确性本身便难以轻易验证，而失败模式本身亦蕴含丰富信息。

_“We’re currently training a new model for which a primary focus is increasing the level of rigor in its thinking, with the goal that the model can think continuously for many hours and remain highly confident in its conclusions. When the First Proof problems were announced, it seemed like the perfect testbed, so over the weekend I tried it out. Already it was able to solve two of the problems (#9 and #10). As it trained, it became increasingly capable, eventually solving–in our estimation–at least three more. We were particularly pleased when it solved #6 and then, two days later, #4, as those problems were from fields familiar to many of us. It’s pretty incredible to watch a model get tangibly smarter day by day.”_

_“我们目前正在训练一款新模型，其核心目标之一是提升其思维过程的严谨性，使其能够连续思考数小时并始终对其结论保持高度置信。当 First Proof 的题目公布时，它立刻成为我们心目中理想的测试平台；因此我在那个周末便着手尝试。模型甫一上手就成功解决了其中两道题（#9 和 #10）。随着训练推进，其能力持续增强，最终据我们估计，又至少攻克了另外三道题。当我们看到它先后解出 #6（两天后又解出 #4）时尤为欣喜——因为这两道题所属的领域，正是我们团队中许多人所熟悉的。亲眼见证一个模型日复一日地变得切实更‘聪明’，实在令人惊叹。”_

– James R. Lee (OpenAI 研究员，推理方向)

– 詹姆斯·R·李（OpenAI 研究员，推理方向）

We ran the model with limited human supervision. When prompting versions of the model along training, we sometimes suggested retrying strategies that appeared fruitful in earlier attempts. For some attempts, we asked the model to expand or clarify parts of a proof after receiving expert feedback, to make the reasoning easier to verify. We also facilitated a back-and-forth between this model and ChatGPT for verification, formatting, and style. For some problems, we present the best of a few attempts, selected by human judgment. This was a fast sprint, and our process was not as clean as we would like in a properly controlled evaluation. We look forward to discussions with the First Proof organizers about a more rigorous experiment and evaluation framework for future iterations.

我们在有限的人类监督下运行了该模型。在训练过程中对不同版本的模型进行提示时，我们有时会建议重试那些在先前尝试中已显现出成效的策略。对于部分尝试，我们在收到专家反馈后，要求模型对证明中的某些部分进行扩展或澄清，以提升推理过程的可验证性。我们还促成了该模型与 ChatGPT 之间就验证、格式排版和语言风格等方面的多轮交互。针对某些问题，我们呈现的是若干次尝试中经人工判断选出的最优结果。这是一次快速推进的短期攻关，我们的流程远未达到严格受控评估所期望的严谨程度。我们期待与 “First Proof” 活动组织方展开深入讨论，共同为后续迭代设计更严谨的实验方案与评估框架。

This work builds on earlier results from frontier reasoning models in math and science. In July 2025, we reached [gold medal-level performance⁠(opens in a new window)](https://x.com/OpenAI/status/1946594928945148246?utm_source=chatgpt.com) on the International Mathematical Olympiad with a general-purpose reasoning model (35/42 points). In November 2025, we shared “ [Early experiments in accelerating science with GPT‑5](https://openai.com/index/accelerating-science-gpt-5/)”, a set of case studies where GPT‑5 helped researchers make concrete progress across math, physics, biology, and other fields, along with the limitations we observed. And most recently, we reported a [physics collaboration](https://openai.com/index/new-result-theoretical-physics/) where GPT‑5.2 proposed a candidate expression for a gluon-amplitude formula that was then formally proved by an internal model and verified by the authors.

本工作建立在前沿推理模型于数学与科学领域早期成果的基础之上。2025 年 7 月，我们借助一款通用型推理模型，在国际数学奥林匹克竞赛（IMO）中达到了[金牌水平表现⁠（在新窗口中打开）](https://x.com/OpenAI/status/1946594928945148246?utm_source=chatgpt.com)（42 分中获得 35 分）。2025 年 11 月，我们发布了《[利用 GPT‑5 加速科学研究的早期实验](https://openai.com/index/accelerating-science-gpt-5/)》，其中包含一系列案例研究，展示了 GPT‑5 如何助力研究人员在数学、物理、生物学及其他领域取得实质性进展，并总结了我们观察到的局限性。而最近，我们还报道了一项[物理学合作成果](https://openai.com/index/new-result-theoretical-physics/)：GPT‑5.2 提出了一种胶子振幅公式的候选表达式，该表达式随后由内部模型完成形式化证明，并获得论文作者的最终验证。

We look forward to deeper engagement with the community on how to evaluate research-grade reasoning, including expert feedback on these attempts, and we’re excited to make these new capabilities available in future public models.

我们期待与学术界展开更深入的交流，共同探讨如何评估达到科研水准的推理能力——包括就本次各项尝试征询专家意见；同时，我们也非常期待将这些全新能力集成至未来面向公众发布的模型中。

- [2026](https://openai.com/news/?tags=2026)

- [2026](https://openai.com/news/?tags=2026)
&#123;% endraw %}
