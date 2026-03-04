---
render_with_liquid: false
title: "Streamlit LLM Hackathon Kickoff (and projects we’d love to see)"
source: "LangChain Blog"
url: "https://blog.langchain.com/streamlit-llm-hackathon-kickoff-and-projects-wed-love-to-see-2/"
date: "2023-09-09"
scraped_at: "2026-03-03T08:46:21.229144514+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Streamlit’s LLM Hackathon kicks off today and we’re thrilled to be partnering with them to bring it to life. We’ve been building with the Streamlit team since LangChain’s inception because it’s the easiest place to get started building LLM apps and we can’t wait to see what everyone builds this week.

今天，Streamlit 的大语言模型（LLM）黑客松正式拉开帷幕，我们非常荣幸能与 Streamlit 携手合作，共同推动本次活动落地。自 LangChain 诞生之初，我们就一直与 Streamlit 团队紧密协作——因为 Streamlit 是入门构建 LLM 应用最便捷的平台；我们也无比期待本周大家将创造出怎样的精彩作品！

As you prepare to get going, we thought we’d share some resources and ideas for apps that we’d love to see (and share out with the broader community!).

在大家即将启程之际，我们想分享一些实用资源和应用创意——这些正是我们热切期待（并乐于向更广泛的社区推广！）的作品类型。

## Getting Started with LangChain and Streamlit

## 使用 LangChain 和 Streamlit 快速上手

[Here’s](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com) a repo including reference implementations of several LangChain agents as Streamlit apps including:

[这里](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com)是一个代码仓库，其中包含多个 LangChain Agent 的参考实现，全部以 Streamlit 应用形式呈现，例如：

- a search enabled chatbot that remembers chat history (app [here](https://langchain-chat-search.streamlit.app/?ref=blog.langchain.com))  
  一个支持搜索、并能记住对话历史的聊天机器人（应用地址：[点击访问](https://langchain-chat-search.streamlit.app/?ref=blog.langchain.com)）

- a chat app that allows the user to add feedback on responses using Streamlit feedback and link to the traces in LangSmith (we’ve been using this one a lot lately)  
  一款支持用户通过 Streamlit Feedback 组件对回复进行评价，并可直接跳转至 LangSmith 中对应调用链路（trace）的聊天应用（我们近期已频繁使用该模板）

- a chatbot capable of answering queries by referring custom documents (app [here](https://langchain-document-chat.streamlit.app/?ref=blog.langchain.com))  
  一款能基于用户提供的自定义文档回答问题的聊天机器人（应用地址：[点击访问](https://langchain-document-chat.streamlit.app/?ref=blog.langchain.com)）

- a chatbot which can communicate with your database (app [here](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com))  
  一款可与您的数据库交互的聊天机器人（应用地址：[点击访问](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com)）

- lots more  
  还有更多示例！

_We would LOVE to see teams contributing to this this week–PRs very welcome! 🚀_

_我们非常期待各支团队本周积极为该项目贡献代码——欢迎提交 Pull Request（PR）！🚀_

[Here’s](https://github.com/langchain-ai/langsmith-cookbook/blob/main/feedback-examples/streamlit/README.md?ref=blog.langchain.com) a LangSmith cookbook on building a Streamlit Chat UI with LangSmith. It shows you step-by-step how to create a  ChatGPT-like web app in Streamlit that supports:

[这里](https://github.com/langchain-ai/langsmith-cookbook/blob/main/feedback-examples/streamlit/README.md?ref=blog.langchain.com)是一份 LangSmith 食谱（cookbook），详解如何基于 LangSmith 构建 Streamlit 聊天界面。它将手把手教你创建一个具备以下特性的类 ChatGPT 网页应用：

- streaming  
  流式响应（streaming）

- custom instructions  
  自定义指令（system prompt）

- app feedback (including a template that lets you log simple 👍👎 scores to runs in LangSmith to make user feedback easier to incorporate.  
  应用内反馈机制（含配套模板，支持将简单的 👍👎 评分直接记录到 LangSmith 的运行记录中，让用户反馈更易集成与分析）

- and more  
  以及其他功能

[Here’s](https://blog.streamlit.io/tag/llms/?ref=blog.langchain.com) some LLM app inspiration from the Streamlit blog, including:

[这里](https://blog.streamlit.io/tag/llms/?ref=blog.langchain.com)汇集了 Streamlit 官方博客中一系列 LLM 应用灵感，包括：

- [how to build a data analysis chatbot](https://blog.streamlit.io/chat-with-pandas-dataframes-using-llms/?ref=blog.langchain.com)  
  [如何构建数据分析型聊天机器人](https://blog.streamlit.io/chat-with-pandas-dataframes-using-llms/?ref=blog.langchain.com)

- [generating data-driven presentations](https://blog.streamlit.io/instant-insight-generate-data-driven-presentations-in-a-snap/?ref=blog.langchain.com)  
  [生成数据驱动的演示文稿](https://blog.streamlit.io/instant-insight-generate-data-driven-presentations-in-a-snap/?ref=blog.langchain.com)

- [an app that lets you chat with “Warren Buffet”](https://blog.streamlit.io/decoding-warren-buffett-with-llms-and-snowflake-sql/?ref=blog.langchain.com) (that won second place in Streamlit’s last Hackathon)  
  [一款让你与“沃伦·巴菲特”对话的应用](https://blog.streamlit.io/decoding-warren-buffett-with-llms-and-snowflake-sql/?ref=blog.langchain.com)（曾在 Streamlit 上届黑客松中荣获亚军）

- and more!  
  更多精彩案例！

[Here’s](https://python.langchain.com/docs/integrations/callbacks/streamlit?ref=blog.langchain.com) our Getting Started documentation (including a scenario on how to create an agent with tools).

[请点击此处](https://python.langchain.com/docs/integrations/callbacks/streamlit?ref=blog.langchain.com)查看我们的入门文档（包含如何使用工具构建智能体的示例场景）。

## LangChain Prompt Hub

## LangChain 提示词中心（Prompt Hub）

We recently launched LangChain Hub, a home for submitting, discovering, inspecting, and remixing prompts. It’s still (very) early days–we see it as not only a useful tool for helping developers build faster, but also as a way for the entire community to get collectively smarter on prompting overall.

我们近期正式推出 LangChain Prompt Hub——一个用于提交、发现、查看和重构提示词（prompts）的平台。目前仍处于（非常）早期阶段；我们不仅将其视为帮助开发者加速构建应用的实用工具，更希望它成为整个社区共同提升提示工程能力的重要途径。

We hope you’ll contribute prompts and try each other’s out–here’s how: [https://docs.smith.langchain.com/hub/quickstart](https://docs.smith.langchain.com/hub/quickstart?ref=blog.langchain.com)

诚邀您贡献自己的提示词，并尝试他人分享的提示词——操作指南在此：[https://docs.smith.langchain.com/hub/quickstart](https://docs.smith.langchain.com/hub/quickstart?ref=blog.langchain.com)

We’ll be tweeting and blogging about our favorites prompts–from most useful to most creative–so make sure you share them with us and the community on [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com)!

我们将通过 Twitter 和博客持续分享精选提示词——涵盖最实用、最具创意等各类佳作。欢迎在 [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com) 上与我们及社区共享您的作品！

_Please share feedback along the way–anything from bugs to big ideas welcome._

_欢迎随时反馈——无论是 Bug 报告，还是宏大构想，我们都热烈欢迎。_

## Projects we’d love to see (and share with the LangChain community!)

## 我们热切期待看到（并乐于向 LangChain 社区分享）的项目！

- applications that use open source models  
- 使用开源模型的应用  

- innovative retrieval tactics  
- 创新的检索策略  

- most practical agents  
- 最具实用价值的智能体  

- most adventurous agents  
- 最具探索精神的智能体  

- apps that connect unique data source/format(s)  
- 能够对接独特数据源/格式的应用  

We’ll be tweeting out our favorite projects throughout the week and collecting them for a blog post to close out the Hackathon. There may even be some (unofficial) LangChain prizes/swag for teams doing this stuff! 👀

本周内，我们将持续在 Twitter 上分享最喜爱的参赛项目，并汇总整理成一篇博客文章，为本次黑客松画上圆满句号。表现突出的团队还有机会获得（非官方）LangChain 纪念奖品/周边！👀

Tag us on Twitter (@langchainai), Send us a note at hello@langchain.dev, or ping us in the [Steamlit Discord](https://discord.gg/bTz5EDYh9Z?ref=blog.langchain.com) (I’m hwchase17).

请在 Twitter 上 @我们（@langchainai），或发送邮件至 hello@langchain.dev，亦可前往 [Streamlit Discord](https://discord.gg/bTz5EDYh9Z?ref=blog.langchain.com) 中联系我们（我是 hwchase17）。

We can’t wait to see what you build!

我们迫不及待想看到您构建的作品！