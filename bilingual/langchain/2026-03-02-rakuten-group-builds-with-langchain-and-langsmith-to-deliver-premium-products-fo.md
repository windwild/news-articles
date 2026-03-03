---
title: "Rakuten Group builds with LangChain and LangSmith to deliver premium products for its business clients and employees"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-rakuten/"
date: "2026-03-02"
scraped_at: "2026-03-03T07:12:55.479539402+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain", "Case Studies"]
---

Rakuten Group is well known for operating one of the largest online shopping malls in Japan. The company has 70+ businesses in fields such as e-commerce, travel, digital content, fintech, communications and more.

乐天集团（Rakuten Group）以运营日本最大的在线购物商城之一而闻名。该公司在电子商务、旅游、数字内容、金融科技、通信等多个领域拥有70多项业务。

Adopting new technologies to push the frontiers of what’s possible is in the DNA of the company, and Rakuten Group has invested in delivering AI applications to better service their end users, clients and employees with a unified product suite.

拥抱新技术、不断拓展可能性的边界，早已融入乐天集团的企业基因。为此，乐天集团大力投入AI应用开发，旨在通过统一的产品套件，更好地服务终端用户、企业客户及内部员工。

Rakuten AI for Business is a comprehensive AI platform that supports business clients in essential business operations, including market analysis and customer support. This platform also empowers clients to enhance productivity across various activities, such as sales, marketing, and IT support.

“乐天AI for Business”是一个综合性AI平台，可支持企业客户开展关键业务运营，包括市场分析与客户服务。该平台还助力客户提升销售、营销、IT支持等各类业务活动的生产力。

LangChain and LangSmith are critical technologies that the team leverages to build these solutions with greater speed and reliability.

LangChain 与 LangSmith 是团队构建上述解决方案所依赖的关键技术，显著提升了开发速度与系统可靠性。

### Rakuten AI: Empowering Businesses

### 乐天AI：赋能企业客户

Rakuten invests heavily to make their ecosystem experience great for members and business clients. When clients onboard their businesses, they receive support from a dedicated onboarding consultant, and once live, continue to get help from them. The AI Team at Rakuten believes in using AI for empowerment, and they saw an opportunity to augment the assistance they give to their clients with new LLM-powered products built with LangChain and LangSmith. Specifically, their clients can benefit from:

乐天集团大力投入，致力于为其会员及企业客户打造卓越的生态系统体验。当企业客户入驻平台时，将获得专属入驻顾问的全程支持；上线后，该顾问仍将持续提供协助。“乐天AI团队”坚信AI应以“赋能”为核心价值，并敏锐地意识到：借助基于LangChain与LangSmith构建的新一代大语言模型（LLM）产品，可进一步增强对客户的支援能力。具体而言，企业客户可受益于以下三大AI工具：

- **Rakuten AI Analyst** which acts as a research assistant, providing valuable market intelligence. This helps clients get business insights backed by relevant data and charts.

- **乐天AI分析师（Rakuten AI Analyst）**：作为智能研究助手，提供高价值的市场情报，帮助客户依托相关数据与图表获取切实可行的商业洞察。

- **Rakuten AI Agent** which supports clients in getting faster, self-serve customer support for their questions related to listing and transacting on the marketplace.

- **乐天AI智能体（Rakuten AI Agent）**：助力客户快速自助解决有关商品上架与平台交易等问题，大幅提升客户服务响应效率。

- **Rakuten AI Librarian** which summarizes all of the client’s documentation to answer questions from the client’s end customers and prospects in real time.

- **乐天AI资料馆员（Rakuten AI Librarian）**：自动汇总客户全部文档资料，实时解答其终端客户与潜在客户的各类咨询。

### Rakuten AI: Empowering Rakutenians

### 乐天AI：赋能乐天员工（Rakutenians）

Rakuten recently leveraged LangChain’s OpenGPTs [package](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com) to deliver an employee empowerment experience, in which teams could build their own chatbots over internal documentation to help with knowledge management and employee enablement. It only took three engineers one week to get the initial platform up and running.

乐天集团近期采用LangChain推出的OpenGPTs [软件包](https://github.com/langchain-ai/opengpts?ref=blog.langchain.com)，打造了一套面向员工的赋能体验：各业务团队可基于内部文档快速构建专属聊天机器人，从而优化知识管理并提升员工能力。仅由三名工程师耗时一周，即完成了该平台的初始版本开发与上线。

The team at Rakuten was excited about LangChain OpenGPTs because it gave them maximal flexibility and control on designing the cognitive architecture and user experience. Additionally, they didn’t want to gate the experience to only a subset of employees and intend to roll the product to 32k employees, and at this scale, the Data Science & ML team must keep a variety of options open and be able to control the cost / performance tradeoffs. LangChain’s framework makes the ability to customize and abstract away vendor lock-in possible.

乐天团队对LangChain OpenGPTs倍感振奋，因其赋予了他们在认知架构设计与用户体验定制方面前所未有的灵活性与掌控力。此外，团队明确拒绝将该体验限定于部分员工——该产品计划全面覆盖全公司3.2万名员工。在此规模下，数据科学与机器学习（Data Science & ML）团队必须保持技术选型的开放性，并精准权衡成本与性能之间的取舍。而LangChain框架正提供了高度可定制化的能力，并有效规避了厂商锁定（vendor lock-in）风险。

### Why LangChain and LangSmith

### 为何选择 LangChain 和 LangSmith

Rakuten was an early adopter of LangChain, and they first started building with the framework in January of 2023. LangChain was helpful in providing common, successful interaction patterns for building with LLMs, and many of the off-the-shelf chain and agent architectures allowed Rakuten to iterate quickly.

乐天（Rakuten）是 LangChain 的早期采用者，自 2023 年 1 月起便开始基于该框架构建应用。LangChain 提供了构建大语言模型（LLM）应用时常见且行之有效的交互模式；其大量开箱即用的链（chain）与智能体（agent）架构，助力乐天快速迭代。

As the team got serious about scaling up their LangChain usage and allowing more users to interact with the applications, they looked to LangSmith to harden their work and provide visibility into what’s happening and _why._

随着团队认真推进 LangChain 的规模化应用，并让更多用户接入相关应用，他们转而借助 LangSmith 来加固开发成果，并全面掌握系统运行状况及其背后的原因。

General Manager of AI for Business at Rakuten, Yusuke Kaji says, “LangSmith allows us to get things done scientifically. At a large company, usually multiple teams develop their ideas independently. Some teams find good approaches, while others don’t. By using LangSmith Hub, we could distribute the best prompts and promote collaboration across teams. By using LangSmith Testing and Eval with our custom evaluation metrics, we can run experiments on multiple approaches (models, cognitive architecture, etc.) and _measure_ the results. By combining the benefits of LangSmith and standing on the shoulders of a gigantic open-source community, we’re able to identify the right approaches for using LLMs in an enterprise-setting faster.”

乐天“AI 赋能商业”业务部总经理 Yusuke Kaji 表示：“LangSmith 让我们得以科学高效地开展工作。在大型企业中，通常多个团队各自独立探索创新方案——有些团队找到了优质路径，有些则尚未突破。借助 LangSmith Hub，我们可以共享最优提示词（prompt），推动跨团队协作；通过结合 LangSmith 的测试与评估（Testing and Eval）功能及我们自定义的评估指标，我们能够对多种方案（如不同模型、认知架构等）展开实验，并对结果进行量化衡量。将 LangSmith 的优势与庞大开源社区的集体智慧相结合，我们得以更快速地甄别出适用于企业级场景的大语言模型应用路径。”

LangSmith also provides Rakuten with the enterprise assurances that they need. Data stays within Rakuten’s environment, and with LangSmith, Rakuten can separate access for development workflows from production ones, maintaining the high bar that Rakuten requires when dealing with user data.

LangSmith 还为乐天提供了所需的企业级保障：所有数据均保留在乐天自有环境中；借助 LangSmith，乐天可将开发流程与生产环境的访问权限严格分离，从而在处理用户数据时始终坚守其一贯的高标准。

### The Road Ahead

### 未来之路

Rakuten started with two ambitious projects, impacting both their e-commerce marketplace and their employee base, but that’s par for the course at Rakuten whose mission is to empower people and society through innovation and entrepreneurship. Rakuten plans to distribute **Rakuten AI for Business** across its customer base, focusing particularly on merchants, hotels, retail stores, and local economies, with the aim to improve productivity by 20%. The team will continue to design and build technical architectures for large-scale AI applications across its suite of 70 businesses, and LangChain and LangSmith will enable them to achieve their goals faster and more safely than they could have otherwise.

乐天起步于两个雄心勃勃的项目，分别面向其电子商务市场平台与内部员工群体——而这正契合乐天“以创新与创业赋能个人与社会”的使命。乐天计划向其客户群全面推广 **Rakuten AI for Business**，重点服务商户、酒店、零售门店及本地经济主体，目标是将整体生产力提升 20%。团队将持续为其旗下 70 家业务单元设计并构建大规模 AI 应用的技术架构；而 LangChain 与 LangSmith 将助力其实现目标——比以往更快、更安全。

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/) [案例研究](https://blog.langchain.com/tag/case-studies/)

[![monday Service + LangSmith：从第一天起构建以代码为先的评估策略](https://blog.langchain.com/content/images/size/w760/format/webp/2026/03/3--2-.png)](https://blog.langchain.com/customers-monday/)

[**monday Service + LangSmith：从第一天起构建以代码为先的评估策略**](https://blog.langchain.com/customers-monday/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 8 分钟

[![Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_002.png)](https://blog.langchain.com/customers-remote/)

[**Remote 如何利用 LangChain 和 LangGraph，借助 AI 为数千名客户完成入驻流程**](https://blog.langchain.com/customers-remote/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 5 分钟

[![Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_003.png)](https://blog.langchain.com/customers-vodafone-italy/)

[**Fastweb + Vodafone：借助 LangGraph 和 LangSmith，利用 AI 智能体重塑客户体验**](https://blog.langchain.com/customers-vodafone-italy/)

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 7 分钟

[![深度智能体评估：我们的经验总结](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**深度智能体评估：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**深度智能体评估：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长 7 分钟

[![How Jimdo empower solopreneurs with AI-powered business assistance](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[![Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_005.png)](https://blog.langchain.com/customers-jimdo/)

[**How Jimdo empower solopreneurs with AI-powered business assistance**](https://blog.langchain.com/customers-jimdo/)

[**Jimdo 如何借助 AI 驱动的商业助手赋能独立创业者**](https://blog.langchain.com/customers-jimdo/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟

[![How ServiceNow uses LangSmith to get visibility into its customer success agents](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[![ServiceNow 如何利用 LangSmith 实现客户成功智能体的可观测性](images/rakuten-group-builds-with-langchain-and-langsmith-to-deliver-premium-products-fo/img_006.png)](https://blog.langchain.com/customers-servicenow/)

[**How ServiceNow uses LangSmith to get visibility into its customer success agents**](https://blog.langchain.com/customers-servicenow/)

[**ServiceNow 如何利用 LangSmith 实现客户成功智能体的可观测性**](https://blog.langchain.com/customers-servicenow/)

[Case Studies](https://blog.langchain.com/tag/case-studies/) 4 min read

[案例研究](https://blog.langchain.com/tag/case-studies/) 阅读时长 4 分钟