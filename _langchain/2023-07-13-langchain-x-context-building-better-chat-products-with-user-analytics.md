---
title: "LangChain x Context: Building Better Chat Products With User Analytics"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-x-context-building-better-chat-products-with-user-analytics/"
date: "2023-07-13"
scraped_at: "2026-03-03T09:32:38.742445208+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**Today we’re announcing a** [**Langchain integration**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com) **for** [**Context**](http://getcontext.ai/?ref=blog.langchain.com). This integration allows builders of Langchain chat products to receive user analytics with a one line plugin.

**今天，我们正式宣布推出** [**LangChain 集成**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com) **，支持** [**Context**](http://getcontext.ai/?ref=blog.langchain.com)。该集成使 LangChain 聊天应用的构建者仅需一行插件代码，即可获取用户行为分析数据。

Building compelling chat products is hard. Developers need a deep understanding of user behaviour and user goals to iteratively improve their products. Common questions that builders ask include: _**how are people using my product? How well is my product meeting user needs?**_ And _**where does my product need improvement?**_

打造出色的聊天类产品极具挑战性。开发者需要深入理解用户行为与用户目标，才能持续迭代优化产品。构建者常提出的典型问题包括：_**用户如何使用我的产品？我的产品在多大程度上满足了用户需求？**_ 以及 _**我的产品在哪些方面亟待改进？**_

Today, answering these questions can involve reading thousands of chat transcripts captured in logs, with little tooling to help identify conversation themes or areas of weak product performance. A better solution now exists with Langchain’s integration with Context.

目前，回答这些问题往往意味着要人工审阅日志中记录的数千条聊天记录，而可用的工具却十分有限，难以自动识别对话主题或产品表现薄弱的环节。如今，LangChain 与 Context 的集成为此提供了更优解决方案。

## What is Context?

## Context 是什么？

**Context is a product analytics platform for LLM-powered chat products.** Context gives builders visibility into how real people use their chat products, with analytics to help developers understand:

**Context 是一款面向大语言模型（LLM）驱动的聊天类产品的数据分析平台。** Context 为构建者提供真实用户使用其聊天产品的全景视图，并通过以下维度的数据分析，帮助开发者深入理解：

- **How people are using their products**, by automatically clustering conversations into groups and tracking user-defined conversation topics,  
- **用户如何使用其产品**：通过自动将对话聚类分组，并追踪用户自定义的对话主题；

- **How their product is meeting user needs**, by reporting user satisfaction, sentiment, and regeneration rates for each conversation topics,  
- **产品在多大程度上满足了用户需求**：针对每个对话主题，报告用户满意度、情感倾向及重生成率（regeneration rate）；

- **Where their product is introducing risk,** by monitoring discussion of risky topics like politics or gambling:  
- **产品在何处引入了风险**：通过监控涉及政治、赌博等高风险话题的讨论；

- **Exactly what users are discussing**, by providing filtering and search over transcripts to allow debugging  
- **用户究竟在讨论什么内容**：提供聊天记录的筛选与全文搜索功能，便于问题排查与调试。

These analytics give builders an understanding of how people are using their product, how their product is performing, and where sensitive topics are being discussed. This user understanding helps ensure user needs are being met, and allows developers to improve their products over time.

上述分析能力可帮助构建者全面掌握用户使用方式、产品实际表现，以及敏感话题出现的具体场景。这种对用户的深度洞察，不仅有助于确保用户需求真正得到满足，也使开发者能够长期、持续地优化产品。

## Getting Started

## 快速入门

To get started, [Context](http://getcontext.ai/?ref=blog.langchain.com) can be accessed for free [here](http://getcontext.ai/?ref=blog.langchain.com), and the Context x LangChain documentation can be accessed [here](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com). The first 50 signups using _LANGCHAIN100_ promo code will receive 3 free months of Context’s $100/month membership tier.

如需开始使用，您可免费访问 [Context](http://getcontext.ai/?ref=blog.langchain.com) 平台：[点击此处](http://getcontext.ai/?ref=blog.langchain.com)；Context × LangChain 集成文档请参见 [此处](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com)。前 50 名使用优惠码 _LANGCHAIN100_ 注册的新用户，将获赠 Context 高级会员（$100/月）为期三个月的免费使用权。

## Installation and Setup

## 安装与配置

To get started with the Context LangChain integration, install the Context Python package:

开始使用 Context 与 LangChain 的集成前，请安装 Context Python 包：

**`pip install context-python --upgrade`**

**`pip install context-python --upgrade`**

**Getting API Credentials** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#getting-api-credentials)

**获取 API 凭据** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#getting-api-credentials)

To get your Context API token:

要获取您的 Context API Token，请按以下步骤操作：

1. Go to the settings page within your Context account ( [https://go.getcontext.ai/settings](https://go.getcontext.ai/settings?ref=blog.langchain.com)).
2. Generate a new API Token.
3. Store this token somewhere secure.

1. 访问您 Context 账户内的设置页面（[https://go.getcontext.ai/settings](https://go.getcontext.ai/settings?ref=blog.langchain.com)）。
2. 生成一个新的 API Token。
3. 将该 Token 储存在安全的位置。

**Setup Context** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#setup-context)

**配置 Context** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#setup-context)

To use the ContextCallbackHandler, import the handler from Langchain and instantiate it with your Context API token.

如需使用 `ContextCallbackHandler`，请从 LangChain 导入该处理器，并使用您的 Context API Token 进行实例化。

Ensure you have installed the context-python package before using the handler.

请确保在使用该处理器前，已安装 `context-python` 包。

```
import os

from langchain.callbacks import ContextCallbackHandler
```

```python
token = os.environ["CONTEXT_API_TOKEN"]

context_callback = ContextCallbackHandler(token)
```

```python
token = os.environ["CONTEXT_API_TOKEN"]

context_callback = ContextCallbackHandler(token)
```

## Usage

## 使用方法

**Using the Context callback within a Chat Model** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#using-the-context-callback-within-a-chat-model)

**在聊天模型中使用 Context 回调** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#using-the-context-callback-within-a-chat-model)

The Context callback handler can be used to directly record transcripts between users and AI assistants.

Context 回调处理器可用于直接记录用户与 AI 助手之间的对话内容。

**Example** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#example)

**示例** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#example)

```
import os

from langchain.chat_models import ChatOpenAI
from langchain.schema import (
   SystemMessage,
   HumanMessage,
)
from langchain.callbacks import ContextCallbackHandler

token = os.environ["CONTEXT_API_TOKEN"]

chat = ChatOpenAI(
   headers={"user_id": "123"}, temperature=0, callbacks=[ContextCallbackHandler(token)]
)
```

```
import os

from langchain.chat_models import ChatOpenAI
from langchain.schema import (
   SystemMessage,
   HumanMessage,
)
from langchain.callbacks import ContextCallbackHandler

token = os.environ["CONTEXT_API_TOKEN"]

chat = ChatOpenAI(
   headers={"user_id": "123"}, temperature=0, callbacks=[ContextCallbackHandler(token)]
)
```

messages = [\
   SystemMessage(\
       content="You are a helpful assistant that translates English to French."\
   ),\
   HumanMessage(content="I love programming."),\
]

print(chat(messages))
```

![](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_001.png)![](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_002.png)![](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_003.png)

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：面向 AI 应用的上下文同步高效维护**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
