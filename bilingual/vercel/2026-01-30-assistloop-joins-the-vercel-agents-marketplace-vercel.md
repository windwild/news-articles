---
title: "AssistLoop joins the Vercel Agents Marketplace - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/assistloop-joins-the-vercel-agents-marketplace"
date: "2026-01-30"
scraped_at: "2026-03-02T09:21:40.253444170+00:00"
language: "en-zh"
translated: true
description: "AssistLoop is now available in the Vercel Marketplace, making it easy to add AI-powered customer support to Next.js apps deployed on Vercel."
---

Jan 30, 2026

2026年1月30日

![](images/assistloop-joins-the-vercel-agents-marketplace-vercel/img_001.jpg)![](images/assistloop-joins-the-vercel-agents-marketplace-vercel/img_002.jpg)

[AssistLoop](https://vercel.com/marketplace/assistloop) 现已上线 [Vercel Marketplace](https://vercel.com/marketplace)，作为一款由 AI 驱动的客户支持集成工具。

该集成原生对接 Vercel，因此只需数分钟即可为您的应用添加 AI 驱动的客户支持功能。借助 AssistLoop，团队可以：

- 仅需一个 Agent ID，即可快速完成 AssistLoop 的安装与配置  
- 直接将 AI 支持能力嵌入 Next.js 应用  
- 基于内部文档、常见问题解答（FAQ）或知识库对智能体（agents）进行训练  
- 自定义助手外观与交互逻辑，使其与品牌风格保持一致  
- 查看用户对话记录，并在必要时无缝转交至人工客服  

该集成天然融入现有的 Vercel 工作流：支持统一账单管理、自动注入环境变量，且无需任何手动配置。团队无需维护独立控制台或执行复杂部署，即可更快速地上线 AI 客户支持功能。

AssistLoop automatically injects `NEXT_PUBLIC_ASSISTLOOP_AGENT_ID` into your project environment. Add the widget script to your site:

AssistLoop 会自动将 `NEXT_PUBLIC_ASSISTLOOP_AGENT_ID` 注入到您的项目环境变量中。请将小部件脚本添加到您的网站中：

widget.tsx

```html
import Script from 'next/script'



3<Script

4  src="https://assistloop.ai/assistloop-widget.js"

5  strategy="afterInteractive"

6  onLoad={() => {

7    window.AssistLoopWidget?.init({

8      agentId: process.env.NEXT_PUBLIC_ASSISTLOOP_AGENT_ID,

9    });

10  }}

11/>


```

AssistLoop 自动将 NEXT\_PUBLIC\_ASSISTLOOP\_AGENT\_ID 注入您的项目环境。只需将小部件脚本添加到您的网站即可：

### Get started

### 快速开始

从 Marketplace 部署 [AssistLoop Next.js](https://vercel.com/templates/ai/next-js-assist-loop-template) 模板，立即体验其实际效果。