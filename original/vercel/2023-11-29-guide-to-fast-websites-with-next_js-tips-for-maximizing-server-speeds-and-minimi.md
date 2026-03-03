---
title: "Guide to fast websites with Next.js: Tips for maximizing server speeds and minimizing client burden - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/guide-to-fast-websites-with-next-js-tips-for-maximizing-server-speeds"
date: "2023-11-29"
scraped_at: "2026-03-02T09:49:19.276993914+00:00"
language: "en"
translated: false
description: "A collection of tips to make faster Next.js websites by maximizing work on the server and minimizing the burden on the client."
---




Nov 29, 2023

Tinloof Co-founder Seif Ghezala gives insights into how his team measures website speed with best practices to make faster websites.

[Tinloof](https://tinloof.com/) is an agency obsessed with delivering fast websites such as jewelry brand [Jennifer Fisher](https://jenniferfisher.com/), which went from a Shopify theme to a modern [Next.js](https://nextjs.org/) website that instantly loads with 80% less JavaScript.

When evaluating the speed of a website, they look at key metrics in a typical user journey:

1. **Server response time:** How long it takes for the user to get any feedback once landed on the page.

2. **Page render time:** How long it takes for a page to become fully visible and interactive.

3. **User interaction time:** How long it takes the user to make key interactions on the page such as navigating between pages or adding an item to the cart.


This article covers tips to measure and make each part of the user journey as fast as it gets.

## **The basics of site speed: Measuring data correctly**

The key to making your site fast and keeping it fast—for any user on any device—is data.

Speed is more than just a way to gauge user experience, it's crucial for getting the top spot on any search platform and winning organic page views.

To ensure they're measuring the right data correctly, tools like [Google PageSpeed Insights](https://pagespeed.web.dev/) and [Vercel Speed Insights](https://vercel.com/docs/speed-insights) are able to provide objective metrics. These tools can be used to diagnose page performance issues, providing insights into aspects like loading times, interactivity, and visual stability.

It's also equally important to test the user journey under various network conditions.

Combining objective tools with a hands-on approach provides a comprehensive view of a website experience, ensuring it’s optimised for all users.

[**Vercel Speed Insights**\\
\\
Learn how to get a detailed view of your website's performance metrics to help facilitate informed decisions on optimization. \\
\\
Get Started](https://vercel.com/docs/speed-insights)

## How to speed up server response: Make use of Next.js’ rendering toolbox

Once key performance metrics are evaluated, the team is able to pinpoint where and how to make improvements in things like server response.

### When possible: Pre-render the entire page

Pre-rendering the page at build-time ensures it is served from a CDN instead of your origin server, resulting in the fastest server response possible. This is done automatically by Next.js if you don’t use the `edge` runtime and the page doesn’t rely on cookies, headers, or search parameters.

### Else: Partial Prerender

Pre-rendering an entire page might not be always possible.

With [Partial Prerendering](https://vercel.com/blog/partial-prerendering-with-next-js-creating-a-new-default-rendering-model) (PPR) in Next.js, it's possible to pre-render a shell of the page that is served from a CDN while streaming the dynamic bits at the same time.

Partial Prerendering is currently [an experimental feature](https://twitter.com/leeerob/status/1723039087391543654) that allows you to render a route with a static loading shell, while keeping some parts dynamic. In other words, you can isolate the dynamic parts of a page instead of a whole route.

### Final resort: Render a loading shell while waiting for the final response

When a page is rendered at request time, it’s better to immediately show the user a UI hint that indicates a page is loading, rather than unresponsive links.

It’s best to make the loading UI resemble as much as possible the final one.

In Next.js, there are two places where you can render the loading UI:

- In a [loading.tsx](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming) file inside the page route folder.


- Inside the fallback prop of the [Suspense boundary](https://nextjs.org/docs/app/building-your-application/routing/loading-ui-and-streaming#streaming-with-suspense) that wraps async component making requests inside the page.


### Cache fetch requests for fast server responses when using loading spinners

Loading shells are not an excuse for slow server responses. Most server responses can be cached instead of making the user wait for them on every page visit.

Although this is the default behaviour of `fetch` requests in Next.js, you can still control the freshness of this data:

- By revalidating the server response every x number seconds.


app/page.tsx

```tsx
export default function Home() {

2  // The CMS data is guaranteed to be fresh every 2 minutes

3  const cmsData = await fetch(`https://...`, { next: { revalidate: 120 } });



5  return <h1>{cmsData.title}</h1>

6}
```

- Or by revalidating the server response when a certain event happens. Here’s an example where a CMS response is revalidated whenever a new CMS page gets published.


app/page.tsx

```jsx
export default function Home() {

2 // The CMS data is cached until the tag is revalidated

3  const cmsData = await fetch(`https://...`, { next: { tags: ['landing-page']);



5  return <h1>{cmsData.title}</h1>

6}
```

app/api/revalidate/route.ts

```tsx
import { revalidateTag } from 'next/cache';

import { NextRequest, NextResponse } from 'next/server';



export async function POST(req: NextRequest): Promise<NextResponse> {

5  const secret = req.nextUrl.searchParams.get('secret');

6  const tag = req.nextUrl.searchParams.get('landing-page');



8  if(!tag || !isValid(secret)) {

9		return NextResponse.json({ status: 400});

10  }



12  return revalidate(tag);

13}
```

The [Next.js guide on caching and revalidation](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating) and the [App Router explainer video](https://www.youtube.com/watch?v=gSSsZReIFRk&t=577s&ab_channel=Vercel) are perfect to help understand these concepts.

## How to speed up the page render: Minimize client burden

**Short answer:** Make the browser do the least amount of work to render the page.

Once the browser receives a response from the server, it still has to paint the entire page and make it ready for user interactions (e.g. button clicks).

While parsing the HTML and rendering, the browser is also downloading resources such as CSS, JavaScript, font, or image files.

The following tips help make page render fast by making the browser do as little work as possible.

### Reduce the JavaScript bundle size and minimize the impact of hydration

The JavaScript shipped with React websites usually consists of React, Next.js, the application code including the JSX of every single React component, and third-party dependencies.

Once the page HTML is rendered and the JavaScript is downloaded, React goes through a process called “ [hydration](https://chat.openai.com/share/4bf8f74b-1681-40c6-aae3-dc1ae00013db)” where it attaches event listeners and state to the components of the page.

Just by using [React Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components) you already get a speed bump because:

1. Their JavaScript (including application code, JSX, and third-party dependencies) is not shipped to the browser.

2. React skips their hydration.


When a component requires interactivity (e.g. state, event listeners), a `use client` directive can be used to convert it to a client component which in addition of being rendered in the server, also has its JavaScript shipped to the browser and is hydrated by React.

## Reduce the impact of client components on page speed

### Only use client components when necessary

URLs can be used to store a component state without having to make it a client component that relies on React’s state.

It requires less code to manage the state, turns state buttons to links that work even without JavaScript, and makes it possible to persist the state on page refresh or when sharing the URL.

### Place client components in the leaves of the page tree

To minimize the JavaScript footprint of imported child components, it’s a good practice to place client components the furthest possible at the bottom of the components tree.

### Be mindful of third-party dependencies’ bundle sizes

Any client component dependency is more JavaScript for the browser to download, parse, and execute.

Tools such as [pkg-size](https://pkg-size.dev/) can be used to determine the size impact of NPM packages based on what’s imported from them and help decide between alternatives.

![](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_001.jpg)

### Lazy-load client components when possible

Even when a client component is necessarily heavy, it’s still possible to only download its JavaScript once it’s rendered.

For example, [the stockists page on Jennifer Fisher](https://jenniferfisher.com/pages/stockists) uses `mapbox-gl`, an extremely heavy package, to display interactive maps.

Since `mapbox-gl` is only used to display maps, its wrapper client component is lazy-loaded so the package bundle is only downloaded when the component is rendered.

You can lazy-load a client component either via `next/dynamic` or a combination of `React.lazy` and `Suspense` , more details can be found on [Next.js guide on the topic](https://nextjs.org/docs/app/building-your-application/optimizing/lazy-loading).

### Efficiently load third-party scripts

Some third-party dependencies like Google Tag Manager are injected via script tags instead of imports in client components.

[@next/third-parties](https://nextjs.org/docs/app/building-your-application/optimizing/third-party-libraries) can be used to reduce their impact on page render speed and if dependency is not supported, [next/script](https://nextjs.org/docs/app/api-reference/components/script) is also a great option.

## How to load fonts more efficiently

Some web fonts are unnecessarily heavy because they include characters not even needed by the website.

In the case of Jennifer Fisher, Tinloof was able to trim out more than 50% of font files using tools such as [transfonter](https://transfonter.org/).

[next/font](https://nextjs.org/docs/app/building-your-application/optimizing/fonts) makes it possible to load local and Google Fonts while providing the following optimizations:

1. Only load fonts on pages where they are used.

2. [Preload](https://web.dev/articles/codelab-preload-web-fonts) fonts to make them available early on when rendering.

3. Use display strategies such as [swap](https://developer.mozilla.org/en-US/docs/Web/CSS/@font-face/font-display) to avoid blocking text rendering by using a fallback font.


## How to load images more efficiently

**Short answer:** use [next/image](https://nextjs.org/docs/app/building-your-application/optimizing/images) when you can.

The `next/image` component provides so many optimizations for local or remote images.

A detailed guide is available on [Next.js docs](https://nextjs.org/docs/app/building-your-application/optimizing/images) so I’ll only highlight some of them:

1. Images are automatically served in modern efficient formats such as AVIF or WebP that preserve quality and dramatically reduce the download size.

2. Images are only loaded when visible in the viewport and a `lazy` boolean prop is available

[to do the opposite for critical images](https://web.dev/articles/lcp-lazy-loading).

3. A `preload` prop is available to make the browser load critical images ASAP.

4. Images are automatically served in different sizes based on the viewport and props such as `sizes` or `loader` are available to customise the behaviour.

5. Local images can automatically show a placeholder while loading and you can provide a

`blurDataURL` to achieve the same with remote images.


The `next/image` component is just a very handy utility and is not required to achieve the benefits above:

1. Images can still be served in modern formats by using CDNs that can convert them on the fly.

2. Lazy-loading images is a native browser attribute that can be used by default.

3. Images can be preloaded using a preload link

`<link rel="preload" as="image" href="..." />` in the document’s `head` or using `ReactDOM.preload.`

4. When loading images from a different domain, it’s a good practice to use

[preconnect links](https://web.dev/articles/preconnect-and-dns-prefetch) to inform the browser to establish a connection with the image provider domain early-on.


## How to load videos more efficiently

Solutions such as [Mux](https://www.mux.com/blog/multi-cdn-support-in-mux-video-for-improved-performance-and-reliability), [Cloudinary](https://cloudinary.com/), or CDNs such as [Fastly](https://www.fastly.com/products/streaming-media/video-on-demand) can be used to help optimise video delivery by serving videos as close as possible to users.

A poster image is a must-have for any video and you can either manually set it or easily extract the first frame of the video to be the poster image when using any video CDN.

The best part is that you can use the same image optimizations tips discussed earlier to render the poster image efficiently.

Here’s an example Mux video component that utilises these optimizations and it’s only rendered on the server:

```tsx
import { preload } from "react-dom";

import { unstable_getImgProps as getImgProps } from "next/image";



type Props = {

5  playbackId: string;

6  loading: "lazy" | "eager";

7  resolution: "SD" | "HD";

8};



export default function MuxVideo({ playBackId, loading, loading }: Props) {

11  const mp4Url = `https://stream.mux.com/${playbackId}/${

12    resolution === "SD" ? "medium" : "high"

13  }.mp4`;



15  const webmUrl = `https://stream.mux.com/${playbackId}/${

16    resolution === "SD" ? "medium" : "high"

17  }.webm`;



19  // Use `getImgProps` to convert the video poster image to WebP

20  const {

21    props: { src: poster },

22  } = getImgProps({

23    src: `https://image.mux.com/${playbackId}/thumbnail.webp?fit_mode=smartcrop&time=0`,

24    alt: "",

25    fill: true,

26  });



28  // Preload the poster when applicable

29  if (loading === "eager") {

30    preload(poster, {

31      as: "image",

32      fetchPriority: "high",

33    });

34  }



36  return (

37    <video

38      autoPlay

39      playsInline

40      loop

41      controls={false}

42      muted

43      preload="none"

44    >

45      <source src={mp4Url} type="video/mp4" />

46      <source src={webmUrl} type="video/webm" />

47    </video>

48  );

49}
```

For videos that are not required to load immediately, you lazy-load them without causing any layout shift:

```tsx
1'use client';



import Image from 'next/image';

import { useEffect, useState } from 'react';

import useInView from '~/hooks/useInView';

import Video, { VideoProps } from './Video';



export default function LazyLoadedVideo(props: VideoProps) {

9  const { ref, inView } = useInView({ triggerOnce: true });



11  return (

12    <>

13      {!inView ? (

14        <Image

15          ref={ref as React.RefObject<HTMLImageElement>}

16          alt={'Video poster'}

17          src={props.poster ?? ''}

18          className={props.className}

19          style={props.style}

20          loading={'lazy'}

21          layout="fill"

22        />

23      ) : (

24        <Video {...props} />

25      )}

26    </>

27  );

28}
```

## How to reduce the HTML document size

The HTML document is a critical resource the browser has to download and parse.

### **Use virtualization**

Components such as carousels/sliders, tables, and lists are also usual culprits.

You can use libraries such [TanStack Virtual](https://tanstack.com/virtual/v3) to only render items when they are visible in the viewport while avoiding any layout shifts.

## How to speed up user interactions

**Short answer:** Provide feedback to the user as early as possible.

Some user interactions such as URL state navigations when filtering or adding an item to the cart rely on server responses, which are not always immediate, causing slow interactions or leaving the user puzzled on whether something went wrong.

Optimistic UI techniques can be used to make such interactions snappy and provide immediate feedback to users.

The idea is to use JavaScript to show the predicted result to the user without waiting the server to return a response.

It can be achieved either through normal React state management or using [React’s useOptimistic hook](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations#optimistic-updates).

## The importance of a performant website

Fast websites are more pleasant to use, more engaging to users, and it’s no surprise they directly impact success metrics such as conversion rate and search engine indexation.

Although the tips above are focused on Next.js, the concepts behind them can be used to make any website faster.

[**Want to talk to an expert?**\\
\\
Brainstorm with our team about your unique use case of Next.js.\\
\\
Send us a message](https://vercel.com/contact/sales)

[![Will Thomson](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_002.jpg)](https://x.com/willthomson__/status/1704137045159911477)

[Will Thomson](https://x.com/willthomson__/status/1704137045159911477)


· [Follow](https://x.com/intent/follow?screen_name=willthomson__)

[View on Twitter](https://x.com/willthomson__/status/1704137045159911477)

Caching turns god-mode on for your website.

Look at the speed of [@Tinloof](https://x.com/Tinloof)'s website.

You type, hit enter, site appears.

No loading spinners. No waiting.

Optimisation is why I choose code over no-code.

P.S They have epic developer resources on their site.

[Watch on X](https://x.com/willthomson__/status/1704137045159911477)

[10:15 AM · Sep 19, 2023](https://x.com/willthomson__/status/1704137045159911477) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[25](https://x.com/intent/like?tweet_id=1704137045159911477) [Reply](https://x.com/intent/tweet?in_reply_to=1704137045159911477)


[Read 4 replies](https://x.com/willthomson__/status/1704137045159911477)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1696549318495178887)

[Alex Sidorenko](https://x.com/asidorenko_/status/1696549318495178887)


· [Follow](https://x.com/intent/follow?screen_name=asidorenko_)

[View on Twitter](https://x.com/asidorenko_/status/1696549318495178887)

"I have one server component that fetches a lot of data and makes the entire page slow to load in Next.js 13"

Wrap it with Suspense

[Watch on X](https://x.com/asidorenko_/status/1696549318495178887)

[11:44 AM · Aug 29, 2023](https://x.com/asidorenko_/status/1696549318495178887) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[934](https://x.com/intent/like?tweet_id=1696549318495178887) [Reply](https://x.com/intent/tweet?in_reply_to=1696549318495178887)


[Read 18 replies](https://x.com/asidorenko_/status/1696549318495178887)

[![Guillermo Rauch](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_004.jpg)](https://x.com/rauchg/status/1696944713708757065)

[Guillermo Rauch](https://x.com/rauchg/status/1696944713708757065)


· [Follow](https://x.com/intent/follow?screen_name=rauchg)

[View on Twitter](https://x.com/rauchg/status/1696944713708757065)

We moved our Web Analytics dashboard pages to [@nextjs](https://x.com/nextjs) App Router and shaved off 800ms of LCP.

What a time to be alive.

[![Web Analytics running on App Router is much faster](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_005.jpg)](https://x.com/rauchg/status/1696944713708757065)

[1:55 PM · Aug 30, 2023](https://x.com/rauchg/status/1696944713708757065) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[589](https://x.com/intent/like?tweet_id=1696944713708757065) [Reply](https://x.com/intent/tweet?in_reply_to=1696944713708757065)


[Read 22 replies](https://x.com/rauchg/status/1696944713708757065)

[![Lee Robinson](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_006.jpg)](https://x.com/leerob/status/1688639192723521536)

[Lee Robinson](https://x.com/leerob/status/1688639192723521536)


· [Follow](https://x.com/intent/follow?screen_name=leerob)

[View on Twitter](https://x.com/leerob/status/1688639192723521536)

From \`useState\` to URL state.

Rather than using client-side React state, we can instead lift state up to the URL for color, size, and even the selected image.

With the added bonus you can now "deep link" to specific variations. Yay, using the web platform!

[Watch on X](https://x.com/leerob/status/1688639192723521536)

[3:52 PM · Aug 7, 2023](https://x.com/leerob/status/1688639192723521536) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[97](https://x.com/intent/like?tweet_id=1688639192723521536) [Reply](https://x.com/intent/tweet?in_reply_to=1688639192723521536)


[Read 6 replies](https://x.com/leerob/status/1688639192723521536)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1693631458982650286)

[Alex Sidorenko](https://x.com/asidorenko_/status/1693631458982650286)


· [Follow](https://x.com/intent/follow?screen_name=asidorenko_)

[View on Twitter](https://x.com/asidorenko_/status/1693631458982650286)

Move client components to the leaves of the component tree where possible.

[Watch on X](https://x.com/asidorenko_/status/1693631458982650286)

[10:29 AM · Aug 21, 2023](https://x.com/asidorenko_/status/1693631458982650286) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.1K](https://x.com/intent/like?tweet_id=1693631458982650286) [Reply](https://x.com/intent/tweet?in_reply_to=1693631458982650286)


[Read 11 replies](https://x.com/asidorenko_/status/1693631458982650286)

[![Alex Sidorenko](images/guide-to-fast-websites-with-next_js-tips-for-maximizing-server-speeds-and-minimi/img_003.jpg)](https://x.com/asidorenko_/status/1705586291788730412)

[Alex Sidorenko](https://x.com/asidorenko_/status/1705586291788730412)


· [Follow](https://x.com/intent/follow?screen_name=asidorenko_)

[View on Twitter](https://x.com/asidorenko_/status/1705586291788730412)

Optimistic updates in Next.js 13

[Watch on X](https://x.com/asidorenko_/status/1705586291788730412)

[10:13 AM · Sep 23, 2023](https://x.com/asidorenko_/status/1705586291788730412) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.0K](https://x.com/intent/like?tweet_id=1705586291788730412) [Reply](https://x.com/intent/tweet?in_reply_to=1705586291788730412)


[Read 12 replies](https://x.com/asidorenko_/status/1705586291788730412)