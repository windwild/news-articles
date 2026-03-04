---
render_with_liquid: false
title: "Zep x LangSmith: Foundations of LLM app development with LangChain.js and Zep"
source: "LangChain Blog"
url: "https://blog.langchain.com/zep-x-langsmith-foundations-of-llm-app-development-with-langchain-js-and-zep/"
date: "2023-08-17"
scraped_at: "2026-03-03T09:18:22.141660723+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Learn how to build three foundational LLM apps using TypeScript, LangChain.js, and Zep.

学习如何使用 TypeScript、LangChain.js 和 Zep 构建三种基础的大型语言模型（LLM）应用。

_Editor's Note: This post was written in collaboration with the [Zep](https://www.getzep.com/?ref=blog.langchain.com) team._  
_编辑注：本文由 [Zep](https://www.getzep.com/?ref=blog.langchain.com) 团队联合撰写。_

_The post walks, step-by-step, through the process of building three foundational LLM apps using TypeScript, LangChain.js, and Zep. We think it's a really compelling exploration of RAG and agents accessing to tools, combined with LangSmith for visibility into model behavior. And, we think–and hope–more developers will try these same approaches in their apps!_  
本文将手把手、分步骤地演示如何使用 TypeScript、LangChain.js 和 Zep 构建三种基础的 LLM 应用。我们认为，这是一次对检索增强生成（RAG）与工具调用型智能体（agents）的极具启发性的实践探索，并结合 LangSmith 实现对模型行为的可观测性。我们相信——也衷心希望——更多开发者能在自己的应用中尝试这些方法！

Python gets much of the love in the LLM space. However, most web apps are built using TypeScript, JavaScript, and related technologies. Zep has first-class support for TypeScript and JavaScript, and this article explores using Zep and LangChain.js to build the foundation for various types of LLM apps.

在大语言模型（LLM）领域，Python 长期占据聚光灯中心。然而，绝大多数 Web 应用实际是基于 TypeScript、JavaScript 及其相关技术栈构建的。Zep 原生支持 TypeScript 和 JavaScript，本文将深入探讨如何结合 Zep 与 LangChain.js，为各类 LLM 应用打下坚实基础。

Zep's long-term memory store makes it simple for developers to add relevant documents, chat history memory & rich user data to their prompts and without having to manage multiple pieces of infrastructure. Zep also automatically embeds chat history and documents, reducing reliance on 3rd-party embedding APIs.

Zep 的长期记忆存储（long-term memory store）让开发者能够轻松地将相关文档、聊天历史记录以及丰富的用户数据注入提示词（prompts）中，而无需自行维护多套基础设施。此外，Zep 还能自动为聊天历史和文档生成嵌入向量（embeddings），从而显著降低对第三方嵌入 API 的依赖。

💡

The source code for this post may be found in the [Zep By Example Repo](https://github.com/getzep/zep-by-example/tree/main/langchain/js?ref=blog.langchain.com).

本文配套源代码可在 [Zep By Example 仓库](https://github.com/getzep/zep-by-example/tree/main/langchain/js?ref=blog.langchain.com) 中获取。

### An overview of the LangChain features we'll use

### 我们将使用的 LangChain 功能概览

We're going to build the foundations for three types of applications, all using LangChain's `ZepMemory` and `ZepVectorStore` classes.

我们将构建三类应用的基础架构，全部基于 LangChain 提供的 `ZepMemory` 和 `ZepVectorStore` 类。

1. A simple conversational bot using a `ConversationChain`. We'll use this to demonstrate the ability to recall past conversations.  
   1. 使用 `ConversationChain` 构建一个简单的对话机器人。我们将借此展示系统对过往对话的记忆与回溯能力。

2. A _Retrieval Augmented Generation_ app using a `ConversationalRetrievalQAChain`. We'll demonstrate how to populate Zep's VectorStore with several books, and ask the LLM questions about the books.  
   2. 使用 `ConversationalRetrievalQAChain` 构建一个 _检索增强生成（RAG）_ 应用。我们将演示如何将若干本图书数据导入 Zep 的向量数据库（VectorStore），并就这些图书向大语言模型提问。

3. Lastly, we'll build a REACT-type _agent_ that has access to two tools. The first, a `peopleRetriever` tool, provides search access to historical chat messages but filtered by entity for people's names. The second, the `bookSearch` tool, provides search access over our book collection.  
   3. 最后，我们将构建一个具备 REACT 范式能力的 _智能体（agent）_，该智能体可调用两个工具：第一个是 `peopleRetriever` 工具，用于按人名实体筛选并检索历史聊天消息；第二个是 `bookSearch` 工具，用于在我们的图书集合中执行语义搜索。

We'll use LangChain's new [LangSmith platform](https://www.langchain.com/langsmith?ref=blog.langchain.com) for observability, providing insight into what our chains and agent are doing under the hood.

我们将借助 LangChain 全新推出的 [LangSmith 平台](https://www.langchain.com/langsmith?ref=blog.langchain.com) 实现可观测性，深入洞察各条链（chains）及智能体（agent）在底层的具体运行逻辑与行为表现。

### A simple conversational bot recalling past conversations

### 一个能回忆过往对话的简单聊天机器人

This somewhat trivial example demonstrates preloading historical conversation into Zep and passing an instance of `ZepMemory` to the chain.

这个看似简单的示例展示了如何将历史对话预先加载到 Zep 中，并将一个 `ZepMemory` 实例传入链（chain）中。

Let's start off by [initializing Zep in our app](https://docs.getzep.com/sdk/?ref=blog.langchain.com) and creating a `sessionId`, a unique key representing the user or a user's chat session. We'll then [load some test data](https://docs.getzep.com/sdk/chat_history/?ref=blog.langchain.com#persisting-a-memory-to-a-session) into the chat history for this session.

让我们首先[在应用中初始化 Zep](https://docs.getzep.com/sdk/?ref=blog.langchain.com)，并创建一个 `sessionId` —— 这是一个唯一标识符，代表某位用户或该用户的某次聊天会话。接着，我们将[加载一些测试数据](https://docs.getzep.com/sdk/chat_history/?ref=blog.langchain.com#persisting-a-memory-to-a-session)到本次会话的聊天历史中。

```typescript
// Create a new ZepClient instance
const client = await ZepClient.init(ZEP_API_URL, ZEP_API_KEY);

// Create a session ID for our conversation. This ID could represent our user, or a
// conversation thread with a user. i.e. You can map multiple sessions to a single user
// in your data model.
const sessionId = randomUUID();

// add the sample chat history to the Zep memory
const messages = history.map(
  ({ role, content }: { role: string; content: string }) =>
    new Message({ role, content }),
);
const zepMemory = new Memory({ messages });
await client.memory.addMemory(sessionId, zepMemory);
```

```typescript
// 创建一个新的 ZepClient 实例
const client = await ZepClient.init(ZEP_API_URL, ZEP_API_KEY);

// 为本次对话创建一个 session ID。该 ID 可以代表某位用户，也可以代表与该用户的某次对话线程。
// 例如，在您的数据模型中，您可以将多个 session 映射到同一个用户。
const sessionId = randomUUID();

// 将示例聊天历史添加到 Zep 的记忆中
const messages = history.map(
  ({ role, content }: { role: string; content: string }) =>
    new Message({ role, content }),
);
const zepMemory = new Memory({ messages });
await client.memory.addMemory(sessionId, zepMemory);
```

Let's now create an instance of `ZepMemory` initialized for the above session, and create our chain. We'll ask the LLM what we've discussed so far, giving it the opportunity review the chat history provided by Zep.

接下来，我们为上述会话创建一个已初始化的 `ZepMemory` 实例，并构建我们的链（chain）。我们将向大语言模型（LLM）提问：“截至目前我们讨论了哪些内容？”，从而让它有机会回顾 Zep 提供的聊天历史。

```typescript
// Create a new ChatOpenAI model instance. We'll use this for both oru chain and agent.
const model = new ChatOpenAI({
  modelName: "gpt-3.5-turbo",
  temperature: 0,
});

// Let's create a new ZepMemory instance with very simple configuration.
// We'll use this in our first chain to demonstrate the basics by recalling the
// chat history we've just added to Zep.
const memorySimple = new ZepMemory({
  sessionId,
  baseURL: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
});

// Let's start with a simple chain and ask the LLM what we've discussed so far.
const conversationChain = new ConversationChain({
  llm: model,
  memory: memorySimple,
});
const res1 = await conversationChain.run("What have we discussed so far?");
console.log(res1);
```

```typescript
// 创建一个新的 ChatOpenAI 模型实例。该模型将同时用于我们的链（chain）和智能体（agent）。
const model = new ChatOpenAI({
  modelName: "gpt-3.5-turbo",
  temperature: 0,
});

// 我们来创建一个配置极为简洁的 ZepMemory 实例。
// 在第一个链中，我们将使用它来演示基础功能：即调用刚刚添加到 Zep 中的聊天历史。
const memorySimple = new ZepMemory({
  sessionId,
  baseURL: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
});

// 先从一个简单的链开始，向大语言模型提问：“截至目前我们讨论了哪些内容？”
const conversationChain = new ConversationChain({
  llm: model,
  memory: memorySimple,
});
const res1 = await conversationChain.run("What have we discussed so far?");
console.log(res1);
```

Thanks to LangSmith, we have visibility into the data sent to the LLM. You'll note below that Zep has automatically summarized the long chat history and provided it to our chain as a _system message_. Zep does this asynchronously on the server in order to avoid impacting the user experience.

得益于 LangSmith，我们能够清晰地看到发送给大语言模型（LLM）的数据。您将在下方注意到，Zep 已自动对冗长的聊天历史进行了摘要，并将其作为一条 _系统消息_ 提供给我们的链（chain）。Zep 在服务端异步执行该摘要操作，以避免影响用户体验。

LangSmith has the nifty ability to share traces and you can [find the trace for this chain here.](https://smith.langchain.com/public/0fac6325-b58a-4f74-89e2-57f8985ced28/r?ref=blog.langchain.com)

LangSmith 具备便捷的追踪（trace）共享功能，您可[在此查看该链的完整追踪记录](https://smith.langchain.com/public/0fac6325-b58a-4f74-89e2-57f8985ced28/r?ref=blog.langchain.com)。

![](https://blog.getzep.com/content/images/2023/08/image.png)

![](https://blog.getzep.com/content/images/2023/08/image.png)

For each subsequent turn of the conversation, LangChain will persist AI and human messages to Zep. These messages will be automatically added to later prompts.

在对话后续的每一轮中，LangChain 都会将 AI 和人类的消息持久化至 Zep。这些消息将被自动添加到后续的提示（prompt）中。

Alongside summarization, Zep also enriches memories with named entities, an intent analysis, and token counts. We'll use some of this metadata later when we build our agent.

除摘要功能外，Zep 还通过命名实体识别（Named Entity Recognition）、意图分析（intent analysis）及词元（token）计数等方式丰富记忆内容。稍后我们在构建智能体（agent）时，将用到其中部分元数据。

```json
    {
      "uuid": "d02a90a7-0981-43ae-92bf-95e448f6fff4",
      "created_at": "2023-08-17T04:11:43.520994Z",
      "role": "AI",
      "content": "So far, we have discussed the authors Kurt Vonnegut, Jules Verne, and Philip K. Dick. We talked about their most famous books, some other notable works, the genres they wrote in, the awards they won, and the influences on their writing styles. We also mentioned the common themes in their works, such as critiques of society, exploration of the human condition, and speculations about future technologies.",
      "token_count": 88,
      "metadata": {
        "system": {
          "entities": [\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 51,\
                  "Start": 38,\
                  "Text": "Kurt Vonnegut"\
                }\
              ],\
              "Name": "Kurt Vonnegut"\
            },\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 64,\
                  "Start": 53,\
                  "Text": "Jules Verne"\
                }\
              ],\
              "Name": "Jules Verne"\
            },\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 84,\
                  "Start": 70,\
                  "Text": "Philip K. Dick"\
                }\
              ],\
              "Name": "Philip K. Dick"\
            }\
          ]
        }
      }
    }
```

```json
    {
      "uuid": "d02a90a7-0981-43ae-92bf-95e448f6fff4",
      "created_at": "2023-08-17T04:11:43.520994Z",
      "role": "AI",
      "content": "截至目前，我们已讨论了作家库尔特·冯内古特（Kurt Vonnegut）、儒勒·凡尔纳（Jules Verne）和菲利普·K·迪克（Philip K. Dick）。我们探讨了他们最著名的作品、其他重要著作、所涉文学体裁、所获奖项，以及影响其写作风格的因素。此外，我们还提到了他们作品中的共同主题，例如对社会的批判、对人类境况的探索，以及对未来科技的推测。",
      "token_count": 88,
      "metadata": {
        "system": {
          "entities": [\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 51,\
                  "Start": 38,\
                  "Text": "Kurt Vonnegut"\
                }\
              ],\
              "Name": "Kurt Vonnegut"\
            },\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 64,\
                  "Start": 53,\
                  "Text": "Jules Verne"\
                }\
              ],\
              "Name": "Jules Verne"\
            },\
            {\
              "Label": "PERSON",\
              "Matches": [\
                {\
                  "End": 84,\
                  "Start": 70,\
                  "Text": "Philip K. Dick"\
                }\
              ],\
              "Name": "Philip K. Dick"\
            }\
          ]
        }
      }
    }
```

### Building a Q&A over Docs / RAG-type app

### 构建基于文档的问答应用（RAG 类型）

Next, we'll use Zep's VectorStore to support a `ConversationalRetrievalQAChain` searching over a Zep document Collection. We've downloaded three public domain scifi books and will be using these for our demo.

接下来，我们将利用 Zep 的 VectorStore 支持一个 `ConversationalRetrievalQAChain`，使其能在 Zep 文档集合（document Collection）中执行检索式问答。我们已下载三本进入公有领域的科幻小说，并将在本次演示中使用它们。

How we approach chunking can significantly effect the performance of our app. Since we have multiple books and will be chunking each of these, we've included the file name as a prefix to each chunk. This ensures the LLM can relate a chunk to its source.

我们采用的分块（chunking）策略会显著影响应用性能。由于涉及多本书籍，且需对每本书分别进行分块，我们为每个文本块添加了对应文件名作为前缀。此举确保大语言模型能准确将文本块与其原始来源关联起来。

```typescript
async function loadDocs(path: string): Promise<Document[]> {
  return new DirectoryLoader(path, {
    ".txt": (path) => new TextLoader(path),
  }).load();
}
```

```typescript
async function loadDocs(path: string): Promise<Document[]> {
  return new DirectoryLoader(path, {
    ".txt": (path) => new TextLoader(path),
  }).load();
}
```

```typescript
async function loadDocsIntoVectorStore(
  config: IZepConfig,
): Promise<ZepVectorStore> {
  const docs = await loadDocs("./books");
  console.log(`Loaded ${docs.length} documents`);

  // Split the documents into chunks
  const splitter = new RecursiveCharacterTextSplitter({
    chunkSize: 1000,
    chunkOverlap: 200,
    separators: ["\n\n", "\n", " ", "", "\r", "\r\n"], // add carriage returns to the list of separators
  });

  // Split the documents into chunks. We also add the source of the document as a header to each chunk.
  const chunks = (
    await Promise.all(
      docs.map((doc) =>
        splitter.splitDocuments([doc], {
          chunkHeader: doc.metadata.source
            ? "SOURCE: " + doc.metadata.source.split("/").pop() + "\n\n"
            : "",
          appendChunkOverlapHeader: true,
        }),
      ),
    )
  ).flat();

  return ZepVectorStore.fromDocuments(chunks, new FakeEmbeddings(), config);
}
```

```typescript
异步函数 loadDocsIntoVectorStore(
  config: IZepConfig,
): Promise<ZepVectorStore> {
  const docs = await loadDocs("./books");
  console.log(`已加载 ${docs.length} 个文档`);

  // 将文档切分为文本块（chunks）
  const splitter = new RecursiveCharacterTextSplitter({
    chunkSize: 1000,
    chunkOverlap: 200,
    separators: ["\n\n", "\n", " ", "", "\r", "\r\n"], // 在分隔符列表中加入回车符
  });

  // 将文档切分为文本块，并为每个文本块添加文档来源作为页眉（header）。
  const chunks = (
    await Promise.all(
      docs.map((doc) =>
        splitter.splitDocuments([doc], {
          chunkHeader: doc.metadata.source
            ? "SOURCE: " + doc.metadata.source.split("/").pop() + "\n\n"
            : "",
          appendChunkOverlapHeader: true,
        }),
      ),
    )
  ).flat();

  return ZepVectorStore.fromDocuments(chunks, new FakeEmbeddings(), config);
}
```

We're creating a new Zep Collection, and so the config we pass into the `loadDocsIntoStore` function includes mandatory `embeddingDimensions` and `isAutoEmbedded` fields. The first specifies the width of the vectors generated by the embedding model we'll use, and the second tells Zep whether it should embed the documents for us. We can alternatively pass in embedding vectors.

我们正在创建一个新的 Zep Collection，因此传入 `loadDocsIntoStore` 函数的 `config` 对象必须包含必需字段 `embeddingDimensions` 和 `isAutoEmbedded`。前者指定我们将使用的嵌入模型所生成向量的维度（即向量宽度），后者则告知 Zep 是否应由其自动完成文档嵌入。我们也可以选择直接传入预计算好的嵌入向量。

```typescript
const config: IZepConfig = {
  apiUrl: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
  collectionName: ZEP_COLLECTION_NAME,
  embeddingDimensions: 768, // Set to the width of the model configured in Zep. Use 1536 for OpenAI
  isAutoEmbedded: true,
};
```

```typescript
const config: IZepConfig = {
  apiUrl: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
  collectionName: ZEP_COLLECTION_NAME,
  embeddingDimensions: 768, // 设置为 Zep 中配置的嵌入模型的向量维度；若使用 OpenAI 模型，请设为 1536
  isAutoEmbedded: true,
};
```

Let's populate our collection with documents and wait for Zep to embed them. Zep Collections have a `status` field that we can poll to determine whether all present documents have been embedded.

现在，让我们将文档载入该 Collection，并等待 Zep 完成嵌入。Zep 的 Collection 包含一个 `status` 字段，我们可通过轮询该字段来判断当前所有已上传文档是否均已嵌入完成。

```typescript
  // Create a new ZepVectorStore instance and load a document collection into it
  const vectorStore = await loadDocsIntoVectorStore(ZEP_COLLECTION_CONFIG);

  // Wait for the ZepVectorStore to finish embedding the documents
  console.log("Waiting for Zep to finish embedding documents...");
  while (true) {
    const c = await client.document.getCollection(ZEP_COLLECTION_NAME);
    console.log(
      `Embedding status: ${c.document_embedded_count}/${c.document_count} documents embedded`,
    );
    await new Promise((resolve) => setTimeout(resolve, 1000));
    if (c.status === "ready") {
      break;
    }
  }
```

```typescript
  // 创建一个新的 ZepVectorStore 实例，并将文档集加载到其中
  const vectorStore = await loadDocsIntoVectorStore(ZEP_COLLECTION_CONFIG);

  // 等待 ZepVectorStore 完成文档嵌入
  console.log("正在等待 Zep 完成文档嵌入……");
  while (true) {
    const c = await client.document.getCollection(ZEP_COLLECTION_NAME);
    console.log(
      `嵌入状态：${c.document_embedded_count}/${c.document_count} 个文档已完成嵌入`,
    );
    await new Promise((resolve) => setTimeout(resolve, 1000));
    if (c.status === "ready") {
      break;
    }
  }
```

Next, we'll configure our memory and chain classes and question the LLM about the books. We've configured the `ZepMemory` with a `memoryKey` and other fields. These need to be aligned with the prompts a chain uses and are dependent on the chain class.

接下来，我们将配置记忆（memory）与链（chain）相关类，并向大语言模型（LLM）提问有关这些书籍的内容。我们已为 `ZepMemory` 配置了 `memoryKey` 及其他字段；这些配置需与链（chain）所使用的提示词（prompt）保持一致，且具体取值取决于所采用的链类（chain class）。

```typescript
// Let's create a new ZepMemory instance. This will be used to store the current state of the conversation.
// Zep will also auto-summarize and enrich memories for you.
const memory = new ZepMemory({
  sessionId,
  baseURL: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
  memoryKey: "chat_history",
  inputKey: "question", // The key for the input to the chain
  outputKey: "text", // The key for the final conversational output of the chain
});

// 让我们创建一个新的 ZepMemory 实例。该实例将用于存储当前对话的状态。
// Zep 还会自动为记忆生成摘要并加以丰富。

const memory = new ZepMemory({
  sessionId,
  baseURL: ZEP_API_URL,
  apiKey: ZEP_API_KEY,
  memoryKey: "chat_history",
  inputKey: "question", // 链（chain）输入字段的键名
  outputKey: "text", // 链最终对话输出结果的键名
});

// Create a new ConversationalRetrievalQAChain instance
// Initialize the chain with the model, the vector store, and the memory
// We'll configure the VectorStore's Retriever to use Maximal Marginal Relevance reranking.
// This will re-rank the search results to ensure that the results are diverse.
const chain = ConversationalRetrievalQAChain.fromLLM(
  model,
  vectorStore.asRetriever({
    searchType: "mmr",
    k: 4,
  }),
  { memory: memory },
);

// 创建一个新的 ConversationalRetrievalQAChain 实例
// 使用模型、向量数据库（vector store）和记忆（memory）初始化该链
// 我们将配置向量数据库的检索器（Retriever），使其采用“最大边际相关性”（Maximal Marginal Relevance，MMR）进行重排序（reranking）
// 此举可对搜索结果重新排序，以确保返回结果具备多样性

const chain = ConversationalRetrievalQAChain.fromLLM(
  model,
  vectorStore.asRetriever({
    searchType: "mmr",
    k: 4,
  }),
  { memory: memory },
);
```

In the code above, we're passing in the `ZepVectorStore` class as a LangChain `Retriever.` Under the hood, Zep uses cosine similarity normalized to \[0,1\] to order search results. Here, we're configuring the Zep retriever to use [_Maximal Marginal Relevance_](https://python.langchain.com/docs/modules/model_io/prompts/example_selectors/mmr?ref=blog.langchain.com) to re-rank search results for diversity. This is useful for RAG apps but domain-dependent, and you should explore how helpful it is for your use case.

在上述代码中，我们将 `ZepVectorStore` 类作为 LangChain 的 `Retriever`（检索器）传入。其底层实现中，Zep 使用归一化至 \[0,1\] 区间的余弦相似度（cosine similarity）对搜索结果进行排序。此处，我们配置 Zep 检索器采用[**最大边际相关性**（Maximal Marginal Relevance，MMR）](https://python.langchain.com/docs/modules/model_io/prompts/example_selectors/mmr?ref=blog.langchain.com) 对搜索结果进行重排序，以提升结果的多样性。该策略对 RAG（检索增强生成）类应用很有帮助，但其效果高度依赖具体领域；因此，您应结合自身使用场景，评估其实际效用。

![](https://blog.getzep.com/content/images/2023/08/image-1.png)

![](https://blog.getzep.com/content/images/2023/08/image-1.png)

The [trace for a call to the chain is above](https://smith.langchain.com/public/9f799057-81c4-4d7e-86f9-dd0508ac00c1/r?ref=blog.langchain.com). With the `ConversationalRetrievalQAChain`, multiple calls are made to the LLM. First, depicted above, the LLM is provided with the user's question and the chat history and is asked to rephrase the question given this context. The rephrased question is then used to search over the document collection.

上方链接展示了对该链（chain）一次调用的[完整执行追踪（trace）](https://smith.langchain.com/public/9f799057-81c4-4d7e-86f9-dd0508ac00c1/r?ref=blog.langchain.com)。在 `ConversationalRetrievalQAChain` 中，大语言模型（LLM）会被调用多次：首先（如图所示），LLM 接收用户的原始问题及当前对话历史，并被要求基于该上下文对问题进行重述（rephrase）；随后，该重述后的问题将被用于在文档集合中执行检索。

This approach is helpful when a user's question alone does not convey enough context to search the vector database.

当用户仅凭单次提问无法提供足够上下文来有效检索向量数据库时，这种做法尤为有效。

I mentioned above how a thoughtful approach to chunking is essential to how well our app works. Well, so is data preparation. In looking at the search results from the vector store, I see that the first result is the Project Gutenberg preface to the book, as it is close in the vector space to our _book_-related query.

前文我已指出，审慎设计分块（chunking）策略对应用效果至关重要；而数据预处理（data preparation）同样关键。查看向量数据库返回的搜索结果时，我发现排在首位的是《Project Gutenberg》版该书的序言——因其在向量空间中与我们这个以“书籍”（_book_）为关键词的查询高度接近。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_003.png)

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_003.png)

We'd probably want to remove the preface when loading the files and before chunking to improve our results. The other three results are, however, relevant.

我们很可能需要在加载文件并执行分块（chunking）之前，就将该序言内容剔除，从而提升整体检索质量。不过，其余三项检索结果则确实与查询高度相关。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_004.png)

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_004.png)

Next, the search results are added to the prompt, along with the rephrased question. The LLM's response is highlighted in green below. It does a pretty good job of making sense of the document chunks we've provided it. The "source" header we added to each chunk has ensured that results relevant to _Philip K. Dick_ are returned.

接下来，搜索结果连同重述后的问题一并加入提示词（prompt）中。下方以绿色高亮显示大语言模型（LLM）的响应。它对我们在提示中提供的文档片段理解得相当到位。我们为每个文档片段添加的 `"source"` 标头，确保了返回的结果与 _菲利普·K·迪克（Philip K. Dick）_ 相关。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js_and-zep/img_005.png)

There [are alternative approaches](https://js.langchain.com/docs/modules/chains/document/?ref=blog.langchain.com) to summarizing and refining search results before populating them into a prompt. These do come at the cost of additional LLM calls, so it's worth exploring the value trade-off for your app.

在将搜索结果填入提示词之前，还存在[其他可选方法](https://js.langchain.com/docs/modules/chains/document/?ref=blog.langchain.com)，例如先对结果进行摘要或精炼。但这些方法会带来额外的大语言模型调用开销，因此值得针对您的具体应用评估其投入产出比。

### Building a REACT-type agent with Zep Memory Retrieval and Search as Tools

### 构建一个基于 Zep 记忆检索与搜索功能的 REACT 类型智能体（Agent）

The last type of app we'll build is an agent that uses Zep's conversational history and vector store as tools. We'll take a quick look at the set up below, but will spend time on the tools themselves.

我们将构建的最后一类应用是一个智能体（agent），它将 Zep 的对话历史记录和向量数据库作为工具来使用。下面我们将简要介绍其初始化配置，但重点将放在各工具本身的设计与实现上。

We're using the `initializeAgentExecutorWithOptions` helper function to initialize the agent, passing in our tool list and LLM. Passing in a ZepMemory class is also possible, but we'll keep it simple for this demonstration.

我们使用 `initializeAgentExecutorWithOptions` 辅助函数来初始化该智能体，并传入工具列表和大语言模型（LLM）。虽然也可以传入 `ZepMemory` 类实例，但为简化本次演示，我们暂不启用该功能。

Each tool has a description that the LLM uses to determine which tool will most likely help it with its task. Note that the agent and tool setup below is fairly primitive. You can build far more [sophisticated ones using Zod](https://js.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com) and [OpenAI Functions](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com).

每个工具都配有描述文本，供大语言模型判断哪个工具最有可能协助完成当前任务。请注意，下方展示的智能体与工具配置较为基础。您还可以借助 [Zod](https://js.langchain.com/docs/modules/agents/agent_types/structured_chat?ref=blog.langchain.com) 或 [OpenAI Functions](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com) 构建更为复杂的智能体。

```typescript
// Let's build an agent!
// 我们来构建一个智能体！
const zepMemoryRetriever = await new ZepRetriever({
    url: ZEP_API_URL,
    apiKey: ZEP_API_KEY,
    sessionId: sessionId,
});

// Create some tools.
// 创建若干工具。
const tools = [\
  new DynamicTool({\
    name: "peopleRetriever",\
    description: `call this if you want to search for authors, characters, or people we may have discussed in the\
past. input should be a search string`,\
    func: async (query) =>\
      await getPeopleFromMemoryTool(query, zepMemoryRetriever),\
  }),\
  new DynamicTool({\
    name: "bookSearch",\
    description:\
      "call this if to search for passages in sci-fi books. input should be a search string",\
    func: async (query) => await getBookSearchTool(query, vectorStore),\
  }),\
];

const executor = await initializeAgentExecutorWithOptions(tools, model, {
  agentType: "zero-shot-react-description",
});
```

Zep has a special LangChain Retriever, the aptly named `ZepRetriever`, for searching over a session's chat history.  
Zep 提供了一个专用于 LangChain 的检索器——恰如其名的 `ZepRetriever`，可用于在会话的聊天历史中进行搜索。

We're using this above in our first tool, the `peopleRetriever`. As the description implies, this tool searches over historical chat messages for a person. The tool also filters chat message results using Zep's entity metadata for `PERSON` entities.  
我们在首个工具 `peopleRetriever` 中便使用了该检索器。顾名思义，该工具用于在历史聊天消息中检索某个人物；同时，它还利用 Zep 为 `PERSON`（人物）实体所标注的元数据对聊天消息结果进行过滤。

```typescript
async function getPeopleFromMemoryTool(
  query: string,
  retriever: ZepRetriever,
): Promise<string> {
  return retriever
    .getRelevantDocuments(query, {
      metadata: {
        where: { jsonpath: '$.system.entities[*] ? (@.Label == "PERSON")' },
      },
    })
    .then((docs) => {
      const filteredDocs = docs.filter((doc) => doc.metadata.dist >= 0.8);
      return (
        filteredDocs.length > 0
          ? filteredDocs.map((doc) => doc.pageContent)
          : ["No results"]
      ).join("\n\n");
    });
}
```

The function also filters for a cosine similarity above 0.8 to ensure that irrelevant chat messages are not returned to the LLM.  
该函数还进一步按余弦相似度 ≥ 0.8 进行筛选，以确保不会将不相关的聊天消息返回给大语言模型（LLM）。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_006.png)

In the trace above, we can see that we've asked the agent whether we've previously discussed _Kurt Vonnegut_. The agent has correctly determined that it should use the `peopleRetriever` tool with input `Kurt Vonnegut`.  
在上方的调用追踪（trace）中，我们可以看到：我们向智能体（agent）提问——此前是否讨论过 _库尔特·冯内古特（Kurt Vonnegut）_？智能体准确判断应调用 `peopleRetriever` 工具，并传入查询词 `Kurt Vonnegut`。

Next, the search results are returned from the tool, passed to the LLM, and it has determined that we have indeed mentioned _Kurt Vonnegut_ in our prior conversations.  
随后，工具返回检索结果，并交由大语言模型处理；模型据此确认：我们确实在先前的对话中提及过 _库尔特·冯内古特_。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_007.png)

Finally, let's take a look at the agent's use of the `bookSearch` tool. We've asked it the following question: _Which sci-fi novel featured a gun club headquartered in Baltimore?_  
最后，我们来看智能体如何调用 `bookSearch` 工具。我们向它提出了如下问题：_哪部科幻小说中描写了一家总部设在巴尔的摩的“枪械俱乐部”？_

Viewing [the trace below](https://smith.langchain.com/public/3db03218-8486-4048-94d8-230401696c98/r?ref=blog.langchain.com), we see the agent chose the correct tool and searched the book collection for _gun club Baltimore_. The vector database returned book chunks relevant to the query, and the agent responds with _From the Earth to the Moon_ by Jules Verne.  
通过查看[下方的调用追踪](https://smith.langchain.com/public/3db03218-8486-4048-94d8-230401696c98/r?ref=blog.langchain.com)，可见智能体正确选择了该工具，并以 _gun club Baltimore_（枪械俱乐部 巴尔的摩）为关键词在图书库中执行检索。向量数据库返回了与查询高度相关的一组图书文本片段（book chunks），智能体最终给出答案：儒勒·凡尔纳（Jules Verne）所著的《从地球到月球》（_From the Earth to the Moon_）。

![](images/zep-x-langsmith-foundations-of-llm-app-development-with-langchain_js-and-zep/img_008.png)

### Summing it up

### 总结

We've explored how to build three foundational LLM app types using LangChain.js and Zep, and, using LangSmith, took a look under the hood as to how things worked.

我们已探索了如何使用 LangChain.js 和 Zep 构建三种基础的 LLM 应用类型，并借助 LangSmith 深入了解了其内部工作原理。

As mentioned above, the chains, agents, and tools we used are quite primitive. The [LangChain docs](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com) are worth exploring as you consider how to solve different problems when building your app. You'll see most value from Zep's features, including message metadata, when you start to customize or build your own agents and tools.

如上所述，我们所使用的链（chains）、智能体（agents）和工具（tools）都还较为基础。在构建应用、思考如何解决各类问题时，建议深入查阅 [LangChain 官方文档](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com)。而当你开始定制或自主开发智能体与工具时，Zep 的各项特性（例如消息元数据）才能真正发挥最大价值。

### Next Steps

### 下一步

- Sign up for the [LangSmith beta](https://smith.langchain.com/?ref=blog.langchain.com)  
- 注册 [LangSmith 测试版](https://smith.langchain.com/?ref=blog.langchain.com)

- Get setup with Zep using the [Quick Start Guide](https://docs.getzep.com/deployment/quickstart?ref=blog.langchain.com)  
- 通过 [快速入门指南](https://docs.getzep.com/deployment/quickstart?ref=blog.langchain.com) 开始使用 Zep