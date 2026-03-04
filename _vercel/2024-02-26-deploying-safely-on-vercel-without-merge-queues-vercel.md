---
title: "Deploying safely on Vercel without merge queues - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-safely-on-vercel-without-merge-queues"
date: "2024-02-26"
scraped_at: "2026-03-02T09:47:18.537050303+00:00"
language: "en-zh"
translated: true
description: "Deploy quickly and safely with Vercel without merge queues"
---
&#123;% raw %}

Feb 26, 2024

2024 年 2 月 26 日

Learn how to introduce custom checks to deploy your applications quickly and safely on Vercel.

了解如何引入自定义检查，以在 Vercel 上快速、安全地部署您的应用。

In order to prevent issues from reaching production, repositories often have settings enabled to keep the `main` branch green whenever any code is merged. When there are many developers contributing code, such as in a [monorepo](https://vercel.com/docs/monorepos), this usually results in a slowdown in developer productivity.

为防止问题流入生产环境，代码仓库通常会启用相关设置，确保每次有代码合入时 `main` 分支始终处于“绿色”（即所有检查通过）状态。当有大量开发者共同提交代码时——例如在 [单体仓库（monorepo）](https://vercel.com/docs/monorepos) 中——这种做法往往会导致开发者生产力下降。

If branches are required to be synced to `HEAD` before merge, developers may have to update branch multiple times before they can merge their code, unnecessarily performing a lot of the same checks over again. A merge queue is an alternative solution to alleviate this pain, but this can also slow down productivity by forcing commits from each developer to be tested before merge in serial, even from unrelated commits.

若要求分支在合并前必须与 `HEAD` 同步，开发者可能需要多次更新其分支，才能最终完成代码合并；在此过程中，大量相同的检查被反复执行，造成不必要的开销。合并队列（merge queue）是一种缓解该问题的替代方案，但它同样会拖慢开发效率：它强制将每位开发者的提交按顺序逐一测试（即使这些提交彼此无关），待全部通过后才允许合并。

With Vercel, you can ensure the safety of production _and_ developers can merge quickly _,_ [without using a merge queue](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment).

借助 Vercel，您既可保障生产环境的安全性，又能让开发者快速完成合并——[无需依赖合并队列](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment)。

### Merge queue drawbacks

### 合并队列的弊端

When a merge queue is used in a repository, once a commit has passed all checks and is ready to be merged, it must be added to the merge queue before it is actually merged. The merge queue will run the same checks that were just run again by applying the commit to the `HEAD` of the main branch to make sure that checks would pass when the commit is merged. If there are multiple commits being merged at the same time, the commits must be tested in serial to ensure that each commit would be safe to land when merged one by one.

当仓库中启用了合并队列时，一旦某次提交已通过全部检查、具备合并条件，它必须先加入合并队列，之后才会真正被合并。此时，合并队列会再次运行刚刚已完成的全部检查——方法是将该提交应用到 `main` 分支最新的 `HEAD` 上，以验证其在实际合并后仍能通过所有检查。若存在多个待合并提交，它们必须按顺序逐一测试，以确保每个提交在单独合并时均属安全。

This has two main issues: **repeated work** and **long merge times.**

这带来两大主要问题：**重复工作** 和 **漫长的合并耗时**。

Since the merge queue must run tests at the most recent `HEAD`, the merge queue will run the CI checks for a commit at least two times. If there are other commits ahead in the merge queue, the merge queue may have to repeat those checks again as other commits ahead of your commit are merged into the repository. Despite the majority of commits being safe to merge after the local CI checks complete on their pull request, the merge queue will incur this cost every time.

由于合并队列必须基于最新的 `HEAD` 运行测试，因此对单次提交至少要执行两次 CI 检查。若您的提交前方还有其他待合并提交，那么随着这些前置提交陆续合入仓库，合并队列还可能被迫再次重复执行这些检查。尽管绝大多数提交在拉取请求（Pull Request）中完成本地 CI 检查后即已满足安全合并条件，合并队列却仍需为每一次合并承担此项开销。

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_001.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_002.jpg)

If multiple developers are contributing code at the same time, the merge queue may also introduce long merge times since it must serially test each commit from each developer, even if the commits are unrelated to each other. There are optimizations that merge queues do to try to relieve this pain such as trying to group multiple commits into the same batch under the assumption that they are likely to pass. However, these optimizations do not solve the issue. With merge queues, changes from developers depend on changes from other developers _even if they are unrelated to each other_, and this makes it hard to scale monorepo merge times with more developers.

当多个开发者同时提交代码时，合并队列（merge queue）也可能导致漫长的合并耗时——因为它必须按顺序逐一测试每位开发者提交的每个变更，即使这些变更是彼此无关的。为缓解这一问题，合并队列会采用一些优化策略，例如尝试将多个提交归入同一批次进行测试（假设它们大概率都能通过）。然而，这些优化并不能从根本上解决该问题。在合并队列机制下，开发者的变更会依赖于其他开发者的变更——_即便二者完全无关_——这使得单体仓库（monorepo）的合并耗时难以随开发者数量增加而线性扩展。

### Using Vercel to run custom checks before promoting deployments

### 使用 Vercel 在部署上线前运行自定义检查

By default, Vercel will promote a production deployment to the production aliased domains as soon as they deployment succeeds and [Vercel Checks](https://vercel.com/docs/observability/checks-overview) pass.

默认情况下，Vercel 会在生产环境部署成功且所有 [Vercel Checks](https://vercel.com/docs/observability/checks-overview) 通过后，立即将该部署提升（promote）至生产环境所绑定的域名。

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_003.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_004.jpg)

If you would like to run custom checks before promoting the deployment to end users, you can now also [disable the automatic promotion of production deployments](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment). With this new option, when Vercel detects a new commit on the main branch, it will start a build a new Production deployment. However, after the build is finished, it won’t automatically promote that deployment to the production domains and therefore the change won’t yet be visible to end users. Instead, Vercel will wait to promote that deployment until you instruct Vercel to, such as via the CLI, API, or in the UI.

如果您希望在将部署推送给终端用户之前运行自定义检查，现在还可以[禁用生产环境部署的自动上线功能](https://vercel.com/docs/deployments/managing-deployments#staging-and-promoting-a-production-deployment)。启用此新选项后，当 Vercel 检测到 `main` 分支上有新提交时，它将启动一次构建并生成一个新的生产环境部署；但构建完成后，Vercel 不会自动将该部署上线至生产域名，因此变更尚不会对终端用户可见。取而代之的是，Vercel 将等待您的明确指令（例如通过 CLI、API 或控制台界面）后再执行上线操作。

This change allows workflows to introduce additional steps between when a production build is complete before end users see the changes while still benefitting from Vercel’s automatic deployment. For example, you can run additional CI checks on the production deployment and automatically promote after those checks complete.

这一改动使工作流能够在生产构建完成之后、终端用户实际看到变更之前，灵活插入额外步骤，同时仍可享受 Vercel 自动化部署带来的便利。例如，您可在生产部署上运行额外的 CI 检查，并在这些检查全部通过后自动触发上线。

Once the requirements for the production deployment is satisfied, users will only need to run the promote command from the Vercel CLI to make the deployment available to end users.

一旦生产部署满足所有预设条件，用户只需在 Vercel CLI 中运行 `promote` 命令，即可将该部署开放给终端用户使用。

![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_005.jpg)![](images/deploying-safely-on-vercel-without-merge-queues-vercel/img_006.jpg)

Disabling automatic assignment and allowing you to control when the deployment is promoted opens up new possibilities for changes to your deployment workflow, without having to opt out of automatic deployments entirely.

禁用自动上线机制、转而由您自主控制部署上线时机，为优化部署流程开辟了全新可能——您无需彻底放弃自动化部署，即可实现更精细的管控。

[**Environments on Vercel**\\
\\
Learn more about creating and managing your deployments on Vercel. \\
\\
Watch the video](https://www.youtube.com/watch?v=nZrAgov_-D8)

[**Vercel 上的环境管理（Environments）**\\
\\
深入了解如何在 Vercel 上创建与管理您的部署。\\
\\
观看视频](https://www.youtube.com/watch?v=nZrAgov_-D8)

### Removing the merge queue

### 移除合并队列

With this workflow in place, the merge queue can be safely removed because checks will still always be run before users ever see the deployment.

采用此工作流后，合并队列即可安全移除，因为所有检查仍将在用户看到部署前始终执行。

Once the production deployment is finished, Vercel will dispatch a [webhook event](https://vercel.com/docs/observability/webhooks-overview/webhooks-api) that the deployment has succeeded. You can listen to these events, such as in your CI system, to run the required checks that should pass before this deployment is promoted to the production domains and made visible to users, such as integration tests and QA. Once all your checks are complete, you can run [`vc promote`](https://vercel.com/docs/cli/deploy#skip-domain) to promote the deployment to production and make it visible to all of your users.

生产部署完成后，Vercel 将触发一个 [webhook 事件](https://vercel.com/docs/observability/webhooks-overview/webhooks-api)，通知该部署已成功。你可以在 CI 系统等环境中监听此类事件，并在该部署被提升至生产环境域名、向用户公开之前，运行必需的检查（例如集成测试和质量保证测试）。待所有检查均通过后，即可运行 [`vc promote`](https://vercel.com/docs/cli/deploy#skip-domain) 命令，将该部署正式提升至生产环境，使其对全部用户可见。

```tsx
1// Ensure that all checks pass

const token = process.env.VERCEL_API_TOKEN;

const scope = process.env.VERCEL_TEAM_ID;

await execaCommand(

5  `npx vercel --scope ${scope} --token ${token} promote ${deploymentId}`,

6);
```

```tsx
1// 确保所有检查均已通过

const token = process.env.VERCEL_API_TOKEN;

const scope = process.env.VERCEL_TEAM_ID;

await execaCommand(

5  `npx vercel --scope ${scope} --token ${token} promote ${deploymentId}`,

6);
```

At Vercel, we use GitHub Actions to listen for the `deployment_status` event and then run our integration test suite against the production deployment. Once all the normal CI checks for the commit are complete and the production integration tests have passed, we then run `vc promote` through a [GitHub Action](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment) to promote the deployment.

在 Vercel，我们使用 GitHub Actions 监听 `deployment_status` 事件，随后针对生产环境部署运行我们的集成测试套件。待该提交所对应的常规 CI 检查全部完成，且生产环境集成测试也顺利通过后，我们便通过一个 [GitHub Action](https://vercel.com/guides/how-can-i-run-end-to-end-tests-after-my-vercel-preview-deployment) 执行 `vc promote` 命令，以完成部署的正式提升。

With this approach, developers don't need to worry about multiple syncs to `HEAD` before merge or waiting for a merge queue. There may be some more commits that are merged to main that may fail CI, but those can be reverted without ever reaching production. Developers can move quickly _and_ safely.

采用这种方案，开发者无需担心在合并前多次同步至 `HEAD`，也无需等待合并队列。尽管可能有更多提交被合并至 `main` 分支并导致 CI 失败，但这些提交可在抵达生产环境前被轻松回退。开发者既能快速推进，又能确保安全。

## Move faster _and_ more safely with Vercel

## 借助 Vercel 更快、更安全地交付代码

By using Vercel, you can remove slowdowns merging code in your repository and improve the time from pull request to landing that change in production. Additionally, it enables you to run additional checks after a deployment completes before users visit that deployment without having to create a complex workflow—helping you iterate faster while maintaining production quality.

借助 Vercel，您可以消除代码仓库中合并流程的瓶颈，显著缩短从发起 Pull Request 到变更正式上线生产环境所需的时间。此外，Vercel 还支持在部署完成、用户访问该部署前，自动运行额外的校验步骤——您无需构建复杂的工作流，即可在保持生产质量的同时加速迭代。
&#123;% endraw %}
