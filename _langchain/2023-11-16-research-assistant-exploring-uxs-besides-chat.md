---
title: "\"Research Assistant\": Exploring UXs Besides Chat"
source: "LangChain Blog"
url: "https://blog.langchain.com/exploring-uxs-besides-chat-with-research-assistant/"
date: "2023-11-16"
scraped_at: "2026-03-03T08:26:03.324304972+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**TLDR: 我们很高兴地宣布一款全新的** [**LangChain 模板**](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com) **，专为辅助研究工作而设计，其设计深受** [**GPT Researcher**](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) **团队启发，并与之深度协作完成。我们对此尤为振奋，因为这是目前我们所见性能最优、运行最久、通用性最强、且非对话式（non-chat）的“认知架构”之一。**

**TLDR：我们很高兴地宣布一款全新的** [**LangChain 模板**](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com) **，专为辅助研究工作而设计，其设计深受** [**GPT Researcher**](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com) **团队启发，并与之深度协作完成。我们对此尤为振奋，因为这是目前我们所见性能最优、运行最久、通用性最强、且非对话式（non-chat）的“认知架构”之一。**

**关键链接（Key Links）：**

**关键链接（Key Links）：**

- **访问“研究助理”模板** [**此处**](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com)  
- **观看我们从零开始编写“研究助理”的全过程** [**此处**](https://www.youtube.com/watch?v=DjuXACWYkkU&ref=blog.langchain.com)

- **访问“研究助理”模板** [**此处**](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com)  
- **观看我们从零开始编写“研究助理”的全过程** [**此处**](https://www.youtube.com/watch?v=DjuXACWYkkU&ref=blog.langchain.com)

## The Downside of Chat

## 聊天界面的局限性

Most LLM applications so far have been chat based. This isn’t terribly surprising - ChatGPT is the [fastest growing consumer application](https://www.reuters.com/technology/chatgpt-sets-record-fastest-growing-user-base-analyst-note-2023-02-01/?ref=blog.langchain.com), and chat is a reasonable UX (allows for back and forth, is a natural medium). However, chat as a UX also has some downsides, and can often make it harder to create highly performant applications.

迄今为止，大多数大语言模型（LLM）应用均基于聊天界面构建。这并不令人意外——ChatGPT 是 [增长最快的消费级应用](https://www.reuters.com/technology/chatgpt-sets-record-fastest-growing-user-base-analyst-note-2023-02-01/?ref=blog.langchain.com)，而聊天本身也是一种合理的用户体验（UX）设计（支持双向交互，符合人类自然沟通习惯）。然而，作为用户界面（UX），聊天模式也存在若干固有局限，往往使构建高性能应用变得更具挑战性。

**Latency Expectations**

**延迟预期**

The main downside are the latency expectations that come with chat. When you are using a chat application, there is a certain expectation you have as a user around the latency of that application. Specifically, you expect a quick response. This is why streaming is an incredibly important functionality in LLM applications - it gives the illusion of a fast response and shows progress.

聊天模式最主要的问题在于其附带的延迟预期。当你使用一个聊天应用时，作为用户，你天然会对该应用的响应延迟抱有特定期待——具体而言，你期望得到快速回应。正因如此，“流式输出（streaming）”在 LLM 应用中成为一项至关重要的功能：它营造出响应迅捷的假象，并实时呈现处理进度。

These latency expectations mean that it is tough to do too much work behind the scenes - the more work you do, the longer it will take to generate a response. This is a bit problematic - the major issue with LLM application is [their accuracy/performance](https://retool.com/reports/state-of-ai-2023?ref=blog.langchain.com), and one main way to increase is the spend more time breaking down the process into individual steps, running more checks, etc. However, all these additional steps greatly increase latency.

此类延迟预期意味着，在后台执行过多计算将十分困难——你做的工作越多，生成最终响应所需的时间就越长。这带来一定困境：当前 LLM 应用面临的核心挑战是 [其准确性与整体性能](https://retool.com/reports/state-of-ai-2023?ref=blog.langchain.com)，而提升性能的主要路径之一，恰恰是投入更多时间将任务拆解为多个精细步骤、执行更全面的校验等。然而，所有这些额外步骤都会显著增加端到端延迟。

We often talk to teams who try to balance these two considerations, which can at points be contradictory. While working in a chat UX, for complex reasoning tasks it’s tough to get a highly accurate and helpful response in the time that is expected.

我们经常与各类团队交流，他们正努力在这两个目标之间寻求平衡——而这种平衡在某些情况下近乎矛盾。在聊天式 UX 下，面对复杂的推理任务，要在用户所预期的时间内产出高度准确且真正有用的回答，实属不易。

**Output Format**

**输出格式**

Chat is great for messages. It’s less great for things that don’t really belong in messages - like long papers or code files, or multiple files. While working with a chat UX, displaying results as messages can often make them tougher to review or consume.

聊天非常适合传递简短消息，但并不适合承载本不属于消息范畴的内容——例如长篇论文、代码文件，或多个文件。在采用聊天式用户界面（UX）时，将结果以消息形式呈现，往往会使用户更难审阅或有效获取信息。

**Human in the Loop**

**人在回路中（Human in the Loop）**

LLMs are not (yet) highly accurate, and so most applications heavily feature humans in the loop. This makes sense - only use the LLM in small bursts, and then have a human check/validate its output and ask for a followup.

大语言模型（LLM）目前尚不具备高度准确性，因此绝大多数应用都深度依赖“人在回路中”机制。这非常合理：仅在小范围内调用 LLM 生成输出，随后由人工检查、验证其结果，并视需发起后续交互。

However, there is a balance to strike here. If the human needs to be too much in the loop, then it’s not actually saving them time! But you can’t take the human out of the loop completely - again, LLMs just aren’t reliable enough for this.

然而，这里需要把握一个平衡点：若人类介入过于频繁，则该方案实际上并未节省用户时间！但也不能完全绕过人工审核——毕竟，LLM 当前的可靠性仍不足以独立承担关键任务。

The key is in finding UXs where you can ask the LLM to do a large amount of work, but it results in something that is still not expected to be a perfect output.

关键在于设计出这样一类用户体验（UX）：允许 LLM 承担大量工作，但其产出本身并不要求“一次性完美”，而是作为可被高效审查、迭代和完善的中间成果。

## Non-Chat Projects

## 非聊天类项目

There are a number of projects that we are excited about that do not use chat as a primary medium. Highlighting a few below:

我们正密切关注若干不以聊天为主要交互方式的项目。以下列举其中几个代表性案例：

This project has a small chat component (asking clarifying questions) afterwords runs autonomously and generates code files. This has humans in the loop at key points:

该项目包含一个轻量级的聊天组件（用于提出澄清性问题），随后即自主运行并生成代码文件。人类仅在关键节点介入：

- Clarifying questions: early on, gather requirements  
- 澄清性提问：项目初期，用于收集需求  

- At the end, when you can inspect the code  
- 项目末期，供用户检查所生成的代码  

The final generated code can easily be modified by the user, so it’s more of a first draft than anything. The output is Python files - far more natural than outputing in chat. There’s no expectation that files are generated automatically - if I were to ask a colleague to write some code, I wouldn’t expect them to continuously message me their progress! I’d expect them to go off for a while, do some work, and then I’d check in - exactly the UX here.

最终生成的代码可由用户轻松修改，本质上更接近一份“初稿”，而非终稿。输出形式为 Python 文件——远比在聊天窗口中逐段输出代码来得自然。用户也并不期待文件能全自动、实时生成：假如我请一位同事编写代码，我不会指望他不断通过消息向我同步进度；相反，我会默认他先独自工作一段时间，完成阶段性成果后再与我同步——这正是本项目所采用的 UX 设计理念。

This bot has been patrolling our GitHub repo and responding to issues. Users do not interact with it through chat, but rather through GitHub issues. The expectation for response time on GitHub issues is FAR higher than that of chat, allowing plenty of time for DosuBot to go do its thing. Its outputs are not expected to be perfect artifacts either - they are merely replies to users. The users are very much in the loop to take them and implement them as they see fit.

该机器人一直在我们的 GitHub 仓库中巡检并响应 issue。用户并非通过聊天界面与它交互，而是通过 GitHub issue 进行交互。对于 GitHub issue 的响应时效要求，远高于聊天场景——这为 DosuBot 充分完成其任务留出了充裕时间。它的输出也无需达到“完美成品”的标准，而仅需作为对用户的合理回复即可；用户始终处于核心环节，可自主决定是否采纳这些回复，并按自身需要加以实现。

We’ve discussed this project before (and will discuss it far more in the next section, as “Research Assistants” are heavily based on it). This project writes full research reports. It saves files that are generated - just as we would save research reports (we wouldn’t message them in chat to each other)! It takes a while to run - but that’s totally fine. If I asked a colleague to write me a research report, I wouldn’t expect anything close to an instantaneous response. It’s outputs can easily be inspected and modified, and used as a first draft - no expectation of a complete output.

我们此前已讨论过该项目（下一节将更深入展开，因为“研究助手”正是在此项目基础上深度构建的）。该项目可生成完整的调研报告，并将产出结果以文件形式保存——正如我们日常撰写调研报告后会将其存为文档（而非在聊天窗口中直接发送给同事）！该流程耗时较长，但这完全可接受：倘若我请一位同事为我撰写一份调研报告，我也绝不会期待对方即时交付。其输出内容易于审阅、修改，并可直接作为初稿使用——我们对其并无“开箱即用、一步到位”的预期。

All of these projects buck the trend of chat based UXs. They bite off larger and larger chunks of work - rather than answer a single question that you can use in a research report, they write the research report for you! The final response is often best served not as a chat message but some other file, and these can easily be modified, so there is still a human-in-the-loop component.

上述所有项目均打破了以聊天界面为主导的用户体验范式。它们逐步承接起更大、更复杂的任务单元——不再局限于回答某个可用于调研报告中的单个问题，而是直接为你撰写整份调研报告！最终成果往往并不适合作为一条聊天消息呈现，而更宜封装为某种独立文件；这类文件易于编辑调整，因而仍天然保留了“人在回路中（human-in-the-loop）”的关键环节。

These project’s aren’t just exciting because they don’t use chat. They are exciting because they are some of the most useful applications we see, and that be precisely because they do not use chat.

这些项目之所以令人振奋，不仅在于它们摒弃了聊天界面，更在于它们代表了我们目前所见最具实用价值的一类应用——而这恰恰正是因其未采用聊天交互模式所致。

## Research Assistant

## 研究助手

A few weeks ago we introduced [LangChain Templates](https://blog.langchain.com/langchain-templates/) \- a collection of reference architectures that are the quickest way to get started with a GenAI application. Most of these revolved around chat. However, some of the most interesting and useful applications we see (including the ones above) do not use chat as the primary interface.

数周前，我们推出了 [LangChain 模板（LangChain Templates）](https://blog.langchain.com/langchain-templates/) ——这是一套参考架构集合，也是启动生成式 AI（GenAI）应用最快捷的途径。其中大多数模板围绕聊天场景设计。然而，我们所见到的最富趣味性与实用性的若干应用（包括上文所述项目）却并未将聊天作为主要交互界面。

We wanted to begin to add templates that were not chat based. We have [worked closely](https://blog.langchain.com/gpt-researcher-x-langchain/) with the GPT-Researcher team in the past and think they have a fantastic use case. As such, we worked with them to add a “Research Assistant” template to LangChain Templates, making it easy to get started with this template completely in the LangChain ecosystem. Note: they also recently released a major new version - [check it out](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com).

我们希望开始纳入非聊天导向的模板。此前，我们曾与 [GPT-Researcher 团队](https://blog.langchain.com/gpt-researcher-x-langchain/) 展开密切协作，并高度认可其应用场景的价值。因此，我们携手该团队，将“研究助手（Research Assistant）”模板正式加入 LangChain Templates，使开发者得以全程依托 LangChain 生态系统便捷地启动并使用该模板。注：该团队近期亦发布了重大新版本——[欢迎查看](https://github.com/assafelovic/gpt-researcher?ref=blog.langchain.com)。

What does this application do under the hood? The “cognitive architecture” can be broken down into a few steps:

该应用在底层如何运作？其“认知架构”可拆解为以下若干步骤：

- User inputs question/topic to write about  
- Generate a bunch of sub questions  
- For each sub question: research that subquestion and get relevant documents, then summarize those documents with respect to the subquestion  
- Take the summaries for each subquestion, and combine them into the final report.  
- Output Final Report  

- 用户输入待撰写的议题或问题  
- 生成一系列子问题  
- 针对每个子问题：开展专项检索，获取相关文档，并据此围绕该子问题进行摘要提炼  
- 汇总各子问题对应的摘要，整合生成最终报告  
- 输出最终报告  

Each of these pieces is modular, making it a perfect fit for the LangChain ecosystem.

上述每个环节均具备模块化特性，因而与 LangChain 生态系统高度契合。

- Swap out the prompt and/or the LLM used to generate the subquestions  
- 替换用于生成子问题的提示词（prompt）和/或大语言模型（LLM）

- Swap out the retriever used to fetch relevant documents  
- 替换用于检索相关文档的检索器（retriever）

- Swap out the prompt and/or the LLM used to generate the final report  
- 替换用于生成最终报告的提示词（prompt）和/或大语言模型（LLM）

By default, the template uses OpenAI for the LLM, and [Tavily](https://app.tavily.com/sign-in?ref=blog.langchain.com) for the search engine. Tavily is a search engine made by the GPT-Researcher team, and is optimized for AI workloads. Specifically, the Tavily API optimizes for RAG. They optimize for getting the most factual and relevant information to insert in any RAG pipeline that will maximize LLM reasoning and output. This allows for an easy-to-use experience of searching the web. However, it can easily be modified to point to our Arxiv Retriever, or our PubMed Retriever, and quickly turned into a research assistant for those sites. It can equally easily be pointed to a vectorstore containing your relevant information.  

默认情况下，该模板使用 OpenAI 作为大语言模型（LLM），并使用 [Tavily](https://app.tavily.com/sign-in?ref=blog.langchain.com) 作为搜索引擎。Tavily 是由 GPT-Researcher 团队开发的搜索引擎，专为 AI 工作负载优化。具体而言，Tavily API 针对 RAG（检索增强生成）场景进行了深度优化：它致力于在任意 RAG 流程中提供最准确、最相关的检索结果，从而最大化大语言模型的推理能力与输出质量。这使得网络搜索变得极为便捷易用。然而，该配置可轻松修改——例如切换至我们的 Arxiv 检索器（Arxiv Retriever）或 PubMed 检索器（PubMed Retriever），快速构建面向相应学术平台的研究助手；亦可无缝对接您自有知识库所在的向量数据库（vectorstore）。

This architecture is doing a LOT under the hood. Another big benefit of integrating this into the LangChain ecosystem is that you can get best-in-class observability for this architecture through [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com). With LangSmith, you can see all the many steps, and inspect the inputs and outputs at each one  

该架构在底层实际执行了大量复杂工作。将此方案集成进 LangChain 生态系统的另一大优势在于：您可通过 [LangSmith](https://smith.langchain.com/?ref=blog.langchain.com) 获得业界领先的可观测性支持。借助 LangSmith，您可以清晰查看整个流程中的所有步骤，并逐层检查每一步的输入与输出。

![](images/research-assistant-exploring-uxs-besides-chat/img_001.png)

You can explore this example trace [here](https://smith.langchain.com/public/bbeb51ba-d804-4c4f-b80d-1e429b180819/r?ref=blog.langchain.com).  

您可在此处探索该示例调用链（trace）：[点击访问](https://smith.langchain.com/public/bbeb51ba-d804-4c4f-b80d-1e429b180819/r?ref=blog.langchain.com)。

## Conclusion  

## 结语

While the GenAI space so far has been dominated by application with chat UXs, we are bullish on the most useful autonomous systems being longer running ones. So is Assaf Elovic, the creator of GPT-Researcher:  

尽管当前生成式 AI（GenAI）领域仍以具备聊天界面（chat UX）的应用为主导，但我们坚信：最具实用价值的自主系统，将是那些运行周期更长、任务更复杂的系统。GPT-Researcher 的创始人 Assaf Elovic 同样持此观点：

> As AI improves, so will automation grow over time, and user behavior will only grow to demand it more and more from products. And with automation growing, user expectation will change, moving less from immediate response/feedback and more to the ability to get high quality results.  

> 随着人工智能持续进步，自动化能力也将随之长期演进；用户行为亦将日益强化对产品自动化能力的需求。而随着自动化程度提升，用户预期亦将发生转变——不再仅仅关注即时响应/反馈，而是愈发重视能否获得高质量的结果。

> Because of this, there is room and need for much more sophisticated AI applications that might take longer to complete, but aim at maximizing quality of RAG and content generation. This is also relates to autonomous agent frameworks that will run in the background to complete complex tasks.  

> 正因如此，市场亟需也留有广阔空间，去发展更为复杂的 AI 应用——它们或许耗时更长，但目标明确：最大化 RAG 效果与内容生成质量。这也正契合自主智能体（autonomous agent）框架的发展方向：即在后台持续运行，以完成各类复杂任务。

GPT-Researcher is a perfect example of this, and we’re excited to have worked with them to bring this “research assistant” template to fruition. Play around with it [here](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com) and let us know your thoughts!  

GPT-Researcher 正是这一理念的完美范例。我们非常荣幸能与 GPT-Researcher 团队合作，共同将这一“研究助手”模板成功落地。欢迎前往 [此处](https://github.com/langchain-ai/langchain/tree/master/templates/research-assistant?ref=blog.langchain.com) 亲自体验，并随时与我们分享您的想法！
{% endraw %}
