---
title: "LangChain 🤝 DemoGPT: New Era for Gen-AI Applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/langchain-demogpt-new-era-for-gen-ai-applications/"
date: "2023-08-21"
scraped_at: "2026-03-03T08:52:25.066727488+00:00"
language: "en-zh"
translated: true
---
&#123;% raw %}

_Editor's Note: This post was written in collaboration with the [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) team. We're excited about what they're doing to make it easier to not only build LLM applications, but also get them in the hands of users and build community in the process. We also thought way they built the platform on top of LangChain and Streamlit is really neat–their under-the-hood walkthrough offers some cool ideas for anyone using a language model to generate an app._

_编辑注：本文由 [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) 团队与本文作者协作完成。我们非常欣喜地看到，DemoGPT 正在努力降低大语言模型（LLM）应用的开发门槛——不仅让构建过程更简单，更致力于将这些应用快速交付给终端用户，并在此过程中培育活跃的开发者社区。此外，我们也十分欣赏其基于 LangChain 和 Streamlit 构建平台的技术路径——他们提供的底层实现详解，为所有希望利用语言模型自动生成应用程序的开发者提供了诸多富有启发性的思路。_

Today we’re happy to announce the collaboration of [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) with LangChain to make generative ai application creation easier. In this blog post, we’ll dig deeper into the details of this collaboration and how to use DemoGPT to build scalable LLM-powered applications with LangChain.

今天，我们很高兴地宣布 [DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) 与 LangChain 展开合作，共同简化生成式 AI 应用的开发流程。本文将深入探讨此次合作的具体细节，并介绍如何借助 DemoGPT，结合 LangChain 构建可扩展的、由大语言模型驱动的应用程序。

**DemoGPT: Emerging Marketplace for LangChain Applications**

**DemoGPT：面向 LangChain 应用的新兴应用市场**

DemoGPT is [an open-source project](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) that aspires to keep pushing the boundaries of Large Language Model (LLM) based application development. At its core, DemoGPT synergizes the capabilities of various Foundation Models, enabling the auto-generation of LangChain x Streamlit applications with just a prompt.

DemoGPT 是一个[开源项目](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com)，致力于持续拓展基于大语言模型（LLM）的应用开发边界。其核心能力在于协同调用多种基础模型（Foundation Models），仅需一条自然语言提示（prompt），即可自动构建 LangChain 与 Streamlit 融合的应用程序。

Here’s a look under the hood at how it works and where we see it going in the future.

接下来，让我们一探其技术内核，了解其工作原理，以及我们对其未来发展的展望。

**Unpacking DemoGPT: A Glimpse into its Technical Core**

**解构 DemoGPT：窥探其技术内核**

![](https://lh3.googleusercontent.com/GcLyXg-t0GXZXnDCAdvTivaujBdkat2MQpWSwVMVn3PeEImffOHp3TRqCqmVnItZyBwVjFVTxqKSt_6FVUPwM4ITHBcWC062rf8MgXSApPZ6fndRfSuVwCxDS9wBG0rOqBSG4lsfs2AjTrCkVAifEfc)

_DemoGPT Architecture_

_DemoGPT 架构图_

Navigating through the architecture of DemoGPT reveals a structured approach to code generation operations. This detailed exploration will take you through its core stages: Planning, Task Creation, Code Snippet Generation, Combining the Code Snippets, and DB Saving. Each stage plays a pivotal role in ensuring optimal functionality and efficiency. Let's delve into each of these components to understand the intricacies of DemoGPT's workflow.

深入剖析 DemoGPT 的架构，可见其代码生成流程具备高度结构化的设计。本次详细解析将带您依次了解其五大核心阶段：规划（Planning）、任务创建（Task Creation）、代码片段生成（Code Snippet Generation）、代码片段整合（Combining the Code Snippets）以及数据库持久化（DB Saving）。每个阶段均在保障系统功能完备性与运行高效性方面发挥着关键作用。接下来，我们将逐一深入各环节，全面理解 DemoGPT 的工作流精妙之处。

**Planning**: DemoGPT starts by generating a plan from the user's instruction.

**规划（Planning）**：DemoGPT 首先根据用户的指令生成一份执行计划。

When a user submits an instruction, its first port of call is the planning module.  
当用户提交一条指令时，该指令首先抵达规划模块。

This segment is the bedrock of the entire DemoGPT structure because the following steps lean heavily on the valid global planning inspired by HuggingGPT.  
这一模块是整个 DemoGPT 架构的基石，因为后续所有步骤都高度依赖于受 HuggingGPT 启发而生成的有效全局规划。

However, unlike HuggingGPT, which goes straight from instruction to task list, DemoGPT first creates a plan in natural language and later creates a task list. This way of processing is more intuitive for LLMs.  
然而，与 HuggingGPT（直接从指令生成任务列表）不同，DemoGPT 首先以自然语言形式生成一份计划，再据此生成任务列表。这种处理方式对大语言模型（LLM）而言更加直观。

The Planning module knows all of the available toolsets to minimize hallucinations. It also uses a self-refining strategy so that planning continues until it is validated by itself.  
规划模块知晓所有可用的工具集，从而最大限度减少幻觉（hallucination）。它还采用一种自优化策略：规划过程持续迭代，直至其自身验证通过为止。

![](https://lh5.googleusercontent.com/C4WNkha3dxIyw76DW0mDOgtozsBGJdXBKSTToQjbUryr7GXO6VKTnvmWqqBjD9fQF_6gPnNnVxXUfsm_jP7KbrwlDxSbiuLT1sogHu_FWxdmlD6oRjj5y492yQ6Lo4wHz65s18VsIgUncl3gp7u2H0w)

![](https://lh5.googleusercontent.com/C4WNkha3dxIyw76DW0mDOgtozsBGJdXBKSTToQjbUryr7GXO6VKTnvmWqqBjD9fQF_6gPnNnVxXUfsm_jP7KbrwlDxSbiuLT1sogHu_FWxdmlD6oRjj5y492yQ6Lo4wHz65s18VsIgUncl3gp7u2H0w)

**Task Creation:** It then creates specific tasks using the plan and instruction.  
**任务创建：** 接着，模块依据该计划与原始指令，生成具体、明确的任务。

In our experiments, we have seen that using a natural language plan minimizes hallucinations vs. going straight from instruction to task list. Our novel approach reduces the number of refining steps needed in the task creation process. This step also has a self-refining subphase to get rid of hallucinated tasks. During this subphase, the module checks the (input, output) pairs of each task, then according to the result, it gives feedback to itself, then generates the tasks again according to the last iteration and continues until it passes the tests.  
在我们的实验中发现，相较于直接从指令生成任务列表，采用自然语言计划能显著降低幻觉发生率。我们提出的这一新方法减少了任务创建过程中所需的优化迭代次数。该步骤还包含一个自优化子阶段，用于剔除幻觉任务。在此子阶段中，模块逐一检验每个任务的（输入，输出）对；根据检验结果向自身提供反馈，并基于上一轮迭代结果重新生成任务，如此反复，直至全部任务均通过校验。

![](https://lh3.googleusercontent.com/3HGdnyWZmQWB3iulnlfA3w6K2r3R7Rnus1gmpy277NME8kGi0yXBe-3C6D2k8yA76jpHRvzW1uEk5z871fG2FUGNVwTJli_fQhhAq_-GgvvVqL_aToPX7Uv1Cs9lpnnFAKYeXZpEo8lCxi8rro1rIjc)

![](https://lh3.googleusercontent.com/3HGdnyWZmQWB3iulnlfA3w6K2r3R7Rnus1gmpy277NME8kGi0yXBe-3C6D2k8yA76jpHRvzW1uEk5z871fG2FUGNVwTJli_fQhhAq_-GgvvVqL_aToPX7Uv1Cs9lpnnFAKYeXZpEo8lCxi8rro1rIjc)

**Code Snippet Generation:** Tasks are transformed into Python code snippets.  
**代码片段生成：** 各项任务被转化为 Python 代码片段。

Each task has its own prompt so that when the corresponding task is converted into a Python code, it uses its custom prompts for this transformation. The transformation process is mindful of previously generated code, so everything works well in tandem.  
每项任务均配有专属提示词（prompt），确保其在转换为 Python 代码时使用定制化的提示进行生成。该转换过程会参考此前已生成的代码，从而保障各部分代码协同一致、无缝衔接。

![](https://lh5.googleusercontent.com/YepUJFuvKwziOpG08WCAYKMZwC4OUEg0EqLzPvDpuHxevzHRoSLEmTVpWUzHWBmnw6e4qwMZeyAj2yZqm_ll6WTzdY4FimrEq70VV7s2CU0kJ38hZmPr4QUidYLLAi6F5lpItCXKYrvWLn12KtrRrG0)

![](https://lh5.googleusercontent.com/YepUJFuvKwziOpG08WCAYKMZwC4OUEg0EqLzPvDpuHxevzHRoSLEmTVpWUzHWBmnw6e4qwMZeyAj2yZqm_ll6WTzdY4FimrEq70VV7s2CU0kJ38hZmPr4QUidYLLAi6F5lpItCXKYrvWLn12KtrRrG0)

**Combining the Code Snippets:** The code snippets are combined into a final code, resulting in an interactive application.  
**代码片段整合：** 所有代码片段被整合为一份完整代码，最终生成一个可交互的应用程序。

All code snippets are put into a prompt to combine them together. Here, the final code is made compatible with Streamlit (such as state management). The output of this module is further improved by a self-refining technique to make sure everything is compatible with Streamlit.

所有代码片段被整合进一个提示词（prompt）中以实现统一。此处，最终生成的代码已适配 Streamlit（例如支持状态管理）。该模块的输出还通过自优化（self-refining）技术进一步改进，以确保全部内容均与 Streamlit 兼容。

![](https://lh5.googleusercontent.com/2jvKC6wfADHd1y5QlFfJOKTeKM7X6XQQ4D7SosHYq6OHRjE53Fka75DYNrg8kyO3-0Zs-P51R4XN_Sh0aAE1CIZ3S6-wbzZHYi9KyvFqFv-Qvbg96F4v-M5gL1UZB2bRavAHWM3bZXtUGHReyxxth20)

**DB Saving (coming in next release):** The generated plan, tasks and code snippets stored in a vector database

**数据库存储（DB Saving，将在下一版本发布）：** 将生成的计划、任务及代码片段存入向量数据库。

In the whole architecture, each phase is applying self-refining to itself to get rid of hallucinated results. In addition, each module has its own examples for few-shot learning and for most applications. This works pretty well and allows applications to be created by lighter models like GPT-3.5 at 10% of the cost of GPT-4. However, to decrease the cost even more and make it more performant, the DB Saving module aims to save the approved results (plans, tasks, and code snippets) to a vector database so that next time, the relevant examples from the vector database will be fetched and used for the few-shot learning to decrease the number of refining steps. This will decrease the cost of application generation and at the same time make generation faster.

在整个架构中，每个阶段均采用自优化机制，以消除幻觉（hallucinated）结果。此外，每个模块均配备专属的少样本学习（few-shot learning）示例，适用于大多数应用场景。该设计效果良好，使得开发者可借助更轻量级模型（如 GPT-3.5）构建应用，成本仅为 GPT-4 的 10%。然而，为进一步降低成本并提升性能，DB Saving 模块旨在将经审核确认的结果（包括计划、任务和代码片段）保存至向量数据库；后续运行时，系统将自动检索并向量数据库中相关的示例，用于少样本学习，从而减少自优化所需的迭代次数。此举既可降低应用生成成本，又能显著加快生成速度。

**How to Install DemoGPT?**

**如何安装 DemoGPT？**

[Installing DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) is a straightforward process, designed to get you up and running with minimal hassle.

[安装 DemoGPT](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) 流程简洁明了，旨在让您以最少的操作快速上手。

|     |
| --- |
| pip install demogpt |

|     |
| --- |
| pip install demogpt |

**How to Use DemoGPT?**

**如何使用 DemoGPT？**

You can use the DemoGPT library either via CLI or by using its Python interface.

您可通过命令行界面（CLI）或 Python 接口两种方式使用 DemoGPT 库。

1. **As a Command Line Interface (CLI)**

1. **作为命令行界面（CLI）**

You can run the DemoGPT application as a Streamlit app by simply typing:

你可以通过简单输入以下命令，以 Streamlit 应用的形式运行 DemoGPT：

|     |
| --- |
| demogpt |

|     |
| --- |
| demogpt |

Once running; enter your own API key and choose which base model you want to use.

启动后，请输入你自己的 API 密钥，并选择希望使用的基座模型。

When everything is ready, you can start creating applications just from a prompt. Let your imagination guide you. You can create a chat with your PDF app in seconds, or create a sentiment analysis tool that takes in a website and returns the tone of text.

一切准备就绪后，你只需提供一个提示（prompt），即可开始创建应用程序。让想象力为你引路：几秒钟内，你就能构建一个支持 PDF 文件交互的聊天应用；或开发一个情感分析工具，它能接收任意网站 URL，并返回网页文本的情感基调（tone）。

Applications are limited only by prompts given, so with longer prompts you too can create sophisticated and unique AI applications.

应用程序的能力边界仅取决于你提供的提示——因此，借助更详尽、更精准的提示，你同样可以构建出复杂而独特的 AI 应用。

![](https://lh5.googleusercontent.com/7QkQmarwI4pd7AmqE716lCtzfmUTJiKKvPPQgBCrIdcagX9fxDuiIzfMemb4JLwTB5wDRM67V3qNi3Jipfwfo67kQMmlRm_z0Rm0JNJtI6gbHIKoGTn2IuxLTVFDjk4GAr-N0aclb_5S_8bLe9CXidA)

![](https://lh5.googleusercontent.com/7QkQmarwI4pd7AmqE716lCtzfmUTJiKKvPPQgBCrIdcagX9fxDuiIzfMemb4JLwTB5wDRM67V3qNi3Jipfwfo67kQMmlRm_z0Rm0JNJtI6gbHIKoGTn2IuxLTVFDjk4GAr-N0aclb_5S_8bLe9CXidA)

_Tweet Generator: An application that can generate tweets from given hashtags and tone of the tweet._

_推文生成器：一款可根据指定话题标签（hashtag）与所需语气自动生成推文的应用。_

![](https://lh5.googleusercontent.com/22Js760o7xfn9G8SIm2mmoubWWNg8NeejibKp6rpZPWVC0jE3lYnK2_nNYb-_BG3_f4aCE_F1mnFZmZQuNZ5mg9QiwMtrWnt7NfR9q_MOuHWrbCawY22KlAUe6eE8zPU9mAEp6oClu0CmMjY1kT4mmk)

![](https://lh5.googleusercontent.com/22Js760o7xfn9G8SIm2mmoubWWNg8NeejibKp6rpZPWVC0jE3lYnK2_nNYb-_BG3_f4aCE_F1mnFZmZQuNZ5mg9QiwMtrWnt7NfR9q_MOuHWrbCawY22KlAUe6eE8zPU9mAEp6oClu0CmMjY1kT4mmk)

_Web Blogger: An application that can generate Medium blog from given website url_

_网络博主助手：一款可根据给定网站 URL 自动生成 Medium 风格博客文章的应用。_

1. **As a Python Library**  

1. **作为 Python 库**

You can run the DemoGPT application as a Python library. To incorporate DemoGPT into your Python applications, follow the steps below.

您可将 DemoGPT 应用作为 Python 库运行。如需在您的 Python 应用中集成 DemoGPT，请按以下步骤操作。

#### Import the necessary module:

#### 导入必要模块：

|     |
| --- |
| from demogpt import DemoGPT |

#### Instantiate the DemoGPT agent

#### 实例化 DemoGPT 智能体

|     |
| --- |
| agent = DemoGPT(model\_name="gpt-3.5-turbo-0613", openai\_api\_key="YOUR\_API\_KEY", max\_steps=10) |

#### Set your instruction and title

#### 设置指令与标题

|     |
| --- |
| instruction = "Your instruction here"<br>title = "Your title here" |

#### Iterate through the generation stages and extract the final code

#### 遍历生成阶段并提取最终代码

|     |
| --- |
| code = ""<br>for phase in agent(instruction=instruction, title=title):<br>    print(phase)  \# This will display the resulting JSON for each generation stage.<br>if phase\["done"\]:<br>        code = phase\["code"\]  \# Extract the final code.<br>print(code) |

For further information, you can visit [DemoGPT Docs](https://docs.demogpt.io/?ref=blog.langchain.com)

如需了解更多详情，欢迎访问 [DemoGPT 文档](https://docs.demogpt.io/?ref=blog.langchain.com)

**From Idea to Marketplace: The Journey with LangChain x DemoGPT**

**从创意到应用市场：LangChain × DemoGPT 的协作之旅**

To provide a clearer picture of this collaboration, let's walk through a potential user journey:

为更清晰地展现此次合作，让我们一起梳理一位典型用户的使用旅程：

Imagine Sarah, an AI enthusiast with a brilliant idea for an application that leverages the power of language models. She visits the LangChain website, where she's introduced to the integrated DemoGPT application generation tool.

设想这样一位用户——Sarah，一位热衷于人工智能的爱好者，她有一个绝妙的应用构想，希望借助大语言模型的强大能力来实现。她访问 LangChain 官网，在那里首次接触到深度集成的 DemoGPT 应用生成工具。

![](https://lh3.googleusercontent.com/jdLNjFP8Ek1qILUBef6tr84PHsbHsz1sk76iyeyrgYkl9XfHW_GEM0kl7Hk-rBzB21noOGN--b2vHTOL460p0-LGeYWI8LDJKRe2LU76CM5WRccKpZ33L8q2-G3VJpbPha5UpChBiDHX8n_dHtxckt8)

_As a first step, app generation occurs on LangChain website_

_第一步：应用生成在 LangChain 官网完成_

With a few prompts and inputs, Sarah crafts her application, watching it come to life in real-time. Once satisfied with her creation, Sarah is presented with the opportunity to showcase her application on the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). With a simple click, her application is listed, making it accessible to a global audience.

仅需输入几条提示词（prompts）和必要信息，Sarah 即可构建出自己的应用，并实时见证其逐步成型。当她对成果感到满意后，系统随即邀请她将该应用发布至 [DemoGPT 应用市场](https://marketplace.demogpt.io/?ref=blog.langchain.com)。只需一次点击，她的应用便正式上架，面向全球用户开放使用。

![](https://lh5.googleusercontent.com/km9yaKnGI5_cHRk8F1w20UGBTWzx6fxrIvUHxCGFigsAtIrvxjY6y2IaEY_RuVTA6H3-18_iATyQjqKfmEUpRxq7KU1i5pEcbJ4szPJwze5VKQL6tSEwmkwYzgNbJ8dZx1MMYUju0oFieG4lJpN8mJY)

_Once the app is generated, it will be listed on DemoGPT Marketplace_

_应用生成完成后，将自动上架至 DemoGPT 应用市场_

Other developers, businesses, or AI enthusiasts can now discover Sarah's application, interact with it, provide feedback, or even propose collaborative enhancements.

如今，其他开发者、企业或 AI 爱好者均可发现 Sarah 的应用，亲身体验其功能、提交反馈，甚至提出协同优化建议。

_All the generated apps will be listed and used on_ [_DemoGPT Marketplace_](https://marketplace.demogpt.io/?ref=blog.langchain.com)

所有生成的应用程序都将在 [_DemoGPT 市场_](https://marketplace.demogpt.io/?ref=blog.langchain.com) 上列出并投入使用。

Furthermore, the marketplace offers Sarah the chance to monetize her application, either through licensing or API sales. As her application gains traction, she receives feedback from the community, leading her back to the LangChain website to iterate and refine her application, ensuring it remains relevant and valuable to its users.

此外，该市场还为 Sarah 提供了通过授权许可或 API 销售等方式将其应用程序变现的机会。随着她的应用逐渐获得用户关注，她将收到来自社区的反馈，进而回到 LangChain 官网持续迭代与优化应用，确保其始终契合用户需求、保持价值。

This cyclical process of creation, showcase, feedback, and refinement ensures that the LangChain x DemoGPT ecosystem remains vibrant, innovative, and user-centric.

这一“创建 → 展示 → 反馈 → 优化”的闭环流程，保障了 LangChain × DemoGPT 生态系统始终充满活力、持续创新，并以用户为中心。

**The Power of Collaboration: LangChain x DemoGPT**

**协作的力量：LangChain × DemoGPT**

One of the most exciting prospects of our collaboration is the emergence of the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). We envision the DemoGPT Marketplace as a platform where the LangChain community, alongside developers and AI enthusiasts globally, can create, showcase, exchange, and even monetize their auto-generated applications.

本次合作最令人振奋的成果之一，便是 [DemoGPT 市场](https://marketplace.demogpt.io/?ref=blog.langchain.com) 的诞生。我们构想中的 DemoGPT 市场，是一个面向 LangChain 社区、全球开发者及 AI 爱好者的平台——在这里，用户可自主创建、公开展示、自由交换，甚至对自动生成的应用程序进行商业化变现。

This marketplace will be more than just a platform; it will be a vibrant community and a space where LangChain users can collaborate, iterate, and refine applications, ensuring that our ecosystem remains dynamic, user-centric, and on the cutting edge of technological advancements. With the added interactivity and user experience enhancements brought by Streamlit, these applications will promise to be not just functional but truly transformative.

这个市场远不止是一个技术平台；它更是一个蓬勃发展的社区，一个 LangChain 用户协同合作、持续迭代与精进应用的空间，从而确保我们的生态系统始终保持动态演进、以用户为核心，并始终站在技术创新的前沿。借助 Streamlit 带来的增强交互性与用户体验优化，这些应用不仅功能完备，更将真正实现变革性突破。

**What’s Next?**

**下一步是什么？**

As users craft their unique applications on LangChain, we hope and envision that these innovative creations will find a new home on the [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com). This platform will be set to become a bustling hub where these auto-generated applications are prominently listed and showcased. It will not just be about giving visibility to the applications but also creating a space where a broader audience can discover, interact with, and derive value from these tools.

当用户在 LangChain 上打造独具个性的应用程序时，我们热切期盼并坚信：这些富有创意的成果将在 [DemoGPT 市场](https://marketplace.demogpt.io/?ref=blog.langchain.com) 找到全新的归属。该平台将发展成为一个热闹非凡的中心枢纽，让这些自动生成的应用程序得以显著列示与集中展示。这不仅关乎提升应用的曝光度，更在于构建一个广阔空间——让更广泛的受众能够发现、使用并切实从中获益。

The vision behind this collaboration is to establish a synergistic ecosystem. By enabling application generation on LangChain and providing a platform for discovery on the DemoGPT Marketplace, we aim to bridge the gap between creators and consumers.

此次合作的愿景，是构建一个协同增效的生态系统：通过 LangChain 实现应用的高效生成，并依托 DemoGPT 市场提供便捷的发现渠道，我们致力于弥合创作者与使用者之间的鸿沟。

Collaboration between LangChain and DemoGPT can be a really huge step for the LLM world!

LangChain 与 DemoGPT 的携手合作，有望成为大语言模型（LLM）领域的一次重大飞跃！

We encourage our community to share their feedback, insights, and experiences on [LangChain Discord channel](https://discord.gg/Hc6QyDYr?ref=blog.langchain.com). Your input is invaluable to us, and it will play a pivotal role in shaping the future of this collaboration.

我们诚挚邀请社区成员在 [LangChain Discord 频道](https://discord.gg/Hc6QyDYr?ref=blog.langchain.com) 分享您的反馈、见解与使用体验。您的意见对我们至关重要，将对本次协作的未来发展起到关键性作用。

For more detailed information, advanced configurations, or troubleshooting, you can always refer to the [DemoGPT GitHub repository](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) or [DemoGPT Marketplace](https://marketplace.demogpt.io/?ref=blog.langchain.com) and consider giving a star.

如需获取更详细的信息、高级配置说明或故障排查指南，您可随时查阅 [DemoGPT GitHub 仓库](https://github.com/melih-unsal/DemoGPT?ref=blog.langchain.com) 或 [DemoGPT 应用市场](https://marketplace.demogpt.io/?ref=blog.langchain.com)，并欢迎为项目点亮一颗 Star ⭐。
&#123;% endraw %}
