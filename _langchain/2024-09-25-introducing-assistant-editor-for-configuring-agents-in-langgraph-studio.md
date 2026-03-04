---
title: "Introducing Assistant Editor for configuring agents in LangGraph Studio"
source: "LangChain Blog"
url: "https://blog.langchain.com/asssistant-editor/"
date: "2024-09-25"
scraped_at: "2026-03-03T07:52:05.950309220+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

We're excited to announce the launch of the [Assistant Editor](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com), a powerful new feature in [LangGraph Studio](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/) that makes it easier than ever to [configure and customize](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#assistants) your LLM-powered agents. This visual editing tool empowers both developers and non-technical users to fine-tune agent behavior without diving into code.

我们很高兴地宣布推出 [Assistant Editor（助手编辑器）](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com)，这是 [LangGraph Studio（LangGraph 工作室）](https://blog.langchain.com/langgraph-studio-the-first-agent-ide/) 中一项功能强大的新特性，让配置和自定义您基于大语言模型（LLM）构建的智能体（agents）变得前所未有的简单。这一可视化编辑工具赋能开发者与非技术用户 alike，无需编写代码即可精细调整智能体的行为。

### What are Assistants?

### 什么是 Assistant（助手）？

Before we dive into the new [Assistant Editor](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com), let's quickly recap what assistants are in the context of LangGraph.

在深入介绍全新的 [Assistant Editor（助手编辑器）](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com) 之前，让我们快速回顾一下在 LangGraph 语境中，“Assistant（助手）” 的含义。

[Assistants](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#assistants) are instances of a graph with specific configurations. They allow you to make rapid changes to agent behavior without altering the underlying graph logic. This is particularly useful for:

[Assistant（助手）](https://langchain-ai.github.io/langgraph/cloud/concepts/api/?ref=blog.langchain.com#assistants) 是具备特定配置的图（graph）实例。它使您能够在不修改底层图逻辑的前提下，快速调整智能体行为。这一机制特别适用于以下场景：

1. **Experimentation**: Developers can quickly modify and version different configurations to test performance.  
   **实验与迭代**：开发者可快速修改并为不同配置创建版本，以测试其性能表现。  
2. **No-code customization**: Business users can adjust agent settings without needing to touch the codebase.  
   **无代码定制**：业务人员无需接触代码库，即可灵活调整智能体设置。

Assistants can share the same graph structure but have different prompts, models, or other configuration options. This flexibility allows for easy personalization and iteration.

多个 Assistant 可共享同一图结构，但各自拥有不同的提示词（prompts）、模型（models）或其他配置选项。这种灵活性极大简化了个性化定制与持续迭代的过程。

### Introducing the Assistant Editor

### 助手编辑器正式登场

The new Assistant Editor in [LangGraph Studio](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) provides a visual interface for creating and modifying assistants. Here's what you can do:

[LangGraph Studio](https://github.com/langchain-ai/langgraph-studio?ref=blog.langchain.com) 中全新推出的 Assistant 编辑器，提供直观的可视化界面，用于创建与修改 Assistant。您可通过它实现以下操作：

- **Intuitive Configuration**: Easily adjust prompts, select different language models, and modify other graph parameters through a user-friendly interface.  
  **直观配置**：通过用户友好的界面，轻松调整提示词、选择不同语言模型，并修改其他图参数。  
- **Real-time preview**: You can try out your configuration in the studio by selecting different assistant configurations to run.  
  **实时预览**：您可在 Studio 中直接运行并试用不同 Assistant 配置，即时验证效果。  
- **Version control**: Save and track different versions of your assistant configurations, making it simple to compare performance or revert changes.  
  **版本控制**：保存并追踪 Assistant 配置的不同版本，便于性能对比或一键回滚变更。  
- **Collaboration**: Share assistant configurations with team members, allowing for easier review and iteration.  
  **协同协作**：与团队成员共享 Assistant 配置，提升评审效率与协作迭代体验。

1×

### Benefits for Different Users

### 不同用户群体的收益

The Assistant Editor in LangGraph Studio enhances the agent development process for various groups.

LangGraph Studio 中的助手编辑器（Assistant Editor）可为多个用户群体提升智能体（agent）开发效率。

For **developers and engineering teams**, the Assistant Editor streamlines experimentation and prototyping, allowing you to make rapid configuration changes and quickly test different prompts, models, and parameters. The built-in versioning system helps developers track changes and compare different configurations– giving visibility to all team members about how the agent configuration has evolved over time while fine-tuning agent performance.

对于**开发者与工程团队**而言，助手编辑器可简化实验与原型开发流程，支持快速调整配置，并高效测试不同提示词（prompts）、模型及参数。其内置的版本控制系统帮助开发者追踪变更、对比不同配置——在持续调优智能体性能的同时，让所有团队成员清晰了解智能体配置随时间的演进过程。

**Business users** can use the Assistant Editor to customize agent behavior directly within the visual interface, aligning them more closely with specific use cases or user needs. This ability to iterate on prompts and settings bridges the gap between business and engineering team needs, promoting collaboration to speed up the process of refining agent interactions.

**业务用户**可通过助手编辑器在可视化界面中直接定制智能体行为，使其更贴合特定应用场景或用户需求。这种对提示词与设置的快速迭代能力，有效弥合了业务团队与工程团队之间的需求鸿沟，促进跨职能协作，从而加速智能体交互体验的优化进程。

### Getting Started

### 入门指南

To start using the Assistant Editor:

开始使用助手编辑器，请按以下步骤操作：

1. Update to the latest version of LangGraph Studio  
   更新至最新版 LangGraph Studio  
2. Open your LangGraph project  
   打开您的 LangGraph 项目  
3. Navigate to the new "Assistants" dropdown  
   进入新增的“Assistants（助手）”下拉菜单  
4. Create a new assistant or select an existing one to edit  
   创建新助手，或选择已有助手进行编辑  

Check out our [detailed YouTube video](https://youtu.be/XQYe3u5e_c4?ref=blog.langchain.com) for a full walkthrough of the Assistant Editor features and best practices. See [detailed documentation](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com) on managing assistants here.

欢迎观看我们的 [详细 YouTube 教程视频](https://youtu.be/XQYe3u5e_c4?ref=blog.langchain.com)，全面了解助手编辑器的功能特性与最佳实践。有关助手管理的详细文档，请参阅 [此处](https://langchain-ai.github.io/langgraph/cloud/how-tos/assistant_versioning/?ref=blog.langchain.com)。

### What's Next?

### 后续计划？

The Assistant Editor is just the beginning of our efforts to make agent development more accessible and efficient.  

助手编辑器（Assistant Editor）仅仅是我们致力于让智能体（agent）开发更易用、更高效的第一步。

We’re working towards making LangGraph Studio a complete GUI for interacting with an agent deployed on LangGraph Cloud.  

我们正努力将 LangGraph Studio 打造成一个完整的图形用户界面（GUI），用于与部署在 LangGraph Cloud 上的智能体进行交互。

We envision every endpoint in the API to be usable from the Studio to open up Agent development and management to many more people.  

我们的愿景是：API 中的每一个端点都能直接通过 Studio 调用，从而让更多人能够参与智能体的开发与管理工作。

We're continuously working on improvements and would love to hear your feedback. What features would you like to see next?  

我们持续进行功能优化与迭代，也非常期待听到您的反馈——您最希望接下来推出哪些新功能？

Join our [community Slack](https://www.notion.so/link-to-slack?ref=blog.langchain.com) to share your thoughts and connect with other LangGraph users. You can also follow us on [Twitter](https://www.notion.so/link-to-twitter?ref=blog.langchain.com) for the latest updates.  

欢迎加入我们的 [社区 Slack 频道](https://www.notion.so/link-to-slack?ref=blog.langchain.com)，分享您的想法，并与其他 LangGraph 用户交流互动。您也可以关注我们的 [Twitter](https://www.notion.so/link-to-twitter?ref=blog.langchain.com)，第一时间获取最新动态。

Start visually configuring your agents today with the new Assistant Editor in LangGraph Studio!  

即刻体验 LangGraph Studio 全新推出的助手编辑器，以可视化方式配置您的智能体！
&#123;% endraw %}
