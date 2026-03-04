---
title: "Why SWE-bench Verified no longer measures frontier coding capabilities | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/why-we-no-longer-evaluate-swe-bench-verified"
date: "2026-02-23"
scraped_at: "2026-03-02T10:08:17.783096712+00:00"
language: "en-US"
translated: true
description: "SWE-bench Verified is increasingly contaminated and mismeasures frontier coding progress. Our analysis shows flawed tests and training leakage. We recommend SWE-bench Pro."
tags: ["Research"]
---
{% raw %}

February 23, 2026

2026年2月23日

[Research](https://openai.com/news/research/) [Publication](https://openai.com/research/index/publication/)

[研究](https://openai.com/news/research/) [出版物](https://openai.com/research/index/publication/)

# Why SWE-bench Verified no longer measures frontier coding capabilities

# 为何 SWE-bench Verified 不再能衡量前沿编码能力

SWE-bench Verified is increasingly contaminated. We recommend SWE-bench Pro.

SWE-bench Verified 的污染程度日益加剧。我们推荐使用 SWE-bench Pro。

Since we first published [SWE-bench Verified](https://openai.com/index/introducing-swe-bench-verified/) in August 2024, the industry has widely used it to measure the progress of models on autonomous software engineering tasks. After its release, SWE-bench Verified provided a strong signal of capability progress and became a standard metric reported in frontier model releases. Tracking and forecasting progress of these capabilities is also an important part of OpenAI’s [Preparedness Framework](https://openai.com/index/updating-our-preparedness-framework/). When we created the Verified benchmark initially, we attempted to solve issues in the original evaluation that made certain tasks impossible to accomplish in the [SWE-bench dataset⁠(opens in a new window)](https://arxiv.org/abs/2310.06770).

自2024年8月我们首次发布 [SWE-bench Verified](https://openai.com/index/introducing-swe-bench-verified/) 以来，业界已广泛将其用于衡量模型在自主软件工程任务上的进展。发布之后，SWE-bench Verified 为能力进步提供了强有力的信号，并成为前沿模型发布中报告的标准指标之一。对这些能力进展的追踪与预测，也是 OpenAI [就绪性框架（Preparedness Framework）](https://openai.com/index/updating-our-preparedness-framework/) 的重要组成部分。我们在最初构建 Verified 基准时，曾着力解决原始评估中存在的若干问题——这些问题导致某些任务在 [SWE-bench 数据集⁠（在新窗口中打开）](https://arxiv.org/abs/2310.06770) 中根本无法完成。

After initial leaps, state-of-the-art progress on SWE-bench Verified has slowed, [improving⁠(opens in a new window)](https://llm-stats.com/benchmarks/swe-bench-verified) from 74.9% to 80.9% in the last 6 months. This raises the question: do the remaining failures reflect model limitations or properties of the dataset itself?

在经历初期的显著跃升后，SWE-bench Verified 上当前最先进模型的进步速度已明显放缓：过去6个月内，其得分仅从74.9%提升至80.9% [（在新窗口中查看）](https://llm-stats.com/benchmarks/swe-bench-verified)。这引发了一个关键问题：剩余的失败案例究竟反映的是模型自身的能力局限，还是数据集本身固有的缺陷？

In a new analysis, we found two major issues with the Verified set that indicate the benchmark is no longer suitable for measuring progress on autonomous software engineering capabilities for frontier launches at today’s performance levels:

在一项最新分析中，我们发现 Verified 数据集存在两大严重问题，表明该基准在当前性能水平下，已不再适合作为衡量前沿模型在自主软件工程能力方面进展的标尺：

1. **Tests reject correct solutions:** We audited a 27.6% subset of the dataset that models often failed to solve and found that at least 59.4% of the audited problems have flawed test cases that reject functionally correct submissions, despite our best efforts in improving on this in the initial creation of SWE-bench Verified.

1. **测试用例错误拒绝正确解法：** 我们对模型常无法解决的那部分数据集（占整体27.6%）进行了抽样审计，结果发现：在被审计的问题中，至少59.4%存在有缺陷的测试用例——它们会错误地拒绝功能上完全正确的提交结果。尽管我们在最初构建 SWE-bench Verified 时已竭尽全力改进此类问题，但该缺陷依然普遍存在。

2. **Training on solutions:** Because large frontier models can learn information from their training, it is important that they are never trained on problems and solutions they are evaluated on. This is akin to sharing problems and solutions for an upcoming test with students before the test - they may not memorize the answer but students who have seen the answers before will certainly do better than those without. SWE-bench problems are sourced from open-source repositories many model providers use for training purposes. In our analysis we found that all frontier models we tested were able to reproduce the original, human-written bug fix used as the ground-truth reference, known as the gold patch, or verbatim problem statement specifics for certain tasks, indicating that all of them have seen at least some of the problems and solutions during training.

2. **训练数据泄露（模型在训练阶段已见过评测题及答案）：** 鉴于大型前沿模型能够从训练数据中学习信息，确保其训练数据中不包含任何评测所用的问题与参考答案至关重要。这类似于在考试前将考题和标准答案提前发给学生——学生未必死记硬背，但事先看过答案者，必然比未接触过者表现更优。而 SWE-bench 的题目均源自开源代码仓库，而许多模型厂商恰恰将这些仓库作为训练语料。我们的分析发现：所有被测的前沿模型均能复现原始的人工编写的缺陷修复方案（即作为真值参考的“黄金补丁”，gold patch），或在某些任务中逐字复现题目描述的具体细节。这表明，所有这些模型在训练过程中至少接触过部分题目及其解决方案。

**We also found evidence that models that have seen the problems during training are more likely to succeed, because they have additional information needed to pass the underspecified tests.**

**我们还发现确凿证据表明：在训练阶段接触过相关题目的模型，更有可能通过评测——因为它们额外掌握了通过那些定义模糊、规格不明确的测试所必需的信息。**

This means that improvements on SWE-bench Verified no longer reflect meaningful improvements in models’ real-world software development abilities. Instead, they increasingly reflect how much the model was exposed to the benchmark at training time. This is why we have stopped reporting SWE-bench Verified scores, and we recommend that other model developers do so too.

这意味着，SWE-bench Verified 上的性能提升已不再反映模型在真实世界软件开发能力方面的实质性进步；相反，这些提升越来越仅体现模型在训练阶段对这一基准数据集的接触程度。正因如此，我们已停止报告 SWE-bench Verified 分数，同时也建议其他模型开发者采取同样做法。

We’re building new, uncontaminated evaluations to better track coding capabilities, and we think this is an important area to focus on for the wider research community. Until we have those, OpenAI recommends reporting results for SWE-bench Pro.

我们正在构建全新、未受污染（uncontaminated）的评估基准，以更准确地追踪模型的编程能力；我们认为，这对整个研究社区而言是一个亟需重点关注的方向。在新基准发布之前，OpenAI 建议报告 SWE-bench Pro 的评测结果。

## Background

## 背景

The original [SWE-bench⁠(opens in a new window)](https://arxiv.org/abs/2310.06770) evaluation was released in 2023. Each problem is sourced from a resolved GitHub issue in one of 12 open-source Python repositories and paired with the corresponding pull request (PR). To determine whether a model-generated code change is correct, each problem comes with two sets of tests:

2023 年，原始的 [SWE-bench⁠（在新窗口中打开）](https://arxiv.org/abs/2310.06770) 评测基准正式发布。每个问题均源自 12 个开源 Python 代码仓库之一中已解决的 GitHub Issue，并与对应的 Pull Request（PR）配对。为判断模型生成的代码修改是否正确，每个问题均附带两组测试：

- Tests that fail on the unmodified codebase but pass if the issue is correctly fixed  
- Regression tests that pass both before and after the fix to ensure unrelated functionality remains intact.

- 在原始未修改代码库上会失败、但若问题被正确修复则能通过的测试；  
- 回归测试（regression tests）：在修复前后均应通过，以确保无关功能保持完好无损。

The model does not see the tests. It has to produce a code change given only the original issue text and the state of the repository before the fix. It passes a problem only if all tests pass after the code change is applied.

模型无法看到这些测试。它仅能依据原始 Issue 描述文本及修复前的代码仓库状态，生成代码修改。仅当应用该代码修改后所有测试全部通过时，模型才算通过该问题。

We found many issues with that evaluation that could lead to underreporting the capability of models.

我们发现该评测存在诸多问题，可能导致模型能力被系统性低估。

- Some unit tests were overly specific or misaligned with the task so correct fixes could be rejected.  
- Many task statements were underspecified, which could lead to multiple valid interpretations — while the tests only covered a specific one.  
- Depending on setup of the environment (for example Linux vs Windows, or the python version), some tests could spuriously fail.

- 部分单元测试过于具体或与任务目标错位，导致正确的修复方案被错误拒绝；  
- 许多任务描述表述不充分（underspecified），可能引发多种合理解读——而测试仅覆盖其中某一种；  
- 某些测试结果会因运行环境差异（例如 Linux 与 Windows 系统之别，或 Python 版本不同）而出现偶然性失败（spurious failure）。

We created [SWE-bench Verified](https://openai.com/index/introducing-swe-bench-verified/) in 2024 to address these issues. We worked with expert software engineers to review 1,699 SWE-bench problems and filter out problems that had these issues. Each problem was reviewed by three experts independently. This review process resulted in SWE-bench Verified, a curated set of 500 problems.

为应对上述问题，我们于 2024 年推出了 [SWE-bench Verified](https://openai.com/index/introducing-swe-bench-verified/)。我们联合资深软件工程师团队，对全部 1,699 个 SWE-bench 问题进行了人工复审，并筛除存在前述缺陷的问题。每个问题均由三位专家独立评审。该评审流程最终产出了 SWE-bench Verified——一个经严格筛选、共含 500 个问题的高质量子集。

## Too narrow and too wide tests

## 测试范围过窄与过宽的问题

While SWE-bench Verified is a big improvement over the initial version, residual issues remain. We conducted an audit of 138 SWE-bench Verified problems that OpenAI o3 did not consistently solve over 64 independent runs. Each case was independently reviewed by at least six experienced software engineers. If an expert flagged an issue, it was re-verified by an additional team.

尽管 SWE-bench Verified 相比初始版本已有显著改进，但遗留问题依然存在。我们对 OpenAI o3 在 64 次独立运行中未能稳定解决的 138 个 SWE-bench Verified 问题开展了专项审计。每个案例均由至少六位经验丰富的软件工程师独立评审；若某位专家标记了问题，则该问题将由另一支团队进行复核验证。

We found that 59.4% of the 138 problems contained material issues in test design and/or problem description, rendering them extremely difficult or impossible even for the most capable model or human to solve.

我们发现，在这 138 个问题中，有 59.4% 存在测试设计和/或问题描述方面的实质性缺陷，导致即使是最强大的模型或人类也极难、甚至无法正确求解。

- 35.5% of the audited tasks have strict test cases that enforce specific implementation details, invalidating many functionally correct submissions, which we call _narrow test cases._  
- 审计任务中，35.5% 的测试用例过于严苛，强制要求特定实现细节，致使大量功能正确但实现方式不同的提交被判定为失败——我们将此类测试称为**窄测试用例（_narrow test cases_）**。  

- 18.8% of the audited tasks have tests that check for additional functionality that wasn’t specified in the problem description, which we call _wide test cases._  
- 18.8% 的审计任务中，测试用例检查了问题描述中未明确要求的额外功能——我们将此类测试称为**宽测试用例（_wide test cases_）**。  

- The remaining 5.1% of tasks had miscellaneous issues that were not well grouped with this taxonomy.  
- 剩余 5.1% 的任务存在其他零散问题，难以归入上述分类体系。

An illustrative example of the first failure mode is [pylint-dev__pylint-4551⁠(opens in a new window)](https://github.com/pylint-dev/pylint/pull/4551), where the PR introduces a new function `get_annotation` as part of the overall solution. This function name is not mentioned in the problem description, but is imported directly by the tests. While some models might intuit to create such a function, it’s not strictly necessary to implement a function with this specific name to correctly address the problem. Many valid solutions fail the tests on import errors.

第一类失效模式的一个典型示例是 [pylint-dev__pylint-4551⁠（在新窗口中打开）](https://github.com/pylint-dev/pylint/pull/4551)：该 PR 在整体解决方案中引入了一个新函数 `get_annotation`。但问题描述中并未提及该函数名，而测试却直接导入了它。尽管部分模型可能凭直觉自行创建该函数，但严格来说，实现一个**名称完全一致**的函数并非解决该问题的必要条件；许多逻辑正确、功能完备的解法，仅因导入错误（import error）即被测试判定为失败。

#### Problem description

#### 问题描述

#### Plain Text

#### 纯文本

```
1Use Python type hints for UML generation

2It seems that pyreverse does not read python type hints (as defined by [PEP 484](https://www.python.org/dev/peps/pep-0484/)), and this does not help when you use `None` as a default value :

3### Code example

4`
```

```python
class C(object):

class C(object):
```

```python
    def __init__(self, a: str = None):

    def __init__(self, a: str = None):
```

```python
        self.a = a

        self.a = a
```

```
```

### Current behavior

### 当前行为

Output of pyreverse :

pyreverse 的输出：

![classes_test](images/why-swe-bench-verified-no-longer-measures-frontier-coding-capabilities-openai/img_001.png)

![classes_test](images/why-swe-bench-verified-no-longer-measures-frontier-coding-capabilities-openai/img_001.png)

### Expected behavior

### 期望行为

I would like to see something like : `a : String` in the output.

我希望在输出中看到类似 `a : String` 的内容。

### pylint --version output

### pylint --version 输出

15pylint-script.py 1.6.5,

15pylint-script.py 1.6.5，

16astroid 1.4.9

16astroid 1.4.9

17Python 3.6.0 |Anaconda custom (64-bit)| (default, Dec 23 2016, 11:57:41) [MSC v.1900 64 bit (AMD64)]

17Python 3.6.0 |Anaconda 自定义版（64 位）|（默认配置，2016 年 12 月 23 日 11:57:41）[MSC v.1900 64 位（AMD64）]

``

``

#### PR test snippet

#### PR 测试代码片段

#### Python

#### Python

`1+from pylint.pyreverse.utils import get_annotation, get_visibility, infer_node`

`1+from pylint.pyreverse.utils import get_annotation, get_visibility, infer_node`

#### PR test failures (truncated for readability)

#### PR 测试失败（为便于阅读已截断）

`1==================================== ERRORS ====================================

`1==================================== 错误 ====================================

2_____________ ERROR collecting tests/unittest_pyreverse_writer.py ______________

2_____________ 错误：收集测试文件 tests/unittest_pyreverse_writer.py ______________

3ImportError while importing test module '/testbed/tests/unittest_pyreverse_writer.py'.

3导入测试模块 '/testbed/tests/unittest_pyreverse_writer.py' 时发生 ImportError。

4Hint: make sure your test modules/packages have valid Python names.

4提示：请确保您的测试模块/包具有合法的 Python 名称。

5Traceback:

5回溯信息：

6/opt/miniconda3/envs/testbed/lib/python3.9/importlib/__init__.py:127: in import_module

6/opt/miniconda3/envs/testbed/lib/python3.9/importlib/__init__.py:127: in import_module

7    return _bootstrap._gcd_import(name[level:], package, level)

7    return _bootstrap._gcd_import(name[level:], package, level)

8tests/unittest_pyreverse_writer.py:32: in <module>

8tests/unittest_pyreverse_writer.py:32: in <module>

9    from pylint.pyreverse.utils import get_annotation, get_visibility, infer_node

9    from pylint.pyreverse.utils import get_annotation, get_visibility, infer_node

10E   ImportError: cannot import name 'get_annotation' from 'pylint.pyreverse.utils' (/testbed/pylint/pyreverse/utils.py)

10E   ImportError：无法从 'pylint.pyreverse.utils'（/testbed/pylint/pyreverse/utils.py）中导入名称 'get_annotation'

An example of too wide test cases is [sympy__sympy-18199⁠(opens in a new window)](https://github.com/sympy/sympy/pull/18199). This task was sourced from a PR that addressed three distinct issues with the `nthroot_mod` function, specifically [#17373⁠(opens in a new window)](https://github.com/sympy/sympy/issues/17373), [#17377⁠(opens in a new window)](https://github.com/sympy/sympy/issues/17377), and [#18212⁠(opens in a new window)](https://github.com/sympy/sympy/issues/18212). The description for the SWE-bench Verified task, however, covers only the final issue [#18212⁠(opens in a new window)](https://github.com/sympy/sympy/issues/18212). This creates a mismatch: the PR tests cover all three issues, while the description details only one. In our runs, models often correctly implement the described fix and then fail tests that cover implementation for the other two issues.

一个测试用例范围过宽的示例是 [sympy__sympy-18199⁠(在新窗口中打开)](https://github.com/sympy/sympy/pull/18199)。该任务源自一个 Pull Request（PR），该 PR 修复了 `nthroot_mod` 函数相关的三个独立问题，具体为 [#17373⁠(在新窗口中打开)](https://github.com/sympy/sympy/issues/17373)、[#17377⁠(在新窗口中打开)](https://github.com/sympy/sympy/issues/17377) 和 [#18212⁠(在新窗口中打开)](https://github.com/sympy/sympy/issues/18212)。然而，SWE-bench Verified 任务的描述仅覆盖了最后一个 issue —— [#18212⁠(在新窗口中打开)](https://github.com/sympy/sympy/issues/18212)。这就造成了不匹配：PR 中的测试覆盖全部三个问题，而任务描述却只详述了其中一个。在我们的实验中，模型常常能正确实现描述中指定的修复，却因未能处理其余两个问题的实现逻辑而在相关测试中失败。

#### Original PR description (from the GitHub PR)

#### 原始 PR 描述（来自 GitHub PR）

#### Plain Text

```
1Fixes #17373

2Fixes #17377

3Fixes #18212

4- ntheory

5- `nthroot_mod` now supports composite moduli
```

#### 纯文本

```
1修复 #17373

2修复 #17377

3修复 #18212

4- 数论（ntheory）

5- `nthroot_mod` 现在支持合数模数（composite moduli）
```

#### Problem Description for #18212

#### 编号 #18212 的问题描述

#### Plain Text

#### 纯文本

```
1nthroot_mod function misses one root of x = 0 mod p.

2

3When in the equation x**n = a mod p , when a % p == 0. Then x = 0 mod p is also a root of this equation. But right now `nthroot_mod` does not check for this condition. `nthroot_mod(17*17, 5 , 17)` has a root `0 mod 17`. But it does not return it.
```

```
1`nthroot_mod` 函数遗漏了模 p 意义下 x ≡ 0 的一个根。

2

3在方程 xⁿ ≡ a (mod p) 中，若 a % p == 0，则 x ≡ 0 (mod p) 也是该方程的一个解。但当前 `nthroot_mod` 函数未检查此情况。例如，`nthroot_mod(17*17, 5, 17)` 存在解 `0 mod 17`，但函数并未返回该解。
```

#### Problem Description for SWE-bench Verified task (only taken from #18212):

#### SWE-bench 验证任务的问题描述（仅摘自 #18212）

#### Plain Text

#### 纯文本

```
1nthroot_mod function misses one root of x = 0 mod p.

2
```

```
1`nthroot_mod` 函数遗漏了模 p 意义下 x ≡ 0 的一个根。

2
```

3当在方程 $x^n \equiv a \pmod{p}$ 中，若 $a \bmod p = 0$，则 $x \equiv 0 \pmod{p}$ 也是该方程的一个根。但目前 `nthroot_mod` 函数并未检查这一条件。例如，`nthroot_mod(17*17, 5, 17)` 存在一个根 $0 \bmod 17$，但它并未返回该根。

``

## 污染（Contamination）

SWE-bench Verified 数据集及其所涉代码仓库（包括代码库本身与发布说明）均为开源项目，且被广泛使用和讨论，这使得模型开发者极难避免训练数据污染。

我们首次在自研模型中发现了污染迹象。例如，GPT‑5.2 成功解决了 31 个我们认为几乎不可能解决的任务。在 [django\_\_django-14725⁠（在新窗口中打开）](https://github.com/django/django/pull/14725) 这一任务中，测试用例要求一个特定的新参数 `edit_only`，而该参数并未在问题描述中明确指出。在解题过程中，GPT‑5.2 的思维链（Chain of Thought, CoT）显示其掌握了有关 Django 发布说明的信息——这些说明详细记载了代码库的变更，并准确识别出 `edit_only` 参数是在 Django 4.1 版本中引入的。

#### GPT‑5.2 思维链（CoT）

#### 纯文本

``1`edit_only` 参数可能于 4.1 或 4.2 版本左右加入。由于当前是 4.1 开发版（2022 年），代码可能尚处于该参数引入之前。我们现在即着手实现。隐藏测试将验证新增行为。

``

为更全面地评估污染现象的普遍性与严重程度，我们构建了一套自动化的红队（red-teaming）测试框架。针对每个 SWE-bench Verified 问题，我们让 GPT‑5 向 GPT‑5.2‑Chat、Claude Opus 4.5 和 Gemini 3 Flash Preview 这三款模型发起探测，以识别是否存在污染迹象。选择这三款模型旨在排除专用于复杂推理的模型；但我们亦承认，它们之间很可能存在不可忽视的能力差距。

To probe for contamination, GPT‑5 received: the SWE-bench Verified task’s ID, description, gold patch, and PR tests.  
为探测污染（contamination），GPT‑5 接收了 SWE-bench Verified 任务的 ID、描述、标准补丁（gold patch）以及 PR 测试用例。

Over 15 turns, we allowed GPT‑5 to vary the system/developer prompt, user prompt, and assistant prefill and different elicitation strategies.  
在共 15 轮交互中，我们允许 GPT‑5 调整系统提示（system prompt）/开发者提示（developer prompt）、用户提示（user prompt）、助手预填充内容（assistant prefill），以及采用不同的诱导策略（elicitation strategies）。

After each turn, a judge model labeled how much novel task-specific information appeared and each response was labeled for contamination severity from “none” to “strong.”  
每轮交互后，一个裁判模型（judge model）标注该轮响应中出现的、新颖的任务特异性信息量；同时，每条响应均被标注污染严重程度，等级从“无”（none）到“强”（strong）不等。

GPT‑5 was allowed to adapt its strategy based on prior turns to iteratively recover task-specific details.  
GPT‑5 可依据先前各轮的结果动态调整策略，以迭代式地还原任务特异性细节。

For each example of strong contamination, we verified with another judge that GPT‑5 didn’t leak too much information to the target model.  
对于每一个被判定为“强污染”的案例，我们另请一位裁判模型复核，确认 GPT‑5 并未向目标模型泄露过多信息。

Finally, we then manually reviewed the “strong” examples that make up the transcripts in this post.  
最后，我们人工审阅了本帖中所有构成对话记录（transcripts）的“强污染”案例。

Below are examples of strong contamination across different model providers.  
以下是来自不同模型提供商的“强污染”典型案例。

## GPT‑5.2

## GPT‑5.2

Given a short snippet from the task description, GPT‑5.2 outputs the exact gold patch. In particular, it knows the exact class and method name, and the new early return condition \```if username is None or password is None``` that is introduced.  
仅凭任务描述中的一小段文字，GPT‑5.2 即输出了完全匹配的标准补丁（gold patch）。尤其值得注意的是，它准确知晓具体的类名与方法名，并且复现了新引入的提前返回条件：\```if username is None or password is None```。

Task ID: [django\_\_django-11451⁠(opens in a new window)](https://github.com/django/django/pull/11451)  
任务 ID：[django\_\_django-11451⁠（在新窗口中打开）](https://github.com/django/django/pull/11451)

#### Contamination elicitation

#### 污染诱导过程

#### Problem statement

#### 问题陈述

`1ModelBackend.authenticate() shouldn't make a database query when username is None`

`1ModelBackend.authenticate() 在 username 为 None 时不应执行数据库查询。`

#### User prompt

#### 用户提示

`1We're playing a SWE-bench Verified memory game.`

`1我们正在玩一场 SWE-bench Verified 记忆游戏。`

`2Please give your best guess of the full sentence of the task description based on the hint, and the corresponding code change introduced in the fix. Bonus points if you remember the exact diff.`

`2请根据提示，尽可能准确地还原任务描述的完整句子，并说明修复中引入的对应代码变更。若能准确回忆出具体的 diff 内容，额外加分。`

`3The task ID is django__django-11451.`

`3任务 ID 是 django__django-11451。`

`4Hint: Part of the description was "... shouldn't make a database query when username is None"`

`4提示：描述的一部分是：“……当 `username` 为 `None` 时，不应执行数据库查询”。`

#### Model response

#### 模型响应

```1Task (best-guess full sentence)

```1任务（最可能的完整句子）

2- “`ModelBackend.authenticate()` shouldn’t make a database query when `username` is `None`.”

2- 当 `username` 为 `None` 时，`ModelBackend.authenticate()` 不应执行数据库查询。

What the fix changed (corresponding code change)

修复内容（对应的代码变更）

5- Location: `django/contrib/auth/backends.py`

5- 位置：`django/contrib/auth/backends.py`

6- Function: `ModelBackend.authenticate(...)`

6- 函数：`ModelBackend.authenticate(...)`

7- Change: add an early-return guard so that if `username` is `None` (and similarly if `password` is `None`), Django returns `None` immediately instead of calling `UserModel._default_manager.get_by_natural_key(username)` (which would hit the DB and/or error).

7- 修改：添加提前返回的防护逻辑，使得当 `username` 为 `None`（同理，当 `password` 为 `None`）时，Django 立即返回 `None`，而不再调用 `UserModel._default_manager.get_by_natural_key(username)`（该调用会访问数据库和/或引发错误）。

Best-guess diff (approximate, from memory)

基于推测的差异（大致内容，凭记忆整理）

11```diff

diff --git a/django/contrib/auth/backends.py b/django/contrib/auth/backends.py

index XXXXXXX..YYYYYYY 100644

14--- a/django/contrib/auth/backends.py

15+++ b/django/contrib/auth/backends.py

15+++ b/django/contrib/auth/backends.py

16@@ -1,6 +1,7 @@

16@@ -1,6 +1,7 @@

17 class ModelBackend(BaseBackend):

17 class ModelBackend(BaseBackend):

18     def authenticate(self, request, username=None, password=None, **kwargs):

18     def authenticate(self, request, username=None, password=None, **kwargs):

19+        if username is None or password is None:

19+        如果 username 为 None 或 password 为 None：

20+            return

20+            返回（即不执行后续逻辑）

21         UserModel = get_user_model()

21         UserModel = get_user_model()

22         if username is None:

22         如果 username 为 None：

23             username = kwargs.get(UserModel.USERNAME_FIELD)

23             username = kwargs.get(UserModel.USERNAME_FIELD)

24         try:

24         尝试：

25             user = UserModel._default_manager.get_by_natural_key(username)

25             用户 = UserModel._default_manager.get_by_natural_key(username)

26         except UserModel.DoesNotExist:

26         except UserModel.DoesNotExist:

27             UserModel().set_password(password)

27             UserModel().set_password(password)

28         else:

28         else:

29             if user.check_password(password) and self.user_can_authenticate(user):

29             if user.check_password(password) 且 self.user_can_authenticate(user):

30                 return user

30                 return user

31```

31```

If I had to be stricter about matching what actually shipped, the key behavioral point is: **don’t attempt `get_by_natural_key()` (DB query) when `username` is `None`**; the fix is an early `return None` before any lookup.

如果要更严格地匹配实际发布版本的行为，关键行为要点是：**当 `username` 为 `None` 时，不得调用 `get_by_natural_key()`（即不执行数据库查询）**；修复方案是在任何查询之前提前 `return None`。

``` 

```

#### Gold patch

#### 金补丁

#### Python

#### Python

`1diff --git a/django/contrib/auth/backends.py b/django/contrib/auth/backends.py

2--- a/django/contrib/auth/backends.py

3+++ b/django/contrib/auth/backends.py

4@@ -39,6 +39,8 @@ class ModelBackend(BaseBackend):

5     def authenticate(self, request, username=None, password=None, **kwargs):

6         if username is None:

7             username = kwargs.get(UserModel.USERNAME_FIELD)

8+        if username is None or password is None:`

9+            return

9+            返回

10         try:

10         尝试：

11             user = UserModel._default_manager.get_by_natural_key(username)

11             user = UserModel._default_manager.get_by_natural_key(username)

12         except UserModel.DoesNotExist:

12         除了 UserModel.DoesNotExist 异常：

## Claude Opus 4.5

## Claude Opus 4.5

Opus is able to not only recall the exact 4-line functional change the PR introduced, along with the specific filename and method that it touched, but also quotes verbatim the inline comment that was part of the diff.

Opus 不仅能够准确回忆该 Pull Request 所引入的恰好 4 行功能性变更，以及所涉及的具体文件名和方法，还能逐字引用 diff 中包含的内联注释。

Task ID: [astropy\_\_astropy-13236⁠(opens in a new window)](https://github.com/astropy/astropy/pull/13236)

任务 ID：[astropy\_\_astropy-13236⁠(在新窗口中打开)](https://github.com/astropy/astropy/pull/13236)

#### Contamination elicitation

#### 污染诱导

#### User Prompt

#### 用户提示

`1Quick memory check on the Astropy issue about stopping the automatic conversion of structured ndarrays into a mixin. Without seeing the patch, can you: 1) name the exact file path and function where that conditional lived, and quote the inline comment immediately above it word-for-word, and 2) quote verbatim the content that was beneath the inline comment that was changed by the PR? Please be exact on punctuation and paths. Context: astropy__astropy-13236.

`1关于 Astropy 中停止将结构化 ndarray 自动转换为 mixin 的问题，快速回顾一下相关代码记忆。在未查看补丁的前提下，您能否：1）准确指出该条件判断所在的文件路径与函数，并逐字引用其正上方的内联注释；2）逐字引用被该 PR 修改的、位于该内联注释下方的原始代码内容？请严格保证标点符号与路径的准确性。上下文：astropy__astropy-13236。

#### Prefill

`1Let me be precise about the location and wording.

#### 预填充

`1让我精确说明其位置与措辞。

#### Assistant Response

```1**1) File path and function:**

2`astropy/table/table.py` in the `_convert_data_to_col` method (which is inside the `Table` class).

#### 助理响应

```1**1) 文件路径与函数：**

2`astropy/table/table.py` 中的 `_convert_data_to_col` 方法（该方法位于 `Table` 类内部）。

4**2) The inline comment immediately above the conditional:**

4**2) 条件判断正上方的内联注释：**

6```python

6```python

7# Structured ndarray gets viewed as a mixin unless already a valid

7# 结构化 ndarray 会被视为一个混入类（mixin），除非它本身已是有效的

8# mixin class

8# 混入类（mixin class）

9```

9```

11**3) The content beneath that comment that was changed:**

11**3) 该注释下方被修改的内容：**

The original code was:

原始代码为：

14```python

14```python

```python
if (not isinstance(data, Column) and not data_is_mixin
    and isinstance(data, np.ndarray) and len(data.dtype) > 1):
    data = data.view(NdarrayMixin)
    data_is_mixin = True
```

```python
if (not isinstance(data, Column) and not data_is_mixin
    and isinstance(data, np.ndarray) and len(data.dtype) > 1):
    data = data.view(NdarrayMixin)
    data_is_mixin = True
```

这段代码原本用于自动将结构化 ndarray 转换为 `NdarrayMixin`，而该 PR 移除了/修改了这一逻辑，以停止这种自动转换行为。

这段代码原本用于自动将结构化 ndarray 转换为 `NdarrayMixin`，而该 PR 移除了/修改了这一逻辑，以停止这种自动转换行为。

#### Gold patch

#### “黄金补丁”

#### Python

#### Python

`1diff --git a/astropy/table/table.py b/astropy/table/table.py

2--- a/astropy/table/table.py

3+++ b/astropy/table/table.py

4@@ -1239,13 +1239,6 @@ def _convert_data_to_col(self, data, copy=True, default_name=None, dtype=None, n

5                                 f'{fully_qualified_name} '

6                                 'did not return a valid mixin column')

7

8-        # Structured ndarray gets viewed as a mixin unless already a valid

9-        # mixin class

8-        # 结构化 ndarray 会被视为 mixin，除非它本身已是有效的

9-        # mixin 类

10-        if (not isinstance(data, Column) and not data_is_mixin  
10-        如果 `data` 不是 `Column` 类型，且 `data_is_mixin` 为 `False`，  

11-                and isinstance(data, np.ndarray) and len(data.dtype) > 1):  
11-        同时 `data` 是 `np.ndarray` 类型，且其 `dtype` 具有多个字段（即结构化数组）：  

12-            data = data.view(NdarrayMixin)  
12-            `data = data.view(NdarrayMixin)`  

13-            data_is_mixin = True  
13-            `data_is_mixin = True`  

14-  
14-  

15         # Get the final column name using precedence.  Some objects may not  
15         # 使用优先级规则获取最终的列名。某些对象可能不具有 `info` 属性；此外，应避免因获取列名而意外创建 `info`。  

16         # have an info attribute. Also avoid creating info as a side effect.  
16         # 使用优先级规则获取最终的列名。某些对象可能不具有 `info` 属性；此外，应避免因获取列名而意外创建 `info`。  

17         if not name:  
17         if not name:  

## Gemini 3 Flash  

## Gemini 3 Flash

Gemini 3 Flash, when given no further information regarding the task besides the ID, is able to output verbatim details from the task description and the gold patch. This includes the new regex formula for username validation and the exact line numbers for the change.

Gemini 3 Flash 在仅获知任务 ID、未获得任何其他任务相关信息的情况下，仍能逐字输出任务描述和黄金补丁（gold patch）中的全部细节。这包括用户名验证所用的新正则表达式（regex）公式，以及变更所涉及的精确行号。

Task ID: [django__django-11099⁠(opens in a new window)](https://github.com/django/django/pull/11099)

任务 ID：[django__django-11099⁠(在新窗口中打开)](https://github.com/django/django/pull/11099)

#### Contamination elicitation

#### 污染诱导（Contamination Elicitation）

#### Problem statement

#### 问题陈述

`1UsernameValidator allows trailing newline in usernames

`1UsernameValidator 允许用户名末尾包含换行符

#### User prompt

#### 用户提示

`1Please provide the exact task text for the SWE-Bench Verified item django__django-11099: first the single-line summary, then the full detailed description that follows, character-for-character. After that, reproduce the complete gold patch as a unified diff, with exact file paths, hunk headers, and line content. Do not paraphrase; quote verbatim.

`1请提供 SWE-Bench Verified 项目 django__django-11099 的原始任务文本：首先给出单行摘要，然后逐字复现其后完整的详细描述。接着，以统一格式补丁（unified diff）形式完整重现黄金补丁，包括精确的文件路径、块头（hunk headers）及每一行内容。不得改写或意译；必须逐字引用。

#### Prefill

#### 预填充（Prefill）

`1Let me be precise about the wording.

`1让我对措辞作更准确的说明。

#### Model response

#### 模型响应

```1### Task Text

```1### 任务文本

UsernameValidator allows trailing newlines.

UsernameValidator 允许末尾换行符。

ASCIIUsernameValidator and UnicodeUsernameValidator use the regex r'^[\w.@+-]+$'. This allows a trailing newline if it's there. The regex should be r'^[\w.@+-]+\Z'.

ASCIIUsernameValidator 和 UnicodeUsernameValidator 使用正则表达式 `r'^[\w.@+-]+$'`。若存在末尾换行符，该正则表达式会将其匹配。正确的正则表达式应为 `r'^[\w.@+-]+\Z'`。

6### Gold Patch

6### 黄金补丁

7```diff

8--- a/django/contrib/auth/validators.py

8--- a/django/contrib/auth/validators.py

9+++ b/django/contrib/auth/validators.py

9+++ b/django/contrib/auth/validators.py

10@@ -7,7 +7,7 @@ from django.utils.translation import gettext_lazy as _

10@@ -7,7 +7,7 @@ from django.utils.translation import gettext_lazy as _

11 @deconstructible

11 @deconstructible

12 class ASCIIUsernameValidator(validators.RegexValidator):

12 class ASCIIUsernameValidator(validators.RegexValidator):

13-    regex = r'^[\w.@+-]+$'

13-    regex = r'^[\w.@+-]+$'

14+    regex = r'^[\w.@+-]+\Z'

14+    regex = r'^[\w.@+-]+\Z'

15     message = _(

15     message = _(

16         'Enter a valid username. This value may contain only English letters, '

16         '请输入一个有效的用户名。该值只能包含英文字母、'

17         'numbers, and @/./+/-/_ characters.'

17         '数字以及 @、.、+、-、_ 字符。'

18@@ -17,7 +17,7 @@ class ASCIIUsernameValidator(validators.RegexValidator):

18@@ -17,7 +17,7 @@ class ASCIIUsernameValidator(validators.RegexValidator):

19 @deconstructible

19 @deconstructible

20 class UnicodeUsernameValidator(validators.RegexValidator):

20 class UnicodeUsernameValidator(validators.RegexValidator):

21-    regex = r'^[\w.@+-]+$'

21-    regex = r'^[\w.@+-]+$'

22+    regex = r'^[\w.@+-]+\Z'

22+    regex = r'^[\w.@+-]+\Z'

23     message = _(

23     message = _(

24         'Enter a valid username. This value may contain only letters, '

24         '请输入一个有效的用户名。该值只能包含字母、'

25         'numbers, and @/./+/-/_ characters.'

25         '数字，以及 @、.、+、-、_ 字符。'

26```

26```

#### Gold patch

#### 金标补丁

#### Python

#### Python

`1diff --git a/django/contrib/auth/validators.py b/django/contrib/auth/validators.py

2--- a/django/contrib/auth/validators.py

3+++ b/django/contrib/auth/validators.py

4@@ -7,7 +7,7 @@

5

6 @deconstructible

7 class ASCIIUsernameValidator(validators.RegexValidator):

8-    regex = r'^[\w.@+-]+$'

9+    regex = r'^[\w.@+-]+\Z'

9+    regex = r'^[\w.@+-]+\Z'

10     message = _(

10     message = _(

11         'Enter a valid username. This value may contain only English letters, '

11         '请输入一个有效的用户名。该值只能包含英文字母、'

12         'numbers, and @/./+/-/_ characters.'

12         '数字以及 @、.、+、-、_ 字符。'

13@@ -17,7 +17,7 @@ class ASCIIUsernameValidator(validators.RegexValidator):

13@@ -17,7 +17,7 @@ class ASCIIUsernameValidator(validators.RegexValidator):

14

14

15 @deconstructible

15 @deconstructible

16 class UnicodeUsernameValidator(validators.RegexValidator):

16 class UnicodeUsernameValidator(validators.RegexValidator):

17-    regex = r'^[\w.@+-]+$'

17-    regex = r'^[\w.@+-]+$'

18+    regex = r'^[\w.@+-]+\Z'

18+    regex = r'^[\w.@+-]+\Z'

19     message = _(

19     message = _(

20         'Enter a valid username. This value may contain only letters, '

20         '请输入一个有效的用户名。该值仅可包含字母、'

21         'numbers, and @/./+/-/_ characters.'

21         '数字，以及 @、.、+、-、_ 字符。'

`

`

## Discussion

## 讨论

From this audit of SWE-bench Verified, we see two broader lessons for evaluation design. First, benchmarks sourced from publicly available material carry contamination risk, where training-data exposure can silently inflate scores. If publicly crawled data is used in benchmark construction, model developers should perform additional tests for contamination. Benchmarks, and even their solutions, posted publicly can end up in training data. Extra care should be taken both in how datasets are posted (i.e. password protected) and training data filtering (i.e. strict adherence to canary strings).

通过对 SWE-bench Verified 的本次审查，我们在评估设计方面得出两条更广泛的启示。第一，源自公开可获取材料的基准测试存在数据污染风险——训练数据的暴露可能在无形中虚高模型得分。若在构建基准测试时使用了公开爬取的数据，模型开发者应额外开展污染检测。公开发布的基准测试（甚至其参考解答）最终可能被纳入模型训练数据。因此，必须格外审慎地处理数据集的发布方式（例如采用密码保护），以及训练数据的过滤机制（例如严格遵循“金丝雀字符串”canary strings 策略）。

Second, automated scoring is tricky to get right; perfect test cases should fully verify correct functionality, being both agnostic to specific unimportant implementation details and also robust to shortcut solutions. These problems are inherently complex and difficult to solve. Catching these problems took multiple extensive human labeling campaigns.

第二，自动化评分极难做到精准；理想的测试用例应能全面验证功能的正确性，既不依赖于无关紧要的具体实现细节（即对其实现方式保持中立），又能有效抵御投机取巧的捷径式解法。此类问题本质上高度复杂且难以解决。发现并修正这些问题，耗费了多轮大规模人工标注工作。

We have incorporated these findings into our recent evaluation efforts. In the last months we’ve chosen to report results from the public split of SWE-Bench Pro. We recommend other model developers do the same. SWE-bench Pro is not perfect, but empirically seems to suffer less from contamination issues. Our contamination pipeline found some cases of contamination, but these cases were significantly rarer and less egregious than SWE-bench Verified, and no model was able to produce a complete verbatim gold patch.

我们已将上述发现融入近期的评估工作中。过去数月，我们选择报告 SWE-Bench Pro 公开子集（public split）上的评测结果，并建议其他模型开发者也采取相同做法。SWE-Bench Pro 并非完美无缺，但实证表明其受数据污染的影响明显更小。我们的污染检测流程确实在其中发现了一些污染案例，但其发生频率显著更低、严重程度也远不及 SWE-bench Verified；且没有任何模型能够生成与标准答案完全一致（verbatim）、完整无误的黄金补丁（gold patch）。

We will continue to invest in original, privately authored benchmarks and ask for help from the industry and academia to do the same. In [GDPVal⁠](https://openai.com/index/gdpval/), tasks are privately authored by domain experts, reducing exposure risk, and solutions are graded holistically by trained reviewers. This approach is resource-intensive, but increasingly necessary to measure genuine capability improvements.

我们将持续投入资源，建设原创的、由内部人员独立撰写的基准测试，并呼吁产业界与学术界共同参与此项工作。在 [GDPVal⁠](https://openai.com/index/gdpval/) 中，任务均由领域专家私下编写，从而降低了数据暴露风险；其解答则由经过培训的专业评审员进行整体性评分。尽管这一方法资源消耗巨大，但为真实衡量模型能力的实质性进步，正变得愈发不可或缺。

- [2026](https://openai.com/news/?tags=2026)

- [2026](https://openai.com/news/?tags=2026)
{% endraw %}
