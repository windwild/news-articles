---
title: "How Dosu Used LangSmith to Achieve a 30% Accuracy Improvement with No Prompt Engineering"
source: "LangChain Blog"
url: "https://blog.langchain.com/dosu-langsmith-no-prompt-eng/"
date: "2024-06-07"
scraped_at: "2026-03-03T08:01:41.656946204+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

**_Editor's Note: the following is authored by Devin Stein, CEO of_** [**_Dosu_**](https://dosu.dev/?ref=blog.langchain.dev) **_. In this blog we walk through how Dosu uses LangSmith to improve the performance of their application - with NO prompt engineering. Rather, they collected feedback from their users, transformed that into few shot examples, and then fed that back into their application._**

**编者按：以下内容由** [**Dosu**](https://dosu.dev/?ref=blog.langchain.dev) **首席执行官 Devin Stein 撰写。本文将详细介绍 Dosu 如何利用 LangSmith 提升其应用性能——全程无需提示词工程（prompt engineering）。具体而言，他们收集了用户反馈，将其转化为少量示例（few-shot examples），再将这些示例重新注入自身应用中。**

**_This is a relatively simple and general technique that can lead to automatic performance improvements. We've written up a_** [**_LangSmith cookbook_**](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com) **_to let anyone get started with continual in-context learning for classification! If learning from videos is more your style, check out our YouTube walkthrough_** [**_here_**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com) **_._**

**这是一种相对简单且普适的技术，可实现自动化的性能提升。我们已编写了一份** [**LangSmith 实战指南（cookbook）**](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com) **，帮助任何人快速上手面向分类任务的持续上下文学习（continual in-context learning）！如果你更习惯通过视频学习，欢迎观看我们在 YouTube 上的详细操作演示** [**此处**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com) **。**

- [**_YouTube Walkthrough_**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com)  
- [**YouTube 操作演示**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com)  
- [**_LangSmith cookbook_**](https://docs.smith.langchain.com/tutorials/Developers/optimize_classifier?ref=blog.langchain.com)  
- [**LangSmith 实战指南**](https://docs.smith.langchain.com/tutorials/Developers/optimize_classifier?ref=blog.langchain.com)  

There are many techniques for “teaching” LLMs to improve their performance on specific tasks. The most common are:

提升大语言模型（LLM）在特定任务上表现的方法多种多样，其中最常见的是以下三种：

1. Prompt Engineering  
1. 提示词工程（Prompt Engineering）  
2. Fine-Tuning  
2. 微调（Fine-Tuning）  
3. In-Context Learning  
3. 上下文学习（In-Context Learning）  

Prompt engineering is the easiest and most common approach to help LLMs learn, but Dosu takes a different approach. Our team is _not using_ prompt engineering, and we see significantly better results.

提示词工程是最简单、也最常用的辅助 LLM 学习的方式；但 Dosu 选择了另一条路径。我们的团队**并未采用提示词工程**，却取得了显著更优的效果。

### **Dosu is an Engineering Teammate who Learns**

### **Dosu：一位会持续学习的工程团队成员**

Dosu is an engineering teammate that acts as the first line of defense for ad-hoc engineering requests, protecting engineers from unnecessary interruptions and unblocking GTM teams. We intentionally use the word “teammate” rather than copilot or assistant because, like a teammate, Dosu should learn the nuances and workflows specific to your organization.

Dosu 是一位工程团队成员，专为应对临时性工程需求而设，是工程师的第一道防线：它能有效屏蔽非必要干扰，并为市场与销售（GTM）团队扫清障碍、加速推进。我们特意使用“team-mate（团队成员）”而非“copilot（副驾驶）”或“assistant（助手）”一词——因为正如真实队友一样，Dosu 应当主动学习并掌握贵组织特有的工作细节与流程规范。

If you haven’t heard of Dosu, you can check out our [previous blog post](https://blog.dosu.dev/iterating-towards-llm-reliability-with-evaluation-driven-development/?ref=blog.langchain.com) or see [these examples](https://go.dosu.dev/reviews?ref=blog.langchain.com). At its core, Dosu automates the work engineers don’t want to do. A simple example of this is labeling. Very few engineers want to spend their time managing labels on tickets and PRs (if you’re reading this and you DO like this..we are [hiring](https://dosu.dev/careers?ref=blog.langchain.com) 😉), however, having consistent, high-quality labels is important! Labels allow engineering teams to search, understand, and optimize where they are spending their time. If you’re skeptical, watch this recent [KubeCon talk](https://www.youtube.com/watch?v=JZ9LQR_j0Rk&ref=blog.langchain.com) by the legendary Kubernetes maintainer [MyBobbyTables](https://twitter.com/MrBobbyTables?ref=blog.langchain.com), explaining why labeling is critical to engineering productivity.

若您尚未了解 Dosu，欢迎查阅我们此前的[博客文章](https://blog.dosu.dev/iterating-towards-llm-reliability-with-evaluation-driven-development/?ref=blog.langchain.com)，或浏览这些[实际案例](https://go.dosu.dev/reviews?ref=blog.langchain.com)。本质上，Dosu 的使命是自动化完成工程师不愿亲力亲为的工作。一个典型例子便是“打标签（labeling）”：极少有工程师愿意将宝贵时间耗费在工单（ticket）和代码合并请求（PR）的标签管理上（如果您正在阅读本文且恰恰热爱这项工作……我们正在[招聘](https://dosu.dev/careers?ref=blog.langchain.com) 😉）；然而，统一、高质量的标签体系至关重要！它使工程团队得以高效检索、深入理解并持续优化自身时间投入的方向。若您仍持怀疑态度，不妨观看传奇 Kubernetes 维护者 [MyBobbyTables](https://twitter.com/MrBobbyTables?ref=blog.langchain.com) 在近期 [KubeCon 大会](https://www.youtube.com/watch?v=JZ9LQR_j0Rk&ref=blog.langchain.com) 上的精彩分享，他深入阐释了为何标签管理对工程效能具有决定性意义。

Dosu automatically labels tickets for you, so you get all the benefits without the work. Sounds great, right? But to be useful Dosu has to be correct. Incorrect labels can cause more work than having no labels at all. On the surface, labeling seems like a straightforward task; however, in practice, labels are often subjective and unique to an organization. For example, the enhancement label at LangChain is about a net-new library feature or integration, whereas, the same enhancement label at Dosu is exclusively for improvements to existing functionality. To do its job, Dosu needs to learn the meaning and rules for labels specific to each organization. So how can we teach Dosu to do this?

Dosu 可自动为您完成工单打标，让您坐享全部收益，却无需付出任何人工成本——听上去很棒，对吧？但要真正发挥作用，Dosu 的标注结果必须准确可靠。错误的标签所引发的后续工作量，甚至可能远超完全不打标签的情况。表面上看，“打标签”似乎是一项直白简单的任务；但在实践中，标签的定义往往具有主观性，且高度依赖于组织自身的语境。例如，“enhancement（增强）”这一标签在 LangChain 中指代全新库功能或集成；而在 Dosu 内部，它则严格限定于对既有功能的改进优化。因此，Dosu 必须学会理解并掌握每一家客户组织专属的标签语义与使用规则。那么，我们该如何教会 Dosu 做到这一点呢？

### **Prompt Engineering within Products Leads to Poor UX**

### **在产品中要求用户进行提示工程会导致糟糕的用户体验**

Although prompt engineering can make a big difference in performance for LLMs, Dosu is more than an LLM. It’s a product. The magic of LLMs comes from those moments when they “just work.” We think putting the burden of prompt engineering on users reduces that magic and leads to an unreliable product experience. To be more specific:

尽管提示工程可显著提升大语言模型（LLM）的性能，但 Dosu 并不仅仅是一个 LLM——它是一款产品。LLM 的魔力正源于那些“开箱即用、自然奏效”的瞬间。我们认为，将提示工程的负担转嫁给用户，会削弱这种魔力，并导致产品体验不可靠。具体而言：

- **Prompts are finicky.** We cannot guarantee a reliable product experience if the product depends on a user’s ability to prompt engineer.  
- **提示极为敏感脆弱。** 若产品的可靠性依赖于用户自行完成提示工程，我们就无法保障稳定可靠的产品体验。

- **Prompts are model-dependent.** We want Dosu to use the best LLM for any given task. We don’t want internal LLM changes to break a prompt that a user spent hours crafting.  
- **提示高度依赖具体模型。** 我们希望 Dosu 能为任意任务自动选用最合适的 LLM；我们不希望内部 LLM 的迭代升级，导致用户耗费数小时精心编写的提示失效。

- **Prompts are static.** Organizations are constantly changing. Hard-coded logic in prompts can become stale and incorrect quickly.  
- **提示是静态的。** 组织自身持续演进，而提示中硬编码的逻辑极易迅速过时甚至出错。

### **Fine-tuned Models are Complex to Manage and Susceptible to Data Drift**

### **微调模型管理复杂，且易受数据漂移影响**

If prompt engineering is off the table, what about fine-tuning? Dosu has enough traffic that collecting a fine-tuning dataset is relatively straightforward, but fine-tuning comes with a few deal-breaking drawbacks:

若排除提示工程，那微调（fine-tuning）是否可行？Dosu 拥有足够高的使用量，收集微调所需的数据集相对容易；但微调本身存在若干难以接受的缺陷：

- **Fine-tuned models are complex to manage.** If we need to fine-tune models for N customers, we have N different models that we need to serve, retrain, and monitor. This is solvable but time-consuming.  
- **微调模型管理极为复杂。** 若需为 N 个客户分别微调模型，我们就必须部署、重训练并持续监控 N 个彼此独立的模型——技术上可行，但耗时巨大。

- **Fine-tuned models are static.** Similar to prompts, fine-tuned models are fixed to a point in time. Organizations change, causing fine-tuned model performance to degrade in unexpected ways due to data drift.  
- **微调模型是静态的。** 与提示类似，微调模型也固化于某一时间点。随着组织持续变化，其数据分布发生偏移（data drift），导致微调模型性能以不可预知的方式下降。

It’s important to highlight that these trade-offs are specifically for tasks where the expected output varies based on each organization. For tasks with the same expected output across all organizations, like input classification, fine-tuning is a perfect solution to optimize performance.

需要特别强调的是：上述权衡仅适用于**输出预期因组织而异的任务**。而对于所有组织均具有相同预期输出的任务（例如输入分类），微调则是优化性能的理想方案。

### **Static In-Context Learning is also Susceptible to Data Drift**

### **静态的上下文内学习同样易受数据漂移影响**

That leaves us with in-context learning, also known as few-shot learning. As a refresher, in-context learning is a technique where the LLM prompt includes example input/output pairs for a given task. In-context learning is simple but effective. It can be so effective that libraries like [DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com), which finds the optimal few-shot examples for you, can improve performance by as much as [65%](https://arxiv.org/pdf/2310.03714?ref=blog.langchain.com).

至此，我们只剩下上下文内学习（in-context learning），即常说的“少样本学习”（few-shot learning）。简要回顾：上下文内学习是一种在 LLM 提示中嵌入特定任务的输入/输出示例对的技术。该方法简单却高效——高效到诸如 [DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) 这类可自动为您筛选最优少样本示例的库，甚至能将性能提升高达 [65%](https://arxiv.org/pdf/2310.03714?ref=blog.langchain.com)。

From a product perspective, there is a lot to like about in-context learning. When Dosu is wrong, users often correct it. This naturally creates an input/output example for in-context learning, meaning users can teach Dosu without knowing anything about LLMs.

从产品视角看，上下文内学习具备诸多优势：当 Dosu 给出错误回答时，用户常会主动纠正——这天然生成了一组可用于上下文内学习的输入/输出示例，意味着用户无需了解任何 LLM 相关知识，即可“教会” Dosu。

Operationally, in-context learning reduces prompt complexity and decreases switching costs to change LLMs. By relying on examples to demonstrate common failure modes and edge cases to the LLM, we avoid crafting brittle, complex prompts that are optimized for a particular LLM.

从运行层面看，在上下文中学习（in-context learning）降低了提示词的复杂度，并减少了更换大语言模型（LLM）的切换成本。通过向 LLM 提供示例来展示常见失效模式和边界情况，我们得以避免编写那些针对特定 LLM 过度优化、脆弱且复杂的提示词。

Although in-context learning gets us what we want from a product perspective, most references to in-context learning in papers rely on static examples and are still susceptible to data-drift. As discussed, organizations are dynamic, and we need Dosu to adapt to their changes.

尽管从产品角度看，在上下文中学习能满足我们的需求，但论文中提及的大多数“在上下文中学习”方法均依赖静态示例，因而仍易受数据漂移（data drift）影响。如前所述，组织是动态演进的，我们需要 Dosu 能够随之持续适应其变化。

## **Continual In-Context Learning is Simple and Effective**

## **持续式在上下文中学习：简洁而高效**

An elegant part of in-context learning is there is only one variable to adjust: the examples.

在上下文中学习的一大精妙之处在于：它仅需调节一个变量——即示例（examples）。

To teach Dosu about the particulars of an organization, all we need to do is pick the optimal examples for that organization for a given task at a given time.

要让 Dosu 掌握某一组织的具体特征，我们只需在特定时间、针对特定任务，为其挑选出对该组织最适配的示例即可。

Before we can choose the best examples, we need to collect them. As mentioned earlier, when users correct Dosu, we save their corrections as an example for that task and then associate it with the user’s organization. We store all of these examples in a database that we refer to as an _example store_ (akin to a traditional ML feature store).

在选定最优示例之前，我们必须先收集它们。如前所述，当用户对 Dosu 的输出进行修正时，我们将这些修正结果保存为该任务的一个示例，并将其与对应用户的组织关联起来。所有此类示例均被存入一个我们称之为“示例库”（_example store_）的数据库中（其作用类似于传统机器学习中的特征库，feature store）。

Now, whenever Dosu is going to complete a task, we can search our example store to find the most relevant examples. This transforms our learning problem into a retrieval problem, similar to what we already do in RAG.

如今，每当 Dosu 即将执行一项任务时，我们便可检索示例库，以找出与当前任务最相关的示例。这便将原本的学习问题转化为了一个检索问题——其思路与我们在 RAG（检索增强生成）中已采用的方法高度一致。

And, that’s it. The final continual in-context learning flow is conceptually simple:

如此而已。最终形成的持续式在上下文中学习流程，在概念上极为简洁：

1. Collect corrections from users and save them to an example store  
   1. 收集用户修正内容，并将其存入示例库；

2. At inference time, search the example store and try to find the optimal examples for the current input  
   2. 在推理阶段，检索示例库，尝试为当前输入找到最优示例；

3. Repeat  
   3. 循环往复。

The end result gives us exactly what we were looking for: a natural way for Dosu to learn about an organization and adapt to its changes over time.

最终效果正契合我们的初衷：为 Dosu 提供一种自然的方式，使其能够持续学习并适应组织的演进与变化。

## **Implementing Continual Learning with LangSmith**

## **使用 LangSmith 实现持续学习**

At Dosu, we’ve been long-time users of LangSmith. When we decided on continual in-context learning as the direction for teaching Dosu about organizations, we looked to see if we could implement it with existing tools. Fortunately, LangSmith has all the building blocks to easily implement continual learning.

在 Dosu，我们长期使用 LangSmith。当我们决定采用持续上下文学习（continual in-context learning）作为向 Dosu 教授组织知识的方向时，我们评估了是否能利用现有工具实现该方案。幸运的是，LangSmith 提供了所有必要组件，可轻松实现持续学习。

For collecting corrections, LangSmith allows you to attach a correction as feedback to a [run](https://docs.smith.langchain.com/tracing/concepts?ref=blog.langchain.com#runs). And for our example store, we can rely on LangSmith’s Datasets. To insert examples into LangSmith, we can either use [rules](https://docs.smith.langchain.com/monitoring/concepts?ref=blog.langchain.com#rules) or insert them via the Datasets API.

在收集用户修正（corrections）方面，LangSmith 允许您将修正作为反馈附加到一次 [run](https://docs.smith.langchain.com/tracing/concepts?ref=blog.langchain.com#runs) 上。对于我们的示例存储库，我们可以直接依托 LangSmith 的 Datasets 功能。向 LangSmith 插入示例的方式有两种：一是通过 [rules](https://docs.smith.langchain.com/monitoring/concepts?ref=blog.langchain.com#rules)，二是调用 Datasets API。

💡

💡

If you want to try this out for yourself, check out our cookbook [here](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com) which walks through this exact task

如果您想亲自尝试这一流程，请查阅我们的食谱文档 [此处](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com)，其中详细演示了本任务的完整实现步骤。

## **Building the World’s Best GitHub Auto Labeler**

## **打造全球最佳的 GitHub 自动打标器**

We wanted to put our new continual in-context learning pipeline to the test. The hardest part of the pipeline is collecting corrections from users. Auto labeling was an ideal first candidate because there is a clear correct answer, which makes collecting corrections simple.

我们希望对全新的持续上下文学习流水线进行实战检验。该流水线中最困难的一环是收集用户的修正反馈。自动打标（auto labeling）成为理想的首个落地场景——因为每个 Issue 或 Pull Request 都有明确的正确标签，使得修正反馈的收集变得极为简单。

Every time a user either adds a label that Dosu missed or removes one of the labels Dosu added, we have a webhook that saves it as a correction on the run in LangSmith. This triggers a rule that automatically inserts the correction as an example to our LangSmith dataset with all the relevant metadata, such as the related organization ID.

每当用户为某个 Issue 或 PR 补充了 Dosu 漏标的标签，或移除了 Dosu 错误添加的标签时，我们的 Webhook 就会将该操作保存为 LangSmith 中对应 run 的一条修正反馈。这将触发一条规则，自动将该修正作为示例插入至我们的 LangSmith 数据集，并附带所有相关元数据（例如关联的组织 ID）。

Now, the next time Dosu labels an issue or PR, we do a similarity search across all recent examples for the current input and organization. We take the top examples, inject them into the auto-label prompt, and run inference.

此后，每当 Dosu 对新的 Issue 或 PR 进行自动打标时，系统都会针对当前输入文本及所属组织，在近期所有示例中执行相似性检索；选取最相关的若干示例，注入至自动打标提示词（prompt）中，再执行模型推理。

We released auto-labeling with continual learning into production a month ago, and the results have been awesome. Dosu’s auto-labeling accuracy increased by over 30%. It’s the best GitHub auto-labeler that exists as far as we know. But more importantly, our customers love it.

我们已于一个月前将支持持续学习的自动打标功能正式上线生产环境，效果令人振奋：Dosu 的自动打标准确率提升了超过 30%。据我们所知，这是目前市面上性能最强的 GitHub 自动打标器。但更重要的是——我们的客户非常喜爱它。

## **Continual Learning is the Future of Agents**

## **持续学习是智能体的未来**

Continual Learning creates a magical product experience. It gives power to end-users to tailor Dosu to meet their needs, and it correlates the time you invest in Dosu to the value you get out.

持续学习打造了令人惊叹的产品体验。它赋予终端用户自主定制 Dosu 的能力，以精准满足其个性化需求；同时，您在 Dosu 上投入的时间，将直接转化为所获得的价值。

With continual learning, Dosu can actually feel like a teammate. Dosu might make mistakes, but we can make sure Dosu, like a teammate, learns from those mistakes and doesn’t make them again.

借助持续学习，Dosu 真正能让人感受到如同一位并肩协作的队友。Dosu 或许会犯错，但正如真实队友一样，我们确保 Dosu 能从错误中学习，并且不再重蹈覆辙。

Auto-labeling is only one example of where we are incorporating continual learning. We are actively exploring other ways to integrate continual learning into retrieval, answer generation, and Dosu’s many other tasks.

自动标注（Auto-labeling）仅是我们融入持续学习理念的其中一个范例。我们正积极探索更多路径，将持续学习深度整合至检索、答案生成，以及 Dosu 承担的众多其他任务之中。

_If you’re interested in trying out Dosu to improve engineering velocity or want to help us build self-learning agentic systems, reach out to hi@dosu.dev_

_如果您希望试用 Dosu 以提升工程研发效能，或有意参与共建具备自学习能力的智能体系统，请联系 hi@dosu.dev_

**_If you want to try this out for yourself with LangSmith, check out our cookbook_** [**_here_**](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com) **_or our YouTube walkthrough_** [**_here_**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com) **_._**

**_若您希望借助 LangSmith 亲自动手实践，请查阅我们的使用指南（Cookbook）_** [**_此处_**](https://docs.smith.langchain.com/monitoring/use_cases/classification?ref=blog.langchain.com) **_，或观看我们的 YouTube 操作演示视频_** [**_此处_**](https://youtu.be/tHZtq_pJSGo?ref=blog.langchain.com) **_。_**
&#123;% endraw %}
