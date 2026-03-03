---
title: "Security through design: Creating the improved Firewall experience - Vercel"
source: "Vercel Blog"
url: "https://vercel.com/blog/security-through-design-creating-the-improved-firewall-experience"
date: "2025-11-24"
scraped_at: "2026-03-03T07:10:39.318018174+00:00"
language: "en"
translated: false
description: "Vercel introduces a new Firewall UI for better surfacing of events and alerts while providing deeper information on mitigation activity"
---




Nov 24, 2025

At Vercel, we believe security should be intuitive, not intimidating. The best security tool is the one that's actually used. It should be clear, useful, and never in the way.

But that's not always the norm. Security tooling can often feel like a tradeoff against shipping velocity. When UX is an afterthought, teams leave tools off or in "logging mode" forever, even when risks are high.

That's why we've redesigned the Vercel Firewall experience from the ground up. The new UI helps you see more, do more, and feel confident in your app's resilience to attacks.

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_001.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_002.jpg)

## **Designing for every Vercel user**

The redesign started with listening. Users told us:

- I want to easily see active DDoS events

- I need more information on what the Firewall blocked

- I need a faster way to investigate traffic alerts or spikes


Developers, SREs, and security teams all use the Firewall for maintenance and troubleshooting. They configure rules, monitor traffic, and respond to unusual activity.

The new Firewall UI is designed for everyone using Vercel. It surfaces clear, actionable information, simplifies navigation, and helps teams resolve issues quickly when it matters most.

## **A better way to see and secure your traffic**

The new design brings together visibility, context, and control in one view.

- **A redesigned overview page** provides a unified, high-signal view of Firewall activity

- **New sidebar navigation** offers one click to Overview, Traffic, Rules, and Audit Log

- **Key activity and alert feeds** surface unusual patterns and potential threats

- **Improved inspection tools** make it faster to move from alert to insight


### A new overview for all security events

The [Overview page](https://vercel.com/d?to=%2F%5Bteam%5D%2F%5Bproject%5D%2Ffirewall&title=Firewall+tab) is your high-level control center for the Firewall. It gives you a clear, birds-eye view of your site’s security posture. The traffic chart remains at the top, and we now surface the most important information based on recent activity.

Four tables surface key Firewall activity so you can see the current state and act quickly when needed:

- Alerts shows recently mitigated DDoS attacks

- Rules displays top rule activity by volume

- Events list mitigations taken by Firewall

- Denied IPs show blocked connections by client IP


![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_003.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_004.jpg)

### Comprehensive traffic intelligence

The new Traffic page focuses entirely on understanding activity across your site. You can now drill down into the detection signals that you care about the most, and filter those signals based on specific mitigation actions on the traffic tab. These updates make it easier to spot patterns or anomalies before they become problems.

We now surface dedicated feeds for:

- Top IPs

- Top JA4 digests

- Top AS names

- Top User Agents

- Top Request Paths

- Rules with most activity


![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_005.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_006.jpg)

### Dedicated rules and activity

Firewall Rules now have a dedicated tab on the sidebar. You can see and manage all of your WAF custom rules in this view, including [Bot Protection](https://vercel.com/docs/bot-management#bot-protection-managed-ruleset), [Managed Rulesets](https://vercel.com/docs/vercel-firewall/vercel-waf/managed-rulesets), [IP Blocking](https://vercel.com/docs/vercel-firewall/vercel-waf/ip-blocking), and more. We’ve also moved the Audit Log to a dedicated tab for full visibility into Firewall changes.

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_007.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_008.jpg)

### Faster event inspection

Clicking an alert or event now opens a detailed view directly in the page. You can dive deeper into Firewall activity and investigate suspicious traffic or DDoS attacks without context switching, helping you diagnose issues faster and take action immediately.

![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_009.jpg)![](images/security-through-design-creating-the-improved-firewall-experience-vercel/img_010.jpg)

## **Security designed for you**

Security is usability. When tools are clear and well-designed, teams act faster and stay safer, without sacrificing shipping velocity.

We'd love your feedback. Explore the new Firewall experience today in your [Vercel Dashboard](https://vercel.com/dashboard) and share your thoughts in the [Vercel Community](https://vercel.com/community).