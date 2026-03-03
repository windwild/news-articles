---
title: "LangChain + Zapier Natural Language Actions (NLA)"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-zapier-nla/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:45:45.937081275+00:00"
language: "en"
translated: false
---

We are super excited to team up with Zapier and integrate their new [Zapier NLA API](https://zapier.com/l/natural-language-actions?ref=blog.langchain.com) into LangChain, which you can now use with your agents and chains. With this integration, you have access to the **5k+ apps and 20k+ actions** on Zapier's platform through a natural language API interface. This is extremely powerful and gives your LangChain agents seemingly limitless possibilities. Big shoutout to Mike Knoop and the rest of the Zapier team for helping with this integration. You can request access in the link shared above. What will you build?

# **Zapier NLA**

NLA supports apps like Gmail, Salesforce, Trello, Slack, Asana, HubSpot, Google Sheets, Microsoft Teams, and thousands more apps: [https://zapier.com/apps](https://zapier.com/apps?ref=blog.langchain.com)

Zapier NLA handles ALL the underlying API auth and translation from natural language -> underlying API call -> return simplified output for LLMs. The key idea is you expose a set of actions via an oauth-like setup window, which you can then query and execute via a REST API.

NLA offers both API Key and OAuth for signing NLA API requests.

1. Server-side (API Key): for quickly getting started, testing, and production scenarios where LangChain will only use actions exposed in the developer's Zapier account (and will use the developer's connected accounts on [Zapier.com](http://zapier.com/?ref=blog.langchain.com))
2. User-facing (Oauth): for production scenarios where you are deploying an end-user facing application and LangChain needs access to end-user's exposed actions and connected accounts on [Zapier.com](http://zapier.com/?ref=blog.langchain.com)

Review [full docs](https://nla.zapier.com/api/v1/dynamic/docs?ref=blog.langchain.com) or reach out to [nla@zapier.com](mailto:nla@zapier.com) for user-facing oauth developer support.

# **LangChain Integration**

We've integrated Zapier NLA into a LangChain `Tool` and `Toolkit` in both Python ( [docs](https://python.langchain.com/docs/modules/agents/tools/integrations/zapier?ref=blog.langchain.com)) and typescript ( [docs](https://hwchase17.github.io/langchainjs/docs/modules/agents/zapier_agent?ref=blog.langchain.com)). This gives your agents and chains superpowers.

To use, simply retrieve an NLA API Key (see above), set the `ZAPIER_NLA_API_KEY` environment variable, then create a `Toolkit` and `agent`:

```python
llm = OpenAI(temperature=0)
zapier = ZapierNLAWrapper()
toolkit = ZapierToolkit.from_zapier_nla_wrapper(zapier)
agent = initialize_agent(toolkit.get_tools(), llm, agent="zero-shot-react-description", verbose=True)
```

‌It's really that simple! The `ZapierToolkit` automatically registers all of your enabled Zapier actions as tools with the correct name and descriptions.

You can also register an individual action as a tool manually using the `ZapierNLARunAction` tool.

To see this in action, look at the example below. This agent now has access to my email and slack, and is able to do some amazing feats. In this example, it’s summarizing the latest email I received from a certain bank and sending it to a slack channel.

![](images/langchain-zapier-natural-language-actions-nla/img_001.png)

# **Next Steps**

We’re hoping to make this as seamless an integration as possible so let us know if you have any feedback for hit any issues!

### Tags



[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/langchain-zapier-natural-language-actions-nla/img_002.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/langchain-zapier-natural-language-actions-nla/img_003.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/langchain-zapier-natural-language-actions-nla/img_004.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/langchain-zapier-natural-language-actions-nla/img_005.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)