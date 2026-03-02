---
title: "How Clay uses LangSmith to debug, evaluate, and monitor 300 million agents runs per month"
source: "LangChain Blog"
url: "https://blog.langchain.com/customers-clay/"
date: "2026-03-01"
scraped_at: "2026-03-02T09:19:42.019078+00:00"
language: "en"
translated: false
description: "Clay is the creative tool for growth — a platform where go-to-market teams build, enrich, and activate lists of companies and people. Sales teams use Clay to source target accounts, qualify leads wi..."
---

[Clay](https://clay.com/?ref=blog.langchain.com) is the creative tool for growth — a platform where go-to-market teams build, enrich, and activate lists of companies and people. Sales teams use Clay to source target accounts, qualify leads with AI-powered research, draft personalized outreach, and route opportunities through their CRM. Clay's customers range from fast-growing startups to large enterprise teams, all relying on the platform to power their outbound motion at scale.

Today, Clay runs approximately **300 million AI agent runs per month**— each one a multi-step reasoning process that might scrape web pages, synthesize research, qualify an account against an ICP, or draft personalized messaging. To maintain quality, control costs, and keep up with the breakneck pace of model releases, Clay relies on LangSmith as its observability and evaluation backbone.

(To listen to the full conversation, check out the video below.)

## From chat completions to 300 million agent runs

Clay's AI journey started simply: teams used chat completions to summarize long documents and write outbound copy. But Clay's engineers quickly noticed something more interesting happening. Users were pulling down web pages, scraping content, and asking AI to extract insights from those pages autonomously. That user behavior became the blueprint for Claytent — Clay's AI web research agent — which launched in mid-2023, just weeks into the GPT-4 era.

Today, AI is woven into every stage of the customer acquisition lifecycle. Clay has built agents across all three phases of its core value proposition:

- Find: Agentic search that sources target accounts from Clay's company and people database or the open web, using reasoning to evaluate ICP fit
- Close: Research agents that enrich accounts with relevant context, qualify them with structured reasoning, and draft personalized outreach sequences
- Grow: Agents that help customers expand existing accounts by identifying upsell signals and generating tailored messaging

Each agent run involves between 10 and 30 steps, combining web searches, page crawls, document synthesis, and structured data extraction. With natural language inputs — users type into a blank text box and can ask for almost anything — the range of tasks is effectively unbounded. At **300 million runs per month**, even small quality or cost inefficiencies compound quickly.

## The challenge: quality, cost, and model proliferation at scale

As Clay's agent usage scaled, three distinct problems emerged that required purpose-built tooling to solve.

### Quality is hard to predict from offline benchmarks

The diversity of Clay's use cases makes production quality fundamentally unpredictable. A customer might use the same agent to qualify biotech companies in Germany one day and research venture-backed consumer startups in Southeast Asia the next. Because inputs are free-form natural language, the surface area for unexpected agent behavior is enormous. Catching quality regressions requires observing real traffic, not synthetic test sets.

### Cost reconciliation is a moving target

At Clay's scale, inference costs are a material business expense. Clay offers users the ability to select their preferred model provider — Anthropic, OpenAI, and others — and runs a meta-prompter that automatically maps prompts to the model best suited for each task type. With multiple providers, dynamic model routing, and hundreds of millions of monthly runs, understanding exactly where money is being spent and whether internal pricing for users is accurate was nearly impossible without a unified observability layer.

### New models arrive faster than internal tooling can keep up

The pace of model releases — "a new model every week," as Jeff Barg (Head of AI at Clay) put it, means Clay constantly needs to evaluate whether a new model deserves a place in the routing map. Without structured evaluation infrastructure, each model assessment was manual, slow, and hard to reproduce.

## LangSmith as the observability layer: from day zero to production

Clay integrated LangSmith early in their agent development process — tracing is turned on at day zero for every new agent. The integration itself took a single line of code, built on top of OpenAI's SDK. Despite Clay running a custom agent harness, the integration was seamless.

### Zero-to-one: building agents with full trace visibility

When building new agents, the LangSmith trace view is part of the iteration loop from the very first run. Engineers stream traces in real time and step through the full execution tree — seeing exactly what the agent saw, what tools it called, what the model returned, and where things went wrong. This matters because what the end user sees is only the final output, not the full agent trace.

LangSmith's ability to represent nested subagent calls and tool invocations in a structured, readable way was a key factor in Clay's decision to use it. The UI is fast enough that 25–50 engineers across Clay's AI organization — including some customer support team members who use it to debug customer-reported issues — can navigate traces efficiently without training.

As Jeff puts it: "LangSmith feels like a platform built by people who have actually built an agent framework. That really shines through in how it handles nested subagents and tool call paths."

### Production monitoring: understanding patterns across millions of runs

In production, LangSmith provides Clay with aggregate visibility across usage patterns, cost profiles, error rates, latency distributions, and output quality — all sliced by customer workspace and model provider. When a customer reports a problem, engineers can immediately pull up the relevant traces and identify whether the failure was a tool call error, an inference issue, or a prompt quality problem.

The ability to export to Snowflake, which allows their data team to run custom analyses on trace data over time has also been helpful. This allows the data team to track cost trends, identify anomalous workspaces, and model the economics of new model introductions before committing to updated pricing.

### Evaluation: benchmarks that reflect real traffic

Clay uses LangSmith for offline evaluations when assessing model changes or prompt updates. Their evaluation framework combines two approaches:

- Deterministic match evals for structured outputs, where the agent's answer is compared against known ground truth
- LLM-as-a-judge evals for research and synthesis tasks, where the agent produces a paragraph of analysis that must be scored for accuracy and relevance

When a new model is released, Clay uses these evaluations to update the meta-prompter's routing map — identifying which use cases the model excels at and pricing it accordingly. LangSmith's dataset management makes it possible to run these benchmarks quickly and track performance deltas across model versions.

## Achieving near-perfect cost reconciliation at massive scale

When asked to quantify LangSmith's impact, Jeff mentioned that:

> "Before LangSmith, we really didn't have a good sense of where we were spending money across different inference providers. With LangSmith, we now have around a **99–99.5% reconciliation rate** between our LangSmith data and the actual bills we receive. Our finance team loves us for that." — Jeff Barg, Head of AI, Clay

At 300 million agent runs per month across multiple model providers, that reconciliation figure represents a huge reduction in financial uncertainty. Clay now prices agent runs to end users with confidence, adjusting pricing quickly — often on the day of a model launch — instead of waiting weeks for invoice data to arrive. This also means Clay can pass model cost reductions directly to customers faster, a meaningful competitive advantage in a market where AI inference costs are declining rapidly.

Beyond cost reconciliation, LangSmith has helped compress the debugging loop for Clay's engineering teams by making tracing available from day one of agent development. Customer support team members can also resolve agent quality complaints directly in LangSmith without escalating to engineering — reducing both resolution time and engineering interruption costs.

Clay also credits LangSmith's platform reliability — specifically the speed and consistency of trace ingest at scale — as a meaningful factor in sustaining developer productivity. At hundreds of millions of monthly runs, any observability tool that couldn't keep up with ingest volume would create blind spots precisely when visibility matters most.

## Looking ahead: Agents with longer time horizons

As Clay's agents become more complex — running longer, spanning more steps, and coordinating more subagents — they're relying increasingly on LangSmith's threads feature to track multi-turn interactions across extended time horizons. They're also experimenting with background coding agents as part of their software development lifecycle, inspired by similar work at companies like Ramp.

## Conclusion

Clay has built one of the most operationally sophisticated AI agent systems in the B2B SaaS world, running 300 million agent runs a month across a model-agnostic, multi-provider stack. LangSmith provides the observability foundation that makes that scale manageable: day-zero tracing for new agent development, production monitoring across usage and cost patterns, structured evaluation infrastructure for model assessments, and near-perfect cost reconciliation that directly informs pricing decisions.