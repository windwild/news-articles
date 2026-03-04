---
render_with_liquid: false
title: "Building a Data Visualization Agent with LangGraph Cloud"
source: "LangChain Blog"
url: "https://blog.langchain.com/data-viz-agent/"
date: "2024-09-12"
scraped_at: "2026-03-03T07:53:31.725076337+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: This is a guest blog post by** [**Dhruv Ateja**](https://www.linkedin.com/in/dhruv-atreja/?ref=blog.langchain.com) **. It covers building a full stack application that uses an agent to both query data as well as choose how to display that data. It leverages LangGraph and LangGraph Cloud.**

**编者按：本文为嘉宾博客文章，作者为** [**Dhruv Ateja**](https://www.linkedin.com/in/dhruv-atreja/?ref=blog.langchain.com) **。文章介绍了如何构建一个全栈应用，该应用使用智能体（agent）不仅查询数据，还能自主决定数据的可视化呈现方式。项目基于 LangGraph 和 LangGraph Cloud 构建。**

**Key Links:**

**关键链接：**

- [**YouTube Video**](https://youtu.be/LRcjlXL9hPA?ref=blog.langchain.com)
- [**YouTube 视频**](https://youtu.be/LRcjlXL9hPA?ref=blog.langchain.com)

- [**GitHub Repo**](https://github.com/DhruvAtreja/datavisualization_langgraph?ref=blog.langchain.com)
- [**GitHub 代码仓库**](https://github.com/DhruvAtreja/datavisualization_langgraph?ref=blog.langchain.com)

- [**Hosted Application**](https://data-visualization-frontend-gamma.vercel.app/?ref=blog.langchain.com)
- [**已部署的应用**](https://data-visualization-frontend-gamma.vercel.app/?ref=blog.langchain.com)

Let's explore an exciting project that leverages LangGraph Cloud's streaming API to create a data visualization agent. You can upload an SQLite database or CSV file, ask questions about your data, and the agent will generate appropriate visualizations. This blog is a brief dive into the agent’s workflow and key features.

让我们探索一个激动人心的项目：它利用 LangGraph Cloud 的流式 API 构建了一个数据可视化智能体（data visualization agent）。你可以上传 SQLite 数据库或 CSV 文件，就你的数据提出问题，智能体将自动生成恰当的可视化图表。本文将简要介绍该智能体的工作流程与核心功能。

/0:28

/0:28

1×

1×

The entire workflow is orchestrated using **LangGraph Cloud**, which provides a framework for easily building complex AI agents, a streaming API for real-time updates, and a visual studio for monitoring and experimenting with the agent's behavior.

整个工作流由 **LangGraph Cloud** 统一编排。LangGraph Cloud 提供了一套框架，便于快速构建复杂的 AI 智能体；其流式 API 支持实时更新；配套的可视化 Studio 则可用于监控智能体行为并开展实验性调试。

First, let us see the current SOTA text to sql workflow:

首先，我们来看当前最先进的“文本到 SQL”（text-to-SQL）工作流：

### **Schema and Metadata Extraction:**

### **模式与元数据提取：**

- The system processes the provided database (e.g., SQLite or CSV) to extract crucial information like table structure and column details.  
- 系统对用户提供的数据库（例如 SQLite 或 CSV）进行解析，提取关键信息，如表结构、字段详情等。

- This initial step grants a comprehensive understanding of the database's organization.  
- 这一初始步骤使系统能够全面理解数据库的组织结构。

### **Embedding Creation:**

### **嵌入生成：**

- For larger datasets, embeddings for schema elements (tables, columns) and sample data are generated. These embeddings improve efficiency during retrieval and matching tasks later on.

- 对于大规模数据集，将为模式元素（表、列）及样本数据生成嵌入向量。这些嵌入向量可显著提升后续检索与匹配任务的执行效率。

### **Entity and Context Retrieval:**

### **实体与上下文检索：**

- The user's query is analyzed to identify entities and the overall context.

- 对用户查询进行分析，以识别其中的实体及整体语义上下文。

- For database values, a syntactic search leveraging a Locality Sensitive Hashing (LSH) index can be implemented.

- 针对数据库中的具体取值，可采用基于局部敏感哈希（Locality Sensitive Hashing, LSH）索引的语法层面搜索。

### **Relevant Table Extraction using Retrieval-Augmented Generation (RAG):**

### **基于检索增强生成（RAG）的相关表提取：**

- This step utilizes RAG to pinpoint the relevant tables that hold the information the user seeks.

- 本步骤利用检索增强生成（RAG）技术，精准定位包含用户所需信息的相关数据表。

- **Experimental Approaches:**

- **实验性方法：**

  - If the schema is manageable within the context window, this step might be skipped.

  - 若模式结构可在大语言模型的上下文窗口内完整容纳，则此步骤可被跳过。

  - Exploring a Knowledge Graph-based RAG for multi-hop functionalities is a potential avenue for future development.

  - 探索基于知识图谱的 RAG 方法以支持多跳推理功能，是未来开发的潜在方向。

  - Extracting relevant columns can be fed into the RAG for more precise table extraction.

  - 提取相关列并将其输入 RAG 模块，有助于实现更精确的表级检索。

### **Large Schema Handling :**

### **大规模模式处理：**

- When dealing with massive table schemas, techniques can be employed to manage them effectively:

- 在处理海量数据表模式时，可采用以下技术实现高效管理：

  - Reducing schema details to essential information ensures efficient processing.

  - 将模式细节精简为关键信息，以保障处理效率。

  - Pruning columns based on metadata tags streamlines the analysis.

  - 基于元数据标签对列进行剪枝，可显著简化分析流程。

  - The pruned schema can then be presented to the Language Model (LLM) to assess table relevance.

  - 剪枝后的模式可提交给大语言模型（LLM），用于评估各表的相关性。

### **Table and Relevance Validation:**

### **表与相关性验证：**

- The extracted tables are meticulously verified to ensure they are truly relevant to the user's query.

- 对已提取的数据表进行细致验证，确保其确实与用户的查询意图高度相关。

### **SQL Query Generation:**

### **SQL 查询生成：**

- The relevant tables, their schema, and sample data rows are fed into the LLM to generate the SQL query.  
- 将相关数据表、其表结构（schema）以及部分示例数据行输入大语言模型（LLM），以生成对应的 SQL 查询。

- **Experimentation:** Prompting the LLM to evaluate the necessity of each column in filtered tables, coupled with a chain-of-thought explanation, can provide valuable insights into the reasoning behind the generated query.  
- **实验探索：** 引导 LLM 评估过滤后表格中每一列的必要性，并辅以思维链（chain-of-thought）式解释，有助于深入理解所生成查询背后的推理逻辑。

### **Query Structure Validation:**

### **查询结构验证：**

- A workflow validates and corrects the generated SQL query's structure, ensuring its correctness before execution.  
- 一个工作流负责验证并修正所生成 SQL 查询的结构，确保其在执行前语法正确、逻辑合理。

For our project, we've focused on smaller datasets, eliminating the need for RAG or LSH techniques. However, the core workflow remains consistent. To explore text-to-SQL implementations for larger datasets, check out [this insightful article](https://medium.com/pinterest-engineering/how-we-built-text-to-sql-at-pinterest-30bad30dabff/?ref=blog.langchain.com) from Pinterest Engineering.  
在本项目中，我们聚焦于小规模数据集，因此无需引入 RAG（检索增强生成）或 LSH（局部敏感哈希）等技术。但核心工作流的设计保持一致。如需了解面向大规模数据集的 text-to-SQL 实现方案，推荐阅读 Pinterest 工程团队撰写的这篇[深度技术文章](https://medium.com/pinterest-engineering/how-we-built-text-to-sql-at-pinterest-30bad30dabff/?ref=blog.langchain.com)。

Here are is an overview of the implementation of the text to sql workflow:  
以下是 text-to-SQL 工作流实现的整体架构概览：

![](images/building-a-data-visualization-agent-with-langgraph-cloud/img_001.png)

### Setting up the graph  

### 构建图工作流

```python

    def create_workflow(self) -> StateGraph:
        """Create and configure the workflow graph."""
        workflow = StateGraph(State)
        # Add nodes to the graph
        workflow.add_node("parse_question", self.sql_agent.parse_question)
        workflow.add_node("get_unique_nouns", self.sql_agent.get_unique_nouns)
        workflow.add_node("generate_sql", self.sql_agent.generate_sql)
        workflow.add_node("validate_and_fix_sql", self.sql_agent.validate_and_fix_sql)
        workflow.add_node("execute_sql", self.sql_agent.execute_sql)
        workflow.add_node("format_results", self.sql_agent.format_results)
        workflow.add_node("choose_visualization", self.sql_agent.choose_visualization)
        workflow.add_node("format_data_for_visualization", self.data_formatter.format_data_for_visualization)
        # Define edges
        workflow.add_edge("parse_question", "get_unique_nouns")
        workflow.add_edge("get_unique_nouns", "generate_sql")
        workflow.add_edge("generate_sql", "validate_and_fix_sql")
        workflow.add_edge("validate_and_fix_sql", "execute_sql")
        workflow.add_edge("execute_sql", "format_results")
        workflow.add_edge("execute_sql", "choose_visualization")
        workflow.add_edge("choose_visualization", "format_data_for_visualization")
        workflow.set_entry_point("parse_question")
```

```

### **1. Schema and Metadata Extraction:**

### **1. 模式与元数据提取：**

- 我们为本项目开发了一个用于存储和查询 SQLite 文件的服务器：[https://github.com/DhruvAtreja/sqllite-server](https://github.com/DhruvAtreja/sqllite-server?ref=blog.langchain.com)
- 该服务器具备两大核心功能：数据库查询与模式（schema）获取。
- 我们提取所有数据表的模式信息，并为每张表额外获取前 3 行数据，以提供上下文。

Extracting schema  
提取模式

```jsx

  const db = new sqlite3.Database(dbPath);

  db.all(
    "SELECT name, sql FROM sqlite_master WHERE type='table';",
    [],
    (err, tables) => {
      if (err) {
        db.close();
        return res.status(500).json({ error: err.message });
      }

      const schema = [];

      const processTable = (index) => {
        if (index >= tables.length) {
          db.close();
          return res.json({ schema: schema.join("\\n") });
        }
```

```javascript
        const { name: tableName, sql: createStatement } = tables[index];
        schema.push(`Table: ${tableName}`);
        schema.push(`CREATE statement: ${createStatement}\\n`);

        db.all(`SELECT * FROM '${tableName}' LIMIT 3;`, [], (err, rows) => {
          if (err) {
            console.error(`Error fetching rows for table ${tableName}:`, err);
          } else if (rows.length > 0) {
            schema.push("Example rows:");
            rows.forEach((row) => schema.push(JSON.stringify(row)));
          }
          schema.push(""); // Add a blank line between tables
          processTable(index + 1);
        });
      };

      processTable(0);
    }
  );
```

```javascript
        const { name: tableName, sql: createStatement } = tables[index];
        schema.push(`表：${tableName}`);
        schema.push(`CREATE 语句：${createStatement}\\n`);

        db.all(`SELECT * FROM '${tableName}' LIMIT 3;`, [], (err, rows) => {
          if (err) {
            console.error(`获取表 ${tableName} 的行数据时出错：`, err);
          } else if (rows.length > 0) {
            schema.push("示例行：");
            rows.forEach((row) => schema.push(JSON.stringify(row)));
          }
          schema.push(""); // 表与表之间添加空行
          processTable(index + 1);
        });
      };

      processTable(0);
    }
  );
```

### **2\. 解析用户问题：**

### **2. 解析用户问题：**

- We pass the user's question to the SQLAgent along with the schema of the database. Using this data we extract the relevant tables and columns.  
- 我们将用户问题连同数据库 schema 一并传给 SQLAgent；利用这些数据，我们提取出相关联的表和列。

- We also identify columns which contain nouns. We'll see why this is important in the next step.  
- 我们还会识别出包含名词（nouns）的列。下一步将说明这一识别为何至关重要。

- If the question is not relevant to the database or if there is not enough information to answer the question, we set `is_relevant` to `false` and end the workflow.  
- 若该问题与数据库无关，或信息不足以作答，我们将 `is_relevant` 设为 `false`，并终止工作流。

Prompt:

提示词（Prompt）：

```python
You are a data analyst that can help summarize SQL tables and parse user questions about a database.
Given the question and database schema, identify the relevant tables and columns.
If the question is not relevant to the database or if there is not enough information to answer the question, set is_relevant to false.

The "noun_columns" field should contain only the columns that are relevant to the question and contain nouns or names, for example, the column "Artist name" contains nouns relevant to the question "What are the top selling artists?", but the column "Artist ID" is not relevant because it does not contain a noun. Do not include columns that contain numbers.
```

```python
你是一名数据分析师，能够协助汇总 SQL 表结构，并解析用户关于数据库的问题。
请根据用户问题及数据库 schema，识别出相关的表和列。
若该问题与数据库无关，或信息不足以作答，请将 `is_relevant` 设为 `false`。

字段 `"noun_columns"` 应仅包含与问题相关、且内容为名词或名称的列。例如，在问题“销量最高的艺术家有哪些？”中，列 `"Artist name"` 包含与问题相关的名词；而 `"Artist ID"` 则不相关，因其内容并非名词。请勿包含内容为数字的列。
```

Response Format:

响应格式：

```json
{

```json
"is_relevant": boolean,

"relevant_tables": [\
\
		{{\
\
		"table_name": string,\
\
		"columns": [string],\
\
		"noun_columns": [string]\
\
		}}\
\
	]

}
```

```json
“is_relevant”：布尔值，

“relevant_tables”：[\
\
		{{\
\
		“table_name”：字符串，\
\
		“columns”：[字符串]，\
\
		“noun_columns”：[字符串]\
\
		}}\
\
	]

}
```

### **3\. 提取唯一名词（unique nouns）：**

### **3．提取唯一名词：**

- 如果用户提问：“销量最高的艺术家有哪些？”或“每个类别的市场份额是多少？”，我们需要明确问题中所指的具体艺术家或类别，才能生成正确的 SQL 查询。
- 如果用户提问：“AC/DC 销量最高的歌曲有哪些？”（大家都知道答案是 *Thunderstruck*），但数据库表中存储的艺人名称为 `"AC/DC"` 而非 `"ac dc"`，那么我们必须获取数据库中该艺人名称的**准确拼写**，才能生成正确的 SQL 查询。
- 这正是“唯一名词”的作用所在。我们从用户问题和数据库 schema 中分别提取唯一名词，并进行匹配——借此可确定艺人名称的规范拼写，以及相关实体的完整列表。

- If the user asks “What are the top selling artists?” or “What is the market share of each category?”, we need to know which artists are being referred to or which categories are being referred to in order to generate the correct SQL query.  
- What if the user asks “Top selling ac dc songs?” (We all know it has to be Thunderstruck) but the table contains the name "AC/DC" instead of "ac dc"? We need to get the correct spelling of the artist's name in order to generate the correct SQL query.  
- This is where the unique nouns come in. We extract the unique nouns from the question and the schema and match them. We can get the correct spelling of the artist's name and the list of entities using the unique nouns.

函数

```python
    def get_unique_nouns(self, state: dict) -> dict:
        """Find unique nouns in relevant tables and columns."""
        parsed_question = state['parsed_question']

        if not parsed_question['is_relevant']:
            return {"unique_nouns": []}

        unique_nouns = set()
        for table_info in parsed_question['relevant_tables']:
            table_name = table_info['table_name']
            noun_columns = table_info['noun_columns']

            if noun_columns:
                column_names = ', '.join(f"`{col}`" for col in noun_columns)
                query = f"SELECT DISTINCT {column_names} FROM `{table_name}`"
                results = self.db_manager.execute_query(state['uuid'], query)
                for row in results:
                    unique_nouns.update(str(value) for value in row if value)
```

```python
    def get_unique_nouns(self, state: dict) -> dict:
        """在相关表和列中查找唯一名词。"""
        parsed_question = state['parsed_question']

        if not parsed_question['is_relevant']:
            return {"unique_nouns": []}

        unique_nouns = set()
        for table_info in parsed_question['relevant_tables']:
            table_name = table_info['table_name']
            noun_columns = table_info['noun_columns']

            if noun_columns:
                column_names = ', '.join(f"`{col}`" for col in noun_columns)
                query = f"SELECT DISTINCT {column_names} FROM `{table_name}`"
                results = self.db_manager.execute_query(state['uuid'], query)
                for row in results:
                    unique_nouns.update(str(value) for value in row if value)
```

```python
        return {"unique_nouns": list(unique_nouns)}
```

```python
        return {"unique_nouns": list(unique_nouns)}
```

### **4. Generating the SQL query:**

### **4. 生成 SQL 查询：**

We pass the schema, the user's question, the parsed question and the unique nouns to the SQLAgent. We skip the rows where any column is null, "N/A" or "".

我们将数据库模式（schema）、用户问题、解析后的问题以及提取出的唯一名词（unique nouns）传入 SQLAgent。对于任意一列值为 `null`、`"N/A"` 或空字符串 `""` 的行，我们予以跳过。

Prompt

提示词（Prompt）

```python
You are an AI assistant that generates SQL queries based on user questions, database schema, and unique nouns found in the relevant tables. Generate a valid SQL query to answer the user's question.

If there is not enough information to write a SQL query, respond with "NOT_ENOUGH_INFO".

Here are some examples:

1. What is the top selling product?
Answer: SELECT product_name, SUM(quantity) as total_quantity FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND product_name != "" AND quantity != "" AND product_name != "N/A" AND quantity != "N/A" GROUP BY product_name ORDER BY total_quantity DESC LIMIT 1

2. What is the total revenue for each product?
Answer: SELECT product_name, SUM(quantity * price) as total_revenue FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND price IS NOT NULL AND product_name != "" AND quantity != "" AND price != "" AND product_name != "N/A" AND quantity != "N/A" AND price != "N/A" GROUP BY product_name ORDER BY total_revenue DESC

3. What is the market share of each product?
Answer: SELECT product_name, SUM(quantity) * 100.0 / (SELECT SUM(quantity) FROM sales) as market_share FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND product_name != "" AND quantity != "" AND product_name != "N/A" AND quantity != "N/A" GROUP BY product_name ORDER BY market_share DESC
```

```python
你是一个 AI 助手，能够根据用户问题、数据库模式（schema）以及相关表中识别出的唯一名词（unique nouns）生成 SQL 查询语句，以准确回答用户问题。

若信息不足、无法生成有效 SQL 查询，请仅返回字符串："NOT_ENOUGH_INFO"。

以下是一些示例：

1. 销量最高的产品是什么？
答案：SELECT product_name, SUM(quantity) as total_quantity FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND product_name != "" AND quantity != "" AND product_name != "N/A" AND quantity != "N/A" GROUP BY product_name ORDER BY total_quantity DESC LIMIT 1

2. 各产品的总营收是多少？
答案：SELECT product_name, SUM(quantity * price) as total_revenue FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND price IS NOT NULL AND product_name != "" AND quantity != "" AND price != "" AND product_name != "N/A" AND quantity != "N/A" AND price != "N/A" GROUP BY product_name ORDER BY total_revenue DESC

3. 各产品的市场份额是多少？
答案：SELECT product_name, SUM(quantity) * 100.0 / (SELECT SUM(quantity) FROM sales) as market_share FROM sales WHERE product_name IS NOT NULL AND quantity IS NOT NULL AND product_name != "" AND quantity != "" AND product_name != "N/A" AND quantity != "N/A" GROUP BY product_name ORDER BY market_share DESC
```

4. Plot the distribution of income over time

4. 随时间绘制收入分布图

Answer: SELECT income, COUNT(*) as count FROM users WHERE income IS NOT NULL AND income != "" AND income != "N/A" GROUP BY income

答案：SELECT income, COUNT(*) as count FROM users WHERE income IS NOT NULL AND income != "" AND income != "N/A" GROUP BY income

{unique_nouns}

{unique_nouns}

### **5\. Validating and fixing the SQL query:**

### **5. 验证并修正 SQL 查询：**

- We pass the SQL query to the SQLAgent. It checks if the query is valid and all the tables and columns used in the query are relevant and if it is, it returns the SQL query.  
- 我们将 SQL 查询传递给 SQLAgent。它会检查该查询是否有效，以及查询中使用的所有表名和列名是否均正确且存在于数据库模式中；若一切无误，则直接返回原始 SQL 查询。

- For example, there are cases when the data needs to be converted from string to date or integer, this is fixed in this step.  
- 例如，某些情况下数据需从字符串类型转换为日期或整数类型，此类类型转换问题即在此步骤中予以修正。

Prompt  

提示词  

```python
You are an AI assistant that validates and fixes SQL queries. Your task is to:
1. Check if the SQL query is valid.
2. Ensure all table and column names are correctly spelled and exist in the schema.
3. If there are any issues, fix them and provide the corrected SQL query.
4. If no issues are found, return the original query.

Respond in JSON format with the following structure. Only respond with the JSON:
{{
    "valid": boolean,
    "issues": string or null,
    "corrected_query": string
}}
```

```python
你是一个用于验证并修正 SQL 查询的 AI 助手。你的任务是：
1. 检查 SQL 查询语法是否有效；
2. 确保所有表名与列名拼写正确，且均存在于数据库模式中；
3. 若存在任何问题，请予以修正，并提供修正后的 SQL 查询；
4. 若未发现任何问题，则返回原始查询。

请严格以如下 JSON 格式响应，且仅输出 JSON 内容：
{{
    "valid": 布尔值,
    "issues": 字符串或 null,
    "corrected_query": 字符串
}}
```

            ("human", '''===Database schema:
{schema}

===Generated SQL query:
{sql_query}

Respond in JSON format with the following structure. Only respond with the JSON:
{{
    "valid": boolean,
    "issues": string or null,
    "corrected_query": string
}}

For example:
1. {{
    "valid": true,
    "issues": null,
    "corrected_query": "None"
}}

2. {{
    "valid": false,
    "issues": "Column USERS does not exist",
    "corrected_query": "SELECT * FROM users WHERE age > 25"
}}
```

            ("human", '''===数据库模式：
{schema}

===生成的 SQL 查询：
{sql_query}

请严格以如下 JSON 格式响应，且仅输出 JSON 内容：
{{
    "valid": 布尔值,
    "issues": 字符串或 null,
    "corrected_query": 字符串
}}

示例：
1. {{
    "valid": true,
    "issues": null,
    "corrected_query": "None"
}}

2. {{
    "valid": false,
    "issues": "列 USERS 不存在",
    "corrected_query": "SELECT * FROM users WHERE age > 25"
}}
```

### **6\. Executing the SQL query:**

### **6．执行 SQL 查询：**

We pass the SQL query to the DatabaseManager. It passes the query to the remote database and returns the results.

我们将 SQL 查询传递给 DatabaseManager。DatabaseManager 将该查询发送至远程数据库，并返回查询结果。

### **7\. Choosing an appropriate visualization:**

### **7．选择合适的可视化图表：**

I think it is a good idea to reverse engineer this process. Assuming that we are adding support for the following graphs/charts:

我认为逆向推导这一过程是个不错的思路。假设我们正在为以下图表类型添加支持：

1. Column Graphs  
2. Bar Graphs  
3. Scatter Plots  
4. Line Graphs  
5. Pie Charts  

1. 柱状图（Column Graphs）  
2. 条形图（Bar Graphs）  
3. 散点图（Scatter Plots）  
4. 折线图（Line Graphs）  
5. 饼图（Pie Charts）  

Here’s a breakdown of the types of questions we would need to support  

以下是需要支持的问题类型分类：

- **Bar/Column Graphs**:  
  - **Questions**: "What are the sales figures for each product in the last quarter?", "How does the population of cities compare?", "What are the top 5 most common job titles in the company?"  
  - **Use Case**: Best for comparing categorical data or showing changes over time when categories are discrete.  

- **条形图／柱状图**：  
  - **问题示例**：“上一季度各产品的销售额是多少？”、“各城市人口数量如何对比？”、“公司中出现频率最高的前 5 个职位名称是什么？”  
  - **适用场景**：最适合用于比较分类数据，或在类别为离散型时展示随时间变化的趋势。

- **Scatter Plots**:  
  - **Questions**: "Is there a relationship between advertising spend and sales?", "How do height and weight correlate in the dataset?", "What is the distribution of ages vs. salaries?"  
  - **Use Case**: Useful for identifying relationships or correlations between two numerical variables.  

- **散点图**：  
  - **问题示例**：“广告投入与销售额之间是否存在关联？”、“数据集中身高与体重之间有何相关性？”、“年龄与薪资的分布关系如何？”  
  - **适用场景**：适用于识别两个数值型变量之间的关系或相关性。

- **Pie Charts**:  
  - **Questions**: "What is the market share distribution among different companies?", "How are the department budgets divided?", "What percentage of the total revenue comes from each product?"  
  - **Use Case**: Ideal for showing proportions or percentages within a whole.  

- **饼图**：  
  - **问题示例**：“不同公司在市场中的份额分布如何？”、“各部门预算如何划分？”、“各产品分别贡献了总收入的百分之几？”  
  - **适用场景**：最适合展示整体中各部分所占的比例或百分比。

- **Line Graphs**:  
  - **Questions**: "How have website visits changed over the year?", "What is the trend in temperature over the past decade?", "How has stock price fluctuated over time?"  
  - **Use Case**: Best for showing trends over time with continuous data.  

- **折线图**：  
  - **问题示例**：“网站访问量在过去一年中如何变化？”、“过去十年气温变化趋势如何？”、“股价随时间如何波动？”  
  - **适用场景**：最适合用于展示连续型数据随时间变化的趋势。

This identifies the following lines of questioning:  

由此可归纳出以下几类提问方向：

- **Aggregations and Summarizations**:  
  - Example: "What is the average revenue by month?" (Line Graph)  
  - "Show the total sales by product category." (Bar/Column Graph)  

- **聚合与汇总类问题**：  
  - 示例：“每月平均收入是多少？”（折线图）  
  - “按产品类别展示总销售额。”（条形图／柱状图）

- **Comparisons**:  
  - Example: "Compare the sales figures of Product A and Product B over the last year." (Line or Column Graph)  

- **对比类问题**：  
  - 示例：“对比产品 A 与产品 B 在过去一年的销售数据。”（折线图或柱状图）

- **Trends Over Time**:  
  - Example: "What is the trend in the number of active users over the past year?" (Line Graph)  

- **时间趋势类问题**：  
  - 示例：“过去一年活跃用户数量的变化趋势如何？”（折线图）

- **Proportions**:  
  - Example: "What percentage of sales came from each region?" (Pie Chart)  

- **比例构成类问题**：  
  - 示例：“各地区销售额占总销售额的百分比分别是多少？”（饼图）

- **Correlations**:  
  - Example: "Is there a correlation between marketing spend and revenue?" (Scatter Plot)  

- **相关性分析类问题**：  
  - 示例：“营销投入与收入之间是否存在相关性？”（散点图）

**Prompt**  

**提示词**

```python
You are an AI assistant that recommends appropriate data visualizations. Based on the user's question, SQL query, and query results, suggest the most suitable type of graph or chart to visualize the data. If no visualization is appropriate, indicate that.

您是一位推荐合适数据可视化的 AI 助手。请根据用户的问题、SQL 查询及其查询结果，建议最适合用于可视化该数据的图表类型；若不适合进行可视化，请明确说明。

Available chart types and their use cases:

可用图表类型及其适用场景：

- Bar Graphs: Best for comparing categorical data or showing changes over time when categories are discrete and the number of categories is more than 2. Use for questions like "What are the sales figures for each product?" or "How does the population of cities compare? or "What percentage of each city is male?"

- 条形图（Bar Graphs）：最适合用于比较分类数据，或在类别为离散型且类别数量大于 2 时展示随时间的变化趋势。适用于如下问题：“各产品的销售额是多少？”、“各城市的常住人口如何比较？”、“各城市男性人口占比是多少？”

- Horizontal Bar Graphs: Best for comparing categorical data or showing changes over time when the number of categories is small or the disparity between categories is large. Use for questions like "Show the revenue of A and B?" or "How does the population of 2 cities compare?" or "How many men and women got promoted?" or "What percentage of men and what percentage of women got promoted?" when the disparity between categories is large.

- 水平条形图（Horizontal Bar Graphs）：最适合用于类别数量较少，或各类别间差异较大的分类数据比较，或此类条件下的时序变化展示。适用于如下问题：“展示 A 和 B 的收入？”、“两个城市的人口规模如何对比？”、“有多少男性和女性获得晋升？”、“男性和女性的晋升比例分别是多少？”（尤其当两类间差异显著时）

- Scatter Plots: Useful for identifying relationships or correlations between two numerical variables or plotting distributions of data. Best used when both x axis and y axis are continuous. Use for questions like "Plot a distribution of the fares (where the x axis is the fare and the y axis is the count of people who paid that fare)" or "Is there a relationship between advertising spend and sales?" or "How do height and weight correlate in the dataset? Do not use it for questions that do not have a continuous x axis."

- 散点图（Scatter Plots）：适用于识别两个数值型变量之间的关系或相关性，或绘制数据分布。最佳使用场景是横纵坐标轴均为连续型变量。适用于如下问题：“绘制票价分布图（横轴为票价，纵轴为支付该票价的人数）”、“广告投入与销售额之间是否存在关联？”、“数据集中身高与体重之间有何相关性？”；**不适用于横轴非连续型变量的问题。**

- Pie Charts: Ideal for showing proportions or percentages within a whole. Use for questions like "What is the market share distribution among different companies?" or "What percentage of the total revenue comes from each product?"

- 饼图（Pie Charts）：最适合展示整体中各部分所占的比例或百分比。适用于如下问题：“不同公司在市场中的份额分布如何？”、“各产品分别贡献了总收入的百分之几？”

- Line Graphs: Best for showing trends and distributions over time. Best used when both x axis and y axis are continuous. Used for questions like "How have website visits changed over the year?" or "What is the trend in temperature over the past decade?". Do not use it for questions that do not have a continuous x axis or a time based x axis.

- 折线图（Line Graphs）：最适合展示随时间变化的趋势或分布。最佳使用场景是横纵坐标轴均为连续型变量（尤其是横轴为时间序列）。适用于如下问题：“网站访问量在过去一年中如何变化？”、“过去十年气温变化趋势如何？”；**不适用于横轴既非连续型变量、也非时间序列的问题。**

Consider these types of questions when recommending a visualization:

在推荐可视化方案时，请考虑以下几类典型问题：

1. Aggregations and Summarizations (e.g., "What is the average revenue by month?" - Line Graph)

1. 聚合与汇总类问题（例如：“每月平均收入是多少？” → 折线图）

2. Comparisons (e.g., "Compare the sales figures of Product A and Product B over the last year." - Line or Column Graph)

2. 对比类问题（例如：“对比产品 A 和产品 B 在过去一年的销售额。” → 折线图或柱状图）

3. Plotting Distributions (e.g., "Plot a distribution of the age of users" - Scatter Plot)

3. 分布绘制类问题（例如：“绘制用户年龄的分布图。” → 散点图）

4. Trends Over Time (e.g., "What is the trend in the number of active users over the past year?" - Line Graph)

4. 时序趋势类问题（例如：“过去一年活跃用户数量的变化趋势如何？” → 折线图）

5. Proportions (e.g., "What is the market share of the products?" - Pie Chart)

5. 比例构成类问题（例如：“各产品的市场份额是多少？” → 饼图）

6. Correlations (e.g., "Is there a correlation between marketing spend and revenue?" - Scatter Plot)

6. 相关性分析类问题（例如：“营销投入与收入之间是否存在相关性？” → 散点图）
```

### **8\. Formatting the data for visualization:**

### **8. 格式化数据以进行可视化：**

We pass the SQL query results to the DataFormatter. It formats the data according to the visualization type. If the results are in a predictable format, we have implemented rule based logic to format the data and only use llms to come up with labels, which speeds up the process especially in the cases of bar graphs, line graphs and scatter plots. Else we pass the results to a LLM to format the data.

我们将 SQL 查询结果传递给 `DataFormatter`。它会根据可视化类型对数据进行格式化。如果结果具有可预测的结构，我们会采用基于规则的逻辑来格式化数据，并**仅使用大语言模型（LLM）生成标签**，从而显著提升处理速度——尤其适用于柱状图、折线图和散点图。否则，我们将结果交由 LLM 进行完整的数据格式化。

**Formatting instructions**  
**格式化指令**

```python

barGraphIntstruction = '''

  Where data is: {
    labels: string[]
    values: {\\data: number[], label: string}[]
  }

// Examples of usage:
Each label represents a column on the x axis.
Each array in values represents a different entity.

```  

// 示例用法：  
每个 `label` 对应 x 轴上的一个柱子（类别）。  
`values` 中的每个数组代表一个独立的实体（例如不同年份、不同产品线等）。  

Recommended Visualization: bar  
Reason: The formatting instruction explicitly defines `labels` (x-axis categories) and `values` as grouped numeric arrays — a canonical structure for multi-series bar charts.

Here we are looking at average income for each month.

我们在此查看每个月的平均收入。

1. data = {
  labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
  values: [{data:[21.5, 25.0, 47.5, 64.8, 105.5, 133.2], label: 'Income'}],
}

1. data = {
  labels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  values: [{data:[21.5, 25.0, 47.5, 64.8, 105.5, 133.2], label: '收入'}],
}

Here we are looking at the performance of american and european players for each series. Since there are two entities, we have two arrays in values.

我们在此查看美国与欧洲选手在各系列赛事中的表现。由于涉及两个实体，`values` 中包含两个数组。

2. data = {
  labels: ['series A', 'series B', 'series C'],
  values: [{data:[10, 15, 20], label: 'American'}, {data:[20, 25, 30], label: 'European'}],
}

2. data = {
  labels: ['系列 A', '系列 B', '系列 C'],
  values: [{data:[10, 15, 20], label: '美国选手'}, {data:[20, 25, 30], label: '欧洲选手'}],
}

horizontalBarGraphIntstruction = '''

  Where data is: {
    labels: string[]
    values: {\data: number[], label: string}[]
  }

// Examples of usage:
Each label represents a column on the x axis.
Each array in values represents a different entity.

horizontalBarGraphIntstruction = '''

  数据格式为：{
    labels: 字符串数组
    values: {\\data: 数值数组, label: 字符串} 数组
  }

// 使用示例：
每个 label 表示横轴（x 轴）上的一个柱状图类别。
`values` 中的每个数组代表一个不同的实体。

Here we are looking at average income for each month.
1. data = {
  labels: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun'],
  values: [{data:[21.5, 25.0, 47.5, 64.8, 105.5, 133.2], label: 'Income'}],
}

我们在此查看每个月的平均收入。
1. data = {
  labels: ['一月', '二月', '三月', '四月', '五月', '六月'],
  values: [{data:[21.5, 25.0, 47.5, 64.8, 105.5, 133.2], label: '收入'}],
}

Here we are looking at the performance of american and european players for each series. Since there are two entities, we have two arrays in values.
2. data = {
  labels: ['series A', 'series B', 'series C'],
  values: [{data:[10, 15, 20], label: 'American'}, {data:[20, 25, 30], label: 'European'}],
}

我们在此查看美国与欧洲选手在各系列赛事中的表现。由于涉及两个实体，`values` 中包含两个数组。
2. data = {
  labels: ['系列 A', '系列 B', '系列 C'],
  values: [{data:[10, 15, 20], label: '美国选手'}, {data:[20, 25, 30], label: '欧洲选手'}],
}

'''

lineGraphIntstruction = '''

  Where data is: {
  xValues: number[] | string[]
  yValues: { data: number[]; label: string }[]
}

lineGraphIntstruction = '''

  数据格式为：{
    xValues: 数值数组 | 字符串数组
    yValues: { data: 数值数组; label: 字符串 } 数组
  }

// Examples of usage:

// 示例用法：

Here we are looking at the momentum of a body as a function of mass.

此处我们考察一个物体的动量随质量变化的关系。

1. data = {
  xValues: ['2020', '2021', '2022', '2023', '2024'],
  yValues: [\
    { data: [2, 5.5, 2, 8.5, 1.5]},\
  ],
}

1. data = {
  xValues: ['2020', '2021', '2022', '2023', '2024'],
  yValues: [\
    { data: [2, 5.5, 2, 8.5, 1.5]},\
  ],
}

Here we are looking at the performance of american and european players for each year. Since there are two entities, we have two arrays in yValues.

此处我们考察每年美国球员与欧洲球员的表现。由于涉及两个实体，`yValues` 中包含两个数组。

2. data = {
  xValues: ['2020', '2021', '2022', '2023', '2024'],
  yValues: [\
    { data: [2, 5.5, 2, 8.5, 1.5], label: 'American' },\
    { data: [2, 5.5, 2, 8.5, 1.5], label: 'European' },\
  ],
}

2. data = {
  xValues: ['2020', '2021', '2022', '2023', '2024'],
  yValues: [\
    { data: [2, 5.5, 2, 8.5, 1.5], label: 'American' },\
    { data: [2, 5.5, 2, 8.5, 1.5], label: 'European' },\
  ],
}

pieChartIntstruction = '''

pieChartIntstruction = '''

  Where data is: {
    labels: string
    values: number
  }[]

  其中 `data` 的结构为：{
    labels: 字符串
    values: 数字
  }[]

// Example usage:
// 示例用法：
 data = [\
        { id: 0, value: 10, label: 'series A' },\
        { id: 1, value: 15, label: 'series B' },\
        { id: 2, value: 20, label: 'series C' },\
      ],
'''

scatterPlotIntstruction = '''
scatterPlotIntstruction = '''
Where data is: {
  series: {
    data: { x: number; y: number; id: number }[]
    label: string
  }[]
}

其中 `data` 的结构为：{
  series: {
    data: { x: 数字; y: 数字; id: 数字 }[]
    label: 字符串
  }[]
}

// Examples of usage:
// 示例用法：
1. Here each data array represents the points for a different entity.
We are looking for correlation between amount spent and quantity bought for men and women.

1. 此处每个 `data` 数组代表一个不同实体的数据点。  
我们旨在分析男性与女性在“消费金额”与“购买数量”之间的相关性。

data = {
  series: [\
    {\
      data: [\
        { x: 100, y: 200, id: 1 },\
        { x: 120, y: 100, id: 2 },\
        { x: 170, y: 300, id: 3 },\
      ],\
      label: 'Men',\
    },\
    {\
      data: [\
        { x: 300, y: 300, id: 1 },\
        { x: 400, y: 500, id: 2 },\
        { x: 200, y: 700, id: 3 },\
      ],\
      label: 'Women',\
    }\
  ],
}

data = {
  series: [\
    {\
      data: [\
        { x: 100, y: 200, id: 1 },\
        { x: 120, y: 100, id: 2 },\
        { x: 170, y: 300, id: 3 },\
      ],\
      label: 'Men',\
    },\
    {\
      data: [\
        { x: 300, y: 300, id: 1 },\
        { x: 400, y: 500, id: 2 },\
        { x: 200, y: 700, id: 3 },\
      ],\
      label: 'Women',\
    }\
  ],
}

2. Here we are looking for correlation between the height and weight of players.

2. 此处我们旨在分析球员身高与体重之间的相关性。

data = {
  series: [\
    {\
      data: [\
        { x: 180, y: 80, id: 1 },\
        { x: 170, y: 70, id: 2 },\
        { x: 160, y: 60, id: 3 },\
      ],\
      label: 'Players',\
    },\
  ],
}

data = {
  series: [\
    {\
      data: [\
        { x: 180, y: 80, id: 1 },\
        { x: 170, y: 70, id: 2 },\
        { x: 160, y: 60, id: 3 },\
      ],\
      label: 'Players',\
    },\
  ],
}

// Note: Each object in the 'data' array represents a point on the scatter plot.
// The 'x' and 'y' values determine the position of the point, and 'id' is a unique identifier.
// Multiple series can be represented, each as an object in the outer array.

// 注意：`data` 数组中的每个对象代表散点图上的一个数据点；  
// `'x'` 和 `'y'` 值决定该点在图中的位置，`'id'` 是其唯一标识符；  
// 可以表示多个数据系列，每个系列均为外层数组中的一个对象。

```python
graph_instructions = {
    "bar": barGraphIntstruction,
    "horizontal_bar": horizontalBarGraphIntstruction,
    "line": lineGraphIntstruction,
    "pie": pieChartIntstruction,
    "scatter": scatterPlotIntstruction
}
```

```python
图表示指令

```python
class DataFormatter:
    def __init__(self):
        self.llm_manager = LLMManager()


    def format_data_for_visualization(self, state: dict) -> dict:
        """Format the data for the chosen visualization type."""
        """为选定的可视化类型格式化数据。"""
        visualization = state['visualization']
        results = state['results']
        question = state['question']
        sql_query = state['sql_query']

        if visualization == "none":
            return {"formatted_data_for_visualization": None}

        if visualization == "scatter":
            try:
                return self._format_scatter_data(results)
            except Exception as e:
                return self._format_other_visualizations(visualization, question, sql_query, results)

        if visualization == "bar" or visualization == "horizontal_bar":
            try:
                return self._format_bar_data(results, question)
            except Exception as e:
                return self._format_other_visualizations(visualization, question, sql_query, results)

        if visualization == "line":
            try:
                return self._format_line_data(results, question)
            except Exception as e:
                return self._format_other_visualizations(visualization, question, sql_query, results)

        return self._format_other_visualizations(visualization, question, sql_query, results)
```

```python
    def _format_line_data(self, results, question):
        if isinstance(results, str):
            results = eval(results)

        if len(results[0]) == 2:

            x_values = [str(row[0]) for row in results]
            y_values = [float(row[1]) for row in results]

            # Use LLM to get a relevant label
            prompt = ChatPromptTemplate.from_messages([\
                ("system", "You are a data labeling expert. Given a question and some data, provide a concise and relevant label for the data series."),\
                ("human", "Question: {question}\\n Data (first few rows): {data}\\n\\nProvide a concise label for this y axis. For example, if the data is the sales figures over time, the label could be 'Sales'. If the data is the population growth, the label could be 'Population'. If the data is the revenue trend, the label could be 'Revenue'."),\
            ])
            label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

            formatted_data = {
                "xValues": x_values,
                "yValues": [\
                    {\
                        "data": y_values,\
                        "label": label.strip()\
                    }\
                ]
            }
        elif len(results[0]) == 3:

            # Group data by label
            data_by_label = {}
            x_values = []

            for item1, item2, item3 in results:
                # Determine which item is the label (string not convertible to float and not containing "/")
                if isinstance(item1, str) and not item1.replace(".", "").isdigit() and "/" not in item1:
                    label, x, y = item1, item2, item3
                else:
                    x, label, y = item1, item2, item3


                if str(x) not in x_values:
                    x_values.append(str(x))
                if label not in data_by_label:
                    data_by_label[label] = []
                data_by_label[label].append(float(y))

            # Create yValues array
            y_values = [\
                {\
                    "data": data,\
                    "label": label\
                }\
                for label, data in data_by_label.items()\
            ]

            formatted_data = {
                "xValues": x_values,
                "yValues": y_values
            }
```

```python
    def _format_line_data(self, results, question):
        if isinstance(results, str):
            results = eval(results)

        if len(results[0]) == 2:

            x_values = [str(row[0]) for row in results]
            y_values = [float(row[1]) for row in results]

            # 使用大语言模型（LLM）生成一个相关标签
            prompt = ChatPromptTemplate.from_messages([\
                ("system", "你是一位数据标注专家。给定一个问题和一些数据，请为该数据序列提供简洁且相关的标签。"),\
                ("human", "问题：{question}\\n 数据（前几行）：{data}\\n\\n请为此 y 轴提供一个简洁的标签。例如，若数据是随时间变化的销售额，则标签可为“销售额”；若是人口增长数据，则标签可为“人口”；若是收入趋势数据，则标签可为“收入”。"),\
            ])
            label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

            formatted_data = {
                "xValues": x_values,
                "yValues": [\
                    {\
                        "data": y_values,\
                        "label": label.strip()\
                    }\
                ]
            }
        elif len(results[0]) == 3:

            # 按标签对数据进行分组
            data_by_label = {}
            x_values = []

            for item1, item2, item3 in results:
                # 判断哪个字段是标签（字符串类型、无法转为浮点数、且不包含“/”）
                if isinstance(item1, str) and not item1.replace(".", "").isdigit() and "/" not in item1:
                    label, x, y = item1, item2, item3
                else:
                    x, label, y = item1, item2, item3


                if str(x) not in x_values:
                    x_values.append(str(x))
                if label not in data_by_label:
                    data_by_label[label] = []
                data_by_label[label].append(float(y))

            # 构建 yValues 数组
            y_values = [\
                {\
                    "data": data,\
                    "label": label\
                }\
                for label, data in data_by_label.items()\
            ]

            formatted_data = {
                "xValues": x_values,
                "yValues": y_values
            }
```

# Use LLM to get a relevant label for the y-axis

# 使用大语言模型为 y 轴生成相关标签

prompt = ChatPromptTemplate.from_messages([\
    ("system", "You are a data labeling expert. Given a question and some data, provide a concise and relevant label for the y-axis."),\
    ("human", "Question: {question}\\n Data (first few rows): {data}\\n\\nProvide a concise label for the y-axis. For example, if the data represents sales figures over time for different categories, the label could be 'Sales'. If it's about population growth for different groups, it could be 'Population'."),\
])
prompt = ChatPromptTemplate.from_messages([\
    ("system", "你是一位数据标注专家。请根据给定的问题和部分数据，为 y 轴提供一个简洁且相关的标签。"),\
    ("human", "问题：{question}\\n 数据（前几行）：{data}\\n\\n请为 y 轴提供一个简洁的标签。例如，若数据表示不同类别的时序销售数据，则标签可为“销售额”；若数据表示不同群体的人口增长情况，则标签可为“人口”。"),\
])

y_axis_label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

y_axis_label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

# Add the y-axis label to the formatted data

# 将 y 轴标签添加到格式化后的数据中

formatted_data["yAxisLabel"] = y_axis_label.strip()

formatted_data["yAxisLabel"] = y_axis_label.strip()

return {"formatted_data_for_visualization": formatted_data}

返回 {"formatted_data_for_visualization": formatted_data}

def _format_scatter_data(self, results):

def _format_scatter_data(self, results):

    if isinstance(results, str):

    如果 results 是字符串类型：

        results = eval(results)

        results = eval(results)

    formatted_data = {"series": []}

    formatted_data = {"series": []}

    if len(results[0]) == 2:

    如果 results 中每行有 2 个字段：

        formatted_data["series"].append({

        formatted_data["series"].append({

            "data": [\
                {"x": float(x), "y": float(y), "id": i+1}\
                for i, (x, y) in enumerate(results)\
            ],
            "label": "Data Points"
        })

            "data": [\
                {"x": float(x), "y": float(y), "id": i+1}\
                for i, (x, y) in enumerate(results)\
            ],
            "label": "数据点"
        })

    elif len(results[0]) == 3:

    elif len(results[0]) == 3:

        entities = {}

        entities = {}

        for item1, item2, item3 in results:

        for item1, item2, item3 in results:

            # Determine which item is the label (string not convertible to float and not containing "/")

            # 判断哪个字段是标签（字符串类型、无法转为浮点数、且不包含 "/" 字符）

            if isinstance(item1, str) and not item1.replace(".", "").isdigit() and "/" not in item1:

            if isinstance(item1, str) and not item1.replace(".", "").isdigit() and "/" not in item1:

                label, x, y = item1, item2, item3

                label, x, y = item1, item2, item3

            else:

            else:

                x, label, y = item1, item2, item3

                x, label, y = item1, item2, item3

            if label not in entities:

            if label not in entities:

                entities[label] = []

                entities[label] = []

            entities[label].append({"x": float(x), "y": float(y), "id": len(entities[label])+1})

            entities[label].append({"x": float(x), "y": float(y), "id": len(entities[label])+1})

        for label, data in entities.items():

        for label, data in entities.items():

            formatted_data["series"].append({

            formatted_data["series"].append({

                "data": data,

                "data": data,

                "label": label

                "label": label

            })

            })

    else:

    else:

        raise ValueError("Unexpected data format in results")

        raise ValueError("results 中的数据格式异常")

    return {"formatted_data_for_visualization": formatted_data}

    返回 {"formatted_data_for_visualization": formatted_data}

def _format_bar_data(self, results, question):

def _format_bar_data(self, results, question):

    if isinstance(results, str):

    如果 results 是字符串类型：

        results = eval(results)

        results = eval(results)

    if len(results[0]) == 2:

    如果 results 中每行有 2 个字段：

        # Simple bar chart with one series

        # 单系列简单柱状图

        labels = [str(row[0]) for row in results]

        labels = [str(row[0]) for row in results]

        data = [float(row[1]) for row in results]

        data = [float(row[1]) for row in results]

# Use LLM to get a relevant label

# 使用大语言模型获取相关标签

prompt = ChatPromptTemplate.from_messages([\
    ("system", "You are a data labeling expert. Given a question and some data, provide a concise and relevant label for the data series."),\
    ("human", "Question: {question}\\nData (first few rows): {data}\\n\\nProvide a concise label for this y axis. For example, if the data is the sales figures for products, the label could be 'Sales'. If the data is the population of cities, the label could be 'Population'. If the data is the revenue by region, the label could be 'Revenue'."),\
])
label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

prompt = ChatPromptTemplate.from_messages([\
    ("system", "您是一位数据标注专家。给定一个问题和一些数据，请为该数据序列提供简洁且相关的标签。"),\
    ("human", "问题：{question}\\n数据（前几行）：{data}\\n\\n请为此 y 轴提供一个简洁的标签。例如，若数据是各产品的销售额，则标签可为“销售额”；若数据是各城市的常住人口，则标签可为“人口”；若数据是按地区划分的收入，则标签可为“收入”。"),\
])
label = self.llm_manager.invoke(prompt, question=question, data=str(results[:2]))

values = [{"data": data, "label": label}]
elif len(results[0]) == 3:
    # Grouped bar chart with multiple series
    # 分组柱状图（含多个数据系列）

    categories = set(row[1] for row in results)
    labels = list(categories)
    entities = set(row[0] for row in results)
    values = []
    for entity in entities:
        entity_data = [float(row[2]) for row in results if row[0] == entity]
        values.append({"data": entity_data, "label": str(entity)})
else:
    raise ValueError("Unexpected data format in results")

values = [{"data": data, "label": label}]
elif len(results[0]) == 3:
    # 分组柱状图（含多个数据系列）

    categories = set(row[1] for row in results)
    labels = list(categories)
    entities = set(row[0] for row in results)
    values = []
    for entity in entities:
        entity_data = [float(row[2]) for row in results if row[0] == entity]
        values.append({"data": entity_data, "label": str(entity)})
else:
    raise ValueError("结果中出现意外的数据格式")

formatted_data = {
    "labels": labels,
    "values": values
}

formatted_data = {
    "labels": labels,
    "values": values
}

return {"formatted_data_for_visualization": formatted_data}

return {"formatted_data_for_visualization": formatted_data}

def _format_other_visualizations(self, visualization, question, sql_query, results):
    instructions = graph_instructions[visualization]
    prompt = ChatPromptTemplate.from_messages([\
        ("system", "You are a Data expert who formats data according to the required needs. You are given the question asked by the user, it's sql query, the result of the query and the format you need to format it in."),\
        ("human", 'For the given question: {question}\\n\\nSQL query: {sql_query}\\n\\Result: {results}\\n\\nUse the following example to structure the data: {instructions}. Just give the json string. Do not format it'),\
    ])
    response = self.llm_manager.invoke(prompt, question=question, sql_query=sql_query, results=results, instructions=instructions)

def _format_other_visualizations(self, visualization, question, sql_query, results):
    instructions = graph_instructions[visualization]
    prompt = ChatPromptTemplate.from_messages([\
        ("system", "您是一位数据专家，负责按指定需求对数据进行格式化。您将收到用户提出的问题、对应的 SQL 查询语句、查询结果，以及所需的目标格式说明。"),\
        ("human", "针对以下问题：{question}\\n\\nSQL 查询语句：{sql_query}\\n\\n查询结果：{results}\\n\\n请参照以下示例结构化数据：{instructions}。仅返回 JSON 字符串，不要添加任何额外格式或解释。"),\
    ])
    response = self.llm_manager.invoke(prompt, question=question, sql_query=sql_query, results=results, instructions=instructions)

    try:
        formatted_data_for_visualization = json.loads(response)
        return {"formatted_data_for_visualization": formatted_data_for_visualization}
    except json.JSONDecodeError:
        return {"error": "Failed to format data for visualization", "raw_response": response}

    try:
        formatted_data_for_visualization = json.loads(response)
        return {"formatted_data_for_visualization": formatted_data_for_visualization}
    except json.JSONDecodeError:
        return {"error": "无法将数据格式化为可视化所需格式", "raw_response": response}

**Throughout the workflow, this was our state:**

**在整个工作流中，我们的状态如下：**

```python
class State(TypedDict):
    question: str
    uuid: str
    parsed_question: Dict[str, Any]
    unique_nouns: List[str]
    sql_query: str
    sql_valid: bool
    sql_issues: str
    results: List[Any]
    answer: Annotated[str, operator.add]
    error: str
    visualization: Annotated[str, operator.add]
    visualization_reason: Annotated[str, operator.add]
    formatted_data_for_visualization: Dict[str, Any]
```

```python
class State(TypedDict):
    question: str
    uuid: str
    parsed_question: Dict[str, Any]
    unique_nouns: List[str]
    sql_query: str
    sql_valid: bool
    sql_issues: str
    results: List[Any]
    answer: Annotated[str, operator.add]
    error: str
    visualization: Annotated[str, operator.add]
    visualization_reason: Annotated[str, operator.add]
    formatted_data_for_visualization: Dict[str, Any]
```

### **Frontend**

### **前端界面**

![](images/building-a-data-visualization-agent-with-langgraph-cloud/img_002.png)

On the frontend, we have prebuilt graph templates which are used to show the visualization.

在前端，我们提供了预构建的图模板，用于展示可视化效果。

We use langgraph's streaming api to get the state of the workflow and updates in real time, to provide a nice UI where user can see the progress of the workflow.

我们使用 LangGraph 的流式 API 实时获取工作流的状态及更新，从而提供一个友好的用户界面，使用户能够直观地查看工作流的执行进度。

Once the visualization is generated, the user can see the traces of the workflow along with the final visualization.

可视化生成后，用户即可同时查看工作流的执行轨迹（traces）以及最终的可视化结果。

## **Conclusion**

## **总结**

By combining the power of LangGraph Cloud's streaming API, parallel processing capabilities, and interactive studio, we've created a flexible and powerful data visualization agent. This project demonstrates how modern AI tools can be leveraged to create intuitive interfaces for database querying and data visualization.

通过融合 LangGraph Cloud 的流式 API、并行处理能力以及交互式 Studio，我们构建了一个灵活而强大的数据可视化智能体（data visualization agent）。本项目展示了如何利用现代 AI 工具，为数据库查询与数据可视化打造直观易用的交互界面。

The ability to ask natural language questions about your data and receive instant, visually appealing results opens up new possibilities for data exploration and analysis. Whether you're a data scientist, business analyst, or just someone curious about your data, this tool provides an accessible and powerful way to gain insights.

以自然语言向您的数据提问，并即时获得美观、直观的结果，这为数据探索与分析开辟了全新可能。无论您是数据科学家、商业分析师，还是单纯对自身数据充满好奇的普通用户，该工具都为您提供了一种便捷而强大的洞察获取方式。

We encourage you to try out this project, connect it to your own database, and explore the possibilities of agentic workflows with LangGraph Cloud!

我们诚挚邀请您尝试本项目，将其连接至您自己的数据库，并深入探索 LangGraph Cloud 所赋能的智能体工作流（agentic workflows）的无限可能！