---
title: "Anthropic Economic Index: AI's impact on software development"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/impact-software-development"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:05.318269525+00:00"
language: "en-zh"
translated: true
description: "Data on how software developers are using Claude"
---
{% raw %}

Societal ImpactsEconomic Research

社会影响与经济研究

# Anthropic Economic Index: AI’s impact on software development

# Anthropic 经济指数：AI 对软件开发的影响

Apr 28, 2025

2025 年 4 月 28 日

![Anthropic Economic Index: AI’s impact on software development](images/anthropic-economic-index-ai_s-impact-on-software-development/img_001.svg)

![Anthropic 经济指数：AI 对软件开发的影响](images/anthropic-economic-index-ai_s-impact-on-software-development/img_001.svg)

#### Footnotes

#### 脚注

1\. Claude.ai conversations were specifically those from Claude.ai Free and Pro. This sample only includes Claude Code sessions powered by the first-party API (Claude Code can be powered by Anthropic first-party APIs or third party cloud provider APIs). All conversations used in our analysis across Claude.ai and Claude Code were from April 6-13, 2025. The initial sample was split evenly across Claude.ai and Claude Code and for Claude.ai, we applied a Claude-based filter to select conversations related to coding. To account for the filter, we renormalized analyses to equally weight Claude Code and Claude.ai interactions, where applicable.

1．本研究中的 Claude.ai 对话特指来自 Claude.ai 免费版（Free）和专业版（Pro）的对话。该样本仅包含由 Anthropic 自研 API 驱动的 Claude Code 会话（Claude Code 可由 Anthropic 自研 API 或第三方云服务商 API 驱动）。我们分析所用的所有 Claude.ai 和 Claude Code 对话均采集自 2025 年 4 月 6 日至 13 日。初始样本在 Claude.ai 和 Claude Code 之间平均分配；针对 Claude.ai，我们应用了基于 Claude 的过滤器，以筛选出与编程相关的对话。为消除该过滤器带来的偏差，在适用情况下，我们对分析结果进行了重新归一化处理，使 Claude Code 与 Claude.ai 的交互在权重上保持相等。

2\. The HTML numbers for Claude.ai are likely inflated slightly because [Artifacts](https://support.anthropic.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them) leverage HTML. While we filter out Artifacts that are unrelated to coding, we don’t explicitly filter out Artifacts that contain coding-related content from the analysis because significant coding usage happens within Artifacts.

2．Claude.ai 的 HTML 相关数据可能略有高估，原因在于 [Artifacts](https://support.anthropic.com/en/articles/9487310-what-are-artifacts-and-how-do-i-use-them) 功能本身依赖 HTML 技术。尽管我们已过滤掉与编程无关的 Artifacts，但并未显式地将包含编程相关内容的 Artifacts 排除在分析之外，因为大量编程活动实际发生于 Artifacts 环境中。

3\. Claude.ai usage does not include Claude For Work (Team and Enterprise plans) usage, which implies that enterprise numbers for Claude.ai specifically are likely undercounted because a significant amount of enterprise usage on Claude.ai occurs within the Claude For Work product.

3．Claude.ai 的使用数据未涵盖 Claude For Work（团队版与企业版）的使用情况。这意味着，Claude.ai 在企业用户层面的具体使用量很可能被低估，因为大量企业级用户对 Claude.ai 的使用是通过 Claude For Work 产品实现的。

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的基准。

Jobs that involve computer programming are a small sector of the modern economy, but an influential one. The past couple of years have seen them changed dramatically by the introduction of AI systems that can assist with—and automate—significant amounts of coding work.

涉及计算机编程的工作虽仅占现代经济的一小部分，却具有重要影响力。过去两年间，AI 系统的引入已对其造成剧烈变革：这些系统不仅能辅助编码工作，更能实现大量编码任务的自动化。

In our [previous Economic Index research](https://www.anthropic.com/news/the-anthropic-economic-index), we found very disproportionate use of Claude by US workers in computer-related occupations: that is, there were many more conversations with Claude about computer-related tasks than one would predict from the number of people working in relevant jobs. It’s the same in [the educational context](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude): Computer Science degrees—which involve large amounts of coding—show highly disproportionate AI use.

在我们此前发布的[《Anthropic 经济指数》研究报告](https://www.anthropic.com/news/the-anthropic-economic-index)中发现，美国从事计算机相关职业的工作者对 Claude 的使用程度极不均衡：即围绕计算机相关任务与 Claude 展开的对话数量，远超从事相关职业的人口比例所预示的水平。这一现象同样出现在[教育场景](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude)中：计算机科学专业（包含大量编程实践）的学生对 AI 的使用也呈现高度不均衡特征。

To understand these changes in more detail, we conducted an analysis of 500,000 coding-related interactions across [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835) (the “default” way that most people interact with Claude) and [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview) (our new specialist coding “agent” that can independently accomplish chains of complex tasks using a variety of digital tools).

为更深入理解上述变化，我们对来自 [Claude.ai](http://claude.ai/redirect/website.v1.6828d5f8-ef33-49d1-b013-3e07a5ed2835)（绝大多数用户与 Claude 交互的“默认”方式）和 [Claude Code](https://docs.anthropic.com/en/docs/agents-and-tools/claude-code/overview)（我们新推出的专注编程的“智能体”，可借助多种数字工具独立完成一系列复杂任务）的共计 500,000 条编程相关交互进行了分析。

We found three key patterns:

我们发现了三大关键趋势：

1. **The coding agent is used for more automation.** 79% of conversations on Claude Code were identified as “automation”—where AI directly performs tasks—rather than “augmentation,” where AI collaborates with and enhances human capabilities (21%). In contrast, only 49% of Claude.ai conversations were classified as automation. _This might imply that as AI agents become more commonplace, and as more agentic AI products are built, we should expect more automation of tasks._

1. **编程智能体更多用于自动化任务。** 在 Claude Code 的对话中，79% 被归类为“自动化”（即 AI 直接执行任务），而仅 21% 属于“增强型”（即 AI 与人类协作并提升其能力）。相比之下，Claude.ai 上仅有 49% 的对话被划分为自动化类型。_这或许意味着：随着 AI 智能体日益普及，以及更多具备自主行动能力（agentic）的 AI 产品问世，我们将看到越来越多的任务被自动化取代。_

2. **Coders commonly use AI to build user-facing apps.** Web-development languages such as JavaScript and HTML were the most common programming languages used in our dataset, and user interface and user experience tasks were among the top coding uses. _This suggests that jobs that center on making simple applications and user interfaces may face disruption from AI systems sooner than those focused purely on backend work_.

2. **开发者普遍借助 AI 构建面向用户的程序。** 在我们的数据集中，JavaScript 和 HTML 等网页开发语言使用频率最高；而用户界面（UI）与用户体验（UX）相关任务亦位居编程用途前列。_这表明：以开发简易应用程序和用户界面为核心职责的岗位，或将比纯粹聚焦后端开发的岗位更早受到 AI 系统的冲击。_

3. **Startups are the main early adopters of Claude Code, while enterprises lag behind.** In a preliminary analysis, we estimated that 33% of conversations on Claude Code served startup-related work, compared to only 13% identified as enterprise-relevant applications. _The adoption gap suggests a divide between nimbler organizations using cutting-edge AI tools, and traditional enterprises._

3. **初创企业是 Claude Code 的主要早期采用者，而大型企业则相对滞后。** 初步分析显示，约 33% 的 Claude Code 对话服务于初创企业相关工作，而明确关联企业级应用场景的对话仅占 13%。_这种采用率差距反映出两类组织间的分野：一类是行动敏捷、积极采用前沿 AI 工具的新兴组织；另一类则是沿袭传统模式的成熟企业。_

### How we analyzed conversations on Claude Code and Claude.ai

### 我们如何分析 Claude Code 与 Claude.ai 上的对话

We analyzed the 500,000 total Claude interactions (split between Claude Code and Claude.ai1) using our [privacy-preserving analysis tool](https://www.anthropic.com/research/clio), which distills user conversations into higher-level, anonymized insights. Here, we used it to identify the topic of the conversation (e.g. “UI/UX component development”), or—as we’ll explain below—to categorize a conversation as focusing on “augmentation” versus “automation”.

我们借助 Anthropic 自研的[隐私保护型分析工具 Clio](https://www.anthropic.com/research/clio)，对总计 500,000 条 Claude 交互（分别来自 Claude Code 和 Claude.ai¹）进行了分析。该工具可将用户原始对话提炼为更高层级、经匿名化处理的洞察结论。本研究中，我们利用它识别对话主题（例如：“UI/UX 组件开发”），或如后文所述，将对话归类为侧重“增强型”还是“自动化”。

### How do developers interact with Claude?

### 开发者如何与 Claude 互动？

In our previous Economic Index reports, we separated out “automation,” where AI directly performs tasks, from “augmentation,” where AI collaborates with a user to perform a task.  
在我们此前的《经济指数》报告中，我们将“自动化”（AI 直接执行任务）与“增强”（AI 与用户协作完成任务）区分开来。

Here, we found that Claude Code showed dramatically higher automation rates—79% of conversations involved some form of automation, compared to 49% on Claude.ai.  
本报告发现，Claude Code 的自动化率显著更高：79% 的对话涉及某种形式的自动化，而 Claude.ai 上这一比例仅为 49%。

We also split automation and augmentation into several subtypes (as discussed in our [previous work](https://www.anthropic.com/news/the-anthropic-economic-index)). “Feedback Loop” patterns, where Claude completes tasks autonomously but with help of human validation (for example, where the user sends any errors back to Claude), were nearly twice as common on Claude Code (35.8% of interactions) as Claude.ai (21.3%). “Directive” conversations, where Claude completed a task with minimal user interaction, were also higher on Claude Code (43.8%, versus 27.5% on Claude.ai). All the patterns of augmentation—including “Learning,” where the user acquires knowledge from the AI model—were substantially lower on Claude Code than on Claude.ai.  
我们还进一步将自动化与增强细分为若干子类型（详见我们此前的[相关研究](https://www.anthropic.com/news/the-anthropic-economic-index)）。其中，“反馈闭环”（Feedback Loop）模式——即 Claude 自主完成任务，但依赖人类验证（例如用户将报错信息重新发送给 Claude）——在 Claude Code 上的发生率（35.8% 的交互）几乎是 Claude.ai（21.3%）的两倍。“指令式”（Directive）对话——即 Claude 在极少用户干预下即完成任务——在 Claude Code 上同样更常见（43.8%，而 Claude.ai 为 27.5%）。所有增强类模式（包括“学习型”（Learning），即用户从 AI 模型中获取知识）在 Claude Code 上的发生率均远低于 Claude.ai。

![Stacked bar chart showing the percentage of automation and augmentation on Claude.ai and Claude Code.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0bd4b66d347cd7c956f54fafa9793368e63b2ed0-4000x2250.jpg&w=3840&q=75)  
![堆叠柱状图：Claude.ai 与 Claude Code 上自动化与增强的占比。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F0bd4b66d347cd7c956f54fafa9793368e63b2ed0-4000x2250.jpg&w=3840&q=75)

Subtypes are defined as follows. Directive: Complete task delegation with minimal interaction; Feedback Loop: Task completion guided by environmental feedback; Task Iteration: Collaborative refinement process; Learning: Knowledge acquisition and understanding; Validation: Work verification and improvement.  
各子类型的定义如下：  
指令式（Directive）：任务全权委托，用户交互极少；  
反馈闭环（Feedback Loop）：任务完成过程受环境反馈引导；  
任务迭代（Task Iteration）：人机协同优化与完善任务；  
学习型（Learning）：知识获取与理解；  
验证型（Validation）：工作成果的校验与改进。

These results illustrate the differences between specialist, coding-focused agents (in this case, Claude Code) and the more “standard” way that users interact with large language models (i.e., through a chatbot interface like Claude.ai). As more agentic products are released, we might see differences in the way AI is integrated into people’s jobs. At least in the case of coding, this might involve more automation of tasks.  
这些结果凸显了专业型、聚焦编程的智能体（本例中为 Claude Code）与用户同大语言模型更“常规”的交互方式（即通过类似 Claude.ai 的聊天机器人界面）之间的差异。随着更多具备自主行为能力（agentic）的产品陆续发布，AI 融入人们工作的方式或将呈现新的分化趋势。至少在编程领域，这种变化可能体现为任务自动化程度的进一步提升。

This raises questions about the extent to which developers will still be involved as AI use becomes more common. Importantly, our results do show that even within automation, humans are still very often involved: “Feedback Loop” interactions still require user input (even if that input is simply pasting error messages back to Claude). But it’s by no means certain that this pattern will persist into the future, when more capable agentic systems will likely require progressively less user input.  
这也引发了一个关键问题：随着 AI 应用日益普及，开发者在开发流程中的参与程度将如何变化？值得强调的是，我们的数据表明，即便在自动化场景中，人类仍频繁参与其中：“反馈闭环”类交互依然需要用户输入（哪怕只是将错误信息粘贴回 Claude）。然而，这一模式能否持续尚无定论——未来更强大的自主型系统很可能对用户输入的依赖程度持续降低。

### What are developers building with Claude?  
### 开发者正用 Claude 构建什么？

Overall, we found that developers commonly use Claude for building user interfaces and interactive elements for websites and mobile applications. Although no single language dominated, the primarily web-focused development languages of JavaScript and TypeScript together accounted for 31% of all queries, and HTML and CSS (other languages for user-facing code) together added another 28%.  
总体来看，开发者普遍使用 Claude 构建网站与移动应用的用户界面及交互功能。尽管并无单一编程语言占据绝对主导地位，但以 Web 开发为核心的 JavaScript 与 TypeScript 合计占全部查询量的 31%；而面向用户界面的其他语言 HTML 与 CSS 则合计贡献了另外 28%。

![Line graph showing top coding use cases used in Claude.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F26b926ce7a1cff3c6d3f9fe63e6cf2417b945ce8-4001x2251.jpg&w=3840&q=75)Percentages represent total percentages of coding-related tasks across both platforms. Because Claude Code and Claude.ai are equally weighted, the portions of the bars that correspond to each of the platforms represent half of that platform's usage.  
![折线图：Claude 中最常用的编程应用场景。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F26b926ce7a1cff3c6d3f9fe63e6cf2417b945ce8-4001x2251.jpg&w=3840&q=75)图中百分比代表跨两个平台（Claude Code 与 Claude.ai）的所有编程相关任务的总占比。由于两个平台权重相等，每根柱状图中对应各平台的部分，代表该平台使用量的一半。

Back-end development languages (used for behind-the-scenes logic, databases, and infrastructure, as well as API and AI development) were also represented: notably, Python was at 14% of queries. However, Python serves dual purposes—both for back-end development and data analysis. Combined with SQL (another data-focused language, making up 6% of queries), these languages likely included many data science and analytics applications beyond traditional back-end development.  
后端开发语言（用于实现后台逻辑、数据库、基础设施，以及 API 和 AI 开发）亦有相当体现：其中 Python 占查询总量的 14%。但需注意，Python 兼具后端开发与数据分析双重用途；若将其与另一门以数据为中心的语言 SQL（占查询量的 6%）合并计算，则这两类语言所涵盖的应用场景，很可能远超传统后端开发范畴，广泛延伸至数据科学与分析领域。

![Line graph showing top programming languages used in Claude.](images/anthropic-economic-index-ai_s-impact-on-software-development/img_004.jpg)Percentages of coding language uses represent total percentages across both platforms. Because Claude Code and Claude.ai are equally weighted, the portions of the bars that correspond to each of the platforms represent half of that platform's usage.  
![折线图：Claude 中最常用的编程语言。](images/anthropic-economic-index-ai_s-impact-on-software-development/img_004.jpg)图中各编程语言使用占比代表跨两个平台（Claude Code 与 Claude.ai）的总占比。由于两个平台权重相等，每根柱状图中对应各平台的部分，代表该平台使用量的一半。

These patterns further extend to the types of common coding tasks involving Claude.  
这些模式进一步延伸至涉及 Claude 的常见编码任务类型。

Two of the top five tasks were focused on user-facing app development: “UI/UX Component Development” and “Web & Mobile App Development” each accounted for 12% and 8% of conversations, respectively.  
在排名前五的任务中，有两项聚焦于面向用户的 App 开发：“UI/UX 组件开发”和“Web 与移动应用开发”，分别占全部对话的 12% 和 8%。

Such tasks increasingly lend themselves to a phenomenon known as “vibe coding”—where developers of varying levels of experience describe their desired outcomes in natural language and let AI take the wheel on implementation details.  
此类任务正日益契合一种被称为“氛围式编程（vibe coding）”的现象——即不同经验水平的开发者以自然语言描述其期望结果，而将具体实现细节交由 AI 全权处理。

Conversations that related to more generic uses, such as “Software Architecture & Code Design” and “Debug and Performance Optimization” were also highly represented in both Claude.ai and Claude Code.  
与更通用用途相关的对话，例如“软件架构与代码设计”及“调试与性能优化”，在 Claude.ai 和 Claude Code 上同样占据显著比例。

Speculatively, these findings suggest that jobs that center on making simple applications and user interfaces might face earlier disruption from AI systems if increasing capabilities cause “vibe coding” to shift more into mainstream workflows.  
推测而言，若 AI 能力持续增强，推动“氛围式编程”进一步融入主流开发流程，则专注于开发简易应用程序和用户界面的相关岗位，或将更早受到 AI 系统的冲击。

As AI increasingly handles component creation and styling tasks, these developers might shift toward higher-level design and user experience work.  
随着 AI 日益承担组件构建与样式设计等任务，这类开发者或将转向更高层级的设计与用户体验工作。

### Who is using Claude for coding?

### 谁在使用 Claude 进行编程？

We also analyzed which groups of developers might be using Claude. We used our analysis system to identify the type of project (e.g. a personal project vs. a project done for a startup) that best described users’ coding-related interactions. Because we don’t know the real-world context in which Claude’s responses were being used, these analyses rely on uncertain inferences from incomplete data. We therefore treat these findings as more preliminary than the ones described above.  
我们还分析了哪些类型的开发者可能正在使用 Claude。我们借助分析系统，识别出最能描述用户编程相关交互的项目类型（例如：个人项目 vs. 为初创公司开展的项目）。由于我们无法获知 Claude 回复在现实场景中的具体使用背景，这些分析依赖于基于不完整数据所作的不确定性推断。因此，我们将这些发现视为比前述结论更具初步性。

![Graph showing types of projects in Claude.ai and Claude Code, with a list of different projects and the percentage of times they appeared in our dataset.](images/anthropic-economic-index-ai_s-impact-on-software-development/img_005.jpg)  
![图表显示 Claude.ai 和 Claude Code 中各类项目的分布情况，列出不同项目类型及其在数据集中的出现百分比。](images/anthropic-economic-index-ai_s-impact-on-software-development/img_005.jpg)

The distance between the dots indicates the gap in the prevalence of each type of project on Claude.ai (blue) and Claude Code (orange).  
各数据点之间的距离，表示同一类项目在 Claude.ai（蓝色）与 Claude Code（橙色）上流行程度的差异。

Startups appear to be the primary early adopters of Claude Code, and enterprise adoption lags behind. Startup work accounted for 32.9% of Claude Code conversations (nearly 20% higher than their Claude.ai usage), whereas enterprise work represented only 23.8% of Claude Code conversations (slightly below their 25.9% share on Claude.ai³).  
初创公司似乎是 Claude Code 的主要早期采用者，而企业级采用则相对滞后。初创公司相关工作占 Claude Code 对话总量的 32.9%（较其在 Claude.ai 上的使用占比高出近 20%）；而企业相关工作仅占 Claude Code 对话的 23.8%（略低于其在 Claude.ai 上 25.9% 的占比³）。

In addition, uses involving students, academics, personal project builders, and tutorial/learning users collectively represent half of the interactions across both platforms. In other words, individuals—not just businesses—are significant adopters of coding assistance tools.  
此外，学生、学术研究者、个人项目开发者以及教程/学习类用户的相关使用行为，在两个平台上的交互总量中合计占比达 50%。换言之，个体用户——而不仅限于企业——同样是编程辅助工具的重要采用者。

These adoption patterns mirror past technology shifts, where startups use new tools for competitive advantage while established organizations move more cautiously and often have detailed security checks in place before adopting new tools company-wide.  
此类采用模式与过往的技术变革趋势一致：初创公司倾向于采用新工具以获取竞争优势；而成熟组织则行动更为审慎，通常需在全公司范围内部署新工具前完成详尽的安全审查。

AI's general-purpose nature could accelerate this dynamic: If AI agents provide significant productivity gains, the gap between early and late adopters could translate into substantial competitive advantages.  
AI 的通用性可能进一步加速这一动态：倘若 AI 智能体能带来显著的生产力提升，则早期采用者与后期采用者之间的差距，或将转化为实质性的竞争优势。

### Limitations  

### 局限性

Our analysis is grounded in real-world AI use—how developers are actually using Claude in their workflows. Although this approach gives our findings practical relevance, it also brings inherent limitations. These include:

我们的分析基于真实世界中的 AI 应用——即开发者在实际工作流中如何真正使用 Claude。尽管这种方法赋予了我们研究发现切实的实践意义，但也带来了固有的局限性。这些局限性包括：

- We analyzed data from Claude.ai and Claude Code only. We excluded Team, Enterprise, and API usage that might show different patterns, particularly in professional settings;

- 我们仅分析了来自 Claude.ai 和 Claude Code 的数据；排除了可能呈现不同使用模式的 Team、Enterprise 及 API 使用场景，尤其是在专业工作环境中；

- The boundary between automation and augmentation becomes increasingly blurred with agentic tools like Claude Code. For example, the “Feedback Loop” pattern differs qualitatively from traditional automation, because it still requires user supervision and input. We will likely need to extend the automation/augmentation framework to account for new agentic capabilities;

- 随着 Claude Code 等具备自主代理（agentic）能力的工具出现，自动化（automation）与增强（augmentation）之间的界限正日益模糊。例如，“反馈循环”（Feedback Loop）模式在本质上不同于传统自动化，因为它仍需用户监督与主动输入。我们很可能需要拓展现有的“自动化/增强”分析框架，以纳入新型代理能力；

- Our categorization of who is using Claude for coding relied on inference from limited context. When categorizing conversations as “startup” versus “enterprise” work, or “personal” versus “academic” projects, our analysis tool made educated guesses based on incomplete information. Some classifications might therefore be incorrect. Additionally, we included an option for ‘Could Not Classify’, which Claude opted for in 5% of Claude.ai conversations and 2% of Claude Code conversations. We excluded this category from analysis and renormalized the results;

- 我们对“谁在使用 Claude 进行编程”的归类，依赖于有限上下文信息所作的推断。例如，在将对话归类为“初创公司”还是“企业级”工作，或“个人项目”还是“学术项目”时，我们的分析工具基于不完整的信息进行了合理推测，部分归类结果因此可能存在误差。此外，我们还设置了“无法归类”（Could Not Classify）选项；Claude 在 5% 的 Claude.ai 对话和 2% 的 Claude Code 对话中选择了该选项。我们在分析中排除了这一类别，并对剩余结果进行了重新归一化处理；

- Our dataset likely captures early adopters. These users might not represent the broader developer population, and this self-selection could skew usage patterns towards more experienced or technically adventurous users;

- 我们的数据库很可能主要覆盖早期采用者。这类用户未必能代表更广泛的开发者群体，而这种自我选择效应可能导致使用模式偏向经验更丰富或技术探索意愿更强的用户；

- Due to privacy considerations, we only analyzed data within a specific retention window, potentially missing cyclical patterns in software development (such as sprint cycles or release schedules);

- 出于隐私保护考量，我们仅分析了特定数据保留时间窗口内的数据，因而可能遗漏软件开发中固有的周期性规律（例如迭代冲刺周期或产品发布节奏）；

- The representativeness of Claude usage is unclear, relative to overall AI coding assistance adoption. Many developers use multiple AI tools beyond Claude, meaning we present only a partial view of their AI engagement patterns;

- 相较于整个 AI 编程辅助工具的采用情况，Claude 的使用是否具有代表性尚不明确。许多开发者除 Claude 外还同时使用多种 AI 工具，这意味着我们所呈现的仅是其 AI 参与模式的部分图景；

- We only studied what developers delegate to AI—not how they ultimately use AI outputs in their codebase, the quality of the resulting code, or whether these interactions effectively improved productivity or code quality.

- 我们仅研究了开发者委托给 AI 的任务内容，而未考察他们最终如何将 AI 输出整合进自身代码库、生成代码的质量如何，亦未评估这些人机交互是否切实提升了开发效率或代码质量。

### Looking ahead

### 展望未来

AI is fundamentally changing the ways developers work. Our analysis implies that this is particularly true where specialist agentic systems like Claude Code are used, is particularly strong for user-facing app development work, and might be giving particular advantages to startups as opposed to more established business enterprises.

AI 正在从根本上重塑开发者的工作方式。我们的分析表明，这种变革在专用型代理系统（如 Claude Code）的应用场景中尤为显著；在面向用户的 App 开发工作中表现尤为突出；并且可能使初创公司相较成熟企业获得独特优势。

Our findings raise many questions. Will the prevalence of “feedback loops,” where humans are still involved in the process, persist as AI capabilities advance, or will we see a shift toward more complete automation? As AI systems become capable of building larger-scale pieces of software, will developers shift to mostly managing and guiding these systems, rather than writing code themselves? Which software development roles will change the most, and which might disappear entirely?

我们的发现引出诸多关键问题：随着 AI 能力持续提升，“人类仍深度参与其中”的反馈循环模式会持续存在，还是会转向更彻底的自动化？当 AI 系统具备构建更大规模软件的能力后，开发者是否会从亲自编写代码，转向以管理与引导 AI 系统为主？哪些软件开发岗位将发生最剧烈的转变？又有哪些岗位可能彻底消失？

The increasing coding skills of AI might also be especially consequential for AI development itself. Since so much of AI research and development relies on software, it’s possible that advancements in AI-assisted coding help to speed up breakthroughs, creating a positively-reinforcing cycle that accelerates AI progress even further.

AI 日益精进的编程能力，对 AI 自身的发展也可能产生尤为深远的影响。鉴于大量 AI 研究与开发工作高度依赖软件实现，AI 辅助编程能力的进步，或将加速关键技术突破，从而形成一个正向强化的循环，进一步推动 AI 整体发展进程。

In the grand scheme of things, AI systems are extremely new. But in a relative sense, coding is among the most developed uses of AI in the economy. That makes it worth watching. Although we can’t assume that the lessons we draw from software development will directly carry over to other types of occupation, software development might be a leading indicator that gives us useful information about how other occupations might change with the rollout of increasingly capable AI models in the future.

宏观而言，AI 系统仍处于非常早期的发展阶段；但相对而言，编程已是当前经济体系中 AI 应用最为成熟的领域之一。这使其成为极具观察价值的前沿窗口。尽管我们不能简单假设从软件开发中总结的经验可直接套用于其他职业类型，但软件开发很可能是重要的先行指标（leading indicator），为我们理解未来更强大 AI 模型逐步落地过程中，其他职业将如何演变提供宝贵线索。

### Work With Us

### 加入我们

If you’re interested in working at Anthropic to research the effects of AI on the labor market, we encourage you to apply for our [Economist](https://job-boards.greenhouse.io/anthropic/jobs/4555010008) and [Data Scientist (Policy)](https://job-boards.greenhouse.io/anthropic/jobs/4502440008) roles.

如果您有兴趣加入 Anthropic，开展 AI 对劳动力市场影响的相关研究，我们诚挚邀请您申请我们的[经济学家（Economist）](https://job-boards.greenhouse.io/anthropic/jobs/4555010008)与[数据科学家（政策方向）（Data Scientist (Policy)）](https://job-boards.greenhouse.io/anthropic/jobs/4502440008)职位。

## Appendix

## 附录

As a supplementary analysis, we also compared our results for software-related automation and augmentation patterns to patterns in interactions that did not involve software.  
作为补充性分析，我们还将软件相关自动化与增强模式的结果，与不涉及软件的交互模式进行了对比。

We conducted this analysis exclusively in Claude.ai, because Claude Code specializes in software applications.  
本分析仅在 Claude.ai 中开展，因为 Claude Code 专精于软件应用领域。

![Table showing percentages of different patterns of AI use for software and non-software applications.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F3539fa9144a552602c77fb78b7f8ed025dfaa7cd-4001x2251.jpg&w=3840&q=75)  
![展示软件类与非软件类应用场景中各类 AI 使用模式占比的表格。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F3539fa9144a552602c77fb78b7f8ed025dfaa7cd-4001x2251.jpg&w=3840&q=75)

Breakdown of automation and augmentation by software versus non-software use cases in Claude.ai. For a description of each pattern, see the caption to the first figure above.  
Claude.ai 中软件类与非软件类应用场景下自动化与增强模式的细分情况。关于每种模式的说明，请参见上文第一张图的图注。

Compared to use cases that don’t involve software, software development is more automative.  
相较于不涉及软件的应用场景，软件开发具有更强的自动化倾向。

A significant increase in Feedback Loops (+18.3%) drives this and, notably, offsets a clear _decrease_ in Directive behaviors (-11.2%).  
这一趋势主要由反馈循环（Feedback Loops）的显著上升（+18.3%）所驱动；值得注意的是，该上升甚至抵消了指令型行为（Directive behaviors）的明显下降（−11.2%）。

In other words, AI-assisted coding currently requires a lot of human reviewing and iteration relative to non-coding tasks, even when Claude does the bulk of the work.  
换言之，即便 Claude 承担了大部分编码工作，当前 AI 辅助编程仍比非编程任务更依赖人工审阅与反复迭代。
{% endraw %}
