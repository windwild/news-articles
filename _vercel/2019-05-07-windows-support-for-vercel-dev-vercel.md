---
title: "Windows Support for `vercel dev` - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-dev-windows"
date: "2019-05-07"
scraped_at: "2026-03-02T10:07:53.495462988+00:00"
language: "en-zh"
translated: true
description: "As of today, you can use the `vercel dev` command of Vercel CLI on Windows."
---

render_with_liquid: false
May 7, 2019

2019 年 5 月 7 日

With the [release](http://zeit.co/blog/now-dev) of `vercel dev`, we provided developers with the first single-command development environment that can handle multiple services at once.

随着 [`vercel dev`](http://zeit.co/blog/now-dev) 的发布，我们为开发者提供了首个支持单命令启动、可同时处理多个服务的开发环境。

In order to open up this opportunity to an even wider range of users, we are very pleased to announce that **`vercel dev`** **supports Windows**.

为了让更广泛的用户群体能够享受这一便利，我们非常高兴地宣布：**`vercel dev` 现已支持 Windows 系统**。

## Supported Terminals

## 支持的终端

As of the latest version of [Vercel CLI](http://zeit.co/download), the following terminals are supported on Windows:

截至最新版 [Vercel CLI](http://zeit.co/download)，以下终端已在 Windows 上获得支持：

- [Command Prompt](https://en.wikipedia.org/wiki/Cmd.exe) (cmd.exe)

- [命令提示符（Command Prompt）](https://en.wikipedia.org/wiki/Cmd.exe)（cmd.exe）

- [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL)

- [Windows 子系统 for Linux（WSL）](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux)（WSL）

- [PowerShell](https://en.wikipedia.org/wiki/PowerShell) (powershell.exe)

- [PowerShell](https://en.wikipedia.org/wiki/PowerShell)（powershell.exe）

- [Hyper](https://hyper.is/) (hyper.exe)

- [Hyper](https://hyper.is/)（hyper.exe）

- [Git BASH](https://gitforwindows.org/) (bash.exe)

- [Git BASH](https://gitforwindows.org/)（bash.exe）

Just like on all the other operating systems, setting up your development server is as easy as running a single command:

就像在所有其他操作系统上一样，设置开发服务器只需运行一条命令即可：

In this example, a Next.js application is run using `vercel dev`.

本例中，我们使用 `vercel dev` 运行一个 Next.js 应用。

## No Dependencies

## 无需额外依赖

If you have [Node.js](https://nodejs.org/en/) installed, you can install Vercel CLI (and therefore `vercel dev`) using [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/lang/en/):

只要您已安装 [Node.js](https://nodejs.org/en/)，即可通过 [npm](https://www.npmjs.com/) 或 [yarn](https://yarnpkg.com/lang/en/) 安装 Vercel CLI（从而获得 `vercel dev` 命令）：

```bash
npm install -g vercel
```

## Conclusion

## 总结

Our team is working hard to ensure [Vercel CLI](http://zeit.co/download) works on all the common operating systems (Linux, Windows, macOS and Alpine Linux).

我们的团队正全力以赴，确保 [Vercel CLI](http://zeit.co/download) 兼容所有主流操作系统（Linux、Windows、macOS 和 Alpine Linux）。

Should you experience any bugs, please do not hesitate to contact [our support team](http://zeit.co/support).

如您遇到任何 Bug，请随时联系我们的[技术支持团队](http://zeit.co/support)。