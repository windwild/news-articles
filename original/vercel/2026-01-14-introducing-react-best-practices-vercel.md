---
title: "Introducing: React Best Practices - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-react-best-practices"
date: "2026-01-14"
scraped_at: "2026-03-02T09:22:44.811176138+00:00"
language: "en"
translated: false
description: "We've encapsulated 10+ years of React and Next.js optimization knowledge into react-best-practices, a structured repository optimized for AI agents and LLMs. "
---




Jan 14, 2026

We've encapsulated 10+ years of React and Next.js optimization knowledge into [`react-best-practices`](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices), a structured repository optimized for AI agents and LLMs.

![](images/introducing-react-best-practices-vercel/img_001.jpg)![](images/introducing-react-best-practices-vercel/img_002.jpg)![](images/introducing-react-best-practices-vercel/img_003.jpg)![](images/introducing-react-best-practices-vercel/img_004.jpg)

React performance work is usually, well, reactive. A release goes out, the app feels slower, and the team starts chasing symptoms. That’s expensive, and it’s easy to optimize the wrong thing.

We’ve seen the same root causes across production codebases for more than a decade:

- Async work that accidentally becomes sequential

- Large client bundles that grow over time

- Components that re-render more than they need to


The “why” here is simple: these aren’t micro-optimizations. They show up as waiting time, jank, and repeat costs that hit every user session.

So, we put together this React best practices framework to make those problems easier to spot and faster to fix.

### The core idea: ordering

Most performance work fails because it starts too low in the stack.

If a request waterfall adds 600ms of waiting time, it doesn’t matter how optimized your `useMemo` calls are. If you ship an extra 300KB of JavaScript on every page, shaving a few microseconds off a loop won’t matter.

Performance work also compounds. A small regression you ship today becomes a long-term tax on every session until someone pays down the debt.

So the framework starts with the two fixes that usually move real-world metrics first:

1. Eliminate waterfalls

2. Reduce bundle size


Then it moves on to server-side performance, client-side fetching, and re-render optimization.

It includes 40+ rules across 8 categories, ordered by impact, from CRITICAL (eliminating waterfalls, reducing bundle size) to incremental (advanced patterns). ‍​‌ ‌ ‌

## What else is inside?

The repository covers eight performance categories:

- Eliminating async waterfalls

- Bundle size optimization

- Server-side performance

- Client-side data fetching

- Re-render optimization

- Rendering performance

- Advanced patterns

- JavaScript performance


Each rule includes an impact rating (CRITICAL to LOW) to help prioritize fixes, plus code examples showing what breaks and how to fix it.

For example, here’s a common pattern that blocks unused code:

_Incorrect (blocks both branches):_

```typescript
async function handleRequest(userId: string, skipProcessing: boolean) {

2  const userData = await fetchUserData(userId)



4  if (skipProcessing) {

5    // Returns immediately but still waited for userData

6    return { skipped: true }

7  }



9  // Only this branch uses userData

10  return processUserData(userData)

11}
```

_Correct (only blocks when needed):_

```typescript
async function handleRequest(

2  userId: string,

3  skipProcessing: boolean

4) {

5  if (skipProcessing) {

6    return { skipped: true }

7  }



9  const userData = await fetchUserData(userId)

10  return processUserData(userData)

11}


```

Individual rule files compile into `AGENTS.md`, a single document that your agents can query when reviewing code or suggesting optimizations. It’s designed to be followed consistently, including by AI agents doing refactors, so teams can apply the same decisions across a large codebase.

## How these practices were collected

These aren’t theoretical. They come from real performance work on production codebases.

A few examples:

![](images/introducing-react-best-practices-vercel/img_005.jpg)![](images/introducing-react-best-practices-vercel/img_006.jpg)

**Combining loop iterations**

A chat page was scanning the same list of messages eight separate times. We combined it into a single pass, which adds up when you have thousands of messages.

**Parallelizing awaits**

An API was waiting for one database call to finish before starting the next, even though they didn’t depend on each other. Running them at the same time cut the total wait in half.

**Lazy State Initialization**

A component was parsing a JSON config from `localStorage` on every render, even though it only needed it once for state initialization. Wrapping the it in a callback (`useState(() => JSON.parse(...))`) eliminated wasted work.

### Using `react-best-practices` in your coding agent

These best practices are also packaged up as [Agent Skills](https://github.com/vercel-labs/agent-skills) that install into Opencode, Codex, Claude Code, Cursor, and other coding agents. When your agent spots cascading `useEffect` calls or heavy client-side imports, it can reference these patterns and suggest fixes.

```bash
npx skills add vercel-labs/agent-skills
```

Check out the [`react-best-practices`](https://github.com/vercel-labs/agent-skills/tree/main/skills/react-best-practices) repository.