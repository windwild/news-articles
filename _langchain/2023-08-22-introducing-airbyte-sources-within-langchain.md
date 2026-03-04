---
title: "Introducing Airbyte sources within LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-airbyte-sources-within-langchain/"
date: "2023-08-22"
scraped_at: "2026-03-03T08:52:00.553771974+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the [Airbyte](https://airbyte.com/?ref=blog.langchain.com) team. They've made it really easy to connect even more data sources to LangChain as document loaders._

_编辑注：本文由 [Airbyte](https://airbyte.com/?ref=blog.langchain.com) 团队协作撰写。他们极大地简化了将更多数据源作为文档加载器（document loaders）接入 LangChain 的流程。_

It’s now possible to utilize the Airbyte sources for [Gong](https://python.langchain.com/docs/integrations/document_loaders/airbyte_gong?ref=blog.langchain.com), [Hubspot](https://python.langchain.com/docs/integrations/document_loaders/airbyte_hubspot?ref=blog.langchain.com), [Salesforce](https://python.langchain.com/docs/integrations/document_loaders/airbyte_salesforce?ref=blog.langchain.com), [Shopify](https://python.langchain.com/docs/integrations/document_loaders/airbyte_shopify?ref=blog.langchain.com), [Stripe](https://python.langchain.com/docs/integrations/document_loaders/airbyte_stripe?ref=blog.langchain.com), [Typeform](https://python.langchain.com/docs/integrations/document_loaders/airbyte_typeform?ref=blog.langchain.com) and [Zendesk Support](https://python.langchain.com/docs/integrations/document_loaders/airbyte_zendesk_support?ref=blog.langchain.com) directly within your LangChain-based application, implemented as [document loaders](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com).

现在，您可直接在基于 LangChain 的应用中使用 Airbyte 提供的以下数据源：[Gong](https://python.langchain.com/docs/integrations/document_loaders/airbyte_gong?ref=blog.langchain.com)、[HubSpot](https://python.langchain.com/docs/integrations/document_loaders/airbyte_hubspot?ref=blog.langchain.com)、[Salesforce](https://python.langchain.com/docs/integrations/document_loaders/airbyte_salesforce?ref=blog.langchain.com)、[Shopify](https://python.langchain.com/docs/integrations/document_loaders/airbyte_shopify?ref=blog.langchain.com)、[Stripe](https://python.langchain.com/docs/integrations/document_loaders/airbyte_stripe?ref=blog.langchain.com)、[Typeform](https://python.langchain.com/docs/integrations/document_loaders/airbyte_typeform?ref=blog.langchain.com) 和 [Zendesk Support](https://python.langchain.com/docs/integrations/document_loaders/airbyte_zendesk_support?ref=blog.langchain.com)——这些均已实现为 [文档加载器（document loaders）](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)。

For example, to load the Stripe invoices for a user, you can use the AirbyteStripeLoader. Installing it is super simple, when you have LangChain installed locally you only need to install the source you are interested in, and you are ready to go:

例如，若要加载某用户的 Stripe 发票数据，您可以使用 `AirbyteStripeLoader`。安装过程极为简单：只要本地已安装 LangChain，您只需安装所需的数据源包，即可立即开始使用：

```
pip install airbyte-source-stripe
```

```
pip install airbyte-source-stripe
```

After that, simply import the loader and pass in configuration and the stream you want to load:

随后，只需导入该加载器，并传入配置参数及希望加载的数据流（stream）名称：

```
from langchain.document_loaders.airbyte import AirbyteStripeLoader
config = {
  "client_secret": "<secret key>",
  "account_id": "<account id>",
  "start_date": "<date from which to start retrieving records from in ISO format, e.g. 2020-10-20T00:00:00Z>"
}
loader = AirbyteStripeLoader(config=config, stream_name="invoices")
documents = loader.load()
# use documents in vector store or otherwise
```

```
from langchain.document_loaders.airbyte import AirbyteStripeLoader
config = {
  "client_secret": "<密钥>",
  "account_id": "<账户 ID>",
  "start_date": "<ISO 格式起始日期（例如：2020-10-20T00:00:00Z），用于指定从该时间点开始拉取记录>"
}
loader = AirbyteStripeLoader(config=config, stream_name="invoices")
documents = loader.load()
# 将 documents 用于向量数据库或其他用途
```

## Why does this matter?

## 这为何重要？

This is the beginning of making Airbyte’s [300+ sources](http://docs.airbyte.com/integrations?ref=blog.langchain.com) available as document loaders in LangChain.

这标志着 Airbyte 超过 [300 种数据源](http://docs.airbyte.com/integrations?ref=blog.langchain.com) 将陆续以文档加载器形式接入 LangChain 的开端。

Airbyte can move data from just about any source to your warehouse or vector database to power your LLM use case (check out this [tutorial](https://airbyte.com/tutorials/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain?ref=blog.langchain.com) for setting up such a data pipeline!). This is normally done by using Airbyte Cloud or a local Airbyte instance, setting up a connection, and running it on a schedule (or via API trigger) to make sure your data stays fresh.

Airbyte 可将几乎任意来源的数据同步至您的数据仓库或向量数据库，从而为大语言模型（LLM）应用场景提供数据支撑（可参考这篇 [教程](https://airbyte.com/tutorials/chat-with-your-data-using-openai-pinecone-airbyte-and-langchain?ref=blog.langchain.com)，了解如何构建此类数据流水线！）。通常，这一过程需借助 Airbyte Cloud 或本地部署的 Airbyte 实例，配置连接后按计划运行（或通过 API 触发），以确保数据持续更新。

But if you are just getting started and are running everything locally, using a full Airbyte instance (including the UI, scheduling service, scale-out capabilities, etc..) may be overkill.

但若您尚处于起步阶段，且所有组件均在本地运行，那么部署一个功能完备的 Airbyte 实例（含 Web 界面、调度服务、横向扩展能力等）可能显得过于复杂和冗余。

With this release, it’s easier than ever to run any Python-based source in LangChain directly within your Python runtime - no need to spin up an Airbyte instance or make API calls to Airbyte Cloud.

借助本次发布，您现在可以前所未有地方便地在 Python 运行时环境中直接运行 LangChain 中任意基于 Python 的数据源——无需启动 Airbyte 实例，也无需调用 Airbyte Cloud 的 API。

## Moving between hosted and embedded Airbyte

## 在托管版与嵌入式 Airbyte 之间切换

As it’s the same code running under the hood, every Airbyte-built loader is compatible with the respective source in the Airbyte service. This means it’s trivial to lift your embedded loading pipeline into your self-hosted Airbyte installation or your Airbyte Cloud instance. The shape of the configuration object and the records is 100% compatible.

由于底层运行的是同一套代码，所有由 Airbyte 构建的加载器（loader）均与 Airbyte 服务中对应的数据源完全兼容。这意味着您可以轻松地将嵌入式加载流水线迁移至自托管的 Airbyte 部署环境，或 Airbyte Cloud 实例中。配置对象的结构与记录格式 100% 兼容。

Running syncs on hosted Airbyte means:

在托管版 Airbyte 上运行同步任务意味着：

- UI 界面，用于实时跟踪正在运行的流水线  
- 同步失败时自动告警  
- 轻松按计划定时执行流水线  

Running syncs with LangChain loaders means:

使用 LangChain 加载器运行同步任务意味着：

- 无需额外部署和维护另一个服务，零运行开销  
- 对执行时机与流水线运行过程拥有完全控制权  

## Mapping Airbyte records to LangChain documents

## 将 Airbyte 记录映射为 LangChain 文档

By default, each record gets mapped to a Document as part of the loader, with all the various fields in the record becoming the metadata of the record. The text portion of the document is left as an empty string. You can pass in a record handler to customize this behavior to build the text part of a record depending on the data:

默认情况下，加载器会将每条 Airbyte 记录映射为一个 `Document` 对象，记录中的所有字段均作为该文档的元数据（metadata）；而文档的文本内容（`page_content`）则默认为空字符串。您可通过传入自定义的 `record_handler` 函数，根据实际数据灵活构造每条记录的文本内容：

```
def handle_record(record, id):
    return Document(page_content=record.data["title"], metadata=record.data)
loader = AirbyteGongLoader(config=config, record_handler=handle_record, stream_name="calls")
```

## Incremental loads

## 增量加载

Since your python application is basically acting as the Airbyte platform, you have full control over how the “sync” is executed. For example you can still benefit from [incremental syncs](https://glossary.airbyte.com/term/incremental-synchronization/?ref=blog.langchain.com) if your stream supports it by accessing the “last_state” property of the loader. This allows you to load only documents that changed since the last time you loaded, allowing you to update an existing vector database effectively:

由于您的 Python 应用本质上充当了 Airbyte 平台，因此您对“同步”（sync）的执行方式拥有完全控制权。例如，如果您的数据流支持增量同步，您仍可通过访问加载器（loader）的 `last_state` 属性来利用 [增量同步](https://glossary.airbyte.com/term/incremental-synchronization/?ref=blog.langchain.com) 功能。这使得您仅需加载自上次加载以来发生变更的文档，从而高效地更新现有向量数据库：

```
import airbyte_cdk.models.airbyte_protocol import AirbyteMessage
with open('stripe_sync_checkpoint.json', 'wb') as file:
    file.write(loader.last_state.json())

// ... later
with open('stripe_sync_checkpoint.json', 'r') as file:
    current_state = AirbyteStateMessage.parse_raw(file.read())
incremental_loader = AirbyteStripeLoader(config=config, stream_name="invoices", state=current_state)
new_docs = incremental_loader.load()
```

```
import airbyte_cdk.models.airbyte_protocol import AirbyteMessage
with open('stripe_sync_checkpoint.json', 'wb') as file:
    file.write(loader.last_state.json())

// ……稍后
with open('stripe_sync_checkpoint.json', 'r') as file:
    current_state = AirbyteStateMessage.parse_raw(file.read())
incremental_loader = AirbyteStripeLoader(config=config, stream_name="invoices", state=current_state)
new_docs = incremental_loader.load()
```

## Custom sources

## 自定义数据源

For now, the following Airbyte sources are available as pip packages (with more to come):

目前，以下 Airbyte 数据源已作为 pip 包提供（后续还将持续增加）：

- [Gong](https://python.langchain.com/docs/integrations/document_loaders/airbyte_gong?ref=blog.langchain.com) `pip install airbyte-source-gong`  
- [Hubspot](https://python.langchain.com/docs/integrations/document_loaders/airbyte_hubspot?ref=blog.langchain.com) `pip install airbyte-source-hubspot`  
- [Salesforce](https://python.langchain.com/docs/integrations/document_loaders/airbyte_salesforce?ref=blog.langchain.com) `pip install airbyte-source-salesforce`  
- [Shopify](https://python.langchain.com/docs/integrations/document_loaders/airbyte_shopify?ref=blog.langchain.com) `pip install airbyte-source-shopify`  
- [Stripe](https://python.langchain.com/docs/integrations/document_loaders/airbyte_stripe?ref=blog.langchain.com) `pip install airbyte-source-stripe`  
- [Typeform](https://python.langchain.com/docs/integrations/document_loaders/airbyte_typeform?ref=blog.langchain.com) `pip install airbyte-source-typeform`  
- [Zendesk Support](https://python.langchain.com/docs/integrations/document_loaders/airbyte_zendesk_support?ref=blog.langchain.com) `pip install airbyte-source-zendesk-support`

However, if you have implemented your own custom Airbyte sources, it’s also possible to integrate them by using the AirbyteCDKLoader base class that works with the Source interface of the Airbyte CDK:

然而，若您已开发了自己的自定义 Airbyte 数据源，也可通过使用 `AirbyteCDKLoader` 基类将其集成——该类与 Airbyte CDK 的 `Source` 接口兼容：

```
from langchain.document_loaders.airbyte import AirbyteCDKLoader
from my_source.source import MyCustomSource # plug in your own source here
config = {
   # your custom configuration
}
loader = AirbyteCDKLoader(source_class=MyCustomSource, config=config, stream_name="my-stream")
```

```
from langchain.document_loaders.airbyte import AirbyteCDKLoader
from my_source.source import MyCustomSource  # 此处替换为您自己的数据源
config = {
   # 您的自定义配置
}
loader = AirbyteCDKLoader(source_class=MyCustomSource, config=config, stream_name="my-stream")
```

You can also install sources from the main Airbyte repository by installing directly via git - for example, to fetch the Github source, simply run  

您还可以直接通过 Git 从 Airbyte 主仓库安装数据源——例如，要获取 GitHub 数据源，只需运行：

```
pip install "source_github@git+https://github.com/airbytehq/airbyte.git@master#subdirectory=airbyte-integrations/connectors/source-github"
```

```
pip install "source_github@git+https://github.com/airbytehq/airbyte.git@master#subdirectory=airbyte-integrations/connectors/source-github"
```

After that, the source is available to be plucked into the AirbyteCDKLoader:

随后，该数据源即可被接入 AirbyteCDKLoader：

```
from source_github.source import SourceGithub
issues_loader = AirbyteCDKLoader(source_class=SourceGithub, config=config, stream_name="issues")
```

```
from source_github.source import SourceGithub
issues_loader = AirbyteCDKLoader(source_class=SourceGithub, config=config, stream_name="issues")
```

Check out [the connector development documentation](https://docs.airbyte.com/connector-development/?ref=blog.langchain.com) for how to get started writing your own sources — it’s easy to get started with them and will allow you to move from local embedded loaders to using a hosted Airbyte instance seamlessly depending on your needs.

请查阅 [连接器开发文档](https://docs.airbyte.com/connector-development/?ref=blog.langchain.com)，了解如何开始编写您自己的数据源——上手非常简单，且能根据您的实际需求，无缝地从本地嵌入式加载器切换至托管的 Airbyte 实例。

## Any questions? We would love to hear from you

## 有任何问题？我们非常期待听到您的声音

If you are interested in leveraging Airbyte to ship data to your LLM-based applications, [please take a moment](https://docs.google.com/forms/d/e/1FAIpQLSduobMZwbqiFlPxsWDG-hrBw6NLYMDu_7zRfo4j7AsaO1QtfQ/viewform?usp=sf_link&_gl=1*m4v6ic*_ga*MTM4ODAyNjg4NS4xNjY5ODkyNDQ1*_ga_HDBMVFQGBH*MTY5MjM2MzY0Ni45NS4xLjE2OTIzNjU2NDUuMC4wLjA.&ref=blog.langchain.com) to fill out our survey so we can make sure to prioritize the most important features.

如果您希望借助 Airbyte 将数据输送至基于大语言模型（LLM）的应用中，[欢迎花几分钟时间](https://docs.google.com/forms/d/e/1FAIpQLSduobMZwbqiFlPxsWDG-hrBw6NLYMDu_7zRfo4j7AsaO1QtfQ/viewform?usp=sf_link&_gl=1*m4v6ic*_ga*MTM4ODAyNjg4NS4xNjY5ODkyNDQ1*_ga_HDBMVFQGBH*MTY5MjM2MzY0Ni45NS4xLjE2OTIzNjU2NDUuMC4wLjA.&ref=blog.langchain.com) 填写我们的调研问卷，以便我们优先开发最重要的功能。

If you have questions or are interested in other existing sources being exposed as loaders this way, do not hesitate to reach out on our [community slack channel](https://airbyte.com/community/community?ref=blog.langchain.com) or in the [Airbyte channel](https://discord.com/channels/1038097195422978059/1131406672972218430?ref=blog.langchain.com) on the LangChain discord server.

如果您有任何疑问，或希望将其他现有数据源以类似方式封装为加载器，请随时通过我们的 [社区 Slack 频道](https://airbyte.com/community/community?ref=blog.langchain.com) 或 LangChain Discord 服务器中的 [Airbyte 频道](https://discord.com/channels/1038097195422978059/1131406672972218430?ref=blog.langchain.com) 与我们联系。
&#123;% endraw %}
