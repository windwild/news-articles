---
render_with_liquid: false
title: "Confidential Inference via Trusted Virtual Machines"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/confidential-inference-trusted-vms"
date: "2025-06-18"
scraped_at: "2026-03-03T06:44:16.265629277+00:00"
language: "en-zh"
translated: true
description: "Announcing a new collaborative research paper on Confidential Inference, a set of tools to improve the security of our model weights and of our users' data"
---
render_with_liquid: false
render_with_liquid: false

Announcements

公告

# Confidential Inference via Trusted Virtual Machines

# 通过可信虚拟机实现机密推理

Jun 18, 2025

2025年6月18日

[Read the paper](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf)

[阅读论文](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf)

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们分析了数千场 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流利度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

Every day, millions of users [entrust](https://trust.anthropic.com/) Claude with sensitive information—from proprietary code to confidential business strategies. At Anthropic, we’re researching and building new technology to ensure that our users’ trust is warranted—and in fact, to ensure that their trust is cryptographically guaranteed.

每天，数百万用户将敏感信息——从专有代码到机密商业策略——[托付](https://trust.anthropic.com/)给 Claude。在 Anthropic，我们正持续开展前沿研究并构建新技术，以确保用户对我们的信任确有依据；更进一步，确保这种信任能通过密码学手段得到坚实保障。

What do we mean by “cryptographically guaranteed”? In a [new report](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf) published in collaboration with [Pattern Labs](https://www.patternlabs.co/), we describe the mechanics of Confidential Inference. Confidential Inference is a set of tools we can use to process encrypted data and to show that such data is only readable within servers that can prove themselves trustworthy. There are two main reasons to adopt these tools:

我们所说的“密码学保障”究竟意味着什么？在我们与 [Pattern Labs](https://www.patternlabs.co/) 联合发布的 [新报告](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf) 中，我们详细阐述了“机密推理”（Confidential Inference）的技术原理。机密推理是一套工具集，使我们能够直接处理加密数据，并证明：此类数据仅可在那些能自证其可信性的服务器内部被解密和读取。采用这些工具主要有两大原因：

- Model Weight Security: We can use Confidential Inference as one component of our broader effort to secure frontier models like Claude against increasingly capable threat actors, such as those described in the recent report from RAND on [Securing AI Model Weights](https://www.rand.org/pubs/research_reports/RRA2849-1.html);  
- 模型权重安全：我们可以将“机密推理（Confidential Inference）”作为更广泛安全战略的一个组成部分，用以保护Claude等前沿模型，抵御能力日益增强的威胁行为者——例如RAND近期发布的报告《[保障AI模型权重安全](https://www.rand.org/pubs/research_reports/RRA2849-1.html)》中所描述的攻击者；

- User Security: We can use Confidential Inference to prove that sensitive user data is kept private.  
- 用户安全：我们可利用机密推理来证明敏感用户数据始终得到隐私保护。

We're sharing this post, and the accompanying [report](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf), to explain what Confidential Inference is and the benefits it could offer our users. We also want to share how we're thinking about the security of the systems involved. This is just a sketch of our research to start a conversation; we’re still early in this work and it is too soon to forecast how it will evolve into specific designs or features we might offer in the future.  
我们发布本文及配套的[技术报告](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf)，旨在阐明“机密推理”是什么，以及它可能为用户带来的益处。同时，我们也希望分享我们对相关系统安全性的整体思考。本文仅是对当前研究工作的初步勾勒，意在开启一场对话；目前这项工作尚处于早期阶段，还远未到能够预测其未来将如何演变为具体设计方案或产品功能的程度。

The following sections provide some of the technical details for the implementation of Confidential Inference. The key takeaway is that we're building systems designed to help ensure your sensitive data remains encrypted everywhere except for the exact moment it needs to be processed—and even then, only within a highly restricted, verifiable environment.  
以下章节介绍了机密推理实现过程中的部分技术细节。核心要点在于：我们正在构建一类系统，旨在确保您的敏感数据**全程加密存储与传输**，仅在真正需要处理的**那一瞬间**才解密——且即便在此刻，解密与处理操作也严格限定于一个高度受限、可验证的安全环境中。

## Inference service  
## 推理服务  

The guiding principle behind Confidential Inference is that sensitive data should remain encrypted except at the point where it's processed. To enforce this, we use the established methods of confidential computing. This means we build a chain of trust that attests to the security of our software, and then use that attestation to enforce rules about exactly which software is allowed to use the encryption keys.  
机密推理的核心原则是：敏感数据应始终保持加密状态，**仅在实际执行处理操作的那一刻才解密**。为落实这一原则，我们采用业界成熟的“机密计算（confidential computing）”方法：即构建一条可信链（chain of trust），对软件自身的安全性进行可信认证（attestation），并基于该认证结果，严格管控哪些软件组件被授权使用加密密钥。

For user data, there are two points where we need to operate on the sensitive cleartext (that is, on text that isn’t encrypted or otherwise obscured in any way):  
对于用户数据，存在两个必须操作明文（即未经任何加密或混淆处理的原始文本）的关键环节：

- The API Server. This server handles a prompt, transforms it into tokens, and operates most of the logic behind a Claude API request;  
- API服务器：负责接收用户提示（prompt）、将其转换为token，并执行Claude API请求背后的大部分逻辑；

- The Inference Server. This server runs the “brains” of Claude on hardware accelerators to generate completion tokens from the prompt.  
- 推理服务器：在硬件加速器上运行Claude的“核心推理引擎”，根据输入提示生成补全token。

For model weights, only the Inference Server receives sensitive data.  
而对于模型权重，仅有推理服务器会接触敏感数据。

We'll focus on the Inference Server for this post—the security of the API Server is equally important, but beyond the scope of what we're trying to describe. Because not all accelerators fully support confidential computing yet, we’re exploring an Inference Server implemented on top of a small, secure "model loader and invoker", which can run within a trusted environment. This loader program performs a few simple jobs:  
本文将聚焦于推理服务器——API服务器的安全性同样至关重要，但不在本文讨论范围内。由于并非所有硬件加速器目前已完全支持机密计算，我们正探索一种新型推理服务器架构：其底层是一个轻量、安全的“模型加载与调用器（model loader and invoker）”，该组件可在可信执行环境（TEE）中运行。该加载器程序承担以下几项简单而关键的任务：

- Accept encrypted data, decrypt it, and send to the accelerator;  
- 接收加密数据，在可信环境中解密，并将明文发送至加速器；

- Invoke calls against the accelerator, and return the encrypted results to the caller.  
- 向加速器发起调用，并将加速器返回的**加密结果**传回调用方。

Only the "trusted" loader is able to access decrypted data. The rest of the system is "untrusted", but can send requests to the loader.

只有“可信”加载器能够访问解密后的数据；系统其余部分均为“不可信”，但可向该加载器发送请求。

We're working on a system based on this design for our own implementation. For this implementation, the majority of our Inference Server runs on the "untrusted" side—where it might change frequently, but where changes cannot affect the security of the system as a whole. We have a small trusted loader, running on a separate virtual machine isolated by the hypervisor. The loader presents itself to the Inference Server as a "virtual accelerator", agnostic to model architecture details. This "virtual accelerator" only accepts programs that have been signed by our secure continuous integration server, which ensures that any code that's run has been reviewed by multiple engineers.

我们正基于这一设计构建自有系统。在本实现中，推理服务器（Inference Server）的主体运行于“不可信”侧——该部分可能频繁变更，但其任何变更均不会影响整个系统的安全性。我们部署了一个轻量级的可信加载器，运行于由虚拟机监控器（hypervisor）隔离的独立虚拟机中。该加载器向推理服务器呈现为一个与模型架构细节无关的“虚拟加速器”。此“虚拟加速器”仅接受经我方安全持续集成（CI）服务器签名的程序，从而确保所有实际运行的代码均已由多名工程师审查。

The end result is to ensure that, should the loader be run correctly, our confidentiality requirements are met _no matter what the rest of the system does_. It’s therefore critical to establish that the loader is run correctly.

最终目标是：只要加载器被正确运行，无论系统其余部分如何行为，我们的机密性要求均能得到满足。因此，确认加载器是否被正确运行至关重要。

## Trusted environment

## 可信执行环境

The report describes the loader running in a confidential computing environment with a specific set of features:

报告描述了加载器在具备特定能力的机密计算（confidential computing）环境中运行：

1. Encrypted memory, isolated by hardware from other workloads;  
1. 内存加密，并通过硬件与其他工作负载隔离；  

2. Disabled debugging features;  
2. 调试功能已禁用；  

3. Cryptographic proof that the correct code is being run.  
3. 提供密码学证明，证实正在运行的是预期的正确代码。  

(1) Protects against some forms of physical attack and against a malicious hypervisor, but the features required to share encrypted host memory with an accelerator aren't well established as of yet. We'll continue to work on closing this gap, but in the meantime we'll rely on our compute providers to maintain security at the physical datacenter and in hypervisor software.

（1）可抵御某些类型的物理攻击及恶意虚拟机监控器（hypervisor）攻击；但目前尚无成熟方案支持将加密的主机内存安全地共享给加速器。我们将持续努力弥补这一技术缺口；与此同时，则依赖计算服务提供商保障物理数据中心及虚拟机监控器软件层面的安全。

(2) and (3) can be achieved through widely supported confidential computing practices, using a trusted platform module (TPM) as the root of trust. The TPM measures each stage of the boot process and reports a hash representing the final result. This hash forms an attestation that the loader server is isolated the way we expect, is running our signed and reviewed code, and is configured to disable the relevant debugging features. A keyserver can check this proof and only release decryption keys when the recipient has proven itself secure.

（2）和（3）可通过业界广泛支持的机密计算实践实现，以可信平台模块（TPM）作为信任根。TPM 会对启动过程的每一阶段进行度量，并输出一个代表最终状态的哈希值。该哈希值构成一项远程证明（attestation），表明加载器服务器已按预期实现隔离、正在运行经签名且经多人审核的代码，并已配置为禁用相关调试功能。密钥服务器（keyserver）可验证此项证明，仅当接收方成功自证其安全性后，才释放解密密钥。

The decision of whether an environment is “trusted” ultimately rests on the keyserver. We’re also exploring models of confidential computing where other parties validate the trusted code and manage independent keyservers. This could allow us to provide stronger confidentiality assurances for each piece of data.

某一环境是否属于“可信”环境，最终由密钥服务器判定。我们也在探索一类新型机密计算模式：由第三方对可信代码进行验证，并各自管理独立的密钥服务器。此类模式有望为每一份数据提供更强的机密性保障。

## Future directions

## 未来方向

As frontier models grow more capable, we may find it necessary to incorporate further safeguards at the secure loader layer. This may include features such as an additional layer of [egress bandwidth limitations](https://www.anthropic.com/news/activating-asl3-protections) on servers that holds cleartext model weights, or requiring a signature from a safety classifier in order to run inference. We hope that presenting this model of Confidential Inference might inspire discussion about what additional features are worth exploring to ensure the ongoing security of Anthropic's environment and the confidentiality of our users’ data.

随着前沿模型能力不断增强，我们可能需要在安全加载器（secure loader）层进一步引入更多防护措施。这些措施可能包括：在存储明文模型权重的服务器上增设一层[出口带宽限制](https://www.anthropic.com/news/activating-asl3-protections)，或要求安全分类器（safety classifier）签名后方可执行推理。我们希望，提出这一“机密推理”（Confidential Inference）模型，能够激发业界探讨：还有哪些额外功能值得探索，以持续保障 Anthropic 环境的安全性及用户数据的机密性。

## Conclusions

## 结论

This research will advance our ongoing efforts to secure our model weights and protect user data. Using this model to protect a user request is designed to ensure that customer data is only ever decrypted in contexts with enhanced hardware-based security controls: :

本研究将推进我们持续开展的模型权重保护与用户数据安全保障工作。采用该模型保护用户请求，旨在确保客户数据仅在具备强化硬件级安全控制的环境中被解密：

- The request is encrypted at a point before it arrives at Anthropic servers;  
- 请求在抵达 Anthropic 服务器之前即已完成加密；  
- When the request arrives at the API server, it is decrypted, processed, and re-encrypted before it is passed onward;  
- 请求抵达 API 服务器后，先被解密、处理，再重新加密，随后才继续向下传递；  
- The Inference Server handles the request in encrypted form, and the request is decrypted only when it's sent to the trusted loader;  
- 推理服务器（Inference Server）全程以加密形式处理请求，仅当请求被发送至可信加载器（trusted loader）时才进行解密；  
- Completions are encrypted before they leave the loader, and passed back through the API server to the caller.  
- 生成结果（completions）在离开加载器前即被加密，并经由 API 服务器返回调用方。

Model weights are a simpler story: they can be stored encrypted, decrypted at the loader, and never released from there.

模型权重的保护路径则更为简洁：可始终以加密形式存储，在加载器处解密，且解密后的权重绝不会从此处泄露。

Hardware designers (who have not [already done so](https://developer.nvidia.com/blog/confidential-computing-on-h100-gpus-for-secure-and-trustworthy-ai/)) should consider incorporating confidential computing into their chips. If there is a hardware root of trust attached to the accelerator, then the trust boundary of this kind of system can be significantly reduced.

硬件设计者（若尚未[着手实施](https://developer.nvidia.com/blog/confidential-computing-on-h100-gpus-for-secure-and-trustworthy-ai/)），应考虑将机密计算（confidential computing）能力集成至其芯片中。若加速器具备硬件可信根（hardware root of trust），此类系统的可信边界即可被显著缩小。

Read [the full report](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf).

请阅读[完整报告](https://assets.anthropic.com/m/c52125297b85a42/original/Confidential_Inference_Paper.pdf)。

### Work with us

### 加入我们

If this discussion of Confidential Inference has inspired you to want to work with us on these questions, please consider applying for one of the open roles listed in the “Security” and “AI Research and Engineering” sections on the [jobs page on our website](https://www.anthropic.com/jobs).

若您因本次关于“机密推理”的讨论而萌生与我们共同探索相关问题的兴趣，欢迎申请我们官网[招聘页面](https://www.anthropic.com/jobs)中“安全”（Security）与“AI 研究与工程”（AI Research and Engineering）板块所列的开放职位。