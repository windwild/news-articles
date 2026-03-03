---
title: "Improved CLI experience when linking and creating environment variables​​​​‌‍​‍​‍‌‍ ‌​‍‌‍‍‌‌‍‌‌‍‍‌‌‍‍​‍​‍​‍‍​‍​‍‌‍​‌‍ ‌‍‍‌‌​‌‍‌‌‌‍‍‌‌​‌‍‌‍‌‌‌‌‍​​‍‍‌‍​‌‍ ‌‍‌​‍​‍​‍​​‍​‍‌‍‍​‌​‍‌‍‌‌‌‍‌‍​‍​‍​‍‍​‍​‍‌‍‍​‌‌​‌‌​‌​​‌​​‍‍​‍ ​‍ - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-cli-experience-when-linking-and-creating-environment-variables"
date: "2025-10-05"
scraped_at: "2026-03-02T09:27:37.323531961+00:00"
language: "en"
translated: false
description: "The Vercel CLI 49.0.0 introduces standardized ls error handling along with improved project linking, environment variable syncing, and more reliable --repo behavior."
---




Oct 5, 2025

![](images/improved-cli-experience-when-linking-and-creating-environment-variables-vercel/img_001.jpg)

Here are some of the key improvements introduced in version 50.0.0:

- After successfully linking a project, the CLI now prompts you to pull your Project’s Environment Variables to keep your local setup aligned with your deployed configuration.

- Input for new Environment Variables is now masked during interactive entry

- When connecting to an existing project with `link`, the CLI now shows an interactive selector if you have fewer than 100 Projects.

- Fixed an issue where `vc link --repo` would incorrectly prefix project names.

- Commands that support the `ls` argument now have standardized behavior. Extra or unexpected arguments will consistently produce a clear error and exit early, ensuring predictable and reliable results across all `ls` commands. This change may require updates to scripts that depended on the previous behavior.