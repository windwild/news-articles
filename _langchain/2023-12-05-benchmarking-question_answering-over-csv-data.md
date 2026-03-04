---
title: "Benchmarking Question/Answering Over CSV Data"
source: "LangChain Blog"
url: "https://blog.langchain.com/benchmarking-question-answering-over-csv-data/"
date: "2023-12-05"
scraped_at: "2026-03-03T08:21:23.239931990+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

**_This is a bit of a longer post. It's a deep dive on question-answering over tabular data. We discuss (and use) CSV data in this post, but a lot of the same ideas apply to SQL data. It covers:_**

**_这是一篇篇幅稍长的文章，深入探讨基于表格数据的问答任务。本文以 CSV 数据为例展开讨论（并实际使用），但其中许多思路同样适用于 SQL 数据。主要内容包括：_**

- **_Background Motivation: why this is an interesting task_**  
- **_背景动因：为何这是一个值得研究的任务_**

- **_Initial Application: how we set up a simple Streamlit app in order to gather a good distribution of real questions_**  
- **_初步应用：我们如何搭建一个简易的 Streamlit 应用，以收集具有代表性的真实用户问题_**

- **_Initial Solution: our initial solution and some conceptual considerations_**  
- **_初始方案：我们的首个解决方案及若干概念性思考_**

- **_Debugging with LangSmith: what we saw people asking, and what issues our initial solution had_**  
- **_借助 LangSmith 调试：我们观察到的用户提问模式，以及初始方案存在的问题_**

- **_Evaluation Setup: how we evaluated solutions_**  
- **_评估设计：我们如何对各类方案进行评估_**

- **_Improved Solution: the final improved solution we arrived at_**  
- **_优化方案：我们最终达成的改进型解决方案_**

**_As a sneak preview, the improved solution we arrived at was a custom agent that used OpenAI functions and had access to two tools: a Python REPL and a retriever._**  
**_提前剧透一下：我们最终提出的优化方案是一个定制化智能体（custom agent），它调用 OpenAI 函数，并具备两项工具能力——Python 交互式执行环境（REPL）与检索器（retriever）。_**

**_We've open-sourced everything - the app we used to gather feedback, the dataset, the eval script - at_** [**_this repo_**](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) **_. We've also made a_** [**_YouTube video_**](https://www.youtube.com/watch?v=jGnf4OhptbA&ref=blog.langchain.com) **_walking through the content in this blog, if that's more your style._**  
**_我们已将全部内容开源——包括用于收集用户反馈的应用、所构建的数据集以及评估脚本——均发布于_** [**_该代码仓库_**](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com) **_。此外，我们也制作了一期_** [**_YouTube 视频_**](https://www.youtube.com/watch?v=jGnf4OhptbA&ref=blog.langchain.com) **_，逐项讲解本文内容，若您更习惯视频形式，欢迎观看。_**

* * *

## Background Motivation

## 背景动因

There's a pretty [standard recipe](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com) for question over text data at this point. On the other hand, one area where we've heard consistent asks for improvement is with regards to tabular (CSV) data. Lots of enterprise data is contained in CSVs, and exposing a natural language interface over it can enable easy insights. The problem is that it's far less clear how to accomplish this.

目前，针对文本数据的问答任务已形成一套较为[标准化的实现范式](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)。然而，另一方面，我们持续收到来自用户的明确反馈：在处理表格类（CSV）数据时，现有方案亟需改进。大量企业数据以 CSV 格式存储，若能为其提供自然语言交互接口，则可显著降低获取业务洞察的门槛。但难点在于：如何切实可行地实现这一目标，尚无清晰路径。

A few weeks ago we decided to focus on this for a bit but quickly ran into an issue–we didn't really know what types of questions people expected to be able ask CSV data, and we didn't have any good way to evaluate this applications.

几周前，我们决定就此问题开展专项探索，却很快遭遇瓶颈——我们并不清楚用户期望对 CSV 数据提出哪些类型的问题；同时，也缺乏行之有效的评估手段来衡量相关应用的实际效果。

💡

💡

Evaluation of LLM applications is often hard because of a lack of data and a lack of metrics.

大语言模型（LLM）应用的评估往往困难重重，其根源在于：既缺乏高质量的标注数据，也缺少公认的评估指标。

In traditional machine learning you usually start with a dataset of inputs and outputs, and you use this to train and then evaluate your model. However, because LLMs are fantastic zero shot learners, it is now possible to use a prompt to quickly build an application based on just an idea, and no data. While this is incredibly powerful in terms of enabling developers to build new applications quickly, it leads to difficulty in evaluating because you lack that data. This is why we've built LangSmith in a way where constructing datasets is as easy as possible.

在传统机器学习中，你通常从一组输入与输出的数据集出发，用它来训练模型，再进行评估。然而，由于大语言模型（LLM）具备出色的零样本学习能力，如今仅凭一个提示词（prompt）和一个初步构想，无需任何标注数据，即可快速构建出一个应用。这种能力极大地提升了开发者快速开发新应用的效率；但与此同时，也带来了评估难题——因为你缺乏用于评估的基准数据。正因如此，我们设计 LangSmith 的核心目标之一，就是让数据集的构建过程尽可能简单。

Likewise, there's often not great metrics for evaluating LLM applications. The outputs are often natural language, and traditional NLP metrics like BLEU and ROUGE aren't great. But what is good at understanding natural language? LLMs! We're pretty bullish on LLM assisted evaluation and have invested in building a bunch of evaluators that use LLMs to do the evaluation.

同样，目前尚缺乏真正适用于评估 LLM 应用的优质评估指标。LLM 的输出通常是自然语言，而传统的自然语言处理（NLP）指标（如 BLEU 和 ROUGE）对此类输出的评估效果往往不佳。那么，什么模型最擅长理解自然语言？答案正是 LLM 本身！我们对“LLM 辅助评估”（LLM-assisted evaluation）持高度乐观态度，并已投入资源构建了一系列基于 LLM 的评估器，专门用于自动化评估任务。

So how did we apply these ideas to our task of creating a better application for answering questions over tabular data? We'll dive into these in more detail in the next sections, but at a high level we:

- Used LangSmith to flag interesting datapoints and used that to construct a dataset of examples  
- Used LLMs to evaluate correctness

那么，我们是如何将上述思路应用于“构建更优的表格数据问答应用”这一具体任务中的？后续章节将深入展开，但总体而言，我们采取了以下关键步骤：

- 利用 LangSmith 标记具有代表性的交互样本，并以此构建示例数据集；  
- 利用 LLM 对回答的正确性进行评估。

* * *

## Initial Application

## 初版应用

First, we set about creating a dataset of questions and ground truth answers. Part of the issue here was didn't even know what type of questions people would want to ask of their tabular data. We could have made some educated guesses, or tried to generate synthetic questions to ask. But we wanted to optimize instead for _real_ questions, as we also wanted to do a bit of exploration here into what types of questions real users would want to ask.

首先，我们着手构建一个包含问题及其标准答案（ground truth answers）的数据集。其中一大挑战在于：我们甚至不清楚用户究竟希望就其表格数据提出哪些类型的问题。我们本可以凭经验做些合理猜测，或尝试生成合成问题；但我们选择优先聚焦于**真实用户提出的问题**——这不仅有助于提升数据真实性，也为我们提供了一次探索真实用户提问模式的宝贵机会。

💡

Before you launch an app it can be tough to guess how users may interact with it. Rather than guessing, one strategy is launch quickly and early and gather real data.

💡

应用上线前，往往很难准确预判用户将如何与之交互。与其凭空猜测，不如采用“快速上线、尽早发布”的策略，主动收集真实用户行为数据。

In order to do this we decided to spin up a quick demo application and put that out in the wild. We would then log actual user questions along with any feedback about the answers that they gave us. To gather feedback we added a simple "thumps up"/"thumbs down" button to the application. We would use LangSmith to monitor all the interactions and feedback, and then we would manually review the interactions and create a dataset consisting of any interesting ones. This is done easily from the LangSmith UI - there is an "Add to Dataset" button on all logs.

为此，我们决定快速搭建一个演示应用并对外发布。随后，我们持续记录真实用户提出的问题，以及他们对系统回答所给予的反馈。为方便收集反馈，我们在应用界面中添加了简单的“👍 赞同”/“👎 不赞同”按钮。我们利用 LangSmith 全面监控所有用户交互及反馈数据，再由人工审阅这些日志，从中筛选出值得关注的样本，构建高质量数据集。该操作在 LangSmith 用户界面中极为便捷——每条日志旁均设有“Add to Dataset”（加入数据集）按钮。

There's also the question of what type of data we wanted to gather. We considered two approaches: (1) let users upload their own CSV and ask questions of that, (2) fix the CSV and gather questions over that. We opted for (2) for a few reasons. First - it would make it simpler for people to play around with, likely leading to more responses. Second - it would probably make it easier to evaluate. Third - we specifically wanted to be logging and looking at user questions, and we didn't want to do this over any confidential CSV that someone might upload. However, this does have several downsides. We would have to choose a CSV to use, and this CSV may not be representative of other CSVs - both in the size and shape of the data, as well as the questions people may want to ask of it.

此外，我们还需考虑：究竟要收集哪一类数据？我们评估了两种方案：（1）允许用户上传自己的 CSV 文件并就该文件提问；（2）预先固定一个 CSV 文件，仅围绕该文件收集用户问题。我们最终选择了方案（2），原因有三：第一，这将显著降低用户的使用门槛，便于快速上手，从而有望获得更丰富的反馈；第二，统一的数据源将极大简化后续的评估工作；第三，我们特别希望系统性地记录并分析用户提出的问题，而若允许上传任意 CSV，则可能涉及敏感或机密数据，带来合规与隐私风险。然而，该方案也存在若干明显缺陷：我们必须自行选定一个 CSV 作为基准数据集，而该数据集在数据规模、结构特征（如列类型、稀疏性、分布形态等）以及用户可能提出的典型问题等方面，未必能充分代表现实世界中其他 CSV 文件的多样性。

For our example application we chose the classic [Titanic dataset](https://github.com/datasciencedojo/datasets/blob/master/titanic.csv?ref=blog.langchain.com) \- a record of all passengers on the Titanic and whether they survived, often used for example data science projects. We created this simple application in Streamlit, put it out in the world, and asked people to give feedback. You can view the [hosted app](https://csv-langchain.streamlit.app/?ref=blog.langchain.com) here, and the [source code here](https://github.com/langchain-ai/langchain-benchmarks/blob/8a5ba6d575f5e46d48eeea878346c65c22dbb62c/archived/csv-qa/streamlit_app.py?ref=blog.langchain.com#L1).

在示例应用中，我们选用了经典的 [Titanic 数据集](https://github.com/datasciencedojo/datasets/blob/master/titanic.csv?ref=blog.langchain.com)——一份完整记录泰坦尼克号全体乘客及其是否生还情况的数据集，常被用作数据科学教学与演示的基准数据。我们基于 Streamlit 快速构建了这个简易应用，将其部署上线，并公开邀请用户试用并提供反馈。您可在此访问 [已部署的应用](https://csv-langchain.streamlit.app/?ref=blog.langchain.com)，其 [源代码](https://github.com/langchain-ai/langchain-benchmarks/blob/8a5ba6d575f5e46d48eeea878346c65c22dbb62c/archived/csv-qa/streamlit_app.py?ref=blog.langchain.com#L1) 亦已开源。

Through this, we gathered ~400 interactions. Of those, about 200 had some form of feedback. Using LangSmith, we drilled into datapoints with bad feedback (and some with good) and manually labeled them and added them to a dataset we created. We did this until we had about 50 datapoints.

通过这一过程，我们共收集到约 400 条用户交互记录；其中约 200 条附带了某种形式的反馈（如评分、文字评论或修正建议）。借助 LangSmith 工具，我们重点分析了反馈质量较差（以及部分质量较好）的样本，人工对这些样本进行标注，并持续将其加入我们自主构建的评测数据集中，直至累计完成约 50 条高质量标注样本。

Now it was time to improve our system! Before talking about how we improved, let's first discuss (1) what the initial system was (2) what issues it had, and (3) how we would evaluate the system to measure any improvements.

现在，是时候优化我们的系统了！在介绍具体改进方法之前，我们先厘清三个关键问题：（1）初始系统的架构与实现方式；（2）该系统存在的主要问题；（3）我们将采用何种方式评估系统性能，以客观衡量各项改进的实际效果。

* * *

## Initial Solution

## 初始方案

The Titanic dataset has a mix of columns in it. Some of them are numeric (age, number of siblings, fare), some of them are categorical (station embarked, cabin) and there's one text column (name).

Titanic 数据集包含多种类型的字段：部分为数值型（如年龄 `age`、兄弟姐妹数量 `sibsp`、票价 `fare`），部分为类别型（如登船港口 `embarked`、舱位等级 `pclass`、船舱编号 `cabin`），另有一列为文本型（乘客姓名 `name`）。

While a person's name isn't _super_ text heavy, it is still text heavy enough to cause some issues. For example if a question is asked about "John Smith", there a bunch of variants of how that name could be represented: `Mr. John Smith` (title), `Smith, John` (order), `Jon Smith` (typo), `John Jacob Smith` (middle name), etc. This can make it tricky to filter rows exactly by name, or even do lookups. Therefore, from the start we knew we had to include some more fuzzy based functionality. However, we also guessed that people would want to ask some questions about aggregations ("who paid the most for their fare") or the like, and so we probably need some functionality to do that.

尽管人名并非高度“文本密集型”字段，但其固有的变异性仍会引发诸多挑战。例如，当用户询问“John Smith”时，该姓名在数据中可能以多种形式出现：带称谓的 `Mr. John Smith`、倒序排列的 `Smith, John`、拼写错误的 `Jon Smith`、含中间名的 `John Jacob Smith` 等。此类差异使得基于姓名的精确行过滤或查找变得异常困难。因此，我们从一开始就明确：系统必须集成更鲁棒的模糊匹配能力。与此同时，我们也预判用户会提出涉及聚合计算的问题（例如“谁支付的票价最高？”），故系统还需支持相应的数值聚合与统计分析功能。

💡

Tabular data that contains text can be particularly tough to deal with, as retrieval is likely needed in some form, but pure retrieval probably isn't enough.

💡

含有文本字段的表格数据往往尤为棘手——因为通常需要某种形式的检索机制，但单纯的检索（如关键词匹配或向量相似度搜索）往往不足以应对复杂查询需求。

### Retrieval

### 检索

For the natural language bit, we wanted to use a traditional retrieval system. We weren't going to get too fancy, so we just wanted to use a simple vectorstore and look up results based on cosine similarity with the input question.

在自然语言处理部分，我们希望采用一种传统的检索系统。我们并不打算过度追求复杂性，因此仅需使用一个简单的向量数据库（vectorstore），并基于输入问题与向量之间的余弦相似度来检索结果。

In order to do this we needed to load a CSV into a vectorstore. We did this using the logic of our [CSVLoader](https://python.langchain.com/docs/integrations/document_loaders/csv?ref=blog.langchain.com). What this does under the hood is:

为实现这一目标，我们需要将 CSV 文件加载进向量数据库。我们采用了 [CSVLoader](https://python.langchain.com/docs/integrations/document_loaders/csv?ref=blog.langchain.com) 的逻辑来完成该操作。其底层工作原理如下：

1. Load each row as its own document  
   将 CSV 中的每一行作为独立的文档加载；  
2. Represent the text of each document as a list of `Column: value` pairs, each on their own line.  
   将每个文档的文本表示为若干形如 `列名: 值` 的键值对，每对占一行。

Digging into point (2) a bit more, there's a few ways you could represent a row of CSV as a document. You could represent it as JSON, as a CSV, or - as we ended up doing - a formatted piece of text. Very concretely, if you had a CSV row with the following values: `{"col1": "foo", "col2": "bar"}` what this ends up looking like after you format it is:

进一步探讨第 (2) 点：将 CSV 的一行表示为文档，其实有多种方式可选——例如以 JSON 格式、原始 CSV 格式，或（正如我们最终选择的）一种格式化后的纯文本形式。具体而言，若某 CSV 行包含如下字段值：`{"col1": "foo", "col2": "bar"}`，经格式化后即呈现为：

```
col1: foo
col2: bar
```

While this may not seem all that interesting, a BIG part of LLM applications is proper data engineering to communicate data to the LLM most effectively. Anecdotally, we've found this representation of tabular (and also JSON) data to be most efficient when the values could contain textual values.

尽管这种表示方式看似平淡无奇，但**恰当的数据工程正是大语言模型（LLM）应用中至关重要的一环**——它决定了我们能否最有效地将数据传达给 LLM。根据我们的实践经验，当表格（以及 JSON）数据中的字段值本身可能包含文本内容时，上述这种“列名: 值”的格式化文本表示法往往最为高效。

### Query Language

### 查询语言

Aside from retrieval, we also figured people would want to ask questions that required some type of query language. For example - "who paid the most for their fare". There are two approaches we considered here.

除检索功能外，我们也预见到用户会提出需要某种查询语言支持的问题，例如：“谁支付的车费最高？”。针对此需求，我们评估了两种技术路径。

First, we considered using a Python REPL and asking the language model to write code to help answer the user's question. This has the benefit of being very flexible. This also has the downside of maybe being TOO flexible - it could enable execution of arbitrary code.

第一种方案是使用 Python 交互式解释器（REPL），并让语言模型生成代码来辅助回答用户问题。该方案的优势在于极高的灵活性；但其劣势也同样明显——灵活性可能“过犹不及”，从而带来执行任意代码的安全风险。

Second, we considered using [`kork`](https://github.com/langchain-ai/kork?ref=blog.langchain.com) to give access to a predetermined set of functions. `kork` is a library that basically whitelists a set of functions that can be used. It's less general - you have to declare all functions that can be run - but it's safer.

其次，我们考虑使用 [`kork`](https://github.com/langchain-ai/kork?ref=blog.langchain.com) 来提供对一组预定义函数的访问权限。`kork` 是一个库，其核心机制本质上是对允许调用的函数进行白名单管理。它的通用性较低——你必须事先声明所有可执行的函数——但安全性更高。

To start, we went with `kork`. We weren't entirely sure about what people would ask, so we defined a few functions (filter, sum, contains) and gave it access to that.

起初，我们选择了 `kork`。由于尚不清楚用户会提出哪些问题，我们仅预先定义了几个函数（如 `filter`、`sum`、`contains`），并授予 `kork` 对这些函数的调用权限。

Our first solution ran retrieval and `kork` in [parallel](https://twitter.com/hwchase17/status/1690780072830201856?s=20&ref=blog.langchain.com), and then combined the answers.

我们的首个方案将检索（retrieval）与 `kork` 调用以[并行方式](https://twitter.com/hwchase17/status/1690780072830201856?s=20&ref=blog.langchain.com)执行，随后再合并两者的输出结果。

* * *

## Debugging with LangSmith

## 使用 LangSmith 进行调试

People started asking questions and the feedback starting rolling in. Only about 1/3 of feedback was positive. What was going wrong? There was two main sources of errors:

用户开始提问，反馈也陆续涌入。其中仅有约三分之一为正面评价。问题出在哪里？主要存在两类错误来源：

### Data Formatting

### 数据格式化

A lot of the functions we wrote for `kork` would return a dataframe. This dataframe was then inserted into a prompt and passed to the language model. There was then a question of how that dataframe was formatted as a string to be passed to the language model.

我们为 `kork` 编写的许多函数都会返回一个 DataFrame。该 DataFrame 随后被插入提示词（prompt）中，并传给语言模型。此时便产生了一个关键问题：这个 DataFrame 应以何种字符串格式呈现，才能被语言模型有效理解？

This was important for answering questions like `Who was in cabin C128`. The returned dataframe would have hopefully filtered to the correct row and be returning all relevant information. Before we launched the app, we tested questions like this and it was working fine. However, after we launched the app and started to look at the responses we noticed it was failing terribly at a large number of these types of questions.

这对回答类似 `Who was in cabin C128`（C128 舱室中有哪些人？）这类问题至关重要。理想情况下，返回的 DataFrame 应已精确筛选出目标行，并包含所有相关信息。在应用上线前，我们曾针对此类问题进行了测试，结果一切正常；然而，上线后当我们实际查看响应结果时，却发现大量同类问题的回答严重失败。

We used LangSmith to inspect the traces to try to get a sense of what was going on. We could see that the correct query was being generated... but when that dataframe was passed into the prompt the formatting was being messed up. We expected it look something like:

我们借助 LangSmith 检查调用链（traces），试图厘清问题根源。我们观察到：查询语句本身生成正确……但当该 DataFrame 被插入提示词时，其字符串格式却出现了混乱。我们原本期望它的格式大致如下：

![](images/benchmarking-question_answering-over-csv-data/img_001.png)

![](images/benchmarking-question_answering-over-csv-data/img_001.png)

But instead it was looking something like:

但实际显示效果却类似于：

![](images/benchmarking-question_answering-over-csv-data/img_002.png)

![](images/benchmarking-question_answering-over-csv-data/img_002.png)

After some more debugging, we discovered that how a dataframe is represented as string may change depending on what platform you are on. In this case, it was being represented differently locally compared to Streamlit cloud. After some more debugging, we figured out that we could fix that inconsistency by specifying some parameters:

经过进一步调试，我们发现：DataFrame 转换为字符串的格式可能因运行平台不同而发生变化——本例中，本地环境与 Streamlit Cloud 上的字符串表示方式就不一致。再经排查，我们确认可通过设置以下参数来消除该不一致性：

```
pd.set_option('display.max_rows', 20)
pd.set_option('display.max_columns', 20)
```

```
pd.set_option('display.max_rows', 20)
pd.set_option('display.max_columns', 20)
```

Doing this fixed a lot of our issues! It also shows how LangSmith can be extremely helpful in debugging LLM issues. The main parts of bringing an LLM application from prototype to production are prompt engineering and data engineering. Understand what exactly the data looks like when you are passing it to an LLM is crucial for debugging performance issues. We've heard from several users of LangSmith who have found these types of data engineering issues only after using LangSmith to inspect the exact inputs to LLMs more carefully.

这一调整解决了我们大量问题！同时也凸显了 LangSmith 在调试大语言模型（LLM）相关问题时的强大作用。将一个 LLM 应用从原型阶段推进到生产部署，核心环节在于提示工程（prompt engineering）和数据工程（data engineering）。准确理解传入 LLM 的数据具体形态，对定位性能问题至关重要。我们已收到多位 LangSmith 用户反馈：正是借助 LangSmith 对 LLM 实际输入内容进行细致检查，他们才首次发现此前被忽视的此类数据工程问题。

💡

💡

If data is not passed to the language model in a clear way, it will make it really tricky for the language model to reason about it correcting. Using LangSmith to make sure the final text looks reasonable, and debug any data processing steps, is a great way to catch any bugs here.

若数据未以清晰、结构化的方式传递给语言模型，将极大增加模型正确推理的难度。利用 LangSmith 检查最终生成文本是否合理，并逐环节调试数据处理流程，是及时发现并修复此类 Bug 的极佳实践。

### Limited `kork` Functionality

### `kork` 功能受限

It turns out the set of functions we gave to `kork` was not NEARLY enough to cover the long tail of questions users would ask.

事实证明，我们赋予 `kork` 的函数集合远远不足以覆盖用户可能提出的长尾类问题。

There are two potential fixes to this. One, we could try to add more functions to `kork`. Second, we could revert to using a Python REPL.

这个问题存在两种潜在的修复方案：其一，我们可以尝试向 `kork` 中添加更多功能；其二，我们可以回归使用 Python REPL。

## Evaluation Setup

## 评估设置

So we've now constructed our dataset of real world examples. We've also done some manual debugging and identified some areas of errors and have some ideas for how to improve. How exactly do we go about measuring whether we've improved?

目前，我们已构建完成一组真实世界示例的数据集。同时，我们也进行了部分人工调试，识别出若干错误高发区域，并初步形成了若干改进思路。那么，我们究竟该如何准确衡量这些改进是否真正奏效呢？

For an example of why this is non-trivial, let's consider the question `Who is in cabin C128`. The correct answer in the CSV is `Williams-Lambert, Mr. Fletcher Fellows`. But there are a LOT of ways a language model could respond that should be considered "correct":

为说明此项任务为何并不简单，我们以问题 `Who is in cabin C128`（C128 舱室中的人是谁？）为例。CSV 文件中的标准答案是 `Williams-Lambert, Mr. Fletcher Fellows`。但语言模型可能以大量不同方式作答，而这些回答理应都被视为“正确”：

- `Mr. Fletcher Fellows Williams-Lambert`
- `The person in cabin C128 was Mr. Fletcher Fellows Williams-Lambert.`
- `Fletcher Williams-Lambert`
- `Mr. Williams-Lambert was in that cabin`

- `Mr. Fletcher Fellows Williams-Lambert`  
- `C128 舱室中的人是 Mr. Fletcher Fellows Williams-Lambert。`  
- `Fletcher Williams-Lambert`  
- `Williams-Lambert 先生住在该舱室。`

In order to properly evaluate these natural language answers... we turned to a language model. We decided to use our standard `qa` evaluator, which takes as input:

为妥善评估此类自然语言形式的回答……我们转而借助语言模型。我们决定采用标准的 `qa` 评估器，其输入包括：

- The input  
- The ground truth answer  
- A predicted answer  

- 输入（input）  
- 标准答案（ground truth answer）  
- 模型预测答案（predicted answer）  

From there, it formats a prompt template with those values and passes that to a language model to get back a response.

随后，评估器将上述三项内容填入预设提示模板，并将该模板提交给语言模型，以获取判断结果。

Even still, this is NOT perfect. For example, one of the questions we evaluated on was `male to female ratio?`. It's pretty unclear what the answer to that question should be. We had labelled the answer as `There were 577 males and 314 females, for a ratio of 1.84`. In one test run, the language model responded `The ratio of males to females in the dataframe is approximately 0.65 to 0.35. This means that there are about 65% males and 35% females`. Our LLM evaluator marked that answer as INCORRECT, even though it probably likely correct.

即便如此，该方法仍远非完美。例如，在我们评估的一道题目 `male to female ratio?`（男女比例是多少？）中，其“正确答案”本身就相当模糊。我们曾将标准答案标注为：`There were 577 males and 314 females, for a ratio of 1.84`（共 577 名男性与 314 名女性，男女比约为 1.84）。但在某次测试运行中，语言模型回答道：`The ratio of males to females in the dataframe is approximately 0.65 to 0.35. This means that there are about 65% males and 35% females`（数据表中男女比例约为 0.65 : 0.35，即约 65% 为男性、35% 为女性）。我们的 LLM 评估器却将该回答判定为“错误”（INCORRECT），尽管它实际上极有可能是正确的。

Does this mean there is no use for an LLM evaluator? We do not believe so. Rather, we believe that LLM evaluators are still useful. For starters, they are markedly better than other "general" evaluation methods we've tried. Secondly, even if occasionally correct _that can be totally fine_ if you're not treating the grades as gospel. For example - don't blindly accept the LLM scores, but rather treat them as indications of where it may be worth looking. Even if you still need to do human evaluation on some data points, using LLM assisted evaluation can help guide you to the most interesting datapoint to look at.

这是否意味着 LLM 评估器毫无用处？我们并不这么认为。相反，我们认为 LLM 评估器依然具有重要价值。首先，相较于我们尝试过的其他“通用型”评估方法，LLM 评估器的表现明显更优；其次，即便其判断偶有偏差——只要我们不将其评分奉为绝对真理，这种偏差通常完全可以接受。举例而言：切勿盲目采纳 LLM 给出的分数，而应将其视作一种线索，提示我们哪些样本值得重点关注。即便最终仍需对部分数据点进行人工评估，借助 LLM 辅助评估也能有效引导我们聚焦于最具分析价值的关键样本。

💡

Using LLMs to evaluate LLM output is NOT perfect, but we believe this is currently the best available solution—and we’re bullish on its long-term potential.

💡

使用大语言模型（LLM）评估其他大语言模型的输出并非完美无缺，但我们认为这目前是最佳可用方案，并对其长期发展前景持乐观态度。

## Improved Solution

## 改进后的方案

Finally, we arrive at the exciting part of the blog. Did we manage to improve our solution? And how did we do so?

终于来到本博客最激动人心的部分：我们是否成功改进了原有方案？又是如何实现的？

Our final solution is:

我们最终的方案包括：

- An agent powered by OpenAIFunctions (`OpenAIFunctionsAgent`)  
  基于 `OpenAIFunctionsAgent` 构建的智能体；
- GPT-4  
  GPT-4 模型；
- Two tools: a Python REPL and a retriever  
  两种工具：一个 Python 交互式执行环境（REPL）和一个检索器（retriever）；
- A custom prompt with custom instructions on how to think about when to use the Python REPL vs the retriever  
  一条定制化提示词（prompt），其中包含明确的指令，指导模型在何时选用 Python REPL、何时调用检索器。

This provides several benefits. First, by giving it access to a Python REPL we give it the ability to do all sorts of queries and analysis. However, as we'll see in some of the comparisons below, the Python REPL can have issues when dealing with text data - in this case the `Name` column. That is where the retriever can come in handy.

这一设计带来了多项优势。首先，赋予模型访问 Python REPL 的能力，使其可执行各类查询与数据分析任务。然而，正如后文部分对比示例所示，Python REPL 在处理文本类数据（例如 `Name` 列）时存在一定局限性；此时，检索器便能发挥关键作用。

💡

Our final solution is an agent with two tools: a Python REPL and a retriever. This allows it to answer questions about the unstructured text, but also perform more traditional data analysis operations.

💡

我们的最终方案是一个配备两种工具的智能体：Python REPL 与检索器。这使其既能回答关于非结构化文本的问题，也能执行更传统的数据分析操作。

Note that we do include some instructions in the prompt specific to the Titanic dataset. Specifically, we tell it that it should try to use the retriever for the `Name` column and the Python REPL for most other things. We did this because with generic wording it was having some trouble reasoning about when to use it. This does mean that comparing to generic solutions (as we do below) is a bit unfair. As a follow up, we would love to see a more generic prompt presented that does not include dataset specific logic. However, we also believe that in order to really improve the performance of your application you will likely need to use a custom prompt and NOT rely on generic defaults.

请注意，我们在提示词中嵌入了针对泰坦尼克号（Titanic）数据集的特定指令：明确要求模型对 `Name` 列优先使用检索器，而对大多数其他列则使用 Python REPL。之所以如此设定，是因为若仅采用通用表述，模型在判断工具适用场景时会出现推理困难。这也意味着，将本方案与通用型解决方案（如下文所做）进行对比，在一定程度上并不完全公平。作为后续工作，我们非常期待看到一种更具通用性的提示词设计——不依赖任何特定数据集的逻辑。但同时，我们也坚信：若想真正提升您应用的实际性能，大概率需要采用定制化提示词，而非依赖通用默认设置。

Now let's look at some results and compare to other methods. First, we compare to our standard [Pandas Agent](https://python.langchain.com/docs/integrations/toolkits/pandas?ref=blog.langchain.com) (using both GPT-3.5 as well as GPT-4). Next, we compare to [PandasAI](https://github.com/gventuri/pandas-ai/tree/main/pandasai?ref=blog.langchain.com) \- one of the top open source libraries for interacting with Pandas DataFrames. A table of performance is below. Again, this is over 50 datapoints and some of the evaluations may not be 100% accurate, so we'll also present some concrete examples after the fact.

现在让我们来看一些结果，并与其他方法进行对比。首先，我们将本方案与我们标准的 [Pandas Agent](https://python.langchain.com/docs/integrations/toolkits/pandas?ref=blog.langchain.com)（分别使用 GPT-3.5 和 GPT-4）进行对比。其次，我们将其与 [PandasAI](https://github.com/gventuri/pandas-ai/tree/main/pandasai?ref=blog.langchain.com) 进行对比——这是目前最主流的、用于与 Pandas DataFrame 交互的开源库之一。下方为性能对比表格。需要说明的是，该评测基于超过 50 个数据点，且部分评估结果可能并非 100% 准确；因此，我们还将在表格之后展示若干具体示例。

![](images/benchmarking-question_answering-over-csv-data/img_003.png)

![](images/benchmarking-question_answering-over-csv-data/img_003.png)

Note: these were all run on LangSmith. We're working on making evaluation runs publicly sharable.

注：所有评测均在 LangSmith 平台上运行。我们正在努力实现评测任务的公开共享功能。

The Pandas Agent and PandasAI performed roughly the same. They struggled on questions involving people's names. For example, for the following question:

Pandas Agent 和 PandasAI 的表现大致相当，但在涉及人名的问题上均表现欠佳。例如，对于以下问题：

> How many siblings does Carrie Johnston have?

> Carrie Johnston 有多少个兄弟姐妹？

The code generate is:

生成的代码如下：

```
# First, we need to find the row for Carrie Johnston
carrie_johnston = df[df['Name'].str.contains('Carrie Johnston')]

# Then, we can find the number of siblings she has
num_siblings = carrie_johnston['SibSp'].values[0]

num_siblings
```

```
# 首先，我们需要找到 Carrie Johnston 对应的数据行
carrie_johnston = df[df['Name'].str.contains('Carrie Johnston')]

# 然后，我们可以获取她拥有的兄弟姐妹数量
num_siblings = carrie_johnston['SibSp'].values[0]

num_siblings
```

However, `df[df['Name'].str.contains('Carrie Johnston')]` does not return any rows because her name appears as `Johnston, Miss. Catherine Helen "Carrie"`.

然而，`df[df['Name'].str.contains('Carrie Johnston')]` 并未返回任何行，因为她的姓名在数据中实际记录为 `Johnston, Miss. Catherine Helen "Carrie"`。

Looking at the four example our custom agent gets wrong, we can see that a lot of the mistakes aren't that bad.

观察我们自定义智能体答错的四个示例，可以看出其中许多错误其实并不严重。

In one case it filters based on age (the ground truth answer we added had no filtering - maybe there should have been?)

在其中一个案例中，它基于年龄进行了筛选（而我们添加的标准答案并未进行任何筛选——或许本应如此？）

![](images/benchmarking-question_answering-over-csv-data/img_004.png)

![](images/benchmarking-question_answering-over-csv-data/img_004.png)

In another case it stops listing after 10 - this is actually because the DataFrame when printed out didn't actually show the whole contents.

在另一个案例中，它在列出第10项后便停止了——这实际上是因为打印出的 DataFrame 并未完整显示全部内容。

![](images/benchmarking-question_answering-over-csv-data/img_005.png)

![](images/benchmarking-question_answering-over-csv-data/img_005.png)

In a third case it just has a different interpretation of how to respond (but the facts look correct)

在第三个案例中，它只是对“如何作答”采用了不同的理解方式（但所陈述的事实看起来是正确的）。

![](images/benchmarking-question_answering-over-csv-data/img_006.png)

![](images/benchmarking-question_answering-over-csv-data/img_006.png)

And finally, it messes up because it uses the retriever to search for names, and the retriever is limited to four responses.

最后，它出错的原因是：使用检索器（retriever）搜索姓名，而该检索器最多仅返回四项结果。

![](images/benchmarking-question_answering-over-csv-data/img_007.png)

![](images/benchmarking-question_answering-over-csv-data/img_007.png)

## Conclusion

## 结论

We're pretty satisfied with the final solution we arrived at - and most of the feedback had been positive as well. We're also pretty happy with the dataset we've put together and think it can be useful in evaluating these types of applications.

我们对最终达成的解决方案相当满意——而且大多数反馈也都是积极的。同时，我们也非常满意所构建的数据集，并认为它在评估此类应用时具有实用价值。

At the same time, we recognize that there is always room for improvements - on both fronts. The dataset can be improved/added to, the evaluators can likely be improved, and we're especially excited to see more solutions to this problem of question-answering over CSV data!

与此同时，我们也认识到，无论是在数据集还是评估方法方面，都仍有持续改进的空间：数据集可以进一步完善或扩充，评估器也有优化潜力；尤其令我们期待的是，针对“基于 CSV 数据的问答”这一问题，涌现出更多创新性解决方案！

We've open-sourced everything - the app we used to gather feedback, the dataset, the eval script - at [this repo](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com).

我们已将全部内容开源——包括用于收集反馈的应用、数据集以及评估脚本——托管于 [该代码仓库](https://github.com/langchain-ai/langchain-benchmarks?ref=blog.langchain.com)。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/benchmarking-question_answering-over-csv-data/img_008.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/benchmarking-question_answering-over-csv-data/img_008.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/benchmarking-question_answering-over-csv-data/img_009.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/benchmarking-question_answering-over-csv-data/img_009.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/benchmarking-question_answering-over-csv-data/img_010.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/benchmarking-question_answering-over-csv-data/img_010.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/benchmarking-question_answering-over-csv-data/img_011.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/benchmarking-question_answering-over-csv-data/img_011.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/benchmarking-question_answering-over-csv-data/img_012.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/benchmarking-question_answering-over-csv-data/img_012.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**借助 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/benchmarking-question_answering-over-csv-data/img_013.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
{% endraw %}
