---
title: "First Input Delay (FID) vs. Interaction to Next Paint (INP) - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/first-input-delay-vs-interaction-to-next-paint"
date: "2023-09-26"
scraped_at: "2026-03-02T09:50:22.258276986+00:00"
language: "en"
translated: false
description: "Learn about the differences between FID and INP and how to optimize your website's INP score."
---




Sep 26, 2023

Learn about the differences between FID and INP and how to optimize your website's INP score.

As of March 2024, Interaction to Next Paint (INP) will replace the First Input Delay (FID) as a new Core Web Vital.

First Input Delay is a web performance metric that measures the time between a user's very first interaction with a web page and the time when the browser's main thread is able to start processing that interaction event.

When a user interacts with a web page, an event is added to a queue to be processed by the browser's main thread. However, if the main thread is already busy doing other tasks like parsing HTML, executing JavaScript, or handling other event listeners, the new event has to wait in the queue.

The FID metric captures the duration of this waiting time, which tells us how long it takes for the browser to respond to the user's first input while the main thread is busy.

![The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_001.jpg)![The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_002.jpg)The First Input Delay measures the time between the first user interaction (clicks, taps, key presses) until the browser can process the event

However, the First Input Delay (FID) metric has some shortcomings:

- **FID only considers the delay of the** **_first_** **input event**, ignoring subsequent interactions that may also be slow or even slower.

- Other factors can contribute to a longer visual feedback delay between user interactions, which FID doesn't measure. This includes the time it takes to process event handlers and recalculate the layout before providing visual feedback to the user.


## ) Interaction to Next Paint (INP)

To address these limitations, the Interaction to Next Paint (INP) metric will replace First Input Delay.

While FID only measured the input delay, which is the time between user input and the browser starting to execute the event handler, INP measures:

- **Input Delay**: the time between user interaction and the time the browser is able to process the event, similar to FID.

- **Processing Delay**: the time it takes the browser to process the event handlers

- **Presentational Delay**: the time it takes the browser to recalculate the layout and paint the pixels to the screen.


![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_003.jpg)![](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_004.jpg)

Additionally, whereas FID only measured the _very first_ user interaction, the INP score is measured when the user leaves the page by aggregating _all interactions_ the user made with the page throughout the page’s lifetime and **returning the worst-measured score**.

![Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_005.jpg)![Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.](images/first-input-delay-fid-vs-interaction-to-next-paint-inp-vercel/img_006.jpg)Since the worst-measured score throughout the page's lifespan was 120ms, the total INP score will be 120.

With INP, we no longer have to focus solely on optimizing event queuing times and main thread availability, as was the case with FID. Now, it is also crucial to address the entire lifecycle of a user interaction. This includes processing event handlers, recalculating layouts, and painting updates to the screen, all of which are critical components of the INP metric.

## Optimizing your INP score

For FID, the primary goal was to reduce the time between a user's initial interaction and when the browser's main thread starts processing it. This typically involved optimizing JavaScript execution times, breaking down long tasks, and ensuring the main thread remains as free as possible during user interactions.

However, with INP, we need to consider a broader range of performance factors.

### Processing Delay

The processing delay emphasizes the importance of not only starting the event handler quickly but also executing it efficiently. We can optimize the processing delay by:

- **Profiling code and identifying performance bottlenecks**.

- **Using techniques like** **`debounce`** **or** **`throttle`** for frequently firing event handlers.

- **Code splitting and tree shaking** to reduce unnecessary JavaScript. Load only what is necessary, when it is necessary.

- **Breaking down long JavaScript tasks** into smaller chunks. The longer a task takes on the main thread, the longer it will block user interactions.


### Presentational Delay

After processing an event, the browser may need to recalculate styles, reflow layouts, and repaint the screen. We can optimize the presentational delay by:

- Using the **`will-change`** property judiciously to inform the browser about properties and elements likely to be animated.

- Opting for **`transform`** and **`opacity`** changes for animations as they are less likely to cause layout recalculations.

- Using properties like **`content-visibility`** to render and update content only when necessary.

- **Reducing forced synchronous layouts.** Avoid reading layout properties immediately after writing them, as this can trigger the browser to synchronize and recalculate styles and layouts.

- **Using web forkers for non-urgent and non-UI tasks.** By offloading these tasks to background threads, you can keep the main thread free and responsive to user interactions.


### Event Handling

Event handlers should be executed efficiently and effectively. We can do this by:

- **Deferring non-critical events** until the main thread is less busy.

- **Using passive event listeners for** events like **`scroll`** and **`touch`**. This informs the browser that the event listener will not prevent a scroll or touch event, allowing the browser to continue smooth scrolling without waiting for the listener.

- **Delegating events** by, instead of attaching event listeners to individual elements, attaching them to a common parent and using event properties to determine which child element was interacted with. This reduces the number of active event listeners and potential slowdowns.


## Measuring your INP score

To maintain an optimized and responsive website, Real User Monitoring (RUM) tools can be used to regularly collect performance data from actual users, which is crucial for measuring INP.

While the metric is not yet officially stable, we can already measure INP using tools like:

- [Vercel Speed Insights](https://vercel.com/docs/speed-insights)

- [PageSpeed Insights](https://pagespeed.web.dev/)

- [Lighthouse's Timespan feature](https://web.dev/lighthouse-user-flows/)


The INP metric provides a broader perspective by recognizing the significance of not just the time it takes for the browser to start processing an event, but also the total time needed to respond to the user's interactions visually.

Optimizing for INP will not only result in more responsive and seamless interactions but also greatly enhance the overall user experience.

If you're using Next.js, using React 18's concurrent features can also help improve your INP score. [Learn more in this blog post](https://vercel.com/blog/how-react-18-improves-application-performance).