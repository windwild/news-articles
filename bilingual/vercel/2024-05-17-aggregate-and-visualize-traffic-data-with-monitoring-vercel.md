---
title: "Aggregate and visualize traffic data with Monitoring - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/aggregate-and-visualize-traffic-data-with-monitoring"
date: "2024-05-17"
scraped_at: "2026-03-02T09:44:45.713559323+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---

May 17, 2024

2024 年 5 月 17 日

![](images/aggregate-and-visualize-traffic-data-with-monitoring-vercel/img_001.jpg)![](images/aggregate-and-visualize-traffic-data-with-monitoring-vercel/img_002.jpg)

You can now select an aggregation when analyzing data in Vercel Monitoring. This change provides more visibility to make it easier to analyze your application.

现在，您可在 Vercel Monitoring 中分析数据时选择聚合方式。这一更新提升了数据可见性，使您的应用分析更加便捷。

The following new aggregations are now available, in addition to sums and counts.

除原有的求和（sum）与计数（count）外，以下新增聚合方式现已上线：

- **Average** values  
- **平均值**

- **Per second** sums and counts  
- **每秒**求和与计数

- **Minimum** and **maximum** values  
- **最小值**与**最大值**

- **75th, 90th, 95th and 99th percentiles**  
- **第 75、90、95 和 99 百分位数**

- **Percentages** of the overall values  
- 整体数值的**百分比**

These aggregations can be used with any visualize setting, for analyzing **data transfer**, **function duration**, **function execution**, and **request counts**. Enterprise customers can also access data with a **five minute granularity** when viewing 24 hours of data or less.

上述所有聚合方式均可与任意可视化设置配合使用，支持对**数据传输量（data transfer）**、**函数执行时长（function duration）**、**函数调用次数（function execution）**以及**请求次数（request counts）**进行分析。企业版客户在查看不超过 24 小时的数据时，还可获得**五分钟粒度**的数据。

Learn more in [our documentation](https://vercel.com/docs/observability/monitoring/monitoring-reference#aggregations) about Monitoring.

有关监控的更多信息，请参阅[我们的文档](https://vercel.com/docs/observability/monitoring/monitoring-reference#aggregations)。