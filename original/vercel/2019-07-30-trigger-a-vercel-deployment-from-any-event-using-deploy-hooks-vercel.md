---
title: "Trigger a Vercel deployment from any event using Deploy Hooks - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/introducing-deploy-hooks"
date: "2019-07-30"
scraped_at: "2026-03-02T10:07:36.186510874+00:00"
language: "en"
translated: false
description: "With Deploy Hooks, you can create a deployment based on any event."
---




Jul 30, 2019

Trigger new deployments using any external event.

Thanks to our first-class [GitHub](https://zeit.co/github) and [GitLab](https://zeit.co/gitlab) Integrations, you can simply push your code to deploy with [Vercel](https://zeit.co/home). But what if you wanted to create a deployment not based on change of source code, but another external event, such as an update in CMS content?

Starting today, you can **deploy based on** **_any_** **event with Deploy Hooks.**

![An illustration of a Vercel Deploy Hook set on Contentful. The Deploy Hook ensures a build and deployment each time content is updated.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_001.jpg)An illustration of a Vercel Deploy Hook set on Contentful. The Deploy Hook ensures a build and deployment each time content is updated.

## What is a Deploy Hook?

A Deploy Hook is a URL that accepts POST requests to trigger deployments with Vercel.

Any platform that can make POST requests can trigger Deploy Hooks — this includes third-party services such as headless CMSes, cron utilities, and even your command line.

## Static Example: Gatsby + Contentful

In order to illustrate Deploy Hooks, we consider the popular pairing of a [Gatsby](https://gatsbyjs.org/)-powered static site, backed by content on [Contentful](https://contentful.com/). Let's set it up so that the static site automatically builds and deploys each time content is updated.

**1\. Set up Boilerplate**

Luckily for us, the Contentful community already has a [Gatsby + Contentful](https://github.com/contentful-userland/gatsby-contentful-starter) boilerplate available.

```bash
gatsby new contentful-starter https://github.com/contentful-userland/gatsby-contentful-starter
```

The boilerplate is a beautiful and fast blog demo powered by Gatsby and Contentful.

**2\. Sign up for Contentful and Obtain Tokens**

Once signed up, we run the `setup` script highlighted on [Contentful](https://contentful.com/)'s onboarding page.

![`npm run setup` takes care of setting up the environment variables that Gatsby needs from Contentful.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_002.jpg)\`npm run setup\` takes care of setting up the environment variables that Gatsby needs from Contentful.

Next, we set the `CONTENTFUL_SPACE_ID` and `CONTENTFUL_ACCESS_TOKEN` [environment variables](https://zeit.co/docs/v2/build-step#using-environment-variables-and-secrets).

**4\. Create Deploy Hook and Specify on Contentful**

We want our Gatsby site to re-build and deploy whenever there is an update in Contentful. Therefore, we create a Deploy Hook pointing to the git `master` branch, and specify the Deploy Hook as a **webhook** within Contentful.

It's easy to create a Deploy Hook for any Vercel project — the [docs](https://zeit.co/docs/v2/advanced/deploy-hooks/) visually explain how.

![Once the webhook is created, our setup is complete.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_003.jpg)Once the webhook is created, our setup is complete.

## Trying it Out!

When we update content via Contentful, a new static Gatsby build is created. After a brief wait, our site is deployed and the updated content is live for us to see!

Gatsby + Contentful + Vercel Deploy Hooks in action

## Reliability and Robustness

In order to create a robust system, we have kept several checks in place:

- **Automatically debounced builds**. You can POST to the Deploy Hook multiple times, and our systems will intelligently discard duplicate deployments.


- **Straightforward revoking**. If you suspect that you may have accidentally leaked your Deploy Hook, you can easily swap the existing hook for a new one within your project settings.


- **Clear timeline of deployment activity**. Under the [Events](https://zeit.co/dashboard/events) tab, you can clearly identify deployments created via hooks.


![The Events timeline clearly showcases all the deployments, including their sources.](images/trigger-a-vercel-deployment-from-any-event-using-deploy-hooks-vercel/img_004.jpg)The Events timeline clearly showcases all the deployments, including their sources.

## Conclusion

With Deploy Hooks, you can now deploy based on _any_ event.

In this post, we explored how Deploy Hooks can help you **automatically re-build and deploy** a static site based on content updates.

How do you intend on using Deploy Hooks? Let us know via [Twitter](https://twitter.com/vercel) or [Chat](https://zeit.co/contact)!