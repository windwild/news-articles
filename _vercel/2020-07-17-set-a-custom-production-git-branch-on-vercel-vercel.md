---
title: "Set a custom production Git branch on Vercel - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/custom-production-branch"
date: "2020-07-17"
scraped_at: "2026-03-02T10:06:36.866749745+00:00"
language: "en-zh"
translated: true
description: "As of today, you can customize the Production Branch of your Projects right in the Project Settings."
---
{% raw %}

Jul 17, 2020

2020 年 7 月 17 日

Up until now, after [creating a new Project](https://vercel.com/import) from a Git repository or one of our examples, all commits to its _default branch_ were being deployed to Production.

此前，只要您通过 Git 仓库或我们的任一示例 [创建新项目](https://vercel.com/import)，该仓库的 _默认分支_ 上的所有提交都会自动部署至生产环境（Production）。

Today we are introducing a new default for newly created Projects, as well as an easy way to customize it from your Project Settings.

今天，我们为新创建的项目引入了一项新的默认配置，同时您也可以在项目设置（Project Settings）中轻松自定义该配置。

## New production branch for new projects

## 新项目的生产分支

Instead of the Git repository's _default branch_, new Projects will now issue Production Deployments for the `main` branch.

新项目将不再使用 Git 仓库的 _默认分支_，而是默认将 `main` 分支的变更部署至生产环境。

If it doesn't exist, the `master` branch will be used ( [more details](https://vercel.com/blog/custom-production-branch#a-note-on-the-master-branch)). And if that doesn't exist either, the Git repository's _default branch_ will be used.

若 `main` 分支不存在，则回退至使用 `master` 分支（[更多详情](https://vercel.com/blog/custom-production-branch#a-note-on-the-master-branch)）；若 `master` 分支也不存在，则最终回退至使用 Git 仓库本身的 _默认分支_。

Existing Projects are unaffected by this change.

现有项目不受此项变更影响。

## New project setting

## 新增项目设置项

On the new **Production Branch** section under **Git Integration** in the Project Settings, you can now also select one of the following options:

在项目设置（Project Settings）中 **Git 集成**（Git Integration）下的全新 **生产分支**（Production Branch）区域，您现在还可以从以下选项中进行选择：

- The `main` branch.  
- `main` 分支。

- The Git repository's _default branch_.

- Git 仓库的 _默认分支_。

- Any other custom branch of your choice.

- 您可自行选择的任意其他自定义分支。

![The default Production Branch configuration in the Project Settings.](images/set-a-custom-production-git-branch-on-vercel-vercel/img_001.jpg)  
项目设置中的默认生产分支（Production Branch）配置。

## A note on the master branch

## 关于 `master` 分支的说明

As you might have noticed, we left out `master` as an option you can select from the dropdown.

如您所见，我们已将 `master` 从下拉菜单的可选项中移除。

This is an intentional decision, in anticipation and agreement with Git providers like [GitHub](https://www.bbc.com/news/technology-53050955) moving away from terms that evoke prejudice and belong to the past.

这一决定是经过深思熟虑的，旨在呼应并支持 GitHub 等 Git 托管平台逐步弃用带有偏见、且属于历史陈旧语境的术语（参见 [GitHub 相关公告](https://www.bbc.com/news/technology-53050955)）。

For reasons of compatibility, creating a new Project from a Git repository that still uses `master` will automatically populate the `Custom` option. If you rename the branch in the future, you can easily change to `main` with just two clicks.

出于兼容性考虑，若您基于仍使用 `master` 分支的 Git 仓库新建项目，系统将自动将“自定义”（Custom）选项设为该分支。未来若您将该分支重命名为 `main`，仅需两次点击即可轻松切换至 `main`。

## Conclusion

## 总结

With this change, you gain the flexibility to configure your repository's _default branch_ for your Project's ongoing work. When you push to that branch, we will create Preview Deployments, and when you push to `main` we will create Production Deployments.

通过此项更新，您可灵活地为项目的持续开发工作指定仓库的 _默认分支_：向该分支推送代码时，我们将自动创建预览部署（Preview Deployments）；而向 `main` 分支推送时，则会触发生产环境部署（Production Deployments）。

Furthermore, if you don't want to use `main`, you can now select any branch you want for your Production Deployments.

此外，若您不希望使用 `main` 作为生产分支，现在也可自由选择任一分支作为您的生产部署目标分支。

Check out the [documentation](https://vercel.com/docs/v2/git-integrations#production-branch) for more details and [let us know](https://twitter.com/vercel) what you think about this change.

请查阅[文档](https://vercel.com/docs/v2/git-integrations#production-branch)了解更多信息，并通过[Twitter](https://twitter.com/vercel)告诉我们您对这一变更的看法。
{% endraw %}
