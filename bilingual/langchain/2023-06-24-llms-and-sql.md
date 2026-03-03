---
title: "LLMs and SQL"
source: "LangChain Blog"
url: "https://blog.langchain.com/llms-and-sql/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:45:36.548643837+00:00"
language: "en-zh"
translated: true
---

[Francisco Ingham](https://twitter.com/fpingham?ref=blog.langchain.com) 和 [Jon Luo](https://twitter.com/JonZluo?ref=blog.langchain.com) 是推动 SQL 集成变革的两位社区核心成员。我们非常荣幸能与他们共同撰写这篇博客，全面分享他们在实践中积累的各类技巧与经验。更令人振奋的是，我们还将与他们联合举办一场时长一小时的线上研讨会，深入探讨这些实践经验，并现场解答其他相关问题。本次研讨会定于 3 月 22 日举行——请通过下方链接报名参加：

- [线上研讨会报名链接](https://www.crowdcast.io/c/fgxa65bugxk4?ref=blog.langchain.com)

LangChain 库提供了多种 SQL 链（SQL chains），甚至还有一个专为简化 SQL 数据交互而设计的 SQL Agent。以下是一些相关资源链接：

- [Python 版 SQL 链](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com)  
- [Python 版 SQL Agent](https://python.langchain.com/docs/modules/agents/toolkits/sql_database?ref=blog.langchain.com)  
- [JavaScript 版 SQL 链](https://hwchase17.github.io/langchainjs/docs/modules/chains/sql_db?ref=blog.langchain.com)  
- [JavaScript 版 SQL Agent](https://hwchase17.github.io/langchainjs/docs/modules/agents/agent_toolkits/sql?ref=blog.langchain.com)  

## 引言

Introduction

企业中大部分数据传统上都存储在 SQL 数据库中。鉴于其中所蕴含的巨大商业价值，能够便捷查询并深入理解这些数据的商业智能（BI）工具日益流行。但试想：如果可以直接使用自然语言与 SQL 数据库交互，会怎样？借助当今的大语言模型（LLM），这已成为现实。LLM 对 SQL 具备一定理解能力，也能生成质量相当不错的 SQL 语句。然而，要真正实现可靠、可用的自然语言到 SQL 的转换，仍面临若干关键挑战。

## 存在的问题

The Problems

既然 LLM 能够生成 SQL，那还缺些什么呢？

遗憾的是，缺的还不少。

首要问题在于“幻觉”（hallucination）。尽管 LLM 可以编写 SQL，但它常常会虚构数据库中并不存在的表名或字段名，甚至生成在目标数据库上根本无法执行或运行出错的 SQL 语句。因此，我们面临的一大核心挑战，是如何将 LLM “锚定”于真实数据库结构之上，确保其输出的 SQL 语句切实有效、语法正确且语义准确。

The main idea to fix this (we will go into more detail below) is to provide the LLM with knowledge about what actually exists in the database and tell it to write a SQL query consistent with that. However, this runs into a second issue — the context window length. LLMs have some context window which limits the amount of text they can operate over. This is relevant because SQL databases often contain a lot of information. So if we were to naively pass in all the data to ground the LLM in reality, we would likely run into this issue.

解决这一问题的核心思路（下文将详细展开）是：向大语言模型（LLM）提供数据库中真实存在的结构与内容知识，并引导其生成与之严格一致的 SQL 查询。然而，这又引出了第二个问题——上下文窗口长度限制。LLMs 具有固定的上下文窗口容量，即其单次处理的文本长度存在上限。这一点尤为关键，因为 SQL 数据库通常包含大量表、字段、约束及示例数据。若我们简单粗暴地将全部数据库信息一次性输入给 LLM 以实现“现实对齐”，极有可能超出其上下文窗口限制。

A third issue is a more basic one: sometimes the LLM just messes up. The SQL it writes may be incorrect for whatever reason, or it could be correct but just return an unexpected result. What do we do then? Do we give up?

第三个问题则更为基础：有时 LLM 就是会出错。它生成的 SQL 可能因各种原因存在语法或逻辑错误；也可能语法完全正确，却返回了意料之外的结果。此时我们该怎么办？就此放弃吗？

## The (High Level) Solutions

## （高层）解决方案

When thinking about how to tackle these issues, it’s informative to think about how we as humans tackle these issues. If we can then replicate the steps that we would take to solve those problems, we can help the LLM do so as well. So let’s think about what a data analyst would do if they were asked to answer a BI question.

在思考如何应对上述问题时，一个富有启发性的角度是：回顾人类自身是如何解决同类问题的。如果我们能复现人类解决问题时所采取的关键步骤，便有望引导 LLM 同样高效地完成任务。因此，让我们设想一位数据分析师在被要求回答某个商业智能（BI）问题时，通常会怎么做。

When data analysts query SQL databases, there’s a few things they normally do that help them make the right queries. For example, they usually make a sample query beforehand to understand what the data looks like. They can look at the schema of the tables, or even certain rows. This can be thought of as the data analyst learning what the data looks like so that when they write a SQL query in the future it is grounded in what actually exists. Data analysts also don’t usually just look at all the data (or thousands of rows) at the same time — they may limit any exploratory queries to the top K rows, or look at summary stats instead. This can yield some hints at how to get around the context window limitations. And finally, if a data analyst hits an error, they don’t just give up — they learn from the error and write a new query.

当数据分析师查询 SQL 数据库时，通常会执行若干关键操作来确保写出正确的查询语句。例如，他们往往先执行一条样本查询，以快速了解数据的形态与分布；他们会查阅表的结构定义（schema），甚至浏览若干具体行的数据。这本质上是一种“数据探查”过程——通过观察真实数据，为后续编写 SQL 查询建立坚实的事实基础。此外，数据分析师通常不会一次性查看全部数据（比如成千上万行），而是将探索性查询限制在前 K 行，或转而分析汇总统计指标（summary statistics）。这种做法恰恰为我们规避上下文窗口限制提供了重要启示。最后，当数据分析师遇到查询错误时，他们绝不会轻易放弃；相反，他们会分析报错信息，从中学习，并据此修正并重写查询语句。

We discuss each of these solutions in a separate section below.

下文各小节将分别深入探讨上述每一项解决方案。

## Describing your database

## 描述你的数据库

To provide the LLM with enough information for it to generate reasonable queries for a given database, we need to effectively describe the database in the prompt. This can include describing table structure, examples of what the data looks like, and even examples of good queries for the database. The examples below come from the Chinook database.

为了让 LLM 能够为特定数据库生成合理、可靠的 SQL 查询，我们必须在提示词（prompt）中对其做出清晰、有效的描述。这包括：表结构定义、典型数据样例，甚至针对该数据库的优质查询范例。以下示例均来自 Chinook 示例数据库。

### Describing the schema

### 描述数据库结构（Schema）

In older versions of LangChain, we simply provided the table names, columns, and their types:

在 LangChain 的早期版本中，我们仅提供表名、各列名称及其数据类型：

```sql
Table 'Track' has columns: TrackId (INTEGER), Name (NVARCHAR(200)), AlbumId (INTEGER), MediaTypeId (INTEGER), GenreId (INTEGER), Composer (NVARCHAR(220)), Milliseconds (INTEGER), Bytes (INTEGER), UnitPrice (NUMERIC(10, 2))
```

`Track` 表包含以下列：TrackId（INTEGER）、Name（NVARCHAR(200)）、AlbumId（INTEGER）、MediaTypeId（INTEGER）、GenreId（INTEGER）、Composer（NVARCHAR(220)）、Milliseconds（INTEGER）、Bytes（INTEGER）、UnitPrice（NUMERIC(10, 2)）

[Rajkumar et al](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2204.xml?ref=blog.langchain.com) 对 OpenAI Codex 的 Text-to-SQL 性能开展了一项研究，评估了多种不同提示结构下的表现。他们发现，当使用包含列名、数据类型、列引用及主外键约束的 `CREATE TABLE` 语句作为提示时，Codex 表现最佳。对于 `Track` 表，该提示形式如下：

```sql
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"AlbumId" INTEGER,
"MediaTypeId" INTEGER NOT NULL,
"GenreId" INTEGER,
"Composer" NVARCHAR(220),
"Milliseconds" INTEGER NOT NULL,
"Bytes" INTEGER,
"UnitPrice" NUMERIC(10, 2) NOT NULL,
PRIMARY KEY ("TrackId"),
FOREIGN KEY("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId"),
FOREIGN KEY("GenreId") REFERENCES "Genre" ("GenreId"),
FOREIGN KEY("AlbumId") REFERENCES "Album" ("AlbumId")
)
```

```sql
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"AlbumId" INTEGER,
"MediaTypeId" INTEGER NOT NULL,
"GenreId" INTEGER,
"Composer" NVARCHAR(220),
"Milliseconds" INTEGER NOT NULL,
"Bytes" INTEGER,
"UnitPrice" NUMERIC(10, 2) NOT NULL,
PRIMARY KEY ("TrackId"),
FOREIGN KEY("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId"),
FOREIGN KEY("GenreId") REFERENCES "Genre" ("GenreId"),
FOREIGN KEY("AlbumId") REFERENCES "Album" ("AlbumId")
)
```

### Describing the data  
### 描述数据

We can further improve the LLM’s ability to create optimal queries by additionally providing examples of [what the data looks like](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com#adding-example-rows-from-each-table). For example, if we are searching for composers in the `Track` table, it will be quite useful to know if the `Composer` column consists of full names, abbreviated names, both, or perhaps even other representation. [Rajkumar et al](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2204.xml?ref=blog.langchain.com) found that providing example rows in a `SELECT` statement following the `CREATE TABLE` description resulted in consistent performance improvements. Interestingly, they found that providing 3 rows was optimal, and that providing more database content can even decrease performance.

我们可通过额外提供[数据实际样例](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com#adding-example-rows-from-each-table)，进一步提升大语言模型（LLM）生成最优 SQL 查询的能力。例如，在 `Track` 表中搜索作曲家时，若能了解 `Composer` 列中存储的是全名、缩写、两者兼有，抑或其它形式（如多人名以逗号分隔），将极为有用。[Rajkumar 等人](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2204.xml?ref=blog.langchain.com) 发现，在 `CREATE TABLE` 定义之后附加一条带示例行的 `SELECT` 语句，可带来持续稳定的性能提升。有趣的是，他们发现提供 **3 行示例**效果最佳；而提供过多数据库内容反而可能降低模型性能。

We’ve adopted the best practice findings from their paper as the default settings. Together, our database description in the prompt looks like this:

我们已将该论文中的最佳实践成果采纳为默认配置。综上，我们在提示词（prompt）中使用的数据库描述如下所示：

```python
db = SQLDatabase.from_uri(
	"sqlite:///../../../../notebooks/Chinook.db",
	include_tables=['Track'], # including only one table for illustration
	sample_rows_in_table_info=3
)
print(db.table_info)
```

```python
db = SQLDatabase.from_uri(
	"sqlite:///../../../../notebooks/Chinook.db",
	include_tables=['Track'], # 仅包含一个表用于演示
	sample_rows_in_table_info=3
)
print(db.table_info)
```

Which outputs:  
输出结果如下：

```
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"AlbumId" INTEGER,
"MediaTypeId" INTEGER NOT NULL,
"GenreId" INTEGER,
"Composer" NVARCHAR(220),
"Milliseconds" INTEGER NOT NULL,
"Bytes" INTEGER,
"UnitPrice" NUMERIC(10, 2) NOT NULL,
PRIMARY KEY ("TrackId"),
FOREIGN KEY("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId"),
FOREIGN KEY("GenreId") REFERENCES "Genre" ("GenreId"),
FOREIGN KEY("AlbumId") REFERENCES "Album" ("AlbumId")
)
SELECT * FROM 'Track' LIMIT 3;
TrackId	Name	AlbumId	MediaTypeId	GenreId	Composer	Milliseconds	Bytes	UnitPrice
1	For Those About To Rock (We Salute You)	1	1	1	Angus Young, Malcolm Young, Brian Johnson	343719	11170334	0.99
2	Balls to the Wall	2	2	1	None	342562	5510424	0.99
3	Fast As a Shark	3	2	1	F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman	230619	3990994	0.99
```

```
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"AlbumId" INTEGER,
"MediaTypeId" INTEGER NOT NULL,
"GenreId" INTEGER,
"Composer" NVARCHAR(220),
"Milliseconds" INTEGER NOT NULL,
"Bytes" INTEGER,
"UnitPrice" NUMERIC(10, 2) NOT NULL,
PRIMARY KEY ("TrackId"),
FOREIGN KEY("MediaTypeId") REFERENCES "MediaType" ("MediaTypeId"),
FOREIGN KEY("GenreId") REFERENCES "Genre" ("GenreId"),
FOREIGN KEY("AlbumId") REFERENCES "Album" ("AlbumId")
)
SELECT * FROM 'Track' LIMIT 3;
TrackId	Name	AlbumId	MediaTypeId	GenreId	Composer	Milliseconds	Bytes	UnitPrice
1	For Those About To Rock (We Salute You)	1	1	1	Angus Young, Malcolm Young, Brian Johnson	343719	11170334	0.99
2	Balls to the Wall	2	2	1	None	342562	5510424	0.99
3	Fast As a Shark	3	2	1	F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman	230619	3990994	0.99
```

### Using custom table information  
### 使用自定义表信息

Although LangChain conveniently assembles the schema and sample row descriptions automatically, there are a few cases in which it is preferable to override the automatic info with hand-crafted descriptions.  

尽管 LangChain 能够方便地自动组装表结构（schema）和示例行描述，但在某些情况下，手动编写描述比依赖自动生成的信息更为合适。

For example, if you know that the first few rows of a table are uninformative, it is best to manually provide example rows that provide the LLM with more information.  

例如，如果你知道某张表的前几行数据缺乏代表性或信息量不足，那么最好手动提供更具信息量的示例行，以帮助大语言模型（LLM）更好地理解数据语义。

As an example, in the \`Track\` table, sometimes multiple composers are separated by slashes instead of commas. This first appears in row 111 of the table, well beyond our limit of 3 rows. We can provide this custom information such that the example rows contain this new information. [Here’s](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com#adding-example-rows-from-each-table) an example of doing this in practice.

以 `Track` 表为例：其中作曲家（Composer）字段有时使用斜杠（`/`）而非逗号（`,`）分隔多位作曲家。该情况首次出现在第 111 行，远超我们默认仅取前 3 行作为示例的限制。此时，我们可以自定义示例行，将这一关键格式特征显式纳入其中。[此处](https://python.langchain.com/docs/modules/chains/popular/sqlite?ref=blog.langchain.com#adding-example-rows-from-each-table) 提供了实际操作的示例。

It is also possible to use a custom description to limit the columns of a table that are visible to the LLM. An example of these two uses applied to the `Track` table might look like:

我们还可以通过自定义描述来限制向 LLM 暴露的列范围。以下即为将上述两种用法（自定义示例行 + 列裁剪）同时应用于 `Track` 表的一个示例：

```
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"Composer" NVARCHAR(220),
PRIMARY KEY ("TrackId"),
)
SELECT * FROM 'Track' LIMIT 4;
TrackId	Name	Composer
1	For Those About To Rock (We Salute You)	Angus Young, Malcolm Young, Brian Johnson
2	Balls to the Wall	None
3	Fast As a Shark	F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman
4	Money	Berry Gordy, Jr./Janie Bradford
```

```
CREATE TABLE "Track" (
"TrackId" INTEGER NOT NULL,
"Name" NVARCHAR(200) NOT NULL,
"Composer" NVARCHAR(220),
PRIMARY KEY ("TrackId"),
)
SELECT * FROM 'Track' LIMIT 4;
TrackId	Name	Composer
1	For Those About To Rock (We Salute You)	Angus Young, Malcolm Young, Brian Johnson
2	Balls to the Wall	None
3	Fast As a Shark	F. Baltes, S. Kaufman, U. Dirkscneider & W. Hoffman
4	Money	Berry Gordy, Jr./Janie Bradford
```

If you have sensitive data that you do not wish to send to an API, you can use this feature to provide mock data instead of your actual database.

如果你的数据中包含敏感信息，不希望将其发送至外部 API，可利用此功能提供模拟数据（mock data），替代真实数据库内容。

## Constraining the size of the output

## 限制输出结果的大小

When we make queries with LLMs within a chain or agent, the result from our query will be used as the input for another LLM. If the query result is too big this will max out our model’s input size. So it is usually a good practice to sensibly limit the size of the output of our query. We can do this by instructing our LLM to use as few columns as possible and limit the number of returned rows.

当我们在链（chain）或智能体（agent）中调用 LLM 执行 SQL 查询时，查询结果将作为后续 LLM 调用的输入。若查询返回结果过大，极易超出模型的最大输入长度限制。因此，合理控制查询输出规模是一项良好实践。具体方法包括：指导 LLM 尽量减少所选列数，并严格限制返回行数。

As we can in the following example, if we ask for the list of total sales per country without specifying a number of countries, the query will be capped to 10. You can manage this limit with the `top_k` parameter.

如以下示例所示：当我们仅要求“按国家统计总销售额”，而未明确指定国家数量时，系统会自动将结果限制为最多 10 条。该上限可通过 `top_k` 参数进行配置。

```
agent_executor.run("List the total sales per country. Which country's customers spent the most?")
```

```
agent_executor.run("列出各国总销售额。哪个国家的客户消费最多？")
```

>>

>>

```
…
Action Input: SELECT c.Country, SUM(i.Total) AS TotalSales FROM Invoice i INNER JOIN Customer c ON i.CustomerId = c.CustomerId GROUP BY c.Country ORDER BY TotalSales DESC LIMIT 10
Observation: [('USA', 523.0600000000003), ('Canada', 303.9599999999999), ('France', 195.09999999999994), ('Brazil', 190.09999999999997), ('Germany', 156.48), ('United Kingdom', 112.85999999999999), ('Czech Republic', 90.24000000000001), ('Portugal', 77.23999999999998), ('India', 75.25999999999999), ('Chile', 46.62)]
…
```

```
…
操作输入：SELECT c.Country, SUM(i.Total) AS TotalSales FROM Invoice i INNER JOIN Customer c ON i.CustomerId = c.CustomerId GROUP BY c.Country ORDER BY TotalSales DESC LIMIT 10  
观测结果：[('美国', 523.0600000000003), ('加拿大', 303.9599999999999), ('法国', 195.09999999999994), ('巴西', 190.09999999999997), ('德国', 156.48), ('英国', 112.85999999999999), ('捷克共和国', 90.24000000000001), ('葡萄牙', 77.23999999999998), ('印度', 75.25999999999999), ('智利', 46.62)]
…
```

### Checking syntax

### 检查语法

If our LLM generated query is syntactically broken we will find that we will get a traceback when running our chain or agent. This is highly problematic if we want to use this for productive purposes. How could we help the LLM correct the query? We can replicate exactly what we would have done if we had made the mistake ourselves. We send the original query with the traceback log to the LLM and ask it to make it right, by understanding exactly what went wrong. This concept is inspired by [this blogpost](https://www.patterns.app/blog/2023/01/18/crunchbot-sql-analyst-gpt/?ref=blog.langchain.com) where you can find a more detailed explanation.

如果由我们的大语言模型（LLM）生成的 SQL 查询在语法上存在错误，那么在运行链（chain）或智能体（agent）时，我们将收到一个回溯错误（traceback）。若希望将该系统用于实际生产环境，此类错误将带来严重问题。那么，我们该如何协助 LLM 修正该查询？我们可以完全复现人类自身犯错时所采取的纠错方式：将原始查询连同报错的回溯日志一并发送给 LLM，并要求它基于对错误根源的准确理解，修正该查询。这一思路源自 [这篇博客文章](https://www.patterns.app/blog/2023/01/18/crunchbot-sql-analyst-gpt/?ref=blog.langchain.com)，文中提供了更详尽的阐释。

In the following example from the docs, you can see that the model was trying to query for an unexisting column and when it finds the query is wrong it promptly corrects it with the `query_checker_sql_db` tool:

在以下来自官方文档的示例中，您可以看到：模型试图查询一个并不存在的列；当它识别出查询有误时，便立即调用 `query_checker_sql_db` 工具进行修正：

_Observation: Error: (sqlite3.OperationalError) no such column: Track.ArtistId_

_\[SQL: SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Track ON Artist.ArtistId = Track.ArtistId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3\]_

_(Background on this error at: [https://sqlalche.me/e/14/e3q8](https://sqlalche.me/e/14/e3q8?ref=blog.langchain.com))_

**Thought:** I should double check my query before executing it.

**Action:** query\_checker\_sql\_db

**Action Input:** _SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Track ON Artist.ArtistId = Track.ArtistId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3_

**Observation:**  
_观察结果：错误：(sqlite3.OperationalError) 无此列：Track.ArtistId_

_\[SQL：SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Track ON Artist.ArtistId = Track.ArtistId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3\]_

_(该错误的详细背景说明参见：[https://sqlalche.me/e/14/e3q8](https://sqlalche.me/e/14/e3q8?ref=blog.langchain.com))_

**思考：** 我应在执行前再次核查我的查询语句。

**动作：** query\_checker\_sql\_db

**动作输入：** _SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Track ON Artist.ArtistId = Track.ArtistId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3_

**观察结果：**

`SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity`  
`SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS 总数量`

`FROM Artist`  
`FROM Artist（艺术家表）`

`INNER JOIN Track ON Artist.ArtistId = Track.ArtistId`  
`INNER JOIN Track（音轨表） ON Artist.ArtistId = Track.ArtistId`

`INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId`  
`INNER JOIN InvoiceLine（发票明细表） ON Track.TrackId = InvoiceLine.TrackId`

`GROUP BY Artist.Name`  
`GROUP BY Artist.Name（按艺术家姓名分组）`

`ORDER BY TotalQuantity DESC`  
`ORDER BY TotalQuantity DESC（按总数量降序排列）`

`LIMIT 3;`  
`LIMIT 3;（仅返回前3条记录）`

**Thought:** I now know the final answer.  
**思考：** 我现在已经知道最终答案。

**Action:** query_sql_db  
**操作：** query_sql_db

**Action Input:** `SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Album ON Artist.ArtistId = Album.ArtistId INNER JOIN Track ON Album.AlbumId = Track.AlbumId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3`  
**操作输入：** `SELECT Artist.Name, SUM(InvoiceLine.Quantity) AS TotalQuantity FROM Artist INNER JOIN Album ON Artist.ArtistId = Album.ArtistId INNER JOIN Track ON Album.AlbumId = Track.AlbumId INNER JOIN InvoiceLine ON Track.TrackId = InvoiceLine.TrackId GROUP BY Artist.Name ORDER BY TotalQuantity DESC LIMIT 3`

## Future work

## 未来工作

As you know, the field is moving fast and we are collectively finding out the best ways for achieving optimal LLM-SQL interaction. Here is the backlog going forward:

众所周知，该领域发展迅速，我们正共同探索实现大语言模型（LLM）与 SQL 最优交互的最佳实践。以下是后续待办事项清单：

#### Few-shot examples

#### 少样本示例

[Rajkumar et al](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2204.xml?ref=blog.langchain.com) also found that Codex’s SQL generation accuracy improved in benchmarks with few-shot learning, where question-query examples are appended to the prompt (see Figure 2).

[Rajkumar 等人](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/files/abs/2204.xml?ref=blog.langchain.com) 的研究也发现，在基准测试中，通过少样本学习（few-shot learning）——即在提示词（prompt）末尾附加若干“自然语言问题–SQL 查询”示例——可显著提升 Codex 的 SQL 生成准确率（参见图 2）。

#### Use subqueries

#### 使用子查询

Some users have found that telling the agent to break down the problem into multiple subqueries, including comments on what each subquery does, helps the agent get to the correct answer. Thinking in subqueries forces the agent to think in logical steps and thus reduces the probability of making structural mistakes in the query. This is analogous to adding CoT type phrases to the prompt like ‘think this problem step by step” for non-sql problems.

部分用户发现，指示智能体将问题拆解为多个子查询，并为每个子查询添加注释说明其功能，有助于智能体得出正确答案。以子查询方式进行思考，能迫使智能体按逻辑步骤推理，从而降低 SQL 查询结构出错的概率。这一策略类似于在非 SQL 类任务的提示词中加入思维链（Chain-of-Thought, CoT）类短语，例如“请逐步思考该问题”。

If you want to help implementing any of these or have other best practices that you found helpful, please do share your thoughts in the discussion in the #sql channel in [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) or directly take a stab at a PR!

如果您希望参与上述任一方向的实现，或有其他行之有效的实践经验，欢迎在 [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) 的 `#sql` 频道讨论区分享您的想法，或直接提交 Pull Request（PR）！

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/llms-and-sql/img_001.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/llms-and-sql/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/llms-and-sql/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/llms-and-sql/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/llms-and-sql/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](images/llms-and-sql/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/llms-and-sql/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口端点**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)