---
title: "How Vercel adopted microfrontends - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-vercel-adopted-microfrontends"
date: "2024-10-22"
scraped_at: "2026-03-02T09:40:07.227532294+00:00"
language: "en"
translated: false
description: "Learn how Vercel cut build times and improved developer velocity while maintaining a smooth user experience with microfrontends."
---




Oct 22, 2024

Learn how Vercel cut build times and improved developer velocity while maintaining a smooth user experience with microfrontends.

Vercel's main website, once a single large Next.js application, serves both our website visitors and logged-in dashboard. But, as Vercel grew, this setup revealed opportunities for improvement. Build times grew, dependency management became more intricate, and workflows needed optimization. Minor changes triggered full builds, affecting isolated development and CI pipelines.

It was clear a change was needed.

By rethinking our architecture, we shifted to vertical microfrontends, leading to a simpler development experience and over a 40% improvement in preview build times and local development compilation. Streamlined dependencies by removing code for the other microfrontends also reduced page weight and boosted end-user performance, with gains in [Core Web Vitals](https://vercel.com/blog/how-core-web-vitals-affect-seo) like Largest Contentful Paint (LCP) and Interaction to Next Paint (INP).

Building on Vercel's support for microfrontends, this overhaul improved the developer experience (DX) and highlighted areas for further optimization. Through dogfooding a large-scale app migration, our shift revealed new ways to streamline the platform for all users. While this blog shares our journey, it also shows where we can smooth the process for everyone. As we continue refining, we’re also making single applications build faster—enabling even greater DX without compromising end-user performance.

Let's look at how we did it.

### Leveraging Turbo

Our first step was to focus on improving local compilation, build times, and CI workflows. Vercel’s monorepo is powered by [Turborepo](https://turbo.build/repo/docs), which allowed us to optimize tasks with features like [Vercel Remote Cache](https://vercel.com/docs/monorepos/remote-caching#vercel-remote-cache) and [**`--affected`**](https://turbo.build/repo/docs/reference/run#--affected). Adopting [Turbopack](https://turbo.build/pack/docs) provided a great speed improvement for local development.

But as we made these improvements, we realized the single-app model was also no longer necessary for Vercel.com. Logical splits within the application meant we could avoid unnecessary work on every build and compile, delivering even more major developer velocity gains.

### Weighing a horizontal or vertical split

Microfrontends offer a way to break down large applications into smaller, independent units, allowing parallel development across product areas and engineering teams. While single applications are cohesive, microfrontends help address scaling issues as both applications and organizations grow. There are two main strategies:

- **Vertical microfrontends:** Split by path, where each page is handled by a single app

- **Horizontal microfrontends:** Split by features, where multiple applications run on the same page


![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_001.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_002.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_003.jpg)![Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).](images/how-vercel-adopted-microfrontends-vercel/img_004.jpg)Two common approaches to microfrontends: Multiple microfrontends within a single page (horizontal split) or having a single microfrontend manage an entire page (vertical split).

There is no right or wrong answer, and each has its trade-offs. Each approach can deliver substantial benefits depending on the use case. Luca Mezzalira's [book on microfrontends](https://www.buildingmicrofrontends.com/) is a good resource on this topic.

Vertical splits offer cohesion, but may cause hard navigations when switching between applications supported by different microfrontends. Techniques like prefetching and APIs like [Chromium’s Speculation Rules](https://developer.chrome.com/docs/web-platform/prerender-pages) can help, but come with limitations, such as increased resource usage and limited browser support.

With horizontal splits, testing, releasing, monitoring, and debugging become more complex, as multiple microfrontends operate on the same page.

We adopted **vertical microfrontends**—splitting the app into logical sections users rarely cross—to reduce build times and simplify dependencies, all while maintaining a unified monorepo.

[**Deploy microfrontends on Vercel**\\
\\
Vercel makes it easy to deploy vertical microfrontends. Learn whether Next.js Multi-Zones can work for you.\\
\\
View template](https://vercel.com/templates/next.js/microfrontends)

Early tests showed this approach could halve build times and streamline ownership across both development and production, giving developers the feel of working on a single application.

### Our migration path

The next step was migrating our monolithic frontend app into smaller vertical applications without disrupting development or the user experience. We broke the application down into three core areas:

- marketing

- documentation

- logged-in dashboard


These areas were naturally distinct. Users don't frequently cross between them, and they maintain distinct user interfaces, making them ideal for separation.

![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_005.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_006.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_007.jpg)![Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.](images/how-vercel-adopted-microfrontends-vercel/img_008.jpg)Users experience soft navigations within a single microfrontend and hard navigations when moving between microfrontends.

Since we use [Next.js](https://nextjs.org/), we used the [Next.js Multi-Zones](https://nextjs.org/docs/app/building-your-application/deploying/multi-zones) feature, which supports vertical microfrontends.

Incremental migration was a priority for us. We opted to create brand new applications, instead of forking the original codebase. Forking seemed easier on the surface, but would have introduced risks. Shared components like headers, footers, and design systems would need to be duplicated and maintained across multiple repositories, leading to synchronization issues and potential inconsistencies.

By continuing with the monorepo, and centralizing code into `packages` within the monorepo, we ensured consistency of the shared components while still easily, gradually breaking out key areas. Tools like [Turborepo](https://turbo.build/repo/docs) and [Dependency Cruiser](https://github.com/sverweij/dependency-cruiser) helped simplify this process.

![Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.](images/how-vercel-adopted-microfrontends-vercel/img_009.jpg)![Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.](images/how-vercel-adopted-microfrontends-vercel/img_010.jpg)Vercel's monorepo is structured with independent microfrontends in the "apps" folder, while shared packages are promoted for seamless access across all apps.

Using [feature flags](https://vercel.com/docs/workflow-collaboration/feature-flags), we were able to incrementally route traffic from the still-live monolithic frontend app to the new microfrontends. This allowed us to minimize risk and validate performance improvements before removing the old code. When the new page had been serving traffic for at least a week without error, we removed the code from the existing application, incrementally reducing the dependencies and build times.

![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_011.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_012.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_013.jpg)![During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.](images/how-vercel-adopted-microfrontends-vercel/img_014.jpg)During incremental migration, the page exists in both the original frontend monolith and the new microfrontend. Feature flags control routing until the microfrontend version goes fully live.

With this monorepo setup and vertical split approach, we felt confident and in control. We were able to move very quickly while preserving consistency, reducing build times, and keeping app development simple.

### Lessons learned and managing the trade-offs

After the successful adoption of microfrontends for Vercel.com, we expanded the same approach to other sites like the [2024 Next.js Conf](https://nextjs.org/conf) page, which runs as a separate application from [nextjs.org](https://nextjs.org/). With this infrastructure, we could extract distinct areas into independent applications, speeding up development cycles as the Next.js Conf team and Next.js development teams could iterate quickly and independently.

That said, there were challenges. We encountered some issues and worked on ensuring performance didn’t regress, specifically using tools like [Speed Insights](https://vercel.com/docs/speed-insights) to monitor real world usage and [Vercel Toolbar](https://vercel.com/docs/workflow-collaboration/vercel-toolbar) for layout shift and interaction timing alerts.

We recognized early on that testing microfrontends locally and in previews was challenging. Features like [Draft Mode](https://vercel.com/docs/workflow-collaboration/draft-mode) didn't work correctly, and performance bottlenecks—like hard navigations—were known issues. To resolve these issues we adopted strategies likes prefetching and prerendering using Chromium’s Speculation Rules.

**An example of overcoming trade-offs:**

To reduce the impact of hard navigations, we start by downloading the initial page's resources (JavaScript and CSS) to prime the browser cache as soon as a link becomes visible. This means when a user navigates, those assets load from the cache. However, the page still requires rendering and fetching remaining assets, like HTML.

We take it a step further by prerendering pages when the user interacts (e.g. tapping a link). This renders the page in the background, including all network requests and processing, so when the user arrives, it feels instantaneous. This approach balances performance with resource usage—only prefetching and prerendering at the right time to avoid overloading the device while still delivering the desired experience.

![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_015.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_016.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_017.jpg)![Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.](images/how-vercel-adopted-microfrontends-vercel/img_018.jpg)Pages prerender or prefetch on user interaction, delivering smooth navigation while optimizing performance and resource use.

### Looking ahead

With the improvements in iteration speed, we're doubling down on enhancing microfrontends across the platform. Our focus is on refining routing, streamlining the preview workflow, and optimizing hard navigation performance. We’re also enhancing the dashboard experience and addressing workflow challenges to improve microfrontend development from start to finish.

The shift to vertical microfrontends has greatly improved developer velocity and cut build times. Teams now work more independently while staying aligned through shared packages, creating a system that balances autonomy with unified development.

As we continue to refine this architecture, we’re excited about its potential. Whether you’re exploring microfrontends—or sticking with a single application—Vercel is committed to ensuring the best possible developer experience.

[**Learn how microfrontends with Vercel can help your DX**\\
\\
Running into developer velocity issues scaling your application? Talk to experts who can help you understand whether microfrontends can help improve your DX.\\
\\
Contact Us](https://vercel.com/contact/sales)