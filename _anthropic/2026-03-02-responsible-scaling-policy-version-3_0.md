---
title: "Responsible Scaling Policy Version 3.0"
source: "Anthropic News"
url: "https://www.anthropic.com/news/responsible-scaling-policy-v3"
scraped_at: "2026-03-02T09:21:05.525159586+00:00"
language: "en-zh"
translated: true
description: "An update to Anthropic's policy to mitigate catastrophic risks from AI"
tags: ["Policy"]
---
{% raw %}

PolicyAnnouncements

# Anthropic’s Responsible Scaling Policy: Version 3.0

# Anthropic 负责任扩展政策：第 3.0 版

Feb 24, 2026

2026 年 2 月 24 日

[Read the Responsible Scaling Policy](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)

[阅读《负责任扩展政策》](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)

![Anthropic’s Responsible Scaling Policy: Version 3.0](images/responsible-scaling-policy-version-3_0/img_001.svg)

![Anthropic 负责任扩展政策：第 3.0 版](images/responsible-scaling-policy-version-3_0/img_001.svg)

#### Footnotes

#### 脚注

1\. As we discuss in the RSP, we will aim to minimize redactions to the public version of the Risk Report. Reasons we may nonetheless have to redact some of the text include legal compliance, intellectual property protection, public safety, and privacy.

1．正如我们在《负责任扩展政策》（RSP）中所讨论的，我们将力求最大限度减少对《风险报告》公开版本的删减。但出于法律合规、知识产权保护、公共安全及隐私保护等考虑，我们仍可能不得不对部分内容进行删减。

我们正在发布《负责任扩展政策》（Responsible Scaling Policy，简称 RSP）的第三版——这是我们为缓解 AI 系统可能引发的灾难性风险而自愿采用的框架。

Anthropic 实施 RSP 已逾两年，期间我们对这一政策的优势与不足积累了大量实践经验。因此，本次更新旨在强化迄今行之有效的机制，在必要之处优化政策内容，并引入新措施，以进一步提升我们决策过程的透明度与问责性。

您可在此处完整阅读新版 RSP：[https://anthropic.com/responsible-scaling-policy/rsp-v3-0](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)。本文将重点介绍此次修订背后的思考逻辑。

## 初始版 RSP 与我们的变革理论

RSP 是我们针对一类特殊挑战所提出的解决方案：即如何应对在政策制定时尚未显现、却可能随指数级演进的 AI 技术而迅速浮现的 AI 风险。2023 年 9 月，我们在起草[初始版 RSP](https://www.anthropic.com/news/anthropics-responsible-scaling-policy) 时，大型语言模型本质上仍仅是聊天界面；而如今，它们已能浏览网页、编写并运行代码、操作计算机，甚至能自主执行多步骤任务。随着每一项新能力的涌现，相应的新风险也随之产生。我们预计这一趋势将持续下去。

我们将 RSP 的核心原则设定为“条件式”（或称“若—则”式）承诺：**若**某模型在特定能力维度上超越既定阈值（例如，在生物科学领域具备协助制造危险武器的能力），**则**政策即要求我们启动一套全新且更为严格的防护措施（例如，防范模型滥用及模型权重被盗）。

每一套防护措施均对应一个“AI 安全等级”（AI Safety Level，简称 ASL）：例如，ASL-2 指代一组基础防护要求，而 ASL-3 则指代适用于更高能力 AI 模型的一套更严格防护要求。

早期的 ASL（ASL-2 和 ASL-3）被定义得较为详尽；但针对尚需数代技术演进方能实现的未来模型，其所需防护措施则难以预先准确界定。因此，我们有意将后续等级（ASL-4 及以上）留作宽泛框架，待我们对更高阶 AI 能力的具体形态形成更清晰认知后，再予以细化完善。

The following is a rough description of our “theory of change”—that is, the mechanisms whereby we hoped to affect the ecosystem with the RSP:

以下是对我们的“变革理论”（即我们期望通过《前沿安全政策》（RSP）影响整个生态系统的机制）的粗略描述：

- _An internal forcing function._ Within Anthropic, we hoped the RSP would compel us to treat important safeguards as requirements for launching (and training) new models. This made the importance of these safeguards clear to the large and growing organization, spurring us on to make faster progress.

- _内部强制机制_：在 Anthropic 内部，我们希望 RSP 能推动我们将关键安全措施视为新模型发布（及训练）的硬性要求。此举使这些安全措施的重要性在规模日益扩大的组织内部变得清晰明确，从而激励我们加快相关进展。

- _A race to the top._ We hoped that announcing our RSP would encourage other AI companies to introduce similar policies. This is the idea of a “race to the top” (the converse of a “race to the bottom”), in which different industry players are incentivized to improve, rather than weaken, their models’ safeguards and their overall safety posture. Over time, we hoped RSPs, or similar policies, would become voluntary industry standards or go on to inform AI laws aimed at encouraging safety and transparency in AI model development.

- _向上的竞逐_：我们期望通过公布 RSP 激励其他人工智能公司推出类似政策。“向上的竞逐”（与“向下的竞逐”相反）意味着行业各方将受到激励，持续提升而非削弱其模型的安全防护能力与整体安全态势。长远来看，我们希望 RSP 或类似政策能逐步发展为行业自愿性标准，或进一步为旨在促进人工智能模型研发安全性与透明度的 AI 立法提供参考依据。

- _Creating more consensus about risks._ We viewed the capability thresholds as potentially important moments for the industry. If we reached an important capability threshold (such as the ability of AI models to support the end-to-end production of bioweapons), we would institute the appropriate safeguards ourselves and use the evidence we’d obtained about AI capabilities to advocate to other companies and governments that they take action as well. In other words, we believed that the capability thresholds might be good points at which to go beyond _unilateral_ action (Anthropic requiring safeguards for its own models) and encourage _multilateral_ action (other AI companies, and/or governments also requiring such safeguards).

- _增进对风险的共识_：我们将各项能力阈值视为可能具有行业里程碑意义的关键节点。一旦我们触及某项重要能力阈值（例如，AI 模型具备支持生物武器端到端全流程制造的能力），我们将率先自主部署相应安全措施，并利用所积累的 AI 能力实证数据，呼吁其他企业及各国政府同步采取行动。换言之，我们认为这些能力阈值恰是超越“单边行动”（仅 Anthropic 对自身模型提出安全要求）并推动“多边行动”（其他 AI 公司和/或各国政府亦共同采纳此类安全要求）的理想契机。

- _Looking to the future_. We recognized that, at some of the later capability thresholds, the intensity of countermeasures we were envisioning (for example, achieving high robustness against misuse of AI models by state-level actors) would likely be difficult or impossible for Anthropic to accomplish unilaterally. We hoped that by the time we reached these higher capabilities, the world would clearly see the dangers, and that we’d be able to coordinate with governments worldwide in implementing safeguards that are difficult for one company to achieve alone.

- _着眼未来_：我们认识到，在后续若干能力阈值上，我们所构想的反制措施强度（例如，实现对国家级行为体滥用 AI 模型行为的高度鲁棒防御）很可能超出 Anthropic 单独承担的能力范围。我们曾期望，待我们抵达更高能力水平时，全球社会将清晰认知相关风险，并使我们得以与世界各国政府协同落实那些单靠一家公司难以独立实现的安全保障措施。

## Assessing our theory of change

## 对我们变革理论的评估

Two and a half years later, our honest assessment is that some parts of this theory of change have played out as we hoped, but others have not. The following are the areas in which the RSP has been successful:

两年半之后，我们坦诚地评估认为：这一变革理论的部分内容已如预期般落地，但另一些方面则尚未实现。以下是 RSP 已取得成效的领域：

- Our RSP **did** incentivize us to develop stronger safeguards. For example, in order to comply with our ASL-3 deployment standard (which is primarily about risks from chemical and biological weapons from threat actors with relatively modest resources and expertise), we developed increasingly sophisticated and accurate methods (specifically, [input and output classifiers](https://www.anthropic.com/research/constitutional-classifiers)) to block content of concern.

- 我们的 RSP **确实**激励我们开发了更强大的安全防护措施。例如，为满足 ASL-3 部署标准（该标准主要针对资源与专业知识相对有限的威胁行为体所引发的化学与生物武器风险），我们持续开发出日益复杂且精准的干预方法（具体而言，即[输入与输出分类器](https://www.anthropic.com/research/constitutional-classifiers)），用以屏蔽高风险内容。

- More broadly, the overall implementation of the ASL-3 standard **did** prove feasible. We [activated ASL-3 safeguards](https://www.anthropic.com/news/activating-asl3-protections) for relevant models in May 2025 and have been working to improve them ever since.

- 更广泛地说，ASL-3 标准的整体实施 **确实** 被证明是可行的。我们已于 2025 年 5 月[为相关模型启用 ASL-3 安全防护](https://www.anthropic.com/news/activating-asl3-protections)，并持续优化至今。

- Our RSP **did** encourage other AI companies to adopt somewhat similar standards: within a few months of announcing our RSP, both [OpenAI](https://cdn.openai.com/openai-preparedness-framework-beta.pdf) and [Google DeepMind](https://storage.googleapis.com/deepmind-media/DeepMind.com/Blog/introducing-the-frontier-safety-framework/fsf-technical-report.pdf) adopted broadly similar frameworks. Some companies have also [implemented](https://cdn.openai.com/gpt-5-system-card.pdf) bioweapon-related classifiers in a similar vein to our ASL-3 defenses. The principles behind these voluntary standards, including those in the RSP, have helped to inform the development of early AI policy. We’ve seen governments around the world (for example in California with [SB 53](https://leginfo.legislature.ca.gov/faces/billTextClient.xhtml?bill_id=202520260SB53), in New York with the [RAISE Act](https://www.nysenate.gov/legislation/bills/2025/A6453/amendment/A), and with the EU AI Act’s [Codes of Practice](https://artificialintelligenceact.eu/article/56/)) start to require frontier AI developers to create and publish frameworks for assessing and managing catastrophic risks—requirements Anthropic addresses through public documentation including its [Frontier Compliance Framework](https://trust.anthropic.com/resources?s=eorilovp4wxk38nxbi7k3&name=anthropic-frontier-compliance-framework). Encouraging these kinds of rigorous transparency frameworks for the industry was exactly what our RSP had set out to do.

- 我们的 RSP **确实** 推动了其他 AI 公司采纳大致相似的标准：在我们公布 RSP 后数月内，[OpenAI](https://cdn.openai.com/openai-preparedness-framework-beta.pdf) 与 [Google DeepMind](https://storage.googleapis.com/deepmind-media/DeepMind.com/Blog/introducing-the-frontier-safety-framework/fsf-technical-report.pdf) 均推出了结构高度近似的安全框架。部分公司还[部署了](https://cdn.openai.com/gpt-5-system-card.pdf)与我们 ASL-3 防御机制类似的生物武器相关内容分类器。这些自愿性标准（包括 RSP 所体现的原则）为早期 AI 政策的制定提供了重要参考。我们已观察到全球多国政府（例如加利福尼亚州的 [SB 53 法案](https://leginfo.legislature.ca.gov/faces/billTextClient.xhtml?bill_id=202520260SB53)、纽约州的 [RAISE 法案](https://www.nysenate.gov/legislation/bills/2025/A6453/amendment/A)，以及欧盟《人工智能法案》中的[行为守则](https://artificialintelligenceact.eu/article/56/)）开始要求前沿 AI 开发者建立并公开发布用于评估与管控灾难性风险的框架——Anthropic 通过其公开文档（包括[前沿合规框架](https://trust.anthropic.com/resources?s=eorilovp4wxk38nxbi7k3&name=anthropic-frontier-compliance-framework)）回应了此类监管要求。推动业界建立此类严谨、透明的制度框架，正是 RSP 的核心目标所在。

Nevertheless, other parts of our theory of change have not panned out as we’d hoped:

然而，我们变革理论的其他部分并未如预期般实现：

- The idea of using the RSP thresholds to create more consensus about AI risks **did not** play out in practice—although there was some of this effect. We found pre-set capability levels to be far more ambiguous than we anticipated: in some cases, model capabilities have clearly _approached_ the RSP thresholds, but we have had substantial uncertainty about whether they have definitively _passed_ those thresholds. The science of model evaluation isn’t well-developed enough to provide dispositive answers. In such cases, we have taken a precautionary approach and implemented the relevant safeguards, but our internal uncertainty translates into a weak external case for taking multilateral action across the AI industry.

- 利用 RSP 能力阈值增进业界对 AI 风险共识这一构想，在实践中**并未真正实现**——尽管产生了一定程度的积极影响。我们发现预设的能力等级远比预期更为模糊：某些情况下，模型能力已明显**趋近**RSP 阈值，但我们对其是否已确凿无疑地**跨越**该阈值仍存在显著不确定性。当前模型评估科学尚不成熟，尚无法给出决定性结论。在此类情形下，我们采取了审慎原则，主动部署了相应安全措施；但这种内部不确定性，却削弱了我们在整个 AI 行业推动多边协同行动的外部说服力。

  - Biological risks provide an example of this “zone of ambiguity”. Our models now show enough biological knowledge that they pass most tests we can run quickly and easily, so we can no longer make a strong argument that risks are low from a given model. But these tests alone aren’t sufficient for a strong argument that risks are _high_, either. We’ve sought additional evidence, such as supporting an extensive [wet-lab trial](https://arxiv.org/pdf/2602.16703), but results remain ambiguous, especially because the studies take long enough that more powerful models are available by the time they’re completed.

  - 生物安全风险即为此类“模糊地带”的典型例证。当前我们的模型已展现出足够丰富的生物学知识，足以通过绝大多数快速简易的测试，因此我们已无法有力主张某款模型的风险水平较低；但仅凭这些测试本身，同样不足以有力论证其风险水平**较高**。我们曾寻求更多佐证，例如资助一项大规模[湿实验研究](https://arxiv.org/pdf/2602.16703)，但结果依然模糊不清——尤其因为这类研究耗时较长，待其完成时，更强大的新模型早已面世。

- Despite rapid advances in AI capabilities over the past three years, government action on AI safety has moved slowly. The policy environment has shifted toward prioritizing AI competitiveness and economic growth, while safety-oriented discussions have yet to gain meaningful traction at the federal level. We remain convinced that effective government engagement on AI safety is both necessary and achievable, and we aim to continue advancing a conversation grounded in evidence, national security interests, economic competitiveness, and public trust. But this is proving to be a long-term project—not something that is happening organically as AI becomes more capable or crosses certain thresholds.

- 尽管过去三年间 AI 能力突飞猛进，各国政府在 AI 安全领域的实质性行动却进展缓慢。当前政策环境正转向优先强调 AI 竞争力与经济增长，而聚焦安全议题的讨论在联邦层面尚未获得切实推动力。我们仍坚信：政府有效参与 AI 安全治理既属必要，亦具可行性；我们将持续推动一场立足实证、兼顾国家安全利益、经济竞争力与公众信任的对话。但现实表明，这是一项长期工程——它并不会随着 AI 能力自然增强或跨越特定阈值而自发发生。

As noted above, we were able to [implement](https://www.anthropic.com/news/activating-asl3-protections) ASL-3 safeguards unilaterally and at reasonable costs to the operation of the company. However, this may not remain true for higher capability levels and higher ASLs. While our higher ASLs are largely undefined, the robust mitigations we laid out in the prior RSP might prove outright impossible to implement without collective action. As one illustration of the scale of the challenge, a [RAND report](https://www.rand.org/content/dam/rand/pubs/research_reports/RRA2800/RRA2849-1/RAND_RRA2849-1.pdf) on model weight security states that its “SL5” security standard, aimed at stopping top-priority operations by the most cyber-capable institutions, is “currently not possible” and “will likely require assistance from the national security community.”

如前所述，我们已能够[单方面实施](https://www.anthropic.com/news/activating-asl3-protections) ASL-3 级别的安全防护措施，且对公司运营成本的影响处于合理范围内。然而，这一情况未必适用于更高能力层级与更高 ASL 等级。尽管我们尚未明确定义更高层级的 ASL，但先前 RSP 中所规划的强效缓解措施，若无集体协作，或将根本无法落实。RAND 公司一份关于模型权重安全的[研究报告](https://www.rand.org/content/dam/rand/pubs/research_reports/RRA2800/RRA2849-1/RAND_RRA2849-1.pdf)即为此类挑战规模提供了例证：该报告提出的“SL5”安全标准（旨在阻断网络能力最强机构所开展的最高优先级行动）被明确指出“目前尚不可行”，且“很可能需要国家安全界提供协助”。

The combination of (a) the zone of ambiguity muddling the public case for risk, (b) an anti-regulatory political climate, and (c) requirements at the higher RSP levels that are very hard to meet unilaterally, creates a structural challenge for our current RSP. We could have tried to address this by defining ASL-4 and ASL-5 safeguards in ways that made compliance easy to achieve—but this would undermine the intended spirit of the RSP.

(a) 风险认知的“模糊地带”削弱了面向公众的风险论证效力，(b) 反规制的政治氛围，以及 (c) RSP 更高层级所提出的要求在单边条件下极难达成——三者叠加，构成了当前 RSP 面临的结构性挑战。我们本可尝试通过重新定义 ASL-4 和 ASL-5 的安全措施，使其易于合规来应对这一困境；但这将背离 RSP 的初衷与精神内核。

Instead, we are choosing to acknowledge these challenges transparently and restructure the RSP _before_ we reach these higher levels. The revised RSP aims to adopt more realistic unilateral commitments that are difficult but still achievable in the current environment, while continuing to comprehensively map the risks we believe the full industry needs to address multilaterally.

取而代之的是，我们选择以坦诚透明的方式直面这些挑战，并在抵达更高能力层级**之前**即对 RSP 进行重构。修订后的 RSP 将确立更具现实可行性的单边承诺——这些承诺虽具挑战性，但在当前环境下仍可达成；同时，它将继续全面梳理我们认定需由整个行业通过多边协作共同应对的风险图谱。

## Updating our Responsible Scaling Policy

## 更新我们的《负责任扩展政策》

The new version of our RSP has three key elements.

新版《负责任扩展政策》（RSP）包含三个关键要素。

### 1\. Separating our plans as a company from our recommendations for the industry

### 1. 区分公司自身计划与面向行业的建议

Our RSP now outlines two sets of mitigations: first, the mitigations that we plan to pursue regardless of what others do; and second, an ambitious capabilities-to-mitigations map that, we believe, would help adequately manage the risks from advanced AI if implemented across the AI industry.

新版RSP明确了两类风险缓解措施：其一，无论行业其他主体是否采取行动，我们都将自主推进的缓解措施；其二，一份雄心勃勃的“能力—缓解措施映射图”，我们相信，若整个AI行业共同落实该映射图，将有助于充分管控先进AI带来的风险。

Read the full [Responsible Scaling Policy](https://anthropic.com/responsible-scaling-policy/rsp-v3-0).

请阅读完整的[《负责任扩展政策》](https://anthropic.com/responsible-scaling-policy/rsp-v3-0)。

### 2\. Frontier Safety Roadmap

### 2. 前沿安全路线图

Our new RSP introduces a requirement to develop and publish a Frontier Safety Roadmap, which will describe our concrete plans for risk mitigations across the areas of Security, Alignment, Safeguards, and Policy. Goals described in the Roadmaps are intended to be ambitious, yet achievable—providing the kind of forcing function that we consider to be a past success of our RSP.

新版RSP新增一项要求：制定并公开发布《前沿安全路线图》，详述我们在安全（Security）、对齐（Alignment）、防护机制（Safeguards）及政策（Policy）四大领域中具体的风险缓解计划。路线图中设定的目标既具雄心，又切实可行——这类“倒逼机制”（forcing function）正是我们此前RSP版本取得成功的关键所在。

Rather than being hard commitments, these are public goals that we will openly grade our progress towards. This strategy of “nonbinding but publicly-declared” targets borrows from the transparency approach we’ve been championing for frontier AI legislation (although it provides the public with much more detail than is required under existing legislation), and from the successes of our previous RSP versions.

这些目标并非具有法律约束力的承诺，而是向公众公开声明的目标，我们将以开放、透明的方式定期评估自身进展。这种“无法律约束力但公开声明”的目标设定策略，借鉴了我们一贯倡导的前沿AI立法透明化路径（尽管本路线图向公众披露的信息远比现行立法所要求的更为详尽），也延续了此前各版RSP的成功实践。

Some example goals from our current Frontier Safety Roadmap include:

我们当前《前沿安全路线图》中部分示例目标包括：

- Launch “moonshot R&D” projects to investigate ambitious, possibly unconventional ways to achieve unprecedented levels of information security;

- 启动“登月式研发”（moonshot R&D）项目，探索雄心勃勃、甚至可能非传统的路径，以实现前所未有的信息安全水平；

- Develop a method for red-teaming our systems (likely involving significant automation) that surpasses the collective contributions from the hundreds of participants in our [bug bounty](https://support.claude.com/en/articles/12119250-model-safety-bug-bounty-program);

- 开发一套红队演练（red-teaming）方法（很可能高度依赖自动化），其效能须超越我们[漏洞赏金计划](https://support.claude.com/en/articles/12119250-model-safety-bug-bounty-program)中数百名参与者的集体贡献；

- Implement a number of systematic measures to ensure Claude behaves according to its [constitution](https://www.anthropic.com/constitution);

- 实施一系列系统性措施，确保Claude严格遵循其[宪法](https://www.anthropic.com/constitution)行事；

- Establish comprehensive, centralized records of all our critical AI development activities, and use AI to analyze these records for issues including concerning behavior by insiders (both human and AI) and security threats;

- 建立全面、集中的核心AI研发活动记录系统，并利用AI技术分析这些记录，识别包括内部人员（含人类与AI）异常行为及各类安全威胁在内的潜在问题；

- Publish a policy roadmap with concrete proposals for a “regulatory ladder”—policies that scale with increasing risk and that could help guide government AI policy.

- 发布一份政策路线图，提出具体可行的“监管阶梯”（regulatory ladder）方案——即随风险等级提升而逐级强化的政策框架，以期为政府制定AI监管政策提供有益参考。

Read the [Frontier Safety Roadmap](https://anthropic.com/responsible-scaling-policy/roadmap) for more on these and our other goals.

请参阅[前沿安全路线图（Frontier Safety Roadmap）](https://anthropic.com/responsible-scaling-policy/roadmap)，了解上述内容及我们的其他目标。

### 3\. Risk Reports and external review

### 3. 风险报告与外部评审

Risk Reports are another way in which we’re improving upon what worked well about our previous RSP. We found that producing a proto-Risk Report, our [Safeguards Report](https://www-cdn.anthropic.com/dc4cb293c77da3ca5e3398bdeef75ee17b42b73f.pdf) from May 2025, was useful for our internal understanding and the public communication of the risks. Risk Reports extend this to a more systematic, comprehensive practice.

风险报告（Risk Reports）是我们对上一版《负责任扩展政策》（RSP）中行之有效做法的进一步优化。我们发现，此前发布的试运行版风险报告——即我们于2025年5月发布的[Safeguards Report（防护措施报告）](https://www-cdn.anthropic.com/dc4cb293c77da3ca5e3398bdeef75ee17b42b73f.pdf)——在提升内部风险认知和向公众传达风险信息方面均发挥了积极作用。风险报告则将这一实践拓展为更系统、更全面的工作机制。

Risk Reports will provide detailed information on the safety profile of our models at the time of publication. They will go beyond describing model capabilities to explain how capabilities, threat models (the specific ways that models might pose threats), and active risk mitigations fit together, and provide an assessment of the overall level of risk. Risk Reports will be published online (with some redactions¹) every 3–6 months.

每份风险报告将在发布时详尽呈现我们模型当时的安全状况。其内容不仅涵盖模型能力描述，还将深入阐释模型能力、威胁模型（即模型可能构成威胁的具体方式）以及正在实施的风险缓解措施三者之间的关联，并据此对整体风险水平作出评估。风险报告将每3至6个月在线发布一次（部分内容将作脱敏处理¹）。

The new RSP also requires external review of Risk Reports in certain circumstances. We will appoint expert third-party reviewers who are deeply familiar with AI safety research, are incentivized to be open and honest about Anthropic’s safety position, and are free of major conflicts of interest. They will have unredacted or minimally-redacted access to the Risk Report and will subject our reasoning, analysis, and decision-making to a comprehensive public review. Although our current models do not yet require external review, we are already running pilots and working toward this goal.

新版RSP还规定，在特定情形下须对风险报告开展外部评审。我们将遴选具备深厚AI安全研究背景的第三方专家担任评审人；这些专家须有充分动机坦诚、客观地评价Anthropic的安全立场，且不存在重大利益冲突。他们将获得未经脱敏或仅作最低限度脱敏的风险报告全文，并对我们的推理逻辑、分析过程与决策依据展开全面、公开的评审。尽管我们当前的模型尚不强制要求外部评审，但我们已启动相关试点项目，并正积极推进此项工作。

Risk Reports will address any gaps between our current safety and security measures and our more ambitious recommendations for industry-wide safety. We are hopeful that describing and publicizing such gaps could help contribute to public awareness and thus to beneficial policy change in the future.

风险报告还将指出我们当前安全与防护措施同我们在全行业层面提出的更高远安全建议之间存在的差距。我们期望，通过明确揭示并公开披露此类差距，有助于提升公众认知，进而推动未来形成更有益的政策变革。

Read the [initial Risk Report](https://anthropic.com/feb-2026-risk-report).

请查阅[首份风险报告（initial Risk Report）](https://anthropic.com/feb-2026-risk-report)。

## Conclusion

## 结语

The Responsible Scaling Policy was always planned to be a living document: a policy that had the flexibility to change as AI models become more capable. This third revision amplifies what worked about the previous RSP, commits us to more transparency about our plans and our risk considerations, and separates out our recommendations for the industry at large from what we can achieve as an individual company.

《负责任扩展政策》（Responsible Scaling Policy）自始即被设计为一份“动态演进的文件”（living document）：一项能够随AI模型能力持续提升而灵活调整的政策。本次第三版修订在继承前版RSP成功经验的基础上，进一步强化了我们对自身发展规划与风险考量的透明度承诺，并将面向整个行业的通用性建议，与我们作为单个企业所能切实达成的目标明确区分开来。

In that same spirit of pragmatism we will continue to revise and refine our RSP, and our methods of evaluating and mitigating risks, as the technology evolves.

秉承同样务实的精神，我们将持续修订和完善RSP，以及风险评估与缓解方法，以适配技术的不断演进。
{% endraw %}
