---
render_with_liquid: false
title: "Protecting your app (and wallet) against malicious traffic - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/protecting-your-app-and-wallet-against-malicious-traffic"
date: "2024-08-02"
scraped_at: "2026-03-02T09:42:28.549004689+00:00"
language: "en-zh"
translated: true
description: "Learn how to block traffic with the Firewall, set up soft and hard spend limits, apply code-level optimizations, and more."
---
render_with_liquid: false
render_with_liquid: false

Aug 2, 2024

2024年8月2日

Let's explore how to block traffic with the Firewall, set up soft and hard spend limits, apply code-level optimizations, and more to protect your app against bad actors.

让我们探索如何利用防火墙拦截流量、设置软性与硬性消费限额、实施代码级优化，以及更多措施，以保护您的应用免受恶意行为者的攻击。

_If you’re on our free tier, you don’t need to worry. When your app passes the included free usage, it is automatically paused and never charged._

_若您使用的是我们的免费套餐，则无需担忧。当您的应用超出所含的免费用量时，系统将自动暂停服务，且绝不会产生任何费用。_

## Configurable Firewall rules

## 可配置的防火墙规则

You can create [custom Firewall rules](https://vercel.com/docs/security/vercel-waf) to log, block, or challenge traffic to your app. Custom rules are available on all plans for no additional charge.

您可创建[自定义防火墙规则](https://vercel.com/docs/security/vercel-waf)，用于记录、拦截或质询发往您应用的流量。所有套餐均免费提供自定义规则功能。

Rules can be based on 15+ fields including request path, user agent, IP address, JA4 fingerprint, geolocation, HTTP headers, and even target path.

规则可基于 15 种以上字段构建，包括请求路径（request path）、用户代理（user agent）、IP 地址、JA4 指纹、地理位置（geolocation）、HTTP 请求头（HTTP headers），甚至目标路径（target path）等。

### Blocking traffic based on IP address

### 基于 IP 地址拦截流量

For example, let’s say you notice some strange traffic from a single IP:

例如，假设您发现某单一 IP 地址发来了异常流量：

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_001.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_002.jpg)

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_001.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_002.jpg)

You can create a custom rule to deny traffic from this IP address:

您可以创建一条自定义规则，拒绝来自该 IP 地址的所有流量：

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_003.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_004.jpg)

### Blocking traffic based on JA4 fingerprints

### 基于 JA4 指纹屏蔽流量

What if you notice an unfamiliar traffic pattern from multiple IP addresses?

如果多个 IP 地址突然出现异常的流量模式，你该如何应对？

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_005.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_006.jpg)

Filtering the Firewall data by JA4 allows you to see fingerprints of traffic data. This is more advanced than looking at just the IP address, user agent, or geolocation. Instead, we can compute a unique fingerprint for traffic that is difficult to circumvent.

通过 JA4 对防火墙数据进行筛选，可直观呈现流量数据的指纹特征。相比仅依赖 IP 地址、用户代理（User Agent）或地理位置等传统维度，JA4 指纹技术更为先进——它能为每类流量生成难以伪造和绕过的唯一标识。

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_007.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_008.jpg)

Using [JA4 fingerprints](https://vercel.com/docs/security/tls-fingerprints#ja4) means a higher probability of detecting (and blocking) bad actors. This advanced fingerprinting is available on all Vercel plans for free.

使用 [JA4 指纹](https://vercel.com/docs/security/tls-fingerprints#ja4) 可显著提升识别（并拦截）恶意行为者的概率。这项高级指纹识别能力在所有 Vercel 套餐中均免费提供。

### Challenging suspicious traffic with Attack Challenge Mode

### 使用攻击挑战模式（Attack Challenge Mode）应对可疑流量

Let’s say you get a usage notification from Vercel that your application is seeing more traffic than normal. It might not be obvious at first what the issue is, and you want to ensure only real customers are allowed into your app.

假设你收到 Vercel 发送的用量通知，提示你的应用当前流量远超正常水平。起初你可能难以判断问题根源，同时你希望确保只有真实用户才能访问你的应用。

With the Firewall, you can turn on [Attack Challenge Mode](https://vercel.com/docs/security/attack-challenge-mode).

借助防火墙功能，你可以启用 [攻击挑战模式（Attack Challenge Mode）](https://vercel.com/docs/security/attack-challenge-mode)。

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_009.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_010.jpg)

This serves up a “challenge” screen to all visitors temporarily while you investigate the rise in usage. Real visitors will automatically complete a browser challenge in the background before proceeding to the app. Malicious traffic likely will not pass the challenge.

当您调查流量激增原因时，该机制会暂时向所有访问者展示一个“验证挑战”页面。真实用户将在后台自动完成浏览器验证挑战，随后正常进入应用；而恶意流量则很可能无法通过该验证。

You can also define custom rules to challenge traffic at a more granular level.

您还可以定义自定义规则，对流量实施更细粒度的验证挑战。

## Real-time usage and spend controls

## 实时用量与消费管控

Serverless shouldn’t mean unlimited usage. Only you know what’s right for your application and your business. To help avoid unexpected bills, you can define a spend limit to get alerted, or automatically pause your app when that amount is reached.

无服务器（Serverless）并不意味着用量无上限。只有您最清楚自己的应用和业务所需的合理用量范围。为避免产生意外账单，您可以设置消费限额：当达到该限额时，系统将向您发送告警，或自动暂停您的应用。

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_011.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_012.jpg)

To quickly take action on traffic patterns, you need to understand your usage in real-time. That’s why we provide a powerful usage page to help you understand your traffic at a glance, as well as a more powerful query engine for advanced usage investigation with [Monitoring](https://vercel.com/docs/observability/monitoring).

要快速响应流量模式变化，您需要实时掌握自身用量情况。正因如此，我们提供了功能强大的用量概览页面，助您一目了然地了解当前流量状况；同时，还集成了更强大的查询引擎，支持借助 [Monitoring（监控）](https://vercel.com/docs/observability/monitoring) 进行深度用量分析。

![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_013.jpg)![](images/protecting-your-app-and-wallet-against-malicious-traffic-vercel/img_014.jpg)

## Code optimizations

## 代码优化

You can also proactively configure your application to [optimize usage](https://vercel.com/docs/pricing/manage-and-optimize-usage). For example, the following areas for optimization are places we commonly see customers reference.

您还可以主动配置应用以[优化用量](https://vercel.com/docs/pricing/manage-and-optimize-usage)。例如，以下几类优化方向，是客户在实践中经常参考的重点领域。

### Enable Fluid compute

### 启用 Fluid 计算

We strongly recommend enabling Fluid compute, which is a more cost-effective model for Vercel Functions. This can **save up to 85% of your function usage** for applications with many concurrent requests.

我们强烈建议启用 Fluid 计算，这是一种针对 Vercel Functions 更具成本效益的计费模式。对于拥有大量并发请求的应用，此举**最多可节省 85% 的函数用量**。

[Learn more about Fluid](https://vercel.com/blog/introducing-fluid-compute) and how to enable in your project.

[了解更多关于 Fluid 的信息](https://vercel.com/blog/introducing-fluid-compute)，以及如何在您的项目中启用它。

### Enable transformation based Image Optimization

### 启用基于转换的图像优化

Vercel’s infrastructure has the ability to optimized images on-demand. This works with [frameworks](https://vercel.com/docs/frameworks#frameworks-infrastructure-support-matrix) like Next.js, SvelteKit, Nuxt, Astro, and Gatsby.

Vercel 的基础设施支持按需优化图像。该功能与 [Next.js、SvelteKit、Nuxt、Astro 和 Gatsby 等框架](https://vercel.com/docs/frameworks#frameworks-infrastructure-support-matrix) 兼容。

The value you pass to the `src` of your image will produce _multiple_ optimized images based on the viewport and device of the visitor. Previously, Vercel's Image Optimization was billed based on the number of unique source images.

您为图像 `src` 属性指定的源地址，将根据访问者的视口尺寸和设备类型，自动生成 _多个_ 优化后的图像版本。此前，Vercel 的图像优化服务按唯一源图像的数量计费。

Based on your feedback, we recently changed that to [bill on the number of transformations](https://vercel.com/changelog/faster-transformations-and-reduced-pricing-for-image-optimization), which a lowered price. We recommend enabling this new option. Learn more about [managing costs](https://vercel.com/docs/image-optimization/managing-image-optimization-costs).

根据您的反馈，我们近期已将其调整为按[图像转换次数计费](https://vercel.com/changelog/faster-transformations-and-reduced-pricing-for-image-optimization)，从而降低了价格。我们建议您启用这一新选项。了解更多关于[成本管理](https://vercel.com/docs/image-optimization/managing-image-optimization-costs)的信息。

This service is optional — you can also optimize your images before uploading them to your CMS or database, and then use the `unoptimized` prop when using frameworks like Next.js (as the source is already compressed).

该服务为可选功能——您也可在将图像上传至 CMS 或数据库前自行完成优化，之后在使用 Next.js 等框架时，通过设置 `unoptimized` 属性（因源图像已压缩）跳过 Vercel 的优化流程。

### -to-blob-storage) Move large media files (like images or videos) to Blob storage

### -to-blob-storage) 将大型媒体文件（如图片或视频）迁移至 Blob 存储

When investigating your usage, if you see that your top sources of Fast Data Transfer are large image or video files, you might consider moving these assets to blob storage. [Vercel Blob](https://vercel.com/docs/storage/vercel-blob) is a cost-effective object storage service for these static assets.

在分析您的用量时，若发现“快速数据传输”用量的主要来源是大型图片或视频文件，您可考虑将这些资源迁移至 Blob 存储。[Vercel Blob](https://vercel.com/docs/storage/vercel-blob) 是一种面向此类静态资源的高性价比对象存储服务。

You can also investigate your usage with [Vercel Observability](https://vercel.com/docs/observability) to better understand the source.

您还可以通过 [Vercel 可观测性（Observability）](https://vercel.com/docs/observability) 来分析您的使用情况，从而更深入地了解流量来源。

## Protecting your deployments from unauthorized traffic

## 保护您的部署免受未授权流量访问

Vercel creates a unique deployment for every commit you push to your repository.

Vercel 会为推送到代码仓库的每一次提交创建一个独立的部署。

This makes it easy to preview and test changes, as well as instantly rollback to older versions if something goes wrong.

这使得预览和测试变更变得十分便捷；一旦出现问题，您还可立即回滚至旧版本。

For most of your applications, you likely only want your current production deployment to be publicly accessible. In November 2023, we updated the defaults for deployment protection to be [turned on by default](https://vercel.com/changelog/deployment-protection-is-now-enabled-by-default-for-new-projects). If you joined Vercel after this time, congratulations, your work here is done.

对大多数应用而言，您可能仅希望当前生产环境的部署对外公开。2023 年 11 月，我们将部署保护（Deployment Protection）的默认设置更新为 [默认启用](https://vercel.com/changelog/deployment-protection-is-now-enabled-by-default-for-new-projects)。若您在此之后加入 Vercel，恭喜您——此项配置已自动完成。

For those of you who have been on Vercel for longer, it might be worth revisiting your deployment protection settings to ensure access to your deployments are locked down to those on your Vercel team. We’re soon shipping an improvement to highlight this in the Vercel dashboard.

对于较早加入 Vercel 的用户，建议重新检查您的部署保护设置，确保仅允许 Vercel 团队成员访问您的部署。我们即将在 Vercel 控制台中上线一项改进功能，以更醒目地提示该设置。

## Secure by default

## 默认安全（Secure by Default）

Our goal is to make applications on Vercel [secure by default](https://vercel.com/resources/iterating-towards-secure-by-default). The only traffic that makes it to your app (and to your bill) is traffic you’re excited to welcome.

我们的目标是让部署在 Vercel 上的应用程序实现 [默认安全（Secure by Default）](https://vercel.com/resources/iterating-towards-secure-by-default)。只有您乐于接纳的流量，才会抵达您的应用（并计入您的账单）。

Vercel keeps you protected from large attacks on your apps automatically. We block an average of 1 billion suspicious connections per week. This malicious traffic never makes it past our Firewall to your wallet.

Vercel 会自动为您抵御针对应用的大规模攻击。我们平均每周拦截约 10 亿次可疑连接。此类恶意流量在到达您的应用或账单前，即被我们的防火墙（Firewall）彻底阻断。

While we continuously strengthen our defense against bad actors, your applications have different levels of tolerance for traffic patterns. A spike of ten thousand new requests might be a normal day for you, or it might be something wrong.

尽管我们持续强化对恶意行为者的防御能力，但您的不同应用对流量模式的容忍度各不相同。一天内新增一万个请求，对您而言或许是常态，也可能意味着异常。

That’s why we also provide configurable Firewall rules, usage notifications, SMS notifications, spend limits, and more.  

因此，我们还提供了可配置的防火墙规则、用量通知、短信通知、消费限额等功能。

Hopefully you now have a better understanding of how to keep your application protected on Vercel and prevent unwanted usage.  

希望您现在对如何在 Vercel 上保护您的应用以及防止非预期调用有了更清晰的认识。