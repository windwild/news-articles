---
title: "Catch production failures early with LangSmith Alerts"
source: "LangChain Blog"
url: "https://blog.langchain.com/langsmith-alerts/"
date: "2025-04-22"
scraped_at: "2026-03-03T07:34:31.148743128+00:00"
language: "en"
translated: false
description: "Set up real‑time notifications on error rates, run latency & feedback scores to spot failures before your customers do."
tags: ["agent builder"]
---

Great user experiences start with reliable applications. That’s why catching failures _before_ they reach your users is key. To help you stay ahead, we’ve launched **Alerts in LangSmith—** making it easier to monitor your LLM apps and agents in real time.

We now support setting alerts based on key metrics like **error rate**, **run latency**, and **feedback scores**.

If you’re already sending production traces to LangSmith, you can [set up your first alert](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com) today. New to tracing? [Get started with tracing](https://docs.smith.langchain.com/observability?ref=blog.langchain.com) in LangSmith.

![](images/catch-production-failures-early-with-langsmith-alerts/img_001.png)LangSmith Alerts Configuration

## Why proactive monitoring matters

Monitoring and alerting are critical for any production app— but LLM-powered applications bring unique challenges, which primarily fall into two categories:

### **Dependence on External Services:**

Agentic apps inherently rely on numerous dependencies — you might use one (or many) model providers and have a number of tools such as APIs, web search services, and databases available to your agent. Outages, rate limits, or increased latency from these dependencies can significantly degrade user experience. Proactive monitoring helps you identify these issues quickly.

### **Quality & Correctness**

User experience isn't just about speed; it's also about the _quality_ of the LLM's output. LLMs don't always behave predictably— small changes in prompts, models, or inputs can unexpectedly impact results.

Prompts that perform well in controlled evaluations can also sometimes regress in real-world scenarios due to differences in user interactions. Alerts based on feedback scores (from [user input](https://docs.smith.langchain.com/evaluation/how_to_guides/attach_user_feedback?ref=blog.langchain.com) or [online evaluations](https://docs.smith.langchain.com/observability/how_to_guides/online_evaluations?ref=blog.langchain.com#configure-llm-as-judge-evaluators)) provide an early warning system for these quality dips.

## LangSmith Alerts Overview

LangSmith supports alerting on the following metrics:

1. **Error Count and Rate**
2. **Average Latency**
3. **Average Feedback Score**

For each alert metric, you can leverage a robust set of filters to focus on specific subsets of runs (e.g., filtering by model, tool call or run type).

![](images/catch-production-failures-early-with-langsmith-alerts/img_002.png)

You can then set an aggregation windows (5 or 15 minutes) and a threshold to tune the sensitivity of alerts.

The last step is integrating the alert into your existing workflows. We support alerts via PagerDuty or setting up a custom webhook (e.g., to send notifications directly to a Slack channel).

And thats it! [Check out our docs](https://docs.smith.langchain.com/observability/how_to_guides/alerts?ref=blog.langchain.com) to learn more and get started today with alerting in LangSmith.

## What's Next?

Alerting is a key piece to any observability product. In the future, we will be adding:

- More types of alerts: run count and LLM token usage
- Change alerts that allow you to set a relative value to alert over (e.g. alert when latency spikes 25%)
- Alerts over custom time windows

If you have feedback or feature requests, let us know what you think by getting in touch with us through the [LangChain Slack Community](https://langchaincommunity.slack.com/?ref=blog.langchain.dev). If you’re not part of the Slack community yet, sign up [here](https://www.langchain.com/join-community?ref=blog.langchain.dev).

### Tags



[![Agent Builder now available in Public Beta](images/catch-production-failures-early-with-langsmith-alerts/img_003.png)](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[**LangSmith Agent Builder now in Public Beta**](https://blog.langchain.com/langsmith-agent-builder-now-in-public-beta/)

[agent builder](https://blog.langchain.com/tag/agent-builder/) 6 min read

[![Introducing Align Evals: Streamlining LLM Application Evaluation](images/catch-production-failures-early-with-langsmith-alerts/img_004.png)](https://blog.langchain.com/introducing-align-evals/)

[**Introducing Align Evals: Streamlining LLM Application Evaluation**](https://blog.langchain.com/introducing-align-evals/)


[![Pairwise Evaluations with LangSmith](images/catch-production-failures-early-with-langsmith-alerts/img_005.png)](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)

[**Pairwise Evaluations with LangSmith**](https://blog.langchain.com/pairwise-evaluations-with-langsmith/)


[![Access Control Updates for LangSmith](images/catch-production-failures-early-with-langsmith-alerts/img_006.png)](https://blog.langchain.com/access-control-updates-for-langsmith/)

[**Access Control Updates for LangSmith**](https://blog.langchain.com/access-control-updates-for-langsmith/)


[![LangSmith's Latest Feature: Grouped Monitoring Charts](images/catch-production-failures-early-with-langsmith-alerts/img_007.png)](https://blog.langchain.com/grouped-monitoring-charts/)

[**LangSmith's Latest Feature: Grouped Monitoring Charts**](https://blog.langchain.com/grouped-monitoring-charts/)