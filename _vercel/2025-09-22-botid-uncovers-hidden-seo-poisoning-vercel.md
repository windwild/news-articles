---
title: "BotID uncovers hidden SEO poisoning - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/botid-uncovers-hidden-seo-poisoning"
date: "2025-09-22"
scraped_at: "2026-03-02T09:28:08.221183469+00:00"
language: "en-zh"
translated: true
description: "A financial institution's suspicious bot traffic turned out to be Google bots crawling SEO-poisoned URLs from years ago. Here's how BotID revealed the real problem."
---
&#123;% raw %}

Sep 22, 2025

2025年9月22日

Your traffic is spiking and you spot suspicious bot activity in your logs. You deploy [BotID](https://vercel.com/botid) expecting to find malicious scrapers, but the results show verified Google bots. Normal crawlers doing their job. But then you notice what they're actually searching for on your site. Queries that have nothing to do with your business. What do you do?

您的流量突然激增，且日志中出现了可疑的机器人活动。您部署了 [BotID](https://vercel.com/botid)，本期望发现恶意爬虫，结果却显示所有请求均来自已验证的 Google 机器人——这些是正常履行职责的搜索引擎爬虫。但随后您注意到：它们实际在您的网站上搜索的内容，与您的业务毫无关联。此时，您该怎么办？

This exact scenario recently played out at one of the largest financial institutions in the world. What they discovered was a years-old SEO attack still generating suspicious traffic patterns.

这一情形最近真实发生于全球最大的金融机构之一。他们发现，这是一场持续数年的 SEO 攻击，至今仍在制造异常的流量模式。

## Malicious-looking search queries

## 看似恶意的搜索查询

The institution's security team was seeing significant bot traffic hitting their deployments with weird and malicious-looking search queries. The volume was concerning and the queries had nothing to do with financial services. They needed to stop this traffic in a reliable way.

该机构的安全团队观察到大量机器人流量正以怪异且看似恶意的搜索查询冲击其线上服务。流量规模令人担忧，且所有查询均与金融服务完全无关。他们亟需一种可靠的方式阻断此类流量。

They implemented [BotID](https://vercel.com/docs/botid)'s invisible CAPTCHA to mitigate the surge in bot traffic and identify the problematic sources before it could impact their systems further.

他们启用了 [BotID](https://vercel.com/docs/botid) 的无感 CAPTCHA 功能，以缓解机器人流量激增，并在进一步影响系统前精准识别问题源头。

## What BotID revealed

## BotID 揭示的结果

The results from BotID were unexpected. The suspicious traffic was not from malicious scrapers or attack infrastructure. Instead, every request originated from [bots.fyi-verified](https://bots.fyi/) Google crawlers, including Googlebot, Google AdsBot, and other legitimate Google services.

BotID 的检测结果出人意料：这些可疑流量并非来自恶意爬虫或攻击基础设施，而是全部源自经 [bots.fyi](https://bots.fyi/) 验证的 Google 爬虫，包括 Googlebot、Google AdsBot 及其他合法的 Google 服务。

```markdown
international shipping from uk to usa royal mail✅【TG：@-----】✅【欧美7折代付】【7折代缴Fedex】

lucky activate sim card✅【TG客服@----】✅【全球SIM定制】【源头批发】
```

```markdown
国际快递英国发美国皇家邮政✅【TG：@-----】✅【欧美七折代付】【七折代缴 FedEx】

幸运激活 SIM 卡✅【TG 客服 @----】✅【全球 SIM 卡定制】【源头批发】
```

JPNTT Docomo电商注册卡TG飞机@----  

JPNTT Docomo 电商注册卡 · Telegram（TG）频道 @----  

42025年全球接码注册TG飞机@----  

2025 年全球接码注册服务 · Telegram（TG）频道 @----  

58位顺子靓号（----.vip）  

58 位顺子靓号（----.vip）  

estes express lines colorado springs reviews✅【TG：@-----】✅【7折付关税】【7折代付快递费】  

Estes Express Lines 科罗拉多斯普林斯服务评价 ✅【Telegram（TG）：@-----】✅【关税享 7 折代付】 【快递费享 7 折代付】  

your香港卡✅【TG客服@----】✅【全球SIM定制】【源头批发】  

您的香港电话卡 ✅【Telegram 客服 @----】✅【支持全球 SIM 卡定制】 【厂家直供、源头批发】  

data sim hong kong✅【TG：@-----】✅【双向Esim】【货源稳定】  

香港数据 SIM 卡 ✅【Telegram（TG）：@-----】✅【支持双向 eSIM】 【货源充足、供应稳定】  

estes express lines colorado springs reviews✅【TG：@-----】✅【7折付关税】【7折代付快递费】  

Estes Express Lines 科罗拉多斯普林斯服务评价 ✅【Telegram（TG）：@-----】✅【关税享 7 折代付】 【快递费享 7 折代付】  

10秦皇岛google外贸推广【TG飞机∶@-----】INS,FACEBOOK代推广】秦皇岛google外贸推广【T  

10｜秦皇岛 Google 外贸推广服务 【Telegram（TG）：@-----】｜支持 Instagram、Facebook 代运营推广｜秦皇岛 Google 外贸推广 【T  

postnl hk✅【TG：@----】✅【7折付关税】【7折代付快递费】  

PostNL 香港服务 ✅【Telegram（TG）：@----】✅【关税享 7 折代付】 【快递费享 7 折代付】  

12💘Google account for sale ❤T:----❤ Main business: foreign trade website construction Google SEO [white hat, bag ranking] Gambling home page does all kinds of extrapolation so  

12｜💘 出售 Google 账号 ❤ Telegram：---- ❤ 主营：外贸网站建设、Google SEO 优化［白帽技术，规避排名风险］｜博彩类首页支持各类外推与流量拓展方案

how to find tracking number on amazon after delivery✅【TG：@----】✅【欧美7折代付】【7折代缴Fedex】

如何在亚马逊包裹签收后查询物流单号 ✅【Telegram：@----】✅【欧美地区代付款享7折优惠】【FedEx运费代缴享7折优惠】

14注册whats注册教程2025TG飞机@----

14 WhatsApp 注册教程（2025版）Telegram 频道 @----

15注册闲鱼注册教程2025TG飞机@----

15 闲鱼账号注册教程（2025版）Telegram 频道 @----

shopee注册接码🔥〖✈️TG：@----〗🔥〖全球直达〗〖源头直码〗

Shopee 账号注册用接码服务 🔥〖✈️Telegram：@----〗🔥〖全球可用〗〖一手直供验证码〗

17东欧接码注册卡预付费短信卡TG✈@----

17 东欧地区接码注册卡｜预付费短信卡 Telegram 频道 @----

18日本OCN Mobile ONE短信卡TG飞机@----

18 日本 OCN Mobile ONE 短信卡 Telegram 频道 @----

19牙买加双向短信🔥〖✈️TG：@----〗🔥〖双向短信〗〖定制接码〗

19 牙买加双向短信服务 🔥〖✈️Telegram：@----〗🔥〖支持收发短信〗〖可定制接码方案〗

20日本Excite Mobile语音卡TG飞机@----

20 日本 Excite Mobile 语音卡 Telegram 频道 @----

21北美接码注册卡0月租短信卡TG✈@----

21 北美地区接码注册卡｜零月租短信卡 Telegram 频道 @----

JPUQ Mobile跨境电商手机卡TG飞机@----

JPUQ Mobile 跨境电商专用手机卡 Telegram 频道 @----

A short list of the queries being searched for

正在搜索的查询词简要列表

Why would verified Google bots be making these strange search queries on a financial institution's website?

为何经过验证的 Google 网络爬虫会在一家金融机构的网站上发起这些异常搜索查询？

## Understanding SEO poisoning

## 深入理解 SEO 投毒攻击

Digging deeper into their site's history revealed the answer. Years ago, before moving to Vercel, their previous infrastructure had been compromised through SEO poisoning.

深入挖掘该网站的历史记录，真相浮出水面：数年前，在迁移到 Vercel 之前，其原有基础设施曾因 SEO 投毒（SEO poisoning）而遭到入侵。

SEO poisoning is an attack where malicious actors manipulate a website to get search engines to index specific content. Attackers create URLs with malicious query parameters that get crawled and indexed by search engines. For example, if your site has search functionality at `/search?q=`, attackers generate thousands of URLs like `/search?q=spam-keyword` and trick search engines into indexing these pages.

SEO 投毒是一种攻击手段，恶意行为者通过篡改网站，诱使搜索引擎对特定内容进行索引。攻击者构造带有恶意查询参数的 URL，使其被搜索引擎爬取并收录。例如，若您的网站在 `/search?q=` 路径下提供搜索功能，攻击者便会生成成千上万个类似 `/search?q=spam-keyword` 的 URL，并欺骗搜索引擎将这些页面纳入索引。

The poisoned pages can then appear in search results, directing traffic to spam or malicious content hosted on legitimate domains.

这些被投毒的页面随后可能出现在搜索结果中，将用户流量导向托管在合法域名上的垃圾信息或恶意内容。

## Legacy indexing persists

## 过期索引持续存在

In this case, Google had indexed thousands of malicious search pages from the compromised site years earlier. Even though the institution had migrated to completely new infrastructure on Vercel, Google's index still contained these poisoned URLs.

本案例中，Google 数年前便已索引了该遭入侵网站生成的数千个恶意搜索页面。尽管该金融机构早已全面迁移至 Vercel 的全新基础设施，Google 的索引中仍残留着这些被投毒的 URL。

Google's bots were systematically attempting to re-crawl these indexed pages, generating the suspicious search queries in their current logs. What appeared to be an active attack was actually Google trying to refresh stale indexed content from a historical compromise.

Google 的爬虫正系统性地尝试重新抓取这些已被索引的页面，从而在其当前日志中生成了可疑的搜索查询。表面看似一次正在进行的主动攻击，实则只是 Google 在尝试更新历史上某次入侵所遗留的过期索引内容。

## A targeted solution

## 针对性解决方案

With BotID providing clear identification of legitimate Google traffic, the team could implement the right approach:

借助 BotID 对合法 Google 流量进行清晰识别，该团队得以采取恰当的应对措施：

1. Update `robots.txt` to disallow crawling of search parameter patterns

1. 更新 `robots.txt`，禁止爬虫抓取含搜索参数的 URL 模式。

2. Submit removal requests through Google Search Console for the poisoned indexed pages

2. 通过 Google 搜索中心（Google Search Console）提交已遭污染的已索引页面的移除请求。

3. Monitor de-indexing progress while allowing legitimate Google crawlers to continue normal operations

3. 在允许合法 Google 爬虫持续正常运行的同时，监控页面去索引（de-indexing）的进展。

Without proper bot identification, they might have spent significant effort trying to block Google's crawlers, which would be both impossible and harmful to their search visibility.

若缺乏准确的机器人识别能力，他们可能耗费大量精力试图屏蔽 Google 爬虫——这不仅不可能实现，还会严重损害其在搜索引擎中的可见性。

## The importance of bot identification

## 机器人识别的重要性

This case demonstrates why bot identification matters just as much as bot blocking. Vercel's verified bot registry powering BotID prevented misidentifying legitimate crawlers while revealing the root cause of suspicious traffic patterns.

本案例说明：机器人识别与机器人拦截同等重要。Vercel 提供的经验证机器人注册表（verified bot registry）驱动 BotID 功能，既避免了将合法爬虫误判为恶意流量，又揭示了可疑流量模式的根本成因。

The institution's problem wasn't current malicious activity but historical technical debt manifesting through search engine behavior.

该机构面临的问题并非当前的恶意活动，而是历史遗留的技术债务，借由搜索引擎行为显现出来。

When you encounter suspicious bot patterns, understanding the traffic source can be more valuable than immediately blocking it. Proper identification reveals whether you're dealing with an active threat or a symptom of deeper issues.

当你发现可疑的机器人流量模式时，厘清其真实来源，往往比立即封禁更有价值。准确识别能帮你判断：所面对的是正在发生的主动威胁，还是更深层次问题的表征。

[**Understand what your bot traffic is actually telling you**\\
\\
Detect and stop advanced bots before they reach your most sensitive routes. Easy to implement, hard to bypass.\\
\\
Get started](https://vercel.com/botid)

[**深入理解你的机器人流量究竟在传递什么信息**  
\\  
在高级机器人抵达你最关键的路由之前，即刻识别并阻断它们。部署简易，难以绕过。  
\\  
立即开始](https://vercel.com/botid)
&#123;% endraw %}
