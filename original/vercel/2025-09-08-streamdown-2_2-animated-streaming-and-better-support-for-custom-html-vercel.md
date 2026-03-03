---
title: "Streamdown 2.2 - animated streaming and better support for custom HTML - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-2-2"
date: "2025-09-08"
scraped_at: "2026-03-02T09:29:01.682379224+00:00"
language: "en"
translated: false
description: "Streamdown 2.2 delivers animated per-word text streaming, improved custom HTML handling, and drop-in compatibility with ReactMarkdown - making it easier to adopt Streamdown in existing projects."
---




Sep 8, 2025

Streamdown 2.2 delivers animated per-word text streaming, improved custom HTML handling, and drop-in compatibility with ReactMarkdown - making it easier to adopt Streamdown in existing projects.

## Animated streaming

By importing the Streamdown stylesheet and enabling the new animated prop, streaming content renders with smooth per-word text animation. This provides a polished experience for AI chat interfaces and other real-time text applications.

```tsx
import { Streamdown } from "streamdown";

import "streamdown/styles.css";



export default function Page() {

5  return (

6    <Streamdown animated isAnimating={status === "streaming"}>

7      {markdown}

8    </Streamdown>

9  );

10}
```

## Better custom HTML support

The components prop now accepts custom HTML attributes by adding elements to allowedTags. The Remend engine has also been improved to strip incomplete HTML tags during streaming, preventing visual glitches from partial markup.

```tsx
1<Streamdown

2  allowedTags={{

3    source: ["id"],  // Allow <source> tag with id attribute

4  }}

5  components={{

6    source: ({ id, children }) => (

7      <button

8        onClick={() => console.log(`Navigate to source: ${id}`)}

9        className="text-blue-600 underline cursor-pointer"

10      >

11        {children}

12      </button>

13    ),

14  }}

15>

16  {markdown}

17</Streamdown>
```

## ReactMarkdown compatibility

Streamdown now supports the remaining ReactMarkdown props, making migration a one-line replacement. Projects using ReactMarkdown can swap to Streamdown without refactoring component configurations.

```tsx
1<Streamdown

2  allowedElements={["p", "h1", "h2"]}

3  disallowedElements={["img"]}

4  unwrapDisallowed={false}

5  skipHtml={true}

6>

7  {markdown}

8</Streamdown>
```

This release also removes CommonJS builds, adds bundled-language aliases for common JavaScript, TypeScript, and shell labels, and includes numerous rendering and security fixes across tables, code blocks, LaTeX, and Mermaid diagrams.

Learn more in the [Streamdown docs](https://streamdown.ai/docs).