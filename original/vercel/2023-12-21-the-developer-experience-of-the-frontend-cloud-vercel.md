---
title: "The developer experience of the Frontend Cloud - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud"
date: "2023-12-21"
scraped_at: "2026-03-02T09:48:52.978804228+00:00"
language: "en"
translated: false
description: "Vercel's Frontend Cloud offers a complete Developer Experience (DX) Platform, to automate complex systems and offer best-in-market iteration velocity."
---




Dec 21, 2023

Part 3 of the developer's guide to a future-proofed stack.

In a large team, creating new code should never be scary. Finding where to place code shouldn't be difficult. And _deploying_ new code certainly shouldn't break anything.

**Ideally, your codebase feels transparent: easy to create, adjust, and monitor.**

The Frontend Cloud offers a complete [Developer Experience (DX) Platform](https://vercel.com/products/dx-platform), so you don't have to spend so much developer time curating and maintaining systems that can be easily automated.

Instead, you get centrally-located and collaborative tooling—Git-based workflows with automatic staging environments and more—where you can easily leverage the self-serve tools in front of you that just work by default.

[**The web's Developer Experience Platform**\\
\\
Traditional deployment tools weren’t built for Frontend development. Get the DX Platform that has teams shipping 6x faster.\\
\\
Explore the Product](https://vercel.com/products/dx-platform)

## Git-based workflow

Vercel's Frontend Cloud uses [framework-defined infrastructure (FdI)](https://vercel.com/blog/framework-defined-infrastructure) to automatically transform your [framework code](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-fit-your-frontend-into-a-framework) into a globally served application. But how do you integrate your existing codebase with the Frontend Cloud?

The answer turns out to be straightforward: GitHub ( [or any Git version control provider](https://vercel.com/docs/deployments/git)). Adding your repo to the Frontend Cloud is as easy as [adding an integration on GitHub](https://vercel.com/docs/getting-started-with-vercel/import).

The simple steps to deploy your code onto the Frontend Cloud.

This allows for immutable, persistent infrastructure provisioned for every single `git push` any developer makes within your codebase. Because of [serverless architecture's ability to scale to zero](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#what-is-serverless-architecture), these deployments don't take up resources when unused.

The best part is that each deployment, when visited, exists in **true-to-production conditions**, with access to [the Frontend Cloud’s global infrastructure](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#vercel's-edge-network).

Any code you push to any branch can therefore be observed as its own unique deployment.

## Observability

![The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_001.jpg)![The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_002.jpg)The frontend cloud gives you updates about your application's speed for your actual user base—in realtime.

Crucial to application transparency is the ability to see how your deployed code is performing _in realtime for your actual users_. The Frontend Cloud gives centrally-located tools to [monitor usage](https://vercel.com/docs/observability/monitoring), [track performance](https://vercel.com/docs/speed-insights), and [decipher user traffic](https://vercel.com/docs/analytics)—all in service of helping you make better decisions and iterate faster.

You also have access to a [robust integration marketplace](https://vercel.com/integrations) to quickly plug in observability tools you may already be using.

Keep in mind that all these tools are available, like everything else, on a _per-deployment_ basis. This makes [experimentation far easier to maintain](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release) and keeps the focus on the developer, who wants to see how a specific change affects the application.

![Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_003.jpg)![Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_004.jpg)Custom (and saveable) monitoring queries mean you can visualize data from any deployment in all the detail you need.

This level of code transparency means bugs are easy to find, and with the Frontend Cloud’s [focus on developer velocity](https://vercel.com/blog/iterating-from-design-to-deploy), they’re also quick to fix. Code should never be a mystery, and everyone on your team—developer or not—should have easy access to the iteration process.

## Collaboration

Within the Frontend Cloud, role-based access to secure deployments is managed from a central dashboard, where you can see vital information about all branches, merges, and pushes of your repo, as well as the deployments themselves.

Since there’s production infrastructure for each deployment, accessing that deployment is as simple as navigating to its automatically provisioned URL.

The power of this can’t be understated: Any unreleased version of your application—or an experiment or side project—can instantly be shared with whichever team members or external clients need to see it in a true-to-production environment.

![The frontend cloud brings the feedback cycle right to the relevant page of your application.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_005.jpg)![The frontend cloud brings the feedback cycle right to the relevant page of your application.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_006.jpg)The frontend cloud brings the feedback cycle right to the relevant page of your application.

Plus, that environment comes with more features, such as:

- [Figma-like commenting](https://vercel.com/docs/workflow-collaboration/comments) tied directly to DOM elements on the deployment. Feedback—from technical and non-technical stakeholders alike—can be addressed directly on the real webpage and converted to tickets in Slack, Linear, or Jira. They can also optionally [block further deployments](https://vercel.com/docs/workflow-collaboration/comments/integrations).

- The ability to [see even unpublished CMS content](https://vercel.com/docs/workflow-collaboration/draft-mode).

- [Direct-on-page (WYSIWYG) editing](https://vercel.com/docs/workflow-collaboration/visual-editing) of CMS content.


In the Frontend Cloud, the [iteration process is truly collaborative](https://vercel.com/blog/iterating-from-design-to-deploy), with all stakeholders having access exactly as they need.

> “Comments have greatly improved our feedback process both internally among our marketers and designers and externally with our global clients—everything happens in the Preview and nothing gets lost in screenshots being sent back and forth.Comments have greatly improved our feedback process both internally among our marketers and designers and externally with our global clients—everything happens in the Preview and nothing gets lost in screenshots being sent back and forth.”
>
> ![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_007.jpg)
>
> **Wunderman Thompson**

## Unlimited environments

Since each deployment, when unused, doesn’t take up substantive resources, the Frontend Cloud can take things a step further: providing [unlimited deployment environments](https://vercel.com/docs/deployments/environments) for different kinds of work.

Each immutable environment gets its own set of environment variables (`.env`), meaning you can have significantly different deploys, just by tweaking these variables. Hydrow, for instance, uses this to [create a completely separate “authoring” environment](https://vercel.com/customers/hydrow), away from the tweaks of developers, allowing content creators to work in a truly WYSIWYG space, saving hours of time for each piece of content.

This translates to production, too, since **any environment can be assigned to a domain.** Wunderman Thompson uses this strategy to [deploy fully localized versions of their websites all from the same CMS](https://vercel.com/blog/wunderman-thompson-composable-workflow), just by tweaking a language variable.

## Decouple deploy from release

Within the Frontend Cloud, it’s good to think about [decoupling your deploys from your releases](https://vercel.com/blog/how-to-scale-a-large-codebase). Deploys are an unlimited resource, full of testing opportunities in a true-to-prod environment. Releases are just for the end-user—upgrades or new features that go live and affect customers.

Companies like Upstart make 12,000 deployments per month, but only 1,000 of those are actual releases to consumers. These deployments offer them the ability to run end-to-end testing, share work easily among colleagues, and generally have a more public, iterative workflow.

However, you can also release to some of your end users without releasing to all. To keep iteration velocity high, you need the confidence to deploy code early and often ( [and be able to rollback](https://vercel.com/docs/deployments/instant-rollback)). Feature flags further separate deployments from releases, by making code in your deployment render [only after meeting your custom conditions](https://vercel.com/blog/how-to-scale-a-large-codebase#releasing-with-confidence-through-feature-flags).

These flags can be easily toggled on/off by developers, allowing your team to experiment without rebuilding the code. They also allow you to roll out new features to select customers, to make sure the release works with a few before releasing to all.

The power of unlimited environments plus unlimited [fast-as-edge feature flags](https://vercel.com/blog/zero-cls-experiments-nextjs-edge-config) makes your codebase truly a joy to experiment with and develop great features—if it’s accessible to use, kept organized, and safe to scale.

## Monorepos

With all this power, how do you keep your teams organized? At Vercel, we’ve helped [thousands of large organizations](https://vercel.com/customers) scale up and manage their codebases, and we believe that monorepos are the optimal code architecture for frontends.

![Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_008.jpg)![Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_009.jpg)Monorepos gather your org's code into one place, maximizing reusability, conformance, and efficiency.

A [monorepo](https://vercel.com/docs/monorepos) is a codebase with multiple projects contained in a single unified repository. Instead of having possibly hundreds of codebases on a per-project basis, monorepos allow for new and existing engineers to onboard in a single place, set up their local environment, and contribute to any project.

Historically, though, monorepos have only been for the largest companies, like Google or Meta. The tooling and best practices have not been accessible to all teams until the past few years.

With the advent of open-source build tools like [Turborepo](https://turbo.build/repo/docs), teams of any size can adopt and manage monorepos without hassle. Turborepo takes the lessons and development workflows from the giants of the web and brings them to every developer.

Turborepo's core concepts explained in just 2 minutes.

Turborepo is a high-performance build system with sensible defaults and robust escape hatches for custom configuration. It simplifies splitting your codebase into different sections, such as a component library, frontend slices for each team, and any other shared business logic.

When a team makes a change to their section of the UI, only the code they’ve changed will build or trigger CI runs, thanks to Turborepo’s powerful caching system. No more wasted time (and money) waiting for scripts or builds to complete for unrelated changes.

![With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_010.jpg)![With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_011.jpg)With Turborepo, if a build has been cached on any user's machine, the cache is available to all users within the monorepo.

Each team can own their part of the UI, with appropriate code reviews, scripts, and tests just for that section of the codebase. When any code needs to be reused across different teams, it's just an `import` statement away.

Monorepos are a superpower when you need to make updates across shared code, or sweeping changes that affect different parts of the UI. You can orchestrate a single change to roll out code safely (ideally behind a [feature flag](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud#decouple-deploy-from-release)), without breaking existing versions.

Turborepo also handles [running your tasks in the correct order](https://turbo.build/repo/docs/core-concepts/monorepos/running-tasks)—a common pain point with monorepos. No need to remember if you built package A before running package B. Turborepo understands your dependency graph and when to run each script.

Finally, Turborepo uses a shared Remote Cache between all members of your team, meaning that if one team member's computer has done the work to run tasks, compile, or build your application, those results are shared between all machines. The Vercel team, for instance, by using the [Vercel Remote Cache](https://vercel.com/blog/vercel-remote-cache-turbo), saved **25,000 hours of compute time last month.**

## Conformance

So, your code is highly accessible to all engineers. But this creates another challenge: how do you know who owns what code? If a new engineer makes a PR that includes a piece of code their team doesn’t own, who do they reach out to?

![Visualize who owns code in your organization.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_012.jpg)![Visualize who owns code in your organization.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_013.jpg)Visualize who owns code in your organization.

The Frontend Cloud allows you to [build conformance rules](https://vercel.com/blog/introducing-conformance) directly into your codebase and track who is responsible for maintaining certain parts of the application.

Onboarding and interaction with the codebase should be a safe and straightforward experience for all, and anyone who needs assistance, regardless of department, should know exactly where to turn.

The [Frontend Cloud has you covered](https://vercel.com/docs/workflow-collaboration/vercel-spaces#code-owners), with tools that provide detailed information about what team owns what, who to contact, and how to review code from different departments.

But let’s say an engineer doesn’t want to deal with the hassle of reaching out to the right people in the org, especially for a tiny change. [This is why the Frontend Cloud provides ways to manage conformance](https://vercel.com/docs/workflow-collaboration/vercel-spaces#conformance) (linting rules and other CI/CD tasks) from an easy location, to prevent errors from ever making it into the codebase.

![Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_014.jpg)![Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_015.jpg)Frontend clouds should provide a bird's eye view of your code that makes it easy to dive into the details you need.

Errors in build can be easy to debug, too, with [each build having its own shareable run log](https://vercel.com/docs/workflow-collaboration/vercel-spaces#runs). This makes it far easier to optimize builds in the first place since each unique run can be compared.

[**Ready to move fast and break nothing?**\\
\\
Try out Conformance with your enterprise team.\\
\\
Contact Us](https://vercel.com/contact/sales)

## Testing

Then, we have a set of challenges that come from decoupled architecture. Yes, [decoupling the frontend and backend](https://vercel.com/blog/the-foundations-of-the-frontend-cloud#why-decouple-the-frontend-from-the-backend...) is a better way to work, but how do you make sure your frontend and backend align perfectly, 100% of the time?

Luckily, end-to-end testing through CI/CD is [easy to set up in the Frontend Cloud](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment). Even though your frontend and backend are decoupled, because you have each instance of your application running in a true-to-prod environment, you can use fully automated services like Github Actions to test the app within that environment, before ever merging to production.

Any test, as preferred, can be [mandatory to pass before deploying to production](https://vercel.com/docs/observability/checks-overview), but they don’t have to block non-production builds. A failing test, then, has a full deployment dedicated to it, where your team can more easily see what’s going wrong.

![You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_016.jpg)![You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_017.jpg)You can implement various checks that run after successful deployments to the frontend cloud. They can define your application's quality metrics, run end-to-end tests, investigate APIs' reliability, and directly check your deployment code.

End-to-end testing is vital to implement on large codebases where teams share code within a monorepo. Since changes can sometimes ripple out or have unexpected effects on other teams, building [Atomic components](https://atomicdesign.bradfrost.com/chapter-2/) that are easy to test is a recommended pattern within the Frontend Cloud.

With testing coverage of your application, individual teams can be freed up to have even better DX, since anyone can push changes with confidence they aren’t breaking anything in the codebase.

A brief walkthrough of setting up end-to-end testing within a Turborepo-powered monorepo.

## Version skew

Another more subtle challenge can arise with decoupled frontends: version skew.

Version skew happens whenever two components of a software system communicate, but they aren’t running at exactly the same version. Often this is benign, but it can lead to hard-to-predict problems.

Imagine, for example, that your app has a form. One day you realize you misspelled the name of the email field. It’s not a huge deal because the code on the backend that reads the field has the same misspelling. But still, you decide to fix the spelling on both backend and frontend.

Now, we have potential version skew: if a user loaded the form before the change, but submits it after the deployment happened, they will get an error because the email field won’t be recognized (the backend expects the new spelling and the frontend sends the old name).

![Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_018.jpg)![Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_019.jpg)Applications are bound to the version that originally generated them every time a user initially navigates to the app. Subsequent requests from this instance of the app are then automatically routed to be served from that same version.

The Frontend Cloud [provisions infrastructure to protect from version skew](https://vercel.com/blog/version-skew-protection), ensuring that users are always sent to the backend that matches the frontend version.

## Third-party tooling

Standardized architecture in the Frontend Cloud also opens the door to a massive ecosystem of third-party tooling:

- Any plugins, community or commercial, written for [your framework](https://vercel.com/docs/frameworks#list-of-supported-frameworks) work by default, since they by definition must output to your framework code.

- Integrations to tools, such as CMS, databases, analytics, ecommerce, and more, become easy to set up and manage from within your framework code. Your codebase can [integrate or exchange an ever-growing number of these tools without fuss](https://vercel.com/integrations).


Crucially, since all these tools can easily be swapped out for each other, **you gain a truly future-proof codebase, without vendor lock-in**.

### What about AI?

At Vercel, we're working on AI-driven solutions to speed up existing tools and enhance workflows. We’re continually excited to [innovate within the AI ecosystem](https://v0.dev/).

![Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_020.jpg)![Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_021.jpg)Vercel's v0, now available in public beta, allows users to leverage AI to generate starter UIs—complete with the ability to copy and paste the working code directly into your product.

We see AI as the future of software development, and we're actively researching ways to securely integrate machine learning into our product to make the automation of the Frontend Cloud even _more_ efficient.

Even without generative AI features, the Frontend Cloud is the [best way to deploy AI-driven applications onto the web](https://vercel.com/blog/introducing-the-vercel-ai-sdk) _**.**_ Features like Edge Functions (which allow extended streaming from sources like OpenAI) and the speed and efficiency of the Frontend Cloud workflow allow for rapid adoption of and iteration with an ever-changing ecosystem of AI tools.

![Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_022.jpg)![Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.](images/the-developer-experience-of-the-frontend-cloud-vercel/img_023.jpg)Vercel's AI SDK offers an interoperable, streaming-enabled, edge-ready software development kit for AI apps built with JavaScript.

If you want to build AI-driven applications, the Frontend Cloud will give you the [fastest time-to-market](https://vercel.com/ai) and best user experience.

[**v0 is now open for everyone.**\\
\\
Generate UI in seconds with text or images. What will you ship?\\
\\
Napkin Sketch Time](https://v0.dev/)

## DX takeaways

In this section, we’ve covered why the Frontend Cloud gives better DX through:

- A familiar Git-based workflow

- Unlimited, production-grade preview environments

- Extremely high observability of your application

- Native collaboration

- Built-in experimentation through environments and feature flags

- Accessible monorepo support to deduplicate effort and onboard faster

- Conformance rules to help engineers stay organized in large codebases

- Automatic end-to-end testing to make sure bugs don’t make it to production

- Easy integration with best-in-class third-party tools, including the latest AI models


Perhaps the most important takeaway is this: if you’re not using the Frontend Cloud, you’re spending a lot of time tinkering with infrastructure that should be fully automated—globally at industry-leading speeds.

In the final article of this series (to be published soon), we'll dive into the core promises of the Frontend Cloud: reliability and security.

Blog post

Sep 12, 2023

### How to create an optimal developer workflow

![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_024.jpg)![](images/the-developer-experience-of-the-frontend-cloud-vercel/img_025.jpg)

Lindsey and Mark

Vercel.com landing page

### See for yourself