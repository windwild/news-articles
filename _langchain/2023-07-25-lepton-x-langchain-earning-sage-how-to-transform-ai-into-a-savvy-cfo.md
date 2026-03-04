---
title: "Lepton x LangChain: Earning Sage, How to Transform AI into a Savvy CFO"
source: "LangChain Blog"
url: "https://blog.langchain.com/lepton-x-langchain-earning-sage/"
date: "2023-07-25"
scraped_at: "2026-03-03T09:32:25.470238983+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**_Editor’s Note: This blog post was written in collaboration LeptonAI Team, an early [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) BETA user. Lots of folks are talking about how best to finetune an open-source model for their specific use case, and LeptonAI has actually done that. We're excited to share their journey and hope it can inform others._**

**_编者按：本文由 LeptonAI 团队与 LangChain 团队合作撰写。LeptonAI 是早期 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 的 Beta 用户之一。当前，许多开发者正热议如何针对自身具体应用场景对开源大模型进行微调（finetuning），而 LeptonAI 已切实完成了这一实践。我们非常荣幸分享他们的探索历程，并希望这一经验能为其他团队提供有益参考。_**

# Introduction

# 引言

Have you ever thought about joining an earning call and asking questions to these CFOs? That used to be the privilege held by the investors from high-end investment banks such as JP Morgan, Goldman Sachs and Morgan Stanley.

你是否曾想过亲自参加一场财报电话会议，并向这些首席财务官（CFO）提问？过去，这仅是高盛（Goldman Sachs）、摩根大通（J.P. Morgan）和摩根士丹利（Morgan Stanley）等顶级投资银行投资者才享有的特权。

Yet with the capability of LLM and proper techniques around it, not anymore.  And if you don’t feel like reading the whole post, feel free to try out a demo [here](https://earningsage.lepton.run/?ref=blog.langchain.com). This demo is created based on the [Apple Q2 2023 earning call](https://github.com/bobmayuze/Earning-Sage/blob/main/earning_reports/AAPL-89728-full.tsv?ref=blog.langchain.com).

然而，借助大语言模型（LLM）的强大能力及配套技术方案，这一门槛已然被打破。若您不想通读全文，欢迎直接体验我们的演示应用：[点击此处](https://earningsage.lepton.run/?ref=blog.langchain.com)。该演示基于 [苹果公司 2023 年第二财季财报电话会议实录](https://github.com/bobmayuze/Earning-Sage/blob/main/earning_reports/AAPL-89728-full.tsv?ref=blog.langchain.com) 构建。

Step into the realm where cutting-edge technology meets financial acumen, let’s dive deep into the transformative process of harnessing the capability of AI, and unveil the secrets to crafting an AI that speaks like a seasoned Chief Financial Officer (CFO), as demonstrated below.

步入前沿科技与金融专业素养交汇的领域——让我们深入探究如何释放人工智能的潜能，并揭示打造一位“言谈如资深首席财务官（CFO）”般睿智 AI 的核心秘诀，如下图所示：

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_001.png)

# Problem Statement

# 问题定义

To begin with, I would like to breakdown the challenge mentioned above into an abstraction, which hopefully can help you understand at an engineering level on what problem we are facing. In a nutshell, the problem looks like this:

首先，我想将上述挑战抽象化，以帮助您从工程实现层面清晰理解我们所面对的核心问题。简而言之，该问题可表述如下：

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_002.png)

The problem we are facing here is to `organically` combine the original earning call transcript,  the text generation model ( mostly could be OpenAI ChatGPT 3.5) and the toolset(python, langchain, chroma, nothing fancy here) to mimic a CFO.

我们当前面临的问题，是如何将原始财报电话会议文字记录、文本生成模型（主流选择如 OpenAI ChatGPT-3.5）以及工具集（Python、LangChain、Chroma 等——并无特别复杂组件）三者“有机融合”，从而构建出一个能够真实模拟 CFO 行为与表达的 AI 系统。

# Thought Through Process for solutions

# 解决方案的思考过程

## Starting with openAI

## 从 OpenAI 开始

To begin with, I started with using ChatGPT 3.5 from open AI with [Langchain retrievalQA chain](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com#quickstart), which is a pretty standard approach for anyone building out an application like this. With that being said, the solution now looks like this:

首先，我使用了 OpenAI 的 ChatGPT 3.5，并结合 [LangChain 的 RetrievalQA 链](https://python.langchain.com/docs/use_cases/question_answering/?ref=blog.langchain.com#quickstart)，这是构建此类应用时一种相当标准的做法。话虽如此，当前解决方案的架构如下所示：

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_003.png)

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_003.png)

Not surprisingly, ChatGPT 3.5 works quite well for questions simply enough, eg. `What's covered in this earning call?`  . The open source tools works like a charm in terms of prototyping. It doesn’t take long to build up the first version of the product. Yet for questions bit more complicated, ChatGPT gives up very quick. You may check it out [here](https://smith.langchain.com/projects/p/4341d1f7-ac1b-416e-9400-20f89f393a5b/r/f721812f-f541-46c2-b80c-6b8ca51fa4ec?ref=blog.langchain.com) .

不出所料，ChatGPT 3.5 对于较为简单的问题表现相当出色，例如：“本次财报电话会议涵盖了哪些内容？”开源工具在原型开发阶段表现得极为出色，仅需很短时间即可构建出产品的首个版本。然而，一旦问题稍显复杂，ChatGPT 往往迅速“放弃回答”。您可在此处查看相关示例：[链接](https://smith.langchain.com/projects/p/4341d1f7-ac1b-416e-9400-20f89f393a5b/r/f721812f-f541-46c2-b80c-6b8ca51fa4ec?ref=blog.langchain.com)。

The full questions list with response from ChatGPT 3.5 is here

ChatGPT 3.5 回答的全部问题列表如下：

- [What's covered in this earning call?](https://smith.langchain.com/public/dbac4723-5a7d-4c63-914d-90f651c2ad22/r?ref=blog.langchain.com)  
- [What is the potential for further growth in the number of Apple devices per iPhone user?](https://smith.langchain.com/public/ecc37b09-8528-49be-b694-5f4d73258c80/r?ref=blog.langchain.com)  
- [What is the Apple’s strategy over AI?](https://smith.langchain.com/public/e3d0b2da-b1cc-4e38-963c-d4607dc7278f/r?ref=blog.langchain.com)  
- [What are the feedbacks on Apply Pay Later?](https://smith.langchain.com/public/a62fb0ac-91f4-4581-91f5-5266a5871d3a/r?ref=blog.langchain.com)  

- [本次财报电话会议涵盖了哪些内容？](https://smith.langchain.com/public/dbac4723-5a7d-4c63-914d-90f651c2ad22/r?ref=blog.langchain.com)  
- [每位 iPhone 用户所拥有的苹果设备数量，未来还有多大增长潜力？](https://smith.langchain.com/public/ecc37b09-8528-49be-b694-5f4d73258c80/r?ref=blog.langchain.com)  
- [苹果公司在人工智能领域的战略是什么？](https://smith.langchain.com/public/e3d0b2da-b1cc-4e38-963c-d4607dc7278f/r?ref=blog.langchain.com)  
- [用户对“Apple Pay Later”（苹果先买后付）功能的反馈如何？](https://smith.langchain.com/public/a62fb0ac-91f4-4581-91f5-5266a5871d3a/r?ref=blog.langchain.com)  

## Then I tried vanilla vicuna

## 接着我尝试了原生 Vicuna 模型

Overheard from friends, and as an Open Source Developer ( worked on Jupyter Lab, yes, the notebook, but beyond notebook! 😅), I decided to try out Vicuna, an open-source chatbot trained by fine-tuning LLaMA on user-shared conversations collected from ShareGPT. With that being said, the solution now looks like this:

从朋友那里听说后，加之我本人也是一名开源开发者（曾参与 JupyterLab 开发——没错，就是那个 Notebook，但不止于此！😅），我决定尝试 Vicuna：一个基于 ShareGPT 用户共享对话数据、对 LLaMA 进行微调训练而成的开源聊天机器人。话虽如此，当前解决方案的架构如下所示：

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_004.png)

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_004.png)

The tricky part here is the first version of the product is built upon Langchain which is initially built upon OpenAI’s API. So as a lot of other prompt engineering frameworks. In this case, switching to another model is a lot of work in terms of compatibility issues. Eg. the other model may doesn’t have the same embedding api endpoint. or the tiktoken lib doesn’t support certain models.

此处的难点在于，该产品的初版是基于 LangChain 构建的，而 LangChain 本身最初又是基于 OpenAI 的 API 开发的——这与许多其他提示工程框架的情况类似。因此，在这种架构下，切换至其他大语言模型将面临大量兼容性问题。例如，目标模型可能不提供相同的嵌入（embedding）API 端点；又或者 `tiktoken` 库并不支持某些模型。

Due to this problem, engineering team at [Lepton.AI](https://www.lepton.ai/?ref=blog.langchain.com) found a way to make the model compatible with the original OpenAI’s API endpoint, makes switching models for a LLM application much easier. The model service enable users to switch the model by simply altering the environment from

正因如此，[Lepton.AI](https://www.lepton.ai/?ref=blog.langchain.com) 的工程团队找到了一种方法，使各类模型能够兼容原始的 OpenAI API 接口，从而大幅简化大语言模型应用中的模型切换流程。该模型服务允许用户仅通过修改环境变量即可完成模型切换，即从：

```bash
OPENAI_API_BASE=https://api.openai.com/v1
OPENAI_API_KEY=YOUR_OPEN_API_KEY
```

to

切换为：

```bash
OPENAI_API_BASE=YOUR_DEPLOYMENT_URL
OPENAI_API_KEY=YOUR_LEPTON_AI_API_KEY
```

The result turns to be pretty solid at first glance, yet evaluation on the outputs is quite challenging. This is where [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) comes in handy. It allows me to add four lines of code to alter the environment variables, and it could handle everything for me from there.

初步看来，这一方案效果相当稳健；但要对模型输出进行系统性评估却颇具挑战。此时，[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 就显得尤为得力：我只需添加四行代码来调整环境变量，后续所有评估、追踪与调试工作均可由它自动完成。

## Turns out the Fine Tuned model is even better

## 事实证明，微调后的模型表现更优

Even though the vanilla model works by not giving up so fast, it still doesn’t really talk quite like a CFO. That is saying the way it talks does not give me the feeling of actually attending an earning call surrounded by talents from top financial institutions.

尽管基础模型（vanilla model）已具备一定韧性（不会轻易“放弃”回答），但它仍远未达到一位首席财务官（CFO）应有的表达风格——换言之，其语言风格无法让我产生身临其境之感：仿佛正置身于一场财报电话会议现场，周围坐满了来自顶尖金融机构的专业人才。

Hence inspired by Vicuna, the fine-tuned model of llama, I decided to fine-tune a model that utilize data from the earning call question & answer section. By collecting data from the earning transcripts, I managed to sample out quite a few earning calls. Then using TUNA, a model augmentation service that augment both the data and model, to create a model that’s more focused on earning call context. With that being said, the solution now looks like this:

受 Llama 微调模型 Vicuna 的启发，我决定构建一个专门针对财报电话会议问答环节（Q&A section）数据进行微调的大语言模型。我从公开财报文字实录（earnings transcripts）中收集并采样了多场典型财报电话会议数据；随后借助 TUNA——一款可同时增强数据与模型能力的模型增强服务——训练出一个更聚焦于财报会议语境的专用模型。至此，整套解决方案演进如下：

![](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_005.png)

Here are few query result from the question list

以下是问题列表中的一些查询结果：

- [What's covered in this earning call?](https://smith.langchain.com/public/80e7f6b6-8ea7-41b9-b875-55781b1c1df8/r?ref=blog.langchain.com)  
- [本次财报电话会议涵盖哪些内容？](https://smith.langchain.com/public/80e7f6b6-8ea7-41b9-b875-55781b1c1df8/r?ref=blog.langchain.com)

- [What is the potential for further growth in the number of Apple devices per iPhone user?](https://smith.langchain.com/public/7f14895a-d6e5-45b9-98bf-bc128954de45/r?ref=blog.langchain.com)  
- [每位 iPhone 用户所拥有的苹果设备数量，未来还有多大增长潜力？](https://smith.langchain.com/public/7f14895a-d6e5-45b9-98bf-bc128954de45/r?ref=blog.langchain.com)

- [What is the Apple’s strategy over AI?](https://smith.langchain.com/public/a2a6d24b-fd46-46f4-9850-b414f0b716f0/r?ref=blog.langchain.com)  
- [苹果公司在人工智能领域的战略是什么？](https://smith.langchain.com/public/a2a6d24b-fd46-46f4-9850-b414f0b716f0/r?ref=blog.langchain.com)

- [What are the feedbacks on Apply Pay Later?](https://smith.langchain.com/public/34555f2f-79a6-4532-bb0e-09727100c2a8/r?ref=blog.langchain.com)  
- [用户对“Apple Pay Later”（苹果先买后付）的反馈如何？](https://smith.langchain.com/public/34555f2f-79a6-4532-bb0e-09727100c2a8/r?ref=blog.langchain.com)

Again, the only thing changed in my code is the `OPENAI_API_BASE` and everything works from there. By leveraging LangSmith, I get to compare the result more efficiently and share them to people who are interested in looking at it as demonstrated in this post multiple times.

再次说明，我在代码中唯一改动的地方只有 `OPENAI_API_BASE`，其余一切均正常运行。借助 LangSmith，我能更高效地对比不同结果，并如本文多次演示的那样，便捷地将结果分享给对此感兴趣的同事或同行。

# Conclusion

# 结论

In conclusion, the integration of data and LLM techniques, such as data augmentation and fine-tuning, stands as a pivotal milestone in the development of AI applications. By combining vast and diverse datasets with the power of LLM, we unlock unprecedented potential, enabling AI systems to generate more accurate, context-aware, and coherent outputs. The synergy between data and LLM not only enhances the overall performance of AI applications but also opens up new avenues for innovation and discovery.

总而言之，数据与大语言模型（LLM）技术（例如数据增强与微调）的深度融合，已成为 AI 应用开发历程中的一个关键里程碑。通过将海量、多样的数据集与 LLM 的强大能力相结合，我们释放出前所未有的潜力，使 AI 系统能够生成更准确、更具上下文感知能力且更连贯的输出。数据与 LLM 的协同效应，不仅显著提升了 AI 应用的整体性能，也开辟了创新与探索的新路径。

As we continue to refine and expand our understanding of this dynamic relationship, we embark upon a journey where the fusion of data-driven insights and advanced language models redefines what is possible, propelling us into an era of AI excellence and transforming the way we interact with technology. The future awaits, as we stride confidently toward a horizon where AI transcends expectations and becomes an indispensable asset in our quest for progress.

随着我们持续深化并拓展对这一动态关系的认知，我们正踏上一段全新旅程：数据驱动的洞察力与先进语言模型的融合，正在重新定义“可能性”的边界，引领我们迈入 AI 卓越发展的新时代，并彻底变革人类与技术互动的方式。未来已来——我们正满怀信心地迈向一个 AI 超越预期、并成为推动人类进步不可或缺支柱的新纪元。

And for the tools mentioned above, both LangSmith and LeptonAI are still under closed beta, but feel free to sign up on the waitlist and give it a try. Feel free to shoot me an email at [uz@lepton.ai](mailto:uz@lepton.ai), I would love to hear from you on your thoughts!

此外，上文提到的两款工具——LangSmith 与 LeptonAI——目前仍处于封闭测试（closed beta）阶段，但欢迎前往等候名单（waitlist）注册并抢先体验。也欢迎随时发送邮件至 [uz@lepton.ai](mailto:uz@lepton.ai)，我很期待听到您对本文或相关技术的想法与反馈！

# Related Links

# 相关链接

- [LangSmith - A unified platform for debugging, testing, evaluating, and monitoring your LLM applications](https://smith.langchain.com/?ref=blog.langchain.com)  
- [LangSmith —— 专为 LLM 应用打造的一体化平台，支持调试、测试、评估与监控](https://smith.langchain.com/?ref=blog.langchain.com)

- [Lepton.AI - Build AI The Simple Way](http://lepton.ai/?ref=blog.langchain.com)  
- [Lepton.AI —— 以最简单的方式构建 AI](http://lepton.ai/?ref=blog.langchain.com)

- [The code for this post - Feel free to use it](https://github.com/bobmayuze/Earning-Sage/tree/main?ref=blog.langchain.com)  
- [本文配套代码 —— 欢迎自由使用](https://github.com/bobmayuze/Earning-Sage/tree/main?ref=blog.langchain.com)

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_006.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_006.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_007.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_007.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_008.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_008.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_009.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/lepton-x-langchain-earning-sage-how-to-transform-ai-into-a-savvy-cfo/img_009.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**使用 Genoss 统一 AI 接口，由 LangChain 提供支持**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
