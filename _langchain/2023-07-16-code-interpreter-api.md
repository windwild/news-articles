---
render_with_liquid: false
title: "Code Interpreter API"
source: "LangChain Blog"
url: "https://blog.langchain.com/code-interpreter-api/"
date: "2023-07-16"
scraped_at: "2026-03-03T09:32:36.454287312+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

**Editor's Note: This is another installation of our guest blog posts highlighting interesting and novel use cases. This blog is written by [Shroominic](https://shroominic.com/?ref=blog.langchain.com) who built an open source implementation of the ChatGPT Code Interpreter.**

**编者按：** 这是我们系列客座博客文章的又一期，旨在展示有趣且新颖的应用场景。本文作者为 [Shroominic](https://shroominic.com/?ref=blog.langchain.com)，他开发了 ChatGPT 代码解释器（Code Interpreter）的一个开源实现。

Important Links:  
重要链接：

- [GitHub Repo](https://github.com/shroominic/codeinterpreter-api?ref=blog.langchain.com)  
- [GitHub 仓库](https://github.com/shroominic/codeinterpreter-api?ref=blog.langchain.com)

In the world of open-source software, there are always exciting developments. Today, I am thrilled to announce a new project that I have been working on - Code Interpreter API. It's an implementation of the ChatGPT Code Interpreter using LangChain Agents. Keep in mind this is an unofficial implementation and I am not affiliated with OpenAI.

在开源软件的世界中，总不乏激动人心的新进展。今天，我非常高兴地宣布一个我近期投入开发的新项目——Code Interpreter API。这是一个基于 LangChain Agents 实现的 ChatGPT 代码解释器。需要特别说明的是，本项目为非官方实现，本人与 OpenAI 无任何隶属或合作关系。

## Motivation  

## 动机

As an indie developer, I am constantly searching for new features to add to my projects. While working on a Discord bot, I attempted to incorporate the code interpreter as a feature. I never tried it at that point but got hyped by seeing people using it on YouTube. It started as an experiment, but with some tinkering, it evolved into a functional and progressively improving feature. I noticed a significant interest in this area and identified a gap in the market - there was no API for this and especially not open source.

作为一名独立开发者，我始终在为自己的项目寻找值得集成的新功能。在开发一款 Discord 机器人时，我尝试将代码解释器作为一项功能引入。彼时我尚未亲自使用过该功能，但看到 YouTube 上许多用户演示其强大能力后深受鼓舞。最初它仅是一次实验性尝试；经过反复调试与优化，它逐渐发展为一项稳定可用、持续进化的功能。我敏锐地察觉到这一领域存在显著需求，并发现市场中尚无此类 API —— 尤其是完全开源的实现方案。

## **Unique Features and Benefits**  

## **独特功能与优势**

The biggest advantage over the already existing Code Interpreter from OpenAI is that this open-source version has internet access. For example, this is useful when asking “Plot the Bitcoin chart of 2023” the agent uses yahoo finance to download live data about the current situation and then shows it as an image plot to the user. Another advantage is that you can use your hardware. For example, if you want to do something that includes running stable diffusion you need to have a dedicated GPU that can run the model. This is not the case in the cloud environment you have from OpenAI. Other features include chat memory so you can ask follow-up questions and automatic Python package installation (when missing) so the agent tries again.

相较于 OpenAI 已有的 Code Interpreter，本开源版本最突出的优势在于具备互联网访问能力。例如，当用户提问“绘制 2023 年比特币价格走势图”时，智能体可调用 Yahoo Finance 接口实时获取最新市场数据，并将结果以图像形式呈现给用户。另一大优势是支持本地硬件部署：例如，若需运行 Stable Diffusion 等计算密集型任务，则可直接利用您自有设备上的专用 GPU 加速推理——而 OpenAI 提供的云端环境并不支持此类自定义硬件配置。此外，本实现还支持对话记忆（chat memory），便于用户提出后续追问；并具备 Python 包自动安装机制（当所需依赖缺失时），使智能体可在补全环境后重试执行。

## **Technical Details**  

## **技术细节**

The core of this project is a LangChain Agent, specifically the new OpenAIFunctionsAgent which gives the advantage of calling functions/tools to better handle the user needs. For the code interpreter, we need to give it access to a Python interpreter so it can execute Python code. This interpreter is represented as a tool so the Agent can call the tool and use Python to fulfill what the user wants.

本项目的核心是一个 LangChain Agent，具体采用的是新版 `OpenAIFunctionsAgent`，其优势在于能够调用各类函数/工具，从而更精准地响应用户需求。针对代码解释器功能，我们需要为其提供一个 Python 解释器环境，使其能够实际执行 Python 代码。该解释器被封装为一个工具（tool），供 Agent 调用，进而借助 Python 完成用户指定的任务。

For example, if the user asks to plot a sin wave and show it as an image, the agent writes Python code and inputs it to the Python interpreter which runs the code, outputs the image and then this image can be displayed to the user. Additionally, the Agent can comment on the result and explain what happened or give more details about the output.

例如，如果用户要求绘制正弦波并以图像形式展示，智能体将编写 Python 代码，并将其输入 Python 解释器执行；解释器运行代码后输出图像，该图像即可呈现给用户。此外，智能体还可对结果进行评述，解释执行过程，或进一步说明输出内容。

It is not straightforward to give LangChain Agents access to a Code Execution Environment. There is already Python REPL but this does not allow for FileIO and it also forgets variables after every run. So I had to write my solution for this: CodeBoxAPI.

为 LangChain 智能体接入代码执行环境并非易事。虽然已有 Python REPL 工具，但它不支持文件输入/输出（FileIO），且每次运行后都会清空变量。因此，我专门为此开发了解决方案：CodeBoxAPI。

When starting a Code Interpreter Session it creates a small Jupyter kernel on your device similar to how Jupyter notebooks work. A CodeBox is the underlying Python execution env where the agent can run code and receive its outputs. A small personal computer the agent has access to and which it can use to serve the user its request.

启动代码解释器会话时，会在您的设备上创建一个轻量级的 Jupyter 内核，其工作机制与 Jupyter Notebook 类似。CodeBox 是底层 Python 执行环境，智能体可在其中运行代码并接收输出结果。它相当于一台专供智能体使用的微型个人计算机，用以响应并满足用户的请求。

## Examples

## 示例

![](images/code-interpreter-api/img_001.png)

![](images/code-interpreter-api/img_001.png)

AI: Here is the normalized plot showing the relative performance of the tech giants (Apple, Google, Microsoft, Amazon) in 2023. The plot is normalized so that the starting point of each stock is 100, which allows for easy comparison of the percentage changes in each stock's price over the period.

AI：这是 2023 年科技巨头（苹果、谷歌、微软、亚马逊）相对表现的归一化走势图。图中已将每支股票的起始点统一设为 100，便于直观比较各股票价格在该时段内的百分比变动。

![](images/code-interpreter-api/img_002.png)

![](images/code-interpreter-api/img_002.png)

**Another Example**

**另一个示例**

Prompt: ”Select representative ETFs for different sectors (Technology, Healthcare, Consumer Discretionary, etc.). Plot their performance during the last two economic cycles. Analyze how different sectors behave in different stages of an economic cycle.”

提示：“为不同行业（如科技、医疗保健、非必需消费品等）选取代表性 ETF；绘制它们在最近两个经济周期中的表现；分析各行业在经济周期不同阶段的表现特征。”

**Response**

**响应**

AI: The plot above shows the performance of the selected ETFs representing the Technology, Healthcare, and Consumer Discretionary sectors during the last two economic cycles (the dot-com bubble from 2000–2002 and the financial crisis from 2007–2009).

上图展示了代表科技（Technology）、医疗保健（Healthcare）和非必需消费品（Consumer Discretionary）行业的几只精选ETF在最近两个经济周期（即2000–2002年的互联网泡沫时期和2007–2009年的金融危机时期）内的表现。

As we can see, all sectors were negatively affected during these periods, with significant drops in value. However, the extent and timing of these drops vary between sectors.

如图所示，所有行业在上述时期均受到负面影响，市值出现显著下跌；但各行业下跌的幅度和时间点存在差异。

For a more detailed analysis, we could look at the performance of these sectors during different stages of the economic cycles (e.g., pre-recession, during the recession, and post-recession). However, this would require a more complex analysis and might be beyond the scope of this discussion.

若需更深入的分析，我们可进一步考察这些行业在经济周期不同阶段（例如衰退前、衰退中与衰退后）的表现。然而，此类分析将更为复杂，可能超出本文讨论范围。

Please note that this analysis is quite simplified and doesn't take into account many factors that could influence the performance of these sectors during different economic cycles. For a more accurate and detailed analysis, you might want to consider consulting with a financial advisor or conducting a more in-depth research.

请注意，本分析较为简化，未纳入诸多可能影响各行业在不同经济周期中表现的因素。如需更精准、详尽的分析，建议咨询专业金融顾问或开展更深入的研究。

![](images/code-interpreter-api/img_003.png)

## Roadmap

## 路线图

The next step is to make CodeBox production-ready, enabling developers to create public apps as it allows for easy scaling. Currently, each user requires a small sandboxed execution environment, making it challenging to deploy to production with this API. Plans also include making it available using other LLMs (e.g., ClaudeV2 or Open Orca). In time, users may be able to run this API 100% locally and offline on their home PC.

下一步是将 CodeBox 打造成生产就绪（production-ready）状态，从而支持开发者构建面向公众的应用——这得益于其出色的可扩展性。目前，每位用户都需要一个轻量级的沙盒执行环境，因此直接通过该 API 部署至生产环境仍具挑战性。后续计划还包括支持其他大语言模型（LLM），例如 ClaudeV2 或 Open Orca。长远来看，用户或将能够完全在本地家用电脑上离线运行该 API。

## **How to Use It**

## **如何使用**

The installation is straightforward: get your OpenAI API Key **[here](https://platform.openai.com/account/api-keys?ref=blog.langchain.com)** and install the package using pip. You can use the API in your Python code: start a session, generate a response based on user input — stop your session. You can find detailed instructions on the project's GitHub **[README](https://github.com/shroominic/codeinterpreter-api/blob/main/README.md?ref=blog.langchain.com)**.

安装十分简单：请先**[在此处](https://platform.openai.com/account/api-keys?ref=blog.langchain.com)** 获取您的 OpenAI API 密钥，再通过 pip 安装对应软件包。您可在 Python 代码中调用该 API：启动会话 → 基于用户输入生成响应 → 终止会话。项目详细使用说明请参阅 GitHub 上的 **[README](https://github.com/shroominic/codeinterpreter-api/blob/main/README.md?ref=blog.langchain.com)**。

## **Contribute**

## **参与贡献**

If you're interested in contributing to the Code Interpreter API, there are several opportunities. Have a look into the Issues I put some tagged as ToDo. But you can also work on your ideas and just push a PR. Thanks!

如果您有兴趣为 Code Interpreter API 做出贡献，目前有多种参与方式。欢迎查看我创建的 Issues，其中部分已标注为 “ToDo”。当然，您也可以基于自己的想法开展工作，并直接提交 Pull Request（PR）。感谢您的支持！

## Do Experiments

## 动手实验

If you have not checked out the repository I highly recommend to do so and just try out your prompts! Try out a lot of different stuff to get an idea of what is possible and what is not. If you encounter any bugs please publish them as GitHub Issues and I will try to fix them.

如果您尚未克隆或浏览过该代码仓库，我强烈建议您立即前往查看，并亲自尝试各种提示词（prompts）！多做不同类型的实验，有助于您直观了解该 API 的能力边界——哪些任务可以完成，哪些尚不支持。如在使用过程中发现任何 Bug，请务必通过 GitHub Issues 提交报告，我将尽力修复。

This is my first blog post ever so thanks for reading this and I hope you had fun! If you want to get updated feel free to check out my [Twitter @shroominic](https://twitter.com/shroominic?ref=blog.langchain.com).

这是我撰写的第一篇博客文章，感谢您阅读至此！希望您读得愉快！如希望及时获取最新动态，欢迎关注我的 [Twitter @shroominic](https://twitter.com/shroominic?ref=blog.langchain.com)。

### Tags

### 标签

[![NeumAI x LangChain: Efficiently maintaining context in sync for AI applications](images/code-interpreter-api/img_004.png)](https://blog.langchain.com/neum-x-langchain/)

[**NeumAI x LangChain: Efficiently maintaining context in sync for AI applications**](https://blog.langchain.com/neum-x-langchain/)


[![Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination](images/code-interpreter-api/img_005.png)](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[**Making Data Ingestion Production Ready: a LangChain-Powered Airbyte Destination**](https://blog.langchain.com/making-data-ingestion-production-ready-a-langchain-powered-airbyte-destination/)

[![Chat with your data using OpenAI, Pinecone, Airbyte and Langchain](images/code-interpreter-api/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[![使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话](images/code-interpreter-api/img_006.jpg)](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**Chat with your data using OpenAI, Pinecone, Airbyte and Langchain**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)

[**使用 OpenAI、Pinecone、Airbyte 和 LangChain 与您的数据进行对话**](https://blog.langchain.com/chat-with-your-data-using-openai-pinecone-airbyte-langchain/)


[**Yeager.ai x LangChain: Exploring GenWorlds a Framework for Coordinating AI Agents**](https://blog.langchain.com/exploring-genworlds/)

[**Yeager.ai × LangChain：探索 GenWorlds——一个用于协调 AI 智能体的框架**](https://blog.langchain.com/exploring-genworlds/)


[![Conversational Retrieval Agents](images/code-interpreter-api/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[![对话式检索智能体](images/code-interpreter-api/img_007.jpg)](https://blog.langchain.com/conversational-retrieval-agents/)

[**Conversational Retrieval Agents**](https://blog.langchain.com/conversational-retrieval-agents/)

[**对话式检索智能体**](https://blog.langchain.com/conversational-retrieval-agents/)


[**Unifying AI endpoints with Genoss, powered by LangChain**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)

[**借助 LangChain，使用 Genoss 统一 AI 接口**](https://blog.langchain.com/unifying-ai-endpoints-with-genoss/)