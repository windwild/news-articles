---
title: "Incorporating domain specific knowledge in SQL-LLM solutions"
source: "LangChain Blog"
url: "https://blog.langchain.com/incorporating-domain-specific-knowledge-in-sql-llm-solutions/"
date: "2023-09-05"
scraped_at: "2026-03-03T08:47:48.297551177+00:00"
language: "en-zh"
translated: true
---

_Editor's Note: This post was written in collaboration with [Manuel](https://twitter.com/manuelsoria_?ref=blog.langchain.com) and [Francisco](https://twitter.com/fpingham?ref=blog.langchain.com) from the_ [_Pampa Labs team_](https://www.pampa.ai/?ref=blog.langchain.com) _. We're always excited to see new best practices emerge for more customizing/personalizing apps more thoroughly, and this post about extending the capabilities of the standard SQL toolkit by applying innovative RAG techniques is an awesome example._

编辑者注：本文由 LangChain 博客团队与来自 [_Pampa Labs 团队_](https://www.pampa.ai/?ref=blog.langchain.com) 的 [Manuel](https://twitter.com/manuelsoria_?ref=blog.langchain.com) 和 [Francisco](https://twitter.com/fpingham?ref=blog.langchain.com) 共同撰写。我们始终乐于见证各类新最佳实践的涌现——这些实践能更深入、更全面地实现应用的定制化与个性化；而本文所介绍的、通过创新性 RAG 技术拓展标准 SQL 工具包能力的方法，正是其中极为出色的范例。

The LangChain library provides different tools to interact with SQL databases which can be used to build and run queries based on natural language inputs. For example, the standard SQL Toolkit draws from standard best practices that have been extensively covered in this [blogpost](https://blog.langchain.com/llms-and-sql/). However, there is still room for improvement when it comes to building a custom solution and adjusting the generic tools to the specific use case. The advantage of having a _plug and play_ toolkit contrasts with having a solution that is not flexible enough for the user to incorporate their domain-specific knowledge about the databases.

LangChain 库提供了多种用于与 SQL 数据库交互的工具，可基于自然语言输入构建并执行查询。例如，标准 SQL 工具包（SQL Toolkit）遵循业界广泛采用的最佳实践，相关内容已在本篇 [博客文章](https://blog.langchain.com/llms-and-sql/) 中详尽阐述。然而，在构建定制化解决方案、或将通用工具适配至特定业务场景时，仍有优化空间。即：开箱即用（_plug and play_）式工具包虽具便捷优势，但其灵活性往往不足，难以支持用户将自身关于数据库的领域知识有效融入系统。

We can extend the out-of-the-box SQL Toolkit with extra custom tools which leverage domain specific knowledge. In this way, we get the best of both worlds: anyone can run the standard SQL Agent with minimal setup while at the same time being able to incorporate extra tools that add relevant information to the prompt at inference time. In this blogpost we will cover how to expand the standard SQL Toolkit with some very useful example extra tools.

我们可通过添加额外的自定义工具来扩展开箱即用的 SQL 工具包，从而融合领域专属知识。如此一来，便能兼得二者之长：一方面，任何人都能以极小配置成本直接运行标准 SQL Agent；另一方面，亦可灵活集成额外工具，在推理（inference）阶段向提示词（prompt）注入高度相关的信息。本文将详细介绍如何借助若干极具实用价值的示例工具，拓展标准 SQL 工具包的能力。

# The Problems

# 面临的问题

Using the standard SQL Toolkit, an agent is able to construct and run queries to provide answers to user questions. Although this toolkit is robust enough for building a first out-of-the-box prototype by just connecting to a database, someone trying to use it with a complex enough database faces at least one of the following problems:

借助标准 SQL 工具包，Agent 能够构建并执行查询，从而回答用户问题。尽管该工具包已足够稳健，仅需连接数据库即可快速搭建首个开箱即用的原型系统；但若将其应用于结构足够复杂的数据库，使用者仍难免遭遇以下至少一种问题：

- Queries not generated correctly, leading to various retries until getting the right query.  
- 查询生成不准确，导致需反复重试方能得到正确 SQL 语句。

- Excessive use of the tools, making the whole thinking process very inefficient in terms of time and tokens.  
- 工具调用过于频繁，致使整个推理过程在时间与 token 消耗方面均效率低下。

- Very extensive prompts with information that is not always relevant to the specific user question.  
- 提示词内容冗长，其中包含大量与当前用户问题无关的信息。

The underlying cause behind these problems is that we are trying to build a custom solution just using generic tools, without leveraging the fact that we _do_ know the nuances of the use case. Therefore, we need to find a way of enhancing the agent with domain specific knowledge, without having to hardcode anything in the prompt template.

上述问题的根本原因在于：我们试图仅依靠通用型工具构建定制化方案，却未能充分利用一个关键前提——我们**确实掌握该业务场景的细微差别与深层逻辑**。因此，亟需探索一种方法，在不修改提示词模板、不硬编码任何内容的前提下，为 Agent 注入领域专属知识。

# Extending the SQL Toolkit

# 扩展 SQL 工具包

It has been [proven](https://arxiv.org/abs/2204.00498?ref=blog.langchain.com) that feeding the prompt with database information is crucial for constructing the right SQL query. This is why the toolkit enables the agent to get information about the table names, the schema, sample rows, etc. However, all these tools can do is retrieve information about the database, akin to how a data scientist would approach a new dataset during their initial interaction.

已有研究[证实](https://arxiv.org/abs/2204.00498?ref=blog.langchain.com)：向提示词中注入数据库相关信息，对生成正确的 SQL 查询至关重要。正因如此，该工具包支持 Agent 获取表名、数据模式（schema）、样本行等元数据信息。然而，所有这些内置工具的功能仅限于检索数据库的基础信息——这类似于数据科学家初次接触一个全新数据集时所采取的探索方式。

But what if it’s not the first interaction?  

但如果这**并非首次交互**呢？

Anyone crafting an LLM-SQL solution brings a wealth of domain-specific knowledge to the table.  
任何构建 LLM-SQL 解决方案的人，都带来了丰富的领域专业知识。

They know which questions are typically hard to translate into queries, as well as when and what supplementary information should be incorporated into the prompt.  
他们清楚哪些问题通常难以转化为 SQL 查询，也了解何时、以及应将哪些补充信息纳入提示词（prompt）中。

This becomes especially crucial in scenarios where simply using the standard toolkit falls short.  
当仅依赖标准工具包无法满足需求时，这类洞察便显得尤为关键。

Such insights can be dynamically included into the prompt using **Retrieval Augmented Generation,** which involves semantically searching in a vector database and retrieving relevant data.  
此类洞见可通过 **检索增强生成（Retrieval Augmented Generation, RAG）** 动态注入提示词——即在向量数据库中进行语义搜索，并检索出相关数据。

## Including few shot examples

## 加入少量示例（Few-shot Examples）

Feeding the prompt with _few-shot_ examples of **question-query matches** [improves the query generation accuracy.](https://arxiv.org/abs/2204.00498?ref=blog.langchain.com)  
在提示词中加入 _少量_ 的 **“问题–SQL 查询”配对示例**，可显著提升查询生成的准确性。[参见论文](https://arxiv.org/abs/2204.00498?ref=blog.langchain.com)

This can be achieved by simply appending standard static examples in the prompt to guide the agent on how it should build queries based on questions.  
一种简单做法是：在提示词末尾直接追加若干固定、标准的示例，以引导 Agent 理解如何根据自然语言问题构造 SQL 查询。

However, a more powerful approach is to have a robust dataset of good examples, and _dynamically_ include those which are relevant to the user question.  
但更强大的方法是：构建一个高质量的示例数据集，并能 _动态地_ 检索并插入与用户问题语义最相关的那些示例。

To achieve this, we need a custom Retriever Tool that handles the vector database in order to retrieve the examples that are semantically similar to the user’s question.  
为实现这一点，我们需要一个自定义的 **检索器工具（Retriever Tool）**，用于对接向量数据库，从而检索出与用户问题语义最相似的示例。

The agent can even decide whether it needs to use other tools or not.  
Agent 甚至可以自主判断是否需要调用其他工具。

Let’s see an example!  
我们来看一个实际示例！

```python
agent.run("How many employees do we have?")
> Entering new AgentExecutor chain...
Invoking: `sql_get_similar_examples` with `How many employees do we have?`
[Document(page_content='How many employees are there', metadata={'sql_query': 'SELECT COUNT(*) FROM "employee"'}), Document(page_content='Which employee has sold the most?', metadata={'sql_query': "SELECT e.FirstName || ' ' || e.LastName AS EmployeeName, SUM(i.Total) AS TotalSales\n            FROM Employee e\n            JOIN Customer c ON e.EmployeeId = c.SupportRepId\n            JOIN Invoice i ON c.CustomerId = i.CustomerId\n            GROUP BY e.EmployeeId\n            ORDER BY TotalSales DESC\n            LIMIT 1;"})]
Invoking: `sql_db_query` with `SELECT COUNT(*) FROM employee`
responded: {content}
[(8,)]We have 8 employees.
> Finished chain.
```

```python
agent.run("我们有多少名员工？")
> 进入新的 AgentExecutor 执行链...
调用工具 `sql_get_similar_examples`，输入：“我们有多少名员工？”
[Document(page_content='How many employees are there', metadata={'sql_query': 'SELECT COUNT(*) FROM "employee"'})，Document(page_content='Which employee has sold the most?', metadata={'sql_query': "SELECT e.FirstName || ' ' || e.LastName AS EmployeeName, SUM(i.Total) AS TotalSales\n            FROM Employee e\n            JOIN Customer c ON e.EmployeeId = c.SupportRepId\n            JOIN Invoice i ON c.CustomerId = i.CustomerId\n            GROUP BY e.EmployeeId\n            ORDER BY TotalSales DESC\n            LIMIT 1;"})]
调用工具 `sql_db_query`，执行 SQL："SELECT COUNT(*) FROM employee"
返回结果：{content}
[(8,)] 我们共有 8 名员工。
> 执行链结束。
```

## Finding misspellings in proper nouns

## 识别专有名词中的拼写错误

Another nice use case of applying RAG in LLM-SQL solutions is for making a system robust to misspellings.  
将 RAG 应用于 LLM-SQL 解决方案的另一项出色用例，是提升系统对拼写错误的鲁棒性。

When querying for proper nouns like names or countries, a user may inadvertently write a proper noun wrongly and the system will not be able to find it in the database (e.g. ‘Franc Sinatra’).  
当用户查询人名、国家等专有名词时，可能无意中拼错，导致系统无法在数据库中查找到对应记录（例如将 “Frank Sinatra” 错拼为 “Franc Sinatra”）。

How can we solve this problem?  
我们该如何解决这一问题？

One way to approach this problem is to create a vector store using all the distinct proper nouns that exist in the database.  
一种可行方案是：基于数据库中所有唯一的专有名词，构建一个向量库（vector store）。

We can then have the agent query that vector store each time the user includes a proper noun in their question, to find the correct spelling for that word.  
随后，每当用户提问中包含专有名词时，Agent 即可主动查询该向量库，以找出该词的正确拼写。

In this way, the agent can make sure it understands which entity the user is referring to before building the target query.  
通过这种方式，Agent 能在生成目标 SQL 查询前，准确理解用户所指的具体实体。

Let’s see an example!

让我们来看一个示例！

```python
`
sql_agent("What is 'Francis Trembling's email address?")

Invoking: `name_search` with `Francis Trembling`

[Document(page_content='François Tremblay', metadata={}), Document(page_content='Edward Francis', metadata={}), Document(page_content='Frank Ralston', metadata={}), Document(page_content='Frank Harris', metadata={}), Document(page_content='N. Frances Street', metadata={})]
Invoking: `sql_db_query_checker` with `SELECT Email FROM Customer WHERE FirstName = 'François' AND LastName = 'Tremblay' LIMIT 1`
responded: {content}

SELECT Email FROM Customer WHERE FirstName = 'François' AND LastName = 'Tremblay' LIMIT 1
Invoking: `sql_db_query` with `SELECT Email FROM Customer WHERE FirstName = 'François' AND LastName = 'Tremblay' LIMIT 1`

[('ftremblay@gmail.com',)]The email address of 'François Tremblay' is 'ftremblay@gmail.com'.

> Finished chain.

{'input': "What is 'Francis Trembling' email address?",
 'output': "The email address of 'François Tremblay' is 'ftremblay@gmail.com'."}
```

_Implementation note: when instructing the LLM to use tools in one order or another, we found it was usually more effective to instruct this in the agent’s prompt rather than in the tool’s description - for more information please refer to the SQL use case in the docs._

_实现说明：在指导大语言模型（LLM）按特定顺序使用工具时，我们发现通常将该指令写入 Agent 的提示词（prompt）中，比写入工具自身的描述中更为有效。如需了解更多，请参阅文档中的 SQL 使用案例。_

## Going further

## 更进一步

As well as these best practices improve the standard SQL Toolkit by leveraging the developer’s field-specific knowledge, there is still room for improvement in terms of accuracy and cost.

除了这些最佳实践通过利用开发者的领域专业知识来提升标准 SQL Toolkit 之外，在准确性和成本方面仍有改进空间。

Some examples on enhancing the few-shot approach include:

增强少样本（few-shot）方法的一些示例包括：

- Applying a **similarity threshold** to decide whether the retrieved examples are related enough to be included in the prompt (e.g. a new question which is very different to other questions, shouldn’t retrieve any examples).

- 应用**相似度阈值**，以判断检索到的示例是否与当前问题足够相关、值得纳入提示词中（例如：一个与历史问题差异极大的新问题，就不应检索任何示例）。

- Similarly, setting a threshold to decide if the **examples are** _**far too related**,_ and no other tools should be used, thus saving a lot of time & tokens (e.g. just adjusting a column filter, just having a related example is enough and no other tools should be necessary).

- 类似地，设定一个阈值来判断示例是否**过度相关**，从而无需调用其他工具，大幅节省时间与 token 消耗（例如：仅需调整某一列的过滤条件，此时仅提供一个高度相关的示例就已足够，无需再启用其他工具）。

- Prioritizing **diversity of the few-shot examples** in order to cover a wider area of examples, as covered in the following [paper by Hongjin Su et al](https://arxiv.org/abs/2209.01975?ref=blog.langchain.com).

- 优先保障少样本示例的**多样性**，以覆盖更广泛的问题场景，详见 Hongjin Su 等人发表的这篇[论文](https://arxiv.org/abs/2209.01975?ref=blog.langchain.com)。

Also, some examples which aren’t strictly related to the few-shot examples but do involve using RAG include:

此外，还有一些示例虽不严格属于少样本范畴，但同样涉及 RAG（检索增强生成）技术的应用，例如：

- Retrieving all values from a relevant categoric column if the user’s question involves filtering a column (e.g. a product name).

- 当用户提问涉及对某列进行筛选时（例如“产品名称”），检索该相关分类列中的全部取值。

- Adjusting sample rows to show only the columns that are relevant to the user question.

- 调整示例数据行，使其仅展示与用户问题相关的列。

If you want to help implementing any of these or have other best practices that you found helpful, don’t hesitate to join the discussion in the #sql [channel](https://discord.com/channels/1038097195422978059/1080206362669224027?ref=blog.langchain.com) in Discord!

如果您希望参与上述任一功能的实现，或有其他行之有效的最佳实践想分享，欢迎随时加入 Discord 中的 #sql [频道](https://discord.com/channels/1038097195422978059/1080206362669224027?ref=blog.langchain.com) 参与讨论！