---
title: "Kay x Cybersyn x LangChain: Embedding SEC Filings for RAG"
source: "LangChain Blog"
url: "https://blog.langchain.com/kay-x-cybersyn-x-langchain/"
date: "2023-10-03"
scraped_at: "2026-03-03T08:39:24.349441986+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written by the [Kay](https://www.kay.ai/?ref=blog.langchain.com) team, in collaboration with [Cybersyn](https://www.cybersyn.com/?ref=blog.langchain.com)._

_编辑注：本文由 [Kay](https://www.kay.ai/?ref=blog.langchain.com) 团队撰写，并与 [Cybersyn](https://www.cybersyn.com/?ref=blog.langchain.com) 联合发布。_

Financial data processing is hard. [SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com) on LangChain– Powered by Kay and Cybersyn–makes it easy for developers to retrieve context from SEC Filings for their generative and conversational agents.

金融数据处理非常困难。LangChain 上的 [SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com)（由 Kay 和 Cybersyn 提供技术支持）让开发者能够轻松地从美国证券交易委员会（SEC）备案文件中检索上下文，从而赋能其生成式与对话式智能体。

Financial documents carry a wealth of nuanced information that is frequently used in high-stakes scenarios, from investing to corporate strategy. [SEC Filings](https://www.sec.gov/edgar/searchedgar/companysearch?ref=blog.langchain.com) are a common source of such financial knowledge for US Public Companies. Several teams are starting to tap into this unstructured data for LLM use cases, but encounter multiple challenges.

金融文档蕴含大量细致入微的信息，广泛应用于投资决策、企业战略等高风险场景。[SEC 备案文件](https://www.sec.gov/edgar/searchedgar/companysearch?ref=blog.langchain.com)是美国上市公司的常见财务知识来源。目前已有多个团队开始将此类非结构化数据用于大语言模型（LLM）相关应用，但在实践中面临诸多挑战。

- **LLMs are missing context:** LLM knowledge is as good as the last training date. Financial markets move rapidly, and developers need to leverage Retrieval Augmented Generation (RAG) to equip LLMs with up-to-date knowledge. Moreover, SEC Filings are hard to index by search engines due to their data formats. Developers then opt to train on derivative articles related to these documents, except this can overlook the source context and lesser-known companies.

- **大语言模型缺乏上下文：** LLM 的知识仅限于其最后一次训练的时间点。金融市场瞬息万变，开发者需借助检索增强生成（RAG）技术，为 LLM 注入最新知识。此外，由于 SEC 备案文件的数据格式特殊，主流搜索引擎难以对其进行有效索引。因此，开发者往往转而使用与这些文件相关的衍生报道进行训练——但这容易忽略原始文档中的关键上下文，也难以覆盖知名度较低的公司。

- **Embedding infra is evolving rapidly:** Both in terms of planning and implementation, infrastructure for RAG is difficult to get right. Developers building their own RAG pipelines are inundated with choice. There are over 50 vector stores to choose from and an ever-changing list of embedding models on the MTEB Leaderboard. There are new ways to embed and retrieve every week. Things get trickier as you try to procure more GPU capacity and set up large-scale offline batch embedding pipelines; all while trying to tame compute costs.

- **嵌入式基础设施快速演进：** 无论在规划还是实施层面，构建可靠的 RAG 基础设施都极具挑战性。自建 RAG 流水线的开发者面临海量选择：超过 50 种向量数据库可供选用，MTEB 排行榜上的嵌入模型也在持续更新；每周都有新的嵌入与检索方法涌现。当需要采购更多 GPU 算力、搭建大规模离线批量嵌入流水线时，问题将更加复杂——与此同时，还需严格控制计算成本。

- **Financial documents are complex:** In addition to extracting data from obscure data formats, financial documents also require careful processing and chunking of data. Developers need to experiment with different ways of transforming tables, determining relevant entities, and linking them to parent sections. There's a low tolerance for false positives in retrieving these documents since these numbers directly influence important decisions.

- **金融文档结构复杂：** 除需从晦涩的数据格式中提取信息外，金融文档还要求对数据进行精细处理与合理分块。开发者需反复试验表格转换方式、识别关键实体，并将其准确关联至所属章节。由于这些数字直接影响重大决策，因此在文档检索环节对误报（false positive）的容忍度极低。

Multiple teams are building this exact same pipeline in-house, driving up costs. This is where the [SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com) on LangChain comes in. Powered by Kay and Cybersyn, developers can easily retrieve context from SEC Filings for their generative and conversational agents.

多个团队正各自重复建设这一完全相同的流水线，导致研发成本不断攀升。此时，LangChain 上的 [SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com) 应运而生。在 Kay 与 Cybersyn 的联合支持下，开发者可便捷地从 SEC 备案文件中检索上下文，赋能其生成式与对话式智能体。

[Kay](https://www.kay.ai/?ref=blog.langchain.com) provides data APIs that are specifically designed for RAG. We offer fully hosted embeddings of large datasets so developers don’t have to collect data, generate embeddings, and scale retrieval. [Cybersyn](https://www.cybersyn.com/?ref=blog.langchain.com) is a data-as-a-service company delivering analytics-ready economic data on [Snowflake Marketplace](https://app.snowflake.com/marketplace?search=cybersyn&ref=blog.langchain.com). Initially focused on where businesses and consumers spend money and time, Cybersyn offers multiple data products via Snowflake, including an LLM training dataset that features SEC Filings. Kay further enriches, embeds, and sets up a semantic retrieval API for this data. In this blog, we will cover how to get started with this API and an overview of the infrastructure behind it.

[Kay](https://www.kay.ai/?ref=blog.langchain.com) 提供专为 RAG 场景设计的数据 API。我们为大型数据集提供全托管式嵌入服务，使开发者无需自行采集数据、生成嵌入向量或扩展检索能力。[Cybersyn](https://www.cybersyn.com/?ref=blog.langchain.com) 是一家数据即服务（Data-as-a-Service）公司，通过 [Snowflake Marketplace](https://app.snowflake.com/marketplace?search=cybersyn&ref=blog.langchain.com) 提供开箱即用的经济分析数据。Cybersyn 最初聚焦于企业与消费者在资金与时间上的投入分布，目前已在 Snowflake 平台上推出多款数据产品，其中包括一个以 SEC 备案文件为核心的 LLM 训练数据集。Kay 进一步对该数据集进行增强处理、向量化嵌入，并构建语义检索 API。本文将介绍如何快速上手该 API，并概览其底层基础设施架构。

## Getting Started

## 快速入门

Using Kay in LangChain is incredibly straightforward.

在 LangChain 中使用 Kay 极其简单直接。

First, [install](https://pypi.org/project/kay/0.0.3/?ref=blog.langchain.com) Kay (`pip install kay`) and get your free API key on [Kay.ai](https://kay.ai/?ref=blog.langchain.com).

第一步：[安装](https://pypi.org/project/kay/0.0.3/?ref=blog.langchain.com) Kay（`pip install kay`），并在 [Kay.ai](https://kay.ai/?ref=blog.langchain.com) 免费获取您的 API 密钥。

Second, initialize the `KayAiRetriever` with the datasets you need. Currently, we index multiple datasets related to Companies. These datasets include financial documents, press releases, engineering blogs, and more ( [docs](https://github.com/kaydotai/kay?ref=blog.langchain.com)). In this case, we'll access 10-K and 10-Qs, and retrieve the top 6 chunks for a given query.

第二步：使用您所需的数据集初始化 `KayAiRetriever`。目前，我们已对多个与企业相关的数据集完成索引，涵盖财务文档、新闻稿、工程类博客等（详见 [文档](https://github.com/kaydotai/kay?ref=blog.langchain.com)）。本例中，我们将访问 10-K 和 10-Q 文件，并针对给定查询返回最相关的前 6 个文本块。

```python
from langchain.retrievers import KayAiRetriever
```

```python
retriever = KayAiRetriever.create(dataset_id="company", data_types=["10-K", "10-Q"], num_contexts=6)
```

```python
retriever = KayAiRetriever.create(dataset_id="company", data_types=["10-K", "10-Q"], num_contexts=6)
```

From here on, it's business as usual. Plug this context into your existing prompts and pass it to your favorite LLM. Here's a sample query that really highlights the power of embedded SEC data.

接下来一切照旧：将此上下文注入您现有的提示词（prompts），然后传递给您最喜爱的大语言模型（LLM）。以下是一个示例查询，充分展现了嵌入式美国证券交易委员会（SEC）数据的强大能力。

```python
**Question**: What are patterns in Nvidia's financial performance over the past three quarters?

**Answer**: Based on the provided financial statements, here are some patterns in NVIDIA's financial performance over the past three quarters:

1. Cash Flows from Operating Activities: The net cash provided by operating activities has shown a consistent increase over the three quarters. It was $1,874 million in Q1 2023, $1,731 million in Q2 2023, and $1,288 million in Q3 2023.

2. Cash Flows from Investing Activities: The net cash provided by investing activities has fluctuated significantly. In Q1 2023, it was $2,612 million, indicating a positive cash flow. However, in Q2 2023, it was negative with a cash outflow of $8,244 million. In Q3 2023, it turned positive again with a cash inflow of $7,378 million.

3. Cash Flows from Financing Activities: The net cash provided by financing activities has also shown variation. In Q1 2023, it was $4,146 million, indicating a positive cash flow. In Q2 2023, it was negative with a cash outflow of $9,961 million. In Q3 2023, it remained negative but decreased to $2,610 million.

4. Acquisitions and Investments: NVIDIA has made acquisitions and investments in all three quarters, but the amounts have varied. In Q1 2023, the net cash used in investing activities was $1,272 million. In Q2 2023, it was a significant cash outflow of $8,244 million. In Q3 2023, it turned positive with a cash inflow of $7,378 million.

5. Payments related to Repurchases of Common Stock: NVIDIA made significant payments related to repurchases of common stock in Q2 2023, with a cash outflow of $8,826 million. This suggests a focus on returning value to shareholders through stock buybacks.

These patterns indicate fluctuations in cash flows from investing and financing activities, while operating cash flows have remained relatively stable. Acquisition and investment activities have also contributed to the variations in cash flows. Additionally, NVIDIA's focus on returning value to shareholders is evident through payments related to repurchases of common stock.
```

```python
**问题**：英伟达（NVIDIA）过去三个季度的财务表现呈现哪些趋势？

**回答**：根据所提供的财务报表，英伟达过去三个季度的财务表现呈现以下趋势：

1. **经营活动产生的现金流量**：经营活动产生的净现金流在三个季度中持续增长。2023年第一季度为18.74亿美元，第二季度为17.31亿美元，第三季度为12.88亿美元。

2. **投资活动产生的现金流量**：投资活动产生的净现金流波动显著。2023年第一季度为26.12亿美元（正值，即现金流入）；第二季度转为负值，现金流出达82.44亿美元；第三季度再度转正，现金流入为73.78亿美元。

3. **筹资活动产生的现金流量**：筹资活动产生的净现金流亦呈现变化。2023年第一季度为41.46亿美元（正值）；第二季度为负值，现金流出达99.61亿美元；第三季度仍为负值，但收窄至26.10亿美元。

4. **收购与投资活动**：英伟达在三个季度均进行了收购与投资，但金额差异较大。2023年第一季度投资活动使用的净现金为12.72亿美元；第二季度大幅增至82.44亿美元现金流出；第三季度则转为73.78亿美元现金流入。

5. **普通股回购相关付款**：英伟达于2023年第二季度就普通股回购支付了高达88.26亿美元的现金，表明公司正通过股票回购积极向股东返还价值。

综上，上述趋势反映出英伟达在投资与筹资活动中的现金流波动较大，而经营活动现金流则保持相对稳定；收购与投资行为亦是导致现金流变动的重要因素；此外，通过普通股回购向股东返还价值的战略意图亦十分明确。
```

In contrast, try the same query with search-enabled LLMs like ChatGPT, Bard, or Perplexity. Kay captures a lot more nuance, since we pre-embed all this data and tailor our retrieval for each dataset and use case. This includes data enrichment, state-of-the-art embeddings, query understanding, and many other topics covered in the infrastructure section below.

相比之下，尝试使用支持搜索功能的大语言模型（如 ChatGPT、Bard 或 Perplexity）执行相同的查询。Kay 能够捕捉到远为丰富的语义细节，因为我们预先对所有数据进行了嵌入，并针对每个数据集和具体应用场景定制了检索策略。这涵盖了数据增强、业界领先的嵌入技术、查询理解，以及下文“基础设施”章节中介绍的诸多其他主题。

## **Use cases**

## **应用场景**

SEC Filings are large, unstructured documents. They capture crucial information about US public companies. In the past, all this data was squeezed into a few rigid tables, making most practitioners miss valuable signals from these files. Now, we can enable analysts, auditors, investors, executives, sales, and marketing teams to parse this information in seconds. Here are a few examples of how users are already utilizing this data.

美国证券交易委员会（SEC）申报文件是篇幅庞大、结构松散的文档，其中蕴含着关于美国上市公司的关键信息。过去，这些数据被强行压缩进少数几个僵化的表格中，导致大多数从业者无法从这些文件中挖掘出有价值的信息线索。如今，我们可帮助分析师、审计师、投资者、企业高管、销售及市场团队在数秒内解析此类信息。以下是一些用户当前已实际应用该数据的示例。

**Analyzing Financial Performance**

**财务表现分析**

_"Show me the revenue growth trend of Company X over the past five years."_

“请展示公司 X 过去五年的营收增长趋势。”

_"Compare the debt-to-equity ratios of Company A and Company B."_

“请对比公司 A 与公司 B 的资产负债率。”

**Identifying Sales Opportunities**

**识别销售机会**

_"Which new hardware products did Company X release this year?" "Summarize Company A's strategic direction and their expansion plans."_

“公司 X 今年发布了哪些新型硬件产品？”“请概述公司 A 的战略方向及其扩张计划。”

**Monitoring Industry Trends**

**监测行业趋势**

_"What are some key market trends Company X is tapping into?" "Identify differences in positioning between Company A and Company B."_  

“公司 X 正在切入哪些关键市场趋势？”“请指出公司 A 与公司 B 在市场定位上的差异。”

**Compliance Research**

**合规研究**

_"How is Company X adapting to recent GDPR guidelines?" "What are the potential risks associated with the acquisition of Company A?"_

“公司X如何适应最新的GDPR指南？”“收购公司A可能带来哪些潜在风险？”

## **Behind the Scenes: Infrastructure**

## **幕后揭秘：基础设施**

RAG systems consist of three essential components: data, representation, and retrieval. In this scenario, data is typically represented as embeddings. The decisions we make regarding these components directly impact performance. At Kay, we care a lot about these choices and constantly stay up to date with the latest techniques. The diagram below depicts some of the key processes within each component. Let's break that down

RAG 系统由三个核心组件构成：数据（data）、表征（representation）和检索（retrieval）。在本场景中，数据通常以嵌入向量（embeddings）形式表示。我们针对这些组件所作的决策将直接影响系统性能。在 Kay，我们高度重视这些技术选型，并持续跟进业界最新方法。下方图示展示了各组件内部若干关键处理流程。下面我们逐一解析：

![](images/kay-x-cybersyn-x-langchain-embedding-sec-filings-for-rag/img_001.png)

### **Collecting data**

### **数据采集**

The foundation of our system is high-quality data. All US public companies submit their mandatory filings through SEC's Electronic Data Gathering, Analysis, and Retrieval (EDGAR) system. While this data is available via an API, it can be challenging to process and embed this due to its varied data formats. This is where Cybersyn steps in.

我们系统的基石是高质量的数据。所有美国上市公司均须通过美国证券交易委员会（SEC）的电子数据收集、分析与检索系统（EDGAR）提交法定申报文件。尽管该数据可通过 API 获取，但因其格式高度多样化（如 PDF、TXT、XBRL 等），直接处理与嵌入面临较大挑战。此时，Cybersyn 的价值便凸显出来。

Cybersyn builds derived data products from proprietary and public datasets that are difficult to procure, clean, or join. One of their data products is [LLM Training Essentials](https://app.snowflake.com/marketplace/listing/GZTSZ290BUX1X/cybersyn-inc-cybersyn-llm-training-essentials?utm_source=Twitter&utm_medium=organic%20social&utm_campaign=LLM_8.7&utm_id=Twitter_LLM), which includes SEC Filings along with several other government datasets. This brings us several benefits:

Cybersyn 从难以获取、清洗或关联的专有及公开数据集出发，构建高附加值的衍生数据产品。其代表性产品之一是 [LLM Training Essentials](https://app.snowflake.com/marketplace/listing/GZTSZ290BUX1X/cybersyn-inc-cybersyn-llm-training-essentials?utm_source=Twitter&utm_medium=organic%20social&utm_campaign=LLM_8.7&utm_id=Twitter_LLM)，该产品不仅涵盖 SEC 申报文件，还整合了多项其他政府公开数据集。这为我们带来了以下显著优势：

- Cybersyn converts unstructured TXT and XBRL data into a relational database, eliminating the need to set up your own OCR and text extraction pipelines from Filing PDFs.

- Cybersyn 将非结构化的 TXT 和 XBRL 数据统一转换为关系型数据库格式，从而免去了用户自行搭建 PDF 申报文件 OCR 识别与文本提取流水线的繁琐工作。

- They also provide additional metadata that helps users join companies with common company identifiers including CIK, EIN, LEI, PermID, and OpenFIGI. This proves useful down the line for retrieval.

- Cybersyn 还提供丰富的附加元数据，支持用户基于通用企业标识符（如 CIK、EIN、LEI、PermID 和 OpenFIGI）实现跨公司数据关联，这对后续的精准检索至关重要。

- This data is then loaded onto the Snowflake Marketplace. Snowflake ensures secure and fully-governed access to this data, allowing users to read and interact with it using SQL queries. This significantly improves ease of access.

- 此数据随后被部署至 Snowflake Marketplace。Snowflake 提供安全、全治理的数据访问机制，用户可直接通过标准 SQL 查询读取并交互式分析该数据，极大提升了数据获取与使用的便捷性。

- Cybersyn also takes responsibility for regularly updating this data, recognizing its time-sensitive nature for use cases involving SEC data.

- Cybersyn 还承担该数据的定期更新职责——充分认识到 SEC 数据在时效性方面的关键要求，确保数据始终处于最新状态。

Working with Cybersyn and Snowflake has significantly contributed to Kay's data quality, accessibility, and reliability. We highly recommend exploring all of their data products.

与 Cybersyn 及 Snowflake 的合作，显著提升了 Kay 在数据质量、可访问性与可靠性方面的综合能力。我们诚挚推荐您深入了解 Cybersyn 全系列数据产品。

### **Generating embeddings**

### **生成嵌入向量**

Once we have raw text data, we start data enrichment. We focus on creating two types of metadata.

在获得原始文本数据后，我们即启动数据增强（data enrichment）流程。我们的重点是构建两类元数据：

- Company Metadata: We source company information such as ticker symbol, industry, location, summary, website, and more. This data helps us normalize and group companies for efficient retrieval.  
- 公司元数据（Company Metadata）：我们采集公司相关信息，例如股票代码（ticker symbol）、所属行业、所在地、公司简介、官网网址等。此类数据有助于我们对公司进行标准化处理与聚类，从而提升检索效率。

- Document Metadata: We also extract information specific to each document such as different sections, all mentions of time and date, and significant entities with NER. This metadata further enhances retrieval. Some of this gets embedded with the chunk and others are used in filtering.  
- 文档元数据（Document Metadata）：我们还从每份文档中提取特定信息，包括不同章节结构、所有时间与日期提及、以及通过命名实体识别（NER）提取的重要实体。这些元数据进一步提升了检索质量。其中一部分会与文本块（chunk）一同嵌入，另一部分则用于后续的过滤操作。

Next step is choosing an embedding model. First, we quickly decided to move away from OpenAI embedding APIs to self-hosting open-source models. OSS embedding models are state of the art, give full control on scaling, are a lot cheaper and open up fine-tuning capabilities down the line. This was essential for us to iterate fast and be able to scale later. Amongst OSS models, after internal evaluation of different use cases for this dataset, we landed on `gte-base` which is one of the top models on the current [leaderboard](https://huggingface.co/spaces/mteb/leaderboard?ref=blog.langchain.com).

下一步是选择嵌入模型。我们迅速决定放弃 OpenAI 的嵌入 API，转而自托管开源嵌入模型（OSS embedding models）。当前主流的开源嵌入模型性能卓越，可完全掌控扩展策略、成本显著更低，并为后续微调（fine-tuning）预留了空间。这对实现快速迭代与未来规模化部署至关重要。在对本数据集多种使用场景进行内部评估后，我们最终选定 `gte-base` 模型——该模型目前位居 [MTEB 排行榜](https://huggingface.co/spaces/mteb/leaderboard?ref=blog.langchain.com) 前列。

To handle SEC data, we implement dynamic variable chunking based on sections, ensuring that the chunk size is limited to an average of 1500 characters using sentences. We handle chunks with tables differently by having a LLM summarize them in natural language. At the end of this process, we have all the data and the tools to start chunking and embedding. For offline batch embedding jobs, we leveraged [Ray](https://www.anyscale.com/ray-open-source?ref=blog.langchain.com)'s parallelization framework. Ray has been easy to set up, does the job, and has reliable support. It enabled us to chunk and embed over 20 million embeddings in under 15 minutes.

为处理美国证券交易委员会（SEC）数据，我们采用基于文档章节的动态可变分块策略，以句子为单位控制每个文本块长度，确保平均字符数不超过 1500。对于含表格的文本块，则交由大语言模型（LLM）生成自然语言摘要进行特殊处理。至此，我们已具备全部数据及相应工具，可正式开展分块与嵌入工作。针对离线批量嵌入任务，我们采用了 [Ray](https://www.anyscale.com/ray-open-source?ref=blog.langchain.com) 并行化框架。Ray 部署简便、功能可靠，且拥有稳定的技术支持，使我们得以在 15 分钟内完成超过 2000 万个嵌入向量的分块与生成。

Finally, we push the generated embeddings into a vector database. We use HNSW for vector indexing and BM25 for text indexing, which is fairly standard for these data types. One notable observation was that several vector stores perform simultaneous write and indexing operations, resulting in a significant decrease in write throughput. To address this issue, we highly recommend transitioning to incremental indexing.

最后，我们将生成的嵌入向量写入向量数据库。我们采用 HNSW 算法进行向量索引，BM25 算法进行文本索引——这是处理此类数据的常规实践。一个值得注意的现象是：多个向量数据库在执行写入操作的同时同步构建索引，导致写入吞吐量显著下降。为此，我们强烈建议改用增量式索引（incremental indexing）策略。

### Optimizing Retrieval

### 检索优化

Retrieval goes beyond making a default call to your vector store. There's a lot we can do to decrease the candidate set and rank chunks better. In this component, we aim to make the retrieval process as accurate and efficient as possible.

检索远不止于向向量数据库发起一次默认查询。我们可通过多种手段缩小候选结果集、更精准地对文本块排序。本模块的目标，正是让整个检索过程兼具高准确性与高效率。

First, we build our own Query Intent Classifier (QIC) powered by LLMs. Given a query, this extracts all the entities that can either help us filter chunks on our metadata or get us some new information that validates hybrid search. This is where we force the LLM for structured output (s/o [Instructor](https://github.com/jxnl/instructor?ref=blog.langchain.com)).  We also run sanity checks on the final response with string matching libraries to not miss out on entities that might exist in our metadata, for example. nike and nike inc. Turns out normalization itself for each metadata is a massive internal effort to do right.

首先，我们基于大语言模型（LLM）自主研发了查询意图分类器（Query Intent Classifier, QIC）。给定用户查询，QIC 可提取所有潜在实体——这些实体既可用于基于元数据的文本块过滤，也可提供新信息以验证混合检索（hybrid search）的有效性。在此环节，我们强制要求 LLM 输出结构化结果（参见 [Instructor](https://github.com/jxnl/instructor?ref=blog.langchain.com)）。此外，我们还借助字符串匹配库对最终输出执行合理性校验（sanity check），避免遗漏元数据中可能存在的实体（例如：“nike” 和 “nike inc.”）。事实上，针对每一类元数据实施标准化处理本身，就是一项庞大而关键的内部工程。

In addition to the classifier, we have also begun generating hallucinated search queries to conduct retrieval over, and to vote on the most relevant answers. While this has latency costs, this is an ongoing experiment to see how this improves accuracy.

除上述分类器外，我们还开始尝试生成“幻觉式”搜索查询（hallucinated search queries）并据此执行检索，再通过投票机制选出最相关的答案。尽管该方法会带来一定延迟开销，但目前仍是一项持续进行的实验，旨在评估其对检索准确率的实际提升效果。

After obtaining a collection of search queries along with relevant filters, we initiate the retrieval process by narrowing down potential candidates using these filters.  
在获取一组搜索查询及相应过滤条件后，我们通过这些过滤条件缩小候选结果范围，从而启动检索流程。

Next, we dynamically select between vector search and hybrid search, depending on the presence of any significant entities identified by QIC that warrant a keyword search. For vector search, we go with the default cosine distance.  
接下来，我们根据 QIC 识别出的重要实体是否存在（这些实体值得触发关键词搜索）来动态选择向量搜索或混合搜索。对于向量搜索，我们采用默认的余弦距离（cosine distance）。

Once we have our top-k retrieved chunks, we apply Cohere's Re-rank and take log of the context relevancy score. These scores help us set up our human evaluation task to unpack how users can intuitively reason through these scores. In the interim, we continue experiments to keep improving the distribution of context relevancy scores.  
在获得前 k 个检索结果片段（chunks）后，我们应用 Cohere 的重排序（Re-rank）功能，并对上下文相关性得分（context relevancy score）取对数。这些得分有助于我们设计人工评估任务，以深入探究用户如何直观地理解并推理这些分数。在此期间，我们持续开展实验，不断优化上下文相关性得分的分布。

### Resources and next steps  
### 资源与后续步骤

RAG is obviously an evolving process that requires consistent commitment to optimization. Our motive for sharing how we approach this stack is to bring more transparency, share our learnings, and welcome feedback so we can continue improving retrieval for public datasets. The strategies we use are not set in stone and we'd love for you to try our SEC retriever and share what you think. Happy to chat and share notes at [cal.com/kaydotai/chat](http://cal.com/kaydotai/chat?ref=blog.langchain.com).  
RAG 显然是一项持续演进的工作，需要长期投入以不断优化。我们分享这套技术栈实践方式的初衷，是提升透明度、共享经验教训，并诚挚欢迎反馈，以便我们持续改进面向公共数据集的检索效果。我们所采用的策略并非一成不变；我们非常期待您试用我们的 SEC 检索器（SEC Retriever），并告诉我们您的想法。欢迎随时通过 [cal.com/kaydotai/chat](http://cal.com/kaydotai/chat?ref=blog.langchain.com) 预约交流、分享笔记。

Here’s some resources to dive in further  
以下是一些可供深入探索的资源：

- [SEC Retriever](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com) on LangChain  
- LangChain 上的 [SEC 检索器（SEC Retriever）](https://python.langchain.com/docs/integrations/retrievers/sec_filings?ref=blog.langchain.com)

- Cybersyn’s [LLM Training Essentials](https://app.snowflake.com/marketplace/listing/GZTSZ290BUX1X/cybersyn-inc-cybersyn-llm-training-essentials?utm_source=Twitter&utm_medium=organic+social&utm_campaign=LLM_8.7&utm_id=Twitter_LLM)  
- Cybersyn 推出的 [大语言模型训练必备工具包（LLM Training Essentials）](https://app.snowflake.com/marketplace/listing/GZTSZ290BUX1X/cybersyn-inc-cybersyn-llm-training-essentials?utm_source=Twitter&utm_medium=organic+social&utm_campaign=LLM_8.7&utm_id=Twitter_LLM)

- [Snowflake Marketplace](https://www.snowflake.com/en/data-cloud/marketplace/?ref=blog.langchain.com)  
- [Snowflake Marketplace](https://www.snowflake.com/en/data-cloud/marketplace/?ref=blog.langchain.com)

- Kay’s [Github](https://github.com/kaydotai/kay?ref=blog.langchain.com)  
- Kay 的 [GitHub 仓库](https://github.com/kaydotai/kay?ref=blog.langchain.com)

Also, a reminder: [LangChain Users get 10,000 Free Kay Requests for next 3 Months](https://kay.ai/?ref=blog.langchain.com) ⚡️  
另外提醒一下：[LangChain 用户可享未来 3 个月内 10,000 次免费 Kay 请求额度](https://kay.ai/?ref=blog.langchain.com) ⚡️
&#123;% endraw %}
