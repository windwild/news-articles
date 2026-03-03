---
title: "Deploy Summary Integration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-summary"
date: "2019-09-03"
scraped_at: "2026-03-02T10:07:40.874812811+00:00"
language: "en"
translated: false
description: "Introducing Deploy Summary, a Vercel integration to enhance your Pull Requests or Merge Requests with screenshots and links to your changed pages."
---




Sep 3, 2019

Deeply integrate your

Today, we're introducing [**Deploy Summary**](https://vercel.com/integrations/deploy-summary), a Vercel integration to augment your workflow with our [GitHub](https://vercel.com/github) and [GitLab](https://vercel.com/gitlab) integrations even further.

**Deploy Summary** analyzes your pull requests and merge requests, detects changed pages, and provides a detailed preview right next to your commits:

![An example of a preview added by Deploy Summary on a pull request.](images/deploy-summary-integration-vercel/img_001.jpg)An example of a preview added by Deploy Summary on a pull request.

These previews include:

- **Screenshots** of the changed pages, to quickly take a glance at the contents of the PR.

- **Direct links** to the changed pages, for a finer grained review.

- The **URL** of the deployment.

- The **commit SHA** of the deployed commit.


### Persistent URLs

Since the **URL does not change if a new commit is pushed**, you only need to share it once with your team – they will see all future commits appear there.

This is especially useful if your project has a login system. In that case, you only need to log in once, because the domain (and therefore the session cookie) stay the same.

## Get started

To start using **Deploy Summary**, visit the [integration's page](https://vercel.com/integrations/deploy-summary) and click "Add":

![After clicking "Add", choose the account or the team where you would like to install Deploy Summary.](images/deploy-summary-integration-vercel/img_002.jpg)After clicking "Add", choose the account or the team where you would like to install Deploy Summary.

Once the integration is installed on your personal account or one of your teams, if you have not already done so, you will be invited to connect your GitHub or GitLab account:

![If you haven't yet connected your GitHub/GitLab account, you will be asked to do so.](images/deploy-summary-integration-vercel/img_003.jpg)If you haven't yet connected your GitHub/GitLab account, you will be asked to do so.

Next, create a new pull request ( [GitHub](https://vercel.com/github)) or merge request ( [GitLab](https://vercel.com/gitlab)) for your frontend (find the full list of supported frameworks [here](https://vercel.com/integrations/deploy-summary)).

Once your branch is deployed, the deployment will be analyzed and page changes will be detected. If one of your pages has changed, a preview show up:

![An example pull request with a preview provided by the Deploy Summary integration.](images/deploy-summary-integration-vercel/img_004.jpg)An example pull request with a preview provided by the Deploy Summary integration.

## Conclusion

With [Deploy Summary](https://vercel.com/integrations/deploy-summary), you can now review pull or merge requests in a much faster way.

Aside from supporting [more frameworks](https://vercel.com/integrations/deploy-summary), we will also explore enhancing workflows even further: Imagine seeing Diff screenshots, lighthouse scores, or bundle sizes right on your pull or merge requests.

Anything unclear? [Drop us a message](https://twitter.com/vercel) [!](mailto:support@zeit.co)