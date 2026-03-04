---
render_with_liquid: false
title: "Measuring AI’s capability to accelerate biological research in the wet lab | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/accelerating-biological-research-in-the-wet-lab"
date: "2025-12-16"
scraped_at: "2026-03-02T10:08:40.288219533+00:00"
language: "en-US"
translated: true
description: "OpenAI introduces a real-world evaluation framework to measure how AI can accelerate biological research in the wet lab. Using GPT-5 to optimize a molecular cloning protocol, the work explores both th..."
tags: ["Research"]
---
render_with_liquid: false
render_with_liquid: false

December 16, 2025

2025年12月16日

[Research](https://openai.com/news/research/) [Publication](https://openai.com/research/index/publication/)

[研究](https://openai.com/news/research/) [出版物](https://openai.com/research/index/publication/)

# Measuring AI’s capability to accelerate biological research in the wet lab

# 评估 AI 加速湿实验生物学研究的能力

GPT‑5 created novel wet lab protocol improvements, optimizing the efficiency of a molecular cloning protocol by 79x.

GPT‑5 提出了一系列全新的湿实验操作流程改进方案，将分子克隆实验流程的效率提升了 79 倍。

![Collage-style graphic with soft blue–orange gradients, a DNA assembly diagram, and bold text reading “Biology Research,” labeled under “OpenAI for Science.”](images/measuring-ai_s-capability-to-accelerate-biological-research-in-the-wet-lab-opena/img_001.png)

![一幅拼贴风格图像：背景为柔和的蓝橙渐变色，中央为 DNA 组装示意图，醒目粗体文字标注“Biology Research”（生物学研究），下方标有“OpenAI for Science”（OpenAI 科学计划）。](images/measuring-ai_s-capability-to-accelerate-biological-research-in-the-wet-lab-opena/img_001.png)

Accelerating scientific progress is one of the most valuable ways AI can benefit humanity. With GPT‑5, we’re beginning to see [early signs⁠](https://openai.com/index/accelerating-science-gpt-5/) of this—not only in helping researchers move faster through the scientific literature, but also in supporting new forms of scientific reasoning, such as surfacing unexpected connections, proposing proof strategies, or suggesting plausible mechanisms that experts can evaluate and test.

加速科学进步，是 AI 惠及人类最具价值的方式之一。借助 GPT‑5，我们已开始观察到这一趋势的[初步迹象⁠](https://openai.com/index/accelerating-science-gpt-5/)——它不仅助力研究人员更高效地浏览科学文献，更能支持新型科学推理，例如揭示意料之外的学科关联、提出数学证明策略，或构想出可供专家评估与验证的合理作用机制。

Progress to date has been most visible in fields like mathematics, theoretical physics, and theoretical computer science, where ideas can be rigorously checked without physical experiments. Biology is different: most advances depend on experimental execution, iteration, and empirical validation in the laboratory.

迄今为止，进展最显著的领域集中于数学、理论物理与理论计算机科学等学科——这些领域中的思想可不经物理实验而被严格验证。生物学则截然不同：绝大多数突破依赖于实验室中具体的实验操作、反复迭代与实证检验。

To help understand how frontier models behave in these settings, we worked with Red Queen Bio, a biosecurity start-up, to build an evaluation framework that tests how a model proposes, analyzes, and iterates on ideas in the wet lab. We set up a simple molecular biology experimental system and had GPT‑5 optimize a molecular cloning protocol for efficiency.

为深入理解前沿大模型在上述实验场景中的实际表现，我们携手生物安全初创公司 Red Queen Bio，共同构建了一套评估框架，用以检验模型在湿实验环境中提出设想、分析问题并持续迭代优化的能力。我们搭建了一个简化的分子生物学实验系统，并让 GPT‑5 针对效率目标优化分子克隆实验流程。

Over multiple rounds of experimentation, GPT‑5 introduced a novel mechanism that improved cloning efficiency by 79x. Cloning is a fundamental molecular biology tool. The efficiency of cloning methods is critical for creating large, complex libraries central to [protein engineering⁠(opens in a new window)](https://www.nature.com/articles/s41592-025-02740-0), [genetic screens⁠(opens in a new window)](https://www.nature.com/articles/s41467-025-67256-9), and [organismal strain engineering⁠(opens in a new window)](https://www.nature.com/articles/s41467-019-13189-z). This project offers a glimpse of how AI could work side-by-side with biologists to speed up research. Improving experimental methods will help human researchers move faster, reduce costs, and translate discoveries into real-world impact.

经过多轮实验迭代，GPT‑5 提出了一种全新机制，使克隆效率提升了 79 倍。克隆是分子生物学的一项基础性技术；其方法效率直接关系到能否高效构建大规模、高复杂度的文库——而这正是[蛋白质工程⁠(在新窗口中打开)](https://www.nature.com/articles/s41592-025-02740-0)、[遗传筛选⁠(在新窗口中打开)](https://www.nature.com/articles/s41467-025-67256-9) 和[生物体菌株工程⁠(在新窗口中打开)](https://www.nature.com/articles/s41467-019-13189-z) 的核心环节。本项目初步展现了 AI 如何与生物学家协同工作、共同加速科研进程。优化实验方法，将助力人类研究人员提升研究速度、降低实验成本，并推动科学发现切实转化为现实世界的应用价值。

Because advances in biological reasoning carry biosecurity implications, we conducted this work in a tightly controlled setting—using a benign experimental system, limiting the scope of the task, and evaluating model behavior to inform our biosecurity risk assessments and the development of model- and system-level safeguards, as outlined in our [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf).

由于生物推理能力的进步涉及生物安全风险，本研究在高度受控的环境中开展——采用无害的实验系统、严格限定任务范围，并对模型行为进行评估，以支撑我们的生物安全风险评估，以及模型级与系统级防护措施的开发，具体详见我们的[《准备就绪框架》⁠（在新窗口中打开）](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf)。

## Experimental results

## 实验结果

In this set-up, GPT‑5 autonomously reasoned about the cloning protocol, proposed modifications, and incorporated data from new experiments to suggest more improvements. The only human intervention was having scientists carry out the modified protocol and upload experimental data.

在此实验设置中，GPT‑5 自主推演克隆实验流程、提出流程优化方案，并整合新实验产生的数据，进一步提出改进建议。唯一的人工干预仅限于由科研人员执行优化后的实验流程，并上传实验数据。

Over the course of multiple rounds, GPT‑5 optimized the cloning procedure to improve the efficiency by over 79x—meaning that for a fixed amount of input DNA, we recovered 79x more sequence-verified clones than the baseline protocol. Most notably, it introduced two enzymes that constitute a novel mechanism: the recombinase RecA from _E. coli_, and phage T4 gene 32 single-stranded DNA–binding protein (gp32). Working in tandem, gp32 smooths and detangles the loose DNA ends, and RecA then guides each strand to its correct match.

经过多轮迭代，GPT‑5 将克隆流程优化至效率提升逾 79 倍——即在输入 DNA 量固定的前提下，所获得的经测序验证的克隆体数量达基准流程的 79 倍。尤为突出的是，模型引入了两种酶，共同构成一种全新机制：来自大肠杆菌（_E. coli_）的重组酶 RecA，以及噬菌体 T4 的基因 32 编码单链 DNA 结合蛋白（gp32）。二者协同作用：gp32 先将松散的 DNA 末端理顺并解缠，RecA 再引导每条 DNA 链精准配对。

GPT-5 optimized the cloning and transformation protocol to produce a >70-fold gain

GPT‑5 优化克隆与转化流程，实现逾 70 倍的效率提升

HiFiRAPF-HiFiHiFi + T7 transformationRAPF + T7 transformation1x2x4x8x16x32x64x128xEfficiency change (fold-change vs. HiFi)\[log₂\]

HiFi（基准流程）RAPF–HiFiHiFi + T7 转化RAPF + T7 转化1×2×4×8×16×32×64×128×效率变化（相对于 HiFi 的倍数变化）\[log₂\]

Initial screening and secondary experiments identified RecA-Assisted Pair-and-Finish HiFi Assembly (RAPF) and Transformation 7 (T7) as the top enzymatic and transformation protocols, respectively. Both RAPF assembly and T7 transformation independently improved cloning efficiency relative to the base HiFi reaction cloning protocol, 2.6-fold and 36-fold respectively; and combined to provide an additive improvement in performance of 79-fold. All clones were confirmed by sequencing. (Error bars: SD of n=3 independent validation experiments).

初步筛选及后续验证实验确认：“RecA 辅助配对与终末完成式 HiFi 组装”（RAPF）与“转化方案 7”（T7）分别为最优的酶促组装与转化方案。相较于基准 HiFi 反应克隆流程，RAPF 组装与 T7 转化各自独立地将克隆效率分别提升了 2.6 倍与 36 倍；二者联用则产生叠加效应，整体性能提升达 79 倍。所有克隆体均经测序验证。（误差线：n = 3 次独立验证实验的标准差）

While early, these results are encouraging. The improvements are specific to our particular cloning set up used in our model system, and still require human scientists to set up and run the protocols. Even so, these experiments show that AI systems can meaningfully assist real laboratory work and may accelerate human scientists in the future.

尽管尚处早期阶段，这些结果仍令人鼓舞。相关性能提升仅适用于本模型系统所采用的特定克隆实验设置，且整个流程仍需人类科研人员进行搭建与操作。即便如此，这些实验表明，AI 系统已能切实辅助真实的实验室工作，未来有望显著加速科研人员的研究进程。

Notably, the AI-lab loop was run with fixed prompting and no human intervention. This scaffolding helped reveal the model’s capacity to propose genuinely novel protocol changes independent of human guidance, but it also locked the system into exploration and limited its ability to maximize the performance of newly discovered ideas. A better dynamic balance between exploration and exploitation would likely yield larger gains, as both the enzymatic and transformation improvements have substantial room for refinement. We expect advances in planning and task-horizon reasoning to improve the ability of simple fixed prompts to support both discovery and subsequent optimization.

值得注意的是，本次“AI–实验室闭环”全程采用固定提示词（fixed prompting），且未引入任何人工干预。该设计框架有助于揭示模型在无人类指导前提下自主提出真正新颖实验方案的能力；但同时也使系统陷入纯探索模式，限制了其对新发现方案进行深度优化与性能最大化的能力。若能在探索（exploration）与利用（exploitation）之间实现更优的动态平衡，预期可取得更大提升——因为当前发现的酶促与转化优化方案均仍有广阔精进空间。我们预计，随着规划能力与任务时间跨度推理能力（task-horizon reasoning）的持续进步，简单固定的提示词将更有效地同时支持科学发现与后续优化。

## An evolutionary framework for optimizing real-world protocols

## 用于优化现实世界实验流程的进化式框架

The [Gibson assembly⁠(opens in a new window)](https://www.nature.com/articles/nmeth.1318) reaction has been a primary cloning method since its invention in 2009, with widespread adoption across molecular biology.  

[吉布森组装（Gibson assembly）⁠(在新窗口中打开)](https://www.nature.com/articles/nmeth.1318) 反应自2009年问世以来，已成为分子生物学领域主流的克隆方法之一，并被广泛采用。

Gibson assembly lets molecular biologists “glue” pieces of DNA together by briefly melting their ends so matching sequences can be sealed into a single molecule.  

吉布森组装使分子生物学家能够通过短暂熔解DNA片段末端，使互补序列彼此配对并共价连接，从而将多段DNA“粘合”成单一分子。

One major appeal of Gibson assembly is its simplicity: everything happens in a single tube at one temperature. Those constraints naturally leave room for improvement.  

吉布森组装的一大优势在于其操作简洁性：整个反应在单管中、单一温度下完成。然而，这些限制条件也自然为其优化留下了空间。

In addition, the following properties make it well-suited to evaluating AI models’ abilities to improve wet lab techniques:

此外，以下特性使其成为评估AI模型改进湿实验（wet lab）技术能力的理想平台：

- Well-defined with controlled components, unlike a cell-based system  
- 组分明确且可控，不同于基于活细胞的系统  

- Has a clear optimization function: transformable circularized DNA made from a fixed amount of linear DNA inputs  
- 具有清晰的优化目标：以固定量的线性DNA输入，生成可转化的环状DNA  

- Relatively fast experimental cycles (1-2 days)  
- 实验周期相对较短（1–2天）  

- High-dimensional design space that requires mechanistic reasoning to improve: optimal buffers, reagents, and temperatures are all interdependent  
- 高维设计空间，需依赖机制性推理进行优化：最优缓冲液、试剂与反应温度等参数彼此耦合、相互依赖  

We used [HiFi assembly⁠(opens in a new window)](https://www.neb.com/en-us/applications/cloning-and-synthetic-biology/dna-assembly-and-cloning/nebuilder-hifi-dna-assembly?srsltid=AfmBOoo1sNIc0ELdZ6rZXK8ERV18f4x8nNd7WTyKXyCWClhMmGCPxRFM), a proprietary enzyme system developed by New England Biolabs and based on Gibson assembly, as an optimization starting point.  

我们选用[HiFi组装⁠(在新窗口中打开)](https://www.neb.com/en-us/applications/cloning-and-synthetic-biology/dna-assembly-and-cloning/nebuilder-hifi-dna-assembly?srsltid=AfmBOoo1sNIc0ELdZ6rZXK8ERV18f4x8nNd7WTyKXyCWClhMmGCPxRFM)——一种由New England Biolabs公司开发、基于吉布森组装原理的专有酶体系——作为优化起点。

We explored whether an AI could innovate and learn from experimental feedback once the single-step and isothermal constraints were removed, and thereby identify protocol improvements in this scenario.  

我们探索了：当解除“单步反应”与“恒温”这两项约束后，AI是否能实现自主创新，并从实验反馈中持续学习，从而在此场景下识别出更优的实验方案。

Specifically, we performed a two-piece cloning reaction using a gene for green fluorescent protein (GFP) and the widely used pUC19 plasmid, a standard DNA “vehicle” used to carry genes into bacteria so they can be copied. The goal was to increase the number of successful colonies.  

具体而言，我们开展了一项两片段克隆反应，使用绿色荧光蛋白（GFP）基因与广泛应用的pUC19质粒——一种标准DNA“载体”，用于将外源基因导入细菌并实现扩增。本实验的目标是提高成功转化菌落的数量。

We optimized the cloning reaction by introducing an evolutionary framework for iterating on proposals, enabling the model to learn “online” from its past experiments.  

我们通过引入一种进化式迭代框架来优化该克隆反应，使模型能够基于过往实验结果实现“在线”学习。

In each round, GPT‑5 proposed a batch of 8-10 different reactions, with reactions pushed to later rounds if they required custom reagents the laboratory did not have readily on hand.  

每一轮中，GPT‑5提出8–10种不同的反应方案；若某方案需使用实验室暂无现货的定制化试剂，则该方案将顺延至后续轮次。

Human scientists then carried out the reactions and measured the colony counts relative to the baseline HiFi Gibson assembly in an initial screen.  

随后，人类科学家执行这些反应，并在初筛中测定各反应所得菌落数目，以基准HiFi吉布森组装为对照进行归一化比较。

The best performing data from the previous round were then fed into the next round.  

上一轮中表现最优的实验数据将作为输入，进入下一轮迭代。

Importantly, the prompting was standardized with no human input beyond clarifying questions, allowing us to attribute novel mechanistic insights directly to the AI rather than human guidance.  

尤为重要的是，所有提示（prompting）均采用标准化流程，除必要澄清性提问外，不引入任何人为干预——这使我们得以将所获新颖机制性洞见直接归因于AI本身，而非人类指导。

We retested the top eight reactions from the full optimization series using a wider range of DNA dilutions, and found that many showed smaller effects than in the initial screen; ultimately, the strongest validated candidate was a reaction from round-5 that reproduced its original performance.  

我们对完整优化系列中排名前八的反应方案，在更宽泛的DNA稀释梯度下进行了复测，发现其中多数方案的效果弱于初筛结果；最终，经验证效果最强的候选方案来自第五轮，且其性能在复测中得到了重现。

Many high performers fell into the ligase-polish family, which appears particularly sensitive to small variations in competent-cell state and/or post-reaction DNA handling.  

许多高表现方案属于“连接酶-修整”（ligase-polish）类型，该类反应对感受态细胞状态及/或反应后DNA操作的微小变化尤为敏感。

Because these reactions used a short HiFi step, we hypothesize that many products likely enter _E. coli_ with only one junction sealed and the other held by annealing, leaving downstream rescue to cellular repair pathways.  

由于此类反应仅采用短暂的HiFi步骤，我们推测：大量产物进入大肠杆菌（_E. coli_）时，仅有一个连接位点完成共价封闭，另一连接位点则仅靠退火维持；后续修复则依赖宿主细胞自身的DNA修复通路。

This creates high variance and a ‘jackpot’ dynamic: even if most of the time variants of this reaction don’t outperform, a single strong outlier can carry the family into subsequent rounds.  

这导致结果高度变异，并呈现“大奖”（jackpot）式动态：即便大多数此类反应变体并未超越基准，单个强效离群值（outlier）便足以推动整个反应家族进入后续优化轮次。

While we focused on optimizing the cloning reaction over rounds due to its mechanistic complexity, we in parallel optimized the transformation procedure using a single “one-shot” round where the model proposed many independent changes, and we took the top performing reaction.  

尽管我们因克隆反应本身的机制复杂性而侧重于多轮迭代优化，但与此同时，我们也采用单轮“一次性”（one-shot）策略对转化（transformation）步骤进行了并行优化：模型一次性提出多项独立调整方案，我们选取其中表现最优者。

Cloning efficiency increases from initial screening over rounds  

克隆效率随实验轮次推进而提升（相对于初始筛选）

012345Experimental round0x2x4x6x8x10x12x14xEfficiency change (fold-change vs. HiFi)

0 1 2 3 4 5  
实验轮次  

0× 2× 4× 6× 8× 10× 12× 14×  
效率变化（相对于HiFi的倍数变化）

Transformation optimization (one shot round)  

转化优化（单轮“一次性”优化）

T7T13T12T2T1T4T11T8T3T6T5T9T10Transformation reactions  
T7T13T12T2T1T4T11T8T3T6T5T9T10转化反应  

0×4×8×12×16×20×Efficiency change (fold-change vs. Ref)  
0×4×8×12×16×20×效率变化（相对于参照组的倍数变化）  

REFREFREFREFREFREFREFREFREFREFREFREFREF  
REFREFREFREFREFREFREFREFREFREFREFREFREF  

Initial optimization screens of the two-step cloning workflow: enzymatic assembly and transformation.  
两步克隆流程的初始优化筛选：酶促组装与转化。  

(Left) Iterative optimization of enzymatic assembly over five rounds (44 reactions total). Starting from the HiFi assembly baseline, GPT‑5 proposed 8–10 assembly protocol variants per round; data of top-performing results were incorporated into subsequent prompts. At each round, we plot the top-performing reaction so far (including previous rounds).  
（左）酶促组装的五轮迭代优化（共44个反应）。以HiFi组装为基准起始，GPT‑5每轮提出8–10种组装方案变体；各轮中表现最优的结果数据被纳入后续提示词中。每轮均绘制截至目前（含此前各轮）表现最优的反应结果。  

(Right) One-shot optimization of transformation conditions testing 13 different protocols. For both optimization screens, data represents single measurements (n=1) per condition; replicated validation was performed separately for top candidates.  
（右）转化条件的一次性优化，共测试13种不同方案。在两类优化筛选中，所展示数据均为各条件下单次测量结果（n = 1）；针对表现最优的候选方案，后续另行开展了重复验证实验。  

Using standardized prompts with no human input, GPT5 improved end-to-end cloning efficiency 79-fold, confirmed across experimental replicates.  
在全程无任何人工作干预、仅使用标准化提示词的前提下，GPT‑5将端到端克隆效率提升了79倍，并在多次独立实验重复中得到验证。  

Notably, the model proposed a new enzymatic procedure, which the model called RecA-Assisted Pair-and-Finish HiFi Assembly (RAPF-HiFi), that adds two new proteins to the reaction: the recombinase RecA from *E. coli*, and the phage T4 gene 32 single-stranded DNA–binding protein (gp32). Further, the model made deliberate modifications to the incubation temperature and time, and the timing of enzymatic additions: it proposed adding RecA and gp32 after an initial 50°C HiFi reaction, letting these proteins work at 37°C, and then going back to 50°C to complete the assembly. Together, these new modifications boosted efficiency over 2.5-fold. It should be noted that this represents the initial performance without iterative optimization of reaction conditions and timing.  
值得注意的是，该模型提出了一种全新的酶促方法，命名为“RecA辅助配对-终末完成HiFi组装”（RAPF-HiFi），其核心是在反应体系中新增两种蛋白：来自大肠杆菌（*E. coli*）的重组酶RecA，以及噬菌体T4基因32编码的单链DNA结合蛋白（gp32）。此外，模型还对孵育温度与时间、以及酶添加时序进行了有意识的调整：先于50°C进行初始HiFi反应，随后加入RecA与gp32，在37°C下使其发挥作用，最后再升温回50°C完成组装。上述新改进协同作用，使效率提升超过2.5倍。需特别说明的是，该性能数据反映的是未经反应条件与时间参数迭代优化的初始表现。  

20 uL reaction volume  
20 µL反应体系体积  

100 ng pUC19 vector, HindIII/KpnI-digested  
100 ng pUC19载体，经HindIII/KpnI双酶切  

64.3 ng Monster GFP insert, DpnI-digested PCR amplicon  
64.3 ng Monster GFP插入片段，为经DpnI消化的PCR扩增产物  

10 μL NEBuilder 2x HiFi DNA Assembly Master Mix  
10 µL NEBuilder 2× HiFi DNA组装预混液  

50°C – 30 min; 4°C hold  
50°C — 30分钟；4°C保存  

On the transformation side, the most effective modification proved unexpectedly simple: pelleting the cells (spinning them down in a centrifuge so they collect at the bottom of the tube), removing half of the supplied volume, and resuspending the cells before adding DNA, all at 4°C. While high-efficiency chemically competent cells are typically considered fragile, the cells tolerated concentration well and the increased molecular collisions boosted transformation efficiency substantially (>30-fold on final validation).  
在转化环节，最有效的改进出人意料地简单：将感受态细胞离心沉淀（在离心机中高速离心，使细胞沉降至管底），弃去一半上清液体积，然后在4°C下重悬细胞，再加入DNA。尽管高效率化学感受态细胞通常被认为较为脆弱，但本实验中细胞对浓缩处理耐受良好，分子碰撞频率的提高显著提升了转化效率（最终验证中提升逾30倍）。

## A novel improvement to homology-based cloning

## 基于同源性的克隆技术的一项新改进

![Diagram showing the steps of RecA-assisted pair-and-finish HiFi DNA assembly, with labeled stages for T5 exonuclease, GP32, RecA, polymerase, and ligase acting sequentially on DNA strands.](images/measuring-ai_s-capability-to-accelerate-biological-research-in-the-wet-lab-opena/img_002.png)

![RecA 辅助的“配对—完成”式 HiFi DNA 组装流程示意图，图中标注了 T5 外切酶、GP32、RecA、DNA 聚合酶和连接酶在 DNA 链上依次作用的各阶段。](images/measuring-ai_s-capability-to-accelerate-biological-research-in-the-wet-lab-opena/img_002.png)

T5 exonuclease creates 3′ overhangs that gp32 stabilizes by suppressing secondary structure. RecA then invades from the 3′ ends, displacing gp32 and promoting homology search and annealing. Heating to 50 °C removes both proteins, enabling polymerase gap fill and ligation.

T5 外切酶产生 3′ 突出端，gp32 通过抑制 DNA 二级结构来稳定这些突出端。随后，RecA 从 3′ 末端侵入，置换 gp32，并促进同源序列搜索与退火。升温至 50 °C 可使这两种蛋白从 DNA 上解离，从而允许 DNA 聚合酶填补缺口并由连接酶完成连接。

Gibson assembly works by giving pieces of DNA matching “sticky” ends so that they can find each other and join. The reaction uses two different enzymes (a polymerase and a ligase) to seal the joined pieces. In RAPF-HiFi, two proteins were introduced to make the matching step work better. The first, gp32, acts like a comb that smooths and untangles the loose DNA ends. The second, RecA, acts like a guide that searches for the correct partner for each strand and pulls the matching pieces together. Higher temperature causes both helpers to fall off the DNA, allowing the normal Gibson enzymes to complete the reaction.

Gibson 组装法通过为 DNA 片段提供互补的“黏性末端”，使其能够彼此识别并连接。该反应利用两种酶（一种 DNA 聚合酶和一种连接酶）将连接后的片段共价封闭。在 RAPF-HiFi 方法中，引入了两种新蛋白以提升“匹配”步骤的效率：第一种是 gp32，其作用类似于一把“梳子”，可理顺并解开松散的 DNA 末端；第二种是 RecA，其作用类似于一位“向导”，能为每条单链搜寻正确的配对伙伴，并将匹配的 DNA 片段拉近并促使其结合。升高温度则促使这两种辅助蛋白从 DNA 上脱落，从而使常规 Gibson 反应中的聚合酶与连接酶得以完成后续步骤。

In summary, we hypothesize that the improved performance is mediated via the following mechanism:

总之，我们提出如下假说：性能提升由以下机制介导：

- Gp32 coats non-annealed single-stranded DNA (ssDNA) tails, removing secondary structure  
- RecA, normally inhibited by structure, invades from the 3’ and displaces the gp32 filament  
- RecA mediates a [ssDNA:ssDNA homology search⁠(opens in a new window)](https://www.pnas.org/doi/10.1073/pnas.82.2.297), driving annealing  
- A return to 50°C displaces both the recA and the gp32 filaments, allowing polymerase and ligase to complete the reaction.

- gp32 包被未退火的单链 DNA（ssDNA）末端，消除其二级结构；  
- RecA 通常受二级结构抑制，但可在 3′ 端侵入，并置换 gp32 形成的蛋白丝；  
- RecA 介导 [ssDNA:ssDNA 同源序列搜索⁠(在新窗口中打开)](https://www.pnas.org/doi/10.1073/pnas.82.2.297)，驱动退火过程；  
- 温度回升至 50 °C 后，RecA 和 gp32 均从 DNA 上解离，使 DNA 聚合酶与连接酶得以完成反应。

To test whether the novel enzymes were functional, and to rule out that the performance improvement is driven solely by changes in thermal steps or buffers, we tested the performance of RAPF-HiFi without RecA, and without both RecA and gp32. The performance of both reactions was reduced relative to RAPF-HiFi, suggesting that both proteins are necessary for the mechanism of action of RAPF-HiFi.

为验证这两种新型酶是否具有功能活性，并排除性能提升仅源于热循环条件或缓冲体系改变的可能性，我们分别测试了缺失 RecA 的 RAPF-HiFi 体系，以及同时缺失 RecA 和 gp32 的体系。结果表明，这两种体系的组装效率均低于完整 RAPF-HiFi 体系，提示 RecA 与 gp32 对 RAPF-HiFi 的作用机制均不可或缺。

Ablating the RecA and gp32 reaction

RecA 与 gp32 反应组分的缺失实验

HiFiRAPF (recA- gp32-)RAPF (recA-)RAPF0x0.5x1x1.5x2x2.5x3x3.5xEfficiency change (fold-change vs. HiFi)

HiFi（对照）RAPF（recA⁻ gp32⁻）RAPF（recA⁻）RAPF0x0.5x1x1.5x2x2.5x3x3.5x效率变化（相对于 HiFi 的倍数变化）

To test the underlying mechanism, we separate out the two new enzymes in the reaction: RecA and gp32. We show that either of these alone reduces the efficiency relative to the HiFi baseline. Together, they outperform the baseline with a 2.6x efficiency gain. (Error bars: SD of n=3 independent experiments)

为探究其内在机制，我们将反应中新引入的两种酶——RecA 与 gp32——分别剔除。结果表明：单独缺失任一蛋白均导致组装效率低于 HiFi 基线水平；而两者共存时，则可实现比基线高 2.6 倍的效率提升。（误差线：n = 3 次独立实验的标准差）

The development RAPF-HiFi suggests that GPT‑5 is capable of complex, multi-dimensional reasoning:

RAPF-HiFi 的开发表明，GPT‑5 具备复杂、多维度的推理能力：

- [RecA 受 DNA 结构抑制⁠(在新窗口中打开)](https://www.pnas.org/doi/10.1073/pnas.151242898)，值得注意的是，该模型同时引入了两项协同修饰：添加 RecA，并辅以 gp32 以消除 DNA 二级结构。  
- _E. coli_ RecA 的天然配体是 _E. coli_ 单链结合蛋白（SSB）。SSB 在基因组复制、重组与修复过程中发挥与 gp32 类似的作用。然而，_E. coli_ SSB 从 DNA 上自发解离的速度过慢，不足以支持 RecA 丝状体的延伸；体内实验表明，[RecFOR 复合物可促进 RecA 在 SSB 丝状体上的成核⁠(在新窗口中打开)](https://www.sciencedirect.com/science/article/pii/S1097276503001886)。SSB 以稳定的四聚体形式结合 DNA，其[解离速率极低⁠(在新窗口中打开)](https://pubs.acs.org/doi/10.1021/bi020122z)。相比之下，gp32 丝状体则[更具动态性⁠(在新窗口中打开)](https://www.sciencedirect.com/science/article/pii/S0022283624001396)，从而允许 RecA 取代其位置。

To our knowledge, RecA and gp32 have not been functionally co-used in molecular biology methods. As with many novel molecular biology techniques, the underlying biochemical activities were already studied, but their use as a practical, generalizable method constitutes the advance.

据我们所知，RecA 与 gp32 尚未在分子生物学方法中被功能性联用。与许多新型分子生物学技术类似，其底层生化活性早已被研究清楚，但将其发展为一种实用、可推广的方法，才构成了真正的技术进步。

For example, the interaction of RecA and gp32 has been studied in mechanistic in vitro reconstitution assays: in studies of D loop formation, [gp32 was shown⁠(in a new window)](https://www.pnas.org/doi/10.1073/pnas.77.5.2606?url_ver=Z39.88-2003&rfr_id=ori%3Arid%3Acrossref.org&rfr_dat=cr_pub++0pubmed) to be capable of enhancing RecA activity. Gp32 has been used in conjunction with its natural T4 recombinase partner UvsX and recombinase loading factor uvsY in [recombinase polymerase amplification (RPA⁠(in a new window)](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.0040204)). Although an [RPA patent specification states⁠(in a new window)](https://patents.google.com/patent/US20090029421A1/en) that effective RPA reactions have been demonstrated using E. coli RecA in a heterologous system with a compromised (i.e., engineered, non–wild-type) gp32 protein, this assertion appears only as a tangent in some patent disclosures and, to our knowledge, has not been supported by published data or adopted as a robust RecA-based RPA system. One cloning method called [SLiCE⁠(in a new window)](https://academic.oup.com/nar/article/40/8/e55/2411705) uses a whole cell extract from _E. coli_ containing the λ Red recombination system, where Red beta may perform dual roles as both a DNA-binding protein and recombinase (though we explicitly prohibited the use of cell extracts in our prompt). In a different application, [Ferrin & Camerini-Otero⁠(in a new window)](https://www.pnas.org/doi/10.1073/pnas.95.5.2152) used RecA alone to selectively capture DNA molecules based on matching sequences. Separately, [gp32 has been used as an additive⁠(in a new window)](https://academic.oup.com/nar/article/18/4/1079/1112638) in a DNA amplification process called PCR to reduce secondary structure. [NABSA amplification was shown⁠(in a new window)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0265391) to be enhanced by both RecA and gp32, though each could enhance the reaction separately and no synergy was identified. More broadly, reported improvements to the basic Gibson-style DNA assembly reactions have been scarce, with the most notable example being a heat-stable DNA-binding protein (ET SSB) that [improves assembly efficiency by approximately 2.5-fold⁠(in a new window)](https://www.biorxiv.org/content/10.1101/2020.06.14.150979v1).

例如，在机制性体外重建实验中，RecA 与 gp32 的相互作用已被深入研究：在 D-loop 形成研究中，[已有研究表明⁠(在新窗口中打开)](https://www.pnas.org/doi/10.1073/pnas.77.5.2606?url_ver=Z39.88-2003&rfr_id=ori%3Arid%3Acrossref.org&rfr_dat=cr_pub++0pubmed)，gp32 能够增强 RecA 活性。gp32 还曾与它的天然 T4 重组酶伙伴 UvsX 及重组酶装载因子 uvsY 联用，应用于[重组酶聚合酶扩增（RPA⁠(在新窗口中打开)](https://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.0040204))。尽管某项[RPA 专利说明书指出⁠(在新窗口中打开)](https://patents.google.com/patent/US20090029421A1/en)，在异源系统中使用 _E. coli_ RecA 并配合经改造（即工程化、非野生型）的 gp32 蛋白，已成功实现高效 RPA 反应，但该说法仅作为部分专利披露中的旁支论述出现；据我们所知，尚无已发表数据予以支持，也未被采纳为稳健可靠的基于 RecA 的 RPA 系统。另一种名为[SLiCE⁠(在新窗口中打开)](https://academic.oup.com/nar/article/40/8/e55/2411705) 的克隆方法，利用含 λ Red 同源重组系统的 _E. coli_ 全细胞提取物——其中 Red beta 可能兼具 DNA 结合蛋白与重组酶双重功能（尽管我们在提示词中明确禁止使用细胞提取物）。在另一应用场景中，[Ferrin 与 Camerini-Otero⁠(在新窗口中打开)](https://www.pnas.org/doi/10.1073/pnas.95.5.2152) 单独使用 RecA，依据序列匹配特异性捕获 DNA 分子。此外，[gp32 曾作为添加剂⁠(在新窗口中打开)](https://academic.oup.com/nar/article/18/4/1079/1112638) 应用于一种称为 PCR 的 DNA 扩增流程，以降低 DNA 二级结构干扰。[NABSA 扩增实验显示⁠(在新窗口中打开)](https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0265391)，RecA 和 gp32 均可单独增强该反应，但二者联用未观察到协同效应。更广泛而言，针对基础 Gibson 式 DNA 组装反应的改进报道极为稀少；其中最显著的案例是一种耐热 DNA 结合蛋白（ET SSB），其[可将组装效率提升约 2.5 倍⁠(在新窗口中打开)](https://www.biorxiv.org/content/10.1101/2020.06.14.150979v1)。

For most applications, we do not expect RAPF-HiFi to compete with the simplicity and robustness of HiFi/Gibson cloning. However, the emergence of a mechanistically distinct assembly pathway is noteworthy: GPT‑5 arrived at a solution that incorporates an unfamiliar combination of recombination proteins and reaction dynamics. The underlying mechanism may prove modular, providing components that can be repurposed or recombined in other molecular workflows. We are also continuing to explore improvements to RAPF-HiFi. Reaction temperatures and step durations can be tuned to balance RecA and gp32 activity against exonuclease over-digestion, and the amounts of both proteins remain to be optimized. GPT‑5 has also proposed a hyperactive RecA variant, which we are currently purifying.

在大多数应用场景下，我们并不预期 RAPF-HiFi 能在简易性与稳健性方面超越 HiFi/Gibson 克隆。然而，一条机制上截然不同的组装通路的出现仍值得关注：GPT‑5 提出了一种融合了陌生重组蛋白组合与新颖反应动力学的解决方案。该底层机制可能具备模块化特性，其所提供的组件有望被重新利用或整合至其他分子实验流程中。我们亦持续探索 RAPF-HiFi 的优化路径：可通过调节反应温度与各步骤时长，在 RecA/gp32 活性与外切酶过度消化之间取得平衡；两种蛋白的用量仍有待进一步优化。此外，GPT‑5 还提出了一种高活性 RecA 变体，目前我们正对其进行纯化。

With respect to the transformation protocol, the successful optimization conditions spanned a range of additives and thermal perturbations intended to enhance the heat-shock efficiency of commercial [10-beta competent cells⁠(in a new window)](https://www.neb.com/en-us/products/c3019-neb-10-beta-competent-e-coli-high-efficiency?srsltid=AfmBOorcs_qhj9EZFQ4g-gGg2ZDAOkN4GF8JZijwvEEn3JIJFcYt_N3y). Of the 13 AI-generated one-shot transformations tested, the most effective modification, Transformation 7 (T7), pelleted the cells, removing half of the supplied volume, and resuspending the cells before adding DNA, all at 4°C. High-efficiency chemically competent cells are typically considered fragile, and such handling steps are generally avoided. Nonetheless, the cells tolerated concentration well. The combined effects of increased DNA exposure per cell and less inhibitory buffer leading to a sharper heat-shock yielded a substantial increase in transformation efficiency (>30-fold).

就转化方案而言，成功的优化条件涵盖一系列旨在提升商用[10-beta 感受态细胞⁠(在新窗口中打开)](https://www.neb.com/en-us/products/c3019-neb-10-beta-competent-e-coli-high-efficiency?srsltid=AfmBOorcs_qhj9EZFQ4g-gGg2ZDAOkN4GF8JZijwvEEn3JIJFcYt_N3y) 热激效率的添加剂与热扰动策略。在测试的 13 种 AI 生成的一次性转化方案中，效果最佳的改良方案——转化方案 7（T7）——在 4°C 下对细胞进行离心沉淀，弃去一半上清液，再于 4°C 下重悬细胞，随后加入 DNA。高效率化学感受态细胞通常被认为较为脆弱，此类操作步骤一般被刻意避免。然而，细胞对浓缩处理表现出良好耐受性。单位细胞接触 DNA 量增加、抑制性缓冲液减少共同导致更锐利的热激响应，最终使转化效率大幅提升（>30 倍）。

This transformation protocol is novel, although a conceptually [similar approach⁠(in a new window)](https://portlandpress.com/bioscirep/article/33/6/e00086/55976/A-comparison-and-optimization-of-methods-and) where the cells are concentrated at an earlier step has been reported. Notably, the method developed here by GPT‑5 is compatible with off-the-shelf chemically competent cells, eliminating the need for in-house cell preparation, while exceeding the similar approach’s reported efficiency gains on comparable cell strains.

该转化方案属首创；尽管已有文献报道一种概念上[相似的方法⁠(在新窗口中打开)](https://portlandpress.com/bioscirep/article/33/6/e00086/55976/A-comparison-and-optimization-of-methods-and)，即在更早阶段对细胞进行浓缩，但本研究中由 GPT‑5 开发的方法具有独特优势：它可直接兼容市售化学感受态细胞，无需实验室自行制备，且在相同菌株上实现的效率提升更优于前述相似方法的报道结果。

## Robotic system

## 机器人系统

To increase the throughput of this model experimental system, Robot on Rails and Red Queen Bio collaborated to build a robotic system that takes in a natural language cloning protocol and executes it in the wet lab.

为提升该模型实验系统的通量，Robot on Rails 与 Red Queen Bio 合作构建了一套机器人系统，能够接收自然语言描述的克隆方案，并在湿实验室内自动执行。

The system combines three components: 1) a human-to-robot LLM that converts plain English into the robot’s actions; 2) a vision system that identifies and localizes labware in real time; and 3) a robotic path planner that determines how to carry out each action safely and accurately. The result is a flexible, generalized lab robot that was further optimized for variants of the Gibson cloning protocol.

该系统整合三大模块：1）人机交互大语言模型（LLM），将日常英文指令转化为机器人可执行动作；2）视觉系统，实时识别并定位实验耗材；3）机器人路径规划器，确保每项操作安全、精准地完成。最终成果是一台灵活通用的实验室机器人，且已针对 Gibson 克隆方案的多种变体进行了专门优化。

We tested whether the autonomous robot could execute a complete cloning experiment by running two protocols simultaneously: the standard HiFi method and R8, the top-performing AI-modified protocol from the first optimization round.

我们测试了该自主机器人能否通过同时运行两种实验方案——标准 HiFi 方法和 R8（第一轮优化中表现最佳的 AI 改进方案）——来完成整套克隆实验。

We compared the robot’s work to human-performed experiments at each step. The robot successfully handled the transformation process, which required diverse physical operations: transferring and mixing liquids, moving sample tubes, applying controlled heat to cells, and spreading cells onto growth plates. When compared directly with human-performed transformations, the robot generated similar quality data with equivalent improvements over baseline, showing early potential for automating and accelerating biological experiment optimization.

我们在每一步操作中都将机器人的工作与人工实验进行对比。机器人成功完成了转化（transformation）流程，该流程涉及多种物理操作：液体转移与混匀、样本管搬运、对细胞施加可控温度处理，以及将细胞涂布于培养平板上。与人工完成的转化实验直接对比后发现，机器人产出的数据质量相当，并在相对于基线的提升幅度上也基本一致，初步展现出自动化并加速生物学实验优化的潜力。

While the fold-changes between the robot and human experiments were similar, absolute colony counts from the robot were approximately ten-fold lower than manual execution, indicating areas for improvement such as liquid handling precision, temperature control calibration, and replicating the nuances of manual cell handling techniques.

尽管机器人与人工实验之间的倍数变化（fold-changes）相近，但机器人获得的菌落绝对数量约为人工操作的十分之一，表明仍存在若干待改进环节，例如液体处理精度、温控系统校准，以及对人工细胞操作中细微技巧的复现能力。

Comparing robot vs human-executed transformation reactions

机器人执行 vs 人工执行的转化反应对比

Reference (normalized)R80.0x0.5x1.0x1.5x2.0x2.5x{rhex.ytitle}HumanRobot

参考值（归一化）R8 0.0× 0.5× 1.0× 1.5× 2.0× 2.5× {rhex.ytitle} 人工 机器人

Both the standard HiFi method (baseline) and the improved R8 method were executed by human researchers and the autonomous robot, with transformation efficiencies normalized to respective HiFi baseline controls (set to 1.0). Human-executed R8 showed 2.39-fold improvement; robot-executed R8 achieved 2.13-fold improvement (89% of human performance), demonstrating comparable protocol ranking despite lower absolute yields.

标准 HiFi 方法（基线）与优化后的 R8 方法均由人类研究人员及自主机器人分别执行；所有转化效率均以各自对应的 HiFi 基线对照组（设为 1.0）进行归一化处理。人工执行的 R8 方案展现出 2.39 倍的提升；而机器人执行的 R8 方案实现了 2.13 倍提升（达人工性能的 89%），表明其在协议优劣排序方面与人类表现相当，尽管绝对产量较低。

## The future

## 未来展望

We believe that these experiments offer a snapshot of what future AI-accelerated science will look like: models continually learning and interacting with the real world. Although our experiments excluded human intervention to purely measure model capabilities, we’re particularly excited about [AI helping human scientists⁠](https://openai.com/science/) design experiments and contribute to research breakthroughs.

我们相信，这些实验为我们勾勒出未来 AI 加速科学探索的一幅缩影：模型持续学习并实时与物理世界交互。尽管本实验刻意排除人为干预，以纯粹评估模型自身能力，但我们尤其期待 [AI 协助人类科学家⁠](https://openai.com/science/) 设计实验，并推动科研突破。

As we work to accelerate scientific progress safely and responsibly, we also seek to evaluate and reduce risks, particularly those related to biosecurity. These evaluations results show that models can reason in the wet lab to improve protocols, and may have implications for biosecurity as described in our [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf). We are [committed to building⁠](https://openai.com/index/preparing-for-future-ai-capabilities-in-biology/) necessary and nuanced safeguards at a model and system level to reduce these risks, as well as develop evaluations to track current levels.

在致力于安全、负责任地加速科学进步的同时，我们也积极评估并降低相关风险，尤其是生物安全（biosecurity）方面的风险。本次评估结果表明，大模型可在湿实验（wet lab）环境中进行推理，从而优化实验方案；其潜在影响已在我们的 [《准备就绪框架》⁠（新窗口打开）](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf) 中予以阐述。我们 [承诺构建⁠](https://openai.com/index/preparing-for-future-ai-capabilities-in-biology/) 必要且细致入微的模型级与系统级防护机制，以降低此类风险，并同步开发评估方法，用以持续追踪当前风险水平。

- [Framework](https://openai.com/news/?tags=framework)  
- [框架](https://openai.com/news/?tags=framework)

- [GPT](https://openai.com/news/?tags=gpt)  
- [GPT](https://openai.com/news/?tags=gpt)

- [2025](https://openai.com/news/?tags=2025)  
- [2025](https://openai.com/news/?tags=2025)