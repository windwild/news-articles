---
title: "Building a viral application for your personal music festival - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/from-idea-to-100-million-views-instafest-music-festival-application"
date: "2022-12-12"
scraped_at: "2026-03-02T09:57:42.941639974+00:00"
language: "en-zh"
translated: true
description: "Learn how Anshay Saboo, a Computer Science student at USC, used Next.js and Vercel to launch Instafest fast and scale to 500,000 new users per hour."
---
{% raw %}

Dec 12, 2022

2022年12月12日

[Instafest](https://www.instafest.app/) 允许用户快速基于自己在 Spotify、Apple Music 和 Last.fm 上最常听的艺术家，生成专属音乐节海报。南加州大学（USC）计算机科学专业学生 [Anshay Saboo](https://twitter.com/AnshaySaboo) 借助 Next.js 和 Vercel 快速上线 Instafest，并成功扩展至**每小时新增 50 万名用户**，累计吸引数百万用户，在 Twitter、TikTok 等平台迅速走红。

> “我从未预料到 Instafest 的增长速度会如此之快。Vercel 和 Next.js 轻松应对海量并发的能力，令我难以置信。我从未预料到 Instafest 的增长速度会如此之快。Vercel 和 Next.js 轻松应对海量并发的能力，令我难以置信。”
>
> ![](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_001.jpg)
>
> **Anshay Saboo**，Instafest 创始人

## Instafest 的发布历程

Instafest 于 2022 年 11 月 22 日正式上线。首日规模尚小，每小时仅约 100–150 名用户；但此后增长迅猛：次日达每小时 500 名用户，第三日升至每小时 2,000 名；至随后一个周日，应用已实现**每小时新增 7 万名用户**。

![使用 Vercel 监控功能可视化 Instafest 在病毒式传播高峰期的流量情况。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_002.jpg)![使用 Vercel 监控功能可视化 Instafest 在病毒式传播高峰期的流量情况。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_003.jpg)使用 Vercel 监控功能可视化 Instafest 在病毒式传播高峰期的流量情况。

网站持续升温，每日均新增功能。在 Questlove、说唱歌手 24KGoldn、导演 Edgar Wright 及 YouTube 创作者 Matt King 等名人于社交媒体分享后，热度进一步攀升。巅峰时期，Instafest 每小时新增用户达 50 万，当周页面浏览量突破 1 亿次。

## 使用 Next.js 构建高性能 React 网站

Anshay 明确希望采用 React 技术栈，因此选择了 [Next.js](https://vercel.com/docs/concepts/next.js/overview)，以“确保应用响应迅速、交互流畅”。Instafest 网站需支持自定义网页字体加载，并快速呈现音乐节海报图像。借助 Next.js，Anshay 利用其[内置字体优化功能](https://nextjs.org/docs/basic-features/font-optimization)与[图片组件](https://nextjs.org/docs/basic-features/image-optimization)，显著提升了网站性能，并有效避免了布局偏移（layout shift）。

通过使用图片组件，Next.js 自动对图片进行优化，并以现代格式（如 `.avif` 和 `.webp`）提供服务，从而减小图片体积，加快页面加载速度，为 Instafest 用户带来更佳体验。此外，Next.js 还自动为每张图片生成响应式版本——即针对不同屏幕尺寸生成多种尺寸的图片副本。这使得 Instafest 能够为每位用户的设备精准匹配最合适的图片尺寸，进一步提升整体性能。

## Deploying Next.js with Vercel

## 使用 Vercel 部署 Next.js

Anshay needed to quickly get his Next.js site online fast, so he turned to Vercel to go from idea to global application in seconds.

Anshay 需要快速将他的 Next.js 网站上线，因此他选择使用 Vercel，仅用数秒便将创意变为面向全球的应用程序。

> “Vercel was the key to Instafest’s successful launch. Being able to easy deploy code, as well as instantly rollback when things went wrong, was crucial.Vercel was the key to Instafest’s successful launch. Being able to easy deploy code, as well as instantly rollback when things went wrong, was crucial.”
>
> ![](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_001.jpg)
>
> **Anshay Saboo,** Creator of Instafest

> “Vercel 是 Instafest 成功发布的关键。轻松部署代码，以及在出现问题时即时回滚的能力，至关重要。”  
>   
> ![](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_001.jpg)  
>   
> **Anshay Saboo**，Instafest 创作者

Thanks to Vercel Functions, the Next.js application was able to scale automatically, without needing to provision additional servers, add load balancers, or pay for more expensive hardware. Instafest was highly available, everywhere around the world, visualized below with [Vercel Monitoring](https://vercel.com/docs/concepts/dashboard-features/monitoring) broken down by Edge Network regions.

得益于 Vercel Functions，该 Next.js 应用实现了自动扩缩容，无需额外配置服务器、添加负载均衡器，也无需为更昂贵的硬件付费。Instafest 在全球范围内始终保持高可用性；下图通过 [Vercel Monitoring](https://vercel.com/docs/concepts/dashboard-features/monitoring)（按边缘网络区域划分）直观呈现了这一特性。

![Using Vercel Monitoring to visualize traffic segmented by Edge Network region.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_005.jpg)![Using Vercel Monitoring to visualize traffic segmented by Edge Network region.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_006.jpg)Using Vercel Monitoring to visualize traffic segmented by Edge Network region.

![使用 Vercel Monitoring 按边缘网络区域划分并可视化流量分布。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_005.jpg)![使用 Vercel Monitoring 按边缘网络区域划分并可视化流量分布。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_006.jpg)使用 Vercel Monitoring 按边缘网络区域划分并可视化流量分布。

Instead, Anshay was able to take advantage of Vercel’s global Edge Network to easily cache both static assets and Function responses. Peaking at 6 million users per day, Instafest never had downtime or showed any increase in latency under load. Using [Vercel Analytics](http://vercel.com/analytics), Anshay could visualize the real user performance of Instafest visitors.

相反，Anshay 充分利用了 Vercel 的全球边缘网络（Edge Network），轻松缓存静态资源和函数响应。Instafest 日活跃用户峰值达 600 万，全程零宕机，且在高负载下未出现任何延迟升高现象。借助 [Vercel Analytics](http://vercel.com/analytics)，Anshay 能够直观呈现 Instafest 访客的真实用户体验性能。

![Using Vercel Analytics to visualize application performance from Core Web Vitals field data.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_007.jpg)![Using Vercel Analytics to visualize application performance from Core Web Vitals field data.](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_008.jpg)Using Vercel Analytics to visualize application performance from Core Web Vitals field data.

![使用 Vercel Analytics 基于核心网页指标（Core Web Vitals）实地数据可视化应用性能。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_007.jpg)![使用 Vercel Analytics 基于核心网页指标（Core Web Vitals）实地数据可视化应用性能。](images/building-a-viral-application-for-your-personal-music-festival-vercel/img_008.jpg)使用 Vercel Analytics 基于核心网页指标（Core Web Vitals）实地数据可视化应用性能。

Learn more about [Next.js on Vercel](https://vercel.com/docs/concepts/next.js/overview) or get started today using one of our [Next.js templates](http://vercel.com/templates/next.js).

了解更多关于 [Vercel 上的 Next.js](https://vercel.com/docs/concepts/next.js/overview)，或立即选用我们的任一 [Next.js 模板](http://vercel.com/templates/next.js) 开始构建。
{% endraw %}
