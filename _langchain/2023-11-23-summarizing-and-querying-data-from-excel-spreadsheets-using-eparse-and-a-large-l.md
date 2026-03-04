---
title: "Summarizing and Querying Data from Excel Spreadsheets Using eparse and a Large Language Model"
source: "LangChain Blog"
url: "https://blog.langchain.com/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-language-model/"
date: "2023-11-23"
scraped_at: "2026-03-03T08:23:46.507150719+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written by_ [_Chris Pappalardo_](https://www.linkedin.com/in/chris-a-pappalardo/?ref=blog.langchain.com) _, a Senior Director at Alvarez & Marsal, a leading global professional services firm. The standard processes for building with LLM work well for documents that contain mostly text, but do not work as well for documents that contain tabular data (like spreadsheets). We wrote about our_ [_latest thinking on Q&A over csvs_](https://blog.langchain.com/benchmarking-question-answering-over-csv-data/) _on the blog a couple weeks ago, and we loved reading Chris's exploration of working with csvs and_ [_LangChain_](https://www.langchain.com/?ref=blog.langchain.com) _using agents, chains, RAG, and metadata. Lots of great learnings in here!_

编辑者注：本文由 Alvarez & Marsal（一家全球领先的专业服务公司）高级总监 [_Chris Pappalardo_](https://www.linkedin.com/in/chris-a-pappalardo/?ref=blog.langchain.com) 撰写。目前基于大语言模型（LLM）的标准构建流程在处理以纯文本为主的文档时效果良好，但在处理以表格数据为主（例如电子表格）的文档时则表现欠佳。我们几周前曾在博客上发布过一篇关于 [_CSV 数据问答（Q&A）最新思考_](https://blog.langchain.com/benchmarking-question-answering-over-csv-data/) 的文章；而 Chris 探索如何结合智能体（agents）、链（chains）、检索增强生成（RAG）及元数据等技术来处理 CSV 文件与 [_LangChain_](https://www.langchain.com/?ref=blog.langchain.com) 的实践，令我们深受启发——其中蕴含大量宝贵经验！

When I first sat down to write [eparse](https://github.com/ChrisPappalardo/eparse?ref=blog.langchain.com), the objective was to create a library that could crawl and parse a large set of Excel files and extract information in context into storage for later consumption. To this end, we were fairly successful – eparse can extract sub-tabular information using a rules-based search algorithm and store labeled cells as rows in a database. Assuming the user has a good idea of what is contained in the source files, SQL queries or the eparse CLI can be used to retrieve specific data.

最初着手开发 [eparse](https://github.com/ChrisPappalardo/eparse?ref=blog.langchain.com) 时，我的目标是构建一个能够遍历并解析大量 Excel 文件、并在上下文中提取信息、最终存入数据库以供后续使用的库。从这一目标来看，我们取得了相当程度的成功：eparse 可借助基于规则的搜索算法提取子表格信息，并将带有标签的单元格以行的形式存入数据库。只要用户对源文件所含内容有较清晰的认知，即可通过 SQL 查询或 eparse 命令行工具（CLI）精准获取所需数据。

However, document Extraction, Transformation, and Loading (“ETL”) activities are becoming more generative AI-oriented to facilitate activities like document summarization and Retrieval-Augmented Generation (“RAG”). Given that most documents in question mostly contain text, which Large Language Models (“LLMs”) are well suited for, many of the ETL tools were built for this case. A typical “quickstart” workflow for these purposes is as follows:

然而，如今文档的抽取、转换与加载（“ETL”）任务正日益转向生成式 AI 驱动模式，以更好地支持文档摘要生成、检索增强生成（“RAG”）等应用场景。由于待处理的大多数文档以文本为主，而大语言模型（“LLMs”）恰恰擅长处理此类文本，因此当前多数 ETL 工具正是为此类场景而设计。典型的一键启动（“quickstart”）工作流如下所示：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_001.png)Figure 1 - Typical AI-oriented ETL Workflow (source: langchain.com).

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_001.png)图 1 — 典型的 AI 导向型 ETL 工作流（来源：langchain.com）。

The process begins with using an ETL tool set like [unstructured](https://github.com/Unstructured-IO/unstructured?ref=blog.langchain.com), which identifies the document type, extracts content as text, cleans the text, and returns one or more text elements. A second library, in this case [langchain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com), will then “chunk” the text elements into one or more documents that are then stored, usually in a vectorstore such as [Chroma](https://github.com/chroma-core/chroma?ref=blog.langchain.com). Finally, an LLM can be used to query the vectorstore to answer questions or summarize the content of the document.

该流程始于使用 [unstructured](https://github.com/UnStructured-IO/unstructured?ref=blog.langchain.com) 等 ETL 工具套件：它首先识别文档类型，再将内容提取为纯文本、清理文本噪声，并返回一个或多个文本片段。随后，第二类库（此处为 [langchain](https://github.com/langchain-ai/langchain?ref=blog.langchain.com)）会将这些文本片段“切分”（chunk）为一个或多个文档，并通常将其存入向量数据库（vectorstore），例如 [Chroma](https://github.com/chroma-core/chroma?ref=blog.langchain.com)。最后，可调用大语言模型（LLM）查询该向量数据库，以回答问题或生成文档摘要。

**This process works well for documents that contain mostly text. It does not work well for documents that contain mostly tabular data, such as spreadsheets.**

**该流程在处理以文本为主的文档时效果良好；但在处理以表格数据为主的文档（如电子表格）时则表现不佳。**

To better understand this problem, let’s consider an example. In the eparse code repository there is a unit test data file called [eparse\_unit\_test\_data.xlsx](https://github.com/ChrisPappalardo/eparse?ref=blog.langchain.com) which contains the following sub-tables, each with different types of financial data:

为更深入理解这一问题，我们来看一个具体示例。在 eparse 代码仓库中，存在一个单元测试数据文件：[eparse\_unit\_test\_data.xlsx](https://github.com/ChrisPappalardo/eparse?ref=blog.langchain.com)，其中包含以下若干子表格，各自承载不同类型的财务数据：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_002.png)Figure 2 - Financial Statement Data by Date with Duplicate Columns![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_003.png)Figure 3 - Principal Repayment Schedules for Multiple Unidentified Debt Instruments

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_002.png)图 2 — 按日期列示的财务报表数据（含重复列）  
![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_003.png)图 3 — 多项未指明债务工具的本金偿还计划表

For this demonstration, I wrote a Gradio app to display the extracted and chunked text data so it is easier to figure out what the libraries are doing behind the scenes. If we use unstructured and langchain without any modifications, the ETL workflow would produce text chunks from this file that look as follows:

为便于演示，我编写了一个 Gradio 应用，用于直观展示经抽取与切分后的文本数据，从而更清晰地揭示底层库的实际运作机制。若直接使用未经任何定制的 unstructured 和 langchain，该 ETL 工作流将从上述 Excel 文件中生成如下形式的文本块：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_004.png)Figure 4 - Extracted Data from Figure 2 Spreadsheet Table in Gradio

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_004.png)图 4 — Gradio 中显示的图 2 所示电子表格表格的抽取结果

Unstructured produces a single text element which LangChain chunks up into 14 pieces, with the 3rd piece (“3 – Document”) containing the first sub-table I depicted above. Each cell in this table is a separate line, and the 3rd piece contains about 40 lines, which is not the entire table.

Unstructured 生成一个单一的文本元素，LangChain 将其切分为 14 个片段，其中第 3 个片段（“3 – Document”）包含了上文所示的第一个子表格。该表格中的每个单元格均独占一行，而第 3 个片段共包含约 40 行，尚未涵盖整个表格。

When I first tried to ask an LLM to summarize the document using the vectorstore, I received a context window overrun error due to the number of tokens (loosely words) exceeding the LLM’s context window size (in this case 2k tokens). This is a common problem with working with LLMs, which I will touch on later in the article. So, to handle that problem, I used a larger context window LLM running on a bigger server and extended the API timeout to 10 minutes. This time we get a decent result:

当我首次尝试借助向量数据库（vectorstore）让大语言模型（LLM）对文档进行摘要时，由于 token 数量（粗略等价于单词数）超出了 LLM 的上下文窗口容量（本例中为 2,000 tokens），我收到了“上下文窗口溢出”（context window overrun）错误。这是使用 LLM 时的常见问题，本文后文将对此展开讨论。为解决该问题，我改用具备更大上下文窗口的 LLM，并将其部署在更高配置的服务器上，同时将 API 超时时间延长至 10 分钟。此次我们得到了一个较为合理的结果：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_005.png)Figure 5 - Summarization Using a Large Context LLM with a Default Implementation

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_005.png)图 5 —— 使用大上下文窗口 LLM 及默认实现方式生成的摘要

With default implementations, the LLM understood some aspects of the file but did not get a good general sense of the content. Also, the amounts are off, the loan amount appears to be 10x higher than the amount in the file, ignores the other loans, and the LLM is misunderstanding the unformatted Excel date value (a 44,621 day maturity would be 122+ years).

在默认实现下，LLM 理解了文件的部分内容，但未能准确把握整体主旨。此外，金额数据存在明显偏差：贷款金额被误判为文件中实际数值的 10 倍；其余贷款信息则被完全忽略；同时，LLM 还错误解读了 Excel 中未经格式化的日期值（例如，将到期日“44,621 天”理解为距今 122 年以上）。

**How does eparse perform on the same task?**

**eparse 在同一任务上的表现如何？**

eparse does things a little differently. Instead of passing entire sheets to LangChain, eparse will find and pass sub-tables, which appears to produce better segmentation in LangChain. Using eparse, LangChain returns 9 document chunks, with the 2nd piece (“2 – Document”) containing the entire first sub-table. Asking the LLM to summarize the spreadsheet using these vectors produces a more comprehensive view of what is contained in the spreadsheet, including the nuances of the sub-tables, and without any erroneous data.

eparse 的处理方式略有不同：它不会将整张工作表直接传给 LangChain，而是先识别并提取子表格（sub-tables），再将这些子表格分别传入——这种做法在 LangChain 中实现了更优的文本分块效果。采用 eparse 后，LangChain 返回 9 个文档片段，其中第 2 个片段（“2 – Document”）完整包含了第一个子表格。基于这些向量让 LLM 对电子表格进行摘要，所得结果能更全面、准确地反映表格内容，包括各子表格间的细微差异，且未引入任何错误数据。

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_006.png)Figure 6 - Summarization Using eparse and Sub-table Chunking

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_006.png)图 6 —— 使用 eparse 与子表格分块方式生成的摘要

However, the LLM gets sidetracked by pedantic things like row structure on a single table, and still gets basic questions about amounts incorrect:

然而，LLM 仍会因一些琐碎细节（例如单个表格内的行结构）而分心，且对金额等基础问题的回答依然不准确：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_007.png)

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_007.png)

And the dates are still in the wrong format:

且日期格式仍未得到正确解析：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_008.png)

**一种更优的方法。**

**一种更优的方法。**

回顾一下，使用 unstructured、eparse 和 LangChain 的默认实现将 Excel 文件直接输入大语言模型（LLM）时，存在以下问题，这也反映了当前这些工具的实际能力局限：

- Excel 工作表被整体当作单个表格传入，而默认的分块（chunking）策略会破坏数据内在的逻辑结构；
- 较大的文本块会给上下文窗口长度、GPU 显存及超时设置等资源约束带来压力；
- 逻辑结构被破坏，加之默认的检索策略，导致生成的摘要不完整；
- LLM 在向量化数据上执行离散值查找（discrete value lookup）时性能较差；
- 默认的数据清洗流程无法处理某些特定问题，例如 Excel 中以数值形式编码的日期。

摘要生成（summarization）的根本挑战在于：它是一种从“多”到“一”的信息压缩过程。而在单文档检索式问答（Q&A）应用的默认配置中，系统通常先检索出文档中语义最相近的 4 个片段，再将它们全部“填充”（stuff）进上下文窗口，最后请求模型生成摘要。

为提升电子表格数据的检索与摘要性能，我们需要探索其他检索策略。Damien Benveniste 最近在 LinkedIn 上发布了一张示意图，专门探讨如何对超出上下文窗口容量的多个大型文档进行摘要处理：

通过在我的 Gradio 应用中新增“链类型（chain type）”、“搜索类型（search type）”和“检索文档数（k-documents）”三项可调参数，我现在能够针对不同大语言模型，在多种配置下分别测试上述各类策略：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_009.png)图 8 —— 新增链类型、搜索类型与检索文档数选项

将链类型设为“映射-归约（map reduce）”（即图 7 中所示的第二种策略），并增加检索文档数量，可显著提升摘要质量：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_010.png)图 9 —— 基于 10 个表格元素的映射-归约式摘要

The LLM hits on all major themes in the various extracted sub-tables, acknowledges the instrument type in the document (debt), and even mentions the amortization schedule. All sans nonsensical data elements.

大语言模型（LLM）准确覆盖了各个提取出的子表格中的所有核心主题，识别出文档中所涉金融工具的类型（债务类），甚至提到了摊销计划表。整个过程未引入任何无意义的数据元素。

Turning on chain verbosity, we can get an idea of what is happening behind the scenes (apologies for the small text):

启用链式调用的详细日志输出（verbosity），我们可以一窥其后台运行机制（文字较小，敬请谅解）：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_011.png)Figure 10 – The Final Prompt in the Map Reduce Chain

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_011.png)图10 — Map-Reduce 链中的最终提示词（Prompt）

Each extracted sub-table is being summarized by the LLM before it is injected into a final prompt for a collective summary at the end, just like the map-reduce diagram depicts. Expanding the K-document size ensures that smaller nuances of the file are considered.

每个提取出的子表格均先由大语言模型单独生成摘要，再将这些摘要注入最终提示词中，以生成整体性汇总——这正与 Map-Reduce 架构图所示意的过程完全一致。增大 K-document（即参与聚合的文档数量）可确保文件中更细微的特征也被纳入考量。

You may be wondering about the “refine” strategy and perhaps wonder what happened to the small context model we started with. I tried various strategies and combinations with the smaller model including refine and, while I was able to eventually deal with the context window limitation, that model with and without the refine strategy just did not deliver quality responses. I believe this result is the combination of a worse foundational model and 8-bit quantization. Bottom line is that it pays to have at least one LLM running on outsized hardware with a solid foundation to test against.

您或许会好奇“refine”（精炼）策略的具体作用，也可能在疑惑：我们最初选用的小上下文窗口模型后来去哪了？我曾尝试多种策略及组合（包括 refine 策略）来适配该小型模型；虽然最终勉强克服了上下文窗口长度的限制，但无论是否启用 refine 策略，该模型始终无法产出高质量响应。我认为这一结果源于两方面因素：基础模型本身性能较弱，加之采用了 8-bit 量化压缩。归根结底，为保障评估基准的可靠性，至少应部署一个运行于高性能硬件之上、具备坚实基础能力的大语言模型。

**What about specific data retrieval?**

**那么，如何实现特定数据的精准提取呢？**

The solution to the problem of extracting specific data from spreadsheet tables using an LLM will involve the Agent design pattern, where LLMs are taught to use functions that they can call. The demonstration of agents is beyond the scope of this article. However, we recently added something to eparse that will assist in this effort that I am excited to share.

利用大语言模型从电子表格中精准提取特定数据的解决方案，将采用 Agent（智能体）设计模式——即训练大语言模型学会调用外部函数。Agent 的具体演示已超出本文范围。不过，我们近期在 eparse 中新增了一项功能，我非常高兴在此与您分享。

In version 0.7.0 of eparse we introduced utility functions and a new interface to seamlessly transition from HTML tables to an eparse data interface backed by Sqlite. What this means is that users can interface their LLMs to structured table data captured by the ETL process, which is stored as metadata in the objects that are uploaded to vector storage. For example, the following HTML table was generated as a by-product from eparsing the unit test spreadsheet:

在 eparse 0.7.0 版本中，我们引入了实用函数及一套全新接口，支持从 HTML 表格无缝过渡至基于 SQLite 的 eparse 数据接口。这意味着：用户可让大语言模型直接对接 ETL 流程所捕获的结构化表格数据——这些数据作为元数据，被存储于上传至向量数据库的对象之中。例如，以下 HTML 表格即为对单元测试用电子表格执行 eparsing 后自动生成的副产品：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_012.png)Figure 11 - HTML Tabular Metadata

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_012.png)图11 — HTML 表格元数据

To facilitate an ETL pipeline powered by eparse, a drop-in replacement of the unstructured auto partitioner and the Excel partitioner are provided starting with v0.7.1 (see the README for more details on how to incorporate these functions into your project):

为构建由 eparse 驱动的 ETL 流水线，自 v0.7.1 版本起，我们提供了非结构化自动分块器（unstructured auto partitioner）与 Excel 分块器（Excel partitioner）的即插即用式替代方案（有关如何将这些函数集成至您项目中的详细说明，请参阅项目 README 文件）。

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_013.png)  
图 12 —— 使用 eparse 构建的、面向非结构化数据的自定义 Excel 分区器（Custom Excel Partitioner for Unstructured Using eparse）

在 LLM 链（LLM chain）中结合智能体工具（agent tools）使用 HTML 表格数据，只需实例化以下全新的 HTML 接口，之后即可像使用任何其他数据库 ORM 那样调用它：

![](images/summarizing-and-querying-data-from-excel-spreadsheets-using-eparse-and-a-large-l/img_014.png)  
图 13 —— eparse 的 HTML 表格数据接口（eparse HTML Tabular Data Interface）

**那么，如何处理 Excel 中数值格式数据（例如日期）的转换？**

针对 Excel 数值型日期等信息需重新格式化为标准日期格式这类问题，最佳解决方案是借助 unstructured 库构建一个自定义的数据清洗（cleaning）或数据暂存（staging）模块（brick）。有关清洗模块及其应用方法的详细说明，请参见 [此处](https://unstructured-io.github.io/unstructured/bricks.html?ref=blog.langchain.com#cleaning)。

**结论（Conclusion）**

综上所述，从 Excel 电子表格中提取信息面临诸多独特挑战——这些挑战往往未被多数 ETL 系统及常规 LLM 工具集所涵盖。在自行设计解决方案时，需重点关注以下几点：

- 电子表格在数据摄入（ingestion）与分块（chunking）环节，以及后续检索（retrieval）环节均存在特有难题；  
- 链式处理流程（chain）的选择至关重要，其默认配置通常（且往往）无法取得良好效果；  
- 大语言模型（LLMs）擅长处理文本，但不擅长直接解析结构化数据，因此你很可能需要采用智能体（agent）方案，才能从查询中获取准确结果；  
- 不同大语言模型在摘要生成（summarization）任务上的性能表现差异显著；  
- 元数据（metadata）极具价值，而你的向量数据库（vectorstore）中可能尚有大量未被充分利用的数据资源。
&#123;% endraw %}
