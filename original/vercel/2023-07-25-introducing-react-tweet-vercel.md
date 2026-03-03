---
title: "Introducing React Tweet - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-react-tweet"
date: "2023-07-25"
scraped_at: "2026-03-02T09:51:36.316869590+00:00"
language: "en"
translated: false
description: "Embed tweets into your React application without sacrificing performance."
---




Jul 25, 2023

Embed tweets into your React application without sacrificing performance.

Introducing [`react-tweet`](https://react-tweet.vercel.app/) – embed tweets into any React application with a single line of code, without sacrificing performance.

app/page.tsx

```javascript
import { Tweet } from 'react-tweet'



export default function Page() {

4  return <Tweet id="1683920951807971329" />

5}
```

The resulting tweet – statically generated, no iframes required:

Some benefits of using `react-tweet`:

- 35x less client-side JavaScript than the Twitter's Native embed

- Support for React Server Components

- Built-in data fetching and caching

- Works with any React framework – [Next.js](https://nextjs.org/), Vite, and Create React App


## Improving embeds with Server Components

Historically, embedding tweets has required using [Twitter's embedded iframe](https://publish.twitter.com/). This loads `560kb` worth of client-side JavaScript, which slows site performance and causes layout shift.

With `react-tweet`, you no longer need to use iframes. Instead, all you need is a simple React component that is compatible with [Next.js](https://nextjs.org/), Vite, and Create React App:

app/page.tsx

```javascript
import { Tweet } from 'react-tweet'



export default function Page() {

4  return <Tweet id="1683920951807971329" />

5}
```

The resulting embedded tweet has several advantages:

- No layout shift or scrolling jumps ( [Cumulative Layout Shift](https://vercel.com/docs/concepts/speed-insights#cumulative-layout-shift-cls))

- Improved UX with instantly visible tweets in the browser (no lazy loading)

- Build with the powerful React component abstraction.


To demonstrate this performance improvement, here's a comparison between the native Twitter embed, iframe embed, and `react-tweet`:

### **Native Twitter embed**

- Demo URL: [https://without-react-tweet.vercel.app/](https://without-react-tweet.vercel.app/)

- Client-side JavaScript needed: `560kb`


### **Twitter embed with iframe**

- Demo URL: [https://without-react-tweet-iframes.vercel.app/](https://without-react-tweet-iframes.vercel.app/)

- Client-side JavaScript needed: `557kb`


### **`react-tweet`**

- Demo URL: [https://with-react-tweet.vercel.app/](https://with-react-tweet.vercel.app/)

- Client-side JavaScript needed: `16kb`


## How `react-tweet` works

Under the hood, `react-tweet` reverse-engineers the Twitter's Embed API to fetch data for a given tweet and renders it in the same style as Twitter's embedded iframe.

You don't need to rely on Twitter API v2 to fetch tweets on your own, saving you money and making it easier to add tweets to your site.

## Get started with `react-tweet`

Try out `react-tweet` today by running the following command:

```bash
npm i react-tweet
```

[Check out the documentation](https://react-tweet.vercel.app/) to learn more.




· [Follow](https://x.com/intent/follow?screen_name=vercel)

[View on Twitter](https://x.com/vercel/status/1683920951807971329)

Introducing \`react-tweet\`:

◆ 35x less client-side JavaScript than the Twitter <iframe>
◆ React Server Components for built-in data fetching
◆ Works with Next.js, Vite, CRA, and more


[3:23 PM · Jul 25, 2023](https://x.com/vercel/status/1683920951807971329) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.7K](https://x.com/intent/like?tweet_id=1683920951807971329) [Reply](https://x.com/intent/tweet?in_reply_to=1683920951807971329)


[Read 69 replies](https://x.com/vercel/status/1683920951807971329)




· [Follow](https://x.com/intent/follow?screen_name=vercel)

[View on Twitter](https://x.com/vercel/status/1683920951807971329)

Introducing \`react-tweet\`:

◆ 35x less client-side JavaScript than the Twitter <iframe>
◆ React Server Components for built-in data fetching
◆ Works with Next.js, Vite, CRA, and more


[3:23 PM · Jul 25, 2023](https://x.com/vercel/status/1683920951807971329) [Twitter for Websites, Ads Information and Privacy](https://help.x.com/en/x-for-websites-ads-info-and-privacy)

[1.7K](https://x.com/intent/like?tweet_id=1683920951807971329) [Reply](https://x.com/intent/tweet?in_reply_to=1683920951807971329)


[Read 69 replies](https://x.com/vercel/status/1683920951807971329)

Vercel.com landing page

### Read the docs

Vercel.com landing page

### Check out the code