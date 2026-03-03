---
title: "Feature Stores and LLMs"
source: "LangChain Blog"
url: "https://blog.langchain.com/feature-stores-and-llms/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:47:04.084718207+00:00"
language: "en-zh"
translated: true
---

**Editor's note: big thank you to [Willem Pienaar](https://twitter.com/willpienaar?ref=blog.langchain.com) ( [Feast](https://github.com/feast-dev/feast?ref=blog.langchain.com)), [Mike Del Balso](https://twitter.com/mikedelbalso?ref=blog.langchain.com) ( [Tecton](https://www.tecton.ai/?ref=blog.langchain.com)), and [Simba Khadder](https://twitter.com/simba_khadder?ref=blog.langchain.com) ( [FeatureForm](https://www.featureform.com/?ref=blog.langchain.com)) for their comments and help on this post.**

**编者注：衷心感谢 [Willem Pienaar](https://twitter.com/willpienaar?ref=blog.langchain.com)（[Feast](https://github.com/feast-dev/feast?ref=blog.langchain.com)）、[Mike Del Balso](https://twitter.com/mikedelbalso?ref=blog.langchain.com)（[Tecton](https://www.tecton.ai/?ref=blog.langchain.com)）和 [Simba Khadder](https://twitter.com/simba_khadder?ref=blog.langchain.com)（[FeatureForm](https://www.featureform.com/?ref=blog.langchain.com)）对本文提出的宝贵意见与协助。**

LLMs represent a new paradigm of AI. There is a big open question of how many of the tools and services that were useful for traditional machine learning are still relevant here. On one hand, there are very real new use cases and requirements for this new paradigm. On the other hand, existing tools and services have years of experience, development, and feature hardening. Are these tools still useful in this new paradigm?

大语言模型（LLM）代表了一种全新的人工智能范式。一个悬而未决的重要问题是：过去在传统机器学习中行之有效的各类工具与服务，究竟有多少在当前新范式下依然适用？一方面，这一新范式催生了大量真实、迫切的新应用场景与需求；另一方面，现有工具和服务已历经多年实践打磨、持续迭代与功能加固。那么，这些工具在新范式下是否仍具价值？

### Feature stores overview

### 特征存储（Feature Store）概述

One particularly interesting case study is feature stores. In traditional machine learning, the input to models is not raw text or an image, but rather a series of engineered “features” related to the datapoint at hand. A feature store is a system meant to centralize and serve ML features to models. There are usually two benefits:

一个尤为值得关注的典型案例是特征存储（feature store）。在传统机器学习中，模型的输入并非原始文本或图像，而是针对当前数据样本所人工构建的一系列“特征”。特征存储是一种旨在集中管理并为机器学习模型统一提供特征的服务系统。其通常具备两大核心价值：

1. A way of keeping track of what features are present at a particular point in time to use in model training  
1. 在模型训练阶段，精准追踪某一特定时间点可用的特征集合  

2. A real-time pipeline of features to use when doing inference  
2. 在模型推理阶段，提供实时更新的特征流水线  

How might these apply to LLM applications?

上述两点如何适用于大语言模型（LLM）应用？

The first point seems not as relevant. Most folks are using pre-trained LLMs from OpenAI, Anthropic, etc and not training their own models from scratch.

第一点似乎相关性较低。目前绝大多数用户直接调用 OpenAI、Anthropic 等公司提供的预训练大语言模型，并不从零开始训练自有模型。

On the other hand, we believe that the second benefit (a real-time pipeline of features to use when doing inference) is still extremely relevant. We believe that a real-time pipeline of features (enabled by a feature store) can be used to achieve real-time personalization of LLM applications. Although we do not see a lot of this at the moment, we believe that this will become more popular as applications become more advanced.

然而，我们认为第二点价值——即在推理阶段提供实时特征流水线——依然极为关键。我们相信，借助特征存储所支撑的实时特征流水线，能够实现 LLM 应用的实时个性化。尽管目前此类实践尚不多见，但我们预计，随着应用复杂度不断提升，这一能力将日益普及。

An LLM is a "reasoning engine," just like a person. There are a whole set of tasks that would be much easier to reason for if you also had ready access to fresh data about your user or business. E.g. if you are asking a person to estimate how long will take to drive from a to b, they'd probably make a way better decision if they also knew which road segments there were between a and b and how much traffic is on those segments right now.

大语言模型本质上是一个“推理引擎”，正如人类一样。若能即时获取关于用户或业务的最新数据，许多任务的推理过程将显著简化。例如，若请一个人估算从 A 地到 B 地的驾车时长，当他同时知晓 A 与 B 之间有哪些路段、以及各路段当前实时交通状况时，其判断结果显然会准确得多。

This kind of added context or data enrichment has been widely used in traditional ML for a long time. Some models have 1000s of features. Although LLMs make it possible to solve some ML tasks with only user prompts, a large set of tasks can only be completed at competitive accuracy with a lot of context data.

此类上下文增强或数据富化（data enrichment）技术，在传统机器学习领域早已被广泛应用。部分模型甚至依赖数千个特征。尽管大语言模型使得仅凭用户提示词即可解决某些机器学习任务，但仍有大量任务必须辅以海量上下文数据，方能达到具备竞争力的准确率。

### Prompting overview

### 提示工程概述

Language model applications are largely defined by how their prompts are constructed. Therefore, before trying to think about how feature stores could impact language model applications, we should try to understand different ways of constructing prompts, and then think about how feature stores could impact prompt construction. Below are probably the three most common types of prompt construction, ordered from least complex to most complex.

语言模型应用在很大程度上由其提示（prompt）的构建方式所决定。因此，在思考特征存储（feature store）如何影响语言模型应用之前，我们应首先理解不同的提示构建方式，再进一步探讨特征存储可能对提示构建产生的影响。以下大致列出了三种最常见的提示构建方式，按从最简单到最复杂的顺序排列。

**#1: Hard coded prompt string**

**#1：硬编码提示字符串**

This is when the entire prompt that is passed into the language model is hard coded by the application. There is no customization done to the prompt, and therefore all the variation in output comes from the language model. This is an incredibly simple prompting strategy that honestly is likely so simple it’s rarely used.

即整个传入语言模型的提示字符串均由应用程序硬编码完成。提示内容完全固定、不可定制，因此所有输出的差异均仅来源于语言模型自身。这是一种极其简单的提示策略——简单到现实中很可能极少被采用。

**#2: Incorporating user input**

**#2：融入用户输入**

The next step is incorporating user input into the prompt string. This means having a prompt template, and filling in the variables with user input that they put in at run time. An example of an application like this could be a poem-generating application. This application could ask the user for a \`subject\` input, and then format a prompt like \`Write me a poem about {subject}\` before passing that to the language model. This can be done with multiple variables, but the important part is it is taking in user input at runtime and formatting a string with those variables.

下一步是将用户输入嵌入提示字符串中。这意味着需预先定义一个提示模板，并在运行时用用户实际提供的输入值填充其中的变量。此类应用的一个典型例子是诗歌生成器：该应用可向用户询问一个 \`subject\`（主题）输入，然后构造形如 \`Write me a poem about {subject}\` 的提示，再将其传给语言模型。该方法可支持多个变量，但关键在于——它在运行时动态接收用户输入，并据此拼接生成最终提示字符串。

**#3: Incorporating basic real-time system data**

**#3：融入基础实时系统数据**

It can often be helpful to include basic, real time system data into the prompt. The most common example of this is incorporating the current date and time. This is not something that you would want to hard code (because it changes constantly). This can be helpful in order to give the language a sense of the current state of the system/world.

在提示中加入基础的、实时的系统数据往往十分有益。最常见的例子是嵌入当前日期与时间。这类信息显然不适合硬编码（因其持续变化）。引入此类信息有助于赋予语言模型对系统/现实世界当前状态的基本感知能力。

**#4: Incorporating external data fetched based on user input**

**#4：融入基于用户输入获取的外部数据**

Another step up is using the user provided input to fetch even more information to put into a prompt. A good example of this is all the question-answering applications. Those applications generally use a prompt template like:  

更进一步的做法是：利用用户输入作为查询条件，主动获取额外的外部数据并注入提示中。问答类（question-answering）应用便是典型代表。这类应用通常采用如下形式的提示模板：

```
Answer the following question: {question}
Only use the following information to answer:
{context}
Answer:
```

```
请回答以下问题：{question}
仅使用以下信息作答：
{context}
答案：
```

There are two variables this prompt expects: \`question\` and \`context\`. Question is usually provided at run-time by the user, and context is data that is fetched (usually via a retrieval system) that is relevant to the user input.

该提示模板期望接收两个变量：\`question\`（问题）和 \`context\`（上下文）。其中，“问题”通常由用户在运行时提供；而“上下文”则是通过检索系统（通常为某种检索机制）获取的、与用户输入相关联的数据。

This already allows for a certain type of “personalization” - depending on the retriever that is used, that context can be used to “personalize” an application so that it can respond about a specific type of data.

这本身已支持某种形式的“个性化”——具体效果取决于所采用的检索器：通过该上下文，应用可被“个性化”配置，从而针对某一特定类型的数据生成响应。

### Feature stores <> Prompting

### 特征存储（Feature Stores）<> 提示工程（Prompting）

Those are the four main prompt construction strategies that we see today. We think feature stores can supercharge prompt construction - by allowing for inclusion of real-time, complex, and often user-based, information.

以上是当前主流的四种提示构建策略。我们认为，特征存储（feature stores）可极大增强提示构建能力——它支持将实时性、复杂性以及（往往）以用户为中心的信息纳入提示中。

This is combining key ideas from existing prompt construction methods. When we insert things like the current date and time, we are injecting knowledge of the current state of the world into the prompt - but it is very simple and general knowledge. When we insert external data fetched based on user input, we are incorporating more personalized data - but it is largely based solely on user input.

这一思路融合了现有各类提示构建方法的核心理念。例如，当我们向提示中插入当前日期和时间，本质上是将关于现实世界“当前状态”的知识注入提示——但这类知识非常基础且泛化；而当我们插入基于用户输入所检索到的外部数据时，则是在引入更具个性化的信息——然而，这类信息仍主要局限于对用户原始输入的直接响应。

To see this in play, we can head over to the [feast GitHub repository](https://github.com/feast-dev/feast?ref=blog.langchain.com) \- one of the more popular open source feature stores. Let’s look at the example on the README.

要直观了解该技术的实际应用，我们可以访问 [Feast GitHub 仓库](https://github.com/feast-dev/feast?ref=blog.langchain.com)——这是目前最受欢迎的开源特征存储项目之一。我们来看其 README 中的示例。

![](<Base64-Image-Removed>)

![](<Base64-Image-Removed>)

In this example we are fetching realtime, user specific information. In traditional ML models this information would be fed in as feature values into a model, but now we can feed it into the prompt!

在此示例中，我们正在获取实时的、面向特定用户的信息。在传统机器学习模型中，此类信息通常作为特征值输入模型；而如今，我们则可将其直接注入提示（prompt）！

To see how this can be done, we’ve set up an example notebook showing how to connect a feature store to a prompt template. Putting it inside a prompt template allows us to nicely package up that logic and pass it through the chain. When we then call that chain, real-time information can be fetched via feast and used to construct a prompt which is then passed into the language model.

为演示具体实现方式，我们准备了一个示例 Notebook，展示如何将特征存储接入提示模板（prompt template）。将该逻辑封装进提示模板，可使整体结构更清晰，并顺畅地嵌入至处理链（chain）中。当调用该链时，系统即可通过 Feast 实时获取信息，据此构建提示，最终将该提示传入语言模型。

See the example notebook for this [here](https://python.langchain.com/docs/modules/model_io/prompts/prompt_templates/connecting_to_a_feature_store?ref=blog.langchain.com).

请参阅此处的示例 Notebook：[点击访问](https://python.langchain.com/docs/modules/model_io/prompts/prompt_templates/connecting_to_a_feature_store?ref=blog.langchain.com)。

We do this for a variety of feature stores: feast, [Tecton](https://www.tecton.ai/?ref=blog.langchain.com), [FeatureForm](https://www.featureform.com/?ref=blog.langchain.com). Here’s an example of the code for doing it with Tecton - as you can see - it’s really quite simple!

我们已为多种特征存储系统（feature stores）实现了该功能，包括 Feast、[Tecton](https://www.tecton.ai/?ref=blog.langchain.com) 和 [FeatureForm](https://www.featureform.com/?ref=blog.langchain.com)。以下是以 Tecton 为例的代码实现——如您所见，操作非常简洁！

![](<Base64-Image-Removed>)

![](<Base64-图像已移除>)

This is obviously a simple example, but we believe it highlights the power of this approach and hints at a future where this is more common. Many language model applications are still struggling to get off the ground, but as time progresses we believe real-time, user-level information will be used to construct prompts and provide a superior, personalized end-user experience. Examples of potential applications include chatbots with real-time context, marketing content with personalized context, and recommendations given recent user session history. As we move toward this world, we believe existing feature stores are well-positioned to help do so.

这显然只是一个简单示例，但我们相信它凸显了该方法的强大能力，并预示着一种更广泛应用的未来图景。当前，许多大语言模型应用仍处于起步阶段；而随着技术演进，我们坚信：实时、细粒度的用户级信息将被用于构建 Prompt，从而提供更优越、更个性化的终端用户体验。潜在应用场景包括：具备实时上下文感知能力的聊天机器人、融合个性化上下文的营销内容，以及基于用户近期会话历史生成的智能推荐。在迈向这一未来的过程中，我们认为现有的特征存储系统已做好充分准备，可为此提供有力支撑。

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI × LangChain：面向 AI 应用高效同步维护上下文](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--19.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：面向 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/5-social--18.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](https://blog.langchain.com/content/images/size/w760/format/webp/2023/08/image20.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)


[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口端点**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)