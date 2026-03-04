---
title: "Cube x LangChain: Building AI experiences with LLMs and the semantic layer"
source: "LangChain Blog"
url: "https://blog.langchain.com/cube-x-langchain-building-ai-experiences-with-llms-and-the-semantic-layer/"
date: "2023-08-23"
scraped_at: "2026-03-03T08:51:03.186456353+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the [Cube](https://cube.dev/?ref=blog.langchain.com) team. The semantic layer plays a key role in ensuring correctness and predictability when building text-to-sql LLM-based applications. Their integration with LangChain makes it really easy to get started with building AI applications on top of the Cube semantic layer._

_编辑者注：本文由 [Cube](https://cube.dev/?ref=blog.langchain.com) 团队协作撰写。语义层在构建基于大语言模型（LLM）的文本转 SQL 应用时，对保障结果的准确性与可预测性起着关键作用。Cube 与 LangChain 的集成，极大简化了在 Cube 语义层之上构建 AI 应用的入门流程。_

For many years already, we live in the data-driven world where accessing the data and deriving insights from it efficiently is paramount. This year, we experience an explosion of interest to artificial intelligence (AI) and large language models (LLMs) in particular, fueled by the latest developments in the technology and vast perspectives unfolding.

多年来，我们已身处一个数据驱动的世界——高效地访问数据并从中提取洞见，始终至关重要。今年，人工智能（AI）尤其是大语言模型（LLMs）引发了空前的关注热潮，这得益于技术的最新突破以及由此展开的广阔前景。

[LangChain](https://www.langchain.com/?ref=blog.langchain.com), an extensive toolkit for working with LLMs, has become one of the most important building blocks for developers of AI experiences. At Cube, we know that our semantic layer is also an important building block for AI applications because Cube not only centralizes metrics calculations but also serves an [antidote to AI hallucinations](https://cube.dev/blog/semantic-layer-the-backbone-of-ai-powered-data-experiences?ref=blog.langchain.com).

[LangChain](https://www.langchain.com/?ref=blog.langchain.com) 是一个功能完备的大语言模型开发工具包，已成为构建 AI 体验的开发者最核心的基础设施之一。在 Cube，我们深知自身的语义层同样是 AI 应用的重要基石——因为 Cube 不仅能集中化指标计算，更可作为应对 AI “幻觉”（hallucinations）的[一剂解药](https://cube.dev/blog/semantic-layer-the-backbone-of-ai-powered-data-experiences?ref=blog.langchain.com)。

## **Semantic document loader**

## **语义文档加载器**

Today, we're happy to present Cube's integration with LangChain. It comes as the [document loader](https://python.langchain.com/docs/integrations/document_loaders/cube_semantic?ref=blog.langchain.com) that is intended to be used to populate a vector database with embeddings derived from the data model of the semantic layer. Later, this vector database can be queried to find best-matching entities of the semantic layer. This is useful to match free-form input, e.g., queries in a natural language, with the views and their members in the data model.

今天，我们很高兴正式推出 Cube 与 LangChain 的集成方案。该集成以 [文档加载器（document loader）](https://python.langchain.com/docs/integrations/document_loaders/cube_semantic?ref=blog.langchain.com) 的形式提供，旨在将语义层数据模型所生成的嵌入（embeddings）导入向量数据库。后续即可通过查询该向量数据库，快速定位语义层中最匹配的实体。这一能力特别适用于将自由形式的输入（例如自然语言查询）与数据模型中的视图（views）及其成员（members）进行精准匹配。

![вуьщ](images/cube-x-langchain-building-ai-experiences-with-llms-and-the-semantic-layer/img_001.jpg)

![вуьщ](images/cube-x-langchain-building-ai-experiences-with-llms-and-the-semantic-layer/img_001.jpg)

We're also providing an chat-based demo application (see [source code](https://github.com/cube-js/cube/tree/master/examples/langchain?ref=blog.langchain.com) on GitHub) with example [OpenAI prompts](https://github.com/cube-js/cube/blob/master/examples/langchain/utils.py?ref=blog.langchain.com#L48,L87) for constructing queries to Cube's [SQL API](https://cube.dev/docs/product/apis-integrations/sql-api?ref=blog.langchain.com). If you wish to create an [AI-powered conversational interface](https://cube.dev/blog/conversational-interface-for-semantic-layer?ref=blog.langchain.com) for the semantic layer, functioning similar to [Delphi](https://www.delphihq.com/?ref=blog.langchain.com), these prompts can be a good starting point.

我们还提供了一个基于聊天界面的演示应用（参见 GitHub 上的[源代码](https://github.com/cube-js/cube/tree/master/examples/langchain?ref=blog.langchain.com)），其中包含用于构造发往 Cube [SQL API](https://cube.dev/docs/product/apis-integrations/sql-api?ref=blog.langchain.com) 查询的示例 [OpenAI 提示词（prompts）](https://github.com/cube-js/cube/blob/master/examples/langchain/utils.py?ref=blog.langchain.com#L48,L87)。若您希望为语义层打造一个类似 [Delphi](https://www.delphihq.com/?ref=blog.langchain.com) 的、[由 AI 驱动的对话式交互界面](https://cube.dev/blog/conversational-interface-for-semantic-layer?ref=blog.langchain.com)，这些提示词将是极佳的起点。

## **Chat-based demo app, dissected**

## **基于聊天的演示应用：深度解析**

Here's what you can build with the all-new document loader for LangChain, a vector database, an LLM by [OpenAI](https://openai.com/?ref=blog.langchain.com), and [Streamlit](https://streamlit.io/?ref=blog.langchain.com) for the user interface:

借助 LangChain 全新推出的文档加载器、一个向量数据库、来自 [OpenAI](https://openai.com/?ref=blog.langchain.com) 的大语言模型（LLM），以及用于用户界面的 [Streamlit](https://streamlit.io/?ref=blog.langchain.com)，您可构建如下应用：

1×

1×  

See how the tables, columns, aggregations, and filters in the SQL query generated by an LLM match the human input.  
查看大语言模型（LLM）生成的 SQL 查询中的表、列、聚合和过滤条件，如何与用户输入相匹配。

Check the [README file on GitHub](https://github.com/cube-js/cube/blob/master/examples/langchain/README.md?ref=blog.langchain.com) for pointers on running this demo application on your machine or skim through the following highlights.  
请查阅 [GitHub 上的 README 文件](https://github.com/cube-js/cube/blob/master/examples/langchain/README.md?ref=blog.langchain.com)，了解如何在本地运行本演示应用；或快速浏览以下关键要点。

**Ingesting metadata from Cube and populating the vector database.**  
**从 Cube 摄取元数据并填充向量数据库。**

The `ingest_cube_meta` function in the `ingest.py` file loads the data model from Cube using the all-new `CubeSemanticLoader`. Note that only [views](https://cube.dev/docs/product/data-modeling/reference/view?ref=blog.langchain.com) are loaded as they are considered the ["facade" of the data model](https://cube.dev/blog/complementing-data-graph-with-views?ref=blog.langchain.com). Loaded documents are then embedded and saved in the FAISS vector store, which is subsequently pickled for later use.  
`ingest.py` 文件中的 `ingest_cube_meta` 函数通过全新的 `CubeSemanticLoader` 从 Cube 加载数据模型。注意：仅加载 [视图（views）](https://cube.dev/docs/product/data-modeling/reference/view?ref=blog.langchain.com)，因为它们被视为数据模型的“门面”（["facade" of the data model](https://cube.dev/blog/complementing-data-graph-with-views?ref=blog.langchain.com)）。加载后的文档经嵌入处理，存入 FAISS 向量数据库，并进一步序列化为 `pickle` 文件以供后续使用。

```
def ingest_cube_meta():
    ...
    loader = CubeSemanticLoader(api_url, api_token)
    documents = loader.load()
    ...
    with open("vectorstore.pkl", "wb") as f:
        pickle.dump(vectorstore, f)
```

```
def ingest_cube_meta():
    ...
    loader = CubeSemanticLoader(api_url, api_token)
    documents = loader.load()
    ...
    with open("vectorstore.pkl", "wb") as f:
        pickle.dump(vectorstore, f)
```

**LLM setup.**  
**LLM 初始化配置。**

In the `main.py` file, dependencies are imported and the environment variables are loaded. The OpenAI model (`llm`) is initialized with the provided API key.  
在 `main.py` 文件中，导入所需依赖项并加载环境变量；随后使用提供的 API 密钥初始化 OpenAI 模型（`llm`）。

```
import ...
load_dotenv()
llm = OpenAI(
    temperature=0,
    openai_api_key=os.environ.get("OPENAI_API_KEY"),
    verbose=True
)
```

```
import ...
load_dotenv()
llm = OpenAI(
    temperature=0,
    openai_api_key=os.environ.get("OPENAI_API_KEY"),
    verbose=True
)
```

**User input and vector store initialization.**  
**用户输入与向量数据库初始化。**

In the same file, Streamlit primitives are utilized to get user input:  
在同一文件中，使用 Streamlit 基础组件获取用户输入：

```
question = st.text_input(
    "Your question: ",
    placeholder="Ask me anything ...",
    key="input"
)
if st.button("Submit", type="primary"):
    check_input(question)
    vectorstore = init_vectorstore()
```

```
question = st.text_input(
    "您的问题：",
    placeholder="随时向我提问……",
    key="input"
)
if st.button("提交", type="primary"):
    check_input(question)
    vectorstore = init_vectorstore()
```

**Querying the vector store.**  
**查询向量数据库。**

The vector store is queried for documents similar to the user's question. The best match's table name is extracted and taken as the best guess to try to create a prompt using the columns from vectorstore:  
向量数据库将被查询，以检索与用户问题语义最相近的文档。从中提取匹配度最高的文档所对应的表名，并将其作为最优猜测，用于基于该表的列信息构建提示词（prompt）：

```
docs = vectorstore.similarity_search(question)
    # take the first document as the best guess
    table_name = docs[0].metadata["table_name"]
```

```
docs = vectorstore.similarity_search(question)
    # 将首个文档视为最优猜测
    table_name = docs[0].metadata["table_name"]
```

# Columns

# 列

columns_question = "All available columns"  
columns_question = "所有可用的列"

column_docs = vectorstore.similarity_search(  
column_docs = vectorstore.similarity_search(  
    columns_question,  
    columns_question,  
    filter=dict(table_name=table_name),  
    filter=dict(table_name=table_name),  
    k=15  
    k=15  
)  
)

**Building the prompt and calling OpenAI.**  
**构建提示词并调用 OpenAI。**

> The OpenAI large language model is called with the constructed prompt, and the response is parsed to extract the SQL query and any associated filters:  
> 使用构建好的提示词调用 OpenAI 大语言模型，并对返回结果进行解析，以提取 SQL 查询语句及相关的过滤条件：

```
# Construct the prompt  
# 构建提示词  
prompt = CUBE_SQL_API_PROMPT.format(  
    input_question=question,  
    table_info=table_name,  
    columns_info=columns,  
    top_k=1000,  
    no_answer_text=_NO_ANSWER_TEXT,  
)  
llm_answer = llm(prompt + PROMPT_POSTFIX)  
```

![](images/cube-x-langchain-building-ai-experiences-with-llms-and-the-semantic-layer/img_002.jpg)

## **Wrapping up**

## **总结**

Cube's integration with LangChain provides a seamless interface for querying data using natural language. By abstracting the complexities of SQL and leveraging the power of LLMs, it provides the builders of AI experiences with a user-friendly and error-prone approach to data access.  
Cube 与 LangChain 的集成提供了一种无缝的自然语言数据查询接口。通过屏蔽 SQL 的复杂性，并充分利用大语言模型（LLM）的能力，它为 AI 应用构建者提供了一种用户友好、且不易出错的数据访问方式。

> It is essential for enterprises to leverage internal knowledge correctly with the power of LLM’s reasoning. Cube’s semantic layer integration with LangChain is a great example of how most product companies will eventually write smart integrations for LLMs to better power these reasoning engines.  
> 企业必须借助大语言模型（LLM）的推理能力，正确地利用内部知识。Cube 的语义层与 LangChain 的集成，正是产品公司未来普遍采用的一种“智能集成”范例——即通过精心设计的集成方案，更好地赋能这些推理引擎。
&#123;% endraw %}
