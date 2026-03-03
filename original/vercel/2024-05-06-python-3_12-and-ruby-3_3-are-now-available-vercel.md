---
title: "Python 3.12 and Ruby 3.3 are now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-3-12-and-ruby-3-3-are-now-available"
date: "2024-05-06"
scraped_at: "2026-03-02T09:45:12.586393512+00:00"
language: "en"
translated: false
description: "The best way to deploy your Next.js site."
---




May 6, 2024

![](images/python-3_12-and-ruby-3_3-are-now-available-vercel/img_001.jpg)![](images/python-3_12-and-ruby-3_3-are-now-available-vercel/img_002.jpg)

Starting today, new Python [Builds](https://vercel.com/docs/deployments/builds) and [Functions](https://vercel.com/docs/functions/serverless-functions) will use version [3.12](https://peps.python.org/pep-0693/) and new Ruby Builds and Functions will use version [3.3](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/).

If you need to continue using Python [3.9](https://www.python.org/dev/peps/pep-0596/) or Ruby [3.2](https://www.ruby-lang.org/en/news/2022/12/25/ruby-3-2-0-released/), ensure you have `18.x` selected for the Node.js Version in your project settings to use the [older build image](https://vercel.com/docs/deployments/build-image#runtime-support).

For Python 3.9, ensure your `Pipfile` and corresponding `Pipfile.lock` have `python_version` set to `3.9` exactly. Similarly, for Ruby 3.2, make sure `ruby "~> 3.2.x"` is defined in the `‌Gemfile`.

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes) to learn more about our supported runtimes.