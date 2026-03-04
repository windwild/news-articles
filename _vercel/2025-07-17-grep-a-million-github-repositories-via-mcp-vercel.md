---
title: "Grep a million GitHub repositories via MCP - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/grep-a-million-github-repositories-via-mcp"
date: "2025-07-17"
scraped_at: "2026-03-02T09:31:09.647732798+00:00"
language: "en-zh"
translated: true
description: "Search 1M+ GitHub repositories from your AI agent using Grep's MCP server. Your agent can now reference coding patterns and solutions used in open source projects to solve problems."
---
&#123;% raw %}

Jul 17, 2025

2025年7月17日

[Grep](https://vercel.com/blog/vercel-acquires-grep) 现已支持 [Model Context Protocol（MCP）](https://modelcontextprotocol.io/introduction)，使 AI 应用能够通过标准接口查询一百万个公开的 GitHub 仓库。无论您是在 Cursor 中开发、使用 Claude，还是集成您自己的智能体（agent），Grep 现在均可作为基于 HTTP 的可搜索代码索引服务。

## What is the Grep MCP server

## 什么是 Grep MCP 服务器

MCP 是一种将工具暴露给大语言模型（LLM）的协议。Grep 全新推出的 MCP 服务器提供了一个用于搜索公开 GitHub 仓库的端点。借助该服务器，AI 智能体可发起搜索请求，并检索匹配特定模式或正则表达式的代码片段，且支持按编程语言、仓库名称及文件路径进行筛选。

该服务依托于 grep.app 相同的底层基础设施，结果通常在不到一秒内返回，且代码片段按相关性排序。

## How to configure it in your AI client

## 如何在您的 AI 客户端中配置它

配置 MCP 服务器通常十分简单。一旦您的客户端识别到 MCP 端点，即可自动探查（introspect）可用工具并直接调用它们。每个工具均通过机器可读的 Schema 进行定义，从而确保智能体与应用程序的集成过程可预测、可复现。

要将 AI 客户端连接至 Grep 的 MCP 服务器，请使用以下配置。

### **In Cursor:**

### **在 Cursor 中：**

```json
1{

2  `"mcpServers": {`

2  `"mcpServers": {`

3    `"grep": {`

3    `"grep": {`

4      `"url": "https://mcp.grep.app"`

4      `"url": "https://mcp.grep.app"`

5    }`

5    }`

6  }`

6  }`

7}`

7}`

### **With Claude Code:**

### **使用 Claude Code：**

```bash
claude mcp add --transport http grep https://mcp.grep.app
```

```bash
claude mcp add --transport http grep https://mcp.grep.app
```

## **An example of how to use it**

## **使用示例**

Let’s say you're writing an MCP server of your own. As you’re implementing it, you have to handle some cases where there’s an error and you want to communicate that to the client. You’re not sure the right way to do that, so you might ask your AI agent how to handle it.

假设你正在开发自己的 MCP 服务器。在实现过程中，你可能会遇到一些出错的情形，需要将错误信息传达给客户端。如果你不确定正确的处理方式，可以向你的 AI 智能体询问该如何应对。

`What's the right way for this MCP tool to return an error message to the client?`

`这个 MCP 工具应采用何种正确方式向客户端返回错误消息？`

If you have the Grep MCP server configured, your agent may decide to run some code searches to help it answer the question. It may try a few different queries, and eventually arrive at this one, which is looking for a `server.tool` function call that includes a `catch` block.

如果你已配置 Grep MCP 服务器，你的智能体可能会决定执行若干代码搜索，以辅助回答该问题。它可能尝试多个不同的查询，最终得到如下这个查询——其目标是查找包含 `catch` 块的 `server.tool` 函数调用。

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

Grep MCP 服务器返回一个结果列表，其格式如下所示：

```text
Repository: microsoft/rushstack

Path: apps/rush-mcp-server/src/tools/base.tool.ts
```

```text
Repository: microsoft/rushstack

Path: apps/rush-mcp-server/src/tools/base.tool.ts
```

URL: https://github.com/microsoft/rushstack/blob/main/apps/rush-mcp-server/src/tools/base.tool.ts

URL：https://github.com/microsoft/rushstack/blob/main/apps/rush-mcp-server/src/tools/base.tool.ts

License: Unknown

许可证：未知

Snippets:

代码片段：

7--- Snippet 1 (Line 39) ---

7--- 代码片段 1（第 39 行）---

8 public register(server: McpServer): void {

8 public register(server: McpServer): void {

9  // TODO: remove ts-ignore

9  // TODO：移除 ts-ignore

10  // @ts-ignore

10  // @ts-ignore

11  server.tool(this._options.name, this._options.description, this._options.schema, async (...args) => {

11  server.tool(this._options.name, this._options.description, this._options.schema, async (...args) => {

12    try {

12    try {

13      const result: CallToolResult = await this.executeAsync(...(args as Parameters<ToolCallback<Args>>));

13      const result: CallToolResult = await this.executeAsync(...(args as Parameters<ToolCallback<Args>>));

14      return result;

14      return result;

15    } catch (error: unknown) {

15    } catch (error: unknown) {

16      return {

16      return {

17        isError: true,

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

18        content: [\
```\
\
这一结果尤其提示了答案：当从 MCP 工具调用返回错误响应时，您应设置 `isError: true`。\
\
为验证该答案，大语言模型（LLM）会发起另一次查询。\
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
该查询提供了更多关于 MCP 服务器如何返回错误响应的示例。\
\
基于这些搜索结果，AI 智能体能够给出答案，并主动提出更新您的项目，以正确处理错误。\
\
## 从零开始，数分钟内构建 MCP 服务\
\
我们仅用一个下午就构建完成了 Grep 的 MCP 服务器。借助 [`mcp-handler`](https://vercel.com/changelog/mcp-server-support-on-vercel) 包，我们将 Grep 现有的 API 快速升级为完全符合规范的 MCP 服务器。该适配器自动处理 Schema 定义、请求路由与响应格式化，您只需将搜索端点映射到 MCP 协议约定即可。\
\
如果您希望将现有工具或 API 暴露给 AI 客户端，Vercel 提供的 MCP 适配器可帮您屏蔽大量样板代码，让开发与部署在 Vercel 平台上变得极为简单。\
\
立即试用 [Grep](https://grep.app/) 或其 MCP 服务器。\
\
[**使用 Next.js 构建 MCP 服务器**\\
\\
快速上手，在 Vercel 上构建您的首个 MCP 服务器。\\
\\
立即部署](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)
&#123;% endraw %}
