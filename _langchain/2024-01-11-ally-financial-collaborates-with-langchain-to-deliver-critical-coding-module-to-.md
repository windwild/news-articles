---
title: "Ally Financial Collaborates with LangChain to Deliver Critical Coding Module to Mask Personal Identifying Information in a Compliant and Safe Manner"
source: "LangChain Blog"
url: "https://blog.langchain.com/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-mask-personal-identifying-information-in-a-compliant-and-safe-manner/"
date: "2024-01-11"
scraped_at: "2026-03-03T08:18:26.049636228+00:00"
language: "en-zh"
translated: true
tags: ["Case Studies"]
---
{% raw %}

Ally Financial, the largest digital-only bank in the US and a leading auto lender, has recently collaborated with LangChain to release the first initial coding module that addresses a significant challenge for AI developers working with personal identifiable information (PII) in highly regulated, consumer-focused industries. The PII Masking module - available [here](https://js.langchain.com/docs/modules/experimental/mask/?ref=blog.langchain.com) \- provides a starting point for organizations that frequently handle customer PII during the normal course of business – including those in financial services, healthcare and retail - to build generative AI applications that also protect customer data.

美国最大的纯数字银行、同时也是领先的汽车贷款机构 Ally Financial 近日携手 LangChain，发布了首个初始编码模块，旨在解决人工智能开发者在高度监管、以消费者为中心的行业中处理个人身份信息（PII）时面临的一项重大挑战。该 PII 屏蔽（Masking）模块现已上线，[点击此处访问](https://js.langchain.com/docs/modules/experimental/mask/?ref=blog.langchain.com)。该模块为那些在日常业务中频繁处理客户 PII 的组织——包括金融服务、医疗健康和零售等行业——提供了起点，助力其构建既能发挥生成式 AI 能力、又能切实保护客户数据的 AI 应用。

### Releasing Ally.ai Built with LangChain

### 基于 LangChain 构建的 Ally.ai 正式发布

The PII Masking module, built with support from LangChain, was created for Ally.ai, the company’s proprietary, cloud-based AI platform that would serve as a secure bridge between Ally data and commercially available LLMs. Ally was an early adopter of generative AI in the financial services industry, launching the platform in September 2023. The company’s first use case with Ally.ai harnessed the power of the platform to assist the Customer Care & Experience team as they interacted with thousands of customers per day.

该 PII 屏蔽模块在 LangChain 的技术支持下开发完成，专为 Ally.ai 打造——这是 Ally 公司自主研发的云原生 AI 平台，旨在安全连接 Ally 内部数据与商用大语言模型（LLM）。Allly 是金融服务业中生成式 AI 的早期采用者，于 2023 年 9 月正式推出 Ally.ai 平台。其首个落地场景即赋能客户关怀与体验（Customer Care & Experience）团队：该团队每日需与数千名客户互动，而 Ally.ai 正为其提供关键支持。

Ally.ai assists more than 700 customer care associates in summarizing the conversations between them and Ally customers. The platform, which is connected to commercial grade LLMs, assists them by sharing a full transcript of each customer call, which is then summarized by the LLM. In the highly-regulated banking sector, PII should be stripped out before summarization by the LLM occurs.

目前，Ally.ai 已协助超过 700 名客户关怀专员，高效完成其与 Ally 客户之间通话内容的摘要生成。该平台已接入商用级大语言模型（LLM），可自动提供每通客户来电的完整文字记录，并由 LLM 进行摘要提炼。而在监管极为严格的银行业，所有 PII 必须在交由 LLM 摘要处理前被彻底剥离。

With the help of LangChain software, Ally’s developers created a module for Ally.ai that would mask various forms of PII, including names, email addresses, account numbers and much more. Because LangChain gave the Ally team the building blocks and framework to ship and iterate quickly, they could solve a critical challenge while moving the project along. Ally.ai was built by a team of five engineers in just two months. The platform has already made an impact on the business, specifically the Customer Care associates receiving the call summaries:

在 LangChain 软件的支持下，Ally 的开发团队为 Ally.ai 构建了一个专用模块，可对多种类型的 PII（包括姓名、电子邮箱地址、账户号码等）进行自动屏蔽。LangChain 为 Ally 团队提供了开箱即用的基础组件与开发框架，使其得以快速交付并持续迭代，从而在推进项目整体进度的同时，成功攻克这一关键难题。整个 Ally.ai 平台仅由五名工程师耗时两个月即完成开发。该平台已切实为业务带来积极影响，尤其显著提升了接收通话摘要的客户关怀专员的工作效能：

- Ally.ai has saved between 30 seconds and two minutes per customer call, allowing associates to quickly finalize their customer call summaries  
- Upwards of 85% of call summaries require no additional edits from associates, a testament to the strength of the platform  
- Associates also said that Ally.ai summarizations have helped them focus their energy on meaningful customer interactions and have reduced the amount of time needed to document the conversation and toggle between screens.

- Ally.ai 每通客户来电平均节省 30 秒至 2 分钟，使专员能更迅速地完成通话摘要；  
- 超过 85% 的通话摘要无需专员额外编辑，充分印证了平台的高可靠性；  
- 专员们还反馈，Ally.ai 的摘要能力帮助他们将精力集中于更有价值的客户互动上，同时大幅减少了记录对话内容及在不同界面间切换所需的时间。

“As a digital bank that serves more than 11 million customers, we want to put the right technology into the hands of our teammates so they can be more productive and provide excellent service. We see so much opportunity in the power of generative AI for our business, and we use LangChain to get to production quickly. The Ally.ai platform allows our team to spend more time with customers while also being more efficient than ever before.” – Sathish Muthukrishnan, Chief Information, Data and Digital Officer at Ally

“作为一家服务超 1100 万客户的数字银行，我们希望将合适的技术交到团队成员手中，助其提升工作效率、提供卓越服务。我们充分认识到生成式 AI 对自身业务的巨大潜力，而 LangChain 正是我们快速实现生产落地的关键工具。Ally.ai 平台使我们的团队既能更深入地陪伴客户，又能以前所未有的效率开展工作。”——Ally 首席信息、数据与数字官 Sathish Muthukrishnan

### Enhancing Security and Compliance + Contributing PII Filtering to LangChain

### 强化安全与合规能力 + 向 LangChain 贡献 PII 过滤功能

While Ally moves quickly, they do so with great care and consideration because they operate in a regulated industry. Security and customer data privacy are front and center of all their initiatives, and with Ally.ai, the Ally team had to be confident that no PII data was sent to LLMs. PII filtering was a requirement of the product in order to ensure security best practices. Achieving this, however, took considerable work because PII data can come in many forms, and during any real-time conversation with a user, there’s risk that the user might share sensitive information unprompted.

Ally 在追求敏捷开发的同时，始终秉持审慎严谨的态度——这源于其所处行业的强监管属性。安全防护与客户数据隐私是 Ally 所有技术举措的核心关切。在 Ally.ai 的建设过程中，团队必须确保没有任何 PII 数据被发送至大语言模型（LLM）。因此，PII 过滤成为产品设计中一项强制性的安全最佳实践要求。然而，实现这一点颇具挑战：PII 数据形态多样，且在任何实时用户对话中，用户都可能在无提示情况下主动透露敏感信息。

In order to release the Ally.ai platform in a manner that adhered to the bank’s governance and compliance needs, the Ally team added their own PII filtering to the LangChain code, which masked all sensitive data _before_ it was sent to the LLM. The result was a new PII Masking module that could first identify potential PII, mask it before it goes to an LLM, and then rehydrate the PII once a summary or other output comes back from the LLM. Essentially, the PII Masking module has two-way communication with the LLM – both before and after data is shared.

为确保 Ally.ai 平台的发布完全符合银行自身的治理与合规要求，Ally 团队在 LangChain 原有代码基础上，自主集成了专属的 PII 过滤逻辑——所有敏感数据均在发送至 LLM **之前**即完成屏蔽。最终成果即为全新发布的 PII Masking 模块：它可首先识别潜在的 PII 信息，在数据传入 LLM 前完成屏蔽，并在 LLM 返回摘要或其他输出结果后，再将原始 PII 信息“还原”（rehydrate）回结果中。本质上，该 PII 屏蔽模块与 LLM 实现了双向交互——既在数据输入前介入，也在输出返回后参与处理。

Ally’s approach to PII filtering was so successful that the Ally team wanted to give back to the LangChain community by contributing their code so that others could benefit.

Ally 对 PII（个人身份信息）过滤的处理方法取得了巨大成功，因此 Ally 团队希望回馈 LangChain 社区，开源其代码，让其他开发者也能从中受益。

Muthurkrishnan continued: “The LangChain ecosystem evolves rapidly, and we’ve benefited from the typescript package while developing the Ally.ai platform. We wanted to give back to the community, so we’ve open sourced our code in the langchain-community package. We’re thrilled that other financial institutions, or other companies operating in regulated industries, could benefit from what we’ve created.”

穆图克里希南继续说道：“LangChain 生态系统发展极为迅速，我们在开发 Ally.ai 平台过程中，充分受益于其 TypeScript 包。我们希望反哺社区，因此已将相关代码开源至 `langchain-community` 包中。我们非常欣喜地看到，其他金融机构，乃至所有处于强监管行业的企业，都能从我们所构建的成果中获益。”

### The Road Ahead

### 未来之路

The initial results of Ally.ai has encouraged the Ally team to forge ahead with pursuing almost 200 AI use cases throughout the enterprise. While not all of them will make it to production – Ally has begun final evaluations on two additional use cases – one with the marketing content and SEO team, and a second one with Ally’s investor relations group. Both of these use cases lean into optimizing employee productivity and improving business processes. For example, the marketing content team has seen the time needed to launch campaigns reduced by up to 2-3 weeks. As more use cases are tested and evaluated through Ally’s extensive governance process, what will be a constant is the use of Ally.ai – with the necessary privacy and security features in place – as the company expands its AI capabilities.

Ally.ai 的初步成果极大地鼓舞了 Ally 团队，推动其在全公司范围内持续推进近 200 个 AI 应用场景。尽管并非所有场景都会最终上线——目前 Ally 已进入另外两个新用例的最终评估阶段：一个面向营销内容与 SEO 团队，另一个面向 Ally 的投资者关系团队。这两个用例均聚焦于提升员工生产力与优化业务流程。例如，营销内容团队已实现活动上线周期缩短达 2–3 周。随着更多应用场景在 Ally 严谨而全面的治理流程中持续测试与评估，“Ally.ai”平台——始终配备完善的隐私与安全机制——将成为公司拓展 AI 能力过程中一以贯之的核心基础设施。

“We’re not standing still, and neither is the developer community,” Muthukrishnan said. “We hope that by making this contribution and collaborating with LangChain, our actions will serve as a model to other organizations who want to harness the power of AI in a responsible way that positively serves consumers and our community.”

“我们从未止步，开发者社区亦然。”穆图克里希南表示，“我们希望通过此次贡献及与 LangChain 的协作，为其他希望以负责任方式善用 AI 技术、切实造福消费者与社会的组织树立典范。”

For more insights from the technology team at Ally, including how the team is doing it right with AI and exploring new innovation, visit [https://ally.tech](https://ally.tech/?ref=blog.langchain.com). You can read more about their announcement too – [here](https://ally.tech/ally-gives-back-to-langchain-ai-community-with-pii-masking-module-137a8701cdaa?ref=blog.langchain.com).

如需了解更多 Ally 技术团队的洞见——包括他们如何正确落地 AI 应用、探索前沿创新，请访问 [https://ally.tech](https://ally.tech/?ref=blog.langchain.com)。您也可在此阅读本次开源公告的详细内容：[此处](https://ally.tech/ally-gives-back-to-langchain-ai-community-with-pii-masking-module-137a8701cdaa?ref=blog.langchain.com)。

“Our goal is for LangChain to be ubiquitous. We designed the framework to be useful no matter the size of the company or the industry it operates in. Ally pushed the boundaries and solved a real problem that we see many companies run up against. We’re grateful that Ally decided to support our mission and contribute back so that others could benefit, and we’re excited to continue to partner with Ally to evolve LangChain to serve financial institutions even better.” – Harrison Chase, CEO of LangChain

“我们的目标是让 LangChain 无处不在。我们设计该框架时，就致力于使其适用于任何规模、任何行业的企业。Ally 突破了技术边界，解决了一个我们观察到许多企业普遍面临的实际难题。我们由衷感谢 Ally 决定支持 LangChain 的使命，并将成果回馈社区，惠及更多开发者；我们也非常期待继续与 Ally 深化合作，进一步优化 LangChain，更好地服务金融行业。”——LangChain 首席执行官 Harrison Chase

**_About Ally Financial_**

**_关于 Ally Financial_**

_Ally Financial Inc. (NYSE: ALLY) is a financial services company with the nation's largest all-digital bank and an industry-leading auto financing business, driven by a mission to "Do It Right" and be a relentless ally for customers and communities. The company serves more than 11 million customers through a full range of online banking services (including deposits, mortgage, point-of-sale personal lending, and credit card products) and securities brokerage and investment advisory services. The company also includes a robust corporate finance business that offers capital for equity sponsors and middle-market companies, as well as auto financing and insurance offerings. For more information, please visit www.ally.com and follow @allyfinancial._

Ally Financial Inc.（纽约证券交易所代码：ALLY）是一家金融服务公司，运营着美国规模最大的纯数字银行，并拥有行业领先的汽车金融业务。公司秉持“做对的事”（Do It Right）使命，矢志成为客户与社区坚定不移的伙伴。Ally 通过全面的线上银行服务（涵盖存款、房贷、消费贷及信用卡等产品），以及证券经纪与投资顾问服务，为逾 1100 万客户提供支持。此外，公司还拥有实力雄厚的企业金融业务，为私募股权基金及中型企业提供资本支持，并提供汽车金融与保险服务。欲了解更多信息，请访问 www.ally.com，并关注 @allyfinancial。

**_About LangChain_**

**_关于 LangChain_**

_LangChain, Inc. was founded in early 2023 to help developers build context-aware reasoning applications. The company’s popular open source framework gives developers the building blocks to create production-ready applications with LLMs. LangChain’s open standard benefits from the force of the community; it keeps pace with the cutting edge, so companies can too. With 600+ tool integrations, 60+ models supported, and easy adoption of the latest cognitive architectures, LangChain gives companies choice, flexibility, and a build-kit to move fast. LangSmith complements as an all-in-one SaaS platform that enables a full, end-to-end, development workflow for building and monitoring LangChain and LLM-powered apps._

_LangChain, Inc. 于 2023 年初成立，旨在帮助开发者构建具备上下文感知能力的推理应用。该公司广受欢迎的开源框架为开发者提供了构建面向生产环境的大语言模型（LLM）应用所需的核心组件。LangChain 的开放标准得益于社区的强大推动力；它始终紧跟技术前沿，从而助力企业同步实现创新突破。凭借对 600 多种工具的集成支持、对 60 多种模型的兼容性，以及对最新认知架构的便捷采用，LangChain 赋予企业充分的选择权、高度的灵活性，以及一套可快速落地的开发套件。LangSmith 作为一款一体化 SaaS 平台，与 LangChain 形成互补，全面支持从开发、调试到监控的端到端工作流，助力企业高效构建和运维基于 LangChain 与大语言模型的应用。_

### Tags

### 标签

[Case Studies](https://blog.langchain.com/tag/case-studies/)

[案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_001.png)](https://blog.langchain.com/customers-monday/)

[![monday Service + LangSmith：从第一天起构建以代码为中心的评估策略](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_001.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith: Building a Code-First Evaluation Strategy from Day 1**](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为中心的评估策略**](https://blog.langchain.com/customers-monday/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 8 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：8 分钟

[![How Remote uses LangChain and LangGraph to onboard thousands of customers with AI](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_002.png)](https://blog.langchain.com/customers-remote/)

[![Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻流程](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_002.png)](https://blog.langchain.com/customers-remote/)

[**How Remote uses LangChain and LangGraph to onboard thousands of customers with AI**](https://blog.langchain.com/customers-remote/)

[**Remote 如何借助 LangChain 和 LangGraph，利用 AI 为数千名客户完成自动化入驻流程**](https://blog.langchain.com/customers-remote/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 5 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：5 分钟

[![Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI Agent 转型客户体验](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：利用 LangGraph 和 LangSmith 通过 AI Agent 转型客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_004.png)](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能个体创业者**](https://blog.langchain.com/customers-jimdo/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![ServiceNow 如何利用 LangSmith 实现对客户成功 Agent 的可观测性](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_005.png)](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现对客户成功 Agent 的可观测性**](https://blog.langchain.com/customers-servicenow/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![Monte Carlo：基于 LangGraph 和 LangSmith 构建数据与 AI 可观测性 Agent](images/ally-financial-collaborates-with-langchain-to-deliver-critical-coding-module-to-/img_006.png)](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo: Building Data + AI Observability Agents with LangGraph and LangSmith**](https://blog.langchain.com/customers-monte-carlo/)

[**Monte Carlo：使用 LangGraph 和 LangSmith 构建数据与 AI 可观测性智能体**](https://blog.langchain.com/customers-monte-carlo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长：4 分钟
{% endraw %}
