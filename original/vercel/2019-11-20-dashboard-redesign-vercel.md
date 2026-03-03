---
title: "Dashboard redesign - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/dashboard-redesign"
date: "2019-11-20"
scraped_at: "2026-03-02T10:07:18.958626051+00:00"
language: "en"
translated: false
description: "We're bringing the simplicity of our developer experience to our web dashboard. Creating new projects, importing existing code, managing domains, setting up redirects, inspecting deployments and funct..."
---




Nov 20, 2019

With the launch of [Zero Config Deployments](https://zeit.co/blog/zero-config), Vercel made it easier than ever to deploy websites and applications. Now, we're bringing the simplicity of our developer experience to our web dashboard.

Creating new projects, importing existing code, managing domains, setting up redirects, inspecting deployments and functions, and managing teams has never been easier.

We are unveiling the next evolution of the **Vercel Dashboard**.

![The new Vercel Dashboard.](images/dashboard-redesign-vercel/img_001.jpg)The new Vercel Dashboard.

## Dashboard Overview

This dashboard redesign is guided by invaluable feedback from our active customers. We want to make the most crucial project elements easily accessible to you:

- Production and latest deployment status.

- Project-level git repository connection.

- Links to production deployments.


## Easily Import Code

With our [GitHub](https://zeit.co/github) and [GitLab](https://zeit.co/gitlab) integrations, we now offer a streamlined approach to import and deploy projects with Vercel, directly from your dashboard. Once imported, your repository will be configured automatically so that you can push to deploy.

![Automatically deploy a template or repository to Vercel](images/dashboard-redesign-vercel/img_002.jpg)Automatically deploy a template or repository to Vercel

## Projects

For a quick glimpse of your projects, we now provide screenshots of your latest production deployments.

![An overview of all your Vercel projects, accompanied with screenshots](images/dashboard-redesign-vercel/img_003.jpg)An overview of all your Vercel projects, accompanied with screenshots

## Project Overview

We now highlight the two most important aspects of your projects: production deployment and preview deployments. Stay informed about your live production deployment, and see what your teammates are working on with a preview deployments list filtered by each member.

![An overview of your live production deployment.](images/dashboard-redesign-vercel/img_004.jpg)An overview of your live production deployment.

![Preview Deployments from Git branches or deployed with Vercel.](images/dashboard-redesign-vercel/img_005.jpg)Preview Deployments from Git branches or deployed with Vercel.

## Deployment Overview

To help debug your projects, logs are now incorporated into the deployment overview. Logs can now be filtered by a specific serverless function or build output and copied to your clipboard in a single click.

If the deployment is made with our [GitHub](https://zeit.co/github) or [GitLab](https://zeit.co/gitlab) integrations, you will find relevant information about the git commit, author, branch, and repository.

![The overview provides meaningful information about an individual deployment.](images/dashboard-redesign-vercel/img_006.jpg)The overview provides meaningful information about an individual deployment.

## Browser Tab Improvements

Like us, you probably have a lot of tabs open while you work. For a quicker overview of your projects, the tab icons and titles of our dashboard pages now contain more useful information.

On the deployment inspector, the status of your deployment is now reflected in the tab icon as queued, building, error, or ready.

Browser tab icons reflect the status of a deployment.

## Git Integration for Projects

It's now easier than ever to link a code repository to your Vercel projects. Once linked, you can enjoy automatic deployments with shareable URLs every time you push a commit or open a pull request.

![Select a repository from the project page to automatically deploy on every commit.](images/dashboard-redesign-vercel/img_007.jpg)Select a repository from the project page to automatically deploy on every commit.

## Production Domains

As part of [Zero Config Deployments](https://zeit.co/blog/zero-config), you can now associate production domains with each of your projects in place of the `alias` field of `vercel.json`. This includes `.vercel.app` domains and any custom domains bought through [Vercel](https://zeit.co/domains) or external services.

![The interface guides you in setting up production domains for your project.](images/dashboard-redesign-vercel/img_008.jpg)The interface guides you in setting up production domains for your project.

![A valid production domain](images/dashboard-redesign-vercel/img_009.jpg)A valid production domain

## Mobile

With improvements to our development tooling and design system, we're ensuring that every part of our dashboard works well on both desktop and mobile so you can manage your deployments on the go.

![The Vercel Dashboard on mobile.](images/dashboard-redesign-vercel/img_010.jpg)The Vercel Dashboard on mobile.

## Performance

We understand very well that any great user experience demands great performance.

For this redesign, we didn't just stop with UI improvements. We also invested heavily in enhancing the dashboard performance — decreasing the time to First Meaningful Paint by over 1.2s.

Here are a few steps we've taken to improve the performance of the Vercel Dashboard

- [Preconnect](https://developers.google.com/web/fundamentals/performance/resource-prioritization#preconnect) to our API, Assets, and Avatar origins.

- Assign critical API calls higher [browser priority](https://developers.google.com/web/fundamentals/performance/resource-prioritization) to avoid blocking requests.

- Memoize in our React components with the `useMemo` and `useCallback` hooks.

- Adopt `ReactDOM.unstable_batchedUpdates` to reduce unnecessary re-renders by 20%.

- Implement [SWR](https://github.com/zeit/swr) to efficiently update dashboard data in realtime.


## Conclusion

With a focus on providing better interactions with your projects and deployments, our new dashboard delivers improved speed, better performance, and more useful features. This redesign includes:

- Dashboard overview.

- Project-level repository connection.

- Code import from source control.

- Production domains process.

- Performance enhancements.


We would love to hear your thoughts on our new dashboard! If you'd like to share feedback, ask questions, or just say hi, you can reach out to us over [Twitter](https://twitter.com/vercel) or [Chat](https://zeit.co/chat).

A special thank you to [Ana Trajkovska](https://twitter.com/AnaTrajkovska_), [Arunoda Susiripala](https://twitter.com/arunoda), [Leo Lamprecht](https://twitter.com/notquiteleo), and [Timothy Lorimer](https://twitter.com/timothyis_) for helping with making this release a reality.