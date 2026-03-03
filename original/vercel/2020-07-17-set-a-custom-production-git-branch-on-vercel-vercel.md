---
title: "Set a custom production Git branch on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/custom-production-branch"
date: "2020-07-17"
scraped_at: "2026-03-02T10:06:36.866749745+00:00"
language: "en"
translated: false
description: "As of today, you can customize the Production Branch of your Projects right in the Project Settings."
---




Jul 17, 2020

Up until now, after [creating a new Project](https://vercel.com/import) from a Git repository or one of our examples, all commits to its _default branch_ were being deployed to Production.

Today we are introducing a new default for newly created Projects, as well as an easy way to customize it from your Project Settings.

## New production branch for new projects

Instead of the Git repository's _default branch_, new Projects will now issue Production Deployments for the `main` branch.

If it doesn't exist, the `master` branch will be used ( [more details](https://vercel.com/blog/custom-production-branch#a-note-on-the-master-branch)). And if that doesn't exist either, the Git repository's _default branch_ will be used.

Existing Projects are unaffected by this change.

## New project setting

On the new **Production Branch** section under **Git Integration** in the Project Settings, you can now also select one of the following options:

- The `main` branch.

- The Git repository's _default branch_.

- Any other custom branch of your choice.


![The default Production Branch configuration in the Project Settings.](images/set-a-custom-production-git-branch-on-vercel-vercel/img_001.jpg)The default Production Branch configuration in the Project Settings.

## A note on the master branch

As you might have noticed, we left out `master` as an option you can select from the dropdown.

This is an intentional decision, in anticipation and agreement with Git providers like [GitHub](https://www.bbc.com/news/technology-53050955) moving away from terms that evoke prejudice and belong to the past.

For reasons of compatibility, creating a new Project from a Git repository that still uses `master` will automatically populate the `Custom` option. If you rename the branch in the future, you can easily change to `main` with just two clicks.

## Conclusion

With this change, you gain the flexibility to configure your repository's _default branch_ for your Project's ongoing work. When you push to that branch, we will create Preview Deployments, and when you push to `main` we will create Production Deployments.

Furthermore, if you don't want to use `main`, you can now select any branch you want for your Production Deployments.

Check out the [documentation](https://vercel.com/docs/v2/git-integrations#production-branch) for more details and [let us know](https://twitter.com/vercel) what you think about this change.