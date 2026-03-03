---
title: "Chat-Your-Data Submissions"
source: "LangChain Blog"
url: "https://blog.langchain.com/chat-your-data-submissions/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:34:52.198069030+00:00"
language: "en-zh"
translated: true
---

Last week, we kicked off a [week long competition](https://blog.langchain.com/chat-your-data-challenge/) to create a chatbot over your own data. The goal was to inspire (1) lots of document loaders for loading various types of data, (2) lots of end-to-end examples.

上周，我们启动了一场为期一周的[竞赛](https://blog.langchain.com/chat-your-data-challenge/)，旨在鼓励大家基于自己的数据构建聊天机器人。本次活动的目标是激发两方面的创新：（1）开发大量文档加载器（document loaders），以支持各类数据源的接入；（2）产出大量端到端（end-to-end）应用示例。

We succeeded on both fronts! On the document loader side, we added [25+ document loaders](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com) ranging from s3 to EveryNote to the College Confidential website.

我们在两个方向上均取得了成功！在文档加载器方面，我们新增了[25+ 种文档加载器](https://python.langchain.com/docs/modules/data_connection/document_loaders/?ref=blog.langchain.com)，覆盖从 Amazon S3、Evernote 到 College Confidential 网站等多种数据源。

One the end-to-end examples side, we're excited to highlight some of the projects below. As a reminder, the winner of the competition will be decided by whichever GitHub repo has the most stars at the end of the week — so if you like a particular one go star it!

在端到端示例方面，我们非常高兴向大家重点介绍以下几项参赛项目。需要提醒的是：本次竞赛的获胜者将由本周结束时 GitHub 仓库获得 Star 数最多的项目决定——因此，如果您喜欢某个项目，请务必前往为其点亮 Star！

The entrants are:

参赛者如下：

### TokBot

### TokBot

- Author: Andrew Gleave  
- 作者：Andrew Gleave  
- Twitter: [@andrewgleave](https://twitter.com/andrewgleave?ref=blog.langchain.com)  
- 推特：[@andrewgleave](https://twitter.com/andrewgleave?ref=blog.langchain.com)  
- GitHub Repo: [https://github.com/andrewgleave/tokbot](https://github.com/andrewgleave/tokbot?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/andrewgleave/tokbot](https://github.com/andrewgleave/tokbot?ref=blog.langchain.com)  
- Description: A GPT-3/LangChain bot that answers questions about the TokCast podcast provides relevant video excerpts  
- 描述：一个基于 GPT-3 和 LangChain 构建的聊天机器人，可回答关于 TokCast 播客的问题，并提供相关的视频片段。

### Ask Everything About Me

### 问我一切关于我的事（Ask Everything About Me）

- Author: Yongtae  
- 作者：Yongtae  
- Twitter: [@Yoooongtae](https://twitter.com/Yoooongtae?ref=blog.langchain.com)  
- 推特：[@Yoooongtae](https://twitter.com/Yoooongtae?ref=blog.langchain.com)  
- GitHub Repo: [https://github.com/Yongtae723/chat-your-data](https://github.com/Yongtae723/chat-your-data?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/Yongtae723/chat-your-data](https://github.com/Yongtae723/chat-your-data?ref=blog.langchain.com)  
- Description: This bot can do the following on your behalf: analyze your tweets and show you what you are interested in these days, answer questions about you from your blog or profile.  
- 描述：该机器人可代您完成以下任务：分析您的推文，帮您了解自己近期关注的兴趣点；或根据您的博客内容与个人资料，回答他人关于您的问题。

### Roam QA

### Roam QA

- Author: JimmyLv  
- 作者：JimmyLv  
- Twitter: [@Jimmy\_JingLv](https://twitter.com/Jimmy_JingLv?ref=blog.langchain.com)  
- 推特：[@Jimmy\_JingLv](https://twitter.com/Jimmy_JingLv?ref=blog.langchain.com)  
- GitHub Repo: [https://github.com/JimmyLv/roam-qa](https://github.com/JimmyLv/roam-qa?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/JimmyLv/roam-qa](https://github.com/JimmyLv/roam-qa?ref=blog.langchain.com)  
- Description: Ask questions to your Roam Research graph in natural language  
- 描述：以自然语言向您的 Roam Research 知识图谱提问。

### Chat-Your-Data Self Hosted

### Chat-Your-Data 自托管版

- Author: Misbah Syed  
- 作者：Misbah Syed  
- Twitter: [@MisbahSy](https://twitter.com/MisbahSy?ref=blog.langchain.com)  
- 推特：[@MisbahSy](https://twitter.com/MisbahSy?ref=blog.langchain.com)  
- GitHub Repo: [https://github.com/misbahsy/chat-your-data-self-hosted](https://github.com/misbahsy/chat-your-data-self-hosted?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/misbahsy/chat-your-data-self-hosted](https://github.com/misbahsy/chat-your-data-self-hosted?ref=blog.langchain.com)  
- Description: Create a ChatGPT like experience over your custom docs using [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com). This repo can help you use models hosted on HuggingFace for embedding and for text generation.  
- 描述：借助 [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com)，在您自定义的文档上构建类似 ChatGPT 的对话体验。本仓库可帮助您调用 Hugging Face 上托管的模型，用于嵌入（embedding）和文本生成。

### Chat With Data

### 与数据对话

- Author: Echo  
- 作者：Echo  
- Twitter: [@hive\_echo](https://twitter.com/hive_echo?ref=blog.langchain.com)  
- 推特：[@hive\_echo](https://twitter.com/hive_echo?ref=blog.langchain.com)  
- GitHub Repo: [https://github.com/echohive42/chat\_with\_data](https://github.com/echohive42/chat_with_data?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/echohive42/chat\_with\_data](https://github.com/echohive42/chat_with_data?ref=blog.langchain.com)  
- Description: This app starts with the AI wikipedia article from data folder and you can chat about it.  
- 描述：该应用以 `data` 文件夹中的 AI 维基百科文章为起点，您可围绕该文章进行对话。

### Chat LangChain Telegram

### LangChain Telegram 对话工具

- Author: Vidal Maxime  
- 作者：Vidal Maxime  
- Twitter: [@vmaxmc2](https://twitter.com/vmaxmc2?ref=blog.langchain.com)  
- 推特：[@vmaxmc2](https://twitter.com/vmaxmc2?ref=blog.langchain.com)  
- GitHub: [https://github.com/vidalmaxime/chat-langchain-telegram](https://github.com/vidalmaxime/chat-langchain-telegram?ref=blog.langchain.com)  
- GitHub：[https://github.com/vidalmaxime/chat-langchain-telegram](https://github.com/vidalmaxime/chat-langchain-telegram?ref=blog.langchain.com)  
- UI: [https://huggingface.co/spaces/maxime/chat-with-your-telegram-chat](https://huggingface.co/spaces/maxime/chat-with-your-telegram-chat?ref=blog.langchain.com)  
- 用户界面（UI）：[https://huggingface.co/spaces/maxime/chat-with-your-telegram-chat](https://huggingface.co/spaces/maxime/chat-with-your-telegram-chat?ref=blog.langchain.com)  
- Description: Understand who you are and your relationships by creating a ChatGPT like experience over your own Telegram chat with [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com).  
- 描述：借助 [LangChain](https://github.com/hwchase17/langchain?ref=blog.langchain.com)，基于您自己的 Telegram 聊天记录构建类 ChatGPT 的对话体验，从而更深入地理解自我身份与人际关系。

### Chat ISW Reports

### ISW 报告对话工具

- Author: Matthew Robinson  
- 作者：Matthew Robinson  
- Twitter: [@UnstructuredIO](https://twitter.com/UnstructuredIO?ref=blog.langchain.com)  
- 推特：[@UnstructuredIO](https://twitter.com/UnstructuredIO?ref=blog.langchain.com)  
- GitHub: [https://github.com/Unstructured-IO/chat-isw-reports](https://github.com/Unstructured-IO/chat-isw-reports?ref=blog.langchain.com)  
- GitHub：[https://github.com/Unstructured-IO/chat-isw-reports](https://github.com/Unstructured-IO/chat-isw-reports?ref=blog.langchain.com)  
- Description: Chat over documents pulled from the Institute for the Study of War (ISW) website.  
- 描述：对从“战争研究所”（Institute for the Study of War, ISW）网站抓取的文档进行对话式查询。

### Chat Your Data Chef

### 数据厨师：食谱对话工具

- Author: Zander Chase  
- 作者：Zander Chase  
- Twitter: [@zanderchase11](https://twitter.com/zanderchase11?ref=blog.langchain.com)  
- 推特：[@zanderchase11](https://twitter.com/zanderchase11?ref=blog.langchain.com)  
- GitHub: [https://github.com/zanderchase/chat-your-data-chef](https://github.com/zanderchase/chat-your-data-chef?ref=blog.langchain.com)  
- GitHub：[https://github.com/zanderchase/chat-your-data-chef](https://github.com/zanderchase/chat-your-data-chef?ref=blog.langchain.com)  
- UI: [https://huggingface.co/spaces/zanderchase/chat-your-data-chef](https://huggingface.co/spaces/zanderchase/chat-your-data-chef?ref=blog.langchain.com)  
- 用户界面（UI）：[https://huggingface.co/spaces/zanderchase/chat-your-data-chef](https://huggingface.co/spaces/zanderchase/chat-your-data-chef?ref=blog.langchain.com)  
- Description: Chat over recipes scraped from several recipes sites.  
- 描述：对从多个食谱网站爬取的菜谱内容进行自然语言对话。

### YouTuber Chatbot

### YouTube 视频聊天机器人

- Author: James Pop  
- 作者：James Pop  

- GitHub: [https://github.com/jryebread/youtuber\_chatbot/tree/main](https://github.com/jryebread/youtuber_chatbot/tree/main?ref=blog.langchain.com)  
- GitHub：[https://github.com/jryebread/youtuber\_chatbot/tree/main](https://github.com/jryebread/youtuber_chatbot/tree/main?ref=blog.langchain.com)  

- UI: [https://jryebread-youtuber-chatbot-main-v73i8j.streamlit.app/](https://jryebread-youtuber-chatbot-main-v73i8j.streamlit.app/?ref=blog.langchain.com)  
- 用户界面（UI）：[https://jryebread-youtuber-chatbot-main-v73i8j.streamlit.app/](https://jryebread-youtuber-chatbot-main-v73i8j.streamlit.app/?ref=blog.langchain.com)  

- Description: make an ai chatbot out of any YouTube video  
- 描述：将任意 YouTube 视频转化为 AI 聊天机器人  

### Investor Education ChatChain

### 投资者教育 ChatChain

- Author: Nicholas Muchinguri  
- 作者：Nicholas Muchinguri  

- GitHub: [https://github.com/nickmuchi87/investor-education-chatchain](https://github.com/nickmuchi87/investor-education-chatchain?ref=blog.langchain.com)  
- GitHub：[https://github.com/nickmuchi87/investor-education-chatchain](https://github.com/nickmuchi87/investor-education-chatchain?ref=blog.langchain.com)  

- UI: [https://huggingface.co/spaces/nickmuchi/Investor-Education-ChatChain](https://huggingface.co/spaces/nickmuchi/Investor-Education-ChatChain?ref=blog.langchain.com)  
- 用户界面（UI）：[https://huggingface.co/spaces/nickmuchi/Investor-Education-ChatChain](https://huggingface.co/spaces/nickmuchi/Investor-Education-ChatChain?ref=blog.langchain.com)  

- Description: ChatBot for asking investing questions from web-scraped website of a leading Investment Manager.  
- 描述：一款基于头部投资管理公司网站网络爬取内容构建的、用于解答投资相关问题的聊天机器人。  

## Bonus (non-valid) Submissions

## 额外展示（非有效参赛作品）

There were also a series of submissions that will not be counted (due to not open source or created before the submission deadline), but that we still want to highlight because they are awesome :)  
我们还收到了一系列未被计入正式评选的作品（原因包括：未开源，或在提交截止日期之前已创建），但因其出色表现，我们仍愿特别推荐 :)  

### ChatGPT+WolframAlpha+Whisper

### ChatGPT + WolframAlpha + Whisper

- Author: James Weaver  
- 作者：James Weaver  

- UI: [https://huggingface.co/spaces/JavaFXpert/Chat-GPT-LangChain](https://huggingface.co/spaces/JavaFXpert/Chat-GPT-LangChain?ref=blog.langchain.com)  
- 用户界面（UI）：[https://huggingface.co/spaces/JavaFXpert/Chat-GPT-LangChain](https://huggingface.co/spaces/JavaFXpert/Chat-GPT-LangChain?ref=blog.langchain.com)  

- Description: A conversational agent implemented with OpenAI GPT-3.5 and LangChain  
- 描述：一个基于 OpenAI GPT-3.5 和 LangChain 实现的对话式智能体  

### Paper QA

### 论文问答系统（Paper QA）

- Author: Andrew White  
- 作者：Andrew White  

- GitHub Repo: [https://github.com/whitead/paper-qa](https://github.com/whitead/paper-qa?ref=blog.langchain.com)  
- GitHub 仓库：[https://github.com/whitead/paper-qa](https://github.com/whitead/paper-qa?ref=blog.langchain.com)  

- UI: [https://huggingface.co/spaces/whitead/paper-qa](https://huggingface.co/spaces/whitead/paper-qa?ref=blog.langchain.com)  
- 用户界面（UI）：[https://huggingface.co/spaces/whitead/paper-qa](https://huggingface.co/spaces/whitead/paper-qa?ref=blog.langchain.com)  

- Description: This is a simple and incomplete package for doing question and answering from PDFs or text files  
- 描述：这是一个简易且尚未完善的工具包，用于从 PDF 或纯文本文件中执行问答任务。

### Any Questions

### 有任何问题？

- Author: Harry  
- 作者：Harry  
- UI: [https://www.anyquestions.ai/video](https://www.anyquestions.ai/video?ref=blog.langchain.com)  
- 用户界面（UI）：[https://www.anyquestions.ai/video](https://www.anyquestions.ai/video?ref=blog.langchain.com)  
- Description: AskAI about a video  
- 功能描述：使用 AskAI 针对视频内容提问  

Reminder, if you like any particular one, make sure to star it! Winner's will be announced at the end of the week.

温馨提示：如果您特别喜欢其中某个项目，请务必为其点亮 Star！优胜者将于本周末公布。

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

[**借助 LangChain 支持的 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)