---
title: "Chat Models"
source: "LangChain Blog"
url: "https://blog.langchain.com/chat-models/"
date: "2023-08-18"
scraped_at: "2026-03-03T08:57:59.313768895+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

Last week OpenAI released a [ChatGPT endpoint](https://openai.com/blog/introducing-chatgpt-and-whisper-apis?ref=blog.langchain.com). It came marketed with several big improvements, most notably being 10x cheaper and a lot faster. But it also came with a completely new API endpoint. We were able to [quickly write a wrapper](https://twitter.com/hwchase17/status/1631023126472724480?s=20&ref=blog.langchain.com) for this endpoint to let users use it like any normal LLM in LangChain, but this did not fully take advantage of the new message-based API. In this blog post we go over the new API schema and how we are adapting LangChain to accommodate not only ChatGPT but also all future chat-based models.

上周，OpenAI 发布了一个 [ChatGPT 接口](https://openai.com/blog/introducing-chatgpt-and-whisper-apis?ref=blog.langchain.com)。官方宣传中强调了多项重大改进，其中最引人注目的是价格降低为原先的十分之一，且响应速度大幅提升。但与此同时，该接口也采用了全新的 API 端点。我们已[迅速为其编写了一个封装器](https://twitter.com/hwchase17/status/1631023126472724480?s=20&ref=blog.langchain.com)，使用户能像调用任何标准大语言模型（LLM）一样在 LangChain 中使用它；然而，这种封装并未充分释放新式“基于消息”的 API 所带来的全部潜力。本文将详细介绍这一新 API 的数据结构，并阐述 LangChain 如何进行适配——不仅支持 ChatGPT，也将为所有未来的对话式模型提供通用支持。

Key Links:

关键链接：

- [Python 文档](https://python.langchain.com/docs/modules/model_io/models/chat/?ref=blog.langchain.com)
- [JS/TS 文档](https://hwchase17.github.io/langchainjs/docs/modules/chat_models/overview?ref=blog.langchain.com)

## Why new abstractions?

## 为何需要新的抽象层？

So OpenAI released a new API - what’s the big deal? Why are new abstractions even needed?

那么，OpenAI 发布了一个新 API——这究竟有何重大意义？为何我们甚至需要构建新的抽象层？

Although the ChatGPT endpoint uses a language model under the hood, the API is quite different from the existing GPT-3 endpoint. This is a bit of a simplification, but the existing GPT-3 endpoint has an interface of:

尽管 ChatGPT 接口底层仍依赖于一个语言模型，但其 API 设计与现有的 GPT-3 接口存在显著差异。虽略有简化，但现有 GPT-3 接口的交互模式为：

- Input: text  
- Output: text  

- 输入：文本  
- 输出：文本  

The new ChatGPT endpoint has an interface of:

而新的 ChatGPT 接口则采用如下交互模式：

- Input: List of chat messages  
- Output: chat message  

- 输入：聊天消息列表  
- 输出：一条聊天消息  

This new interface means that some of our abstractions about the inputs/outputs to a language model are no longer correct. For example, the prompting strategies we had previously built all assumed that the output of the PromptTemplate was a string. However, now for chat models, the input needs to be a list of messages. Since prompting is at the core of a lot of LangChain utilities and functionalities, this is a change that cuts pretty deep.

这一全新接口意味着，我们此前关于语言模型输入/输出的一些抽象假设已不再成立。例如，我们先前设计的所有提示工程（prompting）策略均默认 PromptTemplate 的输出为字符串类型；但如今，对于对话式模型而言，输入必须是一组消息（message）构成的列表。由于提示工程是 LangChain 大量工具与核心功能的基础，这一变化影响深远，触及框架设计的根本层面。

## Why chat models?

## 为何需要聊天模型？

Okay, so there’s a new type of model. Why are we rushing to support it? Is it really so different from the existing API that it deserves new abstractions?

好的，现在出现了一种新型模型。我们为何要急于支持它？它真的与现有 API 差异如此之大，以至于值得引入全新的抽象层吗？

To answer that, it’s worth thinking about why OpenAI chose to release a model in this format at all. This part is all speculation. The main difference between this API and the previous GPT-3 API is that there is now more structure to user input, coming in the form of different types of messages. To be specific, the ChatGPT API allows for differentiation between “user”, “assistant”, and “system” messages. This differentiation could allow for the model to treat different types of messages differently, which could in theory improve the safety of applications built on top of these models. For example, a commonly known type of attack against LLM applications is [prompt injection attacks](https://simonwillison.net/2022/Sep/12/prompt-injection/?ref=blog.langchain.com), where the end user directs the application to do something it wasn’t intended to do. By adding this structure into the prompt now, in theory, end applications could put all their application instructions in the “system” messages, all end user input in the “user” messages, and then the model could be trained to always “obey” system messages, despite what the user messages may tell it. In practice, it seems like prompt injection attacks against chat models are [still a thing](https://medium.com/seeds-for-the-future/tricking-chatgpt-do-anything-now-prompt-injection-a0f65c307f6b?ref=blog.langchain.com), so this may not fully address those concerns. Only time will tell.

要回答这个问题，不妨思考一下：OpenAI 为何选择以这种形式发布模型？以下分析纯属推测。当前 API 与此前 GPT-3 API 的主要区别在于：用户输入如今具备更强的结构化特征，体现为多种类型的消息。具体而言，ChatGPT API 支持区分“user”（用户）、“assistant”（助手）和“system”（系统）三类消息。这种区分使模型能够对不同类型的消息采取差异化处理策略，理论上可提升构建于这些模型之上的应用的安全性。例如，针对大语言模型（LLM）应用的一种广为人知的攻击方式是 [提示注入攻击（prompt injection attacks）](https://simonwillison.net/2022/Sep/12/prompt-injection/?ref=blog.langchain.com)，即终端用户诱导应用执行其本不应执行的操作。通过在提示中引入上述结构，理论上终端应用可将全部应用指令置于“system”消息中，所有终端用户输入置于“user”消息中；而模型则可被训练为始终“服从”system 消息，无论 user 消息内容如何。然而在实践中，针对聊天模型的提示注入攻击 [依然存在](https://medium.com/seeds-for-the-future/tricking-chatgpt-do-anything-now-prompt-injection-a0f65c307f6b?ref=blog.langchain.com)，因此该机制未必能彻底解决相关安全问题。最终效果，仍有待时间检验。

The above example of “user” vs “assistant” vs “system” messages also speaks to why this format is different enough from the existing APIs to deserve its own abstractions.

上述关于“user”、“assistant”与“system”消息的示例，也正说明了：这种新格式与现有 API 已足够不同，因而值得拥有专属的抽象层。

There’s also more practical reasons. OpenAI has not yet released a “normal” LLM endpoint corresponding to the ChatGPT models, so if people want take full advantage of the speed/cost of these models they need to use the ChatGPT API. There are also rumors of other chat-style models coming to market soon ( [Claude from Anthropic](https://scale.com/blog/chatgpt-vs-claude?ref=blog.langchain.com), [Bard from Google](https://blog.google/technology/ai/bard-google-ai-search-updates/?ref=blog.langchain.com), early rumors of a [dialogue model from Cohere](https://thenewstack.io/cohere-vs-openai-in-the-enterprise-which-will-cios-choose/?ref=blog.langchain.com)). Although it is not yet known what format these models will be available in, it is not crazy to assume they will also have a chat based API option.

此外，还有更实际的考量。目前 OpenAI 尚未推出与 ChatGPT 模型对应的“标准”LLM 接口；因此，若用户希望充分享受这些模型在速度与成本方面的优势，就必须使用 ChatGPT API。同时，业内亦有传闻称，其他基于对话的模型也将很快面世（例如 [Anthropic 公司的 Claude](https://scale.com/blog/chatgpt-vs-claude?ref=blog.langchain.com)、[Google 公司的 Bard](https://blog.google/technology/ai/bard-google-ai-search-updates/?ref=blog.langchain.com)，以及早期传闻中 [Cohere 公司正在研发的对话模型](https://thenewstack.io/cohere-vs-openai-in-the-enterprise-which-will-cios-choose/?ref=blog.langchain.com)）。尽管这些模型最终将以何种接口形式发布尚不可知，但假设它们同样提供基于聊天的 API 选项，也并非毫无根据。

## What are our goals with the new abstractions?

## 新抽象层的设计目标是什么？

When designing these new abstractions, we had three primary goals in mind:

在设计这些新抽象层时，我们确立了三大核心目标：

**#1: Allow users to fully take advantage of the new chat model interface**

**目标 #1：让用户充分释放新聊天模型接口的全部潜力**

As mentioned above, the API for chat models is pretty different from existing LLM APIs. We want to let users take advantage of that.

如前所述，聊天模型的 API 与现有 LLM API 差异显著。我们希望帮助用户充分利用这一差异。

**#2: Allow for interoperability of prompts between “normal” LLM APIs and chat-based APIs**

**目标 #2：实现“标准”LLM API 与基于聊天的 API 之间提示词（prompt）的互操作性**

Although there are definitely differences in prompts for “normal” LLMs vs chat-based APIs, we wanted to make it as seamless as possible (within reason) to use the same prompt with either type of model. Practically, we prioritized this since most prompts in the code base are optimized for LLMs, and we did not want them to break terribly for chat-based models.

尽管“常规”大语言模型（LLM）与基于对话的 API 在提示词（prompt）设计上确实存在差异，但我们仍力求在合理范围内实现无缝切换——即同一套提示词可同时适配两类模型。实际上，我们之所以将此作为优先事项，是因为当前代码库中的大多数提示词均针对 LLM 进行了优化，而我们不希望它们在迁移到对话式模型时出现严重兼容性问题。

**#3: Make the abstractions generic beyond just OpenAI**

**#3：使抽象层具备通用性，不局限于 OpenAI**

We did not want any abstractions we put in place to be OpenAI-specific. As mentioned above, there are rumors of other chat-style models coming to market soon, and we wanted to make sure we could seamlessly support them.

我们不希望所构建的任何抽象层仅适用于 OpenAI。如前所述，业内已有传闻称其他对话式模型即将面世；为此，我们致力于确保新架构能无缝支持这些未来模型。

## What are these new abstractions?

## 这些新抽象层具体指什么？

While it may seem like we are introducing overly many abstractions into the codebase, they are all done with the goal of making anything added to codebase work as well as possible with these new models. One of the objectives of LangChain has always been to allow for interoperability between language model providers, and we hope this helps with that.

尽管看起来我们正在向代码库中引入大量抽象层，但其根本目标是确保未来添加到代码库中的所有组件都能尽可能好地适配这些新型模型。LangChain 的核心目标之一始终是实现不同语言模型提供商之间的互操作性；我们希望此次重构能切实推动这一目标的达成。

**Chat Messages**

**对话消息（Chat Messages）**

We are adding abstractions for the different types of chat messages.

我们正在为各类对话消息引入抽象层。

- `HumanMessage`: a message sent from the perspective of the human  
- `HumanMessage`：以人类用户视角发送的消息  

- `AIMessage`: a message sent from the perspective of the AI the human is interacting with  
- `AIMessage`：以人类正在交互的 AI 角色视角发送的消息  

- `SystemMessage`: a message setting the objectives the AI should follow  
- `SystemMessage`：用于设定 AI 应遵循的目标或行为准则的消息  

- `ChatMessage`: a message allowing for arbitrary setting of role  
- `ChatMessage`：支持任意指定角色（role）的通用消息类型  

**Chat Models**

**对话模型（Chat Models）**

We are also adding abstractions for chat models. The interface these types of models expect is very similar to the underlying ChatGPT API - it takes in a list of Chat Messages and returns a Chat Message.

我们同时也为对话模型引入抽象层。此类模型所期望的接口与底层 ChatGPT API 高度相似：接收一个 `ChatMessage` 列表作为输入，并返回单个 `ChatMessage` 作为输出。

**Chat Message Templates**

**聊天消息模板**

Since most applications don’t hard code messages to send but rather utilize the idea of “PromptTemplates” (take in user input, and return a prompt) we are adding corresponding chat message prompt templates.

由于大多数应用程序并不会将待发送的消息硬编码，而是采用“PromptTemplate”（接收用户输入并返回提示词）的理念，因此我们新增了对应的聊天消息提示模板。

- `HumanMessagePromptTemplate`: a class that exposes a method to take in user input and return a HumanMessage  
- `HumanMessagePromptTemplate`：一个类，提供一个方法，接收用户输入并返回一个 `HumanMessage`。

- `AIMessagePromptTemplate`: a class that exposes a method to take in user input and return an AIMessage  
- `AIMessagePromptTemplate`：一个类，提供一个方法，接收用户输入并返回一个 `AIMessage`。

- `SystemMessagePromptTemplate`: a class that exposes a method to take in user input and return a SystemMessage  
- `SystemMessagePromptTemplate`：一个类，提供一个方法，接收用户输入并返回一个 `SystemMessage`。

- `ChatMessagePromptTemplate`: a class that exposes a method to take in user input and return a ChatMessage  
- `ChatMessagePromptTemplate`：一个类，提供一个方法，接收用户输入并返回一个 `ChatMessage`。

**Prompt Values**

**提示值（Prompt Values）**

To allow for interoperability of prompts between “normal” LLM APIs and chat-based APIs, we are adding the concept of a `PromptValue`. This is a class which has the following methods:

为实现“常规”大语言模型（LLM）API 与基于聊天的 API 之间提示词的互操作性，我们引入了 `PromptValue` 的概念。这是一个具备以下方法的类：

- `to_string`: converts the PromptValue into a string, to be used in “normal” LLM APIs  
- `to_string`：将 `PromptValue` 转换为字符串，供“常规”LLM API 使用。

- `to_messages`: converts the PromptValue into a list of messages, to be used in chat-based APIs  
- `to_messages`：将 `PromptValue` 转换为消息列表，供基于聊天的 API 使用。

To go along with this, we also added methods to `BaseLLM` and `BaseChatModel` class that take in `PromptValue`s, convert them to `string`s or `ChatMessages` respectively, and then pass them to the model.

与此配套，我们还在 `BaseLLM` 和 `BaseChatModel` 类中新增了相应方法：接收 `PromptValue`，分别将其转换为字符串或 `ChatMessage`，再传入模型。

## How do these align with our objectives?

## 这些设计如何契合我们的目标？

Let’s make sure these abstractions align with the objectives we set out  

让我们确认这些抽象设计是否契合我们既定的目标。

**#1: Allow users to fully take advantage of the new chat model interface**  

**目标 #1：使用户能够充分使用全新的聊天模型接口**

We cover all of the functionality in the ChatGPT interface. There are some things we do not explicitly have abstractions for (like the `name` parameter), but those are still usable and we may work on adding better support in the future should they become more relevant.

我们覆盖了 ChatGPT 界面中的全部功能。某些功能（例如 `name` 参数）我们尚未显式地提供抽象封装，但这些功能依然可用；未来若其重要性提升，我们也会考虑增强支持。

**#2: Allow for interoperability of prompts between “normal” LLM APIs and chat-based APIs**

**#2：支持“常规”大语言模型（LLM）API 与基于对话的 API 之间的提示词（prompt）互操作性**

The `PromptValue` abstraction should allow for this. We have very simple methods for converting a string to messages (make it a single `HumanMessage`) and messages to a string (just cast the whole list to string). These (especially the messages-to-string method) can definitely be improved.

`PromptValue` 抽象应能实现这一点。我们提供了极为简洁的方法，用于在字符串与消息之间相互转换：将字符串转为消息（即封装为单个 `HumanMessage`），或将消息列表转为字符串（直接将整个消息列表强制转为字符串）。这些方法（尤其是“消息→字符串”方法）显然还有很大的优化空间。

**#3: Make the abstractions generic beyond just OpenAI**

**#3：使抽象设计具备通用性，不局限于 OpenAI**

We believe that by adding explicit concepts of Human/AI/System messages, rather than relying on dictionaries with `"role"` keys, we have set ourselves up for being model API agnostic. This way, if another model provider has different naming conventions (eg they call the AI `"AI"` rather than OpenAI’s `"assistant"`) we can easily map to these naming conventions in the model wrapper.

我们相信，通过明确定义 `Human` / `AI` / `System` 消息等概念，而非依赖含 `"role"` 键的字典结构，我们已为实现模型 API 无关性（model API agnosticism）打下了基础。这样一来，若其他模型服务商采用不同的角色命名规范（例如，将其 AI 角色命名为 `"AI"`，而非 OpenAI 的 `"assistant"`），我们便可在模型封装器（model wrapper）中轻松完成对应映射。

## Next steps

## 后续计划

Hopefully this has helped to clarify some of our thinking around what abstractions we introduced. We would LOVE feedback on these abstractions. It is always scary to have to formulate abstractions on a completely new concept in less than a week, so we really appreciate any suggestions and comments.

希望以上内容有助于厘清我们引入这些抽象设计背后的思考逻辑。我们非常期待您对这些抽象设计提出反馈！在不到一周的时间内，为一个全新概念构建抽象体系，始终令人忐忑；因此，我们由衷感谢您的任何建议与评论。

We will also work on continuing to add in more functionality around chat models. For example, better message-to-string support, better few-shot example support, and better support for chat memory.

我们还将持续为对话模型（chat models）扩充更多功能，例如：更完善的“消息→字符串”转换支持、更强大的少样本（few-shot）示例支持，以及更优的对话记忆（chat memory）支持。

We also have accrued a massive backlog of items due to this unexpected release, so thank you for your patience as we try to sift through that.

此次发布略显仓促，也由此积压了大量待办事项。感谢您的耐心等待，我们将尽快梳理并推进处理。

Finally, a big thank-you to the Anthropic team (and Mike Lambert in particular) for thinking through some of these abstractions and making sure they were general beyond the ChatGPT API. It's always hard to try to generalize abstractions when there's only a single instance to look at, so we greatly appreciated their wisdom.

最后，衷心感谢 Anthropic 团队（尤其感谢 Mike Lambert）深入参与部分抽象设计的探讨，并确保这些设计超越 ChatGPT API 的局限，具备更广泛的适用性。当仅有一个实例可供参考时，尝试对抽象进行泛化，向来颇具挑战；因此，我们由衷感佩他们的远见卓识。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/chat-models/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/chat-models/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/chat-models/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/chat-models/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/chat-models/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain《2024 年人工智能现状》报告](images/chat-models/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/chat-models/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/chat-models/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/chat-models/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/chat-models/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/chat-models/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/chat-models/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform 进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟
{% endraw %}
