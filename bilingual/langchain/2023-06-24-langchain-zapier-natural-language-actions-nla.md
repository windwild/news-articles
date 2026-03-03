---
title: "LangChain + Zapier Natural Language Actions (NLA)"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-zapier-nla/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:45:45.937081275+00:00"
language: "en-zh"
translated: true
---

We are super excited to team up with Zapier and integrate their new [Zapier NLA API](https://zapier.com/l/natural-language-actions?ref=blog.langchain.com) into LangChain, which you can now use with your agents and chains. With this integration, you have access to the **5k+ apps and 20k+ actions** on Zapier's platform through a natural language API interface. This is extremely powerful and gives your LangChain agents seemingly limitless possibilities. Big shoutout to Mike Knoop and the rest of the Zapier team for helping with this integration. You can request access in the link shared above. What will you build?

我们非常激动地宣布与 Zapier 展开合作，并将 Zapier 全新推出的 [Zapier NLA API](https://zapier.com/l/natural-language-actions?ref=blog.langchain.com) 集成至 LangChain，您现在即可在智能体（agents）和链（chains）中使用该功能。借助此次集成，您可通过自然语言 API 接口，无缝调用 Zapier 平台上的 **5000+ 应用程序** 和 **20000+ 可执行操作**。这一能力极为强大，为您的 LangChain 智能体打开了近乎无限的可能性。衷心感谢 Mike Knoop 及 Zapier 全体团队对本次集成的大力支持！您可通过上方链接申请访问权限。那么，您打算构建什么应用呢？

# **Zapier NLA**

# **Zapier 自然语言操作（NLA）**

NLA supports apps like Gmail, Salesforce, Trello, Slack, Asana, HubSpot, Google Sheets, Microsoft Teams, and thousands more apps: [https://zapier.com/apps](https://zapier.com/apps?ref=blog.langchain.com)

NLA 支持 Gmail、Salesforce、Trello、Slack、Asana、HubSpot、Google Sheets、Microsoft Teams 等数千款应用：[https://zapier.com/apps](https://zapier.com/apps?ref=blog.langchain.com)

Zapier NLA handles ALL the underlying API auth and translation from natural language -> underlying API call -> return simplified output for LLMs. The key idea is you expose a set of actions via an oauth-like setup window, which you can then query and execute via a REST API.

Zapier NLA 全面接管底层 API 的身份认证，以及从自然语言指令 → 底层 API 调用 → 返回面向大语言模型（LLM）简化的输出等全部流程。其核心设计思路是：您通过一个类似 OAuth 的配置界面，公开一组可执行操作；随后即可通过 REST API 对这些操作进行查询与调用。

NLA offers both API Key and OAuth for signing NLA API requests.

NLA 同时支持 API Key 和 OAuth 两种方式对 NLA API 请求进行签名认证。

1. Server-side (API Key): for quickly getting started, testing, and production scenarios where LangChain will only use actions exposed in the developer's Zapier account (and will use the developer's connected accounts on [Zapier.com](http://zapier.com/?ref=blog.langchain.com))  
2. User-facing (Oauth): for production scenarios where you are deploying an end-user facing application and LangChain needs access to end-user's exposed actions and connected accounts on [Zapier.com](http://zapier.com/?ref=blog.langchain.com)

1. 服务端模式（API Key）：适用于快速上手、测试及生产环境，此时 LangChain 仅调用开发者 Zapier 账户中已公开的操作（并使用开发者在 [Zapier.com](http://zapier.com/?ref=blog.langchain.com) 上已连接的账户）；  
2. 面向用户模式（OAuth）：适用于部署面向终端用户的应用场景，此时 LangChain 需要访问终端用户在 [Zapier.com](http://zapier.com/?ref=blog.langchain.com) 上所公开的操作及其已连接的账户。

Review [full docs](https://nla.zapier.com/api/v1/dynamic/docs?ref=blog.langchain.com) or reach out to [nla@zapier.com](mailto:nla@zapier.com) for user-facing oauth developer support.

请查阅 [完整文档](https://nla.zapier.com/api/v1/dynamic/docs?ref=blog.langchain.com)，或联系 [nla@zapier.com](mailto:nla@zapier.com) 获取面向用户的 OAuth 开发者支持。

# **LangChain Integration**

# **LangChain 集成**

We've integrated Zapier NLA into a LangChain `Tool` and `Toolkit` in both Python ( [docs](https://python.langchain.com/docs/modules/agents/tools/integrations/zapier?ref=blog.langchain.com)) and typescript ( [docs](https://hwchase17.github.io/langchainjs/docs/modules/agents/zapier_agent?ref=blog.langchain.com)). This gives your agents and chains superpowers.

我们已在 Python（[文档](https://python.langchain.com/docs/modules/agents/tools/integrations/zapier?ref=blog.langchain.com)）和 TypeScript（[文档](https://hwchase17.github.io/langchainjs/docs/modules/agents/zapier_agent?ref=blog.langchain.com)）中，将 Zapier NLA 集成进 LangChain 的 `Tool` 与 `Toolkit`。这将为您的智能体与链赋予“超能力”。

To use, simply retrieve an NLA API Key (see above), set the `ZAPIER_NLA_API_KEY` environment variable, then create a `Toolkit` and `agent`:

使用方法十分简单：只需获取一个 NLA API Key（参见上文），设置环境变量 `ZAPIER_NLA_API_KEY`，然后创建一个 `Toolkit` 和 `agent` 即可：

```python
llm = OpenAI(temperature=0)
zapier = ZapierNLAWrapper()
toolkit = ZapierToolkit.from_zapier_nla_wrapper(zapier)
agent = initialize_agent(toolkit.get_tools(), llm, agent="zero-shot-react-description", verbose=True)
```

`ZapierToolkit` 就是这么简单！它会自动将您所有已启用的 Zapier 动作注册为工具，并为其配置正确的名称与描述。

您也可以使用 `ZapierNLARunAction` 工具，手动将某个特定动作注册为独立工具。

实际效果请参见下方示例。该智能体现已接入我的电子邮件和 Slack 账户，能够完成一些令人惊叹的任务。在本例中，它会汇总我最近收到的某家银行发来的邮件，并将摘要发送至指定 Slack 频道。

![](images/langchain-zapier-natural-language-actions-nla/img_001.png)

# **下一步**

我们致力于将此集成打造为尽可能无缝的体验——如果您有任何反馈或遇到任何问题，请务必告诉我们！

## **下一步**

我们致力于将此集成打造为尽可能无缝的体验——如果您有任何反馈或遇到任何问题，请务必告诉我们！

### Tags

### 标签

[![NeumAI x LangChain：面向 AI 应用的高效上下文同步维护](images/langchain-zapier-natural-language-actions-nla/img_002.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI × LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)

[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/langchain-zapier-natural-language-actions-nla/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/langchain-zapier-natural-language-actions-nla/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/langchain-zapier-natural-language-actions-nla/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/langchain-zapier-natural-language-actions-nla/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)

[![Conversational Retrieval Agents](images/langchain-zapier-natural-language-actions-nla/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/langchain-zapier-natural-language-actions-nla/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain 支持的 Genoss 统一 AI 接口端点**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)