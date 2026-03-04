---
title: "AI Code Elements - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-code-elements"
date: "2026-01-21"
scraped_at: "2026-03-02T09:22:15.980662526+00:00"
language: "en-zh"
translated: true
description: "A brand new set of components designed to help you build the next generation of IDEs, coding apps and background agents."
---
&#123;% raw %}

Jan 21, 2026

2026 年 1 月 21 日

Today we're releasing a brand new set of components designed to help you build the next generation of IDEs, coding apps and background agents.

今天我们发布了一套全新的组件，旨在帮助您构建下一代集成开发环境（IDE）、编程应用及后台智能体（background agents）。

## [<Agent />](https://ai-sdk.dev/elements/components/agent)

## [<Agent />](https://ai-sdk.dev/elements/components/agent)

A composable component for displaying an AI SDK [ToolLoopAgent](https://ai-sdk.dev/docs/agents/overview) configuration with model, instructions, tools, and output schema.

一个可组合式组件，用于展示 AI SDK 的 [ToolLoopAgent](https://ai-sdk.dev/docs/agents/overview) 配置，支持指定模型、指令、工具及输出模式（output schema）。

```bash
npx ai-elements add agent
```

```bash
npx ai-elements add agent
```

![](images/ai-code-elements-vercel/img_001.jpg)![](images/ai-code-elements-vercel/img_002.jpg)

![](images/ai-code-elements-vercel/img_001.jpg)![](images/ai-code-elements-vercel/img_002.jpg)

## [<CodeBlock />](https://ai-sdk.dev/elements/components/code-block)

## [<CodeBlock />](https://ai-sdk.dev/elements/components/code-block)

Building on what we've learned from [Streamdown](https://streamdown.ai/), we massively improved the code block component with support for a header, icon, filename, multiple languages and a more performant renderer.

在汲取 [Streamdown](https://streamdown.ai/) 实践经验的基础上，我们对代码块（code block）组件进行了大幅优化：新增支持标题栏、图标、文件名、多种编程语言高亮，以及性能更优的渲染器。

```bash
npx ai-elements add code-block
```

```bash
npx ai-elements add code-block
```

![](images/ai-code-elements-vercel/img_003.jpg)![](images/ai-code-elements-vercel/img_004.jpg)

![](images/ai-code-elements-vercel/img_003.jpg)![](images/ai-code-elements-vercel/img_004.jpg)

## [<Commit />](https://ai-sdk.dev/elements/components/commit)

## [<Commit />](https://ai-sdk.dev/elements/components/commit)

The Commit component displays commit details including hash, message, author, timestamp, and changed files.

Commit 组件用于展示提交（commit）的详细信息，包括提交哈希值（hash）、提交消息（message）、作者（author）、时间戳（timestamp）以及已更改的文件列表。

```bash
npx ai-elements add commit
```

```bash
npx ai-elements add commit
```

![](images/ai-code-elements-vercel/img_005.jpg)![](images/ai-code-elements-vercel/img_006.jpg)

![](images/ai-code-elements-vercel/img_005.jpg)![](images/ai-code-elements-vercel/img_006.jpg)

## [<EnvironmentVariables />](https://ai-sdk.dev/elements/components/environment-variables)

## [<EnvironmentVariables />](https://ai-sdk.dev/elements/components/environment-variables)

The EnvironmentVariables component displays environment variables with value masking, visibility toggle, and copy functionality.

EnvironmentVariables 组件用于展示环境变量，支持值掩码（value masking）、显隐切换（visibility toggle）以及复制功能。

```bash
npx ai-elements add environment-variables
```

```bash
npx ai-elements add environment-variables
```

![](images/ai-code-elements-vercel/img_007.jpg)![](images/ai-code-elements-vercel/img_008.jpg)

![](images/ai-code-elements-vercel/img_007.jpg)![](images/ai-code-elements-vercel/img_008.jpg)

## [<FileTree />](https://ai-sdk.dev/elements/components/file-tree)

## [<FileTree />](https://ai-sdk.dev/elements/components/file-tree)

The FileTree component displays a hierarchical file system structure with expandable folders and file selection.

FileTree 组件用于展示分层的文件系统结构，支持文件夹展开/折叠以及文件选择功能。

```bash
npx ai-elements add file-tree
```

```bash
npx ai-elements add file-tree
```

![](images/ai-code-elements-vercel/img_009.jpg)![](images/ai-code-elements-vercel/img_010.jpg)

![](images/ai-code-elements-vercel/img_009.jpg)![](images/ai-code-elements-vercel/img_010.jpg)

## [<PackageInfo />](https://ai-sdk.dev/elements/components/package-info)

## [<PackageInfo />](https://ai-sdk.dev/elements/components/package-info)

The PackageInfo component displays package dependency information including version changes and change type badges.

`PackageInfo` 组件用于显示软件包依赖信息，包括版本变更及变更类型徽章。

```bash
npx ai-elements add package-info
```

```bash
npx ai-elements add package-info
```

![](images/ai-code-elements-vercel/img_011.jpg)![](images/ai-code-elements-vercel/img_012.jpg)

![](images/ai-code-elements-vercel/img_011.jpg)![](images/ai-code-elements-vercel/img_012.jpg)

## [<Sandbox />](https://ai-sdk.dev/elements/components/sandbox)

## [<Sandbox />](https://ai-sdk.dev/elements/components/sandbox)

The Sandbox component provides a structured way to display AI-generated code alongside its execution output in chat conversations. It features a collapsible container with status indicators and tabbed navigation between code and output views.

`Sandbox` 组件为在聊天对话中结构化地展示 AI 生成的代码及其执行结果提供了一种标准化方式。该组件包含可折叠容器、状态指示器，并支持在“代码”与“输出”视图之间通过标签页切换。

## [<SchemaDisplay />](https://ai-sdk.dev/elements/components/schema-display)

## [<SchemaDisplay />](https://ai-sdk.dev/elements/components/schema-display)

The SchemaDisplay component visualizes REST API endpoints with HTTP methods, paths, parameters, and request/response schemas.

`SchemaDisplay` 组件以可视化方式呈现 REST API 端点，包括 HTTP 方法、路径、参数以及请求/响应的结构模式（schema）。

```bash
npx ai-elements add schema-display
```

```bash
npx ai-elements add schema-display
```

![](images/ai-code-elements-vercel/img_015.jpg)![](images/ai-code-elements-vercel/img_016.jpg)

![](images/ai-code-elements-vercel/img_015.jpg)![](images/ai-code-elements-vercel/img_016.jpg)

## [<Snippet />](https://ai-sdk.dev/elements/components/snippet)

## [<Snippet />](https://ai-sdk.dev/elements/components/snippet)

The Snippet component provides a lightweight way to display terminal commands and short code snippets with copy functionality. Built on top of shadcn/ui InputGroup, it's designed for brief code references in text.

`Snippet` 组件提供一种轻量级方式，用于展示终端命令和简短代码片段，并内置一键复制功能。该组件基于 shadcn/ui 的 `InputGroup` 构建，专为在正文中嵌入简短代码引用而设计。

```bash
npx ai-elements add snippet
```

```bash
npx ai-elements add snippet
```

![](images/ai-code-elements-vercel/img_017.jpg)![](images/ai-code-elements-vercel/img_018.jpg)

![](images/ai-code-elements-vercel/img_017.jpg)![](images/ai-code-elements-vercel/img_018.jpg)

## [<StackTrace />](https://ai-sdk.dev/elements/components/stack-trace)

## [<StackTrace />](https://ai-sdk.dev/elements/components/stack-trace)

The StackTrace component displays formatted JavaScript/Node.js error stack traces with clickable file paths, internal frame dimming, and collapsible content.

`StackTrace` 组件以格式化方式展示 JavaScript/Node.js 错误堆栈跟踪信息，支持点击跳转的文件路径、内部调用帧的视觉降噪（dimming），以及可折叠的内容区域。

```bash
npx ai-elements add stack-trace
```

```bash
npx ai-elements add stack-trace
```

![](images/ai-code-elements-vercel/img_019.jpg)![](images/ai-code-elements-vercel/img_020.jpg)

## [<Terminal />](https://ai-sdk.dev/elements/components/terminal)

## [<Terminal /> 组件](https://ai-sdk.dev/elements/components/terminal)

The Terminal component displays console output with ANSI color support, streaming indicators, and auto-scroll functionality.

Terminal 组件用于显示控制台输出，支持 ANSI 颜色、流式加载指示器以及自动滚动功能。

```bash
npx ai-elements add terminal
```

```bash
npx ai-elements add terminal
```

![](images/ai-code-elements-vercel/img_021.jpg)![](images/ai-code-elements-vercel/img_022.jpg)

## [<TestResults />](https://ai-sdk.dev/elements/components/test-results)

## [<TestResults /> 组件](https://ai-sdk.dev/elements/components/test-results)

The TestResults component displays test suite results (like Vitest) including summary statistics, progress, individual tests, and error details.

TestResults 组件用于展示测试套件（如 Vitest）的执行结果，包括汇总统计、进度条、单个测试用例详情以及错误信息。

## [Bonus: <Attachments />](https://ai-sdk.dev/elements/components/attachments)

## [附加功能：<Attachments />](https://ai-sdk.dev/elements/components/attachments)

Not code related, but since attachment were being used in Message, PromptInput and more, we broke it out into its own component - a flexible, composable attachment component for displaying files, images, videos, audio, and source documents.

该功能与代码本身无关，但由于附件（attachment）已在 `Message`、`PromptInput` 等多个场景中被广泛使用，我们将其抽离为一个独立组件——一个灵活、可组合的 `<Attachments />` 组件，用于展示文件、图片、视频、音频及源文档。

```bash
npx ai-elements add attachments
```

```bash
npx ai-elements add attachments
```

![](images/ai-code-elements-vercel/img_025.jpg)![](images/ai-code-elements-vercel/img_026.jpg)
&#123;% endraw %}
