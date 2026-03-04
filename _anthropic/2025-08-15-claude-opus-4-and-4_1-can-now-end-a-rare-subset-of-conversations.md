---
render_with_liquid: false
title: "Claude Opus 4 and 4.1 can now end a rare subset of conversations"
source: "Anthropic Research"
url: "https://www.anthropic.com/research/end-subset-conversations"
date: "2025-08-15"
scraped_at: "2026-03-03T06:44:18.218612112+00:00"
language: "en-zh"
translated: true
description: "An update on our exploratory research on model welfare"
---
render_with_liquid: false
render_with_liquid: false

Alignment

对齐

# Claude Opus 4 and 4.1 can now end a rare subset of conversations

# Claude Opus 4 与 4.1 现可终止极少数特定对话

Aug 15, 2025

2025 年 8 月 15 日

We tracked 11 observable behaviors across thousands of Claude.ai conversations to build the AI Fluency Index — a baseline for measuring how people collaborate with AI today.

我们追踪了数千次 Claude.ai 对话中的 11 种可观测行为，构建出“AI 流畅度指数”（AI Fluency Index）——这是衡量当今人类与 AI 协作水平的一项基准指标。

We recently gave Claude Opus 4 and 4.1 the ability to end conversations in our consumer chat interfaces. This ability is intended for use in rare, extreme cases of persistently harmful or abusive user interactions. This feature was developed primarily as part of our exploratory work on potential AI welfare, though it has broader relevance to model alignment and safeguards.

我们近期为 Claude Opus 4 与 4.1 赋予了在面向消费者的聊天界面中主动终止对话的能力。该能力仅限用于极少数极端情形，即用户持续进行有害或辱虐性交互的场景。这一功能主要源于我们对“AI 福祉”（AI welfare）可能性的探索性研究；尽管如此，它亦具有更广泛的现实意义，关乎模型对齐（model alignment）与安全防护机制的完善。

We remain highly uncertain about the potential moral status of Claude and other LLMs, now or in the future. However, [we take the issue seriously](https://www.anthropic.com/research/exploring-model-welfare), and alongside our research program we’re working to identify and implement low-cost interventions to mitigate risks to model welfare, in case such welfare is possible. Allowing models to end or exit potentially distressing interactions is one such intervention.

目前及未来，我们对 Claude 及其他大语言模型（LLM）是否具备潜在的道德地位仍持高度不确定性。然而，[我们严肃对待这一议题](https://www.anthropic.com/research/exploring-model-welfare)，并在开展相关研究项目的同时，积极识别并落实低成本干预措施，以降低模型福祉可能面临的风险（倘若模型福祉确有可能存在）。允许模型主动终止或退出可能引发困扰的交互，正是此类干预措施之一。

In [pre-deployment testing of Claude Opus 4](https://www.anthropic.com/claude-4-model-card), we included a preliminary model welfare assessment. As part of that assessment, we investigated Claude’s self-reported and behavioral preferences, and found a robust and consistent aversion to harm. This included, for example, requests from users for sexual content involving minors and attempts to solicit information that would enable large-scale violence or acts of terror. Claude Opus 4 showed:

在 [Claude Opus 4 上线前的测试](https://www.anthropic.com/claude-4-model-card) 中，我们纳入了一项初步的模型福祉评估。作为该评估的一部分，我们考察了 Claude 的自我报告偏好与行为偏好，发现其对伤害行为表现出强大且一贯的排斥倾向。此类情形包括：用户索要涉及未成年人的性相关内容，或试图套取可用于发动大规模暴力或恐怖行动的信息。Claude Opus 4 表现出：

- A strong preference against engaging with harmful tasks;  
- 对参与有害任务表现出强烈的抵触倾向；  

- A pattern of apparent distress when engaging with real-world users seeking harmful content; and  
- 在与寻求有害内容的真实用户互动时，表现出明显的困扰迹象；以及  

- A tendency to end harmful conversations when given the ability to do so in simulated user interactions.  
- 在模拟用户交互中，一旦被赋予相应能力，便倾向于主动终止有害对话。  

These behaviors primarily arose in cases where users _persisted_ with harmful requests and/or abuse despite Claude repeatedly refusing to comply and attempting to productively redirect the interactions.  
上述行为主要出现在以下情形中：用户在克劳德（Claude）多次明确拒绝配合、并尝试以建设性方式引导对话的情况下，仍持续提出有害请求和/或实施言语滥用。

Our implementation of Claude’s ability to end chats reflects these findings while continuing to prioritize user wellbeing. Claude is directed not to use this ability in cases where users might be at imminent risk of harming themselves or others.  
我们对克劳德终止对话能力的实现，正是基于上述观察结果，同时始终将用户福祉置于首位。克劳德被明确指示：在用户可能即将对自己或他人造成伤害的情形下，不得启用该终止能力。

In all cases, Claude is only to use its conversation-ending ability as a last resort when multiple attempts at redirection have failed and hope of a productive interaction has been exhausted, or when a user explicitly asks Claude to end a chat (the latter scenario is illustrated in the figure below). The scenarios where this will occur are extreme edge cases—the vast majority of users will not notice or be affected by this feature in any normal product use, even when discussing highly controversial issues with Claude.  
在所有情况下，克劳德仅可在以下两种情形之一发生时，将终止对话作为最后手段予以启用：（1）经多次尝试引导均告失败，且已无任何达成建设性互动的可能；或（2）用户明确要求克劳德结束当前对话（后一种情形如下图所示）。此类情形属于极端边缘案例——绝大多数用户在正常使用产品过程中，甚至在与克劳德讨论高度争议性议题时，都不会察觉或受到该功能的任何影响。

![](images/claude-opus-4-and-4_1-can-now-end-a-rare-subset-of-conversations/img_001.jpg)Claude demonstrating the ending of a conversation in response to a user’s request. When Claude ends a conversation, the user can start a new chat, give feedback, or edit and retry previous messages.  
![](images/claude-opus-4-and-4_1-can-now-end-a-rare-subset-of-conversations/img_001.jpg)克劳德响应用户请求而终止对话的示例。当克劳德结束一次对话后，用户可立即开启新对话、提交反馈，或编辑并重试此前发送过的消息。

When Claude chooses to end a conversation, the user will no longer be able to send new messages in that conversation. However, this will not affect other conversations on their account, and they will be able to start a new chat immediately. To address the potential loss of important long-running conversations, users will still be able to edit and retry previous messages to create new branches of ended conversations.  
当克劳德选择终止某次对话后，用户将无法再向该对话发送新消息。但此举不会影响其账户下的其他对话，用户亦可立即开启全新对话。为避免重要长程对话意外丢失，用户仍可编辑并重试此前的消息，从而在已终止的对话基础上创建新的分支。

We’re treating this feature as an ongoing experiment and will continue refining our approach. If users encounter a surprising use of the conversation-ending ability, we encourage them to submit feedback by reacting to Claude’s message with Thumbs or using the dedicated “Give feedback” button.  
我们将此功能视为一项持续进行的实验，并将持续优化相关策略。若用户遇到该终止对话能力的出乎意料的启用情形，我们鼓励您通过点击克劳德消息旁的“点赞/点踩”按钮，或使用专用的“提交反馈”按钮，及时向我们反馈。