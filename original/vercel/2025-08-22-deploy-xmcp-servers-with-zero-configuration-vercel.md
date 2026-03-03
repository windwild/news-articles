---
title: "Deploy xmcp servers with zero-configuration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/deploy-xmcp-servers-with-zero-configuration"
date: "2025-08-22"
scraped_at: "2026-03-02T09:29:37.864882544+00:00"
language: "en"
translated: false
description: "xmcp, a framework for building and shipping MCP applications with TypeScript, can now be deployed to Vercel with zero-configuration."
---




Aug 22, 2025

Vercel now supports [xmcp](https://xmcp.dev/), a framework for building and shipping MCP servers with TypeScript, with zero-configuration.

xmcp uses file-based routing to create tools for your MCP server.

```text
my-project/

2├── src/

3│   ├── middleware.ts

4│   └── tools/

5│       ├── greet.ts

6│       ├── search.ts

7├── package.json

8├── tsconfig.json

9└── xmcp.config.ts
```

File-based routing using xmcp

Once you've created a file for your tool, you can use a default export in a way that feels familiar to many other file-based routing frameworks. Below, we create a "greeting" tool.

```javascript
1// src/tools/greet.ts

import { z } from "zod";

import { type InferSchema } from "xmcp";



export const schema = {

6  name: z.string().describe("The name of the user to greet"),

7};



9// Tool metadata

export const metadata = {

11  name: "greet",

12  description: "Greet the user",

13};

export default async function greet({ name }: InferSchema<typeof schema>) {

15  const result = `Hello, ${name}!`;



17  return {

18    content: [{ type: "text", text: result }],

19  };

20}
```

Learn more about [deploying xmcp to Vercel](https://vercel.com/docs/frameworks/backend/xmcp) in the documentation.