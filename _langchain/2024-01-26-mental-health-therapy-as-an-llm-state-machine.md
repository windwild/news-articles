---
render_with_liquid: false
title: "Mental Health Therapy as an LLM State Machine"
source: "LangChain Blog"
url: "https://blog.langchain.com/mental-health-therapy-as-an-llm-state-machine/"
date: "2024-01-26"
scraped_at: "2026-03-03T08:17:24.762996744+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: this blog post was written by Chris from** [**Sonia Health**](https://www.linkedin.com/company/sonia-health/?ref=blog.langchain.com) **. We're particularly excited to highlight this for a few reasons. First, this is a use case with a really positive societal benefit. Second, the implementation mirrors how we are thinking about more complex workflows internally — as state machines! Check out** [**LangGraph**](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com) **(which we just released) as an easy way to build these types of applications.**

**编者按：本文由** [**Sonia Health**](https://www.linkedin.com/company/sonia-health/?ref=blog.langchain.com) **的 Chris 撰写。我们特别兴奋地推荐这篇博文，原因有二：其一，该用例具有显著的积极社会价值；其二，其实现方式与我们内部对更复杂工作流的构想高度一致——即以状态机（state machines）建模！欢迎试用我们刚刚发布的** [**LangGraph**](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com) **，它为构建此类应用提供了便捷路径。**

## **Mental Health Crisis**

## **心理健康危机**

[20% of Americans](https://www.nimh.nih.gov/health/statistics/mental-illness?ref=blog.langchain.com) suffer with their mental health each year. While the demand for psychotherapy is steadily rising, supply is severely limited. Wait lists for therapy are often several months and once you finally get an appointment, it costs upwards of $100 per session. This is more than half of what the average American [earns per day](https://www.talent.com/salary?job=daily&ref=blog.langchain.com).

据美国国家心理健康研究所（NIMH）统计，**每年约20%的美国人** [**遭受心理健康问题困扰**](https://www.nimh.nih.gov/health/statistics/mental-illness?ref=blog.langchain.com)。尽管心理治疗需求持续攀升，但专业供给却严重不足：就诊等候名单动辄长达数月；而一旦终于预约成功，单次咨询费用往往超过100美元——这已超过普通美国人**日均收入的一半** [**（数据来源）**](https://www.talent.com/salary?job=daily&ref=blog.langchain.com)。

Today, most people who are suffering from mental health challenges can’t access any support. We believe that AI can help solve the mental health crises and are going to explain in this post how we are approaching it by developing Sonia, an AI therapist.

如今，绝大多数正经历心理健康挑战的人根本无法获得任何支持。我们坚信，人工智能有望助力缓解这场心理健康危机；本文将详细介绍我们如何通过开发 Sonia——一位AI治疗师——来践行这一理念。

## **AI Therapy**

## **AI 心理治疗**

Going back in time, the concept of AI therapy first came up in 1964 when MIT professor Joseph Weizenbaum developed the [computer program ELIZA](https://en.wikipedia.org/wiki/ELIZA?ref=blog.langchain.com). Modeled after a [Rogerian psychotherapist](https://en.wikipedia.org/wiki/Person-centered_therapy?ref=blog.langchain.com), the chatbot was originally built as an antic to show just how superficial human-to-computer interaction was. To his surprise and confusion, people started spending hours talking to ELIZA, valuing the non-judgmental responses that offered a safe space for expressing their feelings.

回溯历史，AI心理治疗的概念最早可追溯至1964年：麻省理工学院（MIT）教授约瑟夫·魏泽鲍姆（Joseph Weizenbaum）开发了名为 [**ELIZA 的计算机程序**](https://en.wikipedia.org/wiki/ELIZA?ref=blog.langchain.com)。该聊天机器人以 [**罗杰斯式心理治疗师**](https://en.wikipedia.org/wiki/Person-centered_therapy?ref=blog.langchain.com) 为模型，最初仅作为一项“讽刺实验”，旨在揭示人机交互何其肤浅。然而令他惊讶甚至困惑的是，人们竟开始花数小时与ELIZA倾谈，并珍视其不带评判的回应——这种回应为表达情绪提供了一个安全空间。

Fast forward almost half a century, the rise of Large Language Models (LLMs) and the release of ChatGPT have brought the spotlight back to AI therapy. In the past 15 months since its release, many have [reported turning to ChatGPT](https://www.reddit.com/r/ChatGPT/comments/15ractu/can_i_use_chatgpt_as_a_therapist/?ref=blog.langchain.com) to talk about their emotions and struggles.

时光快进近半个世纪，大语言模型（LLMs）的兴起与ChatGPT的发布，再度将AI心理治疗推至聚光灯下。自ChatGPT发布以来的15个月内，已有大量用户 [**报告称自己转向ChatGPT倾诉情绪与困境**](https://www.reddit.com/r/ChatGPT/comments/15ractu/can_i_use_chatgpt_as_a_therapist/?ref=blog.langchain.com)。

ChatGPT represents a promising step towards making mental health care more accessible through the use of AI. However, the problem with a vanilla model like ChatGPT is the lack of domain-specific conversation structure. A single system prompt isn’t able to guide through an entire 30–60 minute conversation where the client and therapist need to continuously dig deeper to get to the core of a problem. While these models were pre-trained on countless psychology textbooks (leading to therapeutical knowledge), transcripts of therapy sessions are barely available publicly (leading to a lack of therapeutical behavior). ChatGPT is an [RLHF fine-tuned](https://en.wikipedia.org/wiki/Reinforcement_learning_from_human_feedback?ref=blog.langchain.com) model that receives instructions and provides solutions, which is very different from how a therapist should engage in a therapy session.

ChatGPT代表了借助AI提升心理健康服务可及性的重要一步。然而，像ChatGPT这样“开箱即用”的通用模型存在明显短板：缺乏面向心理治疗领域的对话结构设计。单一系统提示（system prompt）无法支撑一场持续30–60分钟的完整咨询——在此过程中，来访者与治疗师需层层深入，方能触及问题核心。尽管这些模型在海量心理学教科书中完成预训练（因而具备治疗知识），但公开可用的真实治疗对话记录却极为稀缺（导致缺乏治疗行为范式）。此外，ChatGPT是一种经 [**人类反馈强化学习（RLHF）微调**](https://en.wikipedia.org/wiki/Reinforcement_learning_from_human_feedback?ref=blog.langchain.com) 的模型，其运作模式是接收指令并输出解决方案，而这与真实治疗师在咨询中应有的互动方式截然不同。

## **Cognitive Behavioral Therapy**

## **认知行为疗法（CBT）**

Before we get started on the technical details, we’ll provide a quick introduction to cognitive behavioral therapy, Sonia’s main therapeutical approach. CBT is one of the most widespread forms of psychological treatment, [proven to be effective](https://www.apa.org/ptsd-guideline/patients-and-families/cognitive-behavioral?ref=blog.langchain.com) for numerous mental health problems including anxiety and depression. The approach is centered around the [cognitive model](https://beckinstitute.org/about/understanding-cbt/?ref=blog.langchain.com#:~:text=The%20cognitive%20model%20describes%20how,and%20treat%20their%20clients'%20difficulties.) of CBT, which describes the interconnectedness of situations, thoughts, behaviors, and emotions. The model states that it isn’t the situation itself that impacts how we feel or react, but rather our interpretations and thoughts about the situation. CBT aims to help clients become aware of, challenge, and reframe these negative interpretations and thoughts.

在展开技术细节之前，我们先简要介绍Sonia所采用的核心治疗取向——**认知行为疗法（CBT）**。CBT是目前应用最广泛的心理治疗方法之一，已被大量研究 [**证实对焦虑、抑郁等多种心理健康问题具有显著疗效**](https://www.apa.org/ptsd-guideline/patients-and-families/cognitive-behavioral?ref=blog.langchain.com)。该疗法以CBT的 [**认知模型**](https://beckinstitute.org/about/understanding-cbt/?ref=blog.langchain.com#:~:text=The%20cognitive%20model%20describes%20how,and%20treat%20their%20clients'%20difficulties.) 为核心，该模型阐释了**情境、想法、行为与情绪之间相互交织的关系**。其核心观点是：真正影响我们感受与反应的，并非事件本身，而是我们对事件的解读与想法。CBT的目标，正是帮助来访者觉察、质疑并重构这些消极的解读与思维模式。

## **LLM State Machine**

## **LLM 状态机**

It is a widespread belief that therapy is more of an art than science. Quite the opposite, CBT is a very structured therapeutical approach. A session as described by its founding father [Aaron Beck consists of 8 well-defined stages](https://en.wikipedia.org/wiki/Aaron_Beck?ref=blog.langchain.com), that get traversed by the therapist. Each stage of the session, such as “mood check”, “agenda setting”, or “feedback”, has a very specific purpose and objective. Looking at it from a computer science perspective, this structure makes it perfectly suited to be modeled as a [finite-state machine](https://en.wikipedia.org/wiki/Finite-state_machine?ref=blog.langchain.com#:~:text=A%20finite%2Dstate%20machine%20(FSM,states%20at%20any%20given%20time.), which is exactly what we did.

人们普遍认为，心理治疗更像一门艺术而非科学。而恰恰相反，认知行为疗法（CBT）是一种高度结构化的治疗方法。正如其创始人[Aaron Beck 所描述](https://en.wikipedia.org/wiki/Aaron_Beck?ref=blog.langchain.com)，一次标准的 CBT 治疗会谈包含 8 个定义明确的阶段，由治疗师依次引导完成。会谈中的每个阶段——例如“情绪检查”（mood check）、“议程设定”（agenda setting）或“反馈环节”（feedback）——都具有非常具体的目标与功能。从计算机科学视角来看，这种清晰、有序的结构天然适合建模为[有限状态机（FSM）](https://en.wikipedia.org/wiki/Finite-state_machine?ref=blog.langchain.com#:~:text=A%20finite%2Dstate%20machine%20(FSM,states%20at%20any%20given%20time.)，而这正是我们所采用的建模方式。

## **Architecture**

## **架构设计**

The main task of an AI (and human) therapist is to respond to their client. Every response requires new context and information, which is dependent on past interactions with the client, the stage of the ongoing session, the current topic that is being addressed, or the sentiment of the very last client message, just to name a few. So how can we make sure that our AI therapist has the right context at the right time?

AI 治疗师（以及人类治疗师）的核心任务是回应来访者。每一次回应都需要动态获取新的上下文与信息——这些信息取决于过往的互动记录、当前会谈所处的阶段、正在探讨的主题，或是来访者最新一条消息的情绪倾向，等等。那么，我们该如何确保 AI 治疗师在恰当的时刻拥有恰当的上下文？

Many [retrieval-augmented generation](https://blogs.nvidia.com/blog/what-is-retrieval-augmented-generation/?ref=blog.langchain.com) (RAG) solutions would simply embed a corpus of psychological knowledge and semantically retrieve the related data. However, fully relying on this would not sufficiently exploit the well-defined structure of CBT therapy and have a suboptimal signal-to-noise ratio.

目前许多[检索增强生成（RAG）](https://blogs.nvidia.com/blog/what-is-retrieval-augmented-generation/?ref=blog.langchain.com)方案，往往只是将心理学知识库进行向量化嵌入，并基于语义相似度检索相关内容。然而，若完全依赖此类方法，则无法充分利用 CBT 本身高度结构化的特点，且容易导致信噪比欠佳。

On the other extreme, hard-coding a single prompt for each stage does not allow enough flexibility, which is crucial for personalized and effective treatment. In CBT, each stage can be broken down into several more fine-grained substages, which of course shouldn’t all be treated equally.

另一极端做法——为每个阶段硬编码单一提示词（prompt）——则缺乏足够的灵活性，而这对于实现个性化、高疗效的干预至关重要。事实上，在 CBT 中，每个主阶段还可进一步细分为多个子阶段，而这些子阶段显然不应被同等对待。

Aiming to find a middle ground, we built a deep decision tree of structured retrieval and prompting for each stage using the LangChain framework. LangChain’s customizable memory modules and agent constructors accelerated our development significantly. Once it was all set up, monitoring and testing on LangSmith saved us many hours while iterating on the prompts.

为寻求平衡点，我们基于 LangChain 框架，为每个阶段构建了一棵深度决策树，融合了结构化检索与分层提示工程。LangChain 提供的可定制记忆模块（memory modules）与智能体构造器（agent constructors）极大加速了我们的开发进程。待整体架构搭建完毕后，借助 LangSmith 进行监控与提示词迭代测试，又为我们节省了大量调试时间。

## **Transitions**

## **状态迁移**

After we built the [agents](https://promptengineering.org/what-are-large-language-model-llm-agents/?ref=blog.langchain.com) for each stage, we needed to think about how to transition between the 8 distinct stages of a CBT therapy session. The tricky part here is that this task is highly domain-specific to therapy. It’s neither a fully syntactic, nor a fully semantic problem.

在为每个阶段构建好对应的[智能体（agents）](https://promptengineering.org/what-are-large-language-model-llm-agents/?ref=blog.langchain.com)之后，我们还需解决关键问题：如何在 CBT 会谈的 8 个不同阶段之间实现合理迁移？这一任务的难点在于其高度依赖临床治疗领域知识——它既非纯粹的语法问题，也非纯粹的语义问题。

On the syntactic side, rules such as “there should be exactly 8 messages in stage X” or “stage X should last at most 5 minutes” could easily be implemented. But what if the client asks a follow-up question in the 8th message or has to take a short break for a few minutes? Point being, you can’t fully rely on these types of rules (but you also can’t completely ignore them).

从语法层面看，诸如“X 阶段必须恰好包含 8 条消息”或“X 阶段持续时间不得超过 5 分钟”等规则易于实现。但倘若来访者在第 8 条消息中提出一个追问，或因故需要短暂中断几分钟呢？关键在于：这类规则不能被完全依赖，但也绝不可被彻底忽视。

On the semantic side, one potential approach is to run repeated LLM calls to determine whether all stage objectives have been met. The output can then either be used to explicitly switch the context of the agent, or more implicitly by integrating the output into the prompt that generates the response to the client.

在语义层面，一种潜在的方法是反复调用大语言模型（LLM），以判断所有阶段目标是否均已达成。随后，该输出可被用于显式地切换智能体的上下文；也可更隐式地将其整合进生成客户端响应所用的提示词中。

No single one of these approaches is sufficient, but collectively they perform pretty well. Not surprisingly, this combination is also being implemented by a human therapist in practice. They need to stay within certain set boundaries such as session duration, but make sure to smoothly finish covering important topics.

上述任一方法单独使用均不充分，但组合起来效果相当出色。毫不意外的是，人类治疗师在实际工作中也正采用这种综合策略：他们需严格遵守既定边界（例如单次会谈时长），同时确保自然、流畅地覆盖所有关键议题。

## **Asynchronous Emergency Check**

## **异步紧急风险筛查**

As recently described by [Bill Gates](https://www.gatesnotes.com/AI-agents?ref=blog.langchain.com), an AI mental health agent can and should do much more than just generating responses. One example of such an additional task is emergency detection. If a client is in immediate danger of hurting themselves or others, they shouldn’t be talking to a machine - at least not yet in early 2024. We have implemented several asynchronous checks that evaluate the risk contained in every message that the client types or speaks. Above a certain threshold, Sonia immediately redirects clients to national hotlines.

正如比尔·盖茨（[Bill Gates](https://www.gatesnotes.com/AI-agents?ref=blog.langchain.com)）近期所述，AI 心理健康助手不仅能生成回复，更应承担远超此范围的职责。其中一项典型附加任务即为紧急风险识别：若来访者正面临立即伤害自身或他人的危险，则此时不应继续与机器对话——至少在 2024 年初的现阶段尚不适宜。我们已部署多项异步筛查机制，对来访者输入或说出的每条消息进行实时风险评估；一旦风险评分超过预设阈值，Sonia 将立即将来访者转接至国家级心理援助热线。

Another example are therapeutical worksheets. If a client struggles to articulate their thoughts, values or goals, a therapist has an inventory of exercises and worksheets to help. Implemented quite similar to a [tool as described by LangChain](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com), our AI therapist Sonia identifies the right time to interrupt the session and present an interactive worksheet to the client in the frontend. Those results then get analyzed and leveraged to continue the session.

另一类应用是治疗性工作表（therapeutic worksheets）。当来访者难以清晰表达其想法、价值观或目标时，治疗师通常会借助一系列练习与工作表予以支持。我们的 AI 治疗师 Sonia 采用与 [LangChain 所述“工具”（Tool）机制](https://python.langchain.com/docs/modules/agents/tools/?ref=blog.langchain.com)高度相似的方式实现该功能：它能精准识别介入时机，在前端会话界面中适时中断当前对话，并向来访者呈现交互式工作表；随后，系统将自动分析填写结果，并据此推动后续会谈进程。

## Conclusion

## 结语

AI has the potential to make mental health care accessible to anyone, anywhere, and anytime at 1% of today’s costs. We are excited to build something that has the potential to positively impact the lives of millions around the world and are grateful for partners like LangChain that support and accelerate us in this process.

人工智能有望以当前成本的 1%，让心理健康服务真正实现“人人可及、处处可达、时时可得”。我们满怀热忱地投身于这项事业——它具备切实改善全球数百万人生活的潜力；同时，我们也由衷感谢 LangChain 等合作伙伴给予我们的坚定支持与高效助力。

[Sonia: AI Therapy](https://apps.apple.com/us/app/sonia-ai-therapy/id6472111765?ref=blog.langchain.com) is live on the App Store.

[Sonia：AI 心理治疗](https://apps.apple.com/us/app/sonia-ai-therapy/id6472111765?ref=blog.langchain.com) 已正式上线苹果 App Store。

## Other State Machines & LangGraph

## 其他状态机与 LangGraph

Modeling CBT as a state machine allowed us to find the right balance between structure and flexibility. While the implementation details are quite domain-specific, we believe that the architecture and mental model can be used for a broad range of conversational AI applications (customer support, candidate screening, tutoring, etc.). LangChain just recently released [LangGraph](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com), a module to create stateful cyclical graphs on top of LangChain. One of the main use cases is the concept of [multi-agent workflows](https://blog.langchain.com/langgraph-multi-agent-workflows/), defined as ‘independent actors powered by language models connected in a specific way’. Put simply, it is the optimal framework to build an LLM state machine. We wish this would have existed when we started building back in October, and highly encourage everyone looking into a state-machine-like application to check it out. Please let us know if you do, we are happy to chat and share learnings!

将认知行为疗法（CBT）建模为状态机，使我们得以在结构化与灵活性之间找到恰当平衡。尽管具体实现细节高度依赖领域特性，但我们相信，这一架构设计与思维范式可广泛适用于各类对话式 AI 应用场景（如客户服务、候选人筛选、个性化辅导等）。LangChain 近期正式发布 [LangGraph](https://python.langchain.com/docs/langgraph?ref=blog.langchain.com)——一个构建于 LangChain 之上的、支持有状态循环图（stateful cyclical graphs）的模块。其核心应用场景之一即为 [多智能体工作流（multi-agent workflows）](https://blog.langchain.com/langgraph-multi-agent-workflows/)，定义为“由大语言模型驱动、按特定方式相互连接的独立智能体”。简而言之，LangGraph 是构建 LLM 状态机的理想框架。倘若它早在我们去年十月启动开发时便已问世，那将极大提升我们的研发效率；因此，我们诚挚建议所有正在探索状态机式应用的开发者务必试用 LangGraph。若您已开始使用，欢迎随时与我们联系——我们非常乐意交流心得、分享经验！

* * *

Thanks a lot for reading - reach out to [contact@soniahealth.com](mailto:contact@soniahealth.com) with any questions or feedback.

非常感谢您的阅读！如有任何问题或反馈，请联系 [contact@soniahealth.com](mailto:contact@soniahealth.com)。