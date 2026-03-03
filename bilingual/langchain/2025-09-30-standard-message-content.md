---
title: "Standard message content"
source: "LangChain Blog"
url: "https://blog.langchain.com/standard-message-content/"
date: "2025-09-30"
scraped_at: "2026-03-03T07:27:15.408331237+00:00"
language: "en-zh"
translated: true
---

TLDR: 我们引入了一种[全新的消息内容视图](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content)，该视图对推理过程、引用标注、服务端工具调用及其他现代大语言模型（LLM）功能在不同厂商之间进行了标准化。这使得开发者能够更轻松地构建与推理服务提供商无关的应用，同时充分利用各厂商的最新功能。该特性完全向后兼容，因为新内容可基于现有消息内容**惰性计算**（lazy computation）得出。

## Motivation  
## 动机

LangChain 的核心优势之一，是为大语言模型提供 **“一次编写，随处运行”**（write once, run anywhere）的抽象层。这一抽象使开发者能够构建可在不同 LLM 服务商之间无缝切换的应用程序，而无需重写代码。

近期，OpenAI、Anthropic 和 Google Gemini 等主流推理服务提供商所支持的功能在丰富性和多样性上出现了爆发式增长。如今，LLM 可以针对单个查询执行多个明确区分的步骤：例如展开推理过程、执行网页搜索、调用代码解释器，最终生成带有引用标注（citations）且可能包含多模态数据（如图像）的响应。尽管各家厂商所支持的功能集合高度相似，但其 API 设计却日益分化；而各厂商提供的通用接口（例如 Chat Completions API）这类兼容层，往往滞后于原生功能的演进——甚至完全不支持某些厂商独有的高级能力。

## Standard content in LangChain 1.0  
## LangChain 1.0 中的标准内容

我们为最新的 LLM 功能引入了新的标准类型，并将这些类型统一暴露在所有 LangChain 消息对象上，从而让开发者在构建与服务商无关的应用时，无需牺牲对任一可用功能的支持。这些功能将在 `langchain` 1.0 版本中正式发布，同时支持 [Python](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com) 和 [JavaScript](https://docs.langchain.com/oss/javascript/releases/langchain-v1?ref=blog.langchain.com) 两种语言。

[标准内容块（Standard content blocks）](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content) 确保**相同的能力在不同服务商下以完全一致的方式表达**。在实践中，它们是一组类型化的数据结构，用于在所有 LLM 服务商之间对消息内容进行归一化处理。具体包括：

- 模型输出的标准文本（含引用标注）  
- 模型的推理过程与思维链（chain-of-thought）输出  
- 来自任意来源的图像、音频、视频及文档（支持 URL、base64 编码、云存储桶文件 ID 等格式）  
- 工具（function）调用与执行指令  
- 厂商专属工具，例如内置网页搜索能力与代码执行环境  

## Details  
## 详细说明

所有 LangChain 消息对象现在均实现了 `.content_blocks` 属性，该属性会基于现有消息内容**惰性加载**（lazily load）新的标准化表示。以 Anthropic 的 Claude 和 OpenAI 的 Responses API 返回结果为例：在本示例中，我们将同时启用它们的推理能力与网页搜索功能。原始的 `.content` 字段仍将保持厂商原生格式透传：

**Anthropic**:

**Anthropic**：

```python
from langchain.chat_models import init_chat_model

llm = init_chat_model(
    "anthropic:claude-sonnet-4-20250514",
    thinking={"type": "enabled", "budget_tokens": 5_000},
).bind_tools([\
    {\
        "type": "web_search_20250305",\
        "name": "web_search",\
        "max_uses": 1,\
    }\
])

response = llm.invoke("When was LangChain created?")

response.content
# [\
#   {\
#     "type": "thinking",\
#     "thinking": "...",\
#     "signature": "...",\
#   },\
#   {\
#     "type": "server_tool_use",\
#     "name": "web_search",\
#     "input": {...},\
#     "id": "...",\
#   },\
#   {\
#     "type": "web_search_tool_result",\
#     "content": [...],\
#     "tool_use_id": "...",\
#   }\
#   {\
#     "type": "text",\
#     "text": "...",\
#     "citations": [...],\
#   }\
```

**OpenAI**:

**OpenAI**：

```python
from langchain.chat_models import init_chat_model

llm = init_chat_model(
    "openai:gpt-5-nano",
    reasoning={"effort": "low", "summary": "auto"},
).bind_tools([{"type": "web_search_preview"}])

response = llm.invoke("When was LangChain created?")

response.content
# [\
#   {\
#     "type": "reasoning",\
#     "summary": [...],\
#     "id": "...",\
#   },\
#   {\
#     "type": "web_search_call"\
#     "action": {...},\
#     "id": "...",\
#     ...\
#   },\
#   {\
#     "type": "text",\
#     "text": "...",\
#     "annotations": [...],\
#     "id": "...",\
#   }\
```

Although the content of these responses are similar, small differences in the APIs add compounding friction to building an application that would let you swap between these two providers.

尽管这些响应的内容相似，但 API 层面的细微差异会显著增加构建可灵活切换这两家服务商的应用程序的开发成本。

The new `.content_blocks` property will parse both responses into a consistent representation:

全新的 `.content_blocks` 属性将把上述两种响应统一解析为一致的数据结构：

```python
response.content_blocks
# [\
#   {\
#     "type": "reasoning",\
#     "reasoning": "...",\
#   },\
#   {\
#     "type": "web_search_call",\
#     "query": "...",\
#     "id": "...",\
#     "extras": {...},\
#   },\
#   {\
#     "type": "web_search_result",\
#     "urls": [...],\
#     "id": "...",\
#     "extras": {...},\
#   },\
#   {\
#     "type": "text",\
#     "text": "...",\
#     "annotations": [...],\
#   }\
```

The output of `.content_blocks` includes new types for reasoning, citations, web searches, code interpreter calls, and also includes LangChain types for (client side) tool calls and multimodal data, such as images, PDF documents, and audio.

`.content_blocks` 的输出涵盖多种新型内容块类型，包括推理（reasoning）、引用（citations）、网页搜索（web search）、代码解释器调用（code interpreter calls），同时也支持 LangChain 原生定义的客户端工具调用（tool calls）及多模态数据（如图像、PDF 文档和音频）等类型。

Standard content blocks are currently available in alpha for

标准内容块（Standard Content Blocks）目前处于 Alpha 阶段，已支持以下平台：

- Providers implementing chat completions APIs (including OpenAI)  
  实现聊天补全（chat completions）API 的服务商（含 OpenAI）

- OpenAI Responses API  
  OpenAI Responses API

- Anthropic (Claude)  
  Anthropic（Claude）

`langchain` 1.0 will feature support for all major providers.

LangChain 1.0 将全面支持所有主流大模型服务商。

## Backward compatibility

## 向后兼容性

- No breaking changes; **100% compatible** with existing LangChain applications  
  无任何破坏性变更；**100% 兼容**现有 LangChain 应用程序

- `.content_blocks` works on all message types, including legacy ones stored in cache  
  `.content_blocks` 支持所有消息类型，包括缓存中存储的历史旧版消息

## Looking forward

## 展望未来

Standard content blocks represent a fundamental step toward more reliable, maintainable LLM applications.

标准内容块是迈向更可靠、更易维护的大语言模型（LLM）应用程序的关键一步。

By providing consistent interfaces across providers, you can:

通过在不同服务商之间提供统一的接口，您将能够：

- **Build with confidence**: Type safety catches errors before production  
  **放心构建**：类型安全可在生产环境部署前捕获错误

- **Scale across providers**: Switch models without spending time rewriting application logic  
  **跨服务商扩展**：无需重写业务逻辑即可自由切换模型

- **Future-proof applications**: New provider features work immediately without breaking existing code  
  **面向未来**：新接入服务商的功能可即刻生效，且不会破坏现有代码

* * *

**Ready to try it?** Check out our [migration guide](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com) and [technical docs](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content).

**准备试用了吗？** 请查阅我们的 [迁移指南](https://docs.langchain.com/oss/python/releases/langchain-v1?ref=blog.langchain.com) 和 [技术文档](https://docs.langchain.com/oss/python/langchain/messages?ref=blog.langchain.com#content)。

**Questions or feedback?** Please comment on the dedicated [Github issue](https://github.com/langchain-ai/langchain/issues/32794?ref=blog.langchain.com) for the release. We’d appreciate any thoughts you have to share!

**有任何问题或反馈？** 欢迎在本次发布的专属 [GitHub Issue](https://github.com/langchain-ai/langchain/issues/32794?ref=blog.langchain.com) 下留言。我们非常期待听到您的宝贵意见！