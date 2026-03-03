---
title: "Sandbox now supports sudo and installing RPM packages - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sandbox-now-supports-sudo-and-installing-rpm-packages"
date: "2025-07-04"
scraped_at: "2026-03-02T09:31:42.250036404+00:00"
language: "en-zh"
translated: true
description: "You can now run commands with sudo inside Vercel Sandbox, giving you full control to install packages at runtime, just like on a traditional Linux system."
---

Jul 4, 2025

2025 年 7 月 4 日

You can now run commands with `sudo` inside [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), giving you full control over runtime environment setup, just like on a traditional Linux system.

现在，您可以在 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 内使用 `sudo` 运行命令，从而像在传统 Linux 系统上一样，完全掌控运行时环境的配置。

This makes it possible to install system dependencies at runtime, like Go, Python packages, or custom binaries, before executing your code.

这使得您能够在执行代码前，于运行时安装系统依赖项（例如 Go、Python 包或自定义二进制文件）。

`sudo` is available via the `runCommand` method:

`sudo` 可通过 `runCommand` 方法调用：

```javascript
import { Sandbox } from "@vercel/sandbox";

const sandbox = await Sandbox.create();

await sandbox.runCommand({
  cmd: "dnf",
  args: ["install", "-y", "golang"]
});
```

7  sudo: true,

8});
```

沙盒的 `sudo` 配置旨在便于使用：

- 保留 `PATH` 环境变量  
- 将 `HOME` 设置为 `/root`  
- 自定义环境变量（例如 `env: { FOO: "bar" }`）可直接透传

在 Sandbox 中启用 `sudo` 后，无需任何变通方案，即可在具备恰当权限的隔离环境中更轻松地运行不受信任的代码。

了解更多关于 [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) 和文档中的 [sudo 配置](https://vercel.com/docs/vercel-sandbox#sudo-config)。