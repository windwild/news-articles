---
title: "Announcing the General Availability of LangSmith and Our Series A Led By Sequoia Capital"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-ga/"
date: "2024-02-15"
scraped_at: "2026-03-03T08:11:52.764931103+00:00"
language: "en-zh"
translated: true
---

Today, we’re thrilled to announce the **general availability of LangSmith** — our solution for LLM application development, monitoring, and testing.  

今天，我们非常激动地宣布 **LangSmith 正式发布（General Availability）**——这是我们专为大语言模型（LLM）应用的开发、监控与测试打造的一体化解决方案。

We initially launched LangSmith in closed beta in July 2023. Since then, we’ve received invaluable feedback from our early users and customers, and made significant improvements to the platform based on their input. We’ve also made heavy investments in our infrastructure to ensure that the platform is able to seamlessly scale to accommodate our rapidly growing user base.  

LangSmith 最初于 2023 年 7 月以封闭测试（closed beta）形式上线。此后，我们从早期用户和客户那里获得了极其宝贵的反馈，并据此对平台进行了大量优化与改进。同时，我们也大幅投入基础设施建设，确保平台能够无缝扩展，从容应对用户规模的快速增长。

If you want to see LangSmith for yourself, [sign up](https://smith.langchain.com/?ref=blog.langchain.com) today. We’ve removed the waitlist, so you can get building immediately. We hope you love it.  

如果您想亲自体验 LangSmith，请立即 [注册](https://smith.langchain.com/?ref=blog.langchain.com)。我们已取消等待名单，您可即刻开始构建应用。期待您喜爱它！

Alongside the GA launch of LangSmith, we’re announcing our **$25M Series A fundraise led by Sequoia Capital**. We’re extremely excited to be working with Sonya Huang and the rest of the Sequoia team to build the future we envision. We're also hiring; if you think you could make a difference on our team, [**see our open roles**](https://langchain.com/careers?ref=blog.langchain.com) and get in touch.  

在 LangSmith 正式发布的同时，我们还宣布完成由红杉资本（Sequoia Capital）领投的 **2500 万美元 A 轮融资**。我们非常荣幸能与 Sonya Huang 及红杉团队携手，共同构建我们所构想的未来。我们也在积极招贤纳士——如果您相信自己能为我们的团队带来改变，欢迎查看 [**当前开放职位**](https://langchain.com/careers?ref=blog.langchain.com)，并联系我们！

Since launching LangSmith, we’ve seen:

自 LangSmith 上线以来，我们已见证：

- Over 80K signups  
- 超过 8 万次注册  
- Over 5K monthly active teams  
- 超过 5000 个活跃团队（月度）  
- Over 40 million traces logged in January alone  
- 仅 1 月份就记录了超 4000 万条调用追踪（traces）

LangSmith is now trusted by the best teams building with LLMs, at companies such as Rakuten, Elastic, Moody’s, Retool, and more.  

LangSmith 已成为众多顶尖 LLM 应用团队的信赖之选，服务客户包括乐天（Rakuten）、Elastic、穆迪（Moody’s）、Retool 等知名公司。

James Spiteri, Director of Product Management at Elastic, shares, _“The impact LangChain and LangSmith had on our application was significant. We couldn’t have shipped the product experience in the first place without LangChain, and we couldn’t have done it at the pace we had without LangSmith.”_  

Elastic 公司产品管理总监 James Spiteri 表示：“LangChain 和 LangSmith 对我们应用的影响极为显著。没有 LangChain，我们根本无法交付最初的产品体验；而没有 LangSmith，我们也绝不可能以如此快的速度完成迭代。”

## LangSmith supports development from prototyping to production  

## LangSmith 全面支持从原型设计到生产部署的开发全流程

We learned from our users about the pain points that are common to building with LLMs, and we’re solving those whether you’re building with LangChain or not. In the rest of this post, we’ll highlight the breadth of workflows LangSmith supports and how they fit into each stage of the application development lifecycle. We hope this will inform users how to best utilize our platform or give you something to consider if you are just starting your journey.  

我们深入倾听用户反馈，系统梳理了使用大语言模型开发应用时普遍存在的痛点，并致力于提供普适性解决方案——无论您是否采用 LangChain 框架。在本文后续部分，我们将全面介绍 LangSmith 所支持的各类工作流，及其如何精准嵌入应用开发全生命周期的各个阶段。我们希望这不仅能帮助现有用户更高效地使用平台，也能为刚刚踏上 LLM 应用开发之路的您提供有价值的参考。

![](images/announcing-the-general-availability-of-langsmith-and-our-series-a-led-by-sequoia/img_001.png)The workflows LangSmith supports at each stage of the LLM application lifecycle  

![](images/announcing-the-general-availability-of-langsmith-and-our-series-a-led-by-sequoia/img_001.png)LangSmith 在 LLM 应用生命周期各阶段所支持的工作流

### Prototyping  

### 原型设计

Prototyping LLM applications often involves quick experimentation between prompts, model types, retrieval strategy and other parameters. The ability to rapidly understand how the model is performing — and debug where it is failing — is incredibly important for this phase.

在原型设计大语言模型（LLM）应用时，通常需要在提示词（prompt）、模型类型、检索策略及其他参数之间快速开展实验。在此阶段，能否迅速理解模型的表现——并精准定位其失败原因——至关重要。

**Debugging**

**调试**

When developing new LLM applications, we suggest having LangSmith tracing enabled by default. Oftentimes, it isn’t necessary to look at every single trace. However, when things go wrong (an unexpected end result, infinite agent loop, slower than expected execution, higher than expected token usage), it’s extremely helpful to debug by looking through the application traces. LangSmith gives clear visibility and debugging information at each step of an LLM sequence, making it much easier to identify and root-cause issues. We provide native rendering of chat messages, functions, and retrieve documents.

开发新的 LLM 应用时，我们建议默认启用 LangSmith 追踪功能。通常，并不需要查看每一条追踪记录（trace）；但当问题发生时（例如：输出结果异常、智能体陷入无限循环、执行速度明显变慢、或 Token 消耗远超预期），通过查阅应用的追踪记录进行调试将极为高效。LangSmith 可清晰呈现 LLM 执行流程中每一步的详细信息与调试线索，极大简化了问题识别与根本原因分析过程。我们原生支持聊天消息、函数调用及检索文档的可视化渲染。

/0:15

1×

/0:15

1×

Inspecting a trace from an LLM application run

检查一次 LLM 应用运行所生成的追踪记录

**Initial Test Set**

**初始测试集**

While many developers still ship an initial version of their application based on “vibe checks”, we’ve seen an increasing number of engineering teams start to adopt a more test driven approach. LangSmith allows developers to create datasets, which are collections of inputs and reference outputs, and use these to run tests on their LLM applications. These test cases can be uploaded in bulk, created on the fly, or exported from application traces. LangSmith also makes it easy to run custom evaluations (both LLM and heuristic based) to score test results.

尽管许多开发者仍依赖主观“感觉判断”（vibe checks）来发布应用的初始版本，但我们观察到越来越多的工程团队正转向更严谨的测试驱动开发模式。LangSmith 允许开发者创建数据集——即输入样本与对应参考输出的集合——并利用这些数据集对 LLM 应用执行自动化测试。测试用例既可批量上传，也可即时创建，甚至能直接从应用运行的追踪记录中导出。此外，LangSmith 还便于运行自定义评估（包括基于 LLM 的评估和基于启发式规则的评估），从而对测试结果进行量化打分。

/0:29

1×

Inspecting test cases and test runs

检查测试用例与测试运行

**Comparison View**

**对比视图**

When prototyping different versions of your applications and making changes, it’s important to see whether or not you’ve regressed with respect to your initial test cases. Oftentimes, changes in the prompt, retrieval strategy, or model choice can have huge implications in responses produced by your application. In order to get a sense for which variant is performing better, it’s useful to be able to view results for different configurations on the same datapoints side-by-side. We’ve invested heavily in a user-friendly comparison view for test runs to track and diagnose regressions in test scores across multiple revisions of your application.

在为应用程序原型设计不同版本并进行修改时，判断是否相对于初始测试用例发生了性能退化至关重要。提示词（prompt）、检索策略或模型选择的变动，往往会对应用程序生成的响应产生重大影响。为了评估哪种变体表现更优，将不同配置在相同数据点上的结果并排查看非常有用。我们已大力投入开发用户友好的测试运行对比视图，以便跨应用程序多个版本追踪和诊断测试分数的退化问题。

/0:14

/0:14

1×

1×

Viewing test runs side by side

并排查看测试运行

**Playground**

**游乐场（Playground）**

LangSmith provides a playground environment for rapid iteration and experimentation. This allows you to quickly test out different prompts and models. You can open the playground from any prompt or model run in your trace. Every playground run is logged in the system and can be used to create test cases or compare with other runs.

LangSmith 提供了一个用于快速迭代与实验的游乐场（Playground）环境，使您能够迅速尝试不同的提示词与模型。您可从任意 trace 中的提示词或模型运行处直接打开该游乐场。每次游乐场运行均会被系统记录，可用于创建测试用例，或与其他运行结果进行对比。

/0:18

/0:18

1×

Opening up a run in the Playground

在 Playground 中打开一次运行

### Beta Testing

### Beta 测试

Beta testing allows developers to collect more data on how their LLM applications are performing in real-world scenarios. In this phase, it’s important to develop an understanding for the types of inputs the app is performing well or poorly on and how exactly it’s breaking down in those cases. Both feedback collection and run annotation are critical for this workflow. This will help in curation of test cases that can help track regressions/improvements and development of automatic evaluations.

Beta 测试使开发者能够收集更多关于其大语言模型（LLM）应用在真实场景中表现的数据。在此阶段，关键在于深入理解应用在哪些类型的输入上表现良好、哪些表现不佳，以及具体在哪些环节出现失效。反馈收集与运行标注（run annotation）均是该工作流中不可或缺的环节。这有助于构建高质量的测试用例集，以追踪性能退化或改进，并推动自动化评估体系的建设。

**Collecting Feedback**

**收集反馈**

When launching your application to an initial set of users, it’s important to gather human feedback on the responses it’s producing. This helps draw attention to the most interesting runs and highlight edge cases that are causing problematic responses. LangSmith allows you to attach feedback scores to logged traces (oftentimes, this is hooked up to a feedback button in your app), then filter on traces that have a specific feedback tag and score. A common workflow is to filter on traces that receive a poor user feedback score, then drill down into problematic points using the detailed trace view.

在将应用首次发布给一批初始用户时，收集用户对模型输出响应的人工反馈至关重要。这有助于快速识别最具代表性的运行实例（runs），并凸显出引发异常响应的边界情况（edge cases）。LangSmith 支持为已记录的调用轨迹（traces）附加反馈评分（通常通过应用内“反馈”按钮实现），随后可按特定反馈标签与评分对轨迹进行筛选。一种常见工作流是：先筛选出用户反馈评分为“差”的轨迹，再借助详细的轨迹视图（detailed trace view）深入分析其中的问题节点。

/0:41

1×

/0:41

1×

Logging a trace and feedback score from ChatLangChain, viewing the results in LangSmith

从 ChatLangChain 记录一次调用轨迹及反馈评分，并在 LangSmith 中查看结果

**Annotating Traces**

**标注轨迹**

LangSmith also supports sending runs to annotation queues, which allow annotators to closely inspect interesting traces and annotate them with respect to different criteria. Annotators can be PMs, engineers, or even subject matter experts. This allows users to catch regressions across important evaluation criteria.

LangSmith 还支持将运行任务发送至标注队列（annotation queues），供标注人员对具有研究价值的轨迹进行细致审查，并依据不同评估维度进行人工标注。标注人员可以是产品经理（PM）、工程师，甚至领域专家（SME）。这一机制帮助用户及时发现关键评估指标上的性能退化问题。

/0:26

1×

发送追踪记录到标注队列

/0:26

1×

将追踪记录发送至标注队列

**Adding Runs to a Dataset**

**将运行记录添加至数据集**

As your application progresses through the beta testing phase, it's essential to continue collecting data to refine and improve its performance. LangSmith enables you to add runs as examples to datasets (from both the project page and within an annotation queue), expanding your test coverage on real-world scenarios. This is a key benefit in having your logging system and your evaluation/testing system in the same platform.

随着应用进入 Beta 测试阶段，持续收集数据以优化和提升其性能至关重要。LangSmith 支持您将运行记录（runs）作为样例添加至数据集（既可通过项目页面操作，也可在标注队列中完成），从而扩展您在真实场景下的测试覆盖范围。将日志系统与评估/测试系统集成于同一平台，正是 LangSmith 的一项核心优势。

/0:14

1×

将一次运行的输入/输出作为样例添加至数据集

/0:14

1×

Adding the inputs/outputs of a run as an example to a dataset

### Production

### 生产环境

Closely inspecting key data points, growing benchmarking datasets, annotating traces, and drilling down into important data in trace view are workflows you’ll also want to do once your app hits production. However, especially at the production stage, it’s crucial to get a high-level overview of application performance with respect to latency, cost, and feedback scores. This ensures that it's delivering desirable results at scale.

密切检查关键数据点、扩充基准测试数据集、对追踪记录进行标注，以及在追踪视图中深入分析重要数据——这些工作流在您的应用上线生产环境后同样需要执行。然而，在生产阶段尤其关键的是：必须从宏观层面掌握应用的整体性能表现，重点关注延迟（latency）、成本（cost）和用户反馈分（feedback scores）。这能确保应用在大规模部署时仍持续交付符合预期的结果。

**Monitoring and A/B Testing**

**监控与 A/B 测试**

LangSmith provides monitoring charts that allow you to track key metrics over time. You can expand to view metrics for a given period and drill down into a specific data point to get a trace table for that time period — this is especially handy for debugging production issues.

LangSmith 提供监控图表，帮助您随时间追踪关键指标。您可以展开查看指定时间段内的指标，并深入钻取某个具体数据点，以获取该时间段的追踪表格——这对调试生产环境问题尤为便捷。

The platform also allows for tag and metadata grouping, which allows users to mark different versions of their applications with different identifiers and view how they are performing side-by-side within each chart. This is helpful for A/B testing changes in prompt, model, or retrieval strategy.

该平台还支持按标签（tag）和元数据（metadata）进行分组，使用户能够为应用程序的不同版本打上不同标识符，并在每张图表中并排查看它们各自的性能表现。这对于对提示词（prompt）、模型（model）或检索策略（retrieval strategy）等变更开展 A/B 测试非常有帮助。

/0:27

1×

/0:27

1×

Viewing monitoring charts and grouping by LLM type

查看监控图表，并按大语言模型（LLM）类型分组

## **The Road Ahead**

## **未来展望**

LangSmith can help with every important workflow at each stage of the LLM application development cycle. As we continue to improve and expand the platform, our future directions include:

LangSmith 可在大语言模型（LLM）应用开发周期的每个阶段，助力所有关键工作流。随着我们持续优化和拓展平台功能，后续重点方向包括：

- Support for regression testing  
- 支持回归测试  
- Ability to run online evaluators on a sample of production data  
- 支持在部分生产数据上运行在线评估器  
- Better filtering and conversation support  
- 更完善的筛选功能与对话支持  
- Easy deployment of applications with hosted LangServe  
- 借助托管版 LangServe 实现应用的一键部署  
- Enterprise features to support the administration and security needs for our largest customers.  
- 面向企业级客户的管理与安全功能，满足最大规模客户的需求  

To learn more about pricing, or reach out to sales, check out our [website](https://www.langchain.com/pricing?ref=blog.langchain.com) for information.

如需了解定价详情或联系销售团队，请访问我们的[官网](https://www.langchain.com/pricing?ref=blog.langchain.com)获取更多信息。

We believe we are in a super early, very fast-moving industry, and our users trust us to be their guide and partner.  

我们相信，当前所处的行业尚处于极为早期的阶段，且发展速度极快；我们的用户信任我们，视我们为他们的向导与合作伙伴。

With LangSmith, and all our products, we strive to stay ahead of the curve and innovate for the needs of our users today.  

借助 LangSmith 及我们所有产品，我们始终致力于引领行业前沿，并立足当下用户需求持续创新。

Thank you for going on this journey with us. Onwards!

感谢您与我们携手同行这一旅程。继续前行！  

![](images/announcing-the-general-availability-of-langsmith-and-our-series-a-led-by-sequoia/img_002.png)