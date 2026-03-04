---
render_with_liquid: false
title: "Copy visual context to agents from Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/copy-visual-context-to-agents"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:39.352495247+00:00"
language: "en-zh"
translated: true
description: "Copy visual context from Vercel Toolbar comments directly to agents. Streamlines feedback-to-code workflow with deployment details and component data."
---
render_with_liquid: false
render_with_liquid: false

Feb 3, 2026

2026年2月3日

![](images/copy-visual-context-to-agents-from-vercel-toolbar-vercel/img_001.jpg)![](images/copy-visual-context-to-agents-from-vercel-toolbar-vercel/img_002.jpg)

Vercel Toolbar now includes "Copy for Agents" functionality that captures complete visual context from comments, providing coding agents with the technical details they need to understand deployment feedback across your application.

Vercel Toolbar 现已新增“复制给 Agent”功能，可从评论中完整捕获视觉上下文，为编程类 AI Agent 提供理解您应用全链路部署反馈所需的全部技术细节。

When teams copy comments using this feature, agents receive structured context including page URL and viewport dimensions, selected text and node path information, React component tree details, and the original comment text. This helps agents understand exactly where issues occur in your deployed application and what changes are needed.

当团队使用此功能复制评论时，Agent 将接收到结构化的上下文信息，包括页面 URL 和视口尺寸、所选文本及其 DOM 节点路径、React 组件树结构，以及原始评论文本。这有助于 Agent 精准定位您已上线应用中问题发生的具体位置，并明确所需修改内容。

**Sample context output:**

**示例上下文输出：**

```markdown
Page URL: /dashboard/projects

Viewport: 1920x1080

Selected Text: "Deploy your latest changes"

Selector: button.deploy-btn

Component Tree: App > Dashboard > ProjectList > DeployButton
```

This structured format eliminates the need to manually explain deployment context to agents, enabling direct copying from the toolbar with complete technical details for component location and implementation.

这种结构化格式消除了手动向智能体（agents）解释部署上下文的需要，支持直接从工具栏复制，且附带完整的组件定位与实现技术细节。

The feature is available to all Vercel users immediately.

该功能现已立即向所有 Vercel 用户开放。

[Learn more about Vercel Toolbar](https://vercel.com/docs/workflow/vercel-toolbar) or [get started with Agents](https://vercel.com/ai).

[了解更多关于 Vercel Toolbar 的信息](https://vercel.com/docs/workflow/vercel-toolbar)，或 [开始使用 Agents](https://vercel.com/ai)。