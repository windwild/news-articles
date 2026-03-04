---
render_with_liquid: false
title: "Building the Black Friday-Cyber Monday live dashboard - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/building-the-black-friday-cyber-monday-live-dashboard"
date: "2024-12-24"
scraped_at: "2026-03-02T09:39:04.266921931+00:00"
language: "en-zh"
translated: true
description: "See how we built the data-heavy Black Friday-Cyber Monday dashboard to be cost-efficient, fast, and accurate. Building a data-heavy, real-time dashboard with a good user experience comes with challeng..."
---
render_with_liquid: false
render_with_liquid: false

Dec 24, 2024

2024 年 12 月 24 日

This year, we built a [Black Friday-Cyber Monday (BFCM) dashboard](https://vercel.com/bfcm) to celebrate the success of our customers through the busy retail weekend.  
今年，我们构建了一个 [“黑色星期五—网络星期一”（BFCM）仪表盘](https://vercel.com/bfcm)，以庆祝我们的客户在这一繁忙的零售购物周末所取得的成功。

The dashboard gave a real-time look inside Vercel's infrastructure, showing live metrics for deployments, requests, blocked traffic, and more.  
该仪表盘实时呈现了 Vercel 基础设施的内部运行状况，动态展示部署量、请求量、被拦截流量等关键指标。

Building a data-heavy, real-time dashboard with a good user experience comes with challenges. Let's walk through how we overcame them.  
构建一个数据密集、实时性强且用户体验良好的仪表盘面临诸多挑战。接下来，我们将逐一介绍我们是如何应对这些挑战的。

## Dashboard architecture

## 仪表盘架构

The BFCM dashboard is a [Next.js](https://nextjs.org/) application built using a modified polling architecture. The core of the site works by having the client poll the server for data every 10 seconds.  
BFCM 仪表盘是一个基于 [Next.js](https://nextjs.org/) 构建的应用，采用了一种经过改良的轮询（polling）架构。其核心机制是：客户端每 10 秒向服务器发起一次数据轮询请求。

Upon receiving the request, the server queries our internal database and returns the aggregate metrics to the client. Behind the scenes, our APIs and services stream data about our requests, deployments, and the Vercel Firewall into the database.  
服务器接收到请求后，即刻查询内部数据库，并将聚合后的指标数据返回给客户端。在后台，我们的各类 API 和服务持续将请求、部署及 Vercel 防火墙等相关数据实时流式写入数据库。

![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_001.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_002.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_003.jpg)![High-level BFCM dashboard architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_004.jpg)High-level BFCM dashboard architecture  
![BFCM 仪表盘高层架构示意图](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_001.jpg)![BFCM 仪表盘高层架构示意图](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_002.jpg)![BFCM 仪表盘高层架构示意图](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_003.jpg)![BFCM 仪表盘高层架构示意图](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_004.jpg)BFCM 仪表盘高层架构

## Backend optimizations

## 后端优化

The metrics we wanted to highlight involved scanning terabytes of data. We needed to avoid costly long-running queries and a poor user experience while retrieving data.  
我们希望重点呈现的指标需扫描数 TB 级别的原始数据。因此，在数据检索过程中，我们必须避免高成本、长时间运行的查询，防止损害用户体验。

### **Cost-efficiency:** Handling expensive queries with a Vercel Marketplace Integration  

### **成本效益：** 借助 Vercel Marketplace 集成处理高开销查询

We started with this initial query for getting the total requests count:

我们最初使用以下 SQL 查询来获取请求总数：

```text
SELECT count() FROM requests WHERE timestamp > '2024-11-29 00:00:00'
```

```text
SELECT count() FROM requests WHERE timestamp > '2024-11-29 00:00:00'
```

Initial SQL Query

初始 SQL 查询

Issues with this query became clear quickly. As more requests came in, the query took longer to run.

该查询的问题很快显现出来：随着请求量持续增加，查询执行时间不断变长。

To minimize the amount of data to scan, we used a **rolling window**. Rather than querying from the beginning of Black Friday every time, we queried a smaller five-minute time period instead:

为最大限度减少需扫描的数据量，我们采用了**滚动窗口（rolling window）**策略。不再每次都从“黑色星期五”活动开始时刻起查询，而是仅查询最近五分钟的时间窗口：

```text
SELECT count() FROM requests WHERE timestamp > now() - INTERVAL 5 MINUTE
```

```text
SELECT count() FROM requests WHERE timestamp > now() - INTERVAL 5 MINUTE
```

Updated SQL query with rolling window

采用滚动窗口更新后的 SQL 查询

This way, the query only needed to count the records from the last five minutes, resulting in cheaper and faster results. However, it also meant that we didn’t have the total count—the actual data we wanted to display.

这样一来，查询只需统计最近五分钟内的记录，显著降低了计算开销并提升了响应速度。但与此同时，我们也失去了累计总数——而这恰恰是我们真正需要展示的核心数据。

To fix this, we used the [Upstash KV integration on the Vercel Marketplace](https://vercel.com/marketplace/upstash). We stored the cumulative count and had the server combine the two numbers into the total.

为解决这一问题，我们集成了 [Vercel Marketplace 上的 Upstash KV](https://vercel.com/marketplace/upstash)。我们将累计请求数持久化存储在 Upstash KV 中，并由服务器端将该累计值与滚动窗口内新增的请求数相加，最终得出实时总请求数。

![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_005.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_006.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_007.jpg)![Using Upstash KV to track totals with incremental updates](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_008.jpg)Using Upstash KV to track totals with incremental updates

![使用 Upstash KV 通过增量更新追踪累计总数](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_005.jpg)![使用 Upstash KV 通过增量更新追踪累计总数](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_006.jpg)![使用 Upstash KV 通过增量更新追踪累计总数](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_007.jpg)![使用 Upstash KV 通过增量更新追踪累计总数](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_008.jpg)使用 Upstash KV 通过增量更新追踪累计总数

### ) Speed: Using **Incremental Static Regeneration (ISR)**

### ) 速度：使用**增量静态再生（ISR）**

All visitors to the BFCM dashboard saw the exact same data. Instead of calling the database for each visitor to the site, we could fetch data once and cache the response.

所有访问 BFCM 仪表板的用户看到的都是完全相同的数据。与其为每位网站访客都调用一次数据库，不如只获取一次数据，并将响应结果缓存起来。

![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_009.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_010.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_011.jpg)![Caching server responses to save database calls](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_012.jpg)Caching server responses to save database calls

![缓存服务器响应以减少数据库调用](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_009.jpg)![缓存服务器响应以减少数据库调用](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_010.jpg)![缓存服务器响应以减少数据库调用](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_011.jpg)![缓存服务器响应以减少数据库调用](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_012.jpg)缓存服务器响应以减少数据库调用

To keep data fresh, we invalidated the cache every five seconds. This also meant we only hit our database once in this time period.

为确保数据时效性，我们每五秒使缓存失效一次。这意味着在此时间窗口内，我们仅需访问一次数据库。

To implement this, we used Next.js's built-in [time-based Incremental Static Regeneration (ISR)](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#time-based-revalidation) by adding the following two lines of code to our `page.tsx` file:

为实现该功能，我们在 `page.tsx` 文件中添加了以下两行代码，利用 Next.js 内置的[基于时间的增量静态再生（ISR）](https://nextjs.org/docs/app/building-your-application/data-fetching/incremental-static-regeneration#time-based-revalidation)机制：

page.tsx

page.tsx

```javascript
1// Tell Next.js to render the page as a static page, despite having fetch calls

export const dynamic = 'force-static';



4// Invalidate the cache after 5 seconds

4// 5 秒后使缓存失效
```

```ts
export const revalidate = 5;

export default function Page() { ... }
```

```ts
export const revalidate = 5;

export default function Page() { ... }
```

以静态方式渲染页面并基于时间设置重新验证（revalidation）

- **如果页面为新鲜状态（生成时间距今不足 5 秒）**：直接返回缓存的页面  

- **如果页面已过期（生成时间距今超过 5 秒）**：先返回缓存的页面，同时在后台异步生成最新版本的页面。下一位访问者访问时，即可看到更新后的页面。

![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_013.jpg)![使用增量静态再生（ISR）为所有用户缓存页面](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_013.jpg)  
![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_014.jpg)![使用增量静态再生（ISR）为所有用户缓存页面](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_014.jpg)  
![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_015.jpg)![使用增量静态再生（ISR）为所有用户缓存页面](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_015.jpg)  
![Using ISR to cache pages for all users](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_016.jpg)![使用增量静态再生（ISR）为所有用户缓存页面](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_016.jpg)  
Using ISR to cache pages for all users  

使用增量静态再生（ISR）为所有用户缓存页面  

通过上述优化，我们的后端架构已全部完成。

![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_017.jpg)![已完成的后端架构](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_017.jpg)  
![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_018.jpg)![已完成的后端架构](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_018.jpg)  
![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_019.jpg)![已完成的后端架构](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_019.jpg)  
![Completed backend architecture](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_020.jpg)![已完成的后端架构](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_020.jpg)  
Completed backend architecture  

已完成的后端架构  

## Frontend optimizations  

## 前端优化  

Our biggest frontend challenge was delivering a smooth real-time experience. Since the page polls every 10 seconds for new data, the numbers are only updated once in that time frame. This created a clunky jump in numbers when new data came in.  

我们面临的最大前端挑战，是提供流畅的实时体验。由于页面每 10 秒轮询一次新数据，数字仅在此时间间隔内更新一次；因此每当新数据到达时，数值会出现突兀的跳变。

![Initial counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_021.jpg)![Initial counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_022.jpg)初始计数动画

## User experience: Dynamic visuals with rate of change

## 用户体验：带变化速率的动态视觉效果

We wanted users to have dynamic visuals—simulating the feeling of the number constantly going up. We can achieve this by calculating the rate at which the metrics change over time.

我们希望为用户提供动态视觉效果——模拟数字持续上升的感觉。这可以通过计算各项指标随时间的变化速率来实现。

In the backend, we calculated the rate without any infrastructure changes, since we already stored the previous count in a KV store:

在后端，我们在不改动任何基础设施的前提下计算了该速率，因为我们已将上一次的计数值存储在 KV 存储中：

```javascript
export function getRateOfChange() {

2  const lastCount = getCountFromKv();

3  const newCount = fetchLatestCount(); // only from last 5 minutes

4  const rateOfChange = newCount / (Date.now() - lastCount.timestamp)

5  return rateOfChange;

6}
```

Then, we passed this rate and value to a client component and used `requestAnimationFrame` to increment the number in the frontend:

然后，我们将该变化速率和数值传递给一个客户端组件，并在前端使用 `requestAnimationFrame` 来递增数字：

counter.tsx

counter.tsx

```javascript
1'use client';



import { useEffect, useRef } from 'react';



export function Counter({ value, rateOfChange }) {

6  const ref = useRef(null);



8  useEffect(() => {

9    let id;

9    `let id;`

10    const increment = (ts) => {

10    `const increment = (ts) => {`

11      if (!ref.current) return;

11      `if (!ref.current) return;`

13      ref.current.textContent = value + rateOfChange * ts;

13      `ref.current.textContent = value + rateOfChange * ts;`

14      id = requestAnimationFrame(increment);

14      `id = requestAnimationFrame(increment);`

15    };

15    `};`

16    id = requestAnimationFrame(increment);

16    `id = requestAnimationFrame(increment);`

17    return () => {

17    `return () => {`

18      cancelAnimationFrame(id);

18      `cancelAnimationFrame(id);`

19    };

20  }, [rateOfChange]);

22  return <span ref={ref}>{value}</span>;

23}
```

## Accuracy: Preventing over/undercounting

## 准确性：防止多计数或少计数

While incrementing the count in the frontend provides a smooth visual effect, it can lead to discrepancies between the displayed count and the actual count from the backend.

虽然在前端递增计数能提供流畅的视觉效果，但这可能导致显示的计数值与后端返回的实际计数值之间出现偏差。

For accuracy, we dynamically adjusted the rate of change by calculating the difference between the value displayed and the new updated value. This way, if we overcounted, we slowed down the update rate. If we undercounted, we sped it up. To do this we:

为确保准确性，我们通过计算当前显示值与新更新值之间的差值，动态调整变化速率。这样，若发生多计数，则降低更新速率；若发生少计数，则提高更新速率。具体实现方式如下：

- Tracked the previous rate and value

- 跟踪记录上一次的变化速率和数值

- Calculated the difference between the old value and the new value

- 计算旧数值与新数值之间的差值

- Adjusted the rate of change based on the difference to fine-tune animation speed  
- 根据差值调整变化速率，以精细调节动画速度  

- Updated the previous ref for the next calculation  
- 更新 `previous` 引用，为下一次计算做准备  

- Updated the current ref with the new value  
- 使用新值更新 `current` 引用  

`counter.tsx`  
`counter.tsx`

```javascript
1'use client';



import { useEffect, useRef, useState } from 'react';



export function Counter({ value, rateOfChange }) {

6  const [rate, setRate] = useState(rateOfChange);
```

8  const lastMetric = useRef({

8  const lastMetric = useRef({

9    value,

9    value,

10    timestamp: null,

10    timestamp: null,

11  });



11  });



13  useEffect(() => {

13  useEffect(() => {

14    const percentageDiff = lastMetric.current.value / value;

14    const percentageDiff = lastMetric.current.value / value;

15    setRate(rateOfChange * percentageDiff);

15    setRate(rateOfChange * percentageDiff);

16  }, [value, rateOfChange]);

16  }, [value, rateOfChange]);

18  const ref = useRef(null);

18  const ref = useRef(null);

20  useEffect(() => {

20  useEffect(() => {

21    let id;

21    let id;

22    const increment = (ts) => {

22    const increment = (ts) => {

23      if (!ref.current) return;

23      if (!ref.current) 返回；

25      const { timestamp, value } = lastMetric.current;

25      const { timestamp, value } = lastMetric.current;

26      lastMetric.current.timestamp = ts;

26      lastMetric.current.timestamp = ts;

28      const lastTime = timestamp ?? ts;

28      const lastTime = timestamp ?? ts;

29      const diff = (ts - lastTime) * rate;

29      const diff = (ts - lastTime) * rate;

30      const newValue = value + diff;

30      const newValue = value + diff;

32      lastMetric.current.value = newValue;

32      lastMetric.current.value = newValue;

33      ref.current.textContent = newValue;

33      ref.current.textContent = newValue;

34      id = requestAnimationFrame(increment);

34      id = requestAnimationFrame(increment);

35    };

35    };

36    id = requestAnimationFrame(increment);

36    id = requestAnimationFrame(increment);

37    return () => {

37    返回 () => {

38      cancelAnimationFrame(id);

38      cancelAnimationFrame(id);

39    };

39    };

40  }, [rate]);

40  }, [rate]);



42  return <span ref={ref}>{value}</span>;

42  return <span ref={ref}>{value}</span>;

43}
43}
```

## Performance: Using React Server Components

## 性能优化：使用 React 服务端组件

The BFCM dashboard is built mostly using React Server Components (RSCs). The only client components needed were ones that did animation. By using RSCs, we were able to simplify our data-fetching logic.

BFCM 仪表板主要采用 React 服务端组件（RSC）构建。唯一需要客户端组件的部分是涉及动画的功能。通过使用 RSC，我们得以大幅简化数据获取逻辑。

In a typical client-side app, we would fetch data using a combination of `useState` and `useEffect`:

在典型的客户端应用中，我们会结合使用 `useState` 和 `useEffect` 来获取数据：

```javascript
const [data, setData] = useState(null);

useEffect(() => setData(getData()), []);
```

```javascript
const [data, setData] = useState(null);

useEffect(() => setData(getData()), []);
```

在客户端获取数据会导致以下问题：

1. 数据加载会被延迟，直到用户浏览器完成 JavaScript 的下载、解析与执行

2. 数据获取过程本身还依赖于用户的网络连接状况

撇开性能问题不谈，客户端数据获取还意味着我们需要为客户端实现并暴露 API 端点。

```javascript
export async function GET() {

2  return getData();

3}
```

```javascript
export async function GET() {

2  return getData();

3}
```

借助 React Server Components（RSC），我们得以利用 `async/await` 将数据获取逻辑迁移至服务端。

```javascript
async function Statistics() {

2	const { value, rateOfChange } = await getData();

3	return <Counter value={value} rateOfChange={rateOfChange} />;

4}
```

```javascript
async function Statistics() {

2	const { value, rateOfChange } = await getData();

3	return <Counter value={value} rateOfChange={rateOfChange} />;

4}
```

通过在组件中直接调用 `getData`，我们消除了对 API 端点的需求。因此，用户在初始页面加载时仅接收到其所需的内容——即完全渲染好的组件，而无需额外的网络请求。

![Final counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_023.jpg)![Final counting animation](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_024.jpg)最终计数动画

## Summary

## 总结

通过逐个解决性能瓶颈，我们完全能够构建出兼具成本效益、高性能、数据准确性和良好用户体验的数据密集型网站：

- 通过获取增量计数（incremental count）而非总数（total count）来提升查询效率；  
- 利用增量静态再生（ISR，Incremental Static Regeneration）最大限度减少数据库调用次数。

- Giving users dynamic visuals with rate-of-change tactics  
- 通过变化率策略为用户提供动态可视化效果  

- Ensuring accuracy with dynamic rate adjustments  
- 通过动态速率调节确保数据准确性  

- Moving data fetching to the server for better performance  
- 将数据获取迁移至服务器端，以提升性能  

Even the most demanding sites can use Vercel and Next.js to create great experiences. We hope this behind-the-scenes exploration of the BFCM dashboard's architecture provides valuable insights for your own site.  
即使是要求最严苛的网站，也能借助 Vercel 和 Next.js 打造卓越的用户体验。我们希望本次对 BFCM 实时仪表盘架构的幕后深度解析，能为您的网站建设提供宝贵启发。

[**Prepare for BFCM 2025**  
**备战 2025 年“黑色星期五 & 网络星期一”（BFCM）**  

If you’re looking ahead to next year’s BFCM, watch the recording of our Black Friday 2025 virtual event hosted by Vercel CTO Malte Ubl.  
若您正着眼于明年 BFCM 的筹备工作，欢迎观看由 Vercel 首席技术官 Malte Ubl 主持的“2025 黑色星期五线上峰会”录播回放。  

Watch now  
立即观看](https://vercel.com/go/black-friday-2025?utm_source=vercel-site&utm_medium=blog&utm_campaign=WBN-Beyond-Black-Friday-2024-12-10)

Blog post  
博客文章  

Nov 27, 2024  
2024 年 11 月 27 日  

### Retailer sees $10M increase in sales on Vercel  
### 零售商借助 Vercel 实现销售额激增 1000 万美元  

![](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_025.jpg)

Alina Weinstein  
阿莉娜·魏因斯坦

Blog post

博客文章

Jan 16, 2024

2024 年 1 月 16 日

### Architecting a live look at reliability: Stripe's viral Black Friday site

### 构建实时可靠性视图：Stripe 爆火的黑色星期五网站

![](images/building-the-black-friday-cyber-monday-live-dashboard-vercel/img_026.jpg)

Greta Workman

格蕾塔·沃克曼