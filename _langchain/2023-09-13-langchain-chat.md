---
title: "LangChain Chat"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-chat/"
date: "2023-09-13"
scraped_at: "2026-03-03T08:45:35.538702752+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

Today we’re excited to announce and showcase an open source chatbot specifically geared toward answering questions about LangChain’s documentation.

今天我们很高兴地宣布并展示一款开源聊天机器人，专为解答有关 LangChain 文档的问题而设计。

**Key Links**

**关键链接**

- Deployed Chatbot: [chat.langchain.dev](https://chat.langchain.dev/?ref=blog.langchain.com)  
- 已部署的聊天机器人：[chat.langchain.dev](https://chat.langchain.dev/?ref=blog.langchain.com)

- Deployed Chatbot on HuggingFace spaces: [huggingface.co/spaces/hwchase17/chat-langchain](https://huggingface.co/spaces/hwchase17/chat-langchain?ref=blog.langchain.com)  
- 部署在 Hugging Face Spaces 上的聊天机器人：[huggingface.co/spaces/hwchase17/chat-langchain](https://huggingface.co/spaces/hwchase17/chat-langchain?ref=blog.langchain.com)

- Open source repo: [github.com/hwchase17/chat-langchain](https://github.com/hwchase17/chat-langchain?ref=blog.langchain.com)  
- 开源代码仓库：[github.com/hwchase17/chat-langchain](https://github.com/hwchase17/chat-langchain?ref=blog.langchain.com)

- Next.js frontend: [github.com/zahidkhawaja/langchain-chat-nextjs](https://github.com/zahidkhawaja/langchain-chat-nextjs?ref=blog.langchain.com)  
- Next.js 前端：[github.com/zahidkhawaja/langchain-chat-nextjs](https://github.com/zahidkhawaja/langchain-chat-nextjs?ref=blog.langchain.com)

Huge shoutout to [Zahid Khawaja](https://twitter.com/chillzaza_?ref=blog.langchain.com) for collaborating with us on this. If you want this type of functionality for webpages in general, you should check out his browser extension: [Lucid](https://twitter.com/chillzaza_/status/1593739682013220865?s=20&ref=blog.langchain.com).

特别感谢 [Zahid Khawaja](https://twitter.com/chillzaza_?ref=blog.langchain.com) 与我们合作完成本项目。如果您希望将此类功能普遍应用于各类网页，欢迎试用他开发的浏览器扩展：[Lucid](https://twitter.com/chillzaza_/status/1593739682013220865?s=20&ref=blog.langchain.com)。

If you like this and want a more advanced version of this for your codebase, you should check out [ClerkieAI](https://twitter.com/ClerkieAI?ref=blog.langchain.com). Their question answer bot is live on our [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com).

如果您喜欢本项目，并希望为自己的代码库部署更高级的版本，欢迎了解 [ClerkieAI](https://twitter.com/ClerkieAI?ref=blog.langchain.com)。他们的问答机器人已上线我们的 [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com)。

* * *

## Overview

## 概览

There have been a few other projects similar to this one in the past weeks (more on that below). However, we hope to share what we believe are unique insights, including:

过去几周中，已有若干类似项目问世（下文将作进一步介绍）。然而，我们希望分享一些我们认为独具价值的见解，包括：

- Document ingestion (what is and isn’t general)  
- 文档摄取（哪些内容具有普适性，哪些不具备）

- **How to make this work in a chatbot setting (important UX)**  
- **如何在聊天机器人场景中实现该功能（关键的用户体验设计）**

- (Prompt Engineering) Tradeoff between speed and performance  
- （提示工程）响应速度与性能之间的权衡

- (Prompt Engineering) How to get it to cite sources  
- （提示工程）如何让模型引用信息来源

- (Prompt Engineering) Output format  
- （提示工程）输出格式设计

Expanding on the bolded section, we believe the chatbot interface is an important UX (just see the success of ChatGPT!) and we think that is missing from other implementations.

进一步说明加粗部分：我们认为聊天机器人界面是一项至关重要的用户体验设计（仅看 ChatGPT 的巨大成功即可印证！），而这一点恰恰是其他实现方案所欠缺的。

* * *

## Motivation

## 动机

Combining LLMs with external data has always been one of the core value props of LangChain. One of the first demo’s we ever made was a [Notion QA Bot](https://github.com/hwchase17/notion-qa?ref=blog.langchain.com), and [Lucid](https://twitter.com/chillzaza_/status/1594847151238037505?s=20&ref=blog.langchain.com) quickly followed as a way to do this over the internet.

将大语言模型（LLM）与外部数据相结合，始终是 LangChain 的核心价值主张之一。我们最早制作的演示之一便是 [Notion 问答机器人（Notion QA Bot）](https://github.com/hwchase17/notion-qa?ref=blog.langchain.com)，随后 [Lucid](https://twitter.com/chillzaza_/status/1594847151238037505?s=20&ref=blog.langchain.com) 迅速问世，成为一种面向互联网实现该能力的方案。

One of the pieces of external data we wanted to enable question-answering over was our [documentation](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com). We have a [growing Discord community](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com), and want to provide fast and accurate support for all their questions. So this seemed like a perfect opportunity to utilize our own technology internally! We reached out to [Zahid](https://twitter.com/chillzaza_?ref=blog.langchain.com), an ML creator and LangChain enthusiast, to see if he would be willing to team up for this, and to our relief he said yes! And so we started building.

我们希望支持问答能力的外部数据源之一，正是我们的 [官方文档](https://python.langchain.com/docs/get_started/introduction.html?ref=blog.langchain.com)。我们拥有一个[日益壮大的 Discord 社区](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com)，亟需为社区成员提出的各类问题提供快速、准确的支持。因此，这无疑是一次绝佳的机会——让我们得以在内部实际应用自身技术！我们联系了机器学习创作者兼 LangChain 爱好者 [Zahid](https://twitter.com/chillzaza_?ref=blog.langchain.com)，询问他是否愿意共同参与该项目；令我们欣喜的是，他欣然应允！于是，项目正式启动。

## Similar Work

## 相关工作

For whatever reason, there was a lot of similar work done here in just the past week! Pretty much all of them followed the same pipeline, which can be condensed as follows:

不知何故，就在过去一周内，涌现出大量类似的工作！这些项目几乎全部遵循同一条技术路径，可概括如下：

![](images/langchain-chat/img_001.png)Diagram of typical ingestion process

![](images/langchain-chat/img_001.png)典型数据摄入流程示意图

**Ingestion**:

**数据摄入（Ingestion）**：

- Take a set of proprietary documents  
- Split them up into smaller chunks  
- Create an embedding for each document  

- 获取一组专有文档  
- 将其切分为更小的文本块  
- 为每个文本块生成嵌入向量（embedding）

![](images/langchain-chat/img_002.png)Diagram of typical query process

![](images/langchain-chat/img_002.png)典型查询流程示意图

**Query**:

**查询**：

- 为查询生成一个嵌入向量（embedding）  
- 在嵌入空间中查找最相似的文档  
- 将这些文档连同原始查询一并输入语言模型，以生成答案  

**此类方法的其他优秀示例还包括**：

**此类方法的其他优秀示例还包括**：

- [GitHub 支持机器人（由 Dagster 开发）](https://dagster.io/blog/chatgpt-langchain?ref=blog.langchain.com) —— 在问题定位与解决目标上，可能与本方案最为接近  
- [Dr. Doc Search](https://github.com/namuan/dr-doc-search?ref=blog.langchain.com) —— 与一本图书（PDF 格式）进行对话  
- [Simon Willison 关于“语义搜索答案”的文章](https://simonwillison.net/2023/Jan/13/semantic-search-answers/?ref=blog.langchain.com) —— 对本文涉及的部分主题给出了清晰易懂的阐释  
- [Ask My Book](https://askmybook.com/?ref=blog.langchain.com) —— 由 Sahil Lavingia 开发，或许是引发当前这波热潮的首个代表性案例  

## Document Ingestion

## 文档摄取（Document Ingestion）

我们立刻面临一个问题：数据究竟应从何处获取？当时有两个选项：直接使用 GitHub 上的源文件，或从互联网网页抓取。尽管 GitHub 中部分文件格式友好（如 Markdown 和 reStructuredText），但我们也发现一些文件并不利于后续处理（例如 `.ipynb` 笔记本文件、自动生成的文档等）。因此，我们最终决定采用网络爬虫方式，从互联网抓取内容。

随后，我们又面临如何预处理 HTML 文件的问题。最初，我们采用了一种通用方式——仅使用 Beautiful Soup 提取页面上的全部文本。然而，在实际使用这些结果后，我们发现侧边栏（sidebar）中的内容常常导致效果不佳。如下图所示，图中两个标为红色的区域实际上并未提供多少有价值的新信息。

![](images/langchain-chat/img_003.png)A screenshot of the problematic sidebar contents.

![](images/langchain-chat/img_003.png)存在干扰的侧边栏内容截图。

当我们深入分析那些质量较差的检索结果时，发现往往正是这些侧边栏信息被错误地提取并填充进了上下文（context）中。为此，我们修改了 HTML 解析器，使其显式忽略这些区域。

尽管该调整针对的是特定网页布局，但我们认为它凸显了一个关键原则：**必须审慎、有意识地决定哪些数据应（或不应）被纳入潜在上下文之中**。**虽然借助通用的数据摄取工具可快速启动项目，但若想获得更优性能，深入检查数据质量并针对性优化整个处理流程，几乎总是必不可少的**。

## How to make this work in a chatbot setting

## 如何在聊天机器人场景中实现这一功能

As mentioned before, we believe a chatbot setting is an important UX decision that:

如前所述，我们认为采用聊天机器人界面是一项关键的用户体验（UX）设计决策，原因在于：

1. People find familiar (see the success of ChatGPT)  
1. 用户对此形式感到熟悉（参见 ChatGPT 的成功案例）

2. Enable other key features (more on this below)  
2. 能够支撑其他关键功能（下文详述）

One of the key features that we wanted to make sure to include that we did not see being done a lot of other places is the ability to ask follow up questions. We believe this is [very important](https://twitter.com/johnvmcdonnell/status/1611860858497531905?s=20&t=ThUtsd5V4xpSJPEC_4Kceg&ref=blog.langchain.com) for any chat based interface. Most (all?) implementations out there primarily ignore this issue, and treat each question as independent. This breaks down when someone wants to ask a follow up question in a natural way, or refer to pieces of context in the prior questions or answers.

我们特别希望纳入的一项关键功能——而当时在其他多数系统中尚未被广泛实现——是支持用户提出后续问题（follow-up questions）。我们认为，这对任何基于对话的交互界面都[至关重要](https://twitter.com/johnvmcdonnell/status/1611860858497531905?s=20&t=ThUtsd5V4xpSJPEC_4Kceg&ref=blog.langchain.com)。目前市面上绝大多数（甚至全部？）实现方案基本忽略了该问题，将每个提问视为彼此独立的事件。这种做法在用户试图以自然方式提出后续问题，或需要引用先前问题与回答中的上下文信息时，便会失效。

The primary way to do this in LangChain is with [memory](https://python.langchain.com/docs/modules/memory/?ref=blog.langchain.com) in a conversation chain. In the simplest implementation of this, the previous lines of conversation are added as context to the prompt. However, this breaks down a bit for our use case, as not only do we care about adding the conversational history to the prompt, but we also care about using it to determine which documents to fetch. If asking a follow up question, we need to know what that follow up question is about in order to fetch relevant documents.

在 LangChain 中实现该功能的主要方式，是借助对话链（conversation chain）中的[记忆模块（memory）](https://python.langchain.com/docs/modules/memory/?ref=blog.langchain.com)。最简单的实现方式，是将历史对话内容直接作为上下文添加至当前提示词（prompt）中。然而，该方法在我们的使用场景中略显不足：我们不仅关注将对话历史加入提示词，更需利用该历史信息来决定应检索哪些文档。当用户提出后续问题时，我们必须准确理解该问题所指涉的主题，才能检索出真正相关的文档。

**Therefore, we created a new chain that had the following steps:**

**因此，我们构建了一条全新的链式流程，包含以下步骤：**

- Given a conversation history and a new question, create a single, standalone question  
- 基于对话历史与新提出的问题，生成一个独立、自包含的（standalone）问题  

- Use that question in a normal [Vector Database Question Answer Chain](https://python.langchain.com/docs/modules/chains/popular/vector_db_qa?ref=blog.langchain.com).  
- 将该独立问题输入标准的[向量数据库问答链（Vector Database Question Answer Chain）](https://python.langchain.com/docs/modules/chains/popular/vector_db_qa?ref=blog.langchain.com)。

![](images/langchain-chat/img_004.png)Diagram of our query process  
![](images/langchain-chat/img_004.png)我们的查询流程示意图

We were a bit worried that using that question in the Vector Database Question Answer Chain would be lossy and lose some of the context, but we did not really observe any negative effects there.

我们曾一度担忧：将重构后的独立问题直接用于向量数据库问答链，可能导致信息损失、丢失部分上下文；但实际测试中，并未观察到明显的负面效果。

In the process of getting to this solution, we tried a few other things with respect to fetching documents from the Vector Database that did not work nearly as well:  
在探索该解决方案的过程中，我们也尝试过若干其他从向量数据库中检索文档的方法，但效果均远不如上述方案：

- Embedding the chat history + question together: once the chat history got long, would massively overly index on that if you were trying to change topics.  
- 将聊天历史记录与问题一起嵌入：一旦聊天历史变长，在尝试切换话题时，模型会严重过度关注历史内容。

- Embedding the chat and question separately and then combining results: better than the above, but still pulled too much information about previous topics into context  
- 分别嵌入聊天记录和问题，再合并结果：虽优于上述方法，但仍将过多关于先前话题的信息带入上下文。

## Prompt Engineering  

## 提示工程  

When building a chatbot, delivering a good user experience is crucial. In our use case, there were a few important considerations:  
构建聊天机器人时，提供良好的用户体验至关重要。在我们的实际应用场景中，有几点关键考量：

- Each answer should include an official source to the [documentation](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com).  
- 每个回答都应包含指向官方[文档](https://python.langchain.com/docs/get_started/introduction?ref=blog.langchain.com)的权威来源链接。

- If the answer includes code, it should be properly formatted as a code block.  
- 若回答中包含代码，必须以规范的代码块格式呈现。

- The chatbot should stay on topic and be upfront about not knowing an answer.  
- 聊天机器人应紧扣主题，并在无法作答时坦率说明。

We were able to achieve all of this with the following [prompt](https://github.com/hwchase17/chat-langchain/blob/master/chain.py?ref=blog.langchain.com):  
我们通过以下[提示词](https://github.com/hwchase17/chat-langchain/blob/master/chain.py?ref=blog.langchain.com)实现了全部目标：

```python
You are an AI assistant for the open source library LangChain. The documentation is located at https://langchain.readthedocs.io.
You are given the following extracted parts of a long document and a question. Provide a conversational answer with a hyperlink to the documentation.
You should only use hyperlinks that are explicitly listed as a source in the context. Do NOT make up a hyperlink that is not listed.
If the question includes a request for code, provide a code block directly from the documentation.
If you don't know the answer, just say "Hmm, I'm not sure." Don't try to make up an answer.
If the question is not about LangChain, politely inform them that you are tuned to only answer questions about LangChain.
Question: {question}
=========
{context}
=========
Answer in Markdown:
```

```python
你是一个面向开源库 LangChain 的 AI 助手。相关文档位于 https://langchain.readthedocs.io。
你将获得一份长文档中提取出的若干片段以及一个问题。请以自然对话风格作答，并附上指向文档的超链接。
你仅可使用上下文中明确列出为来源的超链接；切勿自行编造未列出的链接。
若问题要求提供代码，请直接从文档中提取并以代码块形式呈现。
若你不知道答案，请仅回答“Hmm, I'm not sure.”（嗯，我不太确定），切勿尝试编造答案。
若问题与 LangChain 无关，请礼貌告知用户：你仅被调优用于回答 LangChain 相关问题。
问题：{question}
=========
{context}
=========
请以 Markdown 格式作答：
```

This is prompt we're currently using to return answers in Markdown with sources and code.  
这是我们当前用于返回含来源引用与代码的 Markdown 格式答案的提示词。

In this prompt, we’re requesting a response in **Markdown** format. This allows us to render the answer in a visually appealing format with proper headings, lists, links, and code blocks.  
在此提示词中，我们明确要求模型以 **Markdown** 格式输出响应。这使我们能够以视觉上更美观的方式渲染答案——包括恰当的标题、列表、超链接及代码块。

**Here’s how it looks on our Next.js frontend:**  
**这是它在我们的 Next.js 前端中的实际效果：**

![](images/langchain-chat/img_005.png)  
![](images/langchain-chat/img_005.png)

In this screenshot, the user requests a follow-up code example. As you can see, we’re able to provide a code example in a sensible format.  
此截图中，用户请求一个后续的代码示例。如您所见，我们成功以清晰合理的格式提供了该代码示例。

The hyperlink in each answer is constructed using the base URL to the documentation, which we’re providing upfront in our prompt. Since we scraped the documentation website in our data ingestion pipeline, we’re able to identify the path to the answer and combine it with the base URL to create a working link.

每个答案中的超链接均基于我们提前在提示词（prompt）中提供的文档基础 URL 构建。由于我们在数据摄入（ingestion）流水线中已爬取了文档网站，因此能够准确定位答案所在路径，并将其与基础 URL 拼接，生成有效的可点击链接。

To keep the chatbot as accurate as possible, we keep the temperature at **0** and include instructions in the prompt to say “ _Hmm, I’m not sure._” if given a question with an unclear answer. To keep the conversation on topic, we also include instructions to decline questions that are not about LangChain.

为最大限度保障聊天机器人的准确性，我们将温度参数（temperature）设为 **0**，并在提示词中明确指示：若遇到答案不明确的问题，须回复“_嗯，我不太确定。_”。为确保对话始终聚焦主题，提示词中还要求拒绝回答任何与 LangChain 无关的问题。

**Striking a balance between speed and performance:**

**在响应速度与输出质量之间寻求平衡：**

- We began our testing with longer Markdown answers. Although the answer quality was great, the response times were slightly longer than desired.  
- 我们最初测试时采用较长的 Markdown 格式答案。虽然答案质量很高，但响应时间略长于预期。

- We spent a lot of time refining the prompt and experimenting with different keywords and sentence structures to improve performance.  
- 我们投入大量时间优化提示词，并反复尝试不同关键词与句式结构，以提升整体性能。

- One method was to mention the _Markdown_ keyword at the end of the prompt. For our use case, we were able to return formatted outputs with only a single mention of the keyword.  
- 其中一种方法是在提示词末尾加入 _Markdown_ 关键词。针对我们的使用场景，仅需提及该词一次，即可稳定返回格式化输出。

- Providing the base URL near the beginning of the prompt improved overall performance — it gives the model a working reference to create a final URL to include in the answer.  
- 将基础 URL 置于提示词靠前位置显著提升了整体性能——这为模型提供了可靠的参考依据，使其能准确构造最终需嵌入答案中的 URL。

- We found that using the singular form, such as "a hyperlink" instead of "hyperlinks" and "a code block" instead of "code blocks", improves response times.  
- 我们发现，使用单数形式（例如用 “a hyperlink” 代替 “hyperlinks”，用 “a code block” 代替 “code blocks”）有助于缩短响应时间。

## Future Work

## 后续工作计划

We're just getting started and we welcome feedback from the LangChain community. We can't wait to introduce new features and improvements in the near future! Follow us on [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com) for updates and checkout the [code](https://github.com/hwchase17/chat-langchain/blob/master/chain.py?ref=blog.langchain.com).

我们才刚刚起步，诚挚欢迎 LangChain 社区的宝贵反馈。我们迫不及待将在不久的将来推出更多新功能与优化升级！欢迎关注我们的 [Twitter](https://twitter.com/LangChainAI?ref=blog.langchain.com) 获取最新动态，并查看 [源代码](https://github.com/hwchase17/chat-langchain/blob/master/chain.py?ref=blog.langchain.com)。

If you like this and want a more advanced version of this for your codebase, you should check out [ClerkieAI](https://twitter.com/ClerkieAI?ref=blog.langchain.com). Their question answer bot is live on our [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com).

如果您喜欢本项目，并希望为您的代码库部署更高级的版本，欢迎了解 [ClerkieAI](https://twitter.com/ClerkieAI?ref=blog.langchain.com)。他们的问答机器人已在我们的 [Discord](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) 社区中正式上线。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/langchain-chat/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/langchain-chat/img_006.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/langchain-chat/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/langchain-chat/img_007.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/langchain-chat/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/langchain-chat/img_008.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/langchain-chat/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/langchain-chat/img_009.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/langchain-chat/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/langchain-chat/img_010.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/langchain-chat/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项](images/langchain-chat/img_011.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
&#123;% endraw %}
