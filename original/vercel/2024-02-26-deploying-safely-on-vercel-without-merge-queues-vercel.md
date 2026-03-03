---
title: "Deploying safely on Vercel without merge queues - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-safely-on-vercel-without-merge-queues"
date: "2024-02-26"
scraped_at: "2026-03-02T09:47:18.537050303+00:00"
language: "en"
translated: false
description: "Deploy quickly and safely with Vercel without merge queues"
---




Feb 26, 2024

Learn how to introduce custom checks to deploy your applications quickly and safely on Vercel.

In order to prevent issues from reaching production, repositories often have settings enabled to keep the `main` branch green whenever any code is merged. When there are many developers contributing code, such as in a [monorepo](https://vercel.com/docs/monorepos), this usually results in a slowdown in developer productivity.

If branches are required to be synced to `HEAD` before merge, developers may have to update branch multiple times before they can merge their code, unnecessarily performing a lot of the same checks over again. A merge queue is an alternative solution to alleviate this pain, but this can also slow down productivity by forcing commits from each developer to be tested before merge in serial, even from unrelated commits.

With Vercel, you can ensure the safety of production _and_ developers can merge quickly _,_ [without using a merge queue](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment).

### Merge queue drawbacks

When a merge queue is used in a repository, once a commit has passed all checks and is ready to be merged, it must be added to the merge queue before it is actually merged. The merge queue will run the same checks that were just run again by applying the commit to the `HEAD` of the main branch to make sure that checks would pass when the commit is merged. If there are multiple commits being merged at the same time, the commits must be tested in serial to ensure that each commit would be safe to land when merged one by one.

This has two main issues: **repeated work** and **long merge times.**

Since the merge queue must run tests at the most recent `HEAD`, the merge queue will run the CI checks for a commit at least two times. If there are other commits ahead in the merge queue, the merge queue may have to repeat those checks again as other commits ahead of your commit are merged into the repository. Despite the majority of commits being safe to merge after the local CI checks complete on their pull request, the merge queue will incur this cost every time.

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_001.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_002.jpg)

If multiple developers are contributing code at the same time, the merge queue may also introduce long merge times since it must serially test each commit from each developer, even if the commits are unrelated to each other. There are optimizations that merge queues do to try to relieve this pain such as trying to group multiple commits into the same batch under the assumption that they are likely to pass. However, these optimizations do not solve the issue. With merge queues, changes from developers depend on changes from other developers _even if they are unrelated to each other_, and this makes it hard to scale monorepo merge times with more developers.

### Using Vercel to run custom checks before promoting deployments

By default, Vercel will promote a production deployment to the production aliased domains as soon as they deployment succeeds and [Vercel Checks](https://vercel.com/docs/observability/checks-overview) pass.

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_003.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_004.jpg)

If you would like to run custom checks before promoting the deployment to end users, you can now also [disable the automatic promotion of production deployments](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment). With this new option, when Vercel detects a new commit on the main branch, it will start a build a new Production deployment. However, after the build is finished, it won’t automatically promote that deployment to the production domains and therefore the change won’t yet be visible to end users. Instead, Vercel will wait to promote that deployment until you instruct Vercel to, such as via the CLI, API, or in the UI.

This change allows workflows to introduce additional steps between when a production build is complete before end users see the changes while still benefitting from Vercel’s automatic deployment. For example, you can run additional CI checks on the production deployment and automatically promote after those checks complete.

Once the requirements for the production deployment is satisfied, users will only need to run the promote command from the Vercel CLI to make the deployment available to end users.

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_005.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_006.jpg)

Disabling automatic assignment and allowing you to control when the deployment is promoted opens up new possibilities for changes to your deployment workflow, without having to opt out of automatic deployments entirely.

[**Environments on Vercel**\\
\\
Learn more about creating and managing your deployments on Vercel. \\
\\
Watch the video](https://www.youtube.com/watch?v=nZrAgov_-D8)

### Removing the merge queue

With this workflow in place, the merge queue can be safely removed because checks will still always be run before users ever see the deployment.

Once the production deployment is finished, Vercel will dispatch a [webhook event](https://vercel.com/docs/observability/webhooks-overview/webhooks-api) that the deployment has succeeded. You can listen to these events, such as in your CI system, to run the required checks that should pass before this deployment is promoted to the production domains and made visible to users, such as integration tests and QA. Once all your checks are complete, you can run [`vc promote`](https://vercel.com/docs/cli/deploy#skip-domain) to promote the deployment to production and make it visible to all of your users.

```tsx
1// Ensure that all checks pass

const token = process.env.VERCEL_API_TOKEN;

const scope = process.env.VERCEL_TEAM_ID;

await execaCommand(

5  `npx vercel --scope ${scope} --token ${token} promote ${deploymentId}`,

6);
```

At Vercel, we use GitHub Actions to listen for the `deployment_status` event and then run our integration test suite against the production deployment. Once all the normal CI checks for the commit are complete and the production integration tests have passed, we then run `vc promote` through a [GitHub Action](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment) to promote the deployment.

With this approach, developers don't need to worry about multiple syncs to `HEAD` before merge or waiting for a merge queue. There may be some more commits that are merged to main that may fail CI, but those can be reverted without ever reaching production. Developers can move quickly _and_ safely.

## Move faster _and_ more safely with Vercel

By using Vercel, you can remove slowdowns merging code in your repository and improve the time from pull request to landing that change in production. Additionally, it enables you to run additional checks after a deployment completes before users visit that deployment without having to create a complex workflow—helping you iterate faster while maintaining production quality.