---
render_with_liquid: false
title: "OpenRecovery: Transforming addiction recovery with LangGraph Platform"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-openrecovery/"
date: "2024-11-20"
scraped_at: "2026-03-03T07:47:13.234364851+00:00"
language: "en-zh"
translated: true
description: "See how OpenRecovery built an AI assistant with LangGraph Cloud, LangGraph, and LangSmith to support users on their journey to addiction recovery."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

[OpenRecovery](http://openrecovery.com/?ref=blog.langchain.com) is transforming addiction recovery with their AI-powered assistant that provides personalized, 24/7 support via text and voice. Bridging the gap between costly inpatient care and generic self-help programs, it makes expert-level guidance accessible to those struggling with addiction. Using tools like LangGraph and LangSmith, and deploying the final application to LangGraph Platform, the OpenRecovery team has built a sophisticated mobile application that adapts to individual users’ recovery journey.

[OpenRecovery](http://openrecovery.com/?ref=blog.langchain.com) 正借助其 AI 驱动的助手重塑戒瘾康复领域——该助手通过文字与语音，为用户提供个性化、全天候（24/7）的支持。它弥合了昂贵的住院治疗与泛化的自助项目之间的鸿沟，让深陷成瘾困境的人们也能获得专家级的指导。OpenRecovery 团队运用 LangGraph 和 LangSmith 等工具，并将最终应用部署至 LangGraph 平台，构建出一款高度智能化的移动应用，能够动态适配每位用户的康复进程。

## **Building a multi-agent architecture with LangGraph**

## **基于 LangGraph 构建多智能体架构**

OpenRecovery chose to build a multi-agent system atop LangGraph for several reasons. First, the team specialized nodes in LangGraph, each with tailored prompts for specific stages of the recovery process, such as step work or fear inventory. This ensures that each workflow is precisely tuned for its intended purpose.

OpenRecovery 选择在 LangGraph 基础上构建多智能体系统，原因有多个。首先，团队在 LangGraph 中设计了专业化的节点，每个节点均配备针对康复流程特定阶段（例如“十二步练习”或“恐惧清单”）量身定制的提示词（prompt），从而确保每个工作流都能精准服务于其既定目标。

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_001.jpg)Visualization of OpenRecovery’s agent architecture using LangGraph Studio (part of LangGraph Platform)

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_001.jpg)使用 LangGraph Studio（LangGraph 平台的组成部分）对 OpenRecovery 智能体架构进行可视化呈现

The graph structure of LangGraph supports the reuse of key components across agents, including shared-state memory, dynamic few-shot expert prompts, and search tools. This maintains consistency and efficiency across the system.

LangGraph 的图结构支持关键组件在各智能体之间复用，包括共享状态内存（shared-state memory）、动态少样本专家提示（dynamic few-shot expert prompts）以及搜索工具等。这保障了整个系统的一致性与运行效率。

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_002.jpg)Using LangGraph Studio (part of LangGraph Platform), the OpenRecovery team can visually inspect state in the graph and agent interactions in the recovery journey

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_002.jpg)借助 LangGraph Studio（LangGraph 平台的组成部分），OpenRecovery 团队可直观查看图中的状态流转及康复旅程中各智能体间的交互过程

LangGraph also enables smooth context switching between different agents within the same conversation. Users can transition from general chat to specific recovery work without disruption, creating a more natural and guided experience.

LangGraph 还支持在同一对话中无缝切换不同智能体的上下文。用户可从泛化聊天自然过渡到具体的康复任务，全程无中断，从而获得更自然、更具引导性的交互体验。

Finally, the architecture is highly scalable. By leveraging LangGraph Platform, OpenRecovery ensures that their multi-agent system can scale effortlessly as new agents are added for various recovery stages and mental health support, as they expand beyond 12-step programs.

最后，该架构具备极强的可扩展性。依托 LangGraph 平台，OpenRecovery 能够轻松扩展其多智能体系统——随着业务从传统“十二步法”项目延伸至更多康复阶段及心理健康支持场景，新增智能体可被无缝集成，系统规模随之平滑增长。

## **Deploying to LangGraph Platform for rapid iteration**

## **部署至 LangGraph 平台以实现快速迭代**

OpenRecovery opted to deploy their app on LangGraph Platform's robust infrastructure, integrating smoothly with their mobile app frontend.  LangGraph Platform's easy-to-use API also reduced the complexity of managing agent conversations and state, making it a great fit for OpenRecovery's lean engineering team.

OpenRecovery 选择将其应用部署于 LangGraph 平台强大而稳健的基础设施之上，并与移动端前端实现平滑集成。LangGraph 平台提供的易用型 API，显著降低了智能体对话管理与状态维护的复杂度，非常契合 OpenRecovery 这支精干高效的工程团队。

A key benefit of LangGraph Platform is its support for rapid iteration. The OpenRecovery team could quickly debug their agent interactions in the out-of-the-box visual studio, LangGraph Studio, then make updates and revisions to meet the evolving needs of their users and incorporate new recovery methodologies.

LangGraph 平台的一项关键优势在于其对快速迭代的支持。OpenRecovery 团队可在开箱即用的可视化开发环境——LangGraph Studio 中，迅速调试智能体（agent）交互行为，随后及时更新与优化系统，以满足用户不断变化的需求，并整合新的康复干预方法。

## **Human-in-the-Loop to enhance trust and accuracy**

## **引入人工闭环（Human-in-the-Loop），提升可信度与准确性**

Recognizing the sensitive nature of addiction recovery, OpenRecovery incorporated crucial human-in-the-loop features into its mobile app. First, the AI encourages deeper introspection by prompting users, much like a sponsor or therapist would. It gauges when enough information has been collected and requests human confirmation when needed for better accuracy and understanding.

鉴于戒瘾康复过程的高度敏感性，OpenRecovery 在其移动应用中集成了关键的人工闭环功能。首先，AI 会像康复伙伴（sponsor）或治疗师一样，主动向用户提出引导性问题，鼓励其进行更深层次的自我反思；当系统判断已收集到足够信息时，会在必要时刻请求人工确认，从而提升响应的准确性与理解深度。

Additionally, users can edit AI-generated summaries or tables, allowing them to verify the accuracy of their personal information and maintain control over their data. Users can also provide feedback to the agent in natural language, which helps build trust throughout the recovery process.

此外，用户可直接编辑 AI 生成的摘要或表格，自主核验个人信息的准确性，并始终掌握自身数据的控制权。用户还能以自然语言向智能体提供反馈，这种双向互动有助于在整个康复过程中持续建立信任关系。

## **Collaborative development and improvement with LangSmith**

## **借助 LangSmith 实现协同开发与持续优化**

Layering on LangSmith for observability has accelerated OpenRecovery's development process and added robustness to their testing.

在系统中集成 LangSmith 以增强可观测性，显著加快了 OpenRecovery 的开发节奏，并大幅提升了测试环节的可靠性。

First, the platform enables collaborative prompt engineering. The non-technical content team and addiction recovery experts can easily modify prompts in the LangSmith prompt hub, test them in the playground, and deploy new revisions on LangGraph Platform. The OpenRecovery team can also test changes in LangGraph Studio, using trace logs to ensure everything functions as expected.

首先，该平台支持协作式提示词工程（collaborative prompt engineering）。非技术背景的内容团队与戒瘾康复领域专家均可便捷地在 LangSmith 提示中心（prompt hub）中修改提示词，在 Playground 中即时测试效果，并将新版本一键部署至 LangGraph 平台。OpenRecovery 团队亦可在 LangGraph Studio 中验证各项变更，借助追踪日志（trace logs）确保所有功能按预期运行。

LangSmith helps the OpenRecovery team identify failure points, such as when the language model lacks the proper empathy needed for addiction recovery support. This allows a human to come in and make the critical corrections.

LangSmith 帮助 OpenRecovery 团队精准定位系统失效点——例如，当大语言模型在戒瘾康复支持场景中缺乏应有的共情能力时。此时，即可由人工介入并完成关键修正。

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_003.png)

![](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_003.png)

When the OpenRecovery team identifies an unsatisfactory response when debugging traces, they can quickly add new few-shot examples to the dataset in LangSmith, re-index it, and test.

当 OpenRecovery 团队在调试追踪日志（traces）过程中发现某次响应不尽如人意时，可迅速在 LangSmith 中向数据集添加新的少样本（few-shot）示例，重新索引后立即开展测试。

the same question to verify the improvement. This enforces a cycle of continuous improvement.

使用相同的问题来验证改进效果。这推动形成了一个持续改进的闭环。

## **Conclusion**

## **结论**

By harnessing LangChain's ecosystem, OpenRecovery has developed a dynamic, personalized AI assistant for addiction recovery. Their multi-agent architecture, combined with human-in-the-loop features, lets the team adapt to individual needs while providing the empathy essential for recovery support. As they expand their offerings and introduce new modalities like voice interactions, OpenRecovery is set to make a meaningful impact in providing expert-level addiction recovery guidance.

借助 LangChain 生态系统，OpenRecovery 开发了一款面向戒瘾康复的动态化、个性化 AI 助手。其多智能体架构结合“人在回路中”（human-in-the-loop）功能，使团队既能灵活适配个体需求，又能提供康复支持所必需的共情能力。随着服务范围不断拓展，并引入语音交互等新模态，OpenRecovery 将在提供专家级戒瘾康复指导方面产生切实而深远的影响。

To try out the beta version of their new Recovery Assistant, visit their [website](https://www.openrecovery.com/?ref=blog.langchain.com) or download on your [iPhone](https://apps.apple.com/us/app/12-steps-addiction-recovery/id6446251140?ref=blog.langchain.com) or [Android](https://play.google.com/store/apps/details?id=com.twelve_steps.twelve_steps&hl=en_US&ref=blog.langchain.com) device – and keep an eye out for their public launch later this month.

如需体验新版 Recovery Assistant 的测试版，请访问其[官网](https://www.openrecovery.com/?ref=blog.langchain.com)，或在您的[iPhone](https://apps.apple.com/us/app/12-steps-addiction-recovery/id6446251140?ref=blog.langchain.com)或[Android](https://play.google.com/store/apps/details?id=com.twelve_steps.twelve_steps&hl=en_US&ref=blog.langchain.com)设备上下载安装——敬请关注其本月稍晚的正式发布！

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_004.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_004.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_005.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_005.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_006.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_007.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_008.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/openrecovery-transforming-addiction-recovery-with-langgraph-platform/img_009.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：借助 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟