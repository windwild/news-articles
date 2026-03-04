---
title: "Branch Domains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/branch-domains"
date: "2019-12-20"
scraped_at: "2026-03-02T10:07:24.903351410+00:00"
language: "en-zh"
translated: true
description: "Assign a Git Branch to your domain, so that every deployment created on it will automatically receive the domain."
---
&#123;% raw %}

Dec 20, 2019

2019 年 12 月 20 日

为您的 Vercel 分支部署分配一个稳定的域名。

在编辑完项目后，只需通过我们的 [Git 集成](https://zeit.co/docs/v2/git-integration/) 推送一次 Git 提交，或使用我们的 [命令行界面](https://zeit.co/download) 运行一条命令，即可借助 Vercel 预览您的更改。

无论采用哪种方式创建的部署，均会获得一个唯一的 URL；但您可能仍希望为预览部署配置一个**自定义域名（Custom Domain）**。今天，我们正式推出 **分支域名（Branch Domains）** 功能，让这一需求成为现实。

## 全新的域名设置选项

要为任意 Git 分支配置域名，您首先需确保项目已在项目概览页面中关联至一个 Git 仓库：

![将您的项目连接至 Git 仓库。](images/branch-domains-vercel/img_001.jpg)将您的项目连接至 Git 仓库。

接下来，添加一个新域名，并选择一个 **Git 分支**：

![选择您希望分配该域名的 Git 分支。](images/branch-domains-vercel/img_002.jpg)选择您希望分配该域名的 Git 分支。

最后，保存设置，并向所选 Git 分支推送一次新提交，即可完成全部配置。

Once you've done that, your domain will automatically point to the **most recent Deployment** created on that Git Branch. Congratulations!

完成上述操作后，您的域名将自动指向该 Git 分支上创建的**最新部署（Deployment）**。恭喜！

Next time you push a new commit, your domain will be updated to reflect it.

下次您推送新的提交（commit）时，您的域名将随之自动更新。

If you prefer to do this using the Vercel REST API instead, you can use the ["Update a project domain"](https://vercel.com/docs/rest-api#endpoints/projects/update-a-project-domain) PATCH endpoint.

如果您更倾向于通过 Vercel REST API 来完成此操作，可以使用 [`“Update a project domain”`](https://vercel.com/docs/rest-api#endpoints/projects/update-a-project-domain) 这一 PATCH 接口。

## Conclusion

## 总结

By configuring a Custom Domain for your Preview Deployments through the **Git Branch** setting, you can now retain your preferred domain (and therefore your branding), even when sharing Preview Deployments with customers or colleagues.

通过在 **Git 分支（Git Branch）** 设置中为预览部署（Preview Deployments）配置自定义域名（Custom Domain），您现在即可在向客户或同事分享预览部署时，持续使用您偏好的域名（从而保持品牌一致性）。

Check out [our documentation](https://vercel.com/docs/v2/custom-domains/) to learn more about this feature.

请查阅[我们的文档](https://vercel.com/docs/v2/custom-domains/)，深入了解此功能。

All our work is inspired by feedback from people like yourself. For feature requests, or to suggest ideas to make our platform and your experience better, please reach out to us [via email](mailto:support@vercel.com) or on [Twitter](https://twitter.com/vercel).

我们所有的开发工作都源于像您这样的用户所提出的宝贵反馈。如需提出功能需求，或有任何建议以帮助我们优化平台与您的使用体验，欢迎随时通过[电子邮件](mailto:support@vercel.com)或[Twitter](https://twitter.com/vercel)与我们联系。
&#123;% endraw %}
