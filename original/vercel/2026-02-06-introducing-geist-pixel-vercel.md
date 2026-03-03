---
title: "Introducing Geist Pixel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-geist-pixel"
date: "2026-02-06"
scraped_at: "2026-03-02T09:21:34.905829906+00:00"
language: "en"
translated: false
description: "Geist Pixel is a bitmap-inspired typeface built on the same foundations as Geist and Geist Mono, reinterpreted through a strict pixel grid. It’s precise, intentional, and unapologetically digital."
---




Feb 6, 2026

Today, we're expanding the Geist font family with [Geist Pixel](https://vercel.com/font).

Geist Pixel is a bitmap-inspired typeface built on the same foundations as Geist Sans and Geist Mono, reinterpreted through a strict pixel grid. It's precise, intentional, and unapologetically digital.

![](images/introducing-geist-pixel-vercel/img_001.jpg)![](images/introducing-geist-pixel-vercel/img_002.jpg)

### Same system, new texture

Geist Pixel isn't a novelty font. It's a system extension.

Just like Geist Mono was created for developers, Geist Pixel was designed with real usage in mind, not as a visual gimmick, but as a functional tool within a broader typographic system.

It includes five distinct variants, each exported separately:

- Geist Pixel Square

- Geist Pixel Grid

- Geist Pixel Circle

- Geist Pixel Triangle

- Geist Pixel Line


Every glyph is constructed on a consistent pixel grid, carefully tuned to preserve rhythm, spacing, and legibility. The result feels both nostalgic and contemporary, rooted in early screen typography, but designed for modern products that ship to real users.

This matters because pixel fonts often break in production. They don't scale properly across viewports, their metrics conflict with existing typography, or they're purely decorative. Geist Pixel was built to solve these problems, maintaining the visual texture teams want while preserving the typographic rigor products require.

It shares the same core principles as the rest of the Geist family:

- Clear structure

- Predictable metrics

- Strong alignment across layouts

- Designed to scale across platforms and use cases


### **Getting started is easy**

[Get started with Geist Pixel](https://vercel.com/font) and start building. Install it directly:

```bash
npm i geist
```

**Exports and CSS variables:**

- `GeistPixelSquare`: --font-geist-pixel-square

- `GeistPixelGrid`: --font-geist-pixel-grid

- `GeistPixelCircle`: --font-geist-pixel-circle

- `GeistPixelTriangle`: --font-geist-pixel-triangle

- `GeistPixelLine`: --font-geist-pixel-line


And use it in `layout.tsx,` e.g. for `GeistPixelSquare`:

app/layout.tsx

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

### Designed for the web and for modern products

While many pixel fonts are purely expressive, Geist Pixel is meant to ship. It works in real UI contexts: banners, dashboards, experimental layouts, product moments, and systems where typography becomes part of the interface language.

Special care was put into:

- Vertical metrics aligned with Geist and Geist Mono

- Consistent cap height and x-height behavior

- Multiple variants for different densities and use cases

- Seamless mixing with the rest of the Geist family


![](images/introducing-geist-pixel-vercel/img_003.jpg)![](images/introducing-geist-pixel-vercel/img_004.jpg)

It's designed for the web, for modern products, and for an era where interfaces are increasingly shaped by AI-driven workflows.

### Crafted on a grid, refined by hand

Although Geist Pixel is grid-based, it wasn't generated mechanically.

Each glyph was manually refined to avoid visual noise, uneven weight distribution, and awkward diagonals. Corners, curves, and transitions were adjusted pixel by pixel to maintain clarity at small sizes and personality at larger scales. Horizontal metrics use a semi-mono approach, and letterforms take inspiration from both its Mono and Sans counterparts. Constraints weren't a limitation, they were the design tool.

Geist Pixel ships with:

- 5 variants

- 480 glyphs

- 7 stylistic sets

- 32 supported languages


Built with the same system mindset as Geist and Geist Mono, it's easy to adopt without breaking layout or rhythm.

### Already shaping what's next

Even before its public release, Geist Pixel has already started influencing the visual language of Vercel. Since being shared internally a few weeks ago, it's found its way into explorations, experiments, and early redesign work, shaping tone, texture, and expression across the product. In many ways, it's already part of the system.

### One family, expanding

With Geist, Geist Mono, and now Geist Pixel, the family spans a broader range, from highly functional UI text to expressive, system-driven display moments.

And we're not stopping here. Geist Serif is already in progress. Same system thinking. A new voice.

[Download Geist Pixel](https://vercel.com/font) and start building.

None of this would have been possible without an incredible group of people behind the scenes. Huge thanks to [Andrés Briganti](https://x.com/ambriganti) for the obsessive level of craft and care poured into the design of the font itself, and to [Guido Ferreyra](https://x.com/guidoferreyra) for his support refining and tuning the font along the way; to [Luis Gutierrez Rico](https://x.com/luisgurico) for bringing Geist Pixel to life through motion and subtle magic; to [Christopher Kindl](https://x.com/kindlaar) for helping us put together the landing page and obsessing over those small details that make everything feel just right; to [Marijana Pavlinić](https://x.com/marijanapav) for constantly pushing us with bold, unexpected, and wildly creative ideas; and to [Zahra Jabini](https://x.com/ZeeJab) for the coordination, technical support, and for making sure all the pieces actually came together. This was a true team effort, and I'm incredibly grateful to have built this with all of you.