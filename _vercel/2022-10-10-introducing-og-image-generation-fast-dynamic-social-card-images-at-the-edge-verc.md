---
title: "Introducing OG Image Generation: Fast, dynamic social card images at the Edge - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-vercel-og-image-generation-fast-dynamic-social-card-images"
date: "2022-10-10"
scraped_at: "2026-03-02T10:00:22.163582808+00:00"
language: "en-zh"
translated: true
description: "Announcing Vercel OG Image Generation, a new library for generating dynamic social card images."
---
{% raw %}

Oct 10, 2022

2022年10月10日

用代码创建引人注目、视觉冲击力强的 OpenGraph 图像。

我们很高兴地宣布推出 **Vercel OG 图像生成（Vercel OG Image Generation）**——一个用于动态生成社交卡片图像的全新库。该方案借助 Vercel Edge Functions、WebAssembly，以及一个专为将 HTML/CSS 转换为 SVG 而打造的全新核心库，性能比现有方案**快 5 倍**。

[几秒钟内即可试用。](https://og-playground.vercel.app/)

## 动态化，但曾受限

嵌入卡片的推文（Tweet）互动率比普通推文[高出 40%](https://www.agorapulse.com/social-media-lab/link-tweet-with-an-image-vs-tweet-with-twitter-cards-does-it-really-matter/)。虽然创建和分享静态社交图像并不困难，但要实时计算并即时生成**动态图像**，过去一直面临诸多限制。

四年前，我们发布了 [og-image.vercel.app](https://og-image.vercel.app/)，旨在帮助开发者通过在 Serverless Function 中对 HTML 页面截屏，来动态生成 [Open Graph](https://ogp.me/)（OG）图像。此后，数千名开发者已使用该服务处理其社交图像需求。尽管功能可用，但该方案存在以下明显缺陷：

- **实现困难：** 此方案需在 Serverless Function 中启动 Chromium，并借助 Puppeteer 对指定 HTML 页面进行截屏。配置这些工具难度较高，且极易引发错误。

- **速度缓慢：** 由于 Chromium 必须被压缩后才能装入 Serverless Function，又需在冷启动时解压，因此整体响应极慢（平均约 4 秒）。这可能导致社交卡片图像**加载缓慢甚至无法显示**。

- **成本高昂：** 仅为截一张图而启动一整套浏览器，效率极低。这导致函数体积庞大，不仅增加费用，还造成计算资源浪费。

- **Large:** Chromium has continued to grow in the past four years. Today, it's

[too large to fit in a Serverless Function](https://github.com/vercel/og-image/issues/148).

- **体积庞大：** Chromium 在过去四年中持续膨胀。如今，它已

[大到无法容纳于一个 Serverless 函数中](https://github.com/vercel/og-image/issues/148)。

## Dynamic without limits

## 无限制的动态能力

We’ve created a brand new open-source library `@vercel/og` to generate dynamic social card images. Vercel OG is:

我们全新打造了一个开源库 `@vercel/og`，用于生成动态社交卡片图像。Vercel OG 具备以下特性：

- **Easy:** No headless browser is needed. Using Vercel OG, you can define your images using HTML and CSS and automatically generate dynamic images from the generated SVGs.

- **简易：** 无需无头浏览器。借助 Vercel OG，您可直接使用 HTML 和 CSS 定义图像，并自动将生成的 SVG 转换为动态图像。

- **Affordable:** Vercel Edge Functions are ~160x cheaper than running Chromium in a Serverless Function. Further, generated images can be cached and stored at the Edge.

- **经济：** 使用 Vercel Edge Functions 的成本约为在 Serverless 函数中运行 Chromium 的 1/160。此外，生成的图像可被缓存并就近存储于边缘节点（Edge）。

- **Fast:** Vercel OG (500KB) is 100x more lightweight than Chromium + Puppeteer (50MB), which allows functions to start _almost instantly_. This helps ensure images are never too slow to generate and are always recognized by tools like the Open Graph Debugger.

- **迅捷：** Vercel OG（500 KB）比 Chromium + Puppeteer（50 MB）轻量 100 倍，使函数能够 _近乎瞬时启动_。这确保了图像生成从不迟滞，并始终能被 Open Graph Debugger 等工具正确识别。

Our results from usage on [vercel.com/docs](http://vercel.com/docs) show Vercel OG is **5x faster** in P99 TTFB (4.96s → 0.99s) and **5.3x faster** in P90 (4s → 0.75s) than our previous version. Further, the code is colocated with the rest of the application for easier maintenance and updates.

我们在 [vercel.com/docs](http://vercel.com/docs) 上的实际使用数据显示：相较于旧版本，Vercel OG 在 P99 首字节时间（TTFB）上快 **5 倍**（4.96 秒 → 0.99 秒），在 P90 上快 **5.3 倍**（4 秒 → 0.75 秒）。此外，相关代码与应用其余部分共置（colocated），更便于维护与更新。

![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_001.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_002.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_003.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_004.jpg)Vercel OG versus the previous implementation with Serverless Functions.

![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_001.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_002.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_003.jpg)![Vercel OG versus the previous implementation with Serverless Functions.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_004.jpg)Vercel OG 与此前基于 Serverless 函数的实现对比。

Vercel OG also supports the following features:

Vercel OG 还支持以下功能：

- Support for basic CSS layout, styling, and typography  
- 支持基础的 CSS 布局、样式和排版

- Support for use in any framework or frontend application  
- 支持在任意框架或前端应用中使用

- Support for downloading font and emoji subsets from Google Fonts and other CDNs  
- 支持从 Google Fonts 及其他 CDN 下载字体和表情符号子集

## Dynamic social images at the Edge  
## 边缘计算环境下的动态社交图像

Vercel OG converts HTML and CSS into images.  
Vercel OG 将 HTML 和 CSS 转换为图像。

The core engine, [Satori](https://github.com/vercel/satori), can be used in modern browsers, Node.js, and Web Workers. Building on top of the core engine, Vercel OG is able to be used inside Edge environments through WebAssembly to easily create social card images.  
其核心引擎为 [Satori](https://github.com/vercel/satori)，可在现代浏览器、Node.js 和 Web Worker 中运行。基于该核心引擎，Vercel OG 进一步通过 WebAssembly 实现了在边缘（Edge）环境中运行的能力，从而轻松生成社交卡片图像。

By leveraging the React component abstraction, social cards can be co-located with the rest of your frontend codebase. For example, inside a Next.js application:  
借助 React 组件的抽象能力，社交卡片可与前端代码库的其余部分共存于同一代码结构中。例如，在一个 Next.js 应用中：

pages/api/og.jsx  

```jsx
import { ImageResponse } from '@vercel/og'
```

```javascript
export const config = {

4  runtime: 'experimental-edge',

5}
```

```javascript
export const config = {

4  runtime: 'experimental-edge',

5}
```

```javascript
export default function () {

8  return new ImageResponse(

9    (

10      <div

11        style={{

12          display: 'flex',
```

```javascript
export default function () {

8  return new ImageResponse(

9    (

10      <div

11        style={{

12          display: 'flex',
```

13          fontSize: 128,

13          字体大小：128，

14          background: 'white',

14          背景颜色：'white'，

15          width: '100%',

15          宽度：'100%'，

16          height: '100%',

16          高度：'100%'，

17        }}

17        }}

18      >

18      >

19        Hello, World!

19        你好，世界！

20      </div>

20      </div>

21    )

21    )

22  )

22  )

23}
```

一个用于生成动态社交卡片图片的 Next.js Edge API 路由。

Vercel OG 会自动添加正确的 `Cache-Control` 响应头，确保图片在边缘节点（Edge）生成后被缓存。

```json
1'content-type': 'image/png'

2'cache-control': 'public, immutable, no-transform, max-age=31536000'
```

一张由 Vercel OG 生成的图片所返回的缓存响应头。

[查看更多示例](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-examples) 或 [阅读 API 文档](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-api)。

> “我们此前的社交卡片生成方案依赖于一个压缩版的 Chromium，以满足 Serverless 函数 50MB 的体积限制。但由于 Chromium 本身体积庞大，图片生成耗时最长可达 5 秒，导致分享链接时体验明显迟滞。而借助 Vercel OG，图片几乎可以瞬时渲染。”  
>  
> ![](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_005.png)  
>  
> **Ben Schwarz**

## Tailwind CSS 支持

Vercel OG 还支持通过 `tw` 属性直接使用 Tailwind CSS。

```html
1<div tw="flex h-full items-center bg-white justify-center">

1<div tw="flex h-full items-center bg-white justify-center">

2  <div tw="bg-gray-50 flex">

2  <div tw="bg-gray-50 flex">

3    <div tw="flex flex-col md:flex-row w-full py-12 px-4 md:items-center justify-between p-8">

3    <div tw="flex flex-col md:flex-row w-full py-12 px-4 md:items-center justify-between p-8">

4      <h2 tw="flex flex-col text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 text-left">

4      <h2 tw="flex flex-col text-3xl sm:text-4xl font-bold tracking-tight text-gray-900 text-left">

5        <span>Ready to dive in?</span>

5        <span>准备开始了吗？</span>

6        <span tw="text-indigo-600">Start your free trial today.</span>

6        <span tw="text-indigo-600">今天即刻开启免费试用。</span>

7      </h2>

7      </h2>

8      <div tw="mt-8 flex md:mt-0">

8      <div tw="mt-8 flex md:mt-0">

9        <div tw="flex rounded-md shadow">

9        <div tw="flex rounded-md shadow">

10          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-3 text-base font-medium text-white">Get started</a>

10          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-indigo-600 px-5 py-3 text-base font-medium text-white">立即开始</a>
```

11        </div>

11        </div>

12        <div tw="ml-3 flex rounded-md shadow">

12        <div tw="ml-3 flex rounded-md shadow">

13          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-white px-5 py-3 text-base font-medium text-indigo-600">Learn more</a>

13          <a href="#" tw="flex items-center justify-center rounded-md border border-transparent bg-white px-5 py-3 text-base font-medium text-indigo-600">了解更多</a>

14        </div>

14        </div>

15      </div>

15      </div>

16    </div>

16    </div>

17  </div>

17  </div>

18</div>

18</div>
```

An example Vercel OG image, modified from the Tailwind UI marketing section.

一个来自 Tailwind UI 营销版块的 Vercel OG 图像示例。

![The example OG image using Tailwind CSS with Vercel OG.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_006.jpg)  
![使用 Tailwind CSS 与 Vercel OG 生成的示例 OG 图像。](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_006.jpg)  
The example OG image using Tailwind CSS with Vercel OG.  
该示例 OG 图像使用了 Tailwind CSS 与 Vercel OG。

View this example in the [Vercel OG Playground](https://og-playground.vercel.app/?share=xVRNb9swDP0rgoahl6h2v4bOSLtDNwwDtsu2oy9yRNtq9WFIch0jyH8fJc-tEwTDbj0kJvlo8j1S1o5urABa0CwjP6yQtQRBKu7x3xrShtD5IssCl2qQRvTyfGN1hr_OGjDBZ5q7JwjSNJmHTZDW-GwTOJud0pRmLeRzaQjxYVRwt9tFm5AWZNOGgpxd5Pn7s9UUHKQI7VFMSN8pPmK0VrCdo9H-LN3UBrGNVb02M8qVbMy3ANpHCImCm6HH3gdZjw8Wgyb2P4QrvnlqnO2NeLDKOsSHVgaY4P2-NPfRiJJIGO5KWjWscXxkN3miVNKELzNiOGEMORItimQ7O5CB1b1SpBvZxSXptuw6othMezaRmsmyCsIAYEjHbl86YI_28lSLANvArraKeF0k-xrtGvWyyipBgkOJuDAW4gKm7CThY55PnoI6LNpgI99xc_8TuBhJsLiRZyDSfFpnKX6UN1FKhfDEyMayD3mO5X4F7gIZbe9I7QCQh-RI1go-nh9VWmft5avzMkkd2G2SGeeETqy6aH448bRDEEwL4lsu7HCQjOmctA5qTH9X0sV7J-f_113UrKwTGJkeDGdqUIHDNIIn4lV3XOtN3PDVNNr4ZU270CBkr6doOmLI7ysE_EpwTCDWGV9qy1DcSa1aYek3F5wE_J_WgzPxHbgzRFsH_9K79F7t2ZqfdEVtly4dWuxouklocZvnKzpdNbS4jo6Aqm9oUXPlYUVB20f5e-ziDYifWPSwTiT9RVcgaBFcD_v9Hw).

在 [Vercel OG Playground](https://og-playground.vercel.app/?share=xVRNb9swDP0rgoahl6h2v4bOSLtDNwwDtsu2oy9yRNtq9WFIch0jyH8fJc-tEwTDbj0kJvlo8j1S1o5urABa0CwjP6yQtQRBKu7x3xrShtD5IssCl2qQRvTyfGN1hr_OGjDBZ5q7JwjSNJmHTZDW-GwTOJud0pRmLeRzaQjxYVRwt9tFm5AWZNOGgpxd5Pn7s9UUHKQI7VFMSN8pPmK0VrCdo9H-LN3UBrGNVb02M8qVbMy3ANpHCImCm6HH3gdZjw8Wgyb2P4QrvnlqnO2NeLDKOsSHVgaY4P2-NPfRiJJIGO5KWjWscXxkN3miVNKELzNiOGEMORItimQ7O5CB1b1SpBvZxSXptuw6othMezaRmsmyCsIAYEjHbl86YI_28lSLANvArraKeF0k-xrtGvWyyipBgkOJuDAW4gKm7CThY55PnoI6LNpgI99xc_8TuBhJsLiRZyDSfFpnKX6UN1FKhfDEyMayD3mO5X4F7gIZbe9I7QCQh-RI1go-nh9VWmft5avzMkkd2G2SGeeETqy6aH448bRDEEwL4lsu7HCQjOmctA5qTH9X0sV7J-f_113UrKwTGJkeDGdqUIHDNIIn4lV3XOtN3PDVNNr4ZU270CBkr6doOmLI7ysE_EpwTCDWGV9qy1DcSa1aYek3F5wE_J_WgzPxHbgzRFsH_9K79F7t2ZqfdEVtly4dWuxouklocZvnKzpdNbS4jo6Aqm9oUXPlYUVB20f5e-ziDYifWPSwTiT9RVcgaBFcD_v9Hw) 中查看此示例。

## Dynamic ticket images for Next.js Conf

## Next.js Conf 动态门票图像

We were able to put Vercel OG Image to the test at [Next.js Conf](https://nextjs.org/conf) by creating dynamic ticket images for every attendee.

我们通过为每位参会者生成动态门票图像，在 [Next.js Conf](https://nextjs.org/conf) 上对 Vercel OG Image 进行了实战检验。

For over 100,000 tickets, we’ve seen images generated **on average in 800ms**. That sub-second response includes loading two custom fonts, two external requests to fetch the GitHub avatar and ticket background images, as well as two embedded SVG images.

针对超过 10 万张门票，我们观察到图像平均生成耗时仅为 **800 毫秒**。这一亚秒级响应涵盖了加载两种自定义字体、发起两次外部请求（分别获取 GitHub 头像与门票背景图），以及嵌入两张 SVG 图像。

Since we have the power of CSS, it’s easy to handle wrapping names that could break the layout, as well as supporting special characters outside of the font glyph range.

得益于 CSS 的强大能力，我们可轻松处理可能导致布局错乱的长姓名自动换行，并支持字体字形范围之外的特殊字符。

![With Vercel OG, you can use the power of CSS to wrap layouts, as well as dynamically fetch and subset fonts from CDNs on the fly.](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_007.jpg)With Vercel OG, you can use the power of CSS to wrap layouts, as well as dynamically fetch and subset fonts from CDNs on the fly.

![借助 Vercel OG，您可利用 CSS 的能力实现布局自动换行，并能即时从 CDN 动态加载及子集化字体。](images/introducing-og-image-generation-fast-dynamic-social-card-images-at-the-edge-verc/img_007.jpg)借助 Vercel OG，您可利用 CSS 的能力实现布局自动换行，并能即时从 CDN 动态加载及子集化字体。

## Try Vercel OG Image Generation

## 尝试 Vercel OG 图像生成

Vercel OG Image Generation using Vercel Edge Functions is available today in public beta.

Vercel OG 图像生成（基于 Vercel Edge Functions）现已开放公开测试版。

- [View examples](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-examples)

- [查看示例](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-examples)

- [Read the API documentation](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-api)

- [阅读 API 文档](https://vercel.com/docs/functions/edge-functions/og-image-generation/og-image-api)

- [Deploy your first social card](https://vercel.com/new/clone?repository-url=https://github.com/vercel/examples/tree/main/edge-functions/vercel-og-nextjs&project-name=vercel-og-nextjs&repository-name=vercel-og-nextjs)

- [部署你的第一张社交卡片](https://vercel.com/new/clone?repository-url=https://github.com/vercel/examples/tree/main/edge-functions/vercel-og-nextjs&project-name=vercel-og-nextjs&repository-name=vercel-og-nextjs)
{% endraw %}
