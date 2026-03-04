---
title: "RealChar x LangSmith: Using Open Source tools to create an AI companion"
source: "LangChain Blog"
url: "https://blog.langchain.com/realchar-x-langsmith-ai-companions/"
date: "2023-07-24"
scraped_at: "2026-03-03T09:32:33.537655627+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

**_Editor’s Note: This blog post was written in collaboration with RealChar, an early [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) BETA user. They moved fast and created something really, really sophisticated and really, really fun to use–all with open source tools._**

**_编者注：本文由 LangChain 团队与 RealChar 联合撰写。RealChar 是 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 早期 Beta 用户之一。他们行动迅速，仅凭开源工具便打造出一款极为精巧、使用体验极佳的 AI 应用。_**

**_We're also very excited about AI characters and companions internally, which is part of the reason we're excited to highlight RealChar. As seen by the meteoric rise of platforms like CharacterAI, allowing people to converse with different personas can be really fun._**

**_我们团队内部也对 AI 角色与 AI 伙伴方向充满热情——这正是我们乐于重点介绍 RealChar 的原因之一。正如 CharacterAI 等平台的迅猛崛起所展现的那样，让用户与不同人格设定的 AI 进行对话，本身就是一件非常有趣的事。_**

**_RealChar may be the most complete and most exciting OSS AI character framework out there. Besides impressive underlying technology, it also offers a really polished UI and UX. They were one of the top trending GitHub repos for basically all of last week, and we'd highly recommend that you check it out if you haven't already._**

**_RealChar 或许是目前最完整、最令人振奋的开源 AI 角色框架。它不仅底层技术实力雄厚，还提供了极为精致的用户界面（UI）与用户体验（UX）。在上周绝大多数时间里，它都稳居 GitHub 最热门仓库榜单前列。若您尚未体验，我们强烈推荐您立即试用！_**

We (RealChar team) are pleased to share our experience using LangSmith and working with LangChain team.

我们（RealChar 团队）很高兴与大家分享使用 LangSmith 的实践经历，以及与 LangChain 团队的合作体验。

In case you don’t know, [RealChar](http://realchar.ai/?ref=blog.langchain.com) is an open source project to let you create, customize and talk to your AI character/companion in realtime (all in one codebase). We offer users natural and seamless conversations with AI on all the common platforms (mobile, web, terminal and desktop soon). We built RealChar leveraging some of best open source tools in the Generative AI/LLM space, including LangChain.

若您尚不了解，[RealChar](http://realchar.ai/?ref=blog.langchain.com) 是一个开源项目，旨在让您实时创建、自定义并与其 AI 角色／AI 伙伴进行对话（全部功能集成于同一代码库中）。我们为用户提供自然、流畅的 AI 对话体验，全面覆盖主流平台（移动端、网页端、终端，桌面端即将上线）。RealChar 的构建深度依托生成式 AI／大语言模型（LLM）领域中最优秀的开源工具，其中包括 LangChain。

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_001.png)![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_002.png)

_Just a fun demo: asking AI Elon about whether he is afraid of losing in the much anticipated cage fight. Full version [here](https://youtu.be/VR61lsWGj6k?ref=blog.langchain.com)._

_趣味演示一则：向 AI 版埃隆提问——他是否担心在万众期待的“笼中对决”中落败？完整视频请见[此处](https://youtu.be/VR61lsWGj6k?ref=blog.langchain.com)。_

RealChar received a ton of attention and usage from the community after [releasing](https://github.com/Shaunwei/RealChar?ref=blog.langchain.com) it just a week ago, and our site has undergo significant traffic. With conversations piling up and logs get cluttered very quickly, we found LangSmith to be a perfect tool for us to monitor and observe the traffic.

RealChar 在一周前[正式发布](https://github.com/Shaunwei/RealChar?ref=blog.langchain.com)后，迅速获得社区广泛关注与大量实际使用，网站流量激增。随着对话请求持续涌入、日志迅速堆积并变得杂乱，我们发现 LangSmith 正是我们监控与观测系统流量的理想工具。

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_003.png)

It’s also easy to filter logs easily based on various conditions, to allow us track issues more accurately. For example, we can easily see all the errors when interacting with the Language Model, which has helped us understand and maintain our reliability better.

此外，LangSmith 支持基于多种条件便捷地筛选日志，从而帮助我们更精准地定位问题。例如，我们可轻松查看所有与大语言模型（LLM）交互过程中发生的错误，这极大提升了我们对系统可靠性的理解与保障能力。

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_004.png)![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_005.png)

LangSmith 还支持我们快速识别重要对话，并轻松将其添加至数据集。这有助于我们在后续工作中利用 LangSmith 的评估（Evaluation）功能，对提示词（prompts）开展效果评估与安全审查。

![](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_006.png)

LangSmith 的用户界面（UI）同样极为出色，操作便捷直观。它在很大程度上已取代了我们此前自研的监控工具。

得益于我们已在使用 LangChain，上述所有功能几乎无需额外成本即可获得。只需在 LangSmith 中配置好 API Key，再设置以下几个环境变量即可：

```jsx
LANGCHAIN_TRACING_V2=true
LANGCHAIN_ENDPOINT=https://api.smith.langchain.com
LANGCHAIN_API_KEY=YOUR_LANGCHAIN_API_KEY
LANGCHAIN_PROJECT=YOUR_LANGCHAIN_PROJECT
```

总体而言，我们认为 LangSmith 是一款集分析（Analytics）、可观测性（Observability）与评估（Evaluation）于一体的优秀工具。对于 RealChar 这类高流量、面向生产环境的应用而言，它极具实用价值。

[/content/media/5101573/253656635-5de0b023-6cf3-4947-84cb-596f429d109e.mp4](https://storage.ghost.io/c/97/88/97889716-a759-46f4-b63f-4f5c46a13333/content/media/5101573/253656635-5de0b023-6cf3-4947-84cb-596f429d109e.mp4?ref=blog.langchain.com)

### 标签

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_007.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_008.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_009.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![对话式检索智能体](images/realchar-x-langsmith-using-open-source-tools-to-create-an-ai-companion/img_010.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**借助 LangChain，通过 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
&#123;% endraw %}
