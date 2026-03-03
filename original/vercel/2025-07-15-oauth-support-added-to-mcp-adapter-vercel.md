---
title: "OAuth support added to MCP Adapter - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/oauth-support-added-to-mcp-adapter"
date: "2025-07-15"
scraped_at: "2026-03-02T09:31:25.515625991+00:00"
language: "en"
translated: false
description: "Vercel's open-source MCP adapter now supports the latest MCP Authorization spec—letting you securely ship, OAuth-enabled MCP servers."
---




Jul 15, 2025

Secure your MCP servers with OAuth using version `1.0.0` of the [MCP Adapter](https://github.com/vercel/mcp-adapter), which now includes official support for the [MCP Authorization spec](https://modelcontextprotocol.io/specification/2025-06-18/basic/authorization). This release introduces:

- Helper functions for OAuth-compliant authorization flows

- A new `withMcpAuth` wrapper for securing routes

- One-click deployable examples with popular auth providers like Better Auth, Clerk, Descope, Stytch, and WorkOS


Here’s an example of how to integrate auth in your MCP server:

app/\[transport\]/route.ts

```javascript
import { createMcpHandler, withMcpAuth } from 'mcp-handler';



const handler = createMcpHandler((server) => {

4  server.tool(

5    'roll_dice',

6    'Rolls an N-sided die',

7    { sides: z.number().int().min(2) },

8    async ({ sides }) => {

9      const value = 1 + Math.floor(Math.random() * sides);

10      return { content: [{ type: 'text', text: `🎲 You rolled a ${value}!` }] };

11    }

12  );

13})



const verifyToken = async (

16  req: Request,

17  bearerToken?: string,

18) => {

19  if (!bearerToken) return undefined;



21  const isValid = bearerToken === '123';

22  if (!isValid) return undefined;



24  return {

25    token: bearerToken,

26    scopes: ['read:stuff'],

27    clientId: 'client123',

28  };

29};



const authHandler = withMcpAuth(handler, verifyToken, {

32  required: true,

33});



export { authHandler as GET, authHandler as POST };
```

Additionally, use the `protectedResourceHandler` to expose resource server metadata for compliant clients. Learn more in the [MCP Auth documentation](https://vercel.com/docs/mcp#enabling-authorization).

### Start building secure MCP servers

Deploy an example MCP server by [cloning our Next.js MCP template](https://vercel.com/templates/ai/model-context-protocol-mcp-with-next-js), or explore starter integrations from our auth partners:

- [Better Auth](https://www.better-auth.com/docs/plugins/mcp)

- [Clerk](https://github.com/clerk/mcp-nextjs-example)

- [Descope](https://github.com/descope/ai/tree/main/examples/nextjs-vercel-mcp-server)

- [Stytch](https://github.com/stytchauth/vercel-mcp-example)

- [WorkOS](https://github.com/workos/vercel-mcp-example)


[**MCP Server with Next.js**\\
\\
Get started building your first MCP server on Vercel.\\
\\
Deploy now](https://vercel.com/templates/next.js/model-context-protocol-mcp-with-next-js)