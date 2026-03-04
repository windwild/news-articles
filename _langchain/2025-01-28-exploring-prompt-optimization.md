---
title: "Exploring Prompt Optimization"
source: "LangChain Blog"
url: "https://blog.langchain.com/exploring-prompt-optimization/"
date: "2025-01-28"
scraped_at: "2026-03-03T07:42:31.037786162+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

By [Krish Maniar](https://www.linkedin.com/in/krishmaniar4?ref=blog.langchain.com) and William Fu-Hinthorn

作者：[Krish Maniar](https://www.linkedin.com/in/krishmaniar4?ref=blog.langchain.com) 与 William Fu-Hinthorn

_If you are interested in beta-testing more prompt optimization techniques, fill out interest form_ [_here_](https://docs.google.com/forms/d/e/1FAIpQLSdK1pZihqohabtGRQ99LZ2Rdwo5dnpnzJrBFRdojVSFq7k8eg/viewform?usp=dialog&ref=blog.langchain.com) _._

_如果您有兴趣参与更多提示词优化技术的 Beta 测试，请在此处填写意向表单：[_此处_](https://docs.google.com/forms/d/e/1FAIpQLSdK1pZihqohabtGRQ99LZ2Rdwo5dnpnzJrBFRdojVSFq7k8eg/viewform?usp=dialog&ref=blog.langchain.com)。_

When we write prompts, we attempt to communicate our intent for LLMs to apply on messy data, but it's hard to effectively communicate every nuance in one go. Prompting is typically done through manual trial and error, testing and tweaking until things work better; on the other hand, tools like [DSPy](https://dspy.ai/?ref=blog.langchain.com) and [promptim](https://dspy.ai/?ref=blog.langchain.com) have shown the usefulness of prompt "programming" and systematic prompt optimization by closing the intent-instruction gap through measurement and testing on real data. In this post, we:

当我们编写提示词时，我们试图向大语言模型（LLM）传达意图，使其能有效处理杂乱、非结构化的数据；但要在一次尝试中精准传递所有细微意图，实属困难。目前提示工程通常依赖人工反复试错——不断测试、调整，直至效果改善；而另一方面，[DSPy](https://dspy.ai/?ref=blog.langchain.com) 和 [promptim](https://dspy.ai/?ref=blog.langchain.com) 等工具已证明，“提示编程”（prompt programming）与系统性提示优化具有显著价值：它们通过在真实数据上进行测量与测试，弥合了用户意图与模型指令之间的鸿沟。本文中，我们：

- Curate five different datasets with verifiable outcomes for benchmarking prompt optimization  
- 实验整理了五个具备可验证结果的数据集，用于提示词优化效果的基准评测；
- Implement and benchmark five different methods of systematically improving prompts  
- 实现并评测了五种系统化提升提示词质量的方法；
- Benchmark how well three different models (`gpt-4o`, `claude-sonnet`, `o1`) do on prompt optimization  
- 对比评测了三种不同模型（`gpt-4o`、`claude-sonnet`、`o1`）在提示词优化任务上的表现。

### **Our conclusions:**

### **我们的核心结论：**

- **Our recommended model for prompt optimization is `claude-sonnet` (over `o1`)**
- **我们推荐将 `claude-sonnet`（而非 `o1`）作为提示词优化的首选模型；**
- **Prompt optimization is most effective on tasks where the underlying model lacks domain knowledge**
- **提示词优化在基础模型缺乏领域知识的任务中效果最为显著；**
- **In the above situations, prompt optimization can show a ~200% increase in accuracy over naive baseline prompts**
- **在上述场景中，提示词优化相较朴素基线提示词，可带来约 200% 的准确率提升；**
- **Prompt optimization in these situations can also be thought of as a form of long-term memory: learning to adapt directly from your data**
- **此类情境下的提示词优化，亦可视为一种“长期记忆”机制：即直接从您的数据中学习并持续适配。**

## What we tested

## 我们测试的内容

We benchmarked five popular prompt optimization approaches (more detailed explanations later on):

我们评测了五种主流的提示词优化方法（后文将提供更详细的说明）：

1. Few-shot prompting: use training examples as demonstrations of expected behavior  
1. 少样本提示（Few-shot prompting）：利用训练样例作为预期行为的示范；
2. Meta-prompting: use an LLM to analyze and improve prompts  
2. 元提示（Meta-prompting）：调用大语言模型分析并改进提示词；
3. Meta-prompting with reflection: let the LLM think and critique its analysis before committing to an updated prompt  
3. 带反思的元提示（Meta-prompting with reflection）：让大语言模型在生成更新版提示词前，先进行思考与自我批判；
4. Prompt gradients: generate targeted improvement recommendations for each example as "text gradients" and then apply those in a separate LLM call  
4. 提示梯度（Prompt gradients）：为每个样例生成针对性的改进建议（即“文本梯度”），再通过另一次大语言模型调用应用这些改进；
5. Evolutionary optimization: explore prompt space through controlled mutations  
5. 进化式优化（Evolutionary optimization）：通过受控变异，在提示词空间中进行探索。

We ran these across three models (O1, GPT-4, and Claude-3.5-Sonnet) on five datasets representative of common tasks, intending to answer the following primary questions:

我们在三类模型（O1、GPT-4、Claude-3.5-Sonnet）上，于五个典型任务的代表性数据集上运行了上述全部方法，旨在回答以下核心问题：

- When does prompt optimization work best?  
- 提示词优化在什么情况下效果最佳？

- Which frontier models work well for prompt optimization?  
- 哪些前沿大语言模型在提示词优化任务中表现良好？

- Which algorithms are the most reliable?  
- 哪些算法最为可靠？

## Algorithms  
## 算法

We tested five different approaches to prompt optimization, each with its own theory of how to improve prompts:  
我们测试了五种不同的提示词优化方法，每种方法都基于各自对“如何改进提示词”的理论假设：

**Few-shot prompting**  
**少样本提示（Few-shot prompting）**

For the simplest tested technique, we chose up to 50 examples from the training set (sampled over a few epochs) and included them in the prompt as demonstrations of expected behavior. This is efficient to learn (since no LLM calls are required to propose changes), though it leads to higher token costs at test time (since typical demonstrations contain more content than direct single instructions).  
作为所测试的最简单技术，我们从训练集中选取最多 50 个样本（跨若干轮次采样），并将它们作为预期行为的示例直接嵌入提示词中。该方法学习效率高（因无需调用大语言模型来生成修改建议），但在推理阶段会带来更高的 token 开销（因典型示例通常比单一指令包含更丰富的内容）。

**Meta-prompting**  
**元提示（Meta-prompting）**

The was the simplest instruction-tuning approach. We first ran the target LLM over the examples. We then calculated scores on the outputs. Note: this requires evaluator(s) to be set up. We then showed the meta-prompting LLM examples of inputs, outputs, reference outputs (if available), and the current prompt's scores on those outputs. Based on those variables, we then asked the LLM to write a better prompt. We repeat this process in mini-batches, periodically evaluating on a held-out development (dev) set. The prompt with the highest dev set score is retained.  
这是最简单的指令微调方法。我们首先让目标大语言模型在示例数据上运行，随后对输出结果进行评分（注意：此步骤需预先配置评估器）。接着，我们将输入、模型输出、参考输出（如可用）以及当前提示词在这些输出上的得分，一并提供给执行元提示的 LLM，并要求其据此生成更优的提示词。该过程以小批量方式迭代进行，并定期在独立的开发集（dev set）上评估效果；最终保留开发集得分最高的提示词。

**Meta-prompting with reflection**  
**带反思机制的元提示（Meta-prompting with reflection）**

We re-use the meta-prompting technique from the first step but give the LLM the option to use "think" and "critique" tools. These tools do nothing more than give the LLM an opportunity to write down thoughts in a scratchpad before committing to a particular prompt update. This helps the LLM use more test-time compute to analyze previous prompts and look for more hidden patterns in the underlying data distribution before committing to the next prompt update.  
我们在第一步元提示的基础上复用该技术，但额外赋予 LLM 使用“思考（think）”和“批判（critique）”工具的能力。这些工具本身不执行任何操作，仅提供一个临时草稿区（scratchpad），供 LLM 在正式更新提示词前写下分析思路与反思内容。此举有助于 LLM 在推理阶段投入更多计算资源，深入分析历史提示词的表现，并挖掘数据分布中更隐蔽的模式，从而为下一次提示词更新做出更审慎的决策。

**Prompt Gradients**  
**提示梯度（Prompt Gradients）**

Popularized by papers such as " [Automatic Prompt Optimization](https://arxiv.org/abs/2305.03495?ref=blog.langchain.com)" by Pryzant et al., this approach breaks optimization into smaller steps:

由Pryzant等人撰写的论文《[Automatic Prompt Optimization](https://arxiv.org/abs/2305.03495?ref=blog.langchain.com)》等所推广，该方法将优化过程分解为若干更小的步骤：

![](images/exploring-prompt-optimization/img_001.png)

![](images/exploring-prompt-optimization/img_001.png)

1. Score the current prompt's outputs  
1. 对当前提示词（prompt）的输出进行评分  

2. Using an LLM, generate specific feedback for each example where the prompt failed (these are the "gradients")  
2. 利用大语言模型（LLM），针对提示词失效的每个样例生成具体反馈（这些即所谓“梯度”）  

3. Propose prompt updates based on these collected "gradients"  
3. 基于所收集的这些“梯度”，提出提示词更新方案  

The idea is that collecting fine-grained feedback before making changes leads to more targeted improvements than the meta-prompting approach.

其核心思想在于：在实施修改前先收集细粒度反馈，相比元提示（meta-prompting）方法，能实现更具针对性的改进。

**Evolutionary Optimization**

**进化式优化**

These algorithms operate in "generations", with groups of generations organized by a phase of a larger curriculum. For each generation, the algorithm applies semi-random "mutations" (in our cases, different types of prompt updates created with the help of an LLM) to create candidate prompts. The best performing prompts are retained after each generation.

此类算法以“代”（generations）为单位运行，多代被组织进一个更大课程体系（curriculum）的不同阶段中。每一代中，算法施加半随机的“变异”操作（在本研究中，即借助大语言模型生成的不同类型提示词更新），从而产生候选提示词；每一代结束后，仅保留表现最优的提示词。

In these experiments, we adapted [PhaseEvo](https://arxiv.org/abs/2402.11347?ref=blog.langchain.com), a recent technique by Cui et al. that combines direct "text gradient" approaches like the one described above with more "global" or lateral updates that instruct the LLM to create new prompts based on shared patterns in the existing population. In theory, this helps the algorithm overcome local optima through greater exploration of variations across the prompt population. PhaseEvo works in phases:

在本次实验中，我们采用了Cui等人提出的最新技术——[PhaseEvo](https://arxiv.org/abs/2402.11347?ref=blog.langchain.com)。该方法融合了上述直接的“文本梯度”（text gradient）策略与更具“全局性”或“横向性”的更新方式：后者指导大语言模型基于当前提示词种群（population）中浮现的共性模式，生成全新提示词。理论上，这种融合可通过在提示词种群中更广泛地探索各类变体，帮助算法跳出局部最优解。PhaseEvo按阶段运行：

![](images/exploring-prompt-optimization/img_002.png)

![](images/exploring-prompt-optimization/img_002.png)

1. Generate diverse initial prompts (by guessing instructions that would create the expected outputs for a set of training examples and then paraphrasing these prompts for more diversity)  
1. 生成多样化的初始提示词（方法是：先推测出能对一组训练样例生成预期输出的指令，再对这些指令进行改写以增强多样性）  

2. Apply prompt gradients to the best performers (See the prompt gradients section above for more information)  
2. 对表现最优的提示词应用提示词梯度（详见上文“提示词梯度”部分）  

3. Create new variants of the top 5 performing prompts through paraphrasing  
3. 通过对表现前五的提示词进行改写，生成其新变体  

4. Combine successful prompts to capture their best elements. This generates a new prompt from two or more existing prompts that are most dissimilar. Since this focuses on distilling or expanding existing prompts, it avoids getting stuck on local errors and encourages further exploration.  
4. 融合多个成功提示词，萃取并整合其最优成分。该步骤从两个或更多彼此差异最大的现有提示词出发，生成一个新提示词。由于该操作聚焦于提炼或拓展已有提示词，因而可避免陷入局部错误，并进一步激发探索潜力。  

5. Repeat gradient optimization on the winners to finish.  
5. 对最终胜出的提示词重复执行梯度优化，完成整个流程。  

The hypothesis for these types of approaches is that LLMs tend to get stuck making shallow corrections based on observed errors without sufficiently analyzing the data as a whole and without adequately exploring other prompting techniques. The structured prompt evolution in theory could help the process find a more globally optimal solution compared to the more straightforward hill-climbing approaches.

此类方法背后的假设是：大语言模型往往囿于表层修正——仅依据观察到的错误进行浅层调整，既未能充分整体分析数据，也未能充分探索其他提示工程技术。而结构化的提示词演化机制，理论上可助力优化过程发现比简单爬山法（hill-climbing）更接近全局最优的解决方案。

## Datasets

## 数据集

We created five datasets to benchmark these on.

我们构建了五个数据集，用于对这些方法进行基准测试。

1. **Support email routing 3**: for each inbound email, route them to the correct assignee (of 3 assignees).

1. **支持邮件路由（3人）**：针对每封入站邮件，将其分配给三位指定处理人中正确的一位。

2. **Support email routing 10:** same as (1) but with 10 possible assignees. This is more challenging, since the "domain expertise" of each assignee is less distinct.

2. **支持邮件路由（10人）**：与（1）相同，但候选处理人增至10位。该任务更具挑战性，因为每位处理人的“领域专长”边界更模糊。

3. **Multilingual math**: the LLM is given a mathematical word problem and must respond with the correct answer spelled out in one of 5 languages. Language is determined by the topic or theme of the word problem (sports->Korean, outer space-> Arabic, cooking -> German, music->English, wildlife->Russian). Neither the prompt nor the optimizer know why a target language is chosen, so the optimizer must be able to discover the latent pattern hidden in the dataset.

3. **多语言数学题**：大语言模型接收一道数学应用题，并须以五种语言之一拼写出正确答案。目标语言由题目主题决定（体育→韩语，外太空→阿拉伯语，烹饪→德语，音乐→英语，野生动物→俄语）。提示词本身及优化器均不知晓语言选择的依据，因此优化器必须能从数据集中发现隐藏的潜在规律。

4. **Email assistant simple**: this is a synthetic dataset meant to test whether prompt optimization is useful for tasks that are well-covered by the LLM's domain knowledge. The LLM is tasked with classifying whether to ignore, respond, or notify the user for a given email.

4. **邮件助手（简易版）**：这是一个合成数据集，旨在检验提示词优化是否对那些本就处于大语言模型领域知识覆盖范围内的任务具有价值。模型需对给定邮件进行分类，判断应忽略、直接回复，还是通知用户。

5. **Email assistant eccentric**: this is similar to the dataset above, but based on more hidden preference rules. Note: these preference rules are _eccentric_, meaning even though the response labels are within the LLM's domain knowledge, the preference rules are not. We crafted a persona of a busy, eccentric tech mogul to provide the ground truth labels for the responses.

5. **邮件助手（怪癖版）**：该数据集与上述类似，但其分类依据是一组更隐蔽的偏好规则。注：这些偏好规则是“怪癖式”的——即尽管最终响应标签本身属于大语言模型的知识范畴，但决定标签归属的规则却并非模型所熟知。我们专门设计了一位忙碌而古怪的科技巨头人物画像，以此作为生成响应真实标签（ground truth labels）的依据。

## Results

## 实验结果

We ran experiments across the five datasets using OpenAI's GPT-4o and O1 models, and Anthropic's Claude-3.5-sonnet as meta-prompting LLMs to drive the optimization algorithms. The target LLM is GPT-4o-mini (meaning we are using other models to optimize a prompt for GPT-4o-mini).

我们在五个数据集上开展了实验，选用 OpenAI 的 GPT-4o 和 O1 模型，以及 Anthropic 的 Claude-3.5-sonnet 作为元提示（meta-prompting）大语言模型，驱动各类优化算法；目标大语言模型为 GPT-4o-mini（即：我们利用其他模型来为 GPT-4o-mini 优化提示词）。

For each algorithm, we select the prompt with the best score on the dev set as the final output of the optimization run. For that prompt, we plot the average scores over three runs on the test split (in the **bar charts)**. 95% confidence bounds are also shown, computed using [Wilson score interval](https://en.wikipedia.org/wiki/Binomial_proportion_confidence_interval?ref=blog.langchain.com) for the binary pass/fail metrics. In the appendix, we also plot the dev set scores for each epoch (or phase in the case of the evolutionary algorithm) to better show the training dynamics for each experiment.

对每种算法，我们选取在开发集（dev set）上得分最高的提示词作为该轮优化的最终输出。对该提示词，我们在测试集（test split）上运行三次并取平均分（以**柱状图**呈现）。所有二分类通过/失败（pass/fail）指标均附带 95% 置信区间，采用 [Wilson 分数区间法](https://en.wikipedia.org/wiki/Binomial_proportion_confidence_interval?ref=blog.langchain.com) 计算。附录中还绘制了各轮次（或进化算法中的各阶段）在开发集上的得分曲线，以便更清晰地展现每次实验的训练动态。

As baselines, we compare the results against GPT-4o-mini scores on a starter prompt for each task. We also include results for how other base models (Claude-3.5-sonnet, O1, O1-mini, and GPT-4o) would have fared on the baseline prompt. Here is what we found.

作为基线对照，我们将各方法结果与 GPT-4o-mini 在各任务初始提示词（starter prompt）下的表现进行比较。此外，我们也报告了其他基础模型（Claude-3.5-sonnet、O1、O1-mini 和 GPT-4o）在相同初始提示词下的性能。以下是我们的主要发现。

_Note: Due to sporadic flagging for content violations in the O1 endpoint during the evolutionary prompting algorithm, we have omitted a couple o1 experiments that were unable to complete._

_注：由于在执行进化式提示优化算法期间，O1 接口偶发因内容违规被拦截，我们不得不省略了少数几组未能完成的 O1 实验。_

**Support email routing (3)**

**支持邮件路由（3人）**

The optimizers consistently improved over the baseline prompt, with both gradient and evolutionary approaches showing similar gains. Claude notably outperformed GPT-4o across all approaches. Claude and 4o fail to improve much even on the dev set using the meta-prompting approach.

所有优化器均稳定优于初始提示词基线；基于梯度和基于进化的两类方法提升幅度相近。Claude 在所有方法中均显著超越 GPT-4o。然而，在采用元提示方法时，Claude 与 GPT-4o 即便在开发集上也几乎未见明显提升。

Below are the results on the test split. Few-shot prompting consistently led to improved, but sub-optimal performance, with the 4o-mini setup only slightly outperforming the worst of the meta-prompting techniques. The more involved evolutionary algorithm slightly outcompeted the other algorithms as well. Claude does a slightly better job at optimizing the underlying model than O1, with GPT-4o lagging behind.

以下是测试集上的结果。少样本提示（few-shot prompting）始终带来性能提升，但仍未达到最优；其中 GPT-4o-mini 配置仅略微优于各类元提示（meta-prompting）技术中最差的一种。更复杂的进化算法（evolutionary algorithm）也略微超越了其他算法。Claude 在优化底层模型方面略胜 O1 一筹，而 GPT-4o 则明显落后。

![](images/exploring-prompt-optimization/img_003.png)Test set performance for experiments on the support email routing (3) dataset. Answers are considered correct (1) if the prompt + model combination assign the email to the correct individual. For each experiment setting, the prompt with the highest dev split pass rate was selected and evaluated on the test split. Aggregations by model and algorithm were done using an arithmetic mean.

![](images/exploring-prompt-optimization/img_003.png)支持邮件路由（3 类）数据集实验的测试集性能。若提示词与模型组合能将邮件正确分配给对应负责人，则视为答案正确（得分为 1）。在每组实验设置中，均选取开发集（dev split）通过率最高的提示词，并在测试集上进行最终评估。按模型与算法分别汇总的平均性能采用算术平均法计算。

**Support email routing (10)**

**支持邮件路由（10 类）**

This is a slightly harder 10-way classification problem of a similar style to the previous dataset. As you can see from the curves below, GPT-4o's failure to converge on the development set when using the simple meta-prompting & the meta-prompting + reflection algorithms is predictive of poor performance on the test split.

这是一个难度稍高的 10 分类任务，风格与前述数据集类似。如下方曲线所示，GPT-4o 在采用简单元提示及“元提示 + 反思”（meta-prompting + reflection）算法时，在开发集上未能收敛，这一现象预示其在测试集上表现欠佳。

The final test results are below. Similar to the first dataset, few-shot prompting gives consistent improvement, though it still lags behind most of the other prompt optimizer techniques.

最终测试结果如下。与第一个数据集类似，少样本提示仍能带来稳定提升，但整体性能仍落后于大多数其他提示词优化技术。

![](images/exploring-prompt-optimization/img_004.png)Test set performance for experiments on the support email routing (10) dataset. Answers are considered correct (score of 1) if the prompt + model combination assign the email to the correct individual. For each experiment setting, the prompt with the highest dev split pass rate was selected and evaluated on the test split. Aggregations by model and algorithm were done using an arithmetic mean.

![](images/exploring-prompt-optimization/img_004.png)支持邮件路由（10 类）数据集实验的测试集性能。若提示词与模型组合能将邮件正确分配给对应负责人，则视为答案正确（得分为 1）。在每组实验设置中，均选取开发集通过率最高的提示词，并在测试集上进行最终评估。按模型与算法分别汇总的平均性能采用算术平均法计算。

O1 really shines on this dataset, outperforming Claude under similar configurations. Gpt-4o suffers once more in all but the evolutionary and gradient algorithms. Surprisingly, GPT-4o causes a prompt _regression_ when using meta-prompt + reflect configuration, likely due to overfitting to specifics on the training split.

O1 在该数据集上表现尤为突出，在相似配置下超越了 Claude。GPT-4o 除在进化算法与梯度算法中尚可外，其余所有方法中均表现不佳。令人意外的是，当采用“元提示 + 反思”配置时，GPT-4o 导致提示词性能出现**倒退（regression）**，原因很可能是其在训练集上发生了过拟合，过度适应了特定样本细节。

**Multilingual math**

**多语言数学题**

This dataset was perhaps the most **discontinuous**, as shown by the dev set performance getting most of its improvements in a single epoch around epoch 3 or 4 (see **Appendix**). This is because the data contains a simple hidden pattern: the target language is determined by the topic of the word problem. Below are the test split results.

该数据集或许是**最不连续（discontinuous）**的一个：如开发集性能曲线所示（参见**附录**），其绝大部分性能提升都集中在第 3 或第 4 轮训练（epoch）附近的一次跃升中。这是因为数据中存在一个简单的隐藏规律：目标语言由应用题的主题决定。下方为测试集结果。

![](images/exploring-prompt-optimization/img_005.png)Test set performance for experiments on the multilingual math dataset. Answers are considered correct (1) if the value is expressed correctly and in the correct target language.For each experiment setting, the prompt with the highest dev split pass rate was selected and evaluated on the test split. Aggregations by model and algorithm were done using an arithmetic mean.

![](images/exploring-prompt-optimization/img_005.png)多语言数学题数据集实验的测试集性能。若数值表达正确且使用了指定的目标语言，则视为答案正确（得分为 1）。在每组实验设置中，均选取开发集通过率最高的提示词，并在测试集上进行最终评估。按模型与算法分别汇总的平均性能采用算术平均法计算。

Due to the stated discontinuity, most of the model<>algorithm combinations failed to provide much improvement over the baseline.

由于上述不连续性，大多数“模型<>算法”组合未能显著超越基线水平。

The reasoning models (O1 and O1-mini) were the best at effecively leveraging the few-shot examples, beating out all the techniques that weren't able to converge to the correct solution. Surprisingly, though O1 was able to leverage the few-shots, it did a poor job of optimizing the prompt instructions. O1 was unable to discover the trick in any of the algorithms.

推理型模型（O1 和 O1-mini）在有效利用少样本示例方面表现最佳，胜过了所有无法收敛至正确解的其他技术。令人意外的是：尽管 O1 能够有效利用少样本示例，却在优化提示指令方面表现欠佳；O1 在所有算法中均未能发现其中的关键技巧。

Claude and (somewhat surprisingly) GPT-4o were both able to discover the solution using the evolutionary algorithm (which runs the optimizer through a curriculum to capture local and global information rather than repeatedly focusing on specific errors). Similarly, Claude was able to discover the correct solution under the metaprompt + reflection setup.

Claude（以及——略令人意外地——GPT-4o）均能借助进化算法（evolutionary algorithm）发现正确解：该算法让优化器通过一个渐进式课程（curriculum）运行，以同时捕获局部与全局信息，而非反复聚焦于特定错误。同样地，Claude 在“元提示（metaprompt）+ 反思（reflection）”配置下也成功找到了正确解。

**Email assistant simple**

**邮件助手（简易版）**

This dataset prompts the model to decide whether an email assistant should **notify** the user, **ignore** the email, or **respond** to the email directly. It follows rules that are fairly obvious, meaning that we expect the base prompt configurations to work well. Below are the training curves.

该数据集要求模型判断邮件助手应**通知**用户、**忽略**该邮件，还是**直接回复**该邮件。其判定规则较为直观，因此我们预期基础提示配置即可取得良好效果。下方为训练曲线图。

And the following are the test results. As you can see at a glance, the results are fairly consistent across model<>algorithm combinations.

以下为测试结果。从图中可一目了然地看出，各“模型<>算法”组合的结果整体上高度一致。

![](images/exploring-prompt-optimization/img_006.png)Performance (pass rate) on the test split of the email assistant (simple) dataset. For each experiment setting, the prompt with the highest dev split pass rate was selected and evaluated on the test split. Aggregations by model and algorithm were done using an arithmetic mean.

![](images/exploring-prompt-optimization/img_006.png)邮件助手（简易版）数据集测试集上的性能（通过率）。对每组实验设置，均选取开发集（dev split）通过率最高的提示，并在测试集上进行评估。按模型和算法分别聚合时，采用算术平均值。

In this case **few-shot examples** produce the most reliable improvements. The task doesn't require the optimizer to uncover any hidden patterns far from the target model's existing behavior. The patterns are barely hidden. Because of this, few-shots do the best job of communicating the expected behavior.

在此任务中，**少样本示例（few-shot examples）** 带来了最稳定可靠的性能提升。该任务无需优化器挖掘远离目标模型现有行为的深层隐藏模式——这些模式本身几乎毫无隐蔽性。正因如此，少样本示例在传达预期行为方面效果最佳。

The direct prompt optimization approaches (gradient, metaprompt) have a hard time capturing reasonable instructions to guide the model in this case beyond what it already knows. We noted that meta-prompting tends to include some unnecessary instructions, even if the optimizer is instructed to focus only on adding instructions that explicitly address failures. O1 and GPT-4o both struggled to assist on this task.

直接式提示优化方法（如基于梯度的方法、元提示法）在此任务中难以提炼出合理的新指令，以在模型已有知识之外进一步引导其行为。我们观察到：即使明确指示优化器仅添加能直接解决失败案例的指令，元提示法仍倾向于引入一些冗余或不必要的内容。O1 与 GPT-4o 在此任务中均表现乏力。

**Email assistant eccentric**

**邮件助手（特异版）**

This task revealed interesting differences between algorithms. The evolutionary approach showed steady improvement throughout training, though never reached perfect scores. More importantly, its improvements translated more reliably to test set performance for 2 of the 3 combinations.

该任务揭示了不同算法之间一些有趣的差异。进化式方法在整个训练过程中展现出持续稳定的提升，但始终未能达到满分。更重要的是，在所测试的 3 种模型组合中，其性能提升在其中 2 种组合上更可靠地泛化到了测试集表现。

Here, Claude still outperforms GPT-4o and O1. The evolutionary algorithm generally outshines the other two techniques, though O1 seems to underperform in that setting.

在此任务中，Claude 仍优于 GPT-4o 和 O1。进化式算法整体上优于另外两种技术；不过 O1 在该设定下表现明显偏弱。

![](images/exploring-prompt-optimization/img_007.png)

**Overall Results**

**总体结果**

Below we plot the average percentage change of each experimental setup across all tested datasets. We use bootstrap sampling to plot 95% confidence intervals for each metric. We also group results by optimizer model and by algorithm. Percentage change represents the optimizer's impact on the target model, relative to the GPT-4o-mini baseline. 100% means that the score has doubled in relative impact, so if the original prompt gets a 20% on a task, the optimized prompt is 40%, etc.

下方图表展示了所有被测数据集上各实验配置的平均百分比变化。我们采用自助法（bootstrap sampling）为每项指标绘制 95% 置信区间。结果同时按优化器模型（optimizer model）和优化算法（algorithm）分组呈现。百分比变化衡量的是优化器对目标模型的影响程度，以 GPT-4o-mini 基线为参照：100% 表示相对影响翻倍——例如原始提示在某任务上得分为 20%，经优化后的提示得分即为 40%，以此类推。

![](images/exploring-prompt-optimization/img_008.png)Average relative improvement above base, with 100% being a doubling of the pass rate, 200% being tripling, etc.

![](images/exploring-prompt-optimization/img_008.png)相对于基线的平均相对提升幅度：100% 表示通过率翻倍，200% 表示三倍，依此类推。

As you can see, the results have wide error margins! While we do see consistent improvements for many of the algorithm<>model settings for these datasets, the lower bound for most of the experiments is **negative —** the current settings sometimes cause the prompt to overfit to training examples rather than leading to robust systems. When applying these techniques, it continues to be important that you maintain a separate test split to confirm that the improvements you see on the train & development splits actually translates to more aligned behavior in reality.

如您所见，结果误差范围非常宽！尽管在这些数据集上，多数“算法 × 模型”组合均展现出一致的正向改进，但大多数实验的置信区间下限为**负值**——当前设置有时会导致提示词过度拟合训练样本，而非构建出鲁棒的系统。因此，在应用这些技术时，仍务必保留独立的测试集，以验证在训练集与开发集上观察到的提升，是否真实转化为现实中更符合预期的行为。

As shown, Claude and O1 perform comparably on-average, but O1 has a very high variance. If you were to care just about the head-to-head win rate, the consistency is more clear: under the tested settings, **Claude was a more reliable optimizer model.**

如图所示，Claude 与 O1 的平均表现相近，但 O1 的方差极高。若仅关注直接对比胜率（head-to-head win rate），其稳定性差异则更为明显：在当前测试设定下，**Claude 是更可靠的优化器模型。**

Adding in O1's slower processing time, higher costs, and less reliable API (OpenAI semi-frequently incorrectly flagged our completions as violating the ToS), we feel comfortable recommending Sonnet 3.5 as the preferred optimizer model for now. We're excited to update our recommendations with the launch of O3 and other models.

再结合 O1 更慢的处理速度、更高的使用成本，以及不够稳定的 API（OpenAI 曾多次误判我们的生成结果违反服务条款），我们目前可放心推荐 Sonnet 3.5 作为首选优化器模型。随着 O3 及其他新模型的发布，我们也将乐于及时更新相关建议。

## What We Learned

## 我们的收获

The results above generally support the existing literature that LLMs are effective prompt engineers. These experiments also shed some light on when they would be (in)-effective.

上述结果总体上支持现有文献中关于大语言模型（LLMs）是高效提示工程师的结论。这些实验也进一步揭示了LLMs在何种情况下会（不）有效。

1. Meta-prompting is especially useful for **discovering rules or preferences** and other clear patterns in the data that may not have been in the LLM's domain knowledge. This means you can define the behavior you want through examples and rely on the optimizer to translate those behaviors to other LLMs so long as they are reasonable instruction followers. This makes declarative prompt programming models possible.

1. 元提示（Meta-prompting）在**发现规则或偏好**，以及数据中其他清晰模式方面尤为有效——而这些模式可能并未包含在LLM的领域知识中。这意味着你可以通过示例定义所需行为，并依赖优化器将这些行为迁移到其他LLM上，前提是目标模型具备合理遵循指令的能力。这使得声明式提示编程（declarative prompt programming）模型成为可能。

2. Meta-prompting (via instruction tuning) is _less_ useful for communicating **nuance** in preferences, as shown in the simple email classification dataset. All the prompt tuning approaches underperformed the few-shot prompting approach for the simple email dataset, where the distinction was less about bright-line rules and conditionals.

2. 元提示（通过指令微调实现）在传达偏好的**细微差别**方面效果较弱，这一点在简单的邮件分类数据集上得到了印证。在该数据集上，所有提示微调方法的表现均逊于少样本提示（few-shot prompting）方法——因为该任务的区分关键并非明确的规则或条件逻辑。

3. We suspect from (1) and (2) that combining few-shot prompting & instruction tuning provides complementary improvements. This supports existing conclusions such by [Opsahl Ong, et. al.](https://arxiv.org/abs/2406.11695?ref=blog.langchain.com) and [Wan, et. al](https://arxiv.org/pdf/2406.15708?ref=blog.langchain.com). Few-shot examples communicate more information than simple instructions but don't capture **complex conditionals and rules** that will likely be a part of your own enterprise's agents. On the other hand, prompt optimization through reflection, "text gradients", or evolutionary algorithms can make more targeted improvements based on existing performance and dataset characteristics, and do so in a more token-efficient way.

3. 基于（1）和（2），我们推测：将少样本提示与指令微调相结合，可带来互补性提升。这一观点也印证了[Opsahl Ong 等人](https://arxiv.org/abs/2406.11695?ref=blog.langchain.com)及[Wan 等人](https://arxiv.org/pdf/2406.15708?ref=blog.langchain.com)等已有研究的结论。少样本示例所传递的信息量远超简单指令，但尚无法涵盖企业自研智能体中常见的**复杂条件逻辑与规则**；而另一方面，借助反思（reflection）、“文本梯度”（text gradients）或进化算法等手段开展的提示优化，则能依据当前性能表现与数据集特征，实现更具针对性的改进，且具有更高的token使用效率。

4. Meta-prompting **doesn't endow the model with new capabilities**. For the multilingual math dataset, GPT-4o-mini still didn't surpass 65% pass rate on any of the optimized configurations, largely due to reasoning errors. While the optimizers were able to instruct it on how to **behave** (which sometimes can induce better _ways_ to **think** via example reasoning trajectories), they don't unlock more powerful reasoning abilities or complex domain-specific knowledge.

4. 元提示**并不能赋予模型新的能力**。在多语言数学数据集上，GPT-4o-mini 在所有经优化的配置下，通过率均未能突破 65%，主要原因在于推理错误。尽管优化器能够指导模型如何**表现**（有时可通过示例推理路径诱导出更优的**思维方式**），但它们无法解锁更强的推理能力，也无法注入复杂的领域专属知识。

## Beyond evals

## 超越评估本身

We have been building [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) to help teams evaluate their LLM applications systematically. Good evaluation lets you detect when things go wrong and understand your system's behavior. But the datasets and metrics you build for evaluation unlock something even more valuable: the ability to improve your system systematically through optimization.

我们一直在构建 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com)，以帮助团队系统化地评估其大语言模型应用。良好的评估不仅能让你及时发现异常，还能助你深入理解系统行为。但更重要的是：你为评估所构建的数据集与指标，将释放一项更为宝贵的能力——即通过优化实现系统的系统性提升。

The datasets in our experiments worked well for optimization because they had clear, **verifiable** **outcomes**:

我们在实验中所用的数据集之所以适用于优化，是因为它们具备清晰、**可验证的** **结果**：

- Routing decisions with ground truth labels  
- Math answers that can be validated  
- Language constraints that can be programmatically checked  

- 带有真实标签（ground truth labels）的路由决策  
- 可被验证正确性的数学答案  
- 可通过程序自动校验的语言约束  

This matters because optimizing against fuzzy or unreliable metrics often makes prompts worse, not better. An LLM judging outputs based on vague criteria will optimize toward its own biases rather than your actual requirements.

这一点至关重要：若以模糊或不可靠的指标作为优化目标，往往会使提示质量下降而非提升。当大语言模型依据含糊标准评判输出时，其优化方向将偏向自身固有偏见，而非你的实际需求。

If you're tracking your application's performance in LangSmith, you're already building the foundation needed for effective prompt optimization. The same datasets that help you understand failures can drive systematic improvements. Data, metrics, and learning close the loop.

如果你已在 LangSmith 中追踪应用性能，那么你实际上已打下了高效提示优化所需的基础。那些帮你诊断失败原因的数据集，同样可以驱动系统性改进。数据、指标与学习三者闭环，形成持续演进的正向循环。

## Prompt optimization as long-term memory

## 将提示优化视作长期记忆

Optimization is learning, and as such, it can be useful to think of prompt optimization as a special case of long-term memory that captures "always-on" behavioral patterns.

优化即学习；因此，将提示优化视作一种特殊形式的长期记忆是富有启发性的——它所捕获的，正是那些“始终在线”的行为模式。

While traditional memory systems store information in databases (vector, graph, or otherwise), prompt optimization stores them directly in your agent's prompt so they are always available in context. Doing so ensures they influence every decision. This is useful for storing core patterns like behavioral rules, stylistic preferences, and key personality traits.

虽然传统记忆系统将信息存储在数据库中（向量数据库、图数据库或其他类型），但提示优化（prompt optimization）则直接将这些信息嵌入到智能体（agent）的提示词中，从而确保其始终处于上下文之内。这种方式可保证这些信息影响智能体的每一次决策。它特别适用于存储核心行为模式，例如行为规则、风格偏好以及关键人格特质。

Memory's process of "learning and improving" is **very** similar to traditional prompt optimization, just with slight differences in how updates are scheduled, and where the updates are stored. The same techniques that work for prompt optimization and learning algorithms in general may also apply to memory. This is an angle we are actively investigating.

记忆系统的“学习与改进”过程与传统的提示优化**高度相似**，仅在更新调度方式及更新内容的存储位置上存在细微差异。适用于提示优化及通用学习算法的各类技术，往往也可迁移应用于记忆系统。这正是我们当前正积极研究的方向。

## Why this matters

## 为何这至关重要

These results support what we (and others like [DSPy](https://dspy.ai/?ref=blog.langchain.com)) have observed: LLM-driven prompt optimization can systematically improve prompts and automate much of the manual guess-and-check process that dominates prompt engineering today. Making this methodology accessible to all stakeholders can help us all build better, more capable systems.

这些结果印证了我们（以及 [DSPy](https://dspy.ai/?ref=blog.langchain.com) 等同行）此前的观察：由大语言模型（LLM）驱动的提示优化，能够系统性地提升提示质量，并自动化当今提示工程中占据主导地位的手动“试错—验证”流程。若能将这一方法论普及至所有相关方，将有助于我们共同构建更优、能力更强的系统。

But it's not a silver bullet. None of our optimized prompts saturated the test sets, and the improvements varied across tasks. This suggests prompt optimization is best viewed as one tool in a broader toolkit for improving LLM applications.

但它并非万能解药。我们所优化的所有提示均未在测试集上达到性能饱和，且不同任务间的提升幅度也各不相同。这表明，提示优化应被视作一套更广泛工具箱中的一个组成部分——用于提升大语言模型应用的整体效能。

We plan to integrate these insights directly into LangSmith to help teams move beyond manual prompt engineering. The goal isn't to eliminate human judgment, but to make it more systematic and data-driven.

我们计划将这些洞见直接集成至 LangSmith 平台，助力团队摆脱纯手动的提示工程模式。其目标并非取代人类判断，而是使其更具系统性与数据支撑性。

## Reproduction

## 可复现性

You can reproduce these experiments by running the `all_sweeps.sh` script in [https://github.com/hinthornw/promptimizer/tree/wfh/blog\_experiments](https://github.com/hinthornw/promptimizer/tree/wfh/blog_experiments?ref=blog.langchain.com)

您可通过运行以下地址中的 `all_sweeps.sh` 脚本复现实验：[https://github.com/hinthornw/promptimizer/tree/wfh/blog\_experiments](https://github.com/hinthornw/promptimizer/tree/wfh/blog_experiments?ref=blog.langchain.com)

## Appendix

## 附录

### Training Dynamics

### 训练动态

In the previous sections, we primarily discussed how the _final_ prompts performed on the held-out test split.  
在前面的章节中，我们主要讨论了**最终**提示词在预留测试集上的表现。

Below, we share charts of the algorithms' training dynamics on the development split for each dataset. These charts show how different algorithms fit to the provided dataset. Comparing these charts with the final scores also reveals the extent to which the algorithms _overfit_ the data in ways that don't translate to consistent gains.  
下方，我们展示了各数据集上算法在开发集（development split）中的训练动态图表。这些图表揭示了不同算法如何拟合所提供的数据集。将这些图表与最终得分进行对比，还可进一步揭示算法在多大程度上对数据发生了**过拟合**——即其性能提升无法稳定泛化至测试集。

**Support email routing (3)**  
**客服邮件路由（3）**

Most of the optimizers consistently improved over the baseline prompt, with both gradient and evolutionary approaches showing similar gains. Claude notably outperformed GPT-4o across all approaches. Claude and 4o fail to improve much even on the dev set using the meta-prompting approach.  
大多数优化器均持续优于基线提示词；梯度法与进化法均展现出相近的提升幅度。Claude 在所有方法中均显著超越 GPT-4o。而采用元提示（meta-prompting）方法时，Claude 与 GPT-4o 即便在开发集上也几乎未见明显提升。

![](images/exploring-prompt-optimization/img_009.png)Scores on the development set over time  
![](images/exploring-prompt-optimization/img_009.png)开发集得分随时间变化曲线

**Support email routing (10)**  
**客服邮件路由（10）**

Naive GPT-4o-powered meta-prompting & meta-prompting + reflection settings fail to learn the classification rules in this dataset. We quickly are seeing a common pattern forming: if the curves stay flat, they obviously don't learn. If the curves quickly approach a perfect score, they likely overfit. It's the algorithms in the middle and with consistent improvements that tend to translate to the best test-set performance.  
基于 GPT-4o 的朴素元提示（meta-prompting）以及“元提示 + 反思”（meta-prompting + reflection）配置，均未能在此数据集中学会分类规则。我们很快观察到一种常见模式：若学习曲线长期保持平坦，则显然未发生有效学习；若曲线迅速逼近满分，则极可能已发生过拟合；而真正能在测试集上取得最佳性能的，往往是那些处于中间区间、且呈现**持续稳定提升**的算法。

![](images/exploring-prompt-optimization/img_010.png)  
![](images/exploring-prompt-optimization/img_010.png)

**Multilingual math**  
**多语言数学题**

This dataset was perhaps the most **discontinuous**, as shown by the dev set performance getting most of its improvements in epochs 2, 3 (or even later) for a few of the settings. This also highlights the usefulness of tracking the **edit history** beyond the last attempt or two. LLMs are fairly useful meta-optimizers by being able to translate the history of edits into more effective updates.  
该数据集或许是**最不连续**的一个：部分配置下，开发集性能的大部分提升都出现在第 2 轮、第 3 轮（甚至更晚）迭代中。这也凸显了追踪**编辑历史**（而非仅最后一两次尝试）的重要价值。大语言模型作为元优化器颇具实用性——它们能将编辑历史转化为更有效的参数更新。

![](images/exploring-prompt-optimization/img_011.png)  
![](images/exploring-prompt-optimization/img_011.png)

**Email assistant simple**

**邮件助手（简洁版）**

Here again we see that the prompt optimization setting (gpt-4o + metaprompting + reflect) that achieves the highest performance on the dev split doesn't actually translate to good performance on the test split.

此处我们再次观察到：在开发集（dev split）上性能最优的提示词优化配置（gpt-4o + 元提示 + 反思机制），实际上并未在测试集（test split）上带来良好的泛化性能。

![](images/exploring-prompt-optimization/img_012.png)

**Email assistant eccentric**

**邮件助手（另类版）**

Though the Claude+evolutionary algorithm setting earned the highest test-split performance, we see that the algorithms that fit the dev set the fastest (and most) were those powered by O1. The o1-evolutionary setting fit the dataset the fastest, despite ultimately failing to significantly improve the quality of the system on the test set. On the other side, settings that don't fit the dev set also fail to improve the prompt significantly on the test set (above).

尽管 Claude + 进化算法组合在测试集上取得了最高性能，但我们发现：在开发集上拟合速度最快（且拟合程度最高）的算法，反而是由 O1 驱动的那些。其中，“O1 + 进化算法”配置拟合开发集的速度最快，但最终却未能显著提升系统在测试集上的质量。另一方面，那些无法有效拟合开发集的配置，同样也未能在测试集上对提示词实现显著改进（如上图所示）。

![](images/exploring-prompt-optimization/img_013.png)

### Comparing Prompts

### 提示词对比分析

While we ultimately care more about the downstream metrics than the exact content of the prompt, it can be illustrative to review the final prompts to see _what_ the optimizers actually learn to modify, and what changes lead to improvements. We will take the Support 10-way classification dataset as an example. First, comparing the four algorithms when driven by Sonnet

尽管我们最终更关注下游任务指标，而非提示词的具体文本内容，但回顾最终生成的提示词仍具启发意义——它能帮助我们理解：优化器实际学会了修改哪些部分？哪些改动真正带来了性能提升？我们将以 Support 10 分类数据集为例进行说明。首先，比较由 Sonnet 驱动的四种算法所生成的提示词：

![](images/exploring-prompt-optimization/img_014.png)

![](images/exploring-prompt-optimization/img_015.png)

![](images/exploring-prompt-optimization/img_016.png)

![](images/exploring-prompt-optimization/img_017.png)

全部四种算法均能学习到主要的分配规则。基于梯度的方法在识别模糊区域以厘清边界方面，稳健性似乎较弱；而其他算法则倾向于识别“优先级规则”，或自行构建决策树，以帮助明确这些边界。

在相同算法下对比不同优化器模型，还可观察到行为上的细微差异。本例中，O1 更倾向于创造性地融合多种技术（如合成的少样本示例与分步指令），且习惯在其规则集之间使用其标志性分隔符（“—”）；Claude 则在此场景下显得最为简洁直接；但二者均能学习到优先级规则及领域映射关系。GPT-4o 生成的指令信息密度则相对最低。

![](images/exploring-prompt-optimization/img_018.png)

![](images/exploring-prompt-optimization/img_019.png)

![](images/exploring-prompt-optimization/img_020.png)
&#123;% endraw %}
