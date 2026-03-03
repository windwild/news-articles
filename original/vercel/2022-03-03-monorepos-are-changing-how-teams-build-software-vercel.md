---
title: "Monorepos are changing how teams build software - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/monorepos"
date: "2022-03-03"
scraped_at: "2026-03-02T10:02:38.176240448+00:00"
language: "en"
translated: false
description: "Monorepos are codebases containing multiple projects in a single unified code repository. This post explores how monorepos can improve your development workflow."
---




Mar 3, 2022

Developing, shipping, and iterating is faster in a monorepo

The largest software companies in the world use monorepos. But historically, adopting a monorepo for anything other than at a Facebook or Google scale was difficult, time-consuming, and often filled with headaches.

Since Turborepo [joined Vercel](https://turborepo.org/blog/joining-vercel), we’ve seen development teams of all sizes adopt Turborepo for [faster builds](https://twitter.com/RobEasthope/status/1486994338290847745) and save over 200 days worth of time by remotely caching their deployments on Vercel.

Turborepo takes the lessons and development workflows from the giants of the Web and brings it to open source for _every_ developer. It lowers the barrier to entry for using monorepos and makes it accessible to everyone.

Let’s explore how monorepos can improve your development workflow.

## What are monorepos?

Monorepos are codebases containing multiple projects, often using multiple frameworks, in a single unified code repository. Rather than having 100+ separate repositories, teams instead choose to consolidate to a monorepo for a number of reasons:

1. [Easier updates across packages](https://vercel.com/blog/monorepos#1.-easier-updates-across-packages)

2. [Easier collaboration and debugging](https://vercel.com/blog/monorepos#2.-easier-collaboration-and-debugging)

3. [Easier local development](https://vercel.com/blog/monorepos#3.-easier-local-development)

4. [Faster builds with remote caching](https://vercel.com/blog/monorepos#4.-faster-builds-with-remote-caching)


![The architecture of a monorepo deployed to Vercel.](images/monorepos-are-changing-how-teams-build-software-vercel/img_001.jpg)![The architecture of a monorepo deployed to Vercel.](images/monorepos-are-changing-how-teams-build-software-vercel/img_002.jpg)The architecture of a monorepo deployed to Vercel.

Monorepos empower software teams to be more collaborative and productive with improved transparency, discoverability, code sharing, and standardization. But colocation of code doesn’t solve every problem.

## Turborepo

[Turborepo](https://www.youtube.com/watch?v=YX5yoApjI3M&t=225s) is a high-performance build system for JavaScript and TypeScript codebases. It was designed after the workflows used by massive software engineering organizations to ship code at scale. Turborepo abstracts the complex configuration needed for monorepos and provides fast, incremental builds with zero-configuration remote caching.

Instead of wasting days worrying about _how_ you're shipping, Turborepo lets you focus on _what_ you're shipping by abstracting configuration, scripts, and tooling on your behalf.

> “Turborepo has drastically improved developer productivity at Makeswift, helping us get to market faster.Turborepo has drastically improved developer productivity at Makeswift, helping us get to market faster.”
>
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_003.jpg)
>
> **Lindsay Trinkle,** Co-founder of Makeswift

Let’s look at some of the advantages of using monorepos and explore how Turborepo makes them easy to adopt.

## Advantages of monorepos

### 1\. Easier updates across packages

Let’s say you have a component library being reused across 100 different repositories, distributed as an npm package. Publishing a new version of the component library and updating all 100 repositories can turn into a nightmare. Different repos quickly get out of date and discrepancies in your application begin to appear. ( _Why does the button look different on this page? Oh, it’s using a different version of the component library._)

With monorepos, updating the version of a package can happen in a single place and cascade to all other dependencies. This helps ensure consistency across products and features and prevents the pain of trying to coordinate commits across multiple repositories.

> “With Turborepo, we were able to give each workspace its own build, test, and typecheck scripts and not worry about manually managing when they execute — Turbo handles the pipelining and caching. Turbo remote caching has drastically sped up our CI runs when a code change only touches one or a few workspaces.With Turborepo, we were able to give each workspace its own build, test, and typecheck scripts and not worry about manually managing when they execute — Turbo handles the pipelining and caching. Turbo remote caching has drastically sped up our CI runs when a code change only touches one or a few workspaces.”
>
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_004.jpg)
>
> **Spike Brehm,** Software Engineer at Watershed

Try out the [Turborepo design system starter](https://github.com/vercel/turborepo/tree/main/examples/design-system) to build your own component library.

### 2\. **Easier collaboration and debugging**

When critical pieces of your system are distributed across many repositories, it’s hard to find the code you’re looking for. With all code living in a single place, it’s easier to search, share, and reuse code across different systems, applications, or libraries. Plus, it’s easier to enforce standards across the organization in a centralized location.

### 3\. **Easier local development**

With separately published repositories, the current tooling (`npm link`) makes it difficult to make changes to shared components or services. This method struggles to scale as the number of repositories grows. It’s not feasible to globally [symlink](https://en.wikipedia.org/wiki/Symbolic_link) 100 repositories together to run an end-to-end test on your local machine.

With monorepos, we can set up testing, linting, formatting, publishing, and other tasks _once_ in a single place where dependencies can be easily managed and upgraded together. This helps prevent toolchains for less active applications from falling behind, making it easy to run locally when revisiting the application later.

> “Turborepo has saved us 67 hours of CI since we adopted it. That's for a team of only four full-time developers.Turborepo has saved us 67 hours of CI since we adopted it. That's for a team of only four full-time developers.”
>
> ![](images/monorepos-are-changing-how-teams-build-software-vercel/img_005.jpg)
>
> **Matt Pocock,** Lead Developer of Stately.ai

Try out the [Turborepo example with pnpm](https://github.com/vercel/turborepo/tree/main/examples/with-pnpm) for the fastest local development experience.

### 4\. Faster builds with remote caching

Turborepo caches the output of any previously run command such as testing and building, so it can replay the cached results instantly instead of rerunning them. Normally, this cache lives on the same machine executing the command.

However, with remote caching, you can share the Turborepo cache across your entire team and CI, resulting in even _faster_ builds and days of time saved. This [speeds up your workflow](https://vercel.com/resources/iterate-faster-with-a-streamlined-development-workflow) by avoiding the need to constantly re-compile, re-test, or re-execute your code if it is unchanged.

![](images/monorepos-are-changing-how-teams-build-software-vercel/img_006.jpg)![](images/monorepos-are-changing-how-teams-build-software-vercel/img_007.jpg)

## Get started with monorepos

[Try out Turborepo](https://turborepo.org/docs/getting-started) today, enable [Remote Caching](https://vercel.com/docs/concepts/monorepos/remote-caching), and experience a faster workflow for your team paired with an improved developer experience.

Watch Turborepo Remote Caching in action and get started with your monorepo today.