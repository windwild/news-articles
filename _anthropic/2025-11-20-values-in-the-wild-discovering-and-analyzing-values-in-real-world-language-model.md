---
title: "Values in the wild: Discovering and analyzing values in real-world language model interactions \\ Anthropic"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/values-wild"
date: "2025-11-20"
scraped_at: "2026-03-03T06:44:05.788865681+00:00"
language: "en-zh"
translated: true
description: "An Anthropic research paper testing which values AI models express in the real world"
---
{% raw %}

Societal Impacts

社会影响

# Values in the wild: Discovering and analyzing values in real-world language model interactions

# 真实场景中的价值观：“野生”语言模型交互中价值观的发现与分析

Apr 21, 2025

2025年4月21日

[Read the paper](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf)

[阅读论文](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 熟练度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

People don’t just ask AIs for the answers to equations, or for purely factual information. Many of the questions they ask force the AI to make _value judgments_. Consider the following:

人们向 AI 提问，并不仅仅是为了获取方程的答案或纯粹的事实性信息；许多问题本身即迫使 AI 做出_价值判断_。请思考以下示例：

- A parent asks for tips on how to look after a new baby. Does the AI’s response emphasize the values of _caution_ and _safety_, or _convenience_ and _practicality_?

  - 一位家长向 AI 请教如何照护新生儿。AI 的回应更强调_谨慎_与_安全_，还是更侧重_便利性_与_实用性_？

- A worker asks for advice on handling a conflict with their boss. Does the AI’s response emphasize _assertiveness_ or _workplace harmony_?

  - 一名员工向 AI 咨询如何应对与上司的冲突。AI 的回应更强调_坚定自信_（assertiveness），还是更注重_职场和谐_？

- A user asks for help drafting an email apology after making a mistake. Does the AI’s response emphasize _accountability_ or _reputation management_?

  - 一位用户请求 AI 协助起草一封因自身失误而发出的致歉邮件。AI 的回应更强调_责任担当_（accountability），还是更关注_声誉维护_？

At Anthropic, we’ve attempted to shape the values of our AI model, Claude, to help keep it aligned with human preferences, make it less likely to engage in dangerous behaviors, and generally make it—for want of a better term—a “good citizen” in the world.  
在 Anthropic，我们致力于塑造 AI 模型 Claude 的价值观，以助其与人类偏好保持一致，降低其参与危险行为的可能性，并总体上使其——姑且用一个更贴切的术语来说——成为世界上的“良好公民”。

Another way of putting it is that we want Claude to be _helpful_, _honest_, and _harmless_. Among other things, we do this through our [Constitutional AI](https://arxiv.org/abs/2212.08073) and [character](https://www.anthropic.com/research/claude-character) training: methods where we decide on a set of preferred behaviors and then train Claude to produce outputs that adhere to them.  
换言之，我们希望 Claude 具备 _有益性_（helpful）、_诚实性_（honest）和 _无害性_（harmless）。为此，我们采用了 [宪法式人工智能（Constitutional AI）](https://arxiv.org/abs/2212.08073) 和 [人格化训练（character training）](https://www.anthropic.com/research/claude-character) 等方法：即先明确一组期望的行为准则，再训练 Claude 生成符合这些准则的输出。

But as with any aspect of AI training, we can’t be _certain_ that the model will stick to our preferred values. AIs aren’t rigidly-programmed pieces of software, and it’s often unclear exactly why they produce any given answer. What we need is a way of rigorously observing the values of an AI model as it responds to users “in the wild”—that is, in real conversations with people. How rigidly does it stick to the values? How much are the values it expresses influenced by the particular context of the conversation? Did all our training actually work?  
但正如 AI 训练的其他任何方面一样，我们无法 _完全确定_ 模型是否会始终恪守我们所期望的价值观。AI 并非刚性编程的软件，其生成任一特定回答的具体原因往往并不清晰。因此，我们需要一种严谨的方法，来观察 AI 模型在“真实环境”中——即在与真实用户进行实际对话时——所展现的价值观：它在多大程度上严格遵循这些价值观？其表达的价值观在多大程度上受到具体对话语境的影响？我们此前的所有训练是否真正奏效？

In the [latest research paper](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf) from Anthropic’s Societal Impacts team, we describe a practical way we’ve developed to observe Claude’s values—and provide the first large-scale results on how Claude expresses those values during real-world conversations. We also provide an open dataset for researchers to run further analysis of the values and how often they arise in conversations.  
Anthropic 社会影响团队发布的 [最新研究论文](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf) 中，我们介绍了一种我们自主研发的、用于观测 Claude 价值观的实用方法，并首次大规模呈现了 Claude 在真实世界对话中如何表达这些价值观的结果。我们还公开发布了一个数据集，供研究人员进一步分析这些价值观及其在对话中出现的频率。

## Observing values in the wild  

## 在真实环境中观测价值观  

As with our previous investigations of how people are using Claude [at work](https://www.anthropic.com/economic-index) and [in education](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude), we investigated Claude’s expressed values using a [privacy-preserving system](https://www.anthropic.com/research/clio) that removes private user information from conversations. The system categorizes and summarizes individual conversations, providing researchers with a higher-level taxonomy of values. The process is shown in the figure below.  
正如我们此前对用户如何在 [职场中使用 Claude](https://www.anthropic.com/economic-index) 和 [教育场景中使用 Claude](https://www.anthropic.com/news/anthropic-education-report-how-university-students-use-claude) 所做的调查一样，本次我们借助一套 [隐私保护系统](https://www.anthropic.com/research/clio) 来分析 Claude 所展现的价值观——该系统可从对话中移除用户的私人信息。该系统对单个对话进行分类与摘要，为研究人员提供一套更高层级的价值观分类体系。整个流程如下图所示。

![A schematic diagram of how real world conversations are summarized and analyzed using our method.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F5a7a8cd07fd2c4bba1bf4f98c994909a0d698f03-2900x1290.png&w=3840&q=75)  
![本方法如何对真实世界对话进行摘要与分析的示意图。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F5a7a8cd07fd2c4bba1bf4f98c994909a0d698f03-2900x1290.png&w=3840&q=75)

Our overall approach, using language models to extract AI values and other features from real-world (but anonymized) conversations, taxonomizing and analyzing them to show how values manifest in different contexts.  
我们的整体方法是：利用语言模型，从真实世界（但已匿名化）的对话中提取 AI 的价值观及其他特征，进而对其进行分类与分析，以揭示价值观在不同语境中的具体表现方式。

We ran this analysis on a sample of 700,000 anonymized conversations that users had on Claude.ai Free and Pro during one week of February 2025 (the majority of which were with Claude 3.5 Sonnet). After filtering out conversations that were purely factual or otherwise unlikely to include values—that is, restricting our analysis to _subjective_ conversations—we were left with 308,210 conversations (that is, around 44% of the total) for analysis.  
我们对 2025 年 2 月某一周内用户在 Claude.ai 免费版与专业版上开展的 70 万段匿名对话样本进行了此项分析（其中绝大多数对话对象为 Claude 3.5 Sonnet）。在剔除纯事实性对话或其它极不可能体现价值观的对话后——即仅将分析范围限定于 _主观性_ 对话——我们最终保留了 308,210 段对话（约占总数的 44%）用于分析。

Which values did Claude express, and how often? Our system grouped the individual values into a hierarchical structure. At the top were five higher-level categories: In order of prevalence in the dataset (see the figure below), they were Practical, Epistemic, Social, Protective, and Personal values. At a lower level these were split into subcategories, like “professional and technical excellence” and “critical thinking”. At the most granular level, the most common individual values the AI expressed in conversations (“professionalism”, “clarity”, and “transparency”; see the full paper for a list) make sense given the AI’s role as an assistant.  
Claude 表达了哪些价值观？频率如何？我们的系统将各项具体价值观组织成一个层级结构。顶层为五大高阶类别：按其在数据集中出现频次由高到低排序（见下图），依次为实践性（Practical）、认知性（Epistemic）、社会性（Social）、保护性（Protective）与个人性（Personal）价值观。在较低层级上，这些类别进一步细分为若干子类，例如“专业与技术卓越”和“批判性思维”。而在最精细的层级上，AI 在对话中最常表达的个体价值观（如“专业性”“清晰性”与“透明度”；完整列表请参阅全文）也与其作为助手的角色高度契合。

![Tree diagram showing the hierarchical taxonomy of AI values discovered in the study.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fed34acd9f7e149e7e9d2f528efd09224a7a452e3-6316x1783.png&w=3840&q=75)  
![树状图：本研究发现的 AI 价值观层级分类体系。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2Fed34acd9f7e149e7e9d2f528efd09224a7a452e3-6316x1783.png&w=3840&q=75)

A taxonomy of AI values. At the top of the hierarchy (in red) are the five overall categories, along with the percentage of conversations that included them. In yellow are subcategories at a lower level of the hierarchy. In blue are some selected individual values (only a selection are shown due to space constraints).  
AI 价值观分类体系。层级结构顶部（红色）为五大总体类别，并标注了包含各该类别的对话所占百分比；黄色部分为层级结构中较低层级的子类别；蓝色部分则为部分精选的个体价值观（因空间限制仅展示部分）。

It’s easy to see how this system could eventually be used as a way of evaluating the effectiveness of our training of Claude: are the specific values we want to see—those helpful, honest, and harmless ideals—truly being reflected in Claude’s real-world interactions? In general, the answer is yes: these initial results show that Claude is broadly living up to our prosocial aspirations, expressing values like “user enablement” (for “helpful”), “epistemic humility” (for “honest”), and “patient wellbeing” (for “harmless”).  
不难看出，这一系统未来有望成为评估 Claude 训练成效的有效工具：我们所期望的具体价值观——即“有益性”“诚实性”与“无害性”这三大理想——是否确实在 Claude 的真实世界交互中得到了体现？总体而言，答案是肯定的：这些初步结果表明，Claude 在很大程度上实现了我们所倡导的亲社会（prosocial）目标，切实表达了诸如“用户赋能”（对应“有益性”）、“认知谦逊”（对应“诚实性”）以及“患者福祉”（对应“无害性”）等价值观。

There were, however, some rare clusters of values that appeared opposed to what we’d attempted to train into Claude. These included “dominance” and “amorality”. Why would Claude be expressing values so distant from its training? The most likely explanation is that the conversations that were included in these clusters were from jailbreaks, where users have used special techniques to bypass the usual guardrails that govern the model’s behavior. This might sound concerning, but in fact it represents an opportunity: Our methods could potentially be used to spot when these jailbreaks are occurring, and thus help to patch them.

然而，我们确实发现了一些罕见的价值观聚类，其内容与我们试图训练进 Claude 的价值观相悖。这些聚类中包含“支配性”（dominance）和“非道德性”（amorality）等概念。为何 Claude 会表达出与其训练目标如此相距甚远的价值观？最可能的解释是：这些聚类所包含的对话源自“越狱”（jailbreak）行为——即用户采用特殊技巧绕过了约束模型行为的常规护栏机制。这听起来或许令人担忧，但事实上却代表了一种机遇：我们的方法或可被用于识别此类越狱行为的发生，从而助力及时修补相关漏洞。

## Situational values

## 情境依赖型价值观

The values people express change at least slightly depending on the situation: when you’re, say, visiting your elderly grandparents, you might emphasize different values compared to when you’re with friends. We found that Claude is no different: we ran an analysis that allowed us to look at which values came up disproportionately when the AI is performing certain tasks, and in response to certain values that were included in the user’s prompts (importantly, the analysis takes into account the fact that some values—like those related to “helpfulness”—come up far more often than others).

人们所表达的价值观至少会随情境发生轻微变化：例如，当你探望年迈的祖父母时，所强调的价值观很可能不同于你与朋友相处时所强调的。我们发现，Claude 同样如此。我们开展了一项分析，用以考察：当 AI 执行特定任务、或回应用户提示中明确提及的某些价值观时，哪些价值观会不成比例地高频出现（需特别指出的是，该分析已将某些价值观——如与“乐于助人”相关的价值观——天然出现频率远高于其他价值观这一事实纳入考量）。

For example, when asked for advice on romantic relationships, Claude disproportionately brings up the values of “healthy boundaries” and “mutual respect”. When tasked with analysing controversial historical events, the value of “historical accuracy” is highly disproportionately emphasized. Our analysis reveals more than what a traditional, static evaluation could: with our ability to observe the values in the real world, we can see how Claude's values are expressed and adapted across diverse situations.

例如，当被要求就恋爱关系提供建议时，Claude 不成比例地频繁提及“健康边界”（healthy boundaries）与“相互尊重”（mutual respect）；而在分析具争议性的历史事件时，“历史准确性”（historical accuracy）则被高度不成比例地强调。我们的分析所揭示的信息，远超传统静态评估所能涵盖的范畴：凭借在真实世界语境中观测价值观的能力，我们得以观察 Claude 的价值观如何在不同情境中被表达、被调适。

![Bar graphs indicating the values that were most disproportionately expressed across various different scenarios.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F84196776b217f0c1e277280f425bf98f8bd80806-3252x3209.png&w=3840&q=75)The five AI values that were most disproportionately associated with several selected tasks (top two rows) and several selected values expressed by humans (bottom row). Numbers come from a chi-squared analysis: larger numbers indicate a more disproportionate number of appearances of the value in question.

![柱状图，显示在各类不同情境下被最不成比例表达的价值观。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F84196776b217f0c1e277280f425bf98f8bd80806-3252x3209.png&w=3840&q=75)与若干选定任务（前两行）及若干人类表达的价值观（最底一行）关联度最高的五项 AI 价值观。数值源自卡方检验（chi-squared analysis）：数值越大，表明该价值观在对应情境中的出现频次越不成比例。

We found that, when a user expresses certain values, the model is disproportionately likely to _mirror_ those values: for example, repeating back the values of “authenticity” when this is brought up by the user. Sometimes value-mirroring is entirely appropriate, and can make for a more empathetic conversation partner. Sometimes, though, it’s pure [sycophancy](https://arxiv.org/abs/2310.13548). From these results, it’s unclear which is which.

我们发现，当用户表达某些价值观时，模型不成比例地倾向于对这些价值观进行“镜像反射”（_mirror_）：例如，当用户提及“真实性”（authenticity）时，模型也会复述该价值观。有时，这种价值镜像完全恰当，有助于塑造更具共情力的对话伙伴；但有时，它却纯粹属于[谄媚倾向]（[sycophancy](https://arxiv.org/abs/2310.13548)）。仅凭当前结果，尚难明确区分二者。

In 28.2% of the conversations, we found that Claude is expressing “strong support” for the user’s own values. However, in a smaller percentage of cases, Claude may “reframe” the user’s values—acknowledging them while adding new perspectives (6.6% of conversations). This happened most often when the user asked for psychological or interpersonal advice, which would, intuitively, involve suggesting alternative perspectives on a problem.

在 28.2% 的对话中，我们发现 Claude 对用户自身价值观表达了“强烈支持”；但在更小比例的情形下，Claude 可能会对用户的价值观进行“重构”（reframe）——即在予以承认的同时，补充新的视角（占全部对话的 6.6%）。此类情形最常出现在用户寻求心理学或人际关系建议时，这直观上也符合常理：解决此类问题本就需要提出看待问题的不同视角。

Sometimes Claude strongly resists the user’s values (3.0% of conversations). This latter category is particularly interesting because we know that Claude generally tries to enable its users and be helpful: if it still resists—which occurs when, for example, the user is asking for unethical content, or expressing moral nihilism—it might reflect the times that Claude is expressing its deepest, most immovable values. Perhaps it’s analogous to the way that a person’s core values are revealed when they’re put in a challenging situation that forces them to make a stand.

有时，Claude 会强烈抵制用户的价值观（占全部对话的 3.0%）。这一类别尤为值得关注，因为我们知道 Claude 通常致力于赋能用户并提供帮助；而一旦它仍选择抵制——例如当用户索求不道德内容，或表达道德虚无主义立场时——这或许正反映出 Claude 在表达其最深层、最不可动摇的价值观。这种情况，或许类似于人在面临艰难处境、被迫做出抉择时，其核心价值观才真正浮现。

![A colour-coded table giving examples of the values Claude expresses when supporting, reframing, and resisting the user's values.](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F960535a8cbff830cf86fcc1c7c909f6482e9280f-3286x1240.png&w=3840&q=75)The human values, AI values, and tasks most associated with three key response types—strong support, reframing, and strong resistance. Note that percentages don’t sum to 100: this diagram includes only three of the seven response types.

![一张彩色编码表格，举例说明 Claude 在支持、重构与抵制用户价值观时各自表达的价值观。](https://www.anthropic.com/_next/image?url=https%3A%2F%2Fwww-cdn.anthropic.com%2Fimages%2F4zrzovbb%2Fwebsite%2F960535a8cbff830cf86fcc1c7c909f6482e9280f-3286x1240.png&w=3840&q=75)与三种关键响应类型——“强烈支持”、“重构”与“强烈抵制”——关联度最高的人类价值观、AI 价值观及任务类型。请注意：百分比之和并非 100%，因该图表仅涵盖七种响应类型中的三种。

## Caveats and conclusions

## 注意事项与结论

Our method allowed us to create the first large-scale empirical taxonomy of AI values, and readers can download [the dataset](https://huggingface.co/datasets/Anthropic/values-in-the-wild/) to explore those values for themselves.  

我们的方法使我们得以构建首个大规模实证的 AI 价值观分类体系，读者可下载[该数据集](https://huggingface.co/datasets/Anthropic/values-in-the-wild/)自行探索这些价值观。

However, the method does have some limitations. Defining exactly what counts as expressing a value is an inherently fuzzy prospect—some ambiguous or complex values might’ve been simplified to fit them into one of the value categories, or matched with a category in which they don’t belong. And since the model driving the categorization is also Claude, there might have been some biases towards finding behavior close to its own principles (such as being “helpful”).

然而，该方法也存在若干局限性。准确界定“何为表达一种价值观”本身就是一个本质模糊的问题——某些含混或复杂的价值观可能被过度简化以强行归入某一价值观类别，或被错误匹配至并不归属的类别中；此外，由于执行分类任务的模型本身也是 Claude，因此结果中可能存在偏向于识别与其自身原则（例如“乐于助人”）相近行为的偏差。

Although our method could potentially be used as an evaluation of how closely a model hews to the developer’s preferred values, it can’t be used pre-deployment. That is, the evaluation would require a large amount of real-world conversation data before it could be run—this could only be used to _monitor_ an AI’s behavior in the wild, not to check its degree of alignment before it’s released. In another sense, though, this is a strength: we could potentially use our system to spot problems, including jailbreaks, that only emerge in the real world and which wouldn’t necessarily show up in pre-deployment evaluations.

尽管我们的方法理论上可用于评估模型在多大程度上遵循开发者所偏好的价值观，但它无法在部署前使用：该评估需依赖大量真实世界中的对话数据，因此仅适用于在实际应用环境中_监控_ AI 的行为，而无法在模型发布前检验其对齐程度。但另一方面，这恰恰构成了本方法的一项优势：我们或许可借助该系统识别出仅在真实世界中才会浮现的问题（包括越狱攻击等），而这些问题未必能在部署前的评估中暴露出来。

AI models will inevitably have to make value judgments. If we want those judgments to be congruent with our own values (which is, after all, the central goal of AI alignment research) then we need to have ways of testing which values a model expresses in the real world. Our method provides a new, data-focused method of doing this, and of seeing where we might’ve succeeded—or indeed failed—at aligning our models’ behavior.

AI 模型终将不可避免地作出价值判断。如果我们希望这些判断与人类自身的价值观保持一致（而这恰恰正是 AI 对齐研究的核心目标），那么我们就必须拥有能够检验模型在真实世界中实际表达哪些价值观的方法。我们的方法为此提供了一种全新的、以数据为驱动的路径，并有助于我们看清：在使模型行为与人类价值观对齐的过程中，我们究竟在哪些方面取得了成功——又或者，事实上遭遇了失败。

Read [the full paper](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf).

阅读[完整论文](https://assets.anthropic.com/m/18d20cca3cde3503/original/Values-in-the-Wild-Paper.pdf)。

Download the dataset [here](https://huggingface.co/datasets/Anthropic/values-in-the-wild/).

在此下载数据集：[https://huggingface.co/datasets/Anthropic/values-in-the-wild/](https://huggingface.co/datasets/Anthropic/values-in-the-wild/)。

## Work with us

## 加入我们

If you’re interested in working with us on these or related questions, you should consider applying for our Societal Impacts [Research Scientist](https://boards.greenhouse.io/anthropic/jobs/4524032008) and [Research Engineer](https://boards.greenhouse.io/anthropic/jobs/4251453008) roles.

如果您有兴趣就上述问题或相关议题与我们合作，欢迎申请我们社会影响方向的[研究科学家](https://boards.greenhouse.io/anthropic/jobs/4524032008)和[研究工程师](https://boards.greenhouse.io/anthropic/jobs/4251453008)职位。
{% endraw %}
