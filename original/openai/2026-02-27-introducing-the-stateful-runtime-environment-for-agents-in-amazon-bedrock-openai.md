---
title: "Introducing the Stateful Runtime Environment for Agents in Amazon Bedrock | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-the-stateful-runtime-environment-for-agents-in-amazon-bedrock"
date: "2026-02-27"
scraped_at: "2026-03-02T10:08:17.048291201+00:00"
language: "en-US"
translated: false
description: "Stateful Runtime for Agents in Amazon Bedrock brings persistent orchestration, memory, and secure execution to multi-step AI workflows powered by OpenAI."
tags: ["Company"]
---

February 27, 2026


# Introducing the Stateful Runtime Environment for Agents in Amazon Bedrock



AI agents excel at reasoning. The harder part is operational: running multi-step work reliably over time, across real tools and real systems, with the right controls.

Today, we’re making this easier for customers through a partnership and joint collaboration with Amazon to deliver the new **Stateful Runtime Environment that runs natively in Amazon Bedrock.** AWS customers will have access to the Runtime Environment, powered by OpenAI models, optimized for AWS infrastructure and tailored for agentic workflows, with the state, reliability, and governance needed for production work.

##### Simplify getting agents into production

A lot of agent prototypes based on stateless APIs tackle simple use cases: one prompt, one answer, maybe one tool call. Production work is different. Real workflows unfold across many steps, require context from previous actions, depend on multiple tool outputs, approvals, and system state, and need trusted guardrails in secure environments.

Stateless APIs require building the supporting orchestration layer for agents. The burden is on development teams to figure out how state is stored, how tools are invoked, how errors are handled, and how long-running tasks resume safely.

The Stateful Runtime Environment is jointly designed to reduce that load. It runs **inside your AWS environment** and is optimized to work with AWS services. Now, instead of manually stitching together disconnected requests to make things work, your agents automatically execute complex steps with “working context” that carries forward memory/history, tool and workflow state, environment use, and identity/permission boundaries.

##### What this unlocks

It’s now easier than ever to deliver solutions like multi-system customer support, sales operations workflows, internal IT automation, and finance processes with approvals and audits.

##### Faster time to production for multi-step workflows

When the runtime handles persistent orchestration and state across steps, teams can focus on the workflow and the business logic instead of scaffolding.

##### A better fit for long-horizon work

Stateful tasks are designed to run reliably over time, carrying forward the context and control boundaries needed for multi-step execution.

##### AWS-native deployment and governance

The runtime is designed to operate within customers’ AWS environment to easily comply with the existing security posture, tooling integrations, and governance rules.

**Getting started**

The Stateful Runtime in Amazon Bedrock will be available soon. If you want to explore how this will benefit your AI journey, reach out to your OpenAI team or request to be contacted.

- [Enterprise](https://openai.com/news/?tags=enterprise)
- [2026](https://openai.com/news/?tags=2026)