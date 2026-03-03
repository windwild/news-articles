---
title: "Introducing OG Image Generation: Fast, dynamic social card images at the Edge - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images"
date: "2022-10-10"
scraped_at: "2026-03-02T10:00:22.163582808+00:00"
language: "en"
translated: false
description: "Announcing Vercel OG Image Generation, a new library for generating dynamic social card images."
---




Oct 10, 2022

Create attention-grabbing, eye-catching OpenGraph imagery with code.

We’re excited to announce **Vercel OG Image Generation** – a new library for generating dynamic social card images. This approach is **5x faster** than existing solutions by using Vercel Edge Functions, WebAssembly, and a brand new core library for converting HTML/CSS into SVGs.

[Try it out in seconds.](https://og-playground.vercel.app/)

## Dynamic with limits

The engagement rate of Tweets that embed a card is [40% higher](https://www.agorapulse.com/social-media-lab/link-tweet-with-an-image-vs-tweet-with-twitter-cards-does-it-really-matter/). While creating and sharing static social images isn’t difficult, handling **dynamic images** that need to be computed and generated instantly has had limits.

We released [og-image.vercel.app](https://og-image.vercel.app/) four years ago to enable developers to dynamically generate [open graph](https://ogp.me/) (OG) images by taking a screenshot of an HTML page inside of a Serverless Function. It’s since been used by thousands of developers to handle their social images. While functional, this approach came with some downsides:

- **Difficult:** This solution required launching Chromium in a Serverless Function and taking a screenshot of the given HTML page with Puppeteer. Setting up these tools was hard to implement and often led to errors.

- **Slow:** Because Chromium needs to be compressed to fit inside a Serverless Function and then decompressed on a cold boot, it’s very slow (~4 seconds on average). This can result in _slow or broken social card images_.

- **Expensive:** Spinning up an entire browser just to take a screenshot was not efficient. This led to large Function sizes, which could be expensive and waste compute.

- **Large:** Chromium has continued to grow in the past four years. Today, it's

[too large to fit in a Serverless Function](https://github.com/vercel/og-image/issues/148).


## Dynamic without limits

We’ve created a brand new open-source library `@vercel/og` to generate dynamic social card images. Vercel OG is:

- **Easy:** No headless browser is needed. Using Vercel OG, you can define your images using HTML and CSS and automatically generate dynamic images from the generated SVGs.

- **Affordable:** Vercel Edge Functions are ~160x cheaper than running Chromium in a Serverless Function. Further, generated images can be cached and stored at the Edge.

- **Fast:** Vercel OG (500KB) is 100x more lightweight than Chromium + Puppeteer (50MB), which allows functions to start _almost instantly_. This helps ensure images are never too slow to generate and are always recognized by tools like the Open Graph Debugger.


Our results from usage on [vercel.com/docs](http://vercel.com/docs) show Vercel OG is **5x faster** in P99 TTFB (4.96s → 0.99s) and **5.3x faster** in P90 (4s → 0.75s) than our previous version. Further, the code is colocated with the rest of the application for easier maintenance and updates.

![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_001.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_002.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_003.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_004.jpg)Vercel OG versus the previous implementation with Serverless Functions.

Vercel OG also supports the following features:

- Support for basic CSS layout, styling, and typography

- Support for use in any framework or frontend application

- Support for downloading font and emoji subsets from Google Fonts and other CDNs


## Dynamic social images at the Edge

Vercel OG converts HTML and CSS into images.

The core engine, [Satori](https://github.com/vercel/satori), can be used in modern browsers, Node.js, and Web Workers. Building on top of the core engine, Vercel OG is able to be used inside Edge environments through WebAssembly to easily create social card images.

By leveraging the React component abstraction, social cards can be co-located with the rest of your frontend codebase. For example, inside a Next.js application:

pages/api/og.jsx

```jsx
import { ImageResponse } from '@vercel/og'



export const config = {

4  runtime: 'experimental-edge',

5}



export default function () {

8  return new ImageResponse(

9    (

10      <div

11        style={{

12          display: 'flex',

13          fontSize: 128,

14          background: 'white',

15          width: '100%',

16          height: '100%',

17        }}

18      >

19        Hello, World!

20      </div>

21    )

22  )

23}
```

A Next.js Edge API Route to create a dynamic social card image.

Vercel OG automatically adds the correct Cache-Control headers to ensure the image is cached at the Edge after it’s been generated.

```json
1'content-type': 'image/png'

2'cache-control': 'public, immutable, no-transform, max-age=31536000'
```

Caching headers from a generated Vercel OG image.

[View more examples](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-examples) or [read the API documentation](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-api).

> “Our social card generation previously used a compressed Chromium release to fit inside the 50mb Serverless Function limit. Due to the size of Chromium, images could take up to 5 seconds to generate, making sharing links feel slow. With Vercel OG, images render almost immediately.Our social card generation previously used a compressed Chromium release to fit inside the 50mb Serverless Function limit. Due to the size of Chromium, images could take up to 5 seconds to generate, making sharing links feel slow. With Vercel OG, images render almost immediately.”
>
> ![](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_005.png)
>
> **Ben Schwarz**

## Tailwind CSS Support

Vercel OG also includes support for using Tailwind CSS with the `tw` prop.

```html
1<div tw="flex h-full items-center bg-white justify-center">

2  <div tw="bg-gray-50 flex">

3    <div tw="flex flex-col md:flex-row w-full py-12 px-4 md:items-center justify-between p-8">

4      <h2 tw="flex flex-col text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 text-left">

5        <span>Ready to dive in?</span>

6        <span tw="text-indigo-600">Start your free trial today.</span>

7      </h2>

8      <div tw="mt-8 flex md:mt-0">

9        <div tw="flex rounded-md shadow">

10          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-3 text-base font-medium text-white">Get started</a>

11        </div>

12        <div tw="ml-3 flex rounded-md shadow">

13          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-white px-5 py-3 text-base font-medium text-indigo-600">Learn more</a>

14        </div>

15      </div>

16    </div>

17  </div>

18</div>
```

An example Vercel OG image, modified from the Tailwind UI marketing section.

![The example OG image using Tailwind CSS with Vercel OG.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_006.jpg)The example OG image using Tailwind CSS with Vercel OG.

View this example in the [Vercel OG Playground](https://og-playground.vercel.app/?share=xVRNb9swDP0rgoahl6h2v4bOSLtDNwwDtsu2oy9yRNtq9WFIch0jyH8fJc-tEwTDbj0kJvlo8j1S1o5urABa0CwjP6yQtQRBKu7x3xrShtD5IssCl2qQRvTyfGN1hr_OGjDBZ5q7JwjSNJmHTZDW-GwTOJud0pRmLeRzaQjxYVRwt9tFm5AWZNOGgpxd5Pn7s9UUHKQI7VFMSN8pPmK0VrCdo9H-LN3UBrGNVb02M8qVbMy3ANpHCImCm6HH3gdZjw8Wgyb2P4QrvnlqnO2NeLDKOsSHVgaY4P2-NPfRiJJIGO5KWjWscXxkN3miVNKELzNiOGEMORItimQ7O5CB1b1SpBvZxSXptuw6othMezaRmsmyCsIAYEjHbl86YI_28lSLANvArraKeF0k-xrtGvWyyipBgkOJuDAW4gKm7CThY55PnoI6LNpgI99xc_8TuBhJsLiRZyDSfFpnKX6UN1FKhfDEyMayD3mO5X4F7gIZbe9I7QCQh-RI1go-nh9VWmft5avzMkkd2G2SGeeETqy6aH448bRDEEwL4lsu7HCQjOmctA5qTH9X0sV7J-f_113UrKwTGJkeDGdqUIHDNIIn4lV3XOtN3PDVNNr4ZU270CBkr6doOmLI7ysE_EpwTCDWGV9qy1DcSa1aYek3F5wE_J_WgzPxHbgzRFsH_9K79F7t2ZqfdEVtly4dWuxouklocZvnKzpdNbS4jo6Aqm9oUXPlYUVB20f5e-ziDYifWPSwTiT9RVcgaBFcD_v9Hw).

## Dynamic ticket images for Next.js Conf

We were able to put Vercel OG Image to the test at [Next.js Conf](https://nextjs.org/conf) by creating dynamic ticket images for every attendee.

For over 100,000 tickets, we’ve seen images generated **on average in 800ms**. That sub-second response includes loading two custom fonts, two external requests to fetch the GitHub avatar and ticket background images, as well as two embedded SVG images.

Since we have the power of CSS, it’s easy to handle wrapping names that could break the layout, as well as supporting special characters outside of the font glyph range.

![With Vercel OG, you can use the power of CSS to wrap layouts, as well as dynamically fetch and subset fonts from CDNs on the fly.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_007.jpg)With Vercel OG, you can use the power of CSS to wrap layouts, as well as dynamically fetch and subset fonts from CDNs on the fly.

## Try Vercel OG Image Generation

Vercel OG Image Generation using Vercel Edge Functions is available today in public beta.

- [View examples](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-examples)

- [Read the API documentation](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-api)

- [Deploy your first social card](https://vercel.com/new/clone?repository-url=https://github.com/vercel/examples/tree/main/edge-functions/vercel-og-nextjs&project-name=vercel-og-nextjs&repository-name=vercel-og-nextjs)