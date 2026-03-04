---
title: "Introducing Wildcard Domains - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/wildcard-domains"
date: "2019-09-10"
scraped_at: "2026-03-02T10:07:31.702203448+00:00"
language: "en-zh"
translated: true
description: "Wildcard Domains allow for pointing all imaginable sub domains to a project, without having to define those sub domains at all."
---

render_with_liquid: false
Sep 10, 2019

2019 年 9 月 10 日

With [Vercel](https://zeit.co/home), you can already deploy to HTTPS-enabled subdomains of your choice.

借助 [Vercel](https://zeit.co/home)，您已可将应用部署至您自选的、启用 HTTPS 的子域名。

What if you could let customers choose those subdomains (like with [Slack workspaces](https://acme.slack.com/))? Today, we're making this possible with the introduction of **Wildcard Domains**!

倘若您能让客户自行选择这些子域名（类似 [Slack 工作区](https://acme.slack.com/) 的方式），会怎样？今天，我们通过推出 **通配符域名（Wildcard Domains）**，让这一设想成为现实！

## Adding Wildcard Domains

## 添加通配符域名

Capturing all subdomains on the fly is as simple as visiting your project's **Domains** tab:

实时捕获所有子域名，只需访问您项目的 **Domains（域名）** 标签页即可：

![In this case, we selected a project called "static-fun".](images/introducing-wildcard-domains-vercel/img_001.jpg)  
在此示例中，我们选择了一个名为 “static-fun” 的项目。

Then, enter a wildcard domain of your choice and click "Add":

接着，输入您选定的通配符域名，然后点击 “Add（添加）”：

![](images/introducing-wildcard-domains-vercel/img_002.jpg)

Next, you will be asked to configure it.

接下来，系统将提示您进行配置。

![If you purchased your domain via Vercel, you won't need to verify it.](images/introducing-wildcard-domains-vercel/img_003.jpg)  
若您是通过 Vercel 购买的域名，则无需额外验证。

After you have correctly configured the nameservers of your domain, it will automatically be assigned to your latest production deployment – which will then be indicated in the UI.

在正确配置您域名的域名服务器（nameservers）后，该域名将自动关联至您最新的生产环境部署——此状态随后将在用户界面（UI）中显示。

![The two blue messages indicate that the domain was successfully applied.](images/introducing-wildcard-domains-vercel/img_004.jpg)  
![两条蓝色消息表示域名已成功应用。](images/introducing-wildcard-domains-vercel/img_004.jpg)

The two blue messages indicate that the domain was successfully applied.

两条蓝色消息表示域名已成功应用。

Once your domain has valid configuration, you can start using it.

当您的域名完成有效配置后，即可开始使用。

## Demo Time

## 演示时间

In order to demonstrate how powerful **Wildcard Domains** really are, we've created a demo project that lets you acquire a subdomain of your choice, on which you can build a tiny website.

为充分展现 **通配符域名（Wildcard Domains）** 的强大能力，我们创建了一个演示项目：您可自由选择并获取一个子域名，并在其上构建一个微型网站。

[Give it a try!](https://static.fun/)  
[立即试用！](https://static.fun/)

The full power of Wildcard Domains in action  

通配符域名的全部能力正在实际运行中  

As you can see, Wildcard Domains allowed us to offer every visitor with a fresh HTML editor in which they can place their own content. Other people visiting those URLs will see a read-only preview.

如您所见，通配符域名使我们能够为每位访问者提供一个全新的 HTML 编辑器，供其自由添加内容；而其他访问这些 URL 的用户则仅能看到只读形式的预览。

The entire [static.fun](https://static.fun/) project is **open source**. Make sure to [check out the code](https://github.com/zeit/static-fun)!

整个 [static.fun](https://static.fun/) 项目均为 **开源**。欢迎前往 [查看源代码](https://github.com/zeit/static-fun)！

## Conclusion

## 总结

With **Wildcard Domains**, you can capture all subdomains on the fly and have a single deployment take care of them. This allows you to offer highly customizable workspaces or profiles to each of your users with no special effort.

借助**通配符域名（Wildcard Domains）**，您可实时捕获所有子域名，并通过一次部署统一管理它们。这使您无需额外投入，即可为每位用户提供高度可定制的工作区或个人资料。

We can't wait to find out what you will create with this! [Let us know via Twitter](https://twitter.com/vercel).

我们迫不及待想了解您将用此功能创造出什么！[欢迎通过 Twitter 告诉我们](https://twitter.com/vercel)。