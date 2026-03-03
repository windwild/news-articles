---
title: "Copy visual context to agents from Vercel Toolbar - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/copy-visual-context-to-agents"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:39.352495247+00:00"
language: "en"
translated: false
description: "Copy visual context from Vercel Toolbar comments directly to agents. Streamlines feedback-to-code workflow with deployment details and component data."
---




Feb 3, 2026

![](images/copy-visual-context-to-agents-from-vercel-toolbar-vercel/img_001.jpg)![](images/copy-visual-context-to-agents-from-vercel-toolbar-vercel/img_002.jpg)

Vercel Toolbar now includes "Copy for Agents" functionality that captures complete visual context from comments, providing coding agents with the technical details they need to understand deployment feedback across your application.

When teams copy comments using this feature, agents receive structured context including page URL and viewport dimensions, selected text and node path information, React component tree details, and the original comment text. This helps agents understand exactly where issues occur in your deployed application and what changes are needed.

**Sample context output:**

```markdown
Page URL: /dashboard/projects

Viewport: 1920x1080

Selected Text: "Deploy your latest changes"

Selector: button.deploy-btn

Component Tree: App > Dashboard > ProjectList > DeployButton
```

This structured format eliminates the need to manually explain deployment context to agents, enabling direct copying from the toolbar with complete technical details for component location and implementation.

The feature is available to all Vercel users immediately.

[Learn more about Vercel Toolbar](https://vercel.com/docs/workflow/vercel-toolbar) or [get started with Agents](https://vercel.com/ai).