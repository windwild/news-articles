---
title: "Vercel Web Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-web-analytics-is-now-generally-available"
date: "2023-04-19"
scraped_at: "2026-03-02T09:53:26.189630359+00:00"
language: "en"
translated: false
description: "Get detailed, first-party page views, traffic analytics"
---




Apr 19, 2023

Get detailed, first-party page views, traffic analytics, and custom events with Vercel Web Analytics.

Vercel Web Analytics is generally available for insights on your top pages, top referrers, and user demographics such as countries, operating systems, browser information, and more. We're also excited to announce new functionality, [filtering](https://vercel.com/changelog/filter-analytics-traffic-data) and [custom events](https://vercel.com/docs/concepts/analytics/custom-events).

[Web Analytics](https://vercel.com/docs/concepts/analytics/limits-and-pricing) is available on all plans and custom events are available for Pro and Enterprise users.

### First-party Analytics for privacy-friendly tracking and less JS

Instead of relying on cookies, first-party Vercel Web Analytics can identify a user by a hash created from the incoming request. Using a generated hash provides a privacy-friendly experience for your visitors and means they can't be tracked across different websites or applications, and data is discarded after 24 hours. Using Vercel Web Analytics removes the need for cookie tracking and third-party scripts.

In just three steps you can set up Web Analytics on your projects to get access to traffic insights—without any compromise on your page loading speed. Vercel Web Analytics is **44x smaller than Google Analytics** so you'll maintain great site performance.

> “Analytics unlocks a treasure trove of application data faster than it would take to write the JIRA ticket to set it up. Analytics unlocks a treasure trove of application data faster than it would take to write the JIRA ticket to set it up. ”
>
> ![](images/vercel-web-analytics-vercel/img_001.png)
>
> **Michelle Bakels,** Co-organizer of React Miami

### Framework-defined analytics ingestion and reporting

The `Analytics` component is a wrapper around the tracking script, offering more seamless integration with Next.js and other frameworks:

- [Next.js](https://vercel.com/docs/concepts/analytics/package)

- [React](https://vercel.com/docs/concepts/analytics/package)

- [SvelteKit](https://vercel.com/docs/concepts/analytics/package)

- [Nuxt](https://vercel.com/docs/concepts/analytics/package)

- [Remix](https://vercel.com/docs/concepts/analytics/package)

- Or any website through a [script tag](https://vercel.com/docs/concepts/analytics/package)


```tsx
import type { AppProps } from 'next/app';

import { Analytics } from '@vercel/analytics/react';



function MyApp({ Component, pageProps }: AppProps) {

5  return (

6    <>

7      <Component {...pageProps} />

8      <Analytics />

9    </>

10  );

11}



export default MyApp;
```

If you are using the pages directory, add this component to your main app file.

### Now with Custom Event Tracking

Vercel Web Analytics also gives Pro and Enterprise users the ability to track custom events. With custom events, you can track things like newsletter signups or what CTAs your customers are clicking the most to dive deeper into understanding your user's journey.

```tsx
import va from '@vercel/analytics';



function SignupButton() {

4  return (

5    <button

6      onClick={() => {

7        va.track('Signup', {

8          location: 'US'

9        });

10      };

11    >

12      Sign Up

13    </button>

14  );

15};
```

This will track an event named Signup.

Understanding users is crucial to building a great product. With Vercel's Web Analytics feature, you can quickly and easily gain insights into your audiences to ensure you're building the best experiences for them. [Get started today](https://vercel.com/docs/concepts/analytics).

Vercel Template

Deploy this template

### A collection of components, hooks, and utilities built on Next.js, Typescript, Tailwind, Radix, Framer Motion, Prisma, and PostgreSQL.

Precedent – Next.js Starter

Vercel Template

Deploy this template

### HTML5 template with analytics and advanced routing configuration.

HTML Starter