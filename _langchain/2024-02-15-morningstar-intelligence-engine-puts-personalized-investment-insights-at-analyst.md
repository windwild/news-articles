---
title: "Morningstar Intelligence Engine puts personalized investment insights at analysts' fingertips"
source: "LangChain Blog"
url: "https://blog.langchain.com/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analysts-fingertips/"
date: "2024-02-15"
scraped_at: "2026-03-03T08:12:13.610384151+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
&#123;% raw %}

## **Challenge**

## **挑战**

Financial services is one of the most data-driven industries and financial professionals are always hungry for more data and better tools to drive value for their clients. [Morningstar](https://www.morningstar.com/company/about-us?ref=blog.langchain.com)–a publicly-traded investment research firm–has been compiling and analyzing fund, stock, and general market data for finance professionals since its founding in 1984.

金融服务是数据驱动程度最高的行业之一，金融从业者始终渴求更多数据和更优工具，以切实提升客户价值。[晨星公司（Morningstar）](https://www.morningstar.com/company/about-us?ref=blog.langchain.com)——一家上市的投资研究机构——自1984年创立以来，一直为金融专业人士持续汇编并分析基金、股票及整体市场数据。

Getting the most out of Morningstar and its products has historically required a deep familiarity with the financial landscape, an ability to parse meticulous research reports, and a mastery of their proprietary–and powerful–toolkit. With the rise of Generative AI, the Morningstar team saw an opportunity to make their data more accessible and more immediately useful to a wider range of users.

过去，要充分释放晨星及其产品的价值，用户需深度熟悉金融市场格局、具备精细研报的解读能力，并熟练掌握其专有（且功能强大）的工具套件。随着生成式人工智能（Generative AI）的兴起，晨星团队意识到一个契机：可借此让自身数据更易获取、更即刻可用，惠及更广泛的用户群体。

## **Solution**

## **解决方案**

Morningstar started by building a chatbot, Mo, that allows Morningstar customers to query their extensive research database using natural language in a conversational format to generate concise yet nuanced insights in seconds.

晨星首先开发了一款名为“Mo”的聊天机器人，使客户能够以自然语言、对话式交互的方式，查询其海量研究数据库，并在数秒内生成简洁而富有洞察力的分析结果。

The team also decided to extend the benefits of this innovation to their customers–often asset managers and wealth advisors–and enable them to build white-labeled chatbots and other AI tools of their own. Using their new platform, [Morningstar Intelligence Engine](https://www.morningstar.com/products/morningstar-intelligence-engine?ref=blog.langchain.com), Morningstar customers can now securely upload their own research information - to provide more context and personalization to Morningstar data - and then “whitelist” the chatbot for their end customers to use.

团队还决定将这项创新的益处延伸至其客户——通常是资产管理公司与财富顾问——赋能他们构建自有品牌的聊天机器人及其他AI工具。借助其全新平台：[晨星智能引擎（Morningstar Intelligence Engine）](https://www.morningstar.com/products/morningstar-intelligence-engine?ref=blog.langchain.com)，晨星客户如今可安全上传自身的研究资料，从而为晨星数据补充更多上下文信息并实现个性化；随后，还可将该聊天机器人“白名单化”，供其终端客户直接使用。

Several Morningstar team members were already familiar with LangChain through their contributions to the open source repository. The collaborative, community-driven spirit first drew the team to LangChain. When it came time to build a production-ready application, LangChain was the obvious choice because:

多名晨星团队成员此前已通过参与开源代码库贡献，对 LangChain 熟悉有加。LangChain 所倡导的协作精神与社区共建理念，最初便深深吸引了该团队。当进入构建生产级应用阶段时，LangChain 成为了不二之选，原因如下：

- **LangChain offered a robust framework** **for initiating LLM-powered application** development. The concepts and ideas presented in LangChain were easily comprehensible and implementable from prototype to production, which expedited the team’s development process.

- **LangChain 提供了稳健的框架，助力启动大语言模型（LLM）驱动的应用开发**。LangChain 所提出的概念与设计思路清晰易懂，从原型验证到生产部署均易于实现，显著加快了团队的开发进程。

- **LangChain had a blueprint for RAG applications**, making discovery and summarization easy. Morningstar integrated various essential concepts from LangChain, including prompt templates, RAG-based approach, the ReAct framework, creating vector embeddings, LangChain evaluators, function calling, and output parsing. The choice of retrieval techniques improved performance out-of-the-box.

- **LangChain 为检索增强生成（RAG）类应用提供了成熟蓝图**，极大简化了信息发现与内容摘要流程。晨星整合了 LangChain 中多项核心能力，包括提示词模板（prompt templates）、RAG 方法论、ReAct 框架、向量嵌入（vector embeddings）构建、LangChain 评估器（evaluators）、函数调用（function calling）以及输出解析（output parsing）。所选用的检索技术开箱即用，显著提升了系统性能。

- **LangChain helped with edge cases like retries** that helped harden Morningstar’s application

- **LangChain 妥善处理了重试等边界场景问题**，有效增强了晨星应用的健壮性。

- **LangChain integrations provided** wide-ranging support across various vector databases, enhancing its versatility and applicability.

- **LangChain 的集成能力覆盖多种向量数据库**，大幅提升了其灵活性与适用性。

- **“LangChain introduced critical cognitive architectures that facilitate a better grasp of generative AI**, enriching our team’s understanding of this evolving technology,” said Jinyoung Kim, Head of Development. “The LangChain team keeps up the rapidly-evolving corpus of research, and then implements that into LangChain so we can benefit from the latest advances.”

- 晨星开发负责人金珍英（Jinyoung Kim）表示：“**LangChain 引入了关键的认知架构，有助于我们更深入地理解生成式人工智能**，从而深化团队对这一快速演进技术的认知。LangChain 团队持续追踪前沿研究成果的迅猛发展，并迅速将其落地集成至 LangChain 中，使我们得以即时受益于最新技术进展。”

Morningstar Intelligence Engine went from idea to production in under 60 days with a lean team of 5 developers.

凭借一支仅5人的精干开发团队，“晨星智能引擎”从构想到正式上线仅耗时不到60天。

## **Results**

## **成果**

“近40年来，客户一直信赖我们，为我们提供前沿洞察与工具，助力他们做出更明智的投资决策。”晨星公司首席技术官亚当·惠特（Adam Wheat）表示，“通过推出并持续迭代‘智能引擎’（Intelligence Engine），晨星延续了其一贯传统——打造创新型产品，为客户创造更大价值。”

“近40年来，客户一直信赖我们，为我们提供前沿洞察与工具，助力他们做出更明智的投资决策。”晨星公司首席技术官亚当·惠特（Adam Wheat）表示，“通过推出并持续迭代‘智能引擎’（Intelligence Engine），晨星延续了其一贯传统——打造创新型产品，为客户创造更大价值。”

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_001.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI 智能体重塑客户体验](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体](images/morningstar-intelligence-engine-puts-personalized-investment-insights-at-analyst/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
&#123;% endraw %}
