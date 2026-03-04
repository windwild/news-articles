---
title: "Introducing EVMbench | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-evmbench"
date: "2026-02-18"
scraped_at: "2026-03-02T10:08:18.698939620+00:00"
language: "en-US"
translated: true
description: "OpenAI and Paradigm introduce EVMbench, a benchmark evaluating AI agents’ ability to detect, patch, and exploit high-severity smart contract vulnerabilities."
tags: ["Research"]
---
{% raw %}

February 18, 2026

2026年2月18日

[Research](https://openai.com/news/research/) [Publication](https://openai.com/research/index/publication/)

[研究](https://openai.com/news/research/) [出版物](https://openai.com/research/index/publication/)

# Introducing EVMbench

# 推出 EVMbench

Making smart contracts safer by evaluating AI agents’ ability to detect, patch, and exploit vulnerabilities in blockchain environments.

通过评估 AI 智能体在区块链环境中检测、修复及利用智能合约漏洞的能力，提升智能合约的安全性。

[Read the paper(opens in a new window)](https://cdn.openai.com/evmbench/evmbench.pdf)

[阅读论文（在新窗口中打开）](https://cdn.openai.com/evmbench/evmbench.pdf)

Smart contracts routinely secure $100B+ in open-source crypto assets. As AI agents improve at reading, writing, and executing code, it becomes increasingly important to measure their capabilities in economically meaningful environments, and to encourage the use of AI systems defensively to audit and strengthen deployed contracts.

智能合约 routinely 保障着逾 1000 亿美元的开源加密资产安全。随着 AI 智能体在读取、编写和执行代码方面能力的持续提升，在具备实际经济意义的环境中衡量其能力变得愈发重要；同时，也亟需鼓励以防御性方式部署 AI 系统，用于审计和强化已上线的智能合约。

Together with [Paradigm⁠(opens in a new window)](https://www.paradigm.xyz/), we’re introducing EVMbench, a benchmark evaluating the ability of AI agents to detect, patch, and exploit high-severity smart contract vulnerabilities. EVMbench draws on 120 curated vulnerabilities from 40 audits, with most sourced from open code audit competitions.  EVMbench additionally includes several vulnerability scenarios drawn from the security auditing process for the [Tempo⁠(opens in a new window)](https://tempo.xyz/) blockchain, a purpose-built L1 designed to enable high-throughput, low-cost payments via stablecoins. These scenarios extend the benchmark into payment-oriented smart contract code, where we expect agentic stablecoin payments to grow, and help ground it in a domain of emerging practical importance.

我们携手 [Paradigm（在新窗口中打开）](https://www.paradigm.xyz/)，共同推出 EVMbench —— 一个用于评估 AI 智能体检测、修复及利用高危智能合约漏洞能力的基准测试套件。EVMbench 汇集了来自 40 次安全审计的 120 个精选漏洞，其中大多数源自公开的代码审计竞赛。此外，EVMbench 还纳入了若干源自 [Tempo（在新窗口中打开）](https://tempo.xyz/) 区块链安全审计流程的漏洞场景。Tempo 是专为稳定币高频、低成本支付而设计的 Layer-1 公链。这些场景将基准测试拓展至面向支付场景的智能合约代码领域——我们预期在此领域，由智能体驱动的稳定币支付将快速增长；此举亦使该基准测试扎根于一个日益凸显实际重要性的应用领域。

To create our task environments, we adapted existing proof-of-concept exploit tests and deployment scripts, when they existed, and otherwise manually wrote them. For the patch mode, we ensured that the vulnerabilities are exploitable and that can be mitigated without introducing compilation-breaking changes, which would compromise our setup. For the exploit mode, we wrote custom graders and red-teamed the environments in an attempt to find and patch methods by which an agent might cheat the grader. In addition to task quality control via domain expertise provided by Paradigm, we used automated task auditing agents to help increase the soundness of our environments.

为构建任务环境，我们在已有可用的前提下，复用并适配了现有概念验证（PoC）漏洞利用测试与部署脚本；其余部分则全部手动编写。在“修复模式”（patch mode）下，我们确保所选漏洞确实可被利用，且可通过修复予以缓解，同时不引入导致编译失败的变更——此类变更将破坏我们的实验设定。在“利用模式”（exploit mode）下，我们开发了定制化评分器（graders），并对环境开展红队演练（red-teaming），力求识别并修补智能体可能用于欺骗评分器的各类手段。除依托 Paradigm 提供的专业领域知识对任务质量进行严格把关外，我们还引入自动化任务审计智能体，进一步增强任务环境的严谨性与可靠性。

EVMbench evaluates three capability modes:

EVMbench 评估以下三种能力模式：

- **Detect**: Agents audit a smart contract repository and are scored on recall of ground-truth vulnerabilities and associated audit rewards.  
- **检测**：智能体对智能合约代码仓库进行审计，其评分依据为对真实漏洞（ground-truth vulnerabilities）的检出率（召回率）以及相应的审计奖励。

- **Patch**: Agents modify vulnerable contracts and must preserve intended functionality while eliminating exploitability, verified through automated tests and exploit checks.  
- **修复**：智能体修改存在漏洞的合约，在彻底消除可利用性的同时必须保持原有功能不变；该目标通过自动化测试与漏洞利用检查予以验证。

- **Exploit**: Agents execute end-to-end fund-draining attacks against deployed contracts on a sandboxed blockchain environment, with grading performed programmatically via transaction replay and on-chain verification.  
- **利用**：智能体在沙盒化区块链环境中，对已部署合约发起端到端的资金盗取攻击；评分通过程序化交易重放与链上验证自动完成。

To support objective and reproducible evaluation, we developed a Rust-based harness that deploys contracts, replays agent transactions deterministically, and restricts unsafe RPC methods. Exploit tasks run in an isolated local Anvil environment rather than on live networks, and vulnerabilities are historical and publicly documented.  
为支持客观、可复现的评估，我们开发了一个基于 Rust 的测试框架（harness），用于部署合约、确定性地重放智能体发起的交易，并限制不安全的 RPC 方法调用。利用类任务（exploit tasks）运行于隔离的本地 Anvil 环境中，而非真实网络；所含漏洞均为历史上真实发生、且已公开披露的案例。

We evaluate frontier agents across all three modes. In the **‘exploit’** mode, GPT‑5.3‑Codex running via Codex CLI achieves a score of 72.2%. This represents a significant gain over previous models, such as GPT‑5, which scores 31.9% and was released just over six months ago. The detect recall and patch success rates remain below full coverage, as a large fraction of vulnerabilities remain difficult for agents to find and fix.  
我们在全部三种模式下对前沿智能体进行评估。在 **“利用”** 模式中，通过 Codex CLI 运行的 GPT‑5.3‑Codex 达到 72.2% 的得分。相较仅发布六个多月前的 GPT‑5（得分为 31.9%），这一提升极为显著。而“检测”的漏洞召回率与“修复”的成功率仍未达到全覆盖水平，因为大量漏洞对当前智能体而言依然难以发现和修复。

EVMbench also reveals interesting differences in model behavior across tasks. Agents perform best in the exploit setting, where the objective is explicit: continue iterating until funds are drained. In contrast, performance is weaker on detect and patch tasks. In **‘detect’**, agents sometimes stop after identifying a single issue rather than exhaustively auditing the codebase. In **‘patch’**, maintaining full functionality while removing subtle vulnerabilities remains challenging.  
EVMbench 还揭示了模型在不同任务中行为的有趣差异：智能体在“利用”任务中表现最佳——其目标明确：持续迭代直至成功盗取资金。相比之下，“检测”与“修复”任务的表现较弱。在 **“检测”** 中，智能体常在识别出单个问题后即停止，未能对整个代码库开展全面审计；在 **“修复”** 中，如何在剔除隐蔽漏洞的同时完整保留原有功能，仍是巨大挑战。

## Limitations  
## 局限性

EVMbench does not represent the full difficulty of real-world smart contract security. The vulnerabilities included were drawn from Code4rena auditing competitions. While these are realistic and high-severity, many heavily deployed and widely used crypto contracts undergo significantly more scrutiny and may be harder to exploit.  
EVMbench 并未完全反映现实世界中智能合约安全问题的全部难度。所纳入的漏洞均源自 Code4rena 审计竞赛。尽管这些漏洞真实存在且危害等级高，但许多已被大规模部署、广泛使用的加密协议合约，往往经历更为严苛的多重审查，实际利用难度可能更高。

Our grading system is robust but imperfect. In **‘detect’** mode, we check whether the agent finds the same vulnerabilities identified by human auditors. If the agent identifies additional issues, we do not currently have a reliable way to determine whether they represent true vulnerabilities that humans missed or false positives.  
我们的评分体系稳健但尚不完美。在 **“检测”** 模式中，我们仅核查智能体是否发现了人类审计员所确认的相同漏洞；若智能体额外识别出其他问题，目前尚无可靠方法判断这些问题是人类遗漏的真实漏洞，还是误报（false positives）。

There are also structural limitations in the **‘exploit’** setting. Transactions are replayed sequentially in the grading container, so behaviors that depend on precise timing mechanics are out of scope. The chain state is a clean local Anvil instance rather than a fork of mainnet, and we currently support only single-chain environments. In some cases this requires mock contracts instead of mainnet deployments.  
**“利用”** 场景还存在结构性局限：评分容器中交易按顺序重放，因此依赖精确时间机制（如时间戳依赖、矿工可操控性 MEV 相关行为等）的行为不在评估范围内。链状态基于干净的本地 Anvil 实例，而非主网（mainnet）分叉；目前仅支持单链环境。在某些情况下，这要求使用模拟合约（mock contracts），而非直接对接主网部署。

## Why this matters  
## 为何这至关重要

Smart contracts secure billions of dollars in assets, and AI agents are likely to be transformative for both attackers and defenders. Measuring model capability in this domain helps track emerging cyber risks and highlights the importance of using AI systems defensively to audit and strengthen deployed contracts.  
智能合约守护着数十亿美元的数字资产，而 AI 智能体极有可能从根本上重塑攻击者与防御者双方的能力格局。在此领域精准衡量模型能力，不仅有助于追踪新兴网络风险，更凸显出以 AI 系统开展防御性应用的关键意义——即主动审计并加固已部署的合约。

EVMbench is intended both as a measurement tool and as a call to action. As agents improve, it becomes increasingly important for developers and security researchers to incorporate AI-assisted auditing into their workflows.

EVMbench 既是一个评估工具，也是一份行动倡议。随着智能体（agents）能力的不断提升，开发者与安全研究人员将 AI 辅助审计纳入自身工作流程，正变得愈发重要。

Over recent months, we’ve seen meaningful gains in model performance on cybersecurity tasks, benefiting both developers and security professionals. In parallel, we’ve been [preparing strengthened cyber safeguards](https://openai.com/index/strengthening-cyber-resilience/) to support defensive use and broader ecosystem resilience.

过去数月间，我们在模型执行网络安全任务方面的性能取得了显著提升，使开发者与安全专业人士均从中受益。与此同时，我们一直在[加强网络防护措施](https://openai.com/index/strengthening-cyber-resilience/)，以支持防御性应用，并增强整个生态系统的韧性。

Because cybersecurity is inherently dual-use, we’re taking an evidence-based, iterative approach that accelerates defenders’ ability to find and fix vulnerabilities while slowing misuse. Our mitigations include safety training, automated monitoring, [trusted access](https://openai.com/index/trusted-access-for-cyber/) for advanced capabilities, and enforcement pipelines including threat intelligence.

鉴于网络安全技术本质上具有“双重用途”（dual-use）特性，我们采取一种基于实证、持续迭代的方法：一方面加速防御方发现并修复漏洞的能力，另一方面延缓其被滥用的风险。我们的缓解措施包括安全性训练、自动化监控、面向高级能力的[可信访问机制](https://openai.com/index/trusted-access-for-cyber/)，以及涵盖威胁情报的执法管道（enforcement pipelines）。

We’re investing in ecosystem safeguards such as expanding the private beta of [Aardvark](https://openai.com/index/introducing-aardvark/), our security research agent, and partnering with open-source maintainers to provide free codebase scanning for widely used projects.

我们正加大对生态系统防护能力的投资，例如扩大我们安全研究智能体 [Aardvark](https://openai.com/index/introducing-aardvark/) 的私有测试范围，并与开源项目维护者合作，为广泛使用的开源项目提供免费的代码库扫描服务。

Building on our Cybersecurity Grant Program launched in 2023, we’re also committing $10M in API credits to accelerate cyber defense with our most capable models, especially for open source software and critical infrastructure systems. Organizations engaged in good-faith security research can apply for API credits and support through our [Cybersecurity Grant Program](https://openai.com/form/cybersecurity-grant-program/).

在 2023 年启动的“网络安全资助计划”（Cybersecurity Grant Program）基础上，我们进一步承诺投入 1000 万美元的 API 积分（API credits），以借助我们最强大的模型加速网络防御能力建设——尤其面向开源软件及关键基础设施系统。致力于善意安全研究的组织，可通过我们的[网络安全资助计划](https://openai.com/form/cybersecurity-grant-program/)申请 API 积分及相关支持。

We release EVMbench’s tasks, tooling, and evaluation framework to support continued research on measuring and managing emerging AI cyber capabilities.

我们开源 EVMbench 的评测任务、配套工具及评估框架，以支持学界与业界持续开展关于新兴 AI 网络能力的量化评估与风险管理研究。
{% endraw %}
