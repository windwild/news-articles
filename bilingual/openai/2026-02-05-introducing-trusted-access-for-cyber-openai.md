---
title: "Introducing Trusted Access for Cyber | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/trusted-access-for-cyber"
date: "2026-02-05"
scraped_at: "2026-03-02T10:08:21.799272345+00:00"
language: "en-US"
translated: true
description: "OpenAI introduces Trusted Access for Cyber, a trust-based framework that expands access to frontier cyber capabilities while strengthening safeguards against misuse."
tags: ["Security"]
---

February 5, 2026

2026年2月5日

[Security](https://openai.com/news/security/) [Safety](https://openai.com/news/safety-alignment/)

[安全](https://openai.com/news/security/) [安全与对齐](https://openai.com/news/safety-alignment/)

# Introducing Trusted Access for Cyber

# 推出“网络安全可信访问”计划

Our approach to enhancing baseline safeguards for all users while piloting trusted access for defensive acceleration.

我们在全面提升所有用户基础防护能力的同时，试点推行“可信访问”机制，以加速防御性能力的落地应用。

[GPT‑5.3‑Codex](https://openai.com/index/introducing-gpt-5-3-codex/) is our most cyber-capable frontier reasoning model to date. Cybersecurity is one of the clearest places where that progress can both meaningfully strengthen the broader ecosystem and introduce new risks. We’ve moved from models that can auto-complete a few lines in a code editor, to models that can work autonomously for hours or even days to accomplish complex tasks. These capabilities can dramatically strengthen cyber defense by accelerating vulnerability discovery and remediation.

[GPT‑5.3‑Codex](https://openai.com/index/introducing-gpt-5-3-codex/) 是我们迄今最具网络安全能力的前沿推理模型。网络安全正是这一技术进步最能显著增强整体生态韧性、同时也最易引入新型风险的关键领域之一。我们的模型已从仅能在代码编辑器中自动补全几行代码，发展为可连续数小时乃至数天自主运行、完成复杂任务的智能体。此类能力可通过加速漏洞发现与修复，极大强化网络防御体系。

To unlock the full defensive potential of these capabilities while reducing the risk of misuse, we are piloting Trusted Access for Cyber: an identity and trust-based framework designed to help ensure enhanced cyber capabilities are being placed in the right hands. This reflects our broader [approach⁠](https://openai.com/index/strengthening-cyber-resilience/) to responsibly deploying highly capable models. In addition, we are committing $10 million in API credits to accelerate cyber defense.

为充分释放上述能力的防御潜力，同时降低滥用风险，我们正试点推出“网络安全可信访问”（Trusted Access for Cyber）：一种基于身份认证与信任评估的框架，旨在确保增强型网络安全能力被交付至真正值得信赖的使用者手中。此举体现了我们更广泛的[负责任部署高能力模型的方法论](https://openai.com/index/strengthening-cyber-resilience/)。此外，我们将投入1000万美元API信用额度，以加速网络防御能力建设。

## Expanding access to frontier models for cyber defense

## 扩大前沿模型在网络安全防御领域的可及性

It is very important the world adopts frontier cyber capabilities quickly to make software more secure and continue to raise the bar of security best practices. Highly capable models can help organizations of all sizes strengthen their security posture, reduce response times, and improve resilience, while enabling security professionals to better detect, analyze, and defend against the most severe and targeted attacks. These advances have the potential to meaningfully raise the baseline of cyber defense across the ecosystem if they are put to work in the hands of people focused on protection and prevention.

全球亟需快速采纳前沿网络安全能力，以提升软件安全性，并持续抬升安全最佳实践的标准。高能力模型可助力各类规模的组织强化其安全态势、缩短响应时间、增强系统韧性；同时赋能安全专业人员更精准地检测、分析并抵御最严重、最具针对性的网络攻击。若这些技术进步能交由专注于防护与预防的专业人士实际应用，将有望切实提升整个生态系统的网络防御基线水平。

There will soon be many cyber-capable models with broad availability from different providers, including open-weight models, and we believe it is critical that OpenAI’s models strengthen defensive capabilities from the outset. This is why we are launching a trust-based access pilot that prioritizes getting our most capable models and tools in the hands of defenders first.

不久之后，多家供应商（包括开源权重模型提供方）将陆续推出大量具备网络安全能力的模型，且普遍开放获取。我们认为，OpenAI 的模型必须从初始阶段即着力强化防御能力。正因如此，我们启动了基于信任的访问试点计划，优先将我们最强大的模型与工具交付给一线防御者使用。

It can be difficult to tell whether any particular cyber action is intended for defensive usage, or to cause harm. For example, “find vulnerabilities in my code” could be part of responsible patching and coordinated disclosure—or it could be used to identify software vulnerabilities to help exploit a system. Because of that ambiguity, restrictions intended to prevent harm have historically created friction for good-faith work. Our approach aims to reduce that friction while still preventing malicious activity.

判断某项具体网络行为究竟是出于防御目的，还是旨在造成损害，往往十分困难。例如，“在我代码中查找漏洞”这一请求，既可能是负责任的补丁修复与协调披露流程的一部分，也可能被用于识别软件漏洞，进而协助攻击系统。正因这种模糊性，历史上为防止危害而设置的限制措施，常常给善意的安全工作带来阻碍。我们的方法旨在减轻此类阻碍，同时依然有效遏制恶意活动。

## Trust-based approach to frontier cyber capabilities

## 基于信任的前沿网络能力治理方式

Frontier models like GPT‑5.3‑Codex have been designed with mitigations like training the model to refuse clearly malicious requests like stealing credentials. In addition to safety training, automated classifier-based monitors will detect potential signals of suspicious cyber activity. Developers and security professionals doing cybersecurity-related work may be impacted by these mitigations, while we calibrate our policies and classifiers.

诸如 GPT‑5.3‑Codex 这类前沿模型，在设计之初即已嵌入多项缓解措施，例如训练模型拒绝明显恶意的请求（如窃取凭据）。除安全训练外，我们还将部署基于自动分类器的监测系统，以识别潜在的可疑网络活动信号。在我们持续校准政策与分类器的过程中，从事网络安全相关工作的开发者和安全专业人士可能暂时受到这些缓解措施的影响。

To use models for potentially high-risk cybersecurity work:

为将模型用于潜在高风险的网络安全工作：

- Users can verify their identity at [chatgpt.com/cyber⁠(opens in a new window)](http://chatgpt.com/cyber?openaicom-did=308e8a81-79cc-4c1b-a24f-db12029455f5&openaicom_referred=true)  
- 用户可通过 [chatgpt.com/cyber⁠（在新窗口中打开）](http://chatgpt.com/cyber?openaicom-did=308e8a81-79cc-4c1b-a24f-db12029455f5&openaicom_referred=true) 验证身份  

- Enterprises can [request trusted access](https://openai.com/form/enterprise-trusted-access-for-cyber/) for their entire team by default through their OpenAI representative  
- 企业客户可默认通过其 OpenAI 客户代表，[申请团队级可信访问权限](https://openai.com/form/enterprise-trusted-access-for-cyber/)  

Security researchers and teams who may need access to even more cyber capable or permissive models to accelerate legitimate defensive work can express interest in our [invite-only program⁠(opens in a new window)](https://docs.google.com/forms/d/e/1FAIpQLSea_ptovrS3xZeZ9FoZFkKtEJFWGxNrZb1c52GW4BVjB2KVNA/viewform?usp=header). Users with trusted access must still abide by our [Usage Policies⁠](https://openai.com/policies/usage-policies/) and [Terms of Use⁠](https://openai.com/policies/row-terms-of-use/).

对于需要更强网络能力或更高权限模型以加速合法防御工作的安全研究人员及团队，可表达参与我们[仅限邀请的计划⁠（在新窗口中打开）](https://docs.google.com/forms/d/e/1FAIpQLSea_ptovrS3xZeZ9FoZFkKtEJFWGxNrZb1c52GW4BVjB2KVNA/viewform?usp=header) 的意向。获得可信访问权限的用户仍须严格遵守我们的[《使用政策》⁠](https://openai.com/policies/usage-policies/) 和[《服务条款》⁠](https://openai.com/policies/row-terms-of-use/)。

This approach is designed to reduce friction for defenders while preventing prohibited behavior, including data exfiltration, malware creation or deployment, and destructive or unauthorized testing. We expect to evolve our mitigation strategy and Trusted Access for Cyber over time based on what we learn from early participants.

该方法旨在降低防御者开展工作的阻力，同时杜绝包括数据窃取、恶意软件创建或部署、以及破坏性或未授权测试在内的各类禁止行为。我们将根据早期参与者的反馈与实践经验，持续优化缓解策略及“网络安全可信访问”机制。

## Scaling the Cybersecurity Grant Program

## 扩大规模：网络安全资助计划

To further accelerate the use of our frontier models for defensive cybersecurity work, we are committing $10 million in API credits for teams through our Cybersecurity Grant Program. We’re looking to partner with teams that have a proven track record of identifying and remediating vulnerabilities in open source software and critical infrastructure systems—teams can apply [here⁠](https://openai.com/form/cybersecurity-grant-program/).

为进一步加速前沿模型在防御型网络安全工作中的应用，我们将在“网络安全资助计划”框架下，向符合条件的团队提供总计 1000 万美元的 API 积分支持。我们诚挚寻求与已在开源软件及关键基础设施系统中展现出成熟漏洞识别与修复能力的团队展开合作——团队可在此[提交申请⁠](https://openai.com/form/cybersecurity-grant-program/)。

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)