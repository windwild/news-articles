---
title: "Multiple Git namespaces per Personal Account and Team - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/multiple-git-namespaces-per-personal-account-and-team"
date: "2021-01-08"
scraped_at: "2026-03-02T10:06:13.825348603+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 8, 2021

![](images/multiple-git-namespaces-per-personal-account-and-team-vercel/img_001.jpg)

When connecting a Project on Vercel to a Git repository, the Git repository previously had to be located in the same Git scope as the Git repositories of all other Projects within that Personal Account or Team.

Now that this connection is defined on the Project-level (see above) instead of being configured on the Personal Account or Team, this limitation is lifted. Additionally, problems with an active connection are now surfaced there too.

Every Personal Account or Team can now contain Vercel Projects that are connected to Git repositories located in various different Git scopes. This also means that, when importing one, Vercel no longer forces a certain destination Personal Account or Team.

Check out [the documentation](https://vercel.com/docs/platform/projects#git) as well.