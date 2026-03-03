---
title: "DNS Records UI - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/dns-records-ui"
date: "2020-06-23"
scraped_at: "2026-03-02T10:06:42.394787763+00:00"
language: "en"
translated: false
description: "Configure custom DNS Records for your Domains and apply presets. Right in the Web UI."
---




Jun 23, 2020

Set your DNS records including presets for commonly used records.

Applying custom **DNS Records to your Domains** (for receiving emails, for example) has so far always required interacting with our advanced [command-line interface](https://vercel.com/download).

From today, you'll be able to manage them **directly from the Web UI** and even insert presets for commonly used DNS Records.

## New Domain Setting

To edit the existing DNS Records of your Domain or add new ones, navigate to the **Domains** page of your Project Settings. There, click **Edit** on the Domain of your choice and you'll find a link at the bottom of the view:

![Editing a Domain within the Project Settings.](images/dns-records-ui-vercel/img_001.jpg)Editing a Domain within the Project Settings.

On the following screen, you'll then be presented with all the details about your Domain and you'll be – among other things – able to **manage its DNS Records**:

![Editing the DNS Records of a Domain.](images/dns-records-ui-vercel/img_002.jpg)Editing the DNS Records of a Domain.

With this section, you can **add new** DNS Records and **remove** or **edit** existing ones, easier than ever, allowing you to get back to your Project without losing focus.

### Presets

Commonly, new DNS Records that are added on our platform are of the type `MX` and are used for receiving emails on services such as [Gmail](https://gmail.com/).

To make working with `MX` services easier, we've added an **Add Preset** button that lets you choose from a list of those services, to easily insert their necessary DNS Records:

![Adding a DNS Record Preset to a Domain.](images/dns-records-ui-vercel/img_003.jpg)Adding a DNS Record Preset to a Domain.

## Conclusion

If you need to receive emails through your custom Domains or configure any other kind of DNS Record, you can now do so directly from the Web UI.

Your DNS Records will only be reflected if you've [bought your Domain](https://vercel.com/domains) with Vercel, [transferred it in](https://vercel.com/guides/transferring-domains-to-vercel), or if you're using our nameservers.

For more details, check out the [documentation](https://vercel.com/docs/v2/custom-domains#dns-records).

[Let us know](https://zeit.co/contact) what you think about this change and if there are any DNS Records Presets you'd like to see us add. We're excited to help you succeed.