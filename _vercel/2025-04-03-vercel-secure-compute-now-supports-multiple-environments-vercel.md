---
title: "Vercel Secure Compute now supports multiple environments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-secure-compute-now-supports-multiple-environments"
date: "2025-04-03"
scraped_at: "2026-03-02T09:35:01.410348537+00:00"
language: "en-zh"
translated: true
description: "Users can now associate each project environment—Production, Preview, and custom—with a distinct Secure Compute network directly from the project settings"
---
&#123;% raw %}

Apr 3, 2025

2025 年 4 月 3 日

![](images/vercel-secure-compute-now-supports-multiple-environments-vercel/img_001.jpg)![](images/vercel-secure-compute-now-supports-multiple-environments-vercel/img_002.jpg)

使用 [Vercel Secure Compute](https://vercel.com/docs/secure-compute) 的团队现在可直接在项目设置中，为每个 [项目环境](https://vercel.com/docs/deployments/environments)（包括 Production、Preview 及自定义环境）分别关联一个独立的 Secure Compute 网络。此举简化了单个项目内按环境进行网络隔离的操作。

要将您项目的各个环境连接至 Secure Compute，请执行以下步骤：

1. 前往 [您项目的 **Secure Compute** 设置页面](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Fsettings%2Fsecure-compute&title=Open+Secure+Compute+settings)

2. 对于您希望连接至 Secure Compute 的每个环境：

   - 选择一个 **活跃（active）** 网络  
   - （可选）选择一个 **被动（passive）** 网络以启用故障转移（failover）  
   - （可选）启用 **构建（builds）**，以便将项目的构建容器纳入该网络  

3. 点击 **保存（Save）** 以持久化您的配置更改  

了解更多关于 [Secure Compute](https://vercel.com/docs/secure-compute) 的信息。
&#123;% endraw %}
