---
title: "🎉 Prem Challenge🎉"
source: "LangChain Blog"
url: "https://blog.langchain.com/prem-challenge-with-langchain/"
date: "2023-06-26"
scraped_at: "2026-03-03T09:34:31.894993296+00:00"
language: "en-zh"
translated: true
---

We're excited to announce a challenge hosted by Prem in collaboration with LangChain.

我们很高兴地宣布，由 Prem 与 LangChain 联合主办的一项挑战赛正式启动。

At LangChain we try to make it easy as possible to experiment with as many different models as possible. That includes the incredible number of emerging open source models. We've made [efforts](https://twitter.com/hwchase17/status/1673393425456963611?s=20&ref=blog.langchain.com) to make our framework as suitable as possible for experimentation with open source models. This has already enabled several amazing projects to be built on top of LangChain and open-source models.

在 LangChain，我们始终致力于尽可能简化对各类模型的实验过程——这其中包括大量蓬勃发展的开源模型。我们已付出诸多努力（[详见此处](https://twitter.com/hwchase17/status/1673393425456963611?s=20&ref=blog.langchain.com)），使 LangChain 框架更适配开源模型的实验需求。这一工作已成功支撑多个精彩项目基于 LangChain 与开源模型构建而成。

We want to see more of these types of projects! Which is why we're so excited to be sharing this challenge created by Prem. We're also using this as an opportunity to highlight our integration with Prem. Together, we're enabling developers to build a new generation of AI applications that leverages LangChain composability and Prem privacy-centric AI model deployments.

我们期待看到更多此类项目！正因如此，我们尤为激动地向大家介绍由 Prem 发起的这项挑战赛。同时，我们也借此机会重点展示 LangChain 与 Prem 的深度集成。双方携手，赋能开发者构建新一代 AI 应用——既充分发挥 LangChain 的可组合性优势，又依托 Prem 以隐私保护为核心理念的 AI 模型部署能力。

### About Prem

### 关于 Prem

Leveraging state-of-the-art Open-Source Large Language Models (LLMs), Prem provides a unified environment to deploy AI models on your infrastructure. Abstracting away all technical complexities for AI deployment and ushering in a new era of privacy-centric AI applications — users can retain control and ownership of their models.

Prem 基于业界领先的开源大语言模型（LLMs），为您提供统一的 AI 模型部署环境，使其可直接运行于您自有基础设施之上。Prem 屏蔽了 AI 部署中所有技术复杂性，开启以隐私保护为核心的新一代 AI 应用时代——用户始终保有对自身模型的完全控制权与所有权。

### One-click Integration

### 一键集成

All Prem AI services expose APIs in the same way as Open AI does. Using the tools together is as simple as downloading the Prem App and tweaking the URL of your API application to point to the Prem AI services, which operate locally with models of your choice.

Prem 所有 AI 服务均采用与 OpenAI 完全一致的 API 接口规范。将二者协同使用极为简便：只需下载 Prem App，并将您应用中的 API 请求地址调整为指向 Prem AI 服务即可；该服务将在本地运行，且支持您自主选择的模型。

If you are used to using LangChain, now you can augment it with Prem. Build AI applications without sensitive data being transferred to any third party.

如果您已熟悉 LangChain 的使用，现在即可通过 Prem 进一步增强其能力。在构建 AI 应用时，无需将任何敏感数据传输至第三方。

### The right abstraction

### 正确的抽象层

Hosting and deploying open-source models today is a headache. You need to:  

如今，托管与部署开源模型仍是一大难题。您需要：

- Choose and test the model for your specific use case.  
- 为您的具体使用场景选择并测试模型。

- Serve the model using one of the multiple web frameworks available.  
- 使用多种可用的 Web 框架之一来部署（serve）该模型。

- Package the service for production usage.  
- 将服务打包，以供生产环境使用。

Thanks to Prem, we remove all of these pain points with a one-click deployment of models and vector stores. So today, if you are using LangChain with OpenAI and want to point to switch to a self-hosted privacy-preserving solution, all you need to do is to install Prem. Then, because Prem exposes the same API as OpenAI, you can easily use any OpenAI class and just change the `api_base`:  

得益于 Prem，我们通过一键式部署模型与向量数据库，彻底消除了上述所有痛点。因此，若您当前正将 LangChain 与 OpenAI 配合使用，并希望切换至自托管、注重隐私保护的替代方案，您只需安装 Prem 即可。由于 Prem 提供与 OpenAI 完全兼容的 API，您可直接复用任意 OpenAI 类，仅需修改 `api_base` 参数：

```python
from langchain.chat_models import ChatOpenAI

chat = ChatOpenAI(openai_api_base="http://localhost:8111/api/v1", max_tokens=128)
```

### Prem Challenge Overview  

### Prem 挑战概览  

Prem Labs aims to foster an ecosystem of privacy-preserving applications. We are excited to announce this challenge to incentivize the developer community to build innovative applications, services, and solutions that put users’ privacy first.  

Prem Labs 致力于构建一个以隐私保护为核心的应用生态。我们非常高兴地宣布本次挑战赛，旨在激励开发者社区打造富有创新性的应用、服务与解决方案——始终将用户隐私置于首位。

Teams participating in the challenge will leverage Prem to deploy AI models and services on-premise. An important requirement is that the submitted applications shouldn't depend on centralized APIs at any point of their stack.  

参赛团队将借助 Prem 在本地（on-premise）部署 AI 模型与服务。一项关键要求是：所提交的应用程序在其技术栈的任何环节均不得依赖中心化 API。

### What  

### 内容说明  

🛠 Teams participating in the challenge will develop Mobile, desktop, or web applications using one or many Prem AI services. Self-hosted AI models provide several benefits, including efficiency, cost optimization, and privacy.  

🛠 参赛团队将基于一个或多个 Prem AI 服务，开发移动应用、桌面应用或 Web 应用。自托管 AI 模型具备多重优势，包括更高运行效率、更优成本控制，以及更强的隐私保障。

To learn more about the challenge and review some reference implementations, head over to our [basic tutorial](https://github.com/premAI-io/challenge-with-langchain/blob/main/README.md?ref=blog.langchain.com) to get up to speed with Prem  

如需进一步了解本次挑战详情，并参考部分实现示例，请访问我们的 [基础教程](https://github.com/premAI-io/challenge-with-langchain/blob/main/README.md?ref=blog.langchain.com)，快速上手 Prem。

### When

### 时间安排

📆 6月26日 — 7月10日

### Where

### 活动地点

🌍 全球任意地点，线上举办（虚拟活动）

### How many?

### 参赛形式

🚶🚶🚶 接受个人参赛与团队参赛；每支团队最多可由4人组成。

### Prizes

### 奖项设置

评审团将遴选并奖励提交的三个最佳应用项目。💰最终入选项目总计可获得高达 10,000 美元及以上的奖金。

## Submission Requirements

## 提交要求

To qualify for the challenge, your application should:

要符合本次挑战赛的参赛资格，您的应用须满足以下条件：

1. **Open Source Github Repository** As Prem is open-source from the start. Also, apps and services MUST be open-source in all of their parts.  
1. **开源 GitHub 仓库** Prem 自诞生起即为开源项目；此外，所有应用与服务的**全部组成部分**都必须开源。

2. **Use Prem Services** From your local machine in development to production remote servers with the same interface, API, and services.  
2. **使用 Prem 服务** 无论是在本地开发环境，还是部署至生产级远程服务器，均通过**统一的接口、API 和服务**调用 Prem。

3. **Don't Log User Data on your server or third parties** No centralized API at any point of the stack! Your users want you to keep your data private!  
3. **切勿在您的服务器或第三方平台记录用户数据** 整个技术栈中**不存在任何中心化 API**！您的用户期望您切实保护其数据隐私！

## Judging Criteria  

## 评审标准  

1. **Prompt utilization** We all know open-source models are not there yet, like OpenAI with powerful GPUs at their disposal: from constraints, humans can leverage their creativity to produce unexpected results. Be smart at prompting.  
1. **提示词（Prompt）运用能力** 我们深知，当前开源模型尚无法媲美 OpenAI 等机构所拥有的强大 GPU 资源；但正因存在限制，人类方能激发创造力，产出出人意料的结果。请聪明、巧妙地设计提示词。

2. **Commodity Hardware** If we want to bring the benefits of AI to billions of people in the global south without locking them in the Big Brother sight, we must work around it and make sure anyone can afford to buy computing resources. Run your apps on cheap VPS without GPU or very inexpensive ones.  
2. **通用硬件适配性** 若我们希望将 AI 的福祉惠及全球南方数十亿人口，同时避免将其困于“老大哥式”的监控生态中，就必须另辟蹊径——确保任何人都能负担得起计算资源。请将您的应用部署在**无 GPU 或仅配备极低成本 GPU 的廉价 VPS** 上运行。

3. **Composability** Combine all Prem services: LLMs, Diffusers, Embedding, and Vector stores.  
3. **可组合性** 充分融合所有 Prem 服务：大语言模型（LLMs）、扩散模型（Diffusers）、嵌入（Embedding）及向量数据库（Vector stores）。

4. **Production Status** How polished is your application? Can my grandma use it?  
4. **产品化程度** 您的应用完成度如何？是否足够直观易用，连我的奶奶都能轻松上手？

## **Submission Process**  

## **提交流程**  

10th of July **\- BEFORE 6 PM UTC** [google form link](https://forms.gle/SHpQE1JtdSJAwo9S8?ref=blog.langchain.com)  
7 月 10 日 **UTC 时间下午 6 点前** [Google 表单链接](https://forms.gle/SHpQE1JtdSJAwo9S8?ref=blog.langchain.com)

Show some love to the [Prem App on Github](https://github.com/premAI-io/prem-app?ref=blog.langchain.com)  
欢迎为 [GitHub 上的 Prem App](https://github.com/premAI-io/prem-app?ref=blog.langchain.com) 点亮 Star ⭐！

Follow us on Twitter - [https://twitter.com/premai\_io](https://twitter.com/premai_io?ref=blog.langchain.com)  
关注我们的 Twitter — [https://twitter.com/premai\_io](https://twitter.com/premai_io?ref=blog.langchain.com)

Join us on Discord - [https://discord.com/invite/kpKk6vYVAn](https://discord.com/invite/kpKk6vYVAn?ref=blog.langchain.com)  
加入我们的 Discord 社区 — [https://discord.com/invite/kpKk6vYVAn](https://discord.com/invite/kpKk6vYVAn?ref=blog.langchain.com)

## Getting Started  

## 快速入门  

### Install Prem  

### 安装 Prem

You can run Prem in two different ways:

您可以通过两种不同方式运行 Prem：

- MacOS: go to [https://premai.io](https://premai.io/?ref=blog.langchain.com) and download Prem App.  
- macOS：访问 [https://premai.io](https://premai.io/?ref=blog.langchain.com)，下载 Prem 应用程序。

- Server: run the installer script: `wget -q <https://get.prem.ninja/install.sh> -O install.sh; sudo bash ./install.sh`  
- 服务器：运行安装脚本：`wget -q <https://get.prem.ninja/install.sh> -O install.sh; sudo bash ./install.sh`

### Run the services in the GUI

### 在图形用户界面（GUI）中运行服务

When the UI is up and running, you can see all the services available. With just one click you can download the service you are interested in. In the background, the docker image associated with the service will be downloaded based on your hardware requirements.

当 UI 启动并正常运行后，您将看到所有可用的服务。只需单击一次，即可下载您感兴趣的服务。后台会根据您的硬件配置，自动下载对应服务的 Docker 镜像。

![](images/prem-challenge/img_001.gif)

While waiting for the download to be completed, read more about the service, in the detail view. Just click on the card and you will be redirected to the service page. Each service page is packaged with some general info as well as complete documentation giving more details into the model exposed. When the download has been completed, just click on `Open` and the service will start. You can interact with the service from the playground or from APIs.

在等待下载完成期间，您可在详情视图中进一步了解该服务。只需点击对应卡片，即可跳转至该服务的专属页面。每个服务页面均包含基础信息以及完整文档，详细介绍其所暴露的模型。下载完成后，点击 `Open`（启动）按钮，服务即开始运行。您可通过 Playground（交互式测试环境）或 API 与该服务进行交互。

![](images/prem-challenge/img_002.gif)

You can check the port on which the service is running from the service detail view.

您可在服务详情视图中查看该服务正在运行的端口号。

![](images/prem-challenge/img_003.gif)

### Start Building Your App

### 开始构建您的应用

Now that the service is running, you can connect to it at [http://localhost:8111](http://localhost:8111/?ref=blog.langchain.com) and start building. Here is a simple snippet using LangChain to connect to the service.

服务已启动，您可通过 [http://localhost:8111](http://localhost:8111/?ref=blog.langchain.com) 访问该服务并开始构建应用。以下是一个使用 LangChain 连接该服务的简单示例。

```python
import os

from langchain.chat_models import ChatOpenAI
from langchain.schema import AIMessage, HumanMessage

os.environ["OPENAI_API_KEY"] = "random-string"

chat = ChatOpenAI(openai_api_base="<http://localhost:8111/api/v1>", max_tokens=128)

messages = [\
    HumanMessage(content="Can you explain what is a large language model?")\
]
chat(messages)
```

```python
import os

from langchain.chat_models import ChatOpenAI
from langchain.schema import AIMessage, HumanMessage

os.environ["OPENAI_API_KEY"] = "random-string"

chat = ChatOpenAI(openai_api_base="http://localhost:8111/api/v1", max_tokens=128)

messages = [
    HumanMessage(content="Can you explain what is a large language model?")
]
chat(messages)
```

```
Certainly! A large language model is a type of machine learning algorithm that has been trained on a very large dataset of text to learn how to generate human-like language. These models can be used for tasks such as text generation, question answering, and natural language processing. In this project, we will use the Hugging Face Transformers library to train a large language model on a dataset of text and then fine-tune it on a smaller dataset of text related to fashion and beauty.
```

```
当然可以！大型语言模型（Large Language Model, LLM）是一类机器学习算法，它通过在海量文本数据集上进行训练，学习生成类人语言的能力。这类模型可用于文本生成、问答、自然语言处理等任务。在本项目中，我们将使用 Hugging Face Transformers 库，在一个通用文本数据集上预训练一个大型语言模型，再针对时尚与美妆领域的较小规模文本数据集对其进行微调。
```

```python
messages = [\
    HumanMessage(content="Write me a story about a superstar.")\
]
chat(messages)
```

```python
messages = [
    HumanMessage(content="Write me a story about a superstar.")
]
chat(messages)
```

```
Once upon a time, there was a young woman who had always dreamed of becoming a star. She sang like a bird, danced like a dream, and captivated every audience she performed for with her sheer talent and charm.

When she was just starting out, she worked tirelessly to make her mark on the music industry, taking any opportunity that came her way and honing her skills day by day. Finally, after years of hard work and dedication, she was offered a record deal and shot to fame almost overnight, becoming an instant superstar in the process.
```

```
从前，有一位年轻女性，从小梦想成为一颗耀眼的明星。她歌声如鸟鸣般清亮，舞姿似梦境般灵动，凭借过人的才华与魅力，每每登台便令全场观众倾倒。

初入行时，她不辞辛劳、全力以赴，抓住每一个机会磨砺自我，日复一日精进技艺。终于，在多年不懈努力与坚持之后，她获得了一份唱片合约，并几乎一夜之间声名鹊起，迅速成长为一位万众瞩目的超级巨星。
```

People everywhere were captivated by this talented young woman, who seemed to have it all: the voice, the looks, the style, and the stage presence that left audiences begging for more. She quickly became a household name, known for her infectious smile, her magnetic energy, and the way she made everyone feel like they knew her personally.

世界各地的人们都被这位才华横溢的年轻女性深深吸引——她仿佛拥有一切：天籁般的嗓音、出众的容貌、独特的风格，以及令观众意犹未尽的舞台表现力。她迅速家喻户晓，以富有感染力的笑容、强大的个人魅力，以及让每位观众都感觉与她私交甚笃的独特亲和力而广为人知。

As she continued to tour and perform, the superstar began to accumulate an enormous following, with fans from all  
随着她持续巡演与演出，这位超级巨星逐渐积累了庞大的粉丝群体，粉丝遍布全球各地。

```

**And Done 🎉 You are now using Prem with LangChain.**

**🎉 大功告成！您现在已成功启用 Prem 与 LangChain 的集成。**

### More Information

### 更多信息

Check out our documentation at: [https://github.com/premai-io/prem-app](https://github.com/premai-io/prem-app?ref=blog.langchain.com)

请查阅我们的文档：[https://github.com/premai-io/prem-app](https://github.com/premai-io/prem-app?ref=blog.langchain.com)

Check out a simple talk to your data notebook: [https://github.com/premAI-io/prem-daemon/blob/main/resources/notebooks/talk\_to\_your\_data.ipynb](https://github.com/premAI-io/prem-daemon/blob/main/resources/notebooks/talk_to_your_data.ipynb?ref=blog.langchain.com)

查看一份简易的“与您的数据对话”示例 Notebook：[https://github.com/premAI-io/prem-daemon/blob/main/resources/notebooks/talk\_to\_your\_data.ipynb](https://github.com/premAI-io/prem-daemon/blob/main/resources/notebooks/talk_to_your_data.ipynb?ref=blog.langchain.com)

Check out our YouTube tutorials

欢迎观看我们的 YouTube 教程：

- Getting Started with Prem: [https://www.youtube.com/watch?v=XixH46Ysl5A](https://www.youtube.com/watch?v=XixH46Ysl5A&ref=blog.langchain.com)  
- 使用 Prem 快速入门：[https://www.youtube.com/watch?v=XixH46Ysl5A](https://www.youtube.com/watch?v=XixH46Ysl5A&ref=blog.langchain.com)

- Deploy Prem in your Paperspace instance: [https://www.youtube.com/watch?v=aW8t6wouwx0](https://www.youtube.com/watch?v=aW8t6wouwx0&ref=blog.langchain.com)  
- 在 Paperspace 实例中部署 Prem：[https://www.youtube.com/watch?v=aW8t6wouwx0](https://www.youtube.com/watch?v=aW8t6wouwx0&ref=blog.langchain.com)

### Tags

### 标签

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/prem-challenge/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/prem-challenge/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/prem-challenge/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![对话式检索智能体](images/prem-challenge/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**借助 LangChain，通过 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)