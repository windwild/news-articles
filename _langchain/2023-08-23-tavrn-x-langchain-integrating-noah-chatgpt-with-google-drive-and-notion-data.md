---
title: "Tavrn x LangChain: Integrating Noah: ChatGPT with Google Drive and Notion data"
source: "LangChain Blog"
url: "https://blog.langchain.com/integrating-chatgpt-with-google-drive-and-notion-data/"
date: "2023-08-23"
scraped_at: "2026-03-03T08:51:10.916610029+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the [Tavrn](https://tavrn.art/?ref=producthunt) team. They were able to build a new personal assistant app, [Noah](https://www.producthunt.com/posts/noah?ref=blog.langchain.com), that's highly personalized and highly context-aware using LangChain (with some interesting retrieval tactics) and LangSmith (for fine-tuning chains and prompts)._

_编辑注：本文由 [Tavrn](https://tavrn.art/?ref=producthunt) 团队协作撰写。他们基于 LangChain（结合若干创新的检索策略）和 LangSmith（用于链式流程与提示词的精细调优），成功构建了一款全新的个人助理应用——[Noah](https://www.producthunt.com/posts/noah?ref=blog.langchain.com)。该应用高度个性化，且具备极强的上下文感知能力。_

ChatGPT is already an indispensable tool for many in the workplace. Its impressive general purpose performance makes it extremely versatile to assist in workflows ranging from creative brainstorming to coding. In order to get the best outputs from ChatGPT, users are familiar with the process of prompting - providing the chat with as much context and instructions as possible so the output is satisfactory.

ChatGPT 已成为职场中许多人的必备工具。其出色的通用性能，使其能够灵活胜任从创意头脑风暴到编程开发等各类工作流。为获得最佳输出结果，用户已熟悉“提示工程”（prompting）这一过程——即尽可能向对话提供丰富的上下文信息与明确指令，以确保输出结果令人满意。

The POV of this laborious user experience usually involves multiple rounds of copy/pasting of parts of multiple documents that contain relevant information to the prompt. Given that ChatGPT has no context whatsoever on the user or his work, the output quality highly depends on information the user provides.  For instance, if a user wants ChatGPT's best help to prioritize which product features to build first, he will have to:

这种费时费力的用户体验，通常意味着用户需反复从多份文档中复制粘贴相关内容至提示中。由于 ChatGPT 对用户本人及其具体工作内容毫无上下文认知，其输出质量几乎完全取决于用户主动提供的信息。例如，若某用户希望借助 ChatGPT 的最优建议，确定应优先开发哪些产品功能，则他必须：

1\. Find and open all documents that could potentially have useful context to ChatGPT (e.g. product meeting notes, user feedback reports, information about the product itself)

1. 查找并打开所有可能对 ChatGPT 具有参考价值的文档（例如：产品会议纪要、用户反馈报告、产品自身相关信息等）；

2\. Read through each document, copy the relevant parts and paste on ChatGPT

2. 逐份通读文档，摘取相关内容并粘贴至 ChatGPT；

3\. Hope it all fits the character limit of ChatGPT and that he did not forget to include any important context

3. 祈祷所有内容未超出 ChatGPT 的字符限制，并且自己没有遗漏任何关键上下文。

This inefficient, manual process of always having to supply the best context to ChatGPT prevents users from utilizing it for more complex use cases like the one illustrated above. We built Noah to resolve the context fetching problem and allow users to experience an AI copilot that always efficiently retrieves the best possible context to answer user queries.

这种低效、纯手动的“持续供给最优上下文”流程，严重阻碍了用户将 ChatGPT 应用于更复杂的场景（如上例所示）。我们打造 Noah，正是为了从根本上解决上下文获取难题，让用户真正体验一位始终能高效检索最优上下文、精准回应查询的 AI 副驾驶。

Simplicity and user-friendliness are core to Noah. We take care of all the heavy-lifting in the background. In just a few clicks, users can sync hundreds of files from their own Google Drive and Notion and start getting help from Noah.

简洁性与易用性是 Noah 的核心设计理念。所有繁重的技术工作均由后台自动完成。用户仅需数次点击，即可将其个人 Google Drive 和 Notion 中的数百个文件同步至 Noah，并立即开始获得帮助。

Powered by LangChain, Noah unlocks a more powerful and relevant use of LLMs in the workplace: a personal AI assistant that provides help specifically to users and their work. In the product prioritization example above, Noah would take care of all three steps (finding relevant documents, selecting the most relevant parts in each document, adding each part to the LLM prompt) so the user's sole input to the chat can be "which product features should I prioritize?"

Noah 基于 LangChain 构建，释放了大语言模型（LLM）在职场中更强大、更贴合实际的应用潜力：一位专属于用户及其具体工作的个人 AI 助理。以上述产品功能优先级排序为例，Noah 将自动完成全部三个步骤（查找相关文档、筛选每份文档中最相关的片段、将各片段整合进 LLM 提示词），因此用户在对话中只需输入一句：“我该优先开发哪些产品功能？”

To get started on Noah, users select the tools from which they would like to sync files.

要开始使用 Noah，用户只需选择希望同步文件的工具来源。

![](images/tavrn-x-langchain-integrating-noah-chatgpt-with-google-drive-and-notion-data/img_001.gif)

![](images/tavrn-x-langchain-integrating-noah-chatgpt-with-google-drive-and-notion-data/img_001.gif)

After the tool is selected, users can either choose specific files or quickly select their 200 most recent files from Google Drive or Notion.

工具选定后，用户既可手动选择特定文件，也可快速选取其在 Google Drive 或 Notion 中最近的 200 个文件。

![](https://lh5.googleusercontent.com/t2xs6xRrfu25K9yCQ1K4UET73oRRjjqFXsBhQkTDTDGOfaPNTgkgLTN_ApTfKZ_JG4cne-3Yzmg9TiGIoptd27HUhiFqQIN4c-IWGjWadMiHv9evOSaX3_ylvlwJQZRcXZhsPHMmFULG09gc5xG8nTE)

![](https://lh5.googleusercontent.com/t2xs6xRrfu25K9yCQ1K4UET73oRRjjqFXsBhQkTDTDGOfaPNTgkgLTN_ApTfKZ_JG4cne-3Yzmg9TiGIoptd27HUhiFqQIN4c-IWGjWadMiHv9evOSaX3_ylvlwJQZRcXZhsPHMmFULG09gc5xG8nTE)

Once users select their files, Noah processes the documents using optimized, context-aware document loaders in addition to state-of-the-art embeddings models. We tried multiple forms of semantic chunking but LangChain's CharacterTextSplitter with around 2,400 characters per chunk outperformed all the others for all types of documents — spreadsheets, documents, PDFs, slides.

用户选定文件后，Noah 会借助优化的、上下文感知型文档加载器，以及业界领先的嵌入（embeddings）模型对文档进行处理。我们尝试了多种语义分块（semantic chunking）方法，但最终发现：对于所有类型的文档（包括电子表格、文本文档、PDF 和幻灯片），LangChain 的 `CharacterTextSplitter`（每块约 2400 个字符）效果显著优于其他所有方案。

![](https://lh3.googleusercontent.com/npGqwFD0qImws_Xd8XuG8U-6QsKJ6TOLUwtR3l_BRNNUIncQau5VshTBA1W_Q8W8aY7QNcNwC4t3rlapt1-cfGzSA6WctKBGXJ4iTpsv4NS_6o9Pl3FW2RAYGD7ye5V9lHBG9RP_oDCI0GViLupIqMo)

![](https://lh3.googleusercontent.com/npGqwFD0qImws_Xd8XuG8U-6QsKJ6TOLUwtR3l_BRNNUIncQau5VshTBA1W_Q8W8aY7QNcNwC4t3rlapt1-cfGzSA6WctKBGXJ4iTpsv4NS_6o9Pl3FW2RAYGD7ye5V9lHBG9RP_oDCI0GViLupIqMo)

Then, once a user asks a question, Noah fetches the most relevant content across multiple sources utilizing cosine similarity vector search and passes them to multi-chain LLM calls where the best possible answer is obtained. We also tried other forms of retrieval but cosine similarity substantially outperformed the others.

随后，当用户提出问题时，Noah 利用余弦相似度（cosine similarity）向量检索，从多个数据源中提取最相关的内容，并将其输入多链式大语言模型（multi-chain LLM）调用流程，从而生成最优答案。我们也尝试过其他检索方式，但余弦相似度的表现远超其余方案。

Langsmith was extra useful to us when fine-tuning which chains and prompts to use for the final user answer. Among the learnings, the optimal memory "k" parameter for ConversationBufferWindowMemory is 1 otherwise the answers get unreliable with so much historical context. Additionally, after the chunks are retrieved, we pass them into an intermediary, GPT-4 powered chain to filter out any conflicting information, _prioritizing more recent sources._

LangSmith 在微调最终用户答案所用的链（chains）与提示词（prompts）时，为我们提供了极大帮助。其中一项关键发现是：`ConversationBufferWindowMemory` 的最优记忆长度参数 “k” 应设为 1；否则，在历史上下文如此丰富的情况下，答案将变得不可靠。此外，在完成分块内容检索后，我们会将这些分块送入一个由 GPT-4 驱动的中间链（intermediary chain），用于过滤相互矛盾的信息，并**优先采用更新近的数据源**。

![](https://lh6.googleusercontent.com/D3uqoj_wkX9vXK39VQzrBcQaG9EXRr7h-FaRqsyHMMxJmeDEzQ3DQ4E8f6M_DT-1LN-XeKbF56aRdOKdOD0P0vNL7Hh7NNLe30aUkWLXHL_feM-ZlpNIdEagDqF5reuaIRgdNlUpRC2WgLcXirMw9bs)

![](https://lh6.googleusercontent.com/D3uqoj_wkX9vXK39VQzrBcQaG9EXRr7h-FaRqsyHMMxJmeDEzQ3DQ4E8f6M_DT-1LN-XeKbF56aRdOKdOD0P0vNL7Hh7NNLe30aUkWLXHL_feM-ZlpNIdEagDqF5reuaIRgdNlUpRC2WgLcXirMw9bs)

Finally, Noah provides the answer, with the appropriate sources cited.

最后，Noah 给出答案，并准确标注所引用的来源。

To get started with Noah and boost your productivity, access [https://tavrn.art/noah](https://tavrn.art/noah?ref=blog.langchain.com).

如需立即体验 Noah，提升您的工作效率，请访问：[https://tavrn.art/noah](https://tavrn.art/noah?ref=blog.langchain.com)。
&#123;% endraw %}
