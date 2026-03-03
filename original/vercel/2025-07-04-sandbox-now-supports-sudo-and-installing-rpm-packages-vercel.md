---
title: "Sandbox now supports sudo and installing RPM packages - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/sandbox-now-supports-sudo-and-installing-rpm-packages"
date: "2025-07-04"
scraped_at: "2026-03-02T09:31:42.250036404+00:00"
language: "en"
translated: false
description: "You can now run commands with sudo inside Vercel Sandbox, giving you full control to install packages at runtime, just like on a traditional Linux system."
---




Jul 4, 2025

You can now run commands with `sudo` inside [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox), giving you full control over runtime environment setup, just like on a traditional Linux system.

This makes it possible to install system dependencies at runtime, like Go, Python packages, or custom binaries, before executing your code.

`sudo` is available via the `runCommand` method:

```javascript
import { Sandbox } from "@vercel/sandbox";



const sandbox = await Sandbox.create();

await sandbox.runCommand({

5  cmd: "dnf",

6  args: ["install", "-y", "golang"],

7  sudo: true,

8});
```

The sandbox `sudo` configuration is designed to be easy to use:

- `PATH` is preserved

- `HOME` is set to /root

- Custom environment variables like `env: { FOO: "bar" }` are passed through


With `sudo` on Sandbox it's easier to run untrusted code in isolated environments with the right permissions, with no workarounds required.

Learn more about [Vercel Sandbox](https://vercel.com/docs/vercel-sandbox) and [sudo in the documentation](https://vercel.com/docs/vercel-sandbox#sudo-config).