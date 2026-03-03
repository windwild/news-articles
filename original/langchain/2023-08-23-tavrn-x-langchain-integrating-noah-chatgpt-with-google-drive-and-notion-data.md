---
title: "Tavrn x LangChain: Integrating Noah: ChatGPT with Google Drive and Notion data"
source: "LangChain Blog"
url: "https://blog.langchain.com/integrating-chatgpt-with-google-drive-and-notion-data/"
date: "2023-08-23"
scraped_at: "2026-03-03T08:51:10.916610029+00:00"
language: "en"
translated: false
---

_Editor's Note: This post was written in collaboration with the [Tavrn](https://tavrn.art/?ref=producthunt) team. They were able to build a new personal assistant app, [Noah](https://www.producthunt.com/posts/noah?ref=blog.langchain.com), that's highly personalized and highly context-aware using LangChain (with some interesting retrieval tactics) and LangSmith (for fine-tuning chains and prompts)._

ChatGPT is already an indispensable tool for many in the workplace. Its impressive general purpose performance makes it extremely versatile to assist in workflows ranging from creative brainstorming to coding. In order to get the best outputs from ChatGPT, users are familiar with the process of prompting - providing the chat with as much context and instructions as possible so the output is satisfactory.

The POV of this laborious user experience usually involves multiple rounds of copy/pasting of parts of multiple documents that contain relevant information to the prompt. Given that ChatGPT has no context whatsoever on the user or his work, the output quality highly depends on information the user provides.  For instance, if a user wants ChatGPT's best help to prioritize which product features to build first, he will have to:

1\. Find and open all documents that could potentially have useful context to ChatGPT (e.g. product meeting notes, user feedback reports, information about the product itself)

2\. Read through each document, copy the relevant parts and paste on ChatGPT

3\. Hope it all fits the character limit of ChatGPT and that he did not forget to include any important context

This inefficient, manual process of always having to supply the best context to ChatGPT prevents users from utilizing it for more complex use cases like the one illustrated above. We built Noah to resolve the context fetching problem and allow users to experience an AI copilot that always efficiently retrieves the best possible context to answer user queries.

Simplicity and user-friendliness are core to Noah. We take care of all the heavy-lifting in the background. In just a few clicks, users can sync hundreds of files from their own Google Drive and Notion and start getting help from Noah.

Powered by LangChain, Noah unlocks a more powerful and relevant use of LLMs in the workplace: a personal AI assistant that provides help specifically to users and their work. In the product prioritization example above, Noah would take care of all three steps (finding relevant documents, selecting the most relevant parts in each document, adding each part to the LLM prompt) so the user's sole input to the chat can be "which product features should I prioritize?"

To get started on Noah, users select the tools from which they would like to sync files.

![](images/tavrn-x-langchain-integrating-noah-chatgpt-with-google-drive-and-notion-data/img_001.gif)

After the tool is selected, users can either choose specific files or quickly select their 200 most recent files from Google Drive or Notion.

![](https://lh5.googleusercontent.com/t2xs6xRrfu25K9yCQ1K4UET73oRRjjqFXsBhQkTDTDGOfaPNTgkgLTN_ApTfKZ_JG4cne-3Yzmg9TiGIoptd27HUhiFqQIN4c-IWGjWadMiHv9evOSaX3_ylvlwJQZRcXZhsPHMmFULG09gc5xG8nTE)

Once users select their files, Noah processes the documents using optimized, context-aware document loaders in addition to state-of-the-art embeddings models. We tried multiple forms of semantic chunking but LangChain's CharacterTextSplitter with around 2,400 characters per chunk outperformed all the others for all types of documents - spreadsheets, documents, PDFs, slides.

![](https://lh3.googleusercontent.com/npGqwFD0qImws_Xd8XuG8U-6QsKJ6TOLUwtR3l_BRNNUIncQau5VshTBA1W_Q8W8aY7QNcNwC4t3rlapt1-cfGzSA6WctKBGXJ4iTpsv4NS_6o9Pl3FW2RAYGD7ye5V9lHBG9RP_oDCI0GViLupIqMo)

Then, once a user asks a question, Noah fetches the most relevant content across multiple sources utilizing cosine similarity vector search and passes them to multi-chain LLM calls where the best possible answer is obtained. We also tried other forms of retrieval but cosine similarity substantially outperformed the others.

Langsmith was extra useful to us when fine-tuning which chains and prompts to use for the final user answer. Among the learnings, the optimal memory "k" parameter for ConversationBufferWindowMemory is 1 otherwise the answers get unreliable with so much historical context. Additionally, after the chunks are retrieved, we pass them into an intermediary, GPT-4 powered chain to filter out any conflicting information, _prioritizing more recent sources._

![](https://lh6.googleusercontent.com/D3uqoj_wkX9vXK39VQzrBcQaG9EXRr7h-FaRqsyHMMxJmeDEzQ3DQ4E8f6M_DT-1LN-XeKbF56aRdOKdOD0P0vNL7Hh7NNLe30aUkWLXHL_feM-ZlpNIdEagDqF5reuaIRgdNlUpRC2WgLcXirMw9bs)

Finally, Noah provides the answer, with the appropriate sources cited.

To get started with Noah and boost your productivity, access [https://tavrn.art/noah](https://tavrn.art/noah?ref=blog.langchain.com).