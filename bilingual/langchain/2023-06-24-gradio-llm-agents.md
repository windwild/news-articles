---
title: "Gradio & LLM Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/gradio-llm-agents/"
date: "2023-06-24"
scraped_at: "2026-03-03T09:46:45.108793382+00:00"
language: "en-zh"
translated: true
---

**Editor's note: this is a guest blog post from Freddy Boulton, a software engineer at Gradio. We're excited to share this post because it brings a large number of exciting new tools into the ecosystem. Agents are largely defined by the tools they have, so to be able to equip them with all these `gradio_tools` is very exciting to us!**

**编者按：** 本文是来自 Gradio 软件工程师 Freddy Boulton 的客座博客文章。我们非常高兴分享这篇博文，因为它为整个生态引入了大量令人振奋的新工具。智能体（Agents）的能力在很大程度上取决于其所拥有的工具；因此，能够为其配备全部这些 `gradio_tools`，令我们倍感振奋！

**Important Links:**

**重要链接：**

- [Gradio Tools Library](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com)
- [Gradio 工具库](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com)

- [LangChain Integration](https://python.langchain.com/docs/modules/agents/tools/integrations/gradio_tools?ref=blog.langchain.com)
- [LangChain 集成文档](https://python.langchain.com/docs/modules/agents/tools/integrations/gradio_tools?ref=blog.langchain.com)

- [Accompanying Gradio Blog Post](https://gradio.app/gradio-and-llm-agents/?ref=blog.langchain.com)
- [配套 Gradio 博客文章](https://gradio.app/gradio-and-llm-agents/?ref=blog.langchain.com)

Large Language Models (LLMs) are very impressive but they can be made even more powerful if we could give them skills to accomplish specialized tasks.

大语言模型（LLMs）已十分惊艳，但若能赋予它们执行特定任务的“技能”，其能力还可进一步大幅提升。

The [gradio\_tools](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com) library can turn any [Gradio](https://github.com/gradio-app/gradio?ref=blog.langchain.com) application into a [tool](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com) that an [agent](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) can use to complete its task. For example, an LLM could use a Gradio tool to transcribe a voice recording it finds online and then summarize it for you. Or it could use a different Gradio tool to apply OCR to a document on your Google Drive and then answer questions about it.

[gradio\_tools](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com) 库可将任意 [Gradio](https://github.com/gradio-app/gradio?ref=blog.langchain.com) 应用程序转换为一种 [工具](https://python.langchain.com/docs/modules/agents/tools?ref=blog.langchain.com)，供 [智能体（Agent）](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) 调用以完成其任务。例如，一个大语言模型可通过某个 Gradio 工具在线获取一段语音录音并将其转录为文字，再为你生成摘要；又或者，它可调用另一个 Gradio 工具对 Google Drive 中的某份文档执行 OCR（光学字符识别），继而回答你关于该文档的问题。

This guide will show how you can use `gradio_tools` to grant your LLM Agent access to the cutting edge Gradio applications hosted in the world. Although `gradio_tools` are compatible with more than one agent framework, we will focus on [LangChain agents](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) in this guide.

本指南将介绍如何借助 `gradio_tools`，使你的大语言模型智能体（LLM Agent）接入全球范围内前沿的 Gradio 应用程序。尽管 `gradio_tools` 兼容多种智能体框架，但本指南将聚焦于 [LangChain 智能体](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com)。

## Some background

## 背景知识简介

### What are agents?

### 什么是智能体（Agents）？

A [LangChain agent](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) is a Large Language Model (LLM) that takes user input and reports an output based on using one of many tools at its disposal.

[LangChain 智能体](https://python.langchain.com/docs/modules/agents/?ref=blog.langchain.com) 是一种大语言模型（LLM），它接收用户输入，并基于调用其可用的多种工具之一来生成输出。

### What is Gradio?

### 什么是 Gradio？

[Gradio](https://github.com/gradio-app/gradio?ref=blog.langchain.com) 是构建机器学习 Web 应用并将其分享给全世界的事实标准框架——仅需 Python 即可实现！🐍

[Gradio](https://github.com/gradio-app/gradio?ref=blog.langchain.com) 是构建机器学习 Web 应用并将其分享给全世界的事实标准框架——仅需 Python 即可实现！🐍

## gradio\_tools - 端到端示例

## gradio\_tools —— 一个端到端示例

要开始使用 `gradio_tools`，您只需导入并初始化所需工具，然后将它们传递给 LangChain Agent！

要开始使用 `gradio_tools`，您只需导入并初始化所需工具，然后将它们传递给 LangChain Agent！

在以下示例中，我们导入 `StableDiffusionPromptGeneratorTool`，用于为 Stable Diffusion 生成优质提示词；

在以下示例中，我们导入 `StableDiffusionPromptGeneratorTool`，用于为 Stable Diffusion 生成优质提示词；

导入 `StableDiffusionTool`，利用优化后的提示词生成图像；

导入 `StableDiffusionTool`，利用优化后的提示词生成图像；

导入 `ImageCaptioningTool`，为生成的图像添加文字描述（caption）；以及

导入 `ImageCaptioningTool`，为生成的图像添加文字描述（caption）；以及

导入 `TextToVideoTool`，根据提示词生成视频。

导入 `TextToVideoTool`，根据提示词生成视频。

接着，我们指示 Agent 生成一张“狗骑滑板”的图像，并**提前优化我们的提示词**；同时要求它为生成的图像添加描述，并基于优化后的提示词生成一段视频。Agent 可自主决定调用哪个工具，无需我们显式指定。

接着，我们指示 Agent 生成一张“狗骑滑板”的图像，并**提前优化我们的提示词**；同时要求它为生成的图像添加描述，并基于优化后的提示词生成一段视频。Agent 可自主决定调用哪个工具，无需我们显式指定。

```python
import os
if not os.getenv("OPENAI_API_KEY"):
    raise ValueError("OPENAI_API_KEY must be set")
from langchain.agents import initialize_agent
from langchain.llms import OpenAI
from gradio_tools import (StableDiffusionTool, ImageCaptioningTool, StableDiffusionPromptGeneratorTool,
                          TextToVideoTool)
from langchain.memory import ConversationBufferMemory
llm = OpenAI(temperature=0)
memory = ConversationBufferMemory(memory_key="chat_history")
tools = [StableDiffusionTool().langchain, ImageCaptioningTool().langchain,\
         StableDiffusionPromptGeneratorTool().langchain, TextToVideoTool().langchain]
agent = initialize_agent(tools, llm, memory=memory, agent="conversational-react-description", verbose=True)
output = agent.run(input=("Please create a photo of a dog riding a skateboard "
                          "but improve my prompt prior to using an image generator."
                          "Please caption the generated image and create a video for it using the improved prompt."))
```

```python
import os
if not os.getenv("OPENAI_API_KEY"):
    raise ValueError("OPENAI_API_KEY must be set")
from langchain.agents import initialize_agent
from langchain.llms import OpenAI
from gradio_tools import (StableDiffusionTool, ImageCaptioningTool, StableDiffusionPromptGeneratorTool,
                          TextToVideoTool)
from langchain.memory import ConversationBufferMemory
llm = OpenAI(temperature=0)
memory = ConversationBufferMemory(memory_key="chat_history")
tools = [StableDiffusionTool().langchain, ImageCaptioningTool().langchain,\
         StableDiffusionPromptGeneratorTool().langchain, TextToVideoTool().langchain]
agent = initialize_agent(tools, llm, memory=memory, agent="conversational-react-description", verbose=True)
output = agent.run(input=("Please create a photo of a dog riding a skateboard "
                          "but improve my prompt prior to using an image generator."
                          "Please caption the generated image and create a video for it using the improved prompt."))
```

您会注意到，我们使用了 `gradio_tools` 自带的一些预构建工具。有关 `gradio_tools` 所含全部工具的完整列表，请参阅此 [文档](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com#gradio-tools-gradio--llm-agents)。

您会注意到，我们使用了 `gradio_tools` 自带的一些预构建工具。有关 `gradio_tools` 所含全部工具的完整列表，请参阅此 [文档](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com#gradio-tools-gradio--llm-agents)。

If you would like to use a tool that's not currently in `gradio_tools`, it is very easy to add your own. That's what the next section will cover.

如果您想使用一个当前尚未包含在 `gradio_tools` 中的工具，自行添加非常简单。接下来的章节将介绍具体方法。

## gradio\_tools - creating your own tool

## gradio\_tools — 创建您自己的工具

The core abstraction is the `GradioTool`, which lets you define a new tool for your LLM as long as you implement a standard interface:

核心抽象是 `GradioTool` 类；只要您实现一个标准接口，即可为您的大语言模型（LLM）定义一个新工具：

```python
class GradioTool(BaseTool):
    def __init__(self, name: str, description: str, src: str) -> None:
    @abstractmethod
    def create_job(self, query: str) -> Job:
        pass
    @abstractmethod
    def postprocess(self, output: Tuple[Any] | Any) -> str:
        pass
```

The requirements are:

需要满足以下要求：

1. The name for your tool  
   您的工具名称  

2. The description for your tool. This is crucial! Agents decide which tool to use based on their description. Be precise and be sure to include examples of what the input and the output of the tool should look like.  
   您的工具描述。这一点至关重要！智能体（agents）会依据该描述决定调用哪个工具。请务必准确描述，并明确给出该工具的典型输入与输出示例。  

3. The url or space id, e.g. `freddyaboulton/calculator`, of the Gradio application. Based on this value, `gradio_tool` will create a [gradio client](https://github.com/gradio-app/gradio/blob/main/client/python/README.md?ref=blog.langchain.com) instance to query the upstream application via API. Be sure to click the link and learn more about the gradio client library if you are not familiar with it.  
   Gradio 应用的 URL 或 Space ID（例如 `freddyaboulton/calculator`）。基于该值，`gradio_tool` 将创建一个 [Gradio 客户端](https://github.com/gradio-app/gradio/blob/main/client/python/README.md?ref=blog.langchain.com) 实例，通过 API 调用上游应用。若您尚不熟悉该客户端库，请务必点击链接了解详情。  

4. `create_job` — Given a string, this method should parse that string and return a job from the client. Most times, this is as simple as passing the string to the `submit` function of the client. More info on creating jobs [here](https://github.com/gradio-app/gradio/blob/main/client/python/README.md?ref=blog.langchain.com#making-a-prediction).  
   `create_job` — 给定一个字符串，该方法需解析该字符串并返回一个由客户端生成的 `Job` 对象。大多数情况下，只需将该字符串直接传入客户端的 `submit` 方法即可。有关创建任务的更多说明，请参见[此处](https://github.com/gradio-app/gradio/blob/main/client/python/README.md?ref=blog.langchain.com#making-a-prediction)。  

5. `postprocess` — Given the result of the job, convert it to a string the LLM can display to the user.  
   `postprocess` — 给定任务执行结果，将其转换为一段字符串，供 LLM 向用户展示。  

6. _Optional_ — Some libraries, e.g. [MiniChain](https://github.com/srush/MiniChain/tree/main?ref=blog.langchain.com), may need some info about the underlying gradio input and output types used by the tool. By default, this will return `gr.Textbox()` but  
   _可选_ — 某些库（例如 [MiniChain](https://github.com/srush/MiniChain/tree/main?ref=blog.langchain.com)）可能需要了解该工具所依赖的 Gradio 输入与输出组件类型。默认情况下，此信息将返回 `gr.Textbox()`，但  

   if you'd like to provide more accurate info, implement the `_block_input(self, gr)` and `_block_output(self, gr)` methods of the tool. The `gr` variable is the gradio module (the result of `import gradio as gr`). It will be  
   如果您希望提供更精确的信息，请实现工具的 `_block_input(self, gr)` 和 `_block_output(self, gr)` 方法。其中 `gr` 变量即为 Gradio 模块（即执行 `import gradio as gr` 所得的对象）。该模块将由 `GradioTool` 父类自动导入，并作为参数传入 `_block_input` 和 `_block_output` 方法中。  

   automatically imported by the `GradioTool` parent class and passed to the `_block_input` and `_block_output` methods.  

And that's it!

就这样！  

Once you have created your tool, open a pull request to the `gradio_tools` repo! We welcome all contributions.  

完成工具开发后，请向 `gradio_tools` 仓库提交 Pull Request！我们欢迎所有贡献。

## Example tool - Stable Diffusion

## 示例工具：Stable Diffusion

Here is the code for the StableDiffusion tool as an example:

以下为 StableDiffusion 工具的示例代码：

```python
from gradio_tool import GradioTool
import os
class StableDiffusionTool(GradioTool):
    """Tool for calling stable diffusion from llm"""
    """用于从大语言模型（LLM）调用 Stable Diffusion 的工具"""
    def __init__(
        self,
        name="StableDiffusion",
        description=(
            "An image generator. Use this to generate images based on "
            "text input. Input should be a description of what the image should "
            "look like. The output will be a path to an image file."
        ),
        src="gradio-client-demos/stable-diffusion",
        hf_token=None,
    ) -> None:
        super().__init__(name, description, src, hf_token)
    def create_job(self, query: str) -> Job:
        return self.client.submit(query, "", 9, fn_index=1)
    def postprocess(self, output: str) -> str:
        return [os.path.join(output, i) for i in os.listdir(output) if not i.endswith("json")][0]
    def _block_input(self, gr) -> "gr.components.Component":
        return gr.Textbox()
    def _block_output(self, gr) -> "gr.components.Component":
        return gr.Image()
```

Some notes on this implementation:

关于该实现的几点说明：

1. All instances of `GradioTool` have an attribute called `client` that is a pointed to the underlying [gradio client](https://github.com/gradio-app/gradio/tree/main/client/python?ref=blog.langchain.com#gradio_client-use-a-gradio-app-as-an-api----in-3-lines-of-python). That is what you should use  
   所有 `GradioTool` 实例均包含一个名为 `client` 的属性，该属性指向底层的 [Gradio 客户端](https://github.com/gradio-app/gradio/tree/main/client/python?ref=blog.langchain.com#gradio_client-use-a-gradio-app-as-an-api----in-3-lines-of-python)。你应在 `create_job` 方法中使用该客户端。

2. `create_job` just passes the query string to the `submit` function of the client with some other parameters hardcoded, i.e. the negative prompt sting and the guidance scale. We could modify our tool to also accept these values from the input string in a subsequent version.  
   `create_job` 方法仅将查询字符串（`query`）连同若干硬编码参数（例如负向提示词字符串和引导尺度）一并传入客户端的 `submit` 函数。后续版本中，我们可以扩展该工具，使其也支持从输入字符串中解析并接收这些参数。

3. The `postprocess` method simply returns the first image from the gallery of images created by the stable diffusion space. We use the `os` module to get the full path of the image.  
   `postprocess` 方法仅简单地返回由 Stable Diffusion 空间生成的图像画廊中的第一张图像。我们借助 `os` 模块获取该图像的完整文件路径。

## Conclusion

## 总结

You now know how to extend the abilities of your LLM with the 1000s of gradio spaces running in the wild!

你现在已了解如何借助线上运行的数千个 Gradio 空间，来拓展你所用大语言模型（LLM）的能力！

Again, we welcome any contributions to the [gradio\_tools](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com) library.

我们再次诚挚欢迎各位为 [gradio_tools](https://github.com/freddyaboulton/gradio-tools?ref=blog.langchain.com) 库贡献代码或建议！

We're excited to see the tools you all build!

我们热切期待看到大家构建出的各类工具！

### Tags

### 标签


[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/gradio-llm-agents/img_001.png)](https://blog.langchain.com/neum-x-langchain/)

[![NeumAI x LangChain：为 AI 应用高效同步维护上下文](images/gradio-llm-agents/img_001.png)](https://blog.langchain.com/neum-x-langchain/)


[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain：为 AI 应用高效同步维护上下文**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/gradio-llm-agents/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端](images/gradio-llm-agents/img_002.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**让数据接入具备生产就绪能力：一个由 LangChain 驱动的 Airbyte 目标端**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)


[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/gradio-llm-agents/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话](images/gradio-llm-agents/img_003.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai x LangChain：探索 GenWorlds —— 一个协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/gradio-llm-agents/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/gradio-llm-agents/img_004.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)

[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)