---
title: "How Tolan builds voice-first AI with GPT-5.1 | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/tolan"
date: "2026-01-07"
scraped_at: "2026-03-02T10:08:35.721766287+00:00"
language: "en-US"
translated: true
description: "Tolan built a voice-first AI companion with GPT-5.1, combining low-latency responses, real-time context reconstruction, and memory-driven personalities for natural conversations."
tags: ["API"]
---
&#123;% raw %}

January 7, 2026

2026年1月7日

[API](https://openai.com/stories/api/) 创业公司

# How Tolan builds voice-first AI with GPT‑5.1

# Tolan 如何借助 GPT‑5.1 构建以语音为先的 AI 应用

With GPT‑5.1, Tolan built a voice app optimized for low latency, accurate context, and stable personalities as conversations evolve.

借助 GPT‑5.1，Tolan 开发了一款语音应用，专为超低延迟、精准上下文理解以及对话演进过程中角色人格的稳定性而优化。

![Tolan logo on orange jigsaw puzzle background](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_001.png)

![橙色拼图背景上的 Tolan 标志](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_001.png)

[Tolan⁠(opens in a new window)](https://www.tolans.com/) is a voice-first AI companion where people talk with a personalized, animated character that learns from conversations over time.

[Tolan⁠（在新窗口中打开）](https://www.tolans.com/) 是一款以语音为先的 AI 伴侣应用，用户可与一个个性鲜明、动态呈现的虚拟角色对话；该角色能随时间推移，从持续的对话中不断学习与成长。

Built by Portola, a veteran team with a prior exit, the app is designed for ongoing, open-ended dialogue rather than quick prompts and replies. “We saw the rise of ChatGPT and knew voice was the next frontier,” says Quinten Farmer, co-founder and CEO of Portola. “But voice is harder. You’re not just responding to typed prompts; you’re holding a live, meandering conversation.”

该应用由 Portola 公司开发——这是一支经验丰富的团队，此前已成功完成一次退出。其产品定位是支持长期、开放式的对话，而非简短的提示与即时回复。“我们见证了 ChatGPT 的崛起，并意识到语音将是下一个前沿领域，”Portola 联合创始人兼首席执行官 Quinten Farmer 表示，“但语音交互更难：你面对的不只是静态的文字提示，而是一场实时、自然、甚至略带漫游性质的对话。”

Voice AI raises the bar on latency and context management, but it also enables more open-ended, exploratory interactions than text.

语音 AI 对延迟和上下文管理提出了更高要求，但同时也比纯文本交互更能支持开放式、探索性的互动体验。

With foundation models becoming faster, cheaper, and more capable, the team focused their efforts on two key levers: memory and character design. Portola built a character-driven universe, shaped by award-winning animators and a science fiction writer, using a real-time context management system to keep personality and memory consistent as conversations unfold.

随着基础模型变得更快、更经济、更强大，团队将研发重心聚焦于两大关键维度：记忆机制与角色设计。Portola 打造了一个以角色为核心的虚拟宇宙——由屡获殊荣的动画师与科幻作家共同塑造，并依托实时上下文管理系统，确保角色人格与记忆在对话进程中始终保持连贯与一致。

The release of the GPT‑5.1 models marked a turning point, delivering major gains in steerability and latency that brought those pieces together, unlocking a more responsive and engaging voice experience.

GPT‑5.1 模型的发布标志着一个转折点——其在可控性（steerability）和延迟（latency）方面的显著提升，将这两项关键能力有机整合，从而解锁了更灵敏、更具沉浸感的语音交互体验。

> “GPT-5.1 gave us the steerability to finally express the characters we had in mind. It wasn’t just smarter—it was more faithful to the tone and personality we wanted to create.”

> “GPT‑5.1 赋予了我们前所未有的可控性，使我们终于能够精准呈现心中构想的角色形象。它不只是更‘聪明’了，而是更忠实地还原了我们所期望的语调与人格特质。”

—Quinten Farmer, CEO, Portola  
—昆腾·法默（Quinten Farmer），Portola 公司首席执行官

## Designing for natural voice interactions

## 面向自然语音交互的设计

Tolan’s architecture is shaped by the demands of voice. Voice users expect instant, natural responses, even when conversations shift midstream. Tolan had to respond quickly, track changing topics, and maintain a consistent personality without lag or tone drift.

托兰（Tolan）的架构由语音交互的本质需求所塑造。语音用户期待即时、自然的回应，哪怕对话中途突然转向。因此，托兰必须快速响应、实时追踪话题变化，并在无延迟、无语调偏移的前提下持续保持统一的人格特征。

To feel natural, conversations required near-instant latency. Introducing OpenAI GPT‑5.1 and the Responses API cut speech initiation time by over 0.7 seconds—enough to noticeably improve conversational flow.

要实现“自然”的听觉感受，对话延迟必须趋近于零。引入 OpenAI GPT‑5.1 模型及 Responses API 后，语音启动时间缩短了 0.7 秒以上——这一改进足以显著提升对话的流畅度。

Equally critical was how the system handled context. Unlike many agents that cache prompts across multiple turns, Tolan rebuilds its context window from scratch each turn. Each context reconstruction pulls in a summary of recent messages, a persona card, vector-retrieved memories, tone guidance, and real-time app signals. This architecture allows Tolan to adapt in real time to abrupt topic shifts, an essential requirement for natural voice-based interaction.

系统处理上下文的方式同样至关重要。不同于许多依赖跨多轮对话缓存提示词（prompts）的智能体，托兰在每一轮对话中都会从零重建其上下文窗口。每次重建均整合以下五类输入：近期消息摘要、角色档案卡（persona card）、基于向量检索的记忆片段、语调指导（tone guidance）以及实时应用信号（real-time app signals）。该架构使托兰能够实时应对突发的话题切换——而这正是自然语音交互不可或缺的核心能力。

“We realized quickly that cached prompts just didn’t cut it,” says Quinten. “Users change subjects all the time. To feel seamless, the system had to adapt midstream.”

“我们很快意识到，仅靠缓存提示词根本行不通，”昆腾表示，“用户随时可能转换话题。若要实现无缝体验，系统就必须能在对话中途即时调整。”

This real-time reconstruction approach is both technically intensive and foundational to Tolan’s success.

这种实时重建机制不仅技术实现难度极高，更是托兰取得成功的关键基石。

![Flow diagram showing Tolan’s conversational loop. A “Recompute persona” step feeds four inputs, chat summary and recent raw messages, user and Tolan personas and other context, memory, and tone. These inputs combine to generate a Tolan response, which leads to a user response. The user response then drives two parallel processes: deriving an updated tone and extracting memories. Extracted memories update memory, updated tone feeds back into tone, and the conversation history is periodically re-summarized and compressed, looping back into the chat summary for the next turn.](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_002.png)

![展示托兰对话闭环的流程图：“重新计算角色（Recompute persona）”步骤接收四类输入：聊天摘要与近期原始消息、用户与托兰的角色设定及其他上下文、记忆、语调。这些输入共同生成托兰的回应，进而触发用户回应；用户回应又并行驱动两个过程：推导更新后的语调、提取新记忆；提取的记忆用于更新记忆库，更新后的语调反馈至语调模块，而对话历史则周期性地被重新摘要与压缩，并回流至下一轮的聊天摘要中。](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_002.png)

## Building memory and personality that hold together over time

## 构建长期稳定、连贯的记忆与人格

Context handling is important, but it wasn’t enough to keep conversations feeling coherent over time. To support long, nonlinear conversations, Tolan built a memory system that retains not just facts and preferences, but also emotional “vibe” signals—clues that help steer how a Tolan should respond.

上下文处理固然重要，但仅靠它还不足以确保对话在长时间内保持连贯性。为支持漫长、非线性的对话，Tolan 构建了一套记忆系统——它不仅保存事实信息和用户偏好，还捕捉情绪层面的“氛围”信号（“vibe” signals），即有助于引导 Tolan 如何回应的关键线索。

Memories are embedded using the OpenAI text-embedding-3-large model and stored in Turbopuffer, a high-speed vector database that enables sub-50ms lookup times. This speed is essential for real-time voice interactions. Each turn, Tolan uses the user’s latest message and system-synthesized questions (e.g., “Who is the user married to?”) to trigger memory recall. To keep memory quality high, Tolan runs a nightly compression job that removes low-value or redundant entries (e.g. “the user drank coffee today”) and resolves contradictions.

这些记忆通过 OpenAI 的 `text-embedding-3-large` 模型生成嵌入向量，并存储于 Turbopuffer——一个高速向量数据库，支持低于 50 毫秒的检索延迟。这一速度对实时语音交互至关重要。每一轮对话中，Tolan 均以用户的最新消息及系统自动生成的问题（例如：“用户与谁结婚？”）为触发器，执行记忆召回。为保障记忆质量，Tolan 每晚运行一次压缩任务：剔除低价值或冗余条目（如“用户今天喝了咖啡”），并自动消解相互矛盾的记忆。

Personality is just as carefully managed. Each Tolan is seeded with a distinct character scaffold, authored by the team’s in-house science fiction writer and refined by a behavioral researcher. These seeds give Tolans consistency, but also flexibility to adapt over time, evolving alongside the user.

人格塑造同样经过审慎设计。每位 Tolan 均基于一套独特的人物架构（character scaffold）初始化，该架构由团队内部的科幻作家创作，并由行为研究员进一步打磨优化。这类“人格种子”既赋予 Tolan 稳定一致的核心特质，又保留充分的适应弹性，使其能随用户共同成长、持续演化。

A parallel system monitors the emotional tenor of the conversation and dynamically adjusts the Tolan’s delivery. This allows a Tolan to shift seamlessly from playful to grounded depending on user cues, without losing its core personality.

另一套并行系统实时监测对话的情绪基调，并动态调节 Tolan 的表达方式。这使得 Tolan 能依据用户线索，在轻松诙谐与沉稳务实之间自然切换，同时始终坚守其人格内核。

The transition to GPT‑5.1 was a turning point. Suddenly, layered prompt instructions—tone scaffolds, memory injections, character traits—were followed more faithfully. Prompts that once required workarounds began behaving as intended.

升级至 GPT‑5.1 成为关键转折点。突然之间，多层提示指令——包括语调框架、记忆注入、人格特质等——得到了更忠实的执行；过去需依赖各种变通技巧才能实现的效果，如今已能按预期自然呈现。

“For the first time, our internal experts felt like the model was really listening,” says Quinten. “Instructions stayed intact across long conversations, persona traits were respected, and we saw far less drift.”

“这是我们首次真切感受到模型‘真的在听’。”昆腾（Quinten）表示，“指令在长对话中始终保持完整，人格特质得到切实尊重，漂移现象也大幅减少。”

Those changes added up to a more consistent and believable personality, which in turn created a more engaging user experience. The Tolan team saw clear, measurable gains: memory recall misses dropped by 30% (based on in-product frustration signals), and next-day user retention rose more than 20% after GPT‑5.1–powered personas went live.

上述改进共同促成更稳定、更可信的人格表现，进而显著提升用户体验的沉浸感与吸引力。Tolan 团队观测到明确且可量化的成效：记忆召回失败率下降 30%（依据产品内用户受挫信号统计），而搭载 GPT‑5.1 驱动人格的版本上线后，次日用户留存率提升逾 20%。

![Flow diagram illustrating how Tolan retrieves and refines memories during conversation. A user message (“I’m so excited for my trip this weekend”) triggers a step that synthesizes follow-up questions, such as upcoming trips, plans for a specific week, and user preferences. These questions are embedded and used to query a memory vector database, with results merged using mean reciprocal rank. The retrieved context informs Tolan’s response (“camping with Steven in Yosemite”). A later user message about a future trip to Iceland is stored as a new memory, then reflected on, clustered with related memories using embedding-based k-nearest neighbors, and compressed by combining, editing, and refining memories within each cluster.](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_003.png)

![流程图示意 Tolan 在对话中如何检索与精炼记忆：用户消息（“我超期待这个周末的旅行！”）触发系统生成后续问题，例如“近期有哪些出行计划？”“某一周的具体安排？”“用户的偏好是什么？”。这些问题经嵌入向量编码后，用于查询记忆向量数据库；检索结果采用平均倒数排名（Mean Reciprocal Rank）法融合。最终获得的上下文指导 Tolan 生成回应（“将与史蒂文在优胜美地露营”）。随后，用户提及未来赴冰岛旅行的消息被存为一条新记忆，继而进入反思环节：借助基于嵌入的 k 近邻算法（k-Nearest Neighbors）将其与相关记忆聚类，并在每个聚类内通过合并、编辑与精炼完成压缩。](images/how-tolan-builds-voice-first-ai-with-gpt-5_1-openai/img_003.png)

## Tolan’s core principles for building natural voice agents

## Tolan 构建自然语音智能体的核心原则

As Tolan evolved, a few principles emerged that now guide how the team builds and evolves its voice architecture:

随着 Tolan 的演进，一些核心原则逐渐浮现，如今正指导着团队构建和迭代其语音架构：

- **Design for conversational volatility:** Voice conversations shift mid-sentence. Systems need to pivot just as quickly to feel natural.

- **面向对话的动态性而设计：** 语音对话常在句子中途发生转向；系统必须以同等速度灵活调整，才能显得自然流畅。

- **Treat latency as part of the product experience:** Sub-second responsiveness shapes whether a voice agent feels conversational or mechanical.

- **将延迟视为产品体验的一部分：** 亚秒级响应能力，直接决定了语音代理是给人以“对话感”，还是“机械感”。

- **Build memory as a retrieval system, not a transcript:** High-quality compression and fast vector search deliver more consistent personality than oversized context windows.

- **将记忆构建为检索系统，而非转录存档：** 高质量压缩与快速向量搜索，比超大上下文窗口更能保障人格表现的一致性。

- **Rebuild context every turn:** Don’t fight drift with bigger prompts. Regenerating context each turn keeps agents grounded as conversations meander.

- **每轮对话均重建上下文：** 不要试图用更长的提示词来对抗上下文漂移；每轮重新生成上下文，可确保代理在漫谈式对话中始终立足于当下、保持连贯。

Together, these lessons form the foundation for Tolan’s next phase of innovation and set the direction for where voice AI is headed.

这些经验共同构成了 Tolan 下一阶段创新的基石，也指明了语音 AI 未来的发展方向。

## Expanding what’s possible with voice AI

## 用语音 AI 拓展可能性的边界

Since launching in February 2025, Tolan has grown to more than 200,000 monthly active users. Its 4.8-star rating and more than 100,000 App Store reviews highlight how well the system maintains consistency across long, shifting conversations. One reviewer noted, “They remember things we talked about two days ago and they bring it back into the conversation that we’re having today.”

自 2025 年 2 月发布以来，Tolan 的月活跃用户已突破 20 万。其 App Store 上高达 4.8 星的评分与逾 10 万条用户评价，印证了该系统在漫长、多变的对话中始终保持高度一致性的卓越能力。一位用户评价道：“他们还记得两天前我们聊过的事，并能自然地把那些内容带入今天这场对话中。”

These signals map directly to the underlying architecture: low-latency model calls, turn-by-turn context reconstruction, and modular memory and persona systems. Together, they allow Tolan to track topic changes, preserve tone, and keep responses grounded without relying on large, fragile prompts.

这些用户反馈直接映射至底层架构：低延迟模型调用、逐轮上下文重建，以及模块化的记忆与人格系统。三者协同，使 Tolan 能够精准追踪话题演变、持续维持语调风格，并让回应始终紧扣语境——而无需依赖庞大且易失效的提示词。

Looking ahead,  Tolan plans to deepen its investments in steerability and memory refinement, focusing its efforts on tighter compression, improved retrieval logic, and expanded persona tuning. The long-term goal is to expand what a voice interface can be: not just responsive, but context-aware and conversationally dynamic.

展望未来，Tolan 将进一步加大在“可控性（steerability）”与“记忆精炼”方面的投入，重点聚焦于更高效的压缩算法、更优的检索逻辑，以及更丰富的角色人格调优能力。其长期目标是拓展语音交互界面的内涵：它不应仅是“响应式”的，更应是“上下文感知的”与“对话动态演进的”。

“The next frontier,” says Quinten, “is building voice agents that aren’t just responsive, but truly multimodal, able to integrate voice, vision, and context into a single, steerable system.”

“下一个前沿领域，”Quinten 表示，“是打造不仅具备响应能力、更真正实现多模态融合的语音代理——它能将语音、视觉与上下文整合进一个统一、可精确调控的系统之中。”
&#123;% endraw %}
