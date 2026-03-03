---
title: "Anyone can build agents, but it takes a platform to run them - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/anyone-can-build-agents-but-it-takes-a-platform-to-run-them"
date: "2026-02-09"
scraped_at: "2026-03-02T09:21:34.900059187+00:00"
language: "en"
translated: false
description: "Why competitive advantage in AI comes from the platform you deploy agents on, not the agents themselves."
---




Feb 9, 2026

Prototyping is democratized, but production deployment isn't.

AI models have commoditized code and agent generation, making it possible for anyone to build sophisticated software in minutes. Claude can scaffold a fully functional agent before your morning coffee gets cold. But that same AI will happily architect a $5,000/month DevOps setup when the system could run efficiently at $500/month.

In a world where anyone can build internal tools and agents, the build vs. buy equation has fundamentally changed. Competitive advantage no longer comes from whether you can build. It comes from rapid iteration on AI that solves real problems for your business and, more importantly, reliably operating those systems at scale.

To do that, companies need an internal AI stack as robust as their external product infrastructure. That's exactly what Vercel's agent orchestration platform provides.

![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_001.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_002.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_003.jpg)![Building agents is becoming easier, but running them reliably requires robust production operations underneath.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_004.jpg)Building agents is becoming easier, but running them reliably requires robust production operations underneath.

## Build vs. buy ROI has fundamentally changed

For decades, the economics of custom internal tools only made sense at large-scale companies. The upfront engineering investment was high, but the real cost was long-term operation with high SLAs and measurable ROI. For everyone else, buying off-the-shelf software was the practical option.

AI has fundamentally changed this equation. Companies of any size can now create agents quickly, and customization delivers immediate ROI for specialized workflows:

- OpenAI deployed an [internal data agent](https://openai.com/index/inside-our-in-house-data-agent/) to democratize analytics

- Vercel’s [lead qualification agent](https://www.businessinsider.com/ai-agent-entry-level-sales-jobs-vercel-2025-10) helps one SDR do the work of 10 (template [here](https://vercel.com/templates/ai/lead-processing-agent))

- Stripe built a [customer-facing financial impact calculator](https://vercel.com/blog/how-stripe-built-a-game-changing-app-in-a-single-flight-with-v0) (on a flight!)


Today the question isn’t build vs. buy. The answer is build _and run_. Instead of separating internal systems and vendors, companies need a single platform that can handle the unique demands of agent workloads.

### Every company needs an internal AI stack

The number of use cases for internal apps and agents is exploding, but here's the problem: production is still hard.

Vibe coding has created one of the largest shadow IT problems in history, and understanding production operations requires expertise in security, observability, reliability, and cost optimization. These skills remain rare even as building becomes easier.

The ultimate challenge for agents isn't building them, it's the platform they run on.

## The platform is the product: how our data agent runs on Vercel

![d0 uses Vercel's agent orchestration platform to answer hundreds of questions per day, reliably and securely.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_005.jpg)![d0 uses Vercel's agent orchestration platform to answer hundreds of questions per day, reliably and securely.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_006.jpg)![d0 uses Vercel's agent orchestration platform to answer hundreds of questions per day, reliably and securely.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_007.jpg)![d0 uses Vercel's agent orchestration platform to answer hundreds of questions per day, reliably and securely.](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_008.jpg)d0 uses Vercel's agent orchestration platform to answer hundreds of questions per day, reliably and securely.

Like OpenAI, we built our own internal data agent named d0 (OSS template [here](https://vercel.com/templates/ai/oss-data-analyst-agent-reference-architecture)). At its core, d0 is a text-to-SQL engine, which is not a new concept. What made it a successful product was the platform underneath.

Using Vercel’s built-in primitives and deployment infrastructure, one person built d0 in a few weeks using 20% of their time.

This was only possible because Sandboxes, Fluid compute and AI Gateway automatically handled the operational complexity that would have normally taken months of engineering effort to scaffold and secure.

Today, d0 has completely democratized data access that was previously limited to professional analysts. Engineers, marketers, and executives can all ask questions in natural language and get immediate, accurate answers from our data warehouse.

Here’s how it works:

- **A user asks a question in Slack:**"What was our Enterprise ARR last quarter?" d0 receives the message, determines the right level of data access based on the permissions of the user, and starts the agent workflow.

- **The agent explores a semantic layer:** The semantic layer is a file system of 5 layers of YAML-based configs that describe our data warehouse, our metrics, our products, and our operations.

- **AI SDK handles the model calls:** Streaming responses, tool use, and structured outputs all work out of the box. We didn't build custom LLM plumbing, we used the same abstractions any Vercel developer can use.

- **Agent steps are orchestrated durably:** If a step fails (Snowflake timeout, model hiccup), Vercel Workflows handles retries and state recovery automatically.

- **Automated actions are executed in isolation**: File exploration, SQL generation, and query execution all happen in a secure Vercel Sandbox. Runaway operations can't escape, and the agent can execute arbitrary Python for advanced analysis.

- **Multiple models are used to balance cost and accuracy**: AI Gateway routes simple requests to fast models and complex analysis to Claude Opus, all in one code base.

- **The answer arrives in Slack:** formatted results, often with a chart or Google Sheet link, are delivered back to the Slack using the AI SDK Chatbot primitive.


## Vercel is the platform for agents

Vercel provides the infrastructure primitives purpose-built for agent workloads, both internal and customer-facing. You build the agent, Vercel runs it. And it just works.

Using our own agent orchestration platform has enabled us to build and manage an increasing number of custom agents.

Internally, we run:

- A lead qualification agent

- d0, our analytics agent

- A customer support agent (handles 87% percent of initial questions)

- An abuse detection agent that flags risky content

- A content agent that turns Slack threads into draft blog posts.


On the product side:

- v0 is a code generation agent, and

- Vercel Agent can review pull requests, analyze incidents, and recommend actions.


Both products run on the same primitives as our internal tools.

[**Sandboxes**](https://vercel.com/docs/vercel-sandbox) give agents a secure, isolated environment for executing sensitive autonomous actions. This is critical for protecting your core systems. When agents generate and run untested code or face prompt injection attacks, sandboxes contain the damage within isolated Linux VMs. When agents need filesystem access for information discovery, sandboxes can dynamically mount VMs with secure access to the right resources.

```tsx
import { Sandbox } from '@vercel/sandbox';



const sandbox = await Sandbox.create();



await sandbox.runCommand({

6  cmd: 'node',

7  args: ["-e", 'console.log("Hello from Vercel Sandbox!")'],

8  stdout: process.stdout,

9});



await sandbox.stop();
```

[**Fluid compute**](https://vercel.com/docs/fluid-compute) automatically handles the unpredictable, long-running compute patterns that agents create. It’s easy to ignore compute when agents are processing text, but when usage scales and you add data-heavy workloads for files, images, and video, cost becomes an issue quickly. Fluid compute automatically scales up and down based on demand, and you're only charged for compute time, keeping costs low and predictable.

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_009.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_010.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_011.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_012.jpg)

[**AI Gateway**](https://vercel.com/docs/ai-gateway) gives you unified access to hundreds of models with built-in budget control, usage monitoring, and load balancing across providers. This is important for avoiding vendor lock-in and getting instant access to the latest models. When your agent needs to handle different types of queries, AI Gateway can route simple requests to fast, inexpensive models while sending complex analysis to more capable ones. If your primary provider hits rate limits or goes down, traffic automatically fails over to backup providers.

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_013.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_014.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_015.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_016.jpg)

[**Workflows**](https://useworkflow.dev/) give agents the ability to perform complex, multi-step operations reliably. When agents are used for critical business processes, failures are costly. Durable orchestration provides retry logic and error handling at every step so that interruptions don't require manual intervention or restart the entire operation.

![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_017.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_018.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_019.jpg)![](images/anyone-can-build-agents-but-it-takes-a-platform-to-run-them-vercel/img_020.jpg)

[**Observability**](https://vercel.com/docs/observability/insights) reveals what agents are actually doing beyond basic system metrics. This data is essential for debugging unexpected behavior and optimizing agent performance. When your agent makes unexpected decisions, consumes more tokens than expected, or underperforms, observability shows you the exact prompts, model responses, and decision paths, letting you trace issues back to specific model calls or data sources.

## Build your agents, Vercel will run them

In the future, every enterprise will build their version of d0. And their internal code review agent. And their customer support routing agent. And hundreds of other specialized tools.

The success of these agents depends on the platform that runs them. Companies who invest in their internal AI stack now will not only move faster, they'll experience far higher ROI as their advantages compound over time.