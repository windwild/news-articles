---
title: "Making agent-friendly pages with content negotiation - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/making-agent-friendly-pages-with-content-negotiation"
date: "2026-02-03"
scraped_at: "2026-03-02T09:21:38.055082760+00:00"
language: "en-zh"
translated: true
description: "Learn how Vercel uses HTTP content negotiation to serve markdown to agents and HTML to humans from the same URL, reducing response sizes by 90% while keeping both versions synchronized."
---

render_with_liquid: false
Feb 3, 2026

2026 年 2 月 3 日

Agents browse the web, but they read differently than humans. They don't need CSS, client-side JavaScript, or images. All of that markup fills up their context window and consumes tokens without adding useful information. What agents need is clean, structured text.

代理程序会浏览网页，但其阅读方式与人类不同。它们不需要 CSS、客户端 JavaScript 或图片。所有这些标记都会占用代理的上下文窗口，并在未提供有效信息的情况下消耗 token。代理真正需要的是干净、结构化的纯文本。

That's why we've updated our blog and changelog pages to make markdown accessible to agents while still delivering a full HTML and CSS experience to human readers. This works through content negotiation, an HTTP mechanism where the server returns different formats for the same content based on what the client requests. No duplicate content or separate sites.

因此，我们已更新博客和更新日志页面，在为人类读者完整保留 HTML 与 CSS 体验的同时，也让代理程序能够直接获取 Markdown 格式内容。该功能基于“内容协商”（Content Negotiation）这一 HTTP 机制实现：服务器根据客户端请求中声明的偏好，对同一份内容返回不同格式的响应。无需维护重复内容，也无需设立独立站点。

## How agents request content

## 代理程序如何请求内容

Agents use the HTTP `Accept` header to specify what formats they prefer. Claude Code, for example, sends this header when fetching pages:

代理程序通过 HTTP 的 `Accept` 请求头来声明其偏好的响应格式。例如，Claude Code 在抓取网页时会发送如下请求头：

`Accept: text/markdown, text/html, */*`

By listing `text/markdown` first, the agent signals that markdown is preferred over HTML when available. Many agents are starting to explicitly prefer markdown this way.

将 `text/markdown` 置于首位，表明代理程序在可用时优先选择 Markdown 而非 HTML。目前，越来越多的代理程序正以这种方式显式声明对 Markdown 的偏好。

Try it out by sending a curl request:

可通过以下 curl 命令尝试：

`curl https://vercel.com/blog/self-driving-infrastructure -H "accept: text/markdown"`

Our middleware examines the `Accept` header on incoming requests and detects these preferences. When markdown is preferred, it routes the request to a Next.js route handler that converts our Contentful rich-text content into markdown.

我们的中间件会检查每个入站请求中的 `Accept` 请求头，并识别其中的格式偏好。当检测到 Markdown 为首选格式时，请求将被路由至一个 Next.js 路由处理器，该处理器负责将我们从 Contentful 获取的富文本内容转换为 Markdown 格式。

This transformation preserves the content's structure. Code blocks keep their syntax highlighting markers, headings maintain their hierarchy, and links remain functional. The agent receives the same information as the HTML version, just in a format optimized for token efficiency.

此转换保留了内容的结构。代码块保留其语法高亮标记，标题维持原有的层级关系，链接保持可点击功能。智能体接收到的信息与 HTML 版本完全一致，仅以更节省 token 的格式呈现。

## **Performance benefits**

## **性能优势**

A typical blog post weighs 500KB with all the HTML, CSS, and JavaScript. However, the same content as markdown is only 2KB. That's a 99.6% reduction in payload size.

一篇典型的博客文章（含全部 HTML、CSS 和 JavaScript）体积约为 500 KB；而相同内容以 Markdown 格式表示时，仅需 2 KB——有效减少 99.6% 的传输负载。

For agents operating under token limits, smaller payloads mean they can consume more content per request and spend their budget on actual information instead of markup. They work faster and hit limits less often.

对于受 token 数量限制的智能体而言，更小的负载意味着每次请求可处理更多内容，并将宝贵的 token 预算用于实际信息本身，而非冗余的标记语言。它们运行更快，也更少触发 token 上限。

We maintain synchronization between HTML and markdown versions using [Next.js 16 remote cache](https://nextjs.org/docs/app/api-reference/directives/use-cache-remote) and shared slugs. When content updates in Contentful, both versions refresh simultaneously.

我们通过 [Next.js 16 远程缓存（remote cache）](https://nextjs.org/docs/app/api-reference/directives/use-cache-remote) 和共享的 URL slug，确保 HTML 与 Markdown 版本始终保持同步。当 Contentful 中的内容更新时，两个版本将同时刷新。

## **How agents discover available content**

## **智能体如何发现可用内容**

Agents need to discover what's available. We implemented a markdown sitemap that lists all content in a format optimized for agent consumption. The sitemap includes metadata about each piece, including publication dates, content types, and direct links to both HTML and markdown versions. This gives agents a complete map of available information and lets them choose the format that works best for their needs.

智能体需要主动发现系统中有哪些内容可用。为此，我们构建了一份专为智能体优化的 Markdown 站点地图（sitemap），其中列出了全部内容，并附带每篇内容的关键元数据，例如发布日期、内容类型，以及指向 HTML 和 Markdown 两个版本的直接链接。这为智能体提供了完整的可用信息全景图，并使其能根据自身需求灵活选择最合适的格式。

Want to see this in action? Add `.md` to the end of this page's URL to [get the markdown version](https://vercel.com/blog/making-agent-friendly-pages-with-content-negotiation.md).

想亲自体验？只需在本页面 URL 末尾添加 `.md`，即可[获取该页面的 Markdown 版本](https://vercel.com/blog/making-agent-friendly-pages-with-content-negotiation.md)。