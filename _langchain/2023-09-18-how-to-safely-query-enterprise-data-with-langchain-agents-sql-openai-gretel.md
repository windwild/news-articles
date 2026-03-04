---
title: "How to Safely Query Enterprise Data with LangChain Agents + SQL + OpenAI + Gretel"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/"
date: "2023-09-18"
scraped_at: "2026-03-03T08:44:44.991464396+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the [Gretel](https://gretel.ai/?ref=blog.langchain.com) team. We're really excited by their approach to combining agent-based methods, LLMs, and synthetic data to enable natural language queries for databases and data warehouses, sans SQL. The post has a really helpful walkthrough (with code!) to bring the ideas to life._

_编辑注：本文由 [Gretel](https://gretel.ai/?ref=blog.langchain.com) 团队与我们合作撰写。我们对其将基于智能体（agent）的方法、大语言模型（LLMs）与合成数据相结合，从而实现无需 SQL 即可对数据库和数据仓库进行自然语言查询的思路深感振奋。本文还提供了极具实操价值的分步指南（含完整代码！），助您真切理解并落地这些理念。_

Agent-based approaches coupled with large language models (LLMs) are quickly transforming how we interact with databases and data warehouses. Combined, these technologies enable natural language queries to data in your application or business, eliminating the need for SQL expertise to interact with data and even facilitating seamless queries across diverse systems.

基于智能体（agent）的方法与大语言模型（LLMs）相结合，正迅速重塑我们与数据库及数据仓库交互的方式。二者协同，使用户能直接以自然语言向应用程序或企业数据发起查询，彻底摆脱对 SQL 专业知识的依赖，甚至还能轻松实现跨异构系统的统一查询。

In this post, we’ll walk through an example of how LangChain, LLMs (whether open-source models like Llama-2, Falcon, or API-based models from OpenAI, Google, Anthropic), and synthetic data from Gretel combine to create a powerful, privacy-preserving solution for natural language data interaction with data in databases and warehouses. We'll introduce key concepts such as Agents, LLM Chains, and synthetic data, then delve into a practical code example to bring these ideas to life.

本文中，我们将通过一个具体示例，展示 LangChain、各类大语言模型（包括开源模型如 Llama-2、Falcon，以及 OpenAI、Google、Anthropic 等提供的 API 模型）与 Gretel 提供的合成数据如何协同工作，构建一套功能强大且注重隐私保护的解决方案，实现面向数据库与数据仓库的自然语言数据交互。我们将首先介绍“智能体（Agents）”、“LLM 链（LLM Chains）”和“合成数据（synthetic data）”等核心概念，随后深入一个实际可运行的代码示例，让这些理念真正“活”起来。

## **Key technologies**

## **核心技术**

- **LLM Chains**: Frameworks such as LangChain for developing applications powered by language models by chaining them together.

- **LLM 链（LLM Chains）**：以 LangChain 为代表的框架，通过将多个语言模型调用“串联”起来，构建由语言模型驱动的应用程序。

- **Agents:** Agents use an LLM to decide what actions to take and the order to take them in, making future decisions by iteratively observing the outcome of prior actions.

- **智能体（Agents）**：智能体利用大语言模型动态决定需执行的操作及其执行顺序，并通过持续观察先前操作的结果来迭代优化后续决策。

- **Function Aware LLMs:** Certain newer LLMs (like OpenAI’s GPT-3.5-turbo-0613 and Google’s PaLM text-bison) have been fine-tuned to detect when a function should be called and respond with the inputs that should be passed to the function.

- **具备函数感知能力的 LLM（Function Aware LLMs）**：某些较新的大语言模型（例如 OpenAI 的 GPT-3.5-turbo-0613 和 Google 的 PaLM text-bison）经过专门微调，能够识别何时应调用外部函数，并准确返回所需传入该函数的参数。

- **Synthetic data:** An artificial version of the real-world created by data-aware generative models that can offer strong privacy guarantees to data. Gretel offers generative models for working with tabular data based on Transformer, GAN, and graph-based architectures.

- **合成数据（Synthetic data）**：由具备数据感知能力的生成式模型所创建的真实世界数据的人工替代版本，可为原始数据提供强有力的隐私保障。Gretel 提供了面向结构化表格数据的生成式模型，其底层架构涵盖 Transformer、GAN 及图神经网络（graph-based）等多种范式。

- **SQL Databases:** The backbone holding the data you'll be querying. For today, we’ll use a SQLite database.

- **SQL 数据库**：承载您待查询数据的核心基础设施。本文示例中，我们将使用 SQLite 数据库。

## **What is an Agent in LangChain?**

## **LangChain 中的“智能体（Agent）”是什么？**

Some applications will require not just a predetermined chain of calls to LLMs/other tools, but potentially an unknown chain that depends on the user's input, too. In these types of chains, there is an “agent” that has access to a suite of tools — for example math, or the ability to query a SQL database. Depending on the user input, the agent can then decide which, if any, of these tools to call.

某些应用场景不仅需要预设好的 LLM 或其他工具调用链，更可能要求一条随用户输入动态生成、事先无法穷举的调用路径。在这一类链式流程中，“智能体（agent）”便应运而生——它被赋予一组可用工具（例如数学计算模块，或查询 SQL 数据库的能力）。智能体将根据用户输入，自主判断是否调用工具，以及具体调用哪一个。

Under the hood, the LangChain SQL Agent uses a [MRKL](https://arxiv.org/abs/2205.00445?ref=blog.langchain.com) (pronounced Miracle)-based approach, and queries the database schema and example rows and uses these to generate SQL queries, which it then executes to pull back the results you're asking for.

LangChain 的 SQL 智能体在底层采用一种基于 [MRKL](https://arxiv.org/abs/2205.00445?ref=blog.langchain.com)（读作 “Miracle”）的方法：它首先查询数据库的表结构（schema）与若干样例数据行，再据此自动生成 SQL 查询语句，并最终执行该语句，返回您所请求的结果。

## **Generating synthetic tabular data**

## **生成合成结构化表格数据**

Before diving into the example, let's talk about synthetic data. With Gretel's models, you can make an artificial but statistically similar version of your sensitive data. This synthetic data is safe to use, thanks to math-backed privacy features like [differential privacy](https://gretel.ai/blog/introducing-gretel-tabular-dp?ref=blog.langchain.com). In our example, we'll use both real and synthetic data to show why this privacy is crucial when letting language models access sensitive info.

在进入具体示例之前，我们先来谈谈合成数据。借助 Gretel 的模型，您可以生成一份人工构造、但统计特性与原始敏感数据高度一致的数据副本。得益于差分隐私（[differential privacy](https://gretel.ai/blog/introducing-gretel-tabular-dp?ref=blog.langchain.com)）等由严谨数学理论支撑的隐私增强技术，该合成数据可安全用于各类场景。在本文示例中，我们将同时使用真实数据与合成数据，直观展现：当语言模型需要访问敏感信息时，此类隐私保护机制为何至关重要。

To generate your own synthetic data for this example, grab the [IBM HR Employee Attrition dataset](https://gretel-public-website.s3.us-west-2.amazonaws.com/datasets/ibm_hr_attrition/ibm-hr-employee-attrition.csv?ref=blog.langchain.com) (or your own) and an API key from [https://console.gretel.ai](https://console.gretel.ai/?ref=blog.langchain.com). You can run Gretel's [quickstart notebook](https://docs.gretel.ai/examples/synthesize-tabular-data?ref=blog.langchain.com) or console-based workflow to create a synthetic version of the data.

为本示例生成您自己的合成数据，请下载 [IBM HR 员工流失数据集](https://gretel-public-website.s3.us-west-2.amazonaws.com/datasets/ibm_hr_attrition/ibm-hr-employee-attrition.csv?ref=blog.langchain.com)（或您自己的数据集），并从 [https://console.gretel.ai](https://console.gretel.ai/?ref=blog.langchain.com) 获取一个 API 密钥。您可以运行 Gretel 提供的 [快速入门 Notebook](https://docs.gretel.ai/examples/synthesize-tabular-data?ref=blog.langchain.com)，或使用基于控制台的工作流，来创建该数据的合成版本。

For this example, I used the Gretel Tabular DP model ( [notebook](https://github.com/gretelai/gretel-blueprints/blob/main/docs/notebooks/create_synthetic_data_with_tabular_dp.ipynb?ref=blog.langchain.com), [docs](https://docs.gretel.ai/reference/synthetics/models/gretel-tabular-dp?ref=blog.langchain.com)) with an epsilon value of 5 for strong privacy guarantees that are great for regulated environments. For maximum accuracy while still maintaining privacy, you can also try the Gretel ACTGAN model ( [docs](https://docs.gretel.ai/reference/synthetics/models/gretel-actgan?ref=blog.langchain.com)), which excels at working with highly dimensional tabular data to enable machine learning and analytics use cases.

在本示例中，我使用了 Gretel Tabular DP 模型（[Notebook](https://github.com/gretelai/gretel-blueprints/blob/main/docs/notebooks/create_synthetic_data_with_tabular_dp.ipynb?ref=blog.langchain.com)，[文档](https://docs.gretel.ai/reference/synthetics/models/gretel-tabular-dp?ref=blog.langchain.com)），设置 epsilon 值为 5，以提供强隐私保障，特别适用于受监管环境。若希望在保持隐私的同时实现最高精度，您还可尝试 Gretel ACTGAN 模型（[文档](https://docs.gretel.ai/reference/synthetics/models/gretel-actgan?ref=blog.langchain.com)），该模型擅长处理高维表格数据，可有效支撑机器学习与数据分析等应用场景。

### **Getting started: Installation**

### **入门指南：安装**

Follow along with our complete [notebook in Colab](https://colab.research.google.com/gist/zredlined/f84c50771245ec15993b44f846c9cd0e/safely-query-enterprise-databases-with-langchain-openai-and-gretel-ai.ipynb?ref=blog.langchain.com#scrollTo=ySD3ANEsCLw-) or [GitHub](https://gist.github.com/zredlined/f84c50771245ec15993b44f846c9cd0e?ref=blog.langchain.com).

请参考我们完整的 [Colab Notebook](https://colab.research.google.com/gist/zredlined/f84c50771245ec15993b44f846c9cd0e/safely-query-enterprise-databases-with-langchain-openai-and-gretel-ai.ipynb?ref=blog.langchain.com#scrollTo=ySD3ANEsCLw-) 或 [GitHub Gist](https://gist.github.com/zredlined/f84c50771245ec15993b44f846c9cd0e?ref=blog.langchain.com)。

First, install dependencies.

首先，安装依赖项。

```
!pip install -Uqq langchain openai gretel-client
!pip install -Uqq smart_open tabulate
```

```
!pip install -Uqq langchain openai gretel-client
!pip install -Uqq smart_open tabulate
```

### **Initializing the LangChain Agent**

### **初始化 LangChain Agent**

Note: Please use your OpenAI key for this, which should be kept private.

注意：请在此处使用您自己的 OpenAI 密钥，并务必妥善保管、切勿泄露。

Here's the code to initialize the LangChain Agent and connect it to your SQL database.

以下是初始化 LangChain Agent 并将其连接至您的 SQL 数据库的代码。

```
from langchain.agents import AgentExecutor, create_sql_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain.agents.agent_types import AgentType
from langchain.chat_models import ChatOpenAI
from langchain.llms.openai import OpenAI
from langchain.sql_database import SQLDatabase
```

```
from langchain.agents import AgentExecutor, create_sql_agent
from langchain.agents.agent_toolkits import SQLDatabaseToolkit
from langchain.agents.agent_types import AgentType
from langchain.chat_models import ChatOpenAI
from langchain.llms.openai import OpenAI
from langchain.sql_database import SQLDatabase
```

```python
def create_agent(
    db_uri,
    agent_type=AgentType.OPENAI_FUNCTIONS,
    verbose=VERBOSE_LANGCHAIN,
    temperature=0,
    model="gpt-3.5-turbo-0613",
 ):
    db = SQLDatabase.from_uri(db_uri)
    toolkit = SQLDatabaseToolkit(db=db, llm=OpenAI(temperature=temperature))


    return create_sql_agent(
        llm=ChatOpenAI(temperature=temperature, model=model),
        toolkit=toolkit,
        verbose=verbose,
        agent_type=agent_type,
    )
```

```python
def create_agent(
    db_uri,
    agent_type=AgentType.OPENAI_FUNCTIONS,
    verbose=VERBOSE_LANGCHAIN,
    temperature=0,
    model="gpt-3.5-turbo-0613",
 ):
    db = SQLDatabase.from_uri(db_uri)
    toolkit = SQLDatabaseToolkit(db=db, llm=OpenAI(temperature=temperature))


    return create_sql_agent(
        llm=ChatOpenAI(temperature=temperature, model=model),
        toolkit=toolkit,
        verbose=verbose,
        agent_type=agent_type,
    )
```

Here, we are also importing some sample datasets. We'll use both a real and a synthetic version of the IBM attrition HR dataset. The synthetic version is generated using Gretel's Tabular DP model with an (ε) Epsilon of 5.

此处，我们还导入了一些示例数据集。我们将同时使用 IBM 员工流失（Attrition）HR 数据集的真实版本和合成版本。该合成版本由 Gretel 的 Tabular DP 模型生成，隐私预算（ε，Epsilon）设为 5。

```
# Create SQLite databases from CSV datasets
create_sqlite_db_from_csv(
    SYNTHETIC_DATA, db_name="synthetic-sqlite.db", table_name="synthetic_ibm_attrition"
)
create_sqlite_db_from_csv(
    REAL_DATA, db_name="real-sqlite.db", table_name="real_ibm_attrition"
)


# Create SQL agent to interact with synthetic IBM attrition data
agent_synthetic_db = create_agent("sqlite:////content/synthetic-sqlite.db")


# Create SQL agent to interact with real-world IBM attrition data
agent_real_db = create_agent("sqlite:////content/real-sqlite.db")
```

```
# 从 CSV 数据集创建 SQLite 数据库
create_sqlite_db_from_csv(
    SYNTHETIC_DATA, db_name="synthetic-sqlite.db", table_name="synthetic_ibm_attrition"
)
create_sqlite_db_from_csv(
    REAL_DATA, db_name="real-sqlite.db", table_name="real_ibm_attrition"
)


# 创建 SQL Agent 以与合成版 IBM 员工流失数据交互
agent_synthetic_db = create_agent("sqlite:////content/synthetic-sqlite.db")


# 创建 SQL Agent 以与真实世界中的 IBM 员工流失数据交互
agent_real_db = create_agent("sqlite:////content/real-sqlite.db")
```

### **Querying the data**

### **查询数据**

First, we'll create a helper function to compare the outputs of real data and synthetic data.

首先，我们将创建一个辅助函数，用于对比真实数据与合成数据在查询输出上的差异。

```
def run_and_compare_queries(synthetic, real, query: str):
    """Compare outputs of Langchain Agents running on real vs. synthetic data"""
    query_template = f"{query} Execute all necessary queries, and always return results to the query, no explanations or apologies please. Word wrap output every 50 characters."


    result1 = synthetic.run(query_template)
    result2 = real.run(query_template)
```

```
def run_and_compare_queries(synthetic, real, query: str):
    """对比在真实数据与合成数据上运行的 LangChain Agent 的输出结果"""
    query_template = f"{query} 执行所有必要的查询，并始终将查询结果直接返回，无需解释或致歉。每 50 个字符自动换行。"


    result1 = synthetic.run(query_template)
    result2 = real.run(query_template)
```

```python
    print("=== Comparing Results for Query ===")
    print(f"Query: {query}")


    table_data = [\
        {"From Agent on Synthetic DB": result1, "From Agent on Real DB": result2}\
    ]


    print(tabulate(table_data, headers="keys", tablefmt="pretty"))
```

```python
    print("=== 比较查询结果 ===")
    print(f"查询语句：{query}")


    table_data = [\
        {"合成数据库代理返回结果": result1, "真实数据库代理返回结果": result2}\
    ]


    print(tabulate(table_data, headers="keys", tablefmt="pretty"))
```

### **示例查询**

### **示例查询**

**哪三个部门的员工流失率最高？**

**哪三个部门的员工流失率最高？**

```
prompt = "Which 3 departments have the highest attrition rates? Return a list please."
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

```
prompt = "哪三个部门的员工流失率最高？请以列表形式返回。"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_001.png)_图 1. 查询 #1 在真实数据与合成数据上的结果对比。_

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_001.png)_Figure 1. Comparing real and synthetic results for query #1._

合成数据集与真实数据集的结果高度相似，增强了我们对合成数据可靠性的信心。

The results were quite similar between the synthetic and real datasets, giving us confidence in the synthetic data's reliability.

**整个数据集中，按每十年为一个区间，各年龄段的人数分布情况如何？**

**What is the distribution of ages by 10-year increments across the entire dataset?**

```
prompt = "Show me a distribution of ages by 10 year increments. Return in list format please."
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

```
prompt = "请展示整个数据集中按每十年为一个区间的年龄分布情况，并以列表形式返回。"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_002.jpg)

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_002.jpg)

Again, the distributions were notably similar between the synthetic and real data sets.

再次，合成数据集与真实数据集的分布表现出显著的相似性。

**Which department travels the furthest from home?**

**哪个部门的员工通勤距离最远？**

```
prompt = "Which department travels the furthest from home?"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

```
prompt = "Which department travels the furthest from home?"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_003.png)_Figure 3. Comparing real and synthetic results for query #3._

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_003.png)_图 3：查询 #3 的真实结果与合成结果对比。_

In this case, we get a perfect match.

本例中，我们得到了完全一致的结果。

## **Importance of privacy: Re-identification attack example**

## **隐私保护的重要性：重识别攻击示例**

Here, we illustrate a "re-identification attack" where vulnerabilities in even de-identified datasets can allow an attacker to re-identify individuals by combining known attributes. Such risks emphasize the danger of sharing data stripped of direct identifiers yet containing attributes that, when combined, can lead to identification — such as the combination of an attacker who knew someone’s age, gender, and department in the example below.

此处我们演示一种“重识别攻击”（re-identification attack）：即使经过匿名化处理的数据集，仍可能存在漏洞，使攻击者通过组合若干已知属性（例如下文示例中攻击者已知某人的年龄、性别及所属部门），重新识别出具体个体。此类风险凸显了如下问题的严重性——即在移除直接标识符（如姓名、身份证号）后，若数据仍保留若干准标识符（quasi-identifiers），当这些属性被交叉比对时，便可能重新定位到特定个人。

Synthetic data prevents direct linking of individual information as no record in the output is based on a single user’s data, effectively thwarting re-identification attacks and upholding privacy.

合成数据可避免个体信息被直接关联，因为其输出中的每一条记录均非源自某单一用户的真实数据，从而有效抵御重识别攻击，切实保障隐私安全。

```
prompt = "Is there an employee who is Age 46, Female, and who works in Human Resources. If so, what is their monthly income, performance rating, and years since their last promotion?"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

```
prompt = "Is there an employee who is Age 46, Female, and who works in Human Resources. If so, what is their monthly income, performance rating, and years since their last promotion?"
run_and_compare_queries(synthetic=agent_synthetic_db, real=agent_real_db, query=prompt)
```

![](images/how-to-safely-query-enterprise-data-with-langchain-agents-sql-openai-gretel/img_004.png)

## **Conclusion**

## **结语**

By using synthetic data, you not only protect privacy but also gain actionable insights—essential for any data-driven organization. When you blend this with agent-based approaches and large language models, you open the door for more and better stakeholder collaborations. No SQL expertise needed; simply use natural language to engage with your data across all levels of your organization.

借助合成数据，您不仅能够保护隐私，还能获得可落地的业务洞见——这对任何以数据为驱动的组织而言都至关重要。当您将合成数据与基于智能体（agent）的方法及大语言模型相结合时，便为更广泛、更深入的利益相关方协作打开了大门。无需掌握 SQL 技能；只需使用自然语言，即可在组织各个层级便捷地与数据交互。

This scalable solution democratizes data access and ushers in a new era of smart, privacy-conscious data interaction. For businesses eager to maintain a competitive edge in today's data-centric world, adopting these technologies isn't just an option; it's a must.

这一可扩展的解决方案让数据访问真正实现普惠化，并引领我们迈入一个智能化、注重隐私保护的数据交互新纪元。对于渴望在当今以数据为中心的世界中保持竞争优势的企业而言，采用这些技术已不再是一种选择，而是一项必然之举。

If you're ready to up your data game, [sign up for Gretel today](https://gretel.ai/signup?ref=blog.langchain.com) and start synthesizing.

如果您已准备好全面提升您的数据能力，请[立即注册 Gretel](https://gretel.ai/signup?ref=blog.langchain.com)，开启数据合成之旅。
&#123;% endraw %}
