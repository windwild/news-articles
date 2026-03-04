---
render_with_liquid: false
title: "What we learned building agents at Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/what-we-learned-building-agents-at-vercel"
date: "2025-11-06"
scraped_at: "2026-03-02T09:25:54.505675608+00:00"
language: "en-zh"
translated: true
description: "We're presenting a simple methodology for discovering successful agent projects that perform well with current generation AI"
---
render_with_liquid: false
render_with_liquid: false

Nov 6, 2025

2025 年 11 月 6 日

Agents present incredible promise for increased productivity and higher quality outcomes in enterprises. Companies are already using them to streamline customer support, code reviews, and sales operations.

智能体（Agents）为企业提升生产力、产出更高质量成果带来了巨大潜力。众多企业已开始将其应用于优化客户服务、代码审查和销售运营等环节。

When building custom internal agents, the challenge isn't whether AI can create value, it's identifying the problems it's ready to solve today, at a cost that makes sense for the business.

在构建定制化内部智能体时，真正的挑战并非“AI 是否能创造价值”，而在于识别出那些 AI 当下即可切实解决、且投入成本符合企业商业逻辑的问题。

At Vercel, we are going through the same AI transformation as our customers. We use our own products to build agents that help us move faster and spend more time on meaningful work.

在 Vercel，我们正经历与客户相同的 AI 转型历程。我们使用自身产品构建智能体，以帮助团队加速推进工作，并将更多时间投入到真正有意义的任务中。

After months of experimentation, we’ve turned our learnings into a repeatable methodology for finding and investing in AI projects that have the highest likelihood of creating significant business impact.

经过数月的实践探索，我们将经验沉淀为一套可复用的方法论，用于甄别并投资于最有可能产生显著商业价值的 AI 项目。

## Finding the agentic sweet spot

## 寻找智能体应用的“黄金切入点”

Over time AI will touch nearly every workflow, handling complex tasks like our own [code review and anomaly investigation agent](https://vercel.com/blog/introducing-vercel-agent). Our intuition for what agents can do is skewed towards high expectations because coding agents like these are so amazing.

长远来看，AI 将渗透至几乎每一项工作流，承担起诸如我们自研的 [代码审查与异常调查智能体](https://vercel.com/blog/introducing-vercel-agent) 等复杂任务。我们对智能体能力的直觉判断往往偏向乐观——毕竟这类编程智能体的表现实在令人惊叹。

But most companies don’t have the engineering capacity to productionize that level of internal use case, and today’s models still face limits in reliability and precision in other domains. This is why we need to select problems that fit what today's frontier models are well suited for.

但大多数企业并不具备将如此高阶的内部用例投入生产的工程能力；同时，当前大模型在其他领域仍存在可靠性与精确度方面的局限。正因如此，我们必须精准选择那些契合当今前沿模型能力边界的现实问题。

We've learned that the highest likelihood of success for current-generation agentic AI comes from work that requires low cognitive load and high repetition from humans.

我们发现：当前一代智能体 AI 最易取得成功的场景，是那些人类执行时认知负荷低、但重复性高的工作。

![The sweet spot is human work with low cognitive load and high repetition](images/what-we-learned-building-agents-at-vercel-vercel/img_001.jpg)![The sweet spot is human work with low cognitive load and high repetition](images/what-we-learned-building-agents-at-vercel-vercel/img_002.jpg)![The sweet spot is human work with low cognitive load and high repetition](images/what-we-learned-building-agents-at-vercel-vercel/img_003.jpg)![The sweet spot is human work with low cognitive load and high repetition](images/what-we-learned-building-agents-at-vercel-vercel/img_004.jpg)The sweet spot is human work with low cognitive load and high repetition

![智能体应用的“黄金切入点”是人类执行时认知负荷低、重复性高的工作](images/what-we-learned-building-agents-at-vercel-vercel/img_001.jpg)![智能体应用的“黄金切入点”是人类执行时认知负荷低、重复性高的工作](images/what-we-learned-building-agents-at-vercel-vercel/img_002.jpg)![智能体应用的“黄金切入点”是人类执行时认知负荷低、重复性高的工作](images/what-we-learned-building-agents-at-vercel-vercel/img_003.jpg)![智能体应用的“黄金切入点”是人类执行时认知负荷低、重复性高的工作](images/what-we-learned-building-agents-at-vercel-vercel/img_004.jpg)智能体应用的“黄金切入点”是人类执行时认知负荷低、重复性高的工作

These tasks are too dynamic for traditional automation, but predictable enough for AI to handle reliably. They show up across businesses in data entry, research, qualification, and triage, where automation saves time and keeps quality consistent.

这些任务对传统自动化而言过于动态，却足够可预测，能够由 AI 可靠地处理。它们广泛出现在各类企业的数据录入、调研、资质审核与分诊等环节中——在这些场景下，自动化不仅能节省时间，还能持续保障工作质量。

This is the low-hanging fruit to tackle today, while models continue to mature toward reliably automating more complex tasks in the future.

这正是当下值得优先攻克的“低垂果实”；与此同时，AI 模型将持续演进，未来将能更可靠地自动化处理更复杂的任务。

## Our methodology for finding the right projects

## 筛选合适项目的实施方法

As simple as it sounds, we talked to our team about tasks that fit the sweet spot: mindless activities repeated often.

听上去很简单：我们与团队成员交流，梳理那些恰好处于“黄金区间”的任务——即频繁重复、无需深度思考的机械性工作。

Humans don’t love boring, repetitive work, so you can often find great ideas by asking questions like “what part of your job do you hate doing the most?” or “which tasks would you like to never do again?”

人类天生不喜欢枯燥、重复的工作，因此，你常常可以通过提问来激发优质创意，例如：“你最讨厌做的工作部分是什么？”或“哪些任务是你再也不想做的？”

Most use cases we’ve found have been relatively simple to automate and have yielded high-quality, measurable outcomes in productivity. Here are two specific examples:

我们迄今发现的大多数用例都相对易于自动化，并已在生产力方面产出高质量、可量化的成果。以下是两个具体实例：

### Lead processing agent

### 潜在线索处理智能体

We used to have a team of 10 people triaging leads that come through our website. When we asked the team’s top performer what they wished they never had to do again, they told us manually researching the information needed to make an initial qualification judgment was mind-numbing.

过去，我们曾配备一个由 10 人组成的团队，专门负责对我们网站获取的潜在客户线索进行初步分诊。当我们询问团队中业绩最佳的成员“你最希望永远不再做的工作是什么”时，对方坦言：为做出初步资质判断而手动搜集相关信息，令人感到极度乏味。

We shadowed that employee to learn their process, then [built an agent to automate initial qualification](https://www.businessinsider.com/ai-agent-entry-level-sales-jobs-vercel-2025-10). Now one person handles the work of 10 and the 9 other employees are focused on higher value, more complex sales work.

我们跟随这位员工实地观察其工作流程，随后[构建了一个智能体，实现初步资质判断的自动化](https://www.businessinsider.com/ai-agent-entry-level-sales-jobs-vercel-2025-10)。如今，仅需一人即可完成原先十人的工作量，其余九名员工则得以专注于更高价值、更复杂的销售任务。

Here’s the agent workflow:  

以下是该智能体的工作流程：

- Deep research - performs comprehensive research on the lead and their company  
- 深度调研——对潜在客户及其公司开展全面调研  

- Qualification - uses `generateObject` to categorize the lead  
- 资质评估——使用 `generateObject` 对潜在客户进行分类  

- Email composition - automatically generates a personalized follow-up email  
- 邮件撰写——自动生成个性化的跟进邮件  

- Human review - sends all of the information to Slack for human approval  
- 人工审核——将全部信息发送至 Slack，供人工审批  

- Approval & email send - catches a Slack webhook event upon human approval  
- 审批与邮件发送——在收到人工审批的 Slack Webhook 事件后触发执行  


### Anti-abuse agent  
### 反滥用智能体  

Our security team manages a steady flow of abuse reports, from phishing and spam to copyright violations. We take each case seriously because false positives can lead to wrongful takedowns, while misses risk leaving harmful content online.  
我们的安全团队持续处理大量滥用举报，涵盖网络钓鱼、垃圾邮件及版权侵权等各类问题。我们严肃对待每一起案件，因为误判（假阳性）可能导致错误下架，而漏判（假阴性）则可能使有害内容继续在线传播。  

Before automation, human reviewers investigated every report manually, running a formulaic process to make an initial judgment call.  
在实现自动化之前，所有举报均由人工审核员逐一手动调查，并遵循一套固定流程作出初步判定。  

We built an abuse platform agent that automatically takes potentially infringing or high-risk URLs, runs visual analysis, understands the page’s intention, and returns recommended actions for human validation.  
我们构建了一个反滥用平台智能体：它能自动接收涉嫌侵权或高风险的 URL，执行视觉分析，理解网页意图，并返回建议处置措施，供人工复核验证。  

Even in its first iteration, this workflow led to a 59% reduction in time to ticket closing, freeing the team to focus on edge cases that require more complex human reasoning.  
即便在首个版本中，该工作流已使工单平均关闭时间缩短了 59%，从而释放团队精力，专注于需更复杂人类判断的边缘案例。

Here’s the agent workflow:

以下是代理工作流：

- URL intake - retrieves new reports from the abuse queue

- URL 接入 — 从滥用报告队列中获取新报告

- Analysis - runs visual/textual analysis to detect phishing or copyright content

- 分析 — 执行视觉/文本分析，以识别钓鱼或侵犯版权的内容

- Recommendation - compiles findings and proposes an action plan

- 建议 — 汇总分析结果，并提出行动方案

- Human review - sends recommendation to a security engineer for final judgment

- 人工审核 — 将建议发送给安全工程师进行最终判定

- Resolution - records the decision and closes the ticket

- 结案 — 记录判定结果并关闭工单


## Get started with our agent templates

## 使用我们的代理模板快速上手

Everyone should begin asking their team the questions above, but you can get started immediately by using one of our agent templates.

每个人都应开始向团队提出上述问题；但您也可立即使用我们提供的任一代理模板快速启动。

We’ve open-sourced a range of agent examples meant to be used as the building blocks for custom agents.

我们已将一系列代理示例开源，这些示例可作为构建自定义代理的基础组件。

- [Lead processing agent](https://vercel.com/templates/ai/lead-processing-agent): Have AI perform the research grunt-work and do initial qualification, then validate with a human in the loop

- [线索处理代理](https://vercel.com/templates/ai/lead-processing-agent)：由 AI 完成调研类基础工作并进行初步资质筛选，再通过“人在环路”（human-in-the-loop）机制进行人工验证

- [Data analyst agent](https://vercel.com/templates/ai/oss-data-analyst-agent-reference-architecture): Converts natural language questions into SQL queries and performs data analysis using multi-phase reasoning  
- [数据分析师智能体（Data analyst agent）](https://vercel.com/templates/ai/oss-data-analyst-agent-reference-architecture)：将自然语言问题转化为 SQL 查询，并通过多阶段推理执行数据分析

- [Flight booking app](https://github.com/vercel/workflow-examples/tree/main/flight-booking-app): A conversational flight booking assistant with built-in retries, resume capabilities, and fault tolerance  
- [航班预订应用（Flight booking app）](https://github.com/vercel/workflow-examples/tree/main/flight-booking-app)：一款具备内置重试机制、断点续订能力及容错能力的对话式航班预订助手

- [Storytime Slackbot](https://github.com/vercel-labs/storytime-slackbot): An interactive, AI-powered Slack bot that creates collaborative children's stories with members of your Slack organization  
- [Storytime Slack 机器人（Storytime Slackbot）](https://github.com/vercel-labs/storytime-slackbot)：一款交互式、AI 驱动的 Slack 机器人，可与您 Slack 组织内的成员协作共创儿童故事

If your team want’s more direct support in finding and building high-ROI AI projects, we’re offering a [hands-on program](https://vercel.com/go/an-agent-on-every-desk) that guides you through use case discovery and agent implementation with our team of forward-deployed engineers.  
如果您的团队希望获得更直接的支持，以发掘并构建高投资回报率（ROI）的 AI 项目，我们正推出一项[实践型计划（hands-on program）](https://vercel.com/go/an-agent-on-every-desk)，由我方派驻一线的工程师团队全程指导您完成用例探索与智能体（agent）落地实施。