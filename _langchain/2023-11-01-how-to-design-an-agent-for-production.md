---
title: "How to design an Agent for Production"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-design-an-agent-for-production/"
date: "2023-11-01"
scraped_at: "2026-03-03T08:30:18.744112782+00:00"
language: "en-zh"
translated: true
---
{% raw %}

**_Editor's Note:_ _This post is written by [_Dexter Storey_](https://twitter.com/StoreyDexter?ref=blog.langchain.com)_ _, [_Sarim Malik_](https://twitter.com/sarimrmalik?ref=blog.langchain.com)_ _, and [_Ted Spare_](https://twitter.com/TedSpare?ref=blog.langchain.com)_ _from the [_Rubric Labs_](https://blog.langchain.com/how-to-design-an-agent-for-production/rubriclabs.com)_ _team._**

**_编者按：_ _本文由 [_Dexter Storey_](https://twitter.com/StoreyDexter?ref=blog.langchain.com)_、[_Sarim Malik_](https://twitter.com/sarimrmalik?ref=blog.langchain.com)_ 与 [_Ted Spare_](https://twitter.com/TedSpare?ref=blog.langchain.com)_ 共同撰写，他们均来自 [_Rubric Labs_](https://blog.langchain.com/how-to-design-an-agent-for-production/rubriclabs.com)_ 团队。**

# Important Links

# 重要链接

- [GitHub repository](https://github.com/calcom/cal.com/tree/main/apps/ai?ref=blog.langchain.com)
- [GitHub 仓库](https://github.com/calcom/cal.com/tree/main/apps/ai?ref=blog.langchain.com)
- [OpenAI Functions Agent by LangChain](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)
- [LangChain 提供的 OpenAI Functions Agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)
- [Install Cal.ai](https://app.cal.com/apps/cal-ai?ref=blog.langchain.com)
- [安装 Cal.ai](https://app.cal.com/apps/cal-ai?ref=blog.langchain.com)

# Goal

# 目标

The purpose of this guide is to explain the underlying tech and logic used to deploy a scheduling agent, [Cal.ai](http://cal.ai/?ref=blog.langchain.com), in production using [LangChain](https://www.langchain.com/?ref=blog.langchain.com).

本指南旨在阐释如何利用 [LangChain](https://www.langchain.com/?ref=blog.langchain.com) 在生产环境中部署日程调度智能体 [Cal.ai](http://cal.ai/?ref=blog.langchain.com)，并详解其底层技术架构与核心逻辑。

# Context

# 背景

Recently, our team at [Rubric Labs](https://blog.langchain.com/how-to-design-an-agent-for-production/rubriclabs.com) had the opportunity to build [Cal.com](https://cal.com/?ref=blog.langchain.com)'s AI-driven email assistant. For context, we’re a team of builders who love to tackle challenging engineering problems.

近期，我们 [Rubric Labs](https://blog.langchain.com/how-to-design-an-agent-for-production/rubriclabs.com) 团队有幸为 [Cal.com](https://cal.com/?ref=blog.langchain.com) 构建其 AI 驱动的电子邮件助手。需要说明的是，我们是一支热衷于攻克复杂工程难题的开发者团队。

The vision for the project was to simplify the complex world of calendar management. Some of the core features we had in mind included:

该项目的愿景是简化纷繁复杂的日程管理世界。我们构想的核心功能包括：

- **Turning informal emails into bookings:** "Want to meet tomorrow at 2?"
- **将非正式邮件转化为日程预约：** “明天两点见面可以吗？”

- **Listing and rearranging bookings:** "Cancel my next meeting"
- **列出并重新安排日程：** “取消我下一场会议”

- **Answering basic questions:** "How does my Tuesday look?"
- **回答基础问题：** “我周二的日程安排如何？”

and more. In summary, we wanted to build a personal, AI-powered scheduling assistant that can offer a complete suite of [CRUD](https://www.codecademy.com/article/what-is-crud?ref=blog.langchain.com) operations to the end user, all within the confines of their email client using natural language.

以及其他更多功能。总而言之，我们的目标是打造一款个性化的、AI 驱动的日程助理，它能通过自然语言，在用户所使用的电子邮件客户端内，为其提供完整的 [CRUD](https://www.codecademy.com/article/what-is-crud?ref=blog.langchain.com)（创建、读取、更新、删除）操作能力。

![](images/how-to-design-an-agent-for-production/img_001.png)向 [Cal.ai](http://cal.ai/?ref=blog.langchain.com) 发送邮件

![](images/how-to-design-an-agent-for-production/img_001.png)向 [Cal.ai](http://cal.ai/?ref=blog.langchain.com) 发送邮件

# Architecture

# 架构

We decided to achieve this using an AI agent, particularly an [OpenAI functions agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com) which is better at dealing with structured data, given [Cal.com's API](https://cal.com/docs/enterprise-features/api/api-reference?ref=blog.langchain.com) exposes a set of booking operations with clear inputs. The underlying architecture is explained below.

我们决定采用 AI 智能体（agent）来实现这一目标，尤其选用 [OpenAI functions agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)，因为它更擅长处理结构化数据——这得益于 [Cal.com 的 API](https://cal.com/docs/enterprise-features/api/api-reference?ref=blog.langchain.com) 提供了一组输入明确的预约操作接口。底层架构如下所述。

![](images/how-to-design-an-agent-for-production/img_002.png)Agent architecture. A scratchpad is a type of memory where the AI tries to write itself.

![](images/how-to-design-an-agent-for-production/img_002.png)智能体架构。草稿区（scratchpad）是一种记忆机制，AI 会在其中尝试“自我书写”。

## Input

## 输入

A [Cal.com](http://cal.com/?ref=blog.langchain.com) user may email `username@cal.ai` (e.g [ted@cal.ai](mailto:ted@cal.ai)) with a request such as “Can you book a meeting with [sarim@rubriclabs.com](mailto:sarim@rubriclab.com) sometime tomorrow?”.

一位 [Cal.com](http://cal.com/?ref=blog.langchain.com) 用户可向 `username@cal.ai`（例如：[ted@cal.ai](mailto:ted@cal.ai)）发送邮件，内容如：“能否帮我明天找个时间与 [sarim@rubriclabs.com](mailto:sarim@rubriclab.com) 开个会？”

The incoming email is cleaned and routed in the [receive route](https://github.com/calcom/cal.com/blob/main/apps/ai/src/app/api/receive/route.ts?ref=blog.langchain.com) using [MailParser](https://nodemailer.com/extras/mailparser/?ref=blog.langchain.com) and the addresses are verified by [DKIM record](https://support.google.com/a/answer/174124?hl=en&ref=blog.langchain.com), making it hard to spoof them.

该入站邮件通过 [接收路由（receive route）](https://github.com/calcom/cal.com/blob/main/apps/ai/src/app/api/receive/route.ts?ref=blog.langchain.com) 进行清洗与分发，使用 [MailParser](https://nodemailer.com/extras/mailparser/?ref=blog.langchain.com) 解析，并借助 [DKIM 记录](https://support.google.com/a/answer/174124?hl=en&ref=blog.langchain.com) 验证发件人地址，从而极大降低地址伪造风险。

Here we also make additional checks, such as ensuring that the email is from a [Cal.com](http://cal.com/?ref=blog.langchain.com) user to prevent misuse. After the email has been verified and parsed, it is passed to the agent loop.

此处我们还执行额外校验，例如确保邮件确实来自一位 [Cal.com](http://cal.com/?ref=blog.langchain.com) 用户，以防滥用。邮件经验证与解析后，即被传入智能体循环（agent loop）。

## Agent

## 智能体

The agent is a LangChain [OpenAI functions agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com) which uses fine-tuned versions of GPT models. This agent is passed pre-defined functions or tools and is able to detect when a function should be called. This allows us to specify the required inputs and desired output.

该智能体基于 LangChain 的 [OpenAI functions agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)，采用微调后的 GPT 模型。我们向该智能体预置若干函数（或称工具），它能自主判断何时应调用哪个函数。由此，我们可以明确定义各函数所需的输入参数及期望的输出结果。

The agent is documented in [the agent loop](https://github.com/calcom/cal.com/blob/main/apps/ai/src/app/api/agent/route.ts?ref=blog.langchain.com).

该智能体的实现详见 [智能体循环（agent loop）](https://github.com/calcom/cal.com/blob/main/apps/ai/src/app/api/agent/route.ts?ref=blog.langchain.com)。

There are two required inputs for an OpenAI functions agent:

OpenAI 函数型智能体（OpenAI functions agent）需要两个必要输入：

1. Tools — a tool is simply a Javascript function with a name, description, and input schema  
1. 工具（Tools）—— 一个工具本质上就是一个具备名称（name）、描述（description）和输入模式（input schema）的 JavaScript 函数。

2. Chat model — a [chat model](https://python.langchain.com/docs/modules/model_io/models/chat/?ref=blog.langchain.com) is a variation of an LLM model that uses an interface where "chat messages" are the inputs and outputs  
2. 聊天模型（Chat model）—— [聊天模型](https://python.langchain.com/docs/modules/model_io/models/chat/?ref=blog.langchain.com) 是大语言模型（LLM）的一种变体，其接口以“聊天消息”作为输入与输出。

In addition to the tools and the chat model, we also pass a prefix prompt to add context for the model. Let’s look into each of the inputs.

除工具和聊天模型外，我们还会传入一个前置提示（prefix prompt），为模型提供上下文。接下来，我们逐一分析这些输入。

👉

👉

Let’s use an analogy for clarity. The agent is an electrician named Peer. Peer is unlike any other electrician, Peer has access to deep intelligence using years of training and learning (the model). However, when presented with a problem (the input), Peer’s work (the output) doesn’t always align with the client’s expectations. One day, a client name Bailey decides to hire Peer and offers him a limited set of tools — a soldering gun, battery, wires, and bulb. Peer uses his knowledge and the provided tools to come up with a solution exactly aligned with Bailey’s expectations.

为便于理解，我们打个比方：该智能体是一位名叫 Peer 的电工。Peer 与其他电工不同——他凭借多年训练与学习所积累的深厚智能（即模型）开展工作。然而，当面对一个问题（输入）时，Peer 给出的方案（输出）并不总能完全契合客户预期。某一天，一位名叫 Bailey 的客户决定聘请 Peer，并仅向他提供一套有限的工具：一把电烙铁、一块电池、若干导线和一只灯泡。Peer 凭借自身知识，并结合客户提供的这些工具，最终给出了一个完全符合 Bailey 预期的解决方案。

### Prompt

### 提示（Prompt）

A [prompt](https://docs.langchain.com/docs/components/prompts/?ref=blog.langchain.com) is a way to program the model by providing context. The user’s information (`userId`, `user.username`, `user.timezone`, etc.) is used to construct a prompt which is passed to the agent.

[提示（Prompt）](https://docs.langchain.com/docs/components/prompts/?ref=blog.langchain.com) 是一种通过提供上下文来“编程式引导”模型行为的方式。用户的各项信息（如 `userId`、`user.username`、`user.timezone` 等）被用于构建提示内容，并传递给智能体。

```
const prompt = `You are Cal.ai - a bleeding edge scheduling assistant that interfaces via email.
Make sure your final answers are definitive, complete and well formatted.
Sometimes, tools return errors. In this case, try to handle the error
intelligently or ask the user for more information.
Tools will always handle times in UTC, but times sent to users should be
formatted per that user's timezone.

The primary user's id is: ${userId}
The primary user's username is: ${user.username}
The current time in the primary user's timezone is: ${now(user.timeZone)}
The primary user's time zone is: ${user.timeZone}
The primary user's event types are: ${user.eventTypes}
The primary user's working hours are: ${user.workingHours}
...
`
```

find the full prompt [here](https://github.com/calcom/cal.com/blob/59faffe0d5596f3b1e14ff34ab9fcbbdea8ed616/apps/ai/src/utils/agent.ts?ref=blog.langchain.com#L52C7-L52C13).

请在此处查看完整提示词：[链接](https://github.com/calcom/cal.com/blob/59faffe0d5596f3b1e14ff34ab9fcbbdea8ed616/apps/ai/src/utils/agent.ts?ref=blog.langchain.com#L52C7-L52C13)。

### Chat Model

### 聊天模型（Chat Model）

A [chat model](https://js.langchain.com/docs/modules/model_io/models/chat/?ref=blog.langchain.com) is a variation of a language model which exposes chat messages as the input and output. For this project, we use the `GPT-4` model by OpenAI which can be accessed using an `OPENAI_API_KEY` ( [read here](https://platform.openai.com/docs/api-reference/authentication?ref=blog.langchain.com) to generate an API key).

[聊天模型](https://js.langchain.com/docs/modules/model_io/models/chat/?ref=blog.langchain.com) 是语言模型的一种变体，其输入与输出均以聊天消息（chat messages）的形式呈现。在本项目中，我们使用 OpenAI 提供的 `GPT-4` 模型，需通过 `OPENAI_API_KEY` 进行访问（[点击此处](https://platform.openai.com/docs/api-reference/authentication?ref=blog.langchain.com)了解如何生成 API 密钥）。

For better adoption, we knew that the user experience had to be lightning fast. We experimented with `gpt-3.5-turbo` but, interestingly, it would often take longer overall by completing tasks in more roundabout ways.

为提升用户采纳率，我们深知用户体验必须极为迅捷。我们曾尝试使用 `gpt-3.5-turbo`，但有趣的是，由于该模型常以更迂回的方式完成任务，整体耗时反而更长。

The [temperature](https://platform.openai.com/docs/guides/gpt/how-should-i-set-the-temperature-parameter?ref=blog.langchain.com) is set to 0 to generate more consistent output. A higher temperature leads to a more creative, inconsistent output.

[温度（temperature）](https://platform.openai.com/docs/guides/gpt/how-should-i-set-the-temperature-parameter?ref=blog.langchain.com) 参数被设为 0，以生成更稳定、一致的输出；更高的 temperature 值则会带来更具创造性但也更不稳定的输出。

```
const model = new ChatOpenAI({
    modelName: "gpt-4",
    openAIApiKey: env.OPENAI_API_KEY,
    temperature: 0,
  });
```

```
const model = new ChatOpenAI({
    modelName: "gpt-4",
    openAIApiKey: env.OPENAI_API_KEY,
    temperature: 0,
  });
```

### Tools

### 工具（Tools）

A tool is composed of a Javascript function, name, input schema (using [Zod](https://github.com/colinhacks/zod?ref=blog.langchain.com)), and description, and is designed to work with structured data.

一个“工具”（tool）由四部分组成：一个 JavaScript 函数、一个名称（name）、一个输入模式（input schema，使用 [Zod](https://github.com/colinhacks/zod?ref=blog.langchain.com) 定义）以及一段描述（description），专为处理结构化数据而设计。

The tools used for this project are of type [DynamicStructuredTool](https://js.langchain.com/docs/api/tools/classes/DynamicStructuredTool?ref=blog.langchain.com) which are designed to work with structured data. A dynamic structured tool is an extension of LangChain’s `StructuredTool` class which basically overrides the `_call` method with the function provided. See the schema below for a `DynamicStructuredTool`.

本项目所用的工具类型为 [DynamicStructuredTool](https://js.langchain.com/docs/api/tools/classes/DynamicStructuredTool?ref=blog.langchain.com)，专为结构化数据设计。动态结构化工具（Dynamic Structured Tool）是 LangChain 中 `StructuredTool` 类的扩展，其核心在于以用户提供的函数重写 `_call` 方法。下方即为一个 `DynamicStructuredTool` 的示例模式定义：

```
DynamicStructuredTool({
    description: "Creates a booking on the primary user's calendar.", // Description
    func: createBooking(), // Function
    name: "createBooking", // Name
    schema: z.object({ // Schema
      from: z.string().describe("ISO 8601 datetime string"),
			...
    }),
  });
```

```
DynamicStructuredTool({
    description: "在主用户的日历上创建一项预约。", // 描述
    func: createBooking(), // 函数
    name: "createBooking", // 名称
    schema: z.object({ // 模式定义
      from: z.string().describe("ISO 8601 格式的日期时间字符串"),
			...
    }),
  });
```

Inputs for a DynamicStructuredTool, [the complete example can be seen here](https://github.com/calcom/cal.com/blob/a87d82fd4731dd163fd227da2dcc10c301c2e31a/apps/ai/src/tools/createBooking.ts?ref=blog.langchain.com#L85)

用于 `DynamicStructuredTool` 的输入参数，[完整示例可参见此处](https://github.com/calcom/cal.com/blob/a87d82fd4731dd163fd227da2dcc10c301c2e31a/apps/ai/src/tools/createBooking.ts?ref=blog.langchain.com#L85)

By creating a suite of tools, we are giving the agent extra capabilities to perform pre-defined actions. [All tools used for this project are documented here](https://github.com/calcom/cal.com/tree/main/apps/ai/src/tools?ref=blog.langchain.com) and listed below. Each tool has complex logic that allows it to understand the user’s request, interact with the [Cal.com](http://cal.com/?ref=blog.langchain.com) API by performing a CRUD task, and handle the response.

通过构建一套工具集，我们为智能体（agent）赋予了执行预定义操作的额外能力。[本项目所用全部工具均在此处文档化](https://github.com/calcom/cal.com/tree/main/apps/ai/src/tools?ref=blog.langchain.com)，并列于下方。每个工具均包含复杂的逻辑，使其能够理解用户请求、通过执行增删改查（CRUD）操作与 [Cal.com](http://cal.com/?ref=blog.langchain.com) API 交互，并妥善处理响应。

```
const tools = [\
    createBooking(apiKey, userId, users),\
    deleteBooking(apiKey),\
    getAvailability(apiKey),\
    getBookings(apiKey, userId),\
    sendBookingLink(apiKey, user, users, agentEmail),\
  updateBooking(apiKey, userId),\
];
```

```
const tools = [\
    createBooking(apiKey, userId, users),\
    deleteBooking(apiKey),\
    getAvailability(apiKey),\
    getBookings(apiKey, userId),\
    sendBookingLink(apiKey, user, users, agentEmail),\
  updateBooking(apiKey, userId),\
];
```

The inputs to the tools above are variables we don’t want the AI agent to have access to and thus, they are injected to the tool, bypassing the agent loop.

上述工具所需的输入参数，是我们不希望 AI 智能体直接访问的变量；因此，这些参数被直接注入到工具内部，从而绕过智能体自身的决策循环（agent loop）。

Using the dynamic prompt and the chat model, the tool parser is able to select the most appropriate tool to handle the user’s request and then run in a loop until it’s able to meet the desired behaviour. This follows iterative learning, even allowing fallbacks by picking an alternative tool in case there is an error.

借助动态提示词（dynamic prompt）与聊天模型（chat model），工具解析器（tool parser）能够选择最合适的工具来响应用户请求，并持续循环执行，直至达成预期行为。该机制遵循迭代式学习范式，甚至支持容错回退——即当某工具执行出错时，自动切换至其他备选工具。

![](images/how-to-design-an-agent-for-production/img_003.png)tools architecture

![](images/how-to-design-an-agent-for-production/img_003.png)工具架构图

### Executor

### 执行器（Executor）

Finally, the tools, chat model, and prompt are used to [initialize an agent](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com) and run the executor to generate a response.

最后，结合工具集、聊天模型与提示词，我们[初始化一个智能体](https://js.langchain.com/docs/modules/agents/agent_types/openai_functions_agent?ref=blog.langchain.com)，并运行其执行器（executor）以生成响应。

```
const executor = await initializeAgentExecutorWithOptions(tools, model, {
  agentArgs: { prefix: prompt },
  agentType: "openai-functions",
  verbose: true,
});
```

```
const executor = await initializeAgentExecutorWithOptions(tools, model, {
  agentArgs: { prefix: prompt },
  agentType: "openai-functions",
  verbose: true,
});
```

## Response

## 响应

After the agent runs through a loop utilizing the different tools, chatting with LLM model and interacting with the [Cal.com](http://cal.com/?ref=blog.langchain.com) API, it comes to an end and concludes with a final response. This response is then emailed to the user using an emailing service, such as [Sendgrid](https://sendgrid.com/?ref=blog.langchain.com) or [Resend](https://resend.com/?ref=blog.langchain.com). The email will either be a confirmation or an error.

在代理（agent）完成一轮循环——期间调用各类工具、与大语言模型（LLM）对话，并与 [Cal.com](http://cal.com/?ref=blog.langchain.com) API 交互——后，流程终止，并生成最终响应。该响应随后通过邮件服务（例如 [Sendgrid](https://sendgrid.com/?ref=blog.langchain.com) 或 [Resend](https://resend.com/?ref=blog.langchain.com)）发送给用户。邮件内容为预约确认或错误提示。

# Tech Stack

# 技术栈

- [Typescript](https://www.typescriptlang.org/?ref=blog.langchain.com)
- [Typescript](https://www.typescriptlang.org/?ref=blog.langchain.com)
- [Next.js 13](https://nextjs.org/?ref=blog.langchain.com)
- [Next.js 13](https://nextjs.org/?ref=blog.langchain.com)
- [Vercel Serverless Functions](https://vercel.com/docs/functions/serverless-functions?ref=blog.langchain.com)
- [Vercel 无服务器函数](https://vercel.com/docs/functions/serverless-functions?ref=blog.langchain.com)
- [LangChain](https://www.langchain.com/?ref=blog.langchain.com)
- [LangChain](https://www.langchain.com/?ref=blog.langchain.com)
- [OpenAI GPT-4](https://openai.com/research/gpt-4?ref=blog.langchain.com)
- [OpenAI GPT-4](https://openai.com/research/gpt-4?ref=blog.langchain.com)
- [Zod](https://zod.dev/?ref=blog.langchain.com)
- [Zod](https://zod.dev/?ref=blog.langchain.com)
- [Sendgrid](https://sendgrid.com/?ref=blog.langchain.com)
- [Sendgrid](https://sendgrid.com/?ref=blog.langchain.com)
- [Cal.com API](https://cal.com/docs/enterprise-features/api/api-reference?ref=blog.langchain.com)
- [Cal.com API](https://cal.com/docs/enterprise-features/api/api-reference?ref=blog.langchain.com)

# Conclusion

# 总结

It’s clear that AI agents with scoped tools is a really powerful combination. Combining the knowledge of an LLM model with structured tools helps tackle natural language problems with structured data, increasing the reliability of said agents. We’re extremely excited about the future of AI agents as they continue to evolve and hope that our partnership with [Cal.com](http://cal.com/?ref=blog.langchain.com) and LangChain to create an open-source agent in production will serve as a template for future projects.

显而易见，“具备限定功能范围的工具”的 AI 代理是一种极为强大的组合。将大语言模型（LLM）的知识能力与结构化工具相结合，有助于利用结构化数据解决自然语言问题，从而显著提升此类代理的可靠性。我们对 AI 代理持续演进的未来充满期待；同时，我们也希望与 [Cal.com](http://cal.com/?ref=blog.langchain.com) 和 LangChain 合作打造的、已在生产环境中运行的开源代理项目，能为后续同类项目提供可复用的参考模板。

💬

💬

If you have feedback on this post, please reach out to us at _hello@rubriclab.com_

若您对本文有任何反馈意见，欢迎通过 _hello@rubriclab.com_ 与我们联系。
{% endraw %}
