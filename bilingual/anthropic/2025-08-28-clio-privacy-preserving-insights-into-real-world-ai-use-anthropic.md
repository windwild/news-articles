---
title: "Clio: Privacy-preserving insights into real-world AI use \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/clio"
date: "2025-08-28"
scraped_at: "2026-03-03T06:44:15.894377330+00:00"
language: "en-zh"
translated: true
description: "A blog post describing Anthropic’s new system, Clio, for analyzing how people use AI while maintaining their privacy "
---

Societal Impacts

社会影响

# Clio: A system for privacy-preserving insights into real-world AI use

# Clio：一种面向真实世界 AI 使用场景的隐私保护型洞察系统

Dec 12, 2024

2024年12月12日

[Read the paper](https://arxiv.org/abs/2412.13678)

[阅读论文](https://arxiv.org/abs/2412.13678)

#### Footnotes

#### 脚注

1 For safety investigations, we also run Clio on a subset of first-party API traffic, keeping results restricted to authorized staff. Certain accounts are excluded from analysis, including trusted organizations with zero retention agreements. For more information about our policies, see Appendix F in the research paper.

1 出于安全调查目的，我们亦在一部分第一方 API 流量上运行 Clio 系统，且相关结果仅限授权员工访问。部分账号被排除在分析范围之外，包括已签署“零数据留存协议”的可信组织。有关我方相关政策的更多详情，请参阅该研究论文的附录 F。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们对数千场 Claude.ai 对话中可观察的 11 类行为进行了追踪，由此构建了“AI 熟练度指数”（AI Fluency Index）——该指数为衡量当今人类与 AI 协作水平提供了基准。

- Update

- 更新

Consumer Terms and Privacy Policy

《消费者条款与隐私政策》

Aug 28, 2025

2025 年 8 月 28 日

What do people use AI models for? Despite the rapidly-growing popularity of large language models, until now we’ve had little insight into exactly how they’re being used.

人们用 AI 模型来做什么？尽管大语言模型（LLM）的受欢迎程度正迅速攀升，但迄今为止，我们对其实际使用方式仍知之甚少。

This isn’t just a matter of curiosity, or even of sociological research. Knowing how people actually use language models is important for safety reasons: providers put considerable effort into pre-deployment testing, and use Trust and Safety systems to prevent abuses. But the sheer scale and diversity of what language models can do makes understanding their uses—not to mention any kind of comprehensive safety monitoring—very difficult.

这并不仅仅关乎好奇心，甚至也不仅是社会学研究的问题。了解用户如何实际使用语言模型，对安全至关重要：服务提供商需投入大量资源开展上线前测试，并依赖“信任与安全”（Trust and Safety）系统来防范滥用行为。然而，语言模型所能执行任务的庞大规模与高度多样性，使得理解其真实用途——更不用说实施全面的安全监控——变得极为困难。

There’s also a crucially important factor standing in the way of a clear understanding of AI model use: privacy. At Anthropic, we take the protection of our users’ data very seriously. How, then, can we research and observe how our systems are used while rigorously maintaining user privacy?

此外，还有一个至关重要的障碍阻碍着我们清晰理解 AI 模型的使用情况：隐私。在 Anthropic，我们高度重视用户数据的保护。那么，我们该如何在严格保障用户隐私的前提下，开展研究并观察自身系统的实际使用情况？

**Cl** aude **i** nsights and **o** bservations, or “Clio,” is our attempt to answer this question. Clio is an automated analysis tool that enables privacy-preserving analysis of real-world language model use. It gives us insights into the day-to-day uses of [claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) in a way that’s analogous to tools like Google Trends. It’s also already helping us improve our safety measures. In this post—which accompanies a [full research paper](https://arxiv.org/abs/2412.13678)—we describe Clio and some of its initial results.

**Cl** aude **i** nsights and **o** bservations（“克里奥”，Clio）正是我们为回答这一问题所作的尝试。Clio 是一款自动化分析工具，支持在保护用户隐私的前提下，对现实世界中语言模型的实际使用情况进行分析。它能为我们提供关于 [claude.ai](http://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 日常使用模式的洞察，其作用方式类似于 Google Trends 等工具；同时，它也已在助力我们优化安全防护措施。本文（同步发布于一篇[完整研究论文](https://arxiv.org/abs/2412.13678)）将介绍 Clio 的设计原理及其部分初步成果。

## How Clio works: Privacy-preserving analysis at scale

## Clio 的工作原理：面向大规模应用的隐私保护型分析

Traditional, top-down safety approaches (such as evaluations and red teaming) rely on knowing what to look for in advance. Clio takes a different approach, enabling bottom-up discovery of patterns by distilling conversations into abstracted, understandable topic clusters. It does so while preserving user privacy: data are automatically anonymized and aggregated, and only the higher-level clusters are visible to human analysts.

传统的自上而下式安全方法（例如各类评估与红队演练）依赖于预先明确需关注的风险点；而 Clio 采用了一种截然不同的路径：它通过对对话内容进行提炼，将其归纳为抽象化、可理解的主题聚类，从而实现自下而上的模式发现。整个过程严格保障用户隐私：所有数据均自动完成匿名化与聚合处理，人类分析师仅能接触到更高层级的主题聚类结果。

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_001.jpg)A summary of Clio’s analysis steps, using imaginary conversation examples for illustration.

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_001.jpg)Clio 分析流程概览（图中以虚构的对话示例辅助说明）。

Here is a brief summary of Clio’s multi-stage process:

以下是 Clio 多阶段流程的简要概述：

1. **Extracting facets**: For each conversation, Clio extracts multiple "facets"—specific attributes or metadata such as the conversation topic, number of back-and-forth turns in the conversation, or the language used.

1. **提取维度（facets）**：针对每场对话，Clio 提取多个“维度”——即特定属性或元数据，例如对话主题、对话轮次（back-and-forth turns）数量，或所用语言。

2. **Semantic clustering**: Similar conversations are automatically grouped together by theme or general topic.

2. **语义聚类**：相似的对话会依据主题或宽泛类别被自动归为一组。

3. **Cluster description**: Each cluster receives a descriptive title and summary that captures common themes from the raw data while excluding private information.

3. **聚类描述**：每个聚类均获得一个描述性标题与摘要，精准概括原始数据中的共性主题，同时严格排除任何隐私信息。

4. **Building hierarchies**: Clusters are organized into a multi-level hierarchy for easier exploration. They can then be presented in an interactive interface that analysts at Anthropic can use to explore patterns across different dimensions (topic, language, etc.).

4. **构建层级结构**：聚类被组织成多级层级结构，便于探索；随后以交互式界面呈现，供 Anthropic 的分析师跨不同维度（如主题、语言等）深入挖掘使用模式。

These four steps are powered entirely by Claude, not by human analysts. This is part of our privacy-first design of Clio, with multiple layers to create “defense in depth.” For example, Claude is instructed to extract relevant information from conversations while omitting private details. We also have a minimum threshold for the number of unique users or conversations, so that low-frequency topics (which might be specific to individuals) aren’t inadvertently exposed. As a final check, Claude verifies that cluster summaries don’t contain any overly specific or identifying information before they’re displayed to the human user.

上述四个步骤完全由 Claude 驱动，无需人工分析师参与。这是 Clio “以隐私为先”设计理念的重要组成部分，通过多重防护机制实现“纵深防御”（defense in depth）。例如，Claude 被明确指示：仅从对话中提取相关信息，同时主动忽略所有隐私细节；我们还设定了唯一用户数或对话数的最低阈值，防止低频主题（可能指向特定个体）被无意暴露；最后，Claude 还会执行终审校验——确保聚类摘要不含任何过度具体或可识别个人身份的信息，方允许其向人类用户展示。

All our privacy protections have been extensively tested, as we describe in the [research paper](https://arxiv.org/abs/2412.13678).

我们所有的隐私保护措施均已通过全面测试，详见[研究论文](https://arxiv.org/abs/2412.13678)。

## How people use Claude: Insights from Clio

## 人们如何使用 Claude：来自 Clio 的洞察

Using Clio, we've been able to glean high-level insights into how people use [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) in practice. While public datasets like [WildChat](https://arxiv.org/abs/2405.01470) and [LMSYS-Chat-1M](https://arxiv.org/abs/2309.11998) provide useful information on how people use language models, they only capture specific contexts and use cases. Clio allows us to understand the full spectrum of real-world usage of [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) (which may look different than usage of other AI systems due to differences in user bases and model types).

借助 Clio，我们得以获取关于用户在实际场景中如何使用 [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 的高层级洞察。尽管 [WildChat](https://arxiv.org/abs/2405.01470) 和 [LMSYS-Chat-1M](https://arxiv.org/abs/2309.11998) 等公开数据集为理解大语言模型的使用方式提供了宝贵参考，但它们仅覆盖特定情境与用例。而 Clio 使我们能够全面把握 [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) 在真实世界中的完整使用图谱（其使用模式可能与其他 AI 系统存在差异，原因在于用户群体构成与模型类型的不同）。

### Top use cases on Claude.ai

### Claude.ai 上的主流使用场景

We used Clio to analyze 1 million conversations with Claude on [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e) (both the Free and Pro tiers) to identify the top tasks people use Claude for. This revealed a particular emphasis on coding-related tasks: the "Web and mobile application development" category represented over 10% of all conversations. Software developers use Claude for tasks ranging from debugging code to explaining Git operations and concepts.

我们利用 Clio 分析了 [claude.ai](https://claude.ai/redirect/website.v1.ad1e2a79-c5b8-42c0-955c-e4dcc00f242e)（含免费版与 Pro 版）上总计 100 万场用户与 Claude 的对话，以识别用户最常使用的任务类型。分析结果凸显出编程相关任务占据显著比重：“网页与移动应用开发”类对话占比超过全部对话的 10%。软件开发者广泛借助 Claude 完成各类任务，包括调试代码、解释 Git 操作及核心概念等。

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_002.jpg)The most common types of conversations users had with Claude, across all languages. The area of the circle corresponds to the percentage of conversations; the titles are summaries generated by Clio after analyzing 1 million randomly-selected conversations.

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_002.jpg)用户与 Claude 开展的各类对话在所有语言中的分布情况（按出现频率排序）。圆圈面积代表该类对话占总对话数的百分比；标题为 Clio 在分析 100 万场随机抽取的对话后自动生成的聚类摘要。

Educational uses formed another significant category, with more than 7% of conversations focusing on teaching and learning. A substantial percentage of conversations (nearly 6%) concerned business strategy and operations (including tasks like drafting professional communications and analyzing business data).

教育类用途构成另一重要类别，超 7% 的对话聚焦于教学与学习。另有近 6% 的对话涉及商业战略与运营（包括起草专业沟通文本、分析商业数据等任务）。

Clio also identified thousands of smaller conversation clusters, showing the rich variety of uses for Claude. Some of these were perhaps surprising, including:

- Dream interpretation;  
- Analysis of soccer matches;  
- Disaster preparedness;  
- “Hints” for crossword puzzles;  
- _Dungeons & Dragons_ gaming;  
- Counting the r’s in the word “strawberry”.

Clio 还识别出数千个规模较小的对话聚类，展现了 Claude 应用场景的丰富多样性。其中一些用途或许令人意外，例如：

- 梦境解析；  
- 足球比赛分析；  
- 灾害应急准备；  
- 填字游戏“提示”；  
- 《龙与地下城》（_Dungeons & Dragons_）游戏；  
- 统计单词 “strawberry” 中字母 “r” 的数量。

### Claude usage varies by language

### Claude 的使用情况因语言而异

Claude usage varies considerably across languages, reflecting varying cultural contexts and needs. We calculated a base rate of how often each language appeared in conversations overall, and from there we could identify topics where a given language appeared much more frequently than usual. Some examples for Spanish, Chinese, and Japanese are shown in the figure below.

Claude 在不同语言间的使用情况差异显著，反映出各地文化背景与实际需求的不同。我们首先计算了每种语言在全部对话中出现的基础频率，继而识别出某些主题下特定语言的出现频次远高于其基础水平。下图展示了西班牙语、中文和日语的若干典型示例。

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_003.jpg)Conversation topics that appeared more frequently in three selected languages (compared to the base rate of that language), as revealed by Clio.

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_003.jpg)Clio 揭示的三种选定语言中出现频率更高的对话主题（相较于该语言的基础出现率）。

## How we improve our safety systems with Clio

## 如何借助 Clio 提升我们的安全系统

In addition to training our language models to refuse harmful requests, we also use dedicated Trust and Safety enforcement systems to detect, block, and take action on activity that might violate our [Usage Policy](https://www.anthropic.com/legal/aup). Clio supplements this work to help us understand where there might be opportunities to improve and strengthen these systems.

除训练语言模型主动拒绝有害请求外，我们还部署了专门的“信任与安全”（Trust and Safety）执行系统，用于检测、拦截并处置可能违反我们[《使用政策》（Usage Policy）](https://www.anthropic.com/legal/aup)的行为。Clio 作为该工作的有力补充，帮助我们识别现有系统中亟待优化与强化的关键环节。

We implement strict privacy access controls when it comes to who can use Clio to further enforce our policies because it may require review of individual accounts. Our Trust and Safety team is able to review topic clusters for areas that indicate likely violations of our Usage Policy. For example, a cluster titled “generate misleading content for campaign fundraising emails” or “incite hateful behavior” describes activity we prohibit. Our Trust and Safety teams can use this bottom-up review approach to identify individual accounts for further review and, if appropriate, take action in accordance with our terms and policies. We strictly limit this type of review to those with legitimate Trust and Safety needs. Our [research paper](https://arxiv.org/abs/2412.13678) includes more information on these processes.

由于 Clio 的使用可能涉及对个别账户的审查，为更严格地落实相关政策，我们对其访问权限实施了严密的隐私管控。我们的“信任与安全”团队可借助 Clio 审查各类话题聚类，识别其中可能违反《使用政策》的行为模式。例如，“为竞选筹款邮件生成误导性内容”或“煽动仇恨行为”等聚类标题，即明确指向我们所禁止的活动类型。团队可通过这种自下而上的审查方式，定位需进一步核查的个别账户，并视情况依据我们的条款与政策采取相应措施。此类审查权限被严格限定于确有“信任与安全”工作需要的人员。关于上述流程的更多细节，请参阅我们的[研究论文](https://arxiv.org/abs/2412.13678)。

We’re still in the process of rolling out Clio across all of our enforcement systems, but so far it has proven to be a useful part of our safety tool kit, helping us discover areas of our protective measures that we need to strengthen.

目前，Clio 尚在向我们全部执法系统全面部署的过程中；但迄今实践已证明，它是安全工具箱中一项极具价值的组件，有助于我们发现现有防护措施中亟需加强的薄弱环节。

### Identifying and blocking coordinated misuse

### 识别并阻断协同滥用行为

Clio has proven effective at identifying patterns of coordinated, sophisticated misuse that would otherwise be invisible when looking at individual conversations, and that might evade simpler detection methods. For example in late September, we identified a network of automated accounts using similar prompt structures to generate spam for search engine optimization. While no individual conversation violated our [Usage Policy](https://www.anthropic.com/legal/aup), the pattern of behavior across accounts revealed a form of coordinated platform abuse we explicitly prohibit in our policy and we removed the network of accounts. We’ve also used Clio to identify other activity prohibited by our [Usage Policy](https://www.anthropic.com/legal/aup), such as attempting to resell unauthorized access to Claude.

Clio 已被证实能够有效识别出那些在单个对话层面难以察觉、且可能绕过更简单检测方法的协调性、高阶滥用行为模式。例如，今年九月下旬，我们发现了一个由自动化账号组成的网络，这些账号使用高度相似的提示词结构批量生成用于搜索引擎优化（SEO）的垃圾内容。尽管其中任何单次对话均未违反我们的[《使用政策》](https://www.anthropic.com/legal/aup)，但跨账号所呈现的行为模式揭示了一种我们在政策中明确禁止的协同式平台滥用行为，因此我们移除了该账号网络。我们还利用 Clio 识别出其他违反[《使用政策》](https://www.anthropic.com/legal/aup)的行为，例如试图转售未经授权访问 Claude 的权限。

### Enhanced monitoring for high-stakes events

### 针对高风险事件的增强型监控

Clio also helps us monitor novel uses and risks during periods of uncertainty or high-stakes events. For example, while we conducted a wide range of safety tests in advance of launching a new [computer use](https://www.anthropic.com/news/developing-computer-use) feature, we used Clio to screen for emergent capabilities and harms we might have missed1. Clio provided an additional safeguard here, as well as insights that helped us continually improve our safety measures throughout the rollout and in future versions of our systems.

Clio 还帮助我们在不确定性加剧或高风险事件期间，监测新兴用途与潜在风险。例如，在推出一项新的[“计算机使用”](https://www.anthropic.com/news/developing-computer-use)功能之前，我们开展了大量安全测试；与此同时，我们借助 Clio 筛查可能被遗漏的新兴能力与潜在危害¹。Clio 在此过程中提供了额外的安全保障，并产出关键洞见，助力我们在该功能上线全周期及后续系统版本中持续优化安全机制。

Clio has also helped us monitor for unknown risks in the run up to important public events like elections or major international events. In the months preceding the 2024 US General Election, we [used Clio](https://www.anthropic.com/news/elections-ai-2024) to identify clusters of activity relating to US politics, voting, and related issues, and guard against any potential risks or misuse. The ability to detect “unknown unknowns,” made possible through Clio, complements our proactive safety measures and helps us respond quickly to new challenges.

Clio 同样助力我们在重大公共事件（如选举或大型国际活动）临近期间，监测此前未知的风险。在美国2024年大选前数月，我们[运用 Clio](https://www.anthropic.com/news/elections-ai-2024) 识别出一批聚焦美国政治、投票及相关议题的活跃对话集群，并防范任何潜在风险或滥用行为。“未知的未知项”（unknown unknowns）的识别能力——这正是 Clio 所赋能的关键优势——有力补充了我们主动式安全措施，并使我们得以快速响应新出现的挑战。

### Reducing false negatives and false positives

### 降低漏报率与误报率

In general, there was agreement between Clio and our pre-existing Trust and Safety classifiers on which conversation clusters were considered concerning. However, there was some disagreement for some clusters. One opportunity for improvement was false negatives (when a system didn’t flag a particular conversation as potentially harmful when in fact it was). For example, our systems sometimes failed to flag violating content when the user asked Claude to translate from one language to another. Clio, however, spotted these conversations.

总体而言，Clio 与我们既有的可信与安全（Trust and Safety）分类器在哪些对话集群应被视为“值得关注”方面基本一致；但针对部分集群，二者判断存在分歧。其中一项亟待改进的方向是降低漏报率（false negatives）——即系统未能将实际上具有潜在危害性的某次对话标记为风险内容。例如，当用户要求 Claude 进行语际翻译时，我们的系统有时未能识别并标记其中的违规内容；而 Clio 则成功捕获了此类对话。

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_004.jpg)Scatterplot of conversation clusters (one dot = one cluster) and the extent to which they were flagged as concerning according to our Trust and Safety classifiers (x-axis) and according to Clio (y-axis). In the top left are clusters that were potentially under-flagged by our Trust and Safety classifiers: false negatives that contained concerning content that wasn’t necessarily flagged. In the bottom right are clusters that were potentially over-flagged: false positives that likely did not contain concerning content. The overall correlation between the Trust and Safety and the Clio classifications was r = 0.71, indicating broad overall agreement between the two systems.

![](images/clio-privacy-preserving-insights-into-real-world-ai-use-anthropic/img_004.jpg)对话集群散点图（每个点代表一个集群），横轴表示既有可信与安全分类器将其标记为“值得关注”的程度，纵轴表示 Clio 的相应标记程度。左上角区域为可能被既有分类器低估的集群：即包含需关注内容却未被充分标记的漏报案例；右下角区域则为可能被高估的集群：即很可能不包含需关注内容却被错误标记的误报案例。整体来看，可信与安全分类器和 Clio 分类结果之间的相关系数为 r = 0.71，表明二者在总体判断上具有高度一致性。

We also used Clio to investigate false positives—another common challenge when developing Trust and Safety classifiers, where the classifier inadvertently tags benign content as harmful. For example, conversations from job seekers requesting advice on their own resumes were sometimes incorrectly flagged by our classifiers (due to the presence of personal information). Programming questions related to security, networking, or web scraping were occasionally misidentified as potential hacking attempts. Even conversations about combat statistics in the aforementioned _Dungeons & Dragons_ conversations sometimes triggered our harm detection systems. We used Clio to highlight these erroneous decisions, helping our safety systems to trigger only for content that really does violate our policies, and otherwise keep out of our users’ way.

我们还利用 Clio 探查误报问题——这是开发可信与安全分类器过程中另一常见挑战，即分类器将本属无害的内容错误标记为有害。例如，求职者就个人简历寻求建议的对话，有时会因含有个人信息而被我们的分类器误判；涉及安全、网络或网页抓取的编程问题，偶尔也被错认为潜在黑客行为；甚至前述《龙与地下城》（_Dungeons & Dragons_）对话中关于战斗统计的讨论，有时也会意外触发我们的危害检测系统。我们借助 Clio 揭示这些错误判定，从而确保安全系统仅在内容确实违反政策时才启动干预，其余情况下则尽可能避免干扰用户正常使用。

## Ethical considerations and mitigations

## 伦理考量与缓解措施

Clio provides valuable insights for improving the safety of deployed language models. However, it did also raise some important ethical considerations that we considered and addressed while developing the system:

Clio 为提升已部署语言模型的安全性提供了宝贵洞见。然而，在系统开发过程中，它也引发了一些重要的伦理关切——对此，我们进行了审慎评估并采取了相应缓解措施：

- **False positives:** In the Trust and Safety context, we've implemented key safeguards with respect to potential false positives. For example, at this time we don't use Clio’s outputs for automated enforcement actions, and we extensively validate its performance across different data distributions—including testing across multiple languages, as we detail in our paper.  
- **误报（False Positives）：** 在“信任与安全”（Trust and Safety）背景下，我们已针对潜在误报实施了关键防护措施。例如，目前我们不会将 Clio 的输出用于自动化执法操作；同时，我们对其在不同数据分布下的性能进行了广泛验证——包括在多种语言场景下的测试，具体细节详见我们的论文。

- **Misuse of Clio:** A system like Clio could be misused to engage in inappropriate monitoring. In addition to strict access controls and our privacy techniques, we mitigate this risk by implementing strict data minimization and retention policies: we only collect and retain the minimum amount of data necessary for Clio.  
- **Clio 的滥用风险：** 像 Clio 这样的系统可能被滥用于不当监控。除严格的访问控制和隐私保护技术外，我们还通过实施严格的数据最小化与数据留存政策来缓解该风险：我们仅收集并保留 Clio 正常运行所必需的最少数据量。

- **User privacy:** Despite Clio's strong performance in our privacy evaluations, it's possible, as with any real-world privacy system, that our systems might not catch certain kinds of private information. To mitigate this potential risk, we regularly conduct audits of our privacy protections and evaluations for Clio to ensure our safeguards are performing as expected. As time goes on, we also plan to use the latest Claude models in Clio so we can continuously improve the performance of these safeguards.  
- **用户隐私：** 尽管 Clio 在我们的隐私评估中表现优异，但正如所有现实世界中的隐私系统一样，我们的系统仍有可能遗漏某些类型的敏感信息。为降低这一潜在风险，我们会定期对 Clio 的隐私保护机制开展审计与评估，以确保各项防护措施按预期运行。未来，我们还计划在 Clio 中集成最新版 Claude 模型，从而持续提升这些防护能力的表现。

- **User trust:** Despite our extensive privacy protections, some users might perceive a system like Clio as invasive or as interfering with their use of Claude. We've chosen to be transparent about Clio's purpose, capabilities, limitations, and what insights we’ve learned from it. And as we noted above, there are instances where Clio identified false positives (where it appeared there was activity violating our usage policy where there wasn’t) in our standard safety classifiers, potentially allowing us to interfere _less_ in legitimate uses of the model.  
- **用户信任：** 尽管我们已部署了全面的隐私保护措施，部分用户仍可能将 Clio 这类系统视为具有侵入性，或认为其干扰了他们对 Claude 的正常使用。为此，我们选择就 Clio 的设计目的、功能边界、固有局限以及我们从中获得的关键洞见保持充分透明。此外，如前所述，在标准安全分类器中，Clio 曾识别出若干误报案例（即系统误判某行为违反了我们的使用政策，而实际上并未违规），这反而有助于我们在合法使用场景中 *减少* 不必要的干预。

## Conclusions

## 结论

Clio is an important step toward empirically grounded AI safety and governance. By enabling privacy-preserving analysis of real-world AI usage, we can better understand how these systems are actually used. Ultimately, we can use Clio to make AI systems safer.  
Clio 是迈向基于实证的 AI 安全与治理的重要一步。通过支持对真实世界中 AI 使用情况的隐私保护型分析，我们得以更深入地理解这些系统在实践中如何被实际使用。最终，我们可以借助 Clio 提升 AI 系统的整体安全性。

AI providers have a dual responsibility: to maintain the safety of their systems while protecting user privacy. Clio demonstrates that these goals aren't mutually exclusive—with careful design and implementation, we can achieve both. By openly discussing Clio, we aim to contribute to positive norms around the responsible development and use of such tools.  
AI 提供方肩负双重责任：既要保障系统的安全性，又要守护用户隐私。Clio 表明，这两项目标并非互斥；只要经过审慎的设计与实施，二者完全可以兼得。我们公开探讨 Clio，旨在推动形成关于此类工具负责任研发与使用的积极行业规范。

We're continuing to develop and improve Clio, and we hope that others will build upon this work. For additional technical details about Clio, including our privacy validations and evaluation methods, please see the [full research paper](https://arxiv.org/abs/2412.13678).  
我们正持续推进 Clio 的研发与优化，并期待更多研究者在此基础上开展延伸工作。有关 Clio 的更多技术细节（包括隐私验证方法与评估流程），请参阅[完整研究论文](https://arxiv.org/abs/2412.13678)。

_We’re currently hiring for our Societal Impacts team. If you’re interested in working on Clio or related research questions, we'd love to receive your application. You can find more information about the role [at this link](https://boards.greenhouse.io/anthropic/jobs/4251453008)._  
_我们当前正在为“社会影响团队”（Societal Impacts team）招聘人才。若您有意参与 Clio 或相关研究课题，我们诚挚欢迎您的申请。有关该职位的更多信息，请访问[此链接](https://boards.greenhouse.io/anthropic/jobs/4251453008)。_

**Edit 14 January 2025:** Links to the Clio paper in this post have been updated to point to the _arXiv_ version.  
**更新说明（2025 年 1 月 14 日）：** 本文中所有指向 Clio 论文的链接均已更新为指向 _arXiv_ 版本。