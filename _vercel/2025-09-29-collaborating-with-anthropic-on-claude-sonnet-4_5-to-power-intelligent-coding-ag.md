---
title: "Collaborating with Anthropic on Claude Sonnet 4.5 to power intelligent coding agents - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/collaborating-with-anthropic-on-claude-sonnet-4-5"
date: "2025-09-29"
scraped_at: "2026-03-02T09:27:47.266734270+00:00"
language: "en-zh"
translated: true
description: "Claude Sonnet 4.5 is now available on Vercel AI Gateway and across the Vercel AI Cloud. Also introducing a new coding agent platform template."
---

Sep 29, 2025

2025 年 9 月 29 日

Claude Sonnet 4.5 现已在 [Vercel AI Gateway](https://vercel.com/ai-gateway) 上线，并获得 [AI SDK](https://ai-sdk.dev/) 的完整支持。我们已在 v0 中对这一模型进行了测试，覆盖了 Next.js 构建流水线，以及我们全新的 Coding Agent Platform 模板。该模型在设计感知能力与代码质量方面均有提升，在构建和 Lint Next.js 应用时展现出可量化的性能增益。

Claude Sonnet 4.5 延续并强化了 Anthropic 在推理与编程领域的优势。当与 [Vercel AI Cloud](https://vercel.com/blog/the-ai-cloud-a-unified-platform-for-ai-workloads) 协同使用时，它赋能一类全新的开发者工作流——AI 可在您的代码仓库内安全地完成规划、执行与交付变更。

[**Claude Sonnet 4.5 交互式体验平台**\\
\\
立即在 AI Gateway 上试用 Claude Sonnet 4.5，无需任何配置或安装。打开体验平台，即可开始输入提示词（prompt）。\\
\\
试用 Claude Sonnet 4.5](https://vercel.com/ai-gateway/models/claude-sonnet-4.5)

## Claude Sonnet 4.5 提升智能体式编程工作流

我们内部评估表明，Claude Sonnet 4.5 在核心的智能体式编程任务中优于其前代模型：

- **Next.js 构建**：首次构建成功率更高，依赖缺失错误更少。该模型能准确推断所需依赖包，并在尝试构建前将其正确写入 `package.json`

- **代码检查（Linting）**：更严格地遵循 Next.js 和 ESLint 的默认规范

- **功能实现**：对 Next.js 特有功能的支持显著增强，例如能正确使用 `next/image` 中的 `<Image>` 组件及其他框架原生组件

在 v0 方面：

- **Frontend design in v0**: Cleaner component structures, better Tailwind usage, and more accessible UI patterns  
- **v0 前端设计优化**：组件结构更清晰、Tailwind CSS 使用更合理、UI 模式更具可访问性  

- **Handling challenging prompts**: When v0 prompts get nuanced, Claude Sonnet 4.5 finds the right context faster and more accurately. It avoids being tripped up by small details or unclear requirements, staying on track to deliver the right solution  
- **应对复杂提示词**：当 v0 的提示词变得细致微妙时，Claude Sonnet 4.5 能更快、更准确地捕捉正确上下文；它不会被细微偏差或模糊需求干扰，始终聚焦于交付正确解决方案  

- **Complex applications**: For complicated apps like 3D worlds, Claude Sonnet 4.5 often gets it right in a single attempt, piecing together moving parts, interactions, and structure without extended back and forth  
- **复杂应用开发**：对于 3D 世界等高复杂度应用，Claude Sonnet 4.5 常能一次性生成正确结果，自动整合动态模块、交互逻辑与整体架构，无需反复迭代  

- **Clarification over guessing**: When a query is unclear, Claude Sonnet 4.5 asks for clarification instead of wasting tokens on something irrelevant  
- **主动澄清，而非盲目猜测**：当用户查询表述不清时，Claude Sonnet 4.5 会主动请求澄清，而非消耗 token 生成无关内容  

These improvements make Claude Sonnet 4.5 effective for coding agents that execute full task chains: understanding a request, generating code, verifying with builds and tests, and shipping changes.  
上述改进使 Claude Sonnet 4.5 成为执行完整任务链的编码智能体的理想选择：从理解需求、生成代码，到通过构建与测试验证，最终交付变更。

## Introducing: Coding Agent Platform to test agents in the wild  
## 新功能发布：编码智能体平台——在真实环境中测试智能体  

To show what’s possible, we’ve released a Coding Agent Platform template that defaults to Anthropic's Claude Code agent using Claude Sonnet 4.5.  
为展示其实际能力，我们已发布一个“编码智能体平台”模板，该模板默认集成 Anthropic 的 Claude Code 智能体，并运行于 Claude Sonnet 4.5 模型之上。  

It's a multi-agent system that can run Claude Code, OpenAI Codex CLI, Cursor CLI, or opencode. After connecting your GitHub organization, you select a repository and define a task (for example, “add dark mode,” “lint this project,” or “create a new API route”). The agent plans, executes, and commits changes automatically.  
这是一个多智能体系统，支持运行 Claude Code、OpenAI Codex CLI、Cursor CLI 或 opencode。连接您的 GitHub 组织后，您可选择目标仓库并定义具体任务（例如：“添加深色模式”、“对本项目执行代码检查（lint）”或“创建一条新 API 路由”）。智能体将自动完成任务规划、执行与代码提交。  

Each task runs in an isolated sandbox. The platform installs dependencies (including the coding tool you choose), executes CLI commands with the selected model, and pushes changes back to GitHub. You review the pull request and decide whether to merge.  
每项任务均在隔离沙箱中运行。平台会自动安装依赖（包括您选定的编码工具），调用所选模型执行 CLI 命令，并将变更推送回 GitHub。您只需审阅生成的 Pull Request 并决定是否合并。  

Progress streams in real time. The UI (built with Next.js and Tailwind CSS) shows commands as they run, builds as they complete, and commits as they’re created. State is persisted in Postgres, with task history and management available for review.  
进度实时流式呈现。前端 UI（基于 Next.js 与 Tailwind CSS 构建）动态显示正在运行的命令、已完成的构建过程，以及新创建的提交记录。所有状态持久化存储于 PostgreSQL 数据库中，任务历史与管理界面可供随时查阅。

[**Coding Agent Platform**  
**编码代理平台**  

Run coding agents in the Vercel AI Cloud with Vercel Sandbox + AI Gateway.  
在 Vercel AI Cloud 中，借助 Vercel Sandbox 与 AI Gateway 运行编码代理。  

Deploy now  
立即部署](https://vercel.com/templates/ai/coding-agent-platform)

## Powered by the Vercel AI Cloud  
## 由 Vercel AI Cloud 驱动

The Coding Agent Platform template runs on the Vercel AI Cloud, where each layer of the stack makes background coding agents viable.  
“编码代理平台”模板运行于 Vercel AI Cloud 之上，其技术栈的每一层共同支撑后台编码代理的可行性。

At the foundation is [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), which provisions secure, short-lived environments for installs, builds, and tests. This isolation keeps agent tasks reproducible and prevents interference with the rest of your project. Inside a Sandbox, you have full command-line access to clone repositories, run commands, and use complete agentic coding toolchains.  
底层基础是 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox)，它可为安装、构建和测试快速创建安全、短暂的运行环境。这种隔离机制确保代理任务可复现，并避免对项目其余部分造成干扰。在 Sandbox 内，您拥有完整的命令行访问权限：可克隆代码仓库、执行任意命令，并使用完整的代理式编码工具链。

Sandboxes scale with demand. As you create new prompts and tasks, they spin up in parallel, removing the need for local compute and improving both performance and cost efficiency. Sandbox is powered by [Fluid compute](https://vercel.com/fluid), which scales elastically and uses [Active CPU pricing](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute). Agents can remain idle without incurring charges, so you only pay for CPU when compute is actively used.  
Sandbox 可随需求自动弹性伸缩。当您创建新提示（prompt）和新任务时，系统将并行启动多个 Sandbox 实例，从而消除对本地算力的依赖，并显著提升性能与成本效益。Sandbox 由 [Fluid compute](https://vercel.com/fluid) 提供支持，该技术具备弹性伸缩能力，并采用 [Active CPU 定价模型](https://vercel.com/blog/introducing-active-cpu-pricing-for-fluid-compute)。代理处于空闲状态时不会产生费用，您仅需为实际使用的 CPU 算力付费。

Each task also makes lightweight AI calls through the AI SDK and AI Gateway. For example, when an agent starts a task, the system generates a descriptive Git branch name based on the task, repository, and context.  
每个任务还会通过 AI SDK 与 AI Gateway 发起轻量级 AI 调用。例如，当代理启动一项任务时，系统会依据该任务内容、目标代码仓库及上下文信息，自动生成一个具有描述性的 Git 分支名称。

Together, these systems provide an integrated execution layer. Instead of piecing together separate tools, the Vercel AI Cloud connects model reasoning with safe, scalable execution, making autonomous coding agents practical in production.  
上述系统协同构成了一套集成化的执行层。无需手动拼凑各类独立工具，Vercel AI Cloud 将大模型推理能力与安全、可扩展的执行环境无缝衔接，使自主式编码代理真正具备生产环境落地的可行性。

## Open-sourcing the Coding Agent Platform template  
## 开源“编码代理平台”模板

We are open-sourcing the Coding Agent template under the same vision as our [Open SDK strategy](https://vercel.com/blog/open-sdk-strategy):  
我们正以与 [Open SDK 战略](https://vercel.com/blog/open-sdk-strategy) 相同的理念，开源“编码代理”模板：

- Fork, audit, and extend the code  
- 可自由 Fork、审查并扩展代码

- Plug in new agents, domain-specific tools, or custom commit logic  
- 插入新的智能体（agents）、特定领域的工具，或自定义的提交逻辑

- Reference implementation that you can bootstrap or deploy on your teams while taking advantage of AI Gateway, AI SDK, and Vercel AI Cloud platform  
- 可供团队快速启动或直接部署的参考实现，同时充分利用 AI Gateway、AI SDK 和 Vercel AI Cloud 平台能力

We’ll provide documentation, examples, and a contributor guide so that the community can evolve it.  
我们将提供文档、示例和贡献者指南，以便社区共同推动该项目持续演进。

### Get started with Claude Sonnet 4.5  
### 快速上手 Claude Sonnet 4.5  

Claude Sonnet 4.5 is available today through AI Gateway and AI SDK. You can try it instantly in the [playground](https://vercel.com/ai-gateway/models/claude-sonnet-4.5), or deploy the [Coding Agent Template](https://vercel.com/templates/ai/coding-agent-platform) to run real tasks against your repositories.  
Claude Sonnet 4.5 即日起已通过 AI Gateway 和 AI SDK 正式开放。您可立即在 [交互式 Playground](https://vercel.com/ai-gateway/models/claude-sonnet-4.5) 中体验，或一键部署 [Coding Agent 模板](https://vercel.com/templates/ai/coding-agent-platform)，在您的代码仓库中执行真实任务。

[**Claude Sonnet 4.5 Playground**\\  
\\  
Try Claude Sonnet 4.5 on AI Gateway instantly, with no setup or install necessary. Open the playground and start prompting.\\  
\\  
Try Claude Sonnet 4.5](https://vercel.com/ai-gateway/models/claude-sonnet-4.5)  
[**Claude Sonnet 4.5 Playground**\\  
\\  
无需任何配置或安装，即可在 AI Gateway 上即时体验 Claude Sonnet 4.5。打开 Playground，立即开始输入提示词（prompt）并运行。\\  
\\  
立即体验 Claude Sonnet 4.5](https://vercel.com/ai-gateway/models/claude-sonnet-4.5)