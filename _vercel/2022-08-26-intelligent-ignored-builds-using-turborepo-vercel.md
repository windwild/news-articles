---
render_with_liquid: false
title: "Intelligent ignored builds using Turborepo - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/intelligent-ignored-builds-using-turborepo"
date: "2022-08-26"
scraped_at: "2026-03-02T10:00:50.253553141+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
render_with_liquid: false
render_with_liquid: false

Aug 26, 2022

2022 年 8 月 26 日

![Intelligent ignored builds using Turborepo](images/intelligent-ignored-builds-using-turborepo-vercel/img_001.jpg)![Intelligent ignored builds using Turborepo](images/intelligent-ignored-builds-using-turborepo-vercel/img_002.jpg)

![使用 Turborepo 实现智能跳过构建](images/intelligent-ignored-builds-using-turborepo-vercel/img_001.jpg)![使用 Turborepo 实现智能跳过构建](images/intelligent-ignored-builds-using-turborepo-vercel/img_002.jpg)

When deployed on Vercel, [Turborepo](https://turborepo.org/) now supports only building affected projects via the new [`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) npm package, saving time and helping teams stay productive.

当部署在 Vercel 上时，[Turborepo](https://turborepo.org/) 现已支持仅构建受代码变更影响的项目——借助全新的 [`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) npm 包，从而节省构建时间，并助力团队持续高效协作。

[`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) leverages the Turborepo dependency graph to automatically determine if each app, or one of its dependencies has changed and needs to be deployed.

[`turbo-ignore`](https://www.npmjs.com/package/turbo-ignore) 利用 Turborepo 的依赖图谱，自动判断每个应用或其任一依赖是否发生了变更，从而确定是否需要重新部署。

Try it now by setting `npx turbo-ignore` as the [Ignored Build Step](https://vercel.com/docs/concepts/projects/overview#ignored-build-step) for each project within your monorepo.

立即尝试：在您的单体仓库（monorepo）中，为每个项目将 `npx turbo-ignore` 设置为 [跳过构建步骤（Ignored Build Step）](https://vercel.com/docs/concepts/projects/overview#ignored-build-step)。

[Check out the documentation](https://vercel.com/docs/concepts/monorepos/turborepo#step-4:-setup-the-ignored-build-step) to learn more.

[查阅相关文档](https://vercel.com/docs/concepts/monorepos/turborepo#step-4:-setup-the-ignored-build-step) 以了解更多信息。