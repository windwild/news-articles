---
title: "The engineering challenges of scaling interpretability"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/engineering-challenges-interpretability"
date: "2024-06-13"
scraped_at: "2026-03-03T07:09:43.558912723+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
---
{% raw %}

Interpretability

可解释性

# The engineering challenges of scaling interpretability

# 扩展可解释性研究的工程挑战

Jun 13, 2024

2024 年 6 月 13 日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

_In this post, and in the above roundtable video, our researchers reflect on the close relationship between scientific and engineering progress, and discuss the technical challenges they encountered in scaling our interpretability research to much larger AI models._

_在本文及上方的圆桌讨论视频中，我们的研究人员反思了科学进步与工程进步之间密不可分的关系，并探讨了在将可解释性研究扩展至更大规模 AI 模型过程中所遇到的技术挑战。_

Last October, the Anthropic Interpretability team published [Towards Monosemanticity](https://transformer-circuits.pub/2023/monosemantic-features), a paper applying the technique of dictionary learning to a small transformer model. In May this year, we published [Scaling Monosemanticity](https://transformer-circuits.pub/2024/scaling-monosemanticity/), where we applied the same technique to a model several orders of magnitude larger. We found tens of millions of “features”—combinations of neurons that relate to semantic concepts—in Claude 3 Sonnet, representing an important step forward in understanding the inner workings of AI models.

去年 10 月，Anthropic 可解释性团队发表了论文《迈向单义性》（[Towards Monosemanticity](https://transformer-circuits.pub/2023/monosemantic-features)），将字典学习（dictionary learning）技术应用于一个小型 Transformer 模型。今年 5 月，我们发布了新论文《扩展单义性》（[Scaling Monosemanticity](https://transformer-circuits.pub/2024/scaling-monosemanticity/)），将同一技术应用于规模大好几个数量级的模型。我们在 Claude 3 Sonnet 中识别出数千万个“特征”——即与语义概念相关的神经元组合，这标志着我们对 AI 模型内部工作机制的理解迈出了重要一步。

To continue making this progress, we need more engineers.

要持续推进这一进展，我们需要更多工程师。

This might seem surprising if you've only read our early papers (for example [Frameworks](https://transformer-circuits.pub/2021/framework/index.html) and [Toy Models of Superposition](https://transformer-circuits.pub/2022/toy_model/index.html)), which required relatively little engineering. But reading the newer research should make clear the scale of the engineering challenge we face.

如果你仅阅读过我们早期的论文（例如 [Frameworks](https://transformer-circuits.pub/2021/framework/index.html) 和 [Toy Models of Superposition](https://transformer-circuits.pub/2022/toy_model/index.html)），这或许会令人惊讶——这些工作对工程实现的要求相对较低。但阅读我们近期的研究成果，便能清晰认识到当前所面临的工程挑战之巨大。

Below, we share two examples of the technical engineering questions that were involved in our latest research. These illustrate the kinds of problems our engineers are tackling right now, and help explain why we think engineering will be one of the major bottlenecks to progress in AI interpretability—and ultimately, AI safety—research.

下文，我们将分享两项最新研究中涉及的关键工程技术问题。这些问题生动展现了我们工程师当前正在攻克的实际难题，也解释了为何我们认为工程能力将成为推进 AI 可解释性研究——乃至最终推动 AI 安全研究——的主要瓶颈之一。

If you're an engineer, this post is aimed at you. If you’re inspired by the examples of engineering problems discussed below, we strongly encourage you to apply for our [Research Engineer role](https://boards.greenhouse.io/anthropic/jobs/4020305008).

如果你是一名工程师，那么这篇文章正是为你而写。如果你被下文所列举的工程问题所启发，我们诚挚邀请你申请我们的 [Research Engineer 岗位](https://boards.greenhouse.io/anthropic/jobs/4020305008)。

## Engineering Problem 1: Distributed Shuffle

## 工程问题 1：分布式数据洗牌（Distributed Shuffle）

Our Sparse Autoencoders—the tools we use to investigate “features”—are trained on the activations of transformers, and those activations need to be shuffled to stop them from learning spurious, order-dependent patterns. When we first started training sparse autoencoders, we could fit our training data on a single GPU and trivially shuffle it. But eventually, we wanted to scale beyond what could fit in memory (imagine starting with the easy task of shuffling a deck of cards, but then scaling it up to shuffling entire warehouses full of cards — it’s a much more difficult problem).

我们所使用的稀疏自编码器（Sparse Autoencoders）——即用于探究“特征”（features）的核心工具——是在 Transformer 模型的激活值（activations）上进行训练的；而这些激活值必须经过洗牌（shuffle），以防止模型学到虚假的、依赖于数据顺序的模式。最初训练稀疏自编码器时，全部训练数据尚可装入单块 GPU 显存，因此洗牌操作轻而易举。但随着研究深入，我们很快希望突破内存容量限制（不妨类比：起初只是洗一副扑克牌，后来却要洗满整个仓库的扑克牌——难度已不可同日而语）。

At this point, we could have implemented a distributed shuffle that scaled to petabytes. Instead, we decided on an approach we could implement quickly, but which didn't scale as well. We split our shuffle into _K_ jobs where each job was responsible for 1/ _K_ of the shuffled output data. We generated a permutation, had each job do a streaming read of all of the training data, and then had it write out its share of the output. This allowed us to scale further, but the downside was obvious: each job had to read all of the training data. This first took hours, and later took days. By the time we were working on [Towards Monosemanticity](https://transformer-circuits.pub/2023/monosemantic-features/index.html), we had 100TB of training data (100 billion data points, each being 1KB) and shuffling had become a major headache.

此时，我们本可实现一种可扩展至 PB 级别的分布式洗牌方案。但我们选择了一种开发周期更短、却扩展性较弱的替代方案：将洗牌任务拆分为 _K_ 个并行作业（jobs），每个作业负责生成最终洗牌结果中 1/_K_ 的数据。具体而言，我们先生成一个全局排列（permutation），再让每个作业流式读取全部训练数据，并仅写出其对应份额的输出。该方案确实帮助我们实现了进一步扩展，但缺陷显而易见：每个作业都必须完整读取全部训练数据。起初耗时数小时，后期则延长至数天。待我们开展 [Towards Monosemanticity](https://transformer-circuits.pub/2023/monosemantic-features/index.html) 项目时，训练数据已达 100 TB（共 1000 亿条样本，每条 1 KB），洗牌操作已然成为一大痛点。

Performing a distributed shuffle that scales isn’t a novel or cutting-edge problem. But it was just one of many engineering problems we had to solve quickly to make scientific progress.

实现可扩展的分布式洗牌并非前沿或新颖的课题。但它只是我们在推进科学研究过程中亟需快速解决的诸多工程问题之一。

In this case, we found a [helpful blog post](https://blog.janestreet.com/how-to-shuffle-a-big-dataset/) and extended the approach to many passes. For one pass, we have _N_ jobs. Each job reads 1/ _N_ of the dataset, shuffles it, and writes out the data in K files each with 1/ _NK_ of the data. The contents of the first file written from each job represent the first 1/ _K_ of the final shuffled data, but it still needs to be shuffled. It’s the same for the second file, and so on. In one pass, we have reduced one shuffle of all the data to _N_ shuffles, each _K_ times smaller. Now, if the shuffles fit in memory on a single machine, we can shuffle it and we’re done. If they don’t fit, we can just run another pass.

在此情形下，我们参考了一篇[极具启发性的博客文章](https://blog.janestreet.com/how-to-shuffle-a-big-dataset/)，并将其方法拓展为多轮（multi-pass）实现。在单轮中，我们启动 _N_ 个作业：每个作业读取数据集的 1/_N_，完成本地洗牌后，将结果写入 _K_ 个文件，每个文件包含总数据量的 1/(_N_×_K_)。来自各作业的第一个输出文件共同构成最终洗牌结果的前 1/_K_，但仍需进一步洗牌；第二个文件同理，依此类推。因此，单轮操作便将一次全量数据洗牌，分解为 _N_ 次规模缩小 _K_ 倍的子洗牌。若这些子洗牌可完全载入单机内存，即可直接完成；否则，只需再执行一轮。

Let’s say each job can keep 100GB of data in memory, and we write one hundred 1GB files. Each pass reduces the size of the shuffles needed by 100 times. One pass can shuffle 100GB of data, two passes can shuffle 10TB, three passes 1PB, four passes 100PB, and so on.

假设每个作业可在内存中容纳 100 GB 数据，并写入一百个大小为 1 GB 的文件，则每轮操作可将所需洗牌的数据量压缩 100 倍：一轮可处理 100 GB，两轮达 10 TB，三轮达 1 PB，四轮达 100 PB，以此类推。

Since we implemented this approach, we’ve stopped thinking about shuffling. Now it’s something that happens quickly, without issues. There are certainly better approaches and faster implementations than ours. But this approach solves our bottleneck, and frees us up to tackle the next problem.

自从采用这一方案以来，我们已不再为洗牌操作费神——它如今总能快速、稳定地完成。当然，业界必然存在更优、更快的实现方式。但对我们而言，这一方案已成功消除了关键瓶颈，使我们得以腾出精力，全力攻克下一个难题。

## Engineering Problem 2: Feature Visualization Pipeline

## 工程问题 2：特征可视化流水线

Another engineering challenge has been generating the underlying data for our feature visualizations, which allow users to see specific tokens that are most strongly activated as part of individual features, along with other information ( [see the Feature Browser from the Towards Monosemanticity paper at this link](https://transformer-circuits.pub/2023/monosemantic-features/vis/a1.html)).

另一个工程挑战在于生成特征可视化所需的底层数据。这些可视化使用户能够观察在各个特征中激活程度最强的具体 token，以及其它相关信息（[参见《迈向单义性》（Towards Monosemanticity）论文中的“特征浏览器”（Feature Browser），链接如下](https://transformer-circuits.pub/2023/monosemantic-features/vis/a1.html)）。

For each feature, we want to find a variety of dataset examples that activate it to different levels, exploring its full distribution. Doing this efficiently for millions of features is an interesting distributed systems problem. Originally, all of this ran in a single job – but we quickly scaled beyond that. Below is a sketch of our current approach.

对于每个特征，我们希望找到一批能以不同强度激活该特征的数据集样本，从而全面覆盖其激活分布。对数百万个特征高效完成这一任务，是一个颇具挑战性的分布式系统问题。最初，全部流程都在单个作业中运行——但很快我们就超出了该方案的承载能力。以下是当前方案的概要设计。

Our dataset for visualization is 100M tokens, and we need to handle millions of features. First we “shard” over the dataset and features, splitting them into many different parts. Each job iterates over its slice of the dataset and, for its slice of features, keeps track of the _K_ highest activating tokens for each feature and 10\* _K_ random tokens that activate the feature (we have already cached the transformer activations in s3, so we don’t need to recompute them).

我们的可视化数据集包含 1 亿（100M）个 token，且需处理数百万个特征。首先，我们对数据集和特征进行“分片”（sharding），将其切分为大量子集。每个作业遍历其对应的数据集片段，并针对其负责的特征子集，为每个特征分别记录激活值最高的 _K_ 个 token，以及另外 10 × _K_ 个随机选取的、能激活该特征的 token（我们已将 Transformer 的中间激活值缓存至 S3，因此无需重复计算）。

Next, we shard over the features and aggregate the results from the previous pass. This gives us the highest-activating tokens for each feature across the entire dataset, as well as a random set of tokens that activate the feature. These are the examples we’ll show in the feature visualization.

接下来，我们按特征进行分片，并聚合上一轮的结果。由此可获得每个特征在整个数据集上的最高激活 token，以及一组随机选取的、能激活该特征的 token。这些即为将在特征可视化界面中展示的样本。

For each of these examples, we need to calculate how the feature fires on surrounding tokens. Our first approach sharded over features. Each job loads the transformer activations for the examples of the features for which it’s responsible. The problem is that these examples are randomly distributed across the dataset: there’s no easy way to read _only_ the data the job needs.

对于上述每个样本，我们还需计算该特征在邻近 token 上的激活情况。我们最初的方案是按特征分片：每个作业加载其所负责特征对应样本的 Transformer 激活值。问题在于，这些样本在数据集中是随机分布的——无法便捷地仅读取该作业所需的数据。

To improve this, we added a pass sharded over the dataset. In this setup, each job handles a slice of transformer activations, and saves the activations needed for each group of features to a separate file. Then, we can run a pass over features and have easy access to just the data we need. We compute how much the feature fires on surrounding tokens, then write out all the relevant data in a format our frontend website can read and display.

为改进这一点，我们新增了一轮按数据集分片的处理流程。在此架构下，每个作业负责处理一部分 Transformer 激活值，并将每组特征所需的相关激活值分别保存至独立文件中。随后，我们再执行一轮按特征分片的处理流程，即可便捷地访问仅需的数据。我们据此计算特征在周围 token 上的激活强度，并将所有相关数据以前端网站可直接读取与渲染的格式输出。

## What we’re looking for

## 我们正在寻找什么

When we started working on Sparse Autoencoders, we didn’t know if the approach would work. The more experiments we ran, the more confident we became in our research. That led us to invest more in our infrastructure so we could run larger experiments. The process continued all the way to [Scaling Monosemanticity](https://transformer-circuits.pub/2024/scaling-monosemanticity/), our most recent paper.

当我们刚开始研究稀疏自编码器（Sparse Autoencoders）时，尚不确定该方法是否可行。随着实验不断推进，我们对自身研究的信心也日益增强。这促使我们加大对基础设施的投入，以支持更大规模的实验。这一过程持续演进，直至我们最新发表的论文——[《扩展单义性》（Scaling Monosemanticity）](https://transformer-circuits.pub/2024/scaling-monosemanticity/)。

That process points to the type of engineering work we do on the Interpretability team — and the fact that we consider research and engineering to be inseparable. Often, our team members will switch back and forth between research and engineering, squeezing more scale out of our current system to launch a new experiment before returning to the research. Since many research ideas don’t work out, we don’t invest more heavily in their infrastructure until we see success.

这一过程正体现了可解释性（Interpretability）团队所从事的工程工作类型——我们始终认为，研究与工程密不可分。团队成员常常在研究与工程之间灵活切换：先通过工程优化，从现有系统中进一步挖掘扩展潜力，以支撑新实验的启动；待实验初步验证后，再回归深入研究。由于许多研究构想最终未能奏效，我们不会过早为其基础设施投入重资，而是在取得明确进展或成功之后，才加大相应投入。

Research is a team effort, and it's as much about implementing ideas as it is ruminating on them. We don’t just hypothesize; we test, build, iterate, and scale.

研究是一项团队协作的工作，它既关乎对想法的深入思考，也同等程度地关乎将想法付诸实践。我们不仅提出假设，更会进行实验验证、构建原型、持续迭代，并最终实现规模化落地。

Because of this, we’re particularly interested in hiring generalist engineers who are able to work flexibly across different domains — whether that’s building pipelines, running ML experiments, or optimizing GPU usage.

正因如此，我们尤其希望招聘具备广泛能力的通才型工程师——他们能够灵活地跨越不同技术领域开展工作，无论是构建数据处理流水线、运行机器学习实验，还是优化 GPU 资源使用效率。

If you’re an engineer who fits this bill, and who is passionate about AI safety, we’d love to see your application. Take a look at the job description for our [Research Engineer role](https://boards.greenhouse.io/anthropic/jobs/4020305008), and at our [Careers page](https://www.anthropic.com/careers) for several other open roles on the Interpretability team.

如果您正是一位符合上述特质的工程师，且对 AI 安全抱有热忱，我们诚挚期待您的申请。欢迎查阅我们 [研究工程师（Research Engineer）职位](https://boards.greenhouse.io/anthropic/jobs/4020305008) 的详细说明，或访问我们的 [招聘页面](https://www.anthropic.com/careers)，了解可解释性（Interpretability）团队目前开放的其他多个职位。

## FAQ

## 常见问题（FAQ）

1. **How many roles are you hiring for?** There are currently 18 members of the Interpretability team, and we're growing quickly. Currently we’re looking to hire at least five senior engineers and two team managers, across multiple locations. See our [Careers page](https://www.anthropic.com/careers) for the listings.

1. **本次招聘多少个岗位？** 目前可解释性团队共有 18 名成员，且团队正处于快速发展阶段。现阶段，我们计划在多个办公地点至少招聘五名高级工程师和两名团队主管。具体职位信息请参阅我们的 [招聘页面](https://www.anthropic.com/careers)。

2. **Does the Interpretability team work with other teams?** Yes. We collaborate strongly with our other research teams (especially the Alignment team). Anthropic is a “team-science” org, and the borders between teams are porous in the best ways — this allows us to get a lot done quickly.

2. **可解释性团队是否会与其他团队协作？** 是的。我们与公司内其他研究团队（尤其是对齐团队，Alignment team）保持紧密合作。Anthropic 是一家奉行“团队科学”（team-science）理念的组织，各团队之间的边界在最佳意义上是开放而互通的——这使我们能够高效推进大量工作。

3. **How do you choose projects to work on?** We think about our research roadmap in terms of Anthropic’s [Responsible Scaling Policy](https://www.anthropic.com/news/anthropics-responsible-scaling-policy), which commits the company to hitting various safety milestones before developing or deploying models above corresponding capability levels. In thinking about research directions, we consider what the research landscape of interpretability looks like, what problems we’re in a position to address, and how the Interpretability team’s work could impact those safety milestones. On a day-to-day level, our research tends to be very exploratory, but it’s an exploration that’s guided by the above considerations.

3. **项目选题是如何确定的？** 我们依据 Anthropic 的 [负责任扩展政策（Responsible Scaling Policy）](https://www.anthropic.com/news/anthropics-responsible-scaling-policy) 来规划研究路线图。该政策承诺：在开发或部署能力水平超过特定阈值的模型之前，公司必须率先达成一系列关键安全里程碑。在确定研究方向时，我们会综合评估当前可解释性领域的研究现状、我们自身具备解决能力的具体问题，以及可解释性团队的研究成果如何切实推动上述安全里程碑的达成。在日常工作中，我们的研究通常具有高度探索性，但这种探索始终以以上考量为指导原则。

4. **What kinds of backgrounds do people on the Interpretability team have?** People have come to the Interpretability team from a wide range of professional backgrounds, including neuroscience, mathematics, biology, physics, data visualization, and software engineering.

4. **可解释性团队成员具有哪些专业背景？** 团队成员来自极为多元的专业领域，包括神经科学、数学、生物学、物理学、数据可视化以及软件工程等。

5. **Are you open to candidates outside of the Bay Area?** The team currently has members in San Francisco, Boston, New York, Seattle, and London. The largest concentration is in San Francisco, and those members come into the office several days a week. We are open to remote working, with a requirement to visit an Anthropic office about 25% of the year. See our [Careers page](https://www.anthropic.com/careers) for more information about all our open positions.

5. **是否接受旧金山湾区以外地区的候选人？** 目前团队成员分布于旧金山、波士顿、纽约、西雅图和伦敦等地。其中人数最集中的办公地点是旧金山，当地成员每周需到办公室办公数天。我们支持远程办公，但要求员工每年约 25% 的工作时间需在 Anthropic 办公室现场办公。有关所有开放职位的更多信息，请参阅我们的 [招聘页面](https://www.anthropic.com/careers)。
{% endraw %}
