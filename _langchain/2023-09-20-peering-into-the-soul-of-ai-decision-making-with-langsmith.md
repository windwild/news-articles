---
render_with_liquid: false
title: "Peering Into the Soul of AI Decision-Making with LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/peering-into-the-soul-of-ai-decision-making-with-langsmith/"
date: "2023-09-20"
scraped_at: "2026-03-03T08:43:56.620883802+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written by [Paul Thomson](https://www.linkedin.com/in/thepaulthomson?ref=blog.langchain.com) from [Commandbar](https://www.commandbar.com/?ref=blog.langchain.com). They've been awesome partners as they brought their application into production with LangSmith, and we're excited to share their story getting there._

_编辑注：本文由 [Commandbar](https://www.commandbar.com/?ref=blog.langchain.com) 的 [Paul Thomson](https://www.linkedin.com/in/thepaulthomson?ref=blog.langchain.com) 撰写。他们作为早期合作伙伴，成功将应用接入 LangSmith 并投入生产环境，我们非常荣幸能与大家分享这段历程。_

Do you ever wonder why you’re getting unhinged responses from ChatGPT sometimes? Or why the heck Midjourney is giving your creations 7 weird fingers? As _intelligent_ as AI is supposed to be, it does produce some pretty _unintelligent_ responses sometimes.

你是否曾疑惑：为什么 ChatGPT 有时会给出离谱、失控的回答？又或者，为什么 Midjourney 总是给你的作品画出七根奇奇怪怪的手指？尽管 AI 被冠以“智能”之名，它却时不时地输出一些相当“不智能”的结果。

Now, if you’re using GPT to write your next “let ‘em down easy breakup message”, the stakes are low - it doesn’t really matter. But if a core product feature is leveraging AI and your customers depend on super-intelligent perfection, you’re going to want some security and assurances that the outputs are up to scratch. Enter, LangSmith.

当然，如果你只是用 GPT 来起草下一条“温柔分手短信”，那出点差错也无伤大雅；但倘若 AI 是你产品的核心功能，而用户正依赖它提供极致精准、高度可靠的体验，你就必须拥有充分的保障与信心——确保每一次输出都经得起检验。此时，LangSmith 应运而生。

Since the launch of [HelpHub](https://helphub.commandbar.com/?ref=commandbar.ghost.io), we were trying to do things on hard mode when it came to iterating and improving functionality. That is, of course, until the LangChain team tantalized us onto their [LangSmith](https://blog.langchain.com/announcing-langsmith/?ref=commandbar.ghost.io) beta. What we didn’t expect was how immediate the downstream improvements were to our flagship AI-powered product.

自 [HelpHub](https://helphub.commandbar.com/?ref=commandbar.ghost.io) 上线以来，我们在功能迭代与优化上一直“硬核攻坚”。直到 LangChain 团队向我们展示了 [LangSmith](https://blog.langchain.com/announcing-langsmith/?ref=commandbar.ghost.io) 的测试版——我们才恍然发现，原来一切可以如此顺畅。更令人惊喜的是，LangSmith 带来的下游改进效果立竿见影，直接赋能了我们主打的 AI 驱动型产品。

But is LangSmith robust enough for us to rely on entirely for our LLM-powered QA? Or is it just another nice-to-have feature for our ENG team?

但问题是：LangSmith 是否足够稳健，足以支撑我们整套基于大语言模型（LLM）的质量保障（QA）体系？抑或它仅仅是我们工程团队锦上添花的又一个“加分项”？

If you’re at the intersection of product, LLMs, and [user experience](https://www.commandbar.com/blog/10-examples-user-onboarding-experiences?ref=commandbar.ghost.io), we’ve just walked so you can run. Time to read on.

如果你正身处产品、大语言模型（LLM）与[用户体验](https://www.commandbar.com/blog/10-examples-user-onboarding-experiences?ref=commandbar.ghost.io)三者的交汇点，那么恭喜你——我们已先行探路，只为助你加速奔跑。现在，就让我们开始阅读吧。

## What Is LangSmith?

## LangSmith 是什么？

LangSmith is a framework built on the shoulders of [LangChain](https://langchain.com/?ref=commandbar.ghost.io). It’s designed to track the inner workings of LLMs and AI agents within your product.

LangSmith 是一个构建于 [LangChain](https://langchain.com/?ref=commandbar.ghost.io) 基础之上的框架，专为追踪你产品中大语言模型（LLM）与 AI Agent 的内部运行机制而设计。

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_001.png)

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_001.png)

Those LLM inner-workings can be categorized into 4 main buckets - each with its own flair of usefulness. Here’s a breakdown of how they all work in unison and what you can expect.

这些 LLM 内部运作机制可划分为四大核心模块——每个模块都各具独特价值。下文将逐一解析它们如何协同工作，以及你能从中获得哪些关键能力。

## Debugging:

## 调试：

When your LLM starts throwing curveballs instead of answers, you don't just want to sit there catching them. With LangSmith, you can roll up your sleeves and play detective. We use the debugging tools to dive into perplexing agent loops, frustratingly slow chains, and to scrutinize prompts like they're suspects in a lineup.

当你的大语言模型（LLM）开始抛出“曲线球”而非答案时，你绝不想只是坐在那儿徒劳接招。借助 LangSmith，你可以挽起袖子，化身侦探——我们利用其调试工具深入探究令人困惑的智能体循环（agent loops）、异常缓慢的链式调用（chains），并像审讯 lineup 中的嫌疑人一样严格审视每一条提示词（prompt）。

### Testing:

### 测试：

Testing LLM applications without LangSmith is like trying to assemble IKEA furniture without the manual: sure, you could wing it, but do you really want to risk it? Baked into LangSmith is the option to utilize existing datasets or create new ones, and run them against your chains. Visual feedback on outputs and accuracy metrics are presented within the interface, streamlining the testing process for our eng team (we really like this).

若不使用 LangSmith 进行测试，就如同没有说明书就组装宜家家具：理论上你或许能凭感觉硬上，但你真的愿意冒这个风险吗？LangSmith 原生支持复用现有数据集或创建新数据集，并将其运行于你的链式流程（chains）之上。输出结果与准确率等评估指标以可视化形式直接呈现在界面中，极大简化了工程团队的测试流程（我们真的超爱这个功能）。

### Evaluating:

### 评估：

Beyond mere testing, evaluation in LangSmith delves into the performance nuances of LLM runs. While the built-in evaluators offer a preliminary analysis, the true power lies in guiding your focus towards crucial examples (more on how we do that later). As your datasets grow, LangSmith ensures you never miss a beat, making evaluations both comprehensive and insightful. Because "good enough" isn't in your vocabulary, right?

评估远不止于基础测试——LangSmith 的评估能力深入挖掘 LLM 运行过程中的性能细节。尽管内置评估器可提供初步分析，其真正威力在于引导你聚焦于关键样例（后文将详述实现方式）。随着数据集持续扩充，LangSmith 确保你始终掌控全局，让每一次评估既全面又富有洞见。毕竟，“差不多就行”这种说法，压根就不在你的词典里，对吧？

### Monitoring:

### 监控：

Think of LangSmith's monitoring as your AI’s babysitter: always vigilant, never distracted, and ready to report every little mischief. It'll give you the play-by-play, ensure everything's in order, and notify you if things get out of hand. We even went a step ahead and piped these flags directly into Slack giving us almost realtime monitoring when our users hit a deadend with chat conversations.

不妨将 LangSmith 的监控功能视作你 AI 系统的“专属保姆”：永远警觉、从不分心，随时准备汇报每一处细微异常。它为你实时呈现完整执行轨迹（play-by-play），确保各环节井然有序；一旦系统失控，立即发出告警。我们甚至更进一步——将这些告警信号直连 Slack，从而在用户聊天陷入僵局时，近乎实时地获得通知。

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_002.png)https://twitter.com/zhanghaili0610

## LangChain vs LangSmith: What’s the difference?

## LangChain 与 LangSmith：有何区别？

While [LangChain is the muscle](https://www.commandbar.com/blog/langchain-guide?ref=commandbar.ghost.io) doing the heavy lifting with Chains, Prompts, and Agents, understanding the 'why' behind the decisions LLMs make is a maze we often found ourselves lost in. That's where LangSmith shines, acting as an AI compass built into LangChain, guiding us through the intricate decision pathways and results that our chatbot generates.

虽然 [LangChain 是承担重担的“肌肉”](https://www.commandbar.com/blog/langchain-guide?ref=commandbar.ghost.io)，借助 Chains（链）、Prompts（提示词）和 Agents（智能体）完成繁重工作，但我们却常常在理解大语言模型（LLM）决策背后的“原因”时迷失于迷宫之中。而 LangSmith 正是在此处大放异彩——它作为内置于 LangChain 中的 AI 指南针，引导我们穿越聊天机器人所生成的复杂决策路径与结果。

> _"LangChain's (the company's) goal is to make it as easy as possible to develop LLM applications"_

said Harrison Chase, co-founder and CEO of LangChain.

> _“LangChain（公司）的目标是让大语言模型（LLM）应用的开发尽可能简单。”_

LangChain 联合创始人兼首席执行官 Harrison Chase 表示。

> _"To that end, we realized pretty early that what was needed - and missing - wasn't just an open source tool like LangChain, but also a complementary platform for managing these new types of applications. To that end, we built LangSmith - which is usable with or without LangChain and let's users easily debug, monitor, test, evaluate, and now (with the recently launched Hub) share and collaborate on their LLM applications.”_

> _“为此，我们很早就意识到：真正需要（却长期缺失）的，不仅是一个像 LangChain 这样的开源工具，更是一个配套平台，用以管理这类新型应用。正因如此，我们构建了 LangSmith——它既可独立使用，也可与 LangChain 协同工作，帮助用户轻松完成调试、监控、测试、评估；如今，随着近期推出的 LangSmith Hub，用户还能共享并协作开发自己的 LLM 应用。”_

What Are LangSmith Traces?

LangSmith Traces 是什么？

Traces in the world of LangSmith are analogous to logs when programming; they allow us to easily see what text came in and out of chains and LLMs. Think of them as detailed breadcrumbs illuminating the AI's journey. Each trace, like a footprint on a sandy beach, represents a pivotal AI decision. Traces don't merely depict the path taken; they shed light on the underlying thought process and actions taken at each juncture.

在 LangSmith 的世界中，“Traces”（追踪记录）类似于编程中的日志（logs），使我们能清晰地看到输入和输出至 Chains 与 LLM 的文本内容。可将它们视作细致入微的“面包屑”，照亮 AI 的推理旅程。每一条 Trace 就如同沙滩上的一枚脚印，代表一次关键的 AI 决策。这些 Trace 所呈现的，不只是走过的路径，更揭示了每个决策节点背后隐含的思考过程与具体操作。

Here’s what one of our traces looks like inside LangSmith:

以下是我们某条 Trace 在 LangSmith 中的实际界面截图：

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_003.png)

All the individual traces are consolidated into datasets:

所有独立的 Trace 均被汇总为数据集：

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_004.png)

Do You Really Need To Use LangSmith?

您真的需要使用 LangSmith 吗？

When generative AI works, it feels like watching a viral “satisfying video” montage - so delightful. But when it doesn’t, it sucks, and sometimes it sucks real bad.

当生成式 AI 正常运行时，体验宛如观看一段走红网络的“解压视频”合集——令人无比愉悦；而一旦它失灵，体验就会大打折扣，有时甚至糟糕透顶。

Take it from us, as we integrated AI more heavily and widely across our products, we’ve been more conscious than ever that the quality of the outputs matches the quality and trust that our customers have in our product. [G2 review flex here](https://www.g2.com/products/commandbar/reviews?ref=commandbar.ghost.io).

请相信我们的切身体会：随着 AI 在我们各款产品中被更深入、更广泛地集成，我们比以往任何时候都更清醒地意识到——AI 输出的质量，必须与客户对我们产品的品质认可和信任程度相匹配。[此处插入 G2 用户评价链接](https://www.g2.com/products/commandbar/reviews?ref=commandbar.ghost.io)。

Truth is, until we powered up LangSmith, we truly had no way of postmorteming responses from OpenAI or testing how prompt changes, or even upgrading to a new model like GPT-4, would affect the answers.

事实是，在启用 LangSmith 之前，我们根本无法对 OpenAI 的响应结果进行复盘分析，也无法系统性地测试提示词（prompt）调整，甚至模型升级（例如迁移到 GPT-4）会对最终回答产生怎样的影响。

## How We Use LangSmith at CommandBar: AI-Powered User Assistance

## CommandBar 如何使用 LangSmith：AI 驱动的用户支持

We’ve covered a lot of ground so far on how LangSmith works. From here on out, we’re ripping the covers off and showing you what’s under the hood of our HelpHub <> LangSmith setup. To give you a little context, first, let’s dive into what HelpHub is.

关于 LangSmith 的工作原理，我们此前已做了大量介绍。接下来，我们将揭开面纱，向您全面展示 HelpHub 与 LangSmith 协同工作的底层架构。为帮助您更好理解，我们先简要介绍一下 HelpHub 是什么。

HelpHub is a GPT-Powered chatbot for any site. It syncs with any public URL or your existing help center to assist users in getting instantaneous support while circumventing customer service teams or manually screening docs.

HelpHub 是一款面向任意网站的、由 GPT 驱动的聊天机器人。它可同步任意公开 URL 或您现有的帮助中心内容，使用户无需联系客服团队或手动翻阅文档，即可即时获得所需支持。

While we utilize our own search with ElasticSearch, we rely on LangChain to merge those search results into meaningful prompts for HelpHub. This synergy allows us to search hundreds of docs and sites in milliseconds, source relevant context, compute reasoning, and deliver an answer to our users (with citations!) almost instantly.

尽管我们采用自研的 ElasticSearch 搜索引擎，但依赖 LangChain 将搜索结果整合为语义清晰、上下文完备的提示词（prompt），输入 HelpHub。这种协同机制使我们能在毫秒级时间内检索数百份文档与网站内容，精准提取相关上下文，完成逻辑推理，并（附带引用来源！）近乎实时地向用户提供答案。

It’s through this core integration with LangChain that we’re able to capture traces via LangSmith.  primarily to finetune and optimize our chatbot’s functionality and sandbox future improvements for our users.

正是通过这一与 LangChain 的核心集成，我们才得以借助 LangSmith 全面捕获调用链路（traces）——主要目的，是持续微调与优化聊天机器人的功能表现，并为面向用户的未来改进方案提供安全可靠的沙盒验证环境。

### Accurate AI Responses Are A Necessity, Not A Nice-To-Have

### 准确的 AI 回答是刚需，而非锦上添花

We pride ourselves on offering precise and relevant answers to user queries and that has always been a strong USP for us.  

我们始终以向用户提供精准且相关的答案为荣，这一直是我们的核心竞争优势。

However, with the aforementioned challenges of unhinged AI-generated responses not always aligning with user expectations, once we flicked on LangSmith, we took our prototyping and QA from mediocre guesswork to David Blaine quality witchcraft.  

然而，面对前述挑战——即不受约束的 AI 生成内容往往无法契合用户预期——自从我们启用 LangSmith 以来，我们的原型开发与质量保障工作便从平庸的凭空猜测，一跃升华为堪比大卫·布莱恩（David Blaine）级别的“魔法技艺”。

Since its integration, LangSmith has traced over X0 million tokens for HelpHub (about XM tokens a week!).  

自集成以来，LangSmith 已为 HelpHub 追踪了超过 X000 万 token（约每周 XM 个 token）！

### Real-world Example of LangSmith In Our Production  

### LangSmith 在我们生产环境中的真实应用案例

Below is an example from [Gus](https://twitter.com/gusgordon?ref=commandbar.ghost.io), one of our mighty talented LangSmith connoisseurs, caught in one of our traces.  

以下案例来自 [Gus](https://twitter.com/gusgordon?ref=commandbar.ghost.io)，他是一位才华横溢的 LangSmith 专家，也是我们追踪记录中的一位典型代表。

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_005.png)

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_005.png)

What he’s referring to in the screenshot is the fact that each prompt from HelpHub should reference the source document that it’s referencing when giving users an answer. We do this primarily to legitimize the LLMs response and give our HelpHub customer’s peace of mind that their end users are in fact getting to the help resource they need (instead of an LLM just hallucinating and giving any response it wants.)  

截图中他所指的内容是：HelpHub 每次向用户作答时，其提示词（prompt）都应明确引用所依据的原始文档。我们这样做的主要目的，是增强大语言模型（LLM）输出结果的可信度，并让 HelpHub 的客户安心——确保其终端用户真正获取到了所需的帮助资源（而非 LLM 凭空“幻觉”出任意答案）。

From here, we went into LangSmith and saw that the LLM actually returned no source, even though we asked it to. Ideally, the source should be returned on the first line in the “Output” section above the actual answer.  

于是，我们进入 LangSmith 查看追踪数据，发现尽管明确要求提供来源，LLM 实际返回的结果中却完全缺失源文档标识。理想情况下，“Output”（输出）部分的第一行就应包含该源文档 ID，置于实际答案之前。

We updated our prompt to be more firm when asking for the sources:  

我们优化了提示词，在要求提供来源时措辞更为明确和坚定：

- Previously the snippet in the prompt responsible for this was: `Return the source ID with the most relevance to your answer.`  
- 此前提示词中负责该功能的片段为：`返回与你的答案最相关联的源文档 ID。`

- We update that piece of the prompt to: `ALWAYS return the source ID with the most relevance to your answer prior to answering the question.`  
- 我们将该提示词片段更新为：`在回答问题之前，务必先返回与你的答案最相关联的源文档 ID。`

We then tested everything using LangSmith evals, to make sure that it fixes the issue before pushing to production.  

随后，我们借助 LangSmith 的评估（evals）功能对全部变更进行了测试，确保该问题已彻底解决，再将其部署至生产环境。

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_006.png)

![](images/peering-into-the-soul-of-ai-decision-making-with-langsmith/img_006.png)

You can now clearly see the citations coming through with the responses in the traces, and we’re good to ship the changes to the prompt to prod.

现在，你已能清晰地在追踪记录（traces）中看到随响应一同返回的引用来源，我们已准备好将提示词（prompt）的更新正式部署至生产环境（prod）。

## The Verdict: Are We Betting The House On LangSmith?

## 最终结论：我们是否把全部身家押注在 LangSmith 上？

When a product like LangSmith comes along, it can feel really natural to default to the path of least resistance and offhand all responsibility. As we start to add additional functionality to HelpHub, there’s an inherent risk that GPT is going to lead users astray, and that’s just not an option we’re willing to entertain.

当 LangSmith 这类产品出现时，人们很容易本能地选择阻力最小的路径，将责任一推了之。然而，随着我们为 HelpHub 持续增添新功能，GPT 将用户引入歧途的风险与生俱来——而这种可能性，是我们绝不愿接受的。

So, in short, yes, we are putting a lot of trust right now in LangSmith and scaling our prototyping and debugging rapidly. The systems we’re building internally have already been instrumental in improving user experience, and as you’ve read earlier, many of these insights and improvements have come directly from those real-time traces from users chatting with HelpHub in the wild.

简而言之：是的，我们当前正高度信赖 LangSmith，并迅速扩大原型开发与调试的规模。我们内部构建的系统已在提升用户体验方面发挥了关键作用；正如前文所述，许多洞见与优化，正是直接源自真实用户在实际使用场景中与 HelpHub 对话所产生的实时追踪记录（real-time traces）。

### Leveraging **User Feedback For Improvements:**

### 借力**用户反馈驱动持续改进：**

We believe that every piece of user feedback, whether positive or negative, is a goldmine of insights. And with LangSmith's help (plus a little ingenuity on our side), we've turned these insights into actionable improvements.

我们坚信：每一条用户反馈——无论褒贬——都是一座蕴藏丰富洞见的金矿。借助 LangSmith 的能力（再辅以我们自身的巧思），我们已将这些洞见切实转化为可落地的改进措施。

Here's how our feedback loop works:

以下是我们的反馈闭环运作机制：

1. **Real-time Feedback Collection:** As users interact with HelpHub, they have the opportunity to provide feedback on the AI-generated responses, signaling with a simple "thumbs up" or "thumbs down".

1. **实时反馈收集**：用户在与 HelpHub 交互过程中，可随时对 AI 生成的响应给出反馈，仅需轻点“👍”或“👎”即可完成。

2. **In-depth Analysis with LangSmith:** Instead of just collecting feedback in the form or positive or negative signals, we delve deeper (particularly for the negative signals). Using LangSmith, we’re able to attribute each signal to an individual trace. In that trace, we can map the exact sequence of steps the model took to generate that response. We essentially replay GPT's thought process and LangChain’s actions, giving us the insights into what went right and where it veered off track.

2. **借助 LangSmith 深度分析**：我们不止于简单归类“正面/负面”信号，而是深入挖掘（尤其针对负面反馈）。通过 LangSmith，我们可将每条反馈精准关联至单条追踪记录（trace）；在该 trace 中，我们能完整还原模型生成该响应所经历的每一步操作——本质上，我们是在重放 GPT 的推理过程与 LangChain 的执行动作，从而清晰识别哪些环节运转良好、哪些环节偏离了轨道。

3. **Categorizing Into Datasets:** Central to our refinement process is LangSmith's use of dynamic datasets. We maintain multiple datasets, each tailored to different query types and user interactions. These datasets are essentially compilations of identical states of our environment at the time the trace was captured. This ensures that when there's an update to the prompt or LLM, a new dataset starts to compile those traces, preventing any contamination.

3. **归类至数据集**：动态数据集（dynamic datasets）的运用，是 LangSmith 赋能我们迭代优化的核心。我们维护多个数据集，各自聚焦于不同类型的用户查询与交互场景。这些数据集本质上是“快照式”采集——即在 trace 生成时刻，完整固化当时运行环境的全部状态。此举确保：一旦提示词（prompt）或大语言模型（LLM）发生更新，系统便会自动启用新的数据集来收录后续 trace，彻底避免新旧数据混杂污染。

4. **Automating ENG-team Signals:** When a user provides feedback, say a thumbs down, it's immediately flagged to our team via Slack. We built this little snippet to help the team screen traces and prioritize the ones that need attention right away.

4. **自动化推送工程团队告警**：当用户提交反馈（例如点击“👎”）时，系统会立即通过 Slack 向工程团队发出告警。我们专门开发了这段轻量级代码，协助团队快速筛选 trace 并优先处理亟待关注的问题。

5. **Iterating Quickly:** We rigorously review the feedback, analyze the corresponding traces, and then, based on our insights, make informed adjustments to the model's role, prompts, or configurations to try and curb whatever jankiness was happening. This iterative process ensures our AI chatbot is continually refining its understanding, resonating more with user needs, and exceeding expectations over time.

5. **快速迭代优化**：我们严格审阅每条反馈，深入分析对应 trace，并基于所得洞见，有针对性地调整模型角色设定、提示词内容或系统配置，以根除各类“卡顿感”（jankiness）。这一闭环迭代机制，保障了我们的 AI 聊天机器人持续深化理解能力、更精准契合用户需求，并在长期演进中不断超越预期。

By combining granular AI insights through LangSmith with user feedback, we’ve created a pretty tight loop of perpetual improvement with HelpHub. This was such an important unlock for us as we build in tactical functionality to our AI.

通过将 LangSmith 提供的细粒度 AI 洞见与用户反馈深度融合，我们在 HelpHub 上构建起一个高度紧密、永续精进的优化闭环。这对我们而言，是在 AI 产品中务实落地各项功能的关键突破口。

# Advice for Product Teams Considering LangSmith

# 面向考虑采用 LangSmith 的产品团队的建议

When you're in the thick of product development, the whirlwind of AI and LLMs can be overwhelming. We've been there, boots on the ground, making sense of it all. From our journey with LangSmith and HelpHub, here's some hard-earned wisdom for fellow product teams.

当您深陷产品开发一线时，AI 与大语言模型（LLM）带来的技术浪潮可能令人应接不暇。我们曾亲身经历——脚踏实地、直面挑战，努力厘清其中脉络。基于我们在 LangSmith 与 HelpHub 项目中的实践历程，以下是我们为同行产品团队总结出的宝贵经验。

### Start with Data, and Start Now:

### 从数据出发，即刻开始：

AI thrives on data. But don’t wait for the 'perfect' moment or the 'perfect' dataset. Start collecting now. Setting up LangSmith takes literally 5 minutes if you’re already using LangChain. Every bit of data, every interaction, adds a layer of understanding. But, a word to the wise: quality matters. Make sure the data reflects real-world scenarios, ensuring your AI resonates with genuine user needs.

AI 依赖数据而蓬勃发展。但切勿等待所谓“完美时机”或“完美数据集”——请即刻启动数据收集工作。若您已在使用 LangChain，那么部署 LangSmith 仅需短短 5 分钟。每一条数据、每一次用户交互，都在为您的理解添砖加瓦。不过，谨记一点：数据质量至关重要。务必确保所采集的数据真实反映现实场景，从而让您的 AI 真正契合用户的实际需求。

1. **Dive Deep with Traces:** Don't just skim the surface. Use LangSmith's trace feature to dive deep into AI decision-making. Every trace is a lesson, a chance to improve.

1. **深入追踪（Traces）：** 切勿浮于表面。善用 LangSmith 的追踪功能，深入剖析 AI 的决策过程。每一次追踪都是一堂课，一次优化良机。

2. **Experiment with Prompts:** One of LangSmith's standout features is its ability to test a new prompt across multiple examples without manual entry each time. This makes it incredibly efficient to iterate on your setup, ensuring you get the desired output from the AI. Note, in addition, the Playground is also an amazing tool to dig around with for testing prompts and adjustments to traces too.

2. **提示词（Prompt）实验：** LangSmith 的一大亮点，是支持将新提示词一次性批量应用于多个示例，无需反复手动输入。这极大提升了配置迭代效率，助您稳定获得理想的 AI 输出。此外，请注意：Playground 同样是一款极为出色的工具，可用于提示词测试及追踪结果的调试与优化。

3. **Lean on the Community:** There's a whole community of LangSmith users out there. Swap stories, share challenges, and celebrate successes. You're not alone on this journey.

3. **依托社区力量：** LangSmith 拥有一个活跃的用户社区。在这里分享实践故事、交流共性挑战、庆祝阶段性成果——您绝非孤军奋战。

4. **Stay on Your Toes:** AI doesn’t stand still, and neither should you. Keep an eye on LangSmith's updates. New features? Dive in. Test, iterate, refine.

4. **保持敏捷响应：** AI 技术日新月异，您亦须与时俱进。持续关注 LangSmith 的版本更新：有新功能发布？立即上手试用；测试、迭代、精进——永不止步。

## Conclusion

## 结语

After diving deep with LangSmith's traces, experimenting with prompts, testing, and iterating on our LLM environment, here's the real talk: LangSmith isn't just a tool for us - it's become a critical inclusion in our stack. We've moved from crossing our fingers and toes hoping our AI works to knowing exactly how and why.

在深度运用 LangSmith 追踪能力、反复实验提示词、持续测试并迭代优化我们的 LLM 环境之后，我们想说句实在话：LangSmith 对我们而言，早已不止是一款工具——它已成为技术栈中不可或缺的关键一环。我们已从过去“双手合十、祈祷 AI 能正常运行”的被动状态，跃升至如今“清晰掌握 AI 如何运作、为何如此”的主动掌控阶段。

So, to our fellow AI product people trailblazers, dive into LangSmith. You’d be silly not to if you’re already using LangChain!

因此，致所有奋战在 AI 产品前沿的同行开拓者们：请即刻拥抱 LangSmith！若您已在使用 LangChain，却尚未尝试 LangSmith——那可真就太可惜了！