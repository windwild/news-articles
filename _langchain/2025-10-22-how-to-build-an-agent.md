---
render_with_liquid: false
title: "How to Build an Agent"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-to-build-an-agent/"
date: "2025-10-22"
scraped_at: "2026-03-03T07:21:59.710012103+00:00"
language: "en-zh"
translated: true
description: "Learn how to build an agent -- from choosing realistic task examples, to building the MVP to testing quality and safety, to deploying in production."
---
render_with_liquid: false
render_with_liquid: false

![](images/how-to-build-an-agent/img_001.png)

While seemingly every company is talking about building agents this year, far fewer have done it. It’s easy to let your imagination run wild with how agents can transform your business, but many teams are unsure where to begin, how to make progress, and where to set expectations.

今年，似乎每家公司都在热议“构建智能体（agent）”，但真正付诸实践的却少之又少。人们很容易畅想智能体将如何彻底变革自身业务，但许多团队却对“从何入手”“如何推进”以及“预期应设在何处”感到迷茫。

_In this guide, we’ll walk through a framework for going from idea to impact— illustrated with a real-world example of building an email agent._

_本指南将带您逐步掌握从构想到落地的系统性框架——并以构建一个邮件智能体（email agent）的真实案例加以说明。_

![](images/how-to-build-an-agent/img_002.png)Step-by-step diagram for process of building an agent

![](images/how-to-build-an-agent/img_002.png)构建智能体的分步流程图

## Step 1: Define your agent’s job with examples

## 第一步：用具体示例明确定义智能体的核心职责

**Choose something realistic and something that requires an agent.**

**选择一项既切实可行、又真正需要智能体来完成的任务。**

Pick something you could teach a smart intern. If your best intern could never complete the task given enough time and resources, the task may be unrealistic or too ambitious. Prove you can get the basics down before activating expert mode.

设想这项任务可以教给一位聪明的实习生。如果你最优秀的实习生即便拥有充足的时间和资源仍无法完成该任务，那么这项任务可能不切实际，或目标过于宏大。请先确保基础能力扎实，再开启“专家模式”。

Start by coming up with 5-10 concrete examples of the task. This serves two purposes:

首先，列出5–10个该任务的具体实例。此举具有双重意义：

- First, it validates that your idea is well-scoped - not too trivial or vague  
- 首先，验证您的构想范围是否合理——既不过于简单，也不流于空泛；  
- Second, gives you a benchmark for measuring performance later.  
- 其次，为您提供后续评估性能表现的基准参照。

### **Example: Building an Email Agent**

### **示例：构建一个邮件智能体**

At this step, we’d define what tasks our agent needs to handle, which likely includes:

在此步骤中，我们需要明确代理（agent）需要处理哪些任务，通常包括：

- Prioritize urgent emails from key stakeholders  
- 优先处理来自关键利益相关方的紧急邮件  

- Schedule meetings based on calendar availability  
- 根据日历空闲时段安排会议  

- Ignore spam or emails that don't require responses  
- 忽略垃圾邮件或无需回复的邮件  

- Answer product questions based on company documentation  
- 基于公司内部文档回答产品相关问题  

**Red flags to avoid:**  

**需避免的危险信号：**

- If you can’t come up with concrete examples, your scope is probably too broad.  
- 如果你无法列举出具体实例，说明你的任务范围可能过于宽泛。  

- Using an agent when traditional software would work better (e.g., when the logic is simple, fixed, and already implemented elsewhere) **.** Agents are slow, expensive, and can be finicky at times. If traditional software gets the job done - just use that!  
- 在传统软件更适用时仍强行使用代理（例如：逻辑简单、固定且已在其他系统中实现）。**代理运行缓慢、成本高昂，且有时表现不稳定。若传统软件已能胜任，请直接使用它！**  

- Expecting magic that doesn't exist (e.g., connecting to APIs or datasets that don’t exist or can’t be built yet)  
- 期待尚不存在的“魔法”功能（例如：对接尚未存在或短期内无法构建的 API 或数据集）  

## Step 2: Design operating procedure  

## 第二步：设计操作流程  

**Write up a detailed standard operating procedure (SOP), with step-by-step instructions for how a human would perform the task or process.**  

**编写一份详尽的标准操作流程（SOP），以分步说明人类将如何执行该任务或流程。**  

This step helps confirm that you’ve chosen a problem with a clear, reasonable scope. It also surfaces the key steps, decisions, and tools your agent will likely need to handle—laying the groundwork for what to build.  

这一步有助于确认你所选择的问题是否具备清晰、合理的边界；同时也能梳理出代理在执行过程中所需的关键步骤、决策点及工具，为后续开发奠定基础。  

### **Example: Building an Email Agent**  

### **示例：构建邮件代理（Email Agent）**  

For our email agent, a step-by-step procedure could look like below:  

以我们的邮件代理为例，其分步操作流程可如下所示：  

- Analyze email content and sender context to categorize response priority  
- 分析邮件正文内容与发件人背景信息，对响应优先级进行分类  

- Checks calendar availability; schedules video conference meeting  
- 查询日历空闲时段，并安排视频会议  

- Draft a response based on the email, sender, and scheduling context  
- 结合邮件内容、发件人身份及会议安排情况，草拟回复  

- Send the email after a quick human review and approval  
- 经人工快速审阅与批准后，发送该邮件

Writing this out helps ensure the task is scoped appropriately, and surfaces the tools and logic our agent will need to handle.

这样写下来有助于确保任务范围界定得当，并明确我们的智能体（agent）所需调用的工具与逻辑。

## Step 3: Build MVP with prompt

## 第三步：基于提示词构建最小可行产品（MVP）

Choosing a place to start is important. If your agent is complex, trying to do it all in one go is too ambitious. Start by designing the agent’s architecture outlined by the SOP: how it will flow, what decisions it needs to make, and where LLM reasoning is essential.

选择一个合适的切入点至关重要。如果你的智能体结构复杂，试图一步到位完成全部功能就过于激进。应首先依据标准操作流程（SOP）设计智能体的整体架构：明确其执行流程、需做出的关键决策，以及大语言模型（LLM）推理不可或缺的关键环节。

Then, build an MVP by focusing on the **most critical LLM reasoning task(s)** (e.g., classification, decision-making) and **creating a prompt that handles them well.** Most agents fail because the LLM can't reason well enough for the task. Getting a single prompt working with hand-fed data will help you build up confidence before proceeding to build the full agent. [Prompt engineering tools like LangSmith](https://docs.smith.langchain.com/prompt_engineering/how_to_guides?ref=blog.langchain.com) can help streamline this process, from managing prompt versions, to testing across scenarios or datasets, and tracking performance over time as you iterate.

接着，通过聚焦于**最关键的大语言模型推理任务**（例如：分类、决策）来构建 MVP，并**设计一个能高效处理这些任务的提示词（prompt）**。大多数智能体失败的根本原因在于：大语言模型在该任务上的推理能力不足。若能先让一个提示词在人工输入数据上稳定运行，将极大增强你的信心，为后续构建完整智能体奠定基础。[LangSmith 等提示工程工具](https://docs.smith.langchain.com/prompt_engineering/how_to_guides?ref=blog.langchain.com)可显著优化这一过程——无论是管理提示词版本、跨不同场景或数据集开展测试，还是在迭代过程中持续追踪性能表现。

**Keep it simple by:**

**保持简洁，可遵循以下原则：**

- Starting with manual inputs for any data or context the prompt needs (hold off on automation for now)  
  - 对提示词所需的所有数据或上下文，先采用人工输入方式（暂不引入自动化）  
- Testing against your outlined examples from Step 1 to validate performance across common use cases  
  - 使用第一步中梳理出的典型样例进行测试，以验证提示词在常见使用场景下的表现  
- Focusing on getting the LLM reasoning right  
  - 聚焦于提升大语言模型的推理质量  

### **Example: Building an Email Agent**

### **示例：构建邮件智能体**

At this stage, we’re identifying and solving _one_ high-leverage reasoning task to start with.

在此阶段，我们的目标是识别并率先解决**一个高杠杆率的推理任务**。

For our email agent, that might mean focusing just on **classifying emails by urgency and intent** (e.g., meeting request, support questions), as this is a foundational step that the rest of the agent depends on.

对我们的邮件智能体而言，这可能意味着仅聚焦于**按紧急程度和意图对邮件进行分类**（例如：会议邀约、技术支持咨询），因为这是整个智能体后续所有功能所依赖的基础环节。

Start by writing a core prompt that does just this, with hand-fed inputs like:  

首先编写一个核心提示词，专门实现上述单一功能，并辅以人工输入的数据，例如：

- Email content: _“Can we meet next week about LangChain’s product roadmap?”_  
- 邮件内容：_“我们下周能否就 LangChain 的产品路线图进行一次会议？”_

- Sender: “ _Jeff Bezos”, Title: “CEO of Amazon”_  
- 发件人：“_Jeff Bezos”，职位：“Amazon 首席执行官”_

- Output: _Intent = “Meeting Request”, Urgency = “High”_  
- 输出：_意图 = “会议请求”，紧急程度 = “高”_

Once the model consistently gets this right across your test cases, you’ll have confidence that the core logic is sound— **and a strong foundation to build on.**  
当模型在所有测试用例中均能稳定、准确地完成该任务时，你便可以确信其核心逻辑是可靠的——**并由此奠定坚实的基础，供后续持续构建与扩展。**

## Step 4: Connect & Orchestrate  

## 第四步：连接与编排

Now that we have a working prompt, it’s time to **connect the prompt to real data and user inputs.**  
如今我们已拥有一个可正常运行的提示词（prompt），下一步便是**将该提示词与真实数据及用户输入相连接。**

Start by identifying what context or data the prompt needs—such as email content, calendar availability, and documentation of products—and plan how to access it programmatically (e.g., via APIs, databases, or file systems).  
首先，明确提示词所需的具体上下文或数据——例如邮件正文、日历空闲时段、产品文档等——并规划如何通过编程方式获取这些信息（例如调用 API、查询数据库或读取文件系统）。

Then, write orchestration logic to connect the right data into your prompt. In simple cases, this might just mean passing inputs directly. For more complex workflows, you may need agentic logic to decide which data sources to query, when to call them, and how to combine their outputs before prompting the LLM.  
接着，编写编排逻辑，将恰当的数据注入提示词中。在简单场景下，这可能仅需直接传入输入参数；而在更复杂的流程中，则可能需要引入智能体（agent）逻辑，以动态决定：应查询哪些数据源、何时发起调用，以及如何整合各数据源的输出，再将其送入大语言模型（LLM）进行提示。

### **Example: Building an Email Agent**  

### **示例：构建一封邮件智能体（Email Agent）**

For our email agent, this step could involve integrating with the **Gmail API** (to read incoming emails), **Google Calendar API** (to check availability), and a **CRM or contact database** (to enrich sender context).  
对于我们的邮件智能体，本步骤可包括接入 **Gmail API**（用于读取新到邮件）、**Google Calendar API**（用于查询日程空闲时段），以及 **CRM 系统或联系人数据库**（用于丰富发件人背景信息）。

We’d then build orchestration logic like the following :  
随后，我们可构建如下编排逻辑：

1. A new email triggers the agent  
1. 一封新邮件触发智能体启动  

2. The agent fetches sender info from the CRM or via web search  
2. 智能体从 CRM 系统或通过网络搜索获取发件人信息  

3. It passes the full context into the prompt to determine urgency and whether a response is needed  
3. 将完整上下文输入提示词，以判断邮件紧急程度及是否需要回复  

4. If a meeting is appropriate, it checks calendar availability and proposes times  
4. 若适宜安排会议，则查询日历空闲时段，并推荐若干可选时间  

5. The agent drafts a response  
5. 智能体草拟回复邮件  

6. After human review, it sends the email  
6. 经人工审核后，自动发出该邮件

## Step 5: Test & Iterate

## 第五步：测试与迭代

Begin by **manually testing** your MVP using the examples you defined in Step 1. The goal is to verify that your agent is producing reasonable, accurate outputs for your core use cases. If your system involves multiple LLM calls or steps, it’s helpful to **set up tracing** using tools like [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) to visualize the flow and debug how decisions are made at each stage.

首先，使用你在**第一步**中定义的示例，对 MVP 进行**人工测试**。目标是验证你的智能体能否针对核心使用场景，生成合理且准确的输出。若系统涉及多次大语言模型（LLM）调用或多个处理步骤，建议借助 [LangSmith](https://docs.smith.langchain.com/?ref=blog.langchain.com) 等工具**配置追踪（tracing）功能**，以直观呈现执行流程，并在每个阶段调试决策逻辑。

Once manual testing is solid, **scale to automated testing** to ensure consistency and catch edge cases. Teams will often beef up examples to a few dozen to get a better sense of the agent’s strengths and weaknesses. This also helps you quantify performance before adding more complexity:

人工测试稳定后，应**转向自动化测试**，以保障结果一致性并发现边界情况（edge cases）。团队通常会将测试样例扩充至数十个，从而更全面地评估智能体的优势与短板。这也有助于在引入更多复杂性之前，对性能进行量化评估：

- Run all examples (original + new) programmatically through your agent  
- Define automated success metrics — this forces clarity around your agent’s expected behavior  
- Use human review selectively to catch issues that metrics might miss  

- 将全部样例（原始样例 + 新增样例）通过程序批量提交给智能体运行  
- 定义自动化的成功指标——此举可促使你明确界定智能体应有的行为表现  
- 有选择地引入人工审核，以识别指标可能遗漏的问题  

### **Example: Building an Email Agent**

### **示例：构建邮件智能体**

For the email agent, we’d want to define and test success across several key areas:

针对该邮件智能体，我们需在以下若干关键维度上明确定义并开展效果测试：

- **Tone and Safety:** Responses should be professional, respectful, and free of hallucinated or inappropriate content  
- **Intent & Priority Detection:** Emails should be correctly categorized and prioritized based on sender and content  
- **Tool Usage Efficiency:** The agent should trigger only the necessary tools (e.g., avoid checking the calendar if no scheduling is required)  
- **Draft Quality:** Suggested replies should be clear, relevant, and accurate based on the input context  

- **语气与安全性**：回复应保持专业、得体，且不含幻觉内容或不当信息  
- **意图与优先级识别**：邮件应依据发件人身份与正文内容被正确分类并排序优先级  
- **工具调用效率**：智能体仅应触发必要工具（例如，若无需安排日程，则不应查询日历）  
- **草稿质量**：所建议的回复应清晰、切题，并严格基于输入上下文保持准确  

## Step 6: Deploy, Scale, and Refine

## 第六步：部署、扩展与优化

Once your MVP is performing reliably, begin expanding its scope—adding new capabilities, broader use cases, or even multi-agent workflows. For every new feature or integration, **repeat the testing process** from Step 5 to ensure you’re not breaking existing functionality.

当 MVP 运行稳定可靠后，即可逐步拓展其应用范围——例如新增能力、覆盖更广泛的使用场景，甚至构建多智能体协同工作流。对于每一项新功能或新集成，都须**重复第五步的测试流程**，确保不会破坏既有功能。

When ready, deploy to production in users' hands. [LangGraph Platform](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com) allows you to quickly ship, scale, and manage your agents with one-click deployment.

准备就绪后，即可将智能体正式部署至生产环境，交付用户使用。[LangGraph 平台](https://langchain-ai.github.io/langgraph/concepts/langgraph_platform/?ref=blog.langchain.com) 支持一键式部署，助你快速上线、弹性伸缩并高效管理智能体。

Monitor how people actually use your agent. Tools like LangSmith let you trace your agent’s actions in real time, making it easier to spot spikes in cost, accuracy issues, or latency. Real-world usage often differs from your initial assumptions, and these insights can reveal gaps, surface unexpected needs, and guide prioritization during your next iteration.

监控用户实际如何使用您的智能体。LangSmith 等工具可让您实时追踪智能体的行为，从而更轻松地识别成本激增、准确率下降或延迟升高问题。真实场景中的使用方式往往与您最初的设想存在差异；这些洞察有助于发现能力缺口、暴露意料之外的用户需求，并为下一轮迭代提供优先级指导。

The key is treating launch as the beginning of iteration, not the end of development.

关键在于：将上线发布视为迭代的起点，而非开发工作的终点。

### **Example: Building an Email Agent**

### **示例：构建邮件智能体**

After deploying our email agent, we might discover unaddressed use cases through monitoring traffic and common use cases.

部署邮件智能体后，我们可通过监控流量和高频使用场景，发现此前未覆盖的用户用例。

These emerging patterns signal opportunities to expand scope. From there, we can iteratively add new integrations and update our prompts and orchestration logic—always validating each addition with tests and user feedback before scaling further.

这些新浮现的使用模式提示了拓展功能边界的契机。此后，我们可以持续迭代，逐步接入新的系统集成、更新提示词（prompts）与编排逻辑——每次新增功能均需通过测试与用户反馈验证，再推进规模化应用。

## Conclusion

## 总结

This process is designed to help you build agents that are grounded in clear use cases, tested against real examples, and shaped by real-world feedback. It’s not just about getting an agent to run, but about building something useful, reliable, and aligned with how people actually work.

这一流程旨在帮助您构建扎根于明确使用场景、经真实案例验证、并由现实反馈持续塑造的智能体。其目标远不止于让一个智能体“跑起来”，而在于打造真正有用、稳定可靠、且契合用户实际工作方式的产品。

Whether you're automating email triage or orchestrating complex workflows, these six steps offer a practical path from idea to impact. But the work doesn’t stop at deployment— **the best agents are built through iteration.**

无论您是在自动化邮件分拣，还是在编排复杂业务流程，这六个步骤都为您提供了一条从创意构想到实际价值落地的可行路径。但工作绝不止步于部署——**最优秀的智能体，诞生于持续迭代之中。**

So start small, stay user-focused, and keep refining.

因此，请从小处着手，始终以用户为中心，并持续优化精进。