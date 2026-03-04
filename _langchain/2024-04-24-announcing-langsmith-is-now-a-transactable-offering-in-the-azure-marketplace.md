---
title: "Announcing LangSmith is now a transactable offering in the Azure Marketplace"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/"
date: "2024-04-24"
scraped_at: "2026-03-03T08:03:42.211657352+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---
{% raw %}

Today, we’re thrilled to announce that enterprises can purchase [LangSmith in the Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/langchain.langsmith?tab=Overview&ref=blog.langchain.com) as an Azure Kubernetes Application.  
今天，我们非常激动地宣布：企业 now 可通过 Azure Marketplace 以“Azure Kubernetes 应用”的形式采购 [LangSmith](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/langchain.langsmith?tab=Overview&ref=blog.langchain.com)。

[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) is a unified DevOps platform for developing, collaborating, testing, and monitoring LLM applications, whether you’re building with LangChain or not.  
[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 是一个统一的 DevOps 平台，专为大语言模型（LLM）应用的开发、协同、测试与监控而设计——无论您是否使用 LangChain 构建应用。

LangSmith has quickly become the platform of choice to help enterprises get their LLM-apps from prototype to production, and LangSmith customers such as Moody’s, Elastic, Rakuten, and BCG rely on the platform to build high quality genAI applications that scale.  
LangSmith 已迅速成为助力企业将 LLM 应用从原型快速推向生产的首选平台；穆迪（Moody’s）、Elastic、乐天（Rakuten）和波士顿咨询集团（BCG）等 LangSmith 客户，均依托该平台构建高质量、可规模化落地的生成式 AI（genAI）应用。

“As a leader in innovation and technology, Moody’s prioritizes thorough testing and evaluation of our Generative AI-powered tools. In order to create applications that are reliable for the enterprise and our customers, LangSmith helps maintain engineering rigor throughout the development and testing phases, allowing us to stress test our LLM-powered applications well before we release them. This gives us confidence as we continue harnessing Generative AI in our mission to decode risk and unlock opportunity.” – Han-chung Lee, Director of Machine Learning at Moody’s.  
“作为创新与技术领域的领导者，穆迪高度重视对生成式 AI 工具的全面测试与评估。为打造既满足企业级可靠性要求、又值得客户信赖的应用，LangSmith 在整个开发与测试阶段持续保障工程严谨性，使我们得以在正式发布前就对 LLM 驱动的应用进行充分的压力测试。这为我们持续推进生成式 AI 战略——解码风险、释放机遇——提供了坚实信心。”  
——穆迪公司机器学习总监 Han-chung Lee

We’re excited to lean into our collaboration with Microsoft by giving our joint customers an easier procurement option via Azure Marketplace, with a data security posture that satisfies even the most demanding infosec and compliance teams.  
我们非常期待深化与微软的合作：通过 Azure Marketplace，为双方共同客户带来更便捷的采购路径，其数据安全架构亦能满足最严苛的信息安全（infosec）与合规团队的要求。

To learn more about LangSmith and the benefits that come with the Azure Marketplace, continue reading or [get in touch](https://www.langchain.com/contact-sales?ref=blog.langchain.com) today.  
如需深入了解 LangSmith 及其通过 Azure Marketplace 采购所享有的各项优势，请继续阅读，或立即 [联系我们](https://www.langchain.com/contact-sales?ref=blog.langchain.com)。

### Benefits of LangSmith  
### LangSmith 的核心优势  

Through LangSmith’s debugging, testing, monitoring, and prompt management modules, enterprise customers benefit from:  
借助 LangSmith 的调试、测试、监控与提示词（prompt）管理模块，企业客户可获得以下价值：

- **Increased visibility of user interactions with their production LLM-applications**: LangSmith gives engineering teams trace-level detail on what their end users are asking their LLM-apps and how the app is responding in production. With easy to augment traces with end-user feedback, LangSmith provides the observability needed for remediation and continual improvement. LangSmith offers teams peace of mind on  
  - performance and quality,  
  - audibility of conversations, and  
  - explainability when interactions fall short of expectations.  
- **提升生产环境中 LLM 应用与用户交互的可观测性**：LangSmith 向工程团队提供细粒度的调用链（trace）级洞察，清晰呈现终端用户向 LLM 应用提出的问题，以及应用在生产环境中的实际响应。通过便捷地将终端用户反馈注入调用链，LangSmith 提供了支撑问题修复与持续优化所需的可观测能力。LangSmith 让团队对以下三方面高枕无忧：  
  - 应用性能与质量，  
  - 对话过程的可审计性（audibility），以及  
  - 当交互结果未达预期时的可解释性（explainability）。

- **More complete testing coverage to improve application quality:** LLM-apps are powerful, but have peculiar characteristics. The non-determinism, coupled with unpredictable, natural language inputs, make for countless ways the system can fail. LangSmith re-imagines traditional software engineering testing to be better suited for working with LLMs. With LangSmith’s Testing & Evaluation module, developers can build confidence in how their application will perform _before_ shipping it to end users. LangSmith helps developers spot regressions and identify if changes to the application logic are moving key metrics in the right direction.  
- **更全面的测试覆盖，显著提升应用质量**：LLM 应用功能强大，但具有独特属性——其输出具有不确定性（non-determinism），加之输入为不可预测的自然语言，导致系统存在海量潜在失效路径。LangSmith 重构了传统软件工程测试范式，使其更契合 LLM 开发场景。借助 LangSmith 的“测试与评估”（Testing & Evaluation）模块，开发者可在应用交付终端用户前，即对其实际表现建立充分信心；LangSmith 还能帮助开发者及时发现性能退化（regressions），并精准判断应用逻辑变更是否正向推动关键指标演进。

- **Improved application development velocity and collaboration with subject matter experts:** LangSmith helps developers debug their application traces to pinpoint where an agent or chain is going off the rails. LangSmith also improves developer collaboration with subject matter experts (e.g. product managers or quality assurance teams) on prompt construction and labeling feedback that often need more end user or industry knowledge.  
- **加速应用开发进程，并强化开发者与领域专家的协作**：LangSmith 协助开发者深入分析调用链，精准定位智能体（agent）或链（chain）运行异常的具体环节；同时，LangSmith 还优化了开发者与领域专家（例如产品经理、质量保障团队）在提示词构建与反馈标注等环节的协作效率——这些工作往往高度依赖终端用户视角或行业专业知识。

- **Clearer ROI analysis to make better business tradeoffs.** When building LLM applications, you almost always are trading off amongst quality, cost, and latency. LangSmith helps teams run experiments to examine metrics related to these three, so that developers can back up their choices with data, helping them prioritize what matters and keep spend in check.  
- **更清晰的投资回报率（ROI）分析，助力科学权衡业务决策**：构建 LLM 应用时，质量、成本与延迟三者之间几乎总是存在权衡取舍。LangSmith 支持团队开展实验，系统性地考察上述三类关键指标，使开发者得以用数据支撑决策，从而聚焦真正重要的目标，并有效管控投入成本。

### Benefits of procuring LangSmith through the Azure Marketplace  
### 通过 Azure Marketplace 采购 LangSmith 的优势  

When you purchase LangSmith through the Azure Marketplace, you’ll keep data fully contained in your Azure VPC, get ease of deployment, and experience a smoother procurement process.  
当您通过 Azure Marketplace 采购 LangSmith 时，您的全部数据将严格保留在 Azure 虚拟私有云（VPC）内，部署流程更加便捷，整体采购体验也更为顺畅。

- **LangSmith will run in your Azure VPC so no data is shared with a 3rd-party.** As a monitoring platform, LangSmith logs a tremendous amount of useful information about what end users are asking of your LLM-applications and how your app responds. When you purchase LangSmith as an Azure Kubernetes Application, we’ll deploy the entire platform in your environment, so no data leaves your network and you have full control over data management. Additionally, infosec teams will appreciate that the Microsoft team has already vetted and certified the LangSmith offering and will continually run security vulnerability scans on our images to keep customers’ data and environments safe.  
- **LangSmith 将运行于您的 Azure VPC 内，确保数据绝不共享给任何第三方**：作为一款监控平台，LangSmith 会记录海量有价值的信息，涵盖终端用户向您的 LLM 应用提出的问题及其响应内容。当您以“Azure Kubernetes 应用”形式采购 LangSmith 时，我们将整套平台部署至您的专属环境中——这意味着所有数据均不会离开您的网络，您对数据管理拥有完全自主权。此外，信息安全团队还将欣慰地看到：微软团队已对 LangSmith 解决方案完成严格审核与认证，并将持续对我们的容器镜像执行安全漏洞扫描，全力守护客户的数据与运行环境安全。

- **Deploying LangSmith to Azure Kubernetes Service (AKS) has never been easier.** We will provide you with a trial license and then production license, upon transaction, to deploy LangSmith and its dependencies to your AKS or OpenShift cluster. With a deep integration with Azure Resource Manager (ARM) APIs, LangSmith via the Azure Marketplace will be simple to set up and integrate. You’ll receive a minor release every six weeks and get white-glove support from our infra team to help with deployment, updates, and on-going scalability maintenance.  
- **将 LangSmith 部署至 Azure Kubernetes 服务（AKS）从未如此简单**：交易完成后，我们将为您提供试用许可证及正式生产许可证，助您将 LangSmith 及其全部依赖组件一键部署至 AKS 或 OpenShift 集群。得益于与 Azure 资源管理器（ARM）API 的深度集成，通过 Azure Marketplace 获取的 LangSmith 具备极简的安装与集成体验。您每六周即可获得一次小版本更新，并享有我们基础设施团队提供的“白手套”（white-glove）级支持——涵盖部署协助、版本升级及长期可扩展性维护。

- **You can retire credits from your Microsoft Azure Consumption Commitment (MACC).** Many Azure customers rely on the full Microsoft suite of products to solve their infrastructure and development needs. LangSmith has met the requirements for IP co-sell, meaning you not only can use your Azure credits to purchase LangSmith, but also every dollar you spend on LangSmith will net against your MACC, making the process of budget approval easier on teams.  
- **您可使用 Microsoft Azure 消费承诺（MACC）额度抵扣 LangSmith 费用**：众多 Azure 客户依赖完整的微软产品套件来满足其基础设施与开发需求。LangSmith 已满足微软“知识产权联合销售”（IP co-sell）计划的各项要求——这意味着您不仅可用 Azure 信用额度直接采购 LangSmith，且每一美元 LangSmith 支出均可全额计入 MACC 抵扣额度，从而大幅简化团队预算审批流程。

### Furthering LangChain’s collaboration with Microsoft

### 深化 LangChain 与微软的合作

We’re continuing to invest in LangChain’s technology collaboration with Azure AI services with deep integrations with Azure OpenAI, Azure AI Search, Microsoft Fabric, and more. Extending our product collaboration with a joint go-to-market effort for LangChain’s commercial offering, LangSmith, was a natural fit that benefits both our customers.

我们正持续加大对 LangChain 与 Azure AI 服务技术合作的投入，深度集成 Azure OpenAI、Azure AI Search、Microsoft Fabric 等多项服务。将双方产品合作进一步拓展至 LangChain 商业化产品 LangSmith 的联合上市（Go-to-Market）策略，是水到渠成之举，也将为双方客户带来切实价值。

If you’re looking for a platform that supports all phases of the LLM application lifecycle, consider LangSmith deployed in your Azure environment. Reach out directly in the [Azure Marketplace](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/langchain.langsmith?tab=Overview&ref=blog.langchain.com) or [contact sales](https://www.langchain.com/contact-sales?ref=blog.langchain.com) to start a conversation with one of our experts. We’re excited to work with you.

若您正在寻找一个能全面支持大语言模型（LLM）应用全生命周期的平台，请考虑在您的 Azure 环境中部署 LangSmith。您可直接通过 [Azure 应用商店](https://azuremarketplace.microsoft.com/en-us/marketplace/apps/langchain.langsmith?tab=Overview&ref=blog.langchain.com) 获取，或 [联系销售团队](https://www.langchain.com/contact-sales?ref=blog.langchain.com)，与我们的专家开启对话。我们期待与您携手合作！

* * *

* * *

_Additional resources:_

_更多资源：_

- [_Deployment documentation_](https://docs.smith.langchain.com/self_hosting/kubernetes?ref=blog.langchain.com)  
- [_LangSmith overview_](https://www.langchain.com/langsmith?ref=blog.langchain.com)  
- [_LangSmith demo_](https://www.youtube.com/watch?v=3wAON0Lqviw&list=PLfaIDFEXuae2CjNiTeqXG5r8n9rld9qQu&index=2&ref=blog.langchain.com)

- [_部署文档_](https://docs.smith.langchain.com/self_hosting/kubernetes?ref=blog.langchain.com)  
- [_LangSmith 概览_](https://www.langchain.com/langsmith?ref=blog.langchain.com)  
- [_LangSmith 演示视频_](https://www.youtube.com/watch?v=3wAON0Lqviw&list=PLfaIDFEXuae2CjNiTeqXG5r8n9rld9qQu&index=2&ref=blog.langchain.com)

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)  

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)  
[![评估深度智能体：我们的实践心得](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_001.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_002.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_003.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_004.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![Easier evaluations with LangSmith SDK v0.2](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_005.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**LangSmith SDK v0.2：更轻松的评估体验**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/announcing-langsmith-is-now-a-transactable-offering-in-the-azure-marketplace/img_006.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 分钟阅读
{% endraw %}
