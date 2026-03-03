---
title: "Eden AI x LangChain: Harnessing LLMs, Embeddings, and AI"
source: "LangChain Blog"
url: "https://blog.langchain.com/eden-ai-x-langchain/"
date: "2023-09-22"
scraped_at: "2026-03-03T08:41:13.300476892+00:00"
language: "en-zh"
translated: true
---

_Editor's Note: This post was written in collaboration with the [Eden AI](https://www.edenai.co/?ref=blog.langchain.com) team. We're really excited about Eden's approach to simplifying AI implementation so that we can get more applications into production! It grants access to a diverse range of AI capabilities, spanning text and image generation, OCR, speech-to-text, and image analysis, all with the convenience of a single API key and minimal code. And their integration with LangChain provides effortless access to lots of LLMs and Embeddings._

_编辑注：本文由 [Eden AI](https://www.edenai.co/?ref=blog.langchain.com) 团队联合撰写。我们非常看好 Eden 简化 AI 落地实践的思路——这将助力更多 AI 应用快速进入生产环境！只需一个 API 密钥和极少代码，即可便捷调用涵盖文本生成、图像生成、OCR、语音转文字及图像分析等在内的丰富 AI 能力。此外，其与 LangChain 的深度集成，更让开发者能轻松接入大量大语言模型（LLM）和嵌入模型（Embeddings）。_

## Introducing Eden AI: Pioneering AI Accessibility

## 介绍 Eden AI：引领 AI 可及性新范式

Eden AI stands as a new revolutionary platform meant to deal with the growing complexity and diversity of AI solutions, which allows users to access a large variety of [AI tools](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com) using a single API key and just a few lines of code.

Eden AI 是一个全新革命性平台，旨在应对日益增长的 AI 解决方案复杂性与多样性，使用户仅凭一个 API 密钥和寥寥数行代码，即可便捷调用海量 [AI 工具](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com)。

Whether you need [Text or Image generation](https://www.edenai.co/technologies/generative-ai?ref=blog.langchain.com), [OCR (Optical Character Recognition)](https://www.edenai.co/technologies/ocr-document-parsing?ref=blog.langchain.com), [Speech-to-Text conversion](https://www.edenai.co/technologies/speech?ref=blog.langchain.com), [Image Analysis](https://www.edenai.co/technologies/image?ref=blog.langchain.com), or more, Eden AI has got you covered. Gone are the days of navigating a complex maze of APIs and authentication processes; Eden AI consolidates it all into one convenient platform.

无论您需要 [文本或图像生成](https://www.edenai.co/technologies/generative-ai?ref=blog.langchain.com)、[OCR（光学字符识别）](https://www.edenai.co/technologies/ocr-document-parsing?ref=blog.langchain.com)、[语音转文字](https://www.edenai.co/technologies/speech?ref=blog.langchain.com)、[图像分析](https://www.edenai.co/technologies/image?ref=blog.langchain.com)，抑或其他能力，Eden AI 均可全面覆盖。告别过去在纷繁复杂的 API 接口与认证流程中艰难穿行的日子——Eden AI 将一切整合至一个高效便捷的统一平台。

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_001.png)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_001.png)

**[Get your API key for FREE](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com)**

**[立即免费获取您的 API 密钥](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com)**

Designed to be user-friendly and accessible to individuals of all proficiency levels, whether they are AI novices or experts, Eden AI seamlessly addresses a diverse spectrum of business requirements, including but not limited to: Data analysis, NLP capabilities, Computer Vision, Automation Optimization, and Custom model training.

Eden AI 致力于极致易用性与普适性，无论您是 AI 新手还是资深专家，皆可轻松上手。它无缝满足各类企业级需求，涵盖但不限于：数据分析、自然语言处理（NLP）、计算机视觉（Computer Vision）、自动化流程优化，以及定制化模型训练。

### Eden AI and LangChain: a powerful AI integration partnership

### Eden AI 与 LangChain：强强联合的 AI 集成伙伴关系

LangChain is an open-source library that provides multiple tools to build applications powered by Large Language Models (LLMs), making it a perfect combination with Eden AI.

LangChain 是一个开源库，提供多种工具，助力开发者构建基于大语言模型（LLM）的应用程序——这使其成为 Eden AI 的理想搭档。

Within the LangChain ecosystem, Eden AI empowers users to fully leverage LLM providers without encountering any limitations. Here is how:

在 LangChain 生态体系内，Eden AI 赋予用户无限制地充分调用各类 LLM 服务商的能力。具体方式如下：

**1. A unified platform to access multiple LLMs and Embeddings**

**1. 一个统一平台，用于接入多种大语言模型（LLM）和嵌入模型（Embeddings）**

Each LLM possesses unique strengths that make it suitable for specific use cases. However, finding the liberty to move between the best LLMs in the market can be challenging.

每种大语言模型（LLM）都具备独特优势，使其适用于特定应用场景。然而，用户往往难以自由地在市场中最优的多个 LLM 之间灵活切换。

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_002.png)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_002.png)

By integrating with LangChain, Eden AI opens the door to an extensive array of LLM and Embedding models. This integration empowers users to harness the capabilities of various providers, even models that are not directly integrated into LangChain's framework.

通过与 LangChain 集成，Eden AI 为用户打开了通向海量 LLM 与嵌入模型的大门。该集成使用户能够调用多家服务商的模型能力，甚至包括那些尚未被直接纳入 LangChain 框架的模型。

The core strength of this combination lies in its simplicity. With just one API key and a single line of code, LangChain users can tap into a diverse range of LLMs through Eden AI. This not only enhances LangChain's models but also provides great flexibility and adaptability to cater to different AI requirements.

这一组合的核心优势在于其极简性：LangChain 用户仅需一个 API 密钥和一行代码，即可通过 Eden AI 接入丰富多样的 LLM。这不仅拓展了 LangChain 原有模型的能力边界，更赋予用户高度的灵活性与适应性，以满足差异化的 AI 应用需求。

**2. A robust dashboard to optimize your AI investments**

**2. 一个功能强大的仪表盘，助您优化 AI 投资回报**

Eden AI doesn't stop at simplifying access to AI models; it also offers robust monitoring and cost management features.

Eden AI 的价值不止于简化 AI 模型的接入流程；它还提供强大而全面的监控与成本管理功能。

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_003.png)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_003.png)

With our intuitive dashboard, you have the power to monitor your AI usage among multiple AI APIs, gain insights into resource allocation, and optimize costs effectively. Additionally, you’ll have access to features such as logging for enhanced debugging and API caching to reduce usage and avoid redundant charges.

借助我们直观易用的仪表盘，您可以实时监控跨多个 AI API 的调用情况，深入洞察资源分配状况，并高效优化成本。此外，您还可使用日志记录（logging）功能提升调试效率，以及启用 API 缓存机制，降低调用量、避免重复计费。

This streamlined approach to cost management ensures that you get the most out of your AI investment without any surprises in your budget.

这种高度简化的成本管理方式，确保您充分释放 AI 投资价值，同时让预算支出清晰可控、毫无意外。

**3\. Advanced AI capabilities to enhance your applications**

**3\. 增强应用功能的高级 AI 能力**

The integration of Eden AI into LangChain represents a significant breakthrough for developers working with LangChain's Agent Tools, empowering them to leverage more advanced capabilities to enhance their applications.

将 Eden AI 集成至 LangChain，是面向使用 LangChain Agent 工具的开发者的重大突破，使其能够便捷调用更先进的 AI 能力，从而显著提升其应用性能。

LangChain Agents act as intermediaries between LLMs and various tools, facilitating a wide range of tasks in AI-powered applications, such as web searches, calculations, and code execution. They are especially crucial for creating versatile and responsive applications, allowing developers to execute functions dynamically and interact with external APIs based on specific user queries.

LangChain Agent 充当大语言模型（LLM）与各类工具之间的中间层，在 AI 应用中支持广泛任务，例如网络搜索、数学计算和代码执行。它们对于构建灵活、响应迅速的应用尤为关键，使开发者能根据具体用户查询动态调用函数，并与外部 API 进行交互。

The key benefit of this integration is that LangChain users can now incorporate these [advanced tools](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com) into their applications with ease, including features like [Explicit Content Detection](http://www.edenai.co/feature/explicit-content-detection?ref=blog.langchain.com) for both text and images, [Invoice](http://www.edenai.co/feature/ocr-invoice?ref=blog.langchain.com) and [ID parsing](http://www.edenai.co/feature/ocr-id-passport?ref=blog.langchain.com), [Object Detection](http://www.edenai.co/feature/ocr?ref=blog.langchain.com), [Text-to-Speech](http://www.edenai.co/feature/text-to-speech?ref=blog.langchain.com), and [Speech-to-Text](https://www.edenai.co/feature/speech-to-text?ref=blog.langchain.com).

此次集成的核心优势在于：LangChain 用户如今可轻松将这些[高级工具](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com)嵌入自身应用，涵盖多项功能，例如面向文本与图像的[显性内容检测（Explicit Content Detection）](http://www.edenai.co/feature/explicit-content-detection?ref=blog.langchain.com)、[发票 OCR 解析（Invoice Parsing）](http://www.edenai.co/feature/ocr-invoice?ref=blog.langchain.com)与[身份证件/护照 OCR 解析（ID Parsing）](http://www.edenai.co/feature/ocr-id-passport?ref=blog.langchain.com)、[目标检测（Object Detection）](http://www.edenai.co/feature/ocr?ref=blog.langchain.com)、[文本转语音（Text-to-Speech）](http://www.edenai.co/feature/text-to-speech?ref=blog.langchain.com)，以及[语音转文本（Speech-to-Text）](https://www.edenai.co/feature/speech-to-text?ref=blog.langchain.com)。

Consequently, this partnership enables developers to enhance their applications with the best AI models and providers, all accessible via a standard API key, thereby delivering an unprecedented level of versatility and responsiveness in executing various functions and interacting with external APIs.

由此，该合作使开发者得以借助业界顶尖的 AI 模型与服务提供商，仅凭一个标准 API 密钥即可接入全部能力，从而在执行各类功能及调用外部 API 时，实现前所未有的灵活性与响应能力。

**How to use Eden AI LLMs and Embedding models into LangChain?**

**如何将 Eden AI 的大语言模型（LLM）与嵌入（Embedding）模型集成至 LangChain？**

Here are not one, but two tutorials that will empower you to redefine the way you approach AI-powered applications. If you’re looking for a basic starter with [Eden AI's LLMs](https://python.langchain.com/docs/integrations/llms/edenai?ref=blog.langchain.com) and [Embeddings](https://python.langchain.com/docs/integrations/text_embedding/edenai?ref=blog.langchain.com), we advise you to follow the first tutorial. On the other hand, if you’re interested in advanced integration, you can proceed directly to the second tutorial!

我们为您精心准备了**不止一篇，而是两篇**教程，助您彻底革新构建 AI 应用的方式。若您希望从基础入门，快速上手使用[ Eden AI 的大语言模型（LLM）](https://python.langchain.com/docs/integrations/llms/edenai?ref=blog.langchain.com)与[嵌入模型（Embeddings）](https://python.langchain.com/docs/integrations/text_embedding/edenai?ref=blog.langchain.com)，建议您优先学习第一篇教程；若您已具备一定经验，希望深入探索高级集成方案，则可直接进入第二篇教程！

**Tutorial 1: Get started with Eden AI to access multiple LLMs and Embeddings**

**教程 1：快速上手 Eden AI —— 接入多种大语言模型与嵌入模型**

In our first tutorial, you will learn how to harness the combined power of LangChain and Eden AI to access multiple Large Language Models (LLMs) and Embeddings.

在本教程中，您将学习如何协同运用 LangChain 与 Eden AI 的能力，便捷接入多种大语言模型（LLM）与嵌入（Embedding）模型。

By mastering the intricacies of embeddings and LLMs, you will unlock the capability to craft a diverse array of functionalities. From building a basic AI assistant to creating custom chatbots, the possibilities are limited only by your imagination.

通过深入掌握嵌入技术与大语言模型的原理与用法，您将解锁构建多样化功能的能力——无论是打造基础 AI 助手，还是开发定制化聊天机器人，一切皆由您的创意所定义。

**Step 1: Installation**

**第一步：安装**

First, ensure you have Python installed. Then, install LangChain by running the following command:

首先，请确保已安装 Python。然后，运行以下命令安装 LangChain：

|     |
| --- |
| Pip install langchain |

|     |
| --- |
| pip install langchain |

**Step 2: Setting Up Your Eden AI Account**

**第二步：配置 Eden AI 账户**

To start using Eden AI, you'll need to [create an account on the Eden AI platform](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com). Once you have an account, set your API KEY as an environment variable by running:

要开始使用 Eden AI，您需要先在 [Eden AI 平台](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com) 上注册账户。注册完成后，通过运行以下命令将您的 API KEY 设置为环境变量：

|     |
| --- |
| export Eden AI\_API\_KEY="your\_api\_key\_here" |

|     |
| --- |
| export EDENAI_API_KEY="your_api_key_here" |

**Step 3: Importing Eden AI LLMs and Embeddings**

**第三步：导入 Eden AI 的大语言模型（LLM）和嵌入（Embedding）模块**

The Eden AI API brings together various providers, each offering multiple models. Let's import the necessary modules for Eden AI LLMs and Embeddings:

Eden AI API 整合了多家服务商，每家均提供多种模型。下面我们导入 Eden AI 的大语言模型（LLM）与嵌入（Embedding）所需的相关模块：

|     |
| --- |
| from langchain.llms import EdenAI<br>from langchain.embeddings.edenai import EdenAiEmbeddings |

|     |
| --- |
| from langchain.llms import EdenAI<br>from langchain.embeddings.edenai import EdenAiEmbeddings |

**Step 4: Using Eden AI LLMs**

**第四步：使用 Eden AI 的大语言模型（LLM）**

Now, let’s instantiate an Eden AI LLM, in this case, OpenAI’s. Eden AI LLMs can be configured with multiple providers.

现在，让我们实例化一个 Eden AI 大语言模型（LLM），此处选用 OpenAI。Eden AI 的 LLM 支持配置多个服务提供商。

|     |
| --- |
| \`\`\`<br>llm=EdenAI(provider="openai", params={"temperature" : 0.2,"max\_tokens" : 250})<br>prompt = """<br>how can i create ai powered chatbots with LLMS<br>""<br>llm(prompt) |

|     |
| --- |
| ```<br>llm = EdenAI(provider="openai", params={"temperature": 0.2, "max_tokens": 250})<br>prompt = """<br>how can I create AI-powered chatbots with LLMs?<br>"""<br>llm(prompt) |

We've asked a question, and the LLM provides a detailed response:

我们提出一个问题，该大语言模型给出了详细回答：

|     |
| --- |
| "\\n\\nCreating an AI-powered chatbot with LLMS is relatively straightforward. First, you need to create a chatbot using the LLMS platform. This involves selecting a template, customizing the chatbot's conversation flow, and setting up the chatbot's naturallanguage processing (NLP) capabilities. Once the chatbot isset up, you can then integrate it with your existing systems, such as customer service software, toenable it to interact with customers. Finally, you can use the LLMS platform to monitor andanalyze the chatbot's performance, allowing you to make adjustments as needed." |

|     |
| --- |
| “\n\n使用 LLM 构建 AI 驱动的聊天机器人相对简单。首先，您需要在 LLM 平台上创建一个聊天机器人——这包括选择模板、自定义聊天机器人的对话流程，以及配置其自然语言处理（NLP）能力。一旦聊天机器人搭建完成，您便可将其集成至现有系统（例如客户服务软件），使其能够与客户交互。最后，您可借助 LLM 平台监控并分析聊天机器人的运行表现，从而按需进行优化调整。” |

You can see other examples of LLMs and how to set up chains with Eden AI [here](https://python.langchain.com/docs/integrations/llms/edenai?ref=blog.langchain.com).

您可在此处查看其他 LLM 示例及如何使用 Eden AI 构建链式调用：[点击访问](https://python.langchain.com/docs/integrations/llms/edenai?ref=blog.langchain.com)。

**Step 5: Exploring Eden AI Embeddings**

**第五步：探索 Eden AI 的嵌入（Embeddings）功能**

Next, we'll explore Eden AI's embeddings:

接下来，我们将探索 Eden AI 的嵌入（Embeddings）功能：

|     |
| --- |
| embeddings = EdenAiEmbeddings(provider="openai")<br>docs = \["Eden AI is integrated in LangChain", "AskYoda is Available"\]<br>document\_result = embeddings.embed\_documents(docs) |

|     |
| --- |
| embeddings = EdenAiEmbeddings(provider="openai")<br>docs = ["Eden AI is integrated in LangChain", "AskYoda is Available"]<br>document_result = embeddings.embed_documents(docs) |

Here is the response, with float numbers being the representation of the texts we had in input:

以下是返回结果，其中浮点数数组即为我们输入文本的向量表示：

|     |
| --- |
| \[\[0.013804426, -0.0032499523, -0.020794097, -0.01929681, -0.024726225, 0.015966397, -0.04086054, 0.0057792477, 0.0024628271, -0.01493089, 0.0055343644, 0.01719781, 0.008808806, -0.010725892, 0.007696335, 0.034283675, -0.0023963589, -0.006744788, -0.0066433363, 0.015700523, -0.024796192, 0.024334412, -0.018233318, -0.009914279, -0.001967813,<br>...<br>0.016727816, 0.0047793766, -0.015208363, -0.019269451, ...\]\] |

|     |
| --- |
| [[0.013804426, -0.0032499523, -0.020794097, -0.01929681, -0.024726225, 0.015966397, -0.04086054, 0.0057792477, 0.0024628271, -0.01493089, 0.0055343644, 0.01719781, 0.008808806, -0.010725892, 0.007696335, 0.034283675, -0.0023963589, -0.006744788, -0.0066433363, 0.015700523, -0.024796192, 0.024334412, -0.018233318, -0.009914279, -0.001967813,<br>…<br>0.016727816, 0.0047793766, -0.015208363, -0.019269451, …]] |

😎 You’re all set! With the knowledge of how to use embeddings and LLMs, you now possess the capability to create an array of impressive functionalities, ranging from basic AI assistants to the development of custom chatbots.

😎 一切就绪！掌握了嵌入（embeddings）和大语言模型（LLMs）的使用方法后，您现在已具备构建多种强大功能的能力——从基础 AI 助手到定制化聊天机器人，皆可轻松实现。

**Tutorial 2: Supercharge your app with advanced AI capabilities**

**教程 2：借助高级 AI 能力为您的应用赋能**

In our second tutorial, you will learn how to easily integrate Eden AI features (specifically Document Parsing) into your app.

在本系列第二篇教程中，您将学习如何轻松将 Eden AI 的功能（特别是文档解析，Document Parsing）集成至您的应用程序中。

This integration will catapult your applications to a new echelon of versatility and responsiveness, ensuring you remain at the forefront of innovation in the ever-evolving AI landscape.

这一集成将极大提升您应用的灵活性与响应能力，助您始终站在日新月异的 AI 技术创新前沿。

**Step 1: Preparing Your Environment**

**步骤 1：准备开发环境**

First, ensure Python is installed on your system. Then, install LangChain by running the following command:

首先，请确认您的系统已安装 Python。随后，运行以下命令安装 LangChain：

|     |
| --- |
| pip install langchain |

|     |
| --- |
| pip install langchain |

**Step 2: Obtaining an Eden AI API Key**

**步骤 2：获取 Eden AI API 密钥**

Before you begin, you'll need an [API key from the Eden AI platform.](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com)

开始之前，您需要从 [Eden AI 平台获取一个 API 密钥。](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com)

**Step 3: Importing Necessary Modules**

**步骤 3：导入必要模块**

Let's import the [modules](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com) required for our advanced AI capabilities (here, Parsing ID and Invoice Tools)

让我们导入实现高级 AI 功能所需的[模块](https://python.langchain.com/docs/integrations/tools/edenai_tools?ref=blog.langchain.com)（此处为身份证解析工具和发票解析工具）

|     |
| --- |
| from langchain.llms import EdenAI<br>from langchain.agents import initialize\_agent, AgentType<br>from langchain.tools.edenai import (<br>EdenAiParsingIDTool,<br>EdenAiParsingInvoiceTool<br>)<br>import os |

|     |
| --- |
| from langchain.llms import EdenAI<br>from langchain.agents import initialize\_agent, AgentType<br>from langchain.tools.edenai import (<br>EdenAiParsingIDTool,<br>EdenAiParsingInvoiceTool<br>)<br>import os |

**Step 4: Setting Up you Eden AI API key**

**步骤 4：配置 Eden AI API 密钥**

Set your Eden AI API key as an environment variable in your system. Replace it with your own API Key.

将您的 Eden AI API 密钥设置为系统环境变量，并用您自己的 API 密钥替换下方占位符。

|     |
| --- |
| os.environ\['Eden AI\_API\_KEY'\] = "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" # replace with your own API Key |

|     |
| --- |
| os.environ\['Eden AI\_API\_KEY'\] = "\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*" # 请替换为您自己的 API 密钥 |

**Step 5. Initializing the LLM**

**步骤 5：初始化大语言模型（LLM）**

Eden AI provides a range of providers, which you can explore [here](https://github.com/edenai/edenai-apis/blob/master/AVAILABLES_FEATURES_AND_PROVIDERS.md?ref=blog.langchain.com). For this tutorial, we'll choose Eden AI LLM to setup the LLM provider (here, OpenAI, text-davinci-003):

Eden AI 提供多种模型服务商，您可在此处查阅完整列表：[链接](https://github.com/edenai/edenai-apis/blob/master/AVAILABLES_FEATURES_AND_PROVIDERS.md?ref=blog.langchain.com)。本教程中，我们将选用 Eden AI 的 LLM 接口，并配置其后端服务商（此处为 OpenAI 的 `text-davinci-003` 模型）：

|     |
| --- |
| llm=EdenAI(provider="openai", model="text-davinci-003", params={"temperature" : 0.2,"max\_tokens" : 250}) |

|     |
| --- |
| llm=EdenAI(provider="openai", model="text-davinci-003", params={"temperature" : 0.2,"max\_tokens" : 250}) |

**Step 6. Setting Up Tools and the Agent**

**步骤 6：配置工具与智能体（Agent）**

Now, it's time to configure the tools and the agent:

现在，我们来配置所需工具及智能体（Agent）：

|     |
| --- |
| tools = \[<br>    EdenAiParsingIDTool(providers=\["amazon","klippa"\],language="en"),<br>    EdenAiParsingInvoiceTool(providers=\["amazon","google"\],language="en"),<br>\]<br>agent\_chain = initialize\_agent(<br>    tools,<br>    llm,<br>agent=AgentType.ZERO\_SHOT\_REACT\_DESCRIPTION,<br>verbose=True,<br>return\_intermediate\_steps=True,<br>) |

|     |
| --- |
| tools = \[<br>    EdenAiParsingIDTool(providers=\["amazon","klippa"\], language="en"),<br>    EdenAiParsingInvoiceTool(providers=\["amazon","google"\], language="en"),<br>\]<br>agent\_chain = initialize\_agent(<br>    tools,<br>    llm,<br>    agent=AgentType.ZERO\_SHOT\_REACT\_DESCRIPTION,<br>    verbose=True,<br>    return\_intermediate\_steps=True,<br>) |

**Step 7: Executing the Agent**

**第七步：运行智能体**

Let's put our agent to work with the Doc Parsing Bot to analyze identification or invoice documents.

让我们启动智能体，借助文档解析机器人（Doc Parsing Bot）来分析身份证件或发票文档。

Our data consists of 2 image URLs:

我们的数据包含两个图像 URL：

- The ID image:

- 身份证件图像：

[https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png](https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png?ref=blog.langchain.com)

[https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png](https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png?ref=blog.langchain.com)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_004.png)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_004.png)

- The invoice image: “ [https://app.edenai.run/assets/img/data\_1.72e3bdcc.png](https://app.edenai.run/assets/img/data_1.72e3bdcc.png?ref=blog.langchain.com)”

- 发票图像：“[https://app.edenai.run/assets/img/data\_1.72e3bdcc.png](https://app.edenai.run/assets/img/data_1.72e3bdcc.png?ref=blog.langchain.com)”

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_005.png)

![](images/eden-ai-x-langchain-harnessing-llms-embeddings-and-ai/img_005.png)

Now, let’s extract the information from the ID and create a welcoming text:

现在，让我们从身份证图像中提取信息，并生成一段欢迎文字：

|     |
| --- |
| id\_result=agent\_chain(""" i have this url of an id: "https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png"<br>                        extract the information in it.<br>                        create a text welcoming the person.<br>                   """)<br>\> Entering new AgentExecutor chain... |

|     |
| --- |
| id\_result=agent\_chain("""我有这张身份证的 URL：“https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png”<br>                        请从中提取信息。<br>                        并生成一段欢迎该人员的文字。<br>                   """)<br>\> 正在进入新的 AgentExecutor 链… |

The result:

结果：

|     |
| --- |
| Action: Eden AI\_identity\_parsing <br>Action Input:"https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png"Observation:<br>last\_name :value : ANGELA <br>given\_names :value : GREENE <br>birth\_place :<br>birth\_date :value :2000-11-09<br>issuance\_date :<br>expire\_date :value :2025-07-31<br>document\_id :value :5843<br>issuing\_state :<br>address :<br>age :<br>country :<br>document\_type :value : DRIVER LICENSE FRONT <br>gender :<br>Thought: I now have the information from the ID and can create a welcoming text. Final Answer: Welcome Angela Greene! |

|     |
| --- |
| 操作：Eden AI\_identity\_parsing <br>操作输入："https://www.citizencard.com/images/sample-cards/uk-id-card-for-over-18s-2023.png"<br>观察结果：<br>last\_name（姓氏）: ANGELA <br>given\_names（名字）: GREENE <br>birth\_place（出生地）:（未提供）<br>birth\_date（出生日期）: 2000-11-09<br>issuance\_date（签发日期）:（未提供）<br>expire\_date（有效期至）: 2025-07-31<br>document\_id（证件编号）: 5843<br>issuing\_state（签发州/地区）:（未提供）<br>address（地址）:（未提供）<br>age（年龄）:（未提供）<br>country（国家）:（未提供）<br>document\_type（证件类型）: DRIVER LICENSE FRONT（驾照正面）<br>gender（性别）:（未提供）<br>思考：我现在已获取身份证中的全部信息，可以生成欢迎文字。<br>最终答案：欢迎 Angela Greene！ |

Then, let’s extract the information from the invoice and summarize it:

接下来，让我们从发票中提取信息并进行摘要：

|     |
| --- |
| invoice\_result=agent\_chain(""" i have this url of an invoice document: "https://app.Eden AI.run/assets/img/data\_2.d6af6d85.png"<br>                        extract the information in it.<br>Summarize them.<br>                   """)<br>\> Entering new AgentExecutor chain... |

|     |
| --- |
| invoice\_result=agent\_chain("""我有这张发票文档的 URL：“https://app.Eden AI.run/assets/img/data\_2.d6af6d85.png”<br>                        请从中提取信息。<br>并对这些信息进行摘要。<br>                   """)<br>\> 正在进入新的 AgentExecutor 链… |

|     |
| --- |
| The result: <br>Action: Eden AI\_invoice\_parsing <br>Action Input: "https://app.Eden AI.run/assets/img/data\_2.d6af6d85.png"<br>Observation: <br>customer\_information : <br>customer\_name : Wiseman Water <br>customer\_address : Wiseman Water,151 Narrows Parkway,Birmingham West Midlands B11,United Kingdom <br>merchant\_information : <br>merchant\_name : Gravity PDF <br>merchant\_address : ABN: 74212487581,48 Federation Way,Telegraph Point NSW 2441, Australia <br>merchant\_website : gravitypdf.com <br>merchant\_tax\_id : 74212487581<br>invoice\_number : PDF47-WEB <br>taxes : <br>date : 2017-01-31<br>locale : <br>currency : GBP <br>bank\_informations : <br>item\_lines : <br>product\_code : Laptop <br>description : Laptop Upgrades: 2GB Extra Ram,<br>Laptop Upgrades: Second 512GB Hard Drive <br>description : Accessories,Accessories: Laser Mouse / Keyboard Combo <br>Thought: I now have all the information from the invoice <br>Final Answer: The invoice from Wiseman Water to Gravity PDF (invoice number PDF47-WEB) contains the following items: Laptop Upgrades: 2GB Extra Ram, Laptop Upgrades: Second 512GB Hard Drive, Accessories: Laser Mouse / Keyboard Combo. The merchant is Gravity PDF, located at ABN: 74212487581, 48 Federation Way, Telegraph Point NSW 2441, Australia, with website gravitypdf.com and tax ID 74212487581. The customer is Wiseman Water, located at 151 Narrows Parkway, Birmingham West Midlands B11, United Kingdom. The invoice was issued on 2017-01-31 and the currency is GBP. |

|     |
| --- |
| 结果：<br>操作：Eden AI\_invoice\_parsing <br>操作输入："https://app.Eden AI.run/assets/img/data\_2.d6af6d85.png"<br>观察结果：<br>customer\_information（客户信息）：<br>customer\_name（客户名称）：Wiseman Water<br>customer\_address（客户地址）：Wiseman Water，151 Narrows Parkway，Birmingham West Midlands B11，英国<br>merchant\_information（商户信息）：<br>merchant\_name（商户名称）：Gravity PDF<br>merchant\_address（商户地址）：ABN: 74212487581，48 Federation Way，Telegraph Point NSW 2441，澳大利亚<br>merchant\_website（商户网站）：gravitypdf.com<br>merchant\_tax\_id（商户税号）：74212487581<br>invoice\_number（发票编号）：PDF47-WEB<br>taxes（税费）：（未提供）<br>date（开票日期）：2017-01-31<br>locale（区域设置）：（未提供）<br>currency（货币）：GBP<br>bank\_informations（银行信息）：（未提供）<br>item\_lines（商品明细）：<br>product\_code（产品编码）：Laptop<br>description（描述）：Laptop Upgrades: 2GB Extra Ram（笔记本升级：额外 2GB 内存），<br>Laptop Upgrades: Second 512GB Hard Drive（笔记本升级：第二块 512GB 硬盘）<br>description（描述）：Accessories（配件），Accessories: Laser Mouse / Keyboard Combo（配件：激光鼠标/键盘套装）<br>思考：我现在已完整获取该发票的所有信息。<br>最终答案：本发票由 Wiseman Water 开具给 Gravity PDF（发票编号：PDF47-WEB），所含商品包括：笔记本升级（额外 2GB 内存）、笔记本升级（第二块 512GB 硬盘）、配件（激光鼠标/键盘套装）。商户为 Gravity PDF，地址为 ABN: 74212487581，48 Federation Way，Telegraph Point NSW 2441，澳大利亚；官网为 gravitypdf.com，税号为 74212487581。客户为 Wiseman Water，地址为 151 Narrows Parkway，Birmingham West Midlands B11，英国。发票开具日期为 2017-01-31，币种为英镑（GBP）。 |

👏 Congrats you’re all done! The integration of Eden AI features into LangChain Tools opens up a world of possibilities for developers. With features such as invoice parsing, ID parsing, as well as object detection, or even explicit content detection, developers can enhance their applications with advanced AI capabilities.

👏 恭喜您已完成全部操作！将 Eden AI 功能集成至 LangChain Tools，为开发者打开了无限可能的大门。借助发票解析、身份证解析、物体检测，乃至敏感内容识别等功能，开发者可为其应用注入前沿 AI 能力。

**Conclusion**

**结论**

Overall, Eden AI streamlines the integration of AI, offering a user-friendly platform that simplifies the labyrinth of APIs and authentication. It grants access to a diverse range of AI capabilities, spanning text and image generation, OCR, speech-to-text, and image analysis, all with the convenience of a single API key and minimal code.

总体而言，Eden AI 极大地简化了 AI 技术的集成流程，提供了一个用户友好的平台，有效化解了繁杂多样的 API 接口与身份认证难题。它支持丰富多样的 AI 能力，涵盖文本与图像生成、OCR（光学字符识别）、语音转文字（speech-to-text）以及图像分析等，仅需一个 API 密钥与极少代码即可便捷调用。

The integration with LangChain further enhances this by providing effortless access to various LLMs and Embeddings. Additionally, Eden AI provides robust cost management features, ensuring you optimize your AI investments effectively.

与 LangChain 的深度集成进一步强化了这一优势，使开发者能轻松接入各类大语言模型（LLM）与嵌入模型（Embeddings）。此外，Eden AI 还提供强大的成本管理功能，助您高效优化 AI 投入产出比。

Whether you're starting with the basics or delving into advanced integration, you now have the tools and knowledge to harness Eden AI and LangChain's capabilities to simplify AI integration and supercharge your applications.  

无论您是从基础起步，还是深入高级集成，您现在都已拥有相应的工具与知识，能够充分利用 Eden AI 和 LangChain 的能力，简化 AI 集成流程，并为您的应用注入强大动力。

[Get your API key for FREE](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com) and start revolutionizing your AI integration today!  

[立即免费获取您的 API 密钥](https://app.edenai.run/user/register?referral=article-langchain&ref=blog.langchain.com)，即刻开启您的 AI 集成革新之旅！