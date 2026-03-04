---
title: "Strengthening cyber resilience as AI capabilities advance | OpenAI"
render_with_liquid: false
source: "OpenAI Blog"
url: "https://openai.com/index/strengthening-cyber-resilience"
date: "2025-12-10"
scraped_at: "2026-03-02T10:47:39.655483355+00:00"
language: "en-US"
translated: true
description: "OpenAI is investing in stronger safeguards and defensive capabilities as AI models become more powerful in cybersecurity. We explain how we assess risk, limit misuse, and work with the security commun..."
tags: ["Security"]
---

render_with_liquid: false
December 10, 2025

2025年12月10日


# Strengthening cyber resilience as AI capabilities advance

# 随着AI能力提升，强化网络韧性


As our models grow more capable in cybersecurity, we’re investing in strengthening them, layering in safeguards, and partnering with global security experts.

随着我们的模型在网络安全领域的能力不断增强，我们正加大投入，以强化模型本身、层层部署安全防护措施，并与全球安全专家开展合作。


Cyber capabilities in AI models are advancing rapidly, bringing meaningful benefits for cyberdefense as well as new dual-use risks that must be managed carefully. For example, capabilities assessed through capture-the-flag (CTF) challenges have improved from 27% on [GPT‑5⁠(opens in a new window)](https://cdn.openai.com/gpt-5-system-card.pdf) in August 2025 to 76% on [GPT‑5.1‑Codex‑Max⁠(opens in a new window)](https://cdn.openai.com/pdf/2a7d98b1-57e5-4147-8d0e-683894d782ae/5p1_codex_max_card_03.pdf) in November 2025.

AI模型的网络能力正快速提升，在为网络防御带来切实裨益的同时，也催生了新的“两用”（dual-use）风险，亟需审慎管理。例如，通过夺旗赛（CTF）挑战所评估的能力，已从2025年8月发布的[GPT‑5⁠(在新窗口中打开)](https://cdn.openai.com/gpt-5-system-card.pdf)的27%，提升至2025年11月发布的[GPT‑5.1‑Codex‑Max⁠(在新窗口中打开)](https://cdn.openai.com/pdf/2a7d98b1-57e5-4147-8d0e-683894d782ae/5p1_codex_max_card_03.pdf)的76%。


We expect that upcoming AI models will continue on this trajectory; in preparation, we are planning and evaluating as though each new model could reach ‘High’ levels of cybersecurity capability, as measured by our [Preparedness Framework⁠(opens in a new window)](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf). By this, we mean models that can either develop working zero-day remote exploits against well-defended systems, or meaningfully assist with complex, stealthy enterprise or industrial intrusion operations aimed at real-world effects. This post explains how we think about safeguards for models that reach these levels of capability, and ensure they meaningfully help defenders while limiting misuse.

我们预计，后续发布的AI模型将持续沿此趋势演进；为此，我们正以“每一款新模型均可能达到‘高’级别网络安全能力”为前提，开展规划与评估工作——该能力等级依据我们的[就绪性框架（Preparedness Framework）⁠(在新窗口中打开)](https://cdn.openai.com/pdf/18a02b5d-6b67-4cec-ab64-68cdfbddebcd/preparedness-framework-v2.pdf)进行衡量。此处所指的“高级别能力”，即模型具备以下任一能力：（1）针对防护严密的系统，自主开发并成功利用零日远程漏洞；或（2）实质性辅助执行复杂、隐蔽的企业级或工业级入侵行动，以达成现实世界中的实际影响。本文将阐述我们如何为达到此类能力水平的模型设计安全防护机制，确保其切实赋能防御方，同时有效遏制滥用。


As these capabilities advance, OpenAI is investing in strengthening our models for defensive cybersecurity tasks and creating tools that enable defenders to more easily perform workflows such as auditing code and patching vulnerabilities. Our goal is for our models and products to bring significant advantages for defenders, who are often outnumbered and under-resourced.

随着上述能力持续演进，OpenAI正加大投入，强化模型在防御性网络安全任务中的表现，并开发一系列工具，助力防御人员更高效地完成代码审计、漏洞修复等工作流程。我们的目标是，让模型与产品切实为防御方带来显著优势——而防御方往往面临人手不足、资源匮乏的现实困境。


Like other dual-use domains, defensive and offensive cyber workflows often rely on the same underlying knowledge and techniques. We are investing in safeguards to help ensure these powerful capabilities primarily benefit defensive uses and limit uplift for malicious purposes. Cybersecurity touches almost every field, which means we cannot rely on any single category of safeguards—such as restricting knowledge or using vetted access alone—but instead need a defense-in-depth approach that balances risk and empowers users. In practice, this means shaping how capabilities are accessed, guided, and applied so that advanced models strengthen security rather than lower barriers to misuse.

与其他两用技术领域类似，网络防御与网络攻击的工作流程往往依赖相同的基础知识与技术手段。我们正大力投资于各类防护措施，以确保这些强大能力主要服务于防御目的，并最大限度抑制其被恶意利用的可能性。网络安全几乎渗透所有行业领域，这意味着我们无法仅依赖某一种类的防护手段——例如单纯限制知识输出，或仅依靠审核准入机制——而必须采取纵深防御（defense-in-depth）策略，在管控风险与赋能用户之间取得平衡。在实践中，这体现为对能力的访问方式、使用引导及应用场景进行系统性塑造，确保先进模型真正增强整体安全性，而非降低恶意行为的实施门槛。


We see this work not as a one-time effort, but as a sustained, long-term investment in giving defenders an advantage and continually strengthening the security posture of the critical infrastructure across the broader ecosystem.

我们视此项工作并非一次性任务，而是长期、持续的战略投入——旨在为防御方构建可持续优势，并不断强化整个生态体系中关键基础设施的安全态势。


## Mitigating malicious uses

## 缓解恶意用途

Our models are designed and trained to operate safely, supported by proactive systems that detect and respond to cyber abuse. We continuously refine these protections as our capabilities and the threat landscape change. While no system can guarantee complete prevention of misuse in cybersecurity without severely impacting defensive uses, our strategy is to mitigate risk through a layered safety stack.

我们的模型经过专门设计与训练，以确保安全运行，并由主动式系统提供支持，用以检测和响应网络滥用行为。随着自身能力提升及威胁态势的持续演变，我们不断优化这些防护措施。尽管没有任何系统能在不严重削弱防御性用途的前提下，完全杜绝网络安全领域的误用行为，但我们采取的是“分层安全堆栈”策略，以系统性降低风险。

At the foundation of this, we take a defense-in-depth approach, relying on a combination of access controls, infrastructure hardening, egress controls, and monitoring. We complement these measures with detection and response systems, and dedicated threat intelligence and insider-risk programs, making it so emerging threats are identified and blocked quickly. These safeguards are designed to evolve with the threat landscape. We assume change, and we build so we can adjust quickly and appropriately.

这一策略以“纵深防御”（defense-in-depth）为根基，综合运用访问控制、基础设施加固、出口流量管控（egress controls）以及持续监控等多重手段。我们进一步辅以检测与响应系统，以及专属的威胁情报与内部风险（insider-risk）项目，从而实现对新兴威胁的快速识别与拦截。这些安全防护机制本身即被设计为可随威胁态势演进而动态演进。我们预设变化是常态，并据此构建具备快速、精准适应能力的系统。

Building on this foundation:

在此基础之上：

- **Training the model to refuse or safely respond to harmful requests while remaining helpful for educational and defensive use cases:** We are training our frontier models to refuse or safely respond to requests that would enable clear cyber abuse, while remaining maximally helpful for legitimate defensive and educational use cases.

- **面向教育与防御场景的请求响应训练：** 我们正训练前沿模型，使其能够拒绝或以安全方式回应可能助长明确网络滥用行为的请求，同时在合法的防御性与教育性应用场景中保持最大程度的实用性与帮助性。

- **Detection systems:** We refine and maintain system-wide monitoring across products that use frontier models to detect potentially malicious cyber activity. When activity appears unsafe, we may block output, route prompts to safer or less capable models, or escalate for enforcement. Our enforcement combines automated and human review, informed by factors like legal requirements, severity, and repeat behavior. We also work closely with developers and enterprise customers to align on safety standards and enable responsible use with clear escalation paths.

- **检测系统：** 我们持续优化并维护覆盖所有采用前沿模型产品的全系统级监控，用以识别潜在恶意网络活动。一旦发现活动存在安全隐患，我们可能屏蔽输出内容、将提示词（prompt）路由至更安全或能力受限的模型，或升级至人工审核与执行环节。我们的执行机制融合自动化审查与人工研判，决策依据包括法律合规要求、事件严重程度、重复违规行为等因素。我们亦与开发者及企业客户紧密协作，就安全标准达成共识，并通过清晰的升级路径，推动负责任的模型使用。

- **End-to-end red teaming:** We are working with expert red teaming organizations to evaluate and improve our safety mitigations. Their job is to try to bypass all of our defenses by working end-to-end, just like a determined and well-resourced adversary might. This helps us identify gaps early and strengthen the full system.

- **端到端红队演练：** 我们正携手专业红队组织，对现有安全缓解措施开展评估与优化。其核心任务是——像一名意志坚定、资源充足的对手那样，从头至尾尝试绕过我们全部防御机制。此举有助于我们尽早发现防护盲区，并全面提升整个系统的健壮性。

## Ecosystem initiatives to strengthen cyber resilience

## 强化网络韧性的生态系统倡议

OpenAI has invested early in applying AI to defensive cybersecurity use cases and our team closely coordinates with global experts to mature both our models and their application. We value the global community of cybersecurity practitioners toiling to make our digital world safer and are committed to delivering powerful tools that support defensive security. As we roll out new safeguards, we will continue to work with the cybersecurity community to understand where AI can meaningfully strengthen resilience, and where thoughtful safeguards are most important.

OpenAI 很早就开始投入将人工智能应用于防御性网络安全场景，并与全球专家密切协作，共同推动模型能力及其实际应用的持续成熟。我们高度珍视全球范围内致力于让数字世界更安全的网络安全从业者群体，并坚定承诺提供强大工具，切实赋能防御性安全工作。随着新一批安全防护措施的陆续推出，我们将持续与网络安全社区协作，深入理解人工智能可在哪些关键领域实质性增强网络韧性，以及在哪些环节尤其需要审慎周密的安全保障。

Alongside these collaborations, we are establishing a set of efforts designed to help defenders move faster, ground our safeguards in real-world needs, and accelerate responsible remediation at scale.

除上述协作外，我们正启动一系列专项举措，旨在助力防御者更快响应威胁、使我们的安全防护机制扎根于真实世界需求，并在规模化层面加速推进负责任的漏洞修复与风险处置。

#### Trusted access programs for cyberdefense

#### 面向网络防御的可信访问计划

We will soon introduce a trusted access program where we explore providing qualifying users and customers working on cyberdefense with tiered access to enhanced capabilities in our latest models for defensive use cases. We're still exploring the right boundary of which capabilities we can provide broad access to and which ones require tiered restrictions, which may influence the future design of this program. We aim for this trusted access program to be a building block towards a resilient ecosystem.

我们即将推出一项“可信访问计划”，探索为符合资质、从事网络防御工作的用户与客户，按等级开放我们最新模型中面向防御场景的增强能力。目前，我们仍在审慎界定：哪些能力可广泛开放，而哪些能力需实施分级限制——这一权衡将直接影响该计划未来的设计方向。我们期望此项可信访问计划成为构建韧性生态系统的基石之一。

#### Expanding defensive capacity with Aardvark

#### 借助 Aardvark 扩展防御能力

[Aardvark](https://openai.com/index/introducing-aardvark/), our agentic security researcher that helps developers and security teams find and fix vulnerabilities at scale, is now in private beta. It scans codebases for vulnerabilities and proposes patches that maintainers can adopt quickly. It has already identified novel CVEs in open-source software by reasoning over entire codebases. We plan to offer free coverage to select non-commercial open source repositories to contribute to the security of the open source software ecosystem and supply chain. Apply to participate [here](https://openai.com/form/aardvark-beta-signup/).

[Aardvark](https://openai.com/index/introducing-aardvark/)，我们推出的具备自主行为能力的安全研究员，可协助开发者与安全团队规模化地发现并修复漏洞，目前已进入私有测试阶段。它能扫描代码库中的安全漏洞，并为维护者快速提供可采纳的补丁方案；通过深度分析整个代码库，它已成功识别出多个开源软件中此前未被发现的新型 CVE（通用漏洞披露）。为助力开源软件生态及供应链的整体安全建设，我们计划为部分非商业性质的开源代码仓库免费提供 Aardvark 服务。欢迎在此[申请参与](https://openai.com/form/aardvark-beta-signup/)。

#### Frontier Risk Council

#### 前沿风险委员会

We will be establishing the Frontier Risk Council, an advisory group that will bring experienced cyber defenders and security practitioners into close collaboration with our teams. This council will start with a focus on cybersecurity, and expand into other frontier capability domains in the future. Members will advise on the boundary between useful, responsible capability and potential misuse, and these learnings will directly inform our evaluations and safeguards. We will share more on the council soon.

我们将成立“前沿风险委员会”（Frontier Risk Council），这是一个由资深网络防御专家与安全实践者组成的咨询小组，旨在与我们的团队开展深度协作。该委员会初期将聚焦于网络安全领域，未来将逐步拓展至其他前沿能力相关领域。委员们将就“有益且负责任的能力”与“潜在滥用风险”之间的边界提供专业建议；这些洞见将直接指导我们的模型评估体系与安全防护机制建设。关于该委员会的更多细节，我们将尽快公布。

#### Developing a shared understanding on threat models with the industry

#### 与业界共建威胁模型的共同认知

Finally, we anticipate cyber misuse may be viable from any frontier model in the industry. To address this, we work with other frontier labs through the Frontier Model Forum, a nonprofit backed by leading AI labs and industry partners, to develop a shared understanding of threat models and best practices. In this context, threat modeling helps mitigate risk by identifying how AI capabilities could be weaponized, where critical bottlenecks exist for different threat actors, and how frontier models might provide meaningful uplift. This collaboration aims to build a consistent, ecosystem-wide understanding of threat actors and attack pathways, enabling labs, maintainers, and defenders to better improve their mitigations and ensure critical security insights propagate quickly across the ecosystem. We are also engaging with external teams to develop [cybersecurity evaluations⁠(opens in a new window)](https://www.irregular.com/publications/spell-bound-technical-case-study). We hope an ecosystem of independent evaluations will further help build a shared understanding of model capabilities.

最后，我们预判：任何业界前沿模型均可能被用于网络恶意用途。为此，我们正通过“前沿模型论坛”（Frontier Model Forum）——一个由领先人工智能实验室与产业合作伙伴共同支持的非营利组织——与其他前沿实验室协同合作，共同构建对威胁模型与最佳实践的统一认知。在此框架下，“威胁建模”（threat modeling）有助于风险缓解：它可识别AI能力被武器化的潜在路径、不同威胁行为体所面临的关键瓶颈，以及前沿模型可能带来的实质性能力提升。该协作旨在建立一套全生态一致的威胁行为体画像与攻击路径图谱，从而赋能各研究实验室、开源项目维护者及安全防御方持续优化其缓解措施，并确保关键安全洞察在生态系统内高效流通。此外，我们正与外部团队合作开发[网络安全评估体系⁠（在新窗口中打开）](https://www.irregular.com/publications/spell-bound-technical-case-study)。我们期待，一个由独立机构构成的评估生态，将进一步推动业界对模型能力形成更深入、更共识性的理解。

Together, these efforts reflect our long-term commitment to strengthening the defensive side of the ecosystem. As models become more capable, our goal is to help ensure those capabilities translate into real leverage for defenders—grounded in real-world needs, shaped by expert input, and deployed with care. Alongside this work, we plan to explore other initiatives and cyber security grants to help surface breakthrough ideas that may not emerge from traditional pipelines, and to crowdsource bold, creative defenses from across academia, industry, and the open-source community. Taken together, this is ongoing work, and we expect to keep evolving these programs as we learn what most effectively advances real-world security.

上述各项举措共同体现了我们长期致力于强化整个生态防御能力的坚定承诺。随着模型能力不断增强，我们的目标是确保这些能力切实转化为防御方的真实优势——这一转化过程以现实世界的安全需求为根基，由领域专家深度参与塑造，并以审慎负责的方式部署落地。与此同时，我们还将探索其他创新项目与网络安全专项资助计划，旨在发掘那些难以通过传统研发路径涌现的突破性构想，并面向学术界、产业界及开源社区广泛征集大胆而富有创造力的防御方案。需要强调的是，这是一项持续演进的工作；我们将基于实践反馈不断迭代优化相关项目，以确保其始终服务于真实世界安全水平的有效提升。

- [2025](https://openai.com/news/?tags=2025)  
- [2025](https://openai.com/news/?tags=2025)

- [Policies and Procedures](https://openai.com/news/?tags=policies-procedures)  
- [政策与规程](https://openai.com/news/?tags=policies-procedures)