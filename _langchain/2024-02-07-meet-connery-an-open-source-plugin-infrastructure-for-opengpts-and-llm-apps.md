---
title: "Meet Connery: An Open-Source Plugin Infrastructure for OpenGPTs and LLM apps"
source: "LangChain Blog"
url: "https://blog.langchain.com/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/"
date: "2024-02-07"
scraped_at: "2026-03-03T08:15:53.430432935+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
&#123;% raw %}

**_Editor's Note: this blog was written by Michael Liebmann and Volodymyr Machula, co-founders of Connery._**  
**_编者注：本文由 Connery 联合创始人 Michael Liebmann 和 Volodymyr Machula 撰写。_**

[**_Connery_**](https://github.com/connery-io/connery?ref=blog.langchain.com) **_is an open-source framework for creating integrations as plugins usable across many platforms, including as tools for LLM-powered agents!_**  
[**_Connery_**](https://github.com/connery-io/connery?ref=blog.langchain.com) **_是一个开源框架，用于将系统集成开发为插件，可跨多个平台复用——包括作为 LLM 驱动智能体（agents）的工具！_**

Over the past decade, Volodymyr and I have created all sorts of integrations. This includes everything from traditional system integrations and customizations to creating plugins for LLM applications, CI/CD workflows, Slack, and no-code tools.  
过去十年间，Volodymyr 和我开发了各类集成方案——从传统的系统集成与定制化开发，到面向 LLM 应用、CI/CD 流水线、Slack 以及无代码工具的插件开发。

It’s always been the same pain points. So, we decided to make a change and wrap our experience into an open-source project called [Connery](https://github.com/connery-io/connery?ref=blog.langchain.com), allowing everyone to benefit from it!  
我们始终面临相同的核心痛点。因此，我们决定做出改变，将多年积累的经验沉淀为一个名为 [Connery](https://github.com/connery-io/connery?ref=blog.langchain.com) 的开源项目，让所有人皆可从中受益！

Connery provides a plugin infrastructure tailored for LLM applications, enabling easy integration with third-party services and customizing them. It manages the runtime, integrates seamlessly with [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?ref=blog.langchain.com), and provides a user interface for connection management, personalization, and safety.  
Connery 提供专为 LLM 应用设计的插件基础设施，支持轻松对接第三方服务并实现灵活定制。它统一管理插件运行时环境，与 [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?ref=blog.langchain.com) 无缝集成，并提供图形化用户界面，用于连接管理、个性化配置及安全管控。

In addition, Connery is building out tooling and developer experience for an open-source plugin ecosystem. The goal is to allow the community to benefit from creating, sharing, and customizing each others’ plugins.  
此外，Connery 正在构建面向开源插件生态的配套工具链与开发者体验。其目标是赋能社区——让开发者能够便捷地创建、共享并定制彼此的插件。

## **Problem: Integrating LLMs with Real-World Applications**  
## **问题：将大语言模型（LLM）与真实世界应用相集成**

LLM-based apps, like chatbots and assistants, are becoming increasingly useful for reasoning or generative tasks. However, enabling LLM apps to directly execute real-world tasks is a much larger opportunity. While this is still a struggle, there is no question that this is becoming a major trend.  
基于大语言模型（LLM）的应用（如聊天机器人与智能助手）在推理与生成类任务中正日益展现出强大价值。然而，让 LLM 应用直接执行真实世界中的具体任务，才蕴含着更为广阔的发展机遇。尽管当前仍面临诸多挑战，但这一方向无疑已成为主流趋势。

Applications for general use, like business or personal assistants (think of something similar to Tony Stark's J.A.R.V.I.S.), may need numerous integrations with external systems. Likewise, agents focused on specific fields like DevOps, HR, finance, or shopping become more effective when they can perform real-world tasks.  
面向通用场景的应用——例如企业级或个人助理（可类比托尼·斯塔克的 J.A.R.V.I.S.）——往往需要与大量外部系统进行集成。同理，专注于 DevOps、人力资源、金融或电商等垂直领域的智能体（agents），一旦具备执行真实世界任务的能力，其效能也将显著提升。

However, compared to conventional applications, LLM-based apps are somewhat unpredictable due to potential hallucinations and incorrect decisions. Consequently, integrating LLMs into real-world scenarios demands additional safety measures and extra consideration.  
然而，相较于传统应用，LLM 应用因存在幻觉（hallucination）与错误决策等固有风险，行为更具不确定性。因此，将 LLM 集成至真实世界场景中，必须引入额外的安全保障机制，并给予更审慎的考量。

Moreover, building and running integrations is generally complex. It's even more so with integrations into LLM-based apps that require a specialized infrastructure.  
此外，构建与运行集成本身已属复杂工程；而面向 LLM 应用的集成则更为棘手——它要求一套专门适配的基础设施支撑。

Below, we list some important challenges you need to consider as a developer while integrating your LLM-based app with the real world.

以下，我们列出开发者在将基于大语言模型（LLM）的应用接入真实世界时需要重点考虑的一些关键挑战。

### **Personalization and security**

### **个性化与安全性**

Personalization of LLM apps is an important driver for AI development in 2024. This allows LLMs to bring more individual value to their users. It also means an LLM app can directly interact with the users’ individual services, such as sending emails, accessing calendars, etc. This requires essential integration and personalization features:

2024 年，LLM 应用的个性化是推动人工智能发展的重要驱动力。它使大语言模型能够为用户带来更具个体价值的服务；同时也意味着 LLM 应用可直接与用户个人服务（例如发送邮件、访问日历等）交互。这要求应用具备关键的集成与个性化能力：

- **User authentication, authorization,** and a **user interface** to manage connections and personalization.  
- **用户身份认证（Authentication）、授权（Authorization）**，以及用于管理连接与个性化设置的**用户界面**。

- **Connection management**: Users need a secure way to authorize AI-powered apps to access their services, such as Gmail, using OAuth. For services not supporting OAuth, like AWS, secure storage of access keys is essential through **Secrets Management**.  
- **连接管理**：用户需通过安全方式（如 OAuth）授权 AI 应用访问其服务（例如 Gmail）。对于不支持 OAuth 的服务（如 AWS），则必须借助**密钥管理（Secrets Management）**安全地存储访问密钥。

- **Personalization**: The user can configure and personalize integrations. For example, specify a custom signature for all the emails. Or personalize metadata for actions so LLMs better understand the personal use case. They can also provide personal information such as name and email so LLMs can use it as additional context when calling actions.  
- **个性化**：用户可配置并定制各项集成功能。例如，为所有邮件指定自定义签名；或为操作（actions）定制元数据（metadata），帮助 LLM 更好地理解用户的个性化使用场景；用户还可提供姓名、邮箱等个人信息，供 LLM 在调用操作时作为额外上下文使用。

### **AI safety and control**

### **AI 安全性与可控性**

Traditional applications have well-defined functions that can be predicted and tested, ensuring consistent operation. In contrast, LLM-based apps are unpredictable due to their natural language capabilities, leading to potential risks like misinterpreted commands. To mitigate this, additional measures are needed:

传统应用程序具有明确定义的功能，可预测、可测试，从而保障运行的一致性；而基于 LLM 的应用因其自然语言能力而具有不可预测性，可能导致指令误读等潜在风险。为此，需采取额外措施加以应对：

- **Metadata** allows LLMs to better understand available actions and consequently reduce the error rate in selecting and executing them. It includes an action description with a clear purpose, an input schema describing the available parameters and validation rules, and the action outcome.  
- **元数据（Metadata）** 可帮助 LLM 更准确地理解可用操作，从而降低操作选择与执行过程中的出错率。元数据包括：清晰阐明用途的操作描述、说明可用参数及校验规则的输入 Schema，以及操作执行后的结果。

- **Human-in-the-loop** capability to empower the user with the final say in executing actions for critical workflows. This should also allow for editing suggested input parameters before running an action — for example, reviewing an email before sending.  
- **人工介入（Human-in-the-loop）** 能力，赋予用户对关键业务流程中操作执行的最终决定权。该能力还应支持在执行操作前编辑系统建议的输入参数——例如，在发送邮件前先行审阅。

- **Audit logs** for consistency, compliance, and transparency.  
- **审计日志（Audit logs）**，以保障系统行为的一致性、合规性与透明度。

### **Infrastructure for integrations**

### **集成所需的基础设施**

LangChain provides a great framework for building LLM applications. On the other hand, adding _integrations_ into such LLM apps is quite different and comes with its own complexity.

LangChain 为构建 LLM 应用提供了优秀的框架；然而，在此类 LLM 应用中加入**集成能力（integrations）**则是一项截然不同的任务，且本身具有相当的复杂性。

Currently, developers need to build their own custom integration infrastructure within their app in order to integrate it with the real world. This includes:  

目前，开发者需在自身应用内构建专属的集成基础设施，才能实现与真实世界的对接。该基础设施包括：

- **Authorization for integrations** with third-party services using OAuth, API Keys, etc.  
- 使用 OAuth、API 密钥等方式对第三方服务进行集成授权。

- **Support different integration types** **and patterns** like CRUD operations, async operations, event-driven operations, etc.  
- 支持多种集成类型与模式，例如 CRUD 操作、异步操作、事件驱动操作等。

- **Support integration code** and its runtime  
- 支持集成代码及其运行时环境。

Most of these items are a hassle when building LLM-powered apps with integrations and distract builders from their main goals.  
上述大多数事项在构建具备集成能力的 LLM 应用时十分繁琐，反而使开发者偏离其核心目标。

## **Proposed solution: open-source plugin infrastructure and ecosystem**  
## **提议的解决方案：面向 OpenGPTs 与 LLM 应用的开源插件基础设施及生态体系**

To address the problems mentioned above, we believe building a **plugin infrastructure** for LLM apps and GPTs with the following characteristics is the best approach:  
为解决上述问题，我们认为，构建一套具备以下特性的、面向 LLM 应用与 GPT 的**插件基础设施**，是最佳路径：

- First, it must be open-source.  
- 首先，它必须是开源的。

- Second, it must have a collaboration model.  
- 其次，它需具备协作机制。

We hope this will grow into an open plugin community and facilitate speed and innovation, unlike many closed-source approaches. This is our primary driver for why and how we build Connery.  
我们希望这一基础设施能逐步发展为一个开放的插件社区，从而加速开发进程、激发创新活力——这与许多闭源方案截然不同。这也正是我们为何以及如何构建 Connery 的核心驱动力。

![](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_001.jpg)Connery components, stakeholders, and their interactions.  
![](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_001.jpg)Connery 的各组件、相关方及其交互关系。

We'll go over the subcomponents of each component in the above diagram next.  
接下来，我们将逐一介绍上图中各组件的子模块。

### **Plugin ecosystem**  
### **插件生态系统**

On the ecosystem side, we have two pieces:  
在生态系统层面，我们包含两个部分：

- **Actions**  
- **操作**：将“操作”视为一项基本任务，类似于带有输入和输出参数的函数，专为完成某一件特定事情而设计。例如，“发送邮件”就是“Gmail”插件中的一项操作。

- **Plugins** are a collection of related actions. Each plugin is represented by an open-source GitHub repository with TypeScript code of a specific structure. A plugin must be installed on the Runner before its actions can be used.  
- **插件** 是一组相关操作的集合。每个插件均以一个开源 GitHub 仓库形式呈现，其中包含符合特定结构的 TypeScript 代码。插件必须先安装到 Runner 上，其内部的操作才能被调用使用。

💡  

For the rest of the article, we will be using the term plugin instead of integration. That is because a plugin is _more_ than an integration. It is a self-contained module that comes with a specific set of features to simplify and improve the integration of third-party APIs (more details below).  
💡  
本文后续将统一使用“插件（plugin）”一词，而非“集成（integration）”。这是因为插件 *远不止* 是一种集成——它是一个自包含的模块，自带一套特定功能，旨在简化并提升第三方 API 的接入体验（详见下文）。

### **Plugin infrastructure**  
### **插件基础设施**

- **The Runner** is the heart of Connery. It's an open-source engine that integrates plugins from GitHub. It’s equipped with a user interface and a set of features for connection management, personalization, and safety. Everyone can set up their own isolated Runner, uniquely configured with a set of plugins and a standardized API for clients.  
- **Runner** 是 Connery 的核心。它是一个开源引擎，用于从 GitHub 集成插件。Runner 内置用户界面，并提供连接管理、个性化配置与安全控制等功能。任何人都可部署一套独立隔离的 Runner，按需配置插件组合，并通过标准化 API 供各类客户端调用。

- **Clients** are the user-facing aspect of Connery, serving as the interface through which end-users can trigger actions. [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?tab=readme-ov-file&ref=blog.langchain.com) from LangChain, for example, allow the end users to deeply customize and personalize their GPTs by connecting them to the real world with Connery actions. Connery also provides Clients for many other platforms.  
- **客户端（Clients）** 是 Connery 面向用户的交互层，作为终端用户触发操作的入口界面。例如，LangChain 提供的 [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?tab=readme-ov-file&ref=blog.langchain.com)，允许终端用户通过 Connery 操作将 GPT 连接到真实世界，从而深度定制与个性化其 GPT。Connery 同样为众多其他平台提供了配套客户端。

### **Developer and user perspectives**  
### **开发者与终端用户视角**

- **Developers** have the flexibility to create their own plugins or utilize existing ones from the community. Plugins can easily be integrated into LLM apps, like chatbots or assistants, through Connery clients, e.g., OpenGPTs, a LangChain Toolkit, API, or others.  
- **开发者** 可灵活选择：自行开发插件，或直接复用社区已有的插件。借助 Connery 客户端（如 OpenGPTs、LangChain 工具包、API 等），插件可轻松集成至各类大语言模型应用（如聊天机器人、智能助手等）。

- **End-users** of the LLM app first personalize their experience on the Runner by connecting to their personal accounts, like Gmail, and providing other personal information. Then, authorize the LLM app to use the personalized Runner. Once done, the user can ask the LLM app to execute actions on their behalf, like sending emails, still controlling what the app does, and having the final say if needed.  
- **大语言模型应用的终端用户** 首先需在 Runner 上完成个性化设置，例如连接个人账户（如 Gmail）并提供其他必要信息；随后授权该 LLM 应用使用已个性化的 Runner。完成授权后，用户即可请求 LLM 应用代为执行操作（如发送邮件），全程保有对应用行为的控制权，并可在必要时行使最终决定权。

## **Example: Running Connery actions from OpenGPTs**  
## **示例：从 OpenGPTs 调用 Connery 操作**

The recent updates to LangChains [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?ref=blog.langchain.com) provide support for different cognitive architectures. The new ‘assistants’ feature offers an easy method for integrating tools, such as Connery actions, into custom GPTs. Let's jump into a brief example:  
LangChain 最近对 [OpenGPTs](https://github.com/langchain-ai/OpenGPTs?ref=blog.langchain.com) 的更新，增强了对多种认知架构的支持。“助手（assistants）”这一新功能，为将工具（如 Connery 操作）集成至自定义 GPT 提供了便捷途径。下面我们来看一个简短示例：

### **Summarize a webpage and send it by email**  
### **网页摘要并邮件发送**

Imagine you've found an insightful article on Paul Graham's website and want to share a concise summary of it with a colleague via email. This could involve two actions from two different plugins:

想象你在 Paul Graham 的网站上发现了一篇富有洞见的文章，想通过电子邮件向同事分享一篇简洁的摘要。这可能需要调用两个不同插件中的两项操作：

1. **Summarize public webpage** action from the [Summarization plugin](https://github.com/connery-io/summarization-plugin?ref=blog.langchain.com). This action takes a public webpage URL and generates a brief summary of the article using OpenAI.  
1. 来自 [Summarization 插件](https://github.com/connery-io/summarization-plugin?ref=blog.langchain.com) 的 **“Summarize public webpage”（摘要公开网页）** 操作。该操作接收一个公开网页 URL，并利用 OpenAI 生成文章的简明摘要。

2. **Send email** action from the [Gmail plugin](https://github.com/connery-io/gmail?ref=blog.langchain.com). It takes the recipient, subject, and body as input parameters and sends the email to the recipient.  
2. 来自 [Gmail 插件](https://github.com/connery-io/gmail?ref=blog.langchain.com) 的 **“Send email”（发送邮件）** 操作。它以收件人、主题和正文为输入参数，将邮件发送给指定收件人。

### **Try demo**

### **试用演示**

[Here](https://opengpts-example-vz4y4ooboq-uc.a.run.app/?ref=blog.langchain.com), you'll find a demo version of OpenGPTs hosted by LangChain. It comes with a preconfigured Connery Runner and all the necessary actions for our demo. You can summarize any article you like and send it to your email, like in the following video(note that for demo purposes, the context window has a 16K token limit):

[此处](https://opengpts-example-vz4y4ooboq-uc.a.run.app/?ref=blog.langchain.com) 提供了 LangChain 托管的 OpenGPTs 演示版本。该演示已预配置 Connery Runner，并集成了本演示所需的所有操作。你可以任意选择一篇文章进行摘要，并将其发送至你的邮箱——正如以下视频所示（请注意：出于演示目的，上下文窗口限制为 16K token）：

[Summarize a webpage and send it by email from OpenGPTs using Connery actions](https://www.youtube.com/watch?v=ok4z-Ox-1_o&ref=blog.langchain.com)  
[使用 Connery 操作，通过 OpenGPTs 摘要网页并以邮件形式发送](https://www.youtube.com/watch?v=ok4z-Ox-1_o&ref=blog.langchain.com)

### **What happens behind the scenes?**

### **幕后发生了什么？**

Below is a simplified process of what happens behind the scenes in the demo:

以下是该演示背后所发生流程的简化说明：

1. **The User sends a request** to the OpenGPT by submitting a prompt.  
1. **用户提交提示（prompt）**，向 OpenGPT 发起请求。

2. **OpenGPT pulls actions:** The OpenGPT connects to Connery Runner through the [LangChain Toolkit](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com) and requests all available actions along with their metadata like action name, description, input names, descriptions, etc.  
2. **OpenGPT 获取可用操作：** OpenGPT 通过 [LangChain Toolkit](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com) 连接到 Connery Runner，并请求所有可用操作及其元数据（例如操作名称、描述、输入参数名、参数描述等）。

3. **Runner prepares actions:** The Runner downloads the source code for each plugin from their GitHub repositories and caches it locally for later use. After downloading, the Runner takes all available actions of these plugins and sends their info back to the OpenGPT.  
3. **Runner 准备操作：** Runner 从各插件对应的 GitHub 仓库下载源代码，并在本地缓存以供后续调用。下载完成后，Runner 收集这些插件中全部可用操作的信息，并将其返回给 OpenGPT。

4. **OpenGPT calls action:** The OpenGPT uses the actions’ metadata to identify a suitable action and its input parameters based on the user's prompt. When the action is identified, and the OpenGPT decides to execute it, the OpenGPT sends a request to the Runner.  
4. **OpenGPT 调用操作：** OpenGPT 基于用户提示，结合操作元数据识别出最匹配的操作及其所需输入参数。一旦确定目标操作并决定执行，OpenGPT 即向 Runner 发送调用请求。

5. **Runner runs action:** The Runner loads the plugin's source code from the cache, finds the action, and runs it with the provided parameters. When the result is ready, the Runner returns it to the OpenGPT.  
5. **Runner 执行操作：** Runner 从本地缓存加载插件源代码，定位对应操作，并以提供的参数运行该操作。结果就绪后，Runner 将其返回给 OpenGPT。

6. **OpenGPT uses the result:** OpenGPT then uses these results to finish its task. It continues the process until the user request is completed. This may include calling multiple actions, as seen in the demo.  
6. **OpenGPT 使用结果：** OpenGPT 利用这些结果完成当前任务。该过程持续进行，直至用户请求完全满足。如演示所示，此过程可能涉及多次调用不同操作。

### **Set up your own OpenGPT with Connery actions**

### **使用 Connery 操作搭建你自己的 OpenGPT**

To configure your own OpenGPT and actions, perform the following steps:  
请按以下步骤配置你自己的 OpenGPT 及相关操作：

1. 使用 [快速入门](https://docs.connery.io/docs/runner/quick-start/?ref=blog.langchain.com) 指南设置 Connery Runner。  
1. Use the [Quickstart](https://docs.connery.io/docs/runner/quick-start/?ref=blog.langchain.com) guide to set up the Connery Runner.

2. 安装您希望在智能体（agent）中使用的插件及其对应的操作（actions）。  
2. Install plugins with the actions you want to use in your agent.

3. Fork [OpenGPTs 仓库](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com)，并按照 README 中的说明进行配置。  
3. Fork the [OpenGPTs repo](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com) and configure it as specified in the README.

4. 在 OpenGPTs 的 `.env` 文件中指定 `CONNERY_RUNNER_URL` 和 `CONNERY_RUNNER_API_KEY` 环境变量，以将其连接至您的 Connery Runner。  
4. Specify the `CONNERY_RUNNER_URL` and `CONNERY_RUNNER_API_KEY` environment variables in the `.env` file of the OpenGPTs to connect it to your Connery Runner.

💡  

💡  

如果您希望在自己的应用和智能体中使用 Connery 操作，可使用我们的 [LangChain Toolkit](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com)（支持 [Python](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com) 和 [JS](https://js.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com)）。  
If you want to use Connery actions in your own apps and agents, you can use our [LangChain Toolkit](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com) for [Python](https://python.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com) and [JS](https://js.langchain.com/docs/integrations/toolkits/connery?ref=blog.langchain.com).

## **下一步计划**  

## **Next Steps**

目前，我们正在**开发上述功能**。我们非常期待听到您的**反馈**，以便为社区优先实现最重要的功能。欢迎在 GitHub 的 [讨论区](https://github.com/connery-io/connery/discussions?ref=blog.langchain.com) 中分享您的想法。  
Currently, we are **building out the features** mentioned above. We would love to hear your **feedback** to prioritize the most important ones for the community. Please let us know what you think in our [discussions board](https://github.com/connery-io/connery/discussions?ref=blog.langchain.com) on GitHub.

除持续完善必要功能外，我们还计划在开源的 Runner 基础上提供一项**托管服务（managed service）**。我们的目标是简化集成流程，帮助用户更快速地调用操作（actions）。  
Besides building out the necessary features, we plan to offer a **managed service** on top of the open-sourced Runner. Our goal is to simplify the integration process and help using actions much faster.

Connery 插件及其操作均以独立的 GitHub 仓库形式存在，这使得共享与复用变得极为便捷。由此，我们构想了一个**持续壮大的去中心化开源插件生态系统**，赋予开发者自由创新与协作开发插件的能力。首批社区插件正在积极构建中。  
Connery plugins and their actions are individual GitHub repositories. This makes sharing and reuse very easy. With this, we envision a **growing decentralized open-source plugin ecosystem**, giving developers the freedom to innovate and collaborate on plugins. The first community plugins are being built.

如果您喜欢本项目，或希望及时获取最新动态，欢迎 [为 GitHub 仓库点亮一颗星 ⭐](https://github.com/connery-io/connery?ref=blog.langchain.com)。  
If you like the project or want to stay in the loop, [give the GitHub repo a star](https://github.com/connery-io/connery?ref=blog.langchain.com).

### 标签  

### Tags

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_002.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_003.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能发展现状报告](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_004.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能发展现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![推出 LangSmith 的 OpenTelemetry 支持](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_005.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**推出 LangSmith 的 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更简易的评估](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_006.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更简易的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/meet-connery-an-open-source-plugin-infrastructure-for-opengpts-and-llm-apps/img_007.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟
&#123;% endraw %}
