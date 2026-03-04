---
title: "Update on Spain and LALIGA blocks of the internet - Vercel"
render_with_liquid: false
source: "Vercel Blog"
url: "https://vercel.com/blog/update-on-spain-and-laliga-blocks-of-the-internet"
date: "2025-04-15"
scraped_at: "2026-03-02T09:34:44.843680600+00:00"
language: "en-zh"
translated: true
description: "A Spanish court has empowered LALIGA to block entire IP addresses tied to unauthorized football streams—causing legitimate websites hosted on Vercel to become inaccessible in Spain."
---

render_with_liquid: false
Apr 15, 2025

2025年4月15日

[A Spanish court has granted LALIGA](https://cybernews.com/news/spain-laliga-streaming-piracy-campaign/) the power to block IP addresses associated with unauthorized football streaming—without distinguishing between infringing and non-infringing services. As a result, legitimate, unrelated websites that people depend on are now inaccessible in Spain.

西班牙一家法院已授予西甲联盟（LALIGA）权力，可屏蔽与非法足球直播相关的IP地址——且不区分侵权服务与合法服务。因此，西班牙民众日常依赖的诸多合法、无关网站目前已无法访问。

**April 18 update**: We are working closely with LALIGA to promptly remove illegal streaming content that infringes on LALIGA’s copyrights. IP addresses `66.33.60.129` and `76.76.21.142` are no longer blocked, and no action is required by Vercel customers. Additionally, in the past seven days, Vercel has not received any takedown notices related to LALIGA content. This reflects our continued commitment to a zero-tolerance policy for illegal content on our platform.

**4月18日更新**：我们正与西甲联盟（LALIGA）紧密合作，迅速下架侵犯其版权的非法直播内容。IP地址 `66.33.60.129` 和 `76.76.21.142` 已解除屏蔽，Vercel客户无需采取任何操作。此外，过去七天内，Vercel未收到任何与LALIGA内容相关的下架通知。这再次印证了我们对平台非法内容一贯坚持的“零容忍”政策。

In December 2024, Commercial Court No. 6 of Barcelona authorized LALIGA to require Spanish ISPs, including Movistar, Vodafone, and Orange, to block IP addresses associated with unauthorized football streaming. The court upheld this ruling in March 2025, [reinforcing LALIGA's authority to enforce these blocks](https://www.laliga.com/en-GB/news/commercial-court-no-6-of-barcelona-upholds-the-judgment-issued-in-favour-of-laliga-and-dismisses-the-annulments-filed-by-cloudflare-and-rootedcon?utm_source=chatgpt.com). Recently, enforcement has widened, and Vercel infrastructure is now being affected.

2024年12月，巴塞罗那第六商业法院授权西甲联盟（LALIGA）要求西班牙多家互联网服务提供商（ISP），包括Movistar、Vodafone和Orange，屏蔽与非法足球直播相关的IP地址。2025年3月，该法院维持原判，[进一步确认LALIGA实施此类屏蔽措施的法律权限](https://www.laliga.com/en-GB/news/commercial-court-no-6-of-barcelona-upholds-the-judgment-issued-in-favour-of-laliga-and-dismisses-the-annulments-filed-by-cloudflare-and-rootedcon?utm_source=chatgpt.com)。近期，执法范围进一步扩大，Vercel基础设施亦因此受到波及。

Users in Spain now face indiscriminate internet blocking, with legitimate websites becoming inaccessible due to their association with shared IP addresses.

西班牙用户目前正面临无差别互联网屏蔽——众多合法网站仅因与被屏蔽IP地址共享同一IP而无法访问。

This includes services that have no connection to piracy, highlighting the collateral damage of such broad enforcement actions.

这其中甚至包括与盗版毫无关联的服务，凸显了此类宽泛执法行动所造成的附带损害。

## Indiscriminate blocking: a blanket form of censorship

## 无差别屏蔽：一种“一刀切”式的审查

This isn't a narrowly scoped takedown. LALIGA is a private organization triggering IP-wide blocks that impact critical infrastructure, developers, and businesses—without review, due process, or transparency. These blocks are primarily enforced during LALIGA matchdays, typically on weekends and select weekdays, when live broadcasts occur.

这并非一次精准、有限范围的下架行动。西甲联盟（LALIGA）作为一家私营机构，正在触发针对整个IP地址段的屏蔽，波及关键基础设施、开发者及企业——整个过程未经审查、缺乏正当程序，亦毫无透明度可言。此类屏蔽主要在LALIGA比赛日（通常为周末及部分工作日）进行，即现场直播期间。

ISP-level blocking of individual sites is common. Typically, this is done by inspecting the [Server Name Indication (SNI)](https://en.wikipedia.org/wiki/Server_Name_Indication) header during the TLS handshake. SNI contains the hostname in plaintext before encryption, allowing ISPs to block specific domains while leaving other traffic on the same IP untouched, even while the actual traffic is encrypted.

在ISP层面针对单个网站实施屏蔽是常见做法。通常，这是通过在TLS握手过程中检查[服务器名称指示（SNI）](https://zh.wikipedia.org/wiki/%E6%9C%8D%E5%8A%A1%E5%99%A8%E5%90%8D%E7%A7%B0%E6%8C%87%E7%A4%BA)头部字段来实现的。SNI在加密前以明文形式携带主机名，使ISP得以精准屏蔽特定域名，同时保留同一IP上其他未被屏蔽的流量——即便实际传输数据本身已被加密。

But that’s not what’s happening here. Spanish ISPs are blocking entire IPs, ignoring SNI and making no effort to distinguish between hosts. Any website or service behind a blocked IP is taken offline, regardless of its legitimacy.

但本次事件并非如此。西班牙各ISP正在屏蔽整个IP地址，完全忽略SNI信息，亦未尝试区分同一IP下托管的不同网站或服务。任何位于被屏蔽IP之后的网站或服务均将被迫离线，无论其是否合法。

What started as an anti-piracy measure has become an unaccountable form of internet censorship. There’s no distinction between targeted enforcement and mass collateral damage. IPs are being blocklisted wholesale.

最初作为反盗版措施而推出的手段，如今已演变为一种缺乏问责机制的互联网审查形式。执法行动既无明确目标，也未区分主次，导致大量无辜用户遭受连带影响；IP 地址正被整批列入黑名单。

## What this means for developers on Vercel

## 对 Vercel 平台开发者的实际影响

Spanish ISPs are enforcing a court order tied to LALIGA by blocking entire IP ranges, not specific domains or content. These blocked IPs for users from a subset of ISPs include:

西班牙多家互联网服务提供商（ISP）正在执行一项与西班牙职业足球联赛（LALIGA）相关的法院禁令，其做法是屏蔽整个 IP 地址段，而非针对特定域名或具体内容。受此影响、被部分西班牙 ISP 屏蔽的 IP 地址包括：

- `66.33.60.129`

- `76.76.21.142`


These IPs serve lawful content, used by businesses like Spanish startup [Tinybird](https://www.tinybird.co/), [Hello Magazine](https://www.hellomagazine.com/), and others operating on Vercel, despite no affiliations with piracy in any form. This affects users in Spain, using Spanish ISPs, while users in neighboring countries remain unaffected.

这些 IP 地址承载着完全合法的内容，为西班牙初创公司 [Tinybird](https://www.tinybird.co/)、[Hello Magazine](https://www.hellomagazine.com/) 等众多依托 Vercel 运营的企业提供服务——它们与任何形式的盗版活动均无任何关联。此次屏蔽仅影响使用西班牙本地 ISP 的西班牙境内用户，邻国用户则不受影响。

This issue isn’t isolated to Vercel. Cloudflare, GitHub Pages, and BunnyCDN are also affected.

该问题并非 Vercel 独有；Cloudflare、GitHub Pages 和 BunnyCDN 等平台同样受到波及。

## Where we stand

## 我们的立场

Users shouldn’t be blocked from legitimate websites and apps, and developers shouldn’t lose access to their audience because of a private entity.

用户不应因某家私营机构的主张而被屏蔽访问合法网站和应用；开发者也不应因此失去其目标受众。

Vercel actively monitors and removes illegal content across our platform. We operate a dedicated abuse team that responds promptly to reports submitted via our [abuse form](https://vercel.com/abuse). This team investigates and takes down infringing deployments, including phishing, malware, copyright and trademark violations—anything that violates Vercel's Acceptable Use Policy with the [Terms of Service](https://vercel.com/legal/terms).

Vercel 持续主动监控并清除平台上的非法内容。我们设有专门的滥用内容处理团队，可快速响应用户通过我们的 [滥用内容举报表单](https://vercel.com/abuse) 提交的报告。该团队会及时调查并下线侵权部署，涵盖网络钓鱼、恶意软件、侵犯版权与商标权等一切违反 Vercel《可接受使用政策》及 [《服务条款》](https://vercel.com/legal/terms) 的行为。

We remain committed to providing fast, secure infrastructure for modern web applications. Likewise, we expect enforcement efforts to do the same: targeted, transparent, and technically sound. We are in contact with LALIGA and are collaborating to remove illegal content in accordance with the court order.

我们始终致力于为现代 Web 应用提供快速、安全的基础设施。同样，我们也期望执法行动秉持相同原则：精准、透明且技术严谨。我们已与西甲联盟（LALIGA）取得联系，并正依据法院裁定协同移除非法内容。

We’re exploring mitigation strategies to restore access for Spanish users and continue to advocate for an open and permissionless web. If you are impacted by this, please don’t hesitate to [join the open discussion](https://community.vercel.com/t/ip-address-block-in-spain/8795), contact support, or reach out to your CSM.

我们正在探索缓解措施，以恢复西班牙用户对服务的访问，并持续倡导一个开放、无需许可的 Web。若您因此受到影响，请随时[加入公开讨论](https://community.vercel.com/t/ip-address-block-in-spain/8795)，联系技术支持，或联系您的客户成功经理（CSM）。