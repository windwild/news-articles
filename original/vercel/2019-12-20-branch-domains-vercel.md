---
title: "Branch Domains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/branch-domains"
date: "2019-12-20"
scraped_at: "2026-03-02T10:07:24.903351410+00:00"
language: "en"
translated: false
description: "Assign a Git Branch to your domain, so that every deployment created on it will automatically receive the domain."
---




Dec 20, 2019

Assign a stable domain to your Vercel branch deployments.

After editing your project, previewing your changes with Vercel is only a matter of pushing a Git commit using our [Git Integration](https://zeit.co/docs/v2/git-integration/), or by running a single command using our [command-line interface](https://zeit.co/download).

Every Deployment created in either way receives a unique URL, yet you still might want to apply a **Custom Domain for your Preview Deployments**. Today, we are making this possible with **Branch Domains.**

## A new domain setting

To apply a domain to a Git Branch of your choice, you first need to ensure that your project is linked to a Git repository on the project's overview page:

![Connect your project to a Git repository.](images/branch-domains-vercel/img_001.jpg)Connect your project to a Git repository.

Next, add a new domain and select a **Git Branch**:

![Select a Git Branch that you want to assign your Domain to.](images/branch-domains-vercel/img_002.jpg)Select a Git Branch that you want to assign your Domain to.

To complete the setup, save and push a new commit to the selected Git Branch.

Once you've done that, your domain will automatically point to the **most recent Deployment** created on that Git Branch. Congratulations!

Next time you push a new commit, your domain will be updated to reflect it.

If you prefer to do this using the Vercel REST API instead, you can use the ["Update a project domain"](https://vercel.com/docs/rest-api#endpoints/projects/update-a-project-domain) PATCH endpoint.

## Conclusion

By configuring a Custom Domain for your Preview Deployments through the **Git Branch** setting, you can now retain your preferred domain (and therefore your branding), even when sharing Preview Deployments with customers or colleagues.

Check out [our documentation](https://vercel.com/docs/v2/custom-domains/) to learn more about this feature.

All our work is inspired by feedback from people like yourself. For feature requests, or to suggest ideas to make our platform and your experience better, please reach out to us [via email](mailto:support@vercel.com) or on [Twitter](https://twitter.com/vercel).