---
title: "Auto Job Cancellation for Vercel for GitHub - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/auto-job-cancellation-for-vercel-github"
date: "2018-11-15"
scraped_at: "2026-03-02T10:07:45.826917761+00:00"
language: "en-zh"
translated: true
description: "Deploying the latest push with Vercel for GitHub for the latest changes in an instant."
---

Nov 15, 2018

2018 年 11 月 15 日

When you connect your GitHub organization to Vercel, with [Vercel for GitHub](https://vercel.com/github), we build and deploy your app for each every Git push. We call such an event a `job`.

当您将 GitHub 组织接入 Vercel（通过 [Vercel for GitHub](https://vercel.com/github)），每次 Git 推送（push）都会触发应用的构建与部署。我们将此类事件称为 `job`（构建任务）。

For a given branch, we process each job in a queue. If multiple jobs are waiting, we pick the latest one to build. Vercel for GitHub will always give you the deployment URL for the most recent commit.

对于任一分支，我们按队列顺序处理每个构建任务。若存在多个待处理任务，系统将仅选取最新提交对应的任务进行构建。Vercel for GitHub 始终为您提供最新一次提交所对应的部署 URL。

## Introducing Auto Job Cancellation

## 自动取消构建任务功能正式推出

As projects grow in size, builds tend to take longer. If you have regular commits coming in for these projects, one after another, the build time will add up and delay the deployment of the latest commit.

随着项目规模扩大，构建耗时往往随之增加。若您频繁地连续提交代码，累积的构建时间将显著延迟最新提交的部署。

**From today, Vercel will always build the latest commit immediately.**

**即日起，Vercel 将始终立即构建最新提交。**

![Auto canceled job on the `master` Git Branch.](images/auto-job-cancellation-for-vercel-for-github-vercel/img_001.jpg)Auto canceled job on the \`master\` Git Branch.

![`master` Git 分支上被自动取消的构建任务。](images/auto-job-cancellation-for-vercel-for-github-vercel/img_001.jpg)`master` Git 分支上被自动取消的构建任务。

While waiting for build job to complete, if Vercel receives a new job from the most recent commit, we cancel the current job and start building the latest job.

在当前构建任务尚未完成时，一旦 Vercel 收到由最新提交触发的新构建任务，系统将立即取消当前任务，并启动对最新提交的构建。

With this new behavior, you can always get the deployment URL for the latest changes right away.

借助这一新机制，您总能即时获取最新变更所对应的部署 URL。

![Auto canceled job on a Pull Request.](images/auto-job-cancellation-for-vercel-for-github-vercel/img_002.jpg)Auto canceled job on a Pull Request.

![Pull Request 中被自动取消的构建任务。](images/auto-job-cancellation-for-vercel-for-github-vercel/img_002.jpg)Pull Request 中被自动取消的构建任务。

## Opt-out support

## 退出支持

We think auto job cancelation is a tremendous new default behavior **that will save you both time and money**.

我们认为，自动取消作业是一项极为出色的默认行为，**能为您节省大量时间和金钱**。

However, if you want every push to build in sequence, Vercel provides an option to be added in a [`vercel.json` configuration file](https://zeit.co/docs/v2/deployments/configuration#github-autojobcancelation).

然而，如果您希望每次推送都按顺序构建，Vercel 提供了一个配置选项，可添加至 [`vercel.json` 配置文件](https://zeit.co/docs/v2/deployments/configuration#github-autojobcancelation) 中。

```json
1{

2  "github": {

3    "autoJobCancelation": false

4  }

5}
```

## Conclusion

## 总结

Our goal for Vercel is always to provide deployments for any project as quickly as possible. We believe that this new Vercel for GitHub behavior that extends a great method to receive deployments from your most recent changes is a great benefit to this goal.

Vercel 的目标始终是尽可能快速地为任意项目提供部署服务。我们相信，这一面向 GitHub 的全新 Vercel 行为——即通过一种优秀的方式，让您能基于最新代码变更快速获取部署结果——将极大助力实现这一目标。

If you have any questions or feedback, we would love to hear from you. Feel free to always [reach out to us](https://zeit.co/chat).

如果您有任何问题或反馈，我们非常期待您的来信！欢迎随时[联系我们](https://zeit.co/chat)。