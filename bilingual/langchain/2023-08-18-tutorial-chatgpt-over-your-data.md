---
title: "Tutorial: ChatGPT Over Your Data"
source: "LangChain Blog"
url: "https://blog.langchain.com/tutorial-chatgpt-over-your-data/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:53:46.572456328+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

**_Note: See the accompanying GitHub repo for this blogpost [here](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)._**

**_注：本文配套的 GitHub 仓库请见 [此处](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)。_**

ChatGPT has taken the world by storm. Millions are using it. But while it’s great for general purpose knowledge, it only knows information about what it has been trained on, which is pre-2021 generally available internet data. It doesn’t know about your private data, it doesn’t know about recent sources of data.

ChatGPT 已席卷全球，数以百万计的用户正在使用它。然而，尽管它在通用知识问答方面表现出色，其知识却仅限于训练时所用的数据——通常是截至 2021 年前公开可获取的互联网信息。它不了解你的私有数据，也不了解近期产生的新数据源。

Wouldn’t it be useful if it did?

如果它能访问这些数据，岂不是非常有用？

This blog post is a tutorial on how to set up your own version of ChatGPT over a specific corpus of data. There is an [accompanying GitHub repo](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com) that has the relevant code referenced in this post. Specifically, this deals with text data. For how to interact with other sources of data with a natural language layer, see the below tutorials:

本文是一篇教程，介绍如何基于特定语料库构建属于你自己的“ChatGPT”。本帖中提及的所有相关代码均托管于 [配套 GitHub 仓库](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)。需特别说明的是，本教程聚焦于**文本数据**。若想了解如何通过自然语言接口与其它类型的数据源交互，请参考以下教程：

- [SQL Database](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com)  
- [APIs](https://python.langchain.com/docs/modules/chains/popular/api?ref=blog.langchain.com)

## High Level Walkthrough

## 整体流程概览

At a high level, there are two components to setting up ChatGPT over your own data: (1) ingestion of the data, (2) chatbot over the data. Walking through the steps of each at a high level here:

从宏观角度看，在自有数据上部署 ChatGPT 包含两大核心环节：（1）数据接入（Ingestion），（2）基于该数据的对话机器人（Chatbot）。以下将分别概述这两个环节的关键步骤：

### Ingestion of data

### 数据接入

![](images/tutorial-chatgpt-over-your-data/img_001.png)Diagram of ingestion process

![](images/tutorial-chatgpt-over-your-data/img_001.png)数据接入流程示意图

This can be broken in a few sub steps. All of these steps are highly modular and as part of this tutorial we will go over how to substitute steps out. The steps are:

该过程可进一步细分为若干子步骤。所有步骤均高度模块化；在本教程中，我们将逐一讲解如何灵活替换其中任一环节。具体步骤如下：

1. 加载数据源为文本：这涉及将数据从任意来源加载为文本格式，以便后续流程使用。这是社区可提供帮助的重要环节之一！

1. Load data sources to text: this involves loading your data from arbitrary sources to text in a form that it can be used downstream. This is one place where we hope the community will help out!

2. 文本分块：这涉及将已加载的文本切分为更小的片段。之所以需要这样做，是因为语言模型通常对可处理的文本长度存在限制，因此需尽可能生成较小的文本块。

2. Chunk text: this involves chunking the loaded text into smaller chunks. This is necessary because language models generally have a limit to the amount of text they can deal with, so creating as small chunks of text as possible is necessary.

3. 文本嵌入：这涉及为每个文本块生成一个数值型向量表示（embedding）。之所以需要这样做，是因为我们仅希望针对特定问题选出最相关的文本块；而实现该目标的方式，是在嵌入空间中查找语义最相近的文本块。

3. Embed text: this involves creating a numerical embedding for each chunk of text. This is necessary because we only want to select the most relevant chunks of text for a given question, and we will do this by finding the most similar chunks in the embedding space.

4. 将嵌入向量存入向量数据库（vectorstore）：这涉及将嵌入向量及其对应的原始文档一同存入向量数据库。向量数据库可帮助我们在嵌入空间中快速、高效地检索出最相似的文本块。

4. Load embeddings to vectorstore: this involves putting embeddings and documents into a vectorstore. Vectorstores help us find the most similar chunks in the embedding space quickly and efficiently.

### 数据查询（Querying of Data）

### 查询数据

![](images/tutorial-chatgpt-over-your-data/img_002.png)Diagram of query process

![](images/tutorial-chatgpt-over-your-data/img_002.png)查询流程示意图

该过程同样可拆解为若干步骤。与前述流程一样，这些步骤高度模块化，且主要依赖可通过替换灵活调整的提示词（prompts）。具体步骤如下：

This can also be broken into a few steps. Again, these steps are highly modular, and mostly rely on prompts that can be substituted out. The steps are:

1. 将聊天历史与新提出的问题合并为一个独立、自包含的问题。这一操作十分必要，因为它支持用户进行追问（这是用户体验设计中的关键考量）。

1. Combine chat history and a new question into a single standalone question. This is necessary because we want to allow for the ability to ask follow up questions (an important UX consideration).

2. 检索相关文档：利用数据摄入（ingestion）阶段构建的嵌入向量和向量数据库，我们可以为当前问题检索出最相关的文档。

2. Lookup relevant documents. Using the embeddings and vectorstore created during ingestion, we can look up relevant documents for the answer.

3. 生成响应：在给定独立问题及检索到的相关文档的前提下，我们可调用语言模型生成最终回答。

3. Generate a response. Given the standalone question and the relevant documents, we can use a language model to generate a response.

我们还将简要介绍该聊天机器人的部署方法，但不会深入展开（相关内容留待后续文章详述！）

We will also briefly touch on deployment of this chatbot, though not spend too much time on that (future post!)

## 数据摄入（Ingestion of data）

## 数据摄入

本节将深入探讨完成数据摄入所需的具体步骤。

This section dives into more detail on the steps necessary to ingest data.

![](images/tutorial-chatgpt-over-your-data/img_003.png)Diagram of ingestion process

![](images/tutorial-chatgpt-over-your-data/img_003.png)数据摄入流程示意图

### 加载数据（Load Data）

### Load Data

First, we need to load data into a standard format. Again, because this tutorial is focused on text data, the common format will be a LangChain Document object. This object is pretty simple and consists of (1) the text itself, (2) any metadata associated with that text (where it came from, etc).

首先，我们需要将数据加载为标准格式。同样，由于本教程聚焦于文本数据，通用格式将是 LangChain 的 `Document` 对象。该对象结构非常简单，包含两部分：(1) 文本内容本身；(2) 与该文本关联的任意元数据（例如来源信息等）。

Because there are so many potential places to load data from, this is one area we hope will be driven a lot by the community. At the very least, we hope to get a lot of example notebooks on how to load data from sources. Ideally, we will add the loading logic into the core library. See [here](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com) for existing example notebooks, and see [here](https://github.com/hwchase17/langchain/tree/master/langchain/document_loaders?ref=blog.langchain.com) for the underlying code. If you want to contribute, feel free to open a PR directly or open a GitHub issue with a snippet of your work.

由于数据可能来自大量不同来源，我们希望这一环节能主要由社区推动。至少，我们期待积累大量示例 Notebook，展示如何从各类数据源加载数据；理想情况下，这些加载逻辑将被整合进 LangChain 核心库中。现有示例 Notebook 可参见[此处](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)，底层代码可参见[此处](https://github.com/hwchase17/langchain/tree/master/langchain/document_loaders?ref=blog.langchain.com)。如果您希望贡献代码，欢迎直接提交 Pull Request，或在 GitHub 上新建 Issue 并附上您的代码片段。

The line below contains the line of code responsible for loading the relevant documents. If you want to change the logic for how the documents are loading, this is the line of code you should change.

下方这行代码负责加载相关文档。如需修改文档加载逻辑，请修改此行代码。

```python
loader = UnstructuredFileLoader("state_of_the_union.txt")
raw_documents = loader.load()
```

```python
loader = UnstructuredFileLoader("state_of_the_union.txt")
raw_documents = loader.load()
```

### Split Text

### 文本切分

In addition to just loading the text, we also need to make sure to chunk it up into small pieces. This is necessary in order to make sure we only pass the smallest, most relevant pieces of text to the language model. In order to split up the text, we will need to initialize a text splitter and then call it on the raw documents.

除了加载文本外，我们还需将其切分为较小的片段。这是必要的，以确保仅向语言模型传递最小且最相关的文本片段。为此，我们需要先初始化一个文本切分器（text splitter），再将其应用于原始文档。

The lines below are responsible for this. If you want to change how to the text is split, you should change these lines

以下几行代码负责执行该操作。如需修改文本切分方式，请修改这几行代码。

```python
text_splitter = RecursiveCharacterTextSplitter()
documents = text_splitter.split_documents(raw_documents)
```

```python
text_splitter = RecursiveCharacterTextSplitter()
documents = text_splitter.split_documents(raw_documents)
```

### Create embeddings and store in vectorstore

### 生成嵌入向量并存入向量数据库（vectorstore）

Next, now that we have small chunks of text we need to create embeddings for each piece of text and store them in a vectorstore. This is done so that we can use the embeddings to find only the most relevant pieces of text to send to the language model.

接下来，在获得文本小片段后，我们需要为每一段文本生成嵌入向量（embeddings），并将其存入向量数据库（vectorstore）。这样做的目的是利用嵌入向量检索出最相关的文本片段，仅将这些片段送入语言模型。

This is done with the following lines. Here we use OpenAI’s embeddings and a FAISS vectorstore. If we wanted to change either the embeddings used or the vectorstore used, this is where we would change them.

以下代码实现了这一操作。此处我们使用 OpenAI 的嵌入模型（embeddings）和 FAISS 向量数据库（vectorstore）。如果需要更换所用的嵌入模型或向量数据库，就在此处进行修改。

```python
embeddings = OpenAIEmbeddings()
vectorstore = FAISS.from_documents(documents, embeddings)
```

```python
embeddings = OpenAIEmbeddings()
vectorstore = FAISS.from_documents(documents, embeddings)
```

Finally, we save the created vectorstore so we can use it later. That way, we only need to run this ingest script once.

最后，我们将创建好的向量数据库保存下来，以便后续重复使用。这样，该数据导入脚本只需运行一次即可。

```python
with open("vectorstore.pkl", "wb") as f:
	pickle.dump(vectorstore, f)
```

```python
with open("vectorstore.pkl", "wb") as f:
	pickle.dump(vectorstore, f)
```

This is the entirety of the ingestion script! After you’ve modified this according to your preferences, you can then run \`python ingest\_data.py\` to run the script. This should generate a \`vectorstore.pkl\` file.

以上即为完整的数据导入脚本！根据您的具体需求完成相应修改后，即可通过执行命令 \`python ingest\_data.py\` 运行该脚本。运行成功后将生成一个名为 \`vectorstore.pkl\` 的文件。

## Query data

## 查询数据

So now that we’ve ingested the data, we can now use it in a chatbot interface. In order to do this, we will use the [ChatVectorDBChain](https://python.langchain.com/docs/modules/chains/popular/chat_vector_db?ref=blog.langchain.com). In order to customize this chain, there are a few things we can change.

现在，数据已成功导入，我们可以将其集成至聊天机器人界面中加以使用。为此，我们将采用 [ChatVectorDBChain](https://python.langchain.com/docs/modules/chains/popular/chat_vector_db?ref=blog.langchain.com)。若需对该链（chain）进行定制化配置，有若干参数可供调整。

![](images/tutorial-chatgpt-over-your-data/img_004.png)Diagram of ChatVectorDBChain

![](images/tutorial-chatgpt-over-your-data/img_004.png)ChatVectorDBChain 结构示意图

### Condense Question Prompt

### 问题凝练提示词（Condense Question Prompt）

The first thing we can control is the prompt that takes in the chat history and new question and produces a standalone question. This is necessary because this standalone question is then used to look up relevant documents.

我们可调控的第一项内容，是用于接收对话历史与新提出的问题、并生成一个独立完整问题的提示词（prompt）。之所以需要生成这样一个独立问题，是因为后续将依据该问题检索相关文档。

This is a sneaky important step. If you just used the new question to look up relevant documents, your chatbot will not work well for follow up questions (because there may be information in the previous exchange that is needed to look up relevant docs). If you embed the whole chat history along with the new question to look up relevant documents, you may pull in documents no longer relevant to the conversation (if the new question is not related at all). Therefor, this step of condensing the chat history and a new question to a standalone question is very important.

这一步看似隐蔽，实则至关重要。如果你仅用新提出的问题去检索相关文档，你的聊天机器人在处理后续问题时将表现不佳（因为前序对话中可能包含检索相关文档所必需的信息）；而如果你将整个对话历史连同新问题一起嵌入以检索相关文档，则可能引入与当前对话完全无关的文档（尤其是当新问题与之前话题毫无关联时）。因此，将对话历史与新问题浓缩为一个独立、自包含的问题，这一环节极为关键。

This prompt is the CONDENSE_QUESTION_PROMPT in the `query_data.py` file.

该提示词即 `query_data.py` 文件中的 `CONDENSE_QUESTION_PROMPT`。

### Question-Answering Prompt

### 问答提示词（Question-Answering Prompt）

The other lever you can pull is the prompt that takes in documents and the standalone question to answer the question. This can be customized to give your chatbot a particular conversational style.

另一个可调节的关键参数，是用于接收文档和上述独立问题、并据此生成答案的提示词。你可以自定义该提示词，从而赋予聊天机器人特定的对话风格。

This prompt is the QA_PROMPT in the `query_data.py` file.

该提示词即 `query_data.py` 文件中的 `QA_PROMPT`。

Note: when working off of the GitHub repo, you MUST change this prompt. The current prompt in there specifies that they should only answer questions about the state of the union address, which works for the dummy example but is probably not good for your use case.

注意：若基于 GitHub 仓库进行开发，你**必须修改此提示词**。当前仓库中该提示词限定模型仅回答关于“国情咨文”（State of the Union Address）的问题——这适用于示例场景，但大概率不适用于你的实际应用场景。

### Language Model

### 语言模型（Language Model）

The final lever to pull is what language model you use to power your chatbot. In our example we use the OpenAI LLM, but this can easily be substituted to other language models that LangChain supports, or you can even write your own wrapper.

最后一个可调节的关键参数，是你为聊天机器人选用的语言模型。在我们的示例中，我们使用的是 OpenAI 的大语言模型（LLM），但你可以轻松将其替换为 LangChain 所支持的其他语言模型，甚至可以自行编写适配器（wrapper）。

## Putting it all together

## 整合所有组件

After making all the necessary customizations, and running `python ingest_data.py`, how do you interact with this chatbot?

完成所有必要定制后，并执行 `python ingest_data.py`，你该如何与这个聊天机器人进行交互？

We’ve exposed a really simple interface through which you can do. You can access this just by running `python cli_app.py` and this will open in the terminal a way to ask questions and get back answers. Try it out!

我们已提供一个极其简洁的接口供您使用。只需运行 `python cli_app.py` 即可启动该接口，它将在终端中打开一个交互式界面，让您能够提问并获取答案。快试试看吧！

![](images/tutorial-chatgpt-over-your-data/img_005.png)

We also have an example of deploying this app via Gradio! You can do so by running `python app.py`. This can also easily be deployed to Hugging Face spaces - see [example space here](https://huggingface.co/spaces/hwchase17/chat-your-data-state-of-the-union?ref=blog.langchain.com).

我们还提供了通过 Gradio 部署该应用的示例！您只需运行 `python app.py` 即可启动。该应用也可轻松部署至 Hugging Face Spaces —— 请参见[此处的示例空间](https://huggingface.co/spaces/hwchase17/chat-your-data-state-of-the-union?ref=blog.langchain.com)。

![](images/tutorial-chatgpt-over-your-data/img_006.png)

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/tutorial-chatgpt-over-your-data/img_007.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/tutorial-chatgpt-over-your-data/img_007.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/tutorial-chatgpt-over-your-data/img_008.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中推出端到端 OpenTelemetry 支持](images/tutorial-chatgpt-over-your-data/img_008.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中推出端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/tutorial-chatgpt-over-your-data/img_009.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/tutorial-chatgpt-over-your-data/img_009.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/tutorial-chatgpt-over-your-data/img_010.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/tutorial-chatgpt-over-your-data/img_010.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/tutorial-chatgpt-over-your-data/img_011.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![借助 LangSmith SDK v0.2 实现更便捷的评估](images/tutorial-chatgpt-over-your-data/img_011.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 更轻松地开展评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/tutorial-chatgpt-over-your-data/img_012.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/tutorial-chatgpt-over-your-data/img_012.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟