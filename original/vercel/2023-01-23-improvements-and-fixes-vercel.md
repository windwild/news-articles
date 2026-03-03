---
title: "Improvements and fixes - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/january-2023"
date: "2023-01-23"
scraped_at: "2026-03-02T09:56:00.066313790+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




Jan 23, 2023

![](images/improvements-and-fixes-vercel/img_001.jpg)

- **Image Optimization:** Source images for Vercel Image Optimization can now be viewed on the [Usage tab](https://vercel.com/docs/concepts/limits/usage).

- **Vercel CLI:** Shipped [v28.12.7](https://github.com/vercel/vercel/releases/tag/vercel%4028.12.7) with improved [Gatsby support](https://vercel.com/changelog/improved-support-for-gatsby-sites).

- **Python Runtime for Vercel Functions:** Improved documentation and [examples](https://vercel.com/templates/python) for using the Python Runtime for Vercel Serverless Functions.

- **Edge Functions:** Improved source map resolution and filtering

for more readable and actionable errors.

- **Docs search:** Improved search in docs by making `CMD+K` the default, enhancing the accuracy and relevance of search results, and including path-based recommendations.

- **Changes to**`.vercelignore` **:** Created a `.vercelignore` file in the "root directory" to fix a bug that caused deployments sourced from git to not properly resolve the `.vercelignore` when a "root directory" has been set.