---
title: "AI Code Elements - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/ai-code-elements"
date: "2026-01-21"
scraped_at: "2026-03-02T09:22:15.980662526+00:00"
language: "en"
translated: false
description: "A brand new set of components designed to help you build the next generation of IDEs, coding apps and background agents."
---




Jan 21, 2026

Today we're releasing a brand new set of components designed to help you build the next generation of IDEs, coding apps and background agents.

## [<Agent />](https://ai-sdk.dev/elements/components/agent)

A composable component for displaying an AI SDK [ToolLoopAgent](https://ai-sdk.dev/docs/agents/overview) configuration with model, instructions, tools, and output schema.

```bash
npx ai-elements add agent
```

![](images/ai-code-elements-vercel/img_001.jpg)![](images/ai-code-elements-vercel/img_002.jpg)

## [<CodeBlock />](https://ai-sdk.dev/elements/components/code-block)

Building on what we've learned from [Streamdown](https://streamdown.ai/), we massively improved the code block component with support for a header, icon, filename, multiple languages and a more performant renderer.

```bash
npx ai-elements add code-block
```

![](images/ai-code-elements-vercel/img_003.jpg)![](images/ai-code-elements-vercel/img_004.jpg)

## [<Commit />](https://ai-sdk.dev/elements/components/commit)

The Commit component displays commit details including hash, message, author, timestamp, and changed files.

```bash
npx ai-elements add commit
```

![](images/ai-code-elements-vercel/img_005.jpg)![](images/ai-code-elements-vercel/img_006.jpg)

## [<EnvironmentVariables />](https://ai-sdk.dev/elements/components/environment-variables)

The EnvironmentVariables component displays environment variables with value masking, visibility toggle, and copy functionality.

```bash
npx ai-elements add environment-variables
```

![](images/ai-code-elements-vercel/img_007.jpg)![](images/ai-code-elements-vercel/img_008.jpg)

## [<FileTree />](https://ai-sdk.dev/elements/components/file-tree)

The FileTree component displays a hierarchical file system structure with expandable folders and file selection.

```bash
npx ai-elements add file-tree
```

![](images/ai-code-elements-vercel/img_009.jpg)![](images/ai-code-elements-vercel/img_010.jpg)

## [<PackageInfo />](https://ai-sdk.dev/elements/components/package-info)

The PackageInfo component displays package dependency information including version changes and change type badges.

```bash
npx ai-elements add package-info
```

![](images/ai-code-elements-vercel/img_011.jpg)![](images/ai-code-elements-vercel/img_012.jpg)

## [<Sandbox />](https://ai-sdk.dev/elements/components/sandbox)

The Sandbox component provides a structured way to display AI-generated code alongside its execution output in chat conversations. It features a collapsible container with status indicators and tabbed navigation between code and output views.

```bash
npx ai-elements add sandbox
```

![](images/ai-code-elements-vercel/img_013.jpg)![](images/ai-code-elements-vercel/img_014.jpg)

## [<SchemaDisplay />](https://ai-sdk.dev/elements/components/schema-display)

The SchemaDisplay component visualizes REST API endpoints with HTTP methods, paths, parameters, and request/response schemas.

```bash
npx ai-elements add schema-display
```

![](images/ai-code-elements-vercel/img_015.jpg)![](images/ai-code-elements-vercel/img_016.jpg)

## [<Snippet />](https://ai-sdk.dev/elements/components/snippet)

The Snippet component provides a lightweight way to display terminal commands and short code snippets with copy functionality. Built on top of shadcn/ui InputGroup, it's designed for brief code references in text.

```bash
npx ai-elements add snippet
```

![](images/ai-code-elements-vercel/img_017.jpg)![](images/ai-code-elements-vercel/img_018.jpg)

## [<StackTrace />](https://ai-sdk.dev/elements/components/stack-trace)

The StackTrace component displays formatted JavaScript/Node.js error stack traces with clickable file paths, internal frame dimming, and collapsible content.

```bash
npx ai-elements add stack-trace
```

![](images/ai-code-elements-vercel/img_019.jpg)![](images/ai-code-elements-vercel/img_020.jpg)

## [<Terminal />](https://ai-sdk.dev/elements/components/terminal)

The Terminal component displays console output with ANSI color support, streaming indicators, and auto-scroll functionality.

```bash
npx ai-elements add terminal
```

![](images/ai-code-elements-vercel/img_021.jpg)![](images/ai-code-elements-vercel/img_022.jpg)

## [<TestResults />](https://ai-sdk.dev/elements/components/test-results)

The TestResults component displays test suite results (like Vitest) including summary statistics, progress, individual tests, and error details.

```bash
npx ai-elements add test-results
```

![](images/ai-code-elements-vercel/img_023.jpg)![](images/ai-code-elements-vercel/img_024.jpg)

## [Bonus: <Attachments />](https://ai-sdk.dev/elements/components/attachments)

Not code related, but since attachment were being used in Message, PromptInput and more, we broke it out into its own component - a flexible, composable attachment component for displaying files, images, videos, audio, and source documents.

```bash
npx ai-elements add attachments
```

![](images/ai-code-elements-vercel/img_025.jpg)![](images/ai-code-elements-vercel/img_026.jpg)