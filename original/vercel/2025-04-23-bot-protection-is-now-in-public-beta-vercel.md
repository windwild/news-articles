---
title: "Bot Protection is now in public beta - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/changelog/bot-protection-is-now-in-public-beta"
date: "2025-04-23"
scraped_at: "2026-03-02T09:34:20.739713576+00:00"
language: "en"
translated: false
description: "Vercel's Bot Protection managed ruleset allows users to mitigate unwanted bot activity on their projects in a single click"
---




Apr 23, 2025

![](images/bot-protection-is-now-in-public-beta-vercel/img_001.jpg)![](images/bot-protection-is-now-in-public-beta-vercel/img_002.jpg)

Vercel Web Application Firewall now includes a new [Bot Protection managed ruleset](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset), available in [public beta](https://vercel.com/docs/release-phases#public-beta) for all users.

Bot Protection helps reduce automated traffic from non-browser sources and allows you to respond based on two action choices:

- **Log Only Action:** Logs identified bot traffic in the Firewall tab without blocking requests

- **Challenge Action:** Serves a [browser challenge](https://vercel.com/docs/vercel-firewall/firewall-concepts#challenge) to traffic from non-browser sources. [Verified bots](https://vercel.com/docs/bot-protection#verified-bots) are automatically excluded


To avoid disrupting legitimate automated traffic that's not already covered by Verified Bots, you can configure [custom WAF rules](https://vercel.com/docs/vercel-waf/custom-rules) using the bypass action for specific requests.

We recommend starting with the Log Only action to observe traffic before enabling serving challenges.

To enable the ruleset:

1. In your [project dashboard](https://vercel.com/docs/projects/project-dashboard), navigate to the [Firewall](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) tab and select **Configure**

2. Under **Bot Management**, navigate to **Bot Protection**

3. Select **Log** or **Challenge**

4. Select **Review Changes** and review the changes to be applied

5. Select **Publish** to apply the changes to your production deployment


Bot Protection complements Vercel's existing mitigations, which already block common threats like DDoS attacks, low quality traffic, and spoofed traffic. It adds an extra layer of protection for any automated traffic that is not clearly malicious.

During this public beta period, we’ve set up a [thread](https://community.vercel.com/t/feedback-thread-for-bot-filter-public-beta/9174) on the Vercel Community where you can share your feedback, feature requests, and experiences with Bot Protection.

Learn more about the [Bot Protection managed ruleset](https://vercel.com/docs/vercel-waf/managed-rulesets) and the [Vercel Firewall.](https://vercel.com/docs/vercel-firewall)

Edit: During the beta period, we renamed the Bot Filter managed ruleset to Bot Protection