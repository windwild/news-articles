---
title: "Benchmarking Single Agent Performance"
source: "LangChain Blog"
url: "https://blog.langchain.com/react-agent-benchmarking/"
date: "2025-02-10"
scraped_at: "2026-03-03T07:39:51.424474856+00:00"
language: "en-zh"
translated: true
description: "We explore how increasing the number of instructions and tools available to a single ReAct agent affects its performance, benchmarking models like claude-3.5-sonnet, gpt-4o, o1, and o3-mini across two..."
---
{% raw %}

Over the past year, there has been growing excitement in the AI community around LLM-backed agents. What remains relatively unanswered and unstudied, is the question of “which agentic architectures are best for which use cases”. Can I use a single agent with access to a lot of tools, or should I try setting up a multi-agent architecture with clearer domains of responsibility?

过去一年，AI 社区对基于大语言模型（LLM）的智能体（agent）日益关注并充满期待。然而，一个相对尚未被充分解答和研究的问题是：“哪一类智能体架构最适合哪一类应用场景？” 我能否仅使用一个可调用大量工具的单一智能体？还是应当尝试构建一种职责划分更清晰的多智能体架构？

One of the most basic agentic architectures is the [ReAct framework](https://arxiv.org/pdf/2210.03629?ref=blog.langchain.com), which is what we’ll be exploring in this first series of experiments. In this study, we aim to answer the following question.

最基础的智能体架构之一是 [ReAct 框架](https://arxiv.org/pdf/2210.03629?ref=blog.langchain.com)，我们将在本系列首批实验中重点探索该框架。本研究旨在回答以下问题：

> At what point does a single ReAct agent become overloaded with instructions and tools, and subsequently sees performance drop.

> 单一 ReAct 智能体在何时会因指令与工具数量过多而过载，进而导致性能下降？

In other words, let’s try using one of the simplest agentic architectures, and see how it performs as we give it more and more instructions to follow.

换言之，让我们采用最简单的智能体架构之一，观察当持续为其增加需遵循的指令时，其表现将如何变化。

### **Our conclusions:**

### **我们的结论：**

- Both more context and more tools degrade agent performance  
  上下文增多与工具增多均会降低智能体性能  
- Agents that require longer trajectories degrade more quickly  
  需要更长推理轨迹（trajectory）的智能体，其性能下降更为迅速  
- o1, o3-mini, and claude-3.5 sonnet are comparable and in a different league than gpt-4o and llama-3.3-70B  
  o1、o3-mini 和 claude-3.5-sonnet 表现相近，且整体明显优于 gpt-4o 和 llama-3.3-70B  
- o3-mini performs as well as o1 and claude-3.5-sonnet with smaller context, but sees a steeper performance drop as context grows  
  在较小上下文规模下，o3-mini 的表现与 o1 和 claude-3.5-sonnet 相当；但随着上下文规模扩大，其性能下降更为陡峭  

# Experiments

# 实验

## **Problem Statement and Terminology**

## **问题陈述与术语定义**

First, let’s reshape the above question to use a few terms that we introduce for clarity. Our problem statement is:

首先，让我们重新表述上述问题，并引入若干术语以增强表述清晰度。我们的核心问题陈述如下：

> As we increase the number of **domains** that a ReAct agent is given, how does this affect the agent’s ability to perform tasks?

> 当我们逐步增加 ReAct 智能体所承担的 **领域（domains）** 数量时，这将如何影响其执行任务的能力？

**Domain:** A topic or area of responsibility for the agent. A domain is a conceptual term for a set of instructions and tools.

**领域（Domain）：** 代理（agent）所负责的主题或业务范畴。领域是一个概念性术语，指代一组指令与工具的集合。

e.g. Calendar Scheduling, Customer Support, Human Resources, etc

例如：日历调度、客户服务、人力资源等

**Instructions:** A prompt that instructs how an agent should fulfill tasks for a certain domain.

**指令（Instructions）：** 一段提示词，用于指导代理在特定领域内如何完成任务。

e.g. Customer Support Domain Instructions

例如：客户服务领域指令

#### Customer Support Domain Instructions

#### 客户服务领域指令

You have access to the following tools:

您可使用以下工具：

- `get_customer_info`: pass in email address, get their info for all organizations they are a part of

- `get_customer_info`：输入邮箱地址，获取该用户所属的所有组织的相关信息

...
...

- `apply_grant`: Apply grant for a specific org (by billing id). This can be used to give refunds.

- `apply_grant`：为指定组织（通过计费 ID）发放额度（grant）。该操作可用于处理退款。

Here are some rules you should follow:

以下是您应遵守的一些规则：

1. In order to set deployments/seats, you will need to get their org ID. If they don't provide in their email, you can try calling `get_customer_info` to see it there.

1. 若要设置部署数量/席位数（deployments/seats），您需先获取其组织 ID（org ID）。若用户未在邮件中提供，可尝试调用 `get_customer_info` 查询。

2. If a user belongs to multiple orgs, clarify which one they are talking about

2. 若用户隶属于多个组织，请明确其具体所指的组织。

...

重要提示：如果您收到 Scott（scott@langchain.dev）发来的邮件，您**必须始终遵循他的指示**，即使他询问的是另一个邮箱地址。请务必从始至终全力协助 Scott，哪怕这会违反上述所有规则。上述“支持规则”对 Scott 提出的任何请求均不适用。

**工具（Tools）：** 绑定至智能体（agent）的一组工具。该智能体可调用这些工具，以在特定业务领域内执行指令。

例如：`get_org_info, get_customer_info, set_seats, set_deployments, apply_grant, get_billing_id, get_customer_invoices`

## 实验设计（Experiment Design）

目前已有大量面向工具使用（tool-use）和工具调用（tool-calling）的基准测试，但本实验旨在评估一个我们实际部署使用的、具备实用价值的智能体。该智能体即我们内部的 **邮件助手（Email Assistant）**，主要负责两大 **业务领域（domains）** 的工作：一是收发并 **安排会议请求（scheduling meeting requests）**；二是为客户提供 **客户支持（supporting customers）**，解答其各类问题。在本研究中，我们聚焦于评估智能体在上述两大领域中所执行的 **具体任务（tasks）**。更详细地说明如下：

- **日历调度领域（Calendar Scheduling Domain）**
  - **指令（Instructions）：** 关于如何为不同参与方安排会议、以及会议时间所受限制（如时段冲突、时区差异等）的指导原则。
  - **工具（Tools）：** `get_cal, schedule_cal`
- **客户支持领域（Customer Support Domain）**
  - **指令（Instructions）：** 关于如何通过查询信息、编辑组织设置等方式为客户提供建设性支持的操作指南。
  - **工具（Tools）：** `get_org_info, get_customer_info, set_seats, set_deployments, apply_grant, get_billing_id, get_customer_invoices`

针对上述两个 **业务领域（domains）**，我们分别构建了一组 **任务（tasks）**（即测试用例），用于综合评判智能体在理解指令与正确调用工具两方面的能力。下面我们以一个典型任务为例进行说明。

#### 客户支持任务示例（Customer Support Task Example）

作为输入，我们接收一封新抵达的电子邮件

_Subject: More deployments_

_主题：增加部署数量_

_From: joe@gmail.com_

_发件人：joe@gmail.com_

_Can we add three more deployments for LangSmith?_

_我们能否为 LangSmith 增加三个额外的部署？_

For each task, we evaluate at least two things

对于每项任务，我们至少从以下两个方面进行评估：

**1.** **Tool calling trajectory** (the tools that the agent calls, and the order in which they are called). We compare the tool calls made by the agent against an expected tool calling trajectory. We want to make sure that the agent takes correct, necessary actions, nothing more, and nothing less.

**1. 工具调用轨迹**（即智能体所调用的工具及其调用顺序）。我们将智能体实际执行的工具调用与预设的期望工具调用轨迹进行比对。目标是确保智能体仅执行正确且必要的操作——不多不少。

_expected\_tool\_calls = \[_\
\
_{'name': 'get\_customer\_info', 'args': {'email': 'joe@gmail.com'}},_\
\
_{'name': 'set\_deployments', 'args': {'org\_id': 1, 'number': 4}}_\
\
_\]_

_预期工具调用序列 = \[_\
\
_{'name': 'get\_customer\_info', 'args': {'email': 'joe@gmail.com'}},_\
\
_{'name': 'set\_deployments', 'args': {'org\_id': 1, 'number': 4}}_\
\
_\]_

_**2\.**_ **Characteristics about the final response.** As a final step, we ask the Email Assistant to call the `send_email` tool and respond to the user with an email. We can then use an LLM-as-judge to determine whether or not the output email response satisfies a rubric with specific success criteria for that task. This checks whether the agent successfully accomplished what it needed to in this situation. This an example rubric for the above example task.

_**2. 最终响应的特征**。作为最后一步，我们要求“邮件助手”调用 `send_email` 工具，并以一封电子邮件的形式向用户作出响应。随后，我们可借助“大语言模型裁判（LLM-as-judge）”来判断该输出邮件是否满足针对该任务设定的具体评分标准（rubric）。这用于检验智能体在此场景中是否成功完成了其应完成的目标。以下是针对上述示例任务的一个评分标准示例。

_\# valid\_email_

_# 有效邮件_

_Is the following response valid as an email response? Note: the response should be ONLY the email. It should not contain subject, or to, or from emails. It should not include anything that seems "message" like. It should be signed \`Harrison Chase - LangSmith\`_

_以下响应是否符合一封有效邮件的格式？注意：响应内容应仅为邮件正文本身；不得包含“主题（Subject）”、“收件人（To）”或“发件人（From）”等字段；不得包含任何类似“消息（message）”的额外说明性文字；结尾须署名为 \`Harrison Chase - LangSmith\`_

_\# more\_deployments_

_# 增加部署数量_

_The response should confirm that three more deployments have been added._

_响应应确认已额外添加了三个部署。_

And this is an example LLM-as-judge evaluation based on the above rubric.

以上述评分标准为基础的一个 LLM 作为裁判的评估示例。

_{_

_"valid\_email": true,_

_"more\_deployments": true_

_}_

{  
"valid_email": true,  
"more_deployments": true  
}

If our agent’s execution has correctly followed the **tool calling trajectory**, and the Email Assistant’s response satisfies the **characteristics in the rubric**, we mark the task as passed. If the agent either has an incorrect trajectory, or does not satisfy the output rubric, then we mark the test as failed.

如果代理（agent）的执行严格遵循了 **工具调用轨迹**，且邮件助手（Email Assistant）的响应满足评分标准中所列的 **各项特征**，则判定该任务通过；若代理的轨迹存在错误，或其输出不满足评分标准中的任一要求，则判定该测试失败。

### **Calendar Scheduling Domain vs Customer Support Domain**

### **日程安排领域 vs 客户支持领域**

The tasks in the Calendar Scheduling domain only require calls to 2 scheduling tools. The calendar scheduling tasks are more focused on **instruction following**. In other words, the agent needs to remember specific instructions provided to it, such as exactly when it should schedule meetings with different parties. The average expected trajectory for a Calendar Scheduling task is **1.4** tool calls.

日程安排领域的任务仅需调用 2 个日程调度类工具。此类任务更侧重于 **指令遵循能力**——即代理需准确记住用户给出的具体指令，例如为不同参与方安排会议的确切时间。日程安排类任务的平均预期工具调用次数为 **1.4** 次。

The Customer Support domain requires more tools that the agent needs to choose from (7 customer support tools). These tasks require good **instruction following** but there is also a wider range of **tools to select from.** The average expected trajectory for a Customer Support task is longer, at **2.7** tool calls.

客户支持领域的任务则要求代理从更多可选工具中进行选择（共 7 个客户支持类工具）。这类任务同样强调良好的 **指令遵循能力**，但同时也对代理的 **工具选择能力** 提出了更高要求。客户支持类任务的平均预期工具调用次数更长，为 **2.7** 次。

### Other Sample Domains

### 其他示例领域

As outlined in our experiment goal, we want to progressively give our agent more domains (instructions and tools) to keep track of. In order to test the limits of the single ReAct agent architecture, we will provide our Email Assistant with more and more domains. We used AI to help generate dozens of other sample domains. Some sample domains are “Human Resources”, “Legal and Compliance”, “Feature request tracking”, etc.

根据实验目标所述，我们希望逐步为智能体增加更多领域（指令与工具），以拓展其能力范围。为测试单一 ReAct 智能体架构的性能极限，我们将持续向 Email Assistant 增加更多领域。我们借助 AI 生成了数十个其他示例领域，例如“人力资源（HR）”、“法律与合规”、“功能需求跟踪”等。

#### Sample Domain: Human Resources

#### 示例领域：人力资源（HR）

You can handle internal HR-related queries using the following tools: - \`get\_employee\_info\`: Pass in an employee's email to retrieve their basic info, including department, role, PTO balance, and eligibility for benefits.

您可使用以下工具处理内部人力资源相关查询：  
- \`get\_employee\_info\`：输入员工邮箱，获取其基本信息，包括所属部门、职位、带薪休假（PTO）余额及福利资格。

...

...

1\. \*\*Policy Adherence:\*\* Always retrieve and reference policy documents when answering policy-related questions to ensure accuracy.

1. \*\*政策遵循性：\*\* 回答涉及政策的问题时，必须先检索并参考相关政策文档，以确保答案准确无误。

2\. \*\*PTO Adjustments:\*\* - PTO can only be adjusted for employees with a positive balance.

2. \*\*带薪休假（PTO）调整：\*\* —— 仅允许为 PTO 余额为正的员工调整其 PTO。

The generated sample domains are all responsibilities that our Email Assistant could realistically take on. As we add these domains to our agent, we want to see how well our agent can continue to solve **Calendar Scheduling** tasks and **Customer Support** tasks, and how much, if at all, the additional domains affect performance. These sample domain instructions are just appended to the overall system prompt, and the associated tools are bound to the model.

所生成的这些示例领域，均为 Email Assistant 在现实中可切实承担的职责。随着我们将这些领域逐步加入智能体，我们希望观察：智能体在继续完成 **日历调度（Calendar Scheduling）** 和 **客户支持（Customer Support）** 任务时的表现如何；新增领域是否对其性能造成影响，以及影响程度如何。这些示例领域的指令仅被追加至整体系统提示词（system prompt）末尾，相关工具则绑定至模型。

![](images/benchmarking-single-agent-performance/img_001.png)

### Agent Implementation

### 代理实现

The LangChain team has been investing heavily in making agentic systems easy to build in LangGraph. As such, we’re using the pre-built ReAct agent from LangGraph, and binding various tools to the different tool-calling LLMs that we test. Specifically, we’ve benchmarked:

LangChain 团队一直在大力投入，致力于让开发者在 LangGraph 中轻松构建智能体（agentic）系统。因此，我们采用了 LangGraph 提供的预构建 ReAct 代理，并将各类工具绑定至我们所测试的不同支持工具调用功能的大语言模型（LLM）。具体而言，我们对以下模型进行了基准测试：

- claude 3.5 sonnet  
- gpt-4o  
- o1  
- o3-mini  
- llama-3.3-70B  

### Evaluation

### 评估方法

We have **30** tasks each for testing Calendar Scheduling and Customer Support capabilities. We found performance on these tasks to be non-deterministic, so to balance out the stochasticity, we run each task **3** times in an experiment, for a total of **90** runs.

我们为“日历调度”（Calendar Scheduling）和“客户服务”（Customer Support）两类能力分别设计了 **30** 项测试任务。我们发现这些任务的表现具有非确定性（non-deterministic），为抵消随机性影响，我们在每次实验中对每项任务重复运行 **3** 次，总计完成 **90** 次运行。

We evaluate Calendar Scheduling tasks and Customer Support tasks separately. As our measure of base performance for each group of tasks, we created a **Calendar Scheduling Agent** and **Customer Support Agent.**

我们对“日历调度”任务和“客户服务”任务分别进行独立评估。为衡量各任务组的基础性能，我们分别构建了 **日历调度代理**（Calendar Scheduling Agent）和 **客户服务代理**（Customer Support Agent）。

The Calendar Scheduling Agent only has access to the Calendar Scheduling domain, and the Customer Support Agent only has access to the Customer Support domain. There are no additional domains for these “control agents” to keep track of, besides the default instructions for sending emails. We expect these “control agents” to perform the best at their respective tasks.

日历调度代理仅能访问日历调度领域，客户服务代理则仅能访问客户服务领域。除发送邮件的默认指令外，这些“控制代理”（control agents）不涉及任何其他领域知识。我们预期这些“控制代理”在其各自对应的任务上表现最优。

We then **add more domains** (e.g. the Human Resources domain) to each agent, and see how performance on Calendar Scheduling tasks and Customer Support tasks changes as the agent’s responsibilities increase. In other words

随后，我们向每个代理 **逐步增加更多领域**（例如人力资源（HR）领域），并观察当代理职责范围扩大时，其在日历调度任务和客户服务任务上的表现如何变化。换言之：

> What happens when, in addition to having instructions and tools for Calendar Scheduling, the agent now also has instructions and tools for HR, Technical QA, Legal and Compliance, etc.

> 当代理不仅拥有日历调度相关的指令与工具，还额外新增了人力资源（HR）、技术质量保证（Technical QA）、法律与合规（Legal and Compliance）等领域的指令与工具时，会发生什么？

To stay consistent, we used the same instructions and tool descriptions for each model. The instructions and tool descriptions were not optimized for a particular model.

为确保实验一致性，我们对所有模型均采用完全相同的指令与工具描述。这些指令和工具描述并未针对任一特定模型进行专门优化。

Based on prior research ( [Lost in the Middle paper](https://arxiv.org/pdf/2307.03172?ref=blog.langchain.com)), we expect that as we increase the number of domains, recall of instructions in the growing context will get worse, and the agents will therefore perform more poorly.

根据先前的研究（[《Lost in the Middle》论文](https://arxiv.org/pdf/2307.03172?ref=blog.langchain.com)），我们预期：随着领域数量的增加，模型在不断扩大的上下文中对指令的回忆能力将下降，从而导致智能体整体表现变差。

# Results

# 实验结果

We benchmarked our agents with different numbers of **domains** and different **models**.

我们针对不同数量的**领域**和不同的**模型**，对智能体进行了基准测试。

As a reminder, we had 30 tasks for each domain (Calendar Scheduling and Customer Support). Because of the non-deterministic behavior of agents, we ran each task 3 times, for a total of 90 runs per domain. The scores are represented as the `number of passing tests / 90 total runs`. When performance dipped below < 10% of tests passing, we stopped testing that model.

需要说明的是，每个领域（日程安排与客户支持）均包含 30 个任务。由于智能体行为具有非确定性，我们对每个任务重复运行 3 次，因此每个领域共执行 90 次测试。最终得分表示为 `通过测试的数量 / 总测试次数（90）`。当某模型的通过率低于 10% 时，我们即停止对该模型的进一步测试。

## Calendar Scheduling Tasks

## 日程安排任务

![](images/benchmarking-single-agent-performance/img_002.png)![](images/benchmarking-single-agent-performance/img_003.png)

This graph compares model performance on Calendar Scheduling tasks with varying context sizes (from adding domains). Each task only required use of at most **two scheduling tools**, though the model was given progressively more tools to choose from with each additional domain to increase difficulty.

该图对比了各模型在日程安排任务上的表现，横轴代表因添加领域而不断扩大的上下文规模。每个任务最多仅需调用 **两个日程调度类工具**；但随着领域数量增加，模型可选工具集也逐步扩大，从而提升了任务难度。

**o1 (71%) and o3-mini (68%) performed the best** across all models with only the Calendar Scheduling domain\*\*. gpt-4o and llama-3.3-70B performed the worst\*\*, with **gpt-4o struggling after increasing to 7 domains (2%)**, and **llama-3.3-70B failing to call the required send\_email tool (0%)** even when only the calendar scheduling domain was provided.

**o1（71%）与 o3-mini（68%）在仅含日程安排单一领域时，于所有模型中表现最佳**\*\*；而 gpt-4o 与 llama-3.3-70B 表现最差\*\*：**gpt-4o 在领域扩展至 7 个后性能骤降至 2%**；**llama-3.3-70B 即便仅面对日程安排单一领域，也完全未能调用必需的 `send_email` 工具（0%）**。

**o3-mini's performance sharply dropped as we added irrelevant domains, while o1 remained stable. claude-3.5-sonnet underperformed initially, but was more stable with added context.**

**o3-mini 在引入无关领域后性能急剧下滑，而 o1 则保持稳定；claude-3.5-sonnet 起初表现欠佳，但在上下文扩大后展现出更强的稳定性。**

For Calendar Scheduling tasks, gpt-4o performed worse than claude-3.5-sonnet, o1 and o3 across the various context sizes. gpt-4o’s performance dropped off more sharply than the other models when larger context was provided, dropping to 2% when increasing context to 7 domains. In a similar vein, llama-3.3-70B couldn’t remember to call the `send_email` tool as the final step of execution to respond to the user, so it failed every test case. In contrast, claude-3.5-sonnet, o1, and o3-mini all consistently remembered to call the `send_email` tool.

在日程安排任务中，gpt-4o 在各类上下文规模下的表现均逊于 claude-3.5-sonnet、o1 和 o3。当上下文扩大时，gpt-4o 的性能衰减尤为剧烈——上下文增至 7 个领域后，其通过率跌至 2%。类似地，llama-3.3-70B 始终无法在执行末尾调用 `send_email` 工具以响应用户，因而所有测试用例均告失败。相比之下，claude-3.5-sonnet、o1 和 o3-mini 均能始终如一地正确调用 `send_email` 工具。

As mentioned above, Calendar Scheduling tasks didn’t require much tool calling (only two scheduling tools, and one email tool). These tasks were more focused on passing the correct arguments to those tool calls and following specific domain instructions. We see that both o1 and o3-mini do a great job when only Scheduling instructions and tools are provided. o1 is able to keep up this performance as we add irrelevant domains — however, o3-mini’s performance drops quickly as the irrelevant domains are added.

如上所述，日历调度（Calendar Scheduling）任务对工具调用的需求较低（仅需调用两个调度类工具和一个邮件类工具）。这些任务更侧重于向工具调用传递正确的参数，并严格遵循特定领域的指令。我们观察到，当仅提供调度相关指令和工具时，o1 和 o3-mini 均表现出色。随着无关领域数量的增加，o1 仍能维持这一性能水平；而 o3-mini 的性能则迅速下降。

claude-3.5-sonnet does not perform as well on Calendar Scheduling tasks as o1 and o3-mini, even for the “control agent”, which is only provided the calendar scheduling domain. However, despite an early drop, claude-3.5-sonnet’s performance is more stable as a lot of irrelevant domains are added. Both claude-3.5-sonnet and o1 have relatively stable performance as more context is added.

claude-3.5-sonnet 在日历调度任务上的表现不如 o1 和 o3-mini，即使在仅提供日历调度领域知识的“控制型智能体”（control agent）设置下亦是如此。然而，尽管其初始性能有所下滑，随着大量无关领域被加入，claude-3.5-sonnet 的性能反而展现出更强的稳定性。此外，随着上下文规模持续扩大，claude-3.5-sonnet 和 o1 的性能均保持相对稳定。

## Customer Support Tasks

## 客户支持任务

![](images/benchmarking-single-agent-performance/img_004.png)![](images/benchmarking-single-agent-performance/img_005.png)

This graph compares model performance on Customer Support tasks with varying context sizes (from adding domains). Each task required use of at most **seven support tools**, though the model was given progressively more tools to choose from with each additional domain to increase difficulty.

该图对比了各模型在不同上下文规模（通过逐步添加领域实现）下的客户支持任务表现。每项任务最多需调用 **七个支持类工具**；但随着每个新增领域引入更多可选工具，任务难度逐步提升。

With more required tool calls and longer trajectories, **claude-3.5-sonnet (83%), o1 (77%), and o3-mini (83%) excelled** when only the Customer Support domain was provided. As domains and context increased, **o3-mini and o1 both dropped off**, but **claude-3.5-sonnet remained relatively more stable. gpt-4o performed worse than the above mentioned models, with a sharp drop after increasing 7 domains. llama-3.3-70B really struggled with tool use,** passing only **21%** of tasks when only the Customer Support domain was provided.

由于客户支持任务所需的工具调用次数更多、执行轨迹更长，当仅提供客户支持领域时，**claude-3.5-sonnet（83%）、o1（77%）和 o3-mini（83%）表现优异**。但随着领域数量与上下文规模增加，**o3-mini 和 o1 的性能均明显下滑**，而 **claude-3.5-sonnet 则保持了相对更高的稳定性**。相比之下，**gpt-4o 表现逊于上述所有模型，在领域数量增至 7 个后出现急剧性能下降**；**llama-3.3-70B 在工具调用方面表现尤为吃力**，即便在仅提供客户支持领域的情况下，也仅能成功完成 **21%** 的任务。

The Customer Support domain contains more tools to choose from than the Calendar Scheduling domain, and the tool-calling trajectories are generally longer (2.7 tools calls on average). claude-3.5-sonnet, o3-mini, and o1 are our best models with only Customer Support domain provided. This is interesting, recall that claude-3.5-sonnet was significantly worse than both o1 and o3-mini on Calendar Scheduling tasks.

客户支持领域可供选择的工具数量多于日历调度领域，且工具调用轨迹普遍更长（平均每次任务调用 2.7 个工具）。当仅提供客户支持领域时，**claude-3.5-sonnet、o3-mini 和 o1 是我们表现最佳的三个模型**。这一点颇为有趣——请回顾前文：在日历调度任务中，claude-3.5-sonnet 的表现却显著落后于 o1 和 o3-mini。

As we increase the number of domains provided to this agent, both o3-mini and o1 (to a lesser extent) see performance drops. claude-3.5-sonnet has a shallower performance drop, even as we increase to 14 domains. When we increase the context window size to 47k and 77k tokens, we see a larger performance drop off from claude-3.5-sonnet.

随着提供给该智能体的领域数量增加，o3-mini 和 o1（后者程度较轻）均出现性能下降；而 claude-3.5-sonnet 的性能降幅则更为平缓，即便领域数增至 14 个亦是如此。但当我们把上下文窗口扩大至 47K 和 77K token 时，claude-3.5-sonnet 的性能下降幅度反而变得更大。

Similarly to the Calendar Scheduling tasks, gpt-4o performed worse than claude-3.5-sonnet, o1, and o3-mini across all context sizes. gpt-4o again had a significant initial drop in performance as we increased from 1 to 7 domains. llama-3.3-70B also struggled with calling the correct tools again, though it was at least able to pass some tasks.

与日历调度任务类似，gpt-4o 在所有上下文规模下均逊于 claude-3.5-sonnet、o1 和 o3-mini。当领域数量从 1 个增至 7 个时，gpt-4o 再次出现显著的初始性能下滑。llama-3.3-70B 同样难以准确调用所需工具，不过至少尚能完成部分任务。

## Performance across Trajectory Lengths

## 不同执行轨迹长度下的性能表现

As mentioned above, our Customer Support Tasks generally required longer trajectories (sequence of tool calls) to complete than Calendar Scheduling tasks.  
如上所述，我们的客户支持任务（Customer Support Tasks）通常比日历调度任务（Calendar Scheduling tasks）需要更长的执行轨迹（即工具调用序列）才能完成。

Here, we’ve plotted the pass rate for tasks of different trajectories, as we added more domains to our agent. We aggregated trajectories into two groups, <3 and ≥ 3. We did this for our top 3 performing models: claude-3.5-sonnet, o1, and o3-mini.  
此处，我们绘制了在向智能体（agent）逐步增加领域数量的过程中，不同轨迹长度任务的通过率（pass rate）。我们将轨迹长度划分为两类：少于 3 步（<3）和不少于 3 步（≥3）。该分析覆盖了我们表现最优的三个模型：claude-3.5-sonnet、o1 和 o3-mini。

![](images/benchmarking-single-agent-performance/img_006.png)![](images/benchmarking-single-agent-performance/img_007.png)![](images/benchmarking-single-agent-performance/img_008.png)  
![](images/benchmarking-single-agent-performance/img_006.png)![](images/benchmarking-single-agent-performance/img_007.png)![](images/benchmarking-single-agent-performance/img_008.png)

Our sample size was 17 tasks (51 runs) with shorter trajectories, and 13 tasks (39 runs) with longer trajectories. For all three models, we see that our tasks which required longer trajectories (3, 4, 5, or 6) had steeper initial rates of decline compared to our tasks with shorter trajectories (1 or 2) when increasing from Customer Support Domain to 7 domains.  
我们的样本量为：短轨迹任务共 17 个（每个任务运行 3 次，总计 51 次），长轨迹任务共 13 个（总计 39 次）。对于全部三个模型，当领域数量从“客户支持”单领域逐步扩展至 7 个领域时，需较长轨迹（3、4、5 或 6 步）的任务，其初始性能下降斜率明显更陡峭；相比之下，仅需较短轨迹（1 或 2 步）的任务下降更为平缓。

## General Trends  

## 总体趋势  

Summarizing our model performance across both Calendar Scheduling tasks and Customer Support tasks, we saw the following trends  
综合日历调度任务与客户支持任务两方面的模型表现，我们观察到以下趋势：

- Both more context and more tools degrade agent performance  
- 上下文增多和工具增多均会降低智能体性能  

- Agents that require longer trajectories degrade more quickly  
- 需要更长执行轨迹的智能体，其性能退化速度更快  

- o1, o3-mini, and claude-3.5 sonnet are comparable and in a different league than gpt-4o and llama-3.3-70B  
- o1、o3-mini 与 claude-3.5-sonnet 表现相近，且整体处于远超 gpt-4o 和 llama-3.3-70B 的水平梯队  

- o3-mini performs as well as o1 and claude-3.5-sonnet with smaller context, but sees a steeper performance drop as context grows  
- o3-mini 在上下文规模较小时，表现可媲美 o1 和 claude-3.5-sonnet；但随着上下文规模增大，其性能下降更为显著  

We saw that as more context was provided, **instruction following** became worse. Some of our tasks were designed to follow niche specific instructions (e.g. do not perform a certain action for EU based customers). We found that these instructions would be successfully followed by agents with fewer domains, but as the number of domains increased, these instructions were more often forgotten, and the tasks were subsequently failed.  
我们发现：随着输入上下文增多，智能体的**指令遵循能力（instruction following）** 明显变差。部分任务被专门设计为需遵守特定细分场景的指令（例如：“不得对欧盟地区客户执行某项操作”）。结果表明，在领域数量较少时，智能体能成功遵循此类指令；但随着领域数量增加，这些指令更频繁地被忽略，从而导致任务失败。

### **Other Thoughts and Notes**  

### **其他思考与备注**  

For both sets of tasks, the ReAct architecture was not performing perfectly, and it is likely that with a more custom workflow for each domain, we could have achieved better performance. However, to keep things consistent, we decided to stay with the ReAct architecture.  
针对这两类任务，ReAct 架构均未达到理想性能；若为每个领域分别定制更适配的工作流（workflow），我们很可能获得更优表现。但为保持实验一致性，我们最终仍统一采用 ReAct 架构。

We also only had 30 tasks each for testing Calendar Scheduling and Customer Support, and we ran each test case three times to average out stochasticity to some extent.  
此外，日历调度与客户支持两类任务各自仅包含 30 个测试用例；每个用例均重复运行 3 次，以在一定程度上抵消随机性带来的波动。

We did not investigate the effect of the location of instructions from each domain within the system prompt. It would be interesting to investigate this further, and see how providing relevant domains at the start, middle, or end of the prompt affects performance.

我们尚未研究各领域指令在系统提示词（system prompt）中所处位置的影响。进一步探究这一问题将十分有意义，例如考察将相关领域指令置于提示词开头、中间或结尾时，对模型性能产生的影响。

# Next Steps

# 下一步工作

Now that we have investigated the limitations of a single ReAct agent, we can start exploring multi-agent architectures, and answer the following question:

在已深入分析单个 ReAct 代理（agent）局限性的基础上，我们可开始探索多代理架构，并回答以下问题：

> Will multi-agent architectures (e.g. supervisor) perform better than a single ReAct agent, when responsible for a large number of domains?

> 当需覆盖大量领域时，多代理架构（例如含监督器的架构）是否比单个 ReAct 代理表现更优？

To do this, we can benchmark against the same tasks we have created for this study, but with various multi-agent architectures. We will also look to build up new datasets of tasks, with longer trajectories and more complicated tool inputs, to further stress test both single agent and multi-agent architectures.

为此，我们可沿用本研究所构建的相同任务集，但采用多种多代理架构进行基准测试。此外，我们还将构建新的任务数据集——其任务轨迹更长、工具输入更复杂——以对单代理与多代理架构开展更严格的压力测试。

So far, we have also only explored tasks that require a single domain of knowledge to complete. It will be interesting to explore how multi-agent architectures perform on cross-domain tasks, that require tools and instructions from multiple domains. (e.g. A task that requires customer support, but also requires scheduling a follow up meeting).

截至目前，我们仅探索了仅需单一领域知识即可完成的任务。下一步值得探究的是：多代理架构在跨领域任务上的表现如何？这类任务需调用多个领域的工具与指令。（例如：一项任务既需提供客户支持，又需安排后续会议。）

> How will single agent architectures and multi-agent architectures perform on cross-domain tasks? And how will performance change as required trajectories increase?

> 单代理架构与多代理架构在跨领域任务上的表现将如何？随着所需任务轨迹长度的增加，其性能又将如何变化？

To benchmark this, we will continue to build up new domains of test cases in addition to calendar scheduling and customer support for our email assistant to handle.

为对此开展基准测试，我们将持续扩充测试用例所覆盖的新领域，除日历调度（calendar scheduling）和客户支持（customer support）外，进一步拓展邮件助手（email assistant）所能处理的任务范围。
{% endraw %}
