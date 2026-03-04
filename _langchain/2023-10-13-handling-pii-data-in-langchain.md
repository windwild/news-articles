---
render_with_liquid: false
title: "Handling PII data in LangChain"
source: "LangChain Blog"
url: "https://blog.langchain.com/handling-pii-data-in-langchain/"
date: "2023-10-13"
scraped_at: "2026-03-03T08:38:09.913282623+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

This blog post was written by Francisco, a founder at [Pampa Labs](https://www.pampa.ai/?ref=blog.langchain.com), who assists companies in developing LLM applications that are accurate and cost efficient.

这篇博客文章由 Francisco 撰写。他是 [Pampa Labs](https://www.pampa.ai/?ref=blog.langchain.com) 的联合创始人，致力于协助企业开发准确且成本高效的大型语言模型（LLM）应用。

### Introduction

### 引言

PII stands for “personally identifiable information” and it refers to personal data that can be used to uncover an individual’s identity. Lately, regulations such as [GDPR](https://www.google.com/search?q=gdpr+regulation&oq=gdpr&gs_lcrp=EgZjaHJvbWUqBggAEEUYOzIGCAAQRRg7MgYIARBFGDsyBggCEEUYPDIGCAMQRRg80gEHNTY0ajBqMagCALACAA&sourceid=chrome&ie=UTF-8&ref=blog.langchain.com) make it so that companies find it increasingly important to find solutions that consider handling PII data effectively.

PII 是“Personally Identifiable Information”（个人身份信息）的缩写，指可用于识别特定个人身份的个人信息。近期，《通用数据保护条例》（[GDPR](https://www.google.com/search?q=gdpr+regulation&oq=gdpr&gs_lcrp=EgZjaHJvbWUqBggAEEUYOzIGCAAQRRg7MgYIARBFGDsyBggCEEUYPDIGCAMQRRg80gEHNTY0ajBqMagCALACAA&sourceid=chrome&ie=UTF-8&ref=blog.langchain.com)）等监管法规日益强化，促使企业愈发重视寻找能有效处理 PII 数据的解决方案。

Managing PII data with LLMs can be tricky. In many applications, you know when you are handling PII data because you explicitly ask for it in the shape of a form. In the case of chatbots, the user might spontaneously send PII data within the conversation (like presenting themselves with their name and surname) and depending on the application, this information might be sent to an LLM provider and logged for quality purposes.

借助 LLM 管理 PII 数据可能颇具挑战性。在许多应用中，你明确知晓自己正在处理 PII 数据——例如，通过表单形式主动向用户收集。但在聊天机器人场景下，用户可能在对话中自发提供 PII 数据（如主动告知自己的姓名和姓氏）；而根据具体应用设计，这类信息可能被发送至 LLM 服务提供商，并出于质量保障目的被记录存档。

There are some questions that commonly arise:

以下是一些常见问题：

- What are the available options to mask PII data?  
- 掩码化（masking）PII 数据有哪些可行方案？  

- What about LangSmith? If LangSmith logs my apps conversations, will it be logging PII data as well?  
- LangSmith 呢？如果 LangSmith 记录我应用的对话日志，是否会一并记录 PII 数据？  

- Do we risk PII data being leaked if we send it to OpenAI? What about other providers?  
- 若将 PII 数据发送给 OpenAI，是否存在数据泄露风险？其他服务商是否也存在类似风险？  

While we don’t propose to have the definitive answers to these questions, by presenting a few options that are available today we can ignite the conversation on which are the best ways to handle PII data when working with LLMs.

尽管我们无意为上述问题提供终极答案，但通过介绍当前可用的若干方案，我们希望激发业界关于“在使用 LLM 时如何最优地处理 PII 数据”的深入讨论。

### Why you should care about masking inputs for LLM providers

### 为何应重视对发送至 LLM 提供商的输入数据进行掩码化处理

LLM providers like OpenAI, Anthropic and Cohere all have their own privacy policies which detail how they use the data sent to them when using their API. For example, some companies might use that data for investigating how to make models better or even use the data to train new models. Since LLMs can sometimes remember explicitly what they have learned in training, this could mean that future versions of their LLMs could potentially reproduce your PII data to other users.

OpenAI、Anthropic 和 Cohere 等 LLM 提供商均制定了各自的隐私政策，详细说明其在您调用其 API 时，将如何使用您所提交的数据。例如，部分公司可能将这些数据用于模型优化研究，甚至直接用于训练新一代模型。由于 LLM 在某些情况下可能显式“记住”其训练阶段所学习的内容，这意味着未来版本的模型有可能将您的 PII 数据复现给其他用户。

Given the importance of these privacy policies and the fact that they might change over time, we strongly suggest users to take a look at providers’ privacy policies before using their services. As an example, [here’s](https://openai.com/policies/privacy-policy?ref=blog.langchain.com) OpenAI’s privacy policy.

鉴于此类隐私政策的重要性，以及其内容可能随时间动态更新，我们强烈建议用户在使用相关服务前，务必审阅各提供商的最新隐私政策。例如，[此处](https://openai.com/policies/privacy-policy?ref=blog.langchain.com) 即为 OpenAI 的隐私政策。

### Sanitizing data for LLM providers

### 为大语言模型（LLM）服务商净化数据

The first question is: how can we anonymize the data? The LangChain ecosystem is integrated with tools that make it easy to mask the data before using it in the application. Let’s take a look a a few of them:

第一个问题是：我们如何对数据进行匿名化处理？LangChain 生态系统已集成多种工具，可轻松在将数据用于应用程序之前对其进行脱敏（掩码）处理。下面我们介绍其中几种：

_**Microsoft Presidio**_

_**Microsoft Presidio**_

Microsoft Presidio is a tool that facilitates PII identification and anonymization in input text. In other words, it can replace your text’s PII elements by generic equivalents. It is quite handy as it can replace credit card numbers, emails, phones, addresses and full names among other such entities.

Microsoft Presidio 是一款用于识别和匿名化输入文本中个人身份信息（PII）的工具。换言之，它能将文本中的 PII 元素替换为通用占位符（如 `<PERSON>`）。该工具非常实用，可自动替换信用卡号、电子邮件地址、电话号码、住址及全名等多种敏感实体。

Presidio works in two steps. First, it analyzes the text searching for PII data. This is probably the key differentiating feature in Presidio, since it uses a combination of different methods to identify the PII data in the text, including both rule based logic and NER Machine Learning models. As a second step, it anonymizes the data by replacing it by a a generic equivalent (i.e. ‘<PERSON>’). If using it within LangChain, the library uses [faker](https://faker.readthedocs.io/en/master/?ref=blog.langchain.com) to replace the entities by a fake value (‘John Smith’) to make the text more natural to the LLM.

Presidio 的工作流程分为两个步骤：第一步是分析文本并识别其中的 PII 数据——这正是 Presidio 的核心差异化能力所在，因为它融合了多种识别方法，包括基于规则的逻辑与命名实体识别（NER）机器学习模型；第二步则是通过替换为通用占位符（例如 `<PERSON>`）来实现数据匿名化。当在 LangChain 中使用 Presidio 时，该库会调用 [faker](https://faker.readthedocs.io/en/master/?ref=blog.langchain.com) 库，将敏感实体替换为逼真的模拟值（如 “John Smith”），从而提升文本对大语言模型（LLM）的自然度与可用性。

If you want more detail on how Presidio identifies PII data, [here](https://microsoft.github.io/presidio/supported_entities/?ref=blog.langchain.com) you can find the entities Presidio detects out of the box, plus the methods used to detect them.

若您希望深入了解 Presidio 识别 PII 数据的具体机制，[此处](https://microsoft.github.io/presidio/supported_entities/?ref=blog.langchain.com)列出了 Presidio 开箱即用所支持识别的全部实体类型，以及每类实体所采用的检测方法。

Using Presidio with LangChain is quite straightforward; one needs to add an extra step to the chain where the anonymization takes place, like so:

在 LangChain 中集成 Presidio 非常简单：只需在调用链中额外添加一个执行匿名化的步骤，示例如下：

```
anonymizer = PresidioAnonymizer()
template = """Rewrite this text into an official, short email:
{anonymized_text}"""
prompt = PromptTemplate.from_template(template)
llm = ChatOpenAI(temperature=0)
chain = {"anonymized_text": anonymizer.anonymize} | prompt | llm
response = chain.invoke(text)
```

```
anonymizer = PresidioAnonymizer()
template = """将以下文本改写为一封正式、简短的电子邮件：
{anonymized_text}"""
prompt = PromptTemplate.from_template(template)
llm = ChatOpenAI(temperature=0)
chain = {"anonymized_text": anonymizer.anonymize} | prompt | llm
response = chain.invoke(text)
```

In the LangChain documentation we can find a full [tutorial](https://python.langchain.com/docs/guides/privacy/presidio_data_anonymization/?ref=blog.langchain.com) on how to use Microsoft Presidio plus a [tutorial](https://python.langchain.com/docs/guides/privacy/presidio_data_anonymization/multi_language?ref=blog.langchain.com) on how to use Presidio with non-English languages. If planning on using Presidio, you can also consider using it with [LLMGuard](https://github.com/laiyer-ai/llm-guard?ref=blog.langchain.com) which contains a suite of tools for LLM security including both input controls and guards (anonymization for PII data, jailbreaks) and output controls (malicious links, toxicity).

在 LangChain 官方文档中，您可以找到一份完整的 [Presidio 使用教程](https://python.langchain.com/docs/guides/privacy/presidio_data_anonymization/?ref=blog.langchain.com)，以及另一份专门介绍 [Presidio 多语言支持的教程](https://python.langchain.com/docs/guides/privacy/presidio_data_anonymization/multi_language?ref=blog.langchain.com)。若您计划采用 Presidio，还可考虑将其与 [LLMGuard](https://github.com/laiyer-ai/llm-guard?ref=blog.langchain.com) 协同使用——后者是一套面向大语言模型安全的工具集，涵盖输入防护（如 PII 数据匿名化、越狱攻击防御）与输出管控（如恶意链接拦截、毒性内容过滤）等多重能力。

_**OpaquePrompts**_

_**OpaquePrompts**_

Another good option to anonymize data is using [OpaquePrompts](https://opaqueprompts.opaque.co/?ref=blog.langchain.com). Instead of using several techniques in unison, OpaquePrompts uses one ML model to detect PII data and mask it appropriately.

另一种不错的数据匿名化方案是使用 [OpaquePrompts](https://opaqueprompts.opaque.co/?ref=blog.langchain.com)。与同时组合多种技术不同，OpaquePrompts 仅依赖一个机器学习模型来检测个人身份信息（PII）并进行相应遮蔽。

One of the main advantages of using OpaquePrompts is just how easy it is to use with LangChain, where we just use an \`OpaquePrompts\` LLM class which we initialize with a LangChain LLM like \`OpenAI\`.

使用 OpaquePrompts 的主要优势之一，正是它与 LangChain 的高度易用性：我们只需使用 \`OpaquePrompts\` 这一 LLM 类，并以 LangChain 中的 LLM（例如 \`OpenAI\`）作为基础模型进行初始化即可。

```
chain = LLMChain(
  prompt=prompt,
  # llm=OpenAI(),
  llm=OpaquePrompts(base_llm=OpenAI()),
  memory=memory,
)
```

```
chain = LLMChain(
  prompt=prompt,
  # llm=OpenAI(),
  llm=OpaquePrompts(base_llm=OpenAI()),
  memory=memory,
)
```

Another of its differential aspects is that it uses [confidential computing](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com) which means that not even their anonymization service can access the original data; a great feature for privacy seeking users. Finally, it will deanonymize the data after getting the response from the LLM so the user will get an answer that contains the original entities that they mentioned / requested.

另一项差异化特性在于，它采用了 [机密计算（confidential computing）](https://en.wikipedia.org/wiki/Confidential_computing?ref=blog.langchain.com)，这意味着其匿名化服务本身也无法访问原始数据——这对注重隐私的用户而言是一项极佳的功能。最后，在从大语言模型（LLM）获得响应后，OpaquePrompts 会自动对数据进行去匿名化处理，从而确保用户收到的答案中仍包含其最初提及或请求的原始实体。

### Sanitizing data for LangSmith

### 为 LangSmith 清洗数据

In case we want to use LangSmith to log our app’s conversations, we might face another challenge: saving the data in a sanitized form. If we just use the aforementioned tools in the way described earlier, the LLM provider will receive the input in a sanitized form but we would be saving the original, unsanitized input to LangSmith. How can we avoid this?

如果我们希望使用 LangSmith 来记录应用程序的对话，可能还会面临另一个挑战：如何以脱敏形式保存数据。若仅按前述方式使用相关工具，则大语言模型（LLM）提供商将接收到已脱敏的输入，但我们却仍会将原始、未脱敏的输入保存至 LangSmith。该如何避免这种情况？

_**Option #1: do not save inputs or outputs**_

_**方案 #1：不保存输入或输出**_

If we want to make sure we are not saving any PII data to LangSmith, we can just hide the inputs and outputs of all of our queries from LangSmith. This can be done with a few environmental variables that LangSmith will use to understand whether it needs to log inputs/outputs or not:

若要确保不向 LangSmith 保存任何个人身份信息（PII），我们可以直接在 LangSmith 中隐藏所有查询的输入与输出。这可通过设置若干环境变量实现，LangSmith 将依据这些变量判断是否需要记录输入/输出：

```
LANGCHAIN_HIDE_INPUTS=true
LANGCHAIN_HIDE_OUTPUTS=true
```

```
LANGCHAIN_HIDE_INPUTS=true
LANGCHAIN_HIDE_OUTPUTS=true
```

In this way we can directly control what is logged and what is not. For more information on this, please refer to the [docs](https://docs.smith.langchain.com/tracing/tracing-faq?ref=blog.langchain.com#how-do-i-mask-sensitive-information-in-my-runs).

通过这种方式，我们可以直接控制哪些内容被记录、哪些不被记录。有关此功能的更多详情，请参阅 [官方文档](https://docs.smith.langchain.com/tracing/tracing-faq?ref=blog.langchain.com#how-do-i-mask-sensitive-information-in-my-runs)。

It is important to note that if using this functionality, we should consider hiding both the inputs and the outputs since the LLM might mention PII data points in its answer (‘Hi John Smith! Nice to meet you’).

需要特别注意的是：若启用此功能，我们应考虑同时隐藏输入和输出内容，因为大语言模型（LLM）可能在其回答中提及个人身份信息（PII）数据点（例如：“你好，约翰·史密斯！很高兴见到你。”）

_**Option #2: mask before saving**_

_**方案二：保存前进行掩码处理**_

Say we want to use the data in LangSmith to debug our application or we were thinking of finetuning a model of our own. In this case, not having the logs of our user’s conversations would hinder us from using real data to improve the quality of our application.

假设我们希望利用 LangSmith 中的数据来调试应用程序，或计划微调我们自己的模型。此时，若缺少用户对话日志，将阻碍我们使用真实数据来提升应用质量。

Another option for cases like this is to mask the input so that the LLM **and** the tracing software both receive masked inputs. This can be achieved by masking the input _before_ sending it as input to the chain. This method has the advantage of allowing us to trace and later use the conversation data while also keeping the data sanitized for the LLM providers and LangSmith tracing.

针对此类场景，另一种可行方案是对输入数据进行掩码处理，确保大语言模型（LLM）**以及**追踪软件均接收到已掩码的输入。具体实现方式是在将输入提交给链（chain）**之前**即完成掩码操作。该方法的优势在于：既支持对对话数据进行追踪并供后续分析使用，又能确保向 LLM 服务提供商及 LangSmith 追踪系统提交的数据始终处于脱敏状态。

### Conclusion

### 结论

Handling PII data effectively is an important aspect of building safe and reliable data applications. We have presented a few proposed solutions for this problem but the LangChain ecosystem is consistently integrating new and innovative alternatives. Stay tuned to the LangChain [newsletter](https://blog.langchain.com/) to be the first to hear of new developments on this front!

高效处理个人身份信息（PII）数据，是构建安全、可靠的数据应用的关键环节之一。本文介绍了几种应对该问题的初步解决方案；而 LangChain 生态系统也正持续整合更多新颖且富有创意的替代方案。欢迎订阅 LangChain [官方通讯](https://blog.langchain.com/)，第一时间获取该领域最新进展！

If you enjoyed this blog post, we're also doing a webinar on this subject next week - [sign up here](https://www.crowdcast.io/c/6es3zwnv0ygy?ref=blog.langchain.com) to join!

如果您喜欢这篇博客文章，我们还将于下周围绕该主题举办一场网络研讨会——欢迎[点击此处报名参加](https://www.crowdcast.io/c/6es3zwnv0ygy?ref=blog.langchain.com)！