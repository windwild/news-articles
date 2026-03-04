---
title: "Introducing Bloom: an open source tool for automated behavioral evaluations"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/bloom"
date: "2025-12-20"
scraped_at: "2026-03-03T06:43:56.989277764+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
&#123;% raw %}

Alignment

对齐

# Introducing Bloom: an open source tool for automated behavioral evaluations

# 发布 Bloom：一款用于自动化行为评估的开源工具

Dec 19, 2025

2025 年 12 月 19 日

[Read the technical report](https://alignment.anthropic.com/2025/bloom-auto-evals/)

[阅读技术报告](https://alignment.anthropic.com/2025/bloom-auto-evals/)

![Introducing Bloom: an open source tool for automated behavioral evaluations](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_001.svg)

![发布 Bloom：一款用于自动化行为评估的开源工具](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_001.svg)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了一个基准。

_We're releasing Bloom, an open source agentic framework for generating behavioral evaluations of frontier AI models. Bloom takes a researcher-specified behavior and quantifies its frequency and severity across automatically generated scenarios. Bloom's evaluations correlate strongly with our hand-labeled judgments and we find they reliably separate baseline models from intentionally misaligned ones. As examples of this, we release benchmark results for four alignment relevant behaviors on 16 models. Bloom is available [here](https://github.com/safety-research/bloom/)._

_我们正式发布 Bloom —— 一个用于生成前沿 AI 模型行为评估的开源智能体框架。Bloom 接收研究者指定的目标行为，并在自动生成的各类场景中量化该行为的发生频率与严重程度。Bloom 的评估结果与我们人工标注的判断高度相关；实证表明，它能稳定地区分基线模型与被刻意设计为不具对齐性的模型。作为示例，我们发布了 Bloom 在 16 个模型上针对四种与对齐密切相关的行为所开展的基准测试结果。Bloom 开源代码库详见 [此处](https://github.com/safety-research/bloom/)。_

High-quality behavioral evaluations are essential for understanding alignment in frontier AI models. But evaluations generally take a long time to develop, and then run the risk of becoming obsolete: the evaluations can “contaminate” training sets for new models, or capabilities can improve to such an extent that the evaluation no longer really tests what we’re interested in. In other words, we need faster, more scalable ways to generate evaluations for misaligned behavior.

高质量的行为评估对于理解前沿 AI 模型的对齐（alignment）至关重要。但评估通常需要耗费大量时间开发，随后又面临过时风险：这些评估可能“污染”新模型的训练数据集，或因模型能力快速提升，导致原有评估不再能真正检验我们所关注的问题。换言之，我们需要更快速、更具可扩展性的方法，来自动生成针对错位行为（misaligned behavior）的评估。

To this end, we recently released [Petri](https://www.anthropic.com/research/petri-open-source-auditing), an open-source tool that allows researchers to automatically explore AI models’ behavioral profiles through diverse multi-turn conversations with simulated users and tools. Petri provides quantitative and qualitative summaries of the model’s behaviors and surfaces new instances of misalignment.

为此，我们近期发布了开源工具 [Petri](https://www.anthropic.com/research/petri-open-source-auditing)，它支持研究人员通过与模拟用户及工具开展多样化的多轮对话，自动探索 AI 模型的行为特征。Petri 提供模型行为的定量与定性总结，并揭示新的错位行为实例。

Bloom is a complementary evaluation tool. Bloom generates targeted evaluation suites for arbitrary behavioral traits. Unlike Petri—which takes user-specified scenarios and scores many behavioral dimensions to flag concerning instances—Bloom takes a single behavior and automatically generates many scenarios to quantify how often it occurs. We built Bloom to allow researchers to quickly measure the model properties they’re interested in, without needing to spend time on evaluation pipeline engineering. Alongside Bloom, we’re releasing benchmark results for four behaviors—delusional sycophancy, instructed long-horizon sabotage, self-preservation, and self-preferential bias—across 16 frontier models. Using Bloom, these evaluations took only a few days to conceptualize, refine, and generate. We include example pipeline outputs for each of these behaviors below.

Bloom 是一款互补型评估工具。它可为任意行为特征自动生成定向评估套件。与 Petri 不同——后者接收用户指定的场景，并在多个行为维度上打分以识别潜在问题实例——Bloom 则聚焦于单一行为，自动构建大量测试场景，以量化该行为出现的频率。我们开发 Bloom 的初衷，是让研究人员无需投入大量精力于评估流水线工程，即可快速测量其关心的模型特性。与此同时，我们还发布了涵盖 16 个前沿模型的四项行为基准测试结果：妄想式谄媚（delusional sycophancy）、受指令驱动的长周期破坏（instructed long-horizon sabotage）、自我保存（self-preservation）和自我偏好偏差（self-preferential bias）。借助 Bloom，这些评估仅用数天即完成概念设计、迭代优化与生成部署。下方列出了每种行为对应的示例流水线输出。

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_002.jpg)Comparative results from four evaluation suites—delusional sycophancy, instructed long-horizon sabotage, self-preservation and self-preferential bias—across 16 frontier models. Elicitation rate measures the proportion of rollouts scoring ≥ 7/10 for behavior presence. Each suite contains 100 distinct rollouts, with error bars showing standard deviation across three repetitions. We use Claude Opus 4.1 as the evaluator across all stages.

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_002.jpg)四项评估套件——妄想式谄媚、受指令驱动的长周期破坏、自我保存与自我偏好偏差——在 16 个前沿模型上的对比结果。激发率（elicitation rate）指在行为存在性评分中 ≥ 7/10 的 rollout 所占比例。每个套件包含 100 个独立 rollout，误差线表示三次重复实验的标准差。所有阶段均采用 Claude Opus 4.1 作为评估模型。

## How Bloom works

## Bloom 的工作原理

Bloom operates through four automated stages that transform a behavior description and seed configuration into a complete evaluation suite with top-level metrics like elicitation rate and average presence of the behavior. Typically, researchers will specify the behavior and configuration, iterate locally on sample evaluations until they capture what they intend, then run large-scale sweeps across target models. Bloom integrates with Weights & Biases for experiments at scale and exports [Inspect](https://inspect.aisi.org.uk/)-compatible transcripts. It also offers a custom transcript viewer. The repository includes a sample seed file to get started.

Bloom 通过四个自动化阶段运行，将行为描述与种子配置（seed configuration）转化为完整的评估套件，并输出顶层指标（如激发率、行为平均存在度等）。通常，研究人员首先明确目标行为与配置参数，在本地对样本评估进行迭代调试，直至准确捕捉预期行为；随后在目标模型上开展大规模评估扫描。Bloom 支持与 Weights & Biases 集成以实现规模化实验，并导出兼容 [Inspect](https://inspect.aisi.org.uk/) 格式的对话记录（transcripts）；此外还提供定制化对话记录查看器。代码仓库中附带一份示例种子文件，便于快速上手。

Bloom generates evaluations in four stages:

Bloom 分四个阶段生成评估：

1. Understanding: The first Bloom “agent” analyzes the researcher’s behavior description and example transcripts to generate detailed context about what to measure and why.

1. 理解（Understanding）：Bloom 的首个“智能体”分析研究人员提供的行为描述与示例对话记录，生成关于“测量什么”及“为何测量”的详细上下文。

2. Ideation: The ideation agent generates evaluation scenarios designed to elicit the target behavior. Each scenario specifies the situation, simulated user, system prompt, and interaction environment.

2. 构思（Ideation）：构思智能体生成旨在激发目标行为的评估场景。每个场景明确定义情境设定、模拟用户、系统提示词（system prompt）及交互环境。

3. Rollout: These scenarios are rolled out in parallel, with an agent dynamically simulating both the user’s and the tool responses to elicit the sought-after behavior in the target model.

3. 执行（Rollout）：这些场景并行执行；一个智能体动态模拟用户响应与工具响应，从而在目标模型中激发所关注的行为。

4. Judgment: A judge model scores each transcript for the presence of the behavior, along with other user-defined qualities, and a meta-judge produces suite-level analysis.

4. 判定（Judgment）：判定模型对每条对话记录就目标行为的存在性及其他用户自定义属性进行打分；元判定模型（meta-judge）则生成套件层级的综合分析。

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_003.jpg)Bloom's four-stage pipeline with configurable parameters at each stage. Users provide a behavior description and seed configuration; Bloom generates rollout-level and suite-level metrics along with a descriptive report.

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_003.jpg)Bloom 的四阶段流水线，各阶段均支持参数配置。用户输入行为描述与种子配置；Bloom 输出 rollout 层级与套件层级的指标，并附带描述性报告。

Unlike fixed evaluation sets, Bloom produces different scenarios on each run while measuring the same underlying behavior (with the option for static single-turn evaluations). This approach enables flexible evaluation that isn’t tied to a limited number of scenarios or a specific prompt format, while maintaining reproducibility through the evaluation seed. The seed is a configuration file specifying the behavior description, example transcripts and other parameters that shape the evaluation—Bloom metrics should always be cited with this seed.

与固定评估集不同，Bloom 每次运行都会生成不同的测试场景，但始终衡量同一底层行为（亦支持静态单轮评估模式）。该方法实现了高度灵活的评估：既不局限于有限数量的场景，也不拘泥于特定提示格式；同时，通过评估种子（evaluation seed）保障了结果的可复现性。所谓“种子”，是一个配置文件，其中定义了行为描述、示例对话记录及其他影响评估过程的参数——引用 Bloom 的各项指标时，必须同步注明所用种子。

Researchers can extensively configure Bloom's behavior, through choosing models for each stage, adjusting the interactions’ length and modality (i.e., whether to expose tools to the target model, whether to simulate a user), controlling how diverse the evaluation scenarios are, and specifying secondary scoring dimensions, like realism or elicitation difficulty.

研究人员可通过多种方式对 Bloom 的行为进行深度配置：为各阶段选择不同模型，调整交互的长度与模态（例如，是否向目标模型暴露工具、是否模拟用户），控制评估场景的多样性，并指定次要评分维度（如真实性或诱导难度）。

**Example outputs from all four stages of the Bloom evaluation pipeline can be viewed [here.](https://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/public/artifacts/cbfddf51-ab0d-45a9-913b-163ae2dd4126)**

**Bloom 评估流水线全部四个阶段的示例输出可在此处查看：[点击访问](https://claude.ai/redirect/website.v1.027b498d-e1f8-4e85-aef7-b109dbd4c9f4/public/artifacts/cbfddf51-ab0d-45a9-913b-163ae2dd4126)**

## Validation and trust

## 验证性与可信度

To validate Bloom’s performance, we test it against two questions.

为验证 Bloom 的性能，我们围绕两个核心问题展开测试。

**Can Bloom reliably distinguish models with different behavioral tendencies?** To validate this, we use Bloom to evaluate production Claude models against system-prompted “model organisms” that have been intentionally designed to exhibit specific quirky behaviors (Bricken et al, 2025). Across ten quirks, Bloom successfully separated the model organism from the production model in nine cases—and in the tenth case (self-promotion), our subsequent manual review revealed that the baseline model actually exhibited similar rates of the behavior.

**Bloom 能否可靠地区分具有不同行为倾向的模型？** 为验证这一点，我们使用 Bloom 对生产环境中的 Claude 模型进行评估，并将其与经系统提示构建的“模型生物”（model organisms）对比——这些“模型生物”被刻意设计以展现十种特定的异常行为（Bricken 等，2025）。在全部十种异常行为中，Bloom 在九种情形下成功将“模型生物”与生产模型区分开来；而在第十种（自我宣传行为）中，我们后续的人工复核发现，基线模型实际上表现出与“模型生物”相近程度的该类行为。

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_004.jpg)Bloom effectively discriminates between system-prompted model organisms and baseline models across 9/10 quirky behaviors without requiring example transcripts. We generate 50-rollout evaluation suites for each behavior on both versions and repeat three times. (Error bars show standard deviation of elicitation rate.)

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_004.jpg)Bloom 在无需示例对话记录的前提下，成功在 10 种异常行为中的 9 种上有效区分了系统提示驱动的“模型生物”与基线模型。我们针对每种行为，在两个模型版本上均生成包含 50 次 rollout 的评估套件，并重复实验三次。（误差线表示诱导率的标准差。）

**How well-calibrated is the Bloom judge against human judgment?** We hand-labeled 40 transcripts across different behaviors, and compared human scores with Bloom’s, using 11 different judge models. Claude Opus 4.1 showed the strongest correlation with human judgment (Spearman correlation of 0.86), followed by Claude Sonnet 4.5 (0.75). Importantly, Opus 4.1 exhibits particularly strong agreement with humans at the extremes of the score spectrum—which matters most, since we often use score thresholds to determine whether a behavior is present or absent. (This work was done prior to the release of Claude Opus 4.5.)

**Bloom 的评判器与人类判断的一致性如何？** 我们人工标注了涵盖多种行为的 40 条对话记录，并使用 11 种不同的评判模型，将人类评分与 Bloom 的评分进行比对。其中，Claude Opus 4.1 与人类判断的相关性最强（Spearman 相关系数达 0.86），其次为 Claude Sonnet 4.5（0.75）。尤为关键的是，Opus 4.1 在评分分布的两端（即高分与低分极端区域）与人类判断展现出特别强的一致性——而这恰恰最为重要，因为我们通常依赖设定的分数阈值来判定某类行为是否存在或缺失。（此项工作完成于 Claude Opus 4.5 发布之前。）

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_005.jpg)Claude Opus 4.1 demonstrates the strongest correlation with human-labeled behavior presence scores across 40 transcripts spanning 12 behaviors and various interaction types.

![](images/introducing-bloom-an-open-source-tool-for-automated-behavioral-evaluations/img_005.jpg)Claude Opus 4.1 在涵盖 12 类行为、多种交互类型的共 40 条对话记录上，展现出与人工标注的行为存在性得分最强的相关性。

## Case study: Self-preferential bias

## 案例研究：自我偏好偏差

To demonstrate Bloom's practical utility, we replicated an evaluation from the Claude Sonnet 4.5 system card that measures “self-preferential bias”—models' tendency to favor themselves in decision-making tasks. Using example transcripts that mirror the system card's approach, Bloom reproduced the same ranking of models as the method used in the system card’s evaluation (in this case confirming that Sonnet 4.5 exhibits the least bias of the models tested). Furthermore, with Bloom we discovered that increased reasoning effort reduces self-preferential bias in Claude Sonnet 4, with the largest improvement occurring between medium and high thinking levels. (Notably, lower bias in these cases didn't come from Sonnet 4 selecting other models more evenly—instead, it increasingly recognized the conflict of interest and declined to judge its own option.)

为展示 Bloom 的实际应用价值，我们复现了 Claude Sonnet 4.5 系统卡中一项用于衡量“自我偏好偏差”的评估——即模型在决策任务中倾向于偏袒自身的倾向。我们采用与系统卡方法一致的示例对话记录，Bloom 成功复现了系统卡评估所得到的模型排序结果（本例中确认：Sonnet 4.5 在所测试模型中表现出最低的此类偏差）。此外，借助 Bloom，我们还发现：在 Claude Sonnet 4 中，提升推理努力程度可降低其自我偏好偏差，其中最显著的改善出现在“中等”与“高”思考层级之间。（值得注意的是，此类偏差的降低并非源于 Sonnet 4 更均衡地选择了其他模型；而是它越来越能识别出利益冲突，并主动拒绝对其自身选项作出评判。）

Beyond replicating known results, Bloom enables deeper investigation through secondary judgment criteria.  
除了复现已知结果外，Bloom 还支持通过次级判断标准开展更深入的探究。

We found that filtering out rollouts with undesirable traits—like unrealism or evaluation awareness—improves both the rate of eliciting the target behavior and the quality of the evaluation.  
我们发现，过滤掉具有不良特征（例如不切实际性或评估意识）的推理轨迹（rollouts），既能提升目标行为的触发率，也能提高评估质量。

We also discovered that while absolute metrics change with configuration choices (number of examples, conversation length, evaluator reasoning effort), model rankings remain largely consistent: in the self-preferential bias study above, Sonnet 4.5 shows the least bias of the four models regardless of how these options are configured.  
我们还发现，尽管绝对指标会随配置选择（如示例数量、对话长度、评估者推理投入程度）而变化，模型的相对排序却基本保持稳定：在上述自偏好偏差研究中，无论这些选项如何配置，Sonnet 4.5 始终是四个模型中表现出最少偏差的一个。

## Get started

## 快速上手

We built Bloom to be accessible and highly configurable, serving as a reliable evaluation generation framework for diverse research applications.  
我们构建 Bloom 的初衷是使其易于使用且高度可配置，从而为各类研究应用提供一个可靠的自动化行为评估生成框架。

Early adopters are already using Bloom to evaluate nested jailbreak vulnerabilities, test hardcoding, measure evaluation awareness, and generate sabotage traces.  
早期使用者已开始利用 Bloom 评估嵌套式越狱漏洞、测试硬编码行为、度量评估意识，并生成破坏性行为轨迹（sabotage traces）。

As AI systems grow more capable and are deployed in increasingly complex environments, the alignment research community needs scalable tools for exploring their behavioral traits. This is what Bloom is designed to facilitate.  
随着 AI 系统能力不断增强，并被部署于日益复杂的环境中，对齐（alignment）研究社区亟需可扩展的工具，以系统探索其行为特征。这正是 Bloom 的设计目标所在。

For complete technical details, experimental configurations, additional case studies, and limitations, read our full technical report on the [Alignment Science blog](https://alignment.anthropic.com/2025/bloom-auto-evals/).  
如需了解完整的技术细节、实验配置、更多案例研究及局限性说明，请参阅我们在 [Alignment Science 博客](https://alignment.anthropic.com/2025/bloom-auto-evals/) 上发布的完整技术报告。

Access Bloom at [github.com/safety-research/bloom](https://github.com/safety-research/bloom).  
访问 Bloom 项目主页：[github.com/safety-research/bloom](https://github.com/safety-research/bloom)。

## Acknowledgments

## 致谢

We would like to thank Keshav Shenoy, Christine Ye, Simon Storf, Julius Steen, Jifan Zhang and Javier Rando for early feedback on Bloom.  
我们衷心感谢 Keshav Shenoy、Christine Ye、Simon Storf、Julius Steen、Jifan Zhang 和 Javier Rando 对 Bloom 早期版本提出的宝贵反馈。

We would also like to thank Jon Kutasov, Samuel Marks, Keir Bradwell, Benjamin Sturgeon, Seoirse Murray, Ariana Azarbal, Chloe Loughridge and Clemens Christoph for feedback on the writing and other helpful comments and discussions.  
我们还要感谢 Jon Kutasov、Samuel Marks、Keir Bradwell、Benjamin Sturgeon、Seoirse Murray、Ariana Azarbal、Chloe Loughridge 和 Clemens Christoph 在文稿撰写及其他方面提供的有益意见与深入讨论。

### Citation

### 引用格式

```
@misc{bloom2025,
title={Bloom: an open source tool for automated behavioral evaluations},
author={Gupta, Isha and Fronsdal, Kai and Sheshadri, Abhay and Michala, Jonathan and Tay, Jacqueline and Wang, Rowan and Bowman, Samuel R. and Price, Sara},
year={2025},
url={https://github.com/safety-research/bloom},
}
```

Copy

复制
&#123;% endraw %}
