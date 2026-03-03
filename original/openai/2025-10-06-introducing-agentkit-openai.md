---
title: "Introducing AgentKit | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-agentkit"
date: "2025-10-06"
scraped_at: "2026-03-02T10:09:36.625305254+00:00"
language: "en-US"
translated: false
description: "Today, we’re releasing  new tools to help developers go from prototype to production faster: AgentKit, expanded evals capabilities, and reinforcement fine-tuning for agents."
---

October 6, 2025


# Introducing AgentKit

New tools for building, deploying, and optimizing agents.



Today we’re launching AgentKit, a complete set of tools for developers and enterprises to build, deploy, and optimize agents. Until now, building agents meant juggling fragmented tools—complex orchestration with no versioning, custom connectors, manual eval pipelines, prompt tuning, and weeks of frontend work before launch. With AgentKit, developers can now design workflows visually and embed agentic UIs faster using new building blocks like:

- **Agent Builder:** a visual canvas for creating and versioning multi-agent workflows
- **Connector Registry:** a central place for admins to manage how data and tools connect across OpenAI products
- **ChatKit:** a toolkit for embedding customizable chat-based agent experiences in your product

We’re also expanding evaluation capabilities with new features like datasets, trace grading, automated prompt optimization, and third-party model support to measure and improve agent performance.

Since releasing the [Responses API and Agents SDK⁠](https://openai.com/index/new-tools-for-building-agents/) in March, we’ve seen developers and enterprises build end-to-end agentic workflows for deep research, customer support, and more. Klarna [built a support agent⁠](https://openai.com/index/klarna/) that handles two-thirds of all tickets and Clay [10x’ed growth⁠](https://openai.com/index/clay/) with a sales agent. AgentKit builds on the Responses API to help developers build agents more efficiently and reliably.

## Design workflows with Agent Builder

As agent workflows grow more complex, developers need clearer visibility into how they work. [Agent Builder⁠(opens in a new window)](https://platform.openai.com/docs/guides/agents/agent-builder) provides a visual canvas for composing logic with drag-and-drop nodes, connecting tools, and configuring custom guardrails. It supports preview runs, inline eval configuration, and full versioning—ideal for fast iteration.

![Interface view of a customer service automation flow in a visual builder tool. The canvas shows connected nodes labeled Start, Jailbreak guardrail, Classification agent, If/else, Return agent, Retention agent, Information agent, Hallucination guardrail, and End. A sidebar on the left lists available node types such as Agent, Note, File search, Guardrails, MCP, and User approval. Top controls include options for Evaluate, Code, Preview, and Publish.](images/introducing-agentkit-openai/img_001.png)

Builders can get started with a blank canvas or with prebuilt templates.

At Ramp, the team went from a blank canvas to a buyer agent in just a few hours:

> Agent Builder transformed what once took months of complex orchestration, custom code, and manual optimizations into just a couple of hours. The visual canvas keeps product, legal, and engineering on the same page, slashing iteration cycles by 70% and getting an agent live in two sprints rather than two quarters.”

— Ramp

Similarly, LY Corporation—a leading Japanese technology and internet services company—built a work assistant agent with Agent Builder in less than two hours.

> "Agent Builder allowed us to orchestrate agents in a whole new way, with engineers and subject matter experts collaborating all in one interface. We built our first multi-agentic workflow and ran it in less than two hours, dramatically accelerating the time to create and deploy agents."

— LY Corporation

We’re also launching a Connector Registry for enterprises to govern and maintain data across multiple workspaces and organizations. The [Connector Registry⁠(opens in a new window)](https://platform.openai.com/docs/guides/agents/connector-registry) consolidates data sources into a single admin panel across ChatGPT and the API. The registry includes all pre-built connectors like Dropbox, Google Drive, Sharepoint, and Microsoft Teams, as well as third-party MCPs.

Developers can also enable [Guardrails⁠(opens in a new window)](https://openai.github.io/openai-guardrails-python/) in Agent Builder—an open-source, modular safety layer that helps protect agents against unintended or malicious behavior. Guardrails can mask or flag PII, detect jailbreaks, and apply other safeguards, making it easier to build and deploy reliable, safe agents. Guardrails can be deployed standalone or via the guardrails library for [Python⁠(opens in a new window)](https://openai.github.io/openai-guardrails-python/) and [JavaScript⁠(opens in a new window)](https://openai.github.io/openai-guardrails-js/).

## Embed agentic chat experiences with ChatKit

Deploying chat UIs for agents can be surprisingly complex— handling streaming responses, managing threads, showing the model thinking, and designing engaging in-chat experiences. [ChatKit⁠(opens in a new window)](https://platform.openai.com/docs/guides/chatkit) makes it simple to embed chat-based agents that feel native to your product. It can be embedded into apps or websites and customized to match your theme or brand.

> "We saved over two weeks of time building a support agent for our Canva Developers community with ChatKit, and integrated it in less than an hour. This support agent will transform the way developers engage with our docs by turning it into a conversational experience, making it easy to build apps and integrations on Canva."

— Canva

ChatKit already powers a range of use cases, from internal knowledge assistants and onboarding guides to customer support and research agents. [HubSpot⁠(opens in a new window)](https://www.hubspot.com/)’s customer support agent is one example:

![Dashboard view of the Ramp platform showing an expense management interface. The main panel greets the user, Daniel, and lists requests such as ‘Request for ChatGPT Business’ (pending review) and ‘Request for HubSpot’ (draft), along with recent expenses for airlines, rideshares, and software. On the right, a software request form is open for ChatGPT Business, detailing 5 seats at $125 per month from October 1, 2025, to October 1, 2026, with a yellow ‘Submit request’ button.](images/introducing-agentkit-openai/img_002.png)

## Measure agent performance with new Evals capabilities

Building reliable, production-ready agents requires rigorous performance evaluations. Last year, we launched [Evals⁠(opens in a new window)](https://platform.openai.com/docs/guides/evals) to help developers test prompts and measure model behavior. We’re now adding four new capabilities that make it even easier to build evals:

- **Datasets**–rapidly build agent evals from scratch and expand them over time with automated graders and human annotations..
- **Trace grading**–run end-to-end assessments of agentic workflows and automate grading to pinpoint shortcomings.
- **Automated prompt optimization**–generate improved prompts based on human annotations and grader outputs.
- **Third-party model support**–evaluate models from other providers within the OpenAI Evals platform.

We’ve already seen major performance gains from customers using Evals.

> "The evaluation platform cut development time on our multi-agent due diligence framework by over 50%, and increased agent accuracy 30%."

— Carlyle

![Interface showing a dataset table with columns for Rating, Tone, Feedback, and Accuracy. Rows display entries with thumbs-up or thumbs-down icons, tone tags such as Professional, Friendly, Rude, and Bad, and accuracy results labeled Pass or Fail with a score of 3.5. The top toolbar includes options for Upload, Columns, Grade, Generate output, and Save.](images/introducing-agentkit-openai/img_003.png)

## Push agent performance with reinforcement fine-tuning

[Reinforcement fine-tuning⁠(opens in a new window)](https://platform.openai.com/docs/guides/reinforcement-fine-tuning) (RFT) lets developers customize our reasoning models. It is generally available on OpenAI o4-mini and in private beta for GPT‑5. We are working closely with dozens of customers to refine the RFT for GPT‑5 before wider release.

Today, we’re introducing two new features in that RFT beta designed to push agent performance even further:

- **Custom tool calls**–train models to call the right tools at the right time for better reasoning
- **Custom graders**–set custom evaluation criteria for what matters most in your use case

## Pricing & availability

Starting today, ChatKit and the new Evals capabilities are generally available to all developers. Agent Builder is available in beta, and Connector Registry is beginning its beta rollout to some API, ChatGPT Enterprise and Edu customers with a [Global Admin Console⁠(opens in a new window)](https://help.openai.com/en/articles/12289294-coming-soon-global-admin-console)(where Global Owners can manage domains, SSO, multiple API orgs). The Global Admin console is a pre-requisite to enabling Connector Registry. All of these tools are included with standard API model pricing.

We plan to add a standalone Workflows API and agent deployment options to ChatGPT soon.

We can’t wait to see what you build.

- [2025](https://openai.com/news/?tags=2025)
- [DevDay](https://openai.com/news/?tags=devday)