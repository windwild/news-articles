---
title: "Announcing LangSmith, a unified platform for debugging, testing, evaluating, and monitoring your LLM applications"
source: "LangChain Blog"
url: "https://blog.langchain.com/announcing-langsmith/"
date: "2023-08-18"
scraped_at: "2026-03-03T09:03:05.723172547+00:00"
language: "en-zh"
translated: true
tags: ["By LangChain"]
---

LangChain exists to make it as easy as possible to develop LLM-powered applications.

LangChain 的使命是让开发大语言模型（LLM）驱动的应用尽可能简单。

We started with an open-source Python package when the main blocker for building LLM-powered applications was getting a simple prototype working. We remember seeing Nat Friedman tweet in late 2022 that there was “ [not enough tinkering happening](https://twitter.com/natfriedman/status/1575742314030301184?ref=blog.langchain.com).” The LangChain open-source packages are aimed at addressing this and we see _lots_ of tinkering happening now ( [Nat agrees](https://twitter.com/natfriedman/status/1646285680941862912?ref=blog.langchain.com))–people are building everything from chatbots over internal company documents to an AI dungeon master for a Dungeons and Dragons game.

我们最初以一个开源 Python 包起步，彼时构建 LLM 应用的最大障碍在于：如何快速跑通一个简易原型。我们还记得，2022 年底，Nat Friedman 在推特上感慨：“[动手实验的人还不够多](https://twitter.com/natfriedman/status/1575742314030301184?ref=blog.langchain.com)”。LangChain 的开源包正是为解决这一问题而生；如今，我们已看到大量开发者在积极尝试与探索（[Nat 本人也表示认同](https://twitter.com/natfriedman/status/1646285680941862912?ref=blog.langchain.com)）——从基于企业内部文档构建的聊天机器人，到为《龙与地下城》（Dungeons & Dragons）游戏打造的 AI 地牢主（Dungeon Master），应有尽有。

The blocker has now changed. While it’s easy to build a prototype of an application in ~5 lines of LangChain code, it’s still deceptively hard to take an application from prototype to production. The main issue that we see today is application performance–something that works ~30% of the time is good enough for a Twitter demo, but not nearly good enough for production.

如今，瓶颈已然转变。尽管仅需约 5 行 LangChain 代码即可快速搭建应用原型，但将原型推进至生产环境却仍出人意料地困难。当前最突出的问题是应用性能——一个仅在约 30% 的情况下能正常运行的系统，或许足以支撑一次 Twitter 演示，却远未达到生产级可用的标准。

Today, we’re introducing LangSmith, a platform to help developers close the gap between prototype and production. It’s designed for building and iterating on products that can harness the power–and wrangle the complexity–of LLMs.

今天，我们正式推出 LangSmith —— 一个助力开发者弥合“原型”与“生产”之间鸿沟的平台。它专为构建和持续迭代能够充分释放 LLM 强大能力、同时有效驾驭其复杂性的产品而设计。

[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) is now in closed beta. So if you’re looking for a robust, unified, system for debugging, testing, evaluating, and monitoring your LLM applications, sign up [here](https://smith.langchain.com/?ref=blog.langchain.com).

[LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) 目前处于封闭测试（closed beta）阶段。如果您正寻求一套强大、统一的系统，用于调试、测试、评估和监控您的 LLM 应用，请立即[在此注册](https://smith.langchain.com/?ref=blog.langchain.com)。

**How did we get here?**

**我们是如何走到这一步的？**

Given the stochastic nature of LLMs, it is not easy–and there’s currently no straightforward way–to answer the simple question of “what’s happening in these models?,” let alone getting them to work reliably. The builders we hear from are running into the same roadblocks (and it’s true for our team, too):

鉴于大语言模型固有的随机性（stochastic nature），要回答“这些模型内部究竟发生了什么？”这一看似简单的问题，本身就极富挑战性；而要让它们稳定可靠地工作，则更是难上加难。我们所接触到的开发者普遍遭遇着相同的障碍（我们的团队亦不例外）：

- Understanding what exactly the final prompt to the LLM call is (after all the prompt template formatting, this final prompt can be long and obfuscated)  
- 准确理解发送给 LLM 调用的最终提示词（prompt）究竟是什么（在完成所有提示模板格式化后，该最终提示词往往篇幅冗长、结构复杂且难以解读）

- Understanding what exactly is returned from the LLM call at each step (before it is post-processed or transformed in any way)  
- 准确理解 LLM 调用在每一步返回的原始结果是什么（即在任何后处理或转换操作发生之前）

- Understanding the exact sequence of calls to LLM (or other resources), and how they are chained together  
- 清晰掌握调用 LLM（或其他资源）的确切顺序，以及各调用之间是如何串联与组合的

- Tracking token usage  
- 追踪 Token 使用量

- Managing costs  
- 管理成本开销

- Tracking (and debugging) latency  
- 追踪（及调试）延迟（latency）

- Not having a good dataset to evaluate their application over  
- 缺乏高质量的数据集来全面评估其应用表现

- Not having good metrics with which to evaluate their application  
- 缺乏科学、有效的指标体系来评估其应用效果

- Understanding how users are interacting with the product  
- 深入理解用户如何与产品进行交互

All of these problems have parallels in traditional software engineering. And, in response, a set of practices and tools for debugging, testing, logging, monitoring, etc. has emerged to help developers abstract away common infrastructure and focus on what really matters - building their applications. LLM application developers deserve the same.

上述所有问题，在传统软件工程中均有对应场景。为此，业界已发展出一整套实践方法与工具体系——涵盖调试（debugging）、测试（testing）、日志记录（logging）、监控（monitoring）等——帮助开发者屏蔽通用基础设施的复杂性，从而专注于真正关键的任务：构建自己的应用。LLM 应用开发者理应享有同等待遇。

LangSmith aspires to be that platform. Over the last few months, we’ve been working directly with some early design partners and testing it on our own internal workflows, and we’ve found LangSmith helps teams in 5 core ways:

LangSmith 致力于成为这样的一站式平台。过去数月间，我们已与部分早期设计合作伙伴深度协作，并在自身内部工作流中进行了实际验证。结果表明，LangSmith 可从以下 5 个核心维度赋能开发团队：

## Debugging

## 调试

LangSmith gives you full visibility into model inputs and output of every step in the chain of events. This makes it easy for teams to experiment with new chains and prompt templates, and spot the source of unexpected results, errors, or latency issues. We’ll also expose latency and token usage so that you can identify which calls are causing issues.

LangSmith 为您提供事件链中每一步的模型输入与输出的完整可观测性。这使得团队能够轻松尝试新的链（chains）和提示模板（prompt templates），并快速定位意外结果、错误或延迟问题的根源。我们还将暴露各调用的延迟（latency）和 Token 使用量，帮助您识别出引发问题的具体调用。

![](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_001.png)

We’ve also made it easy to change and rerun examples from the UI. We added this feature after seeing teams take logs of bad examples and copy-paste into the OpenAI playground to tweak the prompt until they got a good result. We wanted to eliminate that friction, and now with the click of a button, you can go from a log to a playground where you can actively edit. This is currently supported for both OpenAI and Anthropic models, with support for more coming soon. We’re also working on supporting this for chains in general.

我们还让在 UI 中修改并重新运行示例变得极为便捷。这一功能源于我们观察到许多团队会将失败案例的日志导出，再复制粘贴至 OpenAI Playground 中反复调整提示词，直至获得理想结果。我们希望彻底消除这一繁琐流程——如今，只需单击一个按钮，您即可从日志直接跳转至交互式 Playground，并实时编辑提示内容。目前该功能已支持 OpenAI 和 Anthropic 模型，更多模型支持即将上线；同时，我们也正在为通用链（chains）扩展此项能力。

This deep visibility into model performance has been particularly helpful for teams developing complex applications. LangSmith helped [Streamlit](https://streamlit.io/?ref=blog.langchain.com) and [Snowflake](https://www.snowflake.com/en/?ref=blog.langchain.com) implement agents that could intelligently and reliably answer questions about their data.

这种对模型性能的深度可观测性，对开发复杂应用的团队尤为宝贵。LangSmith 协助 [Streamlit](https://streamlit.io/?ref=blog.langchain.com) 和 [Snowflake](https://www.snowflake.com/en/?ref=blog.langchain.com) 构建了智能、可靠的 Agent，使其能精准可靠地回答有关自身数据的问题。

"LangChain has been instrumental in helping us prototype intelligent agents at Snowflake,” said Adrien Treuille, Director of Product at Snowflake. “LangSmith was easy to integrate, and the agnostic open source API made it very flexible to adapt to our implementation,” tacked on Richard Meng, Senior Software Engineer at Snowflake.

“LangChain 在助力 Snowflake 快速构建智能 Agent 原型方面发挥了关键作用。”Snowflake 产品总监 Adrien Treuille 表示，“LangSmith 集成简便，其与平台无关的开源 API 极大提升了我们适配自身实现的灵活性。”Snowflake 高级软件工程师 Richard Meng 补充道。

[Boston Consulting Group](https://www.bcg.com/?ref=blog.langchain.com) also built a highly-customized, and highly performant, series of applications on top of LangChain’s framework by relying on this same infrastructure.

[Boston Consulting Group（波士顿咨询公司，BCG）](https://www.bcg.com/?ref=blog.langchain.com) 同样依托这一基础设施，在 LangChain 框架之上构建了一系列高度定制化、高性能的应用。

“We are proud of being one of the early LangChain design partners and users of LangSmith,”  Said Dan Sack, Managing Director and Partner at BCG.  “The use of LangSmith has been key to bringing production-ready LLM applications to our clients.  LangSmith's ease of integration and intuitive UI enabled us to have an evaluation pipeline up and running very quickly. Additionally, tracing and evaluating the complex agent prompt chains is much easier, reducing the time required to debug and refine our prompts, and giving us the confidence to move to deployment.”

“我们很荣幸成为 LangChain 的早期设计合作伙伴及 LangSmith 的首批用户之一。”BCG 管理董事兼合伙人 Dan Sack 表示，“LangSmith 的应用，是推动面向客户的生产级大语言模型（LLM）应用落地的关键。LangSmith 易于集成、界面直观，使我们得以迅速搭建并运行评估流水线。此外，对复杂 Agent 提示链（prompt chains）进行追踪与评估也变得更加简单，显著缩短了调试与优化提示词所需的时间，也让我们更有信心推进至正式部署阶段。”

In another example of debugging in action, we partnered with [DeepLearningAI](https://www.deeplearning.ai/?ref=blog.langchain.com) to equip learners in the [recently-released](https://www.deeplearning.ai/short-courses/langchain-for-llm-application-development/?ref=blog.langchain.com) [LangChain courses](https://www.deeplearning.ai/short-courses/langchain-for-llm-application-development/?ref=blog.langchain.com) with access to LangSmith. This allowed students to easily visualize the exact sequence of calls, and the inputs and outputs at each step in the chain with precision. Students can understand exactly what the chains, prompts, and LLMs were doing, which helps build intuition as they learn to create new and more sophisticated applications.

另一个实战调试案例是：我们与 [DeepLearning.AI](https://www.deeplearning.ai/?ref=blog.langchain.com) 展开合作，为近期发布的 [LangChain 课程](https://www.deeplearning.ai/short-courses/langchain-for-llm-application-development/?ref=blog.langchain.com) 学员提供 LangSmith 访问权限。这使学员能够清晰、精确地可视化整个调用序列，以及链中每一步的输入与输出。学员由此可准确理解链（chains）、提示（prompts）与大语言模型（LLMs）的实际行为，从而在学习构建新型、更复杂应用的过程中逐步建立直觉与工程判断力。

## Testing

## 测试

One of the main questions we see developers grapple with is: “If I change this chain/prompt, how does that affect my outputs?”  
开发者最常遇到的核心问题之一是：“如果我修改了这条链（chain）或提示词（prompt），会对输出结果产生怎样的影响？”

The most effective way to answer this question is to curate a dataset of examples that you care about, and then run any changed prompts/chains over this dataset.  
回答这一问题最有效的方式，是精心构建一个你所关注的示例数据集，然后将所有修改后的提示词或链在此数据集上运行。

LangSmith first makes it easy to create these datasets from traces or by uploading datasets you’ve curated manually. You can then easily run chains and prompts over those data sets.  
LangSmith 首先让这类数据集的创建变得轻而易举——既可直接从追踪记录（traces）中生成，也可上传你手动整理的数据集。随后，你便能轻松地在这些数据集上运行各类链和提示词。

![](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_002.png)

The first helpful step is simply manually looking at the new inputs and outputs. Although this may seem unsatisfyingly basic, it actually has some benefits — many of the companies we’ve spoken to actually like some manual touch points because it allows them to develop better intuition about how to interact with LLMs. This intuition can prove incredibly valuable when trying to think about how to improve the application. The main unlock we hope to provide is a clear interface for letting developers easily see the inputs and outputs for each data point, as without that visibility they cannot build up that intuition.  
第一步实用且有效的操作，就是人工审阅新的输入与输出。尽管这看似基础得令人失望，实则颇具价值——我们访谈过的许多公司都表示，他们恰恰欢迎这种人工介入环节，因为它有助于培养对大语言模型（LLM）交互方式的更佳直觉。这种直觉在思考如何优化应用时，往往具有不可估量的价值。我们希望提供的核心能力，正是一个清晰直观的界面，使开发者能够便捷地查看每个数据点对应的输入与输出；若缺乏这种可见性，开发者便无从建立上述直觉。

Today, we primarily hear from teams that want to bring their prototype into production, and are narrowing in on specific prompts they’d like to improve.  
当前，我们听到最多的声音来自那些正将原型推进生产环境的团队，他们正聚焦于若干亟待优化的具体提示词。

[Klarna](https://www.klarna.com/us/?ref=blog.langchain.com) is building industry-leading AI integrations that go beyond a simple call to a language model, and instead rely on a series of calls. As they focus on a specific section, LangSmith has provided the tools and data they need to ensure no regressions occur.  
[Klarna](https://www.klarna.com/us/?ref=blog.langchain.com) 正在构建行业领先的 AI 集成方案，其复杂度远超对语言模型的单次调用，而是依赖一系列协同调用。当他们聚焦于某一特定模块时，LangSmith 为其提供了确保不发生功能退化（regression）所必需的工具与数据支持。

In parallel, we’re starting to hear from more and more ambitious teams that are striving for a more effective approach.  
与此同时，我们也越来越多地收到来自雄心勃勃的团队的反馈——他们正致力于探索更高效、更系统化的实践路径。

## Evaluating  

## 评估  

LangSmith integrates seamlessly with our open source collection of evaluation modules. These modules have two main types of evaluation: heuristics and LLMs. Heuristic Evaluations will use logic like regexes to evaluate the correctness of an answer. LLM evaluations will use LLMs to evaluate themselves.  
LangSmith 与我们开源的评估模块库无缝集成。这些模块主要包含两类评估方式：基于启发式规则（heuristics）的评估与基于大语言模型（LLM）的评估。启发式评估通过正则表达式（regex）等逻辑判断答案的正确性；而 LLM 评估则利用大语言模型自身来完成对输出质量的评判。

We are extremely bullish on LLM assisted evaluation over the long term. Critics of this approach will say that it’s conceptually shaky and practically costly (time and money). But, we’ve been seeing some [very compelling evidence](https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback?ref=blog.langchain.com) come out of top labs that this is a viable strategy. And, as we collectively make improvements to these models—both private and open source—and usage becomes more ubiquitous, we expect costs to come down considerably.  
长期来看，我们对“LLM 辅助评估”这一方向抱有极强信心。批评者认为该方法在概念上不够稳固，且在实践中成本高昂（时间与金钱）。然而，顶尖研究实验室已陆续发布一些[极具说服力的证据](https://www.anthropic.com/index/constitutional-ai-harmlessness-from-ai-feedback?ref=blog.langchain.com)，证明这是一种切实可行的策略。此外，随着我们共同推动各类模型（包括私有模型与开源模型）持续演进，以及其应用日益普及，我们预计相关成本将显著下降。

### Monitoring  

### 监控  

While debugging, testing, and evaluating can help you get from prototype to production, the work doesn’t stop once you ship. Developers need to actively track performance, and ideally, optimize that performance based on feedback. We consistently see developers relying on LangSmith to track the system-level performance of their application (like latency and cost), track the model/chain performance (through associating feedback with runs), debug issues (diving into a particular run that went wrong), and establish a broad understanding of how users are interacting with their application and what their experience is like.  
尽管调试、测试与评估能助力你将原型顺利推向生产环境，但交付上线绝非终点。开发者需持续主动监控系统性能，并理想情况下，依据用户反馈不断优化性能。我们持续观察到，开发者广泛借助 LangSmith 实现以下目标：监控应用的系统级性能指标（如延迟与成本）、跟踪模型/链的运行表现（通过将用户反馈关联至具体运行记录）、排查故障（深入分析某次异常运行）、并全面理解终端用户如何与应用交互，以及其实际使用体验如何。

![](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_003.png)

![](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_003.png)

像 [Mendable](https://www.mendable.ai/?ref=blog.langchain.com)、[Multi-On](https://multion.ai/?ref=blog.langchain.com) 和 [Quivr](https://github.com/StanGirard/quivr?ref=blog.langchain.com) 这样雄心勃勃的初创公司——它们已为数千名用户提供服务——正积极使用 LangSmith，不仅用于监控整体使用情况，更借助这些洞察主动应对关键问题。

“多亏了 LangChain Smith，我们得以分析自身的 LLM 调用，理解不同链式方法（如 `stuff` 与 `reduce`）在问答任务中的性能表现，并据此持续优化。它甚至帮助我们调试并理解自身产生的错误。我们持续利用它改进提示工程，并热切期待新功能的推出。” —— [Theodo](https://www.linkedin.com/company/theodo/?ref=blog.langchain.com) 公司 GenAI 负责人、[Quivr](https://github.com/StanGirard/quivr?ref=blog.langchain.com) 创始人 Stan Girard 表示。

### A unified platform

### 统一平台

尽管上述每一类产品功能都在开发流程的特定阶段提供了独特价值，但我们相信，LangSmith 的长期影响力，将主要源于它作为一个单一、完全集成的中心枢纽，支持开发者一站式完成所有相关工作。我们看到许多团队仍在使用各种复杂冗余、如同“鲁布·戈德堡机械”（Rube Goldberg machine）般的流程来管理其大语言模型应用；而我们希望终结这种现状。

举一个非常简单的例子：我们认为，LangSmith 的基础能力之一，就是帮助用户轻松地从现有日志中创建数据集，并立即将其用于测试与评估——无缝打通日志记录/调试工作流与测试/评估工作流。

拉丁美洲初创公司 [Fintual](https://fintual.com/?ref=blog.langchain.com) 怀抱远大愿景，致力于通过个性化财务顾问帮助本国公民积累财富；他们在 LLM 开发早期就采用了 LangSmith。“我们一听说 LangSmith，就立刻将整个开发栈迁移至该平台。我们 *本可以* 自行构建所需的评估、测试和监控工具，但那样做效果会差 1000 倍、耗时长 10 倍，且需要投入两倍规模的团队。” Fintual 团队负责人 Jose Pena 表示。

“由于我们正在构建金融产品，对准确性、个性化程度与安全性的要求尤为严苛。LangSmith 帮助我们打造出真正有信心交付给用户的产品。”

我们迫不及待要将这些优势带给更多团队。目前，我们的路线图上已列有大量待上线功能，包括数据分析、交互式 Playground、团队协作、上下文内学习（in-context learning）、提示词创建（prompt creation）等。

最后，我们也清醒地认识到：仅靠 LangSmith，尚无法覆盖您今日将应用推向生产环境所需的所有功能。为此，我们已支持将数据集导出为 OpenAI evals 所需的标准格式，方便您直接向 OpenAI evals 社区贡献数据。这些数据亦可直接用于在 [Fireworks 平台](https://www.fireworks.ai/?ref=blog.langchain.com) 上微调您的模型（我们后续也将努力使其易于接入其他微调系统）。此外，我们还支持以通用格式导出运行日志，并已与 [Context](https://docs.smith.langchain.com/tracing/use-cases/export-runs/context?ref=blog.langchain.com) 等团队合作，确保您能将日志顺利加载至其分析引擎，并在其平台上开展深度分析。

**We can’t wait to see what you build.**

**我们迫不及待想看到您构建的成果。**

### Tags

### 标签

[By LangChain](https://blog.langchain.com/tag/by-langchain/)

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/)

[![Evaluating Deep Agents: Our Learnings](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[![评估深度智能体：我们的经验总结](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_004.png)](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**Evaluating Deep Agents: Our Learnings**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[**评估深度智能体：我们的经验总结**](https://blog.langchain.com/evaluating-deep-agents-our-learnings/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 7 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：7 分钟

[![Introducing End-to-End OpenTelemetry Support in LangSmith](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[![在 LangSmith 中引入端到端 OpenTelemetry 支持](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_005.png)](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**Introducing End-to-End OpenTelemetry Support in LangSmith**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[**在 LangSmith 中引入端到端 OpenTelemetry 支持**](https://blog.langchain.com/end-to-end-opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 3 min read

[由 LangChain 发布](https://blog.langchain.com/tag/by-langchain/) 阅读时长：3 分钟

[![LangChain State of AI 2024 Report](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[![LangChain 2024 年人工智能现状报告](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_006.png)](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain State of AI 2024 Report**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[**LangChain 2024 年人工智能现状报告**](https://blog.langchain.com/langchain-state-of-ai-2024/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 6 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 6 分钟

[![Introducing OpenTelemetry support for LangSmith](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[![为 LangSmith 引入 OpenTelemetry 支持](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_007.png)](https://blog.langchain.com/opentelemetry-langsmith/)

[**Introducing OpenTelemetry support for LangSmith**](https://blog.langchain.com/opentelemetry-langsmith/)

[**为 LangSmith 引入 OpenTelemetry 支持**](https://blog.langchain.com/opentelemetry-langsmith/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![Easier evaluations with LangSmith SDK v0.2](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[![使用 LangSmith SDK v0.2 实现更便捷的评估](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_008.png)](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**Easier evaluations with LangSmith SDK v0.2**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[**使用 LangSmith SDK v0.2 实现更便捷的评估**](https://blog.langchain.com/easier-evaluations-with-langsmith-sdk-v0-2/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长约 4 分钟

[![LangGraph Platform in beta: New deployment options for scalable agent infrastructure](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[![LangGraph 平台进入 Beta 阶段：面向可扩展智能体基础设施的新部署选项](images/announcing-langsmith-a-unified-platform-for-debugging-testing-evaluating-and-mon/img_009.png)](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph Platform in beta: New deployment options for scalable agent infrastructure**](https://blog.langchain.com/langgraph-platform-announce/)

[**LangGraph 平台进入 Beta 测试阶段：面向可扩展智能体基础设施的全新部署选项**](https://blog.langchain.com/langgraph-platform-announce/)

[By LangChain](https://blog.langchain.com/tag/by-langchain/) 4 min read

[由 LangChain 撰写](https://blog.langchain.com/tag/by-langchain/) 阅读时长：4 分钟