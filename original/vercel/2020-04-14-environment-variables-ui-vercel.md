---
title: "Environment Variables UI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/environment-variables-ui"
date: "2020-04-14"
scraped_at: "2026-03-02T10:06:57.044540085+00:00"
language: "en"
translated: false
description: "Configure different Environment Variables for Production, Preview, and Development – right in the Dashboard."
---




Apr 14, 2020

Customize Environment Variables for projects in your Dashboard

If you are working on a sophisticated project, you might have found yourself wanting to configure different Environment Variables depending on the Environment your project is deployed to.

With today's release, we're making it possible to configure different **Environment Variables** for **Production**, **Preview**, and **Development** – right in the Dashboard.

## New project setting

To configure an Environment Variable for your project, simply navigate to your Project Settings and look for the newly added Environment Variables section:

![The new "Environment Variables" field in the Project Settings.](images/environment-variables-ui-vercel/img_001.jpg)The new "Environment Variables" field in the Project Settings.

Within this section, you can assign an Environment Variable to the Production, Preview, or Development Environment, depending on where you want it to be available.

### System environment variables

The platform provides several Environment Variables that contain values provided by the system, such as the URL of the deployment or the name of the Git branch that the deployment origined from.

In order to make one of them available to your code, choose it from [this list](https://zeit.co/docs/v2/build-step#system-environment-variables) and enter its name into the project setting like so:

![Configuring a System Environment Variable.](images/environment-variables-ui-vercel/img_002.jpg)Configuring a System Environment Variable.

## New command for Vercel CLI

Environment Variables specified for the **Development** **Environment** are made available to your team and can be downloaded into a local development setup using a newly added `vercel env pull` command, which automatically creates a `.env` file:

```bash
1$ vercel env pull

Vercel CLI 18.0.0

Downloading Development Environment Variables for project my-site

4✅ Created .env file [510ms]
```

Retrieving Development Environment Variables locally

At least version **18.0.0** of [Vercel CLI](https://vercel.com/download) is required to be able to run this command.

Furthermore, you can use `vercel env add` and `vercel env remove` to add or remove Environment Variables from your project, directly from the command-line.

## Conclusion

The new Environment Variables section in the Project Settings lets you specify different Environment Variables for Production, Preview, and Development, without creating a `vercel.json` configuration file.

Additionally, sharing Development Environment Variables with your colleagues is now easier than ever before, since they can be pulled from the project using `vercel env pull`.

[Let us know](https://zeit.co/contact) what you think about this change. We're excited to help you succeed.