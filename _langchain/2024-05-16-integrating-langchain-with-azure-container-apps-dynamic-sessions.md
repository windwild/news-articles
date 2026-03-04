---
render_with_liquid: false
title: "Integrating LangChain with Azure Container Apps dynamic sessions"
source: "LangChain Blog"
url: "https://blog.langchain.com/integrating-langchain-with-azure-container-apps-dynamic-sessions/"
date: "2024-05-16"
scraped_at: "2026-03-03T08:02:37.826014947+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Azure Container Apps dynamic sessions provide a secure, low-latency, reliable Python REPL API. With the new dynamic sessions LangChain integration, you can safely give your LangChain chains and agents the ability to write and execute Python code.

Azure Container Apps 动态会话提供一种安全、低延迟、可靠的 Python REPL（读取-求值-输出）API。借助全新的动态会话 LangChain 集成，您可以安全地赋予 LangChain 链（chains）和智能体（agents）编写并执行 Python 代码的能力。

### Relevant Links

### 相关链接

- LangChain: [docs](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com)  
- LangChain：[文档](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com)
- Azure Container Apps: [docs](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?ref=blog.langchain.com) and [tutorial](https://learn.microsoft.com/en-us/azure/container-apps/sessions-tutorial-langchain?ref=blog.langchain.com)  
- Azure Container Apps：[文档](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?ref=blog.langchain.com) 和 [教程](https://learn.microsoft.com/en-us/azure/container-apps/sessions-tutorial-langchain?ref=blog.langchain.com)
- LangGraph data analyst: [video](https://www.youtube.com/watch?v=NsVnUz7sp_Y&ref=blog.langchain.com) and [code](https://github.com/langchain-ai/langchain/blob/master/cookbook/azure_container_apps_dynamic_sessions_data_analyst.ipynb?ref=blog.langchain.com)  
- LangGraph 数据分析师：[视频](https://www.youtube.com/watch?v=NsVnUz7sp_Y&ref=blog.langchain.com) 和 [代码](https://github.com/langchain-ai/langchain/blob/master/cookbook/azure_container_apps_dynamic_sessions_data_analyst.ipynb?ref=blog.langchain.com)

# The value of code execution

# 代码执行的价值

LLMs excel at solving complex problems but, just like human brains, struggle with certain computational tasks.  While these current state-of-the-art models can explain intricate concepts like statistical mechanics, they may not be able to perform tasks like correctly computing the average of 10 floats. However, these models can proficiently write Python code to compute the average of a list of floats.

大语言模型（LLM）擅长解决复杂问题，但与人类大脑类似，它们在某些计算任务上仍存在困难。尽管当前最先进的模型能够清晰阐释统计力学等复杂概念，却可能无法准确完成诸如计算 10 个浮点数平均值这类基础运算。然而，这些模型却能熟练编写 Python 代码，用以计算一组浮点数列表的平均值。

Just as computers ushered in a new era of human productivity by handling raw computations so that we could focus on defining algorithms and programmatic logic, code execution tools will also enhance LLM agents’ capabilities, leading to higher productivity and performance.

正如计算机通过承担底层计算任务，使人类得以专注于算法设计与程序逻辑，从而开启人类生产力的新纪元；代码执行工具也将增强 LLM 智能体的能力，进而提升其生产力与整体性能。

# Azure Container Apps dynamic sessions

# Azure Container Apps 动态会话

Dynamic sessions is a new feature in Azure Container Apps that allows you to run LLM-generated code securely in a sandbox. You can augment the limitations of LLMs with  mathematical computations by running their generated Python code securely in dynamic sessions without any containers’ knowledge needed.

动态会话是 Azure Container Apps 中的一项新功能，允许您在沙箱环境中安全地运行由大语言模型生成的代码。您可通过在动态会话中安全执行模型生成的 Python 代码，弥补 LLM 在数学计算方面的固有局限，且整个过程无需用户了解或管理容器相关细节。

Sessions have the following attributes:

会话具备以下特性：

- **Strong isolation**: Sessions are isolated from each other and from the host environment. Each session runs in its own Hyper-V sandbox, providing enterprise-grade security and isolation. Optionally, you can enable network isolation to further enhance security.  
- **强隔离性**：各会话之间相互隔离，且与宿主环境完全隔离。每个会话均在独立的 Hyper-V 沙箱中运行，提供企业级的安全性与隔离保障。您还可选择启用网络隔离，以进一步强化安全性。

- **Fully managed**: The platform fully manages a session's lifecycle. Sessions are automatically cleaned up when no longer in use.  
- **全托管**：平台全面管理会话的整个生命周期。当会话不再使用时，系统将自动清理资源。

- **Fast startup**: A new session is allocated in about 100ms. Rapid start-ups are achieved by automatically maintaining a pool of ready but unallocated sessions.  
- **快速启动**：新建会话的分配耗时约 100 毫秒。系统通过自动维护一个“就绪但未分配”的会话池，实现极速启动。

- **Scalable**: Sessions can run at a high scale. You can run hundreds or thousands of sessions concurrently.  
- **高可扩展性**：会话支持大规模并发运行。您可同时启动数百乃至数千个会话。

- **Data access**: You can upload files to a Session so that your code can interact with your data.  
- **数据访问能力**：您可向会话上传文件，使您的代码能够直接访问和处理自有数据。

- **Private**: Files are written in the session's file system inside the Hyper-V isolation boundary. They are not accessible directly by default. They can be downloaded using an API.  
- **私密性**：所有文件均写入位于 Hyper-V 隔离边界内的会话文件系统中，默认不可被外部直接访问；您可通过 API 下载这些文件。

- **Preinstalled packages**: Sessions comes with many of the most popular packages preinstalled, like NumPy, pandas, and scikit-learn. You can also run `!pip install ...` like in a notebook cell to add more (if egress is enabled).  
- **预装软件包**：会话已预装大量常用 Python 包，例如 NumPy、pandas 和 scikit-learn。您还可像在 Jupyter Notebook 单元格中一样，运行 `!pip install ...` 命令安装额外依赖（需已启用出站网络访问）。

For full documentation of the sessions API head to the [Azure Container Apps docs](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com).

有关会话（Sessions）API 的完整文档，请参阅 [Azure Container Apps 文档](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com)。

# Using the LangChain integration

# 使用 LangChain 集成

Getting started with the LangChain integration is simple. You can do the following:

LangChain 集成的入门非常简单。您可按以下步骤操作：

1. Set up your Azure Container Apps service by following the instructions [here](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com#create-a-session-pool-with-azure-cli). Make sure to get your Sessions pool management endpoint as shown [here](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com#get-the-pool-management-api-endpoint-with-azure-cli).

1. 按照[此处](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com#create-a-session-pool-with-azure-cli)的说明，配置您的 Azure Container Apps 服务。请务必获取您的会话池（Sessions pool）管理端点，具体方法见[此处](https://learn.microsoft.com/en-us/azure/container-apps/sessions-code-interpreter?tabs=azure-cli&ref=blog.langchain.com#get-the-pool-management-api-endpoint-with-azure-cli)。

2. Install the required dependencies

2. 安装所需依赖项

`!pip install langchain-azure-dynamic-sessions`

`!pip install langchain-azure-dynamic-sessions`

3. Import and run

3. 导入并运行

```python
from langchain_azure_dynamic_sessions import SessionsPythonREPLTool

tool = SessionsPythonREPLTool(
	pool_management_endpoing="<<Enter Pool Management Endpoint>>",
)

code = """
import numpy as np

print("sampling 3 datapoints from standard normal distribution")
```

```python
np.random.normal(size=3).tolist()
```

# To get string output:  
# 获取字符串输出：

```python
print(tool.invoke(code))
```

This will generate a JSON string like:  
这将生成一个 JSON 字符串，例如：

```python
"""{
  "result": [
    0.34904792009397784,
    -2.237593977256981,
    1.2965825537776963
  ],
  "stdout": "sampling 3 datapoints from standard normal distribution",
  "stderr": ""
}"""
```

If we want the raw outputs, not as a string, we can use `tool.execute()`:  
如果希望获取原始输出（而非字符串形式），可使用 `tool.execute()`：

```python
# To get dict output:  
# 获取字典格式输出：
tool.execute(code)
```

This would return a dictionary with a list of floats for the `"result"`:  
该调用将返回一个字典，其 `"result"` 字段为一个浮点数列表：

```python
{
  "result": [
    0.34904792009397784,
    -2.237593977256981,
    1.2965825537776963
  ],
  "stdout": "sampling 3 datapoints from standard normal distribution",
  "stderr": ""
}
```

Head to the [LangChain docs](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com) to see how to upload files to a session, pass model-generated code to the tool, use the tool in an agent, and more.  
请访问 [LangChain 文档](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com)，了解如何向会话上传文件、将模型生成的代码传入该工具、在智能体（agent）中使用该工具，以及更多高级用法。

# Data analyst agent with LangGraph  
# 基于 LangGraph 的数据分析智能体

One of the most exciting use cases for Sessions is building agents that can analyze large datasets using code. In the below walkthrough we show how to build a data analyst agent using LangGraph and dynamic sessions:

Sessions 最激动人心的应用场景之一，是构建能够利用代码分析大规模数据集的智能体（agents）。在下方的实操指南中，我们将演示如何使用 LangGraph 和动态 Sessions 构建一个数据分析智能体：

Here's the link to the agent [code](https://github.com/langchain-ai/langchain/blob/master/cookbook/azure_container_apps_dynamic_sessions_data_analyst.ipynb?ref=blog.langchain.com).

该智能体的 [源代码链接](https://github.com/langchain-ai/langchain/blob/master/cookbook/azure_container_apps_dynamic_sessions_data_analyst.ipynb?ref=blog.langchain.com)。

# Conclusion

# 总结

Code executing tools are indispensable for data analysis and software engineering LLM application. With the new LangChain and Azure Container Apps dynamic sessions integration, you can write and execute Python code safely and with low latency.

代码执行类工具对于数据分析和软件工程领域的 LLM 应用而言不可或缺。借助 LangChain 与 Azure Container Apps 动态 Sessions 的全新集成，您可安全、低延迟地编写并执行 Python 代码。

Head to the [LangChain docs](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com) to get started!

请前往 [LangChain 官方文档](https://python.langchain.com/v0.2/docs/integrations/tools/azure_dynamic_sessions/?ref=blog.langchain.com) 开始使用！