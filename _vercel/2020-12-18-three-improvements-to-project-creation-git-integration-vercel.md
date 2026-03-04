---
title: "Three Improvements to Project Creation & Git Integration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/three-improvements-to-vercel-project-creation-vercel-git-integration"
date: "2020-12-18"
scraped_at: "2026-03-02T10:06:16.937312799+00:00"
language: "en-zh"
translated: true
description: "We've improved the developer experience by introducing three updates that apply to all users on Hobby, Pro, and Enterprise plans."
---
&#123;% raw %}

Dec 18, 2020

2020 年 12 月 18 日

Projects are core to everything on your Vercel account. We’ve recently improved the developer experience by introducing three updates for projects. These apply to all users on Hobby, Pro, and Enterprise plans.

项目是您 Vercel 账户中一切功能的核心。我们近期通过为项目引入三项更新，显著提升了开发者体验。这些更新适用于所有 Hobby、Pro 和 Enterprise 计划的用户。

By improving how projects are created and connected to Git in Vercel, we expect a decrease in the time between project creation and deployment for all users and a reduction in complexity for some larger Vercel customers.

通过优化 Vercel 中项目的创建方式及其与 Git 的连接机制，我们预计所有用户的项目创建到部署耗时将缩短，同时部分大型 Vercel 客户所面临的操作复杂度也将降低。

## Project-Level Git

## 项目级 Git 集成

Project-level Git mainly affects larger teams and agencies. We’ve enabled users to have _multiple_ GitHub, GitLab, and/or Bitbucket connections to their Vercel account by moving the scope for Git connections from the account level to the project level.

项目级 Git 主要影响大型团队和代理机构。我们已将 Git 连接的作用域从账户级别迁移至项目级别，从而支持用户在同一个 Vercel 账户下配置 _多个_ GitHub、GitLab 和/或 Bitbucket 连接。

![Different Projects can be associated with different git repositories. ](images/three-improvements-to-project-creation-git-integration-vercel/img_001.jpg)不同项目可关联不同的 Git 代码仓库。

This means users can connect a Git namespace (i.e. a GitHub account or organization) to an individual project, allowing for a different Git connection on each project in their Vercel account.

这意味着用户可将某个 Git 命名空间（例如一个 GitHub 账户或组织）绑定至单个项目，从而在 Vercel 账户中的每个项目上使用各自独立的 Git 连接。

## Project Creation

## 项目创建流程优化

We’ve also updated the project creation flow so you can search for your existing repositories when creating a new project. This reduces the number of page loads you experience when importing repositories so you get to deployment faster.

我们还优化了项目创建流程，使您在新建项目时即可直接搜索已有代码仓库。此举减少了导入仓库过程中的页面加载次数，助您更快完成部署。

Take a look at the way Git is integrated during the project creation phase. The component is interactive, so go ahead and give it a try:

请查看项目创建阶段中 Git 的集成方式。该组件具备交互能力，欢迎立即尝试：

Try out Vercel's newest way to create projects by connecting a repo or cloning a template.

试用 Vercel 最新推出的项目创建方式：通过连接代码仓库或克隆模板来快速启动项目。

## Template Library

## 模板库

Also shown above, we’ve moved the template library to be part of the project creation flow (in case you don’t have an existing repository when creating a new project). Using templates is a great way to leverage the time of the developers who created them, reducing the time you spend on the basic components and pages of your project.

如上图所示，我们已将模板库整合进项目创建流程中（尤其适用于您在新建项目时尚未拥有现有代码仓库的场景）。使用模板能充分借鉴模板创建者所投入的开发时间，从而大幅减少您在项目基础组件与页面上的重复劳动。

We’ve recently added two advanced Next.js templates, _Next.js Commerce_ and _Virtual Event Starter Kit_, which contain many advanced components and pages you can clone and fully customize. Click on "Browse All Templates" in the "Clone Template" container to find them.

我们近期新增了两个高级 Next.js 模板：_Next.js Commerce_（Next.js 商城）和 _Virtual Event Starter Kit_（虚拟活动入门套件），其中包含大量高级组件与页面，您可直接克隆并进行完全自定义。请在“克隆模板”区域点击“浏览全部模板”以查找它们。

We’re committed to continue enhancing your experience as a developer on Vercel, thank you for your support and feedback!

我们始终致力于持续优化您在 Vercel 平台上的开发者体验。感谢您的支持与宝贵反馈！
&#123;% endraw %}
