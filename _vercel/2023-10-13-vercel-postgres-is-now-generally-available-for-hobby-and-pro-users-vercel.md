---
title: "Vercel Postgres is now generally available for Hobby and Pro users - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/vercel-postgres-is-now-available-for-pro-users"
date: "2023-10-13"
scraped_at: "2026-03-02T09:49:58.688234291+00:00"
language: "en-zh"
translated: true
description: "Changelog for (now deprecated) Vercel postgres, our serverless SQL database, general availability for hobby and pro users"
---
{% raw %}

Oct 13, 2023

2023年10月13日

![](images/vercel-postgres-is-now-generally-available-for-hobby-and-pro-users-vercel/img_001.jpg)![](images/vercel-postgres-is-now-generally-available-for-hobby-and-pro-users-vercel/img_002.jpg)

Vercel KV 和 Vercel Postgres 服务已正式停用。您现在可通过 [Vercel Marketplace Storage](https://vercel.com/marketplace/category/storage) 部署 KV 和 Postgres 的替代存储方案（参见 [KV](https://vercel.com/marketplace?search=kv) 和 [Postgres](https://vercel.com/marketplace?search=postgres)），享受自动账户开通与统一账单管理。

[Vercel Postgres](https://vercel.com/docs/storage/vercel-postgres/quickstart)（我们的无服务器 SQL 数据库）现已面向 Hobby（入门版）和 Pro（专业版）用户全面开放。

在公测（beta）阶段，我们将冷启动时间缩短至 100–200 毫秒，并修复了多个连接处理相关的问题。同时，使用费用也已 **较公测期进一步下调**：

- 总存储容量费用：  
**从 $0.30/GB 降低 60%，至 $0.12/GB**

- 写入数据费用：  
**从 $0.10/GB 降低 4%，至 $0.096/GB**

- 数据传输费用：  
**从 $0.20/GB 降低 55%，至 $0.09/GB**

**Billing will begin on October 19th**  
**计费将于 10 月 19 日开始**

and Pro users have the following usage included:  
Pro 用户享有以下包含用量：

- 1 database then $1.00 USD per additional database  
- 1 个数据库，之后每增加一个数据库收费 1.00 美元

- 100 hours of compute time per month then $0.10 USD per additional compute-hour  
- 每月 100 小时计算时间，之后每增加一小时计算时间收费 0.10 美元

- 512 MB total storage then $0.12 USD per additional GB  
- 总存储空间 512 MB，之后每增加 1 GB 收费 0.12 美元

- 512 MB written data per month then $0.096 USD per additional GB  
- 每月写入数据量 512 MB，之后每增加 1 GB 收费 0.096 美元

- 512 MB data transfer per month then $0.09 USD per additional GB  
- 每月数据传输量 512 MB，之后每增加 1 GB 收费 0.09 美元

If you were a beta participant and want to opt out of using Vercel Postgres, you can backup your database and [delete it](https://vercel.com/docs/storage/vercel-postgres/usage-and-pricing#managing-charges).  
如果您曾是 Beta 测试参与者，且希望退出使用 Vercel Postgres，您可以先备份数据库，然后[将其删除](https://vercel.com/docs/storage/vercel-postgres/usage-and-pricing#managing-charges)。

[Check out the documentation](https://vercel.com/docs/storage/vercel-postgres) to learn more.  
[查阅文档](https://vercel.com/docs/storage/vercel-postgres)了解更多信息。
{% endraw %}
