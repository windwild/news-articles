---
title: "Workflow Builder: Build your own workflow automation platform - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/workflow-builder-build-your-own-workflow-automation-platform"
date: "2025-11-24"
scraped_at: "2026-03-02T09:24:51.826179425+00:00"
language: "en"
translated: false
description: "Workflow Builder is a free, open-source template, powered by Next.js and the Workflow DevKit, that helps you build workflow builder applications and agents."
---




Nov 24, 2025

Workflow Builder is an open-source Next.js template for building workflow automation platforms

Today we're open-sourcing [Workflow Builder](https://workflow-builder.dev/), a complete visual automation platform powered by the [Workflow Development Kit](https://useworkflow.dev/) (WDK).

The project includes a visual editor, execution engine, and infrastructure, giving you what you need to build your own workflow automation tools and agents. Deploy it to Vercel and customize it for your use case.

[**Deploy the Workflow Builder**\\
\\
Deploy your own Workflow Builder with one click.\\
\\
Deploy](https://vercel.com/templates/ai/workflow-builder)

## What's included in Workflow Builder

Workflow Builder is a production-ready Next.js application with a fully interactive workflow editor, AI-assisted workflow generation, six prebuilt integration modules, and end-to-end observability.

### Visual workflow editor

The visual workflow editor lets you build, connect, and execute workflows using drag-and-drop steps. You get real-time validation, undo/redo, auto-save, and persistent state without writing code.

Prebuilt integrations include:

- Resend (emails)

- Linear (issues)

- Slack (notifications)

- PostgreSQL (database)

- HTTP requests (API calls)

- [Vercel AI Gateway](https://vercel.com/ai-gateway) (AI models)


### AI-powered text-to-workflow generation

The AI-powered text-to-workflow feature converts natural language prompts into executable workflows. Type a description of your automation, and the system generates structured step definitions and connections.

### Webhook triggers

Webhook triggers connect your workflows to external apps and APIs. External events, services, or data sources can trigger workflow execution in real time.

### Referencing outputs from previous steps

Each workflow step can access and reference outputs from previous steps. This creates dynamic, data-driven processes and enables agentic workflows where later steps depend on earlier results.

### Workflow code generation

Every visual workflow compiles into executable TypeScript via the Workflow Development Kit (WDK). The `"use workflow"` and `"use step"` directives transform your functions into a runtime execution graph that handles state management, error handling, and step coordination.

![](images/workflow-builder-build-your-own-workflow-automation-platform-vercel/img_001.jpg)![](images/workflow-builder-build-your-own-workflow-automation-platform-vercel/img_002.jpg)

## Use cases for Workflow Builder

With Workflow Builder, you have the foundation to build your own workflow automation platform for internal tools or customer-facing products:

- **Agents:** Execute multi-step, cross-system workflows powered by AI

- **Internal tools**: Custom automation systems tailored to your organization’s processes and systems

- **Customer-facing workflow tools**: Offer domain-specific workflow builders like Zapier or n8n

- **Integration platforms**: Add drag-and-drop workflow capabilities to your product

- **Data pipelines**: Design ETL or data processing pipelines with visual monitoring and execution tracking