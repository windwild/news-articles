---
title: "Environment Variables UI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/environment-variables-ui"
date: "2020-04-14"
scraped_at: "2026-03-02T10:06:57.044540085+00:00"
language: "en-zh"
translated: true
description: "Configure different Environment Variables for Production, Preview, and Development – right in the Dashboard."
---
{% raw %}

Apr 14, 2020

Apr 14, 2020

Customize Environment Variables for projects in your Dashboard

在仪表板中为项目自定义环境变量

If you are working on a sophisticated project, you might have found yourself wanting to configure different Environment Variables depending on the Environment your project is deployed to.

如果您正在开发一个复杂的项目，可能已经遇到需要根据项目所部署的环境（如生产环境、预览环境或开发环境）来配置不同环境变量的需求。

With today's release, we're making it possible to configure different **Environment Variables** for **Production**, **Preview**, and **Development** – right in the Dashboard.

借助本次发布，您现在可以直接在仪表板中分别为 **Production（生产环境）**、**Preview（预览环境）** 和 **Development（开发环境）** 配置不同的 **环境变量（Environment Variables）**。

## New project setting

## 新增项目设置

To configure an Environment Variable for your project, simply navigate to your Project Settings and look for the newly added Environment Variables section:

要为您的项目配置环境变量，只需进入项目设置（Project Settings），并找到新添加的“环境变量”（Environment Variables）部分：

![The new "Environment Variables" field in the Project Settings.](images/environment-variables-ui-vercel/img_001.jpg)  
![项目设置中的新“环境变量”字段。](images/environment-variables-ui-vercel/img_001.jpg)  
The new "Environment Variables" field in the Project Settings.

项目设置中的新“环境变量”字段。

Within this section, you can assign an Environment Variable to the Production, Preview, or Development Environment, depending on where you want it to be available.

在此部分中，您可以将某个环境变量指定给 **Production（生产环境）**、**Preview（预览环境）** 或 **Development（开发环境）**，具体取决于您希望该变量在哪个环境中生效。

### System environment variables

### 系统环境变量

The platform provides several Environment Variables that contain values provided by the system, such as the URL of the deployment or the name of the Git branch that the deployment origined from.

平台提供了若干系统级环境变量，其值由系统自动注入，例如：当前部署的 URL，或触发此次部署的 Git 分支名称。

In order to make one of them available to your code, choose it from [this list](https://zeit.co/docs/v2/build-step#system-environment-variables) and enter its name into the project setting like so:

为了在代码中使用其中某个系统环境变量，请从[此列表](https://zeit.co/docs/v2/build-step#system-environment-variables)中选择一个，并将其名称输入项目设置，如下所示：

![Configuring a System Environment Variable.](images/environment-variables-ui-vercel/img_002.jpg)  
![配置系统环境变量。](images/environment-variables-ui-vercel/img_002.jpg)  
Configuring a System Environment Variable.  
配置系统环境变量。

## New command for Vercel CLI

## Vercel CLI 新增命令

Environment Variables specified for the **Development** **Environment** are made available to your team and can be downloaded into a local development setup using a newly added `vercel env pull` command, which automatically creates a `.env` file:

为 **开发（Development）环境** 指定的环境变量将对您的团队开放，并可通过新添加的 `vercel env pull` 命令下载至本地开发环境，该命令会自动创建一个 `.env` 文件：

```bash
1$ vercel env pull

Vercel CLI 18.0.0

Downloading Development Environment Variables for project my-site

4✅ Created .env file [510ms]
```

```bash
1$ vercel env pull

Vercel CLI 18.0.0

正在为项目 my-site 下载开发环境变量

4✅ 已创建 .env 文件 [510ms]
```

Retrieving Development Environment Variables locally

在本地获取开发环境变量

At least version **18.0.0** of [Vercel CLI](https://vercel.com/download) is required to be able to run this command.

运行此命令至少需要 [Vercel CLI](https://vercel.com/download) 版本 **18.0.0**。

Furthermore, you can use `vercel env add` and `vercel env remove` to add or remove Environment Variables from your project, directly from the command-line.

此外，您还可以直接通过命令行使用 `vercel env add` 和 `vercel env remove` 命令，为项目添加或删除环境变量。

## Conclusion

## 总结

The new Environment Variables section in the Project Settings lets you specify different Environment Variables for Production, Preview, and Development, without creating a `vercel.json` configuration file.

项目设置中的全新“环境变量”（Environment Variables）部分，让您无需创建 `vercel.json` 配置文件，即可分别为生产（Production）、预览（Preview）和开发（Development）环境指定不同的环境变量。

Additionally, sharing Development Environment Variables with your colleagues is now easier than ever before, since they can be pulled from the project using `vercel env pull`.

此外，与同事共享开发环境变量如今比以往任何时候都更简单——他们只需运行 `vercel env pull` 命令，即可从项目中拉取这些变量。

[Let us know](https://zeit.co/contact) what you think about this change. We're excited to help you succeed.

[欢迎告诉我们](https://zeit.co/contact) 您对这一变更的看法。我们非常期待助您取得成功。
{% endraw %}
