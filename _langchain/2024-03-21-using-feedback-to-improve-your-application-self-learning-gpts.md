---
render_with_liquid: false
title: "Using Feedback to Improve Your Application: Self Learning GPTs"
source: "LangChain Blog"
url: "https://blog.langchain.com/self-learning-gpts/"
date: "2024-03-21"
scraped_at: "2026-03-03T08:05:58.023019368+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

We built and hosted a simple demo app to show how applications can learn and improve from feedback over time.  
我们构建并托管了一个简单的演示应用，以展示应用程序如何随时间推移，通过用户反馈实现自我学习与持续优化。

The app is called "Self Learning GPTs" and it uses LangSmith to gather feedback and then automatically use that feedback to improve over time. It does this by creating few-shot examples from that feedback and incorporating those into the prompt.  
该应用名为“Self Learning GPTs”（自学习 GPT），它利用 LangSmith 收集用户反馈，并自动将这些反馈用于模型的持续优化。具体实现方式是：从反馈中生成少量示例（few-shot examples），并将它们整合进提示词（prompt）中。

Key Links:  
关键链接：

- You can access a hosted version of this app [here](https://self-learning-gpts-vz4y4ooboq-uw.a.run.app/?ref=blog.langchain.com).  
- 您可通过[此处](https://self-learning-gpts-vz4y4ooboq-uw.a.run.app/?ref=blog.langchain.com)访问该应用的托管版本。

- You can see a deep dive on how this works in [this YouTube video](https://www.youtube.com/watch?v=OnQQeWEwzyw&ref=blog.langchain.com).  
- 您可在[本 YouTube 视频](https://www.youtube.com/watch?v=OnQQeWEwzyw&ref=blog.langchain.com)中深入了解其工作原理。

- We are doing a webinar around "Optimization of LLM Systems" with Omar Khattab from DSPy in a few weeks - sign up [here](https://us06web.zoom.us/webinar/register/WN_n4HUNqhFQFa4ax3kYrZW8g?ref=blog.langchain.com).  
- 我们将在几周后举办一场主题为“大语言模型系统优化”（Optimization of LLM Systems）的线上研讨会，主讲嘉宾为来自 DSPy 的 Omar Khattab —— 欢迎点击[此处](https://us06web.zoom.us/webinar/register/WN_n4HUNqhFQFa4ax3kYrZW8g?ref=blog.langchain.com)报名参加。

- If you want early access to "LangSmith Automations" which power this - sign up [here](https://forms.gle/TUiy6McfTArproBu7?ref=blog.langchain.com).  
- 若您希望提前体验驱动本应用的核心功能——“LangSmith Automations”，请通过[此处](https://forms.gle/TUiy6McfTArproBu7?ref=blog.langchain.com)申请早期访问权限。

## Learning From Feedback  

## 从反馈中学习

Learning from feedback has been a key part of building LLM systems almost from the beginning. ChatGPT - the application that took the world by storm - used [Reinforcement Learning from Human Feedback](https://huyenchip.com/2023/05/02/rlhf.html?ref=blog.langchain.com) (RLHF) to tame the model to a point where it could be used as a general purpose chatbot. Midjourney keeps on getting better and better - probably in large part due to the [feedback loop](https://x.com/DrJimFan/status/1643279641065713665?s=20&ref=blog.langchain.com) it has.  
从反馈中学习，几乎是构建大语言模型（LLM）系统伊始就至关重要的环节。风靡全球的 ChatGPT 应用即采用了[基于人类反馈的强化学习](https://huyenchip.com/2023/05/02/rlhf.html?ref=blog.langchain.com)（RLHF）技术，对模型进行调优，使其最终可作为通用型聊天机器人投入使用。Midjourney 也持续迭代精进——这很大程度上可能归功于其建立的[反馈闭环机制](https://x.com/DrJimFan/status/1643279641065713665?s=20&ref=blog.langchain.com)。

The intuition for learning from feedback is simple. If you can gather feedback (in some form) on how well model predictions do, you can then optimize the model to produce more results like that. If you could continually do this - then your model could [continually learn and improve](https://fullstackdeeplearning.com/course/2022/lecture-6-continual-learning/?ref=blog.langchain.com) over time. This fully automated continually learning is perhaps not here, but I think most practitioners would not debate the importance of gathering feedback.  
从反馈中学习的直觉逻辑十分简单：只要能以某种形式收集到关于模型预测效果的反馈，便可据此优化模型，使其更频繁地生成类似优质结果；若该过程能够持续进行，那么模型便能[持续学习、不断进步](https://fullstackdeeplearning.com/course/2022/lecture-6-continual-learning/?ref=blog.langchain.com)。尽管目前尚无真正意义上全自动化的持续学习系统，但我相信绝大多数从业者都会认同——收集反馈本身至关重要。

## Feedback in LangSmith  

## LangSmith 中的反馈机制

Ever since we launched LangSmith, we placed an emphasis on making it easy to collect and track feedback. We make it easy to attach feedback to a run programmatically, allowing you to log things like thumbs up/down. We added a human annotation queue to allow reviewers to add feedback manually to runs. We adding filtering to allow you to filter to runs with particular feedback. We added monitoring to make it easy to track feedback in aggregated over time.  
自 LangSmith 发布以来，我们始终将“便捷地收集与追踪反馈”作为核心设计目标。我们提供了编程接口，使您能轻松地为任意一次运行（run）附加反馈（例如点赞/点踩）；我们引入了人工标注队列（human annotation queue），支持审核人员手动为运行添加反馈；我们增加了筛选功能，便于您按特定反馈类型过滤运行记录；我们还新增了监控能力，帮助您长期、聚合地追踪反馈趋势。

Still - so far we haven't provided much tooling or resources to make it easy for you to incorporate this feedback back into your application. We've been adding some features (still in beta for a few weeks) that power Self Learning GPTs and do exactly this.  
然而，截至目前，我们尚未提供足够丰富的工具或资源，来帮助您便捷地将这些反馈重新融入您的应用逻辑中。为此，我们正陆续上线若干新功能（目前仍处于数周的 Beta 测试阶段），它们正是驱动“Self Learning GPTs”实现上述能力的核心组件。

## Self Learning GPTs  

## 自学习 GPT

So how exactly does Self Learning GPTs work? It's relatively simple, and involves combining a bunch of different LangSmith features.

那么，Self Learning GPTs 到底是如何工作的？其原理相对简单，核心在于整合 LangSmith 的多项功能。

First, we trace all runs with LangSmith. This provides us with the full trace of a chatbot turn. Importantly - this is NOT just capturing the LLM call. This is capturing the full trace. We will go more into why this is so important later. As part of this, we log the UUID of the assistant that produced the run.

首先，我们使用 LangSmith 追踪所有运行（runs）。这为我们提供了聊天机器人单轮对话的完整执行轨迹（full trace）。关键在于——这**不仅仅是记录大语言模型（LLM）调用本身**，而是捕获整个执行流程的完整追踪。后文我们将进一步阐述为何这一点至关重要。在此过程中，我们还会记录生成该运行的助手（assistant）的 UUID。

Second, we capture feedback in the form of thumbs up/down and log it to LangSmith. We attach it to the corresponding trace.

其次，我们以“点赞/点踩”（thumbs up/down）的形式收集用户反馈，并将其记录至 LangSmith，同时将该反馈关联到对应的执行轨迹上。

Third, we use a new LangSmith feature to automatically move relevant data from traces into a dataset specifically for that assistant. What this involves is:

第三，我们利用 LangSmith 的一项新功能，自动将相关执行轨迹中的数据迁移至专属于该助手的数据集。具体操作包括：

- Creating a filter. Here, we want to grab all runs that have positive feedback (thumbs up).  
  - 创建一个筛选器：此处我们希望提取所有获得正面反馈（即“点赞”）的运行记录。

- Selecting a dataset. We recorded the assistant UUID as part of the trace, so we can use this to move the data into a dataset specifically for that assistant. This is important so each assistant can build its own dataset (as we expect them to learn specific things).  
  - 选择目标数据集：由于我们在执行轨迹中已记录了助手的 UUID，因此可据此将数据定向导入该助手专属的数据集。这一点至关重要——它确保每位助手都能构建并维护自身独立的数据集（因为我们期望不同助手学习并掌握各自特定的知识与能力）。

Finally, we use the LangSmith SDK to pull down this dataset at run time and use the examples in the prompt as few-shot examples.

最后，我们在运行时通过 LangSmith SDK 拉取该数据集，并将其中的样例作为少样本（few-shot）示例嵌入提示词（prompt）中。

## LangSmith Automations

## LangSmith 自动化功能

The key new thing which powers this is the automations which allow you to automatically move runs (according to some filter and sampling rate) into a dataset (or annotation queue). We will be rolling this out to everyone in a few weeks. In the meantime, if you are interested in early access please sign up [here](https://forms.gle/TUiy6McfTArproBu7?ref=blog.langchain.com).

驱动这一整套流程的核心新特性，正是 LangSmith 的**自动化功能**——它支持你依据指定筛选条件和采样率，自动将符合条件的运行记录迁移至数据集（或标注队列）。该功能将在数周内向全体用户正式发布。在此期间，如你希望提前体验，请点击此处[注册申请](https://forms.gle/TUiy6McfTArproBu7?ref=blog.langchain.com)。

## Importance

## 重要意义

We are excited to showcase this for two reasons.

我们之所以热切展示这一能力，主要有两点原因。

Mainly: this is a reliable way to automatically construct datasets of good examples.  
主要：这是一种可靠的方法，可自动构建高质量输入/输出示例的数据集。

When talking with teams building LLM applications, they often don't have a dataset of good input/output pairs. They were often doing this process of collecting feedback and then moving to a dataset manually. This automates that and makes it easy for anyone to do.  
在与构建大语言模型（LLM）应用的团队交流时，我们常发现他们缺乏高质量输入/输出配对的数据集。过去，他们通常需要手动收集用户反馈，再人工整理成数据集。本方法将该流程自动化，使任何人都能轻松完成。

Secondarily: incorporating them as few shot examples is a cheap and practical way to use this feedback to improve your application. Previously when collecting feedback, all we could use it for was helping to highlight datapoints you should look at. This is far more actionable.  
其次：将这些样本作为少样本（few-shot）示例嵌入提示中，是一种低成本且切实可行的方式，可直接利用反馈提升应用效果。以往收集到的反馈，仅能用于标记出值得关注的数据点；而本方法则提供了更明确、更具操作性的改进路径。

Note that this is not the only way to use these datapoints. You could use them as test set to do regression testing against. You could use them to fine-tune a model. You could do dynamic selection of few shot examples. You could use these examples in a [DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com)-like manner to optimize your LLM system.  
请注意，上述用法并非唯一途径。你还可以将这些数据点用作回归测试的测试集；用于模型微调（fine-tuning）；实现少样本示例的动态选择；或借鉴 [DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) 的思路，将这些示例用于优化整个 LLM 系统。

## Optimization of LLM Systems  

## LLM 系统的优化

[DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) is a framework for algorithmically optimizing LLM prompts and weights. We have chatted in depth with [Omar](https://twitter.com/lateinteraction?ref=blog.langchain.com) about optimization of LLM systems and done an [initial integration](https://github.com/stanfordnlp/dspy/blob/main/examples/tweets/compiling_langchain.ipynb?ref=blog.langchain.com) with them. We build off of a lot of ideas in DSPy to create this example.  
[DSPy](https://github.com/stanfordnlp/dspy?ref=blog.langchain.com) 是一个面向算法化优化大语言模型提示词（prompts）与模型权重（weights）的框架。我们已就 LLM 系统优化问题与 [Omar](https://twitter.com/lateinteraction?ref=blog.langchain.com) 进行了深入探讨，并完成了与 DSPy 的[初步集成](https://github.com/stanfordnlp/dspy/blob/main/examples/tweets/compiling_langchain.ipynb?ref=blog.langchain.com)。本示例的设计大量借鉴了 DSPy 中的核心思想。

There are actually a lot of similarities between DSPy and LangChain. Mainly - they both deal with optimizations of LLM systems, not just of a single LLM call. A key component of this is _tracing_, a concept that both DSPy and LangChain place a lot of emphasis on. Tracing underpins a lot of the optimizations that DSPy does, and with LangSmith we've obviously placed a lot of emphasis on it as well.  
事实上，DSPy 与 LangChain 存在诸多共通之处：二者均聚焦于**整个 LLM 系统**的优化，而非单次 LLM 调用的优化。其中一项核心能力是**追踪（tracing）**——这正是 DSPy 与 LangChain 共同高度重视的关键概念。DSPy 所实现的大量优化均以追踪能力为基石；而 LangSmith 同样将追踪能力置于核心地位。

Tracing the full system is particularly important because you will usually gather feedback at the system level, but there may be multiple distinct LLM calls inside the system that you want to optimize. Therefore, you need a way to associate the high level feedback with the lower-level LLM calls. This why it is necessary to have top-notch tracing - something that we've always emphasized in LangChain and LangSmith.  
对完整系统进行追踪尤为重要，因为用户反馈通常来自系统整体层面，但系统内部往往包含多个独立的 LLM 调用，而你可能希望分别优化其中每一处。因此，必须建立一种机制，将高层级的系统反馈精准关联至底层具体的 LLM 调用。正因如此，“业界领先”的追踪能力不可或缺——而这恰恰是 LangChain 与 LangSmith 始终坚持强调并持续投入的方向。

The current Self Optimizing GPTs doesn't go as far as DSPy. We just curate a few shot example dataset, we don't try to optimize which of the examples are best to select. That could easily be a next step. We've stopped short of that just because we believe that creating this dataset is already hugely helpful, and most companies are struggling to even do this.  
当前的“自优化 GPT”方案尚未达到 DSPy 的深度：我们仅完成了少样本示例数据集的整理工作，尚未进一步优化“如何从该数据集中智能选取最合适的示例”。这显然可作为下一阶段的重要方向。我们暂未推进该步骤，是因为我们坚信——仅构建此类数据集本身已极具价值，而现实中大多数企业甚至尚不具备完成这一基础工作的能力。

We're very excited to explore more advanced ideas around optimization in the future. We'll be hosting a webinar with Omar on "Optimization of LLM Systems" in a few weeks - should be a fun one. [Register here](https://us06web.zoom.us/webinar/register/WN_n4HUNqhFQFa4ax3kYrZW8g?ref=blog.langchain.com).  
我们对未来探索更前沿的优化理念充满期待。数周后，我们将携手 Omar 举办主题为“LLM 系统的优化”的线上研讨会，敬请期待！[立即报名](https://us06web.zoom.us/webinar/register/WN_n4HUNqhFQFa4ax3kYrZW8g?ref=blog.langchain.com)