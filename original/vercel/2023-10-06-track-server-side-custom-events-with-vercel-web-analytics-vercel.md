---
title: "Track server-side custom events with Vercel Web Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/track-server-side-custom-events-with-vercel-web-analytics"
date: "2023-10-06"
scraped_at: "2026-03-02T09:50:35.915505197+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Oct 6, 2023

Vercel Web Analytics now supports tracking custom events on the server-side, in addition to existing support for client-side tracking.

app/page.tsx

```jsx
import { track } from '@vercel/analytics/server';



export default function FeedbackPage() {

4  async function submitFeedback(data: FormData) {

5    'use server';



7    await track('Feedback', {

8      message: data.get('feedback') as string,

9    });

10  }



12  return (

13    <form action={submitFeedback}>

14      <input type="text" name="feedback" placeholder="Feedback" />

15      <button type="submit">Submit Feedback</button>

16    </form>

17  );

18}
```

Tracking a server-side event with a Server Action in Next.js.

Events can now be tracked from [Route Handlers](https://nextjs.org/docs/app/building-your-application/routing/route-handlers), [API Routes](https://nextjs.org/docs/pages/building-your-application/routing/api-routes), and [Server Actions](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations) when using Next.js (or other frameworks like SvelteKit and Nuxt) through the `track` function.

Custom event tracking is available for Pro and Enterprise users.

[Check out the documentation](https://vercel.com/docs/analytics/custom-events) to learn more.