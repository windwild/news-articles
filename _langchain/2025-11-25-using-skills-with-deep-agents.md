---
render_with_liquid: false
title: "Using skills with Deep Agents"
source: "LangChain Blog"
url: "https://blog.langchain.com/using-skills-with-deep-agents/"
date: "2025-11-25"
scraped_at: "2026-03-03T07:17:32.014974418+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

tl;dr: Anthropic 最近提出了 [agent skills（智能体技能）](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com) 的概念。所谓“技能”，本质上就是包含一个 [SKILL.md](http://skill.md/?ref=blog.langchain.com) 文件及任何相关文件（例如文档或脚本）的文件夹；智能体可动态发现并加载这些技能，从而在特定任务上表现更优。**我们已在 [deepagents-CLI](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli?ref=blog.langchain.com) 中添加了对技能的支持**。

### 通用型智能体的兴起

Claude Code 和 Manus 等通用型智能体已获得广泛采用。尽管我们可能预期这类通用智能体会调用大量工具，但一个出人意料的趋势却浮现出来：它们实际使用的工具数量 remarkably 少。Claude Code 仅使用约 [十几个工具](https://www.notion.so/177808527b1780cda055dad7024c8e65?pvs=21&ref=blog.langchain.com)，而 Manus 使用的工具则 [少于 20 个](https://www.youtube.com/watch?v=6_BcCthVvb8&ref=blog.langchain.com)。

通用型智能体为何能仅依赖少量工具就完成各类任务？关键洞见在于——赋予智能体一台计算机的访问权限。借助 [bash](https://x.com/trq212/status/1982869394482139206?s=20&ref=blog.langchain.com) 和 [文件系统工具](https://blog.langchain.com/how-agents-can-use-filesystems-for-context-engineering/)，智能体可以像人类一样执行操作，而无需为每一项任务都配备专用的绑定工具。

我们在开源智能体运行时框架 [deepagents](https://github.com/langchain-ai/deepagents/tree/master?ref=blog.langchain.com) 中应用了上述原则——该框架原生支持文件系统操作与代码执行。欢迎观看我们的概览视频：[此处观看](https://www.youtube.com/watch?v=IVts6ztrkFg&ref=blog.langchain.com)，以及配套的 [演示文稿](https://docs.google.com/presentation/d/10RyhGsScWhfqKk4PbYOljPiotoa8xcWNw9pAujJ0sAc/edit?slide=id.g398124b6427_0_0&ref=blog.langchain.com#slide=id.g398124b6427_0_0)。

![Deep Agents 概览](images/using-skills-with-deep-agents/img_001.png)

### 具备技能的通用型智能体

通用型智能体仅依赖少量工具，如何实现多样化操作？在我们的网络研讨会中，[Manus 探讨了一种方法](https://rlancemartin.github.io/2025/10/15/manus/?ref=blog.langchain.com)：**将操作职责从专用工具转移到文件系统**。与其提供大量工具，不如为智能体配备一台装有各类脚本／操作说明的计算机；智能体只需利用其内置的文件系统与 shell 工具，即可借助这些资源完成大量任务。

Anthropic 提出的“技能”正是遵循这一模式。每个技能即一个文件夹，内含一个 `SKILL.md` 文件——该文件以 YAML 前置元数据（frontmatter）开头，并辅以 Markdown 格式的操作说明。下图引自 [Anthropic 博客文章](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com)，清晰展示了 [`SKILL.md`](http://skill.md/?ref=blog.langchain.com) 文件的结构：

![打包附加内容](images/using-skills-with-deep-agents/img_002.png)

Skills offer two advantages over traditional tools: The first benefit is **_token efficiency_.** Skills are progressively disclosed. Only YAML frontmatter loads by default; agents read the full `SKILL.md` only when needed. Traditional tools require all definitions upfront in context, which can bloat the context window. You can see this figure from [Anthropic’s blog post](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com) as an illustration of this:

技能相比传统工具具有两大优势：第一项优势是**_Token 效率高_**。技能采用渐进式披露机制：默认仅加载 YAML 前置元数据（frontmatter），代理（agent）仅在需要时才读取完整的 `SKILL.md` 文件；而传统工具则需在上下文中预先加载全部定义，容易导致上下文窗口过度膨胀。下图引自 [Anthropic 博客文章](https://www.anthropic.com/engineering/equipping-agents-for-the-real-world-with-agent-skills?ref=blog.langchain.com)，直观展示了这一特点：

![Skills and the Context Window](images/using-skills-with-deep-agents/img_003.png)

![技能与上下文窗口](images/using-skills-with-deep-agents/img_003.png)

The second benefit is **_reduced cognitive load._** Agents call a small set of atomic tools instead of navigating many potentially overlapping tools — a common source of [context confusion](https://blog.langchain.com/2b5808527b1780e1ad9de771adb52b66?pvs=25). Here is table comparing skills to tools, and the associated benefit of skills for encoding actions.

第二项优势是**_降低认知负荷_**。代理调用一组数量精简、功能原子化的工具，而非在大量可能存在功能重叠的工具中反复切换——后者正是 [上下文混淆（context confusion）](https://blog.langchain.com/2b5808527b1780e1ad9de771adb52b66?pvs=25) 的常见成因。下表对比了技能与传统工具，并列出了技能在动作编码（action encoding）方面的对应优势：

![Comparing skills to tools](images/using-skills-with-deep-agents/img_004.png)

![技能与工具对比](images/using-skills-with-deep-agents/img_004.png)

Skills enable powerful capabilities beyond reducing token usage. As [Barry Zhang of Anthropic mentions](https://www.youtube.com/live/xmbSQz-PNMM?si=6B0YIg7J6HHisYAS&t=2277&ref=blog.langchain.com), skills are a step toward continuous learning: agents can create new skills on the fly as they encounter novel tasks. Skills are also easily shareable across agents and composable within sessions, allowing agents to pull in multiple skills as needed.

技能带来的能力远不止节省 Token。正如 [Anthropic 的 Barry Zhang 所指出](https://www.youtube.com/live/xmbSQz-PNMM?si=6B0YIg7J6HHisYAS&t=2277&ref=blog.langchain.com)，技能是迈向持续学习的重要一步：当代理遇到全新任务时，可即时动态创建新技能。此外，技能易于在不同代理之间共享，也支持在单次会话内灵活组合，使代理能按需调用多个技能。

### Deep Agents CLI + Skills

### 深度代理 CLI（Deep Agents CLI）+ 技能

Our deepagent-CLI is an [open source coding assistant](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli?ref=blog.langchain.com) that can use your local filesystem, just like Claude Code. We’ve added skills to the deepagent-CLI, making it possible to use the [large](https://github.com/anthropics/skills?ref=blog.langchain.com) and [growing](https://skillsmp.com/?ref=blog.langchain.com) collection of public skills.

我们的 `deepagent-CLI` 是一款 [开源编程助手](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli?ref=blog.langchain.com)，可像 Claude Code 一样直接访问本地文件系统。我们已将技能功能集成至 `deepagent-CLI`，使其能够调用 [规模庞大](https://github.com/anthropics/skills?ref=blog.langchain.com) 且 [持续增长](https://skillsmp.com/?ref=blog.langchain.com) 的公开技能库。

Just create a skills folder for you agent and copy any example skills [from our repo](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli/examples/skills?ref=blog.langchain.com):

只需为你的代理创建一个技能目录，并从 [我们的代码仓库](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli/examples/skills?ref=blog.langchain.com) 中复制任意示例技能：

```python
mkdir -p ~/.deepagents/agent/skills
cp -r examples/skills/web-research ~/.deepagents/agent/skills/
```

```python
mkdir -p ~/.deepagents/agent/skills
cp -r examples/skills/web-research ~/.deepagents/agent/skills/
```

These skills are default loaded into the deepagent CLI at startup, and you can see all available skills by simply running `deepagents skills list` in your terminal:

这些技能将在 `deepagent-CLI` 启动时自动加载；你只需在终端中运行 `deepagents skills list` 命令，即可查看当前所有可用技能：

![Deep Agents skills list](images/using-skills-with-deep-agents/img_005.png)

![Deep Agents 技能列表](images/using-skills-with-deep-agents/img_005.png)

When you give deepagents requests related to any of the skills, it will automatically read the relevant [`SKILL.md`](http://skill.md/?ref=blog.langchain.com) file execute the skill. For a complete overview of skills, see our video here and see the [README](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli?ref=blog.langchain.com#skills).

当你向 deepagents 发出与任一技能相关的请求时，它将自动读取相应的 [`SKILL.md`](http://skill.md/?ref=blog.langchain.com) 文件并执行该技能。如需全面了解所有技能，请观看我们的视频，并参阅 [README](https://github.com/langchain-ai/deepagents/tree/master/libs/deepagents-cli?ref=blog.langchain.com#skills)。