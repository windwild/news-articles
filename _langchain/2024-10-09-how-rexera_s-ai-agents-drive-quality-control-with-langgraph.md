---
title: "How Rexera’s AI agents drive quality control with LangGraph"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-rexera/"
date: "2024-10-09"
scraped_at: "2026-03-03T07:51:08.090185631+00:00"
language: "en-zh"
translated: true
description: "See how Rexera migrated to LangGraph to create a robust quality control agent for real estate workflows, significantly improving their LLM response accuracy."
tags: ["Case Studies"]
---
{% raw %}

Rexera is revolutionizing the $50 billion real estate transaction industry by harnessing AI to automate manual workflows. By deploying intelligent AI agents, Rexera streamlines real estate operations, accelerates transactions, and significantly reduces both costs and errors.

Rexera 正通过利用人工智能自动化人工工作流，彻底变革价值 500 亿美元的房地产交易行业。通过部署智能 AI 代理，Rexera 简化了房地产运营流程，加快了交易速度，并显著降低了成本与错误率。

Leveraging LangChain and LangGraph alongside their large language models (LLMs), Rexera has developed sophisticated AI agents. These AI agents perform complex cognitive tasks such as:

Rexera 借助 LangChain 和 LangGraph 框架，并结合其自研大语言模型（LLMs），开发出高度成熟的 AI 代理。这些 AI 代理可执行如下复杂认知任务：

- Ordering payoff statements  
- 下达结清证明（payoff statements）指令  
- Extracting critical data from documents  
- 从文档中提取关键数据  
- Performing quality control checks  
- 执行质量控制检查  

Below, we explore how Rexera created a robust Quality Control (QC) application that reviews real estate workflows with the precision of a human operator while proactively identifying issues to prevent delays. We'll explore how their system evolved, from its initial single-prompt approach to a more controllable and accurate solution using LangGraph.

下文将深入探讨 Rexera 如何构建一套稳健的质量控制（QC）应用——该应用能以人类操作员级别的精度审核房地产工作流，同时主动识别潜在问题，从而预防流程延误。我们还将剖析其系统演进路径：从最初依赖单一提示词（single-prompt）的 LLM 方案，逐步升级为基于 LangGraph 的、更可控且更精准的解决方案。

## **Initial Approach: Single-Prompt LLM Checks and Their Limitations**

## **初始方案：单提示词 LLM 质量检查及其局限性**

Quality control is essential in real estate transactions. Rexera has developed a specialized QC application that reviews thousands of workflows daily. This application checks for errors across various stages of a real estate transaction, including data handling, client communication, and interactions with counterparties such as homeowner associations (HOAs), county offices, utility companies, and others.

质量控制是房地产交易中不可或缺的一环。Rexera 已开发出一款专用 QC 应用，每日审核数千个工作流。该应用覆盖房地产交易各阶段，对数据处理、客户沟通，以及与业主协会（HOAs）、县政部门、公用事业公司等合作方的交互环节进行错误检测。

To ensure quality in real estate transactions, Rexera initially implemented several single-prompt LLM checks. These checks were designed to verify:

为保障房地产交易质量，Rexera 最初部署了多个基于单提示词的 LLM 检查机制。这些检查旨在验证以下几方面：

- Document accuracy  
- 文档准确性  
- Client expectation fulfillment  
- 客户预期达成情况  
- Workflow timeliness (SLA compliance)  
- 工作流时效性（是否符合服务等级协议 SLA）  
- Cost control  
- 成本管控  

However, this approach had limitations. Single-prompt LLMs struggled with the complexity of real estate workflows for several reasons, as they couldn’t grasp the full scope of a workflow, had limited context, and couldn’t navigate multi-dimensional scenarios properly.

然而，该方案存在明显局限性。单提示词 LLM 在应对房地产工作流的复杂性时表现乏力，原因在于：其难以全面把握整个工作流的完整脉络，上下文理解能力有限，且无法妥善处理多维度、多环节交织的现实场景。

Rexera evaluates LLM check effectiveness using three key metrics across thousands of workflow runs:

Rexera 通过三项核心指标，在数千次工作流运行中持续评估 LLM 检查机制的有效性：

1. **Accuracy**: Correctness scores for issue identification  
1. **准确性**：问题识别的正确性得分  

2. **Efficiency**: Execution speed per transaction  
2. **效率**：每笔交易的执行速度  

3. **Cost-effectiveness**: Associated LLM costs  
3. **成本效益**：相关大语言模型（LLM）的使用成本  

This approach streamlined QC by flagging potential issues and reducing manual review needs. However, Rexera identified the need for a more advanced solution to tackle complex real estate workflows effectively.  
该方法通过标记潜在问题、减少人工审核需求，显著优化了质量检查（QC）流程。然而，Rexera 意识到，要高效应对复杂的房地产业务流程，还需更先进的解决方案。

## **Evolving to AI Agents: Trying out CrewAI**  
## **迈向 AI 智能体：试用 CrewAI**

Recognizing the limitations of single-prompt LLMs, Rexera then tried a multi-agent approach using CrewAI, where each AI agent oversaw a different part of the transaction process. For example an agent would be defined as:  
鉴于单提示词（single-prompt）大语言模型的局限性，Rexera 随后尝试采用基于 CrewAI 的多智能体架构——每个 AI 智能体负责交易流程中的不同环节。例如，某智能体可被定义为：  

- Role: "Senior Content Quality Check Analyst"  
- 角色：“高级内容质量核查分析师”  

- Task: "Check if all HOA documents requested by the client have been ordered, and verify that corresponding ETA and cost information has been sent to the client"  
- 任务：“核查客户所要求的所有业主协会（HOA）文件是否均已下单，并确认相应的预计完成时间（ETA）及费用信息是否已发送给客户”  

This approach led to some improvements over single-prompt LLMs:  
该方案相较单提示词 LLM 取得了一定改进：  

- **False positives** (incorrectly flagging non-issues) dropped from 35% to 8%.  
- **误报率**（将非问题错误标记为问题）从 35% 降至 8%。  

- **False negatives** (failing to flag real issues) fell from 10% to 5%.  
- **漏报率**（未能识别真实存在的问题）从 10% 降至 5%。  

However, a key challenge emerged with the CrewAI approach. While the AI agents were capable, they sometimes took the wrong path in decision-making, like a GPS system choosing a longer route. This lack of precise control meant that in complex scenarios, agents might veer off course, leading to false positives or false negatives.  
然而，CrewAI 方案暴露出一个关键挑战：尽管各 AI 智能体能力不俗，但在决策过程中有时会“走错路”，如同导航系统选择了更长的路线。这种缺乏精准控制的特性意味着，在复杂场景下，智能体可能偏离既定路径，从而引发误报或漏报。

## **Migrating to LangGraph for Precision and Control**  
## **迁移到 LangGraph：实现更高精度与可控性**

To overcome the limitations of the CrewAI approach, Rexera shifted to LangGraph to custom-design decision paths for various scenarios, particularly benefiting complex cases. Built by the LangChain team, LangGraph is a controllable agent framework that brought additional advantages to Rexera, including the integration of human-in-the-loop workflows, state management, and more.  
为克服 CrewAI 方案的固有局限，Rexera 转而采用 LangGraph，针对各类业务场景（尤其是复杂场景）定制化设计决策路径。LangGraph 由 LangChain 团队开发，是一款具备高度可控性的智能体框架，为 Rexera 带来了诸多额外优势，包括支持“人在环路中”（human-in-the-loop）的工作流、状态管理（state management）等能力。

To illustrate the effectiveness of the new LangGraph-based approach, let's consider rush orders - a common complexity in real estate workflows where closings must happen faster than standard timelines.

为说明基于 LangGraph 的新方法的有效性，我们以“加急订单”为例——这是房地产工作流中一种常见复杂情形，要求交易结案时间快于标准周期。

Using LangGraph, Rexera created a tree-like structure for the Quality Control (QC) application that allows for cycles and branching. This structure enables the QC application to navigate different paths based on the rush requirements.

借助 LangGraph，Rexera 为质量控制（QC）应用构建了一种树状结构，支持循环与分支逻辑。该结构使 QC 应用能够依据加急需求动态选择不同的执行路径。

When the application identifies a rush order, it's directed down the "Rush Order" branch of the tree. For standard orders, the application follows a different branch, focusing on regular processing checks.

当应用识别出加急订单时，便会进入树状结构中的“加急订单”分支；而对于标准订单，则进入另一条分支，专注于常规流程检查。

![](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_001.jpg)

![](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_001.jpg)

This tree-like structure, enabled by LangGraph, dramatically improved Rexera’s QC process accuracy and completeness by introducing more deterministic decision-making and reducing the randomness of agents going down the wrong path. This shift has led to greater consistency in results, ensuring workflows are completed accurately and efficiently.

这一由 LangGraph 实现的树状结构，通过引入更具确定性的决策机制、显著降低智能体误入错误路径的随机性，大幅提升了 Rexera 质量控制流程的准确性与完整性。这一转变带来了更稳定一致的结果，确保工作流得以准确、高效地完成。

This approach with LangGraph added to the improvements made over CrewAI, resulting in:

LangGraph 方案在 CrewAI 基础上进一步优化，最终实现：

- False positives reduced from **8% to 2%**  
- 假阳性率从 **8% 降至 2%**

- False negatives decreased from **5% to 2%**  
- 假阴性率从 **5% 降至 2%**

Comparing these outputs for the same rush order scenario, the following example breaks down the QC findings with each new architecture:

针对同一加急订单场景，下述示例对比了各新一代架构输出的 QC 检查结果：

**Single-Prompt LLM Output:**  
**单提示词 LLM 输出：**

- **Issue found:** "True"  
- **发现问题：** “是”

- **Explanation:** "We did not explicitly acknowledge the rush request from the client in our communication."  
- **解释：** “我们在沟通中未明确确认客户的加急请求。”

- **Analysis:** **False positive**—While the rush request was actually acknowledged and executed, the LLM missed recognizing it due to its limited ability to handle complex, multi-step interactions, leading to an incorrect error being flagged.  
- **分析：** **假阳性**——实际上，加急请求已被明确确认并执行；但受限于 LLM 处理复杂、多步骤交互的能力，模型未能识别该事实，从而错误地标记了一个本不存在的问题。

**CrewAI Output:**

**CrewAI 输出：**

- **Issue found:** "False"  
- **问题发现：** “否”

- **Explanation:** "The client requested a rush order, which was acknowledged and acted upon by our team."  
- **解释：** “客户提出了加急订单请求，我方团队已确认并执行了该请求。”

- **Analysis:** **Partially accurate**—CrewAI identified the correct outcome of the rush order being executed but failed to notice a discrepancy in the order type, such as whether it was appropriately marked and handled as a rush order in the system.  
- **分析：** **部分准确**——CrewAI 正确识别出加急订单已被执行，但未能察觉订单类型方面存在的差异，例如该订单在系统中是否被正确标记并按加急订单流程处理。

**LangGraph Output:**

**LangGraph 输出：**

- **Issue found:** "True"  
- **问题发现：** “是”

- **Explanation:** "Order details indicate 'Rush Order: False' despite the client requesting and us acknowledging and executing a rush order."  
- **解释：** “订单详情显示‘加急订单：否’，而客户实际提出了加急订单请求，且我方已确认并执行了该加急订单。”

- **Analysis:** **Completely accurate**—LangGraph not only confirmed that the rush order was acknowledged and executed but also identified the inconsistency in how the order type was recorded. By following a custom decision path, it ensured both the acknowledgment of the rush and the proper handling of the order type were verified, preventing any potential delays or issues.  
- **分析：** **完全准确**——LangGraph 不仅确认了加急订单已被确认和执行，还精准识别出订单类型记录方式的不一致。通过遵循自定义决策路径，它同时验证了加急请求的确认状态与订单类型的正确处理，从而避免了潜在的延误或问题。

## **Conclusion**

## **结论**

By leveraging LangGraph's cycles and branching capabilities, Rexera created a more intelligent, adaptable QC application that ensured their AI agents would execute the right checks for each specific scenario, enhancing efficiency and accuracy in our real estate transactions.  
借助 LangGraph 的循环与分支能力，Rexera 构建了一款更智能、更灵活的质量控制（QC）应用，确保其 AI 智能体能针对每种具体场景执行恰当的校验，从而显著提升了房地产交易中的效率与准确性。

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)  
[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_002.png)](https://blog.langchain.com/customers-monday/)  
[![monday 服务 + LangSmith：从第一天起构建以代码为先的评估策略](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_002.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_003.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_003.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_004.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-rexera_s-ai-agents-drive-quality-control-with-langgraph/img_007.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
{% endraw %}
