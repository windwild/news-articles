---
title: "Streamdown 2.2 - animated streaming and better support for custom HTML - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/streamdown-2-2"
date: "2025-09-08"
scraped_at: "2026-03-02T09:29:01.682379224+00:00"
language: "en-zh"
translated: true
description: "Streamdown 2.2 delivers animated per-word text streaming, improved custom HTML handling, and drop-in compatibility with ReactMarkdown - making it easier to adopt Streamdown in existing projects."
---
&#123;% raw %}

Sep 8, 2025

2025 年 9 月 8 日

Streamdown 2.2 推出了逐词动画文本流式渲染、改进的自定义 HTML 处理能力，以及与 ReactMarkdown 的即插即用兼容性——让 Streamdown 更轻松地集成到现有项目中。

## Animated streaming

## 动画流式渲染

通过引入 Streamdown 样式表并启用新的 `animated` 属性，流式内容将以平滑的逐词动画形式呈现。这为 AI 聊天界面及其他实时文本应用提供了更精致的用户体验。

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

## 更完善的自定义 HTML 支持

The components prop now accepts custom HTML attributes by adding elements to allowedTags. The Remend engine has also been improved to strip incomplete HTML tags during streaming, preventing visual glitches from partial markup.

`components` 属性现在可通过向 `allowedTags` 中添加元素来支持自定义 HTML 属性。Remend 引擎也已优化，可在流式传输过程中自动移除不完整的 HTML 标签，从而避免因部分标记导致的视觉异常。

```tsx
1<Streamdown

2  allowedTags=&#123;{

3    source: ["id"],  // Allow <source> tag with id attribute

4  }}
```

5  components=&#123;{

5  components=&#123;{

6    source: ({ id, children }) => (

6    source: ({ id, children }) => (

7      <button

7      <button

8        onClick={() => console.log(`Navigate to source: ${id}`)}

8        onClick={() => console.log(`跳转到源代码：${id}`)}

9        className="text-blue-600 underline cursor-pointer"

9        className="text-blue-600 underline cursor-pointer"

10      >

10      >

11        {children}

11        {children}

12      </button>

12      </button>

13    ),

13    ),

14  }}

14  }}

15>

15>

16  {markdown}

16  {markdown}

17</Streamdown>
```

17</Streamdown>
```

## ReactMarkdown compatibility

## ReactMarkdown 兼容性

Streamdown now supports the remaining ReactMarkdown props, making migration a one-line replacement. Projects using ReactMarkdown can swap to Streamdown without refactoring component configurations.

Streamdown 现在支持其余所有 ReactMarkdown 的 props，使得迁移只需一行替换即可完成。使用 ReactMarkdown 的项目可以无缝切换至 Streamdown，无需重构组件配置。

```tsx
1<Streamdown

2  allowedElements={["p", "h1", "h2"]}

3  disallowedElements={["img"]}

4  unwrapDisallowed={false}

5  skipHtml={true}
```

6>

7  {markdown}

8</Streamdown>
```

此版本还移除了 CommonJS 构建，为常见的 JavaScript、TypeScript 和 Shell 标签添加了捆绑式语言别名，并在表格、代码块、LaTeX 和 Mermaid 图表等方面引入了大量渲染与安全修复。

详情请参阅 [Streamdown 文档](https://streamdown.ai/docs)。
&#123;% endraw %}
