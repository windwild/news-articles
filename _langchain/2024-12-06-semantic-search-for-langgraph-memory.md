---
title: "Semantic Search for LangGraph Memory"
source: "LangChain Blog"
url: "https://blog.langchain.com/semantic-search-for-langgraph-memory/"
date: "2024-12-06"
scraped_at: "2026-03-03T07:46:34.190168151+00:00"
language: "en-zh"
translated: true
tags: ["langgraph", "memory", "agents", "agent builder", "![Building Multi-Agent Apps", "deep agents", "![Reflection Agents", "**Reflection Agents**", "**Plan-and-Execute Agents**", "By LangChain"]
---
{% raw %}

Following our [launch of long-term memory support](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/), we're adding semantic search to LangGraph's BaseStore. Available today in the open source `PostgresStore` and `InMemoryStore`'s, in LangGraph studio, as well as in production in all LangGraph Platform deployments.

继我们推出[长期记忆支持](https://blog.langchain.com/launching-long-term-memory-support-in-langgraph/)之后，我们现为 LangGraph 的 BaseStore 增加了语义搜索功能。该功能现已在开源的 `PostgresStore` 和 `InMemoryStore` 中可用，同时亦已集成至 LangGraph Studio，并在所有 LangGraph Platform 的生产环境中正式上线。

**Quick Links:**  
**快速链接：**

- [Video tutorial](https://youtu.be/HfJ4h380J_U?ref=blog.langchain.com) on adding semantic search to the memory agent template  
- [为记忆智能体模板添加语义搜索的视频教程](https://youtu.be/HfJ4h380J_U?ref=blog.langchain.com)

- [How to guide](https://langchain-ai.github.io/langgraph/how-tos/memory/semantic-search/?ref=blog.langchain.com) on adding semantic search in LangGraph  
- [LangGraph 中添加语义搜索的操作指南](https://langchain-ai.github.io/langgraph/how-tos/memory/semantic-search/?ref=blog.langchain.com)

- [How to guide](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com) on adding semantic search in your LangGraph Platform deployment  
- [在您的 LangGraph Platform 部署中启用语义搜索的操作指南](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com)

![](images/semantic-search-for-langgraph-memory/img_001.png)

## Why semantic search?  
## 为何需要语义搜索？

While our base memory implementation provides document storage and filtering, many users requested primitives for more sophisticated retrieval of unstructured information. Simple filtering works when you keep things well-organized, but agents often need to find relevant information based on meaning, not just exact matches.

尽管我们的基础记忆实现已支持文档存储与过滤，许多用户仍呼吁提供更高级的非结构化信息检索能力。简单过滤仅在信息组织良好时才有效；而智能体往往需依据语义（而非仅靠字面精确匹配）来查找相关信息。

For example, an agent might need to:  
例如，一个智能体可能需要：

- Recall user preferences and past interactions for personalized responses  
- 回忆用户偏好及过往交互，以生成个性化响应

- Learn from past mistakes by retrieving similar failed approaches  
- 通过检索相似的失败方案，从过往错误中学习

- Maintain consistent knowledge by recalling important facts learned in previous interactions  
- 通过回顾此前交互中习得的关键事实，保持知识的一致性

Semantic search addresses these challenges by matching on meaning rather than exact content, making agents more effective at using their stored knowledge.  
语义搜索通过语义匹配（而非字面内容匹配）应对上述挑战，从而显著提升智能体对所存知识的利用效率。

## Implementation  
## 实现方式

The `BaseStore`'s `search` (and asynchronous `asearch`) methods now support a natural language `query` term.  
`BaseStore` 的 `search`（以及异步版本 `asearch`）方法现在支持自然语言形式的 `query` 参数。

If the store you are using has added support, documents will be scored and returned based on semantic similarity.  
如果你所使用的存储后端已添加相关支持，文档将依据语义相似度进行打分并返回。

Support has been added to both the `InMemoryStore` for development and `PostgresStore` for production.  
目前，开发用的 `InMemoryStore` 和生产环境用的 `PostgresStore` 均已支持该功能。

An example usage is below:  
以下是一个使用示例：

```python
def search_memory(state: State, *, store: BaseStore):
    results = store.search(
        ("user_123", "interactions"),
        query=state["messages"][-1].content,
        filter={"type": "conversation"},
        limit=3
    )
    return {
        "context": [\
            f"Previous interaction ({r.score:.2f} relevance):\n{r.value}"\
            for r in results\
        ]
    }
Example search node to lookup relevant memories.
```

```python
def search_memory(state: State, *, store: BaseStore):
    results = store.search(
        ("user_123", "interactions"),
        query=state["messages"][-1].content,
        filter={"type": "conversation"},
        limit=3
    )
    return {
        "context": [\
            f"Previous interaction ({r.score:.2f} relevance):\n{r.value}"\
            for r in results\
        ]
    }
用于检索相关记忆的搜索节点示例。
```

Example node querying for related content  
用于查询相关内容的节点示例

To use in the LangGraph Platform, you can configure your server to embed new items through a `store` configuration in your `langgraph.json` file:  
若要在 LangGraph 平台中使用该功能，你可在 `langgraph.json` 文件中通过 `store` 配置项，为服务器配置新条目的嵌入（embedding）能力：

```json
{
  "store": {
    "index": {
      "embed": "openai:text-embeddings-3-small",
      "dims": 1536,
      "fields": ["text", "summary"]
    }
  }
}
```

```json
{
  "store": {
    "index": {
      "embed": "openai:text-embeddings-3-small",
      "dims": 1536,
      "fields": ["text", "summary"]
    }
  }
}
```

The main configuration options:  
主要配置项说明：

- `embed`: Embedding provider (e.g., "openai:text-embedding-3-small") or path to custom function ([doc](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com#custom-embeddings)). `provider:model` support depends on LangChain to use.  
- `embed`：嵌入模型提供方（例如 `"openai:text-embedding-3-small"`），或自定义函数的路径（[文档](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com#custom-embeddings)）。`provider:model` 格式的支持依赖于 LangChain 的集成能力。

- `dims`: Dimension size of the chosen embedding model (1536 for OpenAI's text-embedding-3-small)  
- `dims`：所选嵌入模型的向量维度（OpenAI 的 `text-embedding-3-small` 模型为 1536 维）

- `fields`: List of fields to index. Use `["$"]` to index entire documents, or specify json paths like `["text", "summary", "messages[-1]"]`  
- `fields`：需索引的字段列表。使用 `["$"]` 可索引整个文档；也可指定 JSON 路径，例如 `["text", "summary", "messages[-1]"]`

If you're not a LangChain user, or if you want to define custom embedding logic, define your own function:  
如果你不是 LangChain 用户，或希望实现自定义的嵌入逻辑，请自行定义函数：

```python
async def aembed_texts(texts: list[str]) -> list[list[float]]:
    response = await client.embeddings.create(
        model="text-embedding-3-small",
        input=texts
    )
    return [e.embedding for e in response.data]
```

```python
async def aembed_texts(texts: list[str]) -> list[list[float]]:
    response = await client.embeddings.create(
        model="text-embedding-3-small",
        input=texts
    )
    return [e.embedding for e in response.data]
```

Then reference your function in the config:  
随后，在配置中引用该函数：

```json
{
  "store": {
    "index": {
      "embed": "path/to/embedding_function.py:embed_texts",
      "dims": 1536
    }
  }
}
```

```json
{
  "store": {
    "index": {
      "embed": "path/to/embedding_function.py:embed_texts",
      "dims": 1536
    }
  }
}
```

If you want to customize which fields to embed for a given item, or if you want to omit an item from being indexed, pass the `index` arg to `store.put`.

如果你想自定义对某个条目嵌入（embedding）哪些字段，或希望跳过某一条目、不将其加入索引，请向 `store.put` 方法传入 `index` 参数。

```
# embed the configured default "text" field "Python tutorial"
store.put(("docs",), "doc1", {"text": "Python tutorial"})
# Override default field to embed "other_field" instead
store.put(
    ("docs",),
    "doc2",
    {"text": "TypeScript guide", "other_field": "value"},
    index=["other_field"],
)
# Do not embed this item
store.put(("docs",), "doc2", {"text": "Other guide"}, index=False)
```

```
# 嵌入已配置的默认字段 "text"："Python 教程"
store.put(("docs",), "doc1", {"text": "Python tutorial"})
# 覆盖默认字段，改为嵌入 "other_field"
store.put(
    ("docs",),
    "doc2",
    {"text": "TypeScript 指南", "other_field": "value"},
    index=["other_field"],
)
# 不对该条目执行嵌入
store.put(("docs",), "doc2", {"text": "其他指南"}, index=False)
```

See the [docs](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com#custom-embeddings) for more information.

请参阅[文档](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com#custom-embeddings)了解更多信息。

## Migration

## 迁移指南

If you're already using LangGraph's memory store, adding semantic search is non-breaking. All operations work the same as before. LangGraph OSS users can start using by constructing their `PostGresStore` with an index configuration ( [sync](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.postgres.PostgresStore) & [async](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.postgres.AsyncPostgresStore) docs):

如果你已在使用 LangGraph 的内存存储（memory store），添加语义搜索功能是**完全向后兼容**的——所有原有操作行为保持不变。LangGraph 开源版（OSS）用户只需在构造 `PostgresStore` 时传入索引配置，即可立即启用该功能（详见 [同步版文档](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.postgres.PostgresStore) 和 [异步版文档](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.postgres.AsyncPostgresStore)）：

```
from langchain.embeddings import init_embeddings
from langgraph.store.postgres import PostgresStore

store = PostgresStore(
    connection_string="postgresql://user:pass@localhost:5432/dbname",
    index={
        "dims": 1536,
        "embed": init_embeddings("openai:text-embedding-3-small"),
        # specify which fields to embed. Default is the whole serialized value
        "fields": ["text"],
    },
)
store.setup()  # Do this once to run migrations
```

```
from langchain.embeddings import init_embeddings
from langgraph.store.postgres import PostgresStore

store = PostgresStore(
    connection_string="postgresql://user:pass@localhost:5432/dbname",
    index={
        "dims": 1536,
        "embed": init_embeddings("openai:text-embedding-3-small"),
        # 指定要嵌入的字段，默认为整个序列化后的值
        "fields": ["text"],
    },
)
store.setup()  # 仅需执行一次，用于运行数据库迁移
```

For LangGraph platform users, once you add an `index` configuration to your deployment, new documents that are `put` into the store can be indexed for search, and you can add a natural language `query` string to return documents sorted by semantic similarity.

对于 LangGraph 平台用户，只要在部署中添加 `index` 配置，后续通过 `put` 写入存储的新文档即可被自动索引以支持搜索；你还可以传入一段自然语言 `query` 字符串，系统将返回按语义相似度排序的相关文档。

## Next Steps

## 后续步骤

We've updated our documentation & templates to demonstrate semantic search in action. Check them out at the links below:

我们已更新文档与模板，以实际演示语义搜索功能。请通过下方链接查看：

- [Memory Template](https://github.com/langchain-ai/memory-template?ref=blog.langchain.com) uses search over memories saved "in the background"  
- [Memory Template（记忆模板）](https://github.com/langchain-ai/memory-template?ref=blog.langchain.com)：在“后台”保存的记忆上执行搜索

- [Memory Agent](https://github.com/langchain-ai/memory-agent?ref=blog.langchain.com) searches over memories saved as a tool  
- [Memory Agent（记忆智能体）](https://github.com/langchain-ai/memory-agent?ref=blog.langchain.com)：将记忆作为工具保存，并在其上执行搜索

- [Video tutorial](https://youtu.be/HfJ4h380J_U?ref=blog.langchain.com) on adding semantic search to the memory agent template  
- [视频教程](https://youtu.be/HfJ4h380J_U?ref=blog.langchain.com)：如何为 Memory Agent 模板添加语义搜索功能

- [How to guide](https://langchain-ai.github.io/langgraph/how-tos/memory/semantic-search/?ref=blog.langchain.com) on adding semantic search in LangGraph  
- [操作指南](https://langchain-ai.github.io/langgraph/how-tos/memory/semantic-search/?ref=blog.langchain.com)：如何在 LangGraph 中添加语义搜索功能

- [How to guide](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com) on adding semantic search in your LangGraph Platform deployment  
- [操作指南](https://langchain-ai.github.io/langgraph/cloud/deployment/semantic_search/?ref=blog.langchain.com)：如何在您的 LangGraph Platform 部署中添加语义搜索功能

- [Reference docs](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.base.BaseStore.search) on the BaseStore  
- [参考文档](https://langchain-ai.github.io/langgraph/reference/store/?ref=blog.langchain.com#langgraph.store.base.BaseStore.search)：关于 `BaseStore` 的说明

Try it out and share your feedback on [GitHub](https://github.com/langchain-ai/langgraph/discussions?ref=blog.langchain.com).

欢迎试用，并在 [GitHub](https://github.com/langchain-ai/langgraph/discussions?ref=blog.langchain.com) 上分享您的反馈。

And finally, for more conceptual information on AI memory, check out our [memory conceptual documentation](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com).

最后，如需深入了解 AI 记忆的相关概念，请查阅我们的 [记忆概念文档（Memory Conceptual Documentation）](https://langchain-ai.github.io/langgraph/concepts/memory/?ref=blog.langchain.com)。

### Tags

### 标签

[langgraph](https://blog.langchain.com/tag/langgraph/) [memory](https://blog.langchain.com/tag/memory/) [agents](https://blog.langchain.com/tag/agents/)

[langgraph](https://blog.langchain.com/tag/langgraph/) [memory（记忆）](https://blog.langchain.com/tag/memory/) [agents（智能体）](https://blog.langchain.com/tag/agents/)

[![Introducing Agent Builder templates](images/semantic-search-for-langgraph-memory/img_002.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[![推出 Agent Builder 模板](images/semantic-search-for-langgraph-memory/img_002.png)](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**Deploy agents instantly with Agent Builder templates**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[**使用 Agent Builder 模板即时部署智能体**](https://blog.langchain.com/introducing-agent-builder-template-library/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 3 min read

[agent builder（Agent Builder）](https://blog.langchain.com/tag/agent-builder/) 阅读时长：3 分钟

[![Building Multi-Agent Apps](images/semantic-search-for-langgraph-memory/img_003.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[![构建多智能体应用](images/semantic-search-for-langgraph-memory/img_003.png)](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**Building Multi-Agent Applications with Deep Agents**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[**使用 Deep Agents 构建多智能体应用**](https://blog.langchain.com/building-multi-agent-applications-with-deep-agents/)

[deep agents](https://blog.langchain.com/tag/deep-agents/) 5 min read

[deep agents](https://blog.langchain.com/tag/deep-agents/) 阅读时长：5 分钟

[![LangSmith Agent Builder Now Generally Available](images/semantic-search-for-langgraph-memory/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[![LangSmith Agent Builder 现已正式发布（GA）](images/semantic-search-for-langgraph-memory/img_004.png)](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**Now GA: LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[**现已正式发布（GA）：LangSmith Agent Builder**](https://blog.langchain.com/langsmith-agent-builder-generally-available/)

[agents](https://blog.langchain.com/tag/agents/) 2 min read

[agents](https://blog.langchain.com/tag/agents/) 阅读时长：2 分钟

[![How to Build the Ultimate AI Automation with Multi-Agent Collaboration](images/semantic-search-for-langgraph-memory/img_005.webp)](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/)

[![如何通过多智能体协作构建终极 AI 自动化系统](images/semantic-search-for-langgraph-memory/img_005.webp)](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/)

[**How to Build the Ultimate AI Automation with Multi-Agent Collaboration**](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/)

[**如何通过多智能体协作构建终极 AI 自动化系统**](https://blog.langchain.com/how-to-build-the-ultimate-ai-automation-with-multi-agent-collaboration/)

[langgraph](https://blog.langchain.com/tag/langgraph/) 8 min read

[langgraph](https://blog.langchain.com/tag/langgraph/) 阅读时长：8 分钟

[![Reflection Agents](images/semantic-search-for-langgraph-memory/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[![反思型智能体（Reflection Agents）](images/semantic-search-for-langgraph-memory/img_006.jpg)](https://blog.langchain.com/reflection-agents/)

[**Reflection Agents**](https://blog.langchain.com/reflection-agents/)

[**反思型智能体（Reflection Agents）**](https://blog.langchain.com/reflection-agents/)

[agents](https://blog.langchain.com/tag/agents/) 6 min read

[智能体（agents）](https://blog.langchain.com/tag/agents/) 阅读时长：6 分钟

[![Plan + Execute Agent Thumbnail](images/semantic-search-for-langgraph-memory/img_007.png)](https://blog.langchain.com/planning-agents/)

[![Plan + Execute Agent 缩略图](images/semantic-search-for-langgraph-memory/img_007.png)](https://blog.langchain.com/planning-agents/)

[**Plan-and-Execute Agents**](https://blog.langchain.com/planning-agents/)

[**规划与执行型智能体（Plan-and-Execute Agents）**](https://blog.langchain.com/planning-agents/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 5 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：5 分钟
{% endraw %}
