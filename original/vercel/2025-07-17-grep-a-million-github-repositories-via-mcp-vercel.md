---
title: "Grep a million GitHub repositories via MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/grep-a-million-github-repositories-via-mcp"
date: "2025-07-17"
scraped_at: "2026-03-02T09:31:09.647732798+00:00"
language: "en"
translated: false
description: "Search 1M+ GitHub repositories from your AI agent using Grep's MCP server. Your agent can now reference coding patterns and solutions used in open source projects to solve problems."
---




Jul 17, 2025

[Grep](https://vercel.com/blog/vercel-acquires-grep) now supports the [Model Context Protocol (MCP)](https://modelcontextprotocol.io/introduction), enabling AI apps to query a million public GitHub repositories using a standard interface. Whether you're building in Cursor, using Claude, or integrating your own agent, Grep can now serve as a searchable code index over HTTP.

## What is the Grep MCP server

MCP is a protocol for exposing tools to large language models (LLMs). Grep’s new MCP server provides an endpoint that searches public GitHub repositories. Through the Grep MCP server, AI agents can issue search queries and retrieve code snippets that match specific patterns or regular expressions, filtered by language, repository, and file path.

It's backed by the same infrastructure as grep.app. Results typically return in a fraction of a second, with snippets ranked for relevance.

## How to configure it in your AI client

Setting up MCP servers is generally straightforward. Once your client is aware of the MCP endpoint, it can introspect the available tools and invoke them directly. Each tool is defined in a machine-readable schema, which makes integration predictable for agents and apps.

To connect an AI client to Grep’s MCP server, use the following configurations.

### **In Cursor:**

```json
1{

2  "mcpServers": {

3    "grep": {

4      "url": "https://mcp.grep.app"

5    }

6  }

7}
```

### **With Claude Code:**

```bash
claude mcp add --transport http grep https://mcp.grep.app
```

## **An example of how to use it**

Let’s say you're writing an MCP server of your own. As you’re implementing it, you have to handle some cases where there’s an error and you want to communicate that to the client. You’re not sure the right way to do that, so you might ask your AI agent how to handle it.

`What's the right way for this MCP tool to return an error message to the client?`

If you have the Grep MCP server configured, your agent may decide to run some code searches to help it answer the question. It may try a few different queries, and eventually arrive at this one, which is looking for a `server.tool` function call that includes a `catch` block.

```json
1{

2 "query": "(?s)server\\.tool.*catch",

3 "language": [\
\
4  "TypeScript",\
\
5  "JavaScript"\
\
6 ],

7 "useRegexp": true

8}
```

The Grep MCP server returns a list of results, which look like this:

```text
Repository: microsoft/rushstack

Path: apps/rush-mcp-server/src/tools/base.tool.ts

URL: https://github.com/microsoft/rushstack/blob/main/apps/rush-mcp-server/src/tools/base.tool.ts

License: Unknown



Snippets:

7--- Snippet 1 (Line 39) ---

8 public register(server: McpServer): void {

9  // TODO: remove ts-ignore

10  // @ts-ignore

11  server.tool(this._options.name, this._options.description, this._options.schema, async (...args) => {

12    try {

13      const result: CallToolResult = await this.executeAsync(...(args as Parameters<ToolCallback<Args>>));

14      return result;

15    } catch (error: unknown) {

16      return {

17        isError: true,

18        content: [\
```\
\
This result in particular suggests the answer: when returning an error response from an MCP tool call, you should set `isError: true` .\
\
To confirm the answer, the LLM runs another query.\
\
```json\
1{\
\
2 "query": "isError: true",\
\
3 "language": [\
\
4  "TypeScript",\
\
5  "JavaScript"\
\
6 ]\
\
7}\
```\
\
That query provides more examples of how MCP servers return error responses.\
\
Based on these search results, the AI agent is able to respond with the answer and offer to update your project to properly handle errors.\
\
## From zero to MCP in minutes\
\
We built Grep's MCP server in an afternoon. Using the [`mcp-handler`](https://vercel.com/changelog/mcp-server-support-on-vercel) package, we turned Grep’s existing API into a fully compliant MCP server. The adapter handles schema, request routing, and response formatting so the only work needed was mapping the search endpoint to the MCP contract.\
\
If you're exposing an existing tool or API to AI clients, Vercel's MCP adapter abstracts the boilerplate and makes development and deployment simple on Vercel.\
\
Try [Grep](https://grep.app/) or Grep's MCP server today.\
\
[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)