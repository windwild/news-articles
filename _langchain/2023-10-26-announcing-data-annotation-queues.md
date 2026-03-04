---
title: "Announcing Data Annotation Queues"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-data-annotation-queue/"
date: "2023-10-26"
scraped_at: "2026-03-03T08:31:44.497294395+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

💡

Data Annotation Queues are a new feature in LangSmith, our developer platform aimed at helping bring LLM applications from prototype to production. Sign up for the beta [here](https://smith.langchain.com/?ref=blog.langchain.com).

💡

数据标注队列（Data Annotation Queues）是 LangSmith 平台的一项新功能。LangSmith 是我们面向开发者的平台，旨在助力大语言模型（LLM）应用从原型阶段顺利迈向生产部署。点击此处[注册参与公测](https://smith.langchain.com/?ref=blog.langchain.com)。

[LangSmith](https://blog.langchain.com/announcing-langsmith/) was launched with the goal of making it easier to take an LLM application from prototype to production. One of the main blockers here is improving the performance of your application and making it more reliable than just a Twitter.

[LangSmith](https://blog.langchain.com/announcing-langsmith/) 于发布之初即确立了核心目标：降低 LLM 应用从原型开发到生产落地的门槛。而实现这一目标的主要障碍之一，正是提升应用性能，并使其远比一条推文（Twitter）更稳定、更可靠。

There are several ways to do that. At the most basic, it's useful to look carefully at the data and build up intuition for where the chain is not performing well.

实现这一目标有多种途径。最基础也最关键的一步，是细致审阅数据，逐步建立对“链式流程（chain）”在哪些环节表现不佳的直觉判断。

💡

**One pattern I noticed is that great AI researchers are willing to manually inspect lots of data. And more than that, they build infrastructure that allows them to manually inspect data quickly. Though not glamorous, manually examining data gives valuable intuitions about the problem.**

[\- Jason Wei, OpenAI](https://twitter.com/_jasonwei/status/1708921475829481683?s=20&ref=blog.langchain.dev)

💡

**我观察到一个共性：顶尖的 AI 研究者往往乐于人工检查大量数据；不仅如此，他们还会构建专用基础设施，以支持快速、高效的人工数据审查。尽管这项工作并不炫酷，但亲手审视数据却能带来关于问题本质的宝贵洞见。**

[\- Jason Wei，OpenAI](https://twitter.com/_jasonwei/status/1708921475829481683?s=20&ref=blog.langchain.dev)

Beyond that, it's helpful to have a dataset of test cases you can run your chain over to measure its performance. Next, you can use techniques like few-shot prompting to do in-context learning to improve the model's performance. As an even more advanced step, you could finetune the model on some examples.

在此基础上，构建一套测试用例数据集也十分有益——你可以将链式流程运行于该数据集之上，从而量化评估其性能表现。随后，可采用小样本提示（few-shot prompting）等技术开展上下文内学习（in-context learning），进一步提升模型性能；更进一步地，还可基于部分样例对模型进行微调（finetuning）。

Notice that all these techniques require having datapoints specific to your application. Which most people often don't have to start! One of the main benefits of LLMs is that they make it incredibly easy to get started building an application compared to traditional machine learning - you don't need to have a dataset to train a model, you can just start using an API. This is great for getting started, but presents some challenges when you start diving deep and you want to improve your chain.

请注意：上述所有方法均依赖于与您具体应用场景高度相关的数据点（datapoints）——而大多数人在项目起步阶段恰恰缺乏这类数据！LLM 的一大核心优势，正在于它显著降低了应用开发的入门门槛：相比传统机器学习，你无需预先准备训练数据集，只需调用 API 即可快速启动开发。这固然极大便利了初始阶段，但当你深入优化、希望持续提升链式流程质量时，便会面临新的挑战。

To help solve some of those problems, we're releasing a new feature of LangSmith: Data Annotation Queues. This is designed to make it easy to review logs, give feedback on those logs, and create datasets from those logs. In parallel, we're excited to highlight [langfree](https://langfree.parlance-labs.com/?ref=blog.langchain.com), an OSS package from [Hamel Husain](https://hamel.dev/?ref=blog.langchain.com) aimed at doing some of this functionality locally.

为助力解决上述难题，我们正式推出 LangSmith 的全新功能：**数据标注队列（Data Annotation Queues）**。该功能专为简化日志审查、便捷提供反馈、并基于日志高效构建高质量数据集而设计。与此同时，我们也很高兴向大家推荐开源工具包 [langfree](https://langfree.parlance-labs.com/?ref=blog.langchain.com) —— 这是由 [Hamel Husain](https://hamel.dev/?ref=blog.langchain.com) 开发的一款本地化解决方案，旨在支持部分同类功能的离线实施。

## Data Annotation Queue

## 数据标注队列

The idea of a data annotation is to create an ideal UX for reviewing logs from chains, with the purpose of either annotating them (marking them as correct or incorrect) or adding them to a dataset (for downstream usage).

数据标注的核心理念是为审查链式调用（chains）产生的日志，打造理想的用户体验；其主要目的有两个：一是对日志进行标注（标记为“正确”或“错误”），二是将日志添加至数据集（供下游任务使用）。

We've made this easy to do by adding an action to add to a data annotation queue from the logs page. With this, you can easily query for datapoints according to some filter and then add them to a queue. For example, you could filter to all datapoints that got negative feedback from the user (because you want to examine what is going on).

我们已在日志页面中新增一项操作——将日志条目加入数据标注队列，大幅简化了该流程。借助此功能，您可先按特定条件（如用户反馈、响应时长等）筛选数据点，再批量加入队列。例如，您可以筛选出所有收到用户负面反馈的数据点（以便深入分析问题成因）。

![](images/announcing-data-annotation-queues/img_001.png)

![](images/announcing-data-annotation-queues/img_001.png)

Once in the annotation queue, you can easily view each datapoint. We imagine two common actions:

进入标注队列后，您可便捷地逐条查看每个数据点。我们预设了两类高频操作：

1. Leave some annotation on the datapoint. This could be some label (good/bad), some classification (english/spanish/etc) or really anything.  
2. Add this datapoint to a dataset. When doing this, you may want to edit the datapoint before adding - for example, if a datapoint was incorrectly answered, you probably want to change the answer to the correct answer before adding.

1. 为该数据点添加标注：可以是简单标签（如“好”/“坏”）、分类类别（如“英语”/“西班牙语”等），或任何其他自定义信息；  
2. 将该数据点加入数据集：执行此操作前，您可能希望先编辑数据点内容——例如，若某条响应本身有误，您很可能需要先将答案更正为正确结果，再将其加入数据集。

To support these action items, we've given prime real estate to the feedback panel (on the right) and made the text of the datapoint directly editable. Not that if you edit the text, you still have to click "Add to Dataset" to add it to a dataset.

为支持上述操作，我们为右侧的反馈面板（Feedback Panel）预留了显著界面空间，并将数据点正文设为可直接编辑。请注意：即使您已编辑文本内容，仍需手动点击“Add to Dataset”（加入数据集）按钮，该数据点才会真正被添加至目标数据集。

![](images/announcing-data-annotation-queues/img_002.png)

![](images/announcing-data-annotation-queues/img_002.png)

Additionally, you can use the buttons on the bottom to do a few more things:

此外，您还可通过底部按钮执行以下额外操作：

- "Move to end" - move this datapoint to the end of queue, essentially ignoring it for now but saying you want to come back to it  
- "Done" - mark that you are finished reviewing a particular datapoint  

- “Move to end”（移至队尾）：将当前数据点移至队列末尾——相当于暂不处理，但明确保留后续复查的意愿；  
- “Done”（完成）：标记当前数据点的审阅工作已结束。

## Langfree

## Langfree

In parallel with releasing the Data Annotation Queue, we're also excited to share [langfree](https://langfree.parlance-labs.com/?ref=blog.langchain.com), an open source package in a similar direction by [Hamel Husain](https://hamel.dev/?ref=blog.langchain.com).

在发布 Data Annotation Queue 的同时，我们也非常高兴地向大家介绍 [langfree](https://langfree.parlance-labs.com/?ref=blog.langchain.com) —— 一个由 [Hamel Husain](https://hamel.dev/?ref=blog.langchain.com) 开发的、目标相似的开源工具包。

💡

💡

langfree helps you extract, transform and curate [ChatOpenAI](https://api.python.langchain.com/en/latest/chat_models/langchain.chat_models.openai.ChatOpenAI.html?ref=blog.langchain.com) runs from [traces](https://js.langchain.com/docs/modules/agents/how_to/logging_and_tracing?ref=blog.langchain.com) stored in [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com), which can be used for fine-tuning and evaluation.

langfree 可帮助您从存储在 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 中的 [traces](https://js.langchain.com/docs/modules/agents/how_to/logging_and_tracing?ref=blog.langchain.com) 里提取、转换和整理 [ChatOpenAI](https://api.python.langchain.com/en/latest/chat_models/langchain.chat_models.openai.ChatOpenAI.html?ref=blog.langchain.com) 的运行记录，这些数据可用于模型微调（fine-tuning）与效果评估（evaluation）。

With similar goals as Data Annotation Queue, this provides an open source alternative which can be helpful if you want to customize the annotation or dataset curation workflow in any way. We are very excited to share this, because we recognize that it's incredibly early on in this journey, and having open-source and customizable tooling for doing these tasks is invaluable - thank you to Hamel for adding this!

其目标与 Data Annotation Queue 高度一致；它提供了一个开源替代方案，特别适合希望以任意方式自定义标注流程或数据集构建流程的用户。我们对此倍感振奋，因为当前整个 LLM 数据工程生态仍处于非常早期的阶段，而开源、可定制的工具对于推进此类工作具有不可估量的价值——衷心感谢 Hamel 贡献这一项目！

Hamel has been a fantastic resource to work with, providing a lot of feedback for Data Annotation Queue along the way! Hamel also runs Parlance Labs - [one of our favorite partners](https://www.langchain.com/partners?ref=blog.langchain.com) \- and we'd highly recommend working with him.

Hamel 是一位极为出色的协作伙伴，在 Data Annotation Queue 的开发过程中提供了大量宝贵反馈！Hamel 同时也是 Parlance Labs 的创始人——[我们最喜爱的合作伙伴之一](https://www.langchain.com/partners?ref=blog.langchain.com)——我们强烈推荐与他合作。

## Conclusion

## 结语

Data Annotation Queue is aimed at making it easy for teams to explore data, annotate example, and create datasets. This type of data exploration and dataset curation is invaluable when looking to bring an LLM application from prototype to production.

Data Annotation Queue 致力于让团队轻松完成数据探索、样本标注与数据集构建。当您希望将大语言模型（LLM）应用从原型阶段推进至生产部署时，此类数据探索与数据集构建工作至关重要。

It also doesn't take that many datapoints to get started! We've seen teams build up valuable benchmarks with only a few examples. The key is that it's (1) specific to your use case, and (2) a high quality data point. If you want help embarking on this journey, please also feel free to [reach out directly](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com)!

而且，启动这项工作并不需要海量数据！我们已看到不少团队仅凭寥寥数个高质量样例，就成功构建出极具价值的基准测试集。关键在于：（1）样本必须高度契合您的具体应用场景；（2）每个数据点都需具备高标注质量。如果您希望就此开启实践之旅，欢迎随时 [直接联系我们](https://airtable.com/appwQzlErAS2qiP0L/shrGtGaVBVAz7NcV2?ref=blog.langchain.com)！
&#123;% endraw %}
