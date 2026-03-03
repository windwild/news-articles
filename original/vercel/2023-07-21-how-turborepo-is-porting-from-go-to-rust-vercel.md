---
title: "How Turborepo is porting from Go to Rust - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-turborepo-is-porting-from-go-to-rust"
date: "2023-07-21"
scraped_at: "2026-03-02T09:51:41.070075484+00:00"
language: "en"
translated: false
description: "Our strategy for making updates and maintaining stability while we migrate languages."
---




Jul 21, 2023

Our strategy for making updates and maintaining stability while we migrate languages.

In [a previous blog post](https://vercel.com/blog/turborepo-migration-go-rust), we talked about **why** we are porting [Turborepo, the high-performance build system for JavaScript and TypeScript](https://turbo.build/?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting), from Go to Rust. Now, let's talk about **how**.

Today, our porting effort is in full swing, moving more and more code to Rust. But when we were starting out, we had to make sure that porting was feasible for us to accomplish. A migration from one language to another is no small task and there's a lot of research to do up front to ensure that the end goal is attainable.

Here’s how we started the process, validated our current porting strategy, and made the call to port Turborepo to Rust.

## Port vs. full rewrite

When we were planning our migration, we briefly considered a full, ground-up rewrite. But, talking the idea through, we realized it wouldn't fit our goals as well as an incremental port would.

### What is an incremental port?

Incremental porting moves code piece-by-piece, running new and old code together at the same time. The goal for the chunk of code being moved is to keep the behavior exactly the same as before it was ported.

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_001.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_002.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_003.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_004.jpg)

In our case, this means we need to have our Go code and Rust code interoperating with each other. We want to do a simple translation, explicitly avoiding making improvements or changing functionality when we're swapping out languages for the slice of code. That way, we can do intensive testing against both sets of code, and complete the migration as quickly as possible.

### Why we didn't do a full rewrite

Full rewrites are very tempting. They are more simple to write and ship, as you don't need to worry about your "before" and "after" code working together. You also get a clean slate to write a new and improved version, without the warts and technical debt of the previous iteration. However, full rewrites also come with some serious downsides.

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_005.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_006.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_007.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_008.jpg)

First, a full rewrite tends to require a complete halt to shipping new features. Otherwise, you run the risk of chasing a moving target as the old codebase grows while you try to catch up with your new code.

A full rewrite also does not guarantee a better user experience. Often, a rewrite ends up less than seamless, as it's not feasible for the new version to match the old one, feature for feature, edge case for edge case. As the surface area of the rewrite grows, there's more room for error and users can end up frustrated with breaking changes and missing features.

Full rewrites also require building up an entirely new codebase, which is a large quantity of unused code. In our experience, unused code, even when verified with tests, can be a breeding ground for bugs. We wanted to make sure that any new Rust code was properly exercised as we moved through our porting effort.

## We chose to port

Therefore, we decided to **port** Turborepo to Rust instead of doing a full rewrite.

Porting did necessitate some tradeoffs. We had to introduce a significant amount of complexity into our codebase, so that we could interoperate between Go and Rust. This complexity meant slower developer velocity to start, but we look forward to workflow improvements going forward, particularly when our porting effort has finished.

More importantly, we knew we could continue shipping features to Turborepo users while porting. All things considered, we determined that this was a reasonable compromise and the path that we would take.

### Starting the port

We chose to start by writing a small, new Turborepo feature in Rust. This way, we could add new functionality from the roadmap for users, integrate Rust into our build process, and interact with existing Go code as little as possible to reduce our initial complexity.

Once we'd laid this groundwork, we knew that we could slowly port more and more code to Rust over time.

## Global `turbo`

We decided to have our first Rust feature be [global `turbo`](https://turbo.build/blog/turbo-1-7-0#global-turbo?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting), a feature that allows users to install Turborepo as a globally available command on their machine.

A global installation of `turbo` will look for a locally installed `turbo` program in the repository, execute it if it exists, and otherwise fallback to the global `turbo` binary. That way, you can easily run `turbo` from anywhere in your repository, but also keep a specific version of `turbo` pinned in your `package.json`.

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_009.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_010.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_011.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_012.jpg)

This feature is implemented through what we started calling "the Rust shim," a bit of Rust code that wraps the existing Go code. The Go portion is compiled via CGO as a C static library and then linked to the Rust binary. Luckily, global `turbo` only required a few features from the rest of Turborepo's code, such as reading configuration and navigating the file system.

## CLI parsing

As we implemented global `turbo`, we realized we needed to parse a few command line arguments like `--cwd`, the argument for setting `turbo`'s current working directory.

After global `turbo`, it made sense to continue by porting the rest of the CLI argument parser to Rust. To parse arguments, we use the [`clap` crate](https://docs.rs/clap/latest/clap/) (Rust’s equivalent of an npm package). `clap` lets you define a data type with the arguments, annotate it a little bit, and it will automatically create a parser.

With the pieces in place, we had to work on sending the args from the Rust entry point to the Go code. For better or worse, [C is the standard for foreign function interfacing (FFI)](https://faultlore.com/blah/c-isnt-a-language/), so we had to use C to communicate between Rust and Go.

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_013.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_014.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_015.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_016.jpg)

We wanted to avoid having too many types in C, as we weren’t confident that we could write cross-platform C types that played well with both Rust and Go. Instead, we decided to serialize our arguments to JSON and send it to Go as a string. Even though JSON serialization does have some overhead, we knew that the arguments struct would only be a few hundred bytes in size, so the performance impact would be minimal.

On the Rust side, we used another cornerstone crate of the Rust ecosystem, [`serde`](https://docs.rs/serde/latest/serde/), which lets you serialize and deserialize data in various different formats, using some minimal annotation. For the Go side, we were already using JSON in the codebase, so it was easy to receive the JSON string and deserialize it into a Go struct.

## Ship it?

With these two features ported, we were ready to ship our first hybrid Go-Rust release.

However, before we could release, we needed to make sure the Go-Rust binary worked in all the various contexts that Turborepo is used, [like the different operating systems and Linux distros that we support](https://turbo.build/repo/docs/installing?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting). As we tested our code, we started noticing some issues on a couple platforms.

### Windows difficulties

On Windows, there are two main toolchains, [Microsoft Visual C++ (MSVC)](https://en.wikipedia.org/wiki/Microsoft_Visual_C%2B%2B) and [Minimalist GNU for Windows (MinGW)](https://en.wikipedia.org/wiki/MinGW).

Go **only** uses MinGW, but we were using Rust with MSVC. This caused some runtime issues, but, luckily, the solution was simple: we moved our Rust toolchain to MinGW.

Next up, we had some issues with paths. Windows has a couple concepts of paths, including what’s called a Universal Naming Convention (UNC) path. When you ask Windows to canonicalize a path (resolve all symlinks and normalize components of the path), it gives you a UNC path.

However, despite the name, UNC paths are not supported everywhere—sometimes not even by Windows itself! This caused a few bugs where we’d provide a UNC path and get an invalid path error. The solution was to use a helpful Rust crate called [dunce](https://docs.rs/dunce/latest/dunce/) that lets you canonicalize a path and get a non-UNC path back, handling the intricacies of this problem for us.

### Alpine Linux

The second set of challenges came with Alpine Linux. At Vercel, we use Alpine, a common operating system for cloud computing, to create lightweight containers for building your projects.

Alpine, though, does not come with `glibc`, the de-facto implementation of the C standard library. This is a problem because many binaries assume `glibc` is installed and don’t package it themselves. There are some libraries that pave over this issue using packages like `gcompat` or `libc6-compat`, but they didn’t end up working for us because the version of `glibc` that Rust requires was too modern for our supported targets. When we’d try to run the binary, we’d get errors that the required `glibc` version was not available.

As a result, we decided to compile Turborepo as a fully static binary. This meant that we packaged our own C standard library implementation using `musl` (since you can't statically link `glibc` due to licensing issues). This seems to work just fine for both Rust and Go: Rust lets you set the C standard library in the target (`aarch64-unknown-linux-musl` vs. `aarch64-unknown-linux-gnu`) and Go does not use a C standard library by default.

However, when we ran this statically linked binary, it would return a segmentation fault. Even worse, when we inspected with a debugger, we’d find a corrupted stack. And, even worser, the segfault appeared to be coming from the Go runtime itself!

After a lot of searching, we tracked down a [seven year-old GitHub issue](https://github.com/golang/go/issues/13492) which explained that Go cannot be compiled as a C static library with `musl`. This posed a significant challenge, as Alpine Linux is an essential platform for Turborepo and its users. We had to go back to the drawing board and figure out how we could ship our Go-Rust combination.

Eventually, after a ton more deliberation, we came up with a solution: we’d compile our Go code and our Rust code as two separate binaries. The Rust code would call the Go code and pass the args serialized to JSON via the CLI.

![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_017.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_018.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_019.jpg)![](images/how-turborepo-is-porting-from-go-to-rust-vercel/img_020.jpg)

We knew that the args were small enough that they could be passed via CLI without too much of a performance hit. And because we were using a serialization format, the code changes were extremely small. All we had to do was change how Rust was sending the JSON string to Go.

With that, we were able to get our first hybrid Go-Rust release out the door. The first version of `turbo` that was shipped to you using these compilation strategies was [version 1.7.0](https://turbo.build/blog/turbo-1-7-0?utm_source=turbo&utm_medium=blog&utm_campaign=turborepo_porting).

## What we learned

Through this effort, we've learned a lot about moving from one language to another. Let's take note of what we've found.

### Serialization is useful for FFI

Our first takeaway is that serialization formats are very useful for interoperability. By serializing to JSON, a format with robust support in both Go and Rust, we were able to minimize our FFI surface area, and avoid a whole class of cross-platform, cross-language bugs. When we had to switch from a single, linked binary to two binaries, we were able to do so with relative ease because our FFI surface area was so small.

The tradeoff here is that serialization and deserialization is slow. You can only depend on this technique if either you know your serialized payloads will be small or you don't care about the performance hit for your use case.

### Porting takes preparation

The second takeaway is that incremental porting is feasible but requires lots of careful testing and strategizing. We ran into quite a few tricky bugs and we caught these issues through lots of automated and manual testing. You can [check out our (and Turbopack's) testing suites in our GitHub workflows](https://github.com/vercel/turbo/tree/main/.github/workflows).

Testing is also extremely important for nailing down the behavior of your code, whether it’s the exact edge cases of CLI parsing, or the order in which configuration is loaded. These exact details are not so crucial when you’re writing your first implementation, but they’re absolutely paramount to avoid breaking changes during a port or rewrite. You should aim to write tests **before** you start porting code, so that you have a known specification to work against.

### Cross-compatibility is difficult

The third takeaway is that cross-platform, cross-language release engineering is extremely challenging. Every platform, language, and compiler has their own quirks that can make interoperability difficult and, the more things you have working together, the more opportunities you have for a new complication.

### Porting is worth it for us

Finally, while porting from Go to Rust has been challenging, it has proven to be the correct choice for us strategically. Even with our porting effort going on, we've been able to ship new features, handle bugs in existing functionality, and keep helping our users while we migrate. It's required some extraordinarily tricky debugging, careful planning, and rigorous testing, but we believe it has been worth it.

## -turborepo) Try out (ported) Turborepo

This week, Turborepo saved 5,742 hours of time for the product engineers and CI machines at Vercel. If you want to try out the same technology in just a few minutes, [check out our article](https://vercel.com/blog/vercel-remote-cache-turbo) on how you can get started with [Vercel Remote Cache](https://vercel.com/docs/concepts/monorepos/remote-caching).

Vercel Template

Deploy this template

### This is an official starter Turborepo with two Next.js sites and three local packages

Turborepo & Next.js Starter

Vercel.com landing page

### Visit turborepo.com