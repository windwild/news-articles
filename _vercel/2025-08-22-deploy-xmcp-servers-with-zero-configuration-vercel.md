---
title: "Deploy xmcp servers with zero-configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-xmcp-servers-with-zero-configuration"
date: "2025-08-22"
scraped_at: "2026-03-02T09:29:37.864882544+00:00"
language: "en-zh"
translated: true
description: "xmcp, a framework for building and shipping MCP applications with TypeScript, can now be deployed to Vercel with zero-configuration."
---
&#123;% raw %}

Aug 22, 2025

2025 年 8 月 22 日

Vercel now supports [xmcp](https://xmcp.dev/), a framework for building and shipping MCP servers with TypeScript, with zero-configuration.

Vercel 现已支持 [xmcp](https://xmcp.dev/) —— 一个用于使用 TypeScript 构建和部署 MCP 服务器的框架，开箱即用，无需配置。

xmcp uses file-based routing to create tools for your MCP server.

xmcp 采用基于文件的路由机制，为您的 MCP 服务器创建工具。

```text
my-project/

2├── src/

3│   ├── middleware.ts

4│   └── tools/

5│       ├── greet.ts

6│       ├── search.ts

7├── package.json
```

8├── tsconfig.json

8├── tsconfig.json

9└── xmcp.config.ts

9└── xmcp.config.ts

```

File-based routing using xmcp

```

使用 xmcp 的基于文件的路由

Once you've created a file for your tool, you can use a default export in a way that feels familiar to many other file-based routing frameworks. Below, we create a "greeting" tool.

创建完工具对应的文件后，你可以采用默认导出（default export）的方式，其用法与许多其他基于文件的路由框架类似。下面，我们创建一个名为 “greeting”（问候）的工具。

```javascript
1// src/tools/greet.ts

1// src/tools/greet.ts

import { z } from "zod";

import { z } from "zod";

import { type InferSchema } from "xmcp";

import { type InferSchema } from "xmcp";



export const schema = {

export const schema = {

6  name: z.string().describe("The name of the user to greet"),

6  name: z.string().describe("要问候的用户姓名"),

7};



9// 工具元数据

// Tool metadata

export const metadata = {

11  name: "greet",

11  名称： "greet",

12  description: "Greet the user",

12  描述： "向用户问好",

13};

export default async function greet({ name }: InferSchema<typeof schema>) {

15  const result = `Hello, ${name}!`;

15  const result = `Hello, ${name}!`;

17  return {

17  返回 {

18    content: [{ type: "text", text: result }],

18    content: [{ type: "text", text: result }],

19  };

19  };

20}
```

20}
```

Learn more about [deploying xmcp to Vercel](https://vercel.com/docs/frameworks/backend/xmcp) in the documentation.

请在文档中了解有关 [将 xmcp 部署到 Vercel](https://vercel.com/docs/frameworks/backend/xmcp) 的更多信息。
&#123;% endraw %}
