---
title: "How Core Web Vitals & Lighthouse scores affect SEO Rankings - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/how-core-web-vitals-affect-seo"
date: "2024-01-19"
scraped_at: "2026-03-02T09:48:55.004376936+00:00"
language: "en-zh"
translated: true
description: "Understand your application's Google page experience ranking and Lighthouse scores. We'll dive into what they are, how they’re measured, and how your users and search ranking are impacted by them."
---
&#123;% raw %}

Jan 19, 2024

2024 年 1 月 19 日

理解您的应用在 Google 页面体验排名及 Lighthouse 评分中的表现。

核心网页指标（Core Web Vitals）会影响您的应用页面在 Google 搜索结果中的排名。本文将深入探讨这些指标的定义、测量方式，以及它们对用户体验和搜索排名的具体影响。

Malte Ubl 是 Vercel 的首席技术官（CTO），也曾担任 Google 搜索部门总监，主导推出了“页面体验”（Page Experience）排名机制——该机制高度依赖核心网页指标（Core Web Vitals）。需要说明的是，本文所述内容均源自公开文档，并在适当位置附有官方链接。

[**需要优化您的各项指标吗？**  
采用 Next.js 或 Vercel 业界领先的一站式托管基础设施，是提升核心网页指标（Core Web Vitals）的绝佳途径。  

## Google 如何基于页面加载速度进行排名

您网站在 Google 搜索结果中的排名，会受到 Google “页面体验”（page experience）排名体系的影响；该体系依据 Google 提出的 [核心网页指标（Core Web Vitals）](https://developers.google.com/search/docs/appearance/core-web-vitals) 对网站性能进行评估。

Google 通过监测真实用户与您网站的交互行为，将相关数据回传至其服务器，从而收集核心网页指标（具体采集机制详见下文）。

我们将这类源自真实用户浏览行为的数据称为 **现场数据（field data）**；这与 **实验室数据（lab data）** 截然不同——后者是在受控的“实验室环境”中运行测试所得，用于评估网站性能表现。Google 的 Lighthouse 工具即为典型的实验室测试工具。

或许本文最重要的核心观点在于：

> “Google 仅在对您的网站进行排名时考虑核心网页指标（Core Web Vitals）的真实用户数据（field data）。Google 在搜索排名中**完全不考虑**您的 Lighthouse 分数。Google 仅在对您的网站进行排名时考虑核心网页指标（Core Web Vitals）的真实用户数据（field data）。Google 在搜索排名中**完全不考虑**您的 Lighthouse 分数。”

> ![](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_001.jpg)

### 搜索排名影响因素的背景解读

### 搜索排名影响因素的背景解读

[页面体验（Page experience）](https://developers.google.com/search/docs/appearance/page-experience) 是 Google 搜索中的一项排名因素，它利用核心网页指标（Core Web Vitals）来评估您的网站相较于其他网站的实际表现。页面体验只是 Google 搜索众多排名因素之一，所有这些因素会综合加权，共同决定您的网站在搜索结果页中的最终排名。

与搜索词的相关性（query relevancy）以及[内容质量（content quality）](https://vercel.com/blog/nextjs-seo-playbook#content-strategies) 远比页面体验重要得多。然而，在您与竞争对手的相关性高度接近的情况下，页面体验可能成为决定谁排名更高的关键因素。

页面体验与核心网页指标的独特之处在于：

- 您可以通过自身努力切实提升这些指标；  
- Google 对您的表现情况保持高度透明。

核心网页指标远不像其他排名因素那样是一个“黑箱”。优化它们所需的经验性猜测（“guesswork”）远少于提升相关性，也比评估内容质量更易于量化和测量。

此外，改善核心网页指标还能直接提升用户体验，而[良好的用户体验可推动转化率提升](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud#why-do-you-need-speed)。

### 如何查看您应用的核心网页指标

### 如何查看您应用的核心网页指标

The authoritative data source for how well your entire app performs for page experience rankings is [Google Search Console](https://search.google.com/search-console).

衡量您的整个应用在页面体验排名中表现如何的权威数据来源是 [Google 搜索中心](https://search.google.com/search-console)。

![The Core Web Vitals page of Google Search Console.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_002.jpg)  
![Google 搜索中心的“核心网页指标”页面。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_002.jpg)  
The Core Web Vitals page of Google Search Console.  
Google 搜索中心的“核心网页指标”页面。

A simple way to access per-page data is Google’s [PageSpeed Insights](https://pagespeed.web.dev/), which is grouped into two main sections: Core Web Vitals and Lighthouse.

一种便捷获取单页数据的方式是 Google 提供的 [PageSpeed Insights](https://pagespeed.web.dev/)，其界面主要分为两大板块：“核心网页指标”（Core Web Vitals）和“Lighthouse”。

## Field data: Core Web Vitals

## 现场数据：核心网页指标

In the top section of PageSpeed Insights, labeled “Discover what your real users are experiencing,” Google collects global field data of the 75th percentile of actual users who have accessed your application in the last 28 days from Chrome browser (desktop and Android mobile devices).

在 PageSpeed Insights 的顶部区域（标题为“了解真实用户的真实体验”），Google 汇总了全球范围内的现场数据——即过去 28 天内通过 Chrome 浏览器（包括桌面端和 Android 移动设备）访问您应用的实际用户中，表现位于第 75 百分位的数据。

Google uses the first three metrics of this real-world data—Largest Contentful Paint (LCP), Interaction to Next Paint (INP), and Cumulative Layout Shift (CLS)—to alter the rank of your application based on the scores. Note that as of March 12, 2024, [INP has replaced First Input Delay (FID)](https://developers.google.com/search/blog/2023/05/introducing-inp).

Google 利用该真实世界数据中的前三项指标——最大内容绘制（Largest Contentful Paint, LCP）、下一次绘制前的交互时间（Interaction to Next Paint, INP）以及累积布局偏移（Cumulative Layout Shift, CLS）——根据其得分调整您应用在搜索结果中的排名。请注意，自 2024 年 3 月 12 日起，[INP 已正式取代首次输入延迟（First Input Delay, FID）](https://developers.google.com/search/blog/2023/05/introducing-inp)。

These three Core Web Vitals are the _only_ data Google uses to affect the rank of your app based on its web performance, and the scores seen here are exactly the numbers Google uses, albeit averaged into a group with [similarly-performing pages on your application](https://support.google.com/webmasters/answer/9205520).

这三项核心网页指标是 Google **唯一**用于依据网页性能影响您应用搜索排名的数据；此处显示的分数正是 Google 实际采用的数值，只不过它们会与您应用中[性能表现相近的其他页面](https://support.google.com/webmasters/answer/9205520)一同取平均值后参与计算。

You’ll also notice there are tabs for both desktop and mobile. This is because Google [ranks your application separately](https://developers.google.com/search/blog/2021/11/bringing-page-experience-to-desktop#:~:text=This%20means%20the,factor%20for%20desktop.) for mobile users vs. desktop users, based on the mobile and desktop versions of your site respectively.

您还会注意到界面中设有“桌面端”和“移动端”两个标签页。这是因为 Google 会[分别对移动端用户和桌面端用户进行排名](https://developers.google.com/search/blog/2021/11/bringing-page-experience-to-desktop#:~:text=This%20means%20the,factor%20for%20desktop.)——前者依据您网站的移动端版本，后者则依据桌面端版本。

![The mobile Core Web Vitals for google.com.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_003.jpg)![The mobile Core Web Vitals for google.com.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_004.jpg)  
![google.com 的移动端核心网页指标。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_003.jpg)![google.com 的移动端核心网页指标。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_004.jpg)  
The mobile Core Web Vitals for google.com.  
google.com 的移动端核心网页指标。

The three metrics beneath the Core Web Vitals can offer further insight into user experience, but do not impact the rank of your application in search.

“核心网页指标”下方列出的另外三项指标可进一步帮助您理解用户体验，但**不会影响**您应用在搜索结果中的排名。

### Which users are included in Core Web Vitals field data?

### 哪些用户被纳入核心网页指标（Core Web Vitals）的实地数据中？

The [Chrome User Experience Report (CrUX)](https://developer.chrome.com/docs/crux/) is the official dataset of Google’s Core Web Vitals program, and [its collection methodology](https://developer.chrome.com/docs/crux/methodology) is publicly documented. Notably, to be included in the report:

[Chrome 用户体验报告（CrUX）](https://developer.chrome.com/docs/crux/) 是 Google 核心网页指标（Core Web Vitals）计划的官方数据集，其[数据采集方法](https://developer.chrome.com/docs/crux/methodology)已公开记录。值得注意的是，要被纳入该报告，需满足以下条件：

- Pages must be “ [sufficiently popular](https://developer.chrome.com/docs/crux/methodology#popularity-eligibility)” and “ [publicly discoverable](https://developer.chrome.com/docs/crux/methodology#discoverability-eligibility).” Whether your pages meet popularity thresholds can be determined via the CWV report in Search Console.

- 页面必须“[足够热门](https://developer.chrome.com/docs/crux/methodology#popularity-eligibility)”且“[可被公众发现](https://developer.chrome.com/docs/crux/methodology#discoverability-eligibility)”。您的页面是否达到热门度门槛，可通过 Search Console 中的核心网页指标（CWV）报告进行判断。

- Users must enable [usage statistic reporting](https://support.google.com/chrome/answer/96817), [sync their browser history](https://support.google.com/chrome/answer/185277) (be signed in to Chrome), and not set a [Sync passphrase](https://support.google.com/chrome/answer/165139?co=GENIE.Platform%3DAndroid#zippy=%2Ccreate-a-passphrase).

- 用户必须启用[使用情况统计报告功能](https://support.google.com/chrome/answer/96817)，[同步浏览器历史记录](https://support.google.com/chrome/answer/185277)（即已登录 Chrome），且**未设置同步密语（Sync passphrase）**。

- Users must use Chrome on either desktop or Android.

- 用户必须在桌面端或 Android 设备上使用 Chrome 浏览器。

**This last bullet means that none of your iPhone users are counted.** This may be relevant insofar that in some markets Android phones skew slower than iPhones, and so a larger percentage of the slower visits to your site may be counted.

**最后一点意味着：您的 iPhone 用户完全不被计入统计。** 这一点可能尤为关键——因为在某些市场，Android 手机的整体性能通常低于 iPhone；因此，访问您网站的较慢连接用户中，有更大比例会被纳入统计。

If your application does not have enough real user data, then your Core Web Vitals cannot be measured and will not be considered in ranking your application.

如果您的应用缺乏足够的真实用户数据，则无法测量其核心网页指标（Core Web Vitals），这些指标也不会被用于对您应用的搜索排名评估。

### Does it matter where my users are coming from?

### 用户来源地是否会影响核心网页指标？

Another frequent question is: Does it matter where my users are coming from? Do I get penalized if I have lots of users in countries with slower internet connectivity?

另一个常见问题是：用户来自哪里是否重要？如果我在互联网连接较慢的国家拥有大量用户，是否会因此受到惩罚？

It _does_ matter where your users are coming from. The point of field data is that it reflects your real users, and all users from all global regions are counted equally.

用户来源地**确实重要**。实地数据（field data）的意义正在于真实反映您所有实际用户的体验，而来自全球各地的所有用户均被平等计入统计。

The good news is that internet connectivity and device performance have been improving worldwide, and with an edge network like Vercel’s, you can [deliver great performance to every user on the planet](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud).

好消息是，全球范围内的互联网连接质量与设备性能正在持续提升；借助 Vercel 这样的边缘网络，您便能[为地球上每一位用户交付卓越的性能体验](https://vercel.com/blog/the-user-experience-of-the-frontend-cloud)。

### Caveat: 28-day sliding window

### 注意事项：28 天滚动窗口

Google 收集核心网页指标（Core Web Vitals，CWV）数据采用的是 28 天滚动窗口机制。您的得分本质上是过去 28 天内各项指标得分的平均值。如果您进行了性能优化（或反之造成性能退化），需等待约一个月才能全面评估该操作的实际影响。

[参见下文](https://vercel.com/blog/how-core-web-vitals-affect-seo#a-quicker-way-to-iterate-on-core-web-vitals-vercel-speed-insights)，了解 Vercel 的 Speed Insights 如何帮助您更快获取更新后的 CWV 数据，从而实时响应性能变化，并防止搜索排名下降。

## Lab data: Lighthouse

## 实验室数据：Lighthouse

在 PageSpeed Insights 的第二部分（标注为“诊断性能问题”）中，Google 利用 Lighthouse 模拟您应用的性能表现——该工具与 Chrome DevTools 中内置的 Lighthouse 完全一致。

这一部分与上文所述的现场真实用户数据（field data）完全独立，其目的仅在于：当您的网站尚未满足 Google 针对真实用户设定的性能标准时，提供改进建议。

再次强调：**Lighthouse 中的任何评分均不计入您网站的搜索引擎排名。** 它仅提供可选的开发指导，帮助您规避 Web 应用开发中的常见陷阱。

![The mobile Lighthouse scores for google.com.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_005.jpg)![The mobile Lighthouse scores for google.com.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_006.jpg)The mobile Lighthouse scores for google.com.

![google.com 的移动端 Lighthouse 得分。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_005.jpg)![google.com 的移动端 Lighthouse 得分。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_006.jpg)google.com 的移动端 Lighthouse 得分。

The [Lighthouse performance score](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring/)—one of the most noticeable numbers on the page—is a weighted score of First Contentful Paint (FCP), [Speed Index](https://developer.chrome.com/en/docs/lighthouse/performance/speed-index/), LCP, Total Blocking Time (TBT), and CLS. Note that, after weighting, actual Core Web Vitals only represent 50% of this score, and INP is not accounted for.

[Lighthouse 性能得分](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring/)——页面上最醒目的数值之一——是首屏内容绘制（FCP）、[速度指数（Speed Index）](https://developer.chrome.com/en/docs/lighthouse/performance/speed-index/)、最大内容绘制（LCP）、总阻塞时间（TBT）和累积布局偏移（CLS）这五项指标的加权综合得分。需注意的是：经加权计算后，真实的核心网页指标（Core Web Vitals）仅占该总分的 50%，而交互延迟（INP）则未被纳入此评分体系。

Results here come from a device emulating a Moto G Power with a throttled network connection, which has specs that likely vary greatly from your actual users’ devices.

此处结果来自一台模拟 Moto G Power 设备的测试环境，并启用了受限网络连接；该设备的硬件规格很可能与您真实用户的设备存在显著差异。

This and other [challenges associated with lab data](https://web.dev/articles/lab-and-field-data-differences) (such as not accounting for what page a user may be coming from before navigating to the reported page), make Lighthouse scores not suitable as your only UX metric.

此类问题，以及其他与实验室数据相关的[挑战](https://web.dev/articles/lab-and-field-data-differences)（例如，未考虑用户在跳转至当前被测页面之前所处的上一页面），使得 Lighthouse 分数不适合作为您衡量用户体验的唯一指标。

For instance, Total Blocking Time (TBT) as a metric often does not reflect real user experience. This is because [modern frameworks like React interrupt execution](https://vercel.com/blog/how-react-18-improves-application-performance) if there is a user event—and hence deliver [good INP](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense)—but the lab test cannot know that when it is observing how much CPU is being used without real user interactions.

例如，总阻塞时间（Total Blocking Time, TBT）这一指标往往无法真实反映用户实际体验。这是因为像 React 这样的现代框架在检测到用户交互事件时会主动中断 JavaScript 执行——从而实现[良好的“交互至下一帧绘制”（Interaction to Next Paint, INP）表现](https://vercel.com/blog/improving-interaction-to-next-paint-with-react-18-and-suspense)；但实验室测试在观测 CPU 使用情况时，并无真实用户交互参与，因此无法识别这种中断行为。

### Interpreting your Lighthouse scores

### 解读您的 Lighthouse 分数

Despite challenges with lab data, Lighthouse still provides useful information, especially in narrowing down which parts of your application may be causing issues for your users. For instance:

尽管实验室数据存在上述局限性，Lighthouse 仍能提供有价值的信息，尤其有助于快速定位您的应用中可能影响用户体验的具体环节。例如：

- **Performance** \- If your Core Web Vitals are not in an acceptable range, Lighthouse [points to possible issues](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring/), like linking scripts that may be blocking the main thread for too long. It also displays which exact element is being counted as causing your LCP.

- **性能（Performance）**：如果您的核心网页指标（Core Web Vitals）未达到可接受范围，Lighthouse 将[指出潜在问题](https://developer.chrome.com/docs/lighthouse/performance/performance-scoring/)，例如引入了长时间阻塞主线程的脚本；同时还会明确标出导致最大内容绘制（Largest Contentful Paint, LCP）的具体元素。

- **Accessibility** \- Lighthouse spots [common errors](https://developer.chrome.com/docs/lighthouse/accessibility/scoring) such as unnamed links or form fields without labels. It can also screenshot elements that don’t have a high enough contrast ratio or links that don’t have enough space to tap.

- **无障碍访问（Accessibility）**：Lighthouse 可识别[常见错误](https://developer.chrome.com/docs/lighthouse/accessibility/scoring)，例如未命名的链接或缺少标签（label）的表单字段；它还能对对比度不足的元素、或点击区域过小的链接自动截屏提示。

- **Best Practices** \- This Lighthouse category is a bit of a catch-all for suggestions that  
[improve the security and usability](https://developer.chrome.com/docs/lighthouse/best-practices/doctype) of your applications. Information here will help browsers parse your code more easily and help to prevent some (but not nearly all) common vulnerabilities like XSS.

- **最佳实践（Best Practices）**：此 Lighthouse 类别属于综合性建议集合，涵盖一系列旨在[提升应用安全性与可用性](https://developer.chrome.com/docs/lighthouse/best-practices/doctype)的优化项。其中提供的信息有助于浏览器更高效地解析您的代码，也能防范部分（但远非全部）常见安全漏洞，例如跨站脚本攻击（XSS）。

- **SEO** \- Lighthouse offers advice here about the [technical portion of your SEO](https://developer.chrome.com/docs/lighthouse/seo/meta-description)—the technical ways to help search engines crawl your site. These checks can be very helpful in debugging why your site may not be ranking as you expect, but they’re far from exhaustive in addressing all factors that may affect your app’s SEO.

- **搜索引擎优化（SEO）**：Lighthouse 在此部分提供有关您 SEO 工作中[技术层面](https://developer.chrome.com/docs/lighthouse/seo/meta-description)的建议——即帮助搜索引擎更有效地抓取和索引您网站的技术手段。这些检查对于排查“为何网站排名未达预期”等问题非常有帮助；但它们远不能覆盖所有可能影响您应用 SEO 表现的因素。

### A quicker way to iterate on Core Web Vitals: Vercel Speed Insights

### 迭代 Core Web Vitals 的更快速方法：Vercel Speed Insights

Google’s data is the authoritative source for how your application is ranking in search and performing for your real users. However, as we mentioned above, the data that Google makes available uses a 28-day sliding window.

谷歌的数据是衡量您的应用在搜索结果中的排名以及真实用户使用体验的权威依据。然而，如上文所述，谷歌所提供的数据采用的是 28 天滚动窗口。

This means that if you ship an improvement or a regression it can take up to one month to see the full impact. And then, if you need to ship a fix for a regression, it can take yet another month for Google to pick up the improvement.

这意味着，若您上线了一项性能优化或引入了一个性能退化问题，可能需要长达一个月时间才能观察到其完整影响；而若需针对性能退化发布修复，则谷歌又需约一个月时间才能采集并反映该改进效果。

To maximize your iteration velocity, Vercel created [Speed Insights](https://vercel.com/docs/speed-insights). Since Chromium browsers expose Core Web Vital metrics as users access your site, the Speed Insights package installed on your site accesses these to report your real-time data. Then, you can react quickly, discovering and fixing problems the moment they appear.

为最大化您的迭代速度，Vercel 推出了 [Speed Insights](https://vercel.com/docs/speed-insights)。由于 Chromium 内核浏览器会在用户访问您网站时实时暴露 Core Web Vitals 指标，因此部署在您网站上的 Speed Insights SDK 可直接获取这些指标，并上报实时性能数据。由此，您便能迅速响应，在问题初现之时即刻发现并修复。

![A snapshot of the Speed Insights tab from the project view.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_007.jpg)![A snapshot of the Speed Insights tab from the project view.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_008.jpg)A snapshot of the Speed Insights tab from the project view.

![项目视图中 Speed Insights 标签页的截图。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_007.jpg)![项目视图中 Speed Insights 标签页的截图。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_008.jpg)项目视图中 Speed Insights 标签页的截图。

Just like all Vercel features tied to [unlimited immutable deployments](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud), you can view Speed Insights on a per-deployment or even per-branch basis, allowing you to easily see the effect of each `git push` on application performance.

与所有依托于 [无限次不可变部署](https://vercel.com/blog/the-developer-experience-of-the-frontend-cloud) 的 Vercel 功能一样，Speed Insights 支持按每次部署（per-deployment）甚至按每个分支（per-branch）进行查看，让您轻松掌握每一次 `git push` 对应用性能产生的具体影响。

Unlike Google’s PageSpeed Insights, you can filter data to smaller windows than the past 28 days, allowing you to see the immediate effects of your changes or to measure arbitrary timespans correlated to large codebase changes.

与谷歌的 PageSpeed Insights 不同，Speed Insights 允许您将数据筛选范围缩小至不足 28 天的窗口期，从而即时观测变更带来的影响，或针对大型代码库变更所对应的时间段进行自定义测量。

You can also view individual routes of your application and view data by the 75th percentile of users (Google’s standard) and 90th, 95th, and 99th.

您还可按应用的单个路由（route）分别查看性能数据，并支持以用户分布的第 75 百分位（即谷歌标准）、第 90、95 和 99 百分位进行统计分析。

Furthermore, you can filter results by global region, allowing you to better allocate resources to where your actual users reside.

此外，您还可按全球地域对结果进行筛选，从而更精准地将资源投向真实用户所在区域。

![Geographic map of the P75 score where the color intensity indicates the relative amount of data points per country.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_009.jpg)![Geographic map of the P75 score where the color intensity indicates the relative amount of data points per country.](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_010.jpg)Geographic map of the P75 score where the color intensity indicates the relative amount of data points per country.

![P75 分数的地理分布图，颜色深浅表示各国数据点数量的相对多少。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_009.jpg)![P75 分数的地理分布图，颜色深浅表示各国数据点数量的相对多少。](images/how-core-web-vitals-lighthouse-scores-affect-seo-rankings-vercel/img_010.jpg)P75 分数的地理分布图，颜色深浅表示各国数据点数量的相对多少。

To ensure that the Speed Insights feature can be used despite many different regulatory limitations around the world, we've designed it in such a way that it provides you with information without being tied to, or associated with, any individual visitor or IP address.

为确保 Speed Insights 功能在全球各地纷繁复杂的监管限制下仍可正常使用，我们对其进行了专门设计：它向您提供信息，但不与任何特定访客或 IP 地址绑定或关联。

## Further reading: Optimizing Core Web Vitals

## 延伸阅读：优化核心网页指标（Core Web Vitals）

Now that you have an overview of what Core Web Vitals are, how to measure them, and how they impact your application, you may be wondering, “How do I optimize each metric?”

在了解了核心网页指标（Core Web Vitals）的定义、测量方法及其对您应用的影响之后，您或许会思考：“我该如何优化每一项指标？”

We've written [deep dive into the topic](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking), specific to JavaScript frameworks and Vercel tooling.

我们已撰写了一篇[关于该主题的深度解析文章](https://vercel.com/resources/how-vercel-improves-your-websites-search-engine-ranking)，内容专为 JavaScript 框架及 Vercel 工具链而定制。

We also recommend Google’s technical guides on optimizing individual metrics: [Largest Contentful Paint (LCP)](https://web.dev/articles/optimize-lcp), [Cumulative Layout Shift (CLS)](https://web.dev/articles/optimize-cls), and [Interaction to Next Paint (INP)](https://web.dev/articles/optimize-inp).

我们也推荐 Google 针对各项指标优化提供的技术指南：[最大内容绘制（Largest Contentful Paint, LCP）](https://web.dev/articles/optimize-lcp)、[累积布局偏移（Cumulative Layout Shift, CLS）](https://web.dev/articles/optimize-cls) 和 [交互到下一次绘制（Interaction to Next Paint, INP）](https://web.dev/articles/optimize-inp)。

## Takeaways

## 关键要点

- Improving Core Web Vitals is the most transparent ranking factor in Google Search, since you have direct access to the underlying data used by Google to rank your site.

- 优化核心网页指标是 Google 搜索中透明度最高的排名因素，因为您可以直接访问 Google 用于对您的网站进行排名所依据的底层数据。

- Only Core Web Vitals count for Google’s search ranking. Your Lighthouse score is ignored.

- 仅有核心网页指标（Core Web Vitals）会影响 Google 的搜索排名；您的 Lighthouse 分数将被忽略。

- Google’s data uses a 28-day sliding window. For improving your site speed at a  
[higher iteration velocity](https://vercel.com/blog/iterating-from-design-to-deploy), Vercel’s Speed Insights gets you real-time, easily filterable access to your Core Web Vitals.

- Google 的数据采用 28 天滚动窗口。若希望以[更高的迭代速度](https://vercel.com/blog/iterating-from-design-to-deploy)提升网站性能，Vercel 的 Speed Insights 可为您提供实时、易于筛选的核心网页指标数据。

[**Your metrics, better with Vercel.**  
[**您的指标，借助 Vercel 更进一步。**  

Our team obsesses over performance. We'll help you find opportunities to improve your application's Core Web Vitals.  
我们的团队对性能精益求精。我们将帮助您发现提升应用核心网页指标（Core Web Vitals）的机会。

Vercel.com landing page  
Vercel.com 首页

### A deep dive into optimizing Core Web Vitals  
### 深度解析：优化核心网页指标（Core Web Vitals）

Vercel.com landing page  
Vercel.com 首页

### Composable commerce on Vercel  
### 基于 Vercel 的可组合式电商（Composable Commerce）
&#123;% endraw %}
