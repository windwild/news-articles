---
render_with_liquid: false
title: "Regression Testing with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/regression-testing/"
date: "2024-05-29"
scraped_at: "2026-03-03T08:02:23.216911024+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**This blog post walks through our improved regression testing experience in LangSmith. If video form is more your style, you can check out our YouTube walkthrough** [**here**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com) **. Sign up for LangSmith** [**here**](https://smith.langchain.com/?ref=blog.langchain.com) **for free to try it out for yourself!**

**本文博客将带您深入了解 LangSmith 中改进后的回归测试体验。若您更偏好视频形式，欢迎观看我们的 YouTube 演示视频** [**此处**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com) **。立即免费注册 LangSmith** [**此处**](https://smith.langchain.com/?ref=blog.langchain.com) **，亲自体验这一新功能！**

- [**YouTube Walkthrough**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com)  
- [**LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com)  

- [**YouTube 演示视频**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com)  
- [**LangSmith**](https://smith.langchain.com/?ref=blog.langchain.com)  

The ability to quickly and reliably evaluate your LLM application allows AI engineers to iterate with confidence. Many of the fastest moving and most successful teams we see have efficient testing and experimentation processes. This generally involves (1) setting up a dataset of inputs and (optionally) expected outputs, (2) defining some evaluation criteria. From there, you can evaluate different prompts, models, cognitive architectures, etc.

快速、可靠地评估您的大语言模型（LLM）应用，使 AI 工程师能够自信地进行迭代开发。我们观察到，进展最快、最成功的团队普遍拥有高效且成熟的测试与实验流程。该流程通常包括两个核心环节：（1）构建一组输入数据集（可选地附带期望输出）；（2）定义明确的评估标准。在此基础上，您即可对不同提示词（prompts）、模型、认知架构等进行系统性评估。

There are a few key differences between this type of testing and traditional software testing. One main difference: when testing AI applications they may not achieve a perfect score on the evaluation dataset. This is in contrast to software testing where you expect tests to always pass. This difference has two downstream effects. First, it becomes important to track the results of your tests over time. This isn’t necessary in software testing because it’s always 100% passing, but in AI engineering tracking this performance over time is necessary for making sure you’re improving. Second, it’s important to be able to compare the individual datapoints between two (or more) runs. You want to be able to see which datapoints the model used to get correct that it now gets wrong (or vice versa).

此类测试与传统软件测试存在若干关键差异。其中最主要的一点在于：在 AI 应用测试中，模型在评估数据集上往往无法达到满分；而传统软件测试则要求所有测试用例必须始终通过。这一根本差异带来两个重要影响：  
第一，持续追踪测试结果随时间的变化变得至关重要。在传统软件测试中，由于测试始终 100% 通过，这种追踪并无必要；但在 AI 工程实践中，唯有长期跟踪性能变化，才能切实判断模型是否真正取得进步。  
第二，必须支持对两次（或多次）运行中各条数据样本（datapoint）的逐项比对。您需要清晰识别出：哪些原本正确预测的样本如今出错（或反之），从而精准定位性能波动的具体来源。

> One pattern I noticed is that great AI researchers are willing to manually inspect lots of data. And more than that, **they build infrastructure that allows them to manually inspect data quickly.** Though not glamorous, manually examining data gives valuable intuitions about the problem.

> 我注意到一个共性现象：顶尖的 AI 研究者乐于人工审阅大量数据；更重要的是，**他们主动构建基础设施，以支持快速、高效的人工数据审查。** 尽管这项工作并不炫目，但亲手审视数据却能为理解问题本质提供极为宝贵的经验直觉。

- [Jason Wei, OpenAI](https://x.com/_jasonwei/status/1708921475829481683?ref=blog.langchain.com)  
- [杰森·魏（Jason Wei），OpenAI](https://x.com/_jasonwei/status/1708921475829481683?ref=blog.langchain.com)

This quote from Jason Wei perfectly describes the importance of looking at data, and the importance of infrastructure that allows them to do that. At LangSmith we strive to build that infrastructure, and it’s led to some big improvements in our regression testing flow.

杰森·魏的这段话精准概括了“审视数据”的重要性，以及支撑这一行为的基础设施的关键价值。在 LangSmith，我们始终致力于打造这样的基础设施——这也直接推动了我们在回归测试流程上的显著优化。

So what do we think that infrastructure consists of?

那么，我们所构想的这类基础设施究竟包含哪些核心要素？

First, you need to be able to select multiple experiments to compare. At least two, but it’s often useful to be able to view three or four at the same time. To enable this, we’ve built our Comparison View. This allows you to select any number of runs and open up into a view where you can see all the results at the same time.

首先，您需要能够灵活选择多个实验进行横向对比——至少两个，但实践中常常需要同时查看三至四个实验。为此，我们专门设计并推出了「对比视图（Comparison View）」。该视图支持您任意选取多组运行记录（runs），并在同一界面中并排呈现全部结果，实现一目了然的全局比对。

![](images/regression-testing-with-langsmith/img_001.gif)

Second, you need a lot of control over this comparison view. You may want to view information in different ways depending on what you’re looking for. For example, sometimes you just want a high level overview, other times you want to see all the text, other times you want to see the latency of each call. With our Display options, you can easily select what information you want to see.

第二，您需要对这一对比视图拥有高度的控制权。根据您的具体需求，您可能希望以不同方式查看信息。例如，有时您仅需一个高层级概览；有时您希望查看全部文本内容；有时您则关注每次调用的延迟情况。借助我们的“显示选项”（Display options），您可以轻松选择希望呈现的信息。

![](images/regression-testing-with-langsmith/img_002.gif)

Third - and most importantly - you want to be able to quickly drill into datapoints that behaved different between the two runs. If they behaved differently - there’s something interesting happening there! So how do we enable this?

第三——也是最重要的一点——您需要能够快速下钻（drill into）在两次运行中行为表现不同的数据点。一旦行为出现差异，往往意味着其中存在值得关注的现象！那么，我们如何实现这一点？

To start, we set a baseline run. We then take one of the evaluation metrics that you calculated and automatically highlight which datapoints increased or decreased on that metric compared to the baseline. This will shade some cells green or red.

首先，我们设定一次基准运行（baseline run）。随后，选取您计算出的任一评估指标，并自动高亮标出相较于该基准，哪些数据点在此指标上出现了上升或下降。系统将相应单元格以绿色（上升）或红色（下降）着色。

![](images/regression-testing-with-langsmith/img_003.gif)

But that’s not all! You can easily filter to only the datapoints that increased/decreased by choosing the toggle at the top of the column. If you have lots of datapoints, this lets you quickly drill in on the most interesting ones.

但这还不是全部！您只需点击列顶部的切换开关（toggle），即可便捷地筛选出指标值上升或下降的数据点。当您的数据点数量庞大时，该功能可助您迅速聚焦于最值得关注的那些样本。

![](images/regression-testing-with-langsmith/img_004.gif)

And finally, once you’ve identified a row that you’re interested in, you can easily expand that row to get a more holistic and specific view of just that datapoint and how the different runs performed on it.

最后，当您定位到某一行感兴趣的数据后，可轻松展开该行，从而获得关于该单一数据点更全面、更细致的视图，并清晰对比各次运行在此数据点上的具体表现。

![](images/regression-testing-with-langsmith/img_005.gif)

These features make it easy to explore data across multiple evaluation runs. This type of exploration is crucial for being able to quickly iterate. This concept of comparing multiple runs is phenomenon that is different between AI and software testing, and we’ve got a few more features (coming soon!) that make this even easier!

上述功能使您能够轻松地跨多次评估运行开展数据分析与探索。此类探索对于实现快速迭代至关重要。而“多轮运行对比”这一理念，正是人工智能测试与传统软件测试之间的重要差异所在；此外，我们还规划了更多功能（即将上线！），进一步简化该流程！

**If video form is more your style, you can check out our YouTube walkthrough** [**here**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com) **. Sign up for LangSmith** [**here**](https://smith.langchain.com/?ref=blog.langchain.com) **for free to try it out for yourself!**

**如果视频形式更符合您的偏好，欢迎点击此处观看我们的 YouTube 教程** [**这里**](https://youtu.be/xTMngs6JWNM?ref=blog.langchain.com) **。立即免费注册 LangSmith** [**此处**](https://smith.langchain.com/?ref=blog.langchain.com) **，亲自体验吧！**