---
title: "Windows Support for `vercel dev` - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/vercel-dev-windows"
date: "2019-05-07"
scraped_at: "2026-03-02T10:07:53.495462988+00:00"
language: "en"
translated: false
description: "As of today, you can use the `vercel dev` command of Vercel CLI on Windows."
---




May 7, 2019

With the [release](http://zeit.co/blog/now-dev) of `vercel dev`, we provided developers with the first single-command development environment that can handle multiple services at once.

In order to open up this opportunity to an even wider range of users, we are very pleased to announce that **`vercel dev`** **supports Windows**.

## Supported Terminals

As of the latest version of [Vercel CLI](http://zeit.co/download), the following terminals are supported on Windows:

- [Command Prompt](https://en.wikipedia.org/wiki/Cmd.exe) (cmd.exe)

- [Windows Subsystem for Linux](https://en.wikipedia.org/wiki/Windows_Subsystem_for_Linux) (WSL)

- [PowerShell](https://en.wikipedia.org/wiki/PowerShell) (powershell.exe)

- [Hyper](https://hyper.is/) (hyper.exe)

- [Git BASH](https://gitforwindows.org/) (bash.exe)


Just like on all the other operating systems, setting up your development server is as easy as running a single command:

In this example, a Next.js application is run using \`vercel dev\`.

## No Dependencies

If you have [Node.js](https://nodejs.org/en/) installed, you can install Vercel CLI (and therefore `vercel dev`) using [npm](https://www.npmjs.com/) or [yarn](https://yarnpkg.com/lang/en/):

```bash
npm install -g vercel
```

## Conclusion

Our team is working hard to ensure [Vercel CLI](http://zeit.co/download) works on all the common operating systems (Linux, Windows, macOS and Alpine Linux).

Should you experience any bugs, please do not hesitate to contact [our support team](http://zeit.co/support).