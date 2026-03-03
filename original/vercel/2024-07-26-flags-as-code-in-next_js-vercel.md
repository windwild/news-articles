---
title: "Flags as Code in Next.js - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/flags-as-code-in-next-js"
date: "2024-07-26"
scraped_at: "2026-03-02T09:42:33.316537142+00:00"
language: "en"
translated: false
description: "The Flags SDK is a free open-source library that gives developers the tools they need to use feature flags in Next.js and SvelteKit applications."
---




Jul 26, 2024

Exploring the usage of feature flags in Next.js with Vercel's Flags SDK.

We recently introduced a new [Flags SDK](https://flags-sdk.dev/) that allows using feature flags, in Next.js and SvelteKit, and works with any feature flag provider—or when using no flag provider at all. It's not meant to be a competitor to other feature flag providers. Instead, it’s a tool that sits between your application and the source of your flags, helping you follow best practices for using feature flags and experiments, keeping your website fast.

Follow along below to get started with the Flags SDK, beginning with a simple feature flag to more sophisticated cases, discussing tradeoffs along the way.

# Contents

01. [Basic start](https://vercel.com/blog/flags-as-code-in-next-js#basic-start)
02. [Guiding principles of the Flags SDK](https://vercel.com/blog/flags-as-code-in-next-js#guiding-principles-of-the-flags-sdk)
03. [Feature Flags are functions](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-functions)
04. [Feature Flags are only ever evaluated on the server](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-are-only-ever-evaluated-on-the-server)
05. [Feature Flags accept no arguments on the call side](https://vercel.com/blog/flags-as-code-in-next-js#feature-flags-accept-no-arguments-on-the-call-side)
06. [A primitive flag](https://vercel.com/blog/flags-as-code-in-next-js#a-primitive-flag)
07. [Flag progressions and their tradeoffs](https://vercel.com/blog/flags-as-code-in-next-js#flag-progressions-and-their-tradeoffs)
08. [Basic case](https://vercel.com/blog/flags-as-code-in-next-js#basic-case)
09. [Overriding from Vercel Toolbar](https://vercel.com/blog/flags-as-code-in-next-js#overriding-from-vercel-toolbar)
10. [Using an environment variable](https://vercel.com/blog/flags-as-code-in-next-js#using-an-environment-variable)
11. [Using Edge Config](https://vercel.com/blog/flags-as-code-in-next-js#using-edge-config)
12. [A primer on Edge Config](https://vercel.com/blog/flags-as-code-in-next-js#a-primer-on-edge-config)
13. [Using a feature flag provider](https://vercel.com/blog/flags-as-code-in-next-js#using-a-feature-flag-provider)
14. [A note on init time](https://vercel.com/blog/flags-as-code-in-next-js#a-note-on-init-time)
15. [OpenFeature](https://vercel.com/blog/flags-as-code-in-next-js#openfeature)
16. [Get started today](https://vercel.com/blog/flags-as-code-in-next-js#get-started-today)

[**Try the template**\\
\\
Jump right in with this ecommerce example that shows how to use the Flags SDK for Next.js applications. Deploy the template with one click. \\
\\
Get started](https://vercel.com/templates/next.js/shirt-shop-feature-flags)

## Basic start

Install the Flags SDK using `npm install flags`.

Then declare a simple feature flag for Next.js like this:

flags.ts

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

We can then call the `showBanner` feature flag function in any server context:

app/page.tsx

```tsx
import { showBanner } from "../flags";



export default async function Page() {

4  const banner = await showBanner();

5  return (

6    <div>

7      {banner ? <Banner /> : null}

8      {/* other components */}

9    </div>

10  );

11}
```

Calling `await showBanner()` returns the value of our feature flag. Since the `decide` function is set to always return `false`, the banner will not be shown.

**_Tip:_** _Use_ [_Flags Explorer_](https://vercel.com/docs/feature-flags/flags-explorer) _to override any feature flags for your own session without affecting your team members. Overrides are great for ensuring features work before you release them for everyone. Flags SDK automatically respects overrides set by Flags Explorer._

## Guiding principles of the Flags SDK

There are several differences to how the SDKs of most feature flagging providers work today. It’s an abstraction that both encodes our best practices for working with feature flags in Next.js, while also allowing you to easily transition between different sources for your feature flags.

![](images/flags-as-code-in-next_js-vercel/img_001.jpg)![](images/flags-as-code-in-next_js-vercel/img_002.jpg)

### **Feature Flags are functions**

Turning each feature flag into its own function means the implementation can change without having to touch the call side. It also allows you to use your well-known editor aids like “Find All References” to see if a flag is still in use.

### **Feature Flags are only ever evaluated on the server**

Flags are only ever calculated on the server. The resolved value can be passed down to the client, but the evaluation itself happens server-side. This approach mitigates common pitfalls of client-side feature flag usage, such as layout shifts, jank, or exposing sensitive flags to the client.

When loading feature flags client-side there are hard limitations where the client simply doesn’t know the state of feature flags until they initialize. This means you’re left picking the worse of two evils: showing a loading spinner or potentially flashing the wrong variant until loading completes. That’s why we always force server-side evaluation.

![](images/flags-as-code-in-next_js-vercel/img_003.jpg)![](images/flags-as-code-in-next_js-vercel/img_004.jpg)

However, server-side evaluation doesn't necessarily mean dynamic pages. The SDK introduces a pattern called _precomputing,_ which enables generating multiple variants of a static page and using [Edge Middleware](https://vercel.com/docs/functions/edge-middleware) to route between them. This allows keeping pages completely static even when they have multiple feature flags on them. It’s especially beneficial for experimentation on marketing pages, but it also works extremely well for serving multiple static shells for [Partial Prerendering](https://vercel.com/docs/frameworks/nextjs#partial-prerendering).

You can learn more about precomputing feature flags [here](https://flags-sdk.dev/principles/precompute).

### **Feature Flags accept no arguments on the call side**

When we declared the `showBanner` feature flag we provided a `decide` function. This function is called to determine the value of a feature flag for a given request.

On the call side, when using `showBanner()` it’s not possible to provide any arguments to the `showBanner` function. It would technically be trivial for us to forward the passed arguments to the decided function, but we introduced this limitation on purpose.

Not being able to pass any information from the call side means the feature flag itself must be able to gather all information it depends on. We can use Next.js concepts like `headers()` and `cookies()` to gather information about the current request from within the `decide` function. We can further call React’s [cache](https://react.dev/reference/react/cache) function to ensure expensive computation and data loading is deduplicated across feature flags.

This means any call side is guaranteed to see the same value of the feature flag since they all by definition provide the same arguments.

It also means we can locally reason about the value a feature flag will resolve to, since we only need to look at the given `decide` function. This is huge for being able to change the implementation without having to change the call side. It allows migrating from one flag provider to another, on a flag by flag basis, while only changing a single file.

And finally, it’s brilliant for delete-ability of feature flags. When you remove a feature flag from code all the data it relied on will no longer be requested. There is no context that’s being established outside of the flag that ultimately ends up unused and any data requirements are deleted along with the flag.

## A primitive flag

Let’s bring flags back to their most basic form before diving deeper into the SDK.

```tsx
const showBanner = false;
```

Even a variable in code could can be seen as a feature flag. By changing the value and redeploying you’re able to modify the behavior of the application.

The value of this feature flag could be loaded from a configuration file, an environment variable, a database or a feature flag provider. The value could be the same for all visitors, or maybe it depends on information present on the request which triggered the evaluation of this feature flag. For example a flag might be on for visitors from a certain region only.

Or maybe the value of a flag even depends on data which first needs to be derived from the incoming request. Imagine a flag which should only be on for users who are part of a certain team. When your application receives a request with an Authorization header, it would first need to validate the provided token, and then potentially check whether that user is part of said team.

## Flag progressions and their tradeoffs

Let's explore various progressions of using feature flags and their respective trade-offs.

### Basic case

As we’ve seen, in its most basic form, you declare a feature flag like this when using the SDK:

flags.ts

```tsx
import { flag } from "flags/next";



export const showBanner = flag({

4  key: "banner",

5  decide: () => false,

6});
```

In the earlier example we’ve set the `showBanner` flag’s `decide` function to always return false. So if we merged this to production the banner would always be hidden. If we wanted to turn the flag on, we could change the `decide` function to return true and redeploy.

This is really the simplest possible case of a feature flag. We’ll of course get into more advanced cases in a bit, but let’s first see what this basic usage gives us and where it falls short.

**Upsides**

- **The flag resolves immediately**. As we hardcoded the value there is no network latency to resolve the flag.

- **Availability**. As we hardcoded the value it will always be available.

- **Change history**. We can see who changed the values through git.


**Downsides**

- **Slow to change**. Changing the value requires making code changes and redeploying.

- **Change bound to deployment.** We can’t change the value of a feature flag without redeploying. This means any existing deployments will never see the new value. And any deployments on other branches will not see the new value until our code change makes it onto that branch.

- **Changes affect everyone**. By hardcoding the boolean value we force the same value for every visitor.


### Overriding from Vercel Toolbar

The Vercel Toolbar is available on preview and production deployments, locally during development. Learn how to set it up [for production](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-production) and [for development](https://vercel.com/docs/workflow-collaboration/vercel-toolbar/in-production-and-localhost/add-to-localhost).

> “We were able to use ‌‌‍‌the Flags SDK and Vercel's Flags Explorer to override a flag and place real-life orders in production before revealing a set of new payment methods to our customers. This setup gives us peace of mind and makes releasing new features almost boring as we've already seen them working behind the flag.We were able to use ‌‌‍‌the Flags SDK and Vercel's Flags Explorer to override a flag and place real-life orders in production before revealing a set of new payment methods to our customers. This setup gives us peace of mind and makes releasing new features almost boring as we've already seen them working behind the flag.”
>
> ![](images/flags-as-code-in-next_js-vercel/img_005.png)
>
> **Phil Wolstenholme,** Lead Frontend Engineer at Co-op

Vercel Toolbar allows viewing and overriding your feature flags. When you use our Flags SDK you can expose your application’s feature flags [through an endpoint](https://vercel.com/docs/workflow-collaboration/feature-flags/supporting-feature-flags#flags-api-endpoint) called `/.well-known/vercel/flags`. Vercel Toolbar will make an authenticated request to that endpoint to load your application’s flags. The flags you return from there will show up in your toolbar.

![](images/flags-as-code-in-next_js-vercel/img_006.jpg)![](images/flags-as-code-in-next_js-vercel/img_007.jpg)

You can then override flags using the flags dialog in the toolbar. Any flags declared through the `flag` function from `flags/next` will automatically respect overrides set by the toolbar.

So when there is an override and you call the `showBanner` feature flag function it will return the override you set from the toolbar instead of calling the `decide` function you declared.

The way this works behind the scenes is that Vercel Toolbar sets a cookie called `vercel-flag-overrides` whenever you create an override. That cookie contains the name and value of each overridden feature flag. The cookie is also encrypted to prevent attackers from inserting arbitrary flag values. This allows any application to respect these overrides. And if you use the Flags SDK for Next.js they get respected automatically.

This is important because when we set the `decide` function to always return `false`, this allows us to merge our feature to production without showing it to anyone yet.

**Safe releases**

We could then use Vercel Toolbar to override the `banner` feature flag, so we can peek what the feature would look like and ensure it works correctly in production before turning it on for everyone.

**Short-lived branches**

Another benefit of this approach is using small branches and merging new functionality early, while keeping it hidden. This approach is called _trunk based development_. Splitting work into small branches that are merged early helps prevent long running branches that get out of sync with main, which helps avoid merge conflicts down the road.

**End-to-end testing**

Another benefit is that your end-to-end tests can call the [encrypt](https://vercel.com/docs/workflow-collaboration/feature-flags/vercel-flags#encrypt) function to create a flag override cookie value to be used in your tests. This way your end-to-end test can easily test multiple scenarios.

_**Note:**_ _This approach is perfect for trunk-based development. You can merge your code and try it out in production, without introducing latency or long running branches. And you don’t even need to use any feature flagging provider, suffer any additional latency or take any risks on availability._

## Using an environment variable

Instead of hardcoding our `decide` function to always return `false` we could check an environment variable instead.

```tsx
export const showBanner = flag({

2  key: "banner",

3  decide: () => process.env.SHOW_BANNER === "1",

4});
```

This small change means we can change the feature flag for our end users without making code changes. Imagine setting the `SHOW_BANNER` environment variable to be on for preview deployments of a specific branch, but to be off for production. This way you could test the banner on those preview deployments without showing it to your users in production yet. You could still use Vercel Toolbar to override the flag in production once the branch merges.

When it’s time to release the feature to production you simply flip the environment variable.

And since we hardcoded the environment variable we would still have the highest possible availability, paired with the lowest possible latency for this flag.

Changing the flag would still require redeploying, so changing the feature flag would not affect previous deployments. This is usually not what you want, and we can solve it using Edge Config in the next step.

_**Note:**_ _This approach is perfect for operational feature flags. Imagine swapping out a backend service like a payment gateway in case one is having issues._

## Using Edge Config

So far, any changes to the flags required redeploying, and did not affect any existing deployments. In this step we’ll change that.

The `decide` function can actually be asynchronous, which allows us to read any data source. You can imagine querying a database, or reading from an external configuration source.

### **A primer on Edge Config**

At Vercel we’ve built a data store tailored to storing feature flags and other configuration called [Edge Config](https://vercel.com/docs/storage/edge-config). Edge Config uses active global replication to push and colocate your configuration along with your compute. Reading Edge Config from applications deployed on Vercel typically takes under 1ms p90. Changes to Edge Config propagate globally in under 10s. It’s extremely available and most Edge Config reads do not even go over the network. We can achieve these outstanding features since we handle your deployments, so we’re in a unique position to also propagate configuration data along with them.

Okay, back to using an external data source like Edge Config from our Flags SDK.

The following code assumes your project is connected to an Edge Config which holds this data:

```tsx
1{

2	"flags": {

3		"banner": true,

4		"sale": false

5	}

6}
```

We can now use Edge Config’s `get` function to read the "flags" key defined in Edge Config:

flags.ts

```tsx
import { flag } from “flags/next”;

import { get } from “@vercel/edge-config”;



export const showBanner = flag({

5  key: “banner”,

6  defaultValue: false,

7  async decide() {

8    // educational example, use @flags-sdk/edge-config for real applications

9    const flags = await get(“flags”);

10    return flags?.banner;

11  }

12});
```

The example above is educational to show how Edge Config and the Flags SDK connects, but it would cause a separate Edge Config read for every feature flag.

Use the [Edge Config Provider](https://flags-sdk.dev/providers/edge-config) which contains further optimizations like only reading the underlying Edge Config once per request rather than once for every feature flag:

flags.ts

```typescript
import { flag } from 'flags/next';

import { edgeConfigAdapter } from '@flags-sdk/edge-config';



export const showBanner = flag({

5  // Will get the `example-flag` key from the `flags` object

6  key: 'banner',

7  // Will load the `flags` key from Edge Config

8  adapter: edgeConfigAdapter(),

9});
```

With this new setup, we can now edit Edge Config and the new value will be used by our flag without having to redeploy our application. To change values in Edge Config we can either use [the API endpoint](https://vercel.com/docs/storage/edge-config/vercel-api) or [the editor](https://vercel.com/docs/storage/edge-config/edge-config-dashboard).

![](images/flags-as-code-in-next_js-vercel/img_008.jpg)![](images/flags-as-code-in-next_js-vercel/img_009.jpg)

This means we no longer need to wait for a redeployment, so the new value is available in seconds, globally.

You’ll notice that Edge Config is an async function, so we’re no longer getting the value immediately. We introduced a tiny bit of latency. But since Edge Config was built for this exact use case the additional latency is negligible.

So we’ve now traded a bit of added latency for the ability to change feature flags without having to redeploy our applications.

_**Note:**_ _This approach is perfect for feature flags where you need to be able to quickly kill a feature, or when you want to time a launch perfectly. Since Edge Config creates a backup for every change you’re also able to see a history of changes and restore previous values quickly._

## Using a feature flag provider

In case you’re already using a feature flag provider you can also integrate them. You can call your feature flag provider from within the `decide` function.

```tsx
1// flags.ts

import { flag } from "flags/next";

import { statsigAdapter } from "@flags-sdk/statsig";



export const showBanner = flag({

6  key: "banner",

7  adapter: statsigAdapter.featureGate((gate) => gate.value),

8})‌;﻿‍﻿﻿‌﻿‌‌‍‌﻿‌‍‍‌‌‍﻿‍​‍​‍​﻿‍‍﻿‌‍﻿﻿‌‍﻿‍‌﻿‌‌‍‌‌‌‍﻿‍‌﻿‌‌‍‌‍‌﻿‌‌‌‍﻿﻿‌‍﻿﻿‌‍﻿‌‌﻿‌‌‍‌‍​‍​‍​﻿‍‍﻿‌‍​‌‌﻿‌‍‍‌﻿‌‍​‍‌‍﻿‌‍﻿﻿‌‍‌﻿﻿‌‍‌‌‌‍‌‌‍‍‌‌﻿‌﻿﻿﻿‌‍‌‌﻿﻿‌﻿‌﻿‌‌‌﻿‌‌‌﻿‌‌﻿﻿‌﻿‌‌‌﻿‌﻿‌‌﻿‍‍‌‌‍‍‌‍‌‌‌‌﻿‌‌‍​﻿‌‍‍﻿‌‍‍‌‌‍‌﻿‌‌‌‌‍‌‌‌﻿﻿‌﻿﻿‌‌‍‌‌﻿﻿‌
```

The code snippet above uses a fictional feature flag provider’s SDK to load feature flags. It shows how you would integrate a feature flagging provider. They typically implement a singleton pattern where you need to await the client’s init before you can access the data.

### **A note on init time**

The SDKs of most feature flag providers are built for long-running servers which fire an initial network request to load the flag configuration once and then update it in the background going forward. This works well in the traditional world of long-running servers as you only pay the price of the slow initial request once. But in today’s serverless world, functions start and stop quite frequently, especially on Edge Middleware the average lifetime of a function instance is in the order of seconds, not minutes.

It’s important that cold instances of your application are able to load flag configurations quickly to keep latency low. That’s why we partnered with [Statsig](https://vercel.com/integrations/statsig), [Hypertune](https://vercel.com/integrations/hypertune), [LaunchDarkly](https://vercel.com/integrations/launchdarkly), [Split](https://vercel.com/integrations/split) and more who created integrations which synchronize their feature flag configuration into Edge Config. Your application can then bootstrap your flag provider’s SDK from Edge Config avoiding the initial network request and the latency that comes with it.

### **OpenFeature**

You might have wondered how the Flags SDK compares to [OpenFeature](https://openfeature.dev/). OpenFeature describes itself as an “open specification that provides a vendor-agnostic, community-driven API for feature flagging that works with your favorite feature flag management tool or in-house solution”.

The Flags SDK and OpenFeature work really well together. You can use the [Flags SDK OpenFeature adapter](https://flags-sdk.dev/providers/openfeature) to get the value of a feature flag in a vendor-agnostic way. This way you can easily swap vendors while still benefiting from the Flag SDK’s nice integration into frameworks and the pre-computation pattern.

_**Recap:**_ _We’ve seen we can use the Flags SDK to pick the right tradeoffs per feature flag, depending on how that feature flag is going to be used. It works well with existing feature flag providers and OpenFeature._

## Get started today

The Flags SDK allows you to choose the right tradeoff for each feature flag without having to refactor the code actually using your flags.

These progressions allow your flag to scale up and down as your feature matures. A flag can start out as a simple hardcoded boolean, mature to a rollout or full-blown experiment and then go back to being a simple operational toggle backed by an environment variable after a successful rollout.

We're excited to equip developers with these powerful new tools for working with feature flags, shipping safely, experimenting smarter, and building truly exceptional web experiences.

[**Check out the SDK**\\
\\
Start experimenting server-side, with better performance and less jank. \\
\\
View the docs](https://flags-sdk.dev/)