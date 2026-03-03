---
title: "The Directory Listing feature will be disabled for older projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/the-directory-listing-feature-will-be-disabled-for-older-projects"
date: "2021-02-08"
scraped_at: "2026-03-02T10:05:38.188050778+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Feb 8, 2021

![](images/the-directory-listing-feature-will-be-disabled-for-older-projects-vercel/img_001.jpg)

Last month, Vercel [announced](https://vercel.com/changelog/listing-the-content-of-directories-can-now-be-toggled) that the Directory Listing feature could now be toggled directly from the Project Settings and that it would be disabled for newly created Projects.

In favor of security, and to prevent unexpected behavior for older Projects, the Directory Listing feature will be disabled for all Projects that were created before January 12th 2021, which is the release date of the respective Project Setting.

The change will be applied on **March 8th 2021**.

Because the Directory Listing feature allows for accessing the source code of a Deployment if no [index file](https://vercel.com/docs/edge-network/directory-listing#disabling-directory-listing-on-a-specific-directory) is present within it, it's safer to disable it by default. If you want, however, you can turn the feature back on right afterwards, if you're relying on it.

Check out [the documentation](https://vercel.com/docs/edge-network/directory-listing) as well.