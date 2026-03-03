---
title: "Proposal for inline LLM instructions in HTML based on llms.txt - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/a-proposal-for-inline-llm-instructions-in-html"
date: "2025-08-20"
scraped_at: "2026-03-02T09:29:40.659913718+00:00"
language: "en"
translated: false
description: "llms.txt is an emerging standard for making content such as docs available for direct consumption by AIs. We’re proposing a convention to include such content directly in HTML responses."
---




Aug 20, 2025

A proposal for inline LLM instructions in HTML based on llms.txt

How do you tell an AI agent what it needs to do when it hits a protected page? Most systems rely on external documentation or pre-configured knowledge, but there's a simpler approach.

What if the instructions were right there in the HTML response?

[llms.txt](https://llmstxt.org/) is an emerging standard for making content such as docs available for direct consumption by AIs. We’re proposing a convention to include such content directly in HTML responses as `<script type="text/llms.txt">`.

## Our use case

Vercel protects preview deployments behind [Vercel Authentication](https://vercel.com/docs/deployment-protection/methods-to-protect-deployments/vercel-authentication) by default. This prevents random users from accessing your private, under-development software. However, it also prevents coding agents like Cursor, Devin, or Claude Code from being able to directly access your deployments.

We already [provide various mechanisms for automated software to access protected URLs](https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation), and additionally [we introduced an MCP server](https://vercel.com/docs/mcp/vercel-mcp) with functions such as `get_access_to_vercel_url` or `web_fetch_vercel_url` to directly help the agent to access the deployments.

> _**But how does the agent know these methods exist?**_

This is when we had the idea: Why don’t we just put instructions for agents directly into the HTML of the HTTP 401 response that explains how to access a deployment when they don’t have access.

## The proposal

We suggest using:

```html
1<script type="text/llms.txt">

2  Instructions to the LLM go here.

3</script>
```

to inline instruction to an LLM directly in the HTML.

## Why use <script> with a new type?

Browsers ignore script elements with an unknown type. This ensures that the content has no impact on rendering in regular browsers.

Script elements are legal inside `<head>` and hence can be placed near the top of the document where LLMs are most likely to notice them. Unlike browsers, LLMs won't ignore them.

Unknown script elements can contain any content (except for `</script>`) which makes them great containers for markdown or other formats designed for LLMs.

## Why base this on llms.txt?

[llms.txt](https://llmstxt.org/) has found adoption for publishing LLM-targeted content in a discoverable fashion on the web, and this is meant to fit right in. [AGENTS.md](https://agents.md/) is another related standard in this space meant for agent-directed context of a repository. As it is currently used for in-repository use-cases while llms.txt is concerned with web publishing, we decided to align with llms.txt.

## Our production use case

We recently shipped this on our default `401` page for deployments.

These are the instructions we use:

```text
1<script type="text/llms.txt">

2  ## Note to agents accessing this page:



4  This page requires authentication to access. Automated agents should use a

5  Vercel authentication bypass token to access this page.



7  The easiest way to get a token is using the get_access_to_vercel_url or

8  web_fetch_vercel_url functions of the Vercel MCP server at

9  <https://mcp.vercel.com> (Docs at <https://vercel.com/docs/mcp/vercel-mcp>).



11  Alternatively, this URL documents how to use the bypass token:

12  <https://vercel.com/docs/deployment-protection/methods-to-bypass-deployment-protection/protection-bypass-automation>

13  You need to prompt the user to provide the bypass token to access this

14  page. The URL above also explains how the user can access the bypass token.

15  Then you can calculate a URL of the following form and successfully access it:

16  `https://current-domain/current-pathname?x-vercel-set-bypass-cookie=true&x-vercel-protection-bypass=$bypass_token`.

17</script>
```

You can try it yourself by running `curl -i https://access-test.vercel.app/ | less`

### Example use cases

Many applications are starting to build MCP servers now, but MCP itself lacks a discovery mechanism. `<script type="text/llms.txt">` might be useful to hint to LLMs trying to navigate a site or app that there's an MCP server available that could help them move forward.

We think the "How do I get access to this?" use case likely applies to many platforms. More generically, one of the DX features of Vercel has been to automatically link from error messages into our observability experience to investigate the error. Such error pages can use `<script type="text/llms.txt">` to directly point the agent towards the MCP service that can help investigate the issue.

## Standard, convention, or pattern?

One of the great things about LLMs is that they are flexible and can adapt to new environments without specific training. When we shipped our first `<script type="text/llms.txt">`, it worked right away.

There was no need to talk to an LLM provider like OpenAI or Anthropic. In fact, the proposal has ephemeral discovery built-in, making it even more seamless than the [baseline llms.txt format](https://llmstxt.org/).

`<script type="text/llms.txt">` doesn't need to be a formal standard. You can just start using it now.