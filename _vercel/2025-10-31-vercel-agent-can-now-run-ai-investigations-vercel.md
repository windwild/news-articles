---
title: "Vercel Agent can now run AI investigations - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-agent-can-now-run-ai-investigations"
date: "2025-10-31"
scraped_at: "2026-03-02T09:26:21.619751071+00:00"
language: "en-zh"
translated: true
description: "Vercel Agent Investigation intelligently conducts incident response investigations to alert, analyze, and suggest remediation steps"
---

render_with_liquid: false
Oct 31, 2025

2025 年 10 月 31 日

Vercel is reimagining incident response for the agentic age.

Vercel 正在为“智能体时代”重新构想事件响应机制。

At [Ship AI](https://vercel.com/blog/ship-ai-2025-recap), we launched Vercel Agent Investigations in Public Beta, a new skill of Vercel Agent that automatically detects issues in your application, conducts root cause analysis, and provides actionable remediation plans to resolve incidents faster. Vercel Agent already helps teams with AI-powered code reviews. Now, it's expanding to help with incident response.

在 [Ship AI](https://vercel.com/blog/ship-ai-2025-recap) 大会上，我们正式推出 **Vercel Agent Investigations（公测版）**——这是 Vercel Agent 的一项全新能力：可自动检测应用中的异常问题、开展根因分析，并提供切实可行的修复方案，从而加速事件解决。Vercel Agent 已通过 AI 驱动的代码审查助力开发团队；如今，其能力进一步延伸至事件响应领域。

By combining our newly-released [anomaly alerts](https://vercel.com/docs/alerts) with investigations, we're improving how development teams respond to and resolve production issues.

我们将新发布的 [异常告警（Anomaly Alerts）](https://vercel.com/docs/alerts) 与调查能力深度整合，全面提升开发团队对生产环境问题的响应与解决效率。

## The hidden cost of incident response for development teams

## 开发团队事件响应背后的隐性成本

Modern web applications can generate overwhelming amounts of raw logs and metrics. Every deployment, every user interaction, and every API call produces data that could signal the difference between smooth operations and a critical incident.

现代 Web 应用会产生海量原始日志与指标数据。每一次部署、每一次用户交互、每一次 API 调用，都可能生成关键信号——这些信号往往决定着系统是平稳运行，还是陷入严重故障。

When a build deployment goes wrong, someone needs to investigate. The modern pace of development means teams are shipping faster than ever, which makes incident investigation increasingly challenging to manage. Hours spent on incident response compound quickly, pulling engineering resources away from feature development and reducing overall team velocity.

当构建部署失败时，总有人必须介入调查。而当今开发节奏日益加快，团队交付速度前所未有，这使得事件调查工作愈发难以高效管理。大量时间耗费在事件响应上，不仅持续挤占工程师本可用于功能开发的人力资源，更显著拖慢整个团队的交付速度。

### The current state of incident response

### 当前事件响应的现状

Today's development teams face several operational challenges that slow development time and burn out teams. Poorly-tuned tools desensitize teams to critical alerts and allow false positives to slip through. Incidents create hours-long manual investigations and context switching that kill productivity, especially if there's a large knowledge and experience gap between team members. Post-mortems and post-incident runbook updates that can prevent future incidents often become deprioritized to catch up on delayed work.

当前，开发团队正面临多项运营挑战，既拖慢开发进度，又加剧团队倦怠。配置不当的工具会削弱团队对关键告警的敏感度，导致误报漏报频发；每次事件都需耗费数小时进行人工排查与上下文切换，严重损害生产力——尤其当团队成员间存在显著的知识与经验断层时，问题更为突出；而本可用于预防未来事件的复盘会议（Post-mortems）和应急预案（Runbook）更新，却常常因追赶积压任务而被搁置。

## Vercel Agent Investigations reduce manual incident response

## Vercel Agent Investigations 降低人工事件响应负担

Investigations are our solution to reducing the manual work of incident response. Vercel Agent uses broad visibility across build time and runtime to automatically analyze incidents and identify root causes to run investigations natively within your application, without using third party tools.

调查（Investigations）是我们降低事件响应人工工作量的解决方案。Vercel Agent 依托对构建期（build time）和运行时（runtime）的广泛可观测性，自动分析事件、定位根本原因，并在您的应用内部原生执行调查，无需依赖第三方工具。

### Anomaly detection without configuration

### 无需配置的异常检测

Anomaly alerts continuously monitor your application for unusual activity, such as spikes in billable metrics like function duration or fast data transfer, or increases in `5xx` errors. There's no configuration needed. Any team subscribed to [Observability Plus](https://vercel.com/docs/observability/observability-plus) automatically gets anomaly alerts out-of-the-box.

异常告警（Anomaly alerts）持续监控您的应用是否存在异常活动，例如计费指标（如函数执行时长、快速数据传输量）的激增，或 `5xx` 错误率的上升。无需任何配置——所有订阅了 [Observability Plus](https://vercel.com/docs/observability/observability-plus) 的团队均可开箱即用地获得异常告警功能。

Once we detect an anomaly, Vercel Agent can step in and either automatically or on-demand, investigate the issue.

一旦检测到异常，Vercel Agent 即可介入，根据需要自动或按需开展问题调查。

![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_001.jpg)![When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_002.jpg)When anomalies occur, Vercel Agent investigates automatically to separate signal from noise, surface what deserves your attention, and suggest next steps.

![当异常发生时，Vercel Agent 自动开展调查，以区分有效信号与噪声，凸显值得关注的问题，并建议后续操作步骤。](images/vercel-agent-can-now-run-ai-investigations-vercel/img_001.jpg)![当异常发生时，Vercel Agent 自动开展调查，以区分有效信号与噪声，凸显值得关注的问题，并建议后续操作步骤。](images/vercel-agent-can-now-run-ai-investigations-vercel/img_002.jpg)当异常发生时，Vercel Agent 自动开展调查，以区分有效信号与噪声，凸显值得关注的问题，并建议后续操作步骤。

### AI-powered root cause analysis

### 由 AI 驱动的根本原因分析

Once we detect an anomaly, Agent performs the same analysis a senior engineer would, processing multiple streams of data and charts to identify issues in seconds, not hours.

一旦检测到异常，Agent 将执行与资深工程师同等深度的分析：综合处理多源数据流与可视化图表，在数秒内（而非数小时）定位问题。

The Vercel Agent analyzes issues with multiple inputs:

Vercel Agent 基于多种输入维度对问题进行分析：

- **Correlation analysis:** What other metrics changed around the same time? Did a deployment just complete? Did traffic patterns shift?

- **关联性分析（Correlation analysis）**：同一时段内还有哪些其他指标发生了变化？是否有新版本刚刚完成部署？流量模式是否发生了偏移？

- **Historical context**: Has this issue occurred before? What was the resolution last time?

- **历史上下文（Historical context）**：该问题此前是否出现过？上一次的解决方案是什么？

- **Dependency mapping**: Which upstream or downstream services might be affected? Is this a cascading failure?

- **依赖关系映射**：哪些上游或下游服务可能受到影响？这是否是一次级联故障？

- **Change attribution**: What code changes or configuration updates preceded the anomaly?

- **变更归因**：在异常发生前，有哪些代码变更或配置更新？

Agent generates a succinct summary that provides clear insights into what went wrong and why, eliminating the guesswork from incident response. Accelerating root-cause analysis during this critical time window improves time-to-remediation and reduces downtime for end-users.

Agent 生成简洁明了的摘要，清晰揭示问题所在及其根本原因，从而消除事故响应中的盲目猜测。在此关键时间窗口内加速根因分析，可显著缩短修复耗时（time-to-remediation），并减少终端用户的停机时间。

### Impact assessment and actionable recommendations

### 影响评估与可执行建议

Not every alert requires immediate action. Investigations assesses the severity and impact of each issue, helping teams prioritize their response. If an issue has already resolved itself, Investigations identifies this so teams can focus their attention elsewhere. For ongoing issues, Investigations determines whether the problem affects user experience, application stability, or specific subsystems.

并非所有告警都需要立即响应。Investigations（调查分析）会评估每个问题的严重程度与影响范围，协助团队合理确定响应优先级。若某问题已自行恢复，Investigations 将识别该情况，使团队得以将精力转向其他待办事项；对于持续存在的问题，Investigations 则判断其是否影响用户体验、应用稳定性，或特定子系统。

Based on its analysis, investigations provide specific, actionable steps tied to the root cause it identified. This eliminates the common problem of generic incident response playbooks that don't account for your specific application architecture or the nature of the failure.

基于上述分析，Investigations 提供与所识别根因紧密关联的具体、可执行操作步骤。此举有效避免了通用型事故响应手册的常见缺陷——即未适配您的具体应用架构或故障特性。

![Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_003.jpg)![Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it. ](images/vercel-agent-can-now-run-ai-investigations-vercel/img_004.jpg)

Vercel Agent investigates a spike in anomalous activity and describes the errors that caused it.

Vercel Agent 对异常活动激增现象展开调查，并描述引发该现象的具体错误。

## **Getting started with Vercel Agent Investigations**

## **开始使用 Vercel Agent Investigations**

Visit the [Agent tab](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent) in the Vercel dashboard to have it run automatically on all error alerts, or choose to run an investigation manually as long as you have Vercel Agent credits.

请访问 Vercel 控制台中的 [Agent 标签页](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fvercel-agent)，即可让 Investigations 在所有错误告警上自动运行；或者，只要您拥有 Vercel Agent 积分，也可选择手动触发调查分析。

Agent Investigations are only available to teams that have [Observability Plus](https://vercel.com/docs/observability/observability-plus), as they build upon its premium features. New Agent users can claim a $100 free credit to use towards both Vercel Agent Investigations and Code Reviews.

Agent Investigations 仅面向已订阅 [Observability Plus](https://vercel.com/docs/observability/observability-plus) 的团队提供，因其构建于 Observability Plus 的高级功能之上。新注册的 Agent 用户可领取 100 美元免费额度，用于 Vercel Agent Investigations 和代码审查（Code Reviews）。

Anomaly alerts are available out-of-the-box for Observability Plus subscribers. Email alerts are default for team owners and optional for team members. Additionally, we provide a Slack integration and webhooks for any communication, ticketing, or incident response tool.

异常告警（Anomaly alerts）开箱即用，所有 Observability Plus 订阅用户均可直接使用。邮件告警默认向团队所有者发送，对团队成员则为可选设置。此外，我们还提供 Slack 集成以及 Webhook 支持，可与各类通信、工单或事件响应工具对接。

Learn more about [Alerts](https://vercel.com/docs/alerts) or enable it on the [Observability dashboard](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Falerts) today.

了解更多关于 [告警（Alerts）](https://vercel.com/docs/alerts) 的信息，或立即前往 [Observability 控制台](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fobservability%2Falerts) 启用该功能。