---
title: "Track server-side custom events with Vercel Web Analytics - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/track-server-side-custom-events-with-vercel-web-analytics"
date: "2023-10-06"
scraped_at: "2026-03-02T09:50:35.915505197+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

Oct 6, 2023

2023 年 10 月 6 日

Vercel Web Analytics now supports tracking custom events on the server-side, in addition to existing support for client-side tracking.

Vercel Web Analytics 现已支持在服务端跟踪自定义事件，此外仍保留对客户端跟踪的现有支持。

app/page.tsx

app/page.tsx

```jsx
import { track } from '@vercel/analytics/server';



export default function FeedbackPage() {

4  async function submitFeedback(data: FormData) {

5    'use server';



7    await track('Feedback', {
```

8      message: data.get('feedback') as string,

8      message: data.get('feedback') 作为字符串,

9    });

9    });

10  }

10  }

12  return (

12  return (

13    <form action={submitFeedback}>

13    <form action={submitFeedback}>

14      <input type="text" name="feedback" placeholder="Feedback" />

14      <input type="text" name="feedback" placeholder="反馈" />

15      <button type="submit">Submit Feedback</button>

15      <button type="submit">提交反馈</button>

16    </form>

16    </form>

17  );

17  );

18}
```

在 Next.js 中使用 Server Action 跟踪服务端事件。

现在，通过 `track` 函数，你可以在 Next.js（或其他类似框架，如 SvelteKit 和 Nuxt）中，从 [路由处理器（Route Handlers）](https://nextjs.org/docs/app/building-your-application/routing/route-handlers)、[API 路由（API Routes）](https://nextjs.org/docs/pages/building-your-application/routing/api-routes) 以及 [服务端操作（Server Actions）](https://nextjs.org/docs/app/building-your-application/data-fetching/forms-and-mutations) 中跟踪事件。

自定义事件跟踪功能仅面向 Pro 和 Enterprise 用户开放。

[查看文档](https://vercel.com/docs/analytics/custom-events) 了解更多信息。