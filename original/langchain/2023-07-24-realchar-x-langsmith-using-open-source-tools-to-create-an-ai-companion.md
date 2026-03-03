---
title: "RealChar x LangSmith: Using Open Source tools to create an AI companion"
source: "LangChain Blog"
url: "https://blog.langchain.com/realchar-x-langsmith-ai-companions/"
date: "2023-07-24"
scraped_at: "2026-03-03T09:32:33.537655627+00:00"
language: "en"
translated: false
---

**_Editor’s Note: This blog post was written in collaboration with RealChar, an early [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) BETA user. They moved fast and created something really, really sophisticated and really, really fun to use–all with open source tools._**

**_We're also very excited about AI characters and companions internally, which is part of the reason we're excited to highlight RealChar. As seen by the meteoric rise of platforms like CharacterAI, allowing people to converse with different personas can be really fun._**

**_RealChar may be the most complete and most exciting OSS AI character framework out there. Besides impressive underlying technology, it also offers a really polished UI and UX. They were one of the top trending GitHub repos for basically all of last week, and we'd highly recommend that you check it out if you haven't already._**

We (RealChar team) are pleased to share our experience using LangSmith and working with LangChain team.

In case you don’t know, [RealChar](http://realchar.ai/?ref=blog.langchain.com) is an open source project to let you create, customize and talk to your AI character/companion in realtime (all in one codebase). We offer users natural and seamless conversations with AI on all the common platforms (mobile, web, terminal and desktop soon). We built RealChar leveraging some of best open source tools in the Generative AI/LLM space, including LangChain.

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_001.png)![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_002.png)

_Just a fun demo: asking AI Elon about whether he is afraid of losing in the much anticipated cage fight. Full version [here](https://youtu.be/VR61lsWGj6k?ref=blog.langchain.com)._

RealChar received a ton of attention and usage from the community after [releasing](https://github.com/Shaunwei/RealChar?ref=blog.langchain.com) it just a week ago, and our site has undergo significant traffic. With conversations piling up and logs get cluttered very quickly, we found LangSmith to be a perfect tool for us to monitor and observe the traffic.

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_003.png)

It’s also easy to filter logs easily based on various conditions, to allow us track issues more accurately. For example, we can easily see all the errors when interacting with the Language Model, which has helped us understand and maintain our reliability better.

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_004.png)![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_005.png)

LangSmith also allows us to identify important conversations and add to dataset easily. This is then helpful for us to evaluate and safe checking the prompts going forward, using the Evaluation features of LangSmith.

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_006.png)

The UI of LangSmith is also top-notch and easy to work with. It largely replaced our monitoring tools previously built in-house.

All these features are almost free to get as we already use LangChain. As soon as the API Key are set up in LangSmith, only a few environment variables are needed:

```jsx
LANGCHAIN_TRACING_V2=true
LANGCHAIN_ENDPOINT=https://api.smith.langchain.com
LANGCHAIN_API_KEY=YOUR_LANGCHAIN_API_KEY
LANGCHAIN_PROJECT=YOUR_LANGCHAIN_PROJECT
```

Overall, we see LangSmith as a great tool for Analytics, Observability, and Evaluation, all in one place. It’s very useful for a production-level application with large volume of traffic like RealChar.

[/content/media/5101573/253656635-5de0b023-6cf3-4947-84cb-596f429d109e.mp4](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/media/5101573/253656635-5de0b023-6cf3-4947-84cb-596f429d109e.mp4?ref=blog.langchain.com)

### Tags



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_007.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_008.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_009.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_010.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)