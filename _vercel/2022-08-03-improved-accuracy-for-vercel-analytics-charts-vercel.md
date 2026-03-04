---
title: "Improved accuracy for Vercel Analytics charts - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/improved-accuracy-for-vercel-analytics-charts"
date: "2022-08-03"
scraped_at: "2026-03-02T10:01:20.697563672+00:00"
language: "en-zh"
translated: true
description: "The best way to deploy your Next.js site."
---
&#123;% raw %}

Aug 3, 2022

2022年8月3日

![](images/improved-accuracy-for-vercel-analytics-charts-vercel/img_001.jpg)![](images/improved-accuracy-for-vercel-analytics-charts-vercel/img_002.jpg)

It's now easier to visualize performance trends over time with Vercel Analytics.

借助 Vercel Analytics，现在可以更轻松地随时间推移可视化性能趋势。

Individual Core Web Vital data points are now displayed as a scatter plot with a trend line showing the estimation curve. This line is shown when there are more than 100 data points for the currently selected date and time window. The performance delta is calculated based on the estimation curve instead of the first and last data points for improved accuracy.

各个核心网页指标（Core Web Vital）数据点现以散点图形式呈现，并叠加一条显示估算曲线的趋势线。当当前所选日期与时间窗口内的数据点超过 100 个时，即显示该趋势线。为提升准确性，性能差值（performance delta）的计算依据改为该估算曲线，而非仅依赖首尾两个数据点。

[Check out the documentation](https://vercel.com/docs/concepts/analytics) to learn more.

[查看文档](https://vercel.com/docs/concepts/analytics) 了解更多信息。
&#123;% endraw %}
