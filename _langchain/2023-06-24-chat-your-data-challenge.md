---
title: "Chat-Your-Data Challenge"
source: "LangChain Blog"
url: "https://blog.langchain.com/chat-your-data-challenge/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:34:48.353447041+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

ChatGPT has taken the world by storm. Millions are using it. But while it’s great for general purpose knowledge, it only knows information about what it has been trained on, which is pre-2021 generally available internet data. It doesn’t know about your private data, it doesn’t know about recent sources of data.

ChatGPT 已席卷全球，数以百万计的用户正在使用它。然而，尽管它在通用知识领域表现出色，但它仅能访问其训练数据所涵盖的信息——这些数据通常是截至 2021 年前公开可获取的互联网内容。它不了解你的私有数据，也不了解近期产生的各类数据源。

Wouldn’t it be useful if it did? This is where [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com) comes in.

如果它能访问这些数据，岂不是非常有用？这正是 [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com) 的用武之地。

The goal of LangChain is to make it easier for everyone to develop language model applications. We recently published a guide on how to create your own ChatGPT over your data [here](https://blog.langchain.com/tutorial-chatgpt-over-your-data/). This included [an example GitHub repo](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com) to start from and customize. But even still, there is a long tail of data sources to integrate with and write prompts for. We realized this after putting a call out to see what the most interesting integrations would be and getting an overwhelming response.

LangChain 的目标是让所有人都能更轻松地开发大语言模型（LLM）应用。我们最近发布了一篇教程，介绍如何基于你自己的数据构建专属的 ChatGPT：[点击查看](https://blog.langchain.com/tutorial-chatgpt-over-your-data/)。该教程附带了一个 [示例 GitHub 仓库](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)，供你快速上手并按需定制。但即便如此，仍存在大量长尾数据源亟待接入，也需为不同场景编写适配的提示词（prompts）。我们在发起社区调研、征集“最具价值的数据集成需求”时，收到了远超预期的热烈反馈，由此深刻意识到这一挑战的广泛性与重要性。

> Gonna beef up the tutorials for how to create your own Chat-GPT over specific documents with [@LangChainAI](https://twitter.com/LangChainAI?ref_src=twsrc%5Etfw&ref=blog.langchain.com)
>
> What types of documents/knowledge bases would people want to have examples for? Eg Notion, Obsidian, webpages, etc
>
> — Harrison Chase (@hwchase17) [February 6, 2023](https://twitter.com/hwchase17/status/1622419133949411328?ref_src=twsrc%5Etfw&ref=blog.langchain.com)

> 我们将加强教程建设，帮助大家基于特定文档（如 Notion、Obsidian、网页等）打造专属 ChatGPT —— 由 [@LangChainAI](https://twitter.com/LangChainAI?ref_src=twsrc%5Etfw&ref=blog.langchain.com) 提供支持  
>   
> 大家最希望看到哪些类型文档或知识库的实战示例？例如 Notion、Obsidian、网页等。  
>   
> — Harrison Chase（@hwchase17）[2023 年 2 月 6 日](https://twitter.com/hwchase17/status/1622419133949411328?ref_src=twsrc%5Etfw&ref=blog.langchain.com)

In a "Chat-Your-Data" Challenge, we're launching a week long challenge to create ChatGPT over your data sources.

本次 “Chat-Your-Data” 挑战赛，我们将发起为期一周的开源共建活动，邀请大家基于自己的数据源打造专属 ChatGPT。

### Motivation

### 活动初衷

The motivation for doing this is, as always, to make it easier for everyone to develop language model applications. In particular, we believe that examples are critically important for helping people do so. Therefore, we are hoping to get as many examples (data loaders + prompts) as possible for doing this for various data sources.

本次活动的初衷一如既往：降低所有人开发大语言模型应用的门槛。尤其重要的是，我们认为高质量的示例（包括数据加载器 + 提示词）对开发者而言至关重要。因此，我们诚挚希望汇聚尽可能多样的数据源示例（涵盖各类数据加载逻辑与配套提示词），覆盖尽可能广泛的使用场景。

We will then put the data loading logic in [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com), put the prompts in [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com), and put the examples in the [LangChain documentation](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com) to make it as easy as possible for others to get started.

随后，我们将把数据加载逻辑整合进 [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com)，把提示词上传至 [LangChainHub](https://github.com/hwchase17/langchain-hub?ref=blog.langchain.com)，并将完整示例纳入 [LangChain 官方文档](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com)，最大限度地降低后续开发者的入门难度。

### How to get started

### 如何参与

1. Clone the [example GitHub repo](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)  
1. 克隆该 [示例 GitHub 仓库](https://github.com/hwchase17/chat-your-data?ref=blog.langchain.com)

2. Customize the data source + prompts to your data (can follow [this tutorial](https://blog.langchain.com/tutorial-chatgpt-over-your-data/))  
2. 根据你的数据定制数据源接入方式与提示词（可参考 [本教程](https://blog.langchain.com/tutorial-chatgpt-over-your-data/)）

3. Bonus: deploy a nice frontend to go along with it! We have an example deployment to Hugging Face spaces in the above tutorial.  
3. 额外加分项：为你的应用部署一个美观易用的前端界面！上述教程中已提供部署至 Hugging Face Spaces 的示例。

4. Submit your entry [with this form](https://forms.gle/9ckmWxQ9GAaMpcRz9?ref=blog.langchain.com)  
4. 通过 [此表单](https://forms.gle/9ckmWxQ9GAaMpcRz9?ref=blog.langchain.com) 提交你的参赛作品

5. Repeat!  
5. 重复以上步骤，持续贡献更多示例！

### Examples

### 示例

We've created two example repos off of this example GitHub repo, to show what it might look like:

我们基于这个示例 GitHub 仓库，创建了两个示例仓库，以展示其可能的实现形式：

- [Notion](https://github.com/hwchase17/chat-langchain-notion?ref=blog.langchain.com): connect with your notion  
- [Notion](https://github.com/hwchase17/chat-langchain-notion?ref=blog.langchain.com)：连接你的 Notion 工作区

- [ReadTheDocs](https://github.com/hwchase17/chat-langchain-readthedocs?ref=blog.langchain.com): connect with your ReadTheDocs site  
- [ReadTheDocs](https://github.com/hwchase17/chat-langchain-readthedocs?ref=blog.langchain.com)：连接你的 ReadTheDocs 网站

Other ideas for sources that we saw from the above tweet are:

上述推文中提到的其他数据源创意还包括：

- Obsidian  
- Obsidian  
- Gong calls  
- Gong 会议录音  
- PDFs  
- PDF 文件  
- Audio files (can use Whisper!)  
- 音频文件（可使用 Whisper！）  
- Git repos  
- Git 代码仓库  
- Arbitrary websites  
- 任意网站  

And lots, lots more! If you're looking for ideas, just look in the replies to [this tweet](https://twitter.com/hwchase17/status/1622419133949411328?s=20&t=LPCDegP1hWIVzhKohm7jpA&ref=blog.langchain.com).

还有更多、更多创意！如果你正在寻找灵感，只需查看 [这条推文](https://twitter.com/hwchase17/status/1622419133949411328?s=20&t=LPCDegP1hWIVzhKohm7jpA&ref=blog.langchain.com) 的评论区即可。

### Will there be a winner?

### 是否会评选优胜者？

Yes! What is a challenge without a winner?

当然会！没有优胜者的挑战，还能称得上是挑战吗？

The rules of engagement are as follows:

参与规则如下：

- At the end of each day, we will tweet out from our Twitter a list of all example GitHub repos submitted in the [submission form](https://forms.gle/9ckmWxQ9GAaMpcRz9?ref=blog.langchain.com)  
- 每日结束时，我们将在 Twitter 上发布一条推文，列出所有通过 [提交表单](https://forms.gle/9ckmWxQ9GAaMpcRz9?ref=blog.langchain.com) 提交的示例 GitHub 仓库  

- At the end of this week (2/12) we will freeze submissions and do a tweet thread will all the GitHub repos submitted  
- 本周结束时（2 月 12 日），我们将关闭提交通道，并发布一条汇总所有已提交 GitHub 仓库的推文长串（tweet thread）  

- Whichever repo has the most stars by 2/19 will be the winner!  
- 截至 2 月 19 日获得 Star 数最多的仓库即为优胜者！

### What do I win?

### 我能赢取什么奖品？

A limited edition LangChain t-shirt.

一件限量版 LangChain T 恤。

![](images/chat-your-data-challenge/img_001.png)

### Tags

### 标签



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/chat-your-data-challenge/img_002.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/chat-your-data-challenge/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/chat-your-data-challenge/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds —— 一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/chat-your-data-challenge/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/chat-your-data-challenge/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)


[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
&#123;% endraw %}
