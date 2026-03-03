---
title: "Introducing Wildcard Domains - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/wildcard-domains"
date: "2019-09-10"
scraped_at: "2026-03-02T10:07:31.702203448+00:00"
language: "en"
translated: false
description: "Wildcard Domains allow for pointing all imaginable sub domains to a project, without having to define those sub domains at all."
---




Sep 10, 2019

With [Vercel](https://zeit.co/home), you can already deploy to HTTPS-enabled subdomains of your choice.

What if you could let customers choose those subdomains (like with [Slack workspaces](https://acme.slack.com/))? Today, we're making this possible with the introduction of **Wildcard Domains**!

## Adding Wildcard Domains

Capturing all subdomains on the fly is as simple as visiting your project's **Domains** tab:

![In this case, we selected a project called "static-fun".](images/introducing-wildcard-domains-vercel/img_001.jpg)In this case, we selected a project called "static-fun".

Then, enter a wildcard domain of your choice and click "Add":

![](images/introducing-wildcard-domains-vercel/img_002.jpg)

Next, you will be asked to configure it.

![If you purchased your domain via Vercel, you won't need to verify it.](images/introducing-wildcard-domains-vercel/img_003.jpg)If you purchased your domain via Vercel, you won't need to verify it.

After you have correctly configured the nameservers of your domain, it will automatically be assigned to your latest production deployment – which will then be indicated in the UI.

![The two blue messages indicate that the domain was successfully applied.](images/introducing-wildcard-domains-vercel/img_004.jpg)The two blue messages indicate that the domain was successfully applied.

Once your domain has valid configuration, you can start using it.

## Demo Time

In order to demonstrate how powerful **Wildcard Domains** really are, we've created a demo project that lets you acquire a subdomain of your choice, on which you can build a tiny website.

[Give it a try!](https://static.fun/)

The full power of Wildcard Domains in action

As you can see, Wildcard Domains allowed us to offer every visitor with a fresh HTML editor in which they can place their own content. Other people visiting those URLs will see a read-only preview.

The entire [static.fun](https://static.fun/) project is **open source**. Make sure to [check out the code](https://github.com/zeit/static-fun)!

## Conclusion

With **Wildcard Domains**, you can capture all subdomains on the fly and have a single deployment take care of them. This allows you to offer highly customizable workspaces or profiles to each of your users with no special effort.

We can't wait to find out what you will create with this! [Let us know via Twitter](https://twitter.com/vercel).