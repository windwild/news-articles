---
render_with_liquid: false
title: "Introducing the Codex app | OpenAI"
source: "OpenAI Blog"
url: "https://openai.com/index/introducing-the-codex-app"
date: "2026-02-02"
scraped_at: "2026-03-02T10:08:23.643618847+00:00"
language: "en-US"
translated: true
description: "Introducing the Codex app for macOS—a command center for AI coding and software development with multiple agents, parallel workflows, and long-running tasks."
tags: ["Product"]
---
render_with_liquid: false
render_with_liquid: false

February 2, 2026


2026 年 2 月 2 日


# Introducing the Codex app

# 推出 Codex 应用

Expanding what developers can do, with the new Codex app for macOS.

借助面向 macOS 全新推出的 Codex 应用，进一步拓展开发者的能力边界。

Try in your IDE

在您的 IDE 中试用

[Join the Codex app waitlist](https://openai.com/form/codex-app/)

[加入 Codex 应用等候名单](https://openai.com/form/codex-app/)


Today, we’re introducing the Codex app for macOS—a powerful new interface designed to effortlessly manage multiple agents at once, run work in parallel, and collaborate with agents over long-running tasks.

今天，我们正式推出面向 macOS 的 Codex 应用——这是一款功能强大的全新界面，专为轻松同时管理多个智能体（agents）、并行执行任务，以及在长期运行的任务中与智能体协同协作而设计。

We're also excited to show more people what's now possible with [Codex⁠](https://openai.com/codex). For a limited time we're including Codex with ChatGPT Free and Go, and we're doubling the rate limits on Plus, Pro, Business, Enterprise, and Edu plans. Those higher limits apply everywhere you use Codex—in the app, from the CLI, in your IDE, and in the cloud.

我们也很高兴向更多用户展示当前借助 [Codex](https://openai.com/codex) 所能实现的全新可能。限时期间，Codex 将免费集成至 ChatGPT Free 和 ChatGPT Go 版本；同时，Plus、Pro、Business、Enterprise 及 Edu 订阅计划的调用速率限制将提升一倍。这些更高的调用限额适用于您使用 Codex 的所有场景——包括本应用、命令行界面（CLI）、您的 IDE，以及云端环境。

The Codex app changes how software gets built and who can build it—from pairing with a single coding agent on targeted edits to supervising coordinated teams of agents across the full lifecycle of designing, building, shipping, and maintaining software.

Codex 应用正在重塑软件开发的方式，以及谁能够参与软件开发——从针对特定代码修改与单个编程智能体结对协作，到全程监督一支协调运作的智能体团队，覆盖软件设计、构建、发布与维护的全生命周期。

## The Codex app: A command center for agents

## Codex 应用：智能体的指挥中心

Since we launched Codex in April 2025, the way developers work with agents has fundamentally changed.  
自2025年4月推出 Codex 以来，开发者与智能体（agents）协作的方式已发生根本性变革。

Models are now capable of handling complex, long-running tasks end to end and developers are now orchestrating multiple agents across projects: delegating work, running tasks in parallel, and trusting agents to take on substantial projects that can span hours, days, or weeks.  
如今，大模型已能端到端地处理复杂、长时间运行的任务；开发者也正跨项目协调多个智能体：分配任务、并行执行工作，并充分信任智能体承担持续数小时、数天乃至数周的大型项目。

The core challenge has shifted from what agents can do to how people can direct, supervise, and collaborate with them at scale—existing IDEs and terminal-based tools are not built to support this way of working.  
核心挑战已从“智能体能做什么”，转向“人类如何大规模地指挥、监督并协同智能体工作”——而现有的集成开发环境（IDE）和基于终端的工具，并非为此类工作方式而设计。

This new way of building coupled with new model capabilities demands a different kind of tool, which is why we are introducing the Codex desktop app, a command center for agents.  
这种全新的构建范式，叠加新一代模型能力，亟需一种全新类型的工具。因此，我们正式推出 Codex 桌面应用——一个专为智能体打造的指挥中心。

00:00  
00:00  

#### Work with multiple agents in parallel  
#### 并行协同多个智能体  

The Codex app provides a focused space for multi-tasking with agents. Agents run in separate threads organized by projects, so you can seamlessly switch between tasks without losing context. The app lets you review the agent’s changes in the thread, comment on the diff, and even open it in your editor to make manual changes.  
Codex 桌面应用为多任务协同智能体提供了专注的工作空间。每个智能体在独立线程中运行，且按项目组织，使你能在不同任务间无缝切换而不丢失上下文。你可在对话线程中直接审阅智能体所作的代码变更、针对差异（diff）添加评论，甚至一键在本地编辑器中打开文件进行手动修改。

It also includes built-in support for worktrees, so multiple agents can work on the same repo without conflicts. Each agent works on an isolated copy of your code, allowing you to explore different paths without needing to track how they impact your codebase. As an agent works, you can check out changes locally or let it continue making progress without touching your local git state.  
应用还原生支持 Git worktree 功能，允许多个智能体在同一代码仓库中并行工作而互不冲突。每个智能体均在代码的隔离副本上运行，让你可自由探索多种实现路径，无需担心其对主代码库造成意外影响。在智能体运行过程中，你既可随时将变更检出至本地查看，也可任其持续推进，完全不干扰你本地的 Git 状态。

The app picks up your session history and configuration from the Codex CLI and IDE extension, so you can immediately start using it with your existing projects.  
该应用自动继承 Codex 命令行工具（CLI）及 IDE 插件中的会话历史与配置，因此你可立即在现有项目中启用它。

#### Go beyond code generation with skills  
#### 借助“技能”（Skills），突破纯代码生成的边界  

Codex is evolving from an agent that writes code into one that uses code to get work done on your computer. With [skills⁠(opens in a new window)](https://agentskills.io/home), you can easily extend Codex beyond code generation to tasks that require gathering and synthesizing information, problem-solving, writing, and more.  
Codex 正从“仅编写代码”的智能体，演进为“运用代码在你的计算机上完成实际工作”的智能体。借助 [skills⁠（在新窗口中打开）](https://agentskills.io/home)，你可以轻松将 Codex 的能力拓展至代码生成之外——覆盖信息搜集与整合、问题求解、内容撰写等更广泛的任务类型。

Skills bundle instructions, resources, and scripts so Codex can reliably connect to tools, run workflows, and complete tasks according to your team’s preferences. The Codex app includes a dedicated interface to create and manage skills. You can explicitly ask Codex to use specific skills, or let it automatically use them based on the task at hand.  
“技能”将指令、资源与脚本打包封装，使 Codex 能稳定连接各类工具、执行工作流，并严格依照团队偏好完成任务。Codex 桌面应用内置专属界面，用于创建与管理技能。你既可明确指示 Codex 调用某项特定技能，也可交由系统根据当前任务自动选择最适配的技能。

We asked Codex to make a racing game, complete with different racers, eight maps, and even items players could use with the space bar. Using an [image generation skill⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/imagegen/SKILL.md) (powered by GPT Image) and a [web game development skill⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/develop-web-game/SKILL.md), Codex built the game by working independently using more than 7 million tokens with just one initial user prompt. It took on the roles of designer, game developer, and QA tester to validate its work by actually playing the game.

我们让 Codex 开发一款赛车游戏，包含多种可选车手、八张赛道地图，甚至还有玩家可通过空格键使用的道具。Codex 借助一项 [图像生成技能⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/imagegen/SKILL.md)（由 GPT Image 驱动）和一项 [网页游戏开发技能⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/develop-web-game/SKILL.md)，仅凭一条初始用户指令，便独立完成了整个游戏的构建，共消耗了超过 700 万个 token。它同时承担了游戏设计师、开发者与质量保障（QA）测试员三重角色，并通过亲自试玩游戏来验证自身成果。

We’ve included the game, as well as the prompt and skills used to create it, below. You can also try out earlier iterations to see how Codex improved it as it worked for longer.

下方已附上该游戏，以及用于创建它的原始提示词（prompt）与所用技能。您还可尝试早期版本，直观感受 Codex 在持续迭代过程中如何逐步优化游戏。

The game was created by Codex with the develop-web-game skill using this prompt that we've summarized for clarity:

该游戏由 Codex 运用 `develop-web-game` 技能，依据以下经我们精简提炼、以提升可读性的提示词开发而成：

Implement Voxel Velocity as a 3D voxel kart racer using Three.js, with exactly one mode: Single Race (always 3 laps, 1 human vs 7 CPU, and all 8 tracks available immediately with no progression). Build a minimal pre-race flow with only: Track (8), Character (8), Difficulty (Chill/Standard/Mean), optional Mirror Mode, optional Allow Clones, and Start Race, plus an Options menu and an in-race pause menu (Resume / Restart / Quit). Create an arcade driving model with responsive handling, forgiving glancing wall hits, meaningful drifting as the main skill, and a drift-charge system that produces exact boost tiers (Tier 1 0.7s, Tier 2 1.1s, Tier 3 1.5s) while keeping baseline speed “fast-but-readable” and pack passing constant on wide roads. Implement exactly 8 items with one-item capacity, subtle position-weighted distribution, and mild effects (max loss of control ≤1.2s, max steering disabled ≤0.6s) that create goofy chaos without hard stuns, plus off-road slowdowns that are reduced by 50% during boosts. Define the 8 characters with their given stats and AI tendencies, implement CPU difficulty presets and track-authored racing/variation splines, drift zones, and hazard avoidance so AI uses multi-lane width for clean overtakes, and ship HUD/audio essentials (position, lap/final lap banner, minimap, item slot, timer/splits, readable SFX, and one music loop per track).

使用 Three.js 实现《Voxel Velocity》——一款 3D 体素风格卡丁车竞速游戏，仅提供一种模式：“单场竞速”（固定 3 圈，1 名人类玩家对战 7 名 CPU 玩家；全部 8 条赛道即时解锁，无需进度解锁）。构建极简的赛前准备流程，仅包含：赛道（8 个选项）、角色（8 个选项）、难度（“轻松 / 标准 / 激烈”三档）、可选镜像模式、可选允许克隆（Allow Clones），以及“开始比赛”按钮；另需配备“设置”菜单与比赛中暂停菜单（含“继续 / 重新开始 / 退出”选项）。设计街机风格驾驶模型：操控响应灵敏；轻微擦碰墙壁时宽容度高；漂移作为核心玩法机制，且具备精准分阶的漂移充能系统（1 阶增益持续 0.7 秒，2 阶 1.1 秒，3 阶 1.5 秒）；基础车速设定为“迅捷但易于掌控”，并在宽阔路段保持稳定的并驾齐驱（pack passing）体验。实现恰好 8 种道具，每名玩家仅可携带其中 1 种；道具分布采用位置加权算法，效果温和（最大失控时间 ≤1.2 秒，最大转向禁用时间 ≤0.6 秒），旨在制造滑稽混乱而非硬性眩晕；离路行驶减速效果在开启增益时降低 50%。定义全部 8 名角色的属性参数与 AI 行为倾向；实现 CPU 难度预设、赛道专属竞速路径/变道样条线（racing/variation splines）、漂移区域（drift zones）及障碍规避逻辑，使 AI 能充分利用多车道宽度完成干净利落的超车；最终交付必备的 HUD 与音效系统（包括实时位置、圈数/最后一圈提示横幅、小地图、道具栏、计时器/分段计时、清晰可辨的音效，以及每条赛道专属的一段循环背景音乐）。

Codex was then continuously reprompted from a random list of ten generic prompts to keep working on the problem. An example of one of the prompts is:

随后，Codex 被持续地、随机地从一份包含十条通用提示词的列表中选取新提示，以推动其持续完善该任务。其中一条示例如下：

Your job is to add new features so the game matches the original more closely. First, play the game and identify what’s missing vs. the original. Then pick a few missing features and implement them. After each feature, thoroughly test it by playing the game and confirm it works. If you notice any bugs while playing, prioritize fixing them too.

您的任务是添加新功能，使游戏更贴近原始需求。首先，亲自试玩当前版本，识别出相较于原始需求缺失的部分；接着挑选若干关键缺失功能予以实现；每完成一项功能后，均须通过实际游戏进行充分测试，并确认其正常运行；若在试玩过程中发现任何缺陷（bug），亦须优先修复。

At OpenAI, we’ve built hundreds of skills internally to help multiple teams confidently delegate work to Codex that would otherwise be hard to define consistently—from running evals and babysitting training runs to drafting documentation and reporting on growth experiments.

在 OpenAI，我们已在内部构建了数百项技能，助力多个团队放心地将原本难以明确定义、难以保持一致性的任务交由 Codex 执行——这些任务涵盖运行评估（evals）、监控训练进程（babysitting training runs）、撰写技术文档，到汇报增长实验成效等方方面面。

The Codex app includes a library of skills for tools and workflows that have become popular at OpenAI, with a few highlighted below. You can find the full list in the [open source repo⁠(opens in a new window)](https://github.com/openai/skills).

Codex 应用内置一个技能库，收录了在 OpenAI 内部广受欢迎的各类工具与工作流技能，其中几项重点技能如下所示。完整清单请参阅 [开源代码仓库⁠(在新窗口中打开)](https://github.com/openai/skills)。

- **Implement designs:** Fetch design context, assets, and screenshots from [Figma⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/figma-implement-design/SKILL.md) and translate them into production-ready UI code with 1:1 visual parity.

- **实现设计稿：** 从 [Figma⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/figma-implement-design/SKILL.md) 获取设计上下文、资源素材与截图，并将其精准还原为具备 1:1 视觉保真度的、可直接投入生产的 UI 代码。

- **Manage projects:** Triage bugs, track releases, manage team workload, and more in [Linear⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/linear/SKILL.md) to keep projects moving.

- **管理项目：** 在 [Linear⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/linear/SKILL.md) 中开展缺陷分级（triage）、版本发布追踪、团队工作量统筹等操作，确保项目高效推进。

- **Deploy to the cloud**: Have Codex deploy your web app creations to popular cloud hosts like [Cloudflare⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/cloudflare-deploy/SKILL.md), [Netlify⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/netlify-deploy/SKILL.md), [Render⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/render-deploy/SKILL.md), and [Vercel⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/vercel-deploy/SKILL.md).

- **云端部署：** 让 Codex 将您开发的网页应用一键部署至主流云平台，例如 [Cloudflare⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/cloudflare-deploy/SKILL.md)、[Netlify⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/netlify-deploy/SKILL.md)、[Render⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/render-deploy/SKILL.md) 和 [Vercel⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/vercel-deploy/SKILL.md)。

- **Generate images:** Use the [image generation skill⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/imagegen/SKILL.md) powered by GPT Image to create and edit images to use in websites, UI mockups, product visuals, and game assets.

- **生成图像：** 运用由 GPT Image 驱动的 [图像生成技能⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/imagegen/SKILL.md)，创建或编辑适用于网站、UI 原型、产品视觉图及游戏资源的图像。

- **Build with OpenAI APIs:** [Reference up-to-date documentation⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/openai-docs/SKILL.md) when building with OpenAI APIs.

- **基于 OpenAI API 构建：** 使用 OpenAI API 进行开发时，可随时查阅 [最新版官方文档⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/openai-docs/SKILL.md)。

- **Create documents:** A set of skills for reading, creating, and editing [PDF⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/pdf/SKILL.md), [spreadsheet⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/spreadsheet/SKILL.md), and [docx⁠(opens in a new window)](https://github.com/openai/skills/blob/main/skills/.curated/doc/SKILL.md) files with professional formatting and layouts.

- **创建文档：** 一套支持专业排版与格式的技能集，可用于读取、新建及编辑 [PDF⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/pdf/SKILL.md)、[电子表格⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/spreadsheet/SKILL.md) 和 [Word 文档（.docx）⁠(在新窗口中打开)](https://github.com/openai/skills/blob/main/skills/.curated/doc/SKILL.md) 文件。

00:00

00:00

Updating a website using the Vercel and image generation skills

使用 Vercel 和图像生成技能更新网站

00:00

00:00

Creating a spreadsheet to generate shopping lists using the spreadsheet skill

使用电子表格技能创建用于生成购物清单的电子表格

00:00

00:00

Managing your issue backlog with Linear

使用 Linear 管理你的问题待办列表

When you create a new skill in the app, Codex can use it wherever you work: in the app, CLI or in your IDE extension. You can also check skills into your repository to make them available to your entire team. Read more about sharing skills using team config [here⁠(opens in a new window)](https://developers.openai.com/codex/enterprise/admin-setup#team-config).

在应用中创建新技能后，Codex 可在您工作的任何地方调用该技能：包括应用内、命令行界面（CLI）或您的 IDE 插件。您还可将技能提交至代码仓库，使其对整个团队开放。有关如何通过团队配置（team config）共享技能的更多详情，请参阅[此处⁠（在新窗口中打开）](https://developers.openai.com/codex/enterprise/admin-setup#team-config)。

#### Delegate repetitive work with Automations

#### 通过自动化（Automations）委派重复性工作

With the Codex app, you can also set up Automations that let Codex work in the background on an automatic schedule. Automations combine instructions with optional skills, running on a schedule you define. When an Automation finishes, the results land in a review queue so you can jump back in and continue working if needed.

借助 Codex 应用，您还可设置自动化（Automations），让 Codex 按照您自定义的时间表在后台自动执行任务。自动化将指令与可选技能相结合，并按设定时间运行。当某项自动化执行完毕后，结果将进入审核队列，以便您随时返回并根据需要继续处理。

At OpenAI, we’ve been using Automations to handle the repetitive but important tasks, like daily issue triage, finding and summarizing CI failures, generating daily release briefs, checking for bugs, and more.

在 OpenAI，我们已利用自动化来处理那些重复但至关重要的任务，例如每日问题分诊（issue triage）、定位并汇总 CI 构建失败信息、生成每日版本发布简报、检查潜在缺陷（bugs）等。  

00:00

00:00

Setting up an automation to periodically create new skills

设置自动化任务，以定期创建新技能

#### A personality that fits how you work

#### 一种契合您工作风格的个性

Developers have different preferences in how they work with an agent. Some want a blunt, execution-focused partner; others prefer more communicative, engaging interactions. Codex now lets developers choose between two personalities—a terse, pragmatic style and a more conversational, empathetic one, without any change in capabilities, to fit the approach you like the most. Just use the /personality command in the app, CLI, and IDE extension.

开发者在与智能体协作时各有偏好：有人倾向直率、以执行为导向的搭档；也有人更喜欢富有沟通性、更具互动感的交互方式。Codex 现在支持开发者在两种个性风格之间自由选择——一种是简洁务实型，另一种是更富对话感与共情力的风格；二者能力完全一致，只为适配您最偏爱的工作方式。只需在应用、命令行界面（CLI）或 IDE 插件中输入 `/personality` 命令即可切换。

Learn more about how to set up and use the Codex app in the [docs⁠(opens in a new window)](http://developers.openai.com/codex/app).

更多关于如何安装和使用 Codex 应用的信息，请参阅 [文档⁠(在新窗口中打开)](http://developers.openai.com/codex/app)。

## Secure by default, configurable by design

## 默认安全，按需可配

We’re integrating security by design across the entire Codex agent stack. The Codex app uses native,  [open-source⁠(opens in a new window)](https://github.com/openai/codex) and configurable system-level sandboxing just like in the Codex CLI. By default, Codex agents are limited to editing files in the folder or branch where they’re working and using cached web search, then asking for permission to run commands that require elevated permissions like network access. You can [configure rules⁠(opens in a new window)](https://developers.openai.com/codex/rules) for your project or team that allows certain commands to automatically run with elevated permissions.

我们正将“安全设计”理念深度融入整个 Codex 智能体技术栈。Codex 应用采用原生、[开源⁠(在新窗口中打开)](https://github.com/openai/codex)且可配置的系统级沙箱机制，与 Codex CLI 中所用方案完全一致。默认情况下，Codex 智能体仅被允许编辑其当前所在文件夹或代码分支内的文件，并仅能使用缓存的网页搜索结果；若需执行需提升权限的命令（例如访问网络），则必须先获得用户明确授权。您还可为项目或团队[配置规则⁠(在新窗口中打开)](https://developers.openai.com/codex/rules)，指定某些命令在满足条件时可自动以提升权限运行。

## Availability & pricing

## 上线时间与定价

The Codex app is available starting today on macOS. Anyone with a ChatGPT Plus, Pro, Business, Enterprise or Edu subscription can use Codex across the CLI, web, IDE-extension and app with their ChatGPT login. Usage is included in ChatGPT subscriptions, with the option to purchase additional credits if needed.

Codex 应用今日起正式登陆 macOS 平台。所有拥有 ChatGPT Plus、Pro、Business、Enterprise 或 Edu 订阅的用户，均可使用其 ChatGPT 账户登录，在命令行界面（CLI）、网页端、IDE 插件及桌面应用中全面使用 Codex。相关用量已包含在 ChatGPT 订阅服务内；如需额外额度，亦可单独购买。

For a limited time, Codex will also be available to ChatGPT Free and Go users to help build more with agents. We’re also doubling rate limits for existing Codex users across all paid plans during this period.

限时期间，ChatGPT 免费版（Free）与 Go 用户也可使用 Codex，助力您借助智能体构建更多应用。同时，在此期间，所有付费订阅计划下的现有 Codex 用户的调用速率限制也将提升一倍。

## What’s next

## 后续计划

Enterprises and developers increasingly rely on Codex for end-to-end development.  

企业和开发者日益依赖 Codex 实现端到端开发。

Since the launch of GPT‑5.2‑Codex in mid-December, overall Codex usage has doubled, and in the past month, more than a million developers have used Codex.  

自 12 月中旬发布 GPT‑5.2‑Codex 以来，Codex 的整体使用量已翻倍；过去一个月中，已有超过一百万名开发者使用 Codex。

We’ll continue to expand where and how developers can use Codex, including making the app available on Windows, pushing the frontier of model capabilities, and rolling out faster inference.  

我们将持续拓展 Codex 的适用场景与使用方式，包括将该应用上线 Windows 平台、推动模型能力边界不断前移，以及部署更快速的推理服务。

Within the app, we’ll keep refining multi-agent workflows based on real-world feedback, making it easier to manage parallel work and move between agents without losing context.  

在应用内部，我们将持续基于真实世界反馈优化多智能体工作流，使并行任务管理更加便捷，并支持在不同智能体间无缝切换而不丢失上下文。

We’re also building out Automations with support for cloud-based triggers, so Codex can run continuously in the background—not just when your computer is open.  

我们还在构建“自动化（Automations）”功能，并支持基于云的触发机制，使 Codex 能够持续在后台运行——而不仅限于您的电脑处于开机状态时。

Codex is built on a simple premise: everything is controlled by code.  

Codex 基于一个简单前提构建：一切均由代码控制。

The better an agent is at reasoning about and producing code, the more capable it becomes across all forms of technical and knowledge work.  

智能体对代码的理解与生成能力越强，其在各类技术性与知识型工作中所展现出的能力也就越强。

Yet a key challenge today is the gap between what frontier models are capable of and how easily people can use them in practice.  

然而，当前一项关键挑战在于：前沿模型的实际能力与其在现实场景中被用户便捷使用的程度之间仍存在显著差距。

Codex is designed to close that gap by making it easier to direct, supervise, and apply the full intelligence of our models to real work.  

Codex 正是为弥合这一差距而设计——它让使用者更轻松地指挥、监督并切实应用我们模型的全部智能来完成真实工作任务。

We’ve focused on making Codex the best coding agent, which has also laid the foundation for it to become a strong agent for a broad range of knowledge work tasks that extend beyond writing code.  

我们始终聚焦于将 Codex 打造成最出色的编程智能体；这一努力同时也为其成长为一名强大智能体奠定了基础——不仅能编写代码，更能胜任广泛的知识型工作任务。

We’re excited to see what you build with Codex!  

我们热切期待您用 Codex 构建出的一切！

- [2026](https://openai.com/news/?tags=2026)  
- [2026](https://openai.com/news/?tags=2026)