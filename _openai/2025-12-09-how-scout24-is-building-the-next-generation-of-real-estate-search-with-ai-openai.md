---
title: "How Scout24 is building the next generation of real-estate search with AI | OpenAI"
render_with_liquid: false
source: "OpenAI Blog"
url: "https://openai.com/index/scout24"
date: "2025-12-09"
scraped_at: "2026-03-02T10:47:39.658331191+00:00"
language: "en-US"
translated: true
description: "Scout24 has created a GPT-5 powered conversational assistant that reimagines real-estate search, guiding users with clarifying questions, summaries, and tailored listing recommendations."
tags: ["ChatGPT"]
---

render_with_liquid: false
December 9, 2025

2025年12月9日

[ChatGPT](https://openai.com/stories/chatgpt/) Enterprise

[ChatGPT](https://openai.com/stories/chatgpt/) 企业版

# How Scout24 is building the next generation of real-estate search with AI

# Scout24 如何借助 AI 构建新一代房地产搜索体验

Scout24 is using generative AI to reimagine how people discover where and how they want to live.

Scout24 正在利用生成式 AI 重新构想人们探索理想居所及生活方式的方式。

00:0002:22

00:00–02:22

Scout24 operates Germany’s largest real-estate platform, connecting seekers, homeowners, landlords and agents in one ecosystem. AI has supported areas like fraud detection, marketing efficiency, and property valuation for years, and  the rise of powerful large language models created an opportunity to build something new for customers: an intelligent, conversational real-estate assistant.

Scout24 运营着德国规模最大的房地产平台，将购房者、业主、房东和房产中介汇聚于同一生态系统之中。多年来，AI 已广泛应用于欺诈检测、营销效率提升和房产估值等领域；而如今，强大大语言模型（LLM）的兴起，为 Scout24 创造了全新机遇——为客户打造一款智能、可对话的房地产助手。

We sat down with Gertrud Kolb, Chief Technology Officer at Scout24, to hear how her team built a GPT‑5 powered search experience, what they learned about “intelligent interaction,” and how they balanced innovation with quality and trust before launch.

我们与 Scout24 首席技术官（CTO）Gertrud Kolb 展开对谈，了解其团队如何构建基于 GPT‑5 的搜索体验、在探索“智能交互”过程中收获了哪些洞见，以及在产品上线前如何兼顾创新、质量与用户信任。

> “Be curious, be open, start doing things. Talk with each other, learn from each other—and have fun.”

> “保持好奇，保持开放，立即行动。彼此交流，相互学习——并享受其中的乐趣。”

—Gertrud Kolb, Chief Technology Officer, Scout24

—Gertrud Kolb，Scout24 首席技术官

#### Results at a glance

#### 一目了然的成果

- GPT‑5 驱动 Scout24 的对话式搜索助手 HeyImmo  
- 自适应答案格式：简洁摘要、要点列表，或带图片预览的直接房源列表  
- 基于 OpenAI Evals 框架构建的定制化评估系统，用于定义并衡量答案质量  
- 全公司范围的“蜂群测试”（swarm testing），以校准预期并压力测试边缘场景  
- 面向速度与可靠性而设计的架构，并支持快速迭代优化  
- 与 OpenAI 解决方案架构师团队紧密协作，持续提升安全性、答案质量与用户体验  

#### Inside the rollout

#### 上线过程揭秘

Scout24 的首要任务是优化搜索——这是其平台最核心的功能。然而，在与 OpenAI 展开原型开发的过程中，团队很快意识到：用户所期待的远不止更精准的搜索结果，他们更需要专业指导。“我们迅速意识到，这已不仅关乎搜索本身；我们需要一位房地产领域的专家助手——一位‘陪练伙伴’（sparring partner），全程引导用户完成整个平台体验。”Gertrud 表示。

这一洞见催生了一款真正具备对话能力的智能助手：它能主动提出澄清性问题、精准呈现相关房源、归纳选项要点，并根据用户需求动态调整答案呈现形式。有人偏好要点式罗列，有人倾向完整摘要，还有人希望立即看到房源列表。而如何准确把握“智能交互”究竟意味着什么，成为项目中最具挑战性的课题之一。

Scout24 同样面临技术架构的选择难题。早期构想曾倾向于采用复杂的多智能体（multi-agent）框架，但团队最终有意识地选择简化路径：依托函数调用（function calling）机制，搭配高度聚焦的模块化组件，从而实现快速交付并基于真实用户反馈持续学习。响应延迟、结果相关性、系统性能，以及答案结构的合理性，由此成为贯穿开发全程的关键关注点。

其中最重要的一课，便是对“质量”的深入理解。为此，Scout24 借鉴 OpenAI Evals 框架，自主研发了一套评估模型——帮助团队明确定义何为“足够好”（good enough），并在大量不同场景中对其可量化地进行验证。与此同时，公司还开展了覆盖全员的内部测试：几乎所有员工都被邀请试用产品、提交反馈，并主动探索和验证各类边缘案例。为确保最终体验达到既定标准，公司甚至推迟了一次上线计划。

在整个开发周期中，Scout24 始终与 OpenAI 团队保持深度协作。Gertrud 将此次合作形容为“极具价值”（immensely helpful）：它显著提升了答案质量，优化了回复结构设计，并在“何为优质 AI 搜索体验”这一根本问题上达成了关键共识。

这种融合了迭代式工程实践、严谨评估体系与广泛测试验证的方法组合，为打造兼具智能感与可信度的客户体验，奠定了坚实基础。

#### Leadership lessons from Scout24

#### Scout24 带来的领导力启示

- Start where AI can transform the core of your product—and iterate from there.  
- 从 AI 能够重塑您产品核心之处着手，并以此为基础持续迭代。

- Quality matters: define “good enough” and build the tools to measure it.  
- 质量至关重要：明确何为“足够好”，并构建相应的评估工具。

- Internal testing at scale uncovers real user expectations.  
- 大规模内部测试能揭示真实用户期望。

- Launch early, learn fast—but know when to slow down.  
- 尽早发布，快速学习——但也要懂得何时该放慢节奏。

- A tight partnership between product teams and technical experts accelerates progress.  
- 产品团队与技术专家之间的紧密协作，可加速推进进程。

#### What’s next  

#### 下一步是什么  

Scout24’s focus now is on interconnectivity: expanding the real-estate assistant across seekers, landlords, homeowners, and agents. From helping agents produce verified floor plans to giving seekers more personalized guidance, the team sees many opportunities to deepen the experience and strengthen network effects across the marketplace.  

Scout24 当前的重点是增强互联互通：将房产助手拓展至购房者、房东、业主及房产经纪人等各类用户群体。从协助经纪人生成经验证的户型图，到为购房者提供更个性化的指导，团队看到了诸多深化用户体验、强化市场平台网络效应的机会。

> “For each customer group we have so many ideas for AI-driven features. We’re only just getting started”  
>   
> —Gertrud Kolb, Chief Technology Officer, Scout24  

> “针对每一类客户群体，我们都已构思出大量由 AI 驱动的功能创意。我们才刚刚起步。”  
>   
> —Gertrud Kolb，首席技术官，Scout24  

## Join the frontier  

## 加入前沿  

More than 1 million businesses around the world are achieving meaningful results with OpenAI.  

全球已有超过 100 万家企业正借助 OpenAI 取得切实成效。

[Contact our team](https://openai.com/contact-sales/)  

[联系我们的团队](https://openai.com/contact-sales/)