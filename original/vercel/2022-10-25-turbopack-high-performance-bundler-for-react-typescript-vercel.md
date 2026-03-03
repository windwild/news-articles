---
title: "Turbopack: High-performance bundler for React & TypeScript - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/turbopack"
date: "2022-10-25"
scraped_at: "2026-03-02T10:00:02.243281724+00:00"
language: "en"
translated: false
description: "Introducing Turbopack, the Rust-based successor to Webpack. A high-performance bundler for React Server Components and TypeScript codebases."
---




Oct 25, 2022

Vercel's mission is to provide the speed and reliability innovators need to create at the moment of inspiration. Last year, we focused on speeding up the way Next.js bundles your apps.

Each time we moved from a JavaScript-based tool to a Rust-based one, we saw enormous improvements. We migrated away from Babel, which resulted in **17x faster transpilation**. We replaced Terser, which resulted in **6x faster minification** toreduce load times and bandwidth usage.

There was one hurdle left: webpack. Webpack has been downloaded over **3 billion times**. It’s become an integral part of building the web, but it's time to go faster.

Today, we’re launching [**Turbopack**](https://turbo.build/) **:** a high-performance bundler for React Server Components and TypeScript codebases.

![Introducing Turbopack, the Rust-based successor to Webpack.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_001.jpg)![Introducing Turbopack, the Rust-based successor to Webpack.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_002.jpg)Introducing Turbopack, the Rust-based successor to Webpack.

Led by the creator of Webpack, Tobias Koppers, Turbopack is our next-generation bundler.

Try out the alpha of Turbopack in Next.js 13 today with [`next dev --turbo`](https://turbo.build/pack/docs).

## How fast is Turbopack?

Turbopack is built on a new incremental architecture for the fastest possible development experience. On large applications, it **shows updates 700x faster than Webpack**.

Turbopack only bundles the minimum assets required in development, so **startup time is extremely fast**. On an application with 5,000 modules, Turbopack takes 4 seconds to boot up, while Vite (with SWC) takes 16.6 seconds.

To learn more, read the [docs](https://turbo.build/pack/docs/core-concepts) on how Turbopack bundles and view the benchmarks.

## Why is Turbopack so fast?

Turbopack’s architecture takes the lessons learned from tools like [Turborepo](https://turborepo.org/) and Google’s Bazel, both of which focus on using caches to **never do the same work twice**.

Turbopack is built on Turbo: an open-source, incremental memoization framework for Rust. Turbo can cache the result of any function in the program. When the program is run again, functions won't re-run unless their inputs have changed. This granular architecture enables your program to skip large amounts of work, at the level of the function.

An incremental reactive system with the speed of Rust? Turbopack is unstoppable.

To learn more, check out our [explainer on Turbo](https://turbo.build/pack/docs/core-concepts).

[**Ready to give Turbopack a try?**\\
\\
See how fast Turbopack really is—try the Web's next-generation bundler today.\\
\\
Contact sales](https://vercel.com/contact/turborepo)

## The future of Turbo

To start, Turbopack will be used for the [Next.js 13](https://beta.nextjs.org/docs) development server. It will power lightning-fast HMR, and it will **support React Server Components natively**, as well as TypeScript, JSX, CSS, and more.

Turbopack will eventually also power Next.js production builds, both locally and in the cloud. We’ll be able to **share Turbo's cache across your entire team,** using [Vercel Remote Caching](https://vercel.com/docs/concepts/monorepos/remote-caching).

Webpack users can also expect **an incremental migration path** into the Rust-based future with Turbopack.

We couldn’t be more excited about the future of the Turbo ecosystem, as we push to help you iterate faster and create at the moment of inspiration.

![Turbopack provides a fast and flexible development experience for apps of any size.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_003.jpg)![Turbopack provides a fast and flexible development experience for apps of any size.](images/turbopack-high-performance-bundler-for-react-typescript-vercel/img_004.jpg)Turbopack provides a fast and flexible development experience for apps of any size.

Explore the [Turbopack alpha](https://turbo.build/pack) in Next.js 13 today.