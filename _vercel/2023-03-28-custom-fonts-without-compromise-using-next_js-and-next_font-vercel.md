---
render_with_liquid: false
title: "Custom fonts without compromise using  Next.js and `next/font` - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-next-font"
date: "2023-03-28"
scraped_at: "2026-03-02T09:54:01.376626438+00:00"
language: "en-zh"
translated: true
description: "`next/font` automatically self-hosts your custom fonts, preventing layout shift and significantly reducing needed code."
---
render_with_liquid: false
render_with_liquid: false

Mar 28, 2023

2023 年 3 月 28 日

仅需几行代码，即可实现高度优化、自托管的字体。

As web developers, we know the importance of typography in design. Custom fonts can set the tone for a website and enhance its overall aesthetic. However, using custom fonts can often create issues with website performance and user experience.

作为 Web 开发者，我们深知排版在设计中的重要性。自定义字体能够奠定网站的整体基调，并提升其整体视觉美感。然而，使用自定义字体常常会引发网站性能与用户体验方面的问题。

One of the biggest issues with custom fonts is the [Cumulative Layout Shift (CLS)](https://web.dev/cls/) that occurs when a font takes too long to load. These Flashes of Unstyled Content (FOUC) can alter the positioning of elements already on the page and make it difficult to navigate. CLS and FOUC can also impact an application's search engine ranking.

自定义字体带来的最主要问题之一，是当字体加载耗时过长时所引发的[累积布局偏移（CLS）](https://web.dev/cls/)。这类“未样式化内容闪烁（FOUC）”会导致页面中已渲染元素的位置发生变动，从而影响用户导航体验。此外，CLS 和 FOUC 还可能损害应用在搜索引擎中的排名。

On Vercel’s external websites, we used to solve these problems with the workarounds that we’ll talk about below. However, with the release of Next.js 13, we switched to [`next/font`](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font), which cut down on complex code, client-side JavaScript, and layout shift.

在 Vercel 的对外网站上，我们过去曾借助下文将介绍的一些变通方案来解决这些问题。然而，随着 Next.js 13 的发布，我们转而采用 [`next/font`](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font)，大幅减少了复杂代码、客户端 JavaScript 以及布局偏移。

[**Get started**\\
\\
This Next.js 13 template, with \`next/font\` ready to go in \`pages/index.js\`, can give you a jumpstart on conquering layout shift.\\
\\
Deploy](https://vercel.com/templates/next.js/nextjs-boilerplate)

[**立即开始**\\
\\
该 Next.js 13 模板已在 \`pages/index.js\` 中预置 \`next/font\`，助您快速攻克布局偏移难题。\\
\\
部署](https://vercel.com/templates/next.js/nextjs-boilerplate)

## Before `next/font`

## 在使用 `next/font` 之前

At `vercel.com` and `nextjs.org`, we were optimizing our font loading in a few key ways:

在 `vercel.com` 和 `nextjs.org` 上，我们曾通过以下几种关键方式优化字体加载：

1. We hosted our font ourselves, instead of using a third-party URL like Google Fonts.

1. 我们自行托管字体文件，而非使用 Google Fonts 等第三方 URL。

2. We preloaded the font using `<meta>` tags.

2. 我们通过 `<meta>` 标签对字体进行预加载。

3. 我们仅预加载了拉丁字符子集。这对英文显示已足够，而其他字符子集仍可在需要时按需加载。

4. 我们指定了外观尽可能接近目标字体的备用字体（fallback fonts）。这些字体虽在技术上并非严格意义上的“Web 安全字体”（web safe），但在许多用户的设备上仍然可用。

5. 我们将 CSS 的 `font-display` 属性设为 `optional`，以确保即使字体加载较晚，页面文本也不会闪烁，从而避免布局偏移（layout shift）。

6. 我们使用客户端 JavaScript 检测用户是否曾访问过 Vercel 网站；若为首次访问，则为其提供备用字体，以实现零布局偏移（zero layout-shift）的体验。

你可能已经猜到，这些优化在代码库中需要一些复杂的变通方案（workarounds）。

以下是旧版 `next/head` 组件返回语句中的相关代码（该组件在每个页面上均被渲染）：

components/head.tsx

```jsx
1<script

dangerouslySetInnerHTML={{

3    __html: `

4    if (!window.newVisit && document.cookie && document.cookie.indexOf('beenHere=1') !== -1) {

4    如果 `window.newVisit` 为假，且 `document.cookie` 存在，且其中包含 `'beenHere=1'`：

5      document.documentElement.classList.add('inter')

5      则向 `document.documentElement` 的类列表中添加 `'inter'` 类。

6    } else {

6    } else {

7      window.newVisit=true

7      否则，将 `window.newVisit` 设为 `true`。

8    }

8    }

9    setTimeout(function() {

9    setTimeout(function() {

10      document.cookie='beenHere=1;samesite=lax;expires='+

10      document.cookie = 'beenHere=1;samesite=lax;expires=' +

11      new Date(Date.now()+31*3600*24*1000).toGMTString()

11      new Date(Date.now() + 31 * 3600 * 24 * 1000).toGMTString();

12    })`,

12    })`,

13  }}

14/>

14/>

15<link

15<link

16  as="font"

16  as="font"

17  crossOrigin="anonymous"

17  crossOrigin="anonymous"

18  href="https://assets.vercel.com/raw/upload/v1660068731/fonts/4/Inter.var.latin.woff2"

18  href="https://assets.vercel.com/raw/upload/v1660068731/fonts/4/Inter.var.latin.woff2"

19  rel="preload"

19  rel="preload"

20  type="font/woff2"

20  type="font/woff2"

21/>

21/>

```

Custom font solution used by Vercel before `next/font`.

```

Vercel 在推出 `next/font` 之前所使用的自定义字体解决方案。

And here’s code from our old CSS:

而这是我们旧版 CSS 中的代码：

```css
1:root {

1:root

2  --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

2  --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

3    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

3    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

4    sans-serif;

4    sans-serif;

5}



5



7:root.inter {

7:root.inter

8  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

8  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

9    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

9    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

10    sans-serif;

10    sans-serif;
```

11}
```

Vercel 在引入 \`next/font\` 之前所使用的自定义字体 CSS。

除了上述调整外，我们还通过手动子集化（subsetting）对字体进行了优化，例如以下示例：

```css
1@font-face {

2  font-family: 'Inter';

3  font-style: normal;

4  font-weight: 100 900;

5  font-display: optional;

6  src: url('https://assets.vercel.com/raw/upload/v1660068731/fonts/4/Inter.var.latin.woff2')

7    format('woff2');

8  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA,  
8  unicode-range：U+0000–U+00FF、U+0131、U+0152–U+0153、U+02BB–U+02BC、U+02C6、U+02DA，

9    U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212,  
9    U+02DC、U+2000–U+206F、U+2074、U+20AC、U+2122、U+2191、U+2193、U+2212，

10    U+2215, U+FEFF, U+FFFD;  
10    U+2215、U+FEFF、U+FFFD；

11}  

11}

13/* Plus eight more @font-face definitions for other languages and characters. */  
13/* 此外还需为其他语言和字符额外定义八个 @font-face 规则。 */

```

@font-face rules to manually subset the font before we used \`next/font\`.  

在使用 \`next/font\` 之前，我们需手动对字体进行子集化处理的 @font-face 规则。

As you can imagine, we’d need to adjust and lengthen the code for any new fonts we wished to add.  

可想而知，每当我们希望添加新字体时，都必须相应调整并扩展这段代码。

## Enter `next/font`  

## 引入 `next/font`

With far less code, `next/font` reliably incorporates all the optimizations mentioned above for either third-party or first-party fonts. Automatic self-hosting—which means total elimination of external network requests—contributes to the bulk of the magic. Plus, your self-hosted font file is further optimized to preload only the characters your website needs.  

仅需极少的代码，`next/font` 即可稳定地为第三方或自有字体集成上述所有优化。其中最关键的“自动自托管”机制——即彻底消除对外部网络请求的依赖——构成了其核心魔力所在。此外，您自托管的字体文件还会被进一步优化，仅预加载您的网站实际用到的字符。

Where `next/font` takes it a step further is preventing layout shift entirely. It calculates the `size-adjust` property based on the actual font files (`.ttf` or `.woff2`, for example), making the calculation available on the server before the font is even requested. This allows `next/font` to generate a fallback font that matches the spacing of your custom font, ensuring a seamless swap.

`next/font` 更进一步之处在于彻底防止布局偏移（layout shift）。它基于实际字体文件（例如 `.ttf` 或 `.woff2`）计算 `size-adjust` 属性，并在字体资源甚至被请求之前，就在服务端完成该计算。这使得 `next/font` 能够生成一个与自定义字体字间距完全匹配的备用字体（fallback font），从而确保字体切换过程平滑无感。

To fully leverage the fallback font, we set `display: "swap"` when configuring the font object. This just allows the browser to swap the custom font in, even if it's slow to load.

为了充分利用备用字体，我们在配置字体对象时设置 `display: "swap"`。这仅允许浏览器在自定义字体加载较慢时，仍能将其替换进页面中。

In total, here’s what the new code looks like:

总体而言，新代码如下所示：

lib/font.ts

```tsx
import { Inter } from 'next/font/google';



const interFont = Inter({

4  display: 'swap',

5  subsets: ['latin'],

6  variable: '--font-sans',

7});



export const interFontClass = interFont.variable;
```

The current code for Vercel's custom fonts is drastically reduced with \`next/font\`.

使用 \`next/font\` 后，Vercel 自定义字体的当前代码量大幅减少。

We can then easily add new fonts and use this one throughout our site as needed. You’ll notice we used the `variable` property, which allows us to reference the variable without changing our existing CSS. You can also use this for easy integration with TailwindCSS in your own project.

随后，我们便能轻松添加新字体，并根据需要在整个网站中使用该字体。你将注意到我们使用了 `variable` 属性，这使得我们无需修改现有 CSS 即可引用该变量。你也可以在自己的项目中利用此特性，便捷地与 TailwindCSS 集成。

Check out the video below for a full demonstration of `next/font`:

请观看下方视频，全面了解 `next/font` 的使用方法：

Learn how to use \`next/font\` in Next.js 13, for both local and remote fonts from Google.

学习如何在 Next.js 13 中使用 \`next/font\`，支持本地字体及来自 Google 的远程字体。

`next/font` is now included in Next.js 13, so no additional installation is required. This also means when importing, you can drop the `@` in front of `next/font`.

`next/font` 现已内置于 Next.js 13 中，因此无需额外安装。这也意味着在导入时，你可以省略 `next/font` 前面的 `@` 符号。

Additionally, when using the new [Next.js 13 App Router](https://vercel.com/blog/nextjs-app-router-data-fetching), you can place font imports in specific layouts, only preloading fonts you need for specific pages the user navigates to. Do take care to import your font in the highest common layout for all pages that need it, to avoid loading in multiple instances of the font.

此外，在使用新的 [Next.js 13 App Router](https://vercel.com/blog/nextjs-app-router-data-fetching) 时，你可将字体导入语句放置在特定的布局组件中，从而仅预加载用户访问特定页面所需的字体。请注意：应将字体导入到所有需要该字体的页面所共用的**最高层级布局**中，以避免同一字体被重复加载多次。

## Bring your own fonts

## 自带字体

Web typography has significant impact on a website's overall design and user experience. Custom fonts bring out your brand’s uniqueness, and with `next/font`, you don’t have to worry about all the baggage that used to come with them.

网页排版对网站的整体设计和用户体验具有显著影响。自定义字体能够凸显您品牌的独特性；而借助 `next/font`，您无需再为以往伴随自定义字体而来的各种负担（如性能开销、加载延迟等）而担忧。

If you're ready to enhance your own applications’s typographical performance, [get started with the documentation](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font) on `next/font`.

如果您已准备好提升自己应用的排版性能，请立即查阅 [`next/font`](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font) 的官方文档开始实践。

[**Want to talk to an expert?**\\
\\
Brainstorm with our team about your unique use case of Next.js.\\
\\
Send us a message](https://vercel.com/contact/sales)

[**想与专家交流？**\\
\\
与我们的团队一起，围绕您在 Next.js 中的独特使用场景展开头脑风暴。\\
\\
立即发送消息](https://vercel.com/contact/sales)

Vercel.com landing page

Vercel.com 着陆页

### Docs for \`next/font\`

### \`next/font\` 文档