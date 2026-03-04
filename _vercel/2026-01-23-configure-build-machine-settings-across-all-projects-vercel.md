---
render_with_liquid: false
title: "Configure build machine settings across all projects - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/configure-build-machine-settings-across-all-projects"
date: "2026-01-23"
scraped_at: "2026-03-02T09:22:20.534666422+00:00"
language: "en-zh"
translated: true
description: "Manage build and deployment settings across all Vercel projects at once. Configure Build Machines and On-Demand Concurrent Builds from a single place."
---
render_with_liquid: false
render_with_liquid: false

Jan 23, 2026

2026 年 1 月 23 日

构建与部署设置现已支持在团队级别进行配置，并可应用于该团队下的所有项目，相较此前需逐个项目单独配置的方式更加高效。

[构建机器](https://vercel.com/docs/builds/managing-builds#larger-build-machines) 允许您为每次构建选择合适的计算资源，以优化构建耗时：

- 标准构建机器：4 个虚拟 CPU（vCPU），8 GB 内存  
- 增强型构建机器：8 个虚拟 CPU（vCPU），16 GB 内存  
- Turbo 构建机器：30 个虚拟 CPU（vCPU），60 GB 内存  

[按需并发构建](https://vercel.com/docs/deployments/managing-builds#on-demand-concurrent-builds) 可控制同时运行的构建数量，以及构建是否跳过排队队列。

您现在可一次性将配置应用至团队内全部项目，也可通过统一界面，对多个项目进行定向调整。

[立即开始使用](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fbuild-and-deployment) 团队级设置。