---
title: "Python 3.12 and Ruby 3.3 are now available - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/python-3-12-and-ruby-3-3-are-now-available"
date: "2024-05-06"
scraped_at: "2026-03-02T09:45:12.586393512+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
{% raw %}

May 6, 2024

2024年5月6日

![](images/python-3_12-and-ruby-3_3-are-now-available-vercel/img_001.jpg)![](images/python-3_12-and-ruby-3_3-are-now-available-vercel/img_002.jpg)

Starting today, new Python [Builds](https://vercel.com/docs/deployments/builds) and [Functions](https://vercel.com/docs/functions/serverless-functions) will use version [3.12](https://peps.python.org/pep-0693/) and new Ruby Builds and Functions will use version [3.3](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/).

从今天起，新的 Python [构建（Builds）](https://vercel.com/docs/deployments/builds) 和 [函数（Functions）](https://vercel.com/docs/functions/serverless-functions) 将默认使用 [3.12](https://peps.python.org/pep-0693/) 版本；新的 Ruby 构建和函数则将默认使用 [3.3](https://www.ruby-lang.org/en/news/2023/12/25/ruby-3-3-0-released/) 版本。

If you need to continue using Python [3.9](https://www.python.org/dev/peps/pep-0596/) or Ruby [3.2](https://www.ruby-lang.org/en/news/2022/12/25/ruby-3-2-0-released/), ensure you have `18.x` selected for the Node.js Version in your project settings to use the [older build image](https://vercel.com/docs/deployments/build-image#runtime-support).

如需继续使用 Python [3.9](https://www.python.org/dev/peps/pep-0596/) 或 Ruby [3.2](https://www.ruby-lang.org/en/news/2022/12/25/ruby-3-2-0-released/)，请在项目设置中将 Node.js 版本设为 `18.x`，以启用[旧版构建镜像（older build image）](https://vercel.com/docs/deployments/build-image#runtime-support)。

For Python 3.9, ensure your `Pipfile` and corresponding `Pipfile.lock` have `python_version` set to `3.9` exactly. Similarly, for Ruby 3.2, make sure `ruby "~> 3.2.x"` is defined in the `‌Gemfile`.

对于 Python 3.9，请确保您的 `Pipfile` 及对应的 `Pipfile.lock` 文件中 `python_version` 字段**精确指定为 `3.9`**；同理，对于 Ruby 3.2，请确保 `Gemfile` 中包含 `ruby "~> 3.2.x"` 声明。

Check out [the documentation](https://vercel.com/docs/runtimes#official-runtimes) to learn more about our supported runtimes.

请查阅[相关文档](https://vercel.com/docs/runtimes#official-runtimes)，了解我们所支持的运行时环境（runtimes）的更多信息。
{% endraw %}
