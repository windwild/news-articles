---
title: "How Dataherald Makes Natural Language to SQL Easy"
source: "LangChain Blog"
url: "https://blog.langchain.com/dataherald/"
date: "2024-02-14"
scraped_at: "2026-03-03T08:13:28.261069965+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**Editor's Note: we're excited to feature this guest post from the** [**Dataherald**](https://www.dataherald.com/?ref=blog.langchain.com) **team. Text-to-SQL is a HUGE use case, and Dataherald is the open-source leader in the space. This is a great look behind the curtains to see what makes it tick.**

**编者按：我们非常荣幸地邀请到** [**Dataherald**](https://www.dataherald.com/?ref=blog.langchain.com) **团队撰写这篇客座文章。文本转 SQL（Text-to-SQL）是一个极为重要的应用场景，而 Dataherald 正是该领域首屈一指的开源领导者。本文将带您深入幕后，一探其技术内核与运行机制。**

When ChatGPT came out in late 2022, everyone went over to see if AI could do their day to day work. Marketers wanted their blog posts written, college students their essays, and developers their helper functions. For those working with relational data, the test was to see how well these advanced LLMs could write SQL.

2022 年底 ChatGPT 发布后，人们纷纷尝试验证 AI 是否能胜任日常工作任务：营销人员希望它代写博客文章，大学生期待它辅助完成论文，开发者则希望它生成辅助函数。而对于处理关系型数据的用户而言，关键测试在于：这些先进的大语言模型（LLM）能否准确编写 SQL。

It turned out that while modern LLMs had become very good at writing _syntactically_ correct SQL, the code they generated often was _semantically_ incorrect. In fact, it soon became clear that LLMs are better at writing procedural code than SQL. This is because:

结果发现，尽管现代大语言模型已能写出语法（_syntactically_）完全正确的 SQL，但其生成的代码却常常在语义（_semantically_）上存在错误。事实上，人们很快意识到：LLM 擅长编写过程式代码，却不擅长编写 SQL。原因如下：

1. Metadata and business definition are not stored in the relational database schema.  
   1. 元数据（metadata）与业务定义并未内嵌于关系型数据库的 Schema 中。  
2. LLMs do not do well when it comes to complex SQL requiring window functions, complex JOINs or temporal calculations. Furthermore on large schemas users will often run into context window issues  
   2. 在涉及窗口函数、复杂 JOIN 或时间序列计算等高级 SQL 场景下，LLM 表现欠佳；此外，在大型 Schema 场景中，用户还常遭遇上下文窗口（context window）限制问题。  
3. To get best performance, you need to fine-tune the LLM to the dataset. Creating the training datasets for NL-to-SQL is hard.  
   3. 要实现最优性能，必须针对具体数据集对 LLM 进行微调；而构建高质量的自然语言转 SQL（NL-to-SQL）训练数据集本身极具挑战性。  
4. Assessing the accuracy of the AI generated SQL is extremely challenging.  
   4. 评估 AI 生成 SQL 的准确性极为困难。

At Dataherald, we set out to build an engine that would allow developers to deploy state of the art NL-to-SQL in their applications. We built it on LangChain, leveraging LangSmith for observability.

在 Dataherald，我们的目标是打造一款引擎，使开发者能够在自身应用中便捷部署业界领先的自然语言转 SQL（NL-to-SQL）能力。该引擎基于 LangChain 构建，并利用 LangSmith 实现可观测性（observability）。

## How Dataherald works

## Dataherald 的工作原理

Dataherald is an [open source](https://github.com/Dataherald/dataherald?ref=blog.langchain.com) NL-to-SQL engine which can also be accessed via a [hosted API](https://www.dataherald.com/news/introducing-dhai?ref=blog.langchain.com). Users can add business context, create training data and fine-tune LLMs to their schema. In the hosted version, users can monitor performance and configure the engine through a UI. However, the core part of the product are the two LangChain agents that do the NL to SQL translation.

Dataherald 是一款 [开源](https://github.com/Dataherald/dataherald?ref=blog.langchain.com) 的自然语言转 SQL（NL-to-SQL）引擎，同时也提供 [托管 API](https://www.dataherald.com/news/introducing-dhai?ref=blog.langchain.com) 接入方式。用户可为其注入业务上下文、构建训练数据，并针对自身数据库 Schema 对大语言模型进行微调。在托管版本中，用户可通过图形界面（UI）监控系统性能并配置引擎参数。然而，该产品的核心组件，是负责执行自然语言到 SQL 转换的两个 LangChain Agent。

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_001.jpg)Dataherald Admin Console Query List![](images/how-dataherald-makes-natural-language-to-sql-easy/img_002.jpg)Dataherald Admin Console Database Instructions

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_001.jpg)Dataherald 管理控制台 — 查询列表  
![](images/how-dataherald-makes-natural-language-to-sql-easy/img_002.jpg)Dataherald 管理控制台 — 数据库说明

## How the agents work

## Agent 的工作机制

Dataherald has two LangChain agents: a RAG-only agent which relies on few-shot prompting and the more advanced agent which uses a fine-tuned LLM-as-a-tool.

Dataherald 包含两个 LangChain Agent：其一是仅依赖检索增强生成（RAG）与少样本提示（few-shot prompting）的轻量级 Agent；其二是更先进的 Agent，它将经过微调的大语言模型作为工具（LLM-as-a-tool）加以调用。

### RAG agent:

### RAG 代理：

The RAG agent is used for scenarios where the developer does not have access to a substantial set of sample Question<>SQL pairs (golden SQL) for fine-tuning or training the LLM. It connects to the database and extracts essential information for SQL generation, such as table schema, categorical values, table and column descriptions. It also then leverages the following tools:

RAG 代理适用于开发者无法获取大量样本“问题<>SQL”对（即“黄金 SQL”）以用于大语言模型（LLM）微调或训练的场景。该代理连接数据库，提取生成 SQL 所需的关键信息，例如表结构（schema）、分类值（categorical values）、表与列的描述等。此外，它还集成以下工具：

- A schema-linking tool to identify relevant tables and columns  
- 一个模式链接（schema-linking）工具，用于识别相关联的表和列；  
- A SQL execution tool that executes the generated SQL queries against the database to validate its correctness and recover from errors.  
- 一个 SQL 执行工具，用于在数据库中运行所生成的 SQL 查询，以验证其正确性，并在出错时实现自动恢复；  
- Few-shot sample retriever tool to fetch golden SQL based on the similarity to the incoming prompt and use it for few shot prompting  
- 一个少样本（few-shot）示例检索工具，根据输入提示（prompt）的语义相似度检索黄金 SQL，并将其用于少样本提示（few-shot prompting）。

Developers can further augment prompts with business-specific instructions that are injected into the prompts based on relevance  

开发者还可基于相关性，将业务特定的指令注入提示词中，从而进一步增强提示效果。

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_003.jpg)

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_003.jpg)

Developers often use this agent to create golden SQLs which can then be used to fine-tune an LLM for the more advanced model. The hosted version allows users to do modify SQL and add samples to the training data with a single click through the UI and code editor  

开发者常利用该代理生成黄金 SQL，后续可用于微调 LLM，构建更高级的模型。托管版本支持用户通过 UI 和代码编辑器一键修改 SQL 并将新样本添加至训练数据集。

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_004.jpg)

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_004.jpg)

### Agent with LLM-as-a-tool:

### 以 LLM 为工具的代理：

Once there are more than 10 golden SQL per table, our recommendation is to fine-tune a model and use the more advanced agent, which can be done with a single API call. For this agent, the fine-tuned NL-to-SQL model serves as a tool itself. However, since the fine-tuned model does not possess all the business context, it is still deployed within an agent that is responsible for retrieving business context.

当每张表对应的黄金 SQL 数量超过 10 条后，我们建议对模型进行微调，并启用更高级的代理——该操作仅需一次 API 调用即可完成。在此类代理中，微调后的自然语言转 SQL（NL-to-SQL）模型本身即作为一项工具使用。然而，由于该微调模型并不具备全部业务上下文，因此仍需部署于一个代理框架内，由该代理负责动态检索并注入所需的业务上下文。

Similar to the RAG agent, this agent has direct access to the database and can execute the generated SQL queries, ensuring they accurately retrieve the necessary information to answer the question and doesn’t contain any syntax errors.  

与 RAG 代理类似，该代理也直接连接数据库，并可执行所生成的 SQL 查询，确保查询能准确返回回答问题所需的数据，且不含任何语法错误。

The diagram below shows how this agent works:

以下示意图展示了该智能体的工作原理：

![](images/how-dataherald-makes-natural-language-to-sql-easy/img_005.jpg)

## Conclusion

## 结论

Developers and data teams at companies ranging in size from startups to Fortune 500 companies use Dataherald today to power conversational interfaces for their customers and empower internal business users to self-serve from the data warehouse.

目前，从初创公司到《财富》500强企业，各类规模公司的开发者与数据团队均已采用 Dataherald，为其客户构建对话式交互界面，并赋能内部业务人员直接自助查询数据仓库。

We are just getting started and we have a lot lined up for the next few months: a LangChain integration, increased support for open source LLMs, and allowing agents to ask follow up questions (human as a tool) are all items currently in development.

我们才刚刚起步，未来几个月已规划了多项重要功能：包括与 LangChain 的集成、对开源大语言模型（LLM）的更强支持，以及让智能体能够主动提出后续问题（即“将人类作为工具”）——这些功能均已在开发中。

If you are tired of wrangling with prompts to get NL-to-SQL to work, try out [Dataherald](https://dataherald.com/?ref=blog.langchain.com).

如果您已厌倦反复调试提示词（prompt）以实现自然语言到 SQL 的转换，不妨试用一下 [Dataherald](https://dataherald.com/?ref=blog.langchain.com)。
{% endraw %}
