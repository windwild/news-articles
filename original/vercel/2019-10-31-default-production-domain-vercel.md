---
title: "Default Production Domain - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/default-production-domain"
date: "2019-10-31"
scraped_at: "2026-03-02T10:07:50.855952322+00:00"
language: "en"
translated: false
description: "Every new project now receives a default production domain."
---




Oct 31, 2019

When creating a new project, it's important that the road to sharing a working production URL of your newly deployed code is as short as possible, with the least amount of friction.

With today's announcement, we're ensuring exactly that.

## New Default Domain

By creating a new project, you will now automatically see a `vercel.app` domain with the name of your project and a random animal appear on your project's Domains tab.

For example, if your project is called **"my-site"**, your default production domain could look like this:

![The default production domain is automatically assigned to your deployments.](images/default-production-domain-vercel/img_001.jpg)The default production domain is automatically assigned to your deployments.

## Deploying to Production

In order to deploy to production, [push to your default branch](https://zeit.co/docs/v2/git-integration) with our Git integration or run `vercel --prod` with our [command-line interface](https://zeit.co/download).

The first deployment in every newly created project is automatically promoted to production.

## Editing Your Domain

Even if you don't like your default production domain, that's not a problem. Changing your production domain is now as easy as clicking **"Edit"** and entering a new one:

![You can edit the default production domain or add a custom domain.](images/default-production-domain-vercel/img_002.jpg)You can edit the default production domain or add a custom domain.

## API Changes

The endpoints for [creating a project](https://zeit.co/docs/api#endpoints/projects/create-a-project) and [ensuring a project exists](https://zeit.co/docs/api#endpoints/projects/ensure-a-project-exists) have been adjusted accordingly and will automatically provide you with a production domain.

To opt-in to this feature, you will need to use the latest version of the project endpoints.

## Conclusion

With default production domains, you can [deploy to production](https://vercel.com/blog/default-production-domain#deploying-to-production) without having to set up a [custom domain](https://zeit.co/docs/v2/custom-domains/) first.

This drastically decreases the time it takes for you to share a working version of your project.

[Let us know what you think](mailto:support@vercel.com) about this change!