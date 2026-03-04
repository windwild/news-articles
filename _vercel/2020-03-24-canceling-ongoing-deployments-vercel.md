---
title: "Canceling Ongoing Deployments - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/canceling-ongoing-deployments"
date: "2020-03-24"
scraped_at: "2026-03-02T10:07:11.774711848+00:00"
language: "en-zh"
translated: true
description: "Preventing ongoing deployments from building is now simply a matter of clicking a button."
---
&#123;% raw %}

Mar 24, 2020

2020 年 3 月 24 日

有时，你可能会发现自己创建了一个不再需要的部署，或者该部署正导致其他部署在队列中等待。

此前，你必须等待此类部署完成，然后才能将其删除。但从今天起，如果某个部署已不再需要，你可以立即 **取消该部署**。

## A New Cancel Button

## 新增“取消”按钮

为防止部署继续构建，你现在可在部署构建过程中，于控制台（Dashboard）上点击新添加的“取消”（Cancel）按钮：

![Canceling an ongoing deployment from the dashboard.](images/canceling-ongoing-deployments-vercel/img_001.jpg)从控制台取消正在进行的部署。

一旦你取消了该部署，排在其后的所有待部署任务将立即开始构建。

## Preventing Deployments from Getting Queued

## 防止部署进入队列

如果你正在非常快速地创建新部署，那么最新创建的部署可能会被排队，直至最早创建的部署完成构建。

取消其中部分部署，可使其余部署提前开始构建。但更优的解决方案是：在团队的“账单”（Billing）设置页面中，提高 **并发构建数（Concurrent Builds）** 的配额：

![Increasing the amount of Concurrent Builds.](images/canceling-ongoing-deployments-vercel/img_002.jpg)  
![增加并发构建数量。](images/canceling-ongoing-deployments-vercel/img_002.jpg)  
Increasing the amount of Concurrent Builds.  
增加并发构建数量。

Please note that the **Concurrent Builds** feature is only available to teams.  
请注意，**并发构建（Concurrent Builds）** 功能仅面向团队用户开放。

## Conclusion

## 结论

Preventing ongoing deployments from building is now simply a matter of clicking a button.  
阻止正在进行的部署继续构建，现在只需单击一个按钮即可完成。

For teams that would like to increase the amount of deployments they can build at the same time, however, we recommend increasing the amount of Concurrent Builds.  
然而，对于希望同时构建更多部署的团队，我们建议增加并发构建数量。

[Let us know what you think](https://zeit.co/contact) about this change.  
[欢迎告诉我们您对这一变更的看法](https://zeit.co/contact)。
&#123;% endraw %}
