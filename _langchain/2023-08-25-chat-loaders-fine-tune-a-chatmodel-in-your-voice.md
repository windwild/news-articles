---
render_with_liquid: false
title: "Chat Loaders: Fine-tune a ChatModel in your Voice"
source: "LangChain Blog"
url: "https://blog.langchain.com/chat-loaders-finetune-a-chatmodel-in-your-voice/"
date: "2023-08-25"
scraped_at: "2026-03-03T08:49:50.818212226+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
render_with_liquid: false
render_with_liquid: false

### Summary

### 摘要

We are adding a new integration type, ChatLoaders, to make it easier to fine-tune models on your own unique writing style. These utilities help convert data from popular messaging platforms to chat messages compatible with fine-tuning formats like that supported by OpenAI.

我们新增了一类集成组件——ChatLoaders，旨在帮助您更便捷地基于自身独特的写作风格对大语言模型进行微调。这些工具可将主流消息平台中的数据转换为符合微调格式（例如 OpenAI 所支持的格式）的对话消息。

Thank you to [Greg Kamradt](https://twitter.com/GregKamradt?ref=blog.langchain.com) for [Misbah Syed](https://twitter.com/MisbahSy?ref=blog.langchain.com) for their thought leadership on this.

衷心感谢 [Greg Kamradt](https://twitter.com/GregKamradt?ref=blog.langchain.com) 与 [Misbah Syed](https://twitter.com/MisbahSy?ref=blog.langchain.com) 在该方向上的前瞻性洞见与引领。

**Important Links:**

**重要链接：**

- **[Chat Loaders](https://python.langchain.com/docs/integrations/chat_loaders/?ref=blog.langchain.com)**
- **[Chat Loaders（中文文档）](https://python.langchain.com/docs/integrations/chat_loaders/?ref=blog.langchain.com)**

- **[Twitter Finetune Example](https://elon-twitter-clone.streamlit.app/?ref=blog.langchain.com)**
- **[Twitter 微调示例（Streamlit 应用）](https://elon-twitter-clone.streamlit.app/?ref=blog.langchain.com)**

- [**Code for Twitter Finetune Example**](https://github.com/langchain-ai/twitter-finetune?ref=blog.langchain.com)
- [**Twitter 微调示例源代码（GitHub）**](https://github.com/langchain-ai/twitter-finetune?ref=blog.langchain.com)

- **[Webinar on this topic next week](https://www.crowdcast.io/c/lzafugqtyata?ref=blog.langchain.com)**
- **[关于本主题的线上研讨会（下周举行）](https://www.crowdcast.io/c/lzafugqtyata?ref=blog.langchain.com)**

### Context

### 背景

On Tuesday, OpenAI [announced](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com) improved fine-tuning support, extending the service to larger chat models like GPT-3.5-turbo. This enables anyone to customize these larger, more capable models for their own use cases. They also teased support for fine-tuning GPT-4 later this year.

本周二，OpenAI [宣布](https://openai.com/blog/gpt-3-5-turbo-fine-tuning-and-api-updates?ref=blog.langchain.com)其微调能力获得显著增强，现已支持更大规模的对话模型（如 GPT-3.5-turbo）。这使得任何用户都能针对自身具体应用场景，定制化这些能力更强、参数量更大的模型。OpenAI 还预告，今年晚些时候将推出 GPT-4 的微调支持。

While fine-tuning is typically [not](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev) [advised](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.dev) for teaching an LLM substantially new knowledge or for factual recall; it _is_ good for style transfer.

尽管微调通常**不推荐**用于向大语言模型灌输大量全新知识，或用于提升事实性内容的精确召回能力（参见 [OpenAI Cookbook 示例](https://github.com/openai/openai-cookbook/blob/main/examples/Question_answering_using_embeddings.ipynb?ref=blog.langchain.dev) 及 [Glean 博客文章](https://www.glean.com/blog/lessons-and-learnings-from-building-an-enterprise-ready-ai-assistant?ref=blog.langchain.dev)），但它**非常适合风格迁移任务**。

We've had a lot of community members ask about the best ways to get ChatGPT to respond "in your own voice" - fine-tuning is an excellent way to do so!

我们收到大量社区成员的咨询：如何让 ChatGPT 的回复“听起来像我自己”？微调正是实现这一目标的绝佳途径！

Great people on Twitter like Greg Kamdrat have also been bullish on this use case:

Twitter 上的优秀实践者（如 Greg Kamradt）也对该应用场景持高度乐观态度：

> Setting the tone/style of the output is top of the list for me  
> 输出语气/风格的设定，是我最优先考虑的事项。

> Fine-tuning as a service to businesses that matches their tone  
> 面向企业的“语气匹配式”微调即服务（Fine-tuning-as-a-Service）。

> Currently investigating...will report back [https://t.co/235WSJzxet](https://t.co/235WSJzxet?ref=blog.langchain.com) [pic.twitter.com/KDzMrdqccv](https://t.co/KDzMrdqccv?ref=blog.langchain.com)  
> 目前正在调研中……后续将同步进展：[https://t.co/235WSJzxet](https://t.co/235WSJzxet?ref=blog.langchain.com) [pic.twitter.com/KDzMrdqccv](https://t.co/KDzMrdqccv?ref=blog.langchain.com)

> — Greg Kamradt (@GregKamradt) [August 22, 2023](https://twitter.com/GregKamradt/status/1694063901724610995?ref_src=twsrc%5Etfw&ref=blog.langchain.com)  
> — Greg Kamradt（@GregKamradt）[2023年8月22日](https://twitter.com/GregKamradt/status/1694063901724610995?ref_src=twsrc%5Etfw&ref=blog.langchain.com)

Fine-tuning on your communications could be useful for a variety of applications, such as responding to customers in your brand's voice, generating content that is more aware of your team's unique jargon, chatting reliably in a target language, or just for fun!  
针对您自有通信数据的微调，可在多种场景中发挥价值：例如以品牌专属语调响应客户、生成更贴合团队内部特有行话的内容、在目标语言中稳定可靠地对话，甚至纯粹用于趣味性尝试！

Why is this better than direct instructions? Style and tone can be hard to describe! Most of us don't write like ChatGPT, and it can sometimes be frustratingly difficult to get the LLM to consistently respond in a particular voice (especially over longer conversations).  
为何这比直接指令更优？因为风格与语调往往难以精准描述！我们大多数人并不像 ChatGPT 那样写作；而让大语言模型（LLM）始终如一地以某种特定“声音”作答——尤其在较长对话中——有时会令人沮丧地困难。

Why is this better than few-shot examples? It can be challenging to capture your voice in only a few concise snippets! Fine-tuning lets you provide a larger number of examples the model can learn from without having to see them every time you want to query the model.  
为何这比少样本（few-shot）示例更优？仅靠几个简短片段，往往难以完整呈现您的独特表达风格！微调则允许您提供大量范例供模型学习，且无需在每次调用模型时重复输入这些示例。

### ChatLoaders  
### ChatLoaders（聊天数据加载器）

At LangChain, we want to make it as easy as possible for you to take advantage of this improved fine-tuning support. To make it simple to adapt a model to your voice, we're adding a new integration type: `ChatLoaders`.  
在 LangChain，我们的目标是让您尽可能轻松地利用这一增强版微调能力。为简化模型对您个性化语调的适配过程，我们新增了一类集成组件：`ChatLoaders`（聊天数据加载器）。

These utilities take data exported from popular messaging platforms and convert them to LangChain message objects, which you can then easily convert platform-agnostic message formats, such as OpenAI, Llama 2, and others. This training data can be used directly for fine-tuning a model.  
这类工具可导入主流消息平台导出的数据，并将其转换为 LangChain 的消息对象（`Message`），进而便捷地转为通用消息格式（如 OpenAI、Llama 2 等所支持的格式）。此类训练数据可直接用于模型微调。

We've added loaders for the following popular messaging platforms so far:  
截至目前，我们已为以下主流消息平台提供了数据加载器：

- Facebook Messenger  
- Facebook Messenger  
- Slack  
- Slack  
- Telegram  
- Telegram  
- WhatsApp  
- WhatsApp  

We have also added a recipe on how to do so for Discord and Twitter (using Apify) and plan to integrate additional chat loaders in the near future. If you have a favorite messaging platform you'd like to support, we'd love to help you land a PR!  
此外，我们还提供了针对 Discord 和 Twitter（借助 Apify 工具）的实现方案指南；未来也将持续集成更多聊天平台的数据加载器。如果您有特别希望支持的消息平台，欢迎贡献代码（PR）——我们非常乐意为您提供协助！

To get you started, we've added an  [end-to-end example notebook](https://colab.research.google.com/github/langchain-ai/langchain/blob/master/docs/extras/integrations/chat_loaders/facebook.ipynb?ref=blog.langchain.com)  to the LangChain documentation showing how to fine-tune `gpt-3.5-turbo` (the model behind ChatGPT) on an example set of Facebook messages.

为帮助您快速上手，我们在 LangChain 文档中添加了一个[端到端示例 Notebook](https://colab.research.google.com/github/langchain-ai/langchain/blob/master/docs/extras/integrations/chat_loaders/facebook.ipynb?ref=blog.langchain.com)，演示如何基于一组示例 Facebook 消息对 `gpt-3.5-turbo`（即 ChatGPT 所用模型）进行微调。

❗

Please ensure all participants of your conversations support the decision to train a model on the chat data before proceeding.

❗

请务必确保对话所有参与者均同意将聊天数据用于模型训练，再继续后续操作。

Once you have your fine-tuned model, you can use the model name directly in  LangChain's [ChatOpenAI](https://api.python.langchain.com/en/latest/chat_models/langchain.chat_models.openai.ChatOpenAI.html?ref=blog.langchain.com#langchain.chat_models.openai.ChatOpenAI) class:

获得微调后的模型后，您可直接在 LangChain 的 [ChatOpenAI](https://api.python.langchain.com/en/latest/chat_models/langchain.chat_models.openai.ChatOpenAI.html?ref=blog.langchain.com#langchain.chat_models.openai.ChatOpenAI) 类中使用该模型名称：

```
from langchain.chat_models import ChatOpenAI

llm = ChatOpenAI(model="ft:gpt-3.5-turbo-0613:{openaiOrg}::{modelId}")
llm.predict("What classes are you taking this year?")
```

```
from langchain.chat_models import ChatOpenAI

llm = ChatOpenAI(model="ft:gpt-3.5-turbo-0613:{openaiOrg}::{modelId}")
llm.predict("今年你修了哪些课程？")
```

Then you can plug this into any other LangChain component!

随后，您即可将该模型无缝集成至任意其他 LangChain 组件中！

### End-to-End Example

### 端到端示例

We've also created an end-to-end example of finetuning a model based on Elon Musk's tweets. This uses Apify to load data. Note that it's less than 100 examples so results may not be the most amazing they could be.

我们还构建了一个基于埃隆·马斯克（Elon Musk）推文的模型微调端到端示例。该示例使用 Apify 加载数据。请注意：样本数量不足 100 条，因此效果可能并非最理想。

We open-sourced this example at the GitHub repo [here](https://github.com/langchain-ai/twitter-finetune?ref=blog.langchain.com). We also hosted it on Streamlit app so you can easily play around with it [here](https://elon-twitter-clone.streamlit.app/?ref=blog.langchain.com).

该示例已在 GitHub 仓库开源，地址为：[此处](https://github.com/langchain-ai/twitter-finetune?ref=blog.langchain.com)。我们还将其部署为 Streamlit 应用，方便您轻松体验和试用：[此处](https://elon-twitter-clone.streamlit.app/?ref=blog.langchain.com)。

### Webinar

### 网络研讨会

There is a lot more to discuss on this topic. What types of messages are best for finetuning? What others sources of data exist for this? How many points do you need?

关于这一主题，还有许多值得深入探讨的内容：哪些类型的消息最适合微调（finetuning）？除此之外，还有哪些可用的数据来源？又需要多少数据样本？

We'll be discussing this and more next week in a [webinar](https://www.crowdcast.io/c/lzafugqtyata?ref=blog.langchain.com) with Greg Kamradt. Come join!

下周，我们将与 Greg Kamradt 一起举办一场[网络研讨会](https://www.crowdcast.io/c/lzafugqtyata?ref=blog.langchain.com)，深入探讨上述问题及其他相关内容，诚邀您参加！

### Conclusion

### 结语

We're excited to see all the creative applications fine-tuning unlocks.  We have implemented a few ChatLoaders already, but we need your help to make it easier to create your own personalized model.  Help us create more ChatLoaders!

我们非常期待看到微调技术所激发的各类创新应用。目前我们已实现若干 ChatLoader，但仍需您的支持，以进一步降低构建个性化模型的门槛。欢迎您参与共建更多 ChatLoader！

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的实践心得**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 分钟阅读

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 分钟阅读

[![LangChain State of AI 2024 Report](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 分钟阅读

[![Introducing OpenTelemetry support for LangSmith](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/chat-loaders-fine-tune-a-chatmodel-in-your-voice/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟