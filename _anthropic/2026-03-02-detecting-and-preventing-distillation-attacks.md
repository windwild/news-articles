---
title: "Detecting and preventing distillation attacks "
source: "Anthropic News"
url: "https://www.anthropic.com/news/detecting-and-preventing-distillation-attacks"
scraped_at: "2026-03-02T09:21:04.894203897+00:00"
language: "en-zh"
translated: true
description: "Anthropic is an AI safety and research company that's working to build reliable, interpretable, and steerable AI systems."
tags: ["Announcements"]
---

Announcements

公告

# Detecting and preventing distillation attacks

# 检测与防范蒸馏攻击

Feb 23, 2026

2026年2月23日

![Detecting and preventing distillation attacks ](images/detecting-and-preventing-distillation-attacks/img_001.svg)

![检测与防范蒸馏攻击](images/detecting-and-preventing-distillation-attacks/img_001.svg)

We have identified industrial-scale campaigns by three AI laboratories—DeepSeek, Moonshot, and MiniMax—to illicitly extract Claude’s capabilities to improve their own models. These labs generated over 16 million exchanges with Claude through approximately 24,000 fraudulent accounts, in violation of our terms of service and regional access restrictions.

我们已发现三个人工智能实验室——DeepSeek、Moonshot 和 MiniMax——开展了大规模工业级行动，非法提取 Claude 的能力以提升其自有模型。这些实验室通过约 24,000 个虚假账户，与 Claude 进行了逾 1,600 万次交互，严重违反了我们的服务条款及区域访问限制。

These labs used a technique called “distillation,” which involves training a less capable model on the outputs of a stronger one. Distillation is a widely used and legitimate training method. For example, frontier AI labs routinely distill their own models to create smaller, cheaper versions for their customers. But distillation can also be used for illicit purposes: competitors can use it to acquire powerful capabilities from other labs in a fraction of the time, and at a fraction of the cost, that it would take to develop them independently.

这些实验室采用了一种名为“知识蒸馏”（distillation）的技术，即利用更强大模型的输出来训练能力较弱的模型。知识蒸馏是一种被广泛使用且完全合法的训练方法。例如，前沿人工智能实验室通常会对自有模型进行蒸馏，从而为客户生成更小、更廉价的版本。但知识蒸馏也可能被用于非法目的：竞争对手可借此在远少于独立研发所需的时间和成本下，从其他实验室获取强大的能力。

These campaigns are growing in intensity and sophistication. The window to act is narrow, and the threat extends beyond any single company or region. Addressing it will require rapid, coordinated action among industry players, policymakers, and the global AI community.

此类行动正变得愈发频繁且复杂。采取应对措施的窗口期十分短暂，而相关威胁也早已超出任何单一公司或地区的范畴。要有效应对这一挑战，需要产业界、政策制定者以及全球人工智能社区迅速开展协同行动。

## Why distillation matters

## 为何知识蒸馏至关重要

Illicitly distilled models lack necessary safeguards, creating significant national security risks. Anthropic and other US companies build systems that prevent state and non-state actors from using AI to, for example, develop bioweapons or carry out malicious cyber activities. Models built through illicit distillation are unlikely to retain those safeguards, meaning that dangerous capabilities can proliferate with many protections stripped out entirely.

经非法蒸馏所得的模型往往缺乏必要的安全防护机制，从而构成重大的国家安全风险。Anthropic 及其他美国公司所构建的系统，旨在防止国家与非国家行为体将人工智能用于例如开发生物武器或实施恶意网络活动等目的。而通过非法蒸馏方式构建的模型极可能无法保留上述防护机制，这意味着危险能力可能大规模扩散，且大量原有保护措施将被彻底剥离。

Foreign labs that distill American models can then feed these unprotected capabilities into military, intelligence, and surveillance systems—enabling authoritarian governments to deploy frontier AI for offensive cyber operations, disinformation campaigns, and mass surveillance. If distilled models are open-sourced, this risk multiplies as these capabilities spread freely beyond any single government's control.

外国实验室若对美国模型实施蒸馏，便可将这些缺乏防护的能力注入其军事、情报及监控系统之中——使威权政府得以将前沿人工智能技术用于进攻性网络行动、虚假信息传播及大规模监控。倘若蒸馏所得模型被开源，该风险将进一步加剧，因为这些能力将不受任何单一政府管控而自由扩散。

## Distillation attacks and export controls

## 知识蒸馏攻击与出口管制

Anthropic has [consistently supported](https://www.anthropic.com/news/securing-america-s-compute-advantage-anthropic-s-position-on-the-diffusion-rule) export controls to help maintain America’s lead in AI. Distillation attacks undermine those controls by allowing foreign labs, including those subject to the control of the Chinese Communist Party, to close the competitive advantage that export controls are designed to preserve through other means.

Anthropic 一贯支持[出口管制政策](https://www.anthropic.com/news/securing-america-s-compute-advantage-anthropic-s-position-on-the-diffusion-rule)，以助力美国维持其在人工智能领域的领先地位。知识蒸馏攻击则削弱了此类管制效力：它使外国实验室（包括受中国共产党控制的实验室）得以绕过管制，通过其他途径弥补出口管制本意维护的竞争优势。

Without visibility into these attacks, the apparently rapid advancements made by these labs are incorrectly taken as evidence that export controls are ineffective and able to be circumvented by innovation. In reality, these advancements depend in significant part on capabilities extracted from American models, and executing this extraction at scale requires access to advanced chips. Distillation attacks therefore reinforce the rationale for export controls: restricted chip access limits both direct model training and the scale of illicit distillation.

若无法察觉此类攻击，外界便可能错误地将这些实验室表面呈现的快速进展，视作出口管制失效、且可通过技术创新轻易规避的证据。事实上，这些进展在很大程度上依赖于从美国模型中提取的能力；而实现大规模提取，则必须依赖先进芯片。因此，知识蒸馏攻击反而进一步印证了出口管制的合理性：对芯片获取的限制，既制约了直接的模型训练，也限制了非法蒸馏的规模。

## What we found

## 我们的发现

The three distillation campaigns detailed below followed a similar playbook, using fraudulent accounts and proxy services to access Claude at scale while evading detection. The volume, structure, and focus of the prompts were distinct from normal usage patterns, reflecting deliberate capability extraction rather than legitimate use.

以下详述的三次知识蒸馏行动均遵循相似的操作模式：利用虚假账户与代理服务规模化访问 Claude，同时规避检测。其提示词（prompts）在数量、结构与关注重点等方面均明显异于常规使用模式，体现出明确的、以能力提取为目的的行为，而非正当用途。

We attributed each campaign to a specific lab with high confidence through IP address correlation, request metadata, infrastructure indicators, and in some cases corroboration from industry partners who observed the same actors and behaviors on their platforms. Each campaign targeted Claude's most differentiated capabilities: agentic reasoning, tool use, and coding.

我们通过IP地址关联、请求元数据、基础设施指标，并在某些情况下结合行业合作伙伴在其平台上观察到的相同攻击者与行为，以高置信度将每场活动归因于特定实验室。每场活动均针对Claude最具差异化的三大能力：智能体式推理（agentic reasoning）、工具调用（tool use）以及编程能力（coding）。

### DeepSeek

### DeepSeek

_Scale: Over 150,000 exchanges_

_规模：逾15万次交互_

The operation targeted:

该活动针对以下方向：

- Reasoning capabilities across diverse tasks  
- 覆盖多种任务类型的推理能力  

- Rubric-based grading tasks that made Claude function as a reward model for reinforcement learning  
- 基于评分标准的评估类任务，使Claude充当强化学习中的奖励模型（reward model）  

- Creating censorship-safe alternatives to policy sensitive queries  
- 为政策敏感类查询生成符合审查要求的替代性回答  

DeepSeek generated synchronized traffic across accounts. Identical patterns, shared payment methods, and coordinated timing suggested “load balancing” to increase throughput, improve reliability, and avoid detection.

DeepSeek在多个账户间生成了同步流量。高度一致的行为模式、共用的支付方式以及协调一致的时间安排，表明其采用了“负载均衡”策略，旨在提升吞吐量、增强服务稳定性并规避检测。

In one notable technique, their prompts asked Claude to imagine and articulate the internal reasoning behind a completed response and write it out step by step—effectively generating chain-of-thought training data at scale. We also observed tasks in which Claude was used to generate censorship-safe alternatives to politically sensitive queries like questions about dissidents, party leaders, or authoritarianism, likely in order to train DeepSeek’s own models to steer conversations away from censored topics. By examining request metadata, we were able to trace these accounts to specific researchers at the lab.

其中一项典型技术是：其提示词（prompts）要求Claude构想并清晰阐述某条已完成回复背后的内在推理过程，并将其逐步写出——实质上实现了大规模链式思维（chain-of-thought）训练数据的自动生成。我们还观察到另一类任务：利用Claude生成对政治敏感问题（例如有关异见人士、政党领导人或威权主义的问题）的符合审查要求的替代性回答；此举极可能是为了训练DeepSeek自有模型，使其在对话中主动规避受审查话题。通过分析请求元数据，我们成功将这些账户追溯至该实验室内的具体研究人员。

### Moonshot AI

### Moonshot AI

_Scale: Over 3.4 million exchanges_

_规模：逾340万次交互_

The operation targeted:  
该活动针对：

- Agentic reasoning and tool use  
- 智能体推理与工具调用  

- Coding and data analysis  
- 编程与数据分析  

- Computer-use agent development  
- 计算机操作型智能体开发  

- Computer vision  
- 计算机视觉  

Moonshot (Kimi models) employed hundreds of fraudulent accounts spanning multiple access pathways. Varied account types made the campaign harder to detect as a coordinated operation. We attributed the campaign through request metadata, which matched the public profiles of senior Moonshot staff. In a later phase, Moonshot used a more targeted approach, attempting to extract and reconstruct Claude’s reasoning traces.  
月之暗面（Kimi 模型）动用了数百个虚假账户，这些账户通过多条访问路径接入系统。账户类型多样，使得该行动更难被识别为一次有组织的协同攻击。我们通过请求元数据将此次攻击归因于月之暗面——这些元数据与月之暗面高级员工公开的个人资料高度吻合。在后续阶段，月之暗面采用了更具针对性的策略，试图提取并重构 Claude 的推理过程痕迹。

### MiniMax  

### MiniMax  

_Scale: Over 13 million exchanges_  
_规模：逾 1300 万次交互_

The operation targeted:  
该行动针对以下方向：

- Agentic coding  
- 智能体编程  

- Tool use and orchestration  
- 工具调用与编排  

We attributed the campaign to MiniMax through request metadata and infrastructure indicators, and confirmed timings against their public product roadmap. We detected this campaign while it was still active—before MiniMax released the model it was training—giving us unprecedented visibility into the life cycle of distillation attacks, from data generation through to model launch. When we released a new model during MiniMax’s active campaign, they pivoted within 24 hours, redirecting nearly half their traffic to capture capabilities from our latest system.  
我们通过请求元数据与基础设施指标将此次攻击归因于 MiniMax，并结合其公开的产品路线图验证了攻击时间线。我们在该行动尚处于活跃阶段——即 MiniMax 尚未发布其正在训练的模型之前——即已成功检测到此次攻击，从而首次实现了对“蒸馏攻击”全生命周期的深度观测，涵盖从数据生成、模型训练直至最终发布的全过程。在我方于 MiniMax 攻击期间发布新模型后，对方在 24 小时内迅速调整策略，将近半数流量转向我方最新系统，以捕获其能力特征。

## How distillers access frontier models  

## 蒸馏者如何访问前沿模型  

For national security reasons, Anthropic does not currently offer commercial access to Claude in China, or to [subsidiaries of their companies](https://www.anthropic.com/news/updating-restrictions-of-sales-to-unsupported-regions) located outside of the country.  
出于国家安全考虑，Anthropic 目前未向中国境内提供 Claude 的商业访问权限，亦未向位于境外的[其公司子公司](https://www.anthropic.com/news/updating-restrictions-of-sales-to-unsupported-regions)提供此类服务。

To circumvent this, labs use commercial proxy services which resell access to Claude and other frontier AI models at scale. These services run what we call “hydra cluster” architectures: sprawling networks of fraudulent accounts that distribute traffic across our API as well as third-party cloud platforms. The breadth of these networks means that there are no single points of failure. When one account is banned, a new one takes its place. In one case, a single proxy network managed more than 20,000 fraudulent accounts simultaneously, mixing distillation traffic with unrelated customer requests to make detection harder.  
为规避上述限制，相关实验室转而使用商业化代理服务——这些服务大规模转售对 Claude 及其他前沿 AI 模型的访问权限。此类服务运行着我们称之为“九头蛇集群（hydra cluster）”的架构：即由大量虚假账户构成的庞大网络，将流量分散至我方 API 及第三方云平台。该网络覆盖范围极广，因而不存在单点故障；一旦某个账户被封禁，随即会有新账户取而代之。在某一案例中，单个代理网络同时运营超过 20,000 个虚假账户，且将蒸馏流量与真实客户的无关请求混杂在一起，极大增加了检测难度。

Once access is secured, the labs generate large volumes of carefully crafted prompts designed to extract specific capabilities from the model. The goal is either to collect high-quality responses for direct model training, or to generate tens of thousands of unique tasks needed to run reinforcement learning. What distinguishes a distillation attack from normal usage is the pattern. A prompt like the following (which approximates similar prompts we have seen used repetitively and at scale) may seem benign on its own:

> _You are an expert data analyst combining statistical rigor with deep domain knowledge. Your goal is to deliver data-driven insights — not summaries or visualizations — grounded in real data and supported by complete and transparent reasoning._

But when variations of that prompt arrive tens of thousands of times across hundreds of coordinated accounts, all targeting the same narrow capability, the pattern becomes clear. Massive volume concentrated in a few areas, highly repetitive structures, and content that maps directly onto what is most valuable for training an AI model are the hallmarks of a distillation attack.

一旦访问权限被获取，相关实验室便会生成大量精心设计的提示词（prompts），旨在从模型中提取特定能力。其目标要么是收集高质量响应以直接用于模型训练，要么是生成数以万计的独特任务，以支撑强化学习（reinforcement learning）的运行。区别蒸馏攻击（distillation attack）与常规使用的关键在于行为模式。如下所示的提示词（其形式近似于我们观察到的、被大规模重复使用的同类提示）单看可能并无异常：

> _你是一位资深数据分析师，兼具严谨的统计学功底与深厚的领域专业知识。你的目标是提供基于数据驱动的深度洞见——而非简单摘要或可视化图表——这些洞见必须扎根于真实数据，并辅以完整、透明的推理过程。_

然而，当此类提示词的各类变体通过数百个协同运作的账户，以数万次的频次集中发送，且全部聚焦于同一狭窄能力时，其攻击模式便一目了然。少数能力维度上出现的海量请求、高度雷同的提示结构，以及内容本身与AI模型训练最具价值的数据高度吻合——这些特征共同构成了蒸馏攻击的典型标志。

## How we’re responding

## 我们的应对措施

We continue to invest heavily in defenses that make such distillation attacks harder to execute and easier to identify. These include:

我们持续大力投入防御能力建设，以提高此类蒸馏攻击的实施难度，并增强其可识别性。具体措施包括：

- **Detection**. We have built several classifiers and behavioral fingerprinting systems designed to identify distillation attack patterns in API traffic. This includes detection of chain-of-thought elicitation used to construct reasoning training data. We have also built detection tools for identifying coordinated activity across large numbers of accounts.

- **检测能力**：我们已构建多套分类器及行为指纹识别系统，专门用于在API流量中识别蒸馏攻击模式。这包括对“思维链”（chain-of-thought）引导行为的检测——此类行为常被用于构造推理类训练数据；同时，我们也开发了可识别跨大量账户协同活动的检测工具。

- **Intelligence sharing** _._ We are sharing technical indicators with other AI labs, cloud providers, and relevant authorities. This provides a more holistic picture into the distillation landscape.

- **情报共享**：我们正向其他AI实验室、云服务提供商及有关监管机构共享技术指标（technical indicators），从而构建更全面的蒸馏攻击态势感知图景。

- **Access controls**. We’ve strengthened verification for educational accounts, security research programs, and startup organizations—the pathways most commonly exploited for setting up fraudulent accounts.

- **访问控制**：我们已加强对教育类账户、安全研究项目及初创企业组织的资质核验——这些渠道正是欺诈性账户最常利用的注册路径。

- **Countermeasures**. We are developing Product, API and model-level safeguards designed to reduce the efficacy of model outputs for illicit distillation, without degrading the experience for legitimate customers.

- **反制措施**：我们正在产品层、API层和模型层同步研发多重防护机制，旨在削弱模型输出被滥用于非法蒸馏的有效性，同时确保合法用户的使用体验不受影响。

But no company can solve this alone. As we noted above, distillation attacks at this scale require a coordinated response across the AI industry, cloud providers, and policymakers. We are publishing this to make the evidence available to everyone with a stake in the outcome.

但没有任何一家公司能够独自解决这一问题。如前所述，如此规模的蒸馏攻击亟需人工智能行业、云服务提供商及政策制定者协同应对。我们发布本文，旨在将相关证据公开，供所有利益相关方参考。