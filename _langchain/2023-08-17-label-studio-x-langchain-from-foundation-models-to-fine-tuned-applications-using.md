---
render_with_liquid: false
title: "Label Studio x LangChain: From Foundation Models to Fine-Tuned Applications Using Label Studio"
source: "LangChain Blog"
url: "https://blog.langchain.com/from-foundation-models-to-fine-tuned-applications-using-label-studio/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:11:01.134166460+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_**Editor's Note:** This post was written by Jimmy Whitaker, Data Scientist in Residence at [HumanSignal](https://humansignal.com/?ref=blog.langchain.com). [Label Studio](https://labelstud.io/blog/from-foundation-models-to-fine-tuned-applications-using-label-studio/?ref=blog.langchain.com) is an open-source data labeling platform that provides LangChain with flexibility when it comes to labeling data for fine-tuning large language models (LLMs). It also enables the preparation of custom training data and the collection and evaluation of responses through human feedback, a critical part of ongoing evaluation and maintenance of expert systems._

_**编者按：** 本文作者为 Jimmy Whitaker，现任 [HumanSignal](https://humansignal.com/?ref=blog.langchain.com) 驻场数据科学家。[Label Studio](https://labelstud.io/blog/from-foundation-models-to-fine-tuned-applications-using-label-studio/?ref=blog.langchain.com) 是一个开源数据标注平台，为 LangChain 在大语言模型（LLM）微调所需的数据标注环节提供了高度灵活性。它还支持构建定制化训练数据，并通过人工反馈收集与评估模型输出——这是专家系统持续评估与运维中至关重要的环节。_

## Introduction

## 引言

Quality is a critical issue when applying large language models (LLMs) to the real world. LLMs, particularly foundation models, are trained on vast corpuses of data, giving them a general "understanding" of the world that is nothing less than jaw-dropping. But, along with this wide coverage, LLMs also inherit an internet-level bias that is near impossible to fully understand, let alone control. This ubiquitous bias poses a challenge because it doesn't always align with the expectations and requirements of our unique application domains. Therefore, a one-size-fits-all LLM often falls short of the expectation of providing quality responses for specific applications.

在将大语言模型（LLM）应用于现实世界时，“质量”是一个关键问题。尤其是基础模型（foundation models），其训练依赖于海量语料库，从而获得了一种令人惊叹的、对世界的泛化“理解”。但与此同时，这种广泛覆盖也使 LLM 继承了近乎互联网级别的偏见——这类偏见不仅极难被全面理解，更遑论有效控制。这种无处不在的偏见构成了严峻挑战：它往往无法契合我们特定应用场景所设定的预期与需求。因此，“通用型”LLM 常常难以满足特定业务场景对高质量响应的严苛要求。

This is not to say that focusing on the quantity of data has not been instrumental in achieving phenomenal results for general chatbots. But as much as these LLMs are data-rich, their application in the real world leaves room for improvement. Quality, not quantity, becomes the key issue. For business applications, contextual awareness, data privacy, and the ability to control these applications are vital requirements. LLMs and applications built on top of them need continuous fine-tuning to suit specific domains and align the model with our precise needs. The ability to do this consistently and reliably is becoming integral for vertical-specific LLM applications.

这并非否定数据“数量”在通用聊天机器人领域取得惊人成果所发挥的关键作用。然而，尽管这些 LLM 拥有海量训练数据，其在真实业务场景中的落地效果仍有提升空间。“质量”，而非“数量”，正日益成为核心议题。对企业级应用而言，上下文感知能力、数据隐私保护以及对系统的可控性，都是不可或缺的基本要求。LLM 及其上层应用必须持续进行微调，以适配特定垂直领域，并精准对齐我们的实际需求。能否稳定、可靠地实现这一目标，已成为面向垂直行业的 LLM 应用落地的关键能力。

Additionally, we must continuously tune and improve our models and applications. This ongoing tuning ensures that our language models perform optimally within our domains and do not propagate biases we'd rather leave behind.

此外，我们必须持续调优并改进模型与应用。这种持续调优机制，可确保语言模型在其所属业务领域内始终发挥最优性能，同时避免延续那些我们希望摒弃的偏见。

These challenges require organizing and evaluating data for application-specific tuning and evaluating model quality. These needs bring us to the star of the day - [Label Studio](https://labelstud.io/?ref=blog.langchain.com).

应对上述挑战，亟需对数据进行组织与评估，以支撑面向具体应用的模型调优及模型质量评测。而满足这些需求的核心工具，正是今日的主角——[Label Studio](https://labelstud.io/?ref=blog.langchain.com)。

## Label Studio: Your LLM Tuner

## Label Studio：您的 LLM 调优助手

Label Studio plays an indispensable role in the ongoing process of improving large language models and the applications surrounding them. It is a platform to capture and annotate user interactions with our applications. This ability is vital for understanding our models' performance and pinpointing areas where adjustments are necessary.

Label Studio 在持续优化大语言模型及其配套应用的过程中扮演着不可或缺的角色。它是一个用于捕获并标注用户与应用程序交互行为的平台。这一能力对于深入理解模型的实际表现、精准识别亟待调整的关键环节至关重要。

In this blog post, we'll explore how Label Studio can be employed as a tool for continuous improvement, specifically in building a Question-Answering (QA) system trained to answer questions about Label Studio itself, using the domain-specific knowledge from [Label Studio’s GitHub documentation](https://github.com/HumanSignal/label-studio?ref=blog.langchain.com).

在本文中，我们将探讨如何将 Label Studio 作为持续优化的工具加以运用——具体而言，是构建一个问答（QA）系统，该系统经专门训练，能够基于 [Label Studio 的 GitHub 文档](https://github.com/HumanSignal/label-studio?ref=blog.langchain.com) 所提供的领域知识，准确回答有关 Label Studio 自身的各种问题。

However, it’s important to note that our conversation about QA is just a starting point. Label Studio's functionality extends well beyond simple QA scenarios. It can classify sentiments in responses, rate the answers provided by LLMs, extract specific entities, and even work with audio and visual data. While our focus here is on a QA system to demonstrate a comprehensive approach to tuning an LLM application, the potential applications are boundless.

但需要强调的是，本文围绕 QA 场景展开的讨论仅是一个起点。Label Studio 的功能远不止于简单的问答任务：它可对用户反馈进行情感分类，对 LLM 生成的回答进行质量评分，执行特定实体抽取，甚至支持音频与视觉数据的标注。尽管本文聚焦于 QA 系统，旨在展示一种面向 LLM 应用的系统性调优方法，但 Label Studio 的潜在应用场景实则无限广阔。

Let’s think about the QA process: as users interact with the chatbot, we can capture what questions were asked, and the answers returned. This data is then sent to Label Studio, where it can be inspected and annotated to assess whether or not the response was appropriate. Through this process of answering questions and applying annotations, we can effectively gauge the quality of our system, and we should be able to use this data to continuously enhance our QA system as well.

让我们思考一下问答（QA）流程：当用户与聊天机器人交互时，我们可以捕获用户提出的问题以及机器人返回的答案。这些数据随后被发送至 Label Studio，在那里可被人工检查和标注，以评估响应是否恰当。通过这一“提问—响应—标注”的闭环过程，我们能够有效衡量系统的质量，并利用这些标注数据持续优化我们的 QA 系统。

Before we proceed further, it's worth emphasizing two critical points:

在进一步展开之前，有必要强调两个关键要点：

1. **Contextual Understanding:** Foundation Models, especially in their initial stages, might not completely grasp the full context of, say, a GitHub repository. It means there's always a potential risk of the QA bot churning out irrelevant or nonsensical responses. This underlines the importance of continuously reviewing and verifying the bot's answers.

1. **上下文理解能力**：基础模型（Foundation Models），尤其是在其初始阶段，可能无法完全理解例如 GitHub 仓库这样的复杂上下文。这意味着问答机器人始终存在生成无关或无意义回答的风险。这也凸显了持续审查与验证机器人回答的必要性。

2. **Dynamic Data Sources:** Just when you think you've achieved a good quality level, remember that data sources (like GitHub repos) are living entities. They evolve, change, and occasionally, this could lead the bot to err. Hence, the need for regular oversight always remains.

2. **动态数据源**：即便你认为系统已达到理想的高质量水平，请务必牢记：数据源（如 GitHub 仓库）是持续演进的“活体”。它们会不断更新、变更，有时甚至会导致机器人出错。因此，定期人工监督始终不可或缺。

Ultimately, our aim for the QA system serves as a blueprint for continuous enhancement across LLM applications. We want a system that allows us to strategically navigate the continuous cycle of feedback and adaptation, all while allowing us to incorporate human understanding. This continuous feedback loop is how we create valuable AI solutions.

最终，我们构建 QA 系统的目标，旨在为大语言模型（LLM）各类应用的持续优化提供一套可复用的方法论蓝图。我们期望打造一个系统，使其能战略性地驾驭“反馈—适应”的持续循环，同时无缝融入人类的专业判断与理解能力。正是这一持续反馈闭环，支撑我们打造出真正有价值的 AI 解决方案。

## Putting It Into Action

## 落地实践

To demonstrate this, let’s build a simple LLM-powered QA system to answer questions about Label Studio. You can check out the [full example](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com) on GitHub for more details.

为直观展示上述理念，我们将构建一个基于大语言模型（LLM）的简易问答系统，用于解答有关 Label Studio 的问题。更多细节请参阅 GitHub 上的[完整示例](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com)。

![](https://blog.langchain.com/content/images/2023/08/image-4.png)A Simple LLM-Powered QA System

![](https://blog.langchain.com/content/images/2023/08/image-4.png)一个简易的 LLM 驱动问答系统

## Step 1: Building a Simple QA System

## 第一步：构建简易问答系统

For this example we'll use [LangChain](https://www.langchain.com/?ref=blog.langchain.com), [ChromaDB](https://www.trychroma.com/?ref=blog.langchain.com), and [OpenAI](https://openai.com/?ref=blog.langchain.com) to construct our QA system. Though we opted to use OpenAI in this example due to its simplified integration, replacing it with other LLMs is feasible based on your preference.

本示例中，我们将使用 [LangChain](https://www.langchain.com/?ref=blog.langchain.com)、[ChromaDB](https://www.trychroma.com/?ref=blog.langchain.com) 和 [OpenAI](https://openai.com/?ref=blog.langchain.com) 构建问答系统。尽管本例选择 OpenAI 是因其集成简便，但您完全可以根据自身需求，将其替换为其他大语言模型（LLM）。

You can read more about our integration with LangChain [here](https://python.langchain.com/docs/integrations/callbacks/labelstudio?ref=blog.langchain.com).

您可在此处进一步了解我们与 LangChain 的集成方案：[相关文档链接](https://python.langchain.com/docs/integrations/callbacks/labelstudio?ref=blog.langchain.com)。

Here’s a brief overview of our approach.

这里是对我们的方法的简要概述。

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_002.png)Workflow for Building a Simple QA Chatbot

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_002.png)构建简易问答聊天机器人的工作流程

**Github as our dataset:** First, we need a dataset to build our document database for our QA system. Since we’re building a QA system for answering questions about Label Studio, we can use our documentation markdown files in the Label Studio Github repo as our source. LangChain makes this easy, taking just a few lines of code.

**数据集来源：GitHub**：首先，我们需要一个数据集来构建问答（QA）系统的文档数据库。由于我们正在构建一个用于解答有关 Label Studio 问题的 QA 系统，因此可将 Label Studio GitHub 仓库中的文档 Markdown 文件作为数据源。LangChain 让这一过程变得非常简单，仅需几行代码即可完成。

```
from langchain.document_loaders.git import GitLoader
from git import Repo

repo_path = "./data/label-studio-repo"
repo = Repo.clone_from("https://github.com/HumanSignal/label-studio",
  to_path=repo_path)
branch = repo.head.reference
loader = GitLoader(repo_path=repo_path,
  branch=branch,
  file_filter=lambda f: f.endswith('.md'))

data = loader.load()
```

```
from langchain.document_loaders.git import GitLoader
from git import Repo

repo_path = "./data/label-studio-repo"
repo = Repo.clone_from("https://github.com/HumanSignal/label-studio",
  to_path=repo_path)
branch = repo.head.reference
loader = GitLoader(repo_path=repo_path,
  branch=branch,
  file_filter=lambda f: f.endswith('.md'))

data = loader.load()
```

**LLM Embeddings for Documents:** Each document is represented by an embedding, a high-dimensional vector that captures the document's content retrieved from our LLM. These embeddings allow us to discern which documents are similar to one another. When a user submits a question, we can generate an embedding for it and retrieve relevant documents.

**文档的 LLM 嵌入表示**：每份文档均以嵌入向量（embedding）形式表示——这是一种高维向量，由大语言模型（LLM）生成，用以表征文档的内容。这些嵌入向量使我们能够判断不同文档之间的语义相似性。当用户提交一个问题时，我们可为其生成对应的嵌入向量，并据此检索出最相关的文档。

**Vector Database Storage:** We utilize a vector database, ChromaDB in this case, to hold our document embeddings. This allows for efficient document comparison with our embeddings and the ability to scale our system if needed.

**向量数据库存储**：我们采用向量数据库（本例中为 ChromaDB）来存储文档嵌入向量。这不仅支持基于嵌入向量的高效文档相似度计算，也使系统具备良好的可扩展性，便于未来按需扩容。

The following Python shows how we combine the feature extraction and vector database to create our QA system.

以下 Python 代码展示了我们如何将特征提取与向量数据库相结合，构建完整的问答系统。

```
from langchain.text_splitter import MarkdownTextSplitter
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Chroma
```

```
from langchain.text_splitter import MarkdownTextSplitter
from langchain.embeddings import OpenAIEmbeddings
from langchain.vectorstores import Chroma
```

```python
text_splitter = MarkdownTextSplitter(chunk_size = 500, chunk_overlap = 0)
all_splits = text_splitter.split_documents(data)

vectorstore = Chroma.from_documents(documents=all_splits,
  embedding=OpenAIEmbeddings())
```

```python
text_splitter = MarkdownTextSplitter(chunk_size = 500, chunk_overlap = 0)
all_splits = text_splitter.split_documents(data)

vectorstore = Chroma.from_documents(documents=all_splits,
  embedding=OpenAIEmbeddings())
```

Now that we have our embedding method and vector store with our documents imported, we’re ready to start answering questions. Our system prompt instructs the model to only rely on the documents it has received to answer the question, reducing the likelihood of hallucinated responses.

在成功导入文档并配置好嵌入方法（embedding method）与向量数据库（vector store）后，我们已准备好开始回答问题。系统提示词（system prompt）明确要求模型仅依据所接收的文档内容作答，从而显著降低产生幻觉响应（hallucinated responses）的可能性。

## Step 2: Capture User Interactions

## 第二步：捕获用户交互

Chat interfaces are incredibly useful for understanding and learning about topics. We created a simple [Gradio](https://www.gradio.app/?ref=blog.langchain.com) application to make interacting with the QA system easier.

聊天界面对于理解与学习各类主题极为有用。我们构建了一个简易的 [Gradio](https://www.gradio.app/?ref=blog.langchain.com) 应用，以简化用户与问答（QA）系统的交互过程。

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_003.png)A Gradio QA Chatbot with Label Studio Expertise

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_003.png)一款具备 Label Studio 专业能力的 Gradio 问答聊天机器人

Our goal isn't solely to address user queries; it's vital to grasp the system's effectiveness by examining the quality and relevance of the answers. Therefore, we've implemented a Label Studio callback in LangChain to capture both the posed question and the system's response.

我们的目标不仅限于响应用户提问；更重要的是，通过评估答案的质量与相关性，深入理解系统的实际效能。因此，我们在 LangChain 中集成了一个 Label Studio 回调（Label Studio callback），用于同步记录用户提出的问题及系统生成的回答。

```
class LabelStudioCallbackHandler(BaseCallbackHandler):

  def __init__(self, api_key, url, project_id):
    self.ls_client = ls.Client(url=url, api_key=api_key)
    self.ls_project = self.ls_client.get_project(project_id)
    self.prompts = {}

  def on_llm_start(self, serialized, prompts, **kwargs):
    self.prompts[str(kwargs["parent_run_id"] or kwargs["run_id"])] = prompts
```

```
class LabelStudioCallbackHandler(BaseCallbackHandler):

  def __init__(self, api_key, url, project_id):
    self.ls_client = ls.Client(url=url, api_key=api_key)
    self.ls_project = self.ls_client.get_project(project_id)
    self.prompts = {}

  def on_llm_start(self, serialized, prompts, **kwargs):
    self.prompts[str(kwargs["parent_run_id"] or kwargs["run_id"])] = prompts
```

```python
  def on_llm_end(self, response, **kwargs):
    run_id = str(kwargs["parent_run_id"] or kwargs["run_id"])
    prompts = self.prompts[run_id]
    tasks = []

    for prompt, generation in zip(prompts, response.generations):
      tasks.append({'prompt': prompt, 'response': generation[0].text})

    self.ls_project.import_tasks(tasks)
    self.prompts.pop(run_id)
```

```python
  def on_llm_end(self, response, **kwargs):
    run_id = str(kwargs["parent_run_id"] or kwargs["run_id"])
    prompts = self.prompts[run_id]
    tasks = []

    for prompt, generation in zip(prompts, response.generations):
      tasks.append({'prompt': prompt, 'response': generation[0].text})

    self.ls_project.import_tasks(tasks)
    self.prompts.pop(run_id)
```

This callback logs the queries and answers and directly inserts them into Label Studio. This provides an intuitive interface for examining, annotating, and evaluating the responses.

该回调函数记录查询与回答，并直接将其插入 Label Studio。这为检查、标注和评估模型响应提供了直观的交互界面。

## Step 3: Annotate the QA application’s performance

## 第三步：标注问答应用的性能表现

Once our data has landed in Label Studio, we have all the tools we need to understand and refine the data with our human expertise. There are many ways to refine your data, such as consensus gathering, applying filters, or even [using other LLMs to evaluate your data](https://labelstud.io/blog/data-labeling-with-gpt-4-ml-backend/?ref=blog.langchain.com).

当我们的数据成功导入 Label Studio 后，我们就拥有了借助人类专业知识来理解并优化数据所需的一切工具。优化数据的方式多种多样，例如开展多人共识标注（consensus labeling）、应用筛选条件，甚至可以[利用其他大语言模型（LLM）对数据进行评估](https://labelstud.io/blog/data-labeling-with-gpt-4-ml-backend/?ref=blog.langchain.com)。

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_004.png)Using Label Studio to Rate QA Chatbot Replies

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_004.png)使用 Label Studio 对问答聊天机器人回复进行评分

Our QA system utilizes a [custom template](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com#running-the-example) to view chat interactions. The flexibility to tailor these templates to our unique requirements ensures a labeling experience perfectly aligned with our needs. Whether adding new categories, allowing response edits, or incorporating other customizations, the system offers extensive adaptability. Learn more about how to [personalize templates](https://labelstud.io/guide/setup?ref=blog.langchain.com#Customize-a-template).

我们的问答系统采用了一个[自定义模板](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com#running-the-example)，用于呈现对话交互过程。这些模板高度可定制，能灵活适配我们的特定需求，从而确保标注体验完全契合实际工作流。无论是新增标注类别、允许编辑模型回复，还是集成其他个性化功能，系统均提供强大的可扩展性。了解更多关于[如何自定义模板](https://labelstud.io/guide/setup?ref=blog.langchain.com#Customize-a-template)的信息。

## Step 4: Gauging Quality

## 第四步：评估系统质量

As we accumulate answered questions and accompanying annotations, we can begin measuring the quality of our system. This feedback loop gives us insight into how well our LLM application performs and where it needs tuning.

随着已回答问题及其对应人工标注数据的持续积累，我们便可开始量化评估系统的整体质量。这一反馈闭环使我们能够清晰洞察大语言模型（LLM）应用的实际表现，并精准识别需要调优的关键环节。

For example, we may want to know the general accuracy of our system. We can use the number of examples labeled “good” in our dataset with the simple formula:

例如，我们可能希望了解系统整体的准确率。我们可以利用数据集中被标注为“good”（良好）的样本数量，并代入以下简单公式进行计算：

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_005.png)

We can simply view these numbers by filtering for the “good” results in the labeling interface to compute accuracy, or we can export the dataset for a more robust analysis.

我们只需在标注界面中筛选出标注结果为“good”的样本，即可直观查看这些数值并计算准确率；或者，我们也可以导出整个数据集，以开展更全面、深入的数据分析。

We can export our data in a CSV format in the UI. Once we have our dataset, we can perform any type of data analysis on our QA system, such as computing the percentage of irrelevant questions, out-of-domain responses, and so on.

我们可通过用户界面（UI）将数据导出为 CSV 格式。获得数据集后，即可对问答（QA）系统执行各类数据分析，例如：计算无关问题所占比例、域外（out-of-domain）回答所占比例等。

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_006.png)Export Data Dialog in Label Studio

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_006.png)Label Studio 中的“导出数据”对话框

Many of these metrics and dashboards are built-in features of the [enterprise version](https://humansignal.com/?ref=blog.langchain.com) of Label Studio to support more robust labeling workflows, as shown below.

如图所示，上述诸多指标与仪表板均为 Label Studio [企业版](https://humansignal.com/?ref=blog.langchain.com) 的内置功能，旨在支持更完善、更可靠的标注工作流。

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_007.png)Annotator Agreement Metrics in Label Studio Enterprise

![](images/label-studio-x-langchain-from-foundation-models-to-fine-tuned-applications-using/img_007.png)Label Studio 企业版中的标注员一致性评估指标

## Step 5: Improve the system

## 第五步：优化系统

The beauty of this iterative approach lies in its self-improving nature. As users engage with the system, we accrue invaluable feedback. We bolster the system’s contextual understanding by integrating positively reviewed ("good") responses into our document database. For more details on this snippet, see the [full example on](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com) GitHub.

这种迭代方法的精妙之处在于其自我增强特性：随着用户持续使用系统，我们将不断积累极具价值的反馈信息。通过将用户评价为正面（即标注为“good”）的回答整合进我们的文档数据库，可显著提升系统对上下文的理解能力。关于该代码片段的更多细节，请参阅 GitHub 上的[完整示例](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com)。

```
# Extract "good" examples and convert them to Documents
good_examples = extract_good_examples_from_jsonl(json_path)
docs = [Document(page_content=str(example), metadata={"source": json_path}) for example in good_examples]
```

```
# 提取标注为“good”的样例，并将其转换为 Document 对象
good_examples = extract_good_examples_from_jsonl(json_path)
docs = [Document(page_content=str(example), metadata={"source": json_path}) for example in good_examples]
```

# Add documents to the vector store and persist

# 向向量存储中添加文档并持久化

```python
vectorstore.add_documents(docs)
vectorstore.persist()
```

This approach can be advantageous to realize immediate improvements to our system, but this can become cumbersome. However, as our dataset grows larger and larger, we can incorporate other tuning techniques, such as fine-tuning the LLM or embeddings generator. Every user interaction, and every question and answer, becomes a valuable dataset. It paints a clearer picture of potential system gaps and general user pain points. Ultimately, this user-driven feedback loop fortifies our application, making it increasingly aligned with our domain and perpetually enhancing its response quality.

这种方案有助于快速提升系统性能，但也可能逐渐变得繁琐。然而，随着数据集持续扩大，我们可以引入其他调优技术，例如对大语言模型（LLM）或嵌入向量生成器进行微调。每一次用户交互、每一个问题与回答，都转化为宝贵的数据样本。这些数据能更清晰地揭示系统潜在缺陷及普遍的用户体验痛点。最终，这一由用户驱动的反馈闭环将不断强化我们的应用——使其日益契合特定业务领域，并持续提升响应质量。

## A Generative AI Workflow for Any QA System

## 适用于任意问答系统的生成式 AI 工作流

At the end of the day, we have a generative AI workflow that can be used to tune any QA system. It demonstrates the power of combining cutting-edge technologies like LangChain and Label Studio with LLMs from OpenAI, resulting in a robust solution to taming bias and boosting the quality of language models.

归根结底，我们构建了一套生成式 AI 工作流，可灵活适配并优化任意问答系统。该工作流充分展现了 LangChain 与 Label Studio 等前沿技术同 OpenAI 大语言模型协同整合的强大能力，从而形成一套稳健可靠的解决方案，有效抑制模型偏见、显著提升语言模型质量。

As we embrace this workflow, we open doors to creating more nuanced, domain-specific applications that not only answer user questions accurately but also do so in a manner that aligns closely with the values and needs of our unique domains. The continuous improvement of our LLM applications is thus not just a goal but an ongoing process that we are committed to – one made possible through innovative tools and a steadfast dedication to quality.

当我们采用这一工作流，便开启了构建更精细、更具领域特性的应用的大门：这些应用不仅能准确回答用户问题，更能以高度契合本领域价值观与实际需求的方式作出回应。因此，我们对大语言模型应用的持续优化，已不仅是一个目标，而是一项我们坚定践行的长期进程——它依托于创新工具的支持，也源于我们对品质始终如一的执着追求。

## Conclusion

## 结论

In an era where large language models (LLMs) have changed the landscape of AI-driven applications, ensuring their quality and relevance has never been more crucial. [The iterative approach we've discussed](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com) showcases the importance of fine-tuning these models to meet specific application requirements, particularly in overcoming inherent biases and ensuring domain-specific accuracy. This dynamic of quantity versus quality is at the forefront of making AI truly impactful in real-world scenarios. We've paved a promising way forward by employing Label Studio in tandem with LangChain and LLMs. Through continuous human feedback, iterative improvements, and domain-specific calibrations, we can ensure that our AI systems are powerful, precise, reliable, and aligned with user expectations.

在大语言模型（LLM）已深刻重塑 AI 应用格局的时代，保障其质量与相关性比以往任何时候都更为关键。[我们此前探讨的迭代式方法](https://github.com/HumanSignal/label-studio-examples/tree/master/question-answering-system?ref=blog.langchain.com)凸显了针对具体应用场景对模型进行微调的重要性——尤其在于克服模型固有偏见、确保领域内精准可靠。数量与质量之间的动态平衡，正是让 AI 在真实世界场景中真正发挥影响力的核心所在。我们通过协同运用 Label Studio、LangChain 与大语言模型，已开辟出一条前景广阔的实践路径。借助持续的人类反馈、反复迭代的优化过程以及面向领域的精细化校准，我们能够确保 AI 系统兼具强大能力、精准表现、高度可靠性，并始终契合用户的实际期望。

## Join the Label Studio Community!

## 加入 Label Studio 社区！

Open source is about building communities, sharing knowledge, and innovating together. Label Studio invites you to be a part of this movement. [Contribute to the project](https://github.com/humansignal/label-studio?ref=blog.langchain.com), [learn from the community](https://slack.labelstud.io/?source=blog), and harness the power of collective wisdom. Together, let's fine-tune the future of AI and make technology more inclusive and adaptive.

开源的本质在于共建社区、共享知识、协同创新。Label Studio 诚挚邀请您加入这场运动：[为项目贡献代码](https://github.com/humansignal/label-studio?ref=blog.langchain.com)，[向社区学习交流](https://slack.labelstud.io/?source=blog)，并充分释放集体智慧的力量。让我们携手同行，共同微调 AI 的未来，让技术更加包容、更具适应性。