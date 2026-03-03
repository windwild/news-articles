---
title: "Run untrusted code with Vercel Sandbox, now generally available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-sandbox-is-now-generally-available"
date: "2026-01-30"
scraped_at: "2026-03-02T09:21:39.510841501+00:00"
language: "en"
translated: false
description: "AI agents need secure, isolated environments that spin up instantly. Vercel Sandbox is now generally available with filesystem snapshots, container support, and production reliability."
---




Jan 30, 2026

AI agents are changing how software gets built. They clone repos, install dependencies, run tests, and iterate in seconds.

Despite the change in software, most infrastructure was built for humans, not agents.

Traditional compute assumes someone is in the loop, with minutes to provision and configure environments. Agents need secure, isolated environments that start fast, run untrusted code, and disappear when the task is done.

Today, Vercel Sandbox is generally available, the execution layer for agents, and we're open-sourcing the Vercel Sandbox [CLI](https://www.npmjs.com/package/sandbox) and [SDK](https://www.npmjs.com/package/@vercel/sandbox) for the community to build on this infrastructure.

## Built on our compute platform

Vercel processes over 2.7 million deployments per day. Each one spins up an isolated microVM, runs user code, and disappears, often in seconds.

To do that at scale, we built our own compute platform.

Internally code-named Hive, it’s powered by [Firecracker](https://firecracker-microvm.github.io/) and orchestrates microVM clusters across multiple regions. When you click Deploy in [v0](https://v0.dev/), import a repo, clone a template, or run `vercel` in the CLI, Hive is what makes it feel quick.

Sandbox brings that same infrastructure to agents.

## Why agents need different infrastructure

Agents don’t work like humans. They spin up environments, execute code, tear them down, and repeat the cycle continuously.

That shifts the constraints toward isolation, security, and ephemeral operation, not persistent, long-running compute.

Agents need:

- Sub-second starts for thousands of sandboxes per task

- Full isolation when running untrusted code from repositories and user input

- Ephemeral environments that exist only as long as needed

- Snapshots to restore complex environments instantly instead of rebuilding

- Fluid compute with Active CPU pricing for cost and performance efficiency


We’ve spent years solving these problems for deployments. Sandbox applies the same approach to agent compute.

## What is Vercel Sandbox?

[Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) provides on-demand Linux microVMs. Each sandbox is isolated, with its own filesystem, network, and process space.

You get `sudo` access, package managers, and the ability to run the same commands you’d run on a Linux machine.

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

Sandboxes are ephemeral by design. They run for as long as you need, then shut down automatically, and you only pay for active CPU time, not idle time.

This matches how agents work. A single task can involve dozens of start, run, and teardown cycles, and the infrastructure needs to keep up.

## How teams are using Sandbox

### [Roo Code](https://roocode.com/)

Roo Code builds AI coding agents that work across Slack, Linear, GitHub, and their web interface. When you trigger an agent, you get a running application to interact with, not just a patch.

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_001.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_002.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_003.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_004.jpg)

> “The agent operates inside a complete environment where services can run together, so it can test changes end-to-end before handing you something to review. Instead of ‘review a patch and hope,’ you get a preview you can engage with as the agent iterates.The agent operates inside a complete environment where services can run together, so it can test changes end-to-end before handing you something to review. Instead of ‘review a patch and hope,’ you get a preview you can engage with as the agent iterates.”
>
> ![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_005.jpg)
>
> **Matt Rubens,** CEO Roo Code

Snapshots changed their architecture. They snapshot the environment so later runs can restore a known state instead of starting from scratch, skipping repo cloning, dependency installs, and service boot time.

> “Snapshots turn agents from stateless workers into persistent collaborators. Start a task on Monday, snapshot it, resume Thursday when stakeholders can review. Branch from a working state and try two approaches in parallel.Snapshots turn agents from stateless workers into persistent collaborators. Start a task on Monday, snapshot it, resume Thursday when stakeholders can review. Branch from a working state and try two approaches in parallel.”
>
> ![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_005.jpg)
>
> **Matt Rubens,** CEO Roo Code

### [Blackbox AI](https://www.blackbox.ai/)

Blackbox AI built Agents HQ, a unified orchestration platform that integrates multiple AI coding agents through a single API. It runs tasks inside Vercel Sandboxes.

![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_007.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_008.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_009.jpg)![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_010.jpg)

> “The decision to standardize on Vercel’s sandbox infrastructure was driven by two critical performance metrics: infrastructure stability and cold start performance. Sub-second sandbox initialization times enabled rapid task distribution and reduced end-to-end execution latency, which proved essential for production-grade agent orchestration.The decision to standardize on Vercel’s sandbox infrastructure was driven by two critical performance metrics: infrastructure stability and cold start performance. Sub-second sandbox initialization times enabled rapid task distribution and reduced end-to-end execution latency, which proved essential for production-grade agent orchestration.”
>
> ![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_011.png)
>
> **Robert Rizk,** Co-founder and CEO of Blackbox AI

This supports horizontal scaling for high-volume concurrent execution. Blackbox can dispatch tasks to multiple agents in parallel, each in an isolated sandbox, without resource contention.

> “By using Vercel sandboxes to let users run AI agents at scale, we enable organizations to treat AI agents as reliable, scalable compute primitives within their development and production systems.By using Vercel sandboxes to let users run AI agents at scale, we enable organizations to treat AI agents as reliable, scalable compute primitives within their development and production systems.”
>
> ![](images/run-untrusted-code-with-vercel-sandbox-now-generally-available-vercel/img_011.png)
>
> **Robert Rizk,** Co-founder and CEO of Blackbox AI

## Create your first sandbox with one command in the CLI

```typescript
npx sandbox create --connect
```

Explore the [documentation](https://vercel.com/docs/vercel-sandbox) to get started, and check out the [open-source SDK](https://github.com/vercel/sandbox).