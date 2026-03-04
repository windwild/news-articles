---
render_with_liquid: false
title: "Chat with your data using OpenAI, Pinecone, Airbyte and Langchain"
source: "LangChain Blog"
url: "https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/"
date: "2023-11-15"
scraped_at: "2026-03-03T08:26:22.117925210+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**_Editor’s Note: This blog post was written in collaboration with_** [**_Airbyte_**](https://airbyte.com/?ref=blog.langchain.com) **_. Their_** [**_new vector database destination_**](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com) **_makes it really easy for data to retrieve relevant context for question answering use cases via LangChain. We're seeing more and more teams seek ways to integrate diverse data sources–and keep them up-to-date automatically–and this is a fantastic way to do it!_**

**_编者注：本文由_** [**_Airbyte_**](https://airbyte.com/?ref=blog.langchain.com) **_联合撰写。他们推出的_** [**_全新向量数据库目标端（vector database destination）_**](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com) **_，使得借助 LangChain 实现问答类场景中相关上下文的高效检索变得极为简便。我们正目睹越来越多的团队迫切寻求整合多样化数据源的方法——并自动保持其持续更新——而这一方案无疑是极佳的选择！_**

**_Aside from the specific use case highlighted here, we're also very excited about this integration in general. It combines the hundreds of sources in AirByte with their robust scheduling and orchestration framework, and leverages the advanced transformation logic in LangChain along with LangChain's 50+ embedding provider integrations and 50+ vectorstore integrations._**

**_除本文重点介绍的这一具体应用场景外，我们对此次集成整体也倍感振奋。它将 Airbyte 支持的数百种数据源，与其强大的调度与编排框架相结合；同时充分利用 LangChain 先进的数据转换逻辑，以及 LangChain 所支持的 50 多种嵌入（embedding）提供商和 50 多种向量数据库（vectorstore）集成能力。_**

_Learn how to build a connector development support bot for Slack that knows all your APIs, open feature requests and previous Slack conversations by heart_

_学习如何构建一个 Slack 连接器开发支持机器人——它能熟记你所有的 API 接口、待办功能请求以及过往的 Slack 对话记录。_

In [a previous article](https://airbyte.com/tutorials/implement-ai-data-pipelines-with-langchain-airbyte-and-dagster?ref=blog.langchain.com), we explained how Dagster and Airbyte can be leveraged to power LLM-supported use cases. Our newly introduced [vector database destination](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com) makes this even easier as it removes the need to orchestrate chunking and embedding manually - instead the sources can be directly connected to the vector database through an Airbyte connection.

在[此前的一篇文章](https://airbyte.com/tutorials/implement-ai-data-pipelines-with-langchain-airbyte-and-dagster?ref=blog.langchain.com)中，我们已介绍如何结合 Dagster 与 Airbyte 构建支持大语言模型（LLM）的应用场景。而我们最新推出的[向量数据库目标端](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com)进一步简化了该流程：它免去了手动编排文本分块（chunking）与嵌入（embedding）的繁琐步骤；取而代之的是，数据源可直接通过 Airbyte 连接无缝接入向量数据库。

This tutorial walks you through a real-world use case of how to leverage vector databases and LLMs to make sense out of your unstructured data. By the end of this, you will:

本教程将带您完成一个真实世界的应用案例：如何利用向量数据库与大语言模型（LLM）从非结构化数据中提取价值与洞见。学完本教程后，您将能够：

- Know how to extract unstructured data from a variety of sources using Airbyte  
  - 掌握如何借助 Airbyte 从多种数据源中抽取非结构化数据；

- Know how to use Airbyte to efficiently load data into a vector database, preparing the data for LLM usage along the way  
  - 掌握如何使用 Airbyte 高效地将数据加载至向量数据库，并在过程中完成面向 LLM 使用的数据预处理；

- Know how to integrate a vector database into your LLM to ask questions about your proprietary data  
  - 掌握如何将向量数据库集成至您的 LLM 应用中，从而就您专有的业务数据提出自然语言问题并获得精准回答。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_001.png)

## What we will build

## 我们将构建什么

To better illustrate how this can look in practice, let’s use something that’s relevant for Airbyte itself.

为更直观地展示该方案在实际中的应用效果，我们以 Airbyte 自身为例展开说明。

Airbyte is a highly extensible system that allows users to develop their own connectors to extract data from any API or internal systems. Helpful information for connector developers can be found in different places:

Airbyte 是一个高度可扩展的系统，允许用户自主开发连接器，以从任意 API 或内部系统中抽取数据。面向连接器开发者的实用信息分散于多个渠道：

- The official connector development documentation website  
- 官方连接器开发文档网站  

- Github issues documenting existing feature requests, known bugs and work in progress  
- 记录现有功能需求、已知缺陷及正在进行工作的 GitHub Issues  

- The community Slack help channel  
- 社区 Slack 帮助频道  

This article describes how to tie together all of these diverse sources to offer a single chat interface to access information about connector development — a bot that can answer questions in plain English about the code base, documentation and reference previous conversations:  

本文介绍如何将上述各类异构信息源整合起来，构建一个统一的聊天界面，用于查询连接器开发相关信息——即一个能够以自然英文回答有关代码库、文档问题，并能参考过往对话内容的智能机器人：  

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_002.png)

In these examples, information from the documentation website and existing Github issues is combined in a single answer.  

在这些示例中，来自文档网站和现有 GitHub Issues 的信息被融合进同一个回答中。

## Prerequisites  

## 前置条件  

For following through the whole process, you will need the following accounts. However, you can also work with your own custom sources and use a local vector store to avoid all but the OpenAI account:  

要完整执行本流程，您需要以下账户。但您也可使用自定义数据源，并采用本地向量数据库（vector store），从而仅需保留 OpenAI 账户即可：

- Source-specific accounts  
- 与数据源相关的账户  

- Apify account  
- Apify 账户  

- Github account  
- GitHub 账户  

- Slack account  
- Slack 账户  

- Destination-specific accounts  
- 与目标系统相关的账户  

- OpenAI account  
- OpenAI 账户  

- Pinecone account  
- Pinecone 账户  

- Airbyte instance ( [local](https://docs.airbyte.com/deploying-airbyte/local-deployment/?ref=blog.langchain.com) or [cloud](https://cloud.airbyte.com/?ref=blog.langchain.com))  
- Airbyte 实例（[本地部署](https://docs.airbyte.com/deploying-airbyte/local-deployment/?ref=blog.langchain.com) 或 [云端服务](https://cloud.airbyte.com/?ref=blog.langchain.com)）

## Step 1 - Fetch Github issues  

## 第一步：获取 GitHub Issues  

Airbyte’s feature and bug tracking is handled by the [Github issue tracker](https://github.com/airbytehq/airbyte/issues?ref=blog.langchain.com) of the Airbyte open source repository. These issues contain important information people need to look up regularly.  

Airbyte 的功能需求与缺陷追踪由 Airbyte 开源仓库的 [GitHub Issue 跟踪器](https://github.com/airbytehq/airbyte/issues?ref=blog.langchain.com) 承担。这些 Issues 中包含用户日常频繁查阅的重要信息。

To fetch Github issues, create a new source using the Github connector.  

要获取 GitHub Issues，请使用 GitHub 连接器创建一个新的数据源。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_003.png)

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_003.png)

If you are using Airbyte Cloud, you can easily authenticate using the “Authenticate your GitHub account”, otherwise follow the instructions in the documentation on the right side of how to set up a [personal access token](https://github.com/settings/tokens?ref=blog.langchain.com) in the Github UI.

如果您正在使用 Airbyte Cloud，可直接点击“Authenticate your GitHub account”（认证您的 GitHub 账户）快速完成身份验证；否则，请参考右侧文档中的说明，在 GitHub 界面中创建一个 [个人访问令牌（Personal Access Token）](https://github.com/settings/tokens?ref=blog.langchain.com)。

Next, configure a cutoff date for issues and specify the repositories that should be synced. In this case I’m going with “2023-07-01T00:00:00Z” and “airbytehq/airbyte” to sync recent issues from the main Airbyte repository:

接下来，请为待同步的 Issues 配置截止日期，并指定需同步的代码仓库。本例中，我们设定截止时间为 `"2023-07-01T00:00:00Z"`，并选择仓库 `"airbytehq/airbyte"`，以同步主 Airbyte 仓库中近期提交的 Issues：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_004.png)

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_004.png)

## Step 2 - Load into vector database

## 第二步：将数据加载至向量数据库

Now we have our first source ready, but Airbyte doesn’t know yet where to put the data. The next step is to configure the destination. To do so, pick the “Pinecone” connector. There is some preprocessing that Airbyte is doing for you so that the data is vector ready:

目前，我们的首个数据源已准备就绪，但 Airbyte 尚未知晓应将数据写入何处。下一步是配置目标（destination）。为此，请选择 “Pinecone” 连接器。Airbyte 将自动为您执行若干预处理操作，确保数据满足向量化要求：

- Separating text and metadata fields and splitting up records into multiple documents to keep each document focused on a single topic and to make sure the text fits into the context window of the LLM that’s going to be used for question answering  
- 将文本字段与元数据字段分离，并将每条记录拆分为多个文档，以确保每个文档聚焦于单一主题，同时保证文本长度适配后续用于问答任务的大语言模型（LLM）的上下文窗口；
- Embedding the text of every document using the configured embedding service, turning the text into a vector to do similarity search on  
- 使用所配置的嵌入服务，对每个文档的文本生成嵌入向量，从而支持语义相似度检索；
- Indexing the documents into the vector database (uploading the vector from the embedding service along with the metadata object)  
- 将文档索引至向量数据库（即上传嵌入服务生成的向量及对应的元数据对象）。

Besides Pinecone, Airbyte supports loading data into Weaviate, Milvus, Qdrant and Chroma.

除 Pinecone 外，Airbyte 还支持将数据加载至 Weaviate、Milvus、Qdrant 和 Chroma 等向量数据库。

For using Pinecone, sign up for a [free trial account](https://app.pinecone.io/?sessionType=signup&ref=blog.langchain.com) and create an index using a starter pod. Set the dimensions to **1536** as that’s the size of the OpenAI embeddings we will be using.

如需使用 Pinecone，请注册一个 [免费试用账户](https://app.pinecone.io/?sessionType=signup&ref=blog.langchain.com)，并使用 Starter Pod 创建一个索引。请将维度（dimensions）设为 **1536**，因为这正是我们将使用的 OpenAI 嵌入向量的维度大小。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_005.png)

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_005.png)

一旦索引准备就绪，请在 Airbyte 中配置向量数据库的目标：

- 将分块大小（chunk size）设为 **1000**（该数值指 token 数量，而非字符数，因此大致相当于 4KB 的文本。最优的分块策略取决于您所处理的具体数据）  
- 配置记录字段，指定哪些字段将作为文本字段进行嵌入（embedding）；其余所有字段将被当作元数据（metadata）处理。目前请将字段设为 “**title**” 和 “**body**”，因为这两个字段正是 GitHub 数据源中 issue 流所包含的相关字段。  
- 设置您的 OpenAI API 密钥，以驱动嵌入服务。您可在 [platform.openai.com/account](https://platform.openai.com/account?ref=blog.langchain.com) 页面的“API keys”（API 密钥）部分找到该密钥。  
- 在索引步骤中，从 Pinecone 控制台界面复制 index 名称、environment（环境）和 API 密钥。您可在 Pinecone UI 的 “API Keys”（API 密钥）部分找到 API 密钥和 environment。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_006.png)![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_007.png)

## Step 3 - 创建连接

## 第三步：创建连接

目标端成功配置后，请建立从 GitHub 数据源到向量数据库目标端的连接。在配置流程中，选择已存在的数据源与目标端。配置连接时，请确保仅启用 “issues” 数据流（stream），因为这是我们当前关注的唯一数据流。

补充说明：Airbyte 可在生产环境中进一步提升该同步任务的效率：

- 为使元数据保持精简，您可以点击数据流名称，单独勾选需要同步的字段。例如，若 “assignee”（指派人）或 “milestone”（里程碑）字段对您毫无意义，即可取消勾选，它们便不会被同步至目标端。  
- 利用同步模式（sync mode），可实现 issues 的增量同步，并在向量数据库中自动去重，从而避免搜索结果中出现陈旧（stale）数据。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_008.png)

若一切顺利，此时应已成功建立一条连接，正通过向量存储目标端，将 GitHub 数据同步至 Pinecone。请给予同步任务几分钟运行时间。首次同步完成后，您可访问 [Pinecone 索引管理页面](https://app.pinecone.io/?ref=blog.langchain.com)，查看已成功索引、随时可供查询的一批向量。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_009.png)

Each vector is associated with a metadata object that’s filled with the fields that were not mentioned as “text fields” in the destination configuration. These fields will be retrieved along with the embedded text and can be leveraged by our chatbot in later sections. This is how a vector with metadata looks like when retrieved from Pinecone:

每个向量都关联一个元数据（metadata）对象，该对象填充了在目标配置中**未被指定为“文本字段”**的那些字段。这些字段将与嵌入的文本一同被检索，并可在后续章节中供我们的聊天机器人使用。以下是从 Pinecone 中检索到的一个带元数据的向量示例：

```
{
      "id": "599d75c8-517c-4f37-88df-ff16576bd607",
      "values": [0.0076571689, ..., 0.0138477711],
      "metadata": {
        "_ab_stream": "issues",
        "_ab_record_id": 1556650122,
        "author_association": "CONTRIBUTOR",
        "comments": 3,
        "created_at": "2023-01-25T13:21:50Z",
        // ...
        "text": "...The acceptance-test-config.yml file is in a legacy format. Please migrate to the latest format...",
        "updated_at": "2023-07-17T09:20:56Z",
      }
}
```

```
{
      "id": "599d75c8-517c-4f37-88df-ff16576bd607",
      "values": [0.0076571689, ..., 0.0138477711],
      "metadata": {
        "_ab_stream": "issues",
        "_ab_record_id": 1556650122,
        "author_association": "CONTRIBUTOR",
        "comments": 3,
        "created_at": "2023-01-25T13:21:50Z",
        // ...
        "text": "...acceptance-test-config.yml 文件采用的是旧版格式，请迁移到最新格式...",
        "updated_at": "2023-07-17T09:20:56Z",
      }
}
```

On subsequent runs, Airbyte will only re-embed and update the vectors for the issues that changed since the last sync - this will speed up subsequent runs while making sure your data is always up-to-date and available.

在后续运行中，Airbyte 仅会对自上次同步以来发生变更的问题重新执行嵌入并更新对应向量——这将显著加快后续同步速度，同时确保您的数据始终最新且可用。

## Step 4 - Chat interface

## 第四步：构建聊天界面

The data is ready, now let’s wire it up with our LLM to answer questions in natural language. As we already used OpenAI for the embedding, the easiest approach is to use it as well for the question answering.

数据已准备就绪，现在让我们将其接入大语言模型（LLM），以支持自然语言问答。由于我们此前已使用 OpenAI 进行文本嵌入，因此最简便的方式是继续使用 OpenAI 来完成问答任务。

We will use Langchain as an orchestration framework to tie all the bits together.

我们将使用 LangChain 作为编排框架，将各组件有机整合起来。

First, install a few pip packages locally:

首先，在本地安装若干 pip 包：

```
pip install pinecone-client langchain openai
```

```
pip install pinecone-client langchain openai
```

The basic functionality here works the following way:

该功能的基本工作流程如下：

- User asks a question  
- The question is embedded using the same model used for generating the vectors in the vector database (OpenAI in this case)  
- The question vector is sent to the vector database and documents with similar vectors are returned — as the vectors represent the meaning of the text, the question and the answer to the question will have very similar vectors and relevant documents will be returned  
- The text of all documents with the relevant metadata are put together into a single string and sent to the LLM together with the question the user asked and the instruction to answer the user’s question based on the provided context  
- The LLM answers the question based on the provided context  
- The answer is presented to the user  

- 用户提出一个问题；  
- 使用与向量数据库中生成向量时**相同的模型**（本例中为 OpenAI）对该问题进行嵌入；  
- 将生成的问题向量发送至向量数据库，返回语义相似度最高的若干文档——由于向量表征的是文本语义，问题与其答案的向量高度相近，因此可精准召回相关文档；  
- 将所有匹配文档的正文内容及其相关元数据拼接为单一字符串，并连同用户原始问题及指令（“请基于所提供上下文回答用户问题”）一并提交给大语言模型（LLM）；  
- LLM 基于所提供的上下文生成答案；  
- 将最终答案呈现给用户。

This flow is often referred to as [retrieval augmented generation](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-foundation-models-customize-rag.html?ref=blog.langchain.com).

这种流程通常被称为[检索增强生成（Retrieval Augmented Generation, RAG）](https://docs.aws.amazon.com/sagemaker/latest/dg/jumpstart-foundation-models-customize-rag.html?ref=blog.langchain.com)。

The RetrievalQA class from the Langchain framework already implements the basic interaction. The simplest version of our question answering bot only has to provide the vector store and the used LLM:

LangChain 框架中的 `RetrievalQA` 类已实现了该流程的基本交互逻辑。我们问答机器人的最简版本只需提供向量数据库（vector store）和所用的大语言模型（LLM）：

```python
# chatbot.py
import os
import pinecone
from langchain.chains import RetrievalQA
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.vectorstores import Pinecone

embeddings = OpenAIEmbeddings()
pinecone.init(api_key=os.environ["PINECONE_KEY"], environment=os.environ["PINECONE_ENV"])
index = pinecone.Index(os.environ["PINECONE_INDEX"])
vector_store = Pinecone(index, embeddings.embed_query, "text")

qa = RetrievalQA.from_chain_type(llm=OpenAI(temperature=0), chain_type="stuff", retriever=vector_store.as_retriever())

print("Connector development help bot. What do you want to know?")
while True:
    query = input("")
    answer = qa.run(query)
    print(answer)
    print("\nWhat else can I help you with:")
```

```python
# chatbot.py
import os
import pinecone
from langchain.chains import RetrievalQA
from langchain.embeddings import OpenAIEmbeddings
from langchain.llms import OpenAI
from langchain.vectorstores import Pinecone

embeddings = OpenAIEmbeddings()
pinecone.init(api_key=os.environ["PINECONE_KEY"], environment=os.environ["PINECONE_ENV"])
index = pinecone.Index(os.environ["PINECONE_INDEX"])
vector_store = Pinecone(index, embeddings.embed_query, "text")

qa = RetrievalQA.from_chain_type(llm=OpenAI(temperature=0), chain_type="stuff", retriever=vector_store.as_retriever())

print("Connector development help bot. What do you want to know?")
while True:
    query = input("")
    answer = qa.run(query)
    print(answer)
    print("\nWhat else can I help you with:")
```

To run this script, you need to set OpenAI and Pinecone credentials as environment variables:

要运行该脚本，需将 OpenAI 和 Pinecone 的凭据配置为环境变量：

```
export OPENAI_API_KEY=...
export PINECONE_KEY=...
export PINECONE_ENV=...
export PINECONE_INDEX=...
python chatbot.py
```

```
export OPENAI_API_KEY=...
export PINECONE_KEY=...
export PINECONE_ENV=...
export PINECONE_INDEX=...
python chatbot.py
```

This works in general, but it has some limitations. By default, only the text fields are passed into the prompt of the LLM, so it doesn’t know what the context of a text is and it also can’t give a reference back to where it found its information:

该实现总体上可行，但仍存在一些局限性：默认情况下，仅有纯文本字段被传入大语言模型的提示（prompt）中，因此模型无法理解文本所处的具体上下文，也无法回溯并引用其信息来源：

```
Connector development help bot. What do you want to know?
> Can you give me information about how to authenticate via a login endpoint that returns a session token?

Yes, the GenericSessionTokenAuthenticator should be supported in the UI[...]
```

```
Connector development help bot. What do you want to know?
> Can you give me information about how to authenticate via a login endpoint that returns a session token?

是的，GenericSessionTokenAuthenticator 应在 UI 中受支持[...]
```

从这里开始，我们还需要进行大量微调，以优化我们的聊天机器人。例如，我们可以改进提示词（prompt），使其包含更多基于元数据字段的信息，并针对我们的具体使用场景更加明确：

```python
prompt_template = """You are a question-answering bot operating on Github issues and documentation pages for a product called connector builder. The documentation pages document what can be done, the issues document future plans and bugs. Use the following pieces of context to answer the question at the end. If you don't know the answer, just say that you don't know, don't try to make up an answer. Always state were you got this information from (and the github issue number if applicable).
If the answer is based on a Github issue that's not closed yet, add 'This issue is not closed yet - the feature might not be shipped yet' to the answer.

{context}

Question: {question}
Helpful Answer:"""

prompt = PromptTemplate(
    template=prompt_template, input_variables=["context", "question"]
)

class ConnectorDevelopmentPrompt(PromptTemplate):
    def format_document(doc: Document, prompt: PromptTemplate) -> str:
        if doc.metadata["_ab_stream"] == "issues":
            return f"Excerpt from Github issue: {doc.page_content}, issue number: {doc.metadata['number']}, issue state: {doc.metadata['state']}"
        else:
            return super().format_document(doc, prompt)

document_prompt = ConnectorDevelopmentPrompt(input_variables=["page_content"], template="{page_content}")
qa = RetrievalQA.from_chain_type(llm=OpenAI(temperature=0), chain_type="stuff", retriever=vector_store.as_retriever(), chain_type_kwargs={"prompt": prompt, "document_prompt": document_prompt})
```

完整脚本也可在 [GitHub](https://github.com/airbytehq/tutorial-connector-dev-bot/blob/main/localbot_adapted.py?ref=blog.langchain.com) 上找到。

该修订版 `RetrievalQA` 链对上下文检索完成后发送给大语言模型（LLM）的提示词进行了定制化处理：

- 基础提示词模板明确了本次问答所处的更广泛背景（此前 LLM 只能依赖文档内容自行推测）；
- 同时也改变了文档内容嵌入提示词的方式：默认情况下仅添加纯文本，而 `ConnectorDevelopmentPrompt` 的实现则额外标明了数据来源，并将相关元数据一并加入提示词中，从而使 LLM 能够依据文本内容之外的更多信息（如来源、问题编号、状态等）生成更准确的回答。

```
Connector development help bot. What do you want to know?
> Can you give me information about how to authenticate via a login endpoint that returns a session token?

You can use the GenericSessionTokenAuthenticator to authenticate via a login endpoint that returns a session token. This is documented in the Connector Builder documentation with an example of how the request flow functions (e.g. metabase). This issue is not closed yet - the feature might not be shipped yet (Github issue #26341).

连接器开发帮助机器人。您想了解什么？
> 您能提供有关如何通过返回会话令牌（session token）的登录端点进行身份验证的信息吗？

您可以使用 `GenericSessionTokenAuthenticator`，通过返回会话令牌的登录端点完成身份验证。Connector Builder 文档中对此有详细说明，并附有请求流程的示例（例如 Metabase）。该问题尚未关闭——此功能可能尚未正式发布（GitHub Issue #26341）。

## Step 5 - Put it on Slack

## 第五步 —— 部署到 Slack

So far this helper can only be used locally. However, using the python slack sdk it’s easy to turn this into a Slack bot itself.

截至目前，该辅助工具仅支持本地运行。但借助 Python Slack SDK，我们可轻松将其封装为一个真正的 Slack 机器人。

To do so, we need to set up a Slack “App” first. Go to [https://api.slack.com/apps](https://api.slack.com/apps?ref=blog.langchain.com) and create a new app based on the manifest [here](https://raw.githubusercontent.com/airbytehq/tutorial-connector-dev-bot/main/slack_manifest.json?ref=blog.langchain.com) (this saves you some work configuring permissions by hand). After you set up your app, install it to the workspace you want to integrate with. This will generate a “Bot User OAuth Access Token” you need to note down. Afterwards, go to the “Basic information” page of your app, scroll down to “App-Level Tokens” and create a new token. Note down this “app level token” as well.

为此，我们首先需要创建一个 Slack “应用（App）”。请访问 [https://api.slack.com/apps](https://api.slack.com/apps?ref=blog.langchain.com)，并基于 [此清单文件（manifest）](https://raw.githubusercontent.com/airbytehq/tutorial-connector-dev-bot/main/slack_manifest.json?ref=blog.langchain.com) 创建一个新应用（此举可免去手动配置权限的繁琐步骤）。应用创建完成后，请将其安装至您希望集成的目标工作区（workspace）。系统将生成一个“Bot User OAuth Access Token”，请务必记录下来。随后，请进入应用的“Basic Information（基本信息）”页面，向下滚动至“App-Level Tokens（应用级令牌）”部分，并创建一个新的令牌。同样，请记录下该“应用级令牌（app level token）”。

Within the regular Slack client, your app can be added to a slack channel by clicking the channel name and going to the “Integrations” tab:

在常规 Slack 客户端中，您可通过点击频道名称、再切换至“Integrations（集成）”标签页，将您的应用添加至指定 Slack 频道：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_010.png)

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_010.png)

After this, your Slack app is ready to receive pings from users to answer questions - the next step is to call Slack from within python code, so we need to install the python client library:

完成上述操作后，您的 Slack 应用即可接收用户消息并作答——下一步是在 Python 代码中调用 Slack API，因此我们需要先安装 Python 客户端库：

```
pip install slack_sdk
```

```
pip install slack_sdk
```

Afterwards, we can extend our existing chatbot script with a Slack integration:

随后，我们可在现有聊天机器人脚本中加入 Slack 集成功能：

```python
from slack_sdk import WebClient
from slack_sdk.socket_mode import SocketModeClient
from slack_sdk.socket_mode.request import SocketModeRequest
from slack_sdk.socket_mode.response import SocketModeResponse

slack_web_client = WebClient(token=os.environ["SLACK_BOT_TOKEN"])

handled_messages = {}

def process(client: SocketModeClient, socket_mode_request: SocketModeRequest):
    if socket_mode_request.type == "events_api":
        event = socket_mode_request.payload.get("event", {})
        client_msg_id = event.get("client_msg_id")
        if event.get("type") == "app_mention" and not handled_messages.get(client_msg_id):
            handled_messages[client_msg_id] = True
            channel_id = event.get("channel")
            text = event.get("text")
            result = qa.answer(text)
            slack_web_client.chat_postMessage(channel=channel_id, text=result)

    return SocketModeResponse(envelope_id=socket_mode_request.envelope_id)

socket_mode_client = SocketModeClient(
    app_token=os.environ["SLACK_APP_TOKEN"],
    web_client=slack_web_client
)
socket_mode_client.socket_mode_request_listeners.append(process)

socket_mode_client.connect()
print("listening")
from threading import Event
Event().wait()
```

上述完整脚本也可在 [GitHub](https://github.com/airbytehq/tutorial-connector-dev-bot/blob/main/slackbot.py?ref=blog.langchain.com) 上找到。

如需运行该脚本，还需将 Slack 机器人的令牌（bot token）和应用令牌（app token）作为环境变量进行配置：

```
export SLACK_BOT_TOKEN=...
export SLACK_APP_TOKEN=...
python chatbot.py
```

Running this, you should be able to ping the development bot application in the channel you added it to like a user and it will respond to questions by running the RetrievalQA chain that loads relevant context from the vector database and uses an LLM to formulate a nice answer:

运行此程序后，您应能像普通用户一样，在已添加该机器人的频道中 @ 该开发机器人，它将通过运行 RetrievalQA 链来响应问题：该链会从向量数据库中加载相关上下文，并调用大语言模型（LLM）生成自然、得体的回答：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_011.png)

All the code can also be found [on Github](https://github.com/airbytehq/tutorial-connector-dev-bot?ref=blog.langchain.com)

所有代码也可在 [GitHub](https://github.com/airbytehq/tutorial-connector-dev-bot?ref=blog.langchain.com) 上获取。

## Step 6 - Additional data source: Scrape documentation website

## 第六步 —— 补充数据源：爬取文档网站

Github issues are helpful, but there is more information we want our development bot to know.

GitHub Issues 很有帮助，但我们的开发机器人还需掌握更多信息。

The [documentation page](https://docs.airbyte.com/connector-development/connector-builder-ui/overview/?ref=blog.langchain.com) for connector development is a very important source of information to answer questions, so it definitely needs to be included. The easiest way to make sure the bot has the same information as what’s published, is to scrape the website. For this case, we are going to use the [Apify](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com) service to take care of the scraping and turning the website into a nicely structured dataset. This dataset can be extracted using the Airbyte Apify Dataset source connector.

[连接器开发文档页面](https://docs.airbyte.com/connector-development/connector-builder-ui/overview/?ref=blog.langchain.com) 是回答相关问题的关键信息来源，因此必须纳入知识库。确保机器人所掌握的信息与线上发布内容完全一致的最简单方式，就是对网站进行爬取。本例中，我们将使用 [Apify](https://docs.airbyte.com/integrations/destinations/langchain/?ref=blog.langchain.com) 服务完成网页爬取，并将其转化为结构清晰的数据集。该数据集可通过 Airbyte 的 Apify Dataset 源连接器（source connector）提取。

First, log into Apify and navigate to the store. Choose the “Web Scraper” actor as a basis - it already implements most of the functionality we need

首先，登录 Apify 并进入其 Marketplace（应用商店）。选择 “Web Scraper”（网页爬虫）Actor 作为基础——它已内置了我们所需的大部分功能：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_012.png)

Next, create a new task and configure it to scrape all pages of the documentation, extracting the page title and all of the content:

接下来，新建一个任务，并配置其爬取全部文档页面，同时提取每页的标题及全部正文内容：

- Set Start URLs to [https://docs.airbyte.com/connector-development/connector-builder-ui/overview/](https://docs.airbyte.com/connector-development/connector-builder-ui/overview/?ref=blog.langchain.com) , the intro page of the documentation linking to other pages  
- 将“起始 URL（Start URLs）”设为 [https://docs.airbyte.com/connector-development/connector-builder-ui/overview/](https://docs.airbyte.com/connector-development/connector-builder-ui/overview/?ref=blog.langchain.com)，即文档的入门页面，该页面包含指向其他文档页的链接；

- Set Link selector to a\[href\] to follow all links from every page  
- 将“链接选择器（Link selector）”设为 `a[href]`，以便从每个页面中遍历并跟随所有超链接；

- Set Glob Patterns to [https://docs.airbyte.com/connector-development/connector-builder-ui/\*](https://docs.airbyte.com/connector-development/connector-builder-ui/*?ref=blog.langchain.com) to limit the scraper to stick to the documentation and not crawl the whole internet  
- 将“通配符模式（Glob Patterns）”设为 [https://docs.airbyte.com/connector-development/connector-builder-ui/\*](https://docs.airbyte.com/connector-development/connector-builder-ui/*?ref=blog.langchain.com)，以限定爬虫仅抓取文档子站内容，避免漫无目的地爬取整个互联网；

- Configure the Page function to extract the page title and the content - in this case the content element can be found using the CSS class name  
- 配置“页面函数（Page function）”以提取页面标题与正文内容——本例中，正文元素可通过 CSS 类名定位。

```javascript
async function pageFunction(context) {
    const $ = context.jQuery;
    const pageTitle = $('title').first().text();
    const content = $('.markdown').first().text();

    return {
        url: context.request.url,
        pageTitle,
        content
    };
}
```

```javascript
async function pageFunction(context) {
    const $ = context.jQuery;
    const pageTitle = $('title').first().text();
    const content = $('.markdown').first().text();

    return {
        url: context.request.url,
        pageTitle,
        content
    };
}
```

运行该 Actor 将快速完成，并为我们生成一个结构清晰、易于使用的数据集，其中包含“页面标题”和“内容”两列：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_013.png)

现在，是时候将 Airbyte 连接到 Apify 数据集了——请进入 Airbyte 网页界面，添加第二个数据源（Source），并选择 “Apify Dataset”：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_014.png)

配置该数据源时，您只需复制 Apify UI 中对应 “Run” 的 “Storage” 标签页内显示的数据集 ID（Dataset ID）即可：

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_015.png)![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_016.png)

数据源配置完成后，请参照之前配置 GitHub 数据源的相同步骤，建立一条从 Apify 数据集到向量数据库（vector store）的数据同步连接。由于相关文本内容分别存放在不同字段中，您还需更新向量数据库的目标配置：在目标（destination）的 “text fields”（文本字段）中添加 **data.pageTitle** 和 **data.content**，然后保存设置。

## 第 7 步 —— 额外数据源：抓取 Slack 消息

## 第 7 步 —— 额外数据源：抓取 Slack 消息

Another valuable source of information relevant to connector development are Slack messages from the public help channel. These can be loaded in a very similar fashion. Create a new source using the Slack connector. When using cloud, you can authenticate using the “Authenticate your Slack account” button for simple setup, otherwise follow the instructions in the documentation on the right hand side how to create a Slack “App” with the required permissions and add it to your workspace. To avoid fetching messages from all channels, set the channel name filter to the correct channel.

另一个与连接器开发密切相关的重要信息来源，是公共帮助频道（public help channel）中的 Slack 消息。这些消息的加载方式与此前非常相似。请使用 Slack 连接器创建一个新的数据源。若使用 Airbyte Cloud，可直接点击“Authenticate your Slack account”（认证您的 Slack 账户）按钮完成简易配置；否则，请参考右侧文档中的说明，创建一个具备必要权限的 Slack “App”，并将其添加至您的工作区。为避免拉取全部频道的消息，请在频道名称筛选器（channel name filter）中指定目标频道。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_017.png)

As for Apify and Github, a new connection needs to be created to move data from Slack to Pinecone. Also add **text** to the “text fields” of the destination to make sure the relevant data gets embedded properly so similarity searches will yield the right results.

与 Apify 和 GitHub 类似，您还需新建一条连接，将 Slack 数据同步至 Pinecone。同时，请在目标端（destination）的“text fields”（文本字段）中添加 **text**，以确保相关数据能被正确嵌入，从而使相似性搜索（similarity search）返回准确结果。

If everything went well, there should be three connections now, all syncing data from their respective sources to the centralized vector store destination using a Pinecone index.

若一切顺利，此时应已建立三条连接，它们分别从各自的数据源（Apify、GitHub、Slack）向统一的向量存储目标（centralized vector store destination）同步数据，并使用同一个 Pinecone 索引。

![](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_018.png)

By adjusting the frequency of the connections, you can control how often Airbyte will rerun the connection to make sure the knowledge base of our chat bot stays up to date. As Github and Slack are frequently updated and support efficient incremental updates, it makes sense to set them to a daily frequency or higher. The documentation pages don’t change as often, so they can be kept at a lower frequency or even just be triggered on demand when there are changes.

通过调整各连接的同步频率，您可以控制 Airbyte 重新运行连接的频次，从而确保聊天机器人的知识库始终保持最新。由于 GitHub 和 Slack 的内容更新频繁，且均支持高效的增量同步（incremental updates），建议将二者设为每日或更高频次的同步。而文档页面更新相对较少，因此可设置较低的同步频率，甚至仅在内容发生变更时按需手动触发同步。

As we have more sources now, let’s improve our prompt to make sure the LLM has all necessary information to formulate a good answer:

随着数据源数量增加，我们来优化提示词（prompt），以确保大语言模型（LLM）能够获取所有必要信息，从而生成高质量的回答：

```python
class ContextualRetriever(VectorStoreRetriever):
    def _get_relevant_documents(self, query: str, *, run_manager):
        docs = super()._get_relevant_documents(query, run_manager=run_manager)
        return [self.format_doc(doc) for doc in docs]

    def format_doc(self, doc: Document) -> Document:
        if doc.metadata["_ab_stream"] == "item_collection":
            doc.page_content = f"Excerpt from documentation page: {doc.page_content}"
        elif doc.metadata["_ab_stream"] == "issues":
            doc.page_content =  f"Excerpt from Github issue: {doc.page_content}, issue number: {int(doc.metadata['number']):d}, issue state: {doc.metadata['state']}"
        elif doc.metadata["_ab_stream"] == "threads" or doc.metadata["_ab_stream"] == "channel_messages":
            doc.page_content =  f"Excerpt from Slack thread: {doc.page_content}"
        return doc
```

By default the RetrievalQA chain retrieves the top 5 matching documents, so if it’s applicable the answer will be based on multiple sources at the same time:

默认情况下，`RetrievalQA` 链会检索最相关的前 5 个文档；因此，在适用场景下，最终答案将同时综合多个数据源的信息生成。

```
Connector development help bot. What do you want to know?

连接器开发帮助机器人。您想了解什么？

> What different authentication methods are supported by the builder? Can I authenticate a login endpoint that returns a session token?

> 构建器支持哪些不同的认证方式？我能否对返回会话令牌（session token）的登录端点进行认证？

The authentication methods supported by the builder are Basic HTTP, Bearer Token, API Key, and OAuth. The builder does not currently support authenticating a login endpoint that returns a session token, but this feature is planned and can be tracked in the Github issue #26341. This issue is not closed yet - the feature might not be shipped yet.

构建器支持的认证方式包括：Basic HTTP、Bearer Token、API Key 和 OAuth。目前，构建器尚不支持对返回会话令牌（session token）的登录端点进行认证；但该功能已在规划中，您可通过 GitHub Issue #26341 跟踪进展。该 Issue 尚未关闭——该功能可能尚未发布。

The first sentence about Basic HTTP, Bearer Token, API Key and OAuth is retrieved from the [documentation page about authentication](https://docs.airbyte.com/connector-development/connector-builder-ui/authentication/?ref=blog.langchain.com), while the second sentence is referring to the same Github issue as before.

第一句关于 Basic HTTP、Bearer Token、API Key 和 OAuth 的内容摘自 [认证相关文档页面](https://docs.airbyte.com/connector-development/connector-builder-ui/authentication/?ref=blog.langchain.com)；第二句所指的 GitHub Issue 与前文相同。

## Wrapping up

## 总结收尾

We covered a lot of ground here - stepping back a bit, we accomplished the following parts:

本文涵盖内容广泛——稍作回顾，我们已实现以下关键部分：

- Set up a pipeline that loads unstructured data from multiple sources into a vector database  
- 搭建一条数据管道，将来自多个源的非结构化数据加载至向量数据库  
- Implement an application that can answer plain text questions about the unstructured data in a general way  
- 实现一个应用程序，能够以通用方式回答有关这些非结构化数据的纯文本问题  
- Expose this application as a Slack bot  
- 将该应用程序以 Slack 机器人的形式对外提供服务  

With data flowing through this system, Airbyte will make sure the data in your vector database will always be up-to-date while only syncing records that changed in the connected source, minimizing the load on embedding and vector database services while also providing an overview over the current state of running pipelines.

随着数据持续流经该系统，Airbyte 将确保您的向量数据库中的数据始终保持最新：它仅同步连接数据源中发生变更的记录，从而最大限度降低嵌入（embedding）服务与向量数据库服务的负载，同时还能提供当前运行中数据管道状态的全局概览。

This setup isn’t using a single black box service that encapsulates all the details and leaves us with limited options for tweaking behavior and controlling data processing - instead it’s composed out of multiple components that be easily extended in various places:

该方案并未采用一个封装全部细节的“黑盒式”单一服务（此类服务往往限制我们对行为调优和数据处理流程的控制权）；相反，它由多个可灵活扩展的组件构成，可在多个环节轻松定制与增强：

- The large catalog of Airbyte sources and the connector builder for integrating specialized sources allow to easily load just about any data into a vector db using a single tool  
- Airbyte 庞大的数据源目录，配合专为集成特定数据源而设计的连接器构建器（Connector Builder），使您能借助单一工具，便捷地将几乎任意类型的数据加载至向量数据库  
- Langchain is very extensible and allows you to leverage LLMs in different ways beyond this simple application, including enriching data from other sources, keeping a chat history to be able to have full conversations and more  
- LangChain 具有极强的可扩展性，让您不仅能在此简单应用之外，以多种方式利用大语言模型（LLM）：例如，融合其他来源的数据、维护聊天历史以支持完整的多轮对话，等等  

If you are interested in leveraging Airbyte to ship data to your LLM-based applications, take a moment to [fill out our survey](https://docs.google.com/forms/d/e/1FAIpQLSduobMZwbqiFlPxsWDG-hrBw6NLYMDu_7zRfo4j7AsaO1QtfQ/viewform?usp=sf_link&ref=blog.langchain.com) so we can make sure to prioritize the most important features.

如果您希望借助 Airbyte 将数据输送至基于大语言模型（LLM）的应用程序中，请花一点时间 [填写我们的调研问卷](https://docs.google.com/forms/d/e/1FAIpQLSduobMZwbqiFlPxsWDG-hrBw6NLYMDu_7zRfo4j7AsaO1QtfQ/viewform?usp=sf_link&ref=blog.langchain.com)，以便我们准确识别并优先开发最重要的功能。
```

### Tags

### 标签


[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_019.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_019.png)](https://blog.langchain.com/neum-x-langchain/)


[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_020.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_020.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_021.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_021.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)


[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain 支持的 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[![LangChain Expression Language](images/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain/img_022.jpg)](https://blog.langchain.com/langchain-expression-language/)

[**LangChain 表达式语言（LangChain Expression Language）**](https://blog.langchain.com/langchain-expression-language/)