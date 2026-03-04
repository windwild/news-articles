---
title: "Catch production failures early with LangSmith Alerts"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-alerts/"
date: "2025-04-22"
scraped_at: "2026-03-03T07:34:31.148743128+00:00"
language: "en-zh"
translated: true
description: "Set up real‑time notifications on error rates, run latency & feedback scores to spot failures before your customers do."
tags: ["agent builder"]
---
&#123;% raw %}

Great user experiences start with reliable applications. That’s why catching failures _before_ they reach your users is key. To help you stay ahead, we’ve launched **Alerts in LangSmith—** making it easier to monitor your LLM apps and agents in real time.

卓越的用户体验始于可靠的应用程序。因此，在问题影响用户之前就及时发现故障至关重要。为助您抢占先机，我们正式推出 **LangSmith 告警功能（Alerts in LangSmith）**，让您能够更轻松地实时监控大语言模型（LLM）应用与智能体（agents）。

We now support setting alerts based on key metrics like **error rate**, **run latency**, and **feedback scores**.

目前，我们已支持基于关键指标（如 **错误率（error rate）**、**运行延迟（run latency）** 和 **反馈评分（feedback scores）**）配置告警。

If you’re already sending production traces to LangSmith, you can [set up your first alert](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com) today. New to tracing? [Get started with tracing](https://docs.smith.langchain.com/observability?ref=blog.langchain.com) in LangSmith.

如果您已在将生产环境的追踪数据（traces）发送至 LangSmith，那么今天即可 [配置您的首个告警](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com)。尚不熟悉追踪？请立即 [开始使用 LangSmith 追踪功能](https://docs.smith.langchain.com/observability?ref=blog.langchain.com)。

![](images/catch-production-failures-early-with-langsmith-alerts/img_001.png)LangSmith Alerts Configuration

![](images/catch-production-failures-early-with-langsmith-alerts/img_001.png)LangSmith 告警配置界面

## Why proactive monitoring matters

## 为何主动监控至关重要

Monitoring and alerting are critical for any production app— but LLM-powered applications bring unique challenges, which primarily fall into two categories:

对任何生产级应用而言，监控与告警都至关重要；而由大语言模型驱动的应用则带来了独特的挑战，主要可归为以下两大类：

### **Dependence on External Services:**

### **对外部服务的依赖性：**

Agentic apps inherently rely on numerous dependencies — you might use one (or many) model providers and have a number of tools such as APIs, web search services, and databases available to your agent. Outages, rate limits, or increased latency from these dependencies can significantly degrade user experience. Proactive monitoring helps you identify these issues quickly.

智能体类应用（agentic apps）天然依赖大量外部组件——您可能调用一个或多个大模型服务商，并为智能体集成了各类工具，例如 API、网络搜索服务和数据库等。这些依赖组件一旦发生宕机、遭遇调用频率限制（rate limits），或响应延迟升高，都将显著损害用户体验。主动监控可助您快速定位此类问题。

### **Quality & Correctness**

### **输出质量与准确性**

User experience isn't just about speed; it's also about the _quality_ of the LLM's output. LLMs don't always behave predictably— small changes in prompts, models, or inputs can unexpectedly impact results.

用户体验不仅关乎响应速度，更取决于大语言模型（LLM）输出的 _质量_。LLM 的行为并非总是可预测的——提示词（prompts）、模型本身或输入数据的细微变动，都可能出人意料地影响最终结果。

Prompts that perform well in controlled evaluations can also sometimes regress in real-world scenarios due to differences in user interactions. Alerts based on feedback scores (from [user input](https://docs.smith.langchain.com/evaluation/how_to_guides/attach_user_feedback?ref=blog.langchain.com) or [online evaluations](https://docs.smith.langchain.com/observability/how_to_guides/online_evaluations?ref=blog.langchain.com#configure-llm-as-judge-evaluators)) provide an early warning system for these quality dips.

在受控评估中表现良好的提示词，在真实场景中有时也会因用户交互方式的差异而出现性能退化。基于反馈分数（来自[用户输入](https://docs.smith.langchain.com/evaluation/how_to_guides/attach_user_feedback?ref=blog.langchain.com)或[在线评估](https://docs.smith.langchain.com/observability/how_to_guides/online_evaluations?ref=blog.langchain.com#configure-llm-as-judge-evaluators)）的告警机制，可为这类质量下降提供早期预警。

## LangSmith Alerts Overview

## LangSmith 告警功能概览

LangSmith supports alerting on the following metrics:

LangSmith 支持对以下指标触发告警：

1. **Error Count and Rate**  
2. **Average Latency**  
3. **Average Feedback Score**  

1. **错误次数与错误率**  
2. **平均延迟**  
3. **平均反馈得分**  

For each alert metric, you can leverage a robust set of filters to focus on specific subsets of runs (e.g., filtering by model, tool call or run type).

针对每一项告警指标，您均可使用一套强大的过滤器，聚焦于特定子集的运行记录（例如：按模型、工具调用或运行类型进行筛选）。

![](images/catch-production-failures-early-with-langsmith-alerts/img_002.png)

![](images/catch-production-failures-early-with-langsmith-alerts/img_002.png)

You can then set an aggregation windows (5 or 15 minutes) and a threshold to tune the sensitivity of alerts.

随后，您可以设置聚合时间窗口（5 分钟或 15 分钟）及阈值，以精细调节告警的灵敏度。

The last step is integrating the alert into your existing workflows. We support alerts via PagerDuty or setting up a custom webhook (e.g., to send notifications directly to a Slack channel).

最后一步是将告警集成至您现有的工作流中。我们支持通过 PagerDuty 发送告警，也支持配置自定义 Webhook（例如：直接向 Slack 频道发送通知）。

And thats it! [Check out our docs](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com) to learn more and get started today with alerting in LangSmith.

就这样！[请查阅我们的文档](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com)，了解更多信息，并立即开始在 LangSmith 中启用告警功能。

## What's Next?

## 下一步是什么？

Alerting is a key piece to any observability product. In the future, we will be adding:

- More types of alerts: run count and LLM token usage  
- Change alerts that allow you to set a relative value to alert over (e.g. alert when latency spikes 25%)  
- Alerts over custom time windows  

告警功能是任何可观测性产品的核心组成部分。未来，我们将陆续推出以下能力：

- 更多类型的告警：运行次数告警与大语言模型（LLM）Token 使用量告警  
- 变化量告警（Change Alerts）：支持设置相对阈值进行告警（例如：当延迟激增 25% 时触发告警）  
- 自定义时间窗口告警  

If you have feedback or feature requests, let us know what you think by getting in touch with us through the [LangChain Slack Community](https://langchaincommunity.slack.com/?ref=blog.langchain.dev). If you’re not part of the Slack community yet, sign up [here](https://www.langchain.com/join-community?ref=blog.langchain.dev).

如果您有任何反馈或功能需求，欢迎通过 [LangChain Slack 社区](https://langchaincommunity.slack.com/?ref=blog.langchain.dev) 与我们联系。若您尚未加入 Slack 社区，可点击此处 [注册](https://www.langchain.com/join-community?ref=blog.langchain.dev)。

### Tags

### 标签

[![Agent Builder now available in Public Beta](images/catch-production-failures-early-with-langsmith-alerts/img_003.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder 现已开放公开测试（Public Beta）**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[agent builder](https://blog.langchain.com/tag/agent-builder/) 阅读时长：6 分钟

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/catch-production-failures-early-with-langsmith-alerts/img_004.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)

[**重磅发布 Align Evals：简化大语言模型（LLM）应用评估流程**](https://blog.langchain.com/introducing-align-evals/)

[![Pairwise Evaluations with LangSmith](images/catch-production-failures-early-with-langsmith-alerts/img_005.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**使用 LangSmith 进行成对评估**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[![Access Control Updates for LangSmith](images/catch-production-failures-early-with-langsmith-alerts/img_006.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**LangSmith 访问控制更新**](https://blog.langchain.com/access-control-updates-for-langsmith/)

[![LangSmith's Latest Feature: Grouped Monitoring Charts](images/catch-production-failures-early-with-langsmith-alerts/img_007.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith's Latest Feature: Grouped Monitoring Charts**](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith 最新功能：分组监控图表**](https://blog.langchain.com/grouped-monitoring-charts/)
&#123;% endraw %}
