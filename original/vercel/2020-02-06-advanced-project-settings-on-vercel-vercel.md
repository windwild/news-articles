---
title: "Advanced Project Settings on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/advanced-project-settings"
date: "2020-02-06"
scraped_at: "2026-03-02T10:07:18.807367234+00:00"
language: "en"
translated: false
description: "Fully customize your project’s behaviour or hit the ground running using our new framework presets."
---




Feb 6, 2020

Control your projects with improved importing, settings, and Vercel CLI.

With the launch of [Zero Config Deployments](https://zeit.co/blog/zero-config), we made setting up your projects as easy as [importing a Git repository](https://zeit.co/docs), and having every push and pull request deployed with Vercel. No configuration.

Today, we're extending this process to non-JavaScript projects (like [Hugo](https://gohugo.io/) sites) and giving you full control over your project's automatically configured settings.

## Better Import

If your code is located in a subdirectory, you'll find it useful that connecting one of your Git repositories to Vercel will prompt you for specifying a **Root Directory**.

Additionally, you can now select a different **Framework** or overwrite its default settings:

![Select the right settings for your needs when importing repositories.](images/advanced-project-settings-on-vercel-vercel/img_001.jpg)Select the right settings for your needs when importing repositories.

## Better Project Settings

Once you've deployed your project, you might still want to continue tweaking its configuration until it meets all your needs – no matter how advanced they are.

Because of that, you can now fully customize all of the options mentioned above right from the Project Settings:

![Adjust your project's configuration at any time.](images/advanced-project-settings-on-vercel-vercel/img_002.jpg)Adjust your project's configuration at any time.

All of the fields are automatically optimized for your Framework by default. Overwriting one of them, however, is as easy as turning on the `OVERRIDE` toggle.

## Better Vercel CLI

After [importing your Git repository](https://zeit.co/docs/v2/git-integrations), every push and pull request gets deployed automatically. However, sometimes you might want to create a quick manual deployment from the CLI.

To make this easy, creating new projects through our [command-line interface](https://zeit.co/download) now surfaces the automatically detected configuration and lets you edit it on the fly:

![Setting up a new Vercel project using Vercel CLI.](images/advanced-project-settings-on-vercel-vercel/img_003.jpg)Setting up a new Vercel project using Vercel CLI.

For subsequent deployments, those values naturally don't have to be configured:

![Deploying to an existing Vercel project using Vercel CLI.](images/advanced-project-settings-on-vercel-vercel/img_004.jpg)Deploying to an existing Vercel project using Vercel CLI.

In order to run `vercel dev,` please make sure to first deploy using `vercel`. Additionally, `vercel --confirm` can be run to auto-confirm the prompts.

Aside from allowing for customizing your Framework settings, as you can see, Vercel CLI now also lets you link your local codebase to any project on Vercel – no matter its name or scope.

## Conclusion

Thanks to the above changes, several new use cases are now possible:

- Projects without a `package.json` file (like [Hugo](https://gohugo.io/) or [Jekyll](https://jekyllrb.com/) sites) can be deployed.

- Your project can be located in a subdirectory of your Git repository.

- The Build Command, Development Command, and Output Directory can be customized.


The `--name` flag is now [deprecated](https://vercel.com/docs/now-cli#commands/now/unique-options/name) in Vercel CLI.

With this release, we've also paved the way for several additional fields that will enable an even more extensive range of use cases in the future. [Stay tuned](https://twitter.com/vercel) [!](https://twitter.com/zeithq)