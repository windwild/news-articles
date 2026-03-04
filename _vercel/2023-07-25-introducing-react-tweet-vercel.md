---
title: "Introducing React Tweet - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-react-tweet"
date: "2023-07-25"
scraped_at: "2026-03-02T09:51:36.316869590+00:00"
language: "en-zh"
translated: true
description: "Embed tweets into your React application without sacrificing performance."
---
{% raw %}

Jul 25, 2023

2023 年 7 月 25 日

在不牺牲性能的前提下，将推文嵌入您的 React 应用程序。

隆重推出 [`react-tweet`](https://react-tweet.vercel.app/) —— 仅需一行代码，即可将推文嵌入任意 React 应用，且完全不牺牲性能。

app/page.tsx

```javascript
import { Tweet } from 'react-tweet'



export default function Page() {

4  return <Tweet id="1683920951807971329" />

5}
```

最终呈现的推文——静态生成，无需 iframe：

Some benefits of using `react-tweet`:

使用 `react-tweet` 的一些优势：

- 35x less client-side JavaScript than the Twitter's Native embed

- 客户端 JavaScript 体积仅为 Twitter 原生嵌入的 1/35

- Support for React Server Components

- 支持 React Server Components（服务端组件）

- Built-in data fetching and caching

- 内置数据获取与缓存机制

- Works with any React framework – [Next.js](https://nextjs.org/), Vite, and Create React App

- 兼容任意 React 框架——包括 [Next.js](https://nextjs.org/)、Vite 和 Create React App


## Improving embeds with Server Components

## 使用服务端组件优化推文嵌入

Historically, embedding tweets has required using [Twitter's embedded iframe](https://publish.twitter.com/). This loads `560kb` worth of client-side JavaScript, which slows site performance and causes layout shift.

传统上，嵌入推文需依赖 [Twitter 的嵌入式 iframe](https://publish.twitter.com/)。该方式会加载高达 `560 KB` 的客户端 JavaScript，严重拖慢网站性能，并引发布局偏移（layout shift）。

With `react-tweet`, you no longer need to use iframes. Instead, all you need is a simple React component that is compatible with [Next.js](https://nextjs.org/), Vite, and Create React App:

借助 `react-tweet`，您不再需要使用 iframe。取而代之的，是一个简洁的 React 组件，且原生兼容 [Next.js](https://nextjs.org/)、Vite 和 Create React App：

app/page.tsx

```javascript
import { Tweet } from 'react-tweet'
```

```tsx
export default function Page() {

4  return <Tweet id="1683920951807971329" />

5}
```

```tsx
export default function Page() {

4  返回 <Tweet id="1683920951807971329" />

5}
```

The resulting embedded tweet has several advantages:

生成的嵌入式推文具有以下多项优势：

- No layout shift or scrolling jumps ( [Cumulative Layout Shift](https://vercel.com/docs/concepts/speed-insights#cumulative-layout-shift-cls))

- 无布局偏移或滚动跳动（[累积布局偏移（CLS）](https://vercel.com/docs/concepts/speed-insights#cumulative-layout-shift-cls)）

- Improved UX with instantly visible tweets in the browser (no lazy loading)

- 浏览器中推文即时可见，显著提升用户体验（无需懒加载）

- Build with the powerful React component abstraction.

- 借助强大而灵活的 React 组件抽象进行构建。

To demonstrate this performance improvement, here's a comparison between the native Twitter embed, iframe embed, and `react-tweet`:

为直观展示这一性能提升，以下对比了原生 Twitter 嵌入、iframe 嵌入与 `react-tweet` 的效果：

### **Native Twitter embed**

### **原生 Twitter 嵌入**

- Demo URL: [https://without-react-tweet.vercel.app/](https://without-react-tweet.vercel.app/)

- 所需客户端 JavaScript 体积：`560kb`

### **使用 iframe 的 Twitter 嵌入**

### **Twitter embed with iframe**

- Demo URL: [https://without-react-tweet-iframes.vercel.app/](https://without-react-tweet-iframes.vercel.app/)

- 所需客户端 JavaScript 体积：`557kb`

### **`react-tweet`**

### **`react-tweet`**

- Demo URL: [https://with-react-tweet.vercel.app/](https://with-react-tweet.vercel.app/)

- 所需客户端 JavaScript 体积：`16kb`

## `react-tweet` 的工作原理

## How `react-tweet` works

在底层，`react-tweet` 通过逆向工程 Twitter 的 Embed API，获取指定推文的数据，并以与 Twitter 原生嵌入 iframe 相同的样式进行渲染。

You don't need to rely on Twitter API v2 to fetch tweets on your own, saving you money and making it easier to add tweets to your site.

您无需依赖 Twitter API v2 即可自行获取推文，从而节省费用，并更轻松地将推文添加到您的网站中。

## Get started with `react-tweet`

## 开始使用 `react-tweet`

Try out `react-tweet` today by running the following command:

今天即可通过运行以下命令试用 `react-tweet`：

```bash
npm i react-tweet
```

[Check out the documentation](https://react-tweet.vercel.app/) to learn more.

[查看文档](https://react-tweet.vercel.app/) 以了解更多信息。

· [Follow](https://x.com/intent/follow?screen_name=vercel)

· [关注](https://x.com/intent/follow?screen_name=vercel)

[View on Twitter](https://x.com/vercel/status/1683920951807971329)

[在 Twitter 上查看](https://x.com/vercel/status/1683920951807971329)

Introducing \`react-tweet\`:

隆重推出 \`react-tweet\`：

◆ 35x less client-side JavaScript than the Twitter <iframe>  
◆ React Server Components for built-in data fetching  
◆ Works with Next.js, Vite, CRA, and more  

◆ 客户端 JavaScript 体积比 Twitter `<iframe>` 减少 35 倍  
◆ 内置数据获取能力的 React Server Components  
◆ 兼容 Next.js、Vite、CRA 等多种开发环境

[3:23 PM · Jul 25, 2023](https://x.com/vercel/status/1683920951807971329) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[3:23 下午 · 2023年7月25日](https://x.com/vercel/status/1683920951807971329) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.7K](https://x.com/intent/like?tweet_id=1683920951807971329) [回复](https://x.com/intent/tweet?in_reply_to=1683920951807971329)

[阅读 69 条回复](https://x.com/vercel/status/1683920951807971329)

· [关注](https://x.com/intent/follow?screen_name=vercel)

[在 Twitter 上查看](https://x.com/vercel/status/1683920951807971329)

隆重推出 \`react-tweet\`：

◆ 客户端 JavaScript 体积比 Twitter `<iframe>` 减少 35 倍  
◆ 内置数据获取能力的 React Server Components  
◆ 兼容 Next.js、Vite、CRA 等多种开发环境  

[3:23 PM · Jul 25, 2023](https://x.com/vercel/status/1683920951807971329) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[3:23 下午 · 2023年7月25日](https://x.com/vercel/status/1683920951807971329) [面向网站的 Twitter、广告信息与隐私政策](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.7K](https://x.com/intent/like?tweet_id=1683920951807971329) [回复](https://x.com/intent/tweet?in_reply_to=1683920951807971329)

[Read 69 replies](https://x.com/vercel/status/1683920951807971329)

[阅读 69 条回复](https://x.com/vercel/status/1683920951807971329)

Vercel.com landing page

Vercel.com 官网首页

### Read the docs

### 查阅文档

Vercel.com landing page

Vercel.com 官网首页

### Check out the code

### 查看源代码
{% endraw %}
