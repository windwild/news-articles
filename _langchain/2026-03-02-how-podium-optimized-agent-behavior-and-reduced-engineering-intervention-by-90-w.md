---
render_with_liquid: false
title: "How Podium optimized agent behavior and reduced engineering intervention by 90% with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-podium/"
date: "2026-03-02"
scraped_at: "2026-03-03T07:14:12.649422736+00:00"
language: "en-zh"
translated: true
description: "See how Podium tests across the lifecycle development of their AI employee agent, using LangSmith for dataset curation and finetuning. They improved agent F1 response quality to 98% and reduced the ne..."
tags: ["Case Studies"]
---
render_with_liquid: false
render_with_liquid: false

## **About Podium**

## **关于 Podium**

Podium is a communication platform that helps small businesses connect quickly with customers via phone, text, email, and social media. Small businesses often have high-touch interactions with customers — think automotive dealers, jewelers, bike shops — yet are understaffed. Podium's mission is to help these businesses respond to customer inquiries promptly so that they can convert leads into sales.

Podium 是一个通信平台，帮助小型企业通过电话、短信、电子邮件和社交媒体快速与客户建立联系。小型企业通常与客户保持高接触度的互动——例如汽车经销商、珠宝商、自行车店等——但往往人手不足。Podium 的使命是助力这些企业及时响应客户咨询，从而将潜在客户转化为实际销售。

Podium data shows that responding to customer inquiries within 5 minutes results in a 46% higher lead conversion rate than responding in an hour. To improve lead capture, Podium launched [AI Employee](https://www.podium.com/product/ai-employee/?ref=blog.langchain.com), their agentic application (and flagship product) to engage local business customers, schedule appointments, and close sales.

Podium 的数据显示：在 5 分钟内回复客户咨询，其潜在客户转化率比一小时内回复高出 46%。为提升线索捕获能力，Podium 推出了其智能体应用（也是旗舰产品）——[AI Employee](https://www.podium.com/product/ai-employee/?ref=blog.langchain.com)，用于与本地企业客户互动、预约安排及促成成交。

Initially, Podium used the LangChain framework for single-turn interactions. As their agentic use cases grew more complex for a wide-ranging set of customers and domains, Podium needed better visibility into their LLM calls and interactions — and turned to [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) for LLM testing and observability.

最初，Podium 使用 LangChain 框架处理单轮交互。随着其智能体应用场景面向更广泛客户群体与行业领域不断深化，复杂度持续提升，Podium 对大语言模型（LLM）调用与交互过程的可观测性提出了更高要求——于是转向 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)，以实现 LLM 的测试与可观测性管理。

## **Testing across the agentic development lifecycle**

## **贯穿智能体开发全生命周期的测试实践**

Establishing feedback loops was especially important to the agentic development lifecycle for Podium. LangSmith allowed the Podium engineers to test and continuously monitor their AI employee’s performance, adding new edge cases to their dataset to refine and test the model over time.

构建反馈闭环对 Podium 的智能体开发全生命周期尤为关键。LangSmith 使 Podium 工程师得以持续测试并监控其 AI Employee 的表现，并不断向数据集中添加新的边界案例，从而长期迭代优化与验证模型。

Podium’s testing approach looks like the following:

Podium 的测试方法如下所示：

1. **Baseline Dataset Curation:** Create an initial dataset to represent basic use cases and requirements for the agent. This serves as a foundation for testing and development.  
1. **基线数据集构建**：构建初始数据集，覆盖智能体的基本使用场景与功能需求，作为后续测试与开发的基础。

2. **Baseline Offline Evaluation:** Conduct initial tests using the curated dataset to assess the agent's performance against the basic requirements before shipping to production.  
2. **基线离线评估**：基于已构建的数据集开展初步测试，在上线生产环境前评估智能体是否满足基本功能需求。

3. **Collecting Feedback:**  
3. **收集反馈**：  
　1. **User-Provided Feedback:** Collect direct input from users interacting with the agent.  
　1. **用户反馈**：收集与智能体交互的真实用户直接输入。  
　2. **Online Evaluation:** Use LLMs to self-evaluate and monitor the quality of responses using in real-time, flagging potential issues for further investigation.  
　2. **在线评估**：利用大语言模型进行实时自评，持续监控响应质量，并对潜在问题自动标记以便深入排查。

4. **Optimization:**  
4. **优化环节**：  
　1. **Prompt Tuning:** Refine the prompts used to guide the agent's responses.  
　1. **提示词调优**：优化引导智能体生成响应的提示词（prompt）。  
　2. **Retrieval Tuning:** Adjust the retrieval mechanisms used to generate responses.  
　2. **检索调优**：调整用于生成响应的检索机制。  
　3. **Model Fine-Tuning:** Use traced data to further train and specialize the model for specific tasks.  
　3. **模型微调**：利用追踪记录的数据，对模型进行进一步训练，使其更适配特定任务。

5. **Ongoing Evaluation:**  
5. **持续评估**：  
　1. **Offline Evaluation:** Evaluate the agent's performance and identify opportunities for optimization using backtesting, pairwise comparisons, and other testing methods.  
　1. **离线评估**：通过回溯测试（backtesting）、成对比较（pairwise comparisons）及其他测试方法，评估智能体性能并识别优化机会。  
　2. **Dataset Curation:** Continuously update and expand the test dataset with new scenarios and edge cases for regression testing, ensuring new changes don't negatively impact existing capabilities.  
　2. **数据集维护**：持续更新并扩充测试数据集，纳入新场景与边界案例，支撑回归测试，确保新变更不会损害既有功能。

![](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_001.jpg)_How Podium creates testing loops for their agent_

![](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_001.jpg)_Podium 如何为其智能体构建测试闭环_

## **Dataset curation and fine-tuning agents with LangSmith**

## **借助 LangSmith 进行数据集构建与智能体微调**

Prior to LangSmith, understanding a customer inquiry and what steps employees should take to resolve the inquiry was difficult, since the Podium engineers made 20–30 LLM calls per interaction. With LangSmith, they quickly got set up and logged and viewed traces to aggregate insights.

在 LangSmith 推出之前，理解客户咨询内容以及员工应采取哪些步骤来解决问题十分困难，因为 Podium 的工程师每次交互需调用 20–30 次大语言模型（LLM）。借助 LangSmith，他们迅速完成部署，并通过记录和查看调用链（traces）高效聚合洞察。

One specific challenge Podium ran into with their AI Employee was that the agent struggled to recognize when a conversation had naturally ended, resulting in awkward repeated goodbyes. To address this, Podium began by creating a dataset in LangSmith with various conversation scenarios, including ways different conversations might conclude.

Podium 在其 AI 员工（AI Employee）上遇到的一个具体挑战是：智能体难以识别对话何时自然结束，导致反复、尴尬地告别。为解决该问题，Podium 首先在 LangSmith 中构建了一个涵盖多种对话场景的数据集，其中包括各类对话可能的结束方式。

Their engineering team then found it helpful to upgrade to a larger model, curating the outputs into a smaller model (using a technique called model distillation). Upgrading their model went smoothly since model inputs and outputs were automatically captured in LangSmith’s traces, allowing the team to easily curate datasets.

其工程团队随后发现，升级至更大规模的模型并将其输出“蒸馏”（distillation）为更小模型（即采用“模型蒸馏”技术）效果显著。由于 LangSmith 的调用链自动捕获了模型的全部输入与输出，模型升级过程十分顺利，团队得以轻松构建高质量数据集。

Podium engineers also enriched LangSmith traces with metadata on customer profiles, business types, and other parameters important to their business. They grouped traces using specific identifiers in LangSmith, making it easy to aggregate related traces during data curation. This enriched data enabled Podium to create a higher-quality and balanced dataset, which improved model fine-tuning and helped them avoid overfitting.

Podium 工程师还向 LangSmith 的调用链中注入了客户画像、企业类型及其他对业务至关重要的元数据。他们在 LangSmith 中利用特定标识符对调用链进行分组，使数据整理过程中关联调用链的聚合变得极为便捷。这些增强后的数据助力 Podium 构建出更高质、更均衡的数据集，从而提升了模型微调效果，并有效避免了过拟合。

With this balanced dataset, the Podium team then compared the results from their fine-tuned model against results from their original, larger model using [pairwise evaluations](https://blog.langchain.com/pairwise-evaluations-with-langsmith/#:~:text=Pairwise%20evaluation%20looks%20at%20the,not%20scoring%20each%20run%20individually.). This comparison allowed them to assess how well the upgraded model could improve the agent’s ability to know when to conclude a conversation.

依托这一均衡数据集，Podium 团队继而采用[成对评估（pairwise evaluations）](https://blog.langchain.com/pairwise-evaluations-with-langsmith/#:~:text=Pairwise%20evaluation%20looks%20at%20the,not%20scoring%20each%20run%20individually.)方法，将微调后模型的输出结果与其原始大规模模型的输出结果进行对比。该对比帮助团队精准评估升级后的模型在提升智能体“判断对话终止时机”能力方面的实际成效。

After fine-tuning, Podium’s new model showed significant improvement in detecting where natural conversation should end for its agent. Podium’s F1 scores with the fine-tune model experienced a 7.5% improvement, going from 91.7% to 98.6% to **exceed their quality threshold of 98%.**

微调完成后，Podium 的新模型在识别智能体对话自然终止点方面展现出显著提升。其 F1 分数由 91.7% 提升至 98.6%，**增幅达 7.5%，成功超越其设定的 98% 质量阈值**。

## **High-quality customer support for AI platform without engineering intervention**

## **无需工程师介入的 AI 平台高质量客户服务**

At Podium, engineers must understand when communications with customers go awry, so that they can keep shipping reliable and high-quality products.

在 Podium，工程师必须及时识别客户沟通中出现的异常，以确保持续交付稳定、高质量的产品。

Since publicly launching their AI Employee in January, it became critical for the Technical Product Specialists (TPS) at Podium to troubleshoot issues users were encountering in real-time. At Podium, the TPS team typically provides customer support for their small business customers. However, pinpointing the source of issues (and how to take action on them) was challenging.

自今年 1 月正式对外发布 AI 员工以来，Podium 的技术产品专家（Technical Product Specialists, TPS）团队亟需实时排查用户所遇问题。在 Podium，TPS 团队通常面向中小型企业客户提供客户支持。然而，准确定位问题根源（以及明确后续应对措施）一直颇具挑战性。

Giving the TPS team access to LangSmith provided clarity, allowing the team to quickly identify customer-reported issues and determine: _“Is this issue caused by a bug in the application, incomplete context, misaligned instructions, or an issue with the LLM?”_

向 TPS 团队开放 LangSmith 访问权限带来了清晰的诊断视角，使其能够快速定位客户反馈的问题，并准确判断：_“该问题是由应用程序缺陷、上下文缺失、指令偏差，还是大语言模型（LLM）自身问题所致？”_

For Podium, identifying the type of customer issue guided them to the appropriate interventions:

对于 Podium 而言，识别客户问题的类型有助于其采取恰当的干预措施：

- **For bugs in the application**: These are orchestration failures, such as an integration failing to return data. These require engineering intervention.  
- **应用程序缺陷**：此类问题属于编排失败，例如某项集成未能返回数据，需由工程团队介入处理。

- **For incomplete context:** LLM is missing information needed to answer a question. These can be remediated by the TPS team by adding additional content.  
- **上下文不完整**：大语言模型（LLM）缺少回答问题所必需的信息。此类问题可由 TPS 团队通过补充相关内容予以解决。

- **For misaligned instructions:** Instructions are based on business requirements; any issues in the requirements can affect agent behavior. These can be remediated by the TPS team making changes in the content authoring system to better suit business requirements.  
- **指令与业务目标不一致**：指令源于业务需求；若需求本身存在偏差，则会影响智能体（agent）的行为。此类问题可通过 TPS 团队在内容创作系统中调整指令，使其更贴合实际业务需求来解决。

- **For an LLM issue:** Even with necessary context, an LLM may produce unexpected or incorrect information. These require engineering intervention.  
- **大语言模型自身问题**：即使提供了充分的上下文，LLM 仍可能生成意外或错误的信息。此类问题需由工程团队介入处理。

For example, many car dealerships use Podium’s AI Employee to respond to customer inquiries. If the AI Employee mistakenly responds that a car dealership does not offer oil changes, the TPS team can use LangSmith’s playground feature to edit the system output and determine if a simple setting change in the Admin interface can resolve the issue.

例如，许多汽车经销商使用 Podium 的 AI 员工（AI Employee）自动回复客户咨询。若 AI 员工错误地回应“本店不提供机油更换服务”，TPS 团队即可利用 LangSmith 的 Playground 功能编辑系统输出，并判断是否仅需在管理后台（Admin interface）中调整某项简单设置即可解决问题。

![](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_002.jpg)_LangSmith Playground enables Podium’s support team to troubleshoot agent behavior without engineering intervention_

![](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_002.jpg)_LangSmith Playground 使 Podium 的支持团队无需工程介入即可排查智能体行为问题_

Before LangSmith, troubleshooting agent behavior often required engineering intervention. This was a time-consuming process that involved calling in engineers to first review model inputs and outputs, and then rewrite and refactor the code.

在引入 LangSmith 之前，排查智能体行为问题通常需要工程团队介入——这是一项耗时的过程：需先召集工程师审阅模型的输入与输出，再重写和重构相关代码。

By giving their TPS team access to LangSmith traces, Podium has **reduced the need for engineering intervention by 90%**, allowing their engineers to focus more on development instead of support tasks.

通过向 TPS 团队开放 LangSmith 的 trace（调用追踪）功能，Podium **将工程介入需求降低了 90%**，从而让工程师得以将更多精力投入开发工作，而非支持性任务。

In summary, using LangSmith led to:

综上所述，采用 LangSmith 带来了以下成效：

- Increased efficiency of Podium’s support team by enabling them to resolve issues more quickly and independently.  
- 显著提升 Podium 支持团队的工作效率，使其能够更快速、更独立地解决问题。

- Improved customer satisfaction (CSAT) scores for both support interactions and Podium’s AI-powered services.  
- 同时提升了客户支持交互环节及 Podium AI 驱动服务的整体客户满意度（CSAT）得分。

## **What’s Next for Podium**

## **Podium 的下一步规划**

By integrating LangSmith and LangChain, Podium has gained a competitive edge in the space of customer experience tools. LangSmith has enhanced observability and simplified the management of large datasets and optimizing model performance. The Podium team has also been integrating [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com) into its workflow, reducing complexity in their agent orchestration while serving different target customers, while increasing controllability over their agent conversations.

通过整合 LangSmith 与 LangChain，Podium 在客户体验工具领域确立了显著的竞争优势。LangSmith 大幅增强了系统可观测性，并简化了大规模数据集的管理以及模型性能优化流程。此外，Podium 团队正将 [LangGraph](http://langchain.com/langgraph?ref=blog.langchain.com) 深度融入其工作流，在面向不同目标客户群体提供服务的同时，降低了智能体编排的复杂度，并显著提升了对智能体对话流程的可控性。

Together, these suite of products have allowed Podium to focus on their core value proposition — help small businesses capture leads more effectively — and efficiently design, test, and monitor their LLM applications.

这些产品组合共同助力 Podium 聚焦于其核心价值主张——更高效地帮助中小企业获取潜在客户——并高效地设计、测试和监控其大语言模型（LLM）应用。

* * *

[**Podium is hiring**](https://www.podium.com/careers/?ref=blog.langchain.com) **across roles to help local businesses win. Inspired by Podium’s story? You can also try out** [**LangSmith for free**](http://smith.langchain.com/?ref=blog.langchain.com) **or** [**talk to a LangSmith expert**](https://bit.ly/langsmith-expert-blog?ref=blog.langchain.com) **to learn more.**

[**Podium 正在招聘**](https://www.podium.com/careers/?ref=blog.langchain.com) **多个岗位，助力本地企业赢得市场。Podium 的故事是否令您深受启发？您也可免费试用** [**LangSmith**](http://smith.langchain.com/?ref=blog.langchain.com) **，或** [**联系 LangSmith 专家**](https://bit.ly/langsmith-expert-blog?ref=blog.langchain.com) **进一步了解详情。**

**And for a more comprehensive best practices for testing and evaluating your LLM application, check out** [**this guidebook**](https://bit.ly/testing-guide-4?ref=blog.langchain.com) **.**

**如需全面了解 LLM 应用的测试与评估最佳实践，请查阅** [**本指南手册**](https://bit.ly/testing-guide-4?ref=blog.langchain.com) **。**

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_003.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_004.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_004.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph 通过 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_005.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone: Transforming Customer Experience with AI Agents using LangGraph and LangSmith**](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 7 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_006.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现对其客户成功智能体的可观测性](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_007.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对其客户成功专员工作状态的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟

[![Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/how-podium-optimized-agent-behavior-and-reduced-engineering-intervention-by-90-w/img_008.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟