---
title: "Life of a Vercel request: Application-aware routing - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/life-of-a-request-application-aware-routing"
date: "2025-04-15"
scraped_at: "2026-03-02T09:34:59.573056569+00:00"
language: "en"
translated: false
description: "Vercel's gateway leverages framework-defined infrastructure to intelligently load balance, protect, and route applications at-scale and with any architecture complexity."
---




Apr 15, 2025

Vercel deployments include application-aware request handling, directly from your framework code.

Routing is a fundamental part of delivering applications, but it’s often treated as an afterthought—tacked onto the caching layer and configured through complex YAML or manual click-ops. This can introduce friction for teams, increase the risk of misconfigurations, and slow down deployments, especially as applications grow in complexity.

Vercel takes a different approach: routing is built into the platform as an application-aware gateway that understands your codebase. This unlocks a range of capabilities that simplify development by reducing configuration overhead, minimizing latency, and enabling more advanced architectures.

The gateway has full context of your deployments, domains, and logic. It supports standard routing and custom rules, but goes beyond reverse proxying by interpreting application logic in real time to make smarter decisions, like skipping unnecessary compute.

Here’s how Vercel routes requests—and why it makes building performant, complex apps easier.

[**Catch up: Read Part I**\\
\\
Life of a Vercel request: What happens when a user presses enter\\
\\
Read now](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter)

## Route-aware and application-aware infrastructure

Vercel uses your [framework code to define infrastructure](https://vercel.com/blog/framework-defined-infrastructure) and how requests are handled at runtime. This tight integration gives the platform full visibility into your app’s structure: routes, layouts, rewrites, middleware, functions, static assets, and routing logic.

We refer to this as _route-aware_ and _application-aware_ infrastructure. That awareness powers the platform’s ability to optimize everything from build output to request resolution, fulfillment, and delivery.

![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_001.jpg)![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_002.jpg)![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_003.jpg)![Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_004.jpg)Framework-defined infrastructure turns each code snapshot into a deployment—an isolated, versioned object that acts as the blueprint for cloud resources, including environment variables, routing rules, caching behavior, and compute.

Unlike a traditional standalone CDN, Vercel's gateway doesn’t need to be manually wired to backends or hardcoded to interpret intent. Routing is not bolted on—it's defined by your app and built into the deployment. This allows it to resolve requests across millions of domains and deployments in real time.

### Aliasing domains on Vercel

Every domain—whether it’s your [custom domain purchased through Vercel](https://vercel.com/docs/getting-started-with-vercel/buy-domain) or a third-party, or a free `*.vercel.app` domain—serves as an external entry point from the internet.

Behind the scenes, these domains are _aliases_—logical mappings to a deployment within Vercel’s global routing.

Each _deployment_, shaped by the framework-defined build process, includes its own routing table, middleware, headers, and logic—providing full app context for request evaluation and WAF logic. When a domain is aliased to point to a deployment, Vercel automatically provisions and manages SSL/TLS certificates for HTTPS with no manual configuration, risk of expiration, or downtime.

![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_005.jpg)![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_006.jpg)![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_007.jpg)![Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_008.jpg)Every domain on Vercel is an alias that maps to a specific deployment in the routing layer, ensuring requests are routed to the correct version globally.

### **De-aliasing and early stages of request fulfillment**

[When a request is made](https://vercel.com/blog/life-of-a-vercel-request-what-happens-when-a-user-presses-enter) to your domain, it travels via Anycast routing to the nearest Point of Presence (PoP), passes through initial DDoS mitigations, and lands in a Vercel Region for initial Web Application Firewall (WAF) inspection.

The request is then enriched in real-time, through _de-aliasing_—the reverse process of mapping the domain to a specific deployment.

While traditional WAFs operate blindly, evaluating requests without understanding the app they’re protecting, [Vercel’s WAF](https://vercel.com/security/web-application-firewall) is made application-aware, as it's integrated with all routing metadata associated with a deployment. That means firewall rules can target specific parts of your application, not just raw path or cumbersome regex patterns.

![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_009.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_010.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_011.jpg)![Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_012.jpg)Requests flow end-to-end through the Vercel Network—starting at the closest Point of Presence, passing through the Vercel Firewall, CDN, and Functions—with routing decisions applied at each stage.

At this point, and throughout the entire lifecycle of the request, Vercel's routing can return with an early response, serve from cache, or invoke compute. In a dynamic network, the destination isn’t fixed as the gateway decides where to send each request.

## A platform unlocked by application-aware routing

Vercel’s gateway provides automatic deployment, routing, and rollout behavior, thanks to the deployment-based approach (quick aliasing and de-aliasing) combined with an instant global propagation pipeline.

Let’s look at a few examples.

### Instant, global propagation for rollouts and rollbacks

When you alias a domain to a deployment, which could be an existing deployment we're updating or a brand new one created from a PR a few seconds ago, that alias becomes the active entry point for all traffic to that domain.

![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_013.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_014.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_015.jpg)![Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_016.jpg)Rollbacks happen instantly by updating the alias to point to a previous deployment. Because routing is handled at the software layer, changes propagate globally within milliseconds—ensuring zero downtime.

Switching that alias—mapping to an internal Vercel deployment—happens instantly. There’s no DNS propagation, no warmup time, and no manual steps. The gateway starts routing traffic to the new version immediately. This change is propagated globally so all users requesting your app will hit the latest deployment milliseconds after it goes live.

If a deployment or PR needs to be reverted, you can just as quickly re-alias the domain to the previous deployment with [Instant Rollback](https://vercel.com/docs/instant-rollback)—which remains untouched given its immutability—and traffic instantly directs to that deployment in a known good state. Importantly, this keeps the CDN cache intact, and is all done with no rebuild, no redeploy, no scale-down event. Just a global pointer update.

### Incremental rollouts

This also enables incremental rollouts of new deployments, often referred to as [blue/green deployments](https://vercel.com/blog/releasing-safe-and-cost-efficient-blue-green-deployments). With all Vercel deployments, you can test a new version using [preview deployments](https://vercel.com/docs/deployments/environments#preview-environment-pre-production) to run health checks, and only promote it to production once it’s ready—all while keeping the previous version one alias change away. Because aliasing is a pointer, you can modify routes to roll out new builds in phases, where there are multiple production environments live at the same time.

![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_017.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_018.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_019.jpg)![Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_020.jpg)Deployment-based routing lets you incrementally split traffic between two versions of your codebase for controlled, phased rollouts. In this example, a portion of traffic is gradually shifting to Deployment B.

If there are issues during the incremental rollout of green (new, meant to be fully live deployment), an instant rollback returns the percentage of traffic back to 100% to blue.

### Skew Protection against version mismatches

Ensuring rollouts don’t affect users who are actively using your app can be tricky to manage. Backend logic can get out of sync with frontend code running in user's browsers.

[Skew Protection](https://vercel.com/docs/skew-protection) helps prevent mismatches between frontends and backends by ensuring a user stays on the same deployment with aliasing pointing to specific deployments. It keeps track of which deployment every user of your app is accessing at any given point and intelligently keeps them in sync.

![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_021.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_022.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_023.jpg)![Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_024.jpg)Version mismatches happen when the frontend and backend come from different deployments. Skew Protection avoids this by routing all requests in a session to the same deployment—ensuring consistency across deploys.

If you deploy a new frontend that depends on changes in the backend, you want to make sure that clients using the new UI aren’t sending requests to an outdated version of the infrastructure. With Vercel’s gateway, de-aliasing solves this. A request that includes a deployment identifier, via a first-party cookie, can bypass the alias entirely and be routed to the exact deployment that originally rendered it.

Search engines often crawl versioned URLs for weeks after indexing. In most setups, those versions are deleted after new deployments—breaking links and losing traffic. Skew Protection corrects for this, routing outdated crawler requests to the correct version for up to 60 days, keeping pages accessible. [Learn how Vercel manages this for you](https://vercel.com/changelog/automatic-mitigation-of-crawler-delay-via-skew-protection).

## A continuous, intelligent reverse proxy

The gateway isn’t just deployment-aware—it’s programmable, serving as an intelligent reverse proxy in front of your apps, facilitating almost all routing. With the integrated gateway, routing doesn’t happen once. It happens continuously.

Throughout the request's lifecycle, the gateway ushers the request through the steps laid out by framework code from the previously mentioned aliasing and de-aliasing and WAF inspection, to programmatic middleware execution and dynamic rewrites. The ushered request is continuously re-evaluated for either continued fulfillment, an early return, or with rewrites that go on yet another path to complete its fulfillment.

This is all derived from code. Developers shape routing at every stage—before, during, and after inspection—with the logic they've defined and versioned with every immutable snapshot of code. This continuous evaluation isn’t just passive—different decisions can be made on the fly for every request, like with middleware.

### Programmatic routing functions

[Middleware](https://vercel.com/docs/edge-middleware) runs during routing, giving you full access to the request object (headers, cookies, pathname, and more). This logic executes close to your users and can short-circuit the request, mutate the path, inject headers, or return early responses. Middleware lets you, with very low latency, inject feature flags and A/B experiments, first-line authentication checks for quick returns, geo-based redirection, application-level bot filtering, and session-aware routing.

![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_025.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_026.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_027.jpg)![Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_028.jpg)Routing functions and programmable logic—such as middleware, rewrites, and redirects—enable per-request decisions to be made early in the lifecycle of a request.

Many routes don’t require dynamic logic. They’re based on predictable patterns or static conditions like pathnames and headers. In these cases, Vercel’s routing layer supports versioned, framework-defined route maps that enable precise control without the need for runtime code execution. This is especially useful when multiple underlying apps serve different parts of the same domain.

### Rewrites and redirects

Rewrites and redirects are first-class primitives. Rewrites route a request to a different origin or path—internal or external—without changing the URL users see. This is critical for building systems like microfrontends, where different parts of an app may live in separate deployments.

![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_029.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_030.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_031.jpg)![Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_032.jpg)Vercel routing enables a single application to route requests across multiple underlying applications, commonly referred to as microfrontends in web architectures.

For example, you can rewrite `/blog/[slug]` to a headless CMS or `/dashboard` to an internal service. The routing layer ensures the client stays unaware of these boundaries, preserving a unified app experience. Rewrites can also target fully external URLs while keeping the original route structure intact.

This allows multi-tenant apps like [Dub](https://dub.co/) and [Mintlify](https://mintlify.com/) to use wildcard subdomains, which allow users to set custom domains easily. This points many different hosts to the same app (which may be backed by many apps and deployments) with centralized routing and minimal complexity.

![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_033.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_034.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_035.jpg)![Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.](images/life-of-a-vercel-request-application-aware-routing-vercel/img_036.jpg)Rewrites route requests to different paths behind the scenes, enabling dynamic URLs and custom domains to serve content from shared application infrastructure—ideal for multi-tenant architectures.

In contrast, redirects update the browser URL and enforce client-side routing changes. They’re useful when migrating legacy paths, fixing SEO issues, or enforcing canonical URLs.

Both rewrites and redirects can be defined statically in your config or generated dynamically via middleware, and both are fully tied to the active deployment. There’s no global routing config that sits outside the lifecycle of your app. Everything is scoped to your code and versioned along with it.

## Framework-defined routing

The Vercel gateway is an intelligent routing system with full awareness of both provisioned infrastructure and every deployment. What’s needed is shaped by your app’s code, giving users the ability to control real-time routing with programmable logic.

As each framework handles routing differently. Vercel analyzes, infers, and then preserves the routing output of every build to ensure requests are handled according to the framework’s behavior and coded intent. It doesn’t just serve static assets or forward requests. It understands the structure and state of your app. It knows what deployment is active, how requests should be shaped, and what logic should run before a response is served. It gives you control without requiring infrastructure management, and flexibility without sacrificing predictability.

Routing is more than matching paths to handlers. On Vercel, it’s a dynamic process that spans deployments, domains, and logic—without drift or downtime. The gateway is where traffic is understood, where code paths are chosen, and where infrastructure becomes part of your app's runtime behavior.

[**Try application-aware routing**\\
\\
Start with Vercel to deploy and scale your app with automated, application-aware routing—right from your framework code.\\
\\
Deploy now](https://vercel.com/new)