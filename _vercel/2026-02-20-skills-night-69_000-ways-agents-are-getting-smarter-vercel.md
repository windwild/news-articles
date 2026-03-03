---
title: "Skills Night: 69,000+ ways agents are getting smarter - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/skills-night-69000-ways-agents-are-getting-smarter"
date: "2026-02-20"
scraped_at: "2026-03-02T09:21:27.518912790+00:00"
language: "en-zh"
translated: true
description: "Andrew Qu reflects on Skills Night SF: how a weekend project became 69,000 community-created skills, the security partnerships protecting them, and what eight partner demos revealed about agents, cont..."
---

Feb 20, 2026

2026年2月20日

The room was full of people who had already used skills.

现场座无虚席，与会者均已有使用 skills 的实际经验。

Tuesday night we hosted Skills Night in San Francisco, an event for developers building on and around [skills.sh](https://skills.sh/), the open skills ecosystem we've been growing since the idea started as a single weekend of writing. What began as Shu Ding sitting down to document everything he knows about React has grown into over 69,000 skills, 2 million skill CLI installs, and a community moving incredibly fast.

周二晚，我们在旧金山举办了“Skills Night”（技能之夜）活动——这是一场面向开发者的技术聚会，聚焦于构建和拓展 [skills.sh](https://skills.sh/) 这一开放技能生态。该生态的构想起源于一个周末的写作实践；最初只是舒鼎（Shu Ding）静坐下来，系统梳理自己所掌握的全部 React 知识，如今已发展为涵盖逾 69,000 项技能、累计超 200 万次技能 CLI 安装、且社区迭代速度惊人的开源项目。

[**Skills Night is heading to New York**\\  
\\  
Join us in New York for our next skills.sh event. See from developers how they're using skills to make their agents smarter.\\  
\\  
Join us in New York](https://luma.com/8d50mt8d)

[**Skills Night 即将登陆纽约**\\  
\\  
诚邀您参加我们在纽约举办的下一场 skills.sh 活动。现场聆听开发者分享：他们如何利用 skills 让 AI 智能体变得更聪明。\\  
\\  
立即报名，加入纽约站](https://luma.com/8d50mt8d)

Here is what we learned.

以下是我们此次收获的关键洞见。

### Where this came from

### 起源：从一个周末开始

The origin story is worth retelling because it shapes how we think about the project.

这段起源故事值得反复讲述，因为它深刻塑造了我们对整个项目的认知方式。

[Shu Ding](https://x.com/shuding) is one of the most talented web engineers I've ever worked with. He knows things about React and the browser that most people will never discover. Last year, he sat down on a weekend and wrote it all down. A kind of web bible. We wanted to figure out how to ship it. We considered a blog post or documentation that the next generation of models might eventually learn — but we wouldn't see the results until Claude Sonnet 8, or GPT-9. On the other hand, an MCP server felt too heavy for what was essentially a collection of markdown documents.

[舒鼎（Shu Ding）](https://x.com/shuding) 是我共事过的最具天赋的 Web 工程师之一。他对 React 和浏览器底层机制的理解，远超绝大多数开发者的认知边界。去年某个周末，他静心梳理、倾囊相授，将所有这些知识完整记录下来——堪称一部现代 Web 开发“圣经”。我们随即思考：如何将其有效交付给世界？曾考虑过以博客文章或传统文档形式发布，供下一代大模型学习——但那意味着成果要等到 Claude Sonnet 8 或 GPT-9 才可能显现；而另一方面，为本质上仅是一组 Markdown 文档的集合去搭建一个 MCP（Model Context Protocol）服务，又显得过于繁重。

Skills made sense as the quickest way to deliver on-demand knowledge. While writing the instructions for installing React best practices, I ended up copying and pasting the same installation instructions for getting the skills into Cursor, Claude Code, Codex, and the other 10+ coding agents but with slightly different installation directories.

Skills 成为按需交付知识最快捷的路径。在撰写 React 最佳实践安装指南时，我发现自己反复复制粘贴同一套安装说明——只为适配 Cursor、Claude Code、Codex 及其他十余种编程智能体，仅因各平台安装路径略有差异。

So I built a CLI to install it into every major coding agent at once. That became `npx skills`. We added telemetry to surface new skills as they got installed, which became the data that powers the leaderboard at [skills.sh](https://skills.sh/). The whole thing went from idea to production on Vercel in days. Malte Ubl, Vercel CTO, framed it perfectly: it's a package manager for agent context.

于是我开发了一个命令行工具（CLI），支持一键将技能部署至所有主流编程智能体——这就是 `npx skills` 的由来。我们进一步加入了遥测功能，实时追踪新技能的安装情况；这些数据最终驱动了 [skills.sh](https://skills.sh/) 上的技能排行榜。整个项目从灵光一现到上线生产环境，仅耗时数天，全部托管于 Vercel。Vercel 首席技术官马尔特·乌布（Malte Ubl）精准地概括了它的本质：这是一个专为智能体上下文（agent context）设计的包管理器。

Now we are tracking 69,000 of them, and making them not just easy to discover but easy to install, with simple commands like just:

```bash
npx skills add vercel-labs/agent-skills --skill vercel-react-best-practices
```

我们现在已追踪其中 69,000 项技能，不仅让它们更易于发现，还让安装变得极为简便——只需执行如下简单命令即可：

```bash
npx skills add vercel-labs/agent-skills --skill vercel-react-best-practices
```

### The security problem we needed to solve

### 我们亟需解决的安全问题

Growth creates attack surface, and fast growth creates it even faster.

增长会扩大攻击面，而快速增长则会使攻击面扩张得更快。

As soon as skills took off, quality variance followed. Ryan from Socket showed us a concrete example: a skill that looked completely clean at the markdown level but included a Python file that opened a remote shell on install. You would never catch that without looking at every file in the directory.

技能一经兴起，其质量便开始参差不齐。Socket 公司的 Ryan 向我们展示了一个具体案例：某项技能在 Markdown 层面看似完全干净，却在安装时悄悄引入了一个 Python 文件，该文件会在本地打开一个远程 shell。若不逐个检查目录中的所有文件，你根本无法察觉这一风险。

That is why we announced security partnerships with [Gen](https://ai.gendigital.com/), [Socket](https://socket.dev/), and [Snyk](https://snyk.io/) to run audits across all skills and every new one that comes in.

正因如此，我们宣布与 [Gen](https://ai.gendigital.com/)、[Socket](https://socket.dev/) 和 [Snyk](https://snyk.io/) 建立安全合作，对全部现有技能及每一项新提交的技能开展全面安全审计。

- Socket is doing cross-ecosystem static analysis combined with LLM-based noise reduction, reporting 95% precision, 98% recall, and 97% F1 across their benchmarks.

- Socket 正在开展跨生态系统的静态分析，并结合基于大语言模型（LLM）的噪声过滤技术；在其各项基准测试中，准确率达 95%，召回率达 98%，F1 得分为 97%。

- Gen is building a real-time agent trust layer called Sage that monitors every connection in and out of your agents, allowing them to run freely without risk of data exfiltration or prompt injection.

- Gen 正在构建一个名为 Sage 的实时智能体信任层，可监控所有进出您智能体的连接，从而使其在无数据泄露或提示注入风险的前提下自由运行。

- Snyk is bringing their package security background to the skills context.

- Snyk 正将其在软件包安全领域的深厚积累，延伸至技能（skills）这一全新场景。

We are building an Audits leaderboard to provide per-skill assessments and recommendations. The goal is not to lock things down. The goal is to let you go fast with confidence. We're always looking for new security partners who can bring unique perspectives to auditing skills and provide more trust signals for skills.

我们正在构建一个“审计排行榜”（Audits Leaderboard），为每一项技能提供独立的安全评估与改进建议。我们的目标并非严加封锁、阻碍创新；而是让您在充分自信的前提下，高速推进开发。我们始终欢迎新的安全合作伙伴加入——若您能为技能审计带来独特视角，并为技能提供更丰富的可信度信号，我们热切期待与您携手合作。

### What the demos showed us

### 演示向我们揭示了什么

Eight partners showed demos on Tuesday, and a few themes kept coming up.

八家合作伙伴在周二展示了演示，其中几个主题反复出现。

**Skills close the training cutoff gap.** [Ben Davis](https://x.com/davis7) ran a controlled experiment to demonstrate this.

**技能可弥补训练截止时间带来的知识缺口。** [Ben Davis](https://x.com/davis7) 开展了一项受控实验来验证这一点。

He tried to get coding agents to implement Svelte remote functions, a relatively new API, four different ways: no context, a skills file with documentation, a skill pointing to the MCP, and a code example in the project.

他尝试让编程智能体以四种不同方式实现 Svelte 远程函数（一个相对较新的 API）：无上下文、带文档的技能文件、指向 MCP 的技能，以及项目中嵌入的代码示例。

Every approach with context worked.

所有带上下文的方法均成功运行。

The no-context run, which he had to force through a stripped-down model to prevent it from inferring solutions, produced completely wrong output. Models are smart enough to use patterns correctly when you give them the patterns. Without context, they fall back to stale training data.

而无上下文的运行——他不得不借助一个精简版模型强制执行，以防模型自行推断解决方案——则生成了完全错误的输出。模型足够聪明，只要提供正确的模式，就能准确运用；但若缺乏上下文，它们便只能退回到过时的训练数据上。

**The medium matters less than the content.** The interesting takeaway from Ben's experiment was not that skills are the only way. It is that getting the right context in is what matters, and skills are the fastest starting point if you do not already have a baseline. Existing code examples, inline documentation, and MCP hints all work.

**媒介不如内容重要。** Ben 实验中真正值得关注的启示，并非“技能是唯一途径”，而是“注入恰当的上下文”才是关键所在；若你尚未建立基准能力，技能则是最快上手的起点。现有的代码示例、内联文档以及 MCP 提示，同样有效。

Skills are just the easiest way to distribute that context to anyone.

技能只是将这类上下文分发给任何人的最便捷方式。

**Agents can now drive the whole stack.** [Evan Bacon](https://x.com/Baconbrix) from Expo showed native iOS feature upgrades driven entirely by Claude Code using Expo skills.

**智能体如今可驱动整套技术栈。** Expo 的 [Evan Bacon](https://x.com/Baconbrix) 展示了如何完全依托 Claude Code 与 Expo 技能，实现原生 iOS 功能升级。

New SwiftUI components, gesture-driven transitions, and tab bar updates were all applied automatically. They are also using LLDB integration in a work-in-progress skill that lets agents read the native iOS view hierarchy and fix notoriously hard keyboard handling bugs automatically.

新增的 SwiftUI 组件、基于手势的页面转场效果，以及标签栏更新，全部实现了自动部署。他们还在开发一项集成 LLDB 的技能：该技能可让智能体读取原生 iOS 视图层级结构，并自动修复那些 notoriously 难以处理的键盘响应问题。

Their production app, Expo Go, now auto-fixes every crash as it occurs. For anyone who has spent time wrestling with Xcode, that is a significant statement.

他们的生产级应用 Expo Go 现在能在每次崩溃发生时自动修复。对于任何曾耗费大量时间与 Xcode 斗争过的开发者而言，这是一项意义重大的声明。

**Skills are becoming infrastructure.**  
**技能正逐渐演变为基础设施。**

[Nick Khami](https://x.com/skeptrune) showed off that Mintlify auto-generates a skill for every documentation site they host, including Claude Code's own docs, Coinbase, Perplexity, and Lovable.

[Nick Khami](https://x.com/skeptrune) 展示了 Mintlify 如何为其托管的每一个文档站点自动生成一项技能——包括 Claude Code 自身的文档、Coinbase、Perplexity 和 Lovable。

Traffic to these sites is now 50% coding agents, up from 10% a year ago. The skill is not something the docs team writes anymore; it is a byproduct of having well-structured documentation. Sentry's David Cramer built Warden, a harness that runs skills as linters on pull requests via GitHub Actions, treating agents as a static analysis layer.

访问这些网站的流量中，如今有 50% 来自编程智能体（coding agents），而一年前这一比例仅为 10%。技能已不再由文档团队手动编写；它已成为结构良好文档的自然副产品。Sentry 的 David Cramer 开发了 Warden —— 一个通过 GitHub Actions 在 Pull Request 上将技能作为代码检查器（linter）运行的框架，从而将智能体视为静态分析的一层。

### What we're building toward  
### 我们正在构建的方向

Guillermo Rauch, Vercel CEO, said something Tuesday night that I keep thinking about: agents make mistakes.

Vercel 首席执行官 Guillermo Rauch 周二晚间的一句话令我久久思索：智能体（agents）会犯错。

They sometimes tell you you are absolutely right and proceed to do the wrong thing. Shipping quality in the AI era means not just celebrating how many tokens you are burning. It means raising the bar on what those tokens actually produce.

它们有时会坚定地告诉你“你完全正确”，却紧接着执行错误的操作。在 AI 时代交付高质量产品，绝不仅仅是炫耀自己消耗了多少 token；更意味着提升对这些 token 实际产出成果的要求标准。

Skills are one answer to that problem. They are how we influence what agents create, keep them up to date with framework changes, and make them more token-efficient by giving them a straight path to the right answer instead of letting them stumble around.

技能正是应对这一问题的方案之一。它使我们得以影响智能体所生成的内容，确保其及时适配框架更新，并通过为其提供直达正确答案的明确路径（而非任其盲目试探），显著提升 token 使用效率。

Two million installs is real signal. The security partnerships make it something teams can rely on. And the demos showed that the most interesting skills work is not at the CLI level. It is in the agents and tools that are now treating skills as a first-class primitive for distributing knowledge at scale.

两百万次安装量是真实有力的信号。安全领域的合作伙伴关系，使其成为团队可信赖的基础设施。而现场演示进一步表明：最具价值的技能工作并不发生在 CLI（命令行界面）层面；真正激动人心的进展，正出现在那些已将“技能”视作一等公民原语（first-class primitive）、用于规模化分发知识的智能体与工具之中。

We will keep building. Come find us at [skills.sh](https://skills.sh/).

我们将持续构建。欢迎访问 [skills.sh](https://skills.sh/) 找到我们。

[**Skills Night is heading to London**  
[**技能之夜即将登陆伦敦**  

\\  
Join us in London for our next skills.sh event. See from developers how they're using skills to make their agents smarter.  
\\  
加入我们在伦敦举办的下一场 skills.sh 活动。亲耳聆听开发者分享他们如何借助技能让智能体变得更聪明。  

\\  
Join us in London](https://luma.com/l4nmctta)  
\\  
欢迎来到伦敦！](https://luma.com/l4nmctta)