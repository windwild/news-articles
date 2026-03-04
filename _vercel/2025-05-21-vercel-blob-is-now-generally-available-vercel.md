---
title: "Vercel Blob is now generally available - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-blob-is-now-generally-available"
date: "2025-05-21"
scraped_at: "2026-03-02T09:33:21.636561364+00:00"
language: "en-zh"
translated: true
description: "Vercel Blob is now generally available, bringing high-performance storage integrated with the Vercel application delivery platform."
---

render_with_liquid: false
May 21, 2025

2025年5月21日

![](images/vercel-blob-is-now-generally-available-vercel/img_001.jpg)![](images/vercel-blob-is-now-generally-available-vercel/img_002.jpg)

Vercel Blob is now generally available, bringing high-performance, globally scalable object storage into your workflows and apps.

Vercel Blob 现已正式发布（GA），将高性能、全球可扩展的对象存储能力直接融入您的工作流与应用程序中。

Blob storage’s underlying S3 infrastructure ensures 99.999999999% durability, and already stores over 400 million files while powering production apps like [v0.dev](https://v0.dev/).

Blob 存储底层基于 S3 架构，具备高达 99.999999999% 的数据持久性；目前已存储超 4 亿个文件，并为 [v0.dev](https://v0.dev/) 等生产级应用提供存储支持。

Pricing is usage-based:

定价采用按用量计费模式：

- **Storage**: $0.023 per GB per month  
- **存储**：0.023 美元/GB/月  

- **Simple API operations (e.g. Reads)**: $0.40 per million  
- **基础 API 操作（例如读取）**：0.40 美元/百万次  

- **Advanced operations (e.g. Uploads)**: $5.00 per million  
- **高级操作（例如上传）**：5.00 美元/百万次  

- **Blob Data Transfer**: starting at $0.050 per GB  
- **Blob 数据传输**：低至 0.050 美元/GB  

Pricing applies to:  
定价适用于：

- New Blob stores starting today  
- 今日起，新创建的 Blob 存储正式上线  

- Existing stores starting June 16, 2025  
- 现有存储将于 2025 年 6 月 16 日起启用新功能  

Storage and operation pricing **match S3**, and Blob Data Transfer is a new mechanism for direct object access that's up to **3x less expensive** than Fast Data Transfer and integrates directly with Vercel’s global caching layer.  
存储与操作定价**与 Amazon S3 一致**；Blob 数据传输（Blob Data Transfer）是一种全新的直接对象访问机制，其费用最高可比快速数据传输（Fast Data Transfer）低 **3 倍**，并原生集成 Vercel 全球缓存层。

Hobby users now get increased free usage: 1 GB of storage and 10 GB of Blob Data Transfer per month.  
Hobby 用户现享更高的免费额度：每月 1 GB 存储空间及 10 GB Blob 数据传输流量。

[Get started with Vercel Blob](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fstores&title=Get+started+with+Vercel+Blob) and learn more in the [documentation](https://vercel.com/docs/vercel-blob).  
[立即开始使用 Vercel Blob](https://vercel.com/d?to=%2F%5Bteam%5D%2F%7E%2Fstores&title=Get+started+with+Vercel+Blob)，或在[文档](https://vercel.com/docs/vercel-blob)中了解更多信息。