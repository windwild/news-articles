---
title: "Xata x LangChain: new vector store and memory store integrations"
source: "LangChain Blog"
url: "https://blog.langchain.com/xata-x-langchain-new-vector-store-and-memory-store-integrations/"
date: "2023-08-29"
scraped_at: "2026-03-03T08:48:49.105200218+00:00"
language: "en-zh"
translated: true
---
{% raw %}

_Editor's Note: This post was written in collaboration with the [Xata](https://xata.io/?ref=blog.langchain.com) team. We're excited about their new integrations and really enjoyed their deepdive on implementation a Q&A chat bot with them._

_编辑注：本文由 LangChain 团队与 [Xata](https://xata.io/?ref=blog.langchain.com) 团队联合撰写。我们非常期待 Xata 推出的新集成，并十分欣赏他们关于如何基于 Xata 构建问答式聊天机器人的深度技术分享。_

Over the past few weeks, we’ve merged four Xata integrations to the LangChain repositories, and today we’re happy to unveil them as part of [Xata’s launch week](https://xata.io/blog/launch-week-august-2023?ref=blog.langchain.com)! In this blog post, we’ll take a brief look at what Xata is and why it is a good data companion for AI applications. We’ll also show a code example for implementing a Q&A chat bot that answers questions based on the info in a Xata database (as a vector store) and has long-term memory stored in Xata (as a memory store).

过去几周，我们已将四项 Xata 集成合并至 LangChain 代码仓库；今天，我们很高兴借 [Xata 发布周](https://xata.io/blog/launch-week-august-2023?ref=blog.langchain.com) 之机正式发布这些集成！本文将简要介绍 Xata 是什么，以及它为何是 AI 应用的理想数据伴侣。我们还将提供一个代码示例，展示如何构建一个问答式聊天机器人：该机器人基于 Xata 数据库（作为向量存储）中的信息回答用户问题，并将长期对话记忆持久化存储于 Xata（作为记忆存储）。

## What is Xata?

## 什么是 Xata？

[Xata](https://xata.io/?ref=blog.langchain.com) is a database platform powered by PostgreSQL. It stores the source-of-truth data in PostgreSQL, but also replicates it automatically to Elasticsearch. This means that it offers functionality from both Postgres (ACID transactions, joins, constraints, etc.) and from Elasticsearch (BM25 full-text search, vector search, hybrid search), behind the same simple serverless API. This covers the functionality needed by the majority of AI applications and because it’s based on PostgreSQL and Elasticsearch, it is reliable and scalable.

[Xata](https://xata.io/?ref=blog.langchain.com) 是一个基于 PostgreSQL 构建的数据库平台。它将“单一可信数据源”（source-of-truth）存储于 PostgreSQL 中，同时自动将数据同步至 Elasticsearch。这意味着，Xata 通过统一、简洁的无服务器（serverless）API，同时提供了 PostgreSQL 的核心能力（如 ACID 事务、表连接、约束检查等）和 Elasticsearch 的关键特性（如 BM25 全文检索、向量搜索、混合搜索）。这一架构覆盖了绝大多数 AI 应用所需的数据功能；又因其底层依托 PostgreSQL 与 Elasticsearch，具备高可靠性与可扩展性。

Xata has client SDKs for both TypeScript/JavaScript and Python and built-in integrations with platforms like GitHub, Vercel, and Netlify.

Xata 提供面向 TypeScript/JavaScript 和 Python 的客户端 SDK，并原生支持与 GitHub、Vercel、Netlify 等平台的集成。

In the AI space, beside the LangChain integrations announced here, Xata offers a deep integration with OpenAI for the “ [ChatGPT on your data](https://xata.io/chatgpt?ref=blog.langchain.com)” use case.

在 AI 领域，除本文宣布的 LangChain 集成外，Xata 还与 OpenAI 深度集成，支持 “[让 ChatGPT 访问你的私有数据](https://xata.io/chatgpt?ref=blog.langchain.com)” 这一典型应用场景。

## The integrations

## 集成能力

As of today, the following integrations are available :

截至今日，以下集成能力已正式上线：

- Xata as a [vector store in LangChain](https://python.langchain.com/docs/integrations/vectorstores/xata?ref=blog.langchain.com). This allows one to store documents with embeddings in a Xata table and perform vector search on them. The integration takes advantage of the [newly GA-ed Python SDK](https://xata.io/blog/announcing-the-python-sdk-ga?ref=blog.langchain.com). The integration supports filtering by metadata, which is represented in Xata columns for the maximum performance.

- Xata 作为 [LangChain 中的向量存储](https://python.langchain.com/docs/integrations/vectorstores/xata?ref=blog.langchain.com)：支持将带嵌入向量（embeddings）的文档存入 Xata 表，并在其上执行向量相似度搜索。该集成充分利用了 [已正式发布（GA）的 Python SDK](https://xata.io/blog/announcing-the-python-sdk-ga?ref=blog.langchain.com)，并支持按元数据（metadata）过滤——元数据以 Xata 表列形式存储，从而实现最优查询性能。

- Xata as a [vector store in LangChain.js](https://js.langchain.com/docs/modules/data_connection/vectorstores/integrations/xata?ref=blog.langchain.com). Same as the Python integration, but for your TypeScript/JavaScript applications.

- Xata 作为 [LangChain.js 中的向量存储](https://js.langchain.com/docs/modules/data_connection/vectorstores/integrations/xata?ref=blog.langchain.com)：功能与 Python 版本一致，专为 TypeScript/JavaScript 应用设计。

- Xata as a [memory store in LangChain](https://python.langchain.com/docs/integrations/memory/xata_chat_message_history?ref=blog.langchain.com). This allows storing the chat message history for AI chat sessions in Xata, making it work as “memory” for LLM applications. The messages are stored in

- Xata 作为 [LangChain 中的记忆存储](https://python.langchain.com/docs/integrations/memory/xata_chat_message_history?ref=blog.langchain.com)：支持将 AI 聊天会话的消息历史持久化存储于 Xata，从而为大语言模型（LLM）应用提供可靠的“记忆”能力。消息以结构化方式存储于 Xata 表中。

- Xata as a [memory store in LangChain.js](https://js.langchain.com/docs/modules/memory/integrations/xata?ref=blog.langchain.com).  Same as the Python integration, but for TypeScript/JavaScript.

- Xata 作为 [LangChain.js 中的记忆存储](https://js.langchain.com/docs/modules/memory/integrations/xata?ref=blog.langchain.com)：功能与 Python 版本一致，适用于 TypeScript/JavaScript 应用。

Each integration comes with one or two code examples in the doc pages linked above.

上述每一项集成，在其对应的文档页面（上方链接）中均附有一至两个可直接运行的代码示例。

**The four integrations already make Xata one of the most comprehensive data solutions for LangChain, and we’re just getting started!**  
**这四项集成已使 Xata 成为 LangChain 生态中功能最全面的数据解决方案之一，而我们才刚刚起步！**  
For the near future, we’re planning to add custom retrievers for the Xata keyword and hybrid search and the Xata [Ask AI](https://xata.io/docs/typescript-client/ask?ref=blog.langchain.com) endpoint.  
在近期规划中，我们将为 Xata 的关键词搜索与混合搜索，以及 Xata 的 [Ask AI](https://xata.io/docs/typescript-client/ask?ref=blog.langchain.com) 接口添加自定义检索器（custom retrievers）。

## Example: Conversational Q&A with memory

## 示例：带记忆的对话式问答

While each LangChain integration comes with at least one minimal code example, in this blog post we’ll look at a more complex example that uses Xata both as a vector store and as a memory store. The application implements the “chat with your data” use case, and allows for follow-up questions. The full code can be found in this [repo](https://github.com/tsg/langchain-xata-example?ref=blog.langchain.com), which you can also use as a starter-kit for LangChain + Xata applications.  
尽管每个 LangChain 集成均至少附带一个最小可行代码示例，但本文将介绍一个更复杂的用例：该示例同时将 Xata 用作向量存储（vector store）和记忆存储（memory store）。该应用实现了“用你的数据进行对话”这一典型场景，并支持多轮追问。完整代码请参见此 [代码仓库](https://github.com/tsg/langchain-xata-example?ref=blog.langchain.com)，你也可将其直接作为 LangChain + Xata 应用的入门模板（starter-kit）使用。

While the example application here is written in TypeScript, a similar example using the Python LangChain can be found in this [Jupyter notebook](https://python.langchain.com/docs/integrations/memory/xata_chat_message_history?ref=blog.langchain.com#conversational-qa-chain-on-your-data-with-memory).  
虽然本文示例应用采用 TypeScript 编写，但你也可以在本 [Jupyter Notebook](https://python.langchain.com/docs/integrations/memory/xata_chat_message_history?ref=blog.langchain.com#conversational-qa-chain-on-your-data-with-memory) 中找到使用 Python 版 LangChain 实现的类似示例。

The main part of the code looks like this:

代码主体部分如下所示：

```tsx
import * as dotenv from "dotenv";
import { XataVectorSearch } from "langchain/vectorstores/xata";
import { OpenAIEmbeddings } from "langchain/embeddings/openai";
import { Document } from "langchain/document";
import { ConversationalRetrievalQAChain } from "langchain/chains";
import { BufferMemory } from "langchain/memory";
import { XataChatMessageHistory } from "langchain/stores/message/xata";
import { ChatOpenAI } from "langchain/chat_models/openai";

import { getXataClient } from "./xata.ts";

dotenv.config();

const client = getXataClient();

/* Create the vector store */
const table = "docs";
const embeddings = new OpenAIEmbeddings();
const vectorStore = new XataVectorSearch(embeddings, { client, table });
```

```markdown
/* Add documents to the vector store */
/* 将文档添加到向量存储中 */
const docs = [\
  new Document({\
    pageContent: "Xata is a Serverless Data platform based on PostgreSQL",\
  }),\
  new Document({\
    pageContent:\
      "Xata offers a built-in vector type that can be used to store and query vectors",\
  }),\
  new Document({\
    pageContent: "Xata includes similarity search",\
  }),\
];

const ids = await vectorStore.addDocuments(docs);

// eslint-disable-next-line no-promise-executor-return
await new Promise((r) => setTimeout(r, 2000));

/* Create the chat memory store */
/* 创建聊天记忆存储 */
const memory = new BufferMemory({
  chatHistory: new XataChatMessageHistory({
    table: "memory",
    sessionId: new Date().toISOString(), // Or some other unique identifier for the conversation
    // 或其他用于标识该对话的唯一标识符
    client,
    createTable: false,
  }),
  memoryKey: "chat_history",
});

/* Initialize the LLM to use to answer the question */
/* 初始化用于回答问题的大语言模型（LLM） */
const model = new ChatOpenAI({});

/* Create the chain */
/* 构建链式调用（Chain） */
const chain = ConversationalRetrievalQAChain.fromLLM(
  model,
  vectorStore.asRetriever(),
  {
    memory,
  }
);

/* Ask it a question */
/* 向其提出一个问题 */
const question = "What is Xata?";
const res = await chain.call({ question });
console.log("Question: ", question);
console.log(res);
/* Ask it a follow up question */
/* 提出一个后续问题 */
const followUpQ = "Can it do vector search?";
const followUpRes = await chain.call({
  question: followUpQ,
});
console.log("Follow-up question: ", followUpQ);
console.log(followUpRes);

/* Clear both the vector store and the memory store */
/* 清空向量存储和记忆存储 */
await vectorStore.delete({ ids });
await memory.clear();
```

Let’s take it piece by piece and see what it does:

让我们逐段分析这段代码的功能：

First, we use Xata as a vector store. In this vector store, we index a few sample documents, but in a real application you can index tens of thousands of documents. These are the documents that our chatbot will use to find answers for user questions. While not shown here, it’s also possible to add custom metadata columns to these documents. You can see the examples on the [integration page](https://js.langchain.com/docs/modules/data_connection/vectorstores/integrations/xata?ref=blog.langchain.com#example-similarity-search-with-a-metadata-filter).

首先，我们使用 Xata 作为向量存储。在此向量存储中，我们索引了若干示例文档；而在实际应用中，您可索引数以万计的文档。这些文档将供我们的聊天机器人检索，以回答用户提出的问题。虽然本例未展示，但您还可以为这些文档添加自定义元数据列。更多示例请参见 [集成文档页面](https://js.langchain.com/docs/modules/data_connection/vectorstores/integrations/xata?ref=blog.langchain.com#example-similarity-search-with-a-metadata-filter)。
```

```tsx
/* Create the vector store */
const table = "docs";
const embeddings = new OpenAIEmbeddings();
const vectorStore = new XataVectorSearch(embeddings, { client, table });

/* 创建向量存储 */
const table = "docs";
const embeddings = new OpenAIEmbeddings();
const vectorStore = new XataVectorSearch(embeddings, { client, table });

/* Add documents to the vector store */
const docs = [\
  new Document({\
    pageContent: "Xata is a Serverless Data platform based on PostgreSQL",\
  }),\
  new Document({\
    pageContent:\
      "Xata offers a built-in vector type that can be used to store and query vectors",\
  }),\
  new Document({\
    pageContent: "Xata includes similarity search",\
  }),\
];

const ids = await vectorStore.addDocuments(docs);
```

```tsx
/* 向向量存储中添加文档 */
const docs = [\
  new Document({\
    pageContent: "Xata 是一个基于 PostgreSQL 的无服务器数据平台",\
  }),\
  new Document({\
    pageContent:\
      "Xata 提供内置的向量（vector）类型，可用于存储和查询向量",\
  }),\
  new Document({\
    pageContent: "Xata 支持相似性搜索",\
  }),\
];

const ids = await vectorStore.addDocuments(docs);
```

Next, we create a chat memory store, again based on Xata. This stores the messages exchanged by the chat bots with the users in a Xata table. Each conversation gets a session ID, which is then used to retrieve the previous messages in the conversation, so that the context is not lost.

接下来，我们再次基于 Xata 创建一个聊天记忆存储（chat memory store）。该存储将聊天机器人与用户之间的消息交换记录保存在 Xata 表中。每次对话都会分配一个会话 ID（session ID），后续可通过该 ID 检索该次对话中的历史消息，从而避免上下文丢失。

```tsx
/* Create the chat memory store */
const memory = new BufferMemory({
  chatHistory: new XataChatMessageHistory({
    table: "memory",
    sessionId: new Date().toISOString(), // Or some other unique identifier for the conversation
    client,
    createTable: false,
  }),
  memoryKey: "chat_history",
});
```

```tsx
/* 创建聊天记忆存储 */
const memory = new BufferMemory({
  chatHistory: new XataChatMessageHistory({
    table: "memory",
    sessionId: new Date().toISOString(), // 或其他用于标识该次对话的唯一标识符
    client,
    createTable: false,
  }),
  memoryKey: "chat_history",
});
```

Then we initialize the client for interrogating the model, in this case the OpenAI ChatGPT API:

接着，我们初始化用于调用大语言模型的客户端——本例中为 OpenAI 的 ChatGPT API：

```tsx
/* Initialize the LLM to use to answer the question */
const model = new ChatOpenAI({});
```

```tsx
/* 初始化用于回答问题的大语言模型（LLM） */
const model = new ChatOpenAI({});
```

And finally, put all of them together in a conversational QA chain:

最后，将上述组件整合为一个对话式问答链（conversational QA chain）：

```tsx
/* Create the chain */
const chain = ConversationalRetrievalQAChain.fromLLM(
  model,
  vectorStore.asRetriever(),
  {
    memory,
  }
);
```

```tsx
/* 创建问答链 */
const chain = ConversationalRetrievalQAChain.fromLLM(
  model,
  vectorStore.asRetriever(),
  {
    memory,
  }
);
```

If you look at the data via the Xata UI while the example is running, you will see two tables: `docs` and `memory`. The `docs` table is populated with the documents from the vector store, having a `content` column and an `embedding` column of type `vector`.

若在示例运行期间通过 Xata UI 查看数据，您将看到两张表：`docs` 和 `memory`。其中 `docs` 表已填入向量存储中的文档，包含一个 `content` 列（内容）和一个类型为 `vector` 的 `embedding` 列。

![](images/xata-x-langchain-new-vector-store-and-memory-store-integrations/img_001.png)

![](images/xata-x-langchain-new-vector-store-and-memory-store-integrations/img_001.png)

The `memory` table is populated with the questions and answers from the user and from the AI:

`memory` 表中填充了用户提出的问题以及 AI 给出的回答：

![](images/xata-x-langchain-new-vector-store-and-memory-store-integrations/img_002.png)

![](images/xata-x-langchain-new-vector-store-and-memory-store-integrations/img_002.png)

## Content hackathon

## 内容黑客松

As part of the launch week, Xata is also organizing a content hackathon, where you can win prizes and swag by creating apps, writing blogs, recording videos, and more. See the [launch week blog post](https://xata.io/blog/launch-week-august-2023?ref=blog.langchain.com) for details.

作为发布周活动的一部分，Xata 还将举办一场内容黑客松（Content Hackathon）——您可通过开发应用、撰写博客、录制视频等方式参与，并赢取丰厚奖品和周边礼品。详情请参阅 [发布周博客文章](https://xata.io/blog/launch-week-august-2023?ref=blog.langchain.com)。

If you have any questions or ideas or if you need help implementing Xata with LangChain, join us on [Discord](https://xata.io/discord?ref=blog.langchain.com) or reach out on [Twitter](https://twitter.com/xata?ref=blog.langchain.com).

如果您有任何疑问、创意，或需要帮助将 Xata 与 LangChain 集成，请加入我们的 [Discord](https://xata.io/discord?ref=blog.langchain.com) 社区，或在 [Twitter](https://twitter.com/xata?ref=blog.langchain.com) 上联系我们。
{% endraw %}
