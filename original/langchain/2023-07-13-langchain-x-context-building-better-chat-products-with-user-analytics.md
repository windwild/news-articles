---
title: "LangChain x Context: Building Better Chat Products With User Analytics"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-x-context-building-better-chat-products-with-user-analytics/"
date: "2023-07-13"
scraped_at: "2026-03-03T09:32:38.742445208+00:00"
language: "en"
translated: false
---

**Today we’re announcing a** [**Langchain integration**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com) **for** [**Context**](http://getcontext.ai/?ref=blog.langchain.com). This integration allows builders of Langchain chat products to receive user analytics with a one line plugin.

Building compelling chat products is hard. Developers need a deep understanding of user behaviour and user goals to iteratively improve their products. Common questions that builders ask include: _**how are people using my product? How well is my product meeting user needs?**_ And _**where does my product need improvement?**_

Today, answering these questions can involve reading thousands of chat transcripts captured in logs, with little tooling to help identify conversation themes or areas of weak product performance. A better solution now exists with Langchain’s integration with Context.

## What is Context?

**Context is a product analytics platform for LLM-powered chat products.** Context gives builders visibility into how real people use their chat products, with analytics to help developers understand:

- **How people are using their products**, by automatically clustering conversations into groups and tracking user-defined conversation topics,
- **How their product is meeting user needs**, by reporting user satisfaction, sentiment, and regeneration rates for each conversation topics,
- **Where their product is introducing risk,** by monitoring discussion of risky topics like politics or gambling:
- **Exactly what users are discussing**, by providing filtering and search over transcripts to allow debugging


These analytics give builders an understanding of how people are using their product, how their product is performing, and where sensitive topics are being discussed. This user understanding helps ensure user needs are being met, and allows developers to improve their products over time.

## Getting Started

To get started, [Context](http://getcontext.ai/?ref=blog.langchain.com) can be accessed for free [here](http://getcontext.ai/?ref=blog.langchain.com), and the Context x LangChain documentation can be accessed [here](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com). The first 50 signups using _LANGCHAIN100_ promo code will receive 3 free months of Context’s $100/month membership tier.

## Installation and Setup

To get started with the Context LangChain integration, install the Context Python package:

**`pip install context-python --upgrade`**

**Getting API Credentials** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#getting-api-credentials)

To get your Context API token:

1. Go to the settings page within your Context account ( [https://go.getcontext.ai/settings](https://go.getcontext.ai/settings?ref=blog.langchain.com)).
2. Generate a new API Token.
3. Store this token somewhere secure.


**Setup Context** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#setup-context)

To use the ContextCallbackHandler, import the handler from Langchain and instantiate it with your Context API token.

Ensure you have installed the context-python package before using the handler.

```
import os

from langchain.callbacks import ContextCallbackHandler

token = os.environ["CONTEXT_API_TOKEN"]

context_callback = ContextCallbackHandler(token)
```

## Usage

**Using the Context callback within a Chat Model** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#using-the-context-callback-within-a-chat-model)

The Context callback handler can be used to directly record transcripts between users and AI assistants.

**Example** [**​**](https://python.langchain.com/docs/modules/callbacks/integrations/context?ref=blog.langchain.com#example)

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



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/langchain-x-context-building-better-chat-products-with-user-analytics/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)