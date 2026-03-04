---
render_with_liquid: false
title: "Keeping community human while scaling with agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/keeping-community-human-while-scaling-with-agents"
date: "2026-02-27"
scraped_at: "2026-03-02T09:21:20.242220273+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel scales community support with AI agents. We automated logistics to reclaim human focus, empowering our team to solve complex problems"
---
render_with_liquid: false
render_with_liquid: false

Feb 27, 2026

2026 年 2 月 27 日

At Vercel, our developer community is at the heart of everything we do. It's how we stay closest to the people using what we build.

在 Vercel，我们的开发者社区是我们一切工作的核心。正因如此，我们才能始终与使用我们所构建产品的用户保持最紧密的联系。

As our community grew, automation helped us scale. But questions still got lost, routing took time, and context switching pulled us away from the work that actually required our expertise. And automation could never help with the things that mattered most, the moments where you really connect with someone and help them. You can't use AI to replicate the feeling of talking to a person who really cares.

随着社区规模不断扩大，自动化帮助我们实现了规模化运营。但问题依然会遗漏，路由分发耗时较长，上下文切换又让我们偏离了真正需要专业知识的核心工作。而自动化永远无法解决那些最重要的事情——那些你真正与他人建立联结、切实提供帮助的关键时刻。你无法用 AI 复刻与一位真正关心你的人交谈时所感受到的温度与真诚。

So we built agents to take over the routing, triage, and follow-ups that don't need a human. We call this the Community Guardian. Let's talk about what it does, how we built it, and how anyone, including non-engineers, can ship agents too.

因此，我们构建了智能体（agents），专门接管无需人工介入的路由分发、初步分级（triage）和后续跟进工作。我们将这一系统命名为 **Community Guardian（社区守护者）**。接下来，我们将详细介绍它的功能、我们的构建方式，以及包括非工程师在内的任何人都如何快速上线自己的智能体。

## The Community Guardian operations layer

## 社区守护者的运营层

When a new post comes in, the Guardian analyzes it, checks for duplicates, and assigns it to the team member with the right specialty and bandwidth. Each person handles up to 10 questions before new ones go to someone else, keeping the workload balanced across time zones.

每当一条新帖子提交进来，守护者便会对其分析、查重，并将其分配给具备相应专业领域知识且当前负载适中的团队成员。每位成员最多处理 10 个问题，之后的新问题将自动转交他人，从而确保不同时区的团队成员之间工作负载均衡。

Nothing gets overlooked. If a question goes unanswered for 48 hours, the Guardian reassigns it. It sends reminders when we're waiting for more information and detects when conversations are resolved.

绝无遗漏。若一个问题在 48 小时内未获回应，守护者将自动重新分配；当我们在等待用户补充更多信息时，它会主动发送提醒；它还能准确识别对话是否已圆满结束。

Under the hood, the Guardian uses Claude through [AI Gateway](https://vercel.com/docs/ai-gateway) and runs on [Vercel Workflows](https://vercel.com/docs/workflow), which lets it check in every 10 minutes and sleep between cycles without consuming resources.

在底层实现上，守护者通过 [AI Gateway](https://vercel.com/docs/ai-gateway) 调用 Claude 模型，并运行于 [Vercel Workflows](https://vercel.com/docs/workflow) 平台之上——这使其能够每 10 分钟执行一次状态检查，并在两次循环之间进入休眠状态，全程不占用任何计算资源。

That handles the operations side, but our team still needed better context to respond well.

上述机制已全面覆盖运营层面的需求，但我们的团队仍需更充分的上下文信息，才能做出高质量响应。

## The intelligence layer: c0, the research assistant

## 智能层：c0——研究助理

While the Guardian manages logistics, c0 is the agent that goes deep on research. It lives in Slack, where our team already works.

虽然 Guardian 负责统筹协调物流事务，c0 则是专注于深度研究的智能体。它驻留在 Slack 中——这正是我们团队日常协作的平台。

When a team member needs context on a thread, c0 searches our knowledge base, documentation, GitHub issues, and past discussions to put together a context package. The context package helps our team respond faster and more accurately instead of relying on their own memory.

当团队成员需要了解某条讨论线程的背景信息时，c0 会自动检索我们的知识库、文档、GitHub Issues 以及过往讨论记录，并据此生成一份“上下文包”。该上下文包帮助团队更快、更准确地响应问题，而无需依赖个人记忆。

Asking c0 for community feedback on v0

向 c0 查询社区对 v0 版本的反馈意见

Beyond individual threads, c0 helps us close the loop with our product teams. It tracks community sentiment and recurring technical hurdles, so rather than someone spending hours auditing a week's worth of posts, we can ask c0 for the "top product feedback" and bring real data to our product conversations.

除了单条讨论线程外，c0 还助力我们与产品团队形成闭环协作。它持续追踪社区情绪及反复出现的技术难点；因此，我们不再需要专人耗费数小时人工审阅一周内的全部帖子，而是可直接向 c0 提出请求，获取“最受关注的产品反馈”，并将真实、可量化的数据带入产品讨论中。

## Reclaiming human focus

## 重拾人类专注力

In its first 23 days, the system helped 281 unique users:

上线最初的 23 天内，该系统已为 281 位独立用户提供了支持：

| **Metric** | **Outcome** |
| --- | --- |
| Initial context gathering | 4,716 first responses triaging issues and gathering logs before a team member arrives |
| Thread revival | 1 in 8 "ghosted" threads brought back to life, resulting in 23 confirmed solutions |
| Operational scale | Over 1,400 agent runs in a recent two-week period, from stale-checks to auto-solving |
| Duplicate detection | 4 duplicate threads detected via vector similarity, with 3 auto-closed at 95%+ confidence |

| **指标** | **成果** |
| --- | --- |
| 初始上下文收集 | 在团队成员介入前，已生成 4,716 条首轮响应，用于问题分诊与日志收集 |
| 线程复苏 | 每 8 条“已失联”（ghosted）线程中即有 1 条被成功激活，共促成 23 项经确认的解决方案 |
| 运营规模 | 近期两周内执行智能体任务逾 1,400 次，涵盖陈旧性检查（stale-checks）到自动问题解决（auto-solving）等各类场景 |
| 重复帖识别 | 借助向量相似度检测出 4 条重复讨论线程，其中 3 条已在 95% 以上置信度下自动关闭 |

Every substantial answer still comes from our team. Agents handle everything else around those answers. Without the repetitive parts of triage and tracking, our team can spend time on complex pair-debugging and relationship building, creating content for the broader community, or just having fun with the developers they care about.

所有实质性回答仍由我们团队亲自提供。智能体则负责围绕这些回答所涉及的所有其他事务。剔除掉重复性的分诊与追踪工作后，我们的团队得以将精力投入到更复杂的结对调试（pair-debugging）、关系建设、面向更广泛社区的内容创作，甚至只是与自己关心的开发者轻松愉快地交流互动。

## Build your own

## 打造属于你自己的智能体

You don't have to be a developer to build something like this. You just need an idea. I'm not an engineer. I manage community and talk to developers. Sure, I understand the problems we're solving, but I'm not writing production code every day.

你无需成为开发者，也能构建类似这样的系统——你真正需要的，只是一个想法。我本人并非工程师，我的角色是社区运营，日常工作是与开发者沟通交流。诚然，我深刻理解我们正在解决的问题，但我并不会每天编写生产环境代码。

My idea started at [a talk in Zurich](https://www.youtube.com/watch?v=8VWq6tcvkJA) where I showed how we were automating community workflows. But that was traditional automation, scripts and rules and if-this-then-that logic. It worked, but it was brittle. Every edge case needed a new rule.

我的想法始于[苏黎世的一场演讲](https://www.youtube.com/watch?v=8VWq6tcvkJA)，我在其中展示了我们如何自动化社区工作流。但那属于传统自动化——依赖脚本、规则以及“如果…那么…”（if-this-then-that）式的逻辑。它确实能运行，却十分脆弱：每个边缘情况都需要新增一条规则。

Demoing our community automation workflows at Vercel Ship Zurich

在 Vercel Ship 苏黎世大会上演示我们的社区自动化工作流

I wanted something smarter, so I started experimenting with my coding agent to add a thinking layer, the step between "new post arrives" and "take action." Instead of "if post contains 'billing' then route to billing team," it became "read this post, understand what the person actually needs, then decide."

我渴望更智能的方案，于是开始用我的编程智能体（coding agent）进行实验，为其增加一个“思考层”——即介于“新帖子到达”与“执行操作”之间的中间环节。它不再沿用“如果帖子包含‘billing’，就转给计费团队”这类机械规则，而是转变为：“阅读这篇帖子，理解用户真实需求，再据此做出决策。”

The thinking layer is like another DX engineer looking at each post who can read between the lines when a user says "it's not working," connect dots to a GitHub issue from three months ago, understand when someone's frustrated vs. just confused, and know when to escalate vs. when to gather more context. Building this way meant I could describe what I wanted in plain English, get working code back, test it against real community threads, and iterate.

这个“思考层”就像另一位 DX 工程师在逐条审阅每篇帖子：当用户说“它不工作了”，它能读懂言外之意；能将当前问题与三个月前的某个 GitHub Issue 关联起来；能分辨用户是感到沮丧，还是仅仅困惑；也能判断何时该升级处理，何时应先收集更多上下文。以这种方式构建系统，意味着我只需用平实的英文描述我的需求，就能获得可运行的代码，再用真实的社区讨论帖进行测试并持续迭代优化。

I wanted to use different models for different tasks, give our agent access to read our docs and community, and allow it to suspend, resume, and recover if something failed. Instead of building all of that from scratch, I described what I needed to my coding agent and landed on [AI Gateway](https://vercel.com/docs/ai-gateway), [AI SDK](https://vercel.com/docs/ai/ai-sdk), and [Vercel Workflows](https://vercel.com/docs/workflow), which already handle those complexities.

我希望为不同任务选用不同模型，赋予智能体读取我们文档和社区内容的权限，并支持其在出错时暂停、恢复与容错重试。我没有从零开始自行实现全部功能，而是向我的编程智能体清晰描述了我的需求，最终选定了已内置这些复杂能力的工具：[AI Gateway](https://vercel.com/docs/ai-gateway)、[AI SDK](https://vercel.com/docs/ai/ai-sdk) 和 [Vercel Workflows](https://vercel.com/docs/workflow)。

### The prompts that built it

### 构建它的提示词（Prompts）

The first prompt was the core idea: "Build me an agent that helps me with the community, day-to-day operations like assigning posts and formatting. I don't know which model will work best yet but make it easy to switch without needing new API keys. Use the AI SDK for the agent."

首个提示词表达了核心构想：“为我构建一个协助社区运营的智能体，用于日常事务，例如分配帖子、格式化内容等。我尚不确定哪种模型效果最佳，但请确保模型切换便捷，无需额外配置新的 API 密钥。请基于 AI SDK 实现该智能体。”

From there, the prompts got more specific as I understood more about what I was building. "And triggers every 10 minutes, I want to check for the latest threads." I'd started with cron jobs, but switched to Vercel Workflows for this. The durable execution meant the agent could suspend between checks and resume exactly where it left off.

随后，随着我对所构建系统的理解不断深入，提示词也愈发具体：“还要设置为每 10 分钟触发一次，检查最新讨论帖。”起初我尝试使用 Cron 作业，但后来改用 Vercel Workflows 来实现这一需求。其持久化执行能力，使得智能体可在两次检查之间安全暂停，并精准恢复至中断处继续运行。

"Make sure we're rotating assignments every 4 hours." Every prompt unlocked the next question. I wasn't following a tutorial or docs. I was having a conversation, and the system grew from that conversation.

“确保每 4 小时轮换一次任务分配。”每一个提示词都自然引出下一个问题。我并未照着教程或文档按部就班地操作，而是在与系统展开一场对话——整个系统正是在这场持续对话中逐步生长成型的。

You don't need to know the right terminology or how to code. You just need to know your problem well enough to describe it and be willing to iterate when something doesn't work the way you expected. The thinking layer turns automation from "follow these exact rules" into "understand the situation and make a judgment call."

你无需掌握专业术语，也不必会写代码。你只需足够了解自己的问题，能清晰描述出来；并在结果未达预期时，乐于反复调整优化。这个“思考层”，正将自动化从“严格遵循既定规则”，升维为“理解当下情境，并作出合理判断”。

## Build with heart

## 用心构建

Community is about people, and we want our people to have the time and energy to show up fully, building with and for the developers in our community.

社区关乎人，我们希望团队成员拥有充足的时间与精力全身心投入，与社区中的开发者们携手共建、为他们而建。

If you want to build something similar, we built c0 with the [Chat SDK](https://github.com/vercel/chat), a unified TypeScript SDK for building agents across Slack, Teams, Discord, and more. The Guardian uses [Vercel Workflows](https://vercel.com/docs/workflow) for durable execution. Come share what you build [in the community](https://community.vercel.com/). We're always happy to talk through what we've learned.

如果您也希望构建类似的产品，我们使用 [Chat SDK](https://github.com/vercel/chat)（一款面向 Slack、Teams、Discord 等多平台的统一 TypeScript SDK）开发了 c0；The Guardian 则采用 [Vercel Workflows](https://vercel.com/docs/workflow) 实现持久化执行。欢迎到 [社区](https://community.vercel.com/) 分享您的成果——我们非常乐意与您交流彼此的经验与心得。