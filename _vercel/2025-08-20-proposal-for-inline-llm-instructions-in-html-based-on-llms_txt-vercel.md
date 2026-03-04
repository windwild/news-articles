---
title: "Proposal for inline LLM instructions in HTML based on llms.txt - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/a-proposal-for-inline-llm-instructions-in-html"
date: "2025-08-20"
scraped_at: "2026-03-02T09:29:40.659913718+00:00"
language: "en-zh"
translated: true
description: "llms.txt is an emerging standard for making content such as docs available for direct consumption by AIs. We’re proposing a convention to include such content directly in HTML responses."
---

render_with_liquid: false
Aug 20, 2025

2025年8月20日

A proposal for inline LLM instructions in HTML based on llms.txt

基于 `llms.txt` 标准的 HTML 内联大语言模型（LLM）指令提案

How do you tell an AI agent what it needs to do when it hits a protected page? Most systems rely on external documentation or pre-configured knowledge, but there's a simpler approach.

当 AI 智能体访问受保护页面时，你该如何告诉它接下来该做什么？目前大多数系统依赖外部文档或预配置的知识，但其实存在一种更简洁的方案。

What if the instructions were right there in the HTML response?

如果这些指令就直接嵌入在 HTML 响应中呢？

[llms.txt](https://llmstxt.org/) is an emerging standard for making content such as docs available for direct consumption by AIs. We’re proposing a convention to include such content directly in HTML responses as `<script type="text/llms.txt">`.

[llms.txt](https://llmstxt.org/) 是一项新兴标准，旨在使文档等内容可被 AI 直接解析与消费。我们提议一种约定：将此类内容以内联方式直接嵌入 HTML 响应中，形式为 `<script type="text/llms.txt">`。

## Our use case

## 我们的实际用例

Vercel protects preview deployments behind [Vercel Authentication](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments/vercel-authentication) by default. This prevents random users from accessing your private, under-development software. However, it also prevents coding agents like Cursor, Devin, or Claude Code from being able to directly access your deployments.

Vercel 默认通过 [Vercel 认证（Vercel Authentication）](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments/vercel-authentication) 保护预览部署（preview deployments）。此举可防止随机用户访问你私有的、尚在开发中的软件；但同时也导致 Cursor、Devin 或 Claude Code 等编程智能体无法直接访问你的部署。

We already [provide various mechanisms for automated software to access protected URLs](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation), and additionally [we introduced an MCP server](https://vercel.com/docs/mcp/vercel-mcp) with functions such as `get_access_to_vercel_url` or `web_fetch_vercel_url` to directly help the agent to access the deployments.

我们已 [提供多种机制，供自动化软件访问受保护的 URL](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation)，此外还 [推出了一个 MCP 服务器（MCP server）](https://vercel.com/docs/mcp/vercel-mcp)，内置 `get_access_to_vercel_url` 或 `web_fetch_vercel_url` 等函数，以直接协助智能体访问部署。

> _**But how does the agent know these methods exist?**_

> _**但智能体如何得知这些方法的存在？**_

This is when we had the idea: Why don’t we just put instructions for agents directly into the HTML of the HTTP 401 response that explains how to access a deployment when they don’t have access.

正是在此刻，我们萌生了一个想法：何不直接将面向智能体的操作指引嵌入 HTTP 401 响应的 HTML 中？这份指引即可清晰说明：当智能体无权访问某部署时，应如何获取访问权限。

## The proposal

## 提案

We suggest using:

我们建议使用：

```html
1<script type="text/llms.txt">

2  Instructions to the LLM go here.

3</script>
```

to inline instruction to an LLM directly in the HTML.

将指令以内联方式直接嵌入 HTML 中，供大语言模型（LLM）使用。

## Why use `<script>` with a new type?

## 为何使用带有新类型的 `<script>` 元素？

Browsers ignore script elements with an unknown type. This ensures that the content has no impact on rendering in regular browsers.

浏览器会忽略类型未知的 `<script>` 元素。这确保了该内容在常规浏览器中渲染时不会产生任何影响。

Script elements are legal inside `<head>` and hence can be placed near the top of the document where LLMs are most likely to notice them. Unlike browsers, LLMs won't ignore them.

`<script>` 元素在 `<head>` 中是合法的，因此可将其置于文档顶部附近——而这正是大语言模型最有可能注意到的位置。与浏览器不同，大语言模型不会忽略它们。

Unknown script elements can contain any content (except for `</script>`) which makes them great containers for markdown or other formats designed for LLMs.

类型未知的 `<script>` 元素可容纳任意内容（除 `</script>` 字符串外），因此非常适合作为面向大语言模型的 Markdown 或其他格式的容器。

## Why base this on llms.txt?

## 为何基于 llms.txt 构建？

[llms.txt](https://llmstxt.org/) 已被广泛采用，用于以可发现的方式在 Web 上发布面向大语言模型（LLM）的内容，而本规范旨在与之无缝契合。[AGENTS.md](https://agents.md/) 是该领域另一项相关标准，专为仓库的智能体（agent）导向上下文而设计。由于 AGENTS.md 当前主要用于仓库内部场景，而 llms.txt 则聚焦于 Web 发布，因此我们决定与 llms.txt 对齐。

## Our production use case

## 我们的生产实践用例

我们最近已将该规范部署至默认的 `401` 页面（用于 Vercel 部署）。

我们使用的具体指令如下：

```text
1<script type="text/llms.txt">

2  ## Note to agents accessing this page:



4  This page requires authentication to access. Automated agents should use a

5  Vercel authentication bypass token to access this page.
```

7  The easiest way to get a token is using the get_access_to_vercel_url or  

7  获取令牌最简单的方法是使用 Vercel MCP 服务器的 `get_access_to_vercel_url` 或  

8  web_fetch_vercel_url functions of the Vercel MCP server at  

8  `web_fetch_vercel_url` 函数，该服务器位于  

9  <https://mcp.vercel.com> (Docs at <https://vercel.com/docs/mcp/vercel-mcp>).  

9  <https://mcp.vercel.com>（文档地址：<https://vercel.com/docs/mcp/vercel-mcp>）。

11  Alternatively, this URL documents how to use the bypass token:  

11  另外，以下网址详细说明了如何使用绕过令牌（bypass token）：  

12  <https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation>  

12  <https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation>  

13  You need to prompt the user to provide the bypass token to access this  

13  您需要提示用户提供绕过令牌，才能访问此  

14  page. The URL above also explains how the user can access the bypass token.  

14  页面。上述网址还说明了用户如何获取该绕过令牌。  

15  Then you can calculate a URL of the following form and successfully access it:  

15  然后，您可以构造如下格式的 URL 并成功访问它：

16  `https://current-domain/current-pathname?x-vercel-set-bypass-cookie=true&x-vercel-protection-bypass=$bypass_token`.

16  `https://current-domain/current-pathname?x-vercel-set-bypass-cookie=true&x-vercel-protection-bypass=$bypass_token`。

17</script>
```

17</script>
```

You can try it yourself by running `curl -i https://access-test.vercel.app/ | less`

你可以亲自尝试：运行 `curl -i https://access-test.vercel.app/ | less`

### Example use cases

### 典型使用场景

Many applications are starting to build MCP servers now, but MCP itself lacks a discovery mechanism. `<script type="text/llms.txt">` might be useful to hint to LLMs trying to navigate a site or app that there's an MCP server available that could help them move forward.

目前，许多应用正开始构建 MCP 服务器，但 MCP 自身缺乏服务发现机制。`<script type="text/llms.txt">` 可用于向试图浏览网站或应用的大型语言模型（LLM）发出提示：此处存在一个可用的 MCP 服务器，可协助其继续推进任务。

We think the "How do I get access to this?" use case likely applies to many platforms. More generically, one of the DX features of Vercel has been to automatically link from error messages into our observability experience to investigate the error. Such error pages can use `<script type="text/llms.txt">` to directly point the agent towards the MCP service that can help investigate the issue.

我们认为，“我该如何访问此资源？”这一使用场景很可能适用于众多平台。更广义地说，Vercel 的一项开发者体验（DX）特性是：自动将错误消息链接至可观测性平台，以便深入调查错误原因。此类错误页面即可利用 `<script type="text/llms.txt">`，直接将智能体引导至可协助排查问题的 MCP 服务。

## Standard, convention, or pattern?

## 是标准、约定，还是模式？

One of the great things about LLMs is that they are flexible and can adapt to new environments without specific training. When we shipped our first `<script type="text/llms.txt">`, it worked right away.

LLM 的一大优势在于其灵活性——无需专门训练，即可适应新环境。当我们首次发布 `<script type="text/llms.txt">` 时，它便立即生效。

There was no need to talk to an LLM provider like OpenAI or Anthropic. In fact, the proposal has ephemeral discovery built-in, making it even more seamless than the [baseline llms.txt format](https://llmstxt.org/).

我们无需联系 OpenAI 或 Anthropic 等 LLM 服务商。事实上，该方案内建了临时性服务发现能力，使其比 [基础版 llms.txt 格式](https://llmstxt.org/) 更加无缝自然。

`<script type="text/llms.txt">` doesn't need to be a formal standard. You can just start using it now.

`<script type="text/llms.txt">` 并不需要成为一项正式标准——你完全可以即刻开始使用。