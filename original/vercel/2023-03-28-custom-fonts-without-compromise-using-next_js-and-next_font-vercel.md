---
title: "Custom fonts without compromise using  Next.js and `next/font` - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/nextjs-next-font"
date: "2023-03-28"
scraped_at: "2026-03-02T09:54:01.376626438+00:00"
language: "en"
translated: false
description: "`next/font` automatically self-hosts your custom fonts, preventing layout shift and significantly reducing needed code."
---




Mar 28, 2023

Highly optimized, self-hosted fonts with just a few lines of code.

As web developers, we know the importance of typography in design. Custom fonts can set the tone for a website and enhance its overall aesthetic. However, using custom fonts can often create issues with website performance and user experience.

One of the biggest issues with custom fonts is the [Cumulative Layout Shift (CLS)](https://web.dev/cls/) that occurs when a font takes too long to load. These Flashes of Unstyled Content (FOUC) can alter the positioning of elements already on the page and make it difficult to navigate. CLS and FOUC can also impact an application's search engine ranking.

On Vercel’s external websites, we used to solve these problems with the workarounds that we’ll talk about below. However, with the release of Next.js 13, we switched to [`next/font`](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font), which cut down on complex code, client-side JavaScript, and layout shift.

[**Get started**\\
\\
This Next.js 13 template, with \`next/font\` ready to go in \`pages/index.js\`, can give you a jumpstart on conquering layout shift.\\
\\
Deploy](https://vercel.com/templates/next.js/nextjs-boilerplate)

## Before `next/font`

At `vercel.com` and `nextjs.org`, we were optimizing our font loading in a few key ways:

1. We hosted our font ourselves, instead of using a third-party URL like Google Fonts.

2. We preloaded the font using `<meta>` tags.

3. We only preloaded the Latin subset of characters. This is enough for English, and other subsets could still load in as needed.

4. We specified fallback fonts that looked as similar as possible to our desired font. This included fonts that weren’t technically “web safe,” but were still available on many users’ devices.

5. We set the `font-display` CSS property to `optional` so that the text on the page wouldn’t flicker and cause layout shift if it loaded late.

6. We used client-side JavaScript to detect if a user has visited Vercel's site before, and if not, we served them the fallback font for a zero layout-shift experience.


As you might guess, these optimizations took some complex workarounds in the codebase.

Here’s the relevant code from the return statement of our old `next/head`, which was rendered on every page:

components/head.tsx

```jsx
1<script

dangerouslySetInnerHTML={{

3    __html: `

4    if (!window.newVisit && document.cookie && document.cookie.indexOf('beenHere=1') !== -1) {

5      document.documentElement.classList.add('inter')

6    } else {

7      window.newVisit=true

8    }

9    setTimeout(function() {

10      document.cookie='beenHere=1;samesite=lax;expires='+

11      new Date(Date.now()+31*3600*24*1000).toGMTString()

12    })`,

13  }}

14/>

15<link

16  as="font"

17  crossOrigin="anonymous"

18  href="https://assets.vercel.com/raw/upload/v1660068731/fonts/4/Inter.var.latin.woff2"

19  rel="preload"

20  type="font/woff2"

21/>
```

Custom font solution used by Vercel before \`next/font\`.

And here’s code from our old CSS:

```css
1:root {

2  --font-sans: -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

3    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

4    sans-serif;

5}



7:root.inter {

8  --font-sans: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', 'Roboto',

9    'Oxygen', 'Ubuntu', 'Cantarell', 'Fira Sans', 'Droid Sans', 'Helvetica Neue',

10    sans-serif;

11}
```

Custom font CSS used by Vercel before \`next/font\`.

In addition to these adjustments, we also optimized the font through manual subsetting, such as the example below:

```css
1@font-face {

2  font-family: 'Inter';

3  font-style: normal;

4  font-weight: 100 900;

5  font-display: optional;

6  src: url('https://assets.vercel.com/raw/upload/v1660068731/fonts/4/Inter.var.latin.woff2')

7    format('woff2');

8  unicode-range: U+0000-00FF, U+0131, U+0152-0153, U+02BB-02BC, U+02C6, U+02DA,

9    U+02DC, U+2000-206F, U+2074, U+20AC, U+2122, U+2191, U+2193, U+2212,

10    U+2215, U+FEFF, U+FFFD;

11}



13/* Plus eight more @font-face definitions for other languages and characters. */
```

@font-face rules to manually subset the font before we used \`next/font\`.

As you can imagine, we’d need to adjust and lengthen the code for any new fonts we wished to add.

## Enter `next/font`

With far less code, `next/font` reliably incorporates all the optimizations mentioned above for either third-party or first-party fonts. Automatic self-hosting—which means total elimination of external network requests—contributes to the bulk of the magic. Plus, your self-hosted font file is further optimized to preload only the characters your website needs.

Where `next/font` takes it a step further is preventing layout shift entirely. It calculates the `size-adjust` property based on the actual font files (`.ttf` or `.woff2`, for example), making the calculation available on the server before the font is even requested. This allows `next/font` to generate a fallback font that matches the spacing of your custom font, ensuring a seamless swap.

To fully leverage the fallback font, we set `display: "swap"` when configuring the font object. This just allows the browser to swap the custom font in, even if it's slow to load.

In total, here’s what the new code looks like:

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

We can then easily add new fonts and use this one throughout our site as needed. You’ll notice we used the `variable` property, which allows us to reference the variable without changing our existing CSS. You can also use this for easy integration with TailwindCSS in your own project.

Check out the video below for a full demonstration of `next/font`:

Learn how to use \`next/font\` in Next.js 13, for both local and remote fonts from Google.

`next/font` is now included in Next.js 13, so no additional installation is required. This also means when importing, you can drop the `@` in front of `next/font`.

Additionally, when using the new [Next.js 13 App Router](https://vercel.com/blog/nextjs-app-router-data-fetching), you can place font imports in specific layouts, only preloading fonts you need for specific pages the user navigates to. Do take care to import your font in the highest common layout for all pages that need it, to avoid loading in multiple instances of the font.

## Bring your own fonts

Web typography has significant impact on a website's overall design and user experience. Custom fonts bring out your brand’s uniqueness, and with `next/font`, you don’t have to worry about all the baggage that used to come with them.

If you're ready to enhance your own applications’s typographical performance, [get started with the documentation](https://nextjs.org/docs/basic-features/font-optimization?utm_source=vercel_site&utm_medium=blog&utm_campaign=custom_font_next_font) on `next/font`.

[**Want to talk to an expert?**\\
\\
Brainstorm with our team about your unique use case of Next.js.\\
\\
Send us a message](https://vercel.com/contact/sales)

Vercel.com landing page


Vercel.com landing page

### Docs for \`next/font\`