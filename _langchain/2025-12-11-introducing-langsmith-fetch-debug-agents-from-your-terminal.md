---
render_with_liquid: false
title: "Introducing LangSmith Fetch: Debug agents from your terminal"
source: "LangChain Blog"
url: "https://blog.langchain.com/introducing-langsmith-fetch/"
date: "2025-12-11"
scraped_at: "2026-03-03T07:15:51.424595140+00:00"
language: "en-zh"
translated: true
---
render_with_liquid: false
render_with_liquid: false

Today, we're launching **LangSmith Fetch**, a CLI tool that brings the full power of LangSmith tracing directly into your terminal and IDE.

今天，我们正式推出 **LangSmith Fetch**——一款命令行工具，可将 LangSmith 追踪（tracing）的全部能力直接带入您的终端和集成开发环境（IDE）。

If you're building agents with coding tools like Claude Code or Cursor, or if you simply prefer working in the command line, you've probably hit this friction: your agent runs, something goes wrong, and now you have to context-switch to the LangSmith UI to figure out what happened. You need to find the right trace, click through the interface, and somehow get that data back into your workflow.

如果您正使用 Claude Code 或 Cursor 等编程辅助工具构建智能体（agents），或者您本身就习惯于在命令行中工作，那么您很可能已遭遇过这种体验断点：您的智能体运行后出错，而您却不得不切换上下文、打开 LangSmith Web 界面来排查问题——需要手动定位正确的追踪记录（trace），逐层点击界面，再设法将相关数据重新导入当前工作流。

LangSmith Fetch eliminates that friction completely. With a single command, you can pull any trace or thread directly into your terminal, feed it to your coding agent, or pipe it into your analysis scripts. Check out the [repo here](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com).

LangSmith Fetch 彻底消除了这一障碍。只需一条命令，您即可将任意追踪记录（trace）或对话线程（thread）直接拉取至终端，输入给您的编程智能体（coding agent）进行分析，或通过管道（pipe）传入您的数据分析脚本。欢迎访问 [项目仓库](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com) 了解详情。

## Observability that fits into every workflow

## 无缝融入各类工作流的可观测性

LangSmith is the agent engineering platform that helps you ship reliable agents quickly. It captures everything your agent does: every LLM call, every tool execution, every decision point. Thousands of developers rely on it to debug production agents.

LangSmith 是面向智能体工程（agent engineering）的一站式平台，助您快速交付稳定可靠的智能体。它完整捕获智能体执行过程中的所有行为：每一次大语言模型（LLM）调用、每一次工具（tool）执行、每一个决策节点。数千名开发者依赖它来调试生产环境中的智能体。

However, not everyone wants to debug in a web UI. If you're a terminal-first developer, switching to a browser breaks your flow. If you're using Claude Code or another coding agent to help debug, you need trace data in a format your agent can consume. If you're building evaluation datasets from production traces, you need bulk export capabilities.

然而，并非所有人都希望在 Web 界面中进行调试。若您是“终端优先”（terminal-first）的开发者，切换至浏览器会打断您的工作流；若您正借助 Claude Code 或其他编程智能体辅助调试，则需要以智能体可解析的格式获取追踪数据；若您需基于生产环境的追踪记录构建评估数据集，则必须具备批量导出能力。

The LangSmith UI is powerful, but for these workflows, you need something different: **direct programmatic access to your trace data from the command line.**

LangSmith 的 Web 界面功能强大，但针对上述场景，您真正需要的是另一种能力：**从命令行直接、程序化地访问您的追踪数据**。

## What LangSmith Fetch does

## LangSmith Fetch 的核心能力

LangSmith Fetch is designed around two core developer workflows:

LangSmith Fetch 围绕两类核心开发者工作流而设计：

### The "I just ran something" workflow

### “我刚刚运行了某项任务”工作流

You execute your agent locally. Something weird happens. You immediately run:

你在本地执行你的智能体（agent）。突然发生了奇怪的事情。你立即运行以下命令：

```bash
langsmith-fetch traces --project-uuid <your-uuid> --format json
```

```bash
langsmith-fetch traces --project-uuid <your-uuid> --format json
```

Boom. The most recent trace from your project, right in your terminal. No opening browsers, no hunting for trace IDs, no copying and pasting. Just instant access to what just happened.

砰！你项目中最新的一条追踪记录（trace）直接显示在终端里。无需打开浏览器，无需费力查找追踪 ID，也无需复制粘贴——刚刚发生的一切，即刻触手可及。

You can narrow it down further:

你还可以进一步缩小查询范围：

```bash
# Get traces from the last 30 minutes
langsmith-fetch traces --project-uuid <your-uuid> --last-n-minutes 30

# Get the last 5 traces
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

```bash
# 获取过去 30 分钟内的所有追踪记录
langsmith-fetch traces --project-uuid <your-uuid> --last-n-minutes 30

# 获取最近的 5 条追踪记录
langsmith-fetch traces --project-uuid <your-uuid> --limit 5
```

### The bulk export workflow

### 批量导出工作流

When you need datasets for evaluation, analysis, or building test suites:

当你需要数据集用于评估、分析或构建测试套件时：

```bash
# Export 50 threads to individual JSON files
langsmith-fetch threads ./my-data --limit 50

# Export traces with temporal filters
langsmith-fetch traces ./traces --project-uuid <your-uuid> --after 2025-12-01
```

```bash
# 将 50 个对话线程（threads）分别导出为独立的 JSON 文件
langsmith-fetch threads ./my-data --limit 50

# 按时间范围导出追踪记录（例如：2025 年 12 月 1 日之后的所有记录）
langsmith-fetch traces ./traces --project-uuid <your-uuid> --after 2025-12-01
```

Each thread or trace gets saved as a separate file, perfect for batch processing, feeding to LLMs for analysis, or building regression test suites.

每个线程（thread）或追踪（trace）都会被保存为一个独立的文件，非常适合批量处理、输入大语言模型（LLM）进行分析，或构建回归测试套件。

## Built for coding agents

## 专为编程智能体（coding agents）打造

Here's where it gets really powerful: **LangSmith Fetch makes your coding agents expert agent debuggers.**

此处正是其真正强大的地方：**LangSmith Fetch 让您的编程智能体化身专家级智能体调试器。**

When you're using Claude Code, Cursor, or other AI coding assistants, they can now access your complete agent execution data directly. Just run `langsmith-fetch` and pipe the output to your coding agent. Suddenly, your coding agent can:

当您使用 Claude Code、Cursor 或其他 AI 编程助手时，它们现在可直接访问您完整的智能体执行数据。只需运行 `langsmith-fetch` 命令，并将输出通过管道（pipe）传给您的编程智能体。瞬间，您的编程智能体便具备以下能力：

- Analyze why your agent made a specific decision  
- 分析您的智能体为何做出某项特定决策  
- Identify inefficient patterns across multiple traces  
- 在多个追踪记录中识别低效模式  
- Suggest prompt improvements based on actual execution data  
- 基于真实执行数据提出提示词（prompt）优化建议  
- Build test cases from production failures  
- 基于线上故障自动生成测试用例  

Example workflow with Claude Code:

使用 Claude Code 的示例工作流：

```bash
claude-code "use langsmith-fetch to analyze the traces in <project-uuid> and tell me why the agent failed"
```

Your coding agent now has complete context about what happened, without you manually explaining or copying data around.

您的编程智能体如今已拥有事件发生的完整上下文，无需您手动解释或到处复制粘贴数据。

## Works with your existing LangSmith setup

## 与您现有的 LangSmith 配置无缝兼容

No new configuration needed. If you're already tracing to LangSmith, LangSmith Fetch works immediately. Just install via pip:

无需额外配置。只要您已在使用 LangSmith 进行追踪，LangSmith Fetch 即可立即启用。只需通过 pip 安装即可：

```bash
pip install langsmith-fetch
```

```bash
pip install langsmith-fetch
```

Set your API key (if you haven't already):

设置您的 API 密钥（如尚未设置）：

```bash
export LANGSMITH_API_KEY=your_api_key
```

```bash
export LANGSMITH_API_KEY=your_api_key
```

And you're ready to go. LangSmith Fetch uses the same authentication and projects as the rest of your LangSmith setup.

现在，您已准备就绪。LangSmith Fetch 使用与您其余 LangSmith 配置相同的认证机制和项目。

## CLI, not MCP

## 命令行工具（CLI），而非 MCP 服务器

You might be wondering: why build a CLI tool instead of an MCP server? MCP is an excellent protocol for giving LLMs structured access to external data sources, and many developers use it directly in their debugging workflows, especially inside tools like Cursor or Claude Code.

您或许会疑惑：为何要构建一个命令行工具（CLI），而不是一个 MCP 服务器？MCP 是一种出色的协议，可为大语言模型（LLM）提供对外部数据源的结构化访问；许多开发者已在调试工作流中直接使用它，尤其在 Cursor 或 Claude Code 等工具内部。

But MCP and a CLI solve different needs. When you're debugging an agent, you need flexibility:

但 MCP 和 CLI 解决的是不同层面的需求。当您调试智能体（agent）时，需要的是灵活性：

- Sometimes you want to quickly inspect a trace in your terminal  
- Sometimes you want to pipe data to `jq` or other Unix tools  
- Sometimes you want to save traces to files for later analysis  
- Sometimes you want to feed data to a coding agent  
- Sometimes you want to build scripts that process hundreds of traces  

- 有时您希望在终端中快速查看某条追踪记录（trace）；  
- 有时您希望将数据通过管道（pipe）传给 `jq` 或其他 Unix 工具；  
- 有时您希望将追踪记录保存为文件，以便后续分析；  
- 有时您希望将数据输入给编程智能体（coding agent）；  
- 有时您希望编写脚本，批量处理数百条追踪记录。

A CLI tool gives you all of this. You can use it standalone, pipe it anywhere, integrate it into any workflow, and combine it with any tool in your ecosystem. It's a fundamental building block.

CLI 工具能完全满足上述所有需求。您可以独立使用它，也可将其输出任意管道传输、集成到任一工作流中，并与您技术生态中的任何工具组合使用——它是一个基础性构建模块。

MCP, by contrast, locks you into MCP-compatible tools and real-time request/response patterns. It's perfect for what it's designed for (giving Claude or other MCP clients access to your data), but it's too restrictive for the breadth of workflows developers need.

相比之下，MCP 将您锁定在仅支持 MCP 的工具及实时请求/响应模式中。它在其设计目标范围内表现完美（即让 Claude 或其他 MCP 客户端访问您的数据），但对于开发者所需覆盖的广泛工作流而言，其限制性过强。

**The CLI is more flexible, more composable, and more Unix-philosophy.**

**命令行工具更加灵活、更易组合，并更符合 Unix 哲学。**

You can still feed LangSmith Fetch output to your coding agents (MCP-compatible or not), but you can also do a hundred other things with it.

你依然可以将 LangSmith Fetch 的输出提供给你的编码智能体（无论是否兼容 MCP），但除此之外，你还能用它完成上百种其他任务。

We're not against MCP. We just don't think every developer tool needs to be MCP. Sometimes, a well-designed CLI is exactly what you need.

我们并不反对 MCP。我们只是认为，并非每个开发者工具都必须是 MCP。有时候，一个设计精良的命令行工具，恰恰就是你所需要的。

## Get started today

## 立即开始使用

LangSmith Fetch is available now on PyPI. Install it, run your first fetch, and experience agent debugging without leaving your terminal.

LangSmith Fetch 现已在 PyPI 上发布。安装它，运行你的首次数据拉取，即可在不离开终端的前提下体验智能体调试功能。

```bash
# Install
pip install langsmith-fetch

# Fetch your most recent trace
langsmith-fetch threads --project-uuid <your-uuid>
```

```bash
# 安装
pip install langsmith-fetch

# 获取你最近的一条追踪记录
langsmith-fetch threads --project-uuid <your-uuid>
```

For complete documentation, examples, and advanced usage, check out the [GitHub repo](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com).

完整文档、示例代码及高级用法，请访问 [GitHub 仓库](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com)。

For a hands-on tutorial, see our [video walkthrough here](https://youtu.be/e_G_rXXj7eU?ref=blog.langchain.com).

如需动手实践教程，请观看我们的 [视频操作指南](https://youtu.be/e_G_rXXj7eU?ref=blog.langchain.com)。

Whether you're a terminal-first developer, building with coding agents, or just want faster access to your trace data, LangSmith Fetch brings the power of LangSmith observability directly into your workflow.

无论你是崇尚终端优先的开发者、正在基于编码智能体进行开发，还是仅仅希望更快地访问追踪数据，LangSmith Fetch 都能将 LangSmith 的可观测性能力直接融入你的工作流。

[Get started with LangSmith Fetch](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com).

[立即开始使用 LangSmith Fetch](https://github.com/langchain-ai/langsmith-fetch?ref=blog.langchain.com)。