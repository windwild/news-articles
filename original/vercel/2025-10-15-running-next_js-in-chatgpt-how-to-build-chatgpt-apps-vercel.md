---
title: "Running Next.js in ChatGPT: How to Build ChatGPT Apps - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/running-next-js-inside-chatgpt-a-deep-dive-into-native-app-integration"
date: "2025-10-15"
scraped_at: "2026-03-02T09:27:30.809760707+00:00"
language: "en"
translated: false
description: "Next.js now runs natively in ChatGPT with working navigation, React Server Components, and full features. Learn how we made this possible behind ChatGPTs triple iframe architecture and deploy our star..."
---




Oct 15, 2025

When OpenAI announced the Apps SDK with Model Context Protocol (MCP) support, it opened the door to embedding web applications directly into ChatGPT. But there's a significant difference between serving static HTML in an iframe and running a full Next.js application with client-side navigation, React Server Components, and dynamic routing.

This is the story of how we bridged that gap. We created a Next.js app that runs natively inside ChatGPT's triple-iframe architecture, complete with navigation and all the modern features you'd expect from a Next.js application.

## What ChatGPT apps and MCP enable

[ChatGPT apps](https://openai.com/index/introducing-apps-in-chatgpt/) are interactive applications that run inside ChatGPT conversations. When you ask ChatGPT to "find me a hotel in Paris," a Booking.com widget appears directly in the chat with real search results you can interact with. These apps reach over 800 million ChatGPT users and appear naturally when relevant to the conversation.

ChatGPT apps are built on [Model Context Protocol](https://vercel.com/blog/model-context-protocol-mcp-explained) (MCP), an open standard that connects AI models to external tools and data. MCP works like REST or GraphQL, but for AI agents. Instead of hard-coding API calls, you define tools and resources in a structured format that models can discover and use. When ChatGPT needs to show your app, it fetches HTML from your MCP server and renders it in an iframe.

For Next.js developers, this means your existing application can run inside ChatGPT with the right patches, giving you immediate distribution without rebuilding from scratch. Our [starter template](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) gives you a working ChatGPT app you can [deploy to Vercel](https://vercel.com/templates/ai/chatgpt-app-with-next-js) right away.

[**Ready to build your own ChatGPT app?**\\
\\
Deploy our ChatGPT Apps SDK Next.js starter template to Vercel and start experimenting right away.\\
\\
Deploy now](https://vercel.com/templates/ai/chatgpt-app-with-next-js)

The template handles all the browser API patches and MCP server configuration automatically. ChatGPT's nested-iframe architecture breaks several Next.js features. Understanding how the patches fix these issues helps you customize and extend your app beyond the starter.

## How ChatGPT's nested-iframe architecture breaks modern frameworks

ChatGPT renders apps in a three-layer iframe architecture to protect itself from potentially malicious apps. An iframe is an HTML element that embeds one webpage inside another, creating an isolated sandbox.

```text
chatgpt.com

2  └── web-sandbox.oaiusercontent.com (sandbox iframe)

3     └── web-sandbox.oaiusercontent.com (inner iframe)

4        └── your app's HTML
```

The sandbox domain (`web-sandbox.oaiusercontent.com`) acts as a security buffer between ChatGPT and your app. This isolates apps from ChatGPT's main interface and protects users from potentially harmful code.

But this security model creates several technical challenges. When Next.js runs inside the deepest iframe, it thinks its origin is `web-sandbox.oaiusercontent.com` instead of your actual domain.

This behavior breaks several core features:

1. **Asset loading breaks:** Next.js requests `/_next/static/chunks/app.js` from the sandbox domain instead of your actual domain, returning 404s

2. **Relative URLs resolve incorrectly:** Images, fonts, and API calls using relative paths (like `/logo.png` or `/api/data`) resolve against the sandbox domain instead of your app's domain

3. **Browser history stores full URLs:**`history.pushState` saves `https://your-app.vercel.app/about`, which exposes your real domain and breaks the sandbox security model

4. **Client-side navigation fails:** When you click a Next.js Link, fetch requests go to the sandbox domain instead of your server

5. **CORS blocks React Server Components:** Cross-origin requests from the iframe to your server fail without proper headers. Browsers also send `OPTIONS` preflight requests that Next.js doesn't handle by default

6. **Parent frames modify your HTML:** ChatGPT occasionally adds attributes to your root `<html>` element, causing React hydration mismatches

7. **External links navigate inside the iframe:** Links to external sites try to load inside the constrained iframe instead of opening in the user's browser


Let's explore how we solved each of these problems.

## **Making static assets load from your actual domain**

Next.js generates asset paths like `/_next/static/chunks/app-pages-browser.js`. When running in the ChatGPT iframe, these requests resolve to `https://web-sandbox.oaiusercontent.com/_next/static/chunks/app-pages-browser.js`. But that URL doesn't exist. The assets live on your actual domain.

Next.js provides `assetPrefix` for exactly this scenario. Setting `assetPrefix` to your app's URL forces all `/_next/` requests to use the correct origin:

next.config.ts

```typescript
import type { NextConfig } from "next";

import { baseURL } from "./baseUrl";



const nextConfig: NextConfig = {

5  assetPrefix: baseURL, // Forces /_next/ requests to use your-app.vercel.app

6};



export default nextConfig;
```

The `baseURL` is dynamically determined based on the environment:

baseUrl.ts

```typescript
export const baseURL =

2  process.env.NODE_ENV == "development"

3    ? "<http://localhost:3000>"

4    : "https://" +

5      (process.env.VERCEL_ENV === "production"

6        ? process.env.VERCEL_PROJECT_PRODUCTION_URL

7        : process.env.VERCEL_BRANCH_URL || process.env.VERCEL_URL);
```

This ensures assets load correctly in development, preview, and production environments.

## **Setting a base URL for all relative paths**

Even with `assetPrefix` configured, other relative URLs still break. Images, fonts, and API calls using relative paths (like `/logo.png`, `/fonts/inter.woff2`, or `/api/data`) all resolve to `https://web-sandbox.oaiusercontent.com` instead of your domain. Next.js doesn't have a built-in way to rewrite every relative URL in your app.

The HTML `<base>` element solves this. It sets the base URL for all relative URLs in a document:

app/layout.tsx

```typescript
function NextChatSDKBootstrap({ baseUrl }: { baseUrl: string }) {

2  return (

3    <>

4      <base href={baseUrl}></base>

5      {/* Other bootstrap code... */}

6    </>

7  );

8}
```

With this single element, every relative URL automatically resolves against your actual domain. This includes images (`<img src="/logo.png">`), stylesheets (`<link href="/styles.css">`), and API calls (`fetch('/api/data')`).

## **Patching browser history to prevent URL leaks**

Next.js uses the History API (`history.pushState` and `history.replaceState`) to update the URL bar during client-side navigation. However, when running inside an iframe with a different displayed origin, these APIs store full URLs like `https://your-app.vercel.app/about`. This exposes your real domain and breaks the sandbox security model.

Our solution is to intercept calls to `history.pushState` and `history.replaceState`, stripping them down to just the path, search params, and hash:

app/layout.tsx

```typescript
const originalReplaceState = history.replaceState;

history.replaceState = (state, unused, url) => {

3  const u = new URL(url ?? "", window.location.href);

4  const href = u.pathname + u.search + u.hash;

5  originalReplaceState.call(history, state, unused, href);

6};



const originalPushState = history.pushState;

history.pushState = (state, unused, url) => {

10  const u = new URL(url ?? "", window.location.href);

11  const href = u.pathname + u.search + u.hash;

12  originalPushState.call(history, state, unused, href);

13};
```

This ensures that navigation history entries only contain relative paths like `/about` instead of full URLs, preserving the iframe's security boundary while maintaining functional browser history and back/forward buttons.

## **Rewriting fetch requests for client-side navigation**

Next.js uses a sophisticated client-side navigation system powered by React Server Components (RSC). When you click a Link, Next.js makes a `fetch` request to load the new page's RSC payload (a special format containing the component tree and data).

But remember, your app runs in an iframe at `web-sandbox.oaiusercontent.com` while the server is at `your-app.vercel.app`. Without intervention, these fetch requests fail because they target the wrong domain.

Our solution is to patch `window.fetch` to rewrite same-origin requests to use the correct base URL:

app/layout.tsx

```typescript
const appOrigin = new URL(baseUrl).origin;

const isInIframe = window.self !== window.top;



if (isInIframe && window.location.origin !== appOrigin) {

5  const originalFetch = window.fetch;



7  window.fetch = (input: URL | RequestInfo, init?: RequestInit) => {

8    // Parse the request URL from various input types

9    let url = /* ... parse input to URL ... */;



11    // If the request targets the iframe's origin, rewrite it

12    if (url.origin === window.location.origin) {

13      const newUrl = new URL(baseUrl);

14      newUrl.pathname = url.pathname;

15      newUrl.search = url.search;

16      newUrl.hash = url.hash;



18      return originalFetch.call(window, newUrl.toString(), {

19        ...init,

20        mode: "cors", // Enable CORS for cross-origin RSC requests

21      });

22    }



24    return originalFetch.call(window, input, init);

25  };

26}
```

This patch only runs when:

1. The app is inside an iframe (`window.self !== window.top`)

2. The iframe's origin differs from the app's actual origin


When these conditions are met, any fetch request to the iframe's origin is transparently rewritten to use the app's real origin, with CORS mode enabled for cross-origin requests.

## Adding CORS headers for cross-origin requests

With fetch patching in place, client-side navigation now makes cross-origin requests from the iframe to your server. But these requests will fail without proper CORS headers.

Modern browsers also send `OPTIONS` preflight requests before cross-origin `POST` requests (which Next.js uses for RSC payloads). Without handling these `OPTIONS` requests, navigation hangs.

Next.js middleware runs on every request before it's processed, which makes it the perfect place to add CORS headers and solve this problem:

middleware.ts

```typescript
import { NextResponse } from "next/server";

import type { NextRequest } from "next/server";



export function middleware(request: NextRequest) {

5  // Handle OPTIONS preflight requests

6  if (request.method === "OPTIONS") {

7    const response = new NextResponse(null, { status: 204 });

8    response.headers.set("Access-Control-Allow-Origin", "*");

9    response.headers.set(

10      "Access-Control-Allow-Methods",

11      "GET,POST,PUT,DELETE,OPTIONS"

12    );

13    response.headers.set("Access-Control-Allow-Headers", "*");

14    return response;

15  }



17  // Add CORS headers to all responses

18  return NextResponse.next({

19    headers: {

20      "Access-Control-Allow-Origin": "*",

21      "Access-Control-Allow-Methods": "GET,POST,PUT,DELETE,OPTIONS",

22      "Access-Control-Allow-Headers": "*",

23    },

24  });

25}



export const config = {

28  matcher: "/:path*", // Apply to all routes

29};
```

This middleware:

1. **Responds to OPTIONS requests** with a 204 status and appropriate CORS headers

2. **Adds CORS headers to all responses** so cross-origin fetch requests succeed


Now when Next.js makes an RSC request during navigation, the browser's preflight check passes and the actual request receives the data it needs.

## **Preventing parent frame interference with DOM mutations**

ChatGPT's parent frames occasionally modify the root `<html>` element by adding attributes. When React tries to hydrate, the server-rendered HTML doesn't match the DOM, causing hydration mismatch errors.

Our solution is to use a `MutationObserver` to watch for attribute changes on the root element and immediately remove unauthorized modifications:

app/layout.tsx

```typescript
const htmlElement = document.documentElement;

const observer = new MutationObserver((mutations) => {

3  mutations.forEach((mutation) => {

4    if (

5      mutation.type === "attributes" &&

6      mutation.target === htmlElement

7    ) {

8      const attrName = mutation.attributeName;

9      if (attrName && attrName !== "suppresshydrationwarning") {

10        htmlElement.removeAttribute(attrName);

11      }

12    }

13  });

14});



observer.observe(htmlElement, {

17  attributes: true,

18  attributeOldValue: true,

19});
```

We also add `suppressHydrationWarning` to the `<html>` tag to prevent React from logging warnings:

app/layout.tsx

```typescript
1<html lang="en" suppressHydrationWarning>
```

While this isn't a perfect solution (the parent frame shouldn't modify our HTML), it prevents the console from being flooded with hydration warnings.

## **Opening external links in the user's browser**

Without intervention, links to external sites try to navigate inside the constrained iframe. This creates a poor user experience when users click on documentation, blog posts, or other external resources.

ChatGPT provides an `openai.openExternal()` API specifically to handle this case. Our solution is to intercept clicks on external links and use this API to open them in the user's browser:

app/layout.tsx

```typescript
window.addEventListener(

2  "click",

3  (e) => {

4    const a = (e?.target as HTMLElement)?.closest("a");

5    if (!a || !a.href) return;



7    const url = new URL(a.href, window.location.href);

8    if (

9      url.origin !== window.location.origin &&

10      url.origin !== appOrigin

11    ) {

12      try {

13        if (window.openai) {

14          window.openai.openExternal({ href: a.href });

15          e.preventDefault();

16        }

17      } catch {

18        console.warn("openExternal failed, likely not in OpenAI client");

19      }

20    }

21  },

22  true // Use capture phase to intercept before Next.js Link components

23);
```

This ensures external links open in the user's browser instead of navigating inside the constrained iframe.

## **Connecting your Next.js app to ChatGPT with MCP**

With all the browser API patches in place, the final step is implementing the MCP server that connects ChatGPT to your Next.js app. MCP servers expose two main primitives: resources (content that can be displayed) and tools (actions the model can invoke).

### How MCP resources serve HTML to ChatGPT

Resources serve HTML content that ChatGPT renders in iframes. We fetch the homepage HTML and register it as a resource:

app/mcp/route.ts

```typescript
const html = await getAppsSdkCompatibleHtml(baseURL, "/");



server.registerResource(

4  "content-widget",

5  "ui://widget/content-template.html",

6  {

7    title: "Show Content",

8    description: "Displays the homepage content",

9    mimeType: "text/html+skybridge",

10    _meta: {

11      "openai/widgetDescription": "Displays the homepage content",

12      "openai/widgetPrefersBorder": true,

13    },

14  },

15  async (uri) => ({

16    contents: [\
\
17      {\
\
18        uri: uri.href,\
\
19        mimeType: "text/html+skybridge",\
\
20        text: `<html>${html}</html>`,\
\
21        _meta: {\
\
22          "openai/widgetDescription": "Displays the homepage content",\
\
23          "openai/widgetPrefersBorder": true,\
\
24        },\
\
25      },\
\
26    ],

27  })

28);
```

The `mimeType` of `text/html+skybridge` tells ChatGPT to render this as an interactive widget. The `_meta` object contains OpenAI-specific configuration like the widget description and whether to show a border.

### How MCP tools trigger app displays

Tools are actions ChatGPT can invoke. By linking a tool to a resource via `openai/outputTemplate`, ChatGPT knows to render the widget after the tool is called:

app/mcp/route.ts

```typescript
server.registerTool(

2  "show_content",

3  {

4    title: "Show Content",

5    description: "Fetch and display the homepage content with the name of the user",

6    inputSchema: {

7      name: z.string().describe("The name of the user to display"),

8    },

9    _meta: {

10      "openai/outputTemplate": "ui://widget/content-template.html",

11      "openai/toolInvocation/invoking": "Loading content...",

12      "openai/toolInvocation/invoked": "Content loaded",

13      "openai/widgetAccessible": false,

14      "openai/resultCanProduceWidget": true,

15    },

16  },

17  async ({ name }) => {

18    return {

19      content: [\
\
20        {\
\
21          type: "text",\
\
22          text: name,\
\
23        },\
\
24      ],

25      structuredContent: {

26        name: name,

27        timestamp: new Date().toISOString(),

28      },

29      _meta: {

30        "openai/outputTemplate": "ui://widget/content-template.html",

31        "openai/toolInvocation/invoking": "Loading content...",

32        "openai/toolInvocation/invoked": "Content loaded",

33        "openai/widgetAccessible": false,

34        "openai/resultCanProduceWidget": true,

35      },

36    };

37  }

38);
```

The `_meta` object contains OpenAI-specific configuration:

- **`openai/outputTemplate`** **:** Links to the registered resource URI

- **`openai/toolInvocation/invoking`** **:** Text shown while the tool is executing

- **`openai/toolInvocation/invoked`** **:** Text shown after completion

- **`openai/widgetAccessible`** **:** Whether the widget should be keyboard/screen reader accessible

- **`openai/resultCanProduceWidget`** **:** Signals that this tool can render a widget


## How your app receives data from ChatGPT

The app can receive data from tool invocations via the `window.openai.toolOutput` property. ChatGPT automatically populates this object with the `structuredContent` from the tool's response:

app/page.tsx

```typescript
const [name, setName] = useState<string | null>(null);



useEffect(() => {

4  if (typeof window === "undefined") return;



6  if (!window.openai) {

7    (window as any).openai = {};

8  }



10  let currentValue = (window as any).openai.toolOutput;



12  Object.defineProperty((window as any).openai, "toolOutput", {

13    get() {

14      return currentValue;

15    },

16    set(newValue: any) {

17      currentValue = newValue;

18      if (newValue?.name) {

19        setName(newValue.name);

20      }

21    },

22    configurable: true,

23    enumerable: true,

24  });



26  if (currentValue?.name) {

27    setName(currentValue.name);

28  }

29}, []);
```

This reactive pattern allows the app to update its UI whenever ChatGPT invokes a tool. The property setter intercepts changes to `toolOutput` and updates React state accordingly.

## Using React hooks to manage ChatGPT integration

The manual [`window.openai`](https://developers.openai.com/apps-sdk/reference) approach shown above works, but it's verbose and requires boilerplate in every component that needs ChatGPT integration. For production applications, we built a collection of React hooks that abstract the browser API into type-safe patterns.

These hooks handle server-side rendering, optimize re-renders, and provide type safety. Three core hooks cover most use cases:

**`useSendMessage`** **sends followup messages to ChatGPT:**

app/page.tsx

```typescript
const sendMessage = useSendMessage();



3// Trigger a new ChatGPT message from user interaction

4<button onClick={() => sendMessage("Show me more examples")}>

5  More Examples

6</button>
```

**`useWidgetProps`** **accesses tool call outputs with type safety:**

app/page.tsx

```typescript
const toolOutput = useWidgetProps<{ name?: string }>();



3// Access structured data from the tool invocation

const name = toolOutput?.name;
```

**`useDisplayMode`** **customizes your interface based on display mode:**

app/page.tsx

```typescript
const displayMode = useDisplayMode();



3// Render different layouts based on how ChatGPT displays the app

return displayMode === "fullscreen" ? <FullView /> : <CompactView />;
```

The full collection of hooks is available in the [ChatGPT Apps SDK Next.js Starter](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter/tree/main/app/hooks).

## **The advantages this approach unlocks**

This approach provides several significant advantages over simpler iframe embedding.

### Native Next.js navigation

Users can click links and navigate between pages using Next.js's client-side routing. The browser's back and forward buttons work correctly. Navigation is fast thanks to React Server Components streaming page updates instead of reloading the entire iframe.

Without these patches, you'd be limited to serving a single static page or adding yet another iframe layer, which would introduce even more complexity.

### Full Next.js feature set

You're not limited to static HTML. All of Next.js's features work normally:

- React Server Components and streaming

- Server Actions for forms

- Incremental Static Regeneration (ISR)

- Dynamic routing with `[slug]` patterns

- API routes

- Middleware


### Unchanged developer experience

The patches are applied once in `layout.tsx`. The rest of your codebase uses familiar Next.js patterns without workarounds. You can develop locally with `next dev` and deploy to Vercel like any other Next.js app.

### Performance that matches standard Next.js apps

Client-side navigation is faster than full page reloads because only the new page's data transfers over the network, not the entire document. React Server Components enable streaming, so users see content faster on slower connections.

### Native-feeling user experience

The app feels integrated into ChatGPT rather than bolted on. Users can:

- Navigate naturally with working back/forward buttons

- See instant page transitions

- Open external links in their browser

- Experience smooth interactions without iframe nesting issues


## Getting started with Next.js in ChatGPT

These seven patches solve the fundamental incompatibilities between ChatGPT's iframe architecture and Next.js's expectations. The [starter template](https://github.com/vercel-labs/chatgpt-apps-sdk-nextjs-starter) implements all of them, so you can focus on building your app's features instead of wrestling with browser APIs.

Whether you're building productivity tools, data visualizations, or interactive experiences, this foundation brings the full power of Next.js to ChatGPT's 800 million users.

[**Ready to build your own ChatGPT app?**\\
\\
Deploy our ChatGPT Apps SDK Next.js starter template to Vercel and start experimenting right away.\\
\\
Deploy now](https://vercel.com/templates/ai/chatgpt-app-with-next-js)