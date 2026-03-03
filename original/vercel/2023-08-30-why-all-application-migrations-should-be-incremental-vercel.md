---
title: "Why all application migrations should be incremental  - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/incremental-migrations"
date: "2023-08-30"
scraped_at: "2026-03-02T09:51:26.141150163+00:00"
language: "en"
translated: false
description: "Projects that require migrations should aim for incremental migrations"
---




Aug 30, 2023

Large migrations are inevitable, but they don't have to be painful or risky. Learn why incrementally migrating is the solution.

In 2023, there are few software projects that are true greenfield endeavors. Instead, migrations of existing systems are the new normal. Migrations done wrong can introduce substantial business and timeline risks into any software project. An incremental migration strategy can minimize those risks while pulling forward validation of business impact.

Vercel’s product is designed to support incremental migration from the ground up. In this post you'll get a high-level overview of incremental migration strategies and considerations.

## Why migrate incrementally?

Almost all software projects that require migrations should aim for incremental migrations in order to:

- Minimize risk by reducing the scope of the individual steps of the migration.

- Minimize risk by having a more natural path to rolling back in the case of unexpected issues.

- Allow validating the technical implementation and business value substantially earlier in the process.

- Achieve downtime-free migration without maintenance windows.


### Understanding big bang migrations

Big bang migrations are migrations in which a system is replaced in a one-time full switchover. There may be intermediate steps, but they are all performed in very short order. Basically, you pick a date, and on that date, all usage is moved from the legacy system to the new system.

![](images/why-all-application-migrations-should-be-incremental-vercel/img_001.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_002.jpg)

Problems with big bang migrations can include:

- You may go through the entire process only to learn that there are product problems that are very expensive to fix this late in the program.

- Rehearsals are inherently difficult to execute, making it hard to assess upfront whether a migration will succeed.

- You may reach a point of no return where a migration has to be completed even if major problems are noticed while it is happening.

- It may be required to take the legacy system offline while the migration is happening leading to lost business. Such maintenance windows often escalate in duration as issues are only discovered while the migration is running.


### What is an incremental migration?

![](images/why-all-application-migrations-should-be-incremental-vercel/img_003.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_004.jpg)

An incremental migration strategy involves gradually transitioning to a new or significantly updated software system. During this process, both the old and new systems run simultaneously, and either features or users are moved over in phases instead of all at once.

There are two major types of incremental migrations:

**1\. Vertical: Feature-by-feature increments**

![](images/why-all-application-migrations-should-be-incremental-vercel/img_005.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_006.jpg)

In this strategy, subsets of system functionality are switched to the new system. Think of this as migrating one feature at a time where both systems are operating in parallel and functionality is routed to the new or legacy system based on whether the respective feature has been migrated or not.

**2\. Horizontal: User-by-user increments**

![](images/why-all-application-migrations-should-be-incremental-vercel/img_007.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_008.jpg)

In horizontal migrations, while "users" are commonly the main unit being moved, other entities can be used instead. The ideal choice would be an entity that can be easily divided or "sharded" within a system, ensuring minimal interaction between these separate shards.

It would not be uncommon to see vertical and horizontal incremental migration strategies combined in complex migrations. In that case you’d see a user-by-user migration on per-feature basis.

## Trade-offs of incremental migrations

The primary trade-off of incremental migrations is the introduction of additional effort to implement the interop between the new and legacy system. This must be weighed against the reduction in risk and faster time to business validation.

This is particularly challenging if the systems have to access each other’s data. In case of a horizontal incremental migration, picking the right unit of increment is the most crucial decision to minimize data dependencies. Common entities where this is true is a "user," or an "organization."

## Frontend migrations

Frontend migrations are a special case of migration in which a frontend layer is migrated while the backend stays stable. Frontend migrations are generally easier to execute because the stateful data continues to be handled by the same "system of record," and only the rendering and processing for the backend’s data is updated.

While the term "frontend" sometimes evokes expectations of user interfaces and similar modalities, the principle of layered migration can be extended deep into larger systems: for example, even if entire systems are exchanged including their primary database, it can be helpful to keep the data-warehouse layer stable and to ingest data from legacy and new systems concurrently.

![](images/why-all-application-migrations-should-be-incremental-vercel/img_009.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_010.jpg)

Not changing the analytics layers at the same time as applications has the additional benefit of retaining a reliable system for the purpose of judging the performance of the new system.

![](images/why-all-application-migrations-should-be-incremental-vercel/img_011.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_012.jpg)

## Migrating from monolithic to composable architecture

A special case of such a frontend migration is one where the legacy system wasn’t properly decomposed into backend and frontend. If the goal is to switch to a new frontend, it may be possible to introduce an API into the legacy system such that a new frontend can be introduced while keeping the existing system around as a backend.

The above is common when companies bought into monolithic systems that coupled frontend and backend into a single system. As these companies want more control over the user interface they are presenting to their users, they often introduce separated frontends that treat the previous monolith as an API service.

### Migrating a web frontend

The key primitive to incremental migration of web frontends is the [reverse proxy](https://vercel.com/docs/edge-network/rewrites). Reverse proxies allow a web server to serve content from multiple different web servers under its primary domain.

![](images/why-all-application-migrations-should-be-incremental-vercel/img_013.jpg)![](images/why-all-application-migrations-should-be-incremental-vercel/img_014.jpg)

### Step 1: Introduce a reverse proxy with zero change in functionality

Step 1 of any migration to new serving infrastructure is to introduce a reverse proxy that forwards all requests to the legacy infra. The reverse proxy can:

- Be co-located with the new frontend (recommended)

- Be the legacy frontend

- Be a dedicated system that is introduced specifically for the migration


Co-locating the reverse proxy with the new frontend is recommended because it allows exposing the new infrastructure to production traffic without expected behavior changes.

Vercel applications come with built-in reverse proxy functionality to help implement such migrations. Notably, the reverse proxy can be programmed through [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) which helps implementing the migration increments as well as request adapters between new and legacy systems.

When this stage is complete the new infrastructure is formally in production yet all actual logic gets served by the legacy system. We expect zero behavior changes after step 1, so it is easy to verify that this step of the migration was successful.

### Step 2: Start migrating parts of the traffic

At the beginning of step 2, the new system serves all of the traffic but none of the actual application logic. The new system can now be configured to take over part of the traffic while continuing to proxy all other traffic to the legacy system.

For example, in a web shop one might start serving a subset of the product detail pages from the new system while everything else is proxied. These increments in functionality can be validated one step at a time.

Over time a larger and larger percentage of pages are served by the new system, until eventually 100% of traffic is fulfilled directly by the new system. At this stage the reverse proxy to the legacy system can be shut down and the migration in terms of user-visible effects is complete.

### Traffic migrations

Traffic migrations are a special case of a horizontal incremental migration.

[Vercel](https://vercel.com/) itself is currently in the middle of a major incremental migration of its primary serving system. The team has chosen an incremental migration strategy paired with dark launches. Their goal for the new system is to have bug-for-bug compatibility with the legacy system while substantially improving latency and CPU usage.

A [dark launch](https://cloud.google.com/blog/products/gcp/cre-life-lessons-what-is-a-dark-launch-and-what-does-it-do-for-me) is the introduction of a secondary system while an existing system continues to serve the user-facing traffic. In our dark launch phase we send traffic both to the old and new system and compare the results to validate that they behave exactly the same.

Naturally, a dark launch uses additional resources (since both old and new systems are engaged for the same traffic effectively doubling processing needs). Respectively, it is advisable to only run a subset of traffic through the dark launch path.

At Vercel, our incremental rollout plan looks like this:

- Dark launch for X% of traffic

- Observe differences in responses between old and new system

- If needed, fix the behavior of the new system

- Validate that the new system does, indeed, improve latency and CPU usage

- Once the dark launch behaves sufficiently like the new system and the goals of the new system achieved, switch the same X% of traffic over to the new system

- Repeat until 100% of traffic is migrated


As of today, we've successfully finished this migration and are now serving 100% of traffic on the new system.

## Summary

Incremental migrations can seem like additional scope that one might wish to avoid, but mature organizations realize that they are usually worth the effort. Incremental migrations minimize risk, improve the time to validating the business value of a change, and eliminate planned downtime.

Frontend migrations are a special case of migrations where systems of record stays the same while the frontend is replaced. Migrations to Vercel are often such frontend migrations. Our platform provides specialized tools to support such migration through reverse proxying and fine-grained request management in [Edge Middleware](https://vercel.com/docs/functions/edge-middleware).

[**Start building securely**\\
\\
Our experts can help you navigate Vercel for your team's unique needs.\\
\\
Contact Us](https://vercel.com/contact/sales)