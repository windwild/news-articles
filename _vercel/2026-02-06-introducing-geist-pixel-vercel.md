---
title: "Introducing Geist Pixel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-geist-pixel"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:34.905829906+00:00"
language: "en-zh"
translated: true
description: "Geist Pixel is a bitmap-inspired typeface built on the same foundations as Geist and Geist Mono, reinterpreted through a strict pixel grid. It’s precise, intentional, and unapologetically digital."
---
{% raw %}

Feb 6, 2026

2026 年 2 月 6 日

Today, we're expanding the Geist font family with [Geist Pixel](https://vercel.com/font).

今天，我们通过 [Geist Pixel](https://vercel.com/font) 扩展了 Geist 字体家族。

Geist Pixel is a bitmap-inspired typeface built on the same foundations as Geist Sans and Geist Mono, reinterpreted through a strict pixel grid. It's precise, intentional, and unapologetically digital.

Geist Pixel 是一款受位图启发的字体，基于与 Geist Sans 和 Geist Mono 相同的设计基础，并通过严格的像素网格重新诠释。它精准、审慎，且毫不掩饰其数字原生特质。

![](images/introducing-geist-pixel-vercel/img_001.jpg)![](images/introducing-geist-pixel-vercel/img_002.jpg)

### Same system, new texture

### 同一体系，全新质感

Geist Pixel isn't a novelty font. It's a system extension.

Geist Pixel 并非一款猎奇字体，而是整个字体系统的一次延伸。

Just like Geist Mono was created for developers, Geist Pixel was designed with real usage in mind, not as a visual gimmick, but as a functional tool within a broader typographic system.

正如 Geist Mono 专为开发者而生，Geist Pixel 的设计也立足于真实使用场景——它并非视觉噱头，而是更广泛排版体系中一件功能完备的工具。

It includes five distinct variants, each exported separately:

它包含五种风格迥异的变体，各自独立导出：

- Geist Pixel Square  
- Geist Pixel Square（Geist Pixel 方形体）

- Geist Pixel Grid  
- Geist Pixel Grid（Geist Pixel 网格体）

- Geist Pixel Circle  
- Geist 像素圆圈  

- Geist Pixel Triangle  
- Geist 像素三角形  

- Geist Pixel Line  
- Geist 像素直线  

Every glyph is constructed on a consistent pixel grid, carefully tuned to preserve rhythm, spacing, and legibility. The result feels both nostalgic and contemporary, rooted in early screen typography, but designed for modern products that ship to real users.  

每个字形均基于统一的像素网格构建，并经过精心调校，以保持视觉节奏、字间距与可读性。最终效果既唤起怀旧之情，又兼具当代感：其根源可追溯至早期屏幕排版，但专为面向真实用户的现代产品而设计。

This matters because pixel fonts often break in production. They don't scale properly across viewports, their metrics conflict with existing typography, or they're purely decorative. Geist Pixel was built to solve these problems, maintaining the visual texture teams want while preserving the typographic rigor products require.  

这一点至关重要，因为像素字体在实际生产环境中常常失效：它们无法在不同视口下合理缩放，其字体度量（metrics）与现有排版系统存在冲突，或仅具纯装饰性。Geist Pixel 正是为解决上述问题而生——在保留设计团队所追求的视觉质感的同时，坚守产品所必需的排版严谨性。

It shares the same core principles as the rest of the Geist family:  

它与整个 Geist 字体家族共享相同的核心设计原则：

- Clear structure  
- 清晰的结构  

- Predictable metrics  
- 可预测的字体度量  

- Strong alignment across layouts  
- 跨布局的强对齐性  

- Designed to scale across platforms and use cases  
- 专为跨平台、多场景缩放而设计

### **Getting started is easy**

### **入门非常简单**

[Get started with Geist Pixel](https://vercel.com/font) and start building. Install it directly:

[通过 Geist Pixel 快速上手](https://vercel.com/font)，立即开始构建。直接安装：

```bash
npm i geist
```

```bash
npm i geist
```

**Exports and CSS variables:**

**导出组件与 CSS 变量：**

- `GeistPixelSquare`: --font-geist-pixel-square

- `GeistPixelSquare`: --font-geist-pixel-square

- `GeistPixelGrid`: --font-geist-pixel-grid

- `GeistPixelGrid`: --font-geist-pixel-grid

- `GeistPixelCircle`: --font-geist-pixel-circle

- `GeistPixelCircle`: --font-geist-pixel-circle

- `GeistPixelTriangle`: --font-geist-pixel-triangle

- `GeistPixelTriangle`: --font-geist-pixel-triangle

- `GeistPixelLine`: --font-geist-pixel-line

- `GeistPixelLine`: --font-geist-pixel-line


And use it in `layout.tsx,` e.g. for `GeistPixelSquare`:

并在 `layout.tsx` 中使用，例如 `GeistPixelSquare`：

`app/layout.tsx`

`app/layout.tsx`

```typescript
import { GeistPixelSquare } from "geist/font/pixel";



export default function RootLayout({ children }) {

4 return (

5   <html lang="en" className={GeistPixelSquare.variable}>

6     <body>{children}</body>

7    </html>

8  );

9}
```

Learn more in the [README](https://www.npmjs.com/package/geist?activeTab=readme).

更多详情请参阅 [README](https://www.npmjs.com/package/geist?activeTab=readme)。

### Designed for the web and for modern products

### 专为网页与现代产品而设计

While many pixel fonts are purely expressive, Geist Pixel is meant to ship. It works in real UI contexts: banners, dashboards, experimental layouts, product moments, and systems where typography becomes part of the interface language.

尽管许多像素字体纯粹用于表现性目的，Geist Pixel 却是为实际交付而生。它适用于真实的用户界面场景：横幅（banners）、仪表盘（dashboards）、实验性布局（experimental layouts）、产品关键时刻（product moments），以及排版本身成为界面语言一部分的系统。

Special care was put into:

我们特别注重以下方面：

- Vertical metrics aligned with Geist and Geist Mono

- 垂直度量（vertical metrics）与 Geist 和 Geist Mono 保持一致

- Consistent cap height and x-height behavior

- 大写字母高度（cap height）与 x 字高（x-height）行为保持一致

- Multiple variants for different densities and use cases

- 提供多种变体，适配不同密度需求与使用场景

- Seamless mixing with the rest of the Geist family

- 可与 Geist 字体家族其余成员无缝混排

![](images/introducing-geist-pixel-vercel/img_003.jpg)![](images/introducing-geist-pixel-vercel/img_004.jpg)

It's designed for the web, for modern products, and for an era where interfaces are increasingly shaped by AI-driven workflows.

它专为网页而生，为现代产品而造，更面向一个界面日益由 AI 驱动的工作流所塑造的时代。

### Crafted on a grid, refined by hand

### 基于网格精心打造，由手细致雕琢

Although Geist Pixel is grid-based, it wasn't generated mechanically.

尽管 Geist Pixel 基于网格设计，但它并非通过机械方式生成。

Each glyph was manually refined to avoid visual noise, uneven weight distribution, and awkward diagonals. Corners, curves, and transitions were adjusted pixel by pixel to maintain clarity at small sizes and personality at larger scales. Horizontal metrics use a semi-mono approach, and letterforms take inspiration from both its Mono and Sans counterparts. Constraints weren't a limitation, they were the design tool.

每个字形均由人工精细调整，以避免视觉杂乱、笔画粗细不均以及别扭的斜线。拐角、曲线与笔画过渡均逐像素优化，确保在小字号下清晰可辨，在大字号下仍富于个性。其水平度量采用半等宽（semi-mono）方案，字形设计则同时汲取了 Geist Mono 与 Geist Sans 的灵感。约束条件并非限制，而是核心的设计工具。

Geist Pixel ships with:

Geist Pixel 包含：

- 5 variants  
- 5 种字重变体  

- 480 glyphs  
- 480 个字形  

- 7 stylistic sets  
- 7 套风格集  

- 32 supported languages  
- 支持 32 种语言  

Built with the same system mindset as Geist and Geist Mono, it's easy to adopt without breaking layout or rhythm.

它与 Geist 和 Geist Mono 共享一致的系统化设计理念，因此可轻松集成，而不会破坏现有排版结构或节奏韵律。

### Already shaping what's next

### 已悄然塑造未来

Even before its public release, Geist Pixel has already started influencing the visual language of Vercel. Since being shared internally a few weeks ago, it's found its way into explorations, experiments, and early redesign work, shaping tone, texture, and expression across the product. In many ways, it's already part of the system.

在正式对外发布之前，Geist Pixel 就已开始影响 Vercel 的视觉语言。数周前该字体在公司内部分享后，便迅速融入了各类探索性设计、实验性项目以及早期的重构工作中，持续塑造着整个产品的语调、质感与表现力。从许多方面来看，它早已成为系统的一部分。

### One family, expanding

### 一个家族，持续扩展

With Geist, Geist Mono, and now Geist Pixel, the family spans a broader range, from highly functional UI text to expressive, system-driven display moments.

随着 Geist、Geist Mono，以及如今的 Geist Pixel 相继推出，这一字体家族的覆盖范围日益广阔——从高度功能化的 UI 正文字体，到富于表现力、由系统驱动的展示型排版场景，皆在其范畴之内。

And we're not stopping here. Geist Serif is already in progress. Same system thinking. A new voice.

我们的探索远未止步。Geist Serif 已在开发之中。延续同一套系统化的设计思维，带来一种全新的声音。

[Download Geist Pixel](https://vercel.com/font) and start building.

[下载 Geist Pixel](https://vercel.com/font)，即刻开始构建。

None of this would have been possible without an incredible group of people behind the scenes. Huge thanks to [Andrés Briganti](https://x.com/ambriganti) for the obsessive level of craft and care poured into the design of the font itself, and to [Guido Ferreyra](https://x.com/guidoferreyra) for his support refining and tuning the font along the way; to [Luis Gutierrez Rico](https://x.com/luisgurico) for bringing Geist Pixel to life through motion and subtle magic; to [Christopher Kindl](https://x.com/kindlaar) for helping us put together the landing page and obsessing over those small details that make everything feel just right; to [Marijana Pavlinić](https://x.com/marijanapav) for constantly pushing us with bold, unexpected, and wildly creative ideas; and to [Zahra Jabini](https://x.com/ZeeJab) for the coordination, technical support, and for making sure all the pieces actually came together. This was a true team effort, and I'm incredibly grateful to have built this with all of you.

若无幕后一群非凡人士的鼎力支持，这一切都不可能实现。衷心感谢 [Andrés Briganti](https://x.com/ambriganti)，他以近乎偏执的专注与匠心倾注于字体本身的创作；感谢 [Guido Ferreyra](https://x.com/guidoferreyra) 在字体打磨与调优过程中给予的持续支持；感谢 [Luis Gutierrez Rico](https://x.com/luisgurico)，以精妙的动效与细腻的“魔法”赋予 Geist Pixel 生命；感谢 [Christopher Kindl](https://x.com/kindlaar)，协助我们打造落地页，并执着于那些让整体体验恰到好处的细微之处；感谢 [Marijana Pavlinić](https://x.com/marijanapav)，始终以大胆、出人意料且极具爆发力的创意不断推动我们前行；也感谢 [Zahra Jabini](https://x.com/ZeeJab)，在项目统筹、技术支援以及确保所有环节真正协同落地等方面所付出的关键努力。这是一次真正的团队协作，能与各位共同完成这项工作，我深感荣幸与感激。
{% endraw %}
