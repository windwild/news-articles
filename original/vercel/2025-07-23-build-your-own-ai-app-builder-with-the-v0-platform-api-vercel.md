---
title: "Build your own AI app builder with the v0 Platform API - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/build-your-own-ai-app-builder-with-the-v0-platform-api"
date: "2025-07-23"
scraped_at: "2026-03-02T09:30:49.320476449+00:00"
language: "en"
translated: false
description: "Learn how to build, extend, and automate AI-generated apps like BI tools and website builders with v0 Platform API"
---




Jul 23, 2025

Learn how to build, extend, and automate AI-generated apps with programmatic access to v0’s app generation pipeline

The [v0 Platform API](https://v0.dev/docs/v0-platform-api) is a text-to-app API that gives developers direct access to the same infrastructure powering [v0.dev](https://v0.dev/).

Currently in [beta](https://vercel.com/changelog/v0-platform-api-now-in-beta), the platform API exposes a composable interface for developers to automate building web apps, integrate code generation into existing features, and build new products on top of LLM-generated UIs.

## What is the v0 Platform API?

The Platform API is a REST interface that wraps v0’s full code generation lifecycle: prompt → project → code files → deployment. Every app built with the platform API is backed by a [v0.dev](https://v0.dev/) chat link.

It includes endpoints for almost all functionality on v0.dev:

- **Natural language app generation:** Generate full-stack web apps from natural language prompts and get back parsed code files and a live demo URL

- **Bring your own context:** Start chats with your own files, from source code, git, or shadcn registry, or include attachments in individual messages

- **Projects and deployments:** Create new Vercel projects, link Vercel projects to a chat, and trigger deploys


## How to use the v0 Platform API

The [v0 SDK](https://github.com/vercel/v0-sdk) is a TypeScript library that makes it simple to interact with the v0 Platform API.

```bash
pnpm install v0-sdk
```

Get your API key from your [v0 account settings](https://v0.dev/chat/settings/keys) and set it as an environment variable:

.env

```bash
V0_API_KEY=your_api_key_here
```

Now, you can integrate v0's AI-powered code generation into your application. Learn more in our complete [Quickstart Guide](https://v0.dev/docs/v0-platform-api/quickstart).

```jsx
import { v0 } from "v0-sdk"



export default async function V0Chat() {

4  // No initialization needed - uses V0_API_KEY automatically

5  const chat = await v0.chats.create({

6    message: "Build a todo app with React and TypeScript"

7  })



9  // Access the generated files

10  chat.files?.forEach((file) => {

11    console.log(`File: ${file.name}`)

12    console.log(`Content: ${file.content}`)

13  })



15  // Use the Demo URL in an iframe

16  return (

17    <iframe

18      src={chat.demo}

19      width="100%"

20      height="600">

21    </iframe>

22  )

23}


```

## What can you build with the Platform API?

The Platform API turns v0 into a headless app builder. Developers are already using it to power:

- Website builders where users can describe a site and get production-ready code

- Slack and Discord bots that return deployed web applications

- VSCode plugins and CLIs that build around the prompt-to-app workflow

- Embedded flows in analytics or CRM tools that generate UI components from natural language

- Custom dev environments and agents that read user intent and return live apps with demo links


ChatPRD generates product requirements, then uses the v0 API to create a live prototype that teams can preview directly in the app’s canvas.

## Get started

Check out the [v0 Platform API template](https://vercel.com/templates/ai/v0-platform-api-demo), a Next.js application demonstrating the v0 Platform API and features like project management, chat history, and real-time app generation with live previews.

- [Vercel template](https://vercel.com/templates/ai/v0-platform-api-demo)

- [v0 template](https://v0.dev/community/v0-platform-api-demo-440Lr82HvuB)

- [GitHub repo](https://github.com/vercel/v0-platform-api-demo)


[![claire vo 🖤](images/build-your-own-ai-app-builder-with-the-v0-platform-api-vercel/img_001.jpg)](https://x.com/clairevo/status/1943369961524600999)

[claire vo 🖤](https://x.com/clairevo/status/1943369961524600999)


· [Follow](https://x.com/intent/follow?screen_name=clairevo)

[View on Twitter](https://x.com/clairevo/status/1943369961524600999)

ok < 24 hrs later i got [@v0](https://x.com/v0) x [@chatprd](https://x.com/chatprd) working locally
✅ generate a PRD
✅ send to v0
✅ preview prototype in ChatPRD
✅ banger pop punk anthem + demo

props to [@vercel](https://x.com/vercel) and [@ctatedev](https://x.com/ctatedev) who are delightfully responsive to SDK and docs questions

[Watch on X](https://x.com/clairevo/status/1943369961524600999)

[2:01 PM · Jul 10, 2025](https://x.com/clairevo/status/1943369961524600999) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[237](https://x.com/intent/like?tweet_id=1943369961524600999) [Reply](https://x.com/intent/tweet?in_reply_to=1943369961524600999)


[Read 16 replies](https://x.com/clairevo/status/1943369961524600999)

[![Guillermo Rauch](images/build-your-own-ai-app-builder-with-the-v0-platform-api-vercel/img_002.jpg)](https://x.com/rauchg/status/1943097445317325150)

Guillermo Rauch

@rauchg

Headless @v0 is here:

𝚒𝚖𝚙𝚘𝚛𝚝 { 𝚟𝟶 } 𝚏𝚛𝚘𝚖 '𝚟𝟶-𝚜𝚍𝚔'

𝚊𝚠𝚊𝚒𝚝 𝚟𝟶.𝚌𝚑𝚊𝚝𝚜.𝚌𝚛𝚎𝚊𝚝𝚎({
𝚖𝚎𝚜𝚜𝚊𝚐𝚎: '𝙱𝚞𝚒𝚕𝚍 𝚖𝚎 𝚊 𝚕𝚊𝚗𝚍𝚒𝚗𝚐 𝚙𝚊𝚐𝚎',
𝚜𝚢𝚜𝚝𝚎𝚖: '𝚈𝚘𝚞’𝚛𝚎 𝚊 𝚁𝚎𝚊𝚌𝚝 𝚎𝚡𝚙𝚎𝚛𝚝'
})
vercel.com/changelog/v0-p…