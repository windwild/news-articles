---
title: "Datadog uses Codex for system-level code review | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/datadog"
date: "2026-01-09"
scraped_at: "2026-03-02T10:08:34.795502174+00:00"
language: "en-US"
translated: true
description: "OpenAI and Datadog brand graphic with the OpenAI wordmark on the left, the Datadog logo on the right, and a central abstract brown fur-like texture panel on a white background."
---
&#123;% raw %}

January 9, 2026

2026年1月9日

[API](https://openai.com/stories/api/) Enterprise

[API](https://openai.com/stories/api/) 企业版

# Datadog uses Codex for system-level code review

# Datadog 借助 Codex 实现系统级代码审查

With Codex, Datadog brings system-wide context into every code review to prevent incidents and protect customer trust.

借助 Codex，Datadog 将全系统上下文融入每一次代码审查，从而预防事故并维护客户信任。

[Datadog⁠(opens in a new window)](https://www.datadoghq.com/) runs one of the world’s most widely-used observability platforms, helping companies monitor, troubleshoot, and secure complex distributed systems. When something breaks, customers depend on Datadog to surface issues fast, which means reliability has to be built in long before code ever reaches production.

[Datadog⁠（在新窗口中打开）](https://www.datadoghq.com/) 运营着全球使用最广泛的可观测性平台之一，助力企业监控、排查和保障复杂分布式系统的安全。当系统出现故障时，客户依赖 Datadog 快速发现并定位问题；这意味着可靠性必须在代码投入生产环境之前就已深度内置于整个开发流程之中。

For Datadog’s engineering teams, that makes code review a high-stakes moment. It’s not just about catching mistakes, but about understanding how changes ripple through interconnected systems—an area where traditional static analysis and rule-based tools often fall short.

对 Datadog 的工程团队而言，代码审查因此成为一项高风险、高影响的关键环节。其意义不仅在于发现错误，更在于理解代码变更如何在相互关联的系统中产生连锁反应——而这恰恰是传统静态分析与基于规则的工具常常力所不及的领域。

To meet this challenge, Datadog’s AI Development Experience (AI DevX) team turned to Codex, the coding agent from OpenAI, which brings system-level reasoning into code review and surfaces risks humans can’t easily see at scale.

为应对这一挑战，Datadog 的人工智能开发体验（AI DevX）团队引入了 OpenAI 推出的编程智能体 Codex。Codex 将系统级推理能力带入代码审查流程，规模化地识别出人类难以察觉的风险点。

“Time savings are real and important,” says Brad Carter, who leads Datadog’s AI DevX team. “But preventing incidents is far more compelling at our scale.”

“节省时间是真实且重要的，”领导 Datadog AI DevX 团队的 Brad Carter 表示，“但在我们这样的业务规模下，预防事故才更具说服力。”

## Bringing system-level context to code review with Codex

## 借助 Codex 将系统级上下文引入代码审查

Effective code review at Datadog traditionally relied heavily on senior engineers—the people who understand the codebase, its history, and the architectural tradeoffs well enough to spot systemic risk.

Datadog 传统的有效代码审查工作长期以来高度依赖资深工程师——这些工程师对代码库、其历史沿革以及架构权衡有深入理解，因而能够识别系统性风险。

But that kind of deep context is hard to scale, and early AI code review tools didn’t solve this problem; many behaved like advanced linters, flagging surface-level issues while missing broader system nuances. Datadog’s engineers often found the suggestions too shallow or too noisy, and ignored them.

但此类深度上下文极难规模化；而早期的 AI 代码审查工具也未能解决这一问题——许多工具表现得如同高级 lint 工具，仅能标记表层问题，却忽略了更广泛的系统性细微差别。Datadog 的工程师普遍认为这些建议过于浅显或噪声过大，因而选择忽略。

Datadog began piloting Codex, the coding agent from OpenAI, by integrating it into the live development workflows. In one of the company’s largest and most heavily used repositories, every pull request was automatically reviewed by Codex. Engineers reacted to comments from Codex with thumbs up or down and shared informal feedback across teams. Many noted that the Codex feedback was worth reading, unlike previous tools that produced noisy or shallow suggestions.

Datadog 开始试点 OpenAI 推出的编程智能体 Codex，并将其集成至实时开发工作流中。在公司最大、使用最频繁的代码仓库之一中，每个拉取请求（pull request）均由 Codex 自动审查。工程师通过点赞或点踩的方式对 Codex 的评论作出反馈，并在团队间共享非正式意见。许多人指出，Codex 提供的反馈值得认真阅读，这与此前那些产生大量噪声或流于表面的工具截然不同。

## Validating AI review against real incidents

## 基于真实事故验证 AI 审查效果

To test whether AI‑assisted review could do more than point out style issues, Datadog built an incident replay harness.

为验证 AI 辅助审查是否不仅能指出风格类问题，Datadog 构建了一套事故回放测试框架（incident replay harness）。

Instead of using hypothetical scenarios, the team went back to historical incidents. They reconstructed pull requests that had contributed to incidents, ran Codex against each one as if it were part of the original review, then asked the engineers who owned those incidents whether feedback from Codex would have made a difference.

团队并未采用假设性场景，而是回溯历史事故。他们重建了曾导致事故发生的拉取请求，在模拟原始审查流程的前提下，逐一运行 Codex 进行分析，并向相关事故的责任工程师征询：若当时收到 Codex 的反馈，是否会产生实质性影响？

The result: Codex found more than 10 cases, or roughly **22%** **of the incidents** that Datadog examined, where engineers confirmed that the feedback Codex provided would have made a difference—more than any other tool evaluated.

结果表明：在 Datadog 所考察的全部事故中，Codex 在超过 10 起（约占 **22%**）案例中被工程师确认——其反馈本可带来实质性改变，这一表现优于所有其他被评估工具。

Because these pull requests had already passed code review, the replay test showed that Codex surfaced risks reviewers hadn’t seen at the time, complementing human judgment rather than replacing it.

由于这些拉取请求此前均已通过人工代码审查，此次回放测试证明：Codex 揭示了当时人工审查者未能察觉的风险，从而对人类判断形成有力补充，而非取而代之。

## Delivering consistent, high-signal feedback

## 提供稳定、高信噪比的反馈

Datadog’s analysis showed that Codex consistently flagged issues that aren’t obvious from the immediate diff alone and can’t be caught by deterministic rules.

Datadog 的分析表明，Codex 能持续识别出仅凭当前代码差异（diff）难以察觉、且无法通过确定性规则捕获的问题。

Engineers described Codex comments as more than “bot noise”:

工程师将 Codex 的评论描述为远不止“机器人噪音”：

- Codex pointed out interactions with modules not touched in the diff  
- 它指出了代码差异（diff）中未涉及的模块之间的交互；

- It identified missing test coverage in areas of cross‑service coupling  
- 它识别出跨服务耦合区域中缺失的测试覆盖；

- It highlighted API contract changes that carried downstream risk  
- 它突显了可能引发下游风险的 API 契约变更。

> “For me, a Codex comment feels like the smartest engineer I’ve worked with and who has infinite time to find bugs. It sees connections my brain doesn’t hold all at once.”

> “对我而言，一条 Codex 评论就像我共事过的最聪明的工程师——而且他拥有无限的时间来发现缺陷。它能看到我大脑无法在同一时刻全部把握的关联。”

—Brad Carter, Engineering Manager at Datadog  
—Brad Carter，Datadog 工程经理

That ability to connect review feedback to real reliability outcomes was what made Codex stand out in Datadog’s evaluation. Unlike static analysis tools, Codex compares the intent of the pull request with submitted code changes, reasoning over the entire codebase and dependencies to execute code and tests to validate behavior.

这种将评审反馈与真实可靠性结果相联系的能力，正是 Codex 在 Datadog 评估中脱颖而出的关键所在。与静态分析工具不同，Codex 将拉取请求（pull request）的意图与已提交的代码变更进行比对，并基于整个代码库及依赖关系进行推理，实际执行代码和测试以验证行为。

“It was the first one that actually seemed to consider the diff in the larger context of the program,” says Carter. “That was novel and eye‑opening.”

“它是第一个真正将 diff 置于整个程序更大上下文中加以考量的工具。”Carter 表示，“这种做法既新颖，又令人耳目一新。”

For many engineers, that shift changed how they engaged with AI review altogether. “I started treating Codex comments like real code review feedback,” says Ted Wexler, Senior Software Engineer at Datadog. “Not something I’d skim or ignore, but something worth paying attention to.”

对许多工程师而言，这一转变彻底改变了他们与 AI 评审互动的方式。“我开始把 Codex 的评论当作真正的代码评审反馈来对待，”Datadog 高级软件工程师 Ted Wexler 表示，“不再是随手略过或直接忽略的内容，而是值得认真关注的信息。”

## Focusing engineers on design over detection

## 聚焦设计，而非仅限于问题检测

Following the evaluation, Datadog deployed Codex more broadly across its engineering workforce. Today **more than 1,000 engineers** use it regularly.

在完成评估后，Datadog 将 Codex 更广泛地部署至其整个工程团队。如今，**已有超过 1,000 名工程师**定期使用该工具。

Feedback is largely surfaced organically rather than through formal in‑tool metrics. Engineers post to Slack about useful insights, constructive comments, and moments where Codex helped them think differently about a problem.

反馈主要以自然涌现的方式呈现，而非依赖正式的工具内指标。工程师们会在 Slack 上主动分享那些富有启发性的洞见、建设性的评论，以及 Codex 帮助他们以全新视角思考问题的关键时刻。

While time savings are significant, teams consistently pointed to a more meaningful shift in how work got done.

虽然节省的时间十分可观，但各团队一致指出，工作方式发生了更为深远的转变。

> “Codex changed my mind for what code review should be. It’s not about replicating our best human reviewers. It's about finding critical flaws and edge cases that humans struggle to see when reviewing changes in isolation.”

> “Codex 彻底改变了我对代码审查应有形态的认知。它并非旨在复制我们最优秀的人类审查员，而是要发现那些人类在孤立审查变更时难以察觉的关键缺陷和边界情况。”

—Brad Carter, Engineering Manager at Datadog

—Brad Carter，Datadog 工程经理

## Redefining code review around risk, not speed

## 以风险为中心，而非以速度为中心，重新定义代码审查

The broader impact for Datadog was a change in how code review itself is defined. Rather than treating review as a checkpoint for catching errors or optimizing cycle time, the team now sees Codex as a core reliability system that acts as a partner:

Datadog 所获得的更广泛影响，在于对“代码审查”这一环节本身的重新定义。团队不再将审查简单视为捕获错误或优化研发周期的检查点，而是将 Codex 视为一个核心可靠性系统，并作为开发者的协作伙伴：

- Surfacing risk beyond what individual reviewers can hold in context  
- 揭示超出单个审查员上下文理解能力的风险  
- Highlighting cross-module and cross-service interactions  
- 突显跨模块、跨服务的交互关系  
- Increasing confidence in shipping at scale  
- 提升大规模交付的信心  
- Allowing human reviewers to focus on architecture and design  
- 使人能将精力聚焦于架构与设计层面  

This shift aligns with how Datadog’s leaders frame engineering priorities, where reliability and trust matter as much as, if not more than, velocity.

这一转变与 Datadog 领导层对工程优先级的定位高度一致——可靠性与信任，其重要性至少不亚于（甚至高于）研发速度。

“We are the platform companies rely on when everything else is breaking,” says Carter. “Preventing incidents strengthens the trust our customers place in us.”

“当其他一切系统都崩溃时，企业所依赖的正是我们的平台。”Carter 表示，“预防事故的发生，将进一步巩固客户对我们的信任。”
&#123;% endraw %}
