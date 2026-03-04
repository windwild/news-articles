---
title: "LangChain 🤝 Streamlit"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-streamlit/"
date: "2023-07-11"
scraped_at: "2026-03-03T09:32:44.515904613+00:00"
language: "en-zh"
translated: true
description: "The initial integration of Streamlit with LangChain and our future plans."
---
{% raw %}

**Editor's Note: This post was written in collaboration with the Streamlit team. From the beginning, Streamlit has been a fantastic tool for LangChain developers. In fact, [one of the first examples](https://github.com/hwchase17/notion-qa?ref=blog.langchain.com) we released used Streamlit as the UI. It has been a honor to have the opportunity to work more closely with the team over the past months, and we're thrilled to share some of the stuff we've been working on and thinking about.**

**编者按：本文由 LangChain 团队与 Streamlit 团队联合撰写。自诞生之初，Streamlit 就一直是 LangChain 开发者的绝佳工具。事实上，我们最早发布的示例之一——[Notion QA 应用](https://github.com/hwchase17/notion-qa?ref=blog.langchain.com)——就采用了 Streamlit 作为其用户界面。过去数月，我们非常荣幸能与 Streamlit 团队展开更紧密的合作；如今，我们满怀激动，向大家介绍双方正在共同推进的集成工作以及相关构想。**

Today, we're excited to announce the initial integration of Streamlit with LangChain and share our plans and ideas for future integrations.

今天，我们很高兴地宣布 Streamlit 与 LangChain 的初步集成，并分享我们对未来深度协作的规划与思考。

The LangChain and Streamlit teams had previously [used](https://blog.langchain.com/auto-eval-of-question-answering-tasks/) and [explored](https://blog.streamlit.io/langchain-tutorial-1-build-an-llm-powered-app-in-18-lines-of-code/?ref=blog.langchain.com) each other's libraries and found that they worked incredibly well together.

LangChain 团队与 Streamlit 团队此前已[使用过](https://blog.langchain.com/auto-eval-of-question-answering-tasks/)并[探索过](https://blog.streamlit.io/langchain-tutorial-1-build-an-llm-powered-app-in-18-lines-of-code/?ref=blog.langchain.com)彼此的库，发现二者配合得极为默契。

- [Streamlit](https://streamlit.io/generative-ai?ref=blog.langchain.com) 是一种更快构建和共享数据应用的方式。它能在几分钟内将数据脚本转化为可分享的 Web 应用，全程仅需纯 Python 编写。  
- [LangChain](https://blog.langchain.com/) 帮助开发者构建功能强大的应用程序，将大语言模型（LLM）与其他计算资源或知识源有机结合。

Both libraries have a strong open-source community ethic, and a "batteries included" approach to quickly delivering a working app and iterating rapidly.

两个库均秉持强烈的开源社区精神，并采用“开箱即用”（batteries included）的设计理念，助力开发者快速交付可运行的应用，并实现高效迭代。

**Rendering LLM thoughts and actions**

**呈现大语言模型（LLM）的思维过程与操作行为**

Our first goal was to create a simpler method for rendering and examining the thoughts and actions of an LLM agent. We wanted to show what takes place before the agent's final response. It's useful for both the final application (to notify the user about the process) and the development stage (to troubleshoot any problems).

我们的首要目标是提供一种更简洁的方式，来呈现并检视 LLM 智能体（agent）的内部思维过程与操作行为——即在其最终响应生成之前所发生的一切。这一能力对终端应用（用于向用户实时反馈处理进展）和开发阶段（用于排查潜在问题）均极具价值。

The [Streamlit Callback Handler](https://python.langchain.com/docs/modules/callbacks/integrations/streamlit?ref=blog.langchain.com) does precisely that. Passing the callback handler to an agent running in Streamlit displays its thoughts and tool input/outputs in a compact expander format.

[Streamlit 回调处理器（Callback Handler）](https://python.langchain.com/docs/modules/callbacks/integrations/streamlit?ref=blog.langchain.com) 正是为此而生。当将该回调处理器传入在 Streamlit 中运行的智能体后，其内部思维过程及所调用工具的输入/输出内容，便会以紧凑的可折叠组件（expander）形式清晰呈现。

Try it out with this MRKL example, a popular Streamlit app:

不妨通过这个广受欢迎的 Streamlit 应用——MRKL 示例——亲自体验一下：

What are we seeing here?  

我们在此看到的是什么？

- An expander is rendered for each thought and tool call from the agent  
- 每个智能体（agent）产生的思考过程和工具调用均渲染为一个可展开区域（expander）。

- The tool name, input, and status (running or complete) are shown in the expander title  
- 工具名称、输入参数以及状态（运行中或已完成）均显示在该可展开区域的标题栏中。

- LLM output is streamed token by token into the expander, providing constant feedback to the user  
- 大语言模型（LLM）的输出以逐 token 的方式流式写入该可展开区域，持续向用户提供实时反馈。

- Once finished, the tool return value is also written out inside the expander  
- 任务完成后，该工具的返回值也会一并写入该可展开区域内。

We added this to our app with just one extra line of code:  
我们仅通过一行额外代码，便将此功能集成到了应用中：

```python
# initialize the callback handler with a container to write to

st_callback = StreamlitCallbackHandler(st.container())

# pass it to the agent in the call to run()

answer = agent.run(user_input, callbacks=[st_callback])
```

For a complete walkthrough on how to get started, please refer to our [docs](https://python.langchain.com/docs/modules/callbacks/integrations/streamlit?ref=blog.langchain.com#installation-and-setup).  
如需完整入门指南，请参阅我们的[文档](https://python.langchain.com/docs/modules/callbacks/integrations/streamlit?ref=blog.langchain.com#installation-and-setup)。

## **Advanced usage**  
## **高级用法**

You can configure the behavior of the callback handler with advanced options available [here](https://api.python.langchain.com/en/latest/callbacks/langchain.callbacks.streamlit.streamlit_callback_handler.StreamlitCallbackHandler.html?ref=blog.langchain.com):  
您可通过[此处](https://api.python.langchain.com/en/latest/callbacks/langchain.callbacks.streamlit.streamlit_callback_handler.StreamlitCallbackHandler.html?ref=blog.langchain.com)提供的高级选项，自定义回调处理器（callback handler）的行为：

- Choose whether to expand or collapse each step when it first loads and completes  
- 可配置每个步骤在首次加载及执行完成时，默认展开或收起。

- Determine how many steps will render before they start collapsing into a "History" step  
- 可设定在多少个步骤之后，后续步骤将自动折叠进一个名为“历史记录”（History）的汇总步骤中。

- Define custom labels for expanders based on the tool name and input  
- 可根据工具名称与输入内容，自定义各可展开区域的标题标签。

The callback handler also works seamlessly with the new [Streamlit Chat UI](https://docs.streamlit.io/knowledge-base/tutorials/build-conversational-apps?ref=blog.langchain.com), as you can see in this "chat with search" app (requires an OpenAI API Key to run):

回调处理器也能与全新的 [Streamlit 聊天界面（Chat UI）](https://docs.streamlit.io/knowledge-base/tutorials/build-conversational-apps?ref=blog.langchain.com) 无缝协作，如下所示的“搜索式聊天”应用即为示例（运行需提供 OpenAI API 密钥）：

🤝

View more example apps and a 1-click GitHub Codespaces setup to start hacking from our [shared repo](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com).

欢迎访问我们的 [共享代码仓库](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com)，查看更多示例应用，并一键启动 GitHub Codespaces 环境，立即开始开发！

## **Where are we going from here?**

## **接下来将走向何方？**

We have a few improvements in progress:

我们正在推进以下几项改进：

- Extend StreamlitCallbackHandler to support additional chain types like VectorStore, SQLChain, and simple streaming (and improve the default UI/UX and ease of customization).  
  - 扩展 `StreamlitCallbackHandler`，以支持更多链类型（如 `VectorStore`、`SQLChain` 和基础流式响应），并优化默认的用户界面/用户体验（UI/UX）及自定义便捷性。

- Make it even easier to use LangChain primitives like Memory and Messages with Streamlit chat and session\_state.  
  - 进一步简化 LangChain 基础组件（如 `Memory` 和 `Messages`）与 Streamlit 聊天功能及 `session_state` 的集成使用。

- Add more app examples and templates to [langchain-ai/streamlit-agent](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com).  
  - 向 [langchain-ai/streamlit-agent](https://github.com/langchain-ai/streamlit-agent?ref=blog.langchain.com) 添加更多应用示例和模板。

We're also exploring some deeper integrations for connecting data to your apps and visualizing chain/agent state to improve the developer experience. And we're excited to collaborate and see how you use these features!

我们还在探索更深层次的集成方案，例如将数据源接入您的应用，以及可视化链（chain）/智能体（agent）的运行状态，从而进一步提升开发者体验。我们也非常期待与您协作，并见证您如何运用这些功能！

If you have ideas, example apps, or want to contribute, please reach out on the [LangChain](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) or [Streamlit](https://discord.gg/bTz5EDYh9Z?ref=blog.langchain.com) Discord servers.

如果您有任何想法、示例应用，或希望参与贡献，请随时在 [LangChain](https://discord.gg/6adMQxSpJS?ref=blog.langchain.com) 或 [Streamlit](https://discord.gg/bTz5EDYh9Z?ref=blog.langchain.com) 的 Discord 社区中联系我们。

Happy coding! 🎈🦜🔗

祝编码愉快！🎈🦜🔗

### Tags

### 标签

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/langchain-streamlit/img_001.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/langchain-streamlit/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据摄取具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话](images/langchain-streamlit/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain：探索 GenWorlds —— 一种协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![对话式检索智能体](https://images.unsplash.com/photo-1625794084867-8ddd239946b1?crop=entropy&cs=tinysrgb&fit=max&fm=webp&ixid=M3wxMTc3M3wwfDF8c2VhcmNofDZ8fGdvbGRlbiUyMHJldHJpZXZlcnxlbnwwfHx8fDE2OTEwNDEwOTl8MA&ixlib=rb-4.0.3&q=80&w=760)](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**使用 Genoss 统一 AI 接口，由 LangChain 提供支持**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)
{% endraw %}
