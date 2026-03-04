---
title: "February 2020 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-february-2020"
date: "2020-02-01"
scraped_at: "2026-03-02T10:07:28.829697649+00:00"
language: "en-zh"
translated: true
description: "Vercel's changelog for February 2020"
---
{% raw %}

Feb 1, 2020

2020 年 2 月 1 日

## Domains

## 域名

- 向项目中添加外部域名时，我们不再要求为其配置 TXT 记录。

- 向项目中添加外部域名时，我们不再要求为其配置 TXT 记录。

## Deployments

## 部署

- Python 无服务器函数现在可在 `functions` 配置项中通过 `excludeFiles` 属性进行[配置](https://zeit.co/docs/configuration#project/functions)，从而显式地将某些文件从最终生成的无服务器函数中排除。

- Python 无服务器函数现在可在 `functions` 配置项中通过 `excludeFiles` 属性进行[配置](https://zeit.co/docs/configuration#project/functions)，从而显式地将某些文件从最终生成的无服务器函数中排除。

- 现在，通过[模板](https://zeit.co/docs#quickstarts)创建的新项目，其 `README.md` 文件中已包含可正常显示的框架 Logo。

- 现在，通过[模板](https://zeit.co/docs#quickstarts)创建的新项目，其 `README.md` 文件中已包含可正常显示的框架 Logo。

- [Hobby 套餐](https://zeit.co/pricing) 用户现无法再创建 Now 1.0 部署。

- [Hobby 套餐](https://zeit.co/pricing) 用户现无法再创建 Now 1.0 部署。

- 构建所用的 [Node.js 版本](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version) 已更新为：`12.x` 系列使用 `12.14.1`，`10.x` 系列使用 `10.18.0`，以与 AWS Lambda 运行时版本保持一致。

- 构建所用的 [Node.js 版本](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version) 已更新为：`12.x` 系列使用 `12.14.1`，`10.x` 系列使用 `10.18.0`，以与 AWS Lambda 运行时版本保持一致。

## Dashboard

## 控制台

- ["导入项目" 页面](https://zeit.co/new) 现在允许您在“导入 Git 仓库”和“导入模板”之间进行选择。

- ["导入项目" 页面](https://zeit.co/new) 现在允许您在“导入 Git 仓库”和“导入模板”之间进行选择。

- Creating a new project [using a template](https://zeit.co/docs#quickstarts) now automatically creates a Git repository to make editing it easier.

- 使用模板[创建新项目](https://zeit.co/docs#quickstarts)现在会自动初始化一个 Git 仓库，以便更方便地编辑项目。

- The "Deploy Hooks" option and the "Git Branch" Domain option in the project settings now work if your Git repository contains hundreds of branches.

- 项目设置中的“部署钩子（Deploy Hooks）”选项和“Git 分支（Git Branch）”域名选项，现支持包含数百个分支的 Git 仓库。

- Team member roles ("Owner" and "Member") are now available on all pricing plans.

- 团队成员角色（“所有者（Owner）”和“成员（Member）”）现已在所有定价方案中提供。

- The "Domains" tab on the project view was now removed in favor of the "Domains" sidebar item on the "Settings" tab.

- 项目视图中的“域名（Domains）”标签页已被移除，取而代之的是“设置（Settings）”标签页侧边栏中的“域名（Domains）”条目。

- Changing the settings of an existing teams on a mobile device doesn't automatically focus the text areas anymore.

- 在移动设备上修改现有团队的设置时，文本输入区域将不再自动获得焦点。

- The Now 1.0 pricing page was removed.

- Now 1.0 定价页面已被移除。

- The "Platform Version" field was removed from the account and team settings.

- “平台版本（Platform Version）”字段已从账户及团队设置中移除。
{% endraw %}
