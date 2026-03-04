---
render_with_liquid: false
title: "Transforming Mortgage Ops with LangChain & LangSmith"
source: "LangChain Blog"
url: "https://blog.langchain.com/transforming-mortgage-ops-with-langchain-langsmith/"
date: "2023-12-06"
scraped_at: "2026-03-03T08:21:21.550442361+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

_Editor's Note: This post was written by_ [_Sasha Aptlin_](mailto:sasha@aptford.com) _at_ [_Aptford_](https://aptford.com/?ref=blog.langchain.com) _through LangChain's Partner Program._

_编辑注：本文由_ [_萨沙·阿普特林（Sasha Aptlin）_](mailto:sasha@aptford.com) _撰写，作者来自_ [_Aptford_](https://aptford.com/?ref=blog.langchain.com)，_系 LangChain 合作伙伴计划成员。_

Meet Maya, a loan officer at [InstaMortgage](https://instamortgage.com/?ref=blog.langchain.com), whose professional life was once consumed by the flood of loan applications and constant demands for accuracy and precision. Imagine her desk, buried under piles of paperwork, her inbox constantly filled with client requests, her days a never-ending cycle of entering data manually and conducting thorough reviews.

让我们认识玛雅（Maya）——一位就职于 [InstaMortgage](https://instamortgage.com/?ref=blog.langchain.com) 的贷款专员。她曾深陷于海量贷款申请的洪流之中，同时还要持续应对准确性与精确性的严苛要求。想象一下她的办公桌：堆满纸质文件；她的收件箱：不断涌入客户咨询；她的一天：在手动录入数据与反复细致审核之间永无止境地循环。

At InstaMortgage, Maya is not just a loan officer. She is a champion for customer service and education. Her objective is to make sure that the process of obtaining a home loan is transparent and straightforward. However, conventional methods frequently left her clients waiting for an answer for way too long, resulting in more confusion than empowerment.

在 InstaMortgage，玛雅不仅是一名贷款专员，更是客户服务与金融教育的倡导者。她的目标是确保购房贷款流程公开透明、简单明了。然而，传统方式常常让客户久等答复，非但未能赋能客户，反而加剧了他们的困惑。

Maya's experience was not unique. Loan officers throughout the mortgage industry encounter the same difficulties: outdated systems, manual procedures, and the need to juggle precision, accuracy, and client satisfaction. It was evident that the mortgage industry, which relied on traditional and error-prone methods, required a significant overhaul.

玛雅的经历并非个例。整个房贷行业中的贷款专员普遍面临相同挑战：系统陈旧、流程依赖人工操作，且需在精准性、准确性与客户满意度之间艰难平衡。显而易见，这个长期依赖传统、易出错方法的房贷行业，亟需一场深刻变革。

## Meet InstaAI

## 认识 InstaAI

Leading the transformation, [InstaMortgage](https://instamortgage.com/?ref=blog.langchain.com) joined forces with [Aptford](https://aptford.com/?ref=blog.langchain.com) to create InstaAI, an AI platform reshaping the mortgage landscape with three core modules powered by Langchain & LangSmith:

引领这场变革，[InstaMortgage](https://instamortgage.com/?ref=blog.langchain.com) 与 [Aptford](https://aptford.com/?ref=blog.langchain.com) 携手打造了 InstaAI —— 一个依托 LangChain 与 LangSmith 构建的 AI 平台，通过三大核心模块重塑房贷行业格局：

- **Mortgage AI** navigates through complex data and guidelines, offering immediate, accurate guidance. Think of a challenging loan application that gets deciphered in minutes, not hours – Mortgage AI makes it possible.

- **房贷 AI（Mortgage AI）**：穿透复杂的数据与监管规则，提供即时、精准的专业指导。试想一份棘手的贷款申请，过去需耗时数小时分析解读，如今只需几分钟即可完成——这正是房贷 AI 的能力所在。

![Mortgage AI](images/transforming-mortgage-ops-with-langchain-langsmith/img_001.jpg)

![房贷 AI（Mortgage AI）](images/transforming-mortgage-ops-with-langchain-langsmith/img_001.jpg)

- **Content AI** enables the creation of clear, concise multi-media content, ensuring that clients are well informed. It also helps Loan Officers build credibility and reputation through content creation that is relevant and educational for future homeowners. Imagine a client receiving tailor-made insights that make complex mortgage concepts easily digestible in the distinctive voice of InstaMortgage – that's ContentAI at work.

- **内容 AI（Content AI）**：支持生成清晰、简洁的多媒体内容，确保客户充分知情；同时助力贷款专员通过创作贴合未来房主需求、兼具专业性与教育意义的内容，树立个人公信力与品牌声誉。试想客户收到量身定制的洞察分析，以 InstaMortgage 独具特色的语言风格，将复杂的房贷概念轻松化解、通俗易懂——这正是内容 AI 在发挥作用。

![Content AI](images/transforming-mortgage-ops-with-langchain-langsmith/img_002.jpg)

![内容 AI（Content AI）](images/transforming-mortgage-ops-with-langchain-langsmith/img_002.jpg)

- **Policy AI** clarifies InstaMortgage policies, employment practices, benefits, compliance, and communication standards. An ever-present guide, it nurtures a positive, productive workplace environment where every team member can thrive.

- **政策 AI（Policy AI）** 澄清 InstaMortgage 的各项政策、雇佣实践、员工福利、合规要求及沟通标准。它如一位始终在侧的向导，持续营造积极、高效的工作环境，让每一位团队成员都能茁壮成长。

![Policy AI](images/transforming-mortgage-ops-with-langchain-langsmith/img_003.jpg)

![政策 AI（Policy AI）](images/transforming-mortgage-ops-with-langchain-langsmith/img_003.jpg)

With InstaAI, Maya's role underwent a radical change. Her job evolved from juggling tedious tasks to fostering meaningful relationships at scale. "InstaAI hasn't just changed how I work; it's redefined my role, supercharging my efforts of enriching the experience for our clients,” she remarks.

借助 InstaAI，玛雅（Maya）的岗位职责发生了根本性转变——从疲于应付琐碎事务，跃升为规模化地构建富有意义的客户关系。“InstaAI 不仅改变了我的工作方式，更重新定义了我的角色，极大增强了我为客户提升体验的能力。”她表示。

## InstaMagic of LangChain & LangSmith

## LangChain 与 LangSmith 的“InstaMagic”

LangChain's [LCEL](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) has been instrumental in developing InstaAI's three core modules, simplifying the construction of dynamic prompts across various data sources, most of which are more than 500 pages long and include tabular data. Under the hood, each user request is rephrased into a question by a separate chain, which is then used to pick the sources to pull from in parallel. The retrieved chunks, enriched with metadata about their source, are then injected into the context before the final run of the “Writer” chain.

LangChain 的 [LCEL（LangChain Expression Language）](https://python.langchain.com/docs/expression_language/?ref=blog.langchain.com) 在 InstaAI 三大核心模块的开发中发挥了关键作用，显著简化了跨多种数据源构建动态提示词（dynamic prompts）的过程——这些数据源大多长达 500 多页，且包含大量表格数据。在底层实现中，每个用户请求均由一条独立链路重新表述为问题，再据此并行选取需检索的数据源；检索所得文本片段（chunks）均附带其来源元数据，随后被注入上下文，最终交由“写作链”（Writer chain）完成最终生成。

![](images/transforming-mortgage-ops-with-langchain-langsmith/img_004.png)

![](images/transforming-mortgage-ops-with-langchain-langsmith/img_004.png)

To generate content ideas, InstaAI follows a straightforward multi-step process. Here's how it works:

InstaAI 采用清晰直观的多步骤流程来生成内容创意。具体如下：

1. Randomly select blog posts from the InstaMortgage sitemap.  
   1. 从 InstaMortgage 网站地图中随机选取博客文章。

2. Analyze the selected blog posts using an LLM to identify any missing points or generate related ideas.  
   2. 利用大语言模型（LLM）分析所选博客文章，识别内容盲点或生成相关创意。

3. Create a rough draft based on one of the seven content types and context from the knowledge base.  
   3. 基于七种内容类型之一，并结合知识库中的上下文，生成初稿。

4. Refine the draft and extract important details such as summary, hashtags, duration (for video scripts), or call-to-action (CTA) into a Pydantic model for future user review.  
   4. 对初稿进行润色，并将摘要、话题标签（hashtags）、时长（适用于视频脚本）或行动号召（CTA）等关键信息提取至 Pydantic 模型中，供后续人工审核。

LCEL has simplified the developer experience to a couple of lines of Python for each of the steps above.

LCEL 将上述每一步的开发体验大幅简化——仅需数行 Python 代码即可实现。

LangSmith had an important role in debugging and logging throughout the development process, as well as monitoring performance in production. Its debugging capabilities enabled precise monitoring and improvement of interactions within each module. By visualizing the exact sequence of events in complex chains that retrieve context from various sources, LangSmith provided insights into the inputs and outputs of LLM calls and ensured that the conversational aspects of MortgageAI, ContentAI, and PolicyAI were logical, precise, and user-friendly.

LangSmith 在整个开发周期中承担了至关重要的调试与日志记录任务，并在生产环境中持续监控系统性能。其强大的调试能力，使开发者得以精准追踪并优化各模块内部的交互逻辑。通过可视化呈现那些从多个异构数据源检索上下文的复杂链路中事件发生的精确顺序，LangSmith 深度揭示了大语言模型（LLM）调用的输入与输出，从而确保 MortgageAI、ContentAI 和 PolicyAI 的对话功能具备逻辑性、准确性与良好的用户体验。

## Results

## 成果

Mortgage questions that used to take hours to research can now be completed in minutes or even seconds. InstaAI has not only improved efficiency but also strengthened client relationships. Early results show that speed to resolution has increased by an average of 67%, and error rates have significantly decreased. The impact on client satisfaction is clear, with testimonials like Rupert's, a long-term client who said, "The speed and accuracy in handling my request were unlike anything I've experienced before." This transformation also benefits our employees, as Shashank Shekhar, CEO of InstaMortgage, explains: "With our newfound capabilities, our team can focus on more challenging and fulfilling tasks, thus making their work at InstaMortgage less tedious and way more rewarding.” He further added that the company intends to continue working with LangChain to further its AI capabilities and become a truly AI-powered mortgage company that delivers the best experience for both its employees and clients.

过去需要数小时研究的房贷问题，如今几分钟甚至几秒钟即可完成。InstaAI 不仅提升了工作效率，也进一步巩固了客户关系。初步结果显示，问题解决速度平均提升了 67%，错误率也显著下降。客户满意度的提升显而易见——长期客户鲁珀特（Rupert）评价道：“处理我请求的速度与准确性，是我此前从未体验过的。”这一变革同样惠及员工。InstaMortgage 首席执行官沙山克·谢卡尔（Shashank Shekhar）表示：“依托我们新获得的能力，团队得以专注于更具挑战性、更富成就感的工作，从而让在 InstaMortgage 的工作不再枯燥，而是变得更有价值。”他还补充道，公司计划持续与 LangChain 合作，进一步增强其 AI 能力，致力于成为一家真正由 AI 驱动的房贷企业，为员工与客户双方都提供最佳体验。