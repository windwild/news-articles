---
title: "Deploy Summary Integration - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/deploy-summary"
date: "2019-09-03"
scraped_at: "2026-03-02T10:07:40.874812811+00:00"
language: "en-zh"
translated: true
description: "Introducing Deploy Summary, a Vercel integration to enhance your Pull Requests or Merge Requests with screenshots and links to your changed pages."
---
&#123;% raw %}

Sep 3, 2019

2019 年 9 月 3 日

深度集成您的工作流

今天，我们正式推出 [**Deploy Summary（部署摘要）**](https://vercel.com/integrations/deploy-summary) —— 一款 Vercel 集成工具，可进一步增强您已有的 [GitHub](https://vercel.com/github) 和 [GitLab](https://vercel.com/gitlab) 集成功能。

**Deploy Summary** 会分析您的 Pull Request（拉取请求）和 Merge Request（合并请求），自动识别发生变更的页面，并在提交记录旁直接提供详尽的预览：

![Deploy Summary 在 Pull Request 上添加的预览示例。](images/deploy-summary-integration-vercel/img_001.jpg)Deploy Summary 在 Pull Request 上添加的预览示例。

这些预览包含以下内容：

- **变更页面的截图**：助您快速概览 PR 中的内容。

- **变更页面的直达链接**：便于进行更细致的审查。

- 部署的 **URL**。

- 已部署提交的 **Commit SHA**。

### Persistent URLs

### 持久化 URL

Since the **URL does not change if a new commit is pushed**, you only need to share it once with your team – they will see all future commits appear there.

由于 **URL 在推送新提交后不会发生变化**，您只需向团队分享一次该链接——他们即可在该页面持续看到后续所有提交。

This is especially useful if your project has a login system. In that case, you only need to log in once, because the domain (and therefore the session cookie) stay the same.

这一特性在您的项目包含登录系统时尤为实用：此时您只需登录一次，因为域名（以及由此产生的会话 Cookie）保持不变。

## Get started

## 开始使用

To start using **Deploy Summary**, visit the [integration's page](https://vercel.com/integrations/deploy-summary) and click "Add":

如需开始使用 **Deploy Summary**，请访问 [集成页面](https://vercel.com/integrations/deploy-summary) 并点击“Add”（添加）：

![After clicking "Add", choose the account or the team where you would like to install Deploy Summary.](images/deploy-summary-integration-vercel/img_002.jpg)  
![点击“Add”后，请选择您希望安装 Deploy Summary 的个人账号或团队。](images/deploy-summary-integration-vercel/img_002.jpg)  
After clicking "Add", choose the account or the team where you would like to install Deploy Summary.  
点击“Add”后，请选择您希望安装 Deploy Summary 的个人账号或团队。

Once the integration is installed on your personal account or one of your teams, if you have not already done so, you will be invited to connect your GitHub or GitLab account:

当集成已成功安装至您的个人账号或任一团队后，若您尚未完成授权，系统将提示您连接 GitHub 或 GitLab 账号：

![If you haven't yet connected your GitHub/GitLab account, you will be asked to do so.](images/deploy-summary-integration-vercel/img_003.jpg)  
![若您尚未连接 GitHub/GitLab 账号，系统将提示您进行连接。](images/deploy-summary-integration-vercel/img_003.jpg)  
If you haven't yet connected your GitHub/GitLab account, you will be asked to do so.  
若您尚未连接 GitHub/GitLab 账号，系统将提示您进行连接。

Next, create a new pull request ([GitHub](https://vercel.com/github)) or merge request ([GitLab](https://vercel.com/gitlab)) for your frontend (find the full list of supported frameworks [here](https://vercel.com/integrations/deploy-summary)).

接下来，请为您的前端项目创建一个新的 Pull Request（[GitHub](https://vercel.com/github)）或 Merge Request（[GitLab](https://vercel.com/gitlab)）（支持的全部框架列表请见 [此处](https://vercel.com/integrations/deploy-summary)）。

Once your branch is deployed, the deployment will be analyzed and page changes will be detected. If one of your pages has changed, a preview show up:  
当您的分支完成部署后，系统将自动分析本次部署，并检测页面内容变更；若其中任一页面发生变更，预览界面即会显示：

![An example pull request with a preview provided by the Deploy Summary integration.](images/deploy-summary-integration-vercel/img_004.jpg)  
一个由 Deploy Summary 集成提供预览效果的拉取请求示例。

## Conclusion

## 结论

With [Deploy Summary](https://vercel.com/integrations/deploy-summary), you can now review pull or merge requests in a much faster way.

借助 [Deploy Summary](https://vercel.com/integrations/deploy-summary)，您现在可以更快速地审阅拉取请求（pull request）或合并请求（merge request）。

Aside from supporting [more frameworks](https://vercel.com/integrations/deploy-summary), we will also explore enhancing workflows even further: Imagine seeing Diff screenshots, lighthouse scores, or bundle sizes right on your pull or merge requests.

除了支持 [更多框架](https://vercel.com/integrations/deploy-summary) 外，我们还将持续探索进一步优化工作流的可能性：例如，直接在您的拉取请求或合并请求中查看差异截图（Diff screenshots）、Lighthouse 评分，或代码包体积（bundle sizes）。

Anything unclear? [Drop us a message](https://twitter.com/vercel) [!](mailto:support@zeit.co)  
如有任何疑问？欢迎 [给我们留言](https://twitter.com/vercel) [!](mailto:support@zeit.co)
&#123;% endraw %}
