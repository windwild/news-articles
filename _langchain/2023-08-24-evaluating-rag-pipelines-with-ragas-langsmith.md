---
title: "Evaluating RAG pipelines with Ragas + LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/evaluating-rag-pipelines-with-ragas-langsmith/"
date: "2023-08-24"
scraped_at: "2026-03-03T08:50:18.042675582+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with the [Ragas](https://github.com/explodinggradients/ragas?ref=blog.langchain.com) team. One of the things we think and talk about a lot at LangChain is how the industry will evolve to identify new monitoring and evaluation metrics that evolve beyond traditional ML ops metrics. Ragas is an exciting new framework that helps developers evaluate QA pipelines in new ways. This post shows how LangSmith and Ragas can be a powerful combination for teams that want to build reliable LLM apps._

_编辑注：本文由 LangChain 团队与 [Ragas](https://github.com/explodinggradients/ragas?ref=blog.langchain.com) 团队联合撰写。在 LangChain，我们持续深入探讨的一个核心议题是：整个行业将如何演进，以定义并采纳超越传统机器学习运维（ML Ops）范畴的新型监控与评估指标。Ragas 是一个令人振奋的全新框架，它为开发者提供了评估问答（QA）流水线的创新方法。本文将展示 LangSmith 与 Ragas 如何协同发力，助力团队构建高可靠性的大语言模型（LLM）应用。_

> How important evals are to the team is a major differentiator between folks rushing out hot garbage and those seriously building products in the space.

> 评估（evals）在团队工作中的重要程度，正是区分“仓促上线粗制滥造产品”与“严肃打造真正产品的团队”的关键分水岭。

This [HackerNews comment](https://news.ycombinator.com/item?id=36789901&ref=blog.langchain.com) emphasizes the importance of having a robust eval strategy when taking your application from a cool demo to a production-ready product. This is especially true when building LLM applications because of the underlying stochastic nature of the models powering them. You can easily build really impressive LLM applications with a few short training and verifying it on a few examples but to make it more robust you have to test it on a test dataset that matches the production distribution. This is an evolutionary process and something you will be doing throughout the lifecycle of your application but let's see how Ragas and LangSmith can help you here.

这条 [Hacker News 评论](https://news.ycombinator.com/item?id=36789901&ref=blog.langchain.com) 强调了构建稳健评估策略的重要性——尤其当你的应用需从一个炫酷的演示原型迈向可投入生产的成熟产品时。这一点在构建大语言模型（LLM）应用时尤为关键，因为驱动这些应用的底层模型本身具有固有的随机性（stochastic nature）。你仅凭少量提示工程和几个示例验证，就很容易搭建出令人印象深刻的 LLM 应用；但若要提升其鲁棒性（robustness），就必须在一个能真实反映生产环境数据分布的测试数据集上进行系统性验证。这是一个持续演进的过程，贯穿你整个应用的生命周期。接下来，我们将具体看看 Ragas 和 LangSmith 如何在此过程中为你提供有力支持。

This article is going to be specifically about QA systems (or [RAG systems](https://arxiv.org/abs/2005.11401?ref=blog.langchain.com)). Every QA pipeline has 2 components

本文将聚焦于问答系统（QA systems），即广义上的 [RAG 系统（检索增强生成）](https://arxiv.org/abs/2005.11401?ref=blog.langchain.com)。每个 QA 流水线均包含两个核心组件：

1. Retriever - which retrieves the most relevant information needed to answer the query  
1. 检索器（Retriever）——负责检索回答用户查询所需最相关的信息；  

2. Generator - which generates the answer with the retrieved information.  
2. 生成器（Generator）——利用检索到的信息生成最终答案。

When evaluating a QA pipeline you have to evaluate both of these separately and together to get an overall score as well as the individual scores to pinpoint the aspects you want to improve. For example, using a better chunking strategy or embedding model can improve the retriever while using a different model or prompt can bring about changes to the generation step. You might want to measure the tendency for hallucinations in the generation step or the recall for the retrieval step.

在评估 QA 流水线时，你既需分别评估这两个组件，也需联合评估整体表现，从而获得综合得分及各组件的独立得分，进而精准定位待优化环节。例如，采用更优的文本分块（chunking）策略或嵌入（embedding）模型可提升检索器性能；而更换基础大模型或调整提示词（prompt），则可能显著影响生成阶段的效果。你可能希望量化生成步骤中幻觉（hallucination）发生的倾向性，或衡量检索步骤的召回率（recall）。

But what metrics and datasets can you use to measure and benchmark these components? There are many conventional metrics and benchmarks for evaluating QA systems like [ROUGE](https://aclanthology.org/W04-1013/?ref=blog.langchain.com) and [BLUE](https://dl.acm.org/doi/10.3115/1073083.1073135?ref=blog.langchain.com) but they have [poor correlation with human judgment](https://arxiv.org/abs/2008.12009?ref=blog.langchain.com). Furthermore, the correlation between the performance of your pipeline over a standard benchmark (like [Beir](https://github.com/beir-cellar/beir?ref=blog.langchain.com)) and production data can vary depending on the distribution shift between both of them. Moreover, building such a golden test set is an expensive and time-consuming task.

那么，究竟该采用哪些指标与数据集来衡量和基准化（benchmark）这些组件呢？目前已有诸多传统评估指标与基准测试集，例如 [ROUGE](https://aclanthology.org/W04-1013/?ref=blog.langchain.com) 和 [BLEU](https://dl.acm.org/doi/10.3115/1073083.1073135?ref=blog.langchain.com)，但研究表明，它们与人类主观判断之间的相关性[普遍偏低](https://arxiv.org/abs/2008.12009?ref=blog.langchain.com)。此外，你的流水线在标准基准（如 [BEIR](https://github.com/beir-cellar/beir?ref=blog.langchain.com)）上的表现，与在真实生产环境中的实际效果之间，其相关性会因二者数据分布偏移（distribution shift）程度的不同而产生较大波动。更进一步说，构建这样一套高质量、权威的“黄金测试集”（golden test set），往往成本高昂且耗时费力。

## Leveraging LLMs for evaluations

## 借力大语言模型开展评估

Leveraging a strong LLM for reference-free evaluation is an upcoming solution that has shown a lot of promise. They correlate better with human judgment than traditional metrics and also require less human annotation. Papers like [G-Eval](https://arxiv.org/abs/2303.16634?ref=blog.langchain.com) have experimented with this and given promising results but there are certain shortcomings too.

利用强大 LLM 实现无参考（reference-free）评估，正成为一项前景广阔的新兴方案：相比传统指标，它与人类主观判断的相关性更高，同时对人工标注的依赖也显著降低。诸如 [G-Eval](https://arxiv.org/abs/2303.16634?ref=blog.langchain.com) 等研究已对此展开探索，并取得了令人鼓舞的初步成果；但该方法亦存在若干固有局限。

LLM prefers outputs their own outputs and when asked to compare between different outputs the relative position of those outputs matters more. LLMs can also have a bias toward a value when asked to score given a range and they also prefer longer responses. Refer to the [Large Language Models are not Fair Evaluators paper](https://arxiv.org/abs/2305.17926?ref=blog.langchain.com) for more. Ragas aims to work around these limitations of using LLMs to evaluate your QA pipelines while also providing actionable metrics using as little annotated data as possible, cheaper, and faster.

大语言模型倾向于偏好自身生成的输出；当被要求对多个不同输出进行比较时，其相对排序位置（relative position）反而比内容质量本身更具影响力。此外，在给定评分区间内对输出打分时，LLM 可能表现出对特定数值的系统性偏差；同时，它还普遍存在“长度偏好”（preference for longer responses）现象。更多细节请参阅论文：[《大语言模型并非公平的评估者》](https://arxiv.org/abs/2305.17926?ref=blog.langchain.com)。Ragas 的设计目标，正是规避上述 LLM 用于 QA 流水线评估时的各类缺陷，同时以尽可能少的人工标注数据为基础，提供切实可用（actionable）、成本更低、速度更快的评估指标。

## Introducing Ragas

## 介绍 Ragas

Ragas 是一个框架，可帮助您从多个不同维度评估您的问答（QA）流水线。它为您提供若干指标，用于评估 QA 系统的各个关键方面，具体包括：

1. **检索效果评估指标**：提供 `context_relevancy`（上下文相关性）和 `context_recall`（上下文召回率），用以衡量您检索系统的性能。
2. **生成效果评估指标**：提供 `faithfulness`（忠实性），用于检测幻觉（hallucination）；以及 `answer_relevancy`（答案相关性），用于衡量答案与问题的相关程度（即答案是否切题）。

这四个维度指标的调和平均值即为 **Ragas 分数（ragas score）**，它是对 QA 系统在所有关键维度上综合性能的单一量化度量。

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_001.png)

大多数评估指标均无需标注数据（labeled data），因此用户可直接运行评估，无需预先构建人工标注的测试数据集，大幅降低了使用门槛。要运行 Ragas，您仅需准备若干问题；若使用 `context_recall` 指标，则还需提供参考答案。（支持“冷启动”方式构建测试数据集的功能也已列入开发路线图）

接下来，让我们实际体验 Ragas 的能力——以 LangChain 构建的一个 QA 链为例进行评估。

## Evaluating a QA chain

## 评估一个 QA 链

我们将基于纽约市（NYC）维基百科页面构建一个 QA 链，并在其上运行 Ragas 评估。这是一个典型的 QA 链实现；如需更深入的了解，欢迎查阅 [LangChain 官方文档](https://python.langchain.com/docs/use_cases/question_answering?ref=blog.langchain.com)。

```python
from langchain.document_loaders import WebBaseLoader
from langchain.indexes import VectorstoreIndexCreator
from langchain.chains import RetrievalQA
from langchain.chat_models import ChatOpenAI
```

# load the Wikipedia page and create index

# 加载 Wikipedia 页面并创建索引

loader = WebBaseLoader("https://en.wikipedia.org/wiki/New_York_City")
index = VectorstoreIndexCreator().from_loaders([loader])

# create the QA chain

# 创建问答链（QA chain）

llm = ChatOpenAI()
qa_chain = RetrievalQA.from_chain_type(
    llm, retriever=index.vectorstore.as_retriever(), return_source_documents=True
)

# testing it out

# 测试问答链

question = "How did New York City get its name?"
result = qa_chain({"query": question})
result["result"]

# output

# 输出

# 'New York City got its name in 1664 when it was renamed after the Duke of York, who later became King James II of England. The city was originally called New Amsterdam by Dutch colonists and was renamed New York when it came under British control.'

# '纽约市于1664年更名，以纪念后来成为英格兰国王詹姆斯二世的约克公爵。该市最初由荷兰殖民者命名为“新阿姆斯特丹”，在归属英国统治后被更名为“纽约”。'

```

in order to use Ragas with LangChain, first import all the metrics you want to use from ragas.metrics. Next import the RagasEvaluatorChain which is a langchain chain wrapper to convert a ragas metric into a langchain [EvaluationChain](https://python.langchain.com/docs/guides/evaluation/?ref=blog.langchain.com).

```

为在 LangChain 中使用 Ragas，首先需从 `ragas.metrics` 导入所有希望使用的评估指标；接着导入 `RagasEvaluatorChain` —— 这是一个 LangChain 链封装器，可将 Ragas 指标转换为 LangChain 的 [EvaluationChain](https://python.langchain.com/docs/guides/evaluation/?ref=blog.langchain.com)。

```python
from ragas.metrics import faithfulness, answer_relevancy, context_relevancy, context_recall
from ragas.langchain import RagasEvaluatorChain

# make eval chains

# 构建评估链（eval chains）

eval_chains = {
    m.name: RagasEvaluatorChain(metric=m)
    for m in [faithfulness, answer_relevancy, context_relevancy, context_recall]
}
```

Once the evaluator chains are created you can call the chain via the \_\_call\_\_() method with the outputs from the QA chain to run the evaluations

一旦创建好评估链，即可通过 `__call__()` 方法传入问答链（QA chain）的输出结果，从而执行各项评估。

```python
# evaluate

# 执行评估

for name, eval_chain in eval_chains.items():
    score_name = f"{name}_score"
    print(f"{score_name}: {eval_chain(result)[score_name]}")

# output

# 输出

# faithfulness_score: 1.0
# answer_relevancy_score: 0.9193459596511587
# context_relevancy_score: 0.07480974380786602
# context_recall_score: 0.9193459596511587
```

Ragas uses LLMs under the hood to do the evaluations but leverages them in different ways to get the measurements we care about while overcoming the biases they have. Let's learn more about how they work under the hood to see how.

Ragas 在底层使用大语言模型（LLM）执行评估任务，但以多种不同方式调用这些模型，从而获得我们所关注的各项指标，同时规避其固有偏见。接下来，让我们深入探究其内部工作机制，以更清晰地理解其原理。

## Under the hood

## 底层机制

> Optional, not required to follow the next steps but helps understand the inner workings of ragas.

> （可选步骤，非后续操作所必需，但有助于理解 Ragas 的内部工作原理。）

All the metrics are documented here but in this section let's try and understand how exactly each Ragas metric works.

所有指标均在此处有详细文档说明；但在本节中，我们将逐一解析每个 Ragas 指标的具体实现方式。

1. **Faithfulness**: measures the factual accuracy of the generated answer with the context provided. This is done in 2 steps. First, given a question and generated answer, Ragas uses an LLM to figure out the statements that the generated answer makes. This gives a list of statements whose validity we have we have to check. In step 2, given the list of statements and the context returned, Ragas uses an LLM to check if the statements provided are supported by the context. The number of correct statements is summed up and divided by the total number of statements in the generated answer to obtain the score for a given example.

1. **忠实度（Faithfulness）**：衡量生成答案在所提供上下文下的事实准确性。该指标分两步计算：  
　　第一步，给定一个问题和对应的生成答案，Ragas 利用 LLM 提取该答案中所包含的全部独立陈述（statements）；由此得到一个待验证真伪的陈述列表。  
　　第二步，Ragas 将该陈述列表与检索返回的上下文一同输入 LLM，判断每条陈述是否均可由上下文支持。最终，将被上下文支持的陈述数量除以生成答案中的总陈述数，即得到该样本的忠实度得分。

2. **Answer Relevancy**: measures how relevant and to the point the answer is to the question. For a given generated answer Ragas uses an LLM to find out the probable questions that the generated answer would be an answer to and computes similarity to the actual question asked.

2. **答案相关性（Answer Relevancy）**：衡量生成答案与原始问题之间的相关程度及切题性。对于某一生成答案，Ragas 利用 LLM 推断出“该答案最可能回答的是哪些问题”，再计算这些推断问题与实际提问之间的语义相似度。

3. **Context Relevancy**: measures the signal-to-noise ratio in the retrieved contexts. Given a question, Ragas calls LLM to figure out sentences from the retrieved context that are needed to answer the question. A ratio between the sentences required and the total sentences in the context gives you the score.

3. **上下文相关性（Context Relevancy）**：衡量所检索上下文中的信噪比。给定一个问题，Ragas 调用 LLM 识别出检索所得上下文中对回答该问题真正必要的句子；该指标即为“必要句子数”与“上下文中总句子数”的比值。

4. **Context Recall**: measures the ability of the retriever to retrieve all the necessary information needed to answer the question. Ragas calculates this by using the provided ground\_truth answer and using an LLM to check if each statement from it can be found in the retrieved context. If it is not found that means the retriever was not able to retrieve the information needed to support that statement.

4. **上下文召回率（Context Recall）**：衡量检索器能否完整召回回答问题所必需的全部信息。Ragas 基于提供的标准答案（ground\_truth answer），利用 LLM 逐条检查其中每个陈述是否均能在检索所得上下文中找到对应支撑；若某陈述未被找到，则表明检索器未能召回支撑该陈述所需的信息。

Understanding how each Ragas metric works gives you clues as to how the evaluation was performed making these metrics reproducible and more understandable. One easy way to visualize the results from Ragas is to use the traces from LangSmith and LangSmith’s evaluation features. Let's look more into that now

深入理解每个 Ragas 指标的工作机制，有助于我们把握评估过程的具体路径，从而使这些指标具备可复现性与更强的可解释性。可视化 Ragas 评估结果的一种便捷方式，是借助 LangSmith 的 trace 追踪功能及其内置评估能力。接下来，我们进一步探讨这一方案。

## Visualising the Evaluations with LangSmith

## 使用 LangSmith 可视化评估结果

While Ragas provides you with a few insightful metrics, it does not help you in the process of continuously evaluation of your QA pipeline in production. But this is where LangSmith comes in.

尽管 Ragas 提供了若干富有洞察力的评估指标，但它本身并不支持在生产环境中对问答（QA）流水线进行持续性评估。而 LangSmith 正是为此而生。

[LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) is a platform that helps to debug, test, evaluate, and monitor chains and agents built on any LLM framework. LangSmith offers the following benefits

[LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 是一个面向任意大语言模型框架所构建的链（chains）与智能体（agents）的平台，支持调试、测试、评估与监控。LangSmith 提供以下核心优势：

1. a platform to create and store a test dataset and run evaluations.

1. 支持创建并存储测试数据集，并运行各类评估任务。

2. a platform to visualise and dig into the evaluation results. Makes Ragas metrics explainable and reproducible.

2. 提供评估结果的可视化与深度分析能力，使 Ragas 指标更具可解释性与可复现性。

3. The ability to continuously add test examples from production logs if your app is also monitored with LangSmith.

3. 若您的应用已接入 LangSmith 监控，则可自动从生产日志中持续采集真实用户查询，将其转化为新的测试样例。

With `RagasEvaluatorChain` you can use the Ragas metrics for running LangSmith evaluations as well. To know more about LangSmith evaluations check out the [quickstart](https://docs.smith.langchain.com/evaluation/quickstart?ref=blog.langchain.com).

借助 `RagasEvaluatorChain`，您还可以使用 Ragas 指标来运行 LangSmith 评估。如需了解有关 LangSmith 评估的更多信息，请参阅 [快速入门指南](https://docs.smith.langchain.com/evaluation/quickstart?ref=blog.langchain.com)。

Let's start with your need to create a dataset inside LangSmith to store the test examples. We’re going to start off with a small dataset with 5 questions and answers to those questions (used only for the `context_recall` metric).

让我们先从在 LangSmith 中创建一个数据集开始，用于存储测试样例。我们将构建一个包含 5 个问题及其对应答案的小型数据集（仅用于 `context_recall` 指标）。

```python
# test dataset
eval_questions = [\
    "What is the population of New York City as of 2020?",\
    "Which borough of New York City has the highest population?",\
    "What is the economic significance of New York City?",\
    "How did New York City get its name?",\
    "What is the significance of the Statue of Liberty in New York City?",\
]

eval_answers = [\
    "8,804,000", # incorrect answer\
    "Queens",    # incorrect answer\
    "New York City's economic significance is vast, as it serves as the global financial capital, housing Wall Street and major financial institutions. Its diverse economy spans technology, media, healthcare, education, and more, making it resilient to economic fluctuations. NYC is a hub for international business, attracting global companies, and boasts a large, skilled labor force. Its real estate market, tourism, cultural industries, and educational institutions further fuel its economic prowess. The city's transportation network and global influence amplify its impact on the world stage, solidifying its status as a vital economic player and cultural epicenter.",\
    "New York City got its name when it came under British control in 1664. King Charles II of England granted the lands to his brother, the Duke of York, who named the city New York in his own honor.",\
    'The Statue of Liberty in New York City holds great significance as a symbol of the United States and its ideals of liberty and peace. It greeted millions of immigrants who arrived in the U.S. by ship in the late 19th and early 20th centuries, representing hope and freedom for those seeking a better life. It has since become an iconic landmark and a global symbol of cultural diversity and freedom.',\
]

examples = [{"query": q, "ground_truths": [eval_answers[i]]}\
           for i, q in enumerate(eval_questions)]
```

```python
# test dataset（测试数据集）
eval_questions = [\
    "截至2020年，纽约市的人口是多少？",\
    "纽约市五个行政区中，哪一个的人口最多？",\
    "纽约市的经济意义是什么？",\
    "纽约市是如何得名的？",\
    "自由女神像在纽约市具有怎样的重要意义？",\
]

eval_answers = [\
    "8,804,000", # 错误答案\
    "皇后区",    # 错误答案\
    "纽约市的经济意义极为重大：它作为全球金融中心，汇聚了华尔街及众多大型金融机构；其经济结构高度多元化，涵盖科技、媒体、医疗、教育等多个领域，因而具备较强的抗经济波动能力；同时，纽约市是国际商业枢纽，吸引大量跨国企业入驻，并拥有庞大且技能娴熟的劳动力队伍；此外，其房地产市场、旅游业、文化产业和高等教育机构也持续推动着城市经济实力的增长；再加上发达的交通网络与全球影响力，进一步强化了纽约市在世界舞台上的地位，使其稳居全球经济重镇与文化中心之列。",\
    "1664年，纽约市被英国占领。英王查理二世将这片土地赐予其弟——约克公爵，后者为纪念自己，将该城命名为‘新约克’（New York）。",
    "纽约市的自由女神像是美国及其崇尚自由与和平理念的重要象征。19世纪末至20世纪初，数百万乘船抵达美国的移民都曾由她迎接，她代表着希望与自由，为那些追寻更好生活的人们带来慰藉。此后，自由女神像逐渐成为标志性地标，亦是全球范围内文化多样性与自由精神的象征。",\
]

examples = [{"query": q, "ground_truths": [eval_answers[i]]}\
           for i, q in enumerate(eval_questions)]
```

```python
# dataset creation
from langsmith import Client
from langsmith.utils import LangSmithError

client = Client()
dataset_name = "NYC test"

try:
    # check if dataset exists
    dataset = client.read_dataset(dataset_name=dataset_name)
    print("using existing dataset: ", dataset.name)
except LangSmithError:
    # if not create a new one with the generated query examples
    dataset = client.create_dataset(
        dataset_name=dataset_name, description="NYC test dataset"
    )
    for q in eval_questions:
        client.create_example(
            inputs={"query": q},
            dataset_id=dataset.id,
        )

    print("Created a new dataset: ", dataset.name)
```

```python
# 数据集创建
from langsmith import Client
from langsmith.utils import LangSmithError

client = Client()
dataset_name = "NYC test"

try:
    # 检查数据集是否已存在
    dataset = client.read_dataset(dataset_name=dataset_name)
    print("正在使用已有数据集：", dataset.name)
except LangSmithError:
    # 若不存在，则基于生成的问题样例新建一个数据集
    dataset = client.create_dataset(
        dataset_name=dataset_name, description="NYC test dataset（纽约市测试数据集）"
    )
    for q in eval_questions:
        client.create_example(
            inputs={"query": q},
            dataset_id=dataset.id,
        )

    print("已创建新数据集：", dataset.name)
```

If you go to the LangSmith dashboard and check the datasets section you should be able to see the dataset we just created.

如果您前往 LangSmith 控制台并查看“数据集”（Datasets）板块，即可看到我们刚刚创建的数据集。

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_002.png)  
LangSmith 数据集标签页中显示我们创建的 NYC 数据集

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_002.png)  
LangSmith 数据集标签页中显示我们创建的 NYC 数据集

To run the evaluations you have to call the `run_on_dataset()` function from the LangSmith SDK. But before that, you have to create a chain factory that will return a new QA chain every time this is called. This is so that any states in the QA chain are not reused when evaluating with individual examples. Make sure the QA chains return the context if using metrics that check on context.

要运行评估，您需调用 LangSmith SDK 中的 `run_on_dataset()` 函数。但在此之前，您必须创建一个链工厂（chain factory），使其每次被调用时都返回一个全新的 QA 链。这样可确保在使用各个独立样例进行评估时，QA 链中的任何状态都不会被复用。如果所用评估指标需检查上下文（context），请务必确保 QA 链返回上下文。

```python
# factory function that return a new qa chain
def create_qa_chain(return_context=True):
    qa_chain = RetrievalQA.from_chain_type(
        llm,
        retriever=index.vectorstore.as_retriever(),
        return_source_documents=return_context,
    )
    return qa_chain
```

```python
# 工厂函数：返回一个新的 QA 链
def create_qa_chain(return_context=True):
    qa_chain = RetrievalQA.from_chain_type(
        llm,
        retriever=index.vectorstore.as_retriever(),
        return_source_documents=return_context,
    )
    return qa_chain
```

Now let's configure and run the evaluation. You use `RunEvalConfig` to configure the evaluation with the metrics/evaluator chains that you want to run against and the `prediction_key` for the returned result. Now call `run_on_dataset` and LangSmith to use the dataset we uploaded and run it against the chain from the factory and evaluate with the `custom_evaluators` we provided and upload the results.

接下来，我们来配置并运行评估。您需使用 `RunEvalConfig` 来配置评估任务，指定希望运行的指标（metrics）或评估器链（evaluator chains），以及用于提取预测结果的 `prediction_key` 字段名。随后调用 `run_on_dataset`，让 LangSmith 使用我们上传的数据集，将其输入至由工厂函数生成的链，并利用我们提供的 `custom_evaluators` 进行评估，最后将结果上传。

```python
from langchain.smith import RunEvalConfig, run_on_dataset

evaluation_config = RunEvalConfig(
    custom_evaluators=[eval_chains.values()],
    prediction_key="result",
)

result = run_on_dataset(
    client,
    dataset_name,
    create_qa_chain,
    evaluation=evaluation_config,
    input_mapper=lambda x: x,
)

# output
# View the evaluation results for project '2023-08-24-03-36-45-RetrievalQA' at:
# https://smith.langchain.com/projects/p/9fb78371-150e-49cc-a927-b1247fdb9e8d?eval=true
```

```python
from langchain.smith import RunEvalConfig, run_on_dataset

evaluation_config = RunEvalConfig(
    custom_evaluators=[eval_chains.values()],
    prediction_key="result",
)

result = run_on_dataset(
    client,
    dataset_name,
    create_qa_chain,
    evaluation=evaluation_config,
    input_mapper=lambda x: x,
)

# 输出示例：
# 在以下链接查看项目 '2023-08-24-03-36-45-RetrievalQA' 的评估结果：
# https://smith.langchain.com/projects/p/9fb78371-150e-49cc-a927-b1247fdb9e8d?eval=true
```

Open up the results and you will see something like this

打开评估结果页面，您将看到类似如下界面：

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_003.png)  
![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_003.png)

This shows the output for each example in the training dataset and the Feedback columns show the evaluation results. Now if you want to dive more into the reasons for the scores and how to improve them, click on any single example and open the Feedback tab.

这显示了训练数据集中每个示例的输出，而“Feedback（反馈）”列则展示了评估结果。现在，若您希望深入探究各项得分的具体原因以及如何优化它们，请单击任意一个示例，并打开“Feedback（反馈）”标签页。

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_004.png)

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_004.png)

This will show you each score and if you open the pop-up icon it will point you to the evaluation run of the RagasEvaluatorChain.

这将为您展示每一项得分；若点击弹出图标，系统将引导您跳转至 `RagasEvaluatorChain` 的对应评估运行记录。

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_005.png)

![](images/evaluating-rag-pipelines-with-ragas-langsmith/img_005.png)

You can analyze each result to see why it was so and this will give you ideas on how to improve it.

您可以逐条分析各项结果，了解其得分原因，从而获得优化系统的具体思路。

Now if your QA pipeline also uses LangSmith for logging, tracing, and monitoring you can leverage the add-to-dataset feature to set up a continuous evaluation pipeline that keeps adding interesting data points (based on human feedback of other indirect methods) into the test to keep the test dataset up to date with a more comprehensive dataset with wider coverage.

此外，如果您的问答（QA）流水线已使用 LangSmith 进行日志记录、链路追踪与监控，则可利用其“add-to-dataset（添加至数据集）”功能，构建一条持续评估流水线：该流水线会持续将具有代表性的新数据点（例如基于人工反馈或其他间接方法识别出的样本）自动加入测试集，从而确保测试数据集始终更新、更全面、覆盖范围更广。

## Conclusion

## 总结

Ragas enhances QA system evaluation by addressing limitations in traditional metrics and leveraging Large Language Models. LangSmith provides a platform for running evaluations and visualizing results.

Ragas 通过弥补传统评估指标的局限性，并充分利用大语言模型（LLM），显著提升了问答（QA）系统评估的深度与有效性；LangSmith 则为执行评估任务及可视化结果提供了统一平台。

By using Ragas and LangSmith, you can ensure your QA systems are robust and ready for real-world applications, making the development process more efficient and reliable.

借助 Ragas 与 LangSmith 的协同能力，您可确保所构建的 QA 系统具备强健性与实用性，真正满足真实场景需求，同时大幅提升开发流程的效率与可靠性。
{% endraw %}
