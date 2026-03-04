---
render_with_liquid: false
title: "Evaluating AI’s ability to perform scientific research tasks | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/frontierscience"
date: "2025-12-16"
scraped_at: "2026-03-02T10:08:39.880641999+00:00"
language: "en-US"
translated: true
description: "OpenAI introduces FrontierScience, a benchmark testing AI reasoning in physics, chemistry, and biology to measure progress toward real scientific research."
tags: ["Research"]
---
render_with_liquid: false
render_with_liquid: false

December 16, 2025

2025年12月16日

[Research](https://openai.com/news/research/) [Publication](https://openai.com/research/index/publication/)

[研究](https://openai.com/news/research/) [出版物](https://openai.com/research/index/publication/)

# Evaluating AI’s ability to perform scientific research tasks

# 评估 AI 执行科学研究任务的能力

We introduce FrontierScience, a new benchmark that evaluates AI capabilities for expert-level scientific reasoning across physics, chemistry, and biology.

我们推出 FrontierScience——一个全新基准，用于评估 AI 在物理学、化学和生物学等领域开展专家级科学推理的能力。

[Read the paper(opens in a new window)](https://cdn.openai.com/pdf/2fcd284c-b468-4c21-8ee0-7a783933efcc/frontierscience-paper.pdf)

[阅读论文（在新窗口中打开）](https://cdn.openai.com/pdf/2fcd284c-b468-4c21-8ee0-7a783933efcc/frontierscience-paper.pdf)

![Partial graphic with a soft green-and-yellow gradient background, a large cropped word starting with “Fro…,” and layered blocks of text on the right listing review criteria such as “Factual,” “Gradable,” “Objective,” and “Difficult.”](images/evaluating-ai_s-ability-to-perform-scientific-research-tasks-openai/img_001.png)

![一幅局部图形：背景为柔和的黄绿色渐变，中央是一个大幅裁切的单词，以“Fro…”开头；右侧分层排列若干文本块，列出了评审标准，例如“事实准确”（Factual）、“可评分”（Gradable）、“客观”（Objective）和“高难度”（Difficult）。](images/evaluating-ai_s-ability-to-perform-scientific-research-tasks-openai/img_001.png)

Reasoning is at the core of scientific work. Beyond recalling facts, scientists generate hypotheses, test and refine them, and synthesize ideas across fields. As our models become more capable, the central question is how they can reason deeply to contribute to scientific research.

推理是科学研究的核心。科学家不仅需要记忆事实，更要提出假设、检验并优化假设，并跨学科整合思想。随着我们模型能力的不断提升，核心问题在于：它们如何实现深度推理，从而真正助力科学研究？

Over the last year, our models have reached major milestones, including achieving gold-medal performance at the International Math Olympiad and the International Olympiad in Informatics. In parallel, we’re starting to see our most capable models, such as GPT‑5, meaningfully accelerate real scientific workflows. Researchers are using these systems for tasks such as literature search across disciplines and languages and working through complex mathematical proofs. In many cases, the model shortens work that might have taken days or weeks to hours. This progress is documented in our paper [_Early science acceleration experiments with GPT‑5_ ⁠](https://openai.com/index/accelerating-science-gpt-5/), released in November 2025, which presents early evidence that GPT‑5 can measurably accelerate scientific workflows.

过去一年中，我们的模型已达成多项重要里程碑，包括在国际数学奥林匹克竞赛（IMO）和国际信息学奥林匹克竞赛（IOI）中斩获金牌。与此同时，我们最强大的模型（如 GPT‑5）已开始切实加速真实的科研工作流。研究人员正将这些系统应用于跨学科、跨语言的文献检索，以及复杂数学证明的推演等任务。在许多情况下，原本需耗时数天乃至数周的工作，如今仅需数小时即可完成。这一进展已在我们于2025年11月发布的论文《[GPT‑5 在早期科学加速实验中的应用](https://openai.com/index/accelerating-science-gpt-5/)》中予以记录；该论文首次提供了实证，表明 GPT‑5 确实能够显著加速科研工作流。

## Introducing FrontierScience

## 推出 FrontierScience

As accelerating scientific progress is one of the most promising opportunities for AI to benefit humanity, we’re improving our models on difficult math and science tasks and working on the tools that will help scientists get the most from them.

加快科学进步是人工智能造福人类最具前景的机遇之一，我们正着力提升模型在高难度数学与科学任务上的表现，并开发有助于科学家充分释放模型潜力的工具。

When [GPQA⁠(opens in a new window)](https://arxiv.org/abs/2311.12022), a “Google-Proof” science benchmark of questions written by PhD experts, was released in November 2023, GPT‑4 scored 39%, below the expert baseline of 70%. Two years later, GPT‑5.2 scored 92%. As models’ reasoning and knowledge capabilities continue to scale, more difficult benchmarks will be important to measure and forecast models’ ability to accelerate scientific research. Prior scientific benchmarks largely focus on multiple-choice questions, are saturated, or are not centrally focused on science.

2023年11月，由博士专家出题、号称“谷歌级难题”的科学评测基准 [GPQA⁠(在新窗口中打开)](https://arxiv.org/abs/2311.12022) 发布时，GPT‑4 得分为 39%，远低于专家基准线的 70%。两年后，GPT‑5.2 的得分跃升至 92%。随着模型的推理能力与知识水平持续提升，构建更具挑战性的评测基准，对衡量和预测模型加速科学研究的能力愈发关键。此前的科学评测基准大多集中于选择题形式，已趋于饱和，或并未以科学能力为核心考察目标。

To bridge this gap, we’re introducing FrontierScience: a new benchmark built to measure expert-level scientific capabilities. FrontierScience is written and verified by experts across physics, chemistry, and biology, and consists of hundreds of questions designed to be difficult, original, and meaningful. FrontierScience includes two tracks of questions: Olympiad, which measures Olympiad-style scientific reasoning capabilities, and Research, which measures real-world scientific research abilities. Providing more insight into models’ scientific capabilities helps us track progress and advance AI-accelerated science.

为填补这一空白，我们推出 **FrontierScience**：一个全新评测基准，旨在衡量专家级科学能力。FrontierScience 由物理学、化学与生物学领域的专家共同编写并审校，包含数百道兼具难度、原创性与科学意义的问题。该基准分为两条评测路径：**Olympiad（奥赛路径）**，评估类似国际学科奥林匹克竞赛风格的科学推理能力；以及 **Research（研究路径）**，评估真实科研场景中的科学实践能力。更深入地理解模型的科学能力，有助于我们追踪进展，并推动人工智能赋能的科学加速发展。

In our initial evaluations, GPT‑5.2 is our top performing model on FrontierScience-Olympiad (scoring 77%) and Research (scoring 25%), ahead of other frontier models. We’ve seen substantial progress on solving expert-level questions while leaving headroom for more progress, especially on open-ended research-style tasks. For scientists, this suggests that current models can already support parts of research that involve structured reasoning, while highlighting that significant work remains to improve their ability to carry out open-ended thinking. These results align with how scientists are already using today’s models: to accelerate research workflows while relying on human judgment for problem framing and validation, and increasingly to explore ideas and connections that would otherwise take much longer to uncover—including, in some cases, contributing new insights that experts then evaluate and test.

在初步评测中，GPT‑5.2 在 FrontierScience-Olympiad（得分为 77%）与 FrontierScience-Research（得分为 25%）两项上均领先于其他前沿模型。我们在解答专家级问题方面已取得显著进展，但仍有广阔提升空间——尤其在开放式的科研类任务上。对科学家而言，这表明当前模型已能支持科研中涉及结构化推理的部分环节；同时也凸显出：要真正增强模型开展开放式思维的能力，仍需大量工作。这些结果与科学家当前使用大模型的方式高度一致：即借助模型加速科研流程，同时在问题建模与结果验证等关键环节依赖人类判断；并日益将其用于探索那些原本需要耗费更长时间才能发现的新思路与新关联——在某些情况下，甚至能提出值得专家进一步评估与实验验证的全新洞见。

In the end, the most important benchmark for the scientific capabilities of AI is the novel discoveries it helps generate; those are what ultimately matter to science and society. FrontierScience sits upstream of that. It gives us a north star for expert-level scientific reasoning, letting us test models on a standardized set of questions, see where they succeed or fail, and identify where we need to improve them. FrontierScience is narrow and has limitations in key respects (for example, focusing on constrained, expert-written problems) and does not capture everything scientists do in their everyday work. But the field needs more difficult, original, and meaningful science benchmarks, and FrontierScience provides a step forward in this direction.

归根结底，衡量人工智能科学能力的最重要“基准”，是它所助力产生的**全新科学发现**——这才是真正关乎科学进步与社会福祉的核心所在。FrontierScience 正处于这一终极目标的上游环节：它为我们确立了专家级科学推理能力的“北极星”指标，使我们得以在一套标准化问题集上系统测试模型，清晰识别其优势与短板，并精准定位亟待改进的方向。当然，FrontierScience 本身具有明确边界与关键局限（例如，聚焦于受约束的、由专家命制的问题），无法覆盖科学家日常工作的全部维度。但整个领域亟需更多高难度、原创性强且富有科学意义的评测基准，而 FrontierScience 正是在这一方向迈出的重要一步。

## What FrontierScience measures and how we built it

## FrontierScience 的评测维度与构建方法

The full FrontierScience evaluation spans over 700 textual questions (with 160 in the gold set) covering subfields across physics, chemistry, and biology. The benchmark is composed of an Olympiad and a Research split. FrontierScience-Olympiad contains 100 questions designed by international olympiad medalists to assess scientific reasoning in a constrained, short answer format. The Olympiad set was designed to contain theoretical questions at least as difficult as problems at international olympiad competitions. FrontierScience-Research consists of 60 original research subtasks designed by PhD scientists (doctoral candidates, professors, or postdoctoral researchers) that are graded using a 10-point rubric. The Research set was created to contain self-contained, multi-step subtasks at the level of difficulty that a PhD scientist might encounter during their research.

完整的 FrontierScience 评测涵盖逾 700 道文本型题目（其中“黄金题集”含 160 题），覆盖物理学、化学与生物学各细分领域。该基准分为 **Olympiad（奥赛路径）** 与 **Research（研究路径）** 两大部分。FrontierScience-Olympiad 包含 100 道题目，由国际学科奥林匹克竞赛金牌得主命题，旨在以受限、简答的形式评估科学推理能力；其理论题难度不低于国际奥赛实际赛题。FrontierScience-Research 则包含 60 个原创科研子任务，由博士科学家（含博士生、教授及博士后研究员）设计，并采用 10 分制评分量规进行评判；这些子任务均为自洽、多步骤的独立任务，其难度对标博士科学家在真实科研过程中可能遇到的典型挑战。

#### Sample questions

#### 示例题目

B1 reacts with aqueous bromine (Br2) to form B2. B2 reacts with potassium nitrite (KNO2) to form B3. B3 is nitrated in nitric acid (HNO3) and sulfuric acid (H2SO4) to form B4.

B1 与溴水（Br₂）反应生成 B2；B2 与亚硝酸钾（KNO₂）反应生成 B3；B3 在硝酸（HNO₃）与硫酸（H₂SO₄）混合酸中发生硝化反应生成 B4。

- B1 contains a monosubstituted aromatic 5-membered heterocycle and has a molar mass of 96.08 g/mol. It may be produced by dehydrating 5-carbon sugars (e.g. xylose) in an acid catalyst.  
- B1 含有一个单取代芳香族五元杂环，摩尔质量为 96.08 g/mol；可在酸催化剂作用下通过脱水 5 碳糖（如木糖）制得。

- B2 has the molecular formula C4H2Br2O3 and contains a tetrasubstituted alkene with 2 substituents being bromines cis to each other.  
- B2 的分子式为 C₄H₂Br₂O₃，含一个四取代烯烃，其中两个溴原子呈顺式构型。

- B3 is a dipotassium salt with a molar mass of 269.27 g/mol. It contains 1 hydrogen.  
- B3 是一种二钾盐，摩尔质量为 269.27 g/mol，分子中仅含 1 个氢原子。

- B4 is an achiral pseudohalogen dimer with 2 carbons, no hydrogens and a molar mass of 300. g/mol.  
- B4 是一种无手性的拟卤素二聚体，含 2 个碳原子、不含氢原子，摩尔质量为 300. g/mol。

When B4 decomposes in solution, it forms an intermediate B5 and 1 equivalent of dinitrogen tetroxide (N2O4) as a side product. Intermediate B5 can be trapped and detected as a Diels-Alder adduct.

当 B4 在溶液中分解时，会生成中间体 B5 和 1 当量的副产物四氧化二氮（N₂O₄）。中间体 B5 可被捕获并作为 Diels–Alder 加合物进行检测。

Provide the structures of B1, B2, B3, B4, and B5 in the following format, "B1: X; B2: X; B3: X; B4: X; B5: X".

请以如下格式提供 B1、B2、B3、B4 和 B5 的结构式：“B1: X；B2: X；B3: X；B4: X；B5: X”。

Each task in FrontierScience is written and verified by a domain expert in physics, chemistry, or biology. For the Olympiad set, all experts were awarded a medal in at least one (and often multiple) international olympiad competitions. For the Research set, all experts hold a relevant PhD degree.

FrontierScience 中的每项任务均由物理学、化学或生物学领域的专家撰写并审核。在奥赛题集（Olympiad set）中，所有专家均至少获得过一次（通常为多次）国际学科奥林匹克竞赛的奖牌；在研究题集（Research set）中，所有专家均拥有相关领域的博士学位。

The Olympiad questions were created in collaboration with 42 former international medalists or national team coaches in the relevant domains, totalling 109 olympiad medals. The research questions were created in collaboration with 45 qualified scientists and domain experts. All scientists were either doctoral candidates, post-doctoral researchers, or professors. Their areas of expertise spanned an array of specialized and important scientific disciplines, from quantum electrodynamics to synthetic organic chemistry to evolutionary biology.

奥赛题目由 42 位相关领域的前国际奥赛奖牌得主或国家队教练共同开发，累计获得国际奥赛奖牌 109 枚。研究类题目则由 45 位资质合格的科学家与领域专家共同开发。所有科学家均为博士研究生、博士后研究员或教授，其专业领域覆盖一系列高度专业化且重要的科学方向，从量子电动力学、合成有机化学到进化生物学等。

The task creation process for both sets included some selection against OpenAI internal models (e.g., discarding tasks that models successfully got right, so we expect the evaluation to be somewhat biased against these models relative to others). We open-source the Olympiad gold set of 100 questions and Research gold set of 60 questions, holding out the other questions to track contamination.

两套题目的任务创建过程均包含对 OpenAI 内部模型的针对性筛选（例如：剔除那些被模型成功解答的任务），因此我们预期本次评估结果将对这些模型产生一定程度的偏差（即相对其他模型而言更不利）。我们开源了包含 100 道题的奥赛“金牌题集”（Olympiad gold set）和包含 60 道题的研究“金牌题集”（Research gold set），其余题目则暂不公开，用于后续污染（contamination）监测。

![Flowchart showing four stages of a task development pipeline—Creation, Review, Resolution, and Revision—with brief descriptions of each step and checkmarks for factual, gradable, objective, and difficult criteria.](images/evaluating-ai_s-ability-to-perform-scientific-research-tasks-openai/img_002.png)

![流程图展示了任务开发流水线的四个阶段——创建（Creation）、审核（Review）、求解（Resolution）与修订（Revision），每个阶段附有简要说明，并标有“事实性”“可评分性”“客观性”和“难度”四项标准的勾选标记。](images/evaluating-ai_s-ability-to-perform-scientific-research-tasks-openai/img_002.png)

Tasks go through four stages: Creation, Review, Resolution, Revision. Independent experts review each other tasks to verify it aligns with the criteria.

任务需经历四个阶段：创建、审核、求解与修订。各独立专家交叉审核彼此设计的任务，以确保其符合各项既定标准。

## How we grade model performance

## 我们如何评估模型表现

The Olympiad set is gradable with a short answer: either with a number, expression, or fuzzy string match, which helps with verifying correctness. However, this verification often trades off with the expressivity and open-endedness of the problem. For the Research set, we introduce a rubric-based architecture for grading more open-ended tasks. Each question includes a scoring rubric with multiple independent and objectively assessable items, totaling 10 points. The grading rubric assesses not only the accuracy of the final answer, but also the correctness of intermediate reasoning steps, allowing for nuanced model performance and failure analysis. A solution is considered “correct” if it’s awarded at least 7/10 rubric points.

奥赛题集采用简短答案形式评分：答案可以是数字、数学表达式，或通过模糊字符串匹配判定；该方式有助于验证答案正确性。但此类验证往往需在准确性与问题的表达力及开放性之间做出权衡。针对研究题集，我们引入基于评分细则（rubric）的评估架构，以支持更开放、更复杂的任务评分。每道题目均配备一份评分细则，其中包含多个相互独立、可客观评判的评分项，总分 10 分。该评分细则不仅评估最终答案的准确性，也考察中间推理步骤的正确性，从而实现对模型表现与失败原因的细致分析。若某解答获得评分细则中至少 7/10 的分数，则视为“正确”。

Responses are evaluated by a model-based grader (GPT‑5) against either the short answer or the rubric criteria. While we’d ideally use an expert human to grade each response, this approach is not scalable, so we designed the rubric to be checkable using a model grader. We developed a verification pipeline to help ensure rubrics and questions were well-calibrated to difficulty and correctness.

所有回答均由基于模型的评分器（GPT‑5）依据简短答案或评分细则进行评估。尽管理想情况下应由领域专家人工逐条评分，但该方式难以规模化实施；因此，我们专门设计了可由模型评分器自动核查的评分细则。此外，我们还构建了一套验证流水线（verification pipeline），以确保评分细则与题目本身在难度与正确性方面均得到良好校准。

##### Sample chemistry research problem

##### 示例化学研究问题

Phthalocyanines are important macrocyclic compounds widely utilized in material and life sciences due to their outstanding physicochemical properties, including intense absorption in the visible-near-IR region and high electron-accepting ability. However, unlike porphyrins, the structural diversity of phthalocyanines has been limited by traditional synthetic methods that rely on one-step condensation of isoindoline units. The development of methodologies that allow controlled modification of the phthalocyanine framework, particularly at the meso-positions, represents a significant advancement in expanding the structural and electronic diversity of these compounds.

酞菁类化合物是一类重要的大环化合物，因其优异的理化性质（如在可见光–近红外区具有强烈吸收、高电子接受能力等）而在材料科学与生命科学中得到广泛应用。然而，与卟啉类化合物不同，传统合成方法（依赖于异吲哚啉单元的一步缩合反应）严重限制了酞菁结构的多样性。近年来，发展可在大环骨架（尤其是“meso”位点）上实施可控修饰的新方法，已成为拓展此类化合物结构多样性与电子多样性的重大进展。

Analyze how the modification of meso-nitrogen atoms in nickel(II) phthalocyanine affects the electronic structure, aromaticity, spectroscopic properties, and reactivity of the resulting macrocycles. Explain the synthetic methodology that enables these modifications, the relationship between π-electron count and observed properties, and how these systems compare to traditional phthalocyanines and related porphyrinoids.

请分析镍(II)酞菁中meso-位氮原子的修饰如何影响所得大环化合物的电子结构、芳香性、光谱性质及反应活性；阐述实现此类修饰的合成方法学，阐明π电子数与所观测性质之间的关联，并比较此类体系与传统酞菁及其它相关卟啉类化合物（porphyrinoids）的异同。

##### Sample response

##### 示例回答

**1\. Introduction: Why Modify the meso-Nitrogens of Phthalocyanines?**

**1．引言：为何要修饰酞菁的meso-位氮原子？**

Phthalocyanines (Pc) are a class of macrocyclic dyes known for their remarkable chemical, electronic, and optical properties. Their widespread use in materials science, catalysis, and biology stems from strong absorptions in the visible/near-IR regions, exceptional redox characteristics (i.e., high electron affinity), and rigid π-conjugation. Traditional synthetic methods, however, typically form the macrocycle in a single step from phthalonitrile or isoindoline precursors, restricting the ability to introduce substitutions selectively at key ring positions—especially the "meso" (bridging) nitrogens. Recently, methodologies allowing targeted modification of the meso-nitrogen atoms in Ni(II) phthalocyanines have emerged as a powerful means to expand the structural and electronic diversity of these macrocycles.

酞菁（Pc）是一类以卓越化学性质、电子性质和光学性质著称的大环染料。其在材料科学、催化及生物学中的广泛应用，源于其在可见光/近红外区的强吸收、优异的氧化还原特性（即高电子亲和力）以及刚性的π共轭结构。然而，传统合成方法通常以邻苯二腈或异吲哚啉为前体，经一步成环反应构建大环，难以在关键环位（尤其是“meso”位，即桥连氮原子）上选择性引入取代基。近年来，针对镍(II)酞菁meso-位氮原子的定向修饰新方法不断涌现，已成为拓展此类大环化合物结构多样性与电子多样性的有力手段。

**2\. Effect on Electronic Structure and Aromaticity**

**2．对电子结构与芳香性的影响**

1. **π-Electron Count and Ring Currents**

1．π电子数与环电流

Phthalocyanines are classical 18-electron aromatic systems, conferring high stability and planarity. Altering the meso-nitrogens through substitution or ring expansion can shift the effective π-electron count. For example, introducing additional unsaturated moieties or heteroatoms may expand the cyclic conjugation to 20 or 22 electrons, moving the molecule between Hückel aromaticity and other regimes that affect ring currents and magnetic properties.

酞菁是经典的18电子芳香体系，因而具有高稳定性与平面性。通过对meso-位氮原子进行取代或环扩展，可改变其有效π电子数。例如，引入额外的不饱和基团或杂原子，可能将环状共轭体系扩展至20或22个π电子，使分子在Hückel芳香性及其他影响环电流与磁性特征的电子构型区间之间发生转变。

    Meso-substitution can tune the electron density distribution around the macrocycle. Electron-donating groups can push electron density toward the ring center, lowering the energy of the lowest unoccupied molecular orbital (LUMO). Electron-withdrawing groups, conversely, stabilize the highest occupied molecular orbital (HOMO) and shift redox potentials toward more positive values, altering both the electrochemical profile and the Q- and B-band positions in the UV-vis spectrum.

    中心位取代（meso-取代）可调控大环周边的电子密度分布。给电子基团可将电子密度推向环中心，从而降低最低未占分子轨道（LUMO）的能量；而吸电子基团则相反，可稳定最高已占分子轨道（HOMO），并使氧化还原电位向更正值方向移动，进而改变其电化学行为以及紫外-可见（UV-vis）光谱中Q带和B带的位置。

**3\. Spectroscopic Consequences**

**3．光谱学效应**

1. **UV-Vis Absorption (Q and B Bands)**

The principal absorption features of phthalocyanines lie in the visible (Q-band, typically 600-700 nm) and near-UV (B-band, typically 300-400 nm).

1．紫外-可见吸收光谱（Q带与B带）

酞菁类化合物的主要吸收特征位于可见光区（Q带，通常为600–700 nm）和近紫外区（B带，通常为300–400 nm）。

    Substitution that expands the ring conjugation or introduces strong electron-donating/withdrawing groups can:

   - Shift the Q-band to longer wavelengths (bathochromic shift), reaching into the near-IR, which is highly desirable for optoelectronic and photodynamic applications.

   - Alter relative intensities of these bands and merge or split them, reflecting changes in orbital symmetries and energies.

    当取代基扩展环共轭体系，或引入强给电子/吸电子基团时，可：

   - 使Q带发生红移（即向长波方向移动），甚至延伸至近红外区（NIR），这对光电及光动力学应用极具价值；

   - 改变这些吸收带的相对强度，并导致其合并或分裂，反映出分子轨道对称性与能量的变化。

2. **NMR Spectroscopy and Aromatic Ring Currents**

Modifications to the π-electron count and distribution are directly observed in 1H and 13C NMR chemical shifts.

2．核磁共振（NMR）光谱与芳香环电流

π电子数目与分布的改变，可直接通过¹H与¹³C NMR化学位移体现出来。

    More highly conjugated (or expanded) aromatic rings exhibit distinct downfield shifts for protons located within induced ring currents, while any partial loss of aromaticity or incorporation of antiaromatic segments can cause atypical shielding/deshielding patterns.

    共轭程度更高（或环系更大）的芳香环，在其感应环电流区域内的质子会呈现显著的去屏蔽（即低场）化学位移；而任何局部芳香性的减弱，或反芳香性片段的引入，则可能导致异常的屏蔽/去屏蔽模式。

**4\. Reactivity and Coordination Chemistry**

**4．反应活性与配位化学**

Because phthalocyanines are often used as redox catalysts or sensors, the meso-nitrogen modifications can significantly influence reactivity:

由于酞菁常被用作氧化还原催化剂或传感器，其中心氮（meso-nitrogen）位点的修饰可显著影响其反应活性：

- Electron-rich meso substituents facilitate nucleophilic or electrophilic attacks at the ring periphery, enabling site-selective functionalizations that are otherwise difficult.

- 富电子的中心取代基（meso substituents）有利于亲核或亲电试剂进攻大环外围，从而实现位点选择性官能化——而此类转化在常规条件下通常难以实现。

(... shortened for the purposes of this figure)

（……为本图示意目的而略去）

##### Sample grading rubric

##### 示例评分标准

###### Analysis of Traditional Phthalocyanine Synthesis Limitations (1 point)

###### 传统酞菁合成方法局限性的分析（1分）

Pass  
达标  

1.0 point: Correctly explains that traditional phthalocyanine synthesis involves one-step condensation with simultaneous formation of all meso-nitrogen bridges, providing limited control over substitution patterns at these positions.  
1.0 分：准确指出传统酞菁合成采用一步缩合反应，所有中心氮桥（meso-nitrogen bridges）同时形成，因而难以调控这些位置上的取代模式。

0.5 point: Mentions limitations of traditional methods but without specific focus on meso-position control challenges.  
0.5 分：提及传统方法的局限性，但未明确聚焦于中心位点（meso-position）取代调控的难点。

0.0 point: Fails to identify key limitations of traditional synthetic approaches or provides incorrect analysis.  
0.0 分：未能指出传统合成策略的关键局限，或分析错误。

###### Thiolate-Mediated Tetramerization Process (1 point)

###### 巯基阴离子介导的四聚过程（1分）

1.0 point: Correctly describes the thiolate-mediated reductive tetramerization and explains how counter cation size (K+ or Cs+ vs. Na+) affects selectivity between tetramer formation and direct macrocyclization.  
1.0 分：准确描述巯基阴离子介导的还原性四聚反应，并阐明抗衡阳离子尺寸（K⁺ 或 Cs⁺ 相较于 Na⁺）如何影响四聚体生成与直接大环化之间的选择性。

0.5 point: Mentions thiolate-mediated tetramerization but without explaining factors controlling selectivity.

0.5 分：提及硫醇盐介导的四聚化，但未解释控制选择性的因素。

Fail  
不合格  

0.0 point: Incorrectly describes the oligomerization process or omits critical details about selectivity control.

0.0 分：对低聚化过程的描述错误，或遗漏关于选择性控制的关键细节。

###### Analysis of NMR Spectroscopic Features (1 point)

###### 核磁共振（NMR）谱学特征分析（1 分）

1.0 point: Correctly explains that upfield shifts in the 16π system indicate paratropic ring current (antiaromaticity), contrasts this with the broad signals in 17π systems due to paramagnetism, and connects these observations to the underlying electronic structures.

1.0 分：正确解释 16π 体系中的核磁共振信号上场位移表明存在逆磁环流（即反芳香性），并将其与 17π 体系中因顺磁性导致的宽峰信号形成对比；同时将这些谱学现象与体系内在的电子结构明确关联。

Pass  
合格  

0.5 point: Identifies basic NMR patterns but without clear connection to ring currents or electronic structure.

0.5 分：识别出基本的 NMR 谱图特征，但未能清晰联系到环电流或电子结构。

0.0 point: Incorrectly interprets NMR data or fails to connect spectral features to electronic properties.

0.0 分：对 NMR 数据的解读错误，或未能将谱图特征与电子性质建立联系。

###### Electrochemical Property Analysis (1 point)

###### 电化学性质分析（1 分）

1.0 point: Correctly explains that the 16π system shows two reversible reductions reflecting conversion to 17π radical and 18π aromatic states, while 17π systems show narrow redox gaps due to facile interconversion between 16π, 17π, and 18π states, and relates these patterns to the underlying electronic structures.

1.0 分：正确解释 16π 体系呈现两个可逆还原峰，对应于向 17π 自由基态和 18π 芳香态的转化；而 17π 体系则因 16π、17π 和 18π 态之间易于相互转化，表现出较窄的氧化还原电位差；并能将上述电化学行为与体系内在的电子结构明确关联。

Pass  
合格  

0.5 point: Describes redox patterns without clearly connecting them to specific electronic state changes.

0.5 分：描述了氧化还原行为模式，但未清晰关联至特定电子态的变化。

0.0 point: Incorrectly interprets electrochemical data or fails to connect redox behavior to electronic properties.

0.0 分：对电化学数据的解读错误，或未能将氧化还原行为与电子性质建立联系。

###### Analysis of Absorption Spectroscopy (1 point)

###### 吸收光谱分析（1分）

1.0 point: Correctly explains that the 16π system shows weak/broad absorption due to symmetry-forbidden HOMO-LUMO transitions in antiaromatic systems, while 17π systems show Q-like bands plus NIR-II absorptions characteristic of radical species, and contrasts these with typical phthalocyanine spectral features.

1.0分：正确解释了16π体系因反芳香性导致HOMO–LUMO跃迁受对称性禁阻，因而呈现弱而宽的吸收；而17π体系则展现出类Q带及近红外II区（NIR-II）吸收，这是自由基物种的典型特征；并进一步将这两类光谱特征与酞菁类化合物的常规光谱特征进行对比。

Pass  
通过  

0.5 point: Describes absorption features but provides limited connection to underlying electronic structures.

0.5分：描述了吸收特征，但未能充分将其与底层电子结构建立联系。

0.0 point: Incorrectly interprets absorption data or fails to relate spectral features to electronic properties.

0.0分：错误解读吸收数据，或完全未能将光谱特征与电子性质相关联。

###### Reactivity Analysis of Antiaromatic System (1 point)

###### 反芳香体系反应性分析（1分）

1.0 point: Correctly explains the high reactivity of the 16π system toward nucleophiles, details specific reactions with hydroxide (ring opening) and hydrazine (ring expansion), and explains how these transformations relieve antiaromatic destabilization.

1.0分：正确阐明16π体系对亲核试剂具有高反应活性，具体说明其与氢氧根离子（发生开环反应）及肼（发生扩环反应）的作用，并解释这些转化如何缓解反芳香性所导致的热力学不稳定。

Fail  
未通过  

0.5 point: Mentions reactivity but provides limited analysis of specific transformations or the driving forces behind them.

0.5分：提及反应性，但对具体转化过程或其驱动力的分析较为简略或不充分。

0.0 point: Incorrectly analyzes reactivity patterns or fails to connect them to the antiaromatic character of the 16π system.

0.0分：错误分析反应性规律，或未能将反应行为与16π体系的反芳香特性相联系。

(... and more)  

（……其余部分同理）

Each task in the research set is graded using a rubric totaling 10 points that can be used by an expert or a model grader. To scale our ability to evaluate models, we use another model to grade responses.

研究集中每一项任务均依据总分为10分的评分量规进行评判，该量规可供领域专家或模型评分器使用。为提升模型评估能力的可扩展性，我们采用另一模型对响应结果进行自动评分。

## Model performance

## 模型性能

We evaluated several frontier models: GPT‑5.2, Claude Opus 4.5, and Gemini 3 Pro, GPT‑4o, OpenAI o4-mini, and OpenAI o3 on FrontierScience-Olympiad and FrontierScience-Research. All reasoning models were evaluated at “high” reasoning effort with the exception of GPT‑5.2 at “xhigh”. In our initial evaluations, GPT‑5.2 is our top performing model on FrontierScience-Olympiad (scoring 77%) and Research (scoring 25%), ahead of other frontier models. Gemini 3 Pro is comparable to GPT‑5.2 on the Olympiad set (scoring 76%).

我们评估了多个前沿模型：GPT‑5.2、Claude Opus 4.5、Gemini 3 Pro、GPT‑4o、OpenAI o4-mini 和 OpenAI o3，评测任务为 FrontierScience-Olympiad 和 FrontierScience-Research。除 GPT‑5.2 在“xhigh”推理强度下运行外，其余所有推理模型均在“high”推理强度下进行评测。在初步评测中，GPT‑5.2 在 FrontierScience-Olympiad（得分为 77%）和 FrontierScience-Research（得分为 25%）上表现最优，领先于其他前沿模型；Gemini 3 Pro 在 Olympiad 数据集上的表现与 GPT‑5.2 相当（得分为 76%）。

We’ve seen substantial progress on solving expert-level questions, especially on open-ended research-style tasks. There is still more room to grow: from analyzing the transcripts for failures, frontier models sometimes made reasoning, logic, and calculation errors, didn’t understand niche scientific concepts, and made factual inaccuracies.

我们在解决专家级问题方面已取得显著进展，尤其在开放式、研究风格的任务上。但仍有较大提升空间：通过对失败案例的对话记录分析发现，前沿模型有时会出现推理错误、逻辑漏洞和计算失误，未能理解小众科学概念，并产生事实性错误。

FrontierScience-Olympiad accuracy across models

FrontierScience-Olympiad 各模型准确率

GPT-4oOpenAI o1OpenAI o4-miniOpenAI o3Grok 4Claude Opus 4.5Gemini 3 ProGPT-5.20%10%20%30%40%50%60%70%80%Accuracy (%)12.3%42.5%61.7%62.9%66.2%71.4%76.1%77.1%

FrontierScience-Research accuracy across models

FrontierScience-Research 各模型准确率

GPT-4oOpenAI o1OpenAI o4-miniGemini 3 ProOpenAI o3Grok 4Claude Opus 4.5GPT-5.20%5%10%15%20%25%30%Accuracy (%)0.4%3.2%8.3%12.4%14.1%15.9%17.5%25.2%

We compare accuracies across several frontier models. GPT‑5.2 is our highest performing model on the FrontierScience-Research and the Olympiad set.

我们对比了多个前沿模型的准确率。GPT‑5.2 是 FrontierScience-Research 和 Olympiad 数据集上表现最佳的模型。

FrontierScience-Olympiad accuracy across reasoning efforts

FrontierScience-Olympiad 各推理强度下的准确率

0%10%20%30%40%50%60%70%80%Accuracy (%)LowMediumHighXHigh67.5%71.9%73.8%77.1%LowMediumHigh53.4%60.5%62.9%GPT-5.2OpenAI o3

FrontierScience-Research accuracy across reasoning efforts

FrontierScience-Research 在不同推理努力下的准确率

0%5%10%15%20%25%30%Accuracy (%)LowMediumHighXHigh18.2%20.2%21.2%25.2%LowMediumHigh12.9%14.4%14.1%GPT-5.2OpenAI o3

0% 5% 10% 15% 20% 25% 30% 准确率 (%)  
低 中 高 超高  
18.2% 20.2% 21.2% 25.2%  
低 中 高  
12.9% 14.4% 14.1%  
GPT-5.2 OpenAI o3  

We compare accuracies across reasoning efforts for GPT‑5.2 and o3. Longer thinking time leads to improved accuracy.

我们对比了 GPT‑5.2 和 o3 在不同推理努力下的准确率。更长的思考时间带来了更高的准确率。

## Limitations and what’s next

## 局限性与未来方向

While FrontierScience represents a step forward in difficulty of scientific benchmarks, there are still many limitations. FrontierScience is composed of questions with a constrained problem statement, which focuses on evaluating the final answer (Olympiad) or evaluating the reasoning to complete a research task (Research). In addition, using rubrics with multiple components on longer tasks is less objective than checking the final answer.

尽管 FrontierScience 代表了科学评测基准在难度上的重要进步，但仍存在诸多局限性。FrontierScience 所含题目均具有明确、受限的问题陈述，其评估重点在于最终答案（奥赛类）或完成科研任务所需的推理过程（研究类）。此外，对耗时较长的任务采用多维度评分标准，其客观性不如仅核查最终答案。

FrontierScience offers a higher resolution snapshot of models’ reasoning on difficult, expert-written questions, but not a full picture of how science gets done in practice. In particular, it does not assess a significant part of scientific research: how models generate genuinely novel hypotheses, or interact with multiple modalities, including video data and real experimental systems in the physical world.

FrontierScience 能够更精细地刻画模型在高难度、专家撰写的科学问题上的推理能力，但并未完整反映现实中科学研究的实际开展方式。尤其值得注意的是，它并未评估科学研究中一个至关重要的环节：模型如何生成真正新颖的科学假说，以及如何与多种模态（包括视频数据及物理世界中的真实实验系统）进行交互。

Looking ahead, we expect progress in scientific reasoning to come from both better general-purpose reasoning systems and focused effort on improvising scientific capabilities. FrontierScience is one tool among many, and as models improve, we plan to iterate on this benchmark, expand it to new domains, and pair it with more real-world evaluations that look at what these systems actually enable scientists to do. Benchmarks like FrontierScience help us understand the weaknesses of today’s AI systems to focus our work on making models be reliable partners in scientific discovery.

展望未来，科学推理能力的进步将来自两方面：一是更强大的通用推理系统，二是针对提升科学能力的专项优化工作。FrontierScience 只是众多工具之一；随着模型能力的持续提升，我们将不断迭代该基准，将其拓展至新的学科领域，并配套开展更多面向真实科研场景的评估——关注这些系统究竟为科学家实际赋能了哪些工作。像 FrontierScience 这样的评测基准，有助于我们识别当前 AI 系统的薄弱环节，从而聚焦研发资源，推动模型成长为科学家在科学发现过程中值得信赖的协作伙伴。

- [Framework](https://openai.com/news/?tags=framework)  
- [框架](https://openai.com/news/?tags=framework)

- [2025](https://openai.com/news/?tags=2025)  
- [2025](https://openai.com/news/?tags=2025)

- [Reasonings & Policy](https://openai.com/news/?tags=reasoning-policy)  
- [推理与策略](https://openai.com/news/?tags=reasoning-policy)