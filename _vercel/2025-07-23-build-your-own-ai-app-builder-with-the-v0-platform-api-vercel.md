---
render_with_liquid: false
title: "Build your own AI app builder with the v0 Platform API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/build-your-own-ai-app-builder-with-the-v0-platform-api"
date: "2025-07-23"
scraped_at: "2026-03-02T09:30:49.320476449+00:00"
language: "en-zh"
translated: true
description: "Learn how to build, extend, and automate AI-generated apps like BI tools and website builders with v0 Platform API"
---
render_with_liquid: false
render_with_liquid: false

Jul 23, 2025

2025 年 7 月 23 日

Learn how to build, extend, and automate AI-generated apps with programmatic access to v0’s app generation pipeline

通过编程方式接入 v0 的应用生成流水线，学习如何构建、扩展和自动化 AI 生成的应用。

The [v0 Platform API](https://v0.dev/docs/v0-platform-api) is a text-to-app API that gives developers direct access to the same infrastructure powering [v0.dev](https://v0.dev/).

[v0 平台 API](https://v0.dev/docs/v0-platform-api) 是一个“文本到应用”（text-to-app）API，使开发者能够直接访问支撑 [v0.dev](https://v0.dev/) 的底层基础设施。

Currently in [beta](https://vercel.com/changelog/v0-platform-api-now-in-beta), the platform API exposes a composable interface for developers to automate building web apps, integrate code generation into existing features, and build new products on top of LLM-generated UIs.

目前该平台 API 处于 [Beta 测试阶段](https://vercel.com/changelog/v0-platform-api-now-in-beta)，它为开发者提供了一个可组合的接口，用于：自动化构建 Web 应用、将代码生成功能集成至现有功能中，以及基于大语言模型（LLM）生成的用户界面构建新产品。

## What is the v0 Platform API?

## 什么是 v0 平台 API？

The Platform API is a REST interface that wraps v0’s full code generation lifecycle: prompt → project → code files → deployment. Every app built with the platform API is backed by a [v0.dev](https://v0.dev/) chat link.

平台 API 是一个 REST 接口，封装了 v0 完整的代码生成生命周期：提示词（prompt）→ 项目（project）→ 代码文件（code files）→ 部署（deployment）。所有通过平台 API 构建的应用，均以一个 [v0.dev](https://v0.dev/) 聊天链接作为后端支持。

It includes endpoints for almost all functionality on v0.dev:

它涵盖了 v0.dev 上几乎所有功能的 API 端点：

- **Natural language app generation:** Generate full-stack web apps from natural language prompts and get back parsed code files and a live demo URL

- **自然语言应用生成**：基于自然语言提示词生成全栈 Web 应用，并返回已解析的代码文件及实时演示 URL。

- **Bring your own context:** Start chats with your own files, from source code, git, or shadcn registry, or include attachments in individual messages

- **自定义上下文**：使用您自己的文件（如源代码、Git 仓库或 shadcn 组件库）启动对话，或在单条消息中附加文件。

- **Projects and deployments:** Create new Vercel projects, link Vercel projects to a chat, and trigger deploys

- **项目与部署**：创建新的 Vercel 项目、将 Vercel 项目关联至聊天会话，并触发部署。

## How to use the v0 Platform API

## 如何使用 v0 平台 API

The [v0 SDK](https://github.com/vercel/v0-sdk) is a TypeScript library that makes it simple to interact with the v0 Platform API.

[v0 SDK](https://github.com/vercel/v0-sdk) 是一个 TypeScript 库，可简化与 v0 平台 API 的交互。

```bash
pnpm install v0-sdk
```

```bash
pnpm install v0-sdk
```

Get your API key from your [v0 account settings](https://v0.dev/chat/settings/keys) and set it as an environment variable:

请从您的 [v0 账户设置](https://v0.dev/chat/settings/keys) 获取 API 密钥，并将其设为环境变量：

.env

.env

```bash
V0_API_KEY=your_api_key_here
```

```bash
V0_API_KEY=your_api_key_here
```

Now, you can integrate v0's AI-powered code generation into your application. Learn more in our complete [Quickstart Guide](https://v0.dev/docs/v0-platform-api/quickstart).

现在，您可将 v0 基于 AI 的代码生成功能集成到您的应用中。更多详情，请参阅完整的 [快速入门指南](https://v0.dev/docs/v0-platform-api/quickstart)。

```jsx
import { v0 } from "v0-sdk"



export default async function V0Chat() {
```

4  // 无需初始化——自动使用 V0_API_KEY

5  const chat = await v0.chats.create({

6    message: "用 React 和 TypeScript 构建一个待办事项应用"

7  })

9  // 访问生成的文件

10  chat.files?.forEach((file) => {

11    console.log(`文件：${file.name}`)

12    console.log(`内容：${file.content}`)

13  })

15  // Use the Demo URL in an iframe

15  // 在 iframe 中使用演示 URL

16  return (

16  返回 (

17    <iframe

17    <iframe

18      src={chat.demo}

18      src={chat.demo}

19      width="100%"

19      width="100%"

20      height="600">

20      height="600">

21    </iframe>

21    </iframe>

22  )

22  )

23}  

23}

## What can you build with the Platform API?

## 使用 Platform API，您可以构建什么？

The Platform API turns v0 into a headless app builder. Developers are already using it to power:

Platform API 将 v0 变身为一个无头应用构建平台。开发者已利用它来驱动以下场景：

- Website builders where users can describe a site and get production-ready code

- 网站构建工具：用户只需描述网站需求，即可获得可直接投入生产的代码；

- Slack and Discord bots that return deployed web applications

- Slack 和 Discord 机器人：可返回已部署的 Web 应用；

- VSCode plugins and CLIs that build around the prompt-to-app workflow

- 面向“提示词→应用”工作流的 VSCode 插件与命令行工具（CLI）；

- Embedded flows in analytics or CRM tools that generate UI components from natural language

- 嵌入在数据分析或 CRM 工具中的流程，支持通过自然语言生成 UI 组件；

- Custom dev environments and agents that read user intent and return live apps with demo links

- 自定义开发环境与智能体（agents），可理解用户意图，并返回带演示链接的实时应用。

ChatPRD generates product requirements, then uses the v0 API to create a live prototype that teams can preview directly in the app’s canvas.

ChatPRD 先生成产品需求文档（PRD），再调用 v0 API 创建可交互的原型，团队可直接在应用的画布中预览该原型。

## Get started

## 快速开始

Check out the [v0 Platform API template](https://vercel.com/templates/ai/v0-platform-api-demo), a Next.js application demonstrating the v0 Platform API and features like project management, chat history, and real-time app generation with live previews.

请查看 [v0 Platform API 模板](https://vercel.com/templates/ai/v0-platform-api-demo)，这是一个 Next.js 应用，用于演示 v0 Platform API 的各项功能，包括项目管理、聊天历史记录，以及支持实时预览的应用生成能力。

- [Vercel 模板](https://vercel.com/templates/ai/v0-platform-api-demo)

- [v0 模板](https://v0.dev/community/v0-platform-api-demo-440Lr82HvuB)

- [GitHub 仓库](https://github.com/vercel/v0-platform-api-demo)


[![claire vo 🖤](images/build-your-own-ai-app-builder-with-the-v0-platform-api-vercel/img_001.jpg)](https://x.com/clairevo/status/1943369961524600999)

[claire vo 🖤](https://x.com/clairevo/status/1943369961524600999)


· [关注](https://x.com/intent/follow?screen_name=clairevo)

在 Twitter 上查看 → [View on Twitter](https://x.com/clairevo/status/1943369961524600999)

ok < 24 hrs later i got [@v0](https://x.com/v0) x [@chatprd](https://x.com/chatprd) working locally  
✅ generate a PRD  
✅ send to v0  
✅ preview prototype in ChatPRD  
✅ banger pop punk anthem + demo  

好的，不到 24 小时后，我就成功在本地运行了 [@v0](https://x.com/v0) × [@chatprd](https://x.com/chatprd)：  
✅ 生成一份产品需求文档（PRD）  
✅ 发送给 v0  
✅ 在 ChatPRD 中预览原型  
✅ 配上一首炸裂的流行朋克圣歌 + 演示视频  

特别感谢 [@vercel](https://x.com/vercel) 和 [@ctatedev](https://x.com/ctatedev)，他们对 SDK 和文档相关问题的响应既及时又亲切！

[Watch on X](https://x.com/clairevo/status/1943369961524600999)

在 X 上观看

[2:01 PM · Jul 10, 2025](https://x.com/clairevo/status/1943369961524600999) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[2:01 下午 · 2025 年 7 月 10 日](https://x.com/clairevo/status/1943369961524600999) [X 网站版、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[237](https://x.com/intent/like?tweet_id=1943369961524600999) [Reply](https://x.com/intent/tweet?in_reply_to=1943369961524600999)

[237 次点赞](https://x.com/intent/like?tweet_id=1943369961524600999) [回复](https://x.com/intent/tweet?in_reply_to=1943369961524600999)


[Read 16 replies](https://x.com/clairevo/status/1943369961524600999)

[查看 16 条回复](https://x.com/clairevo/status/1943369961524600999)

[![Guillermo Rauch](images/build-your-own-ai-app-builder-with-the-v0-platform-api-vercel/img_002.jpg)](https://x.com/rauchg/status/1943097445317325150)

[![吉列尔莫·劳赫](images/build-your-own-ai-app-builder-with-the-v0-platform-api-vercel/img_002.jpg)](https://x.com/rauchg/status/1943097445317325150)

Guillermo Rauch

吉列尔莫·劳赫

@rauchg

@rauchg

Headless @v0 is here:

无头版 @v0 正式发布：

𝚒𝚖𝚙𝚘𝚛𝚝 { 𝚟𝟶 } 𝚏𝚛𝚘𝚖 '𝚟𝟶-𝚜𝚍𝚔'

导入 { v0 } 来自 'v0-sdk'

𝚊𝚠𝚊𝚒𝚝 𝚟𝟶.𝚌𝚑𝚊𝚝𝚜.𝚌𝚛𝚎𝚊𝚝𝚎({
await v0.chats.create({
𝚖𝚎𝚜𝚜𝚊𝚐𝚎: '𝙱𝚞𝚒𝚕𝚍 𝚖𝚎 𝚊 𝚕𝚊𝚗𝚍𝚒𝚗𝚐 𝚙𝚊𝚐𝚎',
消息: '为我构建一个落地页',
𝚜𝚢𝚜𝚝𝚎𝚖: '𝚈𝚘𝚞’𝚛𝚎 𝚊 𝚁𝚎𝚊𝚌𝚝 𝚎𝚡𝚙𝚎𝚛𝚝'
系统提示: '你是一位 React 专家'
})
})

vercel.com/changelog/v0-p…  

vercel.com/changelog/v0-p…