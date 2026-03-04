---
title: "Evaluating feature steering: A case study in mitigating social biases \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/evaluating-feature-steering"
date: "2024-12-19"
scraped_at: "2026-03-03T07:03:50.396203033+00:00"
language: "en-zh"
translated: true
description: "A new piece of Anthropic research by Durmus et al.: \"Evaluating feature steering: A case study in mitigating social biases\""
---
{% raw %}

Societal Impacts  
社会影响  

Interpretability  
可解释性  

# Evaluating feature steering: A case study in mitigating social biases  

# 评估特征引导：一项缓解社会偏见的案例研究  

Oct 25, 2024  
2024年10月25日  

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.  

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建了“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。  

A few months ago, we published an interpretability [paper](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html) demonstrating our ability to learn [interpretable features](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#assessing-interp) that correspond to various concepts (e.g., [famous individuals](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#feature-survey-categories-people), types of [computer code](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#feature-survey-categories-code), etc.) represented in [Claude 3 Sonnet](https://www.anthropic.com/news/claude-3-family). To verify our feature interpretations, we ran qualitative [feature steering](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#assessing-tour-influence) experiments, where we artificially dialed up and down various features to see if they changed model outputs in intuitive ways. The results were promising – for example, turning up a feature that responded to mentions of the Golden Gate Bridge made the model talk about the Golden Gate Bridge. Such examples led us to hypothesize that feature steering might be a promising way to modify model outputs in specific interpretable ways.  

几个月前，我们发表了一篇关于**可解释性**的[论文](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html)，展示了我们学习[可解释特征](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#assessing-interp)的能力——这些特征对应于模型内部表征的各类概念（例如：[知名人物](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#feature-survey-categories-people)、各类[计算机代码](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#feature-survey-categories-code)等），而这些概念均存在于 [Claude 3 Sonnet](https://www.anthropic.com/news/claude-3-family) 中。为验证我们对这些特征的解释是否合理，我们开展了定性的[特征引导](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#assessing-tour-influence)实验：人为增强或抑制特定特征的激活强度，观察模型输出是否以符合直觉的方式发生变化。实验结果令人鼓舞——例如，增强一个对“金门大桥”提及高度响应的特征后，模型确实更倾向于谈论金门大桥。此类实例促使我们提出假设：特征引导可能是一种有前景的方法，可用于以特定且可解释的方式调控模型输出。  

Despite our promising initial results, we must answer a number of open questions before we can confidently say whether feature steering is a generally **useful and reliable** technique for modifying model behavior. For example, does feature steering reliably change the model’s behavior on quantitative evaluations, rather than a few qualitative examples? Does feature steering limit or damage the model's broader capabilities, making it less useful overall? Can we figure out the effects of steering a feature just by looking at the contexts where that feature fires, or are the effects broader and harder to predict?  

尽管初步结果令人鼓舞，但在我们能确信特征引导是否是一种普遍**有效且可靠**的模型行为调控技术之前，仍需回答一系列尚未解决的问题。例如：特征引导能否在定量评估中稳定地改变模型行为，而不仅限于少数定性示例？该技术是否会限制或损害模型更广泛的通用能力，从而整体上削弱其可用性？我们能否仅通过观察某特征被激活的具体上下文，就准确推断出对该特征进行引导所产生的影响；抑或其影响范围更广、更难预测？  

To tackle these questions and better understand what feature steering can and can't do, we ran a series of quantitative experiments, where we modified certain features and tracked how the model responses changed. In a nutshell we:  

为深入探究上述问题，并更全面地理解特征引导的能力边界，我们开展了一系列定量实验：通过调控特定特征，系统追踪模型响应的变化。简言之，我们：

1. 聚焦于 29 个[与社会偏见相关的特征](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#safety-relevant-bias)，以更深入地理解特征引导（feature steering）在缓解模型中社会偏见方面的潜在效用。  
1. 聚焦于 29 个[与社会偏见相关的特征](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#safety-relevant-bias)，以更深入地理解特征引导（feature steering）在缓解模型中社会偏见方面的潜在效用。

2. 在全部 29 个特征上，对经特征引导的模型开展了两项社会[偏见](https://arxiv.org/abs/2302.07459)[评估](https://arxiv.org/abs/2212.09251)（覆盖 11 类社会偏见）及两项能力评估。  
2. 在全部 29 个特征上，对经特征引导的模型开展了两项社会[偏见](https://arxiv.org/abs/2302.07459)[评估](https://arxiv.org/abs/2212.09251)（覆盖 11 类社会偏见）及两项能力评估。

通过将所有评估指标与全部特征进行交叉测试，我们得以衡量每个特征对模型行为调控的**针对性**与**有效性**，并判断：借助特征引导降低偏见是否必然以牺牲模型能力为代价。  
通过将所有评估指标与全部特征进行交叉测试，我们得以衡量每个特征对模型行为调控的**针对性**与**有效性**，并判断：借助特征引导降低偏见是否必然以牺牲模型能力为代价。

我们的结果呈现混合性（mixed）。具体发现如下：  
我们的结果呈现混合性（mixed）。具体发现如下：

1. 在某一特定范围内（即特征引导的**“甜蜜点”**（sweet spot）），我们可成功引导模型，同时不损害其他模型能力；但一旦超出该范围，特征引导反而可能导致模型能力**下降**——有时甚至严重到使模型无法正常使用（图 1）。  
1. 在某一特定范围内（即特征引导的**“甜蜜点”**（sweet spot）），我们可成功引导模型，同时不损害其他模型能力；但一旦超出该范围，特征引导反而可能导致模型能力**下降**——有时甚至严重到使模型无法正常使用（图 1）。

2. 特征引导可在**目标领域内影响模型评估结果**。例如，提升一个在性别偏见讨论中被显著激活的特征值，会导致性别认同偏见得分上升（图 2，左）。  
2. 特征引导可在**目标领域内影响模型评估结果**。例如，提升一个在性别偏见讨论中被显著激活的特征值，会导致性别认同偏见得分上升（图 2，左）。

3. 我们发现一些证据表明：**仅凭特征被激活的上下文，往往不足以准确预测其实际效应**。例如，我们认为可能与性别偏见相关的某些特征，**同时也显著影响年龄偏见**；我们将此类跨维度的非预期效应统称为**脱靶效应**（off-target effects）（图 2，右）。  
3. 我们发现一些证据表明：**仅凭特征被激活的上下文，往往不足以准确预测其实际效应**。例如，我们认为可能与性别偏见相关的某些特征，**同时也显著影响年龄偏见**；我们将此类跨维度的非预期效应统称为**脱靶效应**（off-target effects）（图 2，右）。

4. 值得乐观的是，我们还发现了一个**中立性特征**（neutrality feature）：它能在九个社会维度上显著降低社会偏见，且**并未明显削弱**我们在实验中所测试的各项模型能力（图 5）。  
4. 值得乐观的是，我们还发现了一个**中立性特征**（neutrality feature）：它能在九个社会维度上显著降低社会偏见，且**并未明显削弱**我们在实验中所测试的各项模型能力（图 5）。

我们希望，公开分享这些初步的、结论尚不统一（mixed）的研究发现，能成为深入理解特征引导如何助力生成更安全模型输出的重要一步。本文末尾附有详尽的**局限性分析、经验总结与未来研究方向建议**。更多补充实验与技术细节则收录于附录中，并在正文各处以交叉引用方式予以提示，供感兴趣的读者查阅。  
我们希望，公开分享这些初步的、结论尚不统一（mixed）的研究发现，能成为深入理解特征引导如何助力生成更安全模型输出的重要一步。本文末尾附有详尽的**局限性分析、经验总结与未来研究方向建议**。更多补充实验与技术细节则收录于附录中，并在正文各处以交叉引用方式予以提示，供感兴趣的读者查阅。

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_001.jpg)_图 1。我们识别出特征引导的“甜蜜点”（横轴：引导因子，取值范围为 -5 至 5），在此区间内特征引导不会显著影响模型能力（纵轴：以 MMLU 准确率作为模型能力的代理指标）。令人惊讶的是，这一“甜蜜点”在全部 29 个被测特征（彩色曲线，图例中含各特征简要说明）中均普遍存在。_  
![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_001.jpg)_图 1。我们识别出特征引导的“甜蜜点”（横轴：引导因子，取值范围为 -5 至 5），在此区间内特征引导不会显著影响模型能力（纵轴：以 MMLU 准确率作为模型能力的代理指标）。令人惊讶的是，这一“甜蜜点”在全部 29 个被测特征（彩色曲线，图例中含各特征简要说明）中均普遍存在。_

## Methods  
## 方法  

### How we picked features and implemented feature steering  
### 特征筛选与特征引导的实现方法  

We analyzed features related to social biases and political ideologies from the [initial set](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#appendix-more-safety-features) we learned from Claude 3 Sonnet. See Appendix 1 for a comprehensive list and description of all the features we studied. Precise details on how we implement feature steering can be found in our [original paper](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#appendix-methods-steering).  
我们从 Claude 3 Sonnet 模型中学习得到的[初始特征集](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#appendix-more-safety-features)中，筛选并分析了与社会偏见及政治意识形态相关的特征。附录 1 提供了本研究所涉全部特征的完整列表与详细说明。关于特征引导的具体实现方法，请参阅我们的[原始论文](https://transformer-circuits.pub/2024/scaling-monosemanticity/index.html#appendix-methods-steering)。

Briefly, feature steering works as follows. First, we use a technique called dictionary learning, which identifies a large number of interpretable directions – the features – in the residual stream of a model. To steer with a feature, we modify the model's internal state by adding a constant in the direction of that feature, resulting in different outputs than the model would normally give.  
简言之，特征引导的工作机制如下：首先，我们采用一种名为**字典学习**（dictionary learning）的技术，在模型的残差流（residual stream）中识别出大量具有可解释性的方向——即“特征”。在实施特征引导时，我们沿某一特征方向向模型内部状态添加一个常量偏移，从而使其输出偏离原本的自然响应。

### How we picked and implemented evaluations

### 我们如何选择并实施评估

To measure the impact of various features on model capabilities, we relied on two common benchmarks: [MMLU](https://arxiv.org/pdf/2009.03300) and [PubMedQA](https://arxiv.org/pdf/1909.06146). These evaluations test models for knowledge across a range of domains and are frequently used in our [model cards](https://www-cdn.anthropic.com/f2986af8d052f26236f6251da62d16172cfabd6e/claude-3-model-card.pdf) to assess capabilities. By using these benchmarks, we can study whether feature steering affects the model's overall performance on general knowledge tasks.

为衡量各类特征对模型能力的影响，我们依赖两个常用基准测试：[MMLU](https://arxiv.org/pdf/2009.03300) 和 [PubMedQA](https://arxiv.org/pdf/1909.06146)。这些评估覆盖多个知识领域，常被用于我们的 [模型卡片（model cards）](https://www-cdn.anthropic.com/f2986af8d052f26236f6251da62d16172cfabd6e/claude-3-model-card.pdf) 中以评估模型能力。借助这些基准，我们可研究特征引导（feature steering）是否会影响模型在通用知识任务上的整体表现。

For social bias evaluations, we used the [BBQ (Bias Benchmark for QA) dataset](https://arxiv.org/pdf/2110.08193v2), which assesses nine forms of social biases and is commonly used in our model cards. We also used a subset of the [model-written evals dataset](https://huggingface.co/datasets/Anthropic/model-written-evals) targeted to our list of features. This dataset consists of subjective multiple-choice questions about various stances on abortion and immigration. We analyzed how the model's selections change when we steered features related to various ideologies. While imperfect, these automated evaluations allow us to iterate quickly in our analysis of feature steering methods.

针对社会偏见评估，我们采用了 [BBQ（问答任务偏见基准，Bias Benchmark for QA）数据集](https://arxiv.org/pdf/2110.08193v2)，该数据集涵盖九类社会偏见，亦常用于我们的模型卡片中。此外，我们还使用了 [模型自撰评估数据集（model-written evals dataset）](https://huggingface.co/datasets/Anthropic/model-written-evals) 的一个子集，该子集专门针对我们所列的特征进行了筛选。该数据集包含关于堕胎与移民议题上不同立场的主观型多项选择题。我们分析了当引导与各类意识形态相关的特征时，模型选择结果的变化情况。尽管这些自动化评估并不完美，但它们使我们得以快速迭代、深入分析特征引导方法。

For all our multiple-choice evaluations, we estimated accuracy by sampling. Specifically, we generated 10 samples from the model for each question and computed probabilities based on these samples. This approach introduces some noise in our results, which is why we see some fluctuations in our plots, especially around a steering factor of 0. To combat this noise, we could have increased the sample size; however, this would have been computationally prohibitive (we return to this in our Limitations section).

对于所有多项选择题评估，我们采用抽样法估算准确率：即对每个问题，从模型生成 10 个样本，并基于这些样本计算概率。该方法会为结果引入一定噪声，因此我们在图表中观察到部分波动，尤其在引导因子（steering factor）为 0 附近尤为明显。为抑制此类噪声，本可进一步增大样本量；但受限于算力，该方案并不可行（我们将在“局限性”章节中再次讨论此问题）。

## Results

## 结果

### Finding the feature steering sweet spot

### 寻找特征引导的“最佳区间”

_Takeaway: We found a "steering sweet spot" for steering factors where steering doesn't impact model capabilities. Surprisingly the same sweet spot (-5,5) holds across all features we tested. Outside of that sweet spot model capabilities degrade significantly._

_核心结论：我们发现了引导因子的“最佳区间”，在此区间内进行特征引导不会损害模型能力。令人惊讶的是，这一最佳区间（-5, 5）在所有经测试的特征上均保持一致；而一旦超出该区间，模型能力便显著下降。_

We ran capabilities evaluations to determine the useful range of possible steering factors. We wanted a range where feature steering can influence model outputs without significantly damaging capabilities, since otherwise we would be evaluating a system that is no longer practically useful. For all evaluations, we varied the 'steering factor' between -20 and 20. This decision was arbitrary.

我们开展能力评估，旨在确定引导因子的有效取值范围：即在该范围内，特征引导既能影响模型输出，又不会显著削弱其能力——否则，我们所评估的将是一个已丧失实际应用价值的系统。在全部评估中，我们将“引导因子”在 -20 至 20 之间变动；该取值范围的选择具有任意性。

Figure 1 illustrates the impact of feature steering on MMLU accuracy across 29 features and nine different steering factors. The accuracy is highest between steering factors -5 and 5, with a steeper decline at more extreme values. We see similar results for PubMedQA (Figure A1). This suggests a sweet spot for steering where we can steer the model with relatively less impact on its general utility. Beyond this range, accuracy drops sharply, suggesting that excessive steering may compromise the model’s general knowledge and reasoning abilities. We found similar effects qualitatively when we looked at the model generations for various steering factors (Table A1).

图 1 展示了特征引导对 MMLU 准确率的影响，横跨 29 个特征及九种不同引导因子。准确率在引导因子 -5 至 5 区间内达到最高，而在更极端的取值下则急剧下降。PubMedQA 的评估结果也呈现类似趋势（图 A1）。这表明存在一个特征引导的“最佳区间”：在此区间内，我们可在对模型通用实用性影响相对较小的前提下实现有效引导。一旦超出该区间，准确率便骤降，暗示过度引导可能损害模型的通用知识储备与推理能力。当我们定性分析不同引导因子下模型生成内容时，也观察到了类似效应（表 A1）。

### Measuring social biases with BBQ

### 借助 BBQ 衡量社会偏见

_Takeaway: Feature steering can influence specific social biases, but it may also produce unexpected ‘off-target effects’, as seen with the "Gender bias awareness" feature's impact on both gender and age bias scores in the BBQ social bias evaluation._

_要点：特征引导（feature steering）可影响特定的社会偏见，但也可能产生意外的“脱靶效应”（off-target effects）——例如，“性别偏见意识”（Gender bias awareness）特征在 BBQ 社会偏见评估中，不仅影响性别偏见得分，还同时影响年龄偏见得分。_

Our analysis on the BBQ dataset focused on two key aspects within the “sweet spot’ of steering factors (-5 to 5) across all features:

我们在 BBQ 数据集上的分析聚焦于所有特征的引导因子“最佳区间”（-5 至 5）内的两个核心方面：

1. Whether feature steering increases or decreases various forms of social biases in specific and intuitive ways.  
   1. 特征引导是否以具体且符合直觉的方式，增加或减少各类社会偏见；

2. Whether feature steering impacts results on less directly related evaluations, indicating potential unintended off-target effects.  
   2. 特征引导是否会影响与该特征关联较弱的其他评测任务的结果，从而揭示潜在的、非预期的脱靶效应。

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_002.jpg)_Figure 2. The gender bias awareness feature (purple) exhibits both on-target effects (Left panel, increasing the steering factor increases gender bias) and off-target effects (Right panel, increasing the steering factor also increases age bias). We measure the bias scores (y-axes) using the [BBQ benchmark](https://arxiv.org/pdf/2110.08193). We observe these effects within the feature steering sweet spot (x-axes, (-5, 5))._

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_002.jpg)_图 2。“性别偏见意识”特征（紫色）同时表现出靶向效应（左图：引导因子增大导致性别偏见得分上升）和脱靶效应（右图：引导因子增大也导致年龄偏见得分上升）。我们采用 [BBQ 基准测试](https://arxiv.org/pdf/2110.08193) 计算各项偏见得分（纵轴）。这些效应均出现在特征引导的最佳区间内（横轴：-5 至 5）。_

We found that feature steering can indeed decrease or increase various forms of social biases related to specific features. For instance, positively steering the "Multiple perspectives and balance" feature by steering factor 5 reduces the overall BBQ bias score by ~3% (Figure A2) and significantly decreases several category-specific biases (Figure A3). Comparing steering factors 0 vs. 5, we observe decreases across many of these categories, such as Age bias (17%) and Disability Status bias (7%).

我们发现，特征引导确实能够降低或升高与特定特征相关联的各类社会偏见。例如，将“多视角与平衡性”（Multiple perspectives and balance）特征以引导因子 +5 进行正向引导，可使 BBQ 总体偏见得分下降约 3%（图 A2），并显著降低多个细粒度类别的偏见得分（图 A3）。对比引导因子为 0 与 5 的情形，我们在多个类别中均观察到下降趋势，例如年龄偏见（降幅 17%）和残障状况偏见（降幅 7%）。

On the other hand, as shown in Figure 1 (Left), steering the "Gender bias awareness" feature that fires on discussions of gender bias has the opposite effect on gender bias scores, which increase by 10% as the steering factor increases from -5 to 5. This may result from the model overly emphasizing gender-related biases in its responses when positively steered, leading our evaluation metrics to interpret these outputs as more biased. Additionally, it is important to note that the feature labels may not be entirely accurate. As discussed in our previous paper, we used automated methods to label these features, which capture the topics of text samples where specific features are active, but do not necessarily indicate the directionality of a given feature. For instance, features labeled as related to discrimination or bias may indeed affect discrimination-related outputs, but not necessarily increase (or decrease) discrimination or bias in predictable ways.

另一方面，如图 1（左图）所示，对在涉及性别偏见讨论中被激活的“性别偏见意识”特征进行引导，反而导致性别偏见得分呈现相反的变化趋势：当引导因子从 -5 增至 5 时，性别偏见得分上升了 10%。这可能是由于模型在正向引导下过度强调回应中的性别相关偏见，致使我们的评测指标将其输出判定为更具偏见性。此外需特别指出：这些特征的标签未必完全准确。正如我们在先前论文中所讨论的，我们采用自动化方法为特征打标——该方法仅能捕捉特定特征活跃时对应文本样本的主题，却无法反映该特征本身对偏见方向（增强或削弱）的影响。例如，被标注为“与歧视或偏见相关”的特征，确实可能影响涉及歧视的输出内容，但未必以可预测的方式增强（或减弱）歧视或偏见程度。

We also discovered unexpected off-target effects when steering certain features. For example, the "Gender bias awareness" feature showed a significant effect on age bias scores (increasing by 13%), even though age bias is not necessarily directly related to gender awareness (Figure 1, Right), and the "Gender bias awareness" feature doesn't necessarily fire in age bias-related contexts. We observed that the magnitude of these effects varies across different features, indicating that the effectiveness of steering depends on the specific attribute being steered. The results for all features are in Appendices 3.2 and 3.3.

我们还发现，对某些特征进行引导时会出现意料之外的脱靶效应。例如，“性别偏见意识”特征显著影响了年龄偏见得分（增幅达 13%），尽管年龄偏见与性别意识之间并无必然的直接关联（图 1，右图），且该特征本身也未必会在涉及年龄偏见的语境中被激活。我们观察到，不同特征引发的此类效应强度各异，表明引导效果高度依赖于被引导的具体属性。所有特征的完整结果详见附录 3.2 和 3.3。

### Measuring political biases

### 政治偏见的测量

_Takeaway: Feature steering significantly influences model selections on political topics but also has unexpected off-target effects._

_要点：特征引导显著影响模型在政治议题上的选择倾向，但也带来意外的脱靶效应。_

Within the (-5, 5) range of steering factors, we analyzed how steering features related to various ideologies affects the model's selections on political topics using the [model-written evals dataset](https://huggingface.co/datasets/Anthropic/model-written-evals).

在引导因子区间（-5 至 5）内，我们借助 [模型自撰评测数据集（model-written evals dataset）](https://huggingface.co/datasets/Anthropic/model-written-evals)，分析了与各类意识形态相关的特征引导，如何影响模型在政治议题上的选择行为。

We found that steering the “Pro-life and anti-abortion stance” feature (dark blue) significantly increased anti-abortion selections (by 50%) (Figure 3). Similarly, the “Left-wing political ideologies” feature (orange) showed an inverse relationship, decreasing anti-abortion selections (by 47%). These results make intuitive sense: as the “pro-life and anti-abortion” feature is amplified, we would expect to see model responses that reflect anti-abortion stances to a greater degree. Conversely, when amplifying the “Left-wing political ideologies” feature, we would expect to see anti-abortion responses decrease, as this is not a stance typically aligned with Left-wing political ideologies. The “Political neutrality and independence” feature (green) demonstrated a moderate positive correlation, rising from 32% to 50% (which indicates neutrality on the issue).

我们发现，增强“支持生命且反对堕胎立场”特征（深蓝色）显著提升了模型选择反堕胎回应的比例（增幅达50%）（图3）。类似地，“左翼政治意识形态”特征（橙色）则呈现相反关系，使反堕胎选择比例下降了47%。这些结果符合直觉：当“支持生命且反对堕胎”特征被强化时，我们自然预期模型输出中体现反堕胎立场的回应会相应增多；反之，当强化“左翼政治意识形态”特征时，反堕胎回应比例应下降，因为该立场通常并不与左翼政治意识形态相一致。“政治中立与独立”特征（绿色）则表现出中等程度的正相关性，其对应的选择比例从32%上升至50%（表明模型在该议题上趋于中立）。

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_003.jpg)_Figure 3. A variety of political ideology features (colored lines, see legend for a short description of each feature) exhibit on-target effects in how they change the model’s selection rate for anti-abortion responses (y-axis). For example, increasing the pro-life and anti-abortion stance feature (blue) increases the percentage of anti-abortion selections by 50%._

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_003.jpg)_图3：多种政治意识形态特征（以不同颜色线条表示；图例中简要说明各特征含义）对模型反堕胎回应选择率（y轴）产生了符合预期的定向调控效果。例如，增强“支持生命且反对堕胎立场”特征（蓝色）可使反堕胎选择比例提升50%。_

Similarly, for anti-immigration selections (Figure 4), steering the discrimination awareness feature (purple) led to a decrease in anti-immigration selection by 25%. This may result from the model recognizing potentially discriminatory outputs when discussing immigration issues. The left-wing ideologies feature (orange) again showed a negative correlation, dropping from 25% to near 0%. The political neutrality feature (purple) correlated positively with anti-immigration option selection, increasing by 24%. Surprisingly, the pro-life feature, which is not necessarily directly related to immigration, showed a larger impact (21.60% increase) than the immigration-specific feature (3.90% change) as the steering factor increased from -5.0 to 5.0. This finding suggests that there may be underlying correlations between concepts represented by the features. Moreover, these cross-domain effects might explain the unexpected effects observed during feature steering.

同样，在反移民回应选择方面（图4），调控“歧视意识”特征（紫色）使反移民选择比例下降了25%。这可能源于模型在讨论移民议题时识别出潜在的歧视性输出。“左翼意识形态”特征（橙色）再次呈现负相关性，其选择比例从25%降至接近0%。“政治中立”特征（此处原文为purple，但结合上下文及图4图例应为绿色或灰色；译文依实际图示逻辑处理为“政治中立”特征）则与反移民选项选择呈正相关，比例上升了24%。令人意外的是，“支持生命”特征——该特征本不必然直接关联移民议题——在调控因子从-5.0增至5.0的过程中，其影响（+21.60%）反而超过了专用于移民议题的特征（+3.90%）。这一发现提示：不同特征所表征的概念之间可能存在潜在关联。此外，此类跨领域效应或许正是特征调控过程中出现意外效果的原因所在。

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_004.jpg)_Figure 4. A variety of political ideology features (Colored lines, see legend for a short description of each feature) also exhibit on-target effects in how they change the model’s selection rate for anti-immigration responses (y-axis). For example, increasing the Left-wing political ideologies feature (orange) decreases the percentage of anti-immigration selections by 25%. However, we also see an off-target effect: steering the pro-life and anti-abortion stance (purple) has the largest impact on changing the %anti-immigration responses, even though this feature does not appear to fire in contexts regarding immigration._

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_004.jpg)_图4：多种政治意识形态特征（以不同颜色线条表示；图例中简要说明各特征含义）同样在模型反移民回应选择率（y轴）上展现出符合预期的定向调控效果。例如，增强“左翼政治意识形态”特征（橙色）可使反移民选择比例下降25%。然而，我们也观察到一种非目标效应（off-target effect）：调控“支持生命且反对堕胎立场”特征（紫色）对反移民回应比例的影响最为显著，尽管该特征在涉及移民议题的语境中似乎并未被显著激活。_

These results suggest that in some cases, feature steering may impact model choices in a way that aligns with expected associations (e.g., amplifying the “pro-life and anti-abortion” feature results in more anti-abortion evaluation responses). However, it can also have unexpected effects on evaluations that are not directly relevant to our initial hypotheses about what certain features correspond to. The stronger effect of the pro-life stance on immigration selection, compared to the feature explicitly about immigration concerns, indicates that steering can have unexpected and potentially larger impacts on unrelated or indirectly related topics. Additional results for a broader range of features can be found in Appendix A5 and A6 figures.

上述结果表明：在某些情况下，特征调控确实能以符合预期的方式影响模型决策（例如，增强“支持生命且反对堕胎”特征会导致更多反堕胎评估回应）；但与此同时，它也可能对那些与我们最初关于特定特征语义假设并无直接关联的评估任务产生意外影响。“支持生命”立场对移民议题选择产生的更强效应，甚至超过专用于移民议题的特征本身，说明特征调控可能对无关或仅间接相关的主题带来意外且潜在更大的影响。更广泛范围内其他特征的调控结果详见附录A5和A6中的图表。

### The “Neutrality” and “Multiple Perspectives” features

### “中立性”与“多元视角”特征

Through the course of our research, we found a promising result that deserves further attention. Figure 5 shows that positively steering the “Neutrality and Impartiality” and “Multiple Perspectives” features tends to consistently _reduce_ bias scores across all nine dimensions on the BBQ benchmark within the feature steering sweet spot. The effect was particularly pronounced for certain categories. For example, bias scores for Age, Disability Status and Physical Appearance showed the most dramatic reduction as the steering factor increased. However, steering the "Neutrality and Impartiality" feature may result in a slight decrease in BBQ accuracy, while the "Multiple Perspectives" feature maintains accuracy across the steering range (Figure A4).

在本研究过程中，我们发现了一个颇具前景的结果，值得进一步关注。图5显示，在特征调控的“最佳区间”（sweet spot）内，正向调控“中立性与公正性”及“多元视角”这两个特征，能够持续、稳定地降低BBQ基准测试全部九个维度上的偏见得分。该效应在某些类别中尤为显著：例如，随着调控因子增大，“年龄”“残障状况”和“外貌”三类的偏见得分下降幅度最为明显。然而，调控“中立性与公正性”特征可能导致BBQ准确率轻微下降；而“多元视角”特征则在整个调控范围内均能保持准确率不变（图A4）。

Our results suggest that feature steering may be an effective way to mitigate some forms of social biases without significantly impacting model capabilities. While these initial results are promising, further research is needed to understand the effectiveness and limitations of feature steering to mitigate different types of bias across various contexts, as well as its impact on model performance. We discuss some paths forward in the next section.

我们的结果表明，特征调控可能是一种在基本不损害模型能力的前提下缓解某些社会偏见的有效方法。尽管这些初步结果令人鼓舞，但仍需开展进一步研究，以深入理解特征调控在不同语境下缓解各类偏见的有效性与局限性，并系统评估其对模型整体性能的影响。我们将在下一节中探讨若干后续研究方向。

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_005.jpg)_Figure 5. Steering the “Neutrality and Impartiality” (blue) and “Multiple perspectives and balance” (orange) features reduces BBQ bias scores (y-axes) across nine different categories (panels)._

![](images/evaluating-feature-steering-a-case-study-in-mitigating-social-biases-anthropic/img_005.jpg)_图5：“中立性与公正性”（蓝色）与“多元视角及平衡性”（橙色）特征的调控，可在BBQ基准测试的九大不同类别（各子图面板）中全面降低偏见得分（y轴）。_

## Limitations

## 局限性

1. _Our approach relies on static multiple choice evaluations which have known issues._  
1. _我们的方法依赖于静态多项选择题评估，而这类评估本身存在已知问题。_  
Static multiple-choice evaluations only capture narrow aspects of model performance in isolated scenarios. An alternative method, such as computing Elo scores (via human judgements) with feature-steered models, could provide a more comprehensive evaluation of our models' helpfulness, harmlessness, or other attributes, across diverse scenarios.  
静态多项选择题评估仅能捕捉模型在孤立场景下性能的狭窄侧面。一种替代方法——例如，借助特征引导（feature-steered）模型，通过人工判断计算 Elo 分数——或可在多样化场景中，对模型的有用性、无害性及其他属性提供更全面的评估。

2. _Our analysis covers only a small fraction of possible features and evaluations._  
2. _我们的分析仅覆盖了全部可能特征与评估指标中极小的一部分。_  
Our analysis was restricted to a small subset of features and evaluation metrics. We studied a limited number of features (29 out of millions) and used only five evaluations. We had to restrict our study for tractability, but this limitation constrains our ability to generalize our findings to the vast majority of features we did not examine. Expanding our analysis to a broader set of features and evaluations (perhaps through automated methods) could provide a more comprehensive understanding of feature steering's effects across different domains and tasks.  
我们的分析被限定于一小部分特征和评估指标：仅研究了有限数量的特征（29 个，而总特征数达数百万），且仅使用了五种评估方法。受限于可操作性，我们不得不缩小研究范围；但这一限制削弱了我们将结论泛化至绝大多数未考察特征的能力。若将分析扩展至更广泛的特征集与评估方法（例如借助自动化手段），或将有助于更全面地理解特征引导在不同领域与任务中的影响。

3. _Our accuracy estimation method is noisy._  
3. _我们的准确率估计方法存在噪声。_  
We computed accuracy for multiple-choice evaluations by sampling 10 responses per question and calculating probabilities. This method introduces noise in our results. While we could decrease noise by increasing the number of samples, this would make evaluations computationally untenable without significant engineering effort. A more precise approach would be to obtain log probabilities directly from the model for each answer choice, but this would have also required significant engineering effort. This limitation impacts our ability to detect subtle effects of feature steering and reduces the overall precision of our results.  
我们通过为每道多项选择题采样 10 个响应并据此计算概率，来估算准确率。该方法为结果引入了噪声。尽管可通过增加采样数量来降低噪声，但若无大量工程投入，这将使评估在计算上变得不可行。一种更精确的方法是直接从模型获取每个选项对应的对数概率（log probabilities），但该方案同样需要大量工程工作。这一局限性削弱了我们检测特征引导细微效应的能力，并降低了整体结果的精度。

## Lessons learned  
## 经验总结  

1. _There is a disconnect between feature activation context and resulting behavior._  
1. _特征激活上下文与其引发的行为之间存在脱节。_  
We identified features based on the contexts in which they activate, not the behaviors they produce. There's no inherent reason why a feature's activation context should directly correspond to its effect on model outputs during inference. Consequently, feature steering does not always lead to predictable changes in model outputs in relevant evaluations. This discrepancy highlights the complex relationship between feature activation and output generation. Our method aims to disentangle this relationship by empirically testing how these features influence model outputs in practice.  
我们依据特征被激活的上下文（context）识别特征，而非其产生的行为（behavior）。特征的激活上下文本无内在理由必须直接对应其在推理过程中对模型输出的影响。因此，特征引导并不总能在相关评估中带来可预测的模型输出变化。这种不一致凸显了特征激活与输出生成之间关系的复杂性。我们的方法旨在通过实证方式检验这些特征在实践中如何影响模型输出，从而厘清这一关系。

2. _Feature steering may not yet be a reliable way to achieve targeted changes in model outputs._  
2. _特征引导目前尚不足以成为实现模型输出定向调控的可靠手段。_  
Feature steering may lead to unpredictable changes across model outputs. Our experiments show that feature steering can influence model outputs in complex and often unexpected ways. When we steer a single feature, we sometimes observe unpredictable changes in model selections across various domains, including those not directly related to the steered feature. Furthermore, we see that steering can compromise the model's response quality and relevance at extreme steering values.  
特征引导可能导致模型输出发生不可预测的变化。我们的实验表明，特征引导对模型输出的影响具有高度复杂性，且常出人意料。当我们仅引导单个特征时，有时会在多个领域（包括与所引导特征无直接关联的领域）观察到模型选择的不可预测变化。此外，在极端引导强度下，我们发现引导过程会损害模型响应的质量与相关性。

## Future work  
## 未来工作方向  

1. _We did not explore the effect of scaling the SAE._  
1. _我们尚未探究稀疏自编码器（SAE）规模缩放的影响。_  
We haven't investigated how feature sensitivity and [specificity](https://transformer-circuits.pub/2024/july-update/index.html#feature-sensitivity) scale with the size of the sparse autoencoder (SAE) that we use to learn the features. Our current results are derived from a 34M parameter SAE, but scaling up the SAE could potentially (and intuitively) result in more sensitive on-target features and less diffuse off-target features.  
我们尚未研究特征敏感性（sensitivity）与[特异性（specificity）](https://transformer-circuits.pub/2024/july-update/index.html#feature-sensitivity)如何随用于学习特征的稀疏自编码器（SAE）规模变化。当前结果基于一个含 3400 万参数的 SAE；但直观而言，扩大 SAE 规模有望提升目标特征的敏感性，并降低非目标特征的弥散性。

2. _Our implementation of feature steering affects the way the model processes both human input and assistant output._  
2. _我们当前的特征引导实现方式会影响模型对人类输入与助手输出的处理过程。_  
Our current algorithm applies steering to the entire prompt, including the human's question, not just the assistant's response. This may introduce unintended effects on how the model processes the input, potentially making our results less precise. A more precise method, such as steering only on the tokens in the model's response, could provide cleaner and less confounded results.  
我们当前的算法将引导作用施加于整个提示（prompt），即包含人类提问，而不仅限于助手的响应。这可能对模型处理输入的方式产生非预期影响，从而降低结果的精确性。一种更精确的方法是仅对模型响应中的 token 施加引导，由此可获得更干净、干扰更少的结果。

3. _Our comparison of feature steering to other techniques is limited._  
3. _我们将特征引导与其他技术进行对比的研究仍十分有限。_  
We haven't looked at how feature steering compares to other methods of influencing model outputs. For example, we didn't study [activation steering](https://arxiv.org/abs/2308.10248), which might offer unique advantages but requires hand-labeled examples of positive and negative reinforcement. Feature steering doesn't require such examples, but it does require significant computational resources for training the SAE and editing the residual stream during inference.  
我们尚未系统比较特征引导与其他影响模型输出方法的异同。例如，我们未研究[激活引导（activation steering）](https://arxiv.org/abs/2308.10248)——该方法虽具独特优势，却需人工标注的正向与负向强化样本。特征引导无需此类标注，但需耗费大量计算资源训练 SAE 并在推理阶段编辑残差流（residual stream）。

4. _We found some comparable effects between prompt engineering and feature steering._  
4. _我们在提示工程（prompt engineering）与特征引导之间发现了一些可比效应。_  
Our preliminary experiments (detailed in Appendix 4) studied the off-target effects of prompt engineering in influencing model responses on anti-immigration and anti-abortion topics. Surprisingly, we found that prompt engineering showed sensitivity and specificity profiles comparable to feature steering. However, these findings are based on limited experiments, and more comprehensive studies are necessary to confirm this finding.  
我们的初步实验（详见附录 4）考察了提示工程在影响模型对反移民与反堕胎话题响应时的“非目标效应”（off-target effects）。令人惊讶的是，提示工程展现出的敏感性与特异性分布模式，与特征引导颇为相似。然而，这些发现基于有限实验，尚需更全面的研究予以验证。

5. _Our findings may motivate the exploration of circuits._  
5. _我们的发现或可推动对“神经回路”（circuits）的探索。_  
Our steering experiments showed complex interactions and unexpected cross-domain effects, suggesting that individual features do not operate in isolation. To effectively steer model behavior, we may need to understand how features work together in circuits — interconnected groups of neurons that perform specific functions. Studying circuits could provide better insights into the inner workings of the model, potentially leading to more precise and effective steering techniques.  
我们的引导实验揭示了复杂的交互作用与意外的跨领域效应，表明单个特征并非独立运作。要有效引导模型行为，我们或许需理解特征如何在“神经回路”（circuits）中协同工作——即执行特定功能的、相互连接的神经元群组。对回路的研究有望深化我们对模型内部机制的理解，进而催生更精准、更有效的引导技术。

6. _We didn’t explore alternative steering methods._  
6. _我们尚未探索其他引导方法。_  
Our current additive steering approach may produce internal states that are extreme or "ungrammatical" from the model's perspective. Future work could explore multiplicative steering, which rescales already-active features by a multiplicative constant, projective steering, which zeros out a feature direction (affecting multiple correlated features and avoiding negative values), and conditional steering, in which one feature is modified only when another is active. These methods might offer more effective control of model outputs, especially when aiming to reduce certain features' influence while maintaining overall model capabilities.  
我们当前采用的加性引导（additive steering）方法，可能生成对模型而言过于极端或“不合语法”（ungrammatical）的内部状态。未来工作可探索乘性引导（multiplicative steering）——即以乘性常数对已激活特征进行重缩放；投影式引导（projective steering）——即归零某一特征方向（同时影响多个相关特征，且避免出现负值）；以及条件式引导（conditional steering）——即仅当另一特征处于活跃状态时才修改某特征。这些方法或能更有效地调控模型输出，尤其适用于在削弱某些特征影响的同时维持模型整体能力的场景。

## Conclusion  
## 结论  

Our evaluation of feature steering in Claude 3 Sonnet revealed both promising initial results as well as limitations of the technique. Encouragingly, our experiments revealed a “sweet spot” where feature steering can influence model outputs while not significantly degrading capabilities. We even found two features which significantly mitigated social biases across nine social dimensions (according to the BBQ benchmark) _without sacrificing_ model capabilities as much. However, we also discovered that a steering vector’s effects can be more complex than its activating contexts suggest, meaning that careful evaluations would be necessary before deploying feature steered models in practice. By sharing our preliminary findings, we hope to inspire further research on steering methods that could lead to safer and more reliable model outputs.  
我们对 Claude 3 Sonnet 中特征引导技术的评估，既揭示了令人鼓舞的初步成果，也暴露了该技术的固有局限。值得鼓舞的是，实验发现了一个“最佳区间”（sweet spot）：在此区间内，特征引导可有效影响模型输出，同时不会显著削弱模型能力。我们甚至发现了两个特征，它们在 BBQ 基准测试涵盖的九个社会维度上显著缓解了社会偏见，且对模型能力的折损相对较小。然而，我们也发现，引导向量（steering vector）的实际效应可能远比其激活上下文所暗示的更为复杂；这意味着，在实际部署经特征引导的模型前，必须开展审慎细致的评估。通过分享这些初步发现，我们期望能激发学界对引导方法的进一步研究，最终推动构建更安全、更可靠的模型输出。

## Bibtex  
## BibTeX 引用格式  

If you’d like to cite this post you can use the following Bibtex key:  
如需引用本文，请使用以下 BibTeX 条目：  

@online{durmus2024steering,

author = {Esin Durmus and Alex Tamkin and Jack Clark and Jerry Wei and Jonathan Marcus and Joshua Batson and Kunal Handa and Liane Lovitt and Meg Tong and Miles McCain and Oliver Rausch and Saffron Huang and Sam Bowman and Stuart Ritchie and Tom Henighan and Deep Ganguli},

作者 = {Esin Durmus、Alex Tamkin、Jack Clark、Jerry Wei、Jonathan Marcus、Joshua Batson、Kunal Handa、Liane Lovitt、Meg Tong、Miles McCain、Oliver Rausch、Saffron Huang、Sam Bowman、Stuart Ritchie、Tom Henighan、Deep Ganguli}，

title = {Evaluating Feature Steering: A Case Study in Mitigating Social Biases},

标题 = {评估特征引导：缓解社会偏见的案例研究}，

date = {2024-10-25},

日期 = {2024-10-25}，

year = {2024},

年份 = {2024}，

url = {https://anthropic.com/research/evaluating-feature-steering},

网址 = {https://anthropic.com/research/evaluating-feature-steering}，

}

## Acknowledgements

## 致谢

Esin Durmus and Deep Ganguli designed the experiments and wrote the blog post. Esin Durmus executed all the experiments, made the figures, and wrote the first drafts of the post. Jonathan Marcus and Oliver Rausch built the feature steering API we used for our experiments. We thank Jerry Wei and Meg Tong for sharing code that we adapted for our work here. We thank Alex Tamkin, Jack Clark, Joshua Batson, Kunal Handa, Liane Lovitt, Miles McCain, Saffron Huang, Sam Bowman, Stuart Ritchie, and Tom Henighan for their detailed feedback, technical advice, and writing suggestions.

Esin Durmus 与 Deep Ganguli 设计了实验并撰写了本篇博客文章。Esin Durmus 独立完成了全部实验，制作了所有图表，并撰写了文章初稿。Jonathan Marcus 与 Oliver Rausch 开发了我们在实验中所使用的特征引导（feature steering）API。我们感谢 Jerry Wei 与 Meg Tong 分享了可供我们在此项工作中适配使用的代码。我们还要感谢 Alex Tamkin、Jack Clark、Joshua Batson、Kunal Handa、Liane Lovitt、Miles McCain、Saffron Huang、Sam Bowman、Stuart Ritchie 和 Tom Henighan 提供的细致反馈、技术建议及写作指导。

## Appendices

## 附录

Appendices are available [at this link](https://assets.anthropic.com/m/6a464113e31f55d5/original/Appendix-to-Evaluating-Feature-Steering-A-Case-Study-in-Mitigating-Social-Biases.pdf). They include:

附录可通过[此链接](https://assets.anthropic.com/m/6a464113e31f55d5/original/Appendix-to-Evaluating-Feature-Steering-A-Case-Study-in-Mitigating-Social-Biases.pdf)获取。其中包含：

- Appendix 1: The impact of steering on model generations (Table A1);  
- 附录 1：引导（steering）对模型生成结果的影响（表 A1）；

- Appendix 2: List of features (Table A2);  
- 附录 2：特征列表（表 A2）；

- Appendix 3: Additional results (Figures A1-A6);  
- 附录 3：补充实验结果（图 A1–A6）；

- Appendix 4: How does feature steering compare to prompting? (Tables A3-A8).  
- 附录 4：特征引导（feature steering）与提示工程（prompting）的对比效果如何？（表 A3–A8）。
{% endraw %}
