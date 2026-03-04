---
render_with_liquid: false
title: "Build stateful conversational AI agents with LangGraph and assistant-ui"
source: "LangChain Blog"
url: "https://blog.langchain.com/assistant-ui/"
date: "2024-09-11"
scraped_at: "2026-03-03T07:53:50.177704680+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**TL;DR: assistant-ui 是一个可嵌入 React 应用的 AI 聊天前端组件。它支持流式响应（streaming）、生成式 UI（generative UI）、人工介入（human-in-the-loop）等关键用户体验范式，专为智能体（agentic）应用而设计。我们与该项目维护者 Simon 合作，实现了 assistant-ui 与 LangGraph Cloud 的深度集成。这使得你可以轻松将 LangGraph 智能体部署为独立 Web 应用，或将其作为助手无缝集成到现有应用中。本文由 LangChain 团队与 Simon 共同撰写。**

## **相关链接**

## **相关链接**

- [快速上手](https://www.assistant-ui.com/docs/runtimes/langgraph?ref=blog.langchain.com)
- [教程](https://www.assistant-ui.com/docs/runtimes/langgraph/tutorial?ref=blog.langchain.com)
- [示例代码仓库](https://github.com/Yonom/assistant-ui-stockbroker?ref=blog.langchain.com) 及 [在线演示](https://assistant-ui-stockbroker.vercel.app/?ref=blog.langchain.com)
- [YouTube 视频介绍](https://youtu.be/k1OEeqknoR0?ref=blog.langchain.com)

## **引言**

## **引言**

在 LangChain，我们对智能体（agent）构建中最具潜力的方向之一——即智能体应用的用户界面与用户体验（UI/UX）——尤为振奋。为此，我们专门撰写了一整套关于智能体 UX 的系列博客文章：[第一篇：聊天交互](https://blog.langchain.com/ux-for-agents-part-1-chat-2/)、[第二篇：环境感知](https://blog.langchain.com/ux-for-agents-part-2-ambient/) 和 [第三篇：综合实践](https://blog.langchain.com/ux-for-agents-part-3/)。当前，聊天（chat）仍是智能体最主流、最广泛采用的交互范式。

然而，聊天 UI/UX 的形态多种多样，且随着智能体功能日趋复杂，你可能还需为其添加各类增强型能力。例如，“人工介入”（human-in-the-loop）机制正变得越来越普遍——即在关键决策或操作前，由用户进行审核或干预；“生成式 UI”（generative UI）也日益流行，开发者希望智能体能主动向终端用户清晰传达其正在执行的操作；当然，流式响应（streaming）更是现代 AI 聊天体验的基本要求。

LangChain 的使命，是让构建驱动这些智能体的“认知架构”（cognitive architectures）尽可能简单。我们致力于降低实现上述功能的门槛：例如，我们正引入标准化的工具调用（tool calling）接口，以更好支持生成式 UI；同时，LangGraph 的有状态（stateful）设计，也使其天然更易于实现人工介入等高级交互模式。

但仅构建好后端认知架构仍远远不够——你还需要一个强大、灵活的前端来承载这些智能体。正因如此，我们非常高兴能与 assistant-ui 展开合作，共同打造 assistant-ui 与 LangGraph Cloud 的深度集成。assistant-ui 在理念与关注点上与 LangChain 高度一致，二者结合，构成了一套构建智能体应用的无缝技术栈。

## **assistant-ui 概览**

## **assistant-ui 概览**

assistant-ui 是一款功能强大的基于 React 的聊天界面组件，专为 AI 驱动的对话场景而设计。它提供了一整套完备的功能特性，助力开发者快速构建交互性强、用户体验友好的 AI 聊天应用。以下是其核心能力概览：

### **Streaming LLM Results**

### **流式传输 LLM 结果**

assistant-ui 开箱即用地支持流式传输 LangChain LLM 响应，包括工具调用（tool calls）。这确保了动态且响应迅速的聊天体验，使用户能够在 AI 生成响应的同时实时查看内容。

/0:05

1×

### **Rich Content Display**

### **丰富内容展示**

界面支持 Markdown 渲染，可呈现多种内容类型，例如列表、代码片段、表格等。这种灵活性有助于清晰、直观地传达复杂信息。

### **Generative UI**

### **生成式用户界面（Generative UI）**

其中一项突出特性是能够以易于理解的方式展示结构化数据。LangChain/LangGraph 中的工具调用可映射至自定义 UI 组件，从而实现更富交互性、更具视觉吸引力的信息呈现。例如，股票价格数据可渲染为如下形式：

![](images/build-stateful-conversational-ai-agents-with-langgraph-and-assistant-ui/img_001.jpg)

### **Human-in-the-Loop with Approval UI**

### **带审批 UI 的人工介入（Human-in-the-Loop）**

For scenarios requiring user oversight, assistant-ui offers approval interfaces. This feature enables users to review and authorize specific AI actions before execution. This enhances safety and control in agent interactions and is particularly useful for critical operations, such as financial transactions.

对于需要用户监督的场景，assistant-ui 提供审批界面。该功能使用户能够在执行前审查并授权特定的 AI 操作。这提升了智能体交互过程中的安全性与可控性，尤其适用于金融交易等关键操作。

![](images/build-stateful-conversational-ai-agents-with-langgraph-and-assistant-ui/img_002.jpg)

### **Multimodal**

### **多模态支持**

assistant-ui goes beyond text-based interactions by allowing the upload of images or documents as inputs to agents.

assistant-ui 不局限于纯文本交互，还支持上传图片或文档作为智能体的输入。

### **Stateful interactions**

### **有状态交互**

By synchronizing with LangGraph state, your apps can host multi-turn conversations with context awareness, complex task handling across multiple exchanges and persistent memory for more natural and efficient interactions.

通过与 LangGraph 状态同步，您的应用可支持具备上下文感知能力的多轮对话、跨多次交互的复杂任务处理，以及持久化记忆，从而实现更自然、更高效的交互体验。

## **Setting up the LangGraph Cloud integration**

## **配置 LangGraph Cloud 集成**

It’s pretty easy to get LangGraph Cloud and an assistant-ui frontend to work together.

将 LangGraph Cloud 与 assistant-ui 前端协同工作非常简单。

1) Deploy your LangGraph agent to LangGraph Cloud

1) 将您的 LangGraph 智能体部署至 LangGraph Cloud

2) Bootstrap an assistant-ui frontend

2) 初始化一个 assistant-ui 前端

`npx assistant-ui@latest create -t langgraph`

`npx assistant-ui@latest create -t langgraph`

3) Set the following environment variables  
3) 设置以下环境变量

```
# Only required for production deployments  
# 仅在生产环境部署时需要
# LANGCHAIN_API_KEY=your_langchain_api_key  
# LANGCHAIN_API_KEY=your_langchain_api_key
LANGGRAPH_API_URL=your_langgraph_api_url  
LANGGRAPH_API_URL=your_langgraph_api_url
NEXT_PUBLIC_LANGGRAPH_ASSISTANT_ID=your_assistant_id_or_graph_id  
NEXT_PUBLIC_LANGGRAPH_ASSISTANT_ID=your_assistant_id_or_graph_id
```

For detailed instructions on using generative UI, human-in-the-loop interactions, tool call approvals, and integrating into existing applications, refer to the [documentation](https://www.assistant-ui.com/docs/runtimes/langgraph?ref=blog.langchain.com).  
有关如何使用生成式 UI、人工介入（human-in-the-loop）交互、工具调用审批，以及如何将助手集成至现有应用的详细说明，请参阅[文档](https://www.assistant-ui.com/docs/runtimes/langgraph?ref=blog.langchain.com)。

## **Stockbroker Agent**  
## **股票经纪人智能体（Stockbroker Agent）**

To illustrate the capabilities of this integration, let's explore the Stockbroker Agent example. This agent demonstrates the power of combining LangGraph and assistant-ui:  
为展示该集成的能力，我们以“股票经纪人智能体（Stockbroker Agent）”示例为例。该智能体充分体现了 LangGraph 与 assistant-ui 协同工作的强大能力：

- Web Search: The agent can search the internet for relevant financial information.  
- 网络搜索：该智能体可联网检索相关金融信息。  
- Financial Statement Analysis: It can read and interpret financial statements.  
- 财务报表分析：它能读取并解析财务报表。  
- Stock Price Retrieval: Real-time stock prices can be fetched and displayed.  
- 股票价格获取：可实时抓取并展示股票价格。  
- Purchase Order Execution: The agent can execute stock purchase orders with user approval.  
- 下单执行：该智能体可在用户确认后执行股票买入指令。

The Stockbroker Agent leverages generative UI to display stock information in a visually appealing format. It also uses approval UI for purchase confirmations, ensuring user oversight on critical financial decisions.  
股票经纪人智能体利用生成式 UI，以直观美观的方式呈现股票信息；同时借助审批 UI 实现交易确认流程，确保用户对关键财务决策拥有最终控制权。

![](images/build-stateful-conversational-ai-agents-with-langgraph-and-assistant-ui/img_003.jpg)  
![](images/build-stateful-conversational-ai-agents-with-langgraph-and-assistant-ui/img_003.jpg)

This diagram illustrates the structure of the Stockbroker Agent, showing how LangGraph Cloud hosts the agent's cognitive architecture, while assistant-ui provides the human-in-the-loop user interaction. The integration between these two systems enables a powerful and user-friendly AI assistant experience.  
该图展示了股票经纪人智能体的整体架构：LangGraph Cloud 托管其认知逻辑与工作流编排，而 assistant-ui 则负责提供支持人工介入的用户交互界面。二者的深度集成，共同打造了一个功能强大且用户体验友好的 AI 助手系统。

You can see a video where we walk through this demo [here](https://youtu.be/k1OEeqknoR0?ref=blog.langchain.com).

您可以在此处观看我们逐步演示该示例的视频：[点击观看](https://youtu.be/k1OEeqknoR0?ref=blog.langchain.com)。

Here’s the link to the [agent repository](https://github.com/Yonom/assistant-ui-stockbroker?ref=blog.langchain.com) and [live demo](https://assistant-ui-stockbroker.vercel.app/?ref=blog.langchain.com).

以下是 [智能体代码仓库](https://github.com/Yonom/assistant-ui-stockbroker?ref=blog.langchain.com) 和 [在线演示](https://assistant-ui-stockbroker.vercel.app/?ref=blog.langchain.com) 的链接。

## **Conclusion**

## **结语**

The combination of LangGraph and assistant-ui opens up new possibilities for building interactive stateful AI assistants that seamlessly integrate into React apps. The streaming, generative UI, and approval UI features enable transparent and interactive communication between users and AI agents, enhancing trust and usability.

LangGraph 与 assistant-ui 的结合，为构建具备状态管理能力、高度交互性的 AI 助手开辟了全新可能——这些助手可无缝集成至 React 应用中。流式响应、生成式用户界面（generative UI）以及审批式用户界面（approval UI）等功能，使用户与 AI 智能体之间的沟通更加透明、自然，从而显著提升用户信任度与使用体验。

By leveraging this powerful integration, developers can focus on creating value-added features and domain-specific functionality. The underlying infrastructure handles the complexities of state management (LangGraph) and UX interaction patterns (assistant-ui), streamlining the development process and enabling the creation of more advanced AI-powered applications.

借助这一强大集成，开发者得以专注于高价值功能与领域专属逻辑的开发；底层基础设施则自动处理状态管理（LangGraph）与用户体验交互模式（assistant-ui）等复杂问题，大幅简化开发流程，并助力构建更先进、更智能的 AI 应用。

To learn more about assistant-ui, check out the [documentation](https://www.assistant-ui.com/docs/runtimes/langgraph?ref=blog.langchain.com) or the stockbroker [example repository](https://github.com/Yonom/assistant-ui-stockbroker?ref=blog.langchain.com).

如需深入了解 assistant-ui，请查阅其 [官方文档](https://www.assistant-ui.com/docs/runtimes/langgraph?ref=blog.langchain.com)，或参阅股票经纪人（stockbroker）[示例代码仓库](https://github.com/Yonom/assistant-ui-stockbroker?ref=blog.langchain.com)。