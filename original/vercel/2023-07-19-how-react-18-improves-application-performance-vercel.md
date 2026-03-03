---
title: "How React 18 Improves Application Performance - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-react-18-improves-application-performance"
date: "2023-07-19"
scraped_at: "2026-03-02T09:51:42.116307389+00:00"
language: "en"
translated: false
description: "Learn how React 18's concurrent features like Transitions, Suspense, and React Server Components improve application performance."
---




Jul 19, 2023

Learn how concurrent features like Transitions, Suspense, and React Server Components improve application performance.

React 18 has introduced concurrent features that fundamentally change the way React applications can be rendered. We'll explore how these latest features impact and improve your application's performance.

First, let's take a small step back to understand the basics of long tasks and the corresponding performance measurements.

## Main thread and Long Tasks

When we run JavaScript in the browser, the JavaScript engine executes code in a single-threaded environment, which is often referred to as the main thread. Along with executing JavaScript code, the main thread is responsible for handling other tasks as well, including managing user interactions like clicks and keystrokes, processing network events, timers, updating animations, and managing browser reflows and repaints.

![The main thread is responsible for handling tasks one by one](images/how-react-18-improves-application-performance-vercel/img_001.jpg)![The main thread is responsible for handling tasks one by one](images/how-react-18-improves-application-performance-vercel/img_002.jpg)The main thread is responsible for handling tasks one by one

When a task is being processed, all other tasks must wait. While small tasks can be executed smoothly by browsers to provide a seamless user experience, longer tasks can be problematic as they can block other tasks from being processed.

Any task that takes more than 50 milliseconds to run is considered a " [long task](https://web.dev/long-tasks-devtools/#what-are-long-tasks)".

![](images/how-react-18-improves-application-performance-vercel/img_003.jpg)![](images/how-react-18-improves-application-performance-vercel/img_004.jpg)

This 50ms benchmark is based on the fact that devices must create a new frame every 16ms (60fps) to maintain a smooth visual experience. However, devices must also perform other tasks, such as responding to user input and executing JavaScript.

The 50ms benchmark allows the device to allocate resources to both rendering frames and performing other tasks, and provides an additional ~33.33ms for the device to perform other tasks while maintaining a smooth visual experience. You can read more about the 50ms benchmark in [this blog post](https://web.dev/rail/#response-process-events-in-under-50ms) covering the RAIL model.

To maintain optimal performance, it is important to minimize the number of long tasks. To measure the performance of your website, there are two metrics that measure the impact of long tasks on the performance of your applications: Total Blocking Time, and Interaction to Next Paint.

[Total Blocking Time (TBT)](https://vercel.com/docs/concepts/speed-insights#total-blocking-time-tbt) is an important metric that measures the time between the [First Contentful Paint (FCP)](https://web.dev/fcp/) and [Time to Interactive (TTI)](https://web.dev/tti/). TBT is the sum of the time it took tasks longer than 50ms to execute, which can have a significant impact on the user experience.

![The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms. ](images/how-react-18-improves-application-performance-vercel/img_005.jpg)![The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms. ](images/how-react-18-improves-application-performance-vercel/img_006.jpg)The TBT is 45ms, since we have two tasks that took longer than 50ms before TTI, which exceeded the 50ms threshold by 30ms and 15ms respectively. The total blocking time is the accumulation of these values: 30ms + 15ms = 45ms.

The [Interaction to Next Paint (INP)](https://web.dev/inp/), a new Core Web Vitals metric, measures the time from a user's first interaction with the page (e.g. clicking a button) to when this interaction is visible on-screen; the next paint. This metric is particularly important for pages with many user interactions, like e-commerce sites or social media platforms. It’s measured by accumulating all the INP measurements throughout the user’s current visit and returning the worst score.

![The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.](images/how-react-18-improves-application-performance-vercel/img_007.jpg)![The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.](images/how-react-18-improves-application-performance-vercel/img_008.jpg)The Interaction to Next Paint is 250ms, as it's the highest measured visual delay.

To understand how the new React updates optimize for these measurements and thus improve the user experience, it's important to understand how traditional React works first.

## Traditional React Rendering

A visual update in React is divided into two phases: the **render phase** and the **commit phase**.

The render phase in React is a pure computation phase where React elements are reconciled with (i.e. compared to) the existing DOM. This phase involves creating a new tree of React elements, also known as the "virtual DOM", which is essentially a lightweight in-memory representation of the actual DOM.

During the render phase, React calculates the differences between the current DOM and the new React component tree and prepares the necessary updates.

![](images/how-react-18-improves-application-performance-vercel/img_009.jpg)![](images/how-react-18-improves-application-performance-vercel/img_010.jpg)

Following the render phase is the commit phase. In this phase, React applies the updates calculated during the render phase to the actual DOM. This involves creating, updating, and deleting DOM nodes to mirror the new React component tree.

In a traditional synchronous render, React would give the same priority to all elements within a component tree. When a component tree is rendered, either on the initial render or on a state update, React would go ahead and render the tree in a single uninterruptible task, after which it gets committed to the DOM to visually update the on-screen components.

![](images/how-react-18-improves-application-performance-vercel/img_011.jpg)![](images/how-react-18-improves-application-performance-vercel/img_012.jpg)

A synchronous render is an “all-or-nothing” operation, where it’s guaranteed that a component that starts rendering will always finish. Depending on the complexity of the components, the render phase could take a while to complete. The main thread is blocked during this time, meaning that users trying to interact with the application experience an unresponsive UI until React has completed the render and committed the result to the DOM.

You can see this happen in the following demo. We have a text input field and a large list of cities that get filtered based on the current value of the text input. In a synchronous render, React will go ahead and re-render the **`CitiesList`** component on each keystroke. This is quite an expensive computation since the list consists of tens of thousands of cities, so there’s a clear visual feedback delay here between the keystroke and seeing this reflected in the text input.

App.jsCityList.jsindex.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

You are editing the code. To exit the edit mode, press Escape

99

1

2

3

4

5

6

7

8

9

10

11

12

13

14

importReact,{useState}from"react";

importCityListfrom"./CityList";

exportdefaultfunctionSearchCities(){

const\[text,setText\] = useState("Am");

return(

<main>

<h1>Traditional Rendering</h1>

<inputtype="text"onChange={(e)=>setText(e.target.value)}/>

<CityListsearchQuery={text}/>

</main>

);

};

Refresh previewOpen on CodeSandbox

[Open on CodeSandbox](https://codesandbox.io/api/v1/sandboxes/define?undefined "Open in CodeSandbox")

If you’re on a high-end device like a Macbook, you might want to throttle your CPU 4x to simulate a lower-end device. You can see this setting in Devtools > Performance > ⚙️ > CPU.

When we look at the performance tab, you can see that long tasks occur on every keystroke, which is suboptimal.

![Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms. ](images/how-react-18-improves-application-performance-vercel/img_013.jpg)![Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms. ](images/how-react-18-improves-application-performance-vercel/img_014.jpg)

Tasks marked with the red corner are considered “long tasks”. Note the total blocking time of 4425.40ms.

In such scenarios, React developers would often use third-party libraries like [`debounce`](https://www.npmjs.com/package/debounce) to defer the rendering, but there was no built-in solution.

React 18 introduces a new concurrent renderer that operates behind the scenes. This renderer exposes some ways for us to mark certain renders as non-urgent.

![When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks](images/how-react-18-improves-application-performance-vercel/img_015.jpg)![When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks](images/how-react-18-improves-application-performance-vercel/img_016.jpg)When rendering the low-priority components (pink), React yields back to the main thread to check for more important tasks

In that case, React will yield back to the main thread every 5 milliseconds to see if there are more important tasks to handle instead, such as user input or even rendering another React component state updates that are more important to the user experience at that moment. By continuously yielding back to the main thread, React is able to make such renders non-blocking and prioritize more important tasks.

![Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components. ](images/how-react-18-improves-application-performance-vercel/img_017.jpg)![Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components. ](images/how-react-18-improves-application-performance-vercel/img_018.jpg)Instead of a single non-interruptible task for every render, the concurrent renderer yields control back to the main thread at intervals of 5ms during the (re)rendering of low-priority components.

Additionally, the concurrent renderer is able to “concurrently” render multiple versions of the component tree in the background without immediately committing the result.

Whereas a synchronous render is an all-or-nothing computation, the concurrent renderer allows React to pause and resume the rendering of one or multiple component trees to achieve the most optimal user experience.

![React pauses the current render based on a user interaction that forces it to prioritize rendering another update](images/how-react-18-improves-application-performance-vercel/img_019.jpg)![React pauses the current render based on a user interaction that forces it to prioritize rendering another update](images/how-react-18-improves-application-performance-vercel/img_020.jpg)React pauses the current render based on a user interaction that forces it to prioritize rendering another update

Using concurrent features, React can pause and resume the rendering of components based on external events such as user interaction. When the user started interacting with `ComponentTwo`, React paused the current rendering, prioritized and render **`ComponentTwo`**, after which it resumed rendering `ComponentOne`. We'll talk about this more in the section on **Suspense.**

## Transitions

We can mark an update as non-urgent by using the **`startTransition`** function made available by the `useTransition` hook. This is a powerful new feature that allows us to mark certain state updates as “transitions”, indicating that they can lead to visual changes that could potentially disrupt user experience if they were rendered synchronously.

By wrapping a state update in **`startTransition`**, we can tell React that we’re okay with deferring or interrupting the rendering to prioritize more important tasks to keep the current user interface interactive.

```jsx
import { useTransition } from "react";



function Button() {

4  const [isPending, startTransition] = useTransition();



6  return (

7    <button

8      onClick={() => {

9        urgentUpdate();

10        startTransition(() => {

11          nonUrgentUpdate()

12        })

13      }}

14    >...</button>

15  )

16}
```

When a transition starts, the concurrent renderer prepares the new tree in the background. Once it’s finished rendering, it’ll keep the result in memory until the React scheduler can performantly update the DOM to reflect the new state. This moment could be when the browser is idle and a higher priority task (like user interaction) isn't pending.

![](images/how-react-18-improves-application-performance-vercel/img_021.jpg)![](images/how-react-18-improves-application-performance-vercel/img_022.jpg)

Using a transition would be perfect for the **`CitiesList`** demo. Instead of directly updating the value passed to the `searchQuery` param on each keystroke – which, in turn, leads to a synchronous render call on each keystroke – we can split the state into two values and wrap the `searchQuery`'s state update in a `startTransition`.

This tells React that the state update might lead to visual changes that could be disruptive to the user, and therefore React should attempt to keep the current UI interactive while preparing the new state in the background without committing the updates immediately.

index.jsApp.jsCityList.jsstyles.css

To enter the code editing mode, press Enter. To exit the edit mode, press Escape

You are editing the code. To exit the edit mode, press Escape

99

1

2

3

4

5

6

7

8

9

10

11

12

13

14

15

16

17

18

19

20

21

22

23

24

importReact,{useState,useTransition}from"react";

importCityListfrom"./CityList";

exportdefaultfunctionSearchCities(){

const\[text,setText\] = useState("Am");

const\[searchQuery,setSearchQuery\] = useState(text);

const\[isPending,startTransition\] = useTransition();

return(

<main>

<h1><code>startTransition</code></h1>

<input

type="text"

value={text}

onChange={(e)=>{

setText(e.target.value)

startTransition(()=>{

setSearchQuery(e.target.value)

})

}}/>

<CityListsearchQuery={searchQuery}/>

</main>

);

};

Refresh previewOpen on CodeSandbox

[Open on CodeSandbox](https://codesandbox.io/api/v1/sandboxes/define?undefined "Open in CodeSandbox")

Now when we type in the input field, the user input remains smooth without any visual delays between keystrokes. This happens since the `text` state is still updated synchronously, which the input field uses as its `value`.

In the background, React starts rendering the new tree on each keystroke. But instead of this being an all-or-nothing synchronous task, React starts preparing the new version of the component tree in memory while the current UI (showing the "old" state) remains responsive to further user input.

Looking at the performance tab, wrapping the state update in a **`startTransition`** significantly decreased the number of long tasks and the total blocking time compared to the performance graph for the implementation without the use of transitions.

![The performance tab shows that the number of long tasks and the total blocking time have reduced significantly.](images/how-react-18-improves-application-performance-vercel/img_023.jpg)The performance tab shows that the number of long tasks and the total blocking time have reduced significantly.

Transitions are part of a fundamental shift in React's rendering model, enabling React to render muliple versions of the UI concurrently, and manage priorities between different tasks. This allows for a smoother and more responsive user experience, especially when dealing with high-frequency updates or CPU-intensive rendering tasks.

## React Server Components

React Server Components are an **experimental feature** in React 18, but [ready for frameworks to adopt](https://react.dev/blog/2023/05/03/react-canaries). This is important to know before we delve into Next.js.

Traditionally, React offered a few primary ways to render our app. We could either render everything entirely on the client (Client-Side Rendering), or we could render the component tree to HTML on the server and send this static HTML to the client with a JavaScript bundle to hydrate the components client-side (Server-Side Rendering).

![](images/how-react-18-improves-application-performance-vercel/img_024.jpg)![](images/how-react-18-improves-application-performance-vercel/img_025.jpg)

Both approaches rely on the fact that the synchronous React renderer needs to rebuild the component tree client-side which the use of the shipped JavaScript bundle, even though this component tree was already available on the server.

React Server Components allow React to send the actual serialized component tree to the client. The client-side React renderer understands this format and uses it to performantly reconstruct the React component tree without having to send the HTML file or JavaScript bundle.

![](images/how-react-18-improves-application-performance-vercel/img_026.jpg)![](images/how-react-18-improves-application-performance-vercel/img_027.jpg)

We can use this new rendering pattern by combining `react-server-dom-webpack/server`'s `renderToPipeableStream` method with **`react-dom/client`**'s `createRoot` method.

```javascript
1// server/index.js

import App from '../src/App.js'

app.get('/rsc', async function(req, res) {

4  const {pipe} = renderToPipeableStream(React.createElement(App));

5  return pipe(res);

6});



8---

9// src/index.js

import { createRoot } from 'react-dom/client';

import { createFromFetch } from 'react-server-dom-webpack/client';

export function Index() {

13  ...

14  return createFromFetch(fetch('/rsc'));

15}

const root = createRoot(document.getElementById('root'));

root.render(<Index />);
```

⚠️ This is an over-simplified (!) example of the CodeSandbox demo shown below.

[Click here to see the full CodeSandbox demo](https://codesandbox.io/p/sandbox/cocky-minsky-m7sgfx). In the next section, we'll cover a more elaborate example.

By default, React won't hydrate React Server Components. The components aren't expected to use any client-side interactivity like accessing the **`window`** object or use hooks like **`useState`** or `useEffect`.

To add a component and its imports to a JavaScript bundle that gets shipped to the client, thus making it interactive, you can use the ["use client" bundler directive](https://react.dev/reference/react/use-client) on the top of the file. This tells the bundler to add **this component and its imports** to the client bundle and tells React to hydrate the tree client-side to add interactivity. Such components are referred to as Client Components.

![Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.](images/how-react-18-improves-application-performance-vercel/img_028.jpg)![Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.](images/how-react-18-improves-application-performance-vercel/img_029.jpg)Note: Framework implementations may differ. For example, Next.js will prerender Client Components to HTML on the server, similar to the traditional SSR approach. By default, however, Client Components are rendered similar to the CSR approach.

It's up to the developer to optimize bundle size when working with Client Components. Developers can do this by:

- Ensuring that only the leaf-most node of the interactive component defines the **`"use client"`** directive. This may require some component decoupling.

- Passing component trees as props rather than importing them directly. This allows React to render the **`children`** as React Server Components without adding them to the client bundle.


## Suspense

Another important new concurrent feature is [**`Suspense`**](https://react.dev/reference/react/Suspense). Although it’s not entirely new as `Suspense` was released in React 16 for code-splitting with **`React.lazy`**, the new capabilities introduced with React 18 extend `Suspense` to data fetching.

Using **`Suspense`**, we can delay the rendering of a component until certain conditions are met, such as data being loaded from a remote source. In the meantime, we can render a fallback component that indicates that this component is still loading.

By declaratively defining loading states, we reduce the need for any conditional rendering logic. Using `Suspense` in combination with React Server Components allows us to directly access server-side data sources without requiring a separate API endpoint, such as databases or the file system.

```jsx
async function BlogPosts() {

2  const posts = await db.posts.findAll();

3  return '...';

4}



export default function Page() {

7  return (

8    <Suspense fallback={<Skeleton />}>

9      <BlogPosts />

10    </Suspense>

11  )

12}
```

Using React Server Components works seamlessly with Suspense, which allows us to define a loading state while the component is still loading.

The true power of **`Suspense`** comes from its deep integration with React's Concurrent features. When a component is suspended, for example because it’s still waiting for data to load, React doesn't just sit idle until the component has received the data. Instead, it pauses the rendering of the suspended component and shifts its focus to other tasks.

![](images/how-react-18-improves-application-performance-vercel/img_030.jpg)![](images/how-react-18-improves-application-performance-vercel/img_031.jpg)

During this time, we can tell React to render a fallback UI to indicate that this component is still loading. Once the awaited data becomes available, React can seamlessly resume the rendering of the previously suspended component in an interruptible way, like we previously saw happening with transitions.

React can also reprioritize components based on user interaction. For example, when a user interacts with a suspended component that's not currently being rendered, React suspends the ongoing render and prioritizes the component that the user is interacting with.

![](images/how-react-18-improves-application-performance-vercel/img_032.jpg)![](images/how-react-18-improves-application-performance-vercel/img_033.jpg)

Once it's ready, React commits it to the DOM, and resumes the previous render. This ensures that user interactions are prioritized and the UI remains responsive and up-to-date with user inputs.

The combination of `Suspense` with React Server Component’s streamable format allows high-priority updates to be sent to the client as soon as they're ready, without waiting for lower-priority rendering tasks to complete. This enables the client to start processing data sooner and provides a more fluid user experience by gradually revealing content as it arrives in a non-blocking manner.

This interruptible rendering mechanism combined with **`Suspense`**'s ability to handle asynchronous operations provides a much smoother and more user-centric experience, particularly in complex applications with significant data-fetching needs.

## Data Fetching

Besides rendering updates, React 18 also introduces a new API to fetch data and memoize the result efficiently.

React 18 now has a [cache function](https://nextjs.org/docs/app/building-your-application/data-fetching/caching#react-cache) that remembers the result of the wrapped function call. If you call the same function with the same arguments _within the same render pass_, it will use the memoized value without the need to execute the function again.

```javascript
import { cache } from 'react'



export const getUser = cache(async (id) => {

4  const user = await db.user.findUnique({ id })

5  return user;

6})



getUser(1)

getUser(1) // Called within same render pass: returns memoized result.
```

In `fetch` calls, React 18 now includes a similar caching mechanism by default without having to use `cache`. This helps to reduce the number of network requests in a single render pass, which improves application performance and lowers API costs.

```javascript
export const fetchPost = (id) => {

2  const res = await fetch(`https://.../posts/${id}`);

3  const data = await res.json();

4  return { post: data.post }

5}



fetchPost(1)

fetchPost(1) // Called within same render pass: returns memoized result.
```

These features are helpful when working with React Server components, as they cannot access the Context API. The automatic caching behavior of both cache and fetch allows exporting a single function from a global module and reusing it throughout the application.

![](images/how-react-18-improves-application-performance-vercel/img_034.jpg)![](images/how-react-18-improves-application-performance-vercel/img_035.jpg)

```jsx
async function fetchBlogPost(id) {

2  const res = await fetch(`/api/posts/${id}`);

3  return res.json();

4}



async function BlogPostLayout() {

7  const post = await fetchBlogPost('123');

8  return '...'

9}

async function BlogPostContent() {

11  const post = await fetchBlogPost('123'); // Returns memoized value

12  return '...'

13}



export default function Page() {

16  return (

17    <BlogPostLayout>

18      <BlogPostContent />

19    </BlogPostLayout>

20  )

21}
```

## Conclusion

In summary, React 18's latest features improve performance in many ways.

- With **Concurrent React**, the rendering process can be paused and resumed later or even abandoned. This means the UI can respond immediately to user input even if a large rendering task is in progress.

- The **Transitions API** allows for smoother transitions during data fetches or screen changes without blocking user input.

- **React Server Components** lets developers build components that work on both the server and client, combining the interactivity of client-side apps with the performance of traditional server rendering without the cost of hydration.

- The extended **`Suspense`** functionality improves loading performance by allowing parts of the application to render before others that may take longer to fetch data.


Developers using [Next.js's App Router](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration) can start taking advantage of the features now available for frameworks, like **`cache`** and Server Components, mentioned in this blog post. In an upcoming blog post, we'll cover how the Next.js App Router leverages these performance features to enhance your application even further.

Vercel.com landing page

### See it in action

Vercel Template

Deploy this template

### Examples of many Next.js App Router features.

Next.js App Router Playground