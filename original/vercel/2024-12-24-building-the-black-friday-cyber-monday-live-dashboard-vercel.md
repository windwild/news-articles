---
title: "Building the Black Friday-Cyber Monday live dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-the-black-friday-cyber-monday-live-dashboard"
date: "2024-12-24"
scraped_at: "2026-03-02T09:39:04.266921931+00:00"
language: "en"
translated: false
description: "See how we built the data-heavy Black Friday-Cyber Monday dashboard to be cost-efficient, fast, and accurate. Building a data-heavy, real-time dashboard with a good user experience comes with challeng..."
---




Dec 24, 2024

This year, we built a [Black Friday-Cyber Monday (BFCM) dashboard](https://vercel.com/bfcm) to celebrate the success of our customers through the busy retail weekend. The dashboard gave a real-time look inside Vercel's infrastructure, showing live metrics for deployments, requests, blocked traffic, and more.

Building a data-heavy, real-time dashboard with a good user experience comes with challenges. Let's walk through how we overcame them.

## Dashboard architecture

The BFCM dashboard is a [Next.js](https://nextjs.org/) application built using a modified polling architecture. The core of the site works by having the client poll the server for data every 10 seconds.

Upon receiving the request, the server queries our internal database and returns the aggregate metrics to the client. Behind the scenes, our APIs and services stream data about our requests, deployments, and the Vercel Firewall into the database.

![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_001.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_002.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_003.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_004.jpg)High-level BFCM dashboard architecture

## Backend optimizations

The metrics we wanted to highlight involved scanning terabytes of data. We needed to avoid costly long-running queries and a poor user experience while retrieving data.

### **Cost-efficiency:** Handling expensive queries with a Vercel Marketplace Integration

We started with this initial query for getting the total requests count:

```text
SELECT count() FROM requests WHERE timestamp > '2024-11-29 00:00:00'
```

Initial SQL Query

Issues with this query became clear quickly. As more requests came in, the query took longer to run.

To minimize the amount of data to scan, we used a **rolling window**. Rather than querying from the beginning of Black Friday every time, we queried a smaller five-minute time period instead:

```text
SELECT count() FROM requests WHERE timestamp > now() - INTERVAL 5 MINUTE
```

Updated SQL query with rolling window

This way, the query only needed to count the records from the last five minutes, resulting in cheaper and faster results. However, it also meant that we didn’t have the total count—the actual data we wanted to display.

To fix this, we used the [Upstash KV integration on the Vercel Marketplace](https://vercel.com/marketplace/upstash). We stored the cumulative count and had the server combine the two numbers into the total.

![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_005.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_006.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_007.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_008.jpg)Using Upstash KV to track totals with incremental updates

### ) Speed: Using **Incremental Static Regeneration (ISR)**

All visitors to the BFCM dashboard saw the exact same data. Instead of calling the database for each visitor to the site, we could fetch data once and cache the response.

![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_009.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_010.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_011.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_012.jpg)Caching server responses to save database calls

To keep data fresh, we invalidated the cache every five seconds. This also meant we only hit our database once in this time period.

To implement this, we used Next.js's built-in [time-based Incremental Static Regeneration (ISR)](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#time-based-revalidation) by adding the following two lines of code to our `page.tsx` file:

page.tsx

```javascript
1// Tell Next.js to render the page as a static page, despite having fetch calls

export const dynamic = 'force-static';



4// Invalidate the cache after 5 seconds

export const revalidate = 5;

export default function Page() { ... }
```

Rendering the page as a static page and setting time based revalidation

- **If the page was fresh (newer than five seconds)**: We returned the cached page

- **If the page was stale (older than five seconds)**: We returned the cached page and regenerated a fresh version of the page in the background. The next time a visitor viewed the site, we returned the fresh page


![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_013.jpg)![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_014.jpg)![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_015.jpg)![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_016.jpg)Using ISR to cache pages for all users

With those optimizations, our backend architecture was complete.

![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_017.jpg)![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_018.jpg)![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_019.jpg)![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_020.jpg)Completed backend architecture

## Frontend optimizations

Our biggest frontend challenge was delivering a smooth real-time experience. Since the page polls every 10 seconds for new data, the numbers are only updated once in that time frame. This created a clunky jump in numbers when new data came in.

![Initial counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_021.jpg)![Initial counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_022.jpg)Initial counting animation

## User experience: Dynamic visuals with rate of change

We wanted users to have dynamic visuals—simulating the feeling of the number constantly going up. We can achieve this by calculating the rate at which the metrics change over time.

In the backend, we calculated the rate without any infrastructure changes, since we already stored the previous count in a KV store:

```javascript
export function getRateOfChange() {

2  const lastCount = getCountFromKv();

3  const newCount = fetchLatestCount(); // only from last 5 minutes

4  const rateOfChange = newCount / (Date.now() - lastCount.timestamp)

5  return rateOfChange;

6}
```

Then, we passed this rate and value to a client component and used `requestAnimationFrame` to increment the number in the frontend:

counter.tsx

```javascript
1'use client';



import { useEffect, useRef } from 'react';



export function Counter({ value, rateOfChange }) {

6  const ref = useRef(null);



8  useEffect(() => {

9    let id;

10    const increment = (ts) => {

11      if (!ref.current) return;



13      ref.current.textContent = value + rateOfChange * ts;

14      id = requestAnimationFrame(increment);

15    };

16    id = requestAnimationFrame(increment);

17    return () => {

18      cancelAnimationFrame(id);

19    };

20  }, [rateOfChange]);



22  return <span ref={ref}>{value}</span>;

23}
```

## Accuracy: Preventing over/undercounting

While incrementing the count in the frontend provides a smooth visual effect, it can lead to discrepancies between the displayed count and the actual count from the backend.

For accuracy, we dynamically adjusted the rate of change by calculating the difference between the value displayed and the new updated value. This way, if we overcounted, we slowed down the update rate. If we undercounted, we sped it up. To do this we:

- Tracked the previous rate and value

- Calculated the difference between the old value and the new value

- Adjusted the rate of change based on the difference to fine-tune animation speed

- Updated the previous ref for the next calculation

- Updated the current ref with the new value


counter.tsx

```javascript
1'use client';



import { useEffect, useRef, useState } from 'react';



export function Counter({ value, rateOfChange }) {

6  const [rate, setRate] = useState(rateOfChange);



8  const lastMetric = useRef({

9    value,

10    timestamp: null,

11  });



13  useEffect(() => {

14    const percentageDiff = lastMetric.current.value / value;

15    setRate(rateOfChange * percentageDiff);

16  }, [value, rateOfChange]);



18  const ref = useRef(null);



20  useEffect(() => {

21    let id;

22    const increment = (ts) => {

23      if (!ref.current) return;



25      const { timestamp, value } = lastMetric.current;

26      lastMetric.current.timestamp = ts;



28      const lastTime = timestamp ?? ts;

29      const diff = (ts - lastTime) * rate;

30      const newValue = value + diff;



32      lastMetric.current.value = newValue;

33      ref.current.textContent = newValue;

34      id = requestAnimationFrame(increment);

35    };

36    id = requestAnimationFrame(increment);

37    return () => {

38      cancelAnimationFrame(id);

39    };

40  }, [rate]);



42  return <span ref={ref}>{value}</span>;

43}
```

## Performance: Using React Server Components

The BFCM dashboard is built mostly using React Server Components (RSCs). The only client components needed were ones that did animation. By using RSCs, we were able to simplify our data-fetching logic.

In a typical client-side app, we would fetch data using a combination of `useState` and `useEffect`:

```javascript
const [data, setData] = useState(null);

useEffect(() => setData(getData()), []);
```

Fetching data on the client results in:

1. Data being delayed until the user’s browser can download, parse, and execute JavaScript

2. The data fetching itself being dependent on the user’s internet connection


Performance aside, client-side fetching also means we would need to implement and expose API endpoints for the client to get data.

```javascript
export async function GET() {

2  return getData();

3}
```

With RSCs, we were able to move data fetching to the server using `async/await`:

```javascript
async function Statistics() {

2	const { value, rateOfChange } = await getData();

3	return <Counter value={value} rateOfChange={rateOfChange} />;

4}
```

By calling `getData` directly in the component, we eliminate the need for API endpoints. As a result, users received only what they need—the fully rendered components—with no additional calls on initial page load.

![Final counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_023.jpg)![Final counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_024.jpg)Final counting animation

## Summary

Building data-heavy websites that are cost-efficient, performant, accurate, and have a good user experience is possible by addressing performance bottlenecks one step at a time:

- Making queries more efficient by getting the incremental count instead of total count

- Using ISR to minimize the number of database calls

- Giving users dynamic visuals with rate-of-change tactics

- Ensuring accuracy with dynamic rate adjustments

- Moving data fetching to the server for better performance


Even the most demanding sites can use Vercel and Next.js to create great experiences. We hope this behind-the-scenes exploration of the BFCM dashboard's architecture provides valuable insights for your own site.

[**Prepare for BFCM 2025**\\
\\
If you’re looking ahead to next year’s BFCM, watch the recording of our Black Friday 2025 virtual event hosted by Vercel CTO Malte Ubl. \\
\\
Watch now](https://vercel.com/go/black-friday-2025?utm_source=vercel-site&utm_medium=blog&utm_campaign=WBN-Beyond-Black-Friday-2024-12-10)

Blog post

Nov 27, 2024

### Retailer sees $10M increase in sales on Vercel

![](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_025.jpg)

Alina Weinstein

Blog post

Jan 16, 2024

### Architecting a live look at reliability: Stripe's viral Black Friday site

![](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_026.jpg)

Greta Workman