---
title: "February 2020 - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/changelog-february-2020"
date: "2020-02-01"
scraped_at: "2026-03-02T10:07:28.829697649+00:00"
language: "en"
translated: false
description: "Vercel's changelog for February 2020"
---




Feb 1, 2020

## Domains

- When adding external domains to a project, we no longer require setting a TXT record for them.


## Deployments

- Python Serverless Functions can now be [configured](https://zeit.co/docs/configuration#project/functions) with a `excludeFiles` property in `functions`, which lets you explicitly exclude certain files from the final Serverless Function.

- New projects created [from templates](https://zeit.co/docs#quickstarts) now contain working framework logos in their `README.md` files.

- Customers on the [Hobby plan](https://zeit.co/pricing) are now unable to create Now 1.0 deployments.

- The [Node.js version](https://zeit.co/docs/runtimes#official-runtimes/node-js/node-js-version) available for builds was set to `12.14.1` for `12.x` and `10.18.0` for `10.x`, to match the AWS Lambda runtime.


## Dashboard

- The ["Import Project" page](https://zeit.co/new) now lets you decide between Importing a Git repository or a template.

- Creating a new project [using a template](https://zeit.co/docs#quickstarts) now automatically creates a Git repository to make editing it easier.

- The "Deploy Hooks" option and the "Git Branch" Domain option in the project settings now work if your Git repository contains hundreds of branches.

- Team member roles ("Owner" and "Member") are now available on all pricing plans

- The "Domains" tab on the project view was now removed in favor of the "Domains" sidebar item on the "Settings" tab.

- Changing the settings of an existing teams on a mobile device doesn't automatically focus the text areas anymore.

- The Now 1.0 pricing page was removed.

- The "Platform Version" field was removed from the account and team settings.