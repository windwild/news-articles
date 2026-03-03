---
title: "Vercel for Bitbucket - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/bitbucket"
date: "2019-11-27"
scraped_at: "2026-03-02T10:07:20.945066842+00:00"
language: "en"
translated: false
description: "Push code to Bitbucket and automatically deploy with Vercel."
---




Nov 27, 2019

[Bitbucket](http://bitbucket.com/) is popular among teams as the central place to plan projects, collaborate on code, test, and deploy — especially in combination with Jira and Trello.

**Today, we are proud to announce our first-class Bitbucket integration,** [**Vercel for Bitbucket**](https://zeit.co/bitbucket).

Vercel makes it easy for you to build and deploy code — whether you need a static website, Serverless Functions, or both combined. If you use Bitbucket in your development workflow, you can now take advantage of **automatic deployments with built-in CI/CD, DNS, and TLS**.

![Commits pushed to Bitbucket are automatically built and deployed with Vercel.](images/vercel-for-bitbucket-vercel/img_001.jpg)Commits pushed to Bitbucket are automatically built and deployed with Vercel.

## Built-in Preview Deployments

Through preview deployments of feature branches, your team can test changes thoroughly, providing more confidence when iterating and merging.

Our Bitbucket integration brings [preview deployments](https://vercel.com/docs/v2/platform/deployments/#preview) to your workflow with no setup required.

## Enable Automatic Deployments

Setting up automatic deployments to Vercel via Bitbucket is simple:

1. Connect to Bitbucket with **one click** and link your project

2. Every `git push` to your project triggers a deployment to a preview URL

3. When merging to the [default branch](https://confluence.atlassian.com/bitbucket/branching-a-repository-223217999.html#BranchingaRepository-Branchtypes) (usually `master`), your [production domains](https://vercel.com/docs/v2/platform/deployments/#production) are updated


When changes are reverted on the default branch, an **instant rollback** is performed on the production domain — aliasing to the previous production deployment.

## Connect with Bitbucket

The first step in setting up the Bitbucket integration is to **Connect with Bitbucket**. This makes the integration available to all your Bitbucket projects. Additionally, you can then also to **Log In to Vercel via Bitbucket**.

To get started, visit the [accounts page](https://zeit.co/account) on your individual or team **Vercel** account, navigate to the **Git Integrations** tab, and click the **Connect with Bitbucket** button.

![Connect your individual or team account with Bitbucket.](images/vercel-for-bitbucket-vercel/img_002.jpg)Connect your individual or team account with Bitbucket.

When Bitbucket requests authorization, click **Grant Access**.

![Click "Grant Access" to complete the Bitbucket connection process](images/vercel-for-bitbucket-vercel/img_003.jpg)Click "Grant Access" to complete the Bitbucket connection process

Once you authorize Bitbucket, it redirects you back to Vercel. This completes the account connection process, and you automatically activate the ability to **Continue with Bitbucket** the next time.

![Once you connect Bitbucket, you also activate the ability to Log In to Vercel with Bitbucket.](images/vercel-for-bitbucket-vercel/img_004.jpg)Once you connect Bitbucket, you also activate the ability to Log In to Vercel with Bitbucket.

## Link Projects

After your Bitbucket account is connected through the **Vercel** [accounts page](https://zeit.co/account), you can set up automatic deployments for a Bitbucket project by linking it to Vercel, with the help of a dropdown.

![Once linked, pushes made to the Bitbucket project will be automatically deployed with ZEIT Now.](images/vercel-for-bitbucket-vercel/img_005.jpg)Once linked, pushes made to the Bitbucket project will be automatically deployed with ZEIT Now.

Select the Bitbucket project you would like to link to from the provided dropdown. Once linked, the Bitbucket project is set up for automatic Vercel deployments.

## What Happens After Linking

For every `git push` made, we build and deploy the latest commit with Vercel. The deployment is guided by the project framework using [zero-config](https://zeit.co/blog/zero-config) or a [`vercel.json` file](https://zeit.co/docs/v2/deployments/configuration).

**By default, we deploy every push**. This means that every `git push` made to a Pull

Request branch is deployed — allowing collaborators to preview changes before they're merged and deployed to production.

Within a Pull Request, if Vercel is still building a commit from a previous push, **that build is canceled in favor of the most recently pushed commit**. This allows collaborators the quickest access to fresh changes.

## Conclusion

Our mission at **Vercel** is to make the cloud accessible to everyone. The [Vercel for Bitbucket](https://zeit.co/bitbucket) integration was one of our most requested features. We are excited about this announcement and hope that it makes your development workflow smoother.

All of our work is heavily driven by feedback from our users. For feature requests, or to suggest ideas to make our platform and your experience better, please reach out to us [over chat](https://zeit.co/chat) or on [Twitter](https://twitter.com/vercel).