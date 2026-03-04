---
title: "Introducing `vercel dev`: Serverless, on localhost - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-dev"
date: "2019-04-30"
scraped_at: "2026-03-02T10:07:57.051206785+00:00"
language: "en-zh"
translated: true
description: "With Vercel CLI's new `vercel dev` command, you can locally work on Vercel applications easily, without having to deploy them."
---

render_with_liquid: false
Apr 30, 2019

2019 年 4 月 30 日

将前端云环境带到你的本地机器，实现无缝的开发体验。

Vercel 的诞生源于一个理念：网站部署本可以简单得多。你只需运行一条命令：`vercel`——仅此而已。

借助我们的 [GitHub](https://vercel.com/docs/git/vercel-for-github) 和 [GitLab](https://vercel.com/docs/git/vercel-for-gitlab) 集成，我们实现了每次 `git push` 后自动部署，并让团队仅通过合并 Pull Request 即可轻松管理预发布（staging）与生产（production）环境。

Vercel 不仅让部署变得轻而易举，更默认实现了部署的可扩展性与全球分发能力。得益于对单体仓库（monorepo）的支持，你可以在同一代码仓库中同时开发静态网站和 [无服务器函数（serverless functions）](https://vercel.com/docs/serverless-functions/introduction)。

**今天，我们非常激动地宣布：一条命令即可在本地运行全部服务——**`vercel dev`**。**

## 单命令本地开发

通常，开发一个网站或应用需要经历一系列步骤：

- 克隆代码仓库

- 拉取依赖包

- Synchronizing and matching ports  
- 同步并匹配端口

- Downloading the right runtime for each programming language  
- 为每种编程语言下载正确的运行时环境

- And so on...  
- 等等……

Even for modern projects, we often need to look up the `README.md` file for instructions about installing dependencies, and then tell a package manager to run developer scripts.  
即使是现代项目，我们也常常需要查阅 `README.md` 文件，以获取安装依赖项的说明，然后指示包管理器运行开发脚本。

**Vercel gives you a different contract. It is always** **`vercel dev`** **.**  
**Vercel 为您提供了一种不同的约定：始终使用** **`vercel dev`** **。**

## No more Control+C  
## 不再需要按 Ctrl+C

When you work with servers, the developer workflow is quite tedious. You have to run a process, find the port, then make your changes, then kill the process (usually with Control+C)...  
在开发服务器端应用时，开发者工作流往往十分繁琐：你需要启动一个进程、查找其监听端口、修改代码、再终止该进程（通常需按 Ctrl+C）……

When you work with **modern frontend frameworks,** your HTML, CSS, and client-side JavaScript **hot-reloading** is expected instead.  
而在使用**现代前端框架**时，人们则理所当然地期望 HTML、CSS 和客户端 JavaScript 具备**热重载（hot-reloading）**能力。

When you introduce [API endpoints](https://nextjs.org/docs/api-routes/introduction) written as serverless functions, we now also have the advantage of bringing live reloading to your backend. `vercel dev` ensures that every single request builds and runs the latest version of your code (yes, like `.php` for every language).  
当你引入以无服务器函数（serverless functions）形式编写的 [API 路由](https://nextjs.org/docs/api-routes/introduction) 时，我们如今还能将实时重载（live reloading）能力延伸至后端。`vercel dev` 可确保每一次请求都基于你代码的最新版本进行构建与执行（没错，就像每种语言都拥有了 `.php` 那样的即时生效能力）。

**Note:** Using Next.js with `next dev` will run both your front-end and serverless functions already. You do not need to use `vercel dev`.  
**注意：** 若使用 Next.js 并运行 `next dev`，它已能同时启动你的前端和无服务器函数，因此无需额外使用 `vercel dev`。

### Gatsby and Node.js Functions

### Gatsby 与 Node.js 函数

If you are building a static site using a tool like [Gatsby](https://www.gatsbyjs.org/), all you need to do is add the command you would normally use to a `dev` script in `package.json`...

如果你正使用 [Gatsby](https://www.gatsbyjs.org/) 这类工具构建静态网站，只需将你通常使用的命令添加到 `package.json` 文件的 `dev` 脚本中即可……

```json
1{

2  "scripts": {

3    "dev": "gatsby develop -p $PORT"

4  }

5}
```

```json
1{

2  "scripts": {

3    "dev": "gatsby develop -p $PORT"

4  }

5}
```

Once that is completed, the tool (in this case `gatsby develop`) is invoked automatically.

完成上述配置后，该工具（此处为 `gatsby develop`）将自动被调用。

The [Gatsbygram](https://github.com/gatsbyjs/gatsby/tree/master/examples/gatsbygram) example showcases this really well:

[Gatsbygram](https://github.com/gatsbyjs/gatsby/tree/master/examples/gatsbygram) 示例很好地展示了这一用法：

In this example, Gatsbygram is run using \`vercel dev\`.

在此示例中，Gatsbygram 通过 \`vercel dev\` 命令运行。

### Go Functions with static HTML

### 使用静态 HTML 的 Go 函数

If you chose to write a backend in [Go](https://golang.org/), there are no changes to be made in order for your project to work with `vercel dev`, you just run the command:

如果你选择使用 [Go](https://golang.org/) 编写后端，那么无需对项目做任何修改，即可直接通过 `vercel dev` 命令运行——你只需执行该命令即可：

In this example, a static site and a Go serverless function are run in parallel.

本示例中，一个静态网站与一个 Go 无服务器函数将并行运行。

### Node.js and headless Chrome

### Node.js 与无头 Chrome

Even if your application is spawning an instance of [Headless Chrome](https://developers.google.com/web/updates/2017/04/headless-chrome) (like [puppeteer](https://github.com/GoogleChrome/puppeteer)), local development will be very smooth, as `vercel dev` emulates production closely:

即使你的应用需要启动一个 [Headless Chrome](https://developers.google.com/web/updates/2017/04/headless-chrome) 实例（例如借助 [puppeteer](https://github.com/GoogleChrome/puppeteer)），本地开发体验依然十分流畅，因为 `vercel dev` 高度模拟了生产环境：

As you can see, both \`vercel dev\` and \`puppeteer\` will boot up in no time.

如你所见，`\`vercel dev\`` 和 `\`puppeteer\`` 都将瞬间启动。

### Static Sites

### 静态网站

As a bonus, you will be glad to know that `vercel dev` also acts as a substitute for [serve](https://github.com/vercel/serve) out of the box. Any time you want to serve a directory quickly, you know what to reach for:

额外福利：你将很高兴地发现，`vercel dev` 开箱即用地替代了 [serve](https://github.com/vercel/serve)。每当需要快速托管某个目录时，你自然知道该用什么工具：

Even though there is no \`vercel.json\` file, serving the directory just works.

即便项目中没有 `\`vercel.json\`` 文件，该目录也能直接被成功托管。

## Get Started

## 快速开始

`vercel dev` is available as part of the latest version of [Vercel CLI](https://vercel.com/cli). For more details, check out [its documentation](https://vercel.com/docs/serverless-functions/introduction#local-development) including [the list](https://vercel.com/docs/build-step#framework-preset) of optimized frameworks.

`vercel dev` 已随最新版本的 [Vercel CLI](https://vercel.com/cli) 一并发布。如需了解更多详情，请参阅其[文档](https://vercel.com/docs/serverless-functions/introduction#local-development)，其中还包含一份[已优化框架列表](https://vercel.com/docs/build-step#framework-preset)。

## Let's develop together

## 让我们携手开发

We want to hear from you and have set up a [dedicated feedback](https://vercel.com/support) form to learn more about the different ways in which you would like to see `vercel dev` improve: Which technologies, platforms, and frameworks you would like us to support, or any hiccups or slow paths you run into.

我们非常期待听到您的声音，并专门设立了一份[反馈表单](https://vercel.com/support)，以深入了解您对 `vercel dev` 的改进建议：例如，您希望我们支持哪些技术、平台和框架，或您在使用过程中遇到的任何卡顿、性能瓶颈等问题。

Furthermore, we also set up a [FAQ page](https://vercel.com/docs/platform/frequently-asked-questions) containing several common questions that might come up when using `vercel dev` and their answers.

此外，我们还整理了一份[常见问题解答（FAQ）页面](https://vercel.com/docs/platform/frequently-asked-questions)，汇总了使用 `vercel dev` 时可能遇到的若干常见问题及其解答。

And as always, you are invited to [join our community](https://github.com/vercel/vercel/discussions) and drop the team a note.

一如既往，诚邀您[加入我们的社区](https://github.com/vercel/vercel/discussions)，随时向团队留言交流。