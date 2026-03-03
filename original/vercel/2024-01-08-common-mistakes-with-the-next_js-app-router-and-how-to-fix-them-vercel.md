---
title: "Common mistakes with the Next.js App Router and how to fix them - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/common-mistakes-with-the-next-js-app-router-and-how-to-fix-them"
date: "2024-01-08"
scraped_at: "2026-03-02T09:48:39.372324639+00:00"
language: "en"
translated: false
description: "Learn how to use the Next.js App Router more effectively and understand the new model."
---




Jan 8, 2024

After talking to hundreds of developers and looking at thousands of Next.js repositories, I've noticed ten common mistakes when building with the Next.js App Router.

This post will share why these mistakes can happen, how to fix them, and some tips to help you understand the new App Router model.

## Using Route Handlers with Server Components

Consider the following code for a Server Component:

app/page.tsx

```tsx
export default async function Page() {

2  let res = await fetch('http://localhost:3000/api/data');

3  let data = await res.json();

4  return <h1>{JSON.stringify(data)}</h1>;

5}
```

Fetching JSON data from a Route Handler in a Server Component.

This `async` component makes a request to a Route Handler to retrieve some JSON data:

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  return Response.json({ data: 'Next.js' });

3}
```

A Route Handler that returns static JSON data.

There's two main issues with this approach:

1. Both [Route Handlers](https://nextjs.org/docs/app/building-your-application/routing/route-handlers) and [Server Components](https://nextjs.org/docs/app/building-your-application/rendering/server-components) run securely on the server. You don't need the additional network hop. Instead, you can call whatever logic you intended to place inside the Route Handler directly in the Server Component. This might be an external API or any `Promise`.

2. Since this code is running on the server with Node.js, we need to provide the absolute URL for the `fetch` versus a relative URL. In reality, we wouldn't hardcode `localhost` here, but instead need to have some conditional check based on the environment we're in. This is unnecessary since you can call the logic directly.


Instead, prefer to do the following:

app/page.tsx

```tsx
export default async function Page() {

2  // call your async function directly

3  let data = await getData(); // { data: 'Next.js' }

4  // or call an external API directly

5  let data = await fetch('https://api.vercel.app/blog')

6  // ...

7}
```

Server Components are able to fetch data directly.

## Static or dynamic Route Handlers

Route Handlers are cached by default when using the `GET` method. This can often be confusing for existing Next.js developers moving from the Pages Router and API Routes.

For example, the following code will be prerendered during `next build`:

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  return Response.json({ data: 'Next.js' });

3}
```

A Route Handler that returns static JSON data.

This JSON data will not change until another build has completed. Why is that?

You can consider Route Handlers the building blocks of pages. For a given request to a route, you want to handle it. Next.js has further abstractions on top of Route Handlers like pages and layouts. This is why Route Handlers are [static by default](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#caching) (like pages) and share the same [route segment configuration](https://nextjs.org/docs/app/api-reference/file-conventions/route-segment-config) options.

This functionality unlocks some new features previously not possible with API Routes in the Pages Router. For example, you can have Route Handlers that produce JSON, or `txt` files, or really _any_ file, which can be computed and prerendered during the build. The statically generated file is then automatically cached, and even [periodically updated](https://nextjs.org/docs/app/building-your-application/routing/route-handlers#revalidating-cached-data) if desired.

app/api/data/route.ts

```tsx
export async function GET(request: Request) {

2  let res = await fetch('https://api.vercel.app/blog');

3  let data = await res.json();

4  return Response.json(data);

5}
```

Return a list of blog posts as JSON data.

Further, this means the Route Handlers are compatible with [Static Exports](https://nextjs.org/docs/app/building-your-application/deploying/static-exports) where you can deploy your Next.js application anywhere that supports static file hosting.

## Route Handlers and Client Components

You might think you need to use Route Handlers with Client Components, since they cannot be marked `async` and fetch or mutate data. Rather than needing to write a `fetch` and create a Route Handler, you can instead call [Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) directly from Client Components.

app/user-form.tsx

```tsx
1'use client';



import { save } from './actions';



export function UserForm() {

6  return (

7    <form action={save}>

8      <input type="text" name="username" />

9      <button>Save</button>

10    </form>

11  );

12}
```

A form and input to save a name.

This works with both forms as well as event handlers:

app/user-form.tsx

```tsx
1'use client';



import { save } from './actions';



export function UserForm({ username }) {

6  async function onSave(event) {

7    event.preventDefault();

8    await save(username);

9  }



11  return <button onClick={onSave}>Save</button>;

12}
```

Server Actions can be called from event handlers.

## Using Suspense with Server Components

Consider the following Server Component. Where should Suspense be placed to define what fallback UI will be shown while the data is being fetched?

app/page.tsx

```tsx
async function BlogPosts() {

2  let data = await fetch('https://api.vercel.app/blog');

3  let posts = await data.json();

4  return (

5    <ul>

6      {posts.map((post) => (

7        <li key={post.id}>{post.title}</li>

8      ))}

9    </ul>

10  );

11}



export default function Page() {

14  return (

15    <section>

16      <h1>Blog Posts</h1>

17      <BlogPosts />

18    </section>

19  );

20}
```

A page which contains an async component with data fetching.

If you guessed inside of the `Page` component, you were correct. The `Suspense` boundary needs to be placed higher than the `async` component doing the data fetching. It will not work if the boundary is inside of the `async` component.

app/page.tsx

```tsx
import { Suspense } from 'react';



async function BlogPosts() {

4  let data = await fetch('https://api.vercel.app/blog');

5  let posts = await data.json();

6  return (

7    <ul>

8      {posts.map((post) => (

9        <li key={post.id}>{post.title}</li>

10      ))}

11    </ul>

12  );

13}



export default function Page() {

16  return (

17    <section>

18      <h1>Blog Posts</h1>

19      <Suspense fallback={<p>Loading...</p>}>

20        <BlogPosts />

21      </Suspense>

22    </section>

23  );

24}
```

Using Suspense with React Server Components.

In the future with Partial Prerendering, this pattern will start to become more common, including defining which components should be prerendered and which should run on-demand.

```tsx
import { unstable_noStore as noStore } from 'next/cache';



async function BlogPosts() {

4  noStore(); // This component should run dynamically

5  let data = await fetch('https://api.vercel.app/blog');

6  let posts = await data.json();

7  return (

8    <ul>

9      {posts.map((post) => (

10        <li key={post.id}>{post.title}</li>

11      ))}

12    </ul>

13  );

14}
```

Opt-into dynamic rendering inside async components.

## Using the incoming request

Since the incoming request object [is not able to be accessed](https://nextjs.org/docs/app#how-can-i-access-the-request-object-in-a-layout) from a Server Component, it might not be obvious how to read parts of the incoming request. This could lead to using client hooks like `useSearchParams` unnecessarily.

There are specific functions and props to the Server Component which allow you to access the incoming request. For example:

- [`cookies()`](https://nextjs.org/docs/app/api-reference/functions/cookies)

- [`headers()`](https://nextjs.org/docs/app/api-reference/functions/headers)

- [`params`](https://nextjs.org/docs/app/api-reference/file-conventions/page#params-optional)

- [`searchParams`](https://nextjs.org/docs/app/api-reference/file-conventions/page#searchparams-optional)


app/blog/\[slug\]/page.tsx

```tsx
export default function Page({

2  params,

3  searchParams,

4}: {

5  params: { slug: string }

6  searchParams: { [key: string]: string | string[] | undefined }

7}) {

8  return <h1>My Page</h1>

9}
```

Reading parts of the URL and the search parameters.

## Using Context providers with App Router

You might want to use [React Context](https://react.dev/reference/react/hooks#context-hooks) or are using an external dependency which relies on context. Two common mistakes I've seen are trying to use context with Server Components (unsupported) and the placement of the provider in the App Router.

To allow for your Server and Client Components to interleave, it's important to make your provider (or multiple providers) be a separate Client Component which takes `children` as a prop and renders them. For example:

app/theme-provider.tsx

```tsx
1'use client';



import { createContext } from 'react';



export const ThemeContext = createContext({});



export default function ThemeProvider({

8  children,

9}: {

10  children: React.ReactNode;

11}) {

12  return <ThemeContext.Provider value="dark">{children}</ThemeContext.Provider>;

13}
```

A Client Component that uses React Context.

Then, with your provider in a separate file as a Client Component, you can import and use this component inside of your layout:

app/layout.tsx

```tsx
import ThemeProvider from './theme-provider';



export default function RootLayout({

4  children,

5}: {

6  children: React.ReactNode;

7}) {

8  return (

9    <html>

10      <body>

11        <ThemeProvider>{children}</ThemeProvider>

12      </body>

13    </html>

14  );

15}
```

A root layout that weaves a client context provider and Server Component children.

With the provider rendered at the root, all other Client Components throughout your app will be able to consume this context. And notably, this configuration still allows for other Server Components (including the `page`) lower in the tree.

## Using Server and Client Components together

Many React and Next.js developers are learning how to use Server and Client Components for the first time. It's expected there might be some mistakes and opportunities to learn this new model!

For example, consider the following page:

app/page.tsx

```tsx
export default function Page() {

2  return (

3    <section>

4      <h1>My Page</h1>

5    </section>

6  );

7}
```

A Server Component page.

This is a Server Component. While that comes with new functionality like being able to [fetch data directly in the component](https://nextjs.org/docs/app/building-your-application/data-fetching/fetching-caching-and-revalidating), it also means certain client-side React [functionalities aren't available](https://nextjs.org/docs/app/building-your-application/rendering/composition-patterns).

For example, consider creating a button that is a counter. This would need to be a new Client Component file marked with the `"use client"` directive at the top:

app/counter.tsx

```tsx
1'use client';



import { useState } from 'react';



export function Counter() {

6  const [count, setCount] = useState(0);

7  return (

8    <div>

9      <p>Count: {count}</p>

10      <button onClick={() => setCount(count + 1)}>Increment</button>

11    </div>

12  );

13}
```

A Client Component button that increments a count.

You can then import and use this component in your page:

app/page.tsx

```tsx
import { Counter } from './counter';



export default function Page() {

4  return (

5    <section>

6      <h1>My Page</h1>

7      <Counter />

8    </section>

9  );

10}
```

Using a Client Component from a Server Component.

The page is a Server Component and the `<Counter>` is a Client Component. Great! What about components lower in the tree than the counter? Can those be Server Components? Yes, through composition:

app/page.tsx

```tsx
import { Counter } from './counter';



function Message() {

4  return <p>This is a Server Component</p>;

5}



export default function Page() {

8  return (

9    <section>

10      <h1>My Page</h1>

11      <Counter>

12        <Message />

13      </Counter>

14    </section>

15  );

16}
```

Children of a Client Component can be Server Components.

Children of a Client Component can be a Server Component! Here's the updated counter:

app/counter.tsx

```tsx
1'use client';



import { useState } from 'react';



export function Counter({ children }: { children: React.ReactNode }) {

6  const [count, setCount] = useState(0);

7  return (

8    <div>

9      <p>Count: {count}</p>

10      <button onClick={() => setCount(count + 1)}>Increment</button>

11      {children}

12    </div>

13  );

14}
```

The counter now accepts children and displays them.

## Adding `“use client”` unnecessarily

Building off the previous example, does that mean that we need to add the `"use client"` directive everywhere?

When the `"use client"` directive is added, you pass into the "client boundary" giving you the ability to run client-side JavaScript (i.e. using React hooks or state). Client Components are still [prerendered on the server](https://github.com/reactwg/server-components/discussions/4), similar to components in the Next.js Pages Router.

Since you're already in the client boundary, siblings of the `<Counter>` would become Client Components. You don't need to add `"use client"` to every file. This might be an approach taken for [incremental adoption of the App Router](https://nextjs.org/docs/app/building-your-application/upgrading/app-router-migration), where a component high up the tree becomes a Client Component and it becomes weave child Server Components further down.

## Not revalidating data after mutations

The Next.js App Router includes a complete model for [fetching, caching, and revalidating data](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations). As developers are still learning this new model, and we're continuing to make improvements based on their feedback, one common mistake I've seen is forgetting to revalidate data after a mutation.

For example, consider the following Server Component. It displays a form, which uses a [Server Action](https://nextjs.org/docs/app/building-your-application/data-fetching/server-actions-and-mutations) to handle the submission and create a new entry in a [Postgres database](https://vercel.com/docs/storage/vercel-postgres).

app/page.tsx

```tsx
export default function Page() {

2  async function create(formData: FormData) {

3    'use server';



5    let name = formData.get('name');

6    await sql`INSERT INTO users (name) VALUES (${name})`;

7  }



9  return (

10    <form action={create}>

11      <input name="name" type="text" />

12      <button type="submit">Create</button>

13    </form>

14  );

15}
```

A Server Action that inserts the name into a Postgres database.

After the form is submitted and the insertion happens successfully, would the data displaying the list of names automatically update? No, not unless we tell Next.js to. For example:

app/page.tsx

```tsx
import { revalidatePath } from 'next/cache';



export default async function Page() {

4  let names = await sql`SELECT * FROM users`;



6  async function create(formData: FormData) {

7    'use server';



9    let name = formData.get('name');

10    await sql`INSERT INTO users (name) VALUES (${name})`;



12    revalidatePath('/');

13  }



15  return (

16    <section>

17      <form action={create}>

18        <input name="name" type="text" />

19        <button type="submit">Create</button>

20      </form>

21      <ul>

22        {names.map((name) => (

23          <li>{name}</li>

24        ))}

25      </ul>

26    </section>

27  );

28}
```

Revalidating data inside of a Server Action.

## Redirects inside of try/catch blocks

When running server-side code, like a Server Component or a Server Action, you might want to [redirect](https://nextjs.org/docs/app/api-reference/functions/redirect) if a resource is not available or after a successful mutation.

The `redirect()` function does not require you to use `return redirect()` as it uses the TypeScript [`never`](https://www.typescriptlang.org/docs/handbook/2/functions.html#never) type. Further, internally this function throws a Next.js specific error. This means you should handle redirecting outside of try/catch blocks.

For example, if you are trying to redirect inside of a Server Component, it might look like this:

app/page.tsx

```tsx
import { redirect } from 'next/navigation';



async function fetchTeam(id) {

4  const res = await fetch('https://...');

5  if (!res.ok) return undefined;

6  return res.json();

7}



export default async function Profile({ params }) {

10  const team = await fetchTeam(params.id);

11  if (!team) {

12    redirect('/login');

13  }



15  // ...

16}
```

Redirecting from a Server Component.

Alternatively, if you're trying to redirect from a Client Component, this should happen inside of a Server Action and not in an event handler:

app/client-redirect.tsx

```tsx
1'use client';



import { navigate } from './actions';



export function ClientRedirect() {

6  return (

7    <form action={navigate}>

8      <input type="text" name="id" />

9      <button>Submit</button>

10    </form>

11  );

12}
```

Redirecting in a Client Component through a Server Action.

app/actions.ts

```tsx
1'use server';



import { redirect } from 'next/navigation';



export async function navigate(data: FormData) {

6  redirect('/posts');

7}
```

A Server Action that redirects to a new route.

## Conclusion

The Next.js App Router is a new approach for building React applications and there's a handful of new concepts to learn. If you've made any of these mistakes, don't feel discouraged. I've made them as well learning how the model works.

If you want to keep learning more and apply this knowledge, check out our [Next.js Learn course](https://nextjs.org/learn) to build a real dashboard application with the App Router.