---
title: "Vercel Ship AI 2025 recap - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/ship-ai-2025-recap"
date: "2025-10-27"
scraped_at: "2026-03-02T09:26:46.891536195+00:00"
language: "en"
translated: false
description: "Earlier this year we introduced the foundations of the AI Cloud: a platform for building intelligent systems that think, plan, and act. At Ship AI, we showed what comes next. What and how to build wit..."
---




Oct 27, 2025

Earlier this year we introduced the foundations of the [AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads): a platform for building intelligent systems that think, plan, and act. [Last week at Ship AI](https://vercel.com/ship/ai), we showed what comes next.

We launched new SDKs, infrastructure, and open source templates that make building production-ready agents as intuitive as building a standard feature. You can now define, deploy, and operate intelligent workflows on the same platform that powers your apps.

Whether you're building your first agent or delivering it to millions of users, these releases make AI development as accessible and scalable as web development.

## AI SDK 6 adds agent-first architecture

Define an agent once and reuse it across any app or workflow. Instead of wiring together prompts and APIs for each use case, [AI SDK 6](https://ai-sdk.dev/docs/introduction/announcing-ai-sdk-6-beta) introduces an agent abstraction that works everywhere.

Now in beta, AI SDK 6 includes:

- **Agent abstraction:** Define once, deploy everywhere

- **Tool execution approval:** Built-in human-in-the-loop review

- **Type-safe by design:** End-to-end type safety across models and UI


The new tool approval system lets you gate any action that needs human review. Define a tool with `needsApproval: true` and the agent will pause until someone confirms:

```typescript
const weather = tool({

2  description: 'Get the weather in a city',

3  inputSchema: z.object({ city: z.string() }),

4  needsApproval: true, // approval gate

5  execute: async ({ city }) => {

6    const weather = await fetchWeather(city);

7    return weather;

8  },

9});



11// Agent that can call the approved tool in a loop

export const agent = new ToolLoopAgent({

13  model: "openai/gpt-5",

14  instructions: 'You are a concise weather assistant.',

15  tools: { weather },

16});
```

An agent with human-in-the-loop approval for weather queries.

You can install the beta with `npm i ai@beta` to get started.

[**Get started with AI SDK 6**\\
\\
Explore the complete documentation for agent abstractions, tool approval patterns, and migration guides.\\
\\
Read the docs](https://v6.ai-sdk.dev/docs/introduction/announcing-ai-sdk-6-beta)

## Marketplace for Agents and AI tools

The [Vercel Marketplace](https://vercel.com/marketplace/category/agents) now lets you discover, install, and connect production-ready agents and AI services directly to your projects.

Agents like CodeRabbit, Corridor, and Sourcery automate development workflows, while integrations with Autonoma, Braintrust, Browser Use, Chatbase, Descope, Kernel, Kubiks, and Mixedbread bring model access, analytics, and observability into one place.

![Explore AI Agents and services in the Vercel Marketplace.](images/vercel-ship-ai-2025-recap-vercel/img_001.jpg)![Explore AI Agents and services in the Vercel Marketplace.](images/vercel-ship-ai-2025-recap-vercel/img_002.jpg)Explore AI Agents and services in the Vercel Marketplace.

Each integration includes unified billing, native observability, and secure credentials management to improve the experience in building on a network of AI-powered tools.

[**AI agents and services on the Vercel Marketplace**\\
\\
Learn how agents and services work together, and see the full launch cohort.\\
\\
Read the announcement](https://vercel.com/blog/ai-agents-and-services-on-the-vercel-marketplace)

## Workflow Development Kit brings reliability-as-code

Long-running work needs retries, background steps, and stateful checkpoints. Traditionally, that means wiring together message queues, schedulers, and state storage. `use workflow` turns reliability into code.

Add `use workflow` to any TypeScript function to make it durable:

- Automatically retries failed steps

- Persists progress between executions

- Adds built-in observability for every run


It's open source and runs on any platform, making async work reliable and observable. Works for AI agent loops, data pipelines, commerce workflows, or any process that needs to survive crashes and resume exactly where it stopped.

Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.

![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_003.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_004.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_005.jpg)![Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.](images/vercel-ship-ai-2025-recap-vercel/img_006.jpg)Vercel automatically detects when a function is durable and dynamically provisions the ideal infrastructure to support it in real time.

Read more about built-in durability with [Workflow Development Kit](https://vercel.com/blog/introducing-workflow).

[**Build durable workflows**\\
\\
Get started with the Workflow Development Kit documentation, examples, and quickstart guides.\\
\\
Get started](https://useworkflow.dev/)

## Vercel Agent joins your team

Vercel Agent is your intelligent assistant for shipping on Vercel.

The Agent reviews code, proposes validated patches, and investigates anomalies using real production data. When it detects performance or error spikes, it automatically opens an AI investigation and summarizes the cause and actionable next steps.

Now in beta, Vercel Agent includes:

- AI code reviews with validated suggestions

- Anomaly alerts that trigger automated investigations

- $100 promo credit to get started


[**Try Vercel Agent**\\
\\
Join the beta and get $100 credit to start using AI code reviews and automated investigations.\\
\\
Get started](https://vercel.com/agent)

## Python support with zero configuration

Python developers can now deploy on the AI Cloud with zero configuration.

Now in beta, the Vercel Python SDK runs frameworks like FastAPI and Flask natively on Vercel, while interacting with platform primitives such as Sandboxes, Blob storage, and Runtime Cache.

You can install the beta with `pip install vercel` to get started.

[**Zero-config Python backends on Vercel**\\
\\
Learn how to deploy FastAPI, Flask, and other Python frameworks with zero configuration.\\
\\
Learn more](https://vercel.com/changelog/vercel-python-sdk-in-beta)

## An Agent on every desk

We believe every company will run its own agents. Purpose-built assistants that accelerate real work. Our new program, An Agent on Every Desk, helps teams ship their first one.

We'll guide you from idea to production: identifying high-value workflows, providing starter templates, and getting an agent live fast.

[**Join the program**\\
\\
Work with our team to build and deploy your first production agent.\\
\\
Express interest](https://vercel.com/go/an-agent-on-every-desk)

### Open source lead agent

The new OSS lead agent helps go-to-market teams research and qualify inbound leads automatically.

Built with [Next.js](https://nextjs.org/), [AI SDK](https://ai-sdk.dev/), [Workflow DevKit](https://useworkflow.dev/), and the [Vercel Slack Adapter](https://vercel.com/marketplace/slack), it demonstrates how teams can combine open source components to automate daily work.

[**Deploy the lead agent**\\
\\
Clone the template and customize it for your go-to-market workflows.\\
\\
View template](https://vercel.com/oss-lead-agent)

## Open source data analyst agent

The OSS Data Analyst Agent brings natural language analytics to your team.

It connects Slack and SQL so anyone can ask questions about their data and get instant, query-driven answers. It's a reference architecture for building your own text-to-SQL agents with the AI SDK.

[**Deploy the data analyst agent**\\
\\
Get the template and connect it to your database and Slack workspace.\\
\\
View template](https://vercel.com/oss-data-analyst)

### The future of the AI Cloud

Ship AI brought the tools for moving from calling models to building agents that actually work in production. The SDK handles the abstraction. Workflows make things durable. The marketplace gives you ready-made agents or the services to build your own. Python support means your backend frameworks run here too.

The pieces fit together because they solve the same problem: making agent development feel like web development. Define your logic, deploy it, let the platform handle the rest.

You can just ship agents.