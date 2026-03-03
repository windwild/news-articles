---
title: "How Mendable leverages LangSmith to debug Tools & Actions"
source: "LangChain Blog"
url: "https://blog.langchain.com/how-mendable-leverages-langsmith-to-debug-tools-actions/"
date: "2024-01-25"
scraped_at: "2026-03-03T08:17:42.945343935+00:00"
language: "en-zh"
translated: true
---

**_Editor's Note: this blog is from Nicolas Camara, CTO @ Mendable. Mendable.ai is a platform helping enterprise teams answer technical questions with AI. We're incredibly excited to highlight how they are using LangChain Agents and LangSmith on their newest feature:_** [**_Tools & Actions_**](https://www.mendable.ai/blog/tools?ref=blog.langchain.com) **_._**

**_编者按：本文作者为 Nicolas Camara，Mendable 公司首席技术官（CTO）。Mendable.ai 是一个面向企业团队的平台，借助 AI 帮助其解答技术问题。我们非常激动地向大家介绍：他们如何在其最新功能——_**[**_Tools & Actions（工具与操作）_**](https://www.mendable.ai/blog/tools?ref=blog.langchain.com) **_——中集成 LangChain Agents 与 LangSmith。_**

It is no secret that 2024 will be the year we start seeing more LLMs baked into our workflows. This means that the way we interact with LLM models will be less just Question and Answer and more action-based.

众所周知，2024 年将是大语言模型（LLM）深度融入我们日常工作流的一年。这意味着我们与 LLM 的交互方式，将不再局限于简单的“提问—回答”，而会越来越多地转向以“执行操作”为核心。

At [Mendable.ai](https://www.mendable.ai/?ref=blog.langchain.com), we are seeing this transformation first hand. Late last year, we equipped ~1000 customer success + sales people at a $20+ billion tech company with GTM assistants that help with tech guidance, process help, and industry expertise. In five months, the platform achieved $1.3 million in savings, and it's projected to save $3 million this year due to decreased research time and dependency on technical resources. Now we are working with that same company to enable these assistants to take action, enabling even more efficiency improvements.

在 [Mendable.ai](https://www.mendable.ai/?ref=blog.langchain.com)，我们正亲历这一变革。去年年底，我们为一家市值超 200 亿美元的科技公司部署了面向约 1000 名客户成功与销售员工的 GTM（Go-to-Market）智能助手，为其提供技术指导、流程支持及行业专业知识。仅用五个月，该平台即实现 130 万美元的成本节约；预计今年总节支额将达到 300 万美元——这主要得益于研究时间大幅缩短，以及对技术资源依赖程度的显著降低。目前，我们正与同一家公司合作，进一步赋能这些助手“主动执行操作”，从而带来更深层次的效率提升。

An example use case would be a salesperson who wants to get the latest focus areas for a prospect and their company. When asking an assistant enabled with our Tools & Actions “what are the latest key initiatives for X”,  the assistant could:

一个典型用例是：某位销售人员希望了解某潜在客户及其所在公司的最新战略重点。当其向已启用“Tools & Actions”功能的助手提问——“X 公司当前最重要的关键举措有哪些？”时，该助手可执行以下操作：

1. Call the CRM API and get the exact team the salesperson is trying to sell to  
1. 调用 CRM 接口，精准获取该销售人员正在对接的目标团队信息；  

2. Use the Google News or DUNS API to get the latest news on the specific team and related initiatives  
2. 调用 Google News 或 DUNS 接口，获取该目标团队及其相关战略举措的最新动态；  

3. Call the CoreSignal API to get the latest hiring trends for the company based on job postings and more  
3. 调用 CoreSignal 接口，基于公开职位发布等数据，获取该公司最新的招聘趋势；  

4. Interpret the news and hiring trends, highlighting ways the salesperson can use these new found initiatives to sell in meeting  
4. 综合分析上述新闻与招聘趋势，提炼出可直接用于销售会议的关键切入点，帮助销售人员更有针对性地推进成交。

As you can see the introduction of Tools & Actions in Mendable expands capabilities quite a bit, enabling chatbots to access and utilize a wider range of data sources and perform various automated tasks. On the backend, to ensure the precision and efficiency of these features, Mendable leverages LangSmith's debugging tools, a critical component in the development and optimization of our AI-driven functionalities.

如您所见，“Tools & Actions”功能的引入显著拓展了 Mendable 的能力边界——它使聊天机器人能够接入并调用更广泛的数据源，并执行各类自动化任务。在后端，为确保这些功能的准确性与高效性，Mendable 深度集成了 LangSmith 的调试工具；该工具是我们开发与优化 AI 驱动功能过程中不可或缺的关键组件。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_001.jpg)

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_001.jpg)

**Opening the ‘black box’ of agent execution**

**揭开智能体（Agent）执行过程的“黑箱”**

One of the biggest problems when building applications that depend on agentic behavior is reliability and lack of observability. Understanding the key interactions, decisions of an Agent loop can be quite tricky. Especially when it has been giving access to multiple resources and is embedded in a production pipeline.

在构建依赖智能体行为（agentic behavior）的应用时，最棘手的问题之一便是可靠性不足与可观测性缺失。要清晰理解智能体循环（Agent loop）中的关键交互与决策逻辑，往往十分困难——尤其当该智能体被授予多个外部资源访问权限，且已深度嵌入生产级流水线时。

While building Tools & Actions, the core aspect we had in mind was giving the ability for the user to create their own Tool via an API call. We designed this so the user could input a tag such as `<ai-generated-value>` when creating the API request and the AI can fill that value at request time with an ‘AI generated’ value based on the user's question and schema. This is one example, but there were a lot more just in time AI inputs/outputs that went into it. This posed some challenges in the building process that we weren’t expecting. Soon our development process was full of “console.logs” everywhere and high latency runs. Trying to debug why a tool wasn’t being called or why the API request had failed became a nightmare. It quickly started to get messy and we had no proper visibility on what the agentic behavior looked like nor if custom tools were working as expected.

在开发“Tools & Actions”功能的过程中，我们最核心的设计目标之一，是赋予用户通过 API 调用自主创建专属工具（Tool）的能力。为此，我们设计了一种机制：用户在构造 API 请求时，可插入类似 `<ai-generated-value>` 的占位标签；系统将在请求发起时，依据用户提问内容与预设 Schema，由 AI 实时生成并填充该值。这只是其中一个示例；实际上，整个功能还融合了大量“即时生成”的 AI 输入与输出。然而，这种设计也带来了我们始料未及的工程挑战：开发过程中很快充斥着遍布各处的 `console.log` 日志语句，且请求延迟居高不下。排查“某个工具为何未被调用”或“某次 API 请求为何失败”，变成了一场噩梦；代码迅速变得混乱不堪，我们既无法清晰观察智能体的实际行为路径，也无法确认自定义工具是否按预期正常运行。

Here is where LangSmith from LangChain came to help.  
LangChain 的 LangSmith 在此处发挥了关键作用。

If you are not familiar, LangSmith allows you to easily debug, evaluate and manage LLM apps. It, of course, integrates swiftly with LangChain. As we were already using parts of the [OpenAI tool agents](https://js.langchain.com/docs/modules/agents/quick_start?ref=blog.langchain.com) that LangChain provides, the integration was smooth.  
如果您尚不熟悉，LangSmith 是一款可帮助您轻松调试、评估和管理大语言模型（LLM）应用的工具。它自然也与 LangChain 实现了快速集成。由于我们此前已部分采用了 LangChain 提供的 [OpenAI 工具智能体（tool agents）](https://js.langchain.com/docs/modules/agents/quick_start?ref=blog.langchain.com)，因此本次集成过程十分顺畅。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_002.jpg)

**The Debugging Process**  
**调试流程**

LangSmith allows us to have a peek inside of the agents’ brain. This is very useful for debugging how an agent's thinking and decision process can impact the output.  
LangSmith 使我们得以一窥智能体（agent）的“思维过程”。这一能力对于调试智能体的推理逻辑与决策路径如何影响最终输出尤为宝贵。

When you enable tracing in a LangChain, the app captures and displays a detailed visualization of the runs’ call hierarchy. This feature allows you to explore the inputs, outputs, parameters, response times, feedback, token consumption, and other critical metrics of your run.  
在 LangChain 中启用追踪（tracing）功能后，应用将捕获并展示每次运行（run）的完整调用层级关系图。该功能支持您深入查看每次运行的输入、输出、参数配置、响应耗时、用户反馈、Token 消耗量以及其他关键性能指标。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_003.jpg)

When we connected LangSmith to our tools & action module, we quickly spotted problems that we didn’t have the visibility for.  
当我们把 LangSmith 接入我们的工具（Tools）与动作（Actions）模块后，迅速发现了此前缺乏可观测性而一直未被察觉的问题。

Take a look for instance on one of our first traces using Tools. As you can see here, the last call to \`ChatOpenAI\` took a long time: 7.23 seconds.  
以我们最早使用 Tools 功能的一次追踪记录为例：如图所示，最后一次对 \`ChatOpenAI\` 的调用耗时长达 7.23 秒。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_004.jpg)

When you click on the 7.23s Run we saw that the prompt was massive, it had concatenated all of our RAG pipeline prompts/sources with our Tools & Actions, leading to delay in the streaming process. This allowed to further optimize what chunks of the prompt need to be used by the Tools & Action module, reducing total latency overall.  
点击该耗时 7.23 秒的运行记录后，我们发现其提示词（prompt）异常庞大——系统将整个 RAG 流水线中的所有提示模板与数据源，连同 Tools 与 Actions 相关内容全部拼接进了单个 prompt，从而严重拖慢了流式响应（streaming）进程。基于此洞察，我们进一步优化了 Tools & Actions 模块所需加载的 prompt 片段，显著降低了整体端到端延迟。

**Inspecting Tools**

**检查工具**

Another valuable aspect of having ease access to traces is the ability to inspect a tool input. As I mentioned in the beginning, we allow users to create custom tools in Mendable. With that we need to make sure that the building process of a tool in the UI is easy and quick but also performs well. This means that when we create a tool in the backend, it needs to have the correct schema defined partially by what the user inputted in our UI (API request details) but also by what the AI will automatically feed in at request time.

能够便捷地访问追踪记录（traces）的另一大价值，就在于可以细致检查某次工具调用的输入。正如我在开头所提到的，Mendable 允许用户创建自定义工具。因此，我们必须确保：在 UI 中构建工具的过程既简单快捷，又能保持良好性能。这意味着，当我们在后端创建一个工具时，其 Schema 必须准确无误——该 Schema 部分由用户在 UI 中输入的内容（例如 API 请求细节）决定，同时也需兼容 AI 在实际请求发生时自动注入的参数。

In the example below, it shows a Recent News Tool that was run. The question inside the {query : { q } } parameter was generated by the AI.

下方示例展示了一次“近期新闻工具”（Recent News Tool）的执行过程。其中 `{query : { q } }` 参数内的查询内容是由 AI 自动生成的。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_005.jpg)

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_005.jpg)

Making sure that query was accurate with what the user inputted but also optimized for the tool being used was very challenging. Thankfully it was very easy to double check that with LangSmith. What we did is we ran the same tool with different queries ~20 times and quickly scrolled through LangSmith making sure the output and schema were accurate. The times that weren’t accurate, we could easily understand why by opening the trace further or by annotating in LangSmith so we could review it later.

确保该查询既忠实反映用户原始输入，又针对当前工具做了充分优化，是一项极具挑战性的任务。所幸，借助 LangSmith，我们能非常便捷地进行二次验证。具体做法是：我们使用约 20 种不同查询反复运行同一工具，并快速浏览 LangSmith 中的追踪记录，逐一确认输出结果与 Schema 的准确性；对于不准确的案例，我们只需进一步展开对应 trace，或直接在 LangSmith 中添加标注，即可清晰定位问题原因，便于后续复盘分析。

What we realized is that the Tools description was critical for the correct schema and input to be generated. With this new insight we obtained from running tons of experiments, we went ahead and improved the AI generated part of that in our product and also made users aware that they need to provide good detailed descriptions when creating a Tool.

我们由此意识到：工具（Tool）的描述文本，对 AI 正确生成 Schema 和输入参数起着决定性作用。基于大量实验所获得的这一新洞见，我们立即优化了产品中由 AI 生成描述文本的部分，同时也在产品界面中明确提示用户：在创建工具时，务必提供详尽、准确的描述信息。

**Building our Dataset**

**构建数据集**

With all the optimization experiments taking over, the need to quickly save inputs/outputs for further evaluation became evident. With LangSmith we selected the runs that we wanted to add to our dataset and clicked the “Add to Dataset” button.

随着各类优化实验全面铺开，亟需一种高效方式将输入/输出样本快速保存下来，以便后续评估分析。借助 LangSmith，我们只需选中希望纳入数据集的若干次运行记录（runs），然后点击“Add to Dataset”（加入数据集）按钮即可。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_006.jpg)

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_006.jpg)

This was a very quick and easy win for us as we now had all the data in one place from our runs and we could even evaluate that using LangSmith itself.

这为我们带来了一个极为快速且轻松的收益：所有运行产生的数据如今都集中存储于一处；更进一步，我们甚至可以直接利用 LangSmith 自身的功能，对这些数据开展系统性评估。

![](images/how-mendable-leverages-langsmith-to-debug-tools-actions/img_007.jpg)

**Conclusion**

**结论**

LangSmith's debugging tools have been a game-changer for us.  

LangSmith 的调试工具彻底改变了我们的开发体验。

They've given us a clear window into how our Tools and Action AI agent thinks and acts, which has been helpful for tackling tricky issues like slow response times and making our debugging process way smoother.  

它们为我们清晰地揭示了 Tools 与 Action AI 智能体的思考与行为逻辑，极大助力我们解决诸如响应延迟等棘手问题，也让整个调试流程顺畅许多。

[Mendable Tools & Actions](https://mendable.ai/blog/tools?ref=blog.langchain.com) has launched but we are still early in the process.  

[Mendable Tools & Actions](https://mendable.ai/blog/tools?ref=blog.langchain.com) 已正式发布，但目前仍处于早期阶段。

We have been working with amazing enterprises to help improve it and tailor custom actions to them.  

我们正与多家优秀企业紧密合作，持续优化该产品，并为其定制专属操作（custom actions）。

If you are interested in testing Mendable, email us at [garrett@mendable.ai](mailto:garrett@mendable.ai) with your use case.  

如果您有兴趣试用 Mendable，请将您的具体使用场景发送邮件至 [garrett@mendable.ai](mailto:garrett@mendable.ai)，与我们联系。

Also, if you are looking to speed up your LLM development process, I would definitely recommend trying [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com) out — especially if you already use LangChain in your pipeline.  

此外，若您希望加速大语言模型（LLM）应用的开发流程，我强烈推荐您尝试 [LangSmith](https://www.langchain.com/langsmith?ref=blog.langchain.com)——尤其当您已在技术栈中集成 LangChain 时。

I hope my insights were helpful and thanks to LangChain for being an awesome partner.  

希望我的分享对您有所启发；同时，衷心感谢 LangChain 作为卓越合作伙伴给予的支持。