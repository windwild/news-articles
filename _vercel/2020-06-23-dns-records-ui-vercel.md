---
title: "DNS Records UI - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/dns-records-ui"
date: "2020-06-23"
scraped_at: "2026-03-02T10:06:42.394787763+00:00"
language: "en-zh"
translated: true
description: "Configure custom DNS Records for your Domains and apply presets. Right in the Web UI."
---

render_with_liquid: false
Jun 23, 2020

Jun 23, 2020

Set your DNS records including presets for commonly used records.

设置您的 DNS 记录，包括常用 DNS 记录的预设选项。

Applying custom **DNS Records to your Domains** (for receiving emails, for example) has so far always required interacting with our advanced [command-line interface](https://vercel.com/download).

此前，为您的域名配置自定义 **DNS 记录**（例如用于接收电子邮件）始终需要通过我们功能强大的 [命令行界面（CLI）](https://vercel.com/download) 来完成。

From today, you'll be able to manage them **directly from the Web UI** and even insert presets for commonly used DNS Records.

从今天起，您将能够 **直接在 Web 界面中管理这些记录**，甚至可一键插入常用 DNS 记录的预设配置。

## New Domain Setting

## 新增域名设置功能

To edit the existing DNS Records of your Domain or add new ones, navigate to the **Domains** page of your Project Settings. There, click **Edit** on the Domain of your choice and you'll find a link at the bottom of the view:

如需编辑现有域名的 DNS 记录或添加新记录，请进入项目设置中的 **“域名（Domains）”** 页面。在该页面中，点击您要操作的域名旁的 **“编辑（Edit）”** 按钮，即可在视图底部看到相关链接：

![Editing a Domain within the Project Settings.](images/dns-records-ui-vercel/img_001.jpg)  
![在项目设置中编辑域名。](images/dns-records-ui-vercel/img_001.jpg)

On the following screen, you'll then be presented with all the details about your Domain and you'll be – among other things – able to **manage its DNS Records**:

进入下一页面后，您将看到该域名的全部详细信息；其中一项重要功能便是 **管理其 DNS 记录**：

![Editing the DNS Records of a Domain.](images/dns-records-ui-vercel/img_002.jpg)  
![编辑域名的 DNS 记录。](images/dns-records-ui-vercel/img_002.jpg)

With this section, you can **add new** DNS Records and **remove** or **edit** existing ones, easier than ever, allowing you to get back to your Project without losing focus.

借助此功能区，您可以 **轻松添加新的 DNS 记录**，以及 **删除或编辑已有记录**——操作比以往更便捷，助您快速返回项目开发，全程不中断思路。

### Presets

### 预设配置

Commonly, new DNS Records that are added on our platform are of the type `MX` and are used for receiving emails on services such as [Gmail](https://gmail.com/).

通常，我们在平台上新增的 DNS 记录多为 `MX` 类型，用于在 [Gmail](https://gmail.com/) 等邮件服务中接收电子邮件。

To make working with `MX` services easier, we've added an **Add Preset** button that lets you choose from a list of those services, to easily insert their necessary DNS Records:

为简化 `MX` 服务的配置流程，我们新增了 **添加预设** 按钮，您可从列表中选择对应服务，一键插入其所需的 DNS 记录：

![Adding a DNS Record Preset to a Domain.](images/dns-records-ui-vercel/img_003.jpg)  
向域名添加 DNS 记录预设。

## Conclusion

## 总结

If you need to receive emails through your custom Domains or configure any other kind of DNS Record, you can now do so directly from the Web UI.

如果您需要通过自定义域名接收邮件，或需配置其他类型的 DNS 记录，现在均可直接通过 Web 管理界面完成。

Your DNS Records will only be reflected if you've [bought your Domain](https://vercel.com/domains) with Vercel, [transferred it in](https://vercel.com/guides/transferring-domains-to-vercel), or if you're using our nameservers.

仅当您已在 Vercel [购买域名](https://vercel.com/domains)、[将域名转入 Vercel](https://vercel.com/guides/transferring-domains-to-vercel)，或正在使用 Vercel 提供的域名服务器（nameservers）时，所配置的 DNS 记录才会生效。

For more details, check out the [documentation](https://vercel.com/docs/v2/custom-domains#dns-records).

如需了解更多详情，请参阅 [官方文档](https://vercel.com/docs/v2/custom-domains#dns-records)。

[Let us know](https://zeit.co/contact) what you think about this change and if there are any DNS Records Presets you'd like to see us add. We're excited to help you succeed.

欢迎通过 [联系我们](https://zeit.co/contact) 告知我们您对本次更新的看法，以及您希望我们后续支持的 DNS 记录预设类型。我们非常期待助您取得成功！