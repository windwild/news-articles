---
title: "GPT-5 lowers the cost of cell-free protein synthesis | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/gpt-5-lowers-protein-synthesis-cost"
date: "2026-02-05"
scraped_at: "2026-03-02T10:08:20.963325504+00:00"
language: "en-US"
translated: true
description: "An autonomous lab combining OpenAI’s GPT-5 with Ginkgo Bioworks’ cloud automation cut cell-free protein synthesis costs by 40% through closed-loop experimentation."
tags: ["Research"]
---
&#123;% raw %}

February 5, 2026

2026年2月5日

[Research](https://openai.com/news/research/) [Publication](https://openai.com/research/index/publication/)

[研究](https://openai.com/news/research/) [出版物](https://openai.com/research/index/publication/)

# GPT‑5 lowers the cost of cell-free protein synthesis

# GPT‑5 降低了无细胞蛋白合成的成本

Working with Ginkgo Bioworks, we created an AI-driven autonomous lab and achieved a 40% reduction in protein production cost.

与 Ginkgo Bioworks 合作，我们构建了一个由 AI 驱动的自主实验室，并实现了蛋白生产成本降低 40% 的成果。

[Read the paper(opens in a new window)](https://cdn.openai.com/pdf/5a12a3bc-96b7-4e07-9386-db6ee5bb2ed9/using-a-gpt-5-driven-autonomous-lab-to-optimize-the-cost-and-titer-of-cell-free-protein-synthesis.pdf)

[阅读论文（在新窗口中打开）](https://cdn.openai.com/pdf/5a12a3bc-96b7-4e07-9386-db6ee5bb2ed9/using-a-gpt-5-driven-autonomous-lab-to-optimize-the-cost-and-titer-of-cell-free-protein-synthesis.pdf)

Loading…

加载中……

We’ve seen [rapid progress](https://openai.com/index/accelerating-science-gpt-5/) from AI in fields like math and physics, where ideas can often be evaluated without touching the physical world. Biology is different. Progress runs through the lab, where scientists run experiments that take time and money.

我们在数学和物理学等领域已见证了人工智能带来的[迅猛进展](https://openai.com/index/accelerating-science-gpt-5/)——这些领域中的想法往往无需接触物理世界即可验证。而生物学则截然不同：进步必须经由实验室实现，科学家需开展耗时且昂贵的实验。

That’s starting to change. Frontier models can now connect directly to lab automation, propose experiments, run them at scale, learn from the results, and decide what to do next. In much of life science, the bottleneck is iteration, and autonomous labs are built to remove that constraint.

这一现状正开始改变。前沿大模型如今可直接对接实验室自动化系统，自主设计实验、规模化执行、从结果中学习，并决定后续步骤。在生命科学的诸多领域中，“迭代速度”是主要瓶颈，而自主实验室正是为突破这一限制而生。

In earlier work, we showed that GPT‑5 could [improve wet-lab protocols](https://openai.com/index/accelerating-biological-research-in-the-wet-lab/) through closed-loop experimentation. Here, we show that the same approach can reduce the cost of protein production.

在此前的研究中，我们已证实 GPT‑5 可通过闭环实验[优化湿实验（wet-lab）操作流程](https://openai.com/index/accelerating-biological-research-in-the-wet-lab/)。本文进一步表明，该方法同样可用于降低蛋白生产成本。

We partnered with [Ginkgo Bioworks⁠(opens in a new window)](https://www.ginkgo.bio/) to connect GPT‑5 to a cloud laboratory—an automated wet lab run remotely through software, where robots execute experiments and return data—and used that lab-in-the-loop setup to optimize a widely used biological process: cell-free protein synthesis (CFPS). Over six rounds of closed-loop experimentation, the system tested more than 36,000 unique CFPS reaction compositions across 580 automated plates. After being provided access to a computer, a web browser, and access to relevant papers, GPT‑5 took three rounds of experimentation to establish a new state of the art in low-cost CFPS, achieving a 40% reduction in protein production cost (and a 57% improvement in the cost of reagents), including novel reaction compositions that are more robust to reaction conditions common in autonomous labs.

我们与[Ginkgo Bioworks（在新窗口中打开）](https://www.ginkgo.bio/)合作，将 GPT‑5 接入“云实验室”——一种通过软件远程操控的自动化湿实验平台，由机器人执行实验并回传数据。我们利用这种“实验室闭环”（lab-in-the-loop）架构，对一项广泛应用的生物技术——无细胞蛋白合成（Cell-Free Protein Synthesis, CFPS）——进行了优化。在六轮闭环实验中，该系统在 580 块自动化微孔板上测试了逾 36,000 种独特的 CFPS 反应组分。在获得计算机、网页浏览器及关键文献访问权限后，GPT‑5 仅用三轮实验即确立了低成本 CFPS 的新标杆：蛋白生产成本降低 40%（试剂成本降低 57%），并生成了若干新型反应配方——这些配方对自主实验室中常见的反应条件波动展现出更强的鲁棒性。

## Why cell-free protein synthesis matters

## 为什么无细胞蛋白合成至关重要

Cell-free protein synthesis (CFPS) is a way to make proteins without growing living cells. Instead of putting DNA into cells and waiting for them to produce a protein, CFPS runs the protein-making machinery in a controlled mixture. That makes it a practical tool for rapid prototyping and testing as scientists can run many experiments quickly and measure results the same day.

无细胞蛋白合成（CFPS）是一种无需培养活细胞即可生产蛋白质的技术。与将DNA导入细胞、再等待细胞表达目标蛋白的传统方法不同，CFPS在受控的混合体系中直接运行蛋白质合成所需的分子机器。这使其成为一种实用的快速原型构建与测试工具——科学家可当日内完成大量实验并获得检测结果。

Proteins are a big part of what modern biology delivers. Many important medicines are based on proteins. Many diagnostics and research assays depend on proteins. In industrial settings, proteins act as enzymes that make chemical processes cleaner and more efficient. Proteins are even found in your laundry detergent. When protein production becomes faster and cheaper, scientists can usually test more ideas sooner, and reduce the cost of turning early research into something that people can benefit from everyday.

蛋白质是现代生物学成果的重要载体。许多重要药物以蛋白质为基础；大量诊断试剂与科研检测方法依赖于蛋白质；在工业领域，蛋白质作为酶可使化学反应更清洁、更高效；甚至你的洗衣液中也含有蛋白质。当蛋白质生产变得更加快速、廉价时，科学家通常能更快地验证更多构想，并显著降低将早期研究成果转化为日常可用产品的成本。

CFPS is already useful for that kind of iteration. The bottleneck is that it is tricky to optimize and gets expensive at scale.

CFPS 已在上述迭代式研发中展现出实用价值。但其瓶颈在于：优化难度大，且在规模化应用时成本高昂。

## Cell-free protein synthesis is difficult to optimize and costly

## 无细胞蛋白合成难以优化且成本高昂

Cell-free protein synthesis requires complex, interacting ingredients: the DNA template encoding the protein to be made, the cell lysate (the soup of cellular machinery from inside cells), and a large number of biochemical components ranging from energy sources to salts. It is incredibly difficult to reason about the system as a whole, and [many⁠(opens in a new window)](https://pubmed.ncbi.nlm.nih.gov/21520017/) [previous⁠(opens in a new window)](https://www.nature.com/articles/s41467-020-15798-5?utm_source=chatgpt.com) [studies⁠(opens in a new window)](https://www.nature.com/articles/s41467-025-58139-0?utm_source=chatgpt.com) have applied different types of machine learning to reduce protein production cost.

无细胞蛋白合成需依赖多种复杂且相互作用的组分：编码目标蛋白的DNA模板、细胞裂解液（即源自细胞内部的分子机器“浓汤”），以及大量生化成分——从能量物质到各类盐类不等。对整个系统进行整体性建模与推理极为困难；[多项研究⁠(在新窗口中打开)](https://pubmed.ncbi.nlm.nih.gov/21520017/) [先前研究⁠(在新窗口中打开)](https://www.nature.com/articles/s41467-020-15798-5?utm_source=chatgpt.com) [最新研究⁠(在新窗口中打开)](https://www.nature.com/articles/s41467-025-58139-0?utm_source=chatgpt.com) 已尝试采用多种机器学习方法，以降低蛋白质生产成本。

Standard cell-free protein synthesis (CFPS) formulations and commercial kits are often priced for human-paced work. Autonomous labs can run thousands of reactions in the time a human team might run dozens. At that scale, the cost of reagents becomes the limiting factor.

标准无细胞蛋白合成（CFPS）配方及商用试剂盒的定价，往往基于人工操作节奏。而自动化实验室可在人类团队完成数十个反应的时间内，运行数千个反应。在此规模下，试剂成本便成为主要制约因素。

CFPS is also difficult to optimize by intuition alone. It’s a mixture of many interacting components. Small changes can matter, but the direction of the effect isn’t always obvious, and the best combinations can be hard to find without running a lot of experiments. Prior approaches have reduced costs, but progress tends to be incremental because exploring the space thoroughly is labor-intensive.

仅凭直觉也难以优化CFPS：它是由众多相互作用组分构成的复杂混合体系；微小调整可能产生显著影响，但效应方向未必直观明确；若不开展大量实验，极难找出最优组合。此前的方法虽已实现成本下降，但进展多属渐进式——因为对整个参数空间进行系统探索，本身劳动强度极大。

## Connecting GPT‑5 to a robotic lab

## 将 GPT‑5 接入机器人实验室

We paired GPT‑5 with Ginkgo Bioworks’ cloud laboratory to form a closed-loop autonomous system for cell-free protein synthesis (CFPS) optimization.

我们将 GPT‑5 与 Ginkgo Bioworks 的云端实验室相集成，构建了一套面向无细胞蛋白合成（CFPS）优化的闭环自主系统。

GPT‑5 designed batches of experiments. The lab executed them. The results were fed back to the model. The model used that data to propose the next round. We repeated that cycle six times.

GPT‑5 设计了多批实验，实验室执行了这些实验；实验结果被反馈给模型；模型利用这些数据提出下一轮实验方案。我们共重复该闭环流程六次。

![Diagram titled “AI-driven autonomous lab.” GPT-5 performs data analysis, biochemical reasoning, and hypothesis generation, sending experimental designs to Reconfigurable Automation Carts (RACs), which execute physical experiments, automate liquid handling, incubate samples, and measure fluorescence. RACs return experimental data and metrics back to GPT-5, forming a closed feedback loop.](https://images.ctfassets.net/kftzwdyauwt9/2TbblhnZK2vp1IFVnn8KaY/502e325bb6b8996c9f5e91d6e93e783e/AI-driven_autonomous_lab___light_mode.png?w=3840&q=90&fm=webp)

![标题为“AI 驱动的自主实验室”的示意图：GPT‑5 执行数据分析、生化推理与假设生成，并将实验设计方案发送至可重构自动化推车（Reconfigurable Automation Carts, RACs）；RACs 执行实体实验、自动化液体处理、样本孵育及荧光检测；RACs 将实验数据与评估指标回传至 GPT‑5，从而构成一个闭环反馈系统。](https://images.ctfassets.net/kftzwdyauwt9/2TbblhnZK2vp1IFVnn8KaY/502e325bb6b8996c9f5e91d6e93e783e/AI-driven_autonomous_lab___light_mode.png?w=3840&q=90&fm=webp)

_GPT‑5 designed batches of experiments in a standard 384-well plate format, and ran them on Ginkgo Bioworks’ cloud laboratory. Once the experiments finished, the cloud laboratory pushed the data back to GPT‑5, where the model analyzed the outcomes, generated new hypotheses, and designed the next round of experiments._

_GPT‑5 以标准的 384 孔板格式设计多批实验，并在 Ginkgo Bioworks 的云端实验室中运行。实验完成后，云端实验室将数据推送回 GPT‑5；模型据此分析实验结果、生成新假设，并设计下一轮实验。_

To keep the loop grounded in what an autonomous lab can do, we added strict programmatic validation before any experiment ran. That validation enforced that AI-designed experiments were physically executable on the automation platform. It prevented “paper experiments” that look plausible in text but can’t be carried out in a robotic workflow.

为确保该闭环始终立足于自主实验室的实际能力，我们在每次实验运行前加入了严格的程序化验证机制。该验证强制要求所有由 AI 设计的实验必须能在自动化平台上物理执行，从而避免出现仅在文本层面看似合理、却无法在机器人工作流中实际开展的“纸上实验”。

Across the full run, the system executed more than 36,000 CFPS reactions across 580 automated plates. This scale matters because it’s what lets patterns emerge. In biology, single experiments are noisy. Throughput and iteration are how you separate signal from random noise. Once GPT‑5 had access to the relevant paper and tools, it took three rounds of experimentation and two months to establish a new state of the art: 40% lower protein production cost compared to the [best prior baseline⁠(opens in a new window)](https://www.biorxiv.org/content/10.1101/2025.08.01.668204v1.article-info).

在整个实验周期中，该系统在 580 块自动化微孔板上共执行了逾 36,000 次无细胞蛋白合成（CFPS）反应。如此大规模至关重要——唯有足够体量，才能使潜在规律浮现。在生物学研究中，单次实验往往噪声显著；而高通量与多轮迭代，正是从随机噪声中识别真实信号的关键路径。在 GPT‑5 获得相关论文与工具访问权限后，仅经三轮实验、耗时两个月，即确立了一项新基准：蛋白质生产成本较此前最优基线降低 40%——参见[最佳先前基线研究⁠（在新窗口中打开）](https://www.biorxiv.org/content/10.1101/2025.08.01.668204v1.article-info)。

_Ginkgo Bioworks’ reconfigurable automation carts. Credit: Ginkgo Bioworks_

_Ginkgo Bioworks 可重构自动化推车。图片来源：Ginkgo Bioworks_

## What we learned

## 我们的发现

We found that the improvements came from identifying combinations that work well together and that hold up in the realities of high-throughput automation.

我们发现，性能提升源于识别出协同效应良好、且在高通量自动化现实约束下依然稳健的试剂组合。

We found that GPT‑5 identified low-cost reaction compositions that humans had not previously tested in this configuration. Cell-free protein synthesis (CFPS) has been studied for years, but the space of possible mixtures is still large. When you can propose and execute thousands of combinations quickly, you can find workable regions that are easy to miss with a manual workflow.

我们发现，GPT‑5 成功识别出若干低成本反应配方——这些配方此前从未被人类以该特定构型测试过。无细胞蛋白合成（CFPS）虽已研究多年，但其可能的组分混合空间仍极为广阔。当能够快速提出并执行数千种组合时，便有望发现那些在人工工作流中极易被忽略、却切实可行的参数区域。

We also found that high-throughput, plate-based experiments often differ from manual, bench-top experiments. Oxygenation can be lower in high-throughput reaction formats. Mixing and geometry can be different. Most CFPS reactions produce much more protein in test tubes than in microtiter plates, because larger scales generally come with more oxygen availability and better mixing. In fact, for plate-based reactions at low volume, GPT‑5 proposed many reactions that out-performed the prior best immediately after getting access to a computer for data analysis and a web browser to search for relevant papers . Overall, GPT‑5 proposed many reagent combinations that performed well under high-throughput constraints, including many that are more robust in low-oxygen conditions common in automated lab settings.

我们还发现，基于微孔板的高通量实验，常与人工台面实验存在显著差异：高通量反应体系中的供氧水平通常更低；混合效率与几何构型亦有所不同。多数 CFPS 反应在试管中产生的蛋白量远高于微孔板，原因在于更大规模的反应体系通常具备更充足的氧气供应与更优的混合效果。事实上，在低体积微孔板反应中，GPT‑5 在刚获得用于数据分析的计算机及用于检索相关文献的网页浏览器后，所提出的诸多反应方案即已超越此前最优结果。总体而言，GPT‑5 提出的大量试剂组合均能在高通量约束下表现优异，其中许多组合对自动化实验室环境中常见的低氧条件更具鲁棒性。

In addition, we found that small changes in buffering, energy regeneration components, and polyamines had an outsized impact relative to their cost. These are not always the first parameters people reach for, but at high throughput, they become testable hypotheses rather than background assumptions.

此外，我们发现缓冲体系、能量再生组分和多胺的微小调整，其影响远超其成本投入。这些参数并非人们通常最先尝试优化的对象，但在高通量条件下，它们便从背景假设转变为可检验的科学假说。

Finally, the cost structure itself shaped what mattered. In CFPS, costs are now dominated by lysate and DNA. That means yield is the highest-leverage strategy. If you can boost protein output per unit of expensive input, you make meaningful progress on cost even before you chase marginal savings elsewhere.

最后，成本结构本身决定了哪些因素最为关键。在无细胞蛋白合成（CFPS）中，当前成本主要由裂解液（lysate）和DNA主导。这意味着提高产率（yield）是最具杠杆效应的策略：只要能提升单位高价原料所产出的蛋白量，即便尚未在其他环节追求边际节约，也能显著降低整体成本。

#### Autonomous lab iteration cuts cost while raising protein yield

#### 自主实验室迭代在提升蛋白产量的同时降低生产成本

_Across six rounds of autonomous experimentation, the system steadily improved cell-free protein synthesis, driving costs down while increasing protein yield. Results are shown as reaction cost versus protein titer for each round, with the best tradeoffs forming a frontier. Larger points mark the lowest cost-per-gram achieved in each round, and the star/dotted reference indicates the prior state-of-the-art benchmark in 384-well plates (Olsen et al., 2025). A closer look at the later rounds highlights the final gains, and a round-by-round summary shows the best cost-per-gram decreasing over time._

_在六轮自主实验迭代中，该系统持续优化无细胞蛋白合成过程，在降低反应成本的同时不断提升蛋白产量。结果以每轮反应成本（横轴）与蛋白滴度（纵轴）呈现，其中最优权衡点构成一条前沿曲线（Pareto frontier）。较大的数据点代表各轮中实现的最低“每克成本”，而星号/虚线参考点则标示此前在384孔板中达到的最先进基准水平（Olsen 等，2025）。对后期几轮结果的深入分析凸显了最终取得的增益；逐轮汇总数据则清晰显示，最优“每克成本”随迭代持续下降。_

## Limitations

## 局限性

These results were demonstrated on one protein, sfGFP, and one cell-free protein synthesis (CFPS) system. Generalization to other proteins and other CFPS systems still needs to be shown.

上述结果仅在一种蛋白（sfGFP）和一种无细胞蛋白合成（CFPS）系统上得到验证。其向其他蛋白及不同CFPS系统的普适性仍有待进一步证实。

Oxygenation and reaction geometry can strongly affect yields, and these factors can vary across scales. Some improvements may be sensitive to these conditions, and understanding those sensitivities is part of what comes next.

供氧条件与反应器几何构型会显著影响蛋白产量，且这些因素随反应规模变化而改变。部分优化效果可能对上述条件高度敏感；厘清这些敏感性，正是下一阶段工作的重点之一。

Human oversight was required for protocol improvements and reagent handling. The system can design and interpret experiments, but laboratory work still involves practical details that need experienced operators.

实验方案优化与试剂操作仍需人工监督。该系统虽能自主设计并解读实验，但实际实验室操作仍涉及诸多实操细节，必须依赖经验丰富的技术人员完成。

## What’s next

## 下一步工作

We plan to apply lab-in-the-loop optimization to other biological workflows where faster iteration can unlock progress. We see autonomous labs as complementary to models. Models can generate designs, but ultimately biology still requires testing and iteration. Closing the loop between generation and experimentation is how you turn promising ideas into working results.

我们计划将“闭环实验室”（lab-in-the-loop）优化范式拓展至其他生物流程——在这些领域中，更快的迭代速度有望推动实质性进展。我们认为，自主实验室并非替代模型，而是与其互为补充：模型擅长生成设计方案，但生物学终归离不开实验验证与反复迭代；唯有打通“设计生成”与“实验验证”之间的闭环，才能将富有潜力的构想真正转化为切实可行的成果。

As we work to accelerate scientific progress safely and responsibly, we also seek to evaluate and reduce risks, particularly those related to biosecurity.  

在致力于安全、负责任地加速科学进步的同时，我们也力求评估并降低各类风险，尤其是与生物安全相关的风险。

These results show that models can reason in the wet lab to improve protocols, and may have implications for biosecurity that we assess and mitigate through our [Preparedness Framework⁠](https://openai.com/index/updating-our-preparedness-framework/).  

这些结果表明，大模型能够在湿实验（wet lab）环境中进行推理，从而优化实验流程；其潜在的生物安全影响，我们正通过[《准备就绪框架》（Preparedness Framework）](https://openai.com/index/updating-our-preparedness-framework/)开展评估与缓解。

We are committed to building⁠ necessary and nuanced safeguards at a model and system level to reduce these risks, as well as develop evaluations to track current levels.  

我们承诺在模型与系统层面构建必要且细致周全的安全防护机制，以降低相关风险；同时开发评估方法，持续追踪当前风险水平。

We’re grateful to our partners at Ginkgo Bioworks and the teams who helped design, run, and support the automated cloud laboratory behind this work.  

衷心感谢我们的合作伙伴——Ginkgo Bioworks，以及参与本项目背后自动化云实验室的设计、运行与支持工作的各支团队。

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)

- [GPT](https://openai.com/news/?tags=gpt)  
- [GPT](https://openai.com/news/?tags=gpt)

- [Science](https://openai.com/news/?tags=science)  
- [科学](https://openai.com/news/?tags=science)
&#123;% endraw %}
