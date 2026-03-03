---
title: "OAuth support added to MCP Adapter - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/oauth-support-added-to-mcp-adapter"
date: "2025-07-15"
scraped_at: "2026-03-02T09:31:25.515625991+00:00"
language: "en-zh"
translated: true
description: "Vercel's open-source MCP adapter now supports the latest MCP Authorization spec—letting you securely ship, OAuth-enabled MCP servers."
---

Jul 15, 2025

2025 年 7 月 15 日

使用 [MCP Adapter](https://github.com/vercel/mcp-adapter) 版本 `1.0.0`，通过 OAuth 保障您的 MCP 服务器安全。该版本现已正式支持 [MCP 授权规范（MCP Authorization spec）](https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization)。本次发布包含以下新特性：

- 面向符合 OAuth 标准的授权流程的辅助函数

- 全新的 `withMcpAuth` 包装器，用于保护路由

- 开箱即用、一键部署的示例项目，已集成主流身份认证服务提供商，包括 Better Auth、Clerk、Descope、Stytch 和 WorkOS


以下是在您的 MCP 服务器中集成身份认证的示例代码：

app/\[transport\]/route.ts

```javascript
import { createMcpHandler, withMcpAuth } from 'mcp-handler';



const handler = createMcpHandler((server) => {

4  server.tool(

4  server.tool(

5    'roll_dice',

5    'roll_dice',

6    'Rolls an N-sided die',

6    '掷一个 N 面骰子',

7    { sides: z.number().int().min(2) },

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {

8    async ({ sides }) => {

9      const value = 1 + Math.floor(Math.random() * sides);

9      const value = 1 + Math.floor(Math.random() * sides);

10      return { content: [{ type: 'text', text: `🎲 You rolled a ${value}!` }] };

10      return { content: [{ type: 'text', text: `🎲 您掷出了 ${value}！` }] };

11    }

11    }

12  );

12  );

13})

13})

```typescript
const verifyToken = async (
  req: Request,
  bearerToken?: string,
) => {
  if (!bearerToken) return undefined;

  const isValid = bearerToken === '123';
  if (!isValid) return undefined;
};
```

```typescript
const verifyToken = async (
  req: Request,
  bearerToken?: string,
) => {
  if (!bearerToken) return undefined;

  const isValid = bearerToken === '123';
  if (!isValid) return undefined;
};
```

24  return {

24  返回 {

25    token: bearerToken,

25    token: bearerToken,

26    scopes: ['read:stuff'],

26    scopes: ['read:stuff'],

27    clientId: 'client123',

27    clientId: 'client123',

28  };

28  };

29};

29};

const authHandler = withMcpAuth(handler, verifyToken, {

const authHandler = withMcpAuth(handler, verifyToken, {

32  required: true,

32  required: true,

33});

33});

```ts
export { authHandler as GET, authHandler as POST };
```

```ts
export { authHandler as GET, authHandler as POST };
```

此外，使用 `protectedResourceHandler` 向符合规范的客户端公开资源服务器元数据。更多详情，请参阅 [MCP 认证文档](https://vercel.com/docs/mcp#enabling-authorization)。

### 开始构建安全的 MCP 服务器

通过 [克隆我们的 Next.js MCP 模板](https://vercel.com/templates/ai/model-context-protocol-mcp-with-next-js) 部署一个示例 MCP 服务器，或探索我们认证合作伙伴提供的入门级集成方案：

- [Better Auth](https://www.better-auth.com/docs/plugins/mcp)

- [Clerk](https://github.com/clerk/mcp-nextjs-example)

- [Descope](https://github.com/descope/ai/tree/main/examples/nextjs-vercel-mcp-server)

- [Stytch](https://github.com/stytchauth/vercel-mcp-example)

- [WorkOS](https://github.com/workos/vercel-mcp-example)

[**MCP Server with Next.js**  
**使用 Next.js 构建 MCP 服务器**  

Get started building your first MCP server on Vercel.  
在 Vercel 上开始构建您的第一个 MCP 服务器。  

Deploy now  
立即部署](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)