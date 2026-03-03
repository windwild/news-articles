---
title: "What’s new in React 19 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/whats-new-in-react-19"
date: "2024-09-04"
scraped_at: "2026-03-02T09:41:18.755485741+00:00"
language: "en"
translated: false
description: "React 19 is near. Here's what to expect and how you can get started deploying React 19 on Vercel."
---




Sep 4, 2024

Explore React 19 and how to start using it on Vercel today.

React 19 is near. The React Core Team [announced a React 19 release candidate](https://react.dev/blog/2024/04/25/react-19#new-feature-use) (RC) this past April. This major version brings several updates and new patterns, aimed at improving performance, ease of use, and developer experience.

Many of these features were introduced as experimental in React 18, but they will be marked as stable in React 19. Here’s a high-level look at what you need to know to be ready.

## Server Components

Server Components are one of the biggest changes to React since its initial release 10 years ago. They act as a foundation for React 19’s new features, improving:

- **Initial page load times.** By rendering components on the server, they reduce the amount of JavaScript sent to the client, resulting in faster initial loads. They also let data queries start on the server _before_ the page is sent to the client.

- **Code portability.** Server Components let developers write components that can run on both the server and client, which reduces duplication, improves maintainability, and enables easier sharing of logic across your codebase.

- **SEO.** Server-side rendering of components allows search engines and LLMs to crawl and index content more effectively, improving search engine optimization.


We won’t dive deep into [Server Components](https://vercel.com/blog/understanding-react-server-components-57brjqQf27QFQaFFm27gZ9) or [rendering strategies](https://vercel.com/blog/how-to-choose-the-best-rendering-strategy-for-your-app) in this post. However, to understand the significance of Server Components, let’s take a brief look at how React rendering has evolved.

React started with Client-Side Rendering (CSR), which served minimal HTML to the user.

index.html

```html
1<!DOCTYPE html>

2<html>

3  <body>

4    <div id="root"></div>

5    <script src="/static/js/bundle.js"></script>

6  </body>

7</html>
```

The linked script includes everything about your application—React, third-party dependencies, and all your application code. As your application grew, so did your bundle size. The JavaScript is downloaded and parsed, and then React loads the DOM elements into the empty div. While this was happening, all the user sees is a blank page.

Even when the initial UI finally shows, the page content is still missing, which is why loading skeletons gained popularity. Data is then fetched and the UI renders a second time, replacing loading skeletons with actual content.

![](images/what_s-new-in-react-19-vercel/img_001.jpg)![](images/what_s-new-in-react-19-vercel/img_002.jpg)![](images/what_s-new-in-react-19-vercel/img_003.jpg)![](images/what_s-new-in-react-19-vercel/img_004.jpg)

React improved with Server-Side Rendering (SSR), which moves the first render to the server. The HTML served to the user wasn’t empty anymore, and it improves how quickly the user saw the initial UI. However, the data still needs to be fetched to display actual content.

![](images/what_s-new-in-react-19-vercel/img_005.jpg)![](images/what_s-new-in-react-19-vercel/img_006.jpg)![](images/what_s-new-in-react-19-vercel/img_007.jpg)![](images/what_s-new-in-react-19-vercel/img_008.jpg)

React frameworks stepped in to further improve the user experience with concepts like Static-Site Generation (SSG), which caches and renders dynamic data during the _build_, and Incremental Static Regeneration (ISR), which recaches and rerenders dynamic data on-demand.

This brings us to React Server Components (RSC). For the first time, native to React, we can fetch data _before_ the UI renders and displays to the user.

page.jsx

```tsx
export default async function Page() {

2  const res = await fetch("https://api.example.com/products");

3  const products = res.json();

4  return (

5    <>

6      <h1>Products</h1>

7      {products.map((product) => (

8        <div key={product.id}>

9          <h2>{product.title}</h2>

10          <p>{product.description}</p>

11        </div>

12      ))}

13    </>

14  );

15}
```

HTML served to the user is fully populated with actual content on the first render, and there is no need to fetch additional data or render a second time.

![](images/what_s-new-in-react-19-vercel/img_009.jpg)![](images/what_s-new-in-react-19-vercel/img_010.jpg)![](images/what_s-new-in-react-19-vercel/img_011.jpg)![](images/what_s-new-in-react-19-vercel/img_012.jpg)

Server Components are a big step forward for speed and performance, enabling a better developer and user experience. Learn more about [React Server Components](https://19.react.dev/reference/rsc/server-components#noun-labs-1201738-(2)).

_Credit to_ [_Josh W. Comeau_](https://www.joshwcomeau.com/) _for inspiration on the rendering diagrams._

[**Try Server Components**\\
\\
This Next.js App Router template lets you experience Server Components with just a few clicks.\\
\\
Deploy Now](https://vercel.com/templates/next.js/app-directory)

## New directives

Directives are not a React 19 feature, but they are related. With the introduction of React Server Components, bundlers need to distinguish where components and functions run. To accomplish this, there are two new directives to be aware of when creating React components:

- **`'use client'`** **marks code that runs only on the client.** Since Server Components are the default, you will add `'use client'` to Client Components when using hooks for interactivity and state.

- **`'use server'`** **marks server-side functions that can be called from client-side code.** You do _not_ need to add `'use server'` to Server Components, only Server Actions (more on that below). If you’d like to make sure a certain piece of code can only runs on the server, [you can use the `server-only` npm package](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns#keeping-server-only-code-out-of-the-client-environment).


Learn more about [Directives](https://19.react.dev/reference/rsc/directives#noun-labs-1201738-(2)).

## Actions

React 19 introduces Actions. These functions replace using event handlers and integrate with React transitions and concurrent features.

﻿

Actions can be used on both the client and server. For example, you can have a Client Action which replaces previous usage of `onSubmit` for a form.

﻿

Rather than needing to parse the event, the action is directly passed the `FormData`.

app.tsx

```jsx
import { useState } from "react";



export default function TodoApp() {

4  const [items, setItems] = useState([\
\
5    { text: "My first todo" },\
\
6  ]);



8  async function formAction(formData) {

9    const newItem = formData.get("item");

10    // Could make a POST request to the server to save the new item

11    setItems((items) => [...items, { text: newItem }]);

12  }



14  return (

15    <>

16      <h1>Todo List</h1>

17      <form action={formAction}>

18        <input type="text" name="item" placeholder="Add todo..." />

19        <button type="submit">Add</button>

20      </form>

21      <ul>

22        {items.map((item, index) => (

23          <li key={index}>{item.text}</li>

24        ))}

25      </ul>

26    </>

27  );

28}
```

### Server Actions

Going further, Server Actions allow Client Components to call async functions executed on the server. This provides additional advantages, like reading the file system or making direct database calls, removing the need for creating bespoke API endpoints for your UI.

Actions are defined with the `'use server'` directive and integrate with client-side components.

To call a Server Action in a Client Component, create a new file and import it:

actions.ts

```tsx
1'use server'



export async function create() {

4  // Insert into database

5}
```

todo-list.tsx

```tsx
1"use client";



import { create } from "./actions";



export default function TodoList() {

6  return (

7    <>

8      <h1>Todo List</h1>

9      <form action={create}>

10        <input type="text" name="item" placeholder="Add todo..." />

11        <button type="submit">Add</button>

12      </form>

13    </>

14  );

15}
```

Learn more about [Server Actions](https://19.react.dev/reference/rsc/server-actions).

## New hooks

To complement Actions, React 19 introduces three new hooks to make state, status, and visual feedback easier. These are particularly useful when working with forms, but they can also be used on other elements, like buttons.

### `useActionState`

This hook simplifies managing form states and form submissions. Using Actions, it captures form input data, handles validation, and error states, reducing the need for custom state management logic. The `useActionState` hook also exposes a `pending` state that can show a loading indicator while the action is being executed.

```tsx
1"use client";



import { useActionState } from "react";

import { createUser } from "./actions";



const initialState = {

7  message: "",

8};



export function Signup() {

11  const [state, formAction, pending] = useActionState(createUser, initialState);



13  return (

14    <form action={formAction}>

15      <label htmlFor="email">Email</label>

16      <input type="text" id="email" name="email" required />

17      {/* ... */}

18      {state?.message && <p aria-live="polite">{state.message}</p>}

19      <button aria-disabled={pending} type="submit">

20        {pending ? "Submitting..." : "Sign up"}

21      </button>

22    </form>

23  );

24}
```

Learn more about [`useActionState`](https://19.react.dev/reference/react/useActionState#noun-labs-1201738-(2)).

### `useFormStatus`

This hook manages the status of the last form submission, and it must be called from inside a component that is also inside a form.

```tsx
import { useFormStatus } from "react-dom";

import action from "./actions";



function Submit() {

5  const status = useFormStatus();

6  return <button disabled={status.pending}>Submit</button>;

7}



export default function App() {

10  return (

11    <form action={action}>

12      <Submit />

13    </form>

14  );

15}
```

While `useActionState` has a built-in `pending` status, `useFormStatus` is useful on its own when:

- There is no form state

- Creating shared form components

- There are multiple forms on the same page—`useFormStatus` will only return status information for a parent form


Learn more about [`useFormStatus`](https://19.react.dev/reference/react-dom/hooks/useFormStatus#noun-labs-1201738-(2)).

### `useOptimistic`

This hook lets you optimistically update the UI before the Server Action finishes executing, rather than waiting for the response. When the async action completes, the UI updates with the final state from the server.

The following example demonstrates optimistically adding a new message to a thread immediately, while the message is also sent to the Server Action for persistence.

```tsx
1"use client";



import { useOptimistic } from "react";

import { send } from "./actions";



export function Thread({ messages }) {

7  const [optimisticMessages, addOptimisticMessage] = useOptimistic(

8    messages,

9    (state, newMessage) => [...state, { message: newMessage }],

10  );



12  const formAction = async (formData) => {

13    const message = formData.get("message") as string;

14    addOptimisticMessage(message);

15    await send(message);

16  };



18  return (

19    <div>

20      {optimisticMessages.map((m, i) => (

21        <div key={i}>{m.message}</div>

22      ))}

23      <form action={formAction}>

24        <input type="text" name="message" />

25        <button type="submit">Send</button>

26      </form>

27    </div>

28  );

29}
```

Learn more about [`useOptimistic`](https://19.react.dev/reference/react/useOptimistic#noun-labs-1201738-(2)).

## New API: `use`

The `use` function offers first-class support for promises and context during rendering. Unlike other React Hooks, `use` can be called within loops, conditional statements, and early returns. Error handling and loading will be handled by the nearest Suspense boundary.

The following example shows a loading message while the cart items promise resolves.

```tsx
import { use } from "react";



function Cart({ cartPromise }) {

4  // `use` will suspend until the promise resolves

5  const cart = use(cartPromise);

6  return cart.map((item) => <p key={item.id}>{item.title}</p>);

7}



function Page({ cartPromise }) {

10  return (

11    /*{ ... }*/

12    // When `use` suspends in Cart, this Suspense boundary will be shown

13    <Suspense fallback={<div>Loading...</div>}>

14      <Cart cartPromise={cartPromise} />

15    </Suspense>

16  );

17}
```

This allows you to group components together so they render only when all the components’ data is available.

Learn more about [`use`](https://19.react.dev/reference/react/use).

## Preloading resources

React 19 adds several new APIs to improve page load performance and user experience by loading and preloading resources such as scripts, stylesheets, and fonts.

- [`prefetchDNS`](https://19.react.dev/reference/react-dom/prefetchDNS) prefetches the IP address of a DNS domain name you expect to connect to.

- [`preconnect`](https://19.react.dev/reference/react-dom/preconnect) connects to a server you expect to request resources from, even if the exact resources are unknown at the time.

- [`preload`](https://19.react.dev/reference/react-dom/preload) fetches a stylesheet, font, image, or external script that you expect to use.

- [`preloadModule`](https://19.react.dev/reference/react-dom/preloadModule) fetches an ESM module that you expect to use.

- [`preinit`](https://19.react.dev/reference/react-dom/preinit) fetches and evaluates an external script or fetches and inserts a stylesheet.

- [`preinitModule`](https://19.react.dev/reference/react-dom/preinitModule) fetches and evaluates an ESM module.


For example, this React code would result in the following HTML output. Note that links and scripts are prioritized and ordered by how early they should load, not based on the order they are used in React.

```tsx
1// React code

import { prefetchDNS, preconnect, preload, preinit } from "react-dom";



function MyComponent() {

5  preinit("https://.../path/to/some/script.js", { as: "script" });

6  preload("https://.../path/to/some/font.woff", { as: "font" });

7  preload("https://.../path/to/some/stylesheet.css", { as: "style" });

8  prefetchDNS("https://...");

9  preconnect("https://...");

10}
```

```html
1<!-- Resulting HTML -->

2<html>

3  <head>

4    <link rel="prefetch-dns" href="https://..." />

5    <link rel="preconnect" href="https://..." />

6    <link rel="preload" as="font" href="https://.../path/to/some/font.woff" />

7    <link

8      rel="preload"

9      as="style"

10      href="https://.../path/to/some/stylesheet.css"

11    />

12    <script async="" src="https://.../path/to/some/script.js"></script>

13  </head>

14  <body>

15    <!-- ... -->

16  </body>

17</html>
```

React frameworks frequently handle resource loading like this for you, so you might not have to call these APIs yourself.

Learn more about [Resource Preloading APIs](https://react.dev/reference/react-dom#resource-preloading-apis).

## Other improvements

### `ref` as a prop

There’s no need for `forwardRef` anymore. React will provide a codemod to make transitioning easier.

```tsx
function CustomInput({ placeholder, ref }) {

2  return <input placeholder={placeholder} ref={ref} />;

3}



5// ...



7<CustomInput ref={ref} />;
```

### `ref` callbacks

In addition to `ref` as a prop, refs can also return a callback function for cleanup. When a component unmounts, React will call the cleanup function.

```tsx
1<input

2  ref={(ref) => {

3    // ref created



5    // Return a cleanup function to reset

6    // ref when element is removed from DOM.

7    return () => {

8      // ref cleanup

9    };

10  }}

11/>;
```

### `Context` as a provider

There’s no need for `<Context.Provider>` anymore. You can use `<Context>` directly instead. React will provide a codemod to convert existing providers.

```tsx
const ThemeContext = createContext("");



function App({ children }) {

4  return <ThemeContext value="dark">{children}</ThemeContext>;

5}
```

### `useDeferredValue` initial value

An `initialValue` option has been added to `useDeferredValue`. When provided, `useDeferredValue` will use the value for the initial render and schedule a re-render in the background, returning the `deferredValue`.

```tsx
function Search({ deferredValue }) {

2  // On initial render the value is ''.

3  // Then a re-render is scheduled with the deferredValue.

4  const value = useDeferredValue(deferredValue, "");



6  return <Results value={value} />;

7}
```

### Document metadata support

React 19 will natively hoist and render title, link, and meta tags, even from nested components. There’s no need for third-party solutions to manage these tags anymore.

```tsx
function BlogPost({ post }) {

2  return (

3    <article>

4      <h1>{post.title}</h1>

5      <title>{post.title}</title>

6      <meta name="author" content="Jane Doe" />

7      <link rel="author" href="https://x.com/janedoe" />

8      <meta name="keywords" content={post.keywords} />

9      <p>...</p>

10    </article>

11  );

12}
```

### Stylesheet support

React 19 allows controlling stylesheet loading order with `precedence`. This makes colocating stylesheets near components easier, and React only loads them if they are used.

There are a few points to keep in mind:

- If you render the same component in multiple places within your application, React will deduplicate the stylesheet and only include it once in the document.

- When server-side rendering, React will include the stylesheet in the head. This ensures that the browser will not paint until it has loaded.

- If the stylesheet is discovered after streaming has started, React will ensure that the stylesheet is inserted into the `<head>` on the client before revealing the content that depends on that stylesheet through a Suspense boundary.

- During client-side rendering, React will wait for newly rendered stylesheets to load before committing the render.


```tsx
function ComponentOne() {

2  return (

3    <Suspense fallback="loading...">

4      <link rel="stylesheet" href="one" precedence="default" />

5      <link rel="stylesheet" href="two" precedence="high" />

6      <article>...</article>

7    </Suspense>

8  );

9}



function ComponentTwo() {

12  return (

13    <div>

14      <p>...</p>

15      {/* Stylesheet "three" below will be inserted between "one" and "two" */}

16      <link rel="stylesheet" href="three" precedence="default" />

17    </div>

18  );

19}
```

### Async scripts support

Render async scripts in any component. This makes colocating scripts near components easier, and React only loads them if they are used.

There are a few points to keep in mind:

- If you render the same component in multiple places within your application, React will deduplicate the script and only include it once in the document.

- When server-side rendering, async scripts will be included in the head and prioritized behind more critical resources that block paint, such as stylesheets, fonts, and image preloads.


```tsx
function Component() {

2  return (

3    <div>

4      <script async={true} src="..." />

5      // ...

6    </div>

7  );

8}



function App() {

11  return (

12    <html>

13      <body>

14        <Component>

15          // ...

16        </Component> // Won't duplicate script in the DOM

17      </body>

18    </html>

19  );

20}
```

### Custom Elements support

Custom Elements allow developers to define their own HTML elements as a part of the [Web Components](https://developer.mozilla.org/en-US/docs/Web/API/Web_components) specification. In previous versions of React, using Custom Elements has been difficult because React treats unrecognized props as attributes rather than properties.

React 19 adds full support for Custom Elements and passes all tests on [Custom Elements Everywhere](https://custom-elements-everywhere.com/).

### Better error reporting

Error handling improves by removing duplicate error messages.

![Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.](images/what_s-new-in-react-19-vercel/img_013.jpg)![Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.](images/what_s-new-in-react-19-vercel/img_014.jpg)

Previously, React would throw the error twice. Once for the original error, then a second time after failing to automatically recover, followed by information about the error.

![In React 19, the error is only displayed once.](images/what_s-new-in-react-19-vercel/img_015.jpg)![In React 19, the error is only displayed once.](images/what_s-new-in-react-19-vercel/img_016.jpg)

In React 19, the error is only displayed once.

Hydration errors improve by logging a single mismatch error instead of multiple errors. Error messages also include information on how to possibly fix the error.

![Example of a hydration error message in React 18.](images/what_s-new-in-react-19-vercel/img_017.jpg)![Example of a hydration error message in React 18.](images/what_s-new-in-react-19-vercel/img_018.jpg)

Example of a hydration error message in React 18.

![Example of an improved hydration error message in React 19.](images/what_s-new-in-react-19-vercel/img_019.jpg)![Example of an improved hydration error message in React 19.](images/what_s-new-in-react-19-vercel/img_020.jpg)

Example of an improved hydration error message in React 19.

Hydration errors when using third-party scripts and browser extensions also improve. Previously, elements inserted by third-party scripts or browser extensions would trigger a mismatch error. In React 19, unexpected tags in the head and body will be skipped over and will not throw an error.

Lastly, React 19 adds two new root options in addition to the existing `onRecoverableError`, to provide better clarity on why the error is happening.

- `onCaughtError` triggers when React catches an error in an Error Boundary.

- `onUncaughtError` triggers when an error is thrown and not caught by an Error Boundary.

- `onRecoverableError` triggers when an error is thrown and automatically recovered.


## Getting started with React 19 on Vercel

React 19 marks a significant evolution in the framework, introducing powerful new features and capabilities. These enhancements increase performance and offer a more seamless experience for developers and users alike.

The following frameworks make it easy to get started with React 19 today:

[**Astro**\\
\\
Deploy React 19 with Astro.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fastro&repository-name=react-19-astro) [**Next.js 15 RC**\\
\\
Deploy React 19 with Next.js 15 RC.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fnext.js&repository-name=react-19-nextjs) [**Vite**\\
\\
Deploy React 19 with Vite.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fvite&repository-name=react-19-vite) [**Waku**\\
\\
Deploy React 19 with Waku.\\
\\
▲ Deploy](https://vercel.com/new/clone?repository-url=https%3A%2F%2Fgithub.com%2Fvercel-labs%2Freact-19-on-vercel%2Ftree%2Fmain%2Fwaku&repository-name=react-19-waku)