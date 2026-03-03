---
title: "Improving INP with React 18 and Suspense - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense"
date: "2022-08-09"
scraped_at: "2026-03-02T10:01:12.102131535+00:00"
language: "en"
translated: false
description: "Learn how to improve Interaction to Next Paint in React applications by using Suspense and selective hydration."
---




Aug 9, 2022

How to optimize your application's responsiveness.

_Updated January 18, 2024._

[Interaction to Next Paint (INP)](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights) measures your site’s responsiveness to user interactions on the page. The faster your page responds to user input, the better.

On March 12, 2024, INP will [officially replace First Input Delay (FID)](https://developers.google.com/search/blog/2023/05/introducing-inp) as the third [Core Web Vital](https://web.dev/articles/vitals).

This post will help you understand why INP is a better way to measure responsiveness than FID and how React and Next.js can improve INP. You'll be prepared for updates to Core Web Vitals, which impact [search rankings](https://nextjs.org/learn/seo), as INP moves from experimental to stable. We have a separate [post on understanding the metric and further optimization of INP.](https://vercel.com/blog/demystifying-inp-new-tools-and-actionable-insights)

## ) Interaction to Next Paint (INP)

Delivering a great user experience is not just about the first initial load, but also about how responsive the page is to interaction. INP helps measure this responsiveness.

A low INP means the given page was able to respond with visual feedback quickly for the majority of interactions. This is measured from the time of the first event to when the browser could show a visual update.

![An INP below or at 200 milliseconds means that your page has good responsiveness.](images/improving-inp-with-react-18-and-suspense-vercel/img_001.jpg)![An INP below or at 200 milliseconds means that your page has good responsiveness.](images/improving-inp-with-react-18-and-suspense-vercel/img_002.jpg)An INP below or at 200 milliseconds means that your page has good responsiveness.

Keep in mind that, by default, JavaScript is single-threaded. If you’re loading a large JS script, nothing else can happen on your page until the main thread is idle—even [reacting to a user’s click on a plain HTML link](https://web.dev/articles/fid#what_if_an_interaction_doesnt_have_an_event_listener).

Improving INP means improving how quickly this main thread can respond to user interaction.

### How does INP differ from FID?

FID will soon be replaced by INP as a Core Web Vital, responsible in part for ranking your application in Google Search. Let’s break down the differences between the two:

- FID measures only the **first** input and browser response. INP considers the responsiveness of all user input for the duration of the page session.

- FID only measures the delay between input and the browser _starting_ to respond. INP measures the time between the input and the event completing in response.

- INP additionally groups events that occur as part of the same logical user interaction, defining the interaction’s latency as the max duration of all its events.


Let’s explore some practical solutions to lower INP with React, like selective hydration with Suspense. These techniques can also improve other metrics such as FID, [Total Blocking Time (TBT)](https://web.dev/tbt), and [Time to Interactive (TTI)](https://web.dev/tti/).

## React 18 and Selective Hydration

React 18 was designed to help improve interactivity with features like [selective hydration](https://github.com/reactwg/react-18/discussions/130) and [`startTransition`](https://github.com/reactwg/react-18/discussions/41). [Concurrent React](https://reactjs.org/blog/2022/03/29/react-v18.html#what-is-concurrent-react) is able to prioritize what you interact with and is interruptible if higher-priority interactions occur.

React and Next.js are able to generate HTML on the server and send it to the client. The initial rendered HTML is not interactive until the JavaScript for the page has been fetched and loaded. **Hydration** then makes your page interactive through JavaScript (e.g. attaching event handlers to a button).

Before React (17 and lower) is able to hydrate _any_ of the components, JavaScript for the entire page needs to be fetched. During this period, the page is not interactive. For example:

```jsx
1// JavaScript for the entire page must be loaded

2// before the page can become interactive

export default function HomePage() {

4  return (

5    <>

6      <Header />

7      <Body />

8      <Footer />

9    </>

10  );

11}
```

JavaScript for the entire page must be loaded before the page can become interactive.

With React 18, you can take hydration off the main thread and make it non-blocking, simply by creating a `Suspense` boundary.

You no longer have to wait for all the JavaScript to load to start hydrating parts of the page. This means components can become interactive faster by allowing the browser to do other work at the same time as hydration, making your page more responsive and resulting in lower FID and INP.

```jsx
import { Suspense } from 'react';



3// Using a loading component as the Suspense fallback

function Loading() { ... }



6// Using `Suspense` makes hydration non-blocking

export default function HomePage() {

8  return (

9    <>

10      <Header />

11      <Suspense fallback={<Loading />}>

12        <Body />

13        <Footer />

14      </Suspense>

15    </>

16  );

17}
```

Using Suspense makes hydration non-blocking with React 18.

These changes help improve the interactivity of all React applications.

## Case Study: Next.js Site

We were able to reduce the [Total Blocking Time (TBT)](https://web.dev/tbt) of [nextjs.org](http://nextjs.org/) from 430ms to 80ms using selective hydration with Suspense while validating changes with Lighthouse (”lab” metrics).

```jsx
1// Simplified version of the changes made to

2// the nextjs.org landing page to improve INP with `Suspense`

export default function Index() {

4  return (

5    <Page title="Next.js by Vercel - The React Framework">

6      <SkipNavContent />

7      <Banner badge="New" href="/blog/next-12-2">

8        {"Next.js 12.2 →"}

9      </Banner>

10      <Hero />

11      <Suspense fallback={<Loading />}>

12        <Features />

13        <Customers />

14        <Learn />

15        <Newsletter />

16        <Footer />

17      </Suspense>

18    </Page>

19  );

20}
```

Simplified version of the changes made to the nextjs.org landing page to improve INP with Suspense.

You can omit the Suspense `fallback`, but proceed with caution. If any components in the subtree suspend, you risk showing a broken, empty state.

Adding `Suspense` to group major areas of the page allows these components to be hydrated independently. Experiment with wrapping major blocks of your site with `Suspense` to achieve similar results.

After rolling out these changes to production, we saw Vitals ("field" metrics) improve to:

- **First Input Delay:** 5ms (Good)

- **Interaction to Next Paint:** 48ms (Good)


![Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.](images/improving-inp-with-react-18-and-suspense-vercel/img_003.jpg)![Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.](images/improving-inp-with-react-18-and-suspense-vercel/img_004.jpg)Interaction to Next Paint (INP) of nextjs.org from Vercel Analytics.

For Next.js developers, we're also working to add support for route transitions (using React 18's `startTransition`) with the new [layouts and routing changes](https://nextjs.org/blog/layouts-rfc). This enables navigations to be interruptable if higher priority events occur, leading to further responsiveness.

## Other ways to optimize INP

Since the main thread must be idle in order to process event handlers, you can also look into these techniques to optimize INP:

- Using CSS instead of JavaScript for animations, since a separate thread handles CSS, called the browser’s compositor thread. Some CSS properties, such as transforms, can also [use the GPU for rendering](https://developer.mozilla.org/en-US/docs/Web/Performance/Fundamentals#specific_coding_tips_for_application_performance).

- [Throttling or debouncing events](https://www.freecodecamp.org/news/javascript-debounce-example/)—especially ones driven by scrolling—that may be called repeatedly by user input.

- [Reducing your DOM size](https://web.dev/articles/dom-size-and-interactivity), to avoid having the browser recalculate too many elements on each render.

- Related to the above, inline SVGs can be especially troublesome if you have too many or if they [end up in your client-side JS bundle](https://kurtextrem.de/posts/svg-in-js) (for example, by inlining them in JSX). You may need reference them in an `<img>`tag or look into [alternate ways of rendering them](https://css-tricks.com/too-many-svgs-clogging-up-your-markup-try-use/), such as keeping them in [React Server Components](https://vercel.com/blog/understanding-react-server-components).

- In the case of a complex application, using web workers to [arbitrarily execute JavaScript on separate threads](https://developer.mozilla.org/en-US/docs/Web/API/Web_Workers_API/Using_web_workers), keeping the main thread open for user input.

- Lazy loading images, fonts, or scripts, which [Next.js can automatically do for you](https://nextjs.org/docs/app/building-your-application/optimizing).


You can start measuring INP today inside [Vercel Speed Insights](https://vercel.com/docs/speed-insights), which gives you real-time information from your real users about how your site is performing. This enables you to quickly debug performance issues and focus on what optimizations are working.