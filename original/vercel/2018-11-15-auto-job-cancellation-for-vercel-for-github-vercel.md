---
title: "Auto Job Cancellation for Vercel for GitHub - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/auto-job-cancellation-for-vercel-github"
date: "2018-11-15"
scraped_at: "2026-03-02T10:07:45.826917761+00:00"
language: "en"
translated: false
description: "Deploying the latest push with Vercel for GitHub for the latest changes in an instant."
---




Nov 15, 2018

When you connect your GitHub organization to Vercel, with [Vercel for GitHub](https://vercel.com/github), we build and deploy your app for each every Git push. We call such an event a `job`.

For a given branch, we process each job in a queue. If multiple jobs are waiting, we pick the latest one to build. Vercel for GitHub will always give you the deployment URL for the most recent commit.

## Introducing Auto Job Cancellation

As projects grow in size, builds tend to take longer. If you have regular commits coming in for these projects, one after another, the build time will add up and delay the deployment of the latest commit.

**From today, Vercel will always build the latest commit immediately.**

![Auto canceled job on the `master` Git Branch.](images/auto-job-cancellation-for-vercel-for-github-vercel/img_001.jpg)Auto canceled job on the \`master\` Git Branch.

While waiting for build job to complete, if Vercel receives a new job from the most recent commit, we cancel the current job and start building the latest job.

With this new behavior, you can always get the deployment URL for the latest changes right away.

![Auto canceled job on a Pull Request.](images/auto-job-cancellation-for-vercel-for-github-vercel/img_002.jpg)Auto canceled job on a Pull Request.

## Opt-out support

We think auto job cancelation is a tremendous new default behavior **that will save you both time and money**.

However, if you want every push to build in sequence, Vercel provides an option to be added in a [`vercel.json` configuration file](https://zeit.co/docs/v2/deployments/configuration#github-autojobcancelation).

```json
1{

2  "github": {

3    "autoJobCancelation": false

4  }

5}
```

## Conclusion

Our goal for Vercel is always to provide deployments for any project as quickly as possible. We believe that this new Vercel for GitHub behavior that extends a great method to receive deployments from your most recent changes is a great benefit to this goal.

If you have any questions or feedback, we would love to hear from you. Feel free to always [reach out to us](https://zeit.co/chat).