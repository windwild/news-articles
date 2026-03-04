---
title: "Git Fork Protection can now be disabled - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/git-fork-protection-can-now-be-disabled"
date: "2021-04-23"
scraped_at: "2026-03-02T10:04:49.643547327+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Apr 23, 2021

2021 年 4 月 23 日

![](images/git-fork-protection-can-now-be-disabled-vercel/img_001.jpg)

![](images/git-fork-protection-can-now-be-disabled-vercel/img_001.jpg)

If you receive a pull request from a fork of your Git repository that includes a change to the `vercel.json` file or the Project has Environment Variables configured, Vercel will require authorization from you or a member of your Team to deploy the pull request.

如果您收到一条来自您 Git 仓库派生分支（fork）的拉取请求（pull request），且该请求包含对 `vercel.json` 文件的修改，或项目已配置环境变量（Environment Variables），Vercel 将要求您本人或团队成员进行授权，方可部署该拉取请求。

This behavior protects you from accidentally leaking sensitive Project information.

此机制可防止您意外泄露项目中的敏感信息。

If you're certain your Environment Variables do not contain sensitive information, you can now disable **Git Fork Protection** by visiting the Security section of your Project Settings.

若您确认您的环境变量中不包含敏感信息，现在您可通过访问项目设置（Project Settings）中的“安全”（Security）部分，来禁用 **Git Fork 保护**（Git Fork Protection）功能。

Check out [the documentation](https://vercel.com/docs/platform/projects#git-fork-protection) as well.

也欢迎查阅 [相关文档](https://vercel.com/docs/platform/projects#git-fork-protection)。
&#123;% endraw %}
