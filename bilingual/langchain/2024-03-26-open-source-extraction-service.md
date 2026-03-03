---
title: "Open Source Extraction Service"
source: "LangChain Blog"
url: "https://blog.langchain.com/open-source-extraction-service/"
date: "2024-03-26"
scraped_at: "2026-03-03T08:05:45.589428076+00:00"
language: "en-zh"
translated: true
---

_Earlier this month we_ [_announced_](https://blog.langchain.com/use-case-accelerant-extraction-service/) _our most recent OSS use-case accelerant: a service for extracting structured data from unstructured sources, such as text and PDF documents. Today we are exposing a hosted version of the service with a simple front end. The application is free to use, but is not intended for production workloads or sensitive data. The intent is to showcase what is possible in this category in 2024, and to help developers get a running start with their own applications._

本月早些时候，我们宣布了最新的开源（OSS）用例加速器：一项从非结构化数据源（例如纯文本和 PDF 文档）中提取结构化数据的服务。今天，我们正式上线该服务的托管版本，并配备了一个简洁的前端界面。该应用可免费使用，但**不适用于生产环境负载或敏感数据处理**。其目标是展示 2024 年此类技术所能实现的能力，并帮助开发者快速启动自己的相关应用。

**Key Links:**  
**关键链接：**

- **YouTube Walkthrough:** [**https://youtu.be/-FMUt3OARy0**](https://youtu.be/-FMUt3OARy0?ref=blog.langchain.com)  
- **YouTube 演示视频：** [**https://youtu.be/-FMUt3OARy0**](https://youtu.be/-FMUt3OARy0?ref=blog.langchain.com)

- **Hosted Extraction Service:** [**https://extract.langchain.com/**](https://extract.langchain.com/?ref=blog.langchain.com)  
- **托管版提取服务：** [**https://extract.langchain.com/**](https://extract.langchain.com/?ref=blog.langchain.com)

- **GitHub Repo:** [**https://github.com/langchain-ai/langchain-extract**](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)  
- **GitHub 代码仓库：** [**https://github.com/langchain-ai/langchain-extract**](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.com)

## Why now?  
## 为何此时推出？

Structured data extraction has emerged as a valuable use case of large language models, which can reason through the ambiguities of unstructured text to coerce information into a desired schema. Model providers are increasingly supporting long context windows and function calling capabilities, both key features to data extraction. And we have recently improved LangChain’s [support for data extraction](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com), allowing developers to easily work with a variety of file types, schema formats, models, few-shot examples, and extraction methods (e.g., tool calling, JSON mode, or parsing). Hosting a reference application allows users to experiment with the latest tools for their own use-cases, and connect what they see to the underlying [OSS implementation](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev).

结构化数据提取已成为大语言模型（LLM）一项极具价值的应用场景：LLM 能够在非结构化文本的语义模糊性中进行推理，从而将信息“强制”映射到预设的结构化模式（schema）中。当前，各大模型提供商正持续增强对长上下文窗口（long context windows）和函数调用（function calling）能力的支持——而这二者恰恰是高效数据提取的关键技术基础。此外，我们近期也显著增强了 LangChain 对数据提取任务的[原生支持](https://python.langchain.com/docs/use_cases/extraction/?ref=blog.langchain.com)，使开发者能够轻松处理多种文件格式、各类 Schema 定义、不同大模型、少样本（few-shot）示例，以及多种提取方法（例如工具调用、JSON 模式输出或后处理解析）。通过提供一个参考性托管应用，用户可直接上手实验最新工具，将其应用于自身具体场景，并将所见功能与底层的[开源实现](https://github.com/langchain-ai/langchain-extract?ref=blog.langchain.dev)一一对应、深入理解。

## Features  
## 主要特性

- Support for PDF, HTML, and text;  
- 支持 PDF、HTML 和纯文本格式；

- Defining and persisting extractors with their own schema and custom instructions;  
- 可定义并持久化专属提取器（extractor），每个提取器均可配置独立的 Schema 和自定义指令；

- Adding few-shot examples for in-context learning;  
- 支持添加少样本（few-shot）示例，以增强上下文学习效果；

- Sharing extractors among users;  
- 支持用户间共享提取器；

- Swapping LLM models;  
- 支持灵活切换底层大语言模型（LLM）；

- A [LangServe](https://python.langchain.com/docs/langserve?ref=blog.langchain.com) endpoint for the core extraction logic, allowing it to be plugged into your own Langchain workflows;  
- 提供基于 [LangServe](https://python.langchain.com/docs/langserve?ref=blog.langchain.com) 的核心提取逻辑 API 端点，便于无缝集成至您自己的 LangChain 工作流中；

- A frontend that lets you define extraction schemas in natural language, share with other users, and test them on text or files (no support of few shot examples yet).  
- 前端界面支持以自然语言方式定义提取 Schema，支持与其他用户共享，并可直接在文本或文件上测试提取效果（当前暂不支持少样本示例功能）。

## Walkthrough  
## 操作演示

Let’s walk through an example, extracting financial data from a public company earnings call. Here we use the [prepared remarks from Uber’s Q4 2023 earnings call](https://s23.q4cdn.com/407969754/files/doc_earnings/2023/q4/transcript/Uber-Q4-23-Prepared-Remarks.pdf?ref=blog.langchain.com), which Uber investor relations makes available [online](https://investor.uber.com/news-events/default.aspx?ref=blog.langchain.com).

我们以一个实际案例展开演示：从某上市公司财报电话会议（earnings call）的文字记录中提取财务数据。本例采用优步（Uber）发布的 [2023 年第四季度财报电话会议准备稿](https://s23.q4cdn.com/407969754/files/doc_earnings/2023/q4/transcript/Uber-Q4-23-Prepared-Remarks.pdf?ref=blog.langchain.com)，该文档由 Uber 投资者关系部门[在线公开提供](https://investor.uber.com/news-events/default.aspx?ref=blog.langchain.com)。

Most public companies host earnings calls, providing their management opportunities to discuss past financial results and future plans. Natural language transcripts of these calls may contain useful information, but often this information must first be extracted from the document and arranged into a structured form so that it can be analyzed or compared across time periods and other companies.

绝大多数上市公司均会定期举行财报电话会议，为管理层提供阐述过往财务表现与未来战略规划的机会。这些会议的自然语言文字实录虽蕴含大量有价值的信息，但通常需先将其中关键内容从原始文档中提取出来，并整理为结构化格式，方能进一步开展分析，或跨时间周期、跨公司进行横向对比。

让我们首先获取 PDF 文件：

```
import requests

pdf_url = "https://s23.q4cdn.com/407969754/files/doc_earnings/2023/q4/transcript/Uber-Q4-23-Prepared-Remarks.pdf"

# 获取 PDF 字节流
pdf_response = requests.get(pdf_url)
assert(pdf_response.status_code == 200)
pdf_bytes = pdf_response.content
```

接下来，我们将为自己生成一个唯一标识符（UUID）。我们的应用程序不管理用户，也不包含正式的身份认证机制。对提取器（extractors）、少样本示例（few-shot examples）及其他相关资源的访问权限，均由该 ID 控制。请将其视为机密信息，并务必妥善保管，切勿丢失！

```
from uuid import uuid4

user_id = str(uuid4())
headers = {"x-key": user_id}
```

接着，我们定义待提取数据的结构（schema）。此处我们指定一个财务数据记录（Financial Data Record）。我们允许大语言模型（LLM）自行推断各类属性，例如该记录所对应的时间段。这里我们使用 Pydantic 提高可读性；但最终，后端服务实际依赖的是 JSON Schema。

```
from pydantic import BaseModel, Field

class FinancialData(BaseModel):
    name: str = Field(..., description="财务指标名称，例如 'revenue'（收入）。")
    value: float = Field(..., description="以当地货币计的名义金额。")
    scale: str = Field(..., description="数值量级单位，例如 'MM'（百万）、'B'（十亿）或 'percent'（百分比）。")
    period_start: str = Field(..., description="时间段起始日期，采用 ISO 格式。")
    period_duration: int = Field(..., description="时间段长度，单位为月。")
    evidence: str = Field(..., description="该数值在原文中出现的完整句子（逐字引用）。")
```

Note that we include an evidence attribute, which provides context for the predictions and supports downstream verification of the results.

请注意，我们包含了一个 `evidence`（证据）属性，该属性为预测结果提供上下文，并支持对结果进行下游验证。

Once we've defined our schema, we create an extractor by posting it to the application:

定义完我们的 schema 后，我们通过向应用程序发送 POST 请求来创建一个 extractor（提取器）：

```
url = "https://extract-server-f34kggfazq-uc.a.run.app"

data = {
    "user_id": user_id,
    "description": "Financial revenues and other figures.",
    "schema": FinancialData.schema(),
    "instruction": (
        "Extract standard financial figures, specifically earnings and "
        "revenue figures. Only extract historical facts, not estimates or guidance."
    )
}

response = requests.post(f"{url}/extractors", json=data, headers=headers)
extractor = response.json()
```

We’ve posted the extractor, which we can now access using its unique ID. We can now try the extractor on our PDF:

我们已成功提交该 extractor，现在可通过其唯一 ID 访问它。接下来，我们可在 PDF 文档上测试该 extractor：

```
result = requests.post(
    f"{url}/extract",
    data={"extractor_id": extractor["uuid"], "model_name": "gpt-3.5-turbo"},
    files={"file": pdf_bytes},
    headers=headers,
)

result.json()
```

And we get back:

返回结果如下：

```
{'data': [{'name': 'Adjusted EBITDA',\
   'scale': 'million',\
   'value': 1300,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'GAAP operating income',\
   'scale': 'million',\
   'value': 652,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'Revenue',\
   'scale': 'billion',\
   'value': 9.9,\
   'evidence': 'We grew our revenue by 13% YoY on a constant-currency basis to $9.9 billion.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'Adjusted EBITDA',\
   'scale': '$',\
   'value': 1.26,\
   'evidence': 'We expect Adjusted EBITDA of $1.26 billion to $1.34 billion.',\
   'period_start': '2023-01-01',\
   'period_duration': 12},\
  {'name': 'Adjusted EBITDA',\
   'scale': '$',\
   'value': 1.34,\
   'evidence': 'We expect Adjusted EBITDA of $1.26 billion to $1.34 billion.',\
   'period_start': '2023-01-01',\
   'period_duration': 12}]}
```

Note that the formatting of the result has deviated in some ways from the descriptions in the schema– for example, we output “million” and “billion” instead of “MM” or “B” as instructed. Different models will struggle with this to varying degrees. Before reaching for a larger model, a judicious choice of few-shot examples can often be an efficient way to clarify our intent. Let’s add one to our extractor:

请注意，结果的格式在某些方面偏离了模式（schema）中的描述——例如，我们输出的是“million”和“billion”，而非指令中要求的“MM”或“B”。不同模型在遵循此类格式要求时的表现各不相同，难度也各异。在转向更大规模模型之前，精心挑选若干示例（few-shot examples）往往是一种高效明确我们意图的方式。下面我们为提取器添加一个示例：

```
examples = [\
    {\
        "text": "In 2022, Revenue was $1 million and EBIT was $2M.",\
        "output": [\
            FinancialData(\
                name="revenue",\
                value=1,\
                scale="MM",\
                period_start="2022-01-01",\
                period_duration=12,\
                evidence="In 2022, Revenue was $1 million and EBIT was $2M.",\
            ).dict(),\
            FinancialData(\
                name="ebit",\
                value=2,\
                scale="MM",\
                period_start="2022-01-01",\
                period_duration=12,\
                evidence="In 2022, Revenue was $1 million and EBIT was $2M.",\
            ).dict()\
        ],\
    },\
]

responses = []
for example in examples:
    create_request = {
        "extractor_id": extractor["uuid"],
        "content": example["text"],
        "output": example['output'],
    }
    response = requests.post(f"{url}/examples", json=create_request, headers=headers)
    responses.append(response)
```

```
examples = [\
    {\
        "text": "In 2022, Revenue was $1 million and EBIT was $2M.",\
        "output": [\
            FinancialData(\
                name="revenue",\
                value=1,\
                scale="MM",\
                period_start="2022-01-01",\
                period_duration=12,\
                evidence="In 2022, Revenue was $1 million and EBIT was $2M.",\
            ).dict(),\
            FinancialData(\
                name="ebit",\
                value=2,\
                scale="MM",\
                period_start="2022-01-01",\
                period_duration=12,\
                evidence="In 2022, Revenue was $1 million and EBIT was $2M.",\
            ).dict()\
        ],\
    },\
]

responses = []
for example in examples:
    create_request = {
        "extractor_id": extractor["uuid"],
        "content": example["text"],
        "output": example['output'],
    }
    response = requests.post(f"{url}/examples", json=create_request, headers=headers)
    responses.append(response)
```

Here we add a single example that contains two records, with updated casing for the “name” field and formatting of the “scale” field. Re-running the extraction on the document, we recover the intended formatting:

此处我们添加了一个仅含两条记录的示例，其中“name”字段采用了更新后的大小写格式（如小写），且“scale”字段严格按要求使用“MM”等缩写形式。再次对文档执行提取操作后，我们成功恢复了预期的格式：

```
result = requests.post(
    f"{url}/extract",
    data={"extractor_id": extractor["uuid"], "model_name": "gpt-3.5-turbo"},
    files={"file": pdf_bytes},
    headers=headers,
)

result.json()
```

```
result = requests.post(
    f"{url}/extract",
    data={"extractor_id": extractor["uuid"], "model_name": "gpt-3.5-turbo"},
    files={"file": pdf_bytes},
    headers=headers,
)

result.json()
```

And we get:

输出结果如下：

```
{'data': [{'name': 'adjusted ebitda',\
   'scale': 'MM',\
   'value': 1300.0,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'gaap operating income',\
   'scale': 'MM',\
   'value': 652.0,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'gross bookings',\
   'scale': 'B',\
   'value': 37.6,\
   'evidence': 'Gross Bookings growth accelerated to 21% YoY on a constant-currency basis (23% excluding Freight), as we generated Gross Bookings of $37.6 billion.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'revenue',\
   'scale': 'B',\
   'value': 9.9,\
   'evidence': 'We grew our revenue by 13% YoY on a constant-currency basis to $9.9 billion.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'adjusted ebitda',\
   'scale': 'B',\
   'value': 1.3,\
   'evidence': 'We expect Adjusted EBITDA of $1.26 billion to $1.34 billion.',\
   'period_start': '2023-01-01',\
   'period_duration': 12}],
 'content_too_long': False}
```

```
{'data': [{'name': 'adjusted ebitda',\
   'scale': 'MM',\
   'value': 1300.0,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'gaap operating income',\
   'scale': 'MM',\
   'value': 652.0,\
   'evidence': 'These strong top-line trends, combined with continued rigor on costs, translated to $1.3 billion in Adjusted EBITDA and $652 million in GAAP operating income.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'gross bookings',\
   'scale': 'B',\
   'value': 37.6,\
   'evidence': 'Gross Bookings growth accelerated to 21% YoY on a constant-currency basis (23% excluding Freight), as we generated Gross Bookings of $37.6 billion.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'revenue',\
   'scale': 'B',\
   'value': 9.9,\
   'evidence': 'We grew our revenue by 13% YoY on a constant-currency basis to $9.9 billion.',\
   'period_start': '2023-10-01',\
   'period_duration': 3},\
  {'name': 'adjusted ebitda',\
   'scale': 'B',\
   'value': 1.3,\
   'evidence': 'We expect Adjusted EBITDA of $1.26 billion to $1.34 billion.',\
   'period_start': '2023-01-01',\
   'period_duration': 12}],
 'content_too_long': False}
```

### LangServe client

### LangServe 客户端

A final note: because we’ve hosted the core extraction logic with LangServe, we can access it via the [RemoteRunnable](https://python.langchain.com/docs/langserve?ref=blog.langchain.com#client) interface and plug it into larger chains and agent workflows.

最后补充一点：由于我们已将核心提取逻辑部署在 LangServe 上，因此可通过 [RemoteRunnable](https://python.langchain.com/docs/langserve?ref=blog.langchain.com#client) 接口调用该服务，并将其无缝集成至更复杂的链式流程（chains）或智能体（agent）工作流中。

The [runnable](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com) can be invoked in the usual way:

[runnable](https://python.langchain.com/docs/expression_language/interface?ref=blog.langchain.com) 可以像通常一样被调用：

```
from langserve import RemoteRunnable

runnable = RemoteRunnable(f"{url}/extract_text/")
response = runnable.invoke(
    {
        "text": "Our 2023 revenue was $100.",
        "schema": FinancialData.schema(),
    }
)
print(response)
```

```
from langserve import RemoteRunnable

runnable = RemoteRunnable(f"{url}/extract_text/")
response = runnable.invoke(
    {
        "text": "Our 2023 revenue was $100.",
        "schema": FinancialData.schema(),
    }
)
print(response)
```

And we get:

我们得到如下输出：

```
{'data': [{'name': 'revenue',\
   'value': 100,\
   'scale': '$',\
   'period_start': '2023-01-01',\
   'period_duration': 12,\
   'evidence': 'Our 2023 revenue was $100.'}]}
```

```
{'data': [{'name': 'revenue',\
   'value': 100,\
   'scale': '$',\
   'period_start': '2023-01-01',\
   'period_duration': 12,\
   'evidence': 'Our 2023 revenue was $100.'}]}
```

Or below, we incorporate it into a retrieval scenario. Here, instead of extracting directly on the input, we index some documents and treat the input as a search query. Searching for “rev”, below, will retrieve a document containing revenue and restrict the extraction to it:

或者，如下所示，我们将它整合进一个检索场景中。此处，我们并不直接在输入文本上执行抽取，而是先对若干文档建立索引，并将输入视为搜索查询。例如，下方搜索关键词 “rev”，将检索到一条包含 “revenue” 的文档，并将抽取操作限定于该文档内：

```
from operator import itemgetter

from langchain_community.vectorstores import FAISS
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import OpenAIEmbeddings

doc_contents = ["Our 2023 revenue was $100", "Our Q1 profit was $10 in 2023."]
vectorstore = FAISS.from_texts(doc_contents, embedding=OpenAIEmbeddings())
retriever = vectorstore.as_retriever()

larger_runnable = (
    {
        "text": itemgetter("text") | retriever | (lambda docs: docs[0].page_content),  # fetch content of top doc,
        "schema": itemgetter("schema"),
    }
    | runnable
)
larger_runnable.invoke({"text": "rev", "schema": FinancialData.schema()})
```

```
from operator import itemgetter

from langchain_community.vectorstores import FAISS
from langchain_core.runnables import RunnablePassthrough
from langchain_openai import OpenAIEmbeddings

doc_contents = ["Our 2023 revenue was $100", "Our Q1 profit was $10 in 2023."]
vectorstore = FAISS.from_texts(doc_contents, embedding=OpenAIEmbeddings())
retriever = vectorstore.as_retriever()

larger_runnable = (
    {
        "text": itemgetter("text") | retriever | (lambda docs: docs[0].page_content),  # fetch content of top doc,
        "schema": itemgetter("schema"),
    }
    | runnable
)
larger_runnable.invoke({"text": "rev", "schema": FinancialData.schema()})
```

Which yields:

其结果为：

```
{'data': [{'name': 'revenue',\
   'value': 100,\
   'scale': '$',\
   'period_start': '2023-01-01',\
   'period_duration': 12,\
   'evidence': 'Our 2023 revenue was $100'}]}
```

We are excited to see what extraction workflows you build, and welcome both feedback on and contributions to LangChain’s extraction capabilities!

我们非常期待看到您构建的各类信息抽取工作流，也诚挚欢迎您就 LangChain 的抽取能力提供反馈或贡献代码！